Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8315452C7
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jun 2022 19:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245409AbiFIRR1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Jun 2022 13:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243030AbiFIRR1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Jun 2022 13:17:27 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B331846C8E
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Jun 2022 10:17:25 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id B8EF55C013C;
        Thu,  9 Jun 2022 13:17:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 09 Jun 2022 13:17:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1654795042; x=1654881442; bh=XySuRvdPii
        Qnrhm1TDv/LTsFNkNGC6HE7BTNI9rjsGo=; b=cbzm7P2jC/oQIE9oJdqOJmx8Jn
        L8pTm4vp8D3XoK4b1t3zb008Ep7l85J7clMCqZuPYxUJauvsPuhkKJz88Q1HTDoL
        tsyPP8NJdQqAYraJAzxKkLHrvThD2+vL/mAClZX+ei1hQAU6crOeBQ4iuwS9ebip
        OlCoJ2KAnaM2hyzR86m5hvbxZkVIZvSex9nRbeaqAkGTGrX3ap6MMVAhPQ6V7uCV
        tCmr74tpvoSGafkrygD5p+T4Hm/eoUXhPwPvOan6BJnlryPAr7Bj5tzGDA8/jpDp
        FzEudw3F5o5pXM//kB/UM0aR7BpOTerhfa0sz9PgK2x5JCY/5wrIEqZGIFPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1654795042; x=1654881442; bh=XySuRvdPiiQnrhm1TDv/LTsFNkNG
        C6HE7BTNI9rjsGo=; b=maBwGO0ivNC6JwkzENCypXEF0ZM6EyuTWFgd4Zn3ukGS
        PvzTkQ4s9b/WDuPd4pr1GJpJNHZWbZUDx9vQBpttogCrJLCroJ5kDfeqx6B5GKvK
        j4HNecgOuYl44QInLxs3zfE1Q5lhhFm/4+6ZP49oH9UYFgeUZkHQQhEcKhaV/GHL
        KaLYyorz/tMThU5s6qF++xSsxulcUfrWcn9vPK2TJmRll1OshBIafpXHjek6UinS
        VDjOHHDsBDQWSLNvUxUfFLjm0dY2kzO/1Fk+zY9iyK+eNITEdKdjb0yvFYWQHnFn
        P+kAxhhvs/loMIyXZZcedB+vToVX3PCD/Gz62KEZpg==
X-ME-Sender: <xms:IiuiYuweSwUmSP2Zh8owbn8qa62zJBLEM0A8XlUdjTxJfH4neZ4rzg>
    <xme:IiuiYqROSjBLRiAHKWtZiEyRRClfYDF3iu2tAo9hA3MNCA_zvqTM2uum4-OaD7ONQ
    efUJjfjhifqMWu1UTY>
X-ME-Received: <xmr:IiuiYgUs2wBjtFjShwdjvlEjUJ0aBkWvbZJ1v9zmZrMHHRIC746bglSbymxfDnuMArxLeoPJ_vTxQylZqbD8kue97JCBUg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedruddtledguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhr
    ihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnh
    epkedvkeffjeellefhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhish
    essghurhdrihho
X-ME-Proxy: <xmx:IiuiYkioXXZyPu_70zgpvG5EexsYpS7jHgCSyzqPyfXiBuzPFr5U4g>
    <xmx:IiuiYgAbtVmNfpAab7X_v3C3PGUX4w642uUCAFKlcbYKIyV0CIF11Q>
    <xmx:IiuiYlIbRU3vjpA498rIyMqdXFjtJ9Ll-QvL8_iWNhq3_NZyD5cSbQ>
    <xmx:IiuiYp50VpNHzv5_Frib3M9T8j61m1TXdTFEOIL6QWhdy_m-2-6eCw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jun 2022 13:17:21 -0400 (EDT)
