Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F03B81F923
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 May 2019 19:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbfEORHO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 May 2019 13:07:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:45292 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726360AbfEORHO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 May 2019 13:07:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 82287AD7F;
        Wed, 15 May 2019 17:07:13 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id DCBDCDA8E5; Wed, 15 May 2019 19:08:13 +0200 (CEST)
Date:   Wed, 15 May 2019 19:08:13 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] Btrfs: avoid fallback to transaction commit during fsync
 of files with holes
Message-ID: <20190515170812.GW3138@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <20190506154351.20047-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190506154351.20047-1-fdmanana@kernel.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 06, 2019 at 04:43:51PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When we are doing a full fsync (bit BTRFS_INODE_NEEDS_FULL_SYNC set) of a
> file that has holes and has file extent items spanning two or more leafs,
> we can end up falling to back to a full transaction commit due to a logic
> bug that leads to failure to insert a duplicate file extent item that is
> meant to represent a hole between the last file extent item of a leaf and
> the first file extent item in the next leaf. The failure (EEXIST error)
> leads to a transaction commit (as most errors when logging an inode do).
> 
> For example, we have the two following leafs:
> 
> Leaf N:
> 
>   -----------------------------------------------
>   | ..., ..., ..., (257, FILE_EXTENT_ITEM, 64K) |
>   -----------------------------------------------
>   The file extent item at the end of leaf N has a length of 4Kb,
>   representing the file range from 64K to 68K - 1.
> 
> Leaf N + 1:
> 
>   -----------------------------------------------
>   | (257, FILE_EXTENT_ITEM, 72K), ..., ..., ... |
>   -----------------------------------------------
>   The file extent item at the first slot of leaf N + 1 has a length of
>   4Kb too, representing the file range from 72K to 76K - 1.
> 
> During the full fsync path, when we are at tree-log.c:copy_items() with
> leaf N as a parameter, after processing the last file extent item, that
> represents the extent at offset 64K, we take a look at the first file
> extent item at the next leaf (leaf N + 1), and notice there's a 4K hole
> between the two extents, and therefore we insert a file extent item
> representing that hole, starting at file offset 68K and ending at offset
> 72K - 1. However we don't update the value of *last_extent, which is used
> to represent the end offset (plus 1, non-inclusive end) of the last file
> extent item inserted in the log, so it stays with a value of 68K and not
> with a value of 72K.
> 
> Then, when copy_items() is called for leaf N + 1, because the value of
> *last_extent is smaller then the offset of the first extent item in the
> leaf (68K < 72K), we look at the last file extent item in the previous
> leaf (leaf N) and see it there's a 4K gap between it and our first file
> extent item (again, 68K < 72K), so we decide to insert a file extent item
> representing the hole, starting at file offset 68K and ending at offset
> 72K - 1, this insertion will fail with -EEXIST being returned from
> btrfs_insert_file_extent() because we already inserted a file extent item
> representing a hole for this offset (68K) in the previous call to
> copy_items(), when processing leaf N.
> 
> The -EEXIST error gets propagated to the fsync callback, btrfs_sync_file(),
> which falls back to a full transaction commit.
> 
> Fix this by adjusting *last_extent after inserting a hole when we had to
> look at the next leaf.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Queued for 5.2-rc, thanks.
