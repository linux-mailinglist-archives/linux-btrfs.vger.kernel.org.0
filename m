Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6791100E79
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Nov 2019 22:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfKRV56 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Nov 2019 16:57:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:60234 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726272AbfKRV56 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Nov 2019 16:57:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B3A88AD0F;
        Mon, 18 Nov 2019 21:57:55 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3BABEDAB3A; Mon, 18 Nov 2019 22:57:57 +0100 (CET)
Date:   Mon, 18 Nov 2019 22:57:57 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/5] Remove extent_map::bdev
Message-ID: <20191118215756.GP3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1570474492.git.dsterba@suse.com>
 <20191118154154.wfter4dio7mlibva@macbook-pro-91.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191118154154.wfter4dio7mlibva@macbook-pro-91.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 18, 2019 at 10:41:54AM -0500, Josef Bacik wrote:
> On Mon, Oct 07, 2019 at 09:37:40PM +0200, David Sterba wrote:
> > The extent_map::bdev is unused and and can be removed, but it's not
> > straightforward so there are several steps. The first patch decouples
> > bdev from map_lookup. The remaining patches clean up use of the bdev,
> > removing a few bio_set_dev on the way. In the end, submit_extent_page is
> > one parameter lighter.
> > 
> > This has survived several fstests runs
> > 
> > David Sterba (5):
> >   btrfs: assert extent_map bdevs and lookup_map and split
> >   btrfs: get bdev from latest_dev for dio bh_result
> >   btrfs: drop bio_set_dev where not needed
> >   btrfs: remove extent_map::bdev
> >   btrfs: drop bdev argument from submit_extent_page
> > 
> >  fs/btrfs/compression.c | 10 ----------
> >  fs/btrfs/disk-io.c     |  3 ---
> >  fs/btrfs/extent_io.c   | 15 +++------------
> >  fs/btrfs/extent_map.c  |  6 +++++-
> >  fs/btrfs/extent_map.h  | 11 ++---------
> >  fs/btrfs/file-item.c   |  1 -
> >  fs/btrfs/file.c        |  3 ---
> >  fs/btrfs/inode.c       | 14 ++++----------
> >  fs/btrfs/relocation.c  |  2 --
> >  9 files changed, 14 insertions(+), 51 deletions(-)
> > 
> 
> This series needs to be dropped from misc-next, it causes any box with cgroups
> enabled to crash on boot.  The bio requires having a bio->bi_disk set when we do
> wbc_init_bio, which we no longer have with this patch.
> 
> To fix this you would need to do something similar to what we do with
> compression, save the wbc css in the bbio and then call the associate_blkg at
> submit time.
> 
> However, this is problematic right now because we don't get notified when the
> bbio is free'd.  We have no way to free the ref on the css we save, which means
> infrastructure needs to be added to biosets so we can get called at free time
> for every bio in a bioset.  Or we can add back the bi_css to the bio, but that
> seems like a less good idea.
> 
> Either way this needs to be dropped until this is addressed.  Thanks,

I found a simple fix that does not need the reverts.

The bdev passed to submit_extent_bio is the latest_bdev, that's what the
cleanup series got rid of, pointlessly passing around a known pointer.

For equivalent change, the bdev can be pulled out of the page in a
series of 5 dereferences.

@@ -2987,13 +2987,16 @@ static int submit_extent_page(unsigned int opf, struct extent_io_tree *tree,
        }
 
        bio = btrfs_bio_alloc(offset);
-       bio_set_dev(bio, bdev);
        bio_add_page(bio, page, page_size, pg_offset);
        bio->bi_end_io = end_io_func;
        bio->bi_private = tree;
        bio->bi_write_hint = page->mapping->host->i_write_hint;
        bio->bi_opf = opf;
        if (wbc) {
+               struct block_device *bdev;
+
+               bdev = BTRFS_I(page->mapping->host)->root->fs_info->fs_devices->latest_bdev;
+               bio_set_dev(bio, bdev);
                wbc_init_bio(wbc, bio);
                wbc_account_cgroup_owner(wbc, page, page_size);
        }
---

To avoid problems with bisection, I'll put the series to after this patch but
otherwise I don't see any reasons to revert.
