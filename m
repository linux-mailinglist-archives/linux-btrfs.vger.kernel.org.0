Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C57FB107759
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Nov 2019 19:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfKVS33 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Nov 2019 13:29:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:59980 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726062AbfKVS33 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Nov 2019 13:29:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0BACAAFBE;
        Fri, 22 Nov 2019 18:29:28 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C92C3DA898; Fri, 22 Nov 2019 19:29:27 +0100 (CET)
Date:   Fri, 22 Nov 2019 19:29:27 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: do not call synchronize_srcu() in inode_tree_del
Message-ID: <20191122182927.GE3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20191119185935.3079-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191119185935.3079-1-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 19, 2019 at 01:59:35PM -0500, Josef Bacik wrote:
> Testing with the new fsstress uncovered a pretty nasty deadlock with
> lookup and snapshot deletion.
> 
> Process A
> unlink
>  -> final iput
>    -> inode_tree_del
>      -> synchronize_srcu(subvol_srcu)
> 
> Process B
> btrfs_lookup  <- srcu_read_lock() acquired here
>   -> btrfs_iget
>     -> find inode that has I_FREEING set
>       -> __wait_on_freeing_inode()
> 
> We're holding the srcu_read_lock() while doing the iget in order to make
> sure our fs root doesn't go away, and then we are waiting for the inode
> to finish freeing.  However because the free'ing process is doing a
> synchronize_srcu() we deadlock.
> 
> Fix this by dropping the synchronize_srcu() in inode_tree_del().  We
> don't need people to stop accessing the fs root at this point, we're
> only adding our empty root to the dead roots list.
> 
> A larger much more invasive fix is forthcoming to address how we deal
> with fs roots, but this fixes the immediate problem.
> 
> Fixes: 76dda93c6ae2 ("Btrfs: add snapshot/subvolume destroy ioctl")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Added to misc-next, thanks.
