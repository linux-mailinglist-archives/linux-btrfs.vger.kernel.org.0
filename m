Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F08E3F53C2
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Aug 2021 01:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233260AbhHWXrt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Aug 2021 19:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233227AbhHWXrs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Aug 2021 19:47:48 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85CE7C061575
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Aug 2021 16:47:05 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id f22so11511981qkm.5
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Aug 2021 16:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=0pqipm8sPf8xPyv0vFDUKXCZDKjXgevKwBMboEtmI/k=;
        b=HbXnMVVoSbGsxIRqsvcjcN3wel3QBtmo/ZBj6t8OKhSRVhGT8SQovQ1jlKeNEPuvdS
         STYxxE+kKcP8UYoUREBBqdeE2e9ADuzYoGBlnDHr3YNwl97JClEvcldxEfYg+m7Le6u6
         A+Qzpx/krW36+67CKLZHRN3q8Ertj2OW/dRdcbiUVkmwSuGUMphm5BTTn1Ebh48Owwrh
         +PjJLfN/Ow3EJbu2pzLurUQ3bAx+QqQ110gIU6Kl8rCC/xZBESbXh2vQW0+zmt2Ebe6H
         C6RnIOcAVWglP1pB8r6YdPkIDhZuD1MLdzNPJacwXkX5gyzIQjsH0ewqSrpaAmf9gLgV
         9ZsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0pqipm8sPf8xPyv0vFDUKXCZDKjXgevKwBMboEtmI/k=;
        b=jNH1MfrDNqsNxL91ydB1cysv/ImvxaPdB2oqNPwTSe50P3w2ljHgfzPGqTr6Qusqap
         SduM4BD35AZbbTQqayPPNvky/0Z1c+EOCULS2/pjfL4zyaiqRx7pZZQ1Y+sDyE0yO74X
         VMzbyxODur5rVMbZA9wtZPpyrc9VTzUGTY0IZvGsHQrI9aBPWGIHNYMjKNC2Zfi9B24p
         ErQSKrp4aaXvvoa7K5uy7pO2XWmOUFr+VUGaomIYIcdXY6bMtih934+j4yS5UTfAzRdV
         eVhfKOZXqjZadGRojIa2i1P8UQXZyLr5R7xUAPrg7rq/8m4yC3JqE8kOlJYpLULwxmIv
         zy1w==
X-Gm-Message-State: AOAM5317m7+9BWu/m7ZAUK8ErX2VCaJZCLUJc3axLA1zZJgakWBoP7Y3
        JOuDTPunwT/qA4n9oeswqHz77w==
X-Google-Smtp-Source: ABdhPJyKIHtsxDB5/Q6mdmIKxQBimbgd2C+BUKxbTAg22rHPCkgNt+7T0MEIfIHynbiaGlLqvPwsaA==
X-Received: by 2002:a37:81c2:: with SMTP id c185mr23851926qkd.446.1629762424621;
        Mon, 23 Aug 2021 16:47:04 -0700 (PDT)
