Return-Path: <linux-btrfs+bounces-14398-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8C2ACBE08
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jun 2025 03:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C417B1890F4C
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jun 2025 01:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E2C72627;
	Tue,  3 Jun 2025 01:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="hNiLUikO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KaywLjJu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19D1A937
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Jun 2025 01:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748912598; cv=none; b=pS0sdZUsTjeCzSeAtmqyaUVq6N8z/ZtGbePyi++dYhR6bHQCnTc3mHDDdt1Ki61Se/zo3ots2JGK0Qs9+ughwOwrlzVVPG5pJbuZan0yrmrmGrxlAJ8O8QXlIo8hB/Uuk82zkzcLXGADsammA2D76JbiBvBfg3/KGeZpEjOUQ1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748912598; c=relaxed/simple;
	bh=pEYJl8EjIpnCdZG/BRtvxVN3GqBgc8i7iUmS07I++wE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=deIHGeBHHSxiIlMlK0p4xGm3djwcv6fiCtGxeOR+8X5O7QovKRSgRoNmcso5PcgD8y3+ZShK15bT3Vr+BFGZL6b3QX9n7ke7SlBRknLoWYnIdj1x2n0ylkaq/vpCx6Pj5uAiTfDzBPqNE0x06TJMrQsLlu3ZJEKJsRVm3cm5/0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=hNiLUikO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KaywLjJu; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 935B7254014A;
	Mon,  2 Jun 2025 21:03:12 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 02 Jun 2025 21:03:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1748912592; x=1748998992; bh=SLb2S7JL4D
	rowEBfgu+hDAD998J9zDEa0oh6qKqoYSw=; b=hNiLUikOGY6D2CogHA/Mnin13F
	kP2C8Btb3PQaqA4qzrVyE/gBLPW4hHpviynvbwUS9uqh9T3ZCSnuH2Cr4En6FCxk
	4xQ1bhvaCnwUYt1un+0Czih5e61GCgJKpzynMFavgqiKuXWNjyTidiOisBYFq/n4
	yI9sw3f4MqPvxRC5wq8xf4ZFOwb8BycpRBC/TJsOAj4YogMw4Dpi/Is+KIlSiuVe
	C8NijOBmSZDDVxMLDacioConDHacGH/0OdnKWJFtNX5oV/Aa0VEVO4r6b6xAVd4P
	uWDfPtVlggZ4JrQhVls9VAWrWXsQm86U5XyLEGKoDk/xxS78XPB5WnKhkUlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748912592; x=1748998992; bh=SLb2S7JL4DrowEBfgu+hDAD998J9zDEa0oh
	6qKqoYSw=; b=KaywLjJuuYZgUBfkC14cGT8D2F1Eqnh7BBSTHfEK3zDOOgOvV3s
	piot015RcqJJXqDU8BSmvbGfebAFpftW/c+osfArFQPeUv8hSORQGJh4fMu+ebLp
	E8ll/4LsTIEiRHv/SxIcaLMrwAVOBJfPOZnNf0nI99lHOS/NOt7usKlct6wJWIqK
	7Dqe3t19VENQHphc5bdV3mbSdOPRLJFuqA280nHZLTixAQcCUGcxThulUPOa3awo
	zgLzJdcwrBvTx7Vc7TqHT1nHC31hJFIJrjqQ01B2AIFhacGbvgncgkwhxPVrNsBX
	pJPdCAIKqtp2s0B359Ea/3LWEaEW2FMCI6A==
X-ME-Sender: <xms:0Ek-aMrK9P6KfLO5hWLgdHZgiWmom4fpiG2hTRDR9uZyticg096PZw>
    <xme:0Ek-aCrwmeKQA2vp_bmRfPBY3gOCulo4RIzUN_wgK4BSnwoH0aKQ6qGKv1VBHEV8e
    1s_2arYxUOw5CLUy7c>
