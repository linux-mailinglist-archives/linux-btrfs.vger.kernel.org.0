Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 493BA567732
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Jul 2022 21:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233202AbiGETE0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Jul 2022 15:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233257AbiGETEV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Jul 2022 15:04:21 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88602205ED;
        Tue,  5 Jul 2022 12:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657047857; x=1688583857;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=mjo1/ew7nxbp20PGLblTtRiaLY4/mTKsBpljTqbTx/4=;
  b=LJCmVgwVYv6emcSaIqyTY6akc27gsZ5y6PnoXfunRAKmHrIrjyUvHD+l
   QLlnjSeDZmEB5mY+wYacCV1V4mNqoHuZhHFKoXMhNvtPW5S7dCCbIGVGB
   wxYYEEFA/iQ49IkN8hOS4M5+b0cluK2xlYK8Xnr5ZzoTtQwbHyhr/Aaew
   Nk0kdb9M+cRfhnuovP7atzIv8ExaGVW03z5lQ0vLse0HIBci6S/ENm+Kh
   FrR60xYiNdWofFiSC2/odecbyvhHqxvUqk1luHBFQr3hDvoU1qk4i5bdM
   Jsf5yVyLJBSttSQqp0RDtYq4AvUnhUOSWgl+B3eoGgggaPpITlAhDs51h
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="281005542"
X-IronPort-AV: E=Sophos;i="5.92,247,1650956400"; 
   d="scan'208";a="281005542"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 12:04:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,247,1650956400"; 
   d="scan'208";a="735270759"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP; 05 Jul 2022 12:04:16 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 5 Jul 2022 12:04:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 5 Jul 2022 12:04:15 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 5 Jul 2022 12:04:15 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 5 Jul 2022 12:04:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U0UAw24N0GXsim1eXwUubupcplJZ+Bq9jElb1rI3mUVWgCMy5ZU8FKZxcdC8g1Ix1PujcqI6Y2BcHlEPCYshtXLyDbVaYI+yD3SMEMnhp/n00eKrkjj3bE5yc36EwsbXCofHI4hZa31RMRWv67AuevaUD71XyCwzsVJ2HSUHk5Rq44dpn8oON0qrdojoBf59INzDCEyYJjI3V5UkhTM4WVITcViJ5AAr5oSr0vGtK/XSL9GsRTXKlSMWOohVsh0JQVw5TdHkewZIELmJa8Xv90AMNp3SEj6CXSAX/8Ha+FJBTH1wgwCx+/biGkYvKf7jpABXBYHYRsjPE6xIHXCIIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=akeq6SrkNZq5noULCf3QJ/dTBobWssMrS2COyyjQnEo=;
 b=D0u1VKMZkHrfA3zAVurOLoMihoL+DaxEpM9snBVGMlAzS8GfyZoWAH4i3XQWOoBNr0rKJkpRF/94SGpw34Aj+pFgKy5/f4cArjAfRYyoCYtrp6R2MFtpiNZSXrESqIQ+3iia1MNESZzQDqduQnwZO2In1bANl0kaC1sdUkD2YwC/ojn35wtRthdbWi4b8i3JPsBtq4OgcpwIJWEVGGW74u4G8yh1efpFrQTm56FSi1x1ywwHc8VxeIR+xXiaMTWbzWrhNb3ZHn+2i+cQeQ3npOp1gEIqy19DE8CGNeYwp/041Yw9/2P0YWbekAaRIqRDQgk1u5xnx+soW3di9u3tCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 DM8PR11MB5736.namprd11.prod.outlook.com (2603:10b6:8:11::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.15; Tue, 5 Jul 2022 19:04:12 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::f188:57e2:349e:51da]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::f188:57e2:349e:51da%7]) with mapi id 15.20.5395.021; Tue, 5 Jul 2022
 19:04:12 +0000
Date:   Tue, 5 Jul 2022 12:04:04 -0700
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
        <linux-parisc@vger.kernel.org>,
        "Filipe Manana" <fdmanana@kernel.org>
Subject: Re: [PATCH v5 2/2] btrfs: Replace kmap() with kmap_local_page() in
 zstd.c
Message-ID: <YsSLJBzwB5bCyuNR@iweiny-desk3>
References: <20220704152322.20955-1-fmdefrancesco@gmail.com>
 <20220704152322.20955-3-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220704152322.20955-3-fmdefrancesco@gmail.com>
