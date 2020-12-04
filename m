Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF392CE8B1
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Dec 2020 08:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbgLDHiG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Dec 2020 02:38:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:54748 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726826AbgLDHiF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 4 Dec 2020 02:38:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1607067439; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=w1nQpmy8XSie1PfOJlfD/7DbLuzLx6ty091XzBLoBYQ=;
        b=SI7jgw9PxGkvkmU7MX3ASFjiUVI+9KYo0Mj60mw7O8rt14siX9c0epGYCX9wjuZv3u19dL
        pAmKGwWe0ZIrlp9f7/Qh8ADitKDZmJvlkEr13UcwQTXJ0NNeTBCVRx3gkoMT91KvmMFUPi
        fUtZloSFwiRDcZ/NeIhShKIVCdKuI8A=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F2D89ABE9;
        Fri,  4 Dec 2020 07:37:18 +0000 (UTC)
Subject: Re: [PATCH] btrfs: qgroup: don't commit transaction when we already
 hold the handle
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Filipe Manana <fdmanana@suse.com>, David Sterba <dsterba@suse.com>
References: <20201204012448.26546-2-wqu@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <4fce0773-a0ba-4c74-0134-8bc22a95d23e@suse.com>
Date:   Fri, 4 Dec 2020 09:37:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201204012448.26546-2-wqu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 4.12.20 г. 3:24 ч., Qu Wenruo wrote:
> [BUG]
> When running the following script, btrfs will trigger an ASSERT():
> 
>   #/bin/bash
>   mkfs.btrfs -f $dev
>   mount $dev $mnt
>   xfs_io -f -c "pwrite 0 1G" $mnt/file
>   sync
>   btrfs quota enable $mnt
>   btrfs quota rescan -w $mnt
> 
>   # Manually set the limit below current usage
>   btrfs qgroup limit 512M $mnt $mnt
> 
>   # Crash happens
>   touch $mnt/file
> 
> The dmesg looks like this:
> 
>   assertion failed: refcount_read(&trans->use_count) == 1, in fs/btrfs/transaction.c:2022
>   ------------[ cut here ]------------
>   kernel BUG at fs/btrfs/ctree.h:3230!
>   invalid opcode: 0000 [#1] SMP PTI
>   RIP: 0010:assertfail.constprop.0+0x18/0x1a [btrfs]
>    btrfs_commit_transaction.cold+0x11/0x5d [btrfs]
>    try_flush_qgroup+0x67/0x100 [btrfs]
>    __btrfs_qgroup_reserve_meta+0x3a/0x60 [btrfs]
>    btrfs_delayed_update_inode+0xaa/0x350 [btrfs]
>    btrfs_update_inode+0x9d/0x110 [btrfs]
>    btrfs_dirty_inode+0x5d/0xd0 [btrfs]
>    touch_atime+0xb5/0x100
>    iterate_dir+0xf1/0x1b0
>    __x64_sys_getdents64+0x78/0x110
>    do_syscall_64+0x33/0x80
>    entry_SYSCALL_64_after_hwframe+0x44/0xa9
>   RIP: 0033:0x7fb5afe588db
> 
> [CAUSE]
> In try_flush_qgroup(), we assume we don't hold a transaction handle at
> all.  This is true for data reservation and mostly true for metadata.
> Since data space reservation always happens before we start a
> transaction, and for most metadata operation we reserve space in
> start_transaction().
> 
> But there is an exception, btrfs_delayed_inode_reserve_metadata().
> It holds a transaction handle, while still trying to reserve extra
> metadata space.
> 
> When we hit EDQUOT inside btrfs_delayed_inode_reserve_metadata(), we
> will join current transaction and commit, while we still have
> transaction handle from qgroup code.
> 
> [FIX]
> Let's check current->journal before we join the transaction.
> 
> If current->journal is unset or BTRFS_SEND_TRANS_STUB, it means
> we are not holding a transaction, thus are able to join and then commit
> transaction.
> 
> If current->journal is a valid transaction handle, we avoid committing
> transaction and just end it
> 
> This is less effective than committing current transaction, as it won't
> free metadata reserved space, but we may still free some data space
> before new data writes.
> 
> Bugzilla: https://bugzilla.suse.com/show_bug.cgi?id=1178634
> Fixes: c53e9653605d ("btrfs: qgroup: try to flush qgroup space when we get -EDQUOT")
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Signed-off-by: David Sterba <dsterba@suse.com>

Wasn't this submitted already? Also are you going to turn the example
script into a fstest?
