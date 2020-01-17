Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57712140C54
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 15:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbgAQOVb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 09:21:31 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36879 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbgAQOVb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 09:21:31 -0500
Received: by mail-qk1-f195.google.com with SMTP id 21so22834499qky.4
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 06:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bBnF1LyXJKaG6+P/v1rGtOYpj6S7+8HqHk5kIJF7Kjw=;
        b=K6a2ejtv5IR/X12/BgRms6qo/Hx4J9A6KxogPnVK9Gbf6/dCX7AXK/La/eiqd9uOLM
         ZXJ5pwBtcjqD2n63Jf9fdqHQx9rOf1IXZKlQoGniC86O1rL9LywDx2noowlFZk8enm/K
         7yxyyUwNVTDCstO1EZ9tSxG+hOWTgZiEFabTeT6JNteAkMWiqRq1EqsLiWSuEq51pnQA
         BAQZireJpCqbSJB04dprf53g1/PYJ5eRixydmqUqqyrwo84FALQpIbzdBj8a8C2TX/wm
         2nFa24JPygQUb5t0ujKfPAdVtRHHFqKx/o6sWUR8BUl0HqrbMj7GoF/txG/mHttJeQM2
         AzIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bBnF1LyXJKaG6+P/v1rGtOYpj6S7+8HqHk5kIJF7Kjw=;
        b=YdncbM9y1VevkhUY13u9UaFTPZ1Xett69uN+S/TfbyGI7wk/189W8APJ2GZY9OwNO1
         8IiT8lYPrLx8fZrIcfinLIT46LvbqaMLwzWBGEK+P6L+mY6TFcwISaUi2KsS/QBrAZIO
         Dsou7B7AcKKPzIM2ztJJkP0MaPUPNlaRmdhReGNoQfMfcZidriEzXD+WJ5xzCbAXcuxG
         Cnxe37yv8heYg3S5IzAGUpDzi1z0Z1yu5qCfMKyA6xkPO5eW9lnE2b+pfMkkv9VSmCqP
         TKlzDmhlczbTYMisUIggfD+nluJwff+sL/Sp2215y3u1/xtOoYJhmoD7F5AXYzGJ2vvB
         q/8g==
X-Gm-Message-State: APjAAAXY+MHaHIdnUwJSdFDKIYMjH/krFldK0iOs9fH+VULzcwklFNO0
        LULTzgIOjiKVzhXyAwzEUEldgRuD4Nva1w==
X-Google-Smtp-Source: APXvYqyG/92D9JyaNBH8uq59I5pC61j5cgoH8osCROUR4732f4RYC8BpoNI51fdct0ykL8cjT2j4xA==
X-Received: by 2002:a05:620a:899:: with SMTP id b25mr38644447qka.197.1579270889792;
        Fri, 17 Jan 2020 06:21:29 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id u16sm11803294qku.19.2020.01.17.06.21.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jan 2020 06:21:29 -0800 (PST)
Subject: Re: [PATCH] btrfs: add extra ending condition for indirect data
 backref resolution
To:     ethanwu <ethanwu@synology.com>
Cc:     linux-btrfs@vger.kernel.org
References: <1578044681-25562-1-git-send-email-ethanwu@synology.com>
 <017fb679-ca13-f38e-e67b-6f1d42c1fbbd@toxicpanda.com>
 <8937126609d3cca7239a9dcf3b2e78fc@synology.com>
 <aa9ce338-de50-a89a-9e94-c87fdcebe3ef@toxicpanda.com>
 <2aaca742a193154ac6cbe09859ff034e@synology.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <5e8a3602-34ee-184a-2685-737144c74795@toxicpanda.com>
