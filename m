Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03EB64A918E
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Feb 2022 01:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352374AbiBDAVX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Feb 2022 19:21:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240222AbiBDAVW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Feb 2022 19:21:22 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96229C061714
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Feb 2022 16:21:22 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d18so3702801plg.2
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Feb 2022 16:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mhzdxFfGRP9zowckI69ur2OcYEMAsE8RuI8y85uhum0=;
        b=QGleUz8yXSoWstWRTTwBHqDFcKzBBGj8L7LeH+R15URXHGVRrcSm+tRyvCt/rynyXk
         ETe+8X8PKL4ZU7dEdaB/mG67dOg6t5N2AFhvlBn03L/ZkPOjapAIsmuDt9UjtS+qcNJy
         mIDa0Wg71s9krJGy+4QRioAymxQ+MI3W5ziIJ0XFE4EOOVEpvyUyNYUFxIkeFXDt0CTS
         xPE5eqOQQZFaWVUjCtLKBrAiZ25a1p0A7ltmyfjOdcw1BLrEs2TU0M4yBzQ5nJUMfXZ0
         tbWH/7zSGxBJUeZlYDilsB2XvMjIGj2VG1thEWqRr6jI1mpzEoTHllMnwLlTKl/xp6/o
         yBfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mhzdxFfGRP9zowckI69ur2OcYEMAsE8RuI8y85uhum0=;
        b=juVVQc7V22QgLatnKVmGDL4+XDzh1GHsYxMbFXglTgDE+cDYN7dsCE51JzmuJ4K0sj
         p67XRmzuJEmzZ+OrgI9H5gk/69WhOKbOOMyOyy4mp0LyIbwfIJ+hFs5b2EZE/Tpj6LVG
         0wm/t8jiuPwrEEUSzchFvxAcFuDlBtaziBy4eD3pVuWUZkXR6ODyKZlzGtEALdt18vV1
         jKfyKDCexigDcGxVwoZTPrja4NR7UNBmefCekJ7GvXaOoolhWV1g5A5MJ79pkPze3zY/
         ZlJQYQF5rt47VG73vq8fAXacKTuhIlcbHmtxWNgfnB8qypT+VR/wmvgl1gfPGAua8KCL
         XxEg==
X-Gm-Message-State: AOAM533AMQZANsQEvj+8GmANRKD8mmPZUwFM8TBLDXjrFyQaUl2xys7u
        WTtz0F4XVuhxH09UNmKGc/Jj8A==
X-Google-Smtp-Source: ABdhPJzxveLOECDBW4swi/TuHlAdRUqZBarvnBszX3p3rP03mUd/rwmJ3uxMcpvqCtfLrInyyx8i4w==
X-Received: by 2002:a17:90b:1a91:: with SMTP id ng17mr247687pjb.115.1643934081938;
        Thu, 03 Feb 2022 16:21:21 -0800 (PST)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:cf6b])
        by smtp.gmail.com with ESMTPSA id 79sm162912pfv.117.2022.02.03.16.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 16:21:21 -0800 (PST)
Date:   Thu, 3 Feb 2022 16:21:20 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: get rid of warning on transaction commit when
 using flushoncommit
