Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58B372EC7E1
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Jan 2021 03:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbhAGCAh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 6 Jan 2021 21:00:37 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:42060 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbhAGCAh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Jan 2021 21:00:37 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id BA91C92A967; Wed,  6 Jan 2021 20:59:55 -0500 (EST)
Date:   Wed, 6 Jan 2021 20:59:55 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Cedric.dewijs@eclipso.eu
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: synchronize btrfs snapshots over a unreliable, slow connection
Message-ID: <20210107015955.GV31381@hungrycats.org>
References: <dc1e528567c9a57d089d77824f071af8@mail.eclipso.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <dc1e528567c9a57d089d77824f071af8@mail.eclipso.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 04, 2021 at 09:51:46PM +0100,   wrote:
> ­I have a master NAS that makes one read only snapshot of my data per day. I want to transfer these snapshots to a slave NAS over a slow, unreliable internet connection. (it's a cheap provider). This rules out a "btrfs send -> ssh -> btrfs receive" construction, as that can't be resumed.
> 
> Therefore I want to use rsync to synchronize the snapshots on the master NAS to the slave NAS.
> 
> My thirst thought is something like this:
> 1) create a read-only snapshot on the master NAS:
> btrfs subvolume snapshot -r /mnt/nas/storage /mnt/nas/storage_snapshots/storage-$(date +%Y_%m_%d-%H%m)
> 2) send that data to the slave NAS like this:
> rsync --partial -var --compress --bwlimit=500KB -e "ssh -i ~/slave-nas.key" /mnt/nas/storage_snapshots/storage-$(date +%Y_%m_%d-%H%m) cedric@123.123.123.123/nas/storage
> 3) Restart rsync until all data is copied (by checking the error code of rsync, is it's 0 then all data has been transferred)
> 4) Create the read-only snapshot on the slave NAS with the same name as in step 1.
> 
> Does somebody already has a script that does this?

Yes, and it is pretty much what you wrote above.  You probably also
want rsync options -aXXHS and --del, possibly also --numeric-ids and/or
--fake-super depending on how exact you want this copy to be (i.e. should
it preserve uid/gids, do both NAS hosts have all the same user names but
different user IDs, do you want the receiver to run rsync as root or an
unprivileged user, etc).

> Is there a problem with this approach that I have not yet considered?­

rsync will not propagate extent sharing to the receiver, and by default
if part of a file is modified, the entire file becomes unshared.  If this
is a problem, you may want to run dedupe on the receiver.

If you omit the -S option and add --inplace to rsync, then there is better
extent sharing (now partially modified files don't unshare the entire file)
but you lose sparse file support (so files that have large holes will have
them filled in with zero-data blocks).  This can result in a size increase
with some file formats, to astronomical sizes in the case of files like
/var/log/lastlog.

If the link can fail, then ssh commands to create snapshots on the receiver
can fail too.  You can loop to retry those as well.

If it takes more than one day to propagate a snapshot over the link,
you will have to decide whether to let rsync keep trying to catch up,
or abort and start over from the next day's snapshot.  You might want
to exit the rsync retry loop if the date changes while it's running.

A related question is what is expected when the sending host reboots.
Does it forget previous incomplete sends and just start a fresh rsync
with the current date's snapshot, or does it loop over all snapshots
in reverse order until it gets to one the receiver has, and then loops
forward from there to send each one from the backlog?

I solved the last two problems by not retaining the snapshots on the
sender side.  Each rsync instance sends from its own freshly created
snapshot that is deleted as soon as rsync exits (or upon reboot after
a crash), and the receiver provides its own snapshot names.  There is
no problem with backlog this way, but if you want to keep snapshots on
both sides of the SSH connection then this approach is not for you.

> ---
> 
> Take your mailboxes with you. Free, fast and secure Mail &amp; Cloud: https://www.eclipso.eu - Time to change!
> 
> 
