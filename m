Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B07103EDBCB
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Aug 2021 18:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbhHPQy5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Aug 2021 12:54:57 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:53624 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbhHPQy4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Aug 2021 12:54:56 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7901E21EAF;
        Mon, 16 Aug 2021 16:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629132864;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pqS6VQvixGzA6R8ckaOFc3g5p3XHnthlpPOMv59gYko=;
        b=DepPr2sI3OMoBtaeZ21yzILyRKT0V03xRST7Be4mmL3x293p3lqQZGx2nr88m3+ibFjeby
        pGCkScbMZotn29OXLfAfIUQZscNrNui2+rpvpPAhLz+zrVhf8Xc2KnhsSy56zrgl8/9czF
        a+1B1m8Jr7Pd7HbWtdpjMJTgQ6zhRxc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629132864;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pqS6VQvixGzA6R8ckaOFc3g5p3XHnthlpPOMv59gYko=;
        b=rR4lKh2L7YuFTukn4Dbd+u2Pmj0o1TxsL4RIU97BWKe9S2xSzyuNuqedbTC6T1HC3HREzv
        0pyNlo9Gy2nMiuAA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 6FC22A3B85;
        Mon, 16 Aug 2021 16:54:24 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B481EDA72C; Mon, 16 Aug 2021 18:51:28 +0200 (CEST)
Date:   Mon, 16 Aug 2021 18:51:28 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Marcos Paulo de Souza <mpdesouza@suse.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, nborisov@suse.com
Subject: Re: [PATCH 1/7] btrfs: Reorder btrfs_find_item arguments
Message-ID: <20210816165128.GH5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Marcos Paulo de Souza <mpdesouza@suse.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com, nborisov@suse.com
References: <20210804184854.10696-1-mpdesouza@suse.com>
 <20210804184854.10696-2-mpdesouza@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210804184854.10696-2-mpdesouza@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 04, 2021 at 03:48:48PM -0300, Marcos Paulo de Souza wrote:
> It's more natural do use objectid, type and offset, in this order, when
> dealing with btrfs keys.
> 
> No functional changes.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
>  fs/btrfs/backref.c | 9 ++++-----
>  fs/btrfs/ctree.c   | 2 +-
>  fs/btrfs/ctree.h   | 2 +-
>  3 files changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
> index f735b8798ba1..9e92faaafa02 100644
> --- a/fs/btrfs/backref.c
> +++ b/fs/btrfs/backref.c
> @@ -1691,8 +1691,8 @@ char *btrfs_ref_to_path(struct btrfs_root *fs_root, struct btrfs_path *path,
>  				btrfs_tree_read_unlock(eb);
>  			free_extent_buffer(eb);
>  		}
> -		ret = btrfs_find_item(fs_root, path, parent, 0,
> -				BTRFS_INODE_REF_KEY, &found_key);
> +		ret = btrfs_find_item(fs_root, path, parent, BTRFS_INODE_REF_KEY,
> +					0, &found_key);

Have you considered using the found_key as both input and output
parameter? As input it stores the objectid/key/offset parameters and
with no errors it's set to the found key.

All callers of the function already have a key and you add another
variable just for the one that changes in the iterations (eg. offset).
