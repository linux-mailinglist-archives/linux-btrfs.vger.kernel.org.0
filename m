Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7279727D48
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jun 2023 12:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233268AbjFHKxf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jun 2023 06:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbjFHKxM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jun 2023 06:53:12 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FDF2D7C
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 03:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1686221572; x=1686826372; i=quwenruo.btrfs@gmx.com;
 bh=pzcmjDrJgJTtRLMs/zVntmEfHRYz9+Iofyd91FGWO68=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=QADhpfvdKjkstELpvOK+SmzbcmC2yPo6oYBp43Pl9FFpy7O2KCkXEwUSwXBPSZxTArK6knz
 hvWEMcGTqZC9Q8yQuShrY4izn+zr6oNfskZK87gvLTGqGactHd39UMnISeN27hf59mpO4z0o6
 WCxG8IDVUFaoQe66E5UV/61bjx4LXUNmRjjuHZFvnN3HDZNtRFEr8zQ3ia8WkwMB+9wP9KUTp
 eY17aZUJ4y+pACsKUvnOmOM/jV3sQRaL2oXsxosBRLy3jGYsl+YD/8EQZUV4533RCaWgfBlCx
 2qfmBAdW0ws9w4it1VXnqECyGxgpwbqF1SDT/ja7K9bGF9vBpaBQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mf0BG-1pf17R2mao-00gUYD; Thu, 08
 Jun 2023 12:52:52 +0200
Message-ID: <b5c767a7-d2ba-5ae1-7792-0124a7aa8b6c@gmx.com>
Date:   Thu, 8 Jun 2023 18:52:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 08/13] btrfs: abort transaction at balance_level() when
 left child is missing
Content-Language: en-US
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1686219923.git.fdmanana@suse.com>
 <77e4be6162916c2d23987cec9542acbc60ec2bde.1686219923.git.fdmanana@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <77e4be6162916c2d23987cec9542acbc60ec2bde.1686219923.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lQ5ArpFTb8qeWcLRLap4+GUmQ5RCl1wY/ARDgzhNfvOUGer2eSp
 SvJ6gG10cfBSO6rqwhcUlejhe5u+2x164SgZkz6iqRKr8Lc+GhI64Y1fAtWK8YLm3/5mLVY
 4O/TOuVDnhrFmNiGCdLH8VGda7vCANsyzAtk+ciLqJ4+5KzqCXArcmGe63qK7U4MYdxAZhU
 Ui0DPp+7qX167+0CaNHlg==
UI-OutboundReport: notjunk:1;M01:P0:tfn1WuzXy7M=;UD8hLKovAeWgHOnX1HDveGPFldz
 xIK45ADmWpbvhZjDmmr93+z7CgHjj14+kN7D/paNHkJnBlGQ3E3MnuYUbtKd5VXA+Xk6oXAeK
 3I/fSNfEu0hnEEze9N+2RYXgFZTPTPpFQROYZE0b/SC9mG+U9Mq5jvEoimWobCm8WKaxVhFzq
 TIsBOKEZHPWM4+ooB4KpCcsxvrF6gAvjlBWfiYwQ3+4XzeIHttPWWUrf93DC9u5dvR9YA6lzD
 z/MhQuCGU9i7I2KT008WgoaArJauLrIf64Xw8lhTZPDWTVLnrdxn5j5Pm+eLHTw1eBbGlFFWL
 tWfaFhWihepJ9ylxa652RnGKiMWry07BzTd6XgVgM6X6vpFvTxQuHXyGEpt3SVhEW7+B0P1bi
 6Kc7UNwh6OscwUOgz43FGqEocxLrQKE36qOBCmdgRWRMYuSD9ih7RdoxGrTyTu7/8NqChXCJF
 Fz0dWFHPKlcHHhASbh5HwfxdpnYTadgb+jFC+0VeHcYpkT2kMRNAhsiiC7zwMSJRSs2Zhtp6b
 pttsdZ6Akvh4fjSrWczH/X3kWqm0Z57CTocPChhyo162VON/c2d1Z/iu6dqf4wLKXnoPsHRJF
 0TljJlQ+dyCWuBxivxOwkb+gUZ0G2Be4Bu5A2kjuSjr89yl82MIYaNWgUkEqOb/SgIju85fec
 /QAa4TdjVRvzLuq24muN0EWMuOnvJh1Jzc2Kfo7vt91waEWhM3UJoOWBSEOUG1X6i1yepW1jE
 5AvhJxptIbWxJgiwWgDATalJbKZNizpwsHrnIjtXYnI+3H4aNT0PYO5R1zbFwg8r8Pjnp7YsR
 vyoSaCfxAn9KtzV4EEPqzkBcndsKBN6MRKLl8rR1r7jDqrdyc/YsMVTbkL7d6LjyOg2tRUA5j
 bsmRaJDwgFtBqXERGxXYzVsidT73cQbeULaYthTsIp0x68z70AKdGxJ5lJfYmHK88udCMwCK7
 rSJyYW4eyjqANOZJwGsMGlOjsqk=
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
> At balance_level() we are calling btrfs_handle_fs_error() when the middl=
e
> child only has 1 item and the left child is missing, however we can simp=
ly
> use btrfs_abort_transaction(), which achieves the same purposes: to turn
> the fs to error state, abort the current transaction and turn the fs to
> RO mode. Besides that, btrfs_abort_transaction() also prints a stack tra=
ce
> which makes it more useful.
>
> Also, as this is a highly unexpected case and it's about a b+tree
> inconsistency, change the error code from -EROFS to -EUCLEAN, tag the if
> branch as 'unlikely' and log an explicit error message.
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
> index 4dcdcf25c3fe..00eea2925d1d 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -1164,9 +1164,13 @@ static noinline int balance_level(struct btrfs_tr=
ans_handle *trans,
>   		 * otherwise we would have pulled some pointers from the
>   		 * right
>   		 */
> -		if (!left) {
> -			ret =3D -EROFS;
> -			btrfs_handle_fs_error(fs_info, ret, NULL);
> +		if (unlikely(!left)) {
> +			btrfs_crit(fs_info,
> +"missing left child when middle child only has 1 item, parent bytenr %l=
lu level %d mid bytenr %llu root %llu",
> +				   parent->start, btrfs_header_level(parent),
> +				   mid->start, btrfs_root_id(root));
> +			ret =3D -EUCLEAN;
> +			btrfs_abort_transaction(trans, ret);
>   			goto out;
>   		}
>   		wret =3D balance_node_right(trans, mid, left);
