Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59AA01728FA
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Feb 2020 20:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730458AbgB0Txq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Feb 2020 14:53:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:52280 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729594AbgB0Txq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Feb 2020 14:53:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5C657AD19;
        Thu, 27 Feb 2020 19:53:44 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 037F8DA83A; Thu, 27 Feb 2020 20:53:23 +0100 (CET)
Date:   Thu, 27 Feb 2020 20:53:23 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: don't force read-only after error in drop snapshot
Message-ID: <20200227195323.GI2902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20200225140553.24849-1-dsterba@suse.com>
 <7660846a-43ed-c218-68c6-fd330e3ff2d1@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7660846a-43ed-c218-68c6-fd330e3ff2d1@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 26, 2020 at 12:35:37PM +0800, Anand Jain wrote:
> On 25/2/20 10:05 PM, David Sterba wrote:
> > Deleting a subvolume on a full filesystem leads to ENOSPC followed by a
> > forced read-only. This is not a transaction abort and the filesystem is
> > otherwise ok, so the error should be just propagated.
> 
> yep.
> 
> > This is caused by unnecessary call to btrfs_handle_fs_error for almost
> > all errors, except EAGAIN. This does not make sense as the standard
> > transaction abort mechanism is in btrfs_drop_snapshot so all relevant
> > failures are handled.
> > 
> > Originally in commit cb1b69f4508a ("Btrfs: forced readonly when
> > btrfs_drop_snapshot() fails") there was no return value at all, so the
> > btrfs_std_error made some sense but once the error handling and
> > propagation has been we don't need it.
> > 
> > Signed-off-by: David Sterba <dsterba@suse.com>
> > ---
> > 
> > The use of btrfs_handle_fs_error in other places looks fishy, it makes
> > sense only in case there's a real error and transaction abort is not
> > possible, ~40 calls sound too much.
> > 
> >   fs/btrfs/extent-tree.c | 2 --
> >   1 file changed, 2 deletions(-)
> > 
> > diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> > index 161274118853..b18db1b3a412 100644
> > --- a/fs/btrfs/extent-tree.c
> > +++ b/fs/btrfs/extent-tree.c
> > @@ -5426,8 +5426,6 @@ int btrfs_drop_snapshot(struct btrfs_root *root,
> >   	 */
> >   	if (!for_reloc && !root_dropped)
> >   		btrfs_add_dead_root(root);
> > -	if (err && err != -EAGAIN)
> > -		btrfs_handle_fs_error(fs_info, err, NULL);
> >   	return err;
> >   }
> 
> However can we confirm that the error returned here are logged by its 
> parents (relocation thread and the cleaner thread) ?

What do you mean logged? The error is propagated to the callers.

In btrfs_clean_one_deleted_snapshot it will result in not looping again
to clean futher subvolumes, silent error should be ok here.

In clean_dirty_subvols the last error is propagated as the loop
continues until all subvolumes from the list are processed, but reloc
dropping snapshot can handle EAGAIN and ENOSPC will be the same.
