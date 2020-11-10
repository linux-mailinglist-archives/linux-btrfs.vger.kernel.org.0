Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 950EA2AE0D1
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Nov 2020 21:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbgKJUjQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Nov 2020 15:39:16 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:15198 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726737AbgKJUjQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Nov 2020 15:39:16 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AAKZsm4021696;
        Tue, 10 Nov 2020 12:38:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=abIN99u+g1+1XMOZSDRGO8skLAvjUwumOSOBu7nn5v8=;
 b=Pbr9O14nG+ldxoEKJIBb/LHD9doXIoWXbf6w+8a6yj0OId3rEDtIP/OYOB5jYMULcsrX
 NfvIL/xCGBISbDd8f/FN2xS+/tXniHkFimtmeboHV6NL1OVOXzla9wJVULyAvnwbOel8
 VCMda0Y3xkY3Sojr3VRTtRoIsC7Tk7Swm9Y= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 34pbxxn1yb-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 10 Nov 2020 12:38:42 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 10 Nov 2020 12:38:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uusk/F7OSadsxRyStEz6LxDWOv7YTPH0h6iyg2LCVmIx3d1EfCy0glI6RMGUzzREV68tl72F8qfTnbaB15ZL+W6g3E+yhbOHanPnSs33gFmjytRqyuMw/CeNIe5GHbM9B8HxZVf/AO4yZ/QTo0b1Vngn2zOPfkowJ+uTiqfPFC2LSHGI9zuvMwUtQZyYLkfFBpcCejqZhycD+inHDC4iCpvwteIL4hvYcbVcWpvWdkiZEf9Q5b9Yso/T6TURKnrBnvD4sP8eZR8np5wSCvu6ZsVwM3eyR/04kEbb0DxfJoe71xMGVNzdx+6m/3VOzWjicK68SmJTWw2HNGzHxoTNNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=abIN99u+g1+1XMOZSDRGO8skLAvjUwumOSOBu7nn5v8=;
 b=oemGIPuzAISsbpPRewu2MH9RSg/Ff7F+nFZFcQ95qygT7hieOUEWes66zy0te1sU9VPRVIU7Dn110rTAvTVqijcu0kLnv1eaX/EnkY941UBDoWciX9/9yL3vpFMAjEbVZ4ZCmxNu7tATzUqrtFYw7MV5WQabtsxJ3jH+ovaLKqGIVtfAiXEOTvlUFdojLxxQuCmP+W69BZ64ZSVZeUYrM89B8kY90Sesnc5UezddiCg1I5xrHfLKB6pmj2QQKwWhkHZV0/rA2gS1PVKZuHQB6Nh8hZQ9tH4+LOcbjopt7HUh67pJ1+yGx0qRwmagAFLWA75yKVPpvw02PmkT4U9jqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=abIN99u+g1+1XMOZSDRGO8skLAvjUwumOSOBu7nn5v8=;
 b=j1loluWiwfOariWfgjdcuCmB7uszlRmP5c1faCVV2OSDwgRItRZ5Zd+aNNtaXv0konblWz1erY57jAcMOQ9nxfts7AdKpsMYGGdhf9i8RpLA6CnrcnjHAUw9RwxOXG+eYzHkFNzUaAL2ojs3MUUESSUE1q1uY6sXQsLOfqwKL2E=
Received: from BY5PR15MB3667.namprd15.prod.outlook.com (2603:10b6:a03:1f9::18)
 by BY5PR15MB3570.namprd15.prod.outlook.com (2603:10b6:a03:1f9::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.22; Tue, 10 Nov
 2020 20:38:34 +0000
Received: from BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::17e:aa61:eb50:290c]) by BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::17e:aa61:eb50:290c%7]) with mapi id 15.20.3541.025; Tue, 10 Nov 2020
 20:38:34 +0000
From:   Nick Terrell <terrelln@fb.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     Chris Mason <clm@fb.com>, Nick Terrell <nickrterrell@gmail.com>,
        "Herbert Xu" <herbert@gondor.apana.org.au>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "squashfs-devel@lists.sourceforge.net" 
        <squashfs-devel@lists.sourceforge.net>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>, Petr Malat <oss@malat.biz>,
        Johannes Weiner <jweiner@fb.com>,
        Niket Agarwal <niketa@fb.com>, Yann Collet <cyan@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5 1/9] lib: zstd: Add zstd compatibility wrapper
