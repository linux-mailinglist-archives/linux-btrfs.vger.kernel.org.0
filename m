Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 715307B4060
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Sep 2023 15:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234083AbjI3NBs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 30 Sep 2023 09:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbjI3NBr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 30 Sep 2023 09:01:47 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C9CFA
        for <linux-btrfs@vger.kernel.org>; Sat, 30 Sep 2023 06:01:44 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-4054496bde3so132757285e9.1
        for <linux-btrfs@vger.kernel.org>; Sat, 30 Sep 2023 06:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696078902; x=1696683702; darn=vger.kernel.org;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gLaxE585BudwV60xabhk/F0PYq9mDFlzSQSdPvEWQS0=;
        b=IkdH7M/31NHBOTaUyp8Y7HAWCzSEGNKuJzvzWs0gW67WE4TTS91r4vLuPC4PMZ1TN+
         3o8KY2kNd3zeTqD/phljtgRPCGIguKpFcLYaKs7YLxhvtSLgzSvHAFjd0OTIOviwPx5U
         rjaZm0PhUSRzUsXC/FTWlsMPdJwP5bQMDXjTDkHJALs7XORkKPGlM4ei1gsfKrfR+ihM
         7O1+Y5+nNzxzWQXB+A5FcUFgUh4VACu87Gg3P64yrM+UtXmufrE4x9EVLvX4f4BziQ5Z
         4DOw+Y8xIYOsu4qclZM/JSDgCasw7TI+5MyXhxM9ebICauge5B4OoagJlu2UCQYcQm0f
         J5bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696078902; x=1696683702;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gLaxE585BudwV60xabhk/F0PYq9mDFlzSQSdPvEWQS0=;
        b=fRO2PSfkPPO6SQz+S3LTAGXKvuwyyREtxxTZSRmxYKRmhGQTe4Ys2mM9Ekq/LP3yBs
         8dl1kEn1S8ZYIgmciPksDcx8uP6xRa9spO5NOOjlBKCB/gT7i6wBP1k7H7NvrLGk8H0X
         Nz+gZ9e2Q1cZ3mBXrFkkkeAvZMMIC6dVmbrEmQvfneFoexwhvmp0Fjwakpv7EwbN+v+5
         8UYuJzv4bjB6ojkDe9JINBO6BgNxz/F/NezM8wqZZKH6xNLefatzrYDboMWRRQsjVaUy
         pYU2vnCCktl5EuQ9gmdl/GYLesVOcDsVMmK2QRItm2mTfmYH0nSE4JW80hgH7mDADght
         o+Qw==
X-Gm-Message-State: AOJu0Ywi/2Gy6gZS3FMn37KMJoQDkMi7pFUWutAu7HXYxRL1CrjD6mK4
        SClaozzRkFhnFmL3tevDj5WKw2MGPhkZbw==
X-Google-Smtp-Source: AGHT+IEa2UeDNsen3Blqxg/WmKwE9IZdR/ON1SFT0Rnwi83xSCLEVYjvJyVzO5cf3GTUfbSRwa1hhA==
X-Received: by 2002:a7b:c44f:0:b0:402:ee71:29 with SMTP id l15-20020a7bc44f000000b00402ee710029mr6018824wmi.10.1696078901821;
        Sat, 30 Sep 2023 06:01:41 -0700 (PDT)
Received: from [192.168.1.121] (athedsl-161999.home.otenet.gr. [85.75.176.109])
        by smtp.googlemail.com with ESMTPSA id 17-20020a05600c029100b004064cd71aa8sm3373445wmk.34.2023.09.30.06.01.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Sep 2023 06:01:41 -0700 (PDT)
Subject: Re: [PATCH] btrfs-progs: fix failed resume due to bad search
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <840a9a762a3a0b8365d79dd7c23d812d95761dcf.1695855009.git.wqu@suse.com>
 <fc926390-38ea-f764-4377-25576b872b31@gmail.com>
 <e834fd8a-3c10-4b5c-9121-9812f460f73c@gmx.com>
 <c9fa7f88-5f3b-04f8-b18d-7d8490299538@gmail.com>
 <a59ee960-f493-47d5-918d-4386a4deecd3@gmx.com>
 <a7404485-0a85-49c2-afb8-769ad112dd8b@gmail.com>
 <cd390b15-7d42-41be-afc6-22c6fa22671d@gmx.com>
