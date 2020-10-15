Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54CD528F994
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Oct 2020 21:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391790AbgJOTgB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Oct 2020 15:36:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:49400 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391788AbgJOTgB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Oct 2020 15:36:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1602790559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=loZNunljh3oCkCnoIXZrFM/jazlvIwwpFEpIRYpTufk=;
        b=Lwhj9pKWqU94ikErRFt28AFzkT6Yg/b/avoCbyRqbNoPsy3FrM/rGsUe7gLs7Xg4oTIolS
        GvF9oSmgFjjwe8YBvu/yYqZIcO5M+OwUKN0qbos0jdu6FRDfoW/pnyvXRAziQAc/C2aiy6
        0W692+7zG2ZrLgvcjp/i1Xc7AdVPWos=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5F14EB18A;
        Thu, 15 Oct 2020 19:35:59 +0000 (UTC)
Subject: Re: [PATCH 2/6] btrfs: only let one thread pre-flush delayed refs in
 commit
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1602786206.git.josef@toxicpanda.com>
 <10113ed0453832382bc350f15758f871db43b5d9.1602786206.git.josef@toxicpanda.com>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <e68e524c-8e51-5381-79b9-bd7fd30a13aa@suse.com>
Date:   Thu, 15 Oct 2020 22:35:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <10113ed0453832382bc350f15758f871db43b5d9.1602786206.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 15.10.20 г. 21:25 ч., Josef Bacik wrote:
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
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/delayed-ref.h | 12 ++++++------
>  fs/btrfs/transaction.c | 32 ++++++++++++++++----------------
>  2 files changed, 22 insertions(+), 22 deletions(-)
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
> index 52ada47aff50..e8e706def41c 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -872,7 +872,8 @@ int btrfs_should_end_transaction(struct btrfs_trans_handle *trans)
>  
>  	smp_mb();

Is this memory barrier required now that you have removed the one in
btrfs_commit_transaction ?

>  	if (cur_trans->state >= TRANS_STATE_COMMIT_START ||
> -	    cur_trans->delayed_refs.flushing)
> +	    test_bit(BTRFS_DELAYED_REFS_FLUSHING,
> +		     &cur_trans->delayed_refs.flags))
>  		return 1;
>  
>  	return should_end_transaction(trans);
> @@ -2042,23 +2043,22 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
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
> +	if (!test_and_set_bit(BTRFS_DELAYED_REFS_FLUSHING,
> +			      &cur_trans->delayed_refs.flags)) {
> +		/*
> +		 * make a pass through all the delayed refs we have so far
> +		 * any runnings procs may add more while we are here
> +		 */
> +		ret = btrfs_run_delayed_refs(trans, 0);
> +		if (ret) {
> +			btrfs_end_transaction(trans);
> +			return ret;
> +		}
> +	}
>  
>  	btrfs_create_pending_block_groups(trans);
>  
> 
