Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF522D8626
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Dec 2020 12:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgLLLGN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 12 Dec 2020 06:06:13 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:19025 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbgLLLGN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 12 Dec 2020 06:06:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1607771172; x=1639307172;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ZJsdSXsI4EWX5xoyX2RY9NULfVs7oV4P7a68WZpI7f0=;
  b=RqgEVaXdNcsUGi053s4rRQiq8GUSFPm7Xyf/x8BpL+Eve+98lFFjK9CQ
   zSPs7bzWLa/mp6fegawjqJV+whd0FNEOoTdAIIbhBI9wQNoVsFFb/75d+
   +lSNM0PxYHVWigelSevYYomW8YQvJAiorM4PzOPj2eNUIExhar7mxbTo4
   WFVefJtObEQzZgFIuot5s+GAVcvOmtw0wyELuGwxlWVI4bz/q1YXD23gI
   cUSYPWy28HYlBpvSbWpkfi+eR9m8B9O57RM0VboMtq00yn4OeN6hFizDq
   DphPKTTUMyoVBWgTE0Egotu2B9fwCnKQ7SwkDwIHKaE8FMYH+Qj+iq/9l
   Q==;
IronPort-SDR: ej578rZwNmH1E7ZA54FL9m5T3tzJ2diJWKuTqiHJbQ8eegIZ5yE9w7EfFYbURY6ON6JMv5jrp+
 jwz5jDInPU+I+qufx+cVOK4ezscGZrCydK6Pe8TBpuu0Z9z1XnlGulKlXO66Eih+fsx3sc2w0n
 c9rIdc20OmysSHI3/Nr9hRFqZ29RY/J0o7lCL+tWzYZ4zvYDRfZf+yYakuVk2Qe17FZDpvGc0q
 94IHMQLuxgdu9eokt4jNWqsbP1JWr+KuHOsoL5HaDF7s5GCe1XYOER0FAWYLCYQl57ZvUwqZKB
 bUM=
X-IronPort-AV: E=Sophos;i="5.78,414,1599494400"; 
   d="scan'208";a="154985083"
Received: from mail-dm6nam12lp2173.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.173])
  by ob1.hgst.iphmx.com with ESMTP; 12 Dec 2020 19:05:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QXVdP0kd5FDDIad6rhXetYwP6Yso1vJA+pBOFiMv8+DVli2eOQuhYbka0p4lutY099a92uWtptUig5WHe6chPlO+kwATl35VnCAMn2XytUAIdc/YDVtEFexcKssM6tTkQlub1YJjX0bm42Or2jo3jl/SJbLVQJmWCo25r5x4Ye7/1dN7iHTQAZAcsdxpqDalKxciw/4NtIKc2X9bTOMoMoqO5oj0UCWO3CjFXYF01aVkCkRTRpB+dB0jRb8h4TUq+pMZJeSwFKaPZbisfGLgCpkAQa3ZzQvG93l1idoRfihS9PFkcdJHZXJLmS/EwHGt2PBk1bJtxLTACv0PBzkUXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJsdSXsI4EWX5xoyX2RY9NULfVs7oV4P7a68WZpI7f0=;
 b=AMsWkFBXZmrWqgFCUcJDgnqNH5PTqun2tUz7yxBuRlTG/9UXkjssin+k3v7rG8rveY2ciK5PPZoel4wJ7Xp1NFnwGEO8a62tKVX6d8utpZ6JVgGWeFl4ksGFlmHw8cpOIx39SwG23PGiwzlhEv+27RFf3cnB8gbIzGruv4nGA4Nq+1ZvVRJ7tOE3yWcmfsN/AuWmRXzjdhaOesqRCE8U2Xdj+LuIM6ImvUcUlKb281tiwydr/8I9gAuBKs40b+W6w3sOmsR85rvGdyStaBGDrF6H8JYo0GTV6Eo4Vz2RP+RmNsWTuNmE4J8xb3ERbX9XfDokRGZG8mKr4Ri1i7DVxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJsdSXsI4EWX5xoyX2RY9NULfVs7oV4P7a68WZpI7f0=;
 b=plocZL0mjBRM3hjlWPnNa5CLhZziuz1bR0HRmDf0f6eAlggDgh22qHNxUFevCSJ22iEDBz1NjP9FGeJRVEch2MMCOmJMPf3Cm48C8K1iHgG9ynVC9/Ic1PUGuTd+g29bZS0559a0OArPgDpqOGtgKpdvegLJci/vyn5RMKU8+R0=
