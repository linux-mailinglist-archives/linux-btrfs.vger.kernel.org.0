Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3C97B5057
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Oct 2023 12:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236473AbjJBKck (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Oct 2023 06:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236367AbjJBKcj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Oct 2023 06:32:39 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4175990
        for <linux-btrfs@vger.kernel.org>; Mon,  2 Oct 2023 03:32:34 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-523100882f2so21302458a12.2
        for <linux-btrfs@vger.kernel.org>; Mon, 02 Oct 2023 03:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696242753; x=1696847553; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9tiT+whugxVhSi1opvZ0tu/uxvMMlBicqFEykK3nZss=;
        b=hM8bjxcE4wOZLSjz5BNA2Qbd8wfHmc9kYCEhGSIE5lBTzgfjVzaInRdc3uv10oVOmL
         nI8LndWOB0QMK8YWPZaZNtLE8LTkG/UTdORzPit+ir0XAJEi6HAfyOJ0m+CJqehDdzmc
         D5mnumTICHk08uMtKW890/4YaogPXws31elv/V3dun2LjrIBdGfdpTXbk+sEFlr5XlHB
         TcVs/DzOAFh3It3rMR0oDT0R9tIdvvJZvavFFMMD8kSS+Bximz78TOBjl13J0Q1pLJfy
         +n2ArILAcpkmSPVDMNrplh1BmKAFLhPDNCuOk/+LPQbpMTSnTm5ZM5LHvIpApwrZqneG
         AHdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696242753; x=1696847553;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9tiT+whugxVhSi1opvZ0tu/uxvMMlBicqFEykK3nZss=;
        b=n5IEVwSRY+xaez/6Hz3VOvq7K1xraDtO+0N28vIPth27MvPW8eKAH2kPT8KZpm+TXE
         imO0SJUSuOD1rQNiFn6GR4mD6tE73M64ECP/UzPevZ7T1jBap5ZzysWiwKg+ud+jITlU
         UFvZq87tJkC6hYEdzneXU5cgNq4KdtwCa4WdaCm/rNiRjPYW4Lyou6Nl3FfixsjB92wl
         27IpPOW361dt+mfQSQLAzqGl1QrBXMLel37uPqP5kRhi7P/b8qcnL7QHXEEw81VA4GS7
         QQ2OBfFwSudcWKdHk+KXdBQzCs0+0tWW+xvhmTKsbAFQx52lewVk8giL0NEPIBINwSHx
         XxeA==
X-Gm-Message-State: AOJu0YzAN6kwJgsYk/escgCgRhEVQcLvAqVdJBuCpfOhimhwEgrwKg9E
        4gjbqMqqxlpvTcBflrxsmfs=
X-Google-Smtp-Source: AGHT+IGh5bR5ZNqYtqBG1iJZZ1QdIWZVWcbqdhU2vPclqXswLYSKhXe/IXdQw5ysaxmmFLblKMPirA==
X-Received: by 2002:a05:6402:8d8:b0:523:100b:462b with SMTP id d24-20020a05640208d800b00523100b462bmr10665210edz.5.1696242752294;
        Mon, 02 Oct 2023 03:32:32 -0700 (PDT)
Received: from [192.168.3.88] (ppp-94-68-116-207.home.otenet.gr. [94.68.116.207])
        by smtp.googlemail.com with ESMTPSA id c8-20020aa7c748000000b005288f0e547esm15452266eds.55.2023.10.02.03.32.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 03:32:31 -0700 (PDT)
Message-ID: <a090f004-28c5-dcaa-793b-c03368ebbe2f@gmail.com>
Date:   Mon, 2 Oct 2023 13:32:29 +0300
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
From:   Konstantinos Skarlatos <k.skarlatos@gmail.com>
In-Reply-To: <77b9d0ba-f0b0-4258-8336-d3687d204967@gmx.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 02/10/2023 2:33 π.μ., Qu Wenruo wrote:
>
>
> On 2023/10/1 23:39, Konstantinos Skarlatos wrote:
>>
>> On 1/10/2023 12:22 π.μ., Qu Wenruo wrote:
>>>
>>>
>>> On 2023/9/30 22:31, Konstantinos Skarlatos wrote:
>>>>
>>>> On 30/9/2023 1:25 π.μ., Qu Wenruo wrote:
>>>>>
>>>>>
>>>>> On 2023/9/29 21:01, Konstantinos Skarlatos wrote:
>>>>>> On 29/09/2023 1:54 μ.μ., Qu Wenruo wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 2023/9/29 19:03, Konstantinos Skarlatos wrote:
>>>>>>>> On 29/09/2023 12:56 π.μ., Qu Wenruo wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 2023/9/29 00:23, Konstantinos Skarlatos wrote:
>>>>>>>>>> Hi Qu, thanks for your patch. I just tried it on a clean
>>>>>>>>>> btrfs-progs
>>>>>>>>>> tree with my filesystem:
>>>>>>>>>>
>>>>>>>>>> ❯ ./btrfstune --convert-to-block-group-tree /dev/sda
>>>>>>>>>> [1]    796483 segmentation fault (core dumped) ./btrfstune
>>>>>>>>>> --convert-to-block-group-tree /dev/sda
>>>>>>>>>
>>>>>>>>> Mind to enable debug build by "make D=1" for btrfs-progs, and go
>>>>>>>>> with
>>>>>>>>> gdb to show the crash callback?
>>>>>>>>>
>>>>>>>>> I assume it could be the same crash from your initial report.
>>>>>>>>>
>>>>>>>>> Thanks,
>>>>>>>>> Qu
>>>>>>>>>
>>>>>>>>
>>>>>>>> Hi Qu, i hope i am doing this correctly...
>>>>>>>>
>>>>>>>>
>>>>>>>> ❯ gdb -ex=r --args ./btrfstune --convert-to-block-group-tree
>>>>>>>> /dev/sda
>>>>>>>> GNU gdb (GDB) 13.2
>>>>>>>> Copyright (C) 2023 Free Software Foundation, Inc.
>>>>>>>> License GPLv3+: GNU GPL version 3 or later
>>>>>>>> <http://gnu.org/licenses/gpl.html>
>>>>>>>> This is free software: you are free to change and redistribute it.
>>>>>>>> There is NO WARRANTY, to the extent permitted by law.
>>>>>>>> Type "show copying" and "show warranty" for details.
>>>>>>>> This GDB was configured as "x86_64-pc-linux-gnu".
>>>>>>>> Type "show configuration" for configuration details.
>>>>>>>> For bug reporting instructions, please see:
>>>>>>>> <https://www.gnu.org/software/gdb/bugs/>.
>>>>>>>> Find the GDB manual and other documentation resources online at:
>>>>>>>> <http://www.gnu.org/software/gdb/documentation/>.
>>>>>>>>
>>>>>>>> For help, type "help".
>>>>>>>> Type "apropos word" to search for commands related to "word"...
>>>>>>>> Reading symbols from ./btrfstune...
>>>>>>>> Starting program: /root/btrfs-progs/btrfstune
>>>>>>>> --convert-to-block-group-tree /dev/sda
>>>>>>>>
>>>>>>>> This GDB supports auto-downloading debuginfo from the following
>>>>>>>> URLs:
>>>>>>>>     <https://debuginfod.archlinux.org>
>>>>>>>> Enable debuginfod for this session? (y or [n]) y
>>>>>>>> Debuginfod has been enabled.
>>>>>>>> To make this setting permanent, add 'set debuginfod enabled on' to
>>>>>>>> .gdbinit.
>>>>>>>> Downloading separate debug info for /lib64/ld-linux-x86-64.so.2
>>>>>>>> Downloading separate debug info for system-supplied DSO at
>>>>>>>> 0x7ffff7fc8000
>>>>>>>> Downloading separate debug info for /usr/lib/libuuid.so.1
>>>>>>>> Downloading separate debug info for /usr/lib/libblkid.so.1
>>>>>>>> Downloading separate debug info for /usr/lib/libudev.so.1
>>>>>>>> Downloading separate debug info for /usr/lib/libc.so.6
>>>>>>>> [Thread debugging using libthread_db enabled]
>>>>>>>> Using host libthread_db library "/usr/lib/libthread_db.so.1".
>>>>>>>> Downloading separate debug info for /usr/lib/libcap.so.2
>>>>>>>>
>>>>>>>> Program received signal SIGSEGV, Segmentation fault.
>>>>>>>> 0x00005555555c6600 in cache_tree_comp_range
>>>>>>>> (node=0xffffffffff000f0f,
>>>>>>>> data=0x7fffffffd780) at common/extent-cache.c:40
>>>>>>>> 40              if (entry->start + entry->size <= range->start)
>>>>>>>> (gdb)
>>>>>>>
>>>>>>> That's great, what about the output from "bt" command?
>>>>>>>
>>>>>>
>>>>>> Hi Qu, this is what i get:
>>>>>>
>>>>>> Program received signal SIGSEGV, Segmentation fault.
>>>>>> 0x00005555555c6600 in cache_tree_comp_range
>>>>>> (node=0xffffffffff000f0f,
>>>>>> data=0x7fffffffd780) at common/extent-cache.c:40
>>>>>> 40              if (entry->start + entry->size <= range->start)
>>>>>> (gdb) bt
>>>>>> #0  0x00005555555c6600 in cache_tree_comp_range
>>>>>> (node=0xffffffffff000f0f, data=0x7fffffffd780) at
>>>>>> common/extent-cache.c:40
>>>>>> #1  0x00005555555ce458 in rb_search (root=0x555555667358,
>>>>>> key=0x7fffffffd780, comp=0x5555555c65d8 <cache_tree_comp_range>,
>>>>>> next_ret=0x0) at common/rbtree-utils.c:59
>>>>>
>>>>> Indeed we're back to the initial crash you reported.
>>>>>
>>>>> The root cause is the @node pointer, which is not valid.
>>>>>
>>>>> I'm not sure why, but we got an invalid node inside the rb tree,
>>>>> which
>>>>> leads to the crash.
>>>>>
>>>>> Considering this is a rare one, I'll need more time to dig into the
>>>>> original crash.
>>>>> I'm afraid with this bug still here, we will not be able to do
>>>>> anything,
>>>>> neither reverting back or continuing the conversion.
>>>>>
>>>>> Thanks,
>>>>> Qu
>>>>
>>>> Hello Qu,
>>>>
>>>> does that mean that the filesystem is not recoverable?
>>>
>>> I'm not sure, unfortunately.
>>>
>>> One thing I'm afraid of is, there may be no space left and cause
>>> something wrong.
>>>
>>>>
>>>> I can keep it for a while if you need it for further debugging.
>>>
>>> Considering the turn-over time, please try this diff (upon this patch)
>>> as the last try.
>>>
>>> As I don't have any clue why the crash can happen, thus I go with my
>>> last guess on the possible ENOSPC.
>>>
>>> If this doesn't work, feel free to reformat the fs.
>>>
>>> Thanks,
>>> Qu
>>
>>
>> Hi Qu,
>>
>> i applied the patch over your previous patch and i got another seg
>> fault :(
>>
>> the latest df i have from my logs is:
>>
>> Filesystem     1M-blocks     Used Available Use% Mounted on
>>
>> /dev/sda        11446344 10109559    748884  94% /storage/btrfs
>
> Unfortunately vanilla df is not good enough for this case.
>
> As the main concern here is about the metadata usage, which doesn't
> really show up.

Is there a way to check for metadata usage with this filesystem?
Maybe there should be a warning that this can happen, or some kind of
check by btrfstune so somebody else can avoid this problem?

>>
>>
>> Starting program: /root/btrfs-progs/btrfstune
>> --convert-to-block-group-tree /dev/sda
>>
>> This GDB supports auto-downloading debuginfo from the following URLs:
>>    <https://debuginfod.archlinux.org>
>> Enable debuginfod for this session? (y or [n]) y
>> Debuginfod has been enabled.
>> To make this setting permanent, add 'set debuginfod enabled on' to
>> .gdbinit.
>> Downloading separate debug info for /lib64/ld-linux-x86-64.so.2
>> Downloading separate debug info for system-supplied DSO at
>> 0x7ffff7fc8000
>> Downloading separate debug info for /usr/lib/libc.so.6
>> [Thread debugging using libthread_db enabled]
>> Using host libthread_db library "/usr/lib/libthread_db.so.1".
>>
>> Program received signal SIGSEGV, Segmentation fault.
>> 0x00007ffff7c9cd77 in malloc () from /usr/lib/libc.so.6
>> (gdb) bt
>> #0  0x00007ffff7c9cd77 in malloc () from /usr/lib/libc.so.6
>> #1  0x000055555558ccd8 in btrfs_alloc_delayed_extent_op () at
>> ./kernel-shared/delayed-ref.h:165
>
> This doesn't sound sane, it's malloc() allocation causing problem.
>
> It may be memory being exhausted or something else.
>
> Either way I have no idea why a malloc() can fail by itself.
> It may really be too large metadata causing the problem.
>
>> #2  0x0000555555592cd1 in alloc_tree_block (trans=0x555567d491d0,
>> root=0x5555558da6d0, num_bytes=16384, root_objectid=10,
>> generation=1833253, flags=0,
>>      key=0x7fffffffd9e0, level=0, empty_size=0,
>> hint_byte=17820097789952, search_end=18446744073709551615,
>> ins=0x7fffffffd930) at kernel-shared/extent-tree.c:2500
>> #3  0x0000555555592f82 in btrfs_alloc_tree_block (trans=0x555567d491d0,
>> root=0x5555558da6d0, blocksize=16384, root_objectid=10,
>> key=0x7fffffffd9e0, level=0,
>>      hint=17820097789952, empty_size=0, nest=BTRFS_NESTING_NORMAL) at
>> kernel-shared/extent-tree.c:2564
>> #4  0x000055555557ba8e in split_leaf (trans=0x555567d491d0,
>> root=0x5555558da6d0, ins_key=0x7fffffffdc40, path=0x55556a180e90,
>> data_size=25, extend=0)
>>      at kernel-shared/ctree.c:2405
>> #5  0x0000555555578fc0 in btrfs_search_slot (trans=0x555567d491d0,
>> root=0x5555558da6d0, key=0x7fffffffdc40, p=0x55556a180e90, ins_len=25,
>> cow=1)
>>      at kernel-shared/ctree.c:1399
>> #6  0x000055555557ca7d in btrfs_insert_empty_items
>> (trans=0x555567d491d0, root=0x5555558da6d0, path=0x55556a180e90,
>> cpu_key=0x7fffffffdc40,
>>      data_size=0x7fffffffdb5c, nr=1) at kernel-shared/ctree.c:2758
>> #7  0x000055555559eb70 in btrfs_insert_empty_item (trans=0x555567d491d0,
>> root=0x5555558da6d0, path=0x55556a180e90, key=0x7fffffffdc40,
>> data_size=0)
>>      at ./kernel-shared/ctree.h:1019
>> #8  0x000055555559ff9a in convert_free_space_to_extents
>> (trans=0x555567d491d0, block_group=0x55555fcc7710, path=0x55556a180e90)
>>      at kernel-shared/free-space-tree.c:465
>
> And every crash you reported is related to free space tree code, I'm not
> sure if that's the root cause.
>
> But for now, if you really need I can provide a patch to forcefully
> remove the converting flag, and then you should be able to mount the fs
> read-only using "-o rescue=all" mount option. (mostly to salvage data).
>
> Otherwise I hardly see a proper way to pin down why we always crash at
> free space tree code.

