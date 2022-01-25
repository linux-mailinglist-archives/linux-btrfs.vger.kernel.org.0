Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6BDC49B0C9
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jan 2022 11:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233967AbiAYJqi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Jan 2022 04:46:38 -0500
Received: from mout.gmx.net ([212.227.17.22]:56793 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236927AbiAYJoZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Jan 2022 04:44:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643103857;
        bh=HzVBUjr3Th4118DtBy5yODKHMrBTUimbhNuIR/ISfgs=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=FGcxmwUzrQW5uxyyffMrMuC7zT6g5c+ieDpQoBSY2yAneq7hPRF3t4Yk6vkR+2f+0
         TyWpG2Xqk3j/UlbDzRxko2ykri3LpphZFeuCrIMxa3X0n2GR+N/cN+5Kj0vGCl2CZi
         zvlKcIYYD2myBBwzyacGClaFuZfZWlQUslnD3XnU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MvK0X-1mL1EH0j8T-00rJ9j; Tue, 25
 Jan 2022 10:44:16 +0100
Message-ID: <9de78ba3-90e4-6408-98a2-766aaa10ecb1@gmx.com>
Date:   Tue, 25 Jan 2022 17:44:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] btrfs: fix deadlock when reserving space during defrag
Content-Language: en-US
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <5cb3ce140c84b0283be685bae8a5d75d5d19af08.1642688018.git.fdmanana@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <5cb3ce140c84b0283be685bae8a5d75d5d19af08.1642688018.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WUe8eYEbFbj2gx+h7297YjXicj5LmM83x29bAkSXRWc/4aGuNz8
 Es36fKGgae0lIpjscKx4J3Z768GJOpoa+XX8OhxM8gCypFkzxT7/g8AgWI187Do4wsAzmKA
 /P+IHkP9hXh3VMH/9q8xmYdqHknecZi6UKPDb9Iq2/8JYBDExx0vFxlCuqxAoekR1tsLcmi
 1J8RiHY0zJBkX/0NGfw6w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:g+X2eyvwnuU=:fFupYeyuop6RSJ/q8U8+Fb
 tlx44cF+xlfiLBeIbWIjnHTo6gea9PZlqsAbZ/Aq6GAj8z8aouGBaBrXjGLyf5g9gKHWpp2HK
 QFinH8+hR87OZRTE6XJlaQ8EBH154WB1uFbw8xfw/6BU/SiiyvcM5J6mhEWqUaIRohorK2oon
 d2WJD0Ddi88LGr9VU6dexAomDI1DPlqlhsqWtRkChVwkLDTiIWB1eA4jm+X+vHmHU/V5fJfKs
 gaa9Z3d0ThS9CzcDx0QM5IXeMJlOiEFyImiEvggjEhNS8fAjWx9YLJmaboAJmtf/ozYFhvciq
 MCbmQbFyRIeAmC8v2bq1DDKqqhA3crIrZ16vhx3jkDdYNa4KTa0muqt3R3EoxsZLFoT7jdt2s
 qWd7dp6Xscdekt0gRPQUdf9jgAMrSgtNxdrBbEVvnL2/Je9B17h5u1SV12MD9yHlhsCGJ770n
 WgV/2IchfRZo7q6bwoG+RdO5dK1c6cSlAt/SBOu11xcgowIBr0P+eiHLeY/XqFOVEAjL2MCOm
 FHcKFBIEocKP69qcMgBFb1//YogbKwxmpTGOXc0qxrJZCNpBSmOf4YDAl0brDMDqbO2/vUJ+u
 8M/OKD1urz3FVgR1NFnaqhljdfm0WLUTkD2mFhqmgETft90pEa9CScBY+FMZJYdX/tS2Fi7Uj
 vP/qCsX6M39SPYar0g1UncDan1T50zQ57L2ZefQLXOa8smmzLIAb5T3mTlFI881DbTQnH0osI
 5feugOw5tqsjxa1/zrDBVVHSeWwuIn3EiNbNreCQlzSMteCF7PNC8s5k1GhphJF3CgEqCdJCj
 +JgwDcuFbDaSzJr8gCjgwUzhCOogAM5i4ORnbfmrPxYMtruSG2t9P5PVqGk6ROZSJ1MTReZlX
 HB0K9WbvWddxnYcAL7z/brg70IZD02UusVZUxLaM5V1uMDY8hzimXgCeNrsCAEd3qg8z+vMVM
 lBPS3bp2YG3/O5A233oWWMdvYnSNzU1Y4Lrtb3Kc5AMpqrpWQ7oISZ4qIcslbL60ou2TdO5zY
 dkxbBZc8ESY8wib5sFPMw3/admqUJ0fULGBxiA9iSPrsTIcLH9bTnUYmFdiBP9k9VWh+lNgu9
 VRbS/XbwtA6hUc=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/1/20 22:27, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>
