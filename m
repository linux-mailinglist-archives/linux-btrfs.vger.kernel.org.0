Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2B2F26DE8F
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Sep 2020 16:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbgIQOW1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Sep 2020 10:22:27 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:38336 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727456AbgIQOUk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Sep 2020 10:20:40 -0400
X-Greylist: delayed 972 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 10:20:18 EDT
Received: from pps.filterd (m0042983.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08HE0ju0003861;
        Thu, 17 Sep 2020 07:01:07 -0700
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-00082601.pphosted.com with ESMTP id 33k5pem09d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Sep 2020 07:01:07 -0700
Received: from pps.reinject (m0042983.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08HDv0dG028393;
        Thu, 17 Sep 2020 06:57:40 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 33k5q65h7r-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 16 Sep 2020 12:18:22 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 16 Sep 2020 12:18:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M0InFZXC9ZxuTTf0SEDyjuokpEL06DCzzq7ung6ixG6nrFkgTNgWQ/8ksMiZCtyjAm1xKOIyebOgHmnqu06++0bC+zbn1R6C7d8iqpeQbMw1CPQG/QpM5jUt9o7cYgijzGW+KfOQz5RefjLKfBbrszWMVaYnaBjEx0rl3X/uJTJUj29rKRdoRSzBH2FmCLYRhd0ffIiEwiW/kvuQFtxOqXto826UFGyYSGKYElDagE39UO8RcBSIYYbyXG8a4PA9BZ0+UB/hhmV3zG2WSQrr+l9lD+CZwtZa4Fam4DNt618q9Y+8B4cNT3hAOBCvEXfC0UfA2yhqu3r+ltufYQyJOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pl/bAI3AqxzrrH9ft3zpTCD/pLp07hprxYHeL2EAyfg=;
 b=g9lj6YLVfEUoOcAN0ESmUEkbig8Q6NlQtnInfNL3qHGzyypKWBw9X4YpWyGErUWnycWP1o34T43ZEbaHtqhOx7XNEIMQTrs7exfYuT+dfQoNJSjoG+CNNL3mAXeOl8VrDMPzv9GUfESgmFrvqnOyepMPl+c9fMrpgy3iLbCxoXpH6ijU7wIcI3nYKtjZo9C6Az9rIzbuiFU9SfMl1Nl6hXUQc3IPzMh1zWhz5vZCB6f5bVyQCh/8NAodP7QD5Zj3y0Bv+uAHDO0qrE6dznhUSLm8vemcDDh2hqkmY5wfXsEeD5cMQBMrLc/hJrgb0t9WTRS94CKRYL92bIs/UlxCkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pl/bAI3AqxzrrH9ft3zpTCD/pLp07hprxYHeL2EAyfg=;
 b=JGbt6PlgaL1lV6csxMctlfLUmUH52a7N8x8L9J6uabp9cdV5S20yF2Sf5eW37ErhWFaXBAuzterOXZ0nNpKR4h/X5QXtOsDPK9sLiT5v66+aNPCsSsIHkWY45I6R+V0Ju65G0ktr/4RPmcNkfLsBUXdikYUJsIweMWCE0x5svJI=
Received: from BY5PR15MB3667.namprd15.prod.outlook.com (2603:10b6:a03:1f9::18)
 by BYAPR15MB2997.namprd15.prod.outlook.com (2603:10b6:a03:b0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 16 Sep
 2020 19:18:17 +0000
Received: from BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::2d08:987a:126:1c9c]) by BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::2d08:987a:126:1c9c%7]) with mapi id 15.20.3391.014; Wed, 16 Sep 2020
 19:18:17 +0000
From:   Nick Terrell <terrelln@fb.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     Chris Mason <clm@fb.com>, Nick Terrell <nickrterrell@gmail.com>,
        "Herbert Xu" <herbert@gondor.apana.org.au>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        "squashfs-devel@lists.sourceforge.net" 
        <squashfs-devel@lists.sourceforge.net>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>, Petr Malat <oss@malat.biz>,
        Johannes Weiner <jweiner@fb.com>,
        Niket Agarwal <niketa@fb.com>, Yann Collet <cyan@fb.com>
Thread-Topic: [PATCH 5/9] btrfs: zstd: Switch to the zstd-1.4.6 API
Thread-Index: AQHWi9t+F+963YLOT0SgwBoo2TG/malq9P8AgABcdACAAALEAIAAA28AgAAA6ACAAEv8AA==
Date:   Wed, 16 Sep 2020 19:18:17 +0000
Message-ID: <4D04D534-75BD-4B13-81B9-31B9687A6B64@fb.com>
References: <20200916034307.2092020-1-nickrterrell@gmail.com>
 <20200916034307.2092020-7-nickrterrell@gmail.com>
 <20200916084958.GC31608@infradead.org>
 <CCDAB4AB-DE8D-4ADE-9221-02AE732CBAE2@fb.com>
 <20200916143046.GA13543@infradead.org>
 <1CAB33F1-95DB-4BC5-9023-35DD2E4E0C20@fb.com>
 <20200916144618.GB16392@infradead.org>
