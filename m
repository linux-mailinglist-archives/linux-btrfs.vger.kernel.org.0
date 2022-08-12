Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A24590FF5
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Aug 2022 13:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234847AbiHLLVe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Aug 2022 07:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiHLLVd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Aug 2022 07:21:33 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD486AB189
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Aug 2022 04:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660303284;
        bh=srUjM3CgoyobxwuJc68JbWMacRkq0zrguRB6As4sg9M=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=R9hRszTvcOTMMRVEcyTZma8si5NXGJ3FXEyV/y77/yrGQuuQLDrV/KA2ZrmRHGdrG
         02m6G4SJtWRfwAFomGkaiU2Po5XHk4gidz9B5TvXbgMYG3O1SODrXmQ5BbZT471qK+
         A4ztLAchs3T6/o4m4fyk3LVrSZVXpt56Lis3FzBk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MvK0R-1nW95e3dc9-00rK5A; Fri, 12
 Aug 2022 13:21:24 +0200
Message-ID: <ea61624a-26ed-38e4-1f92-400cab7d504a@gmx.com>
Date:   Fri, 12 Aug 2022 19:21:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20220707053331.211259-1-hch@lst.de>
 <20220707053331.211259-4-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 3/6] btrfs: pass a btrfs_bio to btrfs_repair_one_sector
In-Reply-To: <20220707053331.211259-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1BvYXunMVT6V8j3O1tNRDSMrF+84XvKICtV89hshx1ZKoyWPRir
 MK1YSr5UOSlLn0GFwR7o17f+3Exe8y8LrH705Kh1oFQIkiO7CuIL7S0ktnFf9/VwJGApoax
 yVMsfHWLh9bDce8a9mYYLfteEvVpGsNyWh9o8vKQxFrzYwKrO22sRm7ppSj2TZFniy6LZlB
 cGJEdAiTn0lt4g8V2LHFg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:d4Xmo2cP1Gs=:kXp6907oFhKp61rezJ4OuP
 YzswJ8/EF81BQXkDtZPHsK5/i65yxMFztj/wRBrWk8DqzOuG676XolDVRTGqr7bcBOA2XO3QG
 N7vpPPmMqUSxEeC8Avlci8/8UlEUi19LsbJEGTre6P6L6ZigAxvP+H4iNcwX6V6nDvErhlH0p
 9Nh0BqIJcL8ZIf0VPCAfKSGXonodHPj1iDD3KyT9+llV52ZCoeZCQmvtcwiIl/KnTc2tqtPoa
 lhvk/dAMuoJ4OLBpndkDA3XQ9C++XCRDqEuCZH5N9UQ1GbU/3ZG8qDoHYoivPZvliAjqjXE1x
 PeLBSb+LISjdv9osPfo1gMY/0gAiCQpIemYXMQsr2dPH7q9BxYD2CDFhxWpQ8HpGR1IVDt+jq
 7Z5HmI3pxlL3Y2x6EEXf2KcuT9EhMbowd21cg4YAXt/URJWw5ROPE2d4Y3lC8dN67PaBCMgzw
 3Y+lxhFS9q1G1P6NRCuqPZR6AZ19av4X36+Gb6n4MlSfKrYXRDDkEvgLhgqp4P4PD7g6AXRzf
 6n3e8mlAMBSLpeJhOA6SMI7G+xfWZ7V+XN+xpzLHFzYQTIWtgcJ/mAizm77OPyv/RRnSVQjLx
 YoCRjikmJSMXH/D+AuLtFYeT+8D6UTVL+ReLxfnPJdHwqBpCG35uk2clpcOqLHxNkGHSGWi6S
 u9rEUDtYSpduoq2aarAvxlgV7dTZ7uYcu1Dvq0MOoYNjb2671mLEA7I3iXQ2EInSw8ESBV5B+
 TopYGOGZm+s+rSLE1t+rUpaD6TvN5DKZsFgTm/pqhac1DaYIGfRy+cJlZDDw5UF2Sw+4wTBUP
 2EXko//6ZYCi6FMlHjkmm/CfqViU24hGndFmIvIY5pjTXbrIkH65DncFVV6/vgZh2P3N7rAmB
 06/JZain67IA6fSUCVQHwg9jLPWXwFYJjs20VY91RHfUShMEIV8ayuTayLW/n9ZCiIqkMbzaB
 fBDRUjA2r8xQM0Yi8Giu9MoQntUOXVpKVDH0hGW4mvmgUW6FDHnqkCCPRgdAXQDuMZuqHUZ7V
 +9YoRIuIK5j+RVpacEMhOZD4hkzYHRp/m9Nuc/0hkqtMw+Evka6OrbbCZQ93RVut2Grh1hB5k
 pszF9qQ4/D6O4wgemDTvwnKmJ1erzoNIxtlJkNn72L6S/dC+B6Gc3M2ag==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/7/7 13:33, Christoph Hellwig wrote:
