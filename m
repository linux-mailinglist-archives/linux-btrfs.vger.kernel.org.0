Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FEE72A9C69
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Nov 2020 19:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbgKFShS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Nov 2020 13:37:18 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:17550 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726075AbgKFShS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 6 Nov 2020 13:37:18 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A6IKOqO013121;
        Fri, 6 Nov 2020 10:36:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=7Xs8JwGJAlCOd0yKwySsfYW8KFvKdhU0T31oovsAuwg=;
 b=ZRS84h8C+xU1faEGPUqstJwPWM41k1c+VLigaX2/b28tiT1iTCpdo68RGquIXVS+xThE
 pzaddCE/fSmVmJus9jVJX+rtuDX9AyM3llvELO3W+W62bQGCvAcV1tmY5PzwxHFlzBQ3
 kLxLN0v1jQMzy8WiiY7NyU8xRTo00kvW51I= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 34m5rfk1r4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 06 Nov 2020 10:36:43 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 6 Nov 2020 10:36:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VeykBGdXQThE3ndGz9Uf360ZL9HiIXAEgBQ2WStQE6YWvAjkjE36FawZQZcwn6KL08P8QfUmmN8tYohpXwWvZats98dyA1Lrs/NqPoDx8xDMH7SkSCcR83qXyt77r6BRtGtDDn/aTZlyOXsZQ6Xren+N8C06caNf8CA7KExR8foCNema+O0Q0g7Eydc7XXHfEEM/K1uwztLnpsdfrMgwK4lXMqewgpEjv1IPk0kEJ3uQ+mapwnaHkaxJ9VkIpbBPv2swdQ0HZK4rP8T35eaD/V/nKuoIOsE01pGBgVve3jHqV5hdHgk5ovRrFMfiPXd1ci2RVnUmxfFzEfQY7B+8wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Xs8JwGJAlCOd0yKwySsfYW8KFvKdhU0T31oovsAuwg=;
 b=Lg7Wg8Xmj79hf+SCu+Y2dHgqIgoC98whyXAovzKOUl9JSswLqKYHEkvcvpsca9RVoNZrJLzeQSi1lCSptZJyokvnOAZjyYcbjDgzt+btCWSMMK0QbQEqOqTr2xQyzRD2RIl0RC06AAZlYSsnj3TEN9P2L6eHTv9iA/0D9J7iAZ4jX0U8NrJ65nuObm4bHS7mOPvCbvELUzKGOru+TlcUuFGPKV8F5u9yIpPzxheE3XJr6g8YE/GKy4G5oAQpdWtZ/U00P6o8Y7ZzVRjfH97K33VBgRKCWB5EPwDX6APg6zkB1L7xA4SlV1sru4VilQ1u1Wf9wkUs8Fedqibq0djYyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Xs8JwGJAlCOd0yKwySsfYW8KFvKdhU0T31oovsAuwg=;
 b=P//89VbluNQyGPoGtpDJVvYmWXJWHi/S1E8/zX8vFkO9lgpb6HMJn/+AvqNjdrsD6E3sTH9+R9W+X86RhXAsBKdfxKt8INpHu62khrKG2Mwum2x6n6frLOB5fmqFy4QMjLw6SVqj5xaRaWboGVYIudOk4Y4Tfs1m7HU3LD827HQ=
Received: from BY5PR15MB3667.namprd15.prod.outlook.com (2603:10b6:a03:1f9::18)
 by SJ0PR15MB4236.namprd15.prod.outlook.com (2603:10b6:a03:2cb::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Fri, 6 Nov
 2020 18:36:40 +0000
Received: from BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::2d08:987a:126:1c9c]) by BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::2d08:987a:126:1c9c%7]) with mapi id 15.20.3499.032; Fri, 6 Nov 2020
 18:36:40 +0000
From:   Nick Terrell <terrelln@fb.com>
To:     Josef Bacik <josef@toxicpanda.com>
CC:     Nick Terrell <nickrterrell@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "squashfs-devel@lists.sourceforge.net" 
        <squashfs-devel@lists.sourceforge.net>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>, Chris Mason <clm@fb.com>,
        Petr Malat <oss@malat.biz>, Johannes Weiner <jweiner@fb.com>,
        Niket Agarwal <niketa@fb.com>, Yann Collet <cyan@fb.com>
