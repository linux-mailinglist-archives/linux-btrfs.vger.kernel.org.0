Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74E8A585E2E
	for <lists+linux-btrfs@lfdr.de>; Sun, 31 Jul 2022 10:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbiGaIkL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 31 Jul 2022 04:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiGaIkK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 31 Jul 2022 04:40:10 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-oln040092069091.outbound.protection.outlook.com [40.92.69.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB3A259
        for <linux-btrfs@vger.kernel.org>; Sun, 31 Jul 2022 01:40:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l8A1zZygqY/CRiT4+wTJMFk7GAafgBVMWNgkl8rQRKb/rmB1SPpWU7YaEjtRaSElbDA+xbl5iWTYiV12gSkQDGXEyhVgM47jw1p7N1CwA493g3c59RulfGtROO4xxVJ1gtp7rAFyFJPi+UzHsgllE9WtI0cQRrfy1DJYZhotTojHVeycsfTpSNgsgGSnw9wdG7sNSaESVz2cAVNixm2DEMiu96hDHAD2zBaGRFhs6JOamCIEtRYZ5y7ccQPvQwSKydBbqq0BBhSBerztyJcPjaLFBCtP5kGUjBxsUd3prTATqjjDf9tTZOFM30CSjRtGLCaVrg89ywtcKNUD5O+WdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vlQmOdRY7oUq9hlPiPO9R1cXl3P46n7Sf638obu7DY8=;
 b=deUkoBnm7c3xwb857k+hvZp4saVr+Y6xr3C6UjzNMtZBHjYfbU1Eunud8lFBMvh+pNLy5MjtRjOirO+0QqMn7mk3ZfDTKXL3nUWT0iF1kYe9rbRSAi3i/af3QQqfaj4spB/HBZXI/mWEwSszV2haEVNPLFbtBLz3sznfhgec76K2h/Nf3X/3ypr/jWCL6+CU94T8q12qkdQpnDpA1LkZgf6kJAo4A669dEPCSJA2FXq7aADeIVpd0jkZes5shf0Fe/uFjz59dL5BdGQ3pji0bCfH+cyYzo8xUieJ/xZ3gHSgGo+AYtEgjPy4vtpU4anyHnGOT8pEYbLVQdimWiMaZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vlQmOdRY7oUq9hlPiPO9R1cXl3P46n7Sf638obu7DY8=;
 b=lC4HNMFHvzvM6zatHe6kp+9Aa0e7jeLkD+CB37SIWfDns39KgYoRJBll9Eeh6prSzjBrBCSOgw0pSYAQ4F445FdttJ1Acvw23UG5F/MYDrE4kke4x1euGvcvoXceWw/fOo//aWoKZ2oivPkjCqIM1XSrho9/xZJMX+CBXKmikJfC59T7CF0SMKVG1QSBhFhq5HKE7Y6eQTyBU6VcDCG5BF2LOMkUaONk8vRMvEdT8zZ/8TvTOak0nI90ktVzwY/kffolqBm4KHCp3Jpy8R/9T1X1kgpT7KRJ9OzeQLO0/gmR/bdrjEn9QxEJynbef0sOBXIG1/a+OYO3KklCUhL09g==
Received: from DB9P192MB1195.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:29f::21)
 by AM7P192MB0803.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:14f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.10; Sun, 31 Jul
 2022 08:40:05 +0000
Received: from DB9P192MB1195.EURP192.PROD.OUTLOOK.COM
 ([fe80::796c:df27:1508:58e5]) by DB9P192MB1195.EURP192.PROD.OUTLOOK.COM
 ([fe80::796c:df27:1508:58e5%8]) with mapi id 15.20.5482.015; Sun, 31 Jul 2022
 08:40:05 +0000
