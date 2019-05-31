Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6595330A48
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 May 2019 10:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbfEaI3h (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 May 2019 04:29:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:51482 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725963AbfEaI3h (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 May 2019 04:29:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6FFB5AB5F
        for <linux-btrfs@vger.kernel.org>; Fri, 31 May 2019 08:29:35 +0000 (UTC)
Subject: Re: [PATCH 1/3] btrfs: switch extent_buffer blocking_writers from
 atomic to int
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1559233731.git.dsterba@suse.com>
 <ebba72a9ef564b27fb5f652e3edcfbca3e981a10.1559233731.git.dsterba@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <ed094516-d79b-0981-5f1e-52002db1d874@suse.com>
Date:   Fri, 31 May 2019 11:29:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <ebba72a9ef564b27fb5f652e3edcfbca3e981a10.1559233731.git.dsterba@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 30.05.19 г. 19:31 ч., David Sterba wrote:
> The blocking_writers is either 0 or 1 and always updated under the lock,
> so we don't need the atomic_t semantics.>
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Nikolay Borisov <nborisov@suse.com>

> ---
>  fs/btrfs/extent_io.c  |  2 +-
>  fs/btrfs/extent_io.h  |  2 +-
>  fs/btrfs/locking.c    | 46 +++++++++++++++++++------------------------
>  fs/btrfs/print-tree.c |  2 +-
>  4 files changed, 23 insertions(+), 29 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 2f38c10d2bfb..57b6de9df7c4 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -4823,7 +4823,7 @@ __alloc_extent_buffer(struct btrfs_fs_info *fs_info, u64 start,
>  	eb->bflags = 0;
>  	rwlock_init(&eb->lock);
>  	atomic_set(&eb->blocking_readers, 0);
> -	atomic_set(&eb->blocking_writers, 0);
> +	eb->blocking_writers = 0;
>  	eb->lock_nested = false;
>  	init_waitqueue_head(&eb->write_lock_wq);
>  	init_waitqueue_head(&eb->read_lock_wq);
> diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
> index aa18a16a6ed7..201da61dfc21 100644
> --- a/fs/btrfs/extent_io.h
> +++ b/fs/btrfs/extent_io.h
> @@ -167,7 +167,7 @@ struct extent_buffer {
>  	struct rcu_head rcu_head;
>  	pid_t lock_owner;
>  
> -	atomic_t blocking_writers;
> +	int blocking_writers;
>  	atomic_t blocking_readers;
>  	bool lock_nested;
>  	/* >= 0 if eb belongs to a log tree, -1 otherwise */
> diff --git a/fs/btrfs/locking.c b/fs/btrfs/locking.c
> index 2f6c3c7851ed..5feb01147e19 100644
> --- a/fs/btrfs/locking.c
> +++ b/fs/btrfs/locking.c
> @@ -111,10 +111,10 @@ void btrfs_set_lock_blocking_write(struct extent_buffer *eb)
>  	 */
>  	if (eb->lock_nested && current->pid == eb->lock_owner)
>  		return;
> -	if (atomic_read(&eb->blocking_writers) == 0) {
> +	if (eb->blocking_writers == 0) {
>  		btrfs_assert_spinning_writers_put(eb);
>  		btrfs_assert_tree_locked(eb);
> -		atomic_inc(&eb->blocking_writers);
> +		eb->blocking_writers++;
>  		write_unlock(&eb->lock);
>  	}
>  }
> @@ -148,12 +148,11 @@ void btrfs_clear_lock_blocking_write(struct extent_buffer *eb)
>  	 */
>  	if (eb->lock_nested && current->pid == eb->lock_owner)
>  		return;
> -	BUG_ON(atomic_read(&eb->blocking_writers) != 1);
>  	write_lock(&eb->lock);
> +	BUG_ON(eb->blocking_writers != 1);
>  	btrfs_assert_spinning_writers_get(eb);
> -	/* atomic_dec_and_test implies a barrier */
> -	if (atomic_dec_and_test(&eb->blocking_writers))
> -		cond_wake_up_nomb(&eb->write_lock_wq);
> +	if (--eb->blocking_writers == 0)
> +		cond_wake_up(&eb->write_lock_wq);
>  }
>  
>  /*
> @@ -167,12 +166,10 @@ void btrfs_tree_read_lock(struct extent_buffer *eb)
>  	if (trace_btrfs_tree_read_lock_enabled())
>  		start_ns = ktime_get_ns();
>  again:
> -	BUG_ON(!atomic_read(&eb->blocking_writers) &&
> -	       current->pid == eb->lock_owner);
> -
>  	read_lock(&eb->lock);
> -	if (atomic_read(&eb->blocking_writers) &&
> -	    current->pid == eb->lock_owner) {
> +	BUG_ON(eb->blocking_writers == 0 &&
> +	       current->pid == eb->lock_owner);
> +	if (eb->blocking_writers && current->pid == eb->lock_owner) {
>  		/*
>  		 * This extent is already write-locked by our thread. We allow
>  		 * an additional read lock to be added because it's for the same
> @@ -185,10 +182,10 @@ void btrfs_tree_read_lock(struct extent_buffer *eb)
>  		trace_btrfs_tree_read_lock(eb, start_ns);
>  		return;
>  	}
> -	if (atomic_read(&eb->blocking_writers)) {
> +	if (eb->blocking_writers) {
>  		read_unlock(&eb->lock);
>  		wait_event(eb->write_lock_wq,
> -			   atomic_read(&eb->blocking_writers) == 0);
> +			   eb->blocking_writers == 0);
>  		goto again;
>  	}
>  	btrfs_assert_tree_read_locks_get(eb);
> @@ -203,11 +200,11 @@ void btrfs_tree_read_lock(struct extent_buffer *eb)
>   */
>  int btrfs_tree_read_lock_atomic(struct extent_buffer *eb)
>  {
> -	if (atomic_read(&eb->blocking_writers))
> +	if (eb->blocking_writers)
>  		return 0;
>  
>  	read_lock(&eb->lock);
> -	if (atomic_read(&eb->blocking_writers)) {
> +	if (eb->blocking_writers) {
>  		read_unlock(&eb->lock);
>  		return 0;
>  	}
> @@ -223,13 +220,13 @@ int btrfs_tree_read_lock_atomic(struct extent_buffer *eb)
>   */
>  int btrfs_try_tree_read_lock(struct extent_buffer *eb)
>  {
> -	if (atomic_read(&eb->blocking_writers))
> +	if (eb->blocking_writers)
>  		return 0;
>  
>  	if (!read_trylock(&eb->lock))
>  		return 0;
>  
> -	if (atomic_read(&eb->blocking_writers)) {
> +	if (eb->blocking_writers) {
>  		read_unlock(&eb->lock);
>  		return 0;
>  	}
> @@ -245,13 +242,11 @@ int btrfs_try_tree_read_lock(struct extent_buffer *eb)
>   */
>  int btrfs_try_tree_write_lock(struct extent_buffer *eb)
>  {
> -	if (atomic_read(&eb->blocking_writers) ||
> -	    atomic_read(&eb->blocking_readers))
> +	if (eb->blocking_writers || atomic_read(&eb->blocking_readers))
>  		return 0;
>  
>  	write_lock(&eb->lock);
> -	if (atomic_read(&eb->blocking_writers) ||
> -	    atomic_read(&eb->blocking_readers)) {
> +	if (eb->blocking_writers || atomic_read(&eb->blocking_readers)) {
>  		write_unlock(&eb->lock);
>  		return 0;
>  	}
> @@ -322,10 +317,9 @@ void btrfs_tree_lock(struct extent_buffer *eb)
>  	WARN_ON(eb->lock_owner == current->pid);
>  again:
>  	wait_event(eb->read_lock_wq, atomic_read(&eb->blocking_readers) == 0);
> -	wait_event(eb->write_lock_wq, atomic_read(&eb->blocking_writers) == 0);
> +	wait_event(eb->write_lock_wq, eb->blocking_writers == 0);
>  	write_lock(&eb->lock);
> -	if (atomic_read(&eb->blocking_readers) ||
> -	    atomic_read(&eb->blocking_writers)) {
> +	if (atomic_read(&eb->blocking_readers) || eb->blocking_writers) {
>  		write_unlock(&eb->lock);
>  		goto again;
>  	}
> @@ -340,7 +334,7 @@ void btrfs_tree_lock(struct extent_buffer *eb)
>   */
>  void btrfs_tree_unlock(struct extent_buffer *eb)
>  {
> -	int blockers = atomic_read(&eb->blocking_writers);
> +	int blockers = eb->blocking_writers;
>  
>  	BUG_ON(blockers > 1);
>  
> @@ -351,7 +345,7 @@ void btrfs_tree_unlock(struct extent_buffer *eb)
>  
>  	if (blockers) {
>  		btrfs_assert_no_spinning_writers(eb);
> -		atomic_dec(&eb->blocking_writers);
> +		eb->blocking_writers--;
>  		/* Use the lighter barrier after atomic */
>  		smp_mb__after_atomic();
>  		cond_wake_up_nomb(&eb->write_lock_wq);
> diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
> index 1141ca5fae6a..7cb4f1fbe043 100644
> --- a/fs/btrfs/print-tree.c
> +++ b/fs/btrfs/print-tree.c
> @@ -155,7 +155,7 @@ static void print_eb_refs_lock(struct extent_buffer *eb)
>  "refs %u lock (w:%d r:%d bw:%d br:%d sw:%d sr:%d) lock_owner %u current %u",
>  		   atomic_read(&eb->refs), atomic_read(&eb->write_locks),
>  		   atomic_read(&eb->read_locks),
> -		   atomic_read(&eb->blocking_writers),
> +		   eb->blocking_writers,
>  		   atomic_read(&eb->blocking_readers),
>  		   atomic_read(&eb->spinning_writers),
>  		   atomic_read(&eb->spinning_readers),
> 
