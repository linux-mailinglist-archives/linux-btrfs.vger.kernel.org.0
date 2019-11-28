Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC51910C8BF
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Nov 2019 13:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfK1Mfh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Nov 2019 07:35:37 -0500
Received: from m4a0039g.houston.softwaregrp.com ([15.124.2.85]:32835 "EHLO
        m4a0039g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726227AbfK1Mfh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Nov 2019 07:35:37 -0500
Received: FROM m4a0039g.houston.softwaregrp.com (15.120.17.147) BY m4a0039g.houston.softwaregrp.com WITH ESMTP;
 Thu, 28 Nov 2019 12:30:43 +0000
Received: from M4W0335.microfocus.com (2002:f78:1193::f78:1193) by
 M4W0335.microfocus.com (2002:f78:1193::f78:1193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Thu, 28 Nov 2019 12:30:47 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (15.124.8.10) by
 M4W0335.microfocus.com (15.120.17.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Thu, 28 Nov 2019 12:30:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GFOHM1mpNQVOLu18G8ORY3V7IdOIEnrcpyJyJcLWtghtmrHzw1fIndURN9GUc0Ms7T1g7HDiRCBrLcLLO8wLxymAWpECSpdTkOIxNMbnEh2RGZEIUTsnKUpqyjyajCWeFKvwizHvr5PNplbgGW8OVUzjlHjhslF46k7VfPrZV3YdJMrtI6fASLwOnoePx0LxkWoDQt5gFfwi/08C4RZzcVH4UfRZBj3Y1rrg5fZCrnlPhUzwRS7CU/a1DeV86bXxJ5NUEc0U2MuvRCtr2M0CL6xA/lqjRCy2QeZ+zYBNIlQIYsAeaftfo/2oyf/JEaIC6AEZblIY0wnm6yKgzt1PCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=82wOsJWRLsAw8WFVdlp0UHjTU+JjI/jcu+FurYlni9s=;
 b=PmHqiK6Jex5DaMX40nN3Q0MC2YiFcUxGOyHiP74QsRjMcLCj2OPGt2ZVA9oi9CuAxekoCJIAdN2XlOfKr96CIj9VPaApynwHbBnKtXVmevhLBJReKxZYXc8XpM1j7l9dn5y6Aio9WWOT3ZI8x27U34jgBbly+ZKu7y5dzOUTqMqjnODtA+pCnqD0w/OZAth45Qs1A1VWDxd5biB55yKTiC6YHXK1K/MYcvnCE9F4AEOhQDMC3uqiXbwTcmzi95XLhBMJI/KDdp+8m5VFr21KzNqu8A/mZtNm9i6IZ5n82/hzccjJl102QxpFlg+murFCy+GKfCdtnoxrW8sZc4nn9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from DM6PR18MB3274.namprd18.prod.outlook.com (10.255.173.147) by
 DM6PR18MB2521.namprd18.prod.outlook.com (20.179.105.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18; Thu, 28 Nov 2019 12:30:47 +0000
Received: from DM6PR18MB3274.namprd18.prod.outlook.com
 ([fe80::ac64:ba52:22b9:a6be]) by DM6PR18MB3274.namprd18.prod.outlook.com
 ([fe80::ac64:ba52:22b9:a6be%5]) with mapi id 15.20.2495.014; Thu, 28 Nov 2019
 12:30:46 +0000
From:   Qu WenRuo <wqu@suse.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 3/3] btrfs: volumes: Allocate degraded chunks if rw
 devices can't fullfil a chunk
Thread-Topic: [PATCH 3/3] btrfs: volumes: Allocate degraded chunks if rw
 devices can't fullfil a chunk
Thread-Index: AQHVnsFex7ovTGKTKUyO5+dDNNJ/QaeSTmKAgA0kZ4CAAEa+gIAAxdqAgAASYwA=
Date:   Thu, 28 Nov 2019 12:30:46 +0000
Message-ID: <366d5a96-4670-5839-6bef-e8d3a77fd00b@suse.com>
References: <20191107062710.67964-1-wqu@suse.com>
 <20191107062710.67964-4-wqu@suse.com>
 <6cc25dbd-55e4-43bb-7b95-86c62bee27c7@oracle.com>
 <f928122d-4e77-e83b-9a53-d2eea7ee16d3@gmx.com>
 <20191127192329.GA2734@twin.jikos.cz>
 <8c0a2816-1a7d-7d75-f591-c8712a85efd5@gmx.com>
 <20191128112449.GF2734@twin.jikos.cz>
In-Reply-To: <20191128112449.GF2734@twin.jikos.cz>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: TY2PR01CA0018.jpnprd01.prod.outlook.com
 (2603:1096:404:a::30) To DM6PR18MB3274.namprd18.prod.outlook.com
 (2603:10b6:5:1c7::19)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=wqu@suse.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [13.231.109.76]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2f637854-2dd0-49e8-1623-08d773fecb06
x-ms-traffictypediagnostic: DM6PR18MB2521:
x-microsoft-antispam-prvs: <DM6PR18MB2521117915DAD7F8F8675F3CD6470@DM6PR18MB2521.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0235CBE7D0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(39860400002)(396003)(366004)(346002)(136003)(189003)(199004)(2616005)(53546011)(8936002)(14454004)(6506007)(2501003)(81156014)(52116002)(8676002)(36756003)(81166006)(386003)(7736002)(478600001)(6116002)(31686004)(316002)(6246003)(110136005)(66066001)(6512007)(3846002)(305945005)(26005)(6486002)(2906002)(186003)(102836004)(25786009)(86362001)(5660300002)(229853002)(76176011)(66476007)(11346002)(66446008)(446003)(71190400001)(71200400001)(66946007)(99286004)(31696002)(64756008)(256004)(66556008)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR18MB2521;H:DM6PR18MB3274.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: thY3K9IhYgpq/NfWuI5sihTSdjoj4PUPXwllHFY0srswzdUueHfctH0/FzyBL7YqLnVvdQwHYrBk6TY2lxk3HUYHl7FskXUONkVbVqD8nT2C86EIwo7RkQ6RTzhcNRj/i7Eox4E9A8Nc4A38Angs3fr7iEIMOSE6HQr7n9RUOTJMS0lgvMa+5S4ywjYHhcwsheYHXKJn0VBd2fWgLzqfYA5gVL5goEk/EB36t3J0YGYvUfxQbAWfbb1eI8IgTE6DgJENnOdb+Wnq4Ka5Acforedp/sYN2rhwND4CPPOYNRTcUzwQSHiE5OqvovyCvf0VYD1diN+hVzgAR6DNtcT21nE+zXiM1ytOiGBVuZSjREeEWaP1PX5FpjOanCjelLqtaTTFKNJvw6crm6ZVgyQUxyEM5o+cS3Vv+h1/Q8wZsgncT3XWlLLut7zUwPjvlpWL
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <BA29301E9B20174CAAF522BEA4A4276B@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f637854-2dd0-49e8-1623-08d773fecb06
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2019 12:30:46.4663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P/oyS5eEhWARH6DfP96xgT08scV+zB7hUgQE8v1Q8Bx62BYLkWV+WmvZg5tWefpv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR18MB2521
X-OriginatorOrg: suse.com
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

DQoNCk9uIDIwMTkvMTEvMjgg5LiL5Y2INzoyNCwgRGF2aWQgU3RlcmJhIHdyb3RlOg0KPiBPbiBU
aHUsIE5vdiAyOCwgMjAxOSBhdCAwNzozNjo0MUFNICswODAwLCBRdSBXZW5ydW8gd3JvdGU6DQo+
PiBPbiAyMDE5LzExLzI4IOS4iuWNiDM6MjMsIERhdmlkIFN0ZXJiYSB3cm90ZToNCj4+PiBPbiBU
dWUsIE5vdiAxOSwgMjAxOSBhdCAwNjo0MTo0OVBNICswODAwLCBRdSBXZW5ydW8gd3JvdGU6DQo+
Pj4+IE9uIDIwMTkvMTEvMTkg5LiL5Y2INjowNSwgQW5hbmQgSmFpbiB3cm90ZToNCj4+Pj4+IE9u
IDExLzcvMTkgMjoyNyBQTSwgUXUgV2VucnVvIHdyb3RlOg0KPj4+Pj4+IFtQUk9CTEVNXQ0KPj4+
Pj4+IEJ0cmZzIGRlZ3JhZGVkIG1vdW50IHdpbGwgZmFsbGJhY2sgdG8gU0lOR0xFIHByb2ZpbGUg
aWYgdGhlcmUgYXJlIG5vdA0KPj4+Pj4+IGVub3VnaCBkZXZpY2VzOg0KPj4+Pj4NCj4+Pj4+IMKg
SXRzIGJldHRlciB0byBrZWVwIGl0IGxpa2UgdGhpcyBmb3Igbm93IHVudGlsIHRoZXJlIGlzIGEg
Zml4IGZvciB0aGUNCj4+Pj4+IMKgd3JpdGUgaG9sZS4gT3RoZXJ3aXNlIGhpdHRpbmcgdGhlIHdy
aXRlIGhvbGUgYnVnIGluIGNhc2Ugb2YgZGVncmFkZWQNCj4+Pj4+IMKgcmFpZDEgd2lsbCBiZSBt
b3JlIHByZXZhbGVudC4NCj4+Pj4NCj4+Pj4gV3JpdGUgaG9sZSBzaG91bGQgYmUgYSBwcm9ibGVt
IGZvciBSQUlENS82LCBub3QgdGhlIGRlZ3JhZGVkIGNodW5rDQo+Pj4+IGZlYXR1cmUgaXRzZWxm
Lg0KPj4+Pg0KPj4+PiBGdXJ0aGVybW9yZSwgdGhpcyBkZXNpZ24gd2lsbCB0cnkgdG8gYXZvaWQg
YWxsb2NhdGluZyBjaHVua3MgdXNpbmcNCj4+Pj4gbWlzc2luZyBkZXZpY2VzLg0KPj4+PiBTbyBl
dmVuIGZvciAzIGRldmljZXMgUkFJRDUsIG5ldyBjaHVua3Mgd2lsbCBiZSBhbGxvY2F0ZWQgYnkg
dXNpbmcNCj4+Pj4gZXhpc3RpbmcgZGV2aWNlcyAoMiBkZXZpY2VzIFJBSUQ1KSwgc28gbm8gbmV3
IHdyaXRlIGhvbGUgaXMgaW50cm9kdWNlZC4NCj4+Pg0KPj4+IFRoYXQgdGhpcyB3b3VsZCBhbGxv
dyBhIDIgZGV2aWNlIHJhaWQ1IChmcm9tIGV4cGVjdGVkIDMpIGlzIHNpbWlsYXIgdG8NCj4+PiB0
aGUgcmVkdWNlZCBjaHVua3MsIGJ1dCBub3cgaGlkZGVuIGJlY2F1c2Ugd2UgZG9uJ3QgaGF2ZSBh
IGRldGFpbGVkDQo+Pj4gcmVwb3J0IGZvciBzdHJpcGVzIG9uIGRldmljZXMuIEFuZCByZWJhbGFu
Y2Ugd291bGQgYmUgbmVlZGVkIHRvIG1ha2UNCj4+PiBzdXJlIHRoYXQncyB0aGUgZmlsZXN5c3Rl
bSBpcyBhZ2FpbiAzIGRldmljZXMgKGFuZCAxIGRldmljZSBsb3N0DQo+Pj4gdG9sZXJhbnQpLg0K
Pj4+DQo+Pj4gVGhpcyBpcyBkaWZmZXJlbnQgdG8gdGhlIDEgZGV2aWNlIG1pc3NpbmcgZm9yIHJh
aWQxLCB3aGVyZSBzY3J1YiBjYW4NCj4+PiBmaXggdGhhdCAoZXhwZWN0ZWQpLCBidXQgdGhlIGJh
bGFuY2UgaXMgSU1ITyBub3QuDQo+Pj4NCj4+PiBJJ2Qgc3VnZ2VzdCB0byBhbGxvdyBhbGxvY2F0
aW9uIGZyb20gbWlzc2luZyBkZXZpY2VzIG9ubHkgZnJvbSB0aGUNCj4+PiBwcm9maWxlcyB3aXRo
IHJlZHVuZGFuY3kuIEZvciBub3cuDQo+Pg0KPj4gQnV0IFJBSUQ1IGl0c2VsZiBzdXBwb3J0cyAy
IGRldmljZXMsIHJpZ2h0Pw0KPj4gQW5kIGV2ZW4gMiBkZXZpY2VzIFJBSUQ1IGNhbiBzdGlsbCB0
b2xlcmFudCAxIG1pc3NpbmcgZGV2aWNlLg0KPiANCj4+IFRoZSB0b2xlcmFuY2UgaGFzbid0IGNo
YW5nZWQgaW4gdGhhdCBjYXNlLCBqdXN0IHVuYmFsYW5jZWQgZGlzayB1c2FnZSB0aGVuLg0KPiAN
Cj4gQWggcmlnaHQsIHRoZSBjb25zdHJhaW50cyBhcmUgc3RpbGwgZmluZS4gVGhhdCB0aGUgdXNh
Z2UgaXMgdW5iYWxhbmNlZA0KPiBpcyBzb21ldGhpbmcgSSdkIHN0aWxsIGNvbnNpZGVyIGEgcHJv
YmxlbSBiZWNhdXNlIGl0J3Mgc2lsZW50bHkgY2hhbmdpbmcNCj4gdGhlIGxheW91dCBmcm9tIHRo
ZSBvbmUgdGhhdCB3YXMgc2V0IGJ5IHVzZXIuDQo+IA0KPiBBcyB0aGVyZSBhcmUgdHdvIGNvbmZs
aWN0aW5nIHdheXMgdG8gY29udGludWUgZnJvbSB0aGUgbWlzc2luZyBkZXZpY2Ugc3RhdGU6DQo+
IA0KPiAtIHRyeSB0byB1c2UgcmVtYWluaW5nIGRldmljZXMgdG8gYWxsb3cgd3JpdGVzIGJ1dCBj
aGFuZ2UgdGhlIGxheW91dA0KPiAtIGRvbid0IGFsbG93IHdyaXRlcywgbGV0IHVzZXIvYWRtaW4g
c29ydCBpdCBvdXQNCj4gDQo+IEknZCByYXRoZXIgaGF2ZSBtb3JlIHRpbWUgdG8gdW5kZXJzdGFu
ZCB0aGUgaW1wbGljYXRpb25zIGFuZCB0cnkgdG8NCj4gZXhwZXJpbWVudCB3aXRoIHRoYXQuDQo+
IA0KQWgsIG1ha2VzIHNlbnNlLg0KDQpTbyBubyBuZWVkIGZvciBhIG5ldyB2ZXJzaW9uLg0KDQpS
ZXZpZXdlZC1ieTogUXUgV2VucnVvIDx3cXVAc3VzZS5jb20+DQoNClRoYW5rcywNClF1DQo=
