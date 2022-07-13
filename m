Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38434573A1F
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Jul 2022 17:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236405AbiGMP20 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Jul 2022 11:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236335AbiGMP2Y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Jul 2022 11:28:24 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200F04D15C
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Jul 2022 08:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657726103; x=1689262103;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=KPOnnDcaRWUjQQxPD+UnfKiqkfCXjPjl6LSrC+HiP4s=;
  b=Nsl1zK0hLmG4brO+hFeUGrN06kOf+qCaxdYmsmvU1+93aKMUi7Pd7LVN
   pctlbKXTQVJGLWxoE3nIRCGg1GbNjmgrHtJQDIp6McjShmBQWmBnvkLq8
   D5WzGADnYoefwOlmby8ucqpAp7gWuLcxcN558VXU1NnQ4I+DJjTeuZKLX
   eazMTvFTnvgs9RhK7sg+PhAshSU+2wkZOAbyZpxHeMf5HD8bOfZt3UNKv
   64pxKeiuFwaA4csvjpCu2+JMGNr39+fFIAsYzTdt/HwK6NuyMjv2xXDGB
   QHUfGpegj15+6Q7rB1Ov9AqQctEPRdEo9ksr5/PgYiTkd25kLx4M1mg3v
   w==;
X-IronPort-AV: E=Sophos;i="5.92,267,1650902400"; 
   d="scan'208";a="206304251"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jul 2022 23:28:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KwCDcXrbeApPvz8K1h61N7x6NnVOerzE7Q/TMZlwCmPfbq8p1nJ87Asfunl99fmb0r6zjjWWSgkfqpytrCjys1jE22NI3VKvhxaQ6mq14wlLF7V6Wi5hTMTKzznqxsFUJrrow41lOMsxzHVM/Yb4DLYikKJklG7qnYNUI0PoFmVXJM4w75o2JMrglA22bFAGgW6iiwsw8Je1Q8heNb6q1QPlxkqNCHcxa8a9miM89UxrIYgPNtyounyX8OPSELPHSHlWz5O3Oj4bxXNUrQI6fi55Fi0gKCrOtWhmCwPr6EBcsMeZm5txZPWTn3ZJg7zLAypeHd5gscLM16zjQAU7ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KPOnnDcaRWUjQQxPD+UnfKiqkfCXjPjl6LSrC+HiP4s=;
 b=l2qGbh1PMA4PkbYGBlwJA39qEEATV25pr1zZk6a1zabZxSHlFIfOh0qbuQet/b4Qqi1ankniG18EeAAhbzTY7Lt0HZ3OcA5+eIebw08gNnDdaS67WMRWOi4RK9yegzwy6VDY28t+gNNkDP30XfloP7mdu9Aus19LHyItXRjYc/wSupS+COhED0OWHSkonFvoDAYrXfjL1RdEx96YtY2bddNYqryjFi+dwnjVzh8kIIISm3QrVj8QyfCI8ihJfNdulU3fSKTE/WK/wWzrLea0gVGsGjHsDb8jrV9E8kbMeH8DZ5a8D7NQvxyQvi7h2+zMOoKpTCM0v2GWsyCwd/fiwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KPOnnDcaRWUjQQxPD+UnfKiqkfCXjPjl6LSrC+HiP4s=;
 b=cr+Aw5D2MkEGu4hvEDk099LyCvJZgzDBqPDzPSqHk0XXgGvWtx5YZFQQn2V8gsVRpCo7dQUhwlORQ+t2WzwHkf5itRxgP8OsLZFzYER8Z0Eo/Cxx8ZuuN9cZ+/qb5nIXf82xAVw9aBVr4LL0v6gMCsfCxgLz3tMFgcIiNPgFZ+M=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM5PR04MB1084.namprd04.prod.outlook.com (2603:10b6:4:46::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Wed, 13 Jul
 2022 15:28:20 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d54b:24e1:a45b:ab91]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d54b:24e1:a45b:ab91%9]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 15:28:20 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Lukas Straub <lukasstraub2@web.de>
