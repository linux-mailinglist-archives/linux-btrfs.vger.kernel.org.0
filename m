Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFA1F44319C
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Nov 2021 16:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234560AbhKBP2S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Nov 2021 11:28:18 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:50524 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233007AbhKBP2J (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Nov 2021 11:28:09 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D8B701FD4C;
        Tue,  2 Nov 2021 15:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1635866732; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6GiLMiJAnzbcLthSAl63S33g7iKONODGvH3XGxM/R0o=;
        b=K7gLoMiRyUeZh7HLcZBFrqwMvxbmkkbhXcP91l+wofrlw3wOIWqbqYp06s1OFkz/gOELiT
        ZX/0NWCxoVh6I//D6I7cIGnkeW5DJFyCzI7fbnugZ94LWWLN7lmNmIeCdZQSdLy6X1dNkU
        Z6J1vXAhPA9B6P0w6IN+XrrZZeAJPVw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A5B6613D66;
        Tue,  2 Nov 2021 15:25:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2cPlJWxYgWExSgAAMHmgww
        (envelope-from <nborisov@suse.com>); Tue, 02 Nov 2021 15:25:32 +0000
Subject: Re: [PATCH 0/3] Balance vs device add fixes
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
References: <20211101115324.374076-1-nborisov@suse.com>
 <YYFLlL4NTF4L+PmE@localhost.localdomain>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <516c7eaf-3fb2-fe61-08f8-ac4201752121@suse.com>
Date:   Tue, 2 Nov 2021 17:25:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YYFLlL4NTF4L+PmE@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2.11.21 г. 16:30, Josef Bacik wrote:
> On Mon, Nov 01, 2021 at 01:53:21PM +0200, Nikolay Borisov wrote:
>> This series enables adding of a device when balance is paused (i.e an fs is mounted
>> with skip_balance options). This is needed to give users a chance to gracefully
>> handle an ENOSPC situation in the face of running balance. To achieve this introduce
>> a new exclop - BALANCE_PAUSED which is made compatible with device add. More
>> details in each patche.
>>
>> I've tested this with an fstests which I will be posting in a bit.
>>
>> Nikolay Borisov (3):
>>   btrfs: introduce BTRFS_EXCLOP_BALANCE_PAUSED exclusive state
>>   btrfs: make device add compatible with paused balance in
>>     btrfs_exclop_start_try_lock
>>   btrfs: allow device add if balance is paused
>>
>>  fs/btrfs/ctree.h   |  1 +
>>  fs/btrfs/ioctl.c   | 49 +++++++++++++++++++++++++++++++++++++++-------
>>  fs/btrfs/volumes.c | 23 ++++++++++++++++++----
>>  fs/btrfs/volumes.h |  2 +-
>>  4 files changed, 63 insertions(+), 12 deletions(-)
>>
> 
> A few things
> 
> 1) Can we integrate the flipping into helpers?  Something like
> 
> 	btrfs_exclop_change_state(PAUSED);
> 
>    So the locking and stuff is all with the code that messes with the exclop?

Right, I left the code flipping balance->paused opencoded because that's
really a special case. By all means I can add a specific helper so that
the ASSERT is not lost as well. The reason I didn't do it in the first
place is because PAUSED is really "special" in the sense it can be
entered only from BALANCE and it's not really generic. If you take a
look how btrfs_exclop_start does it for example, it simply checks we
don't have a running op and simply sets it to whatever is passed

> 
> 2) The existing helpers do WRITE_ONCE(), is that needed here?  I assume not>    because we're not actually exiting our exclop state, but still
seems wonky.

That got me thinking in the first place and actually initially I had a
patch which removed it. However, I *think* it might be required since
exclusive_operation is accessed without a lock ini the sysfs code i.e.
btrfs_exclusive_operation_show so I guess that's why we need it.

Goldwyn, what's your take on this?

> 
> 3) Maybe have an __btrfs_exclop_finish(type), so instead of 
> 
> 	if (paused) {
> 		do thing;
> 	} else {
> 		btrfs_exclop_finish();
> 	}
> 
>   you can instead do
> 
> 	type = BTRFS_EXCLOP_NONE;
> 	if (pause stuff) {
> 		do things;
> 		type = BTRFS_EXCLOP_BALANCE_PAUSED;
> 	}
> 
> 	/* other stuff. */
> 	__btrfs_exclop_finish(type);
> 
> then btrfs_exclop_finish just does __btrfs_exclop_finish(NONE);

I'm having a hard time seeing how this would increase readability. What
should go into the __btrfs_exclop_finish function?


> Thanks,
> 
> Josef
> 
