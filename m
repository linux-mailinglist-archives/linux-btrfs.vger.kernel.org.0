Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2F5719E88
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 May 2019 15:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbfEJNyk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 May 2019 09:54:40 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:33398 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727249AbfEJNyk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 May 2019 09:54:40 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4ADcHQj022205;
        Fri, 10 May 2019 06:54:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=9DvwEMVxHtBA5+XUGgKCrfWzKkk6rbTELPJMf1jNmPU=;
 b=TCaL/HhF140sjXdJkwgx+0sJIWmL1PodtlYMZ1NmRmY/0SN+UD3wCRSzaruQm62aqX4J
 FoSvaXPFQl6N/GHWTXFlY5zITHYcZD4V6qcbd7K0ezeHdVEoP51vTHXKby+IRLmcLZ54
 cb1Z0Oug8LoYgOvMPWIHolTHL4thxWaWhDo= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2scv04jj5e-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 10 May 2019 06:54:34 -0700
Received: from ash-exhub102.TheFacebook.com (2620:10d:c0a8:82::f) by
 ash-exhub104.TheFacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 10 May 2019 06:54:31 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 10 May 2019 06:54:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9DvwEMVxHtBA5+XUGgKCrfWzKkk6rbTELPJMf1jNmPU=;
 b=ADYZnE0xBQvD9EjiGG74w/NtCUAu1rSN3qLVkjUMaZhmWffmzT5E6LXHXZI5iUlBW/sAMKzEduao0h+2YqwI4dU6Rn+zlT+dWM295QtHwKsAgWkJ6nbXL4Sp8NNSrYRAiIzOpQGr6nmi7GH7u5LL4SYZ5DWf+vsgu8uWXS+PaTY=
Received: from DM5PR15MB1290.namprd15.prod.outlook.com (10.173.212.17) by
 DM5PR15MB1323.namprd15.prod.outlook.com (10.173.215.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.21; Fri, 10 May 2019 13:54:30 +0000
Received: from DM5PR15MB1290.namprd15.prod.outlook.com
 ([fe80::6182:329:231e:af13]) by DM5PR15MB1290.namprd15.prod.outlook.com
 ([fe80::6182:329:231e:af13%5]) with mapi id 15.20.1878.019; Fri, 10 May 2019
 13:54:30 +0000
From:   Chris Mason <clm@fb.com>
To:     Johannes Thumshirn <jthumshirn@suse.de>
CC:     David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 14/17] btrfs: directly call into crypto framework for
 checsumming
Thread-Topic: [PATCH 14/17] btrfs: directly call into crypto framework for
 checsumming
Thread-Index: AQHVByHcHj361c2vWkWOfcMgLPaHB6ZkHAOAgABFfgA=
Date:   Fri, 10 May 2019 13:54:30 +0000
Message-ID: <A792E55A-8007-44AB-8E9A-4EE4C363D15C@fb.com>
References: <20190510111547.15310-1-jthumshirn@suse.de>
 <20190510111547.15310-15-jthumshirn@suse.de>
 <18303EEF-24F1-40BB-9448-A55324AA119A@fb.com>
In-Reply-To: <18303EEF-24F1-40BB-9448-A55324AA119A@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: MailMate (1.12.4r5594)
x-clientproxiedby: BL0PR0102CA0041.prod.exchangelabs.com
 (2603:10b6:208:25::18) To DM5PR15MB1290.namprd15.prod.outlook.com
 (2603:10b6:3:b8::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c091:480::8888]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 41e575b2-10d5-4229-65b2-08d6d54f0639
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:DM5PR15MB1323;
x-ms-traffictypediagnostic: DM5PR15MB1323:
x-microsoft-antispam-prvs: <DM5PR15MB13232217248D9FA458CDD40BD30C0@DM5PR15MB1323.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0033AAD26D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(376002)(136003)(346002)(396003)(199004)(189003)(316002)(6512007)(5660300002)(8936002)(6436002)(6486002)(99286004)(6916009)(53936002)(186003)(33656002)(53546011)(386003)(102836004)(6506007)(11346002)(25786009)(4326008)(486006)(2616005)(476003)(52116002)(76176011)(446003)(46003)(229853002)(83716004)(7736002)(6246003)(71190400001)(71200400001)(8676002)(54906003)(36756003)(305945005)(14454004)(82746002)(14444005)(50226002)(86362001)(256004)(81156014)(66556008)(68736007)(81166006)(2906002)(73956011)(66476007)(66946007)(66446008)(64756008)(6116002)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR15MB1323;H:DM5PR15MB1290.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BvC0PkFGG8KrjB5tH9zkp3FtBy/DJN1BQ3CTZS1DoIAgkoRyFr7yx8SNgSTsRzFfODwF1Yg15OYM6yeb1Zl+g835WZrvr7T21loG0qKNhZN+8P6FSs3EV7ahXFjmsx6QJa6ZBeOHbK7JOIEglWHSxPcoQcMNOZvfElErH5usTDqLxy2l9IeNfiwUgrE2r6iZzfNv5K6JXndIxigY/un+1WOL2RcBe9MTEO6iAMvxPqyefggjeK8WLaDYAE5FZ7tC5KQGBcoOBmI/eQgbKHMO+5wZnv6dqxYEyz1DZgDXV1w0LEw9vJ5F6o2kv1sfbUkGGetZ13XTQwxjjkzighkHGySBLbNsxtrMnR5SZBkwnLmJhbzatdkVpXbYbW29+CPfTdvUatsl+XbmDPl3HB3Bcr/qQJ0oqZ1rNIR6lzc3cpc=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 41e575b2-10d5-4229-65b2-08d6d54f0639
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2019 13:54:30.5413
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1323
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-09_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=829 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905100096
X-FB-Internal: deliver
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