Date:   Thu, 9 Jun 2022 10:17:20 -0700
From:   Boris Burkov <boris@bur.io>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.cz>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: add tracepoints for ordered extents
Message-ID: <YqIrIHrqTq/0BugE@zen>
References: <6bd882fd0562b8b18600629f7d0504f98c560dcf.1654792073.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bd882fd0562b8b18600629f7d0504f98c560dcf.1654792073.git.johannes.thumshirn@wdc.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 09, 2022 at 09:28:04AM -0700, Johannes Thumshirn wrote:
> When debugging a reference counting issue with ordered extents, I've found
> we're lacking a lot of tracepoint coverage in the ordered-extent code.
> 
> Close these gaps by adding tracepoints after every refcount_inc() in the
> ordered-extent code.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Looks good, I see the new tracepoints. I think it would be helpful for
posterity to motivate why refcount_inc is what we want to trace.

Reviewed-by: Boris Burkov <boris@bur.io>

> ---
>  fs/btrfs/ordered-data.c      | 19 +++++++++--
>  include/trace/events/btrfs.h | 64 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 80 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
> index dc88d2b3721f..41b3bc44c92b 100644
> --- a/fs/btrfs/ordered-data.c
> +++ b/fs/btrfs/ordered-data.c
> @@ -401,6 +401,7 @@ void btrfs_mark_ordered_io_finished(struct btrfs_inode *inode,
>  			set_bit(BTRFS_ORDERED_IO_DONE, &entry->flags);
>  			cond_wake_up(&entry->wait);
>  			refcount_inc(&entry->refs);
> +			trace_btrfs_ordered_extent_mark_finished(inode, entry);
>  			spin_unlock_irqrestore(&tree->lock, flags);
>  			btrfs_init_work(&entry->work, finish_func, NULL, NULL);
>  			btrfs_queue_work(wq, &entry->work);
> @@ -473,6 +474,7 @@ bool btrfs_dec_test_ordered_pending(struct btrfs_inode *inode,
>  	if (finished && cached && entry) {
>  		*cached = entry;
>  		refcount_inc(&entry->refs);
> +		trace_btrfs_ordered_extent_dec_test_pending(inode, entry);
>  	}
>  	spin_unlock_irqrestore(&tree->lock, flags);
>  	return finished;
> @@ -807,8 +809,10 @@ struct btrfs_ordered_extent *btrfs_lookup_ordered_extent(struct btrfs_inode *ino
>  	entry = rb_entry(node, struct btrfs_ordered_extent, rb_node);
>  	if (!in_range(file_offset, entry->file_offset, entry->num_bytes))
>  		entry = NULL;
> -	if (entry)
> +	if (entry) {
>  		refcount_inc(&entry->refs);
> +		trace_btrfs_ordered_extent_lookup(inode, entry);
> +	}
>  out:
>  	spin_unlock_irqrestore(&tree->lock, flags);
>  	return entry;
> @@ -848,8 +852,10 @@ struct btrfs_ordered_extent *btrfs_lookup_ordered_range(
>  			break;
>  	}
>  out:
> -	if (entry)
> +	if (entry) {
>  		refcount_inc(&entry->refs);
> +		trace_btrfs_ordered_extent_lookup_range(inode, entry);
> +	}
>  	spin_unlock_irq(&tree->lock);
>  	return entry;
>  }
> @@ -878,6 +884,7 @@ void btrfs_get_ordered_extents_for_logging(struct btrfs_inode *inode,
>  		ASSERT(list_empty(&ordered->log_list));
>  		list_add_tail(&ordered->log_list, list);
>  		refcount_inc(&ordered->refs);
> +		trace_btrfs_ordered_extent_lookup_for_logging(inode, ordered);
>  	}
>  	spin_unlock_irq(&tree->lock);
>  }
> @@ -901,6 +908,7 @@ btrfs_lookup_first_ordered_extent(struct btrfs_inode *inode, u64 file_offset)
>  
>  	entry = rb_entry(node, struct btrfs_ordered_extent, rb_node);
>  	refcount_inc(&entry->refs);
> +	trace_btrfs_ordered_extent_lookup_first(inode, entry);
>  out:
>  	spin_unlock_irq(&tree->lock);
>  	return entry;
> @@ -975,8 +983,11 @@ struct btrfs_ordered_extent *btrfs_lookup_first_ordered_range(
>  	/* No ordered extent in the range */
>  	entry = NULL;
>  out:
> -	if (entry)
> +	if (entry) {
>  		refcount_inc(&entry->refs);
> +		trace_btrfs_ordered_extent_lookup_first_range(inode, entry);
> +	}
> +
>  	spin_unlock_irq(&tree->lock);
>  	return entry;
>  }
> @@ -1055,6 +1066,8 @@ int btrfs_split_ordered_extent(struct btrfs_ordered_extent *ordered, u64 pre,
>  	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
>  	int ret = 0;
>  
> +	trace_btrfs_ordered_extent_split(BTRFS_I(inode), ordered);
> +
>  	spin_lock_irq(&tree->lock);
>  	/* Remove from tree once */
>  	node = &ordered->rb_node;
> diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
> index 29fa8ea2cc0f..73df80d462dc 100644
> --- a/include/trace/events/btrfs.h
> +++ b/include/trace/events/btrfs.h
> @@ -598,6 +598,70 @@ DEFINE_EVENT(btrfs__ordered_extent, btrfs_ordered_extent_put,
>  	TP_ARGS(inode, ordered)
>  );
>  
> +DEFINE_EVENT(btrfs__ordered_extent, btrfs_ordered_extent_lookup,
> +
> +	     TP_PROTO(const struct btrfs_inode *inode,
> +		      const struct btrfs_ordered_extent *ordered),
> +
> +	     TP_ARGS(inode, ordered)
> +);
> +
> +DEFINE_EVENT(btrfs__ordered_extent, btrfs_ordered_extent_lookup_range,
> +
> +	     TP_PROTO(const struct btrfs_inode *inode,
> +		      const struct btrfs_ordered_extent *ordered),
> +
> +	     TP_ARGS(inode, ordered)
> +);
> +
> +DEFINE_EVENT(btrfs__ordered_extent, btrfs_ordered_extent_lookup_first_range,
> +
> +	     TP_PROTO(const struct btrfs_inode *inode,
> +		      const struct btrfs_ordered_extent *ordered),
> +
> +	     TP_ARGS(inode, ordered)
> +);
> +
> +DEFINE_EVENT(btrfs__ordered_extent, btrfs_ordered_extent_lookup_for_logging,
> +
> +	     TP_PROTO(const struct btrfs_inode *inode,
> +		      const struct btrfs_ordered_extent *ordered),
> +
> +	     TP_ARGS(inode, ordered)
> +);
> +
> +DEFINE_EVENT(btrfs__ordered_extent, btrfs_ordered_extent_lookup_first,
> +
> +	     TP_PROTO(const struct btrfs_inode *inode,
> +		      const struct btrfs_ordered_extent *ordered),
> +
> +	     TP_ARGS(inode, ordered)
> +);
> +
> +DEFINE_EVENT(btrfs__ordered_extent, btrfs_ordered_extent_split,
> +
> +	     TP_PROTO(const struct btrfs_inode *inode,
> +		      const struct btrfs_ordered_extent *ordered),
> +
> +	     TP_ARGS(inode, ordered)
> +);
> +
> +DEFINE_EVENT(btrfs__ordered_extent, btrfs_ordered_extent_dec_test_pending,
> +
> +	     TP_PROTO(const struct btrfs_inode *inode,
> +		      const struct btrfs_ordered_extent *ordered),
> +
> +	     TP_ARGS(inode, ordered)
> +);
> +
> +DEFINE_EVENT(btrfs__ordered_extent, btrfs_ordered_extent_mark_finished,
> +
> +	     TP_PROTO(const struct btrfs_inode *inode,
> +		      const struct btrfs_ordered_extent *ordered),
> +
> +	     TP_ARGS(inode, ordered)
> +);
> +
>  DECLARE_EVENT_CLASS(btrfs__writepage,
>  
>  	TP_PROTO(const struct page *page, const struct inode *inode,
> -- 
> 2.35.3
> 
