Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 744B150DC37
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Apr 2022 11:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235393AbiDYJO5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Apr 2022 05:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241492AbiDYJOj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Apr 2022 05:14:39 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC236CABAB
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Apr 2022 02:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1650877883;
        bh=N1TA9tqbcXdCk8krJUVdk+3/eWj6A/jFiWxHBrlATaw=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=gW0nMNrpaJN9jtCY+jnbzwcVi46OIYMkJOVPnD350UmGixtimJomoDY3G1XVNrlwG
         BfOyHpCP3tdg49kSlipVF9asQ0VAn4Npza9eTPWKUk2Tf3ALU8q+SDIAyWlNSqRwpR
         p68UqKwOWGII+0k05JGmS6J6H2HOregIX0FTtdOA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MVeI8-1nHJD42biu-00RZyq; Mon, 25
 Apr 2022 11:11:23 +0200
Message-ID: <62f71a43-8167-f29f-8e9f-d95bc6667e0e@gmx.com>
Date:   Mon, 25 Apr 2022 17:11:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 03/10] btrfs: split btrfs_submit_data_bio
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
References: <20220425075418.2192130-1-hch@lst.de>
 <20220425075418.2192130-4-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220425075418.2192130-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KpSFL+xCbkN8GPG8aIjIMRsc/s3tlVliRLsJD8ARRIqKBuUYPSM
 5FUhY4rN2dyvpVw64e6xBmu/fwDbTJ/ckeib6HfXJIGQngQ60dM0kcUwtWBKkkPhgDTfnt3
 r8EMSMOMv1Q8tMCGc2VHYkSjwdq9aY1XtdLftVcMEbpYBJNvKhtqIv6KpxONCScD0G/M9SU
 aGm3lHfVn4lYF7NgNGoeg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9mDJY00z/zk=:CXCczpI5z5REVi5mg6dbVj
 s1EOcJovc/pId7SwJKJUhZIz/T8/0GPnXGIXifs3V41eYqvL2j/UNVl2jmhAG4O3unnFWZLYT
 gDfcWEvTH28mttItanbH2a5XBnk0bjBIpfWgKfXxvtzQpPX6MFNjXI/54OwqtIDu4ykrxBvRI
 lBXdedaRgeBG3pjD6lT00AwFFlOA238c/Fovjg6zB20CYG6XC+q/t44nEh4v7W78HNwqPVnVe
 mDlEKTuL1Gnmp6RkOggW9F+buiCLg/BVlvkaeOzSePlC97eQjbuzQHd6QK2ruhLdmnny3ILNg
 q8kL4X0D8Nrxro5dziANdxtXEBKnGXwGuLNN6LDDYDAjG3HmGZtlUQuVDtAzASv5P5pKLAu0F
 aapd6E0oCAeQClyTqMSQF6f8kV2o3HmfiJQ8tnG5OkTwCfH0kqg73cEqi7LUkGyU2AnDaySWg
 1he+oYpFAgaYDasZmtx/AmkVXS+Xw4K1z2+X5QbznMlPPwt1SMBjg/D988VInciQ+5R72gQfk
 voWp+yB0AKo9tW7ajRUx9kmKirdG+KsRZZhQF0g/a0x4beqTQl93D9FeomXfLrgS/kFv7yLqB
 ORaKIT5p93dFkkLqdIDmeohWni11445+Nut7PjOEg7yuyhWPaaS3nXN0yeA42XF6w5c8xstPa
 xjw19XmiISbvym1wNzGMmK5/Vg+lSA28L6k3tvCEUvmuHlX7tdqQKWUNYzkeMD2SW62iseER/
 4tlZtpPPqC5WJKg1tQJXZu7PFUE3QKjOSMCJ+ua9rU4DDlwSZKrvdJVR6GtyUTHoGzOkO9UGD
 echt0ZUC3c3o8e8SOQ9pe/9OEkXlXpfcg9PqM2zge7jhrbwTQTp2ewgt2DidaNypFm4foBytl
 ERB+IoQJXFTHpNKvxgBkxT17C9b/h7A7fYJ3u7QcJPzj2lwPpHJgP3i75wCuCjyp6FtqEihnH
 HBUynfcAXDVdYfEugEj+kUss6t8sXwV4vaj9bsnpnGhiHKgG3npUKuRkmgKy/tWvQ0/VKnnt2
 /o88iG8+0R91V6tAxRWBJkNKfwzwkDBllahBV1jJDJOo5EE8gIFqjgv2fT1d/BCKTq57hEiXy
 D6veIhZq4uLrUw=
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/4/25 15:54, Christoph Hellwig wrote:
> Split btrfs_submit_data_bio into one helper for reads and one for writes=
.

If we're splitting the bio mapping, wouldn't it be better to split by
read/write first, then by data/meta?

Especially for all read bios, we use workqueue to defer to a less strict
context, which is unrelated to data/metadata.

