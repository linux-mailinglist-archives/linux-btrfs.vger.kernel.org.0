Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9FD421D6
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Jun 2019 11:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731963AbfFLJ6H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Jun 2019 05:58:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:37178 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731934AbfFLJ6C (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Jun 2019 05:58:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D60BDAC61;
        Wed, 12 Jun 2019 09:58:00 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7FD61DA88C; Wed, 12 Jun 2019 11:58:51 +0200 (CEST)
Date:   Wed, 12 Jun 2019 11:58:51 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Neal Gompa <ngompa13@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Subject: Re: APFS improvements (e.g. firm links, volume w/ subvols
 replication) as ideas for Btrfs?
Message-ID: <20190612095851.GG3563@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Chris Murphy <lists@colorremedies.com>,
        Neal Gompa <ngompa13@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
References: <CAEg-Je9XTvEtg=Mpb1xKkO6Lzd3-yzSK7GcfbKH13uuf-u-wTA@mail.gmail.com>
 <CAJCQCtSPZwcg5y-d+mOhmyCdvq1dpzLUg05kPUg7CYhZp6Oz_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJCQCtSPZwcg5y-d+mOhmyCdvq1dpzLUg05kPUg7CYhZp6Oz_Q@mail.gmail.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 11, 2019 at 10:03:51PM -0600, Chris Murphy wrote:
> On Tue, Jun 11, 2019 at 12:31 PM Neal Gompa <ngompa13@gmail.com> wrote:
> >
> > Hey,
> >
> > So Apple held its WWDC event last week, and among other things, they
> > talked about improvements they've made to filesystems in macOS[1].
> >
> > Among other things, one of the things introduced was a concept of
> > "firm links", which is something like NTFS' directory junctions,
> > except they can cross (sub)volumes.
> 
> My understanding is it's a work around for the lack of APFS supporting
> directory hardlinks. Btrfs does support directory hardlinks but a

Directory hardlinks are not supported in general on linux and prohibited
on the VFS level. (check fs/namei.c vfs_link, explicitly returns -EPERM
for a directory).

> hardlink points to a particular inode within a particular subvolume
> (files tree) so it's not possible to have a hard link that crosses
> subvolumes. A reflink can already do this, but it's really just an
> efficient copy, the resulting directory is independent. A directory
> symlink can mirror a directory across subvolumes, but like any symlink
> it must have a fixed path available to always find the real deal.
> 
> I think a firm link like thing on Btrfs would require a format change,
> but I'm not certain. My best guess of what it'd be, is a dir/file
> object that gets its own inode but contains a hard reference (not
> independent object) to a subvolid+inode.
> 
> 
> >This concept makes it easier to
> > handle uglier layouts. While bind mounts work kind of okay for this
> > with simpler configurations, it requires operating system awareness,
> > rather than being setup automatically as the volume is mounted. This
> > is less brittle and works better for recovery environments, and help
> > make easier to do read-only system volumes while supported read-write
> > sections in a more flexible way.
> 
> There are a couple of things going on. One is something between VFS
> and Btrfs does this goofy assumption that bind mounts are subvolumes,
> which is definitely not true. I bring this up here:
> https://lore.kernel.org/linux-btrfs/CAJCQCtT=-YoFJgEo=BFqfiPdtMoJCYR3dJPSekf+HQ22GYGztw@mail.gmail.com/

The subvolumes build on top of the bind mount API internally but it is
or should be a different kind of object.

> Near as I can tell, Btrfs kernel code just needs to be smarter about
> distinguishing between bind mounts of directories versus the behind
> the scene bind mount used for subvolumes mounted using -o subvol= or
> -o subvolid= ; I don't think that's difficult. It's just someone needs
> to work through the logic and set aside the resources to do it.

I tried to fix that and got half way through, then hit the difficult
problems mainly with nested subvolumes. For leaf subvolumes, the
difference between

  subvolume/dir/dir/dir (bind mounted)

and

  subvolume (mounted with -o)

is to traverse back the path until the subvolume is hit, which in both
cases would be 'subvolume'. Howvever, with nested subvolumes it's not
easy to see where to stop

  subvol1/dir/dir/subvol2/dir/dir/subvol3/dir/dir

and take 3 cases:

  mount -o subvol=subvol1
  mount -o subvol=subvol2
  mount -o subvol=subvol3

the backward path traversal will always say it's subvol3 (that's wrong
from users POV). Keeping track of the exact subvolume that was mounted
is not trivial because it partially has to duplicate the internal VFS
information which makes it hard to keep consistent after moves.

There was a concept proposal called 'fs view' that would add proper
subvolume abstraction for subvolumes to VFS but I don't know how far
this got.
