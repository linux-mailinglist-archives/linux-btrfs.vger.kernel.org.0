Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2ED5FBF4
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jul 2019 18:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbfGDQgm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Jul 2019 12:36:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:39708 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726038AbfGDQgm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 4 Jul 2019 12:36:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E4F22AEF5;
        Thu,  4 Jul 2019 16:36:40 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1ACAFDA89D; Thu,  4 Jul 2019 18:37:21 +0200 (CEST)
Date:   Thu, 4 Jul 2019 18:37:21 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Colin King <colin.king@canonical.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] btrfs: fix memory leak of path on error return path
Message-ID: <20190704163721.GA20977@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Colin King <colin.king@canonical.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190702141028.11566-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702141028.11566-1-colin.king@canonical.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 02, 2019 at 03:10:28PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently if the allocation of roots or tmp_ulist fails the error handling
> does not free up the allocation of path causing a memory leak. Fix this by
> freeing path with a call to btrfs_free_path before taking the error return
> path.
> 
> Addresses-Coverity: ("Resource leak")

Does this have an id, that coverity uses?

> Fixes: 5911c8fe05c5 ("btrfs: fiemap: preallocate ulists for btrfs_check_shared")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  fs/btrfs/extent_io.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 1eb671c16ff1..d7f37a33d597 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -4600,6 +4600,7 @@ int extent_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>  	tmp_ulist = ulist_alloc(GFP_KERNEL);
>  	if (!roots || !tmp_ulist) {
>  		ret = -ENOMEM;
> +		btrfs_free_path(path);

This fixes only one leak, therere are more that I spotted while
reviewing this patch. The gotos from the while-loop jump to
out_free_list but that leave the path behind.

That's why the exit block is a better place for the cleanups. This
requires proper nesting of the cleanup calls, that's slightly
inconvenient in this case. The free_path is before call to
unlock_extent_cached so when the ordre is switched and free_path moved
to out_free_ulist, then all the leaks are addressed in one go.

Bummer that the leaks escaped sight of original patch author (me), 2
reviewers and now 1 fix reviewer.
