Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2567E27F2F7
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Sep 2020 22:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729742AbgI3UGr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Sep 2020 16:06:47 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:36008 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725355AbgI3UGq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Sep 2020 16:06:46 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08UK5pCZ001683;
        Wed, 30 Sep 2020 13:06:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=QrEustfQaUyP/3UPingB/qC54bWQWakhMeaD5/tFH/c=;
 b=GvygUPW7sZG3l3bcIHIBofridGTNPt5RpWy+/CCQSsm397A/mBzjdyhQiz/Dgdob4Jln
 2JbcO7sk+K780nBMLJjT65GLeel0diAwrUr+xHFbxxAMyeQyTApAelxdBE8GWTgCG2hr
 bOpiZJsvxZjeQc++aUeQwXgiVD2xj2ixaDk= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 33vvgrhm6q-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 30 Sep 2020 13:06:01 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 30 Sep 2020 13:05:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j7zKHy2g7l3rQsXamWHkU2t8yDT2jlIxDSJ47NjaNlyIeteRlYw9dE9zZEHfoRd44ADYC8vv4vi5ALilwU9g0yBzFatASB5/+dd2dj14S/1nZ53dwUIrvTie9yiaWYOhlLvsTLhvmBCM++vw9RDmcmLOiZ6b9llPihOW4JrpAVCPhGChhpO8inIAMsbapLcC6yQFa3MJf15z74ticz6JBORPDevgG8VpxJDkjfen3dcmZmrEbT8tXUADMX3qSmC1AA0zyq9XzbKQ1HtEgPi1RW0mAtbQJyMr6yHFi0HMVVyNXzsuKf7vxulfs+9tlD8pF+dHCWPV48C74gdE41e9dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QrEustfQaUyP/3UPingB/qC54bWQWakhMeaD5/tFH/c=;
 b=EVTbCdJCTPh3xHWBhJxcjfPQQGR7eyhA3Ckpv8FoanQTG3QMylc75YfKjLsCP+WnmJpywH7i2cXsY+XwwRr5I6zN5A2+lUiOygIL8W0s2hp10TJR5Bc4z3XhZYxO8ZGEIION0Cz5fOZoaw6e2Eq5yPWZyi+DQ+N7BygTE8sacuGJ/EbOZmUBQctkis6apAF7JUcODztUsYTSe9G3+L0R60KlucPOfYt6s52QsdH3FB7CCQiyGucOUxj61gBOVjfPjrakh56GdPVy1q+UiMSBSBOw9D47wE3ZOxxqdnjNZKp1hTynqk53mTgQrIdouDHQwK2Ecu2M/UTMmNycA7l0Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QrEustfQaUyP/3UPingB/qC54bWQWakhMeaD5/tFH/c=;
 b=PIUKb6cKHXuZVFqZY27YK+sYECoe74+yUVNGUFhJZRGJZ/fNKUWdN4sUFHi+zvEusiebW5r4vcE16j8RYHmCY7FQEAm3kBjTaxVKKWl14FWUqDwZ/+UcbjBbqc/E1aF4IAZnsSBRWAHSTFQF9PQ9n/NSw1t7TBb8ZmCaCXuZbiE=
Received: from BY5PR15MB3667.namprd15.prod.outlook.com (2603:10b6:a03:1f9::18)
 by BYAPR15MB2408.namprd15.prod.outlook.com (2603:10b6:a02:85::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.29; Wed, 30 Sep
 2020 20:05:45 +0000
Received: from BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::2d08:987a:126:1c9c]) by BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::2d08:987a:126:1c9c%7]) with mapi id 15.20.3412.029; Wed, 30 Sep 2020
 20:05:45 +0000
From:   Nick Terrell <terrelln@fb.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     Nick Terrell <nickrterrell@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        "squashfs-devel@lists.sourceforge.net" 
        <squashfs-devel@lists.sourceforge.net>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>, Chris Mason <clm@fb.com>,
        Petr Malat <oss@malat.biz>, Johannes Weiner <jweiner@fb.com>,
        Niket Agarwal <niketa@fb.com>, Yann Collet <cyan@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 0/9] Update to zstd-1.4.6
Thread-Topic: [PATCH v4 0/9] Update to zstd-1.4.6
Thread-Index: AQHWlvXiaMJXVTfuy0uJI/ZnL66KB6mAvuoAgADdUgA=
Date:   Wed, 30 Sep 2020 20:05:45 +0000
Message-ID: <8743398B-0BBB-424E-A6A7-9D8AE4EFE8ED@fb.com>
References: <20200930065318.3326526-1-nickrterrell@gmail.com>
 <20200930065336.GA13656@infradead.org>
