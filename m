Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9355E2DB7F7
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Dec 2020 01:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbgLPAud (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Dec 2020 19:50:33 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:49166 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725815AbgLPAuc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Dec 2020 19:50:32 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BG0YJQ6020142;
        Tue, 15 Dec 2020 16:49:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=I/Lb2HIB9tlQNDpGHgvE3BrKQ0R9rMkHbdza6UCykBA=;
 b=CGrZ9z0IE3cmBU+V/1Q/oKhUdUGdN7iHdAyL95kLEOPwG0hmZ9aL4UL0LFpG3ImVBoLC
 qugAlY0pqicINZEqn2Etg1EBTIT+dysXDmDydhZ6NfLG7vLspeErNAfv+tQyWp/GUPi3
 e9Bk7iYG/XdSdbIMHoOol0tZ3anJPjD+C6M= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 35ewhdkvd3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 15 Dec 2020 16:49:11 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 15 Dec 2020 16:49:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NxX54VuB9rm6BlWqMYIhJtuZET/KxvnmgaV/izQBW5WnnLhIxBXeRLPr89CVyWk+G6g/5HFqIm/GteBTl6v4bVxShC5xsyatEpkr3Ho4MrNvgCHP7i28I8XB+zae/EPSwPhejxQXDrOe8z2jdfvYxOAa2FeN5hiTwW4kLb3S9zTP7bY1hG9LC7IxHGPlwosTlUJyTkMKw15qsJ3tdrkygSMK5ssNRwpfGq26grIic4D8K3SkQS4Rl2wCXHsfd+e8NiDvyf/dWpMLUsNekKxJMjuN4JH3U2ExNQnia1i97yCAVYUV5HSRSwYEacDOk9BxPlgdKOCU3IAs7xIcweZLJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/Lb2HIB9tlQNDpGHgvE3BrKQ0R9rMkHbdza6UCykBA=;
 b=lOPZM1cGC5Sj2KGfEmuwhsjgQT0A6cyVdKG3GboX561sxHK12YrHe6VPtfulddg0oMPdlgPCLrbz4z05euhLJDrHTTsFvK7Ih18bnGsO0c26EUTuD1rxRXVFh43L050AlgXGkKLHeLlrjHeRwRR/4j4sn+0BWihvAKvobVh6DzJMnUFT4QCpBw72OUKjuiEtFTEK+2pB1jGWbsSXGZHukrTguyI22HzjLkdwsl3XgcxPT1x7QRkyW/OqZ8RF8A6s8fZHknPOlNma3K0LZp3XewX/8GEevxANuUQxDzG4SS6xhzVglnWqx5bT+IbMdiUIKYdPwVqJBeJKKFfv8VjakQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/Lb2HIB9tlQNDpGHgvE3BrKQ0R9rMkHbdza6UCykBA=;
 b=Cfr77lm5bALYaUKlLngU8Ru2r2ONhn+Z607K/k8nNOwjwsnQQAxWnE3ix+3A2R/kRbu1YlS9xHk6+uKC7yJoiZy5MXvK+zxmk6NCF6qGR/b2hC9x5tx2Suz5KiaMAvZHtDD6D52kawSFm9/6QPDAHGxzHeILJLJ99lmuZg8dhLw=
Received: from BY5PR15MB3667.namprd15.prod.outlook.com (2603:10b6:a03:1f9::18)
 by BYAPR15MB2456.namprd15.prod.outlook.com (2603:10b6:a02:82::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.21; Wed, 16 Dec
 2020 00:48:51 +0000
Received: from BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::17e:aa61:eb50:290c]) by BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::17e:aa61:eb50:290c%7]) with mapi id 15.20.3654.025; Wed, 16 Dec 2020
 00:48:51 +0000
