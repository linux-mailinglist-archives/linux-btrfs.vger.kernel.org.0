Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF847B43E8
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Sep 2023 23:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233981AbjI3VW5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 30 Sep 2023 17:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbjI3VW4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 30 Sep 2023 17:22:56 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF476DD
        for <linux-btrfs@vger.kernel.org>; Sat, 30 Sep 2023 14:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
 t=1696108967; x=1696713767; i=quwenruo.btrfs@gmx.com;
 bh=rhlzcBq1NQkgtLOqYvFoZQ1w3BIzrQsUwbtyTCFNSiw=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=CD282jCvkmp2Zvy2DvmV/I5LgXusi+8Yctkt3i+KSWQ1rf4IUOgjJr2hMq29+FSDewuEfKpmE2a
 vPmzKqhBhxFm/4O5OnNZDFN15coqIGbs7lbG5tGKC4voZljyzGBGrs0ZtOzwtaV10BobPiEanZ/sg
 y4Q2HeKkYEINzaCdLXbcnwgCKlmCojl1KbkZsTyfX/ZJt5UF4BYd/38Fp61O6FKnpBsj3Q5a8SgKZ
 DD6mTIR7Va8tMccH5e66s0DMHNKHoToAUAyH//Ir2ceJFgYOyMqLGh0etmnTH887uPBO8yJqu7Ul6
 LtLGJe2dvsf+6jq325FC1J3/q04PmttxFZfA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([218.215.59.251]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N7zBb-1rifag4AWh-0152ra; Sat, 30
 Sep 2023 23:22:46 +0200
Content-Type: multipart/mixed; boundary="------------ssFPKEgTjNR19u6TJoMHMBBg"
Message-ID: <17ed25c0-9a96-456b-a998-6e7d8e5ad113@gmx.com>
Date:   Sun, 1 Oct 2023 07:52:41 +1030
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
In-Reply-To: <35bc07b9-2e6c-0848-661c-8e991cb5479a@gmail.com>
X-Provags-ID: V03:K1:226YOTUJaxzgPIMn0P1crBOeyLXNZAMhZJipQj0eBOoGpRjTta5
 r1trUiDf/7TMjWf3B1Lshk5jhmtuc4atM9d0S19I1/vh9bJs7gYkRezv9cMErUfBlmNlmna
 yVfeN3MRAJix+tamk3oKW5P8Lq+7yj4US6lkw37kFZMeGqnP2jWVp5b8yJ5SrvJLi50wYmq
 /DuKwNFRWqNAMqPRvEXzQ==
UI-OutboundReport: notjunk:1;M01:P0:E5YyIdI48Nw=;zB+G+ukb5I/bkx/rPT9X9fB7Ths
 yC/wQ9UfGSJwa1Y7mB0VyyFC8M+lXJnRXNQTcd80kdja6gbkej2L/M4ILhN8lyWfkTFdMCS2p
 cm7h60haT7Papuy8P7Q2bdluOI/xXYprHI/AkgZyyAOEKHj6HWgm2dPl7rP6cPlLXPntAj9pI
 5AIZHWkBCd3Ub+UtkysFD88eIPZhJFL/VzVUQ2rwBXaB8b+z3hDvTpV9KTXWaAJI5RGkRYKnG
 ObYqZdYCC2TpTJOcVq2WGn8Mg6iQoCWJp7ZqrKMiIlzkq0da76/8I9QJT9UIppWp2Ttzxy+ov
 varECt/+k1kE4c6mffR8tmfglcJexfyjhkj+fhYsUjgC6qP9K0xSeBPOsQ+t8WOE55JV+mi7Q
 L4b2ZfqhLvt2NrRYidQA9/kprJROviPZOlIK2s2Y+UhReOVLXZYMr3QQlbm3IcV/2gZoFkogs
 zkeV270p4EvN6O+icdY8TdLJSBMc4FZSVhw8mbHbrzcWRPtFxWyIgnyLp8wdWkUFPD/cQSjB/
 AMMttdRwfogR23xLWtpG1D757FrsCKvcY5jbe7/uweiWgH8luylw4Nha48laPmmoQG/9Nf03A
 hpAfftFb1ry+KrC+hrFBGLjklDCI16fw7GsYoOQWzjVpBDRt/STch6ACP4zWTmICIR77SMHMw
 QP1tt2cLN70OCP+tAL95AEDKKbOkJx/HO9xh4FoP4cUN06I9rcJN7EQrsQUkUfnlm+z68UriQ
 MN1s6gWnGlju5oHCPhLwLJkDTY76lw51CLMxtGAHNzK6zV3HbZ+bDlD9XEX+twNfAwz4h1fZD
 iLpKrX0oefq6sOWXnlxyZrd7AlbgN4ApabJvDYZRSjwDBunVsKn4kUEAOsGgCHIgJ9QX56OBD
 nBn6ApbuuVdmEhfTN8hW8CTBapvKTA4mQYJoXbE9sxhRXi2YvPDNn0gkGOwuia/ZN/GWjgwBz
 XVJZiBUWDg+w7nknILwuijMLZYI=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a multi-part message in MIME format.
--------------ssFPKEgTjNR19u6TJoMHMBBg
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable



On 2023/9/30 22:31, Konstantinos Skarlatos wrote:
>
> On 30/9/2023 1:25 =CF=80.=CE=BC., Qu Wenruo wrote:
>>
>>
>> On 2023/9/29 21:01, Konstantinos Skarlatos wrote:
>>> On 29/09/2023 1:54 =CE=BC.=CE=BC., Qu Wenruo wrote:
>>>>
>>>>
>>>> On 2023/9/29 19:03, Konstantinos Skarlatos wrote:
>>>>> On 29/09/2023 12:56 =CF=80.=CE=BC., Qu Wenruo wrote:
>>>>>>
>>>>>>
>>>>>> On 2023/9/29 00:23, Konstantinos Skarlatos wrote:
>>>>>>> Hi Qu, thanks for your patch. I just tried it on a clean btrfs-pro=
gs
>>>>>>> tree with my filesystem:
>>>>>>>
>>>>>>> =E2=9D=AF ./btrfstune --convert-to-block-group-tree /dev/sda
>>>>>>> [1]=C2=A0=C2=A0=C2=A0 796483 segmentation fault (core dumped) ./bt=
rfstune
>>>>>>> --convert-to-block-group-tree /dev/sda
>>>>>>
>>>>>> Mind to enable debug build by "make D=3D1" for btrfs-progs, and go =
with
>>>>>> gdb to show the crash callback?
>>>>>>
>>>>>> I assume it could be the same crash from your initial report.
>>>>>>
>>>>>> Thanks,
>>>>>> Qu
>>>>>>
>>>>>
>>>>> Hi Qu, i hope i am doing this correctly...
>>>>>
>>>>>
>>>>> =E2=9D=AF gdb -ex=3Dr --args ./btrfstune --convert-to-block-group-tr=
ee /dev/sda
>>>>> GNU gdb (GDB) 13.2
>>>>> Copyright (C) 2023 Free Software Foundation, Inc.
>>>>> License GPLv3+: GNU GPL version 3 or later
>>>>> <http://gnu.org/licenses/gpl.html>
>>>>> This is free software: you are free to change and redistribute it.
>>>>> There is NO WARRANTY, to the extent permitted by law.
>>>>> Type "show copying" and "show warranty" for details.
>>>>> This GDB was configured as "x86_64-pc-linux-gnu".
>>>>> Type "show configuration" for configuration details.
>>>>> For bug reporting instructions, please see:
>>>>> <https://www.gnu.org/software/gdb/bugs/>.
>>>>> Find the GDB manual and other documentation resources online at:
>>>>> <http://www.gnu.org/software/gdb/documentation/>.
>>>>>
>>>>> For help, type "help".
>>>>> Type "apropos word" to search for commands related to "word"...
>>>>> Reading symbols from ./btrfstune...
>>>>> Starting program: /root/btrfs-progs/btrfstune
>>>>> --convert-to-block-group-tree /dev/sda
>>>>>
>>>>> This GDB supports auto-downloading debuginfo from the following URLs=
:
>>>>> =C2=A0=C2=A0=C2=A0 <https://debuginfod.archlinux.org>
>>>>> Enable debuginfod for this session? (y or [n]) y
>>>>> Debuginfod has been enabled.
>>>>> To make this setting permanent, add 'set debuginfod enabled on' to
>>>>> .gdbinit.
>>>>> Downloading separate debug info for /lib64/ld-linux-x86-64.so.2
>>>>> Downloading separate debug info for system-supplied DSO at
>>>>> 0x7ffff7fc8000
>>>>> Downloading separate debug info for /usr/lib/libuuid.so.1
>>>>> Downloading separate debug info for /usr/lib/libblkid.so.1
>>>>> Downloading separate debug info for /usr/lib/libudev.so.1
>>>>> Downloading separate debug info for /usr/lib/libc.so.6
>>>>> [Thread debugging using libthread_db enabled]
>>>>> Using host libthread_db library "/usr/lib/libthread_db.so.1".
>>>>> Downloading separate debug info for /usr/lib/libcap.so.2
>>>>>
>>>>> Program received signal SIGSEGV, Segmentation fault.
>>>>> 0x00005555555c6600 in cache_tree_comp_range (node=3D0xffffffffff000f=
0f,
>>>>> data=3D0x7fffffffd780) at common/extent-cache.c:40
>>>>> 40=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 if (entry->start + entry->size <=3D range->start)
>>>>> (gdb)
>>>>
>>>> That's great, what about the output from "bt" command?
>>>>
>>>
>>> Hi Qu, this is what i get:
>>>
>>> Program received signal SIGSEGV, Segmentation fault.
>>> 0x00005555555c6600 in cache_tree_comp_range (node=3D0xffffffffff000f0f=
,
>>> data=3D0x7fffffffd780) at common/extent-cache.c:40
>>> 40=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 if (entry->start + entry->size <=3D range->start)
>>> (gdb) bt
>>> #0=C2=A0 0x00005555555c6600 in cache_tree_comp_range
>>> (node=3D0xffffffffff000f0f, data=3D0x7fffffffd780) at
>>> common/extent-cache.c:40
>>> #1=C2=A0 0x00005555555ce458 in rb_search (root=3D0x555555667358,
>>> key=3D0x7fffffffd780, comp=3D0x5555555c65d8 <cache_tree_comp_range>,
>>> next_ret=3D0x0) at common/rbtree-utils.c:59
>>
>> Indeed we're back to the initial crash you reported.
>>
>> The root cause is the @node pointer, which is not valid.
>>
>> I'm not sure why, but we got an invalid node inside the rb tree, which
>> leads to the crash.
>>
>> Considering this is a rare one, I'll need more time to dig into the
>> original crash.
>> I'm afraid with this bug still here, we will not be able to do anything=
,
>> neither reverting back or continuing the conversion.
>>
>> Thanks,
>> Qu
>
> Hello Qu,
>
> does that mean that the filesystem is not recoverable?

