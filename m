Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 842FE3FB013
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Aug 2021 05:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbhH3DtC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 29 Aug 2021 23:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhH3DtC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 29 Aug 2021 23:49:02 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4C3C061575
        for <linux-btrfs@vger.kernel.org>; Sun, 29 Aug 2021 20:48:09 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id q68so12118349pga.9
        for <linux-btrfs@vger.kernel.org>; Sun, 29 Aug 2021 20:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=mPMoSqxg8jSXbf9Us2oJXYNJTS6cdMbdXdxJtXly08Q=;
        b=V0gd4pHZgdUFk4JNmIpfx2AHFgBdBeDRnndTQKuNAOEgCMQEhyo1fqW/+wBAJ+YEDA
         /IHCwgYE/hpDhBnyAsyHq6d3HV33fbW6poyGhghXCYATt6+Paou3coM+1APBSa8qUhWR
         lF0WZGHeaPDx1DberRHpmvzqrgYVjAmaduU2Q6ZA7A9GYHFHR8bmeDRpAVOPSTndaAYU
         EQ4roQ1kr4oTi4D3D9TGwBPYSXoBLfF5STBsOLKy2DWA7eVCnh4qRV78/2aoCzVfVOKt
         2WhAklUUMz1kfid3EGsV41+4LWGlH4RU48h7mVNLyuRxHyTCxVYP9rXwbXLwQt8GJ7vC
         HotA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=mPMoSqxg8jSXbf9Us2oJXYNJTS6cdMbdXdxJtXly08Q=;
        b=QGCI+1GSLipOBK8FKYrn7GUPQN+FSD/DLQBMEtRYoXdpvKqM0+wBc2r014Ffp3WOy/
         tk2PFtmnTk/J6lkf5WtpIAdd5vP5C5eObtoBwOAbS92uhYCyEdH6NKxGYmHkm4TiN1c2
         hqCBEZ9RD922GIlsl3UeV1pBFSEdT0aJQXr1UREpytyVQHJZmluuN1D8fsh7dVEBdO4R
         lTSIPpSgAao072R86YdbnSI9LDhaAj0g0En+VObBP8+CwarftKkcNUxcyMJPpEoq97PF
         oxYRAQ8iFtD4fjfwr5WjG8j/sNHiIQ4SgJ9u1fssUsax6igmwPA7lMXpI9CW915EFhUX
         iDMA==
X-Gm-Message-State: AOAM533xKjFe4/76R0spTBK7cG0DOcQXOX+Dx9aT5l6K52Ficx6bXQa6
        p8lK5r5wHNZ7RZwPv4+y3hg=
X-Google-Smtp-Source: ABdhPJxtsrcVLl0Gt/PL9d13IZ2amNhLkZX9EsECKuo0ZjKv8OTctASD75mywdioJmPPTWhkalYQiA==
X-Received: by 2002:a62:920b:0:b0:3ec:7912:82be with SMTP id o11-20020a62920b000000b003ec791282bemr21311584pfd.34.1630295288484;
        Sun, 29 Aug 2021 20:48:08 -0700 (PDT)
Received: from [192.168.2.53] (108-201-186-146.lightspeed.sntcca.sbcglobal.net. [108.201.186.146])
        by smtp.gmail.com with ESMTPSA id l185sm13042824pfd.62.2021.08.29.20.48.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Aug 2021 20:48:07 -0700 (PDT)
Subject: Re: Trying to recover data from SSD
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <67691486-9dd9-6837-d485-30279d3d3413@gmail.com>
 <d60cca92-5fe2-6059-3591-8830ca9cf35c@gmail.com>
 <c7fed97e-d034-3af1-2072-65a9bb0e49ef@gmx.com>
 <544e3e73-5490-2cae-c889-88d80e583ac4@gmail.com>
 <c03628f0-585c-cfa8-5d80-bd1f1e4fb9c1@gmx.com>
 <d7c65e1d-6f4e-484b-a52f-60084160969f@gmail.com>
 <2684f59f-679d-5ee7-2591-f0a4ea4e9fbe@gmx.com>
 <238d1f6c-20a9-f002-e03a-722175c63bd6@gmail.com>
 <4bd90f4a-7ced-3477-f113-eee72bc05cbb@gmx.com>
 <fab2dab5-41bb-43f2-5396-451d66df3917@gmail.com>
 <60a21bca-d133-26c0-4768-7d9a70f9d102@gmx.com>
 <7e8394c9-9eb3-c593-9473-5c40d80428a5@gmail.com>
 <1785017b-e23b-e93d-5b78-2aa40170fe62@gmail.com>
 <14a9a98c-50fc-eb7b-804b-2fe36775b5fa@gmx.com>
 <36652872-850c-fe92-9fcd-c9c95dc25d65@gmail.com>
 <cebedd98-1fe4-731f-fc54-5366c8f18a2f@gmx.com>
 <d0ebdff7-10f0-c8f3-e098-18f651a149d8@gmail.com>
 <597bd681-c7ba-075c-4376-142695b91f93@gmx.com>
 <4a5d64fd-637c-bd8a-fe6f-db1bb20942c2@gmail.com>
 <5858520a-ca82-0552-140d-9702fc7dad94@gmx.com>
