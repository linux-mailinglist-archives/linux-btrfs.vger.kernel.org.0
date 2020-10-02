Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5182B280EF4
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Oct 2020 10:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgJBIaa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Oct 2020 04:30:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:55038 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbgJBIa3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 2 Oct 2020 04:30:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601627427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=+L/m6983WlsbJMggF0cKwokzdvsnJMttVPLU3QMcNfE=;
        b=NC5in5KJA5bltywHdpBuBsO6aiyU+o2C/p8pPOTGNSoHqzmgqyvm4fYhYL7OIsZTZ48DSr
        wt/ujf0k54sg4CJTwe4gBKgtYkSuq1ONJojsSInN1wgjMYgSHjenuK1XSplHg0QUI47S0s
        rAKfRcRogU2ZU9UrWNUxkl5qkUljL7c=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3F211AD31;
        Fri,  2 Oct 2020 08:30:27 +0000 (UTC)
Subject: Re: [PATCH 9/9] btrfs: add a trace class for dumping the current
 ENOSPC state
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1601495426.git.josef@toxicpanda.com>
 <bf8f40699e24ea12b405a580262d99016ce7ffa0.1601495426.git.josef@toxicpanda.com>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <777f67b3-8c6a-4bb1-1a0b-32b866018efc@suse.com>
Date:   Fri, 2 Oct 2020 11:30:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <bf8f40699e24ea12b405a580262d99016ce7ffa0.1601495426.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 30.09.20 г. 23:01 ч., Josef Bacik wrote:
> Often when I'm debugging ENOSPC related issues I have to resort to
> printing the entire ENOSPC state with trace_printk() in different spots.
> This gets pretty annoying, so add a trace state that does this for us.
> Then add a trace point at the end of preemptive flushing so you can see
> the state of the space_info when we decide to exit preemptive flushing.
> This helped me figure out we weren't kicking in the preemptive flushing
> soon enough.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/space-info.c        |  1 +
>  include/trace/events/btrfs.h | 62 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 63 insertions(+)
> 
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index b9735e7de480..6f569a7d2df4 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -1109,6 +1109,7 @@ static void btrfs_preempt_reclaim_metadata_space(struct work_struct *work)
>  	/* We only went through once, back off our clamping. */
>  	if (loops == 1 && !space_info->reclaim_size)
>  		space_info->clamp = max(1, space_info->clamp - 1);
> +	trace_btrfs_done_preemptive_reclaim(fs_info, space_info);
>  	spin_unlock(&space_info->lock);
>  }
>  
> diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
> index c340bff65450..651ac47a6945 100644
> --- a/include/trace/events/btrfs.h
> +++ b/include/trace/events/btrfs.h
> @@ -2027,6 +2027,68 @@ TRACE_EVENT(btrfs_convert_extent_bit,
>  		  __print_flags(__entry->clear_bits, "|", EXTENT_FLAGS))
>  );
>  
> +DECLARE_EVENT_CLASS(btrfs_dump_space_info,
> +	TP_PROTO(const struct btrfs_fs_info *fs_info,
> +		 const struct btrfs_space_info *sinfo),
> +
> +	TP_ARGS(fs_info, sinfo),
> +
> +	TP_STRUCT__entry_btrfs(
> +		__field(	u64,	flags			)
> +		__field(	u64,	total_bytes		)
> +		__field(	u64,	bytes_used		)
> +		__field(	u64,	bytes_pinned		)
> +		__field(	u64,	bytes_reserved		)
> +		__field(	u64,	bytes_may_use		)
> +		__field(	u64,	bytes_readonly		)
> +		__field(	u64,	reclaim_size		)
> +		__field(	int,	clamp			)
> +		__field(	u64,	global_reserved		)
> +		__field(	u64,	trans_reserved		)
> +		__field(	u64,	delayed_refs_reserved	)
> +		__field(	u64,	delayed_reserved	)
> +		__field(	u64,	free_chunk_space	)
> +	),
> +
> +	TP_fast_assign_btrfs(fs_info,
> +		__entry->flags			=	sinfo->flags;
> +		__entry->total_bytes		=	sinfo->total_bytes;
> +		__entry->bytes_used		=	sinfo->bytes_used;
> +		__entry->bytes_pinned		=	sinfo->bytes_pinned;
> +		__entry->bytes_reserved		=	sinfo->bytes_reserved;
> +		__entry->bytes_may_use		=	sinfo->bytes_may_use;
> +		__entry->bytes_readonly		=	sinfo->bytes_readonly;
> +		__entry->reclaim_size		=	sinfo->reclaim_size;
> +		__entry->clamp			=	sinfo->clamp;
> +		__entry->global_reserved	=	fs_info->global_block_rsv.reserved;
> +		__entry->trans_reserved		=	fs_info->trans_block_rsv.reserved;
> +		__entry->delayed_refs_reserved	=	fs_info->delayed_refs_rsv.reserved;
> +		__entry->delayed_reserved	=	fs_info->delayed_block_rsv.reserved;
> +		__entry->free_chunk_space	=	atomic64_read(&fs_info->free_chunk_space);
> +	),
> +
> +	TP_printk_btrfs("flags=%s total_bytes=%llu bytes_used=%llu "
> +			"bytes_pinned=%llu bytes_reserved=%llu "
> +			"bytes_may_use=%llu bytes_readonly=%llu "
> +			"reclaim_size=%llu clamp=%d global_reserved=%llu "
> +			"trans_reserved=%llu delayed_refs_reserved=%llu "
> +			"delayed_reserved=%llu chunk_free_space=%llu",
> +			__print_flags(__entry->flags, "|", BTRFS_GROUP_FLAGS),
> +			__entry->total_bytes, __entry->bytes_used,
> +			__entry->bytes_pinned, __entry->bytes_reserved,
> +			__entry->bytes_may_use, __entry->bytes_readonly,
> +			__entry->reclaim_size, __entry->clamp,
> +			__entry->global_reserved, __entry->trans_reserved,
> +			__entry->delayed_refs_reserved,
> +			__entry->delayed_reserved, __entry->free_chunk_space)
> +);
> +
> +DEFINE_EVENT(btrfs_dump_space_info, btrfs_done_preemptive_reclaim,
> +	TP_PROTO(const struct btrfs_fs_info *fs_info,
> +		 const struct btrfs_space_info *sinfo),
> +	TP_ARGS(fs_info, sinfo)
> +);


I think this could be just a TRACE_EVENT, do you expect to define
further events based on the same class ?

> +
>  TRACE_EVENT(btrfs_add_reserve_ticket,
>  	TP_PROTO(const struct btrfs_fs_info *fs_info, u64 flags, int flush,
>  		 u64 bytes),
> 
