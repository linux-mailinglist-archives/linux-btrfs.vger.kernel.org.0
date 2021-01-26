Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 693583057EB
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jan 2021 11:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S314379AbhAZXGE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Jan 2021 18:06:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:45152 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392785AbhAZTQT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Jan 2021 14:16:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B3664B953;
        Tue, 26 Jan 2021 19:15:36 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id CD52EDA7D2; Tue, 26 Jan 2021 20:13:49 +0100 (CET)
Date:   Tue, 26 Jan 2021 20:13:49 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH v3 11/12] btrfs: adjust the flush trace point to include
 the source
Message-ID: <20210126191349.GX1993@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Nikolay Borisov <nborisov@suse.com>
References: <cover.1602249928.git.josef@toxicpanda.com>
 <cbc33fd7a2d39ca651ba1f1e44345663f5c369cc.1602249928.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbc33fd7a2d39ca651ba1f1e44345663f5c369cc.1602249928.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 09, 2020 at 09:28:28AM -0400, Josef Bacik wrote:
> Since we have normal ticketed flushing and preemptive flushing, adjust
> the tracepoint so that we know the source of the flushing action to make
> it easier to debug problems.
> 
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/space-info.c        | 20 ++++++++++++--------
>  include/trace/events/btrfs.h | 10 ++++++----
>  2 files changed, 18 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index 5ee698c12a7b..30474fa30985 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -664,7 +664,7 @@ static int may_commit_transaction(struct btrfs_fs_info *fs_info,
>   */
>  static void flush_space(struct btrfs_fs_info *fs_info,
>  		       struct btrfs_space_info *space_info, u64 num_bytes,
> -		       enum btrfs_flush_state state)
> +		       enum btrfs_flush_state state, bool for_preempt)
>  {
>  	struct btrfs_root *root = fs_info->extent_root;
>  	struct btrfs_trans_handle *trans;
> @@ -747,7 +747,7 @@ static void flush_space(struct btrfs_fs_info *fs_info,
>  	}
>  
>  	trace_btrfs_flush_space(fs_info, space_info->flags, num_bytes, state,
> -				ret);
> +				ret, for_preempt);
>  	return;
>  }
>  
> @@ -973,7 +973,8 @@ static void btrfs_async_reclaim_metadata_space(struct work_struct *work)
>  
>  	flush_state = FLUSH_DELAYED_ITEMS_NR;
>  	do {
> -		flush_space(fs_info, space_info, to_reclaim, flush_state);
> +		flush_space(fs_info, space_info, to_reclaim, flush_state,
> +			    false);
>  		spin_lock(&space_info->lock);
>  		if (list_empty(&space_info->tickets)) {
>  			space_info->flush = 0;
> @@ -1109,7 +1110,7 @@ static void btrfs_preempt_reclaim_metadata_space(struct work_struct *work)
>  		to_reclaim >>= 2;
>  		if (!to_reclaim)
>  			to_reclaim = btrfs_calc_insert_metadata_size(fs_info, 1);
> -		flush_space(fs_info, space_info, to_reclaim, flush);
> +		flush_space(fs_info, space_info, to_reclaim, flush, true);
>  		cond_resched();
>  		spin_lock(&space_info->lock);
>  	}
> @@ -1200,7 +1201,8 @@ static void btrfs_async_reclaim_data_space(struct work_struct *work)
>  	spin_unlock(&space_info->lock);
>  
>  	while (!space_info->full) {
> -		flush_space(fs_info, space_info, U64_MAX, ALLOC_CHUNK_FORCE);
> +		flush_space(fs_info, space_info, U64_MAX, ALLOC_CHUNK_FORCE,
> +			    false);
>  		spin_lock(&space_info->lock);
>  		if (list_empty(&space_info->tickets)) {
>  			space_info->flush = 0;
> @@ -1213,7 +1215,7 @@ static void btrfs_async_reclaim_data_space(struct work_struct *work)
>  
>  	while (flush_state < ARRAY_SIZE(data_flush_states)) {
>  		flush_space(fs_info, space_info, U64_MAX,
> -			    data_flush_states[flush_state]);
> +			    data_flush_states[flush_state], false);
>  		spin_lock(&space_info->lock);
>  		if (list_empty(&space_info->tickets)) {
>  			space_info->flush = 0;
> @@ -1286,7 +1288,8 @@ static void priority_reclaim_metadata_space(struct btrfs_fs_info *fs_info,
>  
>  	flush_state = 0;
>  	do {
> -		flush_space(fs_info, space_info, to_reclaim, states[flush_state]);
> +		flush_space(fs_info, space_info, to_reclaim, states[flush_state],
> +			    false);
>  		flush_state++;
>  		spin_lock(&space_info->lock);
>  		if (ticket->bytes == 0) {
> @@ -1302,7 +1305,8 @@ static void priority_reclaim_data_space(struct btrfs_fs_info *fs_info,
>  					struct reserve_ticket *ticket)
>  {
>  	while (!space_info->full) {
> -		flush_space(fs_info, space_info, U64_MAX, ALLOC_CHUNK_FORCE);
> +		flush_space(fs_info, space_info, U64_MAX, ALLOC_CHUNK_FORCE,
> +			    false);
>  		spin_lock(&space_info->lock);
>  		if (ticket->bytes == 0) {
>  			spin_unlock(&space_info->lock);
> diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
> index 0a3d35d952c4..6d93637bae02 100644
> --- a/include/trace/events/btrfs.h
> +++ b/include/trace/events/btrfs.h
> @@ -1112,15 +1112,16 @@ TRACE_EVENT(btrfs_trigger_flush,
>  TRACE_EVENT(btrfs_flush_space,
>  
>  	TP_PROTO(const struct btrfs_fs_info *fs_info, u64 flags, u64 num_bytes,
> -		 int state, int ret),
> +		 int state, int ret, int for_preempt),

for_preempt should be bool

>  
> -	TP_ARGS(fs_info, flags, num_bytes, state, ret),
> +	TP_ARGS(fs_info, flags, num_bytes, state, ret, for_preempt),
>  
>  	TP_STRUCT__entry_btrfs(
>  		__field(	u64,	flags			)
>  		__field(	u64,	num_bytes		)
>  		__field(	int,	state			)
>  		__field(	int,	ret			)
> +		__field(	int,	for_preempt		)
>  	),
>  
>  	TP_fast_assign_btrfs(fs_info,
> @@ -1128,15 +1129,16 @@ TRACE_EVENT(btrfs_flush_space,
>  		__entry->num_bytes	=	num_bytes;
>  		__entry->state		=	state;
>  		__entry->ret		=	ret;
> +		__entry->for_preempt	=	for_preempt;
>  	),
>  
> -	TP_printk_btrfs("state=%d(%s) flags=%llu(%s) num_bytes=%llu ret=%d",
> +	TP_printk_btrfs("state=%d(%s) flags=%llu(%s) num_bytes=%llu ret=%d for_preempt=%d",
>  		  __entry->state,
>  		  __print_symbolic(__entry->state, FLUSH_STATES),
>  		  __entry->flags,
>  		  __print_flags((unsigned long)__entry->flags, "|",
>  				BTRFS_GROUP_FLAGS),
> -		  __entry->num_bytes, __entry->ret)
> +		  __entry->num_bytes, __entry->ret, __entry->for_preempt)
>  );
>  
>  DECLARE_EVENT_CLASS(btrfs__reserved_extent,
> -- 
> 2.26.2
