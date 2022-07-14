Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B488574082
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Jul 2022 02:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbiGNAZZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 13 Jul 2022 20:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiGNAZY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Jul 2022 20:25:24 -0400
Received: from out20-194.mail.aliyun.com (out20-194.mail.aliyun.com [115.124.20.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD1B192;
        Wed, 13 Jul 2022 17:25:21 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04436396|-1;BR=01201311R141S26rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.147629-0.00137183-0.850999;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047211;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.OS-no4c_1657758318;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.OS-no4c_1657758318)
          by smtp.aliyun-inc.com;
          Thu, 14 Jul 2022 08:25:19 +0800
Date:   Thu, 14 Jul 2022 08:25:20 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: Re: [PATCH] btrfs: Replace kmap() with kmap_local_page() in zstd.c
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Nick Terrell <terrelln@fb.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Filipe Manana <fdmanana@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>
In-Reply-To: <20220611135203.27992-1-fmdefrancesco@gmail.com>
References: <20220611135203.27992-1-fmdefrancesco@gmail.com>
Message-Id: <20220714082519.A7C9.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 8BIT
X-Mailer: Becky! ver. 2.75.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

Compiler warning:

fs/btrfs/zstd.c:478:55: warning: passing argument 1 of ¡®__kunmap_local¡¯ discards ¡®const¡¯ qualifier from pointer target type [-Wdiscarded-qualifiers]
  478 |                         kunmap_local(workspace->in_buf.src);
./include/linux/highmem-internal.h:284:24: note: in definition of macro ¡®kunmap_local¡¯
  284 |         __kunmap_local(__addr);                                 \
      |                        ^~~~~~
./include/linux/highmem-internal.h:200:41: note: expected ¡®void *¡¯ but argument is of type ¡®const void *¡¯
  200 | static inline void __kunmap_local(void *addr)
      |                                   ~~~~~~^~~~

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2022/07/14

> The use of kmap() is being deprecated in favor of kmap_local_page(). With
> kmap_local_page(), the mapping is per thread, CPU local and not globally
> visible.
> 
> Therefore, use kmap_local_page() / kunmap_local() in zstd.c because in
> this file the mappings are per thread and are not visible in other
> contexts; meanwhile refactor zstd_compress_pages() to comply with nested
> local mapping / unmapping ordering rules.
> 
> Tested with xfstests on a QEMU + KVM 32 bits VM with 4GB of RAM and
> HIGHMEM64G enabled.
> 
> Cc: Filipe Manana <fdmanana@kernel.org>
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
> 
> Thanks to Ira Weiny for his invaluable help and persevering support.
> Thanks also to Filipe Manana for identifying a fundamental detail I had overlooked:
> https://lore.kernel.org/lkml/20220611093411.GA3779054@falcondesktop/ 
> 
> tweed32:/usr/lib/xfstests # ./check -g compress
> FSTYP         -- btrfs
> PLATFORM      -- Linux/i686 tweed32 5.19.0-rc1-vanilla-debug+ #22 SMP PREEMPT_DYNAMIC Sat Jun 11 14:31:39 CEST 2022
> MKFS_OPTIONS  -- /dev/loop1
> MOUNT_OPTIONS -- /dev/loop1 /mnt/scratch
> 
> btrfs/024 1s ...  0s
> btrfs/026 3s ...  3s
> btrfs/037 1s ...  1s
> btrfs/038 1s ...  0s
> btrfs/041 0s ...  1s
> btrfs/062 34s ...  35s
> btrfs/063 18s ...  18s
> btrfs/067 33s ...  32s
> btrfs/068 10s ...  10s
> btrfs/070       [not run] btrfs and this test needs 5 or more disks in SCRATCH_DEV_POOL
> btrfs/071       [not run] btrfs and this test needs 5 or more disks in SCRATCH_DEV_POOL
> btrfs/072 33s ...  33s
> btrfs/073 17s ...  15s
> btrfs/074 36s ...  32s
> btrfs/076 0s ...  0s
> btrfs/103 1s ...  1s
> btrfs/106 1s ...  1s
> btrfs/109 1s ...  0s
> btrfs/113 0s ...  1s
> btrfs/138 43s ...  46s
> btrfs/149 1s ...  1s
> btrfs/183 1s ...  1s
> btrfs/205 1s ...  1s
> btrfs/234 3s ...  3s
> btrfs/246 0s ...  0s
> btrfs/251 1s ...  1s
> Ran: btrfs/024 btrfs/026 btrfs/037 btrfs/038 btrfs/041 btrfs/062 btrfs/063 btrfs/067 btrfs/068 btrfs/070 btrfs/071 btrfs/072 btrfs/073 btrfs/074 btrfs/076 btrfs/103 btrfs/106 btrfs/109 btrfs/113 btrfs/138 btrfs/149 btrfs/183 btrfs/205 btrfs/234 btrfs/246 btrfs/251
> Not run: btrfs/070 btrfs/071
> Passed all 26 tests
> 
>  fs/btrfs/zstd.c | 42 +++++++++++++++++++++++-------------------
>  1 file changed, 23 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
> index 0fe31a6f6e68..4d50eb3edce5 100644
> --- a/fs/btrfs/zstd.c
> +++ b/fs/btrfs/zstd.c
> @@ -391,6 +391,8 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
>  	*out_pages = 0;
>  	*total_out = 0;
>  	*total_in = 0;
> +	workspace->in_buf.src = NULL;
> +	workspace->out_buf.dst = NULL;
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
> +			kunmap_local((void *)workspace->in_buf.src);
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
> +		kunmap_local((void *)workspace->in_buf.src);
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
> +			kunmap_local((void *)workspace->in_buf.src);
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
> +		kunmap_local((void *)workspace->in_buf.src);
>  	return ret;
>  }
>  
> -- 
> 2.36.1