> Pass the btrfs_bio instead of the plain bio to btrfs_repair_one_sector,
> an remove the start and failed_mirror arguments in favor of deriving
> them from the btrfs_bio.  For this to work ensure that the file_offset
> field is also initialized for buffered I/O.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Unfortuantely new test case btrfs/261 will expose some problems in
latest misc-next, the first commit I can pin down is back to this patch.

The simplified reproducer is here:

         mkfs.btrfs -f -d raid5 -m raid5 $dev1 $dev2 $dev3 -b 1G
         mount $dev1 $mnt
         xfs_io -f -c "pwrite 0 200m" $mnt/garbage > /dev/null
         $fsstress -s 1660413672 -w -d $mnt -n 2000
         sync
         $fssum -A -f -w /tmp/fssum.saved $mnt
         umount $mnt

         xfs_io -c "pwrite -S 0x0 1m 1023m" $dev1
         mount $dev1 $mnt
         $fssum -r /tmp/fssum.saved $mnt > /dev/null
         umount $mnt

This will cause the following weird output at the end of the tests:

[ 3671.459747] BTRFS critical (device dm-1): unable to find logical
18446744073709551613 length 4096
[ 3671.460449] BTRFS critical (device dm-1): unable to find logical 4093
length 4096
[ 3671.461271] BTRFS critical (device dm-1): unable to find logical
18446744073709551613 length 4096
[ 3671.461914] BTRFS critical (device dm-1): unable to find logical 4093
length 4096

The reason is, now btrfs_get_io_failure_record() can hit the following
range:

r/i=3D5/269 file_offset=3D6987776 em->block_start=3D-3 (HOLE)

This means, we're now trying to repair a hole.

But weirdly, just before this commit, at the previous commit, (btrfs:
simplify the pending I/O counting in struct compressed_bio), that hole
range is not passed to btrfs_repair_one_sector() at all.

And just comparing the two trace I dumpped for
btrfs_repair_one_sector(), I can not find obvious problems, except those
hole extents are not queued into btrfs_repair_one_sector() at all.

Any clue how could this happen?

