Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D515C52AE0C
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 May 2022 00:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbiEQWXR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 May 2022 18:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbiEQWXQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 May 2022 18:23:16 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546184D626
        for <linux-btrfs@vger.kernel.org>; Tue, 17 May 2022 15:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652826187;
        bh=4ZD1yydNOuXeqHCDuh23hv2MGOrsAmoHNBc55WmszAs=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=GtehjyWnvDd0wY315/7BrhMDNGwsKNP7UiuJr28NOnqu4cDm3Qop+DycDon8LByhU
         WjwYnQTBvFnCQ1fPS4lLjlrgfr74gzPlgOIx9kZ772c1Wi7OVvCUVgJsoWgj+jiwrQ
         m6RRT/wApZMqJG+rCK99tnRXkXcLaLLRUHlsurfk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N7zFj-1nnhuN3COB-014xsV; Wed, 18
 May 2022 00:23:07 +0200
Message-ID: <5dc10aca-29ce-9318-c8f9-9ea83b35dde1@gmx.com>
Date:   Wed, 18 May 2022 06:22:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 08/15] btrfs: refactor end_bio_extent_readpage
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20220517145039.3202184-1-hch@lst.de>
 <20220517145039.3202184-9-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220517145039.3202184-9-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iLDYJ68t6WfSXYGL8KEPUERueO2aYTNGaOikGyH1kAvUYxggeII
 mumccNeLGDhSiEwHjgNMXnx/K/84bAL+h6TOtBD5kiG6Q4JRCuY+HX6wT4cnWI13SeEOLBu
 AUYhXTeKK/J4jD2lgUkeEWvCaxbYzddCxJdWoSm0fWNB3FXdVduA+U6UZ40ManXjnxKvFBS
 YSz+qC4dXfywHiJgV6SBg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0UCC/t5Wcuc=:911h45+mQD1+MOwlCphWyL
 bS4u51JT5DcLRBuTJ1GxlHcz/nubT0EKPIn+KpwJATSkZhYB9sEGyYFfzRgFonSheSimibgOy
 TaNh2fz5m38fRGdvFRR7ROONAF5KLOLpGbBHHHrHSyXtB977wMLOC7BnSQts21uveO5jhKTr6
 rfrxg6HJnWuTwUjkDa6IOSPx8cdnvEFdsmxr+ELxmLhdt5oE/jrz9nfn79740AuFj8FPwkIn/
 kn7FlPL6cp/HzpIldOkgJPdqTf10+hpmG4gMYRhp0w1YyjEFgDA7Oi/CcS1hhCp4gNjo0mH97
 ymkvHKB0LbMEEneWeh6vJ1YV4IFJOprofQHI+I9an30q9aupWyypiBmiywBl/W9Q7cd3O7khA
 6QfnQpfiB/cVA95zbJb0myDoiDlLR9M0ztzvLQLOQg6gYvCVVfF3EADaZkM7Bplb1z/RdBPce
 hmdOBCgbtjGaMmAfGpQ3BEQ+AILSqfuRf3LHPx75w/sWbe8AzmgbjVdyF7cREIgTKGNzOCqmx
 FeqZG8iZMiO9EjIyg0rxW9QGwWRkcWj9aqypBeBUJ8/Yc/1iUTKNbuvyrcdY/DQhQSpV2nXD2
 GTNDN9fIgGj494zQ5KdNXSfICvb1bhNRm4LD/G8PbRnaGt0RcY1vrJ2U/jx8bkPL7DMR40Era
 9KjzLusBZ0l3vCp20lqh5ExdCA/KL0Ca8t03P32/zChQ4EuLXc9AvNNlZgp3UTqYtWuGJkJK4
 Hx1Re9lubH87NF31aLbfWvtAWHplMp2QVgbTHREQGgaz4sbnPQAyln/AmMAT9S2YX1ugo3wnh
 glSZD/1EJQMWh1kE0ddSRy2bpeYA3IalJh+lZybMiutUempEE0YX3H9ui9FflPs+PUb6YT74b
 5OJOsghOUTVL5uQ6zV3QyRldccDjrN2yk7/fQih8VjvA3bLpfjPJs6TUcgCoqhSI7u2hndBdt
 c8KbC52PiFN8mq+iJEmxOppD0Wf8G9F850OWghEvDNjW3deOYG/grJXve+hYAcq+ERSbWOX40
 tcgBvFBGoLBipIVUzRo+ozuAJabqrBbt3MlqpIZCjo/6zLf5qdLOZzBdyZJRB7VRysF9d4qDS
 meCcSmtD226z37ZcpdNElHEhqGkQ67qjmOLVWqY9S+CXVqLAkQfGbZrWQ==
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/17 22:50, Christoph Hellwig wrote:
> Untangle the goto mess and remove the pointless 'ret' local variable.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/btrfs/extent_io.c | 87 +++++++++++++++++++++-----------------------
>   1 file changed, 41 insertions(+), 46 deletions(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index f96d5b7071813..1ba2d4b194f2e 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -3028,7 +3028,6 @@ static void end_bio_extent_readpage(struct bio *bi=
o)
>   	 */
>   	u32 bio_offset =3D 0;
>   	int mirror;
> -	int ret;
>   	struct bvec_iter_all iter_all;
>
>   	ASSERT(!bio_flagged(bio, BIO_CLONED));
> @@ -3039,6 +3038,7 @@ static void end_bio_extent_readpage(struct bio *bi=
o)
>   		struct btrfs_fs_info *fs_info =3D btrfs_sb(inode->i_sb);
>   		const u32 sectorsize =3D fs_info->sectorsize;
>   		unsigned int error_bitmap =3D (unsigned int)-1;
> +		bool repair =3D false;
>   		u64 start;
>   		u64 end;
>   		u32 len;
> @@ -3076,55 +3076,23 @@ static void end_bio_extent_readpage(struct bio *=
bio)
>   			if (is_data_inode(inode)) {
>   				error_bitmap =3D btrfs_verify_data_csum(bbio,
>   						bio_offset, page, start, end);
> -				ret =3D error_bitmap;
> +				if (error_bitmap)
> +					uptodate =3D false;
>   			} else {
> -				ret =3D btrfs_validate_metadata_buffer(bbio,
> -					page, start, end, mirror);
> +				if (btrfs_validate_metadata_buffer(bbio,
> +						page, start, end, mirror))
> +					uptodate =3D false;
>   			}
> -			if (ret)
> -				uptodate =3D false;
> -			else
> -				clean_io_failure(BTRFS_I(inode)->root->fs_info,
> -						 failure_tree, tree, start,
> -						 page,
> -						 btrfs_ino(BTRFS_I(inode)), 0);
>   		}
>
> -		if (likely(uptodate))
> -			goto readpage_ok;
> -
> -		if (is_data_inode(inode)) {
> -			/*
> -			 * If we failed to submit the IO at all we'll have a
> -			 * mirror_num =3D=3D 0, in which case we need to just mark
> -			 * the page with an error and unlock it and carry on.
> -			 */
> -			if (mirror =3D=3D 0)
> -				goto readpage_ok;
> -
> -			/*
> -			 * submit_data_read_repair() will handle all the good
> -			 * and bad sectors, we just continue to the next bvec.
> -			 */
> -			submit_data_read_repair(inode, bio, bio_offset, bvec,
> -						mirror, error_bitmap);
> -
> -			ASSERT(bio_offset + len > bio_offset);
> -			bio_offset +=3D len;
> -			continue;
> -		} else {
> -			struct extent_buffer *eb;
> -
> -			eb =3D find_extent_buffer_readpage(fs_info, page, start);
> -			set_bit(EXTENT_BUFFER_READ_ERR, &eb->bflags);
> -			eb->read_mirror =3D mirror;
> -			atomic_dec(&eb->io_pages);
> -		}
> -readpage_ok:
>   		if (likely(uptodate)) {
>   			loff_t i_size =3D i_size_read(inode);
>   			pgoff_t end_index =3D i_size >> PAGE_SHIFT;
>
> +			clean_io_failure(BTRFS_I(inode)->root->fs_info,
> +					 failure_tree, tree, start, page,
> +					 btrfs_ino(BTRFS_I(inode)), 0);
> +
>   			/*
>   			 * Zero out the remaining part if this range straddles
>   			 * i_size.
> @@ -3141,14 +3109,41 @@ static void end_bio_extent_readpage(struct bio *=
bio)
>   				zero_user_segment(page, zero_start,
>   						  offset_in_page(end) + 1);
>   			}
> +		} else if (is_data_inode(inode)) {
> +			/*
> +			 * Only try to repair bios that actually made it to a
> +			 * device.  If the bio failed to be submitted mirror
> +			 * is 0 and we need to fail it without retrying.
> +			 */
> +			if (mirror > 0)
> +				repair =3D true;

In fact, you can do it even better, by also checking the number of
copies the bio has.

That what I missed in my all patchset, and completely relies on the
mirror based loop to exit.

> +		} else {
> +			struct extent_buffer *eb;
> +
> +			eb =3D find_extent_buffer_readpage(fs_info, page, start);
> +			set_bit(EXTENT_BUFFER_READ_ERR, &eb->bflags);
> +			eb->read_mirror =3D mirror;
> +			atomic_dec(&eb->io_pages);
>   		}
> +
> +		if (repair) {
> +			/*
> +			 * submit_data_read_repair() will handle all the good
> +			 * and bad sectors, we just continue to the next bvec.
> +			 */
> +			submit_data_read_repair(inode, bio, bio_offset, bvec,
> +						mirror, error_bitmap);
> +		} else {
> +			/* Update page status and unlock */
> +			end_page_read(page, uptodate, start, len);
> +			endio_readpage_release_extent(&processed,
> +					BTRFS_I(inode), start, end,
> +					PageUptodate(page));

Another reason I'm not introducing the end_sector_io().

Here the code looks super familiar with end_sector_io(), but due to the
@processed interface, it's not compatible with end_sector_io(), or we
will do the unlock with way more io_tree operations with much smaller
range, thus reduces performance.

Thanks,
Qu

> +		}
> +
>   		ASSERT(bio_offset + len > bio_offset);
>   		bio_offset +=3D len;
>
> -		/* Update page status and unlock */
> -		end_page_read(page, uptodate, start, len);
> -		endio_readpage_release_extent(&processed, BTRFS_I(inode),
> -					      start, end, PageUptodate(page));
>   	}
>   	/* Release the last extent */
>   	endio_readpage_release_extent(&processed, NULL, 0, 0, false);
