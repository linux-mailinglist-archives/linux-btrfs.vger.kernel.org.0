Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23CF049BA90
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jan 2022 18:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356718AbiAYRog (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Jan 2022 12:44:36 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:47292 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243199AbiAYRnh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Jan 2022 12:43:37 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 68E721F381;
        Tue, 25 Jan 2022 17:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643132614;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+ql0GFrFEXFCnMUcGF2qylYjzdrVwdGopSBs1LI55NE=;
        b=Yl7lxfeX2RpcY9kDtwP1xb6HDhYs+Yf7i8frmTFpNnCrK7b6TXgdE/cHWhmciEqy3/kU53
        fjb+7PI/57EpUzbmOJSUIHFBEaBI5cX55m0SQrr7anOBGaGHnN+YKQGbWKolzGxbRLIbzu
        bQ2cCGachC3/8txJqbsLL3whwho3OoM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643132614;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+ql0GFrFEXFCnMUcGF2qylYjzdrVwdGopSBs1LI55NE=;
        b=akVzHf4nzV+KjpunfKgkek1Zn482ljiWUbmkBuiYvJTFEJ1l8VK9Sl1ZddRwe5CIosjA2b
        HKNW5G3F28wGxBCg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 613BFA3B81;
        Tue, 25 Jan 2022 17:43:34 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id DE7CEDA7A9; Tue, 25 Jan 2022 18:42:53 +0100 (CET)
Date:   Tue, 25 Jan 2022 18:42:53 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/6] btrfs: speedup and avoid inode logging during
 rename/link
Message-ID: <20220125174253.GV14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <cover.1642676248.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1642676248.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 20, 2022 at 11:00:05AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Often rename and link operations need to update inodes that were logged
> before, and often they trigger inode logging when it's not possible to
> quickly determine if the inode was previously logged in the current
> transaction.
> 
> This patchset speedups renames either by updating more efficiently a
> previously logged directory or by avoiding triggering inode logging when
> not needed. This can make all the difference, specially before all the
> recent massive optimizations to directory logging between 5.16, upcoming
> 5.17 and other other changes in misc-next.
> 
> An openSUSE Tumbleweed user recently ran into an issue where package
> installation/upgrades with the zypper tool were very slow, and it turned
> out zypper was spending over 99% of its time on rename operations, which
> were doing directory logging, and some of the packages required renaming
> over 1700 files. The issue only happened on a 5.15 kernel, and it was
> indirectly caused by excessive inode eviction, happening almost 100x more
> when compared to 5.13, 5.14 and 5.16-rc[6,7,8] kernels. That in turn
> resulted in logging inodes during renames when that would not happen if
> inode eviction hadn't happen. More details on the changelogs of patches
> 3/6 to 5/6.
> 
> Filipe Manana (6):
>   btrfs: add helper to delete a dir entry from a log tree
>   btrfs: pass the dentry to btrfs_log_new_name() instead of the inode
>   btrfs: avoid logging all directory changes during renames
>   btrfs: stop doing unnecessary log updates during a rename
>   btrfs: avoid inode logging during rename and link when possible
>   btrfs: use single variable to track return value at btrfs_log_inode()

The patchset has been in for-next, I'm moving it to misc-next now, thanks.
