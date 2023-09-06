Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6660B7933D2
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Sep 2023 04:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235655AbjIFCpd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Sep 2023 22:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbjIFCpd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Sep 2023 22:45:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4724CE
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Sep 2023 19:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693968328; x=1725504328;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Syifn1patVDRQ1bTWhNlhAzOkPL4GkTq6vFxajDqmzk=;
  b=OHFGbDKkDsSL5PnZFonuQ/9Nc5DT+f8iB3fpxrEkYfHKdGRYGHmz0aAb
   J1twsRCSu8ZsZLBwHAM2dtP/G0HLPSN1JCd5nMWHAnqvqz9rU2+cDOiEp
   QaebRikTt2TCbxSZ34NwaTcJ/EXQIMUEH67GpaQCTaE+rEBI03Wz9E0aX
   K+5+fvD2fnowayx/4HMSeBar8jgI4R5xEyS7uJE5qvRKVblH4zOo37AgX
   xB3W/hiV5pF90D9cxwuXyVzlK/phTRPaI0sRsMgri7xwFuN79uyf/YsJs
   BgLO0NPpSYLcYa0pQ4CIounvxjFvS0zv1kP5TBM7CPk86zhqmQWFAs2EF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="407953848"
X-IronPort-AV: E=Sophos;i="6.02,230,1688454000"; 
   d="scan'208";a="407953848"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 19:45:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="776409948"
X-IronPort-AV: E=Sophos;i="6.02,230,1688454000"; 
   d="scan'208";a="776409948"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Sep 2023 19:45:26 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 5 Sep 2023 19:45:25 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 5 Sep 2023 19:45:25 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 5 Sep 2023 19:45:25 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 5 Sep 2023 19:45:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RkwjjgkNY461gzFngbKuT7f1uxSjciJbHXla8lSJ0RJH9seasnFVNF6gzC1DVy4vCTJW6gmJUyVpe+omOgt+f0CwzRp0cfRl9kB2AET1bSQ5upLZ4CgBb2Hj4BXBbp2JljFLldgURKxekAINHTE/dJwnZOD9yGxBG5AEBN77bzKls68C/JOsBSc0RjziIaNdeq0JQ4i4bqapRgQ++3sb69CF+TMJhSGyXdy+AOT0gLAMIT0QFHiPeTw5VOLOLWOCJmKj7hYssWjGA1MuSpsbPyTgfNKFBo8pQ2FzC7f7sTluIlJYU7TiRkGzRpJKCykCRm1/DqSwdlU1eZdHeE6yfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pzWYa4EnxH8rbEQvsXAIzziYd0W/0YPegbuTx1tcoCA=;
 b=KFQevcf9EfZrYceJ2W+8gynQDY90zAP9FSMQATScbYmdMHw15e7ZMYF1ctCyT8YxeQLjb591/p8imfrRJWUaaWpQJ8jNnOAf7nl4pvG15jOyknX9yFjRow4tOOWFCS2OYEcmOmOSo9U6ql7FtAH+DNohKaH9vu6HqV7RMpGMc42bh6WVK8zcxiWt9itJV+1sxqOZB7INV5gqJxs0m4gb7KRRrXBW7Ebx6ib4/GreT0amWpfp6an9uOGkm7byhCLRZ7tmgMNACmaPg8jCeOLjyZjZoTVMrWoRTrdU9PLZbFiTFkKU4cGuVo4YWzfeJAXSnefcr9//AsoV00AGQDax2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by MW5PR11MB5788.namprd11.prod.outlook.com (2603:10b6:303:198::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Wed, 6 Sep
 2023 02:45:21 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6745.030; Wed, 6 Sep 2023
 02:45:21 +0000
Date:   Wed, 6 Sep 2023 10:45:10 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Qu Wenruo <wqu@suse.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-btrfs@vger.kernel.org>, <ying.huang@intel.com>,
        <feng.tang@intel.com>, <fengwei.yin@intel.com>,
        <oliver.sang@intel.com>
Subject: Re: [PATCH 3/3] btrfs: utilize the physically/virtually continuous
 extent buffer memory
Message-ID: <202309061050.19c12499-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8bc15bfdaa2805d1d1b660b8b2e07a55aa02027d.1692858397.git.wqu@suse.com>
X-ClientProxiedBy: SI2PR04CA0007.apcprd04.prod.outlook.com
 (2603:1096:4:197::19) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|MW5PR11MB5788:EE_
