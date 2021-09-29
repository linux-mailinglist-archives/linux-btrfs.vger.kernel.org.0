Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF8741C812
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Sep 2021 17:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345099AbhI2POd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Sep 2021 11:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345109AbhI2POZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Sep 2021 11:14:25 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560F5C06176C
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Sep 2021 08:12:43 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id m26so2622732qtn.1
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Sep 2021 08:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=3KJAb/aIswEjCqjp7WhqXDReErZVo7etoq74P4XMLgo=;
        b=L+Pz6S//Fqo3055dWzmUdg2/YCUBbCfhM6lMlNP0Q7zPoeowPLIw4sCQQnpEAfJv8Y
         CepTmwKCynZTzeFDsskZTlUXx8a4DJJKikBx3uuBGyzALhj+Tnt3y7M325Uuov7k8FeH
         WPQucQvjHlCUeuwAfEXK52JVy+aiPIhjQTn59ffjmZuHLRWbFtV2UhUDQnlaeZVUmhMo
         Z7fpR4g0aV1fQjysHxy5IQe9u6KKbUrZKFgVD1GxVqo9ld2P7stdQymk7uWYEnlwDcmH
         6yWonxraeFZJxB33vRpN8jQoDdTuZCbmhVuPsxsLc1CUU+YunJPMhzZ5aYEufwnQmd6f
         esUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3KJAb/aIswEjCqjp7WhqXDReErZVo7etoq74P4XMLgo=;
        b=5bhY4lUw3uut+9Ij1/qUF++E6kJtm4YRTaaf0A2F7SgdVZZxLZdkUJ4cz/vsR1pXJU
         v23dZJfR4AuiDX/Um0OxEAbEJuguBXpRCm/0qJQ223N7FdTwOmEIqf7PO8P9ee+fO4em
         IzQuzcsxQKj4NYx65whMTj3vpECctmpi6VygvqEY5A59EkLTyVNItoHNuaqqmS0Ns4v7
         WIDS4NhkTB4uBwwMeuh6GJdJBDqJmsKoqQ3L82X0IJjQVzVy4VM4//lHlTm1CwM3lYYz
         iRHQSj2P705aDkdwl7QubP1nSxIOElhAyJm8lWcLa4c91df5YF1m87o7p7rWMTzeQUQX
         9pcA==
X-Gm-Message-State: AOAM530nKxX7eQzFsgqG+urFod1Q7vbduFQkXiaqpINBWGXRqMlUoeTp
        yn+4GD4ZxX/mWTi9J3N4pawO2WV9fyCzPw==
X-Google-Smtp-Source: ABdhPJz1WPmM3KTUhdHeS281Nd75RRHefxhUefmzQmTLWpez/eCCPavcB5T/GbtcKbdmca89JX3tbA==
X-Received: by 2002:ac8:4c99:: with SMTP id j25mr407769qtv.191.1632928361655;
        Wed, 29 Sep 2021 08:12:41 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id a17sm52883qtn.86.2021.09.29.08.12.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Sep 2021 08:12:40 -0700 (PDT)
Subject: Re: [PATCH] btrfs: index free space entries on size
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <449df997c354fb9d074bf5f7d32bffc082386c4f.1632750544.git.josef@toxicpanda.com>
 <ca935b82-0d4b-8bef-e1c2-4b541dcbf3d4@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <a3d86848-ffad-4037-8cb9-33023f3bc15d@toxicpanda.com>
