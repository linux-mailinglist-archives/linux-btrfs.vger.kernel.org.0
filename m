Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98367B30E6
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Sep 2023 12:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbjI2KzL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Sep 2023 06:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232993AbjI2KzK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Sep 2023 06:55:10 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D6811F
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Sep 2023 03:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
 t=1695984903; x=1696589703; i=quwenruo.btrfs@gmx.com;
 bh=xcrwNwO6vb+QDldoqpQn8Db58WSv9KFLnbacPcCNiOk=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=WVbv9My9/EBVcdLWkf0kG2p5zmRUOa1OvzIx3uLwiEG0IxJzWpQ7+AcGTpopC6TfpeCbZz+crSd
 OdDleKlTZYvASaMcSVBq3PuudyWM2EbC46Qmm2QfMeL7lYJ/5jFUD2MKvCPM3yxJW8q1zqNrEJqpX
 wB/ilqRaCBUB5+0Ya1xSz8GQz1KjOiVDQDKRM3odmLjjhoE51Do8+C6UqV7b1Lrqs33iDvP5VUxH3
 Iy6fnRPtP9EopqAHznV3I2CeUKhVf3MArRowoY6DvyYTDQlTbFt5BvSRyjSFnUx0U0kOARQ6INUkk
 TchGSeVn44wSYiGlWmt8MBMZFn+h/K7CdZAA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([218.215.59.251]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MPGW7-1r0pDv1kNR-00PaS1; Fri, 29
 Sep 2023 12:55:03 +0200
Message-ID: <a59ee960-f493-47d5-918d-4386a4deecd3@gmx.com>
Date:   Fri, 29 Sep 2023 20:24:59 +0930
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs-progs: fix failed resume due to bad search
Content-Language: en-US
To:     Konstantinos Skarlatos <k.skarlatos@gmail.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <840a9a762a3a0b8365d79dd7c23d812d95761dcf.1695855009.git.wqu@suse.com>
 <fc926390-38ea-f764-4377-25576b872b31@gmail.com>
 <e834fd8a-3c10-4b5c-9121-9812f460f73c@gmx.com>
 <c9fa7f88-5f3b-04f8-b18d-7d8490299538@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <c9fa7f88-5f3b-04f8-b18d-7d8490299538@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ClY5sgLifd0fKhuF9X1690c3XtjNa3CmSIVOJX+LCWlFO6U0EYO
 z1cavxXQUUdLac+Nz0zfSoclaZVyDgG/eB5GW5AS+6G/+cm2KwRcrh5e8aTAYFizm4BE3OS
 rLE9l8vJA9r6IU6fAxsxputP8ZYZ5EAHWbh9wv+pqs6tVfx0jUAiKnkuVsdiktB6/ceuNP0
 8ZsRBMTQcBIhbUnRfKeQQ==
UI-OutboundReport: notjunk:1;M01:P0:LIpA45GiGM0=;A1u3dcBo8FxpmGv8A8W1Qck0aaR
 LFC5y24+wvLZQYv+gBozJGctSTvuirGS1hTt1t0PSr28oX8czjMkXTOZoCPTOyDcaWVghe1v/
 9TWZJVrN0EJx5MasGsqDiSbhqGkBalDPJAGuRmF73njW7ukTy0ppuiORxwaenG+GWHFs+dAKy
 2QkIx8tGlmuuoBkYHH2M/rboDXvooUrP90ZY3OyeBfZjl8XpBLflxyN83zxbB76msTI81ke6g
 HyhZ84pc87iAkwkCQwC8LOP5w0Zg+odkSvOmU7Xfz7WLts5bwa0lizINM73MS0Ovx0I4E3J3J
 a01to65otnuE3FF4QAHjX7fpDwW9Z3SIFMBOf6vRUXJjFFp+K9zFPWKVn7FZrL/2X3z26S7UM
 YRNB5B2r+CWKERE88j6XcKOeBacs8yzYw8IUcYS82iTogIUvHCCLcMjMhCzQrDZeRJOZh7mco
 1iiWna9e5Teinbrs3+B13jq/dYbINRLEaUAz2dNsMoHj5sFTdCoab4ftov8U2sppiA/YxCgkO
 psHOIgFvNBTFj29ON/ZJ7LxPWyoTuhHeNH5OsG6sWsk+rbgq07CzauP5uairfXvgminVcH6iu
 cgIcgRNwzxK0bI7RrRpLcZDpft7D6a46i+OF0NENeCkmbNDOO2ZccHBKZbh/hxtBqZJL+HbEq
 LwIl/dkRcinvIL3AI/D5eei61YqbdrTOgMzf4Ndeq3ka9SZEurwgGjOqN5H0dfgO5yLos/TMu
 q3Nr5rCeLdXEHa2s6m9jtz2/8ReV2zFBUOa3UE0aUxObrntyZg/zpsE4gRbvT0gT0MmhY0BOj
 7tl7bA+UB2gmPtmJZ8I4MlYu3COutu7uI9QG8uO4gHv7BZjzT5f2Ri11vGdVaVeldYtWriJe1
 eaB2OWk9EHYMzCF2TYIR9FCTwxohIUKuE53uTMHqnVRBIIRYJwLqpA2zJrQ75ug6IUqKMsJQ+
 jz7FurEyx3QHoRCR3h0vjzo5u1Y=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/9/29 19:03, Konstantinos Skarlatos wrote:
> On 29/09/2023 12:56 =CF=80.=CE=BC., Qu Wenruo wrote:
>>
>>
>> On 2023/9/29 00:23, Konstantinos Skarlatos wrote:
>>> Hi Qu, thanks for your patch. I just tried it on a clean btrfs-progs
>>> tree with my filesystem:
>>>
>>> =E2=9D=AF ./btrfstune --convert-to-block-group-tree /dev/sda
>>> [1]=C2=A0=C2=A0=C2=A0 796483 segmentation fault (core dumped)=C2=A0 ./=
btrfstune
>>> --convert-to-block-group-tree /dev/sda
>>
>> Mind to enable debug build by "make D=3D1" for btrfs-progs, and go with
>> gdb to show the crash callback?
>>
>> I assume it could be the same crash from your initial report.
>>
>> Thanks,
>> Qu
>>
>
> Hi Qu, i hope i am doing this correctly...
>
>
> =E2=9D=AF gdb -ex=3Dr --args ./btrfstune --convert-to-block-group-tree /=
dev/sda
> GNU gdb (GDB) 13.2
> Copyright (C) 2023 Free Software Foundation, Inc.
> License GPLv3+: GNU GPL version 3 or later
> <http://gnu.org/licenses/gpl.html>
> This is free software: you are free to change and redistribute it.
> There is NO WARRANTY, to the extent permitted by law.
> Type "show copying" and "show warranty" for details.
> This GDB was configured as "x86_64-pc-linux-gnu".
> Type "show configuration" for configuration details.
> For bug reporting instructions, please see:
> <https://www.gnu.org/software/gdb/bugs/>.
> Find the GDB manual and other documentation resources online at:
>  =C2=A0=C2=A0=C2=A0 <http://www.gnu.org/software/gdb/documentation/>.
>
> For help, type "help".
> Type "apropos word" to search for commands related to "word"...
> Reading symbols from ./btrfstune...
> Starting program: /root/btrfs-progs/btrfstune
> --convert-to-block-group-tree /dev/sda
>
> This GDB supports auto-downloading debuginfo from the following URLs:
>  =C2=A0 <https://debuginfod.archlinux.org>
> Enable debuginfod for this session? (y or [n]) y
> Debuginfod has been enabled.
> To make this setting permanent, add 'set debuginfod enabled on' to .gdbi=
nit.
> Downloading separate debug info for /lib64/ld-linux-x86-64.so.2
> Downloading separate debug info for system-supplied DSO at 0x7ffff7fc800=
0
> Downloading separate debug info for /usr/lib/libuuid.so.1
> Downloading separate debug info for /usr/lib/libblkid.so.1
> Downloading separate debug info for /usr/lib/libudev.so.1
> Downloading separate debug info for /usr/lib/libc.so.6
> [Thread debugging using libthread_db enabled]
> Using host libthread_db library "/usr/lib/libthread_db.so.1".
> Downloading separate debug info for /usr/lib/libcap.so.2
>
> Program received signal SIGSEGV, Segmentation fault.
> 0x00005555555c6600 in cache_tree_comp_range (node=3D0xffffffffff000f0f,
> data=3D0x7fffffffd780) at common/extent-cache.c:40
> 40=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 if (entry->start + entry->size <=3D range->start)
> (gdb)

That's great, what about the output from "bt" command?

Thanks,
Qu
>
>
>
>
>>>
>>> Sep 28 17:46:17 elsinki kernel: btrfstune[796483]: segfault at
>>> ffffffffff000f2f ip 0000564b6c2107aa sp 00007ffdc8ad25c8 error 5 in
>>> btrfstune[564b6c1d1000+5b000] likely on CPU 3 (core 2, socket 0)
>>> Sep 28 17:46:17 elsinki kernel: Code: ff 48 8b 34 24 48 8d 3d 5a d8 01
>>> 00 b8 00 00 00 00 e8 5a 37 00 00 48 8b 33 bf 0a 00 00 00 e8 1d 0c fc f=
f
>>> eb a8 e8 86 0a fc ff <48> 8b 4f 20 48 8b 56 08 48 89 c8 48 03 47 28 48
>>> 89 c7 b8 01 00 00
>>> Sep 28 17:46:17 elsinki systemd[1]: Created slice Slice
>>> /system/systemd-coredump.
>>> Sep 28 17:46:17 elsinki systemd[1]: Started Process Core Dump (PID
>>> 796493/UID 0).
>>> Sep 28 17:46:21 elsinki systemd-coredump[796494]: [=F0=9F=A1=95] Proce=
ss 796483
>>> (btrfstune) of user 0 dumped core.
>>>
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 Stack trace of thread
>>> 796483:
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 #0 0x0000564b6c2107aa
>>> n/a (/root/btrfs-progs/btrfstune + 0x4d7aa)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ELF object binary
>>> architecture: AMD x86-64
>>> Sep 28 17:46:21 elsinki systemd[1]: systemd-coredump@0-796493-0.servic=
e:
>>> Deactivated successfully.
>>> Sep 28 17:46:21 elsinki systemd[1]: systemd-coredump@0-796493-0.servic=
e:
>>> Consumed 4.248s CPU time.
>>>
>>>
>>> On 28/9/2023 1:50 =CF=80.=CE=BC., Qu Wenruo wrote:
>>>> [BUG]
>>>> There is a bug report that when converting to bg tree crashed, the
>>>> resulted fs is unable to be resumed.
>>>>
>>>> This problems comes with the following error messages:
>>>>
>>>>  =C2=A0=C2=A0 ./btrfstune --convert-to-block-group-tree /dev/sda
>>>>  =C2=A0=C2=A0 ERROR: Corrupted fs, no valid METADATA block group foun=
d
>>>>  =C2=A0=C2=A0 ERROR: failed to delete block group item from the old r=
oot: -117
>>>>  =C2=A0=C2=A0 ERROR: failed to convert the filesystem to block group =
tree feature
>>>>  =C2=A0=C2=A0 ERROR: btrfstune failed
>>>>  =C2=A0=C2=A0 extent buffer leak: start 17825576632320 len 16384
>>>>
>>>> [CAUSE]
>>>> When resuming a interrupted conversion, we go through
>>>> read_converting_block_groups() to handle block group items in both
>>>> extent and block group trees.
>>>>
>>>> However for the block group items in the extent tree, there are sever=
al
>>>> problems involved:
>>>>
>>>> - Uninitialized @key inside read_old_block_groups_from_root()
>>>>  =C2=A0=C2=A0 Here we only set @key.type, not setting @key.objectid f=
or the
>>>> initial
>>>>  =C2=A0=C2=A0 search.
>>>>
>>>>  =C2=A0=C2=A0 Thus if we're unlukcy, we can got (u64)-1 as key.object=
id, and exit
>>>>  =C2=A0=C2=A0 the search immediately.
>>>>
>>>> - Wrong search direction
>>>>  =C2=A0=C2=A0 The conversion is converting block groups in descending=
 order,
>>>> but the
>>>>  =C2=A0=C2=A0 block groups read is in ascending order.
>>>>  =C2=A0=C2=A0 Meaning if we start from the last converted block group=
, we would at
>>>>  =C2=A0=C2=A0 most read one block group.
>>>>
>>>> [FIX]
>>>> To fix the problems, this patch would just remove
>>>> read_old_block_groups_from_root() function completely.
>>>>
>>>> As for the conversion, we ensured the block group item is either in t=
he
>>>> old extent or the new block group tree.
>>>> Thus there is no special handling needed reading block groups.
>>>>
>>>> We only need to read all block groups from both trees, using the same
>>>> read_old_block_groups_from_root() function.
>>>>
>>>> Reported-by: Konstantinos Skarlatos <k.skarlatos@gmail.com>
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>> ---
>>>> To Konstantinos:
>>>>
>>>> The bug I fixed here can explain all the failures you hit (the initia=
l
>>>> one and the one after the quick diff).
>>>>
>>>> Please verify if this helps and report back (without the quick diff i=
n
>>>> the original thread).
>>>>
>>>> We may have other corner cases to go, but I believe the patch itself =
is
>>>> necessary no matter what, as the deleted code is really
>>>> over-engineered and buggy.
>>>> ---
>>>>  =C2=A0 kernel-shared/extent-tree.c | 79
>>>> +------------------------------------
>>>>  =C2=A0 1 file changed, 1 insertion(+), 78 deletions(-)
>>>>
>>>> diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.=
c
>>>> index 7022643a9843..4d6bf2b228e9 100644
>>>> --- a/kernel-shared/extent-tree.c
>>>> +++ b/kernel-shared/extent-tree.c
>>>> @@ -2852,83 +2852,6 @@ out:
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>>>  =C2=A0 }
>>>> -/*
>>>> - * Helper to read old block groups items from specified root.
>>>> - *
>>>> - * The difference between this and read_block_groups_from_root() is,
>>>> - * we will exit if we have already read the last bg in the old root.
>>>> - *
>>>> - * This is to avoid wasting time finding bg items which should be
>>>> in the
>>>> - * new root.
>>>> - */
>>>> -static int read_old_block_groups_from_root(struct btrfs_fs_info
>>>> *fs_info,
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct =
btrfs_root *root)
>>>> -{
>>>> -=C2=A0=C2=A0=C2=A0 struct btrfs_path path =3D {0};
>>>> -=C2=A0=C2=A0=C2=A0 struct btrfs_key key;
>>>> -=C2=A0=C2=A0=C2=A0 struct cache_extent *ce;
>>>> -=C2=A0=C2=A0=C2=A0 /* The last block group bytenr in the old root. *=
/
>>>> -=C2=A0=C2=A0=C2=A0 u64 last_bg_in_old_root;
>>>> -=C2=A0=C2=A0=C2=A0 int ret;
>>>> -
>>>> -=C2=A0=C2=A0=C2=A0 if (fs_info->last_converted_bg_bytenr !=3D (u64)-=
1) {
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * We know the last =
converted bg in the other tree, load the
>>>> chunk
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * before that last =
converted as our last bg in the tree.
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ce =3D search_cache_exten=
t(&fs_info->mapping_tree.cache_tree,
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fs_info->last_conve=
rted_bg_bytenr);
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!ce || ce->start !=3D=
 fs_info->last_converted_bg_bytenr) {
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 e=
rror("no chunk found for bytenr %llu",
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fs_info->last_converted_bg_bytenr);
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
eturn -ENOENT;
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ce =3D prev_cache_extent(=
ce);
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * We should have pr=
evious unconverted chunk, or we have
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * already finished =
the convert.
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ASSERT(ce);
>>>> -
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 last_bg_in_old_root =3D c=
e->start;
>>>> -=C2=A0=C2=A0=C2=A0 } else {
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 last_bg_in_old_root =3D (=
u64)-1;
>>>> -=C2=A0=C2=A0=C2=A0 }
>>>> -
>>>> -=C2=A0=C2=A0=C2=A0 key.type =3D BTRFS_BLOCK_GROUP_ITEM_KEY;
>>>> -
>>>> -=C2=A0=C2=A0=C2=A0 while (true) {
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D find_first_block_=
group(root, &path, &key);
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret > 0) {
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
et =3D 0;
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g=
oto out;
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret !=3D 0) {
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g=
oto out;
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_item_key_to_cpu(pat=
h.nodes[0], &key, path.slots[0]);
>>>> -
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D read_one_block_gr=
oup(fs_info, &path);
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0 && ret !=3D -=
ENOENT)
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g=
oto out;
>>>> -
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* We have reached last b=
g in the old root, no need to
>>>> continue */
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (key.objectid >=3D las=
t_bg_in_old_root)
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 b=
reak;
>>>> -
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (key.offset =3D=3D 0)
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 k=
ey.objectid++;
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 k=
ey.objectid =3D key.objectid + key.offset;
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 key.offset =3D 0;
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_release_path(&path)=
;
>>>> -=C2=A0=C2=A0=C2=A0 }
>>>> -=C2=A0=C2=A0=C2=A0 ret =3D 0;
>>>> -out:
>>>> -=C2=A0=C2=A0=C2=A0 btrfs_release_path(&path);
>>>> -=C2=A0=C2=A0=C2=A0 return ret;
>>>> -}
>>>> -
>>>>  =C2=A0 /* Helper to read all block groups items from specified root.=
 */
>>>>  =C2=A0 static int read_block_groups_from_root(struct btrfs_fs_info *=
fs_info,
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 struct btrfs_root *root)
>>>> @@ -2989,7 +2912,7 @@ static int read_converting_block_groups(struct
>>>> btrfs_fs_info *fs_info)
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> -=C2=A0=C2=A0=C2=A0 ret =3D read_old_block_groups_from_root(fs_info, =
old_root);
>>>> +=C2=A0=C2=A0=C2=A0 ret =3D read_block_groups_from_root(fs_info, old_=
root);
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error("failed=
 to load block groups from the old root: %d",
>>>> ret);
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>