X-MS-Office365-Filtering-Correlation-Id: aebda27e-0ff0-47b8-977a-08dbae834fee
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S0ej1vk711A7VWr0OAxPe8a0aewCMgG8it6vXwfFwkObXaWgRIaL4Qkasjud/CyFAz+3Jj88efJtbPVgPzzjpQ3Cs3wt0X0pb9HjMUVbitF3quGv7fDqwNP8MU6plj/Guq3BEoeDCooLtvfyfadvp5aBOxjIVZDtux15uYY0ztqabUTnJ4Phn1pcnAxpfi5q/oR8fLa1lVz3UveC7tuvfK1V+JgSDlnhBT+HTw0m4+1JIuKo3IX7lQULF7/6lAYl1rjQYkjwmhD7cw/FMo1FlJxsLx/VEJ+GVDH3zFaJcWoRKdlCQCi0rsJotYscGyrDNw6otvh5rqhZT+G6d+vkI1VU3FFpOp7JkrUSpsn3gOo4GAchFXe3D1AsCkg9r79KT+5GmjgIAUYLlERqenUuygXsZoDJ/yYdjxv+n3f5ztLl9zJRYcvw1yL/UTP3sV1LEej6YWOuRxu+IlnXazvL35TmdL1V56tO0lxB4LyzsQ4vWmw1+likFosrIf91C2ZkNI3oXrXGJZzCezFc74ZBQncg3j8D1lDgCBOHsXQd+usNx/Cmya7H0ugxYxXbim9EoAcGpK8cb6L6GuouGTluvA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(136003)(366004)(376002)(186009)(1800799009)(451199024)(38100700002)(478600001)(5660300002)(966005)(6666004)(82960400001)(6916009)(66946007)(66556008)(66476007)(316002)(41300700001)(4326008)(8936002)(8676002)(83380400001)(2906002)(26005)(30864003)(86362001)(36756003)(6512007)(107886003)(2616005)(1076003)(6506007)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?LiOa1zZfDDwWkcPzbwTkvHTY0YFmhkP/CpRd+Zb4LWDAvfAtczWYxT7FyH?=
 =?iso-8859-1?Q?dKlZVjmKOIGoGz959/Vyoer0Ewxn7aztJiUou4qaqiGVZsZm/q+gx2HMSp?=
 =?iso-8859-1?Q?Ux7+c9E5skRaD8VgSUjWW/xPjtk6eru4Lr++SvVb4pQK+2lADWurvM7J8v?=
 =?iso-8859-1?Q?XrVBfpWrjhxo/HuWd76zAVd9C/lEZvh9DCoFgJIs1ICLxnmsZwn9qo8dwi?=
 =?iso-8859-1?Q?sBC4V3C3ThxlJEiaVTzoQnLIwUEJ6Csez96M5yWA9lYLZV9cm8PzBEKpbB?=
 =?iso-8859-1?Q?3fxIt34DCdoA5TS8GRCtPmx3bCqRLVQ3HtAcSB0pfLCPfbw21ZxwmUeerC?=
 =?iso-8859-1?Q?NZzSJEbvEFuQsbMa2PwzySii+9nsu0twscF5H5wOn9OUtmXgx/oYB33/fS?=
 =?iso-8859-1?Q?SmCN3CF8PzE4Bc+hnP9WSbUnZt0TxGfalEL9plzehChDISpRmkDa84wZLb?=
 =?iso-8859-1?Q?Q3FBgKFWscMXYJcgC+RA0Xz+u0uAaB7pS6boDPSlRCudEHH6GVPEbchRai?=
 =?iso-8859-1?Q?u1y0OeSSJkL3OfE83Q7C9pOpcs8TS9/DCjCyi7vkZSi4qeHuClba51DdQH?=
 =?iso-8859-1?Q?j4y1uBurc0sjpNAH463u9ARfokxfDOUCkH881Js5Rmn4INmMi1DrRSFYNT?=
 =?iso-8859-1?Q?TLzsPMmGL8/QNv6fzSuaGNAXInmWT5mRlAX7p6ibynIKkGC822V0nlJJvT?=
 =?iso-8859-1?Q?pTPR4Yll0dLET90gWyFgPEZXMk8JF5bxTCN0tLIptrMxJYt3khSucv95hy?=
 =?iso-8859-1?Q?ViSP+JY6tEYnNM7g+X/E2K7EbMAmvnij6SqBfYvA9eE3/MskHbJ8mQOy8u?=
 =?iso-8859-1?Q?JT5oCS+Rfgx9L2pmjtVwHHXtotn5OC3Tj7x80r3BEOfEt9VWfK0rJom2ve?=
 =?iso-8859-1?Q?f3cAWwE1CtMktJXm4/rglUKQRh2yE62KptynqTCjAZyyUTzeEODjeKDezN?=
 =?iso-8859-1?Q?9ALMErA8OeI5nuFQyLAYwBzweQLfvYMurLnkLI0XsrT6Wy+XsmC3Ce9ZTU?=
 =?iso-8859-1?Q?wtuOG1UmFMZGH6PMX17h17Dj5kpkDv+0wnvuLrzfwW03K05uotpyQo12Nw?=
 =?iso-8859-1?Q?JjGI9shXd0GY5FPmqXwwuebn7M1sZjO5dvCKmUdPVM+bHXKk3UqVyF9l8I?=
 =?iso-8859-1?Q?xxXpQUUe/Pae+4faQDZtJrhNohTYg3LvBdzkemOXbeGA+Pt0n/9HZCtP3H?=
 =?iso-8859-1?Q?ruInuVx1KaMdjZoQvHFJiom9fWH6K5L8NRf0ner0oPNQKgYlbyicS9ZJYE?=
 =?iso-8859-1?Q?ZA4bLYzO4gJ/8ZwKs9sauotywRZJwStNsbQgiYKsMHUU1k3tvRMQJLZSWm?=
 =?iso-8859-1?Q?SABj6yWgJ5obD37CH1eF5BVQIK0kRTMoE0614tEttzl1UbyeKpAm/TKJjZ?=
 =?iso-8859-1?Q?rfUjmq/HdBCZD8or8OGFW+lKHYEYE4XTQ6hLcvi3m1XuFWgTwAafqQeIG4?=
 =?iso-8859-1?Q?wW3UsQGuGvLSYie8/4O6I7MXxyOTt3EcezqbVjaODEJQjLNkoWIzCjJFL2?=
 =?iso-8859-1?Q?ytyK0kkg038M8a5PkBJSeFX2tXIVD07xxJjcPpQREizixhqccnIpyQG7UW?=
 =?iso-8859-1?Q?59jjp4O53VQSmcd9Aff3BARwP6X2nuVkgIm9dTVddmPwM0EACOdd/hU++n?=
 =?iso-8859-1?Q?WYtiOpwH1ioz0laKkblSYAMZ/8qllIieYWnZpdsrwd483qrHfvTaGeIg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aebda27e-0ff0-47b8-977a-08dbae834fee
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 02:45:21.1616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PbCkqAixno3o1NzV4h4RLQiG3L3M+26QbtcEUZYnHAWiEZXaJcX9AhxkcHcp+5d+j8Cdyz4GVhRrMJimUeE9Sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5788
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