Message-ID: <YfxxgCEHLsHr+Cgi@relinquished.localdomain>
References: <f47e0cbbad232ab8962161622f71d8093bcc5108.1643814527.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f47e0cbbad232ab8962161622f71d8093bcc5108.1643814527.git.fdmanana@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 02, 2022 at 03:26:09PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When using the flushoncommit mount option, during almost every transaction
> commit we trigger a warning from __writeback_inodes_sb_nr():
> 
>   $ cat fs/fs-writeback.c:
>   (...)
>   static void __writeback_inodes_sb_nr(struct super_block *sb, ...
>   {
>         (...)
>         WARN_ON(!rwsem_is_locked(&sb->s_umount));
>         (...)
>   }
>   (...)
> 
> The trace produced in dmesg looks like the following:
> 
> [  947.470439] ------------[ cut here ]------------
> [  947.473890] WARNING: CPU: 5 PID: 930 at fs/fs-writeback.c:2610 __writeback_inodes_sb_nr+0x7e/0xb3
> [  947.481623] Modules linked in: nfsd nls_cp437 cifs asn1_decoder cifs_arc4 fscache cifs_md4 ipmi_ssif
> [  947.489571] CPU: 5 PID: 930 Comm: btrfs-transacti Not tainted 95.16.3-srb-asrock-00001-g36437ad63879 #186
> [  947.497969] RIP: 0010:__writeback_inodes_sb_nr+0x7e/0xb3
> [  947.502097] Code: 24 10 4c 89 44 24 18 c6 (...)
> [  947.519760] RSP: 0018:ffffc90000777e10 EFLAGS: 00010246
> [  947.523818] RAX: 0000000000000000 RBX: 0000000000963300 RCX: 0000000000000000
> [  947.529765] RDX: 0000000000000000 RSI: 000000000000fa51 RDI: ffffc90000777e50
> [  947.535740] RBP: ffff888101628a90 R08: ffff888100955800 R09: ffff888100956000
> [  947.541701] R10: 0000000000000002 R11: 0000000000000001 R12: ffff888100963488
> [  947.547645] R13: ffff888100963000 R14: ffff888112fb7200 R15: ffff888100963460
> [  947.553621] FS:  0000000000000000(0000) GS:ffff88841fd40000(0000) knlGS:0000000000000000
> [  947.560537] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  947.565122] CR2: 0000000008be50c4 CR3: 000000000220c000 CR4: 00000000001006e0
> [  947.571072] Call Trace:
> [  947.572354]  <TASK>
> [  947.573266]  btrfs_commit_transaction+0x1f1/0x998
> [  947.576785]  ? start_transaction+0x3ab/0x44e
> [  947.579867]  ? schedule_timeout+0x8a/0xdd
> [  947.582716]  transaction_kthread+0xe9/0x156
> [  947.585721]  ? btrfs_cleanup_transaction.isra.0+0x407/0x407
> [  947.590104]  kthread+0x131/0x139
> [  947.592168]  ? set_kthread_struct+0x32/0x32
> [  947.595174]  ret_from_fork+0x22/0x30
> [  947.597561]  </TASK>
> [  947.598553] ---[ end trace 644721052755541c ]---
> 
> This is because we started using writeback_inodes_sb() to flush delalloc
> when comitting a transaction (when using -o flushoncommit), in order to
> avoid deadlocks with filesystem freeze operations. This change was made
> by commit ce8ea7cc6eb313 ("btrfs: don't call btrfs_start_delalloc_roots
> in flushoncommit"). After that change we started producing that warning,
> and every now and then a user reports this since the warning happens too
> often, it spams dmesg/syslog, and a user is unsure if this reflects any
> problem that might compromise the filesystem's reliability.
> 
> We can not just lock the sb->s_umount semaphore before calling
> writeback_inodes_sb(), because that would at least deadlock with
> filesystem freezing, since at fs/super.c:freeze_super() sync_filesystem()
> is called while we are holding that semaphore in write mode, and that can
> trigger a transaction commit, resulting in a deadlock. It would also
> trigger the same type of deadlock in the unmount path. Possibly, it could
> also introduce some other locking dependencies that lockdep would report.
> 
> To fix this call try_to_writeback_inodes_sb() instead of
> writeback_inodes_sb(), because that will try to read lock sb->s_umount
> and then will only call writeback_inodes_sb() if it was able to lock it.
> This is fine because the cases where it can't read lock sb->s_umount
> are during a filesystem unmount or during a filesystem freeze - in those
> cases sb->s_umount is write locked and sync_filesystem() is called, which
> calls writeback_inodes_sb(). In other words, in all cases where we can't
> take a read lock on sb->s_umount, writeback is already being triggered
> elsewhere.

I looked for other places that down_write(&sb->s_umount), and I found
sget() -> grab_super(). grab_super() (briefly) write locks s_umount and
doesn't appear to flush anything. So in theory, if I were to mount an
already mounted filesystem at the exact time we tried to writeback the
inodes, we could skip the writeback?

Maybe I'm missing something. Even if not, this seems super unlikely and
probably better than the warning anyways...
