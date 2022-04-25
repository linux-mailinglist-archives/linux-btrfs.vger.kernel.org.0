Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF82950DBF6
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Apr 2022 11:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241537AbiDYJGP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Apr 2022 05:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241052AbiDYJFv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Apr 2022 05:05:51 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E541F39BB2
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Apr 2022 02:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1650877276;
        bh=49pavMomVobY7Gd9W2S6LuDdjfdNDd1ZEIXeVKUhNnY=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=UZw40dl4YNTKEgACbhtx/7+2ciUAb5MzWbJjqwbtB6CXJ593dNMXYNF0KlOU36KeN
         8M1fm1X5Yv9BUF+p0qmc8Q+/yt7lGrYdOW8TTzrenJNKXWod+3rRQiQ0N20UM1hqU2
         IwbJ4WoStaAJ/CgTMj+c7HyNmGrWqZtW4gSUCteo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MRTRN-1nUq582GTV-00NUfJ; Mon, 25
 Apr 2022 11:01:16 +0200
Message-ID: <cc0cbe5c-ee50-9cd9-c718-6dc5c773a2b9@gmx.com>
Date:   Mon, 25 Apr 2022 17:01:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 10/10] btrfs: do not allocate a btrfs_bio for low-level
 bios
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
References: <20220425075418.2192130-1-hch@lst.de>
 <20220425075418.2192130-11-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220425075418.2192130-11-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7/hIMkpmwJ9nbkR5Z3yY/BYgOYcx2yLLSn4rAmyFBmA85bAFDLO
 rYUFnue9PwLeOnqo0amNbeLWvyh5890FFwlYz3jtAfImFlka9YtsOYc38lYLAnt1XcOVAQ2
 6VKxkrSib9keW7USbqk5SWzwxHklXA3GrNld2LLPx9bGJrJnh5MB+0pYF7tO6BxjXBJyJza
 CBVjKtfWvQ1faEqwX3pvA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wLcYgJtJ7Q4=:Qrwjp46N2aPvWzU7iZNb1X
 iQR0DUTjXQP2pg5+BA+9eukM1/Q8d3wIz1f/J6m7wEENyzJcJIpBhyCKMfwAZOmGyi9LUINgL
 wSH+ZniFrj24Dwjnlm01Z0V/ZMWP5Y4shm6s9v63z9M9RBpNF//kEyXmkW057aEEfGGbphGYK
 u9jdN06m+InRkrCMjSuzTPc/pZ2IlMuSIWgZE0wWNYxpVwhzgI1RUXpjosxV9YXkaCzm0iGQ8
 a3TnZCYwOLyfMhatJJOjsS/7MxrddaHfvbxC9rdEe965vBxUAwPJdF460g73OoEFHwMBl7Ude
 verq6W21/ril2zosm7GyO3136uaH17kBKBSBmvgTvtIbyI6IXo3XIqWTzFbfXGa7fpGyIbSvJ
 Zz4lDM47oZF/tiISFyLWi3H4x2Px5Yd15BzbehtVV1HobiSz29UDu3kcP5BQQvrNVY296P9tU
 Ule/xgbon2v0M7/QdBN/pKsTG/tQBzOeFeLSK/Rdekq+KYIHDiw2f2yMhveKnPFakbZN9YtEY
 S5Nklw5A33ZG3iGHBJ6Szzf9flzD8xEn8/Z9+M11HCf7MNoABHgE4Cozq3CRMHxHCdFjZ4PPc
 CsobA8OpLTYpepQnxvnbZSjfSAOl3cTzjAIAhjfniCM/9CcFU+i9XXOdbuiSo5wfz67K1J9b8
 /LMTN/W26LmS/C7Kr1pq9xdSMkMy5tQ91jXbZSAvPtS1rXcpy326f+JiiYdK5QA9Xk56QGT4N
 UpmAFvXqkC45ZKaFdYpBMvjhJ7cDBXfNv+ToJABvTVrvypnUh3ym2MtXUx1Ky9cyXQLAVb6gx
 m3Jo8dORxyO7aTrmFZ4+era+mwsAZ01J36s69WnxQctblVSfERZpoxebIlsh/JAAN44OtDHzz
 40qX5v33v8FkEytR6dt2o+t7fYCJR7fFfA1PC0VcizeTF0rkC4s1KbtWNjGKYNU+csZpKA0ax
 5g5qbid7/rZzZzjiudWW7/suFnFT3Q9QYGZV5z90eaaCFLtSnt2iyBfyHas+77yoVw90H4qUG
 fgvuBcOWKw84GxT/btLTsDkJ1P4Lbq27R6P62Pj1+B+uXC5udHX19Q7qA4crLLoCcTxcWbyBv
 6r5ELAu58yoCQY=
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/4/25 15:54, Christoph Hellwig wrote:
> The bios submitted from btrfs_map_bio don't really interact with the
> rest of btrfs and the only btrfs_bio member actually used in the
> low-level bios is the pointer to the btrfs_io_contex used for endio
> handler.
>
> Use a union in struct btrfs_io_stripe that allows the endio handler to
> find the btrfs_io_context and remove the spurious ->device assignment
> so that a plain fs_bio_set bio can be used for the low-level bios
> allocated inside btrfs_map_bio.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/btrfs/extent_io.c | 13 -------------
>   fs/btrfs/extent_io.h |  1 -
>   fs/btrfs/volumes.c   | 20 ++++++++++----------
>   fs/btrfs/volumes.h   |  5 ++++-
>   4 files changed, 14 insertions(+), 25 deletions(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index a14ed9b9dc2d0..37f4eee418219 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -3209,19 +3209,6 @@ struct bio *btrfs_bio_alloc(unsigned int nr_iovec=
s)
>   	return bio;
>   }
>
> -struct bio *btrfs_bio_clone(struct block_device *bdev, struct bio *bio)
> -{
> -	struct btrfs_bio *bbio;
> -	struct bio *new;
> -
> -	/* Bio allocation backed by a bioset does not fail */
> -	new =3D bio_alloc_clone(bdev, bio, GFP_NOFS, &btrfs_bioset);
> -	bbio =3D btrfs_bio(new);
> -	btrfs_bio_init(bbio);
> -	bbio->iter =3D bio->bi_iter;
> -	return new;
> -}
> -
>   struct bio *btrfs_bio_clone_partial(struct bio *orig, u64 offset, u64 =
size)
>   {
>   	struct bio *bio;
> diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
> index b390ec79f9a86..3078e90be3a99 100644
> --- a/fs/btrfs/extent_io.h
> +++ b/fs/btrfs/extent_io.h
> @@ -265,7 +265,6 @@ void extent_clear_unlock_delalloc(struct btrfs_inode=
 *inode, u64 start, u64 end,
>
>   int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_a=
rray);
>   struct bio *btrfs_bio_alloc(unsigned int nr_iovecs);
> -struct bio *btrfs_bio_clone(struct block_device *bdev, struct bio *bio)=
;
>   struct bio *btrfs_bio_clone_partial(struct bio *orig, u64 offset, u64 =
size);
>
>   void end_extent_writepage(struct page *page, int err, u64 start, u64 e=
nd);
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index d54aacb4f05f2..c621bd631450a 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -6666,23 +6666,21 @@ static void btrfs_end_bioc(struct btrfs_io_conte=
xt *bioc, bool async)
>
>   static void btrfs_end_bio(struct bio *bio)
>   {
> -	struct btrfs_io_context *bioc =3D bio->bi_private;
> +	struct btrfs_io_stripe *stripe =3D bio->bi_private;
> +	struct btrfs_io_context *bioc =3D stripe->bioc;
>
>   	if (bio->bi_status) {
>   		atomic_inc(&bioc->error);
>   		if (bio->bi_status =3D=3D BLK_STS_IOERR ||
>   		    bio->bi_status =3D=3D BLK_STS_TARGET) {
> -			struct btrfs_device *dev =3D btrfs_bio(bio)->device;
> -
> -			ASSERT(dev->bdev);
>   			if (btrfs_op(bio) =3D=3D BTRFS_MAP_WRITE)
> -				btrfs_dev_stat_inc_and_print(dev,
> +				btrfs_dev_stat_inc_and_print(stripe->dev,
>   						BTRFS_DEV_STAT_WRITE_ERRS);
>   			else if (!(bio->bi_opf & REQ_RAHEAD))
> -				btrfs_dev_stat_inc_and_print(dev,
> +				btrfs_dev_stat_inc_and_print(stripe->dev,
>   						BTRFS_DEV_STAT_READ_ERRS);
>   			if (bio->bi_opf & REQ_PREFLUSH)
> -				btrfs_dev_stat_inc_and_print(dev,
> +				btrfs_dev_stat_inc_and_print(stripe->dev,
>   						BTRFS_DEV_STAT_FLUSH_ERRS);
>   		}
>   	}
> @@ -6714,14 +6712,16 @@ static void submit_stripe_bio(struct btrfs_io_co=
ntext *bioc,
>   	}
>
>   	if (clone) {
> -		bio =3D btrfs_bio_clone(dev->bdev, orig_bio);
> +		bio =3D bio_alloc_clone(dev->bdev, orig_bio, GFP_NOFS,
> +				      &fs_bio_set);
>   	} else {
>   		bio =3D orig_bio;
>   		bio_set_dev(bio, dev->bdev);
> +		btrfs_bio(bio)->device =3D dev;
>   	}
>
> -	bio->bi_private =3D bioc;
> -	btrfs_bio(bio)->device =3D dev;
> +	bioc->stripes[dev_nr].bioc =3D bioc;
> +	bio->bi_private =3D &bioc->stripes[dev_nr];
>   	bio->bi_end_io =3D btrfs_end_bio;
>   	bio->bi_iter.bi_sector =3D physical >> 9;
>   	/*
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 28e28b7c48649..825e44c82f2b0 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -396,7 +396,10 @@ static inline void btrfs_bio_free_csum(struct btrfs=
_bio *bbio)
>
>   struct btrfs_io_stripe {
>   	struct btrfs_device *dev;
> -	u64 physical;
> +	union {
> +		u64 physical;			/* block mapping */
> +		struct btrfs_io_context *bioc;	/* for the endio handler */
> +	};
>   	u64 length; /* only used for discard mappings */

Isn't @length a better candidate?

Since it's only used for discard.

Thanks,
Qu

>   };
>
