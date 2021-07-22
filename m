Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC5983D2FF5
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jul 2021 00:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbhGVWLD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Jul 2021 18:11:03 -0400
Received: from mout.gmx.net ([212.227.17.22]:43865 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231596AbhGVWLC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Jul 2021 18:11:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626994295;
        bh=CQ4AOLjwX9L6dmur0EozxiMIVRp0TF32iYQY6CwtaWw=;
        h=X-UI-Sender-Class:To:References:From:Subject:Date:In-Reply-To;
        b=dgGxSSnA4cFxDBYPqCjCtRSmrmY5k7O6uvoLOynyDkLuJ8wQbYu1xIyeqcis/01HB
         /oTbke8BPFmAVY48QuY5o32jDSccnjJTkYEo9eh7sbNFhWMUBtrxiIB014T4dqHh+K
         Xm9ZhaZg4NMq8Q6Our9tLhQuFpFWZAv1kyjMOFk8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mqb1c-1lK7EM1ijY-00mZpI; Fri, 23
 Jul 2021 00:51:35 +0200
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20210722192955.18709-1-dsterba@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH] btrfs: allow degenerate raid0/raid10
Message-ID: <db9e2f31-73a5-0d0d-a1da-7acde6fb118e@gmx.com>
Date:   Fri, 23 Jul 2021 06:51:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210722192955.18709-1-dsterba@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sMvjN53rxfUEAZkQ3G4v/bKaco7kpJd1Wp/9kz58SggSYArbCep
 ERM9MY2js4s4/9OYjBcNYz3kp3oI01grMr6ruOOYxgZ2R+qmch60ffSCxMmre73iRnLNImn
 dxU7wb6ykizAtc9UoNAdnL1KWSkr9Jb1WP7+wsV1Dn1swbQt5SiY1j5DvOVtKNNjvZoN+TN
 s+VuXQOnO3TUyFAelH91g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:3v1uBDonOt4=:L46CqebyW13/eM2dz4zREu
 BILXNgY0JtGOegYP7cdOtvj97aN6xhRJbJYbyrgeYWFa24/IB1VWN6X2eNvu9L3+8mB2TEHDz
 LgQTiG9zO200zOed2+XwPyO7hCIVxuYmWv3tHY4kLWW4IJv0mdHtUUcE8EwU5iLVf85e/IzZ0
 1fPPyCWgxfytz+fpsqwU4zUAIxe6WzntAO2Mt+CqcnEmXzvYcq+WV7p+78bFxDAs/Um2yCMel
 RR+NLIsiUD7m81mPKptjTzqVwXxSy5XRm4YgqbITot+9nUJi1DjvM4dpb02HfsIC1w9MNN2/x
 P2GtpyV/oINtWEkkbfx80Enr2C37jL7UWr1KHJD5RLBPUbHPUHVnUp1UZEQHuWrTJ14j5TiVf
 Aa9CE1whR+teO8i4PyVqg7eSCM2wBcR2M8rwiX6VF9w0G7edF3N6JU9V8mmC8KvHv0mxwZzzD
 5EAsUIphbQdfN3rcVR8vhnWmAgGSImNvsgxxu4F5Fh/n2L15PSDrFK2KfaFLVnq5Wqa3T1TL/
 5YfddaFHc70be3XYWFaBR/KpjPcolTsYWsXCkMJQj9Zsl5ye7hBkR6VGzO1DYJg3eBIHM3bjz
 lc9cfIcpyncbOV3YempulKKpth3dkVmkVM4IgOrqqeXZpNyzIMa88/gXkaqGpdcd3d5UFACcY
 PPBQi4JNS9R1glT9XqjAs6Zj17m+8dgzXclnA7x0VMG4AvzbSFpckzitgkpx8A6XPHoPp98Ya
 nhuqwGnTbtT202m12mKUNK3bTFXBmCy3QSKtD+S4Fm09yL0K6uEAtwkNHCzBu4PjY3vEXW6LS
 akFLE+8Fm5V5JpGg6ICFupctL78pI14saursLGTWpVH6N8bmciRWgwwt6XAMn62RODOQeg8e5
 Uc+oF/LKpeLFVNHJpRwu/f01lKdHLfPpYxSkuLI05GkSGe8jgLn3VH6Xdk/y3o+2ZNTfNF/Y0
 y2UwPTiNBMgMK7VE1UIDhLgnydikDi/goRvpg03LLQ3+eajuRvUbbJjkf/F9djNNiV5swhRDB
 AoAnlq709hsWV98TD/n0XiKERBIG9atnvIiyYiKw1vnJDBBK8uYcPrBBqEe3q1jlTKbrNGhnk
 x0Sd6Vhm0y/wjT3NatwkGWVDW/rEDnKqRiY5WoDMHtzlJe2V3hD93vzQQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/23 =E4=B8=8A=E5=8D=883:29, David Sterba wrote:
> The data on raid0 and raid10 are supposed to be spread over multiple
> devices, so the minimum constraints are set to 2 and 4 respectively.
> This is an artificial limit and there's some interest to remove it.

This could be a better way to solve the SINGLE chunk created by degraded
mount.

>
> Change this to allow raid0 on one device and raid10 on two devices. This
> works as expected eg. when converting or removing devices.
>
> The only difference is when raid0 on two devices gets one device
> removed. Unpatched would silently create a single profile, while newly
> it would be raid0.
>
> The motivation is to allow to preserve the profile type as long as it
> possible for some intermediate state (device removal, conversion).
>
> Unpatched kernel will mount and use the degenerate profiles just fine
> but won't allow any operation that would not satisfy the stricter device
> number constraints, eg. not allowing to go from 3 to 2 devices for
> raid10 or various profile conversions.

My initial thought is, tree-checker will report errors like crazy, but
no, the check for RAID1 only cares substripe, while for RAID0 no number
of devices check.

So a good surprise here.


Another thing is about the single device RAID0 or 2 devices RAID10 is
the stripe splitting.

Single device RAID0 is just SINGLE, while 2 devices RAID10 is just RAID1.
Thus they need no stripe splitting at all.

But we will still do the stripe calculation, thus it could slightly
reduce the performance.
Not a big deal though.

>
> Example output:
>
>    # btrfs fi us -T .
>    Overall:
>        Device size:                  10.00GiB
>        Device allocated:              1.01GiB
>        Device unallocated:            8.99GiB
>        Device missing:                  0.00B
>        Used:                        200.61MiB
>        Free (estimated):              9.79GiB      (min: 9.79GiB)
>        Free (statfs, df):             9.79GiB
>        Data ratio:                       1.00
>        Metadata ratio:                   1.00
>        Global reserve:                3.25MiB      (used: 0.00B)
>        Multiple profiles:                  no
>
> 		Data      Metadata  System
>    Id Path       RAID0     single    single   Unallocated
>    -- ---------- --------- --------- -------- -----------
>     1 /dev/sda10   1.00GiB   8.00MiB  1.00MiB     8.99GiB
>    -- ---------- --------- --------- -------- -----------
>       Total        1.00GiB   8.00MiB  1.00MiB     8.99GiB
>       Used       200.25MiB 352.00KiB 16.00KiB
>
>    # btrfs dev us .
>    /dev/sda10, ID: 1
>       Device size:            10.00GiB
>       Device slack:              0.00B
>       Data,RAID0/1:            1.00GiB

Can we slightly enhance the output?
RAID0/1 really looks like a new profile now, even the "1" really means
the number of device.

>       Metadata,single:         8.00MiB
>       System,single:           1.00MiB
>       Unallocated:             8.99GiB
>
> Note "Data,RAID0/1", with btrfs-progs 5.13+ the number of devices per
> profile is printed.
>
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/volumes.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 86846d6e58d0..ad943357072b 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -38,7 +38,7 @@ const struct btrfs_raid_attr btrfs_raid_array[BTRFS_NR=
_RAID_TYPES] =3D {
>   		.sub_stripes	=3D 2,
>   		.dev_stripes	=3D 1,
>   		.devs_max	=3D 0,	/* 0 =3D=3D as many as possible */
> -		.devs_min	=3D 4,
> +		.devs_min	=3D 2,
>   		.tolerated_failures =3D 1,
>   		.devs_increment	=3D 2,
>   		.ncopies	=3D 2,
> @@ -103,7 +103,7 @@ const struct btrfs_raid_attr btrfs_raid_array[BTRFS_=
NR_RAID_TYPES] =3D {
>   		.sub_stripes	=3D 1,
>   		.dev_stripes	=3D 1,
>   		.devs_max	=3D 0,
> -		.devs_min	=3D 2,
> +		.devs_min	=3D 1,
>   		.tolerated_failures =3D 0,
>   		.devs_increment	=3D 1,
>   		.ncopies	=3D 1,
>
