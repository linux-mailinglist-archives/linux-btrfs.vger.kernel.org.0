Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A025A1315A3
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jan 2020 17:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbgAFQFe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jan 2020 11:05:34 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45523 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbgAFQFe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Jan 2020 11:05:34 -0500
Received: by mail-qt1-f196.google.com with SMTP id l12so42796517qtq.12
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Jan 2020 08:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WpbJ9loscf9isVkizweGnAlV/C0Hpl++bMsT1+u1eP4=;
        b=shMf6algGBZBWJ78j7FAFhzb6KBYH8d2gIfCOxZEFjqx1rzNbkEQizdDUaJdpa3F0c
         nkNiAOT7qULIB5naO2sFT7blhMfrw9mt98BqV9QiWFEgwgTJJTctbhv2hHfmFtfY1N5q
         ek/cW6i9I+s467L2UEE2uSKmT6FiKWsmfufZ8k/5clRk/rLkS+So2aZZwMAnrmJ3o5D1
         dqtnDjuKh8z1kskVZE5sHDTMrWybg8PsFItABQ57YdztyEJHkfDiR3yw0nw8HKSBK0S0
         Rl1W24p97utLAn1viY5jXKfl9MItSoxZ42V583aWQvIqy2vwpnRTGhnOHvkbzXq9n8sT
         rCaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WpbJ9loscf9isVkizweGnAlV/C0Hpl++bMsT1+u1eP4=;
        b=VpbZd2tmbKsnu3+QbxLbbqh4XrdKSo9Wx1zLq7UZUhochsLtT+zNjqXCISu9Fv91V3
         wqn9LDJClT0vXvhD4ivVFWwnO9eQPUyDLion1Jtv/m+v56BcnWPyUaQIlrwGDHjEmzpM
         1zHt6iNxv2ECUTQACLmYXLvhzyqAMsQoHQPhnG/rvcZ8muNVUqoI+MzZ4fepXrbIFnqt
         qc0Wk0DOiFpW0OF+0Qu3YAFQETLpsFyskwkvg9DrtSQT6MDnV88z2/FRGEl6mF/qc0nV
         h3RIbhlIgJzC41hp6zJgrexAk2J/V8LcEHVLVgHQLNtzOrnvkTcz0gg7rUfav0hN3gC2
         nfvQ==
X-Gm-Message-State: APjAAAX/PNRjCBvqAneSgOo3seO22kx6jZXENFq3tojc8qqFFySk4xBS
        vh4G3jrYxzqzgD3yEt+NfOTqD2U0tRiesA==
X-Google-Smtp-Source: APXvYqwndxkoptoOcg6gYC1c9Bo7cVklJDepCPqzYwtFzT9qorsUL+yzvlH/LNmeIjqD1O3CbjpKUg==
X-Received: by 2002:aed:376a:: with SMTP id i97mr75425676qtb.44.1578326732140;
        Mon, 06 Jan 2020 08:05:32 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::6941])
        by smtp.gmail.com with ESMTPSA id 206sm20833047qkf.132.2020.01.06.08.05.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2020 08:05:31 -0800 (PST)
Subject: Re: [PATCH] btrfs: add extra ending condition for indirect data
 backref resolution
To:     ethanwu <ethanwu@synology.com>
Cc:     linux-btrfs@vger.kernel.org
References: <1578044681-25562-1-git-send-email-ethanwu@synology.com>
 <017fb679-ca13-f38e-e67b-6f1d42c1fbbd@toxicpanda.com>
 <8937126609d3cca7239a9dcf3b2e78fc@synology.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <aa9ce338-de50-a89a-9e94-c87fdcebe3ef@toxicpanda.com>
Date:   Mon, 6 Jan 2020 11:05:30 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <8937126609d3cca7239a9dcf3b2e78fc@synology.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/5/20 10:45 PM, ethanwu wrote:
> Josef Bacik 於 2020-01-04 00:31 寫到:
>> On 1/3/20 4:44 AM, ethanwu wrote:
>>> Btrfs has two types of data backref.
>>> For BTRFS_EXTENT_DATA_REF_KEY type of backref, we don't have the
>>> exact block number. Therefore, we need to call resolve_indirect_refs
>>> which uses btrfs_search_slot to locate the leaf block. After that,
>>> we need to walk through the leafs to search for the EXTENT_DATA items
>>> that have disk bytenr matching the extent item(add_all_parents).
>>>
>>> The only conditions we'll stop searching are
>>> 1. We find different object id or type is not EXTENT_DATA
>>> 2. We've already got all the refs we want(total_refs)
>>>
>>> Take the following EXTENT_ITEM as example:
>>> item 11 key (40831553536 EXTENT_ITEM 4194304) itemoff 15460 itemsize 95
>>>      extent refs 24 gen 7302 flags DATA
>>>      extent data backref root 257 objectid 260 offset 65536 count 5 #backref 
>>> entry 1
>>>      extent data backref root 258 objectid 265 offset 0 count 9 #backref entry 2
>>>      shared data backref parent 394985472 count 10 #backref entry 3
>>>
>>> If we want to search for backref entry 1, total_refs here would be 24 rather
>>> than its count 5.
>>>
>>> The reason to use 24 is because some EXTENT_DATA in backref entry 3 block
>>> 394985472 also points to EXTENT_ITEM 40831553536, if this block also belongs to
>>> root 257 and lies between these 5 items of backref entry 1,
>>> and we use total_refs = 5, we'll end up missing some refs from backref
>>> entry 1.
>>>
>>
>> This seems like the crux of the problem here.  The backref stuff is
>> just blindly looking for counts, without keeping track of which counts
>> matter.  So for full refs we should only be looking down paths where
>> generation > the snapshot generation.  And then for the shared refs it
>> should be anything that comes from that shared block.  That would be
>> the proper way to fix the problem, not put some arbitrary limit on how
>> far into the inode we can search.
>>
> 
> I am not sure if generation could be used to skip blocks for full(indirect) 
> backref.
> 
> For exmple:
> create a data extent in subvol id 257 at generation 10
> At generation 11, take snapshot(suppose the snapshot id is 258) from subvol 257.
> 
> When we send snapshot 258, all the tree blocks it searches comes from subvol 257,
> since snapshot only copy root node from its source,
> none of tree blocks in subvol 257 has generation(all <= 10) > snapshot 
> generation(11)
> 
> Or do I miss something?

