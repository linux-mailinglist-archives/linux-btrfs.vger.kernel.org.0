Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD80D6A8B
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2019 22:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731489AbfJNUEJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Oct 2019 16:04:09 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:32935 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730668AbfJNUEJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Oct 2019 16:04:09 -0400
Received: by mail-qt1-f195.google.com with SMTP id r5so27225521qtd.0
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Oct 2019 13:04:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iHRud3qmPNr62Bt9OGfA1BZj9uWE7FZ1csdx+VeZoc0=;
        b=omINAt8J3UMe5iVssT2Azfcz9TR3YCPBzX2Jq6MbN0TZ0bxBOxMef4CJ6gVqaxufZ/
         t1sHhVgzlNNhVH2fokAZH2FkOaYZOJxFMgVBEU/lNF6iG/llw0KnRwGPWzL7sYa3MbFs
         7vKGBS9OcNVT/aj9fFt5DcaB5efTq8YDwIES7Xi+p2c5J1K3Dr5Nc+mbu5Pd25jzJpUT
         HN1mgBefE2tFnGqg2ROEGuXg25yG5y9KgyO2ooQXyM6Wasirp9jT8KX6xTrXKrkRIdIa
         TUeaCaGIeVL3km4Lr+ItPV4h7nXQzhk8dU8AkpOU9pRZy/og9OlskfVa9pJGHYIDpjr3
         137A==
X-Gm-Message-State: APjAAAX0plojFj4e45U7sL2v1HKy+6S3IGz/Im4B/9vzMkAh6aVlmYMD
        0hcqBDHGZh2y2EQ+sflvvyU=
X-Google-Smtp-Source: APXvYqwxTZzhx2fUZECCVE1oKl6R/Yralv9iCTjCaG88kXmngeu26PMPEVPbGgfzlt42WUSyPJLizg==
X-Received: by 2002:ad4:538b:: with SMTP id i11mr14102613qvv.211.1571083447600;
        Mon, 14 Oct 2019 13:04:07 -0700 (PDT)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:500::2:b1f8])
        by smtp.gmail.com with ESMTPSA id a19sm12118048qtc.58.2019.10.14.13.04.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Oct 2019 13:04:06 -0700 (PDT)
Date:   Mon, 14 Oct 2019 16:04:05 -0400
From:   Dennis Zhou <dennis@kernel.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 13/19] btrfs: have multiple discard lists
Message-ID: <20191014200405.GE40077@dennisz-mbp.dhcp.thefacebook.com>
References: <cover.1570479299.git.dennis@kernel.org>
 <87b5ef751e8febd481065e475bd53b276e670ff6.1570479299.git.dennis@kernel.org>
 <20191010165100.nz7tfn7kpclp6dkl@macbook-pro-91.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010165100.nz7tfn7kpclp6dkl@macbook-pro-91.dhcp.thefacebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 10, 2019 at 12:51:01PM -0400, Josef Bacik wrote:
> On Mon, Oct 07, 2019 at 04:17:44PM -0400, Dennis Zhou wrote:
> > Non-block group destruction discarding currently only had a single list
> > with no minimum discard length. This can lead to caravaning more
> > meaningful discards behind a heavily fragmented block group.
> > 
> > This adds support for multiple lists with minimum discard lengths to
> > prevent the caravan effect. We promote block groups back up when we
> > exceed the BTRFS_DISCARD_MAX_FILTER size, currently we support only 2
> > lists with filters of 1MB and 32KB respectively.
> > 
> > Signed-off-by: Dennis Zhou <dennis@kernel.org>
> > ---
> >  fs/btrfs/ctree.h            |  2 +-
> >  fs/btrfs/discard.c          | 60 +++++++++++++++++++++++++++++++++----
> >  fs/btrfs/discard.h          |  4 +++
> >  fs/btrfs/free-space-cache.c | 37 +++++++++++++++--------
> >  fs/btrfs/free-space-cache.h |  2 +-
> >  5 files changed, 85 insertions(+), 20 deletions(-)
> > 
> > diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> > index e81f699347e0..b5608f8dc41a 100644
> > --- a/fs/btrfs/ctree.h
> > +++ b/fs/btrfs/ctree.h
> > @@ -439,7 +439,7 @@ struct btrfs_full_stripe_locks_tree {
> >  };
> >  
> >  /* discard control */
> > -#define BTRFS_NR_DISCARD_LISTS		2
> > +#define BTRFS_NR_DISCARD_LISTS		3
> >  
> >  struct btrfs_discard_ctl {
> >  	struct workqueue_struct *discard_workers;
> > diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
> > index 072c73f48297..296cbffc5957 100644
> > --- a/fs/btrfs/discard.c
> > +++ b/fs/btrfs/discard.c
> > @@ -20,6 +20,10 @@
> >  #define BTRFS_DISCARD_MAX_DELAY		(10000UL)
> >  #define BTRFS_DISCARD_MAX_IOPS		(10UL)
> >  
> > +/* montonically decreasing filters after 0 */
> > +static int discard_minlen[BTRFS_NR_DISCARD_LISTS] = {0,
> > +	BTRFS_DISCARD_MAX_FILTER, BTRFS_DISCARD_MIN_FILTER};
> > +
> >  static struct list_head *
> >  btrfs_get_discard_list(struct btrfs_discard_ctl *discard_ctl,
> >  		       struct btrfs_block_group_cache *cache)
> > @@ -120,7 +124,7 @@ find_next_cache(struct btrfs_discard_ctl *discard_ctl, u64 now)
> >  }
> >  
> >  static struct btrfs_block_group_cache *
> > -peek_discard_list(struct btrfs_discard_ctl *discard_ctl)
> > +peek_discard_list(struct btrfs_discard_ctl *discard_ctl, int *discard_index)
> >  {
> >  	struct btrfs_block_group_cache *cache;
> >  	u64 now = ktime_get_ns();
> > @@ -132,6 +136,7 @@ peek_discard_list(struct btrfs_discard_ctl *discard_ctl)
> >  
> >  	if (cache && now > cache->discard_delay) {
> >  		discard_ctl->cache = cache;
> > +		*discard_index = cache->discard_index;
> >  		if (cache->discard_index == 0 &&
> >  		    cache->free_space_ctl->free_space != cache->key.offset) {
> >  			__btrfs_add_to_discard_list(discard_ctl, cache);
> > @@ -150,6 +155,36 @@ peek_discard_list(struct btrfs_discard_ctl *discard_ctl)
> >  	return cache;
> >  }
> >  
> > +void btrfs_discard_check_filter(struct btrfs_block_group_cache *cache,
> > +				u64 bytes)
> > +{
> > +	struct btrfs_discard_ctl *discard_ctl;
> > +
> > +	if (!cache || !btrfs_test_opt(cache->fs_info, DISCARD_ASYNC))
> > +		return;
> > +
> > +	discard_ctl = &cache->fs_info->discard_ctl;
> > +
> > +	if (cache && cache->discard_index > 1 &&
> > +	    bytes >= BTRFS_DISCARD_MAX_FILTER) {
> > +		remove_from_discard_list(discard_ctl, cache);
> > +		cache->discard_index = 1;
> 
> Really need names here, I have no idea what 1 is.
> 

Yep, done.

> > +		btrfs_add_to_discard_list(discard_ctl, cache);
> > +	}
> > +}
> > +
> > +static void btrfs_update_discard_index(struct btrfs_discard_ctl *discard_ctl,
> > +				       struct btrfs_block_group_cache *cache)
> > +{
> > +	cache->discard_index++;
> > +	if (cache->discard_index == BTRFS_NR_DISCARD_LISTS) {
> > +		cache->discard_index = 1;
> > +		return;
> > +	}
> > +
> > +	btrfs_add_to_discard_list(discard_ctl, cache);
> > +}
> > +
> >  void btrfs_discard_cancel_work(struct btrfs_discard_ctl *discard_ctl,
> >  			       struct btrfs_block_group_cache *cache)
> >  {
> > @@ -202,23 +237,34 @@ static void btrfs_discard_workfn(struct work_struct *work)
> >  {
> >  	struct btrfs_discard_ctl *discard_ctl;
> >  	struct btrfs_block_group_cache *cache;
> > +	int discard_index = 0;
> >  	u64 trimmed = 0;
> > +	u64 minlen = 0;
> >  
> >  	discard_ctl = container_of(work, struct btrfs_discard_ctl, work.work);
> >  
> >  again:
> > -	cache = peek_discard_list(discard_ctl);
> > +	cache = peek_discard_list(discard_ctl, &discard_index);
> >  	if (!cache || !btrfs_run_discard_work(discard_ctl))
> >  		return;
> >  
> > -	if (btrfs_discard_bitmaps(cache))
> > +	minlen = discard_minlen[discard_index];
> > +
> > +	if (btrfs_discard_bitmaps(cache)) {
> > +		u64 maxlen = 0;
> > +
> > +		if (discard_index)
> > +			maxlen = discard_minlen[discard_index - 1];
> > +
> >  		btrfs_trim_block_group_bitmaps(cache, &trimmed,
> >  					       cache->discard_cursor,
> >  					       btrfs_block_group_end(cache),
> > -					       0, true);
> > -	else
> > +					       minlen, maxlen, true);
> > +	} else {
> >  		btrfs_trim_block_group(cache, &trimmed, cache->discard_cursor,
> > -				       btrfs_block_group_end(cache), 0, true);
> > +				       btrfs_block_group_end(cache),
> > +				       minlen, true);
> > +	}
> >  
> >  	discard_ctl->prev_discard = trimmed;
> >  
> > @@ -231,6 +277,8 @@ static void btrfs_discard_workfn(struct work_struct *work)
> >  				 cache->key.offset)
> >  				btrfs_add_to_discard_free_list(discard_ctl,
> >  							       cache);
> > +			else
> > +				btrfs_update_discard_index(discard_ctl, cache);
> >  		} else {
> >  			cache->discard_cursor = cache->key.objectid;
> >  			cache->discard_flags |= BTRFS_DISCARD_BITMAPS;
> > diff --git a/fs/btrfs/discard.h b/fs/btrfs/discard.h
> > index 898dd92dbf8f..1daa8da4a1b5 100644
> > --- a/fs/btrfs/discard.h
> > +++ b/fs/btrfs/discard.h
> > @@ -18,6 +18,8 @@
> >  
> >  /* discard size limits */
> >  #define BTRFS_DISCARD_MAX_SIZE		(SZ_64M)
> > +#define BTRFS_DISCARD_MAX_FILTER	(SZ_1M)
> > +#define BTRFS_DISCARD_MIN_FILTER	(SZ_32K)
> >  
> >  /* discard flags */
> >  #define BTRFS_DISCARD_RESET_CURSOR	(1UL << 0)
> > @@ -39,6 +41,8 @@ void btrfs_add_to_discard_list(struct btrfs_discard_ctl *discard_ctl,
> >  			       struct btrfs_block_group_cache *cache);
> >  void btrfs_add_to_discard_free_list(struct btrfs_discard_ctl *discard_ctl,
> >  				    struct btrfs_block_group_cache *cache);
> > +void btrfs_discard_check_filter(struct btrfs_block_group_cache *cache,
> > +				u64 bytes);
> >  void btrfs_discard_punt_unused_bgs_list(struct btrfs_fs_info *fs_info);
> >  
> >  void btrfs_discard_cancel_work(struct btrfs_discard_ctl *discard_ctl,
> > diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
> > index ce33803a45b2..ed35dc090df6 100644
> > --- a/fs/btrfs/free-space-cache.c
> > +++ b/fs/btrfs/free-space-cache.c
> > @@ -2471,6 +2471,7 @@ int __btrfs_add_free_space(struct btrfs_fs_info *fs_info,
> >  	if (ret)
> >  		kmem_cache_free(btrfs_free_space_cachep, info);
> >  out:
> > +	btrfs_discard_check_filter(cache, bytes);
> 
> So we're only accounting the new space?  What if we merge with a larger area
> here?  We should probably make our decision based on the actual trimable area.
> 

Thanks that's a good catch. I've updated it to be info->bytes if
possible.

> >  	btrfs_discard_update_discardable(cache, ctl);
> >  	spin_unlock(&ctl->tree_lock);
> >  
> > @@ -3409,7 +3410,13 @@ static int trim_no_bitmap(struct btrfs_block_group_cache *block_group,
> >  				goto next;
> >  			}
> >  			unlink_free_space(ctl, entry);
> > -			if (bytes > BTRFS_DISCARD_MAX_SIZE) {
> > +			/*
> > +			 * Let bytes = BTRFS_MAX_DISCARD_SIZE + X.
> > +			 * If X < BTRFS_DISCARD_MIN_FILTER, we won't trim X when
> > +			 * we come back around.  So trim it now.
> > +			 */
> > +			if (bytes > (BTRFS_DISCARD_MAX_SIZE +
> > +				     BTRFS_DISCARD_MIN_FILTER)) {
> >  				bytes = extent_bytes = BTRFS_DISCARD_MAX_SIZE;
> >  				entry->offset += BTRFS_DISCARD_MAX_SIZE;
> >  				entry->bytes -= BTRFS_DISCARD_MAX_SIZE;
> > @@ -3510,7 +3517,7 @@ static void end_trimming_bitmap(struct btrfs_free_space_ctl *ctl,
> >  
> >  static int trim_bitmaps(struct btrfs_block_group_cache *block_group,
> >  			u64 *total_trimmed, u64 start, u64 end, u64 minlen,
> > -			bool async)
> > +			u64 maxlen, bool async)
> >  {
> >  	struct btrfs_free_space_ctl *ctl = block_group->free_space_ctl;
> >  	struct btrfs_free_space *entry;
> > @@ -3535,7 +3542,7 @@ static int trim_bitmaps(struct btrfs_block_group_cache *block_group,
> >  		}
> >  
> >  		entry = tree_search_offset(ctl, offset, 1, 0);
> > -		if (!entry || (async && start == offset &&
> > +		if (!entry || (async && minlen && start == offset &&
> >  			       btrfs_free_space_trimmed(entry))) {
> 
> Huh?  Why do we care if minlen is set if our entry is already trimmed?  If we're
> already trimmed we should just skip it even with minlen set, right?  Thanks,
> 

Yeah this definitely needs a comment. The reason for this is minlen is
used to check if we're in discard_index 0 which is the free path
discarding. In this case, because bitmaps are lossily marked trimmed,
(we skip lone pages less than BTRFS_ASYNC_DISCARD_MIN_FILTER), we need
to just go back and double check. The goal is to maintain the invariant
everything is discarded when we forget about a block group.

I think in practice, with the FORCE_EXTENT_THRESHOLD patch later on,
this shouldn't really be common case as it should have been picked out
by some coalescing.

Thanks,
Dennis
