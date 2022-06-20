Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6BE95526A2
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Jun 2022 23:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbiFTVih (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Jun 2022 17:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344307AbiFTVic (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Jun 2022 17:38:32 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3C0140B7
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Jun 2022 14:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655761111; x=1687297111;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AjsNlIkuCUYKMsUZoyi1pVt6ngwim51fts4tX2ixG3s=;
  b=Bxz+9kdeIJrTKIQZzLssO1mf5cYcSDu+5Jugmhxm4/Pu/sgy0J+VKMk8
   R4Il8+JOTJjwjTHiMQW+JW0oPjpaYC6H9F6MWQG5OfSnqNM90/hCQ29AX
   BpxkSuD8H+/438xFKj+NFsCpZbIiOJwOvwt80sEfawnuBL+YGpPSyc3+0
   XS2xbaEmqvguvxt2RSoCnYKt6fNNUvLP19Ug6ULb95h5UTph5fbMmi3H2
   uh+HfQneqaTwnUb/H54v36G7oXwoJPyuZcVXFMhJLbLweKbdvKTyt8qIf
   yEZ5yhVW42olLpkauF3ZuKVt6365akDv4ePx7enf4uI5XMAGSc9qk1hxS
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10384"; a="305412790"
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; 
   d="scan'208";a="305412790"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 14:38:30 -0700
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; 
   d="scan'208";a="764237133"
Received: from ashwinna-mobl3.amr.corp.intel.com (HELO localhost) ([10.209.11.254])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 14:38:30 -0700
Date:   Mon, 20 Jun 2022 14:38:30 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        "Fabio M . De Francesco" <fmdefrancesco@gmail.com>
Subject: Re: [PATCH] btrfs: zlib: refactor how we prepare the input buffer
Message-ID: <YrDo1qgcXEKSQM7l@iweiny-desk3>
References: <d0bfc791b5509df7b9ad44e41ada197d1b3149b3.1655519730.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0bfc791b5509df7b9ad44e41ada197d1b3149b3.1655519730.git.wqu@suse.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jun 18, 2022 at 10:39:28AM +0800, Qu Wenruo wrote:
> Inspired by recent kmap() change from Fabio M. De Francesco.
> 
> There are some weird behavior in zlib_compress_pages(), mostly around how
> we prepare the input buffer.
> 
> [BEFORE]
> - We hold a page mapped for a long time
>   This is making it much harder to convert kmap() to kmap_local_page(),
>   as such long mapped page can lead to nested mapped page.
> 
> - Different paths in the name of "optimization"
>   When we ran out of input buffer, we will grab the new input with two
>   different paths:
> 
>   * If there are more than one pages left, we copy the content into the
>     input buffer.
>     This behavior is introduced mostly for S390, as that arch needs
>     multiple pages as input buffer for hardware decompression.
> 
>   * If there is only one page left, we use that page from page cache
>     directly without copying the content.
> 
>   This is making page map/unmap much harder, especially due the latter
>   case.
> 
> [AFTER]
> This patch will change the behavior by introducing a new helper, to
> fulfill the input buffer:
> 
> - Only map one page when we do the content copy
> 
> - Unified path, by always copying the page content into workspace
>   input buffer
>   Yes, we're doing extra page copying. But the original optimization
>   only work for the last page of the input range.
> 
>   Thus I'd say the sacrifice is already not that big.
> 
> - Use kmap_local_page() and kunmap_local() instead
>   Now the lifespan for the mapped page is only during memcpy() call,
>   we're definitely fine to use kmap_local_page()/kunmap_local().

Thanks!  This helps a lot.  Minor issue below.

[snip]

> +static void fill_input_buffer(struct workspace *workspace,
> +			      struct address_space *mapping,
> +			      unsigned long total_in, u64 *fileoff_ret)
> +{
> +	unsigned long bytes_left = total_in - workspace->strm.total_in;
> +	const int input_pages = min(DIV_ROUND_UP(bytes_left, PAGE_SIZE),
> +				    workspace->buf_size / PAGE_SIZE);
> +	u64 file_offset = *fileoff_ret;
> +	int i;
> +
> +	/* Copy the content of each page into the input buffer. */
> +	for (i = 0; i < input_pages; i++) {
> +		struct page *in_page;
> +		void *addr;
> +
> +		in_page = find_get_page(mapping, file_offset >> PAGE_SHIFT);
> +
> +		addr = kmap_local_page(in_page);
> +		memcpy(workspace->buf + i * PAGE_SIZE, addr, PAGE_SIZE);
> +		kunmap_local(addr);

This should be memcpy_from_page().

Ira

> +
> +		put_page(in_page);
> +		file_offset += PAGE_SIZE;
> +	}
> +	*fileoff_ret = file_offset;
> +	workspace->strm.next_in = workspace->buf;
> +	workspace->strm.avail_in = min_t(unsigned long, bytes_left,
> +					 workspace->buf_size);
> +}
> +
>  int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
>  		u64 start, struct page **pages, unsigned long *out_pages,
>  		unsigned long *total_in, unsigned long *total_out)
>  {
>  	struct workspace *workspace = list_entry(ws, struct workspace, list);
> +	/* Total input length. */
> +	const unsigned long len = *total_out;
>  	int ret;
> -	char *data_in;
>  	char *cpage_out;
>  	int nr_pages = 0;
> -	struct page *in_page = NULL;
>  	struct page *out_page = NULL;
> -	unsigned long bytes_left;
> -	unsigned int in_buf_pages;
> -	unsigned long len = *total_out;
>  	unsigned long nr_dest_pages = *out_pages;
>  	const unsigned long max_out = nr_dest_pages * PAGE_SIZE;
>  
> @@ -140,40 +174,8 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
>  		 * Get next input pages and copy the contents to
>  		 * the workspace buffer if required.
>  		 */
> -		if (workspace->strm.avail_in == 0) {
> -			bytes_left = len - workspace->strm.total_in;
> -			in_buf_pages = min(DIV_ROUND_UP(bytes_left, PAGE_SIZE),
> -					   workspace->buf_size / PAGE_SIZE);
> -			if (in_buf_pages > 1) {
> -				int i;
> -
> -				for (i = 0; i < in_buf_pages; i++) {
> -					if (in_page) {
> -						kunmap(in_page);
> -						put_page(in_page);
> -					}
> -					in_page = find_get_page(mapping,
> -								start >> PAGE_SHIFT);
> -					data_in = kmap(in_page);
> -					memcpy(workspace->buf + i * PAGE_SIZE,
> -					       data_in, PAGE_SIZE);
> -					start += PAGE_SIZE;
> -				}
> -				workspace->strm.next_in = workspace->buf;
> -			} else {
> -				if (in_page) {
> -					kunmap(in_page);
> -					put_page(in_page);
> -				}
> -				in_page = find_get_page(mapping,
> -							start >> PAGE_SHIFT);
> -				data_in = kmap(in_page);
> -				start += PAGE_SIZE;
> -				workspace->strm.next_in = data_in;
> -			}
> -			workspace->strm.avail_in = min(bytes_left,
> -						       (unsigned long) workspace->buf_size);
> -		}
> +		if (workspace->strm.avail_in == 0)
> +			fill_input_buffer(workspace, mapping, len, &start);
>  
>  		ret = zlib_deflate(&workspace->strm, Z_SYNC_FLUSH);
>  		if (ret != Z_OK) {
> @@ -266,11 +268,6 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
>  	*out_pages = nr_pages;
>  	if (out_page)
>  		kunmap(out_page);
> -
> -	if (in_page) {
> -		kunmap(in_page);
> -		put_page(in_page);
> -	}
>  	return ret;
>  }
>  
> -- 
> 2.36.1
> 