Received: from CH2PR04MB6522.namprd04.prod.outlook.com (2603:10b6:610:34::19)
 by CH2PR04MB6712.namprd04.prod.outlook.com (2603:10b6:610:9e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.13; Sat, 12 Dec
 2020 11:05:05 +0000
Received: from CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a]) by CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a%7]) with mapi id 15.20.3632.023; Sat, 12 Dec 2020
 11:05:05 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "g.btrfs@cobb.uk.net" <g.btrfs@cobb.uk.net>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "dsterba@suse.cz" <dsterba@suse.cz>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "realwakka@gmail.com" <realwakka@gmail.com>
Subject: Re: [PATCH] btrfs-progs: scrub: warn if scrub started on a device has
 mq-deadline
Thread-Topic: [PATCH] btrfs-progs: scrub: warn if scrub started on a device
 has mq-deadline
Thread-Index: AQHWyzejusrpHpJPFU6br/aRVTSRlKnzVtcA
Date:   Sat, 12 Dec 2020 11:05:04 +0000
Message-ID: <d3afc9edd13c47b33cf3152e27f10b701a97b77a.camel@wdc.com>
References: <20201205184929.22412-1-realwakka@gmail.com>
         <SN4PR0401MB35981F791C9508429506EDA09BCE0@SN4PR0401MB3598.namprd04.prod.outlook.com>
         <20201210202020.GH6430@twin.jikos.cz>
         <SN4PR0401MB359892AE5C0771A8209A4A559BCA0@SN4PR0401MB3598.namprd04.prod.outlook.com>
         <20201211155348.GK6430@suse.cz>
         <SN4PR0401MB3598ECDD1EE787041F3C328C9BCA0@SN4PR0401MB3598.namprd04.prod.outlook.com>
         <SN4PR0401MB3598DA1476FDAB86BD9EE4559BCA0@SN4PR0401MB3598.namprd04.prod.outlook.com>
         <7d14b742-feef-58b4-97da-45d05132b02e@cobb.uk.net>
         <SN4PR0401MB3598EA952D5F942C165422819BC90@SN4PR0401MB3598.namprd04.prod.outlook.com>
In-Reply-To: <SN4PR0401MB3598EA952D5F942C165422819BC90@SN4PR0401MB3598.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.1 (3.38.1-1.fc33) 
authentication-results: cobb.uk.net; dkim=none (message not signed)
 header.d=none;cobb.uk.net; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:8d3e:27aa:85c2:44b5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 02895887-ef87-411a-06c0-08d89e8dc7b3
