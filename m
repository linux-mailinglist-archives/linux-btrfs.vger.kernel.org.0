Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E03C72C2FD
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jun 2023 13:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbjFLLiJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Jun 2023 07:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjFLLhr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Jun 2023 07:37:47 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E3B7D88
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Jun 2023 04:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1686568762; x=1687173562; i=quwenruo.btrfs@gmx.com;
 bh=cC6KrRlnksKjHA7hDvpb0KfngYhpL8f9noPLg0usD+Q=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=NUfVept2NPwmLXyR8piO+YbO4ffhGmDanT0dThwAf9iDtvKryyv3R4zjg4qadzANdMG75Ev
 aRW6Nzs67+LR8MM7bx1yDzlXZyb6VZfzNPGZoS2tQVPN1rqn9LlJ5ocztZkZvRsH5Ghj3s2/3
 43Cfo2G/kDA8mnLxi8G6eXNFqIcOI+yCz6Bsd8I7ZmlWJo7xb2Sbvae+9aKA/5P1rkWlCRKqz
 EviJjANGSM3sSU1zdMFIGwWyHP8VocPSndzQhph6F6uHL8oqM8Q7k6KRyZJMtn3IFy4viYX71
 i/ShwDLW2fRGCtqbbGSYT/4LlkRG/pAE8AM9gvu8R9Q++tEvhUyQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MLi8g-1qQCSn0rlA-00HcSe; Mon, 12
 Jun 2023 13:19:21 +0200
Message-ID: <56baba91-7e71-76c1-9474-924b67202d9d@gmx.com>
Date:   Mon, 12 Jun 2023 19:19:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] btrfs: send: do not BUG_ON() on unexpected symlink data
 extent
Content-Language: en-US
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <f3c6cadc84e001f786b82ef540cf39e9e8ce859e.1686566191.git.fdmanana@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <f3c6cadc84e001f786b82ef540cf39e9e8ce859e.1686566191.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aijC7qPo99vmV1G3TR1TjyoG4DJwMaVjQqFHZJxNFxYl+FpeJYD
 HpmLcTh/3S5mxDiWZgRDnvauXz0DvYx+prNmhLftoIlzFBp+8NaUmBRQbs8+3/YjkKVdGbW
 baFk+dS50V6OiwGg9OEami3vqmGYsswMj30la0pTbmC125DiI2hs0X9o3R9YMhYJZDcz+dl
 29IQq1gz47XR27GdsnxgQ==
UI-OutboundReport: notjunk:1;M01:P0:pgjpW4bzQpg=;Mb0IgaIT2uc8B87te/01Kwer0Kx
 eJLnqAy1JtD64h/CU7SP1YZAgtHKGviZjiviBjX/EfiSmaxMhdKeUrufHIMszJJoicE8Xpmux
 T6wEnDUb3crLFUSxbk60cAZ1lZKuuYIvoh589iSwEwviv6gRXlYh3RCkPJccK7/v/vkp8i2bb
 Ui7urRgJmduMWDjO9WOQ8ZptGGUn0hw8zYGbRjx9vJFfFtZqCXhGOiIyaPbwfTgdwZVYKiH+J
 JAkGbmrCpTY6dNNH2FjzNWE3Av3F/SueFvzgW13B+tygCxMeQ8oEIdpqTlqu/ErRIfNP4RYgG
 +iqbqXiUk4xAmN/B/wtmwGWvjlxNlXOde8WiLHTCR20Ak92D3DnIVXs8He4hZcQNi4QgpaV3T
 nUiR8+iJ7bNFs53KRw2XXKV2tf8aw+iTrIECFMyJRFY8PkLnx3sRsY37d5q6Yxsc0gGoS8Xph
 rhsYM/Brnqe0X5T9KJSm66I7iHz1QBuTllEvLnLEU6fFlU7DcD+Dfp2GPomyDtXd5nCXgluBy
 H/8tSSj9aKRub40eXVOa4PNbtoQUFIb+tFV+/jG/D6oAY4s/n2kCKZhojLkbpay8adR6ndjjO
 xOBKVH2/ozJfrGaBp1wRNIgY8XCS2keMEbfiAR88Wqoy5fuAoa0nEKn+ccWJ+hkJPc63bSGVO
 b2Apd541prQS0Nls23BCD967H1mB51AbgvqVOpsxHOaivwIIIzFcss9b3Or07gXkP+V9wwaiH
 wbbRl/zlZKqBT/RCVgYTl4CBETedsD6n4MrOmDVP/mxY3r9CAczU9kQ+m1lbS6xAqRlJctpak
 yCop2mZZ9GebPD2urgJ7bHWyUeg1sCNr9i2G1wk2aezMP+K6mSUyFUnw+0jlt4uEizbT39Bm3
 9ANqwlpY4oDjChgoPzTzmnWppi9iJB+5pT5WLQRK7L7VIBg+uJTLcE+IftJ8rrQiLsMtlCntg
 Bo7mvZAgBb4/NzWsj48Hr6BMBwE=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/6/12 18:40, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>
> There's really no need to BUG_ON() if we find a symlink with an extent
> that is not inline or is compressed. We can just make send fail with
> an error (-EUCLEAN) and log an informative error message, so just do
> that instead of BUG_ON().
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/send.c | 16 ++++++++++++++--
>   1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> index af2e153543a5..8bfd44750efe 100644
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -1774,9 +1774,21 @@ static int read_symlink(struct btrfs_root *root,
>   	ei =3D btrfs_item_ptr(path->nodes[0], path->slots[0],
>   			struct btrfs_file_extent_item);
>   	type =3D btrfs_file_extent_type(path->nodes[0], ei);
> +	if (unlikely(type !=3D BTRFS_FILE_EXTENT_INLINE)) {
> +		ret =3D -EUCLEAN;
> +		btrfs_crit(root->fs_info,
> +"send: found symlink extent that is not inline, ino %llu root %llu exte=
nt type %d",
> +			   ino, btrfs_root_id(root), type);
> +		goto out;
> +	}
>   	compression =3D btrfs_file_extent_compression(path->nodes[0], ei);
> -	BUG_ON(type !=3D BTRFS_FILE_EXTENT_INLINE);
> -	BUG_ON(compression);
> +	if (unlikely(compression !=3D BTRFS_COMPRESS_NONE)) {
> +		ret =3D -EUCLEAN;
> +		btrfs_crit(root->fs_info,
> +"send: found symlink extent with compression, ino %llu root %llu compre=
ssion type %d",
> +			   ino, btrfs_root_id(root), compression);
> +		goto out;
> +	}
>
>   	off =3D btrfs_file_extent_inline_start(ei);
>   	len =3D btrfs_file_extent_ram_bytes(path->nodes[0], ei);
