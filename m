Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBFDF43718F
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Oct 2021 08:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbhJVGOb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Oct 2021 02:14:31 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:43752 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbhJVGO3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Oct 2021 02:14:29 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 07D8C1FD58;
        Fri, 22 Oct 2021 06:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634883132; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eafxm8BPEk6S65MvMcllYUU9fMwgmsl0Up9kjDVeV2c=;
        b=cb2H7eDlr9gFZ4EnYdqHAjsYccxYIL92wK/vK1qF4H+gmV9f1sVj5p752iU7OiwYeTWZVD
        RlOsY/+DBgWAQX9SV01q+OiLP0IrTD+BWQpbnlfC/CsbaXtH57c1Ad7dvnnnClAF71o88N
        NkBpWgkucI2riXUtQzWW5c/B+3P4fqU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D586413A17;
        Fri, 22 Oct 2021 06:12:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YZqeMTtWcmENAwAAMHmgww
        (envelope-from <nborisov@suse.com>); Fri, 22 Oct 2021 06:12:11 +0000
Subject: Re: [PATCH] btrfs: Remove spurious unlock/lock of unused_bgs_lock
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <20211014070311.1595609-1-nborisov@suse.com>
 <20211021170410.GI20319@twin.jikos.cz>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <1802ecc2-b8d4-0982-6488-f777005b7fc7@suse.com>
Date:   Fri, 22 Oct 2021 09:12:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211021170410.GI20319@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 21.10.21 г. 20:04, David Sterba wrote:
> On Thu, Oct 14, 2021 at 10:03:11AM +0300, Nikolay Borisov wrote:
>> Since both unused block groups and reclaim bgs lists are protected by
>> unused_bgs_lock then free them in the same critical section without
>> doing an extra unlock/lock pair.
>>
>> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
>> ---
>>  fs/btrfs/block-group.c | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
>> index e790ea0798c7..308b8e92c70e 100644
>> --- a/fs/btrfs/block-group.c
>> +++ b/fs/btrfs/block-group.c
>> @@ -3873,9 +3873,7 @@ int btrfs_free_block_groups(struct btrfs_fs_info *info)
>>  		list_del_init(&block_group->bg_list);
>>  		btrfs_put_block_group(block_group);
>>  	}
>> -	spin_unlock(&info->unused_bgs_lock);
>>  
>> -	spin_lock(&info->unused_bgs_lock);
> 
> That looks correct, I'm not sure about one thing. The calls to
> btrfs_put_block_group can be potentaily taking some time if the last
> reference is dropped and we need to call btrfs_discard_cancel_work and
> several kfree()s. Indirectly there's eg. cancel_delayed_work_sync and
> btrfs_discard_schedule_work, so calling all that under unused_bgs_lock
> seems quite heavy.

btrfs_free_block_groups is called from 2 contexts only:

1. If we error out during mount
2. One of the last things we do during unmount, when all worker threads
are stopped.

IMO doing the cond_resched_lock would be a premature optimisation and
I'd aim for simplicity.

> 
> OTOH, this is in btrfs_free_block_groups so it's called at the end of
> mount so we don't care about performance. There could be a problem with
> a lot of queued work and doing that in one locking section can cause
> warnings or other stalls.
> 
> That the lock is unlocked and locked at least inserts one opportunity to
> schedule. Alternatively to be totally scheduler friendly, the loops
> could follow pattern
> 
> 
> 	spin_lock(lock);
> 	while (!list_empty()) {
> 		entry = list_first();
> 
> 		list_del_init(entry);
> 		btrfs_put_block_group(entry->bg);
> 		cond_resched_lock(lock);
> 	}
> 	spin_unlock(lock);
> 
> So with the cond_resched_lock inside the whole lock scope can be done as
> you suggest.
> 
