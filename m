Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B75842AF393
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Nov 2020 15:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbgKKObO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Nov 2020 09:31:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:40624 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726881AbgKKObN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Nov 2020 09:31:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4B9F2AC83;
        Wed, 11 Nov 2020 14:31:12 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7728CDA6E1; Wed, 11 Nov 2020 15:29:30 +0100 (CET)
Date:   Wed, 11 Nov 2020 15:29:30 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 4/8] btrfs: remove the recursion handling code in
 locking.c
Message-ID: <20201111142930.GP6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1604697895.git.josef@toxicpanda.com>
 <c04e7bd2e5294b23eadbcafedca7214f7894c9e9.1604697895.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c04e7bd2e5294b23eadbcafedca7214f7894c9e9.1604697895.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 06, 2020 at 04:27:32PM -0500, Josef Bacik wrote:
> @@ -71,31 +47,7 @@ void __btrfs_tree_read_lock(struct extent_buffer *eb, enum btrfs_lock_nesting ne
>  	if (trace_btrfs_tree_read_lock_enabled())
>  		start_ns = ktime_get_ns();
>  
> -	if (unlikely(recurse)) {
> -		/* First see if we can grab the lock outright */
> -		if (down_read_trylock(&eb->lock))
> -			goto out;
> -
> -		/*
> -		 * Ok still doesn't necessarily mean we are already holding the
> -		 * lock, check the owner.
> -		 */
> -		if (eb->lock_owner != current->pid) {

This

> -			down_read_nested(&eb->lock, nest);
> -			goto out;
> -		}
> -
> -		/*
> -		 * Ok we have actually recursed, but we should only be recursing
> -		 * once, so blow up if we're already recursed, otherwise set
> -		 * ->lock_recursed and carry on.
> -		 */
> -		BUG_ON(eb->lock_recursed);
> -		eb->lock_recursed = true;
> -		goto out;
> -	}
>  	down_read_nested(&eb->lock, nest);
> -out:
>  	eb->lock_owner = current->pid;
>  	trace_btrfs_tree_read_lock(eb, start_ns);
>  }
> @@ -136,22 +88,11 @@ int btrfs_try_tree_write_lock(struct extent_buffer *eb)
>  }
>  
>  /*
> - * Release read lock.  If the read lock was recursed then the lock stays in the
> - * original state that it was before it was recursively locked.
> + * Release read lock.
>   */
>  void btrfs_tree_read_unlock(struct extent_buffer *eb)
>  {
>  	trace_btrfs_tree_read_unlock(eb);
> -	/*
> -	 * if we're nested, we have the write lock.  No new locking
> -	 * is needed as long as we are the lock owner.
> -	 * The write unlock will do a barrier for us, and the lock_recursed
> -	 * field only matters to the lock owner.
> -	 */
> -	if (eb->lock_recursed && current->pid == eb->lock_owner) {

And this were the last uses of the lock_owner inside locks, so when the
recursion is gone, the remainig use:

btrfs_init_new_buffer:

4624         /*
4625          * Extra safety check in case the extent tree is corrupted and extent
4626          * allocator chooses to use a tree block which is already used and
4627          * locked.
4628          */
4629         if (buf->lock_owner == current->pid) {
4630                 btrfs_err_rl(fs_info,
4631 "tree block %llu owner %llu already locked by pid=%d, extent tree corruption detected",
4632                         buf->start, btrfs_header_owner(buf), current->pid);
4633                 free_extent_buffer(buf);
4634                 return ERR_PTR(-EUCLEAN);
4635         }

And

185
186 /*
187  * Helper to output refs and locking status of extent buffer.  Useful to debug
188  * race condition related problems.
189  */
190 static void print_eb_refs_lock(struct extent_buffer *eb)
191 {
192 #ifdef CONFIG_BTRFS_DEBUG
193         btrfs_info(eb->fs_info, "refs %u lock_owner %u current %u",
194                    atomic_read(&eb->refs), eb->lock_owner, current->pid);
195 #endif
196 }

The safety check added in b72c3aba09a53fc7c18 ("btrfs: locking: Add
extra check in btrfs_init_new_buffer() to avoid deadlock") and it seems
to be useful but I think it builds on the assumptions of the previous
tree locks. The mentioned warning uses the recursive locking which is
being removed.

For debugging we could keep the lock_owner in eb, but under the
CONFIG_BTRFS_DEBUG, so for the release build the eb size is reduced.
