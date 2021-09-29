Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 469EE41BC2B
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Sep 2021 03:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243515AbhI2BcK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Sep 2021 21:32:10 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:12264 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229505AbhI2BcJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Sep 2021 21:32:09 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18SM2GC6029060;
        Tue, 28 Sep 2021 18:30:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=uAotu9RKqy7m6qO7IrmJJpKZSW01HJGusvsPwzkQCQM=;
 b=PEhBVBWyv46cyBqJZwq45AwvEgGUQFNG7zbSyRNWIKYphaMrcyWZfm1y1cVYqt9AXkLx
 wLfoJ3HeJBAw6DB4fWoTdt8br0MOcRb0fqmu2reIwi7Q2hcUOAkhIe318HOK1JAbwwsE
 V7O+7W49e9JTQo8Eh66re0f0x0ZbRjhlihY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3bcbfes5ak-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 28 Sep 2021 18:30:28 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 28 Sep 2021 18:30:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N8ROxlC9imZu4o1QhylAWLY3uyi6zAVTsPegYiAkVrMfoN06Pnicdnhsc/wiaNWezEbYc9cOZ6Z6tJR7ZjQo5JM/VJC6B0A39eed3DWKZCviCdHVpzPPMpV6xdXetzS7Aac5MKFV67H2KU3z9GuXx2zXKcn/bdiPQtYcl0e25jGaAipIyYl6DpmlZZW/2EZ562jDzaalI5rbksR3AXCQ4SK53dJcMm1vdu3fXDl3PjPX2CJpV2J0LaN97W0VvsUQg6A4bO3iIwMvuO3Sv3p2B9bI+lsBRrvdxq5HvezB0nHT/+Q3UTD267DeZrOdxjls43zfMA9GD9nZBqa/m10Pkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=uAotu9RKqy7m6qO7IrmJJpKZSW01HJGusvsPwzkQCQM=;
 b=D8sqgTy8hjTsYhuqMoFb7zCMKxm2AqoIaij+6RZ2oDjt8b/id9huA713z1cy0pXrgtHfrfyy6r4aT4rQN309+befdxuzFPL2E65QBp2rrPKmhgSCSTXmc+mVxzM6baJ5zT0hPtQvozeFjGZ6U78cWDzGhOHQHT61Ls58jQeArlqeoHMrayJ1bby7t4G3e+yuJnJy3Rmb6wNoVVhBwltqLB29kKrSyuBITDaiZoPQegddnfi0NJ8A0Vf/3T7DXG+6z8QVh5m5qiukAfDCZWpykx0pqS2uh2w1NbzA+n6HEcgr21H3AFV1omkhq4h29E79EK4c4QT9vS9lIZ+y1Weq8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BY5PR15MB3667.namprd15.prod.outlook.com (2603:10b6:a03:1f9::18)
 by SJ0PR15MB4520.namprd15.prod.outlook.com (2603:10b6:a03:379::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.21; Wed, 29 Sep
 2021 01:30:26 +0000
Received: from BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::445:550f:2ac9:240c]) by BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::445:550f:2ac9:240c%6]) with mapi id 15.20.4544.021; Wed, 29 Sep 2021
 01:30:26 +0000
From:   Nick Terrell <terrelln@fb.com>
To:     "B093B859-53CC-4818-8CC3-A317F4872AD6@fb.com" 
        <B093B859-53CC-4818-8CC3-A317F4872AD6@fb.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL][PATCH v11 0/4] Update to zstd-1.4.10
