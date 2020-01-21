Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B016143DFD
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jan 2020 14:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbgAUN0q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jan 2020 08:26:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:41076 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727059AbgAUN0q (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jan 2020 08:26:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id ED55FB23B;
        Tue, 21 Jan 2020 13:26:38 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7272CDA738; Tue, 21 Jan 2020 14:26:23 +0100 (CET)
Date:   Tue, 21 Jan 2020 14:26:23 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH][RESEND] btrfs: set trans->drity in
 btrfs_commit_transaction
Message-ID: <20200121132623.GR3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        kernel-team@fb.com, linux-btrfs@vger.kernel.org
References: <20200117135751.42036-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117135751.42036-1-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 17, 2020 at 08:57:51AM -0500, Josef Bacik wrote:
> If we abort a transaction we have the following sequence
> 
> if (!trans->dirty && list_empty(&trans->new_bgs))
> 	return;
> WRITE_ONCE(trans->transaction->aborted, err);
> 
> The idea being if we didn't modify anything with our trans handle then
> we don't really need to abort the whole transaction, maybe the other
> trans handles are fine and we can carry on.
> 
> However in the case of create_snapshot we add a pending_snapshot object
> to our transaction and then commit the transaction.  We don't actually
> modify anything.  sync() behaves the same way, attach to an existing
> transaction and commit it.  This means that if we have an IO error in
> the right places we could abort the committing transaction with our
> trans->dirty being not set and thus not set transaction->aborted.
> 
> This is a problem because in the create_snapshot() case we depend on
> pending->error being set to something, or btrfs_commit_transaction
> returning an error.
> 
> If we are not the trans handle that gets to commit the transaction, and
> we're waiting on the commit to happen we get our return value from
> cur_trans->aborted.  If this was not set to anything because sync() hit
> an error in the transaction commit before it could modify anything then
> cur_trans->aborted would be 0.  Thus we'd return 0 from
> btrfs_commit_transaction() in create_snapshot.
> 
> This is a problem because we then try to do things with
> pending_snapshot->snap, which will be NULL because we didn't create the
> snapshot, and then we'll get a NULL pointer dereference like the
> following
> 
> "BUG: kernel NULL pointer dereference, address: 00000000000001f0"
> RIP: 0010:btrfs_orphan_cleanup+0x2d/0x330
> Call Trace:
>  ? btrfs_mksubvol.isra.31+0x3f2/0x510
>  btrfs_mksubvol.isra.31+0x4bc/0x510
>  ? __sb_start_write+0xfa/0x200
>  ? mnt_want_write_file+0x24/0x50
>  btrfs_ioctl_snap_create_transid+0x16c/0x1a0
>  btrfs_ioctl_snap_create_v2+0x11e/0x1a0
>  btrfs_ioctl+0x1534/0x2c10
>  ? free_debug_processing+0x262/0x2a3
>  do_vfs_ioctl+0xa6/0x6b0
>  ? do_sys_open+0x188/0x220
>  ? syscall_trace_enter+0x1f8/0x330
>  ksys_ioctl+0x60/0x90
>  __x64_sys_ioctl+0x16/0x20
>  do_syscall_64+0x4a/0x1b0
> 
> In order to fix this we need to make sure anybody who calls
> commit_transaction has trans->dirty set so that they properly set the
> trans->transaction->aborted value properly so any waiters know bad
> things happened.
> 
> This was found while I was running generic/475 with my modified
> fsstress, it reproduced within a few runs.  I ran with this patch all
> night and didn't see the problem again.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Added to misc-next, thanks.