From:   Konstantinos Skarlatos <k.skarlatos@gmail.com>
Message-ID: <35bc07b9-2e6c-0848-661c-8e991cb5479a@gmail.com>
Date:   Sat, 30 Sep 2023 16:01:39 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <cd390b15-7d42-41be-afc6-22c6fa22671d@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On 30/9/2023 1:25 π.μ., Qu Wenruo wrote:
>
>
> On 2023/9/29 21:01, Konstantinos Skarlatos wrote:
>> On 29/09/2023 1:54 μ.μ., Qu Wenruo wrote:
>>>
>>>
>>> On 2023/9/29 19:03, Konstantinos Skarlatos wrote:
>>>> On 29/09/2023 12:56 π.μ., Qu Wenruo wrote:
>>>>>
>>>>>
>>>>> On 2023/9/29 00:23, Konstantinos Skarlatos wrote:
>>>>>> Hi Qu, thanks for your patch. I just tried it on a clean btrfs-progs
>>>>>> tree with my filesystem:
>>>>>>
>>>>>> ❯ ./btrfstune --convert-to-block-group-tree /dev/sda
>>>>>> [1]    796483 segmentation fault (core dumped) ./btrfstune
>>>>>> --convert-to-block-group-tree /dev/sda
>>>>>
>>>>> Mind to enable debug build by "make D=1" for btrfs-progs, and go with
>>>>> gdb to show the crash callback?
>>>>>
>>>>> I assume it could be the same crash from your initial report.
>>>>>
>>>>> Thanks,
>>>>> Qu
>>>>>
>>>>
>>>> Hi Qu, i hope i am doing this correctly...
>>>>
>>>>
>>>> ❯ gdb -ex=r --args ./btrfstune --convert-to-block-group-tree /dev/sda
>>>> GNU gdb (GDB) 13.2
>>>> Copyright (C) 2023 Free Software Foundation, Inc.
>>>> License GPLv3+: GNU GPL version 3 or later
>>>> <http://gnu.org/licenses/gpl.html>
>>>> This is free software: you are free to change and redistribute it.
>>>> There is NO WARRANTY, to the extent permitted by law.
>>>> Type "show copying" and "show warranty" for details.
>>>> This GDB was configured as "x86_64-pc-linux-gnu".
>>>> Type "show configuration" for configuration details.
>>>> For bug reporting instructions, please see:
>>>> <https://www.gnu.org/software/gdb/bugs/>.
>>>> Find the GDB manual and other documentation resources online at:
>>>> <http://www.gnu.org/software/gdb/documentation/>.
>>>>
>>>> For help, type "help".
>>>> Type "apropos word" to search for commands related to "word"...
>>>> Reading symbols from ./btrfstune...
>>>> Starting program: /root/btrfs-progs/btrfstune
>>>> --convert-to-block-group-tree /dev/sda
>>>>
>>>> This GDB supports auto-downloading debuginfo from the following URLs:
>>>>     <https://debuginfod.archlinux.org>
>>>> Enable debuginfod for this session? (y or [n]) y
>>>> Debuginfod has been enabled.
>>>> To make this setting permanent, add 'set debuginfod enabled on' to
>>>> .gdbinit.
>>>> Downloading separate debug info for /lib64/ld-linux-x86-64.so.2
>>>> Downloading separate debug info for system-supplied DSO at
>>>> 0x7ffff7fc8000
>>>> Downloading separate debug info for /usr/lib/libuuid.so.1
>>>> Downloading separate debug info for /usr/lib/libblkid.so.1
>>>> Downloading separate debug info for /usr/lib/libudev.so.1
>>>> Downloading separate debug info for /usr/lib/libc.so.6
>>>> [Thread debugging using libthread_db enabled]
>>>> Using host libthread_db library "/usr/lib/libthread_db.so.1".
>>>> Downloading separate debug info for /usr/lib/libcap.so.2
>>>>
>>>> Program received signal SIGSEGV, Segmentation fault.
>>>> 0x00005555555c6600 in cache_tree_comp_range (node=0xffffffffff000f0f,
>>>> data=0x7fffffffd780) at common/extent-cache.c:40
>>>> 40              if (entry->start + entry->size <= range->start)
>>>> (gdb)
>>>
>>> That's great, what about the output from "bt" command?
>>>
>>
>> Hi Qu, this is what i get:
>>
>> Program received signal SIGSEGV, Segmentation fault.
>> 0x00005555555c6600 in cache_tree_comp_range (node=0xffffffffff000f0f,
>> data=0x7fffffffd780) at common/extent-cache.c:40
>> 40              if (entry->start + entry->size <= range->start)
>> (gdb) bt
>> #0  0x00005555555c6600 in cache_tree_comp_range
>> (node=0xffffffffff000f0f, data=0x7fffffffd780) at 
>> common/extent-cache.c:40
>> #1  0x00005555555ce458 in rb_search (root=0x555555667358,
>> key=0x7fffffffd780, comp=0x5555555c65d8 <cache_tree_comp_range>,
>> next_ret=0x0) at common/rbtree-utils.c:59
>
> Indeed we're back to the initial crash you reported.
>
> The root cause is the @node pointer, which is not valid.
>
> I'm not sure why, but we got an invalid node inside the rb tree, which
> leads to the crash.
>
> Considering this is a rare one, I'll need more time to dig into the
> original crash.
> I'm afraid with this bug still here, we will not be able to do anything,
> neither reverting back or continuing the conversion.
>
> Thanks,
> Qu

