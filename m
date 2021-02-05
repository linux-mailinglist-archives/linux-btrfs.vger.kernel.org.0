Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1CB4311053
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Feb 2021 19:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbhBERHm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Feb 2021 12:07:42 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:34728 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229611AbhBEQc4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 5 Feb 2021 11:32:56 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 115IDF2P030096;
        Fri, 5 Feb 2021 10:14:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=lJIPyQxud8AFJj6BL+Ox24faXeYxC6UD6uYCyZPr7hw=;
 b=ELdTJXpqg94bNS9QjEMqWzCcYC08gTFeYJa6A/6NJ7sr0VwwQe2bWXqcEakCh8ci1+US
 a8ODGoE5O8iLLQu8xQNt7W256QC2dpTJcqo3Ar5GJCpUjsF1/t7ez6f3u0IgzAEgLz0a
 YxImc55tl7a4OjvhqNbInUw/q+Q/vCbAOM0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 36h0s02wwc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 05 Feb 2021 10:14:34 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 5 Feb 2021 10:14:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c1dkP8CUYgAY/061aTrh1RtsTb0VRxheLJv2PfbFP6iX06WzJTbnFy2pvvhMWtD0QTCkUDwKSgrpiZEUNfYT43LaqjyqdscXq0wTqKNvhdW2++MpcMp/Ad1eV0Qb+DE4pbqNV19rG2ARsGB2OeSYlRW3TRAlRBSSQ3Ivigwf6BOE2YN5JbH5yHTNc0jacouNnRGitlM5oDilVyYO3Yv/auxXtxOYNICToqy9MspDwnNHc4nV+48PsjW0zUqEgDQzGPcYakrES+SgVjgGnxzYzpB4YhRQ4SSk0/EVIXRudwJnIRm3yW1U0SQaHuutP5yfhJLPDwD4jW5vYnWwAC1kSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJIPyQxud8AFJj6BL+Ox24faXeYxC6UD6uYCyZPr7hw=;
 b=kV8m6PdmIPLHNvsPOmmWnv97xEvX3R2Bnhlagapmcai3ChOcUM8SiW0JpZvns9Lr85jMfw3rYH0dg0rrmPnVa+lSJTEw/PffYU+PmuBMxpcCV33vbig8+ZGtcegFeaxkYOail+A814VmGFxijzzDvvwRk+Dg9C41HNqpPRw8KpZQhIYC4aBlhWRfKbnTqowROPlymQr1lGX9qU9UERQYCaKH+Dsk7HPJeEMJZo7qyMcY3cSydlQSQPQi+StLPIgCh62xWyofEijXBPXLgu3Mt4tpi8DE7dOHEz+ai+mI9Cw1T+y0TN8d1lH0RaOOsIwMNozQIu7inQ07jbwhIu8N7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJIPyQxud8AFJj6BL+Ox24faXeYxC6UD6uYCyZPr7hw=;
 b=HaJl6tZA+CWIymjHuuApg/Ku7sF3Fy+OEBXEeeQledD6vERf3IJ/SDuB44JcjMZwX6wSfZcKzuLictgMhkxJnSAyA65La4oq7gNZZP+gFHYv/g1FpUsfQ8E7w2JjHZMJ0tzMMnHZSMKgZUg653HTqqHXiHRw5z7X7Dn/kBzbRgU=
Received: from SA0PR15MB3839.namprd15.prod.outlook.com (2603:10b6:806:83::14)
 by SN6PR1501MB2015.namprd15.prod.outlook.com (2603:10b6:805:7::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Fri, 5 Feb
 2021 18:14:32 +0000
Received: from SA0PR15MB3839.namprd15.prod.outlook.com
 ([fe80::6122:2d99:88bf:9ec2]) by SA0PR15MB3839.namprd15.prod.outlook.com
 ([fe80::6122:2d99:88bf:9ec2%5]) with mapi id 15.20.3825.023; Fri, 5 Feb 2021
 18:14:32 +0000
From:   Chris Mason <clm@fb.com>
To:     Eric Biggers <ebiggers@kernel.org>
CC:     Boris Burkov <boris@bur.io>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH 2/5] btrfs: initial fsverity support
Thread-Topic: [PATCH 2/5] btrfs: initial fsverity support
Thread-Index: AQHW+0yOUU+g4fmaSU+Z5J8S4J1M26pJHLEAgADCNYA=
Date:   Fri, 5 Feb 2021 18:14:32 +0000
Message-ID: <232BA45D-BC4A-4213-945F-B3B60D884143@fb.com>
References: <cover.1612475783.git.boris@bur.io>
 <88389022bd9f264f215c9d85fe48214190402fd6.1612475783.git.boris@bur.io>
 <YBzoHniIpslKZtbp@sol.localdomain>
