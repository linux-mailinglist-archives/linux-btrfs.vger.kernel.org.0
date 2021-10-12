Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8B1142A3B1
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Oct 2021 13:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236282AbhJLL6Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Oct 2021 07:58:16 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:48834 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbhJLL6Q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Oct 2021 07:58:16 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E6B8C2207C;
        Tue, 12 Oct 2021 11:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634039773; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TENzTWVJsjMW9ZpO8ra7Upz0sSJQHnT3YroIewM3hqk=;
        b=c4HDN2KcbQnauerklwOrUjw7+caLlOJwuyoon8w7d0SmSUlTarYgDn4Vjy2rT+aiJQYu3h
        kWtFuGr5fwazTTjjes/Im7m8KwLyEWMiXUCsoXJKLPmqA6xRHHxAKpKmM0HTmm9uMbyqlw
        RNHk4+afJe5WoiDjNLtvoLz/5n4zpqo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B5B0E13B2A;
        Tue, 12 Oct 2021 11:56:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id k+TtKd13ZWFpNAAAMHmgww
        (envelope-from <nborisov@suse.com>); Tue, 12 Oct 2021 11:56:13 +0000
Subject: Re: [PATCH] btrfs-progs: print-tree: fix chunk/block group flags
 output
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20211012021719.18496-1-wqu@suse.com>
 <b331b0a3-8119-d66e-c49e-742262ad4a9f@suse.com>
 <504c9584-e760-54a4-7ae4-1c4f26ec5323@suse.com>
 <32c39029-8434-e3f9-0d72-740fe6f44bff@gmx.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <a643cdea-5130-c44e-ce4f-dc8fa23e7481@suse.com>
Date:   Tue, 12 Oct 2021 14:56:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <32c39029-8434-e3f9-0d72-740fe6f44bff@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 12.10.21 г. 14:42, Qu Wenruo wrote:
> 
> 
> On 2021/10/12 18:38, Nikolay Borisov wrote:
>>
>>
>> On 12.10.21 г. 13:35, Nikolay Borisov wrote:
>>> <snip>
>>>
>>>>
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>> ---
>>>>   kernel-shared/print-tree.c | 47
>>>> +++++++++++++++++++++++---------------
>>>>   1 file changed, 29 insertions(+), 18 deletions(-)
>>>>
>>>> diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
>>>> index 67b654e6d2d5..39655590272e 100644
>>>> --- a/kernel-shared/print-tree.c
>>>> +++ b/kernel-shared/print-tree.c
>>>> @@ -159,40 +159,51 @@ static void print_inode_ref_item(struct
>>>> extent_buffer *eb, u32 size,
>>>>       }
>>>>   }
>>>>
>>>> -/* Caller should ensure sizeof(*ret)>=21 "DATA|METADATA|RAID10" */
>>>> +/* The minimal length for the string buffer of block group/chunk
>>>> flags */
>>>> +#define BG_FLAG_STRING_LEN    64
>>>> +
>>>>   static void bg_flags_to_str(u64 flags, char *ret)
>>>>   {
>>>>       int empty = 1;
>>>> +    char profile[BG_FLAG_STRING_LEN] = {};
>>>>       const char *name;
>>>>
>>>> +    ret[0] = '\0';
>>>>       if (flags & BTRFS_BLOCK_GROUP_DATA) {
>>>>           empty = 0;
>>>> -        strcpy(ret, "DATA");
>>>> +        strncpy(ret, "DATA", BG_FLAG_STRING_LEN);
>>>
>>> I find using strncpy rather odd, it guarantees it will copy num
>>> characters, and if source is smaller than dest, it will overwrite the
>>> rest with 0. So what happens is you are copying 4 chars here, and
>>> writing 60 zeros. Frankly I think it's better to use >>
>>> snprintf(ret, BG_FLAG_STRING_LEN, "DATA");
> 
> Well, you just told me a new fact, strncpy() would set the the rest bytes.
> 
> I thought it would just add the terminal '\0' if it's not reaching the
> size limit.
> 
> But you're right, strncpy() would reset the padding bytes to zero.

The thing is strncpy doesn't really set final NULL by definition. I.e if
source is larger than N, then dest won't be null terminated.

<snip>

> 
>>>
>>>> +            profile[i] = toupper(profile[i]);
>>>> +    }
>>>> +    if (profile[0]) {
>>
>> Actually profile[0] here is guaranteed to be nonul - it's either
>> UNKNOWN... or whatever btrfs_bg_type_to_raid_name returned. So you can
>> simply use the strncat functions without needing the if.
> 
> You forgot SINGLE type.
> 
> In that case, profile[0] can be "\0".

How does that happen? If btrfs_bg_type_to_raid_name return NULL then
prfile contains UNKNWON. OTOH if the 'else' is executed then either
profile contains "single" or whatever btrfs_bg_type_to_raid_name
returned. So profile can never be NULL. What am I missing?

<snip>