Hello,

kernel test robot noticed a 12.0% improvement of filebench.sum_operations/s on:


commit: 2fa4ac9754a7fa77bad88aae11ac77ba137d3858 ("[PATCH 3/3] btrfs: utilize the physically/virtually continuous extent buffer memory")
url: https://github.com/intel-lab-lkp/linux/commits/Qu-Wenruo/btrfs-warn-on-tree-blocks-which-are-not-nodesize-aligned/20230824-143628
base: https://git.kernel.org/cgit/linux/kernel/git/kdave/linux.git for-next
patch link: https://lore.kernel.org/all/8bc15bfdaa2805d1d1b660b8b2e07a55aa02027d.1692858397.git.wqu@suse.com/
patch subject: [PATCH 3/3] btrfs: utilize the physically/virtually continuous extent buffer memory

testcase: filebench
test machine: 96 threads 2 sockets (Ice Lake) with 128G memory
parameters:

	disk: 1HDD
	fs: btrfs
	fs2: cifs
	test: webproxy.f
	cpufreq_governor: performance






Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230906/202309061050.19c12499-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/disk/fs2/fs/kconfig/rootfs/tbox_group/test/testcase:
  gcc-12/performance/1HDD/cifs/btrfs/x86_64-rhel-8.3/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp1/webproxy.f/filebench

commit: 
  19e81514b8 ("btrfs: map uncontinuous extent buffer pages into virtual address space")
  2fa4ac9754 ("btrfs: utilize the physically/virtually continuous extent buffer memory")

