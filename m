Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0F451BDF1
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 May 2022 13:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354844AbiEEL1C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 May 2022 07:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236651AbiEEL1A (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 May 2022 07:27:00 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A7C53B73
        for <linux-btrfs@vger.kernel.org>; Thu,  5 May 2022 04:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1651749796;
        bh=/RBEHyRXtLJrP9cpWnOeRrEOtdh8vh/c6xG1dyz8lc4=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=CEix8c9OHCnURdzJBmRGpv34SrlzyXFYfBogfAinLmbbGnm40tCRcErPsVf4vUoa8
         orbGWnWizBbEgwuHd+HVTYEcbcd0L0UVSSEOS0p01fjL4AqjU+ULFXh8GeFWHijrMZ
         DBxZMI8hOQFWVkH4DyErMIUsHFPwA0vP6Rgvppsg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M5wPh-1njXJI1R2x-007Xvt; Thu, 05
 May 2022 13:23:15 +0200
Message-ID: <a56fbdc1-e707-dfab-1150-fc7c1b205dce@gmx.com>
Date:   Thu, 5 May 2022 19:23:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 10/10] btrfs: do not allocate a btrfs_bio for low-level
 bios
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20220504122524.558088-1-hch@lst.de>
 <20220504122524.558088-11-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220504122524.558088-11-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SzZxCA+n8a0X8QiSSe5TyFWccU/GJiXMTUl6bHf/6McDd0StOKh
 mcEfZhvC7P6bOI/XWpgECSmtixIKL5Z3ILjrwGei4MMutD1hq03BPuk/iig43Mv8qEewIpe
 QPp3HLhY5HbQ4LqBlJNVQ8Nf2Lap2HanayZyO8s/QFdBffQu1l09ls6vvm881IXOGJQREba
 aoN5dd0jHgdeoeQ0KeqBQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RfO6USnR8Jw=:4AUKWXp3+VKrImps+1VLAv
 FCQWA3JfmScXV4CnVT1nleyziHtRnpCGQ5JF5kcs4hjFMaLvtfU5uHYIm7ZIeSc3adNuWnJBW
 RDHa15X9vIVBjbaE5nqDZ9OzhY772ywKdbTXG/pk6NQZZDm+vviDPDNp4yXcaeM3U9Vuqu/uW
 mph1LbGpORT4LUtJDgEVv9W+2DhM8EaiAnYasjwAQq1Id9GLlyAgGWQLalpS2BckP8tV2+cJa
 Swfgo0qODIH/cSaAtdHb8mVY2pfc7N7dQYKdE3XW8Mh4JI2ydgiyFTbBPP2J+DHzt7qp407i8
 fhP7dsNa5lhCDzGzKhO11smfmiLitBtNBngTCinG0L/x3nUR6ZJlsj+CSokNMxoKS3jh8Fp7Y
 K/4R/BooSF2M/9EqTspF9thYcQCGXMv7rjpMu48JFx/43MKPb+fpnd6iZWbJckNkfoO7hQ28p
 BL71HY1kZ9zx6LGcpKENxuyXnnNXGwQGv5oDDzeJUjhuxcb2ZUMzh0sNu/Bmom+rqbn5IPZ9E
 AMe5uLgKEbJHjKDxMyshT+4a1Hc9A2BWIeqnH1jsmxyKtidPHVhv10kRKKlXlU3Gby2zh0kAy
 5Pfu8TFTq9m5EfE3oZlxg8yD70ve/gKcg6c4Gp+6YJk+HhfS0mnE1jWHc9RBnHNOZUhZESiiB
 Wf2oWJzrZwm7DefDhmhfGHoAOOA6XWSfQC6Ckbv7aeaO/X3ZQymjYXtMLG16wY3PjrXQK3UKf
 KXBC7dlNbRLsHEdz5bszjaeRs5cPPB6+2GEglozlIGXeF4ytmWjGEOaWmq9Oy+OMmSY/sGgvo
 bmk02ou3VCeTIWe2p0zlOt3f4wKtBgbaXsxIXwCKNHlt6EPlAMiHK/3dH1OftVhtAM4EdiuU2
 RHnzuF8yolgcbAZJhSBYKy/0sLJyOtVrBO9serPO7J2dhKpvwkvCmn/L8zj/XnoIsUkIFnW6z
 maFFYzPXn4RCjycu51duVPorz/5dmGYaz+Gexksivgoau6IrQ6brYnL6Vno/vUys5opjnXzLN
 hwhwYDZScM3AzmDBK3Tudg4rOPiLNHaX69+Q+GvXcoKf9jnDrUDFX22QO5NLBNYV69LsxhBou
 FSNGrkj1JO9wog=
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

Although such union is not that reader friendly, it should be safe enough.

Reviewed-by: Qu Wenruo <wqu@suse.com>


Although in the future, I may add a new bioset for such low-level bios
for other purposes (like read-repair at per-stripe level), thus may
allow a more readable solution.
But that would be another story in the future anyway.

Thanks,
Qu
> ---
>   fs/btrfs/extent_io.c | 13 -------------
>   fs/btrfs/extent_io.h |  1 -
>   fs/btrfs/volumes.c   | 20 ++++++++++----------
>   fs/btrfs/volumes.h   |  5 ++++-
>   4 files changed, 14 insertions(+), 25 deletions(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 93191771e5bf1..7efbc964585d3 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -3210,19 +3210,6 @@ struct bio *btrfs_bio_alloc(unsigned int nr_iovec=
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
> index 17674b7e699c6..ce69a4732f718 100644
> --- a/fs/btrfs/extent_io.h
> +++ b/fs/btrfs/extent_io.h
> @@ -248,7 +248,6 @@ void extent_clear_unlock_delalloc(struct btrfs_inode=
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
> index 28ac2bfb5d296..8577893ccb4b9 100644
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
>   };
>
