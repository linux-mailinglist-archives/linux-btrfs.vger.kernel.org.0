Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85671710A27
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 May 2023 12:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239088AbjEYKc2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 May 2023 06:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240576AbjEYKc1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 May 2023 06:32:27 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC94D197
        for <linux-btrfs@vger.kernel.org>; Thu, 25 May 2023 03:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1685010743; x=1685615543; i=quwenruo.btrfs@gmx.com;
 bh=tsSEaBF5hPkBB+jZWJkJkWNXevBASTFSPgTA/IDqI50=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=jXPWk7SxRypmf8P2fPNTFl9ED0UL35XYZB9zp7eZrAkuAKgZ3W08JXHQ0qn4uz6n5KkPux7
 dymvhOqOrFMVIdiYGnj9rzwPl7AyXSDRpyvljtU6n746gV1JvhYOQD1XlyAEfE3tANXnhHB1X
 /HtmoWk+41zPIQj3A2yQ9o4L0FjBUthPtzgbIKjP95sTfcEDNoKcCo5sbhX0m6mrfclVXRVWI
 XzGUAaA2NK3Y6pntp5sXzZS8rnemYbK2F3bf8E4oD95vSMO9ke8n5TaDObF5nGJqw27Utu7NO
 +9rIJM5R9BQDzKIx+YsyCTAhAr+iPG/6PaCRXoLcGHvQbmg7+/Iw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M7JzQ-1q3D7y1Ab6-007nRG; Thu, 25
 May 2023 12:32:23 +0200
Message-ID: <100f08f8-3829-609c-e829-88ce9701422b@gmx.com>
Date:   Thu, 25 May 2023 18:32:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 3/9] btrfs: open code set_extent_new
Content-Language: en-US
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1684967923.git.dsterba@suse.com>
 <34f3abd71b4da58527bfc16268a4d915f98e5305.1684967923.git.dsterba@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <34f3abd71b4da58527bfc16268a4d915f98e5305.1684967923.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:z3J2/xElgjfmYFhJ307rwASpLypErZv3GZQnTrC4EkqOco7VJv+
 8xjY4uo34BjlrzrfDAM3kOaCjj7EosLxo+JGYIE8B+n6KC1l3ZGTz6Ab4VnHau0Bb3ks90R
 zfzVNIClA2ocU62BLZUMzZ8nzAvo2V2LtqMoQ/VJaXQ1E6q1FCLKKD6t6cYyN8mI9pKyi/N
 q735tkN61LprwwnLPe8LA==
UI-OutboundReport: notjunk:1;M01:P0:c7w8+qPCQms=;wVDAfi99+s57ZLGU3ZHciepnL0x
 9/W9mCC1t05OF/kCyl5dyi7b8eAMiBDxFFq6ZPD3PYQL5Qj420T+qWHnuPsfjKdjY3MrOK0xN
 dUYINULqGQGKP8zZHpUcDDSmgp8iQmviGctK/1aGt92m2t3lfgbqj8DLRpF/qBP8RQHLTWjld
 Oac1BeHv8fMrcVDpDK+CZQHWw9ziCdSWoUa5QzAEmbY03Fo/lMqPHAxBNXeJ/CYq/mBGlKKd9
 dTXJtIlPCpeKGX+GKZLDGIpLBgDkBcydK/0UbSJ7OKKdJx3p9NE7+KQnV3JMTZPNy627CaJ9Z
 231mutASj8ZBMQm/OKA1xySaI87RoF29JUCihC4lrEM5OIoT550MoNWWps3fbey8MdRG/Bo1v
 TXRr7Nde82aypUN9DQOdEBNIOvd9o7UMLKbC7JabhaGEFFqbqXfYTyqvuAIGxWUfpGhvE/VjS
 oL87OuPvUGP4xffKhmPA3QeW3HDSxassHYaQPSZutJ0isWpFbWtQ9p5pQ28igWeKEoWXlbqfQ
 SKt4b404VjFzBIconAJ02suK4wjea0L5M52kGye4R98bBaFFNRK6WL5m900Tz69cZtiTzbGni
 nG4VevLwXhr9TBLFJlp3Bb4QBtz3lCt0m9+CBv17Npwep1GRI6V82vjdPicqsW86UN7GmEwRu
 15ySqTrYQTyXmtCOGqtUwKQG9sT6E+HFD7kCvvptziWg/vO9RbwVukLDYH7rKoHRn/AXatb1n
 tzECIV+uHWLl7SFTpfV/aXVqJkFYVuzfUbXoTGVFiUzUGnLQnnAzoN9MASqd6vCUv3R7em+b/
 VC/BkAfpI/nExZdUevRg1fdwwxhJfNRRvY92CmPiIOUpj52p40tZ1IkTx/L+WdTu9XkjGh8eB
 kf4hOULhJjbWR3mX9anzbPcaSXW9AtGCy3HxUl+pi1vYo92FmhHzLLD4zTB0BXe01c69d4opJ
 aO/DTbgLe05FAQSpS6t1ZABauYs=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/5/25 07:04, David Sterba wrote:
> The helper is used only once.
>
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/extent-io-tree.h | 6 ------
>   fs/btrfs/extent-tree.c    | 5 +++--
>   2 files changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
> index e5289d67b6b7..293e49377104 100644
> --- a/fs/btrfs/extent-io-tree.h
> +++ b/fs/btrfs/extent-io-tree.h
> @@ -193,12 +193,6 @@ int convert_extent_bit(struct extent_io_tree *tree,=
 u64 start, u64 end,
>   		       u32 bits, u32 clear_bits,
>   		       struct extent_state **cached_state);
>
> -static inline int set_extent_new(struct extent_io_tree *tree, u64 start=
,
> -		u64 end)
> -{
> -	return set_extent_bit(tree, start, end, EXTENT_NEW, NULL, GFP_NOFS);
> -}
> -
>   int find_first_extent_bit(struct extent_io_tree *tree, u64 start,
>   			  u64 *start_ret, u64 *end_ret, u32 bits,
>   			  struct extent_state **cached_state);
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 5de5b577e7fd..5c7c72042193 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -4832,8 +4832,9 @@ btrfs_init_new_buffer(struct btrfs_trans_handle *t=
rans, struct btrfs_root *root,
>   			set_extent_dirty(&root->dirty_log_pages, buf->start,
>   					buf->start + buf->len - 1, GFP_NOFS);
>   		else
> -			set_extent_new(&root->dirty_log_pages, buf->start,
> -					buf->start + buf->len - 1);
> +			set_extent_bit(&root->dirty_log_pages, buf->start,
> +				       buf->start + buf->len - 1,
> +				       EXTENT_NEW, NULL, GFP_NOFS);
>   	} else {
>   		buf->log_index =3D -1;
>   		set_extent_dirty(&trans->transaction->dirty_pages, buf->start,
