Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E89B41312D
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2019 17:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfECPbj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 May 2019 11:31:39 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:49492 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726267AbfECPbj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 3 May 2019 11:31:39 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x43FIeau004144;
        Fri, 3 May 2019 08:31:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=7VtPjMkozy/ug4k9Z+oQ8b1A0Qe1rL6oN0lwmvtHPJ4=;
 b=aqGyQyK1oi5jgp7x5tZEGR8eTiLZw3hClhjcGSCJ2yvCwpkv1wXbf5cqyURg8qeEKHhs
 Oy7dAT8VZ+zm3X7B7ZKUDQklGLr80PJ005rL/l85lsPH1uz4xmcPS18+qyl71Pv/++d/
 nELYr+On9I1dXPiWND7JhxkpsiQoQN5jKR4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2s8r2q022j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 03 May 2019 08:31:36 -0700
Received: from ash-exhub103.TheFacebook.com (2620:10d:c0a8:82::c) by
 ash-exhub102.TheFacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 3 May 2019 08:31:35 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 3 May 2019 08:31:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7VtPjMkozy/ug4k9Z+oQ8b1A0Qe1rL6oN0lwmvtHPJ4=;
 b=OXrL7rMXGioiXTeKTfRClvXEDO559d1+nrRhtrLWd9G0QS+WI28d6jKyAU6EXYK11bUPszWzIdBxMVEjHfUfpUYC98T1X/FhTPymq4LGsZ80mYHlLZ0xvzHy9sVuMhma0pgCEOg+pdsSk4TqmBmx47mytmYyIzSXUCdBfIOv8/I=
Received: from BYAPR15MB3479.namprd15.prod.outlook.com (20.179.60.19) by
 BYAPR15MB2680.namprd15.prod.outlook.com (20.179.156.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.12; Fri, 3 May 2019 15:31:34 +0000
Received: from BYAPR15MB3479.namprd15.prod.outlook.com
 ([fe80::7857:5261:c8c:5aa3]) by BYAPR15MB3479.namprd15.prod.outlook.com
 ([fe80::7857:5261:c8c:5aa3%2]) with mapi id 15.20.1856.012; Fri, 3 May 2019
 15:31:33 +0000
From:   Rik van Riel <riel@fb.com>
To:     "fdmanana@gmail.com" <fdmanana@gmail.com>,
        Josef Bacik <josef@toxicpanda.com>
CC:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH] btrfs: don't double unlock on error in btrfs_punch_hole
Thread-Topic: [PATCH] btrfs: don't double unlock on error in btrfs_punch_hole
Thread-Index: AQHVAcJSNUyu2kOsLUGdNgpRZcZft6ZZhUoAgAABwAA=
Date:   Fri, 3 May 2019 15:31:33 +0000
Message-ID: <b50d4c12828e720a965ef8c9c4b436383fa86f36.camel@fb.com>
References: <20190503151007.75525-1-josef@toxicpanda.com>
         <CAL3q7H6aoGNzYoXM7R5T4DsxYtOGZi0iaBEOiKB5GJrsXksaEA@mail.gmail.com>
