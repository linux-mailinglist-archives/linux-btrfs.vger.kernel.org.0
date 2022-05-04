Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49BEC519FEC
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 May 2022 14:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239420AbiEDMuv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 May 2022 08:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350047AbiEDMug (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 May 2022 08:50:36 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4762CE37
        for <linux-btrfs@vger.kernel.org>; Wed,  4 May 2022 05:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1651668415;
        bh=AtZEKZNYC5IetjOfjwA+YpE3hzZBD762nOOn29JY8WU=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=i3LFVEtPwylrOuvA7psin+FF4+crvMWvd3IAUAW9KLIdL5TPlaTpK84KDmkrxENPv
         +Jsd3U2shWaQ7br0mafbu4ol076HpWRA7c/7yQ7cp0TYdiOLxJ689kZopCKUKtXqAS
         WvpVRNL2nx5cDCb446f7ymWs8k/R4jr+Qs0g6hLI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N8XTv-1nqvCp1HJR-014RBE; Wed, 04
 May 2022 14:46:55 +0200
Message-ID: <5aa3ffc2-2c34-54b0-c122-b6e9d7f8b79b@gmx.com>
Date:   Wed, 4 May 2022 20:46:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 09/10] btrfs: refactor btrfs_map_bio
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20220504122524.558088-1-hch@lst.de>
 <20220504122524.558088-10-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220504122524.558088-10-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TtOnZGaC6BByK3wY4exEq68/B/k8iYN292towX6weSAMlIF+YaM
 WVMs3KW6XS5fjEnN5pG+0xlg/2UmLrCtJMwq3AWTjAFDwBFTiGzhJXhAr6aRQNo7B5tLCdf
 nzGzABVyQkwUe0pMYRB5Vwzd3JATyAHG5tJA5IRFo++c21XMCMOc8lVCuRHzVUNLC7j4GYt
 en0gPw5kgk5i6vcikNOWA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6kdhODv0NAo=:hEk5pcQH0aZlaC3jBQ7G5B
 mlc/AuhbMS99DPAx5tBONXVOQj0cx3mOoq5kWU/4lczkgyt/Gwke8sdsk1tTENZmNsEjeqMyJ
 PyX9USd1J1CKBkdkFEExBz8WnDStiMyDdjQRjk9UmNIKf+ErJl8rW2fHO7s5ubc3TKSprLuLJ
 JDefY3CnSiV4B28esHdq3SsDZVLffrp3BxFtl1bAMMCUWhYGQqK+cF5LDNtVLI7E86imxU5ou
 LlO+It4loPlnUrdaEu4P+vs8VKPKqcRU2OY51rIlreBS/qT6pL2bsV1ZpShJHcSylQ2Ya0P9I
 Uv8Vm4zul7krHq2a7nPjF96v9YNbJ1d6WhLBOwTrmA2B7/Peo3FCldA8LYGMnvuFoHQqM95yp
 zKqXytFqKaCsyXgCmhC0ku0VeUSd53xcG/Ca64CUnlgiPtON+zkZL7ANvvRaA8oRFTAezz4b4
 41YjEVEaeWsVMJ1qRGU/DHUlI699E5pmqdoZwECn8R1se6tX/Y7PszOcLX3BSC4IV6ALPN5P/
 EjGRbHkiQiz1RKrNMS3amtsvUlTVsj02zcMCO9j/yZijYiLXR7x63NZn0PqPggJvPqTw/wWGl
 mTMrNamQXe97ZB0OubadYlK031vOaEo+DHoPFnr8bDj+M2KbCE0nhD1t/GvGO2D16am9ncYWf
 Bq00ikKT0avD9b2lCIsko7KpWK9UV0oLwUF6nV2aFFSGkb/vIu/rNF2PLsHBf5lKkytqhVOK3
 lpBsxKAQ8N64s6oZHEpfINHYgYl31BDB6iTZdhWeqTfZ6SxyW79nx5vPtTB1CHYGDQQ2dAMTE
 gGOuCjWdBhBdIyP7EVAgRUw66S2OcP9q0i/D1/sl+oF/z24nhzJi8+Wz9zBNhDDItFkueEht2
 etRSSl8Dr+uducrSjGKOepYujI6hwl6IpVYerTSXdrA+pzWMI6syEzQ3Ng5wQcUViTRgqD20x
 ewmAAE1C3jZWijdwNRc9ysFyFQQ/16KtFXGR2SJdK9eeYZd9lNCVO5xl31OrhYCDJH7WGZ/zw
 lwupi2mAMoHUUgUZ3vkHPD1jRQ2JFhAYQlzGlbminqMD5Xl9X909JVuLzB6GqLqUAClBP0GBh
 HolsbVPKN5Si7w=
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
> Move all per-stripe handling into submit_stripe_bio and use a label to
> cleanup instead of duplicating the logic.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/volumes.c | 77 +++++++++++++++++++++-------------------------
>   1 file changed, 35 insertions(+), 42 deletions(-)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 5f18e9105fe08..28ac2bfb5d296 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -6695,10 +6695,30 @@ static void btrfs_end_bio(struct bio *bio)
>   		btrfs_end_bioc(bioc, true);
>   }
>
> -static void submit_stripe_bio(struct btrfs_io_context *bioc, struct bio=
 *bio,
> -			      u64 physical, struct btrfs_device *dev)
> +static void submit_stripe_bio(struct btrfs_io_context *bioc,
> +		struct bio *orig_bio, int dev_nr, bool clone)
>   {
>   	struct btrfs_fs_info *fs_info =3D bioc->fs_info;
> +	struct btrfs_device *dev =3D bioc->stripes[dev_nr].dev;
> +	u64 physical =3D bioc->stripes[dev_nr].physical;
> +	struct bio *bio;
> +
> +	if (!dev || !dev->bdev ||
> +	    test_bit(BTRFS_DEV_STATE_MISSING, &dev->dev_state) ||
> +	    (btrfs_op(orig_bio) =3D=3D BTRFS_MAP_WRITE &&
> +	     !test_bit(BTRFS_DEV_STATE_WRITEABLE, &dev->dev_state))) {
> +		atomic_inc(&bioc->error);
> +		if (atomic_dec_and_test(&bioc->stripes_pending))
> +			btrfs_end_bioc(bioc, false);
> +		return;
> +	}
> +
> +	if (clone) {
> +		bio =3D btrfs_bio_clone(dev->bdev, orig_bio);
> +	} else {
> +		bio =3D orig_bio;
> +		bio_set_dev(bio, dev->bdev);
> +	}
>
>   	bio->bi_private =3D bioc;
>   	btrfs_bio(bio)->device =3D dev;
> @@ -6733,32 +6753,25 @@ static void submit_stripe_bio(struct btrfs_io_co=
ntext *bioc, struct bio *bio,
>   blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *=
bio,
>   			   int mirror_num)
>   {
> -	struct btrfs_device *dev;
> -	struct bio *first_bio =3D bio;
>   	u64 logical =3D bio->bi_iter.bi_sector << 9;
> -	u64 length =3D 0;
> -	u64 map_length;
> +	u64 length =3D bio->bi_iter.bi_size;
> +	u64 map_length =3D length;
>   	int ret;
>   	int dev_nr;
>   	int total_devs;
>   	struct btrfs_io_context *bioc =3D NULL;
>
> -	length =3D bio->bi_iter.bi_size;
> -	map_length =3D length;
> -
>   	btrfs_bio_counter_inc_blocked(fs_info);
>   	ret =3D __btrfs_map_block(fs_info, btrfs_op(bio), logical,
>   				&map_length, &bioc, mirror_num, 1);
> -	if (ret) {
> -		btrfs_bio_counter_dec(fs_info);
> -		return errno_to_blk_status(ret);
> -	}
> +	if (ret)
> +		goto out_dec;
>
>   	total_devs =3D bioc->num_stripes;
> -	bioc->orig_bio =3D first_bio;
> -	bioc->private =3D first_bio->bi_private;
> -	bioc->end_io =3D first_bio->bi_end_io;
> -	atomic_set(&bioc->stripes_pending, bioc->num_stripes);
> +	bioc->orig_bio =3D bio;
> +	bioc->private =3D bio->bi_private;
> +	bioc->end_io =3D bio->bi_end_io;
> +	atomic_set(&bioc->stripes_pending, total_devs);
>
>   	if ((bioc->map_type & BTRFS_BLOCK_GROUP_RAID56_MASK) &&
>   	    ((btrfs_op(bio) =3D=3D BTRFS_MAP_WRITE) || (mirror_num > 1))) {
> @@ -6770,9 +6783,7 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info *f=
s_info, struct bio *bio,
>   			ret =3D raid56_parity_recover(bio, bioc, map_length,
>   						    mirror_num, 1);
>   		}
> -
> -		btrfs_bio_counter_dec(fs_info);
> -		return errno_to_blk_status(ret);
> +		goto out_dec;
>   	}
>
>   	if (map_length < length) {
> @@ -6782,29 +6793,11 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info =
*fs_info, struct bio *bio,
>   		BUG();
>   	}
>
> -	for (dev_nr =3D 0; dev_nr < total_devs; dev_nr++) {
> -		dev =3D bioc->stripes[dev_nr].dev;
> -		if (!dev || !dev->bdev || test_bit(BTRFS_DEV_STATE_MISSING,
> -						   &dev->dev_state) ||
> -		    (btrfs_op(first_bio) =3D=3D BTRFS_MAP_WRITE &&
> -		    !test_bit(BTRFS_DEV_STATE_WRITEABLE, &dev->dev_state))) {
> -			atomic_inc(&bioc->error);
> -			if (atomic_dec_and_test(&bioc->stripes_pending))
> -				btrfs_end_bioc(bioc, false);
> -			continue;
> -		}
> -
> -		if (dev_nr < total_devs - 1) {
> -			bio =3D btrfs_bio_clone(dev->bdev, first_bio);
> -		} else {
> -			bio =3D first_bio;
> -			bio_set_dev(bio, dev->bdev);
> -		}
> -
> -		submit_stripe_bio(bioc, bio, bioc->stripes[dev_nr].physical, dev);
> -	}
> +	for (dev_nr =3D 0; dev_nr < total_devs; dev_nr++)
> +		submit_stripe_bio(bioc, bio, dev_nr, dev_nr < total_devs - 1);
> +out_dec:
>   	btrfs_bio_counter_dec(fs_info);
> -	return BLK_STS_OK;
> +	return errno_to_blk_status(ret);
>   }
>
>   static bool dev_args_match_fs_devices(const struct btrfs_dev_lookup_ar=
gs *args,
