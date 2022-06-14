Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4475854B2D6
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jun 2022 16:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236644AbiFNOOB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Jun 2022 10:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233498AbiFNON6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Jun 2022 10:13:58 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FFD2AC53;
        Tue, 14 Jun 2022 07:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655216037; x=1686752037;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=A5RBNaE+FFAc0u3Bmk3R0ra9nTk9NBMyOGmzPnPQtH8=;
  b=VITy9yXCvkZOnQ3CGez460LyIqJsYfxQzt1vvDzh/lUCyouA15+WVRGS
   5A1na5mF3xwXwV3UDGkHsvm5+jShE9mFc6WD1fIbA2+PpYDmhCVkirL5e
   pTawljt6ZFg/JEBIBahoK0NtocT6V1Ymslc3W5/zPmJ+S28X+lXT8LSR8
   plBR8z7NZRTnO5rreEODzGF9OBvZc1QlcKguEmNfqrzVfn9WKUigZ8aLr
   eJd1eeaADZrQuK0z5ldCVYZvXboxIfoUrNbRbd6nYjeuMHtVFY++f41VE
   +6EMbW8ZnbxvVtU6Y1AfyXTYJVrN+TkRmkojFlCdzjyv3IRZppW8hCgPb
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="267314209"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="267314209"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 07:13:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="569998998"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga002.jf.intel.com with ESMTP; 14 Jun 2022 07:13:57 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 14 Jun 2022 07:13:56 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 14 Jun 2022 07:13:56 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 14 Jun 2022 07:13:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sd1Nt5Dfkp2pFnPY2UkApvZkw5oltxRvbRHMvesH/BdHSUV6PbT/xeeDSRpDkfRC6M7fTVKvDv3kgn3IGzinWcl2sstG+q9A11PXKsfAfsGLzwGzpPoHd3Vvo3IzONFhZT9c8K9RLnLyKo5Tq7ijXK6tjmwMgiDu7Qez1GdZAzJstw0I9OBafSGgjWDl8sOHF7qaNRue63T+zq/MRhFdGqlSyPgNytx+5y/Plro9iL/ADBrf0RhLo2J19h9NNHIHcEaP7Ez9PjkJtnBQtY7Bex1KE/qBJxGrFfvDGJr4cNQq0mlvNYekSR/DBW0wx+Q+W6F5gOkT39Q58teC13outw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t2PdxJV5RMAYKPBpFIgImOMVTMTpa90wDnZ096n827g=;
 b=Kq7QYoGdu4R3WguUDjjMDG1/LP6rYkCn1B0+kSedZO2Bxlv4ZhNFqXfiSn4NAfxiqf6FGiLJZEcHnzsOB3GTk2xLMnBr7SJvXTShbF4swXq6YYpzwgsLNpyfENLMA2AMoG1THBEW2TYhFkNddtn9WDZ+taWDCBWVAGIraq8I98+DbkW1ZuV0QXGDJvazuGrpNF/QfazjNWeqScHIxY7htgBMpQWDLDU1XQhklsmRfUC4glD6CC6gi+5msVd7ZhNLQ3I8qqw6MPnsCJtp6lHelhnjx8eJ5XZDc01JQNEDlVd9d9H0anmK7FBSQooZN9h+unULc1bMVs/O6JtCmJHlJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 SA2PR11MB4988.namprd11.prod.outlook.com (2603:10b6:806:f8::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.13; Tue, 14 Jun 2022 14:13:54 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::d4e9:9ae1:29b2:90c]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::d4e9:9ae1:29b2:90c%5]) with mapi id 15.20.5332.020; Tue, 14 Jun 2022
 14:13:54 +0000
Date:   Tue, 14 Jun 2022 07:13:49 -0700
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
Subject: Re: [RFC PATCH] btrfs: Replace kmap() with kmap_local_page() in
 zlib.c
