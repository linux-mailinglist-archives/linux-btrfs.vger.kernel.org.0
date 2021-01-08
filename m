Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC192EF56B
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Jan 2021 17:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbhAHQDm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Jan 2021 11:03:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:40218 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726386AbhAHQDl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 8 Jan 2021 11:03:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3EC15ACC6;
        Fri,  8 Jan 2021 16:03:00 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C89EADA6E9; Fri,  8 Jan 2021 17:01:09 +0100 (CET)
Date:   Fri, 8 Jan 2021 17:01:09 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH v5 2/8] btrfs: only let one thread pre-flush delayed refs
 in commit
Message-ID: <20210108160109.GB6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Nikolay Borisov <nborisov@suse.com>
References: <cover.1608319304.git.josef@toxicpanda.com>
 <9e47b11bdfe5b4905fdaa81e952de2e2466c6335.1608319304.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e47b11bdfe5b4905fdaa81e952de2e2466c6335.1608319304.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 18, 2020 at 02:24:20PM -0500, Josef Bacik wrote:
> I've been running a stress test that runs 20 workers in their own
> subvolume, which are running an fsstress instance with 4 threads per
> worker, which is 80 total fsstress threads.  In addition to this I'm
> running balance in the background as well as creating and deleting
> snapshots.  This test takes around 12 hours to run normally, going
> slower and slower as the test goes on.
> 
> The reason for this is because fsstress is running fsync sometimes, and
> because we're messing with block groups we often fall through to
> btrfs_commit_transaction, so will often have 20-30 threads all calling
> btrfs_commit_transaction at the same time.
> 
> These all get stuck contending on the extent tree while they try to run
> delayed refs during the initial part of the commit.
> 
> This is suboptimal, really because the extent tree is a single point of
> failure we only want one thread acting on that tree at once to reduce
> lock contention.  Fix this by making the flushing mechanism a bit
> operation, to make it easy to use test_and_set_bit() in order to make
> sure only one task does this initial flush.
> 
> Once we're into the transaction commit we only have one thread doing
> delayed ref running, it's just this initial pre-flush that is
> problematic.  With this patch my stress test takes around 90 minutes to
> run, instead of 12 hours.
> 
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/delayed-ref.h | 12 ++++++------
>  fs/btrfs/transaction.c | 33 ++++++++++++++++-----------------
>  2 files changed, 22 insertions(+), 23 deletions(-)
> 
> diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
> index 1c977e6d45dc..6e414785b56f 100644
> --- a/fs/btrfs/delayed-ref.h
> +++ b/fs/btrfs/delayed-ref.h
> @@ -135,6 +135,11 @@ struct btrfs_delayed_data_ref {
>  	u64 offset;
>  };
>  
> +enum btrfs_delayed_ref_flags {
> +	/* Used to indicate that we are flushing delayed refs for the commit. */
> +	BTRFS_DELAYED_REFS_FLUSHING,
> +};
> +
>  struct btrfs_delayed_ref_root {
>  	/* head ref rbtree */
>  	struct rb_root_cached href_root;
> @@ -158,12 +163,7 @@ struct btrfs_delayed_ref_root {
>  
>  	u64 pending_csums;
>  
> -	/*
> -	 * set when the tree is flushing before a transaction commit,
> -	 * used by the throttling code to decide if new updates need
> -	 * to be run right away
> -	 */
> -	int flushing;
> +	unsigned long flags;
>  
>  	u64 run_delayed_start;
>  
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index f51f9e39bcee..ccd37fbe5db1 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -909,9 +909,9 @@ bool btrfs_should_end_transaction(struct btrfs_trans_handle *trans)
>  {
>  	struct btrfs_transaction *cur_trans = trans->transaction;
>  
> -	smp_mb();
>  	if (cur_trans->state >= TRANS_STATE_COMMIT_START ||
> -	    cur_trans->delayed_refs.flushing)
> +	    test_bit(BTRFS_DELAYED_REFS_FLUSHING,
> +		     &cur_trans->delayed_refs.flags))
>  		return true;
>  
>  	return should_end_transaction(trans);
> @@ -2043,23 +2043,22 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
>  	btrfs_trans_release_metadata(trans);
>  	trans->block_rsv = NULL;
>  
> -	/* make a pass through all the delayed refs we have so far
> -	 * any runnings procs may add more while we are here
> -	 */
> -	ret = btrfs_run_delayed_refs(trans, 0);
> -	if (ret) {
> -		btrfs_end_transaction(trans);
> -		return ret;
> -	}
> -
> -	cur_trans = trans->transaction;
> -
>  	/*
> -	 * set the flushing flag so procs in this transaction have to
> -	 * start sending their work down.
> +	 * We only want one transaction commit doing the flushing so we do not
> +	 * waste a bunch of time on lock contention on the extent root node.
>  	 */
> -	cur_trans->delayed_refs.flushing = 1;
> -	smp_wmb();

This barrier obviously separates the flushing = 1 and the rest of the
code, now implemented as test_and_set_bit, which implies full barrier.

However, hunk in btrfs_should_end_transaction removes the barrier and
I'm not sure whether this is correct:

-	smp_mb();
 	if (cur_trans->state >= TRANS_STATE_COMMIT_START ||
-	    cur_trans->delayed_refs.flushing)
+	    test_bit(BTRFS_DELAYED_REFS_FLUSHING,
+		     &cur_trans->delayed_refs.flags))
 		return true;

This is never called under locks so we don't have complete
synchronization of neither the transaction state nor the flushing bit.
btrfs_should_end_transaction is merely a hint and not called in critical
places so we could probably afford to keep it without a barrier, or keep
it with comment(s).
