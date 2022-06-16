Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4C754D6BB
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jun 2022 03:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346318AbiFPBFc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jun 2022 21:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346001AbiFPBFb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jun 2022 21:05:31 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047EA3467C
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Jun 2022 18:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655341526;
        bh=apZE9l7iu9kZ8EB52YmjpN2QWVv5WVyzMwId2to81Vo=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=ATt7WUILOLbmoZNqMD2em2/DVZLxw6ZMJBD9OVPdlc4dXggvlWoUEQGXdF8MHB+Dh
         gLyf84zzOitbfaPdtK7h0SSZmuTiltJ2BEFR8XYFz0W/z68bzeyYnE5Aqbc38lX95f
         6dXzEPNIc/hMLolIlxHquTVrD981yhRT6cx07JFs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MCbIx-1nsbXa2glf-009gL6; Thu, 16
 Jun 2022 03:05:26 +0200
Message-ID: <281a06be-aba0-bcce-5681-dc81b0245124@gmx.com>
Date:   Thu, 16 Jun 2022 09:05:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 4/5] btrfs: remove the raid56_parity_{write,recover}
 return value
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20220615151515.888424-1-hch@lst.de>
 <20220615151515.888424-5-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220615151515.888424-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6BgTuL5bunM+E8hGdnz7lB5C9o5BgStRdUxbZ5qOLoe6Ob1Nif5
 qtwWuCzborEG+PtIgdLj69u10VwcB82+2/MZAoXQArsT2PRLFNSJOtuoOYD3Mfv5mrtfLTt
 1PKK46S91vhpKxg+cTP8gOx0MluH6T6hMaTiQIiny7K7kov3sDMUTEbNZIYIHxrOLpHBEyr
 2SlBi3E2UiYz0LyTnrrjw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+oNFKtVzLQM=:0HjuB4OI39L/Qmd+Rs0Tki
 cKxR4ArX5RUcXnieDajU4p7S+XE+sM4xi6SYUYZWIZewkYFZmo/lRPC/C4MsHgVa5WGw/041H
 7NsG3qlDcrqlqjfjYSsWO2h+5xHCGEdEQipTtCx4jXEqC3+BMSNAxiCjJVY0HTWjWXNoAKtXp
 lN/vvsM2PsneI2jsq5rHjIeWTr+bf1B8OZmS7GsoiPuZjJMJ/ZG+LMmJok4vp9ddhslMuoo2x
 kv594nnzakQ4BQ+DrUvewGCfllH3Lre62aYHGiCOoaXFytvFmNlIJ2uB6Gb3OOJK0M7+dm0H1
 c4w4yFhFyw7wgSnq3FiLF5dQ1a8LNRnNbgcbY47lZ+ERD+57Oa2lv70awaPuBPUY1x6dgSbXe
 AyUbH3Q+uHpJdsxsGEHjxFwSVp2aMxXpPZpEEUnttikZKzHxUe28fv/zCoxRnQWKBWgShaCFZ
 1iOpZSau1wVOw5p93zoB6OpgClnyQhiSUU7BKV8fE8x3LSzQZltckZ1TpMHwMWQwhf+iyjj4j
 5m26ZEdlCYOhx6S0yFgVUiIawWD8wciDA/nujzfk1vmMijFogxqmRRo6qZbM5qvY/EP7XhAum
 oXA44AFbt/agP1KZKmz2+IrApfgec/1yLdo+SasORFAlKXJlkRBY3z9uNieHYqrHDW/Eq3KEB
 SmWFwL0THJDJ9PU83vTaleZlEINab0Mc/N/E7O2QBeg50q/GHC956jYCoICh0966MJCnn1u7g
 OcCtIdSChUBY7VDCa8sFyoyKPlN3ikpQcigaGMlHzDtL16XeNmUSPDXkRSn482StpT4uBG78E
 EQgVkadVACRTY8+2wIOWvIgyk1rL8nzoCzq6a5rAXFOfhvutWVzRPD3TZPtHhszIqbMdWE2s8
 o91c9hISvV6vyUFiZL2RWxX3e2xND8m/avKYOPP+ROvzyCf0wx3Ou8qc2PVS2ioJopSpa74wW
 EgG8VXgpQw9Mva4IkLqWiy24HsP6TZW+njAie9iEdWbuffzWzHaFZ/b41B2dRa2F9w1WBw0Y0
 qOmkM1gm2/I9oGKfCgPINqcedMwsjvliW5j4IWhMpgJWIlIZiOawXIYO619qWvCHrSbyG+lxz
 mJOPKqFKiL5Nj/vp7g73D9NZ7RadXWouIDg9v3CJ06MR1r5r3a1b2R6Zw==
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/15 23:15, Christoph Hellwig wrote:
> Follow the pattern of the main bio submission helper and do not return
> an error and always consume the bio.  This allows these functions to
> consume the btrfs_bio_counter_ from the caller and thus avoid additional
> roundtrips on that counter.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/btrfs/raid56.c  | 51 ++++++++++++++++++++++++----------------------
>   fs/btrfs/raid56.h  |  6 +++---
>   fs/btrfs/scrub.c   | 10 ++-------
>   fs/btrfs/volumes.c | 19 ++++++++---------
>   4 files changed, 41 insertions(+), 45 deletions(-)
>
> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
> index e071648f2c591..bd64147bd8bab 100644
> --- a/fs/btrfs/raid56.c
> +++ b/fs/btrfs/raid56.c
> @@ -1809,7 +1809,7 @@ static void rbio_add_bio(struct btrfs_raid_bio *rb=
io, struct bio *orig_bio)
>   /*
>    * our main entry point for writes from the rest of the FS.
>    */
> -int raid56_parity_write(struct bio *bio, struct btrfs_io_context *bioc)
> +void raid56_parity_write(struct bio *bio, struct btrfs_io_context *bioc=
)
>   {
>   	struct btrfs_fs_info *fs_info =3D bioc->fs_info;
>   	struct btrfs_raid_bio *rbio;
> @@ -1820,12 +1820,12 @@ int raid56_parity_write(struct bio *bio, struct =
btrfs_io_context *bioc)
>   	rbio =3D alloc_rbio(fs_info, bioc);
>   	if (IS_ERR(rbio)) {
>   		btrfs_put_bioc(bioc);
> -		return PTR_ERR(rbio);
> +		ret =3D PTR_ERR(rbio);
> +		goto out_err;

out_err will call btrfs_bio_counter_dec(fs_info);

But at this branch, we don't yet have called
`btrfs_bio_counter_inc_noblocked()`.

Wouldn't this cause underflow?

Thanks,
Qu
>   	}
>   	rbio->operation =3D BTRFS_RBIO_WRITE;
>   	rbio_add_bio(rbio, bio);
>
> -	btrfs_bio_counter_inc_noblocked(fs_info);
>   	rbio->generic_bio_cnt =3D 1;
>
>   	/*
> @@ -1835,8 +1835,8 @@ int raid56_parity_write(struct bio *bio, struct bt=
rfs_io_context *bioc)
>   	if (rbio_is_full(rbio)) {
>   		ret =3D full_stripe_write(rbio);
>   		if (ret)
> -			btrfs_bio_counter_dec(fs_info);
> -		return ret;
> +			goto out_err;
> +		return;
>   	}
>
>   	cb =3D blk_check_plugged(btrfs_raid_unplug, fs_info, sizeof(*plug));
> @@ -1851,9 +1851,14 @@ int raid56_parity_write(struct bio *bio, struct b=
trfs_io_context *bioc)
>   	} else {
>   		ret =3D __raid56_parity_write(rbio);
>   		if (ret)
> -			btrfs_bio_counter_dec(fs_info);
> +			goto out_err;
>   	}
> -	return ret;
> +	return;
> +
> +out_err:
> +	btrfs_bio_counter_dec(fs_info);
> +	bio->bi_status =3D errno_to_blk_status(ret);
> +	bio_endio(bio);
>   }
>
>   /*
> @@ -2199,8 +2204,8 @@ static int __raid56_parity_recover(struct btrfs_ra=
id_bio *rbio)
>    * so we assume the bio they send down corresponds to a failed part
>    * of the drive.
>    */
> -int raid56_parity_recover(struct bio *bio, struct btrfs_io_context *bio=
c,
> -			  int mirror_num, int generic_io)
> +void raid56_parity_recover(struct bio *bio, struct btrfs_io_context *bi=
oc,
> +			   int mirror_num, bool generic_io)
>   {
>   	struct btrfs_fs_info *fs_info =3D bioc->fs_info;
>   	struct btrfs_raid_bio *rbio;
> @@ -2209,13 +2214,14 @@ int raid56_parity_recover(struct bio *bio, struc=
t btrfs_io_context *bioc,
>   	if (generic_io) {
>   		ASSERT(bioc->mirror_num =3D=3D mirror_num);
>   		btrfs_bio(bio)->mirror_num =3D mirror_num;
> +	} else {
> +		btrfs_get_bioc(bioc);
>   	}
>
>   	rbio =3D alloc_rbio(fs_info, bioc);
>   	if (IS_ERR(rbio)) {
> -		if (generic_io)
> -			btrfs_put_bioc(bioc);
> -		return PTR_ERR(rbio);
> +		ret =3D PTR_ERR(rbio);
> +		goto out_err;
>   	}
>
>   	rbio->operation =3D BTRFS_RBIO_READ_REBUILD;
> @@ -2227,18 +2233,12 @@ int raid56_parity_recover(struct bio *bio, struc=
t btrfs_io_context *bioc,
>   "%s could not find the bad stripe in raid56 so that we cannot recover =
any more (bio has logical %llu len %llu, bioc has map_type %llu)",
>   			   __func__, bio->bi_iter.bi_sector << 9,
>   			   (u64)bio->bi_iter.bi_size, bioc->map_type);
> -		if (generic_io)
> -			btrfs_put_bioc(bioc);
>   		kfree(rbio);
> -		return -EIO;
> +		goto out_err;
>   	}
>
> -	if (generic_io) {
> -		btrfs_bio_counter_inc_noblocked(fs_info);
> +	if (generic_io)
>   		rbio->generic_bio_cnt =3D 1;
> -	} else {
> -		btrfs_get_bioc(bioc);
> -	}
>
>   	/*
>   	 * Loop retry:
> @@ -2257,8 +2257,6 @@ int raid56_parity_recover(struct bio *bio, struct =
btrfs_io_context *bioc,
>   			rbio->failb--;
>   	}
>
> -	ret =3D lock_stripe_add(rbio);
> -
>   	/*
>   	 * __raid56_parity_recover will end the bio with
>   	 * any errors it hits.  We don't want to return
> @@ -2266,15 +2264,20 @@ int raid56_parity_recover(struct bio *bio, struc=
t btrfs_io_context *bioc,
>   	 * will end up calling bio_endio with any nonzero
>   	 * return
>   	 */
> -	if (ret =3D=3D 0)
> +	if (lock_stripe_add(rbio) =3D=3D 0)
>   		__raid56_parity_recover(rbio);
> +
>   	/*
>   	 * our rbio has been added to the list of
>   	 * rbios that will be handled after the
>   	 * currently lock owner is done
>   	 */
> -	return 0;
> +	return;
>
> +out_err:
> +	btrfs_put_bioc(bioc);
> +	bio->bi_status =3D errno_to_blk_status(ret);
> +	bio_endio(bio);
>   }
>
>   static void rmw_work(struct work_struct *work)
> diff --git a/fs/btrfs/raid56.h b/fs/btrfs/raid56.h
> index 9e4e0501e4e89..c94f503eb3832 100644
> --- a/fs/btrfs/raid56.h
> +++ b/fs/btrfs/raid56.h
> @@ -175,9 +175,9 @@ static inline int nr_data_stripes(const struct map_l=
ookup *map)
>
>   struct btrfs_device;
>
> -int raid56_parity_recover(struct bio *bio, struct btrfs_io_context *bio=
c,
> -			  int mirror_num, int generic_io);
> -int raid56_parity_write(struct bio *bio, struct btrfs_io_context *bioc)=
;
> +void raid56_parity_recover(struct bio *bio, struct btrfs_io_context *bi=
oc,
> +			   int mirror_num, bool generic_io);
> +void raid56_parity_write(struct bio *bio, struct btrfs_io_context *bioc=
);
>
>   void raid56_add_scrub_pages(struct btrfs_raid_bio *rbio, struct page *=
page,
>   			    unsigned int pgoff, u64 logical);
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 18986d062cf63..f091e57222082 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -1376,18 +1376,12 @@ static int scrub_submit_raid56_bio_wait(struct b=
trfs_fs_info *fs_info,
>   					struct scrub_sector *sector)
>   {
>   	DECLARE_COMPLETION_ONSTACK(done);
> -	int ret;
> -	int mirror_num;
>
>   	bio->bi_iter.bi_sector =3D sector->logical >> 9;
>   	bio->bi_private =3D &done;
>   	bio->bi_end_io =3D scrub_bio_wait_endio;
> -
> -	mirror_num =3D sector->sblock->sectors[0]->mirror_num;
> -	ret =3D raid56_parity_recover(bio, sector->recover->bioc,
> -				    mirror_num, 0);
> -	if (ret)
> -		return ret;
> +	raid56_parity_recover(bio, sector->recover->bioc,
> +			      sector->sblock->sectors[0]->mirror_num, false);
>
>   	wait_for_completion_io(&done);
>   	return blk_status_to_errno(bio->bi_status);
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 739676944e94d..3a8c437bdd65b 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -6749,8 +6749,12 @@ void btrfs_submit_bio(struct btrfs_fs_info *fs_in=
fo, struct bio *bio,
>   	btrfs_bio_counter_inc_blocked(fs_info);
>   	ret =3D __btrfs_map_block(fs_info, btrfs_op(bio), logical,
>   				&map_length, &bioc, mirror_num, 1);
> -	if (ret)
> -		goto out_dec;
> +	if (ret) {
> +		btrfs_bio_counter_dec(fs_info);
> +		bio->bi_status =3D errno_to_blk_status(ret);
> +		bio_endio(bio);
> +		return;
> +	}
>
>   	total_devs =3D bioc->num_stripes;
>   	bioc->orig_bio =3D bio;
> @@ -6761,10 +6765,10 @@ void btrfs_submit_bio(struct btrfs_fs_info *fs_i=
nfo, struct bio *bio,
>   	if ((bioc->map_type & BTRFS_BLOCK_GROUP_RAID56_MASK) &&
>   	    ((btrfs_op(bio) =3D=3D BTRFS_MAP_WRITE) || (mirror_num > 1))) {
>   		if (btrfs_op(bio) =3D=3D BTRFS_MAP_WRITE)
> -			ret =3D raid56_parity_write(bio, bioc);
> +			raid56_parity_write(bio, bioc);
>   		else
> -			ret =3D raid56_parity_recover(bio, bioc, mirror_num, 1);
> -		goto out_dec;
> +			raid56_parity_recover(bio, bioc, mirror_num, true);
> +		return;
>   	}
>
>   	if (map_length < length) {
> @@ -6779,12 +6783,7 @@ void btrfs_submit_bio(struct btrfs_fs_info *fs_in=
fo, struct bio *bio,
>
>   		submit_stripe_bio(bioc, bio, dev_nr, should_clone);
>   	}
> -out_dec:
>   	btrfs_bio_counter_dec(fs_info);
> -	if (ret) {
> -		bio->bi_status =3D errno_to_blk_status(ret);
> -		bio_endio(bio);
> -	}
>   }
>
>   static bool dev_args_match_fs_devices(const struct btrfs_dev_lookup_ar=
gs *args,
