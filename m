Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 423772A9CB1
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Nov 2020 19:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgKFSvY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Nov 2020 13:51:24 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:39564 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726075AbgKFSvX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 6 Nov 2020 13:51:23 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A6ImkmH021329;
        Fri, 6 Nov 2020 10:51:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=G16dLQtFhCMRyr26RpSW9m/UBD3F6gQhulJDeRhz/U0=;
 b=jBqZ7Xrj3qhwIDwPxBwLYepBrn03jhJg/83f4BHw8CU5HqEHnvlXsnUfN3t3CKh/tXdJ
 dXJ+JcLdUnYcWqaLPkKJlA3Fn/pG6K744jDOcEhUA+GgZJnjLiErXbqJe391KjL0oohd
 2sh3rdGux/9qDs6DuyQwxPUWJZKr8fsBUrQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 34mr9bdn6v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 06 Nov 2020 10:51:09 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 6 Nov 2020 10:51:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZKPox+19uYKAL7lx1erGVqHnD3ZQzQMkvadMO+p7/6GlNQVX6uvHoD5RSdPIeLDUP//3D6er4sIAMp+dQbvdYeaU8xOJxrXGbCtu15fsP2sht6y0Ef/f0lEI1GzwEBNZ9AyCAbzMqbccaKaXNm9c6sVvtfbSLjFzCzDofn/775wssZwe7Zca+i2ngriBifZwNjz4VvxqwCX6y783BSM1YRYA/LXpFmqjaamcQnMTqE83punbQph1Tn2m0MQc9XpG4KOAqLekUFWq4ldPHfYXUyoNoTthvZ8q0Vk6xU8kAQ4cC1hhdDFu8kGrCErcnJNPRLzplCjcD+vcON152KAedw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G16dLQtFhCMRyr26RpSW9m/UBD3F6gQhulJDeRhz/U0=;
 b=k46Qhw2BZas6cwkSYWbJvjiwMlvljP1qCMIRcQqUpH9E+qudAgRseC42ztrDWlHDwKk6FiexB8LHVc84B8+uVOfISSgoCEdOx8KeItuXo9yp3sw9Fo3HeW7LOOoDmqjaKNupepunt1mPm0rzotF6BG1NMaZ43fCcBGZLp7kl8dV1Xa6Y78hOtv0LGpKAP/Y8USeW6YSzlgpKevOIuLfiH5SKaDtNXDn7w+DGtZ92FOnJOresOkbVm1J9AnKon01MzTBNKCRDRkM07K2H8PVVXyp2MmIWF3x2smdAFNoBLheRTKzfTQ/Yyp3TVCBKBzDwYMFFFda8E3aNAKkdmERmJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G16dLQtFhCMRyr26RpSW9m/UBD3F6gQhulJDeRhz/U0=;
 b=Qq0ExCqUjMUVYweygF43/YL/H1bOVQVGiIgblzL5PWcDCVS7IUvYEqqj9nyqp77pJfZwsX0AMhTzCzvmWCO5+l7rU8bNZtL8HAaiO+QcJn9WJI1xlq/Z58H+epEvBO/qxhzJz7Q14V2FnQCwKceacOq5fY5jV1/EamQilkqqmNE=
Received: from BY5PR15MB3667.namprd15.prod.outlook.com (2603:10b6:a03:1f9::18)
 by BYAPR15MB2264.namprd15.prod.outlook.com (2603:10b6:a02:8a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Fri, 6 Nov
 2020 18:51:02 +0000
Received: from BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::2d08:987a:126:1c9c]) by BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::2d08:987a:126:1c9c%7]) with mapi id 15.20.3499.032; Fri, 6 Nov 2020
 18:51:02 +0000
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
Subject: Re: [GIT PULL][PATCH v5 0/9] Update to zstd-1.4.6
Thread-Topic: [GIT PULL][PATCH v5 0/9] Update to zstd-1.4.6
Thread-Index: AQHWsabYVo88ftkvF06GySx18fZqPqm7XZQAgAAaqYA=
Date:   Fri, 6 Nov 2020 18:51:02 +0000
Message-ID: <6D8DAFAA-0442-470B-B58A-6EBD72E39AF6@fb.com>
References: <20201103060535.8460-1-nickrterrell@gmail.com>
 <025719a2-2432-8204-201f-adbbd293fa9a@toxicpanda.com>
