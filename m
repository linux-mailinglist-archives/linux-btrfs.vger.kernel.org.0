Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89D959E688
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2019 13:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfH0LLu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Aug 2019 07:11:50 -0400
Received: from mail-oln040092071093.outbound.protection.outlook.com ([40.92.71.93]:47846
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726125AbfH0LLu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Aug 2019 07:11:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UqiyoCWuCZ+bi26zYA+uJFMvgt2qR4bKptYXmjq+HMRuaXif9z7bNw+RHZgvkElrSTdR8TnLwsZJ62U31gXJAsCbQE2bWYhcRHjuX91UM+XzGtU35FVN2nx5TUhxnubm7wEmHV/ZBC5MT9lb4EaSZIhQHc1sXiNKLq1cYDoR6VIbIv+kFogFvjGZxZdOIw9UxjknqXrRRYs8zfhNaAmuVqEZ8St8KLOARPFqJVT/dHYu+cOKxt4Z0Luck4ljwROa5Kh3AEFGnnV2WihQ1DTLfoG8INAirej1FXqFYlVBlylJBd+ZjW0y0oegpZ1kTzNJZUuiz/d3Ar3lcwn7mdSZOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mjg/0RkY9klOKk6gvLNvi1yn0s3umlmMySXNdN0v2sE=;
 b=H48d+xhJtCYDbj3kv//UnTF2MBetLRBk3CcopOnDbttHzk+ePDkx5saztHACEczUDwyWH+bDV1cEwBQoGWTB+yD4lTPm+phbRBhSjN/JQCEZXOZ62oZIYFSeuXDRVm5qlHGJsFE8AIVuHJEhgjyqei5oMJEbmeHHObx2Z/ucCLoXQ++FLOxFbnXxAYzSUI/iZuyiwSCTMPaFqXv7pLOv70xu5JdODFZvTjLaWQ7EY34POhcTJeUTceLXtP/lwSAUEeQNrKKJ0ZHUjaXW5xS+LKdgcOb0gQ9FfBV2IpgYUrRB7s0PQ/6sUDM7Br7qXZDI0XGfwouXtnHi4IEGF2OCzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AM5EUR03FT059.eop-EUR03.prod.protection.outlook.com
 (10.152.16.52) by AM5EUR03HT204.eop-EUR03.prod.protection.outlook.com
 (10.152.17.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2199.13; Tue, 27 Aug
 2019 11:11:46 +0000
Received: from DB7P191MB0377.EURP191.PROD.OUTLOOK.COM (10.152.16.58) by
 AM5EUR03FT059.mail.protection.outlook.com (10.152.17.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.13 via Frontend Transport; Tue, 27 Aug 2019 11:11:46 +0000
Received: from DB7P191MB0377.EURP191.PROD.OUTLOOK.COM
 ([fe80::bc80:8fa0:42bd:4be5]) by DB7P191MB0377.EURP191.PROD.OUTLOOK.COM
 ([fe80::bc80:8fa0:42bd:4be5%5]) with mapi id 15.20.2199.021; Tue, 27 Aug 2019
 11:11:46 +0000
From:   Alberto Bursi <alberto.bursi@outlook.it>
To:     =?utf-8?B?U3fDom1pIFBldGFyYW1lc2g=?= <swami@petaramesh.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     Christoph Anton Mitterer <calestyo@scientia.net>
Subject: Re: Massive filesystem corruption since kernel 5.2 (ARCH)
Thread-Topic: Massive filesystem corruption since kernel 5.2 (ARCH)
Thread-Index: AQHVWqS22gbHP/giy0mM/nLVdqYtGacLopmAgAJ9HICAAFVBgIAAErQAgAACbYCAAE2mAIAAA4SA
Date:   Tue, 27 Aug 2019 11:11:46 +0000
Message-ID: <DB7P191MB0377516063743C8D5A382C4292A00@DB7P191MB0377.EURP191.PROD.OUTLOOK.COM>
References: <11e4e889f903ddad682297c4420faeb0245414cf.camel@scientia.net>
 <18d24f2f-4d33-10aa-5052-c358d4f7c328@petaramesh.org>
 <a8968a812e270a0dd80c4cf431a8437d3a7daba5.camel@scientia.net>
 <5aefca34-224a-0a81-c930-4ccfcd144aef@petaramesh.org>
 <4bd70aa2-7ad0-d5c6-bc1f-22340afaac60@petaramesh.org>
 <370697f1-24c9-c8bd-01a7-c2885a7ece05@gmx.com>
 <fcd2e070-67e9-4889-f778-748070cc9856@petaramesh.org>
In-Reply-To: <fcd2e070-67e9-4889-f778-748070cc9856@petaramesh.org>
Accept-Language: it-IT, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MR2P264CA0042.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500::30)
 To DB7P191MB0377.EURP191.PROD.OUTLOOK.COM (2603:10a6:5:10::13)
x-incomingtopheadermarker: OriginalChecksum:4DA6B42CEEF22B9E22086133C4F01907C16FB78762FEEB0338874032F5FEC762;UpperCasedChecksum:634C978C6B25764C2AC58379B87C5B55E20CFC79095921E95AD2CA9FA13FAA9C;SizeAsReceived:7939;Count:49
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [yZ9m410rPSZB+bpNRTfbixBsKBR22lnM]
x-microsoft-original-message-id: <45f95585-a92b-bb87-4812-b6596a87741f@outlook.it>
x-ms-publictraffictype: Email
x-incomingheadercount: 49
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(5050001)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031322404)(2017031323274)(2017031324274)(1601125500)(1603101475)(1701031045);SRVR:AM5EUR03HT204;
x-ms-traffictypediagnostic: AM5EUR03HT204:
x-microsoft-antispam-message-info: rwVieqRj+iGiNSDdM7pVrg8ErA7gLkBO0Y+P9SpI9X5yMB2aFmmhvlJJ0LGKTQxZiqk5HTAH3ei/zN+NLqJPYu2cZrpD2Sg6E6Z9uqCSiw9Ojn3pEv7lfeDiqg75D1vh9ozBkpOu34RopGojRYwXgQQAJC08LmmuR4gkbs6US5C12GKvPIRHoAZsgD4dLOGE
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <3574C567E4C7B84FB1F033AD22A79C7B@EURP191.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: c60a6225-68cc-45bc-fad2-08d72adf590e
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2019 11:11:46.7805
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5EUR03HT204
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

DQpPbiAyNy8wOC8xOSAxMjo1OSwgU3fDom1pIFBldGFyYW1lc2ggd3JvdGU6DQo+DQo+DQo+IFNv
IGl0IHNlZW1zIHRoYXQgbW91bnRpbmcgd2l0aCDigJxjbGVhcl9jYWNoZeKAnSBkaWQgbm90IGFj
dHVhbGx5IGNsZWFyIHRoZQ0KPiBjYWNoZSBhbmQgZml4IHRoZSBpc3N1ZSA/DQo+DQo+IOClkA0K
Pg0KDQptb3VudGluZyB3aXRoIGNsZWFyX2NhY2hlIGRvZXMgbm90IGFjdHVhbGx5IGNsZWFyIGNh
Y2hlDQoNCnVubGVzcyBpdCBpcyBuZWVkZWQgb3IgbW9kaWZpZWQgb3Igc29tZXRoaW5nLg0KDQoN
CklmIHlvdSB3YW50IHRvIGZ1bGx5IGNsZWFyIGNhY2hlIHlvdSBuZWVkIHRvIHVzZSAob24gYW4g
dW5tb3VudGVkIA0KZmlsZXN5c3RlbSkNCg0KYnRyZnMgY2hlY2sgLS1jbGVhci1zcGFjZS1jYWNo
ZSB2MSAvZGV2L3NkWA0KDQpvcg0KDQpidHJmcyBjaGVja8KgIC0tY2xlYXItc3BhY2UtY2FjaGUg
djIgL2Rldi9zZFgNCg0KZGVwZW5kaW5nIG9uIHdoYXQgc3BhY2UgY2FjaGUgeW91IHVzZWQgKHYx
IGlzIGRlZmF1bHQpDQoNCg0KLUFsYmVydG8NCg0K
