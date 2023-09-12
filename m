Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 835DD79D9EE
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Sep 2023 22:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjILUQo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Sep 2023 16:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjILUQn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Sep 2023 16:16:43 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79B9E4B
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Sep 2023 13:16:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5C5A62183A;
        Tue, 12 Sep 2023 20:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694549796;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=op8MN0Dcv8GDHL5p9ZOeUrFFQH/c7qbKIXPid8xqAfs=;
        b=grMYFL2FOt42v5ag7oB5LbNWGWOLmtOZ+b7Kog0Pa4OPbdd4LggY7jDdfenm5Qg/d1awmS
        wM4EgLkASLEhiLqLRPXDoyuAmA8sZLqTXeu7ZK6PucxY+Q8rGV61AKnsBL94zenc+h4skr
        IwDqYbm4fGEsAZaD4sV6o3KfTvISOhg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694549796;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=op8MN0Dcv8GDHL5p9ZOeUrFFQH/c7qbKIXPid8xqAfs=;
        b=zU3nTRW+CbqVa47//IBbiED8ze2zrBM4iwL/c+g5csdfpheHtB8PuQ/oOHU5y1JNnrw6zd
        yIy6OwduzgaqAdCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 32A96139DB;
        Tue, 12 Sep 2023 20:16:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id j3N9CyTHAGUgeAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 12 Sep 2023 20:16:36 +0000
Date:   Tue, 12 Sep 2023 22:16:34 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix race between reading a directory and adding
 entries to it
