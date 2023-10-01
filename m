Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B94A7B4A57
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Oct 2023 01:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbjJAXdZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 1 Oct 2023 19:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjJAXdY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 1 Oct 2023 19:33:24 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334E6BD
        for <linux-btrfs@vger.kernel.org>; Sun,  1 Oct 2023 16:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
 t=1696203195; x=1696807995; i=quwenruo.btrfs@gmx.com;
 bh=eWbhAqpcenpE34v+p7rV3sliRjyIQmIGvoOrcwSZaDM=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=aDFuiS+ojbfmtMrguQ4f4oDYs1A9FLIOaQ3LVHq6bcYa6WJ8z3pt0A1rd5k0PDVVMGzK4kyEE+T
 yrOrrhwv0Z8rBsgVUjhgd3PB8P0JL2ACuJ3Lb6c5gzhE1orW/4M4bF7v7efgLzCedqKWUKTHCXXFl
 gTL0wr2IQIZlNN+ualF6yeuTy8JgcNzVXpABXXBOAdHWlrknpQR3q1ZkcUhh5TzfHMGTpj7h9zJbg
 0eKUTDuTxoqKDmq6JBeKpH+dcwiJwGVUk993xemxxd64oVaM+MS6T8e5lindPof8TMHCAr1wjCTki
 quG7RAY0N94UcxpZSaBbP7fOam+HAmFjjgMQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([218.215.59.251]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N0oBx-1rb5ot2Hq9-00wqJq; Mon, 02
 Oct 2023 01:33:15 +0200
Message-ID: <77b9d0ba-f0b0-4258-8336-d3687d204967@gmx.com>
Date:   Mon, 2 Oct 2023 10:03:10 +1030
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs-progs: fix failed resume due to bad search
To:     Konstantinos Skarlatos <k.skarlatos@gmail.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <840a9a762a3a0b8365d79dd7c23d812d95761dcf.1695855009.git.wqu@suse.com>
 <fc926390-38ea-f764-4377-25576b872b31@gmail.com>
 <e834fd8a-3c10-4b5c-9121-9812f460f73c@gmx.com>
 <c9fa7f88-5f3b-04f8-b18d-7d8490299538@gmail.com>
 <a59ee960-f493-47d5-918d-4386a4deecd3@gmx.com>
 <a7404485-0a85-49c2-afb8-769ad112dd8b@gmail.com>
 <cd390b15-7d42-41be-afc6-22c6fa22671d@gmx.com>
 <35bc07b9-2e6c-0848-661c-8e991cb5479a@gmail.com>
 <17ed25c0-9a96-456b-a998-6e7d8e5ad113@gmx.com>
 <c7856278-f7c0-6ed5-1535-8013f1e658d1@gmail.com>
Content-Language: en-US
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
In-Reply-To: <c7856278-f7c0-6ed5-1535-8013f1e658d1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8yzecTTkkkNBMGBznc/FMe/ffjnevPkZPfgJuXT9othswX5Ru4U
 1oljIlhrJthjCV6jW6z5NaMwM+YOWlTdiiuhfrdmhsqo1FeCuWR/p674K3VDnK8KA3VZDIw
 gh3k754J+cxIAWd9zVj54tFgBH8zhUA6lN3a4Q0tngEoPI6T93Wg+4lIjKh/Q3Gc5lfAWit
 6F3HFjfg8wZgZs78mq+vA==
UI-OutboundReport: notjunk:1;M01:P0:2+jns+NbDLw=;Lyz1+D2IKC85j4l8z/OKECEcf2g
 aANrktPnL6sXOZK0lJaKDZi4Ctae9HnfqaOz7xcOQjE/dGXO9ecod/rwjZ8VHZhRjDoqBEbIh
 IOkZMLb7kVvnEr1SshtmReLdHDcA14u7fpmkBFy+b5s0wdjFas7FcrjjfzJqf27xtGddvHZm2
 SLd4ofj24jggFT87Mifqj8ECvv3kb7zOS51lpp2zEwn7LAHjaFwCvWzjxkIFUVAE2ozykwtOU
 juBj2ciWp1yKAlfSsqqavef7Hb2Dr+cyEj2pCov0845px/sCDv2jNv4zymj1saf3sZ3N+dycu
 Frtj4PozUlevnjy5bHmtwyk2MoFCLY/55VSOHo0hkHVpdRPDbzESZiIgTyQ0qpCdO7os7EEs4
 tLmUFFH5R9rUNnpPiPA2hO3jci5//6wJA3xKr9WJkNrVE4+uuBjB7b+i6PS5kxofXAL1zcsBx
 N0A+d5gmjheRMUlBqKj9PP9w/p0+L/WFxr39by+UphmwBiaUQhK/TagvBD4111BdYqA9bTeRh
 rm3gyytwdfHsEG1DWt7XZ5fv61Mcq8EFv1Rdavt0ecX3UJ8fLB91s5ayPtzCIsfPSOvyMQr3b
 1HZCV6Ct5cdxDJtTeCt1r050hTLVKUXMAj+wkcoxWapG+F6ajngwBRWxNRgiqrcbqOmuiasW9
 Djy4jQTSuzPA6vOHNZz4ydrXrsJoUWmDf+rfEJKAzffvNANqzZHbF02Q4O001VoyrLYsPy1P+
 E8dIzO96hYq1RppnV6iizfH4H8ZCByeWR3Yt/Ct9Y4dH7kZKf9RmvU8X2OE8gubBfVSx0H6nI
 Xv6VI66Vr4a8cBBHaZKMQBlnhufY/YYDkbeUXJWZuyijZhPZc20Sbwbj9rQmQ2Wzbt8aPvyNe
 bdl6phAcoLFfEO+lgsjH8xxv3iDib8Ai4Kzl0wO/glAfQ1AIg+NYe5D0ruN4th6r+VEicZ3R9
 qyrxzZ0rJ9F2wEhVGqIfOEZzByg=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/10/1 23:39, Konstantinos Skarlatos wrote:
>
> On 1/10/2023 12:22 =CF=80.=CE=BC., Qu Wenruo wrote:
>>
>>
>> On 2023/9/30 22:31, Konstantinos Skarlatos wrote:
>>>
>>> On 30/9/2023 1:25 =CF=80.=CE=BC., Qu Wenruo wrote:
>>>>
>>>>
>>>> On 2023/9/29 21:01, Konstantinos Skarlatos wrote:
>>>>> On 29/09/2023 1:54 =CE=BC.=CE=BC., Qu Wenruo wrote:
>>>>>>
>>>>>>
>>>>>> On 2023/9/29 19:03, Konstantinos Skarlatos wrote:
>>>>>>> On 29/09/2023 12:56 =CF=80.=CE=BC., Qu Wenruo wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 2023/9/29 00:23, Konstantinos Skarlatos wrote:
>>>>>>>>> Hi Qu, thanks for your patch. I just tried it on a clean
>>>>>>>>> btrfs-progs
>>>>>>>>> tree with my filesystem:
>>>>>>>>>
>>>>>>>>> =E2=9D=AF ./btrfstune --convert-to-block-group-tree /dev/sda
>>>>>>>>> [1]=C2=A0=C2=A0=C2=A0 796483 segmentation fault (core dumped) ./=
btrfstune
>>>>>>>>> --convert-to-block-group-tree /dev/sda
>>>>>>>>
>>>>>>>> Mind to enable debug build by "make D=3D1" for btrfs-progs, and g=
o
>>>>>>>> with
>>>>>>>> gdb to show the crash callback?
>>>>>>>>
>>>>>>>> I assume it could be the same crash from your initial report.
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>> Qu
>>>>>>>>
>>>>>>>
>>>>>>> Hi Qu, i hope i am doing this correctly...
>>>>>>>
>>>>>>>
>>>>>>> =E2=9D=AF gdb -ex=3Dr --args ./btrfstune --convert-to-block-group-=
tree
>>>>>>> /dev/sda
>>>>>>> GNU gdb (GDB) 13.2
>>>>>>> Copyright (C) 2023 Free Software Foundation, Inc.
>>>>>>> License GPLv3+: GNU GPL version 3 or later
>>>>>>> <http://gnu.org/licenses/gpl.html>
>>>>>>> This is free software: you are free to change and redistribute it.
>>>>>>> There is NO WARRANTY, to the extent permitted by law.
>>>>>>> Type "show copying" and "show warranty" for details.
>>>>>>> This GDB was configured as "x86_64-pc-linux-gnu".
>>>>>>> Type "show configuration" for configuration details.
>>>>>>> For bug reporting instructions, please see:
>>>>>>> <https://www.gnu.org/software/gdb/bugs/>.
>>>>>>> Find the GDB manual and other documentation resources online at:
>>>>>>> <http://www.gnu.org/software/gdb/documentation/>.
>>>>>>>
>>>>>>> For help, type "help".
>>>>>>> Type "apropos word" to search for commands related to "word"...
>>>>>>> Reading symbols from ./btrfstune...
>>>>>>> Starting program: /root/btrfs-progs/btrfstune
>>>>>>> --convert-to-block-group-tree /dev/sda
>>>>>>>
>>>>>>> This GDB supports auto-downloading debuginfo from the following
>>>>>>> URLs:
>>>>>>> =C2=A0=C2=A0=C2=A0 <https://debuginfod.archlinux.org>
>>>>>>> Enable debuginfod for this session? (y or [n]) y
>>>>>>> Debuginfod has been enabled.
>>>>>>> To make this setting permanent, add 'set debuginfod enabled on' to
>>>>>>> .gdbinit.
>>>>>>> Downloading separate debug info for /lib64/ld-linux-x86-64.so.2
>>>>>>> Downloading separate debug info for system-supplied DSO at
>>>>>>> 0x7ffff7fc8000
>>>>>>> Downloading separate debug info for /usr/lib/libuuid.so.1
>>>>>>> Downloading separate debug info for /usr/lib/libblkid.so.1
>>>>>>> Downloading separate debug info for /usr/lib/libudev.so.1
>>>>>>> Downloading separate debug info for /usr/lib/libc.so.6
>>>>>>> [Thread debugging using libthread_db enabled]
>>>>>>> Using host libthread_db library "/usr/lib/libthread_db.so.1".
>>>>>>> Downloading separate debug info for /usr/lib/libcap.so.2
>>>>>>>
>>>>>>> Program received signal SIGSEGV, Segmentation fault.
>>>>>>> 0x00005555555c6600 in cache_tree_comp_range
>>>>>>> (node=3D0xffffffffff000f0f,
>>>>>>> data=3D0x7fffffffd780) at common/extent-cache.c:40
>>>>>>> 40=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (entry->start + entry->size <=3D range->start)
>>>>>>> (gdb)
>>>>>>
>>>>>> That's great, what about the output from "bt" command?
>>>>>>
>>>>>
>>>>> Hi Qu, this is what i get:
>>>>>
>>>>> Program received signal SIGSEGV, Segmentation fault.
>>>>> 0x00005555555c6600 in cache_tree_comp_range (node=3D0xffffffffff000f=
0f,
>>>>> data=3D0x7fffffffd780) at common/extent-cache.c:40
>>>>> 40=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 if (entry->start + entry->size <=3D range->start)
>>>>> (gdb) bt
>>>>> #0=C2=A0 0x00005555555c6600 in cache_tree_comp_range
>>>>> (node=3D0xffffffffff000f0f, data=3D0x7fffffffd780) at
>>>>> common/extent-cache.c:40
>>>>> #1=C2=A0 0x00005555555ce458 in rb_search (root=3D0x555555667358,
>>>>> key=3D0x7fffffffd780, comp=3D0x5555555c65d8 <cache_tree_comp_range>,
>>>>> next_ret=3D0x0) at common/rbtree-utils.c:59
>>>>
>>>> Indeed we're back to the initial crash you reported.
>>>>
>>>> The root cause is the @node pointer, which is not valid.
>>>>
>>>> I'm not sure why, but we got an invalid node inside the rb tree, whic=
h
>>>> leads to the crash.
>>>>
>>>> Considering this is a rare one, I'll need more time to dig into the
>>>> original crash.
>>>> I'm afraid with this bug still here, we will not be able to do
>>>> anything,
>>>> neither reverting back or continuing the conversion.
>>>>
>>>> Thanks,
>>>> Qu
>>>
>>> Hello Qu,
>>>
>>> does that mean that the filesystem is not recoverable?
>>
>> I'm not sure, unfortunately.
>>
>> One thing I'm afraid of is, there may be no space left and cause
>> something wrong.
>>
>>>
>>> I can keep it for a while if you need it for further debugging.
>>
>> Considering the turn-over time, please try this diff (upon this patch)
>> as the last try.
>>
>> As I don't have any clue why the crash can happen, thus I go with my
>> last guess on the possible ENOSPC.
>>
>> If this doesn't work, feel free to reformat the fs.
>>
>> Thanks,
>> Qu
>
>
> Hi Qu,
>
> i applied the patch over your previous patch and i got another seg fault=
 :(
>
> the latest df i have from my logs is:
>
> Filesystem=C2=A0=C2=A0=C2=A0=C2=A0 1M-blocks=C2=A0=C2=A0=C2=A0=C2=A0 Use=
d Available Use% Mounted on
>
> /dev/sda=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 11446344 10109559=C2=
=A0=C2=A0=C2=A0 748884=C2=A0 94% /storage/btrfs

Unfortunately vanilla df is not good enough for this case.

As the main concern here is about the metadata usage, which doesn't
really show up.
>
>
> Starting program: /root/btrfs-progs/btrfstune
> --convert-to-block-group-tree /dev/sda
>
> This GDB supports auto-downloading debuginfo from the following URLs:
>  =C2=A0 <https://debuginfod.archlinux.org>
> Enable debuginfod for this session? (y or [n]) y
> Debuginfod has been enabled.
> To make this setting permanent, add 'set debuginfod enabled on' to
> .gdbinit.
> Downloading separate debug info for /lib64/ld-linux-x86-64.so.2
> Downloading separate debug info for system-supplied DSO at 0x7ffff7fc800=
0
> Downloading separate debug info for /usr/lib/libc.so.6
> [Thread debugging using libthread_db enabled]
> Using host libthread_db library "/usr/lib/libthread_db.so.1".
>
> Program received signal SIGSEGV, Segmentation fault.
> 0x00007ffff7c9cd77 in malloc () from /usr/lib/libc.so.6
> (gdb) bt
> #0=C2=A0 0x00007ffff7c9cd77 in malloc () from /usr/lib/libc.so.6
> #1=C2=A0 0x000055555558ccd8 in btrfs_alloc_delayed_extent_op () at
> ./kernel-shared/delayed-ref.h:165

This doesn't sound sane, it's malloc() allocation causing problem.

It may be memory being exhausted or something else.

Either way I have no idea why a malloc() can fail by itself.
It may really be too large metadata causing the problem.

> #2=C2=A0 0x0000555555592cd1 in alloc_tree_block (trans=3D0x555567d491d0,
> root=3D0x5555558da6d0, num_bytes=3D16384, root_objectid=3D10,
> generation=3D1833253, flags=3D0,
>  =C2=A0=C2=A0=C2=A0 key=3D0x7fffffffd9e0, level=3D0, empty_size=3D0,
> hint_byte=3D17820097789952, search_end=3D18446744073709551615,
> ins=3D0x7fffffffd930) at kernel-shared/extent-tree.c:2500
> #3=C2=A0 0x0000555555592f82 in btrfs_alloc_tree_block (trans=3D0x555567d=
491d0,
> root=3D0x5555558da6d0, blocksize=3D16384, root_objectid=3D10,
> key=3D0x7fffffffd9e0, level=3D0,
>  =C2=A0=C2=A0=C2=A0 hint=3D17820097789952, empty_size=3D0, nest=3DBTRFS_=
NESTING_NORMAL) at
> kernel-shared/extent-tree.c:2564
> #4=C2=A0 0x000055555557ba8e in split_leaf (trans=3D0x555567d491d0,
> root=3D0x5555558da6d0, ins_key=3D0x7fffffffdc40, path=3D0x55556a180e90,
> data_size=3D25, extend=3D0)
>  =C2=A0=C2=A0=C2=A0 at kernel-shared/ctree.c:2405
> #5=C2=A0 0x0000555555578fc0 in btrfs_search_slot (trans=3D0x555567d491d0=
,
> root=3D0x5555558da6d0, key=3D0x7fffffffdc40, p=3D0x55556a180e90, ins_len=
=3D25,
> cow=3D1)
>  =C2=A0=C2=A0=C2=A0 at kernel-shared/ctree.c:1399
> #6=C2=A0 0x000055555557ca7d in btrfs_insert_empty_items
> (trans=3D0x555567d491d0, root=3D0x5555558da6d0, path=3D0x55556a180e90,
> cpu_key=3D0x7fffffffdc40,
>  =C2=A0=C2=A0=C2=A0 data_size=3D0x7fffffffdb5c, nr=3D1) at kernel-shared=
/ctree.c:2758
> #7=C2=A0 0x000055555559eb70 in btrfs_insert_empty_item (trans=3D0x555567=
d491d0,
> root=3D0x5555558da6d0, path=3D0x55556a180e90, key=3D0x7fffffffdc40, data=
_size=3D0)
>  =C2=A0=C2=A0=C2=A0 at ./kernel-shared/ctree.h:1019
> #8=C2=A0 0x000055555559ff9a in convert_free_space_to_extents
> (trans=3D0x555567d491d0, block_group=3D0x55555fcc7710, path=3D0x55556a18=
0e90)
>  =C2=A0=C2=A0=C2=A0 at kernel-shared/free-space-tree.c:465

