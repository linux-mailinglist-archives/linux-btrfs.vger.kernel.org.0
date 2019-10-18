Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1963DD5AB
	for <lists+linux-btrfs@lfdr.de>; Sat, 19 Oct 2019 02:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731591AbfJSAIM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Oct 2019 20:08:12 -0400
Received: from m9a0003g.houston.softwaregrp.com ([15.124.64.68]:48372 "EHLO
        m9a0003g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728668AbfJSAIM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Oct 2019 20:08:12 -0400
Received: FROM m9a0003g.houston.softwaregrp.com (15.121.0.191) BY m9a0003g.houston.softwaregrp.com WITH ESMTP
 FOR linux-btrfs@vger.kernel.org;
 Sat, 19 Oct 2019 00:07:32 +0000
Received: from M9W0067.microfocus.com (2002:f79:be::f79:be) by
 M9W0068.microfocus.com (2002:f79:bf::f79:bf) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Fri, 18 Oct 2019 23:50:02 +0000
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (15.124.72.10) by
 M9W0067.microfocus.com (15.121.0.190) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Fri, 18 Oct 2019 23:50:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c9KrQYL4en0hGgDbnvsMS8ASccf5RqFhEEwnFUzVtn7C4us9mrFutTL6I8QgZgjuy2n5xnYnseSqzANliM+YAqtceqYatqxrxqIPOZU8fASxq5Q1Rm2i1hwuTd48eSzDqH9iRCmjQgSJDszsj8T4vs86/1j18aLJdk7Tl5kBYlt/bFJ8HuU+pfhagssR+SyVTn5TN9OjKpKegWU95tB71bONlEWM/GDT0XnbDGYhPNsH18n6YFdIqdqwJSt6xlhry3CQqNm9ir/srlBPdNID405cMl07NsUl8/UqyuBhNc34l8JNxIbCdJPAV0XtCU9RMw1LTBjxlwDfiVP8+SI+fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d2bZUtzqVJAql97dVH9g9t0SRgf7czWA/zulCYJG4Kk=;
 b=V2zvhBTdgs8yCt/1iUshtZiY7OLwh/ivYcTSteADLTaVys8yMwZcTh/2chMrhfdqY8t5QMjxCYDB+5uDObb3F9DblcVowQMOfKcCDmmNYktX+IHdelRPRvXBhf8CwKYP27EhE+8X6Y1jDRbDqfz+XmuYasRB3XJYuXQdtcqZEpQN3rN8VoloOA/5PWFw4xTwFPOkOoCt9bf53GqMTD4ylCouL+ePKbPQf7W89awt4wIR9n5bYyjaO5iwaPljKgjsvQObaQUojb/4y2eoMEmCqqf3Pw0JWitjBlvP5i8pFghDOamKSi4M6KO3t7IoYWFJqzy8Tnw8qkJRwW3ArQEJqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from BY5PR18MB3266.namprd18.prod.outlook.com (10.255.163.207) by
 BY5PR18MB3107.namprd18.prod.outlook.com (10.255.137.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.21; Fri, 18 Oct 2019 23:50:00 +0000
Received: from BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::5c5:8dae:70ef:a254]) by BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::5c5:8dae:70ef:a254%4]) with mapi id 15.20.2347.024; Fri, 18 Oct 2019
 23:50:00 +0000
From:   Qu WenRuo <wqu@suse.com>
To:     Ferry Toth <fntoth@gmail.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 0/3] btrfs-progs: Add check and repair for invalid inode
 generation
Thread-Topic: [PATCH 0/3] btrfs-progs: Add check and repair for invalid inode
 generation
Thread-Index: AQHVhfM0opL6vpxcaUKwBk5wEWOTL6dhEZKA
Date:   Fri, 18 Oct 2019 23:50:00 +0000
Message-ID: <b1c32c4b-734f-0f4e-44d1-cb4ef69b7fe1@suse.com>
References: <20190924081120.6283-1-wqu@suse.com>
 <36d45e31-f125-4b21-a68e-428f807180f7@gmail.com>
In-Reply-To: <36d45e31-f125-4b21-a68e-428f807180f7@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: TYAPR01CA0079.jpnprd01.prod.outlook.com
 (2603:1096:404:2c::19) To BY5PR18MB3266.namprd18.prod.outlook.com
 (2603:10b6:a03:1a1::15)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=wqu@suse.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [13.231.109.76]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f54672b0-2294-41bf-0f3a-08d75425e37e
