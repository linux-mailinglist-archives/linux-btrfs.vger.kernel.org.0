Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF535541C3
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jun 2022 06:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356921AbiFVEdi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jun 2022 00:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356733AbiFVEde (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jun 2022 00:33:34 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C602EA36
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jun 2022 21:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655872343;
        bh=IL125lbbpLFkVD5y1H1p+x/77VUdEs0JNVHsbzmUyYE=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=FQvEol556f5PShNXUoZfhglHn0knuXO4L/i4pVPn4ufLaDyuNvXElMab3nHx4bY9b
         mOAJFs3kDe6fUCXI9tY62DHcIu31o2zcZZlrLbWaCDuGrTNuLjhiSo5ZSz2ZugvMHo
         KvMR8bt4R8qg0pVyqmcTRpovUPW75cSRGzx5BG9k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M8ykg-1o00Po3mcw-0066ro; Wed, 22
 Jun 2022 06:32:23 +0200
Message-ID: <6490bdce-d5f6-9e59-ba04-41f0fdf8bbff@gmx.com>
Date:   Wed, 22 Jun 2022 12:32:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] btrfs: repair all bad mirrors
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org
References: <20220619082821.2151052-1-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220619082821.2151052-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:x774/rGbFGRWEfe5Gc1iq5fl5WnUS2nm3XQIW1crrh2/sT2E7A4
 eyeveYDymGKtWaHUt/7eCSkQKuM6FxJkljsI6gbQ/XYNnu7Vn/pM7JTrO7Br0kXvuDrQ7rU
 NWcN2bOwyVd5hGnpMdeuCoXvajoqDvur1AYqfnZ8IGLgSVnoR8ql7jApz+e51ulWL3wsuTk
 m7TLmU51BfQ6mnX3ubhmw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Q4B7VLOrM3A=:yX46nuM7vvrQmPBL+hmbky
 JycemMYO/5muuzgBI2aDQMJwKeZRvWNtdlyUfHC0LcFfo47HHpcBqcBabkmV1hiPxvRdW1UUZ
 KXD4k51ipB50Q3OoEdlDwypNScGXnNaLHK1ElRr82njvYdYLCvWOBEB8o7dgHgj/jqc88jQcK
 vU6r649lu1qSu+/fFhwsXQuPoh3BKPxShJ3Z+//AhPsGnzV98C+VOoBJrcpnFePtMldw+/IEM
 KxS4+j8OoebNpGDTAqp46JNhT/42xrbLcgRsQgWXA0lcTIb+zAgdU7w1oNeG4tkDjYSyNwnYp
 iRAOfVYX7TjBPsUc7Yg9K7r1gDfyqRyjfnVEN6RVzGgmR/qxnz5TO4/h35Adp1Lx7vKsV+6mr
 NMP5L9ws3+kBEs7hueZefb9Qhgb64mgtrTV0vSUEuyUgICmHXP/wl4Qfqbyjkaup+UdluzBGp
 6EceviXsd/BhD//SPmO4pRG1BXfyVV1DSJSKCYWywGSoA2yckQwFdiSlor5t2swd+s3K9gzf2
 xzQMJExXIGSqn56PoFjmMO6D1HPVjPtWcO3Er2pIWHGyBonjJjBOeV+v/IWDh4t7kJ/QoxKlH
 +cnsKUCVG9fdZnUrhheFt6BCsScx2Cp5rTjA9QoqdLB+hKhW5P3KLmzn3blF/LWsyw3E6+0zP
 PSjwT4nXWqi1irVBPtCyXiQVLrGlSyiE6Mt549TPommVKdtKHI6mw6Xd/DIPy8ff+NGGFg2mA
 8iaNgdSaBvmiQIkXjwcrZxFx6pzrPT2G8nlYH5xeqUXpTemCg5RdfFKUeJaGyPpMHnP++rKEw
 J7KsDzrO9GUnBa6TBvFHLWdCSE+pbn8ZexA76ZH5dVUhbqC2FPQYKnm4/JMeSVVnL5UyjlXLf
 36MBtJKMFHvMa+6yKTErG9+sdqMTm8J63bRz25KEW72E9ylYOPtWm1Jy20hriDMv7//XzqY9b
 KCASHtfbOAxMhyWn6ebWzf1rvEhC4iaF7ZnQJr3cRQHABe3BYYHAbqSofZwilkvk1BTzc3jmg
 UrAwbcWGd0f0GhRIlWjorCxCMEAxR7bb1HZ69XccLt1wSxsuQPjlFhSuFWetjCOcnnjop6jkL
 zqZR+HvIjcIzbo18qHWVyR1w6DMUWJC+PetOOrtxFQcmIWbQXVT27pqBw==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/19 16:28, Christoph Hellwig wrote:
> When there is more than a single level of redundancy there can also be
> mutiple bad mirrors, and the current read repair code only repairs the
> last bad one.
>
> Restructure btrfs_repair_one_sector so that it records the original bad
> bad mirror, and the number of copies, and then repair all bad copies
> until we reach the original bad copy in clean_io_failure.  Note that
> this also means the read repair reads will always start from the next
> bad mirror and not mirror 0.
>
> This fixes btrfs/265 in xfstests.

Personally speaking, why not only repair the initial failed mirror?

It would be much simpler, no need to record which mirrors failed.

Thanks,
Qu
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/btrfs/extent_io.c | 127 +++++++++++++++++++++----------------------
>   fs/btrfs/extent_io.h |   3 +-
>   2 files changed, 63 insertions(+), 67 deletions(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 854999c2e139b..9775ac5d28a9e 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2432,6 +2432,20 @@ int btrfs_repair_eb_io_failure(const struct exten=
t_buffer *eb, int mirror_num)
>   	return ret;
>   }
>
> +static int next_mirror(struct io_failure_record *failrec, int cur_mirro=
r)
> +{
> +	if (cur_mirror =3D=3D failrec->num_copies)
> +		return cur_mirror + 1 - failrec->num_copies;
> +	return cur_mirror + 1;
> +}
> +
> +static int prev_mirror(struct io_failure_record *failrec, int cur_mirro=
r)
> +{
> +	if (cur_mirror =3D=3D 1)
> +		return failrec->num_copies;
> +	return cur_mirror - 1;
> +}
> +
>   /*
>    * each time an IO finishes, we do a fast check in the IO failure tree
>    * to see if we need to process or clean up an io_failure_record
> @@ -2444,7 +2458,7 @@ int clean_io_failure(struct btrfs_fs_info *fs_info=
,
>   	u64 private;
>   	struct io_failure_record *failrec;
>   	struct extent_state *state;
> -	int num_copies;
> +	int mirror;
>   	int ret;
>
>   	private =3D 0;
> @@ -2468,20 +2482,19 @@ int clean_io_failure(struct btrfs_fs_info *fs_in=
fo,
>   					    EXTENT_LOCKED);
>   	spin_unlock(&io_tree->lock);
>
> -	if (state && state->start <=3D failrec->start &&
> -	    state->end >=3D failrec->start + failrec->len - 1) {
> -		num_copies =3D btrfs_num_copies(fs_info, failrec->logical,
> -					      failrec->len);
> -		if (num_copies > 1)  {
> -			repair_io_failure(fs_info, ino, start, failrec->len,
> -					  failrec->logical, page, pg_offset,
> -					  failrec->failed_mirror);
> -		}
> -	}
> +	if (!state || state->start > failrec->start ||
> +	    state->end < failrec->start + failrec->len - 1)
> +		goto out;
> +
> +	mirror =3D failrec->this_mirror;
> +	do {
> +		mirror =3D prev_mirror(failrec, mirror);
> +		repair_io_failure(fs_info, ino, start, failrec->len,
> +				  failrec->logical, page, pg_offset, mirror);
> +	} while (mirror !=3D failrec->orig_mirror);
>
>   out:
>   	free_io_failure(failure_tree, io_tree, failrec);
> -
>   	return 0;
>   }
>
> @@ -2520,7 +2533,8 @@ void btrfs_free_io_failure_record(struct btrfs_ino=
de *inode, u64 start, u64 end)
>   }
>
>   static struct io_failure_record *btrfs_get_io_failure_record(struct in=
ode *inode,
> -							     u64 start)
> +							     u64 start,
> +							     int failed_mirror)
>   {
>   	struct btrfs_fs_info *fs_info =3D btrfs_sb(inode->i_sb);
>   	struct io_failure_record *failrec;
> @@ -2542,7 +2556,8 @@ static struct io_failure_record *btrfs_get_io_fail=
ure_record(struct inode *inode
>   		 * (e.g. with a list for failed_mirror) to make
>   		 * clean_io_failure() clean all those errors at once.
>   		 */
> -
> +		ASSERT(failrec->this_mirror =3D=3D failed_mirror);
> +		ASSERT(failrec->len =3D=3D fs_info->sectorsize);
>   		return failrec;
>   	}
>
> @@ -2552,7 +2567,7 @@ static struct io_failure_record *btrfs_get_io_fail=
ure_record(struct inode *inode
>
>   	failrec->start =3D start;
>   	failrec->len =3D sectorsize;
> -	failrec->this_mirror =3D 0;
> +	failrec->orig_mirror =3D failrec->this_mirror =3D failed_mirror;
>   	failrec->compress_type =3D BTRFS_COMPRESS_NONE;
>
>   	read_lock(&em_tree->lock);
> @@ -2587,6 +2602,20 @@ static struct io_failure_record *btrfs_get_io_fai=
lure_record(struct inode *inode
>   	failrec->logical =3D logical;
>   	free_extent_map(em);
>
> +	failrec->num_copies =3D btrfs_num_copies(fs_info, logical, sectorsize)=
;
> +	if (failrec->num_copies =3D=3D 1) {
> +		/*
> +		 * we only have a single copy of the data, so don't bother with
> +		 * all the retry and error correction code that follows. no
> +		 * matter what the error is, it is very likely to persist.
> +		 */
> +		btrfs_debug(fs_info,
> +			"Check Repairable: cannot repair, num_copies=3D%d",
> +			failrec->num_copies);
> +		kfree(failrec);
> +		return ERR_PTR(-EIO);
> +	}
> +
>   	/* Set the bits in the private failure tree */
>   	ret =3D set_extent_bits(failure_tree, start, start + sectorsize - 1,
>   			      EXTENT_LOCKED | EXTENT_DIRTY);
> @@ -2603,54 +2632,6 @@ static struct io_failure_record *btrfs_get_io_fai=
lure_record(struct inode *inode
>   	return failrec;
>   }
>
> -static bool btrfs_check_repairable(struct inode *inode,
> -				   struct io_failure_record *failrec,
> -				   int failed_mirror)
> -{
> -	struct btrfs_fs_info *fs_info =3D btrfs_sb(inode->i_sb);
> -	int num_copies;
> -
> -	num_copies =3D btrfs_num_copies(fs_info, failrec->logical, failrec->le=
n);
> -	if (num_copies =3D=3D 1) {
> -		/*
> -		 * we only have a single copy of the data, so don't bother with
> -		 * all the retry and error correction code that follows. no
> -		 * matter what the error is, it is very likely to persist.
> -		 */
> -		btrfs_debug(fs_info,
> -			"Check Repairable: cannot repair, num_copies=3D%d, next_mirror %d, f=
ailed_mirror %d",
> -			num_copies, failrec->this_mirror, failed_mirror);
> -		return false;
> -	}
> -
> -	/* The failure record should only contain one sector */
> -	ASSERT(failrec->len =3D=3D fs_info->sectorsize);
> -
> -	/*
> -	 * There are two premises:
> -	 * a) deliver good data to the caller
> -	 * b) correct the bad sectors on disk
> -	 *
> -	 * Since we're only doing repair for one sector, we only need to get
> -	 * a good copy of the failed sector and if we succeed, we have setup
> -	 * everything for repair_io_failure to do the rest for us.
> -	 */
> -	ASSERT(failed_mirror);
> -	failrec->failed_mirror =3D failed_mirror;
> -	failrec->this_mirror++;
> -	if (failrec->this_mirror =3D=3D failed_mirror)
> -		failrec->this_mirror++;
> -
> -	if (failrec->this_mirror > num_copies) {
> -		btrfs_debug(fs_info,
> -			"Check Repairable: (fail) num_copies=3D%d, next_mirror %d, failed_mi=
rror %d",
> -			num_copies, failrec->this_mirror, failed_mirror);
> -		return false;
> -	}
> -
> -	return true;
> -}
> -
>   int btrfs_repair_one_sector(struct inode *inode,
>   			    struct bio *failed_bio, u32 bio_offset,
>   			    struct page *page, unsigned int pgoff,
> @@ -2671,12 +2652,26 @@ int btrfs_repair_one_sector(struct inode *inode,
>
>   	BUG_ON(bio_op(failed_bio) =3D=3D REQ_OP_WRITE);
>
> -	failrec =3D btrfs_get_io_failure_record(inode, start);
> +	failrec =3D btrfs_get_io_failure_record(inode, start, failed_mirror);
>   	if (IS_ERR(failrec))
>   		return PTR_ERR(failrec);
>
> -
> -	if (!btrfs_check_repairable(inode, failrec, failed_mirror)) {
> +	/*
> +	 * There are two premises:
> +	 * a) deliver good data to the caller
> +	 * b) correct the bad sectors on disk
> +	 *
> +	 * Since we're only doing repair for one sector, we only need to get
> +	 * a good copy of the failed sector and if we succeed, we have setup
> +	 * everything for repair_io_failure to do the rest for us.
> +	 */
> +	failrec->this_mirror =3D next_mirror(failrec, failrec->this_mirror);
> +	if (failrec->this_mirror =3D=3D failrec->orig_mirror) {
> +		btrfs_debug(fs_info,
> +			"Check Repairable: (fail) num_copies=3D%d, this_mirror %d, orig_mirr=
or %d",
> +			failrec->num_copies,
> +			failrec->this_mirror,
> +			failrec->orig_mirror);
>   		free_io_failure(failure_tree, tree, failrec);
>   		return -EIO;
>   	}
> diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
> index c0f1fb63eeae7..5bd23bb239dae 100644
> --- a/fs/btrfs/extent_io.h
> +++ b/fs/btrfs/extent_io.h
> @@ -262,8 +262,9 @@ struct io_failure_record {
>   	u64 len;
>   	u64 logical;
>   	enum btrfs_compression_type compress_type;
> +	int orig_mirror;
>   	int this_mirror;
> -	int failed_mirror;
> +	int num_copies;
>   };
>
>   int btrfs_repair_one_sector(struct inode *inode,
