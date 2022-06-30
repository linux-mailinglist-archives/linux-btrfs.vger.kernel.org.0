Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0590B561FA0
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jun 2022 17:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236176AbiF3PqX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jun 2022 11:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236135AbiF3PqP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jun 2022 11:46:15 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7915641622;
        Thu, 30 Jun 2022 08:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656603974; x=1688139974;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=BYD0m8Q7VGnekIH34WgiE8P9jp0zzduGzzm3SNOz0Jc=;
  b=KbGSoYo5KZ8cIG/4WQVL530KgoHzoJdFG6QDVyyTGE2s42d8Vk5QwLpB
   x0XmR7FYlDoD9WoL4mXHM8BD3X0F5Juv/ZBQVOYxAsDkRl8WWLa1Z+0Vs
   hrqh4clm6YddjOPR0bL7lR/KH1LrmPJbLAHEFBHi5s1gMipN5/Qhke8X0
   D1bB2mzYwvCs2xfiG+uZ7rDdHyCixsEXlJmjpuCsmczCxtpkB9gOljov2
   BrGgA0gnZubJuA9o8/IHz6+CFrUl/E08D+q6DsJji/Te6CbFw0EdsAr9f
   01klQQjve0hnGtAWwZl693XZ31AF8eiD+/437pGML+NEkEHefx0WS7p7U
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="262182502"
X-IronPort-AV: E=Sophos;i="5.92,234,1650956400"; 
   d="scan'208";a="262182502"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 08:46:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,234,1650956400"; 
   d="scan'208";a="588804970"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga007.jf.intel.com with ESMTP; 30 Jun 2022 08:46:13 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 30 Jun 2022 08:46:12 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 30 Jun 2022 08:46:12 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 30 Jun 2022 08:46:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V6pGulpUtnHUpz2q2IGPd4ZguxdI/Q8y8NGLnrQu3IpW3Ke+NL3eBuIgF55UOOHPWT/cW9K8U0f56X5J+hrigpfPr39S9YbL/s7XXRnonfaoYkd+BdW/DNLL6ipgHl3c8q/hartz7CT4O9b60v6dwi/iPRwk1TUDGinwmF58c3L8i3iU+X63LFqNmloi1088fk5lYuUD4+bT6z8r457MQZd78mQ2GrjPrt4fG5tpAijtywtdLRKSHHt9FjVb4utFVU7gBnYs+gdH5zfjquhRyZNPKzn93mfcz1G/6mnKdB001OkldCXkSMwVTQDm1l/ieGesmn2AEXBXE1NthgXxAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KA8mXYJ85hvdz/3X8ovCK8PViYASgibvs6AJDnugcgE=;
 b=U+ro5ghx/cVgRKDe8n3cTGazOHCd/PULmdA8k8gIx0QNMpRu3dGRXW9b/6ztbozqEAjKLlodqLfanvLARwGEof+jJ+Ts0AJHnKkbsUeLldFsq7IXF7gPsp4f/LzhsEts/6CE5Ln5P63EdqKTMzlmWnDTYLY96HXPkAAvIbsu1NFWoUfa6044CCIYw4SBNkzX5KPSY8wBHQOWVJBw0YzdPRagoTq15/cVFNOVRShbW+jMzjI8Yc3iYSSUmiUlx70woLkV8twFy7HT3JsoE8jvAx3csrHpbAccg38COZcBtwKBNZ8xIzCr0ynIL3w4FaRzBQOYx/Cl7z4Nd2q9IDrOww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 DM6PR11MB2778.namprd11.prod.outlook.com (2603:10b6:5:c0::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.14; Thu, 30 Jun 2022 15:46:10 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::e912:6a38:4502:f207]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::e912:6a38:4502:f207%5]) with mapi id 15.20.5395.014; Thu, 30 Jun 2022
 15:46:10 +0000
Date:   Thu, 30 Jun 2022 08:46:03 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
CC:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Nick Terrell <terrelln@fb.com>,
        Chris Down <chris@chrisdown.name>, Qu Wenruo <wqu@suse.com>,
        Filipe Manana <fdmanana@suse.com>,
        Gabriel Niebler <gniebler@suse.com>,
        <linux-btrfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH] btrfs: Replace kmap_atomic() with kmap_local_page()
