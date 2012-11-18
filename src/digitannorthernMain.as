import com.adobe.serialization.json.JSON;
import com.devaldi.controls.flexpaper.FlexPaperViewer;

import mx.controls.Alert;
import mx.core.FlexGlobals;
import mx.rpc.events.FaultEvent;
import mx.rpc.events.ResultEvent;
import mx.utils.StringUtil;

private var modelConfig:Object;

[Bindable]
private var siteurl:String="";

[Bindable]
private var serviceurl:String="";

[Bindable]
private var swfPath:String=demoswf;
[Bindable]
private var dynamicswfViewer:FlexPaperViewer=new FlexPaperViewer();
[Bindable]
private var selctedcolor:String="default";
[Bindable]
private var demoswf:String="";
[Bindable]
private var downloadPath:String="";
[Bindable]
private var searchText:String="";
[Bindable]
private var errorswf:String="";

[Bindable]
private var genecountsArr:Array=new Array();

private function digitalnorthern_init():void{
	serve_getConfigData.send();
	searchText=FlexGlobals.topLevelApplication.parameters.id;
	
	//
	
}

private  function httpResults(event:ResultEvent):void {
	//p1.removeAllElements();
	
	
	
	var result:Object = event.result;
	if(result.length>4 && result.toString() !="nofile\n"){
	swfPath="";
	swfPath=serviceurl+StringUtil.trim(result.toString())+'.swf';
	downloadPath=serviceurl+StringUtil.trim(result.toString())+'.pdf';
	//"http://v22.popgenie.org/digitalnortherntest/output/Paper.swf";//
	//swfPath="http://v22.popgenie.org/digitalnorthernService/output/temp521660157.swf"
	//swfviewer.SwfFile="http://v22.popgenie.org/digitalnorthernService/output/temp249526537.swf";
	swfviewer.SwfFile=swfPath;
	}else if(result.length>4 && result.toString() =="nofile\n"){
		swfPath=errorswf;
		swfviewer.SwfFile=swfPath;
	}else{
		swfPath=errorswf;
		swfviewer.SwfFile=swfPath;
		Alert.show("Check your input Values","Wrong Input")	
	}
	
	//dynamicswfViewer.Scale=2.0;
	
	//p1.addChild(dynamicswfViewer);
//   Alert.show(swfPath);
   
}

private function colourChange():void
{
	var hexString:* = bgcpicker.selectedColor.toString(16).toUpperCase();
	var cnt:int = 6 - hexString.length;
	var zeros:String = "";
	for (var i:int = 0; i < cnt; i++) 
	{
		zeros += "0";
	}
	selctedcolor="#" + zeros + hexString;
	submitbtnClick();
}

/**
 * creationCompete HTTP service Result
 */
private function handle_config_files(event:ResultEvent):void {
	modelConfig = (JSON.decode(String(event.result)));
	loadPolFile(modelConfig.settings.policy_file);
	siteurl=modelConfig.settings.url;
	serviceurl=modelConfig.settings.serviceurl;
	demoswf=modelConfig.settings.demoswf;
	errorswf=modelConfig.settings.errorswf;
	swfPath=demoswf;
	
	if(searchText!=null){
		if(searchText.length>5){
			inputTranscripttxt.text=searchText;//.replace( /\s+/gi, ",");;
			submitbtnClick();
		}
	}
	//Alert.show(siteurl);
}

/**
 * When submit button click
 */
private function submitbtnClick():void{
	var tmpStr:String=new String();
	tmpStr=StringUtil.trim(inputTranscripttxt.text);
	genecountsArr=new Array();
	
	var str:String= tmpStr.replace(new RegExp("[\n\r]","g"),",");
	var str2:String= str.replace(/[\r]+/g,',');
	var str3:String=str2.replace( /\s+/g,',');
	var str4:String= str3.replace(', ',',');
	
	 genecountsArr = str4.split(',');


	
	httpService.method = "POST"; 
	var params:Object = new Object(); 
	params.dn=str4;
	//inputTranscripttxt.text=str4;
	//Plot gene names FALSE
	params.geneannot=genenames.selectedItem.data;
	//Plot dendrogram FALSE
	params.plotden=plotdendrogram.selectedItem.data;
	//Max genes for colour scale  60
	params.zmax=maxgenscale.value;
	//Min gene frequency 1
	params.cutoff=mingenfq.value;
	//Clustering method average
	params.clustmethod=clustermethod.selectedItem.data;
	//distmethod euclidean
	params.distmethod=euclideanmedthod.selectedItem.data;
	//Correlation method
	params.cormethod=corrmethod.selectedItem.data;
	//Background default
	params.background=selctedcolor;
	
	httpService.url=siteurl;
	httpService.send(params);
}
private function downloadpdf():void{
	navigateToURL(new URLRequest(downloadPath), "_blank");
}

/**
 * When its fault fire this function
 */
private function transcriptDataResultFault(event:FaultEvent):Boolean {
	//myAlert.show(alertBox,"Please check the input format!!", false);
	Alert.show("Please check the input format!!");
	return true;
}

/**
 * Retrieves the crossdomain file for the web-service policy file.
 */
private function loadPolFile(url:String):void {
	Security.loadPolicyFile(url);
}

