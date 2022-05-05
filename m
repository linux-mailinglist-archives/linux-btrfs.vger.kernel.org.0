Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C53F51B5FE
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 May 2022 04:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239543AbiEECiX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 May 2022 22:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239426AbiEECiW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 May 2022 22:38:22 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749B63120D
        for <linux-btrfs@vger.kernel.org>; Wed,  4 May 2022 19:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1651718079;
        bh=RUL5LF1u23TbOhjRY2g4ve1a+A4fKH7XZZfi+feG3zI=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=EmrFTZqVPW+J+lZSjxjMB0Sk1+L5AUfQAEu2mGBplZeGmNUBPFYKAEiVJeZqz32G8
         ecN7s0ndT4XxLZVQI3yIsSBeu53SbNI7sBlB0XeZa4Yd7eRU7zfL3KXGNF6rzpEdqZ
         QiLjvRVyUpj6GE48wvhzPXM3I2nsibo7Qe+899t0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MPokD-1nPfH31tdD-00MtFf; Thu, 05
 May 2022 04:34:39 +0200
Message-ID: <02e4d2a3-7e72-1b83-1005-fab13bf50931@gmx.com>
Date:   Thu, 5 May 2022 10:34:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20220504122524.558088-1-hch@lst.de>
 <20220504122524.558088-9-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 08/10] btrfs: remove btrfs_end_io_wq
In-Reply-To: <20220504122524.558088-9-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:z4AB/vcD1QHpvCib/eQhmsQiF8ULDWQXShBy03PCSWzXsBAiTz9
 J4SXiH3IQYrxcG4FLEhE7SP1ho6VlahFbGs3zIh7Tp9I1RjKFYwrL/RkRDSubHwdSPmxf2J
 T638eeUgijomWgESXBr2suhntGlXd0/Otvgqcv3cw2nn9kaMw6axY/2PlH2LH7zF3rp/x61
 4w0sAM00UZYael7Za/Mgw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6jXB3kV4KHY=:2ZFCnvQv7yfgTA9cGIzqr/
 sfASidYeyqYY5H/B5ENgYCPqOueCmhprUZSpcpU5kDCqZMFq4VYvNOJyjdfhuNv+bviMWY5zu
 2bQJUVY865a29BDpNAJ8hLewbLi5yHZB3/OHpacyX4MhS1R0ht8sFr/402IViyk1go/U2Em3N
 J9IseA6ATHg+fukExuK5vrW5rp8lwyIeAqrqnQa6STDGTkAIVHgrMQzmkqxbCnT9mkSFpuH6K
 aYTZ0EmM3PH01jCBPhgX2w2orJo95RVI1kcvQITcTR07pBODvf13taxg49abGvi0SsG56F6CC
 ver5/SplKkJK67pBHlLqNsNNgEfdWle4FqgK2vE9SL6tdC0eYlOp4I+cKJPIB3d2ar0IOfr3G
 BncbUkgK5z3QTe1EfqiWlaga9PTYhpOBMQ1CQqPD5vaCa3xZ+oTwjI2losRZOo00nLsVILOUw
 nJTTSWMY5sZlM3gDEWOMF/uCR3PGjwmnuK4r/msEjuHhMo8g/GAnSP1dCOGwKLL9IhaSydj1i
 OdTzUp7fdFE/YRHN16ktAZYZeOn+Zfu/tn6qivuW7pXSFzlArXU8cobZEJTIx4aXMzd6BOBr7
 ooDmi7aptVJuYpOXQOztZjkih3Vqq/day75zizHBhFFvXwRV5staAJLYKDSUAKgx6o9lWqjYj
 YaP8NME1h2RE5AxkKcD5WOX+mY6kEsSbxoZ51iQcsTgRSvDSorQ8qSYEhuoZ6SE/uZ8JTYK2O
 /RtrLy+vWzLqhQJv7O/5chL8JJ7L0877I4ot//j+6gZGEc/ZNEtSVVDonz+/mntMTpcApd9r4
 amXyOL/sBLC1gfuHDwBIpK5f4JJLJwTGHvjFhlCXF4nch8dpBLIpdCICBYkhE7ixqoaxhzaQM
 NBMHndyiJt29IZ6W0AfudCy1HnmL2DrTcFnwCtJT7npw20XY6pilfhwizgVnnv9CU0PvCOV1J
 WL/3iaEzHbeXzGh1mAa4Mc/8joQbs7p3QqqkgxZW+5WPpTyt/B5Jhw2AG5dr7BkSXafx+vw9D
 HT2y3MaKVkhcit00RFSlYsY37y7mQx0tH6F/G/jB5n8L11+qVWjxEjrBKHZKAgvdJ9B6TrKFE
 ZNBrLstViSV86U=
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/4 20:25, Christoph Hellwig wrote:
> All reads bio that go through btrfs_map_bio need to be completed in
> user context.  And read I/Os are the most common and timing critical
> in almost any file system workloads.

