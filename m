Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 652787B2F31
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Sep 2023 11:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232915AbjI2Jdb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Sep 2023 05:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232887AbjI2Jda (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Sep 2023 05:33:30 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690E6193
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Sep 2023 02:33:27 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9b275afb6abso100301666b.1
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Sep 2023 02:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695980006; x=1696584806; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0Kc/LN95kqE5xKM07tW/UhRHnLlPLilbH4Ha+h3QBkg=;
        b=Jo1Gx/8DsyPJEyGZp8ozclHYLEvlCIdEUsbx2oUI3b2GbgrLDkoNlLFf0Ci/DuS7so
         EedThCqdCa4/yFevCvWyDS3q7VGsHdASPKf8nWT9qbOeu48tvvVWNn0FzkKvX8fmtAI3
         XSsW7dI7S1wg3ZDfPnvsBDgFiq1RrTYqgxAS/tKFQ7lqYojb0v1l04GkEjQdj6qY9T6G
         lHpWuqpDBpb/SJrMg8/TyhjlynmhG9o0iW/iMaWFIWAPDBcwTQp+i8NRJ7kxbRUXSQUF
         FkadZcN+RdjtCjVnhvJHdoZxSE4h+viwywzsMJm61uWygnu6mrurvwlqmqYM1Sdw1ZOg
         Rtdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695980006; x=1696584806;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Kc/LN95kqE5xKM07tW/UhRHnLlPLilbH4Ha+h3QBkg=;
        b=q6UdmOVIBOeO1mhWBV99y2J0ypOABj6nPma8Y8asIjCFJYsI76AcgCLmgQdhoCSyPi
         JMndYuecl0x27hxxMq8ZqcHJitggOecYiqPoCVtwzZquiMzdcoNSKuusZPATW5+oqDHp
         AQOC/c2dIVncTSkLSGaAJjC3eNiyR/lIrS3N3vCJ1/QLGW25QOUKFb+EloDI6wCez8OG
         veIvJ+60sX3iRGsh8+xqzM1kMae083Gnlza1cLim1c0rfN9wVjYOsAVZ95lKv/4lpgAn
         pCU1WWm4oski68X+WFVCyYDFxxuMqmVqSws49EpkY1u+TyZMLBMgY1ygnWkjLqNejbb3
         y19w==
X-Gm-Message-State: AOJu0YwH7mb1y0f8czFgxUP+XW31G/LlOBG9AzDtYCAHwg1qqSD26h/n
        JjuPQ322WJEY4/yr40rZv08=
X-Google-Smtp-Source: AGHT+IH801HgouJmt4bwfM8/MKNVybytcynli6rhnxrUmSWe84BVQCMgfGq38pYncbE/j8k85mNlvQ==
X-Received: by 2002:a17:907:2717:b0:9a2:143e:a070 with SMTP id w23-20020a170907271700b009a2143ea070mr3446055ejk.20.1695980005502;
        Fri, 29 Sep 2023 02:33:25 -0700 (PDT)
Received: from [192.168.3.88] (ppp-94-68-116-207.home.otenet.gr. [94.68.116.207])
        by smtp.googlemail.com with ESMTPSA id ey6-20020a1709070b8600b009b2b7333c8bsm3417841ejc.81.2023.09.29.02.33.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Sep 2023 02:33:24 -0700 (PDT)
Message-ID: <c9fa7f88-5f3b-04f8-b18d-7d8490299538@gmail.com>
Date:   Fri, 29 Sep 2023 12:33:19 +0300
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
From:   Konstantinos Skarlatos <k.skarlatos@gmail.com>
In-Reply-To: <e834fd8a-3c10-4b5c-9121-9812f460f73c@gmx.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 29/09/2023 12:56 π.μ., Qu Wenruo wrote:
>
>
> On 2023/9/29 00:23, Konstantinos Skarlatos wrote:
>> Hi Qu, thanks for your patch. I just tried it on a clean btrfs-progs
>> tree with my filesystem:
>>
>> ❯ ./btrfstune --convert-to-block-group-tree /dev/sda
>> [1]    796483 segmentation fault (core dumped)  ./btrfstune
>> --convert-to-block-group-tree /dev/sda
>
> Mind to enable debug build by "make D=1" for btrfs-progs, and go with
> gdb to show the crash callback?
>
> I assume it could be the same crash from your initial report.
>
> Thanks,
> Qu
>

Hi Qu, i hope i am doing this correctly...


❯ gdb -ex=r --args ./btrfstune --convert-to-block-group-tree /dev/sda
GNU gdb (GDB) 13.2
Copyright (C) 2023 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later
<http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
Type "show copying" and "show warranty" for details.
This GDB was configured as "x86_64-pc-linux-gnu".
Type "show configuration" for configuration details.
For bug reporting instructions, please see:
<https://www.gnu.org/software/gdb/bugs/>.
Find the GDB manual and other documentation resources online at:
    <http://www.gnu.org/software/gdb/documentation/>.

For help, type "help".
Type "apropos word" to search for commands related to "word"...
Reading symbols from ./btrfstune...
Starting program: /root/btrfs-progs/btrfstune
--convert-to-block-group-tree /dev/sda

This GDB supports auto-downloading debuginfo from the following URLs:
  <https://debuginfod.archlinux.org>
Enable debuginfod for this session? (y or [n]) y
Debuginfod has been enabled.
To make this setting permanent, add 'set debuginfod enabled on' to .gdbinit.
Downloading separate debug info for /lib64/ld-linux-x86-64.so.2
Downloading separate debug info for system-supplied DSO at 0x7ffff7fc8000
Downloading separate debug info for /usr/lib/libuuid.so.1
Downloading separate debug info for /usr/lib/libblkid.so.1
Downloading separate debug info for /usr/lib/libudev.so.1
Downloading separate debug info for /usr/lib/libc.so.6
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/usr/lib/libthread_db.so.1".
Downloading separate debug info for /usr/lib/libcap.so.2

Program received signal SIGSEGV, Segmentation fault.
0x00005555555c6600 in cache_tree_comp_range (node=0xffffffffff000f0f,
data=0x7fffffffd780) at common/extent-cache.c:40
40              if (entry->start + entry->size <= range->start)
(gdb)




>>
>> Sep 28 17:46:17 elsinki kernel: btrfstune[796483]: segfault at
>> ffffffffff000f2f ip 0000564b6c2107aa sp 00007ffdc8ad25c8 error 5 in
>> btrfstune[564b6c1d1000+5b000] likely on CPU 3 (core 2, socket 0)
>> Sep 28 17:46:17 elsinki kernel: Code: ff 48 8b 34 24 48 8d 3d 5a d8 01
>> 00 b8 00 00 00 00 e8 5a 37 00 00 48 8b 33 bf 0a 00 00 00 e8 1d 0c fc ff
>> eb a8 e8 86 0a fc ff <48> 8b 4f 20 48 8b 56 08 48 89 c8 48 03 47 28 48
>> 89 c7 b8 01 00 00
>> Sep 28 17:46:17 elsinki systemd[1]: Created slice Slice
>> /system/systemd-coredump.
>> Sep 28 17:46:17 elsinki systemd[1]: Started Process Core Dump (PID
>> 796493/UID 0).
>> Sep 28 17:46:21 elsinki systemd-coredump[796494]: [🡕] Process 796483
>> (btrfstune) of user 0 dumped core.
>>
>>                                                    Stack trace of thread
>> 796483:
>>                                                    #0 0x0000564b6c2107aa
>> n/a (/root/btrfs-progs/btrfstune + 0x4d7aa)
>>                                                    ELF object binary
>> architecture: AMD x86-64
>> Sep 28 17:46:21 elsinki systemd[1]: systemd-coredump@0-796493-0.service:
>> Deactivated successfully.
>> Sep 28 17:46:21 elsinki systemd[1]: systemd-coredump@0-796493-0.service:
>> Consumed 4.248s CPU time.
>>
>>
>> On 28/9/2023 1:50 π.μ., Qu Wenruo wrote:
>>> [BUG]
>>> There is a bug report that when converting to bg tree crashed, the
>>> resulted fs is unable to be resumed.
>>>
>>> This problems comes with the following error messages:
>>>
>>>    ./btrfstune --convert-to-block-group-tree /dev/sda
>>>    ERROR: Corrupted fs, no valid METADATA block group found
>>>    ERROR: failed to delete block group item from the old root: -117
>>>    ERROR: failed to convert the filesystem to block group tree feature
>>>    ERROR: btrfstune failed
>>>    extent buffer leak: start 17825576632320 len 16384
>>>
>>> [CAUSE]
>>> When resuming a interrupted conversion, we go through
>>> read_converting_block_groups() to handle block group items in both
>>> extent and block group trees.
>>>
>>> However for the block group items in the extent tree, there are several
>>> problems involved:
>>>
>>> - Uninitialized @key inside read_old_block_groups_from_root()
>>>    Here we only set @key.type, not setting @key.objectid for the
>>> initial
>>>    search.
>>>
>>>    Thus if we're unlukcy, we can got (u64)-1 as key.objectid, and exit
>>>    the search immediately.
>>>
>>> - Wrong search direction
>>>    The conversion is converting block groups in descending order,
>>> but the
>>>    block groups read is in ascending order.
>>>    Meaning if we start from the last converted block group, we would at
>>>    most read one block group.
>>>
>>> [FIX]
>>> To fix the problems, this patch would just remove
>>> read_old_block_groups_from_root() function completely.
>>>
>>> As for the conversion, we ensured the block group item is either in the
>>> old extent or the new block group tree.
>>> Thus there is no special handling needed reading block groups.
>>>
>>> We only need to read all block groups from both trees, using the same
>>> read_old_block_groups_from_root() function.
>>>
>>> Reported-by: Konstantinos Skarlatos <k.skarlatos@gmail.com>
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>> ---
>>> To Konstantinos:
>>>
>>> The bug I fixed here can explain all the failures you hit (the initial
>>> one and the one after the quick diff).
>>>
>>> Please verify if this helps and report back (without the quick diff in
>>> the original thread).
>>>
>>> We may have other corner cases to go, but I believe the patch itself is
>>> necessary no matter what, as the deleted code is really
>>> over-engineered and buggy.
>>> ---
>>>   kernel-shared/extent-tree.c | 79
>>> +------------------------------------
>>>   1 file changed, 1 insertion(+), 78 deletions(-)
>>>
>>> diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
>>> index 7022643a9843..4d6bf2b228e9 100644
>>> --- a/kernel-shared/extent-tree.c
>>> +++ b/kernel-shared/extent-tree.c
>>> @@ -2852,83 +2852,6 @@ out:
>>>       return ret;
>>>   }
>>> -/*
>>> - * Helper to read old block groups items from specified root.
>>> - *
>>> - * The difference between this and read_block_groups_from_root() is,
>>> - * we will exit if we have already read the last bg in the old root.
>>> - *
>>> - * This is to avoid wasting time finding bg items which should be
>>> in the
>>> - * new root.
>>> - */
>>> -static int read_old_block_groups_from_root(struct btrfs_fs_info
>>> *fs_info,
>>> -                       struct btrfs_root *root)
>>> -{
>>> -    struct btrfs_path path = {0};
>>> -    struct btrfs_key key;
>>> -    struct cache_extent *ce;
>>> -    /* The last block group bytenr in the old root. */
>>> -    u64 last_bg_in_old_root;
>>> -    int ret;
>>> -
>>> -    if (fs_info->last_converted_bg_bytenr != (u64)-1) {
>>> -        /*
>>> -         * We know the last converted bg in the other tree, load the
>>> chunk
>>> -         * before that last converted as our last bg in the tree.
>>> -         */
>>> -        ce = search_cache_extent(&fs_info->mapping_tree.cache_tree,
>>> -                     fs_info->last_converted_bg_bytenr);
>>> -        if (!ce || ce->start != fs_info->last_converted_bg_bytenr) {
>>> -            error("no chunk found for bytenr %llu",
>>> -                  fs_info->last_converted_bg_bytenr);
>>> -            return -ENOENT;
>>> -        }
>>> -        ce = prev_cache_extent(ce);
>>> -        /*
>>> -         * We should have previous unconverted chunk, or we have
>>> -         * already finished the convert.
>>> -         */
>>> -        ASSERT(ce);
>>> -
>>> -        last_bg_in_old_root = ce->start;
>>> -    } else {
>>> -        last_bg_in_old_root = (u64)-1;
>>> -    }
>>> -
>>> -    key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
>>> -
>>> -    while (true) {
>>> -        ret = find_first_block_group(root, &path, &key);
>>> -        if (ret > 0) {
>>> -            ret = 0;
>>> -            goto out;
>>> -        }
>>> -        if (ret != 0) {
>>> -            goto out;
>>> -        }
>>> -        btrfs_item_key_to_cpu(path.nodes[0], &key, path.slots[0]);
>>> -
>>> -        ret = read_one_block_group(fs_info, &path);
>>> -        if (ret < 0 && ret != -ENOENT)
>>> -            goto out;
>>> -
>>> -        /* We have reached last bg in the old root, no need to
>>> continue */
>>> -        if (key.objectid >= last_bg_in_old_root)
>>> -            break;
>>> -
>>> -        if (key.offset == 0)
>>> -            key.objectid++;
>>> -        else
>>> -            key.objectid = key.objectid + key.offset;
>>> -        key.offset = 0;
>>> -        btrfs_release_path(&path);
>>> -    }
>>> -    ret = 0;
>>> -out:
>>> -    btrfs_release_path(&path);
>>> -    return ret;
>>> -}
>>> -
>>>   /* Helper to read all block groups items from specified root. */
>>>   static int read_block_groups_from_root(struct btrfs_fs_info *fs_info,
>>>                          struct btrfs_root *root)
>>> @@ -2989,7 +2912,7 @@ static int read_converting_block_groups(struct
>>> btrfs_fs_info *fs_info)
>>>           return ret;
>>>       }
>>> -    ret = read_old_block_groups_from_root(fs_info, old_root);
>>> +    ret = read_block_groups_from_root(fs_info, old_root);
>>>       if (ret < 0) {
>>>           error("failed to load block groups from the old root: %d",
>>> ret);
>>>           return ret;