And every crash you reported is related to free space tree code, I'm not
sure if that's the root cause.

But for now, if you really need I can provide a patch to forcefully
remove the converting flag, and then you should be able to mount the fs
read-only using "-o rescue=3Dall" mount option. (mostly to salvage data).

Otherwise I hardly see a proper way to pin down why we always crash at
free space tree code.

Thanks,
Qu
> #9=C2=A0 0x00005555555a01ed in update_free_space_extent_count
> (trans=3D0x555567d491d0, block_group=3D0x55555fcc7710, path=3D0x55556a18=
0e90,
> new_extents=3D1)
>  =C2=A0=C2=A0=C2=A0 at kernel-shared/free-space-tree.c:525
> #10 0x00005555555a07ae in modify_free_space_bitmap
> (trans=3D0x555567d491d0, block_group=3D0x55555fcc7710, path=3D0x55556a18=
0e90,
> start=3D17592699748352, size=3D16384,
>  =C2=A0=C2=A0=C2=A0 remove=3D0) at kernel-shared/free-space-tree.c:707
> #11 0x00005555555a0ff2 in __add_to_free_space_tree
> (trans=3D0x555567d491d0, block_group=3D0x55555fcc7710, path=3D0x55556a18=
0e90,
> start=3D17592699748352, size=3D16384)
>  =C2=A0=C2=A0=C2=A0 at kernel-shared/free-space-tree.c:997
> #12 0x00005555555a10ad in add_to_free_space_tree (trans=3D0x555567d491d0=
,
> start=3D17592699748352, size=3D16384) at kernel-shared/free-space-tree.c=
:1028
> #13 0x0000555555591db8 in __free_extent (trans=3D0x555567d491d0,
> bytenr=3D17592699748352, num_bytes=3D16384, parent=3D0, root_objectid=3D=
2,
> owner_objectid=3D0,
>  =C2=A0=C2=A0=C2=A0 owner_offset=3D0, refs_to_drop=3D1) at kernel-shared=
/extent-tree.c:2130
> #14 0x000055555559651c in run_delayed_tree_ref (trans=3D0x555567d491d0,
> fs_info=3D0x5555556672f0, node=3D0x5555695d3570, extent_op=3D0x0,
> insert_reserved=3D0)
>  =C2=A0=C2=A0=C2=A0 at kernel-shared/extent-tree.c:3906
> #15 0x00005555555965b1 in run_one_delayed_ref (trans=3D0x555567d491d0,
> fs_info=3D0x5555556672f0, node=3D0x5555695d3570, extent_op=3D0x0,
> insert_reserved=3D0)
>  =C2=A0=C2=A0=C2=A0 at kernel-shared/extent-tree.c:3926
> #16 0x00005555555967de in btrfs_run_delayed_refs (trans=3D0x555567d491d0=
,
> nr=3D18446744073709551615) at kernel-shared/extent-tree.c:4010
> #17 0x00005555555afbd1 in btrfs_commit_transaction
> (trans=3D0x555567d491d0, root=3D0x55555567bc90) at
> kernel-shared/transaction.c:210
> #18 0x0000555555566b19 in convert_to_bg_tree (fs_info=3D0x5555556672f0) =
at
> tune/convert-bgt.c:112
> #19 0x00005555555647bb in main (argc=3D3, argv=3D0x7fffffffe288) at
> tune/main.c:393
>
> Kind regards,
>
>
>>
>>> Kind regards,
>>>
>>>
>>>>> #2=C2=A0 0x00005555555c6964 in lookup_cache_extent (tree=3D0x5555556=
67358,
>>>>> start=3D17820099854336, size=3D16384) at common/extent-cache.c:145
>>>>> #3=C2=A0 0x0000555555597cac in alloc_extent_buffer (fs_info=3D0x5555=
556672f0,
>>>>> bytenr=3D17820099854336, blocksize=3D16384) at
>>>>> kernel-shared/extent_io.c:262
>>>>> #4=C2=A0 0x000055555558253b in btrfs_find_create_tree_block
>>>>> (fs_info=3D0x5555556672f0, bytenr=3D17820099854336) at
>>>>> kernel-shared/disk-io.c:232
>>>>> #5=C2=A0 0x0000555555582cdb in read_tree_block (fs_info=3D0x55555566=
72f0,
>>>>> bytenr=3D17820099854336, owner_root=3D10, parent_transid=3D1833250, =
level=3D0,
>>>>> first_key=3D0x0)
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 at kernel-shared/disk-io.c:439
>>>>> #6=C2=A0 0x00005555555776bd in read_node_slot (fs_info=3D0x555555667=
2f0,
>>>>> parent=3D0x55557571ba60, slot=3D154) at kernel-shared/ctree.c:850
>>>>> #7=C2=A0 0x000055555557a644 in push_leaf_right (trans=3D0x555567b3d1=
40,
>>>>> root=3D0x5555558da740, path=3D0x5555757f0d30, data_size=3D25, empty=
=3D0) at
>>>>> kernel-shared/ctree.c:1965
>>>>> #8=C2=A0 0x000055555557b7d1 in split_leaf (trans=3D0x555567b3d140,
>>>>> root=3D0x5555558da740, ins_key=3D0x7fffffffdc50, path=3D0x5555757f0d=
30,
>>>>> data_size=3D25, extend=3D0)
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 at kernel-shared/ctree.c:2338
>>>>> #9=C2=A0 0x0000555555578fc0 in btrfs_search_slot (trans=3D0x555567b3=
d140,
>>>>> root=3D0x5555558da740, key=3D0x7fffffffdc50, p=3D0x5555757f0d30, ins=
_len=3D25,
>>>>> cow=3D1) at kernel-shared/ctree.c:1399
>>>>> #10 0x000055555557ca7d in btrfs_insert_empty_items
>>>>> (trans=3D0x555567b3d140, root=3D0x5555558da740, path=3D0x5555757f0d3=
0,
>>>>> cpu_key=3D0x7fffffffdc50, data_size=3D0x7fffffffdb6c, nr=3D1)
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 at kernel-shared/ctree.c:2758
>>>>> #11 0x000055555559eb70 in btrfs_insert_empty_item
>>>>> (trans=3D0x555567b3d140,
>>>>> root=3D0x5555558da740, path=3D0x5555757f0d30, key=3D0x7fffffffdc50,
>>>>> data_size=3D0)
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 at ./kernel-shared/ctree.h:1019
>>>>> #12 0x000055555559ff9a in convert_free_space_to_extents
>>>>> (trans=3D0x555567b3d140, block_group=3D0x55555fcc7780,
>>>>> path=3D0x5555757f0d30)
>>>>> at kernel-shared/free-space-tree.c:465
>>>>> #13 0x00005555555a01ed in update_free_space_extent_count
>>>>> (trans=3D0x555567b3d140, block_group=3D0x55555fcc7780,
>>>>> path=3D0x5555757f0d30,
>>>>> new_extents=3D1)
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 at kernel-shared/free-space-tree.c:525
>>>>> #14 0x00005555555a07ae in modify_free_space_bitmap
>>>>> (trans=3D0x555567b3d140, block_group=3D0x55555fcc7780,
>>>>> path=3D0x5555757f0d30,
>>>>> start=3D17592699748352, size=3D16384, remove=3D0)
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 at kernel-shared/free-space-tree.c:707
>>>>> #15 0x00005555555a0ff2 in __add_to_free_space_tree
>>>>> (trans=3D0x555567b3d140, block_group=3D0x55555fcc7780,
>>>>> path=3D0x5555757f0d30,
>>>>> start=3D17592699748352, size=3D16384)
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 at kernel-shared/free-space-tree.c:997
>>>>> #16 0x00005555555a10ad in add_to_free_space_tree
>>>>> (trans=3D0x555567b3d140,
>>>>> start=3D17592699748352, size=3D16384) at
>>>>> kernel-shared/free-space-tree.c:1028
>>>>> #17 0x0000555555591db8 in __free_extent (trans=3D0x555567b3d140,
>>>>> bytenr=3D17592699748352, num_bytes=3D16384, parent=3D0, root_objecti=
d=3D2,
>>>>> owner_objectid=3D0, owner_offset=3D0,
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 refs_to_drop=3D1) at kernel-shared/extent-t=
ree.c:2130
>>>>> #18 0x000055555559651c in run_delayed_tree_ref (trans=3D0x555567b3d1=
40,
>>>>> fs_info=3D0x5555556672f0, node=3D0x55556bf11090, extent_op=3D0x0,
>>>>> insert_reserved=3D0)
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 at kernel-shared/extent-tree.c:3906
>>>>> #19 0x00005555555965b1 in run_one_delayed_ref (trans=3D0x555567b3d14=
0,
>>>>> fs_info=3D0x5555556672f0, node=3D0x55556bf11090, extent_op=3D0x0,
>>>>> insert_reserved=3D0)
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 at kernel-shared/extent-tree.c:3926
>>>>> #20 0x00005555555967de in btrfs_run_delayed_refs
>>>>> (trans=3D0x555567b3d140,
>>>>> nr=3D18446744073709551615) at kernel-shared/extent-tree.c:4010
>>>>> #21 0x00005555555afbd1 in btrfs_commit_transaction
>>>>> (trans=3D0x555567b3d140, root=3D0x55555567bd70) at
>>>>> kernel-shared/transaction.c:210
>>>>> #22 0x0000555555566b19 in convert_to_bg_tree
>>>>> (fs_info=3D0x5555556672f0) at
>>>>> tune/convert-bgt.c:112
>>>>> #23 0x00005555555647bb in main (argc=3D3, argv=3D0x7fffffffe298) at
>>>>> tune/main.c:393
>>>>> (gdb)
>>>>>
>>>>>
>>>>>
>>>>>> Thanks,
>>>>>> Qu
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>>>
>>>>>>>>> Sep 28 17:46:17 elsinki kernel: btrfstune[796483]: segfault at
>>>>>>>>> ffffffffff000f2f ip 0000564b6c2107aa sp 00007ffdc8ad25c8 error
>>>>>>>>> 5 in
>>>>>>>>> btrfstune[564b6c1d1000+5b000] likely on CPU 3 (core 2, socket 0)
>>>>>>>>> Sep 28 17:46:17 elsinki kernel: Code: ff 48 8b 34 24 48 8d 3d 5a
>>>>>>>>> d8 01
>>>>>>>>> 00 b8 00 00 00 00 e8 5a 37 00 00 48 8b 33 bf 0a 00 00 00 e8 1d 0=
c
>>>>>>>>> fc ff
>>>>>>>>> eb a8 e8 86 0a fc ff <48> 8b 4f 20 48 8b 56 08 48 89 c8 48 03 47
>>>>>>>>> 28 48
>>>>>>>>> 89 c7 b8 01 00 00
>>>>>>>>> Sep 28 17:46:17 elsinki systemd[1]: Created slice Slice
>>>>>>>>> /system/systemd-coredump.
>>>>>>>>> Sep 28 17:46:17 elsinki systemd[1]: Started Process Core Dump (P=
ID
>>>>>>>>> 796493/UID 0).
>>>>>>>>> Sep 28 17:46:21 elsinki systemd-coredump[796494]: [=F0=9F=A1=95]=
 Process
