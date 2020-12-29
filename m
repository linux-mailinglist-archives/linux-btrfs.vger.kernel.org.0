Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A571D2E6FFC
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Dec 2020 12:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbgL2LcA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Dec 2020 06:32:00 -0500
Received: from mout.gmx.net ([212.227.15.19]:35753 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbgL2Lb7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Dec 2020 06:31:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1609241421;
        bh=ppTBVVbI7tfpFqmWEsu3kayhgpVBdAvFYq8JE8qZCzE=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=QT5eb26eird0w66cOHqk4ivCavnYFMy4wbGu/5DnRW7kcUaUxYE9i6PKvzGBevA/z
         gj46/U8WCTadtoCY8oQ/kbWf+6hJRUIaBkow9KkQOLevF2BCEfwJX7G7jtQ5tXPlFD
         CINHyrUX8ddbYnyT+gtyovg2TMqcE1YMWFzs4DNg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MbRfv-1kIgWj3brt-00bra7; Tue, 29
 Dec 2020 12:30:21 +0100
Subject: Re: [PATCH] btrfs: relocation: output warning message for leftover v1
 space cache before aborting current data balance
To:     =?UTF-8?Q?St=c3=a9phane_Lesimple?= <stephane_btrfs2@lesimple.fr>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <90cf0737-6d33-94d8-9607-0f9c371c82aa@gmx.com>
 <20201229003837.16074-1-wqu@suse.com>
 <6b4afae37ba5979f25bddabd876a7dc5@lesimple.fr>
 <4f838a67672053e268ffce77ea800a8a@lesimple.fr>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <82e6288d-7b37-5797-13d9-f786afb33f5d@gmx.com>
Date:   Tue, 29 Dec 2020 19:30:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <4f838a67672053e268ffce77ea800a8a@lesimple.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KxH3O4Y/d745iX0F5aLCraIR+pbs/kZfllMa/dqcMCeLWQYlZZY
 DKoO6LZrNBK5aFxdADwMVf0NJrpC7ZEOfRPei0QbXHXSBXA96Aa7sOa8Tdk9tqJvmYeCOuk
 UR+6lcumK/eHR3SP8togmYP69R2PzwuEPLsbj2otyuVOpH12lPa+1MRg/fxKugYkPL0o4Re
 kxIqG/Wovg1yUTrAP7Q6A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:l+KCSBao7GE=:QMSYW53TJSMR6MaTwHyqC+
 LJgow/u4J0oI+FXiiQvoOOP+3YIcWO5CklpB6P4yd60rW0tg4H3IZefh1o/3UoFuNDaqcQ26Q
 badNRKP37suz7n7ALhv9IsXf1fLT/TE9AClt4bcseD4s34BkIJ7ta1yveEEJAp6X6E48R4Xh1
 kDUb4Jy5O5/LwZ4aw4G+yz56uhTeHrRxAOaVva6xV8JMMq23kWHlx/H/B4QaSuaX5ZGfpS6wj
 dy20nLQv4APvDTIS5rihOO0B45ctrqV07lwnxwK+7JHLjzFL69b69n78Y+XKQqM+p6+wiYrIJ
 Fz3s+J9fjDZkSF0pnRFm9Pyr5YNk7MO5Qv585U0dMA385h0WGYj6a25y8MrOkH+/xGw7JLA5f
 buCfHPugBf1n9FKu1Rz9H4oQZgIHlYO/dxIYV5Es63PLa0uyp8EqyDnDcEbL2Y1owZsllVhhV
 FBPJsrrytCTygOb/md6Co0nUIiIIigJS+TqAD2PsO/sImozG8bRjC3jNX2JQ3Xaa7/tSE52Zb
 pDWiEJMLoZ9SScStGUVq8fGGryDZFeq09JfR8B6GtsDIBzw9kiFhgTwlGyv1A82LkcdRUsBaI
 9ZtaN9CmjwKKsDHDCe5kMZnqlPj8ibPT5lxOXlW9tw/u/w5VE4tciQmNwvgZVH32bwJ7+1DvM
 NJilCpS3HUEG+1RYjjeDzirt0yBTslOlYZBslV5s9wfeIQTPIgOzN3upqlB5uS9ZDHVtDrqCP
 mAhNpt8/QwXtVRMf5bVGkJXOgX3FmtPkq43r1vayqVOSvZS2dRqMEEKk4CJHvwAN6Whp7/rZ5
 Z+spJ5Cd1CW/nn34MA/ahb+ZExvY80w5nNNzIPE3unI7K/59B9ClL7Vil3WMJHyfoM1YBJ2yB
 p99yIxIG3WJscmoIDg0Q==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/12/29 =E4=B8=8B=E5=8D=887:08, St=C3=A9phane Lesimple wrote:
> December 29, 2020 11:31 AM, "Qu Wenruo" <quwenruo.btrfs@gmx.com> wrote:
>
>>> # btrfs ins dump-tree -t root /dev/mapper/luks-tank-mdata | grep EXTEN=
T_DA
>>> item 27 key (51933 EXTENT_DATA 0) itemoff 9854 itemsize 53
>>> item 12 key (72271 EXTENT_DATA 0) itemoff 14310 itemsize 53
>>> item 25 key (74907 EXTENT_DATA 0) itemoff 12230 itemsize 53
>>
>> Mind to dump all those related inodes?
>>
>> E.g:
>>
>> $ btrfs ins dump-tree -t root <dev> | gerp 51933 -C 10
>
> Sure. I added -w to avoid grepping big numbers just containing the digit=
s 51933:
>
> # btrfs ins dump-tree -t root /dev/mapper/luks-tank-mdata | grep 51933 -=
C 10 -w
>                  generation 2614632 root_dirid 256 bytenr 42705449811968=
 level 2 refs 1
>                  lastsnap 2614456 byte_limit 0 bytes_used 101154816 flag=
s 0x1(RDONLY)
>                  uuid 1100ff6c-45fa-824d-ad93-869c94a87c7b
>                  parent_uuid 8bb8a884-ea4f-d743-8b0c-b6fdecbc397c
>                  ctransid 1337630 otransid 1249372 stransid 0 rtransid 0
>                  ctime 1554266422.693480985 (2019-04-03 06:40:22)
>                  otime 1547877605.465117667 (2019-01-19 07:00:05)
>                  drop key (0 UNKNOWN.0 0) level 0
>          item 25 key (51098 ROOT_BACKREF 5) itemoff 10067 itemsize 42
>                  root backref key dirid 534 sequence 22219 name 20190119=
_070006_hourly.7
>          item 26 key (51933 INODE_ITEM 0) itemoff 9907 itemsize 160
>                  generation 0 transid 1517381 size 262144 nbytes 3055340=
7488
>                  block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
>                  sequence 116552 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRE=
SS|PREALLOC)
>                  atime 0.0 (1970-01-01 01:00:00)
>                  ctime 1567904822.739884119 (2019-09-08 03:07:02)
>                  mtime 0.0 (1970-01-01 01:00:00)
>                  otime 0.0 (1970-01-01 01:00:00)
>          item 27 key (51933 EXTENT_DATA 0) itemoff 9854 itemsize 53
>                  generation 1517381 type 2 (prealloc)
>                  prealloc data disk byte 34626327621632 nr 262144
>                  prealloc data offset 0 nr 262144
>          item 28 key (52262 ROOT_ITEM 0) itemoff 9415 itemsize 439
>                  generation 2618893 root_dirid 256 bytenr 42677048360960=
 level 3 refs 1
