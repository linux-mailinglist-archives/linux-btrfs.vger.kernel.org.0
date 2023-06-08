Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3023F727AA6
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jun 2023 10:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbjFHI6Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jun 2023 04:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbjFHI6H (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jun 2023 04:58:07 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA4F1FDA
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 01:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1686214680; x=1686819480; i=quwenruo.btrfs@gmx.com;
 bh=SJ8ZcNCsa5gBQzJ7sTeS8FxTWYJdewLG4yAW+0SzgeY=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=CbP6EvO3Sfl2YSIzV//hEC2xz0kwjIfDU03SdiMqitazyTHLVgajA7bHmVarBNNfI3rONwf
 3AlqjsX7Lp8G1VE1Zlx3j/SR14AmN30J+VLxQwMEGSAJFk7TiWv7U42gpxVNcVtqCNnlGlgpf
 0Y9F5Rv75ZWjslRotmdw5Fr6BWNQDdivdx1VSCDehtc8ZBt1Vec8B10rs6y/GYj4Ou/tWg0ep
 3Cil84AU6E0/0JQ5MxV7T/1dloRtJj0ETTYTkafGQFk6b9riBGt7qhyRzD80ideERNO77ZYD9
 rgaqp+yZrZHR+GGDId4udR8Im1kRXswG4J0ZkKJD72P4qovLtM9w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N2Dx8-1q2CNa0PEc-013heY; Thu, 08
 Jun 2023 10:58:00 +0200
Message-ID: <f90ee8a8-65f0-b96b-296c-1720cd9acfe6@gmx.com>
Date:   Thu, 8 Jun 2023 16:57:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 08/13] btrfs: abort transaction at balance_level() when
 left child is missing
Content-Language: en-US
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1686164789.git.fdmanana@suse.com>
 <91e588216500d2aaa7e119e5ac4be927c71bf066.1686164817.git.fdmanana@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <91e588216500d2aaa7e119e5ac4be927c71bf066.1686164817.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ivw3js9lxpdg2vIWh+gN8qcqszFfnNLZkwBhYZAZZh4O8AFaWL5
 Z2dbOc5mVTE/vzj36/oftf5s7tlEMKM0bai/yuMyLBClrlU9oDHzqfBmPU6ozImJQwxrlNZ
 7oprrg6phz8mUlMzlvkL+Oh6BfSSwR6ar4tpWfAcf2Qq0JVtX999fYT3mDSYbk7clKVvO3A
 dUBlyb6ju2kh+Hv5xOHng==
UI-OutboundReport: notjunk:1;M01:P0:9Mu/sAC0WUE=;H8xQSTCD/Kd6kxC5CN2kFJarcD/
 cwBkcyMDD+U6g0J5Yu91AozRT6gXsqvBw+oDOKxaQiAuMG8COzwru+mdaa/4WnOLPhmB9SwrE
 +e8ywCK87qEZ8fospYuqYAhjgRfsjkKYR2CjqEyGGS3XONQELkzuljRqJ2bUWO+TK4Oy5IxWo
 6oLlNtrnfJmON78eWdzMo3rFqe6S6XGVGf9cuYTAcERJ5WyPnC00+k0qXjwyJbsea9Ijjpq0S
 p0fZWEmyRH0VawzToT8TTvfSxh4aZZz5ifGeJJsaB4+pBbIJtboWoh+8pd+K2XQmVbAyoq1Hr
 K9txfJLviqhzFJAeM9PTEz5MQQzYFVX2zq85jjx+HNYsCI123fYtFCHg4rSajZ77Qz7KpzOYX
 t/88hy5ygKkiOdQ207QglOlSRsAKQJJgJxoJopgcgHFlUy2Yt9+ShuqZ6krXLxHsAt6JYlDQv
 Og4VViVDH7TZNsNp6w7O9jwvZZVTHMHWlyPY5pR2Jy4Smnsp09XjSmRlxHHgvVhKnwJ4Xi18S
 A3QJZVHNOZmEYeeTz9TzBDFArSmcgtugZhUPlAeaYPMm+Sp/8zRyipfUJnUpj/5jm+nTTSl9y
 DOOB7RZti4HrHA8uMfHEjIs2QUBKNyiQkMIHjGTrHOnbgw40qj5N3a2ouRVhv3fgTZY6x6gXj
 H8PViuHrCPr25q6VM8sOtRfhonPP8tY00DbClug8YuSi+8Cu0CmvTXatr1qTKjpb4vKwZ9SWb
 ieQaCHLlFpxVLsKHwJVSKwePgWzQMKEYUZiwjFHbZYB4QG//ZK+ydR2jVe/8UZKKMFC97GMhh
 MpGRd9j2N3A89BU7xtbAV+74TW/sA41LLfMZaW/87Nb9J2/leyZd3LRV9P4l2/Y2luPzHm517
 rMAyrkkDGuasgciJTOA09i8u+VHGUV8PKqYDdH05MN3WpfNB199uqlCRr+M7v8bn/a/Ix938e
 xebd69bLuGjudED55jRn9FkE1Sc=
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
> Also, as this is an highly unexpected case and it's about a b+tree
> inconsistency, change the error code from -EROFS to -EUCLEAN and tag the
> if branch as 'unlikely'.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>   fs/btrfs/ctree.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index 4dcdcf25c3fe..e2943047b01d 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -1164,9 +1164,9 @@ static noinline int balance_level(struct btrfs_tra=
ns_handle *trans,
>   		 * otherwise we would have pulled some pointers from the
>   		 * right
>   		 */
> -		if (!left) {
> -			ret =3D -EROFS;
> -			btrfs_handle_fs_error(fs_info, ret, NULL);
> +		if (unlikely(!left)) {
> +			ret =3D -EUCLEAN;

I'd prefer to have an message every time we return -EUCLEAN.

Otherwise looks good to me.

Thanks,
Qu
> +			btrfs_abort_transaction(trans, ret);
>   			goto out;
>   		}
>   		wret =3D balance_node_right(trans, mid, left);
