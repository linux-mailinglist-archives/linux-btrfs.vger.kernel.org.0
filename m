Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22D252DD32B
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Dec 2020 15:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbgLQOnb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Dec 2020 09:43:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:57152 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728050AbgLQOna (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Dec 2020 09:43:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2C42BAC90;
        Thu, 17 Dec 2020 14:42:49 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 33641DA83A; Thu, 17 Dec 2020 15:41:09 +0100 (CET)
Date:   Thu, 17 Dec 2020 15:41:09 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: initialize test inodes location
Message-ID: <20201217144109.GO6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <7d1759263b14140254494b1ae49fe69aff099dc1.1608051618.git.josef@toxicpanda.com>
 <20201217124103.GN6430@twin.jikos.cz>
 <c779da25-61f3-85fb-b593-fdd614ab8931@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c779da25-61f3-85fb-b593-fdd614ab8931@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 17, 2020 at 09:39:18AM -0500, Josef Bacik wrote:
> On 12/17/20 7:41 AM, David Sterba wrote:
> > On Tue, Dec 15, 2020 at 12:00:26PM -0500, Josef Bacik wrote:
> >> While testing other things I was noticing that sometimes my VM would
> >> fail to load the btrfs module because the self test failed like this
> >>
> >> BTRFS: selftest: fs/btrfs/tests/inode-tests.c:963 miscount, wanted 1, got 0
> >>
> >> This turned out to be because sometimes the btrfs ino would be the btree
> >> inode number, and thus we'd skip calling the set extent delalloc bit
> >> helper, and thus not adjust ->outstanding_extents.  Fix this by making
> >> sure we init test inodes with a valid inode number so that we don't get
> >> random failures during self tests.
> >>
> >> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> >> ---
> >>   fs/btrfs/tests/btrfs-tests.c | 7 ++++++-
> >>   fs/btrfs/tests/inode-tests.c | 9 ---------
> >>   2 files changed, 6 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/fs/btrfs/tests/btrfs-tests.c b/fs/btrfs/tests/btrfs-tests.c
> >> index 8ca334d554af..0fede1514a3e 100644
> >> --- a/fs/btrfs/tests/btrfs-tests.c
> >> +++ b/fs/btrfs/tests/btrfs-tests.c
> >> @@ -55,8 +55,13 @@ struct inode *btrfs_new_test_inode(void)
> >>   	struct inode *inode;
> >>   
> >>   	inode = new_inode(test_mnt->mnt_sb);
> >> -	if (inode)
> >> +	if (inode) {
> >> +		inode->i_mode = S_IFREG;
> >> +		BTRFS_I(inode)->location.type = BTRFS_INODE_ITEM_KEY;
> >> +		BTRFS_I(inode)->location.objectid = BTRFS_FIRST_FREE_OBJECTID;
> >> +		BTRFS_I(inode)->location.offset = 0;
> >>   		inode_init_owner(inode, NULL, S_IFREG);
> >> +	}
> > 
> > As this is adding more statements to the if-block, I'd rather rewrite it
> > as
> > 
> > 	inode = new();
> > 	if (!inode)
> > 		return NULL;
> > 
> > 	inode-> ...
> > 
> 
> Agreed, I've updated it locally, I'll wait for comments for the rest of the 
> series and then resend.  Thanks,

No need to resend unless something else pops up, the change is trivial.