In-Reply-To: <025719a2-2432-8204-201f-adbbd293fa9a@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=fb.com;
x-originating-ip: [98.33.101.203]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1279f163-95ef-46cf-3ec6-08d88284e898
x-ms-traffictypediagnostic: BYAPR15MB2264:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB226463FAAD7A29033369470BABED0@BYAPR15MB2264.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Oyv+B4ofz8QF015alIOS08gpagp6oVGn2NU8+o2ITp7nIDatoi7gLB6uXa/ROQ++urRbr77csBkQvEYDfajyqchnvSt2zxVPvqvZub26wgiic1jbKj7VCMnft0mlf8YVoc5RMMCw7RH2GzRaddki/I0T7pHc/FyU6ryOCxVm6NltvI1V5gsMiUgys4KFohbyVi0HlnMXZ03zoXRh8ib6qd1cjbzMGh+qU4AtctoPSbJE3EVdsSU4ZrTTKhNB5/DRVPTzbbB3t0KzFIvu3DdY7J5AGa7+7qAidAIeRhACWOceP6FqdSfTjvIQxbG+RCK/gTOThUkueEeIdWzSMIjkIQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3667.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(346002)(136003)(396003)(366004)(33656002)(66446008)(6512007)(15650500001)(53546011)(36756003)(64756008)(6506007)(4326008)(83380400001)(26005)(186003)(76116006)(66946007)(66556008)(66476007)(2906002)(6486002)(478600001)(316002)(54906003)(8936002)(86362001)(8676002)(6916009)(5660300002)(71200400001)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: EbeaqRgtq5fne9H3in8ycCYIllSGRHbmdZw7ow+gSvbwx6+GH3jcJYJS7lxdaHsEc1CVF3a3yiQxbMECdrRbY9jSw9RyONMQ5EELW5B3PwQuU7lY8g7V6vriJMQr33QEfcMwpQAHF6d+Tdy52zPcXUpxWDOaBlEgm5z8gfpwZqmFK0JENzoTVTwNEUDDAGcnTPKB6oXFc0PmEm9wLy7yjkMNlDS2n0WgOSddE1a/GVOm7NXgOcLTs22uOzCNyPFEcvqoWo/uIcn2gtryQESfm7Sok4yB/0LazEVSdOmnLjx6eLuwzjhKfPMTrzlUk7NY6Df2tpc0ANlU/iJUxb09AuRoH8JAJIPPTcgNreV14iig7ZXZ7gmeOX3zod0LBhsSG1n/9XjKfOyMmbLOI23mygsyFuJqWS7CsWiINcRU5jPllsEA+i1s7FyPGwc9p7J92LcaromtWIY4HbZXTstVXnA2U9M6rwGwbR9/TeqJYwM9wF0Glx7iQ3sfwq9xbsEcYxt8uC9MuyHoiy7OQJ4klAOTYsoB0iGj67rmwONtTQVU+VZmjwEeWPzczpsdz4iGLFotDjtwpjayVR2Ubl6x0MrNbH3suWtSzW3CfhiF1p9HTN4q8lhzTCTuedNcLndALwWyIG6HU5f+be3Nkz6G7g==
Content-Type: text/plain; charset="utf-8"
Content-ID: <2876C9A351E1824BB447C209E0C8325A@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3667.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1279f163-95ef-46cf-3ec6-08d88284e898
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2020 18:51:02.0162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j1QjEP+g3GgS4NVNNO60o/a16Y3dl+eRSa8vM78dT4HjpUj/G/eEBjZ9x3vCzoeO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2264
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-06_06:2020-11-05,2020-11-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 mlxlogscore=999
 suspectscore=0 mlxscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011060133
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

