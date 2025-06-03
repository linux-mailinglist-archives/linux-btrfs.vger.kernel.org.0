Return-Path: <linux-btrfs+bounces-14415-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE788ACCBCA
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jun 2025 19:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E59001897432
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jun 2025 17:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCEC81D54EE;
	Tue,  3 Jun 2025 17:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="jcjLobxZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Cf8uBnr2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE701A0730
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Jun 2025 17:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748970709; cv=none; b=bRuvH4IbgzDMpUxHuqYO4G+EXbtwQ/mGnIINqIWV35mm18x11EqKr56rRB3wIbDxk5c6p2RQ5Zcy8qiisQDZXdD1WIhQvdFGD+qRmEd4xMDCMUsmq1fJX7nV1ILgzk36Rup6eMMy4KZobS3mFQGAy2ScdxCldkgLjt2SH8WeORg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748970709; c=relaxed/simple;
	bh=tkS+4Tkma5hq4XRDkLRemiPZNne0j1l7ZEzZB3/TAfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mxq1H3uaK7Lp/N5OxcVC4y1FGCchipkdQbuuGtuE/f7z5zATvmfgdhs1ekamzHYfYWx/M8yVAIQWWqmiwTmwmiviQb2IC6PzyXUHOSQqtMz2aaK1nBotma+dppY+d/ShYOK7xgoW5BSlyOfYRxI7lh3tIk17WG+a4UJgFuSOuvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=jcjLobxZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Cf8uBnr2; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id A371C13800EF;
	Tue,  3 Jun 2025 13:11:45 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 03 Jun 2025 13:11:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1748970705;
	 x=1749057105; bh=pFt4/a6ZB87vU7wErDHf0RAg7yNrpkxNIBx8MynVDdQ=; b=
	jcjLobxZN34Zj0nP8gIu3dV6+b27urZh9Ca52rUdVKZdmO+Hg1S0pWAJq5qU+W/c
	akWdWzUntr2VbZXyV9pajQw5URqelMK40z15rPGnhz6C9DNESxH75Gqyx7vLg74E
	LJH0rmBwSXPXaeEA39Wb8Udmjqi4HkO1ZFsm6qAeKH+UsWG2x+Q8auImSA+wuz+c
	9vrgWXmp6YW8biJ45FDZDzjkTSjFCFNGN1tiBMVXfFzYYhbEmZxzpOqwxxK/x0Sg
	dy0bmffMC90L03kIjJMTz9yQ/Vu+VqcQnpThUADcuWViKW2nmLjH0HY3XDUoakf6
	G2LSpKPjw0Pkev5gkwW1cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748970705; x=
	1749057105; bh=pFt4/a6ZB87vU7wErDHf0RAg7yNrpkxNIBx8MynVDdQ=; b=C
	f8uBnr2aiiyLu4bNoQ5MokcPW2ZbmaoKeAtzgBs6T1PFc2MpDrW00YYDFYzQ+sjY
	qdDIZPNueWKSHvXD0dTR21wD1+rd6x2zPL+qJUwhb5TIOs5oryJ011pj3LFriHaC
	kMBWwlTISMd+2pdalUE6z41r7M0LmRg88zzIC1GoiE4bo3rW3SyF2WpGUkBb+pgE
	4nFbvonM+Xy8HbT16askyK6+BZN6mVtqxROOki/giWCEh8GQQTOX3YADLSL5ukkf
	uquQhEU1SeB0y0xYXdSj+16U0lcw93WgYvHcZBD6Jud6ozLniNbjck67kaViVX62
	gC1+40DmYgvnbXVZ9X9zw==
X-ME-Sender: <xms:0Sw_aAIW2CnDlAqVwy0trU6oz-iJ_miiiuehUXtHcQCOzAOLYVKskw>
    <xme:0Sw_aAJHlUKzuClWQ7XyJRz6fXCMcYMBzt_feeiFHyJzLLtRJXLk2LXayjP-xJOpm
    zkodiahmQPcwGTPOuE>
