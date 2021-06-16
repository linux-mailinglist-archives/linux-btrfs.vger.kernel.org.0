Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37E983AA083
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Jun 2021 17:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234980AbhFPP7I (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Jun 2021 11:59:08 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:46700 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234756AbhFPP6U (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Jun 2021 11:58:20 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C2D3B21A6D;
        Wed, 16 Jun 2021 15:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623858973;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Apl7O202VTGnc586TG2RPjIRTrQfy9ZQecjLPvHdbGE=;
        b=qnMXmryEZUr5QJYMtCgi0wjwHZE7xxZ2tIAahbr9J7HNxXV3iuraA06YvqHTX6rddF1ISc
        YiKh9biE5haKJCV6LdDCOU67GlViZM9IGoBjrFI4ogyPF3ikeM5DJ7n75XE71eiHe2heXP
        RIV+lIbM/Sjh3cCxV33pJkxGPhLV/Vk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623858973;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Apl7O202VTGnc586TG2RPjIRTrQfy9ZQecjLPvHdbGE=;
        b=z63b2OBLHvlkM2SlDzZ227sIyJk6cxXJHLg6mL3AXNvlSJGVp6MuZCxe3ZGl3USuiOkr0A
        n2cVeqTHUIYzOKCQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id BBF86A3BAD;
        Wed, 16 Jun 2021 15:56:13 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id EB071DB225; Wed, 16 Jun 2021 17:53:25 +0200 (CEST)
Date:   Wed, 16 Jun 2021 17:53:25 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Filipe Manana <fdmanana@gmail.com>
Cc:     David Sterba <dsterba@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 2/6] btrfs: add cancelable chunk relocation support
Message-ID: <20210616155325.GQ28158@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Filipe Manana <fdmanana@gmail.com>,
        David Sterba <dsterba@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <cover.1621526221.git.dsterba@suse.com>
 <79a09502c532bc9939645d2711c72ebad5fce2e7.1621526221.git.dsterba@suse.com>
 <CAL3q7H6P-TqtM6BkRY5_15ThVJzD54HZCdjKtdkukUqrZzh5-Q@mail.gmail.com>
 <CAL3q7H4xwZwZaBVXjJ8n9152D39eomfKOS1j0QQBFAWn7kYUxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H4xwZwZaBVXjJ8n9152D39eomfKOS1j0QQBFAWn7kYUxQ@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 16, 2021 at 02:55:46PM +0100, Filipe Manana wrote:
> On Wed, Jun 16, 2021 at 2:54 PM Filipe Manana <fdmanana@gmail.com> wrote:
> >
> > On Fri, May 21, 2021 at 9:15 PM David Sterba <dsterba@suse.com> wrote:
> > >
> > > Add support code that will allow canceling relocation on the chunk
> > > granularity. This is different and independent of balance, that also
> > > uses relocation but is a higher level operation and manages it's own
> > > state and pause/cancelation requests.
> > >
> > > Relocation is used for resize (shrink) and device deletion so this will
> > > be a common point to implement cancelation for both. The context is
> > > entirely in btrfs_relocate_block_group and btrfs_recover_relocation,
> > > enclosing one chunk relocation. The status bit is set and unset between
> > > the chunks. As relocation can take long, the effects may not be
> > > immediate and the request and actual action can slightly race.
> > >
> > > The fs_info::reloc_cancel_req is only supposed to be increased and does
> > > not pair with decrement like fs_info::balance_cancel_req.
> > >
> > > Signed-off-by: David Sterba <dsterba@suse.com>
> > > ---
> > >  fs/btrfs/ctree.h      |  9 +++++++
> > >  fs/btrfs/disk-io.c    |  1 +
> > >  fs/btrfs/relocation.c | 60 ++++++++++++++++++++++++++++++++++++++++++-
> > >  3 files changed, 69 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> > > index a142e56b6b9a..3dfc32a3ebab 100644
> > > --- a/fs/btrfs/ctree.h
> > > +++ b/fs/btrfs/ctree.h
> > > @@ -565,6 +565,12 @@ enum {
> > >          */
> > >         BTRFS_FS_BALANCE_RUNNING,
> > >
> > > +       /*
> > > +        * Indicate that relocation of a chunk has started, it's set per chunk
> > > +        * and is toggled between chunks.
> > > +        */
> > > +       BTRFS_FS_RELOC_RUNNING,
> > > +
> > >         /* Indicate that the cleaner thread is awake and doing something. */
> > >         BTRFS_FS_CLEANER_RUNNING,
> > >
> > > @@ -871,6 +877,9 @@ struct btrfs_fs_info {
> > >         struct btrfs_balance_control *balance_ctl;
> > >         wait_queue_head_t balance_wait_q;
> > >
> > > +       /* Cancelation requests for chunk relocation */
> > > +       atomic_t reloc_cancel_req;
> > > +
> > >         u32 data_chunk_allocations;
> > >         u32 metadata_ratio;
> > >
> > > diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> > > index 8c3db9076988..93c994b78d61 100644
> > > --- a/fs/btrfs/disk-io.c
> > > +++ b/fs/btrfs/disk-io.c
> > > @@ -2251,6 +2251,7 @@ static void btrfs_init_balance(struct btrfs_fs_info *fs_info)
> > >         atomic_set(&fs_info->balance_cancel_req, 0);
> > >         fs_info->balance_ctl = NULL;
> > >         init_waitqueue_head(&fs_info->balance_wait_q);
> > > +       atomic_set(&fs_info->reloc_cancel_req, 0);
> > >  }
> > >
> > >  static void btrfs_init_btree_inode(struct btrfs_fs_info *fs_info)
> > > diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> > > index b70be2ac2e9e..9b84eb86e426 100644
> > > --- a/fs/btrfs/relocation.c
> > > +++ b/fs/btrfs/relocation.c
> > > @@ -2876,11 +2876,12 @@ int setup_extent_mapping(struct inode *inode, u64 start, u64 end,
> > >  }
> > >
> > >  /*
> > > - * Allow error injection to test balance cancellation
> > > + * Allow error injection to test balance/relocation cancellation
> > >   */
> > >  noinline int btrfs_should_cancel_balance(struct btrfs_fs_info *fs_info)
> > >  {
> > >         return atomic_read(&fs_info->balance_cancel_req) ||
> > > +               atomic_read(&fs_info->reloc_cancel_req) ||
> > >                 fatal_signal_pending(current);
> > >  }
> > >  ALLOW_ERROR_INJECTION(btrfs_should_cancel_balance, TRUE);
> > > @@ -3780,6 +3781,47 @@ struct inode *create_reloc_inode(struct btrfs_fs_info *fs_info,
> > >         return inode;
> > >  }
> > >
> > > +/*
> > > + * Mark start of chunk relocation that is cancelable. Check if the cancelation
> > > + * has been requested meanwhile and don't start in that case.
> > > + *
> > > + * Return:
> > > + *   0             success
> > > + *   -EINPROGRESS  operation is already in progress, that's probably a bug
> > > + *   -ECANCELED    cancelation request was set before the operation started
> > > + */
> > > +static int reloc_chunk_start(struct btrfs_fs_info *fs_info)
> > > +{
> > > +       if (test_and_set_bit(BTRFS_FS_RELOC_RUNNING, &fs_info->flags)) {
> > > +               /* This should not happen */
> > > +               btrfs_err(fs_info, "reloc already running, cannot start");
> > > +               return -EINPROGRESS;
> > > +       }
> > > +
> > > +       if (atomic_read(&fs_info->reloc_cancel_req) > 0) {
> > > +               btrfs_info(fs_info, "chunk relocation canceled on start");
> > > +               /*
> > > +                * On cancel, clear all requests but let the caller mark
> > > +                * the end after cleanup operations.
> > > +                */
> > > +               atomic_set(&fs_info->reloc_cancel_req, 0);
> > > +               return -ECANCELED;
> > > +       }
> > > +       return 0;
> > > +}
> > > +
> > > +/*
> > > + * Mark end of chunk relocation that is cancelable and wake any waiters.
> > > + */
> > > +static void reloc_chunk_end(struct btrfs_fs_info *fs_info)
> > > +{
> > > +       /* Requested after start, clear bit first so any waiters can continue */
> > > +       if (atomic_read(&fs_info->reloc_cancel_req) > 0)
> > > +               btrfs_info(fs_info, "chunk relocation canceled during operation");
> > > +       clear_and_wake_up_bit(BTRFS_FS_RELOC_RUNNING, &fs_info->flags);
> > > +       atomic_set(&fs_info->reloc_cancel_req, 0);
> > > +}
> > > +
> > >  static struct reloc_control *alloc_reloc_control(struct btrfs_fs_info *fs_info)
> > >  {
> > >         struct reloc_control *rc;
> > > @@ -3862,6 +3904,12 @@ int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start)
> > >                 return -ENOMEM;
> > >         }
> > >
> > > +       ret = reloc_chunk_start(fs_info);
> > > +       if (ret < 0) {
> > > +               err = ret;
> > > +               goto out_end;
> >
> > There's a bug here. At out_end we do:
> >
> > btrfs_put_block_group(rc->block_group);
> >
> > But rc->block_group was not yet assigned.
> 
> On misc-next it's actually label "out_put_bg" and under there we do
> the block group put, but not on the version posted here.

Right, thanks for catching it. It should have been
btrfs_put_block_group(bg).