>>>>>>>>> 796483
>>>>>>>>> (btrfstune) of user 0 dumped core.
>>>>>>>>>
>>>>>>>>> Stack trace of
>>>>>>>>> thread
>>>>>>>>> 796483:
>>>>>>>>> #0
>>>>>>>>> 0x0000564b6c2107aa
>>>>>>>>> n/a (/root/btrfs-progs/btrfstune + 0x4d7aa)
>>>>>>>>> ELF object
>>>>>>>>> binary
>>>>>>>>> architecture: AMD x86-64
>>>>>>>>> Sep 28 17:46:21 elsinki systemd[1]:
>>>>>>>>> systemd-coredump@0-796493-0.service:
>>>>>>>>> Deactivated successfully.
>>>>>>>>> Sep 28 17:46:21 elsinki systemd[1]:
>>>>>>>>> systemd-coredump@0-796493-0.service:
>>>>>>>>> Consumed 4.248s CPU time.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 28/9/2023 1:50 =CF=80.=CE=BC., Qu Wenruo wrote:
>>>>>>>>>> [BUG]
>>>>>>>>>> There is a bug report that when converting to bg tree crashed,
>>>>>>>>>> the
>>>>>>>>>> resulted fs is unable to be resumed.
>>>>>>>>>>
>>>>>>>>>> This problems comes with the following error messages:
>>>>>>>>>>
>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 ./btrfstune --convert-to-block-group-t=
ree /dev/sda
>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 ERROR: Corrupted fs, no valid METADATA=
 block group found
