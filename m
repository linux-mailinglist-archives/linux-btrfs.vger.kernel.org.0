Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5D77AE5C8
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Sep 2023 08:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233710AbjIZGZZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Sep 2023 02:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbjIZGZY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Sep 2023 02:25:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB82DF
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Sep 2023 23:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695709517; x=1727245517;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=yk3F53lq+MZeaQ3UEnDM6EU7NBbRqcoUCdyowDfK1iI=;
  b=GhgzxCCkTiyTDA7ur3MZCn85bel4yC26DRz5Q/kWAZM/UuksOPD1th4E
   HtVIiNoITUEkS1t/06AWk7nCzTUfOSe5beHQJNh0Arp1KRY+qnvl0MvjG
   78UJOP1uE5de5wx6/EPRlnCue/gwr33iw3tWScWZFvosqJvt/Hi/iMVvH
   lnJ1f9h26zP8qbTT8mGVhDLtXQpqzPN5vFAtXK+n/O4UFVLoQLDNAPu+S
   bOML2xhV9kBQsVEJUrm4vFQyTyoYecCBZpRBdsAbP7dRVKOC0nmLBORWG
   OEsKF1vNdyI1ym61/YhazDSWc54FgyNuhzQkEqCw9N9q2xn+W3rN6/lvM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="385345412"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="385345412"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 23:25:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="872378053"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="872378053"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Sep 2023 23:25:16 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 23:25:16 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 23:25:15 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 25 Sep 2023 23:25:15 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 25 Sep 2023 23:25:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lE5sbySCvEAV0Q/gbUfgDw7DK1+ICB1hTFoqLt2eSIDNbhOArvnrMetK09ONEbcVb7TCPrqCnCXZt7S8WZCAfvFfbnm0D8gxTlj712gNeGrQ0uQtZ+oYb4DAhSQFZZlLmXUqbRI2Q9dd78cQzWwp/q7QS1TP7s92tcGf2oixVAZ9F73ehStT0Ri+l02avjdzE5q0qY/LBhNm+5CV1qWsw6pmme9pk3Xxj46EUAwAboyh59wfIg2/TlT89C1QhbbWnmEc3e62AfxbkBdEflnWj38nvvMetAQtdlsDDH4lpa6Td+XX9P4WhbTfU2BvhkT0oMhYbw63NREbN3MnCRz8Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fAJUcyyIugZNdmh269Eg8EGdWYd7z0M80ShEZi00QHw=;
 b=YjGmIi+yMXfg98XTaEkl1JVwhV5bY+eyeU/v/IAcI9QKArDQdNyqnAIXeA3vFfwbusEE4pdB5uBirOeZ94UC4GC1uF15z5EaGMIYiYuiYqsci3okF8QGh8sRNnNhg3I80F1swaqCuc60+nkYJVZgew9fieIVDfdOvKprOT3LRE+G3iZDbV0drsYX1w2C7TAMKpy0x5mxaNizO5l1FsGh+gLd32Dj+E8D+Qa7WbMYWkNK6KZDVOdJoTJJRrYDsF+uRhZ3n3dGiEqH7WjAg3B0ACu9NAIqhKEdA733j6IvQFPHe6iKq2pDEI6HW+OrAiuSp7sZP1ubyGDLQNTIPScrNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by CO1PR11MB4930.namprd11.prod.outlook.com (2603:10b6:303:9b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Tue, 26 Sep
 2023 06:25:14 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6813.017; Tue, 26 Sep 2023
 06:25:14 +0000
Date:   Tue, 26 Sep 2023 14:25:06 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     <fdmanana@kernel.org>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-btrfs@vger.kernel.org>, <ltp@lists.linux.it>,
        <oliver.sang@intel.com>
Subject: Re: [PATCH 7/8] btrfs: use extent_io_tree_release() to empty dirty
 log pages
Message-ID: <202309261438.d1bebb50-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <459c0d25abdfecdc7c57192fa656c6abda11af31.1695333278.git.fdmanana@suse.com>
X-ClientProxiedBy: SI2PR01CA0025.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::10) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|CO1PR11MB4930:EE_
X-MS-Office365-Filtering-Correlation-Id: 9901e5be-6d93-4514-6c1e-08dbbe5957e1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ou1QNKvFK8X7/Qu40ilpwPfaYMjwyiyvWBJxTuyK1t71TRxo3OSzoSrkwV6IvZqZSTXHxCSk7cuFAOOlm9nJJ8riPs7IiWZv9oWccy8Qq+7H1Hf2Kmfup+cuJj0+ccOO3EIQdORzQW0BRSVDTQIFzaLPjO53tMi34q39cVj9i90eIrB0J7t244LpllN+mKmChgkLOi7E6vHFrFbCXyZBRT0KB9p/Ifp9g+UZKK+06h4UR6I+E9YJffuLU8gQG6XaLn6gAysOQeTRqBokbTERIwjJW4QVBIrgap8As9MFI+btMbBmYgUc4oMxF5de38TGUIrZ/YR1IjAgszmu+HKNbG6SmwGQyjNaEQStqQacFmYwMeWQfUaoXultfrHwCA0aLTj9G0y8qU8HRi/7gV1alb3YIIqB//vl9PqYjQpz3FqovDBYZpauheEQbowMdVbdvLiPEEaH0lkvEMPJyuNTg0/q/BY6LWYAGyNMR9rt3JV4FDLD84labvqROw3pH2jruRxafu2HAOiosP+ww4jgSP/EdkBTpWYqMBTZJHyejURbAj4Rn0Y1d4bxozqHa2upIlEOrOUSpGKOr1m6uGwO1cg2ea4YTpdGqFErCWlJQ+urZ9GVD/vq4QfYUMZiUS8+FRO2cBuV+391HH0wnfPJUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(39860400002)(366004)(396003)(230922051799003)(1800799009)(186009)(451199024)(6506007)(478600001)(6486002)(6512007)(6666004)(36756003)(8936002)(82960400001)(38100700002)(966005)(2616005)(1076003)(66946007)(26005)(83380400001)(2906002)(86362001)(4326008)(41300700001)(5660300002)(8676002)(316002)(6916009)(66476007)(107886003)(66556008)(14143004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z0Vn8NbPCyJI81bQcvgSjf0jVwlJqxSnyQVN20e1Xx4JkZTESOncQv8tGq/w?=
 =?us-ascii?Q?xklvmX0/snA84yKkbm13Wa1omJS40edGoFsMMehg+cONr6DHNyap6+S9QEwX?=
 =?us-ascii?Q?zktMeZdGhgBAkk0I9BYtrvoxOgWByfLlTV/+3IT7xe0xcQ8nO/tgkF8GFOxs?=
 =?us-ascii?Q?Cde8NLM+AA6tHgcKrhoH9TAqu6FjqdoTwXIj2Tiwd8D2YZ7e8Gmei98c0k4H?=
 =?us-ascii?Q?bD94TBuuXiC1RQwKPtNByJCXfAXqljGNssGKuIxCKhN+sDWnruCaUAWI2Tec?=
 =?us-ascii?Q?HsxwSfZ1TXlNPBNUiUL7caeYRVOgVKpN3y68qYItpJgZP2+KMO1CFxv4BH3x?=
 =?us-ascii?Q?eaNOyYmuogYIU63JyDUJXtitZieQpZKqjh3tUF9WFJ7+QHc8pbIYHz56cK7m?=
 =?us-ascii?Q?t01biOFlgxJaLTkxWHNxTcrYKZkn2QeFUPW7fSuqiBiGiiQI3siSRNKYAZVt?=
 =?us-ascii?Q?8Jr8aU04szdIcFyAPPYU9tls9TA260faLsVOY1Ol7uUo9dlKrB15HYeXYsTi?=
 =?us-ascii?Q?nOZJcVVGPW6+pJDE6VjQvk9gs5rNLZSBVje2vAx8D1kokoXxZ8i693zPw2cj?=
 =?us-ascii?Q?BoL39KR2392Z+BdwlYDDV31j1Za/Q40S9jGyhWSm43ElIk4wZ4luAukYpaZS?=
 =?us-ascii?Q?fZP5A94HUqD2A8xZYQK/7ZUhzGPpAlv1WeGfNdaguq/QzK6Z4qt89NcdyH72?=
 =?us-ascii?Q?o+YtA6PwPeauQYKGAV6vm4V64gnz320iY45bDt+mq1Y51bOXdle/S9MeovPG?=
 =?us-ascii?Q?N3fZtN/JUMbZ2/gosBzl16FDZe0MCzadpt2U7aRYwfj5OenxOyHuh/zNhTKn?=
 =?us-ascii?Q?xrpTwke2LBl2gnezhLppFiiey1Q5f+qYee61gbcLaMwPubiAPsADtPeF+7iB?=
 =?us-ascii?Q?RbN2/vty8v+2gAMT44A3tUeZpHElSqmgSSrfCZanzTDib7iY0EsTPQQpEkNE?=
 =?us-ascii?Q?CTkcu0UYW2mqyrYAknnnr6E4dAR3iEf6zuZy7mDTVCb1CBL90gUAoI90PLD4?=
 =?us-ascii?Q?iMGoezPKZBGgRz4/LlDCp3/8a1p3VVtdeRQb2yIUXdhryNY1YoqdPosKUv78?=
 =?us-ascii?Q?HmdHyl/tj2MwdQO6WTFZZekCmxWRhSywwcyl/pDGFI9IGaDjMoS3cbjtaOzI?=
 =?us-ascii?Q?EA7qMHpbKKFDOZMLUres0D1Ny/nYfG+yNROknam2TWxydwkn0V1EdD+WyHm8?=
 =?us-ascii?Q?z19oPnGT0SEfrGvN1YTndjH31HN/YVjLr434OXZp+HTdkIwCWY0algjMI39A?=
 =?us-ascii?Q?e68NDLghsWQPa1XgzATRrn3wYCwE5zNzmMnAAckKg1kCSPrR9S+eE02x2J5Q?=
 =?us-ascii?Q?rOnv7c6xOqk/PzrBP5/u1CBueOVv3FA6jsPuj3PZFDTO2rp4qTG5VZstyQrg?=
 =?us-ascii?Q?mfc5K+15HFPEIsApvR9FXhONBxH+qGiOc8rRyLpQXYkO2aBS0q4FUwre6Zhp?=
 =?us-ascii?Q?iSREIUYtf6tgSSUYEAV/mGQgf7ZSC0f0snWnIIM2qVtsi0J1Vnk9BYzyaLCs?=
 =?us-ascii?Q?rE9ek8X8Q/zUd/H4TSnoDtQ6OdrDZbINlz+TZ8nD7eQ5S4ib0T6cP9Ur6v7A?=
 =?us-ascii?Q?ruOm5vfJjt+gKonueginN6TSHXswPZniZlGeJenKf4eyErRcNTcNotlhcBEN?=
 =?us-ascii?Q?AQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9901e5be-6d93-4514-6c1e-08dbbe5957e1
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 06:25:14.1443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bN8QRH95l0Ul3bEeQTPv8zU2CnWBm5616Yg/SxM0slCe50zZcioTabg5zjtN1JQuh4UfhSoQUSe4L/7i/I1kGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4930
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



