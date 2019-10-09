Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6723D0E78
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2019 14:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730606AbfJIMPF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Oct 2019 08:15:05 -0400
Received: from m4a0039g.houston.softwaregrp.com ([15.124.2.85]:49134 "EHLO
        m4a0039g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727219AbfJIMPF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 9 Oct 2019 08:15:05 -0400
Received: FROM m4a0039g.houston.softwaregrp.com (15.120.17.146) BY m4a0039g.houston.softwaregrp.com WITH ESMTP;
 Wed,  9 Oct 2019 12:13:55 +0000
Received: from M9W0068.microfocus.com (2002:f79:bf::f79:bf) by
 M4W0334.microfocus.com (2002:f78:1192::f78:1192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Wed, 9 Oct 2019 12:14:40 +0000
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (15.124.72.12) by
 M9W0068.microfocus.com (15.121.0.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Wed, 9 Oct 2019 12:14:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HWYuqBaDlY2MWvmTdVYRFSsbWHjjvYvObxnjXZo67+6feXZKk+q7rYjKr4tcZLlxUMvDIfZunOw1QKBzQOkcZ2AITE5iLUZwIWqEbRCatzsihOclCnfxWBwANYLg3dNm+zCndGzVoWynOte+hHR0KSDM0xrGjqR4yU7xS006ul0+wiO3fej4d88dLH6qBRw1jiPRdytjbDD/apogXhAE2j+gXLLN5hKrYg7TQK7xOEAyAP2PJuuu6F32J1jKQcSGTkyL8oaHwD51qBM6fCEBrJuLRqh2V9GyHmtok5t2lMAMqmBhBuc8Grrem3QeBCjYlmlFcr0k1D3TTG/b5yqdDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0l9KqpjbDv8G50ntMbAIZ/sG3uRwknBpp6PKQCDsrQQ=;
 b=EoHIQJQTukGpr4NIEHdNBgvmr5xnvnFrDZdljo5LLLn6/4AVFCmK3X1ftJaIS5E+7RevirJ7rjHKbzOA+Fc5Jxq3tmLEKT5ottvp5UeHXAiMhUHNOqQww8zm+RA0Z+YFiJ9TFx3TN7B9T78oJBSa1vIWoF2C2iSHmXCq1vWx60eVxp8uvYGNTXY8HZSckBewzaHAlRKOuyMaiLerXha+wneCI2b4S+EZKntm3n0ds5Qy963RIfK9af/I3lr07U1Wq9fPUWA16OUKDrPtzdAfuNj/9SwGmPdvdewJHp6+wXFwr+yucCw6mQAV6F98w1T161qJlr1z2FbKsrE5CFfmXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from BY5PR18MB3266.namprd18.prod.outlook.com (10.255.163.207) by
 BY5PR18MB3187.namprd18.prod.outlook.com (10.255.139.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Wed, 9 Oct 2019 12:14:39 +0000
Received: from BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::5c5:8dae:70ef:a254]) by BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::5c5:8dae:70ef:a254%4]) with mapi id 15.20.2327.026; Wed, 9 Oct 2019
 12:14:39 +0000
From:   Qu WenRuo <wqu@suse.com>
To:     Anand Jain <anand.jain@oracle.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] btrfs: block-group: Refactor
 btrfs_read_block_groups()
Thread-Topic: [PATCH v2 1/3] btrfs: block-group: Refactor
 btrfs_read_block_groups()
Thread-Index: AQHVfpo8aUlS45rGKE+U7HfMBse6T6dSOPeA
Date:   Wed, 9 Oct 2019 12:14:38 +0000
Message-ID: <7ad1bf89-2217-6b48-749a-af4cb47b7447@suse.com>
References: <20191008044909.157750-1-wqu@suse.com>
 <20191008044909.157750-2-wqu@suse.com>
 <d4b783b7-6706-e32e-d57e-946b27a8d833@oracle.com>
In-Reply-To: <d4b783b7-6706-e32e-d57e-946b27a8d833@oracle.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: TY1PR01CA0139.jpnprd01.prod.outlook.com
 (2603:1096:402:1::15) To BY5PR18MB3266.namprd18.prod.outlook.com
 (2603:10b6:a03:1a1::15)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=wqu@suse.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [13.231.109.76]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 76128cc6-e1ab-4c59-31c7-08d74cb241bf
x-ms-traffictypediagnostic: BY5PR18MB3187:
x-microsoft-antispam-prvs: <BY5PR18MB318796FF718B6580F5DFB6ECD6950@BY5PR18MB3187.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 018577E36E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(346002)(136003)(39860400002)(396003)(376002)(199004)(189003)(54534003)(81166006)(81156014)(66066001)(6916009)(7736002)(6486002)(102836004)(36756003)(14444005)(256004)(8936002)(71190400001)(305945005)(5660300002)(71200400001)(8676002)(316002)(2616005)(11346002)(14454004)(76176011)(478600001)(52116002)(486006)(99286004)(446003)(476003)(6246003)(2906002)(186003)(86362001)(386003)(6512007)(6436002)(6506007)(31686004)(4326008)(31696002)(53546011)(25786009)(6116002)(3846002)(66556008)(64756008)(66446008)(66476007)(26005)(229853002)(66946007);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR18MB3187;H:BY5PR18MB3266.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vf59w+8GxBJZChi7Y1790moXd0dobERK+xuoguVFt5b6vvxWxyssN8fqNILPmnufZGpJcD7T5Fxkbn76zePkCj0dV20XnGFx58JKGG+N+NcJzUOsVcv62nYQaC5S6R6293iU16UcOsMI0kGBUTOXiM9n7zILz5EUYgYc7ddfnrWVAi/Y2GG+pqyCrd7B1zCt26Yj0IItLvP6PzkWEmyFzSck6+gANGSaRC7KqXCsvDY1UxnNXgbg45sm7orF9AHzcG0+o5bzBTC/w+xGxlM3Dg/av/3mUyjQxPh/S50D9hEWnHl6FbCUTkyU/ytYl81lH/fX93kUNdLjX18ga7aqC7FXG07EDnAN2LIOnBsG+3z4qyvjfew9dC0ymduwDeNeddReiz+t4zjxLPNih1IA4LAUWD9KAI51/tlIIu2vL5Q=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <7CFB7A4A262C00408ADA77DBD284AE62@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 76128cc6-e1ab-4c59-31c7-08d74cb241bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2019 12:14:38.8742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ML7EwUGddrTrqCwnEZw3G0dQKBIRuTKYhKNiZuyxU0PiM03vglLgzIVqkjp0Jtm6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3187
X-OriginatorOrg: suse.com
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

