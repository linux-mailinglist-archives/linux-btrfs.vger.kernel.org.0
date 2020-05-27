Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDD2E1E5069
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 May 2020 23:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgE0VZU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 May 2020 17:25:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:34772 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbgE0VZU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 May 2020 17:25:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DEA20AD76;
        Wed, 27 May 2020 21:25:21 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8A57EDA72D; Wed, 27 May 2020 23:24:20 +0200 (CEST)
Date:   Wed, 27 May 2020 23:24:20 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Filipe Manana <fdmanana@gmail.com>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: Remove BTRFS_INODE_IN_DELALLOC_LIST flag
Message-ID: <20200527212419.GL18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Filipe Manana <fdmanana@gmail.com>,
        Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20200527101104.7441-1-nborisov@suse.com>
 <CAL3q7H5vZdvgs7Jsu3jp-9BFyv=XyBEJQOE-xytgzmud2we5Gw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H5vZdvgs7Jsu3jp-9BFyv=XyBEJQOE-xytgzmud2we5Gw@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 27, 2020 at 08:48:31PM +0100, Filipe Manana wrote:
> On Wed, May 27, 2020 at 12:42 PM Nikolay Borisov <nborisov@suse.com> wrote:
> >
> > The flag simply replicates whether btrfs_inode::delallocs_inodes list
> > is empty or not. Just defer this check to the list management functions
> > (btrfs_add_delalloc_inodes/__btrfs_del_delalloc_inode) which are
> > always called under btrfs_root::delalloc_lock.
> 
> The flag is there to avoid taking the root's delalloc_lock spinlock
> everytime a range is marked for delalloc for any inode of the
> subvolume.

I overlooked that not all uses of the bit are under delalloc_lock, which
would make it redundant, but both test_bit are inside inode lock, not
the delalloc lock.

> Have you measured performance with very high concurrency of buffered
> writes against files in the same subvolume?

I'll remove the patch for now unless the performance is verified to be
ok.