x-ms-traffictypediagnostic: BY5PR18MB3107:
x-microsoft-antispam-prvs: <BY5PR18MB3107F3B97DD4E0291ED239E7D66C0@BY5PR18MB3107.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01949FE337
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(396003)(136003)(376002)(346002)(366004)(199004)(189003)(7736002)(256004)(6246003)(6512007)(6116002)(66946007)(229853002)(386003)(2906002)(6486002)(76176011)(6506007)(66556008)(66446008)(64756008)(305945005)(52116002)(102836004)(66476007)(81156014)(81166006)(476003)(486006)(2616005)(14444005)(11346002)(8676002)(8936002)(446003)(3846002)(186003)(26005)(71190400001)(36756003)(6436002)(5660300002)(71200400001)(14454004)(2501003)(66066001)(86362001)(110136005)(478600001)(316002)(25786009)(31696002)(31686004)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR18MB3107;H:BY5PR18MB3266.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 76y2Agdz757fV3sZsFL4e6pq8fiUgdj1Qacsb1/loSxuAqhv+lOBaR/F56ap6s1pYzfRxmKDOZgVyUf9NHt50sPEAJx+hMCxh2XSNIlK8ncwBuPgaUKDRPX9q3VGPKVjwV+RPnMPnwt57J9j69l9R7BQAcPwMlkS0H55++O+NrC/+Vi+gZmBLFjvyS9jeeqkpJR14KXEeYD7aEzJtAxWshGRMMzJIJ5BvDtqRxnBYzau49TQu9D38SjRLYvaoyQ83TD3rgueFQfiuGszf/IN5fwmbzI+6WA9ZZeBPi5dg+dtRnC9LF12zh7+u+Q4aDmrrnjnteRDVRyve7ANddaoNEZvcml3FhZDfFiaf/+h9EvYL4jw2X5tVgh5AFVNTGzP/Suf13VrZeizCDWFBAjdy1rFy5nsvmgJzXJ68O0h9b0=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <83CEEE312B42B4418DA723E028A899E5@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f54672b0-2294-41bf-0f3a-08d75425e37e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2019 23:50:00.6375
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7FLBWIiIXTn5wmbsqOuplIGuE3qMYFm3BIvj6k8P3+4E32jnhxzYJVLSklzFP2XG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3107
X-OriginatorOrg: suse.com
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

