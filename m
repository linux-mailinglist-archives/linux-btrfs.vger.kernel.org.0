Return-Path: <linux-btrfs+bounces-6303-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FBE92A911
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jul 2024 20:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68EEA1F21B59
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jul 2024 18:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F9F14BF9B;
	Mon,  8 Jul 2024 18:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="okIw/pzu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B5D15A8;
	Mon,  8 Jul 2024 18:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720463976; cv=none; b=D1wfhtUj6YlH06yHZV0TZd2Fb9UEbteg6oGE+WOmXGcgfoOtI7P2lYJi7FJR/3qk7K+jT6W0wc6bqqIDZOgJWZXhz0dJFzajFT69i3DKxeY6BOh9Mr2/1opHTG4/cAF6Q/hrLNwYHySUWRlZZJ9lmYCAVa5+z6Mtv8BDkHUGYfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720463976; c=relaxed/simple;
	bh=ZfuNEYoOqOCSPJu9L+u4555sPJkVhSKzoTzDgt8B10g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uoYNjFc6Pw0zk8WJmgn5oqvv+1AA1k4+P07zLxI3TAVrIKT2bFAvIrQcDQRKgx2nviAjlZm2a6Cdc8K86rHccckyVnm9bmuTJCcl9fgvOKeR+zCOZhH4BPpnnwluLETC10Xn9z9gxpuqxFa43oO0VCBxPckVzK3JvooHb5Y4LWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=okIw/pzu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55F1AC116B1;
	Mon,  8 Jul 2024 18:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720463975;
	bh=ZfuNEYoOqOCSPJu9L+u4555sPJkVhSKzoTzDgt8B10g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=okIw/pzu3JfDI+SuRjRu6Lg2fZp59TABGNHzWtUMXi1yiV4im/7vbZvhr+yHyclWu
	 b8pj1cCt7+dMkS3EMoClZpGKx4pIifLewsXrJj0jeCWztHaFeGJuioiwLFr3zN7Cvq
	 F3ItIeCLtLwxhVCCaQvYTNKCIDaRbIcE+1VfvIN6mB0xOKOsV3dJUKK98XJN11zozX
	 mZcawitHcP+3XP7RpcCbizP7HI0NE46D5X4wpRj8Mw/FJLB/17Tdyl8a+GvYD/7Wlu
	 BqU8lVjWdx5gBP9TT1NDxEPhAg8Q7g1i58kXCA+/jDlt9rD6c7jEQjPvlBPbat14TE
	 PeJy0uSWkPq3A==
Date: Mon, 8 Jul 2024 11:39:34 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Dave Chinner <david@fromorbit.com>, Andi Kleen <ak@linux.intel.com>,
	Christoph Hellwig <hch@infradead.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Kent Overstreet <kent.overstreet@linux.dev>, kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org, linux-nfs@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 1/9] fs: add infrastructure for multigrain timestamps
Message-ID: <20240708183934.GO612460@frogsfrogsfrogs>
References: <20240708-mgtime-v4-0-a0f3c6fb57f3@kernel.org>
 <20240708-mgtime-v4-1-a0f3c6fb57f3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240708-mgtime-v4-1-a0f3c6fb57f3@kernel.org>

On Mon, Jul 08, 2024 at 11:53:34AM -0400, Jeff Layton wrote:
> The VFS has always used coarse-grained timestamps when updating the
> ctime and mtime after a change. This has the benefit of allowing
> filesystems to optimize away a lot metadata updates, down to around 1
> per jiffy, even when a file is under heavy writes.
> 
> Unfortunately, this has always been an issue when we're exporting via
> NFSv3, which relies on timestamps to validate caches. A lot of changes
> can happen in a jiffy, so timestamps aren't sufficient to help the
> client decide when to invalidate the cache. Even with NFSv4, a lot of
> exported filesystems don't properly support a change attribute and are
> subject to the same problems with timestamp granularity. Other
> applications have similar issues with timestamps (e.g backup
> applications).
> 
> If we were to always use fine-grained timestamps, that would improve the
> situation, but that becomes rather expensive, as the underlying
> filesystem would have to log a lot more metadata updates.
> 
> What we need is a way to only use fine-grained timestamps when they are
> being actively queried. Use the (unused) top bit in inode->i_ctime_nsec
> as a flag that indicates whether the current timestamps have been
> queried via stat() or the like. When it's set, we allow the kernel to
> use a fine-grained timestamp iff it's necessary to make the ctime show
> a different value.

