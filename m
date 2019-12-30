Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02CA312CDD0
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Dec 2019 09:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbfL3Iyx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Dec 2019 03:54:53 -0500
Received: from mout.gmx.net ([212.227.17.22]:51603 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727162AbfL3Iyx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Dec 2019 03:54:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1577696090;
        bh=Ny9AVYik/uUHPxSJls6WsDOKU7qWEj3cUHR+vyK91VE=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=fl689MN/hlNyq++l1bWBdwGLf2jqKao/Htgl7OquBuwzl6oacQYl+RfvJqBwHCo3l
         KXCPbZVKA3g4QrHWb8cMS01rMHa6L5GwDXbgVXjSjbaW7biE0ZgKOK2z62NYwTybR2
         U/+sq1sFx/sS3duuIaKMG3GtRiux5HrbLJnV1iWw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N7zFj-1jpzyM2BO7-0154rP; Mon, 30
 Dec 2019 09:54:50 +0100
Subject: Re: read time tree block corruption detected
To:     Patrick Erley <pat-lkml@erley.org>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAOB=O_jxu5JOe=JiYVW_VZ1rgs9+mdHpAHkscXkc4MVRLrBKDw@mail.gmail.com>
 <4bf17941-2ab0-15ca-b4c9-f6ba037624ee@gmx.com>
 <CAOB=O_jfwBVihtbNTF1xLNWNtf2_Mi=Bs_BCZ8VnXOKWosw7uQ@mail.gmail.com>
 <66d35620-160e-105a-6970-03c3de3f7c78@gmx.com>
 <CAOB=O_jpg0K4eDARfG+XDDRMHhm+yKp8XfhjqHsFxAswSPUfdQ@mail.gmail.com>
 <CAOB=O_hdjpNtNtMMi93CFh3wO048SDVxMgBQd_pC0wx0C_49Ug@mail.gmail.com>
 <a2f28c83-01c0-fce7-5332-2e9331f3c3df@gmx.com>
 <CAOB=O_gBBjT9EVduHWHbF8iOsA8ua-ZGGh4s1x6Lia24LAZEMg@mail.gmail.com>
 <4c06d3a9-7f09-c97c-a6f3-c7f7419d16a7@gmx.com>
 <CAOB=O_i=ZDZw92ty9HUeobV1J4FA8LNRCkPKkJ1CVrzHxAieuw@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <27a9570c-70cc-19b6-3f5f-cd261040a67c@gmx.com>
Date:   Mon, 30 Dec 2019 16:54:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CAOB=O_i=ZDZw92ty9HUeobV1J4FA8LNRCkPKkJ1CVrzHxAieuw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="78LmIyCukfz9UeUYEeYvwy5fOsCPtDq3B"
X-Provags-ID: V03:K1:Qf+qckjgadUmpNAr3U+EwYBmyJGxBZPe1Xg83n5UfBjknk2Cwdh
 +xx06znXRP9lQbT6uJx6x6YSNrg+IVGqT+AE2gMPfWmI1exBqylMbkoy2HYut4mGxjxk2Pn
 Bz0UKb5RwNbSFmY+Pk1WOiSMy6IkijXzbHPVIkmtj2dYQiJ5ocG/kjJFqlEHmVc9ezz3FFC
 XFmG5T5kU3ytd+/Rd4HOw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:3vyjaihXbxE=:okG0rE3WvajqcMgLXjJtmh
 m68Kywvy+DF5TfBrMcZ+dm6tWid3AfNbeKlhgJYoWa5b2TDa9YfxaNaJGrxtcW1f1+loNpAK2
 Q5ECnIgM9XGubBJN5sSKAgE4T36WxTeCVbg6wOwa0+P//51WuQ61hh9602C7X8WGpfmppvSIk
 pL+Y8WBwEmr/sr1/63YeOPv3R5IIT4EXUiAuJJGoq7TVa1sXUZULsrcEtMpIzvQfXlK/f9EI/
 r267kAaXLZD12gCPSSJKimvKb4r3kPqI8apxn+/vGaaWivTLJnioaW6Kvv8ORdvnWw/hGG0x1
 VDXh0aPBy16ZXbxZeKOvOvDU+Yep8i8+wp332nW5P8v8vf32lpj2runYqBEHIG5BYrDL3WDi8
 DzaxrWbeQNbUsLw5W96W0MB/VJOmdHqc8ZwAXS8RmMD8ogwxHKuRoUAXUGmd/hvgeT2Gu1Lox
 MD8EMPvluv+C/SudfQETZGsOCN4HsjWU20WjuKAmVi6ZJ4e/3/8OQ3J02hiZAV7K5lsOsAWHO
 +GWSf9q0VE4ay+IOiw+X296xSEj97eeh6dElvoawusG93WA0lyDztyUg4s2ZZX6cRntQSlnqD
 awTRZOHCLSQjul//S+0eogr8GNiEoeqtqBr07Uv/oUbf4PIGP+IU0ac4A+UI1UaUot1Uxmq74
 yP3gb0kRXOnWY7nbcpO1cXUUTlwfhkfq39Qhhq7OPQinC17hPUT15mMna8rIPO6mXySm9XcZn
 H5m7iXHAtp5Q3kgrfbTstt2DXfUDa4ZZN5d7F5EEI7HM/JLiAVIc29DJz+qdy4i4LkU4LnJNv
 89VqBzZKukyPGppO210EBBjZRcUDKgqCYEL8Mx00smiXI2s4kn1OsrD38Y2FAy9Ui5OPgr7Lc
 +b8QsJsHRjHBxWom7CJpiNQA1vmeQZvCRgYQKvDTJB9qre6NQ0SJ47+2z9m9ue7DfcmueoCVd
 tjkC2z+cI1dG8AqNgx4/hcb/HV1PCcHct/9zMBn5yMXeL+dZAaLw8QKi6+VUIeLjfHGmFyoa+
 U/0UCUo6eVmNXC0cOrLWWN2TyAg87G6MUFBWIt2989i8VNGkdw2fTCqEwiShoE9yccSG7V8rO
 0Qf1z0gXROXKv0SRutKJP3+6wgmrL6wtnw5cMcgaEDUgqKYHpruhH7lxd12O5+R0XD5qPO8Nr
 3HwL7bD0dPJ6kQQHOP6EHyYQlLRF7kHEyn+qLJqbN75N/aLeFPGEry3vxSfWWLDr6Yv/WtBv8
 GMUNiZHzpnAd+aUku1zQtHoNR3LcxqCy0MsIHNLuJDYARAXLis4koaQnFmFQ=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--78LmIyCukfz9UeUYEeYvwy5fOsCPtDq3B
Content-Type: multipart/mixed; boundary="l16JtkGdX2HdHGvvp3ZllS23OwG9LN1DX"

--l16JtkGdX2HdHGvvp3ZllS23OwG9LN1DX
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/12/30 =E4=B8=8B=E5=8D=884:14, Patrick Erley wrote:
> On Mon, Dec 30, 2019 at 6:09 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrot=
e:
>>
>>
>>
>> On 2019/12/30 =E4=B8=8B=E5=8D=882:07, Patrick Erley wrote:
>>> On Sun, Dec 29, 2019 at 9:58 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wr=
ote:
>>>>
>>>>
>>>>
>>>> On 2019/12/30 =E4=B8=8B=E5=8D=881:50, Patrick Erley wrote:
>>>>> On Sun, Dec 29, 2019 at 9:47 PM Patrick Erley <pat-lkml@erley.org> =
wrote:
>>>>>>
>>>>>> On Sun, Dec 29, 2019 at 9:43 PM Qu Wenruo <quwenruo.btrfs@gmx.com>=
 wrote:
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> On 2019/12/30 =E4=B8=8B=E5=8D=881:36, Patrick Erley wrote:
>>>>>>>> (ugh, just realized gmail does top replies.  Sorry... will try t=
o
>>>>>>>> figure out how to make gsuite behave like a sane mail client bef=
ore my
>>>>>>>> next reply):
>>>>>>>>
>>>>>>>> here's btrfs check /dev/nvme0n1p2 (sda3, which is a mirror of it=
, has
>>>>>>>> exactly the same output)
>>>>>>>>
>>>>>>>> [1/7] checking root items
>>>>>>>> [2/7] checking extents
>>>>>>>> [3/7] checking free space cache
>>>>>>>> [4/7] checking fs roots
>>>>>>>> [5/7] checking only csums items (without verifying data)
>>>>>>>> [6/7] checking root refs
>>>>>>>> [7/7] checking quota groups skipped (not enabled on this FS)
>>>>>>>> Opening filesystem to check...
>>>>>>>> Checking filesystem on /dev/nvme0n1p2
>>>>>>>> UUID: 815266d6-a8b9-4f63-a593-02fde178263f
>>>>>>>> found 89383137280 bytes used, no error found
>>>>>>>> total csum bytes: 85617340
>>>>>>>> total tree bytes: 1670774784
>>>>>>>> total fs tree bytes: 1451180032
>>>>>>>> total extent tree bytes: 107905024
>>>>>>>> btree space waste bytes: 413362851
>>>>>>>> file data blocks allocated: 90769887232
>>>>>>>>  referenced 88836960256
>>>>>>>
>>>>>>> It looks too good to be true, is the btrfs-progs v5.4? IIRC in v5=
=2E4 we
>>>>>>> should report inodes generation problems.
>>>>>>
>>>>>> Hurray Bottom Reply?
>>>>>>
>>>>>> /usr/src/initramfs/bin $ ./btrfs.static --version
>>>>>> btrfs-progs v5.4
>>>>
>>>> This is strange.
>>>>
>>>>
>>>> 6084adam|thinkpad|~$ btrfs check --mode=3Dlowmem test.img
>>>> Opening filesystem to check...
>>>> Checking filesystem on test.img
>>>> UUID: c6c6ddd2-01c1-47fc-b699-cacfae9d4bfd
>>>> [1/7] checking root items
>>>> [2/7] checking extents
>>>> [3/7] checking free space cache
>>>> cache and super generation don't match, space cache will be invalida=
ted
>>>> [4/7] checking fs roots
>>>> ERROR: invalid inode generation for ino 257, have 885834456838809167=
1
>>>> expect [0, 9)
>>>> ERROR: errors found in fs roots
>>>> found 131072 bytes used, error(s) found
>>>> total csum bytes: 0
>>>> total tree bytes: 131072
>>>> total fs tree bytes: 32768
>>>> total extent tree bytes: 16384
>>>> btree space waste bytes: 123409
>>>> file data blocks allocated: 0
>>>>  referenced 0
>>>> 6085adam|thinkpad|~$ btrfs --version
>>>> btrfs-progs v5.4
>>>>
>>>> As expected, v5.4 should detect such problem without problem.
>>>>
>>>> Would you please provide extra tree dump to help us to determine wha=
t
>>>> makes btrfs check unable to detect such problems?
>>>>
>>>> # btrfs ins dump-tree -b 303629811712 /dev/dm-1
>>> anvil ~ # btrfs ins dump-tree -b 303629811712 /dev/nvme0n1p2
>>> btrfs-progs v5.4
>>> Invalid mapping for 303629811712-303629815808, got 476092633088-47716=
6374912
>>> Couldn't map the block 303629811712
>>> Couldn't map the block 303629811712
>>> bad tree block 303629811712, bytenr mismatch, want=3D303629811712, ha=
ve=3D0
>>> ERROR: failed to read tree block 303629811712
>>>
>> The bytenr is different from your initial report.
>>
>> Anyway, you can try mount with v5.4, and use the bytenr from the dmesg=
=2E
>>
>> Then please provide both dmeg (including the "corrupted leaf" line), a=
nd
>> the `btrfs ins dump-tree -b` output.
>>
>> Thanks,
>> Qu
>>
>=20
> Good news and bad news.  Running btrfs check --repair fixed the errors
> listed in $subject, but seems to have fully hosed te filesystem.  I'm
> now getting:
>=20
> ./btrfs.static check /dev/nvme0n1p2
> Opening filesystem to check...
> Checking filesystem on /dev/nvme0n1p2
> UUID: 815266d6-a8b9-4f63-a593-02fde178263f
> [1/7] checking root items
> parent transid verify failed on 499774480384 wanted 3323349 found 33233=
40
> parent transid verify failed on 499774386176 wanted 3323349 found 33233=
40
> parent transid verify failed on 499774394368 wanted 3323349 found 33233=
40
> parent transid verify failed on 499774398464 wanted 3323349 found 33233=
40
> parent transid verify failed on 499774406656 wanted 3323349 found 33233=
40
> parent transid verify failed on 499774423040 wanted 3323349 found 33233=
40
> parent transid verify failed on 499774427136 wanted 3323349 found 33233=
40
> parent transid verify failed on 499774439424 wanted 3323349 found 33233=
40
> parent transid verify failed on 499774324736 wanted 3323349 found 33233=
40
> parent transid verify failed on 499774513152 wanted 3323349 found 33233=
40
> parent transid verify failed on 499774341120 wanted 3323349 found 33233=
40
> [2/7] checking extents
> leaf parent key incorrect 499774554112
> bad block 499774554112
> ERROR: errors found in extent allocation tree or chunk allocation
> [3/7] checking free space cache
> there is no free space entry for 499922907136-499952799744
> there is no free space entry for 499922907136-500822249472
> cache appears valid but isn't 499748507648
> [4/7] checking fs roots
> Wrong key of child node/leaf, wanted: (1442047, 1, 0), have:
> (523365974016, 168, 16384)
> root 5 inode 1442047 errors 2001, no inode item, link count wrong
>     unresolved ref dir 256 index 0 namelen 3 name etc filetype 2
> errors 6, no dir index, no inode ref
> root 5 inode 1835263 errors 2001, no inode item, link count wrong
>     unresolved ref dir 256 index 0 namelen 3 name bin filetype 2
> errors 6, no dir index, no inode ref
> root 5 inode 1966335 errors 2001, no inode item, link count wrong
>     unresolved ref dir 256 index 0 namelen 4 name proc filetype 2
> errors 6, no dir index, no inode ref
> root 5 inode 2097407 errors 2001, no inode item, link count wrong
>     unresolved ref dir 256 index 0 namelen 5 name lib32 filetype 2
> errors 6, no dir index, no inode ref
> root 5 inode 2228479 errors 2001, no inode item, link count wrong
>     unresolved ref dir 256 index 0 namelen 3 name sys filetype 2
> errors 6, no dir index, no inode ref
> root 5 inode 2359551 errors 2001, no inode item, link count wrong
>     unresolved ref dir 256 index 0 namelen 5 name lib64 filetype 2
> errors 6, no dir index, no inode ref
> root 5 inode 3145983 errors 2001, no inode item, link count wrong
>     unresolved ref dir 256 index 0 namelen 3 name dev filetype 2
> errors 6, no dir index, no inode ref
> root 5 inode 3277055 errors 2001, no inode item, link count wrong
>     unresolved ref dir 256 index 0 namelen 3 name opt filetype 2
> errors 6, no dir index, no inode ref
> root 5 inode 3408127 errors 2001, no inode item, link count wrong
>     unresolved ref dir 256 index 0 namelen 3 name mnt filetype 2
> errors 6, no dir index, no inode ref
> root 5 inode 3539199 errors 2001, no inode item, link count wrong
>     unresolved ref dir 256 index 0 namelen 3 name usr filetype 2
> errors 6, no dir index, no inode ref
> root 5 inode 3670271 errors 2001, no inode item, link count wrong
>     unresolved ref dir 256 index 0 namelen 5 name media filetype 2
> errors 6, no dir index, no inode ref
> root 5 inode 4587775 errors 2001, no inode item, link count wrong
>     unresolved ref dir 256 index 0 namelen 4 name sbin filetype 2
> errors 6, no dir index, no inode ref
> root 5 inode 4980991 errors 2001, no inode item, link count wrong
>     unresolved ref dir 256 index 0 namelen 4 name etc2 filetype 2
> errors 6, no dir index, no inode ref
> root 5 inode 4984678 errors 2001, no inode item, link count wrong
>     unresolved ref dir 256 index 0 namelen 3 name run filetype 2
> errors 6, no dir index, no inode ref
> root 5 inode 5505279 errors 2001, no inode item, link count wrong
>     unresolved ref dir 256 index 0 namelen 7 name exports filetype 2
> errors 6, no dir index, no inode ref
> root 5 inode 5767423 errors 2001, no inode item, link count wrong
>     unresolved ref dir 256 index 0 namelen 5 name debug filetype 2
> errors 6, no dir index, no inode ref
> root 5 inode 5898495 errors 2001, no inode item, link count wrong
>     unresolved ref dir 256 index 0 namelen 4 name etc3 filetype 2
> errors 6, no dir index, no inode ref
> root 5 inode 6029567 errors 2001, no inode item, link count wrong
>     unresolved ref dir 256 index 0 namelen 4 name root filetype 2
> errors 6, no dir index, no inode ref
> root 5 inode 6431345 errors 2001, no inode item, link count wrong
>     unresolved ref dir 256 index 0 namelen 4 name boot filetype 2
> errors 6, no dir index, no inode ref
> root 5 inode 6553855 errors 2001, no inode item, link count wrong
>     unresolved ref dir 256 index 0 namelen 3 name var filetype 2
> errors 6, no dir index, no inode ref
> root 5 inode 7602431 errors 2001, no inode item, link count wrong
>     unresolved ref dir 256 index 0 namelen 3 name tmp filetype 2
> errors 6, no dir index, no inode ref
> root 5 inode 9133291 errors 2001, no inode item, link count wrong
>     unresolved ref dir 256 index 0 namelen 13 name .pulse-cookie
> filetype 1 errors 6, no dir index, no inode ref
> root 5 inode 9133292 errors 2001, no inode item, link count wrong
>     unresolved ref dir 256 index 0 namelen 6 name .pulse filetype 2
> errors 6, no dir index, no inode ref
> root 5 inode 9980485 errors 2001, no inode item, link count wrong
>     unresolved ref dir 256 index 0 namelen 9 name bootchart filetype 2
> errors 6, no dir index, no inode ref
> root 5 inode 10254180 errors 2001, no inode item, link count wrong
>     unresolved ref dir 256 index 0 namelen 4 name temp filetype 2
> errors 6, no dir index, no inode ref
> root 5 inode 11827458 errors 2001, no inode item, link count wrong
>     unresolved ref dir 256 index 0 namelen 8 name tftpboot filetype 2
> errors 6, no dir index, no inode ref
> root 5 inode 14435353 errors 2001, no inode item, link count wrong
>     unresolved ref dir 131327 index 0 namelen 4 name s0be filetype 2
> errors 6, no dir index, no inode ref
> root 5 inode 14646004 errors 2001, no inode item, link count wrong
>     unresolved ref dir 256 index 0 namelen 4 name s0be filetype 2
> errors 6, no dir index, no inode ref
> root 5 inode 14910590 errors 2001, no inode item, link count wrong
>     unresolved ref dir 256 index 0 namelen 13 name .bash_history
> filetype 1 errors 6, no dir index, no inode ref
> root 5 inode 23438027 errors 2001, no inode item, link count wrong
>     unresolved ref dir 256 index 0 namelen 8 name mknod.sh filetype 1
> errors 6, no dir index, no inode ref
> root 5 inode 25548332 errors 2001, no inode item, link count wrong
>     unresolved ref dir 256 index 0 namelen 8 name ctrl_dir filetype 1
> errors 6, no dir index, no inode ref
> root 5 inode 25548333 errors 2001, no inode item, link count wrong
>     unresolved ref dir 256 index 0 namelen 5 name state filetype 1
> errors 6, no dir index, no inode ref
> root 5 inode 26407893 errors 2001, no inode item, link count wrong
>     unresolved ref dir 256 index 0 namelen 6 name e2fsck filetype 1
> errors 6, no dir index, no inode ref
> root 5 inode 36767707 errors 2001, no inode item, link count wrong
>     unresolved ref dir 924630 index 0 namelen 31 name
> lib_mysqludf_log-warnings.patch filetype 1 errors 6, no dir index, no
> inode ref
> root 5 inode 36767712 errors 2001, no inode item, link count wrong
>     unresolved ref dir 924632 index 0 namelen 32 name
> lib_mysqludf_stem-mysql_m4.patch filetype 1 errors 6, no dir index, no
> inode ref
> root 5 inode 36767838 errors 2001, no inode item, link count wrong
>     unresolved ref dir 924633 index 0 namelen 33 name
> mysql-udf-base64-signedness.patch filetype 1 errors 6, no dir index,
> no inode ref
> root 5 inode 36767839 errors 2001, no inode item, link count wrong
>     unresolved ref dir 924633 index 0 namelen 20 name
> mysql-udf-base64.sql filetype 1 errors 6, no dir index, no inode ref
> root 5 inode 36767840 errors 2001, no inode item, link count wrong
>     unresolved ref dir 924634 index 0 namelen 27 name
> mysql-udf-http-stdlib.patch filetype 1 errors 6, no dir index, no
> inode ref
> root 5 inode 36767843 errors 2001, no inode item, link count wrong
>     unresolved ref dir 924635 index 0 namelen 29 name
> mysql-udf-ipv6-warnings.patch filetype 1 errors 6, no dir index, no
> inode ref
> root 5 inode 37030378 errors 2001, no inode item, link count wrong
>     unresolved ref dir 924616 index 0 namelen 12 name metadata.xml
> filetype 1 errors 6, no dir index, no inode ref
> root 5 inode 37030384 errors 2001, no inode item, link count wrong
>     unresolved ref dir 924619 index 0 namelen 12 name metadata.xml
> filetype 1 errors 6, no dir index, no inode ref
> root 5 inode 37030490 errors 2001, no inode item, link count wrong
>     unresolved ref dir 924625 index 0 namelen 12 name metadata.xml
> filetype 1 errors 6, no dir index, no inode ref
> root 5 inode 37030492 errors 2001, no inode item, link count wrong
>     unresolved ref dir 924626 index 0 namelen 12 name metadata.xml
> filetype 1 errors 6, no dir index, no inode ref
> root 5 inode 37030497 errors 2001, no inode item, link count wrong
>     unresolved ref dir 924628 index 0 namelen 12 name metadata.xml
> filetype 1 errors 6, no dir index, no inode ref
> root 5 inode 39198776 errors 2001, no inode item, link count wrong
>     unresolved ref dir 256 index 0 namelen 8 name bootback filetype 2
> errors 6, no dir index, no inode ref
> root 5 inode 51520157 errors 2001, no inode item, link count wrong
>     unresolved ref dir 924616 index 0 namelen 29 name
> lib_mysqludf_log-0.0.2.ebuild filetype 1 errors 6, no dir index, no
> inode ref
> root 5 inode 51520163 errors 2001, no inode item, link count wrong
>     unresolved ref dir 924619 index 0 namelen 30 name
> lib_mysqludf_stem-0.9.1.ebuild filetype 1 errors 6, no dir index, no
> inode ref
> root 5 inode 51520278 errors 2001, no inode item, link count wrong
>     unresolved ref dir 924625 index 0 namelen 32 name
> mysql-udf-base64-20010618.ebuild filetype 1 errors 6, no dir index, no
> inode ref
> root 5 inode 51520280 errors 2001, no inode item, link count wrong
>     unresolved ref dir 924626 index 0 namelen 25 name
> mysql-udf-http-1.0.ebuild filetype 1 errors 6, no dir index, no inode
> ref
> root 5 inode 51520284 errors 2001, no inode item, link count wrong
>     unresolved ref dir 924628 index 0 namelen 25 name
> mysql-udf-ipv6-0.4.ebuild filetype 1 errors 6, no dir index, no inode
> ref
> root 5 inode 58792107 errors 2001, no inode item, link count wrong
>     unresolved ref dir 256 index 0 namelen 3 name foo filetype 1
> errors 6, no dir index, no inode ref
> root 5 inode 63681251 errors 2001, no inode item, link count wrong
>     unresolved ref dir 256 index 0 namelen 4 name xpra filetype 2
> errors 6, no dir index, no inode ref
> root 5 inode 66715793 errors 2001, no inode item, link count wrong
>     unresolved ref dir 256 index 0 namelen 8 name .viminfo filetype 1
> errors 6, no dir index, no inode ref
> root 5 inode 71469207 errors 2001, no inode item, link count wrong
>     unresolved ref dir 924616 index 0 namelen 8 name Manifest filetype
> 1 errors 6, no dir index, no inode ref
> root 5 inode 71469208 errors 2001, no inode item, link count wrong
>     unresolved ref dir 924619 index 0 namelen 8 name Manifest filetype
> 1 errors 6, no dir index, no inode ref
> root 5 inode 71469238 errors 2001, no inode item, link count wrong
>     unresolved ref dir 924625 index 0 namelen 8 name Manifest filetype
> 1 errors 6, no dir index, no inode ref
> root 5 inode 71469239 errors 2001, no inode item, link count wrong
>     unresolved ref dir 924626 index 0 namelen 8 name Manifest filetype
> 1 errors 6, no dir index, no inode ref
> root 5 inode 71469240 errors 2001, no inode item, link count wrong
>     unresolved ref dir 924628 index 0 namelen 8 name Manifest filetype
> 1 errors 6, no dir index, no inode ref
> root 5 inode 75334150 errors 2001, no inode item, link count wrong
>     unresolved ref dir 256 index 0 namelen 7 name lib.new filetype 2
> errors 6, no dir index, no inode ref
> root 5 inode 77351088 errors 2001, no inode item, link count wrong
>     unresolved ref dir 256 index 0 namelen 3 name lib filetype 7
> errors 6, no dir index, no inode ref
> ERROR: errors found in fs roots
> found 951992320 bytes used, error(s) found
> total csum bytes: 0
> total tree bytes: 3895296
> total fs tree bytes: 0
> total extent tree bytes: 3813376
> btree space waste bytes: 1560917
> file data blocks allocated: 27983872
>  referenced 27983872
>=20
> Should I also paste in the repair log?
>=20
Yes please.

This sounds very strange, especially for the transid mismatch part.

Thanks,
Qu


--l16JtkGdX2HdHGvvp3ZllS23OwG9LN1DX--

--78LmIyCukfz9UeUYEeYvwy5fOsCPtDq3B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4Ju1YXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qjXgQf/U40p5tWdhdX3P3Si8KpjWK96
+VkU+QeUe7aQyx00VAa6Hn0iNFZIAQo4Oab515f/z+Za3Yx3fsx27vFCFkU0LROV
IoQJwem8LlXI1Kutipy+kUrKBVwR9fZizsB9R1Sh3qP3wbjjOPLgGbSCRMK8x7Cc
+meMC+TC+j4CkIeKybJhq/Bcu5u8ZNOeCDhNh98xrTip/l9HTax+213ulY4xq4H5
dJMeLs1ADUAubzA2weH36BzAmvsyVPc37KnrB8iFJSpsuJjDDedGqXs2YeMjW4OK
KtHDeooJ3XRrj3e8Z+mVkS28AeAiIQMf1q1Z5TffpVE4eN92fb8QRJH2Gfe0Hw==
=Tvol
-----END PGP SIGNATURE-----

--78LmIyCukfz9UeUYEeYvwy5fOsCPtDq3B--