DQoNCk9uIDIwMTkvMTAvMTkg5LiK5Y2INDozMiwgRmVycnkgVG90aCB3cm90ZToNCj4gT3AgMjQt
MDktMjAxOSBvbSAxMDoxMSBzY2hyZWVmIFF1IFdlbnJ1bzoNCj4+IFdlIGhhdmUgYXQgbGVhc3Qg
dHdvIHVzZXIgcmVwb3J0cyBhYm91dCBiYWQgaW5vZGUgZ2VuZXJhdGlvbiBtYWtlcw0KPj4ga2Vy
bmVsIHJlamVjdCB0aGUgZnMuDQo+IA0KPiBNYXkgSSBhZGQgbXkgcmVwb3J0PyBJIGp1c3QgdXBn
cmFkZWQgVWJ1bnR1IGZyb20gMTkuMDQgLT4gMTkuMTAgc28NCj4ga2VybmVsIHdlbnQgZnJvbSA1
LjAgLT4gNS4zIChidXQgSSB3YXMgdXNpbmcgNC4xNSB0b28pLg0KPiANCj4gQm9vdGluZyA1LjMg
bGVhdmVzIG1lIGluIGluaXRyYW1mcyBhcyBJIGhhdmUgL2Jvb3Qgb24gQGJvb3QgYW5kIC8gb24g
L0ANCj4gDQo+IEluIGluaXRyYW1mcyBJIGNhbiB0cnkgdG8gbW91bnQgYnV0IGdldCBzb21ldGhp
bmcgbGlrZQ0KPiBidHJmcyBjcml0aWNhbCBjb3JydXB0IGxlYWYgaW52YWxpZCBpbm9kZSBnZW5l
cmF0aW9uIG9wZW5fY3RyZWUgZmFpbGVkDQo+IA0KPiBCb290aW5nIG9sZCBrZXJuZWwgd29ya3Mg
anVzdCBhcyBiZWZvcmUsIG5vIGVycm9ycy4NCj4gDQo+PiBBY2NvcmRpbmcgdG8gdGhlIGNyZWF0
aW9uIHRpbWUsIHRoZSBpbm9kZSBpcyBjcmVhdGVkIGJ5IHNvbWUgMjAxNA0KPj4ga2VybmVsLg0K
PiANCj4gSG93IGRvIEkgZ2V0IHRoZSBjcmVhdGlvbiB0aW1lPw0KDQojIGJ0cmZzIGlucyBkdW1w
LXRyZWUgLWIgPHRoZSBieXRlbnIgcmVwb3J0ZWQgYnkga2VybmVsPiA8eW91ciBkZXZpY2U+DQo+
IA0KPj4gQW5kIHRoZSBnZW5lcmF0aW9uIG1lbWJlciBvZiBJTk9ERV9JVEVNIGlzIG5vdCB1cGRh
dGVkICh1bmxpa2UgdGhlDQo+PiB0cmFuc2lkIG1lbWJlcikgc28gdGhlIGVycm9yIHBlcnNpc3Rz
IHVudGlsIGxhdGVzdCB0cmVlLWNoZWNrZXIgZGV0ZWN0cy4NCj4+DQo+PiBFdmVuIHRoZSBzaXR1
YXRpb24gY2FuIGJlIGZpeGVkIGJ5IHJldmVydGluZyBiYWNrIHRvIG9sZGVyIGtlcm5lbCBhbmQN
Cj4+IGNvcHlpbmcgdGhlIG9mZmVuZGluZyBkaXIvZmlsZSB0byBhbm90aGVyIGlub2RlIGFuZCBk
ZWxldGUgdGhlIG9mZmVuZGluZw0KPj4gb25lLCBpdCBzdGlsbCBzaG91bGQgYmUgZG9uZSBieSBi
dHJmcy1wcm9ncy4NCj4+DQo+IEhvdyB0byBmaW5kIHRoZSBvZmZlbmRpbmcgZGlyL2ZpbGUgZnJv
bSB0aGUgY29tbWFuZCBsaW5lIG1hbnVhbGx5Pw0KDQojIGZpbmQgPG1vdW50IHBvaW50PiAtaW51
bSA8aW5vZGUgbnVtYmVyPg0KDQpUaGFua3MsDQpRdQ0KDQo+IA0KPj4gVGhpcyBwYXRjaHNldCBh
ZGRzIHN1Y2ggY2hlY2sgYW5kIHJlcGFpciBhYmlsaXR5IHRvIGJ0cmZzLWNoZWNrLCB3aXRoIGEN
Cj4+IHNpbXBsZSB0ZXN0IGltYWdlLg0KPj4NCj4+IFF1IFdlbnJ1byAoMyk6DQo+PiDCoMKgIGJ0
cmZzLXByb2dzOiBjaGVjay9sb3dtZW06IEFkZCBjaGVjayBhbmQgcmVwYWlyIGZvciBpbnZhbGlk
IGlub2RlDQo+PiDCoMKgwqDCoCBnZW5lcmF0aW9uDQo+PiDCoMKgIGJ0cmZzLXByb2dzOiBjaGVj
ay9vcmlnaW5hbDogQWRkIGNoZWNrIGFuZCByZXBhaXIgZm9yIGludmFsaWQgaW5vZGUNCj4+IMKg
wqDCoMKgIGdlbmVyYXRpb24NCj4+IMKgwqAgYnRyZnMtcHJvZ3M6IGZzY2stdGVzdHM6IEFkZCB0
ZXN0IGltYWdlIGZvciBpbnZhbGlkIGlub2RlIGdlbmVyYXRpb24NCj4+IMKgwqDCoMKgIHJlcGFp
cg0KPj4NCj4+IMKgIGNoZWNrL21haW4uY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgNTAgKysrKysrKysrKystDQo+
PiDCoCBjaGVjay9tb2RlLWxvd21lbS5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgNzYgKysrKysrKysrKysrKysrKysrDQo+PiDCoCBjaGVj
ay9tb2RlLW9yaWdpbmFsLmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgfMKgwqAgMSArDQo+PiDCoCAuLi4vLmxvd21lbV9yZXBhaXJhYmxlwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCAwDQo+PiDCoCAuLi4v
YmFkX2lub2RlX2dlbmVhcnRpb24uaW1nLnh6wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8
IEJpbiAwIC0+IDIwMTIgYnl0ZXMNCj4+IMKgIDUgZmlsZXMgY2hhbmdlZCwgMTI2IGluc2VydGlv
bnMoKyksIDEgZGVsZXRpb24oLSkNCj4+IMKgIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPj4gdGVzdHMv
ZnNjay10ZXN0cy8wNDMtYmFkLWlub2RlLWdlbmVyYXRpb24vLmxvd21lbV9yZXBhaXJhYmxlDQo+
PiDCoCBjcmVhdGUgbW9kZSAxMDA2NDQNCj4+IHRlc3RzL2ZzY2stdGVzdHMvMDQzLWJhZC1pbm9k
ZS1nZW5lcmF0aW9uL2JhZF9pbm9kZV9nZW5lYXJ0aW9uLmltZy54eg0KPj4NCj4gDQo=
