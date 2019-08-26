Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6C59D5E0
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2019 20:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730869AbfHZSgQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Aug 2019 14:36:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:35674 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729855AbfHZSgQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Aug 2019 14:36:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 723B9AD45;
        Mon, 26 Aug 2019 18:36:15 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3B4B9DA98E; Mon, 26 Aug 2019 20:36:39 +0200 (CEST)
Date:   Mon, 26 Aug 2019 20:36:39 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs-progs: don't check nbytes on unlinked files
Message-ID: <20190826183639.GD2752@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20190809131831.26370-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809131831.26370-1-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 09, 2019 at 09:18:31AM -0400, Josef Bacik wrote:
> We don't update the inode when evicting it, so the nbytes will be wrong
> in between transaction commits.  This isn't a problem, stop complaining
> about it to make generic/269 stop randomly failing.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Added to devel, thanks.
> ---
>  check/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/check/main.c b/check/main.c
> index ca2ace10..45726e6e 100644
> --- a/check/main.c
> +++ b/check/main.c
> @@ -807,7 +807,7 @@ static void maybe_free_inode_rec(struct cache_tree *inode_cache,
>  	} else if (S_ISREG(rec->imode) || S_ISLNK(rec->imode)) {
>  		if (rec->found_dir_item)
>  			rec->errors |= I_ERR_ODD_DIR_ITEM;
> -		if (rec->found_size != rec->nbytes)
> +		if (rec->nlink > 0 && rec->found_size != rec->nbytes)

I've added a comment above the line.
