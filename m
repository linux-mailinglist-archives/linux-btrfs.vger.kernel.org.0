Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94F373F51A9
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Aug 2021 22:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbhHWUEr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Aug 2021 16:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbhHWUEq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Aug 2021 16:04:46 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24BFC061575
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Aug 2021 13:04:02 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id e15so14877459qtx.1
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Aug 2021 13:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=eFeDEIVCoYJCIPTPpjOq2G8iKvZZTpC54FPJmVTny+U=;
        b=a8h7jN0bkcoy8APpyuOuONg4RKUZGi677hL2Rmpem8tEX0xwBWNwg2eWZsQlwMkr3b
         JFRTEVDXZkLQKFbRWxNgUAaJx/Cq8yWJ1wULR+8Md5YF9TLcxKG0z0IyflyDF7vNCWL3
         vB+oGk8p5nfvzwFCV8EJ1sMD0S0pynl1HjBbkWb0nBOJE0Nz3TF/rRSvcVFKCXF0hgzT
         viKsfgScaHNEEYIz7O6R4j0L5OH7dvJAO/FftciAs1l7I8lWM/UZCO1lASy23iFu3m5I
         O2yxtfgEueFgSGYQMSYP8Ecar7WvI13FTl1Nqqs+5Uhq5TnPHrsoMvDLjUENu/QDFWah
         8I0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eFeDEIVCoYJCIPTPpjOq2G8iKvZZTpC54FPJmVTny+U=;
        b=I8aLBPHl325R63F9EPouXopqL8ssGa/Vo9l7clNNZAy+rxfcHVF8g38Oeaq/9I2OWj
         3om3ThSmnWK8gBGR9v7sIUK/wACduw7AYj3fuXZHst/KzKXRc5b5I9mrHABaahmxlByr
         q0Kli6yvaClHJBpxnL+4NHbUKN71Y5UDyu4y//nOj9lAdkEarnI/aS2P4SCcfwS2C14s
         RHPnZ/EldgmCBTecHbXb/bRjBNWBJxAcCU5hm/3cRsO8o2xN8LAMFi+K6wBycukFRZqE
         8XiOvGfL/sVggE8KqnLseM8iEpqYZmWExxO5l3b3mhKAGQVtZQmE0EdTg93fSWBXVX1J
         emTw==
X-Gm-Message-State: AOAM530ivIB7KR8PYW4zaHa9QygpHvthEMJMEIf1sJgJJdKVwYBR0Ydo
        ZtNfnQmufWzkeNZVTpcWD9xQjg==
X-Google-Smtp-Source: ABdhPJzkaT/ugYd7ytFWVwOcOfLfcQB/1xX/L8gxe4DuC75Y7ZoJe/LEXjRZZarCuDW4Bl7JfxenUA==
X-Received: by 2002:a05:622a:138c:: with SMTP id o12mr31073689qtk.315.1629749041879;
        Mon, 23 Aug 2021 13:04:01 -0700 (PDT)
Received: from localhost.localdomain (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id c20sm9027996qkk.121.2021.08.23.13.04.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Aug 2021 13:04:01 -0700 (PDT)
Subject: Re: [PATCH 6/9] btrfs-progs: add the block group item in make_btrfs()
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1629486429.git.josef@toxicpanda.com>
 <d433af292d5e99ff194bc6362133e64704ecd006.1629486429.git.josef@toxicpanda.com>
 <72de3cea-aee0-a7e4-d585-bf9ea749e53b@gmx.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <080b9285-9af0-0f51-4b3e-e9f357004920@toxicpanda.com>
Date:   Mon, 23 Aug 2021 16:04:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <72de3cea-aee0-a7e4-d585-bf9ea749e53b@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/23/21 5:00 AM, Qu Wenruo wrote:
> 
> 
> On 2021/8/21 上午3:11, Josef Bacik wrote:
>> Currently we build a bare-bones file system in make_btrfs(), and then we
>> load it up and fill in the rest of the file system after the fact.  One
>> thing we omit in make_btrfs() is the block group item for the temporary
>> system chunk we allocate, because we just add it after we've opened the
>> file system.
>>
>> However I want to be able to generate the free space tree at
>> make_btrfs() time, because extent tree v2 will not have an extent tree
>> that has every block allocated in the system.  In order to do this I
>> need to make sure that the free space tree entries are added on block
>> group creation, which is annoying if we have to add this chunk after
>> I've created a free space tree.
>>
>> So make future work simpler by simply adding our block group item at
>> make_btrfs() time, this way I can do the right things with the free
>> space tree in the generic make block group code without needing a
>> special case for our temporary system chunk.
>>
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>> ---
>>   mkfs/common.c | 31 +++++++++++++++++++++++++++++++
>>   mkfs/main.c   |  9 ++-------
>>   2 files changed, 33 insertions(+), 7 deletions(-)
>>
>> diff --git a/mkfs/common.c b/mkfs/common.c
>> index 9263965e..cba97687 100644
>> --- a/mkfs/common.c
>> +++ b/mkfs/common.c
>> @@ -190,6 +190,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
>>       u64 num_bytes;
>>       u64 system_group_offset = BTRFS_BLOCK_RESERVED_1M_FOR_SUPER;
>>       u64 system_group_size = BTRFS_MKFS_SYSTEM_GROUP_SIZE;
>> +    bool add_block_group = true;
>>
>>       if ((cfg->features & BTRFS_FEATURE_INCOMPAT_ZONED)) {
>>           system_group_offset = cfg->zone_size * BTRFS_NR_SB_LOG_ZONES;
>> @@ -283,6 +284,36 @@ int make_btrfs(int fd, struct btrfs_mkfs_config 
>> *cfg)
>>           if (blk == MKFS_SUPER_BLOCK)
>>               continue;
>>
>> +        /* Add the block group item for our temporary chunk. */
>> +        if (cfg->blocks[blk] > system_group_offset &&
>> +            add_block_group) {
> 
> This makes the block group item always be the first item.
> 
> But for skinny metadata, METADATA_ITEM is smaller than BLOCK_GROUP_ITEM,
> meaning it should be before BLOCK_GROUP_ITEM.
> 
> Won't this cause the extent tree has a bad key order?
> 

No because it's based on the actual bytenr.  We'll insert the extent 
item entry first, and then move to the next block and if it's past the 
first block we add the block group item, and then the actual extent 
item.  So it goes

first block X gets extent item inserted
X+1 > X, insert block group item
insert X+1 extent item.

Thanks,

Josef
