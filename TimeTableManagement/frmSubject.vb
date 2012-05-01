Imports System.Data.SqlClient
Public Class frmSubject
    Dim currentRow As Integer

    Private Sub btnExit_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnExit.Click
        Me.Close()
    End Sub

    Private Sub frmSubject_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Call FillCombo(cmbSemester, "Select 0 AS SemesterID, '' as SemesterName Union Select SemesterID, SemesterName from TTM_Semester order by SemesterID", enumComboFill.CF_SEMESTER, enumComboFillType.CFT_BOUNDCODE)
    End Sub

    Private Sub btnSave_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSave.Click
        On Error GoTo err
        If Savingvalidation() <> 0 Then Exit Sub
        '
        If Val(txtSubjectID.Text) = 0 Then
            objCommand = New SqlClient.SqlCommand("ttm_insert_subject", objcnn)
            objCommand.CommandType = CommandType.StoredProcedure
            objCommand.Parameters.AddWithValue("@subjectcode", txtSubjectCode.Text.Trim())
            objCommand.Parameters.AddWithValue("@SubjectName", txtSubjectName.Text.Trim())
            objCommand.Parameters.AddWithValue("@SemesterID", cmbSemester.SelectedValue)
            objCommand.Parameters.AddWithValue("@marks", Val(txtMarks.Text))
            objCommand.ExecuteNonQuery()
            MsgBox("Information saved successfully", MsgBoxStyle.Information, "Cofirmation")
            Call ClearScreen()
            Exit Sub
        Else
            objCommand = New SqlClient.SqlCommand("ttm_update_subject", objcnn)
            objCommand.CommandType = CommandType.StoredProcedure
            objCommand.Parameters.AddWithValue("@subjectID", Val(txtSubjectID.Text))
            objCommand.Parameters.AddWithValue("@subjectcode", txtSubjectCode.Text.Trim())
            objCommand.Parameters.AddWithValue("@SubjectName", txtSubjectName.Text.Trim())
            objCommand.Parameters.AddWithValue("@SemesterID", cmbSemester.SelectedValue)
            objCommand.Parameters.AddWithValue("@marks", Val(txtMarks.Text))
            objCommand.ExecuteNonQuery()
            MsgBox("Information saved successfully", MsgBoxStyle.Information, "Cofirmation")
            Exit Sub
        End If
err:
        MsgBox("Unable to save", MsgBoxStyle.Critical, "Information")
    End Sub

    Private Sub ClearScreen()
        cmbSemester.SelectedValue = 0
        txtSubjectCode.Text = ""
        txtMarks.Text = ""
        txtSubjectName.Text = ""
        pnNavigation.Visible = False
        txtSubjectID.Text = ""
        btnSearch.Enabled = True
    End Sub

    Private Sub btnSearch_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSearch.Click
        On Error GoTo err
        'Dim sqlStr As String
        '' '' ''objCommand = New SqlCommand("Select * from ttm_subject", objcnn)
        '' '' ''objSqlDataReader = objCommand.ExecuteReader()
        '' '' ''objSqlDataReader.NextResult()
        '' '' ''While objSqlDataReader.Read()
        '' '' ''    txtSubjectCode.Text = objSqlDataReader(1).ToString()
        '' '' ''    txtSubjectName.Text = objSqlDataReader(2).ToString()
        '' '' ''    cmbSemester.Text = objSqlDataReader(3).ToString()
        '' '' ''    txtMarks.Text = objSqlDataReader(4).ToString()
        '' '' ''End While
        '' '' ''objSqlDataReader.Close()
        'objCommand = New SqlCommand("ttm_search_subject", objcnn)
        'objCommand.Parameters.Add("@subjectcode", txtSubjectCode.Text.Trim())
        'objCommand.Parameters.Add("@SubjectName", txtSubjectName.Text)
        'objCommand.Parameters.Add("@SemesterID", cmbSemester.SelectedValue)
        'objCommand.Parameters.Add("@marks", txtMarks.Text)
        'objCommand.ExecuteNonQuery()
        ' '' '' '' '' '' '' '' ''objDataSet = New DataSet()
        ' '' '' '' '' '' '' '' ''sqlStr = "Select * from ttm_subject "
        ' '' '' '' '' '' '' '' ''objDataAdapter = New SqlDataAdapter(sqlStr, objcnn)
        ' '' '' '' '' '' '' '' ''objDataAdapter.SelectCommand.CommandText = sqlStr
        '' '' '' '' '' '' '' '' ''oleDbCommandBuilder1 = New OleDbCommandBuilder(oleDbDataAdapter1)
        ' '' '' '' '' '' '' '' ''objDataAdapter.Fill(objDataSet, "ttm_Subject")
        ' '' '' '' '' '' '' '' ''currentRow = 0
        ' '' '' '' '' '' '' '' ''showData()
        objDataAdapter = New SqlDataAdapter
        objDataAdapter.SelectCommand = New SqlCommand
        objDataAdapter.SelectCommand.Connection = objcnn
        objDataAdapter.SelectCommand.CommandText = "ttm_search_subject"
        objDataAdapter.SelectCommand.Parameters.AddWithValue("@subjectcode", txtSubjectCode.Text.Trim())
        objDataAdapter.SelectCommand.Parameters.AddWithValue("@SubjectName", txtSubjectName.Text.Trim())
        objDataAdapter.SelectCommand.Parameters.AddWithValue("@SemesterID", cmbSemester.SelectedValue)
        objDataAdapter.SelectCommand.Parameters.AddWithValue("@marks", Val(txtMarks.Text))
        objDataAdapter.SelectCommand.Parameters.AddWithValue("@SubjectID", 0)
        objDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure
        objDataSet = New DataSet()
        objDataAdapter.Fill(objDataSet, "ttm_search_Subject")
        If objDataSet.Tables("ttm_search_Subject").Rows.Count.ToString() > 0 Then
            currentRow = 0
            showData()
            btnSearch.Enabled = False
        Else
            MsgBox("No record fount", MsgBoxStyle.Critical, "Search")
        End If

        Exit Sub
