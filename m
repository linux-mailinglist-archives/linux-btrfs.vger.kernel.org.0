Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1C952D0C5
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 May 2022 12:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236154AbiESKpG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 May 2022 06:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbiESKpE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 May 2022 06:45:04 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567FEAEE36
        for <linux-btrfs@vger.kernel.org>; Thu, 19 May 2022 03:45:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EDA841F86B;
        Thu, 19 May 2022 10:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652957100; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bx7Zr/gpbg5KUrkUxXEvokUjPSYrsK5cxCGJcu4xfss=;
        b=So9eOiXfTGucQ9nOW3Zqqj2kPjNJ36rPVvcOz0bhZwQy0soMdbG9pXPTLB+qIX2zyQqqpm
        YV407BPNwQZWOdum/jZ4RXIlgCx2cSoRn6lqCmfKnvnDzoOYVbbqQ+Bdve0rfcBEoelXxp
        YKRcVSztp62TJw05RCLRf9OuSdemwj4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8D47613AF8;
        Thu, 19 May 2022 10:45:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Ds3hH6wfhmLVVAAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 19 May 2022 10:45:00 +0000
Message-ID: <da8e2614-e365-da00-dad5-1d4cf62b1e20@suse.com>
Date:   Thu, 19 May 2022 13:45:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 12/15] btrfs: add new read repair infrastructure
Content-Language: en-US
To:     Qu Wenruo <wqu@suse.com>, Christoph Hellwig <hch@lst.de>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20220517145039.3202184-1-hch@lst.de>
 <20220517145039.3202184-13-hch@lst.de>
 <e2c4e54c-548b-2221-3bf7-31f6c14a03ee@gmx.com>
 <20220519093641.GA32623@lst.de>
 <d99b2ba3-23d2-0ea1-9aa4-13a898e77ab6@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <d99b2ba3-23d2-0ea1-9aa4-13a898e77ab6@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 19.05.22 г. 13:41 ч., Qu Wenruo wrote:
> 
> 
> On 2022/5/19 17:36, Christoph Hellwig wrote:
>> On Wed, May 18, 2022 at 07:04:22AM +0800, Qu Wenruo wrote:
>>> Function btrfs_repair_read_bio() will only return true if all of its
>>> data matches csum.
>>>
>>> Consider the following case:
>>>
>>> Profile RAID1C3, 2 sectors to read, the initial mirror is 1.
>>>
>>> Mirror 1:    |X|X|
>>> Mirror 2:    |X| |
>>> Mirror 3:    | |X|
>>>
>>> Now we will got -EIO, but in reality, we can repair the read by using
>>> the first sector from mirror 3 and the 2nd sector from mirror 2.
>>
>> I tried to write a test case for this by copying btrfs/140 and then
>> as a first step extending it to three mirrors unsing the raid1c1
>> profile.  But it seems that the tricks used there don't work,
>> as the code in btrfs/140 relies on the fact that the btrfs logic
>> address repored by file frag is reported by dump-tree as the item
>> "index" ĭn this line:
>>
>> item 4 key (FIRST_CHUNK_TREE CHUNK_ITEM 137756672) itemoff 15751 itemsiz
>>
>> but for the raid1c3 profile that line reports something entirely
>> different.
>>
>> for raid1:
>>
>> logical: 137756672
>> item 4 key (FIRST_CHUNK_TREE CHUNK_ITEM 137756672) itemoff 15751 
>> itemsize 112
>>
>> for raid1c3:
>>
>> logical: 343998464
>> item 5 key (FIRST_CHUNK_TREE CHUNK_ITEM 298844160) itemoff 15621 
>> itemsize 144
>>
>> any idea how to find physical sectors to corrupt for raid1c1?
>>
> 
> I also recently hit weird cases why extent allocator no longer puts the 
> first data extent at the beginning of a chunk.
> 
> So in that case, the best solution is to use "btrfs-map-logical -l 
> 343998464", which will directly return the physical offset of the wanted 
> logical on each involved devices.

Any reason why this is kept as a separate tool and not simply integrated 
into btrfs-progs as a separate command?

> 
> Although we need to note:
> 
> - btrfs-map-logical may not always be shipped in progs in the future
>    This tool really looks like a debug tool. I'm not sure if we will keep
>    shipping it (personally I really hope to)
> 
> - btrfs-map-logical only return data stripes
>    Thus it doesn't work for RAID56 just in case you want to use it.
> 
> Despite the weird extent logical bytenr, everything should be fine with 
> btrfs-map-logical.
> 
> I'll take some time looking into the weird behavior change.
> 
> Thanks,
> Qu
> 
