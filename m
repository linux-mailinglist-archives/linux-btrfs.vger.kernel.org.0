Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CED383FA7FA
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 Aug 2021 01:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbhH1XQz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 28 Aug 2021 19:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbhH1XQy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 28 Aug 2021 19:16:54 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE497C061756
        for <linux-btrfs@vger.kernel.org>; Sat, 28 Aug 2021 16:16:03 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id f11-20020a17090aa78b00b0018e98a7cddaso7479035pjq.4
        for <linux-btrfs@vger.kernel.org>; Sat, 28 Aug 2021 16:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=3+F4IHd+C1OwwNPNDahYmd2udWMchbowbg9lYa4MSY4=;
        b=qOdQarYZ1eQZYW88sYs1p4gYqFYdyZPdogosuSpzyvoxQ4gdNYLERHjRPgorXbH2/q
         a3z6wJJuPAsiSL36pHcXTD9u6Svi/gJkwcsxj0jqJ8/A1p/KdmBaglEM3RRdNYgaoDpc
         V0BveP67OxojkumuSJWqpxWUjWHn/4z5E5QklgybeZkLAX9VU2NzR9zte6nWRcyhpVOQ
         9c9PSdP1iajl5+YEwHoMOIaesmYm3cCSMIjsGsf3yxPNQBRv6hXz3h65Xujfk2y02vq7
         pUGUk0whAIg3FvErBXkN1On2OnQbW+iYwaS83ZdLDzF42yd+6JXgb2EenmPj7R4sF+DS
         gOlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=3+F4IHd+C1OwwNPNDahYmd2udWMchbowbg9lYa4MSY4=;
        b=pUvHXGVjv6JMgMUblRI0cJQYh2k345wr8WeclRLJaGMKDEc5WU6INugMfKsniNeXDA
         QtdwfLRATtdr//3G0yCR9iMNUz7+KwqQU8h7f6jIE+ryVX07iVvfnKmIw5ihp1FMppuO
         CP1bBx4B/W7ZUd5TOYW3Hz7TjEceHmw6y5mxMa4MQtVzJ4gTwevmz4OeI2SuBu7YFRJZ
         6P9VKhX1BHDbQrPFtK5f0a79ZvzVdq7Z54YIV8Ie9/DRqFoB0pR6ha6pRZll/zOJ2p7l
         +ecrg898Q+FbdpjKM4bCTiQiysVoVsLGF8DU11HvW6TsB/rT76E96XrOisgT9WW/GirW
         v97Q==
X-Gm-Message-State: AOAM533f5SIjyXHAq6LboSK0wbA14Ki+feRZ29jCpIEL+qdFeoc2Q4aj
        9XHHa8YyNLCIe3ZNkVAxjYs=
X-Google-Smtp-Source: ABdhPJxv9AfIZPt/NZ2d/IcIOdfa65Yft4MBd1qJsV3ZIOuvzg15x6wi6uC/F5MjnGA8y21MxOZPzA==
X-Received: by 2002:a17:90a:bb82:: with SMTP id v2mr30938156pjr.125.1630192563004;
        Sat, 28 Aug 2021 16:16:03 -0700 (PDT)
Received: from [192.168.2.53] (108-201-186-146.lightspeed.sntcca.sbcglobal.net. [108.201.186.146])
        by smtp.gmail.com with ESMTPSA id z9sm10142476pfn.22.2021.08.28.16.16.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Aug 2021 16:16:01 -0700 (PDT)
