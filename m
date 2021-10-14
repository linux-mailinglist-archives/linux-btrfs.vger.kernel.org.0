Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA0EF42DEDA
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Oct 2021 18:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbhJNQH2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Oct 2021 12:07:28 -0400
Received: from verein.lst.de ([213.95.11.211]:50760 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231571AbhJNQH1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Oct 2021 12:07:27 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id A795968B05; Thu, 14 Oct 2021 18:05:20 +0200 (CEST)
Date:   Thu, 14 Oct 2021 18:05:20 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] btrfs: update device path inode time instead of
 bd_inode
Message-ID: <20211014160520.GA445@lst.de>
References: <00b8cf32502e30403b9849a73e62f4ad5175fded.1634224611.git.josef@toxicpanda.com> <20211014153347.GA30555@lst.de> <YWhRr123vMRtiHF4@localhost.localdomain> <20211014155341.GA32052@lst.de> <YWhUCilH3TjmQC+X@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWhUCilH3TjmQC+X@localhost.localdomain>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 14, 2021 at 12:00:10PM -0400, Josef Bacik wrote:
> 1 fs/btrfs/volumes.c  update_dev_time      1900 generic_update_time(d_inode(path.dentry), &now, S_MTIME | S_CTIME);

This is the onde we're talking about.

> 4 fs/inode.c          inode_update_time    1789 return generic_update_time(inode, time, flags);

This is update_time().

And all others are ->update_time instances.

> > Looking at this a bit more I think the right fix is to simply revert the
> > offending commit.  The lockdep complains was due to changes issues in the
> > loop driver and has been fixed in the loop driver in the meantime.
> > 
> 
> Where were they fixed?  And it doesn't fix the fact that we're calling open on a
> device, so any change at all to the loop device is going to end us back up in
> this spot because we end up with the ->lo_mutex in our dependency chain.  I want
> to avoid this by not calling open, and that means looking up the inode and doing
> operations without needing to go through the full file open path.

This all looks like the open_mutex (formerly bd_mutex) vs lo_mutex inside
and outside chains, and they were fixed.

> The best thing for btrfs here is to export the update_time() helper and call
> that to avoid all the baggage that comes from opening the block device.  Thanks,

update_time is a bit too low-level for an export as it requires a fair
effort to call it the right way.
