Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0661032447B
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Feb 2021 20:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbhBXTQb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Feb 2021 14:16:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:33216 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234927AbhBXTQV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Feb 2021 14:16:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D7EC7AB95;
        Wed, 24 Feb 2021 19:15:37 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 08C5CDA734; Wed, 24 Feb 2021 20:13:37 +0100 (CET)
Date:   Wed, 24 Feb 2021 20:13:37 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Maheep Kumar Kathuria <me@maheepk.net>
Cc:     clm@fb.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: Fixed a brace coding style issue
Message-ID: <20210224191337.GB1993@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Maheep Kumar Kathuria <me@maheepk.net>,
        clm@fb.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210215150820.83069-1-me@maheepk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210215150820.83069-1-me@maheepk.net>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Feb 15, 2021 at 08:38:20PM +0530, Maheep Kumar Kathuria wrote:
> Fixed a coding style issue in thresh_exec_hook()
> 
> Signed-off-by: Maheep Kumar Kathuria <me@maheepk.net>
> ---
>  fs/btrfs/async-thread.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/async-thread.c b/fs/btrfs/async-thread.c
> index 309516e6a968..38abeff7af69 100644
> --- a/fs/btrfs/async-thread.c
> +++ b/fs/btrfs/async-thread.c
> @@ -212,9 +212,8 @@ static inline void thresh_exec_hook(struct __btrfs_workqueue *wq)
>  out:
>  	spin_unlock(&wq->thres_lock);
>  
> -	if (need_change) {
> +	if (need_change)
>  		workqueue_set_max_active(wq->normal_wq, wq->current_active);
> -	}

This is really a trivial change, have you checked if there are more?
Fixing them in a larger batch would be better than one by one.
