Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEE8B4A6947
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Feb 2022 01:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243403AbiBBAf4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Feb 2022 19:35:56 -0500
Received: from mout.gmx.net ([212.227.15.15]:42075 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243361AbiBBAf4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 1 Feb 2022 19:35:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643762149;
        bh=eimSaf8b7y85V8YX1T++PRvoinr24iSZfdA1tJOTB5A=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=VwFefC++LVjsdBDYUrIq7hEe+UgEY6LmLbobM4XrkeBL4kWORrGLIj06gtP/eTUFi
         A8S8BSmUGral0YRhNTlb863EN2LNL8WSIS84Xum68rbHqEaQzNtfvLvKPEMx7u6fNj
         i4z8SH21LpecEFkwtljxzkbc4VPTMypFBS9CJokw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mi2Nv-1mb1qX1KYD-00e3Lo; Wed, 02
 Feb 2022 01:35:49 +0100
Message-ID: <e67bb761-c4bf-b929-0bee-650f425248ac@gmx.com>
Date:   Wed, 2 Feb 2022 08:35:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [POC for v5.15 0/2] btrfs: defrag: what if v5.15 is doing proper
 defrag
Content-Language: en-US
To:     =?UTF-8?Q?Fran=c3=a7ois-Xavier_Thomas?= <fx.thomas@gmail.com>
Cc:     Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20220125065057.35863-1-wqu@suse.com>
 <Ye/S15/clpSOG3y6@debian9.Home>
 <791ca198-d4d0-91b3-ed9b-63cc19c78437@gmx.com>
 <92236445-440d-b1c0-bd76-b8001facd334@gmx.com>
 <CAEwRaO6xT_utSgyHuRhEK+C6Y8uvLABJw5FS=TitsMVxODo1OQ@mail.gmail.com>
 <CAEwRaO6qcxr7ArAhkL-s=yRyNxmupFSVZL_w5ffHXagPQbiAgg@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CAEwRaO6qcxr7ArAhkL-s=yRyNxmupFSVZL_w5ffHXagPQbiAgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vTnvD0pCmNbM9VsB8FdRzd9gkirTyJypjKtqJIKd6QnQUN2y9Uy
 guf0fDh2MTFWOT2GkhJosFv7ouZPbb1nRAJSW3y3fR7pteZpXATtuiJnEWoCaUYxcSGIPwE
 8JdjYgonMqa0E982fmzcqbMV+xZVzOe93VjqqjNO1eBXu9wsho5fMInkEMJW0B0zerIgYjr
 yDvye92pj4fW6Loyi8Bdg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:4OAd6C969oA=:LnwlraMfvwCKq82mA5mrnI
 yV/r8yhnOrx51Qkg5puXIFHdIlZ9p5rj2QJffbINlLdK0mZnsO9BJde/1b3WOHoOyys2N0dXh
 wjySJl7pQ22UMF6w96mwsV7zp95/KhI+Ks0FbczEKbCwnqLK7LM9mFPdqgJ+H6t3T5VwxyfuN
 bYZ0TZieRSmnrCmVMHYXLYoqLu+NxkLSCGcE1SnZ6m/8X2pfFsBdZmkDgYZAK6imZcy0ShUIo
 upV6z5O6LpYfxz1J0O7AnRKqtZxtEDX0wgtFy21LLsE0jF/GkBC8MKG3KL+svHIlA8I83ntUR
 tonNTsybqoA0KfOAUW6K5ubYz7ySfAlc7y0/WJUn2qN/k8HWhwzvfovbimlB6v47Mxz2iHklh
 Mb6xW6L/ntCDsVHdhxzEB/ehultPwS0vQ3FzBh/ljdnzDa3EqIL7/hhYjeitUyfkjknKU4bta
 VoKLyphx/irsI/lxIUc3ZPSUBnf8TuvZzqhLJDl2xmwXkA8QKnVn9UwvYjj0RHuES0b40VF1F
 d71BX6QwDNUgJfAOTKlzbq+mP24nDLwfRGCqvmORiSToH1vGLbYAiwkBhmTlkB+X0qncURoCu
 4E/vdWjW30e4wsbSzMhqeCMup/HkQIFO5/kH/Xa8LJ8zeM2VVLKUL6Tb9XJ+sEBm+nUsxtAz8
 V9q53BTivyYrrQNbigvJ02G3mfX8MgdJB8RsemdrL7qTDtkVOwFpQia+ZonS/BjrA64t2RTUs
 yxxbnhwnyTH4+SO8PsL5U9kWgGjPRi0iKy9yovsBMAL49ZLRcnoe4Y4vO8SE6goQE6EuG+EAW
 AELV/7CA1HS9iR6roXyKRTxM0ocd+YA0KzRWXKKUx3ejHxZK76uD7hYtp/x+UZ31kt//HNruY
 sev6K0DOBD2fL5FsnlTKSjbl4Bgyc658DzUK3pe7iAkTKvhdMgSjpgMHBXJf4U1xpFaKaWp9U
 l6kagB31mIgKx90jROUXjaXKgVuQ96vz94emW1gDvGVBsq9IKLZVHPYSxsWh8CIQhhJhXaVNJ
 GLTPRrTDyjNc1V0y95QzLBJcED+nDavBkFgbvWFdpo5+OyC8gV+3WS3rltzRUJ6fdpKBp1QPY
 YNlOzmpjN6AwAs/Abrdw87TvAiSFbwdF/P8qogOz///f3Swu/XqrTLe0HplPcnWpWv09jRB9m
 lsOKClpo68wUtYohTktiXWKyCb
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/2/2 05:18, Fran=C3=A7ois-Xavier Thomas wrote:
>> Sure, I'll take the last 5.15 I used (5.15.13) as a base + the 2
>> patches from this thread, is that good?
>>     1-btrfs-dont-defrag-preallocated-extents.patch
>>     2-defrag-limit-cluster-size-to-first-hole.patch
>>
>> Will post results tomorrow when it finishes compiling.
>
> Tomorrow ended up taking a week, as it happens, sorry for that. No
> significant difference compared to before:
> https://i.imgur.com/BNoxixL.png
>
> I'm not sure what we can infer from this, if I understood correctly
> this should have shown similar amounts of I/O to 5.16 with all the
> previous fixes, right?

OK, things are getting more complex now.

Unless your workload includes quite some preallocated range, it's
definitely not what I expected.

As a final struggle, mind to test the small diff (without any previous
diff) against v5.15?

Thanks,
Qu

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index cc61813213d8..bcc075ea56c9 100644
=2D-- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1528,8 +1528,6 @@ int btrfs_defrag_file(struct inode *inode, struct
file *file,
                         cluster =3D (PAGE_ALIGN(defrag_end) >>
                                    PAGE_SHIFT) - i;
                         cluster =3D min(cluster, max_cluster);
-               } else {
-                       cluster =3D max_cluster;
                 }

                 if (i + cluster > ra_index) {


>
> I pasted the full diff I used at the end of this mail, since
> `defrag_lookup_extent` changed signature between 5.15 and 5.16 I had
> to do a couple of minor changes to get it to compile on 5.15.13.
> Hopefully that was what you initially intended on testing.
>
> Thanks,
> Fran=C3=A7ois-Xavier
>
> ----
>
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index cc61813213d8..07eb7417b6e7 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -1119,19 +1119,23 @@ static struct extent_map
> *defrag_lookup_extent(struct inode *inode, u64 start)
>   static bool defrag_check_next_extent(struct inode *inode, struct
> extent_map *em)
>   {
>       struct extent_map *next;
> -    bool ret =3D true;
> +    bool ret =3D false;
>
>       /* this is the last extent */
>       if (em->start + em->len >=3D i_size_read(inode))
> -        return false;
> +        return ret;
>
>       next =3D defrag_lookup_extent(inode, em->start + em->len);
>       if (!next || next->block_start >=3D EXTENT_MAP_LAST_BYTE)
> -        ret =3D false;
> -    else if ((em->block_start + em->block_len =3D=3D next->block_start)=
 &&
> -         (em->block_len > SZ_128K && next->block_len > SZ_128K))
> -        ret =3D false;
> +        goto out;
> +    if (test_bit(EXTENT_FLAG_COMPRESSED, &next->flags))
> +        goto out;
> +    if ((em->block_start + em->block_len =3D=3D next->block_start) &&
> +     (em->block_len > SZ_128K && next->block_len > SZ_128K))
> +        goto out;
>
> +    ret =3D true;
> +out:
>       free_extent_map(next);
>       return ret;
>   }
> @@ -1403,6 +1407,30 @@ static int cluster_pages_for_defrag(struct inode =
*inode,
>
>   }
>
> +static u64 get_cluster_size(struct inode *inode, u64 start, u64 len)
> +{
> +    u64 cur =3D start;
> +    u64 cluster_len =3D 0;
> +    while (cur < start + len) {
> +        struct extent_map *em;
> +
> +        em =3D defrag_lookup_extent(inode, cur);
> +        if (!em)
> +            break;
> +        /*
> +         * Here we don't do comprehensive checks, we just
> +         * find the first hole/preallocated.
> +         */
> +        if (em->block_start >=3D EXTENT_MAP_LAST_BYTE ||
> +            test_bit(EXTENT_FLAG_PREALLOC, &em->flags))
> +            break;
> +        cluster_len +=3D min(em->start + em->len - cur, start + len - c=
ur);
> +        cur =3D min(em->start + em->len, start + len);
> +    }
> +    return cluster_len;
> +}
> +
> +
>   int btrfs_defrag_file(struct inode *inode, struct file *file,
>                 struct btrfs_ioctl_defrag_range_args *range,
>                 u64 newer_than, unsigned long max_to_defrag)
> @@ -1531,6 +1559,13 @@ int btrfs_defrag_file(struct inode *inode,
> struct file *file,
>           } else {
>               cluster =3D max_cluster;
>           }
> +        cluster =3D min_t(unsigned long,
> +                get_cluster_size(inode, i << PAGE_SHIFT,
> +                         cluster << PAGE_SHIFT)
> +                    >> PAGE_SHIFT,
> +                    cluster);
> +        if (cluster =3D=3D 0)
> +            goto next;
>
>           if (i + cluster > ra_index) {
>               ra_index =3D max(i, ra_index);
> @@ -1557,6 +1592,7 @@ int btrfs_defrag_file(struct inode *inode,
> struct file *file,
>           balance_dirty_pages_ratelimited(inode->i_mapping);
>           btrfs_inode_unlock(inode, 0);
>
> +next:
>           if (newer_than) {
>               if (newer_off =3D=3D (u64)-1)
>                   break;
