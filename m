Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 902ED53D8BD
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 Jun 2022 00:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241057AbiFDWbb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 4 Jun 2022 18:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237737AbiFDWb3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 4 Jun 2022 18:31:29 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47EE4D249
        for <linux-btrfs@vger.kernel.org>; Sat,  4 Jun 2022 15:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654381882;
        bh=lMKeMpyk4G8Uj4Utgsln8QCpz2y3o5W/PhO0wuA2724=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=TSlziYMc0c9Y3a/WWBxMhMfPCEKDerSbDrjl4XJz5u+N5APSt2qrQunyTqADt1rj9
         D6Bt+5+uajD66GVbVSt2w6MAYSJYfflFSd0G2MY1oY4qdbq6lNYqaHynCXOPBIGCCz
         fXi/+WKOhSHY0u3IJ7xYQbSWdHIHe2vBqr5XcgIs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M8QS2-1ntCRt3oci-004WKp; Sun, 05
 Jun 2022 00:31:22 +0200
Message-ID: <ee3f0a66-ce9d-5e3d-2a8e-fd620bcb5f5d@gmx.com>
Date:   Sun, 5 Jun 2022 06:31:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 3/3] btrfs: pass the btrfs_bio_ctrl to submit_one_bio
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20220603071103.43440-1-hch@lst.de>
 <20220603071103.43440-4-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220603071103.43440-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/EMW9dXxzzja4IksL+plDoLIqi+LUFgiZoTK1rRCz4qfpA8926M
 aMkDV9Y+cbz6law1zSXK/zljYEVMQhnu3JDoBnEbzJJGftQZ3miiE6l9gEP68QI7jleIjcU
 Wf9pFx9KyJYM5KM7ZMDXLTzXnMWKrl03PwFzWRKBR9d+B14qJs6qNhngH0kmhKM1RRP0fG/
 cilUhrq9u1ERFxjDvUOZQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:z3hl8TrFFEc=:KiX+O2yHnbjlo2ENRFZNDH
 ab9++xIMteyaWuFuVDdlOwzB/5UbyVqzTYVJiCUrMBWw22/WQYhQaYupLy+8+ADkClwWoC3Vv
 2VDxRUQ3bRZL7xaruG6sY8fpGxfHXS9Q1Bz+fqXPur0ZeLZrF720Cldcl8GSAb+0kIACsC8j7
 IQJORY8R8FedaXksqb+o6FhZNBuJcTyvPx3QF3QJzbc4q30TUVlSQ9ox1AgDgvIfWszt7KMBR
 4YgW5dNAQ2w5C2sBnODo+J8kQHO9DB65TtheAORKccVfhDKe1sL/6S7TNL7VzpzTiPYo2+Ln+
 Mjqb29qb7RCAV2ZxYaXFrAOx/fgHRNiEmOi1mdGA92bJrk9rFS+ppqT4XAt84S4WXY2verI6O
 lB+TkWeT78xIB8UyhR+L4nTa1+nedbmSPbuGpbPYwLTjCOEw6t9e/7AFMGNspagoF2gxUlXZV
 XFWr7b1BBv3Rj0FN9cZiUk/a7bUVx3LjiCNUNX6m5W6luLvL5AzPLBK7sSjexgdKfahCBk0fx
 GiNEsVwVd7oANiFx+e2JQfiWW5r3LMxoKoAE5W17Zqz5CV/1uAjY+Ork0XbeK6IRmfzg7y5eu
 rdZAlYiTfsk5HLESwC/j1VMY4fL6LFC5fP1Gv/tcS56KOV2lyN7KiYEcVl4JIBgWNRWI03m51
 Todvu2JQe7v1j/mr06mSdvKEcyJCr5TfZqYgaLiE2o0LLncz+sC9NxMM8micLwOcvKC12rVjB
 o6bZ8Da/7Upi0wjqqEbzL5V/Ltw1qthZSLrggmQegxPhAnOyDQet5FHBsS3PJpQtkLhc/NGKS
 EB6STVZ5J6510BTlnWuZrrDei27A4fnrk+JRAOo+hOgM/RpJZsHUOUUKxNPPUEAW5/6b6fm5+
 GWTHWT1QyCAPb6hzI452i08wvlySc87ym8usNDNcc/Tcwg8t3eo7r4flQMH7hcL7TPkPK8n/F
 dSPl77lTjgKh4Yy9kZZXQ7SUFU35WN2/vzXKVNZbRj843UWEodfPbmD7OZHvMHhUsxZLk3STl
 hqEjWokuxYfFrkec5EyM8EmlZgKERgDkEFEvRsU4kumkUbi5h1RaBtNNUaEVTR/2YbLODFc8u
 lS4zKQEIgwqkBK9Z2inWXg8IN3Y2EtC07bw2O1khK6cblfc5KdJ1dVJ9w==
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/3 15:11, Christoph Hellwig wrote:
> submit_one_bio always works on the bio and compression flags from a
> btrfs_bio_ctrl structure.  Pass the explicitly and clean up the the
> calling conventions by handling a NULL bio in submit_one_bio, and
> using the btrfs_bio_ctrl to pass the mirror number as well.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Qu Wenruo <wqu@suse.com>

