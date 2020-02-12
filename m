Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD0315B145
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2020 20:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbgBLTot (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Feb 2020 14:44:49 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43844 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727372AbgBLTot (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Feb 2020 14:44:49 -0500
Received: by mail-qk1-f194.google.com with SMTP id p7so3260671qkh.10
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Feb 2020 11:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1WfMKVDeX+w4widGKOWPOZRHixW+dosI7VBt7wspxfE=;
        b=uvMRKeT4yAu5s1oJHbQeEyT0YnC5fU26iAzftUfO9B5bHVRMvBojSEoUn7mKWEfTY5
         n/Zd5xauV6Py3IQASFYIdeKhy8O9TqPHLL/n579i87LGqL/ukYRMTltkZCZ93cPwh0EY
         43GnDXKQ7wh6R1CZTG82a/BFEOIz9Ix6ILhPeGUoGGSTjLrH+FU1/+74rsP44u19C0sZ
         WCiI6kwJrh+sMc0oZhWN1NdFHOJMRK0jqtgssdkKty6QJw0C8pGNwFUox4u2L+4Tia8F
         +INlfPor6a94B+uLBn6e9h7wcpLhjwu0sc/ImfnD4Iujjjs/SME9Jle3kpxNVJelwalk
         BJvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1WfMKVDeX+w4widGKOWPOZRHixW+dosI7VBt7wspxfE=;
        b=GxqG7FWoMK8CMwlYzRr5b6Uh1pvemMyhqIVRe+NLsO7bVJIlhJpSsyZK8WxquJvR9t
         e0+mWB0tsp3IY23u/X+l7qnYTCHzCzf/5ZIbxOHfca2DXmS8U2WZMtm4vmN1nll2REWy
         kdyNk15F8KVbgGQ1K4ioAlNuajjHaUbbZ7JxxQaoL6rVpAC6z/AAcyds8d3tzPTJmGPn
         ubLqlPveP/B2AAFK3QCv9mc654+9a90Q5ebi/oJVnkh+NTDqzKA11VVYOYGGvKR+Pa7t
         xqXoCnQlx/YU0kTRY2BaR3lE7OXqob98ZtM/a0oiaWjRVFk9u0lehu040x5uuKn/Q+ol
         BrRw==
X-Gm-Message-State: APjAAAVTFOlKqu6tzyVzyyx/LBYzRfCS6WM8rZfyvjElyVxKjCmpurWq
        RN/PAp1VD9nO7tu/JVfZRVbODA==
X-Google-Smtp-Source: APXvYqzoeFC6Bz9JYq6Lp28gALTTXAj0U3jBnVv5cCM1tnOdcKS5t03Wk9GZtpSh4semTXpTHvmc6g==
X-Received: by 2002:a37:ef13:: with SMTP id j19mr12362584qkk.188.1581536686116;
        Wed, 12 Feb 2020 11:44:46 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::1d9])
        by smtp.gmail.com with ESMTPSA id p92sm73379qtd.14.2020.02.12.11.44.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2020 11:44:45 -0800 (PST)
Subject: Re: [PATCH] btrfs: add a find_contiguous_extent_bit helper and use it
 for safe isize
To:     fdmanana@gmail.com
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
References: <20200212183831.78293-1-josef@toxicpanda.com>
 <CAL3q7H7vUxcghnxfyVTrG0ztHZT-=9uo7H7nwRCJUzyB25CiPQ@mail.gmail.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <7279d1d5-0b27-f319-0591-90750323c3a7@toxicpanda.com>
