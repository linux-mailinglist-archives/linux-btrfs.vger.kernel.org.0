Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C82F1C7390
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 May 2020 17:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729365AbgEFPFn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 May 2020 11:05:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:44074 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729048AbgEFPFm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 6 May 2020 11:05:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DE414B249;
        Wed,  6 May 2020 15:05:42 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 82B4CDA83A; Wed,  6 May 2020 17:04:48 +0200 (CEST)
Date:   Wed, 6 May 2020 17:04:48 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: qgroup: Mark qgroup inconsistent if we're
 inherting snapshot to a new qgroup
Message-ID: <20200506150448.GH18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200402063735.32808-1-wqu@suse.com>
 <288d0020-380f-717e-ab05-3fe6dbc64cd5@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <288d0020-380f-717e-ab05-3fe6dbc64cd5@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 08, 2020 at 08:36:27PM +0800, Qu Wenruo wrote:
> Forgot to mention, although this doesn't cause any data corruption, it
> breaks snapper, which has some kind of "space aware cleaner algorithm",
> which put all newly created snapshots into 1/0, but not the current root
> subvolume.
> 
> And since snapper uses snapshot ioctl to assign qgroup relationship
> directly, without using qgrou assign ioctl, it has no way to detect such
> problem.
> 
> Hopes we can get this patch into current release cycle.

It's still time to get it to 5.8, with CC: stable it could get
propagated to other versions. For 5.7 it's not clear at this point as
the bug does not seem to be urgent and as far as I understand it,
there's a workaround.

Also with an application (snapper) using some semantics of the ioctls,
we need to actually test it with patched and unpatched kernel, or maybe
snapper needs some fixup first.

> > --- a/fs/btrfs/qgroup.c
> > +++ b/fs/btrfs/qgroup.c
> > @@ -2622,6 +2622,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
> >  	struct btrfs_root *quota_root;
> >  	struct btrfs_qgroup *srcgroup;
> >  	struct btrfs_qgroup *dstgroup;
> > +	bool need_rescan = false;
> >  	u32 level_size = 0;
> >  	u64 nums;
> >  
> > @@ -2765,6 +2766,13 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
> >  				goto unlock;
> >  		}
> >  		++i_qgroups;
> > +
> > +		/*
> > +		 * If we're doing a snapshot, and adding the snapshot to a new
> > +		 * qgroup, the numbers are guaranteed to be incorrect.
> > +		 */
> > +		if (srcid)
> > +			need_rescan = true;
> >  	}
> >  
> >  	for (i = 0; i <  inherit->num_ref_copies; ++i, i_qgroups += 2) {
> > @@ -2784,6 +2792,9 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
> >  
> >  		dst->rfer = src->rfer - level_size;
> >  		dst->rfer_cmpr = src->rfer_cmpr - level_size;
> > +
> > +		/* Manually tweaking numbers? No way to keep qgroup sane */
> > +		need_rescan = true;
> >  	}
> >  	for (i = 0; i <  inherit->num_excl_copies; ++i, i_qgroups += 2) {
> >  		struct btrfs_qgroup *src;
> > @@ -2802,6 +2813,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
> >  
> >  		dst->excl = src->excl + level_size;
> >  		dst->excl_cmpr = src->excl_cmpr + level_size;
> > +		need_rescan = true;
> >  	}
> >  
> >  unlock:
> > @@ -2809,6 +2821,8 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
> >  out:
> >  	if (!committing)
> >  		mutex_unlock(&fs_info->qgroup_ioctl_lock);
> > +	if (need_rescan)
> > +		fs_info->qgroup_flags |= BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;

This got me curious, a non-atomic change to qgroup_flags and without
any protection. The function is not running in a safe context (like
quota enable or disable) so lack of synchronization seems suspicious. I
grepped for other changes to the qgroup_flags and it's very
inconsistent. Sometimes it's the fs_info::qgroup_lock, no lokcing at all
or no obvious lock but likely fs_info::qgroup_ioctl_lock or
qgroup_rescan_lock.

I was considering using atomic bit updates but that would be another
patch.
