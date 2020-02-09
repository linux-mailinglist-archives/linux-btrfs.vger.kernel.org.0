Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF5815684D
	for <lists+linux-btrfs@lfdr.de>; Sun,  9 Feb 2020 02:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbgBIBYP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 8 Feb 2020 20:24:15 -0500
Received: from mout.gmx.net ([212.227.17.21]:38149 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726474AbgBIBYP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 8 Feb 2020 20:24:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1581211448;
        bh=ZuGXm6L5HO4/cHk2sxVTb8Tq4VUlhbKVfSM4tScKEaI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ZKXU+Xvc3xWTGTallFgQQUVdI8SvKy4rBLAqA2EzUSjIJWd81HtDZdyEdRnx/K5K1
         uFFpt0GSuhj4/3uSc7uU9WAM0+995NOPpoKsJXfz1+KWWrHUBEMZSYV8LgWD0pG4d2
         +roBwrGURzcSpyRLch3ttgV98L8lDJSJRI7iab78=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MMGRK-1jGTWD17Ti-00JKMM; Sun, 09
 Feb 2020 02:24:08 +0100
Subject: Re: btrfs root fs started remounting ro
To:     John Hendy <jw.hendy@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CA+M2ft9zjGm7XJw1BUm364AMqGSd3a8QgsvQDCWz317qjP=o8g@mail.gmail.com>
 <CA+M2ft9ANwKT1+ENS6-w9HLtdx0MDOiVhi5RWKLucaT_WtZLkg@mail.gmail.com>
 <40b47145-f965-ec5f-2caf-68434c4fbc62@gmx.com>
 <CA+M2ft8zMv8nhs6VzZWnzgcP2nRasrwxLzjKgaZPnm_prtWQow@mail.gmail.com>
 <3e5f4de7-fec1-f8cd-c8b1-20b5a3f38f60@gmx.com>
 <CA+M2ft_6_1pkP75G79qj4dLxOjJr0bOGtATaGPTVQGn25sAo+A@mail.gmail.com>
 <CA+M2ft9dcMKKQstZVcGQ=9MREbfhPF5GG=xoMoh5Aq8MK9P8wA@mail.gmail.com>
 <75f86be2-80fe-26c1-235f-1c6d3a618eeb@gmx.com>
 <CA+M2ft9PjH29SY+nBqfFEapr9g7BjjMFeE_p2P0oL1q8xHGUBw@mail.gmail.com>
 <CA+M2ft9AnivVhPapsn_=bEoU5Ujw9PFo9Lbcjr5nzStdq84awg@mail.gmail.com>
 <711cfe11-be8e-566d-5fbe-55a9434fb5f5@gmx.com>
 <CA+M2ft-9sUpyru6yH3f=NrKnRWFph2Eg58PmU_xhCBqJCRQKCg@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAU4EEwEIADgCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1oQAKCRDC
 PZHzoSX+qCY6CACd+mWu3okGwRKXju6bou+7VkqCaHTdyXwWFTsr+/0ly5nUdDtT3yEVggPJ
 3VP70wjlrxUjNjFb6iIvGYxiPOrop1NGwGYvQktgRhaIhALG6rPoSSAhGNjwGVRw0km0PlIN
 D29BTj/lYEk+jVM1YL0QLgAE1AI3krihg/lp/fQT53wLhR8YZIF8ETXbClQG1vJ0cllPuEEv
 efKxRyiTSjB+PsozSvYWhXsPeJ+KKjFen7ebE5reQTPFzSHctCdPnoR/4jSPlnTlnEvLeqcD
 ZTuKfQe1gWrPeevQzgCtgBF/WjIOeJs41klnYzC3DymuQlmFubss0jShLOW8eSOOWhLRuQEN
 BFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcgaCbPEwhLj
 1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj/IrRUUka
 68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fNGSsRb+pK
 EKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0q1eW4Jrv
 0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEvABEBAAGJ
 ATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAKCRDCPZHz
 oSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gyfmtBnUai
 fnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsSoCEEynby
 72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAkZkA523JG
 ap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gGUO/iD/T5
 oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <c3d3757e-9c63-1d5b-061a-3b74ec94678e@gmx.com>
Date:   Sun, 9 Feb 2020 09:24:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <CA+M2ft-9sUpyru6yH3f=NrKnRWFph2Eg58PmU_xhCBqJCRQKCg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="uhdcsqvCR86H9O9SHDo6YCZTt2dZhqNLD"
X-Provags-ID: V03:K1:Ets6IiADHwtWb8gUPoVBPp6CmxSNLmyQpsfGh3pOTXHO4nFxuOW
 oaJRd/VsZXBnFg819skVYHN9ZwKfbGfemqIt8QNby81f2BWEIvO+33xkxyKMwgi59AHWEZs
 YBWjxiLE+wpeOonfsfGM0h+Wqhug5lcL5GkvhFFZO0c0iAjT4G3l/e7Dx/N2NHEh00K6s01
 OgTgBW068Cs5fV6AL2zMg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:DN16haCO82U=:kAWQo4gd9yGFBhWKuZpChk
 Kre9GFagIDo7PAmmWmCVfBXX91WSNoj//qig4SKZegxam1HDabhHIxxI0bH1IM4M3Q703VU6B
 qKeoZsrZ4nnnkEwFegKi3j7fy1rSjWWiDMzfLvpU9y1i4hXcNfJfTiMtqL8WhCJjpgQ3J/o4t
 4xr+sRuaA2XEjTz4USc3NwF9mtChSZ83TV86Sfh1zTjB2SCHdLr/eBnzsldeCqORRUuApX+s5
 p1qEDYZDcTuAMfIOsj26wYsiFKGmkP5cIE1TYmCqxhxeXbIX8ZZjdK03oyYfTwfPNqztvJlQq
 DxGAOGx9HYWAXBp83uyhWmapJBOb3npBemWF8qWi+BgcvdhEkpxu+Ua92cBDHP7Xfk80Ei66C
 CEOQmVdmVL4adgC26yb3/SJ77J8q6oWcc7+MKsrM6Ih5AdcVhKy3A4xWw6n2k7dxAaowd0/a5
 dnltFhZjbDxqp7yCv/qM7SPon7g1DexKo4zN++aPhzR4P9Hi44gy37H/TDcZErhJ3VTPnlLL0
 79FXrcEW3GvZ68zLK7SA8KitvEn36sMjiLNgWNOzE5K4DpOpXptWiAyTY4ASstAi0Ox4yq170
 dBNnW1v5Jq8YuRDFp3VxpnGUKdVr0H1dIYAPDyQm8xk2s0u+lITYQQ8g9xaDO4R5wnhixThH7
 DU+tdbtO70z/KVwS+x9ck/sSSN77xFbvp8cOdffz3NiApmJcwObM6UfFDo0Ovg/1IIBhS2pPn
 tAdosAXQDqgduNSVnszUipGUzfM01jeQn/HRcLHPqARNt5OOeAKUHyGWu3kZVjTdw5zwGchL3
 ht9IUFeZsSHoNfxjZIZL6RUvOdMMRnJP1vyAEC3dm+MLWg/A1eFNjLEEYwvWRmwiYBpW5Y4vg
 qEfiCkyv+BiQvNTMaDmK1pf5lNZvnZx1MfuB9SsUa8qVRefaXshrgrPZ+uKzjrjcJyOB/Hn9U
 tEt1Ul2nVEEO6sDLmbB380J7XENBGHGJf5XsaLwoK1iuV6XJwKKa9jCJFsVMV/d5yLvytWjfd
 l+BlCmCrq7qf96d4yzCHKyqcT7ojcHT4BZTVrfBBy77D9cgIf7inYSlgK88JvTHz/6UWE4YCw
 h/KNe6Lv8LqRbWYHOS4F6/j1AF61ihuxnp1Xj4d3UEuuAkc0J2+bM4BXysbRtWkijRl3N7jaK
 LUOOJRCLiPF3rYCjw+ocTKBD2rKIFbVGwpZYd8wOV+Z5gtkCvC4Lpul6SvrNOrCShB0+EHeif
 bfg8c3ht2BPxaNfdsiEV/hyzM77Mv85mVJyLFFx3DY95J2AhkeZ1O4ZkuynOuvJu1RhSxRNKF
 9Ty94ypY0R+KUnHZmeUZhKt5BbBkp9wKesUVhNBNmoqRj21rHTlUEtAaJGknVhBVokgs22pQ
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uhdcsqvCR86H9O9SHDo6YCZTt2dZhqNLD
Content-Type: multipart/mixed; boundary="iCVk7wyMnZgTEm21JIWa2P35NyfNOjpeM"

--iCVk7wyMnZgTEm21JIWa2P35NyfNOjpeM
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/2/9 =E4=B8=8A=E5=8D=889:20, John Hendy wrote:
> On Sat, Feb 8, 2020 at 7:09 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote=
:
>>
>>
>>
>> On 2020/2/9 =E4=B8=8A=E5=8D=888:59, John Hendy wrote:
>>> Also, if it's of interest, the zero-log trick was new to me. For my
>>> original m2.sata nvme drive, I'd already run all of --init-csum-tree,=

>>> --init-extent-tree, and --repair (unsure on the order of the first
>>> two, but --repair was definitely last) but could then not mount it. I=

>>> just ran `btrfs rescue zero-log` on it and here is the very brief
>>> output from a btrfs check:
>>>
>>> $ sudo btrfs check /dev/mapper/nvme
>>> Opening filesystem to check...
>>> Checking filesystem on /dev/mapper/nvme
>>> UUID: 488f733d-1dfd-4a0f-ab2f-ba690e095fe4
>>> [1/7] checking root items
>>> [2/7] checking extents
>>> data backref 40762777600 root 256 owner 525787 offset 0 num_refs 0 no=
t
>>> found in extent tree
>>> incorrect local backref count on 40762777600 root 256 owner 525787
>>> offset 0 found 1 wanted 0 back 0x5635831f9a20
>>> incorrect local backref count on 40762777600 root 4352 owner 525787
>>> offset 0 found 0 wanted 1 back 0x56357e5a3c70
>>> backref disk bytenr does not match extent record, bytenr=3D4076277760=
0,
>>> ref bytenr=3D0
>>> backpointer mismatch on [40762777600 4096]
>>
>> At this stage, btrfs check --repair should be able to fix it.
>>
>> Or does it still segfault?
>=20
> This was the original problematic drive, the m2.sata. I just did
> `btrfs check --repair` and it completed with:
>=20
> $ sudo btrfs check --repair /dev/mapper/nvme
> enabling repair mode
> WARNING:
>=20
>     Do not use --repair unless you are advised to do so by a developer
>     or an experienced user, and then only after having accepted that no=

>     fsck can successfully repair all types of filesystem corruption. Eg=
=2E
>     some software or hardware bugs can fatally damage a volume.
>     The operation will start in 10 seconds.
>     Use Ctrl-C to stop it.
> 10 9 8 7 6 5 4 3 2 1
> Starting repair.
> Opening filesystem to check...
> Checking filesystem on /dev/mapper/nvme
> UUID: 488f733d-1dfd-4a0f-ab2f-ba690e095fe4
> [1/7] checking root items
> Fixed 0 roots.
> [2/7] checking extents
> data backref 40762777600 root 256 owner 525787 offset 0 num_refs 0 not
> found in extent tree
> incorrect local backref count on 40762777600 root 256 owner 525787
> offset 0 found 1 wanted 0 back 0x5561d1f74ee0
> incorrect local backref count on 40762777600 root 4352 owner 525787
> offset 0 found 0 wanted 1 back 0x5561cd31f220
> backref disk bytenr does not match extent record, bytenr=3D40762777600,=

> ref bytenr=3D0
> backpointer mismatch on [40762777600 4096]
> repair deleting extent record: key [40762777600,168,4096]
> adding new data backref on 40762777600 root 256 owner 525787 offset 0 f=
ound 1
> Repaired extent references for 40762777600
> No device size related problem found
> [3/7] checking free space cache
> cache and super generation don't match, space cache will be invalidated=

> [4/7] checking fs roots
> [5/7] checking only csums items (without verifying data)
> [6/7] checking root refs
> [7/7] checking quota groups skipped (not enabled on this FS)
> found 87799443456 bytes used, no error found
> total csum bytes: 84696784
> total tree bytes: 954220544
> total fs tree bytes: 806535168
> total extent tree bytes: 47710208
> btree space waste bytes: 150766636
> file data blocks allocated: 87780622336
>  referenced 94255783936
>=20
> The output of btrfs check now on this drive:
>=20
> $ sudo btrfs check /dev/mapper/nvme
> Opening filesystem to check...
> Checking filesystem on /dev/mapper/nvme
> UUID: 488f733d-1dfd-4a0f-ab2f-ba690e095fe4
> [1/7] checking root items
> [2/7] checking extents
> [3/7] checking free space cache
> cache and super generation don't match, space cache will be invalidated=

> [4/7] checking fs roots
> [5/7] checking only csums items (without verifying data)
> [6/7] checking root refs
> [7/7] checking quota groups skipped (not enabled on this FS)
> found 87799443456 bytes used, no error found
> total csum bytes: 84696784
> total tree bytes: 954220544
> total fs tree bytes: 806535168
> total extent tree bytes: 47710208
> btree space waste bytes: 150766636
> file data blocks allocated: 87780622336
>  referenced 94255783936

Just as it said, there is no error found by btrfs-check.

If you want to be extra safe, please run `btrfs check` again, using
v5.4.1 (which adds an extra check for extent item generation).

At this stage, at least v5.3 kernel should be able to mount it, and
delete offending files.

v5.4 is a little more strict on extent item generation. But if you
delete the offending files using v5.3, everything should be fine.

If you want to be abosultely safe, you can run `btrfs check
--check-data-csum` to do a scrub-like check on data.

Thanks,
Qu
>=20
> How is that looking? I'll boot back into a usb drive to try --repair
> --mode=3Dlowmem on the SSD. My continued worry is the spurious file I
> can't delete. Is that something btrfs --repair will try to fix or is
> there something else that needs to be done? It seems this inode is
> tripping things up and I can't find a way to get rid of that file.
>=20
> John
>=20
>=20
>>
>> Thanks,
>> Qu
>>> ERROR: errors found in extent allocation tree or chunk allocation
>>> [3/7] checking free space cache
>>> [4/7] checking fs roots
>>> [5/7] checking only csums items (without verifying data)
>>> [6/7] checking root refs
>>> [7/7] checking quota groups skipped (not enabled on this FS)
>>> found 87799443456 bytes used, error(s) found
>>> total csum bytes: 84696784
>>> total tree bytes: 954220544
>>> total fs tree bytes: 806535168
>>> total extent tree bytes: 47710208
>>> btree space waste bytes: 150766636
>>> file data blocks allocated: 87780622336
>>>  referenced 94255783936
>>>
>>> If that looks promising... I'm hoping that the ssd we're currently
>>> working on will follow suit! I'll await your recommendation for what
>>> to do on the previous inquiries for the SSD, and if you have any
>>> suggestions for the backref errors on the nvme drive above.
>>>
>>> Many thanks,
>>> John
>>>
>>> On Sat, Feb 8, 2020 at 6:51 PM John Hendy <jw.hendy@gmail.com> wrote:=

>>>>
>>>> On Sat, Feb 8, 2020 at 5:56 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wr=
ote:
>>>>>
>>>>>
>>>>>
>>>>> On 2020/2/9 =E4=B8=8A=E5=8D=885:57, John Hendy wrote:
>>>>>> On phone due to no OS, so apologies if this is in html mode. Indee=
d, I
>>>>>> can't mount or boot any longer. I get the error:
>>>>>>
>>>>>> Error (device dm-0) in btrfs_replay_log:2228: errno=3D-22 unknown =
(Failed
>>>>>> to recover log tree)
>>>>>> BTRFS error (device dm-0): open_ctree failed
>>>>>
>>>>> That can be easily fixed by `btrfs rescue zero-log`.
>>>>>
>>>>
>>>> Whew. This was most helpful and it is wonderful to be booting at
>>>> least. I think the outstanding issues are:
>>>> - what should I do about `btrfs check --repair seg` faulting?
>>>> - how can I deal with this (probably related to seg fault) ghost fil=
e
>>>> that cannot be deleted?
>>>> - I'm not sure if you looked at the post --repair log, but there a t=
on
>>>> of these errors that didn't used to be there:
>>>>
>>>> backpointer mismatch on [13037375488 20480]
>>>> ref mismatch on [13037395968 892928] extent item 0, found 1
>>>> data backref 13037395968 root 263 owner 4257169 offset 0 num_refs 0
>>>> not found in extent tree
>>>> incorrect local backref count on 13037395968 root 263 owner 4257169
>>>> offset 0 found 1 wanted 0 back 0x5627f59cadc0
>>>>
>>>> Here is the latest btrfs check output after the zero-log operation.
>>>> - https://pastebin.com/KWeUnk0y
>>>>
>>>> I'm hoping once that file is deleted, it's a matter of
>>>> --init-csum-tree and perhaps I'm set? Or --init-extent-tree?
>>>>
>>>> Thanks,
>>>> John
>>>>
>>>>> At least, btrfs check --repair didn't make things worse.
>>>>>
>>>>> Thanks,
>>>>> Qu
>>>>>>
>>>>>> John
>>>>>>
>>>>>> On Sat, Feb 8, 2020, 1:56 PM John Hendy <jw.hendy@gmail.com
>>>>>> <mailto:jw.hendy@gmail.com>> wrote:
>>>>>>
>>>>>>     This is not going so hot. Updates:
>>>>>>
>>>>>>     booted from arch install, pre repair btrfs check:
>>>>>>     - https://pastebin.com/6vNaSdf2
>>>>>>
>>>>>>     btrfs check --mode=3Dlowmem as requested by Chris:
>>>>>>     - https://pastebin.com/uSwSTVVY
>>>>>>
>>>>>>     Then I did btrfs check --repair, which seg faulted at the end.=
 I've
>>>>>>     typed them off of pictures I took:
>>>>>>
>>>>>>     Starting repair.
>>>>>>     Opening filesystem to check...
>>>>>>     Checking filesystem on /dev/mapper/ssd
>>>>>>     [1/7] checking root items
>>>>>>     Fixed 0 roots.
>>>>>>     [2/7] checking extents
>>>>>>     parent transid verify failed on 20271138064 wanted 68719924810=
 found
>>>>>>     448074
>>>>>>     parent transid verify failed on 20271138064 wanted 68719924810=
 found
>>>>>>     448074
>>>>>>     Ignoring transid failure
>>>>>>     # ... repeated the previous two lines maybe hundreds of times
>>>>>>     # ended with this:
>>>>>>     ref mismatch on [12797435904 268505088] extent item 1, found 4=
12
>>>>>>     [1] 1814 segmentation fault (core dumped) btrfs check --repair=

>>>>>>     /dev/mapper/ssd
>>>>>>
>>>>>>     This was with btrfs-progs 5.4 (the install USB is maybe a mont=
h old).
>>>>>>
>>>>>>     Here is the output of btrfs check after the --repair attempt:
>>>>>>     - https://pastebin.com/6MYRNdga
>>>>>>
>>>>>>     I rebooted to write this email given the seg fault, as I wante=
d to
>>>>>>     make sure that I should still follow-up --repair with
>>>>>>     --init-csum-tree. I had pictures of the --repair output, but F=
irefox
>>>>>>     just wouldn't load imgur.com <http://imgur.com> for me to post=
 the
>>>>>>     pics and was acting
>>>>>>     really weird. In suspiciously checking dmesg, things have gone=
 ro on
>>>>>>     me :(  Here is the dmesg from this session:
>>>>>>     - https://pastebin.com/a2z7xczy
>>>>>>
>>>>>>     The gist is:
>>>>>>
>>>>>>     [   40.997935] BTRFS critical (device dm-0): corrupt leaf: roo=
t=3D7
>>>>>>     block=3D172703744 slot=3D0, csum end range (12980568064) goes =
beyond the
>>>>>>     start range (12980297728) of the next csum item
>>>>>>     [   40.997941] BTRFS info (device dm-0): leaf 172703744 gen 45=
0983
>>>>>>     total ptrs 34 free space 29 owner 7
>>>>>>     [   40.997942]     item 0 key (18446744073709551606 128 129790=
60736)
>>>>>>     itemoff 14811 itemsize 1472
>>>>>>     [   40.997944]     item 1 key (18446744073709551606 128 129802=
97728)
>>>>>>     itemoff 13895 itemsize 916
>>>>>>     [   40.997945]     item 2 key (18446744073709551606 128 129812=
35712)
>>>>>>     itemoff 13811 itemsize 84
>>>>>>     # ... there's maybe 30 of these item n key lines in total
>>>>>>     [   40.997984] BTRFS error (device dm-0): block=3D172703744 wr=
ite time
>>>>>>     tree block corruption detected
>>>>>>     [   41.016793] BTRFS: error (device dm-0) in
>>>>>>     btrfs_commit_transaction:2332: errno=3D-5 IO failure (Error wh=
ile
>>>>>>     writing out transaction)
>>>>>>     [   41.016799] BTRFS info (device dm-0): forced readonly
>>>>>>     [   41.016802] BTRFS warning (device dm-0): Skipping commit of=
 aborted
>>>>>>     transaction.
>>>>>>     [   41.016804] BTRFS: error (device dm-0) in cleanup_transacti=
on:1890:
>>>>>>     errno=3D-5 IO failure
>>>>>>     [   41.016807] BTRFS info (device dm-0): delayed_refs has NO e=
ntry
>>>>>>     [   41.023473] BTRFS warning (device dm-0): Skipping commit of=
 aborted
>>>>>>     transaction.
>>>>>>     [   41.024297] BTRFS info (device dm-0): delayed_refs has NO e=
ntry
>>>>>>     [   44.509418] systemd-journald[416]:
>>>>>>     /var/log/journal/45c06c25e25f434195204efa939019ab/system.journ=
al:
>>>>>>     Journal file corrupted, rotating.
>>>>>>     [   44.509440] systemd-journald[416]: Failed to rotate
>>>>>>     /var/log/journal/45c06c25e25f434195204efa939019ab/system.journ=
al:
>>>>>>     Read-only file system
>>>>>>     [   44.509450] systemd-journald[416]: Failed to rotate
>>>>>>     /var/log/journal/45c06c25e25f434195204efa939019ab/user-1000.jo=
urnal:
>>>>>>     Read-only file system
>>>>>>     [   44.509540] systemd-journald[416]: Failed to write entry (2=
3 items,
>>>>>>     705 bytes) despite vacuuming, ignoring: Bad message
>>>>>>     # ... then a bunch of these failed journal attempts (of note:
>>>>>>     /var/log/journal was one of the bad inodes from btrfs check
>>>>>>     previously)
>>>>>>
>>>>>>     Kindly let me know what you would recommend. I'm sadly back to=
 an
>>>>>>     unusable system vs. a complaining/worrisome one. This is simil=
ar to
>>>>>>     the behavior I had with the m2.sata nvme drive in my original
>>>>>>     experience. After trying all of --repair, --init-csum-tree, an=
d
>>>>>>     --init-extent-tree, I couldn't boot anymore. After my dm-crypt=

>>>>>>     password at boot, I just saw a bunch of [FAILED] in the text s=
plash
>>>>>>     output. Hoping to not repeat that with this drive.
>>>>>>
>>>>>>     Thanks,
>>>>>>     John
>>>>>>
>>>>>>
>>>>>>     On Sat, Feb 8, 2020 at 1:29 AM Qu Wenruo <quwenruo.btrfs@gmx.c=
om
>>>>>>     <mailto:quwenruo.btrfs@gmx.com>> wrote:
>>>>>>     >
>>>>>>     >
>>>>>>     >
>>>>>>     > On 2020/2/8 =E4=B8=8B=E5=8D=8812:48, John Hendy wrote:
>>>>>>     > > On Fri, Feb 7, 2020 at 5:42 PM Qu Wenruo <quwenruo.btrfs@g=
mx.com
>>>>>>     <mailto:quwenruo.btrfs@gmx.com>> wrote:
>>>>>>     > >>
>>>>>>     > >>
>>>>>>     > >>
>>>>>>     > >> On 2020/2/8 =E4=B8=8A=E5=8D=881:52, John Hendy wrote:
>>>>>>     > >>> Greetings,
>>>>>>     > >>>
>>>>>>     > >>> I'm resending, as this isn't showing in the archives. Pe=
rhaps
>>>>>>     it was
>>>>>>     > >>> the attachments, which I've converted to pastebin links.=

>>>>>>     > >>>
>>>>>>     > >>> As an update, I'm now running off of a different drive (=
ssd,
>>>>>>     not the
>>>>>>     > >>> nvme) and I got the error again! I'm now inclined to thi=
nk
>>>>>>     this might
>>>>>>     > >>> not be hardware after all, but something related to my s=
etup
>>>>>>     or a bug
>>>>>>     > >>> with chromium.
>>>>>>     > >>>
>>>>>>     > >>> After a reboot, chromium wouldn't start for me and demsg=
 showed