I appreciate the v3->v4 change that we hide the QUERIED flag in the
upper bit of the ctime nanoseconds, instead of all support for post-2262
timestamps.  Thank you. :)

> This solves the problem of being able to distinguish the timestamp
> between updates, but introduces a new problem: it's now possible for a
> file being changed to get a fine-grained timestamp. A file that is
> altered just a bit later can then get a coarse-grained one that appears
> older than the earlier fine-grained time. This violates timestamp
> ordering guarantees.
> 
> To remedy this, keep a global monotonic ktime_t value that acts as a
> timestamp floor.  When we go to stamp a file, we first get the latter of
> the current floor value and the current coarse-grained time. If the
> inode ctime hasn't been queried then we just attempt to stamp it with
> that value.
> 
> If it has been queried, then first see whether the current coarse time
> is later than the existing ctime. If it is, then we accept that value.
> If it isn't, then we get a fine-grained time and try to swap that into
> the global floor. Whether that succeeds or fails, we take the resulting
> floor time, convert it to realtime and try to swap that into the ctime.

Makes sense to me.  One question, though -- mgtime filesystems that want
to persist a ctime to disk are going to have to do something like this,
right?

di_ctime_ns = cpu_to_be32(atomic_read(&inode->i_ctime_nsec) &
			  ~I_CTIME_QUERIED);

IOWs, they need to mask off the QUERIED flag (aka bit 31) so that they
never store a strange looking nanoseconds value.  Probably they should
already be doing this, but I wouldn't trust them already to be clamping
the nsec value.

I'm mostly thinking of xfs_inode_to_disk, which currently calls
inode_get_ctime() but doesn't clamp nsec at all before writing it to
disk.  Does that need to mask off I_CTIME_QUERIED explicitly?

> We take the result of the ctime swap whether it succeeds or fails, since
> either is just as valid.
> 
> Filesystems can opt into this by setting the FS_MGTIME fstype flag.
> Others should be unaffected (other than being subject to the same floor
> value as multigrain filesystems).
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/inode.c         | 171 ++++++++++++++++++++++++++++++++++++++++++++---------
>  fs/stat.c          |  36 ++++++++++-
>  include/linux/fs.h |  34 ++++++++---
>  3 files changed, 204 insertions(+), 37 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index f356fe2ec2b6..10ed1d3d9b52 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -60,6 +60,13 @@ static unsigned int i_hash_shift __ro_after_init;
>  static struct hlist_head *inode_hashtable __ro_after_init;
>  static __cacheline_aligned_in_smp DEFINE_SPINLOCK(inode_hash_lock);
>  
> +/*
> + * This represents the latest fine-grained time that we have handed out as a
> + * timestamp on the system. Tracked as a monotonic value, and converted to the
> + * realtime clock on an as-needed basis.
> + */
> +static __cacheline_aligned_in_smp ktime_t ctime_floor;

ktime_get claims that it stops when the system is suspended; will that
cause problems after a resume?  I /think/ the answer is no because any
change to the file after a resume will first determine the coarse grain
ctime value, which will be far beyond the floor.  The new coarse grain
ctime will be written to the inode and become the new floor, as provided
by coarse_ctime().

The rest of the code here makes sense to me.

--D