As i have backups for my data, i will not need the patch, i just want to
help fix this bug.

But from what you are saying i understand that there is no reason for me
to keep this filesystem anymore, correct?

In any case, thank you for helping me out!

Kind regards,
Konstantinos Skarlatos
>
> Thanks,
> Qu
>> #9  0x00005555555a01ed in update_free_space_extent_count
>> (trans=0x555567d491d0, block_group=0x55555fcc7710, path=0x55556a180e90,
>> new_extents=1)
>>      at kernel-shared/free-space-tree.c:525
>> #10 0x00005555555a07ae in modify_free_space_bitmap
>> (trans=0x555567d491d0, block_group=0x55555fcc7710, path=0x55556a180e90,
>> start=17592699748352, size=16384,
>>      remove=0) at kernel-shared/free-space-tree.c:707
>> #11 0x00005555555a0ff2 in __add_to_free_space_tree
>> (trans=0x555567d491d0, block_group=0x55555fcc7710, path=0x55556a180e90,
>> start=17592699748352, size=16384)
>>      at kernel-shared/free-space-tree.c:997
>> #12 0x00005555555a10ad in add_to_free_space_tree (trans=0x555567d491d0,
>> start=17592699748352, size=16384) at
>> kernel-shared/free-space-tree.c:1028
>> #13 0x0000555555591db8 in __free_extent (trans=0x555567d491d0,
>> bytenr=17592699748352, num_bytes=16384, parent=0, root_objectid=2,
>> owner_objectid=0,
>>      owner_offset=0, refs_to_drop=1) at kernel-shared/extent-tree.c:2130
>> #14 0x000055555559651c in run_delayed_tree_ref (trans=0x555567d491d0,
>> fs_info=0x5555556672f0, node=0x5555695d3570, extent_op=0x0,
>> insert_reserved=0)
>>      at kernel-shared/extent-tree.c:3906
>> #15 0x00005555555965b1 in run_one_delayed_ref (trans=0x555567d491d0,
>> fs_info=0x5555556672f0, node=0x5555695d3570, extent_op=0x0,
>> insert_reserved=0)
>>      at kernel-shared/extent-tree.c:3926
>> #16 0x00005555555967de in btrfs_run_delayed_refs (trans=0x555567d491d0,
>> nr=18446744073709551615) at kernel-shared/extent-tree.c:4010
>> #17 0x00005555555afbd1 in btrfs_commit_transaction
>> (trans=0x555567d491d0, root=0x55555567bc90) at
>> kernel-shared/transaction.c:210
>> #18 0x0000555555566b19 in convert_to_bg_tree (fs_info=0x5555556672f0) at
>> tune/convert-bgt.c:112
>> #19 0x00005555555647bb in main (argc=3, argv=0x7fffffffe288) at
>> tune/main.c:393
>>
>> Kind regards,
>>
>>
>>>
>>>> Kind regards,
>>>>
>>>>
>>>>>> #2  0x00005555555c6964 in lookup_cache_extent (tree=0x555555667358,
>>>>>> start=17820099854336, size=16384) at common/extent-cache.c:145
>>>>>> #3  0x0000555555597cac in alloc_extent_buffer
>>>>>> (fs_info=0x5555556672f0,
>>>>>> bytenr=17820099854336, blocksize=16384) at
>>>>>> kernel-shared/extent_io.c:262
>>>>>> #4  0x000055555558253b in btrfs_find_create_tree_block
>>>>>> (fs_info=0x5555556672f0, bytenr=17820099854336) at
>>>>>> kernel-shared/disk-io.c:232
>>>>>> #5  0x0000555555582cdb in read_tree_block (fs_info=0x5555556672f0,
>>>>>> bytenr=17820099854336, owner_root=10, parent_transid=1833250,
>>>>>> level=0,
>>>>>> first_key=0x0)
>>>>>>      at kernel-shared/disk-io.c:439
>>>>>> #6  0x00005555555776bd in read_node_slot (fs_info=0x5555556672f0,
>>>>>> parent=0x55557571ba60, slot=154) at kernel-shared/ctree.c:850
>>>>>> #7  0x000055555557a644 in push_leaf_right (trans=0x555567b3d140,
>>>>>> root=0x5555558da740, path=0x5555757f0d30, data_size=25, empty=0) at
>>>>>> kernel-shared/ctree.c:1965
>>>>>> #8  0x000055555557b7d1 in split_leaf (trans=0x555567b3d140,
>>>>>> root=0x5555558da740, ins_key=0x7fffffffdc50, path=0x5555757f0d30,
>>>>>> data_size=25, extend=0)
>>>>>>      at kernel-shared/ctree.c:2338
>>>>>> #9  0x0000555555578fc0 in btrfs_search_slot (trans=0x555567b3d140,
>>>>>> root=0x5555558da740, key=0x7fffffffdc50, p=0x5555757f0d30,
>>>>>> ins_len=25,
>>>>>> cow=1) at kernel-shared/ctree.c:1399
>>>>>> #10 0x000055555557ca7d in btrfs_insert_empty_items
>>>>>> (trans=0x555567b3d140, root=0x5555558da740, path=0x5555757f0d30,
>>>>>> cpu_key=0x7fffffffdc50, data_size=0x7fffffffdb6c, nr=1)
>>>>>>      at kernel-shared/ctree.c:2758
>>>>>> #11 0x000055555559eb70 in btrfs_insert_empty_item
>>>>>> (trans=0x555567b3d140,
>>>>>> root=0x5555558da740, path=0x5555757f0d30, key=0x7fffffffdc50,
>>>>>> data_size=0)
>>>>>>      at ./kernel-shared/ctree.h:1019
>>>>>> #12 0x000055555559ff9a in convert_free_space_to_extents
>>>>>> (trans=0x555567b3d140, block_group=0x55555fcc7780,
>>>>>> path=0x5555757f0d30)
>>>>>> at kernel-shared/free-space-tree.c:465
>>>>>> #13 0x00005555555a01ed in update_free_space_extent_count
>>>>>> (trans=0x555567b3d140, block_group=0x55555fcc7780,
>>>>>> path=0x5555757f0d30,
>>>>>> new_extents=1)
>>>>>>      at kernel-shared/free-space-tree.c:525
>>>>>> #14 0x00005555555a07ae in modify_free_space_bitmap
>>>>>> (trans=0x555567b3d140, block_group=0x55555fcc7780,
>>>>>> path=0x5555757f0d30,
>>>>>> start=17592699748352, size=16384, remove=0)
>>>>>>      at kernel-shared/free-space-tree.c:707
>>>>>> #15 0x00005555555a0ff2 in __add_to_free_space_tree
>>>>>> (trans=0x555567b3d140, block_group=0x55555fcc7780,
>>>>>> path=0x5555757f0d30,
>>>>>> start=17592699748352, size=16384)
>>>>>>      at kernel-shared/free-space-tree.c:997
>>>>>> #16 0x00005555555a10ad in add_to_free_space_tree
>>>>>> (trans=0x555567b3d140,
>>>>>> start=17592699748352, size=16384) at
>>>>>> kernel-shared/free-space-tree.c:1028
>>>>>> #17 0x0000555555591db8 in __free_extent (trans=0x555567b3d140,
>>>>>> bytenr=17592699748352, num_bytes=16384, parent=0, root_objectid=2,
>>>>>> owner_objectid=0, owner_offset=0,
>>>>>>      refs_to_drop=1) at kernel-shared/extent-tree.c:2130
>>>>>> #18 0x000055555559651c in run_delayed_tree_ref
>>>>>> (trans=0x555567b3d140,
>>>>>> fs_info=0x5555556672f0, node=0x55556bf11090, extent_op=0x0,
>>>>>> insert_reserved=0)
>>>>>>      at kernel-shared/extent-tree.c:3906
>>>>>> #19 0x00005555555965b1 in run_one_delayed_ref (trans=0x555567b3d140,
>>>>>> fs_info=0x5555556672f0, node=0x55556bf11090, extent_op=0x0,
>>>>>> insert_reserved=0)
>>>>>>      at kernel-shared/extent-tree.c:3926
>>>>>> #20 0x00005555555967de in btrfs_run_delayed_refs
>>>>>> (trans=0x555567b3d140,
>>>>>> nr=18446744073709551615) at kernel-shared/extent-tree.c:4010
>>>>>> #21 0x00005555555afbd1 in btrfs_commit_transaction
>>>>>> (trans=0x555567b3d140, root=0x55555567bd70) at
>>>>>> kernel-shared/transaction.c:210
>>>>>> #22 0x0000555555566b19 in convert_to_bg_tree
>>>>>> (fs_info=0x5555556672f0) at
>>>>>> tune/convert-bgt.c:112
>>>>>> #23 0x00005555555647bb in main (argc=3, argv=0x7fffffffe298) at
>>>>>> tune/main.c:393
>>>>>> (gdb)
>>>>>>
>>>>>>
>>>>>>
>>>>>>> Thanks,
>>>>>>> Qu
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Sep 28 17:46:17 elsinki kernel: btrfstune[796483]: segfault at
>>>>>>>>>> ffffffffff000f2f ip 0000564b6c2107aa sp 00007ffdc8ad25c8 error
>>>>>>>>>> 5 in
>>>>>>>>>> btrfstune[564b6c1d1000+5b000] likely on CPU 3 (core 2, socket 0)
>>>>>>>>>> Sep 28 17:46:17 elsinki kernel: Code: ff 48 8b 34 24 48 8d 3d 5a
>>>>>>>>>> d8 01
>>>>>>>>>> 00 b8 00 00 00 00 e8 5a 37 00 00 48 8b 33 bf 0a 00 00 00 e8
>>>>>>>>>> 1d 0c
>>>>>>>>>> fc ff
>>>>>>>>>> eb a8 e8 86 0a fc ff <48> 8b 4f 20 48 8b 56 08 48 89 c8 48 03 47
>>>>>>>>>> 28 48
>>>>>>>>>> 89 c7 b8 01 00 00
>>>>>>>>>> Sep 28 17:46:17 elsinki systemd[1]: Created slice Slice
>>>>>>>>>> /system/systemd-coredump.
>>>>>>>>>> Sep 28 17:46:17 elsinki systemd[1]: Started Process Core Dump
>>>>>>>>>> (PID
>>>>>>>>>> 796493/UID 0).
>>>>>>>>>> Sep 28 17:46:21 elsinki systemd-coredump[796494]: [🡕] Process
>>>>>>>>>> 796483
>>>>>>>>>> (btrfstune) of user 0 dumped core.
>>>>>>>>>>
>>>>>>>>>> Stack trace of
>>>>>>>>>> thread
>>>>>>>>>> 796483:
>>>>>>>>>> #0
>>>>>>>>>> 0x0000564b6c2107aa
>>>>>>>>>> n/a (/root/btrfs-progs/btrfstune + 0x4d7aa)
>>>>>>>>>> ELF object
>>>>>>>>>> binary
>>>>>>>>>> architecture: AMD x86-64
>>>>>>>>>> Sep 28 17:46:21 elsinki systemd[1]:
>>>>>>>>>> systemd-coredump@0-796493-0.service:
>>>>>>>>>> Deactivated successfully.
>>>>>>>>>> Sep 28 17:46:21 elsinki systemd[1]:
>>>>>>>>>> systemd-coredump@0-796493-0.service:
>>>>>>>>>> Consumed 4.248s CPU time.
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> On 28/9/2023 1:50 π.μ., Qu Wenruo wrote:
>>>>>>>>>>> [BUG]
>>>>>>>>>>> There is a bug report that when converting to bg tree crashed,
>>>>>>>>>>> the
>>>>>>>>>>> resulted fs is unable to be resumed.
>>>>>>>>>>>
>>>>>>>>>>> This problems comes with the following error messages:
>>>>>>>>>>>
>>>>>>>>>>>      ./btrfstune --convert-to-block-group-tree /dev/sda
>>>>>>>>>>>      ERROR: Corrupted fs, no valid METADATA block group found
>>>>>>>>>>>      ERROR: failed to delete block group item from the old
>>>>>>>>>>> root:
>>>>>>>>>>> -117
>>>>>>>>>>>      ERROR: failed to convert the filesystem to block group
>>>>>>>>>>> tree
>>>>>>>>>>> feature
>>>>>>>>>>>      ERROR: btrfstune failed
>>>>>>>>>>>      extent buffer leak: start 17825576632320 len 16384
>>>>>>>>>>>
>>>>>>>>>>> [CAUSE]
>>>>>>>>>>> When resuming a interrupted conversion, we go through
>>>>>>>>>>> read_converting_block_groups() to handle block group items in
>>>>>>>>>>> both
>>>>>>>>>>> extent and block group trees.
>>>>>>>>>>>
>>>>>>>>>>> However for the block group items in the extent tree, there are
>>>>>>>>>>> several
>>>>>>>>>>> problems involved:
>>>>>>>>>>>
>>>>>>>>>>> - Uninitialized @key inside read_old_block_groups_from_root()
>>>>>>>>>>>      Here we only set @key.type, not setting @key.objectid for
>>>>>>>>>>> the
>>>>>>>>>>> initial
>>>>>>>>>>>      search.
>>>>>>>>>>>
>>>>>>>>>>>      Thus if we're unlukcy, we can got (u64)-1 as
>>>>>>>>>>> key.objectid, and
>>>>>>>>>>> exit
>>>>>>>>>>>      the search immediately.
>>>>>>>>>>>
>>>>>>>>>>> - Wrong search direction
>>>>>>>>>>>      The conversion is converting block groups in descending
>>>>>>>>>>> order,
>>>>>>>>>>> but the
>>>>>>>>>>>      block groups read is in ascending order.
>>>>>>>>>>>      Meaning if we start from the last converted block
>>>>>>>>>>> group, we
>>>>>>>>>>> would at
>>>>>>>>>>>      most read one block group.
>>>>>>>>>>>
>>>>>>>>>>> [FIX]
>>>>>>>>>>> To fix the problems, this patch would just remove
>>>>>>>>>>> read_old_block_groups_from_root() function completely.
>>>>>>>>>>>
>>>>>>>>>>> As for the conversion, we ensured the block group item is
>>>>>>>>>>> either
>>>>>>>>>>> in the
>>>>>>>>>>> old extent or the new block group tree.
>>>>>>>>>>> Thus there is no special handling needed reading block groups.
>>>>>>>>>>>
>>>>>>>>>>> We only need to read all block groups from both trees, using
>>>>>>>>>>> the
>>>>>>>>>>> same
>>>>>>>>>>> read_old_block_groups_from_root() function.
>>>>>>>>>>>
>>>>>>>>>>> Reported-by: Konstantinos Skarlatos <k.skarlatos@gmail.com>
>>>>>>>>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>>>>>>>>> ---
>>>>>>>>>>> To Konstantinos:
>>>>>>>>>>>
>>>>>>>>>>> The bug I fixed here can explain all the failures you hit (the
>>>>>>>>>>> initial
>>>>>>>>>>> one and the one after the quick diff).
>>>>>>>>>>>
>>>>>>>>>>> Please verify if this helps and report back (without the quick
>>>>>>>>>>> diff in
>>>>>>>>>>> the original thread).
>>>>>>>>>>>
>>>>>>>>>>> We may have other corner cases to go, but I believe the patch
>>>>>>>>>>> itself is
>>>>>>>>>>> necessary no matter what, as the deleted code is really
>>>>>>>>>>> over-engineered and buggy.
>>>>>>>>>>> ---
>>>>>>>>>>>     kernel-shared/extent-tree.c | 79
>>>>>>>>>>> +------------------------------------
>>>>>>>>>>>     1 file changed, 1 insertion(+), 78 deletions(-)
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/kernel-shared/extent-tree.c
>>>>>>>>>>> b/kernel-shared/extent-tree.c
>>>>>>>>>>> index 7022643a9843..4d6bf2b228e9 100644
>>>>>>>>>>> --- a/kernel-shared/extent-tree.c
>>>>>>>>>>> +++ b/kernel-shared/extent-tree.c
>>>>>>>>>>> @@ -2852,83 +2852,6 @@ out:
>>>>>>>>>>>         return ret;
>>>>>>>>>>>     }
>>>>>>>>>>> -/*
>>>>>>>>>>> - * Helper to read old block groups items from specified root.
>>>>>>>>>>> - *
>>>>>>>>>>> - * The difference between this and
>>>>>>>>>>> read_block_groups_from_root() is,
>>>>>>>>>>> - * we will exit if we have already read the last bg in the old
>>>>>>>>>>> root.
>>>>>>>>>>> - *
>>>>>>>>>>> - * This is to avoid wasting time finding bg items which
>>>>>>>>>>> should be
>>>>>>>>>>> in the
>>>>>>>>>>> - * new root.
>>>>>>>>>>> - */
>>>>>>>>>>> -static int read_old_block_groups_from_root(struct
>>>>>>>>>>> btrfs_fs_info
>>>>>>>>>>> *fs_info,
>>>>>>>>>>> -                       struct btrfs_root *root)
>>>>>>>>>>> -{
>>>>>>>>>>> -    struct btrfs_path path = {0};
>>>>>>>>>>> -    struct btrfs_key key;
>>>>>>>>>>> -    struct cache_extent *ce;
>>>>>>>>>>> -    /* The last block group bytenr in the old root. */
>>>>>>>>>>> -    u64 last_bg_in_old_root;
>>>>>>>>>>> -    int ret;
>>>>>>>>>>> -
>>>>>>>>>>> -    if (fs_info->last_converted_bg_bytenr != (u64)-1) {
>>>>>>>>>>> -        /*
>>>>>>>>>>> -         * We know the last converted bg in the other tree,
>>>>>>>>>>> load the
>>>>>>>>>>> chunk
>>>>>>>>>>> -         * before that last converted as our last bg in the
>>>>>>>>>>> tree.
>>>>>>>>>>> -         */
>>>>>>>>>>> -        ce =
>>>>>>>>>>> search_cache_extent(&fs_info->mapping_tree.cache_tree,
>>>>>>>>>>> - fs_info->last_converted_bg_bytenr);
>>>>>>>>>>> -        if (!ce || ce->start !=
>>>>>>>>>>> fs_info->last_converted_bg_bytenr) {
>>>>>>>>>>> -            error("no chunk found for bytenr %llu",
>>>>>>>>>>> - fs_info->last_converted_bg_bytenr);
>>>>>>>>>>> -            return -ENOENT;
>>>>>>>>>>> -        }
>>>>>>>>>>> -        ce = prev_cache_extent(ce);
>>>>>>>>>>> -        /*
>>>>>>>>>>> -         * We should have previous unconverted chunk, or we
>>>>>>>>>>> have
>>>>>>>>>>> -         * already finished the convert.
>>>>>>>>>>> -         */
>>>>>>>>>>> -        ASSERT(ce);
>>>>>>>>>>> -
>>>>>>>>>>> -        last_bg_in_old_root = ce->start;
>>>>>>>>>>> -    } else {
>>>>>>>>>>> -        last_bg_in_old_root = (u64)-1;
>>>>>>>>>>> -    }
>>>>>>>>>>> -
>>>>>>>>>>> -    key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
>>>>>>>>>>> -
>>>>>>>>>>> -    while (true) {
>>>>>>>>>>> -        ret = find_first_block_group(root, &path, &key);
>>>>>>>>>>> -        if (ret > 0) {
>>>>>>>>>>> -            ret = 0;
>>>>>>>>>>> -            goto out;
>>>>>>>>>>> -        }
>>>>>>>>>>> -        if (ret != 0) {
>>>>>>>>>>> -            goto out;
>>>>>>>>>>> -        }
>>>>>>>>>>> -        btrfs_item_key_to_cpu(path.nodes[0], &key,
>>>>>>>>>>> path.slots[0]);
>>>>>>>>>>> -
>>>>>>>>>>> -        ret = read_one_block_group(fs_info, &path);
>>>>>>>>>>> -        if (ret < 0 && ret != -ENOENT)
>>>>>>>>>>> -            goto out;
>>>>>>>>>>> -
>>>>>>>>>>> -        /* We have reached last bg in the old root, no need to
>>>>>>>>>>> continue */
>>>>>>>>>>> -        if (key.objectid >= last_bg_in_old_root)
>>>>>>>>>>> -            break;
>>>>>>>>>>> -
>>>>>>>>>>> -        if (key.offset == 0)
>>>>>>>>>>> -            key.objectid++;
>>>>>>>>>>> -        else
>>>>>>>>>>> -            key.objectid = key.objectid + key.offset;
>>>>>>>>>>> -        key.offset = 0;
>>>>>>>>>>> -        btrfs_release_path(&path);
>>>>>>>>>>> -    }
>>>>>>>>>>> -    ret = 0;
>>>>>>>>>>> -out:
>>>>>>>>>>> -    btrfs_release_path(&path);
>>>>>>>>>>> -    return ret;
>>>>>>>>>>> -}
>>>>>>>>>>> -
>>>>>>>>>>>     /* Helper to read all block groups items from specified
>>>>>>>>>>> root. */
>>>>>>>>>>>     static int read_block_groups_from_root(struct btrfs_fs_info
>>>>>>>>>>> *fs_info,
>>>>>>>>>>>                            struct btrfs_root *root)
>>>>>>>>>>> @@ -2989,7 +2912,7 @@ static int
>>>>>>>>>>> read_converting_block_groups(struct
>>>>>>>>>>> btrfs_fs_info *fs_info)
>>>>>>>>>>>             return ret;
>>>>>>>>>>>         }
>>>>>>>>>>> -    ret = read_old_block_groups_from_root(fs_info, old_root);
>>>>>>>>>>> +    ret = read_block_groups_from_root(fs_info, old_root);
>>>>>>>>>>>         if (ret < 0) {
>>>>>>>>>>>             error("failed to load block groups from the old
>>>>>>>>>>> root: %d",
>>>>>>>>>>> ret);
>>>>>>>>>>>             return ret;
>>>>>>>>
>>>>>>

