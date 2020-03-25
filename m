Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0AC192011
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Mar 2020 05:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725954AbgCYEJx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 25 Mar 2020 00:09:53 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:35074 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725263AbgCYEJw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Mar 2020 00:09:52 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 350AA62EE62; Wed, 25 Mar 2020 00:09:51 -0400 (EDT)
Date:   Wed, 25 Mar 2020 00:09:50 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Graham Cobb <g.btrfs@cobb.uk.net>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Question: how understand the raid profile of a btrfs filesystem
Message-ID: <20200325040950.GV13306@hungrycats.org>
References: <517dac49-5f57-2754-2134-92d716e50064@alice.it>
 <20200321032911.GR13306@hungrycats.org>
 <fd306b0b-8987-e1e7-dee5-4502e34902c3@inwind.it>
 <20200321232638.GD2693@hungrycats.org>
 <3fb93a14-3608-0f64-cf5c-ca37869a76ef@inwind.it>
 <d472962c-c669-3004-7ab4-be65a6ed72ba@inwind.it>
 <20200322234934.GE2693@hungrycats.org>
 <a15a47f1-9465-dd5c-4b70-04f1a14e6a96@libero.it>
 <28ddb178-674b-fab7-afa4-18a575299c1d@cobb.uk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <28ddb178-674b-fab7-afa4-18a575299c1d@cobb.uk.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 23, 2020 at 10:48:44PM +0000, Graham Cobb wrote:
> On 23/03/2020 20:50, Goffredo Baroncelli wrote:
> > On 3/23/20 12:49 AM, Zygo Blaxell wrote:
> >> On Sun, Mar 22, 2020 at 09:38:30AM +0100, Goffredo Baroncelli wrote:
> >>> On 3/22/20 9:34 AM, Goffredo Baroncelli wrote:
> >>>
> >>>>
> >>>> To me it seems complicated to
> >>> [sorry I push the send button too early]
> >>>
> >>> To me it seems too complicated (and error prone) to derive the target
> >>> profile from an analysis of the filesystem.
> >>>
> >>> Any thoughts ?
> >>
> >> I still don't understand the use case you are trying to support.
> >>
> >> There are 3 states for a btrfs filesystem:
> >>
> > [...]
> >>
> >>     3.  A conversion is interrupted prior to completion.  Sysadmin is
> >>     expected to proceed immediately back to state #2, possibly after
> >>     taking any necessary recovery actions that triggered entry into
> >>     state #3.  It doesn't really matter what the current allocation
> >>     profile is, since it is likely to change before we allocate
> >>     any more block groups.
> >>
> >> You seem to be trying to sustain or support a filesystem in state #3 for
> >> a prolonged period of time.  Why would we do that?  
> 
> In real life situations (particularly outside a commercial datacentre)
> this situation can persist for quite a while.  I recently found myself
> in a real-life situation where this situation was not only in existence
> for weeks but was, at some times, getting worse (I was getting further
> away from my target configuration, not closer).
> 
> In this case, the original trigger was a disk in a well over 10TB
> filesystem beginning to go bad. My strategy for handling that was to
> replace the failing disk asap, and then rearrange the disk usage on the
> system later. In order to handle the immediate emergency, I made use of
> existing free space in LVM volume groups to replace the failing disk,
> but that meant I had some user data and backups on the same physical
> disk for a while (although I have plenty of other backups available I
> like to keep my first-tier backups on separate local disks).

I've done those.  And the annoying thing about them was...

> So, once the immediate crisis was over, I needed to move disks around
> between the filesystems. It was weeks before I had managed to do
> sufficient disk adds, removes 

Disk removes are where the current system breaks down.  'btrfs device
remove' is terrible:

	- can't cancel a remove except by rebooting or forcing ENOSPC

	- can't resume automatically after a reboot (probably a good
	thing for now, given there's no cancel)

	- can't coexist with a balance, even when paused--device remove
	requires the balance to be _cancelled_ first

	- doesn't have any equivalent to the 'convert' filter raid
	profile target in balance info

so if you need to remove a device while you're changing profiles, you
have to abort the profile change and then relocate a whole lot of data
without being able to specify the correct target profile.

The proper fix would be to reimplement 'btrfs dev remove' using pieces of
the balance infrastructure (it kind of is now, except where it's not),
and so 'device remove' can keep the 'convert=' target.  Then you don't
have to lose the target profile while doing removes (and fix the other
problems too).

Or just move it from the balance info to the superblock, as suggested
elsewhere in the thread (none of these changes can be done without
changing something in the on-disk format).  But definitely don't have
the target profile in both places!

> and replaces to have all the filesystems
> back to having data and backups on separate disks and all the data and
> metadata in the profiles I wanted. Just doing a replace for one disk
> took many days for the system to physically copy the data from one disk
> to the other.
> 
> As this system was still in heavy use, this was made worse by btrfs
> deciding to store data in profiles I did not want (at that point in the
> manipulation) and forcing me to rebalance the data that had been written
> during the last disk change before I could start on the next one.
> 
> Bottom line: although not the top priority in btrfs development, a
> simple way to control the profile to be used for new data and metadata
> allocations would have real benefit to overstretched sysadmins.
> 