Message-ID: <YqiXnc2YyCkE2huj@iweiny-desk3>
References: <20220614104718.9193-1-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220614104718.9193-1-fmdefrancesco@gmail.com>
X-ClientProxiedBy: MWHPR18CA0070.namprd18.prod.outlook.com
 (2603:10b6:300:39::32) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a4a7b797-3ed8-4b46-06e8-08da4e101cfe
X-MS-TrafficTypeDiagnostic: SA2PR11MB4988:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <SA2PR11MB4988C91AB1406192E97DD4A9F7AA9@SA2PR11MB4988.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2IKU5QSwkwoAgJDoQGMA4PjiCnowdIPQfnHq1okn/YfiTuj7GSBq3CxV/QFVuaShLKZVCTG53SfUck5CkMaC4ZpBXEQNvL7u8V3ZLUR5hKdh8CPv1ucjw1NxZIpZfsmfS2HCgeJMg+cHKF1VGAiMLeGzj+E3pOx1j9n0KVFQfOnf31Olh2vMfhGpcMxGvje0LyutgbgbftTnclKlvgvM0xjsuSZGYwHUL0UWq0H60fW7nCpZMyrctt6AmNqavRfoS77GS4h0BkHl6vzKrtmLa9qnO4/PYVYQwOYF9SpTn5LSg8m1dkdCAg5w8JNtJGjA4ZPjAJnbFPGuzOvtktPFvSok/fW+jw0hCSeRfZkrL3a250LqhAhacYvVno27OYRA/yQ80y8eu6qrIIKkWTsmLrv3v0+mKVX9Z95qSSqz16tvUQNOUtTCet/SRgLDV1ptCVH5wRNev/OTZsCagpQ3sjCwAY7UDGe4kDJLw3A12Lpn0SM0zmsb173Vffc+oFn/spwwYAr/HxsOATbDULAZ+B/PVkt70vkkFzb2KPzEj8VIbOTeWYJtMT3YGsbGboE5XvphaSGaXcH0m+TbMLWYEzUp+/7RvDZ78vDpIM40k8PqUaSLt068GfOi27gsg6WQPYtFZ6K/ovnBmGnAo2gz+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(8936002)(508600001)(7416002)(5660300002)(44832011)(82960400001)(6916009)(54906003)(316002)(8676002)(66476007)(6486002)(4326008)(66946007)(66556008)(86362001)(83380400001)(186003)(9686003)(6512007)(26005)(38100700002)(2906002)(33716001)(6506007)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Qj9y+I8majgxTFX8AVByMkB2FZIdvCtxDcne5dfj9sn4wwdw7p/AMYCZkwMC?=
 =?us-ascii?Q?HCndyp41ryXJ/HrkH4TPwKyrK7ea15UBuYH+bxzxmWdYPexrkUuWHJr2ItqI?=
 =?us-ascii?Q?L49QaxwKu5ZZmo5nXLnDpbUbznqCR8j+yT6vJL3g6BNI9GPaeQZ7JDmMbv91?=
 =?us-ascii?Q?H7u2jcIyVpnbsHyh3bxUhBkuhks7fyJUkoes/LWR3MSDJsWIeCkXr/sTmFV+?=
 =?us-ascii?Q?/Pj9kWx+Dmf6B8sbUjYOC97maWq+5eRcjcb6PlwYWCy7Qe4iOe/pxZZ1K7c/?=
 =?us-ascii?Q?kvBDfV6j/48Ky9Tj70dZd7ZPyUUbhudeldh6mJE/FNHpmxmMNeHBvh40KgI1?=
 =?us-ascii?Q?PvYILlNCxYp4VvprFMx1liY8Tb0W3v5sdfyGzRBao1iZ8GGSRdWQ3xYalj9B?=
 =?us-ascii?Q?CorrQ2CNZpF3KWenbijZyORn9SruZ5Sh8QqVSGBQwrFI+/sxa0C4qk8zssJ9?=
 =?us-ascii?Q?vOSDG5sMsZvSABZLO4G9CIZz4agWt8QPcLAXSQQcrgekmQEVOBMg2FbFLWIm?=
 =?us-ascii?Q?yIf1empUbEtIHAuZZSex3t/W0Ets2eXaN9zZj5y/TMDr/iLFem1mfABZT4Sm?=
 =?us-ascii?Q?JpUxxiT9Yf0euerKNabqZBBqljMR9Ps2jfPtfVo4ii1eyyp/uhiCSc9Yt+K3?=
 =?us-ascii?Q?ggjvSvuUd9TjKCn72QAEYFWBrDL8c5OOhCzFaqITZ5D7yagoaylpx7K8rAk4?=
 =?us-ascii?Q?/S2WmPDa18bUwg5T5dS4URo6JxWwgWT6dCrFT6e/HFP0wzHVgo4bea7Ul3lK?=
 =?us-ascii?Q?wR4617B6D6Usp+O17JxNQ6i4CMAtUBpMUL2F+TJ738yHudK6OllFUmR5YLBa?=
 =?us-ascii?Q?thhOomz3onMLrkGCobhqrQptiZOijaO5bwsgTW4NGvaL7Q+vccIxgutvhMvs?=
 =?us-ascii?Q?Dg09/mWbLqZC7IPTKgiF6V+jWL/gbyvIIfGXfpK7kUrerOR7eno3ZjG/Juoi?=
 =?us-ascii?Q?yCUoLYIX20sUYqXbINVwM/8D27CGkdEHl2oUttZFWVxn/L0l61NM1/vsTuf/?=
 =?us-ascii?Q?t+cE4pNROtbY+H29dhNi5fNC5wItiJB3GbkfaMtmxR77xHku0Au+b3eV5d+w?=
 =?us-ascii?Q?wspdywnyM3eLNoRXXqk/pbPBewOIzmen6raE12EMVidE5i1nxw4KF+i+4xXH?=
 =?us-ascii?Q?wiYwIjj8fPyGR8Bv8xSHqtV3yXXgvl2Tusibw8bOhOTgql688QIlYxIHfDnV?=
 =?us-ascii?Q?9CBRm8NcjWOWrwH871uV6kEv/JWeJYWyymWi1k3G3gF7TGgTmu7tPMpMprAx?=
 =?us-ascii?Q?nuUSJJx2UQ42FjaNnFR1XAuOhYeVSGdX7W5Envued9J/cWzLtrj0Km6kwViL?=
 =?us-ascii?Q?mebHxPFsd5OCLk6tNob9QZEwnxqfNskqipyDRWOu/HEuG1ePY54fo24nrHR7?=
 =?us-ascii?Q?eiQOwAQ9RQQPqdrneScNvndvOoqJ7WgKtNUxx3xnau7KQcP19UpotsNJWIqz?=
 =?us-ascii?Q?6ykgA7by0Ds5Ntyo01Tilr51EIoUM+ijE65Yhs9mBUZsXqOoWdWyAeMP43Ss?=
 =?us-ascii?Q?CbiuFzENFYf9cz1yviw5EyoCCEnSE9xOUSzwinNOT2lpzGmQU90U+HuP81Q2?=
 =?us-ascii?Q?uBnlF1PlqAuZUYxoTFNdr1250W4bq0xfGEN5loWMOxwImK4PsK0kxriMYMVc?=
 =?us-ascii?Q?0OGPeoGSCILd6phd5kksF0W7HmEUYgqCp6IM3TnzMv7Aw0PvnFnqNyXiCY8V?=
 =?us-ascii?Q?2vVG25JMMR7JQSp19RG3GjPKUDOD5Bs+JEj+QQFQQl+/wvP9sTn/yNL4YICW?=
 =?us-ascii?Q?cJvsFOKNg24tv+rspPph0XXjgMADGr8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a4a7b797-3ed8-4b46-06e8-08da4e101cfe
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2022 14:13:54.0918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kNRzKLdKMhIX3d6eZ+Krd2pmJfSaJFHD1EEs/ghrlokPXKRrGcR1h5ZR8geFP1OY09bHQx6Mk6oLfsiOA+tJGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4988
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 14, 2022 at 12:47:18PM +0200, Fabio M. De Francesco wrote:

