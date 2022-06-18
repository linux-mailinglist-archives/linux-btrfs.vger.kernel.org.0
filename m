Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFAA550323
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Jun 2022 08:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiFRGOd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 18 Jun 2022 02:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiFRGOc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 18 Jun 2022 02:14:32 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E476E192A7
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jun 2022 23:14:30 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id g4so8060387wrh.11
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jun 2022 23:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zvgJCIb015g7IhtkTDiBU3KfXz4ADau4Yl/uZ2Eb+vU=;
        b=N/Ewu16t/xDX0+W/bf6ZJE5U2xxsfOjkbR44XdqcZNcbRL0Gc673A7StUOJZc4Vm46
         +BqSpF/I4C5MWmJImhbenZGNVWAGQfVGPnFnBdHmt3wimdMxAFolSE78+FgV9V3B1LBe
         6Lul595/JcSn38VLF9jsLYrc9irG5CTYw7b0dyjiNbKM7VRHVi51uhKr4AsPffW+Xemb
         uvqqgBw/eLAGwLF0+oWoBGDxKoxXAcXECDrqobUfgzEOqJnSjc6phvnIdJpG4TlZkkXH
         8COBwyML4matWH58WSxjgGMGCmDUfZGcWUwyWuQ6JZ4xhO3oOlaW1W6J18TWpgyVYmr5
         aX8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zvgJCIb015g7IhtkTDiBU3KfXz4ADau4Yl/uZ2Eb+vU=;
        b=BIOa0Ubbpz7ESbNbNuU9gZCp+kGNUp6s/umLdridyZQaGaLPMGGLdi6oyQJ0dpH55J
         6PFyBUHVvwixfz6ESyykmJlxhUdIc+1JOYlwB5K7a7+jVyx3dr8Q+iU2A+3wJOwnVw4Q
         oNpWLb/voXm1hbqdAOvouDAkk9BSayud4/8rZdmaLrFSdGPkAtoLFIcbQa65S0QYTQj3
         SS0hxt3qpO4kONiQtywruh2gnoPtGHpahUsSTo0ddd7L0oxh4ojoYFl/0pIhLbq6WC0c
         rg0g3Qw6769X3dMKGi4Kam8jXmWV/1aeubWVWzk+yTTsPE4r6qU7BRjdBr+NcvA1juMn
         5+pg==
X-Gm-Message-State: AJIora8H55Jh9FITfoosR7+/VbSX6ngA3MdgeZUWtHZC3SaN9oKm4Hy+
        3FmAd/L9AMrs3tnMbmrmVGoneedZdmU=
X-Google-Smtp-Source: AGRyM1ujtvqb2SxBUDLT1afPIqACmh4xUHByFicqwqjKSeIVo8CbITHkwk1axLjBl7SD4WF8sxzq0g==
X-Received: by 2002:adf:fb0d:0:b0:21a:2f42:4f0a with SMTP id c13-20020adffb0d000000b0021a2f424f0amr12423562wrr.638.1655532868682;
        Fri, 17 Jun 2022 23:14:28 -0700 (PDT)
Received: from opensuse.localnet (host-87-6-98-182.retail.telecomitalia.it. [87.6.98.182])
        by smtp.gmail.com with ESMTPSA id by13-20020a056000098d00b0021a39a56a73sm6269321wrb.106.2022.06.17.23.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 23:14:27 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     linux-btrfs@vger.kernel.org, Qu Wenruo <wqu@suse.com>
Cc:     ira.weiny@intel.com
Subject: Re: [PATCH] btrfs: zlib: refactor how we prepare the input buffer
Date:   Sat, 18 Jun 2022 08:14:26 +0200
Message-ID: <2326236.NG923GbCHz@opensuse>
In-Reply-To: <d0bfc791b5509df7b9ad44e41ada197d1b3149b3.1655519730.git.wqu@suse.com>
References: <d0bfc791b5509df7b9ad44e41ada197d1b3149b3.1655519730.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On sabato 18 giugno 2022 04:39:28 CEST Qu Wenruo wrote:
> Inspired by recent kmap() change from Fabio M. De Francesco.
> 

Thanks!

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
> 
> Cc: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Only tested on x86_64 for the correctness of the new helper.
>
> 
> But considering how small the window we need the page to be mapped, I
> think it should also work for x86 without any problem.
>

