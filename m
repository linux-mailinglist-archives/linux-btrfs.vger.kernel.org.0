Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 517913114C2
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Feb 2021 23:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbhBEWNx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Feb 2021 17:13:53 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:18364 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232596AbhBEOjX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 5 Feb 2021 09:39:23 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 115FoToV028891;
        Fri, 5 Feb 2021 07:50:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=eY4MyoQnpPc31PWj3mKzpev0hjb6K3y5r+yK7mCDRYE=;
 b=Bti/Pm/gzr6xKvELcsU/MDgLjJR8uKFMJYfWgpUTMUF/FXjkD6MoKJS7Uw/a3W+l/XHL
 e+LodVGUS2vy6VzIwWYiUHp9XHIcE5CCS5EEnmg1qTBdQccCbbFHKcfJhX1hdtRDYwJS
 j03gco1jW27kEDYnOEjrcEbeamF/Z9uaz3M= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 36gypha9xj-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 05 Feb 2021 07:50:59 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 5 Feb 2021 07:50:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U74HZp5pu3VkkI15OZqcFBMZOzWAL7+Suexjh5+TChFm9PBkr4bYIN8IYOCsGFA7VwXQJ5GK0c4a0UFt8b0yefAyHKjP0OUfAbsZvNcKUpkKRTCXv0B1jhEZBx9QeTJhlUttwE1dT7liRN2DukqFexrMbyCKIr4hxRqsZdKDAl1QDvqQZn/DaGs+qxkc4OUrbvZoIFP/cXuDF7XNEsQjzKolxyG3+bpXlmxMM/REt4H1yN2Ypm1WHbuiRxP45dgUUknyWC0ZN5SVUHC2FqhhILnlG7aJ2R3leE1koAaNNThtBJAG4IfUdq1LSz/cDkgWBW6v/UEif4NLG21QFucreQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eY4MyoQnpPc31PWj3mKzpev0hjb6K3y5r+yK7mCDRYE=;
 b=VCFEuprB9SQt1oU6oLlzJtTIaSAWkNDPBnY4jpqucVUy7xBjadzx10MeH8fG87IVAS6gjFS8tzbwyrv7WRTE4aLD+PjB9bQbvTtKvowi+bagtQgSNPhFm91+/KqjbCKvE149lhqSVUKL5PQ5oBSC0mCx6NV7iNN15UjySm1MCJC3lmVWaP+6Jjqo6JT3S5jlnfYXh4Y589xvvGJ7Mtjowva/IFg2/xWVtAQNrRSjmU3inKtxqkXkHUiNjKpDxF3dPMjh7W7oYIhVuGTaxiFHvKry0YG2BZpAW+/g/DPQ/yZ9T6BRZTJuQrbdPXCfe9jaOR90A0LQ7mqwc1CpNV6rZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eY4MyoQnpPc31PWj3mKzpev0hjb6K3y5r+yK7mCDRYE=;
 b=NEJvDSHWMlYvCh0JkVhI4dA9v/HRjpOV8FJB8ly/9g0MjJiXMOwkqKidQY5xIRTX69s+WFJtGdNzI2QgL9mYx+aB2NU0rzVb6XIGGMAUxQ1qSPbELVSOvapk6gm7pSuD46aSP5WzequSgHRB+R+z5w2yicN6pqj1mUXAtU6RQ/M=
Received: from SA0PR15MB3839.namprd15.prod.outlook.com (2603:10b6:806:83::14)
 by SN6PR15MB2239.namprd15.prod.outlook.com (2603:10b6:805:20::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16; Fri, 5 Feb
 2021 15:50:32 +0000
Received: from SA0PR15MB3839.namprd15.prod.outlook.com
 ([fe80::6122:2d99:88bf:9ec2]) by SA0PR15MB3839.namprd15.prod.outlook.com
 ([fe80::6122:2d99:88bf:9ec2%5]) with mapi id 15.20.3825.023; Fri, 5 Feb 2021
 15:50:32 +0000
From:   Chris Mason <clm@fb.com>
To:     Nikolay Borisov <nborisov@suse.com>
CC:     Boris Burkov <boris@bur.io>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH 2/5] btrfs: initial fsverity support
Thread-Topic: [PATCH 2/5] btrfs: initial fsverity support
Thread-Index: AQHW+0yOUU+g4fmaSU+Z5J8S4J1M26pJNOmAgACBwYA=
Date:   Fri, 5 Feb 2021 15:50:32 +0000
Message-ID: <F05FE137-DDD7-454F-BAC5-857B47405AFF@fb.com>
References: <cover.1612475783.git.boris@bur.io>
 <88389022bd9f264f215c9d85fe48214190402fd6.1612475783.git.boris@bur.io>
 <b3e49ee9-2910-7971-9ba7-54207625078d@suse.com>
