Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7725B54734B
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Jun 2022 11:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbiFKJeV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 11 Jun 2022 05:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiFKJeU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 11 Jun 2022 05:34:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE55760DE;
        Sat, 11 Jun 2022 02:34:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 44E54B80735;
        Sat, 11 Jun 2022 09:34:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72AEEC34116;
        Sat, 11 Jun 2022 09:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654940054;
        bh=Vtk6TK+0pIoI6XwxJPmgg7GkQJaA8TTlSr7u406vlOk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RrRqwn1EmlBxgOSMVEAzkD20uR7r3kNmWJo6CebZwCUSHeq8dLnTmkMrG/15qNIBk
         xi5TNglzJrgsVIxC/QG0Qfi+ddsaed18SZPcMIQoBofeY3LpDxqXW8EbgwyLt7y/WV
         Pa9smEwbnObjbU5oJ4cj9tBABTC8Rdkg1NENjp1i91VrW0aC9ddKYD5NNkNOnN8RCs
         nPqioLRyTTHQnO7Z45qJkXSDhPFtRrmEPkg1qkbM06AvMZFlJIkpMu2pIUbP5gnGei
         cXuSi3LLWJbGsbwcFVbTNexFRnPZ0qWuC3LpcceHDAbpu9cvyX1YDEpxtLLWSDKOPQ
         fXdVMQIKw8RbA==
Date:   Sat, 11 Jun 2022 10:34:11 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Nick Terrell <terrelln@fb.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [RFC PATCH] btrfs: Replace kmap() with kmap_local_page() in
 zstd.c