From:   Martin Edelius <martin.edelius@outlook.com>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: "parent transid verify failed" on raid5 array
Thread-Topic: "parent transid verify failed" on raid5 array
Thread-Index: AdiktAWlp735W6lMS1yLNYDL/IgFHA==
Date:   Sun, 31 Jul 2022 08:40:05 +0000
Message-ID: <DB9P192MB119500EDD9CD8A59B250AFE7989B9@DB9P192MB1195.EURP192.PROD.OUTLOOK.COM>
Accept-Language: sv-SE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_ecca9737-3fb7-4a23-a452-5fd2dddae788_ActionId=33eff7cd-48fd-413f-abea-a1ba2dd7956e;MSIP_Label_ecca9737-3fb7-4a23-a452-5fd2dddae788_ContentBits=0;MSIP_Label_ecca9737-3fb7-4a23-a452-5fd2dddae788_Enabled=true;MSIP_Label_ecca9737-3fb7-4a23-a452-5fd2dddae788_Method=Standard;MSIP_Label_ecca9737-3fb7-4a23-a452-5fd2dddae788_Name=Internal;MSIP_Label_ecca9737-3fb7-4a23-a452-5fd2dddae788_SetDate=2022-07-31T08:01:54Z;MSIP_Label_ecca9737-3fb7-4a23-a452-5fd2dddae788_SiteId=76431109-ff89-42c2-8781-a07ca07a2d57;
x-tmn:  [gIAq3oOOkFIu4R20Gj+NLi+bxIQpUaQW]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 23ab4bb4-488a-414a-0df4-08da72d044b1
x-ms-traffictypediagnostic: AM7P192MB0803:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WDMBOtGletPf6EZbQ1rKf6qaIF5uLhgiMjfKEu4V8OALD9PFC9QADGzc5bcQayDbcy34P7Cdf+ixfopIFX1yCuPpKT/e23U44W3RPWZ9+aLEP2A/pwvYeNCXpc2pgbZs5fPKeoS+FlQsamyfEdLyzf3hijqX+tt6t4TZG0IuFxfhde5q3GiiFAgthpvaDICPEg3JRFjzR31nyKzJR7s/gEAbjzv6OxA2sdeSg5KqOUies5CUf01HmsNEZ1FumuUl5eFOwbeo5kP9WtzMyFepdhWA9KOhYL9NhcmdRpZMhN0jL+ARVOPFAwdp5H3N9M8mhbFw83frbkdQB9MyguuaArHrVgwBZGqqhvAlCvdCSBnaif0oTciqV0wi+H+A2tLyXQhbynqo6V1COgRoMtSHsSV00lLYBiCv60zjrTiMskddj3UOGIRR+2AQfo4OrKvUYTH8SHBlV/mPe19Z8s5Pe3UcRwdKYBO+pgStgmJVFmh4iv8l0ZLld0nujVeN9XfwgpUEQQOYjd2jIrbhoSAR8pHTxKv2HtTupjM2spC72VQmNNtfDo2RRBl8poM1PMX2T2/a6IDiWapA2sMZZVqbThs+LM8wdKHICVcVyH7RsDDrpJyKt5dXN8ivfeeM5E5B
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?P2lg6Yudhp/UJuYCueemqzHBY3KAChRkaPKPbuVGjbIQlstvDMwJ0CXwE+7q?=
 =?us-ascii?Q?BHoQ5KGM8DIvgCFQj/+3JAtCETfHZAz+Dcp4esWs6lHjKlxpsvU5pu01f0vr?=
 =?us-ascii?Q?OhH6j2VZf/e6xosyCPEbr6hhj5R9Uk0hY3ztAFsOrWpRpB1Y7v/oFyxFIbju?=
 =?us-ascii?Q?OYnmp++PJB/lSoIBN+eQG8sr6VlMZ9znruGHPrMG19ITFUYlVAgZ3jfbzt3s?=
 =?us-ascii?Q?UMgZx9wvjCukS/PqA1lzKgyJCT0ng2x8gf49E6qldMRVYlEui0fmG9PXEOJ+?=
 =?us-ascii?Q?t6mmDIwEaJFYc9sOiHIEWms2LHV6eyOBRVAQ/VZTf2TXlidieS697DJJpjX0?=
 =?us-ascii?Q?ARlZPCsnTkz11DhRbH/xe/jAhbIoOI1onY0CxAOCZvo6vu4iB0TnXu1SoJEl?=
 =?us-ascii?Q?U1BqYSBaCEuf0ki1GnONJ2HdUb9vTZSifJX6gVHUnv+po7Btvz3HWJc63OvI?=
 =?us-ascii?Q?ndZ4u6VOAXs/XB0jmwe429BSBMdlTw1qMbO+3GFm3IpifLpB+7YdRPlQop0v?=
 =?us-ascii?Q?45wTamddi69I51CaFANAh8IO5u7b2WkSCZ6LSigtSaOeVJkZt5jUFmORbodZ?=
 =?us-ascii?Q?oRsn0cCczKPVmTAW5BCSaY6bZS8RvpmJu3MkwvK5Ic+p3W60E3M6eR0YsjEQ?=
 =?us-ascii?Q?HAfxO41ox6ki2DteReMFE3xbrWpJr348enPwk3lWq2JWd5nhuB9gDQzLX9I5?=
 =?us-ascii?Q?6/Q4AJ2mgO7w5aptSuXpqGKSiA7Zwli+cRg6VXhzAu3YxksFkIGzmzdq+Ru+?=
 =?us-ascii?Q?8bnPXcC7BFtTfzdRjlQAljTeeys369oIIWvH2FIhHN8R1o2wffPMx6vjQgBv?=
 =?us-ascii?Q?7Yonf8uoiTxXxJTQ/DER+1P+FJZbYLjx1I+vuJlq9IMviryRnAnd8tc1GKD/?=
 =?us-ascii?Q?xY+jS1mDb8QUUQ1I9UMb3s/58M2POUDnUvBnkeUT+acjWP/Ei4sQdi98Rh0M?=
 =?us-ascii?Q?aeYLj3a6F4p6VlZHLPxemdu7+XgOGbigG0CcmRggDrzrMWl4AEhzm2W5vwm5?=
 =?us-ascii?Q?PlPBHoa+Uu8SglaatPon/QHFTalgUx5nxLZH9c+oHg2jFMHYbVeFitB4UykN?=
 =?us-ascii?Q?a+t3356psRMskG08i9aI6gsMm26hoM3w9bJ3otu+jVSO4PE4oTS/57HaH4QZ?=
 =?us-ascii?Q?lF1vVRVEFCytp7VXm8dua2+BrGVE+bIM8rjzNlrwieZ3f+kzDXILmRdfMmH2?=
 =?us-ascii?Q?JCBqFSSkflUFUeTX1p91VQPBeKT2M4b9ivlwrvW/mRCXD9zeiGvtl50zqeAK?=
 =?us-ascii?Q?G0k7MX7j2YeZQ+Z5alhPIQqeInzoXoccVw6c77lPqQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9P192MB1195.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 23ab4bb4-488a-414a-0df4-08da72d044b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2022 08:40:05.7408
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7P192MB0803
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi all!

