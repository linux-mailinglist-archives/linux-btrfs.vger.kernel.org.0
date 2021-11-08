Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6A6A449C83
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Nov 2021 20:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237084AbhKHTeC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Nov 2021 14:34:02 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:46344 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbhKHTeB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Nov 2021 14:34:01 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 352071FD50;
        Mon,  8 Nov 2021 19:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1636399876;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8uvUb6XF8GBduTqsUWqx5UDnou0+7nRays6Xo+Kvy3s=;
        b=l+Xocydo2/Lo3VB5ck1DcvxhXHuI6LimKZ6C4tu3udrAkUml3UVF06gd5C3fhuIJWLPizR
        8Qtvz7aBfVdzUpM+yKWBI7TYcAnUqCsVuN7t5Jub2RnlB+hmztZXUKBfx+8MVHt+TRIm73
        2UiPgt5zM6Z4wGDH+qxHj6RjFAqXCx4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1636399876;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8uvUb6XF8GBduTqsUWqx5UDnou0+7nRays6Xo+Kvy3s=;
        b=+RWGhFhVjudEK3SdlnYA9ijg/z+IF7mLhAwH/bSFerWATALslEoFiaN61Yb9e9xkExWSbp
        2qVtEXP19BR22rBg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 2D32FA3B83;
        Mon,  8 Nov 2021 19:31:16 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7EAA1DA799; Mon,  8 Nov 2021 20:30:37 +0100 (CET)
Date:   Mon, 8 Nov 2021 20:30:37 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/7] Cleanup btrfs_item_* related helpers
Message-ID: <20211108193037.GK28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1634842475.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1634842475.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 21, 2021 at 02:58:30PM -0400, Josef Bacik wrote:
> Hello,
> 
> We've got a lot of odd patterns with our btrfs_item* helpers.  In a lot of
> places we use teh btrfs_item_*_nr() helpers, in some places we get the
> btrfs_item and then use the direct helpers on that.  Our btrfs_item_key()
> helpers only take the slot.
> 
> Fix this up by using a leaf+slot combination everywhere, and only use the offset
> calculations in the helpers.
> 
> This gives us a net deletion of about 40 lines, and also allows me to more
> easily change the btrfs_item math when I change the size of btrfs_header in the
> future without needing to update all the callsites to pass in an extent buffer.
> 
> Thanks,
> 
> Josef Bacik (7):
>   btrfs: use btrfs_item_size_nr/btrfs_item_offset_nr everywhere
>   btrfs: add btrfs_set_item_*_nr() helpers
>   btrfs: make btrfs_file_extent_inline_item_len take a slot
>   btrfs: introduce item_nr token variant helpers
>   btrfs: drop the _nr from the item helpers
>   btrfs: remove the btrfs_item_end() helper
>   btrfs: rename btrfs_item_end_nr to btrfs_item_data_end

Added to misc-next, thanks. It's a big conflict surface but hopefully
all incorrect uses of the helpers in the old/new code should be caught
by a mismatching types of the parameters.
