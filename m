Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 799837AAE19
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Sep 2023 11:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233176AbjIVJdU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Sep 2023 05:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233174AbjIVJdG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Sep 2023 05:33:06 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40131E72
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 02:32:43 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so7194913a12.1
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 02:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695375162; x=1695979962; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fb55LnCrc+vsxxVtjvUF9uvJ88hHNWP5ajn5fjwexJ0=;
        b=V/ZVRhBQcYVz9Z5rOEP2sSVQ9NcVz3tpe9tlnI8uM3oWJObEL0N9wyFBcsIQF+R69v
         aEgfyTq1TOmahW4jcH5paypfm/x0+jCp6+sN3kcN8YhglEDfjUIc4iEfe5Ug9yjn39da
         z73X3OPZkEcQnsqAfwvimkhHbktL/3tiKm0TcGwMHejkkrGyWfyvGjMciLMLeyDpCs6+
         6Fj69nSkXdVtfCkgZ71UWharl4HNcrjH+4kqeFQESR+H28E9ZDbd5PxMKjQ+15ze/jvp
         P0/aM27Lbf4QED4/RrV5DWubGxuNnLoqF5g064KRrmZQmURX00rRxvl9/puorOqxq9U6
         J0DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695375162; x=1695979962;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fb55LnCrc+vsxxVtjvUF9uvJ88hHNWP5ajn5fjwexJ0=;
        b=WwX2PpZ0hLVw/mfdjDQ8wrGoyZrQ3ZCnPobnjhjK8FMK1IIiUmxiuejVWSOCrufbzS
         ohvPP8QC7AoIsdKRddmRrV4pF1i+J2hyzCQUrpNF3FiInw+2yXhivuayqSonwvgrW/n+
         hQhXNmF4weWKZorsXanjr++jMmw6HedjMdMEyjRLWqcavv/bBrJAXPLVyaXapXKbA/RG
         w5nTpaLvVIL6V95oV87yi6p/cGoJEYKIIEDf8pli5IHXdhd0Nr/MsKuXKtzLdLbhuMK1
         chp6bjQwT8+qj976IFonKRiJLDnNgxKnqUpQVs546GEyTeuM2xVxbScW52t1MPm6Ere2
         KcSQ==
X-Gm-Message-State: AOJu0YzyPOzAWWiSV6m2ecZzt9gY0yot2vDgmjpJ6boXbwwuurS4YxoD
        TpMkbqjYayCEkuddhCMOhzU=
X-Google-Smtp-Source: AGHT+IFjOjsR6Z6OKNfrDn5FDReDjqGBKowte518rk9Dvl4eiagAvt/9UwnUdr4Eye4+wHnKnXPv+Q==
X-Received: by 2002:a05:6402:254b:b0:533:26cd:37c4 with SMTP id l11-20020a056402254b00b0053326cd37c4mr3152224edb.11.1695375161329;
        Fri, 22 Sep 2023 02:32:41 -0700 (PDT)
Received: from [192.168.3.88] (ppp-94-68-116-207.home.otenet.gr. [94.68.116.207])
        by smtp.googlemail.com with ESMTPSA id r22-20020a056402035600b00530ccd180a3sm2001783edw.97.2023.09.22.02.32.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Sep 2023 02:32:40 -0700 (PDT)
Message-ID: <31319035-f0cf-0882-321e-ad50ccfd5e40@gmail.com>
Date:   Fri, 22 Sep 2023 12:32:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: btrfstune --convert-to-block-group-tree segfaulted. now
 filesystem is unmountable
Content-Language: el-en, en-US
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <3c93d0b5-a8cb-ebe3-f8d6-76ea6340f23e@gmail.com>
 <0b7b9bd4-9b0c-467c-be20-b7d6b613e5d3@gmx.com>
From:   Konstantinos Skarlatos <k.skarlatos@gmail.com>
In-Reply-To: <0b7b9bd4-9b0c-467c-be20-b7d6b613e5d3@gmx.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello Qu,
thank you for your quick answer!
using your patch, i now get this:

❯ ./btrfstune --convert-to-block-group-tree /dev/sda
ERROR: Corrupted fs, no valid METADATA block group found
ERROR: failed to delete block group item from the old root: -117
ERROR: failed to convert the filesystem to block group tree feature
ERROR: btrfstune failed
extent buffer leak: start 17825576632320 len 16384