Message-ID: <20230912201634.GD20408@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <903764240e39987ca676cd02913a836b3b4930c8.1694515104.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <903764240e39987ca676cd02913a836b3b4930c8.1694515104.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 12, 2023 at 11:45:39AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When opening a directory (opendir(3)) or rewinding it (rewinddir(3)), we
> are not holding the directory's inode locked, and this can result in later
> attempting to add two entries to the directory with the same index number,
> resulting in a transaction abort, with -EEXIST (-17), when inserting the
> second delayed dir index. This results in a trace like the following:
> 
>   Sep 11 22:34:59 myhostname kernel: BTRFS error (device dm-3): err add delayed dir index item(name: cockroach-stderr.log) into the insertion tree of the delayed node(root id: 5, inode id: 4539217, errno: -17)
>   Sep 11 22:34:59 myhostname kernel: ------------[ cut here ]------------
>   Sep 11 22:34:59 myhostname kernel: kernel BUG at fs/btrfs/delayed-inode.c:1504!
>   Sep 11 22:34:59 myhostname kernel: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
>   Sep 11 22:34:59 myhostname kernel: CPU: 0 PID: 7159 Comm: cockroach Not tainted 6.4.15-200.fc38.x86_64 #1
>   Sep 11 22:34:59 myhostname kernel: Hardware name: ASUS ESC500 G3/P9D WS, BIOS 2402 06/27/2018
>   Sep 11 22:34:59 myhostname kernel: RIP: 0010:btrfs_insert_delayed_dir_index+0x1da/0x260
>   Sep 11 22:34:59 myhostname kernel: Code: eb dd 48 (...)
>   Sep 11 22:34:59 myhostname kernel: RSP: 0000:ffffa9980e0fbb28 EFLAGS: 00010282
>   Sep 11 22:34:59 myhostname kernel: RAX: 0000000000000000 RBX: ffff8b10b8f4a3c0 RCX: 0000000000000000
>   Sep 11 22:34:59 myhostname kernel: RDX: 0000000000000000 RSI: ffff8b177ec21540 RDI: ffff8b177ec21540
>   Sep 11 22:34:59 myhostname kernel: RBP: ffff8b110cf80888 R08: 0000000000000000 R09: ffffa9980e0fb938
>   Sep 11 22:34:59 myhostname kernel: R10: 0000000000000003 R11: ffffffff86146508 R12: 0000000000000014
>   Sep 11 22:34:59 myhostname kernel: R13: ffff8b1131ae5b40 R14: ffff8b10b8f4a418 R15: 00000000ffffffef
>   Sep 11 22:34:59 myhostname kernel: FS:  00007fb14a7fe6c0(0000) GS:ffff8b177ec00000(0000) knlGS:0000000000000000
>   Sep 11 22:34:59 myhostname kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   Sep 11 22:34:59 myhostname kernel: CR2: 000000c00143d000 CR3: 00000001b3b4e002 CR4: 00000000001706f0
>   Sep 11 22:34:59 myhostname kernel: Call Trace:
>   Sep 11 22:34:59 myhostname kernel:  <TASK>
>   Sep 11 22:34:59 myhostname kernel:  ? die+0x36/0x90
>   Sep 11 22:34:59 myhostname kernel:  ? do_trap+0xda/0x100
>   Sep 11 22:34:59 myhostname kernel:  ? btrfs_insert_delayed_dir_index+0x1da/0x260
>   Sep 11 22:34:59 myhostname kernel:  ? do_error_trap+0x6a/0x90
>   Sep 11 22:34:59 myhostname kernel:  ? btrfs_insert_delayed_dir_index+0x1da/0x260
>   Sep 11 22:34:59 myhostname kernel:  ? exc_invalid_op+0x50/0x70
>   Sep 11 22:34:59 myhostname kernel:  ? btrfs_insert_delayed_dir_index+0x1da/0x260
>   Sep 11 22:34:59 myhostname kernel:  ? asm_exc_invalid_op+0x1a/0x20
>   Sep 11 22:34:59 myhostname kernel:  ? btrfs_insert_delayed_dir_index+0x1da/0x260
>   Sep 11 22:34:59 myhostname kernel:  ? btrfs_insert_delayed_dir_index+0x1da/0x260
>   Sep 11 22:34:59 myhostname kernel:  btrfs_insert_dir_item+0x200/0x280
>   Sep 11 22:34:59 myhostname kernel:  btrfs_add_link+0xab/0x4f0
>   Sep 11 22:34:59 myhostname kernel:  ? ktime_get_real_ts64+0x47/0xe0
>   Sep 11 22:34:59 myhostname kernel:  btrfs_create_new_inode+0x7cd/0xa80
>   Sep 11 22:34:59 myhostname kernel:  btrfs_symlink+0x190/0x4d0
>   Sep 11 22:34:59 myhostname kernel:  ? schedule+0x5e/0xd0
>   Sep 11 22:34:59 myhostname kernel:  ? __d_lookup+0x7e/0xc0
>   Sep 11 22:34:59 myhostname kernel:  vfs_symlink+0x148/0x1e0
>   Sep 11 22:34:59 myhostname kernel:  do_symlinkat+0x130/0x140
>   Sep 11 22:34:59 myhostname kernel:  __x64_sys_symlinkat+0x3d/0x50
>   Sep 11 22:34:59 myhostname kernel:  do_syscall_64+0x5d/0x90
>   Sep 11 22:34:59 myhostname kernel:  ? syscall_exit_to_user_mode+0x2b/0x40
>   Sep 11 22:34:59 myhostname kernel:  ? do_syscall_64+0x6c/0x90
>   Sep 11 22:34:59 myhostname kernel:  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> 
> The race leading to the problem happens like this:
> 
> 1) Directory inode X is loaded into memory, its ->index_cnt field is
>    initialized to (u64)-1 (at btrfs_alloc_inode());
> 
> 2) Task A is adding a new file to directory X, holding its vfs inode lock,
>    and calls btrfs_set_inode_index() to get an index number for the entry.
> 
>    Because the inode's index_cnt field is set to (u64)-1 it calls
>    btrfs_inode_delayed_dir_index_count() which fails because no dir index
>    entries were added yet to the delayed inode and then it calls
>    btrfs_set_inode_index_count(). This functions finds the last dir index
>    key and then sets index_cnt to that index value + 1. It found that the
>    last index key has an offset of 100. However before it assigns a value
>    of 101 to index_cnt...
> 
> 3) Task B calls opendir(3), ending up at btrfs_opendir(), where the vfs
>    lock for inode X is not taken, so it calls btrfs_get_dir_last_index()
>    and sees index_cnt still with a value of (u64)-1. Because of that it
>    calls btrfs_inode_delayed_dir_index_count() which fails since no dir
>    index entries were added to the delayed inode yet, and then it also
>    calls btrfs_set_inode_index_count(). This also finds that the last
>    index key has an offset of 100, and before it assigns the value 101
>    to the index_cnt field of inode X...
> 
> 4) Task A assigns a value of 101 to index_cnt. And then the code flow
>    goes to btrfs_set_inode_index() where it increments index_cnt from
>    101 to 102. Task A then creates a delayed dir index entry with a
>    sequence number of 101 and adds it to the delayed inode;
> 
> 5) Task B assigns 101 to the index_cnt field of inode X;
> 
> 6) At some later point when someone tries to add a new entry to the
>    directory, btrfs_set_inode_index() will return 101 again and shortly
>    after an attempt to add another delayed dir index key with index
>    number 101 will fail with -EEXIST resulting in a transaction abort.
> 
> Fix this by locking the inode at btrfs_get_dir_last_index(), which is only
> only used when opening a directory or attempting to lseek on it.
> 
> Reported-by: ken <ken@bllue.org>
> Link: https://lore.kernel.org/linux-btrfs/CAE6xmH+Lp=Q=E61bU+v9eWX8gYfLvu6jLYxjxjFpo3zHVPR0EQ@mail.gmail.com/
> Reported-by: syzbot+d13490c82ad5353c779d@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/linux-btrfs/00000000000036e1290603e097e0@google.com/
> Fixes: 9b378f6ad48c ("btrfs: fix infinite directory reads")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
