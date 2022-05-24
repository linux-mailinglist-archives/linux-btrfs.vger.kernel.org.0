Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD28532B2D
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 May 2022 15:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237762AbiEXNV4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 May 2022 09:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235573AbiEXNVz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 May 2022 09:21:55 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1944474A;
        Tue, 24 May 2022 06:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653398511;
        bh=yLUGa5/uALCWmORpBpjvR4PawSKfAZimTqcZ3HoRWUo=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=IKfronvZOQ3QfUIoi/aE0x2+1J0ryMTPxlcZeT544sH3rvkpVkcrJZPDhnFo80/Lo
         TfRynKJeF7pA9y34Ii0W1z9gFBwdP2PvbzTu9VByF9+qo4yMUbKmnVY4H9bgJr9fvK
         XrQLZIHkEqgkjw4QwTnwd6I3xevEhv1XVBiOo3ss=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MfHEJ-1nN9PB2ZsB-00gsU9; Tue, 24
 May 2022 15:21:51 +0200
Message-ID: <3416e5ef-22b9-82e2-10ec-be6993669fd3@gmx.com>
Date:   Tue, 24 May 2022 21:21:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 7/9] btrfs/215: use _btrfs_get_first_logical
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
References: <20220524071838.715013-1-hch@lst.de>
 <20220524071838.715013-8-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220524071838.715013-8-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yB89ajsgbVHQQKZFKf1spPuk5e8iVZN1EtAdv+Dm7WrZhtKUN90
 AKLmOSbLjy8ycuFGPqbREuXJlXxbrIl8ikkhG1TiSaqobDTI1E/SMJRDMfdcJKk7exsL8Ip
 Kn9uP9n9K7ATbUEwvjwBkXP2gP8UCCWyp3nZEjSrald2IRqrXuY/elhok5VUfv3e9ODIWkd
 FLEq9qHF/BHwcoNiAsaRw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cQCuMcoehn8=:urXhMLT/SvBHpqhXenwnMB
 rTYHaOMbdyrZZUXaLis+3EMc36pX1xdNBP8f6Uc010rvWTRkGXpnvqWTl2wWroXNcfqSQWGm3
 /Jl9gkrVeyE2iGGu8xZKCq5/Pox2x4Dy+jHiEwT0nwgi1ZwiaMH/gKQitdMQuYC0b20P6phYT
 dIdX84FGwGE0pIwlzwt3mPTQg7pnWK0yKoNGNHLXwtuF9XiHuONPFrEjJ52r/dqGCkiptW/MS
 nKZS0jBT7vF/6GW16sDuOCyjTh19f9LoAsL2pd2eKwKhDc/Nq743IraZmnNy57j1iEeBy3BDF
 iNDJ/OaHBEkIjwjifUYQoecDmJyuEKo3NqfSL9sQ9xYOe7Q6CM2sJ0rWuIG9HsCU4Kk0shhCj
 Ixe2BvyPr3MFyEQQ2bBfPFwatFeb2PmY78z+S3hDGwOkqICM7s6uxIZpyn5GeKfIm5FwPoGGP
 0XZDVVVlfe5RTNGof8S7o64yjAd4xjskzWzf6zV7aahc1tIFM/E/HJPq4ZkFQlmjlhQ9xVZ0x
 R8i+b6uERyManMimRuY5lLHKnENt6qYKUjdekWTY4HeLxsxYIrs/o33IF2hLGqC/fh0VzPbXn
 ewGn8SHQKJnm/MNMZBXj1HeRtrQEI7ILcaINclyrf8Tayv1SOsCKUIuMh3Kv6KeR2D48Y+cc+
 IFoKoNdvHnWRnlpa76Aeg7t2Glg52GCvJ3AQRHIRq3/7rqpN6CoaioyzaiGYAxGfY7OkIRHoc
 hc4iqLa2Bj/6NT1uclIOOzOtaUc772yZiGyvC3zeRl8XCuL8E4lPzoHutVKftkz+BvyxmEnsp
 gZqktwAM/uCc75nXSLfWbwtUecKQwXTkDGrkwG4uFf6H0etNxW2b3Mehz7CEzYLJ1IUpctkc+
 8YdhIT8MiVy6GXh+g7P+fwOWtbvj/0d4rUt00GT4+L31pk9bccR0BgaemaD9ouwli7SCx0FPu
 7hzK0msXMxRNt40cbhU8qvoKNHNJDKJt1lKix9xfan2m+4/CqjAzf/70s6ZMIUbQiqe+eclIv
 bZ7+gWoKMM4b35C9Ih8xAFc8Q1Q4KXG6OEt8JohatEr5cQCwEr75Jgc806L3tMg2081sWIoNc
 02h5wAxAX+23XsnZwJTySl/5RKc/IxABIJTJ35sOcmikIItWIAkeNoRxw==
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/24 15:18, Christoph Hellwig wrote:
> Use the _btrfs_get_first_logical helper instead of open coding it.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   tests/btrfs/215 | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/btrfs/215 b/tests/btrfs/215
> index 0dcbce2a..928f365c 100755
> --- a/tests/btrfs/215
> +++ b/tests/btrfs/215
> @@ -56,7 +56,7 @@ fi
>   #create an 8 block file
>   $XFS_IO_PROG -d -f -c "pwrite -S 0xbb -b $filesize 0 $filesize" "$SCRA=
TCH_MNT/foobar" > /dev/null
>
> -logical_extent=3D$($FILEFRAG_PROG -v "$SCRATCH_MNT/foobar" | _filter_fi=
lefrag | cut -d '#' -f 1)
> +logical_extent=3D$(_btrfs_get_first_logical $SCRATCH_MNT/foobar)
>   physical_extent=3D$(get_physical $logical_extent)
>
>   echo "logical =3D $logical_extent physical=3D$physical_extent" >> $seq=
res.full
