Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 939CFBFC68
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Sep 2019 02:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfI0A1J (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Sep 2019 20:27:09 -0400
Received: from m4a0041g.houston.softwaregrp.com ([15.124.2.87]:48017 "EHLO
        m4a0041g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725808AbfI0A1J (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Sep 2019 20:27:09 -0400
Received: FROM m4a0041g.houston.softwaregrp.com (15.120.17.146) BY m4a0041g.houston.softwaregrp.com WITH ESMTP;
 Fri, 27 Sep 2019 00:25:11 +0000
Received: from M9W0068.microfocus.com (2002:f79:bf::f79:bf) by
 M4W0334.microfocus.com (2002:f78:1192::f78:1192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Fri, 27 Sep 2019 00:25:45 +0000
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (15.124.72.12) by
 M9W0068.microfocus.com (15.121.0.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Fri, 27 Sep 2019 00:25:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AiX5BI5qJEf3ihJNLc1+C3Kg+dqRajxOIqR+l9Y+dIj028t57GwtjTHUNycPMkLyFFgwhtxySO8yyPyBt+sT3oL99NA0rH993GQvmWvrVgX2FjO09IIDSOo3UA0gzWxFe8eF4eybUAVnsLnfdp4qOMGVnhzV0OkAwYwIfZxyU0crElZ+7QQh2h7cmANwmOtLtngarTy5Mslgb06bSgbQ3rw3bUkjsHExVU9wabVPFpoDJFQ5nAqhHvdFbgIDrf6DCMOpR2gME5G9yhb2y6e3wSSZUcVIvFLj0WlCwsefLh/jAfJ5aCvVbjRG1IlrqIxOQOmx0DERrOLBkrhk/Q6CmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EAK6dk5AeHeh8iuN9RoaN6mRR+DWPuy46MrxrH75rpo=;
 b=mGUkFoMVC3BWh++qH7Vpz1DqRmqJaAx7hoP7uRzzTIseBkC6jTBdvxGkUgb0ft1ir9Y9xNoOZYJc7qjYLLC40a+gzeonokgfVLBTrzMW0SGdLhLgmgIrwZJdJp1MNT6q+b6sZIKrr8HrVPye52v+0Uh4QBZSQ6nvz2jyhCRnakfFz3kJI/mlsSMnLmLaDIN/FtbNXnP35x48e9yp+IbtiOXJRkm59b5OG82Ob9zE6UQUkREa3DUcRhV3B4ArUAdRJCvf8i7ALl54ddPKdb6LvpEvh3YrA+d+FjXOODW5WzPVDy2OxIFTwgKwUcEsk18smD9P04zPQiYs2mE4q/USRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from BY5PR18MB3266.namprd18.prod.outlook.com (10.255.163.207) by
 BY5PR18MB3220.namprd18.prod.outlook.com (10.255.136.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.19; Fri, 27 Sep 2019 00:25:43 +0000
Received: from BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::3993:1f66:bd4:83cc]) by BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::3993:1f66:bd4:83cc%5]) with mapi id 15.20.2284.023; Fri, 27 Sep 2019
 00:25:43 +0000
From:   Qu WenRuo <wqu@suse.com>
To:     Josef Bacik <josef@toxicpanda.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH RFC] btrfs: relocation: Hunt down BUG_ON() in
 merge_reloc_roots()
Thread-Topic: [PATCH RFC] btrfs: relocation: Hunt down BUG_ON() in
 merge_reloc_roots()
Thread-Index: AQHVdJnfgm9bzkx97Eq9pTG+IqrfCqc+qvYA
Date:   Fri, 27 Sep 2019 00:25:43 +0000
Message-ID: <97a4cff2-3547-5991-1c19-ff15972e8d13@suse.com>
References: <20190926063545.20403-1-wqu@suse.com>
 <20190926183338.uwylopkth7pal5zd@macbook-pro-91.dhcp.thefacebook.com>
In-Reply-To: <20190926183338.uwylopkth7pal5zd@macbook-pro-91.dhcp.thefacebook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: TYCPR01CA0042.jpnprd01.prod.outlook.com
 (2603:1096:405:1::30) To BY5PR18MB3266.namprd18.prod.outlook.com
 (2603:10b6:a03:1a1::15)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=wqu@suse.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [13.231.109.76]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3e456689-0023-4ed6-c46d-08d742e13bc0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BY5PR18MB3220;
x-ms-traffictypediagnostic: BY5PR18MB3220:
x-microsoft-antispam-prvs: <BY5PR18MB32205D449C8F26D85339C416D6810@BY5PR18MB3220.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0173C6D4D5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(346002)(366004)(396003)(39860400002)(376002)(52314003)(199004)(189003)(71200400001)(71190400001)(14454004)(36756003)(6246003)(52116002)(305945005)(102836004)(31696002)(81156014)(86362001)(256004)(81166006)(7736002)(66476007)(66556008)(64756008)(66946007)(66446008)(25786009)(3846002)(31686004)(76176011)(99286004)(229853002)(2616005)(6116002)(476003)(6486002)(486006)(14444005)(66066001)(6512007)(4326008)(478600001)(386003)(11346002)(26005)(8936002)(8676002)(6916009)(2906002)(446003)(186003)(5660300002)(6506007)(316002)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR18MB3220;H:BY5PR18MB3266.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pV0U/KAn2x/zLYfmBsOoe8ecIIozzhrunO+tahyrQcBtedCCSqioGG49UZ8ZlaxEcLvekGNGwE6ppp9prfS6EYl7IDzYkvVr4pUUU9H1xkVYGedQZAXwXmAJ4s63qgg4Xof/D2G66trKGrZ8XDiIURSRvs/sicREZ4qbtHKCf8h20g707NuQM2UJCpeABhtAbsS/Io9oSkWo4qhx4B8XRFLeaz6dWVQSPtvlh5f5JPFEKUj7vFcib9j78S0GiJPwZQfjyAf79QdIfd1YuastO/EzrGU4C3rBfKS1ZEw5BVcnEdvK8uuE8iVaRZmAEUdREJgxBnhpDPcb1p26E6blXei8l8oirIwpWcDQ4Vz2Sn0hKVVTqSJ8Eh1x+FgPsglKIkyYW9DF6KR5LhCqtfoOS+gtXshNsuMvs4xiq8F0PQ0=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <AB97859F358A5C409F4E55A0361DE451@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e456689-0023-4ed6-c46d-08d742e13bc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2019 00:25:43.5767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4nsQ1mEUs2uherLI6ygR8bGPks9+G/vezcqFwfwutbasUIPPIDI8ZWJ9Dfh3cl0h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3220
X-OriginatorOrg: suse.com
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

DQoNCk9uIDIwMTkvOS8yNyDkuIrljYgyOjMzLCBKb3NlZiBCYWNpayB3cm90ZToNCj4gT24gVGh1
LCBTZXAgMjYsIDIwMTkgYXQgMDI6MzU6NDVQTSArMDgwMCwgUXUgV2VucnVvIHdyb3RlOg0KPj4g
W0JVR10NCj4+IFRoZXJlIGlzIG9uZSBCVUdfT04oKSByZXBvcnQgd2hlcmUgYSB0cmFuc2FjdGlv
biBpcyBhYm9ydGVkIGR1cmluZw0KPj4gYmFsYW5jZSwgdGhlbiBrZXJuZWwgQlVHX09OKCkgaW4g
bWVyZ2VfcmVsb2Nfcm9vdHMoKToNCj4+DQo+PiAgIHZvaWQgbWVyZ2VfcmVsb2Nfcm9vdHMoc3Ry
dWN0IHJlbG9jX2NvbnRyb2wgKnJjKQ0KPj4gICB7DQo+PiAJLi4uDQo+PiAJQlVHX09OKCFSQl9F
TVBUWV9ST09UKCZyYy0+cmVsb2Nfcm9vdF90cmVlLnJiX3Jvb3QpKTsgPDw8DQo+PiAgIH0NCj4+
DQo+PiBbQ0FVU0VdDQo+PiBJdCdzIHN0aWxsIHVuY2VydGFpbiB3aHkgd2UgY2FuIGdldCB0byBz
dWNoIHNpdHVhdGlvbi4NCj4+IEFzIGFsbCBfX2FkZF9yZWxvY19yb290KCkgY2FsbHMgd2lsbCBh
bHNvIGxpbmsgdGhhdCByZWxvYyByb290IHRvDQo+PiByYy0+cmVsb2Nfcm9vdHMsIGFuZCBpbiBt
ZXJnZV9yZWxvY19yb290cygpIHdlIGNsZWFudXAgcmMtPnJlbG9jX3Jvb3RzLg0KPj4NCj4+IFNv
IHRoZSByb290IGNhdXNlIGlzIHN0aWxsIHVuY2VydGFpbi4NCj4+DQo+PiBbRklYXQ0KPj4gQnV0
IHdlIGNhbiBzdGlsbCBodW50IGRvd24gYWxsIHRoZSBCVUdfT04oKSBpbiBtZXJnZV9yZWxvY19y
b290cygpLg0KPj4NCj4+IFRoZXJlIGFyZSAzIEJVR19PTigpcyBpbiBpdDoNCj4+IC0gQlVHX09O
KCkgZm9yIHJlYWRfZnNfcm9vdCgpIHJlc3VsdA0KPj4gLSBCVUdfT04oKSBmb3Igcm9vdC0+cmVs
b2Nfcm9vdCAhPSByZWxvY19yb290IGNhc2UNCj4+IC0gQlVHX09OKCkgZm9yIHRoZSBub24tZW1w
dHkgcmVsb2Nfcm9vdF90cmVlDQo+Pg0KPj4gRm9yIHRoZSBmaXJzdCB0d28sIGp1c3QgZ3JhYiB0
aGUgcmV0dXJuIHZhbHVlIGFuZCBnb3RvIG91dCB0YWcgZm9yDQo+PiBjbGVhbnVwLg0KPj4NCj4+
IEZvciB0aGUgbGFzdCBvbmUsIG1ha2UgaXQgbW9yZSBncmFjZWZ1bCBieToNCj4+IC0gZ3JhYiB0
aGUgbG9jayBiZWZvcmUgZG9pbmcgcmVhZC93cml0ZQ0KPj4gLSB3YXJuIGluc3RlYWQgb2YgcGFu
aWMNCj4+IC0gY2xlYW51cCB0aGUgbm9kZXMgaW4gcmMtPnJlbG9jX3Jvb3RfdHJlZQ0KPj4NCj4+
IFNpZ25lZC1vZmYtYnk6IFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPg0KPiANCj4gSWYgd2UncmUg
Z29pbmcgdG8gZG8gdGhlc2UgdGhpbmdzIHdlIG1pZ2h0IGFzIHdlbGwgYWRkIHRoZSBhYmlsaXR5
IHRvIGVycm9yDQo+IGluamVjdCBhbmQgYWRkIGFuIHhmc3Rlc3QgdG8gdmVyaWZ5IHRoZXkgZG9u
J3QgYnJlYWsgYW55dGhpbmcuDQoNCkJDQyBoYXMgdG9vbCB0byBpbmplY3QgY2VydGFpbiBlcnJv
cnMgdG8gbWVtb3J5IGFsbG9jYXRpb24uDQpBbmQgSSBoYXZlIGJ0cmZzLXByb2ZpbGVyIHRvb2wg
dG8gaW5qZWN0IGFueSBvdmVycmlkZWFibGUgZnVuY3Rpb24gd2l0aA0Kc2ltaWxpYXIgY2FsbGNo
YWluIGNvbmRpdGlvbi4NCg0KVGhlIHByb2JsZW0gaXMsIGl0J3Mgbm90IHNvbWV0aGluZyBjYW4g
YmUgcHJvdmlkZWQgdGhyb3VnaCB4ZnN0ZXN0IGl0c2VsZi4NCg0KRnVydGhlcm1vcmUsIEkgc2Vl
IG5vIHJlYXNvbiB3aHkgbWVyZ2VfcmVsb2Nfcm9vdCgpIGZhaWx1cmUgY291bGQgbGVhZA0KdG8g
dGhlIGZpbmFsIEJVR19PTigpLCB0aHVzIEknbSBub3Qgc3VyZSBldmVuIHdpdGggZXJyb3IgaW5q
ZWN0aW9uIHdlDQpjb3VsZCBoaXQgdGhlIGZpbmFsIEJVR19PTigpLCBtZWFuaW5nIGV2ZW4gd2l0
aCBlcnJvciBpbmplY3Rpb24sIHdlIG1heQ0Kbm90IGdldCBmdWxsIGNvdmVyYWdlLg0KDQpCdXQg
YW55d2F5LCBJJ2xsIGFkZCB0aGUgZXJyb3IgaW5qZWN0aW9uIHRlc3QgcmVzdWx0IGluIHRoZSBu
ZXh0IHVwZGF0ZS4NCg0KVGhhbmtzLA0KUXUNCg0KPiAgVGhlDQo+IEJVR19PTihyb290LT5yZWxv
Y19yb290ICE9IHJlbG9jX3Jvb3QpIGlzbid0IGFibGUgdG8gYmUgdGVzdGVkLCBidXQgeW91IGNh
biBhdA0KPiBsZWFzdCBtYWtlIHJlYWRfZnNfcm9vdCgpIGFuZCBtZXJnZV9yZWxvY19yb290KCkg
YW5kIHRoZW4gdGVzdCB0aGlzIHBhdGNoIGJ5DQo+IHRyaWdnZXJpbmcgZXJyb3JzIGluIHRoZXNl
IHBhdGhzLg0KPiANCj4gSWYgeW91IGRvIHRoYXQgSSdtIG9rIHdpdGggbm90IGJlaW5nIGFibGUg
dG8gZXhwbGFpbiB0aGUgbGVha2luZyBub2RlcywgZ2V0dGluZw0KPiByaWQgb2YgdGhlIEJVR19P
TigpJ3MgaXMgZ29vZCBlbm91Z2ggcmVhc29uLiAgVGhhbmtzLA0KPiANCj4gSm9zZWYNCj4gDQo=
