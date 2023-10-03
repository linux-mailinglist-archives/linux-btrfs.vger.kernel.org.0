Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3B87B664A
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Oct 2023 12:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbjJCKV7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Oct 2023 06:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbjJCKV6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Oct 2023 06:21:58 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BBE4B0
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Oct 2023 03:21:53 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9ad810be221so130164566b.2
        for <linux-btrfs@vger.kernel.org>; Tue, 03 Oct 2023 03:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696328512; x=1696933312; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zE5AWSjrRzl0mK7pt+m4T/mdWBimx1pSEIodJ7Vnnd0=;
        b=hxbVsitiivfRBtQZj3wviHorP+9rIo2syfrB4iv8pb9ooK8ZHidCibg6wKqFW3UM8t
         FgUWqXVQL9SLv0+T3/SDZQmi6BA1JkRCfH9A7pwX5Ok/FVbWYO8VQL9fspPqrSJfWZCP
         Eado5qXCO8ZXDStiMSaqyHzoX6vPz6BNxgMhf4ZaZ1ijAz8v7OP1zt1HLqoTXpa0z7pz
         pHDBVIiAU2+O1IfgrRmI78uFR4FqVRg5G+u/6oQuvuff3PTsCma1lzs8/GVoDrWdY9x/
         0po2rsLliMiRF9iAtbkKhKPxc0p/klF2esbVXCDdZ8mi2rcWsX+mCxFWpg6ucE0NIwhK
         ys/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696328512; x=1696933312;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zE5AWSjrRzl0mK7pt+m4T/mdWBimx1pSEIodJ7Vnnd0=;
        b=q4mmgIF8CBD01kXuVRQbgTrF71OY6cxjm0FKpxZk6dpWUK0Dp6/Eux2DiGR2EjGF79
         c/PXwdQnJoWr/LNYg9p8H0PuFb5SBebCqbVS+EdyznDa8ARyEaDnlqsPWbh4S7deFUY1
         XBFnDsycRinF7VoHGPaYwh0JfV+E5fMbThak3cTNRT/mjw5McSjHG3XpPbYftjsbHK85
         9BqbjGZNwYa26Nbtn30OhwIpOTsR15BtO6tlAtBrkdRDb/hfEcYlotfzaN7B3Q5D8ClP
         UiL7V/9uPTgn/Y+Hd78nmGx6DRTK+JZeV/kp0ILFixLT8zjdgN9vlc8MKHpxI0aNk+B0
         DjlQ==
X-Gm-Message-State: AOJu0YwaUkaxjAtiWMIf/WnyUq2FcV3VKfwEn5yphLBl3S0PW7ieJ0Ja
        Qjq0i8MPHA/+ZarMSbk/5C4=
X-Google-Smtp-Source: AGHT+IGoEKXKiEUiC0M4SvWG2WYeibxEnYFIIAWA9147u3L5EZjf361gSRTjpAIcuWFvcXvUsifJKA==
X-Received: by 2002:a17:906:5384:b0:9b2:b119:4909 with SMTP id g4-20020a170906538400b009b2b1194909mr12911118ejo.75.1696328511485;
        Tue, 03 Oct 2023 03:21:51 -0700 (PDT)
Received: from [192.168.3.88] (ppp-94-68-116-207.home.otenet.gr. [94.68.116.207])
        by smtp.googlemail.com with ESMTPSA id xo22-20020a170907bb9600b009b2d46425absm818857ejc.85.2023.10.03.03.21.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Oct 2023 03:21:50 -0700 (PDT)
Message-ID: <d609fc7b-0d89-8c08-45e2-156aa3b22dd0@gmail.com>
Date:   Tue, 3 Oct 2023 13:21:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] btrfs-progs: fix failed resume due to bad search
Content-Language: el-en, en-US
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
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
 <77b9d0ba-f0b0-4258-8336-d3687d204967@gmx.com>
 <a090f004-28c5-dcaa-793b-c03368ebbe2f@gmail.com>
 <e4df02ff-d141-4878-9536-ae5c4e4ffbb3@gmx.com>
