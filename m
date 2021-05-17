Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFFF8382998
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 May 2021 12:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236148AbhEQKP0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 May 2021 06:15:26 -0400
Received: from mout.gmx.net ([212.227.15.15]:37943 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229474AbhEQKPZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 May 2021 06:15:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1621246437;
        bh=v94oBgU27MM+bPMwIq+5aXQmdE9Vdj1PZQAxw8h2u24=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=c/Pc4PFw4OplGruKpXYpfyLHMAmlItPh6lURIPdrPBMk1ZTJKSBBgQjTiaFegYQKr
         RyMcABxzYgRnlUoooONbjkCk8YNzuzggtqXnClXSt1uBmHe4zhHrNcj8O1wNhtuFjz
         nrEfxIpEQEj3i/z5lU/0WB7p9PaDFL7sVuSsi9Ow=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N7zBR-1lMQlj0u8Z-014zCc; Mon, 17
 May 2021 12:13:56 +0200
To:     Yang Li <yang.lee@linux.alibaba.com>, clm@fb.com
Cc:     josef@toxicpanda.com, dsterba@suse.com, nathan@kernel.org,
        ndesaulniers@google.com, linux-btrfs@vger.kernel.org,
        lukas.bulwahn@gmail.com, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
References: <1621244810-38832-1-git-send-email-yang.lee@linux.alibaba.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v2] btrfs: Remove redundant initialization of 'to_add'
Message-ID: <5938551d-a083-a62c-4ab3-bc29fc62b1df@gmx.com>
Date:   Mon, 17 May 2021 18:13:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <1621244810-38832-1-git-send-email-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0U/g3hMrG3o9fGlDnHRwXK68W/K/FH6/b8eQv0VDDz9dIoTuExD
 xiqwfwDQjRUSbpsNx+V1gb4ixIk+Gbu8vRb48DLnUwvhlCqjKIizRtaHsZpe0hoW7KvFJyw
 NKlCxDKqndQ3Bdx5RHdM/anE7VyaVFQpGiMtm5BBwqE4eSZaOTiIynYlx3a9sS6WhDItKGV
 I79EuEnKM4vzA+F17vjEw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:EPaV5kE0SOE=:ncrqL6P/aa5VszjRuabaVJ
 v0NDRFGqT4o6+C9MIYC7tdXkezCnrPaKX9AQ5GKXGf7MSx2vRxowMoZ8aM4nUNGd0OyrhPPs5
 lN/e26mL0DtMbaMvr2SxteBC889RsSy+vRoo4u9SVFtuAXC35t2CpZFxWGhM6Qq73vcbylXSF
 8Vnxi/goLea5bds1eDCTsqdcrMWFA4NiaxzGh+YaNrpWUJYThjnDx9+uT6ejO95IkU91ftHfc
 V62Q59Qq2sLj4xjbw4Edqb86Vib3OeXGxvqWL8mC8wjooh0YGfPYEG6wNlzD1b4d5wrLqHZy5
 Vrm20vkgElTZ5ztgOeNoatMxMKENNFoBXM6nt+RuVm/f9qexL90qh2iQE1I6E8pWYj5cWNpwo
 +aphho6SZ0pjVjsLdgZhRZwvhA6pGIr/1Gpx9JaQ8N/yi6rpbZ8wAlWTYhtO5ZVIfWAlo+BFs
 u2J4iStZPztdOJUnXSDzwxoHRiB4QwnQkqOX4UQkKPdLgzYeoFiMeUsugl+WMfjTibxlhxzwz
 CDSCRddDCuhXIrUI0y0aJiLEd4kP8ri3fItabECW9Nit+bT/aJm+ggHz/ixUNEEuQjRjzbiVV
 YfSF7Zpo22yPT56/e0hJGWAVEv1EMII5IDlMWFRVNKLfYAXh41yLsotWOMi0gnBmxEKu+OQre
 dAk4yQtxMe5T0PCgT83ZbSCu0OCsuKdQvBRGSUNFM48oz46P0N74AvYeMtK7GrA8/bpq7rQYE
 OJLRtVM0h/TVNNGo+FIXSKsV9+FPJt622p/LswSXuEJ/4joFh3xM14Vg1xqgmAq0CHSdDFBdc
 f8rfEcEvIEnDxG7R/0xghEY1WsjKQVBw2T4yKTHWc/SOvwF0dHOg593EVnzim6ninde/Zvc9B
 grKyMlFCIx3qQt/f9ZZvrvfKmBRN/0H80yLXfElckzsFk+FDzF+b6wbMSKCwDtCzsflfqB6sl
 t4kFHkiu+vUxMdRw+musVAi1DQpXFYKabqX/HKu2gyJF9IYNIqt0n1GzA2dnaEiOCm+321OQz
 3aE1ckDLPWBDX1DlrTW+6dOrWKIpkbZzP2Ca9Mo2wnVJ6pTlW0PL488zRoJJOnonsU+wks9J1
 92VvhgivSrjCLLESNVBSdDJnk89YmTAKQlVhOSTo4C93nrNHDUkshMrxjeUD1wX3PfeSeorV8
 O2JTWFXuUEXjiXRL3XAwY0PBfPvN9zufUtQGpWUDUDmfJhTLDNwSCfpTWWAqlumWwgMaO5LQ2
 ogOYv3hOMnM8x6XXv
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/5/17 =E4=B8=8B=E5=8D=885:46, Yang Li wrote:
> Variable 'to_add' is being initialized however this value is never
> read as 'to_add' is assigned a new value in if statement. Remove the
> redundant assignment. At the same time, move its declaration into the
> if statement, because the variable is not used elsewhere.
>
> Clean up clang warning:
>
> fs/btrfs/extent-tree.c:2774:8: warning: Value stored to 'to_add' during
> its initialization is never read [clang-analyzer-deadcode.DeadStores]

