Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4A044D896
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Nov 2021 15:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232823AbhKKOxk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Nov 2021 09:53:40 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:45340 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbhKKOxi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Nov 2021 09:53:38 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1466521B28;
        Thu, 11 Nov 2021 14:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1636642249; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v5vlSSahFLItGnic3NuxlTMRAldYpChRH4N0tKnfU30=;
        b=V/+Eu/sDPWPwQzPuuwpHDqu/MmkTATUpejX0ftHus7XfRPSaYiQslnvQpUE/t1J5e5O6bD
        P8O5ORlmIXq0u1W8XaExrkWSCr0CZhGEDlyCw7TZYW0eb5iZPBOmHXGjGXpW3zk8OfUp8z
        MSGUEkzXW8PTSbq0hw8TxKaKRpK96eQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CB3B313DBC;
        Thu, 11 Nov 2021 14:50:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id H/SjLsgtjWGmaAAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 11 Nov 2021 14:50:48 +0000
Subject: Re: [PATCH v3 2/7] btrfs: check for priority ticket granting before
 flushing
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1636470628.git.josef@toxicpanda.com>
 <efd7030290cfce311cea39f381b2e5cb38761336.1636470628.git.josef@toxicpanda.com>
 <f0f97d68-cf01-515b-f787-3ccb924ff9ad@suse.com>
 <YY0lETfvTPmkvhA9@localhost.localdomain>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <9efd1d38-cdcd-127e-3b44-d3c907000bfe@suse.com>
Date:   Thu, 11 Nov 2021 16:50:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YY0lETfvTPmkvhA9@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 11.11.21 г. 16:13, Josef Bacik wrote:
> On Thu, Nov 11, 2021 at 03:14:20PM +0200, Nikolay Borisov wrote:
>>
>>
>> On 9.11.21 г. 17:12, Josef Bacik wrote:
>>> Since we're dropping locks before we enter the priority flushing loops
>>> we could have had our ticket granted before we got the space_info->lock.
>>> So add this check to avoid doing some extra flushing in the priority
>>> flushing cases.
>>>
>>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>>
>> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
>>
>>> --->  fs/btrfs/space-info.c | 9 ++++++++-
>>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
>>> index 9d6048f54097..9a362f3a6df4 100644
>>> --- a/fs/btrfs/space-info.c
>>> +++ b/fs/btrfs/space-info.c
>>> @@ -1264,7 +1264,7 @@ static void priority_reclaim_metadata_space(struct btrfs_fs_info *fs_info,
>>>  
>>>  	spin_lock(&space_info->lock);
>>>  	to_reclaim = btrfs_calc_reclaim_metadata_size(fs_info, space_info);
>>> -	if (!to_reclaim) {
>>> +	if (!to_reclaim || ticket->bytes == 0) {
>>
>> nit: This is purely an optimization, handling the case where a prio
>> ticket N is being added to the list, but at the same time we might have
>> had ticket N-1 just satisfied (or failed) and having called
>> try_granting_ticket might have satisfied concurrently added ticket N,
>> right? And this is a completely independent change of the other cleanups
>> being done here?
>>
> 
> It's definitely just an optimization, but it can be less specific than this.
> Think we came in to reserve, we didn't have the space, we added our ticket to
> the list.  But at the same time somebody was waiting on the space_info lock to
> add space and do btrfs_try_granting_ticket(), so we drop the lock, get
> satisfied, come in to do our loop, and we have been satisified.
> 
> This is the priority reclaim path, so to_reclaim could be !0 still because we
> may have only satisified the priority tickets and still left non priority
> tickets on the list.  We would then have to_reclaim but ->bytes == 0.
> 
> Clearly not a huge deal, I just noticied it when I was redoing the locking for
> the cleanups and it annoyed me.  Thanks,

IMO such scenario description should be put in the changelog.

> 
> Josef
> 
