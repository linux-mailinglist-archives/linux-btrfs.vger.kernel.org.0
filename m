Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFB0563886
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Jul 2022 19:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbiGARTU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Jul 2022 13:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbiGARTT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 1 Jul 2022 13:19:19 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09BA52E9F4;
        Fri,  1 Jul 2022 10:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656695958; x=1688231958;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=pbCRCIxWy/9y/zw6zrXCct4fi3bokHPo532JFhUkers=;
  b=DRLfbK3xHGjfSPEKO84XoxPu7YOgrvhNIkeCWGTW5M5wumwiTbXj3aY/
   LXg9GOx94EASLICXHtqhZzNV1/31kwZ4sJ9cbyHAJze39bYjeS9cft36S
   iVDEiCZ5GFf1sREzB5bEWej2SRx8BGqNwvHyIUZHbA30W/+dCTm2pValx
   ZCswPTWYgJa2Li7YPnaGlh2WnaY9dbQ0gVTblOAciUVKrQlZBV5b2l11X
   zZOrdtHg1YXlJK/u8geq6hOc5r3+0Ip9IzSLYonA3FnbEGo5cD8VFL3EC
   jr3620VcuReshuBBIoXI1FJufo4pZLLYTdgjpOA1C9kqoh6OqHTz6/gC+
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10395"; a="281464627"
X-IronPort-AV: E=Sophos;i="5.92,237,1650956400"; 
   d="scan'208";a="281464627"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 10:19:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,237,1650956400"; 
   d="scan'208";a="734128203"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga001.fm.intel.com with ESMTP; 01 Jul 2022 10:19:16 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 1 Jul 2022 10:19:16 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 1 Jul 2022 10:19:16 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 1 Jul 2022 10:19:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A2uFJsm8gmmQVMJnPZdhqrWgp/um6HvqR332nDJ8JtTVcLSDMWfp1v/rNPhH3zCXOFUiD/M9hkk6lIQak89xBJAv4vw3HJu0vhQQfe0kouRVhKFFJduH+sv7xxwOF7OigcZgxGB+DRVmsiECZo9QtiYPUCANZ76DEAWlQboSCOkH9PbWBnAbBaom9DTGjZV7EkmfTtE5Afk4FH5mMEco0Uv+mkW58CI2fyuXw38r9geiYVU1M78h7LTYyIQpGyDvbNwV5Ifx8Q0wBV0Uoc1ByIss4bDxNqLmFkhqOemWKSgWvpFz3v674GpE97bCGv2nxU1853i3l2+gsFGZuOkA/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qSuKk44vZiek7Ine4rtiRiX1UwMb8NdQTX9l0u85jQc=;
 b=EXjnEvu1H7ovFpoAgupbAIeW7cN8Oadi9TiJsJP1bJfsHT8za5OsHtmzbbbd9RNMUL5Mz4+KjBou7+c+kfKEM++W4H6chqWe5fV95QFuH+OvtQkHgHryhr7suxp7dNIfVsYKl4Xhzlw0KWMEWXyrw37GjuDXSm8MjF5kB5DBP9KtzBabL92etrWhruQxhBPKkzc0CCbGu/b1+NzynkqKE8FTJLpFx3GStTGaQZ9FR42bQerprACwBu64bcQS6Ilnuo0L14L99MuP2LE/SOHs4++CoM/grjEJFA6uPi0u03EMUYzvHYQbTBkRK2o033EDjqg+zVehKi2aRxwwamoqdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 MN0PR11MB5986.namprd11.prod.outlook.com (2603:10b6:208:371::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Fri, 1 Jul
 2022 17:19:13 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::e912:6a38:4502:f207]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::e912:6a38:4502:f207%5]) with mapi id 15.20.5395.014; Fri, 1 Jul 2022
 17:19:13 +0000
Date:   Fri, 1 Jul 2022 10:19:06 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
CC:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Nick Terrell <terrelln@fb.com>, <linux-btrfs@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        "Helge Deller" <deller@gmx.de>,
        John David Anglin <dave.anglin@bell.net>,
        <linux-parisc@vger.kernel.org>, Filipe Manana <fdmanana@kernel.org>