I'm not sure, unfortunately.

One thing I'm afraid of is, there may be no space left and cause
something wrong.

>
> I can keep it for a while if you need it for further debugging.

Considering the turn-over time, please try this diff (upon this patch)
as the last try.

As I don't have any clue why the crash can happen, thus I go with my
last guess on the possible ENOSPC.

If this doesn't work, feel free to reformat the fs.

Thanks,
Qu

> Kind regards,
>
>
>>> #2=C2=A0 0x00005555555c6964 in lookup_cache_extent (tree=3D0x555555667=
358,
>>> start=3D17820099854336, size=3D16384) at common/extent-cache.c:145
>>> #3=C2=A0 0x0000555555597cac in alloc_extent_buffer (fs_info=3D0x555555=
6672f0,
>>> bytenr=3D17820099854336, blocksize=3D16384) at kernel-shared/extent_io=
.c:262
>>> #4=C2=A0 0x000055555558253b in btrfs_find_create_tree_block
>>> (fs_info=3D0x5555556672f0, bytenr=3D17820099854336) at
>>> kernel-shared/disk-io.c:232
>>> #5=C2=A0 0x0000555555582cdb in read_tree_block (fs_info=3D0x5555556672=
f0,
>>> bytenr=3D17820099854336, owner_root=3D10, parent_transid=3D1833250, le=
vel=3D0,
>>> first_key=3D0x0)
>>> =C2=A0=C2=A0=C2=A0=C2=A0 at kernel-shared/disk-io.c:439
>>> #6=C2=A0 0x00005555555776bd in read_node_slot (fs_info=3D0x5555556672f=
0,
>>> parent=3D0x55557571ba60, slot=3D154) at kernel-shared/ctree.c:850
>>> #7=C2=A0 0x000055555557a644 in push_leaf_right (trans=3D0x555567b3d140=
,
>>> root=3D0x5555558da740, path=3D0x5555757f0d30, data_size=3D25, empty=3D=
0) at
>>> kernel-shared/ctree.c:1965
>>> #8=C2=A0 0x000055555557b7d1 in split_leaf (trans=3D0x555567b3d140,
>>> root=3D0x5555558da740, ins_key=3D0x7fffffffdc50, path=3D0x5555757f0d30=
,
>>> data_size=3D25, extend=3D0)
>>> =C2=A0=C2=A0=C2=A0=C2=A0 at kernel-shared/ctree.c:2338
>>> #9=C2=A0 0x0000555555578fc0 in btrfs_search_slot (trans=3D0x555567b3d1=
40,
>>> root=3D0x5555558da740, key=3D0x7fffffffdc50, p=3D0x5555757f0d30, ins_l=
en=3D25,
>>> cow=3D1) at kernel-shared/ctree.c:1399
>>> #10 0x000055555557ca7d in btrfs_insert_empty_items
>>> (trans=3D0x555567b3d140, root=3D0x5555558da740, path=3D0x5555757f0d30,
>>> cpu_key=3D0x7fffffffdc50, data_size=3D0x7fffffffdb6c, nr=3D1)
>>> =C2=A0=C2=A0=C2=A0=C2=A0 at kernel-shared/ctree.c:2758
>>> #11 0x000055555559eb70 in btrfs_insert_empty_item (trans=3D0x555567b3d=
140,
>>> root=3D0x5555558da740, path=3D0x5555757f0d30, key=3D0x7fffffffdc50,
>>> data_size=3D0)
>>> =C2=A0=C2=A0=C2=A0=C2=A0 at ./kernel-shared/ctree.h:1019
>>> #12 0x000055555559ff9a in convert_free_space_to_extents
>>> (trans=3D0x555567b3d140, block_group=3D0x55555fcc7780, path=3D0x555575=
7f0d30)
>>> at kernel-shared/free-space-tree.c:465
>>> #13 0x00005555555a01ed in update_free_space_extent_count
>>> (trans=3D0x555567b3d140, block_group=3D0x55555fcc7780, path=3D0x555575=
7f0d30,
>>> new_extents=3D1)
>>> =C2=A0=C2=A0=C2=A0=C2=A0 at kernel-shared/free-space-tree.c:525
>>> #14 0x00005555555a07ae in modify_free_space_bitmap
>>> (trans=3D0x555567b3d140, block_group=3D0x55555fcc7780, path=3D0x555575=
7f0d30,
>>> start=3D17592699748352, size=3D16384, remove=3D0)
>>> =C2=A0=C2=A0=C2=A0=C2=A0 at kernel-shared/free-space-tree.c:707
>>> #15 0x00005555555a0ff2 in __add_to_free_space_tree
>>> (trans=3D0x555567b3d140, block_group=3D0x55555fcc7780, path=3D0x555575=
7f0d30,
>>> start=3D17592699748352, size=3D16384)
>>> =C2=A0=C2=A0=C2=A0=C2=A0 at kernel-shared/free-space-tree.c:997
>>> #16 0x00005555555a10ad in add_to_free_space_tree (trans=3D0x555567b3d1=
40,
>>> start=3D17592699748352, size=3D16384) at
>>> kernel-shared/free-space-tree.c:1028
>>> #17 0x0000555555591db8 in __free_extent (trans=3D0x555567b3d140,
>>> bytenr=3D17592699748352, num_bytes=3D16384, parent=3D0, root_objectid=
=3D2,
>>> owner_objectid=3D0, owner_offset=3D0,
>>> =C2=A0=C2=A0=C2=A0=C2=A0 refs_to_drop=3D1) at kernel-shared/extent-tre=
e.c:2130
>>> #18 0x000055555559651c in run_delayed_tree_ref (trans=3D0x555567b3d140=
,
>>> fs_info=3D0x5555556672f0, node=3D0x55556bf11090, extent_op=3D0x0,
>>> insert_reserved=3D0)
>>> =C2=A0=C2=A0=C2=A0=C2=A0 at kernel-shared/extent-tree.c:3906
>>> #19 0x00005555555965b1 in run_one_delayed_ref (trans=3D0x555567b3d140,
>>> fs_info=3D0x5555556672f0, node=3D0x55556bf11090, extent_op=3D0x0,
>>> insert_reserved=3D0)
>>> =C2=A0=C2=A0=C2=A0=C2=A0 at kernel-shared/extent-tree.c:3926
>>> #20 0x00005555555967de in btrfs_run_delayed_refs (trans=3D0x555567b3d1=
40,
>>> nr=3D18446744073709551615) at kernel-shared/extent-tree.c:4010
>>> #21 0x00005555555afbd1 in btrfs_commit_transaction
>>> (trans=3D0x555567b3d140, root=3D0x55555567bd70) at
>>> kernel-shared/transaction.c:210
>>> #22 0x0000555555566b19 in convert_to_bg_tree (fs_info=3D0x5555556672f0=
) at
>>> tune/convert-bgt.c:112
>>> #23 0x00005555555647bb in main (argc=3D3, argv=3D0x7fffffffe298) at
>>> tune/main.c:393
>>> (gdb)
>>>
>>>
>>>
>>>> Thanks,
>>>> Qu
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>>>
>>>>>>> Sep 28 17:46:17 elsinki kernel: btrfstune[796483]: segfault at
>>>>>>> ffffffffff000f2f ip 0000564b6c2107aa sp 00007ffdc8ad25c8 error 5 i=
n
>>>>>>> btrfstune[564b6c1d1000+5b000] likely on CPU 3 (core 2, socket 0)
>>>>>>> Sep 28 17:46:17 elsinki kernel: Code: ff 48 8b 34 24 48 8d 3d 5a
>>>>>>> d8 01
>>>>>>> 00 b8 00 00 00 00 e8 5a 37 00 00 48 8b 33 bf 0a 00 00 00 e8 1d 0c
>>>>>>> fc ff
>>>>>>> eb a8 e8 86 0a fc ff <48> 8b 4f 20 48 8b 56 08 48 89 c8 48 03 47
>>>>>>> 28 48
>>>>>>> 89 c7 b8 01 00 00
>>>>>>> Sep 28 17:46:17 elsinki systemd[1]: Created slice Slice
>>>>>>> /system/systemd-coredump.
>>>>>>> Sep 28 17:46:17 elsinki systemd[1]: Started Process Core Dump (PID
>>>>>>> 796493/UID 0).
>>>>>>> Sep 28 17:46:21 elsinki systemd-coredump[796494]: [=F0=9F=A1=95] P=
rocess 796483
>>>>>>> (btrfstune) of user 0 dumped core.
>>>>>>>
>>>>>>> Stack trace of
>>>>>>> thread
>>>>>>> 796483:
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #0
>>>>>>> 0x0000564b6c2107aa
>>>>>>> n/a (/root/btrfs-progs/btrfstune + 0x4d7aa)
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ELF object
>>>>>>> binary
>>>>>>> architecture: AMD x86-64
>>>>>>> Sep 28 17:46:21 elsinki systemd[1]:
>>>>>>> systemd-coredump@0-796493-0.service:
>>>>>>> Deactivated successfully.
>>>>>>> Sep 28 17:46:21 elsinki systemd[1]:
>>>>>>> systemd-coredump@0-796493-0.service:
>>>>>>> Consumed 4.248s CPU time.
>>>>>>>
>>>>>>>
>>>>>>> On 28/9/2023 1:50 =CF=80.=CE=BC., Qu Wenruo wrote:
>>>>>>>> [BUG]
>>>>>>>> There is a bug report that when converting to bg tree crashed, th=
e
>>>>>>>> resulted fs is unable to be resumed.
>>>>>>>>
>>>>>>>> This problems comes with the following error messages:
>>>>>>>>
>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 ./btrfstune --convert-to-block-group-tre=
e /dev/sda
>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 ERROR: Corrupted fs, no valid METADATA b=
lock group found
>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 ERROR: failed to delete block group item=
 from the old root:
>>>>>>>> -117
>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 ERROR: failed to convert the filesystem =
to block group tree
>>>>>>>> feature
>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 ERROR: btrfstune failed
>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 extent buffer leak: start 17825576632320=
 len 16384
>>>>>>>>
>>>>>>>> [CAUSE]
>>>>>>>> When resuming a interrupted conversion, we go through
>>>>>>>> read_converting_block_groups() to handle block group items in bot=
h
>>>>>>>> extent and block group trees.
>>>>>>>>
>>>>>>>> However for the block group items in the extent tree, there are
>>>>>>>> several
>>>>>>>> problems involved:
>>>>>>>>
>>>>>>>> - Uninitialized @key inside read_old_block_groups_from_root()
>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 Here we only set @key.type, not setting =
@key.objectid for the
>>>>>>>> initial
>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 search.
>>>>>>>>
>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 Thus if we're unlukcy, we can got (u64)-=
1 as key.objectid, and
>>>>>>>> exit
>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 the search immediately.
>>>>>>>>
>>>>>>>> - Wrong search direction
>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 The conversion is converting block group=
s in descending order,
>>>>>>>> but the
>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 block groups read is in ascending order.
>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 Meaning if we start from the last conver=
ted block group, we
>>>>>>>> would at
>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 most read one block group.
>>>>>>>>
>>>>>>>> [FIX]
>>>>>>>> To fix the problems, this patch would just remove
>>>>>>>> read_old_block_groups_from_root() function completely.
>>>>>>>>
>>>>>>>> As for the conversion, we ensured the block group item is either
>>>>>>>> in the
>>>>>>>> old extent or the new block group tree.
>>>>>>>> Thus there is no special handling needed reading block groups.
>>>>>>>>
>>>>>>>> We only need to read all block groups from both trees, using the
>>>>>>>> same
>>>>>>>> read_old_block_groups_from_root() function.
>>>>>>>>
>>>>>>>> Reported-by: Konstantinos Skarlatos <k.skarlatos@gmail.com>
>>>>>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>>>>>> ---
>>>>>>>> To Konstantinos:
>>>>>>>>
>>>>>>>> The bug I fixed here can explain all the failures you hit (the
>>>>>>>> initial
>>>>>>>> one and the one after the quick diff).
>>>>>>>>
>>>>>>>> Please verify if this helps and report back (without the quick
>>>>>>>> diff in
>>>>>>>> the original thread).
>>>>>>>>
>>>>>>>> We may have other corner cases to go, but I believe the patch
>>>>>>>> itself is
>>>>>>>> necessary no matter what, as the deleted code is really
>>>>>>>> over-engineered and buggy.
>>>>>>>> ---
>>>>>>>> =C2=A0=C2=A0=C2=A0 kernel-shared/extent-tree.c | 79
>>>>>>>> +------------------------------------
>>>>>>>> =C2=A0=C2=A0=C2=A0 1 file changed, 1 insertion(+), 78 deletions(-=
)
>>>>>>>>
>>>>>>>> diff --git a/kernel-shared/extent-tree.c
>>>>>>>> b/kernel-shared/extent-tree.c
>>>>>>>> index 7022643a9843..4d6bf2b228e9 100644
>>>>>>>> --- a/kernel-shared/extent-tree.c
>>>>>>>> +++ b/kernel-shared/extent-tree.c
>>>>>>>> @@ -2852,83 +2852,6 @@ out:
>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>>>>>>> =C2=A0=C2=A0=C2=A0 }
>>>>>>>> -/*
>>>>>>>> - * Helper to read old block groups items from specified root.
>>>>>>>> - *
>>>>>>>> - * The difference between this and
>>>>>>>> read_block_groups_from_root() is,
>>>>>>>> - * we will exit if we have already read the last bg in the old
>>>>>>>> root.
>>>>>>>> - *
>>>>>>>> - * This is to avoid wasting time finding bg items which should b=
e
>>>>>>>> in the
>>>>>>>> - * new root.
>>>>>>>> - */
>>>>>>>> -static int read_old_block_groups_from_root(struct btrfs_fs_info
>>>>>>>> *fs_info,
>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stru=
ct btrfs_root *root)
>>>>>>>> -{
>>>>>>>> -=C2=A0=C2=A0=C2=A0 struct btrfs_path path =3D {0};
>>>>>>>> -=C2=A0=C2=A0=C2=A0 struct btrfs_key key;
>>>>>>>> -=C2=A0=C2=A0=C2=A0 struct cache_extent *ce;
>>>>>>>> -=C2=A0=C2=A0=C2=A0 /* The last block group bytenr in the old roo=
t. */
>>>>>>>> -=C2=A0=C2=A0=C2=A0 u64 last_bg_in_old_root;
>>>>>>>> -=C2=A0=C2=A0=C2=A0 int ret;
>>>>>>>> -
>>>>>>>> -=C2=A0=C2=A0=C2=A0 if (fs_info->last_converted_bg_bytenr !=3D (u=
64)-1) {
>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * We know the l=
ast converted bg in the other tree,
>>>>>>>> load the
>>>>>>>> chunk
>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * before that l=
ast converted as our last bg in the tree.
>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ce =3D
>>>>>>>> search_cache_extent(&fs_info->mapping_tree.cache_tree,
>>>>>>>> - fs_info->last_converted_bg_bytenr);
>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!ce || ce->start =
!=3D
>>>>>>>> fs_info->last_converted_bg_bytenr) {
>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 error("no chunk found for bytenr %llu",
>>>>>>>> - fs_info->last_converted_bg_bytenr);
>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return -ENOENT;
>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ce =3D prev_cache_ext=
ent(ce);
>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * We should hav=
e previous unconverted chunk, or we have
>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * already finis=
hed the convert.
>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ASSERT(ce);
>>>>>>>> -
>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 last_bg_in_old_root =
=3D ce->start;
>>>>>>>> -=C2=A0=C2=A0=C2=A0 } else {
>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 last_bg_in_old_root =
=3D (u64)-1;
>>>>>>>> -=C2=A0=C2=A0=C2=A0 }
>>>>>>>> -
>>>>>>>> -=C2=A0=C2=A0=C2=A0 key.type =3D BTRFS_BLOCK_GROUP_ITEM_KEY;
>>>>>>>> -
>>>>>>>> -=C2=A0=C2=A0=C2=A0 while (true) {
>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D find_first_bl=
ock_group(root, &path, &key);
>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret > 0) {
>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ret =3D 0;
>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 goto out;
>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret !=3D 0) {
>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 goto out;
>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_item_key_to_cpu=
(path.nodes[0], &key, path.slots[0]);
>>>>>>>> -
>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D read_one_bloc=
k_group(fs_info, &path);
>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0 && ret !=
=3D -ENOENT)
>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 goto out;
>>>>>>>> -
>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* We have reached la=
st bg in the old root, no need to
>>>>>>>> continue */
>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (key.objectid >=3D=
 last_bg_in_old_root)
>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 break;
>>>>>>>> -
>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (key.offset =3D=3D=
 0)
>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 key.objectid++;
>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 key.objectid =3D key.objectid + key.offset;
>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 key.offset =3D 0;
>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_release_path(&p=
ath);
>>>>>>>> -=C2=A0=C2=A0=C2=A0 }
>>>>>>>> -=C2=A0=C2=A0=C2=A0 ret =3D 0;
>>>>>>>> -out:
>>>>>>>> -=C2=A0=C2=A0=C2=A0 btrfs_release_path(&path);
>>>>>>>> -=C2=A0=C2=A0=C2=A0 return ret;
>>>>>>>> -}
>>>>>>>> -
>>>>>>>> =C2=A0=C2=A0=C2=A0 /* Helper to read all block groups items from =
specified
>>>>>>>> root. */
>>>>>>>> =C2=A0=C2=A0=C2=A0 static int read_block_groups_from_root(struct =
btrfs_fs_info
>>>>>>>> *fs_info,
>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 struct btrfs_root *root)
>>>>>>>> @@ -2989,7 +2912,7 @@ static int
>>>>>>>> read_converting_block_groups(struct
>>>>>>>> btrfs_fs_info *fs_info)
>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return ret;
>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>>>> -=C2=A0=C2=A0=C2=A0 ret =3D read_old_block_groups_from_root(fs_in=
fo, old_root);
>>>>>>>> +=C2=A0=C2=A0=C2=A0 ret =3D read_block_groups_from_root(fs_info, =
old_root);
>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 error("failed to load block groups from the old
>>>>>>>> root: %d",
>>>>>>>> ret);
>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return ret;
>>>>>
>>>

