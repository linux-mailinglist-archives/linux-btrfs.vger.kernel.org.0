Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12FD4563867
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Jul 2022 19:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbiGARIz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Jul 2022 13:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGARIx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 1 Jul 2022 13:08:53 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566D3219F;
        Fri,  1 Jul 2022 10:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656695332; x=1688231332;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ncXh69WBSfp8W7tJGtWfWVrGnq+cEJMHcm4u5TeEzko=;
  b=iX+rw0Sf0s4K3mgIII9H15hEb/Mke20U3cM50I+YqIO+k5juXpWkMW3E
   EBeEP4j501ubxo1urX/BEmb8pK7Yrs12WsKLVHonV2HBIIOZlEpRCRaQf
   DGeZa8H4wuQG2U4vwXvEPRcP7Rk2Me0wJE9ibXPIAfGf4Snby6xYUwXcn
   qMAc0DKBQ9b+lFKnl212bXHVzBNWzwcDPxSrXsUpSm9z0xeJNAXoQgpzC
   /GVQcT/OkdaW96N4xV96cAPljUNGllMcMTbqjKZYcDzzZ/L58LYHjhFNL
   RHVgzM7hz6JqWqHZ9oVaN5gbCqzwjImr8IRIIdooYFq+TCstqAknpItuc
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10395"; a="308221739"
X-IronPort-AV: E=Sophos;i="5.92,237,1650956400"; 
   d="scan'208";a="308221739"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 10:08:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,237,1650956400"; 
   d="scan'208";a="596325885"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 01 Jul 2022 10:08:48 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 1 Jul 2022 10:08:48 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 1 Jul 2022 10:08:48 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 1 Jul 2022 10:08:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fS9xowihIp2sam6qq8gD4g58saExoohXvxhh4+C9gx04EQdSYTc74g2M6rPhcMC+6Xg7tlZa21JyCRn4giribI5l060ZIntudwoN78F5XiNppqCECHRbbB+gwssu4w1IZbPhyRQ9PX7Bk6btk4s1p+5kC72TQjLXZ/Fxb42TkiYh0sbl/SgWs5YvLQzRuR08v9gOg/5u7bA/XvbLz68MHTx6dSid65NJVxMH6qJsnJd7lSY90vZltn+2aey3aCW8XvT4bjeVWXnxg24RBE/el5zlGxOyHlrTWrKcM5LinztQdBrIS6+ja8bnOABZTZRCPRiw4fYfb9/J+SWZzRHfyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zziPze4/ELb7CwJEcs0E9NHAqf+e9ShQ2/T2JxkMzFo=;
 b=j4y03pVgH1YMG4Y46eUC2NCZT47Ck82Ac6AGNq0gJnrMs8RKddBfkD0OSICwODSZaeEOJE4LX5P2XheQDD/pVyY6u/ocC+UeW7M04ZyupbHFhzURRwZt5C6qkeAfC9b7tWDiZJiVqB+j68nYwoQwtfsOHrbhnYUoJjJ1G1EkehtKMn0qp/LrzcVT+5Flc2h3Hn/sxk1K4rB0/RyfoIa3TLfvT/e8mXF7DAPEqlOSarvaHznGLLa2Y8w9nRsH30WxHZqvCA0NfmdqPQLd6mrX3Qnw7AeW3Iiu5OabTL4tmAhb4Pj5LE/eZNkcHMiMqLS/whLwdhSgSMo7iXrubhUPOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 BN6PR11MB4018.namprd11.prod.outlook.com (2603:10b6:405:7a::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.14; Fri, 1 Jul 2022 17:08:43 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::e912:6a38:4502:f207]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::e912:6a38:4502:f207%5]) with mapi id 15.20.5395.014; Fri, 1 Jul 2022
 17:08:42 +0000