Received: from localhost.localdomain (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u6sm9497903qkp.49.2021.08.23.16.47.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Aug 2021 16:47:04 -0700 (PDT)
Subject: Re: [PATCH 6/9] btrfs-progs: add the block group item in make_btrfs()
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1629486429.git.josef@toxicpanda.com>
 <d433af292d5e99ff194bc6362133e64704ecd006.1629486429.git.josef@toxicpanda.com>
 <72de3cea-aee0-a7e4-d585-bf9ea749e53b@gmx.com>
 <080b9285-9af0-0f51-4b3e-e9f357004920@toxicpanda.com>
 <f1c7b1c0-04cb-48ad-c728-5fc5429d7001@gmx.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <66c5ecee-9f4f-0980-18d2-f1053952ee99@toxicpanda.com>
Date:   Mon, 23 Aug 2021 19:47:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <f1c7b1c0-04cb-48ad-c728-5fc5429d7001@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/23/21 7:37 PM, Qu Wenruo wrote:
> 
> 
> On 2021/8/24 上午4:04, Josef Bacik wrote:
>> On 8/23/21 5:00 AM, Qu Wenruo wrote:
>>>
>>>
>>> On 2021/8/21 上午3:11, Josef Bacik wrote:
>>>> Currently we build a bare-bones file system in make_btrfs(), and 
>>>> then we
>>>> load it up and fill in the rest of the file system after the fact.  One
>>>> thing we omit in make_btrfs() is the block group item for the temporary
>>>> system chunk we allocate, because we just add it after we've opened the
>>>> file system.
>>>>
>>>> However I want to be able to generate the free space tree at
>>>> make_btrfs() time, because extent tree v2 will not have an extent tree
>>>> that has every block allocated in the system.  In order to do this I
>>>> need to make sure that the free space tree entries are added on block
>>>> group creation, which is annoying if we have to add this chunk after
>>>> I've created a free space tree.
>>>>
>>>> So make future work simpler by simply adding our block group item at
>>>> make_btrfs() time, this way I can do the right things with the free
>>>> space tree in the generic make block group code without needing a
>>>> special case for our temporary system chunk.
>>>>
>>>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>>>> ---
>>>>   mkfs/common.c | 31 +++++++++++++++++++++++++++++++
>>>>   mkfs/main.c   |  9 ++-------
>>>>   2 files changed, 33 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/mkfs/common.c b/mkfs/common.c
>>>> index 9263965e..cba97687 100644
>>>> --- a/mkfs/common.c
>>>> +++ b/mkfs/common.c
>>>> @@ -190,6 +190,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config
>>>> *cfg)
>>>>       u64 num_bytes;
>>>>       u64 system_group_offset = BTRFS_BLOCK_RESERVED_1M_FOR_SUPER;
>>>>       u64 system_group_size = BTRFS_MKFS_SYSTEM_GROUP_SIZE;
>>>> +    bool add_block_group = true;
>>>>
>>>>       if ((cfg->features & BTRFS_FEATURE_INCOMPAT_ZONED)) {
>>>>           system_group_offset = cfg->zone_size * BTRFS_NR_SB_LOG_ZONES;
>>>> @@ -283,6 +284,36 @@ int make_btrfs(int fd, struct btrfs_mkfs_config
>>>> *cfg)
>>>>           if (blk == MKFS_SUPER_BLOCK)
>>>>               continue;
>>>>
>>>> +        /* Add the block group item for our temporary chunk. */
>>>> +        if (cfg->blocks[blk] > system_group_offset &&
>>>> +            add_block_group) {
>>>
>>> This makes the block group item always be the first item.
>>>
>>> But for skinny metadata, METADATA_ITEM is smaller than BLOCK_GROUP_ITEM,
>>> meaning it should be before BLOCK_GROUP_ITEM.
>>>
>>> Won't this cause the extent tree has a bad key order?
>>>
>>
>> No because it's based on the actual bytenr.  We'll insert the extent
>> item entry first, and then move to the next block and if it's past the
>> first block we add the block group item, and then the actual extent
>> item.  So it goes
>>
>> first block X gets extent item inserted
>> X+1 > X, insert block group item
>> insert X+1 extent item.
>>
> 
> But then what if we go non-skinny metadata?
> 
> Then block group item is always before any extent item.
> 

         item 0 key (1048576 METADATA_ITEM 0) itemoff 16259 itemsize 24
                 refs 1 gen 1 flags TREE_BLOCK
                 tree block skinny level 0
         item 1 key (1048576 TREE_BLOCK_REF 1) itemoff 16259 itemsize 0
                 tree block backref
         item 2 key (1048576 BLOCK_GROUP_ITEM 4194304) itemoff 16235 
itemsize 24
                 block group used 98304 chunk_objectid 256 flags SYSTEM
         item 3 key (1064960 METADATA_ITEM 0) itemoff 16211 itemsize 24
                 refs 1 gen 1 flags TREE_BLOCK
                 tree block skinny level 0


This is what it looks like.  We're basing it off of the key.objectid. 
If the key.objectid's match, which they will, the block group will 
always be after it all.  It's doing the right thing.  Thanks,

Josef