X-ME-Received: <xmr:0Ek-aBNWaZMvGo3n0XO_WNnauXTUTqnu3CZW-sL59jBaoOdGZHI7J7yhwLQQqemMozR6dloydINgTcf_r9mfzH0k2O4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefledukeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhep
    uehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtth
    gvrhhnpeekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeel
    jeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hrihhssegsuhhrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepfhgumhgrnhgrnhgrsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:0Ek-aD4kln8BrTStXffrF0o7QKLmDpTYrjXCos1OQt_hJymomeWS_Q>
    <xmx:0Ek-aL7m6KDOi_SdEP116omVvPgxmPRrndZIOwjAy9ZgIonaUWFINQ>
    <xmx:0Ek-aDiPh74LW-ycYE5ltWQJy_uNRaWkwOkZt_yZp9ndK1uvOnle6g>
    <xmx:0Ek-aF7cofQXC2kwOSBwrahOUIK2jJkKutJXyfJf0fQZl3ni7HwKig>
    <xmx:0Ek-aInM2rZik-XUKD6FgnwrPTw5wFovzBn5_PtoV5NgYoAuqQF3AYlx>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Jun 2025 21:03:11 -0400 (EDT)
Date: Mon, 2 Jun 2025 18:03:10 -0700
From: Boris Burkov <boris@bur.io>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 01/14] btrfs: fix a race between renames and directory
 logging
Message-ID: <20250603010310.GA1509461@zen.localdomain>
References: <cover.1748789125.git.fdmanana@suse.com>
 <10075404e05fae4f219cd308bff91a25ac3bd6fe.1748789125.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10075404e05fae4f219cd308bff91a25ac3bd6fe.1748789125.git.fdmanana@suse.com>

On Mon, Jun 02, 2025 at 11:32:54AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> We have a race between a rename and directory inode logging that if it
> happens and we crash/power fail before the rename completes, the next time
> the filesystem is mounted, the log replay code will end up deleting the
> file that was being renamed.
> 
> This is best explained following a step by step analysis of an interleaving
> of steps that lead into this situation.
> 
> Consider the initial conditions:
> 
> 1) We are at transaction N;
> 
> 2) We have directories A and B created in a past transaction (< N);
> 
> 3) We have inode X corresponding to a file that has 2 hardlinks, one in
>    directory A and the other in directory B, so we'll name them as
>    "A/foo_link1" and "B/foo_link2". Both hard links were persisted in a
>    past transaction (< N);
> 
> 4) We have inode Y corresponding to a file that as a single hard link and
>    is located in directory A, we'll name it as "A/bar". This file was also
>    persisted in a past transaction (< N).
> 
> The steps leading to a file loss are the following and for all of them we
> are under transaction N:
> 
>  1) Link "A/foo_link1" is removed, so inode's X last_unlink_trans field
>     is updated to N, through btrfs_unlink() -> btrfs_record_unlink_dir();
> 
>  2) Task A starts a rename for inode Y, with the goal of renaming from
>     "A/bar" to "A/baz", so we enter btrfs_rename();
> 
>  3) Task A inserts the new BTRFS_INODE_REF_KEY for inode Y by calling
>     btrfs_insert_inode_ref();
> 
>  4) Because the rename happens in the same directory, we don't set the
>     last_unlink_trans field of directoty A's inode to the current
>     transaction id, that is, we don't cal btrfs_record_unlink_dir();

Presumably, an alternative fix would be to also call
btrfs_record_unlink_dir() for same directory renames? However, it seems
like pinning the log commit for the duration of the rename is going to
be faster than falling back to a full transaction commit.

Did I understand the rationale correctly?

