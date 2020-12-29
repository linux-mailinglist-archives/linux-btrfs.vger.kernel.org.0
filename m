Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63A3E2E6FA9
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Dec 2020 11:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgL2Kav (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Dec 2020 05:30:51 -0500
Received: from mout.gmx.net ([212.227.17.20]:42861 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726156AbgL2Kav (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Dec 2020 05:30:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1609237755;
        bh=F6wYGGY6WiIYiv9g1B+tkkuMJdyzKt6/HOT/cz+S3iY=;
        h=X-UI-Sender-Class:To:References:From:Subject:Date:In-Reply-To;
        b=DD8gonuY4TBTGXnuLf9GEVW1Z/HhN6wtqj7PGy2f76jSTXS+1wYXPZf+gfG7T0Hz4
         x1wg0mlVOjqdtlz5Z/4ZnfhaDqJFZG9IW2jDxnntON7zgyuhcwTeZmdvSatoNVeEoh
         6MHRdNKHjOqMxNAbp8LNRGuZeLdV0+95B1PiLq8E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M3DJl-1kspL52m9l-003bQy; Tue, 29
 Dec 2020 11:29:15 +0100
To:     =?UTF-8?Q?St=c3=a9phane_Lesimple?= <stephane_btrfs2@lesimple.fr>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20201229003837.16074-1-wqu@suse.com>
 <6b4afae37ba5979f25bddabd876a7dc5@lesimple.fr>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH] btrfs: relocation: output warning message for leftover v1
 space cache before aborting current data balance
Message-ID: <90cf0737-6d33-94d8-9607-0f9c371c82aa@gmx.com>
Date:   Tue, 29 Dec 2020 18:29:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <6b4afae37ba5979f25bddabd876a7dc5@lesimple.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gURp05QQ6lJUuRDPGihi88Ns2VGJXWgSYg/pcEAeA52VEthBT1T
 rrL2fOgDE2Gu0YjWxUMxY7fwm/gfklfItBF9QCvZX6Zdlq40oCMmj6j65zvSbS5hs71v+oD
 U5VWfNZIm2XfbxdkJS6BNpmQOpA9v021XD6EF1sZUTxsLIz6ZakJLInRU4XZdDk9zSlZNAt
 sSAGIojuQFLQ4YKkJcmwQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Yt4lQ5/eEwE=:y1dXWMWx7ErLLeBSHK2L+6
 CAU/AUmVESw32M+7BB/821nPltGCe0LTuMZu3LK15PbqnRu63Cs2+qisCQmw2q0GnYw07GIUl
 B4/bgZtNscL0n4/KNdpt7X+Rn9DkSoiCY1x1k0yrApz7UjcUcjgZVCRHTVQP2QGCi7wl6Z01n
 0DP+2AVkleZUc6vgUPcByCyKS7gqZhAtuHvMXm3j1J+Hnxr79Jfs4I1yydO2g4HDStL/Gtk0F
 9+Hcw+zVISZfy+e6EWsnQVZWfKbqCMDYX7rz4IBbTslXCPoWVcrS+tJwzrFB8kBoxobA6C/zw
 foJrlSYTRAqKXVaeYO9XIQtZ55usfjoe8/EB1XkJzkVgUGLostzrBAJgKXmtk+JRxKoWmDELT
 fohsLP7+d7Nuj/AGLcv+L6ureaud/ckPSBZqgJJHsoyi6LpMrwiUIHbtCE26XjS3n84KDR49V
 l5EXozLPcH7oWo6y6vibu8KkERqGkRPbNzvJ6SbfgB39Fw+inePAILZ0leeeQOGCe5frfBuOV
 aqwKV+GsK/xLW3Obowf4McvVIMBTicI4tsWHBMUsJwDTGaEy9nBUDww27cogTC/3WePTRIa4G
 jzZoPnJGRnegbaFl5FopamFe/kcfPgArOq+9msqH0vpK3FAYYJEtL6KM3sIQzICkDt6eok4sI
 WlnhIagUIBc2HVksvuQjICOOsdDQi3L9pX8PXLO636hS/ClwZj1xwMxKRfDafz6xp6Q4hYd8I
 AEcrxig2o5wjd+GCrBBKUHob+7TXpat3lYz8A/4XDrz2vXfE8XXQTNI4AS3wm45Rh2uJr5pOE
 iCL5C6Q97AefhiOcj3ZpTyNmc8JrtadsMrOwl32YUzQ3Jz/T40cavGkoIx8XbLiM5xwKvAHrB
 lTRSgwu0bH2zba3Igp8A==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/12/29 =E4=B8=8B=E5=8D=885:27, St=C3=A9phane Lesimple wrote:
> December 29, 2020 1:38 AM, "Qu Wenruo" <wqu@suse.com> wrote:
>
>> In delete_v1_space_cache(), if we find a leaf whose owner is tree root,
>> and we can't grab the free space cache inode, then we return -ENOENT.
>>
>> However this would make the caller, add_data_references(), to consider
>> this as a critical error, and abort current data balance.
>>
>> This happens for fs using free space cache v2, while still has v1 data
>> left.
>>
>> For v2 free space cache, we no longer load v1 data, making btrfs_igrab(=
)
>> no longer work for root tree to grab v1 free space cache inodes.
>>
>> The proper fix for the problem is to delete v1 space cache completely
>> during v2 convert.
>>
>> We can't just ignore the -ENOENT error, as for root tree we don't use
>> reloc tree to replace its data references, but rely on COW.
>> This means, we have no way to relocate the leftover v1 data, and block
>> the relocation.
>>
>> This patch will just workaround it by outputting a warning message,
>> showing the user how to manually solve it.
>>
>> Reported-by: St=C3=A9phane Lesimple <stephane_btrfs2@lesimple.fr>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>
> Your analysis seems correct, as this FS is quite old (several years),
> and has seen quite a number of kernel versions! I converted it to
> space_cache v2 ~6-12 months ago I think. It does has v1 leftovers:
>
> # btrfs ins dump-tree -t root /dev/mapper/luks-tank-mdata | grep EXTENT_=
DA
> item 27 key (51933 EXTENT_DATA 0) itemoff 9854 itemsize 53
> item 12 key (72271 EXTENT_DATA 0) itemoff 14310 itemsize 53
> item 25 key (74907 EXTENT_DATA 0) itemoff 12230 itemsize 53

Mind to dump all those related inodes?

E.g:

$ btrfs ins dump-tree -t root <dev> | gerp 51933 -C 10

The point here is to show if we have INODE_ITEM here for the inode number.

If there is really no INODE_ITEM, but have EXTENT_DATA left, then there
is something wrong with the v1 cache deletion.
That would explain the problem you're hitting.

Either caused by kernel or btrfs-progs, we need to further pin down the
cause of course.
For any reason, this should be considered as a corruption, which is
pretty dangerous (deleting inode item without deleting all its content,
definitely a big NO-NO).

>
> What's interesting also is that a FS I created only a few weeks ago,
> under kernel 5.6.17, also has v1 leftovers, as per the above command.
> So the issue might be more common than we think (not just years-old FS).
>
> Before fixing the FS I can't balance, I wanted to test your patch,
> even if it's pretty straightforward, just to be sure:
>
> # btrfs bal start -dvrange=3D34625344765952..34625344765953 /tank
> ERROR: error during balancing '/tank': No such file or directory
> There may be more info in syslog - try dmesg | tail
>
> [   76.114187] BTRFS info (device dm-10): balance: start -dvrange=3D3462=
5344765952..34625344765953
> [   76.122792] BTRFS info (device dm-10): relocating block group 3462534=
4765952 flags data|raid1
> [   87.065468] BTRFS info (device dm-10): found 167 extents, stage: move=
 data extents
> [   87.685571] BTRFS warning (device dm-10): leftover v1 space cache fou=
nd, please use btrfs-check --clear-space-cache v1 to clean it up

Although above ins dump should work, I just want to be extra sure about
where the -ENOENT comes from.

Would you mind to test the following debug output?

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 19b7db8b2117..f7f3682ce017 100644
=2D-- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2932,8 +2932,10 @@ static int delete_block_group_cache(struct
btrfs_fs_info *fs_info,
                 goto truncate;

         inode =3D btrfs_iget(fs_info->sb, ino, root);
-       if (IS_ERR(inode))
+       if (IS_ERR(inode)) {
+               pr_info("%s: no inode item found for ino %llu\n",
__func__, ino);
                 return -ENOENT;
+       }

  truncate:
         ret =3D btrfs_check_trunc_cache_free_space(fs_info,
@@ -2986,8 +2988,11 @@ static int delete_v1_space_cache(struct
extent_buffer *leaf,
                         break;
                 }
         }
-       if (!found)
+       if (!found) {
+               pr_info("%s: no FILE_EXTENT found, leaf start=3D%llu
data_bytenr=3D%llu\n",
+                       __func__, leaf->start, data_bytenr);
                 return -ENOENT;
+       }
         ret =3D delete_block_group_cache(leaf->fs_info, block_group, NULL=
,
                                         space_cache_ino);
         return ret;


My guess is, the dump would show no INODE_ITEM, and the debug output
would print something like "delete_block_group_cache: no inode item
found for XXXXXX".

Thanks,
Qu
> [  100.018692] BTRFS info (device dm-10): balance: ended with status: -2
>
> So, it works. You can add my Tested-By.
>
> Regards,
>
> St=C3=A9phane.
>
