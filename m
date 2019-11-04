Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C31EEE8CE
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Nov 2019 20:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbfKDTet (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Nov 2019 14:34:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:44308 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728654AbfKDTes (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 4 Nov 2019 14:34:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3C70FABE9;
        Mon,  4 Nov 2019 19:34:47 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 98762DB6FC; Mon,  4 Nov 2019 20:34:54 +0100 (CET)
Date:   Mon, 4 Nov 2019 20:34:54 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Andrei Borzenkov <arvidjaar@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: Does GRUB btrfs support log tree?
Message-ID: <20191104193454.GD3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Chris Murphy <lists@colorremedies.com>,
        Andrei Borzenkov <arvidjaar@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJCQCtS1v7waFA=ERafSCSCHmPJVytdFZkJLqNTC3U3Gw3Y7tA@mail.gmail.com>
 <d1874d17-700a-d78d-34be-eec0544c9de2@gmail.com>
 <CAJCQCtTpLTJdRjD7aNJEYXuMO+E65=GiYpKP3Wy5sgOWYs3Hsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJCQCtTpLTJdRjD7aNJEYXuMO+E65=GiYpKP3Wy5sgOWYs3Hsw@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Oct 27, 2019 at 09:05:54PM +0100, Chris Murphy wrote:
> > > Since log tree writes means a
> > > full file system update hasn't happened, the old file system state
> > > hasn't been dereferenced, so even in an SSD + discard case, the system
> > > should still be bootable. And at that point Btrfs kernel code does log
> > > replay, and catches the system up, and the next update will boot the
> > > new state.
> > >
> > > Correct?
> > >
> >
> > Yes. If we speak about grub here, it actually tries very hard to ensure
> > writes has hit disk (it fsyncs files as it writes them and it flushes
> > raw devices). But I guess that fsync on btrfs just goes into log and
> > does not force transaction. Is it possible to force transaction on btrfs
> > from user space?

* sync/syncfs
* the ioctl BTRFS_IOC_SYNC (calls syncfs)
* ioctls BTRFS_IOC_START_SYNC + BTRFS_IOC_WAIT_SYNC

> The only fsync I ever see Fedora's grub2-mkconfig do is for grubenv.
> The grub.cfg is not fsync'd. When I do a strace of grub2-mkconfig,
> it's so incredibly complicated. Using -ff -o options, I get over 1800
> separate PID files exported. From what I can tell, it creates a brand
> new file "grub.cfg.new" and writes to that. Then does a cat from
> "grub.cfg.new" into "grub.cfg" - maybe it's file system specific
> behavior, I'm not sure.
> 
> I'm pretty sure "sync" will do what you want, it calls syncfs() and
> best as I can tell it does a full file system sync, doesn't use the
> log tree. I'd argue grub-mkconfig should write all of its files, and
> then sync that file system, rather than doing any fsync at all.

This would work in most cases. I'm not sure, but the update does not
seem to be atomic. Ie. all old kernels match the old grub.cfg, or there
are new kernels that match the new cfg.

Even if there's not fsyncs and just the final sync, some other activity
in the filesystem can do the sync before between updates of kernels and
grub.cfg. Like this

start:

- kernel1
- grub.cfg (v1)

update:

- add kernel2
- remove kernel1
- <something calls sync>
- update grub.cfg (v2)
- grub calls sync

If the crash happens after sync and before update, kernel1 won't be
reachable and kernel2 won't be in the grub.cfg.