In fact the only call sites really caring num_mirror is the metadata
read path (as it doesn't rely on the read-repair code, since metadata
has inline csum and it has a different validation condition).

It may be a good idea to make a union for btrfs_bio, to contain all the
needed info for metadata verification (btrfs_key, transid, level), so
that we can get rid of the num_mirror parameter for submit_extent_page()
completely.

Thanks,
Qu
> ---
>   fs/btrfs/extent_io.c | 82 ++++++++++++++++++++------------------------
>   1 file changed, 37 insertions(+), 45 deletions(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 72a258fa27947..facca7feb9a22 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -144,6 +144,7 @@ struct tree_entry {
>    */
>   struct btrfs_bio_ctrl {
>   	struct bio *bio;
> +	int mirror_num;
>   	enum btrfs_compression_type compress_type;
>   	u32 len_to_stripe_boundary;
>   	u32 len_to_oe_boundary;
> @@ -178,10 +179,11 @@ static int add_extent_changeset(struct extent_stat=
e *state, u32 bits,
>   	return ret;
>   }
>
> -static void submit_one_bio(struct bio *bio, int mirror_num,
> -			   enum btrfs_compression_type compress_type)
> +static void __submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
>   {
> +	struct bio *bio =3D bio_ctrl->bio;
>   	struct inode *inode =3D bio_first_page_all(bio)->mapping->host;
> +	int mirror_num =3D bio_ctrl->mirror_num;
>
>   	/* Caller should ensure the bio has at least some range added */
>   	ASSERT(bio->bi_iter.bi_size);
> @@ -191,14 +193,17 @@ static void submit_one_bio(struct bio *bio, int mi=
rror_num,
>   	else if (btrfs_op(bio) =3D=3D BTRFS_MAP_WRITE)
>   		btrfs_submit_data_write_bio(inode, bio, mirror_num);
>   	else
> -		btrfs_submit_data_read_bio(inode, bio, mirror_num, compress_type);
> +		btrfs_submit_data_read_bio(inode, bio, mirror_num,
> +					   bio_ctrl->compress_type);
>
> -	/*
> -	 * Above submission hooks will handle the error by ending the bio,
> -	 * which will do the cleanup properly.  So here we should not return
> -	 * any error, or the caller of submit_extent_page() will do cleanup
> -	 * again, causing problems.
> -	 */
> +	/* The bio is owned by the bi_end_io handler now */
> +	bio_ctrl->bio =3D NULL;
> +}
> +
> +static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
> +{
> +	if (bio_ctrl->bio)
> +		__submit_one_bio(bio_ctrl);
>   }
>
>   /*
> @@ -215,12 +220,11 @@ static void submit_write_bio(struct extent_page_da=
ta *epd, int ret)
>   		ASSERT(ret < 0);
>   		bio->bi_status =3D errno_to_blk_status(ret);
>   		bio_endio(bio);
> +		/* The bio is owned by the bi_end_io handler now */
> +		epd->bio_ctrl.bio =3D NULL;
>   	} else {
> -		submit_one_bio(bio, 0, 0);
> +		__submit_one_bio(&epd->bio_ctrl);
>   	}
> -
> -	/* The bio is owned by the bi_end_io handler now */
> -	epd->bio_ctrl.bio =3D NULL;
>   }
>
>   int __init extent_state_cache_init(void)
> @@ -3408,7 +3412,6 @@ static int submit_extent_page(unsigned int opf,
>   			      struct page *page, u64 disk_bytenr,
>   			      size_t size, unsigned long pg_offset,
>   			      bio_end_io_t end_io_func,
> -			      int mirror_num,
>   			      enum btrfs_compression_type compress_type,
>   			      bool force_bio_submit)
>   {
> @@ -3420,10 +3423,8 @@ static int submit_extent_page(unsigned int opf,
>
>   	ASSERT(pg_offset < PAGE_SIZE && size <=3D PAGE_SIZE &&
>   	       pg_offset + size <=3D PAGE_SIZE);
> -	if (force_bio_submit && bio_ctrl->bio) {
> -		submit_one_bio(bio_ctrl->bio, mirror_num, bio_ctrl->compress_type);
> -		bio_ctrl->bio =3D NULL;
> -	}
> +	if (force_bio_submit)
> +		submit_one_bio(bio_ctrl);
>
>   	while (cur < pg_offset + size) {
>   		u32 offset =3D cur - pg_offset;
> @@ -3463,8 +3464,7 @@ static int submit_extent_page(unsigned int opf,
>   		if (added < size - offset) {
>   			/* The bio should contain some page(s) */
>   			ASSERT(bio_ctrl->bio->bi_iter.bi_size);
> -			submit_one_bio(bio_ctrl->bio, mirror_num, bio_ctrl->compress_type);
> -			bio_ctrl->bio =3D NULL;
> +			submit_one_bio(bio_ctrl);
>   		}
>   		cur +=3D added;
>   	}
> @@ -3741,10 +3741,8 @@ static int btrfs_do_readpage(struct page *page, s=
truct extent_map **em_cached,
>
>   		ret =3D submit_extent_page(REQ_OP_READ | read_flags, NULL,
>   					 bio_ctrl, page, disk_bytenr, iosize,
> -					 pg_offset,
> -					 end_bio_extent_readpage, 0,
> -					 this_bio_flag,
> -					 force_bio_submit);
> +					 pg_offset, end_bio_extent_readpage,
> +					 this_bio_flag, force_bio_submit);
>   		if (ret) {
>   			/*
>   			 * We have to unlock the remaining range, or the page
> @@ -3776,8 +3774,7 @@ int btrfs_readpage(struct file *file, struct page =
*page)
>   	 * If btrfs_do_readpage() failed we will want to submit the assembled
>   	 * bio to do the cleanup.
>   	 */
> -	if (bio_ctrl.bio)
> -		submit_one_bio(bio_ctrl.bio, 0, bio_ctrl.compress_type);
> +	submit_one_bio(&bio_ctrl);
>   	return ret;
>   }
>
> @@ -4060,7 +4057,7 @@ static noinline_for_stack int __extent_writepage_i=
o(struct btrfs_inode *inode,
>   					 disk_bytenr, iosize,
>   					 cur - page_offset(page),
>   					 end_bio_extent_writepage,
> -					 0, 0, false);
> +					 0, false);
>   		if (ret) {
>   			has_error =3D true;
>   			if (!saved_ret)
> @@ -4553,7 +4550,7 @@ static int write_one_subpage_eb(struct extent_buff=
er *eb,
>   	ret =3D submit_extent_page(REQ_OP_WRITE | write_flags, wbc,
>   			&epd->bio_ctrl, page, eb->start, eb->len,
>   			eb->start - page_offset(page),
> -			end_bio_subpage_eb_writepage, 0, 0, false);
> +			end_bio_subpage_eb_writepage, 0, false);
>   	if (ret) {
>   		btrfs_subpage_clear_writeback(fs_info, page, eb->start, eb->len);
>   		set_btree_ioerr(page, eb);
> @@ -4594,7 +4591,7 @@ static noinline_for_stack int write_one_eb(struct =
extent_buffer *eb,
>   					 &epd->bio_ctrl, p, disk_bytenr,
>   					 PAGE_SIZE, 0,
>   					 end_bio_extent_buffer_writepage,
> -					 0, 0, false);
> +					 0, false);
>   		if (ret) {
>   			set_btree_ioerr(p, eb);
>   			if (PageWriteback(p))
> @@ -5207,9 +5204,7 @@ void extent_readahead(struct readahead_control *ra=
c)
>
>   	if (em_cached)
>   		free_extent_map(em_cached);
> -
> -	if (bio_ctrl.bio)
> -		submit_one_bio(bio_ctrl.bio, 0, bio_ctrl.compress_type);
> +	submit_one_bio(&bio_ctrl);
>   }
>
>   /*
> @@ -6536,7 +6531,9 @@ static int read_extent_buffer_subpage(struct exten=
t_buffer *eb, int wait,
>   	struct btrfs_fs_info *fs_info =3D eb->fs_info;
>   	struct extent_io_tree *io_tree;
>   	struct page *page =3D eb->pages[0];
> -	struct btrfs_bio_ctrl bio_ctrl =3D { 0 };
> +	struct btrfs_bio_ctrl bio_ctrl =3D {
> +		.mirror_num =3D mirror_num,
> +	};
>   	int ret =3D 0;
>
>   	ASSERT(!test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags));
> @@ -6571,8 +6568,7 @@ static int read_extent_buffer_subpage(struct exten=
t_buffer *eb, int wait,
>   	ret =3D submit_extent_page(REQ_OP_READ, NULL, &bio_ctrl,
>   				 page, eb->start, eb->len,
>   				 eb->start - page_offset(page),
> -				 end_bio_extent_readpage, mirror_num, 0,
> -				 true);
> +				 end_bio_extent_readpage, 0, true);
>   	if (ret) {
>   		/*
>   		 * In the endio function, if we hit something wrong we will
> @@ -6581,10 +6577,7 @@ static int read_extent_buffer_subpage(struct exte=
nt_buffer *eb, int wait,
>   		 */
>   		atomic_dec(&eb->io_pages);
>   	}
> -	if (bio_ctrl.bio) {
> -		submit_one_bio(bio_ctrl.bio, mirror_num, 0);
> -		bio_ctrl.bio =3D NULL;
> -	}
> +	submit_one_bio(&bio_ctrl);
>   	if (ret || wait !=3D WAIT_COMPLETE)
>   		return ret;
>
> @@ -6604,7 +6597,9 @@ int read_extent_buffer_pages(struct extent_buffer =
*eb, int wait, int mirror_num)
>   	int all_uptodate =3D 1;
>   	int num_pages;
>   	unsigned long num_reads =3D 0;
> -	struct btrfs_bio_ctrl bio_ctrl =3D { 0 };
> +	struct btrfs_bio_ctrl bio_ctrl =3D {
> +		.mirror_num =3D mirror_num,
> +	};
>
>   	if (test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags))
>   		return 0;
> @@ -6678,7 +6673,7 @@ int read_extent_buffer_pages(struct extent_buffer =
*eb, int wait, int mirror_num)
>   			err =3D submit_extent_page(REQ_OP_READ, NULL,
>   					 &bio_ctrl, page, page_offset(page),
>   					 PAGE_SIZE, 0, end_bio_extent_readpage,
> -					 mirror_num, 0, false);
> +					 0, false);
>   			if (err) {
>   				/*
>   				 * We failed to submit the bio so it's the
> @@ -6695,10 +6690,7 @@ int read_extent_buffer_pages(struct extent_buffer=
 *eb, int wait, int mirror_num)
>   		}
>   	}
>
> -	if (bio_ctrl.bio) {
> -		submit_one_bio(bio_ctrl.bio, mirror_num, bio_ctrl.compress_type);
> -		bio_ctrl.bio =3D NULL;
> -	}
> +	submit_one_bio(&bio_ctrl);
>
>   	if (ret || wait !=3D WAIT_COMPLETE)
>   		return ret;
