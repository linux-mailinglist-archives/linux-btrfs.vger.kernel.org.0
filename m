Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DADB6717A83
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 May 2023 10:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235119AbjEaIqp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 May 2023 04:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235145AbjEaIqR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 May 2023 04:46:17 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBC110B
        for <linux-btrfs@vger.kernel.org>; Wed, 31 May 2023 01:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
        t=1685522741; i=quwenruo.btrfs@gmx.com;
        bh=AnjqOeEpk8VS4qm28qlG79ado5+NfsUxDv/ad0+/ueY=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=hE73h944aupB1F/XiK0m/oNIYazVjjbF9Wtv58TkwFS1pxTofOQfpa0nzuvZbHkts
         +tK18vYTOXXnWilqzNhbkBDouRcSRmREBanlaoM4MHu6tC0aYFcGoQkDsczxGpgX7l
         GJ7VEM+5fcVGhw8sk6z6bAXa/dxkavJtqjXgDB2fxOGb+3CDpsclAu22r7g7p6Pmg0
         1xJNL5gmmimEj98Xgi/UfCmNHNO2qU/6KwtmEh4lSOnQgI2BoiFQcYlBJKPFs81yXg
         +GXFAqjCvXDtkqpTyHQe1+bp4qRa1nV+Lvy6iP7XChuVyK99ZG9GVomtr4nljk7DmI
         g+PSKpxzEc+Sg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N8XPt-1q8f9J2yXJ-014Vh9; Wed, 31
 May 2023 10:45:41 +0200
Message-ID: <af05e9ca-663e-69de-7f09-98a85da724d5@gmx.com>
Date:   Wed, 31 May 2023 16:45:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 1/6] btrfs: remove BTRFS_MAP_DISCARD
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20230531041740.375963-1-hch@lst.de>
 <20230531041740.375963-2-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230531041740.375963-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QbXA3qhUX4F3lBYbKvvm9MoB3/mnOIAbBjxqrHJPslpEajx1m5s
 Q4bWEd8z1Bidr1RpXw4UIsq9IDyCa8vXWWF3TlzjxiMzDSqs0OroPUyZdWR48ruLZ9l7U/M
 G0uKZc2BG1rddrzQ0gGFTrHvVmMM3q9jTnkVZKI6Fw03MWfbYf2AAevSxULnxvZmMJWqCeI
 hJdz20KC8NLC0jjbRgvcg==
UI-OutboundReport: notjunk:1;M01:P0:idYy0fqDRdc=;il/KZEsLQuO1xc7Ulesp/pNnH57
 m3u9Ub3YuRG8hBtOUxPnlXoLJOr4+5zRneNEFEqrg8lgmfm9egiMMF3vpC284IseO5KL9yLb+
 dE17s0Nb2+EzafvWUlbJxcHOtZtpuyVxJ6x1h1q1TAycn/JPKSpABqwQpNcp13OBNkjP3MCuA
 I/5M/FvueWjtv9v8s78gnWUNMC3LZnTWJKrrlnN3PTtRudkudOiAcVfoHidx+5MpIRQlBK7+z
 0CKYTBx+cb0KUB9Ygkfb0PM9zYQJ0IdzjuyU3blj3Q6r0QQEWJKOQ4EQFGBJi18otWDbXxIbX
 mCnj9Pw2Mzl8ZSc84bP1/l9svhoLkT+YUO2xKsr/UY/zbnwiqQcszoigPk812BuK/g2TtLn9H
 wg3VnK95iViQGErqVc1mU4lIieN5Gr1ZCMt/dbmcQapnEYmgGjFv7gryy6ZJv2IrUqJqfHgLg
 Js8MZeWmt7Tx+IJxdj3mhtQPPKDtjZS1ohXzUC65X0jzFPoFU+r+vjnrxzeTUgH8nnA08o4hP
 eRx1+MWiHOz2ic1utsRBN51CZ7oYTf1y8OkzTWsHubYuLI3KcVvi7ThwNz/yRkmXx3el+SjJn
 uk9CH2O2/TzbZQ2Ib74YFB36xp+7WJPqR3pwaO5oN0BUw5UStZk0fx/wPfecRVT6t6g/dSIEy
 iE9u8lXFDc6ka0kPcI/E179W07MKJGBngM1WKt0ykmkyE0wKKBkp/nmkgu23KLHHmbdwTvwo2
 kmR6KqeAdi1KT+Pk+HFk9Wx2cGvNDokXZjCcu8tvlu9U91j7ealhMQHKEr+urLYFOS+I9ED3C
 sPyRJGjJjnw1DsYeiWi6iyVqNrkX2xG/Int6R26QpsUSYvgMrMkZzZ1kYg5fG5QDhE/jZ3lTw
 zQwOKaLvil5pW5JfcUK//bMXmk1AXTc5JnpmhFWz+IxgCOJDr8KFhbtWDHSxwFXqJ6DQNyrve
 Z/IP4pZXDLeVy0v+WTNBTvwcsfU=
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
> BTRFS_MAP_DISCARD is never set, as REQ_OP_DISCARD is never passed to
> btrfs_op() only only checked in two ASSERTS.
>
> Remove it and let the catchall WARN_ON in btrfs_op() deal with accidenta=
l
> REQ_OP_DISCARDs leaked into btrfs_op().
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/volumes.c | 3 ---
>   fs/btrfs/volumes.h | 3 ---
>   2 files changed, 6 deletions(-)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index a4bfec088617ec..c236bfba0cec3b 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -6182,8 +6182,6 @@ static u64 btrfs_max_io_len(struct map_lookup *map=
, enum btrfs_map_op op,
>   			    u64 offset, u32 *stripe_nr, u64 *stripe_offset,
>   			    u64 *full_stripe_start)
>   {
> -	ASSERT(op !=3D BTRFS_MAP_DISCARD);
> -
>   	/*
>   	 * Stripe_nr is the stripe where this block falls.  stripe_offset is
>   	 * the offset of this block in its stripe.
> @@ -6261,7 +6259,6 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_inf=
o, enum btrfs_map_op op,
>   	u64 max_len;
>
>   	ASSERT(bioc_ret);
> -	ASSERT(op !=3D BTRFS_MAP_DISCARD);
>
>   	num_copies =3D btrfs_num_copies(fs_info, logical, fs_info->sectorsize=
);
>   	if (mirror_num > num_copies)
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 16fc640cabd3f7..e960a51abf873d 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -556,15 +556,12 @@ struct btrfs_dev_lookup_args {
>   enum btrfs_map_op {
>   	BTRFS_MAP_READ,
>   	BTRFS_MAP_WRITE,
> -	BTRFS_MAP_DISCARD,
>   	BTRFS_MAP_GET_READ_MIRRORS,
>   };
>
>   static inline enum btrfs_map_op btrfs_op(struct bio *bio)
>   {
>   	switch (bio_op(bio)) {
> -	case REQ_OP_DISCARD:
> -		return BTRFS_MAP_DISCARD;
>   	case REQ_OP_WRITE:
>   	case REQ_OP_ZONE_APPEND:
>   		return BTRFS_MAP_WRITE;
