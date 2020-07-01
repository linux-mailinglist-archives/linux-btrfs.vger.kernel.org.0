Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8578E211212
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jul 2020 19:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbgGARjr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Jul 2020 13:39:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:40838 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726432AbgGARjr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 1 Jul 2020 13:39:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 644A4AD1B;
        Wed,  1 Jul 2020 17:39:45 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 67B54DA781; Wed,  1 Jul 2020 19:39:29 +0200 (CEST)
Date:   Wed, 1 Jul 2020 19:39:29 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Greed Rong <greedrong@gmail.com>
Subject: Re: [PATCH 3/4] btrfs: preallocate anon_dev for subvolume and
 snapshot creation
Message-ID: <20200701173928.GF27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        Greed Rong <greedrong@gmail.com>
References: <20200616021737.44617-1-wqu@suse.com>
 <20200616021737.44617-4-wqu@suse.com>
 <20200616151004.GE27795@twin.jikos.cz>
 <f792151a-ebd5-2ac7-c9ac-0c274ea1ab8e@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f792151a-ebd5-2ac7-c9ac-0c274ea1ab8e@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 01, 2020 at 11:25:27AM +0800, Qu Wenruo wrote:
> >> +struct btrfs_root *btrfs_get_new_fs_root(struct btrfs_fs_info *fs_info,
> >> +					 u64 objectid, dev_t anon_dev)
> >> +{
> >> +	return __get_fs_root(fs_info, objectid, anon_dev, true);
> >> +}
> > 
> > This does not look like a good API, we should keep btrfs_get_fs_root and
> > add the anon_bdev initialization to the callers, there are only a few.
> > 
> 
> A few = over 25?
> 
> I have switched to keep btrfs_get_fs_root(), but you won't like the summary:
> 
> Old:
>  fs/btrfs/disk-io.h     |  2 ++
>  fs/btrfs/ioctl.c       | 21 ++++++++++++++++-
>  fs/btrfs/transaction.c |  3 ++-
>  fs/btrfs/transaction.h |  2 ++
>  5 files changed, 70 insertions(+), 9 deletions(-)
> 
> New:
>  fs/btrfs/backref.c     |  4 ++--
>  fs/btrfs/disk-io.c     | 42 ++++++++++++++++++++++++++++++++++--------
>  fs/btrfs/disk-io.h     |  3 ++-
>  fs/btrfs/export.c      |  2 +-
>  fs/btrfs/file.c        |  2 +-
>  fs/btrfs/inode.c       |  2 +-
>  fs/btrfs/ioctl.c       | 31 +++++++++++++++++++++++++------
>  fs/btrfs/relocation.c  | 11 ++++++-----
>  fs/btrfs/root-tree.c   |  2 +-
>  fs/btrfs/scrub.c       |  2 +-
>  fs/btrfs/send.c        |  4 ++--
>  fs/btrfs/super.c       |  2 +-
>  fs/btrfs/transaction.c |  3 ++-
>  fs/btrfs/transaction.h |  2 ++
>  fs/btrfs/tree-log.c    |  2 +-
>  fs/btrfs/uuid-tree.c   |  2 +-
>  16 files changed, 83 insertions(+), 33 deletions(-)
> 
> Do we really go that direction?

You're right, I don't like the summary and I don't like the code either.

Adding the anon_dev argument to btrfs_get_fs_root is wrong and I have
never suggested that. What I meant is to put the actual id allocation
to the callers where the subvolume is created, ie only 2 places.
