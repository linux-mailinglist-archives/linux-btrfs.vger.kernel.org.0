Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6AB0477ECF
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Dec 2021 22:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241464AbhLPV3I (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Dec 2021 16:29:08 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:50586 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236940AbhLPV3I (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Dec 2021 16:29:08 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0FD481F37E;
        Thu, 16 Dec 2021 21:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1639690147; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1lBMZQ0G/x/C0TgV0qudzt9+EtEtjiYKW1cInX9TdXM=;
        b=BQvq8gwoukDZOBTx14L5oHv8k7J8uWg1LuEr0Y1qfrTxYUUjuNwajWS3RMsbYH56htWvnd
        GXmvpa2j2RoJpG7ZJEo+GnavOLYKAp0qDOsAMs53dQsFHhcXsC0n1arHXMxU0WKFZb+PzX
        MNjF3EWFIVAktUDcWP1nixQTVTKr2a4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C3E6F13EEE;
        Thu, 16 Dec 2021 21:29:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vFxWLKKvu2FhMgAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 16 Dec 2021 21:29:06 +0000
Subject: Re: bisected: btrfs dedupe regression in v5.11-rc1: 3078d85c9a10 vfs:
 verify source area in vfs_dedupe_file_range_one()
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
References: <20211210183456.GP17148@hungrycats.org>
 <25f4d4fd-1727-1c9f-118a-150d9c263c93@suse.com>
 <YbfTYFQVGCU0Whce@hungrycats.org>
 <fc395aed-2cbd-f6e5-d167-632c14a07188@suse.com>
 <Ybj1jVYu3MrUzVTD@hungrycats.org>
 <c6125582-a1dc-1114-8211-48437dbf4976@suse.com>
 <YbrPkZVC/MazdQdc@hungrycats.org>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <ab295d78-d250-fe8f-33a5-09cc90d5e406@suse.com>
Date:   Thu, 16 Dec 2021 23:29:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YbrPkZVC/MazdQdc@hungrycats.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 16.12.21 г. 7:33, Zygo Blaxell wrote:
> On Wed, Dec 15, 2021 at 12:25:04AM +0200, Nikolay Borisov wrote:
>> Huhz, this means there is an open transaction handle somewhere o_O. I
>> checked back the stacktraces in your original email but couldn't see
>> where that might be coming from. I.e all processes are waiting on
>> wait_current_trans and this happens _before_ the transaction handle is
>> opened, hence num_extwriters can't have been incremented by them.
>>
>> When an fs wedges, and you get again num_extwriters can you provde the
>> output of "echo w > /proc/sysrq-trigger"
> 
> Here you go...

<snip>

> 
> Again we have "3 locks held" but no list of locks.  WTF is 10883 doing?
> Well, first of all it's using 100% CPU in the kernel.  Some samples of
> kernel stacks:
> 
> 	# cat /proc/*/task/10883/stack
> 	[<0>] down_read_nested+0x32/0x140
> 	[<0>] __btrfs_tree_read_lock+0x2d/0x110
> 	[<0>] btrfs_tree_read_lock+0x10/0x20
> 	[<0>] btrfs_search_old_slot+0x627/0x8a0
> 	[<0>] btrfs_next_old_leaf+0xcb/0x340
> 	[<0>] find_parent_nodes+0xcd7/0x1c40
> 	[<0>] btrfs_find_all_leafs+0x63/0xb0
> 	[<0>] iterate_extent_inodes+0xc8/0x270
> 	[<0>] iterate_inodes_from_logical+0x9f/0xe0

That's the real culprit, in this case we are not searching the commit
root hence we've attached to the transaction. So we are doing backref
resolution which either:

a) Hits some pathological case and loops for very long time, backref
resolution is known to take a lot of time.

b) We hit a bug in backref resolution and loop forever which again
results in the transaction being kept open.

Now I wonder why you were able to bisect this to the seemingly unrelated
commit in the vfs code.

Josef any ideas how to proceed further to debug why backref resolution
takes a long time and if it's just an infinite loop?

> 	[<0>] btrfs_ioctl_logical_to_ino+0x183/0x210
> 	[<0>] btrfs_ioctl+0xa81/0x2fb0
> 	[<0>] __x64_sys_ioctl+0x91/0xc0
> 	[<0>] do_syscall_64+0x38/0x90
> 	[<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 	# cat /proc/*/task/10883/stack
> 	# cat /proc/*/task/10883/stack
> 	[<0>] __tree_mod_log_rewind+0x57/0x250
> 	# cat /proc/*/task/10883/stack
> 	[<0>] __tree_mod_log_rewind+0x57/0x250
> 	# cat /proc/*/task/10883/stack
> 	# cat /proc/*/task/10883/stack
> 	[<0>] __tree_mod_log_rewind+0x57/0x250
> 	# cat /proc/*/task/10883/stack
> 	[<0>] __tree_mod_log_rewind+0x57/0x250
> 	# cat /proc/*/task/10883/stack
> 	[<0>] __tree_mod_log_rewind+0x57/0x250
> 	# cat /proc/*/task/10883/stack
> 	[<0>] __tree_mod_log_rewind+0x57/0x250
> 	# cat /proc/*/task/10883/stack
> 	# cat /proc/*/task/10883/stack
> 	[<0>] __tree_mod_log_rewind+0x57/0x250
> 	# cat /proc/*/task/10883/stack
> 	# cat /proc/*/task/10883/stack
> 	[<0>] __tree_mod_log_rewind+0x57/0x250
> 	# cat /proc/*/task/10883/stack
> 	[<0>] __tree_mod_log_rewind+0x57/0x250
> 	# cat /proc/*/task/10883/stack
> 	# cat /proc/*/task/10883/stack
> 	# cat /proc/*/task/10883/stack
> 	[<0>] free_extent_buffer.part.0+0x51/0xa0
> 	# cat /proc/*/task/10883/stack
> 	[<0>] find_held_lock+0x38/0x90
> 	[<0>] kmem_cache_alloc+0x22d/0x360
> 	[<0>] __alloc_extent_buffer+0x2a/0xa0
> 	[<0>] btrfs_clone_extent_buffer+0x42/0x130
> 	[<0>] btrfs_search_old_slot+0x660/0x8a0
> 	[<0>] btrfs_next_old_leaf+0xcb/0x340
> 	[<0>] find_parent_nodes+0xcd7/0x1c40
> 	[<0>] btrfs_find_all_leafs+0x63/0xb0
> 	[<0>] iterate_extent_inodes+0xc8/0x270
> 	[<0>] iterate_inodes_from_logical+0x9f/0xe0
> 	[<0>] btrfs_ioctl_logical_to_ino+0x183/0x210
> 	[<0>] btrfs_ioctl+0xa81/0x2fb0
> 	[<0>] __x64_sys_ioctl+0x91/0xc0
> 	[<0>] do_syscall_64+0x38/0x90
> 	[<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> So it looks like tree mod log is doing some infinite (or very large
> finite) looping in the LOGICAL_INO ioctl.  That ioctl holds a transaction
> open while it runs, but it's not blocked per se, so it doesn't show up
> in SysRq-W output.
> 
