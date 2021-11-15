Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82460450391
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Nov 2021 12:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbhKOLiv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Nov 2021 06:38:51 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:32972 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbhKOLiH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Nov 2021 06:38:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1636976112; x=1668512112;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=R/SJz64dxgkcf9StrT2HWccLSB1mDl1dCZ/sUx/6Z5M=;
  b=eTt/52O7OdSYfHYCaHy3Pva8Gpx8589i3i21aEIK3OEZueoWI6a6vOdl
   AcR9LHR40wFCWgd22uabrzqjqIOWYdvtTZcHX01mdTzcAOfF6kB9QkRlp
   snuLqflUp8K3H/YDGW0XHbiusKBopVGJ9oZFsDJnsJuLBO7V1iEcLAqgO
   /odCMM10y17c8Z9+D6TJpUFAHTOYrLXB2uSuWqRx0x8lIDSZYaoKKF8FA
   RXWYJLpkMhB56DpK3Cv2okb7KMG8XfR/qv1Wy0A/Z2r/1tO4D/NT2thIs
   4Fczk6hKeLjpG+FFiAFM4Il6wFTaVGaJ5BeYMuhAwEftNtqc+EWuLuRH2
   g==;
X-IronPort-AV: E=Sophos;i="5.87,236,1631548800"; 
   d="scan'208";a="289560432"
Received: from mail-bn7nam10lp2104.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.104])
  by ob1.hgst.iphmx.com with ESMTP; 15 Nov 2021 19:34:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fjxkjcre6KyvGx2nJdJ8/Uz7Cwy/dyuFQ5RhZHxhoyAAL84vlJ6LssamUW2HsTeSVSqZowfZKtZbO4bky6fuZ1A/Nahi96H4x+AgKqz+xvBSdfps+k7SZ7SYMTAlDS9hsv5x8DB8jFHaH/5SVJ9Tg5ydk0UYRSq21nLNnbg0cgcycUdERNon2YQ/LZjVpZ/m6pbCrXY8OCZc5WN7vFBIGeinLEaDD7u5NwHrqgNT7L97R6VopcGMzSc5r7ThlIdoI//5YQekUpICg4qUe3dsdeX8ix8m0+HK0ZKF1KCkGNRBBC8SDzTxhN+va4mWl7OMTnB6upIN/nCq7mOT1ivu7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hcz5rbJ/0VJ3xen9myBmg2Wz3A/5eWhEliPEQNMENyk=;
 b=Ydfr2Ijl2tyKn0IbCHJCOzJO7oWL8EWgT7FWXtW0CmHn2ma8jONH9DWy40ZilSYhgNhM8fe3ODlEz9oQC1mvUuMv1saF0WGwM5g5Y+ybdCuGi1U5CG6W9I36SiFqGxO9usZvGuM9TbTTU1cHVDi9I79lDeGyzPIEf2CsbsnojxpxrwowjZnWF+yK5wrMXJ99RdyU0kcefSneknUiJGH3lYNiiuBNkDP+MoY7yv1X8/H7Jdxy0jas8jIzTG3thwRlbVO2Tei6j/W9ExEyYA4gq0Z08T7hu93Pakhx64urNRtRHmyUCs3SIHjArIQBBGo5cK9z1fBSvj5CyFEMuTIjDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hcz5rbJ/0VJ3xen9myBmg2Wz3A/5eWhEliPEQNMENyk=;
 b=k2NHwfF3Xu9aIDnSdsq8PFhwZr+O406ivXtNENVMzCkCiH6TQctzdSQCTZSiS8XA0Uzrgsix6MuBWcs8kLngiQZYZAqJDfEy6xTDmcdU96xCflwpN+ArEJshIKBGvjQPzPg/jxvJhVKPbF7E8fibuXMSEv77inQczmJ597zBWxs=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7221.namprd04.prod.outlook.com (2603:10b6:510:17::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16; Mon, 15 Nov
 2021 11:34:24 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3418:fa40:16a4:6e0c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3418:fa40:16a4:6e0c%3]) with mapi id 15.20.4690.027; Mon, 15 Nov 2021
 11:34:24 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH] fstests: detect btrfs compression and disable certain
 tests
Thread-Topic: [PATCH] fstests: detect btrfs compression and disable certain
 tests