Message-ID: <Yr3FO7IZT79QEh6s@iweiny-desk3>
References: <20220627174849.29962-1-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220627174849.29962-1-fmdefrancesco@gmail.com>
X-ClientProxiedBy: PH0PR07CA0042.namprd07.prod.outlook.com
 (2603:10b6:510:e::17) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 787d6763-57f5-4bac-801c-08da5aafa788
X-MS-TrafficTypeDiagnostic: DM6PR11MB2778:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Txnrt6Hd3S5iGpqdpnLYORJ0Sumlz1jJar20pSJLeZ7WIwfqiJYBBkvfNfyvb8oygjOEi9179Rvq2sExaslZuM3grrbyIvpjBFUz1gr2r1iyffZREYzMdIcOqcHDhE4ruI92ydju1QBkNZlR5EQwVYYCSDrp/dz2egEQkJpgtvzPlszc+CU+HJJxG+rYaYMjWCHfj0+qcUYTphVoq8jEHWRu3DAG7anlqM8Vz3xGcRaXcyDleVZsPCHQjOjShfLUkSwcffFbHzL+j1IqTSTDjXKt4xWkk2rXR/c0+mk3Wl6JeucK4hBo6KoNNA+mk670iHb3JBWZnmNwl9TqWiWzmNAA/rNDbhLY5Qu6wfAj327aGRnMTuq59fwwR9vh1/1NIxfT+ygktSTr8SWalPLb5dBrOlTViNdZVqtHIiICB+9OlEbYvOSn0MsfnAxgkoLcZdBjMwmB6kKFsXtRplX8WJXrW6N56sL9zOVBY1klghFq7ZY3pA+R2GTyx9MsrzZq3bquHN/meOLIrKaCo8gYtbAquN5N+P/vWljBKzqxhfT2UnDolG77muoiuYqNyhLuotKkr97GJHlfs6CW5watdYakDvItIn24VMJlA5odX+AKFiX//ow2xmSxgosBwflcLlPqcgUVhSUIQnrSXRJ34NvneUSzZFqhqVckJFtQ5fYQ6hmePzq6FLTsXid8ig0s0Hisf9WyVSWPvt/+r66eBrqZAUj6iV/68fpbZ+sqLDHGDZQd0Li4jyz2QbRJpRt/2n+B9TCAHOGcp1vKOCVx0LgKYm6Zk68pqBzY2r1mZACEkt8uq3fqCBjRkujMgqfjg7AUZJ4eulXXd2lV8jdKjw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(366004)(136003)(376002)(39860400002)(346002)(66476007)(8936002)(6486002)(7416002)(5660300002)(2906002)(4326008)(6916009)(66946007)(8676002)(66556008)(478600001)(316002)(966005)(54906003)(44832011)(33716001)(38100700002)(6666004)(186003)(6506007)(9686003)(6512007)(86362001)(41300700001)(83380400001)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1DBUKj7ud3c3gNgt9y2AeNcU1tg2CHog1Lv1Mw1b/5Sqcuh2QZQZb0kcLkG2?=
 =?us-ascii?Q?woy2pogXyr5C42F+CAg6UlB/xQvv8NLwZ6lcgvh/rbz/HXepZBbXOf7OGqbE?=
 =?us-ascii?Q?Hjb5RI03VELKII5SRzKtjDOXMlQ+xn3lW++qjzuOirCdl5PA5lSsf3KqY6To?=
 =?us-ascii?Q?aEPtSlC/TrlKAer/xYoO0gJT9MGsOVYnfgw6bCcfU0K4Lou0GtmJwQ7gk7iT?=
 =?us-ascii?Q?aV5YapHIwLAULRhpaBmi2GbkXNlY4ltuUM+ZqaV6uXFdKzoNB+FBibMUyjna?=
 =?us-ascii?Q?HB86sncoEZDdp0CRkaRbT6spoQW6rWbYsnasHFxNNZDGjkV5Af0YDcA4ykht?=
 =?us-ascii?Q?kz8SFg1odeGURXGOZ4Kfapb/b+RQbMznu8f70xumEUzjxtlh8CBRUr14UdZp?=
 =?us-ascii?Q?+z5lT5AmlmOrqp2EmSMCzMAqZgwbsx5yImdxeLqObumtQTUVup53oBAcWgTz?=
 =?us-ascii?Q?rqUZ+26olrQ+bqHnWP18gxRDWuzyACFVJ9x3cCP5wiO64P8JrVWMmd0ZqA4w?=
 =?us-ascii?Q?iuCgskFStEhUoEtKOla4FueJ0J2khkYwDcvpdjNFCMjDI+uc0Rcb4cV2xX03?=
 =?us-ascii?Q?eXsfGQGKgJEUPQGAmdov2/QxRhtxlz6f1i08zxWvzVuxqk1sA+L+sVZacyht?=
 =?us-ascii?Q?m23whb01pcsQnqWJ3ZuVZqxmWTBbk1IR2ZmP39NXwP2tgFaxlCvejCBKAska?=
 =?us-ascii?Q?NARIIu535VELiAW9BMZKVOcXVz8xnQAkj2tIgLyzjBb1nHzaQbyeV5zNtskw?=
 =?us-ascii?Q?PsTA4Gzql0cysPBYYxGh7mbAxhGJwgerD7KT5nPXqBKoX93XWHz/k3ePfrDI?=
 =?us-ascii?Q?aiyOCGR/7YWixVEULqQiWG2vAinI1wwGuOY+lVe2SnsddR8Nkn61e/FWOshK?=
 =?us-ascii?Q?FT8NOfu7ZhXGoXkMhNsML07A6J4qW1wsi+aMZki3X86sUZVw/4GooDTYiYYk?=
 =?us-ascii?Q?VmKKBq2iK5rI0Poq1ESiyGo4b1KDM5NfE6oCBo29RwaBtThPotuoUPvwUMhU?=
 =?us-ascii?Q?Q2huiGxeV1dIHFsgLreohU/h2phJ9aheiCyj9edoeS80ycdJAdBPlzUYQk89?=
 =?us-ascii?Q?kLYepDaoRx74yuXPEznpg1+XOdrkkBM3HW88T7KwRuYdmrKcYE1qaKQFb72x?=
 =?us-ascii?Q?PgGEjZgmVqfy+SqHZhnxThSJ1FJUR5tC1OAOuFNGURSSETi2f699P+JTrD/O?=
 =?us-ascii?Q?Oz2PjtFEiFlQYV3FtkgAV3a+g+yk2aSv9jHD9Z02Vs4Jk3zjcn7RE8FD9K7w?=
 =?us-ascii?Q?xeMZYoSW7g8BgoXjFvicAyhmWHfd7YFJjv4RmbmgMt26CEFyOK2TuSaCZG0P?=
 =?us-ascii?Q?mNX/X7tegDWLvkp6u+Wy+1oNgn3nXHzLdrXT2WoZ7hwaDoLcvUSXkSu4rQEY?=
 =?us-ascii?Q?U6T/BgM+KB9JYVVLWVi/Vcw6qe7VkAIDOQUICPWQjlSkRUNqERY1zJmUBjMa?=
 =?us-ascii?Q?xlpNNN3Gi7/re3ktlhfw7nQ/UB874wpoJSPHXRI1jXWDZ56Tm1b+tmX9jfCj?=
 =?us-ascii?Q?BOWJ9GDK5CFXqhds9cF8dsVP/OEzPw2C3Fda46kNqsG2v0eWJ3FXUVxBcZgY?=
 =?us-ascii?Q?vfewMVDj8xDSR5OCmGspxs2qvCzQEzE6ztwFvgdUSE16pzo8yIPoYnQhVP+1?=
 =?us-ascii?Q?9shTET+4T3IgaIhKgBnXfRFve5GXAKtQAFGUVlQMVM8r?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 787d6763-57f5-4bac-801c-08da5aafa788
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 15:46:10.4269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PDkQSNTJru1D/yxO2iHn8iKuZlesJkGzwlzUgT0bkIPfUEzTqBOc0rDEY5gRcu3FQ5f/D9JudK7qVLfbMg9TbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2778
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 27, 2022 at 07:48:49PM +0200, Fabio M. De Francesco wrote:
> kmap_atomic() is being deprecated in favor of kmap_local_page() where it
> is feasible. With kmap_local_page() mappings are per thread, CPU local,
> and not globally visible.
> 
> As far as I can see, the kmap_atomic() calls in compression.c and in
> inode.c can be safely converted.
> 
> Above all else, David Sterba has confirmed that "The context in
> check_compressed_csum is atomic [...]" and that "kmap_atomic() in inode.c
> [...] also can be replaced by kmap_local_page().".[1]
> 
> Therefore, convert all kmap_atomic() calls currently still left in fs/btrfs
> to kmap_local_page().
> 
> Tested with xfstests on a QEMU + KVM 32-bits VM with 4GB RAM and booting a
> kernel with HIGHMEM64GB enabled.
> 
> [1] https://lore.kernel.org/linux-btrfs/20220601132545.GM20
> 633@twin.jikos.cz/
> 
> Suggested-by: Ira Weiny <ira.weiny@intel.com>