err:
        MsgBox("Unable to search", MsgBoxStyle.Critical, "Search")
    End Sub

    Private Sub showData()
        txtSubjectCode.Text = objDataSet.Tables("ttm_search_Subject").Rows(currentRow)("SubjectCode").ToString()
        txtSubjectName.Text = objDataSet.Tables("ttm_search_Subject").Rows(currentRow)("SubjectName").ToString()
        cmbSemester.SelectedValue = objDataSet.Tables("ttm_search_Subject").Rows(currentRow)("SemesterID")
        txtMarks.Text = objDataSet.Tables("ttm_search_Subject").Rows(currentRow)("Marks").ToString()
        txtSubjectID.Text = objDataSet.Tables("ttm_search_Subject").Rows(currentRow)("SubjectID").ToString()
        lblDisplay.Text = (currentRow + 1).ToString() + " of " + objDataSet.Tables("ttm_search_Subject").Rows.Count.ToString()
        If objDataSet.Tables("ttm_search_Subject").Rows.Count.ToString() > 1 Then
            pnNavigation.Visible = True
        Else
            pnNavigation.Visible = False
        End If

    End Sub 'showData

    Private Sub btnFirst_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnFirst.Click
        currentRow = 0
        showData()
    End Sub

    Private Sub btnPreviuos_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnPreviuos.Click
        If currentRow > 0 Then
            currentRow -= 1
        End If
        showData()
    End Sub

    Private Sub btnNext_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnNext.Click
        If currentRow < objDataSet.Tables("ttm_search_Subject").Rows.Count - 1 Then
            currentRow += 1
        End If
        showData()
    End Sub

    Private Sub btnLast_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnLast.Click
        currentRow = objDataSet.Tables("ttm_search_Subject").Rows.Count - 1
        showData()
    End Sub

    Private Sub btnDelete_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnDelete.Click
        On Error GoTo err
        objCommand = New SqlClient.SqlCommand("ttm_delete_subject", objcnn)
        objCommand.CommandType = CommandType.StoredProcedure
        objCommand.Parameters.AddWithValue("@subjectID", Val(txtSubjectID.Text))
        objCommand.ExecuteNonQuery()
        MsgBox("Information deleted successfully", MsgBoxStyle.Information, "Cofirmation")
        ClearScreen()
        Exit Sub
err:
        MsgBox("Unable to delete", MsgBoxStyle.Critical, "Information")
    End Sub

    Private Sub btnClear_Click_1(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnClear.Click
        ClearScreen()
    End Sub

    Private Function Savingvalidation() As Long
        Savingvalidation = 0
        If txtSubjectCode.Text.Trim() = "" Then
            MsgBox("Please provide subject code", MsgBoxStyle.Information, "Validation")
            txtSubjectCode.Focus()
            Savingvalidation = 1
            Exit Function
        End If
        '
        If txtSubjectName.Text.Trim() = "" Then
            MsgBox("Please provide subject name", MsgBoxStyle.Information, "Validation")
            txtSubjectName.Focus()
            Savingvalidation = 1
            Exit Function
        End If
        '
        If cmbSemester.SelectedValue = 0 Then
            MsgBox("Please provide semester", MsgBoxStyle.Information, "Validation")
            cmbSemester.Focus()
            Savingvalidation = 1
            Exit Function
        End If
        '
        If IsNumeric(txtMarks.Text) = False Then
            MsgBox("Please provide marks in number", MsgBoxStyle.Information, "Validation")
            txtMarks.Focus()
            Savingvalidation = 1
            Exit Function
        End If
        '
    End Function
End Class