Date:   Fri, 1 Jul 2022 10:08:34 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
CC:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Nick Terrell <terrelln@fb.com>, <linux-btrfs@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "James E. J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        "John David Anglin" <dave.anglin@bell.net>,
        <linux-parisc@vger.kernel.org>, "David Sterba" <dsterba@suse.cz>
Subject: Re: [RESEND PATCH v4 1/2] highmem: Make __kunmap_{local,atomic}()
 take "const void *"
Message-ID: <Yr8qEp+us0e+FS/g@iweiny-desk3>
References: <20220627111927.3ef94745aab4491901d43028@linux-foundation.org>
 <20220628144649.28046-1-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220628144649.28046-1-fmdefrancesco@gmail.com>
X-ClientProxiedBy: BYAPR07CA0004.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::17) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 066458ef-8f9a-4a9c-0bfc-08da5b8459ae
X-MS-TrafficTypeDiagnostic: BN6PR11MB4018:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MiRRhKpSJuhEjNqN0/pcemfvYOvAc6gFSSZGMUeMh5lGOfDnc6PJW+vAUiKaVDb05cY+6egs9bZGlR0lj05ETqaZJ/cuHt5upcVNVHA827rO9pomejH7zzRzTbXO4L2sn6OQ62Ltbn7+QGdBIRg67tBLidlc+tLzgGcBtXJk3OmWvNrIPQ7FzkQFDVtStVHtqWwakr1o7mY9I9gYdxaAmDzeU0X6E4WjGnvTlk/5kcgqdzjTU6bqkz4TXZPWg2p5JoQE/eb6mkC5gM3bmos+IE/2vW0zDv/PNnpVXGtnQtk109QhNqLtSD5e3zzaaTpD21kbpfwCnJ5kpKKYZ2yS8J47E8hZGgrxVjwwXeU1TPcXDJPXdNeTLXDfaI7iRZ1RQRTDUW+ZHDYm1sZaEdZNvfJifQa1RlqNC/opa5qLKvvaLZUFRvdTEcd96IM9ysC5kDFz09Mwc1pPIvsUYV83cSidBY1ZL5C1GNdpYYbfrc1DbXRCeslQtpxVXsbek4/D05LTBa99mtZSW5IgEckJ0MtE0VNfRys8hgRnr3icmuQcXs3OsB0e8BhTu4MK97Ti2wjjZZWDeq+MYkXgJJ2wZAu1lE5PbOQE2qapA7B3i3ePYrZc54hKE2YrlogiuhD9Fb/3hcfjt09AhUwLuQz++yTZzBErVAyOj/4rlRh98oXfmgiqpF7HBTK5kYNVkO5f7YIEeicOObvAH7OE9gmUrt6+dAr9yrQPP9eVdXE9oKDzcF6bxjEVG+luaj4W1UT5y/Hd93rNYge0nRqZUK2BXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(366004)(346002)(39860400002)(396003)(136003)(186003)(83380400001)(86362001)(66556008)(316002)(54906003)(66476007)(38100700002)(4326008)(8676002)(6486002)(6916009)(478600001)(33716001)(7416002)(44832011)(9686003)(6512007)(8936002)(82960400001)(6666004)(41300700001)(5660300002)(2906002)(66946007)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?atsbbMsLPmKe54Yakuy6a1Bfptlt/MCKQCv6zYr1BrHZdDsUrtP/iFxRY3l4?=
 =?us-ascii?Q?xedeRdOUF+j0e6H7VXBadjzgiREbjrdO55BCPBaRhqLnnsDlz6ljIjLBTRip?=
 =?us-ascii?Q?5COY7Ah0kkkrwMfgyKJIjfQkyQ1Vx5LqmuDPheeOl4326wQsIVw8x9kT0hK6?=
 =?us-ascii?Q?5WEJAsw5W7zxby/69ttUjUegmmWfj+FdBiJvHLLzsl3zctZXeN9IDa7OYeEx?=
 =?us-ascii?Q?RHobDXuBsnYGxsEQHDtSTSLppSTxUKiwW0wP32hvHVTYOheOKu3+RHzHL1Uv?=
 =?us-ascii?Q?7IhB1VaaS4lYwnSIg6Q0AqlEYkxLAv4s8IDtu3aLjHlMxTSX6neoA/SBiqcM?=
 =?us-ascii?Q?VLnssFPAqw8grB9XQxGitXoiIQf0BL50leU4u0jD97FyMxwoAsE7E75LuAyS?=
 =?us-ascii?Q?B/a7DnbuOJk9VYwpOKKoOB9I5TQ4L69Pe5z/bY/Z9rx37WBlv+FbBxnrztFq?=
 =?us-ascii?Q?y2K2mbXqL7hfV+NBoosEYJ4s9UB7j9O+uyBOARs7Rse+8DQiVrIGH4K9NIRq?=
 =?us-ascii?Q?V2YjdCWB8XgJEzNTwiWdEXZTdh6axneT5iMoOyfvsLgA613XmGH+illVqpRs?=
 =?us-ascii?Q?2qXrTHBISYDywv5Mn2pOvW8m9tn/d1k+n07ugLjxeavtNvKo1lB+Ksohtx2N?=
 =?us-ascii?Q?/G6jc5inejd/VFgxyf+1AR5I3/iiDy7/Ki5NwkeW3D3OI9V8IrQwtoWRIKQm?=
 =?us-ascii?Q?+d6EFmNRZ+tDOW3k1L/1Do0KwD+2Xjcomq8Z7Lcuabcg+iJTri5uZxGEnJqH?=
 =?us-ascii?Q?JFt/x3+aciw6huTi26K3iY+IDseX//iQHiCYle1yXUzkcMOi8LCyDLGrok4i?=
 =?us-ascii?Q?b8OAw9v5gCXD0zzeH86f+RyUib9TbrMKhj7wUQoP3lePQo5/Zu7s8CdGOkfh?=
 =?us-ascii?Q?/0N6BeLD2E06hX0so5x3UWbvipdBaA1TvIL647Xev+O8l3DFD+GCB1/dWFve?=
 =?us-ascii?Q?ooTjw+JOF6wYHgevAg1xjfGGtSnxidgpNxJT4Jrr9lmvk0DJIniZ36927DWr?=
 =?us-ascii?Q?zVkxreM+BFY9siOQRew1yFHNT8V3+HsO5u/GyF4eObCi5tckc2+IhlWFydjK?=
 =?us-ascii?Q?/qsjqMbX5KBejjeY4bvQddBH2F4/d+FZCrItDZk+Uh3YdKxJaabXpMMvafyz?=
 =?us-ascii?Q?4lu64AK/HWkQiOjt/Ew4QSUPvNOBJD51kxeUnutuGKAWEfNiL4ulqIeDl+AK?=
 =?us-ascii?Q?/j61emrDycEw0s8LhT5ZmRAMvYY2PEbT85QgL2iXLmGC56PLCwuKmOxR7T4w?=
 =?us-ascii?Q?Yd01BJFyGQ1ugZkruYdkw1Nk5yeCwFGSEVsOkzu3+RS5hVrc2VsHbJAM82wj?=
 =?us-ascii?Q?3X9CXI5+pcJoPRq070TEKgVYYqVfpLO1DlrcvOJ/DNo7qkhjZVX7rAnl6lQ+?=
 =?us-ascii?Q?VVrO6VwXJlZkiC+U0e18TlFGutv/lisEljf2RKQ46SXU0RVEdBfNiU97cM0T?=
 =?us-ascii?Q?lgkm/cn1aIenzTOpaN5unCU2PBAaDmaSZObFFJPBQIIzAMBLYTaNMxpY+gmt?=
 =?us-ascii?Q?jugtGdOu2+cZ+5/1n2VDNvMlC2F2/925Dwhio1gRVZjYBfARbn/ORvLeoYcs?=
 =?us-ascii?Q?Vu0rvcq3CQ5MfA242JjcDrVPPoV1sggbpeVYRAzkqVkb3JpmVTpa9qMmylgl?=
 =?us-ascii?Q?ILVDf4iDLtUIOqh/Kf/gva/WMLOCrlBj7h4fVUyx0gf6?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 066458ef-8f9a-4a9c-0bfc-08da5b8459ae
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2022 17:08:42.6445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7kZbrmwHggvWfxQf893QD1nbYgIpVZJQEejDe0cwWrHLb/nJwQA1SwGjCRsT4J85zzJjb8lS7g9hfSRiH5ZDKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB4018
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 28, 2022 at 04:46:49PM +0200, Fabio M. De Francesco wrote:
> __kunmap_ {local,atomic}() currently take pointers to void. However, this
> is semantically incorrect, since these functions do not change the memory
> their arguments point to.
> 
> Therefore, make this semantics explicit by modifying the
> __kunmap_{local,atomic}() prototypes to take pointers to const void.
> 
> As a side effect, compilers will likely produce more efficient code.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Suggested-by: David Sterba <dsterba@suse.cz>
> Suggested-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
> 
> This is a resend of the same patch CC'ed to linux-mm.
> 
> v3->v4: Cc Maintainers and mailing lists I had overlooked when I sent v3.
> 
> v2->v3: Fix compilation errors for ARCH=parisc.
>         Reported-by: kernel test robot <lkp@intel.com>
> 
> v1->v2: Change the commit message to clearly explain why these functions
>         should require pointers to const void. The fundamental argument
>         behind the commit message changes is semantic correctness.
>         Obviously, there are no changes to the code.
>         Many thanks to David Sterba and Ira Weiny for suggestions and
>         reviews.
> 
>  arch/parisc/include/asm/cacheflush.h |  6 +++---
>  arch/parisc/kernel/cache.c           |  2 +-
>  include/linux/highmem-internal.h     | 10 +++++-----
>  mm/highmem.c                         |  2 +-
>  4 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/parisc/include/asm/cacheflush.h b/arch/parisc/include/asm/cacheflush.h
> index 8d03b3b26229..0bdee6724132 100644
> --- a/arch/parisc/include/asm/cacheflush.h
> +++ b/arch/parisc/include/asm/cacheflush.h
> @@ -22,7 +22,7 @@ void flush_kernel_icache_range_asm(unsigned long, unsigned long);
>  void flush_user_dcache_range_asm(unsigned long, unsigned long);
>  void flush_kernel_dcache_range_asm(unsigned long, unsigned long);
>  void purge_kernel_dcache_range_asm(unsigned long, unsigned long);
> -void flush_kernel_dcache_page_asm(void *);
> +void flush_kernel_dcache_page_asm(const void *addr);
>  void flush_kernel_icache_page(void *);
>  
>  /* Cache flush operations */
> @@ -31,7 +31,7 @@ void flush_cache_all_local(void);
>  void flush_cache_all(void);
>  void flush_cache_mm(struct mm_struct *mm);
>  
> -void flush_kernel_dcache_page_addr(void *addr);
> +void flush_kernel_dcache_page_addr(const void *addr);
>  
>  #define flush_kernel_dcache_range(start,size) \
>  	flush_kernel_dcache_range_asm((start), (start)+(size));
> @@ -75,7 +75,7 @@ void flush_dcache_page_asm(unsigned long phys_addr, unsigned long vaddr);
>  void flush_anon_page(struct vm_area_struct *vma, struct page *page, unsigned long vmaddr);
>  
>  #define ARCH_HAS_FLUSH_ON_KUNMAP
> -static inline void kunmap_flush_on_unmap(void *addr)
> +static inline void kunmap_flush_on_unmap(const void *addr)
>  {
>  	flush_kernel_dcache_page_addr(addr);
>  }
> diff --git a/arch/parisc/kernel/cache.c b/arch/parisc/kernel/cache.c
> index a9bc578e4c52..993999a65e54 100644
> --- a/arch/parisc/kernel/cache.c
> +++ b/arch/parisc/kernel/cache.c
> @@ -549,7 +549,7 @@ extern void purge_kernel_dcache_page_asm(unsigned long);
>  extern void clear_user_page_asm(void *, unsigned long);
>  extern void copy_user_page_asm(void *, void *, unsigned long);
>  
> -void flush_kernel_dcache_page_addr(void *addr)
> +void flush_kernel_dcache_page_addr(const void *addr)
>  {
>  	unsigned long flags;
>  
> diff --git a/include/linux/highmem-internal.h b/include/linux/highmem-internal.h
> index cddb42ff0473..034b1106d022 100644
> --- a/include/linux/highmem-internal.h
> +++ b/include/linux/highmem-internal.h
> @@ -8,7 +8,7 @@
>  #ifdef CONFIG_KMAP_LOCAL
>  void *__kmap_local_pfn_prot(unsigned long pfn, pgprot_t prot);
>  void *__kmap_local_page_prot(struct page *page, pgprot_t prot);
> -void kunmap_local_indexed(void *vaddr);
> +void kunmap_local_indexed(const void *vaddr);
>  void kmap_local_fork(struct task_struct *tsk);
>  void __kmap_local_sched_out(void);
>  void __kmap_local_sched_in(void);
> @@ -89,7 +89,7 @@ static inline void *kmap_local_pfn(unsigned long pfn)
>  	return __kmap_local_pfn_prot(pfn, kmap_prot);
>  }
>  
> -static inline void __kunmap_local(void *vaddr)
> +static inline void __kunmap_local(const void *vaddr)
>  {
>  	kunmap_local_indexed(vaddr);
>  }
> @@ -121,7 +121,7 @@ static inline void *kmap_atomic_pfn(unsigned long pfn)
>  	return __kmap_local_pfn_prot(pfn, kmap_prot);
>  }
>  
> -static inline void __kunmap_atomic(void *addr)
> +static inline void __kunmap_atomic(const void *addr)
>  {
>  	kunmap_local_indexed(addr);
>  	pagefault_enable();
> @@ -197,7 +197,7 @@ static inline void *kmap_local_pfn(unsigned long pfn)
>  	return kmap_local_page(pfn_to_page(pfn));
>  }
>  
> -static inline void __kunmap_local(void *addr)
> +static inline void __kunmap_local(const void *addr)
>  {
>  #ifdef ARCH_HAS_FLUSH_ON_KUNMAP
>  	kunmap_flush_on_unmap(addr);
> @@ -224,7 +224,7 @@ static inline void *kmap_atomic_pfn(unsigned long pfn)
>  	return kmap_atomic(pfn_to_page(pfn));
>  }
>  
> -static inline void __kunmap_atomic(void *addr)
> +static inline void __kunmap_atomic(const void *addr)
>  {
>  #ifdef ARCH_HAS_FLUSH_ON_KUNMAP
>  	kunmap_flush_on_unmap(addr);
> diff --git a/mm/highmem.c b/mm/highmem.c
> index 1a692997fac4..e32083e4ce0d 100644
> --- a/mm/highmem.c
> +++ b/mm/highmem.c
> @@ -561,7 +561,7 @@ void *__kmap_local_page_prot(struct page *page, pgprot_t prot)
>  }
>  EXPORT_SYMBOL(__kmap_local_page_prot);
>  
> -void kunmap_local_indexed(void *vaddr)
> +void kunmap_local_indexed(const void *vaddr)
>  {
>  	unsigned long addr = (unsigned long) vaddr & PAGE_MASK;
>  	pte_t *kmap_pte;
> -- 
> 2.36.1
> 
> 