I've been looking around for a solution to my problematic raid5 array and a=
lthough there's quite a bit of useful information I also see the advice to =
not try and fix this error myself and instead consult this mailing list. (A=
s a side note, I did search this list for a potential fix but got 3000+ res=
ults so I resorted to starting a new thread.)

I was away for a couple of days and came home to this problem so I'm not en=
tirely sure what happened. As there are no signs of power outages my guess =
is that it's just a faulty disk (/dev/sdb). The SMART info says that it's b=
een online for a little over a year so IMHO it should last a lot longer but=
 I guess it didn't.

I'm running the Rockstor NAS and do my best to keep everything updated on a=
 regular basis.

So far I've only tried mounting the filesystem as degraded and read-only (a=
nd with the usebackuproot option as a sort of last resort) but keep getting=
 the same error:
mount: /mnt2: wrong fs type, bad option, bad superblock on /dev/sdb, missin=
g codepage or helper program, or other error.

I have other disks I can swap in but I've had mixed results previously (whe=
n the array broke the first time) using the recommended commands (btrfs rep=
lace for example) and I have data on this array I haven't backed up yet (ro=
okie mistake, I know) so I'd rather ask you for guidance before I start pot=
entially making things worse. :)

Here's the info requested:

Rockstor:/mnt2 # uname -a
Linux Rockstor 5.3.18-lp152.106-default #1 SMP Mon Nov 22 08:38:17 UTC 2021=
 (52078fe) x86_64 x86_64 x86_64 GNU/Linux

Rockstor:/mnt2 # btrfs --version
btrfs-progs v4.19.1

Rockstor:/mnt2 # btrfs fi show
Label: 'ROOT'  uuid: cd444c07-dfe0-4813-9a71-6833c48d1cab
        Total devices 1 FS bytes used 5.32GiB
        devid    1 size 109.75GiB used 8.80GiB path /dev/sda4

Label: 'SDD'  uuid: 3d0e1b45-666a-46c6-9c83-e2f16a73b79e
        Total devices 4 FS bytes used 257.92GiB
        devid    1 size 465.76GiB used 89.00GiB path /dev/sdc
        devid    2 size 465.76GiB used 89.00GiB path /dev/sdi
        devid    3 size 465.76GiB used 89.00GiB path /dev/sdh
        devid    4 size 465.76GiB used 89.00GiB path /dev/sdd

Label: 'HDD'  uuid: 0aae387e-2847-44a5-8db7-0635421d80af
        Total devices 8 FS bytes used 11.41TiB
        devid    1 size 2.73TiB used 1.64TiB path /dev/sdb
        devid    2 size 2.73TiB used 1.64TiB path /dev/sdj
        devid    3 size 1.82TiB used 1.64TiB path /dev/sdl
        devid    4 size 1.82TiB used 1.64TiB path /dev/sdg
        devid    5 size 3.64TiB used 1.64TiB path /dev/sdf
        devid    6 size 3.64TiB used 1.64TiB path /dev/sde
        devid    7 size 3.64TiB used 1.64TiB path /dev/sdm
        devid    8 size 3.64TiB used 1.64TiB path /dev/sdk

Rockstor:/mnt2 # btrfs fi df /mnt2
Data, single: total=3D8.54GiB, used=3D5.22GiB
System, single: total=3D32.00MiB, used=3D16.00KiB
Metadata, single: total=3D232.00MiB, used=3D100.03MiB
GlobalReserve, single: total=3D13.61MiB, used=3D0.00B

The dmesg log is approximately 258 kb so I placed it in my OneDrive instead=
: https://1drv.ms/u/s!AsKRbODiURBmrMdN3oEHLQqlLqxujA?e=3DOIo05V (let me kno=
w if you want me to provide it through some other means).

Thanks.


Brg,
Martin

