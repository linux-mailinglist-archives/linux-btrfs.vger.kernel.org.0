Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B80D7493F04
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jan 2022 18:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356387AbiASRZ4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Jan 2022 12:25:56 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:35664 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356376AbiASRZx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Jan 2022 12:25:53 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id BC8FC1F3A8;
        Wed, 19 Jan 2022 17:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642613152;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hsAfNXdBDSBd4WXrg2m1g+CShVLHlDRgr7uK3aSC9q0=;
        b=Y/8Xl2ye0XM384Ivkfe/daPhvTJ14yIPTKxoSOLfKS/QAP/9BAzDN6+ZZVgt6Q73rBHAnF
        lPOvsUPYSTbZEtOkc5n5SCUSBx602pBeNExFWPywCyrD7nbvyK2CPz2amcBxXU5770p0Yn
        PsWY5RumSksHkFcsck6uRnjlGxjvV1A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642613152;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hsAfNXdBDSBd4WXrg2m1g+CShVLHlDRgr7uK3aSC9q0=;
        b=NKZX3Frs0/xJUdhg3RjsfFvpAtXbo8ZAdBfwbmK9/lJ/+GI5uzNaY39fNMWxR+Utb9PnSq
        sloKaOa2wFi6qVDw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id B626AA3B85;
        Wed, 19 Jan 2022 17:25:52 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8E618DA7A3; Wed, 19 Jan 2022 18:25:15 +0100 (CET)
Date:   Wed, 19 Jan 2022 18:25:15 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs: defrag: properly update range->start for
 autodefrag
Message-ID: <20220119172515.GR14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <20220118115352.52126-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220118115352.52126-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 18, 2022 at 07:53:52PM +0800, Qu Wenruo wrote:
> [BUG]
> After commit 7b508037d4ca ("btrfs: defrag: use defrag_one_cluster() to
> implement btrfs_defrag_file()") autodefrag no longer properly re-defrag
> the file from previously finished location.
> 
> [CAUSE]
> The recent refactor on defrag only focuses on defrag ioctl subpage
> support, doesn't take auto defrag into consideration.
> 
> There are two problems involved which prevents autodefrag to restart its
> scan:
> 
> - No range.start update
>   Previously when one defrag target is found, range->start will be
>   updated to indicate where next search should start from.
> 
>   But now btrfs_defrag_file() doesn't update it anymore, making all
>   autodefrag to rescan from file offset 0.
> 
>   This would also make autodefrag to mark the same range dirty again and
>   again, causing extra IO.
> 
> - No proper quick exit for defrag_one_cluster()
>   Currently if we reached or exceed @max_sectors limit, we just exit
>   defrag_one_cluster(), and let next defrag_one_cluster() call to do a
>   quick exit.
>   This makes @cur increase, thus no way to properly know which range is
>   defragged and which range is skipped.
> 
> [FIX]
> The fix involves two modifications:
> 
> - Update range->start to next cluster start
>   This is a little different from the old behavior.
>   Previously range->start is updated to the next defrag target.
> 
>   But in the end, the behavior should still be pretty much the same,
>   as now we skip to next defrag target inside btrfs_defrag_file().
> 
>   Thus if auto-defrag determines to re-scan, then we still do the skip,
>   just at a different timing.
> 
> - Make defrag_one_cluster() to return >0 to indicate a quick exit
>   So that btrfs_defrag_file() can also do a quick exit, without
>   increasing @cur to the range end, and re-use @cur to update
>   @range->start.
> 
> - Add comment for btrfs_defrag_file() to mention the range->start update
>   Currently only autodefrag utilize this behavior, as defrag ioctl won't
>   set @max_to_defrag parameter, thus unless interrupted it will always
>   try to defrag the whole range.
> 
> Reported-by: Filipe Manana <fdmanana@suse.com>
> Fixes: 7b508037d4ca ("btrfs: defrag: use defrag_one_cluster() to implement btrfs_defrag_file()")
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to misc-next, thanks.