private function runDemoData():void{
	inputTranscripttxt.text="POPTR_0001s00200,POPTR_0001s00210,POPTR_0001s00220,POPTR_0001s00230,POPTR_0001s00240,POPTR_0001s00250,POPTR_0001s00260,POPTR_0001s00270,POPTR_0001s00280,POPTR_0001s00285,POPTR_0001s00290,POPTR_0001s00300,POPTR_0001s00310,POPTR_0001s00320,POPTR_0001s00330,POPTR_0001s00340,POPTR_0001s00350,POPTR_0001s00360,POPTR_0001s00370,POPTR_0001s00380,POPTR_0001s00390,POPTR_0001s00400,POPTR_0001s00410,POPTR_0001s00415,POPTR_0001s00420,POPTR_0001s00430,POPTR_0001s00440,POPTR_0001s00450,POPTR_0001s00460,POPTR_0001s00470,POPTR_0001s00480,POPTR_0001s00490,POPTR_0001s00500,POPTR_0001s00510,POPTR_0001s00520,POPTR_0001s00530,POPTR_0001s00540,POPTR_0001s00550,POPTR_0001s00560,POPTR_0001s00570,POPTR_0001s00580,POPTR_0001s00590,POPTR_0001s00600,POPTR_0001s00610,POPTR_0001s00620,POPTR_0001s00630,POPTR_0001s00640,POPTR_0001s00650,POPTR_0001s00660,POPTR_0001s00670,POPTR_0001s00680,POPTR_0001s00690,POPTR_0001s00700,POPTR_0001s00710,POPTR_0001s00720,POPTR_0001s00730,POPTR_0001s00750,POPTR_0001s00760,POPTR_0001s00770,POPTR_0001s00780,POPTR_0001s00790,POPTR_0001s00800,POPTR_0001s00810,POPTR_0001s00820,POPTR_0001s00830,POPTR_0001s00840,POPTR_0001s00850,POPTR_0001s00860,POPTR_0001s00870,POPTR_0001s00880,POPTR_0001s00890,POPTR_0001s00900,POPTR_0001s00910,POPTR_0001s00920,POPTR_0001s00930,POPTR_0001s00940,POPTR_0001s00950,POPTR_0001s00960,POPTR_0001s00970,POPTR_0001s00990,POPTR_0001s01000,POPTR_0001s01010,POPTR_0001s01020,POPTR_0001s01040,POPTR_0001s01050,POPTR_0001s01060,POPTR_0001s01070,POPTR_0001s01080,POPTR_0001s01090,POPTR_0001s01100,POPTR_0001s01110,POPTR_0001s01120,POPTR_0001s01130,POPTR_0001s01140,POPTR_0001s01150,POPTR_0001s01160,POPTR_0001s01165,POPTR_0001s01170,POPTR_0001s01180,POPTR_0001s01190,POPTR_0001s01210,POPTR_0001s01220,POPTR_0001s01230,POPTR_0001s01240,POPTR_0001s01250,POPTR_0001s01260,POPTR_0001s01270,POPTR_0001s01280,POPTR_0001s01290,POPTR_0001s01300,POPTR_0001s01310,POPTR_0001s01320,POPTR_0001s01340,POPTR_0001s01350,POPTR_0001s01360,POPTR_0001s01370,POPTR_0001s01380,POPTR_0001s01390,POPTR_0001s01400,POPTR_0001s01410,POPTR_0001s01420,POPTR_0001s01430,POPTR_0001s01440,POPTR_0001s01450,POPTR_0001s01460,POPTR_0001s01470,POPTR_0001s01480,POPTR_0001s01490,POPTR_0001s01500,POPTR_0001s01510,POPTR_0001s01520,POPTR_0001s01530,POPTR_0001s01540,POPTR_0001s01550,POPTR_0001s01560,POPTR_0001s01580,POPTR_0001s01590,POPTR_0001s01600,POPTR_0001s01610,POPTR_0001s01620,POPTR_0001s01630,POPTR_0001s01640,POPTR_0001s01650,POPTR_0001s01660,POPTR_0001s01670,POPTR_0001s01690,POPTR_0001s01700,POPTR_0001s01720,POPTR_0001s01730,POPTR_0001s01740,POPTR_0001s01750,POPTR_0001s01760,POPTR_0001s01770,POPTR_0001s01780,POPTR_0001s01790,POPTR_0001s01800,POPTR_0001s01810,POPTR_0001s01820,POPTR_0001s01830,POPTR_0001s01840,POPTR_0001s01850,POPTR_0001s01860,POPTR_0001s01870,POPTR_0001s01880,POPTR_0001s01890,POPTR_0001s01920,POPTR_0001s01930,POPTR_0001s01940,POPTR_0001s01950,POPTR_0001s01960,POPTR_0001s01970,POPTR_0001s01980,POPTR_0001s01990,POPTR_0001s02000,POPTR_0001s02010,POPTR_0001s02020,POPTR_0001s02030,POPTR_0001s02040,POPTR_0001s02050,POPTR_0001s02060,POPTR_0001s02070,POPTR_0001s02080,POPTR_0001s02090,POPTR_0001s02100,POPTR_0001s02110,POPTR_0001s02120,POPTR_0001s02130,POPTR_0001s02140,POPTR_0001s02150,POPTR_0001s02160,POPTR_0001s02170";	
	submitbtnClick();
}

private function navigatetohelppage():void{
	navigateToURL(new URLRequest("http://www.popgenie.org/book/digital-northern"), "_blank");
}