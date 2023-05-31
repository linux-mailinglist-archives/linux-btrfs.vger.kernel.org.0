Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1F8717A9E
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 May 2023 10:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235126AbjEaItL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 May 2023 04:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232514AbjEaIsr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 May 2023 04:48:47 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F643113
        for <linux-btrfs@vger.kernel.org>; Wed, 31 May 2023 01:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
        t=1685522866; i=quwenruo.btrfs@gmx.com;
        bh=8vozCf1DejCmWXCG4auGJ7s9zfVsXrrbjAYjwtoxWmg=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=sqp11Sc0vunnvVUic++AuTFMI+H05SH6eI25sfYq/YmfdsHGo8Gv/fGl3mn7zKzDT
         zltw7FLEupIAN5Epnuv0BLWZAnJ1Eod9B/NWaZ2jxjRFeorZ73zgPwwSD4QBYrkm7K
         MTOrDgAkuZdnQkvmbazitnf3UeGc+d35zRTFXQ3aTcOK01dbpdmI55jhmivBOWQRDZ
         FKQ+Q77hHlP5RTkXtYugdatzb7Vh9pyu6A+HZbkafHyRnLRMrigDjX+i6v4KR9mlIe
         AA0AUjUPaf13wBgsIiKYSj2AA2DOu5Z8tcjJ5TfxB1cyaVU9HYjjlG8pdoMBZ5AmVH
         eADOw0uuIs3uQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MoO6C-1qSewT1Ngu-00ol1H; Wed, 31
 May 2023 10:47:45 +0200
Message-ID: <6997cf68-8775-f518-9b7d-2dbc15b5ce58@gmx.com>
Date:   Wed, 31 May 2023 16:47:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 2/6] btrfs: optimize simple reads in btrfsic_map_block
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20230531041740.375963-1-hch@lst.de>
 <20230531041740.375963-3-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230531041740.375963-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:H2dEG1bQEfV1Y6WCtao7sI5/n+biJ5YGFwcK32fdnVt/3FJR0EQ
 gTY5pJukCAZf8xqB1jWChlQ7C7yAYjcszYMjqmcAvGuKGS6QZdpnWQOHhS5Ien6DujKrkNh
 oQ31ZMiY/kwHLbu92cgXrW0dgZHxX7fdRl222teptYzE2xkaaHmKmDzPsTnXG9vNJrhaoDb
 D5yuA6NY3imJyCjbAAn/w==
UI-OutboundReport: notjunk:1;M01:P0:Kl/T9NYGmB8=;AZtqo5Fma001daGHx7wbxMXniqh
 QLcUDaAjXnUhmcqIYZsrnzxTcPyLBTkGMQBltGyMcYnGByQ6zD7gy7EQv06MmMjKIM5hZuj5d
 sabhYnkRvCj1UspxFCw1C6x1hndbrMcnYVzgECD3nc1Xh2CvmZTNpy65urEnzmBrT4v4zWYOk
 3nJQrryqmS1EdRh4MJPzUuAeO0nJMowi3tZN09ADLTXtyPVY6tYjv2QralvHZebsznaKCzyTl
 CVLVkn9MUHkzpWLneZGQO6UVIznb7tQpGZrUl/TTlBKOG6suS3uZcNygHTZ0dBbCOIRk6eHXV
 i77Zccpzo4zQaq6caF8QzRFw+x92o1drJc1elPkVG9SbALNdvWDT/E1AX2Uu6H5S9pGWo5eTi
 Oa+a9tkr/KOR94eVf+yKFUVaKHpUQa5iHrf1g5zEtihIE8C4AN3jl6ZD3ofk8K+QmnDyFywar
 dJ0a0+bUwwPSPTFSjxDOmXw1RCgG0ajEbfLbJeqX6hTc0l6soxRf4+QmG+MbFlD01vouAJyMp
 E8NNGaWDNV7F7nduaW05ObgCHW0JdNMyNU2AswriKBdjKKFeaRzuwK+sQF1zaQqC8ciN9tiK+
 Oh+rxcfXegINcWqF3Xyd8wJbJqPiIYUnQouxPuR1DoK/QxMs2W1Dbq3nqR3fcO+P2RMbqZAoJ
 NiYTz9syFyM58aKf+aV9gUPJNU43n5Nnr0wvEmxSxOsmrOf0lD3+yuVLCgZxc0ducAWYk6axm
 sX9fd3oyT8C9uyaxXy6V6rnVIoW1OpIJGna2xV8aOEBtTEk+VMSHz66k89wkWBCZgVP8igEei
 qwtMflC0vG7WZVIpUy0cpojA4/IDlV1o2VRnXKclS6zBwmhWLA9lRmCfOrK+PZPBcKNWqqyka
 /s1JvxmJuNJOotEbKPaHTSr2ZU+F4f8oPyc4G7bjhdHNiQEu6YzkkaQUEZSYlkG0ppw8TQuRn
 CeqGbiegq7rj73idps/vuHeJtwM=
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
> Pass a smap into __btrfs_map_block so that the usual case of a read that
> doesn't require parity raid recovery doesn't need an extra memory
> allocation for the btrfs_io_context.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Qu Wenruo <wqu@suse.com>

