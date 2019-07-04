Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0505FC63
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jul 2019 19:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbfGDRT1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Jul 2019 13:19:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:46606 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727026AbfGDRT1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 4 Jul 2019 13:19:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8827CACF8;
        Thu,  4 Jul 2019 17:19:25 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E4023DA89D; Thu,  4 Jul 2019 19:20:07 +0200 (CEST)
Date:   Thu, 4 Jul 2019 19:20:07 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     dsterba@suse.cz, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] btrfs: fix memory leak of path on error return path
Message-ID: <20190704172007.GB20977@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Colin Ian King <colin.king@canonical.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190702141028.11566-1-colin.king@canonical.com>
 <20190704163721.GA20977@twin.jikos.cz>
 <366d87f9-96ea-ecc3-6464-9d20e3050248@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <366d87f9-96ea-ecc3-6464-9d20e3050248@canonical.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 04, 2019 at 05:47:50PM +0100, Colin Ian King wrote:
> >>  	tmp_ulist = ulist_alloc(GFP_KERNEL);
> >>  	if (!roots || !tmp_ulist) {
> >>  		ret = -ENOMEM;
> >> +		btrfs_free_path(path);
> > 
> > This fixes only one leak, therere are more that I spotted while
> > reviewing this patch. The gotos from the while-loop jump to
> > out_free_list but that leave the path behind>
> > That's why the exit block is a better place for the cleanups. This
> > requires proper nesting of the cleanup calls, that's slightly
> > inconvenient in this case. The free_path is before call to
> > unlock_extent_cached so when the ordre is switched and free_path moved
> > to out_free_ulist, then all the leaks are addressed in one go.
> 
> Oh, yes. Even static analysis missed that too!
> 
> > Bummer that the leaks escaped sight of original patch author (me), 2
> > reviewers and now 1 fix reviewer.
> > 
> Given that you can see more issues, I'll leave the fix in your capable
> hands.

This

--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4764,11 +4764,11 @@ int extent_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
                ret = emit_last_fiemap_cache(fieinfo, &cache);
        free_extent_map(em);
 out:
-       btrfs_free_path(path);
        unlock_extent_cached(&BTRFS_I(inode)->io_tree, start, start + len - 1,
                             &cached_state);
 
 out_free_ulist:
+       btrfs_free_path(path);
        ulist_free(roots);
        ulist_free(tmp_ulist);
        return ret;
---

should fix it.
