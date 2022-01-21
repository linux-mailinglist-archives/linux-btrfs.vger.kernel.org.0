Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC9D2495733
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jan 2022 01:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378324AbiAUAHq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jan 2022 19:07:46 -0500
Received: from drax.kayaks.hungrycats.org ([174.142.148.226]:45030 "EHLO
        drax.kayaks.hungrycats.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1378263AbiAUAHq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jan 2022 19:07:46 -0500
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id 35F2217A69D; Thu, 20 Jan 2022 19:07:45 -0500 (EST)
Date:   Thu, 20 Jan 2022 19:07:45 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     dsterba@suse.cz, Remi Gauvin <remi@georgianit.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Case for "datacow-forced" option
Message-ID: <Yen5URN7kiynhgK6@hungrycats.org>
References: <42e747ca-faf1-ed7c-9823-4ab333c07104@georgianit.com>
 <20220111160112.GP14046@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111160112.GP14046@twin.jikos.cz>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 11, 2022 at 05:01:12PM +0100, David Sterba wrote:
> On Fri, Jan 07, 2022 at 08:30:46PM -0500, Remi Gauvin wrote:
> > I notice some software is silently creating files with +C attribute
> > without user input.  (Systemd journals, libvert qcow files, etc.)... I
> > can appreciate the goal of a performance boost, but I can only see this
> > as disaster for users of btrfs RAID, which will lead to inconsistent
> > mirrors on unclean shutdown, (and no way to fix, other than full balance.)
> > 
> > I think a datacow-forced option would be a good idea to prevent
> > accidental creation of critical files with nocow attribute.
> 
> Settings like that start some kind of "policy wars" and list of
> exceptions, ie. who decides what the filesystem is allowed to do. A
> mount option like you suggest would never allow to create a nocow file,
> but having some scratch nocow files with better performance would be
> nice to have. A global forced option would prevent accidental nocow
> files while you as user would consider them important.
> 
> I'd rather see that fixed or made configurable on the side of
> applications, the filesystem is really just providing features and
> options and limits the policies and forced options to the users.
> 
> IIRC the systemd journals got +C because the write pattern is 'append'
> that over time creates highly fragmented files. For VM images it's a
> performance optimization at the cost of no checksums. Both performance
> vs reliability trade off, that somebody made on behalf of users. But not
> to satisfaction to all, wich I understand but don't agree that the
> filesystem should be the level where this gets resolved.

Policy controls that were previously handled in lower storage layers
are becoming btrfs's responsibility as it replaces those layers.
datasums and RAID were first, but encryption and integrity are coming.

In other words, btrfs already started the policy war by invading the
territory of legacy policy regimes and establishing its own new and
different policy regime.  Now that the policy war has started, we'd like
proper tools to fight and win.

e.g. if we put ext4 on a dm-integrity device, applications don't get to
disable data integrity on individual files--every file on the filesystem
gets block-level integrity.  Similar things happen with encryption and
mirroring: every file on the filesystem is encrypted and every file gets
mirrored, because the whole filesystem is stored in something encrypted
or mirrored, and no second option is available from the filesystem.

If we want to have a mix of different policies, we can create a bunch
of ext4 filesystems with different policies set on the backing devices
and mount them all at the appropriate points.  It can be set up so that
unprivileged users can only create files on the encrypted filesystems
to prevent data leaks, only a privileged user can change those rules,
and even for privileged users rule changes are a little non-trivial
(e.g. new filesystems have to be created and mounted to implement a new
policy option combination).

It's awesome that btrfs _can_ enable or disable data integrity selectively
at the individual inode level without special privileges, but it's not a
novel capability, only a novel policy.  Unlike other Linux filesystem +
storage stack setups, btrfs allows a user to enable and disable storage
policy controls without permission and with reckless abandon.

If btrfs is to replace the other layers, then it needs to reimplement
the control knobs (or explicit _lack_ of control knobs) of the things
it's replacing, or functionality is lost compared to the legacy systems.
In some cases failure to verify, encrypt, or mirror data can result in
catastrophic failures, and having controls available to unprivileged
users that disable these features at inode level would be a bug.

It's much nicer to say "we don't ever allow nodatasum files on our
filesystems because our hosting providers have terrible taste in SSD
models" and be done with the issue forever.  The alternative is to play
whack-a-mole every day when some new app gets installed or upgraded,
it doesn't follow policy rules, and upstream won't fix it.

We'd have apps explode during completely normal disk failure events
because the app turned off datacow (and with it datasum and self-heal)
and a bad sector or two silently destroys the files.  It became enough
of a problem that I now patch the kernel to silently clear bits from
application requests to set forbidden attributes, removing the need to
frequently audit the filesystems for new files with these attributes.

> If fragmentation is problem, eventual runs of the defrag ioctl on the
> files can make the problem bearable.