> 
>  5) Task A then removes the entries from directory A (BTRFS_DIR_ITEM_KEY
>     and BTRFS_DIR_INDEX_KEY items) when calling __btrfs_unlink_inode()
>     (actually the dir index item is added as a delayed item, but the
>     effect is the same);
> 
>  6) Now before task A adds the new entry "A/baz" to directory A by
>     calling btrfs_add_link(), another task, task B is logging inode X;
> 
>  7) Task B starts a fsync of inode X and after logging inode X, at
>     btrfs_log_inode_parent() it calls btrfs_log_all_parents(), since
>     inode X has a last_unlink_trans value of N, set at in step 1;
> 
>  8) At btrfs_log_all_parents() we search for all parent directories of
>     inode X using the commit root, so we find directories A and B and log
>     them. Bu when logging direct A, we don't have a dir index item for
>     inode Y anymore, neither the old name "A/bar" nor for the new name
>     "A/baz" since the rename has deleted the old name but has not yet
>     inserted the new name - task A hasn't called yet btrfs_add_link() to
>     do that.
> 
>     Note that logging directory A doesn't fallback to a transaction
>     commit because its last_unlink_trans has a lower value than the
>     current transaction's id (see step 4);
> 
>  9) Task B finishes logging directories A and B and gets back to
>     btrfs_sync_file() where it calls btrfs_sync_log() to persist the log
>     tree;
> 
> 10) Task B successfully persisted the log tree, btrfs_sync_log() completed
>     with success, and a power failure happened.
> 
>     We have a log tree without any directory entry for inode Y, so the
>     log replay code deletes the entry for inode Y, name "A/bar", from the
>     subvolume tree since it doesn't exist in the log tree and the log
>     tree is authorative for its index (we logged a BTRFS_DIR_LOG_INDEX_KEY
>     item that covers the index range for the dentry that corresponds to
>     "A/bar").
> 
>     Since there's no other hard link for inode Y and the log replay code
>     deletes the name "A/bar", the file is lost.
> 
> The issue wouldn't happen if task B synced the log only after task A
> called btrfs_log_new_name(), which would update the log with the new name
> for inode Y ("A/bar").
> 
> Fix this by pinning the log root during renames before removing the old
> directory entry, and unpinning after btrfs_log_new_name() is called.
> 
> Fixes: 259c4b96d78d ("btrfs: stop doing unnecessary log updates during a rename")
> CC: stable@vger.kernel.org # 5.18+
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

The explanation and fix make sense to me, thanks.
Reviewed-by: Boris Burkov <boris@bur.io>

One qq: would it be possible / make sense to have an absolutely minimal
fix patch that only restores the log pinning order (as changed by
259c4b96d78d) without the additional refactoring of the subvol root
checking logic (i.e., getting rid of the per-root pin tracking bools)?
Then separately do that refactoring?

