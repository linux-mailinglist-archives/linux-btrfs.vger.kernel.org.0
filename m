Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 173712B0C74
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Nov 2020 19:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbgKLSUC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Nov 2020 13:20:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:54396 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726534AbgKLSUB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Nov 2020 13:20:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EF613AFF8;
        Thu, 12 Nov 2020 18:19:59 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 182D0DA6E1; Thu, 12 Nov 2020 19:18:16 +0100 (CET)
Date:   Thu, 12 Nov 2020 19:18:16 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/8] Locking cleanups and lockdep fix
Message-ID: <20201112181816.GV6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1604697895.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1604697895.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 06, 2020 at 04:27:28PM -0500, Josef Bacik wrote:
> Hello,
> 
> Filipe reported a lockdep splat that he hit on btrfs/187, but honestly could be
> hit anywhere we do readdir on a sufficiently large fs.  Fixing this is fairly
> straightforward, but enabled me to do a lot of extra cleanups, especially now
> that my other locking fixes have been merged.  The first two patches are to
> address the lockdep problem.  The followup patches are cleaning out the
> recursive locking support, which we no longer require.  I would have separated
> this work, but btrfs_next_old_leaf was a heavy user of this, so it would be
> annoying to take separately, hence putting it all together.  Thanks,
> 
> Josef
> 
> Josef Bacik (8):
>   btrfs: cleanup the locking in btrfs_next_old_leaf
>   btrfs: unlock to current level in btrfs_next_old_leaf
>   btrfs: kill path->recurse
>   btrfs: remove the recursion handling code in locking.c
>   btrfs: remove __btrfs_read_lock_root_node
>   btrfs: use btrfs_tree_read_lock in btrfs_search_slot
>   btrfs: remove the recurse parameter from __btrfs_tree_read_lock
>   btrfs: remove ->recursed from extent_buffer

Added to misc-next, with some minor updates in changelogs. Seems that
this should remove all leftovers after the locking switch.