DQoNCk9uIDIwMTkvMTAvOSDkuIvljYg4OjA4LCBBbmFuZCBKYWluIHdyb3RlOg0KPiBPbiAxMC84
LzE5IDEyOjQ5IFBNLCBRdSBXZW5ydW8gd3JvdGU6DQo+PiBSZWZhY3RvciB0aGUgd29yayBpbnNp
ZGUgdGhlIGxvb3Agb2YgYnRyZnNfcmVhZF9ibG9ja19ncm91cHMoKSBpbnRvIG9uZQ0KPj4gc2Vw
YXJhdGUgZnVuY3Rpb24sIHJlYWRfb25lX2Jsb2NrX2dyb3VwKCkuDQo+Pg0KPj4gVGhpcyBhbGxv
d3MgcmVhZF9vbmVfYmxvY2tfZ3JvdXAgdG8gYmUgcmV1c2VkIGZvciBsYXRlciBCR19UUkVFIGZl
YXR1cmUuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogUXUgV2VucnVvIDx3cXVAc3VzZS5jb20+DQo+
IA0KPiBOaXQ6IENoYW5nZSBsb2cgZGlkbid0IG1lbnRpb24gYWJvdXQgdGhpbmdzIHdoaWNoIGlz
IGFsc28gZml4ZWQgaGVyZS4NCj4gwqAxLiBUaGUgaW5jb21wYXRpYmxlIGZlYXR1cmUgY2hlY2sg
Y2xlYW51cHMuDQo+IA0KPiArwqDCoMKgwqDCoMKgIGludCBtaXhlZCA9IGJ0cmZzX2ZzX2luY29t
cGF0KGluZm8sIE1JWEVEX0dST1VQUyk7DQo+IA0KPiDCoDIuIFRoZSBidWcgd2UgZmFpbGVkIHRv
IGNhbGwgImJ0cmZzX3B1dF9ibG9ja19ncm91cChjYWNoZSk7IiBhdCBbMV0NCj4gDQo+IC0tLS0t
LS0tLS0tLS0tLS0tDQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmICghbWl4ZWQg
JiYNCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAoKGNhY2hlLT5mbGFn
cyAmIEJUUkZTX0JMT0NLX0dST1VQX01FVEFEQVRBKSAmJg0KPiAtwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIChjYWNoZS0+ZmxhZ3MgJiBCVFJGU19CTE9DS19HUk9VUF9EQVRB
KSkpIHsNCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJ0
cmZzX2VycihpbmZvLA0KPiAtImJnICVsbHUgaXMgYSBtaXhlZCBibG9jayBncm91cCBidXQgZmls
ZXN5c3RlbSBoYXNuJ3QgZW5hYmxlZCBtaXhlZA0KPiBibG9jayBncm91cHMiLA0KPiAtwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBjYWNoZS0+a2V5Lm9iamVjdGlkKTsNCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHJldCA9IC1FSU5WQUw7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCA8LS0tLSBbMV0NCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
YnRyZnNfaXRlbV9rZXlfdG9fY3B1KHBhdGgtPm5vZGVzWzBdLCAma2V5LA0KPiBwYXRoLT5zbG90
c1swXSk7DQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldCA9IHJlYWRfb25lX2Js
b2NrX2dyb3VwKGluZm8sIHBhdGgsIG5lZWRfY2xlYXIpOw0KPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBpZiAocmV0IDwgMCkNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBnb3RvIGVycm9yOw0KPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB9DQo+IC0tLS0tLS0tLS0tLS0tLS0tDQoNClRoYW5rcyBmb3IgY2F0Y2hpbmcgdGhhdCEN
Cg0KSW4gZmFjdCBJIHJlbWVtYmVyZWQgSSBmaXhlZCBhbiBlcnJvciBvdXQgcHJvYmxlbSwgYnV0
IGJ5IHNvbWVob3cgSQ0KZGlkbid0IGZvdW5kIGl0IGluIHRoZSBwYXRjaC9kaWZmLg0KDQpJJ2xs
IHNlbmQgb3V0IGEgc21hbGwgdXBkYXRlIGZvciB0aGlzIG9uZSBhbmQgdXBkYXRlIG15IGdpdGh1
YiBicmFuY2guDQoNClRoYW5rcywNClF1DQo+IA0KPiBPdGhlcndpc2UgbG9va3MgZ29vZC4NCj4g
DQo+IFJldmlld2VkLWJ5OiBBbmFuZCBKYWluIDxhbmFuZC5qYWluQG9yYWNsZS5jb20+DQo+IA0K
PiBUaGFua3MsIEFuYW5kDQo+IA0K
