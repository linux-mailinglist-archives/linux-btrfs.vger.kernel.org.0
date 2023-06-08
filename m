Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43149727D47
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jun 2023 12:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235585AbjFHKw4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jun 2023 06:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236023AbjFHKw2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jun 2023 06:52:28 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99C430C1
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 03:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1686221528; x=1686826328; i=quwenruo.btrfs@gmx.com;
 bh=sFGmxr2ZwOQ+X0m72uhirrcpZjpPiKJ4q8HBcj6hJMg=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=uV5KMSQM+CIJnRCdNR9ZbU+5DsUiH/MjSMO/k0i+QWzOq9hMb38erbUecFDn8m8G50dCHWE
 PBC1wPa3ubILvQHsmVFj90tXlyHEM89qvOCb7B3Aat7n9o2CUKH2b/eEHtlLVDYYsLkAzsMFL
 FLlXeEzGWkGk1vS5KCeT/le5Mejlr3qEUUxIG0d/JfO1tmrun1WgeFyU5fzpEHjn9F+FimnMm
 XdHYIwgFoBthtY2PyHyEiQu+aKGgeCYSdwXiQoWovx0RXU0s/5FB1P1sDtRrCZwENHWEYNIWM
 wmMUzokfijI9otXLZ7VpOwFfTFgolP4JfJqBAm9keORiY1Qw68Ww==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mnpnm-1pnmTV3q4A-00pJPj; Thu, 08
 Jun 2023 12:52:08 +0200
Message-ID: <22a37ee1-dd8c-a982-01fa-666f81b83bf7@gmx.com>
Date:   Thu, 8 Jun 2023 18:52:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 09/13] btrfs: abort transaction at update_ref_for_cow()
 when ref count is zero
Content-Language: en-US
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1686219923.git.fdmanana@suse.com>
 <9980464fc9f02392f0dab60c5564495c811ed256.1686219923.git.fdmanana@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <9980464fc9f02392f0dab60c5564495c811ed256.1686219923.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8ptSdaumcGb38HHilKIRrioyX+iJmlbTPc5B3v0ppio8R4SttwP
 y9HGEgxZX2fqWhCDIxHgIqLTWlKZa8C8xIpYnYxCmQpBpsLjkxYRiGii8lD8zVRm29G8wBf
 IcfPefziOX9YXVxiMfU0FzqoDBptEMdCHnqPG1BGc5r/lIAXeacS3WUcPRvZaUEbQ/ilSjG
 RyvSlkPokiSPZelibJMaw==
UI-OutboundReport: notjunk:1;M01:P0:Hb/o5/jda9I=;yprB2QXE8aHuCWTxb/SqxmJOJ36
 GVg0dSKF5yWhDt48L7WwWuocFasBc43Nz5n5S8tHzCW5s9C/mYN1w+1VVJswzVjYTUVwPiLZr
 Ea4373UydhrAHmXRBds6sPHOxfgy0jjwsqZeDNsBG3FExIF0bgJXG7zTvNpCZJhNHY31NAp2w
 t1wVGxPobI6icDK1L23qTIYu8mivL3vAP5cIyeJ9ls6RlNjemtkMA710YUwvAJnkj1wxE9BXV
 n4on1eik6izk3UeghTEQgRx6nSLgW8JtqlCDkOfr/CwkLXG0PenBHHpWqeFoPUwpemgAUy2pS
 2xyTPjBCTqOYquOZ1nvAGlqDXmdEJ5Njuz+ZPF2AJyhZK2GBTpVRDlECW4jiVAOfOimI0P0S+
 06+ir5xiuvy9s0UA6dus7JVX8kQ0Vu3LBptdGYO9SRFz521l2lvOIqX0czKbksicnGixHw3MJ
 sVNcH9dN/vd/w6X8MJBgAVpJEJf1IdcbGf9ly2fLpci8ht6CEtV4oTWWaImXUGbyhh+MarJ0X
 RWYwesFOfi/b/RncP/mJVEQAtgigHgEpWPJlgqV1LeEz7zUQVuKwwi7x/JbkYM6CnLud4050Q
 XaV8jzfQj8ZbKzhILpoJPtnvnVUnslRTXmpWGvMD6LW9meH+Iu3XBPhBXSsDGLavh6RjXXq+j
 PBss2wQvbQb8+kRJKgHNEEvhCCAWKU+SV4/Np+k7a5liu1eyWy/dDT4XeAcBukz91jNgdh4kC
 HjGvpE5UmGvPwDiVITdFAUh7DPYxm3zplD9XRLpX98gK7meHKwRwmXTM8xnd/WhP8A/Yud1aZ
 d8iktVG/wbXHRJ7hxRg2vAYRRitDDEh52Tr6tWZFNwYEFANP1y4KC70iKRuVO94+48ALS9aDd
 6XIsU+6hgxK5Riihqsig76l5JXiY75y2C+nLwbDXkniT+M78CbXz6TLLqBk+heUSOnY0ufqCN
 KPKIltw3T9i/lDTf1NFePx/knGY=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/6/8 18:27, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>
> At update_ref_for_cow() we are calling btrfs_handle_fs_error() if we fin=
d
> that the extent buffer has an unexpected ref count of zero, however we c=
an
> simply use btrfs_abort_transaction(), which achieves the same purposes: =
to
> turn the fs to error state, abort the current transaction and turn the f=
s
> to RO mode as well. Besides that, btrfs_abort_transaction() also prints =
a
> stack trace which makes it more useful.
>
> Also, as this is a very unexpected situation, indicating a serious
> corruption/inconsistency, tag the if branch as 'unlikely', set the error
> code to -EUCLEAN instead of -EROFS, and log an explicit message.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/ctree.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index 00eea2925d1d..0449b3d819a9 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -421,9 +421,13 @@ static noinline int update_ref_for_cow(struct btrfs=
_trans_handle *trans,
>   					       &refs, &flags);
>   		if (ret)
>   			return ret;
> -		if (refs =3D=3D 0) {
> -			ret =3D -EROFS;
> -			btrfs_handle_fs_error(fs_info, ret, NULL);
> +		if (unlikely(refs =3D=3D 0)) {
> +			btrfs_crit(fs_info,
> +				   "found 0 references for tree block at bytenr %llu level %d root =
%llu",
> +				   buf->start, btrfs_header_level(buf),
> +				   btrfs_root_id(root));
> +			ret =3D -EUCLEAN;
> +			btrfs_abort_transaction(trans, ret);
>   			return ret;
>   		}
>   	} else {
