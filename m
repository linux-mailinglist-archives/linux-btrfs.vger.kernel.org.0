Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43D187B0E67
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Sep 2023 23:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbjI0V5Z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Sep 2023 17:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjI0V5Y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Sep 2023 17:57:24 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0C0FB
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Sep 2023 14:57:22 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-4054f790190so110544145e9.2
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Sep 2023 14:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695851841; x=1696456641; darn=vger.kernel.org;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C8UcNE7WpJNzoucJVd9mzuEISgOkE40JhABaY8jhGMo=;
        b=bUp6VQ6SIWzoEMBLmbJwmqYPCwpVEJqAjVQCMs7krZxF6KLq9DYL4rVuhmMMSzsusS
         g5HF7+brq6I+Qpd8leBTcwfjBLBoX3/FwI0iiJsIh+y9M59l2g4bLCsV/5Vc4PXovg1l
         DFm3pkho+c8vRraW/z2CLFfokJw6P8DhJbS46pwfunofh3i8VWPBi98lnUEiHEkOVB75
         7soGAXq9dp2AZfR4VzG5UaTlPzTWGKFbiNHMy1AuBS+6TKbT50jH4ibwscyzl2XMLko2
         mHjOGQv6Hjnc9pephFbo77Oth9mo2070UUZpmTpd5uQu3xgpUjSDe7O4Jgjp7IbLhLJk
         +9RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695851841; x=1696456641;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C8UcNE7WpJNzoucJVd9mzuEISgOkE40JhABaY8jhGMo=;
        b=o37Fjdgd6zUhoaZ7QM5yL8az97VdgjaHt1ebqRGcrRDZsX2aWwjEW8qBW+kymZAmSd
         CUuSiVEFoTrRZd0tNPPcExM7ApzoScktm6wmcL3YJqbJY5GpCCTpjhzzL2Lvsd8igxS/
         kpXmm4FPT4AGFznM3OwJTuaOE9+VAsxP/dA3tyUBvt613fNSrJfh+JoA72OWBlZy2DLe
         nTDmod5QbiOLDhM+P9xT1goguCTDaQBQKLlNGGO2CtYrQiRKNhDx8eHLV2XipHuePe2V
         7/1JKd5mWvV5saH8zo1poqRQFSQvYKUI3Xcbo45D3B+O555bZMotLD8ezoVmlcR5Y876
         7QTQ==
X-Gm-Message-State: AOJu0YzsL5ZIwb9w5+DnuMTOvjpCcTK6rP6dVbp66hWlEUJA1JeD8TcJ
        4GWRWNGVA8K2wju/kCWpumkq8croZNwWuA==
X-Google-Smtp-Source: AGHT+IFb6aJQv9zqRLQqM7SHeE1wnvUe4gwFYwnK+JFRoNYJq7h7f03mTTYMgykcfJqP96Z+BjWrDA==
X-Received: by 2002:a1c:7904:0:b0:401:daf2:2737 with SMTP id l4-20020a1c7904000000b00401daf22737mr3070193wme.30.1695851840343;
        Wed, 27 Sep 2023 14:57:20 -0700 (PDT)
Received: from [192.168.1.121] (athedsl-4558735.home.otenet.gr. [94.70.91.151])
        by smtp.googlemail.com with ESMTPSA id y1-20020a05600c364100b003fefe70ec9csm2747634wmq.10.2023.09.27.14.57.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Sep 2023 14:57:19 -0700 (PDT)
Subject: Re: btrfstune --convert-to-block-group-tree segfaulted. now
 filesystem is unmountable
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <3c93d0b5-a8cb-ebe3-f8d6-76ea6340f23e@gmail.com>
 <0b7b9bd4-9b0c-467c-be20-b7d6b613e5d3@gmx.com>
 <31319035-f0cf-0882-321e-ad50ccfd5e40@gmail.com>
 <81f63d28-a2be-47b6-9dd3-32735be73101@gmx.com>
 <620ca0c7-8152-4251-8f23-6b1cf0959de5@gmx.com>
 <07e9fd50-ca9d-cebf-31e9-402da6812d1d@gmail.com>
 <5986bd50-d7c0-41ff-a4d8-a90f4edadaca@gmx.com>