X-ME-Received: <xmr:0Sw_aAtgk6CBfchYU88ut19wLw32hWjGMpBoViPd6gJX1gk8DZ9p_ROZr4fOEwP0Sk--kScZ5yNwZ-WZWNpAh9c8aeU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdektdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeen
    ucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenuc
    ggtffrrghtthgvrhhnpedulefhtdfhteduvdethfeftdeitdethedvtdekvdeltddvveeg
    tdeuuddtiedtieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepfhgumhgrnhgrnhgrsehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:0Sw_aNYyESCKTBVJh3EpowHrF79mdrQVClwxcX2UsEbCGNIudCXmDQ>
    <xmx:0Sw_aHatishGn0sUTDhyr4Pf50LTrlWE1zeB0UNHkIt00gfgQST7tA>
    <xmx:0Sw_aJB7krggu9YE5i5xjbFVWHkF7-TdW6jRHOBPAhmafh4Q8rtexA>
    <xmx:0Sw_aNaNv2zKN_7UqpQ7hNNqJ6hNTJUgICOBT8vuZWFNYxQm9-2eNA>
    <xmx:0Sw_aAGaxov0gi2bILquq7laP4quk_mS_asFkXaGqpTKqjywLFdPCPjq>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Jun 2025 13:11:44 -0400 (EDT)
Date: Tue, 3 Jun 2025 10:11:42 -0700
From: Boris Burkov <boris@bur.io>
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 01/14] btrfs: fix a race between renames and directory
 logging
Message-ID: <20250603171142.GA2599675@zen.localdomain>
References: <cover.1748789125.git.fdmanana@suse.com>
 <10075404e05fae4f219cd308bff91a25ac3bd6fe.1748789125.git.fdmanana@suse.com>
 <20250603010310.GA1509461@zen.localdomain>
 <CAL3q7H5a5gzL6BMsbpG3JBNwPeFxWq70Nt_Mz7YVPgCF=QJizw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H5a5gzL6BMsbpG3JBNwPeFxWq70Nt_Mz7YVPgCF=QJizw@mail.gmail.com>

