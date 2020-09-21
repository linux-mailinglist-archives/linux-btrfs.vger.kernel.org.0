Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26246271EAD
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Sep 2020 11:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbgIUJOJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Sep 2020 05:14:09 -0400
Received: from mail-eopbgr680040.outbound.protection.outlook.com ([40.107.68.40]:29435
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726333AbgIUJOJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Sep 2020 05:14:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jU1ojZ+A9eRowPTAMaXrGXrZKUkrsxyYgbP26F9pfevuwCKgSpTL87wLWCdW6dRc6H9mnyWujB4q/qeCeZBdZFaRBiwRcdkkUkNqCru+M2PVPISMmNprP4fCgtS2udOv6faabd9HeZdSf9at0QKIbx8NX5F4IaOGP+ugZPi0T1jOJE2VX8eNUuRD17SxzDF/NjeAHyME3ciDpzNm5hSdrYyeM3hNnonFVVeSKDNU6zP4U9fS8iMEEOms+ebcs0mVpJoR/znwAOIviXBKuIe5352oSxNEU/oMm+a+wkiTRo3uhyArdJTBx4aBYpInQTedQREBUuNFulURNxztsuFZpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G60pD7ap3mHqVfCcjDmjCEAPiy1kqAFen5u8A2GClPI=;
 b=h+yrv9c17md830eE+UdJb8QtQ2GM0BjeIvcD06lvU5wgbwMqRSDniNZL5hIKYaw16KeXGq4T798WNeL2iDigtas4l8/lP0hCm+W2JxJOZIkw1VM5HdopftsahdBhotn6Kzbdj1vdr9f/Jps+FhBFl2Y7ePMifMTeL8aypoi0CP39pJSUEm//X2LKJvgJ8+LhbFcQKi4x3vMU9rXQJsNEwitIbJ9LILDpqZh83KPxrShFptHdxE4IJ2+RJr3dCSerpVVhdXJ9D7bAGJBzelyXiKguc505YIYju+KZRCZ3ciX9ePY0yBeK3jV9t/9RHeLiDhjfy0GX6l+9wrO3PJyEiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G60pD7ap3mHqVfCcjDmjCEAPiy1kqAFen5u8A2GClPI=;
 b=LWcJxrUlODMjnvimKf50MIMx2Cby4KuGS4rAERVTkJTepYdajljBq3MWsiGcB0g1Qy3++mrDT2kTIeJtvM3BB73SacKN9ikslAPHSlKztBT3IQWKnUz+ZCQb/wa5c8kF/dXDQHb3NJ0IspVY6CM9kPzpOEp2wDiFC+0aEbaxv5w=
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by BY5PR11MB4353.namprd11.prod.outlook.com (2603:10b6:a03:1b9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.19; Mon, 21 Sep
 2020 09:14:06 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::21a8:8895:6487:5126]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::21a8:8895:6487:5126%6]) with mapi id 15.20.3391.023; Mon, 21 Sep 2020
 09:14:06 +0000
From:   "Zhang, Qiang" <Qiang.Zhang@windriver.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "clm@fb.com" <clm@fb.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "syzbot+582e66e5edf36a22c7b0@syzkaller.appspotmail.com" 
        <syzbot+582e66e5edf36a22c7b0@syzkaller.appspotmail.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?u9i4tDogW1BBVENIXSBidHJmczogRml4IG1pc3NpbmcgY2xvc2UgZGV2aWNl?=
 =?gb2312?Q?s?=
