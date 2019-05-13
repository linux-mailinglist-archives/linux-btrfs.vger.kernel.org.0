Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4646C1B77C
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 May 2019 15:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729938AbfEMNzk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 May 2019 09:55:40 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:37200 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729710AbfEMNzj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 May 2019 09:55:39 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4DDmBiR025380;
        Mon, 13 May 2019 06:55:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=JRSB28FqriSrL6oY4fhgvF0PqKL/uK71y3gwe6gCU7U=;
 b=UezKFt0IqDiLpAqEqhU0D4b0+glFMUjA7Ok9qbxnFTClFi3xE4scSozMKBEbs7cqqpto
 HFxQquyCvBTMtHuw1E9QPCRb9IZs+kzTgrPKIIKh2hHyxXIgiJCvfEh9CU97UAcrZwJp
 W3Kmoyli1fkipqq+eSHZxUIwMFQizA/xnak= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2sdug85y2k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 13 May 2019 06:55:11 -0700
Received: from ash-exhub102.TheFacebook.com (2620:10d:c0a8:82::f) by
 ash-exhub201.TheFacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 13 May 2019 06:55:10 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 13 May 2019 06:55:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JRSB28FqriSrL6oY4fhgvF0PqKL/uK71y3gwe6gCU7U=;
 b=jkJOiGhh0c7gZSPsFEEi/n/LDH7pvZ6ebLxFrlEEIBOdwPqxfb7rT5cVesvADyhGTWJ3UKKAjVXWCCE5XuhCd9q0obD7UF7TFFmT25MqvboDMu8OIKuIup4WXO+Q1zgJo/tTxbzI7c473BJf8u6slyVDwlvKdzriTdXT8BQBqH4=
Received: from DM5PR15MB1290.namprd15.prod.outlook.com (10.173.212.17) by
 DM5PR15MB1817.namprd15.prod.outlook.com (10.174.246.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.22; Mon, 13 May 2019 13:55:07 +0000
Received: from DM5PR15MB1290.namprd15.prod.outlook.com
 ([fe80::6182:329:231e:af13]) by DM5PR15MB1290.namprd15.prod.outlook.com
 ([fe80::6182:329:231e:af13%5]) with mapi id 15.20.1878.024; Mon, 13 May 2019
 13:55:07 +0000
From:   Chris Mason <clm@fb.com>
To:     Johannes Thumshirn <jthumshirn@suse.de>
CC:     David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 14/17] btrfs: directly call into crypto framework for
 checsumming
Thread-Topic: [PATCH 14/17] btrfs: directly call into crypto framework for
 checsumming
Thread-Index: AQHVByHcHj361c2vWkWOfcMgLPaHB6ZkHAOAgAACbwCABIsjgIAAbxUA
Date:   Mon, 13 May 2019 13:55:07 +0000
Message-ID: <9697C6F0-1C0B-4790-A96C-4B56F4DF37D0@fb.com>
References: <20190510111547.15310-1-jthumshirn@suse.de>
 <20190510111547.15310-15-jthumshirn@suse.de>
 <18303EEF-24F1-40BB-9448-A55324AA119A@fb.com>
 <A792E55A-8007-44AB-8E9A-4EE4C363D15C@fb.com> <20190513071729.GD12653@x250>
