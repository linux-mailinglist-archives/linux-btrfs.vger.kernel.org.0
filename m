Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 413D7731AA
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jul 2019 16:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfGXO3z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Jul 2019 10:29:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:37778 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726610AbfGXO3z (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Jul 2019 10:29:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id ED421AF7E;
        Wed, 24 Jul 2019 14:29:53 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 36A7CDA808; Wed, 24 Jul 2019 16:30:31 +0200 (CEST)
Date:   Wed, 24 Jul 2019 16:30:31 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 2/2] Btrfs: fix ENOSPC errors, leading to transaction
 aborts, when cloning extents
Message-ID: <20190724143031.GO2868@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <20190627170042.6241-1-fdmanana@kernel.org>
 <20190705100950.14917-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190705100950.14917-1-fdmanana@kernel.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 05, 2019 at 11:09:50AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When cloning extents (or deduplicating) we create a transaction with a
> space reservation that considers we will drop or update a single file
> extent item of the destination inode (that we modify a single leaf). That
> is fine for the vast majority of scenarios, however it might happen that
> we need to drop many file extent items, and adjust at most two file extent
> items, in the destination root, which can span multiple leafs. This will
> lead to either the call to btrfs_drop_extents() to fail with ENOSPC or
> the subsequent calls to btrfs_insert_empty_item() or btrfs_update_inode()
> (called through clone_finish_inode_update()) to fail with ENOSPC. Such
> failure results in a transaction abort, leaving the filesystem in a
> read-only mode.
> 
> In order to fix this we need to follow the same approach as the hole
> punching code, where we create a local reservation with 1 unit and keep
> ending and starting transactions, after balancing the btree inode,
> when __btrfs_drop_extents() returns ENOSPC. So fix this by making the
> extent cloning call calls the recently added btrfs_punch_hole_range()
> helper, which is what does the mentioned work for hole punching, and
> make sure whenever we drop extent items in a transaction, we also add a
> replacing file extent item, to avoid corruption (a hole) if after ending
> a transaction and before starting a new one, the old transaction gets
> committed and a power failure happens before we finish cloning.
> 
> A test case for fstests follows soon.
> 
> Reported-by: David Goodwin <david@codepoets.co.uk>
> Link: https://lore.kernel.org/linux-btrfs/a4a4cf31-9cf4-e52c-1f86-c62d336c9cd1@codepoets.co.uk/
> Reported-by: Sam Tygier <sam@tygier.co.uk>
> Link: https://lore.kernel.org/linux-btrfs/82aace9f-a1e3-1f0b-055f-3ea75f7a41a0@tygier.co.uk/
> Fixes: b6f3409b2197e8f ("Btrfs: reserve sufficient space for ioctl clone")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next (some time ago), thanks.