Personally speaking, compiler should be able to optimize out such
problem, nothing really worthy bothering.

Especially considering these "fixes" just randomly pop up, distracting
the reviewers' time.

If you really believe these "fixes" are really worthy (not to just
fulfill the stupid KPI), please at least pack them into a larger
patchset (but keep the separate patches), not just sending one when you
find one.

>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>

I know some maintainers are already very upset about the bot, although
in your case it reduces a lifespan of a variable, thus it's marginally
acceptable, but under other cases, it doesn't really help much.

If such fixes come from indie developers, I'm pretty fine or even happy
to help them to start more contribution.

But a sponsored bot just repeating clang static analyzer

Trust me, no maintainer will be happy with that, and you're destroying
the reputation of your company (if the reputation hasn't been destoryed
already).

> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>
> Change in v2:
> --According to Lukas's suggestion, combine the declaration and assignmen=
t of
>    variable 'to_add' into one line, just as "u64 to_add =3D min(len, ...=
);"
>    https://lore.kernel.org/patchwork/patch/1428697/
>
>   fs/btrfs/extent-tree.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index f1d15b6..13ac978 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -2774,11 +2774,9 @@ static int unpin_extent_range(struct btrfs_fs_inf=
o *fs_info,
>   		spin_unlock(&cache->lock);
>   		if (!readonly && return_free_space &&
>   		    global_rsv->space_info =3D=3D space_info) {
> -			u64 to_add =3D len;
> -
>   			spin_lock(&global_rsv->lock);
>   			if (!global_rsv->full) {
> -				to_add =3D min(len, global_rsv->size -
> +				u64 to_add =3D min(len, global_rsv->size -
>   					     global_rsv->reserved);

Have you ever wondered why "global_rsv" is not indented by tab only, but
with extra spaces?

It's supposed to be aligned with "len".

Thanks,
Qu
>   				global_rsv->reserved +=3D to_add;
>   				btrfs_space_info_update_bytes_may_use(fs_info,
>