X-ClientProxiedBy: BYAPR05CA0017.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::30) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d574cba3-752b-479f-15a9-08da5eb9256c
X-MS-TrafficTypeDiagnostic: DM8PR11MB5736:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WPqXyWK8TJAaWIb+K7zToQr/HwzDaU3ADMgIQbJHYztbLZGow3OoDe6X0XUSdCF/XR6uXDp54d2AtWcl51Kd/hrrB7ykpkFg0xNwmWsy/N70D+izVI5AAx6KPLAIteBFAB5BJ4ZRuKw4NRYzELcmOmf0XUI48utyrDMEAN2T4wUiadHM62iPJ9RnO8Pxh8RcnWfbk4YiK6IpIazH8kTzonqAvc5Yc5KvyL7p6npAHY3zzgQNkbeZb/n1ZetoURyOlPgnc2dv5l94mT7pBrk5tVf0cKXOKgj/4O377A/ROJlYLIZ1Xu1vDQXBRqQ+da4GRzy8ZybAMYfE3+G3jcphRiK2iCd/cltf9BqPPb/a6A1bysPZXYbMH0c3fzosBSMIOkczj0P4FydqyXd/54qxasy+KLYf7HmC2GPbWcDT7MkmCR4jKll557GILCgDUVHuRcDl9HXLvqxEOdBxCzP6+q+kLROqhdIxKQb4Dc9gXOanEmXe6JJsz7AuFvAiLswJTm+x5ELVU2oQ4p1TuNe3oVxOXfOHth/UOkv3Xbrh1ng2eeAJe4t/fv3D8iK7jGdmZcpxqyaML0pBynnU1DO7SFbxAjbbPQ4SXLvgYki6k20kZkt3W+pBYg57ktSUL/IDyuNSboHDqCXEwRnpGPm7nZPx1tRiUGKYNEy7XulWlBbUBsbbwUq2kDX93uji4NnIberBsOGHcTtbfdsPCx82qgs59ODUVXK4hNp01hsl8adODiy4L5ubel5QQ4VzYHD1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(396003)(366004)(39860400002)(376002)(136003)(478600001)(6486002)(38100700002)(186003)(6506007)(41300700001)(6666004)(2906002)(316002)(54906003)(82960400001)(8936002)(7416002)(44832011)(5660300002)(86362001)(6916009)(9686003)(6512007)(83380400001)(66946007)(66476007)(66556008)(33716001)(4326008)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gzRDVE1CgP/06jEg1IjizIKWQspU5zycxdWXj3e9gHlqSKcDIRUxL1WET+6v?=
 =?us-ascii?Q?a75hGLvFJo2Puk2VcjuI628lOtYI/T+P9k3vZRFykgaMP1tVtgXp4QuZCx4h?=
 =?us-ascii?Q?RVSz6qdvFxJqRh9guaPaW3VzbfyS9NLGGDoeM+bkcH8vBvOZ2tVTeeqKlPIi?=
 =?us-ascii?Q?KL7ATYEBbPUGFaMBUIb6Amp7/ZJgIjF+b7ikae/EZ6ASmFWZEpyaJAHBB+dt?=
 =?us-ascii?Q?5VM7l9UEYWF03drdeAZK3QoS+v+vTNFIGS3PVYz1gdhHuFR28mZOf8XbMH9T?=
 =?us-ascii?Q?OdOHrc1IKm3wkAHqDdTgWWx/TyXaFRgYcF0PHCIoI8pJiNhIFwAPkwtGxwQ4?=
 =?us-ascii?Q?cxnc6grVgXxoiCUXwBr3oacnm4D6iK1Aziwl8HHc77JrobCXzzdLpkxcoWrI?=
 =?us-ascii?Q?xWzT44IFVRvOIyLwIhA0haTsgToBRmI0oWMob3cdUgM0rfIS52XYY6OW80EH?=
 =?us-ascii?Q?fyr3N0rPdEX/TPNEqNHQKh7rt8NPgytpdPI8dsr3rDGKqD8oHXP0kTfh8SLA?=
 =?us-ascii?Q?qcqxAUo1uG4RSBh+8iEHiGpBKI+vk1obvltBws0OcH/giiwzzoSGzj/nANFW?=
 =?us-ascii?Q?4PVoQkYL5nYVgUc9AmlF/qJ+GCNWFF0rgyDXk9XEqyXY67RWwXJpnlccHBV1?=
 =?us-ascii?Q?QkGW6rKenHl6AVx6wH3+d/qEGXcQrGRle4ODr326yqo4muj/cQAT5c6RdaZV?=
 =?us-ascii?Q?Gjmg3m4G5U7UcGmilLwEYqHjnzZhDdOaRFk2kv0oiVk7pVbgJp0jFd1XlNhk?=
 =?us-ascii?Q?BYv8xIZ+4yIqwjGIqlTLYfsD68A9DnN8ciOEQe+qzfo5ySqDNLgyi7FbEXy5?=
 =?us-ascii?Q?ObP+OBGs50dWwhcIZekRtkpQUesJf1nKAR9DIvJ7xWZQ5a/uvHNwiYiMYGId?=
 =?us-ascii?Q?ABJq56p05yWP40/kErOi2jJ3Cy02RyGK6XyiztsJgOOnC48SvjnjKkt6ACUm?=
 =?us-ascii?Q?/m632IhAgfUmAJ97Qj2U+tQZks2ORH3hQ0NuApqor7AnY2uoIFAQhEkTOW0v?=
 =?us-ascii?Q?NeF6792x0lrXf8F19HE03Gc93SGGzUYLHCgDRppuXMN4phzTkeKbWHu+kxld?=
 =?us-ascii?Q?qiWnh9FDoUtA/iyFhBWa80O5Z0EX27oF9nbEKlIayZMBIm4l6ppJ2LDFw5qn?=
 =?us-ascii?Q?Nw/hSsiRnPq9KS/HbcrCsJ8LVMYSGnfutKdrfYm/b/XDYK/8I7qeJkQYnkRN?=
 =?us-ascii?Q?+yfwCXavIe51DNHZaBk+KJvbH4aStrFHIxqflZOJ9cIvxmlzx8FpdUtqogZR?=
 =?us-ascii?Q?VH9rndlUfZwJW3Z3b0XA811Q/R2Wn9/Y31k5Ae72i/pJiej5gTNUbQPgxjbF?=
 =?us-ascii?Q?yMQGjke1Ic14bZ6a1KWIIDPVsRCCpAwRSKg/gLLEY0Dsrt90aHAUkwL2Duzf?=
 =?us-ascii?Q?x5jv+FP/xoTfEacXz2bnlGweRL+0QDVx1bSvtGKRJkC8zgUMi6lmt45z5UOh?=
 =?us-ascii?Q?3tC1E3qJh0hO3FDgwER/+ElQWxKE3RcskHwVH6mNn7HDhJOHr0DK/PXmoV9U?=
 =?us-ascii?Q?h4rPKIxNRpEhx/FLj74DY4h1D8tAsU2pU1o9rrB+LBjyjTANzwO8oc71geEQ?=
 =?us-ascii?Q?7d158P9+k1u/ZLgOUIp+7g5VA5ZDeblJJQjusnRu6AuW/QOo5tJIQDMvekpg?=
 =?us-ascii?Q?nV4hMNZ1//GBIibFxVQiFnDJGrLY44Rn9ssJRzNUAlvb?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d574cba3-752b-479f-15a9-08da5eb9256c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2022 19:04:11.9428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 28TZi8/J19lY91xCI4Lj6xXYoD443ed7X49Zw2+W9gYWl7U2GtSpreTkXvrNcR57s8ZG/HpslMHttg9ED8mSQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5736
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 04, 2022 at 05:23:22PM +0200, Fabio M. De Francesco wrote:
> The use of kmap() is being deprecated in favor of kmap_local_page(). With
> kmap_local_page(), the mapping is per thread, CPU local and not globally
> visible.
> 
> Therefore, use kmap_local_page() / kunmap_local() in zstd.c because in this
> file the mappings are per thread and are not visible in other contexts. In
> the meanwhile use plain page_address() on pages allocated with the GFP_NOFS
> flag instead of calling kmap*() on them (since they are always allocated
> from ZONE_NORMAL).
> 
> Tested with xfstests on QEMU + KVM 32 bits VM with 4GB of RAM and
> booting a kernel with HIGHMEM64G enabled.
> 
> Cc: Filipe Manana <fdmanana@kernel.org>
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>  fs/btrfs/zstd.c | 34 ++++++++++++++--------------------
>  1 file changed, 14 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
> index 0fe31a6f6e68..78e0272e770e 100644
> --- a/fs/btrfs/zstd.c
> +++ b/fs/btrfs/zstd.c
> @@ -403,7 +403,7 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
>  
>  	/* map in the first page of input data */
>  	in_page = find_get_page(mapping, start >> PAGE_SHIFT);
> -	workspace->in_buf.src = kmap(in_page);
> +	workspace->in_buf.src = kmap_local_page(in_page);
>  	workspace->in_buf.pos = 0;
>  	workspace->in_buf.size = min_t(size_t, len, PAGE_SIZE);
>  
> @@ -415,7 +415,7 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
>  		goto out;
>  	}
>  	pages[nr_pages++] = out_page;
> -	workspace->out_buf.dst = kmap(out_page);
> +	workspace->out_buf.dst = page_address(out_page);
>  	workspace->out_buf.pos = 0;
>  	workspace->out_buf.size = min_t(size_t, max_out, PAGE_SIZE);
>  
> @@ -450,9 +450,7 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
>  		if (workspace->out_buf.pos == workspace->out_buf.size) {
>  			tot_out += PAGE_SIZE;
>  			max_out -= PAGE_SIZE;
> -			kunmap(out_page);
>  			if (nr_pages == nr_dest_pages) {
> -				out_page = NULL;
>  				ret = -E2BIG;
>  				goto out;
>  			}
> @@ -462,7 +460,7 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
>  				goto out;
>  			}
>  			pages[nr_pages++] = out_page;
> -			workspace->out_buf.dst = kmap(out_page);
> +			workspace->out_buf.dst = page_address(out_page);
>  			workspace->out_buf.pos = 0;
>  			workspace->out_buf.size = min_t(size_t, max_out,
>  							PAGE_SIZE);
> @@ -477,15 +475,15 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
>  		/* Check if we need more input */
>  		if (workspace->in_buf.pos == workspace->in_buf.size) {
>  			tot_in += PAGE_SIZE;
> -			kunmap(in_page);
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
> +			workspace->out_buf.dst = page_address(out_page);

Why is this needed?

The rest looks good,
Ira

[snip]
