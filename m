Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4881155B6C
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Feb 2020 17:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgBGQIp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Feb 2020 11:08:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:33256 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726951AbgBGQIp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 7 Feb 2020 11:08:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9013FB275;
        Fri,  7 Feb 2020 16:08:42 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C8C69DA790; Fri,  7 Feb 2020 17:08:28 +0100 (CET)
Date:   Fri, 7 Feb 2020 17:08:28 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        David Sterba <dsterba@suse.cz>,
        Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v4 2/5] btrfs: use BIOs instead of buffer_heads from
 superblock writeout
Message-ID: <20200207160827.GG2654@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>
References: <20200205143831.13959-1-johannes.thumshirn@wdc.com>
 <20200205143831.13959-3-johannes.thumshirn@wdc.com>
 <20200205181605.GA11348@infradead.org>
 <SN4PR0401MB359893900DDE52857064A2CF9B1D0@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN4PR0401MB359893900DDE52857064A2CF9B1D0@SN4PR0401MB3598.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 06, 2020 at 08:20:16AM +0000, Johannes Thumshirn wrote:
> >> @@ -3497,9 +3506,23 @@ static int write_dev_supers(struct btrfs_device *device,
> >>   		op_flags = REQ_SYNC | REQ_META | REQ_PRIO;
> >>   		if (i == 0 && !btrfs_test_opt(device->fs_info, NOBARRIER))
> >>   			op_flags |= REQ_FUA;
> > 
> > Question on the existing code:  why is it safe to not use FUA for the
> > subsequent superblocks?
> > 
> >> +
> >>C +		/*
> >> +		 * Directly use BIOs here instead of relying on the page-cache
> >> +		 * to do I/O, so we don't loose the ability to do integrity
> >> +		 * checking.
> >> +		 */
> >> +		bio = bio_alloc(gfp_mask, 1);
> >> +		bio_set_dev(bio, device->bdev);
> >> +		bio->bi_iter.bi_sector = bytenr >> SECTOR_SHIFT;
> >> +		bio->bi_private = device;
> >> +		bio->bi_end_io = btrfs_end_super_write;
> >> +		bio_add_page(bio, page, BTRFS_SUPER_INFO_SIZE,
> >> +			     offset_in_page(bytenr));
> > 
> > Missing return value check.  But given that it is a single page and
> > can't error out please switch to __bio_add_page here.
> IR
> Good question, I guess it's saver to always FUA the SBs

That is a performance optimization IIRC, only the primary superblock
does FUA the backup superblocks don't as this would add 2 more flushes
that are considered expensive.

The trade-off is optimistic because the backup superblocks are almost
never necessary. For the common power-fail situation primary will be
there or not atomically, the non-FUA writes of secondary superblocks
will be perhaps delayed a bit. The scenario where the primary sb is
unexpectedly damaged would have to happen in the short window between
primary FUA and backup writes, so the current version of sb is not
available. Something like that:

  write primary sb
1 FUA

  write backup copy 1
  other writes
  write backup copy 2
  other writes
2 FUA (or equvalent flushing the copies to device)

The window is between 1 and 2, and if some divine force kills primary
sb, the backup copies are not permanently stored yet. Which makes
recovery of the last transaction tricky, but there are still the backup
superblocks with previous intact version.

With FUA after each backup, the window would be shortened, with only 2
blocks written, allowing to access the latest transaction, or possibly
the previous one too given where exactly the write sequence is
interrupted.

The above describes possible scenario but I consider it quite rare to
hit in practice, also it depends on the device that should not just skip
writes or FUAs. So the performance optimization is IMO justified.