Hello,

kernel test robot noticed "BUG:sleeping_function_called_from_invalid_context_at_fs/btrfs/extent-io-tree.c" on:

commit: 84b23544b95acd2e4c05fc473816d19b749fe17b ("[PATCH 7/8] btrfs: use extent_io_tree_release() to empty dirty log pages")
url: https://github.com/intel-lab-lkp/linux/commits/fdmanana-kernel-org/btrfs-make-extent-state-merges-more-efficient-during-insertions/20230922-184038
base: https://git.kernel.org/cgit/linux/kernel/git/kdave/linux.git for-next
patch link: https://lore.kernel.org/all/459c0d25abdfecdc7c57192fa656c6abda11af31.1695333278.git.fdmanana@suse.com/
patch subject: [PATCH 7/8] btrfs: use extent_io_tree_release() to empty dirty log pages

in testcase: ltp
version: ltp-x86_64-14c1f76-1_20230715
with following parameters:

	disk: 1HDD
	fs: btrfs
	test: ltp-aiodio.part2-01



compiler: gcc-12
test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz (Ivy Bridge) with 8G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202309261438.d1bebb50-oliver.sang@intel.com



kern  :err   : [  179.301033] BUG: sleeping function called from invalid context at fs/btrfs/extent-io-tree.c:132
kern  :err   : [  179.301247] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 3670, name: aiodio_sparse
kern  :err   : [  179.301432] preempt_count: 1, expected: 0
kern  :err   : [  179.301544] RCU nest depth: 0, expected: 0
kern  :warn  : [  179.301708] CPU: 1 PID: 3670 Comm: aiodio_sparse Not tainted 6.6.0-rc2-00143-g84b23544b95a #1
kern  :warn  : [  179.301924] Hardware name: Hewlett-Packard p6-1451cx/2ADA, BIOS 8.15 02/05/2013
kern  :warn  : [  179.302126] Call Trace:
kern  :warn  : [  179.302242]  <TASK>
kern :warn : [  179.302351] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
kern :warn : [  179.302489] __might_resched (kernel/sched/core.c:10188) 
kern :warn : [  179.302630] ? preempt_notifier_dec (kernel/sched/core.c:10142) 
kern :warn : [  179.302781] ? extent_io_tree_release (fs/btrfs/extent-io-tree.c:132) btrfs
kern :warn : [  179.303082] ? walk_down_log_tree (fs/btrfs/tree-log.c:2711) btrfs
kern :warn : [  179.303368] extent_io_tree_release (include/linux/sched.h:2097 fs/btrfs/extent-io-tree.c:132) btrfs
kern :warn : [  179.303657] free_log_tree (fs/btrfs/tree-log.c:3214) btrfs
kern :warn : [  179.303922] ? walk_log_tree (fs/btrfs/tree-log.c:3173) btrfs
kern :warn : [  179.304123] ? free_log_tree (fs/btrfs/tree-log.c:330) btrfs
kern :warn : [  179.304323] btrfs_free_log (fs/btrfs/tree-log.c:3227) btrfs
kern :warn : [  179.304519] commit_fs_roots (fs/btrfs/transaction.c:1539) btrfs
kern :warn : [  179.304721] ? btrfs_read_block_groups (fs/btrfs/block-group.c:2668) btrfs
kern :warn : [  179.304934] ? __btrfs_run_delayed_refs (fs/btrfs/extent-tree.c:2135) btrfs
kern :warn : [  179.305142] ? trace_btrfs_transaction_commit (fs/btrfs/transaction.c:1501) btrfs
kern :warn : [  179.305357] btrfs_commit_transaction (fs/btrfs/transaction.c:2508 (discriminator 3)) btrfs
kern :warn : [  179.305566] ? cleanup_transaction (fs/btrfs/transaction.c:2243) btrfs
kern :warn : [  179.305769] ? dput (fs/dcache.c:900) 
kern :warn : [  179.305879] ? dget_parent (fs/dcache.c:971) 
kern :warn : [  179.305988] btrfs_sync_file (fs/btrfs/file.c:1987) btrfs
kern :warn : [  179.306184] ? start_ordered_ops+0x100/0x100 btrfs
kern :warn : [  179.306400] ? find_vma (mm/mmap.c:1853) 
kern :warn : [  179.306506] ? find_vma_intersection (mm/mmap.c:1853) 
kern :warn : [  179.306630] __do_sys_msync (mm/msync.c:97) 
kern :warn : [  179.306742] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
kern :warn : [  179.306852] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
kern  :warn  : [  179.306986] RIP: 0033:0x7f3b83d45740
kern :warn : [ 179.307093] Code: 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 80 3d a1 8e 0d 00 00 74 17 b8 1a 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 89 54
All code
========
   0:	00 f7                	add    %dh,%bh
   2:	d8 64 89 01          	fsubs  0x1(%rcx,%rcx,4)
   6:	48 83 c8 ff          	or     $0xffffffffffffffff,%rax
   a:	c3                   	retq   
   b:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  12:	00 00 00 
  15:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  1a:	80 3d a1 8e 0d 00 00 	cmpb   $0x0,0xd8ea1(%rip)        # 0xd8ec2
  21:	74 17                	je     0x3a
  23:	b8 1a 00 00 00       	mov    $0x1a,%eax
  28:	0f 05                	syscall 
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 58                	ja     0x8a
  32:	c3                   	retq   
  33:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  3a:	48 83 ec 28          	sub    $0x28,%rsp
  3e:	89                   	.byte 0x89
  3f:	54                   	push   %rsp

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 58                	ja     0x60
   8:	c3                   	retq   
   9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  10:	48 83 ec 28          	sub    $0x28,%rsp
  14:	89                   	.byte 0x89
  15:	54                   	push   %rsp
kern  :warn  : [  179.307439] RSP: 002b:00007ffdafb85f58 EFLAGS: 00000202 ORIG_RAX: 000000000000001a
kern  :warn  : [  179.307615] RAX: ffffffffffffffda RBX: 0000000006400000 RCX: 00007f3b83d45740
kern  :warn  : [  179.307777] RDX: 0000000000000004 RSI: 0000000006400000 RDI: 00007f3b7d800000
kern  :warn  : [  179.307938] RBP: 00007f3b7d800000 R08: 0000000000000004 R09: 0000000000000000
kern  :warn  : [  179.308098] R10: 00007f3b83c50168 R11: 0000000000000202 R12: 0000000000000004
kern  :warn  : [  179.308287] R13: 000055b86e53d033 R14: 000055b86e53d140 R15: 0000000000000000
kern  :warn  : [  179.308454]  </TASK>



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230926/202309261438.d1bebb50-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