From:   Konstantinos Skarlatos <k.skarlatos@gmail.com>
Message-ID: <2c2c5520-08e3-b477-0f94-20fd7d86b517@gmail.com>
Date:   Thu, 28 Sep 2023 00:57:19 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <5986bd50-d7c0-41ff-a4d8-a90f4edadaca@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On 27/9/2023 11:44 μ.μ., Qu Wenruo wrote:
>
>
> On 2023/9/28 00:05, Konstantinos Skarlatos wrote:
>>
>> On 26/09/2023 12:21 πμ, Qu Wenruo wrote:
>>>
>>>
>>> On 2023/9/23 07:16, Qu Wenruo wrote:
>>>>
>>>>
>>>> On 2023/9/22 19:02, Konstantinos Skarlatos wrote:
>>>>> Hello Qu,
>>>>> thank you for your quick answer!
>>>>> using your patch, i now get this:
>>>>>
>>>>> ❯ ./btrfstune --convert-to-block-group-tree /dev/sda
>>>>> ERROR: Corrupted fs, no valid METADATA block group found
>>>>
>>>> Mind to dump the involved trees by:
>>>>
>>>>    # btrfs ins dump-tree -t extent /dev/sda
>>>
>>> How stupid I'm... That tree can be super large.
>>>
>>> Would you mind to dump it using the following command?
>>>
>>>   # btrfs ins dump-tree -t extent test.img |\
>>>     grep "item .* BLOCK_GROUP_ITEM "
>>>
>>> This should greatly reduce the size while still get what I need.
>>>
>>> Thanks,
>>> Qu
>> Hi Qu,
>> Here are the two dumps - much smaller now :)
>>
>> btrfs ins dump-tree -t 11 /dev/sda  > dump2.txt
>> btrfs ins dump-tree -t extent /dev/sda | grep "item .* BLOCK_GROUP_ITEM
>> " > dump3.txt
>
> Good news, the block groups items are still there for the old extent 
> tree. Only the data block group items (which have a larger bytenr) are 
> converted to block group tree.
> And the conversion is indeed in bytenr order correctly.
>
> I'll need to investigate the reason why open_ctree() doesn't read the 
> old block group items from the old tree.

Thanks Qu for the good news!


kind regards,


