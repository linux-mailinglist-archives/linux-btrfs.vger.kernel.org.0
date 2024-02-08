Return-Path: <linux-btrfs+bounces-2239-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D93384DC93
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Feb 2024 10:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5ACA2823C2
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Feb 2024 09:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ABE26BB4B;
	Thu,  8 Feb 2024 09:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m/MWoxoB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4656F6BB3B
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Feb 2024 09:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707383689; cv=fail; b=tqIg+zbLwXK7jV1/VN7IuL/kUJbpbe5C5q/jcRmX4FDVJlfjdjIQ3bU1WcEu/KIgCZHB6Ebxvt9qTUsM3A+z9wZishDNhJy0O2Y9jM22VVJwD+LEFGLVeyDpXWywgAusdvGUeLgOJ9GCiizm99dhmeu6qPvBNZ42c7Ic6uO8Woc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707383689; c=relaxed/simple;
	bh=UbrVoQhwMQt4Tr7NN9Q9aJJ6K/5YNdmF3ULc3xeUj3E=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=jxInqG9syPr7Q4HC7eB2Rw7OEQRMaeVbhMG+Qfx+GPo32mrBtOQf2aZPGcozvucvYp2GqeCiUHVT4z02/39QfFGaMltv0sVQ9dDgnNPGpzO8XdvqeIlhj1xDlgjCQ6aZKEmJ+FmMdBjiWDOjarN8XpjoMYchuJhMG4acfJmDkl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m/MWoxoB; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707383687; x=1738919687;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UbrVoQhwMQt4Tr7NN9Q9aJJ6K/5YNdmF3ULc3xeUj3E=;
  b=m/MWoxoBsFx5XFExCtjJSQMenh90m10JwB++kO/oTOocJCLsYmR+iQw+
   1J3DcEnM4nG+JeaI0CExuTNz//1ti1xmY1lysGgEPke1Wwy/VQiowYjAr
   AejpvLoksX4P1JQq5raha8xkIKbZcS5gg4CoswOBafdztRZm12QyxWghn
   Y52LydAuCnA5J+uMpK93PqTgPBrepHUKnKB4AP62t/jVfBQ5WNunGnxhN
   S5FFGTXKCXtds7FBz3xgDMX11GervM4R/aVbsjvX5qQm9RtNOGFRKDtXa
   nr0Be0cay3BKRZjQzSywewG+zs1HLS10zqjEacZgnB0qDECiyO4jhqo27
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="1475129"
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="1475129"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 01:14:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="32672237"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Feb 2024 01:14:40 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 8 Feb 2024 01:14:35 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 8 Feb 2024 01:14:35 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 8 Feb 2024 01:14:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N/sHtnexlSmJ4Ho5CKooh2vMcLTZ605e3v4JO/MmwWjbw16e0W1H3nmS3OxW7vzBYKYmFJfhqa8HCrXSjXSfHW+VioFrUuiaot6xjdHpZJDFpf7cyP1Ryq1dP5sPTQ5NCiNwSeSKKPev+2xaiiYp1LiJMbCBftegkvTXGbSmVOAXShk52hI+q5pJ1Diy8YDlhmzBAeaBHOovxzkTrfwBYVNhaIjgC2NVM2U4fX52PHn0r66ciHJ/sT33fJNPWSTnP2nS0ohbyQF9vlY2WEEiTb1kHytD/qwxRk14J3y5NQ/cu1UEqluleisgZH3XbylNHwZreDUfusPSl1Eoa/jseQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O5IgjuCXJJQcU2e8Lz3h4juIIwLfbtz/6MsuqLDtW2A=;
 b=ZHqudE41+142WhotSt/Yj+gm+aPwVD7oUyzlsytXp3J2GjGvw2FM10M2Ba0p4++c2TeRhvhWyltyUcUlyQvw7D9bJGsTf/5QoutddH4lAhH35+2rqg5iXvbtUPcO4i40pLw6mxVtLSGGbCL2rzu9CRhPmPyu7whKJI9ahgHwq2vUb5ds5ypMGJd4JKPy7ZfOfog1rzJPKORWvdjpgwFz5O04MGCSJ6Uq1M/ci7sOF+oiRX+sF6rEaZA/GVCsliQ3EC9kk4Pzk32jIo65Gyt2khtnYN3FajbI0h84+5/PnFPiDJk8qB7iNz80VwfXkHbTnKL9oUR5Dj/sGtpzd1npEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DM4PR11MB5293.namprd11.prod.outlook.com (2603:10b6:5:390::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38; Thu, 8 Feb
 2024 09:14:27 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e%3]) with mapi id 15.20.7249.038; Thu, 8 Feb 2024
 09:14:27 +0000
Date: Thu, 8 Feb 2024 17:14:20 +0800
From: kernel test robot <oliver.sang@intel.com>
To: David Sterba <dsterba@suse.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-btrfs@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [kdave-btrfs-devel:fix-6.7-device-scanning] b80f3ec659:
 xfstests.btrfs.285.fail