Thread-Topic: [PATCH v5 1/9] lib: zstd: Add zstd compatibility wrapper
Thread-Index: AQHWsabb1Jdg9cQzfUKQ7VkOPnEyX6m7dNAAgAS9ZoCAAYw+gIAAISeA
Date:   Tue, 10 Nov 2020 20:38:33 +0000
Message-ID: <812F138F-FB74-447C-86FB-5179E128078D@fb.com>
References: <20201103060535.8460-1-nickrterrell@gmail.com>
 <20201103060535.8460-2-nickrterrell@gmail.com>
 <20201106183846.GA28005@infradead.org>
 <D9338FE4-1518-4C7B-8C23-DBDC542DAC35@fb.com>
 <20201110183953.GA10656@infradead.org>
In-Reply-To: <20201110183953.GA10656@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:7f29]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dfeda2b1-49a9-49af-439e-08d885b897df
x-ms-traffictypediagnostic: BY5PR15MB3570:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR15MB3570946001E9186571F12DAEABE90@BY5PR15MB3570.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AnA2xDG26DKJwse1yqzRKr66uclJ+tYxXXUAaX17Ukv3+tj+2VVujmtyDOWiVxsZ4Mm1/uYRIsWdyJ/+C8fk1R67YK1O0wZ/oeOJolSY7anBidNMExdNsPufjvjNiSbrf1APNj2I/XdS+eQX1EOQgb3N/yEaM5+PdSyZZsl0gkZklWADoCiS8UaiOUaB6XxqCrI2sGMQvIUBOjNA2lxt7NsE66BjBJvr6y+GxRyQSsDrJ5mbUu9ul3QTlxlzkvrs8sKTdnZjpTtJ+ohLLCjXXG1vVdYjqahn6I+dWvrC6dmB6HGZcayuEx7JNICanqHm5PGHqK0gubO7ek9ODe43Yw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3667.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(39860400002)(366004)(396003)(346002)(83380400001)(8676002)(71200400001)(54906003)(7416002)(316002)(6486002)(186003)(6916009)(8936002)(4326008)(53546011)(6506007)(33656002)(6512007)(2906002)(2616005)(76116006)(91956017)(5660300002)(66556008)(64756008)(66446008)(36756003)(478600001)(66476007)(86362001)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: xER37zgztKERZYTjH69dz2G3E0KSXertOvYTOWk9mwvzhKBCL6RU+VTf75TZaIx2f/Jkyw9cdgm2T5Xo0DDQdMbOiRyf8c+7zN3loHW3IMzEX7kUyRMj+G41EGwYDT61uToM5p0EnbbvvlxmQ6OVnZNfW4wzUjOCBy65QjDi8IBtNRcEbENxcPyqCRs/1oq3BWw+Gqrf8wj/gT9XkDDf7YDXAcfftFZrQltPvi/c0SksqRHnWotHV5bhqxa6QQQi6T2i/nixRk6vC6WC7hKZN1pAwZu+BJIshrhlIF9gKPvqkvc7tJfJnmLBeMY/uSs+afRl2IVQNydB2qlUX7oT81O/C6KdSYw7Gxc8tpHIx120yb5gc8dOvKoIIolP8dE6mTEz0Dc3lS3VEQKRQEiYdkbBKKPs0GA5bg/IXE2nKgaD4o5MsW91JyRLykM0V9aEWJtjOCrq70SgYvLtGpCbldivyme071xNViko+7SOyky+qiH7Hl8fxqevLx3QSIljWJVnNhycX7aJ5E2UGX/fQfBSeUFSGD1jkPewTc+Yax+US9XIsXlbkAGuT2y+jECDUGqGbXI0uLCB+9vyWwLR57obbxkwnqPIDfajSSXjAf4/avAW8IzbfyFew8oHHBWgwuBv+KSsGG4wga9IbbOOc/lxUhMwpscMUaLVtQK8pO5J0pibg0E6cMdyJNk1hufM
Content-Type: text/plain; charset="utf-8"
Content-ID: <BD430BE41FA88F48A3D3FCAC0A64BA9E@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3667.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfeda2b1-49a9-49af-439e-08d885b897df
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2020 20:38:33.8924
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DWZkKjz/nEGqcxOR4y82keTBk/1joPHSWBLvgkTicH9DF9TAnS85z4EbFWYDO+jE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3570
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-10_07:2020-11-10,2020-11-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 impostorscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 mlxscore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011100139
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

