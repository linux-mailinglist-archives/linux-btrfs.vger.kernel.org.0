Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 126321349A2
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jan 2020 18:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgAHRou (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jan 2020 12:44:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:41578 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726290AbgAHRou (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 8 Jan 2020 12:44:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B80A9AE3A;
        Wed,  8 Jan 2020 17:44:48 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9F19BDA791; Wed,  8 Jan 2020 18:44:37 +0100 (CET)
Date:   Wed, 8 Jan 2020 18:44:36 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: fix improper setting of scanned
Message-ID: <20200108174435.GL3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200103153844.13852-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200103153844.13852-1-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

As 'scanning' has another meaning in btrfs, the subject should say
something about writeback or at least write cache range scanning.

On Fri, Jan 03, 2020 at 10:38:44AM -0500, Josef Bacik wrote:
> We noticed that we were having regular CG OOM kills in cases where there
> was still enough dirty pages to avoid OOM'ing.  It turned out there's
> this corner case in btrfs's handling of range_cyclic where files that
> were being redirtied were not getting fully written out because of how
> we do range_cyclic writeback.
> 
> We unconditionally were setting scanned = 1; the first time we found any
> pages in the inode.  This isn't actually what we want, we want it to be
> set if we've scanned the entire file.  For range_cyclic we could be
> starting in the middle or towards the end of the file, so we could write
> one page and then not write any of the other dirty pages in the file
> because we set scanned = 1.
> 
> Fix this by not setting scanned = 1 if we find pages.  The rules for
> setting scanned should be
> 
> 1) !range_cyclic.  In this case we have a specified range to write out.
> 2) range_cyclic && index == 0.  In this case we've started at the
>    beginning and there is no need to loop around a second time.
> 3) range_cyclic && we started at index > 0 and we've reached the end of
>    the file without satisfying our nr_to_write.
> 
> This patch fixes both of our writepages implementations to make sure
> these rules hold true.  This fixed our over zealous CG OOMs in
> production.
> 
> Fixes: d1310b2e0cd9 ("Btrfs: Split the extent_map code into two parts")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/extent_io.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 410f5a64d3a6..d634cb0c39e3 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -3965,6 +3965,7 @@ int btree_write_cache_pages(struct address_space *mapping,
>  	if (wbc->range_cyclic) {
>  		index = mapping->writeback_index; /* Start from prev offset */
>  		end = -1;
> +		scanned = (index == 0);

It's explained in the changelog but I think a comment would be good here
too. I'll add it at commit time.