Date:   Fri, 17 Jan 2020 09:21:28 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <2aaca742a193154ac6cbe09859ff034e@synology.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/17/20 5:44 AM, ethanwu wrote:
> Josef Bacik 於 2020-01-07 00:05 寫到:
>> On 1/5/20 10:45 PM, ethanwu wrote:
>>> Josef Bacik 於 2020-01-04 00:31 寫到:
>>>> On 1/3/20 4:44 AM, ethanwu wrote:
>>>>> Btrfs has two types of data backref.
>>>>> For BTRFS_EXTENT_DATA_REF_KEY type of backref, we don't have the
>>>>> exact block number. Therefore, we need to call resolve_indirect_refs
>>>>> which uses btrfs_search_slot to locate the leaf block. After that,
>>>>> we need to walk through the leafs to search for the EXTENT_DATA items
>>>>> that have disk bytenr matching the extent item(add_all_parents).
>>>>>
>>>>> The only conditions we'll stop searching are
>>>>> 1. We find different object id or type is not EXTENT_DATA
>>>>> 2. We've already got all the refs we want(total_refs)
>>>>>
>>>>> Take the following EXTENT_ITEM as example:
>>>>> item 11 key (40831553536 EXTENT_ITEM 4194304) itemoff 15460 itemsize 95
>>>>>      extent refs 24 gen 7302 flags DATA
>>>>>      extent data backref root 257 objectid 260 offset 65536 count 5 
>>>>> #backref entry 1
>>>>>      extent data backref root 258 objectid 265 offset 0 count 9 #backref 
>>>>> entry 2
>>>>>      shared data backref parent 394985472 count 10 #backref entry 3
>>>>>
>>>>> If we want to search for backref entry 1, total_refs here would be 24 rather
>>>>> than its count 5.
>>>>>
>>>>> The reason to use 24 is because some EXTENT_DATA in backref entry 3 block
>>>>> 394985472 also points to EXTENT_ITEM 40831553536, if this block also 
>>>>> belongs to
>>>>> root 257 and lies between these 5 items of backref entry 1,
>>>>> and we use total_refs = 5, we'll end up missing some refs from backref
>>>>> entry 1.
>>>>>
>>>>
>>>> This seems like the crux of the problem here.  The backref stuff is
>>>> just blindly looking for counts, without keeping track of which counts
>>>> matter.  So for full refs we should only be looking down paths where
>>>> generation > the snapshot generation.  And then for the shared refs it
>>>> should be anything that comes from that shared block.  That would be
>>>> the proper way to fix the problem, not put some arbitrary limit on how
>>>> far into the inode we can search.
>>>>
>>>
>>> I am not sure if generation could be used to skip blocks for full(indirect) 
>>> backref.
>>>
>>> For exmple:
>>> create a data extent in subvol id 257 at generation 10
>>> At generation 11, take snapshot(suppose the snapshot id is 258) from subvol 257.
>>>
>>> When we send snapshot 258, all the tree blocks it searches comes from subvol 
>>> 257,
>>> since snapshot only copy root node from its source,
>>> none of tree blocks in subvol 257 has generation(all <= 10) > snapshot 
>>> generation(11)
>>>
>>> Or do I miss something?
>>
>> Nope I was saying it wrong, sorry about that.  What I should say is
>> for "backref entry 1" we should _only_ walk down paths that belong to
>> root 257, and then for root 258 we _only_ walk down paths that belong
>> to 258, and then we do our normal dance for indirect refs.
>>
>>>
>>>> That's not to say what you are doing here is wrong, we really won't
>>>> have anything past the given extent size so we can definitely break
>>>> out earlier.  But what I worry about is say 394985472 _was_ in between
>>>> the leaves while searching down for backref entry #1, we'd end up with
>>>> duplicate entries and not catch some of the other entries.  This feels
>>>
>>> This patch doesn't adjust the total_refs. Is there any example that
>>> this patch will ruin the backref walking?
>>
>> No I'm talking about a general failure of the current code, your patch
>> doesn't make it better or worse.
>>
>>>
>>>> like we need to fix the backref logic to know if it's looking for
>>>> direct refs, and thus only go down paths with generation > snapshot
>>>> generation, or shared refs and thus only count things that directly
>>>> point to the parent block.  Thanks,
>>>>
>>>
>>> Ok, I agree, my patch doesn't solve the original problem:
>>> When resolving indirect refs, we could take entries that don't
>>> belong to the backref entry we are searching for right now.
>>>
>>> If this need to be fixed, I think it could be done by the following way
>>>
>>> item 11 key (40831553536 EXTENT_ITEM 4194304) itemoff 15460 itemsize
>>>          extent refs 24 gen 7302 flags DATA
>>>          shared data backref parent 394985472 count 10 #backref entry 1
>>>          extent data backref root 257 objectid 260 offset 1048576 count 3 
>>> #backref entry 2
>>>          extent data backref root 256 objectid 260 offset 65536 count 6 
>>> #backref entry 3
>>>          extent data backref root 257 objectid 260 offset 65536 count 5 
>>> #backref entry 4
>>>
>>> When searching for entry 4, the EXTENT_DATA entries that match the 
>>> EXTENT_ITEM bytenr
>>> will be in one of the following situations:
>>>
>>> 1. shared block that just happens to be part of root 257. For every leaf we 
>>> run into,
>>>     check its bytenr to see if it is a shared data backref entry, if so skip it.
>>>     We may need an extra list or rb tree to store this information.
>>
>> We don't need to worry about this case, because if we have a normal
>> ref then the whole path down to that bytenr belongs wholey to that
>> root.  The full backref will only be in paths that were not touched by
>> the referencing root.
>>
> 
> Thank you for the review,
> I don't fully understand the way shared data backref is used in btrfs.
> It took me a while to check the backref code and do some experiment.
> One way shared backref will be used is balance, all the items used
> by relocation tree use shared backref.
> 
> After running balance, if any EXTENT_ITEM is moved during balance,
> all the back reference of that newly-located EXTENT_ITEM will become
> shared, and the block owner is exactly the original root.
> 
> We could then produce normal reference by just COWIng the tree block,
> and leaving some of the shared backrefs unchanged,(dd an 128MB extent
> and cow every other 4K blocks, so these items span across many
> leafs and COWing one block leaves the other shared backrefs untouched)
> 
> In the end, we have two types of back reference from the same root,
> and yet the owner of all these blocks are the same root.
> 
> Therefore, I think this condition is still needed.

Yes you can definitely have a shared ref pointing back to a root that you have a 
real ref for, but my point is you treat this separately.  If you have a shared 
block you _won't_ have a real ref for the items in that leaf from the same root. 
  They should be exclusive of any real reference you have.  Thanks,

Josef