Thread-Index: AQHX1+oCKNB1i8rq50mGpr9HN69JRQ==
Date:   Mon, 15 Nov 2021 11:34:24 +0000
Message-ID: <PH0PR04MB7416B864F4F7FE9B6B6E39989B989@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <f2b314338ecd06ae734ff0f0537f0cdf247db8f6.1636737764.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b89a9de5-8e65-42ae-2232-08d9a82be01d
x-ms-traffictypediagnostic: PH0PR04MB7221:
x-microsoft-antispam-prvs: <PH0PR04MB7221A4C7676227D339EE4C9B9B989@PH0PR04MB7221.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7F7cSN/cyyWNa3KCYQofdylPt9CdE7bOEPslYuUwIJ2rDFURciXj3optUh/c0CbjU6lhDetyNqAPdwtszKH2/37PhN0IjLC7y/aXiPWIEiCquoPrUInqv/sVEfFNhhgcNEQ1otPzQ2yf0t+07RnbkDidcLMMt3LMEojLzbWwC3Dsu71sJJJUXYMr9UksA8C5stKkCCSv9Nnjb9C4ofhn0GUM51FBU9ifI6PwMBDX/PZnJkhDqfdwWp+hXHRtQBsVGaDCuRK9L2lBEJ9gLOkeGRQfKzQTt5DY8kTeIIcKYnkNVRfWsPqR8mNwPPhuoW9G/RMNxWyjXaMPQtWB40z8DmiVVCuUwkxnQODaQljAdK7hNI78tieO9SEZiopCgqKo6gl7MpEce9k9e2JXTJXVavKoPv+tqZZ4dxsWb1jwzY/U1eC6ydJXHkLP2qNzPjVCW2hQk4iQ5Y0uwsc7Yo8QlDutoUmwzhAj1flWUm3Mr/hzA1bKt9A+q3K7JxtRr8pfK+D2ArcROSE/5JwqeMYqeRrYWoZ/fDzoXHhkEeIJ+9pidDApDhfi6cnC7ntf63if7Fm+4y36CQ+gAVPeR1ifIPtjr2ujGJcKvgbdF23fCmi6cwYU2kmzGCoUrTvy2z9ynmXCeZpwpr6LL2qD2V3E0n0kbgCrWtqCN7PjtKwWPWH8DylmxbXC4dj6icF5rv1N9sc5Drmr8wsdkBsdeGDhwQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(508600001)(76116006)(7696005)(64756008)(91956017)(53546011)(6506007)(66446008)(4744005)(316002)(66946007)(52536014)(2906002)(5660300002)(66556008)(33656002)(186003)(110136005)(83380400001)(9686003)(38100700002)(122000001)(55016002)(71200400001)(86362001)(8936002)(38070700005)(8676002)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Toov7AachjS/T62KIvHpxHVbtORACL3Uyp+5OQyJ6Pb27gruu4obgofOArJw?=
 =?us-ascii?Q?0c4IS8OsVkSXEKfxaWwfI0jEPOuyMurfslLHrfMOYjk6VWpUQxOwMPxttOEJ?=
 =?us-ascii?Q?iMv/qcnS88sp6aou+Y+OMXXS8IubUL9qPqpy6kv98u7EVOmH3mRw+Dg17uDU?=
 =?us-ascii?Q?55Rn2lw0cmCwVLVb7vnMaBdFKRlGQ2K/2VqWmof/4qOK3TyQRb055HV85qmU?=
 =?us-ascii?Q?wLeYno6qdv7eIR/+PP1kiMkIjKY4u0Qfb+gj/QK+O/SknPdYDIPQB2+4+r4L?=
 =?us-ascii?Q?4P1w/fPV09O7UKSxOeDPpc2L/rG99c1kNcm4taW61pLtNzwXVIjXs3nJquy3?=
 =?us-ascii?Q?H/wdvNuk3Ztos9usR2wTFyiBNv5C3yA0e8yt+e9RZG3BMCr4z3pzabk87rXH?=
 =?us-ascii?Q?ORvJ/BnXBB2+vBIuxYTEQ0x/EFxj2M+BjbMlX0UTYJ1s/tU3tIjaKDMd0S5+?=
 =?us-ascii?Q?9WnDb7ChDOxU3GyaD418o37HRU76hgJ0/O6wdw/jlKFZub5d1gWJdDbM0Q6K?=
 =?us-ascii?Q?+hKdICtg6LbOpsnB8t/Bcl/Tmh59nYUD9/ny6yOS8MoJ5XKlLhMZLDIBo/ql?=
 =?us-ascii?Q?6Ycv+6SLanvGiU1VnqGW+67FlAgLJVmRg9qOm8xHY7jCQXwlO0Xk/unsEtX0?=
 =?us-ascii?Q?am6MPlsFov8MqkZjpBQ/83xkjHJUp57FIjStESxC2RnNd6rv6xQdsMqSkubr?=
 =?us-ascii?Q?RQK+tDtSvgtrU80ePzn/JuxSvvNUpBv2bx/IL40Ui7c5Dx+7OQ/7awkFApiU?=
 =?us-ascii?Q?gr6xRtBSpC0iGu+8zAx0etq1VPVXaF/Iih6+Ot/SmnPL1XaavIElFWa4V0wT?=
 =?us-ascii?Q?/QnHoli/sFYZemOlzV5Uei4jw2kvrfrPxzrbIheumLFmhuM2NvTe49sE94t3?=
 =?us-ascii?Q?TNuPq/qwl0dB9tQgghRL0y053mbl+RVBkx9PVobDn6jpIj0yPfR5oIoSO9IA?=
 =?us-ascii?Q?onqfYhNiTZQNqvE9TlBOGCPrDF1ACYXea3a5poBIyVqwOyy1a+DgxpBEeV+5?=
 =?us-ascii?Q?abjW8qns7SpdxojqNmyVyWdhnFtqQKqVgVTzzW946pI1DJguHyNVeaGmRAhV?=
 =?us-ascii?Q?af00ukxCmqWV+aDVG15BRod9Qhm1M2u+CsFyV7FbPu6XMvwG5EvCfOdEHcGz?=
 =?us-ascii?Q?yXqqH40pNPOornUXCIZVijGsF29EMxX3c2Vv+HDi7dHKh+f/VYAF/hfcySff?=
 =?us-ascii?Q?ESShDh7St89JjXUQ6T0XtFvCjRLKmC1TZPyjCVFrSL/pguDtJwpzvoK99ypm?=
 =?us-ascii?Q?QtM2Hx5TtDiYZlpa+2RiL+aStASC+y7uaWemWyxj705DREwJhm/ulEh9d8MJ?=
 =?us-ascii?Q?7Q2QlC0N+vrdZjDN5Ykqr7Yk8gfTX9ElJmhynGaS0OrAmrKY5grgs84yU7R6?=
 =?us-ascii?Q?hBFgZnS218U1sQClZeNnJg+7M5ADrB1+jC/XfoV5RMppT4cLOcYGv3k3ul71?=
 =?us-ascii?Q?/N74FcXGUSSTBzva6svg4bBJgKNOLoa/+7C1d0H2bWodR5GFELdM3r4U8JPg?=
 =?us-ascii?Q?YyMBcwZCi2Y5CRESkpVT9AldNkuqNhyu6hUhWwbpzarBhNtSJzFDcRsEV/DY?=
 =?us-ascii?Q?Sy3rXZLGE8i1J1yqeaghIe3zFaYFnXPlQUDZCjG0krMpKNeNsP3BllcD3I/T?=
 =?us-ascii?Q?ffQ+j2niozGHUKCI+xRBafUZwdBDjGzZqHYd4CbGSvaqn+UUHUw5MD3NndeI?=
 =?us-ascii?Q?eIpeUOu0gGQlfREZeP3b3x++Fd+JLO7AHiRVxEekXX7wJhAUZKprQVEjSHoq?=
 =?us-ascii?Q?iee9q+syhMolcX4GOJOcVqHwgwj60DA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b89a9de5-8e65-42ae-2232-08d9a82be01d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2021 11:34:24.5247
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sDKlXuEAegtcmKv4YjodjkV+N0v/W3QkP/SqVPhJfRGTQoFuJsLdvfJ98XJQGy1IfKwYOHeytrt6+H0LvXOX9CRV3iFdNoxR8Xaza7++/Mc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7221
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/11/2021 18:23, Josef Bacik wrote:=0A=
> Our nightly xfstests runs exposed a set of tests that always fail if we=
=0A=
> have compression enabled.  This is because compression obviously messes=
=0A=
> with the amount of data space allocated on disk, and these tests are=0A=
> testing either that quota is doing the correct thing, or that we're able=
=0A=
> to completely fill the file system.=0A=
> =0A=
> Add a helper to check to see if we have any of our compression related=0A=
> mount options set and simply _not_run for these specific tests.=0A=
> =0A=
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>=0A=
> ---=0A=
>  common/btrfs      | 10 ++++++++++=0A=
>  tests/btrfs/126   |  4 ++++=0A=
>  tests/btrfs/139   |  4 ++++=0A=
>  tests/btrfs/230   |  4 ++++=0A=
>  tests/btrfs/232   |  4 ++++=0A=
>  tests/generic/275 |  4 ++++=0A=
>  tests/generic/427 |  4 ++++=0A=
>  7 files changed, 34 insertions(+)=0A=
=0A=
btrfs/237 will also need this check I think.=0A=
