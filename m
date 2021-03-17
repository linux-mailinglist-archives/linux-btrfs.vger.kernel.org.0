Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABFF833F7B6
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Mar 2021 19:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbhCQR7a (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Mar 2021 13:59:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:34610 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232904AbhCQR7F (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Mar 2021 13:59:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AA4CCAC1E;
        Wed, 17 Mar 2021 17:59:03 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8A9CDDA6E2; Wed, 17 Mar 2021 18:57:01 +0100 (CET)
Date:   Wed, 17 Mar 2021 18:57:01 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix subvolume/snapshot deletion not triggered on
 mount
Message-ID: <20210317175701.GV7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <5975ac44ce65830fd685896ed66b09eb16c4c4d8.1615912470.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5975ac44ce65830fd685896ed66b09eb16c4c4d8.1615912470.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 16, 2021 at 04:53:46PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> During the mount procedure we are calling btrfs_orphan_cleanup() against
> the root tree, which will find all orphans items in this tree. When an
> orphan item corresponds to a deleted subvolume/snapshot (instead of an
> inode space cache), it must not delete the orphan item, because that will
> cause btrfs_find_orphan_roots() to not find the orphan item and therefore
> not add the corresponding subvolume root to the list of dead roots, which
> results in the subvolume's tree never being deleted by the cleanup thread.
> 
> The same applies to the remount from RO to RW path.
> 
> Fix this by making btrfs_find_orphan_roots() run before calling
> btrfs_orphan_cleanup() against the root tree.
> 
> A test case for fstests will follow soon.
> 
> Reported-by: Robbie Ko <robbieko@synology.com>
> Link: https://lore.kernel.org/linux-btrfs/b19f4310-35e0-606e-1eea-2dd84d28c5da@synology.com/
> Fixes: 638331fa56caea ("btrfs: fix transaction leak and crash after cleaning up orphans on RO mount")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