From:   Nick Terrell <terrelln@fb.com>
To:     Eric Biggers <ebiggers@kernel.org>
CC:     Nick Terrell <nickrterrell@gmail.com>,
        "squashfs-devel@lists.sourceforge.net" 
        <squashfs-devel@lists.sourceforge.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Christoph Hellwig <hch@infradead.org>,
        "Yann Collet" <cyan@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Petr Malat <oss@malat.biz>, "Chris Mason" <clm@fb.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Niket Agarwal <niketa@fb.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Johannes Weiner <jweiner@fb.com>
Subject: Re: [f2fs-dev] [PATCH v7 0/3] Update to zstd-1.4.6
Thread-Topic: [f2fs-dev] [PATCH v7 0/3] Update to zstd-1.4.6
Thread-Index: AQHWybXbXo5DSFQdaEqlAnoQrw8JMqn4tsKAgAAywQCAAA2CgA==
Date:   Wed, 16 Dec 2020 00:48:51 +0000
Message-ID: <B3F00261-E977-4B85-84CD-66B07DA79D9D@fb.com>
References: <20201203205114.1395668-1-nickrterrell@gmail.com>
 <DF6B2E26-2D6E-44FF-89DB-93A37E2EA268@fb.com>
 <X9lOHkAE67EP/sXo@sol.localdomain>
