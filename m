Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E80E755CF6D
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jun 2022 15:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235935AbiF0MR6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Jun 2022 08:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234297AbiF0MR5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Jun 2022 08:17:57 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50129.outbound.protection.outlook.com [40.107.5.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6550DEF3
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Jun 2022 05:17:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ctl/lvI27mNzNVmuCSlsJSHAd4QTooSPSN3aqGt7zcq8uJ6TaOwgnwUiHalWib3ma3LwEUWx0sMoGZ+umCWq3N9tbQH4SZIhbjGZqMkLOKEfyxvwaEmaErnDQZpiC6+yga0va0QTw9okOVydi6ULOzd6RlmTEnSA1iXbDnyKciMT2W8GW50lbl4vGll4xKnqkpjmlRlqaqQBpOmEyor3fbobgKnsaif/jswoM6Z7jrHy+H2CsX0wXuCPLDDvxQuKEc5eQX6iUcHjEKDz9r9yzcbKD2T5TLcbHEdE3nlVAv5Psawt0L+r554v4UevFp8AhxFPzsAZTAveKcuqkiU/RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HEnIlzS+rF9BF2YXrsoOGi0CX93FZPooN24ZyLyjdNE=;
 b=oRSUALKauVgNgHqdTFvsYLXa2dOdfO6nUXb9w/YEOUMIVH9q5KPr8/PPl8ZsR66e0faPLdpak17PDvz26QnHruc1S/+L8UyI1SuBbQh6f6EVYpPo6lBWy3xWO9KX3vtfAqkHfUdoeSus3owdFD47YHNRUUufb3uKhtryDqpvgy1n0hM1epo/dJTvJCJLWNvNMR63EBgSGPx1HMm2yxRlSmsrRRdvq0BpMzV1YYs45aTvp5j9FNhsRBnzwmz3rjxeiz+aj4TPaUGcICxnB/iptQMSVJHMnIAQgoyNxARfLG8Loi+pvWzLtXg4rvX4Uyi1ZYSvI9TT1A7j76p9oNYH6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bcom.cz; dmarc=pass action=none header.from=bcom.cz; dkim=pass
 header.d=bcom.cz; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bcom.cz; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HEnIlzS+rF9BF2YXrsoOGi0CX93FZPooN24ZyLyjdNE=;
 b=npD3XwZkZLBjRK9hByyNF7Vhk0x5Y/a4yHmOTvH5tF/6AsODdh4isURWluMVH5dzmsNK7DllmJ4coVSSYkGDZrYTVK1wl2uhH/ounxpSm/JV6zc2jwQAaPB2VXi3vRxyK/nrSn92RSi9hX9TuxtvX9AQrnvhON1b0vGcUZsN/y8=
Received: from PAXPR03MB7856.eurprd03.prod.outlook.com (2603:10a6:102:213::23)
 by DBBPR03MB6809.eurprd03.prod.outlook.com (2603:10a6:10:20c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Mon, 27 Jun
 2022 12:17:49 +0000
Received: from PAXPR03MB7856.eurprd03.prod.outlook.com
 ([fe80::9922:97d9:a13f:6924]) by PAXPR03MB7856.eurprd03.prod.outlook.com
 ([fe80::9922:97d9:a13f:6924%7]) with mapi id 15.20.5373.018; Mon, 27 Jun 2022
 12:17:49 +0000
From:   =?utf-8?B?TGlib3IgS2xlcMOhxI0=?= <libor.klepac@bcom.cz>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "quwenruo.btrfs@gmx.com" <quwenruo.btrfs@gmx.com>
Subject: Re: Question about metadata size
Thread-Topic: Question about metadata size
Thread-Index: AQHYigSW65wbq0NzSkyBZZP+sZI85K1jCCEAgAADogCAAAi/AIAAF0gA
Date:   Mon, 27 Jun 2022 12:17:49 +0000
Message-ID: <d97f1c183d0babf67c888c7fb79316be0d3f5073.camel@bcom.cz>
References: <8415b7126cba5045d4b9d6510da302241fcfaaf0.camel@bcom.cz>
         <42e942e3-a6d9-1fcd-cd9b-5c22ee3f2e1f@gmx.com>
         <f9b7e2fea36afefaec844c385d34b280f766b10b.camel@bcom.cz>
         <068fdbd5-d704-c929-355b-9cf0f500807f@gmx.com>
In-Reply-To: <068fdbd5-d704-c929-355b-9cf0f500807f@gmx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.2-1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bcom.cz;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 182c1138-2234-4a50-fb60-08da58370d46
x-ms-traffictypediagnostic: DBBPR03MB6809:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IhfQfds6ePtEoFu+2mLPvSZxy53P+bo6vKgsjxMVjdQeS6kqbAXHcVx0H2x6gi29IQjmEQR7w7sW21PzmsvhBlRhaCBqU36NiN4GHPRbYoBIURcupH63napPxPJeN7KDQqAxgVTLQe7YszTA6BPHOAHXos1Rn2Y7xxX/qu0TpZp7pFkNb9tIHaOFwVSYz0y70BnSnYilgpBGOP8KgSsmvdEPs+o+DZ9aiKKdGgalDgoKXt4MNfh8wX5Z0w+xlsy0Bi9nN0blTq58xwyKRSSZ7U+qx2b7arc2UmgGTSXg7GCTI0qZJQsyfUOm9pQk1fdknf7p22bkvsCOoE3HHseOous4U0uAir+58CChbBF+aoBh5grfRxT3e6KwwFTO9w+LgkxUSbQj+jcLh/0Onp4ggSAmG8ZwfVJ502kYpEi2bfXY4UdKKUa4MOTP7gkjzjeihPaW/tyuzdlgWx17j1c/TLi/Ldf0CxhrijaqIV3dH/It6bnXJR9qXjhKAszBMXlaaA0aloroYcVbOELGJyPoDRaWWpRrdh0ahCqZ32dQ23fFlu9MxHRZpgrfRcpvgOtFUGkceYUpr8xWnO0jDMccKjc/nsDE5rEbBv4/A5eSI3raef38G1fo9TOX98SebXI5hRGlCYoOxQlxBs/JCLb+z4AdpyF+53SiDPRYc6CntlaAL3d1PGP/CACY2csDkLcMm9UuX+Nlm1J1Zvn3OQ2BDYH74gk0gbGk8kMK7uijx7vemosRKihWKYb14sd7pcVIBTvldJR3ltx2vFz/kVWtAm1tJ3N53vAFmR7WxaM3vpc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR03MB7856.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(396003)(136003)(376002)(366004)(39850400004)(5660300002)(36756003)(2906002)(122000001)(85182001)(316002)(41300700001)(2616005)(38100700002)(53546011)(110136005)(86362001)(478600001)(6512007)(83380400001)(3480700007)(66946007)(64756008)(76116006)(66556008)(8676002)(66446008)(91956017)(66476007)(6506007)(71200400001)(38070700005)(186003)(6486002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aGFMbHhPbEJ6UnhEYzRSR3lNRFZoRXltQUhtQzJ5aWZvQTNEZm4wWmI5OHZQ?=
 =?utf-8?B?ZEEwWkRpNTNJekRTN1JxeW1uc29PZmRsRThVU0JPNEs0dHNXWFNVcGRqOHIv?=
 =?utf-8?B?cjdpNHliNlZqdmdQb0hYWVFTUWJ0UVpvTGw5VlhzOUNTYks0RDhUSHU5eFlo?=
 =?utf-8?B?WUFJOFVFRDlUeFRGbnNFOWRCd014elluaWo0SWxENzVmNVgzUVR5andVWVB5?=
 =?utf-8?B?MjczVTNpYmE3N0JBSmVEWUE3cnlIWEpyVmJrK3FYcklIVVlCVlZZNG1RWXNo?=
 =?utf-8?B?L3paK1Z0L1FBZDExUnd1T2NZS0dLRWdORUFsMzEwWkRPaXcwWVJaSTNEN3BJ?=
 =?utf-8?B?SVFXNmFzeTcweEdTc1h5QjFpRjY5M2FBV29CNGpmNUtldzNIRFQycGFNOW1h?=
 =?utf-8?B?VWVIQ1Job1VNdGcvbCtKLytuM05TOXFjZGsyT3F1d0FMZEZPMGRGdHh5Zmxy?=
 =?utf-8?B?enFQR2RPcGxTeFQ1aDZFL2pTOVFSbjZYZUpYZE1Qd29iRE5DeEFLOUhGTGp3?=
 =?utf-8?B?N242MThMTUJDL1RxTzlMTlgzSSs3c29vOFIxTURvZzF1b29paXNIL2ltZll3?=
 =?utf-8?B?VkFlQzRnSkYzL1Nqbmd0bnducGhUUzBNVVVMUFNFMVJ5Q2NKeWk2YjRHazh4?=
 =?utf-8?B?bVVBbURNcnpyY1pTSW0xNy9Xd3ZKVXF1eXduejVSM0tvcXo0UE42SVJWUno5?=
 =?utf-8?B?bit2T3ovenl2MzVMMnpKdHJLSnYrVTB2b3NwMm0rZ2tyRStTMzViQW1XSGx1?=
 =?utf-8?B?OGF5Rnlxa0NtT0hxVklRbXEzL3pDNnBuUERRZC9oek5pSnVrazRVL1VSS2g0?=
 =?utf-8?B?ZzlzNWpWZVgvWE9MVjZzSGZydlNVbFJ1Z3VDTW5wMnQ3TzBNcTFkZGhKWkpU?=
 =?utf-8?B?RVZUQmRNenV3ZDBFVEpnZjQ3YmtQdlVXS095Wm5FNUt5YkFUK2pPa1QrdnpV?=
 =?utf-8?B?MjkxVnF6MXpvNTQ3N2x1eHpqMFhscW9pMXZudklrNnlBb01WREk0SVRWdFlp?=
 =?utf-8?B?YUpnS1FyUUdoY2NFcHZBS2kvM0ZLY1RpcEJ6YWk5WjYyZ29EYWNNNlViK2ZY?=
 =?utf-8?B?bjhHNkQ3OWZkZW8vZ240RjgwYmtFNWNyVW9YelU5cDNsU1RSK1ZGTCtCUnBa?=
 =?utf-8?B?em8vcWdLd0w1RDF4Slc5MjNScmFJalRKN3ZPeGFCK1VncDFrblZydWtmQnJh?=
 =?utf-8?B?cGpvMWFRTCsyT0lmUjJsMjBvUzU0SjZrWDFvQjV6a0tiUjZLYUU5eWMrNSt6?=
 =?utf-8?B?TDlkTmtxaHByOXordTJjWUhZMEpMR01TSHUxaHpMQ2t3ajllMnpEZVM5SVVp?=
 =?utf-8?B?RStSeEFZMmFwTk5lMU5sNFgxSEoybCtxNXYwc0M5cWVIMzNNbVNnbVpWczRQ?=
 =?utf-8?B?TVpxL3lKOE0zNGsyT3JIWnVjT2hOS2dGUTROUXNKRDEwbzVMcTZjY3VMY1h3?=
 =?utf-8?B?ajBxSFVGMFh1QzJMQ2hHd1FhcnVkSmR0YjJnY0dGSkJ3WVJBQnNTak1zTU55?=
 =?utf-8?B?QTlOVUhtMVRXOEM0dmRNNExnS0lkUnZRbXZxSzhxK0U3Zkh4RDVrekMvZWZs?=
 =?utf-8?B?WERHM1I1aUNjTFpVeWJueHEwZFp3RU50MFFEbi9PNWJlRmFFbWY2UGlJbDVw?=
 =?utf-8?B?UExaR1FzVlBTOEVLM25nNzZ1WmxXOVNINUlLaXZvYzQ4dC9VOU5rODdBWkZN?=
 =?utf-8?B?SnVhQjhwVVJhQ2drcCtEY0NFMDE3WjN5dzJUUU5xL1RSaTlXTWxwRXhvcU92?=
 =?utf-8?B?NDZMakk2SkJHc2FRV29FRVhuNXEvQmM3alhCU1MwNUJyVWNhOUI5dHIvUktT?=
 =?utf-8?B?TUhyNEpLMmNlNUZaWDNDeVQ3aHJOVzFLeWo1U3hndDd3dmFsUWltOThuZktB?=
 =?utf-8?B?MnJnOW52SS9KdE1vZFhSNHVPNm4yZVM4YWhMNkxNT1JhelpCaHl2NTV4TG1D?=
 =?utf-8?B?ZllhYTlJbDhVL0xYNVQyYXRFWnlQMlJSOUxYb0dnTEQvYlVOZitlS1JVakdl?=
 =?utf-8?B?WkFaL1RRUTFPcUVua0xLUVB1M2xpR2thMCs5SVZzTGdaOWRNQmR6RzBtUlNN?=
 =?utf-8?B?S0paQzhWU3FUNk52WVB0RzVBOTJQY1htcit5bVN1SENPZEFGaEJkN1pHb0xw?=
 =?utf-8?B?cUQvUHBXdGNkWXhidEkzalNzQW82NVZaK2d1TVdXcUFqdllLeHBHeTMxbyt4?=
 =?utf-8?Q?Me3KGy0+gk62vwjuIPRtNmz7SAzPuSWclkzo5mXmBf58?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9DE5ABE15A817048831F8C37867DE6AB@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bcom.cz
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR03MB7856.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 182c1138-2234-4a50-fb60-08da58370d46
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2022 12:17:49.5235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 86024d20-efe6-4f7c-a3f3-90e802ed8ce7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rn+H97sGG3PQnsfOdj4UHPwJqCSCLAeynTjpjBbLBY850YiULASu+4dqEQNM1nBLe31FndKyGCUGT9cI97Ey6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB6809
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gUG8sIDIwMjItMDYtMjcgYXQgMTg6NTQgKzA4MDAsIFF1IFdlbnJ1byB3cm90ZToNCj4gDQo+
IA0KPiBPbiAyMDIyLzYvMjcgMTg6MjMsIExpYm9yIEtsZXDDocSNIHdyb3RlOg0KPiA+IE9uIFBv
LCAyMDIyLTA2LTI3IGF0IDE4OjEwICswODAwLCBRdSBXZW5ydW8gd3JvdGU6DQo+ID4gPiANCj4g
PiA+IA0KPiA+ID4gT24gMjAyMi82LzI3IDE3OjAyLCBMaWJvciBLbGVww6HEjSB3cm90ZToNCj4g
PiA+ID4gSGksDQo+ID4gPiA+IHdlIGhhdmUgZmlsZXN5c3RlbSBsaWtlIHRoaXMNCj4gPiA+ID4g
DQo+ID4gPiA+IE92ZXJhbGw6DQo+ID4gPiA+IMKgwqDCoMKgwqAgRGV2aWNlIHNpemU6wqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAzMC4wMFRpQg0KPiA+ID4gPiDCoMKgwqDCoMKg
IERldmljZSBhbGxvY2F0ZWQ6wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDI0LjkzVGlCDQo+ID4g
PiA+IMKgwqDCoMKgwqAgRGV2aWNlIHVuYWxsb2NhdGVkOsKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
NS4wN1RpQg0KPiA+ID4gPiDCoMKgwqDCoMKgIERldmljZSBtaXNzaW5nOsKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgMC4wMEINCj4gPiA+ID4gwqDCoMKgwqDCoCBVc2VkOsKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAyNC45MlRpQg0KPiA+
ID4gPiDCoMKgwqDCoMKgIEZyZWUgKGVzdGltYXRlZCk6wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgNS4wN1RpQsKgwqDCoMKgwqAgKG1pbjoNCj4gPiA+ID4gMi41NFRpQikNCj4gPiA+ID4gwqDC
oMKgwqDCoCBEYXRhIHJhdGlvOsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIDEuMDANCj4gPiA+ID4gwqDCoMKgwqDCoCBNZXRhZGF0YSByYXRpbzrCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMS4wMA0KPiA+ID4gPiDCoMKgwqDCoMKgIEdsb2Jh
bCByZXNlcnZlOsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDUxMi4wME1pQsKgwqDCoMKgwqAg
KHVzZWQ6IDAuMDBCKQ0KPiA+ID4gPiANCj4gPiA+ID4gRGF0YSxzaW5nbGU6IFNpemU6MjQuODVU
aUIsIFVzZWQ6MjQuODRUaUIgKDk5Ljk4JSkNCj4gPiA+ID4gwqDCoMKgwqAgL2Rldi9zZGPCoMKg
wqDCoMKgwqAgMjQuODVUaUINCj4gPiA+ID4gDQo+ID4gPiA+IE1ldGFkYXRhLHNpbmdsZTogU2l6
ZTo4OC4wMEdpQiwgVXNlZDo4MS41NEdpQiAoOTIuNjUlKQ0KPiA+ID4gPiDCoMKgwqDCoCAvZGV2
L3NkY8KgwqDCoMKgwqDCoCA4OC4wMEdpQg0KPiA+ID4gPiANCj4gPiA+ID4gU3lzdGVtLERVUDog
U2l6ZTozMi4wME1pQiwgVXNlZDozLjI1TWlCICgxMC4xNiUpDQo+ID4gPiA+IMKgwqDCoMKgIC9k
ZXYvc2RjwqDCoMKgwqDCoMKgIDY0LjAwTWlCDQo+ID4gPiA+IA0KPiA+ID4gPiBVbmFsbG9jYXRl
ZDoNCj4gPiA+ID4gwqDCoMKgwqAgL2Rldi9zZGPCoMKgwqDCoMKgwqDCoCA1LjA3VGlCDQo+ID4g
PiA+IA0KPiA+ID4gPiANCj4gPiA+ID4gSXMgaXQgbm9ybWFsIHRvIGhhdmUgc28gbXVjaCBtZXRh
ZGF0YT8gV2UgaGF2ZSBvbmx5IDExOSBmaWxlcw0KPiA+ID4gPiB3aXRoDQo+ID4gPiA+IHNpemUN
Cj4gPiA+ID4gb2YgMjA0OCBieXRlcyBvciBsZXNzLg0KPiA+ID4gDQo+ID4gPiBUaGF0IHdvdWxk
IG9ubHkgdGFrZSBhcm91bmQgNTBLaUIgc28gbm8gcHJvYmxlbS4NCj4gPiA+IA0KPiA+ID4gPiBU
aGVyZSBpcyA4ODUgZmlsZXMgaW4gdG90YWwgYW5kIDE3IGRpcmVjdG9yaWVzLCB3ZSBkb24ndCB1
c2UNCj4gPiA+ID4gc25hcHNob3RzLg0KPiA+ID4gDQo+ID4gPiBUaGUgb3RoZXIgZmlsZXMgcmVh
bGx5IGRlcGVuZHMuDQo+ID4gPiANCj4gPiA+IERvIHlvdSB1c2UgY29tcHJlc3Npb24sIGlmIHNv
IG1ldGFkYXRhIHVzYWdlIHdpbGwgYmUgZ3JlYXRlbHkNCj4gPiA+IGluY3JlYXNlZC4NCj4gPiAN
Cj4gPiANCj4gPiBZZXMsIHdlIHVzZSB6c3RkIGNvbXByZXNzaW9uIC0gZmlsZXN5c3RlbSBpcyBt
b3VudGVkIHdpdGggY29tcHJlc3MtDQo+ID4gZm9yY2U9enN0ZDo5DQo+ID4gDQo+ID4gPiANCj4g
PiA+IEZvciBub24tY29tcHJlc3NlZCBmaWxlcywgdGhlIG1heCBmaWxlIGV4dGVudCBzaXplIGlz
IDEyOE0sIHdoaWxlDQo+ID4gPiBmb3INCj4gPiA+IGNvbXByZXNzZWQgZmlsZXMsIHRoZSBtYXgg
ZmlsZSBleHRlbnQgc2l6ZSBpcyBvbmx5IDEyOEsuDQo+ID4gPiANCj4gPiA+IFRoaXMgbWVhbnMs
IGZvciBhIDNUaUIgZmlsZSwgaWYgeW91IGhhdmUgY29tcHJlc3MgZW5hYmxlZCwgaXQNCj4gPiA+
IHdpbGwNCj4gPiA+IHRha2UNCj4gPiA+IDI0TSBmaWxlIGV4dGVudHMsIGFuZCBzaW5jZSBlYWNo
IGZpbGUgZXh0ZW50IHRha2VzIGF0IGxlYXN0IDUzDQo+ID4gPiBieXRlcw0KPiA+ID4gZm9yDQo+
ID4gDQo+ID4gVGhhdCBpcyBsb3Qgb2YgZXh0ZW50cyA7KQ0KPiA+IA0KPiA+ID4gbWV0YWRhdGEs
IG9uZSBzdWNoIDNUaUIgZmlsZSBjYW4gYWxyZWFkeSB0YWtlIG92ZXIgMSBHaUIgZm9yDQo+ID4g
PiBtZXRhZGF0YS4NCj4gPiANCj4gPiBJIGd1ZXNzIHRoZXJlIGlzIG5vIHdheSB0byBpbmNyZWFz
ZSBleHRlbnQgc2l6ZT8NCj4gDQo+IEN1cnJlbnRseSBpdCdzIGhhcmQgY29kZWQuIFNvIG5vIHdh
eSB0byBjaGFuZ2UgdGhhdCB5ZXQuDQo+IA0KPiBCdXQgcGxlYXNlIGtlZXAgaW4gbWluZCB0aGF0
LCBidHJmcyBjb21wcmVzc2lvbiBuZWVkcyB0byBkbyB0cmFkZS1vZmYNCj4gYmV0d2VlbiB3cml0
ZXMsIGFuZCB0aGUgZGVjb21wcmVzc2VkIHNpemUuDQo+IA0KPiBFLmcuIGlmIHdlIGNhbiBoYXZl
IGFuIDFNaUIgY29tcHJlc3NlZCBleHRlbnQsIGJ1dCBpZiAxMDIwS2lCIGFyZQ0KPiBvdmVyd3Jp
dHRlbiwganVzdCBvbmUgNEtpQiBpcyByZWFsbHkgcmVmZXJyZWQsIHRoZW4gdG8gcmVhZCB0aGF0
IDRLaUINCj4gd2UNCj4gbmVlZCB0byBkZWNvbXByZXNzIGFsbCB0aGF0IDFNaUIganVzdCB0byBy
ZWFkIHRoYXQgNEtpQi4NCg0KWWVzLCBpIGdldCByZWFzb24gZm9yIHRoaXMuDQpJIGp1c3QgbmV2
ZXIgcmVhbGlzZWQgdGhlIGRpZmZlcmVuY2UgaW4gZXh0ZW50IHNpemUgYW5kIGl0J3MgaW1wYWN0
IG9uDQptZXRhZGF0YSBzaXplL251bWJlciBvZiBleHRlbnRzLg0KDQo+IFNvIHBlcnNvbmFsbHkg
c3BlYWtpbmcsIGlmIHRoZSBtYWluIHB1cnBvc2Ugb2YgdGhvc2UgbGFyZ2UgZmlsZXMgYXJlDQo+
IGp1c3QgdG8gYXJjaGl2ZSwgbm90IHRvIGRvIGZyZXF1ZW50IHdyaXRlIG9uLCB0aGVuIHVzZXIg
c3BhY2UNCj4gY29tcHJlc3Npb24gd291bGQgbWFrZSBtb3JlIHNlbnNlLg0KDQpPaywgdGhlc2Ug
ZmlsZXMgYXJlIHdyaXRlbiBvbmNlIGFuZCBkZWxldGVkIGFmdGVyIDE0IGRheXMgKGV2ZXJ5IDE0
DQpkYXlzLCBuZXcgZnVsbCBiYWNrdXAgaXMgY3JlYXRlZCBhbmQgb2xkZXN0IGZ1bGxiYWNrdXAg
aXMgZGVsZXRlZC4gRnVsbA0KYmFja3VwIGlzIGR1bXAgb2Ygd2hvbGUgZGlzayBpbWFnZSBmcm9t
IHZtd2FyZSksIHVubGVzcyBuZWVkZWQgZm9yIHNvbWUNCnJlY292ZXJ5LiBUaGVuIGl0J3MgbW91
bnRlZCBhcyBkaXNrIGltYWdlLg0KDQo+IA0KPiBUaGUgZGVmYXVsdCBidHJmcyB0ZW5kcyB0byBs
ZWFuIHRvIHdyaXRlIHN1cHBvcnQuDQo+IA0KPiA+IFdlIGNhbiB1c2UgaW50ZXJuYWwgY29tcHJl
c3Npb24gb2YgbmFraXZvLCBidXQgbm90IHdpdGhvdXQgZGVsZXRpbmcNCj4gPiBhbGwNCj4gPiBz
dG9yZWQgZGF0YSBhbmQgY3JlYXRpbmcgZW1wdHkgcmVwb3NpdG9yeS4NCj4gPiBBbHNvIHdlIHdh
bnRlZCB0byBkbyBjb21wcmVzc2lvbiBpbiBidHJmcywgd2UgaG9wZWQgaXQgd2lsbCBnaXZlDQo+
ID4gbW9yZQ0KPiA+IHBvd2VyIHRvIGJlZXNkIHRvIGRvIGl0J3MgdGhpbmcgKGZvciBjb21wYXJp
bmcgZGF0YSkNCj4gDQo+IFRoZW4gSSBndWVzcyB0aGVyZSBpcyBub3QgbXVjaCB0aGluZyB3ZSBj
YW4gaGVscCByaWdodCBub3csIGFuZCB0aGF0DQo+IG1hbnkgZXh0ZW50cyBhcmUgYWxzbyBzbG93
aW5nIGRvd24gZmlsZSBkZWxldGlvbiBqdXN0IGFzIHlvdQ0KPiBtZW50aW9uZWQuDQoNClNvIGkg
d2lsbCBoYXZlIHRvIGV4cGVyaW1lbnQsIGlmIHVzZXIgbGFuZCBjb21wcmVzc2lvbiBhbGxvd3Mg
dXMgdG8gZG8NCnNvbWUgcmVhc29uYmxlIGRlZHVwbGljYXRpb24gd2l0aCBiZWVzZC4NCkl0IG1h
eSBtYXliZSBzcGVlZCB1cCBiZWVzZCwgaXQgY2Fubm90IGtlZXAgdXAgd2l0aCBkYXRhIGluZmx1
eCwgbWF5YmUNCml0J3MgKGFsc28pIGJlY2F1c2UgdGhlIG51bWJlciBvZiBmaWxlIGV4dGVudHMu
DQpVbmZvcnR1bmF0ZWx5IGl0IHdpbGwgbWVhbiBzb21lIHNlcmlvdXMgZGF0YSBqdWdnbGluZyBp
biBwcm9kdWN0aW9uDQplbnZpcm9ubWVudC4NCg0KVGhhbmtzLA0KTGlib3INCg0KDQo+IA0KPiBU
aGFua3MsDQo+IFF1DQo+IA0KPiA+IA0KPiA+ID4gDQo+ID4gPiBUaGFua3MsDQo+ID4gPiBRdQ0K
PiA+IA0KPiA+IFdpdGggcmVnYXJkcywgTGlib3INCj4gPiANCj4gPiA+ID4gDQo+ID4gPiA+IE1v
c3Qgb2YgdGhlIGZpbGVzIGFyZSBtdWx0aSBnaWdhYnl0ZSwgc29tZSBvZiB0aGVtIGhhdmUgYXJv
dW5kDQo+ID4gPiA+IDNUQg0KPiA+ID4gPiAtDQo+ID4gPiA+IGFsbCBhcmUgc25hcHNob3RzIGZy
b20gdm13YXJlIHN0b3JlZCB1c2luZyBuYWtpdm8uDQo+ID4gPiA+IA0KPiA+ID4gPiBXb3JraW5n
IHdpdGggZmlsZXN5c3RlbSAtIG1vc3RseSBkZWxldGluZyBmaWxlcyBzZWVtcyB0byBiZQ0KPiA+
ID4gPiB2ZXJ5DQo+ID4gPiA+IHNsb3cgLQ0KPiA+ID4gPiBpdCB0b29rIHNldmVyYWwgaG91cnMg
dG8gZGVsZXRlIHNuYXBzaG90IG9mIG9uZSBtYWNoaW5lLCB3aGljaA0KPiA+ID4gPiBjb25zaXN0
ZWQgb2YgZm91ciBvciBmaXZlIG9mIHRob3NlIDNUQiBmaWxlcy4NCj4gPiA+ID4gDQo+ID4gPiA+
IFdlIHJ1biBiZWVzZCBvbiB0aG9zZSBkYXRhLCBidXQgaSB0aGluaywgdGhlcmUgd2FzIHRoaXMg
bXVjaA0KPiA+ID4gPiBtZXRhZGF0YQ0KPiA+ID4gPiBldmVuIGJlZm9yZSB3ZSBzdGFydGVkIHRv
IGRvIHNvLg0KPiA+ID4gPiANCj4gPiA+ID4gV2l0aCByZWdhcmRzLA0KPiA+ID4gPiBMaWJvcg0K
