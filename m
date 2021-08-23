Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EACFC3F510F
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Aug 2021 21:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbhHWTMh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Aug 2021 15:12:37 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:58938 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbhHWTMg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Aug 2021 15:12:36 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E59F91FFDC;
        Mon, 23 Aug 2021 19:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629745912;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B+/2sMMhdKAOULvnn7NPdqH1HHLOCHhzUgKtUSJvEGw=;
        b=poou9KBRMrR+Fhl0JeWYNmMGzJ5BVnJZAYECWaCkaBN/ZQjCKxY5Zv83ii/NI0fEG2llK4
        uKueSJ1dWJXMXQ8gmZEyJxQ11/g8yTxwXSeOoYR8j24zc3wxulxbjRwpUHJ2GQa//p5nam
        1ge7TeEq1mj5t6cWQSajQbVhtUAVMnc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629745912;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B+/2sMMhdKAOULvnn7NPdqH1HHLOCHhzUgKtUSJvEGw=;
        b=cPQkbNdMfLq2jQFLpKzl9z/H43JJwOdZIIdGYlob1i3pg3QZPgf28or3Mqnph0tYyG23s/
        08nxrPv/xWPN3tCw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id DECFDA3B84;
        Mon, 23 Aug 2021 19:11:52 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5C8A9DA725; Mon, 23 Aug 2021 21:08:53 +0200 (CEST)
Date:   Mon, 23 Aug 2021 21:08:53 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v5 05/11] btrfs: defrag: introduce a new helper to
 collect target file extents
Message-ID: <20210823190853.GP5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210806081242.257996-1-wqu@suse.com>
 <20210806081242.257996-6-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210806081242.257996-6-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 06, 2021 at 04:12:36PM +0800, Qu Wenruo wrote:
> Introduce a new helper, defrag_collect_targets(), to collect all
> possible targets to be defragged.
> 
> This function will not consider things like max_sectors_to_defrag, thus
> caller should be responsible to ensure we don't exceed the limit.
> 
> This function will be the first stage of later defrag rework.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/ioctl.c | 120 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 120 insertions(+)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index c0639780f99c..043c44daa5ae 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -1427,6 +1427,126 @@ static int cluster_pages_for_defrag(struct inode *inode,
>  
>  }
>  
> +struct defrag_target_range {
> +	struct list_head list;
> +	u64 start;
> +	u64 len;
> +};
> +
> +/*
> + * Helper to collect all valid target extents.

Please use wording like "Collect all the valid ...", ie. drop any "This
function does ..." or "Helper to do ..."