Subject: Re: [RESEND PATCH v4 2/2] btrfs: Replace kmap() with
 kmap_local_page() in zstd.c
Message-ID: <Yr8siondUuz08rTZ@iweiny-desk3>
References: <20220616210037.7060-1-fmdefrancesco@gmail.com>
 <20220616210037.7060-3-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220616210037.7060-3-fmdefrancesco@gmail.com>
X-ClientProxiedBy: BYAPR07CA0026.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::39) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a96c92b1-f7b0-4d28-9fbd-08da5b85d1d6
X-MS-TrafficTypeDiagnostic: MN0PR11MB5986:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FkiiDdj52KEivGO76YDyVRwv4LPxCne2lu4MXNX7HmbiD4uV+iVKcsyAg1aPcHIOPqV9F1tfX8/6fFLcDTEF3sspfOS5PgOJ52oSzVxweIO/VAvfAv9qA0u/cm6DLKhLTNI6qvtWvzk8z3szlVU8l/V62DIswIP3ynT846qmfoB7YL9Gq8FESsMGjxCgFkCdUpxTzwPcKUy5laGPquoRyltZoF1HpFiYLS/XC1uGiyifxFSkFzZ8P7Cb4pPpccx4LL1cI7q+H7/MX2tRG1F4VCVuSaDjrLHDnlgSfsbFyG1HUxIlo2J2gEdB9YAh4keXvXlNolfnmJ6WZruE20laZwAwuL8ZR987uP209y0EzmwB/F0fPwDsNOwqdum6tMkcwV+ns1YEneCWaSV5genFrS4qpGL5OlcxCjgOv3z1f9v8L1Hl+e6xOOK+TpWBZchAWV9O+llj1Er3ITcgNS3OG9nFQW7Rx75Vxl+vO958GW86nTCbJOGRmEA9VrhrRw1m7uOMvg/ALECKQ/xlfXmQKLLT514UjibAVOicSVps4T0snqfXbsL0XmNttd2bRvuHJKgivmQCVvhm2FP7DmwvBC+0/+82vzLXShWXUEvqRDnnkGNOwAvXRuGKyzapVX92jupHmkM4zPh34vGyovrAAVAqKTDQ4xMmLENPU6ZhQE6BZJkA8JN2HJ8xFaKOciExybuFdWml9O5J55onPYhbA0QPgtC5CVnZrQSxmSVqWr3Ib4bRdsyrNSB8voIOyndnxjTJkybqXJMqd3sc6ByqtQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(376002)(346002)(39860400002)(136003)(366004)(86362001)(66946007)(44832011)(4326008)(6666004)(7416002)(83380400001)(186003)(41300700001)(6506007)(66556008)(6916009)(54906003)(8936002)(8676002)(478600001)(316002)(966005)(5660300002)(2906002)(6486002)(82960400001)(33716001)(6512007)(38100700002)(9686003)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k0N/oPJe5X8BkSY7LkxwXakZdZ383MXhNrkBeyNRTSRdCwkR8aho0wrfuF0y?=
 =?us-ascii?Q?WYUGsinAMUZlMYbFV+eMB2xFueTz3HqZnkCPt8CtuaRshgi9Lxk6ZQggPUgN?=
 =?us-ascii?Q?i5mANdGG846Flr85c++F1+ExLbKu+DPv6voLLR0CYIKA7O91+riWGcNZqI4r?=
 =?us-ascii?Q?rYU9WzHNcaSgNF7HgBVOKZ1efwLRWDKpDJteDaRTMymEF3b3iGWnencWeLVV?=
 =?us-ascii?Q?nvLIlfrfpo5oTB9gceB5miEOt7xsa5KywkF6N+cztlhae7iGE+5sYpwfflBk?=
 =?us-ascii?Q?2bnpA7tSDlLcvbCRH6qnunlGF24p6z+BLtGwmX8CIe3M55wH4czoWaVpNtB+?=
 =?us-ascii?Q?hQxgNiqejcVYn1DfZ+YYtIuGDrUyE8Hv+Uq4SDPOHvpmY06e6RDSDhN5AB+X?=
 =?us-ascii?Q?yOTcnlX8VwSUxnxqt4h7CsNyYz1NMvKEvlL6Z8AHVmZH+xOYsKcfxWjJ9Rfl?=
 =?us-ascii?Q?b3cg7EAX9FUZX8fxD4vb+SgY9Mrk8SXI4+Ag+yieptaCPHLw8BRKc9Rdvx0Q?=
 =?us-ascii?Q?aC7iZF5cPscZMpbmZZRPaIuG7I3KnQ8MRz1TxE0ooYfPZk5QxlIEVAyq2Nis?=
 =?us-ascii?Q?x3jt4J4hlbyTuA0xr3/Redk+tT5Vbt+WyeuKEcUiMLXqm9qgQ/Jjq+nBT77i?=
 =?us-ascii?Q?Rs6XC6+5IAGa0I+ryFBPmsbsYTLaUtjKaRiUYu0IEkNujBjltrRr8qEuQofY?=
 =?us-ascii?Q?KUZk/FH7UFc0F7FqfacHtRWV0cZo+sWxiDqSpL5EACVdXun+No5oAXZJ+LQM?=
 =?us-ascii?Q?3I85347TYdkYOpaZQyxMOkFrLklSfF2kHSxeB6hpHQ8Jh72k/KU9R6PnpwPa?=
 =?us-ascii?Q?+X3Ut0N3k7ZlRQRyoLok5S36scYrb3oob0vFOpIw+DXCREVQpK/G2iEUelYi?=
 =?us-ascii?Q?S2trE7T9aGpvgerGzoqSbrJQ1n7GZdM13MQceRlJ4I4c47FF+1xhWwxwuEKK?=
 =?us-ascii?Q?j3+iB5KUm2SGzl47bVT5Q1Os9WGAa1zE8TuEMWxZSPPYMuPM0YqmG7GuraGP?=
 =?us-ascii?Q?zKFNUDeDUAgVBcnMmZG8k8i/lKH1pCrpdo9ahwLVO425rvhqgXHgR804zeo3?=
 =?us-ascii?Q?O0FC6BAB5P3Qy522oEZjonnDWnTRqo+LFiOD2LBdTF9cwhIYJRvFNx01FvjK?=
 =?us-ascii?Q?/c7bnY6t4wdwVt7r0fCG/gJIgB1+8wblH1hfsXhUZfAbsThv79xIygyD2mOY?=
 =?us-ascii?Q?mbbe+62ZfWmr5/o8m+x5lbqGRmccK1gZJIdj0NhJWyMz403TbgjLx/ERSxTv?=
 =?us-ascii?Q?mIyLXQucI5ScIiCsfAbmPZvLbcmSDGIvnITBx6uQpquxWif0GpXL1/W4Ofzb?=
 =?us-ascii?Q?H6QPWmIM4XfgoG+sFtJpG/Vjpjg7Cqcfe/UdG8ZCszaXlFcB0g2sxnHz5CF7?=
 =?us-ascii?Q?FRlvtC3hQDCQw1p1o1d5EccT9vA2H1dWkrvyX652yR9M2eqS/yyakYD7nHom?=
 =?us-ascii?Q?4IcUu2mHb+ef2z1bdZvg4d4MRtjdULSVOobeleGrvzNOeoljsiRm4hPRXF9p?=
 =?us-ascii?Q?hYGK3rqfbgJXZJsiVvW7d3roJDJZQGMvcuKtRqmM7cv81Tfm/0hPnxYgyFjh?=
 =?us-ascii?Q?tqThE5oprx/torWVPSAIRCzdqh/KYH1RtKIYNCecLjyPoEI4cuhx7ifF5GPJ?=
 =?us-ascii?Q?JbaeHm52TIcTcPsAC4oBWf441ij/8jMnwAPc8z6B510K?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a96c92b1-f7b0-4d28-9fbd-08da5b85d1d6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2022 17:19:13.7033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BbM3W7bpJpsx9FsRICXaD038A+t9cQKHCK5QCwrbPT+ylOjxKzSNVmCdYmPlK+uMCEQSpqNqxDTWo8ZH3qp3YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB5986
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 16, 2022 at 11:00:36PM +0200, Fabio M. De Francesco wrote:
> The use of kmap() is being deprecated in favor of kmap_local_page(). With
> kmap_local_page(), the mapping is per thread, CPU local and not globally
> visible.
> 
> Therefore, use kmap_local_page() / kunmap_local() in zstd.c because in
> this file the mappings are per thread and are not visible in other
> contexts; meanwhile refactor zstd_compress_pages() to comply with the
> ordering rules about nested local mapping / unmapping.
> 
> Tested with xfstests on QEMU + KVM 32 bits VM with 4GB of RAM and
> HIGHMEM64G enabled. These changes passed all the tests of the group
> "compress".
> 
> Cc: Filipe Manana <fdmanana@kernel.org>
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
> 
> v3->v4: Cc Maintainers and lists that had been overlooked when v3 was
>         sent (mostly regarding patch 1/2).
> 
> v2->v3: Remove unnecessary casts to arguments of kunmap_local() now that
>         this API can take pointers to const void.
> 
> v1->v2: No changes.
> 
> Thanks to Ira Weiny for his invaluable help and persevering support.
> Thanks also to Filipe Manana for identifying a fundamental detail I had
> overlooked in RFC:
> https://lore.kernel.org/lkml/20220611093411.GA3779054@falcondesktop/
> 
>  fs/btrfs/zstd.c | 42 +++++++++++++++++++++++-------------------
>  1 file changed, 23 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
> index 0fe31a6f6e68..5d2ab0bac9d2 100644
> --- a/fs/btrfs/zstd.c
> +++ b/fs/btrfs/zstd.c
> @@ -391,6 +391,8 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
>  	*out_pages = 0;
>  	*total_out = 0;
>  	*total_in = 0;
> +	workspace->in_buf.src = NULL;
> +	workspace->out_buf.dst = NULL;

