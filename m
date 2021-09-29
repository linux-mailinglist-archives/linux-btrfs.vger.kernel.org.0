Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A96241C81C
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Sep 2021 17:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345083AbhI2PSR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Sep 2021 11:18:17 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:43040 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345079AbhI2PSK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Sep 2021 11:18:10 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EDF2422423;
        Wed, 29 Sep 2021 15:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1632928587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5QgLAobB0HH0Ultm/Xb5OY4iEQkcmuzUTBX04qUkKaI=;
        b=kv16oyxKSLzfrbz2encb4QdxYFbJXq31GlltQ/2zm2Y5M0bpW0HEDXDmhDpAG2zrlaPB72
        q8R4o2XF4k11rItzXGgSlumfR7rTzNVZnHbd08arSt5uy4wVOwEczNzYDWApU0eNQgUCKq
        e8woUizNW+ecLQDuSWZHFWexinz5S90=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B0DFF13FE7;
        Wed, 29 Sep 2021 15:16:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EGiCKEuDVGHkEAAAMHmgww
        (envelope-from <nborisov@suse.com>); Wed, 29 Sep 2021 15:16:27 +0000
Subject: Re: [PATCH] btrfs: index free space entries on size
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <449df997c354fb9d074bf5f7d32bffc082386c4f.1632750544.git.josef@toxicpanda.com>
 <ca935b82-0d4b-8bef-e1c2-4b541dcbf3d4@suse.com>
 <a3d86848-ffad-4037-8cb9-33023f3bc15d@toxicpanda.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <8778ed3a-5f59-418b-94e6-7e37b73c04a5@suse.com>
Date:   Wed, 29 Sep 2021 18:16:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <a3d86848-ffad-4037-8cb9-33023f3bc15d@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 29.09.21 г. 18:12, Josef Bacik wrote:
> On 9/29/21 7:43 AM, Nikolay Borisov wrote:
>>
>>
>> On 27.09.21 г. 16:56, Josef Bacik wrote:
>>
>> <snip>
>>
>>> ---
>>>   fs/btrfs/free-space-cache.c | 79 +++++++++++++++++++++++++++++++------
>>>   fs/btrfs/free-space-cache.h |  2 +
>>>   2 files changed, 69 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
>>> index 0d26819b1cf6..d6eaf51ee597 100644
>>> --- a/fs/btrfs/free-space-cache.c
>>> +++ b/fs/btrfs/free-space-cache.c
>>> @@ -1576,6 +1576,38 @@ static int tree_insert_offset(struct rb_root
>>> *root, u64 offset,
>>>       return 0;
>>>   }
>>>   +static u64 free_space_info_bytes(struct btrfs_free_space *info)
>>> +{
>>> +    if (info->bitmap && info->max_extent_size)
>>> +        return info->max_extent_size;
>>> +    return info->bytes;
>>> +}

>>> +
<snip>

>> 1. First you get the largest free space (in case we are using
>> use_bytes_index). So say we want 5k and the largest index is 5m we are
>> going to return 5m by doing rb_first_cached.
>>
>> 2. The for() loop then likely terminates on the first iteration because
>> the largest extent is already too large. However I think this function
>> should be refactored, because the "indexed by size" case really works in
>> O(1) complexity. You take the largest available space via
>> rb_first_cached, then perform all the alignments checks in the body of
>> the loop and return the chunk if it satisfies them or execute the newly
>> added break.
>>
>> This insight is really lost within the surrounding code, majority of
>> which exists for the "indexed by offset" case.
>>
> 
> Actually the bulk of this loop deals with alignment and bitmap entry
> handling. In the normal case we are very likely to just get an extent
> that's more than large enough and we can carry on, however if the
> "largest" extent is a bitmap extent then we need to do the bitmap search
> lower down.  And then there are also the alignment checks.  We may need
> to walk a few entries in the space indexed tree before we get one that
> actually works, even if it's rare.
> 
> But I agree it's slightly subtle, I'll add a comment here and one for
> the insert function to indicate how the tree works.  Thanks,

Can't the body of the loop be factored out in a separate function that's
called in the loop and also able to be called from outside the loop -
for the fast case when we get the largest extent?

> 
> Josef
> 