In-Reply-To: <b3e49ee9-2910-7971-9ba7-54207625078d@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c091:480::1:a667]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cbf0ba0d-577f-4924-ab4f-08d8c9edc515
x-ms-traffictypediagnostic: SN6PR15MB2239:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR15MB22396DE87983C31FB397828ED3B29@SN6PR15MB2239.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fbSB9RwGcepXgItducVGfMCFkgGKdG49pGfuFNlrPmtCJOHBtrjVAp0OPPwge2POGxklgrg6OPcIiC+x1dU7LCO+lU4nTA8zSGKuW/tJUO66zry3uVPJtUQfvebq5ot8HF//u4vV9PhO99csgFltacj+ztUkm2qshh+eDlsk65Rw/en/Y/fO5te3j/P4BwPCBKGY+XusM5bnarYz6diiKX0asSA3VpGbJfrTmIfT+XqO/S5uOKN1p3+jWttAgwIjdNAMKjZFlHhH2d9x7V8ttPDzIvoQOM0i5NwkVJwUwtL6SmaXgAaDT5uFvOKJpUYIwDMwTH7LMexU+ne0i61rPAeuOxySo+gRl5DHQYT26JxcPSLEn4eKqRoBScYKr952reyLvRO3JAwqOVcyvLehm59KJaXYVLMdei6Z76Rej2DfTrBH6a1KL/Wws6t7Tgi0Ccke2LaoBnRKVnHGFk8lM5O9I1iF0knLqGIYrBtGO7t0MitQWZpc6NOtt3gnXIWAIg93MN3WA9bupcVNikSVp3a83t42A0zeMRR0Cm0yBwAQNYCIaxIHZkIr4Zs8zkQsALwJ8rq3a7WXbKVzfwr9dw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR15MB3839.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(136003)(376002)(366004)(346002)(36756003)(86362001)(2906002)(2616005)(6512007)(54906003)(4326008)(5660300002)(6486002)(8676002)(33656002)(71200400001)(53546011)(66946007)(316002)(6916009)(6506007)(8936002)(66556008)(66476007)(91956017)(64756008)(83380400001)(186003)(76116006)(478600001)(66446008)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?NWlFWjJSTndjSXF6Y0xmNEM0cndOc212dHZNU2FqQllsdFNPYzVBT2dGeHFH?=
 =?utf-8?B?akJ6UGlwRWp0b2N5ZWN5aTIzbzZyRHF3WlBkcEJrYUhxQU4wMS9WYSsxWEcx?=
 =?utf-8?B?d09udXZOTkdFa2p0WEloS0xja0ljMjJ1SnlUNm1uZHV1Si9uaUtNaVJxN1E4?=
 =?utf-8?B?aUdJdWZ1WVdKOGM5RTRnN1VSYlczYXl1V1cwZEk4YllpblcvcGZVNlJDVEsr?=
 =?utf-8?B?VkZIUWxMaFJvbW11TTFLaFJ4enozZnBwdkd0bE5Zb0FRclRoMncvd1lWUWJJ?=
 =?utf-8?B?SngxVXMvbXRTbjBmSUJ2b3RnOWFvakJZc3hiZDI2cGN4My9od0wzbzE3YUtn?=
 =?utf-8?B?NjQzRmpZdEIwRFBFWExLSzd3LzViWjgrNTFEMHROdXFoN0p5ZXBOT3hoVGNk?=
 =?utf-8?B?ZjRuUWVaYm9QTjczcU5ReW96d0E2Ti9TVkxWQVU3TkozWDBXQ0h3RDYxemFu?=
 =?utf-8?B?VTJPb0JlNzF6SGVGK2RsV1FKbm1NNll1SzRmWHU3Nzk0anJKeUhLN2ZaaURm?=
 =?utf-8?B?RnkyQmwxcUw4MFhXQjB4dEszL0t6ZktrdlkzZE8vVEZjZ21yVENJaWtuRWNu?=
 =?utf-8?B?b0FYS1pQSHU3MHZlbytRbDFLMFFLWEFtb3pqV2RtdnZyeFk1RjBwZGVZVC9i?=
 =?utf-8?B?R2M3VW5PYk5NZDEycS9wcVY0S01KWjdnVWs5U1h4YjhBY3ZWbEdtM2xTSDNl?=
 =?utf-8?B?NWZjMENVSGtRa25kb1ZCM1JJQnk1S0F0YlBWWG9nZ1VxM1RZbVg0Q0hPcndR?=
 =?utf-8?B?NVBpdWsyTWtlS0JaV3NEZENTSUpzcWI0cnVqRVhlSnl5ZTcrZ2gxaDFCcktk?=
 =?utf-8?B?dCt3WEFva0ltOGFFMXQ0VDgxZHJvWnVEenE3eVJOZ201Ynd5ZW5oNHIwUzlI?=
 =?utf-8?B?dmlHdVRhdWFLTUlETFhVN2J4ajlsMnQvVnNmeGR6WThZTDhGVjdtaDVGWnVQ?=
 =?utf-8?B?RHZNd0V1ZENtaUNNN2FjS3A3V1ZZWlBUSG1sRzd1OGM5N2xjUUFBMkZTWmhn?=
 =?utf-8?B?M0JudWNBcmc4WUhyQ2daalZsdm93b2RYdjQyc0hTTGZWWlV6eVA3QThRUEUr?=
 =?utf-8?B?ckZYUU9CMm0yRUFZbHNrSUNZdEFSL0hZMG9tR0NrSVplQzJENzM2czZrYVpR?=
 =?utf-8?B?QjczOUh5NWtueDVtNXIrYkZJU2N3R0Mxb1BOSGkxc0kwMEFTOXBHc2xWNVhz?=
 =?utf-8?B?cjJSaDB0amtEOEt1TytJSVBTSzNRQTNQUHNVaDBxU3laWUFqTkhSV0dNcTFS?=
 =?utf-8?B?d3ZNc24wZUlSWmt4NHRFNURkVlh6WWhuTlZNdWh1Y24xdzNaOGtpTTdSdmUy?=
 =?utf-8?B?eGhESkR4UC81aXczR05iR0FLNkJHWkJkY3VUTS9OWldQUW8zMXhlZnNtd0JP?=
 =?utf-8?B?WmNPdElBUWRTUFBhTCt1dFhZOGNHOHFPNGJvTEQwM0NDRWRRTjgzYlZRODdZ?=
 =?utf-8?B?bEFXMk0wYTVYMmVFVTdnN3hQdnBEdDF4OTNEeEg2OEorT1NMYUtFSVpheFRV?=
 =?utf-8?B?SmRlU2l1emdqTzM2YzlBdmR1cGxYQ1hCQmlrMmlON25JOU93eFBaaWNuTm5i?=
 =?utf-8?B?TzdPRjZOaFVTZkFPUm1hSWVGc0NPenVRZm5CNGkyRjA2M0JMN0pkTVB4WnZH?=
 =?utf-8?B?RjEwQUpXSEoveDhyZzVmczQ5YUNSTEtIenIwaVFFNU9wRW13NXJjVlFFcmJU?=
 =?utf-8?B?Y2pOV21XRTQwWGIxWlFRZEpBQVJzZmNWMi9BZTdZL2N6Tm5RL3FoZ0ZDSGF1?=
 =?utf-8?B?UXJBeTgyYjRNaUlaSWt5bVRCTG5BcWRyaVRUSWpmTVhzZHBaMHlSWWJiN1p0?=
 =?utf-8?Q?zLFZFnMSgfhtWHkfJhIxj4CQ8lQdz2n3+3BPw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B4499AE727D31442A457BCFB7A5F24DB@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR15MB3839.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbf0ba0d-577f-4924-ab4f-08d8c9edc515
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2021 15:50:32.3002
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aAxuh+Sw/5M45uBSNlzysCMb22hApYngATnTJOq6X6nzdbmoFVSmD1ImKMS/jHiM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2239
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-05_09:2021-02-05,2021-02-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2102050103
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

