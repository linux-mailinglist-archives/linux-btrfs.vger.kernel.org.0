Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6DEE9E6C0
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2019 13:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbfH0L3s (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Aug 2019 07:29:48 -0400
Received: from mail-oln040092071021.outbound.protection.outlook.com ([40.92.71.21]:32263
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725793AbfH0L3s (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Aug 2019 07:29:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nBjtZSDAapG71g/EayM2k5oTBEOcT8/SVnGWh0Pl7JcD1LXgoxiQksYnNaOCdXLD3MlXPxxGe+jBTjrtdf+3za5Vu73Pad6da9Kk7dKSh19O4gaU5bJgeUfqvUgMJ/1QhxNFkrlUD/r+R0WYUyhw6vIrG9sI8huVg8qPCSm3iJDTmp8dBEFSYymGBqz7lk1kXwl+5oBCH9efOiPdjDNaXzqbOUVxr+32QcRZ8Rd+kudko8N8jLRuA9Umy8v37LNowOcPchFIgv/GoC2C7ngu3h0YPgWwMQM5d8qhEe/216e3EQTgfd44x2Ah/FZcErDWUcR8yvc+7P8pLEa1gow+FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SqYKiwXO2hZjWNzxuwY/OgKBKzNzUTL4l/OL+7Dvkjg=;
 b=Vjx0oNyFrZDzISxM6Ktq8b0MA2sg9KzHX73FcLW/b5m6kyjy0Tf5X9kMLj582O7ufBwpPm3Afk++EDBMFafB8m2cpKLW/R9OL1VF1cIv+ZTAUmqBP2SBDoCno/AaO1we3ypwGC/+Txe4gNp8JNpY65RAZ0Z/0OD7+tcf/AE3Yplb91zNcTM6/gol4rxqJDyWUNEf0yZUUaefqZaFGpFuPN+aPIHpkY9279b3KXCXW1IAYsX7POv0Ky4WyznIeq2r+XGCu6QC14R40AHe6Wi0DOM5HraUwhhGibffife5dWlERubiduiEgOVZk91HBifaHyGSj626EW1Y8ublqlrADw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DB5EUR03FT019.eop-EUR03.prod.protection.outlook.com
 (10.152.20.54) by DB5EUR03HT179.eop-EUR03.prod.protection.outlook.com
 (10.152.21.247) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2199.13; Tue, 27 Aug
 2019 11:29:45 +0000
Received: from DB7P191MB0377.EURP191.PROD.OUTLOOK.COM (10.152.20.53) by
 DB5EUR03FT019.mail.protection.outlook.com (10.152.20.163) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2199.13 via Frontend Transport; Tue, 27 Aug 2019 11:29:45 +0000
Received: from DB7P191MB0377.EURP191.PROD.OUTLOOK.COM
 ([fe80::bc80:8fa0:42bd:4be5]) by DB7P191MB0377.EURP191.PROD.OUTLOOK.COM
 ([fe80::bc80:8fa0:42bd:4be5%5]) with mapi id 15.20.2199.021; Tue, 27 Aug 2019
 11:29:44 +0000
From:   Alberto Bursi <alberto.bursi@outlook.it>
To:     =?utf-8?B?U3fDom1pIFBldGFyYW1lc2g=?= <swami@petaramesh.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     Christoph Anton Mitterer <calestyo@scientia.net>
Subject: Re: Massive filesystem corruption since kernel 5.2 (ARCH)
Thread-Topic: Massive filesystem corruption since kernel 5.2 (ARCH)
Thread-Index: AQHVWqS22gbHP/giy0mM/nLVdqYtGacLopmAgAJ9HICAAFVBgIAAErQAgAACbYCAAE2mAIAAA4SAgAACQwCAAALEAA==
Date:   Tue, 27 Aug 2019 11:29:44 +0000
Message-ID: <DB7P191MB0377D8AA890573819E717F3192A00@DB7P191MB0377.EURP191.PROD.OUTLOOK.COM>
References: <11e4e889f903ddad682297c4420faeb0245414cf.camel@scientia.net>
 <18d24f2f-4d33-10aa-5052-c358d4f7c328@petaramesh.org>
 <a8968a812e270a0dd80c4cf431a8437d3a7daba5.camel@scientia.net>
 <5aefca34-224a-0a81-c930-4ccfcd144aef@petaramesh.org>
 <4bd70aa2-7ad0-d5c6-bc1f-22340afaac60@petaramesh.org>
 <370697f1-24c9-c8bd-01a7-c2885a7ece05@gmx.com>
 <fcd2e070-67e9-4889-f778-748070cc9856@petaramesh.org>
 <DB7P191MB0377516063743C8D5A382C4292A00@DB7P191MB0377.EURP191.PROD.OUTLOOK.COM>
 <82263aa3-bc0c-8b45-e5e5-ed38f7c00058@petaramesh.org>
In-Reply-To: <82263aa3-bc0c-8b45-e5e5-ed38f7c00058@petaramesh.org>
Accept-Language: it-IT, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MR2P264CA0013.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:1::25) To DB7P191MB0377.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:5:10::13)
x-incomingtopheadermarker: OriginalChecksum:411AA2BCDD2E014B05AC26B4775006DC261738608A1C90FA449AA362A7F75B75;UpperCasedChecksum:A0EA3431FD3E53DCE0386E3D1802892B049F16CC8E17728667204D8BE0FC89B2;SizeAsReceived:8065;Count:49
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [qv4jWOOMgyJacTlhzJs2D/FP20Px1gtg]
x-microsoft-original-message-id: <0f498bcf-ee3d-0687-4655-f72576aa9ed9@outlook.it>
x-ms-publictraffictype: Email
x-incomingheadercount: 49
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(5050001)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031322404)(2017031323274)(2017031324274)(1601125500)(1603101475)(1701031045);SRVR:DB5EUR03HT179;
x-ms-traffictypediagnostic: DB5EUR03HT179:
x-microsoft-antispam-message-info: NFpQ4dndfjqEIvtNDzqDYPz2JAQXicPMqh6qXAObEVGhcdqhCewmTgS5HlWlc9L9PieT2kucn4s9i9k0EQrckCXUJ/KlJ1IKkxt5+H9HEhhWhfJHHt6DgxfXcuTQRZYWK4kmu9m0jC1fpUVQE2pi7ZcA6vjMuPSNiT/i7iGDAZ6sdExwqc6dFe+e9205NXRn
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <07CB6E722BE4F946B1532DE4A13C1532@EURP191.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: bf8256e2-6a82-4d5d-2a12-08d72ae1dbf9
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2019 11:29:44.7689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5EUR03HT179
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