>
> Thanks,
> Qu
>>
>> Kind regards,
>> Konstantinos Skarlatos
>>>>
>>>> And
>>>>
>>>>    # btrfs ins dump-tree -t 11 /dev/sda
>>>>
>>>>
>>>> Considering the code converting a block group, there should never be
>>>> a missing block group (either in the old or the new tree).
>>>> I think there may be something wrong with the code reading both trees.
>>>>
>>>> Thanks,
>>>> Qu
>>>>> ERROR: failed to delete block group item from the old root: -117
>>>>> ERROR: failed to convert the filesystem to block group tree feature
>>>>> ERROR: btrfstune failed
>>>>> extent buffer leak: start 17825576632320 len 16384
>>>>>
>>>>> On 22/09/2023 12:06 π.μ., Qu Wenruo wrote:
>>>>>>
>>>>>>
>>>>>> On 2023/9/21 22:57, Konstantinos Skarlatos wrote:
>>>>>>> Hi all,
>>>>>>> i tried to convert my BTRFS filesystem to block-group-tree but it
>>>>>>> segfaulted and now the fs is not mountable.
>>>>>>>
>>>>>>> ❯ btrfstune --convert-to-block-group-tree /dev/sda
>>>>>>> [1]    174047 segmentation fault (core dumped) btrfstune
>>>>>>> --convert-to-block-group-tree /dev/sda
>>>>>>>
>>>>>>>
>>>>>>> [2531715.190802] btrfstune[174047]: segfault at 1f ip
>>>>>>> 000055ec409fd198
>>>>>>> sp 00007ffd0a772eb0 error 4 in btrfstune[55ec409d6000+6a000]
>>>>>>> likely on
>>>>>>> CPU 3 (core 2, socket 0)
>>>>>>> [2531715.190818] Code: 40 00 f3 0f 1e fa 41 56 41 55 49 89 fd 41
>>>>>>> 54 49
>>>>>>> 89 f4 55 89 d5 53 48 8b 5f 68 49 89 ee 48 85 db 74 3f 48 8d 74 35
>>>>>>> 00 0f
>>>>>>> 1f 00 <48> 8b 43 20 48 8b 4b 28 48 01 c1 49 39 cc 0f 83 8c 00 00 00
>>>>>>> 48 39
>>>>>>>
>>>>>>> [174131]: Process 174047 (btrfstune) of user 0 dumped core.
>>>>>>>
>>>>>>> Stack trace of
>>>>>>> thread
>>>>>>> 174047:
>>>>>>> #0
>>>>>>> 0x000055ec409fd198
>>>>>>> alloc_extent_buffer (btrfstune + 0x34198)
>>>>>>> #1
>>>>>>> 0x000055ec409ee4f5
>>>>>>> read_tree_block (btrfstune + 0x254f5)
>>>>>>> #2
>>>>>>> 0x000055ec409db5a6
>>>>>>> read_node_slot (btrfstune + 0x125a6)
>>>>>>> #3
>>>>>>> 0x000055ec409e6e2d
>>>>>>> n/a (btrfstune + 0x1de2d)
>>>>>>> #4
>>>>>>> 0x000055ec409e8a4d
>>>>>>> n/a (btrfstune + 0x1fa4d)
>>>>>>> #5
>>>>>>> 0x000055ec409def01
>>>>>>> btrfs_search_slot (btrfstune + 0x15f01)
>>>>>>> #6
>>>>>>> 0x000055ec409e9c79
>>>>>>> btrfs_insert_empty_items (btrfstune + 0x20c79)
>>>>>>> #7
>>>>>>> 0x000055ec40a0090c
>>>>>>> n/a (btrfstune + 0x3790c)
>>>>>>> #8
>>>>>>> 0x000055ec40a05185
>>>>>>> n/a (btrfstune + 0x3c185)
>>>>>>> #9
>>>>>>> 0x000055ec40a05c75
>>>>>>> add_to_free_space_tree (btrfstune + 0x3cc75)
>>>>>>
>>>>>> There seems to be something wrong with free space tree code here.
>>>>>> Not sure which part is causing the problem, the fst or the 
>>>>>> conversion
>>>>>> part.
>>>>>>
>>>>>>> #10
>>>>>>> 0x000055ec40a3ec49
>>>>>>> n/a (btrfstune + 0x75c49)
>>>>>>> #11
>>>>>>> 0x000055ec409fb52a
>>>>>>> btrfs_run_delayed_refs (btrfstune + 0x3252a)
>>>>>>> #12
>>>>>>> 0x000055ec40a13091
>>>>>>> btrfs_commit_transaction (btrfstune + 0x4a091)
>>>>>>> #13
>>>>>>> 0x000055ec409dcfdd
>>>>>>> convert_to_bg_tree (btrfstune + 0x13fdd)
>>>>>>> #14
>>>>>>> 0x000055ec409d640a
>>>>>>> main (btrfstune + 0xd40a)
>>>>>>> #15
>>>>>>> 0x00007f44ace27cd0
>>>>>>> n/a (libc.so.6 + 0x27cd0)
>>>>>>> #16
>>>>>>> 0x00007f44ace27d8a
>>>>>>> __libc_start_main (libc.so.6 + 0x27d8a)
>>>>>>> #17
>>>>>>> 0x000055ec409d7db5
>>>>>>> _start (btrfstune + 0xedb5)
>>>>>>> ELF object binary
>>>>>>> architecture: AMD x86-64
>>>>>>>
>>>>>>>
>>>>>>> ❯ btrfstune --convert-from-block-group-tree /dev/sda
>>>>>>> ERROR: filesystem doesn't have block-group-tree feature
>>>>>>>
>>>>>>>
>>>>>>> ❯ mount /dev/sda /storage/btrfs -o ro
>>>>>>> mount: /storage/btrfs: wrong fs type, bad option, bad superblock on
>>>>>>> /dev/sda, missing codepage or helper program, or other error.
>>>>>>>           dmesg(1) may have more information after failed mount 
>>>>>>> system
>>>>>>> call.
>>>>>>>
>>>>>>> Sep 19 17:18:23 elsinki kernel: BTRFS info (device sda): using 
>>>>>>> crc32c
>>>>>>> (crc32c-generic) checksum algorithm
>>>>>>> Sep 19 17:18:23 elsinki kernel: BTRFS error (device sda):
>>>>>>> unrecognized
>>>>>>> or unsupported super flag: 274877906944
>>>>>>> Sep 19 17:18:23 elsinki kernel: BTRFS error (device sda): 
>>>>>>> superblock
>>>>>>> contains fatal errors
>>>>>>> Sep 19 17:18:23 elsinki kernel: BTRFS error (device sda): 
>>>>>>> open_ctree
>>>>>>> failed
>>>>>>>
>>>>>>>
>>>>>>> ❯ btrfstune --convert-to-block-group-tree /dev/sda
>>>>>>> ERROR: failed to find block group for bytenr 20196285349888
>>>>>>
>>>>>> This is the correct way to resume the failed conversion.
>>>>>>
>>>>>> But by somehow the block group item seems to be missing from both 
>>>>>> old
>>>>>> and new trees.
>>>>>>
>>>>>> Mind to test if the attached patch can help?
>>>>>>
>>>>>>
>>>>>>
>>>>>>> ERROR: failed to convert the filesystem to block group tree feature
>>>>>>> extent buffer leak: start 17825576632320 len 16384
>>>>>>>
>>>>>>> ❯ btrfs filesystem show
>>>>>>> Label: none  uuid: 5a583d35-3eb2-410b-9044-1ac87a062247
>>>>>>>            Total devices 3 FS bytes used 9.53TiB
>>>>>>>            devid    1 size 3.64TiB used 3.64TiB path /dev/sda
>>>>>>>            devid    2 size 3.64TiB used 3.64TiB path /dev/sdc
>>>>>>>            devid    3 size 3.64TiB used 3.64TiB path /dev/sdd
>>>>>>>
>>>>>>> ❯ btrfs check --mode lowmem /dev/sda
>>>>>>> Opening filesystem to check...
>>>>>>> Checking filesystem on /dev/sda
>>>>>>> UUID: 5a583d35-3eb2-410b-9044-1ac87a062247
>>>>>>> [1/7] checking root items
>>>>>>> [2/7] checking extents
>>>>>>> ERROR: chunk [20197359091712 20198432833536) doesn't have related
>>>>>>> block
>>>>>>> group item
>>>>>> [...]> ERROR: chunk [20674088337408 20674096726016) doesn't have
>>>>>> related block
>>>>>>> group item
>>>>>>
>>>>>> This shows most of the block groups have been converted.
>>>>>> Hope the patch can finish the conversion.
>>>>>>
>>>>>> Thanks,
>>>>>> Qu
>>>>>>>
>>>>>>>
>>>>>>> my system specs are:
>>>>>>> AMD Phenom(tm) II X4 965 Processor @3400MHz
>>>>>>> 8GB RAM
>>>>>>>
>>>>>>> ❯ uname -r
>>>>>>> 6.4.9-arch1-1
>>>>>>>
>>>>>>>
>>>>>
>>
>>
