Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02EA6758109
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jul 2023 17:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233686AbjGRPet (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Jul 2023 11:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233672AbjGRPem (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Jul 2023 11:34:42 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2065.outbound.protection.outlook.com [40.107.20.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6340E7E
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Jul 2023 08:34:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k2NVjV61pUFnsYTytKoXCiJCda7k28xga4ZRn+9olBbicXLfSCkApj3pcckg+ryHpgAChZMA/1cFF4CzJAP/ZdrjCkl7VQV4WW+a7vI/sZMVykN+AWudAakui+e10S5Ip7Dl7LEZdVbYRh18yWpnZ9pyU1Vb9c/6+2jPRJ7ptBH0RZWDcX/E09ocUfUQBF4Gyc6CzHgrHxlpyuMFc08GpS9AgoRuiV/0n+7A2OAYyMMFsvMcKfNzzIh+oLohts/IdLTyQHP63LsX6zuMP7HWFaLmFTwR0TZZbt2MgoKX0I/CjxuIi0s3jiHt2ndveW9EBsD0N5VK9J4WqQ1Yd5YiYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9AKJEei1S/lXjei2ibCTp79kyPKPNn3V00AjU9HxVw0=;
 b=MjO6lvcPR2nHapYYmxbpi+Q/bxif/eta1PpzVjNOJvv9OraBjUynSa1BKE55gh9YZA1ZwIW3nPMnncj+RUNPmUhF7oTX7wtWoImmgQRTAiFGW5ABzCIZ8qTolnrZjes23pWjpKLPMKLTph2h3bFRBXZoj2taXUAZeWjbLygsK/Q5A4G+GPEnCAc7JnUBecv+vZoGIym39fkQ/SdN9ktazNxzGOVyA3dv1uSdciMPdJamOvUHOs7KF0CJ3PrbyvOQY4JZkTvBcmpRBHwwq2MBvCqFaoI1QD7+csoycPsLgLaBdVskFjp2/1X6tqYe4tBSXMJtti/jq4ubOaXRtrfy2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=helmholtz-muenchen.de; dmarc=pass action=none
 header.from=helmholtz-muenchen.de; dkim=pass header.d=helmholtz-muenchen.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hmgu.onmicrosoft.com;
 s=selector1-hmgu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9AKJEei1S/lXjei2ibCTp79kyPKPNn3V00AjU9HxVw0=;
 b=OE/1bukfjWZEgZXQOCu2dT3vaMMSkzGlCtdgDfeYr9X68Da+7M+RKKKTcfQijfN9z+2/jYG18fR/ZwGCrdi9o71bp3kuq3Sa0tORUTMZfjN0c8IHjuNzIPiqofyWq9xdcI2ott2rUjDvx9Yv/D52+Yw7NpXsXgvPzGaw5a64GXc=
Received: from PR3PR04MB7340.eurprd04.prod.outlook.com (2603:10a6:102:93::18)
 by DU2PR04MB8997.eurprd04.prod.outlook.com (2603:10a6:10:2e0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Tue, 18 Jul
 2023 15:34:23 +0000
Received: from PR3PR04MB7340.eurprd04.prod.outlook.com
 ([fe80::39bd:265c:980:8db6]) by PR3PR04MB7340.eurprd04.prod.outlook.com
 ([fe80::39bd:265c:980:8db6%6]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 15:34:23 +0000
From:   Bernd Lentes <bernd.lentes@helmholtz-muenchen.de>
To:     Qu Wenruo <wqu@suse.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Remi Gauvin <remi@georgianit.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: RE: question to btrfs scrub
Thread-Topic: question to btrfs scrub
Thread-Index: AdmqYWxcqzByINPHTMyzVF+8SQB2BgAB8fyAAA4C3wAAJq31gADUQtNgAA4hmwAAFVwYIAAAiSAAAAyYELAABoslAAAaKeyAAFCejJAAEViOAAIMNzjA
Date:   Tue, 18 Jul 2023 15:34:23 +0000
Message-ID: <PR3PR04MB7340ED5619736D95E2E5AD8ED638A@PR3PR04MB7340.eurprd04.prod.outlook.com>
References: <PR3PR04MB734055F52AB54D94193FA79CD625A@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <8a3d7ad6-0ddb-3160-eece-8d6228b9c0a6@gmx.com>
 <PR3PR04MB7340BD6CD63180053CCA023ED62AA@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <3d208b62-efc2-afe4-e928-986dc4c53936@gmx.com>
 <PR3PR04MB7340ACCB059FA7C9A22052DBD62EA@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <e4237dc0-2bdc-a8b3-9db5-6b0e24b7b513@suse.com>
 <PR3PR04MB7340B6C8F2191ED355D1232BD62FA@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <80136f6f-0575-58e8-ea8d-7053c8af4db0@suse.com>
 <PR3PR04MB734063CF2AEA3709D3AFD9A5D62FA@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <743f92ee-19e8-ba45-0426-795a91fc0e0b@georgianit.com>
 <00c1ea17-680f-18a0-d40a-f36bcdb9101d@gmx.com>
 <PR3PR04MB7340C4687924686D4C7ABD8AD62DA@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <6732859d-55b9-82cd-c50d-33f5455b054b@suse.com>
In-Reply-To: <6732859d-55b9-82cd-c50d-33f5455b054b@suse.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=helmholtz-muenchen.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PR3PR04MB7340:EE_|DU2PR04MB8997:EE_
x-ms-office365-filtering-correlation-id: 7d9554a0-393e-4918-b9ac-08db87a47678
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rYu3Bvl7y0sghhg+lnbk5wf05MwHYRFC3Ey8kofs/ifPqk+ihXDEsOQXAjSFUASH+QMRxdI5DnbMNNALEp2TNZ2PSmtfJiDXm7k2E/D4IP8j4pZL/7uhUwpa+pDqV5llp+nc6zVSd634CA2EWiTR2p8i2QqLZJKN/fT5wv5lnEscVz921xCyjC6ee0reW0+dez8PLYK3BFBk8wr/p4F+hCddQpONlGSoHiFJswAeBFRddXimM5u+VR6H88SGN+ms3PLNYRco/2lthNGo7YA6EjUSBdo7mrrU3E00QDrtMCFeHuBVy1+fbtre6x/mqtFvF8HxFlAtfg6T2oYkbX9tbsr9B6oZccsUIEy6GlLyPSWLOYbdzLPgqZKTkabDFUqtxj6I89umdBjQz85fzv++LAweDYRKA+JGf4Q2J8THNtoB2cgJD6Nb24MVzlkuq9vSEAVGwlvtGga1xxQgF2H+7EtNVbGvCT5GyjSxakJw3lu4iN20d1KnV8YOtXhFFlpeQ28Min2olRK6ASTQzoyEcihzlWt9+ng52ICCBPlG4tmrQEEEQdzVJ4k8Vz9JcC28eL9zLOtCq1wC/htR3wPAmkGSOvU5UqAYY6mf9rqG5h6esOcqvGwgGsWLAs5MMD0J
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR04MB7340.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(366004)(136003)(396003)(346002)(376002)(451199021)(83380400001)(33656002)(26005)(478600001)(6506007)(53546011)(55016003)(966005)(7696005)(9686003)(71200400001)(41300700001)(52536014)(64756008)(38070700005)(5660300002)(66476007)(66446008)(44832011)(8936002)(66556008)(76116006)(316002)(38100700002)(66946007)(8676002)(3480700007)(86362001)(4744005)(2906002)(122000001)(110136005)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VWwvUFZZTWFVUk1JaWJyOUd2NGNwTm5MMWw4RytQOU4rQnBVeGJ0NFpkL1hF?=
 =?utf-8?B?NlY0aGdmb3MyQlZZYXo4a2hNS1hFdldleWs3T2IxQU45U3VVampyNXpPV0Fs?=
 =?utf-8?B?bnZVeDZqTXFNQ2lJcjRZVjdWSFRiVnkvVjNEQ1k5Ylo3anoza3MxbDRZZnQ4?=
 =?utf-8?B?cXhOd0tQOE0wQjBqYld4WU9ySE1ORDdFQlpqcjVtNnpwOHlvc2VmRUhIa2JP?=
 =?utf-8?B?V09xKzRhTklNUHljRVV5aGRaMHRSQlhMOWRyK2RNVStYYkdtVTUxOGV0RWZr?=
 =?utf-8?B?ZEJyclczQXNjS0tFWG1WcTh1N1NrdDBFajFDRW42endmNnVuZkxLS3p3bHg1?=
 =?utf-8?B?NWE0Z1c4NVFhNVNkd04xVmZIQnhrOENiWGpic3NyK3pSdUowa1NENVZNbUUr?=
 =?utf-8?B?dDRzaXV0dXN3Qm1WRHpIZzFCNkdrdEEwZVdhWTNMZ04xT1ZpMFpZcGdJQ2gw?=
 =?utf-8?B?R0lsSkUzSlNMT0hFSDZjUFo4S0NYMk5LS1dnUnJIWFJIS2gyb21yemxlVHBF?=
 =?utf-8?B?S1NPL2NudHJwY2tnRGxtNWpaZmh2dmkxaHFOTnI4ZTNHUDd5OWhrS0lJbi9I?=
 =?utf-8?B?dXM3VklCNThXWnNnajI5a1k4dGF1TlI2eGRsVHFPdXpzVlhYNGsyb0V4eXl2?=
 =?utf-8?B?VTFPU3RrY1Z6VEVMczg5OVFmNzdJbEJrM0RLaTdLTjBOeFc3cXJrbUxFYjNl?=
 =?utf-8?B?ZVdleUI0SzJ2aHpzUE11emhtbjZuS2JIbjlIa2hjUXV4L0gweHNRemFZUTdK?=
 =?utf-8?B?TkNYZ0pORC9vbUNWZ29OU2VFdWFOVmxvRjVQeGp2SDFFaEVOYVl0T2g5MXMx?=
 =?utf-8?B?bkRiRFFCNkhVTmZMRFRZM0w0aitOOWM5MDNNYk9nVnN4R3U5MW9QU250QWo4?=
 =?utf-8?B?aUZRWkxCTDJWYzF5VndxVXhsUm43bUQ0U1FTaXA0VTl2SlpSYm9SQUhCUHBt?=
 =?utf-8?B?WXlOblg2SzFkWTM2M1M1d1d2NHQ0YzJjck52V1lBWGR0VHZOdkd4eTk2c01t?=
 =?utf-8?B?cll0NEhWM28wRHd4OXVXV21NUHdtRUJQSU5WMGNEci91M1Z5TVA4dExBT09j?=
 =?utf-8?B?UFBDMlJ6eXQvenFOdG9LZnA4ZzBCUkxSSVRMYVhqNHdKNktzeW1KdVRSWHY1?=
 =?utf-8?B?Wkw4L3doSlJHU2w4OXdXY1Y2dTRpc2w0TytwcTArWmFmWThuakFRamJYY3F6?=
 =?utf-8?B?NFJjTENQelFtVUZCcldBVU84endpTEN5RVdEQlBUU3J0MytkN3VUc0RmN0VR?=
 =?utf-8?B?dGZ2TjVmbHNKakpOMVFFZ1dpRENzcS84dlh3RCtlMnVIbHpMNDlPZm5JK3JV?=
 =?utf-8?B?RVc1YVdzVjU3b2ltM1J0VWtKVTRSeUhjN0haSmE3cm9jcUxKRWNQSDdISmht?=
 =?utf-8?B?WXlVNFZZcmVHMHlDYnZ1elZFZEpHcXVZRUpwQVVrVmRJa0hXeU1IVklwUWNF?=
 =?utf-8?B?K2gvdVVuSjlRQmRFMmF3cXlFZnlSZ25KMVh0WDI4clByOEtNSWZCbjhkN1RB?=
 =?utf-8?B?Z3E1Rmk3amVwbm5lT2pHU1YzMG1lUXdUenZvZDBYZE5TUnA1TGVYajZReG50?=
 =?utf-8?B?TFVGbkxLRHlkRkNMT05mbXV5ODBhRW42N1g4VUV5U3BKbmpoNmlJTEJydzUr?=
 =?utf-8?B?OWxUL2lqbXhCUzVkSnVwVTBNQitjV2VoK1RnNTVzVWJ4YXlXbnZ0VXBmSm5O?=
 =?utf-8?B?U3o3TTAvN2REckxjSHpib1Z1RnBOb3RrTmQzV1hCRWNHZWJXMmsrenlGZzQy?=
 =?utf-8?B?QmVKWG5ZQys3YTBUZytFZTc3eXVtSndPMTdmcGYxcDdoWmdlcVpxbkdGQ3dw?=
 =?utf-8?B?ZzU3ZkJiNTVLUVg4NjNDUVBPMzd5Tm9XSGYyQTg1N0ovaXpDalR3RzZ0OVBM?=
 =?utf-8?B?dWZ3dE1Bb2ZRc21CVjI5ZWxjcHVnbDJZbnkweDVaZE4xTXk3bENja2JxdHhN?=
 =?utf-8?B?dTkvemRLaFR1SmZZNXcvZDJzTStvbjNZZHo0SlJUM3NzVnhXeTgrTkg3dDBI?=
 =?utf-8?B?KzVYaG9rUzQ0T0ZHRDZVbnFtS1lIb2REbUM4TTZ5dU0rK3JBTmJ4Uk1acm1x?=
 =?utf-8?B?TXpZUldHZmZabytKd09jS05MSUtxRDRZSGk5a3VSL2s0a0NKTXdVd2tVK053?=
 =?utf-8?B?bHFzWDE0SzFlYlFEUjJDdzZ2Y05lRlhoSEN4VUxjUHZ4WXBRT3hSaXZGREJI?=
 =?utf-8?B?NHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: helmholtz-muenchen.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR3PR04MB7340.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d9554a0-393e-4918-b9ac-08db87a47678
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2023 15:34:23.5017
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e229e493-1bf2-40a7-9b84-85f6c23aeed8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LGPGiHnUMLvO2KBNl44wxPobhG68u8/OojIk3J6P5PFrkpshgvu8BUurrr6Nm3Rm3p6buPcnvp77m57QxGFWE/fF3eHmoDolpTiaEPDdGqqZJNSsMOg9/BHnIP/fcuQE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8997
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Pg0KPiBPbiAyMDIzLzcvOCAwNDo1NCwgQmVybmQgTGVudGVzIHdyb3RlOg0KPiA+PiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBRdSBXZW5ydW8gPHF1d2VucnVvLmJ0cmZz
QGdteC5jb20+DQo+ID4+IFNlbnQ6IFRodXJzZGF5LCBKdWx5IDYsIDIwMjMgODoyMyBBTQ0KPiA+
PiBUbzogUmVtaSBHYXV2aW4gPHJlbWlAZ2VvcmdpYW5pdC5jb20+OyBCZXJuZCBMZW50ZXMNCj4g
Pj4gPGJlcm5kLmxlbnRlc0BoZWxtaG9sdHotbXVlbmNoZW4uZGU+OyBRdSBXZW5ydW8gPHdxdUBz
dXNlLmNvbT47DQo+ID4+IGxpbnV4LWJ0cmZzIDxsaW51eC1idHJmc0B2Z2VyLmtlcm5lbC5vcmc+
DQo+ID4+IFN1YmplY3Q6IFJlOiBxdWVzdGlvbiB0byBidHJmcyBzY3J1Yg0KDQoNCj4gPj4gSSBo
YXRlIHRvIHBvaW50IG15IGZpbmdlciB0byBidHJmcyBpdHNlbGYsIGJ1dCBJIHN0aWxsIHJlbWVt
YmVyIGluDQo+ID4+IHRoZSBvbGQgZGF5cyBzb21lIHdvcmtsb2FkIGNhbiBsZWFkIHRvIHN1Y2gg
ZmFsc2UgYWxlcnRzLg0KPiA+PiBCdXQgSSBjYW4gbm90IHJlY2FsbCB3aGljaCBjb21taXQgaXMg
Y2F1c2luZyBhbmQgd2hpY2ggb25lIGlzIGZpeGluZw0KPiA+PiB0aGUgcHJvYmxlbS4NCg0KRGVh
ciBRdSwNCg0KZG9lcyB0aGF0IG1lYW4gdGhlIGJ1ZyBpcyBwb3NzaWJseSBub3QgZml4ZWQgPw0K
VXV1aC4NCg0KQmVybmQNCg0KSGVsbWhvbHR6IFplbnRydW0gTcO8bmNoZW4g4oCTIERldXRzY2hl
cyBGb3JzY2h1bmdzemVudHJ1bSBmw7xyIEdlc3VuZGhlaXQgdW5kIFVtd2VsdCAoR21iSCkNCklu
Z29sc3TDpGR0ZXIgTGFuZHN0cmHDn2UgMSwgRC04NTc2NCBOZXVoZXJiZXJnLCBodHRwczovL3d3
dy5oZWxtaG9sdHotbXVuaWNoLmRlDQpHZXNjaMOkZnRzZsO8aHJ1bmc6IFByb2YuIERyLiBtZWQu
IERyLiBoLmMuIE1hdHRoaWFzIFRzY2jDtnAsIERhbmllbGEgU29tbWVyIChrb21tLikgfCBBdWZz
aWNodHNyYXRzdm9yc2l0emVuZGU6IE1pbkRpcuKAmWluIFByb2YuIERyLiBWZXJvbmlrYSB2b24g
TWVzc2xpbmcNClJlZ2lzdGVyZ2VyaWNodDogQW10c2dlcmljaHQgTcO8bmNoZW4gSFJCIDY0NjYg
fCBVU3QtSWROci4gREUgMTI5NTIxNjcxDQo=
