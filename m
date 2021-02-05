Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9AF031150B
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Feb 2021 23:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232746AbhBEWWx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Feb 2021 17:22:53 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:28354 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232629AbhBEO27 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 5 Feb 2021 09:28:59 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 115G2tYH022561;
        Fri, 5 Feb 2021 08:06:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=5SVb2YcrDgse2Co9enxVfM4r4yaDhIqghpnS+XdlSfk=;
 b=dTtExATS4cLFdvm5XmK6NVNK/96iRcU5DktJI+63AYzEZ4pQXO6i7d3yPB4t4dLH6LJM
 kW6Z5nb+5INDq9l/Fq/tRYTEi4WDiKOy4e2AaysDq8suca3vIs3Ph5CLjxLjprvXH1Je
 0g6LTUmOdnOH6YeFcqlrERpAT9HyOTVSQ6g= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 36fx4nw098-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 05 Feb 2021 08:06:35 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 5 Feb 2021 08:06:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g+DroKZWqH30MiWMk5Hm4c4od67CnQCvdx6xdKAx45qSXM85U/Mo+lnz2V8s/01nAZ7vyhN4g1a/8VgclOc9D4b81QS0gowoALkpgjeD39bMc+SCg9VAJSWo6ZohDEDPVMqiMXuE46Au4oOrk/BpLd9kqO4osoF8oNGq6Uq8WMQOUK9U7xs9zpNpQVIo0PAMGXonE+Njpdwp5GzxdGwfp2mMoShp0JcDNZVAE+YNaIaX0E6YYUb7Pg0hpD8kJoX/2DuAOkp9d5RnVCWbWt+OeKcbLz3opSK2iHF5GHlX8jKDp3oD3NTyMr65n3V0lNt/fYW7En9lqrDCaDZ6J0Ge7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5SVb2YcrDgse2Co9enxVfM4r4yaDhIqghpnS+XdlSfk=;
 b=JeNlKifd1kI6kIMASqXS6i6vSTQSXGt2O3MYDsEQgJNjAOss3QDBUv4Tq0ffiqUJ7K75WcjphuZufwPaRZ+16WG5dXmfC4+UOCjuYMs2dawRNzn7k4X0ftHEK9oDH2cxsN7GgPHirjjGybMU9G3+OscejMnBhTAEhatdg5AfPc7aSXvwRnS4Mjyt55c7acSmbdJ2XjeD11jm2wVgePX8F1FqwDUsZfuOWyMIVaC/SYOYCWhmOqZB9xjA/iltdv/h3wQYGOArDMuCrrBBdv+ckz4fZ2NRSJuJEJILxnmCyjU3yfh1+Klz3ZDCqtA8iL3lYjluAd7HXr5evgpx/MZ5mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5SVb2YcrDgse2Co9enxVfM4r4yaDhIqghpnS+XdlSfk=;
 b=cOymHirkYkS8RFyJtyrgE+0z+bT5dh/7c6x6r3Mqg58cX9ESc/sPusGjsN/T43pIIDvbn5orNBlatN6DVndLYb7FLTq32gatdkfDe5YZYq7yW+z5/2Erxs8svJmyyH5H2Qzqbo6YcIv9GJ13Ab6MYIpHPnG8CroYUl3eMAtfVrg=
Received: from SA0PR15MB3839.namprd15.prod.outlook.com (2603:10b6:806:83::14)
 by SN6PR15MB2304.namprd15.prod.outlook.com (2603:10b6:805:23::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17; Fri, 5 Feb
 2021 16:06:30 +0000
Received: from SA0PR15MB3839.namprd15.prod.outlook.com
 ([fe80::6122:2d99:88bf:9ec2]) by SA0PR15MB3839.namprd15.prod.outlook.com
 ([fe80::6122:2d99:88bf:9ec2%5]) with mapi id 15.20.3825.023; Fri, 5 Feb 2021
 16:06:30 +0000
From:   Chris Mason <clm@fb.com>
To:     Boris Burkov <boris@bur.io>
CC:     Eric Biggers <ebiggers@kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH 0/5] btrfs: support fsverity
Thread-Topic: [PATCH 0/5] btrfs: support fsverity
Thread-Index: AQHW+0yGQUeTKggKU0qZ5e4U3nG89apJFY8AgAAMaYCAAJkogA==
Date:   Fri, 5 Feb 2021 16:06:30 +0000
Message-ID: <0AAFA0E2-5ACB-48C5-B1DC-52D311EC5266@fb.com>
References: <cover.1612475783.git.boris@bur.io>
 <YBziIn5FhtekZ7ZP@sol.localdomain>
 <20210205065819.GB2428856@devbig008.ftw2.facebook.com>
