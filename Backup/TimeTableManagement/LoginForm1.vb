Imports System.Windows.Forms
Imports System.Data.SqlClient
Public Class LoginForm1
    Dim currentRow As Long
    ' TODO: Insert code to perform custom authentication using the provided username and password 
    ' (See http://go.microsoft.com/fwlink/?LinkId=35339).  
    ' The custom principal can then be attached to the current thread's principal as follows: 
    '     My.User.CurrentPrincipal = CustomPrincipal
    ' where CustomPrincipal is the IPrincipal implementation used to perform authentication. 
    ' Subsequently, My.User will return identity information encapsulated in the CustomPrincipal object
    ' such as the username, display name, etc.

    Private Sub OK_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles OK.Click
        Dim logincorrect As Boolean
        objDataAdapter = New SqlDataAdapter
        objDataAdapter.SelectCommand = New SqlCommand
        objDataAdapter.SelectCommand.Connection = objcnn
        objDataAdapter.SelectCommand.CommandText = "getlogincorrect"
        objDataAdapter.SelectCommand.Parameters.AddWithValue("@username", UsernameTextBox.Text.Trim)
        objDataAdapter.SelectCommand.Parameters.AddWithValue("@password", PasswordTextBox.Text.Trim)
        objDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure
        objDataSet = New DataSet()
        objDataAdapter.Fill(objDataSet, "getlogincorrect")
        currentRow = 0
        logincorrect = objDataSet.Tables("getlogincorrect").Rows(currentRow)("correctlogin").ToString()

        ''
        ''

        objDataAdapter.SelectCommand = New SqlCommand
        objDataAdapter.SelectCommand.Connection = objcnn
        objDataAdapter.SelectCommand.CommandText = "getfacultylogin"
        objDataAdapter.SelectCommand.Parameters.AddWithValue("@username", UsernameTextBox.Text.Trim)
        objDataAdapter.SelectCommand.Parameters.AddWithValue("@password", PasswordTextBox.Text.Trim)
        objDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure
        objDataSet = New DataSet()
        objDataAdapter.Fill(objDataSet, "getfacultylogin")
        currentRow = 0
        loginwithfaculty = objDataSet.Tables("getfacultylogin").Rows(currentRow)("loginwithfaculty").ToString()
        ''
        ''
        If logincorrect Then
            Me.Hide()
            MDIParent1.ShowDialog()
        Else
            MsgBox("Incorrect login name or password", MsgBoxStyle.Information, "Login")
        End If
    End Sub

    Private Sub Cancel_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Cancel.Click
        Me.Close()
    End Sub

    Private Sub LoginForm1_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Call Main()
    End Sub

    Private Sub UsernameTextBox_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles UsernameTextBox.TextChanged

    End Sub

    Private Sub PasswordTextBox_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles PasswordTextBox.TextChanged

    End Sub
End Class