In-Reply-To: <20190513071729.GD12653@x250>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: MailMate (1.12.4r5594)
x-clientproxiedby: BN6PR19CA0108.namprd19.prod.outlook.com
 (2603:10b6:404:a0::22) To DM5PR15MB1290.namprd15.prod.outlook.com
 (2603:10b6:3:b8::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.253.148.112]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 284437cb-6267-4365-622c-08d6d7aa9b23
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:DM5PR15MB1817;
x-ms-traffictypediagnostic: DM5PR15MB1817:
x-microsoft-antispam-prvs: <DM5PR15MB18178E99109758E6E2A45E2BD30F0@DM5PR15MB1817.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0036736630
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(199004)(189003)(6916009)(83716004)(73956011)(26005)(5660300002)(66946007)(64756008)(66446008)(66476007)(66556008)(66066001)(82746002)(386003)(33656002)(6506007)(498600001)(305945005)(7736002)(14454004)(52116002)(76176011)(86362001)(186003)(6116002)(2616005)(99286004)(81166006)(81156014)(50226002)(68736007)(4744005)(36756003)(25786009)(3846002)(53546011)(6246003)(446003)(8676002)(8936002)(11346002)(54906003)(486006)(53936002)(71190400001)(71200400001)(256004)(6436002)(476003)(4326008)(102836004)(2906002)(6486002)(229853002)(6512007);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR15MB1817;H:DM5PR15MB1290.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: U1VCCN/i7Q8Q6nrDctE6rf9BQXrNLWj3nIqkweET+o+dq/6W3L05Tb7j0f6bywP3TY3MUPN861e1txpzJu12etw27UCKWZqR6dF0OD+WRVyH/ituS+4ua4oYvMomGCQkLoo9FyrL3l6Rh1gu0j1QqWoTwo7edyHjkQCxw6kmYWumV0FC0HAW/bEAxsGiZExJGyJ8ZXFasTp/MGU0K478cgi/DW5305581KeMt+OEJTL5b5EFVvjBB4/ouDXPbm5xkWL7wmTvijSgro+6e5cV1jIvzHPmYsy8JvGF3hFrCjF5pWYGv9pqs2ewq7uJurkvCB2LOI4d2vDHSAufh6G8rodFZ3+jv/YiZ57FLb00ww1t6PIBN1bPqCLv8SbX1xX+qSdW6KQQFJGRiuIo9zYp84FjTLaEJWWpwMwlH8pAS8U=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 284437cb-6267-4365-622c-08d6d7aa9b23
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2019 13:55:07.0826
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1817
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-13_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=658 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905130097
X-FB-Internal: deliver
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMTMgTWF5IDIwMTksIGF0IDM6MTcsIEpvaGFubmVzIFRodW1zaGlybiB3cm90ZToNCg0KPiBP
biBGcmksIE1heSAxMCwgMjAxOSBhdCAwMTo1NDozMFBNICswMDAwLCBDaHJpcyBNYXNvbiB3cm90
ZToNCj4+IExvb2tpbmcgYXQgdGhlIGNhbGxlcnMgb2YgYnRyZnNfY3N1bV9maW5hbCgpIGFuZCBi
dHJmc19jc3VtX2RhdGEoKSwgDQo+PiBsZXRzDQo+PiBqdXN0IHBhc3MgdGhlIHNoYXNoX2Rlc2Mg
ZnJvbSB0aGUgY2FsbGVycy4gIFRoYXQgd2F5IHlvdSBkb24ndCBoYXZlIA0KPj4gdG8NCj4+IHBv
a2UgYXQgbWVtY3B5IGFuZCBzaGFzaF9kZXNjX2N0eCgpLg0KPg0KPiBJIHdhbnRlZCB0byBhdm9p
ZCBzcHJlYWRpbmcga25vd2xlZGdlIGFib3V0IHRoZSBjcnlwdG8gYXBpIHRvIGRlZXAgDQo+IGlu
dG8gdGhlDQo+IGZpbGVzeXN0ZW0uIEknZCBhY3R1YWxseSBsb3ZlZCB0byBoYXZlIHNvbWV0aGlu
ZyBha2luIHRvIHViaWZzJw0KPiB1Ymlmc19pbmZvOjpsb2dfaGFzaCBidXQgd2Fzbid0IHJlYWxs
eSBzdXJlIGhvdyB0byBoYW5kbGUgY29uY3VycmVuY3kuDQoNCkl0J3MgbXVjaCBiZXR0ZXIgdG8g
YmUgZXhwbGljaXQgdGhhdCB3ZSdyZSB1c2luZyB0aGUgY3J5cHRvIEFQSSB0aGFuIHRvIA0KbXVj
ayBhcm91bmQgaW4gY3J5cHRvIGFwaSBpbnRlcm5hbCBkYXRhIHN0cnVjdHMuICBJdCdzIGp1c3Qg
YSBmZXcgDQpjYWxsZXJzLCBhbmQgbm90IG1ham9yIHN1cmdlcnkgdG8gY2hhbmdlIGl0IGFyb3Vu
ZCBzb21lIHRpbWUgbGF0ZXIgaWYgd2UgDQpuZWVkIHRvLg0KDQotY2hyaXMNCg==
