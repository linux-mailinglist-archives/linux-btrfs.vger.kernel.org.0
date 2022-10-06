Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6765F61C2
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Oct 2022 09:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiJFHiK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Oct 2022 03:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiJFHiJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Oct 2022 03:38:09 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C9680E80
        for <linux-btrfs@vger.kernel.org>; Thu,  6 Oct 2022 00:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1665041879;
        bh=1x/GD35K7LFcoOjbPPObXXZAHAhxzfBls8OrDEiCNHs=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=WpItW/xuSHDxOFAFG6swWJ3s9dn1cKFhdbz4rtF4lbdcJkrAtWMTt3PN6RGYQUG3i
         acXQEBmjyK/fsenXzRubHsp58J5GH1D0kJ60V4j0yfB+PIymtE5p8+oQkcbJ7QNZiM
         D3BK1h96cyloGXvXvDKmZ59tdnRuK5wN2e2Lus/o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M2O2W-1ocVAW2zfy-003vV0; Thu, 06
 Oct 2022 09:37:59 +0200
Message-ID: <bb97abd0-70ce-15b3-f1fb-ebde4437aef0@gmx.com>
Date:   Thu, 6 Oct 2022 15:37:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
To:     Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1664999303.git.boris@bur.io>
 <cace4a8be466b9c4fee288c768c5384988c1fca8.1664999303.git.boris@bur.io>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 1/5] btrfs: 1G falloc extents
In-Reply-To: <cace4a8be466b9c4fee288c768c5384988c1fca8.1664999303.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OhG+cpQgr3oJgUZU0ClOYnkozRfUBkCN2wjwOVVAI4LzLfSbwv8
 jt+TT+DR2Bjx4fF65ZSLh5SGdTINxZ46Cxzzl5zLLWMM6nb2+m3tL6kXrF17ygL93e2Hqcl
 mHnGBUtBFCmrMmEeARPujq3ha113biqs5NkPLvKpomT3NUbQS9yKZLR0YDjmxx7sY2S+Urs
 27H7F1Debklk+XM92pUAw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CZMj9/3l1Kw=:XfArjFFXGiPNDr7qquq72t
 y1a+XDYFcAv3Wm4L+PSBiHmQ8QTlk52x8bmN6baP7fL9cJbPSJjBvmBMJnqHPpNjVS072b+dQ
 2RR2KdFLV1SzlH2JwJHZV1zpDFjbdpuJ9hXsbmmNnKBYPj3A4HWyuHYtxnRs7ObYR18tBqZE2
 kAbsouF1m7sHtsK5JViUVE6bDFaPm6/P/V1y+sFEHOrhD6aC9GOMSlUeCzdJL5r8wr+7sxdSd
 7bnnlaTrXmux6zdy5XYSisyu0VvD4afLs/SpWgTEbjC26ynIpSpqQkVF3iv7PwllYMqKQki/a
 4lARnWkRlXRd2aEmcehwUY0Gz2hOWtBNpRyb13I13xQCeLesMW9nwHi0wxBA44+XAo09ZZUP5
 L+qsa2FwmHEROjv60E2UL+1312TpwgzxZwEKjxeSAk6xAEWf/Csb6JBI/BifbmXSf1XrFaRer
 rCy4gYJr+alcXL/K1RTl9Rj0LCm1to5cca/7VNJDblBONloWYxYmqCu//H0vzEuasfuWXBYf5
 MAsZbi/4Es4+JlFdhm0hrne67zhe5KR+14FlUchsiyIsfNLUewFoiOfcNpkAyVDzgdQe/RgVS
 NUWzdgGVc6RhIaEcSkS/s7lJpKvGvJ9DbTbhylwc+PZIpUrgmCL67wjwKkmQcBM9CNDdHhLRn
 UW5TWQXWaum5Wahtivu/UF3YtZrz3L5Ot219QGlQy3S6W+klYq06/ADiQKcULroph5mtmUKn1
 w6pDDyuPxi7TJnPUiK88y+3MEu+Ke8ZCw1SKpP7UIEaf1Odiz0Ztyn9MnckUoLt7oWV3WUPug
 0cZvkLkilVZxlzk4tABklzkOsYqAYfKTgC+qg+b+6c3OVncn6iRbRhQ8KwveShCnuh2/9TZVF
 5ckEWZuon6fLO+5ZCOXemngAC6EX3RjWInCFqwgdK+hABGLXQO/JbE9wmAGp14y24Rven6nqI
 O0CsZBelu1QFllVjRhcyNy1H+g1bVmKqL8Sqmn1LrqBkrpRZpDpq+yguR8glz3gh6xklCeYhD
 7vzZgJ9vPV/HMX+lMIsJxL4krKQWcIXKX4C3r/o2tEyP/bZZka+j4Hgg+v5vCzfZuyUO7t5vO
 J7cOS4jaZaQ3ZH6k3JKx7t4tK8ETEgya2bf8qa4vnV1cb1eqy2F6GgcOOMseGXDDS2m8zDZON
 gua41atBGgF+xmU7hE5/RhCOdY
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/10/6 03:49, Boris Burkov wrote:
> When doing a large fallocate, btrfs will break it up into 256MiB
> extents. Our data block groups are 1GiB, so a more natural maximum size
> is 1GiB, so that we tend to allocate and fully use block groups rather
> than fragmenting the file around.
>
> This is especially useful if large fallocates tend to be for "round"
> amounts, which strikes me as a reasonable assumption.
>
> While moving to size classes reduces the value of this change, it is
> also good to compare potential allocator algorithms against just 1G
> extents.

Btrfs extent booking is already causing a lot of wasted space, is this
larger extent size really a good idea?

E.g. after a lot of random writes, we may have only a very small part of
the original 1G still being referred.
(The first write into the pre-allocated range will not be COWed, but the
next one over the same range will be COWed)

But the full 1G can only be freed if none of its sectors is referred.
Thus this would make preallocated space much harder to be free,
snapshots/reflink can make it even worse.

So wouldn't such enlarged preallocted extent size cause more pressure?

In fact, the original 256M is already too large to me.

Thanks,
Qu
>
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>   fs/btrfs/inode.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 45ebef8d3ea8..fd66586ae2fc 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -9884,7 +9884,7 @@ static int __btrfs_prealloc_file_range(struct inod=
e *inode, int mode,
>   	if (trans)
>   		own_trans =3D false;
>   	while (num_bytes > 0) {
> -		cur_bytes =3D min_t(u64, num_bytes, SZ_256M);
> +		cur_bytes =3D min_t(u64, num_bytes, SZ_1G);
>   		cur_bytes =3D max(cur_bytes, min_size);
>   		/*
>   		 * If we are severely fragmented we could end up with really