> ---
>  fs/btrfs/inode.c | 81 ++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 64 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 7074f975c033..7bad21ec41f8 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -8063,6 +8063,7 @@ static int btrfs_rename_exchange(struct inode *old_dir,
>  	int ret;
>  	int ret2;
>  	bool need_abort = false;
> +	bool logs_pinned = false;
>  	struct fscrypt_name old_fname, new_fname;
>  	struct fscrypt_str *old_name, *new_name;
>  
> @@ -8186,6 +8187,31 @@ static int btrfs_rename_exchange(struct inode *old_dir,
>  	inode_inc_iversion(new_inode);
>  	simple_rename_timestamp(old_dir, old_dentry, new_dir, new_dentry);
>  
> +	if (old_ino != BTRFS_FIRST_FREE_OBJECTID &&
> +	    new_ino != BTRFS_FIRST_FREE_OBJECTID) {
> +		/*
> +		 * If we are renaming in the same directory (and it's not for
> +		 * root entries) pin the log early to prevent any concurrent
> +		 * task from logging the directory after we removed the old
> +		 * entries and before we add the new entries, otherwise that
> +		 * task can sync a log without any entry for the inodes we are
> +		 * renaming and therefore replaying that log, if a power failure
> +		 * happens after syncing the log, would result in deleting the
> +		 * inodes.
> +		 *
> +		 * If the rename affects two different directories, we want to
> +		 * make sure the that there's no log commit that contains
> +		 * updates for only one of the directories but not for the
> +		 * other.
> +		 *
> +		 * If we are renaming an entry for a root, we don't care about
> +		 * log updates since we called btrfs_set_log_full_commit().
> +		 */
> +		btrfs_pin_log_trans(root);
> +		btrfs_pin_log_trans(dest);
> +		logs_pinned = true;
> +	}
> +
>  	if (old_dentry->d_parent != new_dentry->d_parent) {
>  		btrfs_record_unlink_dir(trans, BTRFS_I(old_dir),
>  					BTRFS_I(old_inode), true);
> @@ -8257,30 +8283,23 @@ static int btrfs_rename_exchange(struct inode *old_dir,
>  		BTRFS_I(new_inode)->dir_index = new_idx;
>  
>  	/*
> -	 * Now pin the logs of the roots. We do it to ensure that no other task
> -	 * can sync the logs while we are in progress with the rename, because
> -	 * that could result in an inconsistency in case any of the inodes that
> -	 * are part of this rename operation were logged before.
> +	 * Do the log updates for all inodes.
> +	 *
> +	 * If either entry is for a root we don't need to update the logs since
> +	 * we've called btrfs_set_log_full_commit() before.
>  	 */
> -	if (old_ino != BTRFS_FIRST_FREE_OBJECTID)
> -		btrfs_pin_log_trans(root);
> -	if (new_ino != BTRFS_FIRST_FREE_OBJECTID)
> -		btrfs_pin_log_trans(dest);
> -
> -	/* Do the log updates for all inodes. */
> -	if (old_ino != BTRFS_FIRST_FREE_OBJECTID)
> +	if (logs_pinned) {
>  		btrfs_log_new_name(trans, old_dentry, BTRFS_I(old_dir),
>  				   old_rename_ctx.index, new_dentry->d_parent);
> -	if (new_ino != BTRFS_FIRST_FREE_OBJECTID)
>  		btrfs_log_new_name(trans, new_dentry, BTRFS_I(new_dir),
>  				   new_rename_ctx.index, old_dentry->d_parent);
> +	}
>  
> -	/* Now unpin the logs. */
> -	if (old_ino != BTRFS_FIRST_FREE_OBJECTID)
> +out_fail:
> +	if (logs_pinned) {
>  		btrfs_end_log_trans(root);
> -	if (new_ino != BTRFS_FIRST_FREE_OBJECTID)
>  		btrfs_end_log_trans(dest);
> -out_fail:
> +	}
>  	ret2 = btrfs_end_transaction(trans);
>  	ret = ret ? ret : ret2;
>  out_notrans:
> @@ -8330,6 +8349,7 @@ static int btrfs_rename(struct mnt_idmap *idmap,
>  	int ret2;
>  	u64 old_ino = btrfs_ino(BTRFS_I(old_inode));
>  	struct fscrypt_name old_fname, new_fname;
> +	bool logs_pinned = false;
>  
>  	if (btrfs_ino(BTRFS_I(new_dir)) == BTRFS_EMPTY_SUBVOL_DIR_OBJECTID)
>  		return -EPERM;
> @@ -8464,6 +8484,29 @@ static int btrfs_rename(struct mnt_idmap *idmap,
>  	inode_inc_iversion(old_inode);
>  	simple_rename_timestamp(old_dir, old_dentry, new_dir, new_dentry);
>  
> +	if (old_ino != BTRFS_FIRST_FREE_OBJECTID) {
> +		/*
> +		 * If we are renaming in the same directory (and it's not a
> +		 * root entry) pin the log to prevent any concurrent task from
> +		 * logging the directory after we removed the old entry and
> +		 * before we add the new entry, otherwise that task can sync
> +		 * a log without any entry for the inode we are renaming and
> +		 * therefore replaying that log, if a power failure happens
> +		 * after syncing the log, would result in deleting the inode.
> +		 *
> +		 * If the rename affects two different directories, we want to
> +		 * make sure the that there's no log commit that contains
> +		 * updates for only one of the directories but not for the
> +		 * other.
> +		 *
> +		 * If we are renaming an entry for a root, we don't care about
> +		 * log updates since we called btrfs_set_log_full_commit().
> +		 */
> +		btrfs_pin_log_trans(root);
> +		btrfs_pin_log_trans(dest);
> +		logs_pinned = true;
> +	}
> +
>  	if (old_dentry->d_parent != new_dentry->d_parent)
>  		btrfs_record_unlink_dir(trans, BTRFS_I(old_dir),
>  					BTRFS_I(old_inode), true);
> @@ -8528,7 +8571,7 @@ static int btrfs_rename(struct mnt_idmap *idmap,
>  	if (old_inode->i_nlink == 1)
>  		BTRFS_I(old_inode)->dir_index = index;
>  
> -	if (old_ino != BTRFS_FIRST_FREE_OBJECTID)
> +	if (logs_pinned)
>  		btrfs_log_new_name(trans, old_dentry, BTRFS_I(old_dir),
>  				   rename_ctx.index, new_dentry->d_parent);
>  
> @@ -8544,6 +8587,10 @@ static int btrfs_rename(struct mnt_idmap *idmap,
>  		}
>  	}
>  out_fail:
> +	if (logs_pinned) {
> +		btrfs_end_log_trans(root);
> +		btrfs_end_log_trans(dest);
> +	}
>  	ret2 = btrfs_end_transaction(trans);
>  	ret = ret ? ret : ret2;
>  out_notrans:
> -- 
> 2.47.2
> 

