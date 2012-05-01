Imports System.Data.SqlClient
Public Class frmSemester
    Dim currentRow As Integer

    Private Sub btnExit_Click_1(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnExit.Click
        Me.Close()
    End Sub

    Private Sub btnSave_Click_1(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSave.Click
        On Error GoTo err
        If Savingvalidation() <> 0 Then Exit Sub
        '
        If Val(txtSemesterID.Text) = 0 Then
            objCommand = New SqlClient.SqlCommand("ttm_insert_Semester", objcnn)
            objCommand.CommandType = CommandType.StoredProcedure
            objCommand.Parameters.AddWithValue("@Semestercode", txtSemesterCode.Text.Trim())
            objCommand.Parameters.AddWithValue("@SemesterName", txtSemesterName.Text.Trim())
            objCommand.Parameters.AddWithValue("@LecturePerWeek", Val(txtLecturePerWeek.Text))
            objCommand.ExecuteNonQuery()
            MsgBox("Information saved successfully", MsgBoxStyle.Information, "Cofirmation")
            Call ClearScreen()
            Exit Sub
        Else
            objCommand = New SqlClient.SqlCommand("ttm_update_Semester", objcnn)
            objCommand.CommandType = CommandType.StoredProcedure
            objCommand.Parameters.AddWithValue("@SemesterID", Val(txtSemesterID.Text))
            objCommand.Parameters.AddWithValue("@Semestercode", txtSemesterCode.Text.Trim())
            objCommand.Parameters.AddWithValue("@SemesterName", txtSemesterName.Text.Trim())
            objCommand.Parameters.AddWithValue("@LecturePerWeek", Val(txtLecturePerWeek.Text))
            objCommand.ExecuteNonQuery()
            MsgBox("Information saved successfully", MsgBoxStyle.Information, "Cofirmation")
            Exit Sub
        End If
err:
        MsgBox("Unable to save", MsgBoxStyle.Critical, "Information")
    End Sub

    Private Sub ClearScreen()
        txtSemesterID.Text = ""
        txtSemesterCode.Text = ""
        txtLecturePerWeek.Text = ""
        txtSemesterName.Text = ""
        pnNavigation.Visible = False
        btnSearch.Enabled = True
    End Sub

    Private Sub btnSearch_Click_1(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSearch.Click
        On Error GoTo err
        objDataAdapter = New SqlDataAdapter
        objDataAdapter.SelectCommand = New SqlCommand
        objDataAdapter.SelectCommand.Connection = objcnn
        objDataAdapter.SelectCommand.CommandText = "ttm_search_Semester"
        objDataAdapter.SelectCommand.Parameters.AddWithValue("@Semestercode", txtSemesterCode.Text.Trim())
        objDataAdapter.SelectCommand.Parameters.AddWithValue("@SemesterName", txtSemesterName.Text.Trim())
        objDataAdapter.SelectCommand.Parameters.AddWithValue("@LecturePerWeek", Val(txtLecturePerWeek.Text))
        objDataAdapter.SelectCommand.Parameters.AddWithValue("@SemesterID", 0)
        objDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure
        objDataSet = New DataSet()
        objDataAdapter.Fill(objDataSet, "ttm_search_Semester")
        If objDataSet.Tables("ttm_search_Semester").Rows.Count.ToString() > 0 Then
            currentRow = 0
            showData()
            btnSearch.Enabled = False
        Else
            MsgBox("No record found", MsgBoxStyle.Information, "Search")
        End If
        Exit Sub
err:
        MsgBox("Unable to search", MsgBoxStyle.Critical, "Search")
    End Sub

    Private Sub showData()
        txtSemesterCode.Text = objDataSet.Tables("ttm_search_Semester").Rows(currentRow)("SemesterCode").ToString()
        txtSemesterName.Text = objDataSet.Tables("ttm_search_Semester").Rows(currentRow)("SemesterName").ToString()
        txtLecturePerWeek.Text = objDataSet.Tables("ttm_search_Semester").Rows(currentRow)("LecturePerWeek").ToString()
        txtSemesterID.Text = objDataSet.Tables("ttm_search_Semester").Rows(currentRow)("SemesterID").ToString()
        lblDisplay.Text = (currentRow + 1).ToString() + " of " + objDataSet.Tables("ttm_search_Semester").Rows.Count.ToString()
        If objDataSet.Tables("ttm_search_Semester").Rows.Count.ToString() > 1 Then
            pnNavigation.Visible = True
        Else
            pnNavigation.Visible = False
        End If
    End Sub 'showData

    Private Sub btnFirst_Click_1(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnFirst.Click
        currentRow = 0
        showData()
    End Sub

    Private Sub btnPreviuos_Click_1(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnPreviuos.Click
        If currentRow > 0 Then
            currentRow -= 1
        End If
        showData()
    End Sub

    Private Sub btnNext_Click_1(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnNext.Click
        If currentRow < objDataSet.Tables("ttm_search_Semester").Rows.Count - 1 Then
            currentRow += 1
        End If
        showData()
    End Sub

    Private Sub btnLast_Click_1(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnLast.Click
        currentRow = objDataSet.Tables("ttm_search_Semester").Rows.Count - 1
        showData()
    End Sub

    Private Sub btnDelete_Click_1(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnDelete.Click
        On Error GoTo err
        objCommand = New SqlClient.SqlCommand("ttm_delete_Semester", objcnn)
        objCommand.CommandType = CommandType.StoredProcedure
        objCommand.Parameters.AddWithValue("@SemesterID", Val(txtSemesterID.Text))
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
        If txtSemesterCode.Text.Trim() = "" Then
            MsgBox("Please provide semester code", MsgBoxStyle.Information, "Validation")
            txtSemesterCode.Focus()
            Savingvalidation = 1
            Exit Function
        End If
        '
        If txtSemesterName.Text.Trim() = "" Then
            MsgBox("Please provide semester name", MsgBoxStyle.Information, "Validation")
            txtSemesterName.Focus()
            Savingvalidation = 1
            Exit Function
        End If
        '
        If IsNumeric(txtLecturePerWeek.Text) = False Then
            MsgBox("Please provide lecture per week in number", MsgBoxStyle.Information, "Validation")
            txtLecturePerWeek.Focus()
            Savingvalidation = 1
            Exit Function
        End If
        '
        If Val(txtLecturePerWeek.Text) = 0 Then
            MsgBox("Please provide lecture per week", MsgBoxStyle.Information, "Validation")
            txtLecturePerWeek.Focus()
            Savingvalidation = 1
            Exit Function
        End If
        '
        'If Val(txtLecturePerWeek.Text) Mod 5 <> 0 Then
        '    MsgBox("Please provide correct value for lecture per week", MsgBoxStyle.Information, "Validation")
        '    txtLecturePerWeek.Focus()
        '    Savingvalidation = 1
        '    Exit Function
        'End If
        ''
    End Function

    Private Sub GroupBox1_Enter(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles GroupBox1.Enter

    End Sub
End Class
