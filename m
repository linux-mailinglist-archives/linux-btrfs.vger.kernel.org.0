Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67D02FC9B4
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2019 16:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfKNPSQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Nov 2019 10:18:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:45974 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726251AbfKNPSQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Nov 2019 10:18:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7A46CAC7B;
        Thu, 14 Nov 2019 15:18:14 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id DED85DA774; Thu, 14 Nov 2019 16:18:17 +0100 (CET)
Date:   Thu, 14 Nov 2019 16:18:17 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] Btrfs: fix missing hole after hole punching and fsync
 when using NO_HOLES
Message-ID: <20191114151817.GJ3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <20191112151331.3641-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112151331.3641-1-fdmanana@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 12, 2019 at 03:13:31PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When using the NO_HOLES feature, if we punch a hole into a file and then
> fsync it, there is a case where a subsequent fsync will miss the fact that
> a hole was punched:
> 
> 1) The extent items of the inode span multiple leafs;
> 
> 2) The hole covers a range that affects only the extent items of the first
>    leaf;
> 
> 3) The fsync operation is done in full mode (BTRFS_INODE_NEEDS_FULL_SYNC
>    is set in the inode's runtime flags).
> 
> That results in the hole not existing after replaying the log tree.
> 
> For example, if the fs/subvolume tree has the following layout for a
> particular inode:
> 
>   Leaf N, generation 10:
> 
>   [ ... INODE_ITEM INODE_REF EXTENT_ITEM (0 64K) EXTENT_ITEM (64K 128K) ]
> 
>   Leaf N + 1, generation 10:
> 
>   [ EXTENT_ITEM (128K 64K) ... ]
> 
> If at transaction 11 we punch a hole coverting the range [0, 128K[, we end
> up dropping the two extent items from leaf N, but we don't touch the other
> leaf, so we end up in the following state:
> 
>   Leaf N, generation 11:
> 
>   [ ... INODE_ITEM INODE_REF ]
> 
>   Leaf N + 1, generation 10:
> 
>   [ EXTENT_ITEM (128K 64K) ... ]
> 
> A full fsync after punching the hole will only process leaf N because it
> was modified in the current transaction, but not leaf N + 1, since it was
> not modified in the current transaction (generation 10 and not 11). As
> a result the fsync will not log any holes, because it didn't process any
> leaf with extent items.
> 
> So fix this by detecting any leading hole in the file for a full fsync
> when using the NO_HOLES feature if we didn't process any extent items for
> the file.
> 
> A test case for fstests follows soon.
> 
> Fixes: 16e7549f045d33 ("Btrfs: incompatible format change to remove hole extents")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