Thanks,
Qu
> ---
>   fs/btrfs/extent_io.c | 47 ++++++++++++++++++++++++--------------------
>   fs/btrfs/extent_io.h |  8 ++++----
>   fs/btrfs/inode.c     |  5 ++---
>   3 files changed, 32 insertions(+), 28 deletions(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 3778d58092dea..ec7bdb3fa0921 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -182,6 +182,7 @@ static int add_extent_changeset(struct extent_state =
*state, u32 bits,
>   static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
>   {
>   	struct bio *bio;
> +	struct bio_vec *bv;
>   	struct inode *inode;
>   	int mirror_num;
>
> @@ -189,12 +190,15 @@ static void submit_one_bio(struct btrfs_bio_ctrl *=
bio_ctrl)
>   		return;
>
>   	bio =3D bio_ctrl->bio;
> -	inode =3D bio_first_page_all(bio)->mapping->host;
> +	bv =3D bio_first_bvec_all(bio);
> +	inode =3D bv->bv_page->mapping->host;
>   	mirror_num =3D bio_ctrl->mirror_num;
>
>   	/* Caller should ensure the bio has at least some range added */
>   	ASSERT(bio->bi_iter.bi_size);
>
> +	btrfs_bio(bio)->file_offset =3D page_offset(bv->bv_page) + bv->bv_offs=
et;
> +
>   	if (!is_data_inode(inode))
>   		btrfs_submit_metadata_bio(inode, bio, mirror_num);
>   	else if (btrfs_op(bio) =3D=3D BTRFS_MAP_WRITE)
> @@ -2533,10 +2537,11 @@ void btrfs_free_io_failure_record(struct btrfs_i=
node *inode, u64 start, u64 end)
>   }
>
>   static struct io_failure_record *btrfs_get_io_failure_record(struct in=
ode *inode,
> -							     u64 start,
> -							     int failed_mirror)
> +							     struct btrfs_bio *bbio,
> +							     unsigned int bio_offset)
>   {
>   	struct btrfs_fs_info *fs_info =3D btrfs_sb(inode->i_sb);
> +	u64 start =3D bbio->file_offset + bio_offset;
>   	struct io_failure_record *failrec;
>   	struct extent_map *em;
>   	struct extent_io_tree *failure_tree =3D &BTRFS_I(inode)->io_failure_t=
ree;
> @@ -2556,7 +2561,7 @@ static struct io_failure_record *btrfs_get_io_fail=
ure_record(struct inode *inode
>   		 * (e.g. with a list for failed_mirror) to make
>   		 * clean_io_failure() clean all those errors at once.
>   		 */
> -		ASSERT(failrec->this_mirror =3D=3D failed_mirror);
> +		ASSERT(failrec->this_mirror =3D=3D bbio->mirror_num);
>   		ASSERT(failrec->len =3D=3D fs_info->sectorsize);
>   		return failrec;
>   	}
> @@ -2567,7 +2572,7 @@ static struct io_failure_record *btrfs_get_io_fail=
ure_record(struct inode *inode
>
>   	failrec->start =3D start;
>   	failrec->len =3D sectorsize;
> -	failrec->failed_mirror =3D failrec->this_mirror =3D failed_mirror;
> +	failrec->failed_mirror =3D failrec->this_mirror =3D bbio->mirror_num;
>   	failrec->compress_type =3D BTRFS_COMPRESS_NONE;
>
>   	read_lock(&em_tree->lock);
> @@ -2632,17 +2637,17 @@ static struct io_failure_record *btrfs_get_io_fa=
ilure_record(struct inode *inode
>   	return failrec;
>   }
>
> -int btrfs_repair_one_sector(struct inode *inode,
> -			    struct bio *failed_bio, u32 bio_offset,
> -			    struct page *page, unsigned int pgoff,
> -			    u64 start, int failed_mirror,
> +int btrfs_repair_one_sector(struct inode *inode, struct btrfs_bio *fail=
ed_bbio,
> +			    u32 bio_offset, struct page *page,
> +			    unsigned int pgoff,
>   			    submit_bio_hook_t *submit_bio_hook)
>   {
> +	u64 start =3D failed_bbio->file_offset + bio_offset;
>   	struct io_failure_record *failrec;
>   	struct btrfs_fs_info *fs_info =3D btrfs_sb(inode->i_sb);
>   	struct extent_io_tree *tree =3D &BTRFS_I(inode)->io_tree;
>   	struct extent_io_tree *failure_tree =3D &BTRFS_I(inode)->io_failure_t=
ree;
> -	struct btrfs_bio *failed_bbio =3D btrfs_bio(failed_bio);
> +	struct bio *failed_bio =3D &failed_bbio->bio;
>   	const int icsum =3D bio_offset >> fs_info->sectorsize_bits;
>   	struct bio *repair_bio;
>   	struct btrfs_bio *repair_bbio;
> @@ -2652,7 +2657,7 @@ int btrfs_repair_one_sector(struct inode *inode,
>
>   	BUG_ON(bio_op(failed_bio) =3D=3D REQ_OP_WRITE);
>
> -	failrec =3D btrfs_get_io_failure_record(inode, start, failed_mirror);
> +	failrec =3D btrfs_get_io_failure_record(inode, failed_bbio, bio_offset=
);
>   	if (IS_ERR(failrec))
>   		return PTR_ERR(failrec);
>
> @@ -2750,9 +2755,10 @@ static void end_sector_io(struct page *page, u64 =
offset, bool uptodate)
>   				    offset + sectorsize - 1, &cached);
>   }
>
> -static void submit_data_read_repair(struct inode *inode, struct bio *fa=
iled_bio,
> +static void submit_data_read_repair(struct inode *inode,
> +				    struct btrfs_bio *failed_bbio,
>   				    u32 bio_offset, const struct bio_vec *bvec,
> -				    int failed_mirror, unsigned int error_bitmap)
> +				    unsigned int error_bitmap)
>   {
>   	const unsigned int pgoff =3D bvec->bv_offset;
>   	struct btrfs_fs_info *fs_info =3D btrfs_sb(inode->i_sb);
> @@ -2763,7 +2769,7 @@ static void submit_data_read_repair(struct inode *=
inode, struct bio *failed_bio,
>   	const int nr_bits =3D (end + 1 - start) >> fs_info->sectorsize_bits;
>   	int i;
>
> -	BUG_ON(bio_op(failed_bio) =3D=3D REQ_OP_WRITE);
> +	BUG_ON(bio_op(&failed_bbio->bio) =3D=3D REQ_OP_WRITE);
>
>   	/* This repair is only for data */
>   	ASSERT(is_data_inode(inode));
> @@ -2775,7 +2781,7 @@ static void submit_data_read_repair(struct inode *=
inode, struct bio *failed_bio,
>   	 * We only get called on buffered IO, thus page must be mapped and bi=
o
>   	 * must not be cloned.
>   	 */
> -	ASSERT(page->mapping && !bio_flagged(failed_bio, BIO_CLONED));
> +	ASSERT(page->mapping && !bio_flagged(&failed_bbio->bio, BIO_CLONED));
>
>   	/* Iterate through all the sectors in the range */
>   	for (i =3D 0; i < nr_bits; i++) {
> @@ -2792,10 +2798,9 @@ static void submit_data_read_repair(struct inode =
*inode, struct bio *failed_bio,
>   			goto next;
>   		}
>
> -		ret =3D btrfs_repair_one_sector(inode, failed_bio,
> -				bio_offset + offset,
> -				page, pgoff + offset, start + offset,
> -				failed_mirror, btrfs_submit_data_read_bio);
> +		ret =3D btrfs_repair_one_sector(inode, failed_bbio,
> +				bio_offset + offset, page, pgoff + offset,
> +				btrfs_submit_data_read_bio);
>   		if (!ret) {
>   			/*
>   			 * We have submitted the read repair, the page release
> @@ -3127,8 +3132,8 @@ static void end_bio_extent_readpage(struct bio *bi=
o)
>   			 * submit_data_read_repair() will handle all the good
>   			 * and bad sectors, we just continue to the next bvec.
>   			 */
> -			submit_data_read_repair(inode, bio, bio_offset, bvec,
> -						mirror, error_bitmap);
> +			submit_data_read_repair(inode, bbio, bio_offset, bvec,
> +						error_bitmap);
>   		} else {
>   			/* Update page status and unlock */
>   			end_page_read(page, uptodate, start, len);
> diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
> index 280af70c04953..a78051c7627c4 100644
> --- a/fs/btrfs/extent_io.h
> +++ b/fs/btrfs/extent_io.h
> @@ -57,6 +57,7 @@ enum {
>   #define BITMAP_LAST_BYTE_MASK(nbits) \
>   	(BYTE_MASK >> (-(nbits) & (BITS_PER_BYTE - 1)))
>
> +struct btrfs_bio;
>   struct btrfs_root;
>   struct btrfs_inode;
>   struct btrfs_io_bio;
> @@ -266,10 +267,9 @@ struct io_failure_record {
>   	int num_copies;
>   };
>
> -int btrfs_repair_one_sector(struct inode *inode,
> -			    struct bio *failed_bio, u32 bio_offset,
> -			    struct page *page, unsigned int pgoff,
> -			    u64 start, int failed_mirror,
> +int btrfs_repair_one_sector(struct inode *inode, struct btrfs_bio *fail=
ed_bbio,
> +			    u32 bio_offset, struct page *page,
> +			    unsigned int pgoff,
>   			    submit_bio_hook_t *submit_bio_hook);
>
>   #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 784c1ad4a9634..a627b2af9e243 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -7953,9 +7953,8 @@ static blk_status_t btrfs_check_read_dio_bio(struc=
t btrfs_dio_private *dip,
>   		} else {
>   			int ret;
>
> -			ret =3D btrfs_repair_one_sector(inode, &bbio->bio, offset,
> -					bv.bv_page, bv.bv_offset, start,
> -					bbio->mirror_num,
> +			ret =3D btrfs_repair_one_sector(inode, bbio, offset,
> +					bv.bv_page, bv.bv_offset,
>   					submit_dio_repair_bio);
>   			if (ret)
>   				err =3D errno_to_blk_status(ret);