From:   Konstantin Svist <fry.kun@gmail.com>
Message-ID: <74809aba-047e-ca7a-e5b4-d64287ddd81d@gmail.com>
Date:   Sun, 29 Aug 2021 20:48:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <5858520a-ca82-0552-140d-9702fc7dad94@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/29/21 17:22, Qu Wenruo wrote:
>
>
> On 2021/8/30 上午4:02, Konstantin Svist wrote:
>> On 8/29/21 00:19, Qu Wenruo wrote:
>>>
>>>
>>> On 2021/8/29 下午2:34, Konstantin Svist wrote:
>>>>
>>>> # btrfs ins dump-tree -b 787070976 --follow /dev/sdb3 | grep "(257
>>>> ROOT_ITEM" -A 5
>>>> checksum verify failed on 786939904 wanted 0xcdcdcdcd found 0xc375d6b6
>>>> checksum verify failed on 786939904 wanted 0xcdcdcdcd found 0xc375d6b6
>>>> checksum verify failed on 786939904 wanted 0xcdcdcdcd found 0xc375d6b6
>>>> Csum didn't match
>>>> WARNING: could not setup extent tree, skipping it
>>>>       item 13 key (257 ROOT_ITEM 0) itemoff 13147 itemsize 439
>>>>           generation 166932 root_dirid 256 bytenr 786726912 level 2
>>>> refs 1
>>>>           lastsnap 56690 byte_limit 0 bytes_used 1013104640 flags
>>>> 0x0(none)
>>>>           uuid 1ac60d28-6f11-2842-aca2-b1574b108336
>>>>           ctransid 166932 otransid 8 stransid 0 rtransid 0
>>>>           ctime 1627959592.718936423 (2021-08-02 19:59:52)
>>>>
>>>>
>>>> # btrfs restore -Divf 786726912 /dev/sdb3 .
>>>> checksum verify failed on 786939904 wanted 0xcdcdcdcd found 0xc375d6b6
>>>> checksum verify failed on 786939904 wanted 0xcdcdcdcd found 0xc375d6b6
>>>> checksum verify failed on 786939904 wanted 0xcdcdcdcd found 0xc375d6b6
>>>> Csum didn't match
>>>> WARNING: could not setup extent tree, skipping it
>>>> This is a dry-run, no files are going to be restored
>>>> checksum verify failed on 920748032 wanted 0x00000000 found 0xb6bde3e4
>>>> checksum verify failed on 920748032 wanted 0x00000000 found 0xb6bde3e4
>>>> checksum verify failed on 920748032 wanted 0x00000000 found 0xb6bde3e4
>>>> bad tree block 920748032, bytenr mismatch, want=920748032, have=0
>>>> ERROR: search for next directory entry failed: -5
>>>
>>> This all zero means the data on-disk are wiped.
>>>
>>> Either not reaching disk or discarded.
>>>
>>> Neither is a good thing.
>>>
>>>>
>>>>
>>>> 1st set of "checksum verify failed" has different addresses, but the
>>>> last set always has 920748032
>>>
>>> Have you tried other bytenrs from find-root?
>>
>>
>> Is it normal that they all fail on the same exact block? Sounds
>> suspicious to me.
>
> This means some higher tree block is corrupted.
>
> Only manual inspection can determine.
>
> But this is definite not a good thing for your data salvage...
>>
>>
>> The other 3 attempts:
>>
>>
>> # btrfs ins dump-super -f /dev/sdb3 | grep backup_tree_root
>>          backup_tree_root:    787070976    gen: 166932    level: 1
>>          backup_tree_root:    778108928    gen: 166929    level: 1
>>          backup_tree_root:    781172736    gen: 166930    level: 1
>>          backup_tree_root:    786399232    gen: 166931    level: 1
>>
>> # btrfs ins dump-tree -b 786399232 --follow /dev/sdb3 | grep "(257
>> ROOT_ITEM" -A 5
>> [...]
>>      item 13 key (257 ROOT_ITEM 0) itemoff 13147 itemsize 439
>>          generation 166931 root_dirid 256 bytenr 781467648 level 2
>> refs 1
>>          lastsnap 56690 byte_limit 0 bytes_used 1013104640 flags
>> 0x0(none)
>>
>> [...]
>
> To manually inspect the tree, you can use btrfs-inspect to see what's
> wrong with the tree blocks.
>
> # btrfs ins dump-tree -b 781467648 --follow --bfs /dev/sdb3
>
> This also means, even the remaining part is fine, a big chunk of data
> can no longer be recovered. 


I'm hoping to find several important files at this point, definitely
don't need the whole FS..

So when I run this, I get about 190 lines like

    key (256 INODE_ITEM 0) block 920748032 gen 166878
    key (52607 DIR_ITEM 988524606) block 1078902784 gen 163454
    key (52607 DIR_INDEX 18179) block 189497344 gen 30
    key (174523 INODE_REF 52607) block 185942016 gen 30
    key (361729 EXTENT_DATA 0) block 785907712 gen 166931
    key (381042 XATTR_ITEM 3817753667) block 1027391488 gen 120910


I tried to pass these into restore, but it's not liking it:

# btrfs restore -Divf 196816535552 /dev/sdb3 .
checksum verify failed on 786939904 wanted 0xcdcdcdcd found 0xc375d6b6
checksum verify failed on 786939904 wanted 0xcdcdcdcd found 0xc375d6b6
checksum verify failed on 786939904 wanted 0xcdcdcdcd found 0xc375d6b6
Csum didn't match
WARNING: could not setup extent tree, skipping it
This is a dry-run, no files are going to be restored
Done searching



