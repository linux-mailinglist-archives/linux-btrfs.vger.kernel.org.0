Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9289717AA8
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 May 2023 10:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234452AbjEaIuh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 May 2023 04:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjEaIuE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 May 2023 04:50:04 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309BCE79
        for <linux-btrfs@vger.kernel.org>; Wed, 31 May 2023 01:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
        t=1685522975; i=quwenruo.btrfs@gmx.com;
        bh=GKC1YczsbDznYizIE1sXt1usdy+gqVIGM9e5rJfIdSI=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=kiSs24aPTRbFw0x2N1AGhclj6ZmsC6D5I2MLZMbanCtId7StcGlUEcHMtPnEoTthw
         pniGiqmPC8Skbf8F0QNuJFtUcOeq3QyGiW7UcxVnk51SFf/H256CLxXHY4zIQU3w/1
         +2AUQjdMmKapE8NZkBvr3IogQZHJi8ETETYtjMdEG2xjN+YOQwLjtGc8Li7fiYhojQ
         zcVHwHw+HoGsIx0ddFzZ8s1HzfBe9rRQWccxLJfDZc2WD55gfbU7GpGQGwYTLBbKRt
         K9Mk/L+IaJyew1VIS6L8zSEHWk59/zSHCfEFwpZAZtKPNvzytY21CsnG4E9S3cUNzM
         ASt6Zfx6eWZsA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mqs0X-1qQCD80uv3-00moIO; Wed, 31
 May 2023 10:49:35 +0200
Message-ID: <9dddd440-6842-b042-2340-3efc67d1faa2@gmx.com>
Date:   Wed, 31 May 2023 16:49:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 5/6] btrfs: remove btrfs_map_sblock
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20230531041740.375963-1-hch@lst.de>
 <20230531041740.375963-6-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230531041740.375963-6-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:E8aKFy2zWZ72+InBcE9ZEdMWTjLCxp10+9rKH94qiPN9K9RpIqL
 H7D/mlpR0Uwqft41MiFplatFjel1iJ7xJtaQrjo7pN0VnoF6OTbuw17ENU3R6s0CoLFIyiA
 NZzgfWe+k9udO6qKbnXC+686ZrBBCBSlA61PiD6l2NJQJ6roG86VPMN1mvAHeRySKgayA1q
 ZOIYyVqEkPvfSBbeNo4FA==
UI-OutboundReport: notjunk:1;M01:P0:IpJhDRdNJjE=;FK8GuAOoN8+E++ihsy9BbpMFA4/
 9/qXDp/S50mFFCLxb2S+FF3ajY9LP60Eya30S20pulMrOOxio+OGnMdyA+vlaFvUNeooUbB4Z
 4aPQsqqKgTF/lGxor+Ha8keGYUOirt1Pv3zBl6elaaBnTfomQ+iZsKgalhEP1di5KQqkTwkKN
 xBWeztESpH1lPzjlLLTgDFt7tNM2ENnMlvpBCGlfsj81s3oAQinj99XQfaR8+tXplOIROcoNt
 8QqmLtAKwF4XpFzXoHht12TYf8Gxu8IdMSHaAUwUnozODzXFk8SeP+deMrPuUDm25PrFIz061
 qDlfpQwlBEzYXLXmI4WrTxpNru4enkd4NosPta6ruSUkjspB7iqKyP4koSOfI6Msbp8huGlhN
 dvZsXiv2GUyvMwxdXGaokqwgOddNu9EnDemy35+jxVHWilWt3jciE4FuefgmUflFtUvWhBTya
 4U4Fz1eUya0MZShAm9Zo38zXnVzHmPzlnmXdfCFGIKaK80T9pXvc3an+zEnMfKA5NEYGkIqcp
 C9/WaktOshizq6JEVvSiCB9D8O+1aFreAEWs10slZbwrxvW6TAN5uJihVCkG27wQvFo8CyZjd
 Asdc9PrFRYHqATl3NZ12JWWs2474XfxGr9i8zWKKGZV50Twoq4cz3WUZZ39rZ5iGsap/lsm1W
 KXY6D2klOafr3yxsnOefsV68s/hicmkVErQTYQTkWJYkc1YjYB1jm0Im/cTcOgOcJ+VjncoWC
 n/vwlAJsL+Voo68OmUgnZok+ZcgeQdLQIor4/5lovqwdbAjHmd7w4mg6zSaMmTFELxSzR9Hbt
 QwKGeztEd3usIwIP/PWHRCynUnzSdJ70TlR3UoqcPfaCZFPHqQoPC0Q/sGgIqChblV4/sYTzx
 dG13mYuzOwv/pIm4Vihz7vc0vpB8G+eXw9iRfsO8/tGJAp6uUTQMfRSY1BCs/6LFoQeU5C5Av
 LQkY2IVzbSgW6Gqh3GQ/MYSRvro=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/5/31 12:17, Christoph Hellwig wrote:
> btrfs_map_sblock just hardcodes three arguments and calls
> btrfs_map_sblock.  Remove it as it doesn't provide any real
> value, but makes following the btrfs_map_block callchains harder.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/scrub.c   | 9 +++++----
>   fs/btrfs/volumes.c | 9 ---------
>   fs/btrfs/volumes.h | 3 ---
>   fs/btrfs/zoned.c   | 4 ++--
>   4 files changed, 7 insertions(+), 18 deletions(-)
>
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index d7d8faf1978a87..8fce48d9e07a85 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -882,8 +882,9 @@ static void scrub_stripe_report_errors(struct scrub_=
ctx *sctx,
>
>   		/* For scrub, our mirror_num should always start at 1. */
>   		ASSERT(stripe->mirror_num >=3D 1);
> -		ret =3D btrfs_map_sblock(fs_info, BTRFS_MAP_GET_READ_MIRRORS,
> -				       stripe->logical, &mapped_len, &bioc);
> +		ret =3D btrfs_map_block(fs_info, BTRFS_MAP_GET_READ_MIRRORS,
> +				      stripe->logical, &mapped_len, &bioc,
> +				      NULL, NULL, 1);
>   		/*
>   		 * If we failed, dev will be NULL, and later detailed reports
>   		 * will just be skipped.
> @@ -1893,8 +1894,8 @@ static int scrub_raid56_parity_stripe(struct scrub=
_ctx *sctx,
>   	bio->bi_end_io =3D raid56_scrub_wait_endio;
>
>   	btrfs_bio_counter_inc_blocked(fs_info);
> -	ret =3D btrfs_map_sblock(fs_info, BTRFS_MAP_WRITE, full_stripe_start,
> -			       &length, &bioc);
> +	ret =3D btrfs_map_block(fs_info, BTRFS_MAP_WRITE, full_stripe_start,
> +			      &length, &bioc, NULL, NULL, 1);
>   	if (ret < 0) {
>   		btrfs_put_bioc(bioc);
>   		btrfs_bio_counter_dec(fs_info);
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 53059ee04f9b60..6141a9fe5a28a0 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -6481,15 +6481,6 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info=
, enum btrfs_map_op op,
>   	return ret;
>   }
>
> -/* For Scrub/replace */
> -int btrfs_map_sblock(struct btrfs_fs_info *fs_info, enum btrfs_map_op o=
p,
> -		     u64 logical, u64 *length,
> -		     struct btrfs_io_context **bioc_ret)
> -{
> -	return btrfs_map_block(fs_info, op, logical, length, bioc_ret,
> -				 NULL, NULL, 1);
> -}
> -
>   static bool dev_args_match_fs_devices(const struct btrfs_dev_lookup_ar=
gs *args,
>   				      const struct btrfs_fs_devices *fs_devices)
>   {
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index c70805c8d89554..3930ee01d6968f 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -582,9 +582,6 @@ static inline unsigned long btrfs_chunk_item_size(in=
t num_stripes)
>
>   void btrfs_get_bioc(struct btrfs_io_context *bioc);
>   void btrfs_put_bioc(struct btrfs_io_context *bioc);
> -int btrfs_map_sblock(struct btrfs_fs_info *fs_info, enum btrfs_map_op o=
p,
> -		     u64 logical, u64 *length,
> -		     struct btrfs_io_context **bioc_ret);
>   int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op o=
p,
>   		    u64 logical, u64 *length,
>   		    struct btrfs_io_context **bioc_ret,
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index e311aae8f1ddca..bbde4ddd475492 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -1782,8 +1782,8 @@ static int read_zone_info(struct btrfs_fs_info *fs=
_info, u64 logical,
>   	int nmirrors;
>   	int i, ret;
>
> -	ret =3D btrfs_map_sblock(fs_info, BTRFS_MAP_GET_READ_MIRRORS, logical,
> -			       &mapped_length, &bioc);
> +	ret =3D btrfs_map_block(fs_info, BTRFS_MAP_GET_READ_MIRRORS, logical,
> +			      &mapped_length, &bioc, NULL, NULL, 1);
>   	if (ret || !bioc || mapped_length < PAGE_SIZE) {
>   		ret =3D -EIO;
>   		goto out_put_bioc;
