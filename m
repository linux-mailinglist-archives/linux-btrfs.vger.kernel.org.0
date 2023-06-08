Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5344B727D44
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jun 2023 12:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236131AbjFHKwu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jun 2023 06:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234518AbjFHKwX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jun 2023 06:52:23 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0FAA2D7B
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 03:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1686221508; x=1686826308; i=quwenruo.btrfs@gmx.com;
 bh=h0lHWgfQSiHXc7W6NpF4FphZYHrbmwmjN+TDyXJ9HpM=;
 h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
 b=MMUoi95kzxUkeKSIJh6679nCZuDeoSaBNqLyoX9AKK2IYpjyXd903f8S/WvZmtRB1LZtn8v
 yJ7ePewXOjluQiLAVdWOWP218e8Pe5f/1Q0ZFBLD5gsbMF91BOdrxppCp7vFlzvu338xjaf4k
 SQiITilM+FhqoGtgy6PgXmF363BfR7sFNz79sDR38YIvCIJYJvNzelWoQoVdNDHA/8JQxw/eM
 94bmM2mjHfyyUscd6qF3+WWNa3SIm4GF4qFmKz1ueVFdkC2w3oOG60pjswZXF9UimlwiuMd0R
 67AyYXgIh9xfdncpZKjSogomhOB+Te/0w3acP4+xynAY93YGaPEA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N0G1n-1pvIxv0635-00xNyD; Thu, 08
 Jun 2023 12:51:48 +0200
Message-ID: <dda1adff-2813-0ff8-1f88-fe14cc73c9eb@gmx.com>
Date:   Thu, 8 Jun 2023 18:51:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Content-Language: en-US
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1686219923.git.fdmanana@suse.com>
 <f566e1432b19f82d9c647b1c0e8e43743818bd7a.1686219923.git.fdmanana@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v2 07/13] btrfs: avoid unnecessarily setting the fs to RO
 and error state at balance_level()
In-Reply-To: <f566e1432b19f82d9c647b1c0e8e43743818bd7a.1686219923.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QgapND09XQ4KR5eDfTsvt3ZwdCBh7wEhRoMV9bDtgmVM1Ftjbgn
 jwQrAT0LYpHkS2Jiyjl8Dh7oFu05w7oHo7J/VoymzdLdKhOyUtrSTxnYII3NKJ8/PNzEdfo
 /1PzfFoNFleFFcHGVSP6nSKuVftSbCdQEWrakj6fLySXT7GoG5ICbc7sqsEGYoYA5Av2MLr
 /ONUHcLjrm2ZRbgnfVBrA==
UI-OutboundReport: notjunk:1;M01:P0:LE3ZZUBnouQ=;hsLxTjLdvu5MHQK8dPGnbsySQJr
 7MqVSZIcohJ89HtoRfn/+MKWpIoKQPrd0I7jDwqGd496a7xamaarNmhXZ55njyLs63rLUB/AW
 d4dZX5Ay+jTCd/tHaHi0LvZy4HV5MwUDqGyPGzYLZW3qfhxC4h/K2ugYnulmnIkBFBvLM0q2n
 xW0Dc2rj0s8/Grm6agVIO5Tn3ziBFFJgSwWcLF3IOxc/3fvBEmmTEKfMzOaleNRlZ5urmYfMf
 HEqwz0XqfHPcNOhOie7FAxe84NTrl289082+tDj4XjSzxtY8oQOvwnztI+Ay8ZhvcPqyVYlQZ
 uHFLOcjhNL3w2z2efKIMjDTmUEbQT/oakNg2XuPpdo3L9yWpSWm96I8OveQNIhXy3vznQ4yQy
 01o2rmVk2FnFPvCOSg5z2m66ZVQOv+NS3XmLDEIf8Ops16i0sJ3ob5js84LM7SZt1MIjkxWLZ
 7II8k9Kie/ARbRt9Wld8ks+BG0N5wCJ3VGd7NGR8/Mkq/zlPGYGezsryMwAzTGSeKeXQrifAs
 97DmHMrKnNd/40cKWJLIbbayszJjFhbrhF4zWnnXF166f5x7+XgCXJTQTA4yMFaplbrAl3naY
 udroM3tri1Li+wHU49z8MqBDVF2CmJT1MwZZrE4x1fp4POobk0xEu/0xMFxzOKZPE0qoS/+Z7
 2epGJ93p1HOSUxLDc6P172wVhRCkmbhOA5En+Zlgrvmg8kX387+4mGLak0c1jroW1y77cQZGg
 G/8BWH9uAtcN0xbJabcVBGu026oNGhHZEs+gUoh9vsbOQCSrgvL4z/zXc2R+x7oYtntiJWZce
 m75sitrVOXWin38Mk48s6bXfpoafJ3D5lBE1N3KjZE/qSyDzp/Jq08pG4Cd290+D8lb/C1f/Q
 vINeCEtIGnpg7rhHJKTot4u1QEjxc2EiK+ASvrqVAtr+L7UHuR3b3xssxx3Yh2z/LKjR6wjYL
 LHBi9BRnBzWXo99aSajPV972YjE=
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
> At balance_level(), when trying to promote a child node to a root node, =
if
> we fail to read the child we call btrfs_handle_fs_error(), which turns t=
he
> fs to RO mode and sets it to error state as well, causing any ongoing
> transaction to abort. This however is not necessary because at that poin=
t
> we have not made any change yet at balance_level(), so any error reading
> the child node does not leaves us in any inconsistent state. Therefore w=
e
> can just return the error to the caller.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Although I'd like to add some comments on the error handling.

The catch here is, we can only hit the branch because @mid is already
the highest tree block of the path.
Thus the path has no CoWed tree block in it at all.

If the condition is not met, we will return an error while some CoWed
tree blocks are still in the path.
In that case, a simple btrfs_release_path() will only reduce the refs
and unlock, but not remove the delayed refs.

Thus this is more like an exception, other locations can not follow the
practice here.

Thanks,
Qu

> ---
>   fs/btrfs/ctree.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index e98f9e205e25..4dcdcf25c3fe 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -1040,7 +1040,6 @@ static noinline int balance_level(struct btrfs_tra=
ns_handle *trans,
>   		child =3D btrfs_read_node_slot(mid, 0);
>   		if (IS_ERR(child)) {
>   			ret =3D PTR_ERR(child);
> -			btrfs_handle_fs_error(fs_info, ret, NULL);
>   			goto out;
>   		}
>
