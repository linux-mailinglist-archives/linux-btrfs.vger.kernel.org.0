Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08CF79DA37
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Sep 2023 22:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbjILUqt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Sep 2023 16:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjILUqs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Sep 2023 16:46:48 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1AC7E64;
        Tue, 12 Sep 2023 13:46:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4A55721846;
        Tue, 12 Sep 2023 20:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694551603;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WJPt1Ma6uz/tVf5cIdZMMrc9e/GB1GVwEHWdMe4+sgo=;
        b=TkcgUmX0U9L1ipNnvdCxJMjNDSJ39ZjrfPRFu0633zMYFXfbpxcjoRA5fxdY70BcEjrqSY
        AsFDvT3bzOqnNKxSZ2f/A02OX0MnodtvS/UmhijRyBAOgKB7JYG88MK/MYEOqrVeedZwdK
        0225mbo6Jzyb/ExTYMFPKOMvMvIvOJ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694551603;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WJPt1Ma6uz/tVf5cIdZMMrc9e/GB1GVwEHWdMe4+sgo=;
        b=DuE3zRidJeBOm3PX8pzQo6hokbLUM7B33wmYgvP3LJhQnYu9oxPx2C5nf9lmDfGoo0sN8Y
        YMt1IiJ+g8EUnKBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0ADF7139DB;
        Tue, 12 Sep 2023 20:46:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Wr/VATPOAGXVBQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 12 Sep 2023 20:46:43 +0000
Date:   Tue, 12 Sep 2023 22:46:41 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Naohiro Aota <naohiro.aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 10/11] btrfs: add trace events for RST
Message-ID: <20230912204641.GG20408@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230911-raid-stripe-tree-v8-0-647676fa852c@wdc.com>
 <20230911-raid-stripe-tree-v8-10-647676fa852c@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911-raid-stripe-tree-v8-10-647676fa852c@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 11, 2023 at 05:52:11AM -0700, Johannes Thumshirn wrote:
> Add trace events for raid-stripe-tree operations.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/raid-stripe-tree.c  |  8 +++++
>  include/trace/events/btrfs.h | 75 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 83 insertions(+)
> 
> diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
> index 7ed02e4b79ec..5a9952cf557c 100644
> --- a/fs/btrfs/raid-stripe-tree.c
> +++ b/fs/btrfs/raid-stripe-tree.c
> @@ -62,6 +62,9 @@ int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start,
>  		if (found_end <= start)
>  			break;
>  
> +		trace_btrfs_raid_extent_delete(fs_info, start, end,
> +					       found_start, found_end);
> +
>  		ASSERT(found_start >= start && found_end <= end);
>  		ret = btrfs_del_item(trans, stripe_root, path);
>  		if (ret)
> @@ -120,6 +123,8 @@ static int btrfs_insert_one_raid_extent(struct btrfs_trans_handle *trans,
>  		return -ENOMEM;
>  	}
>  
> +	trace_btrfs_insert_one_raid_extent(fs_info, bioc->logical, bioc->size,
> +					   num_stripes);
>  	btrfs_set_stack_stripe_extent_encoding(stripe_extent, encoding);
>  	for (int i = 0; i < num_stripes; i++) {
>  		u64 devid = bioc->stripes[i].dev->devid;
> @@ -445,6 +450,9 @@ int btrfs_get_raid_extent_offset(struct btrfs_fs_info *fs_info,
>  
>  		stripe->physical = physical + offset;
>  
> +		trace_btrfs_get_raid_extent_offset(fs_info, logical, *length,
> +						   stripe->physical, devid);
> +
>  		ret = 0;
>  		goto free_path;
>  	}
> diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
> index b2db2c2f1c57..e2c6f1199212 100644
> --- a/include/trace/events/btrfs.h
> +++ b/include/trace/events/btrfs.h
> @@ -2497,6 +2497,81 @@ DEFINE_EVENT(btrfs_raid56_bio, raid56_write,
>  	TP_ARGS(rbio, bio, trace_info)
>  );
>  
> +TRACE_EVENT(btrfs_insert_one_raid_extent,
> +
> +	TP_PROTO(struct btrfs_fs_info *fs_info, u64 logical, u64 length,

const struct fs_info

> +		 int num_stripes),
> +
> +	TP_ARGS(fs_info, logical, length, num_stripes),
> +
> +	TP_STRUCT__entry_btrfs(
> +		__field(	u64,	logical		)
> +		__field(	u64,	length		)
> +		__field(	int,	num_stripes	)
> +	),
> +
> +	TP_fast_assign_btrfs(fs_info,
> +		__entry->logical	= logical;
> +		__entry->length		= length;
> +		__entry->num_stripes	= num_stripes;
> +	),
> +
> +	TP_printk_btrfs("logical=%llu, length=%llu, num_stripes=%d",
> +			__entry->logical, __entry->length,
> +			__entry->num_stripes)

Tracepoint messages should follow the formatting guidelines
https://btrfs.readthedocs.io/en/latest/dev/Development-notes.html#tracepoints

> +);
> +
> +TRACE_EVENT(btrfs_raid_extent_delete,
> +
> +	TP_PROTO(struct btrfs_fs_info *fs_info, u64 start, u64 end,
> +		 u64 found_start, u64 found_end),
> +
> +	TP_ARGS(fs_info, start, end, found_start, found_end),
> +
> +	TP_STRUCT__entry_btrfs(
> +		__field(	u64,	start		)
> +		__field(	u64,	end		)
> +		__field(	u64,	found_start	)
> +		__field(	u64,	found_end	)
> +	),
> +
> +	TP_fast_assign_btrfs(fs_info,
> +		__entry->start	=	start;
> +		__entry->end	=	end;
> +		__entry->found_start =	found_start;
> +		__entry->found_end =	found_end;

Tracepoints follow the fancy spacing and alignment in the assign blocks.

> +	),
> +
> +	TP_printk_btrfs("start=%llu, end=%llu, found_start=%llu, found_end=%llu",
> +			__entry->start, __entry->end, __entry->found_start,
> +			__entry->found_end)
> +);
