Return-Path: <linux-btrfs+bounces-2330-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 650BB8517A3
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Feb 2024 16:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89E971C219FB
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Feb 2024 15:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380D23C46E;
	Mon, 12 Feb 2024 15:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="as1hrd6L"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349303B797
	for <linux-btrfs@vger.kernel.org>; Mon, 12 Feb 2024 15:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707750480; cv=fail; b=jJVkp8QwoyTuyzyOswddL8j6wfDcAT9bvYMPlzYt7Q2uC31ukl6u8Xp0/D9TtpbEhwrPRQAZUKlovB5mBDb09lwACWLIQ22dwHnJEH3Z07NqmKmLI83bFKR0qVlW4pQA+u21gJkvYyFLM1tUSobGwOn1cjFjHofM26+ZZM9va+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707750480; c=relaxed/simple;
	bh=OASL9Bvy/BOYmp7dxfuqEx7IEsoAzTpyw+Z8lrXBgOg=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=PPPIdLUUF76C6/GwrZYeHCZJr6Z8B4VAEaH1EBFwuvo4xwq94Q42jpuW/VqLHVDSRnpJkF/dFRFiG4RUzrf2EAcGPNikH0g3s0G5dtF7HewpHwLfjkrkTopV7ufLu4i5SLO2sF9LMOSQxJ+lyOV9m4oVS2UIGVbUEv6TYxR5/8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=as1hrd6L; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707750478; x=1739286478;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OASL9Bvy/BOYmp7dxfuqEx7IEsoAzTpyw+Z8lrXBgOg=;
  b=as1hrd6LoEX62rbeRnb+ktqa3l3S1STvbC/80NUQlB2AzMPgE9oLp06+
   dD7DNT6YlaSc4R4EW5sBjXZdQP271roDy3lkIUwZIGuwQOVXb/eEQLWoM
   wWYu50PIiTS86C8M94lMnqn+Vnwn1WwhuJymI/KtY156Uv5JXvUSadsB+
   b9O5RuCRLiRaWgr9h8TwtDkPnfkI1WKiGu2UKoB8au50eN2ImjQjdOvMG
   CQs/ClLrfEUlYfxt5sd/QiAZkJaZtEXPaDEBLecnTDesB38i/iGxsNtCe
   LMS0UsJe+Zs51Ti4NVpp4S9+U3gZsQ/wYC0gv/7AdZl+AQyPqx/VBhSRO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="24198518"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="24198518"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP; 12 Feb 2024 07:07:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="2908081"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Feb 2024 07:07:56 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 12 Feb 2024 07:07:56 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 12 Feb 2024 07:05:25 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 12 Feb 2024 07:05:25 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 12 Feb 2024 07:04:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cVJ2KcZcjfrl/fnZ+AajbeA/eLM9ho5tsxsLM8qfy0Om+vsEw61qEBMlGj/xK+rY/da/QNJHANNeYIetSGPSr9sIR0UllTi2+9lVLFTbbHhQ1ec1IK323wqbdZjidSL7Yjqgb57yLANleb1lY+bvowt0YjpI0DZ0dPKv44U2yvO30tzACQWdFwcL1F1xex4+5RzVzrln2L53uWYoB4Q5VcE1np8v0sMLwPVu8J6cvV/fagBLLtdkW1p5ZXjVTdVyIqD2QOvFjfwNef62XLrGtwGQ2qQ3GvNchlZ++UnWrb4b0xLR5OFxBEdFvzIl8H5ITBp1hdryuMGVkBsd382kWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Of3yfV7V2V0c+0yHPqSkcpDvYQggNAfPvEvs1ui9BRI=;
 b=Qt1UGXMyaea1tjx9c491F2+FANcOPPdKUtwm0t5N/uR6cXmS7V4Nky8IOR4Ml8nPu388DOEWlB//cuJp+aJlPR6w2w0tKrc6bwScGnn+tTPS6Y6MNUnNvQfQ7wsShaZZxU/94MOo9dNE26QeCxqiASgS65TPEVIdr3b24SBwkRDufK2JIayzaIlKrveIWH2a5TEdcLzTwGhMJlJLfHRi3g+CFpVol6b2QSNVJbXaZDtxZzGdCi3j7qkGpiaITAXxz6iGZoNZ17exFMu98FlKNGK8atvIE6pBRbGuX3MK8vJ4fJlFWnM1tTi9lwNU6VlH2RTK1HW4eQnKfx4xJy4evg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by IA1PR11MB7726.namprd11.prod.outlook.com (2603:10b6:208:3f4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Mon, 12 Feb
 2024 15:04:03 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e%3]) with mapi id 15.20.7270.033; Mon, 12 Feb 2024
 15:04:03 +0000
Date: Mon, 12 Feb 2024 23:03:56 +0800
From: kernel test robot <oliver.sang@intel.com>
To: David Sterba <dsterba@suse.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, <linux-btrfs@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linux-next:master] [btrfs]  1d73d634d1: xfstests.btrfs.197.fail
Message-ID: <202402122244.c5d74821-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR02CA0082.apcprd02.prod.outlook.com
 (2603:1096:4:90::22) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|IA1PR11MB7726:EE_