This patch passed 26/26 "compress" group tests of (x)fstests on a 32-bit 
QEMU + KVM VM (two tests were skipped because they need 5 or more disks, 
but I don't have enough free space).

Tested-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

tweed32:/usr/lib/xfstests # ./check -g compress
FSTYP         -- btrfs
PLATFORM      -- Linux/i686 tweed32 5.19.0-rc2-vanilla-debug+ #46 SMP 
PREEMPT_DYNAMIC Sat Jun 18 07:30:28 CEST 2022
MKFS_OPTIONS  -- /dev/loop1
MOUNT_OPTIONS -- /dev/loop1 /mnt/scratch

btrfs/024 4s ...  3s
btrfs/026 8s ...  6s
btrfs/037 5s ...  3s
btrfs/038 3s ...  3s
btrfs/041 4s ...  2s
btrfs/062 47s ...  40s
btrfs/063 26s ...  22s
btrfs/067 44s ...  39s
btrfs/068 17s ...  13s
btrfs/070	[not run] btrfs and this test needs 5 or more disks in 
SCRATCH_DEV_POOL
btrfs/071	[not run] btrfs and this test needs 5 or more disks in 
SCRATCH_DEV_POOL
btrfs/072 46s ...  41s
btrfs/073 21s ...  22s
btrfs/074 48s ...  41s
btrfs/076 3s ...  3s
btrfs/103 3s ...  3s
btrfs/106 3s ...  3s
btrfs/109 4s ...  3s
btrfs/113 4s ...  3s
btrfs/138 63s ...  53s
btrfs/149 4s ...  3s
btrfs/183 4s ...  3s
btrfs/205 4s ...  3s
btrfs/234 5s ...  4s
btrfs/246 3s ...  3s
btrfs/251 3s ...  2s
Ran: btrfs/024 btrfs/026 btrfs/037 btrfs/038 btrfs/041 btrfs/062 btrfs/063 
btrfs/067 btrfs/068 btrfs/070 btrfs/071 btrfs/072 btrfs/073 btrfs/074 
btrfs/076 btrfs/103 btrfs/106 btrfs/109 btrfs/113 btrfs/138 btrfs/149 
btrfs/183 btrfs/205 btrfs/234 btrfs/246 btrfs/251
Not run: btrfs/070 btrfs/071
Passed all 26 tests

>
> ---
>  fs/btrfs/zlib.c | 85 ++++++++++++++++++++++++-------------------------
>  1 file changed, 41 insertions(+), 44 deletions(-)
> 
> diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
> index 767a0c6c9694..2cd4f6fb1537 100644
> --- a/fs/btrfs/zlib.c
> +++ b/fs/btrfs/zlib.c
> @@ -91,20 +91,54 @@ struct list_head *zlib_alloc_workspace(unsigned int 
level)
>  	return ERR_PTR(-ENOMEM);
>  }
>  
> +/*
> + * Copy the content from page cache into @workspace->buf.
> + *
> + * @total_in:		The original total input length.
> + * @fileoff_ret:	The file offset.
> + *			Will be increased by the number of bytes we 
read.
> + */
> +static void fill_input_buffer(struct workspace *workspace,
> +			      struct address_space *mapping,
> +			      unsigned long total_in, u64 
*fileoff_ret)
> +{
> +	unsigned long bytes_left = total_in - workspace->strm.total_in;
> +	const int input_pages = min(DIV_ROUND_UP(bytes_left, PAGE_SIZE),
> +				    workspace->buf_size / 
PAGE_SIZE);
> +	u64 file_offset = *fileoff_ret;
> +	int i;
> +
> +	/* Copy the content of each page into the input buffer. */
> +	for (i = 0; i < input_pages; i++) {
> +		struct page *in_page;
> +		void *addr;
> +
> +		in_page = find_get_page(mapping, file_offset >> 
PAGE_SHIFT);
> +
> +		addr = kmap_local_page(in_page);
> +		memcpy(workspace->buf + i * PAGE_SIZE, addr, 
PAGE_SIZE);
> +		kunmap_local(addr);
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
>  int zlib_compress_pages(struct list_head *ws, struct address_space 
*mapping,
>  		u64 start, struct page **pages, unsigned long 
*out_pages,
>  		unsigned long *total_in, unsigned long *total_out)
>  {
>  	struct workspace *workspace = list_entry(ws, struct workspace, 
list);
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
> @@ -140,40 +174,8 @@ int zlib_compress_pages(struct list_head *ws, struct 
address_space *mapping,
>  		 * Get next input pages and copy the contents to
>  		 * the workspace buffer if required.
>  		 */
> -		if (workspace->strm.avail_in == 0) {
> -			bytes_left = len - workspace->strm.total_in;
> -			in_buf_pages = min(DIV_ROUND_UP(bytes_left, 
PAGE_SIZE),
> -					   workspace->buf_size / 
PAGE_SIZE);
> -			if (in_buf_pages > 1) {
> -				int i;
> -
> -				for (i = 0; i < in_buf_pages; i++) 
{
> -					if (in_page) {
> -						
kunmap(in_page);
> -						
put_page(in_page);
> -					}
> -					in_page = 
find_get_page(mapping,
> -								
start >> PAGE_SHIFT);
> -					data_in = kmap(in_page);
> -					memcpy(workspace->buf + i 
* PAGE_SIZE,
> -					       data_in, 
PAGE_SIZE);
> -					start += PAGE_SIZE;
> -				}
> -				workspace->strm.next_in = 
workspace->buf;
> -			} else {
> -				if (in_page) {
> -					kunmap(in_page);
> -					put_page(in_page);
> -				}
> -				in_page = find_get_page(mapping,
> -							start 
>> PAGE_SHIFT);
> -				data_in = kmap(in_page);
> -				start += PAGE_SIZE;
> -				workspace->strm.next_in = data_in;
> -			}
> -			workspace->strm.avail_in = min(bytes_left,
> -						       
(unsigned long) workspace->buf_size);
> -		}
> +		if (workspace->strm.avail_in == 0)
> +			fill_input_buffer(workspace, mapping, len, 
&start);
>  
>  		ret = zlib_deflate(&workspace->strm, Z_SYNC_FLUSH);
>  		if (ret != Z_OK) {
> @@ -266,11 +268,6 @@ int zlib_compress_pages(struct list_head *ws, struct 
address_space *mapping,
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
Good job!

With your patch, the logic of zlib_compress_pages() is much more 
understandable for people unfamiliar with this code.

Reviewed-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

As a side effect (desired and important to me), I can now easily convert 
the remaining kmap() call sites in zlib.c.

Thanks again,

Fabio

PS: I'm adding Ira Weiny to the list of recipients.


