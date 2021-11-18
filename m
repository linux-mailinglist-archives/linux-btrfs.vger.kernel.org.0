Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19527455AC2
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Nov 2021 12:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344087AbhKRLnE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Nov 2021 06:43:04 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:38550 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344412AbhKRLlB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Nov 2021 06:41:01 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 246371FD29;
        Thu, 18 Nov 2021 11:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637235481;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/WLnHx0QShvT5z0YSeVCbnYKCZLddOFHLmCDt/S7niQ=;
        b=sHAvt0dkVkoZweTrnURiS7sNrqqVzNjQgLa7BBfJnSlzZk8uqIRzHNBjfkMndAoou+lRk+
        b/yVfdsPlBsoxOPBpTWyE0zAfdI0XvIW4f3AoKoKAiRL+CmQNxH2gx+3TvN1mIQP7DmA36
        XwxIEonqihHZSEGIpuibdjRKmFpLm1o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637235481;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/WLnHx0QShvT5z0YSeVCbnYKCZLddOFHLmCDt/S7niQ=;
        b=BoEj+CVhBYwH0dA8NBsj12Z0oUKEIMqPbwMlLPKIZA2+Zaq8/DhNsw+nqI4eosq2JeVuww
        PkY4ZjK/QAl/WbBA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 1C904A3B83;
        Thu, 18 Nov 2021 11:38:01 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BA47ADA735; Thu, 18 Nov 2021 12:37:56 +0100 (CET)
Date:   Thu, 18 Nov 2021 12:37:56 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: remove unnecessary @nr_written parameters
Message-ID: <20211118113756.GX28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20211112053314.30009-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211112053314.30009-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 12, 2021 at 01:33:14PM +0800, Qu Wenruo wrote:
> We use @nr_written to record how many pages have been started by
> btrfs_run_delalloc_range().
> 
> Currently there are only two cases that would populate @nr_written:
> 
> - Inline extent creation
> - Compressed write
> 
> But both cases will also set @page_started to one.
> 
> In fact, in writepage_delalloc() we have the following code, showing
> that @nr_written is really only utilized for above two cases:
> 
> 	/* did the fill delalloc function already unlock and start
> 	 * the IO?
> 	 */
> 	if (page_started) {
> 		/*
> 		 * we've unlocked the page, so we can't update
> 		 * the mapping's writeback index, just update
> 		 * nr_to_write.
> 		 */
> 		wbc->nr_to_write -= nr_written;
> 		return 1;
> 	}
> 
> But for such cases, writepage_delalloc() will return 1, and exit
> __extent_writepage() without going through __extent_writepage_io().
> 
> Thus this means, inside __extent_writepage_io(), we always get
> @nr_written as 0.
> 
> So this patch is going to remove the unnecessary parameter from the
> following functions:
> 
> - writepage_delalloc()
> 
>   As @nr_written passed in is always the initial value 0.
> 
>   Although inside that function, we still need a local @nr_written
>   to update wbc->nr_to_write.
> 
> - __extent_writepage_io()
> 
>   As explained above, @nr_written passed in can only be 0.
> 
>   This also means we can remove one update_nr_written() call.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to misc-next, thanks.