From:   Konstantinos Skarlatos <k.skarlatos@gmail.com>
In-Reply-To: <e4df02ff-d141-4878-9536-ae5c4e4ffbb3@gmx.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 03/10/2023 3:01 π.μ., Qu Wenruo wrote:
>
>
> On 2023/10/2 21:02, Konstantinos Skarlatos wrote:
> [...]
>>>>
>>>>
>>>> Hi Qu,
>>>>
>>>> i applied the patch over your previous patch and i got another seg
>>>> fault :(
>>>>
>>>> the latest df i have from my logs is:
>>>>
>>>> Filesystem     1M-blocks     Used Available Use% Mounted on
>>>>
>>>> /dev/sda        11446344 10109559    748884  94% /storage/btrfs
>>>
>>> Unfortunately vanilla df is not good enough for this case.
>>>
>>> As the main concern here is about the metadata usage, which doesn't
>>> really show up.
>>
>> Is there a way to check for metadata usage with this filesystem?
>
> There is a way, `btrfs filesystem df <mnt>` and `btrfs filesystem usage
> <mnt>`
>
> The problem is, those methods need to mount the fs, which is no yet
> possible due to the conversion failure.
>
>> Maybe there should be a warning that this can happen, or some kind of
>> check by btrfstune so somebody else can avoid this problem?
>
> It's a problem in btrfstune, which is using too small metadata
> reservation for each transaction.
> And maybe a bug in btrfs-progs code base.
>
> Anyway, I'll also send a patch to address the metadata reservation
> problem for btrfstune very soon.

Hi Qu, thank you for everything.
I learned a lot during this bug investigation!

Kind regards,
>
> [...]
>>> And every crash you reported is related to free space tree code, I'm
>>> not
>>> sure if that's the root cause.
>>>
>>> But for now, if you really need I can provide a patch to forcefully
>>> remove the converting flag, and then you should be able to mount the fs
>>> read-only using "-o rescue=all" mount option. (mostly to salvage data).
>>>
>>> Otherwise I hardly see a proper way to pin down why we always crash at
>>> free space tree code.
>>
>> As i have backups for my data, i will not need the patch, i just want to
>> help fix this bug.
>>
>> But from what you are saying i understand that there is no reason for me
>> to keep this filesystem anymore, correct?
>
> Yes, feel free to reformat the fs.
>
> Thanks
> Qu
>>
>> In any case, thank you for helping me out!
>>
>> Kind regards,
>> Konstantinos Skarlatos
>>>
>>> Thanks,
>>> Qu
>>>> #9  0x00005555555a01ed in update_free_space_extent_count
>>>> (trans=0x555567d491d0, block_group=0x55555fcc7710,
>>>> path=0x55556a180e90,
>>>> new_extents=1)
>>>>       at kernel-shared/free-space-tree.c:525
>>>> #10 0x00005555555a07ae in modify_free_space_bitmap
>>>> (trans=0x555567d491d0, block_group=0x55555fcc7710,
>>>> path=0x55556a180e90,
>>>> start=17592699748352, size=16384,
>>>>       remove=0) at kernel-shared/free-space-tree.c:707
>>>> #11 0x00005555555a0ff2 in __add_to_free_space_tree
>>>> (trans=0x555567d491d0, block_group=0x55555fcc7710,
>>>> path=0x55556a180e90,
>>>> start=17592699748352, size=16384)
>>>>       at kernel-shared/free-space-tree.c:997
>>>> #12 0x00005555555a10ad in add_to_free_space_tree
>>>> (trans=0x555567d491d0,
>>>> start=17592699748352, size=16384) at
>>>> kernel-shared/free-space-tree.c:1028
>>>> #13 0x0000555555591db8 in __free_extent (trans=0x555567d491d0,
>>>> bytenr=17592699748352, num_bytes=16384, parent=0, root_objectid=2,
>>>> owner_objectid=0,
>>>>       owner_offset=0, refs_to_drop=1) at
>>>> kernel-shared/extent-tree.c:2130
>>>> #14 0x000055555559651c in run_delayed_tree_ref (trans=0x555567d491d0,
>>>> fs_info=0x5555556672f0, node=0x5555695d3570, extent_op=0x0,
>>>> insert_reserved=0)
>>>>       at kernel-shared/extent-tree.c:3906
>>>> #15 0x00005555555965b1 in run_one_delayed_ref (trans=0x555567d491d0,
>>>> fs_info=0x5555556672f0, node=0x5555695d3570, extent_op=0x0,
>>>> insert_reserved=0)
>>>>       at kernel-shared/extent-tree.c:3926
>>>> #16 0x00005555555967de in btrfs_run_delayed_refs
>>>> (trans=0x555567d491d0,
>>>> nr=18446744073709551615) at kernel-shared/extent-tree.c:4010
>>>> #17 0x00005555555afbd1 in btrfs_commit_transaction
>>>> (trans=0x555567d491d0, root=0x55555567bc90) at
>>>> kernel-shared/transaction.c:210
>>>> #18 0x0000555555566b19 in convert_to_bg_tree
>>>> (fs_info=0x5555556672f0) at
>>>> tune/convert-bgt.c:112
>>>> #19 0x00005555555647bb in main (argc=3, argv=0x7fffffffe288) at
>>>> tune/main.c:393
>>>>
>>>> Kind regards,
>>>>
>>>>
>>>>>
>>>>>> Kind regards,
>>>>>>
>>>>>>
>>>>>>>> #2  0x00005555555c6964 in lookup_cache_extent
>>>>>>>> (tree=0x555555667358,
>>>>>>>> start=17820099854336, size=16384) at common/extent-cache.c:145
>>>>>>>> #3  0x0000555555597cac in alloc_extent_buffer
>>>>>>>> (fs_info=0x5555556672f0,
>>>>>>>> bytenr=17820099854336, blocksize=16384) at
>>>>>>>> kernel-shared/extent_io.c:262
>>>>>>>> #4  0x000055555558253b in btrfs_find_create_tree_block
>>>>>>>> (fs_info=0x5555556672f0, bytenr=17820099854336) at
>>>>>>>> kernel-shared/disk-io.c:232
>>>>>>>> #5  0x0000555555582cdb in read_tree_block (fs_info=0x5555556672f0,
>>>>>>>> bytenr=17820099854336, owner_root=10, parent_transid=1833250,
>>>>>>>> level=0,
>>>>>>>> first_key=0x0)
>>>>>>>>       at kernel-shared/disk-io.c:439
>>>>>>>> #6  0x00005555555776bd in read_node_slot (fs_info=0x5555556672f0,
>>>>>>>> parent=0x55557571ba60, slot=154) at kernel-shared/ctree.c:850
>>>>>>>> #7  0x000055555557a644 in push_leaf_right (trans=0x555567b3d140,
>>>>>>>> root=0x5555558da740, path=0x5555757f0d30, data_size=25,
>>>>>>>> empty=0) at
>>>>>>>> kernel-shared/ctree.c:1965
>>>>>>>> #8  0x000055555557b7d1 in split_leaf (trans=0x555567b3d140,
>>>>>>>> root=0x5555558da740, ins_key=0x7fffffffdc50, path=0x5555757f0d30,
>>>>>>>> data_size=25, extend=0)
>>>>>>>>       at kernel-shared/ctree.c:2338
>>>>>>>> #9  0x0000555555578fc0 in btrfs_search_slot (trans=0x555567b3d140,
>>>>>>>> root=0x5555558da740, key=0x7fffffffdc50, p=0x5555757f0d30,
>>>>>>>> ins_len=25,
>>>>>>>> cow=1) at kernel-shared/ctree.c:1399
>>>>>>>> #10 0x000055555557ca7d in btrfs_insert_empty_items
>>>>>>>> (trans=0x555567b3d140, root=0x5555558da740, path=0x5555757f0d30,
>>>>>>>> cpu_key=0x7fffffffdc50, data_size=0x7fffffffdb6c, nr=1)
>>>>>>>>       at kernel-shared/ctree.c:2758
>>>>>>>> #11 0x000055555559eb70 in btrfs_insert_empty_item
>>>>>>>> (trans=0x555567b3d140,
>>>>>>>> root=0x5555558da740, path=0x5555757f0d30, key=0x7fffffffdc50,
>>>>>>>> data_size=0)
>>>>>>>>       at ./kernel-shared/ctree.h:1019
>>>>>>>> #12 0x000055555559ff9a in convert_free_space_to_extents
>>>>>>>> (trans=0x555567b3d140, block_group=0x55555fcc7780,
>>>>>>>> path=0x5555757f0d30)
>>>>>>>> at kernel-shared/free-space-tree.c:465
>>>>>>>> #13 0x00005555555a01ed in update_free_space_extent_count
>>>>>>>> (trans=0x555567b3d140, block_group=0x55555fcc7780,
>>>>>>>> path=0x5555757f0d30,
>>>>>>>> new_extents=1)
>>>>>>>>       at kernel-shared/free-space-tree.c:525
>>>>>>>> #14 0x00005555555a07ae in modify_free_space_bitmap
>>>>>>>> (trans=0x555567b3d140, block_group=0x55555fcc7780,
>>>>>>>> path=0x5555757f0d30,
>>>>>>>> start=17592699748352, size=16384, remove=0)
>>>>>>>>       at kernel-shared/free-space-tree.c:707
>>>>>>>> #15 0x00005555555a0ff2 in __add_to_free_space_tree
>>>>>>>> (trans=0x555567b3d140, block_group=0x55555fcc7780,
>>>>>>>> path=0x5555757f0d30,
>>>>>>>> start=17592699748352, size=16384)
>>>>>>>>       at kernel-shared/free-space-tree.c:997
>>>>>>>> #16 0x00005555555a10ad in add_to_free_space_tree
>>>>>>>> (trans=0x555567b3d140,
>>>>>>>> start=17592699748352, size=16384) at
>>>>>>>> kernel-shared/free-space-tree.c:1028
>>>>>>>> #17 0x0000555555591db8 in __free_extent (trans=0x555567b3d140,
>>>>>>>> bytenr=17592699748352, num_bytes=16384, parent=0, root_objectid=2,
>>>>>>>> owner_objectid=0, owner_offset=0,
>>>>>>>>       refs_to_drop=1) at kernel-shared/extent-tree.c:2130
>>>>>>>> #18 0x000055555559651c in run_delayed_tree_ref
>>>>>>>> (trans=0x555567b3d140,
>>>>>>>> fs_info=0x5555556672f0, node=0x55556bf11090, extent_op=0x0,
>>>>>>>> insert_reserved=0)
>>>>>>>>       at kernel-shared/extent-tree.c:3906
>>>>>>>> #19 0x00005555555965b1 in run_one_delayed_ref
>>>>>>>> (trans=0x555567b3d140,
>>>>>>>> fs_info=0x5555556672f0, node=0x55556bf11090, extent_op=0x0,
>>>>>>>> insert_reserved=0)
>>>>>>>>       at kernel-shared/extent-tree.c:3926
>>>>>>>> #20 0x00005555555967de in btrfs_run_delayed_refs
>>>>>>>> (trans=0x555567b3d140,
>>>>>>>> nr=18446744073709551615) at kernel-shared/extent-tree.c:4010
>>>>>>>> #21 0x00005555555afbd1 in btrfs_commit_transaction
>>>>>>>> (trans=0x555567b3d140, root=0x55555567bd70) at
>>>>>>>> kernel-shared/transaction.c:210
>>>>>>>> #22 0x0000555555566b19 in convert_to_bg_tree
>>>>>>>> (fs_info=0x5555556672f0) at
>>>>>>>> tune/convert-bgt.c:112
>>>>>>>> #23 0x00005555555647bb in main (argc=3, argv=0x7fffffffe298) at
>>>>>>>> tune/main.c:393
>>>>>>>> (gdb)
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>> Thanks,
>>>>>>>>> Qu
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> Sep 28 17:46:17 elsinki kernel: btrfstune[796483]: segfault at
>>>>>>>>>>>> ffffffffff000f2f ip 0000564b6c2107aa sp 00007ffdc8ad25c8 error
>>>>>>>>>>>> 5 in
>>>>>>>>>>>> btrfstune[564b6c1d1000+5b000] likely on CPU 3 (core 2,
>>>>>>>>>>>> socket 0)
>>>>>>>>>>>> Sep 28 17:46:17 elsinki kernel: Code: ff 48 8b 34 24 48 8d
>>>>>>>>>>>> 3d 5a
>>>>>>>>>>>> d8 01
>>>>>>>>>>>> 00 b8 00 00 00 00 e8 5a 37 00 00 48 8b 33 bf 0a 00 00 00 e8
>>>>>>>>>>>> 1d 0c
>>>>>>>>>>>> fc ff
>>>>>>>>>>>> eb a8 e8 86 0a fc ff <48> 8b 4f 20 48 8b 56 08 48 89 c8 48
>>>>>>>>>>>> 03 47
>>>>>>>>>>>> 28 48
>>>>>>>>>>>> 89 c7 b8 01 00 00
>>>>>>>>>>>> Sep 28 17:46:17 elsinki systemd[1]: Created slice Slice
>>>>>>>>>>>> /system/systemd-coredump.
>>>>>>>>>>>> Sep 28 17:46:17 elsinki systemd[1]: Started Process Core Dump
>>>>>>>>>>>> (PID
>>>>>>>>>>>> 796493/UID 0).
>>>>>>>>>>>> Sep 28 17:46:21 elsinki systemd-coredump[796494]: [🡕] Process
>>>>>>>>>>>> 796483
>>>>>>>>>>>> (btrfstune) of user 0 dumped core.
>>>>>>>>>>>>
>>>>>>>>>>>> Stack trace of
>>>>>>>>>>>> thread
>>>>>>>>>>>> 796483:
>>>>>>>>>>>> #0
>>>>>>>>>>>> 0x0000564b6c2107aa
>>>>>>>>>>>> n/a (/root/btrfs-progs/btrfstune + 0x4d7aa)
>>>>>>>>>>>> ELF object
>>>>>>>>>>>> binary
>>>>>>>>>>>> architecture: AMD x86-64
>>>>>>>>>>>> Sep 28 17:46:21 elsinki systemd[1]:
>>>>>>>>>>>> systemd-coredump@0-796493-0.service:
>>>>>>>>>>>> Deactivated successfully.
>>>>>>>>>>>> Sep 28 17:46:21 elsinki systemd[1]:
>>>>>>>>>>>> systemd-coredump@0-796493-0.service:
>>>>>>>>>>>> Consumed 4.248s CPU time.
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> On 28/9/2023 1:50 π.μ., Qu Wenruo wrote:
>>>>>>>>>>>>> [BUG]
>>>>>>>>>>>>> There is a bug report that when converting to bg tree
>>>>>>>>>>>>> crashed,
>>>>>>>>>>>>> the
>>>>>>>>>>>>> resulted fs is unable to be resumed.
>>>>>>>>>>>>>
>>>>>>>>>>>>> This problems comes with the following error messages:
>>>>>>>>>>>>>
>>>>>>>>>>>>>       ./btrfstune --convert-to-block-group-tree /dev/sda
>>>>>>>>>>>>>       ERROR: Corrupted fs, no valid METADATA block group
>>>>>>>>>>>>> found
>>>>>>>>>>>>>       ERROR: failed to delete block group item from the old
>>>>>>>>>>>>> root:
>>>>>>>>>>>>> -117
>>>>>>>>>>>>>       ERROR: failed to convert the filesystem to block group
>>>>>>>>>>>>> tree
>>>>>>>>>>>>> feature
>>>>>>>>>>>>>       ERROR: btrfstune failed
>>>>>>>>>>>>>       extent buffer leak: start 17825576632320 len 16384
>>>>>>>>>>>>>
>>>>>>>>>>>>> [CAUSE]
>>>>>>>>>>>>> When resuming a interrupted conversion, we go through
>>>>>>>>>>>>> read_converting_block_groups() to handle block group items in
>>>>>>>>>>>>> both
>>>>>>>>>>>>> extent and block group trees.
>>>>>>>>>>>>>
>>>>>>>>>>>>> However for the block group items in the extent tree,
>>>>>>>>>>>>> there are
>>>>>>>>>>>>> several
>>>>>>>>>>>>> problems involved:
>>>>>>>>>>>>>
>>>>>>>>>>>>> - Uninitialized @key inside read_old_block_groups_from_root()
>>>>>>>>>>>>>       Here we only set @key.type, not setting
>>>>>>>>>>>>> @key.objectid for
>>>>>>>>>>>>> the
>>>>>>>>>>>>> initial
>>>>>>>>>>>>>       search.
>>>>>>>>>>>>>
>>>>>>>>>>>>>       Thus if we're unlukcy, we can got (u64)-1 as
>>>>>>>>>>>>> key.objectid, and
>>>>>>>>>>>>> exit
>>>>>>>>>>>>>       the search immediately.
>>>>>>>>>>>>>
>>>>>>>>>>>>> - Wrong search direction
>>>>>>>>>>>>>       The conversion is converting block groups in descending
>>>>>>>>>>>>> order,
>>>>>>>>>>>>> but the
>>>>>>>>>>>>>       block groups read is in ascending order.
>>>>>>>>>>>>>       Meaning if we start from the last converted block
>>>>>>>>>>>>> group, we
>>>>>>>>>>>>> would at
>>>>>>>>>>>>>       most read one block group.
>>>>>>>>>>>>>
>>>>>>>>>>>>> [FIX]
>>>>>>>>>>>>> To fix the problems, this patch would just remove
>>>>>>>>>>>>> read_old_block_groups_from_root() function completely.
>>>>>>>>>>>>>
>>>>>>>>>>>>> As for the conversion, we ensured the block group item is
>>>>>>>>>>>>> either
>>>>>>>>>>>>> in the
>>>>>>>>>>>>> old extent or the new block group tree.
>>>>>>>>>>>>> Thus there is no special handling needed reading block
>>>>>>>>>>>>> groups.
>>>>>>>>>>>>>
>>>>>>>>>>>>> We only need to read all block groups from both trees, using
>>>>>>>>>>>>> the
>>>>>>>>>>>>> same
>>>>>>>>>>>>> read_old_block_groups_from_root() function.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Reported-by: Konstantinos Skarlatos <k.skarlatos@gmail.com>
>>>>>>>>>>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>>>>>>>>>>> ---
>>>>>>>>>>>>> To Konstantinos:
>>>>>>>>>>>>>
>>>>>>>>>>>>> The bug I fixed here can explain all the failures you hit
>>>>>>>>>>>>> (the
>>>>>>>>>>>>> initial
>>>>>>>>>>>>> one and the one after the quick diff).
>>>>>>>>>>>>>
>>>>>>>>>>>>> Please verify if this helps and report back (without the
>>>>>>>>>>>>> quick
>>>>>>>>>>>>> diff in
>>>>>>>>>>>>> the original thread).
>>>>>>>>>>>>>
>>>>>>>>>>>>> We may have other corner cases to go, but I believe the patch
>>>>>>>>>>>>> itself is
>>>>>>>>>>>>> necessary no matter what, as the deleted code is really
>>>>>>>>>>>>> over-engineered and buggy.
>>>>>>>>>>>>> ---
>>>>>>>>>>>>>      kernel-shared/extent-tree.c | 79
>>>>>>>>>>>>> +------------------------------------
>>>>>>>>>>>>>      1 file changed, 1 insertion(+), 78 deletions(-)
>>>>>>>>>>>>>
>>>>>>>>>>>>> diff --git a/kernel-shared/extent-tree.c
>>>>>>>>>>>>> b/kernel-shared/extent-tree.c
>>>>>>>>>>>>> index 7022643a9843..4d6bf2b228e9 100644
>>>>>>>>>>>>> --- a/kernel-shared/extent-tree.c
>>>>>>>>>>>>> +++ b/kernel-shared/extent-tree.c
>>>>>>>>>>>>> @@ -2852,83 +2852,6 @@ out:
>>>>>>>>>>>>>          return ret;
>>>>>>>>>>>>>      }
>>>>>>>>>>>>> -/*
>>>>>>>>>>>>> - * Helper to read old block groups items from specified
>>>>>>>>>>>>> root.
>>>>>>>>>>>>> - *
>>>>>>>>>>>>> - * The difference between this and
>>>>>>>>>>>>> read_block_groups_from_root() is,
>>>>>>>>>>>>> - * we will exit if we have already read the last bg in
>>>>>>>>>>>>> the old
>>>>>>>>>>>>> root.
>>>>>>>>>>>>> - *
>>>>>>>>>>>>> - * This is to avoid wasting time finding bg items which
>>>>>>>>>>>>> should be
>>>>>>>>>>>>> in the
>>>>>>>>>>>>> - * new root.
>>>>>>>>>>>>> - */
>>>>>>>>>>>>> -static int read_old_block_groups_from_root(struct
>>>>>>>>>>>>> btrfs_fs_info
>>>>>>>>>>>>> *fs_info,
>>>>>>>>>>>>> -                       struct btrfs_root *root)
>>>>>>>>>>>>> -{
>>>>>>>>>>>>> -    struct btrfs_path path = {0};
>>>>>>>>>>>>> -    struct btrfs_key key;
>>>>>>>>>>>>> -    struct cache_extent *ce;
>>>>>>>>>>>>> -    /* The last block group bytenr in the old root. */
>>>>>>>>>>>>> -    u64 last_bg_in_old_root;
>>>>>>>>>>>>> -    int ret;
>>>>>>>>>>>>> -
>>>>>>>>>>>>> -    if (fs_info->last_converted_bg_bytenr != (u64)-1) {
>>>>>>>>>>>>> -        /*
>>>>>>>>>>>>> -         * We know the last converted bg in the other tree,
>>>>>>>>>>>>> load the
>>>>>>>>>>>>> chunk
>>>>>>>>>>>>> -         * before that last converted as our last bg in the
>>>>>>>>>>>>> tree.
>>>>>>>>>>>>> -         */
>>>>>>>>>>>>> -        ce =
>>>>>>>>>>>>> search_cache_extent(&fs_info->mapping_tree.cache_tree,
>>>>>>>>>>>>> - fs_info->last_converted_bg_bytenr);
>>>>>>>>>>>>> -        if (!ce || ce->start !=
>>>>>>>>>>>>> fs_info->last_converted_bg_bytenr) {
>>>>>>>>>>>>> -            error("no chunk found for bytenr %llu",
>>>>>>>>>>>>> - fs_info->last_converted_bg_bytenr);
>>>>>>>>>>>>> -            return -ENOENT;
>>>>>>>>>>>>> -        }
>>>>>>>>>>>>> -        ce = prev_cache_extent(ce);
>>>>>>>>>>>>> -        /*
>>>>>>>>>>>>> -         * We should have previous unconverted chunk, or we
>>>>>>>>>>>>> have
>>>>>>>>>>>>> -         * already finished the convert.
>>>>>>>>>>>>> -         */
>>>>>>>>>>>>> -        ASSERT(ce);
>>>>>>>>>>>>> -
>>>>>>>>>>>>> -        last_bg_in_old_root = ce->start;
>>>>>>>>>>>>> -    } else {
>>>>>>>>>>>>> -        last_bg_in_old_root = (u64)-1;
>>>>>>>>>>>>> -    }
>>>>>>>>>>>>> -
>>>>>>>>>>>>> -    key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
>>>>>>>>>>>>> -
>>>>>>>>>>>>> -    while (true) {
>>>>>>>>>>>>> -        ret = find_first_block_group(root, &path, &key);
>>>>>>>>>>>>> -        if (ret > 0) {
>>>>>>>>>>>>> -            ret = 0;
>>>>>>>>>>>>> -            goto out;
>>>>>>>>>>>>> -        }
>>>>>>>>>>>>> -        if (ret != 0) {
>>>>>>>>>>>>> -            goto out;
>>>>>>>>>>>>> -        }
>>>>>>>>>>>>> -        btrfs_item_key_to_cpu(path.nodes[0], &key,
>>>>>>>>>>>>> path.slots[0]);
>>>>>>>>>>>>> -
>>>>>>>>>>>>> -        ret = read_one_block_group(fs_info, &path);
>>>>>>>>>>>>> -        if (ret < 0 && ret != -ENOENT)
>>>>>>>>>>>>> -            goto out;
>>>>>>>>>>>>> -
>>>>>>>>>>>>> -        /* We have reached last bg in the old root, no
>>>>>>>>>>>>> need to
>>>>>>>>>>>>> continue */
>>>>>>>>>>>>> -        if (key.objectid >= last_bg_in_old_root)
>>>>>>>>>>>>> -            break;
>>>>>>>>>>>>> -
>>>>>>>>>>>>> -        if (key.offset == 0)
>>>>>>>>>>>>> -            key.objectid++;
>>>>>>>>>>>>> -        else
>>>>>>>>>>>>> -            key.objectid = key.objectid + key.offset;
>>>>>>>>>>>>> -        key.offset = 0;
>>>>>>>>>>>>> -        btrfs_release_path(&path);
>>>>>>>>>>>>> -    }
>>>>>>>>>>>>> -    ret = 0;
>>>>>>>>>>>>> -out:
>>>>>>>>>>>>> -    btrfs_release_path(&path);
>>>>>>>>>>>>> -    return ret;
>>>>>>>>>>>>> -}
>>>>>>>>>>>>> -
>>>>>>>>>>>>>      /* Helper to read all block groups items from specified
>>>>>>>>>>>>> root. */
>>>>>>>>>>>>>      static int read_block_groups_from_root(struct
>>>>>>>>>>>>> btrfs_fs_info
>>>>>>>>>>>>> *fs_info,
>>>>>>>>>>>>>                             struct btrfs_root *root)
>>>>>>>>>>>>> @@ -2989,7 +2912,7 @@ static int
>>>>>>>>>>>>> read_converting_block_groups(struct
>>>>>>>>>>>>> btrfs_fs_info *fs_info)
>>>>>>>>>>>>>              return ret;
>>>>>>>>>>>>>          }
>>>>>>>>>>>>> -    ret = read_old_block_groups_from_root(fs_info,
>>>>>>>>>>>>> old_root);
>>>>>>>>>>>>> +    ret = read_block_groups_from_root(fs_info, old_root);
>>>>>>>>>>>>>          if (ret < 0) {
>>>>>>>>>>>>>              error("failed to load block groups from the old
>>>>>>>>>>>>> root: %d",
>>>>>>>>>>>>> ret);
>>>>>>>>>>>>>              return ret;
>>>>>>>>>>
>>>>>>>>
>>