DQoNCj4gT24gRmViIDUsIDIwMjEsIGF0IDM6MDYgQU0sIE5pa29sYXkgQm9yaXNvdiA8bmJvcmlz
b3ZAc3VzZS5jb20+IHdyb3RlOg0KPiANCj4+ICsNCj4+ICsvKg0KPj4gKyAqIGRyb3AgYWxsIHRo
ZSBpdGVtcyBmb3IgdGhpcyBpbm9kZSB3aXRoIHRoaXMga2V5X3R5cGUuICBCZWZvcmUNCj4+ICsg
KiBkb2luZyBhIHZlcml0eSBlbmFibGUgd2UgY2xlYW51cCBhbnkgZXhpc3RpbmcgdmVyaXR5IGl0
ZW1zLg0KPj4gKyAqDQo+PiArICogVGhpcyBpcyBhbHNvIHVzZWQgdG8gY2xlYW4gdXAgaWYgYSB2
ZXJpdHkgZW5hYmxlIGZhaWxlZCBoYWxmIHdheQ0KPj4gKyAqIHRocm91Z2gNCj4+ICsgKi8NCj4+
ICtzdGF0aWMgaW50IGRyb3BfdmVyaXR5X2l0ZW1zKHN0cnVjdCBidHJmc19pbm9kZSAqaW5vZGUs
IHU4IGtleV90eXBlKQ0KPj4gK3sNCj4gDQo+IFlvdSBzaG91bGQgaWRlYWxseSBiZSB1c2luZyBi
dHJmc190cnVuY2F0ZV9pbm9kZV9pdGVtcyBhcyBpdCBhbHNvDQo+IGltcGxlbWVudHMgdGhyb3R0
bGluZyBwb2xpY2llcyBhbmQga2VlcHMgZXZlcnl0aGluZyBpbiBvbmUgcGxhY2UuIElmIGZvcg0K
PiBhbnkgcmVhc29uIHRoYXQgaW50ZXJmYWNlIGlzIG5vdCBzdWZmaWNpZW50IEknZCByYXRoZXIg
c2VlIGl0IHJlZmFjdG9yZWQNCj4gYW5kIGJyb2tlbiBkb3duIGluIHNtYWxsZXIgcGllY2VzIHRo
YW4ganVzdCBjb3B5aW5nIHN0dWZmIGFyb3VuZCwgdGhpcw0KPiBqdXN0IGluY3JlbWVudHMgdGhl
IG1haW50ZW5hbmNlIGJ1cmRlbi4NCj4gDQoNCmJ0cmZzX3RydW5jYXRlX2lub2RlX2l0ZW1zIGlz
IGFscmVhZHkgY29tcGxleCwgYW5kIGl04oCZcyBkZXNpZ25lZCBmb3IgdGhpbmdzIHRoYXQgZGVh
bCB3aXRoIGNoYW5nZXMgdG8gaV9zaXplLiAgSXQgd291bGQgaGF2ZSB0byBiZSByZXdvcmtlZCB0
byByZW1vdmUgdGhlIGFzc3VtcHRpb24gdGhhdCB3ZeKAmXJlIHphcHBpbmcgdW5jb25kaXRpb25h
bGx5IGZyb20gaGlnaCBvZmZzZXRzIHRvIGxvdy4NCg0KTWF5YmUgb25jZSB3ZeKAmXZlIGZpbmFs
aXplZCBldmVyeXRoaW5nIGVsc2UgYWJvdXQgZnN2ZXJpdHksIGl0IG1ha2VzIHNlbnNlIHRvIG9w
dGltaXplIGRyb3BfdmVyaXR5X2l0ZW1zIGFuZCBmb2xkIGl0IGludG8gdGhlIG90aGVyIHRydW5j
YXRlIGhlbHBlciwgYnV0IHRoZSBmdW5jdGlvbiBhcyBpdCBzdGFuZHMgaXMgZWFzeSB0byByZXZp
ZXcgYW5kIGhhcyBubyByaXNrcyBvZiBhZGRpbmcgcmVncmVzc2lvbnMgb3V0c2lkZSBvZiBmc3Zl
cml0eS4gIFRoZSBpbXBvcnRhbnQgcGFydCBub3cgaXMgZ2V0dGluZyB0aGUgZGlzayBmb3JtYXQg
bmFpbGVkIGRvd24gYW5kIGJhc2ljIGZ1bmN0aW9uYWxpdHkgcmlnaHQuDQoNCj4+ICsNCj4+ICsJ
CS8qIGRlc2MgPSBOVUxMIHRvIGp1c3Qgc3VtIGFsbCB0aGUgaXRlbSBsZW5ndGhzICovDQo+IA0K
PiBuaXQ6IHR5cG8gLSBkZXN0IGluc3RlYWQgb2YgZGVzYw0KPiANCg0KV2hvb3BzLCB0aGF0IGNh
bWUgZnJvbSB0aGUgb3JpZ2luYWwgZXh0NCBjb2RlIGFuZCBJIGRpZG7igJl0IHN3YXAgdGhlIGNv
bW1lbnQuDQoNCj4+ICsNCj4+ICsvKg0KPj4gKyAqIGZzdmVyaXR5IGNhbGxzIHRoaXMgdG8gYXNr
IHVzIHRvIHNldHVwIHRoZSBpbm9kZSBmb3IgZW5hYmxpbmcuICBXZQ0KPj4gKyAqIGRyb3AgYW55
IGV4aXN0aW5nIHZlcml0eSBpdGVtcyBhbmQgc2V0IHRoZSBpbiBwcm9ncmVzcyBiaXQNCj4+ICsg
Ki8NCj4+ICtzdGF0aWMgaW50IGJ0cmZzX2JlZ2luX2VuYWJsZV92ZXJpdHkoc3RydWN0IGZpbGUg
KmZpbHApDQo+PiArew0KPj4gKwlzdHJ1Y3QgaW5vZGUgKmlub2RlID0gZmlsZV9pbm9kZShmaWxw
KTsNCj4+ICsJaW50IHJldDsNCj4+ICsNCj4+ICsJaWYgKHRlc3RfYml0KEJUUkZTX0lOT0RFX1ZF
UklUWV9JTl9QUk9HUkVTUywgJkJUUkZTX0koaW5vZGUpLT5ydW50aW1lX2ZsYWdzKSkNCj4+ICsJ
CXJldHVybiAtRUJVU1k7DQo+PiArDQo+PiArCS8qDQo+PiArCSAqIGV4dDQgYWRkcyB0aGUgaW5v
ZGUgdG8gdGhlIG9ycGhhbiBsaXN0IGhlcmUsIHByZXN1bWFibHkgYmVjYXVzZSB0aGUNCj4+ICsJ
ICogdHJ1bmNhdGUgZG9uZSBhdCBvcnBoYW4gcHJvY2Vzc2luZyB0aW1lIHdpbGwgZGVsZXRlIHBh
cnRpYWwNCj4+ICsJICogbWVhc3VyZW1lbnRzLiAgVE9ETzogc2V0dXAgb3JwaGFucw0KPj4gKwkg
Ki8NCj4gDQo+IEFueSBwbGFucyB3aGVuIG9ycGhhbiBzdXBwb3J0IGlzIGdvaW5nIHRvIGJlIGlt
cGxlbWVudGVkPw0KPiANCg0KSSB3YXMgb24gdGhlIGZlbmNlIGFib3V0IGlnbm9yaW5nIHRoZW0g
Y29tcGxldGVseS4gIFRoZSBzcGFjZSBpc27igJl0IGxlYWtlZCwgYW5kIG9ycGhhbnMgYXJlIGJh
ZCBlbm91Z2ggYWxyZWFkeS4gIEl0IHdvdWxkbuKAmXQgYmUgaGFyZCB0byBtYWtlIHRoZSBvcnBo
YW4gY29kZSBjaGVjayBmb3IgaW5jb21wbGV0ZSBmc3Zlcml0eSBlbmFibGVzIHRob3VnaC4NCg0K
Pj4gKwlzZXRfYml0KEJUUkZTX0lOT0RFX1ZFUklUWV9JTl9QUk9HUkVTUywgJkJUUkZTX0koaW5v
ZGUpLT5ydW50aW1lX2ZsYWdzKTsNCj4+ICsJcmV0ID0gZHJvcF92ZXJpdHlfaXRlbXMoQlRSRlNf
SShpbm9kZSksIEJUUkZTX1ZFUklUWV9ERVNDX0lURU1fS0VZKTsNCj4+ICsJaWYgKHJldCkNCj4+
ICsJCWdvdG8gZXJyOw0KPj4gKw0KPj4gKwlyZXQgPSBkcm9wX3Zlcml0eV9pdGVtcyhCVFJGU19J
KGlub2RlKSwgQlRSRlNfVkVSSVRZX01FUktMRV9JVEVNX0tFWSk7DQo+PiArCWlmIChyZXQpDQo+
PiArCQlnb3RvIGVycjsNCj4gDQo+IEEgc2xpZ2h0bHkgaGlnaGVyLWxldmVsIHF1ZXN0aW9uOg0K
PiANCj4gSW4gZHJvcF92ZXJpdHlfaXRlbXMgeW91IGFyZSBkb2luZyB0cmFuc2FjdGlvbi1wZXIt
aXRlbSwgc28gd2hhdCBoYXBwZW5zDQo+IGR1cmluZyBhIGNyYXNoIGFuZCBvbmx5IHNvbWUgb2Yg
dGhlIGl0ZW1zIGJlaW5nIGRlbGV0ZWQ/IElzIHRoaXMgZmluZSwNCj4gcHJlc3VtYWJseSB0aGF0
J2QgbWFrZSB0aGUgZmlsZSB1bnJlYWRhYmxlPyBJLmUgd2hhdCBzaG91bGQgYmUgdGhlDQo+IGdy
YW51bGUgb2YgYXRvbWljaXR5IHdoZW4gZGVhbGluZyB3aXRoIHZlcml0eSBpdGVtcyAtIGFsbCBv
ciBub3RoaW5nIG9yDQo+IHBlci1pdGVtIGlzIHN1ZmZpY2llbnQ/DQoNCkp1c3QgbmVlZHMgdG8g
cmVydW4gdGhlIHZlcml0eSBlbmFibGUgYWZ0ZXIgdGhlIGNyYXNoLiAgVGhlIGZpbGUgd29u4oCZ
dCBiZSBoYWxmIHZlcml0eSBlbmFibGVkIGJlY2F1c2UgdGhlIGJpdCBpc27igJl0IHNldCB1bnRp
bCBhZnRlciBhbGwgb2YgdGhlIHZlcml0eSBpdGVtcyBhcmUgaW5zZXJ0ZWQuDQoNCj4gDQo+PiAr
DQo+PiArCXJldHVybiAwOw0KPj4gKw0KPj4gK2VycjoNCj4+ICsJY2xlYXJfYml0KEJUUkZTX0lO
T0RFX1ZFUklUWV9JTl9QUk9HUkVTUywgJkJUUkZTX0koaW5vZGUpLT5ydW50aW1lX2ZsYWdzKTsN
Cj4+ICsJcmV0dXJuIHJldDsNCj4+ICsNCj4+ICt9DQo+PiArDQo+PiArLyoNCj4+ICsgKiBmc3Zl
cml0eSBjYWxscyB0aGlzIHdoZW4gaXQncyBkb25lIHdpdGggYWxsIG9mIHRoZSBwYWdlcyBpbiB0
aGUgZmlsZQ0KPj4gKyAqIGFuZCBhbGwgb2YgdGhlIG1lcmtsZSBpdGVtcyBoYXZlIGJlZW4gaW5z
ZXJ0ZWQuICBXZSB3cml0ZSB0aGUNCj4+ICsgKiBkZXNjcmlwdG9yIGFuZCB1cGRhdGUgdGhlIGlu
b2RlIGluIHRoZSBidHJlZSB0byByZWZsZWN0IGl0J3MgbmV3IGxpZmUNCj4+ICsgKiBhcyBhIHZl
cml0eSBmaWxlDQo+PiArICovDQo+PiArc3RhdGljIGludCBidHJmc19lbmRfZW5hYmxlX3Zlcml0
eShzdHJ1Y3QgZmlsZSAqZmlscCwgY29uc3Qgdm9pZCAqZGVzYywNCj4+ICsJCQkJICBzaXplX3Qg
ZGVzY19zaXplLCB1NjQgbWVya2xlX3RyZWVfc2l6ZSkNCj4+ICt7DQo+PiArCXN0cnVjdCBidHJm
c190cmFuc19oYW5kbGUgKnRyYW5zOw0KPj4gKwlzdHJ1Y3QgaW5vZGUgKmlub2RlID0gZmlsZV9p
bm9kZShmaWxwKTsNCj4+ICsJc3RydWN0IGJ0cmZzX3Jvb3QgKnJvb3QgPSBCVFJGU19JKGlub2Rl
KS0+cm9vdDsNCj4+ICsJaW50IHJldDsNCj4+ICsNCj4+ICsJaWYgKGRlc2MgIT0gTlVMTCkgew0K
PiANCj4gUmVkdW5kYW50IGNoZWNrIGFzIHRoZSBkZXNjcmlwdG9yIGNhbiBuZXZlciBiZSBudWxs
IGFzIHBlciBlbmFibGVfdmVyaXR5Lg0KPiANCg0KVGFrZSBhIGxvb2sgYXQgdGhlIHJvbGxiYWNr
IGdvdG86DQoNCnJvbGxiYWNrOg0KICAgICAgICBpbm9kZV9sb2NrKGlub2RlKTsNCiAgICAgICAg
KHZvaWQpdm9wcy0+ZW5kX2VuYWJsZV92ZXJpdHkoZmlscCwgTlVMTCwgMCwgcGFyYW1zLnRyZWVf
c2l6ZSk7DQogICAgICAgIGlub2RlX3VubG9jayhpbm9kZSk7DQogICAgICAgIGdvdG8gb3V0DQoN
Cj4+ICsJCS8qIHdyaXRlIG91dCB0aGUgZGVzY3JpcHRvciAqLw0KPj4gKwkJcmV0ID0gd3JpdGVf
a2V5X2J5dGVzKEJUUkZTX0koaW5vZGUpLA0KPj4gKwkJCQkgICAgICBCVFJGU19WRVJJVFlfREVT
Q19JVEVNX0tFWSwgMCwNCj4+ICsJCQkJICAgICAgZGVzYywgZGVzY19zaXplKTsNCj4+ICsJCWlm
IChyZXQpDQo+PiArCQkJZ290byBvdXQ7DQo+PiArDQo+PiArCQkvKiB1cGRhdGUgb3VyIGlub2Rl
IGZsYWdzIHRvIGluY2x1ZGUgZnMgdmVyaXR5ICovDQo+PiArCQl0cmFucyA9IGJ0cmZzX3N0YXJ0
X3RyYW5zYWN0aW9uKHJvb3QsIDEpOw0KPj4gKwkJaWYgKElTX0VSUih0cmFucykpIHsNCj4+ICsJ
CQlyZXQgPSBQVFJfRVJSKHRyYW5zKTsNCj4+ICsJCQlnb3RvIG91dDsNCj4+ICsJCX0NCj4+ICsJ
CUJUUkZTX0koaW5vZGUpLT5jb21wYXRfZmxhZ3MgfD0gQlRSRlNfSU5PREVfVkVSSVRZOw0KPj4g
KwkJYnRyZnNfc3luY19pbm9kZV9mbGFnc190b19pX2ZsYWdzKGlub2RlKTsNCj4+ICsJCXJldCA9
IGJ0cmZzX3VwZGF0ZV9pbm9kZSh0cmFucywgcm9vdCwgQlRSRlNfSShpbm9kZSkpOw0KPj4gKwkJ
YnRyZnNfZW5kX3RyYW5zYWN0aW9uKHRyYW5zKTsNCj4+ICsJfQ0KPj4gKw0KPj4gK291dDoNCj4+
ICsJaWYgKGRlc2MgPT0gTlVMTCB8fCByZXQpIHsNCj4gDQo+IEp1c3QgY2hlY2tpbmcgZm9yIHJl
dCBpcyBzdWZmaWNpZW50Lg0KDQpTZWUgYWJvdmUsIHRoZSBkZXNjIGNoZWNrIGlzIHJlcXVpcmVk
Lg0KDQo+PiArc3RhdGljIHN0cnVjdCBwYWdlICpidHJmc19yZWFkX21lcmtsZV90cmVlX3BhZ2Uo
c3RydWN0IGlub2RlICppbm9kZSwNCj4+ICsJCQkJCSAgICAgICBwZ29mZl90IGluZGV4LA0KPj4g
KwkJCQkJICAgICAgIHVuc2lnbmVkIGxvbmcgbnVtX3JhX3BhZ2VzKQ0KPj4gK3sNCj4+ICsJc3Ry
dWN0IHBhZ2UgKnA7DQo+PiArCXU2NCBzdGFydCA9IGluZGV4IDw8IFBBR0VfU0hJRlQ7DQo+PiAr
CXVuc2lnbmVkIGxvbmcgbWFwcGluZ19pbmRleDsNCj4+ICsJc3NpemVfdCByZXQ7DQo+PiArCWlu
dCBlcnI7DQo+PiArDQo+PiArCS8qDQo+PiArCSAqIHRoZSBmaWxlIGlzIHJlYWRvbmx5LCBzbyBp
X3NpemUgY2FuJ3QgY2hhbmdlIGhlcmUuICBXZSBqdW1wDQo+PiArCSAqIHNvbWUgcGFnZXMgcGFz
dCB0aGUgbGFzdCBwYWdlIHRvIGNhY2hlIG91ciBtZXJrbGVzLiAgVGhlIGdvYWwNCj4+ICsJICog
aXMganVzdCB0byBqdW1wIHBhc3QgYW55IGh1Z2VwYWdlcyB0aGF0IG1pZ2h0IGJlIG1hcHBlZCBp
bi4NCj4+ICsJICovDQo+PiArCW1hcHBpbmdfaW5kZXggPSAoaV9zaXplX3JlYWQoaW5vZGUpID4+
IFBBR0VfU0hJRlQpICsgMjA0OCArIGluZGV4Ow0KPiANCj4gU28gd2hhdCBkb2VzIHRoaXMgbWFn
aWMgbnVtYmVyIDIwNDggbWVhbiwgaG93IHdhcyBpdCBkZXJpdmVkPyBQZXJoYXBzDQo+IGdpdmUg
aXQgYSBzeW1ib2xpYyBuYW1lIGVpdGhlciB2aWEgYSBsb2NhbCBjb25zdCB2YXIgb3IgdmlhIGEg
ZGVmaW5lLA0KPiBzb21ldGhpbmcgbGlrZQ0KPiANCj4gI2RlZmluZSBJTk9ERV9WRVJJVFlfRU9G
X09GRlNFVCAyMDQ4IG9yIHNvbWV0aGluZyBhbG9uZyB0aG9zZSBsaW5lcy4NCj4gDQoNCk5vIG9i
amVjdGlvbnMgdG8gdGhlIGNvbnN0YW50LCBidXQgdGhlIG9mZnNldCBpcyBwcmV0dHkgYXJiaXRy
YXJ5IGFuZCBub3QgcmVwZWF0ZWQgYW55d2hlcmUgZWxzZS4gIEl0IG1ha2VzIG1vcmUgc2Vuc2Ug
dG8ganVzdCBjb21tZW50IGl0IHdoZXJlIHdlIHVzZSBpdCwgYmVjYXVzZSBJTk9ERV9WRVJJVFlf
RU9GX09GRlNFVCBsb29rcyBsaWtlIGFuIGltcG9ydGFudCBudW1iZXIgYW5kIDIwNDggaXMgb2J2
aW91c2x5IHB1bGxlZCBvdXQgb2YgdGhlIHNreS4NCg0KPiBJZiB0aGUgZmlsZSBpcyBSTyB0aGVu
IHdoeSBkbyB5b3UgbmVlZCB0byBhZGQgc3VjaCBhIGxhcmdlIG9mZnNldCwgaXQncw0KPiBub3Qg
Y2xlYXIgd2hhdCB0aGUgaHVnZXBhZ2VzIGlzc3VlIGlzLg0KDQoNCkl04oCZcyBwb3NzaWJsZSBm
b3IgZXhlY3V0YWJsZSBwYWdlcyB0byBiZSB0dXJuZWQgaW50byBodWdlcGFnZXMgYnkgdGhlIFZN
LCBhbmQgdGhlcmUgYXJlIHZhcmlvdXMgbG9uZyB0ZXJtIGVmZm9ydHMgdG8gaHVnaWZ5IGFsbCB0
aGUgdGhpbmdzLiAgSnVtcGluZyBmYXIgZW5vdWdoIGF3YXkgdGhhdCB3ZSBtYWtlIHN1cmUgd2Xi
gJlyZSBub3Qgb3ZlcmxhcHBpbmcgb25lIG9mIHRob3NlIGh1Z2VwYWdlcyBzZWVtcyBsaWtlIGEg
Z29vZCBpZGVhLg0KDQotY2hyaXMNCg0K
