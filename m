Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A47154F59F
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jun 2022 12:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380871AbiFQKih (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jun 2022 06:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381976AbiFQKiR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jun 2022 06:38:17 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60606006C
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jun 2022 03:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655462289;
        bh=sjx8a0P6wP0DRACBY+2RKdPGtUBv5gr0PWnzpZ4ayZ8=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=BD+lxDj3duoSmD6oDxcyeIWpUvyKamNyJQcTALvFozj2esMZOLILwNo/zNOz9x2jT
         mwg4m7mKMTS7DPrt/ThaGIR07aJLJUbIZdsfrE7tTETbEskgDPkxSftYRthq91ZdQ7
         Gbh28IEUZZ3mRXr1mOZNEpMwqMZxpDI8MqGKWAWQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MLi8g-1oJgFU3WSG-00HctP; Fri, 17
 Jun 2022 12:38:09 +0200
Message-ID: <b64e0808-a3c7-b549-363e-d92640d4245f@gmx.com>
Date:   Fri, 17 Jun 2022 18:38:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 04/10] btrfs: remove the raid56_parity_write return value
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20220617100414.1159680-1-hch@lst.de>
 <20220617100414.1159680-5-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220617100414.1159680-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Bq9zc42o/ijHNVbs1ORmyD94PYR5gZtubfGCQzv7HL0fnuusr2c
 LkcDym4auuVVuvWWzaEwj5qAPvC68LCldvAGglWNzSV/+1FqYIjJN+Cc4plhNqoaSm1EzQE
 K90kXLNr+g0R2TxzG5IdxJcL7xEX0kinSVds15S3DN4/2E2Vt9OUO9bcPoJHpYJHDRo90kV
 m3F5mcbMQCvdWqbbcldug==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OTZNOH5I9IA=:eBMw24YYVEwbuRwwO9CiHn
 dUR08yOm7nFbARh8Mo+iNBgHaq6ZQlFZKnZJEKjyEkHfGAIQmnFSfOdDuBdICu/u1vwWuanU8
 rGkrGueRCg+fRnedjtN5cgE42XI6FS+BvjuKVIm03+mTX9APR1i4APCUWsvaLUJA85lVpnZTi
 tM8Xry53TGU3QfF1wpfzgM/EyZ9O/N0ezH0Q7xeWejEg9E/XXf6MZlOmBR58mcPLjtyis4eF9
 1FlTpodY2UqmtkFl9agdNISTCwUFAUfjQ+nXQ7VYVJxZ6AkhSe4TX9A6ekCtiob9bwdAsugWq
 8g9raGh494UhC8mBQCMcWAze+8wbriy3im/calr2VAVPF5wVbgPtv+Ing6iZIePchj4AqlibQ
 jgQDBXeIVtM9wpXrbYsoyKjo7K7VfER+NB+ARLL996S8m5krUV7Rs8mBDFKmv9pumErRcEbAY
 +ayxLjG3AOJaZgb1ewz2uG1SA2wXJwwmNm2EdkOPptRjZ8qPtmANdr22en5IWSAHxCQHOas3F
 3rezDM/gjZwKTV33j1tbuM8ilnkqw5PSzUrpwMSmR48I/Scb9TMxRdr4tYQaJdiTP7Nr5cwnP
 WoUgfkXctkO5ICGqTVPFESCEbwrs2KBvhU3qLDQWtrkvfR71adIB2GNf6cukKCnao1gbVV1au
 Ucdxp2w//q7rI6pao5wUujerH6lTzp2kN02tJ6N3tQUafJKLSe5V9v78UIR2qsKxlGqnTcd+H
 gsj4Sniw5fJKQKyzDjBl10OQ7QACEAc3eBuQN0LqxWi2ls+ZYNMGrT0ls0O6P8slFnQAlrcWU
 JIJjWLKRFAxKv+uubhOVGhVlOFSOy3Yt6N4X3nwjW7I8CPR9YDEvNK7reBImCvoUyMCUvV5Jm
 FxEoiv686Re1t1xZ3k27pReWclrIzydgnrS5wtE2Mzverh3B75WKBlpgl4+6bkhHhNla6nZR/
 +Vu6H0aEih1jE6kkaH7aUk6wMKsnebT1OWRb4f4SeXWNTAVw4FvUjNV3jWN35INYQU6PKXzyd
 ZeuQ+Ld96Gm7BZJ2nC6r+tA7ZTJKA68Yk1esPY0vMx4Oz9qLrB9fTouho/rtv12s9FVj5E1/2
 WW8PawXmqYix7jPsXBKF42DHILqrqU+SNjgA5bPHchJ0HPFP4+OOiYA8w==
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/17 18:04, Christoph Hellwig wrote:
> Always consume the bio and call the end_io handler on error instead of
> returning an error and letting the caller handle it.  This matches what
> the block layer submission does and avoids any confusion on who
> needs to handle errors.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/raid56.c  | 23 +++++++++++++++--------
>   fs/btrfs/raid56.h  |  2 +-
>   fs/btrfs/volumes.c |  2 +-
>   3 files changed, 17 insertions(+), 10 deletions(-)
>
> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
> index 233dcef6ce3ad..c0cc2d99509c9 100644
> --- a/fs/btrfs/raid56.c
> +++ b/fs/btrfs/raid56.c
> @@ -1803,18 +1803,19 @@ static void rbio_add_bio(struct btrfs_raid_bio *=
rbio, struct bio *orig_bio)
>   /*
>    * our main entry point for writes from the rest of the FS.
>    */
> -int raid56_parity_write(struct bio *bio, struct btrfs_io_context *bioc)
> +void raid56_parity_write(struct bio *bio, struct btrfs_io_context *bioc=
)
>   {
>   	struct btrfs_fs_info *fs_info =3D bioc->fs_info;
>   	struct btrfs_raid_bio *rbio;
>   	struct btrfs_plug_cb *plug =3D NULL;
>   	struct blk_plug_cb *cb;
> -	int ret;
> +	int ret =3D 0;
>
>   	rbio =3D alloc_rbio(fs_info, bioc);
>   	if (IS_ERR(rbio)) {
>   		btrfs_put_bioc(bioc);
> -		return PTR_ERR(rbio);
> +		ret =3D PTR_ERR(rbio);
> +		goto out;
>   	}
>   	rbio->operation =3D BTRFS_RBIO_WRITE;
>   	rbio_add_bio(rbio, bio);
> @@ -1829,8 +1830,8 @@ int raid56_parity_write(struct bio *bio, struct bt=
rfs_io_context *bioc)
>   	if (rbio_is_full(rbio)) {
>   		ret =3D full_stripe_write(rbio);
>   		if (ret)
> -			btrfs_bio_counter_dec(fs_info);
> -		return ret;
> +			goto out_dec_counter;
> +		return;
>   	}
>
>   	cb =3D blk_check_plugged(btrfs_raid_unplug, fs_info, sizeof(*plug));
> @@ -1841,13 +1842,19 @@ int raid56_parity_write(struct bio *bio, struct =
btrfs_io_context *bioc)
>   			INIT_LIST_HEAD(&plug->rbio_list);
>   		}
>   		list_add_tail(&rbio->plug_list, &plug->rbio_list);
> -		ret =3D 0;
>   	} else {
>   		ret =3D __raid56_parity_write(rbio);
>   		if (ret)
> -			btrfs_bio_counter_dec(fs_info);
> +			goto out_dec_counter;
>   	}
> -	return ret;
> +
> +	return;
> +
> +out_dec_counter:
> +	btrfs_bio_counter_dec(fs_info);
> +out:
> +	bio->bi_status =3D errno_to_blk_status(ret);
> +	bio_endio(bio);
>   }
>
>   /*
> diff --git a/fs/btrfs/raid56.h b/fs/btrfs/raid56.h
> index 1dce205b79bf9..3f223ae39462a 100644
> --- a/fs/btrfs/raid56.h
> +++ b/fs/btrfs/raid56.h
> @@ -167,7 +167,7 @@ struct btrfs_device;
>
>   int raid56_parity_recover(struct bio *bio, struct btrfs_io_context *bi=
oc,
>   			  int mirror_num, int generic_io);
> -int raid56_parity_write(struct bio *bio, struct btrfs_io_context *bioc)=
;
> +void raid56_parity_write(struct bio *bio, struct btrfs_io_context *bioc=
);
>
>   void raid56_add_scrub_pages(struct btrfs_raid_bio *rbio, struct page *=
page,
>   			    unsigned int pgoff, u64 logical);
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index bdcefc19cd51e..b30d4449ef18d 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -6768,7 +6768,7 @@ void btrfs_submit_bio(struct btrfs_fs_info *fs_inf=
o, struct bio *bio,
>   	if ((bioc->map_type & BTRFS_BLOCK_GROUP_RAID56_MASK) &&
>   	    ((btrfs_op(bio) =3D=3D BTRFS_MAP_WRITE) || (mirror_num > 1))) {
>   		if (btrfs_op(bio) =3D=3D BTRFS_MAP_WRITE)
> -			ret =3D raid56_parity_write(bio, bioc);
> +			raid56_parity_write(bio, bioc);
>   		else
>   			ret =3D raid56_parity_recover(bio, bioc, mirror_num, 1);
>   		goto out_dec;