In-Reply-To: <YBzoHniIpslKZtbp@sol.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c091:480::1:a667]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 823daa38-7368-4fc6-f18d-08d8ca01e2ff
x-ms-traffictypediagnostic: SN6PR1501MB2015:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR1501MB20152785AEE9E1FDC15F5F1CD3B29@SN6PR1501MB2015.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vf2wV71LZnbQYBJc0iAuliZcO2aixUC0vyv0ocsJooNEd3G3kLJzf+DBD1ZW7JPi2irml1YqoxoHAFPrDrNCPr1wOrWoYLEsQdk64fHtulX/aXaoffkI2kXBwM/9+wmc+EuVkc8hmM2XKRrbkQeIW78fJQ492PA9gjDaDfoDgt5YmebKfbhdaK5VgVOHLmEjArJQh9Dl5Aplm6srMkObYLS65NmzwZispxDHd0YCYZYh7YCGAqPawvOnx5MWfkS3pl/PqReaiYV1sMuXsIphhKfQIV+o5gLhAgDG3xW5592IFeOCJgPTmHGlqSqP0/ejh6h6PKkhFi9/WvAGgFiss8cZ0we2ETNjnTpDZkxhKQ5xihaniEgPYiLb+Mjgumq8udR2Nbp7GB0vtUaAayMkWc3wpXUf+dU4SpJxL9M1YOgDCptuw42V7En22Uujd/OGXvJxO4VGcnOtps06ScJ0epdFKhaH/OKkm88yRBhAkTAP7g2nuBwsUjxW18Z/k3mPzbNrymfRUsF4qvaepWqY+JjZqIN5qkOrxnWseW4ijUncAfHsMmtGBsE7jVP03cbfYxQotdylPKZqPDSDRmh2ww==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR15MB3839.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(366004)(39860400002)(136003)(346002)(66946007)(36756003)(478600001)(186003)(91956017)(8676002)(64756008)(6486002)(53546011)(6512007)(66446008)(2906002)(66556008)(76116006)(6916009)(33656002)(2616005)(54906003)(5660300002)(316002)(83380400001)(71200400001)(66476007)(86362001)(8936002)(4326008)(6506007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?MEV4UjZvMTJkR0NLWGh6a1JDOEJyMXRNSGU1Mmg5N0NuQXp0WDVGdmVzWGhS?=
 =?utf-8?B?QTJia28vRDZEYlJOdlRHR0FRWFU0VEl0RHdwMVU2TmNpeTU2QmlkMVRjQlph?=
 =?utf-8?B?L1JuSXJCSjk1MHhSVFdqVmlVZUkyWWEzcllXOW41eVg1NUFBTVgrR1V2b1g4?=
 =?utf-8?B?R0IvQVd3QnhCTk03K1lueE5mdzZoTm1sVVNlQVRZOHVDUjJnOGJXMzlqSG1K?=
 =?utf-8?B?cWdXOXFTbDF3Q2hVclBVU0VpYXZXY2lNZkw1YTA0WExHakZlSzFyS1Voa1Q1?=
 =?utf-8?B?WURoYlJHaVlBMjBaSkRlRmNwQWNZSDZ0NE1CWnBjdHMxc3ZqMHdmL0hYWjVz?=
 =?utf-8?B?RVN3V3B6TVcra2xRYkhwOU1MdzRWQ1hBUG5KZWtkTFAzbzQvU3JQTVNkL2RM?=
 =?utf-8?B?UVJsUW15YlZaQmFhdC9MWTFuY1NKeEdkeUo0bzZmM3dTVzhVZThrWis5MFdQ?=
 =?utf-8?B?eDBXeEhyd05jYWl1WjVoSWRkeTBlUmJTb3RRZ201dWJBUVJKaDNYOUZqZ2Zx?=
 =?utf-8?B?NVp1a3ZQS2htVS83TEZGYzhHKzZsaFhGMkhLTVlaTDUyY0xZbGVsVFVEb2xQ?=
 =?utf-8?B?TEtsUWlmYzhZMmtOU1JkZXNpMnE2dDZBUm90eTBmdkNROUp3RHFLVkxyYUJI?=
 =?utf-8?B?VnVkL0N3QlJRQUhOS2hUdFFOUE5CdU1FT2pEQkkwQzhQYWpVTitzZHJoNGow?=
 =?utf-8?B?L0d6Z3dMaEVvc3JMQUhUTXJWeFBuRzFhSDRrLzNhRnN6bUpxK2RuZm5VWWZ4?=
 =?utf-8?B?cHphMmVwR1BWaHpqU201YXA3TFlmdHhPOWloQWxKRGxzNWkrdXc1K05HY3V0?=
 =?utf-8?B?Z081Y2JxRE94MWRqWTMyM2ZiUFVuZUZvTy8yQnpTcmtBRnBEKysrdDdkNnYr?=
 =?utf-8?B?YmF6RU1oS2tiRXI0MEN6TGRmbGkrb0FTRkZiRGp5QW9TeTdVQUVGdTJoSkZO?=
 =?utf-8?B?WVg4T3FTVDZpNlNSK0p5dG54VTh6b04wMHlicjZUd2xFcmx0dlFFbnNXRTFj?=
 =?utf-8?B?dFl1bUFZUjN0eGFUd3ljZ0RsRFN2eDdjeEZnUEhldWlmaER2amc5cXp3R24z?=
 =?utf-8?B?a0xWU2R4ZHVoTHZKREJBNnhOOGtuU3pYV3FMVTVBSlc1U0NIYTlTenlxRkF5?=
 =?utf-8?B?T1pRaXJyWmplNEtzL3gybXpMMHZ4cnloMUUvWnM2S010anI2R0Rkbng4U1F4?=
 =?utf-8?B?K1JSdUVRaUFNRGF2akhwZTdjdUlKNVNlamFmbHBzY3hhY2JNa2xXWEdqTzNh?=
 =?utf-8?B?RlVrdk5BMVRCbDFuekJVakxJZkhXVW45QStDQ2FiQk1mc1ZLc3YvRTdIL1JY?=
 =?utf-8?B?R0ozRWZENVlMSWp5bFp5RG45VFIxY1RnM2tGMTltVUIydktGbE1GbmJSSHoy?=
 =?utf-8?B?ak8xakhGNUd6MStlUWs2YytrcDdyRTVSK0RXTkc2RTZteVNNcmlKcTdXa2RT?=
 =?utf-8?B?cHpsRFRzWlRYZWQzbi9IcHpqWUtmdDdiSk1iTlByUTNDSzVDU1VtbHhDamtG?=
 =?utf-8?B?ci9sejVCUzFGYUVRUDBSZGtzK2ZIa0pwZ2x2WmYvcFNmeVNZRzREL09XdVZn?=
 =?utf-8?B?TTRKcC9TRFhyd1RWdWMvRTVYb2xSODZZdW9LMXJDa3REbVVLb1R6TDFiNnk0?=
 =?utf-8?B?S203VjdKY1VlV0VuRGRoQm4yb0NnY05mMVBnZW1jUmlyTnBDdWduN3NvWDJ3?=
 =?utf-8?B?R01Ubm9QbGIzamcxV3FLZzJrSHdiVWNwbUVFNlZMTCt2UXhYSTdVb2ZsSit2?=
 =?utf-8?B?ZE1ucTJ5R0JJTzJram1oZ0JGOU9KMkxuNHBzb2hsdDRvVUhlaTI0N0tjSTV2?=
 =?utf-8?Q?o/eslhCT/a3irVSNWXEEB4YY9R3WHlRkqQYhM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DA8C4245DAA5CA46AC98328783C2C11D@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR15MB3839.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 823daa38-7368-4fc6-f18d-08d8ca01e2ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2021 18:14:32.4510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 211ZmRSDv0MAvCgmuDVfuJnPA668qtmi8Sfeho4lm4rVNdATlKnhkd4O/eqlhz7f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB2015
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-05_10:2021-02-05,2021-02-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 clxscore=1015 adultscore=0 bulkscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102050114
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

DQoNCj4gT24gRmViIDUsIDIwMjEsIGF0IDE6MzkgQU0sIEVyaWMgQmlnZ2VycyA8ZWJpZ2dlcnNA
a2VybmVsLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBUaHUsIEZlYiAwNCwgMjAyMSBhdCAwMzoyMToz
OFBNIC0wODAwLCBCb3JpcyBCdXJrb3Ygd3JvdGU6DQo+PiArLyoNCj4+ICsgKiBkcm9wIGFsbCB0
aGUgaXRlbXMgZm9yIHRoaXMgaW5vZGUgd2l0aCB0aGlzIGtleV90eXBlLiAgQmVmb3JlDQo+PiAr
ICogZG9pbmcgYSB2ZXJpdHkgZW5hYmxlIHdlIGNsZWFudXAgYW55IGV4aXN0aW5nIHZlcml0eSBp
dGVtcy4NCj4+ICsgKg0KPj4gKyAqIFRoaXMgaXMgYWxzbyB1c2VkIHRvIGNsZWFuIHVwIGlmIGEg
dmVyaXR5IGVuYWJsZSBmYWlsZWQgaGFsZiB3YXkNCj4+ICsgKiB0aHJvdWdoDQo+PiArICovDQo+
PiArc3RhdGljIGludCBkcm9wX3Zlcml0eV9pdGVtcyhzdHJ1Y3QgYnRyZnNfaW5vZGUgKmlub2Rl
LCB1OCBrZXlfdHlwZSkNCj4gDQo+IEkgYXNzdW1lIHlvdSBjaGVja2VkIHdoZXRoZXIgdGhlcmUn
cyBhbHJlYWR5IGNvZGUgaW4gYnRyZnMgdGhhdCBkb2VzIHRoaXM/DQoNCk5pa29sYXkgY29ycmVj
dGx5IGNhbGxlZCBvdXQgYnRyZnNfdHJ1bmNhdGVfaW5vZGVfaXRlbXMoKSwgYnV0IEkgd2FudGVk
IHRvIGtlZXAgbXkgZmluZ2VycyBvdXQgb2YgdGhhdCBpbiB2MCBvZiB0aGUgcGF0Y2hlcy4NCg0K
PiAgVGhpcw0KPiBzZWVtcyBsaWtlIGEgZmFpcmx5IGdlbmVyaWMgdGhpbmcgdGhhdCBtaWdodCBi
ZSBuZWVkZWQgZWxzZXdoZXJlIGluIGJ0cmZzLg0KPiBTaW1pbGFybHkgZm9yIHdyaXRlX2tleV9i
eXRlcygpIGFuZCByZWFkX2tleV9ieXRlcygpLg0KPiANCg0KSXQgbWlnaHQgbWFrZSBzZW5zZSB0
byBtYWtlIHJlYWQvd3JpdGVfa2V5X2J5dGVzKCkgb3VyIGdlbmVyaWMgZnVuY3Rpb25zLCBidXQg
dW5sZXNzIEkgbWlzc2VkIHNvbWV0aGluZyBJIGRpZG7igJl0IHNlZSBncmVhdCBmaXRzLg0KDQo+
PiArLyoNCj4+ICsgKiBmc3Zlcml0eSBkb2VzIGEgdHdvIHBhc3Mgc2V0dXAgZm9yIHJlYWRpbmcg
dGhlIGRlc2NyaXB0b3IsIGluIHRoZSBmaXJzdCBwYXNzDQo+PiArICogaXQgY2FsbHMgd2l0aCBi
dWZfc2l6ZSA9IDAgdG8gcXVlcnkgdGhlIHNpemUgb2YgdGhlIGRlc2NyaXB0b3IsDQo+PiArICog
YW5kIHRoZW4gaW4gdGhlIHNlY29uZCBwYXNzIGl0IGFjdHVhbGx5IHJlYWRzIHRoZSBkZXNjcmlw
dG9yIG9mZg0KPj4gKyAqIGRpc2suDQo+PiArICovDQo+PiArc3RhdGljIGludCBidHJmc19nZXRf
dmVyaXR5X2Rlc2NyaXB0b3Ioc3RydWN0IGlub2RlICppbm9kZSwgdm9pZCAqYnVmLA0KPj4gKwkJ
CQkgICAgICAgc2l6ZV90IGJ1Zl9zaXplKQ0KPj4gK3sNCj4+ICsJc3NpemVfdCByZXQgPSAwOw0K
Pj4gKw0KPj4gKwlpZiAoIWJ1Zl9zaXplKSB7DQo+PiArCQlyZXR1cm4gcmVhZF9rZXlfYnl0ZXMo
QlRSRlNfSShpbm9kZSksDQo+PiArCQkJCSAgICAgQlRSRlNfVkVSSVRZX0RFU0NfSVRFTV9LRVks
DQo+PiArCQkJCSAgICAgMCwgTlVMTCwgKHU2NCktMSwgTlVMTCk7DQo+PiArCX0NCj4+ICsNCj4+
ICsJcmV0ID0gcmVhZF9rZXlfYnl0ZXMoQlRSRlNfSShpbm9kZSksDQo+PiArCQkJICAgICBCVFJG
U19WRVJJVFlfREVTQ19JVEVNX0tFWSwgMCwNCj4+ICsJCQkgICAgIGJ1ZiwgYnVmX3NpemUsIE5V
TEwpOw0KPj4gKwlpZiAocmV0IDwgMCkNCj4+ICsJCXJldHVybiByZXQ7DQo+PiArDQo+PiArCWlm
IChyZXQgIT0gYnVmX3NpemUpDQo+PiArCQlyZXR1cm4gLUVJTzsNCj4+ICsNCj4+ICsJcmV0dXJu
IGJ1Zl9zaXplOw0KPj4gK30NCj4gDQo+IFRoaXMgZG9lc24ndCByZXR1cm4gdGhlIHJpZ2h0IHZh
bHVlIHdoZW4gYnVmX3NpemUgIT0gMCAmJiBidWZfc2l6ZSAhPSBkZXNjX3NpemUuDQo+IEl0J3Mg
c3VwcG9zZWQgdG8gcmV0dXJuIHRoZSBhY3R1YWwgc2l6ZSBvciAtRVJBTkdFLCBsaWtlIGdldHhh
dHRyKCkgZG9lczsgc2VlDQo+IHRoZSBjb21tZW50IGFib3ZlIGZzdmVyaXR5X29wZXJhdGlvbnM6
OmdldF92ZXJpdHlfZGVzY3JpcHRvci4NCj4gDQo+IEl0IGRvZXNuJ3QgbWF0dGVyIG11Y2ggYmVj
YXVzZSB0aGF0IGNhc2UgZG9lc24ndCBoYXBwZW4gY3VycmVudGx5LCBidXQgaXQgd291bGQNCj4g
YmUgbmljZSB0byBrZWVwIHRoaW5ncyBjb25zaXN0ZW50Lg0KPiANCg0KRm9yZ290IGFsbCBhYm91
dCB0aGlzLCBidXQgSSB3YXMgZ29pbmcgdG8gc3VnZ2VzdCBvcHRpbWl6aW5nIHRoaXMgcGFydCBh
IGJpdCwgc2luY2UgYnRyZnMgaXMgZG9pbmcgYSB0cmVlIHNlYXJjaCBmb3IgZWFjaCBjYWxsLiAg
SeKAmWQgbG92ZSB0byBoYXZlIGEgd2F5IHRvIGRvIGl0IGluIG9uZSBzZWFyY2gtYWxsb2NhdGUt
Y29weSByb3VuZC4NCg0KPj4gKy8qDQo+PiArICogcmVhZHMgYW5kIGNhY2hlcyBhIG1lcmtsZSB0
cmVlIHBhZ2UuICBUaGVzZSBhcmUgc3RvcmVkIGluIHRoZSBidHJlZSwNCj4+ICsgKiBidXQgd2Ug
Y2FjaGUgdGhlbSBpbiB0aGUgaW5vZGUncyBhZGRyZXNzIHNwYWNlIGFmdGVyIEVPRi4NCj4+ICsg
Ki8NCj4+ICtzdGF0aWMgc3RydWN0IHBhZ2UgKmJ0cmZzX3JlYWRfbWVya2xlX3RyZWVfcGFnZShz
dHJ1Y3QgaW5vZGUgKmlub2RlLA0KPj4gKwkJCQkJICAgICAgIHBnb2ZmX3QgaW5kZXgsDQo+PiAr
CQkJCQkgICAgICAgdW5zaWduZWQgbG9uZyBudW1fcmFfcGFnZXMpDQo+PiArew0KPj4gKwlzdHJ1
Y3QgcGFnZSAqcDsNCj4+ICsJdTY0IHN0YXJ0ID0gaW5kZXggPDwgUEFHRV9TSElGVDsNCj4+ICsJ
dW5zaWduZWQgbG9uZyBtYXBwaW5nX2luZGV4Ow0KPj4gKwlzc2l6ZV90IHJldDsNCj4+ICsJaW50
IGVycjsNCj4+ICsNCj4+ICsJLyoNCj4+ICsJICogdGhlIGZpbGUgaXMgcmVhZG9ubHksIHNvIGlf
c2l6ZSBjYW4ndCBjaGFuZ2UgaGVyZS4gIFdlIGp1bXANCj4+ICsJICogc29tZSBwYWdlcyBwYXN0
IHRoZSBsYXN0IHBhZ2UgdG8gY2FjaGUgb3VyIG1lcmtsZXMuICBUaGUgZ29hbA0KPj4gKwkgKiBp
cyBqdXN0IHRvIGp1bXAgcGFzdCBhbnkgaHVnZXBhZ2VzIHRoYXQgbWlnaHQgYmUgbWFwcGVkIGlu
Lg0KPj4gKwkgKi8NCj4+ICsJbWFwcGluZ19pbmRleCA9IChpX3NpemVfcmVhZChpbm9kZSkgPj4g
UEFHRV9TSElGVCkgKyAyMDQ4ICsgaW5kZXg7DQo+IA0KPiBidHJmcyBhbGxvd3MgZmlsZXMgb2Yg
dXAgdG8gdGhlIHBhZ2UgY2FjaGUgbGltaXQgb2YgTUFYX0xGU19GSUxFU0laRSBhbHJlYWR5Lg0K
PiBTbyBpZiB0aGUgTWVya2xlIHRyZWUgcGFnZXMgYXJlIGNhY2hlZCBwYXN0IEVPRiBsaWtlIHRo
aXMsIGl0IHdvdWxkIGJlIG5lY2Vzc2FyeQ0KPiB0byBsaW1pdCB0aGUgc2l6ZSBvZiBmaWxlcyB0
aGF0IHZlcml0eSBjYW4gYmUgZW5hYmxlZCBvbiwgbGlrZSB3aGF0IGV4dDQgYW5kDQo+IGYyZnMg
ZG8uICBTZWUgdGhlIC1FRkJJRyBjYXNlIGluIHBhZ2VjYWNoZV93cml0ZSgpIGluIGZzL2V4dDQv
dmVyaXR5LmMgYW5kDQo+IGZzL2YyZnMvdmVyaXR5LmMuDQo+IA0KPiBOb3RlIHRoYXQgdGhpcyBl
eHRyYSBsaW1pdCBpc24ndCBsaWtlbHkgdG8gYmUgZW5jb3VudGVyZWQgaW4gcHJhY3RpY2UsIGFz
IGl0DQo+IHdvdWxkIG9ubHkgZGVjcmVhc2UgYSB2ZXJ5IGxhcmdlIGxpbWl0IGJ5IGFib3V0IDEl
LCBhbmQgZnMtdmVyaXR5IGlzbid0IGxpa2VseQ0KPiB0byBiZSB1c2VkIG9uIHRlcmFieXRlLXNp
emVkIGZpbGVzLg0KPiANCj4gSG93ZXZlciBtYXliZSB0aGVyZSdzIGEgd2F5IHRvIGF2b2lkIHRo
aXMgd2VpcmRuZXNzIGVudGlyZWx5LCBlLmcuIGJ5IGFsbG9jYXRpbmcNCj4gYSB0ZW1wb3Jhcnkg
aW4tbWVtb3J5IGlub2RlIGFuZCB1c2luZyBpdHMgYWRkcmVzc19zcGFjZT8NCg0KDQpUaGlzIGlz
IGEgZ29vZCBwb2ludCwgSSB0aGluayBtYXliZSBqdXN0IGRvIHRoZSBFRkJJRyBkYW5jZSBmb3Ig
bm93PyAgSXTigJlzIG5vdCBhIGZhY3RvciBmb3IgdGhlIGRpc2sgZm9ybWF0LCBhbmQgd2UgY2Fu
IGFkZCB0aGUgc2VwYXJhdGUgYWRkcmVzcyBzcGFjZSBhbnkgdGltZS4gIEZvciB0aGUgY29tbW9u
IGNhc2UgdG9kYXksIEkgd291bGQgcHJlZmVyIGF2b2lkaW5nIHRoZSBvdmVyaGVhZCBvZiBhbGxv
Y2F0aW5nIHRoZSB0ZW1wIGlub2RlL2FkZHJlc3Nfc3BhY2UuDQoNCi1jaHJpcw==
