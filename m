Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 997A71008A0
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Nov 2019 16:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbfKRPtD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Nov 2019 10:49:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:56104 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726646AbfKRPtD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Nov 2019 10:49:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 54FC9ABB1;
        Mon, 18 Nov 2019 15:49:02 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 05491DA823; Mon, 18 Nov 2019 16:49:03 +0100 (CET)
Date:   Mon, 18 Nov 2019 16:49:03 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/5] Remove extent_map::bdev
Message-ID: <20191118154903.GK3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1570474492.git.dsterba@suse.com>
 <20191118154154.wfter4dio7mlibva@macbook-pro-91.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191118154154.wfter4dio7mlibva@macbook-pro-91.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 18, 2019 at 10:41:54AM -0500, Josef Bacik wrote:
> On Mon, Oct 07, 2019 at 09:37:40PM +0200, David Sterba wrote:
> > The extent_map::bdev is unused and and can be removed, but it's not
> > straightforward so there are several steps. The first patch decouples
> > bdev from map_lookup. The remaining patches clean up use of the bdev,
> > removing a few bio_set_dev on the way. In the end, submit_extent_page is
> > one parameter lighter.
> > 
> > This has survived several fstests runs
> > 
> > David Sterba (5):
> >   btrfs: assert extent_map bdevs and lookup_map and split
> >   btrfs: get bdev from latest_dev for dio bh_result
> >   btrfs: drop bio_set_dev where not needed
> >   btrfs: remove extent_map::bdev
> >   btrfs: drop bdev argument from submit_extent_page
> > 
> >  fs/btrfs/compression.c | 10 ----------
> >  fs/btrfs/disk-io.c     |  3 ---
> >  fs/btrfs/extent_io.c   | 15 +++------------
> >  fs/btrfs/extent_map.c  |  6 +++++-
> >  fs/btrfs/extent_map.h  | 11 ++---------
> >  fs/btrfs/file-item.c   |  1 -
> >  fs/btrfs/file.c        |  3 ---
> >  fs/btrfs/inode.c       | 14 ++++----------
> >  fs/btrfs/relocation.c  |  2 --
> >  9 files changed, 14 insertions(+), 51 deletions(-)
> > 
> 
> This series needs to be dropped from misc-next, it causes any box with cgroups
> enabled to crash on boot.  The bio requires having a bio->bi_disk set when we do
> wbc_init_bio, which we no longer have with this patch.

Do you have the stack trace of the crash?
