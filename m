Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDA239107C
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 May 2021 08:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232903AbhEZGPL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 May 2021 02:15:11 -0400
Received: from mout.gmx.net ([212.227.17.20]:56153 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232350AbhEZGPK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 May 2021 02:15:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1622009611;
        bh=KxgWeHfxFfUb6Gv0RYGmvh4jtC6GycYtBhkPxNEiLY0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=llZdYF9IKzwVI8TBihyK4zlZzBCkoz5pR9MVog4mJwXQVCTwEyj5+ITcCgK6T1JxY
         HFOzMg7q3oC+4/pTVYJNEsCQjnuKrSSV7gtq0KqOBVL50k7vJqRnGBDYICtW/BFnzp
         xH8pZcqVPkLQKg1f6g1yQfB5UmoaScXsWghaZ4xE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MUGeB-1lukq91OfT-00RLqB; Wed, 26
 May 2021 08:13:30 +0200
Subject: Re: [PATCH] btrfs: relocation: fix misplaced barrier in
 reloc_root_is_dead
To:     Baptiste Lepers <baptiste.lepers@gmail.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210526060947.26159-1-baptiste.lepers@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <9fcd47ac-2642-88be-1bf0-7b920baefb10@gmx.com>
Date:   Wed, 26 May 2021 14:13:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210526060947.26159-1-baptiste.lepers@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:faF+UzofNDGJzyvBV9ZdiJ9SvU9svIoL4IA1ZAHTd1jXRfYLaCl
 XAJRJvb7Npd190Vb1QayCDnHfdq5UDDx3KTAa7nSN4ug6L1VRszEnHJuT0k079LqhpaTm66
 wIgNaTWn9/iQlYRKh3Az0qqgiKan8Fwu1B/dJVf6ck5ed//3dctyUX7slLfliwQyxXrZUcP
 BLSFqEohqW1HaLa2AKLZg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:4WC1wSO3Sf8=:u6JYmwTTyY6j8M6nsZfvfp
 jDwZYrU9eZ7eb7bnCIZ/8Qs+blHML/LlheICJA/F63rp5rCxuNFdrWYyRYiMIyx2fUWVBs0dS
 P8RpKOSeJd9oOjMd7cZ/tBmLrbjqZWykIpQTlatsMK/mtQlXN7045yDtxVdOiq7GjkLl54UiR
 PfjECtGn5XqYwsd+speVMAR6m9XDK6EUG25D+A8VLGr9BP1iIk8Er1XVyJCzWevwzpGv/zxYR
 BZvpUCiWkfJUVfcEnRRRP43eLwPLp11INcQOXzQOlq72FuQEvkeyHK5CEtDyJLYvRsW+SkHuW
 JXXfnS2v42tGCTRNPFdZ8AblrtfE8Tsh/dpJzeUSWdeik2l0CwlYyo7x+Hz/AyKzXnCMjh4Zu
 NHZsYboqwO2dpJYoBr7svDc4fjiG4q28GzM+4CZUBtaIlza+nNeTBInFph/KgLDYiUTFeSjmr
 TkRUvwJtJfg6+wmFBc9QQiTTVBWRdxkYnUNY1Xa5VAE2Hqy4h6FZesC6dgMtII/+5uFJ0x0oF
 lfl6OVOBt6G33LMuZGaEYdt/TsIjFEHmZFKvTn7flY0l3dvLmIvORL+KeZYCgm27YSR/h8qoS
 SgqQpQZQA5tmirGSXJljLt0XJYeMV3ODiRD7ivdTyq2E90bgH1D3O1EJpOmosedgT9Z6Zqj+7
 4fz2zg4pmgY/FZ7/arkQSbUZ166kf+l+s3i2vBohl5XQWgCWZO4TaTMeqHeyic2azy8Tu84/2
 psfioQlns/1199GcAZq4/ctFKgT7yjxb9mvcmhKkQKAJOSASguY49YIUYOshzl1neplk5VYy2
 334WfQkna8gJwW0w9dt2nqvYmKJaKhlSmSlkKE1BRx10v3725zXe/M0E33Pxo92ZeyxBYDSY8
 ZK+GQ8lhEM0UAHEf0tVO0UF0rFH3/Mt5yLZwKcXT0v+/+I3cXa2Y75dSmaGd3nOoaLxKnal/E
 xSNK7f3wFUnXsbD3/+vWwhWcEXVLfzpN4Gf3VwFIDH1wlTk6bPtvlPPySJZ9kcwqZTYvNrgzw
 wIieP9RUj8Y9CcXq6fzqqV6EICjd2IMPZUIOJoLjoYrFbntQE19ICHBFljChsrlX+Aq2sHPHB
 FRWTSy2EPNcVF7/cDo/LcsagirMJodMmICk4pGW1o8oTh55xOJao6Aivw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/5/26 =E4=B8=8B=E5=8D=882:09, Baptiste Lepers wrote:
> Fix a misplaced barrier in reloc_root_is_dead. The
> BTRFS_ROOT_DEAD_RELOC_TREE bit should be checked before accessing
> reloc_root.
>
> The fix forces the order documented in the original commit:
> "In the cross section C-D, either caller gets the DEAD bit set, avoiding
> access reloc_root no matter if it's safe or not.  Or caller get the DEAD
> bit cleared, then access reloc_root, which is already NULL, nothing will
> be wrong."
>
> static bool reloc_root_is_dead()
>      smp_rmb(); <--- misplaced
>      if (test_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state))
>            return true;
>      return false;
> }

Exactly what I originally purposed to David, we didn't reach an
agreement on where the barrier should be.

At least I'm completely fine with this patch.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
>
> static bool have_reloc_root(struct btrfs_root *root)
> {
>         if (reloc_root_is_dead(root))
>                 return false;
>         <--- the barrier should happen here
>         if (!root->reloc_root)
>                 return false;
>         return true;
> }
>
> Fixes: 6282675e6708e ("btrfs: relocation: fix reloc_root lifespan and ac=
cess")
> Signed-off-by: Baptiste Lepers <baptiste.lepers@gmail.com>
> ---
>   fs/btrfs/relocation.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index b70be2ac2e9e..8cddcce56bf4 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -289,15 +289,14 @@ static int update_backref_cache(struct btrfs_trans=
_handle *trans,
>
>   static bool reloc_root_is_dead(struct btrfs_root *root)
>   {
> +	bool is_dead =3D test_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state);
>   	/*
>   	 * Pair with set_bit/clear_bit in clean_dirty_subvols and
>   	 * btrfs_update_reloc_root. We need to see the updated bit before
>   	 * trying to access reloc_root
>   	 */
>   	smp_rmb();
> -	if (test_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state))
> -		return true;
> -	return false;
> +	return is_dead;
>   }
>
>   /*
>