DQoNCj4gT24gTm92IDEwLCAyMDIwLCBhdCAxMDozOSBBTSwgQ2hyaXN0b3BoIEhlbGx3aWcgPGhj
aEBpbmZyYWRlYWQub3JnPiB3cm90ZToNCj4gDQo+IE9uIE1vbiwgTm92IDA5LCAyMDIwIGF0IDAy
OjAxOjQxUE0gLTA1MDAsIENocmlzIE1hc29uIHdyb3RlOg0KPj4gWW91IGRvIGNvbnNpc3RlbnRs
eSBhc2sgZm9yIGEgc2hpbSBsYXllciwgYnV0IHlvdSBoYXZlbj8/P3QgZXhwbGFpbmVkIHdoYXQN
Cj4+IHdlIGdhaW4gYnkgZGl2ZXJnaW5nIGZyb20gdGhlIGRvY3VtZW50ZWQgYW5kIHRlc3RlZCBB
UEkgb2YgdGhlIHVwc3RyZWFtIHpzdGQNCj4+IHByb2plY3QuICBJdD8/P3MgYW4gaW1wb3J0YW50
IGRpc2N1c3Npb24gZ2l2ZW4gdGhhdCB3ZSBob3BlIHRvIHJlZ3VsYXJseQ0KPj4gdXBkYXRlIHRo
ZSBrZXJuZWwgc2lkZSBhcyB0aGV5IG1ha2UgaW1wcm92ZW1lbnRzIGluIHpzdGQuDQo+IA0KPiBB
biBBUEkgdGhhdCBsb29rcyBsaWtlIGV2ZXJ5IG90aGVyIGtlcm5lbCBBUEksIGFuZCBkb2Vzbid0
IGNhdXNlIGVuZGxlc3MNCj4gYW1vdW50IG9mIGNodXJuIGJlY2F1c2Ugc29tZW9uZSBkZWNpZGVk
IHRoZXkgbmVlZCBhIG5ldyBBUEkgZmxhdm9yIG9mDQo+IHRoZSBkYXkuICBCdHcsIEknbSBub3Qg
YXNraW5nIGZvciBhIHNoaW0gbGF5ZXIgLSB0aGF0IHdhcyB0aGUgY29tcHJvbWlzZQ0KPiB3ZSBl
bmRlZCB1cCB3aXRoLg0KDQpJIHdpbGwgcHV0IHVwIGEgdmVyc2lvbiBvZiB0aGUgcGF0Y2ggc2V0
IHdpdGggdGhlIHNoaW0gbGF5ZXIuIEkgd2lsbCBmb2xsb3cgdGhlDQprZXJuZWwgc3R5bGUgZ3Vp
ZGUgZm9yIHRoZSBzaGltLCB3aGljaCB3aWxsIGludm9sdmUgZnVuY3Rpb24gcmVuYW1pbmcuIEkg
d2lsbA0KcHJlZml4IHRoZSBmdW5jdGlvbnMgd2l0aCDigJx6c3RkX+KAnSBpbnN0ZWFkIG9mIOKA
nFpTVERf4oCdIHRvIG1ha2UgaXQgY2xlYXIgdGhhdA0KdGhpcyBpcyBub3QgdGhlIHVwc3RyZWFt
IHpzdGQgQVBJLCBidXQgcmF0aGVyIGEga2VybmVsIHdyYXBwZXIgKGFuZCBiZSBjbG9zZXINCnRv
IHRoZSBzdHlsZSBndWlkZSkuDQoNCk90aGVyIHRoYW4gcmVuYW1pbmcgdG8gZm9sbG93IHRoZSBr
ZXJuZWwgc3R5bGUgZ3VpZGUsIEkgd2lsbCBrZWVwIHRoZSBBUEkgYXMNCnNpbWlsYXIgYXMgcG9z
c2libGUgdG8gdGhlIGV4aXN0aW5nIEFQSSwgdG8gbWluaW1pemUgY2h1cm4uDQoNClBsZWFzZSBs
ZXQgbWUga25vdyBpZiB5b3UgaGF2ZSBhbnkgcGFydGljdWxhciByZXF1ZXN0cyBmb3IgdGhlIHNo
aW0gdGhhdCBJDQpoYXZlbid0IG1lbnRpb25lZCwgb3IgaWYgeW91IHdvdWxkIHByZWZlciBzb21l
dGhpbmcgZWxzZS4gQWx0ZXJuYXRpdmVseSwgDQpjb21tZW50IG9uIHRoZSBwYXRjaGVzIG9uY2Ug
SSBwdXQgdGhlbSB1cC4gRXhwZWN0IHRoZW0gbGF0ZXIgdGhpcyB3ZWVrDQpvciB3ZWVrZW5kLg0K
DQpCZXN0LA0KTmljaw0KDQo+IElmIHpzdGQgZm9sa3MgY2FuJ3QgbWFpbnRhaW4gYSBzYW5lIGNv
ZGUgYmFzZSBtYXliZSB3ZSBzaG91bGQganVzdCBkcm9wDQo+IHRoaXMgY2hpbGRpc2ggY2h1cm5p
bmcgY29kZSBiYXNlIGZyb20gdGhlIHRyZWUuDQoNCg==