In-Reply-To: <X9lOHkAE67EP/sXo@sol.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
x-originating-ip: [98.33.101.203]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ebec23ec-2226-487e-da17-08d8a15c5b96
x-ms-traffictypediagnostic: BYAPR15MB2456:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB24564911A5A3A8FFC0DDB714ABC50@BYAPR15MB2456.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hGXdxAGi87ncxKZ3JDrujFakQLxzuIT/E5SCmCI5w1YuX7Va8jPerGgPPMClOllvLyt6WgbgZOmKTxzsHgtJIoF7bc8a0Cce6iQWcrx4uwBsP+5K3XlyoZCo0mfWHt1naU8KOadcf9Z1seo7geGQPnJz6PGxshu3l6ipZGfqwdVRTGYRmsm/3zEr13jcdez27C90x5+aZFF3KURpdauoYaQCy1H4rcMwOv4neYnY4rAXxgqx0Wdc2womuGFMZEsu4k28sg4LghDimTVH+VhKGcreRqMtSjh52xN1eMJG8wYvfO4LysKBiGkJLRExL+Dvho3I9xviOdDgs+qqD8JkOsUeesTvXprwmc0guk4rTkzbF9A5qfXaiPjV1T2hvbPz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3667.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(136003)(396003)(39860400002)(376002)(26005)(8936002)(86362001)(478600001)(66946007)(4326008)(54906003)(6916009)(33656002)(186003)(6506007)(6486002)(316002)(83380400001)(53546011)(6512007)(2906002)(76116006)(71200400001)(66446008)(2616005)(64756008)(66476007)(66556008)(8676002)(7416002)(36756003)(5660300002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?WTZzNUV5MjZnWW00N1RVSS9VeUM2UTlPcC8ydllnN1VjUGthMThyRmVJMmtR?=
 =?utf-8?B?VzA5OW1JTDk0NkczaDcyNFhPUXRxVVR6eGJBYzE1WmVvc3Bzd2JHcjRBcGQz?=
 =?utf-8?B?RW4vbGx1d3MyL2UvRzIvZFZVWlJ0TjFZelRLQXhoSFZkMjVINmVBTERNL1l4?=
 =?utf-8?B?MTBaZitRUWRpNDlsSm5yY1V2OXVic3M5MUhGMzA1aVhHVXhXYWw5QUJTbEtE?=
 =?utf-8?B?bkw1SjRlRjRjczExY2NycE5DakNVM0N5QzNsTnM0WXV4M2RJTm5rNEFlVUJY?=
 =?utf-8?B?LzBpV1liZXNTNWpMbFh1eWlvSHhFK1BRaW5uSmtQQUNVYk1kWUIwZURVd3k3?=
 =?utf-8?B?bUc1WGtCd2FvNC90MVlQSGt5QlorQUdwZzdKRk9IQWUrUVpMWDZpM2g0ZFlp?=
 =?utf-8?B?WFhlakFsekhWdUZOOGorMmF0ZkhMREF5YjYrS0ZxUmxIYmlkMi9TVlpyU3o1?=
 =?utf-8?B?TllnVkRmYTFQem9ucDI4YW82Zlp6Y0xwMDFhT1Z4Q295ZjdPdy81ZHkranFQ?=
 =?utf-8?B?OUl6QjZubis3S2xPV1JGUDJoZURZTUFRdUN5THBqQTJnYWY1TmhvV3hua2ZJ?=
 =?utf-8?B?c05BdjNFaUhOd2puVG9iUjZtMlQ2MDRZSndQSGFFZk1JR3R0VFQvcXVXemQ4?=
 =?utf-8?B?OXQ1dC9MS0RoOTFQZnAxRXlHMmNURkhOM2FYTm1wMi9NOVdWZDRoaUZDTWRC?=
 =?utf-8?B?QS84RW5WZHZxYlFwRHdmMjl5YUhnUjQydFhYTEFhekZjZHFyU29BOTl5bWdi?=
 =?utf-8?B?UXlteVVCUWtwMnhlZ1k0OVRjV1Q0cHpaRzkyY1hIK3g5ckNRZ0FpVUxOM3lM?=
 =?utf-8?B?Q1BtL2U5TTBiOU14ODlueDBRZmovTlJzM1pvR1NwUWpyZ2Q1cm1UQnFSMno4?=
 =?utf-8?B?c1pjMHlzSzVkZ1JOT25ydkJ3NlRlTDRLWGJMbXB0RmRzVHNjNERBQWJIZmVy?=
 =?utf-8?B?Zld5cVpWcGgyMFdGV3RSWU96a29KZ0kraXV3K0lwclRCb1BqSlJmcUtocGhu?=
 =?utf-8?B?bTlCNmdjdkQzUzBDK1Z5b3piSHVsNTNtenRkWm16WTV0bGFhVEhVVzlEYkZu?=
 =?utf-8?B?d0c1azJUY04wNE1KRmdLTzhxQys1TXFtNjlTaUgyWTMzSmsraXdJcklEQUty?=
 =?utf-8?B?MWtVNGoyS1dlNXhacittbnYzYVE0ZnkwVGNyMnhhTW5BaHJoT05MZlIxYklh?=
 =?utf-8?B?U2V5d1BKbExRTm1leWdrc20vdU5JSjhLUkpDSmFzSjk4aXRNT2QzbzVWOW1v?=
 =?utf-8?B?RUtKNmlZUS8xbkRWNW83MEV6V2kralJ6ZG04NjVadjlFWUxiTVkwbGRqdHcy?=
 =?utf-8?Q?QvymQ9lFCadSZMDTp6Ayogah5jE6qDRgOn?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7493AC814B949749B1BAE993CCB9C194@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3667.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebec23ec-2226-487e-da17-08d8a15c5b96
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2020 00:48:51.6642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eiHqHksSq61xI87rUjqw1AFqN/PK25nlLVfjah41OA+ne2ze0qEpxTb9jvx4/Yne
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2456
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-15_13:2020-12-15,2020-12-15 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 spamscore=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1011 mlxlogscore=879
 adultscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012160001
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

DQoNCj4gT24gRGVjIDE1LCAyMDIwLCBhdCA0OjAwIFBNLCBFcmljIEJpZ2dlcnMgPGViaWdnZXJz
QGtlcm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gT24gVHVlLCBEZWMgMTUsIDIwMjAgYXQgMDg6NTg6
NTJQTSArMDAwMCwgTmljayBUZXJyZWxsIHZpYSBMaW51eC1mMmZzLWRldmVsIHdyb3RlOg0KPj4g
DQo+PiANCj4+PiBPbiBEZWMgMywgMjAyMCwgYXQgMTI6NTEgUE0sIE5pY2sgVGVycmVsbCA8bmlj
a3J0ZXJyZWxsQGdtYWlsLmNvbT4gd3JvdGU6DQo+Pj4gDQo+Pj4gRnJvbTogTmljayBUZXJyZWxs
IDx0ZXJyZWxsbkBmYi5jb20+DQo+Pj4gDQo+Pj4gUGxlYXNlIHB1bGwgZnJvbQ0KPj4+IA0KPj4+
IGdpdEBnaXRodWIuY29tOnRlcnJlbGxuL2xpbnV4LmdpdCB0YWdzL3Y3LXpzdGQtMS40LjYNCj4+
PiANCj4+PiB0byBnZXQgdGhlc2UgY2hhbmdlcy4gQWx0ZXJuYXRpdmVseSB0aGUgcGF0Y2hzZXQg
aXMgaW5jbHVkZWQuDQo+PiANCj4+IElzIGl0IHBvc3NpYmxlIHRvIGdldCB0aGlzIHBhdGNoc2V0
IG1lcmdlZCBpbiB0aGUgNS4xMSBtZXJnZSB3aW5kb3c/IEl0IGFwcGxpZXMNCj4+IGNsZWFubHkg
dG8gdGhlIGxhdGVzdCBtYXN0ZXIuIFBsZWFzZSBsZXQgbWUga25vdyBpZiB0aGVyZSBpcyBhbnl0
aGluZyB0aGF0IEkgY2FuIGRvDQo+PiB0byBkcml2ZSB0aGlzIHBhdGNoc2V0IHRvd2FyZHMgbWVy
Z2UuDQo+PiANCj4+IFRoYW5rcywNCj4+IE5pY2sNCj4gDQo+IFdlbGwsIGl0J3MgdG9vIGxhdGUg
Zm9yIDUuMTEgZm9yIHBhdGNoZXMgdGhhdCB3ZXJlbid0IGFscmVhZHkgaW4gbGludXgtbmV4dCwg
c28NCj4geW91J2xsIGhhdmUgdG8gYWltIGZvciA1LjEyLg0KPiANCj4gSXQgbG9va3MgbGlrZSB5
b3UncmUgYXNraW5nIEhlcmJlcnQgdG8gcHVsbCB0aGlzIGludG8gdGhlIGNyeXB0byB0cmVlPyAg
SWYgaGUncw0KPiBpbnRlcmVzdGVkIGluIGRvaW5nIHRoYXQsIHRoYXQgY291bGQgd29yay4gIEhv
d2V2ZXIgbGliL3pzdGQvIGlzbid0IHRoYXQNCj4gc3Ryb25nbHkgImNyeXB0by1yZWxhdGVkIiwg
YW5kIGl0IGRvZXNuJ3QgYWN0dWFsbHkgaGF2ZSBhIG1haW50YWluZXIgbGlzdGVkIGluDQo+IE1B
SU5UQUlORVJTLiAgUGVyaGFwcyBhbm90aGVyIHBhdGggZm9yd2FyZHMgaXMgZm9yIHlvdSB0byB2
b2x1bnRlZXIgdG8gbWFpbnRhaW4NCj4gbGliL3pzdGQvIGFuZCBzZW5kIHB1bGwgcmVxdWVzdHMg
Zm9yIGl0IGRpcmVjdGx5IHRvIExpbnVzPw0KDQpUaGFua3MgZm9yIHRoZSBhZHZpY2UhIFRoZSBm
aXJzdCB6c3RkIHBhdGNoZXMgd2VudCB0aHJvdWdoIEhlcmJlcnTigJlzIHRyZWUsIHdoaWNoIGlz
DQp3aHkgSeKAmXZlIHNlbnQgdGhlbSB0aGlzIHdheS4NCg0KSeKAmWQgYmUgaGFwcHkgdG8gbWFp
bnRhaW4genN0ZCAoYW5kIGx6NCwgYW5kIHh4aGFzaCksIHRob3VnaCBJIGRvbuKAmXQga25vdyBl
eGFjdGx5IHdoYXQNCnRoYXQgZW50YWlscy4NCg0KQmVzdCwNCk5pY2sNCg0KPiAtIEVyaWMNCg0K