>>>>>>     > >>> similar parent transid/csum errors to my original post b=
elow.
>>>>>>     I used
>>>>>>     > >>> btrfs-inspect-internal to find the inode traced to
>>>>>>     > >>> ~/.config/chromium/History. I deleted that, and got a ne=
w set of
>>>>>>     > >>> errors tracing to ~/.config/chromium/Cookies. After I de=
leted
>>>>>>     that and
>>>>>>     > >>> tried starting chromium, I found that my btrfs /home/jwh=
endy
>>>>>>     pool was
>>>>>>     > >>> mounted ro just like the original problem below.
>>>>>>     > >>>
>>>>>>     > >>> dmesg after trying to start chromium:
>>>>>>     > >>> - https://pastebin.com/CsCEQMJa
>>>>>>     > >>
>>>>>>     > >> So far, it's only transid bug in your csum tree.
>>>>>>     > >>
>>>>>>     > >> And two backref mismatch in data backref.
>>>>>>     > >>
>>>>>>     > >> In theory, you can fix your problem by `btrfs check --rep=
air
>>>>>>     > >> --init-csum-tree`.
>>>>>>     > >>
>>>>>>     > >
>>>>>>     > > Now that I might be narrowing in on offending files, I'll =
wait
>>>>>>     to see
>>>>>>     > > what you think from my last response to Chris. I did try t=
he above
>>>>>>     > > when I first ran into this:
>>>>>>     > > -
>>>>>>     https://lore.kernel.org/linux-btrfs/CA+M2ft8FpjdDQ7=3DXwMdYQaz=
hyB95aha_D4WU_n15M59QrimrRg@mail.gmail.com/
>>>>>>     >
>>>>>>     > That RO is caused by the missing data backref.
>>>>>>     >
>>>>>>     > Which can be fixed by btrfs check --repair.
>>>>>>     >
>>>>>>     > Then you should be able to delete offending files them. (Or =
the whole
>>>>>>     > chromium cache, and switch to firefox if you wish :P )
>>>>>>     >
>>>>>>     > But also please keep in mind that, the transid mismatch look=
s
>>>>>>     happen in
>>>>>>     > your csum tree, which means your csum tree is no longer reli=
able, and
>>>>>>     > may cause -EIO reading unrelated files.
>>>>>>     >
>>>>>>     > Thus it's recommended to re-fill the csum tree by --init-csu=
m-tree.
>>>>>>     >
>>>>>>     > It can be done altogether by --repair --init-csum-tree, but =
to be
>>>>>>     safe,
>>>>>>     > please run --repair only first, then make sure btrfs check r=
eports no
>>>>>>     > error after that. Then go --init-csum-tree.
>>>>>>     >
>>>>>>     > >
>>>>>>     > >> But I'm more interesting in how this happened.
>>>>>>     > >
>>>>>>     > > Me too :)
>>>>>>     > >
>>>>>>     > >> Have your every experienced any power loss for your NVME =
drive?
>>>>>>     > >> I'm not say btrfs is unsafe against power loss, all fs sh=
ould
>>>>>>     be safe
>>>>>>     > >> against power loss, I'm just curious about if mount time =
log
>>>>>>     replay is
>>>>>>     > >> involved, or just regular internal log replay.
>>>>>>     > >>
>>>>>>     > >> From your smartctl, the drive experienced 61 unsafe shutd=
own
>>>>>>     with 2144
>>>>>>     > >> power cycles.
>>>>>>     > >
>>>>>>     > > Uhhh, hell yes, sadly. I'm a dummy running i3 and every ti=
me I get
>>>>>>     > > caught off gaurd by low battery and instant power-off, I k=
ick myself
>>>>>>     > > and mean to set up a script to force poweroff before that
>>>>>>     happens. So,
>>>>>>     > > indeed, I've lost power a ton. Surprised it was 61 times, =
but maybe
>>>>>>     > > not over ~2 years. And actually, I mis-stated the age. I h=
aven't
>>>>>>     > > *booted* from this drive in almost 2yrs. It's a corporate =
laptop,
>>>>>>     > > issued every 3, so the ssd drive is more like 5 years old.=

