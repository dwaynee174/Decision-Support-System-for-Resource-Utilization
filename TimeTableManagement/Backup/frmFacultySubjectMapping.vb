Imports System.Data.SqlClient

Public Class frmFacultySubjectMapping
    Dim currentRow As Integer

    Private Sub btnExit_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnExit.Click
        Me.Close()
    End Sub

    Private Sub ClearScreen()
        cmbFaculty.SelectedValue = 0
        cmbSemester.SelectedValue = 0
        lstMappedSubject.Items.Clear()
        lstUnmappedSubject.Items.Clear()
    End Sub

    Private Sub showData()
        cmbSemester.SelectedValue = objDataSet.Tables("ttm_search_Subject").Rows(currentRow)("SemesterID").ToString()
        lblDisplay.Text = "Record " + (currentRow + 1).ToString() + " of " + objDataSet.Tables("ttm_search_Subject").Rows.Count.ToString()
        If objDataSet.Tables("ttm_search_Subject").Rows.Count.ToString() > 1 Then
            pnNavigation.Visible = True
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

    Private Sub btnSave_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSave.Click
        Dim lngCount As Integer
        'On Error GoTo err
        Do Until lngCount = lstMappedSubject.Items.Count()
            objCommand = New SqlClient.SqlCommand("ttm_insert_facultysubjectmapping", objcnn)
            objCommand.CommandType = CommandType.StoredProcedure
            objCommand.Parameters.AddWithValue("@SemesterID", cmbSemester.SelectedValue)
            objCommand.Parameters.AddWithValue("@FacultyID", cmbFaculty.SelectedValue)
            objCommand.Parameters.AddWithValue("@Subjectname", lstMappedSubject.Items(lngCount))
            objCommand.ExecuteNonQuery()
            lngCount = lngCount + 1
        Loop
        MsgBox("Information saved successfully", MsgBoxStyle.Information, "Cofirmation")
        Call ClearScreen()
        Exit Sub
        'err:
        '        MsgBox("Unable to save", MsgBoxStyle.Critical, "Information")
    End Sub
    Private Sub frmFacultySubjectMapping_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Call FillCombo(cmbSemester, "select 0 as SemesterID, '' AS SemesterName union Select SemesterID, SemesterName from TTM_Semester order by SemesterID", enumComboFill.CF_SEMESTER, enumComboFillType.CFT_BOUNDCODE)
        Call FillCombo(cmbFaculty, "Select 0 as FacultyID, '' as FacultyName union Select FacultyID, FacultyName from TTM_FacultyInformation order by FacultyID", enumComboFill.CF_FACULTY, enumComboFillType.CFT_BOUNDCODE)
        ClearScreen()
    End Sub

    Private Sub btnAdd_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnAdd.Click
        On Error GoTo err
        If lstUnmappedSubject.SelectedIndex >= 0 Then
            lstMappedSubject.Items.Add(lstUnmappedSubject.SelectedItem)
            Call addItemToDatabase()
        End If
        Exit Sub
err:
        Resume Next
    End Sub

    Private Sub btnRemove_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnRemove.Click
        On Error GoTo err
        If lstMappedSubject.SelectedIndex >= 0 Then
            deleteItemFromDatabase()
            lstMappedSubject.Items.RemoveAt(lstMappedSubject.SelectedIndex)
        End If
        Exit Sub
