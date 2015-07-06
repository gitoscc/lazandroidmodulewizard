{Hint: save all files to location: C:\adt32\eclipse\workspace\AppHttpClientDemo1\jni }
unit unit1;
  
{$mode delphi}
  
interface
  
uses
  Classes, SysUtils, And_jni, And_jni_Bridge, Laz_And_Controls, 
    Laz_And_Controls_Events, AndroidWidget, textfilemanager;
  
type

  { TAndroidModule1 }

  TAndroidModule1 = class(jForm)
      jButton1: jButton;
      jButton2: jButton;
      jButton3: jButton;
      jButton4: jButton;
      jEditText1: jEditText;
      jEditText2: jEditText;
      jHttpClient1: jHttpClient;
      jTextFileManager1: jTextFileManager;
      jTextView1: jTextView;
      jTextView2: jTextView;
      jWebView1: jWebView;
      procedure AndroidModule1JNIPrompt(Sender: TObject);
      procedure AndroidModule1Rotate(Sender: TObject; rotate: integer;
        var rstRotate: integer);
      procedure jButton1Click(Sender: TObject);
      procedure jButton2Click(Sender: TObject);
      procedure jButton3Click(Sender: TObject);
      procedure jButton4Click(Sender: TObject);
      procedure jHttpClient1CodeResult(Sender: TObject; code: integer);
      procedure jHttpClient1ContentResult(Sender: TObject; content: string);

    private
      {private declarations}
    public
      {public declarations}
  end;
  
var
  AndroidModule1: TAndroidModule1;

implementation
  
{$R *.lfm}

{ TAndroidModule1 }

//http://inchoo.net/dev-talk/android-development/rest-api-with-http-authentication-android-beanstalk-example/
procedure TAndroidModule1.jButton1Click(Sender: TObject);
begin
  jEditText2.Clear;

  //Please,  configure to real location ...
  //jHttpClient1.SetAuthenticationHost('http:\\localhost', 123);    //ok!
  //or SetAuthenticationHost('', -1);  //--> AuthScope(null, -1)

  //jHttpClient1.SetAuthenticationUser('jmpessoa', '123456');       //ok!
  //jHttpClient1.SetAuthenticationMode(autBasic);                   //ok!

  //Non-blocking !
  jHttpClient1.GetAsync(jEditText1.Text);    //get [Async]  content  ... http://cartoonforyou.forumvi.com/h1-page

  jWebView1.Navigate('http://www.freepascal.org');  // view page ... http://cartoonforyou.forumvi.com/h1-page

end;

procedure TAndroidModule1.jButton2Click(Sender: TObject);
begin
  ShowMessage('Please,  configure to real location ...');
  (*
  //Non-blocking !
  jHttpClient1.PostNameValueDataAsync('http:\\localhost\myphpcode.php', 'name','paul');     //ok

  //or
  jHttpClient1.PostNameValueDataAsync('http:\\localhost\myphpcode.php', 'name=paul&city=bsb'); //ok

  //or
  jHttpClient1.AddNameValueData('name','paul');
  jHttpClient1.AddNameValueData('city','bsb');
  jHttpClient1.PostNameValueDataAsync('http:\\localhost\myphpcode.php');
  *)
end;

procedure TAndroidModule1.jButton3Click(Sender: TObject);
var
   content: string;
begin
  jEditText2.Clear;

  //blocking
  content:= jHttpClient1.Get('http://cartoonforyou.forumvi.com/h1-page');
  jEditText2.Append(content);
end;

procedure TAndroidModule1.jButton4Click(Sender: TObject);
begin
    ShowMessage('Please,  configure the code to real location ...');
  (*
    //blocking
    jHttpClient1.AddNameValueData('name','paul');
    jHttpClient1.AddNameValueData('city','bsb');
    jHttpClient1.Post('http:\\localhost\myphpcode.php');
  *)
end;

procedure TAndroidModule1.jHttpClient1CodeResult(Sender: TObject; code: integer);
begin
   jEditText2.AppendLn('--------------------------------');
   jEditText2.AppendLn('Code Result = '+ IntToStr(code));
   //ShowMessage(IntToStr(code));
end;

procedure TAndroidModule1.jHttpClient1ContentResult(Sender: TObject; content: string);
var
  list: TStringList;
  txtContent: String;
  ok: boolean;
begin

  jEditText2.Clear;
  jEditText2.AppendLn(content);

  //save to device folder Download...   you can try others folders
  list:= TStringList.Create;
  list.Text:= content;
  list.SaveToFile(Self.GetEnvironmentDirectoryPath(dirDownloads)+'/mycontent.txt');
  list.Free;

   //test  [is it there ?]
   txtContent:=  jTextFileManager1.LoadFromFile( Self.GetEnvironmentDirectoryPath(dirDownloads), 'mycontent.txt');
   //ShowMessage(txtContent);   //yes, it is !!!!

  //others test ....
  {
   ok:= Self.CopyFile(Self.GetEnvironmentDirectoryPath(dirDownloads) + '/mycontent.txt',
                      Self.GetEnvironmentDirectoryPath(dirSdCard) + '/mycontent.txt');

   if ok then ShowMessage('copied !!') else  ShowMessage('copy  fail!')
   }

end;

procedure TAndroidModule1.AndroidModule1Rotate(Sender: TObject;
  rotate: integer; var rstRotate: integer);
begin
   Self.UpdateLayout;
end;

procedure TAndroidModule1.AndroidModule1JNIPrompt(Sender: TObject);
begin
  jEditText2.Clear;
  jEditText1.SetFocus;

  if  not Self.IsWifiEnabled() then Self.SetWifiEnabled(True);

  //Test
  {
  if Self.IsSdCardMounted then ShowMessage('Yes, SdCard is Mounted!!!')
  else ShowMessage('Warning, SdCard is NOT Mounted!');
  }

end;

end.
