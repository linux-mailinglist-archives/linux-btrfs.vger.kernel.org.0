Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E33955DD1A
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jun 2022 15:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238154AbiF0P34 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Jun 2022 11:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235959AbiF0P3y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Jun 2022 11:29:54 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00119.outbound.protection.outlook.com [40.107.0.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E407E19285
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Jun 2022 08:29:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n7hl6CZTs1BMX8untSUVTYnylY7Q2r6P+aKsk8CJ5yYMCkscY7lihri3GC00VHRd/YfOr3hYZ0QAvQFvv5rzBGJBR3y22XKtWZWyH8Wez0aKqXAFeNlFpNnM/PuUY1GQ5AjZbKGCkibOiEP+vYFY+UwWOdImCzlkyFazAHiBp5JWTC2yVGdcH/CWuBlsfaSl/rHixaUAgVP8e747SLEb7Lzzod7qAf3zOkrS/VSkYb6rBdkNzuetzLaEgbUdSqDET1DEUUVn9DcoSUp7fiVLBFfuRSLYa/7vNvK0aFLWjv4XcL3iyXRnNKgPb9drrF4Z5ir9TxOmOCzlmpwrW4p8NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y817yBZlTs0moxMpXZnw1J5n0t/0VF7enEQ6b7h4CzY=;
 b=W7y/VbV7eH6dV46im6HlWHpGVdAPKq8RhNHPOMu6Eto1bJhjzMW+E3VbpknbvtU7uOLaxBTyk9THC714FRDAmbQtgfaVSs/HmC9LSl9R2Loc1qCaGC/CLfGBpEjgpfNkSUMuABtcHOuT1woFpuVJ2Zbj/Z2/MrEvKOPM6X1r7k9VVDtMkE3oXw0Dly1VGdWmQkRFBhYWdPpWtfjdPZALxqKD7WWvKamBVmURmtdy9Ngey5dKlusKBUa3frXgfmIqB5BrdeOgiSSPvCUaF9LkMVPBbcpOh2GBbWICwoDre2hBpCsk+SXf7FfA/qTWpDir88ll6FDzGR/p1ksOziPFpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bcom.cz; dmarc=pass action=none header.from=bcom.cz; dkim=pass
 header.d=bcom.cz; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bcom.cz; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y817yBZlTs0moxMpXZnw1J5n0t/0VF7enEQ6b7h4CzY=;
 b=Xz6ng1tmimCWe7m6h0C2gD/O9SyOU06dQ220R50szzhR/A4Kk7TwhpVFoB+wQ9HfyMf0D3EQFJT7IMjtfemG0U1s/KH9sa/9kkwEtX3E8NK0bfq0Ma1cWXN0Ce+Dmcd9qp23qMl+ERpKDqDxSbaOVZ6thu1/+9v2nubEdey57cs=
Received: from PAXPR03MB7856.eurprd03.prod.outlook.com (2603:10a6:102:213::23)
 by PR2PR03MB5386.eurprd03.prod.outlook.com (2603:10a6:101:20::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Mon, 27 Jun
 2022 15:29:48 +0000
Received: from PAXPR03MB7856.eurprd03.prod.outlook.com
 ([fe80::9922:97d9:a13f:6924]) by PAXPR03MB7856.eurprd03.prod.outlook.com
 ([fe80::9922:97d9:a13f:6924%7]) with mapi id 15.20.5373.018; Mon, 27 Jun 2022
 15:29:48 +0000
From:   =?utf-8?B?TGlib3IgS2xlcMOhxI0=?= <libor.klepac@bcom.cz>
To:     "joshua@mailmag.net" <joshua@mailmag.net>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Question about metadata size
Thread-Topic: Question about metadata size
Thread-Index: AQHYigSW65wbq0NzSkyBZZP+sZI85K1jCCEAgAADogCAAAi/AIAAF0gAgAAGFQCAACO0gIAACL0AgAAB/YCAAAEhgA==
Date:   Mon, 27 Jun 2022 15:29:48 +0000
Message-ID: <514bd2f7b1ecdc78f9df35e1d1844e5a7e8bfdf6.camel@bcom.cz>
References: <2b839657cfb533eee9b01a2197e76cf01916a195.camel@bcom.cz>
         <6a345774-e87c-ad3f-1172-e1d59f1382a7@gmx.com>
         <E77A8A5F-4C3F-479C-9428-DE56C82A8618@mailmag.net>
         <cc28f1516a8fe92007994d1a3fcee93f@mailmag.net>
In-Reply-To: <cc28f1516a8fe92007994d1a3fcee93f@mailmag.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.2-1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bcom.cz;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 52d8315d-00a3-4bcf-f945-08da5851df11
x-ms-traffictypediagnostic: PR2PR03MB5386:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hjFa7r5Kcd3+l/T63EjWP8AE3MU3ajGTjz0U/DdfmbeA52d9BH5vunsd1glTwYPP0BCXT0wJ+QwfBzViWHLaGSDm3cWMaux1EYkTDoaXouq7W1JPxwktF22BkgkIC8OL4428C3d4hHRTfPKmX/8id4p4qweGMT1m6nASWXkw2ANZCxWWNQBuWJEauhQs+f/ab1cl+jjsXA/RbSDXBI7MFXGZ6gYZ5R4v8HaQEYg7IfRj/1hLwfQsnrv7Jx7rdchpk4n6JmKjKch/pVIJoqwX1li9I15RECm3CvS8E0gFN/X1rLdrr3UuL8uLTxwaPJtyj+r3FoO+XdNekLWyGtD71hcjo9NVOx5P8KVU1vTAFyehHcmH7kk9CE1g4nI4P1yZ94eaNDi/GN2QCB3EHbnWIW5l02INLQ9QJ4A5b+qNXYHoiybaAXm3HiJzZxBaxUPE62Co3V69eJn6ULXo+pOE7tkk13nz5yDp5BtApeIj/uWQSg9cdD1iJM7jmYc+jBxMJCf+imh4yZKeYI0VXPq83Hi4wV4bV3vNDdY0jjDxfUQUAmv5AkY9cTj4BZwB+losQDYPeaVoCFKwYJPCNbkpfbrtil15enHn/aGBGbcHd5qydkyBYy9HEz9cQpk98sMYRZI+mJ9SW7KW8clQ8O0emdEaCsbhjZO6WQWFdh5egtuPatW4/EY4TIzyzKAvYOgyJv5iHexKD7qagNowAPE1qlhqxNZrOfjmXCH39Dj58u/pLHvlkn3VlSdOfpvIaet89Yl0HE7raZ3aB2k7+rRad8qlGf4CFE53gSvNS2DSE0qcSnIUgp4alpze9mqltD7HYXjzU6uynTTzQzqQCrEuSw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR03MB7856.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39850400004)(366004)(346002)(396003)(136003)(376002)(76116006)(66446008)(91956017)(8936002)(2616005)(6916009)(8676002)(64756008)(4326008)(66556008)(66946007)(86362001)(41300700001)(38070700005)(6506007)(316002)(6512007)(38100700002)(5660300002)(186003)(66476007)(478600001)(71200400001)(83380400001)(966005)(6486002)(85182001)(2906002)(3480700007)(36756003)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dmxKOVh5UDBxdW5tblJFZGpqK2xNdFgvOVVtNDBTeGJMUmV2OXZsZm8zczhm?=
 =?utf-8?B?UTYxNjZ2a0dyODZya0YzK3lCcGYvQzJOZld5ZHhzRjlZVkV6NWZ4aW5BeUVV?=
 =?utf-8?B?SXl3V0F2T2R6T05wQUdjbGd6SG1OeWtqOWVteUVlc2dlV0J4N1pDSGlKOWtv?=
 =?utf-8?B?TDlDbTlybUJYbWtvdnVqSEwwUFQzamIxSUl4NGlqL3pqYTNzU0Joc2hMTUdF?=
 =?utf-8?B?NXl2LzdJZGlNVHZ3K214V21hUmdmMjJudTVnMkxPV2l5T29RaHJ6eE9wbDhk?=
 =?utf-8?B?QWQ5S25JZERZZXlBZ2VqT0Z0WnRzRHc2MEhYVU4yTDJyQnlCcVlYa09neUNR?=
 =?utf-8?B?emlXc3FzVEs4V2c1eG0rTUtvT3JFSStvYm56K1phMzJmZ24wZkdhRFRsZU1k?=
 =?utf-8?B?SXRwd3lMeUtVT2NrWDZHeWMyYnBrK0ZvTC96QlNlVHFVQk5xTnI0aXZuTjB1?=
 =?utf-8?B?d05tNnNnem1sZ3MxYU4vNU5qS2U4bDRINCs2cFhDSWwvQmFvU0hGc3NpQTlE?=
 =?utf-8?B?N3I0OUdRQUJ5ekpoTkwxbzJ4dTZOZjVrUlQraEI4Y0FHSmxwLy9zQnJxaTQy?=
 =?utf-8?B?U0o5d1hINDcvNWwzRXlpTUhMbWpRLzZVb0FmVEJaOHBEbjZITmphNzRkejRH?=
 =?utf-8?B?YmZCMEJvY0ppeFBjUVArMWVUMklKTTlvbnozbFgxZ1VUNHdyaWVPVUhEV1VW?=
 =?utf-8?B?bHFBT1d5YjdaZmYra0t6WkVvb0hqMzJWb21HZTBvZG1zM1lvN1AyMVJ6YUF6?=
 =?utf-8?B?bDdycEhGQ3RsYmlwblgwYnh4czVmdWgwbUgvNjdybUpaNmJkbUoyQ0VpbllL?=
 =?utf-8?B?bDZIT21UWDBXM2Jpb2NBWStlemhtZGxPY2tpcUh1Mm5ac0svUEZHdlo1dGw1?=
 =?utf-8?B?RWQ2aHhzTzZjMlRUZ2syQk91SU1NUzhsMTBBOTJzT3RLMG5tbTFTUjBuYlJQ?=
 =?utf-8?B?ZlRwVW1US0tkTnk0RExEWmFwTDBvTE92ZllOR2JlK1BiRFd5RXYwSE1TVWt4?=
 =?utf-8?B?OXIzQU5qWndqUDN3REZQMlJOcnUxZ3BGMnVRelUvdDhQUWdDVFhiK2RsbUVD?=
 =?utf-8?B?MHU3aDkzUFkzNi94MmZyVG9rM3YzeGgzWnRTYitLd2NEbW1aUU8zc1lQRmFq?=
 =?utf-8?B?endoOUVFRWpUcVVORGJRN1RrSVQ4NWNHcWU3Zlp5M0kvbTBXSUpuVUVZeXV3?=
 =?utf-8?B?dXJKVTc2Wm5ZWFZvb2orT2MxS0ludTVoUDd1bTI1TjVkQm1BSlczNmpqWjZY?=
 =?utf-8?B?cEFpZ3RVLy9SbFJ6cjVVc3R2ZklzQnVyTFptYkpjaXVaRmNhU2NpR2poVzdr?=
 =?utf-8?B?cjFiWHRmd2g5Ui9OM2xobzJ6b3hxcE1EUVI5akN6NmJaYjg5QVFsLzFHdjF5?=
 =?utf-8?B?d3p5YU1mUjRRTXU1aGFNOHZXY2FCem0yTllMcDZIK2xtTHZwbFpXZWJiYVFz?=
 =?utf-8?B?STlzUlhGTDR3WnJlbkN2dTY1TkJMUVNmQ0l5cVRKVG1pQ3dwYXdwd3p1elJ5?=
 =?utf-8?B?ZXJSSDk5MUI5aEVmRzlva01kMytpL2NLNjhhRy8wbDl0UkYxS2ptSWxNTDBL?=
 =?utf-8?B?dWxxODVUeG9EakEvTkw3WnExY1FpNDNPcTFaNzZnZEt0cmJZWHdiNm1ITmNV?=
 =?utf-8?B?WFhwVTIvSFJFZnp3akpja2lZbXF2UXpXSXNmSTRCSnVYMzdwSE9PT2Njak5t?=
 =?utf-8?B?ajVCeXhETThwRUVkbi9ZbGw2WFJabG5XRnFkQ0g0NW95clI4em5leGZBWXVX?=
 =?utf-8?B?R2syN3d1bDFXQ292bVFncEF4QmhtTzMraEd2K01HdDh5YjlPUHhxdUxpODRs?=
 =?utf-8?B?NCt3K3BWcTVPRVM1L1cydFl3L1A1ZzVmbGRLaldCWUlvMVFtMkFhQ1ZDeG5v?=
 =?utf-8?B?OVlOZFJxRDQ5Q0ZHRnpLMlJiNnd6bmpTNFJNb2k4OWM1dkNtQlhYdmozTGZw?=
 =?utf-8?B?THlYU1c0NUxLWkFDRGY4NzFpcTlwM2dHNnlZczlyNGFBU3Q5UlNJRUI3Y3hF?=
 =?utf-8?B?ZHpGRFRYSHN4b05CaW1RbktWa2htUnI4T3ZFQWlKMzQzWVVWRVVsTkJtSkda?=
 =?utf-8?B?Q0IzdEcyUmRtcGJ3UEgwK09PT2hwS3BYc29GSjVTMk1zTzRzT09jaStHZS9y?=
 =?utf-8?B?VlpMWkh1ZnFHZzNTNmpKM3JLcm4xUVNydGV6bG9EK2Q5c2hYZ1FVRGNRNzUx?=
 =?utf-8?B?dEFmWmhLYmYrcEN5emlkdGQ4Q0V1S0NreUNqa2tPNDNISFF5MjVhZzF0NFhR?=
 =?utf-8?B?VURBcjRwaUpEay8wQnlFNUhoR3FnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <90EFF936EDAFCE4CB9F71A83A79F6113@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bcom.cz
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR03MB7856.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52d8315d-00a3-4bcf-f945-08da5851df11
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2022 15:29:48.4126
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 86024d20-efe6-4f7c-a3f3-90e802ed8ce7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rFESSzwhrEwHP+2bk6GUmINaMsPQXDyAnRMyHl/8pMaTeK26K0EZFtTc/HovV/ksDXlrVzHydJQY1jsZVY1SMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR2PR03MB5386
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

DQoNCk9uIFBvLCAyMDIyLTA2LTI3IGF0IDE1OjI1ICswMDAwLCBKb3NodWEgd3JvdGU6DQo+IEp1
bmUgMjcsIDIwMjIgODoxOCBBTSwgIkxpYm9yIEtsZXDDocSNIiA8bGlib3Iua2xlcGFjQGJjb20u
Y3o+IHdyb3RlOg0KPiANCj4gPiBPbiBQbywgMjAyMi0wNi0yNyBhdCAwNzo0NyAtMDcwMCwgSm9z
aHVhIFZpbGx3b2NrIHdyb3RlOg0KPiA+IA0KPiA+ID4gc25pcA0KPiA+ID4gDQo+ID4gPiA+IA0K
PiA+ID4gPiBTbyBpIHdpbGwgaGF2ZSB0byBleHBlcmltZW50LCBpZiB1c2VyIGxhbmQgY29tcHJl
c3Npb24gYWxsb3dzDQo+ID4gPiA+IHVzDQo+ID4gPiA+IHRvIGRvDQo+ID4gPiA+IHNvbWUgcmVh
c29uYmxlIGRlZHVwbGljYXRpb24gd2l0aCBiZWVzZC4NCj4gPiA+IA0KPiA+ID4gQXMgbG9uZyBh
cyB0aGUgY29tcHJlc3Npb24gYWxnb3JpdGhtL3Rvb2wgY2FuIHJlcHJvZHVjZSB0aGUgc2FtZQ0K
PiA+ID4gY29tcHJlc3NlZCBkYXRhIGZvciB0aGUgc2FtZSBpbnB1dCwgdGhlbiBpdCB3b3VsZCBi
ZSBmaW5lLg0KPiA+ID4gDQo+ID4gPiBEb2VzIE5ha2l2byBzdXBwb3J0IGNvbXByZXNzaW9uIHRo
YXQgcGxheXMgbmljZSB3aXRoIGRlZHVwZT8NCj4gPiA+IA0KPiA+ID4gSSBrbm93IFZlZWFtIGZv
ciBleGFtcGxlIGhhcyDigJxkZWR1cGUtZnJpZW5kbHnigJ0gYXMgYSBjb21wcmVzc2lvbg0KPiA+
ID4gb3B0aW9uIHdoaWNoIG1ha2VzIGl0IG91dHB1dCBsZXNzLWNvbXByZXNzZWQgZGF0YSwgYnV0
IGVuc3VyZXMNCj4gPiA+IHlvdXINCj4gPiA+IHN0b3JhZ2UgYXBwbGlhbmNlIGNhbiBkZWR1cGUg
aXQuDQo+ID4gPiANCj4gPiA+IE5vdCBzdXJlIGlmIHRoZXkgaGF2ZSBzb21ldGhpbmcgbGlrZSB0
aGF0LCBidXQgaWYgc28sIGl0IHdvdWxkDQo+ID4gPiBwcm9iYWJseSBiZSB0aGUgYmVzdCBzb2x1
dGlvbi4NCj4gPiANCj4gPiBMb29raW5nIGF0IHRoZSB2ZWVhbSBkb2NzLCBpdCBzZWVtcyB0byBi
ZSBqdXN0IGNvbXByZXNzaW9uIGxldmVsLA0KPiA+IGllDQo+ID4gdmVyeSBmYXN0IGNvbXByZXNz
aW9uDQo+ID4gDQo+ID4gTGlib3INCj4gDQo+IEhtbSwgeW91IGFwcGVhciB0byBiZSBwYXJ0aWFs
bHkgY29ycmVjdC4NCj4gDQo+IFRoZWlyIGRvY3VtZW50YXRpb246DQo+IGh0dHBzOi8vaGVscGNl
bnRlci52ZWVhbS5jb20vYmFja3VwLzcwL2JwX3ZzcGhlcmUvdG9waWNfY29tcHJlc3Npb24uaA0K
PiB0bWwNCj4gQ2xhaW1zIHRoYXQ6DQo+ICJEZWR1cGUtZnJpZW5kbHkg4oCUIHRoaXMgaXMgYW4g
b3B0aW1pemVkIGNvbXByZXNzaW9uIGxldmVsIGZvciB2ZXJ5DQo+IGxvdyBDUFUgdXNhZ2UgYW5k
IHVzZXMgYSB2ZXJ5IHNpbXBsZSwgZml4ZWQgZGljdGlvbmFyeS4gVGhpcyBtZXRob2QNCj4gY2Fu
IGJlIGEgZ29vZCBjb21wcm9taXNlIHdoZW4gdXNpbmcgZGVkdXBsaWNhdGluZyBzdG9yYWdlIG9y
IFdBTg0KPiBhY2NlbGVyYXRvcnMgYmVjYXVzZSwgd2hpbGUgaXQgd2lsbCBsb3dlciB0aGUgZGVk
dXBlIHJhdGlvIGNvbXBhcmVkDQo+IHRvIG5vIGNvbXByZXNzaW9uLCBpdCB3aWxsIHNlbmQgbGVz
cyBkYXRhIHRvIHRoZSBkZWR1cGxpY2F0aW5nDQo+IGFwcGxpYW5jZS4iDQo+IA0KPiBTbyBpdCBk
aWRuJ3QgZG8gd2hhdCBJIHdhcyBleHBlY3RpbmcsIGFzIGl0J3MgcHVycG9zZSBpcyB3aGF0IHlv
dQ0KPiBzYWlkOsKgIG1vcmUgZm9yIHRha2luZyB0aGUgZGVkdXBlIGxvYWQgb2ZmIHRoZSBiYWNr
dXAgc2VydmVyKHMpLsKgIA0KPiANCj4gSW50ZXJlc3RpbmcsIHRoYW5rcyBmb3IgcG9pbnRpbmcg
dGhhdCBvdXQuDQo+IA0KDQpUaGFua3MgZm9yIHRoaXMgbGluaywgaSB3aWxsIHVzZSBpdCB0byBh
c2sgbmFraXZvIHN1cHBvcnQuIA0KQnV0IGkgZG9uJ3QgZXhwZWN0IHRoZW0gdG8gaGF2ZSBpdCBp
bXBsZW1lbnRlZC4NCg0KTGlib3INCg0KPiA+IA0KPiA+ID4gPiBJdCBtYXkgbWF5YmUgc3BlZWQg
dXAgYmVlc2QsIGl0IGNhbm5vdCBrZWVwIHVwIHdpdGggZGF0YQ0KPiA+ID4gPiBpbmZsdXgsDQo+
ID4gPiA+IG1heWJlDQo+ID4gPiA+IGl0J3MgKGFsc28pIGJlY2F1c2UgdGhlIG51bWJlciBvZiBm
aWxlIGV4dGVudHMuDQo+ID4gPiA+IFVuZm9ydHVuYXRlbHkgaXQgd2lsbCBtZWFuIHNvbWUgc2Vy
aW91cyBkYXRhIGp1Z2dsaW5nIGluDQo+ID4gPiA+IHByb2R1Y3Rpb24NCj4gPiA+ID4gZW52aXJv
bm1lbnQuDQo+ID4gPiANCj4gPiA+IEknbSB3b25kZXJpbmcgY2FuIHdlIGp1c3QgcmVtb3VudCB0
aGUgZnMgdG8gcmVtb3ZlIHRoZQ0KPiA+ID4gY29tcHJlc3M9enN0ZA0KPiA+ID4gbW91bnQgb3B0
aW9uPw0KPiA+ID4gDQo+ID4gPiBTaW5jZSBjb21wcmVzcz16c3RkIHdpbGwgb25seSBhZmZlY3Qg
bmV3IHdyaXRlcyBhbmQgdG8gdXNlci1zcGFjZQ0KPiA+ID4gY29tcHJlc3Npb24gc2hvdWxkIGJl
IHRyYW5zcGFyZW50LCBkaXNhYmxpbmcgYnRyZnMgY29tcHJlc3Npb24gYXQNCj4gPiA+IGFueQ0K
PiA+ID4gdGltZSBwb2ludCBzaG91bGQgbm90IGNhdXNlIHByb2JsZW1zLg0KPiA+ID4gDQo+ID4g
PiBUaGFua3MsDQo+ID4gPiBRdQ0KPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiBUaGFua3MsDQo+
ID4gPiA+IExpYm9yDQo+ID4gPiA+IA0KPiA+ID4gPiANCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBU
aGFua3MsDQo+ID4gPiA+ID4gUXUNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+
ID4gPiANCj4gPiA+ID4gPiA+ID4gVGhhbmtzLA0KPiA+ID4gPiA+ID4gPiBRdQ0KPiA+ID4gPiA+
ID4gDQo+ID4gPiA+ID4gPiBXaXRoIHJlZ2FyZHMsIExpYm9yDQo+ID4gPiA+ID4gPiANCj4gPiA+
ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gPiBNb3N0IG9mIHRoZSBmaWxlcyBhcmUgbXVsdGkg
Z2lnYWJ5dGUsIHNvbWUgb2YgdGhlbSBoYXZlDQo+ID4gPiA+ID4gPiA+ID4gYXJvdW5kDQo+ID4g
PiA+ID4gPiA+ID4gM1RCDQo+ID4gPiA+ID4gPiA+ID4gLQ0KPiA+ID4gPiA+ID4gPiA+IGFsbCBh
cmUgc25hcHNob3RzIGZyb20gdm13YXJlIHN0b3JlZCB1c2luZyBuYWtpdm8uDQo+ID4gPiA+ID4g
PiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gV29ya2luZyB3aXRoIGZpbGVzeXN0ZW0gLSBtb3N0bHkg
ZGVsZXRpbmcgZmlsZXMgc2VlbXMNCj4gPiA+ID4gPiA+ID4gPiB0bw0KPiA+ID4gPiA+ID4gPiA+
IGJlDQo+ID4gPiA+ID4gPiA+ID4gdmVyeQ0KPiA+ID4gPiA+ID4gPiA+IHNsb3cgLQ0KPiA+ID4g
PiA+ID4gPiA+IGl0IHRvb2sgc2V2ZXJhbCBob3VycyB0byBkZWxldGUgc25hcHNob3Qgb2Ygb25l
DQo+ID4gPiA+ID4gPiA+ID4gbWFjaGluZSwNCj4gPiA+ID4gPiA+ID4gPiB3aGljaA0KPiA+ID4g
PiA+ID4gPiA+IGNvbnNpc3RlZCBvZiBmb3VyIG9yIGZpdmUgb2YgdGhvc2UgM1RCIGZpbGVzLg0K
PiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA+IFdlIHJ1biBiZWVzZCBvbiB0aG9zZSBk
YXRhLCBidXQgaSB0aGluaywgdGhlcmUgd2FzIHRoaXMNCj4gPiA+ID4gPiA+ID4gPiBtdWNoDQo+
ID4gPiA+ID4gPiA+ID4gbWV0YWRhdGENCj4gPiA+ID4gPiA+ID4gPiBldmVuIGJlZm9yZSB3ZSBz
dGFydGVkIHRvIGRvIHNvLg0KPiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA+IFdpdGgg
cmVnYXJkcywNCj4gPiA+ID4gPiA+ID4gPiBMaWJvcg0K
