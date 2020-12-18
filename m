Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D12962DE967
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Dec 2020 19:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732723AbgLRS7Z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Dec 2020 13:59:25 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:11892 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725875AbgLRS7Y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Dec 2020 13:59:24 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BIItjJj030741;
        Fri, 18 Dec 2020 10:57:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=2M0QgBo5FmaEE9AMvHpca5kIUYPqk54OfbVwi7ond5c=;
 b=fRE8Mv//6+LyRYJOadarvg+Zt4pSOldfiWqZ3irpmBw7IpmC2vngm+xwb0b/soOUhm6K
 ZUK9kVokcf/URzVmSbAPIc5jrGgps7+lqQGu9xFTtaYlsNWi2i0QmFgNUtqIfk++Q4/S
 5VeHaXdTtbgRPOeZKDgSgahMSzXp+xqdNls= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 35gwa89pdy-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 18 Dec 2020 10:57:33 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 18 Dec 2020 10:57:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C+MoTJ4LsC4dA64ORNHUwOjMn6JdWEsUNnb5Q43LncMFUWtgwDVSPpIsqkR2Sxe23T6RgZ6BITnikt7dR562c39zpzH12Oox7QQGKG+jRPSzCs/iRgsTiHc4tV/lo1mD8czCNMn1dvl5V1bU+89GUVDh9cBUA2v0obP//B3Nf1EX7w+vqkTh0e9Lf40BnsneKyMNcp3GBX+Ro4Aq+s/sXlQcKLYfj+3OOHTdDPb88uiRuy6v/q3lNtbyMD0Kr8SPnyDy1BEJkZwCgr84tNQRRtAI4onbpr8VfPQfFoY4kR4sVRsW6it4CylmojJKbH/cZ4DO1d/Hc5XeAmZrYaWNiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2M0QgBo5FmaEE9AMvHpca5kIUYPqk54OfbVwi7ond5c=;
 b=jwayu/W3J6iaKqKd+0+bFToErxe1oGLr6l7Ti9G0V7xZ5fVlj2fM36FBxyPv7QrEVlHonviDT/6Ru7aBzNXQxNruAc1Y55dU0F6eSMfmxBBc1bqlZpAEJhTuuXSrGZTcA2sQ1h5IhfmDzVc/QI7zed2oCUGln5JWvhhXmLP+EP5mTG5Ofe3hSiqgx8n62NWC7ApdpJdO1JoK5NhGyBV2NvR87GI9hcGQl8p4A46YL10ph8WmdXfN4x+TVKUVlCQA8RlmvueQrs9pCMXlf3b21EE6Ya4U4u5NsM4XvN5AgcriWYnC1QiLyQTeeTfnz5a45yJ4f6d85FE4FPYmcKVc4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2M0QgBo5FmaEE9AMvHpca5kIUYPqk54OfbVwi7ond5c=;
 b=IHu/57n0/qmuOi2q5gxz9FHuW3fWzWyQCmitoofexdwiXDQfvEMPdNFBEBogezZlz5sugJsYyJMc13wyBhqBPLm1P1AVl5b/IsMVFs6xl2XvoUeCsXZcZRb4FaiA+nnUuEdGrPIy/Y4tH0NpSJfKf4uK4MZYMMTbSM+rSwZjQ8c=
Received: from BY5PR15MB3667.namprd15.prod.outlook.com (2603:10b6:a03:1f9::18)
 by BYAPR15MB2326.namprd15.prod.outlook.com (2603:10b6:a02:84::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Fri, 18 Dec
 2020 18:57:29 +0000
Received: from BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::17e:aa61:eb50:290c]) by BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::17e:aa61:eb50:290c%7]) with mapi id 15.20.3654.025; Fri, 18 Dec 2020
 18:57:29 +0000
From:   Nick Terrell <terrelln@fb.com>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
CC:     David Sterba <dsterba@suse.cz>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Eric Biggers <ebiggers@kernel.org>,
        Nick Terrell <nickrterrell@gmail.com>,
        "squashfs-devel@lists.sourceforge.net" 
        <squashfs-devel@lists.sourceforge.net>,
        Christoph Hellwig <hch@infradead.org>,
        Yann Collet <cyan@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Petr Malat <oss@malat.biz>, "Chris Mason" <clm@fb.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "Niket Agarwal" <niketa@fb.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        "Johannes Weiner" <jweiner@fb.com>
