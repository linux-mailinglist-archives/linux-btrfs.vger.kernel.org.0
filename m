Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3A5630B3E
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 May 2019 11:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbfEaJTT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 May 2019 05:19:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:59916 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726002AbfEaJTT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 May 2019 05:19:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 387F5AE15
        for <linux-btrfs@vger.kernel.org>; Fri, 31 May 2019 09:19:16 +0000 (UTC)
Subject: Re: [PATCH 2/3] btrfs: switch extent_buffer spinning_writers from
 atomic to int
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1559233731.git.dsterba@suse.com>
 <6dfcb89b254ee5016edfa9816fce3487a23b446c.1559233731.git.dsterba@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <41aca846-afb1-9b83-f442-d791eb929c36@suse.com>
Date:   Fri, 31 May 2019 12:19:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <6dfcb89b254ee5016edfa9816fce3487a23b446c.1559233731.git.dsterba@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 30.05.19 г. 19:31 ч., David Sterba wrote:
> The spinning_writers is either 0 or 1 and always updated under the lock,
> so we don't need the atomic_t semantics.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>  fs/btrfs/extent_io.c  |  2 +-
>  fs/btrfs/extent_io.h  |  2 +-
>  fs/btrfs/locking.c    | 10 +++++-----
>  fs/btrfs/print-tree.c |  2 +-
>  4 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 57b6de9df7c4..71ee9e976307 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -4842,7 +4842,7 @@ __alloc_extent_buffer(struct btrfs_fs_info *fs_info, u64 start,
>  	BUG_ON(len > MAX_INLINE_EXTENT_BUFFER_SIZE);
>  
>  #ifdef CONFIG_BTRFS_DEBUG
> -	atomic_set(&eb->spinning_writers, 0);
> +	eb->spinning_writers = 0;
>  	atomic_set(&eb->spinning_readers, 0);
>  	atomic_set(&eb->read_locks, 0);
>  	atomic_set(&eb->write_locks, 0);
> diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
> index 201da61dfc21..5616b96c365d 100644
> --- a/fs/btrfs/extent_io.h
> +++ b/fs/btrfs/extent_io.h
> @@ -187,7 +187,7 @@ struct extent_buffer {
>  	wait_queue_head_t read_lock_wq;
>  	struct page *pages[INLINE_EXTENT_BUFFER_PAGES];
>  #ifdef CONFIG_BTRFS_DEBUG
> -	atomic_t spinning_writers;
> +	int spinning_writers;
>  	atomic_t spinning_readers;
>  	atomic_t read_locks;
>  	atomic_t write_locks;
> diff --git a/fs/btrfs/locking.c b/fs/btrfs/locking.c
> index 5feb01147e19..270667627977 100644
> --- a/fs/btrfs/locking.c
> +++ b/fs/btrfs/locking.c
> @@ -15,19 +15,19 @@
>  #ifdef CONFIG_BTRFS_DEBUG
>  static void btrfs_assert_spinning_writers_get(struct extent_buffer *eb)
>  {
> -	WARN_ON(atomic_read(&eb->spinning_writers));
> -	atomic_inc(&eb->spinning_writers);
> +	WARN_ON(eb->spinning_writers);
> +	eb->spinning_writers++;
>  }
>  
>  static void btrfs_assert_spinning_writers_put(struct extent_buffer *eb)
>  {
> -	WARN_ON(atomic_read(&eb->spinning_writers) != 1);
> -	atomic_dec(&eb->spinning_writers);
> +	WARN_ON(eb->spinning_writers != 1);
> +	eb->spinning_writers--;
>  }
>  
>  static void btrfs_assert_no_spinning_writers(struct extent_buffer *eb)
>  {
> -	WARN_ON(atomic_read(&eb->spinning_writers));
> +	WARN_ON(eb->spinning_writers);
>  }

IMO longterm  it will be good if those debug functions contained
lockdep_assert_held_exclusive/read macros for posterity.

>  
>  static void btrfs_assert_spinning_readers_get(struct extent_buffer *eb)
> diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
> index 7cb4f1fbe043..c5cc435ed39a 100644
> --- a/fs/btrfs/print-tree.c
> +++ b/fs/btrfs/print-tree.c
> @@ -157,7 +157,7 @@ static void print_eb_refs_lock(struct extent_buffer *eb)
>  		   atomic_read(&eb->read_locks),
>  		   eb->blocking_writers,
>  		   atomic_read(&eb->blocking_readers),
> -		   atomic_read(&eb->spinning_writers),
> +		   eb->spinning_writers,
>  		   atomic_read(&eb->spinning_readers),
>  		   eb->lock_owner, current->pid);
>  #endif
> 