>>>>>>     > >
>>>>>>     > >> Not sure if it's related.
>>>>>>     > >>
>>>>>>     > >> Another interesting point is, did you remember what's the=

>>>>>>     oldest kernel
>>>>>>     > >> running on this fs? v5.4 or v5.5?
>>>>>>     > >
>>>>>>     > > Hard to say, but arch linux maintains a package archive. T=
he nvme
>>>>>>     > > drive is from ~May 2018. The archives only go back to Jan =
2019
>>>>>>     and the
>>>>>>     > > kernel/btrfs-progs was at 4.20 then:
>>>>>>     > > - https://archive.archlinux.org/packages/l/linux/
>>>>>>     >
>>>>>>     > There is a known bug in v5.2.0~v5.2.14 (fixed in v5.2.15), w=
hich could
>>>>>>     > cause metadata corruption. And the symptom is transid error,=
 which
>>>>>>     also
>>>>>>     > matches your problem.
>>>>>>     >
>>>>>>     > Thanks,
>>>>>>     > Qu
>>>>>>     >
>>>>>>     > >
>>>>>>     > > Searching my Amazon orders, the SSD was in the 2015 time f=
rame,
>>>>>>     so the
>>>>>>     > > kernel version would have been even older.
>>>>>>     > >
>>>>>>     > > Thanks for your input,
>>>>>>     > > John
>>>>>>     > >
>>>>>>     > >>
>>>>>>     > >> Thanks,
>>>>>>     > >> Qu
>>>>>>     > >>>
>>>>>>     > >>> Thanks for any pointers, as it would now seem that my pu=
rchase
>>>>>>     of a
>>>>>>     > >>> new m2.sata may not buy my way out of this problem! Whil=
e I didn't
>>>>>>     > >>> want to reinstall, at least new hardware is a simple fix=
=2E Now I'm
>>>>>>     > >>> worried there is a deeper issue bound to recur :(
>>>>>>     > >>>
>>>>>>     > >>> Best regards,
>>>>>>     > >>> John
>>>>>>     > >>>
>>>>>>     > >>> On Wed, Feb 5, 2020 at 10:01 AM John Hendy <jw.hendy@gma=
il.com
>>>>>>     <mailto:jw.hendy@gmail.com>> wrote:
>>>>>>     > >>>>
>>>>>>     > >>>> Greetings,
>>>>>>     > >>>>
>>>>>>     > >>>> I've had this issue occur twice, once ~1mo ago and once=
 a
>>>>>>     couple of
>>>>>>     > >>>> weeks ago. Chromium suddenly quit on me, and when tryin=
g to
>>>>>>     start it
>>>>>>     > >>>> again, it complained about a lock file in ~. I tried to=
 delete it
>>>>>>     > >>>> manually and was informed I was on a read-only fs! I en=
ded up
>>>>>>     biting
>>>>>>     > >>>> the bullet and re-installing linux due to the number of=
 dead end
>>>>>>     > >>>> threads and slow response rates on diagnosing these iss=
ues,
>>>>>>     and the
>>>>>>     > >>>> issue occurred again shortly after.
>>>>>>     > >>>>
>>>>>>     > >>>> $ uname -a
>>>>>>     > >>>> Linux whammy 5.5.1-arch1-1 #1 SMP PREEMPT Sat, 01 Feb 2=
020
>>>>>>     16:38:40
>>>>>>     > >>>> +0000 x86_64 GNU/Linux
>>>>>>     > >>>>
>>>>>>     > >>>> $ btrfs --version
>>>>>>     > >>>> btrfs-progs v5.4
>>>>>>     > >>>>
>>>>>>     > >>>> $ btrfs fi df /mnt/misc/ # full device; normally would =
be
>>>>>>     mounting a subvol on /
>>>>>>     > >>>> Data, single: total=3D114.01GiB, used=3D80.88GiB
>>>>>>     > >>>> System, single: total=3D32.00MiB, used=3D16.00KiB
>>>>>>     > >>>> Metadata, single: total=3D2.01GiB, used=3D769.61MiB
>>>>>>     > >>>> GlobalReserve, single: total=3D140.73MiB, used=3D0.00B
>>>>>>     > >>>>
>>>>>>     > >>>> This is a single device, no RAID, not on a VM. HP Zbook=
 15.
>>>>>>     > >>>> nvme0n1                                       259:5    =
0
>>>>>>     232.9G  0 disk
>>>>>>     > >>>> =E2=94=9C=E2=94=80nvme0n1p1                            =
       259:6    0
>>>>>>      512M  0
>>>>>>     > >>>> part  (/boot/efi)
>>>>>>     > >>>> =E2=94=9C=E2=94=80nvme0n1p2                            =
       259:7    0
>>>>>>      1G  0 part  (/boot)
>>>>>>     > >>>> =E2=94=94=E2=94=80nvme0n1p3                            =
       259:8    0
>>>>>>     231.4G  0 part (btrfs)
>>>>>>     > >>>>
>>>>>>     > >>>> I have the following subvols:
>>>>>>     > >>>> arch: used for / when booting arch
>>>>>>     > >>>> jwhendy: used for /home/jwhendy on arch
>>>>>>     > >>>> vault: shared data between distros on /mnt/vault
>>>>>>     > >>>> bionic: root when booting ubuntu bionic
>>>>>>     > >>>>
>>>>>>     > >>>> nvme0n1p3 is encrypted with dm-crypt/LUKS.
>>>>>>     > >>>>
>>>>>>     > >>>> dmesg, smartctl, btrfs check, and btrfs dev stats attac=
hed.
>>>>>>     > >>>
>>>>>>     > >>> Edit: links now:
>>>>>>     > >>> - btrfs check: https://pastebin.com/nz6Bc145
>>>>>>     > >>> - dmesg: https://pastebin.com/1GGpNiqk
>>>>>>     > >>> - smartctl: https://pastebin.com/ADtYqfrd
>>>>>>     > >>>
>>>>>>     > >>> btrfs dev stats (not worth a link):
>>>>>>     > >>>
>>>>>>     > >>> [/dev/mapper/old].write_io_errs    0
>>>>>>     > >>> [/dev/mapper/old].read_io_errs     0
>>>>>>     > >>> [/dev/mapper/old].flush_io_errs    0
>>>>>>     > >>> [/dev/mapper/old].corruption_errs  0
>>>>>>     > >>> [/dev/mapper/old].generation_errs  0
>>>>>>     > >>>
>>>>>>     > >>>
>>>>>>     > >>>> If these are of interested, here are reddit threads whe=
re I
>>>>>>     posted the
>>>>>>     > >>>> issue and was referred here.
>>>>>>     > >>>> 1)
>>>>>>     https://www.reddit.com/r/btrfs/comments/ejqhyq/any_hope_of_rec=
overing_from_various_errors_root/
>>>>>>     > >>>> 2)
>>>>>>     https://www.reddit.com/r/btrfs/comments/erh0f6/second_time_btr=
fs_root_started_remounting_as_ro/
>>>>>>     > >>>>
>>>>>>     > >>>> It has been suggested this is a hardware issue. I've al=
ready
>>>>>>     ordered a
>>>>>>     > >>>> replacement m2.sata, but for sanity it would be great t=
o know
>>>>>>     > >>>> definitively this was the case. If anything stands out =
above that
>>>>>>     > >>>> could indicate I'm not setup properly re. btrfs, that w=
ould
>>>>>>     also be
>>>>>>     > >>>> fantastic so I don't repeat the issue!
>>>>>>     > >>>>
>>>>>>     > >>>> The only thing I've stumbled on is that I have been mou=
nting with
>>>>>>     > >>>> rd.luks.options=3Ddiscard and that manually running fst=
rim is
>>>>>>     preferred.
>>>>>>     > >>>>
>>>>>>     > >>>>
>>>>>>     > >>>> Many thanks for any input/suggestions,
>>>>>>     > >>>> John
>>>>>>     > >>
>>>>>>     >
>>>>>>
>>>>>
>>


--iCVk7wyMnZgTEm21JIWa2P35NyfNOjpeM--

--uhdcsqvCR86H9O9SHDo6YCZTt2dZhqNLD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4/XzQACgkQwj2R86El
/qiVZQf/ejbgdjR6cB2853Hvi+7KN+T/wpTZTe2jcSZZcoGsz2GdmhOz4FdygYk5
YcxJWwQBVc5Q+S5/WpMLlg/8itJ2D3iRJXoMMTc2pP3cPZfKALaqcT4TMsBD7tXP
EIm+EKp3xSfFt+W/ndTGTYVmy6plxGK9m8KmxOyRyMVvTuGcCg1oOoUTCdUCuH33
swjB+Lj1uykQZiQLjS0HmGDguwcKyDuvyQVyMvxlO6ij3w46bHWrHsk1alBOzLig
LacM1+/eixw1Yw/+0Oj75p7f9D5ERO66FQPlrDtxyLpCLUO/yOnMuqZfq0gCVsf3
4o5ieeEWVhCQoOUmGwGhHvq2iHEIpw==
=ObBw
-----END PGP SIGNATURE-----

--uhdcsqvCR86H9O9SHDo6YCZTt2dZhqNLD--