> When defragging we can end up collecting a range for defrag that has
> already pages under delalloc (dirty), as long as the respective extent
> map for their range is not mapped to a hole, a prealloc extent or
> the extent map is from an old generation.
>
> Most of the time that is harmless from a functional perspective at
> least, however it can result in a deadlock:
>
> 1) At defrag_collect_targets() we find an extent map that meets all
>     requirements but there's delalloc for the range it covers, and we ad=
d
>     its range to list of ranges to defrag;
>
> 2) The defrag_collect_targets() function is called at defrag_one_range()=
,
>     after it locked a range that overlaps the range of the extent map;
>
> 3) At defrag_one_range(), while the range is still locked, we call
>     defrag_one_locked_target() for the range associated to the extent
>     map we collected at step 1);
>
> 4) Then finally at defrag_one_locked_target() we do a call to
>     btrfs_delalloc_reserve_space(), which will reserve data and metadata
>     space. If the space reservations can not be satisfied right away, th=
e
>     flusher might be kicked in and start flushing delalloc and wait for
>     the respective ordered extents to complete. If this happens we will
>     deadlock, because both flushing delalloc and finishing an ordered
>     extent, requires locking the range in the inode's io tree, which was
>     already locked at defrag_collect_targets().

Could it be possible that we allow btrfs_delalloc_reserve_space() to
choose the flush mode?
Like changing it to NO_FLUSH for this particular call sites?

Thanks,
Qu

>
> So fix this by skipping extent maps for which there's already delalloc.
>
> Fixes: eb793cf857828d ("btrfs: defrag: introduce helper to collect targe=
t file extents")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>   fs/btrfs/ioctl.c | 31 ++++++++++++++++++++++++++++++-
>   1 file changed, 30 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 550d8f2dfa37..0082e9a60bfc 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -1211,6 +1211,35 @@ static int defrag_collect_targets(struct btrfs_in=
ode *inode,
>   		if (em->generation < newer_than)
>   			goto next;
>
> +		/*
> +		 * Our start offset might be in the middle of an existing extent
> +		 * map, so take that into account.
> +		 */
> +		range_len =3D em->len - (cur - em->start);
> +		/*
> +		 * If this range of the extent map is already flagged for delalloc,
> +		 * skipt it, because:
> +		 *
> +		 * 1) We could deadlock later, when trying to reserve space for
> +		 *    delalloc, because in case we can't immediately reserve space
> +		 *    the flusher can start delalloc and wait for the respective
> +		 *    ordered extents to complete. The deadlock would happen
> +		 *    because we do the space reservation while holding the range
> +		 *    locked, and starting writeback, or finishing an ordered
> +		 *    extent, requires locking the range;
> +		 *
> +		 * 2) If there's delalloc there, it means there's dirty pages for
> +		 *    which writeback has not started yet (we clean the delalloc
> +		 *    flag when starting writeback and after creating an ordered
> +		 *    extent). If we mark pages in an adjacent range for defrag,
> +		 *    then we will have a larger contiguous range for delalloc,
> +		 *    very likely resulting in a larger extent after writeback is
> +		 *    triggered (except in a case of free space fragmentation).
> +		 */
> +		if (test_range_bit(&inode->io_tree, cur, cur + range_len - 1,
> +				   EXTENT_DELALLOC, 0, NULL))
> +			goto next;
> +
>   		/*
>   		 * For do_compress case, we want to compress all valid file
>   		 * extents, thus no @extent_thresh or mergeable check.
> @@ -1219,7 +1248,7 @@ static int defrag_collect_targets(struct btrfs_ino=
de *inode,
>   			goto add;
>
>   		/* Skip too large extent */
> -		if (em->len >=3D extent_thresh)
> +		if (range_len >=3D extent_thresh)
>   			goto next;
>
>   		next_mergeable =3D defrag_check_next_extent(&inode->vfs_inode, em,