I'm more curious on whether the check-integrity feature is still under
heavy usage.

It's from old time where we don't have a lot of sanity checks, but
nowadays it looks less worthy and can cause extra burden to maintain.

Thanks,
Qu
> ---
>   fs/btrfs/check-integrity.c | 19 ++++++++++++-------
>   1 file changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/fs/btrfs/check-integrity.c b/fs/btrfs/check-integrity.c
> index b4408037b823c5..fe15367000141a 100644
> --- a/fs/btrfs/check-integrity.c
> +++ b/fs/btrfs/check-integrity.c
> @@ -1459,13 +1459,13 @@ static int btrfsic_map_block(struct btrfsic_stat=
e *state, u64 bytenr, u32 len,
>   	struct btrfs_fs_info *fs_info =3D state->fs_info;
>   	int ret;
>   	u64 length;
> -	struct btrfs_io_context *multi =3D NULL;
> +	struct btrfs_io_context *bioc =3D NULL;
> +	struct btrfs_io_stripe smap, *map;
>   	struct btrfs_device *device;
>
>   	length =3D len;
> -	ret =3D btrfs_map_block(fs_info, BTRFS_MAP_READ,
> -			      bytenr, &length, &multi, mirror_num);
> -
> +	ret =3D __btrfs_map_block(fs_info, BTRFS_MAP_READ, bytenr, &length, &b=
ioc,
> +				NULL, &mirror_num, 0);
>   	if (ret) {
>   		block_ctx_out->start =3D 0;
>   		block_ctx_out->dev_bytenr =3D 0;
> @@ -1478,21 +1478,26 @@ static int btrfsic_map_block(struct btrfsic_stat=
e *state, u64 bytenr, u32 len,
>   		return ret;
>   	}
>
> -	device =3D multi->stripes[0].dev;
> +	if (bioc)
> +		map =3D &bioc->stripes[0];
> +	else
> +		map =3D &smap;
> +
> +	device =3D map->dev;
>   	if (test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state) ||
>   	    !device->bdev || !device->name)
>   		block_ctx_out->dev =3D NULL;
>   	else
>   		block_ctx_out->dev =3D btrfsic_dev_state_lookup(
>   							device->bdev->bd_dev);
> -	block_ctx_out->dev_bytenr =3D multi->stripes[0].physical;
> +	block_ctx_out->dev_bytenr =3D map->physical;
>   	block_ctx_out->start =3D bytenr;
>   	block_ctx_out->len =3D len;
>   	block_ctx_out->datav =3D NULL;
>   	block_ctx_out->pagev =3D NULL;
>   	block_ctx_out->mem_to_free =3D NULL;
>
> -	kfree(multi);
> +	kfree(bioc);
>   	if (NULL =3D=3D block_ctx_out->dev) {
>   		ret =3D -ENXIO;
>   		pr_info("btrfsic: error, cannot lookup dev (#1)!\n");