Hello Qu,

does that mean that the filesystem is not recoverable?

I can keep it for a while if you need it for further debugging.

Kind regards,


>> #2  0x00005555555c6964 in lookup_cache_extent (tree=0x555555667358,
>> start=17820099854336, size=16384) at common/extent-cache.c:145
>> #3  0x0000555555597cac in alloc_extent_buffer (fs_info=0x5555556672f0,
>> bytenr=17820099854336, blocksize=16384) at kernel-shared/extent_io.c:262
>> #4  0x000055555558253b in btrfs_find_create_tree_block
>> (fs_info=0x5555556672f0, bytenr=17820099854336) at
>> kernel-shared/disk-io.c:232
>> #5  0x0000555555582cdb in read_tree_block (fs_info=0x5555556672f0,
>> bytenr=17820099854336, owner_root=10, parent_transid=1833250, level=0,
>> first_key=0x0)
>>      at kernel-shared/disk-io.c:439
>> #6  0x00005555555776bd in read_node_slot (fs_info=0x5555556672f0,
>> parent=0x55557571ba60, slot=154) at kernel-shared/ctree.c:850
>> #7  0x000055555557a644 in push_leaf_right (trans=0x555567b3d140,
>> root=0x5555558da740, path=0x5555757f0d30, data_size=25, empty=0) at
>> kernel-shared/ctree.c:1965
>> #8  0x000055555557b7d1 in split_leaf (trans=0x555567b3d140,
>> root=0x5555558da740, ins_key=0x7fffffffdc50, path=0x5555757f0d30,
>> data_size=25, extend=0)
>>      at kernel-shared/ctree.c:2338
>> #9  0x0000555555578fc0 in btrfs_search_slot (trans=0x555567b3d140,
>> root=0x5555558da740, key=0x7fffffffdc50, p=0x5555757f0d30, ins_len=25,
>> cow=1) at kernel-shared/ctree.c:1399
>> #10 0x000055555557ca7d in btrfs_insert_empty_items
>> (trans=0x555567b3d140, root=0x5555558da740, path=0x5555757f0d30,
>> cpu_key=0x7fffffffdc50, data_size=0x7fffffffdb6c, nr=1)
>>      at kernel-shared/ctree.c:2758
>> #11 0x000055555559eb70 in btrfs_insert_empty_item (trans=0x555567b3d140,
>> root=0x5555558da740, path=0x5555757f0d30, key=0x7fffffffdc50, 
>> data_size=0)
>>      at ./kernel-shared/ctree.h:1019
>> #12 0x000055555559ff9a in convert_free_space_to_extents
>> (trans=0x555567b3d140, block_group=0x55555fcc7780, path=0x5555757f0d30)
>> at kernel-shared/free-space-tree.c:465
>> #13 0x00005555555a01ed in update_free_space_extent_count
>> (trans=0x555567b3d140, block_group=0x55555fcc7780, path=0x5555757f0d30,
>> new_extents=1)
>>      at kernel-shared/free-space-tree.c:525
>> #14 0x00005555555a07ae in modify_free_space_bitmap
>> (trans=0x555567b3d140, block_group=0x55555fcc7780, path=0x5555757f0d30,
>> start=17592699748352, size=16384, remove=0)
>>      at kernel-shared/free-space-tree.c:707
>> #15 0x00005555555a0ff2 in __add_to_free_space_tree
>> (trans=0x555567b3d140, block_group=0x55555fcc7780, path=0x5555757f0d30,
>> start=17592699748352, size=16384)
>>      at kernel-shared/free-space-tree.c:997
>> #16 0x00005555555a10ad in add_to_free_space_tree (trans=0x555567b3d140,
>> start=17592699748352, size=16384) at 
>> kernel-shared/free-space-tree.c:1028
>> #17 0x0000555555591db8 in __free_extent (trans=0x555567b3d140,
>> bytenr=17592699748352, num_bytes=16384, parent=0, root_objectid=2,
>> owner_objectid=0, owner_offset=0,
>>      refs_to_drop=1) at kernel-shared/extent-tree.c:2130
>> #18 0x000055555559651c in run_delayed_tree_ref (trans=0x555567b3d140,
>> fs_info=0x5555556672f0, node=0x55556bf11090, extent_op=0x0,
>> insert_reserved=0)
>>      at kernel-shared/extent-tree.c:3906
>> #19 0x00005555555965b1 in run_one_delayed_ref (trans=0x555567b3d140,
>> fs_info=0x5555556672f0, node=0x55556bf11090, extent_op=0x0,
>> insert_reserved=0)
>>      at kernel-shared/extent-tree.c:3926
>> #20 0x00005555555967de in btrfs_run_delayed_refs (trans=0x555567b3d140,
>> nr=18446744073709551615) at kernel-shared/extent-tree.c:4010
>> #21 0x00005555555afbd1 in btrfs_commit_transaction
>> (trans=0x555567b3d140, root=0x55555567bd70) at
>> kernel-shared/transaction.c:210
>> #22 0x0000555555566b19 in convert_to_bg_tree (fs_info=0x5555556672f0) at
>> tune/convert-bgt.c:112
>> #23 0x00005555555647bb in main (argc=3, argv=0x7fffffffe298) at
>> tune/main.c:393
>> (gdb)
>>
>>
>>
>>> Thanks,
>>> Qu
>>>>
>>>>
>>>>
>>>>
>>>>>>
>>>>>> Sep 28 17:46:17 elsinki kernel: btrfstune[796483]: segfault at
>>>>>> ffffffffff000f2f ip 0000564b6c2107aa sp 00007ffdc8ad25c8 error 5 in
>>>>>> btrfstune[564b6c1d1000+5b000] likely on CPU 3 (core 2, socket 0)
>>>>>> Sep 28 17:46:17 elsinki kernel: Code: ff 48 8b 34 24 48 8d 3d 5a 
>>>>>> d8 01
>>>>>> 00 b8 00 00 00 00 e8 5a 37 00 00 48 8b 33 bf 0a 00 00 00 e8 1d 0c
>>>>>> fc ff
>>>>>> eb a8 e8 86 0a fc ff <48> 8b 4f 20 48 8b 56 08 48 89 c8 48 03 47 
>>>>>> 28 48
>>>>>> 89 c7 b8 01 00 00
>>>>>> Sep 28 17:46:17 elsinki systemd[1]: Created slice Slice
>>>>>> /system/systemd-coredump.
>>>>>> Sep 28 17:46:17 elsinki systemd[1]: Started Process Core Dump (PID
>>>>>> 796493/UID 0).
>>>>>> Sep 28 17:46:21 elsinki systemd-coredump[796494]: [🡕] Process 
>>>>>> 796483
>>>>>> (btrfstune) of user 0 dumped core.
>>>>>>
>>>>>> Stack trace of
>>>>>> thread
>>>>>> 796483:
>>>>>>                                                      #0
>>>>>> 0x0000564b6c2107aa
>>>>>> n/a (/root/btrfs-progs/btrfstune + 0x4d7aa)
>>>>>>                                                      ELF object 
>>>>>> binary
>>>>>> architecture: AMD x86-64
>>>>>> Sep 28 17:46:21 elsinki systemd[1]:
>>>>>> systemd-coredump@0-796493-0.service:
>>>>>> Deactivated successfully.
>>>>>> Sep 28 17:46:21 elsinki systemd[1]:
>>>>>> systemd-coredump@0-796493-0.service:
>>>>>> Consumed 4.248s CPU time.
>>>>>>
>>>>>>
>>>>>> On 28/9/2023 1:50 π.μ., Qu Wenruo wrote:
>>>>>>> [BUG]
>>>>>>> There is a bug report that when converting to bg tree crashed, the
>>>>>>> resulted fs is unable to be resumed.
>>>>>>>
>>>>>>> This problems comes with the following error messages:
>>>>>>>
>>>>>>>      ./btrfstune --convert-to-block-group-tree /dev/sda
>>>>>>>      ERROR: Corrupted fs, no valid METADATA block group found
>>>>>>>      ERROR: failed to delete block group item from the old root: 
>>>>>>> -117
>>>>>>>      ERROR: failed to convert the filesystem to block group tree
>>>>>>> feature
>>>>>>>      ERROR: btrfstune failed
>>>>>>>      extent buffer leak: start 17825576632320 len 16384
>>>>>>>
>>>>>>> [CAUSE]
>>>>>>> When resuming a interrupted conversion, we go through
>>>>>>> read_converting_block_groups() to handle block group items in both
>>>>>>> extent and block group trees.
>>>>>>>
>>>>>>> However for the block group items in the extent tree, there are
>>>>>>> several
>>>>>>> problems involved:
>>>>>>>
>>>>>>> - Uninitialized @key inside read_old_block_groups_from_root()
>>>>>>>      Here we only set @key.type, not setting @key.objectid for the
>>>>>>> initial
>>>>>>>      search.
>>>>>>>
>>>>>>>      Thus if we're unlukcy, we can got (u64)-1 as key.objectid, and
>>>>>>> exit
>>>>>>>      the search immediately.
>>>>>>>
>>>>>>> - Wrong search direction
>>>>>>>      The conversion is converting block groups in descending order,
>>>>>>> but the
>>>>>>>      block groups read is in ascending order.
>>>>>>>      Meaning if we start from the last converted block group, we
>>>>>>> would at
>>>>>>>      most read one block group.
>>>>>>>
>>>>>>> [FIX]
>>>>>>> To fix the problems, this patch would just remove
>>>>>>> read_old_block_groups_from_root() function completely.
>>>>>>>
>>>>>>> As for the conversion, we ensured the block group item is either
>>>>>>> in the
>>>>>>> old extent or the new block group tree.
>>>>>>> Thus there is no special handling needed reading block groups.
>>>>>>>
>>>>>>> We only need to read all block groups from both trees, using the 
>>>>>>> same
>>>>>>> read_old_block_groups_from_root() function.
>>>>>>>
>>>>>>> Reported-by: Konstantinos Skarlatos <k.skarlatos@gmail.com>
>>>>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>>>>> ---
>>>>>>> To Konstantinos:
>>>>>>>
>>>>>>> The bug I fixed here can explain all the failures you hit (the
>>>>>>> initial
>>>>>>> one and the one after the quick diff).
>>>>>>>
>>>>>>> Please verify if this helps and report back (without the quick
>>>>>>> diff in
>>>>>>> the original thread).
>>>>>>>
>>>>>>> We may have other corner cases to go, but I believe the patch
>>>>>>> itself is
>>>>>>> necessary no matter what, as the deleted code is really
>>>>>>> over-engineered and buggy.
>>>>>>> ---
>>>>>>>     kernel-shared/extent-tree.c | 79
>>>>>>> +------------------------------------
>>>>>>>     1 file changed, 1 insertion(+), 78 deletions(-)
>>>>>>>
>>>>>>> diff --git a/kernel-shared/extent-tree.c
>>>>>>> b/kernel-shared/extent-tree.c
>>>>>>> index 7022643a9843..4d6bf2b228e9 100644
>>>>>>> --- a/kernel-shared/extent-tree.c
>>>>>>> +++ b/kernel-shared/extent-tree.c
>>>>>>> @@ -2852,83 +2852,6 @@ out:
>>>>>>>         return ret;
>>>>>>>     }
>>>>>>> -/*
>>>>>>> - * Helper to read old block groups items from specified root.
>>>>>>> - *
>>>>>>> - * The difference between this and 
>>>>>>> read_block_groups_from_root() is,
>>>>>>> - * we will exit if we have already read the last bg in the old 
>>>>>>> root.
>>>>>>> - *
>>>>>>> - * This is to avoid wasting time finding bg items which should be
>>>>>>> in the
>>>>>>> - * new root.
>>>>>>> - */
>>>>>>> -static int read_old_block_groups_from_root(struct btrfs_fs_info
>>>>>>> *fs_info,
>>>>>>> -                       struct btrfs_root *root)
>>>>>>> -{
>>>>>>> -    struct btrfs_path path = {0};
>>>>>>> -    struct btrfs_key key;
>>>>>>> -    struct cache_extent *ce;
>>>>>>> -    /* The last block group bytenr in the old root. */
>>>>>>> -    u64 last_bg_in_old_root;
>>>>>>> -    int ret;
>>>>>>> -
>>>>>>> -    if (fs_info->last_converted_bg_bytenr != (u64)-1) {
>>>>>>> -        /*
>>>>>>> -         * We know the last converted bg in the other tree, 
>>>>>>> load the
>>>>>>> chunk
>>>>>>> -         * before that last converted as our last bg in the tree.
>>>>>>> -         */
>>>>>>> -        ce = 
>>>>>>> search_cache_extent(&fs_info->mapping_tree.cache_tree,
>>>>>>> - fs_info->last_converted_bg_bytenr);
>>>>>>> -        if (!ce || ce->start != 
>>>>>>> fs_info->last_converted_bg_bytenr) {
>>>>>>> -            error("no chunk found for bytenr %llu",
>>>>>>> - fs_info->last_converted_bg_bytenr);
>>>>>>> -            return -ENOENT;
>>>>>>> -        }
>>>>>>> -        ce = prev_cache_extent(ce);
>>>>>>> -        /*
>>>>>>> -         * We should have previous unconverted chunk, or we have
>>>>>>> -         * already finished the convert.
>>>>>>> -         */
>>>>>>> -        ASSERT(ce);
>>>>>>> -
>>>>>>> -        last_bg_in_old_root = ce->start;
>>>>>>> -    } else {
>>>>>>> -        last_bg_in_old_root = (u64)-1;
>>>>>>> -    }
>>>>>>> -
>>>>>>> -    key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
>>>>>>> -
>>>>>>> -    while (true) {
>>>>>>> -        ret = find_first_block_group(root, &path, &key);
>>>>>>> -        if (ret > 0) {
>>>>>>> -            ret = 0;
>>>>>>> -            goto out;
>>>>>>> -        }
>>>>>>> -        if (ret != 0) {
>>>>>>> -            goto out;
>>>>>>> -        }
>>>>>>> -        btrfs_item_key_to_cpu(path.nodes[0], &key, path.slots[0]);
>>>>>>> -
>>>>>>> -        ret = read_one_block_group(fs_info, &path);
>>>>>>> -        if (ret < 0 && ret != -ENOENT)
>>>>>>> -            goto out;
>>>>>>> -
>>>>>>> -        /* We have reached last bg in the old root, no need to
>>>>>>> continue */
>>>>>>> -        if (key.objectid >= last_bg_in_old_root)
>>>>>>> -            break;
>>>>>>> -
>>>>>>> -        if (key.offset == 0)
>>>>>>> -            key.objectid++;
>>>>>>> -        else
>>>>>>> -            key.objectid = key.objectid + key.offset;
>>>>>>> -        key.offset = 0;
>>>>>>> -        btrfs_release_path(&path);
>>>>>>> -    }
>>>>>>> -    ret = 0;
>>>>>>> -out:
>>>>>>> -    btrfs_release_path(&path);
>>>>>>> -    return ret;
>>>>>>> -}
>>>>>>> -
>>>>>>>     /* Helper to read all block groups items from specified 
>>>>>>> root. */
>>>>>>>     static int read_block_groups_from_root(struct btrfs_fs_info
>>>>>>> *fs_info,
>>>>>>>                            struct btrfs_root *root)
>>>>>>> @@ -2989,7 +2912,7 @@ static int 
>>>>>>> read_converting_block_groups(struct
>>>>>>> btrfs_fs_info *fs_info)
>>>>>>>             return ret;
>>>>>>>         }
>>>>>>> -    ret = read_old_block_groups_from_root(fs_info, old_root);
>>>>>>> +    ret = read_block_groups_from_root(fs_info, old_root);
>>>>>>>         if (ret < 0) {
>>>>>>>             error("failed to load block groups from the old 
>>>>>>> root: %d",
>>>>>>> ret);
>>>>>>>             return ret;
>>>>
>>