Date:   Wed, 12 Feb 2020 14:44:44 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAL3q7H7vUxcghnxfyVTrG0ztHZT-=9uo7H7nwRCJUzyB25CiPQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/12/20 1:44 PM, Filipe Manana wrote:
> On Wed, Feb 12, 2020 at 6:40 PM Josef Bacik <josef@toxicpanda.com> wrote:
>>
>> Filipe noticed a race where we would sometimes get the wrong answer for
>> the i_disk_size for !NO_HOLES with my patch.  That is because I expected
>> that find_first_extent_bit() would find the contiguous range, since I'm
>> only ever setting EXTENT_DIRTY.  However the way set_extent_bit() works
>> is it'll temporarily split the range, loop around and set our bits, and
>> then merge the state.  When it loops it drops the tree->lock, so there
>> is a window where we can have two adjacent states instead of one large
>> state.  Fix this by walking forward until we find a non-contiguous
>> state, and set our end_ret to the end of our logically contiguous area.
>> This fixes the problem without relying on specific behavior from
>> set_extent_bit().
>>
>> Fixes: 79ceff7f6e5d ("btrfs: introduce per-inode file extent tree")
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>> ---
>> Dave, I assume you'll want to fold this in to the referenced patch, if not let
>> me know and I'll rework the series to include this as a different patch.
>>
>>   fs/btrfs/extent-io-tree.h |  2 ++
>>   fs/btrfs/extent_io.c      | 36 ++++++++++++++++++++++++++++++++++++
>>   fs/btrfs/file-item.c      |  4 ++--
>>   3 files changed, 40 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
>> index 16fd403447eb..cc3037f9765e 100644
>> --- a/fs/btrfs/extent-io-tree.h
>> +++ b/fs/btrfs/extent-io-tree.h
>> @@ -223,6 +223,8 @@ int find_first_extent_bit(struct extent_io_tree *tree, u64 start,
>>                            struct extent_state **cached_state);
>>   void find_first_clear_extent_bit(struct extent_io_tree *tree, u64 start,
>>                                   u64 *start_ret, u64 *end_ret, unsigned bits);
>> +int find_contiguous_extent_bit(struct extent_io_tree *tree, u64 start,
>> +                              u64 *start_ret, u64 *end_ret, unsigned bits);
>>   int extent_invalidatepage(struct extent_io_tree *tree,
>>                            struct page *page, unsigned long offset);
>>   bool btrfs_find_delalloc_range(struct extent_io_tree *tree, u64 *start,
>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>> index d91a48d73e8f..50bbaf1c7cf0 100644
>> --- a/fs/btrfs/extent_io.c
>> +++ b/fs/btrfs/extent_io.c
>> @@ -1578,6 +1578,42 @@ int find_first_extent_bit(struct extent_io_tree *tree, u64 start,
>>          return ret;
>>   }
>>
>> +/**
>> + * find_contiguous_extent_bit: find a contiguous area of bits
>> + * @tree - io tree to check
>> + * @start - offset to start the search from
>> + * @start_ret - the first offset we found with the bits set
>> + * @end_ret - the final contiguous range of the bits that were set
>> + *
>> + * set_extent_bit anc clear_extent_bit can temporarily split contiguous ranges
>> + * to set bits appropriately, and then merge them again.  During this time it
>> + * will drop the tree->lock, so use this helper if you want to find the actual
>> + * contiguous area for given bits.  We will search to the first bit we find, and
>> + * then walk down the tree until we find a non-contiguous area.  The area
>> + * returned will be the full contiguous area with the bits set.
>> + */
>> +int find_contiguous_extent_bit(struct extent_io_tree *tree, u64 start,
>> +                              u64 *start_ret, u64 *end_ret, unsigned bits)
>> +{
>> +       struct extent_state *state;
>> +       int ret = 1;
>> +
>> +       spin_lock(&tree->lock);
>> +       state = find_first_extent_bit_state(tree, start, bits);
>> +       if (state) {
>> +               *start_ret = state->start;
>> +               *end_ret = state->end;
>> +               while ((state = next_state(state)) != NULL) {
>> +                       if (state->start > (*end_ret + 1))
>> +                               break;
>> +                       *end_ret = state->end;
>> +               }
>> +               ret = 0;
> 
> So as long as the tree is not empty, we will always be returning 0
> (success), right?
> If we break from the while loop we should return with 1, but this
> makes us return 0.
> 

Yeah, that's the same behavior we have with find_first_extent_bit, that's why we do

if (!ret && start == 0)
	i_size = min(i_size, end + 1);
else
	i_size = 0;

Thanks,

Josef
