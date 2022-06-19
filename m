Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF3BB5509CD
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Jun 2022 12:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234768AbiFSKp1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 19 Jun 2022 06:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235146AbiFSKpV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 19 Jun 2022 06:45:21 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD6910553
        for <linux-btrfs@vger.kernel.org>; Sun, 19 Jun 2022 03:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655635516;
        bh=jBw32gblr+T6GkpCkl6PVIwwjpUbeVyDRiwPSTq0Wrs=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=PKy7y4HzOgOcw73YjYpK5ajn1zT6cWOfIFOwaJ7ytqk/s/Ev6uewdzM4YgPnctdUL
         i57oHjpVyeKEr+jvv4/VhiD67ojNnh+WpcAGK0TzXvjOTiXyRnynWRNKe4/OKSrGaC
         fcw0PiyxUDrEGCIoLYBz7C9ytpCr3zFasljoM0Pk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N0Fxf-1no4hH0OMZ-00xO6m; Sun, 19
 Jun 2022 12:45:16 +0200
Message-ID: <59dc5c97-36c6-9737-b7ab-1d4fcfaba2e3@gmx.com>
Date:   Sun, 19 Jun 2022 18:45:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 06/10] btrfs: transfer the bio counter reference to the
 raid submission helpers
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20220617100414.1159680-1-hch@lst.de>
 <20220617100414.1159680-7-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220617100414.1159680-7-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DCuHkbd1vbXBGv8AdMka3PoYQ06x6IMnPpnTSZY9oL85rgx+BBz
 QnF7pPgYkWYv4uEFgYwUDARwHzd3RJzfxgg9uNLrekvdIeVj3qDiT2iEneXwuLahWXrWPE0
 IpR0Ipg53lZh3EGY/mdkf0m/qlY0i3GlVd67kSOcqPfn8dA6uFAIBpzy5CRpum5g6RuwzzB
 sJaGe3uW/musULnkZv/MQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SaujjEvAKE8=:G+t9lKQD88FII8889SmGoi
 YMrLjgtmT4RYGL82NcRwuT8M6d3rjX+LAZQXlkJPqcYoUo9/5QPCmoAi8BfyhmF6HZyE5yIVU
 RBhT4BVVJatioEReHGHR+uuVQGjd3yd0F3YEN71kAqU+Dss8fvL/VOHWAXF6wdAeuDyFH493b
 klCjxGSxhByC9YXwPYftbrwq+4Yl5e+Sd4ZftzwuOZWhh9Punb2QGTaO/xcK6B0CejCS2Fial
 p2MhO3mZXBlbEVCuUIaHknHYubz2ItrMSdPfA6YRy9lhSNVcpmzYmOZIzXQB10XpUnn02yyDI
 aEl/26bd86+urK4/j/PNC//2czd1FNuyZa+P8Y/liqxE//1LEVysLqfmN1GpCBbcbB4mZI0jW
 h10FKmJZckadl9EfELe9CNEKzvqQcI+UAz5KsbYLDszEcnVAGsU9PzjOCRvpKoFH85L4TQVch
 OXXEg8UbXJz7i4/rAblVPqHbkvS47wi50vf1jJ56LkEM9WM8DlVk0mMZ4/4GIQujV2jdt/7UZ
 GcqTGhn9qYdJxlVea4VXhcxCrsZCIm+VvQ7sDjKq3Js0ABBimy03wg7oyyw3VnbrHK7zbtJOM
 dWw1CHzlzlqkrZL+PebSGhUViBa601FNu4QSK0NHAIXO2wjWxylOJVP/cW6rIv9xdobxKCO42
 /jO7HZjpxwigvBc6PnheR+Zeyl0W+wslN6wr+jfQORzKhdvOUO31oElw68ZXnp2K77LBID7rI
 EV5sTgNLqFtJryYEsrU/M6xPBml0ZGJzmawrOrlpInu/3Qg1C8seFvr3Omg5030H9owE1mR8J
 uUoeM5S2uusOV1Zic12qvezYTMXNumRM/0BFUjv4RJ1NqA516Udac6zhNvfYmExgG6LPB/2m5
 94QqNyji/GwfnW1kLmiufPFQKDTt2hX+UFF5Wl3JMwlaV76eq+TVEU/RKLtzBUobQ+/4iN7qz
 NJF3287T9JTzmjo5PZJ1vejXsaK7ybrLEqq2cuqJKvGHdImwqOsZ7jiuoSzG/UIMrp4gg1bya
 SJlOCCfYxfgjVA+FFJqPqHcGidurFEvlyBBirT/yZPmoCASTWmu/OrqKUc0nFs/gEzO/lpdef
 Dr4/E9YoGBA42wGzNUb73tn8DyyGgfStFMJ8XmI4vDMRnk2tlIEGUDirw==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/17 18:04, Christoph Hellwig wrote:
