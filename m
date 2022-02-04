Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF31F4AA43F
	for <lists+linux-btrfs@lfdr.de>; Sat,  5 Feb 2022 00:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358955AbiBDXXi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Feb 2022 18:23:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343646AbiBDXXh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Feb 2022 18:23:37 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9910DFC07E6
        for <linux-btrfs@vger.kernel.org>; Fri,  4 Feb 2022 15:23:35 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id s16so6214357pgs.13
        for <linux-btrfs@vger.kernel.org>; Fri, 04 Feb 2022 15:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HVA3d7uHlEVn4xfPSytSgBdjEdpLWpdPXhmh6J1SAZ4=;
        b=JeL6PI0Nb7/W713KaVKdZdVJC+V1nKgFL28LdtQHvWt1h7mJY4l0t6d5unrsGyDf25
         uG69o+4LHsLTBxRoUvy9gFKY32SjGFbKLxQNGC0JX6398aOupyyWknYAuG1jtWt/ZINC
         ++d64nR1Ae/o78rVSzCxQVXc+UDDc4HPROC8coxUBjBBBljjrrHTo67TzKeVhBHwd+vb
         4gBDFOgzwHUGZ0pqqgx7ETppXxkOeAgOeqOU0OK1tkIyG28vSCPmjveHwvsTwJPQsVgq
         5xuMeDczV6GbGoO52V/6rG02AFFh1ITRGiBRDy5gY7zoZs7m4VxNWTdP7E0bIFm1aDg4
         ySag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HVA3d7uHlEVn4xfPSytSgBdjEdpLWpdPXhmh6J1SAZ4=;
        b=AD10QgNHtyfypwyhOsBlqdWqK0m3b6cgY/pqGTkv/vJonqG3hmSWJrjtGbdatU9Zgj
         WJM03OzVcCDRxD+50TxjyvEs1AtKXT5TxPGd++H/NM4+7KI5DAV3YSY7/7sqQepKaSkL
         j21xfZqm86K1Cdcc9KbkFgqV1oCwJCg3iNjHukUj8wNLEn3wVvL8v0uasiFd544OLtER
         zXFFgiis7bfAl3mCsCPvCSVRNmlbOxBGjTG95hjk0+AQ9kgGdz60xwkP6aLQd+T+/ann
         +Rqcf0m4t8awjPOVzACjpgmKxqBDXsWLFPL6wAjxPXkpfXecozTKqAsB9ksyv8S4s8jy
         sWIw==
X-Gm-Message-State: AOAM533FZjvuPom77gS9rpHSb77R1dLCZED6gDN3na5pmLJKuWd92jYt
        YwYckujOxF36al7YnAijbQGuWQ==
X-Google-Smtp-Source: ABdhPJwM3kUujnIjQGvHoIpStnopJanocpGnfjTY8QoZ5OYP8pDdbBLsjLxebKaTC1GUnofltz0sOg==
X-Received: by 2002:a05:6a00:23ce:: with SMTP id g14mr5335241pfc.78.1644017015179;
        Fri, 04 Feb 2022 15:23:35 -0800 (PST)
Received: from relinquished.localdomain ([2601:602:8b80:8e0::7d1e])
        by smtp.gmail.com with ESMTPSA id f22sm3798882pfj.206.2022.02.04.15.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 15:23:34 -0800 (PST)
Date:   Fri, 4 Feb 2022 15:23:34 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: get rid of warning on transaction commit when
 using flushoncommit