In-Reply-To: <20200930065336.GA13656@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:4b41]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a751936f-809e-4cce-2789-08d8657c37a2
x-ms-traffictypediagnostic: BYAPR15MB2408:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB240832F8552491AE6E47AAD4AB330@BYAPR15MB2408.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0SFJMZaxyzcsGd6RHsPV1ZfpTskPpdJIM/T15YfsScinQy3hsvkaxIHaHiY+bGF/ILoGiC6ixcJZz+WlgCl8xpCXxm9cXpBPlAwN3oBVNZUXhb0BZi2qlyawNm6YttheYqVm2k8sNDvs1AC0dyataiEioLvoQ86BeZ089DPmVMStMPuBZq17/5HRgUf26M/7PG9cTV/8leJk3JOfJKN7opucPld+qvzUeE7Dqt8ozPYtE1QboRGJuSszaSA5bqrxMMIB7qADIlfwQxWXf3Ilb0yont0USSqBvNE3yo6uxEuAXpm3GV/nRQgyPd4eKYzsv+FCLY+UPMzYK096dKZvMWGKT12vIUW+md3n9vjxPbdV/ngijNVaxFcSApHWNpCxiqZAJEO/TC1C2GzV1BqdhrsJsyjCUKncZkEO0XwZrSuZszxQIxD+Ehk4TZsF+OSgHqnuEgfRhPnz0yRU18yqPg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3667.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(366004)(396003)(39860400002)(136003)(2906002)(36756003)(71200400001)(8936002)(30864003)(5660300002)(478600001)(6506007)(83380400001)(86362001)(6486002)(76116006)(66556008)(316002)(966005)(54906003)(66446008)(4326008)(53546011)(8676002)(64756008)(66946007)(66476007)(6512007)(7416002)(2616005)(186003)(6916009)(33656002)(91956017)(15650500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: TrSN9csmYTUh5rRCoYjTiabbWh0G9cBQz5QXzWZTkFHTbwCBCh2kEKU7aJr2ggFky/Kov4CaM5vFwFfiMbZf39jXq009byY7+jpBZpJWe2eYnMBa5NEJt8o9c+tyOoQ1cFhPLDg/Qv7xlif2MYg74tju675OgmkQZJKI18v9V6zEXLiMxZs7PUnhjJwzyrtbkcRKHrODtJbGskIcPUkptUIPRbOzxQGtUFCUxiS7W9lDPMXJLSIVagcEMBFwvS0LAJEEMfyM8NFevaTXluC2zi3HRBCxSaKKfFeVuUD3YI6HK8nw6UVWvOpTEMl/4h+6jGVv5ETqzNfe/SY0f6V+dhsmDypvtKq7a6vKRZ7ivHyUoLo+C5stKp667jQJL2g+00Kfon+PI1PBGHGea69TAFwnAg7pXKMyXO/O6/+YQmPptbAhDbFW+NiA+bPGJiV+zvgGX2SBlDUCTH7SrOJYgPFqREew426MsDDizVPfUHKdt+e3iTj1ymNYwJejqY/SBN4Xa/c61msq0mtyMBh7YdVztTKJLUxwo+lVd2JDk5XFsfZQYS9Rb8KIUw4MyeCHLG0ZtEX85mL9KAXojRffL6RQaNBRPQ8kikXmDGfSgVKLfs8cZ2h631kZG7afsNiFMYbDyxvR+J5KoTQ+HkH/RZX1tDSgrWx/T/zZflJT5qbO3kusHrGdwC7VWhGXAeop
Content-Type: text/plain; charset="utf-8"
Content-ID: <53BD93F5062CE34D831ED9A447A7C73C@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3667.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a751936f-809e-4cce-2789-08d8657c37a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2020 20:05:45.4340
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fnnDCN9zKsBzKVWiCyvxQ10ZdF0wqQUC6JV5QYY4KYFDCM83JSzHOtooFPzh8WDd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2408
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-30_10:2020-09-30,2020-09-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 clxscore=1011 phishscore=0 mlxscore=0 bulkscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009300162
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

DQoNCj4gT24gU2VwIDI5LCAyMDIwLCBhdCAxMTo1MyBQTSwgQ2hyaXN0b3BoIEhlbGx3aWcgPGhj
aEBpbmZyYWRlYWQub3JnPiB3cm90ZToNCj4gDQo+IEFzIHlvdSBrZWVwIHJlc2VuZCB0aGlzIEkg
a2VlcCByZXRlbGxpbmcgeW91IHRoYXQgc2hvdWxkIG5vdCBkbyBpdC4NCj4gUGxlYXNlIHByb3Zp
ZGUgYSBwcm9wZXIgTGludXggQVBJLCBhbmQgc3dpdGNoIHRvIHRoYXQuICBWZXJzaW9uZWQgQVBJ
cw0KPiBoYXZlIGFic29sdXRlbHkgbm8gYnVzaW5lc3MgaW4gdGhlIExpbnV4IGtlcm5lbC4NCg0K
VGhlIEFQSSBpcyBub3QgdmVyc2lvbmVkLiBXZSBwcm92aWRlIGEgc3RhYmxlIEFCSSBmb3IgYSBs
YXJnZSBzZWN0aW9uIG9mIG91ciBBUEksDQphbmQgdGhlIHBhcnRzIHRoYXQgYXJlbuKAmXQgQUJJ
IHN0YWJsZSBkb27igJl0IGNoYW5nZSBpbiBzZW1hbnRpY3MsIGFuZCB1bmRlcmdvIGxvbmcNCmRl
cHJlY2F0aW9uIHBlcmlvZHMgYmVmb3JlIGJlaW5nIHJlbW92ZWQuDQoNClRoZSBjaGFuZ2Ugb2Yg
Y2FsbGVycyBpcyBhIG9uZS10aW1lIGNoYW5nZSB0byB0cmFuc2l0aW9uIGZyb20gdGhlIGV4aXN0
aW5nIEFQSQ0KaW4gdGhlIGtlcm5lbCwgd2hpY2ggd2FzIG5ldmVyIHVwc3RyZWFtJ3MgQVBJLCB0
byB1cHN0cmVhbSdzIEFQSS4NCg0KLU5pY2sNCg0KPiBPbiBUdWUsIFNlcCAyOSwgMjAyMCBhdCAx
MTo1MzowOVBNIC0wNzAwLCBOaWNrIFRlcnJlbGwgd3JvdGU6DQo+PiBGcm9tOiBOaWNrIFRlcnJl
bGwgPHRlcnJlbGxuQGZiLmNvbT4NCj4+IA0KPj4gVGhpcyBwYXRjaHNldCB1cGdyYWRlcyB0aGUg
enN0ZCBsaWJyYXJ5IHRvIHRoZSBsYXRlc3QgdXBzdHJlYW0gcmVsZWFzZS4gVGhlDQo+PiBjdXJy
ZW50IHpzdGQgdmVyc2lvbiBpbiB0aGUga2VybmVsIGlzIGEgbW9kaWZpZWQgdmVyc2lvbiBvZiB1
cHN0cmVhbSB6c3RkLTEuMy4xLg0KPj4gQXQgdGhlIHRpbWUgaXQgd2FzIGludGVncmF0ZWQsIHpz
dGQgd2Fzbid0IHJlYWR5IHRvIGJlIHVzZWQgaW4gdGhlIGtlcm5lbCBhcy1pcy4NCj4+IEJ1dCwg
aXQgaXMgbm93IHBvc3NpYmxlIHRvIHVzZSB1cHN0cmVhbSB6c3RkIGRpcmVjdGx5IGluIHRoZSBr
ZXJuZWwuDQo+PiANCj4+IEkgaGF2ZSBub3QgeWV0IHJlbGVhc2UgenN0ZC0xLjQuNiB1cHN0cmVh
bS4gSSB3YW50IHRoZSB6c3RkIHZlcnNpb24gaW4gdGhlIGtlcm5lbA0KPj4gdG8gbWF0Y2ggdXAg
d2l0aCBhIGtub3duIHVwc3RyZWFtIHJlbGVhc2UsIHNvIHdlIGtub3cgZXhhY3RseSB3aGF0IGNv
ZGUgaXMNCj4+IHJ1bm5pbmcuIFdoZW5ldmVyIHRoaXMgcGF0Y2hzZXQgaXMgcmVhZHkgZm9yIG1l
cmdlLCBJIHdpbGwgY3V0IGEgcmVsZWFzZSBhdCB0aGUNCj4+IHVwc3RyZWFtIGNvbW1pdCB0aGF0
IGdldHMgbWVyZ2VkLiBUaGlzIHNob3VsZCBub3QgYmUgbmVjZXNzYXJ5IGZvciBmdXR1cmUNCj4+
IHJlbGVhc2VzLg0KPj4gDQo+PiBUaGUga2VybmVsIHpzdGQgbGlicmFyeSBpcyBhdXRvbWF0aWNh
bGx5IGdlbmVyYXRlZCBmcm9tIHVwc3RyZWFtIHpzdGQuIEEgc2NyaXB0DQo+PiBtYWtlcyB0aGUg
bmVjZXNzYXJ5IGNoYW5nZXMgYW5kIGltcG9ydHMgaXQgaW50byB0aGUga2VybmVsLiBUaGUgY2hh
bmdlcyBhcmU6DQo+PiANCj4+IDEuIFJlcGxhY2UgYWxsIGxpYmMgZGVwZW5kZW5jaWVzIHdpdGgg
a2VybmVsIHJlcGxhY2VtZW50cyBhbmQgcmV3cml0ZSBpbmNsdWRlcy4NCj4+IDIuIFJlbW92ZSB1
bm5jZXNzYXJ5IHBvcnRhYmlsaXR5IG1hY3JvcyBsaWtlOiAjaWYgZGVmaW5lZChfTVNDX1ZFUiku
DQo+PiAzLiBVc2UgdGhlIGtlcm5lbCB4eGhhc2ggaW5zdGVhZCBvZiBidW5kbGluZyBpdC4NCj4+
IA0KPj4gVGhpcyBhdXRvbWF0aW9uIGdldHMgdGVzdGVkIGV2ZXJ5IGNvbW1pdCBieSB1cHN0cmVh
bSdzIGNvbnRpbnVvdXMgaW50ZWdyYXRpb24uDQo+PiBXaGVuIHdlIGN1dCBhIG5ldyB6c3RkIHJl
bGVhc2UsIHdlIHdpbGwgc3VibWl0IGEgcGF0Y2ggdG8gdGhlIGtlcm5lbCB0byB1cGRhdGUNCj4+
IHRoZSB6c3RkIHZlcnNpb24gaW4gdGhlIGtlcm5lbC4NCj4+IA0KPj4gSSd2ZSB1cGRhdGVkIHpz
dGQgdG8gdXBzdHJlYW0gd2l0aCBvbmUgYmlnIHBhdGNoIGJlY2F1c2UgZXZlcnkgY29tbWl0IG11
c3QgYnVpbGQsDQo+PiBzbyB0aGF0IHByZWNsdWRlcyBwYXJ0aWFsIHVwZGF0ZXMuIFNpbmNlIHRo
ZSBjb21taXQgaXMgMTAwJSBnZW5lcmF0ZWQsIEkgaG9wZSB0aGUNCj4+IHJldmlldyBidXJkZW4g
aXMgbGlnaHRlbmVkLiBJIGNvbnNpZGVyZWQgcmVwbGF5aW5nIHVwc3RyZWFtIGNvbW1pdHMsIGJ1
dCB0aGF0IGlzDQo+PiBub3QgcG9zc2libGUgYmVjYXVzZSB0aGVyZSBoYXZlIGJlZW4gfjM1MDAg
dXBzdHJlYW0gY29tbWl0cyBzaW5jZSB0aGUgbGFzdCB6c3RkDQo+PiBpbXBvcnQsIGFuZCB0aGUg
Y29tbWl0cyBkb24ndCBhbGwgYnVpbGQgaW5kaXZpZHVhbGx5LiBUaGUgYnVsayB1cGRhdGUgcHJl
c2VydmVzDQo+PiBiaXNlY3RhYmxpdHkgYmVjYXVzZSBidWdzIGNhbiBiZSBiaXNlY3RlZCB0byB0
aGUgenN0ZCB2ZXJzaW9uIHVwZGF0ZS4gQXQgdGhhdA0KPj4gcG9pbnQgdGhlIHVwZGF0ZSBjYW4g
YmUgcmV2ZXJ0ZWQsIGFuZCB3ZSBjYW4gd29yayB3aXRoIHVwc3RyZWFtIHRvIGZpbmQgYW5kIGZp
eA0KPj4gdGhlIGJ1Zy4gQWZ0ZXIgdGhpcyBiaWcgc3dpdGNoIGluIGhvdyB0aGUga2VybmVsIGNv
bnN1bWVzIHpzdGQsIGZ1dHVyZSBwYXRjaGVzDQo+PiB3aWxsIGJlIHNtYWxsZXIsIGJlY2F1c2Ug
dGhleSB3aWxsIG9ubHkgaGF2ZSBvbmUgdXBzdHJlYW0gcmVsZWFzZSB3b3J0aCBvZg0KPj4gY2hh
bmdlcyBlYWNoLg0KPj4gDQo+PiBUaGlzIHBhdGNoc2V0IGNoYW5nZXMgdGhlIHpzdGQgQVBJIGZy
b20gYSBjdXN0b20ga2VybmVsIEFQSSB0byB0aGUgdXBzdHJlYW0gQVBJLg0KPj4gSSBjb25zaWRl
cmVkIHdyYXBwaW5nIHRoZSB1cHN0cmVhbSBBUEkgd2l0aCBhIHdyYXBwZXIgdGhhdCBpcyBjbG9z
ZXIgdG8gdGhlDQo+PiBrZXJuZWwgc3R5bGUgZ3VpZGUuIEZvbGxvd2luZyBhZHZpc2UgZnJvbSBo
dHRwczovL2xrbWwub3JnL2xrbWwvMjAyMC85LzE3LzgxNA0KPj4gSSd2ZSBjaG9zZW4gdG8gdXNl
IHRoZSB1cHN0cmVhbSBBUEkgZGlyZWN0bHksIHRvIG1pbmltaXplIG9wcG9ydHVuaXRpZXMgdG8N
Cj4+IGludHJvZHVjZSBidWdzLCBhbmQgYmVjYXVzZSB1c2luZyB0aGUgdXBzdHJlYW0gQVBJIGRp
cmVjdGx5IG1ha2VzIGRlYnVnZ2luZyBhbmQNCj4+IGNvbW11bmljYXRpb24gd2l0aCB1cHN0cmVh
bSBlYXNpZXIuDQo+PiANCj4+IFRoaXMgcGF0Y2hzZXQgY29tZXMgaW4gMyBwYXJ0czoNCj4+IDEu
IFRoZSBmaXJzdCAyIHBhdGNoZXMgcHJlcGFyZSBmb3IgdGhlIHpzdGQgdXBncmFkZS4gVGhlIGZp
cnN0IHBhdGNoIGFkZHMgYQ0KPj4gICBjb21wYXRpYmlsaXR5IHdyYXBwZXIgc28genN0ZCBjYW4g
YmUgdXBncmFkZWQgd2l0aG91dCBtb2RpZnlpbmcgYW55IGNhbGxlcnMuDQo+PiAgIFRoZSBzZWNv
bmQgcGF0Y2ggYWRkcyBhbiBpbmRpcmVjdGlvbiBmb3IgdGhlIGxpYi9kZWNvbXByZXNzX3VuenN0
ZC5jIGluY2x1ZGluZw0KPj4gICBvZiBhbGwgZGVjb21wcmVzc2lvbiBzb3VyY2UgZmlsZXMuDQo+
PiAyLiBJbXBvcnQgenN0ZC0xLjQuNi4gVGhpcyBwYXRjaCBpcyBjb21wbGV0ZWx5IGdlbmVyYXRl
ZCBmcm9tIHVwc3RyZWFtIHVzaW5nDQo+PiAgIGF1dG9tYXRlZCB0b29saW5nLg0KPj4gMy4gVXBk
YXRlIGFsbCBjYWxsZXJzIHRvIHRoZSB6c3RkLTEuNC42IEFQSSB0aGVuIGRlbGV0ZSB0aGUgY29t
cGF0aWJpbGl0eQ0KPj4gICB3cmFwcGVyLg0KPj4gDQo+PiBJIHRlc3RlZCBldmVyeSBjYWxsZXIg
b2YgenN0ZCBvbiB4ODZfNjQuIEkgdGVzdGVkIGJvdGggYWZ0ZXIgdGhlIDEuNC42IHVwZ3JhZGUN
Cj4+IHVzaW5nIHRoZSBjb21wYXRpYmlsaXR5IHdyYXBwZXIsIGFuZCBhZnRlciB0aGUgZmluYWwg
cGF0Y2ggaW4gdGhpcyBzZXJpZXMuIA0KPj4gDQo+PiBJIHRlc3RlZCBrZXJuZWwgYW5kIGluaXRy
YW1mcyBkZWNvbXByZXNzaW9uIGluIGkzODYgYW5kIGFybS4NCj4+IA0KPj4gSSByYW4gYmVuY2ht
YXJrcyB0byBjb21wYXJlIHRoZSBjdXJyZW50IHpzdGQgaW4gdGhlIGtlcm5lbCB3aXRoIHpzdGQt
MS40LjYuDQo+PiBJIGJlbmNobWFya2VkIG9uIHg4Nl82NCB1c2luZyBRRU1VIHdpdGggS1ZNIGVu
YWJsZWQgb24gYW4gSW50ZWwgaTktOTkwMGsuDQo+PiBJIGZvdW5kOg0KPj4gKiBCdHJGUyB6c3Rk
IGNvbXByZXNzaW9uIGF0IGxldmVscyAxIGFuZCAzIGlzIDUlIGZhc3Rlcg0KPj4gKiBCdHJGUyB6
c3RkIGRlY29tcHJlc3Npb24rcmVhZCBpcyAxNSUgZmFzdGVyDQo+PiAqIFNxdWFzaEZTIHpzdGQg
ZGVjb21wcmVzc2lvbityZWFkIGlzIDE1JSBmYXN0ZXINCj4+ICogRjJGUyB6c3RkIGNvbXByZXNz
aW9uK3dyaXRlIGF0IGxldmVsIDMgaXMgOCUgZmFzdGVyDQo+PiAqIEYyRlMgenN0ZCBkZWNvbXBy
ZXNzaW9uK3JlYWQgaXMgMjAlIGZhc3Rlcg0KPj4gKiBaUkFNIGRlY29tcHJlc3Npb24rcmVhZCBp
cyAzMCUgZmFzdGVyDQo+PiAqIEtlcm5lbCB6c3RkIGRlY29tcHJlc3Npb24gaXMgMzUlIGZhc3Rl
cg0KPj4gKiBJbml0cmFtZnMgenN0ZCBkZWNvbXByZXNzaW9uK2J1aWxkIGlzIDUlIGZhc3Rlcg0K
Pj4gDQo+PiBUaGUgbGF0ZXN0IHpzdGQgYWxzbyBvZmZlcnMgYnVnIGZpeGVzIGFuZCBhIDEgS0Ig
cmVkdWN0aW9uIGluIHN0YWNrIHVhZ2UgZHVyaW5nDQo+PiBjb21wcmVzc2lvbi4gRm9yIGV4YW1w
bGUgdGhlIHJlY2VudCBwcm9ibGVtIHdpdGggbGFyZ2Uga2VybmVsIGRlY29tcHJlc3Npb24gaGFz
DQo+PiBiZWVuIGZpeGVkIHVwc3RyZWFtIGZvciBvdmVyIDIgeWVhcnMgaHR0cHM6Ly9sa21sLm9y
Zy9sa21sLzIwMjAvOS8yOS8yNy4NCj4+IA0KPj4gUGxlYXNlIGxldCBtZSBrbm93IGlmIHRoZXJl
IGlzIGFueXRoaW5nIHRoYXQgSSBjYW4gZG8gdG8gZWFzZSB0aGUgd2F5IGZvciB0aGVzZQ0KPj4g
cGF0Y2hlcy4gSSB0aGluayBpdCBpcyBpbXBvcnRhbnQgYmVjYXVzZSBpdCBnZXRzIGxhcmdlIHBl
cmZvcm1hbmNlIGltcHJvdmVtZW50cywNCj4+IGNvbnRhaW5zIGJ1ZyBmaXhlcywgYW5kIGlzIHN3
aXRjaGluZyB0byBhIG1vcmUgbWFpbnRhaW5hYmxlIG1vZGVsIG9mIGNvbnN1bWluZw0KPj4gdXBz
dHJlYW0genN0ZCBkaXJlY3RseSwgbWFraW5nIGl0IGVhc3kgdG8ga2VlcCB1cCB0byBkYXRlLg0K
Pj4gDQo+PiBCZXN0LA0KPj4gTmljayBUZXJyZWxsDQo+PiANCj4+IHYxIC0+IHYyOg0KPj4gKiBT
dWNjZXNzZnVsbHkgdGVzdGVkIEYyRlMgd2l0aCBoZWxwIGZyb20gQ2hhbyBZdSB0byBmaXggbXkg
dGVzdC4NCj4+ICogKDEvOSkgRml4IFpTVERfaW5pdENTdHJlYW0oKSB3cmFwcGVyIHRvIGhhbmRs
ZSBwbGVkZ2VkX3NyY19zaXplPTAgbWVhbnMgdW5rbm93bi4NCj4+ICBUaGlzIGZpeGVzIEYyRlMg
d2l0aCB0aGUgenN0ZC0xLjQuNiBjb21wYXRpYmlsaXR5IHdyYXBwZXIsIGV4cG9zZWQgYnkgdGhl
IHRlc3QuDQo+PiANCj4+IHYyIC0+IHYzOg0KPj4gKiAoMy85KSBTaWxlbmNlIHdhcm5pbmdzIGJ5
IEtlcm5lbCBUZXN0IFJvYm90Og0KPj4gIGh0dHBzOi8vZ2l0aHViLmNvbS9mYWNlYm9vay96c3Rk
L3B1bGwvMjMyNA0KPj4gIFN0YWNrIHNpemUgd2FybmluZ3MgcmVtYWluLCBidXQgdGhlc2UgYXJl
bid0IG5ldywgYW5kIHRoZSBmdW5jdGlvbnMgaXQgd2FybnMgb24NCj4+ICBhcmUgZWl0aGVyIHVu
dXNlZCBvciBub3QgaW4gdGhlIG1heGltdW0gc3RhY2sgcGF0aC4gVGhpcyBwYXRjaHNldCByZWR1
Y2VzIHpzdGQNCj4+ICBjb21wcmVzc2lvbiBzdGFjayB1c2FnZSBieSAxIEtCIG92ZXJhbGwuIEkn
dmUgZ290dGVuIHRoZSBsb3cgaGFuZ2luZyBmcnVpdCwgYW5kDQo+PiAgbW9yZSBzdGFjayByZWR1
Y3Rpb24gd291bGQgcmVxdWlyZSBzaWduaWZpY2FudCBjaGFuZ2VzIHRoYXQgaGF2ZSB0aGUgcG90
ZW50aWFsDQo+PiAgdG8gaW50cm9kdWNlIG5ldyBidWdzLiBIb3dldmVyLCBJIGRvIGhvcGUgdG8g
Y29udGludWUgdG8gcmVkdWNlIHpzdGQgc3RhY2sNCj4+ICB1c2FnZSBpbiBmdXR1cmUgdmVyc2lv
bnMuDQo+PiANCj4+IHYzIC0+IHY0Og0KPj4gKiAoMy85KSBGaXggZXJyb3JzIGFuZCB3YXJuaW5n
cyByZXBvcnRlZCBieSBLZXJuZWwgVGVzdCBSb2JvdDoNCj4+ICBodHRwczovL2dpdGh1Yi5jb20v
ZmFjZWJvb2svenN0ZC9wdWxsLzIzMjYNCj4+ICAtIFJlcGxhY2UgbWVtLmggd2l0aCBhIGN1c3Rv
bSBrZXJuZWwgaW1wbGVtZW50YXRpb24gdGhhdCBtYXRjaGVzIHRoZSBjdXJyZW50DQo+PiAgICBs
aWIvenN0ZC9tZW0uaCBpbiB0aGUga2VybmVsLiBUaGlzIGF2b2lkcyBjYWxscyB0byBfX2J1aWx0
aW5fYnN3YXAqKCkgd2hpY2gNCj4+ICAgIGRvbid0IHdvcmsgb24gY2VydGFpbiBhcmNoaXRlY3R1
cmVzLCBhcyBleHBvc2VkIGJ5IHRoZSBLZXJuZWwgVGVzdCBSb2JvdC4NCj4+ICAtIFJlbW92ZSBB
U0FOL01TQU4gKHVuKXBvaXNvbmluZyBjb2RlIHdoaWNoIGRvZXNuJ3Qgd29yayBpbiB0aGUga2Vy
bmVsLCBhcw0KPj4gICAgZXhwb3NlZCBieSB0aGUgS2VybmVsIFRlc3QgUm9ib3QuDQo+PiAgLSBJ
J3ZlIGZpeGVkIGFsbCBvZiB0aGUgdmFsaWQgY3BwY2hlY2sgd2FybmluZ3MgcmVwb3J0ZWQsIGJ1
dCB0aGVyZSB3ZXJlIG1hbnkNCj4+ICAgIGZhbHNlIHBvc2l0aXZlcywgd2hlcmUgY3BwY2hlY2sg
d2FzIGluY29ycmVjdGx5IGFuYWx5emluZyB0aGUgc2l0dWF0aW9uLA0KPj4gICAgd2hpY2ggSSBk
aWQgbm90IGZpeC4gSSBkb24ndCBiZWxpZXZlIGl0IGlzIHJlYXNvbmFibGUgdG8gZXhwZWN0IHRo
YXQgdXBzdHJlYW0NCj4+ICAgIHpzdGQgc2lsZW5jZXMgYWxsIHRoZSBzdGF0aWMgYW5hbHl6ZXIg
ZmFsc2UgcG9zaXRpdmVzLiBVcHN0cmVhbSB6c3RkIHVzZXMNCj4+ICAgIGNsYW5nIHNjYW4tYnVp
bGQgZm9yIGl0cyBzdGF0aWMgYW5hbHlzaXMuIFdlIGZpbmQgdGhhdCBzdXBwb3J0aW5nIG11bHRp
cGxlDQo+PiAgICBzdGF0aWMgYW5hbHlzaXMgdG9vbHMgbXVsdGlwbGllcyB0aGUgYnVyZGVuIG9m
IHNpbGVuY2luZyBmYWxzZSBwb3NpdGl2ZXMsDQo+PiAgICB3aXRob3V0IHByb3ZpZGluZyBlbm91
Z2ggbWFyZ2luYWwgdmFsdWUgb3ZlciBydW5uaW5nIGEgc2luZ2xlIHN0YXRpYyBhbmFseXNpcw0K
Pj4gICAgdG9vbC4NCj4+IA0KPj4gTmljayBUZXJyZWxsICg5KToNCj4+ICBsaWI6IHpzdGQ6IEFk
ZCB6c3RkIGNvbXBhdGliaWxpdHkgd3JhcHBlcg0KPj4gIGxpYjogenN0ZDogQWRkIGRlY29tcHJl
c3Nfc291cmNlcy5oIGZvciBkZWNvbXByZXNzX3VuenN0ZA0KPj4gIGxpYjogenN0ZDogVXBncmFk
ZSB0byBsYXRlc3QgdXBzdHJlYW0genN0ZCB2ZXJzaW9uIDEuNC42DQo+PiAgY3J5cHRvOiB6c3Rk
OiBTd2l0Y2ggdG8genN0ZC0xLjQuNiBBUEkNCj4+ICBidHJmczogenN0ZDogU3dpdGNoIHRvIHRo
ZSB6c3RkLTEuNC42IEFQSQ0KPj4gIGYyZnM6IHpzdGQ6IFN3aXRjaCB0byB0aGUgenN0ZC0xLjQu
NiBBUEkNCj4+ICBzcXVhc2hmczogenN0ZDogU3dpdGNoIHRvIHRoZSB6c3RkLTEuNC42IEFQSQ0K
Pj4gIGxpYjogdW56c3RkOiBTd2l0Y2ggdG8gdGhlIHpzdGQtMS40LjYgQVBJDQo+PiAgbGliOiB6
c3RkOiBSZW1vdmUgenN0ZCBjb21wYXRpYmlsaXR5IHdyYXBwZXINCj4+IA0KPj4gY3J5cHRvL3pz
dGQuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAyMiArLQ0KPj4gZnMvYnRy
ZnMvenN0ZC5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICA0NiArLQ0KPj4gZnMv
ZjJmcy9jb21wcmVzcy5jICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDEwMCArLQ0KPj4g
ZnMvc3F1YXNoZnMvenN0ZF93cmFwcGVyLmMgICAgICAgICAgICAgICAgICAgIHwgICAgNyArLQ0K
Pj4gaW5jbHVkZS9saW51eC96c3RkLmggICAgICAgICAgICAgICAgICAgICAgICAgIHwgMzAyMSAr
KysrKysrKy0tLS0NCj4+IGluY2x1ZGUvbGludXgvenN0ZF9lcnJvcnMuaCAgICAgICAgICAgICAg
ICAgICB8ICAgNzYgKw0KPj4gbGliL2RlY29tcHJlc3NfdW56c3RkLmMgICAgICAgICAgICAgICAg
ICAgICAgIHwgICA0NCArLQ0KPj4gbGliL3pzdGQvTWFrZWZpbGUgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHwgICAzNSArLQ0KPj4gbGliL3pzdGQvYml0c3RyZWFtLmggICAgICAgICAgICAg
ICAgICAgICAgICAgIHwgIDM3OSAtLQ0KPj4gbGliL3pzdGQvY29tbW9uL2JpdHN0cmVhbS5oICAg
ICAgICAgICAgICAgICAgIHwgIDQzNyArKw0KPj4gbGliL3pzdGQvY29tbW9uL2NvbXBpbGVyLmgg
ICAgICAgICAgICAgICAgICAgIHwgIDE1MCArDQo+PiBsaWIvenN0ZC9jb21tb24vY3B1LmggICAg
ICAgICAgICAgICAgICAgICAgICAgfCAgMTk0ICsNCj4+IGxpYi96c3RkL2NvbW1vbi9kZWJ1Zy5j
ICAgICAgICAgICAgICAgICAgICAgICB8ICAgMjQgKw0KPj4gbGliL3pzdGQvY29tbW9uL2RlYnVn
LmggICAgICAgICAgICAgICAgICAgICAgIHwgIDEwMSArDQo+PiBsaWIvenN0ZC9jb21tb24vZW50
cm9weV9jb21tb24uYyAgICAgICAgICAgICAgfCAgMzU1ICsrDQo+PiBsaWIvenN0ZC9jb21tb24v
ZXJyb3JfcHJpdmF0ZS5jICAgICAgICAgICAgICAgfCAgIDU1ICsNCj4+IGxpYi96c3RkL2NvbW1v
bi9lcnJvcl9wcml2YXRlLmggICAgICAgICAgICAgICB8ICAgNjYgKw0KPj4gbGliL3pzdGQvY29t
bW9uL2ZzZS5oICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDcwOSArKysNCj4+IGxpYi96c3Rk
L2NvbW1vbi9mc2VfZGVjb21wcmVzcy5jICAgICAgICAgICAgICB8ICAzODAgKysNCj4+IGxpYi96
c3RkL2NvbW1vbi9odWYuaCAgICAgICAgICAgICAgICAgICAgICAgICB8ICAzNTIgKysNCj4+IGxp
Yi96c3RkL2NvbW1vbi9tZW0uaCAgICAgICAgICAgICAgICAgICAgICAgICB8ICAyNTggKw0KPj4g
bGliL3pzdGQvY29tbW9uL3pzdGRfY29tbW9uLmMgICAgICAgICAgICAgICAgIHwgICA4MyArDQo+
PiBsaWIvenN0ZC9jb21tb24venN0ZF9kZXBzLmggICAgICAgICAgICAgICAgICAgfCAgMTI0ICsN
Cj4+IGxpYi96c3RkL2NvbW1vbi96c3RkX2ludGVybmFsLmggICAgICAgICAgICAgICB8ICA0Mzgg
KysNCj4+IGxpYi96c3RkL2NvbXByZXNzLmMgICAgICAgICAgICAgICAgICAgICAgICAgICB8IDM0
ODUgLS0tLS0tLS0tLS0tLS0NCj4+IGxpYi96c3RkL2NvbXByZXNzL2ZzZV9jb21wcmVzcy5jICAg
ICAgICAgICAgICB8ICA2MjUgKysrDQo+PiBsaWIvenN0ZC9jb21wcmVzcy9oaXN0LmMgICAgICAg
ICAgICAgICAgICAgICAgfCAgMTY1ICsNCj4+IGxpYi96c3RkL2NvbXByZXNzL2hpc3QuaCAgICAg
ICAgICAgICAgICAgICAgICB8ICAgNzUgKw0KPj4gbGliL3pzdGQvY29tcHJlc3MvaHVmX2NvbXBy
ZXNzLmMgICAgICAgICAgICAgIHwgIDc2NCArKysNCj4+IGxpYi96c3RkL2NvbXByZXNzL3pzdGRf
Y29tcHJlc3MuYyAgICAgICAgICAgICB8IDQxNTcgKysrKysrKysrKysrKysrKysNCj4+IGxpYi96
c3RkL2NvbXByZXNzL3pzdGRfY29tcHJlc3NfaW50ZXJuYWwuaCAgICB8IDExMDMgKysrKysNCj4+
IGxpYi96c3RkL2NvbXByZXNzL3pzdGRfY29tcHJlc3NfbGl0ZXJhbHMuYyAgICB8ICAxNTggKw0K
Pj4gbGliL3pzdGQvY29tcHJlc3MvenN0ZF9jb21wcmVzc19saXRlcmFscy5oICAgIHwgICAyOSAr
DQo+PiBsaWIvenN0ZC9jb21wcmVzcy96c3RkX2NvbXByZXNzX3NlcXVlbmNlcy5jICAgfCAgNDMz
ICsrDQo+PiBsaWIvenN0ZC9jb21wcmVzcy96c3RkX2NvbXByZXNzX3NlcXVlbmNlcy5oICAgfCAg
IDU0ICsNCj4+IGxpYi96c3RkL2NvbXByZXNzL3pzdGRfY29tcHJlc3Nfc3VwZXJibG9jay5jICB8
ICA4NDkgKysrKw0KPj4gbGliL3pzdGQvY29tcHJlc3MvenN0ZF9jb21wcmVzc19zdXBlcmJsb2Nr
LmggIHwgICAzMiArDQo+PiBsaWIvenN0ZC9jb21wcmVzcy96c3RkX2N3a3NwLmggICAgICAgICAg
ICAgICAgfCAgNDY1ICsrDQo+PiBsaWIvenN0ZC9jb21wcmVzcy96c3RkX2RvdWJsZV9mYXN0LmMg
ICAgICAgICAgfCAgNTIxICsrKw0KPj4gbGliL3pzdGQvY29tcHJlc3MvenN0ZF9kb3VibGVfZmFz
dC5oICAgICAgICAgIHwgICAzMiArDQo+PiBsaWIvenN0ZC9jb21wcmVzcy96c3RkX2Zhc3QuYyAg
ICAgICAgICAgICAgICAgfCAgNDk2ICsrDQo+PiBsaWIvenN0ZC9jb21wcmVzcy96c3RkX2Zhc3Qu
aCAgICAgICAgICAgICAgICAgfCAgIDMxICsNCj4+IGxpYi96c3RkL2NvbXByZXNzL3pzdGRfbGF6
eS5jICAgICAgICAgICAgICAgICB8IDExMzggKysrKysNCj4+IGxpYi96c3RkL2NvbXByZXNzL3pz
dGRfbGF6eS5oICAgICAgICAgICAgICAgICB8ICAgNjEgKw0KPj4gbGliL3pzdGQvY29tcHJlc3Mv
enN0ZF9sZG0uYyAgICAgICAgICAgICAgICAgIHwgIDYxOSArKysNCj4+IGxpYi96c3RkL2NvbXBy
ZXNzL3pzdGRfbGRtLmggICAgICAgICAgICAgICAgICB8ICAxMDQgKw0KPj4gbGliL3pzdGQvY29t
cHJlc3MvenN0ZF9vcHQuYyAgICAgICAgICAgICAgICAgIHwgMTIwMCArKysrKw0KPj4gbGliL3pz
dGQvY29tcHJlc3MvenN0ZF9vcHQuaCAgICAgICAgICAgICAgICAgIHwgICA1MCArDQo+PiBsaWIv
enN0ZC9kZWNvbXByZXNzLmMgICAgICAgICAgICAgICAgICAgICAgICAgfCAyNTMxIC0tLS0tLS0t
LS0NCj4+IGxpYi96c3RkL2RlY29tcHJlc3MvaHVmX2RlY29tcHJlc3MuYyAgICAgICAgICB8IDEy
MDUgKysrKysNCj4+IGxpYi96c3RkL2RlY29tcHJlc3MvenN0ZF9kZGljdC5jICAgICAgICAgICAg
ICB8ICAyNDEgKw0KPj4gbGliL3pzdGQvZGVjb21wcmVzcy96c3RkX2RkaWN0LmggICAgICAgICAg
ICAgIHwgICA0NCArDQo+PiBsaWIvenN0ZC9kZWNvbXByZXNzL3pzdGRfZGVjb21wcmVzcy5jICAg
ICAgICAgfCAxODM2ICsrKysrKysrDQo+PiBsaWIvenN0ZC9kZWNvbXByZXNzL3pzdGRfZGVjb21w
cmVzc19ibG9jay5jICAgfCAxNTQwICsrKysrKw0KPj4gbGliL3pzdGQvZGVjb21wcmVzcy96c3Rk
X2RlY29tcHJlc3NfYmxvY2suaCAgIHwgICA2MiArDQo+PiAuLi4vZGVjb21wcmVzcy96c3RkX2Rl
Y29tcHJlc3NfaW50ZXJuYWwuaCAgICAgfCAgMTk1ICsNCj4+IGxpYi96c3RkL2RlY29tcHJlc3Nf
c291cmNlcy5oICAgICAgICAgICAgICAgICB8ICAgMTggKw0KPj4gbGliL3pzdGQvZW50cm9weV9j
b21tb24uYyAgICAgICAgICAgICAgICAgICAgIHwgIDI0MyAtDQo+PiBsaWIvenN0ZC9lcnJvcl9w
cml2YXRlLmggICAgICAgICAgICAgICAgICAgICAgfCAgIDUzIC0NCj4+IGxpYi96c3RkL2ZzZS5o
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICA1NzUgLS0tDQo+PiBsaWIvenN0ZC9m
c2VfY29tcHJlc3MuYyAgICAgICAgICAgICAgICAgICAgICAgfCAgNzk1IC0tLS0NCj4+IGxpYi96
c3RkL2ZzZV9kZWNvbXByZXNzLmMgICAgICAgICAgICAgICAgICAgICB8ICAzMjUgLS0NCj4+IGxp
Yi96c3RkL2h1Zi5oICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAyMTIgLQ0KPj4g
bGliL3pzdGQvaHVmX2NvbXByZXNzLmMgICAgICAgICAgICAgICAgICAgICAgIHwgIDc3MiAtLS0N
Cj4+IGxpYi96c3RkL2h1Zl9kZWNvbXByZXNzLmMgICAgICAgICAgICAgICAgICAgICB8ICA5NjAg
LS0tLQ0KPj4gbGliL3pzdGQvbWVtLmggICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwg
IDE1MSAtDQo+PiBsaWIvenN0ZC96c3RkX2NvbW1vbi5jICAgICAgICAgICAgICAgICAgICAgICAg
fCAgIDc1IC0NCj4+IGxpYi96c3RkL3pzdGRfY29tcHJlc3NfbW9kdWxlLmMgICAgICAgICAgICAg
ICB8ICAgNzkgKw0KPj4gbGliL3pzdGQvenN0ZF9kZWNvbXByZXNzX21vZHVsZS5jICAgICAgICAg
ICAgIHwgICA3OSArDQo+PiBsaWIvenN0ZC96c3RkX2ludGVybmFsLmggICAgICAgICAgICAgICAg
ICAgICAgfCAgMjczIC0tDQo+PiBsaWIvenN0ZC96c3RkX29wdC5oICAgICAgICAgICAgICAgICAg
ICAgICAgICAgfCAxMDE0IC0tLS0NCj4+IDcxIGZpbGVzIGNoYW5nZWQsIDI0MzY4IGluc2VydGlv
bnMoKyksIDEzMDEyIGRlbGV0aW9ucygtKQ0KPj4gY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUv
bGludXgvenN0ZF9lcnJvcnMuaA0KPj4gZGVsZXRlIG1vZGUgMTAwNjQ0IGxpYi96c3RkL2JpdHN0
cmVhbS5oDQo+PiBjcmVhdGUgbW9kZSAxMDA2NDQgbGliL3pzdGQvY29tbW9uL2JpdHN0cmVhbS5o
DQo+PiBjcmVhdGUgbW9kZSAxMDA2NDQgbGliL3pzdGQvY29tbW9uL2NvbXBpbGVyLmgNCj4+IGNy
ZWF0ZSBtb2RlIDEwMDY0NCBsaWIvenN0ZC9jb21tb24vY3B1LmgNCj4+IGNyZWF0ZSBtb2RlIDEw
MDY0NCBsaWIvenN0ZC9jb21tb24vZGVidWcuYw0KPj4gY3JlYXRlIG1vZGUgMTAwNjQ0IGxpYi96
c3RkL2NvbW1vbi9kZWJ1Zy5oDQo+PiBjcmVhdGUgbW9kZSAxMDA2NDQgbGliL3pzdGQvY29tbW9u
L2VudHJvcHlfY29tbW9uLmMNCj4+IGNyZWF0ZSBtb2RlIDEwMDY0NCBsaWIvenN0ZC9jb21tb24v
ZXJyb3JfcHJpdmF0ZS5jDQo+PiBjcmVhdGUgbW9kZSAxMDA2NDQgbGliL3pzdGQvY29tbW9uL2Vy
cm9yX3ByaXZhdGUuaA0KPj4gY3JlYXRlIG1vZGUgMTAwNjQ0IGxpYi96c3RkL2NvbW1vbi9mc2Uu
aA0KPj4gY3JlYXRlIG1vZGUgMTAwNjQ0IGxpYi96c3RkL2NvbW1vbi9mc2VfZGVjb21wcmVzcy5j
DQo+PiBjcmVhdGUgbW9kZSAxMDA2NDQgbGliL3pzdGQvY29tbW9uL2h1Zi5oDQo+PiBjcmVhdGUg
bW9kZSAxMDA2NDQgbGliL3pzdGQvY29tbW9uL21lbS5oDQo+PiBjcmVhdGUgbW9kZSAxMDA2NDQg
bGliL3pzdGQvY29tbW9uL3pzdGRfY29tbW9uLmMNCj4+IGNyZWF0ZSBtb2RlIDEwMDY0NCBsaWIv
enN0ZC9jb21tb24venN0ZF9kZXBzLmgNCj4+IGNyZWF0ZSBtb2RlIDEwMDY0NCBsaWIvenN0ZC9j
b21tb24venN0ZF9pbnRlcm5hbC5oDQo+PiBkZWxldGUgbW9kZSAxMDA2NDQgbGliL3pzdGQvY29t
cHJlc3MuYw0KPj4gY3JlYXRlIG1vZGUgMTAwNjQ0IGxpYi96c3RkL2NvbXByZXNzL2ZzZV9jb21w
cmVzcy5jDQo+PiBjcmVhdGUgbW9kZSAxMDA2NDQgbGliL3pzdGQvY29tcHJlc3MvaGlzdC5jDQo+
PiBjcmVhdGUgbW9kZSAxMDA2NDQgbGliL3pzdGQvY29tcHJlc3MvaGlzdC5oDQo+PiBjcmVhdGUg
bW9kZSAxMDA2NDQgbGliL3pzdGQvY29tcHJlc3MvaHVmX2NvbXByZXNzLmMNCj4+IGNyZWF0ZSBt
b2RlIDEwMDY0NCBsaWIvenN0ZC9jb21wcmVzcy96c3RkX2NvbXByZXNzLmMNCj4+IGNyZWF0ZSBt
b2RlIDEwMDY0NCBsaWIvenN0ZC9jb21wcmVzcy96c3RkX2NvbXByZXNzX2ludGVybmFsLmgNCj4+
IGNyZWF0ZSBtb2RlIDEwMDY0NCBsaWIvenN0ZC9jb21wcmVzcy96c3RkX2NvbXByZXNzX2xpdGVy
YWxzLmMNCj4+IGNyZWF0ZSBtb2RlIDEwMDY0NCBsaWIvenN0ZC9jb21wcmVzcy96c3RkX2NvbXBy
ZXNzX2xpdGVyYWxzLmgNCj4+IGNyZWF0ZSBtb2RlIDEwMDY0NCBsaWIvenN0ZC9jb21wcmVzcy96
c3RkX2NvbXByZXNzX3NlcXVlbmNlcy5jDQo+PiBjcmVhdGUgbW9kZSAxMDA2NDQgbGliL3pzdGQv
Y29tcHJlc3MvenN0ZF9jb21wcmVzc19zZXF1ZW5jZXMuaA0KPj4gY3JlYXRlIG1vZGUgMTAwNjQ0
IGxpYi96c3RkL2NvbXByZXNzL3pzdGRfY29tcHJlc3Nfc3VwZXJibG9jay5jDQo+PiBjcmVhdGUg
bW9kZSAxMDA2NDQgbGliL3pzdGQvY29tcHJlc3MvenN0ZF9jb21wcmVzc19zdXBlcmJsb2NrLmgN
Cj4+IGNyZWF0ZSBtb2RlIDEwMDY0NCBsaWIvenN0ZC9jb21wcmVzcy96c3RkX2N3a3NwLmgNCj4+
IGNyZWF0ZSBtb2RlIDEwMDY0NCBsaWIvenN0ZC9jb21wcmVzcy96c3RkX2RvdWJsZV9mYXN0LmMN
Cj4+IGNyZWF0ZSBtb2RlIDEwMDY0NCBsaWIvenN0ZC9jb21wcmVzcy96c3RkX2RvdWJsZV9mYXN0
LmgNCj4+IGNyZWF0ZSBtb2RlIDEwMDY0NCBsaWIvenN0ZC9jb21wcmVzcy96c3RkX2Zhc3QuYw0K
Pj4gY3JlYXRlIG1vZGUgMTAwNjQ0IGxpYi96c3RkL2NvbXByZXNzL3pzdGRfZmFzdC5oDQo+PiBj
cmVhdGUgbW9kZSAxMDA2NDQgbGliL3pzdGQvY29tcHJlc3MvenN0ZF9sYXp5LmMNCj4+IGNyZWF0
ZSBtb2RlIDEwMDY0NCBsaWIvenN0ZC9jb21wcmVzcy96c3RkX2xhenkuaA0KPj4gY3JlYXRlIG1v
ZGUgMTAwNjQ0IGxpYi96c3RkL2NvbXByZXNzL3pzdGRfbGRtLmMNCj4+IGNyZWF0ZSBtb2RlIDEw
MDY0NCBsaWIvenN0ZC9jb21wcmVzcy96c3RkX2xkbS5oDQo+PiBjcmVhdGUgbW9kZSAxMDA2NDQg
bGliL3pzdGQvY29tcHJlc3MvenN0ZF9vcHQuYw0KPj4gY3JlYXRlIG1vZGUgMTAwNjQ0IGxpYi96
c3RkL2NvbXByZXNzL3pzdGRfb3B0LmgNCj4+IGRlbGV0ZSBtb2RlIDEwMDY0NCBsaWIvenN0ZC9k
ZWNvbXByZXNzLmMNCj4+IGNyZWF0ZSBtb2RlIDEwMDY0NCBsaWIvenN0ZC9kZWNvbXByZXNzL2h1
Zl9kZWNvbXByZXNzLmMNCj4+IGNyZWF0ZSBtb2RlIDEwMDY0NCBsaWIvenN0ZC9kZWNvbXByZXNz
L3pzdGRfZGRpY3QuYw0KPj4gY3JlYXRlIG1vZGUgMTAwNjQ0IGxpYi96c3RkL2RlY29tcHJlc3Mv
enN0ZF9kZGljdC5oDQo+PiBjcmVhdGUgbW9kZSAxMDA2NDQgbGliL3pzdGQvZGVjb21wcmVzcy96
c3RkX2RlY29tcHJlc3MuYw0KPj4gY3JlYXRlIG1vZGUgMTAwNjQ0IGxpYi96c3RkL2RlY29tcHJl
c3MvenN0ZF9kZWNvbXByZXNzX2Jsb2NrLmMNCj4+IGNyZWF0ZSBtb2RlIDEwMDY0NCBsaWIvenN0
ZC9kZWNvbXByZXNzL3pzdGRfZGVjb21wcmVzc19ibG9jay5oDQo+PiBjcmVhdGUgbW9kZSAxMDA2
NDQgbGliL3pzdGQvZGVjb21wcmVzcy96c3RkX2RlY29tcHJlc3NfaW50ZXJuYWwuaA0KPj4gY3Jl
YXRlIG1vZGUgMTAwNjQ0IGxpYi96c3RkL2RlY29tcHJlc3Nfc291cmNlcy5oDQo+PiBkZWxldGUg
bW9kZSAxMDA2NDQgbGliL3pzdGQvZW50cm9weV9jb21tb24uYw0KPj4gZGVsZXRlIG1vZGUgMTAw
NjQ0IGxpYi96c3RkL2Vycm9yX3ByaXZhdGUuaA0KPj4gZGVsZXRlIG1vZGUgMTAwNjQ0IGxpYi96
c3RkL2ZzZS5oDQo+PiBkZWxldGUgbW9kZSAxMDA2NDQgbGliL3pzdGQvZnNlX2NvbXByZXNzLmMN
Cj4+IGRlbGV0ZSBtb2RlIDEwMDY0NCBsaWIvenN0ZC9mc2VfZGVjb21wcmVzcy5jDQo+PiBkZWxl
dGUgbW9kZSAxMDA2NDQgbGliL3pzdGQvaHVmLmgNCj4+IGRlbGV0ZSBtb2RlIDEwMDY0NCBsaWIv
enN0ZC9odWZfY29tcHJlc3MuYw0KPj4gZGVsZXRlIG1vZGUgMTAwNjQ0IGxpYi96c3RkL2h1Zl9k
ZWNvbXByZXNzLmMNCj4+IGRlbGV0ZSBtb2RlIDEwMDY0NCBsaWIvenN0ZC9tZW0uaA0KPj4gZGVs
ZXRlIG1vZGUgMTAwNjQ0IGxpYi96c3RkL3pzdGRfY29tbW9uLmMNCj4+IGNyZWF0ZSBtb2RlIDEw
MDY0NCBsaWIvenN0ZC96c3RkX2NvbXByZXNzX21vZHVsZS5jDQo+PiBjcmVhdGUgbW9kZSAxMDA2
NDQgbGliL3pzdGQvenN0ZF9kZWNvbXByZXNzX21vZHVsZS5jDQo+PiBkZWxldGUgbW9kZSAxMDA2
NDQgbGliL3pzdGQvenN0ZF9pbnRlcm5hbC5oDQo+PiBkZWxldGUgbW9kZSAxMDA2NDQgbGliL3pz
dGQvenN0ZF9vcHQuaA0KPj4gDQo+PiAtLSANCj4+IDIuMjguMA0KPj4gDQo+IC0tLWVuZCBxdW90
ZWQgdGV4dC0tLQ0KDQo=
