Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1BAA483755
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jan 2022 20:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235963AbiACTCs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jan 2022 14:02:48 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:59254 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235959AbiACTCr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Jan 2022 14:02:47 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1ADA1210FA;
        Mon,  3 Jan 2022 19:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1641236566;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+oB+49Q2i+86GJ/3EVTgAQq/WrkezTCOyvzOHYXqyNk=;
        b=0+5CMPr2cQh8nWofxrSGKU+gPRwgnejpNUDXHTAMS92xVw2/KtSN8sd8qEzyKlgmKzgX4l
        xjHzCIecnB/dL17sJzTv12KlbXirId6MQZtfkzwlXfIprKJSFRTME7CsGW3rSG+oL6Zngz
        /zzmcDOmRwxHi0jSYj8k6SwYyfb78DE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1641236566;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+oB+49Q2i+86GJ/3EVTgAQq/WrkezTCOyvzOHYXqyNk=;
        b=IfV3e60MxJkcyqUpYNsoHm5WRQpxfiIDQ1Pjcy1rg2Tad4idZvSaybaBp/lczxM9U+CYYI
        KThl4r65nEUvXqBQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 08AA9A3B83;
        Mon,  3 Jan 2022 19:02:46 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3067FDA729; Mon,  3 Jan 2022 20:02:17 +0100 (CET)
Date:   Mon, 3 Jan 2022 20:02:17 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs: output more debug message for uncommitted
 transaction
Message-ID: <20220103190216.GR28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20211216114736.69757-1-wqu@suse.com>
 <20211216114736.69757-3-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216114736.69757-3-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 16, 2021 at 07:47:36PM +0800, Qu Wenruo wrote:
> The extra info like how many dirty bytes this uncommitted transaction
> has can be very helpful.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

This does not depend on the first patch, so I'll apply that now.

> ---
>  fs/btrfs/disk-io.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 42 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 5c598e124c25..25e0248e3c55 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -4491,6 +4491,47 @@ int btrfs_commit_super(struct btrfs_fs_info *fs_info)
>  	return btrfs_commit_transaction(trans);
>  }
>  
> +static void warn_about_uncommitted_trans(struct btrfs_fs_info *fs_info)
> +{
> +	struct btrfs_transaction *trans;
> +	struct btrfs_transaction *tmp;
> +	bool found = false;
> +
> +	if (likely(list_empty(&fs_info->trans_list)))
> +		return;
> +
> +	/*
> +	 * This function is only called at the very end of close_ctree(),
> +	 * thus no other running transaction, no need to take trans_lock.
> +	 */

I've added an assert

	ASSERT(test_bit(BTRFS_FS_CLOSING_DONE, &fs_info->flags));

just in case somebody would use it as a warning function outside of the
close_tree context.