> +
>  /*
>   * Empty aops. Can be used for the cases where the user does not
>   * define any of the address_space operations.
> @@ -2127,19 +2134,72 @@ int file_remove_privs(struct file *file)
>  }
>  EXPORT_SYMBOL(file_remove_privs);
>  
> +/**
> + * coarse_ctime - return the current coarse-grained time
> + * @floor: current (monotonic) ctime_floor value
> + *
> + * Get the coarse-grained time, and then determine whether to
> + * return it or the current floor value. Returns the later of the
> + * floor and coarse grained timestamps, converted to realtime
> + * clock value.
> + */
> +static ktime_t coarse_ctime(ktime_t floor)
> +{
> +	ktime_t coarse = ktime_get_coarse();
> +
> +	/* If coarse time is already newer, return that */
> +	if (!ktime_after(floor, coarse))
> +		return ktime_mono_to_real(coarse);
> +	return ktime_mono_to_real(floor);
> +}
> +
> +/**
> + * current_time - Return FS time (possibly fine-grained)
> + * @inode: inode.
> + *
> + * Return the current time truncated to the time granularity supported by
> + * the fs, as suitable for a ctime/mtime change. If the ctime is flagged
> + * as having been QUERIED, get a fine-grained timestamp.
> + */
> +struct timespec64 current_time(struct inode *inode)
> +{
> +	ktime_t floor = smp_load_acquire(&ctime_floor);
> +	ktime_t now = coarse_ctime(floor);
> +	struct timespec64 now_ts = ktime_to_timespec64(now);
> +	u32 cns;
> +
> +	if (!is_mgtime(inode))
> +		goto out;
> +
> +	/* If nothing has queried it, then coarse time is fine */
> +	cns = smp_load_acquire(&inode->i_ctime_nsec);
> +	if (cns & I_CTIME_QUERIED) {
> +		/*
> +		 * If there is no apparent change, then
> +		 * get a fine-grained timestamp.
> +		 */
> +		if (now_ts.tv_nsec == (cns & ~I_CTIME_QUERIED))
> +			ktime_get_real_ts64(&now_ts);
> +	}
> +out:
> +	return timestamp_truncate(now_ts, inode);
> +}
> +EXPORT_SYMBOL(current_time);
> +
>  static int inode_needs_update_time(struct inode *inode)
>  {
> +	struct timespec64 now, ts;
>  	int sync_it = 0;
> -	struct timespec64 now = current_time(inode);
> -	struct timespec64 ts;
>  
>  	/* First try to exhaust all avenues to not sync */
>  	if (IS_NOCMTIME(inode))
>  		return 0;
>  
> +	now = current_time(inode);
> +
>  	ts = inode_get_mtime(inode);
>  	if (!timespec64_equal(&ts, &now))
> -		sync_it = S_MTIME;
> +		sync_it |= S_MTIME;
>  
>  	ts = inode_get_ctime(inode);
>  	if (!timespec64_equal(&ts, &now))
> @@ -2507,6 +2567,14 @@ void inode_nohighmem(struct inode *inode)
>  }
>  EXPORT_SYMBOL(inode_nohighmem);
>  
> +struct timespec64 inode_set_ctime_to_ts(struct inode *inode, struct timespec64 ts)
> +{
> +	inode->i_ctime_sec = ts.tv_sec;
> +	inode->i_ctime_nsec = ts.tv_nsec & ~I_CTIME_QUERIED;
> +	return ts;
> +}
> +EXPORT_SYMBOL(inode_set_ctime_to_ts);
> +
>  /**
>   * timestamp_truncate - Truncate timespec to a granularity
>   * @t: Timespec
> @@ -2538,38 +2606,87 @@ struct timespec64 timestamp_truncate(struct timespec64 t, struct inode *inode)
>  }
>  EXPORT_SYMBOL(timestamp_truncate);
>  
> -/**
> - * current_time - Return FS time
> - * @inode: inode.
> - *
> - * Return the current time truncated to the time granularity supported by
> - * the fs.
> - *
> - * Note that inode and inode->sb cannot be NULL.
> - * Otherwise, the function warns and returns time without truncation.
> - */
> -struct timespec64 current_time(struct inode *inode)
> -{
> -	struct timespec64 now;
> -
> -	ktime_get_coarse_real_ts64(&now);
> -	return timestamp_truncate(now, inode);
> -}
> -EXPORT_SYMBOL(current_time);
> -
>  /**
>   * inode_set_ctime_current - set the ctime to current_time
>   * @inode: inode
>   *
> - * Set the inode->i_ctime to the current value for the inode. Returns
> - * the current value that was assigned to i_ctime.
> + * Set the inode's ctime to the current value for the inode. Returns the
> + * current value that was assigned. If this is not a multigrain inode, then we
> + * just set it to whatever the coarse_ctime is.
> + *
> + * If it is multigrain, then we first see if the coarse-grained timestamp is
> + * distinct from what we have. If so, then we'll just use that. If we have to
> + * get a fine-grained timestamp, then do so, and try to swap it into the floor.
> + * We accept the new floor value regardless of the outcome of the cmpxchg.
> + * After that, we try to swap the new value into i_ctime_nsec. Again, we take
> + * the resulting ctime, regardless of the outcome of the swap.
>   */
>  struct timespec64 inode_set_ctime_current(struct inode *inode)
>  {
> -	struct timespec64 now = current_time(inode);
> +	ktime_t now, floor = smp_load_acquire(&ctime_floor);
> +	struct timespec64 now_ts;
> +	u32 cns, cur;
> +
> +	now = coarse_ctime(floor);
>  
> -	inode_set_ctime_to_ts(inode, now);
> -	return now;
> +	/* Just return that if this is not a multigrain fs */
> +	if (!is_mgtime(inode)) {
> +		now_ts = ktime_to_timespec64(now);
> +		inode_set_ctime_to_ts(inode, now_ts);
> +		goto out;
> +	}
> +
> +	/*
> +	 * We only need a fine-grained time if someone has queried it,
> +	 * and the current coarse grained time isn't later than what's
> +	 * already there.
> +	 */
> +	cns = smp_load_acquire(&inode->i_ctime_nsec);
> +	if (cns & I_CTIME_QUERIED) {
> +		ktime_t ctime = ktime_set(inode->i_ctime_sec, cns & ~I_CTIME_QUERIED);
> +
> +		if (!ktime_after(now, ctime)) {
> +			ktime_t old, fine;
> +
> +			/* Get a fine-grained time */
> +			fine = ktime_get();
> +
> +			/*
> +			 * If the cmpxchg works, we take the new floor value. If
> +			 * not, then that means that someone else changed it after we
> +			 * fetched it but before we got here. That value is just
> +			 * as good, so keep it.
> +			 */
> +			old = floor;
> +			if (!try_cmpxchg(&ctime_floor, &old, fine))
> +				fine = old;
> +			now = ktime_mono_to_real(fine);
> +		}
> +	}
> +	now_ts = ktime_to_timespec64(now);
> +	cur = cns;
> +retry:
> +	/* Try to swap the nsec value into place. */
> +	if (try_cmpxchg(&inode->i_ctime_nsec, &cur, now_ts.tv_nsec)) {
> +		/* If swap occurred, then we're (mostly) done */
> +		inode->i_ctime_sec = now_ts.tv_sec;
> +	} else {
> +		/*
> +		 * Was the change due to someone marking the old ctime QUERIED?
> +		 * If so then retry the swap. This can only happen once since
> +		 * the only way to clear I_CTIME_QUERIED is to stamp the inode
> +		 * with a new ctime.
> +		 */
> +		if (!(cns & I_CTIME_QUERIED) && (cns | I_CTIME_QUERIED) == cur) {
> +			cns = cur;
> +			goto retry;
> +		}
> +		/* Otherwise, keep the existing ctime */
> +		now_ts.tv_sec = inode->i_ctime_sec;
> +		now_ts.tv_nsec = cur & ~I_CTIME_QUERIED;
> +	}
> +out:
> +	return timestamp_truncate(now_ts, inode);
>  }
>  EXPORT_SYMBOL(inode_set_ctime_current);
>  
> diff --git a/fs/stat.c b/fs/stat.c
> index 6f65b3456cad..df7fdd3afed9 100644
> --- a/fs/stat.c
> +++ b/fs/stat.c
> @@ -26,6 +26,32 @@
>  #include "internal.h"
>  #include "mount.h"
>  
> +/**
> + * fill_mg_cmtime - Fill in the mtime and ctime and flag ctime as QUERIED
> + * @stat: where to store the resulting values
> + * @request_mask: STATX_* values requested
> + * @inode: inode from which to grab the c/mtime
> + *
> + * Given @inode, grab the ctime and mtime out if it and store the result
> + * in @stat. When fetching the value, flag it as queried so the next write
> + * will ensure a distinct timestamp.
> + */
> +void fill_mg_cmtime(struct kstat *stat, u32 request_mask, struct inode *inode)
> +{
> +	atomic_t *pcn = (atomic_t *)&inode->i_ctime_nsec;
> +
> +	/* If neither time was requested, then don't report them */
> +	if (!(request_mask & (STATX_CTIME|STATX_MTIME))) {
> +		stat->result_mask &= ~(STATX_CTIME|STATX_MTIME);
> +		return;
> +	}
> +
> +	stat->mtime = inode_get_mtime(inode);
> +	stat->ctime.tv_sec = inode->i_ctime_sec;
> +	stat->ctime.tv_nsec = ((u32)atomic_fetch_or(I_CTIME_QUERIED, pcn)) & ~I_CTIME_QUERIED;
> +}
> +EXPORT_SYMBOL(fill_mg_cmtime);
> +
>  /**
>   * generic_fillattr - Fill in the basic attributes from the inode struct
>   * @idmap:		idmap of the mount the inode was found from
> @@ -58,8 +84,14 @@ void generic_fillattr(struct mnt_idmap *idmap, u32 request_mask,
>  	stat->rdev = inode->i_rdev;
>  	stat->size = i_size_read(inode);
>  	stat->atime = inode_get_atime(inode);
> -	stat->mtime = inode_get_mtime(inode);
> -	stat->ctime = inode_get_ctime(inode);
> +
> +	if (is_mgtime(inode)) {
> +		fill_mg_cmtime(stat, request_mask, inode);
> +	} else {
> +		stat->ctime = inode_get_ctime(inode);
> +		stat->mtime = inode_get_mtime(inode);
> +	}
> +
>  	stat->blksize = i_blocksize(inode);
>  	stat->blocks = inode->i_blocks;
>  
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index dc9f9c4b2572..f873f6c58669 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1608,6 +1608,17 @@ static inline struct timespec64 inode_set_mtime(struct inode *inode,
>  	return inode_set_mtime_to_ts(inode, ts);
>  }
>  
> +/*
> + * Multigrain timestamps
> + *
> + * Conditionally use fine-grained ctime and mtime timestamps when there
> + * are users actively observing them via getattr. The primary use-case
> + * for this is NFS clients that use the ctime to distinguish between
> + * different states of the file, and that are often fooled by multiple
> + * operations that occur in the same coarse-grained timer tick.
> + */
> +#define I_CTIME_QUERIED		((u32)BIT(31))
> +
>  static inline time64_t inode_get_ctime_sec(const struct inode *inode)
>  {
>  	return inode->i_ctime_sec;
> @@ -1615,7 +1626,7 @@ static inline time64_t inode_get_ctime_sec(const struct inode *inode)
>  
>  static inline long inode_get_ctime_nsec(const struct inode *inode)
>  {
> -	return inode->i_ctime_nsec;
> +	return inode->i_ctime_nsec & ~I_CTIME_QUERIED;
>  }
>  
>  static inline struct timespec64 inode_get_ctime(const struct inode *inode)
> @@ -1626,13 +1637,7 @@ static inline struct timespec64 inode_get_ctime(const struct inode *inode)
>  	return ts;
>  }
>  
> -static inline struct timespec64 inode_set_ctime_to_ts(struct inode *inode,
> -						      struct timespec64 ts)
> -{
> -	inode->i_ctime_sec = ts.tv_sec;
> -	inode->i_ctime_nsec = ts.tv_nsec;
> -	return ts;
> -}
> +struct timespec64 inode_set_ctime_to_ts(struct inode *inode, struct timespec64 ts);
>  
>  /**
>   * inode_set_ctime - set the ctime in the inode
> @@ -2490,6 +2495,7 @@ struct file_system_type {
>  #define FS_USERNS_MOUNT		8	/* Can be mounted by userns root */
>  #define FS_DISALLOW_NOTIFY_PERM	16	/* Disable fanotify permission events */
>  #define FS_ALLOW_IDMAP         32      /* FS has been updated to handle vfs idmappings. */
> +#define FS_MGTIME		64	/* FS uses multigrain timestamps */
>  #define FS_RENAME_DOES_D_MOVE	32768	/* FS will handle d_move() during rename() internally. */
>  	int (*init_fs_context)(struct fs_context *);
>  	const struct fs_parameter_spec *parameters;
> @@ -2513,6 +2519,17 @@ struct file_system_type {
>  
>  #define MODULE_ALIAS_FS(NAME) MODULE_ALIAS("fs-" NAME)
>  
> +/**
> + * is_mgtime: is this inode using multigrain timestamps
> + * @inode: inode to test for multigrain timestamps
> + *
> + * Return true if the inode uses multigrain timestamps, false otherwise.
> + */
> +static inline bool is_mgtime(const struct inode *inode)
> +{
> +	return inode->i_sb->s_type->fs_flags & FS_MGTIME;
> +}
> +
>  extern struct dentry *mount_bdev(struct file_system_type *fs_type,
>  	int flags, const char *dev_name, void *data,
>  	int (*fill_super)(struct super_block *, void *, int));
> @@ -3252,6 +3269,7 @@ extern void page_put_link(void *);
>  extern int page_symlink(struct inode *inode, const char *symname, int len);
>  extern const struct inode_operations page_symlink_inode_operations;
>  extern void kfree_link(void *);
> +void fill_mg_cmtime(struct kstat *stat, u32 request_mask, struct inode *inode);
>  void generic_fillattr(struct mnt_idmap *, u32, struct inode *, struct kstat *);
>  void generic_fill_statx_attr(struct inode *inode, struct kstat *stat);
>  extern int vfs_getattr_nosec(const struct path *, struct kstat *, u32, unsigned int);
> 
> -- 
> 2.45.2
> 
> 