Message-ID: <202402081636.6d71afee-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR01CA0198.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::7) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DM4PR11MB5293:EE_
X-MS-Office365-Filtering-Correlation-Id: 848090b2-1269-4cbe-aed2-08dc2886599b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2fZ84NhayXm0uiO4dY1BcFo4yWCYeUvod786QDRvNpjft8ufgFGDImYzZuhCh2+kxEdXhfYhkDkhhd6mCQ7FEBULrEilALLl7C2+DJHfCN7lBqZBzxVLRUvVEVS+Vfiz79GwvAc7h6Qpf91vVroqfZSJpHXwi+CNG2k/mkgHsPGZYCY+vesG8eHRRJU6BmlusxyCE6w3rMhZ+q9I3QUfk+PXqxiiq2xZ0rGaQ9+9wtSDq70p1XqfXqPKFB6VclNIDWY/Xi/2UTe+qb4PUta1u7b3bcTJKK0hy1jST1FgqT4RORHx060wZ0Ox1SF9EcCcrRQKmLHg0kuM6XStTFYO/zaeV/LiJrYBRgJOqYhmZFKMuOiXG/dNlTqX8b8NL1lKDk3nM6A/cEAc5DTdtV+pHqvNwZ5/yVvxgAxSWFcN3rNRj22xVPH8fE0IUY8KyqyMA56f0RJBny8Roo6TxG0nz0tXJMq4suiFUqUs0y57okr60soEM2b+o85/fKjHaO6DQ49mC0/4CLgoYyLRRqezFI9zlUs6FCIslcdp+uSSpq84h9W3Ti5vcy7HVSF3f1jsr6CGpM3ECwr+YTjLtHf4QA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(346002)(396003)(366004)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(2906002)(5660300002)(6512007)(41300700001)(26005)(83380400001)(2616005)(86362001)(107886003)(1076003)(8936002)(6506007)(6666004)(6916009)(4326008)(478600001)(6486002)(316002)(966005)(36756003)(38100700002)(66476007)(82960400001)(66946007)(66556008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7NsY+vCQrQtX1I2CuXqpntyJQFHJ2ECu1CYMs/ecUFBRLnWooReEiLvYFeuP?=
 =?us-ascii?Q?G6zc/apz+Fa5rYqb1PR75Dqc5jplmy9Fh4GbnS5H45dcBksMPd/Mfo3jloaL?=
 =?us-ascii?Q?RwbqwcM/ETooWCJH5OVaGOv9MicqJe3zbsonLUkF12PAtEevvVhTRcM+zqsA?=
 =?us-ascii?Q?31naHxi9QTGlh18YvdC/R9xQxKY6ea4Gr4ZpAJvgKGiirMbWEHv02SkVDDg1?=
 =?us-ascii?Q?QlaUN6F579OXFc3epzPgGyHf6di0donv3II86k+Co06YrMvLsaGXWJyzuH0A?=
 =?us-ascii?Q?CbbiUjgS8P6MQ3Fhnqe9A2rNQUEzAf8I4u9bAGHL0K+KxlYPvQOzp2loNMnN?=
 =?us-ascii?Q?wnKxSB5ul2lMMZ9hCjoAvsTAlqELfLhcIjg8MmaCFyLW2xW/nTbK6fwDiTg/?=
 =?us-ascii?Q?emIUS++ihtvrkuHIU6aO7LbcFssCiVeVmNYFLoGndhpOuxOWZslD1m0wy+ix?=
 =?us-ascii?Q?b0wKlt11+t4e03iJfwP6Io8g72zmzcFr/drWy2oBflB3kbvS/hKAJIc/afAW?=
 =?us-ascii?Q?yWeU1vNtq3OfbRMfqTYiVic1dxWnNPUdtocvwe8UGWXt2A6nthr4ymE1kGfb?=
 =?us-ascii?Q?SqDOrzoS7E0vS8l2CrnyXG/u1BHtkm0eXghujPLcMiDaTtA5iNNozTt6B4j0?=
 =?us-ascii?Q?4jjKwFyLwgJn1soTBkTmq5wuXo8AhgiwgCGLm9amgFG7DVOkCDFVZAJJqPgV?=
 =?us-ascii?Q?DFzhz38E4yB+HD0BV5y5sgc5I+eRuigRMBQKKdGUopIP/+8AiXzjiv6+7Qmj?=
 =?us-ascii?Q?fNJ/jYvHun9jQ9/CZrVF0CeKkouAMLQCK/Vpn/Hos1eUidcid4MmqNE8uUbM?=
 =?us-ascii?Q?J6W1LSVdT41f5T2Nms+SmSEY5hwJojl2ywA5v/3cMSs1qiAGneePlMPH6U/s?=
 =?us-ascii?Q?4vh7sWKNSfO2eEafgL5NXdOoA289Sq685+s1AH8wVcfsVKayPMX/MyCOgrLf?=
 =?us-ascii?Q?bw9GrpbnxEprxH/bLTdBRHaZZ2Q4LCkmujOPQQhPZwcaDAF4U3CvgEl9kp9k?=
 =?us-ascii?Q?AnDqo7e2M3/vKUH+xzKoHBgTv0VfRzWeBmvQVLC+qXCy/RCbalwGJ/yykcWv?=
 =?us-ascii?Q?rfLo9Zq11JZjdJLWD86f8OWCmqoFAjVyPMXIQ3E9mEEofru4RTx4WlwU1pAT?=
 =?us-ascii?Q?VSpJL5m+AeRP8DUkYtVSDRxGMKb9GYPJJFWqmhQeCPaJXHjOhMkm2kVSFnmF?=
 =?us-ascii?Q?JaiReqHHm3ExZHwvStLW0SwsTuTdV5greSal5IdbwA83H6ph+CSo3IvEK+48?=
 =?us-ascii?Q?vk9dnKhuqoCH0s1NUlkhKF1Mi9nomxU4WsTVjjj+4nhkR+X3gRINKhQQMFX7?=
 =?us-ascii?Q?PBUFc7C9Yr+jwciG+ApQTWfMEfR1R0qWvuL8cg/Cn84PcRWsZbRwnbRQhY8I?=
 =?us-ascii?Q?SNwv/EPZ/8Xx6ZgVLHB5PFQlHdkEryuDtCvkNo6l0uwr+xMV2DVPZ9/x6jlu?=
 =?us-ascii?Q?4Dod4O6JwHSZajsjiWzKzRf0jPyV/HDX8SmATPqj4SNbmnUjhBcdSz2kX89/?=
 =?us-ascii?Q?rwOtARwjrtqtZ/Hv6yt5SjwdXlLCBxa9U/iMeLnWuTmg7O8FKnF1pFLrgv3f?=
 =?us-ascii?Q?VsY3ExWovGF9CwFRknuqdJpURHEI/4ZxHusmVCDdvOFfEqmDhZIBEAks2yMb?=
 =?us-ascii?Q?rQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 848090b2-1269-4cbe-aed2-08dc2886599b
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 09:14:27.4767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZXNOx1b8aECz3iDUxWywI9b3UsPBTFD5Q/pRmU3LBDElxQtnbyDsLIymZxBdCLTCUc4QmMg2a3UfMvaLOeyeLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5293
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "xfstests.btrfs.285.fail" on:

commit: b80f3ec6592c69f88ebc74a4e16676af161e2759 ("the fix")
https://github.com/kdave/btrfs-devel.git fix-6.7-device-scanning

in testcase: xfstests
version: xfstests-x86_64-c46ca4d1-1_20240205
with following parameters:

	disk: 6HDD
	fs: btrfs
	test: btrfs-285



compiler: gcc-12
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz (Haswell) with 8G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


we noticed this patch seems not a formal patch, below detail informations just
FYI.


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202402081636.6d71afee-oliver.sang@intel.com

2024-02-06 23:45:26 export TEST_DIR=/fs/sda1
2024-02-06 23:45:26 export TEST_DEV=/dev/sda1
2024-02-06 23:45:26 export FSTYP=btrfs
2024-02-06 23:45:26 export SCRATCH_MNT=/fs/scratch
2024-02-06 23:45:26 mkdir /fs/scratch -p
2024-02-06 23:45:26 export SCRATCH_DEV_POOL="/dev/sda2 /dev/sda3 /dev/sda4 /dev/sda5 /dev/sda6"
2024-02-06 23:45:26 echo btrfs/285
2024-02-06 23:45:26 ./check btrfs/285
FSTYP         -- btrfs
PLATFORM      -- Linux/x86_64 lkp-hsw-d01 6.7.0-00001-gb80f3ec6592c #1 SMP PREEMPT_DYNAMIC Wed Feb  7 07:00:38 CST 2024
MKFS_OPTIONS  -- /dev/sda2
MOUNT_OPTIONS -- /dev/sda2 /fs/scratch

btrfs/285       - output mismatch (see /lkp/benchmarks/xfstests/results//btrfs/285.out.bad)
    --- tests/btrfs/285.out	2024-02-05 17:37:40.000000000 +0000
    +++ /lkp/benchmarks/xfstests/results//btrfs/285.out.bad	2024-02-06 23:45:51.904771890 +0000
    @@ -1,2 +1,7 @@
     QA output created by 285
    +cat: /sys/fs/btrfs/95783542-ca90-43bd-84a1-389add1ee212/allocation/data/size_classes: No such file or directory
    +1c1
    +< 
    +---
    +> none 0 small 1 medium 1 large 1
     Silence is golden
    ...
    (Run 'diff -u /lkp/benchmarks/xfstests/tests/btrfs/285.out /lkp/benchmarks/xfstests/results//btrfs/285.out.bad'  to see the entire diff)
Ran: btrfs/285
Failures: btrfs/285
Failed 1 of 1 tests




The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240208/202402081636.6d71afee-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