x-ms-traffictypediagnostic: CH2PR04MB6712:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR04MB6712C9B3416078ED1487DAA0E7C90@CH2PR04MB6712.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ROhV0YTRSe+c1khDTV6xgbgE+tmezaOzy/Oei9x9olUWLVSpuEs4qDwjVGGcRD52+zroX1STjOiorQ+fAf7971WMz7p0RjRv/6sDAuAEP1pGRfpT4xqkscZcR/KTc5K7iPcLwoRtg8c7G3hoxaRJ0ipAaYgo0febj5fE7jRiG2uwWW4Z7LOHx6rUVjx29JqqIozuJbAWM9sbuBCswNXqOKS+D3N7xWJFhnBV28M5XkMYUzqQDglF/Mkw3Sg0kalMY9smsnwm1cMC/9R3oRr7qwHdjci6EnnD3YZ9HI+rNziLVoT29W37M3af09RjHrCFmazQEX+eORhdQOyH0J3HoA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR04MB6522.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(366004)(53546011)(66556008)(508600001)(4001150100001)(8936002)(2616005)(66946007)(91956017)(8676002)(36756003)(54906003)(76116006)(6506007)(4326008)(6486002)(6512007)(186003)(66476007)(64756008)(71200400001)(110136005)(2906002)(86362001)(83380400001)(5660300002)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?OXFoQmRJcklDMTZUbVdVS09JY25zR1ZlakZkSzN6eWdFd1BRamdUeGI2Y2Nt?=
 =?utf-8?B?Wkg0cUM1dElTMllQc0FjdmJXNEFpalFwTEphWS9MRmRzUldVNnA3RzBjUDlF?=
 =?utf-8?B?cVhHdUsrczVWL1FRdDVDS1RNSzh6L2FGakRrMDA3VHhHRzVpKytMZy82dm1Q?=
 =?utf-8?B?V3hiQkFTNzAxdkdJUUlJMEh6VWEySGREMXRuUDU4c0ZHUnhDRmdZbmpsTXRp?=
 =?utf-8?B?L0ZtMXVwREIzbmUxQm1mTTNNWUZ4K2VhYTZUcjRkTjMyTUhvODJNbUhuQjdV?=
 =?utf-8?B?clkvM3kzd29hS1gwZVFibVpKbjF6bVlwb0NWN3pNWUdkUVhneG5Qa2JvUGNh?=
 =?utf-8?B?YlZCZEJ4TWxaaXRRVlM4dFphVkVvYy9ZWU5sMmdKeTZUM0ZTMFRRaTlZNGE5?=
 =?utf-8?B?TGlPT0xNMDRIemJsVE5IMUtVQldiTEU3dzloeHpCYUl6eHdidTFIQWNKdWJC?=
 =?utf-8?B?YVMyVHZ0cFY4OXM3dHFjSVBnSFI5TTM3TzRxS1MwSVBXODA1WW9BRmsrK1Rl?=
 =?utf-8?B?bXZzU0FvazVLM1c1cGtOZDhpUzZ5TDBnd1hwQ3IxU1d0dWhRYVIraFZoUlVJ?=
 =?utf-8?B?NVM2ZEgvTHc3TE9HNTdNMkE3V3lUVllhRjFDR0w2cWJ3WHFlS0orRGk0OHox?=
 =?utf-8?B?UGFvbzV5VFVWTEgzNmZCdTRRdUhJY2tsQVB2QzJpdStXOE1KYVhMcnBaUWs1?=
 =?utf-8?B?K3F1Y1FGZ3BiRi9DekNJZGhFbkswY0sxTE1jYnpRTWVUZ2dlTTRyajhRNk1j?=
 =?utf-8?B?RjFZdkNKWDQ2SWZDSVIyZ0ZjTzExU1VhZWp4c0lWa2ZwNjV2ZFFZRUNmQVhh?=
 =?utf-8?B?VDVtSExKcjFTS2VJN1hxcUJLdVM5b2NuNjB3c25USG1YY0svZFBzdzlITUFz?=
 =?utf-8?B?bHcxMnQ5VDlSdG9Sb1l4dmJFZWdLa3lJMEQ5U2R1ckpPY3pQVjhMUGpTOHpO?=
 =?utf-8?B?Q1k3d2FRekZuc0t5VHNzU2MxdGo4WVY0enFraTlCbTBFK0tZYTArNjZHWG8y?=
 =?utf-8?B?ekhiMXpZdVRIZjZzR051MnBMNXVvR1YwcUFnbklwRUx6LzdmL256Uk1xYThH?=
 =?utf-8?B?OXRIR2FqOWk2WHl4TXBxWUx2T1NsenVldjVUaFZ6RzNSZjVvV2RYNHEyNGtP?=
 =?utf-8?B?NGc1NkFiQ253VkNjU2R3SFNRR2NlMmc0ckt6T05FU2xGaGEwSEZqMVJHNFNh?=
 =?utf-8?B?OXk1bWt0aldQd2hLdDBkbG1NK3c4ZlR5dDBYRzlLSXJyYWhLWWVMMWxJcFUw?=
 =?utf-8?B?S3pJQ2VYbE1XcWRYelRIVTR6U0xTazdRcWxualY4Ly80dmZCRHdtQnBRSFE0?=
 =?utf-8?B?eldhM0h3UWpCTDNvbFlmUFA4TnByNkdyejhkdmNPZTZ2Y2U0WmtBd3BONnlP?=
 =?utf-8?B?U1BGSEpzK1dBQzFKWXM2ajdKNmxoRk9qVUI2KzFQL0pNRGxQekpPZXA1akx3?=
 =?utf-8?Q?/71+UPqP?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E287352917A3C0418E411B94BC67378D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR04MB6522.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02895887-ef87-411a-06c0-08d89e8dc7b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2020 11:05:04.8521
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kB7WOoSGsK7gcQVUnBo14ztmYEMykBcFUFY4HAc/n6PfSf73LC1iEFqxjhh08/TK+pEW2nVIZ5eBBGWtjzE7dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6712
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gU2F0LCAyMDIwLTEyLTEyIGF0IDEwOjM0ICswMDAwLCBKb2hhbm5lcyBUaHVtc2hpcm4gd3Jv
dGU6DQo+IE9uIDExLzEyLzIwMjAgMTg6MDUsIEdyYWhhbSBDb2JiIHdyb3RlOg0KPiA+IE9uIDEx
LzEyLzIwMjAgMTY6NDIsIEpvaGFubmVzIFRodW1zaGlybiB3cm90ZToNCj4gPiA+IE9uIDExLzEy
LzIwMjAgMTc6MDIsIEpvaGFubmVzIFRodW1zaGlybiB3cm90ZToNCj4gPiA+ID4gWytDYyBEYW1p
ZW4gXQ0KPiA+ID4gPiBPbiAxMS8xMi8yMDIwIDE2OjU1LCBEYXZpZCBTdGVyYmEgd3JvdGU6DQo+
ID4gPiA+ID4gT24gRnJpLCBEZWMgMTEsIDIwMjAgYXQgMDY6NTA6MjNBTSArMDAwMCwgSm9oYW5u
ZXMgVGh1bXNoaXJuIHdyb3RlOg0KPiA+ID4gPiA+ID4gT24gMTAvMTIvMjAyMCAyMToyMiwgRGF2
aWQgU3RlcmJhIHdyb3RlOg0KPiA+ID4gPiA+ID4gPiBPbiBNb24sIERlYyAwNywgMjAyMCBhdCAw
NzoyMzowM0FNICswMDAwLCBKb2hhbm5lcyBUaHVtc2hpcm4gd3JvdGU6DQo+ID4gPiA+ID4gPiA+
ID4gT24gMDUvMTIvMjAyMCAxOTo1MSwgU2lkb25nIFlhbmcgd3JvdGU6DQo+ID4gPiA+ID4gPiA+
ID4gPiBXYXJuIGlmIHNjdXJiIHN0YXJlZCBvbiBhIGRldmljZSB0aGF0IGhhcyBtcS1kZWFkbGlu
ZSBhcyBpby1zY2hlZHVsZXINCj4gPiA+ID4gPiA+ID4gPiA+IGFuZCBwb2ludCBkb2N1bWVudGF0
aW9uLiBtcS1kZWFkbGluZSBkb2Vzbid0IHdvcmsgd2l0aCBpb25pY2UgdmFsdWUgYW5kDQo+ID4g
PiA+ID4gPiA+ID4gPiBpdCByZXN1bHRzIHBlcmZvcm1hbmNlIGxvc3MuIFRoaXMgd2FybmluZyBo
ZWxwcyB1c2VycyBmaWd1cmUgb3V0IHRoZQ0KPiA+ID4gPiA+ID4gPiA+ID4gc2l0dWF0aW9uLiBU
aGlzIHBhdGNoIGltcGxlbWVudHMgdGhlIGZ1bmN0aW9uIHRoYXQgZ2V0cyBpby1zY2hlZHVsZXIN
Cj4gPiA+ID4gPiA+ID4gPiA+IGZyb20gc3lzZnMgYW5kIGNoZWNrIHdoZW4gc2NydWIgc3RhcnMg
d2l0aCB0aGUgZnVuY3Rpb24uDQo+ID4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gRnJv
bSBhIHF1aWNrIGdyZXAgaXQgc2VlbXMgdG8gbWUgdGhhdCBvbmx5IGJmcSBpcyBzdXBwb3J0aW5n
IGlvcHJpbyBzZXR0aW5ncy4NCj4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+IFllYWggaXQn
cyBvbmx5IEJGUS4NCj4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gQWxzbyB0aGVyZSdz
IHNvbWUgZmVhdHVyZXMgbGlrZSB3cml0ZSBvcmRlcmluZyBndWFyYW50ZWVzIHRoYXQgY3VycmVu
dGx5IA0KPiA+ID4gPiA+ID4gPiA+IG9ubHkgbXEtZGVhZGxpbmUgcHJvdmlkZXMuDQo+ID4gPiA+
ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gVGhpcyB3YXJuaW5nIHdpbGwgdHJpZ2dlciBhIGxv
dCBvbmNlIHRoZSB6b25lZCBwYXRjaHNldCBmb3IgYnRyZnMgaXMgbWVyZ2VkLA0KPiA+ID4gPiA+
ID4gPiA+IGFzIGZvciBleGFtcGxlIFNNUiBkcml2ZXMgbmVlZCB0aGlzIG9yZGVyaW5nIGd1YXJh
bnRlZXMgYW5kIHRoZXJlZm9yZSBzZWxlY3QNCj4gPiA+ID4gPiA+ID4gPiBtcS1kZWFkbGluZSAo
dmlhIHRoZSBFTEVWQVRPUl9GX1pCRF9TRVFfV1JJVEUgZWxldmF0b3IgZmVhdHVyZSkuDQo+ID4g
PiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiBUaGlzIHdvbid0IGFmZmVjdCB0aGUgZGVmYXVsdCBj
YXNlIGFuZCBmb3Igem9uZWQgZnMgd2UgY2FuJ3Qgc2ltcGx5IHVzZQ0KPiA+ID4gPiA+ID4gPiBC
RlEgYW5kIHRodXMgdGhlIGlvbmljZSBpbnRlcmZhY2UuIFdoaWNoIHNob3VsZCBiZSBJTUhPIGFj
Y2VwdGFibGUuDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IEJ1dCB0aGVuIHRoZSBwYXRjaCBt
dXN0IGNoZWNrIGlmIGJmcSBpcyBzZXQgYW5kIG90aGVyd2lzZSB3YXJuLiBNeSBvbmx5IGZlYXIN
Cj4gPiA+ID4gPiA+IGlzIHRob3VnaCwgcGVvcGxlIHdpbGwgYmxpbmRseSBzZWxlY3QgYmZxIHRo
ZW4gYW5kIGdldCBhbGwga2luZHMgb2YgDQo+ID4gPiA+ID4gPiBwZW5hbHRpZXMvcHJvYmxlbXMu
DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gSG0gcmlnaHQsIGFuZCB3ZSBrbm93IHRoYXQgb25jZSBz
dWNoIHJlY29tbWVuZGF0aW9ucyBzdGljaywgaXQncyB2ZXJ5DQo+ID4gPiA+ID4gaGFyZCB0byBn
ZXQgcmlkIG9mIHRoZW0gZXZlbiBpZiB0aGVyZSdzIGEgcHJvcGVyIHNvbHV0aW9uIGltcGxlbWVu
dGVkLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gQW5kIGl0J3Mgbm90IG9ubHkgbXEtZGVhZGxp
bmUgYW5kIGJmcSBoZXJlLCB0aGVyZSBhcmUgYWxzbw0KPiA+ID4gPiA+ID4ga3liZXIgYW5kIG5v
bmUuIE9uIGEgZGVjZW50IG52bWUgSSdkIGxpa2UgdG8gaGF2ZSBub25lIGluc3RlYWQgb2YgYmZx
LCBvdGhlcndpc2UNCj4gPiA+ID4gPiA+IHBlcmZvcm1hbmNlIGdvZXMgZG93biB0aGUgZHJhaW4u
IElmIG15IHdvcmtsb2FkIGlzIHNlbnNpdGl2ZSB0byBidWZmZXIgYmxvYXQsIEknZA0KPiA+ID4g
PiA+ID4gdXNlIGt5YmVyIG5vdCBiZnEuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gSSdtIG5vdCBz
dXJlIGFib3V0IGhpZ2ggcGVyZm9ybWFuY2UgZGV2aWNlcyBpZiB0aGUgc2NydWIgaW8gbG9hZCBv
biB0aGUNCj4gPiA+ID4gPiBub3JtYWwgcHJpb3JpdHkgaXMgdGhlIHNhbWUgcHJvYmxlbSBhcyB3
aXRoIHNwaW5uaW5nIGRldmljZXMuIEFzc3VtaW5nDQo+ID4gPiA+ID4gaXQgaXMsIHdlIG5lZWQg
c29tZSBsb3cgcHJpb3JpdHkvaWRsZSBjbGFzcyBmb3IgYWxsIHNjaGVkdWxlcnMgYXQgbGVhc3Qu
DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBTbyBJTUhPIHRoaXMgcGF0Y2gganVzdCBtYWtlcyB0
aGluZ3Mgd29yc2UuIEJ1dCB3aG8gYW0gSSB0byBqdWRnZS4NCj4gPiA+ID4gPiANCj4gPiA+ID4g
PiBJbiB0aGlzIHNpdHVhdGlvbiB3ZSBuZWVkIGJyb2FkZXIgcGVyc3BlY3RpdmUsIHRoYW5rcyBm
b3IgdGhlIGlucHV0LA0KPiA+ID4gPiA+IHdlJ2xsIGhvcGVmdWxseSBjb21lIHRvIHNvbWUgY29u
Y2x1c2lvbi4gV2UgZG9uJ3Qgd2FudCB0byBtYWtlIHRoaW5ncw0KPiA+ID4gPiA+IHdvcnNlLCBu
b3cgd2UncmUgbGVmdCB3aXRoIHdvcmthcm91bmRzIG9yIHdhcm5pbmdzIHVudGlsIHNvbWUgYnJh
dmUgc291bA0KPiA+ID4gPiA+IGltcGxlbWVudHMgdGhlIG1pc3NpbmcgaW8gc2NoZWR1bGVyIGZ1
bmN0aW9uYWxpdHkuDQo+ID4gPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiBJIHRoaW5rIHRoYXQn
cyBhbGwgd2UgY2FuIGRvIG5vdy4NCj4gPiA+ID4gDQo+ID4gPiA+IERhbWllbiAoQ0NlZCkgZGlk
IHNvbWUgd29yayBvbiBtcS1kZWFkbGluZSwgbWF5YmUgaGUgaGFzIGFuIGlkZWEgaWYgdGhpcyBp
cw0KPiA+ID4gPiBwb3NzaWJsZS9kb2FibGUuDQo+ID4gPiA+IA0KPiA+ID4gDQo+ID4gPiBIYSBJ
IGhhdmUgYSBzdG9wIGdhcCBzb2x1dGlvbiwgd2UgY291bGQgdGVtcG9yYXJpbHkgY2hhbmdlIHRo
ZSBpbyBzY2hlZHVsZXIgdG8gYmZxDQo+ID4gPiB3aGlsZSB0aGUgc2NydWIgam9iIGlzIHJ1bm5p
bmcgYW5kIHRoZW4gYmFjayB0byB3aGF0ZXZlciB3YXMgY29uZmlndXJlZC4NCj4gPiA+IA0KPiA+
ID4gT2YgY2F1c2Ugb25seSBpZiBiZnEgc3VwcG9ydHMgdGhlIGVsZXZhdG9yX2ZlYXR1cmVzIHRo
ZSBibG9jayBkZXZpY2UgcmVxdWlyZXMuDQo+ID4gPiANCj4gPiA+IFRob3VnaHRzPw0KPiA+ID4g
DQo+ID4gDQo+ID4gSSB3b3VsZCBwcmVmZXIgeW91IGRpZG4ndCBtZXNzIHdpdGggdGhlIHNjaGVk
dWxlciBJIGhhdmUgY2hvc2VuIChvciBvbmx5DQo+ID4gaWYgYXNrZWQgdG8gd2l0aCBhIG5ldyBv
cHRpb24pLiBNeSBzdWdnZXN0aW9uOg0KPiA+IA0KPiA+IDEuIElmIC1jIG9yIC1uIGhhdmUgYmVl
biBzcGVjaWZpZWQgZXhwbGljaXRseSwgY2hlY2sgdGhlIHNjaGVkdWxlciBhbmQNCj4gPiBlcnJv
ciBpZiBpdCBpcyBrbm93biB0aGF0IGl0IGlzIGluY29tcGF0aWJsZS4NCg0KRWxldmF0b3Igbm90
IGNvbXBhdGlibGUgd2l0aCB6b25lZCBibG9jayBkZXZpY2VzIHdpbGwgbm90IGV2ZW4gYmUgc2hv
d24gaW4NCnN5c2ZzLiBFLmcuIGJmcSBpcyBub3QgZXZlbiBsaXN0ZWQgZm9yIFNNUiBkcml2ZXMu
IFNvIHRoZSB1c2VyL0ZTIGNhbm5vdCBzZWxlY3QNCmEgd3Jvbmcgc2NoZWR1bGVyIGJlc2lkZSAi
bm9uZSIuIEZvciBTTVIsIHRoYXQgY3VycmVudGx5IG1lYW5zIGRlYWRsaW5lIG9ubHkuDQoNCkZv
ciBaTlMsIHRoZSBFTEVWQVRPUl9GX1pCRF9TRVFfV1JJVEUgZmVhdHVyZSBpcyBpZ25vcmVkLCBz
byBhbnkgc2NoZWR1bGVyIGNhbg0KYmUgdXNlZC4gVXNpbmcgb25lIHdvdWxkIG5vdCBiZSBhIGdv
b2QgaWRlYSBpbiBhbnkgY2FzZSwgYnV0IGlmIGJmcSBpcyBuZWVkZWQNCml0IGNhbiBiZSB1c2Vk
OiB3ZSBkbyBub3QgaGF2ZSB0aGUgc2VxdWVudGlhbCB3cml0ZSBjb25zdHJhaW50IHRoYW5rcyB0
byB0aGUNCnVzZSBvZiB6b25lIGFwcGVuZCB3cml0ZXMgb25seSBmb3Igc2VxdWVudGlhbCB6b25l
cy4gDQoNCj4gPiAyLiBJZiAtYy8tbiBoYXZlIG5vdCBiZWVuIHNwZWNpZmllZCwganVzdCB3YXJu
IChub3QgZmFpbCkgaWYgdGhlDQo+ID4gc2NoZWR1bGVyIGlzIGtub3duIHRvIGJlIGluY29tcGF0
aWJsZSB3aXRoIHRoZSBkZWZhdWx0IGlkbGUgY2xhc3MgcmVxdWVzdC4NCj4gPiANCj4gPiAzLiBQ
cm92aWRlIGEgd2F5IHRvIHN1cHByZXNzIHRoZSB3YXJuaW5nIGluIHN0ZXAgMiAoaXMgLXEgZW5v
dWdoLCBvcg0KPiA+IGRvZXMgdGhhdCBhbHNvIHN1cHByZXNzIG90aGVyIHVzZWZ1bC9pbXBvcnRh
bnQgbWVzc2FnZXM/KS4NCj4gPiANCj4gPiA0LiBFeHBhbmQgdGhlIGRlc2NyaXB0aW9uIGluIHRo
ZSBtYW4gcGFnZSB3aGljaCBjdXJyZW50bHkgc2F5cyAiTm90ZQ0KPiA+IHRoYXQgbm90IGFsbCBJ
TyBzY2hlZHVsZXJzIGhvbm9yIHRoZSBpb25pY2Ugc2V0dGluZ3MuIiBJdCBjb3VsZCByZWFkDQo+
ID4gc29tZXRoaW5nIGxpa2U6DQo+ID4gDQo+ID4gIk5vdGUgdGhhdCBub3QgYWxsIElPIHNjaGVk
dWxlcnMgaG9ub3IgdGhlIGlvbmljZSBzZXR0aW5ncy4gQXQgdGltZSBvZg0KPiA+IHdyaXRpbmcs
IG9ubHkgYmZxIGhvbm9ycyB0aGUgaW9uaWNlIHNldHRpbmdzIGFsdGhvdWdoIG5ld2VyIGtlcm5l
bHMgbWF5DQo+ID4gY2hhbmdlIHRoYXQuIEEgd2FybmluZyB3aWxsIGJlIHNob3duIGlmIHRoZSBj
dXJyZW50bHkgc2VsZWN0ZWQgSU8NCj4gPiBzY2hlZHVsZXIgaXMga25vd24gdG8gbm90IHN1cHBv
cnQgaW9uaWNlLiINCj4gPiANCj4gPiANCj4gDQo+IA0KPiBXb3JrcyBmb3IgbWUgYXMgd2VsbC4g
TXkgb25seSBjb25jZXJuIGlzLCBwZW9wbGUgd2lsbCBkZWZhdWx0IHRvIGJmcSBhbmQgdGhlbiAN
Cj4gY29tcGxhaW4gZm9yIFhZIGJlY2F1c2Ugb2YgdGhlIGNoYW5nZSB0byBiZnEuIE5vdGUsIEkn
bSBub3QgYWdhaW5zdCBiZnEgYXQgYWxsLA0KPiBJJ20ganVzdCBhcmd1aW5nIGl0J3Mgbm90IGEg
b25lIHNpemUgZml0cyBhbGwgZGVjaXNpb24uDQo+IA0KPiBJJ2QgYWxzbyBsaWtlIHRvIHNlZSBp
ZiBzY3J1YiBvbiBhIG52bWUgcmVhbGx5IGlzIGJlbmVmaWNpYWwgd2l0aCBiZnEgaW5zdGVhZCBv
Zg0KPiBub25lLiBJIGhhdmUgbXkgZG91YnQncyBidXQgdGhhdCdzIGEgZ3V0IGZlZWxpbmcgYW5k
IEkgaGF2ZSBubyBudW1iZXJzIHRvIGJhY2sgdXANCj4gdGhpcyBzdGF0ZW1lbnQuDQo+IA0KPiBO
aWNlIHdlZWtlbmQsDQo+IAlKb2hhbm5lcw0KPiANCg0KLS0gDQpEYW1pZW4gTGUgTW9hbA0KV2Vz
dGVybiBEaWdpdGFsDQo=