On Tue, Jun 03, 2025 at 08:55:03AM +0100, Filipe Manana wrote:
> On Tue, Jun 3, 2025 at 2:03 AM Boris Burkov <boris@bur.io> wrote:
> >
> > On Mon, Jun 02, 2025 at 11:32:54AM +0100, fdmanana@kernel.org wrote:
> > > From: Filipe Manana <fdmanana@suse.com>
> > >
> > > We have a race between a rename and directory inode logging that if it
> > > happens and we crash/power fail before the rename completes, the next time
> > > the filesystem is mounted, the log replay code will end up deleting the
> > > file that was being renamed.
> > >
> > > This is best explained following a step by step analysis of an interleaving
> > > of steps that lead into this situation.
> > >
> > > Consider the initial conditions:
> > >
> > > 1) We are at transaction N;
> > >
> > > 2) We have directories A and B created in a past transaction (< N);
> > >
> > > 3) We have inode X corresponding to a file that has 2 hardlinks, one in
> > >    directory A and the other in directory B, so we'll name them as
> > >    "A/foo_link1" and "B/foo_link2". Both hard links were persisted in a
> > >    past transaction (< N);
> > >
> > > 4) We have inode Y corresponding to a file that as a single hard link and
> > >    is located in directory A, we'll name it as "A/bar". This file was also
> > >    persisted in a past transaction (< N).
> > >
> > > The steps leading to a file loss are the following and for all of them we
> > > are under transaction N:
> > >
> > >  1) Link "A/foo_link1" is removed, so inode's X last_unlink_trans field
> > >     is updated to N, through btrfs_unlink() -> btrfs_record_unlink_dir();
> > >
> > >  2) Task A starts a rename for inode Y, with the goal of renaming from
> > >     "A/bar" to "A/baz", so we enter btrfs_rename();
> > >
> > >  3) Task A inserts the new BTRFS_INODE_REF_KEY for inode Y by calling
> > >     btrfs_insert_inode_ref();
> > >
> > >  4) Because the rename happens in the same directory, we don't set the
> > >     last_unlink_trans field of directoty A's inode to the current
> > >     transaction id, that is, we don't cal btrfs_record_unlink_dir();
> >
> > Presumably, an alternative fix would be to also call
> > btrfs_record_unlink_dir() for same directory renames? However, it seems
> > like pinning the log commit for the duration of the rename is going to
> > be faster than falling back to a full transaction commit.
> >
> > Did I understand the rationale correctly?
> 
> Yes, you understood correctly.
> We want to avoid setting last_unlink_trans for the directory, in case
> of same directory renames, to avoid full transaction commits.
> 
> >
> > >
> > >  5) Task A then removes the entries from directory A (BTRFS_DIR_ITEM_KEY
> > >     and BTRFS_DIR_INDEX_KEY items) when calling __btrfs_unlink_inode()
> > >     (actually the dir index item is added as a delayed item, but the
> > >     effect is the same);
> > >
> > >  6) Now before task A adds the new entry "A/baz" to directory A by
> > >     calling btrfs_add_link(), another task, task B is logging inode X;
> > >
> > >  7) Task B starts a fsync of inode X and after logging inode X, at
> > >     btrfs_log_inode_parent() it calls btrfs_log_all_parents(), since
> > >     inode X has a last_unlink_trans value of N, set at in step 1;
> > >
> > >  8) At btrfs_log_all_parents() we search for all parent directories of
> > >     inode X using the commit root, so we find directories A and B and log
> > >     them. Bu when logging direct A, we don't have a dir index item for
> > >     inode Y anymore, neither the old name "A/bar" nor for the new name
> > >     "A/baz" since the rename has deleted the old name but has not yet
> > >     inserted the new name - task A hasn't called yet btrfs_add_link() to
> > >     do that.
> > >
> > >     Note that logging directory A doesn't fallback to a transaction
> > >     commit because its last_unlink_trans has a lower value than the
> > >     current transaction's id (see step 4);
> > >
> > >  9) Task B finishes logging directories A and B and gets back to
> > >     btrfs_sync_file() where it calls btrfs_sync_log() to persist the log
> > >     tree;
> > >
> > > 10) Task B successfully persisted the log tree, btrfs_sync_log() completed
> > >     with success, and a power failure happened.
> > >
> > >     We have a log tree without any directory entry for inode Y, so the
> > >     log replay code deletes the entry for inode Y, name "A/bar", from the
> > >     subvolume tree since it doesn't exist in the log tree and the log
> > >     tree is authorative for its index (we logged a BTRFS_DIR_LOG_INDEX_KEY
> > >     item that covers the index range for the dentry that corresponds to
> > >     "A/bar").
> > >
> > >     Since there's no other hard link for inode Y and the log replay code
> > >     deletes the name "A/bar", the file is lost.
> > >
> > > The issue wouldn't happen if task B synced the log only after task A
> > > called btrfs_log_new_name(), which would update the log with the new name
> > > for inode Y ("A/bar").
> > >
> > > Fix this by pinning the log root during renames before removing the old
> > > directory entry, and unpinning after btrfs_log_new_name() is called.
> > >
> > > Fixes: 259c4b96d78d ("btrfs: stop doing unnecessary log updates during a rename")
> > > CC: stable@vger.kernel.org # 5.18+
> > >
> > > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> >
> > The explanation and fix make sense to me, thanks.
> > Reviewed-by: Boris Burkov <boris@bur.io>
> >
> > One qq: would it be possible / make sense to have an absolutely minimal
> > fix patch that only restores the log pinning order (as changed by
> > 259c4b96d78d) without the additional refactoring of the subvol root
> > checking logic (i.e., getting rid of the per-root pin tracking bools)?
> > Then separately do that refactoring?
> 
> A fix doesn't have to necessarily make code exactly equal to what it
> was before, unless the only solution is a full revert, which usually
> happens for fairly recent commits.
> 
> The code is slightly different, yes, but many things have changed
> after that commit over the years.
> I wouldn't call it a refactoring, and I don't see why you think it
> makes backporting harder, in fact trying to do it exactly as before
> would actually make the backport harder on more recent kernels.

