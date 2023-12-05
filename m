Return-Path: <linux-btrfs+bounces-608-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D80804A80
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 07:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83DCDB20D3C
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 06:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2EE12E63;
	Tue,  5 Dec 2023 06:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f9YsPTLH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F6EA4
	for <linux-btrfs@vger.kernel.org>; Mon,  4 Dec 2023 22:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701758682; x=1733294682;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DyNTyVE04JvTu9UxxverZzKtFO8zZyKZyP1rCaEPk90=;
  b=f9YsPTLHolQvpDRC0ee2N0mT5SRSi+XGQH3NzpY0ulrkJVza8KrDKSQq
   TDPC49rXdMMl/kxT09qlo2SN6TIir1UOVikxbBX0NYtMmIiX5T0GKqSkW
   YpoxguT3l+aKT3BSM8RGSRBTjEtKYLP3oMxBn0IriSYeUh8P8lB8ex+MG
   rBKvDZZTYm1i+0xh1EHfHZES/dK+zjohc/w9YcC07p8lR4pqNT6/bKLdM
   CyzvhrYrZt+7Z4vsEZ2XEusl4v1lj0lpbBsNS9oARW3aC27XIoBqxtAzg
   +8Vc6T7TbgjX9+MVhyTA5aqIjj7J/zxN1/Ar0xCCvBfqylx5YcvrlJ4vV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="373297428"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="373297428"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 22:44:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="805180042"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="805180042"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Dec 2023 22:44:41 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Dec 2023 22:44:41 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 4 Dec 2023 22:44:41 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 4 Dec 2023 22:44:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PGwUlUClOYF8J6vgksoMbMTrqcLVXQlt0plVtOwaLz5uAJk4NQQoizmzEfbf14tDoCHCLeaojR5X9KOCCOMlA3GDTWLteXPWQqzb3yPSiaHRjtKcDegBCemeb3EQMYOe6inMtko61obW8tKHxgcOv9onkPwJ4ESsjqRNlMccQzuOMBVJqBLgS/zoBVMK5ARNucctKZmfgjKhxqP01H+BM0RqzKP7AoefA0ptggxQmtEe6hDgDeMgriAtUbmZz7Fxyst5OiZtlnf0Xpe+emAD38eLWv3PkDZXzKukHzBBAP9Yz/3tieQc9ErinM30CqOgmkEE3Q6HN3+f8oWFztFAFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Ssq6Q6OpFR/17Kyr0xmA/QmbO3tsOBefSJDzlvLhaQ=;
 b=lmvp9gMvDANh1sz7wHJ4LfeJOnDAk9r7qDk7EXdacQqlFsjny5aA8ubtxYFJVYJU5m4qLb1675Yc4mkj5y6Eidhwg9GioXsu6yrmjw7mh+cg9ZazaEy8HHxKi9jQFrZfd7WHTXeK6e3Tbu5UniGcF/K/FXH9aFKz1Qu+2pGEamQzsrrGB9FXiC/5ux73OJni+LRLuDI9xhFrYfHIUfePOMJm/ES0eYZsLwzrT/HLOcAU2bnSqW1Ea46aA5qMqmwGDQwbW1ualrtFhEaMsuyJ4QQ7EZOjJHlOofMmAhmrTMg4gloiLtf1kAETomXi85gFCsJXWCa4GPuMA7OBvVvUrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA1PR11MB6781.namprd11.prod.outlook.com (2603:10b6:806:25d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 06:44:38 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f%3]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 06:44:38 +0000
Date: Tue, 5 Dec 2023 14:44:29 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Josef Bacik <josef@toxicpanda.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, David Sterba <dsterba@suse.com>, Johannes Thumshirn
	<johannes.thumshirn@wdc.com>, Christian Brauner <brauner@kernel.org>,
	<linux-btrfs@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linux-next:master] [btrfs]  7d59ee54f0: xfstests.btrfs.220.fail
