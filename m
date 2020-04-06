Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0972819EEF9
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Apr 2020 02:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbgDFA5U (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Apr 2020 20:57:20 -0400
Received: from mail-eopbgr1370087.outbound.protection.outlook.com ([40.107.137.87]:30517
        "EHLO AUS01-SY3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727833AbgDFA5U (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 5 Apr 2020 20:57:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XDnWjLklOMM5qbcZJuz79DrWmObIx28PwWgqUuufbKndxSWucRx8PdYtJRStOKScqxqc2iv9VXuUnBC195Hj4q5as8sJf1Kndl0S1cmLFN53SK/uiktRbYuMCdy6t9WBRQd6OxBYQ7rtpjppfMh0943EQlMIGtXG1bye8UMQSXFPqmSlvww4n54yPV+eIDO9dYdxGE8FQBlVW7mF3+f96lVHmA4CrNn0hj/oIWGYpamSYCFfLppfnS8p7TBbPyAwiqqf3uqV8r59LhcqpjCJu1S00wV2Caw5fzT8IrjcRQfzuvZzDqqq8p+ON1TEu972SJUT4BAUoUCCC2sgFtzkmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dPMlTVTjj3InXCX2yl+sxm1PA5SbVOth+rf6vgdG4zQ=;
 b=Vsm7tLY9nfw/FRXAnULPE4aO4MZ2woL6N+4SRKwQr8Dk1k7HrIu3ptiggQrnG2Fou/hEhSLHYtpdrsx9/pkC7wOJ6LSQ3arda5qcJWey3Urz69dDkRNb3F6Vbd2AxXoyWoKhCQcypB8+SKs6+ykZnp0wX/Fmr/5z4Y2s3X3KZNWSTvfTapgKXrbZBvHXA4SoeltvHJd8/tY/AJdsXglOJEaz6xGGKvqm9P0AG03Q0tTyy1iqukfNAPq2KodfHvqyQnCA/DZMw5qI70mSWdjXyq5pAc2GeXZ7SM81/l08UH+c5IAv72AZm+uvekDGMXHTSx6bmkdDcZ2U59izo3ulXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=pauljones.id.au; dmarc=pass action=none
 header.from=pauljones.id.au; dkim=pass header.d=pauljones.id.au; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oakvillepondscapes.onmicrosoft.com;
 s=selector2-oakvillepondscapes-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dPMlTVTjj3InXCX2yl+sxm1PA5SbVOth+rf6vgdG4zQ=;
 b=WJj1DAHR6E61VMVVkXDgs3M8mXbL79dhBLWsXtRFUjgOoykEDTIWaWSmPotbDBZ6xM3RUL8zmqTFtiRPGj+KSqPHC3DfxruiLUMLjZBw6T8VRzkI3lOAt2iEN99gLF2/yQbvXRotxsQYoPav8TkCWxtV0oIn+p5gYFL5SSFIWiw=
Received: from SYBPR01MB3897.ausprd01.prod.outlook.com (20.177.136.214) by
 SYBPR01MB3417.ausprd01.prod.outlook.com (20.177.137.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.15; Mon, 6 Apr 2020 00:57:12 +0000
Received: from SYBPR01MB3897.ausprd01.prod.outlook.com
 ([fe80::995d:971d:a82:4664]) by SYBPR01MB3897.ausprd01.prod.outlook.com
 ([fe80::995d:971d:a82:4664%4]) with mapi id 15.20.2878.017; Mon, 6 Apr 2020
 00:57:12 +0000
From:   Paul Jones <paul@pauljones.id.au>
To:     "kreijack@inwind.it" <kreijack@inwind.it>,
        Achim Gratz <Stromeko@nexgo.de>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: RE: [RFC][PATCH v2] btrfs: ssd_metadata: storing metadata on SSD
Thread-Topic: [RFC][PATCH v2] btrfs: ssd_metadata: storing metadata on SSD
Thread-Index: AQHWCxqborxCmya2DUuYHJ+f/OvY2ahqSQFigACarICAAGCtoA==
Date:   Mon, 6 Apr 2020 00:57:11 +0000
Message-ID: <SYBPR01MB389757DD12E86E1899B788099EC20@SYBPR01MB3897.ausprd01.prod.outlook.com>
References: <20200405071943.6902-1-kreijack@libero.it>
 <87o8s6bavr.fsf@Rainer.invalid>
 <c5aaf7df-f5a7-d319-976f-ee203a6f4d9b@libero.it>
In-Reply-To: <c5aaf7df-f5a7-d319-976f-ee203a6f4d9b@libero.it>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=paul@pauljones.id.au; 
x-originating-ip: [110.175.198.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f21509b9-a9b7-4b3a-2b3a-08d7d9c570d6
x-ms-traffictypediagnostic: SYBPR01MB3417:
x-microsoft-antispam-prvs: <SYBPR01MB3417435562AC0E4BCA8375029EC20@SYBPR01MB3417.ausprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0365C0E14B
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SYBPR01MB3897.ausprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(346002)(39830400003)(396003)(136003)(376002)(366004)(66946007)(33656002)(52536014)(186003)(316002)(7696005)(86362001)(110136005)(55016002)(5660300002)(76116006)(66556008)(53546011)(2906002)(9686003)(71200400001)(66476007)(26005)(6506007)(81166006)(66446008)(64756008)(8676002)(8936002)(81156014)(508600001);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: pauljones.id.au does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qvoXCmlfnjsLTjHZPZrfwaT0Ct5ii+qgX1rEckJS+q5kBuHr+A9KCTq3DoLXn2QR78LquNXWE630M2GJE3bvbilnAAbkxe1OTvPoL76+dr5gj4UnK2i91JmT64MnTq5yH2xmxq4TDzRs2P8+ZEo/wv9+EghFfmt+51UPljg29RCjoghuFDpEW/U5izqwS8gMoRGq46HnTiuZ/FhAXh7d7ZkKH95y4vucp9HbNV7OugBY3xc2GSrzvqUEEk0yO+60sheZvEHFkm5r721jqONpEl8IfDeXto1AS2riwqPUZtHKN/AHk5zyU0INAkmC1EEoq7RbeC8+T019xo1jqCyFTJemcemdavHMzQWr5Y2n1TOyCLVJzqCZiFZ8o9f2qCYKh+lPR0L1z9gWCXvAC8D5DsVgHm7veAfFQsxuLWo6he4Fcq28uGYaHuqw1rX/NhbI
x-ms-exchange-antispam-messagedata: g2VXk3r6VXpKvp6/4Y2SS/QjwHMQwczC5Buumev7GTtWEYDuGOZTksVplxpPyxu1R7IkMInjrlMk/J16+zt7oapRZWCoZv3oCzXGeADKKHxhTiBBke/zdHj3eglxgQLb62ZF+dpzbp0xBP5GUnmdGA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: pauljones.id.au
X-MS-Exchange-CrossTenant-Network-Message-Id: f21509b9-a9b7-4b3a-2b3a-08d7d9c570d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2020 00:57:11.9833
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8f216723-e13f-4cce-b84c-58d8f16a0082
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QqsII8WQ7KYr0jrGXxFkouuzPrFB2EFcPOIOvOAX5T5OMG/4h/BEV1l4TjQqCnd7RviztR9oIxN1t1WNtFT0Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYBPR01MB3417
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBsaW51eC1idHJmcy1vd25lckB2
Z2VyLmtlcm5lbC5vcmcgPGxpbnV4LWJ0cmZzLQ0KPiBvd25lckB2Z2VyLmtlcm5lbC5vcmc+IE9u
IEJlaGFsZiBPZiBHb2ZmcmVkbyBCYXJvbmNlbGxpDQo+IFNlbnQ6IE1vbmRheSwgNiBBcHJpbCAy
MDIwIDU6MDQgQU0NCj4gVG86IEFjaGltIEdyYXR6IDxTdHJvbWVrb0BuZXhnby5kZT47IGxpbnV4
LWJ0cmZzQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1JGQ11bUEFUQ0ggdjJdIGJ0
cmZzOiBzc2RfbWV0YWRhdGE6IHN0b3JpbmcgbWV0YWRhdGEgb24gU1NEDQo+IA0KPiBPbiA0LzUv
MjAgMTA6MjIgQU0sIEFjaGltIEdyYXR6IHdyb3RlOg0KPiA+IEdvZmZyZWRvIEJhcm9uY2VsbGkg
d3JpdGVzOg0KPiA+PiBUaGlzIGlzIGFuIFJGQzsgSSB3cm90ZSB0aGlzIHBhdGNoIGJlY2F1c2Ug
SSBmaW5kIHRoZSBpZGVhDQo+ID4+IGludGVyZXN0aW5nIGV2ZW4gdGhvdWdoIGl0IGFkZHMgbW9y
ZSBjb21wbGljYXRpb24gdG8gdGhlIGNodW5rIGFsbG9jYXRvci4NCj4gPj4NCj4gPj4gVGhlIGNv
cmUgaWRlYSBpcyB0byBzdG9yZSB0aGUgbWV0YWRhdGEgb24gdGhlIHNzZCBhbmQgdG8gbGVhdmUg
dGhlDQo+ID4+IGRhdGEgb24gdGhlIHJvdGF0aW9uYWwgZGlza3MuIEJUUkZTIGxvb2tzIGF0IHRo
ZSByb3RhdGlvbmFsIGZsYWdzIHRvDQo+ID4+IHVuZGVyc3RhbmQgdGhlIGtpbmQgb2YgZGlza3Mu
DQo+ID4NCj4gPiBNeSBjb21tZW50IHJlYWxseSBpcyBvbmx5IGFib3V0IGhpcyBhc3BlY3Qgb2Yg
eW91ciBwcm9wb3NhbDogSSB3b3VsZA0KPiA+IGNvbnNpZGVyIGEgbW9yZSBnZW5lcmFsIHdheSBv
ZiBpbnRyb2R1Y2luZyBhIHRpZXJpbmcgb2YgZGlza3Mgc28gdGhhdA0KPiA+IG9uZSBjYW4gZGlz
Y2VybiBiZXR3ZWVuIHNsb3dlciBhbmQgZmFzdGVyIFNTRCBhcyB3ZWxsLg0KPiANCj4gVGhpcyBp
cyBhIGZ1cnRoZXIgc3RlcC4gSSBkaWRuJ3QgbWluZCB0byBhIHRpZXJpbmcgb2YgZmFzdCAoTlZN
ID8pIGFuZCBzbG93IFNTRC4NCj4gRm9yIHRoYXQgdGhlcmUgYXJlIHNvbWUgdW51c2VkIGZpZWxk
cyBpbiB0aGUgc3VwZXJibG9jayB3aGljaCBjYW4gYmUgdXNlZC4NCj4gDQo+IEhvd2V2ZXIgbm93
IG15IGZpcnN0IGNvbmNlcm4gaXMgaWYgdGhpcyBpcw0KPiBhKSByZWFsbHkgdXNlZnVsDQo+IGIp
IEkgaW50cm9kdWNlZCBzb21lIGZ1bmN0aW9uYWwgcmVncmVzc2lvbg0KPiANCj4gUmVnYXJkaW5n
IGEpLCB0aGVyZSBpcyBhbiBpbmNyZW1lbnQgb2YgcGVyZm9ybWFuY2U7IGhvd2V2ZXIgc3RhY2tp
bmcgYnRyZnMNCj4gb3ZlciBiY2FjaGUgbGVhZHMgdG8gYW4gZXZlbiBiaWdnZXIgZ2Fpbjsgb2Yg
Y291cnNlIHN0YWNraW5nIGJ0cmZzIG92ZXINCj4gYmNhY2hlIGNvbXBsaWNhdGVzIHRoZSBjb25m
aWd1cmF0aW9uIGZvciB0aGUgcmFpZCBzZXR1cA0KPiANCj4gUmVnYXJkaW5nIGIpIHRoZSBvbmx5
IHJlZ3Jlc3Npb24gdGhhdCBJIGZvdW5kIGlzIHRoYXQgdGhlIGxvZ2ljIGJlaGluZCB0aGUNCj4g
YWxsb2NhdGlvbiBvZiBkaXNrcyBpbiBSQUlENS9SQUlENiBiZWNhbWUgbW9yZSBjb21wbGV4LiBC
dXQgSSBhbSBub3Qgc3VyZSBpZg0KPiB0aGlzIGNhbiBiZSBjYWxsZWQgcmVncmVzc2lvbi4NCg0K
VGhpcyBpcyBkZWZpbml0ZWx5IHVzZWZ1bCBmb3IgbWUuIEkndmUgYmVlbiBtZWFuaW5nIHRvIGlt
cGxlbWVudCBpdCBmb3IgYWdlcywgYnV0IHdhcyBhIGJpdCBhZnJhaWQgdG8gdHJ5IGFzIGtlcm5l
bCBkZXZlbG9wbWVudCBpcyBub3QgbXkgYXJlYS4NCkkndmUgYWxzbyBiZWVuIHRoaW5raW5nIGFi
b3V0IHRyeWluZyBiY2FjaGUsIGJ1dCBJIHJlbWVtYmVyIGhlYXJpbmcgYWJvdXQgcGVvcGxlIGhh
dmluZyBjb3JydXB0aW9uIGlzc3VlcyB3aGVuIHVzZWQgd2l0aCBidHJmcy4gVGhhdCB3YXMgYSB3
aGlsZSBhZ28sIHNvIEkgcHJlc3VtZSB0aGV5IGFyZSBmaXhlZCBub3cuDQpDcmF6eSBpZGVhIC0g
aXMgdGhlcmUgYSB3YXkgYnRyZnMgY291bGQgaG9vayBpbnRvIGJjYWNoZSBvciBkbS1jYWNoZSBk
aXJlY3RseT8gSSBrbm93IHRoYXQncyBhIGxheWVyaW5nIHZpb2xhdGlvbiwgYnV0IGJ0cmZzIGRv
ZXNuJ3QgdXNlIHRoZSBub3JtYWwgbGF5ZXJpbmcgcGFyYWRpZ20gYW55d2F5Lg0KDQpQYXVsLg0K