Date:   Wed, 29 Sep 2021 11:12:39 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <ca935b82-0d4b-8bef-e1c2-4b541dcbf3d4@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/29/21 7:43 AM, Nikolay Borisov wrote:
> 
> 
> On 27.09.21 г. 16:56, Josef Bacik wrote:
> 
> <snip>
> 
>> ---
>>   fs/btrfs/free-space-cache.c | 79 +++++++++++++++++++++++++++++++------
>>   fs/btrfs/free-space-cache.h |  2 +
>>   2 files changed, 69 insertions(+), 12 deletions(-)
>>
>> diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
>> index 0d26819b1cf6..d6eaf51ee597 100644
>> --- a/fs/btrfs/free-space-cache.c
>> +++ b/fs/btrfs/free-space-cache.c
>> @@ -1576,6 +1576,38 @@ static int tree_insert_offset(struct rb_root *root, u64 offset,
>>   	return 0;
>>   }
>>   
>> +static u64 free_space_info_bytes(struct btrfs_free_space *info)
>> +{
>> +	if (info->bitmap && info->max_extent_size)
>> +		return info->max_extent_size;
>> +	return info->bytes;
>> +}
>> +
>> +static void tree_insert_bytes(struct btrfs_free_space_ctl *ctl,
>> +			      struct btrfs_free_space *info)
>> +{
>> +	struct rb_root_cached *root = &ctl->free_space_bytes;
>> +	struct rb_node **p = &root->rb_root.rb_node;
>> +	struct rb_node *parent_node = NULL;
>> +	struct btrfs_free_space *tmp;
>> +	bool leftmost = true;
>> +
>> +	while (*p) {
>> +		parent_node = *p;
>> +		tmp = rb_entry(parent_node, struct btrfs_free_space,
>> +			       bytes_index);
>> +		if (free_space_info_bytes(info) < free_space_info_bytes(tmp)) {
>> +			p = &(*p)->rb_right;
>> +			leftmost = false;
> 
> According to this the leftmost node is the largest available extent?
> This is slightly counter intuitive, as general it's regarded that the
> nodes left of the current one are smaller than it, whilst this
> completely turns the concept upside down. I assume that's due to the
> "cached" version of the rb tree and wanting to utilize the cached node
> to hold the largest one. Perhaps a slight comment to sharpen attention
> to future readers might be beneficial.
> 
>> +		} else {
>> +			p = &(*p)->rb_left;
>> +		}
>> +	}
>> +
>> +	rb_link_node(&info->bytes_index, parent_node, p);
>> +	rb_insert_color_cached(&info->bytes_index, root, leftmost);
>> +}
>> +
>>   /*
>>    * searches the tree for the given offset.
>>    *
>> @@ -1704,6 +1736,7 @@ __unlink_free_space(struct btrfs_free_space_ctl *ctl,
>>   		    struct btrfs_free_space *info)
>>   {
>>   	rb_erase(&info->offset_index, &ctl->free_space_offset);
>> +	rb_erase_cached(&info->bytes_index, &ctl->free_space_bytes);
>>   	ctl->free_extents--;
>>   
>>   	if (!info->bitmap && !btrfs_free_space_trimmed(info)) {
>> @@ -1730,6 +1763,8 @@ static int link_free_space(struct btrfs_free_space_ctl *ctl,
>>   	if (ret)
>>   		return ret;
>>   
>> +	tree_insert_bytes(ctl, info);
>> +
>>   	if (!info->bitmap && !btrfs_free_space_trimmed(info)) {
>>   		ctl->discardable_extents[BTRFS_STAT_CURR]++;
>>   		ctl->discardable_bytes[BTRFS_STAT_CURR] += info->bytes;
>> @@ -1876,7 +1911,7 @@ static inline u64 get_max_extent_size(struct btrfs_free_space *entry)
>>   /* Cache the size of the max extent in bytes */
>>   static struct btrfs_free_space *
>>   find_free_space(struct btrfs_free_space_ctl *ctl, u64 *offset, u64 *bytes,
>> -		unsigned long align, u64 *max_extent_size)
>> +		unsigned long align, u64 *max_extent_size, bool use_bytes_index)
>>   {
>>   	struct btrfs_free_space *entry;
>>   	struct rb_node *node;
>> @@ -1887,15 +1922,28 @@ find_free_space(struct btrfs_free_space_ctl *ctl, u64 *offset, u64 *bytes,
>>   	if (!ctl->free_space_offset.rb_node)
>>   		goto out;
>>   
>> -	entry = tree_search_offset(ctl, offset_to_bitmap(ctl, *offset), 0, 1);
>> -	if (!entry)
>> -		goto out;
>> +	if (use_bytes_index) {
>> +		node = rb_first_cached(&ctl->free_space_bytes);
>> +	} else {
>> +		entry = tree_search_offset(ctl, offset_to_bitmap(ctl, *offset),
>> +					   0, 1);
>> +		if (!entry)
>> +			goto out;
>> +		node = &entry->offset_index;
>> +	}
>>   
>> -	for (node = &entry->offset_index; node; node = rb_next(node)) {
>> -		entry = rb_entry(node, struct btrfs_free_space, offset_index);
>> +	for (; node; node = rb_next(node)) {
>> +		if (use_bytes_index)
>> +			entry = rb_entry(node, struct btrfs_free_space,
>> +					 bytes_index);
>> +		else
>> +			entry = rb_entry(node, struct btrfs_free_space,
>> +					 offset_index);
>>   		if (entry->bytes < *bytes) {
>>   			*max_extent_size = max(get_max_extent_size(entry),
>>   					       *max_extent_size);
>> +			if (use_bytes_index)
>> +				break;
>>   			continue;
>>   		}
> 
> This hunk is somewhat subtle, because:
> 
> 1. First you get the largest free space (in case we are using
> use_bytes_index). So say we want 5k and the largest index is 5m we are
> going to return 5m by doing rb_first_cached.
> 
> 2. The for() loop then likely terminates on the first iteration because
> the largest extent is already too large. However I think this function
> should be refactored, because the "indexed by size" case really works in
> O(1) complexity. You take the largest available space via
> rb_first_cached, then perform all the alignments checks in the body of
> the loop and return the chunk if it satisfies them or execute the newly
> added break.
> 
> This insight is really lost within the surrounding code, majority of
> which exists for the "indexed by offset" case.
> 

Actually the bulk of this loop deals with alignment and bitmap entry handling. 
In the normal case we are very likely to just get an extent that's more than 
large enough and we can carry on, however if the "largest" extent is a bitmap 
extent then we need to do the bitmap search lower down.  And then there are also 
the alignment checks.  We may need to walk a few entries in the space indexed 
tree before we get one that actually works, even if it's rare.

But I agree it's slightly subtle, I'll add a comment here and one for the insert 
function to indicate how the tree works.  Thanks,

Josef

