Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5714EE1485
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Oct 2019 10:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390137AbfJWIme (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Oct 2019 04:42:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:55014 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732361AbfJWIme (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Oct 2019 04:42:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 672B9B01C;
        Wed, 23 Oct 2019 08:42:31 +0000 (UTC)
Subject: Re: [PATCH 3/5] btrfs: access eb::blocking_writers according to
 ACCESS_ONCE policies
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1571340084.git.dsterba@suse.com>
 <cb93f314165c09d91cbbeb7a1d4ee59b54496220.1571340084.git.dsterba@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <270b6d1b-9304-80cd-4104-b55e8df99a8a@suse.com>
Date:   Wed, 23 Oct 2019 11:42:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <cb93f314165c09d91cbbeb7a1d4ee59b54496220.1571340084.git.dsterba@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 17.10.19 г. 22:38 ч., David Sterba wrote:
> A nice writeup of the LKMM (Linux Kernel Memory Model) rules for access
> once policies can be found here
> https://lwn.net/Articles/799218/#Access-Marking%20Policies .
> 
> The locked and unlocked access to eb::blocking_writers should be
> annotated accordingly, following this:
> 
> Writes:
> 
> - locked write must use ONCE, may use plain read
> - unlocked write must use ONCE
> 
> Reads:
> 
> - unlocked read must use ONCE
> - locked read may use plain read iff not mixed with unlocked read
> - unlocked read then locked must use ONCE
> 
> There's one difference on the assembly level, where
> btrfs_tree_read_lock_atomic and btrfs_try_tree_read_lock used the cached
> value and did not reevaluate it after taking the lock. This could have
> missed some opportunities to take the lock in case blocking writers
> changed between the calls, but the window is just a few instructions
> long. As this is in try-lock, the callers handle that.

Looking at blocking_writers it seems this variable is modified under
eb->lock (in set lock blocking which requires us having a spinning lock
first, meaning the setting thread is the owner). At this point the
owning thread will have to eventually unlock it, this happens in
btrfs_tree_unlock. There the read/write to the variable is either locked
or unlocked depending on whether the lock is blocking (unlocked) or
spinning (locked).

OTOH other readers of the lock might access is unlocked, namely :
tree_read_lock (in case wait_event is called), tree_read_lock_atomic -
the first access is unlocked. The optimistic unlocked checks in
try_tree_(read|Write_lock).

So I believe this puts us in scenario 3 in the referenced section of
that LWN article:

A shared variable (blocking_writers) is only modified while holding a
given lock by a given owning CPU or thread (that's the thread which
first took a spinning lock and eventually converted it to a blocking
one), but is read by other CPUs or threads or by code not holding that
lock (that's other threads that might want to acquire the lock on the
given eb).

Apart from one minor nit below (and provided my understanding is correct
as per above exposé) you can add:

Reviewed-by: Nikolay Borisov <nborisov@suse.com>

> 
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>  fs/btrfs/locking.c | 31 +++++++++++++++++++------------
>  1 file changed, 19 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/btrfs/locking.c b/fs/btrfs/locking.c
> index 00edf91c3d1c..a12f3edc3505 100644
> --- a/fs/btrfs/locking.c
> +++ b/fs/btrfs/locking.c
> @@ -109,7 +109,7 @@ void btrfs_set_lock_blocking_write(struct extent_buffer *eb)
>  	if (eb->blocking_writers == 0) {
>  		btrfs_assert_spinning_writers_put(eb);
>  		btrfs_assert_tree_locked(eb);
> -		eb->blocking_writers = 1;
> +		WRITE_ONCE(eb->blocking_writers, 1);
>  		write_unlock(&eb->lock);
>  	}
>  }

<snip>


> @@ -294,7 +299,8 @@ void btrfs_tree_lock(struct extent_buffer *eb)
>   */
>  void btrfs_tree_unlock(struct extent_buffer *eb)
>  {
> -	int blockers = eb->blocking_writers;
> +	/* This is read both locked and unlocked */
> +	int blockers = READ_ONCE(eb->blocking_writers);

Actually aren't we guaranteed that btrfs_tree_unlock's caller is the
owner of blocking_writers meaning we can use plain loads as per:

"The owning CPU or thread may use plain loads..."

>  
>  	BUG_ON(blockers > 1);
>  
> @@ -305,7 +311,8 @@ void btrfs_tree_unlock(struct extent_buffer *eb)
>  
>  	if (blockers) {
>  		btrfs_assert_no_spinning_writers(eb);
> -		eb->blocking_writers = 0;
> +		/* Unlocked write */
> +		WRITE_ONCE(eb->blocking_writers, 0);
>  		/*
>  		 * We need to order modifying blocking_writers above with
>  		 * actually waking up the sleepers to ensure they see the
> 
