Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1E284828FC
	for <lists+linux-btrfs@lfdr.de>; Sun,  2 Jan 2022 04:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbiABD1t (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 1 Jan 2022 22:27:49 -0500
Received: from drax.kayaks.hungrycats.org ([174.142.148.226]:41426 "EHLO
        drax.kayaks.hungrycats.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229783AbiABD1s (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 1 Jan 2022 22:27:48 -0500
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id D29C9130496; Sat,  1 Jan 2022 22:27:47 -0500 (EST)
Date:   Sat, 1 Jan 2022 22:27:47 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Eric Levy <contact@ericlevy.name>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: parent transid verify failed
Message-ID: <YdEbsxw7Nk0GKKzN@hungrycats.org>
References: <c0c6ec8de80b8e10185fe1980377dcc7af8d3200.camel@ericlevy.name>
 <Yc9Wgsint947Tj59@hungrycats.org>
 <baa90652685a400aa60636f8596e3d28304da1ad.camel@ericlevy.name>
 <YdDAGLU7M5mx7rL8@hungrycats.org>
 <59a9506eb880b054f8eff90d5b26ad0c673c7e1f.camel@ericlevy.name>
 <YdDurReZpZQeo+7/@hungrycats.org>
 <109cc618254b1f8d9365bd4ecb7eb435dea91353.camel@ericlevy.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <109cc618254b1f8d9365bd4ecb7eb435dea91353.camel@ericlevy.name>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jan 01, 2022 at 07:55:57PM -0500, Eric Levy wrote:
> On Sat, 2022-01-01 at 19:15 -0500, Zygo Blaxell wrote:
> > Try rebooting to make sure the old mount is truly gone.
> > 
> > If the filesystem has been lazily umounted with open files it can be
> > very difficult to find all the processes that are still holding the
> > files open and force them to close.  Tools like 'fuser' and 'lsof'
> > don't work after all the mount points have been deleted.
> 
> I couldn't find any indication that the file system remained mounted.
> The mount point was empty, umount commands failed for all target
> devices, as well as the mount point, and the mount table showed no
> relevant entries.

Yes, that's normal with lazy umounts.  With a lazy umount, the mount
point is removed immediately, so you get all the behavior you described,
but the filesystem is not actually umounted until after the last open
file descriptors referencing the filesystem are closed (that's the
"lazy" part).

It can get complicated when there are also errors in the lower storage
layers, as processes can sometimes get stuck in iowait state and become
unkillable, and then the only way to recover is to reboot.

Sometimes you can spot a filesystem that has been lazy-umounted in
/proc, by running

	ls -l /proc/self/*/fd/* /proc/self/*/{exec,cmd,root}

and looking for anomalous filenames in the symlinks (like the file
has the right base name but the early parts of the path are missing).
That's the only clue you'll have that this is happening, and it's
not even a reliable one.

With private mount namespaces it's even more confusing, because it's
possible for a filesystem to be mounted in a place that is not visible
to some processes.

> I rebooted, and the file system mounted automatically (as normal). I
> found no reports of problems in the log (below).
> 
> I performed a trivial test (writing "Hello world" to a file, and
> reading), and it performed correctly.
> 
> Is it likely that data written before the bad events is entirely
> intact, that all parts of the file tree not touched afterward have not
> been damaged? How confident should I be of not having corruption?

You can run btrfs scrub to verify the data and metadata.

The most probable outcome is that everything's OK.  The device layer
reported failed writes to btrfs, and btrfs aborted the last transaction
to protect the on-disk data.  I would not expect any errors in either
btrfs check or scrub, as this scenario is one the filesystem is designed
and tested for.

Normally, btrfs transactions will protect most old data from earlier
transactions from damage by write errors, so I would not expect any
errors in this case.  The exceptions are nodatacow files (because
the transactional data integrity guarantees require datacow to work)
and raid5/6 (because many parity raid implementations violate btrfs's
transactional data integrity rules, notably including btrfs's built-in
raid5/6).

> Is it safe to try to continue to write data beyond the capacity of the
> first device, into the additional device?

Probably.  It should have been safe the first time, too.  If you've
resolved the lower storage layer issues, then it should be OK.

Since you're transitioning from one disk to multiple disks, you should
convert metadata to raid1, and ensure there's sufficient unallocated
space on the first drive to hold metadata as it grows.  This can be done
with two balance commands:

	btrfs balance start -dlimit=16 /fs

	btrfs balance start -mconvert=raid1,soft /fs

(replace "16" with the total data capacity of your filesystem divided by
30 GB, or 5 + the number of GB of metadata you already have, whichever is
larger)

If you run out of metadata space, then the filesystem will abort a
transaction and go read-only.  Adding a second disk to a full first disk
makes this likely--a balance is required to rearrange the data so that
all the space can be used.

> ---
> 
> 
> Jan 01 19:26:43 hostname kernel: Loading iSCSI transport class v2.0-870.
> Jan 01 19:26:43 hostname kernel: iscsi: registered transport (tcp)
> Jan 01 19:26:43 hostname kernel: aufs 5.x-rcN-20210809
> Jan 01 19:26:43 hostname kernel: scsi host4: iSCSI Initiator over TCP/IP
> Jan 01 19:26:43 hostname kernel: scsi host5: iSCSI Initiator over TCP/IP
> Jan 01 19:26:43 hostname kernel: scsi 4:0:0:2: Direct-Access     SYNOLOGY Storage          4.0  PQ: 0 ANSI: 5
> Jan 01 19:26:43 hostname kernel: sd 4:0:0:2: Attached scsi generic sg4 type 0
> Jan 01 19:26:43 hostname kernel: sd 4:0:0:2: [sdc] 524288000 512-byte logical blocks: (268 GB/250 GiB)
> Jan 01 19:26:43 hostname kernel: sd 4:0:0:2: [sdc] Write Protect is off
> Jan 01 19:26:43 hostname kernel: sd 4:0:0:2: [sdc] Mode Sense: 43 00 10 08
> Jan 01 19:26:43 hostname kernel: sd 4:0:0:2: [sdc] Write cache: enabled, read cache: enabled, supports DPO and FUA
> Jan 01 19:26:43 hostname kernel: sd 4:0:0:2: [sdc] Optimal transfer size 16384 logical blocks > dev_max (8192 logical blocks)
> Jan 01 19:26:43 hostname kernel: scsi 4:0:0:1: Direct-Access     SYNOLOGY iSCSI Storage    4.0  PQ: 0 ANSI: 5
> Jan 01 19:26:43 hostname kernel: sd 4:0:0:1: Attached scsi generic sg5 type 0
> Jan 01 19:26:43 hostname kernel: sd 4:0:0:1: [sdd] 524288000 512-byte logical blocks: (268 GB/250 GiB)
> Jan 01 19:26:43 hostname kernel: sd 4:0:0:1: [sdd] Write Protect is off
> Jan 01 19:26:43 hostname kernel: sd 4:0:0:1: [sdd] Mode Sense: 43 00 10 08
> Jan 01 19:26:43 hostname kernel: sd 4:0:0:1: [sdd] Write cache: enabled, read cache: enabled, supports DPO and FUA
> Jan 01 19:26:43 hostname kernel: sd 4:0:0:1: [sdd] Optimal transfer size 16384 logical blocks > dev_max (8192 logical blocks)
> Jan 01 19:26:43 hostname kernel:  sdd: sdd1
> Jan 01 19:26:43 hostname kernel: sd 4:0:0:2: [sdc] Attached SCSI disk
> Jan 01 19:26:43 hostname kernel: sd 4:0:0:1: [sdd] Attached SCSI disk
> Jan 01 19:26:43 hostname kernel: BTRFS: device fsid c6f83d24-1ac3-4417-bdd9-6249c899604d devid 2 transid 9211 /dev/sdc scanned by systemd-udevd (386)
> Jan 01 19:26:44 hostname kernel: BTRFS: device fsid c6f83d24-1ac3-4417-bdd9-6249c899604d devid 1 transid 9211 /dev/sdd1 scanned by systemd-udevd (396)

There's the dev scan with no duplicate devices...

> Jan 01 19:26:44 hostname kernel: kauditd_printk_skb: 13 callbacks suppressed
> Jan 01 19:26:44 hostname kernel: audit: type=1400 audit(1641083204.403:25): apparmor="DENIED" operation="capable" profile="/usr/sbin/cups-browsed" pid=670 comm="cups-browsed" capability=23  capname="sys_nice"
> Jan 01 19:26:47 hostname kernel: audit: type=1400 audit(1641083207.587:26): apparmor="STATUS" operation="profile_load" profile="unconfined" name="docker-default" pid=993 comm="apparmor_parser"
> Jan 01 19:26:49 hostname kernel: bridge: filtering via arp/ip/ip6tables is no longer available by default. Update your scripts to load br_netfilter if you need this.
> Jan 01 19:26:49 hostname kernel: Bridge firewalling registered
> Jan 01 19:26:49 hostname kernel: bpfilter: Loaded bpfilter_umh pid 1017
> Jan 01 19:26:49 hostname unknown: Started bpfilter
> Jan 01 19:26:50 hostname kernel: Initializing XFRM netlink socket
> Jan 01 19:28:45 hostname kernel: BTRFS info (device sdd1): flagging fs with big metadata feature
> Jan 01 19:28:45 hostname kernel: BTRFS info (device sdd1): disk space caching is enabled
> Jan 01 19:28:45 hostname kernel: BTRFS info (device sdd1): has skinny extents

...and there's the ctree open messages.  Looks good.

Note there are no errors recorded (i.e. no messages reporting error
counts during mount).  Those errors occurred in the last transaction
that was aborted, so their error counts are not persisted.

> Jan 01 19:28:45 hostname kernel: FS-Cache: Loaded
> Jan 01 19:28:45 hostname kernel: FS-Cache: Netfs 'nfs' registered for caching
> Jan 01 19:28:45 hostname kernel: NFS: Registering the id_resolver key type
> Jan 01 19:28:45 hostname kernel: Key type id_resolver registered
> Jan 01 19:28:45 hostname kernel: Key type id_legacy registered
> Jan 01 19:28:45 hostname kernel: FS-Cache: Duplicate cookie detected
> Jan 01 19:28:45 hostname kernel: FS-Cache: O-cookie c=00000000eab55a10 [p=00000000197b94cc fl=222 nc=0 na=1]
> Jan 01 19:28:45 hostname kernel: FS-Cache: O-cookie d=000000007bc6e6c7 n=00000000d6efde4c
> Jan 01 19:28:45 hostname kernel: FS-Cache: O-key=[16] '0400000001000000020008010a040102'
> Jan 01 19:28:45 hostname kernel: FS-Cache: N-cookie c=00000000d8681119 [p=00000000197b94cc fl=2 nc=0 na=1]
> Jan 01 19:28:45 hostname kernel: FS-Cache: N-cookie d=000000007bc6e6c7 n=00000000fd46ace5
> Jan 01 19:28:45 hostname kernel: FS-Cache: N-key=[16] '0400000001000000020008010a040102'
> Jan 01 19:29:15 hostname kernel: BTRFS info (device sdd1): the free space cache file (274908315648) is invalid, skip it

Free space cache updates were lost too.  btrfs space_cache v1 expects
that to happen, and can detect it and rebuild the cache.
