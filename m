Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7B6319452C
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Mar 2020 18:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbgCZROw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Mar 2020 13:14:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:52786 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726163AbgCZROw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Mar 2020 13:14:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 70C8CAF84;
        Thu, 26 Mar 2020 17:14:49 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 67BB3DA730; Thu, 26 Mar 2020 18:14:17 +0100 (CET)
Date:   Thu, 26 Mar 2020 18:14:16 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Filipe Manana <fdmanana@gmail.com>
Cc:     Marcos Paulo de Souza <marcos@mpdesouza.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: Re: [PATCH RFC] btrfs: send: Emit all xattr of an inode if the
 uid/gid changed
Message-ID: <20200326171416.GJ5920@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Filipe Manana <fdmanana@gmail.com>,
        Marcos Paulo de Souza <marcos@mpdesouza.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        Marcos Paulo de Souza <mpdesouza@suse.com>
References: <20200325015251.28838-1-marcos@mpdesouza.com>
 <CAL3q7H5y_i1czDe9ftp5U-SNFO1fOG8DJPoNToaMLJwjX-D-kw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H5y_i1czDe9ftp5U-SNFO1fOG8DJPoNToaMLJwjX-D-kw@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 26, 2020 at 01:51:20PM +0000, Filipe Manana wrote:
> >  * Should it be fixed in userspace?
> 
> No.
> 
> Send should emit a sequence of operations that produces correct
> results in the receiving side. It should never result in any data or
> metadata loss, crashes, etc.
> 
> This is no different from rename dependencies for example, where we
> make send change the order of rename and other operations so that the
> receiving side doesn't fail - otherwise we would have to add a lot of
> intelligence and complicated code to btrfs receive in progs - which
> brings us to another point - any consumer of a send stream would have
> to be changed - btrfs receive from btrfs-progs, is the most well
> known, and very few people will use anything else, but there may be
> other consumers of send streams out there.

Agreed, receive should do only minimal post processing of the stream or
avoid it completely. There's one workaround for the capabilities and
chown (process_set_xattr, process_chown) but it does not address all
cases. With the send generated with the xattr update the workaround can
be dropped.

> > @@ -6255,6 +6260,22 @@ static int changed_inode(struct send_ctx *sctx,
> >                         sctx->cur_inode_mode = btrfs_inode_mode(
> >                                         sctx->left_path->nodes[0], left_ii);
> >                 }
> > +
> > +               /*
> > +                * Process all XATTR of the inode if the generation or owner
> > +                * changed.
> > +                *
> > +                * If the inode changed it's uid/gid, but kept a
> > +                * security.capability xattr, only the uid/gid will be emitted,
> > +                * causing the related xattr to deleted. For this reason always
> > +                * emit the XATTR when an inode has changed.
> > +                */
> > +               if (sctx->cur_inode_new_gen || left_uid != right_uid ||
> > +                   left_gid != right_gid) {
> > +                       ret = process_all_new_xattrs(sctx);
> 
> So the correct place for fixing this issue is at
> send.c:finish_inode_if_needed(), in the following place:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/btrfs/send.c?h=v5.6-rc7#n6000
> 
> If a chown operation is sent, then just send the xattr - and instead
> if sending all xattrs, just send the xattr with the name
> "security.capability" - check first if there are any other
> capabilities that use other xattr names - if there are, just emit
> set_xattr operations for all xattrs with a "security." prefix in their
> name.

Sounds good. The only problem known to me are the capabilities but in case
there's more, the list can be extended. The owner change implications
are documented in chown and capabilities manual pages, I haven't found
anything else.