In-Reply-To: <20200916144618.GB16392@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:d83f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 97a5bd0e-43fb-42a2-f4da-08d85a75441d
x-ms-traffictypediagnostic: BYAPR15MB2997:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB299780DCB400AFD7B04A0361AB210@BYAPR15MB2997.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NVcV/Vtkfy+btdGrv35JUEYADiDiC2P/EB6jTD+hbJQEC7sewWq9c0yOrPfhslVYIZVHhoTK0R9bwJuHUiWswPO//U+wPnvhgav9GnN+ndkK1Aial1vFw4Qr6T+xPaS9mCG/sWiHZTqGJBCDEXU3P2cDcOQTFlqtk+5QMdSdeRVcul7dBW/OU8Gz/H3FOYLhz6Zr4JnYxRhEdu7v026x5AfZf3njJPLrGZV/bAmkzx3LRo0U7W6sqLFaNIVD12FjpKfNHrgEF1qvpmWj2DhGeMzdIyqltz8WSPicaY1bZHnXyXO+6IyJV67onsNv8PQPMTD8cSkx+sRwhgheFpf0wuYsGqsMTtbR1QvmLEgAtupZHzxrdqgzFQ3QjLKNzgul
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3667.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(346002)(366004)(396003)(136003)(33656002)(54906003)(2906002)(64756008)(66476007)(76116006)(71200400001)(66946007)(5660300002)(91956017)(66446008)(6506007)(186003)(316002)(4326008)(86362001)(66556008)(6486002)(53546011)(478600001)(6512007)(36756003)(8676002)(8936002)(2616005)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: GbDkf9zRIf4fbXdCu0/czb1JawfWzOllAc5/aye20eRw60401jr4KClHdz+N8AyYcT2ptUbbLWzbcgiY5E/ID9/oytH9QnjD9RvZ6egBQwEnTYqyyR6LcfhsQMSbVVSO058RG/BeDNPRw2U1zAhWI8G4p0M/1h/LoiaALIwFQ3uuKw5KY5DFNC2bsiEFlIg0I8ymHfl/PdE/P3BYs/AFtFQOmTXH8ZxeB8WxucUabkHDwtHPz/OgBELpwid49jxbD3t224+vCOuBbuVcxehisJzfZf4a7UTby3AC45ChSm3O++13DNDn29j4bx89zcep30sG+xZDHuxSUW6Gw08i/QLM9gyKcey0VDilw2wC4ef99utZd+qIXJK9xUG9vDvBHoCxFXMi8v/fEt8a00ClBsgEyR5jHVh5E45IUCxAOUBSnI3B3uUvKZmDTBhC5xe8ntNUXkMlBy0ZoVe6bIpHmE3E+7kol1Kn4LYRfI63xl0u0bH7Y1+gSmFh2QADsZ4+FUh6vKbvaVxHL9zy9AAxfygqNdjJjIRStRcL/6JzIS09lvldcy1CMRQTMnYKb76g3eeNc4sxVs9IxHFdHgjJOOj3SmBxMzoXSDbw+n+YDZw2mYSTJ4nBU9z9ZO8E8TTXwWIom9oPF5LG5OOr071WsBH7mVP4+bEZIQ/rzi/EyL+DCKidOzmXHRDIvuaLraJ4
Content-ID: <74653741ADB844449A7BD81A4044B26F@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3667.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97a5bd0e-43fb-42a2-f4da-08d85a75441d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2020 19:18:17.1633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vPzQgLi29MiCYv6hPBiPZ0gbFYqZYyrcjVrybmrzi+cckDzUJwrmwM7+D2jgwo56
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2997
X-OriginatorOrg: fb.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-16_12:2020-09-16,2020-09-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 bulkscore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 impostorscore=0 adultscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009160135
X-FB-Internal: deliver
subject: Re: [PATCH 5/9] btrfs: zstd: Switch to the zstd-1.4.6 API
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-17_09:2020-09-16,2020-09-17 signatures=0
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