Test failures aside this looks ok to me.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> Suggested-by: David Sterba <dsterba@suse.cz>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
> 
> Tests of groups "quick" and "compress" output several errors largely due
> to memory leaks and shift-out-of-bounds. However, these errors are exactly
> the same which are output without this and other conversions of mine to use
> kmap_local_page(). Therefore, it looks like these changes don't introduce
> regressions.
> 
> The previous RFC PATCH can be ignored:
> https://lore.kernel.org/lkml/20220624084215.7287-1-fmdefrancesco@gmail.com/
> 
> With this patch, in fs/btrfs there are no longer call sites of kmap() and
> kmap_atomic().
> 
>  fs/btrfs/compression.c |  4 ++--
>  fs/btrfs/inode.c       | 12 ++++++------
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index f4564f32f6d9..b49719ae45b4 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -175,10 +175,10 @@ static int check_compressed_csum(struct btrfs_inode *inode, struct bio *bio,
>  		/* Hash through the page sector by sector */
>  		for (pg_offset = 0; pg_offset < bytes_left;
>  		     pg_offset += sectorsize) {
> -			kaddr = kmap_atomic(page);
> +			kaddr = kmap_local_page(page);
>  			crypto_shash_digest(shash, kaddr + pg_offset,
>  					    sectorsize, csum);
> -			kunmap_atomic(kaddr);
> +			kunmap_local(kaddr);
>  
>  			if (memcmp(&csum, cb_sum, csum_size) != 0) {
>  				btrfs_print_data_csum_error(inode, disk_start,
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index e921d6c432ac..0a7a621710f6 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -332,9 +332,9 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
>  			cur_size = min_t(unsigned long, compressed_size,
>  				       PAGE_SIZE);
>  
> -			kaddr = kmap_atomic(cpage);
> +			kaddr = kmap_local_page(cpage);
>  			write_extent_buffer(leaf, kaddr, ptr, cur_size);
> -			kunmap_atomic(kaddr);
> +			kunmap_local(kaddr);
>  
>  			i++;
>  			ptr += cur_size;
> @@ -345,9 +345,9 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
>  	} else {
>  		page = find_get_page(inode->vfs_inode.i_mapping, 0);
>  		btrfs_set_file_extent_compression(leaf, ei, 0);
> -		kaddr = kmap_atomic(page);
> +		kaddr = kmap_local_page(page);
>  		write_extent_buffer(leaf, kaddr, ptr, size);
> -		kunmap_atomic(kaddr);
> +		kunmap_local(kaddr);
>  		put_page(page);
>  	}
>  	btrfs_mark_buffer_dirty(leaf);
> @@ -3357,11 +3357,11 @@ static int check_data_csum(struct inode *inode, struct btrfs_bio *bbio,
>  	offset_sectors = bio_offset >> fs_info->sectorsize_bits;
>  	csum_expected = ((u8 *)bbio->csum) + offset_sectors * csum_size;
>  
> -	kaddr = kmap_atomic(page);
> +	kaddr = kmap_local_page(page);
>  	shash->tfm = fs_info->csum_shash;
>  
>  	crypto_shash_digest(shash, kaddr + pgoff, len, csum);
> -	kunmap_atomic(kaddr);
> +	kunmap_local(kaddr);
>  
>  	if (memcmp(csum, csum_expected, csum_size))
>  		goto zeroit;
> -- 
> 2.36.1
> 
