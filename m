Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 689F42EC8DF
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Jan 2021 04:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbhAGDKG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Jan 2021 22:10:06 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:35362 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbhAGDKF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Jan 2021 22:10:05 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 08AC192AAC2; Wed,  6 Jan 2021 22:09:23 -0500 (EST)
Date:   Wed, 6 Jan 2021 22:09:23 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Forza <forza@tnonline.net>
Cc:     Cedric.dewijs@eclipso.eu, linux-btrfs@vger.kernel.org
Subject: Re: synchronize btrfs snapshots over a unreliable, slow connection
Message-ID: <20210107030919.GX31381@hungrycats.org>
References: <dc1e528567c9a57d089d77824f071af8@mail.eclipso.de>
 <cd3a4a0a-e0b4-3224-f00c-5ec52c6362e3@tnonline.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cd3a4a0a-e0b4-3224-f00c-5ec52c6362e3@tnonline.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 05, 2021 at 09:34:24AM +0100, Forza wrote:
> 
> 
> On 2021-01-04 21:51, Cedric.dewijs@eclipso.eu wrote:
> > ­I have a master NAS that makes one read only snapshot of my data per day. I want to transfer these snapshots to a slave NAS over a slow, unreliable internet connection. (it's a cheap provider). This rules out a "btrfs send -> ssh -> btrfs receive" construction, as that can't be resumed.
> > 
> > Therefore I want to use rsync to synchronize the snapshots on the master NAS to the slave NAS.
> > 
> > My thirst thought is something like this:
> > 1) create a read-only snapshot on the master NAS:
> > btrfs subvolume snapshot -r /mnt/nas/storage /mnt/nas/storage_snapshots/storage-$(date +%Y_%m_%d-%H%m)
> > 2) send that data to the slave NAS like this:
> > rsync --partial -var --compress --bwlimit=500KB -e "ssh -i ~/slave-nas.key" /mnt/nas/storage_snapshots/storage-$(date +%Y_%m_%d-%H%m) cedric@123.123.123.123/nas/storage
> > 3) Restart rsync until all data is copied (by checking the error code of rsync, is it's 0 then all data has been transferred)
> > 4) Create the read-only snapshot on the slave NAS with the same name as in step 1.
> > 
> > Does somebody already has a script that does this?
> > Is there a problem with this approach that I have not yet considered?­
> > 
> 
> One option is to store the send stream as a compressed file and rsync that
> file over and do a shasum or similar on it.
> 
> Steps would be something like this on the sender side:
> 
> 1) create read-only snapshot as
> /mnt/nas/storage_snapshots/storage-210105-0930
> 2) btrfs send /mnt/nas/storage_snapshots/storage-210105-0930| xz -T0 - >
> /some/path/storage-210105-0930.xz

Should be:

	if btrfs send /mnt/nas/storage_snapshots/storage-210105-0930 > >(xz -T0 - > /some/path/storage-210105-0930.xz); then
		if xz -t /some/path/storage-210105-0930.xz; then
			... good to go ...
		else
			... handle xz failure ...
		fi
	else
		... handle btrfs send failure ...
	fi

> send this file to remote location, verify integrity, then do:

For huge files and broken links, use these options:

	rsync --append --inplace --partial --bwlimit=500KB storage-210105-0930.xz receiver:/path

This will avoid copy-and-rename of a big file in case the backup file is
very large and the link is failing relatively often.

> 3) xzcat storage-210105-0930.xz | btrfs receive /nas/storage

This can be problematic if the deltas are unusually large.  e.g. if we
add 1TB of new data on Tuesday, and delete it all on Thursday, we can't
unpack Friday's snapshot because ssh is still working on getting Tuesday's
snapshot over the network (and will be for at least 3 more Tuesdays at a
500 KB/s link speed).

What we really need here is a way to bless an rsync-synchronized btrfs
subvol for future use with btrfs send -p, so we can freely switch between
them as required.  Like this, perhaps:

1) sender:  btrfs sub snap -r subvol snapshot-$(date +%s)

2) sender:  rsync -avxHSXX --partial --numeric-ids --del receiver:/path/to/receive/subvol

   (do not leave out:

	-a - recurse and preserve inode attributes

	-x - stay within the subvol

	-XX - preserve xattrs (receive might fail if they are missing)

	-H - hardlinks (send/receive might fail unless every inode has
	all of the same names on both sides)

	--numeric-ids (send and receive use numeric ids)

	--del (receive will not attempt to create an existing file,
	it will just fail)

    and don't use --exclude or --fake-super, or any variation like --include '!foo' or --no-fake-super)

3) sender:  get generation and uuid from snapshot-$(date +%s) and send it to receiver

4) receiver:

        struct btrfs_ioctl_received_subvol_args rs_args = {
                .received_uuid = /* insert the subvol uuid from the sender side */,
                .stransid = /* insert the subvol transid from the sender side */,
        }
        u64 flags;

	subvol_fd = open("/path/to/received/subvol", O_RDONLY);
	/* set the received uuid on the subvol so btrfs send -p can use it as a parent */
        ret = ioctl(subvol_fd, BTRFS_IOC_SET_RECEIVED_SUBVOL, &rs_args);

	/* this is just "btrfs prop set <snapshot> ro true", but you can also do it from C code */
        ret = ioctl(subvol_fd, BTRFS_IOC_SUBVOL_GETFLAGS, &flags);
        flags |= BTRFS_SUBVOL_RDONLY;
        ret = ioctl(subvol_fd, BTRFS_IOC_SUBVOL_SETFLAGS, &flags);

The result should be compatible with future btrfs send -p (in
theory--remember, I've already been wrong about btrfs send once this
week ;).

This code is untested, and things will go badly and silently wrong if the
two subvols are _not_ in fact identical (e.g. if you excluded anything
in the transfer, added anything on the receive side, or didn't use _all_
of the rsync options listed above to produce topologically identical
inode-to-filename graphs on both sides).

> You could expand on the compression scheme by using self-healing archives
> using PAR[1] or similar tools, in case you want to keep the archived files.

I would only attempt to put the archives into long-term storage after
verifying that they produce correct output when fed to btrfs receive;
otherwise, you could find out too late that a months-old archive was
damaged, incomplete, or incorrect, and restores after that point are no
longer possible.

Once that verification has been done and the subvol is no longer needed
for incremental sends, you can delete the subvol and keep the archive(s)
that produced it.

> btrbk[2] is a Btrfs backup tool that also can store snapshots as archives on
> remote location. You may want to have a look at that too.
> 
> Good Luck!
> 
> 
> [1]https://en.wikipedia.org/wiki/Parchive
> [2]https://digint.ch/btrbk/
> 
> 