[snip]

> @@ -148,26 +148,26 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
>  				int i;
>  
>  				for (i = 0; i < in_buf_pages; i++) {
> -					if (in_page) {
> -						kunmap(in_page);
> +					if (data_in) {
> +						kunmap_local(data_in);
>  						put_page(in_page);
>  					}
>  					in_page = find_get_page(mapping,
>  								start >> PAGE_SHIFT);
> -					data_in = kmap(in_page);
> +					data_in = kmap_local_page(in_page);
>  					memcpy(workspace->buf + i * PAGE_SIZE,
>  					       data_in, PAGE_SIZE);
>  					start += PAGE_SIZE;

This is moving start forward...

>  				}
>  				workspace->strm.next_in = workspace->buf;
>  			} else {
> -				if (in_page) {
> -					kunmap(in_page);
> +				if (data_in) {
> +					kunmap_local(data_in);
>  					put_page(in_page);
>  				}
>  				in_page = find_get_page(mapping,
>  							start >> PAGE_SHIFT);
> -				data_in = kmap(in_page);
> +				data_in = kmap_local_page(in_page);
>  				start += PAGE_SIZE;
>  				workspace->strm.next_in = data_in;
>  			}
> @@ -196,9 +196,14 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
>  		 * the stream end if required
>  		 */
>  		if (workspace->strm.avail_out == 0) {
> -			kunmap(out_page);
> +			kunmap_local(data_in);
> +			data_in = NULL;
> +			put_page(in_page);

I don't think you need to put/get the page to do the remapping.

> +
> +			kunmap_local(cpage_out);
>  			if (nr_pages == nr_dest_pages) {
> -				out_page = NULL;
> +				cpage_out = NULL;
> +				put_page(out_page);
>  				ret = -E2BIG;
>  				goto out;
>  			}
> @@ -207,7 +212,14 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
>  				ret = -ENOMEM;
>  				goto out;
>  			}
> -			cpage_out = kmap(out_page);
> +			cpage_out = kmap_local_page(out_page);
> +
> +			in_page = find_get_page(mapping, start >> PAGE_SHIFT);

I think start is the wrong value here.  It got incremented above.

> +			data_in = kmap_local_page(in_page);
> +			workspace->strm.next_in = data_in;
> +			workspace->strm.avail_in = min(bytes_left,
> +						       (unsigned long)workspace->buf_size);

I'm not sure about changing avail_in here either because nothing has happened
with the in buffer whilst doing this re-mapping AFAICS.

[snip]

I think the issue with the tests is contained to zlib_compress_pages().
But an idea to verify that is to split this patch between the changes in
zlib_compress_pages() [above] and zlib_decompress_bio() [below] because below
looks very straight forward.

Ira

> @@ -287,7 +311,7 @@ int zlib_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
>  	unsigned long buf_start;
>  	struct page **pages_in = cb->compressed_pages;
>  
> -	data_in = kmap(pages_in[page_in_index]);
> +	data_in = kmap_local_page(pages_in[page_in_index]);
>  	workspace->strm.next_in = data_in;
>  	workspace->strm.avail_in = min_t(size_t, srclen, PAGE_SIZE);
>  	workspace->strm.total_in = 0;
> @@ -309,7 +333,7 @@ int zlib_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
>  
>  	if (Z_OK != zlib_inflateInit2(&workspace->strm, wbits)) {
>  		pr_warn("BTRFS: inflateInit failed\n");
> -		kunmap(pages_in[page_in_index]);
> +		kunmap_local(data_in);
>  		return -EIO;
>  	}
>  	while (workspace->strm.total_in < srclen) {
> @@ -336,13 +360,14 @@ int zlib_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
>  
>  		if (workspace->strm.avail_in == 0) {
>  			unsigned long tmp;
> -			kunmap(pages_in[page_in_index]);
> +
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
> @@ -355,7 +380,7 @@ int zlib_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
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
