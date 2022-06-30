Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F10E75625FA
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Jul 2022 00:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbiF3WVP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jun 2022 18:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbiF3WVN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jun 2022 18:21:13 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D611A1039;
        Thu, 30 Jun 2022 15:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656627672; x=1688163672;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=kib0vE1g7LZBYZxTPIIc66FkHoJyUZts/650CtJedJI=;
  b=NyJAq71JeFa71UWuSOc/Ty4qQISCGlThbTG1iqwXEqHBM1/VuNihLqxM
   nZyBlh/hRXN43I3n5jY7CRe+JumcWh788DJ4ZjbK6OEcbMtvboLzm1IOI
   EeLkTeTii73znqVfatwABj8HKt15y9mtjJ2ayscwx+QCK9ySLDU2qvuWo
   0yt9eFGR+pSAua14aMUs7XBI8Sc32U/MrjyzzXyGyPnhav+QFomyrYWU3
   uNvFbOYSy2vpH9wgG209KxOCNmJFhlDRQ/m/9dxXE19f0H7ZxBgB83kih
   UGn6G/hKslTDcejFa6a4hofIrHquPW5Jqko1UHHUH7zOYxLWFYEzMhI8l
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="346472874"
X-IronPort-AV: E=Sophos;i="5.92,235,1650956400"; 
   d="scan'208";a="346472874"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 15:21:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,235,1650956400"; 
   d="scan'208";a="595995487"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga007.fm.intel.com with ESMTP; 30 Jun 2022 15:21:11 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 30 Jun 2022 15:21:11 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 30 Jun 2022 15:21:11 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 30 Jun 2022 15:21:11 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 30 Jun 2022 15:21:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GKqvWTsEdauEQTRYoofDBqsIjwDO8Wz7R253sz4PJAUM65jDBb5Q90Ju+ce+v/6qQnq8stLEjDfNg/jYeRccAU68BqfEct+Ojw20s6xnDeA9kS4QWuQEeqVfKoDi7AF1xefP/wxC6XrwiGpOx1cQ8voa7pKsCOg3y9rZN5pX1wEWxukFQe6a1AuLqoTTv2MAZphw8s7L3sTn3wQMh1Dl3M0ACTq17Zfk5ZvlatcsvZ1HMN0pSgfsgsb8+EdYp4Buu9qAi59xPv7y99NWqqqMD32MPrbAlLQmJbz8cPGQEAwVqdXO0kkV54WPl2Ap8U92ea5StwNZYbp5VpFK3daU7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8C9txXgU4Y1Ry/+pZ1b0y+4os3PSHu7Dzj0H3rUoWdw=;
 b=mMmacTtoaZEBlMJddV8VNvUAYzRCOqCqJEW8jquxtqM1lPYYLsZxfLXgsCKA8ohgeaaK6zfOe1lx5Rynkigj1Tyvh8I6HPSthOQ7x+lFYa8p2fs3MdOFaQl0RoQ8jJE05cpuEjrkiUC6hCp5ZzdEQO82HKQWd9JdMUAHnAyhYg7JRJQgpifGLnAEoLLmjJ6CrFkyXs63kX/GiOcQoHM1d625iS48EApf8xtkdPHuY+FCGH+fpH4oEmx6AQ1v+9iSN8HRSsXgSOrQbZJjbEPkqyQv7bVU78dJB4+ndqg2SZtHXPFXswqVv1gtz75arl5pEal9cmbGnm37LHmrFSk/eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 PH0PR11MB5143.namprd11.prod.outlook.com (2603:10b6:510:3f::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.15; Thu, 30 Jun 2022 22:21:08 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::e912:6a38:4502:f207]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::e912:6a38:4502:f207%5]) with mapi id 15.20.5395.014; Thu, 30 Jun 2022
 22:21:08 +0000
Date:   Thu, 30 Jun 2022 15:21:00 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
CC:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Nick Terrell <terrelln@fb.com>,
        Chris Down <chris@chrisdown.name>,
        Filipe Manana <fdmanana@suse.com>, Qu Wenruo <wqu@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Gabriel Niebler <gniebler@suse.com>,
        <linux-btrfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] btrfs: Convert zlib_decompress_bio() to use
 kmap_local_page()
