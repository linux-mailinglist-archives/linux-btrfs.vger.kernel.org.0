Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6832941C843
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Sep 2021 17:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345206AbhI2PYX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Sep 2021 11:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345127AbhI2PYV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Sep 2021 11:24:21 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB37C06161C
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Sep 2021 08:22:40 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id p4so2672999qki.3
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Sep 2021 08:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=sRszrlCwqxJ4iE1xvaEQ4h4DrM0PGEuXUQamkYckiXU=;
        b=adnx/pjjw2mC2ltWTYoHVvQhk4OqP9NBaw7+yxthskwIdXukyjk591fanlNYf1/t61
         bveiex7xLJP1/pEO2kFJObO5v/J+D6JhMI0fTcvvUYNI57IvjNs+nQv0bGsaGhoF9ww8
         +qYO8vqH7VrINZ1dDzeh/PAPph3twNkKw71ABCU1MOhFGsFf6WJvKtuxC768W/ZmzwNl
         4MgksXeM7BZ940JKVIlPaA+Owz/tkLq7dtJy64LJs69wV7ea9JJ/ycpdahzDqLnf34be
         LcpfShpDbV7cwKguFYz0PsxBkC3YDqLD2ECJdDp7eFAHARb65qvBytSHIaRESCEoEXhF
         bVqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sRszrlCwqxJ4iE1xvaEQ4h4DrM0PGEuXUQamkYckiXU=;
        b=QGokCIHvm4ShFQUzjmKieLVOI3Nacnny5R2qpKeeq5tRhV8KTOs11tkq2mjhz78b+J
         nTH1sqoa0i21n326yTAcNqROctEGLL2XYqLRI8ZX0DFttu8lShS1oXufQNa2Fgu+DaJH
         Mx3mMQwYTG2e61LBWV0vPBgrgGf2dM4kyFz3UCvW8XImrGktmjZUhKu6+zZj/zUJ5KBf
         QpiLQ+4EFJJYHd6Tldi2JW/HPFf7FNq4UTEzoL/gCS3250+7UQGs/MlsY2d6N0LGLfNn
         jpH5plAMlqQNyvCCXPyS6ro+TPO7AIg9j0G4lcnWut1rmv9g9JeTP6kya978YAFfiVqR
         wqCQ==
X-Gm-Message-State: AOAM533eM0HhVAB6DKa1JqWvVwaegIg7Xvo1ajgkldfbINzy/kj2NrME
        dvXgiZw/r+S3Gid28r/remg+Yw==
X-Google-Smtp-Source: ABdhPJwBSza4xG60c1ONyJ90yXmaN074GnlwvHUuXGIDrVRQ5gg1Fmi/Vr9k8KaF6eM+MEik701hdg==
X-Received: by 2002:a37:a548:: with SMTP id o69mr320317qke.9.1632928959269;
        Wed, 29 Sep 2021 08:22:39 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 139sm84840qkj.44.2021.09.29.08.22.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Sep 2021 08:22:38 -0700 (PDT)
Subject: Re: [PATCH] btrfs: index free space entries on size
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <449df997c354fb9d074bf5f7d32bffc082386c4f.1632750544.git.josef@toxicpanda.com>
 <ca935b82-0d4b-8bef-e1c2-4b541dcbf3d4@suse.com>
 <a3d86848-ffad-4037-8cb9-33023f3bc15d@toxicpanda.com>
 <8778ed3a-5f59-418b-94e6-7e37b73c04a5@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <b5799bb1-48c0-963e-569d-10a815f07062@toxicpanda.com>
Date:   Wed, 29 Sep 2021 11:22:36 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <8778ed3a-5f59-418b-94e6-7e37b73c04a5@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/29/21 11:16 AM, Nikolay Borisov wrote:
> 
> 
> On 29.09.21 г. 18:12, Josef Bacik wrote:
>> On 9/29/21 7:43 AM, Nikolay Borisov wrote:
>>>
>>>
>>> On 27.09.21 г. 16:56, Josef Bacik wrote:
>>>
>>> <snip>
>>>
>>>> ---
>>>>    fs/btrfs/free-space-cache.c | 79 +++++++++++++++++++++++++++++++------
>>>>    fs/btrfs/free-space-cache.h |  2 +
>>>>    2 files changed, 69 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
>>>> index 0d26819b1cf6..d6eaf51ee597 100644
>>>> --- a/fs/btrfs/free-space-cache.c
>>>> +++ b/fs/btrfs/free-space-cache.c
>>>> @@ -1576,6 +1576,38 @@ static int tree_insert_offset(struct rb_root
>>>> *root, u64 offset,
>>>>        return 0;
>>>>    }
>>>>    +static u64 free_space_info_bytes(struct btrfs_free_space *info)
>>>> +{
>>>> +    if (info->bitmap && info->max_extent_size)
>>>> +        return info->max_extent_size;
>>>> +    return info->bytes;
>>>> +}
> 
>>>> +
> <snip>
> 
>>> 1. First you get the largest free space (in case we are using
>>> use_bytes_index). So say we want 5k and the largest index is 5m we are
>>> going to return 5m by doing rb_first_cached.
>>>
>>> 2. The for() loop then likely terminates on the first iteration because
>>> the largest extent is already too large. However I think this function
>>> should be refactored, because the "indexed by size" case really works in
>>> O(1) complexity. You take the largest available space via
>>> rb_first_cached, then perform all the alignments checks in the body of
>>> the loop and return the chunk if it satisfies them or execute the newly
>>> added break.
>>>
>>> This insight is really lost within the surrounding code, majority of
>>> which exists for the "indexed by offset" case.
>>>
>>
>> Actually the bulk of this loop deals with alignment and bitmap entry
>> handling. In the normal case we are very likely to just get an extent
>> that's more than large enough and we can carry on, however if the
>> "largest" extent is a bitmap extent then we need to do the bitmap search
>> lower down.  And then there are also the alignment checks.  We may need
>> to walk a few entries in the space indexed tree before we get one that
>> actually works, even if it's rare.
>>
>> But I agree it's slightly subtle, I'll add a comment here and one for
>> the insert function to indicate how the tree works.  Thanks,
> 
> Can't the body of the loop be factored out in a separate function that's
> called in the loop and also able to be called from outside the loop -
> for the fast case when we get the largest extent?
> 

Sure, but we still *might* have to loop through the bytes index, so it would be 
something like

if (use_bytes_index) {
	if (special_helper_succeeds(ctl, entry, align, offset, bytes))
		return entry;
}

for (; node; node = rb_next(node));

We could conceivably have two functions, one that does the space index and the 
offset index, and then have the special helper to do the common thing, and then 
have special loops, but that's a lot of common code when all we need is a 
special case to stop searching once entry->bytes < *bytes, so I think a comment 
is a better option.  Thanks,

Josef