Message-ID: <202312051101.f6be0b61-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:194::10) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA1PR11MB6781:EE_
X-MS-Office365-Filtering-Correlation-Id: 252a5bdb-22df-4ae4-345d-08dbf55da70f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QyS1Ym3by6cVkReA0KUiUkgPvBKClUA/dWv5keQSCq3+0X/yxlV5H4YVj6ISCdpgMYULMo67MSfLwWBl9af8gR4Xjqmanz9IzsXgbeNod2ahs/1+km7v/vujnCwWXE1LXWjiTa2tP/NSq6MskwdEV+CXLtBvnJq64L6rcf0U4Ttj1I1jKz/mKxNhtu5a3yDkIwEa2H+4QuX6WN1F6Peyczd69UQkWaDcDnhiFOsI0qedSABk/WTfWFEz0OjcksDJP9swPFFI72mVHpwjDs1RcHOv3F2VEa51kJYMt4+emzabjshwbQko5hYwrxQ2RvKI5kRmMAAiPCfrMxP2N7A9D3eWeirfP8OyS/AMFN0NMLTPUJjNq8Db15NHTf+EOtTY7/I4uEHXkcItcbU3n9GjFF3YduRq3gnzDgOxj0wisV+co552X3r3IxsXuw8mqo9Q2D7NUB4pHugpIgFqp97MoNNnx1EUDL4zLrjiXk9QGXq9FDE6sPRYMla1le3vDhWQohgBa7eK5RdxygnxSjt2zJx8/g2uHU7x4BFFNHu8/i8GddzKqDZ5PWPoGRJpZhpwHo7ZPl1AT3peI7bwS89yHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(366004)(346002)(376002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(8676002)(8936002)(4326008)(6506007)(36756003)(966005)(6666004)(107886003)(2616005)(26005)(1076003)(6512007)(54906003)(316002)(66946007)(66556008)(66476007)(6916009)(478600001)(6486002)(41300700001)(5660300002)(4001150100001)(2906002)(38100700002)(82960400001)(83380400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DUkFTTWZPbDPWh4w5AGXVEQWQ2buEiBbPdYn5VgZZmI03fR8lX9T5ZfEJTrv?=
 =?us-ascii?Q?Aau8YY1u2LVmdHQnB2TGDAHpJJ6yaoz69mw/8+wg4z1zZ/SBuAWLow9efjFI?=
 =?us-ascii?Q?oTPsF41z5acbCGR25PG1MCl3lahaiaVkCwRFvluo2U0fOpbwbcXuboGxXOH9?=
 =?us-ascii?Q?BFEQ7TSBWXk71ODendQST1vtG/S27JnjAgWUhNGhnMPM7lDiJy8NF4nC+lIK?=
 =?us-ascii?Q?4q7BPJo0IBLZbG3o5TPESZiLdbQTUGlYpDmy114uRXqVM+9okGV/LpgI/5XG?=
 =?us-ascii?Q?PwQi9Zxzug/sYDPEY1mkO33F+2BEXVrdcgEHSywyaQJjhlr7Lv3FOLx5OpdQ?=
 =?us-ascii?Q?YhjOL5MNcDxvBxdfabs9HSq9I27SVXmgZCkNm1yooV0rtu/XOI5fu2G/LnG6?=
 =?us-ascii?Q?ya85a+G0XcpWeqAgCNUKx+lIQFt42Ds6/xLGYCuKk38J4uLPDa/Q6uB2VUs7?=
 =?us-ascii?Q?BZOLPutY0/djRrUbNClorLgi412v0Uf1AlQsFYivhXaBY0Be0gmHNw5pH9eA?=
 =?us-ascii?Q?c4QRVQ3Hhc322twh9+dOxb/+lfNqrno8EERSU0XJ2N6lYjOdJ6uhXWfwrT82?=
 =?us-ascii?Q?QhIRO/6JMb6YDq30eC58erin496bBic7B3PvuiSRZchAo3xRi/2pac/1WOmm?=
 =?us-ascii?Q?c41QbKH3q5BFfvxZYv5P6a+WmzQxvS3mZSyAqfla1A7yJf8tdvzrjc7MhPfv?=
 =?us-ascii?Q?TDoihAldGwkhStVQZR7u+HYPRW4RZGy78BPsuBeTWhyyiF3MU6QBO6/WJfzh?=
 =?us-ascii?Q?ou739lM3NC4sVMmsMGlKC2rLI6522Ml0RE9VWzQi916TsIQ0VrNaY5iB+S9u?=
 =?us-ascii?Q?y6qFzk7anEmoQ5x1s1K0Zy/JAOg4bkOQ6fppCQ/04J2Qltd9q+XnPr1weunX?=
 =?us-ascii?Q?wCFlbka/GZcmVYM8tG1kvcfzZjBzTcYy2o9LCXjL5JPbQYHKL53xErIgvgn8?=
 =?us-ascii?Q?D35eg4IAT83ulXd9Vev3ZYNum9QicVFxbnzUr/6U0lktJp1SpW01PJeBoVok?=
 =?us-ascii?Q?EPFe1cZkI2KuKEXh5LtpaC1uZ2kbhSVEQ21N8O/dNsaUfLWZ8TSqN0RkZZZz?=
 =?us-ascii?Q?AIaSKp1XCmPEDVQow7G5pk6qSpMP0tjMfVrgy+4Lz40saFojlj6aS4wrfwW/?=
 =?us-ascii?Q?qVpc9OHA6jePAtA02msbbgoYlBCyN5qfDZTsTRkkMPko1BdsdUplN4V1hPQK?=
 =?us-ascii?Q?W3XW+TeFZQ0P9sH6GhRajQN+Hmc/TxxbkuJC2/hhGi2ZsDvaoIWn6cecgRZx?=
 =?us-ascii?Q?JJnt74K5mIU4dM6/JTECtXWwfEjExiorvYU001f9giZibFBdshoo4k0bXpvy?=
 =?us-ascii?Q?RiYHhmRwenhVrDsnNCzx8qbPfll4NXEzUpTijplHP7iEvXNOakr4a7B2pm7S?=
 =?us-ascii?Q?jj0qF4Hs0AP3aCzAeLbS6fvMHNm8pbWbazNYcDMt5l6/Z+3uT+jvykPSulCx?=
 =?us-ascii?Q?Xdsp+piGdXtrCVvV3Q/NHAdElNHP2rAsrvOmcNRBr5f9VLBv+PXT+LhBM5Kv?=
 =?us-ascii?Q?CyfYlu62lECN2XgseCcuQE+Z++Ps6Yy7enGq+l5Ir5AJikt7LIYKr1AJ/Rvs?=
 =?us-ascii?Q?QyPP9iNeRrEsaX/0by2cou+W24DJNEuQrxExjLrWwapgeb8kLKA1qnbnccjw?=
 =?us-ascii?Q?AA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 252a5bdb-22df-4ae4-345d-08dbf55da70f
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 06:44:38.7351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ggwg5TmbSGIHD23pnkVjSvRJI8aWKXhEdX7EgQg4QlWzcsO7zdnCiTycITqKlbFc/0ZmZ0ojUZc6eIZDkZ5b6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6781
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "xfstests.btrfs.220.fail" on:

commit: 7d59ee54f0ef2b1bc3eece201e580b70d1bba4cb ("btrfs: remove code for inode_cache and recovery mount options")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master 629a3b49f3f957e975253c54846090b8d5ed2e9b]

in testcase: xfstests
version: xfstests-x86_64-11914614-1_20231122
with following parameters:

	disk: 6HDD
	fs: btrfs
	test: btrfs-220



compiler: gcc-12
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz (Haswell) with 8G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202312051101.f6be0b61-oliver.sang@intel.com

2023-12-04 03:56:44 export TEST_DIR=/fs/sdb1
2023-12-04 03:56:44 export TEST_DEV=/dev/sdb1
2023-12-04 03:56:44 export FSTYP=btrfs
2023-12-04 03:56:44 export SCRATCH_MNT=/fs/scratch
2023-12-04 03:56:44 mkdir /fs/scratch -p
2023-12-04 03:56:44 export SCRATCH_DEV_POOL="/dev/sdb2 /dev/sdb3 /dev/sdb4 /dev/sdb5 /dev/sdb6"
2023-12-04 03:56:44 echo btrfs/220
2023-12-04 03:56:44 ./check btrfs/220
FSTYP         -- btrfs
PLATFORM      -- Linux/x86_64 lkp-hsw-d01 6.7.0-rc3-00074-g7d59ee54f0ef #1 SMP PREEMPT_DYNAMIC Mon Dec  4 01:30:48 CST 2023
MKFS_OPTIONS  -- /dev/sdb2
MOUNT_OPTIONS -- /dev/sdb2 /fs/scratch

btrfs/220       [failed, exit status 1]- output mismatch (see /lkp/benchmarks/xfstests/results//btrfs/220.out.bad)
    --- tests/btrfs/220.out	2023-11-22 02:47:17.000000000 +0000
    +++ /lkp/benchmarks/xfstests/results//btrfs/220.out.bad	2023-12-04 03:57:08.228523511 +0000
    @@ -1,2 +1,4 @@
     QA output created by 220
    -Silence is golden
    +mount: /fs/scratch: wrong fs type, bad option, bad superblock on /dev/sdb2, missing codepage or helper program, or other error.
    +mount -o norecovery,ro /dev/sdb2 /fs/scratch failed
    +(see /lkp/benchmarks/xfstests/results//btrfs/220.full for details)
    ...
    (Run 'diff -u /lkp/benchmarks/xfstests/tests/btrfs/220.out /lkp/benchmarks/xfstests/results//btrfs/220.out.bad'  to see the entire diff)
Ran: btrfs/220
Failures: btrfs/220
Failed 1 of 1 tests




The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231205/202312051101.f6be0b61-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


