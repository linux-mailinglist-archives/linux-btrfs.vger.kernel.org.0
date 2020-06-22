Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B55E203F79
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jun 2020 20:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730129AbgFVSvl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Jun 2020 14:51:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:41852 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730030AbgFVSvl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Jun 2020 14:51:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D4077AD12;
        Mon, 22 Jun 2020 18:51:39 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A653DDA79B; Mon, 22 Jun 2020 20:51:28 +0200 (CEST)
Date:   Mon, 22 Jun 2020 20:51:28 +0200
From:   David Sterba <dsterba@suse.cz>
To:     dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 00/46] Trivial BTRFS_I removal
Message-ID: <20200622185128.GJ27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200603055546.3889-1-nborisov@suse.com>
 <20200617113759.GL27795@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617113759.GL27795@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 17, 2020 at 01:37:59PM +0200, David Sterba wrote:
> On Wed, Jun 03, 2020 at 08:55:00AM +0300, Nikolay Borisov wrote:
> > V2 with purely cosmetic changes in the line length of some patches' changelogs.
> > 
> > For the cover letter of substance for this series check v1 [0] cover letter.
> > 
> > [0] https://lore.kernel.org/linux-btrfs/SN4PR0401MB3598824C8AE02453F8ABD61A9B8B0@SN4PR0401MB3598.namprd04.prod.outlook.com/T/#t
> > 
> > Nikolay Borisov (46):
> >   btrfs: Make __btrfs_add_ordered_extent take struct btrfs_inode
> >   btrfs: Make get_extent_allocation_hint take btrfs_inode
> >   btrfs: Make btrfs_lookup_ordered_extent take btrfs_inode
> >   btrfs: Make btrfs_reloc_clone_csums take btrfs_inode
> >   btrfs: Make create_io_em take btrfs_inode
> >   btrfs: Make extent_clear_unlock_delalloc take btrfs_inode
> >   btrfs: Make btrfs_csum_one_bio takae btrfs_inode
> >   btrfs: Make __btrfs_drop_extents take btrfs_inode
> 
> I've applied 1-8 to misc-next, that's what applied cleanly when I first
> looked at the series and still applies now, with a minor conflict and
> manual fix to recently added "btrfs: fix RWF_NOWAIT writes blocking on
> extent locks and waiting for IO".
> 
> 46 in one go seem to be too much, I'll try to apply the rest in case the
> fixups won't get out of hand.

Still a lot of fixups, I'll keep it in a topic branch in for-next to
reduce conflict surface but will push it to misc-next at rc3 time.

The transition to btrfs_inode is worth, but please let's do it in
smaller batches next time, 20 patches should be ok. The turnaround time
should be shorter as the expected number of post-merge window fixes is
now going to be low. Thanks.