> Transfer the bio counter reference acquired by btrfs_submit_bio to
> raid56_parity_write and raid56_parity_recovery together with the bio tha=
t
> the reference was acuired for instead of acquiring another reference in
> those helpers and dropping the original one in btrfs_submit_bio.

Btrfs_submit_bio() has called btrfs_bio_counter_inc_blocked(), then call
btrfs_bio_counter_dec() in its out_dec: tag.

Thus the bio counter is already paired.

Then why we want to dec the counter again in RAID56 path?

Or did I miss some patches in the past modifying the behavior?

Thanks,
Qu

>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/btrfs/raid56.c  | 16 ++++++----------
>   fs/btrfs/volumes.c | 15 +++++++--------
>   2 files changed, 13 insertions(+), 18 deletions(-)
>
> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
> index cd39c233dfdeb..00a0a2d472d88 100644
> --- a/fs/btrfs/raid56.c
> +++ b/fs/btrfs/raid56.c
> @@ -1815,12 +1815,11 @@ void raid56_parity_write(struct bio *bio, struct=
 btrfs_io_context *bioc)
>   	if (IS_ERR(rbio)) {
>   		btrfs_put_bioc(bioc);
>   		ret =3D PTR_ERR(rbio);
> -		goto out;
> +		goto out_dec_counter;
>   	}
>   	rbio->operation =3D BTRFS_RBIO_WRITE;
>   	rbio_add_bio(rbio, bio);
>
> -	btrfs_bio_counter_inc_noblocked(fs_info);
>   	rbio->generic_bio_cnt =3D 1;
>
>   	/*
> @@ -1852,7 +1851,6 @@ void raid56_parity_write(struct bio *bio, struct b=
trfs_io_context *bioc)
>
>   out_dec_counter:
>   	btrfs_bio_counter_dec(fs_info);
> -out:
>   	bio->bi_status =3D errno_to_blk_status(ret);
>   	bio_endio(bio);
>   }
> @@ -2209,6 +2207,8 @@ void raid56_parity_recover(struct bio *bio, struct=
 btrfs_io_context *bioc,
>   	if (generic_io) {
>   		ASSERT(bioc->mirror_num =3D=3D mirror_num);
>   		btrfs_bio(bio)->mirror_num =3D mirror_num;
> +	} else {
> +		btrfs_get_bioc(bioc);
>   	}
>
>   	rbio =3D alloc_rbio(fs_info, bioc);
> @@ -2231,12 +2231,8 @@ void raid56_parity_recover(struct bio *bio, struc=
t btrfs_io_context *bioc,
>   		goto out_end_bio;
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
> @@ -2266,8 +2262,8 @@ void raid56_parity_recover(struct bio *bio, struct=
 btrfs_io_context *bioc,
>   	return;
>
>   out_end_bio:
> -	if (generic_io)
> -		btrfs_put_bioc(bioc);
> +	btrfs_bio_counter_dec(fs_info);
> +	btrfs_put_bioc(bioc);
>   	bio_endio(bio);
>   }
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 844ad637a0269..fea139d628c04 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -6756,8 +6756,12 @@ void btrfs_submit_bio(struct btrfs_fs_info *fs_in=
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
> @@ -6771,7 +6775,7 @@ void btrfs_submit_bio(struct btrfs_fs_info *fs_inf=
o, struct bio *bio,
>   			raid56_parity_write(bio, bioc);
>   		else
>   			raid56_parity_recover(bio, bioc, mirror_num, true);
> -		goto out_dec;
> +		return;
>   	}
>
>   	if (map_length < length) {
> @@ -6786,12 +6790,7 @@ void btrfs_submit_bio(struct btrfs_fs_info *fs_in=
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
