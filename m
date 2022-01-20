Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56B73495710
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jan 2022 00:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348239AbiATXj6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jan 2022 18:39:58 -0500
Received: from mout.gmx.net ([212.227.15.19]:34531 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244889AbiATXj4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jan 2022 18:39:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1642721989;
        bh=s9GlERPYxzWXO964NUpP+PkshFNOEnWFcHgKs5JeC1Y=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=Na/SUuHqaXm0k27W1KUl9b2kVmHaBQQ21dsKQ8AAa+ZVYGg6Ix0tNTKZpN5x9/sB8
         FIuHYtUDDdsy3JqZvJAp9/ntY2nuejsF4bfOMdI9qrGaMpGUYmzYStGyY0A9FG8sHQ
         W4fTVgOjgJNPKs6px7ekBJOZw1h78TeS+7BLGRn8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MUGe1-1mkSut2zAJ-00RIQa; Fri, 21
 Jan 2022 00:39:49 +0100
Message-ID: <f0e65987-7673-0334-fd00-03d36b832722@gmx.com>
Date:   Fri, 21 Jan 2022 07:39:46 +0800
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
X-Provags-ID: V03:K1:kQWEBxAzDfk+2xIKTLBlOdOn3+xOYAG1BJXM5LohTZye8Q/72WZ
 s34owJUz1eAqm0FSdANdaC2DMiVdG5vFZN2Z5NbF37I5i7TmQMIvMX1+X5JTST2auwUlHio
 2HLBQYQcQvkIkOLCGlZ6zsseK+OS07KRlVfPNLSAFdAMQamrx9IXOx8bNWTGZ2mEnWNfYyr
 ZJ3tluf8dKh1jio2ElFwg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Q2R3Nyg5I94=:TkA0U6JYkjZYXCNztI2HmP
 YU4/M4QNk6BqWOj+GIbMOlZI7E90Lwd+sKH3U4HNSRC4xsbqO4o/D4M8efx1bu1ZKjlu7oU0x
 rBBmIhpZBDdflZug7t8Z6qmiCbA24up64P/ZYlbbL6HTLCKuOPA8qlhwHSVYP23OjT3V5lESS
 j0rCtMqKhsTvsp0GPcksh42DpZ5F9V0iYL3wbu172pyI0SrQQm4m54XsElLcj+KmHbvjKg8sC
 zC7ccjrMQZK+RqWY2UkRcXshDoxZznYIbCM7ZAzlQyypiBIlPB3n4t3jGVzDkRdjHJx4rE9kg
 P6lYdgeyGgrp7mtZhpVSBvLkVH/K5/d4Z2R9HfVYDo/NpYcCl15hPEQuca9TuDtQwl5GG7+Ls
 AFgjya45zmtLxAK3utU/+wJlMBSgEjibWMWAgInxrYYYInxA78+MGVn0e5kfhRY95A0YXbmj5
 Ma5FF/FdTyQMTloblsi9Nm8//yrvxpC6Us3UcN9MI//bPkhYnUNBaf7CJSQi7E1d4EadAA7bs
 rkbYPANj6RSXHPg/gkzwePd/pCAMC5BfWclQkjzGbjHKp23SC1RH7WILt/sL5kYRLzj03Q3EU
 WZOGlGlBSzkzl0ye99bg5+JiCqKkLo1Jkq6ouu5i9WZqx9xr7AGUJlLAMsA3S5VtNJbuXCs9v
 enOxl4Xov5L7FK580Toggcf+xcD+Cn5UJoPSKBfGs9wFmgdah9k77O/fB5JoLqBGvqsWmR2jC
 pMD79/5Poeid4vqXmk/1fSZuz2YVHzrIJrbaJt3Ygalg4KAeRTF0HD64dO2OOYQGFhsk5/KTC
 cszdDFIr1AWjYjcN0tycys+ALHggmkFzj10NVeQL0iP4bTqi0QbBEVYtf6u3Aff32tljmk3Q+
 4gEbiy6yxA2tMXX9ErCFPrM7TQxPbgO11TMEdLzKDxGATnM7OoWv+x1gpZfP/pFkCotfORsDD
 2FXD9GnAN3myrZraqFjZr2MQMEplLXCew3hXM5P6BVLazAsoPClU/tM0vdEJb6TCRl/KxfH6u
 4Rzy1BlAiVjVrkvX5Veu7TykIx3Hwa/tG089GcV6L/0vhqmh0y9W/2GBBNh/jk1Uq0OiipMz/
 4yMU+iE5xrCQZM=
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

That's the part I missed.

>
> So fix this by skipping extent maps for which there's already delalloc.
>
> Fixes: eb793cf857828d ("btrfs: defrag: introduce helper to collect targe=
t file extents")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

But I have some concern over one comment below.

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

If the page is already under writeback, won't we wait for it in
defrag_one_range() by defrag_prepare_one_page() and
wait_on_page_writeback()?

Thus I think this case is not really possible here.

Thanks,
Qu

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