Subject: Re: Trying to recover data from SSD
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <67691486-9dd9-6837-d485-30279d3d3413@gmail.com>
 <46f3b990-ec2d-6508-249e-8954bf356e89@gmx.com>
 <CADQtc0=GDa-v_byewDmUHqr-TrX_S734ezwhLYL9OSkX-jcNOw@mail.gmail.com>
 <04ce5d53-3028-16a3-cc1d-ee4e048acdba@gmx.com>
 <7f42b532-07b4-5833-653f-bef148be5d9a@gmail.com>
 <1c066a71-bc66-3b12-c566-bac46d740960@gmx.com>
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
From:   Konstantin Svist <fry.kun@gmail.com>
Message-ID: <36652872-850c-fe92-9fcd-c9c95dc25d65@gmail.com>
Date:   Sat, 28 Aug 2021 16:16:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <14a9a98c-50fc-eb7b-804b-2fe36775b5fa@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/27/21 23:16, Qu Wenruo wrote:
>
>
> On 2021/8/28 下午1:57, Konstantin Svist wrote:
>> On 8/20/21 19:56, Konstantin Svist wrote:
>>> On 8/11/21 18:18, Qu Wenruo wrote:
>>>>
>>>> On 2021/8/12 上午6:34, Konstantin Svist wrote:
>>>>> Shouldn't there be an earlier generation of this subvolume's tree
>>>>> block
>>>>> somewhere on the disk? Would all of them have gotten overwritten
>>>>> already?
>>>> Then it will be more complex and I can't ensure any good result.
>>>
>>> It was already pretty complex and results were never guaranteed :)
>>>
>>>
>>>> Firstly you need to find an older root tree:
>>>>
>>>> # btrfs ins dump-super -f /dev/sdb3 | grep backup_tree_root
>>>>                  backup_tree_root:       30687232        gen: 2317
>>>>   level: 0
>>>>                  backup_tree_root:       30834688        gen: 2318
>>>>   level: 0
>>>>                  backup_tree_root:       30408704        gen: 2319
>>>>   level: 0
>>>>                  backup_tree_root:       31031296        gen: 2316
>>>>   level: 0
>>>>
>>>> Then try the bytenr in their reverse generation order in btrfs ins
>>>> dump-tree:
>>>> (The latest one should be the current root, thus you can skip it)
>>>>
>>>> # btrfs ins dump-tree -b 30834688 /dev/sdb3 | grep "(257 ROOT_ITEM"
>>>> -A 5
>>>>
>>>> Then grab the bytenr of the subvolume 257, then pass the bytenr to
>>>> btrfs-restore:
>>>>
>>>> # btrfs-restore -f <bytenr> /dev/sdb3 <restore_path>
>>>>
>>>> The chance is already pretty low, good luck.
>>>>
>>>> Thanks,
>>>> Qu
>>>
>>>
>>> When I run dump-tree, I get this:
>>>
>>> # btrfs ins dump-tree -b 787070976 /dev/sdb3 | grep "(257 ROOT_ITEM"
>>> -A 5
>>> checksum verify failed on 786939904 wanted 0xcdcdcdcd found 0xc375d6b6
>>> checksum verify failed on 786939904 wanted 0xcdcdcdcd found 0xc375d6b6
>>> checksum verify failed on 786939904 wanted 0xcdcdcdcd found 0xc375d6b6
>>> Csum didn't match
>>> WARNING: could not setup extent tree, skipping it
>>>
>>> The same exact offset fails checksum for all 4 backup roots, any way
>>> around this?
>
> When without the grep, is there any output?


# btrfs ins dump-tree -b 787070976 /dev/sdb3
btrfs-progs v5.13.1
checksum verify failed on 786939904 wanted 0xcdcdcdcd found 0xc375d6b6
checksum verify failed on 786939904 wanted 0xcdcdcdcd found 0xc375d6b6
checksum verify failed on 786939904 wanted 0xcdcdcdcd found 0xc375d6b6
Csum didn't match
WARNING: could not setup extent tree, skipping it
node 787070976 level 1 items 7 free space 486 generation 166932 owner
ROOT_TREE
node 787070976 flags 0x1(WRITTEN) backref revision 1
fs uuid 44a768e0-28ba-4c6a-8eef-18ffa8c27d1b
chunk uuid a8a06213-eebf-40d8-ab1a-914f621fbe1c
    key (EXTENT_TREE ROOT_ITEM 0) block 787087360 gen 166932
    key (277 INODE_ITEM 0) block 197491195904 gen 56511
    key (305 INODE_ITEM 0) block 778174464 gen 166929
    key (366 EXTENT_DATA 0) block 197491949568 gen 56511
    key (428 INODE_ITEM 0) block 36175872 gen 166829
    key (476 INODE_ITEM 0) block 787234816 gen 166932
    key (FREE_SPACE UNTYPED 99888398336) block 780812288 gen 166929

# btrfs ins dump-tree -b 778108928 /dev/sdb3
btrfs-progs v5.13.1
checksum verify failed on 786939904 wanted 0xcdcdcdcd found 0xc375d6b6
checksum verify failed on 786939904 wanted 0xcdcdcdcd found 0xc375d6b6
checksum verify failed on 786939904 wanted 0xcdcdcdcd found 0xc375d6b6
Csum didn't match
WARNING: could not setup extent tree, skipping it
node 778108928 level 1 items 7 free space 486 generation 166929 owner
ROOT_TREE
node 778108928 flags 0x1(WRITTEN) backref revision 1
fs uuid 44a768e0-28ba-4c6a-8eef-18ffa8c27d1b
chunk uuid a8a06213-eebf-40d8-ab1a-914f621fbe1c
    key (EXTENT_TREE ROOT_ITEM 0) block 778125312 gen 166929
    key (277 INODE_ITEM 0) block 197491195904 gen 56511
    key (305 INODE_ITEM 0) block 778174464 gen 166929
    key (366 EXTENT_DATA 0) block 197491949568 gen 56511
    key (428 INODE_ITEM 0) block 36175872 gen 166829
    key (476 INODE_ITEM 0) block 780730368 gen 166929
    key (FREE_SPACE UNTYPED 99888398336) block 780812288 gen 166929

..and 2 more from other backup_tree_roots


