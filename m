Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC28D7AF847
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Sep 2023 04:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbjI0CnF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Sep 2023 22:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbjI0ClE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Sep 2023 22:41:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C489D7D87;
        Tue, 26 Sep 2023 19:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695780640; x=1727316640;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=pOhEquu6Fu4LkmVb7N2CylChqS7TTMt7MqwxjfBRo0I=;
  b=QQZ+6e//aM7uPxhr3ZuXArHxFnHmswQcmJ2RHRHJLmp3kWlBsU/2NQz3
   LnXW8WmWpMd6VkwePmD7DM+5unAxRizyiLzceoVlBvspk+LWkwZopFY9y
   7OcmH0cSVPN1UEUkSH/loBD9VPcgVDzIrZ6mRYZVCY3J/+XABs4gi4ysZ
   9IUr18FXkOTd9izh4sWpbp2NrA6CYEFw/QdxNwX4N5CZ8fY7EJF6jooYX
   yrjG2DAvS1RF7OKHMAeg/3k/tQk9TY8X8xa7UiL8Ib+RR++CstzwulBe6
   hKCLVsawGVEiUep3KrWu0lgaud8ragrgLhOzFczmpjtIq5rss5prmI45C
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="384490451"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="384490451"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 19:10:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="749015570"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="749015570"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Sep 2023 19:10:40 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 19:10:39 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 19:10:39 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 26 Sep 2023 19:10:39 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 26 Sep 2023 19:10:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FADWNvf9SPgM5yd5zF6U0dY52UHJWQYeax9+rQpvXFp8eoJEZtYTqAgc8epTIIzyNodTtcD8GlTwM5zxcM4uFSF6GKUqlwEGq2Xd92M4Cy5kVpEJVjvyiTfzwyvsHSI2g21M4sqRiGP5YLpR6AiTSfk6wmJoNhceaHVb5O/R6uDaepv73+71zeILypJdn09EuxG3C/ANRibYzzTVhzZsLOgYfa6eOqgkIOGmCcgD9/wWButWh0r/oj1leGLdPy6shbDirFGGdHRdczVdxvidPPUPGYhIKrx0eKPlnj+QXySK3U3Ss4Z34JGzkeaMAy73Fzb2/bkyLh3F9OzMqwvyrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xlG6J53tMKJNxoC8i6+X1LhV1TUnc2U6RToJ2giOs0c=;
 b=Nw8SxZsqzkTbHNr98TGI5+3cQ7RVWlPqdTtJE4PzynxaVjLp0U0DTbM+NfrbboGDbGCuMXkKl2HpIdX9gdczpOIbY1zUkzk2i1WjGB609wKD70EmSu690h3mjWh4svo/n4mAHHsMpq97nkVmbCal2V1CmXhCszgwa1QS+Kk1hMeWKPd89IDW1KdBdjlo/To5NfDf1w0PQ79saHjcdMkQ4GCqETAwa6Eje2rI6DMscy2IJ6dnUc3lIAe2TElMFNGtAWndxTfsCJT4lqluE6+ei+u7mBOOqnxa78gjsbzhi2dNyXgIWzIp3pwWP02lKkAGO5j2hdglEu+90oY+tTh5sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by DM4PR11MB5294.namprd11.prod.outlook.com (2603:10b6:5:391::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 02:10:36 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6813.017; Wed, 27 Sep 2023
 02:10:36 +0000
Date:   Wed, 27 Sep 2023 10:10:23 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Josef Bacik <josef@toxicpanda.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>, David Sterba <dsterba@suse.com>,
        Filipe Manana <fdmanana@suse.com>,
        <linux-btrfs@vger.kernel.org>, <ying.huang@intel.com>,
        <feng.tang@intel.com>, <fengwei.yin@intel.com>,
        <oliver.sang@intel.com>
Subject: [linus:master] [btrfs]  77d20c685b:  stress-ng.iomix.ops_per_sec
 68.5% improvement
Message-ID: <202309261605.687d7dbf-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0133.apcprd02.prod.outlook.com
 (2603:1096:4:188::18) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|DM4PR11MB5294:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f90ad02-1450-464b-d310-08dbbefeefc4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B8cHNyEz2oANTRGwWGWFiqi/gZ/uM1/oU0GG96uk6RNVOaygbzjhay5cAEasFEAgWeCYistcaLYcClrOvkRTmgiT1IzhsjusX0emLwGUlQv5lMYXsBg7fdLvvYBjTZ9ZNooAwdylcgszIlG3q9brZSylToCDO6XsqcgfijLX7yjZgQbfPYV9AL/ND2QoYCVpXkMr2iy6rGDNFgK1ii0XELb+uDi03NQibJISbIuXP9hd4iV+FoNFht54Ir6ktun+uJztEbIuJM9w/nHVLTpFCUHuyY7yXjpawTNM/344aLn9uPyYaQXOQSEjRWcruthnbr2JV1aM1f1G7xZB29udpiJUHhVidEmKt+O5vv/JCbukp+Lho2yiE2D0W/O2Ixz97WqWbR8SIwKeC+kADYsk1ymtQfN1cKixNr/+aGY5DxS9g7KmEz16+dkc41MffNSgA3aiyBKLeU517xGpkxgBLdoNIdLHlGff3hMgxfoLQ5/boo5xwML9LLuEvhHGM1GnOMaKAI86g/QCbuw/W20xrzFBnxk8Sb8iT+WSM++c4/tBBggh5a0xxeIEkUjHxfD0+8nQlcTX8oziX3pVC/8SOw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(366004)(396003)(136003)(230922051799003)(186009)(451199024)(1800799009)(30864003)(2906002)(66476007)(66556008)(316002)(66946007)(54906003)(6916009)(5660300002)(966005)(8936002)(478600001)(6666004)(6486002)(6512007)(2616005)(26005)(107886003)(1076003)(6506007)(4326008)(41300700001)(83380400001)(86362001)(38100700002)(36756003)(82960400001)(8676002)(579004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?+bTeZV/wKbx2dSHOtasBRQV0Oln8i2gW3+JuZ2qMBkPexAikJhjnTBvDjC?=
 =?iso-8859-1?Q?2G6pqp4WC6MOsYYLOhOhG73ZNxZ/dKFmg3j2vSfqgUemhnYETZdwiNRoTl?=
 =?iso-8859-1?Q?t4X3Zr9dFmomqtiVwsN7IFQohgmPFAsann/30+G/NcJgrKkyTn+oqkyHuJ?=
 =?iso-8859-1?Q?jVnXwD4DWjLiw4+uHdfCfAAa7k2n+Wqv9GBU64S5hoCvmfes+xfk4dVkl5?=
 =?iso-8859-1?Q?19HXu1P1lBooo9ksFEc52JP5NZII/b3pmHMkP620CRwsgxGjaThQFHtmL+?=
 =?iso-8859-1?Q?hhi9Yz8P8nLS/Ug+Diy68QZFj3kV1MCxsibB0DCU+IILX0XQmU1fc2m+Jb?=
 =?iso-8859-1?Q?wTvcYf1GBoflH+fnGcfL0W5shRdpyAUr30Eq28i/Vu6MzqQNWs9b152LQl?=
 =?iso-8859-1?Q?D+sifnpGgSjlL5xHsfKnQ94xhF1/9ui0JyBGSwAh5I5I2ZZFiq1qOvFQPq?=
 =?iso-8859-1?Q?lJ16H2nHbf7MHY/rdYL7dzKpuuK9ro+Aq9OkzEsnyav3jsF1NmIP7j9f4r?=
 =?iso-8859-1?Q?Su9fB7FG0+70Q+UZ+4Uz6Tb/AH1ESfB/sMRZ8KuDhJqTUa+2OMxXLUjfpc?=
 =?iso-8859-1?Q?7W0b/LKHUgX4fhay7TbDjaF8uB/nXW4YRz6EwCEU2kB2UEZ/44aGXkdOaL?=
 =?iso-8859-1?Q?JUqSXrDYgdYT1+wbUVcm56kdHxRqxazRpF6kuRJTcZ0M41UiklzTBe5avI?=
 =?iso-8859-1?Q?pykUqbwzsc0fyJiiGpQnHAPldfoxG6w10zEKv/dMTQ5ENTycxPA80zOOoK?=
 =?iso-8859-1?Q?070fdiUb8lnvdetwqwzoyicJn0b4kpYZ2uIkIiyPMqlLErQVJVorkPIyyv?=
 =?iso-8859-1?Q?LBLPYbQTRftpcrRJTe+UBBsv0h9xvp2uUwABWCqr6x+gYSMXnpw0N94kqq?=
 =?iso-8859-1?Q?nvPlRn/aWq0d2VeSBmSHIr+OOXRBY2wIJqXEZgdjizxlCLOe4t6rv/39/A?=
 =?iso-8859-1?Q?O05irRLXPzpoSCP7pzdm+b6PzMLQ53jGQ1luaGGyJk4FEGbv+7YgMMm7xm?=
 =?iso-8859-1?Q?vJbM/KPm5H1beflUcgKJJFYTJwzmA+Pr+mIpUHj8g21B/ziJbbQs3VAQsz?=
 =?iso-8859-1?Q?+U/N5v0nPXPWy3/Sm0/OpngIyk4EOYZQmdy9b/j4s0GaBrVtmUnsD8rwAf?=
 =?iso-8859-1?Q?CwnwSZSsPpxA6PbjVWr3zpmPXJQ0pprP09dQJWq4PI+NtCEqfkNXFanlYq?=
 =?iso-8859-1?Q?BnPDqfukZ8x8qAJegG0CksgIjI5Lv0upqET7asx/n0LKCnYrgHjXy9Hp3R?=
 =?iso-8859-1?Q?NLoO/j0QgUHjqQajz0ul1bFYchY1cHOoUHToW1VOer2ULMmSAi0Yz1tyXY?=
 =?iso-8859-1?Q?B+V4aA0d1R5gMYNmYTKtN3mxvonsketSwPGa1wrRZXNczZ6xlCXmngzqL+?=
 =?iso-8859-1?Q?fI2XwGe4DC6L/CrEtBTQu/fWdKMkNC4wQiWlhUaHZuGkRygFlkOrGbxkDp?=
 =?iso-8859-1?Q?2OnhyRNbLwmckc1apzEM+dOXdVaDdnyKio2cEDe9a+o0dr7ImfReNu5o9W?=
 =?iso-8859-1?Q?T+8b7xxYCkKE3j7Hw6Wd2LArJFFrHtiQPVrZDPM1D0wiAhuaKqXNzdVNXq?=
 =?iso-8859-1?Q?NAxBYl4jPobojz1Ta1rd9tExizEdfu0Rr+aoV5VS6c08/aJIsKM+ePfCrO?=
 =?iso-8859-1?Q?4sNohKq5WLD0WxGzXs2mYiqojjYO9cgUInRqwB6WTpKakgRdDYfLdzgw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f90ad02-1450-464b-d310-08dbbefeefc4
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 02:10:36.3193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /qxiAg/2TOi7ALsoUEkDZnD79ZZh8OsXWPf+imlNgzyIrKcpFbouac+xwJNiNUjm90uFr8BNSPdgs/D/+xAVWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5294
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



Hello,

kernel test robot noticed a 68.5% improvement of stress-ng.iomix.ops_per_sec on:


commit: 77d20c685b6baeb942606a93ed861c191381b73e ("btrfs: do not block starts waiting on previous transaction commit")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: stress-ng
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	nr_threads: 10%
	disk: 1HDD
	testtime: 60s
	fs: btrfs
	class: filesystem
	test: iomix
	cpufreq_governor: performance






Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230926/202309261605.687d7dbf-oliver.sang@intel.com

=========================================================================================
class/compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  filesystem/gcc-12/performance/1HDD/btrfs/x86_64-rhel-8.3/10%/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp8/iomix/stress-ng/60s

commit: 
  ee34a82e89 ("btrfs: release path before inode lookup during the ino lookup ioctl")
  77d20c685b ("btrfs: do not block starts waiting on previous transaction commit")

ee34a82e890a7bab 77d20c685b6baeb942606a93ed8 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     10.78            +3.2       13.99        mpstat.cpu.all.iowait%
      1.10 ±  4%      +0.4        1.51 ±  7%  mpstat.cpu.all.sys%
    122474 ±  6%     -16.0%     102858 ±  8%  numa-vmstat.node0.nr_dirtied
    122310 ±  6%     -16.0%     102793 ±  8%  numa-vmstat.node0.nr_written
     87.40            -4.0%      83.87        iostat.cpu.idle
     10.47           +29.7%      13.58        iostat.cpu.iowait
      1.77 ±  2%     +22.8%       2.18 ±  5%  iostat.cpu.system
    238990 ±  2%     -10.3%     214415        proc-vmstat.nr_dirtied
    238672 ±  2%     -10.2%     214270        proc-vmstat.nr_written
   1293769 ±  3%      -9.7%    1167757        proc-vmstat.pgpgout
     15599 ± 19%     +23.6%      19279 ± 12%  sched_debug.cfs_rq:/.min_vruntime.max
     25733 ±  5%     +22.7%      31572 ± 11%  sched_debug.cpu.nr_switches.avg
     26395 ± 11%     +34.8%      35569 ± 15%  sched_debug.cpu.nr_switches.stddev
     89.50 ±  2%     +17.9%     105.50 ±  4%  turbostat.Avg_MHz
      2.49 ±  2%      +0.4        2.93 ±  4%  turbostat.Busy%
     59654 ± 22%     +45.7%      86940 ± 18%  turbostat.POLL
     19462 ±  3%      -9.1%      17692        vmstat.io.bo
      6.33 ±  7%     +36.8%       8.67 ±  5%  vmstat.procs.b
     45360 ±  5%     +27.3%      57748 ± 12%  vmstat.system.cs
     85369            +6.1%      90557 ±  3%  vmstat.system.in
    938131 ±  4%     +68.8%    1583382 ±  7%  stress-ng.iomix.ops
     15567 ±  4%     +68.5%      26232 ±  7%  stress-ng.iomix.ops_per_sec
   1514861 ±  2%     -12.6%    1323912 ±  2%  stress-ng.time.file_system_outputs
     70.50 ±  5%     +38.8%      97.83 ±  7%  stress-ng.time.percent_of_cpu_this_job_got
     40.18 ±  5%     +41.1%      56.70 ±  7%  stress-ng.time.system_time
   1360628 ±  6%     +29.0%    1755242 ± 13%  stress-ng.time.voluntary_context_switches
 9.543e+08           +25.2%  1.195e+09 ±  4%  perf-stat.i.branch-instructions
      0.64            -0.1        0.59        perf-stat.i.branch-miss-rate%
   8915744 ±  2%      +6.0%    9448037 ±  2%  perf-stat.i.branch-misses
   5192643 ±  8%     +24.8%    6481794 ±  8%  perf-stat.i.cache-misses
  19351415 ±  2%     +17.5%   22733847 ±  5%  perf-stat.i.cache-references
     47660 ±  5%     +27.3%      60669 ± 13%  perf-stat.i.context-switches
      1.13 ±  3%      -7.4%       1.05        perf-stat.i.cpi
     5e+09 ±  3%     +20.8%   6.04e+09 ±  5%  perf-stat.i.cpu-cycles
      0.01 ±  4%      -0.0        0.01 ±  7%  perf-stat.i.dTLB-load-miss-rate%
 1.147e+09 ±  2%     +29.6%  1.486e+09 ±  4%  perf-stat.i.dTLB-loads
      0.01 ±  4%      -0.0        0.00 ±  3%  perf-stat.i.dTLB-store-miss-rate%
 6.597e+08 ±  2%     +31.5%  8.673e+08 ±  5%  perf-stat.i.dTLB-stores
 4.757e+09 ±  2%     +27.1%  6.044e+09 ±  4%  perf-stat.i.instructions
      0.93 ±  2%      +7.6%       1.00        perf-stat.i.ipc
      0.08 ±  3%     +20.9%       0.09 ±  5%  perf-stat.i.metric.GHz
    343.06 ±  4%     +17.4%     402.77 ±  6%  perf-stat.i.metric.K/sec
     43.11 ±  2%     +28.6%      55.43 ±  4%  perf-stat.i.metric.M/sec
    697436 ± 11%     +36.0%     948334 ± 10%  perf-stat.i.node-store-misses
    381863 ±  3%     +15.5%     441021 ±  4%  perf-stat.i.node-stores
      0.93 ±  2%      -0.1        0.79 ±  2%  perf-stat.overall.branch-miss-rate%
      1.05 ±  2%      -4.9%       1.00        perf-stat.overall.cpi
      0.01 ±  3%      -0.0        0.01 ±  8%  perf-stat.overall.dTLB-load-miss-rate%
      0.01 ±  3%      -0.0        0.00 ±  4%  perf-stat.overall.dTLB-store-miss-rate%
      0.95 ±  2%      +5.1%       1.00        perf-stat.overall.ipc
     64.46 ±  2%      +3.7       68.15 ±  2%  perf-stat.overall.node-store-miss-rate%
 9.395e+08           +25.2%  1.176e+09 ±  4%  perf-stat.ps.branch-instructions
   8780421 ±  2%      +5.9%    9294725 ±  2%  perf-stat.ps.branch-misses
   5111666 ±  8%     +24.8%    6379090 ±  8%  perf-stat.ps.cache-misses
  19051781 ±  2%     +17.4%   22373117 ±  5%  perf-stat.ps.cache-references
     46925 ±  5%     +27.2%      59709 ± 13%  perf-stat.ps.context-switches
 4.922e+09 ±  3%     +20.8%  5.944e+09 ±  5%  perf-stat.ps.cpu-cycles
 1.129e+09 ±  2%     +29.6%  1.463e+09 ±  4%  perf-stat.ps.dTLB-loads
 6.493e+08 ±  2%     +31.4%  8.535e+08 ±  5%  perf-stat.ps.dTLB-stores
 4.683e+09 ±  2%     +27.0%  5.947e+09 ±  4%  perf-stat.ps.instructions
    686515 ± 11%     +35.9%     933307 ± 10%  perf-stat.ps.node-store-misses
    375908 ±  3%     +15.5%     434029 ±  4%  perf-stat.ps.node-stores
 2.981e+11 ±  2%     +26.0%  3.757e+11 ±  4%  perf-stat.total.instructions
      0.02 ± 29%     +55.5%       0.03 ± 13%  perf-sched.sch_delay.max.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.__btrfs_tree_read_lock
      0.01 ± 34%    +110.7%       0.03 ± 16%  perf-sched.sch_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.vfs_fileattr_set
      0.01 ± 25%     -65.8%       0.00 ±101%  perf-sched.sch_delay.max.ms.wait_current_trans.start_transaction.btrfs_attach_transaction_barrier.btrfs_sync_fs
      0.01 ± 42%     -67.6%       0.00 ± 17%  perf-sched.sch_delay.max.ms.wait_current_trans.start_transaction.btrfs_sync_file.btrfs_do_write_iter
      9.34 ± 45%     +57.0%      14.66 ±  7%  perf-sched.wait_and_delay.avg.ms.btrfs_start_ordered_extent.btrfs_wait_ordered_range.btrfs_sync_file.btrfs_do_write_iter
     84.12 ±  3%     -23.7%      64.22 ± 16%  perf-sched.wait_and_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
     34.50 ± 10%     -15.3%      29.23 ±  7%  perf-sched.wait_and_delay.avg.ms.io_schedule.folio_wait_bit_common.extent_write_cache_pages.extent_writepages
     92.62 ± 10%     -22.6%      71.73 ±  8%  perf-sched.wait_and_delay.avg.ms.io_schedule.folio_wait_bit_common.filemap_update_page.filemap_get_pages
     89.69 ±  7%     -18.5%      73.14 ±  6%  perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.__fdget_pos
      0.71 ± 20%     -42.5%       0.41 ± 32%  perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.__btrfs_tree_read_lock
     26.52 ± 39%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.wait_current_trans.start_transaction.btrfs_attach_transaction_barrier.btrfs_sync_fs
     81.44 ±  9%     +37.4%     111.87 ± 13%  perf-sched.wait_and_delay.avg.ms.wait_for_commit.btrfs_commit_transaction.iterate_supers.ksys_sync
    105.65 ±  5%     -66.7%      35.14 ±102%  perf-sched.wait_and_delay.avg.ms.wait_for_commit.btrfs_wait_for_commit.btrfs_attach_transaction_barrier.btrfs_sync_fs
      5.50 ±146%    +390.9%      27.00 ± 19%  perf-sched.wait_and_delay.count.btrfs_start_ordered_extent.btrfs_wait_ordered_range.btrfs_sync_file.__x64_sys_fsync
      1332 ±  5%     +26.9%       1690 ± 20%  perf-sched.wait_and_delay.count.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
    895.33 ±  5%     +25.4%       1123 ±  6%  perf-sched.wait_and_delay.count.io_schedule.rq_qos_wait.wbt_wait.__rq_qos_throttle
      1306 ± 10%     +18.7%       1550 ±  6%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.__mutex_lock.constprop.0.__fdget_pos
     30.17 ± 15%    -100.0%       0.00        perf-sched.wait_and_delay.count.wait_current_trans.start_transaction.btrfs_attach_transaction_barrier.btrfs_sync_fs
     71.83 ± 11%    +167.7%     192.33 ±  7%  perf-sched.wait_and_delay.count.wait_current_trans.start_transaction.btrfs_finish_one_ordered.btrfs_work_helper
     51.83 ± 13%    +129.3%     118.83 ± 22%  perf-sched.wait_and_delay.count.wait_for_commit.btrfs_commit_transaction.iterate_supers.ksys_sync
     74.33 ±  8%     -94.4%       4.17 ±114%  perf-sched.wait_and_delay.count.wait_for_commit.btrfs_wait_for_commit.btrfs_attach_transaction_barrier.btrfs_sync_fs
    624.35 ± 14%     -30.4%     434.53 ± 10%  perf-sched.wait_and_delay.max.ms.io_schedule.folio_wait_bit_common.filemap_update_page.filemap_get_pages
      1024 ± 18%     -32.9%     688.00 ± 26%  perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.__btrfs_tree_read_lock
    142.62 ± 54%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.wait_current_trans.start_transaction.btrfs_attach_transaction_barrier.btrfs_sync_fs
    245.46 ± 10%     -72.0%      68.69 ±103%  perf-sched.wait_and_delay.max.ms.wait_for_commit.btrfs_wait_for_commit.btrfs_attach_transaction_barrier.btrfs_sync_fs
      2.31 ± 97%     -86.8%       0.30 ±120%  perf-sched.wait_time.avg.ms.btrfs_commit_transaction.iterate_supers.ksys_sync.__x64_sys_sync
     14.02 ±  9%     -39.5%       8.48 ± 16%  perf-sched.wait_time.avg.ms.btrfs_start_ordered_extent.btrfs_run_ordered_extent_work.btrfs_work_helper.process_one_work
      1.09 ± 43%    +133.9%       2.55 ± 31%  perf-sched.wait_time.avg.ms.btrfs_start_ordered_extent.btrfs_wait_ordered_range.__btrfs_wait_cache_io.btrfs_write_dirty_block_groups
     11.14 ±  5%     +31.5%      14.66 ±  7%  perf-sched.wait_time.avg.ms.btrfs_start_ordered_extent.btrfs_wait_ordered_range.btrfs_sync_file.btrfs_do_write_iter
     84.12 ±  3%     -23.7%      64.22 ± 16%  perf-sched.wait_time.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
     34.49 ± 10%     -15.3%      29.23 ±  7%  perf-sched.wait_time.avg.ms.io_schedule.folio_wait_bit_common.extent_write_cache_pages.extent_writepages
     92.62 ± 10%     -22.6%      71.73 ±  8%  perf-sched.wait_time.avg.ms.io_schedule.folio_wait_bit_common.filemap_update_page.filemap_get_pages
     89.68 ±  7%     -18.5%      73.13 ±  6%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.__fdget_pos
      0.71 ± 20%     -42.5%       0.41 ± 32%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.__btrfs_tree_read_lock
     26.51 ± 39%     -97.6%       0.63 ±159%  perf-sched.wait_time.avg.ms.wait_current_trans.start_transaction.btrfs_attach_transaction_barrier.btrfs_sync_fs
     81.44 ±  9%     +37.4%     111.86 ± 13%  perf-sched.wait_time.avg.ms.wait_for_commit.btrfs_commit_transaction.iterate_supers.ksys_sync
    105.64 ±  5%     -66.7%      35.13 ±102%  perf-sched.wait_time.avg.ms.wait_for_commit.btrfs_wait_for_commit.btrfs_attach_transaction_barrier.btrfs_sync_fs
     62.15 ± 57%     -88.7%       7.03 ± 80%  perf-sched.wait_time.max.ms.__cond_resched.process_one_work.worker_thread.kthread.ret_from_fork
     22.66 ±112%     -89.4%       2.41 ±131%  perf-sched.wait_time.max.ms.btrfs_commit_transaction.iterate_supers.ksys_sync.__x64_sys_sync
    624.35 ± 14%     -30.4%     434.52 ± 10%  perf-sched.wait_time.max.ms.io_schedule.folio_wait_bit_common.filemap_update_page.filemap_get_pages
      1024 ± 18%     -32.9%     687.99 ± 26%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.__btrfs_tree_read_lock
    142.62 ± 54%     -99.0%       1.46 ±171%  perf-sched.wait_time.max.ms.wait_current_trans.start_transaction.btrfs_attach_transaction_barrier.btrfs_sync_fs
    245.46 ± 10%     -72.0%      68.68 ±103%  perf-sched.wait_time.max.ms.wait_for_commit.btrfs_wait_for_commit.btrfs_attach_transaction_barrier.btrfs_sync_fs
     38.11 ±  5%      -9.6       28.47 ±  8%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
     35.07 ±  4%      -7.6       27.50 ±  6%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     36.16 ±  4%      -7.6       28.61 ±  5%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     36.16 ±  4%      -7.5       28.62 ±  5%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
     36.10 ±  4%      -7.5       28.55 ±  5%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     36.87 ±  4%      -7.5       29.33 ±  6%  perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
     33.44 ±  4%      -7.3       26.15 ±  6%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
     33.76 ±  4%      -7.3       26.51 ±  7%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
     32.17 ±  4%      -7.0       25.14 ±  7%  perf-profile.calltrace.cycles-pp.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     17.07 ±  6%      -4.4       12.70 ±  7%  perf-profile.calltrace.cycles-pp.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
     12.51 ±  6%      -3.3        9.23 ±  9%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state
      9.18 ±  4%      -2.4        6.78 ±  9%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter
      8.91 ±  4%      -2.4        6.55 ±  9%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt
      7.62 ±  4%      -2.0        5.65 ±  8%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      6.44 ±  5%      -1.6        4.79 ±  9%  perf-profile.calltrace.cycles-pp.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      5.98 ±  3%      -1.6        4.37 ±  6%  perf-profile.calltrace.cycles-pp.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      5.93 ±  3%      -1.6        4.32 ±  6%  perf-profile.calltrace.cycles-pp.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt
      5.26 ±  3%      -1.5        3.78 ±  6%  perf-profile.calltrace.cycles-pp.scheduler_tick.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues
      3.91 ±  3%      -1.1        2.76 ±  8%  perf-profile.calltrace.cycles-pp.perf_event_task_tick.scheduler_tick.update_process_times.tick_sched_handle.tick_sched_timer
      3.78 ±  3%      -1.1        2.68 ±  8%  perf-profile.calltrace.cycles-pp.perf_adjust_freq_unthr_context.perf_event_task_tick.scheduler_tick.update_process_times.tick_sched_handle
      2.44 ±  5%      -0.8        1.68 ± 13%  perf-profile.calltrace.cycles-pp.__intel_pmu_enable_all.perf_adjust_freq_unthr_context.perf_event_task_tick.scheduler_tick.update_process_times
      2.06 ± 28%      -0.7        1.35 ±  8%  perf-profile.calltrace.cycles-pp.stress_mwc8
      2.12 ± 13%      -0.5        1.61 ± 18%  perf-profile.calltrace.cycles-pp.stress_rndbuf
      0.78 ±  4%      -0.5        0.27 ±100%  perf-profile.calltrace.cycles-pp.iterate_supers.ksys_sync.__x64_sys_sync.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.10 ±  7%      -0.5        1.63 ±  8%  perf-profile.calltrace.cycles-pp.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter
      0.81 ±  5%      -0.4        0.36 ± 70%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.sync
      0.81 ±  5%      -0.4        0.36 ± 70%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.sync
      0.81 ±  5%      -0.4        0.36 ± 70%  perf-profile.calltrace.cycles-pp.sync
      0.80 ±  5%      -0.4        0.36 ± 70%  perf-profile.calltrace.cycles-pp.__x64_sys_sync.do_syscall_64.entry_SYSCALL_64_after_hwframe.sync
      0.80 ±  5%      -0.4        0.36 ± 70%  perf-profile.calltrace.cycles-pp.ksys_sync.__x64_sys_sync.do_syscall_64.entry_SYSCALL_64_after_hwframe.sync
      1.91 ±  8%      -0.4        1.47 ±  8%  perf-profile.calltrace.cycles-pp.__do_softirq.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt
      0.70 ±  8%      -0.4        0.28 ±100%  perf-profile.calltrace.cycles-pp.perf_mux_hrtimer_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      1.89 ± 13%      -0.4        1.48 ±  8%  perf-profile.calltrace.cycles-pp.__mmap
      1.86 ± 13%      -0.4        1.46 ±  8%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__mmap
      1.84 ± 13%      -0.4        1.45 ±  8%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
      0.65 ±  9%      -0.4        0.26 ±100%  perf-profile.calltrace.cycles-pp.rcu_core.__do_softirq.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      1.78 ± 14%      -0.4        1.40 ±  9%  perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
      1.50 ± 11%      -0.3        1.18 ±  8%  perf-profile.calltrace.cycles-pp.__munmap
      1.49 ± 11%      -0.3        1.17 ±  9%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__munmap
      1.46 ± 12%      -0.3        1.15 ±  9%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
      0.95 ± 11%      -0.2        0.74 ±  9%  perf-profile.calltrace.cycles-pp.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
      0.95 ± 12%      -0.2        0.74 ±  9%  perf-profile.calltrace.cycles-pp.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
      0.94 ± 11%      -0.2        0.72 ±  8%  perf-profile.calltrace.cycles-pp.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.90 ± 12%      -0.2        0.70 ±  8%  perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64
      0.65 ± 12%      +0.2        0.80 ±  8%  perf-profile.calltrace.cycles-pp._raw_spin_lock.btrfs_block_rsv_release.btrfs_trans_release_metadata.__btrfs_end_transaction.btrfs_fileattr_set
      0.72 ± 11%      +0.2        0.92 ±  9%  perf-profile.calltrace.cycles-pp.find_extent_buffer.read_block_for_search.btrfs_search_slot.btrfs_lookup_xattr.btrfs_setxattr
      0.89 ± 10%      +0.2        1.10 ±  9%  perf-profile.calltrace.cycles-pp._raw_spin_lock.btrfs_update_root_times.btrfs_update_inode.btrfs_fileattr_set.vfs_fileattr_set
      0.48 ± 45%      +0.2        0.70 ±  7%  perf-profile.calltrace.cycles-pp.wake_up_q.rwsem_wake.up_write.btrfs_release_path.btrfs_free_path
      1.10 ± 11%      +0.2        1.34 ±  7%  perf-profile.calltrace.cycles-pp.join_transaction.start_transaction.btrfs_fileattr_set.vfs_fileattr_set.do_vfs_ioctl
      1.01 ± 10%      +0.2        1.24 ±  7%  perf-profile.calltrace.cycles-pp.btrfs_block_rsv_release.btrfs_trans_release_metadata.__btrfs_end_transaction.btrfs_fileattr_set.vfs_fileattr_set
      0.83 ± 14%      +0.3        1.11 ±  8%  perf-profile.calltrace.cycles-pp._raw_spin_lock.wait_current_trans.start_transaction.btrfs_fileattr_set.vfs_fileattr_set
      0.39 ± 70%      +0.3        0.67 ±  8%  perf-profile.calltrace.cycles-pp.try_to_wake_up.wake_up_q.rwsem_wake.up_write.btrfs_release_path
      1.54 ±  7%      +0.3        1.83 ±  8%  perf-profile.calltrace.cycles-pp.up_write.btrfs_release_path.btrfs_free_path.btrfs_setxattr.btrfs_set_prop
      0.86 ± 11%      +0.3        1.15 ±  7%  perf-profile.calltrace.cycles-pp.__reserve_bytes.btrfs_reserve_metadata_bytes.btrfs_block_rsv_add.start_transaction.btrfs_fileattr_set
      1.22 ±  8%      +0.3        1.51 ±  8%  perf-profile.calltrace.cycles-pp.btrfs_update_root_times.btrfs_update_inode.btrfs_fileattr_set.vfs_fileattr_set.do_vfs_ioctl
      0.92 ± 11%      +0.3        1.22 ±  4%  perf-profile.calltrace.cycles-pp.btrfs_get_delayed_node.btrfs_get_or_create_delayed_node.btrfs_delayed_update_inode.btrfs_update_inode.btrfs_fileattr_set
      0.96 ±  9%      +0.3        1.27 ±  5%  perf-profile.calltrace.cycles-pp.btrfs_get_or_create_delayed_node.btrfs_delayed_update_inode.btrfs_update_inode.btrfs_fileattr_set.vfs_fileattr_set
      1.34 ± 11%      +0.3        1.64 ±  8%  perf-profile.calltrace.cycles-pp.rwsem_down_read_slowpath.down_read.__btrfs_tree_read_lock.btrfs_read_lock_root_node.btrfs_search_slot
      0.93 ± 13%      +0.3        1.24 ±  8%  perf-profile.calltrace.cycles-pp._raw_spin_lock.__btrfs_release_delayed_node.btrfs_delayed_update_inode.btrfs_update_inode.btrfs_fileattr_set
      1.07 ± 13%      +0.3        1.40 ±  7%  perf-profile.calltrace.cycles-pp.wait_current_trans.start_transaction.btrfs_fileattr_set.vfs_fileattr_set.do_vfs_ioctl
      1.18 ± 11%      +0.3        1.52 ±  4%  perf-profile.calltrace.cycles-pp.btrfs_reserve_metadata_bytes.btrfs_block_rsv_add.start_transaction.btrfs_fileattr_set.vfs_fileattr_set
      1.65 ±  8%      +0.3        2.00 ±  6%  perf-profile.calltrace.cycles-pp.read_block_for_search.btrfs_search_slot.btrfs_lookup_xattr.btrfs_setxattr.btrfs_set_prop
      1.66 ±  9%      +0.4        2.04 ±  6%  perf-profile.calltrace.cycles-pp.down_read.__btrfs_tree_read_lock.btrfs_read_lock_root_node.btrfs_search_slot.btrfs_lookup_xattr
      1.70 ±  8%      +0.4        2.09 ±  6%  perf-profile.calltrace.cycles-pp.__btrfs_tree_read_lock.btrfs_read_lock_root_node.btrfs_search_slot.btrfs_lookup_xattr.btrfs_setxattr
      0.18 ±142%      +0.5        0.64 ± 12%  perf-profile.calltrace.cycles-pp._raw_spin_lock.__reserve_bytes.btrfs_reserve_metadata_bytes.btrfs_block_rsv_add.start_transaction
      1.57 ± 10%      +0.5        2.02 ±  5%  perf-profile.calltrace.cycles-pp.btrfs_block_rsv_add.start_transaction.btrfs_fileattr_set.vfs_fileattr_set.do_vfs_ioctl
      2.45 ±  6%      +0.5        2.91 ±  6%  perf-profile.calltrace.cycles-pp.btrfs_free_path.btrfs_setxattr.btrfs_set_prop.btrfs_fileattr_set.vfs_fileattr_set
      2.42 ±  6%      +0.5        2.88 ±  5%  perf-profile.calltrace.cycles-pp.btrfs_release_path.btrfs_free_path.btrfs_setxattr.btrfs_set_prop.btrfs_fileattr_set
      2.28 ±  9%      +0.5        2.81 ±  8%  perf-profile.calltrace.cycles-pp.__btrfs_release_delayed_node.btrfs_delayed_update_inode.btrfs_update_inode.btrfs_fileattr_set.vfs_fileattr_set
      2.82 ±  7%      +0.6        3.44 ±  6%  perf-profile.calltrace.cycles-pp.btrfs_read_lock_root_node.btrfs_search_slot.btrfs_lookup_xattr.btrfs_setxattr.btrfs_set_prop
      2.31 ±  7%      +0.7        2.98 ±  7%  perf-profile.calltrace.cycles-pp.__btrfs_end_transaction.btrfs_fileattr_set.vfs_fileattr_set.do_vfs_ioctl.__x64_sys_ioctl
      4.00 ± 10%      +1.0        5.04 ±  6%  perf-profile.calltrace.cycles-pp.btrfs_delayed_update_inode.btrfs_update_inode.btrfs_fileattr_set.vfs_fileattr_set.do_vfs_ioctl
      5.18 ± 10%      +1.4        6.55 ±  4%  perf-profile.calltrace.cycles-pp.start_transaction.btrfs_fileattr_set.vfs_fileattr_set.do_vfs_ioctl.__x64_sys_ioctl
      5.67 ±  8%      +1.4        7.07 ±  6%  perf-profile.calltrace.cycles-pp.btrfs_update_inode.btrfs_fileattr_set.vfs_fileattr_set.do_vfs_ioctl.__x64_sys_ioctl
     15.31 ±  7%      +2.6       17.87 ±  6%  perf-profile.calltrace.cycles-pp.btrfs_search_slot.btrfs_lookup_xattr.btrfs_setxattr.btrfs_set_prop.btrfs_fileattr_set
     15.72 ±  6%      +2.6       18.32 ±  6%  perf-profile.calltrace.cycles-pp.btrfs_lookup_xattr.btrfs_setxattr.btrfs_set_prop.btrfs_fileattr_set.vfs_fileattr_set
     24.78 ±  5%      +4.4       29.22 ±  4%  perf-profile.calltrace.cycles-pp.btrfs_setxattr.btrfs_set_prop.btrfs_fileattr_set.vfs_fileattr_set.do_vfs_ioctl
     25.42 ±  5%      +4.6       30.02 ±  4%  perf-profile.calltrace.cycles-pp.btrfs_set_prop.btrfs_fileattr_set.vfs_fileattr_set.do_vfs_ioctl.__x64_sys_ioctl
     39.35 ±  4%      +8.3       47.63 ±  4%  perf-profile.calltrace.cycles-pp.btrfs_fileattr_set.vfs_fileattr_set.do_vfs_ioctl.__x64_sys_ioctl.do_syscall_64
     40.81 ±  4%      +8.5       49.35 ±  4%  perf-profile.calltrace.cycles-pp.vfs_fileattr_set.do_vfs_ioctl.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64_after_hwframe
     41.93 ±  4%      +8.9       50.85 ±  4%  perf-profile.calltrace.cycles-pp.do_vfs_ioctl.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64_after_hwframe.ioctl
     42.42 ±  4%      +9.1       51.55 ±  4%  perf-profile.calltrace.cycles-pp.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64_after_hwframe.ioctl
     43.04 ±  4%      +9.3       52.32 ±  4%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.ioctl
     43.27 ±  4%      +9.3       52.62 ±  4%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.ioctl
     44.39 ±  4%      +9.6       54.00 ±  4%  perf-profile.calltrace.cycles-pp.ioctl
     35.78 ±  4%      -7.6       28.18 ±  6%  perf-profile.children.cycles-pp.cpuidle_idle_call
     36.16 ±  4%      -7.5       28.62 ±  5%  perf-profile.children.cycles-pp.start_secondary
     36.87 ±  4%      -7.5       29.33 ±  6%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
     36.87 ±  4%      -7.5       29.33 ±  6%  perf-profile.children.cycles-pp.cpu_startup_entry
     36.86 ±  4%      -7.5       29.32 ±  6%  perf-profile.children.cycles-pp.do_idle
     34.09 ±  4%      -7.3       26.77 ±  6%  perf-profile.children.cycles-pp.cpuidle_enter
     33.93 ±  4%      -7.3       26.64 ±  6%  perf-profile.children.cycles-pp.cpuidle_enter_state
     32.32 ±  4%      -7.0       25.28 ±  6%  perf-profile.children.cycles-pp.acpi_idle_enter
     32.26 ±  4%      -7.0       25.24 ±  6%  perf-profile.children.cycles-pp.acpi_safe_halt
     26.04 ±  5%      -6.5       19.51 ±  8%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
     12.94 ±  6%      -3.3        9.60 ±  9%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      9.50 ±  4%      -2.5        7.05 ±  9%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      9.23 ±  4%      -2.4        6.82 ±  9%  perf-profile.children.cycles-pp.hrtimer_interrupt
      7.93 ±  4%      -2.0        5.90 ±  8%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      6.68 ±  5%      -1.7        5.00 ±  8%  perf-profile.children.cycles-pp.tick_sched_timer
      6.20 ±  3%      -1.6        4.56 ±  6%  perf-profile.children.cycles-pp.tick_sched_handle
      6.16 ±  3%      -1.6        4.52 ±  5%  perf-profile.children.cycles-pp.update_process_times
      5.46 ±  3%      -1.5        3.94 ±  6%  perf-profile.children.cycles-pp.scheduler_tick
      4.03 ±  3%      -1.2        2.86 ±  7%  perf-profile.children.cycles-pp.perf_event_task_tick
      4.00 ±  3%      -1.2        2.84 ±  8%  perf-profile.children.cycles-pp.perf_adjust_freq_unthr_context
      2.87 ±  4%      -0.9        2.00 ± 12%  perf-profile.children.cycles-pp.__intel_pmu_enable_all
      2.44 ± 15%      -0.5        1.91 ±  8%  perf-profile.children.cycles-pp.stress_mwc8
      2.40 ±  7%      -0.5        1.87 ±  8%  perf-profile.children.cycles-pp.__irq_exit_rcu
      2.18 ±  8%      -0.5        1.69 ±  7%  perf-profile.children.cycles-pp.__do_softirq
      1.96 ± 13%      -0.4        1.53 ±  8%  perf-profile.children.cycles-pp.stress_rndbuf
      1.90 ± 13%      -0.4        1.49 ±  8%  perf-profile.children.cycles-pp.__mmap
      1.07 ± 34%      -0.4        0.66 ± 30%  perf-profile.children.cycles-pp.ktime_get
      1.88 ± 13%      -0.4        1.49 ±  8%  perf-profile.children.cycles-pp.vm_mmap_pgoff
      1.52 ± 12%      -0.3        1.19 ±  9%  perf-profile.children.cycles-pp.__munmap
      0.80 ±  5%      -0.3        0.52 ±  7%  perf-profile.children.cycles-pp.__x64_sys_sync
      0.80 ±  5%      -0.3        0.52 ±  7%  perf-profile.children.cycles-pp.ksys_sync
      0.81 ±  5%      -0.3        0.52 ±  6%  perf-profile.children.cycles-pp.sync
      0.96 ± 11%      -0.2        0.74 ±  9%  perf-profile.children.cycles-pp.__x64_sys_munmap
      0.75 ±  7%      -0.2        0.53 ± 12%  perf-profile.children.cycles-pp.perf_mux_hrtimer_handler
      0.68 ±  4%      -0.2        0.46 ±  9%  perf-profile.children.cycles-pp.btrfs_commit_transaction
      0.96 ± 11%      -0.2        0.75 ±  9%  perf-profile.children.cycles-pp.__vm_munmap
      0.99 ± 11%      -0.2        0.78 ±  9%  perf-profile.children.cycles-pp.do_vmi_munmap
      1.00 ±  7%      -0.2        0.80 ±  8%  perf-profile.children.cycles-pp.do_writepages
      0.94 ± 11%      -0.2        0.74 ±  9%  perf-profile.children.cycles-pp.do_vmi_align_munmap
      0.70 ± 11%      -0.2        0.51 ±  7%  perf-profile.children.cycles-pp.rcu_core
      0.63 ± 11%      -0.2        0.48 ±  5%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.68 ±  8%      -0.2        0.52 ±  8%  perf-profile.children.cycles-pp.btrfs_submit_bio
      0.67 ±  8%      -0.2        0.52 ±  8%  perf-profile.children.cycles-pp.btrfs_submit_chunk
      0.66 ±  7%      -0.2        0.51 ±  9%  perf-profile.children.cycles-pp.btree_write_cache_pages
      0.64 ±  7%      -0.1        0.50 ± 10%  perf-profile.children.cycles-pp.submit_eb_page
      0.50 ±  9%      -0.1        0.35 ±  7%  perf-profile.children.cycles-pp.handle_mm_fault
      0.53 ±  5%      -0.1        0.40 ± 10%  perf-profile.children.cycles-pp.btree_csum_one_bio
      0.59 ±  9%      -0.1        0.46 ±  8%  perf-profile.children.cycles-pp.wb_workfn
      0.58 ± 10%      -0.1        0.45 ±  8%  perf-profile.children.cycles-pp.wb_do_writeback
      0.47 ± 10%      -0.1        0.34 ±  9%  perf-profile.children.cycles-pp.__handle_mm_fault
      0.48 ±  5%      -0.1        0.36 ± 11%  perf-profile.children.cycles-pp.btrfs_check_leaf
      0.48 ±  5%      -0.1        0.36 ± 11%  perf-profile.children.cycles-pp.__btrfs_check_leaf
      0.51 ± 11%      -0.1        0.38 ± 10%  perf-profile.children.cycles-pp.__mm_populate
      0.54 ±  8%      -0.1        0.41 ±  7%  perf-profile.children.cycles-pp.__writeback_single_inode
      0.62 ± 14%      -0.1        0.50 ±  5%  perf-profile.children.cycles-pp.load_balance
      0.48 ± 11%      -0.1        0.36 ± 11%  perf-profile.children.cycles-pp.populate_vma_page_range
      0.54 ±  9%      -0.1        0.42 ±  8%  perf-profile.children.cycles-pp.wb_writeback
      0.50 ± 13%      -0.1        0.38 ± 15%  perf-profile.children.cycles-pp.clockevents_program_event
      0.54 ±  8%      -0.1        0.41 ±  7%  perf-profile.children.cycles-pp.writeback_sb_inodes
      0.48 ±  7%      -0.1        0.36 ± 16%  perf-profile.children.cycles-pp.perf_rotate_context
      0.39 ± 11%      -0.1        0.28 ± 10%  perf-profile.children.cycles-pp.do_fault
      0.36 ± 16%      -0.1        0.26 ± 14%  perf-profile.children.cycles-pp.unmap_vmas
      0.48 ± 10%      -0.1        0.37 ± 11%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.43 ± 10%      -0.1        0.32 ±  9%  perf-profile.children.cycles-pp.__get_user_pages
      0.38 ± 12%      -0.1        0.28 ± 10%  perf-profile.children.cycles-pp.do_read_fault
      0.35 ± 18%      -0.1        0.25 ± 14%  perf-profile.children.cycles-pp.unmap_page_range
      0.49 ± 16%      -0.1        0.39 ±  7%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.50 ± 15%      -0.1        0.40 ±  6%  perf-profile.children.cycles-pp.find_busiest_group
      0.54 ± 13%      -0.1        0.44 ±  9%  perf-profile.children.cycles-pp.exit_to_user_mode_loop
      0.34 ± 17%      -0.1        0.24 ± 14%  perf-profile.children.cycles-pp.zap_pmd_range
      0.34 ± 16%      -0.1        0.24 ± 15%  perf-profile.children.cycles-pp.zap_pte_range
      0.25 ± 13%      -0.1        0.16 ± 16%  perf-profile.children.cycles-pp.btrfs_run_delayed_refs
      0.25 ± 12%      -0.1        0.15 ± 16%  perf-profile.children.cycles-pp.__btrfs_run_delayed_refs
      0.42 ± 13%      -0.1        0.32 ± 12%  perf-profile.children.cycles-pp.unmap_region
      0.54 ±  9%      -0.1        0.45 ± 10%  perf-profile.children.cycles-pp.native_sched_clock
      0.34 ± 12%      -0.1        0.25 ± 14%  perf-profile.children.cycles-pp.rcu_do_batch
      0.39 ± 12%      -0.1        0.31 ±  6%  perf-profile.children.cycles-pp.update_sg_lb_stats
      0.35 ± 12%      -0.1        0.27 ± 14%  perf-profile.children.cycles-pp.run_rebalance_domains
      0.36 ± 11%      -0.1        0.28 ± 11%  perf-profile.children.cycles-pp.irqtime_account_irq
      0.34 ± 13%      -0.1        0.27 ± 12%  perf-profile.children.cycles-pp.update_blocked_averages
      0.20 ± 11%      -0.1        0.13 ± 18%  perf-profile.children.cycles-pp.btrfs_run_delayed_refs_for_head
      0.47 ±  9%      -0.1        0.40 ±  9%  perf-profile.children.cycles-pp.sched_clock
      0.17 ± 19%      -0.1        0.11 ± 11%  perf-profile.children.cycles-pp.exc_page_fault
      0.17 ± 19%      -0.1        0.11 ± 11%  perf-profile.children.cycles-pp.do_user_addr_fault
      0.20 ± 15%      -0.1        0.14 ±  9%  perf-profile.children.cycles-pp.asm_exc_page_fault
      0.11 ± 33%      -0.1        0.05 ± 49%  perf-profile.children.cycles-pp.__mod_lruvec_page_state
      0.17 ± 14%      -0.1        0.11 ±  8%  perf-profile.children.cycles-pp.__btrfs_write_out_cache
      0.17 ± 14%      -0.1        0.11 ±  8%  perf-profile.children.cycles-pp.btrfs_write_out_cache
      0.10 ±  5%      -0.1        0.05 ± 73%  perf-profile.children.cycles-pp.timerqueue_del
      0.09 ± 30%      -0.1        0.04 ± 73%  perf-profile.children.cycles-pp.crc_pcl
      0.11 ± 12%      -0.1        0.06 ±  9%  perf-profile.children.cycles-pp.commit_cowonly_roots
      0.10 ± 15%      -0.0        0.05 ± 45%  perf-profile.children.cycles-pp.btrfs_write_dirty_block_groups
      0.12 ± 22%      -0.0        0.08 ± 27%  perf-profile.children.cycles-pp.pagecache_get_page
      0.07 ±  7%      -0.0        0.03 ±100%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.14 ± 20%      -0.0        0.10 ±  7%  perf-profile.children.cycles-pp.perf_pmu_nop_void
      0.11 ± 14%      -0.0        0.07 ± 17%  perf-profile.children.cycles-pp.__btrfs_free_extent
      0.08 ± 14%      -0.0        0.04 ± 71%  perf-profile.children.cycles-pp.__x64_sys_exit_group
      0.08 ± 14%      -0.0        0.04 ± 71%  perf-profile.children.cycles-pp.do_group_exit
      0.08 ± 14%      -0.0        0.04 ± 71%  perf-profile.children.cycles-pp.do_exit
      0.08 ± 16%      -0.0        0.04 ± 45%  perf-profile.children.cycles-pp.exit_mmap
      0.08 ± 17%      -0.0        0.04 ± 45%  perf-profile.children.cycles-pp.__mmput
      0.13 ± 10%      -0.0        0.10 ±  5%  perf-profile.children.cycles-pp.x86_pmu_disable
      0.08 ± 16%      -0.0        0.05 ± 46%  perf-profile.children.cycles-pp.filemap_map_pages
      0.24 ±  7%      +0.0        0.28 ± 10%  perf-profile.children.cycles-pp.btrfs_inode_flags_to_fsflags
      0.22 ±  6%      +0.1        0.27 ±  9%  perf-profile.children.cycles-pp.unlock_up
      0.14 ± 13%      +0.1        0.19 ± 12%  perf-profile.children.cycles-pp.inode_get_bytes
      0.13 ± 20%      +0.1        0.19 ± 10%  perf-profile.children.cycles-pp.strcmp
      0.22 ±  9%      +0.1        0.29 ± 11%  perf-profile.children.cycles-pp.__smp_call_single_queue
      0.16 ± 21%      +0.1        0.22 ± 16%  perf-profile.children.cycles-pp.inode_maybe_inc_iversion
      0.34 ± 16%      +0.1        0.43 ± 10%  perf-profile.children.cycles-pp.fill_stack_inode_item
      0.39 ±  9%      +0.1        0.49 ±  9%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      0.30 ± 13%      +0.1        0.40 ± 12%  perf-profile.children.cycles-pp.__fget_light
      0.35 ±  9%      +0.1        0.46 ± 12%  perf-profile.children.cycles-pp.btrfs_put_transaction
      0.32 ± 12%      +0.1        0.43 ±  9%  perf-profile.children.cycles-pp.__radix_tree_lookup
      0.43 ± 13%      +0.1        0.55 ± 10%  perf-profile.children.cycles-pp.fileattr_set_prepare
      0.26 ±  9%      +0.1        0.39 ±  7%  perf-profile.children.cycles-pp.__get_user_4
      0.54 ±  7%      +0.1        0.69 ± 14%  perf-profile.children.cycles-pp.find_prop_handler
      0.47 ± 11%      +0.1        0.61 ±  6%  perf-profile.children.cycles-pp.find_extent_buffer_nolock
      0.70 ± 11%      +0.2        0.86 ±  9%  perf-profile.children.cycles-pp.wake_up_q
      0.88 ±  7%      +0.2        1.08 ±  6%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.86 ± 10%      +0.2        1.06 ±  7%  perf-profile.children.cycles-pp.find_extent_buffer
      1.12 ± 11%      +0.2        1.36 ±  7%  perf-profile.children.cycles-pp.join_transaction
      1.05 ± 10%      +0.3        1.30 ±  6%  perf-profile.children.cycles-pp.btrfs_block_rsv_release
      1.24 ±  8%      +0.3        1.53 ±  8%  perf-profile.children.cycles-pp.btrfs_update_root_times
      0.93 ± 11%      +0.3        1.23 ±  4%  perf-profile.children.cycles-pp.btrfs_get_delayed_node
      1.96 ±  6%      +0.3        2.27 ±  8%  perf-profile.children.cycles-pp.up_write
      0.98 ±  9%      +0.3        1.28 ±  5%  perf-profile.children.cycles-pp.btrfs_get_or_create_delayed_node
      0.90 ± 12%      +0.3        1.21 ±  7%  perf-profile.children.cycles-pp.__reserve_bytes
      1.46 ± 11%      +0.3        1.79 ±  3%  perf-profile.children.cycles-pp.btrfs_root_node
      1.11 ± 13%      +0.3        1.44 ±  7%  perf-profile.children.cycles-pp.wait_current_trans
      1.44 ± 12%      +0.4        1.79 ±  8%  perf-profile.children.cycles-pp.rwsem_down_read_slowpath
      1.87 ±  8%      +0.4        2.22 ±  5%  perf-profile.children.cycles-pp.read_block_for_search
      1.19 ± 11%      +0.4        1.54 ±  4%  perf-profile.children.cycles-pp.btrfs_reserve_metadata_bytes
      1.82 ±  9%      +0.4        2.26 ±  6%  perf-profile.children.cycles-pp.down_read
      1.83 ±  9%      +0.5        2.28 ±  6%  perf-profile.children.cycles-pp.__btrfs_tree_read_lock
      2.46 ±  6%      +0.5        2.92 ±  5%  perf-profile.children.cycles-pp.btrfs_free_path
      1.58 ± 11%      +0.5        2.04 ±  5%  perf-profile.children.cycles-pp.btrfs_block_rsv_add
      2.46 ±  6%      +0.5        2.93 ±  5%  perf-profile.children.cycles-pp.btrfs_release_path
      2.33 ± 10%      +0.5        2.87 ±  8%  perf-profile.children.cycles-pp.__btrfs_release_delayed_node
      2.35 ±  7%      +0.7        3.02 ±  7%  perf-profile.children.cycles-pp.__btrfs_end_transaction
      3.08 ±  8%      +0.7        3.76 ±  5%  perf-profile.children.cycles-pp.btrfs_read_lock_root_node
      4.06 ± 10%      +1.1        5.12 ±  6%  perf-profile.children.cycles-pp.btrfs_delayed_update_inode
      5.27 ± 10%      +1.4        6.64 ±  4%  perf-profile.children.cycles-pp.start_transaction
      5.72 ±  8%      +1.4        7.11 ±  6%  perf-profile.children.cycles-pp.btrfs_update_inode
     15.73 ±  6%      +2.6       18.33 ±  6%  perf-profile.children.cycles-pp.btrfs_lookup_xattr
     17.09 ±  6%      +2.8       19.89 ±  6%  perf-profile.children.cycles-pp.btrfs_search_slot
     24.80 ±  5%      +4.4       29.24 ±  4%  perf-profile.children.cycles-pp.btrfs_setxattr
     25.44 ±  5%      +4.6       30.03 ±  4%  perf-profile.children.cycles-pp.btrfs_set_prop
     39.40 ±  4%      +8.3       47.68 ±  4%  perf-profile.children.cycles-pp.btrfs_fileattr_set
     54.40 ±  3%      +8.4       62.75 ±  3%  perf-profile.children.cycles-pp.do_syscall_64
     54.62 ±  3%      +8.4       63.01 ±  3%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     40.88 ±  4%      +8.6       49.44 ±  4%  perf-profile.children.cycles-pp.vfs_fileattr_set
     41.99 ±  4%      +9.0       50.94 ±  4%  perf-profile.children.cycles-pp.do_vfs_ioctl
     42.48 ±  4%      +9.2       51.65 ±  4%  perf-profile.children.cycles-pp.__x64_sys_ioctl
     44.82 ±  4%      +9.6       54.45 ±  4%  perf-profile.children.cycles-pp.ioctl
     16.97 ±  5%      -3.4       13.59 ±  6%  perf-profile.self.cycles-pp.acpi_safe_halt
      2.87 ±  4%      -0.9        2.00 ± 12%  perf-profile.self.cycles-pp.__intel_pmu_enable_all
      1.91 ± 16%      -0.4        1.50 ±  8%  perf-profile.self.cycles-pp.stress_mwc8
      1.29 ± 13%      -0.3        0.97 ±  7%  perf-profile.self.cycles-pp.stress_rndbuf
      1.23 ±  6%      -0.3        0.92 ±  4%  perf-profile.self.cycles-pp.perf_adjust_freq_unthr_context
      0.63 ± 12%      -0.2        0.48 ±  5%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.26 ±  9%      -0.1        0.17 ± 11%  perf-profile.self.cycles-pp.cpuidle_idle_call
      0.22 ±  8%      -0.1        0.17 ± 12%  perf-profile.self.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.13 ± 12%      -0.1        0.08 ± 23%  perf-profile.self.cycles-pp.__hrtimer_run_queues
      0.09 ± 30%      -0.1        0.04 ± 73%  perf-profile.self.cycles-pp.crc_pcl
      0.12 ± 23%      -0.0        0.08 ± 10%  perf-profile.self.cycles-pp.scheduler_tick
      0.16 ± 13%      -0.0        0.12 ± 12%  perf-profile.self.cycles-pp.cpuidle_enter
      0.11 ± 16%      -0.0        0.08 ±  4%  perf-profile.self.cycles-pp.x86_pmu_disable
      0.12 ± 11%      -0.0        0.10 ± 16%  perf-profile.self.cycles-pp.note_gp_changes
      0.08 ± 17%      +0.0        0.12 ±  8%  perf-profile.self.cycles-pp.btrfs_delayed_update_inode
      0.07 ± 49%      +0.0        0.11 ± 15%  perf-profile.self.cycles-pp.fill_stack_inode_item
      0.07 ± 18%      +0.0        0.11 ±  9%  perf-profile.self.cycles-pp.crc32c_pcl_intel_update
      0.05 ± 49%      +0.0        0.09 ± 14%  perf-profile.self.cycles-pp.current_time
      0.10 ± 17%      +0.1        0.16 ± 15%  perf-profile.self.cycles-pp.fileattr_set_prepare
      0.13 ± 22%      +0.1        0.19 ± 10%  perf-profile.self.cycles-pp.strcmp
      0.19 ±  9%      +0.1        0.26 ±  9%  perf-profile.self.cycles-pp.unlock_up
      0.23 ± 14%      +0.1        0.30 ±  6%  perf-profile.self.cycles-pp.btrfs_fileattr_set
      0.23 ± 15%      +0.1        0.30 ±  8%  perf-profile.self.cycles-pp.vfs_fileattr_set
      0.31 ± 16%      +0.1        0.38 ± 13%  perf-profile.self.cycles-pp.rwsem_mark_wake
      0.15 ± 22%      +0.1        0.22 ± 17%  perf-profile.self.cycles-pp.inode_maybe_inc_iversion
      0.16 ± 11%      +0.1        0.23 ± 10%  perf-profile.self.cycles-pp.__schedule
      0.24 ± 18%      +0.1        0.31 ± 11%  perf-profile.self.cycles-pp.wait_current_trans
      0.48 ±  8%      +0.1        0.56 ±  8%  perf-profile.self.cycles-pp.kmem_cache_alloc
      0.14 ± 14%      +0.1        0.23 ± 11%  perf-profile.self.cycles-pp.__x64_sys_ioctl
      0.29 ± 11%      +0.1        0.39 ± 12%  perf-profile.self.cycles-pp.__fget_light
      0.71 ±  6%      +0.1        0.81 ± 10%  perf-profile.self.cycles-pp.down_write
      0.26 ± 15%      +0.1        0.37 ± 11%  perf-profile.self.cycles-pp.btrfs_setxattr
      0.34 ±  8%      +0.1        0.45 ± 13%  perf-profile.self.cycles-pp.btrfs_put_transaction
      0.31 ± 11%      +0.1        0.42 ±  9%  perf-profile.self.cycles-pp.__radix_tree_lookup
      0.21 ± 16%      +0.1        0.32 ± 15%  perf-profile.self.cycles-pp.do_vfs_ioctl
      0.25 ± 11%      +0.1        0.38 ±  7%  perf-profile.self.cycles-pp.__get_user_4
      0.42 ± 15%      +0.2        0.58 ± 11%  perf-profile.self.cycles-pp.rwsem_down_read_slowpath
      0.89 ± 11%      +0.2        1.11 ± 10%  perf-profile.self.cycles-pp.start_transaction
      0.81 ± 12%      +0.2        1.04 ±  9%  perf-profile.self.cycles-pp.__btrfs_end_transaction
      1.28 ±  4%      +0.3        1.56 ±  7%  perf-profile.self.cycles-pp.btrfs_search_slot
      0.93 ± 11%      +0.3        1.22 ±  4%  perf-profile.self.cycles-pp.btrfs_get_delayed_node
      1.45 ± 11%      +0.3        1.77 ±  3%  perf-profile.self.cycles-pp.btrfs_root_node
      1.80 ±  3%      +0.3        2.12 ±  4%  perf-profile.self.cycles-pp.rwsem_optimistic_spin
      5.38 ±  7%      +1.2        6.58 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

