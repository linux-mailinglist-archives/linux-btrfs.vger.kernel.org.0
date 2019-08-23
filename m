Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79EF29AB7E
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2019 11:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387621AbfHWJjB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Aug 2019 05:39:01 -0400
Received: from mail-eopbgr1370052.outbound.protection.outlook.com ([40.107.137.52]:44000
        "EHLO AUS01-SY3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732168AbfHWJjB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Aug 2019 05:39:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FhMqxYtMVDtb10DLQss/lKDj7Dicgn6Ff4b6m3/6uC5pngC1U7mXNN4D06gPh/61LZnvJUBLhbCLXMGYRjNLWA/xLYpV5H239H37WDNRvMvVQwjPo7DCEsgUMCSHoa0TdtHFldmqYBD43gAfE3hrTLPlmIK6AmYS0LfItKG40efIkEBh+JO4/C/L2vji66XS75qbU8mGcQ9dc3sYW87zbOABsCJOz7kqUWCU/dAN3q7EBVfQM7elzRFBF/pdB6ipOFCzb7uSRDUAcQ51ZRbZSW6i0ptyh+WiZ2GfawaZWNJEmVPWCXTTqxPED/4ef0+702gztFte1MM/RO7wOrsbNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9nARnPnTNWO0wRlfCU2+pE/0fV9Lo6oe+/1JDySWY4=;
 b=YaR6ifiHrmYP8MCO38Ioyysi9zpM102Saph9pmJlg2wCtnAA9OUih2Abq3h4rSgi3hRJ55+6hmtufGNvxCLw5qa4DfVzPRVnnegrrMu5loSyGPWPWQ0TJQdrHk344ZyMY2Dqq2XV/tZAOiZUnD4FQwfynQSu4ZdZEJjs+sQ6OfdNb8cIXUJeOHKn0Mgbr74lDUCKKJt7SHWqR8JR/TzxUltvR4CwNN3bwyDIuDYw+fpH9I3gqHme8QDZw1bveAt/S3BqCC1n2J6uRlMw0qESX+CCQ6i98O2O4Zb4RFr9lk7Df78fyaCfgexjcqsqJTV/hiuJgGRGz9/V1PZ6Xa7b5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=pauljones.id.au; dmarc=pass action=none
 header.from=pauljones.id.au; dkim=pass header.d=pauljones.id.au; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oakvillepondscapes.onmicrosoft.com;
 s=selector2-oakvillepondscapes-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9nARnPnTNWO0wRlfCU2+pE/0fV9Lo6oe+/1JDySWY4=;
 b=RarcaYyVRUPOMrENBGLNGGMB2K8hfgJ8Lvb773ZAz1HH7yc20ZExDmzyLVZsRab2mwBcOFyFKWJME9i3WmKRaBX2Vfj22sCu1tqavcVrZvfGmTxvv7YtQH+l3UotRU9gcQsIiascikJQtPZecf70cj8CgE3FDdtMHfooEZb6htY=
Received: from SYCPR01MB5086.ausprd01.prod.outlook.com (20.178.187.213) by
 SYCPR01MB3501.ausprd01.prod.outlook.com (20.177.141.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Fri, 23 Aug 2019 09:38:55 +0000
Received: from SYCPR01MB5086.ausprd01.prod.outlook.com
 ([fe80::a4a3:7933:106d:97cd]) by SYCPR01MB5086.ausprd01.prod.outlook.com
 ([fe80::a4a3:7933:106d:97cd%6]) with mapi id 15.20.2178.020; Fri, 23 Aug 2019
 09:38:55 +0000
From:   Paul Jones <paul@pauljones.id.au>
To:     Peter Becker <floyd.net@gmail.com>,
        =?utf-8?B?SG9sZ2VyIEhvZmZzdMOkdHRl?= 
        <holger@applied-asynchrony.com>
CC:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: RE: [PATCH v2 0/4] Support xxhash64 checksums
Thread-Topic: [PATCH v2 0/4] Support xxhash64 checksums
Thread-Index: AQHVWN5sZym6CkEPx0WNaunvpntJ1acHGJSAgAA1gYCAASHToA==
Date:   Fri, 23 Aug 2019 09:38:55 +0000
Message-ID: <SYCPR01MB5086F030FA4FD295783638B99EA40@SYCPR01MB5086.ausprd01.prod.outlook.com>
References: <20190822114029.11225-1-jthumshirn@suse.de>
 <ed9e2eaa-7637-9752-94bb-fd415ab2b798@applied-asynchrony.com>
 <CAEtw4r01JMFqszs0bBeeU3OXLqbT5+cU+4ZP282J3cvYzALgZg@mail.gmail.com>
In-Reply-To: <CAEtw4r01JMFqszs0bBeeU3OXLqbT5+cU+4ZP282J3cvYzALgZg@mail.gmail.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=paul@pauljones.id.au; 
x-originating-ip: [203.213.69.224]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 68443c50-ae8a-470f-1de3-08d727adb798
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(5600166)(711020)(4605104)(1401327)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7193020);SRVR:SYCPR01MB3501;
x-ms-traffictypediagnostic: SYCPR01MB3501:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <SYCPR01MB350109EFF8649705E37D7FE99EA40@SYCPR01MB3501.ausprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1227;
x-forefront-prvs: 0138CD935C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(396003)(376002)(346002)(39830400003)(189003)(13464003)(199004)(33656002)(316002)(446003)(7736002)(305945005)(11346002)(486006)(74316002)(71200400001)(71190400001)(76176011)(256004)(6436002)(4326008)(55016002)(8936002)(14454004)(53936002)(102836004)(6246003)(66556008)(99286004)(5660300002)(6306002)(25786009)(9686003)(6506007)(53546011)(26005)(66066001)(86362001)(81166006)(52536014)(186003)(81156014)(8676002)(508600001)(476003)(64756008)(229853002)(3846002)(6116002)(2906002)(110136005)(76116006)(66946007)(66446008)(7696005)(66476007);DIR:OUT;SFP:1101;SCL:1;SRVR:SYCPR01MB3501;H:SYCPR01MB5086.ausprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: pauljones.id.au does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QYvxCIvJbHCXguuTDqdFP+Tl+q5yX5KgmD6tEbZ1Hrp5Nrd8giET6BEDF+rkJWvh+F85Ng/Q1gkL6VJAlRWamXOegcSvX4gl/VPek+d8OLcAA0xwjp5H2pZyWIfx+8AFP0Ya63RaeW58C/NUD7aGCqSboYxSzt3bmapgSFMSX+D3oG72/4wrjQ+RGwo2WlQTU5/xn91Ybrxe0bwWxkwFbozr8UWWswthz5JxKrsoFuW08XLgckz00JYwljccp+qM8aTJIK+f+ctFL6KBb9xQFCzsGe5NSP9LOYYtiMObX6FjJ8ZC9VrmBPtyEUWQbT3K0gVoarym5k7AChA6xmPqQb6pEZypC7i0YoD3oy21P1XuCAzl9e1qVPvD6K48ShUw3KTk3gjvqDxxg+WjOLL7YJ/4+81hhdANT0V0//H+vu0=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: pauljones.id.au
X-MS-Exchange-CrossTenant-Network-Message-Id: 68443c50-ae8a-470f-1de3-08d727adb798
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2019 09:38:55.7840
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8f216723-e13f-4cce-b84c-58d8f16a0082
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c2DUsvEnRYAJJb7f1rn1ZSUoHl5WHxAp5QA/4SdFC6icrP9fmLixPw8/uky2+9synLYZCBdTiHHzRzzWoH1S3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYCPR01MB3501
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBsaW51eC1idHJmcy1vd25lckB2
Z2VyLmtlcm5lbC5vcmcgPGxpbnV4LWJ0cmZzLQ0KPiBvd25lckB2Z2VyLmtlcm5lbC5vcmc+IE9u
IEJlaGFsZiBPZiBQZXRlciBCZWNrZXINCj4gU2VudDogRnJpZGF5LCAyMyBBdWd1c3QgMjAxOSAx
OjQwIEFNDQo+IFRvOiBIb2xnZXIgSG9mZnN0w6R0dGUgPGhvbGdlckBhcHBsaWVkLWFzeW5jaHJv
bnkuY29tPg0KPiBDYzogTGludXggQlRSRlMgTWFpbGluZ2xpc3QgPGxpbnV4LWJ0cmZzQHZnZXIu
a2VybmVsLm9yZz4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAwLzRdIFN1cHBvcnQgeHhoYXNo
NjQgY2hlY2tzdW1zDQo+IA0KPiBBbSBEby4sIDIyLiBBdWcuIDIwMTkgdW0gMTY6NDEgVWhyIHNj
aHJpZWIgSG9sZ2VyIEhvZmZzdMOkdHRlDQo+IDxob2xnZXJAYXBwbGllZC1hc3luY2hyb255LmNv
bT46DQo+ID4gYnV0IGhvdyBkb2VzIGJ0cmZzIGJlbmVmaXQgZnJvbSB0aGlzIGNvbXBhcmVkIHRv
IHVzaW5nIGNyYzMyLWludGVsPw0KPiANCj4gQXMgaSBrbm93LCBjcmMzMmMgIGlzIGFzIGZhciBh
cyB+M3ggZmFzdGVyIHRoYW4geHhoYXNoLiBCdXQgeHhIYXNoIHdhcyBjcmVhdGVkDQo+IHdpdGgg
YSBkaWZmZXJlbmQgZGVzaWduIGdvYWwuDQo+IElmIHlvdSB1c2luZyBhIGNwdSB3aXRob3V0IGhh
cmR3YXJlIGNyYzMyIHN1cHBvcnQsIHh4SGFzaCBwcm92aWRlcyB5b3UgYQ0KPiBtYXhpbXVtIHBv
cnRhYmlsaXR5IGFuZCBzcGVlZC4gTG9vayBhdCBhcm0sIG1pcHMsIHBvd2VyLCBldGMuIG9yIG9s
ZCBpbnRlbA0KPiBjcHVzIGxpa2UgQ29yZSAyIER1by4NCg0KSSd2ZSBnb3QgYSBtb2RpZmllZCB2
ZXJzaW9uIG9mIHNtaGFzaGVyIChodHRwczovL2dpdGh1Yi5jb20vUGVlSmF5L3NtaGFzaGVyKSB0
aGF0IHRlc3RzIHNwZWVkIGFuZCBjcnlwdG9ncmFwaGljcyBvZiB2YXJpb3VzIGhhc2hpbmcgZnVu
Y3Rpb25zLg0KDQpDcmMzMiBTb2Z0d2FyZSAtICAzNzkuOTEgTWlCL3NlYw0KQ3JjMzIgSGFyZHdh
cmUgLSA3MzM4LjYwIE1pQi9zZWMNClhYaGFzaDY0IFNvZnR3YXJlIC0gMTIwOTQuNDAgTWlCL3Nl
Yw0KDQpUZXN0aW5nIGRvbmUgb24gYSAxc3QgR2VuIFJ5emVuLiBJbXByZXNzaXZlIG51bWJlcnMg
ZnJvbSBYWGhhc2g2NC4NCg0KDQpQYXVsLg0K
