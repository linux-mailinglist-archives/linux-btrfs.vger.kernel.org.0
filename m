Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26147727AA7
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jun 2023 10:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234641AbjFHI6z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jun 2023 04:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbjFHI6x (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jun 2023 04:58:53 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31109E
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 01:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1686214727; x=1686819527; i=quwenruo.btrfs@gmx.com;
 bh=u+wSDKmx3lARWs/F0CY9IEuSaHFC42/+MzkXW4aWiCU=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=dBkzUsH4oy9szc9XxoECK9yPckWMpCJutQUJCtSfKHxfScHhV8w/MwiCf8uxtsu7NzzbYSR
 XCga7K5ac5twt0yssl/4ytYKnWWwGKyUZNootudfQXGIAp1BOrbEu9JS9nCCO3RqCDBH2zU5l
 UfCn1pcSckgSZOZjf+uoUHZeOCICyAaVQcC3grP8yTU98cjU78WXYSd3Evx+tPfkJU3IiLFAf
 K4O0+0Zt5urG5g1dnRj8cipJa0HlciV1RJ7Q5Q7dInNlTjoBXurldsVGgsa/RRLckZBqfhf0b
 oX13ClbsULuafyTyTm7kShQeHMlHhWKcvjkNXnDuLmAvKjXUG2sw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N9dwj-1q3Z0V1IRh-015cbn; Thu, 08
 Jun 2023 10:58:47 +0200
Message-ID: <88b90700-8034-46fe-0969-dfe6e7eabdba@gmx.com>
Date:   Thu, 8 Jun 2023 16:58:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 09/13] btrfs: abort transaction at update_ref_for_cow()
 when ref count is zero
Content-Language: en-US
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1686164789.git.fdmanana@suse.com>
 <a7914cc7ab662f8bf4e0ab5622e81622acbc186e.1686164819.git.fdmanana@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <a7914cc7ab662f8bf4e0ab5622e81622acbc186e.1686164819.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:52U8haiwkjzLU2v6wcgsa5zwTu+/YQZ/8uzbhOyAFZ2/o+52IQF
 lYpRM7p6qaLi5BUyEHoHxkc1SPMYaBpIkHJk+Mm+runkXjbR5vtvm0iXxwzeRuKopAoJV3h
 2tjY/VAeVatV5p24ItHRRK7I53wsCrOe2MP9pCRYR63Ru6nX5zOjmLvA9hn224fXRx8Lmj5
 kRanwt3bjfXt0jm7ZvUEw==
UI-OutboundReport: notjunk:1;M01:P0:xgTgbmx+UF8=;8jApXcLtV5gmszP1W/MkI4yWjyn
 lvBH5MV0iwvfMXBMDNDiRnKSoc06PiyxSXiREwbmG8WhEHDQ0OTj8NDrAwqWjCAMI5kPkDTW2
 oysIAEwcNfhWr5ELjrG42SxJ8dJdvdG9eT4eKHMKJ/7lkD8RcqnXmsGV4eDjTE/8dagtRC1nk
 RQ7hls4kEqPNyl8qQ05KXnaEsCqfDpidWZIbTEM22pgvoD6h4l8tU0C0+9UIXAFbbLarWmyA8
 x1WuH1w9jidbY7INWtC4As4PX1QTTuT1vHaaNJhE2fWl9nVeLCU2lGy8pqbxwmbmv+cYVs0ul
 ZJLfP5vH/gYkPD5CbCkYVg2oJL+bXO9r/zw68L0T1bUOL2E6QJe8sfuqex5UG9Nf66QHZwCgQ
 edcA+ZzVUJTgGcvQ007/zVWQjZ8epsQ7raWsuah84w6vcWDGp4iX0JI1bvELriI3/5mQZ8H+Y
 +63BAk35X72wF+8Osq0GEsKReMCQzB/p43Z6SlHAoRgHUzlHBhwvV4cxSDFStcB02sbHy4HHC
 V2KWVKwgf3iQcR7l2qXDVXwttFKASbcdt87l+m68HeHo0yxTIxbh/ojNBfRl8zdduYF3AUul9
 MVIKgibDYprAs14CfS7v3UwHaJwqi7oUwdJd/nZ5KY22/qJD6K1NC6pB3JkFSnm8h4Z8b9Wid
 yNU2DdD+FSbh+02h/qnPXkWWuLQWRJbwIG1p0ADXfluYilA+NQwMDtHqg3NcmgBgtUWccr0lc
 JXpeePQJxTdHE32NA9M0eRC6w1Ql/pWf9PBx1YuCPCoXQKmtTi6qlNhB2MoUIePrVP3mAF7Fs
 uVnKkmLycE+OIUTBQu89E5hO0Y+/dZqW5tZ2z7bJIo86p0G49XrcxXkWYThqKWiOnCAkI7Dz0
 i0H+zY/AoUL2ST/Stsy4CSGeOvBs0vGbjFjx3u4wq9b0+aEW0BwZMFCtZHUyrqvRDgle4kqjf
 JtQ2dP+ilaHGOXstkkyMCU4YkHo=
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



On 2023/6/8 03:24, fdmanana@kernel.org wrote:
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
> corruption/inconsistency, tag the if branch as 'unlikely' and set the
> error code to -EUCLEAN instead of -EROFS.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>   fs/btrfs/ctree.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index e2943047b01d..2971e7d70d04 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -421,9 +421,9 @@ static noinline int update_ref_for_cow(struct btrfs_=
trans_handle *trans,
>   					       &refs, &flags);
>   		if (ret)
>   			return ret;
> -		if (refs =3D=3D 0) {
> -			ret =3D -EROFS;
> -			btrfs_handle_fs_error(fs_info, ret, NULL);
> +		if (unlikely(refs =3D=3D 0)) {
> +			ret =3D -EUCLEAN;

The same as previous patch, just one extra error message explaining the
reason for EUCLEAN would be better.

Thanks,
Qu
> +			btrfs_abort_transaction(trans, ret);
>   			return ret;
>   		}
>   	} else {
