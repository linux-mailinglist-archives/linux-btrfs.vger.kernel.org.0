Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C868E3E8CA6
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Aug 2021 10:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236270AbhHKI43 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Aug 2021 04:56:29 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:60850 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235282AbhHKI43 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Aug 2021 04:56:29 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F12C02217D;
        Wed, 11 Aug 2021 08:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1628672164; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D8BMvRAvYYoKA6ugPCWcb4+YuVENkFLlaD+SWC82cWY=;
        b=KFpU+UlW0Ew1Mu7Cqt+G0G0L4H6P3qr8317zYiGLZuiv6/D6JCyAa8pQmIVH29AdrBZ9kY
        mHs7GfgM3YYI98hz8Zg8JRQKMQaNLYVSVV8N/PXjxphKfiFu7kKXZl+M/HuSYvxqnhSYdq
        CLXg7umEJ9Vhj1L2AGuyjdNn2GIWvo0=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id BECA3136D9;
        Wed, 11 Aug 2021 08:56:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id xrAlLKSQE2HRdwAAGKfGzw
        (envelope-from <nborisov@suse.com>); Wed, 11 Aug 2021 08:56:04 +0000
Subject: Re: [PATCH] btrfs-progs: map-logical: handle corrupted fs better
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210810235445.44567-1-wqu@suse.com>
 <a9c908a2-ada5-24ab-dc01-ebd686294000@suse.com>
 <40072166-1fa6-33f0-ebad-b47e4c08b633@gmx.com>
 <26765bca-a9de-af53-2d9e-d1131de4d801@suse.com>
 <1d598b9f-830b-282f-0445-d7c2a8ba3d9d@gmx.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <b32a36a6-3ef6-012a-4a96-a30f435ddf19@suse.com>
Date:   Wed, 11 Aug 2021 11:56:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1d598b9f-830b-282f-0445-d7c2a8ba3d9d@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 11.08.21 г. 11:47, Qu Wenruo wrote:
> 
> 
> On 2021/8/11 下午3:28, Nikolay Borisov wrote:
>>
>>
>> On 11.08.21 г. 10:17, Qu Wenruo wrote:
>>>
>>>
>>> On 2021/8/11 下午3:03, Nikolay Borisov wrote:
>>>>
>>>>
>>>> On 11.08.21 г. 2:54, Qu Wenruo wrote:
>>>>> Currently if running btrfs-map-logical on a filesystem with corrupted
>>>>> extent tree, it will fail due to open_ctree() error.
>>>>>
>>>>> But the truth is, btrfs-map-logical only requires chunk tree to do
>>>>> logical bytenr mapping.
>>>>>
>>>>> Make btrfs-map-logical more robust by:
>>>>>
>>>>> - Loosen the open_ctree() requirement
>>>>>     Now it doesn't require an extent tree to work.
>>>>>
>>>>> - Don't return error for map_one_extent()
>>>>>     Function map_one_extent() is too lookup extent tree to ensure
>>>>> there is
>>>>>     at least one extent for the range we're looking for.
>>>>>
>>>>>     But since now we don't require extent tree at all, there is no
>>>>> hard
>>>>>     requirement for that function.
>>>>>     Thus here we change it to return void, and only do the check when
>>>>>     possible.
>>>>>
>>>>> Now btrfs-map-logical can work on a filesystem with corrupted extent
>>>>> tree.
>>>>>
>>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>>> ---
>>
>> <snip>
>>
>>>>
>>>>
>>>> Furthermore with map_one_extent present the semantics of the program is
>>>> that it prints the logical mapping of the real extent rather then the
>>>> passed in bytes. Because the user is allowed to pass an offset for
>>>> which
>>>> there isn't a real extent. So if we want to retain this your change
>>>> is a
>>>> no-go.
>>>
>>> The change just makes the extent item lookup an optional operation.
>>
>>
>>>
>>> If by somehow we failed to lookup the extent item, we just continue with
>>> the values passed-in, no longer to verify whether there is an extent.
>>>
>>> This is especially important for fs with corrupted extent tree.
>>>
>>>> OTOH if we want to have btrfs_map_logical to serve as a simple
>>>> calculation aid i.e you pass in some logical byte, irrespective whether
>>>> it contains a real extent or not, and have the program return what the
>>>> physical mapping is then map_one_extent becomes redundant altogether.
>>>
>>> Yeah, I was also thinking about that, but not sure if we should
>>> completely remove map_one_extent().
>>>
>>> Thus I took the middle land by rendering it optional.
>>
>> IMO the middle ground would be to add a command line switch i.e force
>> which would ignore map_one_extent. In such exceptional cases a user with
>> a problem could be instructed to run the command with an '-f' switch for
>> example. The rest of the time the program would preserve its old logic
>> which guarantees returning mapping for real extents.
> 
> But now I'm wondering, do we really need that extent check?
> 
> I mean, yes rejecting the lookup for non-existing range may be helpful,
> but it's not perfect.
> 
> For example, if we are looking up a unwritten preallocated range, we can
> pass the extent check, but still only gets garbage from the disk.

Well yes and no. We will get a garbage if we try to read directly from
the disk by using the resulting offset. OTOH we are getting valid data
for an extent that exists - preallocated extents are real extents at the
end of the day.

Again, it all boils down to what semantics we'd like to offer. But the
more I think about it, the more I'm inclined to say keep it simple, and
do a conversion from logical->physical in which case map_one_extent can
be removed as well.

> 
> So why not just let users do whatever they want?
> 
> (Well, I should ask the same questions to the older me from 5 years ago)
> 
> Thanks,
> Qu
>>
>>>
>>> But if that's the way to go, I can't be more happier as that greatly
>>> simplify the workflow of btrfs-map-logical.
>>>
>>> Thanks,
>>> Qu
>>>
>>>>
>>>> <snip>
>>>>
>>>
> 