On 22/09/2023 12:06 π.μ., Qu Wenruo wrote:
>
>
> On 2023/9/21 22:57, Konstantinos Skarlatos wrote:
>> Hi all,
>> i tried to convert my BTRFS filesystem to block-group-tree but it
>> segfaulted and now the fs is not mountable.
>>
>> ❯ btrfstune --convert-to-block-group-tree /dev/sda
>> [1]    174047 segmentation fault (core dumped)  btrfstune
>> --convert-to-block-group-tree /dev/sda
>>
>>
>> [2531715.190802] btrfstune[174047]: segfault at 1f ip 000055ec409fd198
>> sp 00007ffd0a772eb0 error 4 in btrfstune[55ec409d6000+6a000] likely on
>> CPU 3 (core 2, socket 0)
>> [2531715.190818] Code: 40 00 f3 0f 1e fa 41 56 41 55 49 89 fd 41 54 49
>> 89 f4 55 89 d5 53 48 8b 5f 68 49 89 ee 48 85 db 74 3f 48 8d 74 35 00 0f
>> 1f 00 <48> 8b 43 20 48 8b 4b 28 48 01 c1 49 39 cc 0f 83 8c 00 00 00
>> 48 39
>>
>> [174131]: Process 174047 (btrfstune) of user 0 dumped core.
>>
>>                                                    Stack trace of thread
>> 174047:
>>                                                    #0 
>> 0x000055ec409fd198
>> alloc_extent_buffer (btrfstune + 0x34198)
>>                                                    #1 
>> 0x000055ec409ee4f5
>> read_tree_block (btrfstune + 0x254f5)
>>                                                    #2 
>> 0x000055ec409db5a6
>> read_node_slot (btrfstune + 0x125a6)
>>                                                    #3 
>> 0x000055ec409e6e2d
>> n/a (btrfstune + 0x1de2d)
>>                                                    #4 
>> 0x000055ec409e8a4d
>> n/a (btrfstune + 0x1fa4d)
>>                                                    #5 
>> 0x000055ec409def01
>> btrfs_search_slot (btrfstune + 0x15f01)
>>                                                    #6 
>> 0x000055ec409e9c79
>> btrfs_insert_empty_items (btrfstune + 0x20c79)
>>                                                    #7 
>> 0x000055ec40a0090c
>> n/a (btrfstune + 0x3790c)
>>                                                    #8 
>> 0x000055ec40a05185
>> n/a (btrfstune + 0x3c185)
>>                                                    #9 
>> 0x000055ec40a05c75
>> add_to_free_space_tree (btrfstune + 0x3cc75)
>
> There seems to be something wrong with free space tree code here.
> Not sure which part is causing the problem, the fst or the conversion
> part.
>
>>                                                    #10
>> 0x000055ec40a3ec49
>> n/a (btrfstune + 0x75c49)
>>                                                    #11
>> 0x000055ec409fb52a
>> btrfs_run_delayed_refs (btrfstune + 0x3252a)
>>                                                    #12
>> 0x000055ec40a13091
>> btrfs_commit_transaction (btrfstune + 0x4a091)
>>                                                    #13
>> 0x000055ec409dcfdd
>> convert_to_bg_tree (btrfstune + 0x13fdd)
>>                                                    #14
>> 0x000055ec409d640a
>> main (btrfstune + 0xd40a)
>>                                                    #15
>> 0x00007f44ace27cd0
>> n/a (libc.so.6 + 0x27cd0)
>>                                                    #16
>> 0x00007f44ace27d8a
>> __libc_start_main (libc.so.6 + 0x27d8a)
>>                                                    #17
>> 0x000055ec409d7db5
>> _start (btrfstune + 0xedb5)
>>                                                    ELF object binary
>> architecture: AMD x86-64
>>
>>
>> ❯ btrfstune --convert-from-block-group-tree /dev/sda
>> ERROR: filesystem doesn't have block-group-tree feature
>>
>>
>> ❯ mount /dev/sda /storage/btrfs -o ro
>> mount: /storage/btrfs: wrong fs type, bad option, bad superblock on
>> /dev/sda, missing codepage or helper program, or other error.
>>         dmesg(1) may have more information after failed mount system
>> call.
>>
>> Sep 19 17:18:23 elsinki kernel: BTRFS info (device sda): using crc32c
>> (crc32c-generic) checksum algorithm
>> Sep 19 17:18:23 elsinki kernel: BTRFS error (device sda): unrecognized
>> or unsupported super flag: 274877906944
>> Sep 19 17:18:23 elsinki kernel: BTRFS error (device sda): superblock
>> contains fatal errors
>> Sep 19 17:18:23 elsinki kernel: BTRFS error (device sda): open_ctree
>> failed
>>
>>
>> ❯ btrfstune --convert-to-block-group-tree /dev/sda
>> ERROR: failed to find block group for bytenr 20196285349888
>
> This is the correct way to resume the failed conversion.
>
> But by somehow the block group item seems to be missing from both old
> and new trees.
>
> Mind to test if the attached patch can help?
>
>
>
>> ERROR: failed to convert the filesystem to block group tree feature
>> extent buffer leak: start 17825576632320 len 16384
>>
>> ❯ btrfs filesystem show
>> Label: none  uuid: 5a583d35-3eb2-410b-9044-1ac87a062247
>>          Total devices 3 FS bytes used 9.53TiB
>>          devid    1 size 3.64TiB used 3.64TiB path /dev/sda
>>          devid    2 size 3.64TiB used 3.64TiB path /dev/sdc
>>          devid    3 size 3.64TiB used 3.64TiB path /dev/sdd
>>
>> ❯ btrfs check --mode lowmem /dev/sda
>> Opening filesystem to check...
>> Checking filesystem on /dev/sda
>> UUID: 5a583d35-3eb2-410b-9044-1ac87a062247
>> [1/7] checking root items
>> [2/7] checking extents
>> ERROR: chunk [20197359091712 20198432833536) doesn't have related block
>> group item
> [...]> ERROR: chunk [20674088337408 20674096726016) doesn't have
> related block
>> group item
>
> This shows most of the block groups have been converted.
> Hope the patch can finish the conversion.
>
> Thanks,
> Qu
>>
>>
>> my system specs are:
>> AMD Phenom(tm) II X4 965 Processor @3400MHz
>> 8GB RAM
>>
>> ❯ uname -r
>> 6.4.9-arch1-1
>>
>>