Message-ID: <Yr4hzN+BTeIQ6ruI@iweiny-desk3>
References: <20220618091901.25034-1-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220618091901.25034-1-fmdefrancesco@gmail.com>
X-ClientProxiedBy: SJ0PR13CA0102.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::17) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d9f6029-19d4-4fe6-0319-08da5ae6d45f
X-MS-TrafficTypeDiagnostic: PH0PR11MB5143:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IJ6BV9hXQTfqp70UKGtSIFiR78k0K06HUpp3yqYW8cxUf3jxTF7rF/pFo4bbx/dB/83yKKUAxmQGnTc7usPeo9JxTqApFkhgUPQzMN9vPBlDPtlUQHKmDOaaA6yUkXpqX9BqFKEKaorflfccN2q9amTtWVyujkdndhc1AfUVlEFfiEROYSVfB5s8KKHHTK/22oNtsdKlEXKwwWFlATFSfCB0WaKWYXry11BzEGttpJaJgfDrcSfiRcJif90TE4F2MKzBbMpugiKnrLrY1AlhcbSXjozKLfpnK2p+bnjvlU1rRhRpO4ftkwBWCBjGDdqDe/0FQAqjf21Cy0I9hMAD9G2yUX6W8aewD34iqee3vH0i3A5mJOV/AvtSJCcXzuiwWSOdZTY9WAto+1BFaChr5mC94wiZqHDkwrwCl1jXO+uUbC3pCAALCOjNciD7Ka4eGH6qxmSO8dOPsYt/qgVvF6FGVLT0Sgo9mbto3YAQbXWtQhU7Rr8kuUmbMurM7WceQRxyjhfGEtHzNA/M1AzAsGn5afXpvnryK2ErlwgoYTnjNmGwaHxdNC/D1IgTP1Oqoih/LsWte6OVEtgdw6vg3ZncGy1L19GpT/PihyF7gkx5tRcjqouM5w+pKMqEPJnGcAaOb3JZbXzlKKrluiPIyn5mMaFBktjO/oPUwyXFMT1Ca/ELoYJOulJGklArfxPSS66y7MjyU6UVmILaU93rkfmvqpEVuSPx1FpdMOTQq1PgHXOm7bO0/rs6JdjbQty0tPeoYmzH+F0giDtenixdfGyT2gSYKBfhGSydRxybTz8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(39860400002)(396003)(376002)(136003)(346002)(366004)(82960400001)(33716001)(6512007)(54906003)(5660300002)(9686003)(6916009)(316002)(66556008)(7416002)(6666004)(41300700001)(86362001)(44832011)(6506007)(38100700002)(66946007)(8676002)(4326008)(66476007)(478600001)(186003)(2906002)(6486002)(83380400001)(8936002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c+VxntQCToMmK46WS2eX6XtGbTHNsgNonWEe9Y166tgB7R3bz/20zfUm92IJ?=
 =?us-ascii?Q?8/Nb+agbxxXjxBOZkWJtuXj5/kP40QbkyZN94uVmFZ7JgijyHSMfrHTWEQnM?=
 =?us-ascii?Q?A+1V0/9Mf7cabnp+otgj3Q42rUWR2AmVVtJubPzFeanEqrlWWlRmCZAWZdC5?=
 =?us-ascii?Q?CJTQiZGNxJUA/FtCrY4dSm0LAaegBPg2joeRk0K6irqegHAKmXou3s+WaClL?=
 =?us-ascii?Q?bAs28WpoOSbStgOS4n0dKIeCqPHvU59xrylIdQJ+5q5LqegzfkK30ILD4UNc?=
 =?us-ascii?Q?jYNHKqlyChzXipQr5HsrqQRzDxvCuGifTvNK22+PXVCFRHGreh418uT0fPY2?=
 =?us-ascii?Q?fcC1QoUGTJuR40PKqTQzg8H2caL1gSfVY7T+y5xW3OnRgQVoWGpB2kWr7L52?=
 =?us-ascii?Q?0tGPJcYH+IjMTjywm+Jdbc/mYcoXB1n38AedJhtpXrjh0wexg6kmjCCJSbtg?=
 =?us-ascii?Q?o5Y4smTM1DhGXM0bZqc5eQ3xwKv6JTHdeTAJICoZ9m0pIlB2tR3uv0o8/81r?=
 =?us-ascii?Q?+SvFHvNoUTIUEro5RlygqOP4QARhBiJaMtkJ32TyML1QLtFqWB8yJwCjVIg2?=
 =?us-ascii?Q?JP0PE+PISqHusuBJanVnn8V87+1PgJV5idUIDmQ7P/G6xnE/5sP+R0rS6+dN?=
 =?us-ascii?Q?aNJ++ItwX63eBwL17S5k36hdtVjvY6610w8brOpHzpgsjic6iGccDRrEzLIQ?=
 =?us-ascii?Q?to7b4igI5aBiH3SgM2DLA7gyp9AZojL1kQkRVtJ0kcEAse1HvRx0LJTa4JI5?=
 =?us-ascii?Q?/66D825NEVZY5rk3cRwERMkcs9Wo7KLu+PynnL/XcmDk0BmQJ0/Z9p8QaXNG?=
 =?us-ascii?Q?s6iXO4MFojhX1sHX+jPRSBHFuEsKa63wa9u+OIKebh3lDP6gOEOHP76jxA42?=
 =?us-ascii?Q?ZdQL3Vabmg5ij2PLRNcX60FI1UzSHyEZg1pO31dhc1ZRYu0hSBuX+A1lQZT5?=
 =?us-ascii?Q?9LrfrELDFFenPMGMLD1AX8DMblvFvIZE/aO4Cmb6vDPgWGHUyXmJkRntbEjT?=
 =?us-ascii?Q?U+N2K8NgXTHdiD6oZmTbePRQf+i5kNFQevPyxpgTIpyBFR6uBvgvTtJ4ZhU0?=
 =?us-ascii?Q?VMg/HCtk/xTkW8pTtDRG6vzxmzRnywFlll9Fmn6Mbi5fJq24ozdZuRH7vuGO?=
 =?us-ascii?Q?0uveA5ca8j1atvk6DL6tAwnx5jdhFnijCCv6i5x3chS7qeA5Nn7vqtGVMqyW?=
 =?us-ascii?Q?zjb5g7TyDlLhlJF4+/WYmKLDXBmiq5LaEDIw8khNB7uBuu6JIFXoQPygsXxr?=
 =?us-ascii?Q?G0m/HfLtrflKLom84Ov27ln+65msckB064H6TgI7h2bZhA3e5yK6WJwWT0Ry?=
 =?us-ascii?Q?eqizJhGAICqf6TDKZdI0Vo+tWBejpJDUeuwra61wJvEU+xCl3oJzSqftbf5z?=
 =?us-ascii?Q?W7W80blvtAfNTS6gQuuFi7/bIzVuGoBEJL3RM3WsbLb2Re7QQfUGdObbpiKd?=
 =?us-ascii?Q?UCU4gcNizsKexshgJGEiuK8/SFqFYGfKH8ezk2ghAe5wJNRW3+ND8NB24yjO?=
 =?us-ascii?Q?6Tz4hzKKA9DvOJX9yzivOcp8C/OBOvKZiNJA3D/2gD9jncZhRaUmOSpf9J+A?=
 =?us-ascii?Q?3ZCs1lUwvReyqRei39ti+Ru7zKuwmxAzhhn12vis6MLR3nS3CWrss+OX1SXW?=
 =?us-ascii?Q?8tsPk6wsfdbfWTcdIKdreXkhWMr+EAxrPLd0MxdKZihk?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d9f6029-19d4-4fe6-0319-08da5ae6d45f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 22:21:07.9883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jztU6jiWefZkjlXIeksbBIRqlbRBkX9+9rwtgMALldft+F7S7/opTDHkXLHHrg3KKAsU8PdvFuUFSHjuYzz0Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5143
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

On Sat, Jun 18, 2022 at 11:19:01AM +0200, Fabio M. De Francesco wrote:
> The use of kmap() is being deprecated in favor of kmap_local_page(). With
> kmap_local_page(), the mapping is per thread, CPU local and not globally
> visible.
> 
> Therefore, use kmap_local_page() / kunmap_local() in zlib_decompress_bio()
> because in this function the mappings are per thread and are not visible
> in other contexts.
> 
> Tested with xfstests on QEMU + KVM 32-bits VM with 4GB of RAM and
> HIGHMEM64G enabled. This patch passes 26/26 tests of group "compress".
> 
> Suggested-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> Reviewed-by: Qu Wenruo <wqu@suse.com>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>  fs/btrfs/zlib.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
> index 2cd4f6fb1537..966e17cea981 100644
> --- a/fs/btrfs/zlib.c
> +++ b/fs/btrfs/zlib.c
> @@ -284,7 +284,7 @@ int zlib_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
>  	unsigned long buf_start;
>  	struct page **pages_in = cb->compressed_pages;
>  
> -	data_in = kmap(pages_in[page_in_index]);
> +	data_in = kmap_local_page(pages_in[page_in_index]);
>  	workspace->strm.next_in = data_in;
>  	workspace->strm.avail_in = min_t(size_t, srclen, PAGE_SIZE);
>  	workspace->strm.total_in = 0;
> @@ -306,7 +306,7 @@ int zlib_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
>  
>  	if (Z_OK != zlib_inflateInit2(&workspace->strm, wbits)) {
>  		pr_warn("BTRFS: inflateInit failed\n");
> -		kunmap(pages_in[page_in_index]);
> +		kunmap_local(data_in);
>  		return -EIO;
>  	}
>  	while (workspace->strm.total_in < srclen) {
> @@ -333,13 +333,13 @@ int zlib_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
>  
>  		if (workspace->strm.avail_in == 0) {
>  			unsigned long tmp;
> -			kunmap(pages_in[page_in_index]);
> +			kunmap_local(data_in);
>  			page_in_index++;
>  			if (page_in_index >= total_pages_in) {
>  				data_in = NULL;
>  				break;
>  			}
> -			data_in = kmap(pages_in[page_in_index]);
> +			data_in = kmap_local_page(pages_in[page_in_index]);
>  			workspace->strm.next_in = data_in;
>  			tmp = srclen - workspace->strm.total_in;
>  			workspace->strm.avail_in = min(tmp, PAGE_SIZE);
> @@ -352,7 +352,7 @@ int zlib_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
>  done:
>  	zlib_inflateEnd(&workspace->strm);
>  	if (data_in)
> -		kunmap(pages_in[page_in_index]);
> +		kunmap_local(data_in);
>  	if (!ret)
>  		zero_fill_bio(cb->orig_bio);
>  	return ret;
> -- 
> 2.36.1
> 