In-Reply-To: <20210205065819.GB2428856@devbig008.ftw2.facebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: bur.io; dkim=none (message not signed)
 header.d=none;bur.io; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c091:480::1:a667]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cba168c5-31db-420d-1499-08d8c9effffd
x-ms-traffictypediagnostic: SN6PR15MB2304:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR15MB2304D9BFAF2FF7F6C4ABB007D3B29@SN6PR15MB2304.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dwXZ1onYlLMGxhDmHrRO3MUUEbPIH8zl8ejx+xhCw6BSG+dm/ARXWDsKC7qpDaoWjrSgvM7GcF7bDcRXUMo6tyVJ38QwhqNTrmCsLDm0uZM88i4g5J+IMmqXgLYdJFKytAGxb+PgrWBIh0o8dJcSiHnApVc/jLofSZ/arNIqa1P5Rt4FM/cs39exXN4MbiPaF/azkIZiKTobFKAhA0ZtOEBpBciDyjd+iFV4GJM/cybR/osCPKHLrfLne9pzyXOULJszqFBSgfwMS4JCuVktUiKyCqIZyryC1pUFAprq8m7RVIbVZ1cQqF/NDVjUdf+Abb8CZdDoPQukV8VxuzzwCo9a1yS/OU6UGQ5yNaZEW/uSSlgOf82KKy3ixpo9zWeaphXrr7luOK0Q9SdIg4uh4k4AgCAPT0alnGowEePCWipXib3z9KKqLYlWA5BUImKKgG+jgT1ssd6wTQUapxpYsKmZ1CfAudCYVZikb/6lgUhtl1BFRd8kPZMRa9PvWDXG7LMF60VOiRvhDWLpOYTeYozUWA6Yc4NGRhREAZCioDyAB/VJjfzxqcAPAMVBmDlGaT+dFfka0GIyVCv5UTmwIA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR15MB3839.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(39860400002)(136003)(346002)(376002)(36756003)(66446008)(33656002)(66946007)(64756008)(5660300002)(86362001)(66556008)(6506007)(4326008)(91956017)(2616005)(66476007)(478600001)(6512007)(6916009)(186003)(8676002)(8936002)(71200400001)(316002)(83380400001)(53546011)(2906002)(54906003)(76116006)(6486002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?bVZHZ21WeEkzUVZtdGxEdVdkTWo4TDFyU2tsZkxyUVZjTWdVZ3M0Zm5XdUY4?=
 =?utf-8?B?TEVZMUhvS2lRcGZhc2xISTBHeE9Fb0VlVndpVzNZbjMzd0ptbzI4djFjdDZJ?=
 =?utf-8?B?d3ltZUxqMEo2bmpRQmdLeHVWK09xYnUydm92MHk2Ykw3SWdGR09DcUFhVnhm?=
 =?utf-8?B?NHFvYVEyekZEcXRydllVcDl2TDMzcDdyV1FIMXd0bllYVHVXTDgrbTcweGNk?=
 =?utf-8?B?OWxmZVZleGdJaFd1bFZsNEV0NUpRSDh4Q2k2RzREdGNxTDErOFNVSnBqNFJN?=
 =?utf-8?B?Ky9PdEh4T3lCU2dSZnBCNGJGdEQrUjN6NmFaYStsYjFSY2dnakJEVmErKzhh?=
 =?utf-8?B?T24xSGpVcWg4Q3pKb2gzd0hjME5HRDZNRnBGTG9MVzN1S1RDSWgvbzlXOFdq?=
 =?utf-8?B?M3F2bWwrR3ZJV3lLbEJ4RzBxNDJ3TGNpQ3E3RTBoUjhqYzh5ZFExdEYxWWlx?=
 =?utf-8?B?bnQxY1FvSURqK1FaelpVd3llVU02ekhuamU1bmt3Tkd1WHQ5NUhWZnUzY3pR?=
 =?utf-8?B?WFZzSHh5OWM2eWs4dGVQSWRDNjNPVTVUTWFRdUwveFBlN1lhZE5tNHhsc2tt?=
 =?utf-8?B?SGYvSDJMT3g1MjhtcFNLdjBzd3BpdEhXZ2xEUUhjdDA2NCtMSmZPdDIrMisz?=
 =?utf-8?B?eFhrRFRxblBmdkl2VkJYOXNxRkU1QjlyNjQwdE90ckwxNkJjZFBYWE5yRWUr?=
 =?utf-8?B?RzNFVWFkUDJzTnBRVFdTdndYT29UaDIvakRwTWdyWnpnNG0yL28yR2E4ZTlN?=
 =?utf-8?B?RFp5NTNxTEdqWFZ2c3JmOUtuK1h4Zm95K0ZmTHZjY2NBMVdKVXNnbEdvUExE?=
 =?utf-8?B?UjBCS1FKYVIrUWtsaThPSXdMQXR3QkZSNTkzc1hRMTg2ek5ySVZTTTlMcVpN?=
 =?utf-8?B?Y2M4UXpkOEpWZE9lZ2pxRkc0S0V1UTZoVjJ4eTE4SnJqRkNRN1J0N3BobzNk?=
 =?utf-8?B?d0V1RzB0ZjliYmo3OVVEZG00a25ZYXRWR21kTDduS1d6RHZQdmRtY0dHZGpk?=
 =?utf-8?B?Ym5HUmt2RUl3aFBMaUxIcm5JYjlNZTArbm1JMXFobmFvdGVXekd0eFNQTVha?=
 =?utf-8?B?Y2diMWJ4L2NtSVR2aHlOSllXUURhVnZ3aE41dkdCa3FtRHU0RkRQNHdyYmRo?=
 =?utf-8?B?K0dzQmFHYzVDOG5YaHBma0NKRXRtNTJnemFkUXJDdGY3ZVRTUnYzUmhZRm52?=
 =?utf-8?B?TFhQTW5oZFNLZG1LT2Q5aXFlVmtnRmxaN0o3WUJwRUFVZUlhK0VueTVGMEts?=
 =?utf-8?B?ZVBvTUZGWmRYdjRSODBST3I0bWJTMDRTOUx3QTBBZEoxSGtrUHdCL3liNTVL?=
 =?utf-8?B?YXpzcENxQ3ZhS010bTJIUktaZUVyRk91ODNyMGRDUElHcXBYbkFpVTVzdksv?=
 =?utf-8?B?RUVXU1IyWDhRUlpoOTZqZ2FQSkxvZzFmM2JXQXNQUHQ0RmNuTERFbWlZekU0?=
 =?utf-8?B?a1lJbDJpaHpwbWIxSDJmUFB0ZE85amlTS2ZUZmVFd2dTYmlyRjZibkl2QlVr?=
 =?utf-8?B?ZGxyUzVnYWloMTNWa2lTcHhPZ2NCRDMwK0t5K21iM0t6SVArRFhsb2E2Y29R?=
 =?utf-8?B?Kzd0dlB4dTVnYm0yQkN5RDhMWmpEclN5OUtpRTdJSUU3aWwrTGgrTzk3Snha?=
 =?utf-8?B?TnpDcTNENEUzWDlscW1aalh4OHFneGIyTndEZm5zNTNqN3VsYXlRZ3pldFJD?=
 =?utf-8?B?aHpnUjNHSEZLUUlQWjZSVVBrQjUzbXI4YlZLZXNNem9FVE1vUzRtdGVCSmht?=
 =?utf-8?B?UmJ1WmVvVDBpMGJPNHVoUm16VDQzdDREOTY1NEIrUWVwWmp6MnVVOFRNck5v?=
 =?utf-8?Q?w8mRspCkL3nSFBXksHp8QdwGEDjy+g8p/uBBs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <60FC79CA0CBD7D49BBADF71BB504A07E@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR15MB3839.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cba168c5-31db-420d-1499-08d8c9effffd
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2021 16:06:30.1181
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V8CuexGpCDtXsBpimyNd/P8n+xBDf6/FtIw4mkHc5cSzVaWaSgYIyvpMFqI9MqiX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2304
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-05_09:2021-02-05,2021-02-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 phishscore=0 suspectscore=0 spamscore=0 priorityscore=1501 adultscore=0
 mlxscore=0 clxscore=1015 impostorscore=0 bulkscore=0 mlxlogscore=980
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102050104
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

DQo+IE9uIEZlYiA1LCAyMDIxLCBhdCAxOjU4IEFNLCBCb3JpcyBCdXJrb3YgPGJvcmlzQGJ1ci5p
bz4gd3JvdGU6DQo+IA0KPiBPbiBUaHUsIEZlYiAwNCwgMjAyMSBhdCAxMDoxMzo1NFBNIC0wODAw
LCBFcmljIEJpZ2dlcnMgd3JvdGU6DQo+PiBPbiBUaHUsIEZlYiAwNCwgMjAyMSBhdCAwMzoyMToz
NlBNIC0wODAwLCBCb3JpcyBCdXJrb3Ygd3JvdGU6DQo+Pj4gVGhpcyBwYXRjaHNldCBwcm92aWRl
cyBzdXBwb3J0IGZvciBmc3Zlcml0eSBpbiBidHJmcy4NCj4+IA0KPj4gVmVyeSBpbnRlcmVzdGVk
IHRvIHNlZSB0aGlzISAgSXQgZ2VuZXJhbGx5IGxvb2tzIGdvb2QsIGJ1dCBJIGhhdmUgc29tZSBj
b21tZW50cy4NCj4+IA0KPj4gQWxzbywgd2hlbiB5b3Ugc2VuZCB0aGlzIG91dCBuZXh0LCBjYW4g
eW91IGluY2x1ZGUNCj4+IGxpbnV4LWZzY3J5cHRAdmdlci5rZXJuZWwub3JnLCBhcyBwZXIgJ2dl
dF9tYWludGFpbmVyLnBsIGZzL3Zlcml0eS8nPw0KPj4gDQo+IA0KPiBTb3JyeSBmb3IgbWlzc2lu
ZyB0aGF0LCBkZWZpbml0ZWx5IHdpbGwgZG8gZm9yIHYyLg0KPiANCj4+PiBBdCBhIGhpZ2ggbGV2
ZWwsIHdlIHN0b3JlIHRoZSB2ZXJpdHkgZGVzY3JpcHRvciBhbmQgTWVya2xlIHRyZWUgZGF0YQ0K
Pj4+IGluIHRoZSBmaWxlIHN5c3RlbSBidHJlZSB3aXRoIHRoZSBmaWxlJ3MgaW5vZGUgYXMgdGhl
IG9iamVjdGlkLCBhbmQNCj4+PiBkaXJlY3QgcmVhZHMvd3JpdGVzIHRvIHRob3NlIGl0ZW1zIHRv
IGltcGxlbWVudCB0aGUgZ2VuZXJpYyBmc3Zlcml0eQ0KPj4+IGludGVyZmFjZSByZXF1aXJlZCBi
eSBmcy92ZXJpdHkvLg0KPj4+IA0KPj4+IFRoZSBmaXJzdCBwYXRjaCBpcyBhIHByZXBhcmF0b3J5
IHBhdGNoIHdoaWNoIGFkZHMgYSBub3Rpb24gb2YNCj4+PiBjb21wYXRfZmxhZ3MgdG8gdGhlIGJ0
cmZzX2lub2RlIGFuZCBpbm9kZV9pdGVtIGluIG9yZGVyIHRvIGFsbG93DQo+Pj4gZW5hYmxpbmcg
dmVyaXR5IG9uIGEgZmlsZSB3aXRob3V0IG1ha2luZyB0aGUgZmlsZSBzeXN0ZW0gdW5tb3VudGFi
bGUgZm9yDQo+Pj4gb2xkZXIga2VybmVscy4gKEl0IHJ1bnMgYWZvdWwgb2YgdGhlIGxlYWYgY29y
cnVwdGlvbiBjaGVjayBvdGhlcndpc2UpDQo+PiANCj4+IEluIGV4dDQsIHZlcml0eSBpcyBhIHJv
X2NvbXBhdCBmaWxlc3lzdGVtIGZlYXR1cmUgcmF0aGVyIHRoYW4gYSBjb21wYXQgZmVhdHVyZS4N
Cj4+IFRoYXQncyBiZWNhdXNlIHdlIHdhbnRlZCB0byBwcmV2ZW50IG9sZCBrZXJuZWxzIGZyb20g
d3JpdGluZyB0byB2ZXJpdHkgZmlsZXMsDQo+PiB3aGljaCB3b3VsZCBjb3JydXB0IHRoZW0gKGdl
dCB0aGVtIG91dCBvZiBzeW5jIHdpdGggdGhlaXIgTWVya2xlIHRyZWVzKS4NCj4+IA0KPj4gQXJl
IHlvdSBzdXJlIHlvdSB3YW50IHRvIG1ha2UgdGhpcyBhICJjb21wYXQiIGZsYWc/DQo+PiANCj4g
DQo+IEkgd2Fzbid0IHN1cmUsIHNvIEknbSBnbGFkIHlvdSBicm91Z2h0IGl0IHVwLiBUaGF0J3Mg
YSBwcmV0dHkgY29tcGVsbGluZw0KPiBhcmd1bWVudCBmb3IgbWFraW5nIGl0IHJvX2NvbW5wYXQs
IGluIG15IG9waW5pb24uIEkgd2FzIGFsc28gd29ycmllZA0KPiBhYm91dCB0aGUgb2xkIGtlcm5l
bCBkZWxldGluZyB0aGUgZmlsZSBhbmQgbGVha2luZyB0aGUgTWVya2xlIGl0ZW1zLg0KPiANCg0K
RGVsZXRpbmcgdGhlIGZpbGUgd2lsbCBhbHNvIGRlbGV0ZSB0aGUgdmVyaXR5IGl0ZW1zLCBvbiBi
b3RoIG9sZCBhbmQgbmV3IGtlcm5lbHMuICBidHJmc190cnVuY2F0ZV9pbm9kZV9pdGVtcygpIGRv
ZXNu4oCZdCBtZXNzIGFyb3VuZC4NCg0KPiBPbiB0aGUgb3RoZXIgaGFuZCwgaXQgZmVlbHMgYSBz
aGFtZSB0byBtYWtlIHRoZSB3aG9sZSBmaWxlIHN5c3RlbSByZWFkDQo+IG9ubHkgb3ZlciAianVz
dCBvbmUgZmlsZSIuDQo+IA0KDQpJIGRvbuKAmXQgZmVlbCByZWFsbHkgc3Ryb25nbHksIGJ1dCBs
ZWFuIHRvd2FyZHMgcmVhZC93cml0ZSBmb3IgdGhpcyByZWFzb24uICBCZWluZyBjb25zaXN0ZW50
IHdpdGggb3RoZXIgaW1wbGVtZW50YXRpb25zIGlzIGltcG9ydGFudCB0aG91Z2guDQoNCj4gRG8g
eW91IGhhdmUgYW55IGdvb2Qgc3RyYXRlZ2llcyBmb3IgZ2V0dGluZyBiYWNrIGEgZmlsZSBzeXN0
ZW0gYWZ0ZXINCj4gY3JlYXRpbmcgc29tZSB2ZXJpdHkgZmlsZXMgYnV0IHRoZW4gcnVubmluZyBh
IGtlcm5lbCB3aXRob3V0IHZlcml0eT8NCj4gDQo+IEkgY291bGQgd3JpdGUgc29tZSB1dGlsaXRp
ZXMgdG8gbGlzdC9kZWxldGUgdmVyaXR5IGZpbGVzIGJlZm9yZSBkb2luZw0KPiB0aGF0IHRyYW5z
aXRpb24/DQo+IA0KPj4+IA0KPj4+IFRoZSBzZWNvbmQgcGF0Y2ggaXMgdGhlIGJ1bGsgb2YgdGhl
IGZzdmVyaXR5IGltcGxlbWVudGF0aW9uLiBJdA0KPj4+IGltcGxlbWVudHMgdGhlIGZzdmVyaXR5
IGludGVyZmFjZSBhbmQgYWRkcyB2ZXJpdHkgY2hlY2tzIGZvciB0aGUgdHlwaWNhbA0KPj4+IGZp
bGUgcmVhZGluZyBjYXNlLg0KPj4+IA0KPj4+IFRoZSB0aGlyZCBwYXRjaCBjbGVhbnMgdXAgdGhl
IGNvcm5lciBjYXNlcyBpbiByZWFkcGFnZSwgY292ZXJpbmcgaW5saW5lDQo+Pj4gZXh0ZW50cywg
cHJlYWxsb2NhdGVkIGV4dGVudHMsIGFuZCBob2xlcy4NCj4+PiANCj4+PiBUaGUgZm91cnRoIHBh
dGNoIGhhbmRsZXMgZGlyZWN0IGlvIG9mIGEgdmVyaXRpZWQgZmlsZSBieSBmYWxsaW5nIGJhY2sg
dG8NCj4+PiBidWZmZXJlZCBpby4NCj4+PiANCj4+PiBUaGUgZmlmdGggcGF0Y2ggYWRkcyBhIGZl
YXR1cmUgZmlsZSBpbiBzeXNmcyBmb3IgdmVyaXR5Lg0KPj4gDQo+PiBJJ20gYWxzbyB3b25kZXJp
bmcgaWYgeW91J3ZlIHRlc3RlZCB1c2luZyB0aGlzIGluIGNvbWJpbmF0aW9uIHdpdGggYnRyZnMN
Cj4+IGNvbXByZXNzaW9uLiAgZjJmcyBhbHNvIHN1cHBvcnRzIGNvbXByZXNzaW9uIGFuZCB2ZXJp
dHkgaW4gY29tYmluYXRpb24sIGFuZA0KPj4gdGhlcmUgaGF2ZSBiZWVuIHNvbWUgcHJvYmxlbXMg
Y2F1c2VkIGJ5IHRoYXQgY29tYmluYXRpb24gbm90IGJlaW5nIHByb3Blcmx5DQo+PiB0ZXN0ZWQu
ICBJdCBzaG91bGQganVzdCB3b3JrIHRob3VnaC4NCj4+IA0KPiANCj4gSSBoYWRuJ3QgdGVzdGVk
IGl0IHdpdGggY29tcHJlc3Npb24geWV0LCBidXQgSSdsbCBkZWZpbml0ZWx5IGRvIHNvLA0KPiBl
c3BlY2lhbGx5IHNpbmNlIGl0IHdhcyBhIHBhaW4gcG9pbnQgYmVmb3JlLiBUaGFua3MgZm9yIHRo
ZSB0aXAuDQoNCkkgZGlkIHRlc3QgdGhlc2UgaW4gdGhlIGluaXRpYWwgaW1wbGVtZW50YXRpb24s
IGJ1dCBtb3JlIGlzIGFsd2F5cyBiZXR0ZXIuICBUaGUgdmVyaXR5IGlzIG9uIHRoZSB1bmNvbXBy
ZXNzZWQgcGFnZXMsIHNvIHRoZSB2ZXJpdHkgcGFzcyBoYXBwZW5zIGFmdGVyIGJ0cmZzIGNyY3Mg
YW5kIGJ0cmZzIGNvbXByZXNzaW9uLg0KDQotY2hyaXMNCg0K
