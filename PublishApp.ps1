Set-ExecutionPolicy RemoteSigned
# Import the module for the  cmdLet
Import-Module 'C:\Program Files\Microsoft Dynamics NAV\110\Service\NavAdminTool.ps1'
# Publish app to database
Publish-NAVApp -ServerInstance DynamicsNAV110 -Path "C:\Users\lagl\Documents\NAV2018_AL\Systemcenter\SCR206 Pop-up comments\Systemcenter LAGL_SCR206 Pop-up comments_1.0.0.0.app" -SkipVerification
# Install in tenant
Install-NAVApp -ServerInstance DynamicsNAV110 -Name "SCR206 Pop-up comments"
# Uninstall the app - Delete the data
Uninstall-NAVApp  -ServerInstance DynamicsNAV110 -Name "SCR206 Pop-up comments" -DoNotSaveData 
# Remove the app from the database - but keep the tables
Unpublish-NAVApp -ServerInstance DynamicsNAV110 -Name "SCR206 Pop-up comments" 
# Synchronize the objekts in theh tenant
Sync-NAVTenant -ServerInstance DynamicsNAV110
# Remove the tables if the app is gone
Sync-NAVApp -ServerInstance DynamicsNAV110 -Name "SCR206 Pop-up comments" -Mode Clean