--------------ssFPKEgTjNR19u6TJoMHMBBg
Content-Type: text/plain; charset=UTF-8; name="diff"
Content-Disposition: attachment; filename="diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3R1bmUvY29udmVydC1iZ3QuYyBiL3R1bmUvY29udmVydC1iZ3QuYwpp
bmRleCA3N2NiYTM5MzBhZTEuLjE5NmUwZjgxYTE3NiAxMDA2NDQKLS0tIGEvdHVuZS9jb252
ZXJ0LWJndC5jCisrKyBiL3R1bmUvY29udmVydC1iZ3QuYwpAQCAtMjgsNyArMjgsNyBAQAog
I2luY2x1ZGUgInR1bmUvdHVuZS5oIgogCiAvKiBBZnRlciB0aGlzIG1hbnkgYmxvY2sgZ3Jv
dXBzIHdlIG5lZWQgdG8gY29tbWl0IHRyYW5zYWN0aW9uLiAqLwotI2RlZmluZSBCTE9DS19H
Uk9VUF9CQVRDSAk2NAorI2RlZmluZSBCTE9DS19HUk9VUF9CQVRDSAk0CiAKIGludCBjb252
ZXJ0X3RvX2JnX3RyZWUoc3RydWN0IGJ0cmZzX2ZzX2luZm8gKmZzX2luZm8pCiB7Cg==

--------------ssFPKEgTjNR19u6TJoMHMBBg--