I did a quick search on other fses, it looks like it's a common pratice
to queue the work into the workqueue when the last one finished, other
than making everything happen in workqueue.
(One example, ext4 uses the same pattern for decrypt/verify work).

So I'm fine with the idea.
This specially speeds up most endios where they are just doing some
small atomic operations, which don't really need to happen in workqueue
context.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
>
> Embedd a work_struct into struct btrfs_bio and use it to complete all
> read bios submitted through btrfs_map, using the REQ_META flag to decide
> which workqueue they are placed on.
>
> This removes the need for a separate 128 byte allocation (typically
> rounded up to 192 bytes by slab) for all reads with a size increase
> of 24 bytes for struct btrfs_bio.  Future patches will reorgnize
> struct btrfs_bio to make use of this extra space for writes as well.
>
> (all sizes are based a on typical 64-bit non-debug build)
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/btrfs/compression.c |   4 --
>   fs/btrfs/ctree.h       |   4 +-
>   fs/btrfs/disk-io.c     | 120 +++--------------------------------------
>   fs/btrfs/disk-io.h     |  10 ----
>   fs/btrfs/inode.c       |  24 +--------
>   fs/btrfs/super.c       |  11 +---
>   fs/btrfs/volumes.c     |  33 ++++++++++--
>   fs/btrfs/volumes.h     |   3 ++
>   8 files changed, 42 insertions(+), 167 deletions(-)
>
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 9d5986a30a4a2..c73ee8ae070d7 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -938,10 +938,6 @@ void btrfs_submit_compressed_read(struct inode *ino=
de, struct bio *bio,
>   			sums +=3D fs_info->csum_size * nr_sectors;
>
>   			ASSERT(comp_bio->bi_iter.bi_size);
> -			ret =3D btrfs_bio_wq_end_io(fs_info, comp_bio,
> -						  BTRFS_WQ_ENDIO_DATA);
> -			if (ret)
> -				goto finish_cb;
>   			ret =3D btrfs_map_bio(fs_info, comp_bio, mirror_num);
>   			if (ret)
>   				goto finish_cb;
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 6cf699959286d..c839c3e77c21e 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -851,8 +851,8 @@ struct btrfs_fs_info {
>   	struct btrfs_workqueue *hipri_workers;
>   	struct btrfs_workqueue *delalloc_workers;
>   	struct btrfs_workqueue *flush_workers;
> -	struct btrfs_workqueue *endio_workers;
> -	struct btrfs_workqueue *endio_meta_workers;
> +	struct workqueue_struct *endio_workers;
> +	struct workqueue_struct *endio_meta_workers;
>   	struct workqueue_struct *endio_raid56_workers;
>   	struct workqueue_struct *rmw_workers;
>   	struct workqueue_struct *compressed_write_workers;
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 8fed801423504..1d9330443c716 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -50,7 +50,6 @@
>   				 BTRFS_SUPER_FLAG_METADUMP |\
>   				 BTRFS_SUPER_FLAG_METADUMP_V2)
>
> -static void end_workqueue_fn(struct btrfs_work *work);
>   static void btrfs_destroy_ordered_extents(struct btrfs_root *root);
>   static int btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,
>   				      struct btrfs_fs_info *fs_info);
> @@ -63,40 +62,6 @@ static int btrfs_destroy_pinned_extent(struct btrfs_f=
s_info *fs_info,
>   static int btrfs_cleanup_transaction(struct btrfs_fs_info *fs_info);
>   static void btrfs_error_commit_super(struct btrfs_fs_info *fs_info);
>
> -/*
> - * btrfs_end_io_wq structs are used to do processing in task context wh=
en an IO
> - * is complete.  This is used during reads to verify checksums, and it =
is used
> - * by writes to insert metadata for new file extents after IO is comple=
te.
> - */
> -struct btrfs_end_io_wq {
> -	struct bio *bio;
> -	bio_end_io_t *end_io;
> -	void *private;
> -	struct btrfs_fs_info *info;
> -	blk_status_t status;
> -	enum btrfs_wq_endio_type metadata;
> -	struct btrfs_work work;
> -};
> -
> -static struct kmem_cache *btrfs_end_io_wq_cache;
> -
> -int __init btrfs_end_io_wq_init(void)
> -{
> -	btrfs_end_io_wq_cache =3D kmem_cache_create("btrfs_end_io_wq",
> -					sizeof(struct btrfs_end_io_wq),
> -					0,
> -					SLAB_MEM_SPREAD,
> -					NULL);
> -	if (!btrfs_end_io_wq_cache)
> -		return -ENOMEM;
> -	return 0;
> -}
> -
> -void __cold btrfs_end_io_wq_exit(void)
> -{
> -	kmem_cache_destroy(btrfs_end_io_wq_cache);
> -}
> -
>   static void btrfs_free_csum_hash(struct btrfs_fs_info *fs_info)
>   {
>   	if (fs_info->csum_shash)
> @@ -739,48 +704,6 @@ int btrfs_validate_metadata_buffer(struct btrfs_bio=
 *bbio,
>   	return ret;
>   }
>
> -static void end_workqueue_bio(struct bio *bio)
> -{
> -	struct btrfs_end_io_wq *end_io_wq =3D bio->bi_private;
> -	struct btrfs_fs_info *fs_info;
> -	struct btrfs_workqueue *wq;
> -
> -	fs_info =3D end_io_wq->info;
> -	end_io_wq->status =3D bio->bi_status;
> -
> -	if (end_io_wq->metadata)
> -		wq =3D fs_info->endio_meta_workers;
> -	else
> -		wq =3D fs_info->endio_workers;
> -
> -	btrfs_init_work(&end_io_wq->work, end_workqueue_fn, NULL, NULL);
> -	btrfs_queue_work(wq, &end_io_wq->work);
> -}
> -
> -blk_status_t btrfs_bio_wq_end_io(struct btrfs_fs_info *info, struct bio=
 *bio,
> -			enum btrfs_wq_endio_type metadata)
> -{
> -	struct btrfs_end_io_wq *end_io_wq;
> -
> -	if (WARN_ON_ONCE(btrfs_op(bio) !=3D BTRFS_MAP_WRITE))
> -		return BLK_STS_IOERR;
> -
> -	end_io_wq =3D kmem_cache_alloc(btrfs_end_io_wq_cache, GFP_NOFS);
> -	if (!end_io_wq)
> -		return BLK_STS_RESOURCE;
> -
> -	end_io_wq->private =3D bio->bi_private;
> -	end_io_wq->end_io =3D bio->bi_end_io;
> -	end_io_wq->info =3D info;
> -	end_io_wq->status =3D 0;
> -	end_io_wq->bio =3D bio;
> -	end_io_wq->metadata =3D metadata;
> -
> -	bio->bi_private =3D end_io_wq;
> -	bio->bi_end_io =3D end_workqueue_bio;
> -	return 0;
> -}
> -
>   static void run_one_async_start(struct btrfs_work *work)
>   {
>   	struct async_submit_bio *async;
> @@ -916,14 +839,7 @@ void btrfs_submit_metadata_bio(struct inode *inode,=
 struct bio *bio, int mirror_
>   	bio->bi_opf |=3D REQ_META;
>
>   	if (btrfs_op(bio) !=3D BTRFS_MAP_WRITE) {
> -		/*
> -		 * called for a read, do the setup so that checksum validation
> -		 * can happen in the async kernel threads
> -		 */
> -		ret =3D btrfs_bio_wq_end_io(fs_info, bio,
> -					  BTRFS_WQ_ENDIO_METADATA);
> -		if (!ret)
> -			ret =3D btrfs_map_bio(fs_info, bio, mirror_num);
> +		ret =3D btrfs_map_bio(fs_info, bio, mirror_num);
>   	} else if (!should_async_write(fs_info, BTRFS_I(inode))) {
>   		ret =3D btree_csum_one_bio(bio);
>   		if (!ret)
> @@ -1939,25 +1855,6 @@ struct btrfs_root *btrfs_get_fs_root_commit_root(=
struct btrfs_fs_info *fs_info,
>   	return root;
>   }
>
> -/*
> - * called by the kthread helper functions to finally call the bio end_i=
o
> - * functions.  This is where read checksum verification actually happen=
s
> - */
> -static void end_workqueue_fn(struct btrfs_work *work)
> -{
> -	struct bio *bio;
> -	struct btrfs_end_io_wq *end_io_wq;
> -
> -	end_io_wq =3D container_of(work, struct btrfs_end_io_wq, work);
> -	bio =3D end_io_wq->bio;
> -
> -	bio->bi_status =3D end_io_wq->status;
> -	bio->bi_private =3D end_io_wq->private;
> -	bio->bi_end_io =3D end_io_wq->end_io;
> -	bio_endio(bio);
> -	kmem_cache_free(btrfs_end_io_wq_cache, end_io_wq);
> -}
> -
>   static int cleaner_kthread(void *arg)
>   {
>   	struct btrfs_fs_info *fs_info =3D arg;
> @@ -2264,7 +2161,8 @@ static void btrfs_stop_all_workers(struct btrfs_fs=
_info *fs_info)
>   	btrfs_destroy_workqueue(fs_info->delalloc_workers);
>   	btrfs_destroy_workqueue(fs_info->hipri_workers);
>   	btrfs_destroy_workqueue(fs_info->workers);
> -	btrfs_destroy_workqueue(fs_info->endio_workers);
> +	if (fs_info->endio_workers)
> +		destroy_workqueue(fs_info->endio_workers);
>   	if (fs_info->endio_raid56_workers)
>   		destroy_workqueue(fs_info->endio_raid56_workers);
>   	if (fs_info->rmw_workers)
> @@ -2284,7 +2182,8 @@ static void btrfs_stop_all_workers(struct btrfs_fs=
_info *fs_info)
>   	 * the queues used for metadata I/O, since tasks from those other wor=
k
>   	 * queues can do metadata I/O operations.
>   	 */
> -	btrfs_destroy_workqueue(fs_info->endio_meta_workers);
> +	if (fs_info->endio_meta_workers)
> +		destroy_workqueue(fs_info->endio_meta_workers);
>   }
>
>   static void free_root_extent_buffers(struct btrfs_root *root)
> @@ -2457,15 +2356,10 @@ static int btrfs_init_workqueues(struct btrfs_fs=
_info *fs_info)
>   	fs_info->fixup_workers =3D
>   		btrfs_alloc_workqueue(fs_info, "fixup", flags, 1, 0);
>
> -	/*
> -	 * endios are largely parallel and should have a very
> -	 * low idle thresh
> -	 */
>   	fs_info->endio_workers =3D
> -		btrfs_alloc_workqueue(fs_info, "endio", flags, max_active, 4);
> +		alloc_workqueue("btrfs-endio", flags, max_active);
>   	fs_info->endio_meta_workers =3D
> -		btrfs_alloc_workqueue(fs_info, "endio-meta", flags,
> -				      max_active, 4);
> +		alloc_workqueue("btrfs-endio-meta", flags, max_active);
>   	fs_info->endio_raid56_workers =3D
>   		alloc_workqueue("btrfs-endio-raid56", flags, max_active);
>   	fs_info->rmw_workers =3D alloc_workqueue("btrfs-rmw", flags, max_acti=
ve);
> diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
> index 809ef065f1666..05e779a41a997 100644
> --- a/fs/btrfs/disk-io.h
> +++ b/fs/btrfs/disk-io.h
> @@ -17,12 +17,6 @@
>    */
>   #define BTRFS_BDEV_BLOCKSIZE	(4096)
>
> -enum btrfs_wq_endio_type {
> -	BTRFS_WQ_ENDIO_DATA,
> -	BTRFS_WQ_ENDIO_METADATA,
> -	BTRFS_WQ_ENDIO_FREE_SPACE,
> -};
> -
>   static inline u64 btrfs_sb_offset(int mirror)
>   {
>   	u64 start =3D SZ_16K;
> @@ -120,8 +114,6 @@ int btrfs_buffer_uptodate(struct extent_buffer *buf,=
 u64 parent_transid,
>   			  int atomic);
>   int btrfs_read_extent_buffer(struct extent_buffer *buf, u64 parent_tra=
nsid,
>   			     int level, struct btrfs_key *first_key);
> -blk_status_t btrfs_bio_wq_end_io(struct btrfs_fs_info *info, struct bio=
 *bio,
> -			enum btrfs_wq_endio_type metadata);
>   blk_status_t btrfs_wq_submit_bio(struct inode *inode, struct bio *bio,
>   				 int mirror_num, u64 dio_file_offset,
>   				 extent_submit_bio_start_t *submit_bio_start);
> @@ -144,8 +136,6 @@ int btree_lock_page_hook(struct page *page, void *da=
ta,
>   int btrfs_get_num_tolerated_disk_barrier_failures(u64 flags);
>   int btrfs_get_free_objectid(struct btrfs_root *root, u64 *objectid);
>   int btrfs_init_root_free_objectid(struct btrfs_root *root);
> -int __init btrfs_end_io_wq_init(void);
> -void __cold btrfs_end_io_wq_exit(void);
>
>   #ifdef CONFIG_DEBUG_LOCK_ALLOC
>   void btrfs_set_buffer_lockdep_class(u64 objectid,
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 5499b39cab61b..8195fd70633ab 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -2616,12 +2616,6 @@ void btrfs_submit_data_read_bio(struct inode *ino=
de, struct bio *bio,
>   		return;
>   	}
>
> -	ret =3D btrfs_bio_wq_end_io(fs_info, bio,
> -			btrfs_is_free_space_inode(BTRFS_I(inode)) ?
> -			BTRFS_WQ_ENDIO_FREE_SPACE : BTRFS_WQ_ENDIO_DATA);
> -	if (ret)
> -		goto out;
> -
>   	/*
>   	 * Lookup bio sums does extra checks around whether we need to csum o=
r
>   	 * not, which is why we ignore skip_sum here.
> @@ -7834,9 +7828,6 @@ static void submit_dio_repair_bio(struct inode *in=
ode, struct bio *bio,
>
>   	BUG_ON(bio_op(bio) =3D=3D REQ_OP_WRITE);
>
> -	if (btrfs_bio_wq_end_io(fs_info, bio, BTRFS_WQ_ENDIO_DATA))
> -		return;
> -
>   	refcount_inc(&dip->refs);
>   	if (btrfs_map_bio(fs_info, bio, mirror_num))
>   		refcount_dec(&dip->refs);
> @@ -7937,19 +7928,12 @@ static inline blk_status_t btrfs_submit_dio_bio(=
struct bio *bio,
>   {
>   	struct btrfs_fs_info *fs_info =3D btrfs_sb(inode->i_sb);
>   	struct btrfs_dio_private *dip =3D bio->bi_private;
> -	bool write =3D btrfs_op(bio) =3D=3D BTRFS_MAP_WRITE;
>   	blk_status_t ret;
>
> -	if (!write) {
> -		ret =3D btrfs_bio_wq_end_io(fs_info, bio, BTRFS_WQ_ENDIO_DATA);
> -		if (ret)
> -			return ret;
> -	}
> -
>   	if (BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)
>   		goto map;
>
> -	if (write) {
> +	if (btrfs_op(bio) =3D=3D BTRFS_MAP_WRITE) {
>   		/* check btrfs_submit_data_write_bio() for async submit rules */
>   		if (async_submit && !atomic_read(&BTRFS_I(inode)->sync_writers))
>   			return btrfs_wq_submit_bio(inode, bio, 0, file_offset,
> @@ -10298,12 +10282,6 @@ static blk_status_t submit_encoded_read_bio(str=
uct btrfs_inode *inode,
>   			return ret;
>   	}
>
> -	ret =3D btrfs_bio_wq_end_io(fs_info, bio, BTRFS_WQ_ENDIO_DATA);
> -	if (ret) {
> -		btrfs_bio_free_csum(bbio);
> -		return ret;
> -	}
> -
>   	atomic_inc(&priv->pending);
>   	ret =3D btrfs_map_bio(fs_info, bio, mirror_num);
>   	if (ret) {
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 9c683c466d585..64eb8aeed156f 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -1906,8 +1906,6 @@ static void btrfs_resize_thread_pool(struct btrfs_=
fs_info *fs_info,
>   	btrfs_workqueue_set_max(fs_info->hipri_workers, new_pool_size);
>   	btrfs_workqueue_set_max(fs_info->delalloc_workers, new_pool_size);
>   	btrfs_workqueue_set_max(fs_info->caching_workers, new_pool_size);
> -	btrfs_workqueue_set_max(fs_info->endio_workers, new_pool_size);
> -	btrfs_workqueue_set_max(fs_info->endio_meta_workers, new_pool_size);
>   	btrfs_workqueue_set_max(fs_info->endio_write_workers, new_pool_size);
>   	btrfs_workqueue_set_max(fs_info->endio_freespace_worker, new_pool_siz=
e);
>   	btrfs_workqueue_set_max(fs_info->delayed_workers, new_pool_size);
> @@ -2668,13 +2666,9 @@ static int __init init_btrfs_fs(void)
>   	if (err)
>   		goto free_delayed_ref;
>
> -	err =3D btrfs_end_io_wq_init();
> -	if (err)
> -		goto free_prelim_ref;
> -
>   	err =3D btrfs_interface_init();
>   	if (err)
> -		goto free_end_io_wq;
> +		goto free_prelim_ref;
>
>   	btrfs_print_mod_info();
>
> @@ -2690,8 +2684,6 @@ static int __init init_btrfs_fs(void)
>
>   unregister_ioctl:
>   	btrfs_interface_exit();
> -free_end_io_wq:
> -	btrfs_end_io_wq_exit();
>   free_prelim_ref:
>   	btrfs_prelim_ref_exit();
>   free_delayed_ref:
> @@ -2729,7 +2721,6 @@ static void __exit exit_btrfs_fs(void)
>   	extent_state_cache_exit();
>   	extent_io_exit();
>   	btrfs_interface_exit();
> -	btrfs_end_io_wq_exit();
>   	unregister_filesystem(&btrfs_fs_type);
>   	btrfs_exit_sysfs();
>   	btrfs_cleanup_fs_uuids();
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index aeacb87457687..5f18e9105fe08 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -6621,11 +6621,27 @@ int btrfs_map_sblock(struct btrfs_fs_info *fs_in=
fo, enum btrfs_map_op op,
>   	return __btrfs_map_block(fs_info, op, logical, length, bioc_ret, 0, 1=
);
>   }
>
> -static inline void btrfs_end_bioc(struct btrfs_io_context *bioc)
> +static struct workqueue_struct *btrfs_end_io_wq(struct btrfs_io_context=
 *bioc)
> +{
> +	if (bioc->orig_bio->bi_opf & REQ_META)
> +		return bioc->fs_info->endio_meta_workers;
> +	return bioc->fs_info->endio_workers;
> +}
> +
> +static void btrfs_end_bio_work(struct work_struct *work)
> +{
> +	struct btrfs_bio *bbio =3D
> +		container_of(work, struct btrfs_bio, end_io_work);
> +
> +	bio_endio(&bbio->bio);
> +}
> +
> +static void btrfs_end_bioc(struct btrfs_io_context *bioc, bool async)
>   {
>   	struct bio *orig_bio =3D bioc->orig_bio;
> +	struct btrfs_bio *bbio =3D btrfs_bio(orig_bio);
>
> -	btrfs_bio(orig_bio)->mirror_num =3D bioc->mirror_num;
> +	bbio->mirror_num =3D bioc->mirror_num;
>   	orig_bio->bi_private =3D bioc->private;
>   	orig_bio->bi_end_io =3D bioc->end_io;
>
> @@ -6637,7 +6653,14 @@ static inline void btrfs_end_bioc(struct btrfs_io=
_context *bioc)
>   		orig_bio->bi_status =3D BLK_STS_IOERR;
>   	else
>   		orig_bio->bi_status =3D BLK_STS_OK;
> -	bio_endio(orig_bio);
> +
> +	if (btrfs_op(orig_bio) =3D=3D BTRFS_MAP_READ && async) {
> +		INIT_WORK(&bbio->end_io_work, btrfs_end_bio_work);
> +		queue_work(btrfs_end_io_wq(bioc), &bbio->end_io_work);
> +	} else {
> +		bio_endio(orig_bio);
> +	}
> +
>   	btrfs_put_bioc(bioc);
>   }
>
> @@ -6669,7 +6692,7 @@ static void btrfs_end_bio(struct bio *bio)
>
>   	btrfs_bio_counter_dec(bioc->fs_info);
>   	if (atomic_dec_and_test(&bioc->stripes_pending))
> -		btrfs_end_bioc(bioc);
> +		btrfs_end_bioc(bioc, true);
>   }
>
>   static void submit_stripe_bio(struct btrfs_io_context *bioc, struct bi=
o *bio,
> @@ -6767,7 +6790,7 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info *f=
s_info, struct bio *bio,
>   		    !test_bit(BTRFS_DEV_STATE_WRITEABLE, &dev->dev_state))) {
>   			atomic_inc(&bioc->error);
>   			if (atomic_dec_and_test(&bioc->stripes_pending))
> -				btrfs_end_bioc(bioc);
> +				btrfs_end_bioc(bioc, false);
>   			continue;
>   		}
>
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 12b2af9260e92..28e28b7c48649 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -371,6 +371,9 @@ struct btrfs_bio {
>   	u8 csum_inline[BTRFS_BIO_INLINE_CSUM_SIZE];
>   	struct bvec_iter iter;
>
> +	/* for read end I/O handling */
> +	struct work_struct end_io_work;
> +
>   	/*
>   	 * This member must come last, bio_alloc_bioset will allocate enough
>   	 * bytes for entire btrfs_bio but relies on bio being last.
