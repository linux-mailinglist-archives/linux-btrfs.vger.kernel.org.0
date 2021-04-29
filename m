Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08B6236EE80
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Apr 2021 19:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240896AbhD2RBb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Apr 2021 13:01:31 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:27923 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S240801AbhD2RB3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Apr 2021 13:01:29 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 13TGxo6B030611;
        Thu, 29 Apr 2021 10:00:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=facebook;
 bh=UCVBF794A1M5Z+FtPZm/i5wg9xM31jvS2X5KReeIB7Y=;
 b=p9Vc1HQRp5RBfj5sX0562N0y1NkafN7KbkABzIijFlugc7WN+qghbahgDqYoNn58yrmn
 kzADR4wLiuoQfkQLSII5C+YY7UmK/etJzxkIHspK2KjjW2JD72CykFrCZvc8h8U42zM4
 mjREcpxCHub6ATJPIPb44LIRDdp/DHdYy7M= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 387xvygv52-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 29 Apr 2021 10:00:40 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 29 Apr 2021 10:00:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GfXImK5ohHscOIcLjGZXEpYsBY8Fa0RGFCQn6n/1w5mrnZdHuozmLPP7Y0y27rlovJ+AiZp6A8y9Ah7PfxePBYyP2ykFVjkwwn7dxZN7Q13gfh5j4Kmeu7MfRpew00GjdsFMQRdBue/3qLSZ9RtWk43a3abiUr+YtqwAo9k1B2XZNcw03rFA93bo7zfCUCbM1AHZFFi3Tjn0YgtAmWzqxEkpunThkknEScdWvSLTmDItHNqFLmRxtLVXkdc8i9auvGKbmfV3JOMw1lEU4kqSJhH+zQFJktSRpuHtPlhdEm/X7GSXocjFQRky+/5Rq2VPim3dh6FvWTVyznyzjB3MvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UCVBF794A1M5Z+FtPZm/i5wg9xM31jvS2X5KReeIB7Y=;
 b=bRpIse5gWss/Y1gvjrSBJoamA2sg6E9tMvcI/2FUsgtJEnxeMarrSFQseVw3KeEh9Rln3s/RBjsSzrZDtyCZ/xs1fOJ7M+OMgN1ZZLBQTio18Lx6N7AVAkPGow8h7UUj45Su6599UcBSoqawTjDcg/fsrdDTX/94VeRIfNLTX3TWyeAQHI/H1YFW5oVzV0PdYxVvrUvGmO0aIRt4tjSs2IQqOkxlS+cECF0/+FclrMu9ges8w709QWNsqUVuRbnco/rhaALs3I3fMA6oggxJdASZMPNPfey+bBY5sBnDJDXT9TJaXy5Up8QFbiDnIBNgGePyXz9969du+x/UkYZ0ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MN2PR15MB3327.namprd15.prod.outlook.com (2603:10b6:208:fd::28)
 by MN2PR15MB2542.namprd15.prod.outlook.com (2603:10b6:208:130::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.24; Thu, 29 Apr
 2021 17:00:35 +0000
Received: from MN2PR15MB3327.namprd15.prod.outlook.com
 ([fe80::bc9e:cd5b:886b:190c]) by MN2PR15MB3327.namprd15.prod.outlook.com
 ([fe80::bc9e:cd5b:886b:190c%7]) with mapi id 15.20.4087.025; Thu, 29 Apr 2021
 17:00:35 +0000
From:   Rik van Riel <riel@fb.com>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>
Subject: Re: [PATCH] btrfs: avoid RCU stalls while running delayed iputs
Thread-Topic: [PATCH] btrfs: avoid RCU stalls while running delayed iputs
Thread-Index: AQHXPQcypIQqyHLFkUOYLFeZWAJquKrLuEgA
Date:   Thu, 29 Apr 2021 17:00:35 +0000
Message-ID: <b806221a442fe754d48810253b4d289080cefc97.camel@fb.com>
References: <c979946e8341274a0a45cfe9166cf6e4bea25a3e.1619707886.git.josef@toxicpanda.com>
In-Reply-To: <c979946e8341274a0a45cfe9166cf6e4bea25a3e.1619707886.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c091:480::1:b112]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 08e19d1b-33e8-41d2-5bc1-08d90b304ea3
x-ms-traffictypediagnostic: MN2PR15MB2542:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR15MB2542BE0676F21D32DB7038EDA35F9@MN2PR15MB2542.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mUXdIelmLZ9bEvzzulsruEFx+6ZwCjQMUcH5EEedkCNnGF5R7jG5Ow3xdMHWyeORVUF5GHu7IiFhUEvtAG+Hb7q8chZbeb6ymc+1l0uXooGqUQA+aNWo6yQTpgRznOYCat4gvNzeaesU6vzZOe73fqEavDZfdoWQsx9xN5+HEqv82bvGDQtQH37MlkCyEx8MLL5VvJzNK4LZhThEZJm77PZwHvF3KeWixS6KLVZoeOFOwnBeLdxiMh4Zk+E6KBFlbGX1mrLwF0NB1l20EQg+vegM7iY/k4Ksq5G0rjSvMV/hUpVY3XJjx/wO3ia/hsC+c1N9x1Hm8jGi2ZLhK+yowgGHLMKbq28XyWHQmVayQseqhvEhdyn0Zt7uZobeDv3x44S4ipq9WWy5NKRfay+fqLzm9JoU5bEcozF30b+TNJGHa81gzwf67u4iW5BoyjlUhyizV7MLemFoR6j0KRAxYX7cZQ/MGwbkcOSAWS21Bda3KG6I/iz57Gez+4s6nTm/tvvA9MRKFYtb2RffZgTAhzvvmexEHd9hFX8YUyAoDDUau7X7uPAbEs6OWOhftRD7sY8Zqvt7wWAGAewN6T8woTthmOVlWKJBgo7CW9rNotM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR15MB3327.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(366004)(396003)(39860400002)(76116006)(110136005)(83380400001)(66946007)(558084003)(6512007)(2906002)(122000001)(8676002)(66476007)(6486002)(2616005)(5660300002)(36756003)(66446008)(186003)(478600001)(8936002)(86362001)(66556008)(316002)(64756008)(38100700002)(6506007)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?T3NoVTRzU25QYnJxR2VIalUxYTFBdDNDakV0QklUV0o4VHk5ZXJDUk1uOXA0?=
 =?utf-8?B?b1gyckxRMG5zY3RtaU0rbTVhbVpYUyszeGVWVEJZNUJmbWFmaFg5aUFvK0xr?=
 =?utf-8?B?ME9mMkJnMFRlcU5QMWxhNW5DN25ZeXFKejFmRUNhd1ZTM0llWURHeE00Wm9U?=
 =?utf-8?B?QTVTRWMzS2NlQVNaZVc3OWJmWURMbktQOEViTFRTc0VFYitQY0tJT0FzUVhW?=
 =?utf-8?B?TitmRS83Wm5EcExlUnQ3Q1N1SkVnSjltRnZtVVdlbUhrSkk3ZTA5b2RNZmgy?=
 =?utf-8?B?MUZKK09kT3kxV20vQmhyRzcrZnVjYzJyZUZpazQ5Q1FQSTRuSTcyYXFKOERa?=
 =?utf-8?B?UkROd1hHT0tRZldPK1RvNmFFanhGYUhCSDBCSENnRzFodSt4eVlMNVYrYUNM?=
 =?utf-8?B?N2NSa3huY0k5eG9XNVV0SHB4SW16ODV4NDc0Vy9pR00rcWhTanRBcENraVZZ?=
 =?utf-8?B?MEpYWFVheENITndadTM4ZGd2dmxCNFQ4cThlY1lpWjdWR2gwL0NOWCtGcUcx?=
 =?utf-8?B?VkZwdVJPZXFaWmQ1M0h0cVEyMWVnQ0Rra205Tm5mS3QxZzJFdm1TeC9oa1dY?=
 =?utf-8?B?aHdCMWsrWTZ1aGNETmxiSzBVcjB1VDU1Um5mdDl5MzQ4ZlhJSjJuR2RIc1Vw?=
 =?utf-8?B?Mi95SmJxSjdqam45c09PRUNHKzdpbG1kMmdaUXNrRnp2akRqdk5VdHBYKzFX?=
 =?utf-8?B?bFBrTi9nSVpFUmRDOWgvV1VpOStWeWpGaW05VjdSdmJoM1NYeUtsMFN2YVd6?=
 =?utf-8?B?TWxtZlZQRkZUekNudFdKby83S1Rld2tSWm8zLzY5K3FNRWtQOHRVaFgvZW5y?=
 =?utf-8?B?L1dXa2FWaUEwSFpWSFNJT1hmSnJNSVQzZFpmN3orczhiWDFvQ1Uyd0I2TXR4?=
 =?utf-8?B?UTAwZTBBZ244TWhmcFEwT2tzRnNPQzRycHFGcGxyK0tMQ2hJNytjVDhGcTJs?=
 =?utf-8?B?bkZwMTlMMnBWeHN3RlBrK0g3UnN5ZnhZdGpQSkRiVlFqTHVJdUhaSkhGZXNk?=
 =?utf-8?B?K0Z5V0RqbnVDRXNGSzJCemR2WlpaaHZZQnZ0VGZYai80b09DY0ppamhTcTdI?=
 =?utf-8?B?aTN4anJYaGk5ZlNzSHBoNUVQa1dmdmd0RjBjcWt3d3Y2T2t6blBQQ0FPYjBl?=
 =?utf-8?B?RWhxMzkydDJSaFlDUFFtNXlhMk5PN3pzZHdXSXVMRGh5Y0c3alRlMjg3Y0NL?=
 =?utf-8?B?dU1PSXFpSkpxRHdObXRBckx0enh0NWk3Mzd1bWMzOWtwaklkVWN6RjJFenc4?=
 =?utf-8?B?QW1SSFpzaDhMTlRnS2svcFpPT3hCcHphN2VWK3lCYzRQcVNja2FNYnZXbTIr?=
 =?utf-8?B?TWJ2bXNFcGhaWWFCM2xNTmNWMjBLY2hsWHRsNWFpOHpVdDcydFY2WXBOSTNa?=
 =?utf-8?B?czFKODhWWW5wQ3VJZnFic2U5RTF5eW5BWkhQV3NMUGJpc09JNjFDYnRCV25n?=
 =?utf-8?B?dldLUVZYY21nQVV4Zy92N01qcTBQa0FuUmZxZFo2ZXRtb1Q2dGd1cnRWbEFM?=
 =?utf-8?B?bjdqYXNWV0E2YVVBVFNJR042V2dvTVdjcEtVRGxWQ2Q1UjV1THBDYnFVZERE?=
 =?utf-8?B?Zkx2aFJYNkZ2L00vM2NzMDRzdEVqL2U5b0MvZlJZVG9zQzh4Z3hoSGdFZUt2?=
 =?utf-8?B?RG14SUlXajh6WEQ5d1FkN3J4YjVqVnNiU2IwZzQ4cU8xTEF4ZDFDbnJJMm9I?=
 =?utf-8?B?UnF1K0tROEFyV2l4aDNxYVVwRDBZVCtiWkdhRVoyRmpVdmZhS2VTYWR2YndR?=
 =?utf-8?B?aWFGVE1xVXBDSFlZV2s5MkpUYjMwVndra1QzdWtUUnFOSHJZaGVvSUowbjNm?=
 =?utf-8?Q?bnKQlXUejCowNWcM0cHXK2+NalXrfYpq7ntVE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <51EDEA1B9E734F4F9E9CF9DD92536BEF@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR15MB3327.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08e19d1b-33e8-41d2-5bc1-08d90b304ea3
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2021 17:00:35.3661
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GHg8EJ803Fw1H06b23bi7J0JNYqw71mN8n00j6NgUkWv4dUEWk1FddntzNZ9qmgp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB2542
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: BMcyAjGRrVB_xBRbtGoQ1Hrm287KcOuS
X-Proofpoint-ORIG-GUID: BMcyAjGRrVB_xBRbtGoQ1Hrm287KcOuS
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-29_08:2021-04-28,2021-04-29 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 mlxlogscore=891 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1011 spamscore=0 phishscore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104290106
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gVGh1LCAyMDIxLTA0LTI5IGF0IDEwOjUxIC0wNDAwLCBKb3NlZiBCYWNpayB3cm90ZToNCj4g
DQo+IEZpeCB0aGlzIGJ5IGFkZGluZyBhIGNvbmRfcmVzY2hlZF9sb2NrKCkgdG8gdGhlIGxvb3Ag
cHJvY2Vzc2luZw0KPiBkZWxheWVkDQo+IGlwdXRzIHNvIHdlIGNhbiBhdm9pZCB0aGVzZSBzb3J0
IG9mIHN0YWxscy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEpvc2VmIEJhY2lrIDxqb3NlZkB0b3hp
Y3BhbmRhLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IFJpayB2YW4gUmllbCA8cmllbEBzdXJyaWVsLmNv
bT4NCg==