19e81514b8c09202 2fa4ac9754a7fa77bad88aae11a 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     30592 ±194%     -92.3%       2343 ± 24%  sched_debug.cpu.avg_idle.min
      1.38            -5.9%       1.30        iostat.cpu.iowait
      4.63            +8.9%       5.04        iostat.cpu.system
      2.56            +0.5        3.09        mpstat.cpu.all.sys%
      0.54            +0.1        0.61        mpstat.cpu.all.usr%
      1996            +3.3%       2062        vmstat.io.bo
     33480           +13.5%      37993        vmstat.system.cs
    152.67           +12.6%     171.83        turbostat.Avg_MHz
      2562            +4.2%       2670        turbostat.Bzy_MHz
      5.34            +0.5        5.83        turbostat.C1E%
      7.12 ± 12%     -21.6%       5.58 ± 12%  turbostat.Pkg%pc2
    209.72            +1.5%     212.81        turbostat.PkgWatt
      4.92 ± 24%      +3.5        8.37 ± 32%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      5.13 ± 28%      +3.6        8.68 ± 31%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      5.13 ± 28%      +3.8        8.90 ± 30%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      5.13 ± 28%      +3.8        8.90 ± 30%  perf-profile.children.cycles-pp.cpuidle_enter
      5.13 ± 28%      +3.8        8.90 ± 30%  perf-profile.children.cycles-pp.cpuidle_enter_state
      5.34 ± 34%      +3.9        9.21 ± 28%  perf-profile.children.cycles-pp.cpuidle_idle_call
     13.90            +9.6%      15.23        filebench.sum_bytes_mb/s
    238030           +12.0%     266575        filebench.sum_operations
      3966           +12.0%       4442        filebench.sum_operations/s
      1043           +12.0%       1168        filebench.sum_reads/s
     25.14           -10.7%      22.46        filebench.sum_time_ms/op
    208.83           +11.9%     233.67        filebench.sum_writes/s
    506705            +5.8%     536097        filebench.time.file_system_outputs
      1597 ±  5%     -36.1%       1020 ±  3%  filebench.time.involuntary_context_switches
     61810 ±  2%      +6.0%      65519        filebench.time.minor_page_faults
    157.67 ±  2%     +31.5%     207.33        filebench.time.percent_of_cpu_this_job_got
    117.60 ±  2%     +27.1%     149.48        filebench.time.system_time
    375177           +10.3%     413862        filebench.time.voluntary_context_switches
     18717            +6.5%      19942        proc-vmstat.nr_active_anon
     20206            +1.2%      20445        proc-vmstat.nr_active_file
    298911            +2.2%     305406        proc-vmstat.nr_anon_pages
    132893            +5.6%     140397        proc-vmstat.nr_dirtied
    313040            +2.0%     319443        proc-vmstat.nr_inactive_anon
     32910            +3.4%      34035        proc-vmstat.nr_shmem
     62503            +1.4%      63367        proc-vmstat.nr_slab_unreclaimable
     99471            +3.7%     103159        proc-vmstat.nr_written
     18717            +6.5%      19942        proc-vmstat.nr_zone_active_anon
     20206            +1.2%      20445        proc-vmstat.nr_zone_active_file
    313040            +2.0%     319443        proc-vmstat.nr_zone_inactive_anon
    943632            +3.2%     974142        proc-vmstat.numa_hit
    841654            +3.6%     871757        proc-vmstat.numa_local
    453634 ± 17%     +27.0%     576268 ±  5%  proc-vmstat.numa_pte_updates
     87464            +6.1%      92814        proc-vmstat.pgactivate
   1595438            +2.9%    1641074        proc-vmstat.pgalloc_normal
   1453326            +3.0%    1497530        proc-vmstat.pgfree
     17590 ±  5%     +14.0%      20045 ±  7%  proc-vmstat.pgreuse
    732160            -1.8%     719104        proc-vmstat.unevictable_pgs_scanned
     19.10            -8.1%      17.55        perf-stat.i.MPKI
 2.039e+09           +17.3%  2.393e+09        perf-stat.i.branch-instructions
      1.27 ±  2%      -0.1        1.15        perf-stat.i.branch-miss-rate%
  25600761            +5.8%   27075672        perf-stat.i.branch-misses
   5037721 ±  4%     +11.4%    5612619        perf-stat.i.cache-misses
 1.632e+08            +5.9%  1.729e+08        perf-stat.i.cache-references
     34079           +14.1%      38871        perf-stat.i.context-switches
 1.326e+10           +14.7%  1.521e+10        perf-stat.i.cpu-cycles
    551.02 ±  2%     +21.0%     666.59 ±  3%  perf-stat.i.cpu-migrations
   3953434 ±  2%     +10.8%    4381924 ±  3%  perf-stat.i.dTLB-load-misses
 2.343e+09           +15.4%  2.704e+09        perf-stat.i.dTLB-loads
 1.141e+09           +14.3%  1.303e+09        perf-stat.i.dTLB-stores
 9.047e+09           +14.9%  1.039e+10        perf-stat.i.instructions
      0.69            +2.0%       0.71        perf-stat.i.ipc
      0.14           +14.7%       0.16        perf-stat.i.metric.GHz
     34.94 ±  4%     +11.1%      38.80        perf-stat.i.metric.K/sec
     59.21           +15.6%      68.43        perf-stat.i.metric.M/sec
      3999 ±  3%      +6.3%       4250        perf-stat.i.minor-faults
   1116010 ±  4%     +14.8%    1280875 ±  2%  perf-stat.i.node-load-misses
   1168171 ±  3%      +7.9%    1259922 ±  2%  perf-stat.i.node-stores
      3999 ±  3%      +6.3%       4250        perf-stat.i.page-faults
     18.04            -7.8%      16.64        perf-stat.overall.MPKI
      1.26 ±  2%      -0.1        1.13        perf-stat.overall.branch-miss-rate%
 2.012e+09           +17.3%  2.359e+09        perf-stat.ps.branch-instructions
  25253051            +5.7%   26690222        perf-stat.ps.branch-misses
   4970910 ±  4%     +11.3%    5534021        perf-stat.ps.cache-misses
  1.61e+08            +5.9%  1.705e+08        perf-stat.ps.cache-references
     33628           +14.0%      38332        perf-stat.ps.context-switches
 1.308e+10           +14.6%    1.5e+10        perf-stat.ps.cpu-cycles
    543.73 ±  2%     +20.9%     657.37 ±  3%  perf-stat.ps.cpu-migrations
   3900887 ±  2%     +10.8%    4321011 ±  3%  perf-stat.ps.dTLB-load-misses
 2.312e+09           +15.3%  2.666e+09        perf-stat.ps.dTLB-loads
 1.125e+09           +14.2%  1.285e+09        perf-stat.ps.dTLB-stores
 8.925e+09           +14.8%  1.024e+10        perf-stat.ps.instructions
      3943 ±  3%      +6.2%       4187        perf-stat.ps.minor-faults
   1101275 ±  4%     +14.7%    1263151 ±  2%  perf-stat.ps.node-load-misses
   1152648 ±  3%      +7.7%    1241973 ±  2%  perf-stat.ps.node-stores
      3943 ±  3%      +6.2%       4187        perf-stat.ps.page-faults
 6.777e+11           +10.5%   7.49e+11        perf-stat.total.instructions
      0.01 ±  7%     -28.2%       0.00 ± 26%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.__btrfs_tree_read_lock
      0.30 ± 35%     -63.0%       0.11 ± 25%  perf-sched.sch_delay.max.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc.cifs_strndup_to_utf16.cifs_convert_path_to_utf16
     30.21 ±  3%      -6.2%      28.33 ±  3%  perf-sched.total_wait_and_delay.average.ms
     30.15 ±  3%      -6.2%      28.28 ±  3%  perf-sched.total_wait_time.average.ms
      1.08           -20.5%       0.86 ±  2%  perf-sched.wait_and_delay.avg.ms.io_schedule.folio_wait_bit_common.filemap_update_page.filemap_get_pages
     99.86 ± 27%     +71.6%     171.38 ± 32%  perf-sched.wait_and_delay.avg.ms.kthreadd.ret_from_fork.ret_from_fork_asm
      1.10 ±  2%     -16.3%       0.92        perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      1.41 ±  5%     -87.1%       0.18 ±223%  perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.cifs_call_async
      0.21           -13.4%       0.18        perf-sched.wait_and_delay.avg.ms.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
    195.95 ± 10%     -18.4%     159.83 ± 12%  perf-sched.wait_and_delay.avg.ms.wait_for_response.compound_send_recv.cifs_send_recv.__SMB2_close
      2.60           -23.5%       1.99        perf-sched.wait_and_delay.avg.ms.wait_for_response.compound_send_recv.cifs_send_recv.query_info
     20.46           -13.7%      17.66 ±  4%  perf-sched.wait_and_delay.avg.ms.wait_for_response.compound_send_recv.smb2_compound_op.smb2_query_path_info
      3.35 ± 66%    +342.5%      14.82 ± 20%  perf-sched.wait_and_delay.avg.ms.wait_for_response.compound_send_recv.smb2_compound_op.smb2_unlink
      2103           +10.0%       2312 ±  3%  perf-sched.wait_and_delay.count.__lock_sock.sk_wait_data.tcp_recvmsg_locked.tcp_recvmsg
      1025           +14.8%       1176        perf-sched.wait_and_delay.count.io_schedule.folio_wait_bit_common.folio_wait_writeback.__filemap_fdatawait_range
      9729 ±  2%     +21.1%      11779        perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      2349 ±  9%     +29.3%       3038 ± 10%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.__mutex_lock.constprop.0.compound_send_recv
    998.00           +14.3%       1140        perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_unlinkat
      1026           +15.0%       1181        perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.open_last_lookups
     18409           +12.5%      20714 ±  4%  perf-sched.wait_and_delay.count.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
      1011           +14.8%       1160        perf-sched.wait_and_delay.count.wait_for_response.compound_send_recv.cifs_send_recv.query_info
      1013           +14.5%       1160        perf-sched.wait_and_delay.count.wait_for_response.compound_send_recv.smb2_compound_op.smb2_unlink
      2.68 ±  4%     -19.6%       2.16 ±  7%  perf-sched.wait_and_delay.max.ms.__lock_sock.sk_wait_data.tcp_recvmsg_locked.tcp_recvmsg
    282.00 ±  3%     -11.3%     250.07 ±  4%  perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_unlinkat
    280.97 ±  2%     -12.8%     244.97 ±  2%  perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.open_last_lookups
      0.49 ±125%     -97.2%       0.01 ±198%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single
      1.05           -20.9%       0.83 ±  2%  perf-sched.wait_time.avg.ms.io_schedule.folio_wait_bit_common.filemap_update_page.filemap_get_pages
      2.14 ±  4%     +19.1%       2.55 ±  8%  perf-sched.wait_time.avg.ms.io_schedule.rq_qos_wait.wbt_wait.__rq_qos_throttle
     99.82 ± 27%     +69.8%     169.46 ± 31%  perf-sched.wait_time.avg.ms.kthreadd.ret_from_fork.ret_from_fork_asm
      1.08 ±  2%     -16.6%       0.90        perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      1.37 ±  5%     -24.5%       1.03 ±  5%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.cifs_call_async
      0.20           -14.2%       0.17        perf-sched.wait_time.avg.ms.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
    195.53 ± 10%     -18.4%     159.54 ± 12%  perf-sched.wait_time.avg.ms.wait_for_response.compound_send_recv.cifs_send_recv.__SMB2_close
      2.54           -24.0%       1.93        perf-sched.wait_time.avg.ms.wait_for_response.compound_send_recv.cifs_send_recv.query_info
     20.44           -13.8%      17.63 ±  4%  perf-sched.wait_time.avg.ms.wait_for_response.compound_send_recv.smb2_compound_op.smb2_query_path_info
      3.32 ± 67%    +345.6%      14.78 ± 20%  perf-sched.wait_time.avg.ms.wait_for_response.compound_send_recv.smb2_compound_op.smb2_unlink
    245.89 ±  9%     -11.8%     216.92 ±  6%  perf-sched.wait_time.max.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc.cifs_strndup_to_utf16.cifs_convert_path_to_utf16
      3.14 ±  9%     -43.6%       1.77 ± 40%  perf-sched.wait_time.max.ms.__cond_resched.dput.terminate_walk.path_openat.do_filp_open
      2.65 ±  3%     -19.9%       2.12 ±  6%  perf-sched.wait_time.max.ms.__lock_sock.sk_wait_data.tcp_recvmsg_locked.tcp_recvmsg
      0.57 ±101%     -91.5%       0.05 ±213%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single
      1.79 ± 82%     -86.4%       0.24 ± 58%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
    281.92 ±  3%     -11.3%     249.99 ±  4%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.do_unlinkat
    280.90 ±  2%     -12.8%     244.88 ±  2%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.open_last_lookups




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