I don't think either of these are needed as they are both set straight away
below.

>  
>  	/* Initialize the stream */
>  	stream = zstd_init_cstream(&params, len, workspace->mem,
> @@ -403,7 +405,7 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
>  
>  	/* map in the first page of input data */
>  	in_page = find_get_page(mapping, start >> PAGE_SHIFT);
> -	workspace->in_buf.src = kmap(in_page);
> +	workspace->in_buf.src = kmap_local_page(in_page);
>  	workspace->in_buf.pos = 0;
>  	workspace->in_buf.size = min_t(size_t, len, PAGE_SIZE);
>  
> @@ -415,7 +417,7 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
>  		goto out;
>  	}
>  	pages[nr_pages++] = out_page;
> -	workspace->out_buf.dst = kmap(out_page);
> +	workspace->out_buf.dst = kmap_local_page(out_page);

Given the conversation in the other thread for zlib_compress_pages(); I think
we should also just use page_address() here.  That simplifies the algorithm
immensely.

I know there was a lot of thought put into how to make this conversion when
this was posted but that is now the cleaner solution.

Ira

>  	workspace->out_buf.pos = 0;
>  	workspace->out_buf.size = min_t(size_t, max_out, PAGE_SIZE);
>  
> @@ -450,9 +452,9 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
>  		if (workspace->out_buf.pos == workspace->out_buf.size) {
>  			tot_out += PAGE_SIZE;
>  			max_out -= PAGE_SIZE;
> -			kunmap(out_page);
> +			kunmap_local(workspace->out_buf.dst);
>  			if (nr_pages == nr_dest_pages) {
> -				out_page = NULL;
> +				workspace->out_buf.dst = NULL;
>  				ret = -E2BIG;
>  				goto out;
>  			}
> @@ -462,7 +464,7 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
>  				goto out;
>  			}
>  			pages[nr_pages++] = out_page;
> -			workspace->out_buf.dst = kmap(out_page);
> +			workspace->out_buf.dst = kmap_local_page(out_page);
>  			workspace->out_buf.pos = 0;
>  			workspace->out_buf.size = min_t(size_t, max_out,
>  							PAGE_SIZE);
> @@ -477,15 +479,16 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
>  		/* Check if we need more input */
>  		if (workspace->in_buf.pos == workspace->in_buf.size) {
>  			tot_in += PAGE_SIZE;
> -			kunmap(in_page);
> +			kunmap_local(workspace->out_buf.dst);
> +			kunmap_local(workspace->in_buf.src);
>  			put_page(in_page);
> -
>  			start += PAGE_SIZE;
>  			len -= PAGE_SIZE;
>  			in_page = find_get_page(mapping, start >> PAGE_SHIFT);
> -			workspace->in_buf.src = kmap(in_page);
> +			workspace->in_buf.src = kmap_local_page(in_page);
>  			workspace->in_buf.pos = 0;
>  			workspace->in_buf.size = min_t(size_t, len, PAGE_SIZE);
> +			workspace->out_buf.dst = kmap_local_page(out_page);
>  		}
>  	}
>  	while (1) {
> @@ -510,9 +513,9 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
>  
>  		tot_out += PAGE_SIZE;
>  		max_out -= PAGE_SIZE;
> -		kunmap(out_page);
> +		kunmap_local(workspace->out_buf.dst);
>  		if (nr_pages == nr_dest_pages) {
> -			out_page = NULL;
> +			workspace->out_buf.dst = NULL;
>  			ret = -E2BIG;
>  			goto out;
>  		}
> @@ -522,7 +525,7 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
>  			goto out;
>  		}
>  		pages[nr_pages++] = out_page;
> -		workspace->out_buf.dst = kmap(out_page);
> +		workspace->out_buf.dst = kmap_local_page(out_page);
>  		workspace->out_buf.pos = 0;
>  		workspace->out_buf.size = min_t(size_t, max_out, PAGE_SIZE);
>  	}
> @@ -538,12 +541,12 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
>  out:
>  	*out_pages = nr_pages;
>  	/* Cleanup */
> -	if (in_page) {
> -		kunmap(in_page);
> +	if (workspace->out_buf.dst)
> +		kunmap_local(workspace->out_buf.dst);
> +	if (workspace->in_buf.src) {
> +		kunmap_local(workspace->in_buf.src);
>  		put_page(in_page);
>  	}
> -	if (out_page)
> -		kunmap(out_page);
>  	return ret;
>  }
>  
> @@ -567,7 +570,7 @@ int zstd_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
>  		goto done;
>  	}
>  
> -	workspace->in_buf.src = kmap(pages_in[page_in_index]);
> +	workspace->in_buf.src = kmap_local_page(pages_in[page_in_index]);
>  	workspace->in_buf.pos = 0;
>  	workspace->in_buf.size = min_t(size_t, srclen, PAGE_SIZE);
>  
> @@ -603,14 +606,15 @@ int zstd_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
>  			break;
>  
>  		if (workspace->in_buf.pos == workspace->in_buf.size) {
> -			kunmap(pages_in[page_in_index++]);
> +			kunmap_local(workspace->in_buf.src);
> +			page_in_index++;
>  			if (page_in_index >= total_pages_in) {
>  				workspace->in_buf.src = NULL;
>  				ret = -EIO;
>  				goto done;
>  			}
>  			srclen -= PAGE_SIZE;
> -			workspace->in_buf.src = kmap(pages_in[page_in_index]);
> +			workspace->in_buf.src = kmap_local_page(pages_in[page_in_index]);
>  			workspace->in_buf.pos = 0;
>  			workspace->in_buf.size = min_t(size_t, srclen, PAGE_SIZE);
>  		}
> @@ -619,7 +623,7 @@ int zstd_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
>  	zero_fill_bio(cb->orig_bio);
>  done:
>  	if (workspace->in_buf.src)
> -		kunmap(pages_in[page_in_index]);
> +		kunmap_local(workspace->in_buf.src);
>  	return ret;
>  }
>  
> -- 
> 2.36.1
> 