Message-ID: <20220611093411.GA3779054@falcondesktop>
References: <20220611020451.28170-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220611020451.28170-1-fmdefrancesco@gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jun 11, 2022 at 04:04:51AM +0200, Fabio M. De Francesco wrote:
> The use of kmap() is being deprecated in favor of kmap_local_page(). With
> kmap_local_page(), the mapping is per thread, CPU local and not globally
> visible.
> 
> Therefore, use kmap_local_page() / kunmap_local() in zstd.c because in
> this file the mappings are per thread and are not visible in other
> contexts; meanwhile refactor zstd_compress_pages() to comply with nested
> local mapping / unmapping ordering rules.
> 
> Tested with xfstests (./check -g compress) on QEMU + KVM 32 bits VM with
> 4GB of RAM and HIGHMEM64G enabled.
> 
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
> 
> This is an RFC PATCH because it actually passes all xfstests of group
> "compress" with the only exception of tests/btrfs/138.
> 
> Since I am relatively new to kernel development and know very little about
> fs/btrfs design and code, I would like to ask for the help from anyone who
> knows this filesystem and xfstests better than me.
> 
> Can anyone please help me figure out what's wrong and how to fix it?
> 
> Please note that there is some discussion for changing __kunmap_local().
> For now I had to cast workspace->in_buf.src to pointer to void,
> otherwise GCC-12 complains with a series of messages like the
> following...
> 
> /usr/src/git/kernels/linux/fs/btrfs/zstd.c:547:33: warning: passing argument 1 of '__kunmap_local' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
>   547 |   kunmap_local(workspace->in_buf.src);
>       |                ~~~~~~~~~~~~~~~~~^~~~
> /usr/src/git/kernels/linux/include/linux/highmem-internal.h:284:17: note: in definition of macro 'kunmap_local'
>   284 |  __kunmap_local(__addr);     \
>       |                 ^~~~~~
> /usr/src/git/kernels/linux/include/linux/highmem-internal.h:92:41: note: expected 'void *' but argument is of type 'const void *'
>    92 | static inline void __kunmap_local(void *vaddr)
>       |                                   ~~~~~~^~~~~
>  
> This is what I get from running xfstests of "compress" group...
> 
> tweed32:/usr/lib/xfstests # ./check -g compress
> FSTYP         -- btrfs
> PLATFORM      -- Linux/i686 tweed32 5.19.0-rc1-vanilla-debug+ #20 SMP PREEMPT_DYNAMIC Fri Jun 10 14:15:51 CEST 2022
> MKFS_OPTIONS  -- /dev/loop1
> MOUNT_OPTIONS -- /dev/loop1 /mnt/scratch
> 
> btrfs/024 0s ...  0s
> btrfs/026 3s ...  3s
> btrfs/037 1s ...  1s
> btrfs/038 0s ...  1s
> btrfs/041 1s ...  0s
> btrfs/062 34s ...  34s
> btrfs/063 18s ...  18s
> btrfs/067 32s ...  30s
> btrfs/068 10s ...  10s
> btrfs/070       [not run] btrfs and this test needs 5 or more disks in SCRATCH_DEV_POOL
> btrfs/071       [not run] btrfs and this test needs 5 or more disks in SCRATCH_DEV_POOL
> btrfs/072 34s ...  34s
> btrfs/073 13s ...  17s
> btrfs/074 35s ...  33s
> btrfs/076 0s ...  1s
> btrfs/103 1s ...  0s
> btrfs/106 0s ...  1s
> btrfs/109 0s ...  0s
> btrfs/113 1s ...  0s
> btrfs/138 43s ... - output mismatch (see /usr/lib/xfstests/results//btrfs/138.out.bad)
>     --- tests/btrfs/138.out     2022-05-11 04:02:17.000000000 +0200
>     +++ /usr/lib/xfstests/results//btrfs/138.out.bad    2022-06-10 17:22:14.419547768 +0200
>     @@ -1,2 +1,3 @@
>      QA output created by 138
>     +Checksum mismatch for zstd (expected 4c99665eb952380c4c2c748a78be4f8a, got d41d8cd98f00b204e9800998ecf8427e)
>      Silence is golden
>     ...
>     (Run 'diff -u /usr/lib/xfstests/tests/btrfs/138.out /usr/lib/xfstests/results//btrfs/138.out.bad'  to see the entire diff)
> btrfs/149 1s ...  1s
> btrfs/183 0s ...  1s
> btrfs/205 2s ...  1s
> btrfs/234 2s ...  2s
> btrfs/246 0s ...  1s
> btrfs/251 1s ...  1s
> Ran: btrfs/024 btrfs/026 btrfs/037 btrfs/038 btrfs/041 btrfs/062 btrfs/063 btrfs/067 btrfs/068 btrfs/070 btrfs/071 btrfs/072 btrfs/073 btrfs/074 btrfs/076 btrfs/103 btrfs/106 btrfs/109 btrfs/113 btrfs/138 btrfs/149 btrfs/183 btrfs/205 btrfs/234 btrfs/246 btrfs/251
> Not run: btrfs/070 btrfs/071
> Failures: btrfs/138
> Failed 1 of 26 tests
> 
> tweed32:/usr/lib/xfstests # cat results/btrfs/138.out.bad 
> QA output created by 138
> Checksum mismatch for zstd (expected 4c99665eb952380c4c2c748a78be4f8a, got d41d8cd98f00b204e9800998ecf8427e)
> 
> tweed32:/usr/lib/xfstests # cat results/btrfs/138.full 
> btrfs-progs v5.17
> See http://btrfs.wiki.kernel.org for more information.
> 
> Performing full device TRIM /dev/loop1 (12.00GiB) ...
> NOTE: several default settings have changed in version 5.15, please make sure
>       this does not affect your deployments:
>       - DUP for metadata (-m dup)
>       - enabled no-holes (-O no-holes)
>       - enabled free-space-tree (-R free-space-tree)
> 
> Label:              (null)
> UUID:               06e21efe-2454-4d0c-ab80-f226320e1544
> Node size:          16384
> Sector size:        4096
> Filesystem size:    12.00GiB
> Block group profiles:
>   Data:             single            8.00MiB
>   Metadata:         DUP             256.00MiB
>   System:           DUP               8.00MiB
> SSD detected:       no
> Zoned device:       no
> Incompat features:  extref, skinny-metadata, no-holes
> Runtime features:   free-space-tree
> Checksum:           crc32c
> Number of devices:  1
> Devices:
>    ID        SIZE  PATH
>     1    12.00GiB  /dev/loop1
> 
> 100+0 records in
> 100+0 records out
> Testing zlib
> 100+0 records in
> 100+0 records out
> Testing lzo
> 100+0 records in
> 100+0 records out
> Testing zstd
> dd: error reading '/mnt/scratch/zstd': Input/output error
> 0+0 records in
> 0+0 records out
> 
> tweed32:/usr/lib/xfstests # cat results/btrfs/138.dmesg 
> [ 1286.929283] run fstests btrfs/138 at 2022-06-10 17:21:30
> [ 1287.090289] BTRFS info (device loop0): flagging fs with big metadata feature
> [ 1287.090292] BTRFS info (device loop0): using free space tree
> [ 1287.090293] BTRFS info (device loop0): has skinny extents
> [ 1287.215036] BTRFS: device fsid 06e21efe-2454-4d0c-ab80-f226320e1544 devid 1 transid 6 /dev/loop1 scanned by mkfs.btrfs (19573)
> [ 1287.226730] BTRFS info (device loop1): flagging fs with big metadata feature
> [ 1287.226733] BTRFS info (device loop1): using free space tree
> [ 1287.226735] BTRFS info (device loop1): has skinny extents
> [ 1287.228967] BTRFS info (device loop1): checking UUID tree
> [ 1321.763502] BTRFS info (device loop1): flagging fs with big metadata feature
> [ 1321.763506] BTRFS info (device loop1): using free space tree
> [ 1321.763506] BTRFS info (device loop1): has skinny extents
> [ 1321.779751] BTRFS info (device loop1): setting incompat feature flag for COMPRESS_LZO (0x8)
> [ 1325.730614] BTRFS info (device loop1): flagging fs with big metadata feature
> [ 1325.730617] BTRFS info (device loop1): using free space tree
> [ 1325.730618] BTRFS info (device loop1): has skinny extents
> [ 1325.748761] BTRFS info (device loop1): setting incompat feature flag for COMPRESS_ZSTD (0x10)
> [ 1330.663239] BTRFS info (device loop1): flagging fs with big metadata feature
> [ 1330.663243] BTRFS info (device loop1): using free space tree
> [ 1330.663245] BTRFS info (device loop1): has skinny extents
> [ 1330.813468] BTRFS info (device loop1): flagging fs with big metadata feature
> [ 1330.813471] BTRFS info (device loop1): using free space tree
> [ 1330.813472] BTRFS info (device loop1): has skinny extents
> 
>  fs/btrfs/zstd.c | 41 ++++++++++++++++++++++-------------------
>  1 file changed, 22 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
> index 0fe31a6f6e68..ccfc098319fd 100644
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
> @@ -603,14 +606,14 @@ int zstd_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
>  			break;
>  
>  		if (workspace->in_buf.pos == workspace->in_buf.size) {
> -			kunmap(pages_in[page_in_index++]);
> +			kunmap_local((void *)workspace->in_buf.src);

I haven't tried the patch, but from a quick glance at the diff, one
clear problem is that page_in_index is no longer incremented anywhere.

That's probably the reason why the test fails when trying to read the
file (decompress).


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
> @@ -619,7 +622,7 @@ int zstd_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
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
> 
