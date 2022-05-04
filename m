Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5DD519FB7
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 May 2022 14:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349842AbiEDMmS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 May 2022 08:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349812AbiEDMmL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 May 2022 08:42:11 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BB532066
        for <linux-btrfs@vger.kernel.org>; Wed,  4 May 2022 05:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1651667908;
        bh=BdGzXm0N4qSkw57MHvsaRzcbTV1mDUW5EWMrKYVmgeg=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=eX+nL365hdlTwVhSwV6SpjEdQKZGoI3gFWC3yxiMosCvjVzENpZ7d3zXrz9fOAC0b
         umA/z8as9CrnqlvSw7Vjld1JBJW8RtzYQP/nDGHaRqrA0bDV349lNPpebq7iMZgXAI
         h9vzsWj2y6PIcPTvMmJcbjrT26UjYewiN6q1AIvM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MKbkC-1nXsFj3RSm-00Kw4G; Wed, 04
 May 2022 14:38:28 +0200
Message-ID: <4b4e9991-3c1b-6758-3e1d-c6aafac61c13@gmx.com>
Date:   Wed, 4 May 2022 20:38:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 04/10] btrfs: split btrfs_submit_data_bio
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20220504122524.558088-1-hch@lst.de>
 <20220504122524.558088-5-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220504122524.558088-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dAHbqlB+44h3Qb00pTq04bQmfadxFNeN6dZ0ZJWAJSJCq47tbLk
 6Fx/AWopUkX3HwdbnDsC03nOdVF/uvlubQdVlqgVRfXIAmM3CyFNRQhR32qmZUy3e4FP3pq
 cbSmgqSjBe3ZVGOUDvxwBNbtJnucSpn88IV2Z+nc8an4hoWqZuebqnRIP6HIf5avwvbTVN8
 I+56q0Q1CjJ+lQFg/hIzQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/u5aimu7P80=:Wg3aJYcF8FCb3jsSJ8/P5W
 dRYaMqyxXExD9dRkNAJKm4e1Cy930tu3IXPf3sqkqFTrdjU0ZuMMljeQ+AnL3wJwWW4Y+Hi01
 t+NGTda014hkAJnA/C9xlhy1Ru0ExVw9nCBVHqGX5yb/X5Gv505wTRN18q7NZVR6A6dFAUeLA
 exRvUne/ZsaOinI0FPKkEVukQu7ERtVpqyhHCEP8f0niyULl5eTl9vbiXFm+RZ7j0WXrTEE9f
 soE/dcGe5rMFcVtdVZRt6cc26MeuxOX1cpwe1KL3CZKBORAyRSi/rXrFF+6gac/3HpHMgZ1EH
 kjbNzHw7h37Jf6wq+977bsD+mXqHOsi9ie5vb4wswWhiTa0XWOKz/RgyNWMwWWa0a0OgA5Ld9
 C6GKpP8l0WGMwFF6R8N+nnrz+ZuhCqQLVGlBDAlc1rPQrBOA1MRGLsvkLKHKNcQ1Rf2Lc3DMS
 7IyijFPDkhcZBNEWSv3KPyZiX9lDUFoB5LkL3oF1jTFnUvqJUGlY0D7HnxyLQYVpk67yFJFya
 M5IlvGw1FtRg37LZ/vVmWGtWO//Bb/znAh9cQ0kNCNW8Gtwt6PfK4oYUaWiLHjeH5emLcP2QG
 AR5nH9qmYVBdV4Rl9IqbC8fShy0KXLGcSmF19TwoaUsIUeBNYo6+jFvjTxwV0RP5nVAW8n14H
 sj03n7/G7wcOJ/9fVKf4ZDYTT6MGbdVb8Kxsgnp6EU2FIGGlgpxL0Y3EkJbBrq+CayT/OJQPQ
 Bww3ehGpcVLJNpdkFE8OjiCkrrvW14GLGbVqlsFKCDsoEDfq12OzonWkH7MVrK+Ns+IUq5D2x
 WyAUxPQpyAW9Un9Y8NM0d/LphDpjpQcYEOwl+2qmig1zVGLLYPNj6dN04VL+LyH1VrnxBldA1
 FF4rNHo4CckzWCP2LkAQwpC4/lB+FS8Xox1S4hr4QvpG1dxqZou0S883poZuBISIXPafUruDN
 1jqY5/Gj9slSCGeUUblGGS9AXRBmrLn+kK0rNhP8zdiCdeKoZA7hZ1Vr3+tMMM8/9OX+QY8Ed
 R3dp2/Ovxn1H/DPqMQGp2rWVvQxGrVmSLEH5c9iRtOUoXjA+BgNxY/s7OQ1WYJ0+R6BgB9y31
 CmPtRxgNNUM13w=
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
> Split btrfs_submit_data_bio into one helper for reads and one for writes=
.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/btrfs/ctree.h     |   6 +-
>   fs/btrfs/extent_io.c |  14 +++--
>   fs/btrfs/inode.c     | 134 ++++++++++++++++++++-----------------------
>   3 files changed, 76 insertions(+), 78 deletions(-)
>
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 6e939bf01dcc3..6f539ddf7467a 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -3251,8 +3251,10 @@ void btrfs_inode_safe_disk_i_size_write(struct bt=
rfs_inode *inode, u64 new_i_siz
>   u64 btrfs_file_extent_end(const struct btrfs_path *path);
>
>   /* inode.c */
> -void btrfs_submit_data_bio(struct inode *inode, struct bio *bio,
> -			   int mirror_num, enum btrfs_compression_type compress_type);
> +void btrfs_submit_data_write_bio(struct inode *inode, struct bio *bio,
> +		int mirror_num);
> +void btrfs_submit_data_read_bio(struct inode *inode, struct bio *bio,
> +		int mirror_num, enum btrfs_compression_type compress_type);
>   unsigned int btrfs_verify_data_csum(struct btrfs_bio *bbio,
>   				    u32 bio_offset, struct page *page,
>   				    u64 start, u64 end);
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 1b1baeb0d76bc..1394a6f80d285 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -182,17 +182,21 @@ static void submit_one_bio(struct bio *bio, int mi=
rror_num,
>   			   enum btrfs_compression_type compress_type)
>   {
>   	struct extent_io_tree *tree =3D bio->bi_private;
> +	struct inode *inode =3D tree->private_data;

I guess we shouldn't use the extent_io_tree for bio->bi_private at all
if we're just tring to grab an inode.

In fact, for all submit_one_bio() callers, we are handling buffered
read/write, thus we can grab inode using
bio_first_page_all(bio)->mapping->host.

No need for such weird io_tree based dance.

>
>   	bio->bi_private =3D NULL;
>
>   	/* Caller should ensure the bio has at least some range added */
>   	ASSERT(bio->bi_iter.bi_size);
>
> -	if (is_data_inode(tree->private_data))
> -		btrfs_submit_data_bio(tree->private_data, bio, mirror_num,
> -					    compress_type);
> +	if (!is_data_inode(tree->private_data))
> +		btrfs_submit_metadata_bio(inode, bio, mirror_num);

Can we just call btrfs_submit_metadata_bio() and return?

Every time I see an "if () else if ()", I can't stop thinking if we have
some corner cases not taken into consideration.

Thanks,
Qu

> +	else if (btrfs_op(bio) =3D=3D BTRFS_MAP_WRITE)
> +		btrfs_submit_data_write_bio(inode, bio, mirror_num);
>   	else
> -		btrfs_submit_metadata_bio(tree->private_data, bio, mirror_num);
> +		btrfs_submit_data_read_bio(inode, bio, mirror_num,
> +					   compress_type);
> +
>   	/*
>   	 * Above submission hooks will handle the error by ending the bio,
>   	 * which will do the cleanup properly.  So here we should not return
> @@ -2774,7 +2778,7 @@ static blk_status_t submit_data_read_repair(struct=
 inode *inode,
>   		ret =3D btrfs_repair_one_sector(inode, failed_bio,
>   				bio_offset + offset,
>   				page, pgoff + offset, start + offset,
> -				failed_mirror, btrfs_submit_data_bio);
> +				failed_mirror, btrfs_submit_data_read_bio);
>   		if (!ret) {
>   			/*
>   			 * We have submitted the read repair, the page release
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index b98f5291e941c..5499b39cab61b 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -2554,90 +2554,82 @@ static blk_status_t extract_ordered_extent(struc=
t btrfs_inode *inode,
>   	return errno_to_blk_status(ret);
>   }
>
> -/*
> - * extent_io.c submission hook. This does the right thing for csum calc=
ulation
> - * on write, or reading the csums from the tree before a read.
> - *
> - * Rules about async/sync submit,
> - * a) read:				sync submit
> - *
> - * b) write without checksum:		sync submit
> - *
> - * c) write with checksum:
> - *    c-1) if bio is issued by fsync:	sync submit
> - *         (sync_writers !=3D 0)
> - *
> - *    c-2) if root is reloc root:	sync submit
> - *         (only in case of buffered IO)
> - *
> - *    c-3) otherwise:			async submit
> - */
> -void btrfs_submit_data_bio(struct inode *inode, struct bio *bio,
> -			   int mirror_num, enum btrfs_compression_type compress_type)
> +void btrfs_submit_data_write_bio(struct inode *inode, struct bio *bio,
> +		int mirror_num)
>   {
>   	struct btrfs_fs_info *fs_info =3D btrfs_sb(inode->i_sb);
> -	struct btrfs_root *root =3D BTRFS_I(inode)->root;
> -	enum btrfs_wq_endio_type metadata =3D BTRFS_WQ_ENDIO_DATA;
> -	blk_status_t ret =3D 0;
> -	int skip_sum;
> -	int async =3D !atomic_read(&BTRFS_I(inode)->sync_writers);
> -
> -	skip_sum =3D (BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM) ||
> -		test_bit(BTRFS_FS_STATE_NO_CSUMS, &fs_info->fs_state);
> -
> -	if (btrfs_is_free_space_inode(BTRFS_I(inode)))
> -		metadata =3D BTRFS_WQ_ENDIO_FREE_SPACE;
> +	struct btrfs_inode *bi =3D BTRFS_I(inode);
> +	blk_status_t ret;
>
>   	if (bio_op(bio) =3D=3D REQ_OP_ZONE_APPEND) {
> -		struct page *page =3D bio_first_bvec_all(bio)->bv_page;
> -		loff_t file_offset =3D page_offset(page);
> -
> -		ret =3D extract_ordered_extent(BTRFS_I(inode), bio, file_offset);
> +		ret =3D extract_ordered_extent(bi, bio,
> +				page_offset(bio_first_bvec_all(bio)->bv_page));
>   		if (ret)
>   			goto out;
>   	}
>
> -	if (btrfs_op(bio) !=3D BTRFS_MAP_WRITE) {
> -		if (compress_type !=3D BTRFS_COMPRESS_NONE) {
> -			/*
> -			 * btrfs_submit_compressed_read will handle completing
> -			 * the bio if there were any errors, so just return
> -			 * here.
> -			 */
> -			btrfs_submit_compressed_read(inode, bio, mirror_num);
> -			return;
> -		} else {
> -			ret =3D btrfs_bio_wq_end_io(fs_info, bio, metadata);
> -			if (ret)
> -				goto out;
> -
> -			/*
> -			 * Lookup bio sums does extra checks around whether we
> -			 * need to csum or not, which is why we ignore skip_sum
> -			 * here.
> -			 */
> -			ret =3D btrfs_lookup_bio_sums(inode, bio, NULL);
> +	/*
> +	 * Rules for async/sync submit:
> +	 *   a) write without checksum:			sync submit
> +	 *   b) write with checksum:
> +	 *      b-1) if bio is issued by fsync:		sync submit
> +	 *           (sync_writers !=3D 0)
> +	 *      b-2) if root is reloc root:		sync submit
> +	 *           (only in case of buffered IO)
> +	 *      b-3) otherwise:				async submit
> +	 */
> +	if (!(bi->flags & BTRFS_INODE_NODATASUM) &&
> +	    !test_bit(BTRFS_FS_STATE_NO_CSUMS, &fs_info->fs_state)) {
> +		if (atomic_read(&bi->sync_writers)) {
> +			ret =3D btrfs_csum_one_bio(bi, bio, (u64)-1, false);
>   			if (ret)
>   				goto out;
> -		}
> -		goto mapit;
> -	} else if (async && !skip_sum) {
> -		/* csum items have already been cloned */
> -		if (btrfs_is_data_reloc_root(root))
> -			goto mapit;
> -		/* we're doing a write, do the async checksumming */
> -		ret =3D btrfs_wq_submit_bio(inode, bio, mirror_num,
> -					  0, btrfs_submit_bio_start);
> -		goto out;
> -	} else if (!skip_sum) {
> -		ret =3D btrfs_csum_one_bio(BTRFS_I(inode), bio, (u64)-1, false);
> -		if (ret)
> +		} else if (btrfs_is_data_reloc_root(bi->root)) {
> +			; /* csum items have already been cloned */
> +		} else {
> +			ret =3D btrfs_wq_submit_bio(inode, bio,
> +					mirror_num, 0,
> +					btrfs_submit_bio_start);
>   			goto out;
> +		}
>   	}
> -
> -mapit:
>   	ret =3D btrfs_map_bio(fs_info, bio, mirror_num);
> +out:
> +	if (ret) {
> +		bio->bi_status =3D ret;
> +		bio_endio(bio);
> +	}
> +}
>
> +void btrfs_submit_data_read_bio(struct inode *inode, struct bio *bio,
> +		int mirror_num, enum btrfs_compression_type compress_type)
> +{
> +	struct btrfs_fs_info *fs_info =3D btrfs_sb(inode->i_sb);
> +	blk_status_t ret;
> +
> +	if (compress_type !=3D BTRFS_COMPRESS_NONE) {
> +		/*
> +		 * btrfs_submit_compressed_read will handle completing the bio
> +		 * if there were any errors, so just return here.
> +		 */
> +		btrfs_submit_compressed_read(inode, bio, mirror_num);
> +		return;
> +	}
> +
> +	ret =3D btrfs_bio_wq_end_io(fs_info, bio,
> +			btrfs_is_free_space_inode(BTRFS_I(inode)) ?
> +			BTRFS_WQ_ENDIO_FREE_SPACE : BTRFS_WQ_ENDIO_DATA);
> +	if (ret)
> +		goto out;
> +
> +	/*
> +	 * Lookup bio sums does extra checks around whether we need to csum or
> +	 * not, which is why we ignore skip_sum here.
> +	 */
> +	ret =3D btrfs_lookup_bio_sums(inode, bio, NULL);
> +	if (ret)
> +		goto out;
> +	ret =3D btrfs_map_bio(fs_info, bio, mirror_num);
>   out:
>   	if (ret) {
>   		bio->bi_status =3D ret;
> @@ -7958,7 +7950,7 @@ static inline blk_status_t btrfs_submit_dio_bio(st=
ruct bio *bio,
>   		goto map;
>
>   	if (write) {
> -		/* check btrfs_submit_data_bio() for async submit rules */
> +		/* check btrfs_submit_data_write_bio() for async submit rules */
>   		if (async_submit && !atomic_read(&BTRFS_I(inode)->sync_writers))
>   			return btrfs_wq_submit_bio(inode, bio, 0, file_offset,
>   					btrfs_submit_bio_start_direct_io);