In-Reply-To: <CAL3q7H6aoGNzYoXM7R5T4DsxYtOGZi0iaBEOiKB5GJrsXksaEA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR11CA0007.namprd11.prod.outlook.com
 (2603:10b6:405:2::17) To BYAPR15MB3479.namprd15.prod.outlook.com
 (2603:10b6:a03:112::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c091:480::e8e4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 290aab03-95e3-4197-7105-08d6cfdc6c37
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR15MB2680;
x-ms-traffictypediagnostic: BYAPR15MB2680:
x-microsoft-antispam-prvs: <BYAPR15MB2680FD801EA18AB96CF67169A3350@BYAPR15MB2680.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0026334A56
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39860400002)(136003)(346002)(376002)(199004)(189003)(110136005)(54906003)(118296001)(229853002)(2501003)(14454004)(2906002)(6116002)(316002)(256004)(14444005)(71190400001)(71200400001)(25786009)(4744005)(36756003)(99286004)(5660300002)(73956011)(68736007)(66476007)(66556008)(64756008)(66446008)(66946007)(6512007)(52116002)(53936002)(4326008)(6246003)(6486002)(6436002)(7736002)(478600001)(486006)(2616005)(305945005)(186003)(102836004)(53546011)(6506007)(386003)(76176011)(86362001)(81166006)(8936002)(11346002)(446003)(8676002)(81156014)(46003)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2680;H:BYAPR15MB3479.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xTu6nATeQs82Vs0OtoP30uodQh829p5L98EEKD/fjEbQfCXg/mEpkoACvZj6cczCIHb1eZyW5LvZB5qLXf087V0uGbGnPqPBFvuxcA/1AkELuXILdvKwhod6ZDFx+JMqcBQR4/rSGOjQI93nixsU3CngoLBuPZH0HHGGlJUPmk1NKdJ8WW4KhlFdAKkKz7qDvSmzFtRb65cJ4BMlhZfP6ocvLERUiRiDS81BTydq+gICMnlqPdsfqrECKZz9HGXLR9lr1LbB+9qaU0WQF8PEhim8MfOJYBmPoEZYbATaSdleo5I++Z6KMJjMTdkMOBt7howqdy9z9+OFFnyhxlWFBuA9vrzwv2HK8UUpZGTzU4rsIQTrplkcN9BcRe3EZirNhi+vS5kV/8YySgDav1wpyxfgat11qXz9bgLQu2q9gPY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <161FECBBD14FA34D9CA00DE00606F1DC@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 290aab03-95e3-4197-7105-08d6cfdc6c37
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2019 15:31:33.8243
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2680
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-03_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=728 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905030098
X-FB-Internal: deliver
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gRnJpLCAyMDE5LTA1LTAzIGF0IDE2OjI1ICswMTAwLCBGaWxpcGUgTWFuYW5hIHdyb3RlOg0K
PiBPbiBGcmksIE1heSAzLCAyMDE5IGF0IDQ6MjEgUE0gSm9zZWYgQmFjaWsgPGpvc2VmQHRveGlj
cGFuZGEuY29tPg0KPiB3cm90ZToNCj4gPiBJZiB3ZSBoYXZlIGFuIGVycm9yIHdyaXRpbmcgb3V0
IGEgZGVsYWxsb2MgcmFuZ2UgaW4NCj4gPiBidHJmc19wdW5jaF9ob2xlX2xvY2tfcmFuZ2Ugd2Un
bGwgdW5sb2NrIHRoZSBpbm9kZSBhbmQgdGhlbiBnb3RvDQo+ID4gb3V0X29ubHlfbXV0ZXgsIHdo
ZXJlIHdlIHdpbGwgYWdhaW4gdW5sb2NrIHRoZSBpbm9kZS4gIFRoaXMgaXMgYmFkLA0KPiA+IGRv
bid0IGRvIHRoaXMuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogSm9zZWYgQmFjaWsgPGpvc2Vm
QHRveGljcGFuZGEuY29tPg0KPiANCj4gUmV2aWV3ZWQtYnk6IEZpbGlwZSBNYW5hbmEgPGZkbWFu
YW5hQHN1c2UuY29tPg0KPiANCj4gTG9va3MgZ29vZCwgSSBpbnRyb2R1Y2VkIHRoZSBkb3VibGUg
dW5sb2NrIGFjY2lkZW50YWxseS4NCg0KRG9lcyB0aGUgcGF0Y2ggbmVlZCBhIEZpeGVzOiB0YWcg
c28gdGhlIC1zdGFibGUNCnBlb3BsZSBrbm93IGhvdyBmYXIgdG8gYmFja3BvcnQgaXQ/DQoNCg==