Thanks,
Qu
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/btrfs/ctree.h     |   6 +-
>   fs/btrfs/extent_io.c |  12 ++--
>   fs/btrfs/inode.c     | 131 ++++++++++++++++++++-----------------------
>   3 files changed, 73 insertions(+), 76 deletions(-)
>
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index ec8487e119949..ab9a0cfed7bb0 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -3250,8 +3250,10 @@ void btrfs_inode_safe_disk_i_size_write(struct bt=
rfs_inode *inode, u64 new_i_siz
>   u64 btrfs_file_extent_end(const struct btrfs_path *path);
>
>   /* inode.c */
> -void btrfs_submit_data_bio(struct inode *inode, struct bio *bio,
> -			   int mirror_num, unsigned long bio_flags);
> +void btrfs_submit_data_write_bio(struct inode *inode, struct bio *bio,
> +		int mirror_num, unsigned long bio_flags);
> +void btrfs_submit_data_read_bio(struct inode *inode, struct bio *bio,
> +		int mirror_num, unsigned long bio_flags);
>   unsigned int btrfs_verify_data_csum(struct btrfs_bio *bbio,
>   				    u32 bio_offset, struct page *page,
>   				    u64 start, u64 end);
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index f9d6dd310c42b..80b4482c477c6 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -186,11 +186,15 @@ static void submit_one_bio(struct bio *bio, int mi=
rror_num, unsigned long bio_fl
>   	/* Caller should ensure the bio has at least some range added */
>   	ASSERT(bio->bi_iter.bi_size);
>
> -	if (is_data_inode(tree->private_data))
> -		btrfs_submit_data_bio(tree->private_data, bio, mirror_num,
> +	if (!is_data_inode(tree->private_data))
> +		btrfs_submit_metadata_bio(tree->private_data, bio, mirror_num);
> +	else if (btrfs_op(bio) =3D=3D BTRFS_MAP_WRITE)
> +		btrfs_submit_data_write_bio(tree->private_data, bio, mirror_num,
>   					    bio_flags);
>   	else
> -		btrfs_submit_metadata_bio(tree->private_data, bio, mirror_num);
> +		btrfs_submit_data_read_bio(tree->private_data, bio, mirror_num,
> +					    bio_flags);
> +
>   	/*
>   	 * Above submission hooks will handle the error by ending the bio,
>   	 * which will do the cleanup properly.  So here we should not return
> @@ -2773,7 +2777,7 @@ static blk_status_t submit_data_read_repair(struct=
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
> index b188f724eff2d..4429d831793d5 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -2552,91 +2552,82 @@ static blk_status_t extract_ordered_extent(struc=
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
> +void btrfs_submit_data_write_bio(struct inode *inode, struct bio *bio,
>   			   int mirror_num, unsigned long bio_flags)
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
> -		ret =3D btrfs_bio_wq_end_io(fs_info, bio, metadata);
> -		if (ret)
> -			goto out;
> -
> -		if (bio_flags & EXTENT_BIO_COMPRESSED) {
> -			/*
> -			 * btrfs_submit_compressed_read will handle completing
> -			 * the bio if there were any errors, so just return
> -			 * here.
> -			 */
> -			btrfs_submit_compressed_read(inode, bio, mirror_num,
> -						     bio_flags);
> -			return;
> -		} else {
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
> +		} else if (btrfs_is_data_reloc_root(bi->root)) {
> +			; /* csum items have already been cloned */
> +		} else {
> +			ret =3D btrfs_wq_submit_bio(inode, bio,
> +					mirror_num, bio_flags, 0,
> +					btrfs_submit_bio_start);
> +			goto out;
>   		}
> -		goto mapit;
> -	} else if (async && !skip_sum) {
> -		/* csum items have already been cloned */
> -		if (btrfs_is_data_reloc_root(root))
> -			goto mapit;
> -		/* we're doing a write, do the async checksumming */
> -		ret =3D btrfs_wq_submit_bio(inode, bio, mirror_num, bio_flags,
> -					  0, btrfs_submit_bio_start);
> +	}
> +	ret =3D btrfs_map_bio(fs_info, bio, mirror_num);
> +out:
> +	if (ret) {
> +		bio->bi_status =3D ret;
> +		bio_endio(bio);
> +	}
> +}
> +
> +void btrfs_submit_data_read_bio(struct inode *inode, struct bio *bio,
> +			   int mirror_num, unsigned long bio_flags)
> +{
> +	struct btrfs_fs_info *fs_info =3D btrfs_sb(inode->i_sb);
> +	blk_status_t ret;
> +
> +	ret =3D btrfs_bio_wq_end_io(fs_info, bio,
> +			btrfs_is_free_space_inode(BTRFS_I(inode)) ?
> +			BTRFS_WQ_ENDIO_FREE_SPACE : BTRFS_WQ_ENDIO_DATA);
> +	if (ret)
>   		goto out;
> -	} else if (!skip_sum) {
> -		ret =3D btrfs_csum_one_bio(BTRFS_I(inode), bio, (u64)-1, false);
> -		if (ret)
> -			goto out;
> +
> +	if (bio_flags & EXTENT_BIO_COMPRESSED) {
> +		/*
> +		 * btrfs_submit_compressed_read will handle completing the bio
> +		 * if there were any errors, so just return here.
> +		 */
> +		btrfs_submit_compressed_read(inode, bio, mirror_num, bio_flags);
> +		return;
>   	}
>
> -mapit:
> +	/*
> +	 * Lookup bio sums does extra checks around whether we need to csum or
> +	 * not, which is why we ignore skip_sum here.
> +	 */
> +	ret =3D btrfs_lookup_bio_sums(inode, bio, NULL);
> +	if (ret)
> +		goto out;
>   	ret =3D btrfs_map_bio(fs_info, bio, mirror_num);
> -
>   out:
>   	if (ret) {
>   		bio->bi_status =3D ret;
> @@ -7909,7 +7900,7 @@ static inline blk_status_t btrfs_submit_dio_bio(st=
ruct bio *bio,
>   		goto map;
>
>   	if (write) {
> -		/* check btrfs_submit_data_bio() for async submit rules */
> +		/* check btrfs_submit_data_write_bio() for async submit rules */
>   		if (async_submit && !atomic_read(&BTRFS_I(inode)->sync_writers))
>   			return btrfs_wq_submit_bio(inode, bio, 0, 0,
>   					file_offset,
