Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E351C3B4D91
	for <lists+linux-btrfs@lfdr.de>; Sat, 26 Jun 2021 10:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbhFZIIR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 26 Jun 2021 04:08:17 -0400
Received: from mout.gmx.net ([212.227.17.20]:48045 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229518AbhFZIIR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 26 Jun 2021 04:08:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1624694749;
        bh=iVyVquD5t7EvksBR/mSIbSFtSTgS56PhRRoBYbrw8+w=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=bp0xP9MFhLvZP7zG1FhhJllpFUIDPBZ8dU/QySft7eYQWyqsSz/KEk6U5DOMxU6aP
         RXPC0g1Xvx5dOuZfTfuySLYkU6F5rLXahrbE2K/fuyGzFo1xU4jso4uSew4WQRpSI7
         H7Y26Xw4mdSYieaQT/bp6+TjA0C7gRcQ/ZQ0xhHg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MmDIu-1lWYCy20ye-00iC5g; Sat, 26
 Jun 2021 10:05:49 +0200
To:     Zhenyu Wu <wuzy001@gmail.com>
Cc:     Graham Cobb <g.btrfs@cobb.uk.net>, Su Yue <l@damenly.su>,
        linux-btrfs@vger.kernel.org
References: <CAJ9tZB_kPgZCsBaoOV93G9UCabdPifUxks+RH0e6RUycJ5wMCA@mail.gmail.com>
 <5yy5orgi.fsf@damenly.su>
 <CAJ9tZB8UjSYCmvLRJ19zyKWyXD=Qp1Am0mFPc=dY8QRgMxcPiA@mail.gmail.com>
 <900f5c2c-9058-54d4-bdc8-a32c37dd8bdc@gmx.com>
 <93eeea80-a5af-fc14-ec71-e111d801eff4@gmx.com>
 <CAJ9tZB8Y+yNoTQmEjuV3f9QL05+=abJ-Ue4m7iRkxAC0NDhTFw@mail.gmail.com>
 <3670289c-19fb-482f-d2ca-3c84eb5decbe@cobb.uk.net>
 <CAJ9tZB-7ogKcPCF=r72jJ3pvZLD3h6VfQbks-pfkB5N_yhJzTg@mail.gmail.com>
 <93bc4428-467f-9a08-0dbf-1fae8cec42dd@gmx.com>
 <CAJ9tZB9Zpnmkg-QTcVCHYKt8e5w4fBseZkJPGUT4wrH2zHokTg@mail.gmail.com>
 <c14fd9c7-3d4c-0498-de76-56025fe2f37b@gmx.com>
 <CAJ9tZB_35KKsBjXQ+qiDPv=2ffpsJnUH8JaBvp5MP3gUwVXK-A@mail.gmail.com>
 <e3df9e2f-7ae6-c3cd-766f-c881f965846b@gmx.com>
 <f139fbe5-1ac2-54b9-c57b-2c93724cd2e2@gmx.com>
 <265bee57-2d24-9415-fcfc-f0ddcee68eda@gmx.com>
 <65c221d1-86cf-1084-4d6c-bdfe717c494a@gmx.com>
 <CAJ9tZB8yMRgL6RjTCR9X4Mb_XKAkuLMnGaW4nnrj-y2XMKoapA@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [question] free space of disk with btrfs is too different from
 other du
Message-ID: <78cbf538-19ba-6fce-4bc3-aadff4e3ce7c@gmx.com>
Date:   Sat, 26 Jun 2021 16:05:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAJ9tZB8yMRgL6RjTCR9X4Mb_XKAkuLMnGaW4nnrj-y2XMKoapA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6P+RElU47yRDI2HivV4A6yKE8xwnHPBr9eu20Yhg+4yTHiswD30
 445zgngFaERcr4+N03EnljUwiCtNMewxzUaFrLxcM5DQK9MNdEbm4LQaQBgUhYkDFumNuXP
 b9q05oH+xVnwWXDyLZeYncrCjVFGLKh1/wSG+vfAqEQW6DBx5e/b7T424mXn/Ln1T/0h7Re
 oQlq0egifV2gcV3Dx9LtA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:OmrRIgSr4u0=:V4H7j5Yqw2+pgavnlTdCXx
 6g1iQrbAVvpGcTnpTDSbtQCW/qt0k9WmLWnktZmtdxo5aP+oJzrzoYS7ajvWzNoqELmuPkcS4
 3EaeSRWdq44eCJ+Tjp2SY6NKczWMPyxEWmGV46fBBZyJZbdVE/GekKo5nDcnbIAknRjIIA77X
 FhVbPay+8hPKr4pxX0H4XXfTSeKuBEDl0hX3ploqmDrEAo+M4jPsZc3+z2UsacKsqtWfcQMml
 L2viUwQQMKkrjDuY64z8r++0S4pxOzj0wEITuCgLktlZLOLcByP3F7eB2wiGftGvgCqz+0kwV
 gp7l0o82l0C9jDW/GBqBEdhFC4BTn59j4YRuneB80q1sjb3NpROYWPKdCgDzayIcxbX6swsZz
 75re3Y/fw7kM7lhsy6kf3rgCNo5/hCflwQpU3uqLH/u5NBahFU4Al2Sjo0TlSgQx0Ixjrmo7F
 XWnLBDNcdd4G4ee2UypbUiDnT69A8CDCo47pkitp6No8D1reMx9SPMkfB67WMf2KbL39SYDA/
 McwcCWs/WhiYjcoQ1Zz+e9sXqY2lemrBpFNyVuo3egUlmCW9dF8ax9RnJu7n3/HE3dYdFF4VB
 PlIJHVglYsZVqy/c2eey2YculMe+5t3f9zYfb8SDNbw+p2ZzPENF639P2IYus5qLg3GSUsUv9
 rmhgGFnzrx5RHyUZUhOGeGZXGICVsPpu8sTMyhCVkwgLmZMyYxXQlC0I8+HYFETEXRdJFJGch
 cBEpK68N0GdSCwEAY1//snst+oEDNUY66wW7MMYQJDn0SDqrxRBBhBntOKY+eW7mWK8dmBWqd
 niuhcRsOJBL21cYdIx94coZo/txvsq52vw0ienjRAUvmcjOdNjYZo9DrNCJmVpqP98h3kRYbX
 nhJzR6gen59cHGgGKx8Vv1XswlJmfwOFJ8LOA/ZuKstlTVsCGhMzuViSE72tB6MTUMFUDvYcY
 zwuYoMROcwMYPfF43IaHa/vIwccPVrrCeAh+uBLmApwOuLEPGlhp9yHmeGIHpr8vKOB5gIPCP
 Iqwu4SC73xSWdngE7iWBdUENzmZ/SdsfdPX8E76tT/Y0ITeXfDCncdQkiNdPAwQYesE9bmcQG
 1Yw1wjxpye9QsHUpQwFninzXG4XsBk3uqqbTlBiiYFUfgZJ6c0P3MZn6w==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/6/26 =E4=B8=8B=E5=8D=883:17, Zhenyu Wu wrote:
> Thank you very much!
>
> i spend about one whole day to delete 58 ghosts and now i have about
> 370GiB free space. now i have enough space to snapper to make
> snapshots. without your help, it is impossible.

It takes much longer than I thought, thus I guess maybe qgroup is
heavily slowing down the process?

>
> and i want to know if this circumstance which ghosts exist will
> happened again? i need to do the same operation to delete these
> ghosts? thanks!

Looking into the subvolume deletion code, the orphan item and subvolume
unlink all happen inside one transaction, thus it should not be possible
to have subvolume unlinked but no orphan item.

Maybe it's some special race/corner case where we inserted orphan item
first, but I don't have a clue yet.

I guess it could be related to the btrfs-zero-log call, but I'm not
familiar enough to log tree code thus hard to say.


Personally speaking, it shouldn't be an easy thing to trigger such
situation anyway.
If it happens again, please let us know, with the history so that we
could have a better clue.

>
> btw, if i `btrfs-corrupt-block -X /dev/sda2` again, it will
> ```
> $ ./btrfs-corrupt-block -X /dev/sda2
> Root XXXX is a ghost
> # repeat 4 times
> Inserted orhpan item for root XXXX
> # repeat 4 times
> Please mount the fs and kernel will try to delete above roots
> $ ./btrfs-corrupt-block -X /dev/sda2
> Root XXXX is a ghost
> # repeat 4 times
> btrfs-corrupt-block.c:1182: mark_roots_orphan: Assertion `ret =3D=3D 0`
> failed, value 0
> ./btrfs-corrupt-block(main+0x78d)[0x55df0ffee925]
> /lib64/libc.so.6(__libc_start_main+0xcd)[0x7f72c889f7ed]
> ./btrfs-corrupt-block(_start+0x2a)[0x55df0ffe083a]
> Aborted
> ```
> it will not harm my data, will it?

If it crashes, it won't write anything to your fs, thus you're
completely safe.

In fact, for your case, it's btrfs_insert_empty_item(), which means the
orphan item is already inserted, and you're completely safe.

I just didn't take the error handling too series as it's just a dirty hack=
.

We should have proper btrfs check for such case soon, thanks to your
report and test!

Thanks,
Qu

> thanks!
>
> On Fri, Jun 25, 2021 at 1:36 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote=
:
>>
>>
>>
>> On 2021/6/25 =E4=B8=8B=E5=8D=881:28, Qu Wenruo wrote:
>>>
>>>
>>> On 2021/6/25 =E4=B8=8A=E5=8D=888:59, Qu Wenruo wrote:
>>>>
>>>>
>>>> On 2021/6/25 =E4=B8=8A=E5=8D=887:46, Qu Wenruo wrote:
>>>>>
>>>>>
>>>>> On 2021/6/24 =E4=B8=8B=E5=8D=8810:38, Zhenyu Wu wrote:
>>>>>> ```
>>>>>> $ btrfs ins dump-tree -t data_reloc
>>>>>> btrfs-progs v5.10.1
>>>>>> data reloc tree key (DATA_RELOC_TREE ROOT_ITEM 0)
>>>>>> leaf 57458688 items 2 free space 16061 generation 941500 owner
>>>>>> DATA_RELOC_TREE
>>>>>> leaf 57458688 flags 0x1(WRITTEN) backref revision 1
>>>>>> fs uuid 644a9e91-5e05-4f5d-a79b-e0eccd21a1a8
>>>>>> chunk uuid fa782e34-63ae-4917-ac63-bbbe56851d8b
>>>>>> item 0 key (256 INODE_ITEM 0) itemoff 16123 itemsize 160
>>>>>> generation 3 transid 0 size 0 nbytes 16384
>>>>>> block group 0 mode 40755 links 1 uid 0 gid 0 rdev 0
>>>>>> sequence 0 flags 0x0(none)
>>>>>> atime 1579910090.0 (2020-01-24 23:54:50)
>>>>>> ctime 1579910090.0 (2020-01-24 23:54:50)
>>>>>> mtime 1579910090.0 (2020-01-24 23:54:50)
>>>>>> otime 1579910090.0 (2020-01-24 23:54:50)
>>>>>> item 1 key (256 INODE_REF 256) itemoff 16111 itemsize 12
>>>>>> index 0 namelen 2 name: ..
>>>>>> total bytes 499972575232
>>>>>> bytes used 466593501184
>>>>>> uuid 644a9e91-5e05-4f5d-a79b-e0eccd21a1a8
>>>>>> $ btrfs ins dump-tree -t root 2>&1|tee root.txt
>>>>>> # attachment
>>>>>
>>>>> This explains everything!
>>>>>
>>>>> There are 58 root items! Meaning all of those snapshots are still ta=
king
>>>>> space.
>>>>>
>>>>> Furthermore, all those roots have no backref, meaning it's already
>>>>> unlinked from the fs, thus btrfs subvolume list won't list them.
>>>>>
>>>>> For the worst part, they also have no orphan item marking them to be
>>>>> deleted.
>>>>> Thus they all become real ghost subvolumes.
>>>>>
>>>>> And since qgroup rescan only create subvolumes based on its ROOT_REF=
_KEY
>>>>> to create 0 level qgroups, all these ghost snapshots are not created=
,
>>>>> causing the super weird result.
>>>>>
>>>>> I have no idea why this could happen, need to dig further into the c=
ode.
>>>>
>>>> A quick glance into the code, and it seems that for such ghost
>>>> subvolumes, "btrfs subv delete -i" may not work.
>>>>
>>>> For that case, I'll craft you a special btrfs-progs branch so that we
>>>> can add orphan items for those ghost roots and let them go for good.
>>>>
>>>> Thus if above "delete -i" doesn't work, please prepare a liveUSB in
>>>> which you can compile btrfs-progs.
>>>
>>> Here you go, please use the branch of btrfs-progs in LiveUSB:
>>>
>>> https://github.com/adam900710/btrfs-progs/tree/dirty_fixes
>>
>> Forgot to mention, I have tested the tool locally without problem.
>>
>> But even if the tool crashes by somehow, it shouldn't change any thing
>> of your fs, so feel free to use it.
>>
>> After digging into the kernel code, kernel will just drop snapshots one
>> by one, thus the limit is not really needed.
>>
>> You can change the line of "u64 orphan_roots[4] =3D { 0 };" to
>> "u64 orphan_roots[64] =3D { 0 }", which will cover all your ghosts root=
s
>> in one go.
>>
>> For the formal fix, I'll enhance btrfs-check to detect and fix the
>> problem soon, but I'm afraid you have to use the dirty fix branch for n=
ow.
>>
>> Thanks,
>> Qu
>>>
>>> It enhances btrfs-progs/btrfs-corrupt-block command (I know it's scary=
,
>>> but trust me, I make the extra option to be extra safe).
>>>
>>> Now in your liveUSB, make sure your fs is not mounted first.
>>>
>>> Then go the following loop:
>>>
>>> # ./btrfs-corrupt-block -X <device>
>>>
>>> It will output which roots are ghosts and will add back orphan items f=
or
>>> them.
>>>
>>> # mount <device> <mnt>
>>>
>>> # btrfs subv sync <mnt>
>>>
>>> It will wait for the 4 subvolumes to be deleted.
>>>
>>> # umount <mnt>
>>>
>>> Then go back to "corrupt-block -X" command and continue.
>>> I made the command to only add orphans to at most 4 subvolumes, to mak=
e
>>> sure we won't trigger too many deletions at the same time.
>>>
>>> If you don't want above loop (you need to go at least 15 loops), nor
>>> want to craft a small script to do that, I can change the code to do a=
ll
>>> of them in one go, but I'm not sure if it's OK for the kernel to handl=
e
>>> so many orphan roots.
>>>
>>> BTW, since you have qgroup enabled, it will make subvolume deletion
>>> pretty slow, it's recommended to disable qgroup first. >
>>> Thanks,
>>> Qu
>>>>
>>>> Thanks,
>>>> Qu
>>>>>
>>>>> But for now, you can try to delete all these 58 subvolumes by their
>>>>> subvolume ID.
>>>>>
>>>>> You can try this as a quick test:
>>>>>
>>>>> # btrfs subv delete -i 6317 <mnt>
>>>>> # btrfs subv sync <mnt>
>>>>>
>>>>> Then check if you still have "6317 ROOT_ITEM" in your root tree dump=
.
>>>>>
>>>>> If it's gone, repeat the process for all roots, I have extracted the
>>>>> root list and attached, so that you can craft a bash script to delet=
e
>>>>> all of them.
>>>>> (Note that above "subv sync" is not needed for each deletion if you =
want
>>>>> to delete them in a batch)
>>>>>
>>>>> Thanks,
>>>>> Qu
>>>>>
>>>>>> $ btrfs ins dump-tree -t extent 2>&1|tee extent.txt
>>>>>> # it's too large, i'll upload it to a cloud disk
>>>>>> ```
>>>>>>
>>>>>> thanks!
>>>>>>
>>>>>>
>>>>>>
>>>>>> On Thu, Jun 24, 2021 at 8:30 PM Qu Wenruo <quwenruo.btrfs@gmx.com>
>>>>>> wrote:
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> On 2021/6/24 =E4=B8=8B=E5=8D=887:33, Zhenyu Wu wrote:
>>>>>>>> the output has changed. do i need `btrfs ins dump-tree -t root`?
>>>>>>>> ```
>>>>>>>> $ sudo btrfs quota disable /
>>>>>>>> $ sudo btrfs quota enable /
>>>>>>>> $ sudo btrfs quota rescan -w /
>>>>>>>> # after 22m11s
>>>>>>>> $ sudo btrfs qgroup show -pcre /
>>>>>>>> qgroupid         rfer         excl     max_rfer     max_excl pare=
nt
>>>>>>>> child
>>>>>>>> --------         ----         ----     --------     -------- ----=
--
>>>>>>>> -----
>>>>>>>> 0/5          81.23GiB      6.90GiB         none         none ---
>>>>>>>> ---
>>>>>>>> ```
>>>>>>>> thanks!
>>>>>>>
>>>>>>> Yes, dump tree output for both root and data_reloc is needed.
>>>>>>>
>>>>>>> There may be a larger dump needed, "btrfs ins dump-tree -t extent
>>>>>>> <device>", as I guess there is some ghost trees not properly
>>>>>>> deleted at
>>>>>>> all...
>>>>>>>
>>>>>>> The whole thing is going crazy now.
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Qu
>>>>>>>>
>>>>>>>> On Thu, Jun 24, 2021 at 6:07 PM Qu Wenruo <quwenruo.btrfs@gmx.com=
>
>>>>>>>> wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 2021/6/24 =E4=B8=8B=E5=8D=885:52, Zhenyu Wu wrote:
>>>>>>>>>> i have rescan quota but it looks like nothing change...
>>>>>>>>>> ```
>>>>>>>>>> $ sudo btrfs quota rescan -w /
>>>>>>>>>> quota rescan started
>>>>>>>>>> # after 8m39s
>>>>>>>>>> $ sudo btrfs qgroup show -pcre /
>>>>>>>>>> qgroupid         rfer         excl     max_rfer     max_excl
>>>>>>>>>> parent   child
>>>>>>>>>> --------         ----         ----     --------     --------
>>>>>>>>>> ------   -----
>>>>>>>>>> 0/5          81.23GiB      6.89GiB         none         none
>>>>>>>>>> ---      ---
>>>>>>>>>> 0/265           0.00B        0.00B         none         none
>>>>>>>>>> ---      ---
>>>>>>>>>> 0/266           0.00B        0.00B         none         none
>>>>>>>>>> ---      ---
>>>>>>>>>> 0/267           0.00B        0.00B         none         none
>>>>>>>>>> ---      ---
>>>>>>>>>> 0/6482          0.00B        0.00B         none         none
>>>>>>>>>> ---      ---
>>>>>>>>>> 0/7501       16.00KiB     16.00KiB         none         none
>>>>>>>>>> ---      ---
>>>>>>>>>> 0/7502       16.00KiB     16.00KiB         none         none
>>>>>>>>>> 255/7502 ---
>>>>>>>>>> 0/7503       16.00KiB     16.00KiB         none         none
>>>>>>>>>> 255/7503 ---
>>>>>>>>>
>>>>>>>>> This is now getting super weird now.
>>>>>>>>>
>>>>>>>>> Firstly, if there are some snapshots of subvolume 5, it should
>>>>>>>>> show up
>>>>>>>>> here, with size over several GiB.
>>>>>>>>>
>>>>>>>>> Thus there seems to be some ghost/hidden subvolumes that even do=
n't
>>>>>>>>> show
>>>>>>>>> up in qgroup.
>>>>>>>>>
>>>>>>>>> It's possible that some qgroup is intentionally deleted, thus no=
t
>>>>>>>>> being
>>>>>>>>> properly updated.
>>>>>>>>>
>>>>>>>>> For that case, you may want to disable qgroup, re-enable, then d=
o a
>>>>>>>>> rescan: (Can all be done on the running system)
>>>>>>>>>
>>>>>>>>> # btrfs quota disable <mnt>
>>>>>>>>> # btrfs quota enable <mnt>
>>>>>>>>> # btrfs quota rescan -w <mnt>
>>>>>>>>>
>>>>>>>>> Then provide the output of 'btrfs qgroup show -prce <mnt>"
>>>>>>>>>
>>>>>>>>> If the output doesn't change at all, after the full 10min rescan=
,
>>>>>>>>> then I
>>>>>>>>> guess you have to dump the root tree, along with the data_reloc
>>>>>>>>> tree.
>>>>>>>>>
>>>>>>>>> # btrfs ins dump-tree -t root <device>
>>>>>>>>> # btrfs ins dump-tree -t data_reloc <device>
>>>>>>>>>
>>>>>>>>> Thanks,
>>>>>>>>> Qu
>>>>>>>>>> 1/0             0.00B        0.00B         none         none
>>>>>>>>>> ---      ---
>>>>>>>>>> 255/7502     16.00KiB     16.00KiB         none         none
>>>>>>>>>> ---      0/7502
>>>>>>>>>> 255/7503     16.00KiB     16.00KiB         none         none
>>>>>>>>>> ---      0/7503
>>>>>>>>>> ```
>>>>>>>>>>
>>>>>>>>>> and i try to mount with option subvolid:
>>>>>>>>>> ```
>>>>>>>>>> $ mkdir /tmp/fulldisk
>>>>>>>>>> $ sudo mount -o subvolid=3D5 /dev/sda2 /tmp/fulldisk
>>>>>>>>>> $ ls -lA /tmp/fulldisk
>>>>>>>>>> total 4
>>>>>>>>>> drwxr-xr-x 1 root   root   1936 May  3 21:34 bin
>>>>>>>>>> drwxr-xr-x 1 root   root      0 Jan 25  2020 boot
>>>>>>>>>> drwxr-xr-x 1 root   root   1686 Jan 20  2020 dev
>>>>>>>>>> drwxr-xr-x 1 wzy    wzy    5756 Jun 24 13:51 etc
>>>>>>>>>> drwxr-xr-x 1 root   root     22 Oct 17  2020 home
>>>>>>>>>> drwxr-xr-x 1 root   root   1332 May 18 14:13 lib
>>>>>>>>>> drwxr-xr-x 1 root   root   6606 May 18 14:13 lib64
>>>>>>>>>> lrwxrwxrwx 1 root   root     10 Jan 24 20:23 media -> /run/medi=
a
>>>>>>>>>> drwxr-xr-x 1 wzy    wzy      38 Jan 27 16:51 mnt
>>>>>>>>>> drwxr-xr-x 1 root   root    234 Jun 18 14:29 opt
>>>>>>>>>> drwxr-xr-x 1 root   root      0 Jan 20  2020 proc
>>>>>>>>>> drwx------ 1 wzy    wzy     536 Jun 15 20:26 root
>>>>>>>>>> drwxr-xr-x 1 root   root     48 May 30 14:14 run
>>>>>>>>>> drwxr-xr-x 1 root   root   4926 May 18 14:12 sbin
>>>>>>>>>> drwxr-xr-x 1 root   root     10 Jan 20  2020 sys
>>>>>>>>>> drwxrwxrwx 1 nobody nobody    0 Jun 18 14:34 tftproot
>>>>>>>>>> drwxrwxrwt 1 root   root      0 May 30 14:25 tmp
>>>>>>>>>> drwxr-xr-x 1 root   root    198 Mar 31 19:32 usr
>>>>>>>>>> drwxr-xr-x 1 root   root    150 Apr  1 18:21 var
>>>>>>>>>> $ sudo btrfs fi du -s /tmp/fulldisk/*
>>>>>>>>>>          Total   Exclusive  Set shared  Filename
>>>>>>>>>>       10.66MiB       0.00B    10.66MiB  /tmp/fulldisk/bin
>>>>>>>>>>          0.00B       0.00B       0.00B  /tmp/fulldisk/boot
>>>>>>>>>>          0.00B       0.00B       0.00B  /tmp/fulldisk/dev
>>>>>>>>>>       33.34MiB    36.00KiB    33.30MiB  /tmp/fulldisk/etc
>>>>>>>>>>       13.79GiB   784.05MiB    12.96GiB  /tmp/fulldisk/home
>>>>>>>>>>      922.28MiB       0.00B   922.28MiB  /tmp/fulldisk/lib
>>>>>>>>>>       23.11MiB       0.00B    23.11MiB  /tmp/fulldisk/lib64
>>>>>>>>>> ERROR: cannot check space of '/tmp/fulldisk/media': Inappropria=
te
>>>>>>>>>> ioctl for device
>>>>>>>>>>          0.00B       0.00B       0.00B  /tmp/fulldisk/mnt
>>>>>>>>>>       11.08GiB       0.00B    11.08GiB  /tmp/fulldisk/opt
>>>>>>>>>>          0.00B       0.00B       0.00B  /tmp/fulldisk/proc
>>>>>>>>>>       40.38MiB     4.35MiB    36.03MiB  /tmp/fulldisk/root
>>>>>>>>>>          0.00B       0.00B       0.00B  /tmp/fulldisk/run
>>>>>>>>>>       26.62MiB       0.00B    26.62MiB  /tmp/fulldisk/sbin
>>>>>>>>>>          0.00B       0.00B       0.00B  /tmp/fulldisk/sys
>>>>>>>>>>          0.00B       0.00B       0.00B  /tmp/fulldisk/tftproot
>>>>>>>>>>          0.00B       0.00B       0.00B  /tmp/fulldisk/tmp
>>>>>>>>>>       47.22GiB     1.03GiB    46.15GiB  /tmp/fulldisk/usr
>>>>>>>>>>        5.80GiB     4.35GiB     1.45GiB  /tmp/fulldisk/var
>>>>>>>>>> ```
>>>>>>>>>>
>>>>>>>>>> because media is a symbolic link so the ERROR should be normal.
>>>>>>>>>> according to `btrfs fi du` it looks like i only use about 80GiB=
.
>>>>>>>>>> it is
>>>>>>>>>> too weird.
>>>>>>>>>> thanks!
>>>>>>>>>>
>>>>>>>>>> On Thu, Jun 24, 2021 at 4:32 PM Graham Cobb <g.btrfs@cobb.uk.ne=
t>
>>>>>>>>>> wrote:
>>>>>>>>>>>
>>>>>>>>>>> On 24/06/2021 08:45, Zhenyu Wu wrote:
>>>>>>>>>>>> Thanks! this is some information of some programs.
>>>>>>>>>>>> ```
>>>>>>>>>>>> # boot from liveUSB
>>>>>>>>>>>> $ btrfs check /dev/sda2
>>>>>>>>>>>> [1/7] checking root items
>>>>>>>>>>>> [2/7] checking extents
>>>>>>>>>>>> [3/7] checking free space cache
>>>>>>>>>>>> [4/7] checking fs roots
>>>>>>>>>>>> [5/7] checking only csums items (without verifying data)
>>>>>>>>>>>> [6/7] checking root refs
>>>>>>>>>>>> [7/7] checking quota groups
>>>>>>>>>>>> # after mount /dev/sda2 to /mnt/gentoo
>>>>>>>>>>>
>>>>>>>>>>> Did you do 'mount -o subvolid=3D5 /dev/sda2 /mnt/gentoo' to ma=
ke
>>>>>>>>>>> sure you
>>>>>>>>>>> can see all subvolumes, not just the default subvolume? I gues=
s it
>>>>>>>>>>> doesn't matter for quota, but it matters if you are using tool=
s
>>>>>>>>>>> like du.
>>>>>>>>>>>
>>>>>>>>>>> You don't even need to use a liveUSB. On your normal mounted
>>>>>>>>>>> system you
>>>>>>>>>>> can do...
>>>>>>>>>>>
>>>>>>>>>>> mkdir /tmp/fulldisk
>>>>>>>>>>> mount -o subvolid=3D5 /dev/sda2 /tmp/fulldisk
>>>>>>>>>>> ls -lA /tmp/fulldisk
>>>>>>>>>>>
>>>>>>>>>>> to see if there are other subvolumes which are not visible in =
/
