Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAC24213A5D
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jul 2020 14:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgGCMyX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Jul 2020 08:54:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:48260 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726877AbgGCMyW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 3 Jul 2020 08:54:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D7CD5AD1E;
        Fri,  3 Jul 2020 12:54:19 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 01CA3DA87C; Fri,  3 Jul 2020 14:54:01 +0200 (CEST)
Date:   Fri, 3 Jul 2020 14:54:01 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 1/2] btrfs: convert block group refcount to refcount_t
Message-ID: <20200703125401.GA27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200701202219.11984-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701202219.11984-1-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 01, 2020 at 04:22:18PM -0400, Josef Bacik wrote:
> I was experimenting with some new allocator changes and I noticed that I
> was getting a UAF with the block groups.  In order to help figure this
> out I converted the block group to use the refcount_t infrastructure.
> This is a generally good idea anyway, so kill the atomic and use
> refcount_t so we can get the benefit of loud complaints when refcounting
> goes wrong.

I don't mind adding some background or motivation of the patch but the
technical part and explanation should be still there and after reading
this paragraph I'm still mssing it.

> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/block-group.c | 8 ++++----
>  fs/btrfs/block-group.h | 2 +-
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 09b796a081dd..7c0075413b08 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -118,12 +118,12 @@ u64 btrfs_get_alloc_profile(struct btrfs_fs_info *fs_info, u64 orig_flags)
>  
>  void btrfs_get_block_group(struct btrfs_block_group *cache)
>  {
> -	atomic_inc(&cache->count);
> +	refcount_inc(&cache->count);
>  }
>  
>  void btrfs_put_block_group(struct btrfs_block_group *cache)
>  {
> -	if (atomic_dec_and_test(&cache->count)) {
> +	if (refcount_dec_and_test(&cache->count)) {
>  		WARN_ON(cache->pinned > 0);
>  		WARN_ON(cache->reserved > 0);
>  
> @@ -1805,7 +1805,7 @@ static struct btrfs_block_group *btrfs_create_block_group_cache(
>  
>  	cache->discard_index = BTRFS_DISCARD_INDEX_UNUSED;
>  
> -	atomic_set(&cache->count, 1);
> +	refcount_set(&cache->count, 1);
>  	spin_lock_init(&cache->lock);
>  	init_rwsem(&cache->data_rwsem);
>  	INIT_LIST_HEAD(&cache->list);
> @@ -3427,7 +3427,7 @@ int btrfs_free_block_groups(struct btrfs_fs_info *info)
>  		ASSERT(list_empty(&block_group->dirty_list));
>  		ASSERT(list_empty(&block_group->io_list));
>  		ASSERT(list_empty(&block_group->bg_list));
> -		ASSERT(atomic_read(&block_group->count) == 1);
> +		ASSERT(refcount_read(&block_group->count) == 1);
>  		btrfs_put_block_group(block_group);
>  
>  		spin_lock(&info->block_group_cache_lock);
> diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
> index b6ee70a039c7..705e48050163 100644
> --- a/fs/btrfs/block-group.h
> +++ b/fs/btrfs/block-group.h
> @@ -115,7 +115,7 @@ struct btrfs_block_group {
>  	struct list_head list;
>  
>  	/* Usage count */
> -	atomic_t count;
> +	refcount_t count;

Originally the comment says 'usage', which is a bit different from
refcounts. The atomics will allow 1->0 and 0->1, which might be valid
pattern and reflects the 'usage counter' semantics. The refcounts catch
the 0->1 increment as bug and complain. This is what we want and that's
why you switch that.

So I suggest to drop the comment and rename it to 'refs' that we use
for refcounts elsewhere.
