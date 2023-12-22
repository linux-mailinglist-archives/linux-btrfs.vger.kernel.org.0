Return-Path: <linux-btrfs+bounces-1127-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D3D81C7B2
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Dec 2023 11:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A3E81F253B6
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Dec 2023 10:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53ECFFBF2;
	Fri, 22 Dec 2023 09:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f12onzap"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F3AFBE4
	for <linux-btrfs@vger.kernel.org>; Fri, 22 Dec 2023 09:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703239193; x=1734775193;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=WxUWAiQ8e3ISa+kvXVQq848zH4/Gk8lwYX4mcSp9veQ=;
  b=f12onzapkGvYdUFjz4544bm46LE/xjQ/rS35pP0z2HLzUY69ZLvTvA6T
   BUQKltzOJSjZqAfPba0GBbhaFMglHQHBKJKXxSJF4cTThsfqXgm1zBkAm
   L6JSxQezbcQAPiiEmjn90kEjLSp9Zury/B8+lmeRDH3VXPO+Ikqb/B3+0
   Q8uFZDjTOBPb/VCG+BOebkLtpZhmYQK2k1C7uRrWlR0J5gUzD5/TvKW2m
   ngeRI3LSnGVj5rnlmIf1/QGusIRZRbSDuPLP9oWqqsKjnq3cGtSi4iDWs
   4IPYD/QoM+L4nC8PMXetfVQUDWoYQTMLz7FXgO6Um/sR8Vxtpas8UjP24
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="394992078"
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="394992078"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 01:59:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="847415841"
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="847415841"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Dec 2023 01:59:52 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 22 Dec 2023 01:59:51 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 22 Dec 2023 01:59:51 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 22 Dec 2023 01:59:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n+Bw6Zoz21fuAGOIt/PW3uogILG7yfQ6N+jPG4etK+E0qfUDWhQcWBJ/tO3mktHl+0nYcoISM4wf+5k7pn0T1VqW99T5U6hvLuwJAcSnrObYYam2tUTji9BFTDhnM1eECmM6YC6OHdqNX/wS8HE1Uodxeqcvu3jb4lTO9LYpRe12pdiKLIK36VoEPM9t+vSbtaF9CnUPmOSxX5gR67wnl1mKyFQfoMjaiiG5D7l5RvAWQEXcUFcWS11AYZZORZJksp1CN02jxV1kKc3LWdMs38Vln88OOxLAXPM8DF3loZMOPEtamAEyM4kSsgCDv4jZxyKzsLLF5XfUEBKVWIglDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HGy6A/c7PQ7Oons5Jt8tlh5A+witFMCSIhhaVujMFS8=;
 b=kt6JbuiOHbVbFuEwU1+Kgm2zJbT4V44nZeVfJnz4lRsj6RgsBu+sQ2/QiEogzSWtsEdBti4QYrtuOtUDYRpcBNpPmWNtJGT+nlf64JXeuTILf+cVfBrv99LembwYc0JtklZSgPQQEkrIJ7/scuNI4e3+MF/0KB7hpP5RwcTjFw+GKVFbkh5w/OddzqKL+9Iu+Y3eu8XRM5rZzWzwUNW1tKCb449J2o0PW9cGx+6lnadX27YL+2gR82YhvHHsXxQndFIZmHFoVQ3XXxfs5JdKMxKw/Pk+v0OkNN5AHF6AO53YhN6u+E7XPw1+aScF2P95yF3JjTZ9QvGqUTvIiJejKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MN6PR11MB8145.namprd11.prod.outlook.com (2603:10b6:208:474::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Fri, 22 Dec
 2023 09:59:44 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f%3]) with mapi id 15.20.7113.019; Fri, 22 Dec 2023
 09:59:44 +0000
Date: Fri, 22 Dec 2023 17:59:34 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Qu Wenruo <wqu@suse.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, David Sterba <dsterba@suse.com>,
	<linux-btrfs@vger.kernel.org>, <ying.huang@intel.com>, <feng.tang@intel.com>,
	<fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: [linux-next:master] [btrfs]  8d99361835:  stress-ng.link.ops_per_sec
 -18.0% regression