Thread-Topic: [PATCH] btrfs: Fix missing close devices
Thread-Index: AQHWj/EJrizd+uroCEKNW01JQmJ8YKlyzrlJ
Date:   Mon, 21 Sep 2020 09:14:06 +0000
Message-ID: <BYAPR11MB2632211F4D65A009DAF5D507FF3A0@BYAPR11MB2632.namprd11.prod.outlook.com>
References: <20200921082637.26009-1-qiang.zhang@windriver.com>,<SN4PR0401MB3598AD645D54CF397612EE429B3A0@SN4PR0401MB3598.namprd04.prod.outlook.com>
In-Reply-To: <SN4PR0401MB3598AD645D54CF397612EE429B3A0@SN4PR0401MB3598.namprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=windriver.com;
x-originating-ip: [60.247.85.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 015e97a6-d8a2-4f90-8d8f-08d85e0eb0d8
x-ms-traffictypediagnostic: BY5PR11MB4353:
x-microsoft-antispam-prvs: <BY5PR11MB4353D638F29B80464815F583FF3A0@BY5PR11MB4353.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:635;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tdgOVi+n5ugUTdLsI46Fh33NVh29AuC8m8dwUXWYNdvhxujtFAmb2CLGO3/Ibtif46ZSYTL7k3K3GYQCdQtZDvUH2FVTawPZ2wuPz4HmvO+e6Xbzwq5Vx4ms9FXRXi8KPEygDcjUO28zkvNLdJtO57McYq2nLhf2ehE4XYzu6m6EAGl2XNNStrLe3bMfWTbIlDASsh+WMrSIs0fKekLexNVGQ4VToWCijjQveUPjGQ6opq5YkjUxXndgp+7n3LnMtEHVx2mSrbeaLZmRQSD4tDqdMDv70k3ub2xhU8A/I/9hr3ceKDz0DcXXeqkMgYtlOab8NtNz0T6Aso8WO1L9DA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2632.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39840400004)(136003)(376002)(366004)(396003)(346002)(186003)(478600001)(55016002)(26005)(9686003)(86362001)(54906003)(7696005)(4326008)(224303003)(6506007)(53546011)(110136005)(5660300002)(316002)(91956017)(66946007)(66446008)(71200400001)(66556008)(76116006)(64756008)(8936002)(2906002)(52536014)(83380400001)(33656002)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: RYqBjCjKwmIccuKEJwJoOYy3pTiMEUj0ADCX8ODaGga58cOvI7CpAEoLUSGbhh2Kix76Ss0BvNnV+sJjSd0SH9Ha+khZs8bsHPEPZDeN4up5MkUUnpyo+GDjAP3CeqG4ViKGBYWufI66Y6U+ABvcbEcMjegsf1+nwjNAl70AxYv1dl5kO9J8WbZn0QW+eehF3QeMi0YKy+gugHxz7GnbTA4bZFOO9LNfz2pNl/24ksVRTzons9GH9uTNbBhB48MJ4YqKqwgn9qSlPWllNLvg4e+6gz9xMYhiJwQOi3vCFRv65Y50w58POFja2hsrES25g8gcVIGcgEkQVFNMvTLAoNneQluh7SBC3tMTCopf1w1OoOXPpyvuGV0S3Hx8Sz5QbvLzTBPXj0KhMErT2Bl9IB9iZyCMUxZfepEoiIV5lw5XTqW02VAs1g95YYeJ/y6EtYIRi8xQlvR4w2qVi7iKaYOGLt7T9XcOx/TcnTm0kz0b70jB3a1kuTQ5pwNAHsm0EMXm1pyqDGcZ5cnR5v7/DJTFWG4LE0PC4gYteJfEFLZvX0EpOAXd9C2/NlmyU6w2IeCvDk16tTTcSlAZf2zeNyU+XOmoWt0FPNDbRO9Scv7DjtVYj1zLAnBC8/LMWzab1tN97xNrM1+Vi3e3LylzQw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 015e97a6-d8a2-4f90-8d8f-08d85e0eb0d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2020 09:14:06.1260
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +6Jljscv1l8hEspma9QAlerIzhtwOQkff+0UPdDvHyzuVwkVFwGEIeIa070XQCx/KK8k3temsrLdcbZpCKpJORf6RdS6RAltUsRHFU8go5M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4353
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCreivP7IyzogSm9oYW5u
ZXMgVGh1bXNoaXJuIDxKb2hhbm5lcy5UaHVtc2hpcm5Ad2RjLmNvbT4Kt6LLzcqxvOQ6IDIwMjDE
6jnUwjIxyNUgMTY6NTIKytW8/sjLOiBaaGFuZywgUWlhbmc7IGNsbUBmYi5jb207IGpvc2VmQHRv
eGljcGFuZGEuY29tOyBkc3RlcmJhQHN1c2UuY29tCrOty806IGxpbnV4LWJ0cmZzQHZnZXIua2Vy
bmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZwrW98ziOiBSZTogW1BBVENIXSBi
dHJmczogRml4IG1pc3NpbmcgY2xvc2UgZGV2aWNlcwoKT24gMjEvMDkvMjAyMCAxMDoyNywgcWlh
bmcuemhhbmdAd2luZHJpdmVyLmNvbSB3cm90ZToKPiBGcm9tOiBacWlhbmcgPHFpYW5nLnpoYW5n
QHdpbmRyaXZlci5jb20+Cj4KPiBXaGVuIHRoZSBidHJmcyBmaWxsIHN1cGVyIGVycm9yLCB3ZSBz
aG91bGQgZmlyc3QgY2xvc2UgZGV2aWNlcyBhbmQKPiB0aGVuIGNhbGwgZGVhY3RpdmF0ZV9sb2Nr
ZWRfc3VwZXIgZnVuYyB0byBmcmVlIGZzX2luZm8uCj4KPiBTaWduZWQtb2ZmLWJ5OiBacWlhbmcg
PHFpYW5nLnpoYW5nQHdpbmRyaXZlci5jb20+Cj4gLS0tCj4gIGZzL2J0cmZzL3N1cGVyLmMgfCAx
ICsKPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCj4KPiBkaWZmIC0tZ2l0IGEvZnMv
YnRyZnMvc3VwZXIuYyBiL2ZzL2J0cmZzL3N1cGVyLmMKPiBpbmRleCA4ODQwYTRmYTgxZWIuLjNi
ZmQ1NGU4ZjM4OCAxMDA2NDQKPiAtLS0gYS9mcy9idHJmcy9zdXBlci5jCj4gKysrIGIvZnMvYnRy
ZnMvc3VwZXIuYwo+IEBAIC0xNjc1LDYgKzE2NzUsNyBAQCBzdGF0aWMgc3RydWN0IGRlbnRyeSAq
YnRyZnNfbW91bnRfcm9vdChzdHJ1Y3QgZmlsZV9zeXN0ZW1fdHlwZSAqZnNfdHlwZSwKPiAgICAg
ICAgICAgICAgIGVycm9yID0gc2VjdXJpdHlfc2Jfc2V0X21udF9vcHRzKHMsIG5ld19zZWNfb3B0
cywgMCwgTlVMTCk7Cj4gICAgICAgc2VjdXJpdHlfZnJlZV9tbnRfb3B0cygmbmV3X3NlY19vcHRz
KTsKPiAgICAgICBpZiAoZXJyb3IpIHsKPiArICAgICAgICAgICAgIGJ0cmZzX2Nsb3NlX2Rldmlj
ZXMoZnNfZGV2aWNlcyk7Cj4gICAgICAgICAgICAgICBkZWFjdGl2YXRlX2xvY2tlZF9zdXBlcihz
KTsKPiAgICAgICAgICAgICAgIHJldHVybiBFUlJfUFRSKGVycm9yKTsKPiAgICAgICB9Cj4KCj5J
IHRoaW5rIHRoaXMgaXMgdGhlIGZpeCBmb3IgdGhlIHN5emthbGxlciBpc3N1ZToKPlJlcG9ydGVk
LWJ5OiBzeXpib3QrNTgyZTY2ZTVlZGYzNmEyMmM3YjBAc3l6a2FsbGVyLmFwcHNwb3RtYWlsLmNv
bQoKUGxlYXNlICB0cnkgdGhpcyBwYXRjaC4K