CC:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: RAID56 discussion related to RST. (Was "Re: [RFC ONLY 0/8] btrfs:
 introduce raid-stripe-tree")
Thread-Topic: RAID56 discussion related to RST. (Was "Re: [RFC ONLY 0/8]
 btrfs: introduce raid-stripe-tree")
Thread-Index: AQHYlqb43VRMNwcKo02MAxAIJIVEbQ==
Date:   Wed, 13 Jul 2022 15:28:20 +0000
Message-ID: <PH0PR04MB74169AEEDF78C8FCBCD30C0E9B899@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1652711187.git.johannes.thumshirn@wdc.com>
 <78daa7e4-7c88-d6c0-ccaa-fb148baf7bc8@gmx.com>
 <PH0PR04MB74164213B5F136059236B78C9B899@PH0PR04MB7416.namprd04.prod.outlook.com>
 <03630cb7-e637-3375-37c6-d0eb8546c958@gmx.com>
 <PH0PR04MB7416D257F7B349FC754E30169B899@PH0PR04MB7416.namprd04.prod.outlook.com>
 <1cf403d4-46a7-b122-96cf-bd1307829e5b@gmx.com>
 <PH0PR04MB741638E2A15F4E106D8A6FAF9B899@PH0PR04MB7416.namprd04.prod.outlook.com>
 <20220713152424.0d93e5fd@gecko>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b09c7e5b-4d10-422d-1e21-08da64e45133
x-ms-traffictypediagnostic: DM5PR04MB1084:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oJ8kMyG809COl/Wag1DvSLY3DybsjZ04xI26lUIgK0ueyEpE7iqFtJ6vlwcfmojfwPDaOaN5bakQpsmAy68c1CRFq9HJFJEF1e7yEvajfXb+J1s4ARt6HGtNCNEB8pKsnQcn3ZTQDa5eFaI0NrG5CAeuPvftq1p7Z1F2aAD01gv9/fkxrb+8pkQ/sZay1OmOF0JYC9GTR/C0AqFLu2jGoOgrqGoqltRicG4YQ8W7LcSADQobCp3ebZhNesBXA0wEEjx6Y061NNvUGkPyGECXJ5BQ1TIZjoPijLhjpYuP24kT89nROwLTNsTxKzHOdSIo2iNEVt4in9mGJpIo5GGEq/hgHq+vnPZzZWpsJuGiEILbuksqBlg1lQ4QeInu98uFfV8b4bWx4MJPfL+xtQcWcLGj8ML/Zq6DlIQwO4PVH2RUnAeNsmiNEn74JOxaOL7oIDsf5ibNcu8G9F1RzlFlp4PZ4L5CzwlI9DBiRNMp5ObL0yo3r1QDcr1P+5mADP0g1KzLitYuTs9YJv+7TPOefz8bvC/wzNtWG4FeBPq+kzj9CJkUBeXi/cJko70wg19PgpI8b7WqsyhZ1S/iNLF2AXIqgPh85l7Lc2uRar4YCMrwgrVbHiwjiJu0BBw7DP8HFS6u7WqrCqLQ5D+4HEzYQHR5/eQdojpF9DrTMb85sjADwg2Blmih3UgraYHEAJgPlN57bdYgDNpaHCSfnE3qjGNNtFcxjNi6Vat5ZkZZooli+wICToHrgb6XTOSa1WNjU2WW1DsewHPTpmjnp+NUajw7MUfxzPA7SQWUQho059KM4Kbr1QETRHyfO+mUFiqpFKNwaPVOd73TyqmCx/8fNYhaTLY8+pEOQXfHrxD/4SA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(54906003)(6916009)(2906002)(966005)(122000001)(38100700002)(55016003)(7696005)(316002)(5660300002)(478600001)(186003)(4744005)(82960400001)(33656002)(52536014)(41300700001)(86362001)(9686003)(71200400001)(66446008)(76116006)(83380400001)(66946007)(66476007)(66556008)(64756008)(8676002)(91956017)(38070700005)(6506007)(53546011)(8936002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?84SEZKjl01QEMQlKWPUVQcZ4gwJTRB/Nld1vRQjEHv0VSgoxBS4XwAJn6nlc?=
 =?us-ascii?Q?y2QubeWLdo16JP23FuNeamr+iraxGZeB9rsPvgfERh4wG9on+dhAmhEekfaH?=
 =?us-ascii?Q?XScdNAMT5R0+xgTNWVMJ7MJ+59FeS7Z5G02FqGZc3usgT2m/YCrfZKj2mSAV?=
 =?us-ascii?Q?VBgmNWxAvzAQjLaR3ccj3sw5R2deuQwAanD/UGJBalZ3DoQsULCB29D5AIJI?=
 =?us-ascii?Q?RGRgwHGuJbXFHeI+A7Q9bL0nV7N/PDDwfGrPPTmhZq/g/lZ7I1IssF8rXkWP?=
 =?us-ascii?Q?skZ6vNY8nRtH2TekIeWRdzjTjgtwe2w2330xhB2S3TE5xK1cIzPLbmj9SQmQ?=
 =?us-ascii?Q?qczVTtwNTOPBnF14zldgt6Rd1OLTPGY4HMDIXlnS2GzTQW8i5jIV1UuNj7em?=
 =?us-ascii?Q?9zbN47bCEhmg7Qase5fovNgNzCpSIYx2S2afoY8WQeCbvUOB1Gm4jcPRJPns?=
 =?us-ascii?Q?lKoJgzePbnJNvP++sV3f37jz85iShPXID+anm3U9/yUVZQrdNMVjiVOmoeVt?=
 =?us-ascii?Q?WM8JdIGtpTp6C6jGQ1L0nFf0EFzsiAKYN6Frzj1JENo18gN/bRzn4QKEmn2a?=
 =?us-ascii?Q?lcvXedABmtHdKsvquw1pz/BOxIBGovo3gL15ceUHsVWQhNRyomEAf7WmlRBl?=
 =?us-ascii?Q?OgKon3lCCaogYK+/P/fxHULyj5Y9dMcNj5DI7VgE7qNhsarsY9XQQ3C7IUcF?=
 =?us-ascii?Q?XqIAhPrtPdawUZmvGA5PM6bH0CBLYtbYDNnqZdN/EIyQK9toyxWSUIpUeZBd?=
 =?us-ascii?Q?PbKQB+DmtPov0tqjU32XHQDoJw6LJfnUFx2tqXGEwSrT/3xBySo5AzHocLt5?=
 =?us-ascii?Q?KOpKArw9JPIMtozlWtpJlQs46724eo/X3T6Fy+We/1E64gnY9SiZx9tYHI1d?=
 =?us-ascii?Q?ZqWO+S+W/RjCvLfAnyEk/iT6qVQqFRrDatObC89Q+hOJ+TRSDq09vKKYxl5+?=
 =?us-ascii?Q?g386752HnwEq/bCQX0fXRpmaAV2/wDhcDvXYbBeESaeAJ2pnUtEhvZXTZ5n3?=
 =?us-ascii?Q?MrQEc99i/ZNob0+ayjDMsoOFYcItNgE24K990VpyajWXJPjLGLTu5gEzbPmR?=
 =?us-ascii?Q?oWCRidGofOd33R4PzTMn4/GBwZPcSDz1CyErrYUKXVkb+svDDK87EIUr7yEE?=
 =?us-ascii?Q?Wa0fed9PYG4pOh/wdoJjb8WC/Oi8w9OOl23+4ZsMAHVqAk1r4hNUy6GGNPr3?=
 =?us-ascii?Q?BwB/dtFqVq404fvx/sPEtr/smpfr0sM66c+xpWswm+Dr+3wm13Mh1oN6qmg3?=
 =?us-ascii?Q?JCDjWjo6Xq9rsRIM/HZwcG+rFY6ro+PgotdRH+Y+ZaC7H4O7LnJWAT7++F1w?=
 =?us-ascii?Q?CWvxYScDLYqXBkh9uMums4R0TU1t0L8Lm1TO7/7BC3Pu3iyy8aEJVm4v0c2n?=
 =?us-ascii?Q?c4L+MdCesGZBVf6VMAKpNBhjmJDnld1HNyQHRr7a7Qo6oAI7AREnSM6CGCN/?=
 =?us-ascii?Q?t2hyRdZTiaDw3A5fe6bdtpNdziFSugFXZZbMdSoMGG0cH5HM6r1fAX87wTao?=
 =?us-ascii?Q?dJwhQrrzRmkZ79akYKMNCqOwrNG1QqNsUgdWolh0oKsHBs0IDeOOK5+YdIRo?=
 =?us-ascii?Q?Ok2JP0fzGe/tar3a5EmNnAkassFna0mpetpc/Lk7tk/YvZD4yNiaKmlWivXN?=
 =?us-ascii?Q?3FG5yLSVUJXBXqM2HpwDZNP5tsm0vANJB8IbA1SoZQGzDyQeubio8CpX6In+?=
 =?us-ascii?Q?tTaIANhrgr6rkTjQKN9FWO1UzJA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b09c7e5b-4d10-422d-1e21-08da64e45133
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2022 15:28:20.3659
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: obdPL+Ls7OUuBF9ehGbt9OMfX2YICn2qWsRQ2tSPgN2VQQKQWAD4lejnOqsEHiCELgFRokWxITaEXIjIh4qF/Q+ZiUuvQsbcHVbcOvh+8Gg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB1084
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 13.07.22 17:25, Lukas Straub wrote:=0A=
> =0A=
> Have you considered variable stripe size? I believe ZFS does this.=0A=
> Should be easy for raid5 since it's just xor, not sure for raid6.=0A=
> =0A=
> PS: ZFS seems to do variable-_width_ stripes=0A=
> https://pthree.org/2012/12/05/zfs-administration-part-ii-raidz/=0A=
=0A=
I did and coincidentally we have been talking about it just 5 minutes=0A=
ago and both David and Chris aren't very fond of the idea.=0A=