err:
        Resume Next
    End Sub

    Private Sub cmbSemester_Validated(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmbSemester.Validated
        getUnmappedSubject()
        getMappedSubject()
    End Sub
    Private Sub addItemToDatabase()
        objCommand = New SqlClient.SqlCommand("ttm_insert_facultysubjectmapping", objcnn)
        objCommand.CommandType = CommandType.StoredProcedure
        objCommand.Parameters.AddWithValue("@SemesterID", cmbSemester.SelectedValue)
        objCommand.Parameters.AddWithValue("@FacultyID", cmbFaculty.SelectedValue)
        objCommand.Parameters.AddWithValue("@Subjectname", lstUnmappedSubject.SelectedItem)
        objCommand.ExecuteNonQuery()
        getUnmappedSubject()
    End Sub
    Private Sub deleteItemFromDatabase()
        objCommand = New SqlClient.SqlCommand("ttm_delete_facultysubjectmapping", objcnn)
        objCommand.CommandType = CommandType.StoredProcedure
        objCommand.Parameters.AddWithValue("@SemesterID", cmbSemester.SelectedValue)
        objCommand.Parameters.AddWithValue("@FacultyID", cmbFaculty.SelectedValue)
        objCommand.Parameters.AddWithValue("@Subjectname", lstMappedSubject.SelectedItem)
        objCommand.ExecuteNonQuery()
        getUnmappedSubject()
    End Sub
    Private Sub getUnmappedSubject()
        objDataSet = New DataSet()
        objDataAdapter = New SqlDataAdapter("usp_get_subject", objcnn)
        objDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure
        objDataAdapter.SelectCommand.Parameters.AddWithValue("@Semesterid", Val(cmbSemester.SelectedValue))
        objDataAdapter.SelectCommand.Parameters.AddWithValue("@FacultyID", Val(cmbFaculty.SelectedValue))
        objDataAdapter.SelectCommand.Parameters.AddWithValue("@IsmappedSubjects", False)
        objDataAdapter.Fill(objDataSet, "usp_get_subject")
        lstUnmappedSubject.Items.Clear()
        'lstUnmappedSubject.DataSource = objDataSet.Tables(0)

        For Each udr As DataRow In objDataSet.Tables(0).Rows()
            lstUnmappedSubject.Items.Add(udr.Item(0))
        Next
    End Sub
    Private Sub getMappedSubject()
        objDataSet = New DataSet()
        objDataAdapter = New SqlDataAdapter("usp_get_subject", objcnn)
        objDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure
        objDataAdapter.SelectCommand.Parameters.AddWithValue("@Semesterid", Val(cmbSemester.SelectedValue))
        objDataAdapter.SelectCommand.Parameters.AddWithValue("@FacultyID", Val(cmbFaculty.SelectedValue))
        objDataAdapter.SelectCommand.Parameters.AddWithValue("@IsmappedSubjects", True)
        objDataAdapter.Fill(objDataSet, "usp_get_subject")
        lstMappedSubject.Items.Clear()
        'lstMappedSubject.DataSource = objDataSet.Tables(0)

        For Each udr As DataRow In objDataSet.Tables(0).Rows()
            lstMappedSubject.Items.Add(udr.Item(0))
        Next
    End Sub
    Private Sub listfillcode()
        'For Each udr As DataRow In objDataSet.Tables(0).Rows()
        '    lstUnmappedSubject.Items.Add(udr.Item(0))
        '    lstUnmappedSubject.ValueMember = udr.Item(1)
        '    lstUnmappedSubject.DisplayMember = udr.Item(0)
        'Next

        'lstUnmappedSubject.DataSource = objDataSet.Tables(0)
        'lstUnmappedSubject.DisplayMember = "Subjectname"
        'lstUnmappedSubject.ValueMember = "Subjectid"


        'objCommand = New SqlCommand("usp_get_subject", objcnn)
        'objCommand.CommandType = CommandType.StoredProcedure
        'objCommand.Parameters.AddWithValue("@Semesterid", Val(cmbSemester.SelectedValue))
        'objCommand.Parameters.AddWithValue("@FacultyID", Val(cmbFaculty.SelectedValue))
        'objCommand.Parameters.AddWithValue("@IsmappedSubjects", False)
        'If objSqlDataReader.IsClosed = False Then objSqlDataReader.Close()

        'objSqlDataReader = objCommand.ExecuteReader
        'If objSqlDataReader.HasRows Then
        '    'Do While objSqlDataReader.Read()
        '    'lstUnmappedSubject.Items.Add(objSqlDataReader(0).ToString())
        '    lstUnmappedSubject.DisplayMember() = objSqlDataReader.GetValues(
        '    lstUnmappedSubject.ValueMember() = objSqlDataReader.Item("subjectid")
        'End If
        ''Loop
        ''
        ''For mapped
        'objCommand = New SqlCommand("usp_get_subject", objcnn)
        'objCommand.CommandType = CommandType.StoredProcedure
        'objCommand.Parameters.AddWithValue("@Semesterid", Val(cmbSemester.SelectedValue))
        'objCommand.Parameters.AddWithValue("@FacultyID", Val(cmbFaculty.SelectedValue))
        'objCommand.Parameters.AddWithValue("@IsmappedSubjects", True)
        'If objSqlDataReader.IsClosed = False Then objSqlDataReader.Close()

        'objSqlDataReader = objCommand.ExecuteReader
        'Do While objSqlDataReader.Read()
        '    lstMappedSubject.Items.Add(objSqlDataReader(0).ToString())
        'Loop
    End Sub

    Private Sub cmbFaculty_Validated(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmbFaculty.Validated
        getUnmappedSubject()
        getMappedSubject()
    End Sub

    Private Sub btnClear_Click_1(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnClear.Click
        ClearScreen()
    End Sub

End Class