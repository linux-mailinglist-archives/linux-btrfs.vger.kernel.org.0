Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5251FB605
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jun 2020 17:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729223AbgFPPXZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Jun 2020 11:23:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:60842 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728899AbgFPPXZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Jun 2020 11:23:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BF7C9B1C2;
        Tue, 16 Jun 2020 15:23:27 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C847ADA7C3; Tue, 16 Jun 2020 17:23:14 +0200 (CEST)
Date:   Tue, 16 Jun 2020 17:23:14 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     dsterba@suse.cz, linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/4] Btrfs: fix hang on snapshot creation after
 RWF_NOWAIT write
Message-ID: <20200616152314.GG27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Filipe Manana <fdmanana@kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20200615174601.14559-1-fdmanana@kernel.org>
 <20200616143420.GC27795@twin.jikos.cz>
 <CAL3q7H4BWscwaA4PL2wKuejHgifZ6ea4Eq+pt-cZAQenxF9s3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H4BWscwaA4PL2wKuejHgifZ6ea4Eq+pt-cZAQenxF9s3w@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 16, 2020 at 04:17:19PM +0100, Filipe Manana wrote:
> On Tue, Jun 16, 2020 at 3:34 PM David Sterba <dsterba@suse.cz> wrote:
> > On Mon, Jun 15, 2020 at 06:46:01PM +0100, fdmanana@kernel.org wrote:
> > > From: Filipe Manana <fdmanana@suse.com>
> > > --- a/fs/btrfs/file.c
> > > +++ b/fs/btrfs/file.c
> > > @@ -1914,6 +1914,8 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
> > >                       inode_unlock(inode);
> > >                       return -EAGAIN;
> > >               }
> > > +             /* check_can_nocow() locks the snapshot lock on success */
> > > +             btrfs_drew_write_unlock(&root->snapshot_lock);
> >
> > That's quite ugly that the locking semantics of check_can_nocow is
> > hidden, this should be cleaned up too.
> >
> > The whole condition
> >
> > 1909                 if (!(BTRFS_I(inode)->flags & (BTRFS_INODE_NODATACOW |
> > 1910                                               BTRFS_INODE_PREALLOC)) ||
> > 1911                     check_can_nocow(BTRFS_I(inode), pos, &count) <= 0)
> >
> > has 2 parts and it's not obvious from the context when the lock actually is
> > taken. The flags check could be pushed down to check_can_nocow, the
> > same but negated condition can be found in btrfs_file_write_iter so this
> > would make it something like:
> >
> >         if (check_can_nocow(inode, pos, &count) <= 0) {
> >                 /* fallback */
> >                 return ...;
> >         }
> >         /*
> >          * the lock is taken and needs to be unlocked at the right time
> >          */
> >
> > Suggestions to rename check_can_nocow welcome too.
> 
> Sure, I can understand it may look not obvious on first sight at least.
> 
> Here I'm only focusing on functional problems and kept this fix as
> small as possible to backport to stable releases,
> as this is a bug that directly impacts user experience.

Ok that makes sense of course, I'll add the four patches to misc-next
and queue them for rc. Thanks.
