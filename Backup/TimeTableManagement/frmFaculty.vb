Imports System.Data.SqlClient
Public Class frmFaculty
    Dim currentRow As Integer

    Private Sub btnExit_Click_1(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnExit.Click
        Me.Close()
    End Sub

    Private Sub frmFaculty_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Call FillCombo(cmbQualification, "Select 0 AS QualificationID, '' AS Qualification union Select QualificationID, Qualification from TTM_Auto_Qualification order by QualificationID", enumComboFill.CF_QUALIFICATION, enumComboFillType.CFT_BOUNDCODE)
    End Sub

    Private Sub btnSave_Click_1(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSave.Click
        On Error GoTo err
        '
        If Savingvalidation() <> 0 Then Exit Sub
        '
        If Val(txtFacultyID.Text) = 0 Then
            objCommand = New SqlClient.SqlCommand("ttm_insert_FacultyInformation", objcnn)
            objCommand.CommandType = CommandType.StoredProcedure
            objCommand.Parameters.AddWithValue("@Facultycode", txtFacultyCode.Text.Trim())
            objCommand.Parameters.AddWithValue("@FacultyName", txtFacultyName.Text.Trim())
            objCommand.Parameters.AddWithValue("@Age", Val(txtAge.Text))
            objCommand.Parameters.AddWithValue("@Qualification", IIf(cmbQualification.SelectedValue = Nothing, 0, cmbQualification.SelectedValue))
            objCommand.Parameters.AddWithValue("@Contactinformation", Val(txtContactInformation.Text))
            objCommand.Parameters.AddWithValue("@username", txtUserName.Text.Trim())
            objCommand.Parameters.AddWithValue("@Password", txtPassword.Text.Trim())
            objCommand.Parameters.AddWithValue("@WorkExperience", Val(txtWorkExperience.Text))
            objCommand.ExecuteNonQuery()
            MsgBox("Information saved successfully", MsgBoxStyle.Information, "Cofirmation")
            Call ClearScreen()
            Exit Sub
        Else
            objCommand = New SqlClient.SqlCommand("ttm_update_FacultyInformation", objcnn)
            objCommand.CommandType = CommandType.StoredProcedure
            objCommand.Parameters.AddWithValue("@FacultyID", Val(txtFacultyID.Text))
            objCommand.Parameters.AddWithValue("@Facultycode", txtFacultyCode.Text.Trim())
            objCommand.Parameters.AddWithValue("@FacultyName", txtFacultyName.Text.Trim())
            objCommand.Parameters.AddWithValue("@Age", Val(txtAge.Text))
            objCommand.Parameters.AddWithValue("@Qualification", IIf(cmbQualification.SelectedValue = Nothing, 0, cmbQualification.SelectedValue))
            objCommand.Parameters.AddWithValue("@Contactinformation", Val(txtContactInformation.Text))
            objCommand.Parameters.AddWithValue("@username", txtUserName.Text.Trim())
            objCommand.Parameters.AddWithValue("@Password", txtPassword.Text.Trim())
            objCommand.Parameters.AddWithValue("@WorkExperience", Val(txtWorkExperience.Text))
            objCommand.ExecuteNonQuery()
            MsgBox("Information saved successfully", MsgBoxStyle.Information, "Cofirmation")
            Exit Sub
        End If
err:
        MsgBox("Unable to save", MsgBoxStyle.Critical, "Information")
    End Sub

    Private Sub ClearScreen()
        txtFacultyID.Text = ""
        txtFacultyCode.Text = ""
        txtAge.Text = ""
        txtFacultyName.Text = ""
        txtUserName.Text = ""
        txtPassword.Text = ""
        cmbQualification.SelectedValue = 0
        txtWorkExperience.Text = ""
        txtContactInformation.Text = ""
        pnNavigation.Visible = False
        btnSearch.Enabled = True
    End Sub

    Private Sub btnSearch_Click_1(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSearch.Click
        On Error GoTo err
        objDataAdapter = New SqlDataAdapter
        objDataAdapter.SelectCommand = New SqlCommand
        objDataAdapter.SelectCommand.Connection = objcnn
        objDataAdapter.SelectCommand.CommandText = "ttm_search_FacultyInformation"
        objDataAdapter.SelectCommand.Parameters.AddWithValue("@Facultycode", txtFacultyCode.Text.ToString.Trim())
        objDataAdapter.SelectCommand.Parameters.AddWithValue("@FacultyName", txtFacultyName.Text.ToString.Trim())
        objDataAdapter.SelectCommand.Parameters.AddWithValue("@Age", Val(txtAge.Text))
        objDataAdapter.SelectCommand.Parameters.AddWithValue("@Qualification", IIf(cmbQualification.SelectedValue = Nothing, 0, cmbQualification.SelectedValue))
        objDataAdapter.SelectCommand.Parameters.AddWithValue("@Contactinformation", Val(txtContactInformation.Text))
        objDataAdapter.SelectCommand.Parameters.AddWithValue("@WorkExperience", Val(txtWorkExperience.Text))
        objDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure
        objDataSet = New DataSet()
        objDataAdapter.Fill(objDataSet, "ttm_search_FacultyInformation")
        If objDataSet.Tables("ttm_search_FacultyInformation").Rows.Count.ToString() > 0 Then
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
        txtFacultyID.Text = objDataSet.Tables("ttm_search_FacultyInformation").Rows(currentRow)("FacultyID").ToString()
        txtFacultyCode.Text = objDataSet.Tables("ttm_search_FacultyInformation").Rows(currentRow)("FacultyCode").ToString()
        txtFacultyName.Text = objDataSet.Tables("ttm_search_FacultyInformation").Rows(currentRow)("FacultyName").ToString()
        cmbQualification.SelectedValue = objDataSet.Tables("ttm_search_FacultyInformation").Rows(currentRow)("Qualification").ToString()
        txtAge.Text = objDataSet.Tables("ttm_search_FacultyInformation").Rows(currentRow)("Age").ToString()
        txtContactInformation.Text = objDataSet.Tables("ttm_search_FacultyInformation").Rows(currentRow)("Contactinformation").ToString()
        txtUserName.Text = objDataSet.Tables("ttm_search_FacultyInformation").Rows(currentRow)("Username").ToString()
        txtPassword.Text = objDataSet.Tables("ttm_search_FacultyInformation").Rows(currentRow)("Password").ToString()
        txtWorkExperience.Text = objDataSet.Tables("ttm_search_FacultyInformation").Rows(currentRow)("WorkExperience").ToString()
        lblDisplay.Text = "Rec: " + (currentRow + 1).ToString() + " of " + objDataSet.Tables("ttm_search_FacultyInformation").Rows.Count.ToString()
        If objDataSet.Tables("ttm_search_FacultyInformation").Rows.Count.ToString() > 1 Then
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
        If currentRow < objDataSet.Tables("ttm_search_FacultyInformation").Rows.Count - 1 Then
            currentRow += 1
        End If
        showData()
    End Sub

    Private Sub btnLast_Click_1(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnLast.Click
        currentRow = objDataSet.Tables("ttm_search_FacultyInformation").Rows.Count - 1
        showData()
    End Sub

    Private Sub btnDelete_Click_1(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnDelete.Click
        On Error GoTo err
        objCommand = New SqlClient.SqlCommand("ttm_delete_FacultyInformation", objcnn)
        objCommand.CommandType = CommandType.StoredProcedure
        objCommand.Parameters.AddWithValue("@FacultyID", Val(txtFacultyID.Text))
        objCommand.ExecuteNonQuery()
        MsgBox("Information deleted successfully", MsgBoxStyle.Information, "Cofirmation")
        ClearScreen()
        Exit Sub
err:
        MsgBox("Unable to delete", MsgBoxStyle.Critical, "Information")
    End Sub

    Private Sub btnClear_Click_1(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnClear.Click
        Call ClearScreen()
    End Sub

    Private Function Savingvalidation() As Long
        Savingvalidation = 0
        If txtFacultyCode.Text.Trim() = "" Then
            MsgBox("Please provide faculty code", MsgBoxStyle.Information, "Validation")
            txtFacultyCode.Focus()
            Savingvalidation = 1
            Exit Function
        End If
        '
        If txtFacultyName.Text.Trim() = "" Then
            MsgBox("Please provide faculty name", MsgBoxStyle.Information, "Validation")
            txtFacultyName.Focus()
            Savingvalidation = 1
            Exit Function
        End If
        '
        If cmbQualification.SelectedValue = 0 Then
            MsgBox("Please provide qualification", MsgBoxStyle.Information, "Validation")
            cmbQualification.Focus()
            Savingvalidation = 1
            Exit Function
        End If
        '
        If IsNumeric(txtAge.Text) = False Then
            MsgBox("Please provide age in number", MsgBoxStyle.Information, "Validation")
            txtAge.Focus()
            Savingvalidation = 1
            Exit Function
        End If
        '
        If Val(txtAge.Text) = 0 Then
            MsgBox("Please provide age", MsgBoxStyle.Information, "Validation")
            txtAge.Focus()
            Savingvalidation = 1
            Exit Function
        End If
        '
        If IsNumeric(txtWorkExperience.Text) = False Then
            MsgBox("Please provide work experience in number", MsgBoxStyle.Information, "Validation")
            txtWorkExperience.Focus()
            Savingvalidation = 1
            Exit Function
        End If
        '
        If Val(txtWorkExperience.Text) = 0 Then
            MsgBox("Please provide work experience", MsgBoxStyle.Information, "Validation")
            txtWorkExperience.Focus()
            Savingvalidation = 1
            Exit Function
        End If
        '
        If (txtContactInformation.Text) = False Then
            MsgBox("Please provide contact information in number", MsgBoxStyle.Information, "Validation")
            txtContactInformation.Focus()
            Savingvalidation = 1
            Exit Function
        End If
        '
        If Val(txtContactInformation.Text) = 0 Then
            MsgBox("Please provide contact information", MsgBoxStyle.Information, "Validation")
            txtContactInformation.Focus()
            Savingvalidation = 1
            Exit Function
        End If
        '
        If txtUserName.Text.Trim = "" Then
            MsgBox("Please provide user name", MsgBoxStyle.Information, "Validation")
            txtUserName.Focus()
            Savingvalidation = 1
            Exit Function
        End If
        '
        If txtPassword.Text.Trim = "" Then
            MsgBox("Please provide password", MsgBoxStyle.Information, "Validation")
            txtPassword.Focus()
            Savingvalidation = 1
            Exit Function
        End If
        '
    End Function

End Class