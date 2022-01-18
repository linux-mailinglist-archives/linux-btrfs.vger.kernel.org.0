Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D09E84912C6
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jan 2022 01:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237750AbiARAU2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Jan 2022 19:20:28 -0500
Received: from mout.gmx.net ([212.227.17.22]:49069 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244183AbiARATn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Jan 2022 19:19:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1642465177;
        bh=cy34XK0LWlVkYGUmDRnP1NA1YT36o3KqjWmN21DtfCs=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=FESMD9/htEcYyqHmKKOvcC4CtKkDeAyxgIkNhipOgn1JwZc79vyMGC9dz+VOFZSbP
         dG7XgHzh6pEPeuZYgz+f4Bdi3bEkqnislE2J/9bg7a/T+iNqE8y3WPkDlCHOvyAeE4
         WshzIOiMISqOA3JSR9zelwT9Ap4c2ZNzh0dT0yLw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N2Dx8-1mAoPH0Cuk-013hGp; Tue, 18
 Jan 2022 01:19:37 +0100
Message-ID: <62b979c7-c165-af31-366a-1430513cb6c9@gmx.com>
Date:   Tue, 18 Jan 2022 08:19:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] btrfs: fix too long loop when defragging a 1 byte file
Content-Language: en-US
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <bcbfce0ff7e21bbfed2484b1457e560edf78020d.1642436805.git.fdmanana@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <bcbfce0ff7e21bbfed2484b1457e560edf78020d.1642436805.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IKlPFb1DIy5v2Qe32+mSqmfhXPYv9tcnn6NEGVXsA8Dl7AMmJpe
 u8etF4YOaL0CFznhfn2F9gSdjXv9lWURXrcA3QilzQI0fPLVHZPOUvccM+RsGUvQDXi+yzU
 GGwPhEjgeu6Tj+Wh55mrQk6d76RlcarxJ/m6vDKESxwRAgT08lx9KygKumcbb6fDOugVudY
 AugdBaDuh06LcIxfI2/sA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:iHTb6M6lLLw=:6vSyUOgmO6gyjRmjD0t92G
 y/PXYahY6SogY5XsmJL1F5++mDHflFDufbhJBD5r1zJtv4vjZgoYTMf1Le+at6j59FkSk8Fsi
 K7XDdpa9JKPvvr94uQDQCyqTKOQfE97Dpkx4zHkpiaH5OyFyFp6fXyn7R4mRhP+gquz7ixmjf
 fhga5stl6IlToX4idc7/Njx1KpzCodLmabWYV8l0hY8577LUYuOr57o3k4A+lYppw0mHNPck5
 X2EbohnAp9Cp7iSAaZ7/vKyN8RRsOMsjsHz213A8RvALiWQ9HdneyFLeDy4rY52v5pMg8smmN
 2vBCIkNrZ05gm3MbzUkmRuIThPa3bX+1H8YzfBX0ZzqoXeSnjLTEkbScDl3muliotboW1scRv
 qZgYvPtzKKFW/X3x/qXA0x3ywrtSOMWc1IDnYT2w6ZZZ8F+63oRm/L/dWLNEV0QusYDzPDxlh
 ci+46rKNwD2lKyiRZQ8i0V8mFBdKbiVfeK3uZbNFpN7mN4CHFOTtvXnUbInNyPTG9TFGS2xcS
 NYN5ec09N88Fmqj80VASusjnKX5BytQs7JE4zfUiPryK960yU00yJNhvo48fTiAEqhu6sf4xM
 VLCe7guleRUZ0SzGJg2WxeVi3Hr1LpvuiAPazcQh4Amly75hAfuQu1YqN+Y13kEN5iYOwU32k
 HZdvSlO3YigGntefs38bYy9Ds4GrevGrFnWgFgyniGlCpWOT1YPkx+F5knsLZGVlM8EQKwY7D
 PbGSDCY8axRZC5lWD2DWajLQD0QXQJRDljiUJZY05Vg7+sndIHnN3RgHZQVXA3PO42gP0S6ZH
 6tWgqO3Pscgce+cVZ3h6MTji8mYd4xHPk5VX0Q8l3CtiCSXN5TakraOf0iMmQAu3K7roTce91
 hRqhH9FTpvQIApeoLrwrmr0uMNgSyKWgA62Au1OX/sYxxRAPidDFW2+JkT62TFBfTmxDyocJj
 YFIVxjcqkZgpXhhrfM1ZYNDqGzqlsyvZ5hSdKUmIP+bPjfVHbtxWiXTHmJhfche4N8CZSgkvu
 RAtb0lzQPYBIaffkYbynmd6M48MCZuO5YtpNpWXOtfhfMUg9PHsMgIwqwchVrSYpb4axsZ2BA
 GT9JDYCPUwRpcg=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/1/18 00:28, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>
> When attempting to defrag a file with a single byte, we can end up in a
> too long loop, which is nearly infinite because at btrfs_defrag_file()
> we end up with the variable last_byte assigned with a value of
> 18446744073709551615 (which is (u64)-1). The problem comes from the fact
> we end up doing:
>
>      last_byte =3D round_up(last_byte, fs_info->sectorsize) - 1;
>
> So if last_byte was assigned 0, which is i_size - 1, we underflow and
> end up with the value 18446744073709551615.
>
> This is trivial to reproduce and the following script triggers it:
>
>    $ cat test.sh
>    #!/bin/bash
>
>    DEV=3D/dev/sdj
>    MNT=3D/mnt/sdj
>
>    mkfs.btrfs -f $DEV
>    mount $DEV $MNT
>
>    echo -n "X" > $MNT/foobar
>
>    btrfs filesystem defragment $MNT/foobar
>
>    umount $MNT
>
> So fix this by not decrementing last_byte by 1 before doing the sector
> size round up. Also, to make it easier to follow, make the round up righ=
t
> after computing last_byte.
>
> Fixes: 7b508037d4cac3 ("btrfs: defrag: use defrag_one_cluster() to imple=
ment btrfs_defrag_file()")
> Reported-by: Anthony Ruhier <aruhier@mailbox.org>
> Link: https://lore.kernel.org/linux-btrfs/0a269612-e43f-da22-c5bc-b34b1b=
56ebe8@mailbox.org/
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/ioctl.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index a5bd6926f7ff..6ad2bc2e5af3 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -1518,12 +1518,16 @@ int btrfs_defrag_file(struct inode *inode, struc=
t file_ra_state *ra,
>
>   	if (range->start + range->len > range->start) {
>   		/* Got a specific range */
> -		last_byte =3D min(isize, range->start + range->len) - 1;
> +		last_byte =3D min(isize, range->start + range->len);
>   	} else {
>   		/* Defrag until file end */
> -		last_byte =3D isize - 1;
> +		last_byte =3D isize;
>   	}
>
> +	/* Align the range */
> +	cur =3D round_down(range->start, fs_info->sectorsize);
> +	last_byte =3D round_up(last_byte, fs_info->sectorsize) - 1;
> +
>   	/*
>   	 * If we were not given a ra, allocate a readahead context. As
>   	 * readahead is just an optimization, defrag will work without it so
> @@ -1536,10 +1540,6 @@ int btrfs_defrag_file(struct inode *inode, struct=
 file_ra_state *ra,
>   			file_ra_state_init(ra, inode->i_mapping);
>   	}
>
> -	/* Align the range */
> -	cur =3D round_down(range->start, fs_info->sectorsize);
> -	last_byte =3D round_up(last_byte, fs_info->sectorsize) - 1;
> -
>   	while (cur < last_byte) {
>   		u64 cluster_end;
>
