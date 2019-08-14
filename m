Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7888CF1C
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Aug 2019 11:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfHNJMb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Aug 2019 05:12:31 -0400
Received: from mail1.arhont.com ([178.248.108.111]:54726 "EHLO
        mail1.arhont.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbfHNJMb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Aug 2019 05:12:31 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail1.arhont.com (Postfix) with ESMTP id B9FFC360080;
        Wed, 14 Aug 2019 10:12:28 +0100 (BST)
Received: from mail1.arhont.com ([127.0.0.1])
        by localhost (mail1.arhont.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id UDESfe7KGCDd; Wed, 14 Aug 2019 10:12:24 +0100 (BST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail1.arhont.com (Postfix) with ESMTP id D2BDE360BFA;
        Wed, 14 Aug 2019 10:12:24 +0100 (BST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail1.arhont.com D2BDE360BFA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arhont.com;
        s=157CE280-B46F-11E5-BB22-6D46E05691A3; t=1565773944;
        bh=UlGnx2t1IsbEG6fwKrKGl0Q3BX5XgCcVOB4ctJxya+I=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=0DiarrE1p7AOEiP5Bn/LPZ334fCZuQSieamilEvbeiWCDsbTqUK/hWocuey5KzfHC
         46yAVzP9Pzio12hyZCpbPRIWFZUE+Yrz/eo1g7gf/D4mTL14GDG3Uwey+8MORckATg
         JzVqdzJ5sicYMIFd/+jCbroaP20IWKs6LAdSdZ9E=
X-Virus-Scanned: amavisd-new at arhont.com
Received: from mail1.arhont.com ([127.0.0.1])
        by localhost (mail1.arhont.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id h6NLjOFGY1dh; Wed, 14 Aug 2019 10:12:24 +0100 (BST)
Received: from mail1.arhont.com (localhost.localdomain [127.0.0.1])
        by mail1.arhont.com (Postfix) with ESMTP id A0C35360080;
        Wed, 14 Aug 2019 10:12:24 +0100 (BST)
Date:   Wed, 14 Aug 2019 10:12:24 +0100 (BST)
From:   "Konstantin V. Gavrilenko" <k.gavrilenko@arhont.com>
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <923264966.8.1565773937997.JavaMail.gkos@xpska>
In-Reply-To: <3ef16706-8c2f-f47d-8057-38c567487926@gmx.com>
References: <347523577.41.1565689723208.JavaMail.gkos@xpska> <8cdacece-32a3-daf7-3ac8-f062179ebbaf@gmx.com> <744798339.29.1565703591504.JavaMail.gkos@xpska> <f2899154-3de6-3d8b-706c-539911831d17@gmx.com> <1425294964.32.1565720950325.JavaMail.gkos@xpska> <3ef16706-8c2f-f47d-8057-38c567487926@gmx.com>
Subject: Re: btrfs errors
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3803 (Zimbra Desktop/7.3.1_13063_Linux)
Thread-Topic: btrfs errors
Thread-Index: XIwUBvpW4vF2D/9G0DQ95wkNuEgDPA==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Thanks for the help and clarification Qu.

I will wait for the 5.3 and see what it brings.


Best regars,
Konstantin


----- Original Message -----
From: "Qu Wenruo" <quwenruo.btrfs@gmx.com>
To: "Konstantin V. Gavrilenko" <k.gavrilenko@arhont.com>, "linux-btrfs" <li=
nux-btrfs@vger.kernel.org>
Sent: Wednesday, 14 August, 2019 1:24:42 AM
Subject: Re: btrfs errors

Thanks for the dump.

Now it's very clear what the problem is.

It's an old kernel behavior which allows compressed file extents to have
NODATASUM flag.

The behavior is going to be fixed in v5.3 by commit 42c16da6d684
("btrfs: inode: Don't compress if NODATASUM or NODATACOW set").

Currently you can just dismiss the false alert.
The only minor downside of the current behavior is, if one copy of your
data is corrupted, there is no chance to recover the data even you're
using DUP/RAID1/RAID5/RAID6/RAID10.

Or you can wait for v5.3 kernel and copy old data back to a newly
created fs which only modified by v5.3 kernel.

Thanks,
Qu

On 2019/8/14 =E4=B8=8A=E5=8D=882:29, Konstantin V. Gavrilenko wrote:
>=20
>=20
> Yours sincerely,
> Konstantin V. Gavrilenko
>=20
> Director
> Arhont Services Ltd
>=20
> web:    http://www.arhont.com
> e-mail: k.gavrilenko@arhont.com
>=20
> tel: +44 (0) 870 44 31337
> fax: +44 (0) 208 429 3111
>=20
> PGP: Key ID - 0xE81824F4
> PGP: Server - keyserver.pgp.com
>=20
>=20
> ----- Original Message -----
> From: "Qu Wenruo" <quwenruo.btrfs@gmx.com>
> To: "Konstantin V. Gavrilenko" <k.gavrilenko@arhont.com>
> Cc: "linux-btrfs" <linux-btrfs@vger.kernel.org>
> Sent: Tuesday, 13 August, 2019 4:01:30 PM
> Subject: Re: btrfs errors
>=20
>=20
>=20
> On 2019/8/13 =E4=B8=8B=E5=8D=889:40, Konstantin V. Gavrilenko wrote:
>>
>> Hi Qu,
>>
>> thanks for the quick response. so I've booted into the latest Archiso (k=
ernel 5.2.xx, btrfs 5.2.xx) and rerun the # btrfs check  and # btrfs scrub.=
 The btrfs check output is rather large and is included as an attachment to=
 this message.
>>
>> It seems that the problem lies in fs_roots.
>> [1/7] checking root items
>> [2/7] checking extents
>> [3/7] checking free space cache
>> [4/7] checking fs roots=20
>> root 257 inode 6360900 errors 1000, some csum missing=20
>> root 258 inode 364233 errors 1040, bad file extent, some csum missing
>> root 258 inode 364234 errors 1040, bad file extent, some csum missing
>> ....
>> root 258 inode 5074178 errors 100, file extent discount
>> Found file extent holes:
>> =09start: 0, len: 4096
>> root 258 inode 5386921 errors 1040, bad file extent, some csum missing
>> ...
>> ERROR: errors found in fs roots
>>
>>
>> Opening filesystem to check...
>> Checking filesystem on /dev/kubuntu-vg/lv_root
>> UUID: 7b19fb5e-4e16-4b62-b803-f59364fd61a2
>> cache and super generation don't match, space cache will be invalidated
>> found 335628447749 bytes used, error(s) found
>> total csum bytes: 292272496
>> total tree bytes: 5118279680
>> total fs tree bytes: 4523163648
>> total extent tree bytes: 244498432
>> btree space waste bytes: 1186351226
>> file data blocks allocated: 536719597568
>>  referenced 630181720064
>=20
> The result indeeds shows some *minor* problem.
>=20
> One is "bad file extent" normally related to some extent too large for
> compressed inlined extent.
>=20
> Considering you're using lzo compression, it looks like some older
> kernel behavior which is no longer considered sane nowadays.
>=20
> You don't need to panic (never run btrfs check --repair yet), as your fs
> is mostly fine, no data loss or whatever.
>=20
> At least in recent kernel releases, you won't hit a problem.
>=20
>=20
> KVG: Good to hear that. Actually this system is about 1.5 y/o, since the =
release of Ubuntu 18.04LTS that was shipped with 4.15
> and the mount options remained the same from the start. the kernel upgrad=
e path was 4.18 in Feb'19, then 5.0 in Apr'19 followed by 5.1 in May'19.
>=20
> I also used to run on a monthly basis for about a year.
>=20
>        btrfs filesystem defrag -r -t 32m $MP 2> /dev/null
>        btrfs balance start -musage=3D35 -dusage=3D55 $MP
>=20
> but once I started doing daily snapshost, I stopped doing it a it was mes=
sing the free space calculations.
>=20
>=20
>>
>>
>> so I've mounted the FS and run scrub, which resulted in "ALL OK" again.
>> UUID:             7b19fb5e-4e16-4b62-b803-f59364fd61a2
>> Scrub started:    Tue Aug 13 13:01:26 2019
>> Status:           finished
>> Duration:         0:02:44
>> Total to scrub:   312.59GiB
>> Rate:             1.91GiB/s
>> Error summary:    no errors found
>>
>>
>> I have backed up all the important data on the external disc just now, a=
nd no errors in the dmesg were reported, so I assume the data is OK.
>> I also have snapshots of this system stored on the external disc dating =
back to Apr'19.
>=20
> Currently it looks like false alert.
>=20
> But to be sure, please do me a favor by running lowmem mode check, which
> should output more useful info other than "bad file extent".
>=20
> # btrfs check --mode=3Dlowmem <dev>
>=20
> It may take a longer time to finish. But should be more useful.
>=20
>=20
>=20
> KVG: Indeed, the btrfs check generated 150k lines of text :)
> so the more detailed errors fall into the following categories
>=20
> 326 lines similar to
> ERROR: root 258 INODE[5074178] size 162 should have a file extent hole
> ERROR: root 258 INODE[5711285] size 586 should have a file extent hole
> ERROR: root 258 INODE[5761076] size 215 should have a file extent hole
>=20
> 75584 lines similar to
> ERROR: root 258 EXTENT_DATA[364233 0] is compressed, but inode flag doesn=
't allow it
> ERROR: root 258 EXTENT_DATA[364233 131072] is compressed, but inode flag =
doesn't allow it
> ERROR: root 258 EXTENT_DATA[364233 262144] is compressed, but inode flag =
doesn't allow it
>=20
> 75693 lines similar to
> ERROR: root 258 EXTENT_DATA[364233 0] compressed extent must have csum, b=
ut only 0 bytes have, expect 4096
> ERROR: root 258 EXTENT_DATA[364233 131072] compressed extent must have cs=
um, but only 0 bytes have, expect 16384
> ERROR: root 258 EXTENT_DATA[364233 262144] compressed extent must have cs=
um, but only 0 bytes have, expect 4096
>=20
> The complete output is xz'ed and attached.
>=20
>=20
>> So I guess the two important questions are=20
>> - is it possible to reliable recover FS, or at least find out which file=
s were affected  at the reported inode location.
>=20
> If it's a false alert, you don't need to recover anything.
>=20
> If it's too strict btrfs check, and you want to follow latest btrfs
> *too sane* behavior, you can just try copy the old data to a newly
> created btrfs.
>=20
> KVG: Sure, thats one of the possibilities. What about if I try a forceful=
 recompression of the complete FS via=20
> # btrfs filesystem defragment -c $MP
>=20
> or alternatively I can try to remove compression alltogether and run a de=
frag to see if that helps remove the problem.
> What do you think?
>=20
> thanks,
> Kos
>=20
>=20
>=20
> Thanks,
> Qu
>=20
>> - is it possible to # btrfs check <snapshot> without copying it back on =
the main disk. maybe loopdevice?
>>
>>
>> thanks,
>> Konstantin
>>
>>
>> ----- Original Message -----
>> From: "Qu Wenruo" <quwenruo.btrfs@gmx.com>
>> To: "Konstantin V. Gavrilenko" <k.gavrilenko@arhont.com>, "linux-btrfs" =
<linux-btrfs@vger.kernel.org>
>> Sent: Tuesday, 13 August, 2019 12:55:47 PM
>> Subject: Re: btrfs errors
>>
>>
>>
>> On 2019/8/13 =E4=B8=8B=E5=8D=885:48, Konstantin V. Gavrilenko wrote:
>>> Hi list
>>>
>>> I have run the btrfs check, and that reported multiple errors on the FS=
.
>>>
>>> # btrfs check --readonly --force /dev/kubuntu-vg/lv_root
>>> <SKIP>
>>
>> Please don't skip the output, especially for btrfs check.
>>
>> The first tree btrfs check checks is extent tree, if we have anything
>> wrong in extent tree, it's way serious than the later part.
>>
>> And I understand you want to check your root fs, thus you have to use
>> --force, but I'd recommend to go whatever distro you like, use its
>> liveCD/USB to check your root fs.
>>
>> It looks like that since your fs is still mounted, the data structure
>> changed during the btrfs check run, it's possible to cause false alert.
>>
>>> root 9214 inode 6850330 errors 2001, no inode item, link count wrong
>>>         unresolved ref dir 266982 index 22459 namelen 36 name 962104104=
5a17a475428a26fcfb5982f.png filetype 1 errors 6, no dir index, no inode ref
>>>         unresolved ref dir 226516 index 9 namelen 28 name GYTSPMxjwCVp8=
kXB7+j91O8kcq4=3D filetype 1 errors 4, no inode ref
>>> root 9214 inode 6877070 errors 2001, no inode item, link count wrong
>>>         unresolved ref dir 226516 index 11 namelen 28 name VSqlYzl4pFqJ=
pvC3GA9bQ0mZK8A=3D filetype 1 errors 4, no inode ref
>>> root 9214 inode 6878054 errors 2001, no inode item, link count wrong
>>>         unresolved ref dir 266982 index 22460 namelen 36 name 52e74e9d2=
b6f598038486f90f8f911c4.png filetype 1 errors 4, no inode ref
>>> root 9214 inode 6888414 errors 2001, no inode item, link count wrong
>>>         unresolved ref dir 226391 index 122475 namelen 14 name the-real=
-index filetype 1 errors 4, no inode ref
>>> root 9214 inode 6889202 errors 100, file extent discount
>>> Found file extent holes:
>>>         start: 0, len: 4096
>>> root 9214 inode 6889203 errors 100, file extent discount
>>> Found file extent holes:
>>>         start: 0, len: 4096
>>> ERROR: errors found in fs roots
>>> found 334531551237 bytes used, error(s) found
>>> total csum bytes: 291555464
>>> total tree bytes: 1004404736
>>> total fs tree bytes: 411713536
>>> total extent tree bytes: 242974720
>>> btree space waste bytes: 186523621
>>> file data blocks allocated: 36730163200
>>>  referenced 42646511616
>>>
>>>
>>> However, scrub and badblock find no errors.
>>>
>>> # btrfs scrub status /mnt/
>>> scrub status for 7b19fb5e-4e16-4b62-b803-f59364fd61a2
>>>         scrub started at Tue Aug 13 07:31:38 2019 and finished after 00=
:02:47
>>>         total bytes scrubbed: 311.15GiB with 0 errors
>>
>> Scrub only checks checksum, doesn't care the content.
>> (Kernel newer than v5.0 will care the content, but doesn't do full
>> cross-check, unlike btrfs-check)
>>
>>>
>>> # badblocks -sv /dev/kubuntu-vg/lv_root=20
>>> Checking blocks 0 to 352133119
>>> Checking for bad blocks (read-only test):  done                        =
                        =20
>>> Pass completed, 0 bad blocks found. (0/0/0 errors)
>>>
>>> # btrfs dev stats /dev/kubuntu-vg/lv_root                              =
                                                                           =
                                             =20
>>> [/dev/mapper/kubuntu--vg-lv_root].write_io_errs    0
>>> [/dev/mapper/kubuntu--vg-lv_root].read_io_errs     0
>>> [/dev/mapper/kubuntu--vg-lv_root].flush_io_errs    0
>>> [/dev/mapper/kubuntu--vg-lv_root].corruption_errs  0
>>> [/dev/mapper/kubuntu--vg-lv_root].generation_errs  0
>>>
>>>
>>>
>>> FS mount fine, and is operational.
>>> would you recommend executing the btrfs check --repair option or is the=
re something else that I can try.
>>
>> Don't do anything stupid yet.
>> Just go LiveCD/USB and check again.
>>
>>>
>>> #  uname -a                                                            =
                                                                           =
                                                  Linux xps 5.1.16-050116-g=
eneric #201907031232 SMP Wed Jul 3 12:35:21 UTC 2019 x86_64 x86_64 x86_64 G=
NU/Linux
>>
>> Since v5.2 introduced a lot of new restrict check, I'd recommend to go
>> mount with latest Archiso, btrfs-check first, if no problem, mount and
>> scrub again just in case.
>>
>>> # btrfs --version                                                      =
                                                                           =
                                             =20
>>> btrfs-progs v4.15.1
>>
>> Big nope. You won't really want to run btrfs check --repair on such old
>> and buggy progs. Unless recent releases (5.2?) btrfs-progs has a bug
>> that transaction is not committed correctly, thus if something wrong
>> happened like BUG_ON() or transaction aborted, the fs can easily be
>> screwed up.
>>
>> Thanks,
>> Qu
>>
>>>
>>>
>>> mount options
>>> on / type btrfs (rw,relatime,compress-force=3Dlzo,ssd,discard,space_cac=
he=3Dv2,autodefrag,subvol=3D/@)
>>>
>>> thanks,
>>> Konstantin
>>>
>>
>=20