Subject: Re: [PATCH v5 5/9] btrfs: zstd: Switch to the zstd-1.4.6 API
Thread-Topic: [PATCH v5 5/9] btrfs: zstd: Switch to the zstd-1.4.6 API
Thread-Index: AQHWsabklGPSgQhAPkiKblW0oNymY6m7XDuAgAAX/wA=
Date:   Fri, 6 Nov 2020 18:36:40 +0000
Message-ID: <55C56F7A-4CF9-44DB-AA61-A5D9F5C61FE0@fb.com>
References: <20201103060535.8460-1-nickrterrell@gmail.com>
 <20201103060535.8460-6-nickrterrell@gmail.com>
 <b12254bc-7320-7170-f39d-e76afe1a7561@toxicpanda.com>
In-Reply-To: <b12254bc-7320-7170-f39d-e76afe1a7561@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=fb.com;
x-originating-ip: [98.33.101.203]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 64387939-e82a-4f92-06f1-08d88282e725
x-ms-traffictypediagnostic: SJ0PR15MB4236:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR15MB42360EB66028E4411FDF8B74ABED0@SJ0PR15MB4236.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a2nMYfCEOvRT23LKA0baGwEkuIpE1OMiDH4XUBAD1IMPo+S/GXE2kr/adUs96QPsRiS9R/ZOQpDYhVdg9SMZZc0MAXmYlQhqAYd2pbSWdYLF/lDmqtxSJeMfYr6m35nUE9uvkh3lnQ3fivaNecYqOH01t70F2yAAhcAc5VDyf261Mercge1KLrTdj6cUmZznCchtaAVWPMu21cEA/BXdLQ4gZtggGTcr5yTs3eFn4FSciab6PGOClEl+xew7mPUb0Z39jVr5tOPjE8tSouhIcXcIsvpQINIg11KMQB3fncMgQOevmcBfkyDXXUz65aJ/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3667.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(366004)(136003)(346002)(376002)(316002)(8936002)(5660300002)(4326008)(6916009)(2906002)(36756003)(33656002)(6486002)(66946007)(83380400001)(66446008)(64756008)(66556008)(66476007)(54906003)(8676002)(186003)(6506007)(71200400001)(6512007)(76116006)(53546011)(2616005)(26005)(478600001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Qkuka9jYBvTliqgAE55Z4RRoCwV7vCtdpZsvz2B00q2G49zXo79xVd7B/04d39hfxgREK0LbsquwNWw32H6h3K5bZMX+t5uhv8dxvqxW24KFvY/eKASImPuA2pTcagnof0bGSj79ol4eqAdFVh0348X6DuWWZhGtitdnEU1eCpsF4ZPkuNEfpiLaIqXZ4JCYeZzuiseJTMMg8p5CIwCK/vLvxVlTHUIK2AB/JOEVUcofbhJQ8MSoLafydO3RjoHx1ZXEgsjdfwRQnJgIRjeK3GZwJI8nflkA1eL73NZHnmMs4LQ463pu8fZ0xCGUTCW2XlODLxI9hNyCrO386/d+s2sXN5T48WwPCcwIR5xLi+UyEhq7qO/LAaEiOgr6xsZbIBz9DjOm0n5XbzoZ6wKApaEH/OWPrrvnYZtGNQCNxR3JCt4y6LP8CbSsvODRg7C4mhEchvyxeX0+l+TuTLTRuPsmelMzCXZyW8T5MFAbaHM4DY/3jzrwPjlCITpYM7z/vcBx0bTctF6tdBncNFd3f6ckGIMThBKj1HyhnrEx19zsahVixAqz8mV4LD+br7YAPuXCCJXOZkT2iYNbwCSXtD5gsyCUUHUtAT/CCP61unD5RbowjcZ0+aAPfir1fa+dLosqLOAc3hurqzUpjqYESw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <DED071C74C8E944D86F979D0FD83BA1B@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3667.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64387939-e82a-4f92-06f1-08d88282e725
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2020 18:36:40.7648
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8iooUT0BDeUxwY+d6536gMIrWy6RT4fesOBNxqTXInwOGcxoY51PvNFTmVrazivA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4236
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-06_06:2020-11-05,2020-11-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1011
 malwarescore=0 impostorscore=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 lowpriorityscore=0 adultscore=0 mlxscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011060132
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

DQoNCj4gT24gTm92IDYsIDIwMjAsIGF0IDk6MTAgQU0sIEpvc2VmIEJhY2lrIDxqb3NlZkB0b3hp
Y3BhbmRhLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiAxMS8zLzIwIDE6MDUgQU0sIE5pY2sgVGVycmVs
bCB3cm90ZToNCj4+IEZyb206IE5pY2sgVGVycmVsbCA8dGVycmVsbG5AZmIuY29tPg0KPj4gTW92
ZSBhd2F5IGZyb20gdGhlIGNvbXBhdGliaWxpdHkgd3JhcHBlciB0byB0aGUgenN0ZC0xLjQuNiBB
UEkuIFRoaXMNCj4+IGNvZGUgaXMgZnVuY3Rpb25hbGx5IGVxdWl2YWxlbnQuDQo+PiBTaWduZWQt
b2ZmLWJ5OiBOaWNrIFRlcnJlbGwgPHRlcnJlbGxuQGZiLmNvbT4NCj4+IC0tLQ0KPj4gIGZzL2J0
cmZzL3pzdGQuYyB8IDQ4ICsrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0t
LS0tLS0tLQ0KPj4gIDEgZmlsZSBjaGFuZ2VkLCAyOCBpbnNlcnRpb25zKCspLCAyMCBkZWxldGlv
bnMoLSkNCj4+IGRpZmYgLS1naXQgYS9mcy9idHJmcy96c3RkLmMgYi9mcy9idHJmcy96c3RkLmMN
Cj4+IGluZGV4IGE3MzY3ZmY1NzNkNC4uNmI0NjZlMDkwY2Q3IDEwMDY0NA0KPj4gLS0tIGEvZnMv
YnRyZnMvenN0ZC5jDQo+PiArKysgYi9mcy9idHJmcy96c3RkLmMNCj4+IEBAIC0xNiw3ICsxNiw3
IEBADQo+PiAgI2luY2x1ZGUgPGxpbnV4L3JlZmNvdW50Lmg+DQo+PiAgI2luY2x1ZGUgPGxpbnV4
L3NjaGVkLmg+DQo+PiAgI2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4NCj4+IC0jaW5jbHVkZSA8bGlu
dXgvenN0ZF9jb21wYXQuaD4NCj4+ICsjaW5jbHVkZSA8bGludXgvenN0ZC5oPg0KPj4gICNpbmNs
dWRlICJtaXNjLmgiDQo+PiAgI2luY2x1ZGUgImNvbXByZXNzaW9uLmgiDQo+PiAgI2luY2x1ZGUg
ImN0cmVlLmgiDQo+PiBAQCAtMTU5LDggKzE1OSw4IEBAIHN0YXRpYyB2b2lkIHpzdGRfY2FsY193
c19tZW1fc2l6ZXModm9pZCkNCj4+ICAJCQl6c3RkX2dldF9idHJmc19wYXJhbWV0ZXJzKGxldmVs
LCBaU1REX0JUUkZTX01BWF9JTlBVVCk7DQo+PiAgCQlzaXplX3QgbGV2ZWxfc2l6ZSA9DQo+PiAg
CQkJbWF4X3Qoc2l6ZV90LA0KPj4gLQkJCSAgICAgIFpTVERfQ1N0cmVhbVdvcmtzcGFjZUJvdW5k
KHBhcmFtcy5jUGFyYW1zKSwNCj4+IC0JCQkgICAgICBaU1REX0RTdHJlYW1Xb3Jrc3BhY2VCb3Vu
ZChaU1REX0JUUkZTX01BWF9JTlBVVCkpOw0KPj4gKwkJCSAgICAgIFpTVERfZXN0aW1hdGVDU3Ry
ZWFtU2l6ZV91c2luZ0NQYXJhbXMocGFyYW1zLmNQYXJhbXMpLA0KPj4gKwkJCSAgICAgIFpTVERf
ZXN0aW1hdGVEU3RyZWFtU2l6ZShaU1REX0JUUkZTX01BWF9JTlBVVCkpOw0KPj4gICAgCQltYXhf
c2l6ZSA9IG1heF90KHNpemVfdCwgbWF4X3NpemUsIGxldmVsX3NpemUpOw0KPj4gIAkJenN0ZF93
c19tZW1fc2l6ZXNbbGV2ZWwgLSAxXSA9IG1heF9zaXplOw0KPj4gQEAgLTM4OSwxMyArMzg5LDIz
IEBAIGludCB6c3RkX2NvbXByZXNzX3BhZ2VzKHN0cnVjdCBsaXN0X2hlYWQgKndzLCBzdHJ1Y3Qg
YWRkcmVzc19zcGFjZSAqbWFwcGluZywNCj4+ICAJKnRvdGFsX2luID0gMDsNCj4+ICAgIAkvKiBJ
bml0aWFsaXplIHRoZSBzdHJlYW0gKi8NCj4+IC0Jc3RyZWFtID0gWlNURF9pbml0Q1N0cmVhbShw
YXJhbXMsIGxlbiwgd29ya3NwYWNlLT5tZW0sDQo+PiAtCQkJd29ya3NwYWNlLT5zaXplKTsNCj4+
ICsJc3RyZWFtID0gWlNURF9pbml0U3RhdGljQ1N0cmVhbSh3b3Jrc3BhY2UtPm1lbSwgd29ya3Nw
YWNlLT5zaXplKTsNCj4+ICAJaWYgKCFzdHJlYW0pIHsNCj4+IC0JCXByX3dhcm4oIkJUUkZTOiBa
U1REX2luaXRDU3RyZWFtIGZhaWxlZFxuIik7DQo+PiArCQlwcl93YXJuKCJCVFJGUzogWlNURF9p
bml0U3RhdGljQ1N0cmVhbSBmYWlsZWRcbiIpOw0KPj4gIAkJcmV0ID0gLUVJTzsNCj4+ICAJCWdv
dG8gb3V0Ow0KPj4gIAl9DQo+PiArCXsNCj4+ICsJCXNpemVfdCByZXQyOw0KPj4gKw0KPj4gKwkJ
cmV0MiA9IFpTVERfaW5pdENTdHJlYW1fYWR2YW5jZWQoc3RyZWFtLCBOVUxMLCAwLCBwYXJhbXMs
IGxlbik7DQo+PiArCQlpZiAoWlNURF9pc0Vycm9yKHJldDIpKSB7DQo+PiArCQkJcHJfd2Fybigi
QlRSRlM6IFpTVERfaW5pdENTdHJlYW1fYWR2YW5jZWQgcmV0dXJuZWQgJXNcbiIsDQo+PiArCQkJ
CQlaU1REX2dldEVycm9yTmFtZShyZXQyKSk7DQo+PiArCQkJcmV0ID0gLUVJTzsNCj4+ICsJCQln
b3RvIG91dDsNCj4+ICsJCX0NCj4+ICsJfQ0KPiANCj4gUGxlYXNlIGRvbid0IGRvIHRoaXMsIHlv
dSBjYW4ganVzdCBhZGQgc2l6ZV90IHJldDIgYXQgdGhlIHRvcCBhbmQgbm90IHB1dCB0aGlzIGlu
IGEgYmxvY2suICBPdGhlciB0aGFuIHRoYXQgdGhlIGNvZGUgbG9va3MgZmluZSwgb25jZSB5b3Ug
Zml4IHRoYXQgeW91IGNhbiBhZGQNCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3LCBJ4oCZbGwgbWFr
ZSB0aGF0IGNoYW5nZSENCg0KPiBSZXZpZXdlZC1ieTogSm9zZWYgQmFjaWsgPGpvc2VmQHRveGlj
cGFuZGEuY29tPg0KPiANCj4gVGhhbmtzLA0KPiANCj4gSm9zZWYNCg0K
