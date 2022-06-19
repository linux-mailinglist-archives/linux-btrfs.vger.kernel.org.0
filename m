Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46B95509B4
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Jun 2022 12:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234680AbiFSKfe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 19 Jun 2022 06:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234518AbiFSKfb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 19 Jun 2022 06:35:31 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D49FD32
        for <linux-btrfs@vger.kernel.org>; Sun, 19 Jun 2022 03:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655634926;
        bh=64qFq7I2y9kxDNzuPPixkwHw79z2Gq7vUbg4Mekgn/g=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=dpTqvro8zTZOPUvETz1rOOuJn1/TSVEX8u0q/7UNTClcGw71B228BT7mMylRqogVR
         5rkc6SNeASB3cX3vdErPg+KUFkpg2zj6QNs2K3b2Bd3ux46Gq6UL3skkenYFlVbnna
         vHBYF7/K2nuRyJaREQ5tjcGweeZMARuhH/U9th+Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MxUnp-1nnW5M19FR-00xvyx; Sun, 19
 Jun 2022 12:35:25 +0200
Message-ID: <b078a3e5-1020-1560-71f4-ca8dee0500bd@gmx.com>
Date:   Sun, 19 Jun 2022 18:35:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 05/10] btrfs: remove the raid56_parity_recover return
 value
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20220617100414.1159680-1-hch@lst.de>
 <20220617100414.1159680-6-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220617100414.1159680-6-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cS8OlZBPi5ownSYNDBYNlKPoSGzreC2ttKuGf/DmjW2a6UDRTxa
 Sjp50Xr11Zuuq1bCA7iH2wifIGbW02Nep6+ICkj7YHpg2fdY9OMGaCEIx7V1ytHOoqzeYSS
 QA48nszTKyuKM53Nzz+NwwmGLcCzWoqoXjGA2qUfolEU4kEBwdPQlUzNCHzarkikO9n6rWY
 NwIXgItdxJ0iY44f1T7uQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FSb36zg27eU=:Ia7Ebxu2MQOBSOx1wOqs2F
 ATN1M2q5VWI40TjAe0/ncmis9WWNx2N376KHxbxusl8nfe1OYysLtjUnmWM5omi0VmVlHUjEX
 b2ow0SvtlHGvW/QJxS/eH81XQwppOXOPc5shxcNsvt22EbG+md9v33/LAM0OiKpTbwpAgaLnH
 8UMB+MhCFu5qvh9EwSm7HSIiT0t7pMiW90IZv1bkAJHqLB3Fa0UwfUTz6+YoyGUVpsjAtGeJA
 u6V+k4pDDja9cN7hZS/1MUZQ2wZVN0IhO9NWbC2wcNTTvRKJYpCdITu6fOSTN7o7+Vvph1MbG
 RIFkhA/WoPEp39OAtgBLQ8SA69slOR2Ss2gTfCyO56C0y5nUxATK3rGrt6c0HJkSert9J2VEn
 mAoC9fWBbwNdIATV1+K0KxuPxElcdB9UqpjRLJAODkMKvacPyzfllPnCz5oQrFddU/c4wQUFb
 /Mw23MISGjmitJM0vrB5vm0xpd5vPQLijTbleZLIPw5Ar22r7/83EsIZ08BgcU8jpJMG4v9ie
 8hNcjVqM1/zr9OmA30nBSWtzNEC2l76DAKmeByDlP0Y2AjaBDiWmZgvHRykj3genGVAZdx77b
 mD+6KyFDKz9OzTTHv/t+J8e+DfnwlqN+fXOV5IYWYYy0F31NNVp+DHdjc1okcIBnuCGJboUx+
 HGp4w8WeyB8JcX0uNHMO2ainP3UwBIhJGNwzOAnpjD8yOazUzutSxw4D6zsZqLSKIBufpdBhI
 Hmjr+mW5wMXMjBy2iMaAQlPf+J2P4Why7FRpijV6W4xAGR26C/PYUIVmh/7FGiVHA0iytNeLG
 nU5YwomwSkgO++4nqiRXjiao7qiYuOXoiANbcCU9qieiZViFdyamF/PADxjGsr8LHl38MYQ7O
 7ic+O27zDMXi9lWNXloIfeYp3+zNlrf/izqcipKbkyDvQWArKSYvTsMlnKGjQaQub2nR+GAHF
 rgncg1MrITYRR/Lt4HLzRsmvoMSn0NI7vv1EI7DgPsvRcNLo6oigA7A8nA9qyIJhl42iCruiC
 SPzYNxVMbERY55Y1X9JNB1TX0+hHyqYJvdN+HkNPU8Jv1ZZV2TqsWHK/QFJ7g/AAJUwPXsfa4
 RfcMyAXRDkuii7RuHA2vLATtx9W5mqSW/jDrudRbT13wyCw/GqY95SnVA==
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
> Always consume the bio and call the end_io handler on error instead of
> returning an error and letting the caller handle it.  This matches what
> the block layer submission does and avoids any confusion on who
> needs to handle errors.
>
> Also use the proper bool type for the generic_io argument.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/raid56.c  | 39 ++++++++++++++++-----------------------
>   fs/btrfs/raid56.h  |  4 ++--
>   fs/btrfs/scrub.c   | 10 ++--------
>   fs/btrfs/volumes.c |  2 +-
>   4 files changed, 21 insertions(+), 34 deletions(-)
>
> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
> index c0cc2d99509c9..cd39c233dfdeb 100644
> --- a/fs/btrfs/raid56.c
> +++ b/fs/btrfs/raid56.c
> @@ -2200,12 +2200,11 @@ static int __raid56_parity_recover(struct btrfs_=
raid_bio *rbio)
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
> -	int ret;
>
>   	if (generic_io) {
>   		ASSERT(bioc->mirror_num =3D=3D mirror_num);
> @@ -2214,9 +2213,8 @@ int raid56_parity_recover(struct bio *bio, struct =
btrfs_io_context *bioc,
>
>   	rbio =3D alloc_rbio(fs_info, bioc);
>   	if (IS_ERR(rbio)) {
> -		if (generic_io)
> -			btrfs_put_bioc(bioc);
> -		return PTR_ERR(rbio);
> +		bio->bi_status =3D errno_to_blk_status(PTR_ERR(rbio));
> +		goto out_end_bio;
>   	}
>
>   	rbio->operation =3D BTRFS_RBIO_READ_REBUILD;
> @@ -2228,10 +2226,9 @@ int raid56_parity_recover(struct bio *bio, struct=
 btrfs_io_context *bioc,
>   "%s could not find the bad stripe in raid56 so that we cannot recover =
any more (bio has logical %llu len %llu, bioc has map_type %llu)",
>   			   __func__, bio->bi_iter.bi_sector << 9,
>   			   (u64)bio->bi_iter.bi_size, bioc->map_type);
> -		if (generic_io)
> -			btrfs_put_bioc(bioc);
>   		kfree(rbio);
> -		return -EIO;
> +		bio->bi_status =3D BLK_STS_IOERR;
> +		goto out_end_bio;
>   	}
>
>   	if (generic_io) {
> @@ -2258,24 +2255,20 @@ int raid56_parity_recover(struct bio *bio, struc=
t btrfs_io_context *bioc,
>   			rbio->failb--;
>   	}
>
> -	ret =3D lock_stripe_add(rbio);
> +	if (lock_stripe_add(rbio))
> +		return;
>
>   	/*
> -	 * __raid56_parity_recover will end the bio with
> -	 * any errors it hits.  We don't want to return
> -	 * its error value up the stack because our caller
> -	 * will end up calling bio_endio with any nonzero
> -	 * return
> +	 * This adds our rbio to the list of rbios that will be handled after
> +	 * the current lock owner is done.
>   	 */
> -	if (ret =3D=3D 0)
> -		__raid56_parity_recover(rbio);
> -	/*
> -	 * our rbio has been added to the list of
> -	 * rbios that will be handled after the
> -	 * currently lock owner is done
> -	 */
> -	return 0;
> +	__raid56_parity_recover(rbio);
> +	return;
>
> +out_end_bio:
> +	if (generic_io)
> +		btrfs_put_bioc(bioc);
> +	bio_endio(bio);
>   }
>
>   static void rmw_work(struct work_struct *work)
> diff --git a/fs/btrfs/raid56.h b/fs/btrfs/raid56.h
> index 3f223ae39462a..6f48f9e4c8694 100644
> --- a/fs/btrfs/raid56.h
> +++ b/fs/btrfs/raid56.h
> @@ -165,8 +165,8 @@ static inline int nr_data_stripes(const struct map_l=
ookup *map)
>
>   struct btrfs_device;
>
> -int raid56_parity_recover(struct bio *bio, struct btrfs_io_context *bio=
c,
> -			  int mirror_num, int generic_io);
> +void raid56_parity_recover(struct bio *bio, struct btrfs_io_context *bi=
oc,
> +			   int mirror_num, bool generic_io);
>   void raid56_parity_write(struct bio *bio, struct btrfs_io_context *bio=
c);
>
>   void raid56_add_scrub_pages(struct btrfs_raid_bio *rbio, struct page *=
page,
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index ad7958d18158f..3afe5fa50a631 100644
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
> index b30d4449ef18d..844ad637a0269 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -6770,7 +6770,7 @@ void btrfs_submit_bio(struct btrfs_fs_info *fs_inf=
o, struct bio *bio,
>   		if (btrfs_op(bio) =3D=3D BTRFS_MAP_WRITE)
>   			raid56_parity_write(bio, bioc);
>   		else
> -			ret =3D raid56_parity_recover(bio, bioc, mirror_num, 1);
> +			raid56_parity_recover(bio, bioc, mirror_num, true);
>   		goto out_dec;
>   	}
>
