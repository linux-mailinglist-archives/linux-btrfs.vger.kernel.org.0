Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6F406A8CFA
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Mar 2023 00:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjCBX0e (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 18:26:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjCBX0d (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 18:26:33 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75C01EBF1
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Mar 2023 15:26:31 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MhD2Y-1qC91G2ejS-00eJKd; Fri, 03
 Mar 2023 00:26:25 +0100
Message-ID: <8a4be689-7ffe-896d-0d73-b5d5d5c32bd9@gmx.com>
Date:   Fri, 3 Mar 2023 07:26:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 04/10] btrfs: pass a btrfs_bio to btrfs_submit_bio
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20230301134244.1378533-1-hch@lst.de>
 <20230301134244.1378533-5-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230301134244.1378533-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:lMWCJmxKcAJyLQolbenN3b8OFmchD+m0U03l4CCs/uNkISNHxj/
 3a9iwhaszudMGXAON20XtKbsuVvzhKKry2VHqZwv1ynqkPKG7cszHkKp5etrOjrASEU6bXc
 LgfAvw7MRQUY2gaEoOCn1peFdoWcgPvdw0tB8zGgRTRytweXQomb8prZGy0qr3Wz8KwdJF3
 ftouuDjtYBLmt9mEqP6RA==
UI-OutboundReport: notjunk:1;M01:P0:hszJPL9OOzE=;L7Y8+Nw5w5hh94bkIcSo27iABgT
 PC9oBlVkBJN1aXy8pf2m609kG1CBVj/c50JRJc82Mf7vzjQABJrcvU8UlwR3gxumeOSEIUX+P
 SS6je8sYJyCa5BtYKg60llWchm4ZtoKE80TzUm4PiDSeLtL+eSJF1ikTEN7NfV/2vfPXfMkiQ
 EsB0IWiNds8ylAugK7iFrO/SsXl8P+2/8CBZN59RdFvxUxgbzTWEKP2a9CwhhLGqZCiecE77c
 JXX6GsD+KvTz2yfyx1ZVC4upLL8xq3ukVuv6wCzJ9YMIiuxyitHGRYAvOIYMJoLoSjWG0TbSv
 7+jHN0S2omxBVTP/+hA7eUgsXfJ1EfHDson/RTyH7heuP2L5TCBW1vt6iQWxoYHLC68E9fzCm
 dUmbyANY2oGMoHIN8gOHKKsMkpt2W8If4vPTl1oyrwTjC+zXhHozTVj1rb2lhaPXzvmWgAdVN
 wEGeb9w/4NE4JHlOSIdmUmXU7vu8E7uu/ntsVls9q6LqWdbe7NtJNBTn07Jicuv/uM3SKIBD3
 BDqrQF7GgFAYYmaYWKjek6q9TnYCRWiK2lyWy2hjh/I6E9Q8d+BT7YpQIrNqj1IivA0NmKpj2
 oo6alhwPV4RL9uDytfzV1Ll673P69vE7C1pWW7WbhegvpjocZALMoMKR+aRAS8D9kIpwlUcmf
 N26d1wEJTjDTYH/69epcyINhGEDyXxBFM6oqtiJy1OfHN0I+1VOnSvpkilF+Sr7/5GLxFVnG3
 Ec6El6uACO5F8joJlCFV2UAzqYpqYuG0FqCMdMjOyXqNNYx7XFO6AVk8H0V/+eESdk2Xll3Qm
 5TAWLBqyP1NN95wXTk0MqqeEKI/Zcel0YcW0IntcdXF4J+du8TplOk5M/EGm7aR5gfmft5SC+
 4KxbTNw8gYSWGN30HzLfPBitFpvCQT78+db0lsfmgUKj1oIbXsrTBgEPKXUUW6b8MMrJ/rmGU
 v5yfSMpgh8c+yH2VPdkNDog7hwY=
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/1 21:42, Christoph Hellwig wrote:
> btrfs_submit_bio expects the bio passed to it to be embedded into a
> btrfs_bio structure.  Pass the btrfs_bio directly to inrease type
> safety and make the code self-documenting.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/bio.c         | 14 +++++++-------
>   fs/btrfs/bio.h         |  2 +-
>   fs/btrfs/compression.c |  4 ++--
>   fs/btrfs/extent_io.c   |  2 +-
>   fs/btrfs/inode.c       |  6 +++---
>   5 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> index 726592868e9c5c..c04e103f876853 100644
> --- a/fs/btrfs/bio.c
> +++ b/fs/btrfs/bio.c
> @@ -164,7 +164,7 @@ static void btrfs_end_repair_bio(struct btrfs_bio *repair_bbio,
>   			goto done;
>   		}
>   
> -		btrfs_submit_bio(&repair_bbio->bio, mirror);
> +		btrfs_submit_bio(repair_bbio, mirror);
>   		return;
>   	}
>   
> @@ -232,7 +232,7 @@ static struct btrfs_failed_bio *repair_one_sector(struct btrfs_bio *failed_bbio,
>   
>   	mirror = next_repair_mirror(fbio, failed_bbio->mirror_num);
>   	btrfs_debug(fs_info, "submitting repair read to mirror %d", mirror);
> -	btrfs_submit_bio(repair_bio, mirror);
> +	btrfs_submit_bio(repair_bbio, mirror);
>   	return fbio;
>   }
>   
> @@ -603,12 +603,12 @@ static bool btrfs_wq_submit_bio(struct btrfs_bio *bbio,
>   	return true;
>   }
>   
> -static bool btrfs_submit_chunk(struct bio *bio, int mirror_num)
> +static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
>   {
> -	struct btrfs_bio *bbio = btrfs_bio(bio);
>   	struct btrfs_inode *inode = bbio->inode;
>   	struct btrfs_fs_info *fs_info = inode->root->fs_info;
>   	struct btrfs_bio *orig_bbio = bbio;
> +	struct bio *bio = &bbio->bio;
>   	u64 logical = bio->bi_iter.bi_sector << 9;
>   	u64 length = bio->bi_iter.bi_size;
>   	u64 map_length = length;
> @@ -650,7 +650,7 @@ static bool btrfs_submit_chunk(struct bio *bio, int mirror_num)
>   		if (use_append) {
>   			bio->bi_opf &= ~REQ_OP_WRITE;
>   			bio->bi_opf |= REQ_OP_ZONE_APPEND;
> -			ret = btrfs_extract_ordered_extent(btrfs_bio(bio));
> +			ret = btrfs_extract_ordered_extent(bbio);
>   			if (ret)
>   				goto fail_put_bio;
>   		}
> @@ -686,9 +686,9 @@ static bool btrfs_submit_chunk(struct bio *bio, int mirror_num)
>   	return true;
>   }
>   
> -void btrfs_submit_bio(struct bio *bio, int mirror_num)
> +void btrfs_submit_bio(struct btrfs_bio *bbio, int mirror_num)
>   {
> -	while (!btrfs_submit_chunk(bio, mirror_num))
> +	while (!btrfs_submit_chunk(bbio, mirror_num))
>   		;
>   }
>   
> diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
> index 873ff85817f0b2..b4e7d5ab7d236d 100644
> --- a/fs/btrfs/bio.h
> +++ b/fs/btrfs/bio.h
> @@ -88,7 +88,7 @@ static inline void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_status_t status)
>   /* Bio only refers to one ordered extent. */
>   #define REQ_BTRFS_ONE_ORDERED			REQ_DRV
>   
> -void btrfs_submit_bio(struct bio *bio, int mirror_num);
> +void btrfs_submit_bio(struct btrfs_bio *bbio, int mirror_num);
>   int btrfs_repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
>   			    u64 length, u64 logical, struct page *page,
>   			    unsigned int pg_offset, int mirror_num);
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 64c804dc3962f6..27bea05cab1a1b 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -333,7 +333,7 @@ void btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
>   	cb->nr_pages = nr_pages;
>   
>   	btrfs_add_compressed_bio_pages(cb, disk_start);
> -	btrfs_submit_bio(&cb->bbio.bio, 0);
> +	btrfs_submit_bio(&cb->bbio, 0);
>   
>   	if (blkcg_css)
>   		kthread_associate_blkcg(NULL);
> @@ -565,7 +565,7 @@ void btrfs_submit_compressed_read(struct bio *bio, int mirror_num)
>   	if (memstall)
>   		psi_memstall_leave(&pflags);
>   
> -	btrfs_submit_bio(&cb->bbio.bio, mirror_num);
> +	btrfs_submit_bio(&cb->bbio, mirror_num);
>   	return;
>   
>   out_free_compressed_pages:
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index d53bd452b9ec30..77de129db364c9 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -157,7 +157,7 @@ static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
>   	    bio_ctrl->compress_type != BTRFS_COMPRESS_NONE)
>   		btrfs_submit_compressed_read(bio, mirror_num);
>   	else
> -		btrfs_submit_bio(bio, mirror_num);
> +		btrfs_submit_bio(btrfs_bio(bio), mirror_num);
>   
>   	/* The bio is owned by the end_io handler now */
>   	bio_ctrl->bio = NULL;
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 431b6082ab3d83..ed96c84f5be71d 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -7787,7 +7787,7 @@ static void btrfs_dio_submit_io(const struct iomap_iter *iter, struct bio *bio,
>   	dip->bytes = bio->bi_iter.bi_size;
>   
>   	dio_data->submitted += bio->bi_iter.bi_size;
> -	btrfs_submit_bio(bio, 0);
> +	btrfs_submit_bio(bbio, 0);
>   }
>   
>   static const struct iomap_ops btrfs_dio_iomap_ops = {
> @@ -9972,7 +9972,7 @@ int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
>   
>   		if (bio_add_page(bio, pages[i], bytes, 0) < bytes) {
>   			atomic_inc(&priv.pending);
> -			btrfs_submit_bio(bio, 0);
> +			btrfs_submit_bio(btrfs_bio(bio), 0);
>   
>   			bio = btrfs_bio_alloc(BIO_MAX_VECS, REQ_OP_READ, inode,
>   					      btrfs_encoded_read_endio, &priv);
> @@ -9986,7 +9986,7 @@ int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
>   	} while (disk_io_size);
>   
>   	atomic_inc(&priv.pending);
> -	btrfs_submit_bio(bio, 0);
> +	btrfs_submit_bio(btrfs_bio(bio), 0);
>   
>   	if (atomic_dec_return(&priv.pending))
>   		io_wait_event(priv.wait, !atomic_read(&priv.pending));