Message-ID: <202312221750.571925bd-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::6)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MN6PR11MB8145:EE_
X-MS-Office365-Filtering-Correlation-Id: 68b1e232-b670-410a-24f8-08dc02d4b922
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rh4eAHfOkc6yjn8ZC/m4jsOlRb6mJqL8M7M6TKkvVNUY3Z9Nqb/XRem5oydf6tkCw7fUjYWlgoIaaPWpVSFjqnd3/Uj5UcWpLetTUvL3nsQciBZOgCCApdlD8M1K4YW/VtPtayXRomR7kOYiw6NG72ciqGme4O32Wd5LlYCtJ/GwaprLup4MwyynC3yhQlhmyqgx4c92IZnMkQJYoCXxBXkMKgA7IjtXVC2hEOyIwH7JBFYAg2rKK11u86tSC/RAWpE1m527YCK6OX31iL0Jttm+ycaPK/65R4ICRbP48LJ4vubR9DYvFdwOKK3iFZOHlO5ql/WthLi+nSj5C/Na2uaArd8W5f6oO4JoPOKKynewcp63Z3R0PNf8Gkr8wVYII8lZwiP9dBaVMyx+XYAB3KeXK+Mh8gwBPeD+rYTcy+jggbhK9q3zlgdGBL6y3V2kUKnSyNG8ZLDmMqvR5cjvr5LftmK/sZYXolqqw0p6hLi763e8PNUwnmFtLKEwGZa7VFdi2iC5yl5b/Ef2boAu3TD1CgpXBnufzxLDygWqw6aKALG2MrhZt5Z2qXUMN9tl5838OXyKpEqS5gNbx9ObwYV5QyGYg5gRzCVMhF4tFgUYubKHjHBJdh0V25XT/V68fCT5+U9y3gW0rfw1i39A1gJ2Rsv086J64qJET6ZnoCU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(376002)(136003)(366004)(230922051799003)(230373577357003)(230473577357003)(186009)(451199024)(1800799012)(64100799003)(1076003)(26005)(2616005)(83380400001)(107886003)(6506007)(6512007)(6666004)(5660300002)(30864003)(2906002)(316002)(41300700001)(8676002)(478600001)(966005)(6486002)(8936002)(6916009)(66476007)(66556008)(4326008)(66946007)(54906003)(36756003)(86362001)(38100700002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?tZRaM1AmufNfOIKFTJ5BIx/wmmPsCiUrkxugcLK7lLCCy1SiYTuucDw/+c?=
 =?iso-8859-1?Q?fcLyncVBjpPUtO1d41O3O96q4ptBeoF3vZMjMDVTf4CcKGmioejrkLE+9w?=
 =?iso-8859-1?Q?1ZkGsafpnv9J28wC06IZhVe/KS0hpqwrq4ZZXzNcLVYmgf0tRXLR3vzuBU?=
 =?iso-8859-1?Q?M20RHMOfyTjqHId+Z+5kHkjYi2azJaJ4kORcTJbWqSVqnGKdNK3Aa3BW11?=
 =?iso-8859-1?Q?iUZ24L3CrRnWrLpsBBayC4fBfOzI7rtADNg78I/zJYgjY9kYLLO5Ml17F2?=
 =?iso-8859-1?Q?5lSotK5JzPIjIV47F4pxM3ZCsmdmBxe04xb24xLo+QHjCMBe87qwadJ6JZ?=
 =?iso-8859-1?Q?9StgpCzgd4e0r7WqQpFi5JElIYOKjwS9vFAAI1vbwVJFRW597qbcqlLzPq?=
 =?iso-8859-1?Q?UC07f7rDcoha6S/cxUS5CKW0+twEZZ7F/AhNIJOKh4EZG9bXf5N925SvyS?=
 =?iso-8859-1?Q?FGRiRKwXAciraAApldw/FDDjgIfjkqR28DXyyYXgVSRzv+Jpx2xMOX7Ar3?=
 =?iso-8859-1?Q?BTnjYvQy/fUG155tooq9K0hTRzVOa4B57HFGlRsgKq6tJsmZHkWuDCpfMB?=
 =?iso-8859-1?Q?gp2eASolnOWrhV2+yn3/37oCiKWpELQuqVtzrvtACHo/e1r10Z2mEU4XRf?=
 =?iso-8859-1?Q?gbydwDchiudGOhZ6T3G5z0YLGyWR+VIzocziJYQw2Y0ZiLqxftIVUVrzqE?=
 =?iso-8859-1?Q?woj0wXuWsehgf0ehgVmFNLEbTPDl9kwnBM3Q2QGg1WpTcc9Lv37bJg1wG6?=
 =?iso-8859-1?Q?wl11r7ORAxfo6YpmTAtNtExpkjUjMfjwpevH2oAvKy2GPK8Guo/XpUKNtQ?=
 =?iso-8859-1?Q?XdZN8rwkHRhiTljysNraCyo9cud+MzxoRk6JpuyK6P87u8hRPUCFY2UXd2?=
 =?iso-8859-1?Q?3TXYnXyRQ58suYKHLVIHG7Bui6yecuKjDC3qYdwWsgsWmjIZbVijZbnAcq?=
 =?iso-8859-1?Q?aVhydb0nruNPPgOIY4ztxb/YUFLbIFceXLEiEEEPu8s5tirsBcV3jxkOEL?=
 =?iso-8859-1?Q?I9u2hJOh72W/oNnIMhsi1mYC3tD0Bdl2jFJ6FCzW7KcOXV77l65yy064K9?=
 =?iso-8859-1?Q?vUtXhPXz5HJxPNkHlQCnlVZmhl1xHkhwyyYb0NQJOLNp8jrgIwvfLgi2Yi?=
 =?iso-8859-1?Q?MMKWuzejwr6eqEiFZ1Eh85PPXN6jx1KZ6fNdCkKb5qcwWpM2TX9yB9TcHd?=
 =?iso-8859-1?Q?3sHu7JK5ho6TVjR6SvSqamCRKKbUqvu16q598ZI45hfKhXMCeXmNxnbQM1?=
 =?iso-8859-1?Q?aWu4Oyb74bOinWCcnZsG31uJR0YQSpAQmA7eNZ89Eaxuc7vFSn6YikQ3Xg?=
 =?iso-8859-1?Q?s+sCa5JBHksJ0b97+3fHR8jH/H/EnwmYR3KyZlLF2wNDh3tEX3ztg/5mO3?=
 =?iso-8859-1?Q?6Ocn4y11JvrS/0FKZEUW7fnUQiChbUK28TFUXsuVJkdLOzBKIzOcNaMIhv?=
 =?iso-8859-1?Q?KuKC+EVfNERo4EeTVqtkch6SvXlt2bPF/oldbvHm93dqhQYvPQoFEw2F14?=
 =?iso-8859-1?Q?+uUsTZnuX1/xcZLfgOdIt54m5Z5HSsM4PzW9iVc1br6/Nt86mM+JwNsxhN?=
 =?iso-8859-1?Q?lDrFYU/9VcbOG+DNr5LvldV2Ga1DqwEr8FAMC51wke7JV7geaOcVJRAfK1?=
 =?iso-8859-1?Q?QblNYz4yg8Ih5AFemZh9xdOSNVt+b/rvZ/z3ZwOSnidAwqkaQ89HoU5Q?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 68b1e232-b670-410a-24f8-08dc02d4b922
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2023 09:59:44.5649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: abYTBH4eRJgHAJBqsPUGpCmJLuis7pi9qcuCZTvKxmpFLLAON90QJ3wkLwdUyaDG8NilmqJIr43/WRsTI74HRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8145
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a -18.0% regression of stress-ng.link.ops_per_sec on:


commit: 8d993618350c86da11cb408ba529c13e83d09527 ("btrfs: migrate get_eb_page_index() and get_eb_offset_in_page() to folios")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

testcase: stress-ng
test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-9980XE CPU @ 3.00GHz (Skylake) with 32G memory
parameters:

	nr_threads: 10%
	disk: 1SSD
	testtime: 60s
	fs: btrfs
	class: filesystem
	test: link
	cpufreq_governor: performance




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202312221750.571925bd-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231222/202312221750.571925bd-oliver.sang@intel.com

=========================================================================================
class/compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  filesystem/gcc-12/performance/1SSD/btrfs/x86_64-rhel-8.3/10%/debian-11.1-x86_64-20220510.cgz/lkp-skl-d08/link/stress-ng/60s

commit: 
  4a565c8069 ("btrfs: don't double put our subpage reference in alloc_extent_buffer")
  8d99361835 ("btrfs: migrate get_eb_page_index() and get_eb_offset_in_page() to folios")

4a565c8069b7578a 8d993618350c86da11cb408ba52 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    128019 ±  2%     -17.8%     105190 ±  3%  meminfo.Active(file)
      6.66            -1.3%       6.58        iostat.cpu.system
      1.17            -9.1%       1.06        iostat.cpu.user
    289284            -6.9%     269436        vmstat.system.cs
     65806            -7.9%      60578        vmstat.system.in
    405.33           -18.1%     332.00        stress-ng.link.ops
      6.74           -18.0%       5.52        stress-ng.link.ops_per_sec
   1112160           -18.4%     907242        stress-ng.time.file_system_outputs
    240.17            -2.8%     233.50        stress-ng.time.percent_of_cpu_this_job_got
   8226690            -7.8%    7585056        stress-ng.time.voluntary_context_switches
   1973316           +79.4%    3540267 ±  2%  turbostat.C1
      1.30            +0.9        2.16        turbostat.C1%
      5.46            -0.3        5.20        turbostat.C1E%
   5718046           -33.5%    3801380 ±  2%  turbostat.POLL
      0.62            -0.1        0.49        turbostat.POLL%
     32012 ±  2%     -17.8%      26302 ±  3%  proc-vmstat.nr_active_file
    206862           -18.2%     169132        proc-vmstat.nr_dirtied
    865283            -1.1%     855487        proc-vmstat.nr_file_pages
     32012 ±  2%     -17.8%      26302 ±  3%  proc-vmstat.nr_zone_active_file
    629237            -8.6%     575380        proc-vmstat.numa_hit
    629214            -8.6%     575323        proc-vmstat.numa_local
    179621            -6.2%     168451        proc-vmstat.pgactivate
    667239            -8.3%     611720        proc-vmstat.pgalloc_normal
    380497            -7.0%     353954        proc-vmstat.pgfree
      0.00 ± 35%    +312.5%       0.01 ± 48%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.__btrfs_tree_lock.btrfs_search_slot.btrfs_insert_empty_items
      0.00          +100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.__btrfs_tree_read_lock
      0.01 ± 64%    +200.0%       0.03 ± 31%  perf-sched.sch_delay.max.ms.__cond_resched.btrfs_alloc_path.btrfs_insert_inode_extref.btrfs_insert_inode_ref.btrfs_add_link
      0.01 ± 42%    +209.7%       0.02 ± 73%  perf-sched.sch_delay.max.ms.__cond_resched.down_write.__btrfs_tree_lock.btrfs_search_slot.btrfs_insert_empty_items
      0.02           +14.4%       0.02 ±  2%  perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.__btrfs_tree_read_lock
    214.90 ±  2%     +18.2%     254.12 ±  3%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1148 ±  3%     -16.2%     962.67 ±  3%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      4112           -12.7%       3591        perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      2.42 ±  3%     +15.3%       2.79 ±  4%  perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.__btrfs_tree_read_lock
      0.01 ± 29%     -46.9%       0.01 ± 48%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.getname_flags.part.0
      0.01 ±  6%     +20.0%       0.01        perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.btrfs_insert_delayed_dir_index
    214.89 ±  2%     +18.3%     254.11 ±  3%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     33.63 ±  5%     +12.0%      37.66 ±  3%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.03 ± 43%     -73.4%       0.01 ± 63%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.getname_flags.part.0
      2.42 ±  2%     +15.4%       2.79 ±  4%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.__btrfs_tree_read_lock
      0.14            -6.4%       0.13        perf-stat.i.MPKI
 1.906e+09            +4.5%  1.993e+09        perf-stat.i.branch-instructions
      1.32            -0.1        1.17        perf-stat.i.branch-miss-rate%
  26743969            -6.5%   25011532        perf-stat.i.branch-misses
      3.41            +0.2        3.60 ±  2%  perf-stat.i.cache-miss-rate%
   1796858            -5.3%    1701141        perf-stat.i.cache-misses
  58405083 ±  2%     -14.3%   50049447 ±  2%  perf-stat.i.cache-references
    304586            -7.0%     283390        perf-stat.i.context-switches
      1.19            -3.7%       1.15        perf-stat.i.cpi
 1.287e+10            -2.9%   1.25e+10        perf-stat.i.cpu-cycles
      0.02            -0.0        0.02 ±  2%  perf-stat.i.dTLB-load-miss-rate%
    600957           -14.0%     517082 ±  2%  perf-stat.i.dTLB-load-misses
 2.795e+09            +2.5%  2.864e+09        perf-stat.i.dTLB-loads
     13392 ±  5%      -6.8%      12476        perf-stat.i.dTLB-store-misses
 1.548e+09            -5.3%  1.467e+09        perf-stat.i.dTLB-stores
     12.26 ± 41%      -5.6        6.63 ±  9%  perf-stat.i.iTLB-load-miss-rate%
    845016 ± 49%     -40.0%     506730 ±  7%  perf-stat.i.iTLB-load-misses
   6089143 ±  5%     +26.0%    7670203 ±  4%  perf-stat.i.iTLB-loads
     16270 ± 24%     +40.8%      22909 ±  6%  perf-stat.i.instructions-per-iTLB-miss
      0.85            +3.7%       0.88        perf-stat.i.ipc
      0.36            -2.9%       0.35        perf-stat.i.metric.GHz
    208.10 ±  4%     +27.9%     266.24 ±  3%  perf-stat.i.metric.K/sec
    175.16            +1.0%     176.99        perf-stat.i.metric.M/sec
    238376 ±  2%      -4.7%     227119 ±  2%  perf-stat.i.node-loads
      0.17            -6.0%       0.16        perf-stat.overall.MPKI
      1.40            -0.1        1.26        perf-stat.overall.branch-miss-rate%
      3.08            +0.3        3.40 ±  2%  perf-stat.overall.cache-miss-rate%
      1.18            -3.6%       1.14        perf-stat.overall.cpi
      7161            +2.6%       7345        perf-stat.overall.cycles-between-cache-misses
      0.02            -0.0        0.02 ±  2%  perf-stat.overall.dTLB-load-miss-rate%
     11.98 ± 43%      -5.8        6.22 ± 10%  perf-stat.overall.iTLB-load-miss-rate%
     14899 ± 27%     +45.9%      21742 ±  6%  perf-stat.overall.instructions-per-iTLB-miss
      0.85            +3.8%       0.88        perf-stat.overall.ipc
 1.876e+09            +4.5%  1.961e+09        perf-stat.ps.branch-instructions
  26334419            -6.5%   24630000        perf-stat.ps.branch-misses
   1769174            -5.3%    1674649        perf-stat.ps.cache-misses
  57480574 ±  2%     -14.3%   49253797 ±  2%  perf-stat.ps.cache-references
    299751            -7.0%     278871        perf-stat.ps.context-switches
 1.267e+10            -2.9%   1.23e+10        perf-stat.ps.cpu-cycles
    591440           -14.0%     508870 ±  2%  perf-stat.ps.dTLB-load-misses
 2.751e+09            +2.5%  2.819e+09        perf-stat.ps.dTLB-loads
     13182 ±  5%      -6.8%      12281        perf-stat.ps.dTLB-store-misses
 1.524e+09            -5.3%  1.444e+09        perf-stat.ps.dTLB-stores
    831651 ± 49%     -40.0%     498659 ±  7%  perf-stat.ps.iTLB-load-misses
   5992481 ±  5%     +26.0%    7547962 ±  4%  perf-stat.ps.iTLB-loads
    234670 ±  2%      -4.7%     223562 ±  2%  perf-stat.ps.node-loads
      5.72 ±  2%      -1.1        4.57 ±  5%  perf-profile.calltrace.cycles-pp.poll_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      6.43            -1.0        5.39        perf-profile.calltrace.cycles-pp.__statfs
      4.95 ±  2%      -0.8        4.19 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__statfs
      4.49 ±  2%      -0.7        3.79 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__statfs
      3.52 ±  2%      -0.6        2.96 ±  3%  perf-profile.calltrace.cycles-pp.__do_sys_statfs.do_syscall_64.entry_SYSCALL_64_after_hwframe.__statfs
      3.30 ±  3%      -0.5        2.76 ±  3%  perf-profile.calltrace.cycles-pp.user_statfs.__do_sys_statfs.do_syscall_64.entry_SYSCALL_64_after_hwframe.__statfs
      1.54 ±  2%      -0.3        1.24 ±  7%  perf-profile.calltrace.cycles-pp.filename_create.do_linkat.__x64_sys_link.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.69 ±  5%      -0.3        1.42 ±  6%  perf-profile.calltrace.cycles-pp.user_path_at_empty.user_statfs.__do_sys_statfs.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.62 ±  4%      -0.3        0.35 ± 70%  perf-profile.calltrace.cycles-pp.__filename_parentat.filename_create.do_linkat.__x64_sys_link.do_syscall_64
      1.66 ±  4%      -0.3        1.40        perf-profile.calltrace.cycles-pp.__lxstat64
      0.75 ±  3%      -0.2        0.50 ± 45%  perf-profile.calltrace.cycles-pp.lookup_one_qstr_excl.filename_create.do_linkat.__x64_sys_link.do_syscall_64
      0.58 ±  8%      -0.2        0.34 ± 70%  perf-profile.calltrace.cycles-pp.link_path_walk.path_lookupat.filename_lookup.do_linkat.__x64_sys_link
      1.36 ±  2%      -0.2        1.13 ±  5%  perf-profile.calltrace.cycles-pp.btrfs_statfs.statfs_by_dentry.user_statfs.__do_sys_statfs.do_syscall_64
      1.41 ±  2%      -0.2        1.18 ±  5%  perf-profile.calltrace.cycles-pp.statfs_by_dentry.user_statfs.__do_sys_statfs.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.28 ±  6%      -0.2        1.07 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__lxstat64
      1.16 ±  6%      -0.2        0.96 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__lxstat64
      0.65 ±  8%      -0.2        0.46 ± 44%  perf-profile.calltrace.cycles-pp.vfs_statx.__do_sys_newlstat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__lxstat64
      1.08 ±  2%      -0.2        0.90 ±  5%  perf-profile.calltrace.cycles-pp.filename_lookup.do_linkat.__x64_sys_link.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.95 ±  3%      -0.2        0.77 ±  4%  perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.__statfs
      1.01 ±  3%      -0.2        0.84 ±  5%  perf-profile.calltrace.cycles-pp.path_lookupat.filename_lookup.do_linkat.__x64_sys_link.do_syscall_64
      1.03 ±  2%      -0.2        0.87 ±  7%  perf-profile.calltrace.cycles-pp.filename_lookup.user_path_at_empty.user_statfs.__do_sys_statfs.do_syscall_64
      0.92 ±  7%      -0.2        0.76 ±  3%  perf-profile.calltrace.cycles-pp.__do_sys_newlstat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__lxstat64
      0.92 ±  2%      -0.1        0.78 ±  6%  perf-profile.calltrace.cycles-pp.path_lookupat.filename_lookup.user_path_at_empty.user_statfs.__do_sys_statfs
      0.80 ±  6%      -0.1        0.68 ±  4%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__statfs
      0.66 ±  3%      -0.1        0.55 ±  7%  perf-profile.calltrace.cycles-pp.btrfs_calc_avail_data_space.btrfs_statfs.statfs_by_dentry.user_statfs.__do_sys_statfs
      0.87 ±  4%      -0.1        0.79 ±  5%  perf-profile.calltrace.cycles-pp.btrfs_insert_delayed_dir_index.btrfs_insert_dir_item.btrfs_add_link.btrfs_link.vfs_link
      0.56 ±  6%      +0.1        0.64 ±  7%  perf-profile.calltrace.cycles-pp.btrfs_get_token_32.btrfs_del_items.__btrfs_unlink_inode.btrfs_unlink.vfs_unlink
      0.84 ±  4%      +0.1        0.93 ±  4%  perf-profile.calltrace.cycles-pp.btrfs_get_token_32.setup_items_for_insert.btrfs_insert_empty_items.btrfs_insert_inode_extref.btrfs_insert_inode_ref
      0.69 ±  6%      +0.1        0.79 ±  6%  perf-profile.calltrace.cycles-pp.push_leaf_right.split_leaf.btrfs_search_slot.btrfs_insert_empty_items.btrfs_insert_inode_extref
      0.60 ±  4%      +0.1        0.71 ±  7%  perf-profile.calltrace.cycles-pp.btrfs_set_token_32.setup_items_for_insert.btrfs_insert_empty_items.insert_with_overflow.btrfs_insert_dir_item
      0.58 ±  4%      +0.1        0.70 ±  6%  perf-profile.calltrace.cycles-pp.btrfs_get_token_32.btrfs_del_items.btrfs_del_inode_extref.btrfs_del_inode_ref.__btrfs_unlink_inode
      0.89 ±  7%      +0.1        1.02 ±  4%  perf-profile.calltrace.cycles-pp.split_leaf.btrfs_search_slot.btrfs_insert_empty_items.btrfs_insert_inode_extref.btrfs_insert_inode_ref
      1.56 ±  3%      +0.1        1.69 ±  5%  perf-profile.calltrace.cycles-pp.btrfs_lock_root_node.btrfs_search_slot.btrfs_lookup_dir_item.__btrfs_unlink_inode.btrfs_unlink
      0.58 ±  5%      +0.1        0.71 ±  6%  perf-profile.calltrace.cycles-pp.btrfs_set_token_32.btrfs_del_items.btrfs_del_inode_extref.btrfs_del_inode_ref.__btrfs_unlink_inode
      1.50 ±  3%      +0.2        1.66 ±  5%  perf-profile.calltrace.cycles-pp.__btrfs_tree_lock.btrfs_lock_root_node.btrfs_search_slot.btrfs_lookup_dir_item.__btrfs_unlink_inode
      1.50 ±  3%      +0.2        1.66 ±  5%  perf-profile.calltrace.cycles-pp.down_write.__btrfs_tree_lock.btrfs_lock_root_node.btrfs_search_slot.btrfs_lookup_dir_item
      1.26 ±  3%      +0.2        1.44 ±  3%  perf-profile.calltrace.cycles-pp.__push_leaf_right.push_leaf_right.split_leaf.btrfs_search_slot.btrfs_insert_empty_items
      1.72 ±  3%      +0.2        1.92 ±  2%  perf-profile.calltrace.cycles-pp.btrfs_del_items.btrfs_del_inode_extref.btrfs_del_inode_ref.__btrfs_unlink_inode.btrfs_unlink
      0.37 ± 70%      +0.3        0.66 ±  5%  perf-profile.calltrace.cycles-pp.btrfs_set_token_32.btrfs_del_items.__btrfs_unlink_inode.btrfs_unlink.vfs_unlink
      2.38 ±  2%      +0.3        2.67 ±  2%  perf-profile.calltrace.cycles-pp.setup_items_for_insert.btrfs_insert_empty_items.btrfs_insert_inode_extref.btrfs_insert_inode_ref.btrfs_add_link
      1.60 ±  2%      +0.4        2.00 ±  5%  perf-profile.calltrace.cycles-pp.btrfs_lock_root_node.btrfs_search_slot.btrfs_insert_empty_items.btrfs_insert_inode_ref.btrfs_add_link
      2.83 ±  3%      +0.4        3.24 ±  2%  perf-profile.calltrace.cycles-pp.btrfs_insert_empty_items.btrfs_insert_inode_ref.btrfs_add_link.btrfs_link.vfs_link
      1.56 ±  3%      +0.4        1.97 ±  4%  perf-profile.calltrace.cycles-pp.__btrfs_tree_lock.btrfs_lock_root_node.btrfs_search_slot.btrfs_insert_empty_items.btrfs_insert_inode_ref
      2.81 ±  3%      +0.4        3.23 ±  2%  perf-profile.calltrace.cycles-pp.btrfs_search_slot.btrfs_insert_empty_items.btrfs_insert_inode_ref.btrfs_add_link.btrfs_link
      7.98            +0.8        8.82 ±  4%  perf-profile.calltrace.cycles-pp.btrfs_insert_inode_extref.btrfs_insert_inode_ref.btrfs_add_link.btrfs_link.vfs_link
      1.17 ±  5%      +0.9        2.03 ±  4%  perf-profile.calltrace.cycles-pp.intel_idle_irq.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      7.62            +0.9        8.49 ±  5%  perf-profile.calltrace.cycles-pp.btrfs_insert_empty_items.btrfs_insert_inode_extref.btrfs_insert_inode_ref.btrfs_add_link.btrfs_link
      0.00            +1.0        0.97 ± 39%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.intel_idle_irq.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      0.81 ± 34%      +1.0        1.80 ± 17%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.__btrfs_tree_lock
      5.90 ±  2%      +1.0        6.94 ±  3%  perf-profile.calltrace.cycles-pp.down_write.__btrfs_tree_lock.btrfs_lock_root_node.btrfs_search_slot.btrfs_insert_empty_items
      5.60 ±  2%      +1.1        6.72        perf-profile.calltrace.cycles-pp.rwsem_spin_on_owner.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.__btrfs_tree_lock
      3.00 ±  2%      +1.4        4.36 ±  2%  perf-profile.calltrace.cycles-pp.btrfs_get_16.btrfs_find_name_in_backref.btrfs_insert_inode_ref.btrfs_add_link.btrfs_link
     10.83 ±  2%      +1.4       12.23 ±  2%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.__btrfs_tree_lock.btrfs_lock_root_node.btrfs_search_slot
      4.29            +1.4        5.69 ±  2%  perf-profile.calltrace.cycles-pp.btrfs_find_name_in_backref.btrfs_insert_inode_ref.btrfs_add_link.btrfs_link.vfs_link
     10.58 ±  2%      +1.4       11.98 ±  2%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.__btrfs_tree_lock.btrfs_lock_root_node
     31.28            +1.7       32.96        perf-profile.calltrace.cycles-pp.link
     30.37            +1.8       32.16        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.link
     30.13            +1.8       31.96        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.link
     29.62            +1.9       31.53        perf-profile.calltrace.cycles-pp.__x64_sys_link.do_syscall_64.entry_SYSCALL_64_after_hwframe.link
     29.03            +2.0       31.01        perf-profile.calltrace.cycles-pp.do_linkat.__x64_sys_link.do_syscall_64.entry_SYSCALL_64_after_hwframe.link
     25.76            +2.6       28.37        perf-profile.calltrace.cycles-pp.vfs_link.do_linkat.__x64_sys_link.do_syscall_64.entry_SYSCALL_64_after_hwframe
     25.59            +2.6       28.22        perf-profile.calltrace.cycles-pp.btrfs_link.vfs_link.do_linkat.__x64_sys_link.do_syscall_64
     16.15            +2.7       18.86 ±  2%  perf-profile.calltrace.cycles-pp.btrfs_insert_inode_ref.btrfs_add_link.btrfs_link.vfs_link.do_linkat
     24.19            +2.8       26.95        perf-profile.calltrace.cycles-pp.btrfs_add_link.btrfs_link.vfs_link.do_linkat.__x64_sys_link
      5.80 ±  2%      -1.2        4.63 ±  5%  perf-profile.children.cycles-pp.poll_idle
      6.50            -1.1        5.44        perf-profile.children.cycles-pp.__statfs
      3.53 ±  2%      -0.6        2.97 ±  3%  perf-profile.children.cycles-pp.__do_sys_statfs
      3.30 ±  3%      -0.5        2.76 ±  3%  perf-profile.children.cycles-pp.user_statfs
      2.53            -0.4        2.13 ±  2%  perf-profile.children.cycles-pp.filename_lookup
      2.41 ±  4%      -0.4        2.02 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock
      2.32            -0.4        1.97 ±  2%  perf-profile.children.cycles-pp.path_lookupat
      1.55 ±  2%      -0.3        1.24 ±  7%  perf-profile.children.cycles-pp.filename_create
      2.01 ±  2%      -0.3        1.72        perf-profile.children.cycles-pp.syscall_return_via_sysret
      1.82            -0.3        1.54 ±  2%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      1.69 ±  4%      -0.3        1.42 ±  6%  perf-profile.children.cycles-pp.user_path_at_empty
      2.34 ±  4%      -0.3        2.08 ±  4%  perf-profile.children.cycles-pp.btrfs_release_path
      1.68 ±  4%      -0.3        1.42        perf-profile.children.cycles-pp.__lxstat64
      1.30 ±  3%      -0.2        1.06 ±  5%  perf-profile.children.cycles-pp.btrfs_update_inode
      1.41 ±  2%      -0.2        1.18 ±  5%  perf-profile.children.cycles-pp.statfs_by_dentry
      1.36 ±  2%      -0.2        1.13 ±  5%  perf-profile.children.cycles-pp.btrfs_statfs
      1.41 ±  5%      -0.2        1.20 ±  7%  perf-profile.children.cycles-pp.getname_flags
      2.34 ±  2%      -0.2        2.14        perf-profile.children.cycles-pp.up_write
      1.42 ±  2%      -0.2        1.22 ±  2%  perf-profile.children.cycles-pp.__memmove
      1.65 ±  5%      -0.2        1.45 ±  4%  perf-profile.children.cycles-pp.link_path_walk
      0.80 ±  7%      -0.2        0.61 ± 10%  perf-profile.children.cycles-pp.btrfs_root_node
      0.87 ±  3%      -0.2        0.69 ± 10%  perf-profile.children.cycles-pp.lookup_one_qstr_excl
      0.91 ±  3%      -0.2        0.74 ±  7%  perf-profile.children.cycles-pp.__btrfs_release_delayed_node
      1.71 ±  4%      -0.2        1.54 ±  2%  perf-profile.children.cycles-pp.btrfs_free_path
      0.88            -0.2        0.72 ±  6%  perf-profile.children.cycles-pp.btrfs_delayed_update_inode
      0.92 ±  7%      -0.2        0.76 ±  3%  perf-profile.children.cycles-pp.__do_sys_newlstat
      1.91 ±  2%      -0.1        1.77 ±  2%  perf-profile.children.cycles-pp.rwsem_wake
      0.96 ±  4%      -0.1        0.82 ±  2%  perf-profile.children.cycles-pp.__filename_parentat
      0.90 ±  4%      -0.1        0.77 ±  6%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      1.10 ±  8%      -0.1        0.97 ±  4%  perf-profile.children.cycles-pp.read_block_for_search
      0.94 ±  5%      -0.1        0.81 ±  7%  perf-profile.children.cycles-pp.strncpy_from_user
      0.87 ±  6%      -0.1        0.74 ±  2%  perf-profile.children.cycles-pp.path_parentat
      0.76 ±  5%      -0.1        0.63 ±  4%  perf-profile.children.cycles-pp.try_to_unlazy
      0.66 ±  9%      -0.1        0.55 ±  5%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.66 ±  9%      -0.1        0.54 ±  4%  perf-profile.children.cycles-pp.vfs_statx
      0.68 ±  4%      -0.1        0.57 ±  4%  perf-profile.children.cycles-pp.__legitimize_path
      0.67 ±  3%      -0.1        0.56 ±  8%  perf-profile.children.cycles-pp.btrfs_calc_avail_data_space
      0.48 ±  5%      -0.1        0.37 ±  9%  perf-profile.children.cycles-pp.d_alloc
      0.74 ±  5%      -0.1        0.64 ±  5%  perf-profile.children.cycles-pp.complete_walk
      0.60 ±  8%      -0.1        0.49 ± 13%  perf-profile.children.cycles-pp.__write_extent_buffer
      0.55 ±  8%      -0.1        0.44 ±  6%  perf-profile.children.cycles-pp.dput
      0.37 ±  9%      -0.1        0.28 ± 10%  perf-profile.children.cycles-pp.__d_alloc
      0.62 ±  5%      -0.1        0.53 ±  5%  perf-profile.children.cycles-pp.btrfs_block_rsv_release
      1.04 ±  3%      -0.1        0.96 ±  4%  perf-profile.children.cycles-pp.start_transaction
      0.31 ±  6%      -0.1        0.23 ± 10%  perf-profile.children.cycles-pp.memcmp
      0.87 ±  4%      -0.1        0.79 ±  5%  perf-profile.children.cycles-pp.btrfs_insert_delayed_dir_index
      0.65 ±  2%      -0.1        0.58 ±  6%  perf-profile.children.cycles-pp.__btrfs_end_transaction
      0.53 ±  5%      -0.1        0.46 ±  6%  perf-profile.children.cycles-pp.mutex_unlock
      0.22 ± 10%      -0.1        0.16 ± 13%  perf-profile.children.cycles-pp.kmem_cache_alloc_lru
      0.23 ±  9%      -0.1        0.17 ± 16%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      0.44 ±  6%      -0.1        0.37 ±  5%  perf-profile.children.cycles-pp.lockref_get_not_dead
      0.31 ± 10%      -0.1        0.26 ±  8%  perf-profile.children.cycles-pp.__cond_resched
      0.29 ± 13%      -0.1        0.23 ± 11%  perf-profile.children.cycles-pp.btrfs_update_root_times
      0.30 ± 16%      -0.1        0.24 ±  3%  perf-profile.children.cycles-pp.btrfs_batch_delete_items
      0.23 ± 11%      -0.1        0.18 ± 15%  perf-profile.children.cycles-pp.__virt_addr_valid
      0.18 ±  8%      -0.1        0.13 ± 21%  perf-profile.children.cycles-pp.sysvec_call_function_single
      0.35 ±  9%      -0.0        0.30 ±  5%  perf-profile.children.cycles-pp._IO_default_xsputn
      0.08 ± 16%      -0.0        0.03 ±101%  perf-profile.children.cycles-pp.run_ksoftirqd
      0.18 ±  7%      -0.0        0.14 ± 12%  perf-profile.children.cycles-pp.join_transaction
      0.10 ± 11%      -0.0        0.07 ± 13%  perf-profile.children.cycles-pp.finish_one_item
      0.41 ±  4%      -0.0        0.37 ±  4%  perf-profile.children.cycles-pp.__smp_call_single_queue
      0.13 ± 14%      -0.0        0.09 ± 14%  perf-profile.children.cycles-pp.finish_task_switch
      0.13 ± 13%      -0.0        0.09 ± 17%  perf-profile.children.cycles-pp.__d_add
      0.14 ± 10%      -0.0        0.10 ± 12%  perf-profile.children.cycles-pp.btrfs_release_delayed_item
      0.14 ±  7%      -0.0        0.11 ± 10%  perf-profile.children.cycles-pp.memcg_slab_post_alloc_hook
      0.16 ±  4%      -0.0        0.13 ± 19%  perf-profile.children.cycles-pp.btrfs_get_or_create_delayed_node
      0.08 ± 17%      -0.0        0.05 ± 47%  perf-profile.children.cycles-pp.may_linkat
      0.10 ± 11%      -0.0        0.07 ± 14%  perf-profile.children.cycles-pp.folio_mark_accessed
      0.46 ±  3%      +0.0        0.50 ±  2%  perf-profile.children.cycles-pp.push_leaf_left
      0.13 ± 14%      +0.0        0.18 ± 11%  perf-profile.children.cycles-pp.btrfs_get_64
      0.13 ± 10%      +0.1        0.20 ± 11%  perf-profile.children.cycles-pp.memcpy_orig
      0.26 ±  9%      +0.1        0.34 ±  5%  perf-profile.children.cycles-pp.btrfs_leaf_free_space
      0.26 ±  8%      +0.1        0.34 ±  4%  perf-profile.children.cycles-pp.leaf_space_used
      0.53 ±  6%      +0.1        0.64 ±  6%  perf-profile.children.cycles-pp.btrfs_get_32
      1.41 ±  3%      +0.1        1.54 ±  3%  perf-profile.children.cycles-pp.__push_leaf_right
      2.16 ±  3%      +0.1        2.29        perf-profile.children.cycles-pp.split_leaf
      3.76 ±  2%      +0.3        4.08 ±  2%  perf-profile.children.cycles-pp.btrfs_del_items
      3.29            +0.5        3.76 ±  2%  perf-profile.children.cycles-pp.btrfs_get_token_32
      4.79            +0.5        5.28 ±  2%  perf-profile.children.cycles-pp.setup_items_for_insert
      2.66 ±  4%      +0.5        3.20 ±  4%  perf-profile.children.cycles-pp.osq_lock
     53.95            +0.8       54.72        perf-profile.children.cycles-pp.do_syscall_64
      3.02 ±  2%      +0.8        3.81 ±  2%  perf-profile.children.cycles-pp.btrfs_set_token_32
      7.98            +0.8        8.82 ±  4%  perf-profile.children.cycles-pp.btrfs_insert_inode_extref
      5.72 ±  2%      +1.1        6.86        perf-profile.children.cycles-pp.rwsem_spin_on_owner
      1.43 ±  6%      +1.1        2.58 ±  6%  perf-profile.children.cycles-pp.intel_idle_irq
     20.83            +1.2       22.04        perf-profile.children.cycles-pp.btrfs_search_slot
     11.44 ±  2%      +1.3       12.78        perf-profile.children.cycles-pp.btrfs_lock_root_node
     11.38 ±  2%      +1.4       12.78 ±  2%  perf-profile.children.cycles-pp.down_write
     11.00 ±  2%      +1.4       12.44 ±  2%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
     11.27 ±  2%      +1.4       12.70 ±  2%  perf-profile.children.cycles-pp.__btrfs_tree_lock
     10.87 ±  2%      +1.5       12.33 ±  2%  perf-profile.children.cycles-pp.rwsem_optimistic_spin
      3.06 ±  2%      +1.5        4.55 ±  2%  perf-profile.children.cycles-pp.btrfs_get_16
      4.52            +1.5        6.04 ±  2%  perf-profile.children.cycles-pp.btrfs_find_name_in_backref
     17.04 ±  2%      +1.6       18.60        perf-profile.children.cycles-pp.btrfs_insert_empty_items
     31.32            +1.7       32.99        perf-profile.children.cycles-pp.link
     29.62            +1.9       31.54        perf-profile.children.cycles-pp.__x64_sys_link
     29.04            +2.0       31.02        perf-profile.children.cycles-pp.do_linkat
     25.77            +2.6       28.38        perf-profile.children.cycles-pp.vfs_link
     25.60            +2.6       28.23        perf-profile.children.cycles-pp.btrfs_link
     16.16            +2.7       18.86 ±  2%  perf-profile.children.cycles-pp.btrfs_insert_inode_ref
     24.19            +2.8       26.95        perf-profile.children.cycles-pp.btrfs_add_link
      5.67 ±  2%      -1.1        4.54 ±  5%  perf-profile.self.cycles-pp.poll_idle
      2.28 ±  4%      -0.4        1.92 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock
      1.95 ±  2%      -0.3        1.66        perf-profile.self.cycles-pp.syscall_return_via_sysret
      1.70            -0.3        1.43 ±  2%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      1.41 ±  3%      -0.2        1.21 ±  2%  perf-profile.self.cycles-pp.__memmove
      0.79 ±  7%      -0.2        0.60 ± 11%  perf-profile.self.cycles-pp.btrfs_root_node
      1.10 ±  3%      -0.2        0.95 ±  4%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.22 ± 22%      -0.1        0.10 ± 31%  perf-profile.self.cycles-pp.read_extent_buffer
      0.78 ±  5%      -0.1        0.68 ±  6%  perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.48 ±  8%      -0.1        0.40 ±  8%  perf-profile.self.cycles-pp.kmem_cache_alloc
      0.20 ± 13%      -0.1        0.11 ± 19%  perf-profile.self.cycles-pp.__write_extent_buffer
      0.29 ±  8%      -0.1        0.20 ± 16%  perf-profile.self.cycles-pp.path_init
      0.53 ±  5%      -0.1        0.45 ±  7%  perf-profile.self.cycles-pp.mutex_unlock
      0.30 ±  5%      -0.1        0.23 ± 10%  perf-profile.self.cycles-pp.memcmp
      0.52 ±  5%      -0.1        0.45 ±  5%  perf-profile.self.cycles-pp.btrfs_statfs
      0.43 ±  6%      -0.1        0.36 ±  5%  perf-profile.self.cycles-pp.lockref_get_not_dead
      0.26 ±  6%      -0.1        0.20 ± 12%  perf-profile.self.cycles-pp.__btrfs_release_delayed_node
      0.34 ±  8%      -0.1        0.28 ±  6%  perf-profile.self.cycles-pp.__push_leaf_right
      0.26 ±  8%      -0.0        0.21 ± 13%  perf-profile.self.cycles-pp.inode_permission
      0.20 ±  8%      -0.0        0.15 ±  8%  perf-profile.self.cycles-pp.filename_lookup
      0.34 ±  8%      -0.0        0.30 ±  5%  perf-profile.self.cycles-pp._IO_default_xsputn
      0.10 ± 11%      -0.0        0.07 ± 13%  perf-profile.self.cycles-pp.finish_one_item
      0.24 ± 11%      -0.0        0.21 ± 10%  perf-profile.self.cycles-pp.start_transaction
      0.12 ± 11%      +0.0        0.17 ± 13%  perf-profile.self.cycles-pp.btrfs_get_64
      0.12 ± 10%      +0.1        0.19 ±  9%  perf-profile.self.cycles-pp.memcpy_orig
      0.50 ±  6%      +0.1        0.61 ±  6%  perf-profile.self.cycles-pp.btrfs_get_32
      1.10 ±  5%      +0.2        1.32 ±  3%  perf-profile.self.cycles-pp.btrfs_find_name_in_backref
      3.03            +0.5        3.54 ±  2%  perf-profile.self.cycles-pp.btrfs_get_token_32
      2.65 ±  4%      +0.5        3.18 ±  4%  perf-profile.self.cycles-pp.osq_lock
      2.74 ±  2%      +0.7        3.49 ±  2%  perf-profile.self.cycles-pp.btrfs_set_token_32
      1.28 ±  6%      +1.1        2.38 ±  8%  perf-profile.self.cycles-pp.intel_idle_irq
      5.57 ±  2%      +1.1        6.70        perf-profile.self.cycles-pp.rwsem_spin_on_owner
      2.85 ±  2%      +1.4        4.23 ±  2%  perf-profile.self.cycles-pp.btrfs_get_16




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


