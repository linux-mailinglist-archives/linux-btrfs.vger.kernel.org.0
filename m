Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF00B3AF97E
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Jun 2021 01:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbhFUXiW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Jun 2021 19:38:22 -0400
Received: from mout.gmx.net ([212.227.17.22]:49099 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231823AbhFUXiV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Jun 2021 19:38:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1624318565;
        bh=92axqBEmF/2bAbaPbL2qGxqRptKZMoVuTwN6HtA9TyY=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=gIC5Om8CxvtLCWgJeiMRhT8P9EFfKNYsdMbCVZbur4F8g+yY/wSoNw9P0Hr8HHeRo
         nYAIKfpNdFl3mVInytKIY+jN/ZlLTZzZw9Fz7C1JXPiknBAPL3gNGSl7dELVr5lNaX
         75NKBhbcTAwEMSvEfebJfYnASYEU+QCYDIgYPdaA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MYeR1-1libGp1DPv-00Ve22; Tue, 22
 Jun 2021 01:36:05 +0200
Subject: Re: Filesystem goes readonly soon after mount, cannot free space or
 rebalance
To:     Asif Youssuff <yoasif@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <2bb832db-3c33-d3ba-d9ae-4ebd44c1c7f3@gmail.com>
 <1b89f8a3-42a4-3c6d-aec8-1b91a7b43713@gmx.com>
 <CAHw5_hk9Uy-q=9n+TvtiCtLH5A08gVo=G4rUhpuQyZwzuF68dQ@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <60a9b119-c842-9fea-3fb3-5cd29a8869ef@gmx.com>
Date:   Tue, 22 Jun 2021 07:36:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAHw5_hk9Uy-q=9n+TvtiCtLH5A08gVo=G4rUhpuQyZwzuF68dQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WlEwQX3G+6svrW4kzA0NeV8P7LwNnj4As1OSn+PQTLgN5FWBNdH
 G6aQz3EZdZ3FQZ3daagGlFfV6cRkYS131Yn5JR0UclKbznE0cW/lKZFyrzuhiykt2EMV9Tr
 KOjskAwby0fLPJxbbJff20hsQdwb6t50TIuL+6IXV/lwjbg+BJnTNZ0tzIeXrsfUfyysk5I
 9G8C0Gtv/HiPCLRl+8jWg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Hcz2KGnOHU0=:MNRZGtV2zGRAFiW9+v4IHn
 vL9Munqu/8WZ33BZ8+cseI2QhGFSvztaqxXi0ihDjJ4siQxgip7/PPvU51J1dfetFQX+S3Beo
 r75ck9u6HZgojNbMLa0hcxmkQWvOsfxgNsG3/6gIff4W1W90e/IO6DAEAw5GK3JyI31i1O2Qt
 qltCcT18b5Y+adyBd+xxdDf5drjG2ke6qSFwpQSD5djRdiatWLliWgtLOZ7rAxmZqBqbQw54H
 L6kblGOXAwWcuh4odR9g+FB3qWQ/f9H13j27zUFT7BugYLKBhbT6VInr6mtD0zCbSP3hXhRUW
 FsDAxkEkKeIG1fsKCkX47vEIWvxc02y6b31JeKkiYKatDp4N/R1+D2xFzKBEllsExkAEGmhbI
 CHiHFNs10gRsUO1vRgeKDcQn9seoruKUirTHwJYtomuB1JqoBHi9datWwkx+1wFyeqrfD7K9C
 zjs0jsewhD2tgZ0avSSVbkSKSYOnYYi/CErdr/s7AyH3PrIWrIOQDNQoaQlb6Kz3s+rkY66oS
 CpLgpgYqvOALYCTwDl9njAoGt1ZdvHjw9GW9+QE+ekAWlUiKXQ4UPvHgMBjSXiT81UYxLFXc1
 lRXVCI+jI/tNU+Rk91HJViHxqLaD5E2h3yqPv/BOFa7OvnY7UO3iycFcn0dgQ2ho7bCk2Fy9o
 tnOgfMFSFd8FXfvy0MIOQoDcQ7QerMxB1HlKvfzV9RinDDr7u8d8fczdVx0e7jag5p7UnLGMC
 9MbwuaILecevfhTcRBAv0AGHxB25xSylnomtNiSgtg3TMEcW7a0mdh59DquPuKKBBmHhiCyLF
 EMkyh8Qa+dqEyOR/FbRANrTX/ey4l6Q1PXdGJ0ZXdF5Jmr7g6G4fDwDQ3TiCcVUSbRvqvEKfl
 sTrS12co+GI6z4kAkA0eqnbvZwEk/7Fx/gqPx1cKjdXodx4izFyoL+8Taou4Ai08ez7eF95hi
 XSUjdE1YVnR2yUbR4UQ7tL49tdtLJUGfEPjXfqBuJu0wjxCR2YBOwOf5QYZ7HjRyoF1k//KAz
 yvKoaQ0p4/qFUuGIWtoNYqvbuD3E5/VYMdX7SClhe9/3u1DDALB76n5uwJnszSCDxmOQ3cwIk
 85Q35Zvml6qfBrAI6TzGoRjY7M2j3e+Fin7/GWkXp6477TVwtFfPAh4Og==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/6/22 =E4=B8=8A=E5=8D=887:14, Asif Youssuff wrote:
> Qu, thanks for responding.
>
> On Mon, Jun 21, 2021 at 3:42 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote=
:
>
>> Can you delete some subvolumes/snapshot to free some space?
>>
>> In such critical case, I don't believe balance will do any help.
>>
>> Regular file deletion also needs extra metadata, thus maybe only
>> subvolumes/snapshots deletion can help.
>
> I have tried removing snapshots, but the disk continues to go ro -
> after remount, the subvolumes are still there. Is there a way to force
> a sync of the subvolume removal before the fs goes ro?

Maybe you can try "btrfs fi sync" before remount?

Thanks,
Qu

>
>