>                  lastsnap 2618893 byte_limit 0 bytes_used 5557338112 fla=
gs 0x0(none)
>                  uuid d0d4361f-d231-6d40-8901-fe506e4b2b53
>                  ctransid 2618893 otransid 1277275 stransid 0 rtransid 0
>                  ctime 1609211576.181355141 (2020-12-29 04:12:56)
>                  otime 1550343531.349394412 (2019-02-16 19:58:51)
>
>> The point here is to show if we have INODE_ITEM here for the inode numb=
er.
>
> I think we do, if I understand the output correctly!
>
>> Although above ins dump should work, I just want to be extra sure about
>> where the -ENOENT comes from.
>>
>> Would you mind to test the following debug output?
>
> Here you go:
>
> [  438.260483] BTRFS info (device dm-10): balance: start -dvrange=3D3462=
5344765952..34625344765953
> [  438.269018] BTRFS info (device dm-10): relocating block group 3462534=
4765952 flags data|raid1
> [  450.439609] BTRFS info (device dm-10): found 167 extents, stage: move=
 data extents
> [  451.026349] delete_v1_space_cache: no FILE_EXTENT found, leaf start=
=3D42676709441536 data_bytenr=3D34626327621632

This means the leaf returned by find_all_leafs() is not correct?!

Would you please try this one? (Need to clean up previous diff first):
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 19b7db8b2117..c4baffa78c0b 100644
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
@@ -2986,8 +2988,12 @@ static int delete_v1_space_cache(struct
extent_buffer *leaf,
                         break;
                 }
         }
-       if (!found)
+       if (!found) {
+               pr_info("%s: no FILE_EXTENT found, leaf start=3D%llu
data_bytenr=3D%llu\n",
+                       __func__, leaf->start, data_bytenr);
+               btrfs_print_leaf(leaf);
                 return -ENOENT;
+       }
         ret =3D delete_block_group_cache(leaf->fs_info, block_group, NULL=
,
                                         space_cache_ino);
         return ret;

Thanks,
Qu
> [  451.026353] BTRFS warning (device dm-10): leftover v1 space cache fou=
nd, please use btrfs-check --clear-space-cache v1 to clean it up
> [  463.501781] BTRFS info (device dm-10): balance: ended with status: -2
>
> Regards,
>
> St=C3=A9phane.
>
