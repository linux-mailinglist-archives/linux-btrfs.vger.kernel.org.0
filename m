Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B529D2BB864
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Nov 2020 22:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbgKTVeL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Nov 2020 16:34:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:58636 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728136AbgKTVeL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Nov 2020 16:34:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CE7D8AED8;
        Fri, 20 Nov 2020 21:34:09 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BE482DA6E1; Fri, 20 Nov 2020 22:32:22 +0100 (CET)
Date:   Fri, 20 Nov 2020 22:32:22 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v7 00/10] btrfs: free space tree mounting fixes
Message-ID: <20201120213222.GA8669@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Boris Burkov <boris@bur.io>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1605736355.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1605736355.git.boris@bur.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 18, 2020 at 03:06:15PM -0800, Boris Burkov wrote:
> This patch set cleans up issues surrounding enabling and disabling various
> free space cache features and their reporting in /proc/mounts.  Because the
> improvements became somewhat complex, the series starts by lifting rw mount
> logic into a single place.
> 
> The first patch is a setup patch that unifies very similar logic between a
> normal rw mount and a ro->rw remount. This is a useful setup step for adding
> more functionality to ro->rw remounts.
> 
> The second patch fixes the omission of orphan inode cleanup on a few trees
> during ro->rw remount.
> 
> The third patch stops marking block groups with need_free_space when the
> free space tree is not yet enabled.
> 
> The fourth patch adds enabling the free space tree to ro->rw remount.
> 
> The fifth patch adds a method for clearing oneshot mount options after mount.
> 
> The sixth patch adds support for clearing the free space tree on ro->rw remount.
> 
> The seventh patch sets up for more accurate /proc/mounts by ensuring that
> cache_generation > 0 iff space_cache is enabled.
> 
> The eigth patch is the more accurate /proc/mounts logic.
> 
> The ninth patch is a convenience kernel message that complains when we skip
> changing the free space tree on remount.
> 
> The tenth patch removes the space cache v1 free space item and free space
> inodes when space cache v1 is disabled (nospace_cache or space_cache=v2).
> 
> The eleventh patch stops re-creating the free space objects when we are not
> using space_cache=v1
> 
> The twelfth patch fixes a lockdep failure in creating the free space tree.

Is this fixing a problem caused by some patches in this series? Because
if yes, the fix should be folded there. A standalone patch makese sense
in case we can't fold it there (eg. after merging to Linus' tree),
otherwise the merged patchsets should be made of complete patches,
without fixes-to-fixes. Even if the patchset is in misc-next, fixups are
still doable.