Message-ID: <Yf21dlU3a7DHryuK@relinquished.localdomain>
References: <f47e0cbbad232ab8962161622f71d8093bcc5108.1643814527.git.fdmanana@suse.com>
 <YfxxgCEHLsHr+Cgi@relinquished.localdomain>
 <Yf0KGz7jhgD+KfwJ@debian9.Home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yf0KGz7jhgD+KfwJ@debian9.Home>
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 04, 2022 at 11:12:27AM +0000, Filipe Manana wrote:
> On Thu, Feb 03, 2022 at 04:21:20PM -0800, Omar Sandoval wrote:
> > On Wed, Feb 02, 2022 at 03:26:09PM +0000, fdmanana@kernel.org wrote:
> > > From: Filipe Manana <fdmanana@suse.com>
> > > 
> > > When using the flushoncommit mount option, during almost every transaction
> > > commit we trigger a warning from __writeback_inodes_sb_nr():
> > > 
> > >   $ cat fs/fs-writeback.c:
> > >   (...)
> > >   static void __writeback_inodes_sb_nr(struct super_block *sb, ...
> > >   {
> > >         (...)
> > >         WARN_ON(!rwsem_is_locked(&sb->s_umount));
> > >         (...)
> > >   }
> > >   (...)
> > > 
> > > The trace produced in dmesg looks like the following:
> > > 
> > > [  947.470439] ------------[ cut here ]------------
> > > [  947.473890] WARNING: CPU: 5 PID: 930 at fs/fs-writeback.c:2610 __writeback_inodes_sb_nr+0x7e/0xb3
> > > [  947.481623] Modules linked in: nfsd nls_cp437 cifs asn1_decoder cifs_arc4 fscache cifs_md4 ipmi_ssif
> > > [  947.489571] CPU: 5 PID: 930 Comm: btrfs-transacti Not tainted 95.16.3-srb-asrock-00001-g36437ad63879 #186
> > > [  947.497969] RIP: 0010:__writeback_inodes_sb_nr+0x7e/0xb3
> > > [  947.502097] Code: 24 10 4c 89 44 24 18 c6 (...)
> > > [  947.519760] RSP: 0018:ffffc90000777e10 EFLAGS: 00010246
> > > [  947.523818] RAX: 0000000000000000 RBX: 0000000000963300 RCX: 0000000000000000
> > > [  947.529765] RDX: 0000000000000000 RSI: 000000000000fa51 RDI: ffffc90000777e50
> > > [  947.535740] RBP: ffff888101628a90 R08: ffff888100955800 R09: ffff888100956000
> > > [  947.541701] R10: 0000000000000002 R11: 0000000000000001 R12: ffff888100963488
> > > [  947.547645] R13: ffff888100963000 R14: ffff888112fb7200 R15: ffff888100963460
> > > [  947.553621] FS:  0000000000000000(0000) GS:ffff88841fd40000(0000) knlGS:0000000000000000
> > > [  947.560537] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [  947.565122] CR2: 0000000008be50c4 CR3: 000000000220c000 CR4: 00000000001006e0
> > > [  947.571072] Call Trace:
> > > [  947.572354]  <TASK>
> > > [  947.573266]  btrfs_commit_transaction+0x1f1/0x998
> > > [  947.576785]  ? start_transaction+0x3ab/0x44e
> > > [  947.579867]  ? schedule_timeout+0x8a/0xdd
> > > [  947.582716]  transaction_kthread+0xe9/0x156
> > > [  947.585721]  ? btrfs_cleanup_transaction.isra.0+0x407/0x407
> > > [  947.590104]  kthread+0x131/0x139
> > > [  947.592168]  ? set_kthread_struct+0x32/0x32
> > > [  947.595174]  ret_from_fork+0x22/0x30
> > > [  947.597561]  </TASK>
> > > [  947.598553] ---[ end trace 644721052755541c ]---
> > > 
> > > This is because we started using writeback_inodes_sb() to flush delalloc
> > > when comitting a transaction (when using -o flushoncommit), in order to
> > > avoid deadlocks with filesystem freeze operations. This change was made
> > > by commit ce8ea7cc6eb313 ("btrfs: don't call btrfs_start_delalloc_roots
> > > in flushoncommit"). After that change we started producing that warning,
> > > and every now and then a user reports this since the warning happens too
> > > often, it spams dmesg/syslog, and a user is unsure if this reflects any
> > > problem that might compromise the filesystem's reliability.
> > > 
> > > We can not just lock the sb->s_umount semaphore before calling
> > > writeback_inodes_sb(), because that would at least deadlock with
> > > filesystem freezing, since at fs/super.c:freeze_super() sync_filesystem()
> > > is called while we are holding that semaphore in write mode, and that can
> > > trigger a transaction commit, resulting in a deadlock. It would also
> > > trigger the same type of deadlock in the unmount path. Possibly, it could
> > > also introduce some other locking dependencies that lockdep would report.
> > > 
> > > To fix this call try_to_writeback_inodes_sb() instead of
> > > writeback_inodes_sb(), because that will try to read lock sb->s_umount
> > > and then will only call writeback_inodes_sb() if it was able to lock it.
> > > This is fine because the cases where it can't read lock sb->s_umount
> > > are during a filesystem unmount or during a filesystem freeze - in those
> > > cases sb->s_umount is write locked and sync_filesystem() is called, which
> > > calls writeback_inodes_sb(). In other words, in all cases where we can't
> > > take a read lock on sb->s_umount, writeback is already being triggered
> > > elsewhere.
> > 
> > I looked for other places that down_write(&sb->s_umount), and I found
> > sget() -> grab_super(). grab_super() (briefly) write locks s_umount and
> > doesn't appear to flush anything. So in theory, if I were to mount an
> > already mounted filesystem at the exact time we tried to writeback the
> > inodes, we could skip the writeback?
> 
> Right, I noticed that. It's a very tiny time window for those cases, plus
> it needs to happen precisely when we are starting a transaction commit.
> 
> I wouldn't worry about it, because flushoncommit never really gave absolute
> guarantees that everything is flushed, it was always a best effort approach.
> 
> With ce8ea7cc6eb3139f4c730d647325e69354159b0f we started using
> writeback_inodes_sb() which does not guarantee if writeback is started.
> Looking at its kernel doc, it explicitly warns about it:
> 
> /**
>  * writeback_inodes_sb	-	writeback dirty inodes from given super_block
>  * @sb: the superblock
>  * @reason: reason why some writeback work was initiated
>  *
>  * Start writeback on some inodes on this super_block. No guarantees are made
>  * on how many (if any) will be written, and this function does not wait
>  * for IO completion of submitted IO.
>  */
> 
> Even before that commit, when we used btrfs_start_delalloc_roots(), we still
> had no guarantees that writeback would be started, as filemap_flush() also
> gives no guarantees. From its kernel doc:
> 
> /**
>  * filemap_flush - mostly a non-blocking flush
>  * @mapping:	target address_space
>  *
>  * This is a mostly non-blocking flush.  Not suitable for data-integrity
>  * purposes - I/O may not be started against all dirty pages.
>  *
>  * Return: %0 on success, negative error code otherwise.
>  */
> 
> So I don't think we will be any worse than before.
> 
> > 
> > Maybe I'm missing something. Even if not, this seems super unlikely and
> > probably better than the warning anyways...
> 
> Yes. Right now flushoncommit can be considered somewhat unusable due to
> spamming dmesg/syslog with the warning and stackstrace. IIRC even Zygo
> had to patch his kernel to remove the warning at __writeback_inodes_sb().
> 
> The change to writeback_inodes_sb() is a clear example of a patch that
> was not tested at all. The warning at __writeback_inodes_sb() exists
> since 2010, and ce8ea7cc6eb3139f4c730d647325e69354159b0f is from 2017.
> Running any test from fstests would trigger the warning several times
> at least.
> 
> Thanks.

That all makes sense, thanks. You can add

Reviewed-by: Omar Sandoval <osandov@fb.com>