Thread-Topic: [GIT PULL][PATCH v11 0/4] Update to zstd-1.4.10
Thread-Index: AQHXtMgnRHahUsnwt0OoDobWrpOhequ6OZgA
Date:   Wed, 29 Sep 2021 01:30:26 +0000
Message-ID: <4A374EA5-F4CC-4C41-A810-90D09CB7A5FB@fb.com>
References: <e19ebd67-949d-e43c-4090-ab1ceadcdfab@gmail.com>
In-Reply-To: <e19ebd67-949d-e43c-4090-ab1ceadcdfab@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a3e9023e-449f-44d7-4018-08d982e8b743
x-ms-traffictypediagnostic: SJ0PR15MB4520:
x-microsoft-antispam-prvs: <SJ0PR15MB4520E181F0A55D74894DA7F6ABA99@SJ0PR15MB4520.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R9p2c0kdox5CVGSyRERVUn2zYpMNNgP7iu0CeYSZ9juW/BV6ELLYFF/jyDGXKdzgUxx1SMUYRaxef2gGgfA5+v0qYVb4a7emNidvBzkEMb61r6zwD4ApT6bs7p+22ppYYplu7UhRrEprfYmkf/MWRfuFHjnah/EqxwvWhIAHybycizBLD1Nwxk8yn2Vlkk6bqxSVxM3tPMQdkhwKFsNnH6btp3uOdec8FXciNK/OUba+gBJqqsgmEd45JozPUneGTG6fuOpe7I8zAB1KLU/a1nU0/qzqHCTd0/kfqaZEIs0O7MEwJrPQJG1CtWaELXRy6bmTPu35JBObHePlO124gyg8wNI35ste64NPcQHuC/Tb57kpWr7u24pOCewOXVFytaPcFjNg96Nk4ZZ1YbRoa+25yCz7ClafhfNH93JSUvbfkuF6gJanQa0YPwAI8ZjziH/3iQJg3ygIOEyV+0MvOBZZ9Cw8kVvvXUrnZnRCpDRY3krNtIGmbvrxvKz3kc8TQI6JZPKgn06LwTSv85rZARs2hCm6ECfCxrxIw/94+sZI51hWYD0VffSP/q4xmxH/PIlLOOSvgS5DmkRNTFfKPvjMiev04LakIqpB59Sw1ibqYbgx4uPsa4UFF/sPeIAm6bs+632XZ4VubprZ4nUprajfwVBtr7WYqvo9slNT7zV5CaHK3odOMIU4wOtToOpxLWmhGv399tjn94QdbnJmTkLcWlypavRugAkzA+8djPYg1Doiiq7R39oCXrSFUM2U
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3667.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38070700005)(4326008)(4744005)(2616005)(53546011)(36756003)(38100700002)(2906002)(54906003)(122000001)(6636002)(6862004)(86362001)(66946007)(186003)(5660300002)(450100002)(6512007)(8676002)(33656002)(8936002)(66446008)(6506007)(37006003)(6486002)(76116006)(508600001)(66556008)(64756008)(71200400001)(15650500001)(83380400001)(316002)(66476007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b2wybzVpV3RLenA2THJtck15NlpXVE52TE0xR0JrTUd1V1FqeGNvZ1dDTXcx?=
 =?utf-8?B?Qzl6NWtTU2phUGdXdk56ZXVNbmhZR3hQQXFWNVJIY3JhcmFuT0RxclRSRXpm?=
 =?utf-8?B?a3NhMlNRRFdZUDZXdkc5MnFXL0plSjIvdUtFMGxPY0d4NCtidUllVzQyS2Ey?=
 =?utf-8?B?ZlJUZCtJbXkzSzIzVzlMb2RKdjJ0ajFRbW9oYUsrcjNqZk5IOTR4T0lRWC9Z?=
 =?utf-8?B?WEZod2xPb00vR0hLWlp3Z3dHNE5WTWlKS29DR2E0WDl3aHZrWUpwNnh4YUdJ?=
 =?utf-8?B?S0JrS1dJRVBzZEIyK1cxRzZ2YWJqQ0o2U3ZrVGkzbHQzTjdGSWMwekFoMTlt?=
 =?utf-8?B?WFljK2dNR3RrMllaL1NWR2FvTXkzN290ZzVMUFFBczZGT1NJNU1LaENUclBP?=
 =?utf-8?B?MVlhdnVlKzJZaHNQeVBhN2VCeithNzQwcVNTZnJnbUJEbktnRDUzYTY1Qmhs?=
 =?utf-8?B?UllkWS8wdzFqQ05vZ1dKaGJ3akJ0QmtpVGVIMnpWTVI0TkNMNlliUE9Jam90?=
 =?utf-8?B?c2Y0VXZ1MTgyK3B4dWk5Uk9JQ2VsaGlhcmNDSmQ5bFNWSWhZaExIYjh4U3FG?=
 =?utf-8?B?Y0VWUTA4dm1JRTJwTTNyS0F4QkZtbmFnYXA2VlBPS0UvTW1GaHFpb2RULzlo?=
 =?utf-8?B?cGlyUmR1NzB0UEY2alpUYmxjZURzUW9ORFZ2c2c0MlRrbWFDUnk4MTBTTWZw?=
 =?utf-8?B?Zm1TenVyZmU0R2E2dHJZYzVhZ3hOeFlSNnR4T0dpeDZHaDJsR3EzcEVRQmx5?=
 =?utf-8?B?dXZNZVJMRkJKYVFWTVdDQzVOeEdKa0Y3aWRUT2ZMdUhRV0ZLK2JGRFhiejFL?=
 =?utf-8?B?VE0yTHhGTWtvODdjUTM0Z05INFhsQmhWbzNOWEhLTE9zRzM1clFCNUJFbUNp?=
 =?utf-8?B?ZkxOWUQvc3pVUWIyY1RXcUsrcEdWWW1hZ2dVbU80RFZJSHlDU05NSDFKZVZK?=
 =?utf-8?B?NTlKUjZISmMzYzM5N2dkc2tCZkpObjVHeWJOQ3NDV1V2cWNvVWZFNG1ZSTZH?=
 =?utf-8?B?NWhhTWE3bjBlL2I5OWdncThiYUJIa2VtelgvVHVJUGV3VnRZRDlMbVNaM2F6?=
 =?utf-8?B?R2p2bTMrd3Q3aXNYR0wwNHloUmZOanFXMEpuY3ZwZHFaTHVGM3JlT3VGVWl1?=
 =?utf-8?B?eG83Z29INytRbTV4aVNQeE54YUtZVkZmRExlc1RKZzhOUXZrYUxGanFIWXYy?=
 =?utf-8?B?d0lZYU9MTVh6YzJ5dk00ZFZ4bU5lUzlVN0FNRW8wYWErbHk2bU9pRXBjZWNC?=
 =?utf-8?B?dVBScTBHNkZ1V2JJdzhFZWNUOGFvNy9mVTk1emhYMlh6R2dOcXpJRVdBQ2I2?=
 =?utf-8?B?eWN6a0NhQzdVS3l0VzdxZVRIVTcxYmhpak9MRXE1YUpuTkdCbmRuWFZCVkx6?=
 =?utf-8?B?ZFgwSGlCeHBjdFNsZ05vZElWNE9FTFpubTFkalNETlJKMzY5NGxmTmdERXhk?=
 =?utf-8?B?U0EwYUs1Z3NrWDJRTXA4T1VmaFh2eXVkbllEdFc4a1V3cGo2Y0tQYUFpUHk0?=
 =?utf-8?B?MnVhZG11QjFUNmlnOUpzT245UGdCK0lJVjc3MU0yNkZSRHBtWDdLZHlMb050?=
 =?utf-8?B?SCtlYmxHTFN4QUgreWljMHNQUmpSdlRGUCswdkhUSGpPcmNMUmZWelBRQmxy?=
 =?utf-8?B?cFFRZW84dXo4aFd5RysycGtGTEFOc0plellaOUpIWWNyVkFLK2dZUFZHTTdL?=
 =?utf-8?B?ZlFKYXBhZWRWa1JKeGliWm43a2NxTkw5eE40L0d3d1hDWFNXTUxhdVpwSmFF?=
 =?utf-8?B?cGZCL20zSUNHOWhNbVlLNU02Q0lhK0YwVG9TRk5CdEFrWHpKYTVoN21DcnZW?=
 =?utf-8?Q?3f3KTTPJBqZFWE9tnbJNrs2IeA7Uj0vEApx0Y=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D24733298968F847B82B6D8130F60DF9@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3667.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3e9023e-449f-44d7-4018-08d982e8b743
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2021 01:30:26.6788
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lk6ZXA2ElhJqtN9Y4/NI8zm+i+DnkC3F5i7UCmlRy7WstlcSQY3/QefdL9T7TyI2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4520
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: ewa95Ah9KmvQHjF885GTgsT1sQPZ196j
X-Proofpoint-GUID: ewa95Ah9KmvQHjF885GTgsT1sQPZ196j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-28_11,2021-09-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 mlxlogscore=857 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1011 phishscore=0 spamscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2109290005
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

DQoNCj4gT24gU2VwIDI4LCAyMDIxLCBhdCA1OjIyIFBNLCBUb20gU2Vld2FsZCA8dHNlZXdhbGRA
Z21haWwuY29tPiB3cm90ZToNCj4gDQo+IEhpLA0KPiANCj4gSGFzIHRoaXMgYmVlbiBhYmFuZG9u
ZWQgb3Igd2lsbCB0aGVyZSBiZSBmdXR1cmUgYXR0ZW1wdHMgYXQgc3luY2luZyB0aGUNCj4gaW4t
a2VybmVsIHpzdGQgd2l0aCB0aGUgdXBzdHJlYW0gcHJvamVjdD8NCj4gDQo+IFRvbQ0KDQpTb3Jy
eSBmb3IgdGhlIGxhY2sgb2YgYWN0aW9uLCBidXQgdGhpcyBoYXMgbm90IGJlZW4gYWJhbmRvbmVk
LiBJ4oCZdmUganVzdCBiZWVuDQpwcmVwYXJpbmcgYSByZWJhc2VkIHBhdGNoLXNldCBsYXN0IHdl
ZWssIHNvIGV4cGVjdCB0byBzZWUgc29tZSBhY3Rpb24gc29vbi4NClNpbmNlIHdl4oCZcmUgbm90
IGluIGEgbWVyZ2Ugd2luZG93LCBJ4oCZbSB1bnN1cmUgaWYgaXQgaXMgYmVzdCB0byBzZW5kIG91
dCB0aGUNCnVwZGF0ZWQgcGF0Y2hlcyBub3csIG9yIHdhaXQgdW50aWwgdGhlIG1lcmdlIHdpbmRv
dyBpcyBvcGVuLCBidXQgSeKAmW0gYWJvdXQgdG8NCnBvc2UgdGhhdCBxdWVzdGlvbiB0byB0aGUg
TEtNTC4NCg0KVGhpcyB3b3JrIGhhcyBiZWVuIG9uIG15IGJhY2sgYnVybmVyLCBiZWNhdXNlIEni
gJl2ZSBiZWVuIGJ1c3kgd2l0aCB3b3JrIG9uDQpac3RkIGFuZCBvdGhlciBwcm9qZWN0cywgYW5k
IGhhdmUgaGFkIGEgaGFyZCB0aW1lIGp1c3RpZnlpbmcgdG8gbXlzZWxmIHNwZW5kaW5nDQp0b28g
bXVjaCB0aW1lIG9uIHRoaXMsIHNpbmNlIHByb2dyZXNzIGhhcyBiZWVuIHNvIHNsb3cuDQoNCkJl
c3QsDQpOaWNrIFRlcnJlbGw=