X-MS-Office365-Filtering-Correlation-Id: c6515d4e-40f8-4bfa-210b-08dc2bdbda04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /ocpelHnRBgqSAP2kLOGVne9l88yLIuc/b/pfqEg4NhHdas7EVY9FBcU1bfM7QQBuaw+ctAAhpSCo+/G5vHjs6XZ1Dl503Clrw9evGcMeeSDj1/XwJhLQpE9+/1idrat50R/ejCAKtYYykTc7NJdhtMGXO1hjpsjduCEu7F8sAcOaVXEzv73jUyg07alWDCS0w7XULg4GeM6H2ZdERh5xCsqCbUjmSdwKzk4R6UbkW7sK29j+bjav/JVvmOXzb1C9QXxwAzWsSUywYKVCAb9Y4SFcxDiRAES4gpa9M2Ibnsq2hrSK/SgdeR1d8vZ3z4FI3vjyoMNyn+4LleNooFYlUHBK/3rA/AQtIls9D/W8/TdwWzqBIv6l09h+3WofapqJA7i+m7psEE/diVaMjfG3YfvN1wrBt1g6TCXELFisRWAGbCS4OLRRNcsVo7HX5T39BH+njn6kQv2OmIgSNK+9QxDtu2+K6NIKwLgfC/Imilv5kP8/DDo/9lT22qNUATj1u2XMGCzIHhAIhrSVdaNofvmkChN5AuA3WDN8pIk4sT6Csd7h2porOqJRyfr7eyIB14c26WG/lhO8M1OjD+7Lw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(39860400002)(366004)(376002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(36756003)(478600001)(1076003)(107886003)(41300700001)(2616005)(83380400001)(26005)(66556008)(66946007)(66476007)(6512007)(5660300002)(8936002)(8676002)(4326008)(6916009)(6506007)(966005)(6486002)(316002)(6666004)(86362001)(38100700002)(82960400001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f0TfKUmJVC+WESv1Zui/V99FsFZeLRyuQnSJD5GqHcwvQBLfkcOlC8dTaXnJ?=
 =?us-ascii?Q?pUejbtViZ6uHzlDxUBgfssmiayHTM58o4P3+iZ83h2fa6JHjp4VuLEkA6rm5?=
 =?us-ascii?Q?SEc+1StXl0O3EPdo9IAgFj2uLlpd73sc4UcLXjLnhIvFNZo0TX56Umdh5AGn?=
 =?us-ascii?Q?6owYGrJ+/JIH+BXekxd+OHLTxLsWYfrnP0ASaOUxmp3kfzyKJNk0F0lslVwN?=
 =?us-ascii?Q?IOk8rsVuvM+0tYWWw+azled7TMmymd8DOVvHQgRRMsmPQ903dMEKgFJP+gIc?=
 =?us-ascii?Q?34lUY6JEA7RXRB/Jd1W1RqElf4GEsIQQC+AfwPyUuI6ci49QyTbTqMxeyGvb?=
 =?us-ascii?Q?+xgQLIHWRi3y3fwNp1poxokIy2+M76kno4RkqiOc8W3tVavShu+ugnABB11L?=
 =?us-ascii?Q?9blmWN1TDV5znZLT6Euf5wEdFzbOapJbHuLXvwPQYeMkWYZ8+Ok0SdtZ6jSN?=
 =?us-ascii?Q?gyD8xwoPgHZfFz6kCiLskLmLKprKcaIozC+SzaLb/mhV+LIh3wB3Y9O2KB0y?=
 =?us-ascii?Q?xJ3d0/CMaN3h8WTanW438duu7c8ESLd4tNi0FHL7c7cugqusr5gy9Kkymxk0?=
 =?us-ascii?Q?07aBYoG44Ken5P0Ivwp8DkgR+1OtQY0sEd3tzqh8HL+0g2g2fju4T2NV7PuR?=
 =?us-ascii?Q?orl2jXiEFeywwC6Podt14WXw/kOulG1qK6VIP21ZEsrgoQ0m6PLHc0SJgeFg?=
 =?us-ascii?Q?wMT4ND6B8fT+8RphiiFwLSMEK2pJ+TCIBFQDzYaQSrzNC9WokjyfCBwC2vYr?=
 =?us-ascii?Q?fH8492saVS/D+R05LHofuE1LJMXc276plgvtyr8WyaV7DIfoNtE62V+tbd3f?=
 =?us-ascii?Q?UEkvE/rKVN2aFeqQX7saRDO8NiWynFQA540o/Os2BbZ7IRUQHvO3IMjUiCxF?=
 =?us-ascii?Q?/rBcPYyryotdlFuQMa3iZXAplVybefes+eVw6tZFjt7aAud6Z7N6Jk7cVmKR?=
 =?us-ascii?Q?9ayFoDQgXuZ7fdyvbGc7SnliKBr2N/Awai2jSRv+xB1Fk5Ovxf1rBzEaYvnV?=
 =?us-ascii?Q?QmGFhT/6R1yPb8u0rcjeKtjHSpbUtcaYfCcctIBKp1Ip0TEIeEsIFuZr8AYH?=
 =?us-ascii?Q?Gd67w9uRnrJbUPMS0JAPIgDN1QQMAuOa7mPGZ7YKJSL8R9y1f4hr2ra5P8If?=
 =?us-ascii?Q?XlUdUfE1ECZ1IUdEvsISPmb7XZY2pa4vBwIn9a1tMLMLJ/ndKHjbxdb8yQid?=
 =?us-ascii?Q?l12QLwwhNbyMPx51hIPckY++E6SRcWWQdm9TwHecittFjnVCfwkfO2oD3QrK?=
 =?us-ascii?Q?p/V1tPo4mq1034WtbrhR1uzYqAhPtaSge54UBZyPi96+NTYSHV9Je9Gse7lb?=
 =?us-ascii?Q?X4HNjqo4giuo7idoUI4UD4j+8aXjLXUv0rJYicMVG3/nqF/7ix46k0DSsJub?=
 =?us-ascii?Q?SDj/bG5uiXRrTgEa6g3lqRSJDRnGOKcDKDqviJgt57W3Ws6ZoAPkTw3qTTGP?=
 =?us-ascii?Q?IAE7K9GN7u6uHJIWwsHGkndYsm3ukKHqJqI+Kr5yb7ljGCJTe+hVn7rYRdYk?=
 =?us-ascii?Q?tkEMwEATnDaFrIXWqty2Wyc9ItcJdMKTNYVrd88DmbwmAkg+qCEHDfw5xpeB?=
 =?us-ascii?Q?7HUytiglSwiG6w/8LvMTXiqKrSCTPKapCr3JXkjLtGM1R+nQM/6YqDBEPq7p?=
 =?us-ascii?Q?wg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c6515d4e-40f8-4bfa-210b-08dc2bdbda04
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 15:04:03.6000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KiXdpYKnVkAnqhf29RMA2rlUI/N55PlyUIKYHr9gFyiVtxb1KbjDlZxbO4i8dPyele1cMtjTvbxJfVHE3w8T6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7726
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "xfstests.btrfs.197.fail" on:

commit: 1d73d634d1268267a5a2b5b1845e48a620ad503c ("btrfs: always scan a single device when mounted")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master b1d3a0e70c3881d2f8cf6692ccf7c2a4fb2d030d]

in testcase: xfstests
version: xfstests-x86_64-c46ca4d1-1_20240205
with following parameters:

	disk: 6HDD
	fs: btrfs
	test: btrfs-197



compiler: gcc-12
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz (Haswell) with 8G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202402122244.c5d74821-lkp@intel.com



2024-02-09 01:33:38 export TEST_DIR=/fs/sdb1
2024-02-09 01:33:38 export TEST_DEV=/dev/sdb1
2024-02-09 01:33:38 export FSTYP=btrfs
2024-02-09 01:33:38 export SCRATCH_MNT=/fs/scratch
2024-02-09 01:33:38 mkdir /fs/scratch -p
2024-02-09 01:33:38 export SCRATCH_DEV_POOL="/dev/sdb2 /dev/sdb3 /dev/sdb4 /dev/sdb5 /dev/sdb6"
2024-02-09 01:33:38 echo btrfs/197
2024-02-09 01:33:38 ./check btrfs/197
FSTYP         -- btrfs
PLATFORM      -- Linux/x86_64 lkp-hsw-d01 6.8.0-rc3-00073-g1d73d634d126 #1 SMP PREEMPT_DYNAMIC Fri Feb  9 09:01:24 CST 2024
MKFS_OPTIONS  -- /dev/sdb2
MOUNT_OPTIONS -- /dev/sdb2 /fs/scratch

btrfs/197       - output mismatch (see /lkp/benchmarks/xfstests/results//btrfs/197.out.bad)
    --- tests/btrfs/197.out	2024-02-05 17:37:40.000000000 +0000
    +++ /lkp/benchmarks/xfstests/results//btrfs/197.out.bad	2024-02-09 01:34:06.449577143 +0000
    @@ -1,25 +1,33 @@
     QA output created by 197
     raid1
    +ERROR: error adding device '/dev/sdb3': Invalid argument
     Label: none  uuid: <UUID>
     	Total devices <NUM> FS bytes used <SIZE>
     	devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
     	*** Some devices missing
    ...
    (Run 'diff -u /lkp/benchmarks/xfstests/tests/btrfs/197.out /lkp/benchmarks/xfstests/results//btrfs/197.out.bad'  to see the entire diff)
Ran: btrfs/197
Failures: btrfs/197
Failed 1 of 1 tests



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240212/202402122244.c5d74821-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