I missed how old the bug was, my bad. Totally agreed that "fixing
forward" is way more appropriate here.

> 
> The code now is equivalent, with more comments about what is being done and why
> The addition is to avoid logging new names in case we have set the log
> for full commit, due to renaming a root, but that doesn't make it
> harder to backport at all.
> 
> Thanks.
> 
> 
> >
> > > ---
> > >  fs/btrfs/inode.c | 81 ++++++++++++++++++++++++++++++++++++++----------
> > >  1 file changed, 64 insertions(+), 17 deletions(-)
> > >
> > > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > > index 7074f975c033..7bad21ec41f8 100644
> > > --- a/fs/btrfs/inode.c
> > > +++ b/fs/btrfs/inode.c
> > > @@ -8063,6 +8063,7 @@ static int btrfs_rename_exchange(struct inode *old_dir,
> > >       int ret;
> > >       int ret2;
> > >       bool need_abort = false;
> > > +     bool logs_pinned = false;
> > >       struct fscrypt_name old_fname, new_fname;
> > >       struct fscrypt_str *old_name, *new_name;
> > >
> > > @@ -8186,6 +8187,31 @@ static int btrfs_rename_exchange(struct inode *old_dir,
> > >       inode_inc_iversion(new_inode);
> > >       simple_rename_timestamp(old_dir, old_dentry, new_dir, new_dentry);
> > >
> > > +     if (old_ino != BTRFS_FIRST_FREE_OBJECTID &&
> > > +         new_ino != BTRFS_FIRST_FREE_OBJECTID) {
> > > +             /*
> > > +              * If we are renaming in the same directory (and it's not for
> > > +              * root entries) pin the log early to prevent any concurrent
> > > +              * task from logging the directory after we removed the old
> > > +              * entries and before we add the new entries, otherwise that
> > > +              * task can sync a log without any entry for the inodes we are
> > > +              * renaming and therefore replaying that log, if a power failure
> > > +              * happens after syncing the log, would result in deleting the
> > > +              * inodes.
> > > +              *
> > > +              * If the rename affects two different directories, we want to
> > > +              * make sure the that there's no log commit that contains
> > > +              * updates for only one of the directories but not for the
> > > +              * other.
> > > +              *
> > > +              * If we are renaming an entry for a root, we don't care about
> > > +              * log updates since we called btrfs_set_log_full_commit().
> > > +              */
> > > +             btrfs_pin_log_trans(root);
> > > +             btrfs_pin_log_trans(dest);
> > > +             logs_pinned = true;
> > > +     }
> > > +
> > >       if (old_dentry->d_parent != new_dentry->d_parent) {
> > >               btrfs_record_unlink_dir(trans, BTRFS_I(old_dir),
> > >                                       BTRFS_I(old_inode), true);
> > > @@ -8257,30 +8283,23 @@ static int btrfs_rename_exchange(struct inode *old_dir,
> > >               BTRFS_I(new_inode)->dir_index = new_idx;
> > >
> > >       /*
> > > -      * Now pin the logs of the roots. We do it to ensure that no other task
> > > -      * can sync the logs while we are in progress with the rename, because
> > > -      * that could result in an inconsistency in case any of the inodes that
> > > -      * are part of this rename operation were logged before.
> > > +      * Do the log updates for all inodes.
> > > +      *
> > > +      * If either entry is for a root we don't need to update the logs since
> > > +      * we've called btrfs_set_log_full_commit() before.
> > >        */
> > > -     if (old_ino != BTRFS_FIRST_FREE_OBJECTID)
> > > -             btrfs_pin_log_trans(root);
> > > -     if (new_ino != BTRFS_FIRST_FREE_OBJECTID)
> > > -             btrfs_pin_log_trans(dest);
> > > -
> > > -     /* Do the log updates for all inodes. */
> > > -     if (old_ino != BTRFS_FIRST_FREE_OBJECTID)
> > > +     if (logs_pinned) {
> > >               btrfs_log_new_name(trans, old_dentry, BTRFS_I(old_dir),
> > >                                  old_rename_ctx.index, new_dentry->d_parent);
> > > -     if (new_ino != BTRFS_FIRST_FREE_OBJECTID)
> > >               btrfs_log_new_name(trans, new_dentry, BTRFS_I(new_dir),
> > >                                  new_rename_ctx.index, old_dentry->d_parent);
> > > +     }
> > >
> > > -     /* Now unpin the logs. */
> > > -     if (old_ino != BTRFS_FIRST_FREE_OBJECTID)
> > > +out_fail:
> > > +     if (logs_pinned) {
> > >               btrfs_end_log_trans(root);
> > > -     if (new_ino != BTRFS_FIRST_FREE_OBJECTID)
> > >               btrfs_end_log_trans(dest);
> > > -out_fail:
> > > +     }
> > >       ret2 = btrfs_end_transaction(trans);
> > >       ret = ret ? ret : ret2;
> > >  out_notrans:
> > > @@ -8330,6 +8349,7 @@ static int btrfs_rename(struct mnt_idmap *idmap,
> > >       int ret2;
> > >       u64 old_ino = btrfs_ino(BTRFS_I(old_inode));
> > >       struct fscrypt_name old_fname, new_fname;
> > > +     bool logs_pinned = false;
> > >
> > >       if (btrfs_ino(BTRFS_I(new_dir)) == BTRFS_EMPTY_SUBVOL_DIR_OBJECTID)
> > >               return -EPERM;
> > > @@ -8464,6 +8484,29 @@ static int btrfs_rename(struct mnt_idmap *idmap,
> > >       inode_inc_iversion(old_inode);
> > >       simple_rename_timestamp(old_dir, old_dentry, new_dir, new_dentry);
> > >
> > > +     if (old_ino != BTRFS_FIRST_FREE_OBJECTID) {
> > > +             /*
> > > +              * If we are renaming in the same directory (and it's not a
> > > +              * root entry) pin the log to prevent any concurrent task from
> > > +              * logging the directory after we removed the old entry and
> > > +              * before we add the new entry, otherwise that task can sync
> > > +              * a log without any entry for the inode we are renaming and
> > > +              * therefore replaying that log, if a power failure happens
> > > +              * after syncing the log, would result in deleting the inode.
> > > +              *
> > > +              * If the rename affects two different directories, we want to
> > > +              * make sure the that there's no log commit that contains
> > > +              * updates for only one of the directories but not for the
> > > +              * other.
> > > +              *
> > > +              * If we are renaming an entry for a root, we don't care about
> > > +              * log updates since we called btrfs_set_log_full_commit().
> > > +              */
> > > +             btrfs_pin_log_trans(root);
> > > +             btrfs_pin_log_trans(dest);
> > > +             logs_pinned = true;
> > > +     }
> > > +
> > >       if (old_dentry->d_parent != new_dentry->d_parent)
> > >               btrfs_record_unlink_dir(trans, BTRFS_I(old_dir),
> > >                                       BTRFS_I(old_inode), true);
> > > @@ -8528,7 +8571,7 @@ static int btrfs_rename(struct mnt_idmap *idmap,
> > >       if (old_inode->i_nlink == 1)
> > >               BTRFS_I(old_inode)->dir_index = index;
> > >
> > > -     if (old_ino != BTRFS_FIRST_FREE_OBJECTID)
> > > +     if (logs_pinned)
> > >               btrfs_log_new_name(trans, old_dentry, BTRFS_I(old_dir),
> > >                                  rename_ctx.index, new_dentry->d_parent);
> > >
> > > @@ -8544,6 +8587,10 @@ static int btrfs_rename(struct mnt_idmap *idmap,
> > >               }
> > >       }
> > >  out_fail:
> > > +     if (logs_pinned) {
> > > +             btrfs_end_log_trans(root);
> > > +             btrfs_end_log_trans(dest);
> > > +     }
> > >       ret2 = btrfs_end_transaction(trans);
> > >       ret = ret ? ret : ret2;
> > >  out_notrans:
> > > --
> > > 2.47.2
> > >

