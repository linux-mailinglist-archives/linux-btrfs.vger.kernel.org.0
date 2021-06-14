Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 685F83A627C
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Jun 2021 13:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234268AbhFNLBI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Jun 2021 07:01:08 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:58542 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234915AbhFNK7h (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Jun 2021 06:59:37 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 16B6321968;
        Mon, 14 Jun 2021 10:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623668253; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TmQo1l7bcMKWEFiclpc1QPil9mIidTMZ8Ob9PomebOU=;
        b=u1gqBZIJTdg4w6O6SSkSENApDDfJhuDM0tEu2HDHuAhuPd2zUtLmsDYNaqIw0aWg3AaJlk
        9KqrIhnkkykgjdvTZCl3d6ekNL+rqZpBCB+BrBOD25U3qZdZ2dQS9vZrfceP/a6tmZqT77
        JkjuBhhKWcB3kIi+WhTwk2e6uid0Evs=
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id CE758118DD;
        Mon, 14 Jun 2021 10:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623668253; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TmQo1l7bcMKWEFiclpc1QPil9mIidTMZ8Ob9PomebOU=;
        b=u1gqBZIJTdg4w6O6SSkSENApDDfJhuDM0tEu2HDHuAhuPd2zUtLmsDYNaqIw0aWg3AaJlk
        9KqrIhnkkykgjdvTZCl3d6ekNL+rqZpBCB+BrBOD25U3qZdZ2dQS9vZrfceP/a6tmZqT77
        JkjuBhhKWcB3kIi+WhTwk2e6uid0Evs=
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id z82pLxw2x2AmfwAALh3uQQ
        (envelope-from <nborisov@suse.com>); Mon, 14 Jun 2021 10:57:32 +0000
Subject: Re: [PATCH 4/4] btrfs: use the filemap_fdatawrite_wbc helper for
 delalloc shrinking
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1623419155.git.josef@toxicpanda.com>
 <bcf08d20f1894052eb6edc4c3f37bd44f6dcab60.1623419155.git.josef@toxicpanda.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <c5df2100-ff64-6ed1-a97b-5960b867de22@suse.com>
Date:   Mon, 14 Jun 2021 13:57:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <bcf08d20f1894052eb6edc4c3f37bd44f6dcab60.1623419155.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 11.06.21 г. 16:54, Josef Bacik wrote:
> sync_inode() has some holes that can cause problems if we're under heavy
> ENOSPC pressure.  If there's writeback running on a separate thread
> sync_inode() will skip writing the inode altogether.  What we really
> want is to make sure writeback has been started on all the pages to make
> sure we can see the ordered extents and wait on them if appropriate.
> Switch to this new helper which will allow us to accomplish this and
> avoid ENOSPC'ing early.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Nikolay Borisov <nborisov@suse.com>

> ---
>  fs/btrfs/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index c37271df2c6d..93d113991e2c 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -9680,7 +9680,7 @@ static int start_delalloc_inodes(struct btrfs_root *root,
>  			btrfs_queue_work(root->fs_info->flush_workers,
>  					 &work->work);
>  		} else {
> -			ret = sync_inode(inode, wbc);
> +			ret = filemap_fdatawrite_wbc(inode->i_mapping, wbc);
>  			btrfs_add_delayed_iput(inode);
>  			if (ret || wbc->nr_to_write <= 0)
>  				goto out;
> 