PiBPbiBOb3YgNiwgMjAyMCwgYXQgOToxNSBBTSwgSm9zZWYgQmFjaWsgPGpvc2VmQHRveGljcGFu
ZGEuY29tPiB3cm90ZToNCj4gDQo+IE9uIDExLzMvMjAgMTowNSBBTSwgTmljayBUZXJyZWxsIHdy
b3RlOg0KPj4gRnJvbTogTmljayBUZXJyZWxsIDx0ZXJyZWxsbkBmYi5jb20+DQo+PiBQbGVhc2Ug
cHVsbCBmcm9tDQo+PiAgIGdpdEBnaXRodWIuY29tOnRlcnJlbGxuL2xpbnV4LmdpdCB0YWdzL3Y1
LXpzdGQtMS40LjYNCj4+IHRvIGdldCB0aGVzZSBjaGFuZ2VzLiBBbHRlcm5hdGl2ZWx5IHRoZSBw
YXRjaHNldCBpcyBpbmNsdWRlZC4NCj4gDQo+IFdoZXJlIGRpZCB3ZSBjb21lIGRvd24gb24gdGhl
IGNvZGUgZm9ybWF0dGluZyBxdWVzdGlvbj8gIFBlcnNvbmFsbHkgSSdtIG9mIHRoZSBtaW5kIHRo
YXQgYXMgbG9uZyBhcyB0aGUgY29uc3VtZXJzIHRoZW1zZWx2ZXMgYWRoZXJlIHRvIHRoZSBwcm9w
ZXIgY29kaW5nIHN0eWxlIEknbSBmaW5lIG5vdCBtYWludGFpbmluZyB0aGUgY29kZSBzdHlsZSBh
cyBsb25nIGFzIHdlIGdldCB0aGUgYmVuZWZpdCBvZiBlYXNpbHkgc3luY2luZyBpbiBjb2RlIGZy
b20gdGhlIHVwc3RyZWFtIHByb2plY3QuICBUaGFua3MsDQoNClRoZSBnZW5lcmFsIGNvbnNlbnN1
cyBvZiBldmVyeW9uZSB3aG8gaGFzIGJlZW4gaW52b2x2ZWQgaW4gdGhlIGRpc2N1c3Npb24gc28g
ZmFyLCBzZWVtcyB0byBiZSB0aGF0IHRoZSBiZW5lZml0cyBvZiBrZWVwaW5nIHpzdGQgaW4tc3lu
YyB3aXRoIHVwc3RyZWFtIG91dHdlaWdoIHRoZSBjb3N0IG9mIGFjY2VwdGluZyB1cHN0cmVhbeKA
mXMgQVBJLCB0aG91Z2ggbm90IGV2ZXJ5b25lIGFncmVlcy4gVGhlIGFsdGVybmF0aXZlIGlzIHRv
IHByb3ZpZGUgYSB3cmFwcGVyIGFyb3VuZCB1cHN0cmVhbeKAmXMgQVBJLCBidXQgdGhpcyBtYWtl
cyBpdCBzbGlnaHRseSBoYXJkZXIgdG8gZGVidWcsIHNpbmNlIHlvdSBoYXZlIHRvIGdvIHRocm91
Z2ggdGhlIHdyYXBwZXIgd2hvc2Ugb25seSBwdXJwb3NlIGlzIHRvIGFkYXB0IHRvIHRoZSBjb2Rp
bmcgc3R5bGUsIGFuZCBhbGxvd3MgYnVncyB0byBzbmVhayBpbnRvIHRoZSBrZXJuZWwgaW1wbGVt
ZW50YXRpb24sIHdoaWNoIGFyZW7igJl0IHByZXNlbnQgdXBzdHJlYW0uDQoNCkFkZGl0aW9uYWxs
eSwgaW4gMjAxNyBMWjQgc3dpdGNoZWQgdG8gdXNpbmcgdXBzdHJlYW0gTFo04oCZcyBBUEkgaW4g
b3JkZXIgdG8gc3RheSB1cCB0byBkYXRlIHdpdGggdXBzdHJlYW0sIHdoaWNoIHNldHMgcHJlY2Vk
ZW50LiBJIGFsc28gaGVscCBtYWludGFpbiBMWjQsIGFuZCBvbmNlIHRoZSB6c3RkIHVwZGF0ZSBp
cyBtZXJnZWQsIEkgcGxhbiB0byB3b3JrIG9uIG1ha2luZyBpdCBlYXNpZXIgdG8gdXBkYXRlIExa
NCBpbiB0aGUga2VybmVsIHdoZW4gdXBzdHJlYW0gdXBkYXRlcy4gVGhhdCB3aWxsIGJlIGEgbXVj
aCBzbWFsbGVyIGNoYW5nZSwgc2luY2UgTFo0IGlzIGFscmVhZHkgbmVhcmx5IHVzaW5nIHVwc3Ry
ZWFt4oCZcyBjb2RlIGRpcmVjdGx5Lg0KDQpCZXN0LA0KTmljaw==
