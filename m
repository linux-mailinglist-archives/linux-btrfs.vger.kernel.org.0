Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF6D2399239
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Jun 2021 20:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbhFBSLM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Jun 2021 14:11:12 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:43848 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229467AbhFBSLI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Jun 2021 14:11:08 -0400
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id CB6761FD2D;
        Wed,  2 Jun 2021 18:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622657364;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rUjxuSKJqqkqeER+dfkQR8fUwFRG+/DQrKiiR8nGLOo=;
        b=mPfITO2I9IiSF7ojR/NNMt9Xzyu4DEsevK6bGmksKqsGfqtiRj8JUjURgDHFIbxEiHRN9C
        zRwqBUJK4NJZmCbTifVTnYkK4aDRxe7Xevig/enBcQZuc8C4pycy+XdhcuUUEJN5vy55BX
        TpaEAlm+EiAvAE/JotxnHPgkdlyK4cQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622657364;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rUjxuSKJqqkqeER+dfkQR8fUwFRG+/DQrKiiR8nGLOo=;
        b=13qRtAdfGN9hTKruRgcjVeDPGmly/+Sv41OyEmwBr+ZjGGxgBzHvGS0DKNfC0F9lXg/5y8
        L1ej6+9JBZmJV2CA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id C508CA3D41;
        Wed,  2 Jun 2021 18:09:24 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id EF167DA83F; Wed,  2 Jun 2021 18:48:03 +0200 (CEST)
Date:   Wed, 2 Jun 2021 18:48:03 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Ritesh Harjani <riteshh@linux.ibm.com>
Subject: Re: [PATCH v4 27/30] btrfs: fix a use-after-free bug in writeback
 subpage helper
Message-ID: <20210602164803.GP31483@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Ritesh Harjani <riteshh@linux.ibm.com>
References: <20210531085106.259490-1-wqu@suse.com>
 <20210531085106.259490-28-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210531085106.259490-28-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 31, 2021 at 04:51:03PM +0800, Qu Wenruo wrote:
> [BUG]
> There is a possible use-after-free bug when running generic/095.
> 
>  BUG: Unable to handle kernel data access on write at 0x6b6b6b6b6b6b725b
>  Faulting instruction address: 0xc000000000283654
>  c000000000283078 do_raw_spin_unlock+0x88/0x230
>  c0000000012b1e14 _raw_spin_unlock_irqrestore+0x44/0x90
>  c000000000a918dc btrfs_subpage_clear_writeback+0xac/0xe0
>  c0000000009e0458 end_bio_extent_writepage+0x158/0x270
>  c000000000b6fd14 bio_endio+0x254/0x270
>  c0000000009fc0f0 btrfs_end_bio+0x1a0/0x200
>  c000000000b6fd14 bio_endio+0x254/0x270
>  c000000000b781fc blk_update_request+0x46c/0x670
>  c000000000b8b394 blk_mq_end_request+0x34/0x1d0
>  c000000000d82d1c lo_complete_rq+0x11c/0x140
>  c000000000b880a4 blk_complete_reqs+0x84/0xb0
>  c0000000012b2ca4 __do_softirq+0x334/0x680
>  c0000000001dd878 irq_exit+0x148/0x1d0
>  c000000000016f4c do_IRQ+0x20c/0x240
>  c000000000009240 hardware_interrupt_common_virt+0x1b0/0x1c0
> 
> [CAUSE]
> There is very small race window like the following in generic/095.
> 
> 	Thread 1		|		Thread 2
> --------------------------------+------------------------------------
>   end_bio_extent_writepage()	| btrfs_releasepage()
>   |- spin_lock_irqsave()	| |
>   |- end_page_writeback()	| |
>   |				| |- if (PageWriteback() ||...)
>   |				| |- clear_page_extent_mapped()
>   |				|    |- kfree(subpage);
>   |- spin_unlock_irqrestore().
> 
> The race can also happen between writeback and btrfs_invalidatepage(),
> although that would be much harder as btrfs_invalidatepage() has much
> more work to do before the clear_page_extent_mapped() call.
> 
> [FIX]
> Here we "wait" for the subapge spinlock to be released before we detach
> subpage structure.
> So this patch will introduce a new function, wait_subpage_spinlock(), to
> do the "wait" by acquiring the spinlock and release it.
> 
> Since the caller has ensured the page is not dirty nor writeback, and
> page is already locked, the only way to hold the subpage spinlock is
> from endio function.
> Thus we only need to acquire the spinlock to wait for any existing
> holder.

The lock/unlock as synchronization is racy in general but for this
particular case it's safe. The endio is late and if the invalidate
page is there early, the lock properly serializes end of work in endio
and start of work in invalidate page. The critical point is that once
endio releases the lock, ther's no way anything else than race in again
and run in parllalel with invalidate. Or that would be some other bug on
a higher level. Ok.