DQoNCj4gT24gU2VwIDE2LCAyMDIwLCBhdCA3OjQ2IEFNLCBDaHJpc3RvcGggSGVsbHdpZyA8aGNo
QGluZnJhZGVhZC5vcmc+IHdyb3RlOg0KPiANCj4gT24gV2VkLCBTZXAgMTYsIDIwMjAgYXQgMTA6
NDM6MDRBTSAtMDQwMCwgQ2hyaXMgTWFzb24gd3JvdGU6DQo+PiBPdGhlcndpc2Ugd2UganVzdCBl
bmQgdXAgd2l0aCBkcmlmdCBhbmQga2VybmVsLXNwZWNpZmljIGJ1Z3MgdGhhdCBhcmUgaGFyZGVy
DQo+PiB0byBkZWJ1Zy4gIFRvIHRoZSBleHRlbnQgdGhvc2UgQVBJcyBtYWtlIHVzIGNvbnRvcnQg
dGhlIGtlcm5lbCBjb2RlLCBJPz8/bQ0KPj4gc3VyZSBOaWNrIGlzIGludGVyZXN0ZWQgaW4gaW1w
cm92aW5nIHRoaW5ncyBpbiBib3RoIHBsYWNlcy4NCj4gDQo+IFNlcmlvdXNseSwgd2UgZG8gbm90
IGNhcmUgZWxzZXdoZXJlLiAgV2h5IHdvdWxkIHpsaWIgYmUgYW55IGRpZmZlcmVudD8NCj4gDQo+
PiBUaGVyZSBhcmUgcHJvYmFibHkgMTAwMCBjb25zdHJ1Y3RpdmUgd2F5cyB0byBoYXZlIHRoYXQg
Y29udmVyc2F0aW9uLiAgUGxlYXNlDQo+PiBjaG9vc2Ugb25lIG9mIHRob3NlIGluc3RlYWQgb2Yg
YmVpbmcgYW4gYXNzaG9sZS4NCj4gDQo+IEkgdGhpbmsgeW91IGFyZSB0aGUgYXNzaG9sZSBoZXJl
IGJ5IGlnbm9yaW5nIHRoZSBwcmFjdGljZXMgd2UgYXJlIHVzaW5nDQo+IGVsc2V3aGVyZSBhbmQg
dGhpbmsgeW91ciBlbXBsb3llcnMgcGV0IHByb2plY3QgaXMgc29tZWhvdyBzcGVjaWFsLiAgSXQN
Cj4gaXMgbm90LCBhbmQgY2xhaW1pbmcgc28gaXMgZXZlcnl0aGluZyBidXQgY29uc3RydWN0aXZl
Lg0KDQpNeSBnb2FsIGluIHVwZGF0aW5nIHRoZSB6c3RkIGtlcm5lbCB0byB1c2UgdGhlIHVwc3Ry
ZWFtIEFQSSBkaXJlY3RseSBpcyB0bw0KbWFrZSBmcmVxdWVudCBzeW5jcyBpbnRvIHRoZSBrZXJu
ZWwgZWFzeS4gVGhpcyBpcyBpbXBvcnRhbnQgc28gdGhlIGtlcm5lbA0KZG9lc24ndCBtaXNzIG91
dCBvbiBidWcgZml4ZXMgYW5kIHBlcmZvcm1hbmNlIGltcHJvdmVtZW50cy4NCg0KVGhlIHVwc3Ry
ZWFtIHpzdGQgaXMgY29udGludW91c2x5IGZ1enplZCBhbmQgaXMgYmF0dGxlIHRlc3RlZCBpbiBw
cm9kdWN0aW9uDQphbmQgYWNyb3NzIG1hbnkgZGlmZmVyZW50IHByb2plY3RzIGV4dGVybmFsIHRv
IEZhY2Vib29rLiBUaGF0IG1lYW5zIHRoYXQNCnpzdGQtMS40LjYgaGFzIGFuIGFkZGl0aW9uYWwg
MyB5ZWFycyBvZiBjb250aW51b3VzIGZ1enppbmcsIGFzIHdlbGwgYXMNCmltcHJvdmVtZW50cyB0
byBvdXIgZnV6eiBhbmQgdGVzdCBzdWl0ZS4NCg0KVGhlIHpzdGQgdmVyc2lvbiBpbiB0aGUga2Vy
bmVsIHdvcmtzIGZpbmUuIEJ1dCwgeW91IGNhbiBzZWUgdGhhdCB0aGUgdmVyc2lvbg0KdGhhdCBn
b3QgaW1wb3J0ZWQgc3RhZ25hdGVkIHdoZXJlIHVwc3RyZWFtIGhhZCAxNCByZWxlYXNlZCB2ZXJz
aW9ucy4gSQ0KZG9uJ3QgdGhpbmsgaXQgbWFrZXMgc2Vuc2UgdG8gaGF2ZSBrZXJuZWwgZGV2ZWxv
cGVycyBtYWludGFpbiB0aGVpciBvd24gY29weQ0Kb2YgenN0ZC4gVGhlaXIgdGltZSB3b3VsZCBi
ZSBiZXR0ZXIgc3BlbnQgd29ya2luZyBvbiB0aGUgcmVzdCBvZiB0aGUga2VybmVsLg0KVXNpbmcg
dXBzdHJlYW0gZGlyZWN0bHkgbGV0cyB0aGUga2VybmVsIHByb2ZpdCBmcm9tIHRoZSB3b3JrIHRo
YXQgd2UsIHRoZSB6c3RkDQpkZXZlbG9wZXJzLCBhcmUgZG9pbmcuIEFuZCBpdCBzdGlsbCBhbGxv
d3Mga2VybmVsIGRldmVsb3BlcnMgdG8gZml4IGJ1Z3MgaWYgYW55DQpzaG93IHVwLCBhbmQgd2Ug
Y2FuIGJhY2stcG9ydCB0aGVtIHRvIHVwc3RyZWFtLg0KDQpGb3IgZXhhbXBsZSwgSeKAmXZlIG1l
YXN1cmVkIHRoYXQgQnRyRlMgZGVjb21wcmVzc2lvbiArIHJlYWQgcGVyZm9ybWFuY2UNCmlzIGlt
cHJvdmVkIDE1JSB3aXRoIHRoaXMgcGF0Y2guIEFuZCBaUkFNIHBlcmZvcm1hbmNlIGltcHJvdmVz
IDMwJS4NCkFuZCBTcXVhc2hGUyBkZWNvbXByZXNzaW9uICsgcmVhZCBwZXJmb3JtYW5jZSBpbXBy
b3ZlcyAxNSUuDQoNCkFkbWl0dGVkbHksIHRoZSBBUEkgcHJvdmlkZWQgZm9yIHN0YXRpYyB3b3Jr
c3BhY2UgYWxsb2NhdGlvbiBpcyB2ZXJib3NlLiBNb3N0DQp6c3RkIHVzZXJzIGRvbuKAmXQgbmVl
ZCBpdCwgc28gb3VyIGVmZm9ydHMgdG8gaW1wcm92ZSB0aGUgZXJnb25vbWljcyBvZiB0aGUgQVBJ
DQpoYXZlbuKAmXQgYmVlbiBmb2N1c2VkIGhlcmUuIEF0IHRoaXMgcG9pbnQsIHdlIGNvdWxkbuKA
mXQgcmVuYW1lIHRoZXNlIEFQSXMgZWFzaWx5LA0Kc2luY2Ugd2UgaGF2ZSB1c2VycyByZWx5aW5n
IG9uIG91ciBBUEkuIEl0IGNvdWxkIGJlIGRvbmUsIGJlY2F1c2Ugd2UgZG9u4oCZdA0KZ3VhcmFu
dGVlIEFCSSBzdGFiaWxpdHkgZm9yIHRoaXMgcG9ydGlvbiBvZiB0aGUgQVBJLCBidXQgd2Ugd291
bGQgaGF2ZSB0byBoYXZlDQphIGdvb2QgcmVhc29uIGZvciBpdC4NCg0KT25lIHBvc3NpYmlsaXR5
IGlzIHRvIGhhdmUgYSBrZXJuZWwgd3JhcHBlciBvbiB0b3Agb2YgdGhlIHpzdGQgQVBJIHRvIG1h
a2UgaXQNCm1vcmUgZXJnb25vbWljLiBJIHBlcnNvbmFsbHkgZG9u4oCZdCByZWFsbHkgc2VlIHRo
ZSB2YWx1ZSBpbiBpdCwgc2luY2UgaXQgYWRkcw0KYW5vdGhlciBsYXllciBvZiBpbmRpcmVjdGlv
biBiZXR3ZWVuIHpzdGQgYW5kIHRoZSBjYWxsZXIsIGJ1dCBpdCBjb3VsZCBiZSBkb25lLg0KDQpP
ZiBhbGwgdGhlIGNvbXByZXNzb3JzIGluIHRoZSBrZXJuZWwsIG9ubHkgbHo0IGFuZCB6c3RkIGFy
ZSB1bmRlciBhY3RpdmUNCmRldmVsb3BtZW50LiBBbmQgbHo0IGhhcyBzd2l0Y2hlZCB0byB1c2lu
ZyB0aGUgdXBzdHJlYW0gQVBJIGRpcmVjdGx5Lg0KWHogZG9lcyBzZWUgYSBsaXR0bGUgYml0IG9m
IGRldmVsb3BtZW50LCBidXQgbm90aGluZyBoYXMgYmVlbiBzeW5jZWQgdG8gdGhlDQprZXJuZWwu
DQoNCkJlc3QsDQpOaWNr