>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 ERROR: failed to delete block group it=
em from the old root:
>>>>>>>>>> -117
>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 ERROR: failed to convert the filesyste=
m to block group tree
>>>>>>>>>> feature
>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 ERROR: btrfstune failed
>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 extent buffer leak: start 178255766323=
20 len 16384
>>>>>>>>>>
>>>>>>>>>> [CAUSE]
>>>>>>>>>> When resuming a interrupted conversion, we go through
>>>>>>>>>> read_converting_block_groups() to handle block group items in
>>>>>>>>>> both
>>>>>>>>>> extent and block group trees.
>>>>>>>>>>
>>>>>>>>>> However for the block group items in the extent tree, there are
>>>>>>>>>> several
>>>>>>>>>> problems involved:
>>>>>>>>>>
>>>>>>>>>> - Uninitialized @key inside read_old_block_groups_from_root()
>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 Here we only set @key.type, not settin=
g @key.objectid for
>>>>>>>>>> the
>>>>>>>>>> initial
>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 search.
>>>>>>>>>>
>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 Thus if we're unlukcy, we can got (u64=
)-1 as
>>>>>>>>>> key.objectid, and
>>>>>>>>>> exit
>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 the search immediately.
>>>>>>>>>>
>>>>>>>>>> - Wrong search direction
>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 The conversion is converting block gro=
ups in descending
>>>>>>>>>> order,
>>>>>>>>>> but the
>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 block groups read is in ascending orde=
r.
>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 Meaning if we start from the last conv=
erted block group, we
>>>>>>>>>> would at
>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 most read one block group.
>>>>>>>>>>
>>>>>>>>>> [FIX]
>>>>>>>>>> To fix the problems, this patch would just remove
>>>>>>>>>> read_old_block_groups_from_root() function completely.
>>>>>>>>>>
>>>>>>>>>> As for the conversion, we ensured the block group item is eithe=
r
>>>>>>>>>> in the
>>>>>>>>>> old extent or the new block group tree.
>>>>>>>>>> Thus there is no special handling needed reading block groups.
>>>>>>>>>>
>>>>>>>>>> We only need to read all block groups from both trees, using th=
e
>>>>>>>>>> same
>>>>>>>>>> read_old_block_groups_from_root() function.
>>>>>>>>>>
>>>>>>>>>> Reported-by: Konstantinos Skarlatos <k.skarlatos@gmail.com>
>>>>>>>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>>>>>>>> ---
>>>>>>>>>> To Konstantinos:
>>>>>>>>>>
>>>>>>>>>> The bug I fixed here can explain all the failures you hit (the
>>>>>>>>>> initial
>>>>>>>>>> one and the one after the quick diff).
>>>>>>>>>>
>>>>>>>>>> Please verify if this helps and report back (without the quick
>>>>>>>>>> diff in
>>>>>>>>>> the original thread).
>>>>>>>>>>
>>>>>>>>>> We may have other corner cases to go, but I believe the patch
>>>>>>>>>> itself is
>>>>>>>>>> necessary no matter what, as the deleted code is really
>>>>>>>>>> over-engineered and buggy.
>>>>>>>>>> ---
>>>>>>>>>> =C2=A0=C2=A0=C2=A0 kernel-shared/extent-tree.c | 79
>>>>>>>>>> +------------------------------------
>>>>>>>>>> =C2=A0=C2=A0=C2=A0 1 file changed, 1 insertion(+), 78 deletions=
(-)
>>>>>>>>>>
>>>>>>>>>> diff --git a/kernel-shared/extent-tree.c
>>>>>>>>>> b/kernel-shared/extent-tree.c
>>>>>>>>>> index 7022643a9843..4d6bf2b228e9 100644
>>>>>>>>>> --- a/kernel-shared/extent-tree.c
>>>>>>>>>> +++ b/kernel-shared/extent-tree.c
>>>>>>>>>> @@ -2852,83 +2852,6 @@ out:
>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>>>>>>>>> =C2=A0=C2=A0=C2=A0 }
>>>>>>>>>> -/*
>>>>>>>>>> - * Helper to read old block groups items from specified root.
>>>>>>>>>> - *
>>>>>>>>>> - * The difference between this and
>>>>>>>>>> read_block_groups_from_root() is,
>>>>>>>>>> - * we will exit if we have already read the last bg in the old
>>>>>>>>>> root.
>>>>>>>>>> - *
>>>>>>>>>> - * This is to avoid wasting time finding bg items which
>>>>>>>>>> should be
>>>>>>>>>> in the
>>>>>>>>>> - * new root.
>>>>>>>>>> - */
>>>>>>>>>> -static int read_old_block_groups_from_root(struct btrfs_fs_inf=
o
>>>>>>>>>> *fs_info,
>>>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s=
truct btrfs_root *root)
>>>>>>>>>> -{
>>>>>>>>>> -=C2=A0=C2=A0=C2=A0 struct btrfs_path path =3D {0};
>>>>>>>>>> -=C2=A0=C2=A0=C2=A0 struct btrfs_key key;
>>>>>>>>>> -=C2=A0=C2=A0=C2=A0 struct cache_extent *ce;
>>>>>>>>>> -=C2=A0=C2=A0=C2=A0 /* The last block group bytenr in the old r=
oot. */
>>>>>>>>>> -=C2=A0=C2=A0=C2=A0 u64 last_bg_in_old_root;
>>>>>>>>>> -=C2=A0=C2=A0=C2=A0 int ret;
>>>>>>>>>> -
>>>>>>>>>> -=C2=A0=C2=A0=C2=A0 if (fs_info->last_converted_bg_bytenr !=3D =
(u64)-1) {
>>>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * We know the=
 last converted bg in the other tree,
>>>>>>>>>> load the
>>>>>>>>>> chunk
>>>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * before that=
 last converted as our last bg in the
>>>>>>>>>> tree.
>>>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ce =3D
>>>>>>>>>> search_cache_extent(&fs_info->mapping_tree.cache_tree,
>>>>>>>>>> - fs_info->last_converted_bg_bytenr);
>>>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!ce || ce->star=
t !=3D
>>>>>>>>>> fs_info->last_converted_bg_bytenr) {
>>>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 error("no chunk found for bytenr %llu",
>>>>>>>>>> - fs_info->last_converted_bg_bytenr);
>>>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return -ENOENT;
>>>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ce =3D prev_cache_e=
xtent(ce);
>>>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * We should h=
ave previous unconverted chunk, or we have
>>>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * already fin=
ished the convert.
>>>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ASSERT(ce);
>>>>>>>>>> -
>>>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 last_bg_in_old_root=
 =3D ce->start;
>>>>>>>>>> -=C2=A0=C2=A0=C2=A0 } else {
>>>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 last_bg_in_old_root=
 =3D (u64)-1;
>>>>>>>>>> -=C2=A0=C2=A0=C2=A0 }
>>>>>>>>>> -
>>>>>>>>>> -=C2=A0=C2=A0=C2=A0 key.type =3D BTRFS_BLOCK_GROUP_ITEM_KEY;
>>>>>>>>>> -
>>>>>>>>>> -=C2=A0=C2=A0=C2=A0 while (true) {
>>>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D find_first_=
block_group(root, &path, &key);
>>>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret > 0) {
>>>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ret =3D 0;
>>>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 goto out;
>>>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret !=3D 0) {
>>>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 goto out;
>>>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_item_key_to_c=
pu(path.nodes[0], &key,
>>>>>>>>>> path.slots[0]);
>>>>>>>>>> -
>>>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D read_one_bl=
ock_group(fs_info, &path);
>>>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0 && ret =
!=3D -ENOENT)
>>>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 goto out;
>>>>>>>>>> -
>>>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* We have reached =
last bg in the old root, no need to
>>>>>>>>>> continue */
>>>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (key.objectid >=
=3D last_bg_in_old_root)
>>>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 break;
>>>>>>>>>> -
>>>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (key.offset =3D=
=3D 0)
>>>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 key.objectid++;
>>>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
>>>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 key.objectid =3D key.objectid + key.offset;
>>>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 key.offset =3D 0;
>>>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_release_path(=
&path);
>>>>>>>>>> -=C2=A0=C2=A0=C2=A0 }
>>>>>>>>>> -=C2=A0=C2=A0=C2=A0 ret =3D 0;
>>>>>>>>>> -out:
>>>>>>>>>> -=C2=A0=C2=A0=C2=A0 btrfs_release_path(&path);
>>>>>>>>>> -=C2=A0=C2=A0=C2=A0 return ret;
>>>>>>>>>> -}
>>>>>>>>>> -
>>>>>>>>>> =C2=A0=C2=A0=C2=A0 /* Helper to read all block groups items fro=
m specified
>>>>>>>>>> root. */
>>>>>>>>>> =C2=A0=C2=A0=C2=A0 static int read_block_groups_from_root(struc=
t btrfs_fs_info
>>>>>>>>>> *fs_info,
>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 struct btrfs_root *root)
>>>>>>>>>> @@ -2989,7 +2912,7 @@ static int
>>>>>>>>>> read_converting_block_groups(struct
>>>>>>>>>> btrfs_fs_info *fs_info)
>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return ret;
>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>>>>>> -=C2=A0=C2=A0=C2=A0 ret =3D read_old_block_groups_from_root(fs_=
info, old_root);
>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 ret =3D read_block_groups_from_root(fs_info=
, old_root);
>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 error("failed to load block groups from the old
>>>>>>>>>> root: %d",
>>>>>>>>>> ret);
>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return ret;
>>>>>>>
>>>>>