DQoNCk9uIDEwIE1heSAyMDE5LCBhdCA5OjQ1LCBDaHJpcyBNYXNvbiB3cm90ZToNCg0KPiBPbiAx
MCBNYXkgMjAxOSwgYXQgNzoxNSwgSm9oYW5uZXMgVGh1bXNoaXJuIHdyb3RlOg0KPg0KPj4gQ3Vy
cmVudGx5IGJ0cmZzX2NzdW1fZGF0YSgpIHJlbGllZCBvbiB0aGUgY3JjMzJjKCkgd3JhcHBlciBh
cm91bmQgdGhlIA0KPj4gY3J5cHRvDQo+PiBmcmFtZXdvcmsgZm9yIGNhbGN1bGF0aW5nIHRoZSBD
UkNzLg0KPj4NCj4+IEFzIHdlIGhhdmUgb3VyIG93biBjcnlwdG9fc2hhc2ggc3RydWN0dXJlIGlu
IHRoZSBmc19pbmZvIG5vdywgd2UgY2FuDQo+PiBkaXJlY3RseSBjYWxsIGludG8gdGhlIGNyeXB0
byBmcmFtZXdvcmsgd2l0aG91dCBnb2luZyB0cm91Z2ggdGhlIA0KPj4gd3JhcHBlci4NCj4NCj4g
SXQgaGFzIGJlZW4gYSB3aGlsZSBzaW5jZSBJIGR1ZyB0aHJvdWdoIHRoZSBjcnlwdG9hcGkgaW50
ZXJuYWxzLiAgSSANCj4gaGF2ZSBvbmUgdmFndWUgYW5kIHNvbWV3aGF0IHVuZm91bmRlZCBjb25j
ZXJuLCB3aGVyZSB3ZSdyZSBkZWZpbmluZyANCj4gdGhlIGRpc2sgZm9ybWF0IHRvIGJlIHdoYXRl
dmVyIGlzIHJldHVybmVkIGZyb20gbG9va2luZyB1cCBzaGEyNTYgb3IgDQo+IGNyYzMyYyBpbiB0
aGUgY3J5cHRvIHRhYmxlcy4gIEknbSBub3QgcmVhbGx5IHN1cmUgaG93IHRvIHJlc29sdmUgdGhp
cyANCj4gc2luY2Ugd2Ugb2J2aW91c2x5IGRvbid0IHdhbnQgb3VyIG93biBzaGEyNTYgaW1wbGVt
ZW50YXRpb24uDQo+DQo+IEknbSBhIGxpdHRsZSBjb25jZXJuZWQgYWJvdXQgYWJvdXQgYnRyZnNf
Y3N1bV9kYXRhKCkgYW5kIA0KPiBidHJmc19jc3VtX2ZpbmFsKCkgYmVsb3cuICBXZSdyZSB1c2lu
ZyB0d28gZGlmZmVyZW50IA0KPiBTSEFTSF9ERVNDX09OX1NUQUNLKCkgYW5kIHRoZW4gb3Zlcndy
aXRpbmcgaW50ZXJuYWxzIA0KPiAoc2hhc2hfZGVzY19jdHgoKSkgd2l0aCB0aGUgYXNzdW1wdGlv
biB0aGF0IHdoYXRldmVyIHdlJ3JlIGRvaW5nIGlzIA0KPiBnb2luZyB0byBiZSB0aGUgc2FtZSBh
cyB1c2luZyB0aGUgc2FtZSBzaGFzaF9kZXNjIHN0cnVjdCBmb3IgYm90aCB0aGUgDQo+IHVwZGF0
ZSBhbmQgZmluYWwgY2FsbHMuICBJIHRoaW5rIHdlIHNob3VsZCBiZSBlaXRoZXIgdXNpbmcgb3Ig
YWRkaW5nIGEgDQo+IGhlbHBlciB0byB0aGUgY3J5cHRvIGFwaSBmb3IgdGhpcy4gIFdlJ3JlIGRp
Z2dpbmcgdG9vIGRlZXAgaW50byANCj4gY3J5cHRvYXBpIHByaXZhdGUgc3RydWN0cyB3aXRoIHRo
ZSBjdXJyZW50IHVzYWdlLg0KDQpMb29raW5nIGF0IHRoZSBjYWxsZXJzIG9mIGJ0cmZzX2NzdW1f
ZmluYWwoKSBhbmQgYnRyZnNfY3N1bV9kYXRhKCksIGxldHMgDQpqdXN0IHBhc3MgdGhlIHNoYXNo
X2Rlc2MgZnJvbSB0aGUgY2FsbGVycy4gIFRoYXQgd2F5IHlvdSBkb24ndCBoYXZlIHRvIA0KcG9r
ZSBhdCBtZW1jcHkgYW5kIHNoYXNoX2Rlc2NfY3R4KCkuDQoNCkknbSBhIGxpdHRsZSB3b3JyaWVk
IGFib3V0IHN0YWNrIHVzYWdlIChhdCBsZWFzdCAzNjAgYnl0ZXMpLCBidXQgd29yc3QgDQpjYXNl
IHdlIGNhbiBkbyBzb21lIHBlcmNwdSBneW1uYXN0aWNzLg0KDQotY2hyaXMNCg==
