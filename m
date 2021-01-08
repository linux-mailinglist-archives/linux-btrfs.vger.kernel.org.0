Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8F12EF5F6
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Jan 2021 17:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbhAHQrI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Jan 2021 11:47:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:35504 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727283AbhAHQrH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 8 Jan 2021 11:47:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C4D8FAD89;
        Fri,  8 Jan 2021 16:46:25 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 61B36DA7A1; Fri,  8 Jan 2021 17:44:35 +0100 (CET)
Date:   Fri, 8 Jan 2021 17:44:35 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 00/13] Serious fixes for different error paths
Message-ID: <20210108164435.GC6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1608135557.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1608135557.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 16, 2020 at 11:22:04AM -0500, Josef Bacik wrote:
> Hello,
> 
> A lot of these were in previous versions of the relocation error handling
> patches.  I added a few since the last go around.  All of these do not rely on
> the error handling patches, and some of them are quite important otherwise we
> get corruption if we get errors in certain spots.  There's also a few lockdep
> fixes and such.  These really need to go in ASAP, regardless of when the
> relocation error handling patches are merged.  They're mostly small and self
> contained, the only "big" one being the one that tracks the root owner for
> relocation reads, which is to resolve the remaining class of lockdep errors we
> get because of an improper lockdep class set on the extent buffer.  Thanks,
> 
> Josef
> 
> Josef Bacik (13):
>   btrfs: don't get an EINTR during drop_snapshot for reloc
>   btrfs: initialize test inodes location
>   btrfs: fix reloc root leak with 0 ref reloc roots on recovery
>   btrfs: splice remaining dirty_bg's onto the transaction dirty bg list
>   btrfs: do not WARN_ON() if we can't find the reloc root
>   btrfs: add ASSERT()'s for deleting backref cache nodes
>   btrfs: do not double free backref nodes on error
>   btrfs: abort the transaction if we fail to inc ref in btrfs_copy_root
>   btrfs: modify the new_root highest_objectid under a ref count
>   btrfs: fix lockdep splat in btrfs_recover_relocation
>   btrfs: keep track of the root owner for relocation reads
>   btrfs: do not cleanup upper nodes in btrfs_backref_cleanup_node
>   btrfs: don't clear ret in btrfs_start_dirty_block_groups

Patch 2 has been merged, patch 9 dropped due to the inode number
cleanups in "btrfs: make btrfs_root::free_objectid hold the next
available objectid". Most of them are reviewed, I'll add the series to
for-next and continue merging to misc-next and then to -rc eventually.
Thanks.