Nope I was saying it wrong, sorry about that.  What I should say is for "backref 
entry 1" we should _only_ walk down paths that belong to root 257, and then for 
root 258 we _only_ walk down paths that belong to 258, and then we do our normal 
dance for indirect refs.

> 
>> That's not to say what you are doing here is wrong, we really won't
>> have anything past the given extent size so we can definitely break
>> out earlier.  But what I worry about is say 394985472 _was_ in between
>> the leaves while searching down for backref entry #1, we'd end up with
>> duplicate entries and not catch some of the other entries.  This feels
> 
> This patch doesn't adjust the total_refs. Is there any example that
> this patch will ruin the backref walking?

No I'm talking about a general failure of the current code, your patch doesn't 
make it better or worse.

> 
>> like we need to fix the backref logic to know if it's looking for
>> direct refs, and thus only go down paths with generation > snapshot
>> generation, or shared refs and thus only count things that directly
>> point to the parent block.  Thanks,
>>
> 
> Ok, I agree, my patch doesn't solve the original problem:
> When resolving indirect refs, we could take entries that don't
> belong to the backref entry we are searching for right now.
> 
> If this need to be fixed, I think it could be done by the following way
> 
> item 11 key (40831553536 EXTENT_ITEM 4194304) itemoff 15460 itemsize
>          extent refs 24 gen 7302 flags DATA
>          shared data backref parent 394985472 count 10 #backref entry 1
>          extent data backref root 257 objectid 260 offset 1048576 count 3 
> #backref entry 2
>          extent data backref root 256 objectid 260 offset 65536 count 6 #backref 
> entry 3
>          extent data backref root 257 objectid 260 offset 65536 count 5 #backref 
> entry 4
> 
> When searching for entry 4, the EXTENT_DATA entries that match the EXTENT_ITEM 
> bytenr
> will be in one of the following situations:
> 
> 1. shared block that just happens to be part of root 257. For every leaf we run 
> into,
>     check its bytenr to see if it is a shared data backref entry, if so skip it.
>     We may need an extra list or rb tree to store this information.

We don't need to worry about this case, because if we have a normal ref then the 
whole path down to that bytenr belongs wholey to that root.  The full backref 
will only be in paths that were not touched by the referencing root.

> 2. same subvol, inode but different offset. Right now in add_all_parents, we only
>     check if bytenr matches. Adding extra check to see if backref offset is the 
> same
>     (here backref entry 1: 65536 != entry 3: 1048576)

Yeah we definitely need to do this because clone can change the offset and point 
at the same bytenr, so we for sure want to only match on matching offsets.

> 3. This might happen if subvol 257 is a snapshot from subvol 256, check leaf 
> owner, if
>     not 257 skip it.

Yup, this is the "only walk down paths owned by the root" thing.

> 4. None of the above, it's type 4 backref entry, this is what we want, add it!
> 
> In this way, we only count entries that matter, and total_refs could be
> changed from total refs of that extent item to number of each entry.
> Then, we could break from loop as soon as possible.
> 
> Will this look better?
>

Yup this is what I want, because then we are for sure always getting exactly the 
right refs.  I would do

1) Make a path->only_this_root (or something better named) that _only_ walks 
down paths that are owned by the original root.  We use this for non-full 
backref walking (backref entry 2, 3, and 4 in the example above).  If we have a 
normal extent backref that references a real root then we know for sure if we 
walk down to that bytenr from that root the whole path will be owned by that root.

2) Match on the offset in the extent data ref.  We don't want to find unrelated 
clones, we want exactly the right match.

3) Keep track of how many refs for that backref.  For the backref entry #4 
example we'd use the above strategies and break as soon as we found 5 entries.

4) Take a good hard look at the indirect backref resolution code.  I feel like 
it's probably mostly ok, we just fix the above things for normal backref lookups 
and it'll just work, so we'll definitely only find references that come from 
that indirect backref.  But I haven't looked too closely so I could be wrong.

I think we're on the same page now, hopefully it's not too much extra work.  But 
it will be by far more robust and reliable.  Thanks,

Josef