Subject: Re: [f2fs-dev] [PATCH v7 0/3] Update to zstd-1.4.6
Thread-Topic: [f2fs-dev] [PATCH v7 0/3] Update to zstd-1.4.6
Thread-Index: AQHWybXbXo5DSFQdaEqlAnoQrw8JMqn4tsKAgAAywQCAAA2CgIAAApeAgAEruQCAADb6AIAANsMAgAK4xQA=
Date:   Fri, 18 Dec 2020 18:57:29 +0000
Message-ID: <EEFB7148-86B7-4761-BAB2-D35F29614A3E@fb.com>
References: <20201203205114.1395668-1-nickrterrell@gmail.com>
 <DF6B2E26-2D6E-44FF-89DB-93A37E2EA268@fb.com>
 <X9lOHkAE67EP/sXo@sol.localdomain>
 <B3F00261-E977-4B85-84CD-66B07DA79D9D@fb.com>
 <20201216005806.GA26841@gondor.apana.org.au>
 <20201216185052.GL6430@twin.jikos.cz>
 <6C449BCE-E7DB-4EE6-B4F5-FED3977BD8F0@fb.com>
 <20201217012337.GA24705@qmqm.qmqm.pl>
In-Reply-To: <20201217012337.GA24705@qmqm.qmqm.pl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: rere.qmqm.pl; dkim=none (message not signed)
 header.d=none;rere.qmqm.pl; dmarc=none action=none header.from=fb.com;
