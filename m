Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFC0544E0B0
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Nov 2021 04:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234575AbhKLDPS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Nov 2021 22:15:18 -0500
Received: from mout.gmx.net ([212.227.17.20]:40909 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230169AbhKLDPS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Nov 2021 22:15:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636686735;
        bh=432XySQCRmn4r9Ix6S+dj3IqXDHREI8FFsRi1lAzCGM=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=O1NbxJyvdw/tElGf7eyhewuAmAdpzavMdGCaUSgTwGINUR49/34GOba/tntVnNy+j
         FxjSw+BBzEJ7FA0LYzHn26nWgmAoNXRAlVJV6/rqKRMuNL8SoQDPpy63bfDz/B4hPR
         uiUw7Ft849zXuCt8nv2tY2fi7i5esxT/BLQac0FA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MDhhX-1mtNbl2SBT-00Aqia; Fri, 12
 Nov 2021 04:12:15 +0100
Message-ID: <9ee991e8-0d32-658a-8a9a-09a7d1d88ee8@gmx.com>
Date:   Fri, 12 Nov 2021 11:12:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] fs:btrfs: remove unneeded variable
Content-Language: en-US
To:     cgel.zte@gmail.com, clm@fb.com
Cc:     josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        chiminghao <chi.minghao@zte.com.cn>
References: <20211112024950.5098-1-chi.minghao@zte.com.cn>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20211112024950.5098-1-chi.minghao@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jQAUnfBSqdP/Sz1v7s/ZimLNbDTFVgUFOKn7hEiLePZwSGCGwjn
 cBiTzMKPzBDKIMgDjfHky2h1I/KDsWvwfd+LZO11J7FpnL7pv5EUjBZezPVZn29lN+PEyIq
 YS9PXSp7WuLxRMCJb8zDV/+IvIOPcLL20v0k/Q/psYcT0J9vGuhWpuUqzsilZ1YMJ/hvOzo
 UrMGvi1duiTVL4cbMeC/w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:PPxwJVFTU/Q=:sbnlMvUTaHfhr09P+2wHkG
 5EiXtItSHVcsJg5i+g/oRj4EiC6vDzU4UD7d1bs9ysQfYqdsmaZ8k5Sgv3NksjkIW4IBqxuxZ
 wMRf5qaLdrCWhDUeIvfmKtpFRe74XeIzcTF2VmBTKN6yxURLvjx+c4qMwueiSrVOna49pvhBk
 wdTSO1A0jQibabK6daXibibsBJoQQFR0XjR2Qea6JBxiwPrRvE3SMfShpFuBtjog5rN2K9m7M
 y58xdltO5W9DOWn5CqW8ZQ3lDrFyXvSBeqBuu0Pbip3ktl4Oms+j7e5h28xKObz5XkJkL/BJ/
 1IGKtNHjQnM1Lyks/53e7dPrk7tZgbq/DObR2mPZvSAd1NmAj9zNtQuderDRpQoO4+A/GJpim
 58FBJ7BN3qP+kWhJsgfu5ZqAK8y/i4Ig53NHzyh8LvPxw6hzJEcWjsL4gGO5yQyIjUCs3GNVF
 0HJtVLiK6+TegPlazeypVVt1a4Lue4JHpf4pci1eehDqTGWdwChzxSy4Vf+ytnqtkcSvBc7Iq
 MtVba6lLTB88EAC2/8DL/iLtThR5St2Pa1V1aFNFz/HM4o/Dq0sDT1C9HEhiEASnTa56ky6ei
 3GrynoE28W+N3elfcxPYN5lglIvLyXABsvH2VeNbOUY1M5KuDwYTa+dh0ev3PNAy4m0rEkiLo
 rO1U0ZVYCGAKHBb6a2Ydr5c6SIB5+d1Si52hmM3cE/Zuyjaz5x10/+LfgawID179fOp+ySbd5
 3cM/lHqpHLGXrblrtoH6MpsJlzaqelTpkaRwY4JeGAxuMpW03uI7nXQHEeLLT2rMX/yBhOydk
 IUHfHWHcOGdL1f+wDYiqnXPH2qXZ45oamknz4BGj/cMKWfrI0ykJYc5u0xbM10BNmmio93hd+
 EytM4QNRT+GtNZHCCyV6sab7yL6hCDrZASOmkuPqvNHQ5MDP08ifP+YUCq/MbFFu8f4dAWaH8
 pwGWMlWtxc0B5TFUGs27X+xSoJubj2FH8TmA3iP2Ewq1w15Kt1LyDzMOdbkJoc0y+n8xWMkX3
 c1tx8tA4A8+BmdJfAaaEZOKo6ZhWig/Up5ayqHOYwkAroqNuyACkDUlW+7e0W66DFTwzCLwWt
 SBrsjY/dVeBR8Y=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/11/12 10:49, cgel.zte@gmail.com wrote:
> From: chiminghao <chi.minghao@zte.com.cn>
>
> Fix the following coccicheck REVIEW:
> ./fs/btrfs/extent_map.c:299:5-8 REVIEW Unneeded variable
>
> Reported-by: Zeal Robot <zealci@zte.com.cm>
> Signed-off-by: chiminghao <chi.minghao@zte.com.cn>

IIRC the @ret is reserved there as we're not handling the !em case with
error number, nor is the only caller properly handling the possible error.

Thanks,
Qu
> ---
>   fs/btrfs/extent_map.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
> index 5a36add21305..1dcb5486ccb6 100644
> --- a/fs/btrfs/extent_map.c
> +++ b/fs/btrfs/extent_map.c
> @@ -296,7 +296,6 @@ static void try_merge_map(struct extent_map_tree *tr=
ee, struct extent_map *em)
>   int unpin_extent_cache(struct extent_map_tree *tree, u64 start, u64 le=
n,
>   		       u64 gen)
>   {
> -	int ret =3D 0;
>   	struct extent_map *em;
>   	bool prealloc =3D false;
>
> @@ -328,7 +327,7 @@ int unpin_extent_cache(struct extent_map_tree *tree,=
 u64 start, u64 len,
>   	free_extent_map(em);
>   out:
>   	write_unlock(&tree->lock);
> -	return ret;
> +	return 0;
>
>   }
>
>
