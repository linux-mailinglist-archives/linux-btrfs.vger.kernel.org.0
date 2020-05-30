Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15E6F1E8FE6
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 May 2020 10:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgE3I5c (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 30 May 2020 04:57:32 -0400
Received: from mail-eopbgr1360073.outbound.protection.outlook.com ([40.107.136.73]:33952
        "EHLO AUS01-ME1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725554AbgE3I5b (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 30 May 2020 04:57:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U3xHXC96FmolEr9d+JI21JaoFX+BuutBCjmmsd9zVCTfQ7nJkKIUAEdFfLarNygm6jeMOpU4cwSW2ltBoG+aFlbwJWt+PCMEcjUQqjmlaPHRH61KU9BleltwTLYqj/OSjDF/48iBzBsxiN7cOvLJl1SE7XocudVZor16RXiIjbkZikdnwXSiy27e05lKN0iREZDKS3jlj0vCps6Ol9KnDqwjBCiABEGKcc6KS4t6lhbjNBj9IsX7F8wq+8kTLlfdNsufbsLVUgtV6K4USxTehdWdEbjRNUZDZsNd8Am67n+px/sKW6wmowfVkfLwXffeCr0DzkUMtzOPB8fpQcLx8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fxbyzB8cXI5Q7bJVL37DQ/3AlMEzKjWjyWTVJ0BP7C4=;
 b=DT0MKYVETeWH1S42wytPp/PpVvwH975XVoQAgBNBsXswWAZt3zuPQxA2/uO20neLZ1Txquklp8D/Gvixzcs3mUP8yjmKnr7Tjsu+GuBI2HZlg7UBE+ecdqGq3Y8JbCGMtWlxtT8uj4OevlWc3aKDzOPiSrU0t5xTVbeH5q0qZMHNS0qiwIpNrsOl+ylnoCq7GG6uHN19DEvbw7eGKkVPUtCFvkIxQjB5uAnr3Y3QuncXMl6mUXzOpz6dn1g9eo5KqaRr+G4kDVCYmQ/lxUt7VrSnO4gnn00iL/yztqkx9z3qouAmprnhCTUyKVFg+jTlt/KvHAd1d6HurlKhrDXQlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=pauljones.id.au; dmarc=pass action=none
 header.from=pauljones.id.au; dkim=pass header.d=pauljones.id.au; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oakvillepondscapes.onmicrosoft.com;
 s=selector2-oakvillepondscapes-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fxbyzB8cXI5Q7bJVL37DQ/3AlMEzKjWjyWTVJ0BP7C4=;
 b=Gl6RZhYITbKnKYYe4hzAQkLbnu5ssLJqED/HFcuxV3oBkEv+F2t2igO8UNwRLNandyJfurwd/x4+Uy83bgjQj4IMF2OJ6IpQ2Ip8otQwNfQ5Jirj7P7CCEtsUYZW/WuCyEVhBY8KGYlOlk6Infa6LmM+9U2fJKIpAnHsod0G0sA=
Received: from SYBPR01MB4604.ausprd01.prod.outlook.com (2603:10c6:10:13::18)
 by SYBPR01MB3675.ausprd01.prod.outlook.com (2603:10c6:10:27::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Sat, 30 May
 2020 08:57:26 +0000
Received: from SYBPR01MB4604.ausprd01.prod.outlook.com
 ([fe80::300b:53f1:1128:bdb9]) by SYBPR01MB4604.ausprd01.prod.outlook.com
 ([fe80::300b:53f1:1128:bdb9%6]) with mapi id 15.20.3045.022; Sat, 30 May 2020
 08:57:26 +0000
From:   Paul Jones <paul@pauljones.id.au>
To:     "kreijack@inwind.it" <kreijack@inwind.it>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     Michael <mclaud@roznica.com.ua>, Hugo Mills <hugo@carfax.org.uk>,
        Martin Svec <martin.svec@zoner.cz>,
        Wang Yugui <wangyugui@e16-tech.com>
Subject: RE: [RFC][PATCH V3] btrfs: ssd_metadata: storing metadata on SSD
Thread-Topic: [RFC][PATCH V3] btrfs: ssd_metadata: storing metadata on SSD
Thread-Index: AQHWNj8o625HfLPl1UyctF1CfIuBlKjAMAoAgAAhTdA=
Date:   Sat, 30 May 2020 08:57:26 +0000
Message-ID: <SYBPR01MB4604AB774891E3D172463C5F9E8C0@SYBPR01MB4604.ausprd01.prod.outlook.com>
References: <20200405082636.18016-1-kreijack@libero.it>
 <69939407-de18-e455-6c85-cd10683894be@gmx.com>
 <de7c16c4-9424-8ccf-16bb-0d3b9d56b6b6@libero.it>
In-Reply-To: <de7c16c4-9424-8ccf-16bb-0d3b9d56b6b6@libero.it>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: inwind.it; dkim=none (message not signed)
 header.d=none;inwind.it; dmarc=none action=none header.from=pauljones.id.au;
x-originating-ip: [220.245.105.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f83188f1-62a3-4eb1-0018-08d8047779b7
x-ms-traffictypediagnostic: SYBPR01MB3675:
x-microsoft-antispam-prvs: <SYBPR01MB3675A4CAAEEE9CAD54E2D9C99E8C0@SYBPR01MB3675.ausprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 041963B986
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7giqmWxh2J/eT/icfnfg/+/i/Nc3j28f0wip1KeZb+9RI6EdqonfnCGEzCUvOIKlhi8yZdJw1vjDXEIKO8GSl983/0mJeIQa/+hJee8DXeUDngPjJI/4grWnBFhkdHfM3XmO2njkHzFQNbF569pF/9hhzArBwR+waiAQVC+LsUsxVjIQlqbbD0OAf1bB1c845FgispHOJJ9HGicu4p24+upzxQTl8W8Oh6eVhSOHjtFumN6LgeVQZFENGci/OFUCh9DHslBdxkH3GjWAZBfjbsz3uHmDBzPTS1XTJrnm9BfbrR5W9tJu8p3d0Z1sTqNXvR8Bc/IfDZ18tkoKLdGUiQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SYBPR01MB4604.ausprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(366004)(39830400003)(136003)(376002)(346002)(26005)(186003)(110136005)(83380400001)(53546011)(6506007)(86362001)(7696005)(2906002)(71200400001)(54906003)(33656002)(52536014)(8676002)(66476007)(66556008)(508600001)(55016002)(64756008)(66446008)(9686003)(66946007)(5660300002)(4326008)(8936002)(76116006)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: MbEPyftjMZjwWsvaQNXppO6dLX4S89diYqSUr30ZBBkA4dIIjEGbY6no7aoe0wpWMgQ2hXYViWFw3J04+UXHNyic7wDEPjbERqLZMEmfnQdJ6fAKA6a5DqNvpvqm/ikApkMcW14FVK4iA2QE96HEDicEqXyRKGVWeiTynncUL7rSS+UmH2PtfL0bg82OvwmnCNGDznVH3pwXQ3hqF1DTvQEq6tJEkZvthCFCIXG4Xa7guXoIF4TgX34I0gdIJryxsNm+5URtW5N4/bSuOs0F4flKXbebDo0NjGAonpiurRiq1nRAFq11aKSPiR9Nt0f8RRu4Ypjv6avnvuKLoe2Q6ogS4MW95lUiCgOxI7F3WMueOv9lLOb2Il9yYi3qIqocrrcVlcdxxLTtHshjEUJ2oZ/dcYAZ8yzkging/bXyWhtXMdyKTSCdTS895GEvsdI/nYvFruRe8cn7LQw4tRXdiKPuoBVVIo6ltQeWwKJKhis=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: pauljones.id.au
X-MS-Exchange-CrossTenant-Network-Message-Id: f83188f1-62a3-4eb1-0018-08d8047779b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2020 08:57:26.1391
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8f216723-e13f-4cce-b84c-58d8f16a0082
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y47sDC8hNepeMMAXfC7n+XmZlq5BTKGzPzVFxSyl7dVCRR9IiXjDu2/QKjb3nqvdzObkX5ciLEjtGXeaiuDtbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYBPR01MB3675
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBsaW51eC1idHJmcy1vd25lckB2
Z2VyLmtlcm5lbC5vcmcgPGxpbnV4LWJ0cmZzLQ0KPiBvd25lckB2Z2VyLmtlcm5lbC5vcmc+IE9u
IEJlaGFsZiBPZiBHb2ZmcmVkbyBCYXJvbmNlbGxpDQo+IFNlbnQ6IFNhdHVyZGF5LCAzMCBNYXkg
MjAyMCA0OjQ4IFBNDQo+IFRvOiBRdSBXZW5ydW8gPHF1d2VucnVvLmJ0cmZzQGdteC5jb20+OyBs
aW51eC1idHJmc0B2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IE1pY2hhZWwgPG1jbGF1ZEByb3puaWNh
LmNvbS51YT47IEh1Z28gTWlsbHMgPGh1Z29AY2FyZmF4Lm9yZy51az47DQo+IE1hcnRpbiBTdmVj
IDxtYXJ0aW4uc3ZlY0B6b25lci5jej47IFdhbmcgWXVndWkgPHdhbmd5dWd1aUBlMTYtDQo+IHRl
Y2guY29tPg0KPiBTdWJqZWN0OiBSZTogW1JGQ11bUEFUQ0ggVjNdIGJ0cmZzOiBzc2RfbWV0YWRh
dGE6IHN0b3JpbmcgbWV0YWRhdGEgb24gU1NEDQo+IA0KPiBPbiA1LzMwLzIwIDY6NTkgQU0sIFF1
IFdlbnJ1byB3cm90ZToNCj4gWy4uLl0NCj4gPj4gVGhpcyBuZXcgbW9kZSBpcyBlbmFibGVkIHBh
c3NpbmcgdGhlIG9wdGlvbiBzc2RfbWV0YWRhdGEgYXQgbW91bnQNCj4gdGltZS4NCj4gPj4gVGhp
cyBwb2xpY3kgb2YgYWxsb2NhdGlvbiBpcyB0aGUgInByZWZlcnJlZCIgb25lLiBJZiB0aGlzIGRv
ZXNuJ3QNCj4gPj4gcGVybWl0IGEgY2h1bmsgYWxsb2NhdGlvbiwgdGhlICJjbGFzc2ljIiBvbmUg
aXMgdXNlZC4NCj4gPg0KPiA+IE9uZSB0aGluZyB0byBpbXByb3ZlIGhlcmUsIGluIGZhY3Qgd2Ug
Y2FuIHVzZSBleGlzdGluZyBtZW1iZXJzIHRvDQo+ID4gcmVzdG9yZSB0aGUgZGV2aWNlIHJlbGF0
ZWQgaW5mbzoNCj4gPiAtIGJ0cmZzX2Rldl9pdGVtOjpzZWVrX3NwZWVkDQo+ID4gLSBidHJmc19k
ZXZfaXRlbTo6YmFuZHdpZHRoIChJIHRlbmQgdG8gcmVuYW1lIGl0IHRvIElPUFMpDQo+IA0KPiBI
aSBRdSwNCj4gDQo+IHRoaXMgcGF0aCB3YXMgYW4gb2xkZXIgdmVyc2lvbix0aGUgY3VycmVudCBv
bmUgKHNlbnQgMiBkYXlzIGFnbykgc3RvcmUgdGhlDQo+IHNldHRpbmcgb2Ygd2hpY2ggZGlza3Mg
aGFzIHRvIGJlIGNvbnNpZGVyZWQgYXMgInByZWZlcnJlZF9tZXRhZGF0YSIuDQo+ID4NCj4gPiBJ
biBmYWN0LCB3aGF0IHlvdSdyZSB0cnlpbmcgdG8gZG8gaXMgdG8gcHJvdmlkZSBhIHBvbGljeSB0
byBhbGxvY2F0ZQ0KPiA+IGNodW5rcyBiYXNlZCBvbiBlYWNoIGRldmljZSBwZXJmb3JtYW5jZSBj
aGFyYWN0ZXJpc3RpY3MuDQo+ID4NCj4gPiBJIGJlbGlldmUgaXQgd291bGQgYmUgc3VwZXIgYXdl
c29tZSwgYnV0IHRvIGdldCBpdCB1cHN0cmVhbSwgSSBndWVzcw0KPiA+IHdlIHdvdWxkIHByZWZl
ciBhIG1vcmUgZmxleCBmcmFtZXdvcmssIHRodXMgaXQgd291bGQgYmUgcHJldHR5IHNsb3cgdG8N
Cj4gbWVyZ2UuDQo+IA0KPiBJIGFncmVlLiBBbmQgY29uc2lkZXJpbmcgdGhhdCBpbiB0aGUgbmVh
ciBmdXR1cmUgdGhlIFNTRCB3aWxsIGJlY29tZSBtb3JlDQo+IHdpZGVzcHJlYWQsIEkgZG9uJ3Qg
a25vdyBpZiB0aGUgZWZmb3J0IChhbmQgdGhlIHRpbWUgcmVxdWlyZWQpIGFyZSB3b3J0aC4NCg0K
SSB0aGluayBpdCB3aWxsIGJlLiBDb25zaWRlciBhIGxhcmdlIDEwVEIrIGZpbGVzeXN0ZW0gdGhh
dCBydW5zIG9uIGNoZWFwIHVuYnVmZmVyZWQgU1NEcyAtIE1ldGFkYXRhIHdpbGwgc3RpbGwgYmUg
YSBib3R0bGVuZWNrIGxpa2UgaXQgaXMgbm93LCBqdXN0IGV2ZXJ5dGhpbmcgaGFwcGVucyBtdWNo
IGZhc3Rlci4gQXJjaGl2YWwgc3RvcmFnZSB3aWxsIGxpa2VseSBiZSByb3RhdGlvbmFsIGJhc2Vk
IGZvciBhIGxvbmcgdGltZSB5ZXQgZm9yIGNvc3QgcmVhc29ucywgYW5kIHRoaXMgaXMgd2hlcmUg
c3NkIG1ldGFkYXRhIHNoaW5lcy4gSSd2ZSBiZWVuIHJ1bm5pbmcgeW91ciBzc2RfbWV0YWRhdGEg
cGF0Y2ggZm9yIG92ZXIgYSBtb250aCBub3cgYW5kIGl0J3MgZmxpcHBpbmcgZmFudGFzdGljISBU
aGUgcmVzcG9uc2l2ZW5lc3MgaXQgYnJpbmdzIHRvIG5ldHdvcmtlZCBhcmNoaXZhbCBzdG9yYWdl
IGlzIGFtYXppbmcuDQoNClBhdWwuDQo=