x-originating-ip: [98.33.101.203]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c76a7279-1503-4881-4370-08d8a386c4bd
x-ms-traffictypediagnostic: BYAPR15MB2326:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB23268812104826A0221F7418ABC30@BYAPR15MB2326.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /RYn/fpD2XaV7Wt43MgxW9X5+tIBCb5G74/swMgFJSlvZ93aBoWE77yC5yP7fpXa/N5N74H2lSxGQsYjw6HLgbOnadLbXp6ziLTvidoIMMT+A092ygADQSs5JSlAkvFdies8nP81Ksogp5Py+fhS+7stF23hb90N7bOwIaKw3eIyyn9EjeCB1P4jkgltbIqewxO+MKrlge4FFiUbVyN9qAOcn2jJnAlz2BO6lz5Wcenh0+HEF60geRdijh4GHrnAIjq4V/5x7Bg6kVXL2xKiSzSNEDe0box4ItMNAtKkBoPiuMDtm32ClVMXzcp+ay21ZolbTYD3me0ej5fus6AZB3ZbT04d5b4g3ZpNKU4oE6zSqPRCd8wfg3N7lJk3cliSJy8Mm9b0BgcTr68YNd2owA9p72hmHYw78rhsYFa8aeKIL4ZMgxgpFpOrHdDaTCIm2VcewSNqrBzskhLZOt6q7A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3667.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(346002)(396003)(39860400002)(136003)(66574015)(966005)(66556008)(6506007)(7416002)(6916009)(8936002)(33656002)(53546011)(2906002)(316002)(478600001)(66446008)(186003)(71200400001)(4326008)(36756003)(66476007)(5660300002)(76116006)(2616005)(6512007)(6486002)(86362001)(26005)(15650500001)(54906003)(64756008)(66946007)(83380400001)(8676002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?K2w2VWhjcDY1Q2dzSm1SVnQ5cmFvaUFPTWVnVUlFSGpaZ1VFTVdOajVHY3Jo?=
 =?utf-8?B?cVM4ZlBzQ3VlUnZIMU9WcGJmdE91TmFRb2xpZUtwMjROUVVjalhEQnhvbTZT?=
 =?utf-8?B?RWNxTzUwNnRNOFlGdTBKZFE2ZHpLcno5WmpHdEpDaEtTM096QUV0TnY3KzRz?=
 =?utf-8?B?Zms4bDZudDdEQVFpVUVnU1dOYTRrR2xkTXdtcjFlVklWMnpNTEJJN0pSY3A0?=
 =?utf-8?B?RVpHbWVRWWN2WEZyUW1Md1llbVpqVlJSQW1Qb0ZTeWRJWHg3NDJvU1g1eEdP?=
 =?utf-8?B?TmFBWFQ3YVlLWENwVjhadTFTcm9YNEdteFRoanQvOXdGTjJDNzA1QXBOSW9M?=
 =?utf-8?B?MHBsd3hyazhrOENHTlF0aXhtL0JpeVA5QWtmb25tcWRpSnFITWtKS2tlOVpG?=
 =?utf-8?B?ajVtVHp3YnZRME1zMkE5c0p0T3ZySzIzdDlZOG9CWEpVRTY5MXcrQjJudnE5?=
 =?utf-8?B?V3J5eWE3R2gralVISTV4VVVpeFBCYTNaV3Y0KzB0dDVYVGJsQWxDbnVsRXEy?=
 =?utf-8?B?OHN3TjB3RjdtZ2d4bHZLSG9YUnFPUTkwNEd6TVZQMi9obWhXcmJlK0ZuM3Fp?=
 =?utf-8?B?SDh6SU9HeHFQQmU2NW03VzZxOStSeDVBVFNTY1l1dkhZZDNqSVF4N0Y4bXR3?=
 =?utf-8?B?NnRDL09HR1MxcElQSlNMWU9Vamd3S3daS2lhQUtncWZmakVKTHlBZGc1c3E5?=
 =?utf-8?B?U1plVkRwSWRYVlQxK084NGNDYVZJRjJUNTRDT1FyNWp2azUxcUdNQ3lXZFQr?=
 =?utf-8?B?MVBiSUNrckVzUStxeHdkWlFqMnlHMHBmRkhVOThaSGJuUHJIcU04NDdwOFYw?=
 =?utf-8?B?OHlnWEtCSFhoTXF0eU5JNUFjWUlwc1hHMEFFQmlXNGhqa1VUWDY4YmtIMVVh?=
 =?utf-8?B?ZEdMeGtHZ29QYlNnZU9nOU82cFdxSkJzdlVkK0dmZk9vaXMySzVSWTU2VUJW?=
 =?utf-8?B?YzJrSk5TMHhrakRkaXk0bzRTWkNNcEJtU3Y5ZDFEK2VEZ2FYSGJIUEd3anBH?=
 =?utf-8?B?OUNvYkJrRytaL2duTHoyWGgySllRWGZqVHB6ekE1WDlZNG1XT3lSWm1FRThF?=
 =?utf-8?B?ZXpDZlFKb1dONHVHZVhtaktlUXAvdGdzYlpBUEdiMVk2NjRMSXRDbmVRYWVW?=
 =?utf-8?B?VHQrSk1uT1BMRzI5K0VrTWRKWHpqUHowOHlPV1BTdnN3MVpkOGw0OERNY0l0?=
 =?utf-8?B?UmRXNURJTFJGYXU4TjNmckMrckYzSnJxbFZxSUJUdE5Jb0NTNURSVU1ONXRC?=
 =?utf-8?B?Tjl4MGpkMWJGd2lhTU82MDBvNndnT2VFcEJxdnhwNktlSzh5YVFsckN2WGtZ?=
 =?utf-8?Q?WYseyTN6/L4FpLO8iaTDoscOBCKgxnDSvu?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <01A54C563A7B194F9912CB252C25CEB2@namprd15.prod.outlook.com>
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3667.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c76a7279-1503-4881-4370-08d8a386c4bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2020 18:57:29.2219
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WZs+TQwfaC8Jr8IwB1PFPfN0Dh7PaeQQW1k27yRjG8eqdNmot7FsOib5Dy1jExwY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2326
X-OriginatorOrg: fb.com
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-18_12:2020-12-18,2020-12-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 mlxlogscore=999 priorityscore=1501 phishscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 impostorscore=0 clxscore=1015 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012180128
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

DQoNCj4gT24gRGVjIDE2LCAyMDIwLCBhdCA1OjIzIFBNLCBNaWNoYcWCIE1pcm9zxYJhdyA8bWly
cS1saW51eEByZXJlLnFtcW0ucGw+IHdyb3RlOg0KPiANCj4gT24gV2VkLCBEZWMgMTYsIDIwMjAg
YXQgMTA6MDc6MzhQTSArMDAwMCwgTmljayBUZXJyZWxsIHdyb3RlOg0KPiBbLi4uXQ0KPj4gSXQg
aXMgdmVyeSBsYXJnZS4gSWYgaXQgaGVscHMsIGluIHRoZSBjb21taXQgbWVzc2FnZSBJ4oCZdmUg
cHJvdmlkZWQgdGhpcyBsaW5rIFswXSwNCj4+IHdoaWNoIHByb3ZpZGVzIHRoZSBkaWZmIGJldHdl
ZW4gdXBzdHJlYW0genN0ZCBhcy1pcyBhbmQgdGhlIGltcG9ydGVkIHpzdGQsDQo+PiB3aGljaCBo
YXMgYmVlbiBtb2RpZmllZCBieSB0aGUgYXV0b21hdGVkIHRvb2xpbmcgdG8gd29yayBpbiB0aGUg
a2VybmVsLg0KPj4gWzBdIGh0dHBzOi8vZ2l0aHViLmNvbS90ZXJyZWxsbi9saW51eC9jb21taXQv
YWMyZWU2NWRjYjczMThhZmU0MjZhZDA4ZjZhODQ0ZmFmM2FlYmI0MQ0KPiANCj4gSSBsb29rcyBs
aWtlIHlvdSBjb3VsZCByZW1vdmUgYSBiaXQgbW9yZSBkZWFkIGNvZGUgYnkgbm90aW5nIF9fR05V
Q19fID49IDQNCj4gKGdjYy00LjkgaXMgY3VycmVudGx5IHRoZSBvbGRlc3Qgc3VwcG9ydGVkIFsx
XSkuDQoNClllYWgsIHRoYXQgd291bGQgY2VydGFpbmx5IGJlIHBvc3NpYmxlLiBNeSBnb2FsIHdh
cyB0byByZW1vdmUgdGhlIG1vc3QgZWdyZWdpb3VzbHkNCmlycmVsZXZhbnQgY29kZSBmcm9tIHRo
ZSBrZXJuZWwsIGluIGFkZGl0aW9uIHRvIHVudXNlZCBmdW5jdGlvbnMgd2hpY2ggd291bGQgZ2Vu
ZXJhdGUNCi1XZnJhbWUtbGFyZ2VyLXRoYW4gY29tcGlsZXIgd2FybmluZ3MuIE15IHRvb2xpbmcg
ZG9lc27igJl0IGhhdmUgdGhlIGxvZ2ljIHRvIHJlYXNvbg0KYWJvdXQgPj0gcmVsYXRpb25zaGlw
cyB5ZXQuIElmIGl0IGlzbuKAmXQgdG9vIGhhcmQgdG8gYWRkLCBJIG1heSBnbyBhaGVhZCBhbmQg
ZG8gdGhhdCwNCm90aGVyd2lzZSBJIHdpbGwgbGVhdmUgaXQgZm9yIGZ1dHVyZSB3b3JrLiBJIHZp
ZXcgdGhhdCBhcyBhIOKAnG5pY2UgdG8gaGF2ZeKAnSBpbnN0ZWFkIG9mIGENCmhhcmQgcmVxdWly
ZW1lbnQsIHRob3VnaCBsZXQgbWUga25vdyBpZiB5b3UgZGlzYWdyZWUuDQoNCkJlc3QsDQpOaWNr
DQoNCj4gWzFdIERvY3VtZW50YXRpb24vcHJvY2Vzcy9jaGFuZ2VzLnJzdA0KPiANCj4gQmVzdCBS
ZWdhcmRzDQo+IE1pY2hhxYIgTWlyb3PFgmF3DQoNCg==