DQpPbiAyNy8wOC8xOSAxMzoyMCwgU3fDom1pIFBldGFyYW1lc2ggd3JvdGU6DQo+IExlIDI3LzA4
LzIwMTkgw6AgMTM6MTEsIEFsYmVydG8gQnVyc2kgYSDDqWNyaXTCoDoNCj4+DQo+PiBidHJmcyBj
aGVjayAtLWNsZWFyLXNwYWNlLWNhY2hlIHYxIC9kZXYvc2RYDQo+IOKAnEJhZCBvcHRpb27igJ0g
KGV2ZW4gd2l0aCBfIGluc3RlYWQgb2YgLSBhbmQgYmV0d2VlbiBvcHRpb24gYW5kIHYxIG9yIFYy
Li4uDQo+DQo+IOClkA0KPg0KDQpIZXJlIG9uIG15IHVwLXRvLWRhdGUgT3BlblNVU0UgVHVtYmxl
d2VlZCBzeXN0ZW0gaXQgd29ya3MuDQoNCihkb2luZyB0aGlzIG9uIGEgcmFuZG9tIGZsYXNoIGRy
aXZlIEkganVzdCBmb3JtYXR0ZWQpDQoNCmhwcHJvYm9vazovaG9tZS9hbGJ5ICMgYnRyZnMgY2hl
Y2sgLS1jbGVhci1zcGFjZS1jYWNoZSB2MSAvZGV2L3NkZDENCk9wZW5pbmcgZmlsZXN5c3RlbSB0
byBjaGVjay4uLg0KQ2hlY2tpbmcgZmlsZXN5c3RlbSBvbiAvZGV2L3NkZDENClVVSUQ6IGY2OWE4
NmNlLTdhYWEtNGM5ZC1hNmRkLTRjOGZmMDkyMDA3Zg0KRnJlZSBzcGFjZSBjYWNoZSBjbGVhcmVk
DQoNCi1BbGJlcnRvDQoNCg==
