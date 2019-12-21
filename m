Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0A9128B5F
	for <lists+linux-btrfs@lfdr.de>; Sat, 21 Dec 2019 21:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfLUUGm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 21 Dec 2019 15:06:42 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:33402 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbfLUUGl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 21 Dec 2019 15:06:41 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 1FAFE537865; Sat, 21 Dec 2019 15:06:37 -0500 (EST)
Date:   Sat, 21 Dec 2019 15:06:32 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Marc Lehmann <schmorp@schmorp.de>
Subject: Re: btrfs dev del not transaction protected?
Message-ID: <20191221200632.GB13306@hungrycats.org>
References: <20191220040536.GA1682@schmorp.de>
 <b9e7f094-0080-ef08-68df-61ffbeaa9d19@gmx.com>
 <20191220063702.GE5861@schmorp.de>
 <1912b2a1-2aa9-bf4c-198f-c5e1565dd11f@gmx.com>
 <20191220132703.GA3435@schmorp.de>
 <204287e5-8aca-3a51-9bc9-be577299bfd6@gmx.com>
 <20191220165008.GA1603@schmorp.de>
 <CAJCQCtRBTaGoAejs9Ms=EbeJJRvMH8t5xHPgXp8P==sCMZZaJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="R3G7APHDIzY6R/pk"
Content-Disposition: inline
In-Reply-To: <CAJCQCtRBTaGoAejs9Ms=EbeJJRvMH8t5xHPgXp8P==sCMZZaJQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--R3G7APHDIzY6R/pk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 20, 2019 at 01:24:02PM -0700, Chris Murphy wrote:
> On Fri, Dec 20, 2019 at 9:53 AM Marc Lehmann <schmorp@schmorp.de> wrote:
> >
> > On Fri, Dec 20, 2019 at 09:41:15PM +0800, Qu Wenruo <quwenruo.btrfs@gmx=
=2Ecom> wrote:
>=20
> > > Consider all these insane things, I tend to believe there is some
> > > FUA/FLUSH related hardware problem.
> >
> > Please don't - I honestly think btrfs developers are way to fast to bla=
me
> > hardware for problems.
>=20
> That's because they have a lot of evidence of this, in a way that's
> only inferable with other file systems. This has long been suspected
> by, and demonstrated, well before Btrfs with ZFS development.
>=20
> A reasonable criticism of Btrfs development is the state of the file
> system check repair, which still has danger warnings. But it's also a
> case of damned if they do, and damned if they don't provide it. It
> might be the best chance of recovery, so why not provide it?
> Conversely, the reality is that the file system is complicated enough,
> and the file system checker too slow, that the effort needs to be on
> (what I call) file system autopsy tools, to figure out why the
> corruption happened, and prevent that from happening. The repair is
> often too difficult.
>=20
> Take, for example, the recent 5.2.0-5.2.14 corruption bug. That was
> self-reported once it was discovered and fixed, which took longer than
> usual, and developers apologized. What else can they do? It's not like
> the developers are blaming hardware for their own bugs. They have
> consistently taken responsibility for Btrfs bugs.
>=20
>=20
> > I currently lose btrfs filesystems about once every
> > 6 months, and other than the occasional user error, it's always the ker=
nel
> > (e.g. 4.11 corrupting data, dmcache and/or bcache corrupting things,
> > low-memory situations etc. - none of these seem to be centric to btrfs,
> > but none of those are hardware errors either). I know its the kernel in
> > most cases because in those cases, I can identify the fix in a later
> > kernel, or the mitigating circumstances don't appear (e.g. freezes).
>=20
> Usually Btrfs developers do mention the possibility of other software
> layers contributing to the problem, it's a valid observation that this
> possibility be stated.

Also note that not all btrfs developers will agree on a failure analysis.
Some patience is required.  Be prepared to support your bug report with
working reproducers and relevant evidence, possibly many times, with fresh
backtraces on each new kernel release in which the bug still appears.

> However, if it's exclusively a software problem, then it should be
> reproducible on other systems.
>=20
>=20
> > In any case if it is a hardware problem, then linux and/or btrfs has
> > to work around them, because it affects many different controllers on
> > different boards:
>=20
> How do you propose Btrfs work around it? In particular when there are
> additional software layers over which it has no control?
>=20
> Have you tried disabling the (drives') write cache?

Apparently many sysadmins disable write cache proactively on all drives,
instead of waiting until the drive drops some data to learn that there's
a problem with the firmware.  That's a reasonable tradeoff for btrfs,
which already has a heavily optimized write path (most of the IO time
in btrfs commit is spent _reading_ metadata).

> > Just while I was writing this mail, on 5.4.5, the _newly created_ btrfs
> > filesystem I restored to went into readonly mode with ENOSPC. Another
> > hardware problem?
>=20
> > [41801.618887] CPU: 2 PID: 5713 Comm: kworker/u8:15 Tainted: P         =
  OE     5.4.5-050405-generic #201912181630
>=20
> Why is this kernel tainted? The point of pointing this out isn't to
> blame whatever it tainting the kernel, but to point out that
> identifying the cause of your problems is made a lot more difficult. I
> think you need to simplify the setup, a lot, in order to reduce the
> surface area of possible problems. Any bug hunt is made way harder
> when there's complication.
>=20
>=20
>=20
> > [41801.618888] Hardware name: MSI MS-7816/Z97-G43 (MS-7816), BIOS V17.8=
 12/24/2014
> > [41801.618903] Workqueue: btrfs-endio-write btrfs_endio_write_helper [b=
trfs]
> > [41801.618916] RIP: 0010:btrfs_finish_ordered_io+0x730/0x820 [btrfs]
> > [41801.618917] Code: 49 8b 46 50 f0 48 0f ba a8 40 ce 00 00 02 72 1c 8b=
 45 b0 83 f8 fb 0f 84 d4 00 00 00 89 c6 48 c7 c7 48 33 62 c0 e8 eb 9c 91 d5=
 <0f> 0b 8b 4d b0 ba 57 0c 00 00 48 c7 c6 40 67 61 c0 4c 89 f7 bb 01
> > [41801.618918] RSP: 0018:ffffc18b40edfd80 EFLAGS: 00010282
> > [41801.618921] BTRFS: error (device dm-35) in btrfs_finish_ordered_io:3=
159: errno=3D-28 No space left
> > [41801.618922] RAX: 0000000000000000 RBX: ffff9f8b7b2e3800 RCX: 0000000=
000000006
> > [41801.618922] BTRFS info (device dm-35): forced readonly
> > [41801.618924] RDX: 0000000000000007 RSI: 0000000000000092 RDI: ffff9f8=
bbeb17440
> > [41801.618924] RBP: ffffc18b40edfdf8 R08: 00000000000005a6 R09: fffffff=
f979a4d90
> > [41801.618925] R10: ffffffff97983fa8 R11: ffffc18b40edfbe8 R12: ffff9f8=
ad8b4ab60
> > [41801.618926] R13: ffff9f867ddb53c0 R14: ffff9f8bbb0446e8 R15: 0000000=
000000000
> > [41801.618927] FS:  0000000000000000(0000) GS:ffff9f8bbeb00000(0000) kn=
lGS:0000000000000000
> > [41801.618928] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [41801.618929] CR2: 00007f8ab728fc30 CR3: 000000049080a002 CR4: 0000000=
0001606e0
> > [41801.618930] Call Trace:
> > [41801.618943]  finish_ordered_fn+0x15/0x20 [btrfs]
> > [41801.618957]  normal_work_helper+0xbd/0x2f0 [btrfs]
> > [41801.618959]  ? __schedule+0x2eb/0x740
> > [41801.618973]  btrfs_endio_write_helper+0x12/0x20 [btrfs]
> > [41801.618975]  process_one_work+0x1ec/0x3a0
> > [41801.618977]  worker_thread+0x4d/0x400
> > [41801.618979]  kthread+0x104/0x140
> > [41801.618980]  ? process_one_work+0x3a0/0x3a0
> > [41801.618982]  ? kthread_park+0x90/0x90
> > [41801.618984]  ret_from_fork+0x1f/0x40
> > [41801.618985] ---[ end trace 35086266bf39c897 ]---
> > [41801.618987] BTRFS: error (device dm-35) in btrfs_finish_ordered_io:3=
159: errno=3D-28 No space left
> >
> > unmount/remount seems to make it work again, and it is full (df) yet has
> > 3TB of unallocated space left. No clue what to do now, do I have to sta=
rt
> > over restoring again?
> >
> >    Filesystem               Size  Used Avail Use% Mounted on
> >    /dev/mapper/xmnt-cold15   27T   23T     0 100% /cold1
>=20
> Clearly a bug, possibly more than one. This problem is being discussed
> in other threads on df misreporting with recent kernels, and a fix is
> pending.
>=20
> As for the ENOSPC, also clearly a bug. But not clear why or where.
>=20
>=20
> > Please, don't always chalk it up to hardware problems - btrfs is a
> > wonderful filesystem for many reasons, one reason I like is that it can
> > detect corruption much earlier than other filesystems. This featire alo=
ne
> > makes it impossible for me to go back to xfs. However, I had corruption
> > on ext4, xfs, reiserfs over the years, but btrfs *is* simply way buggier
> > still than those - before btrfs (and even now) I kept md5sums of all
> > archived files (~200TB), and xfs and ext4 _do_ a much better job at not
> > corrupting data than btrfs on the same hardware - while I get filesystem
> > problems about every half a year with btrfs, I had (silent) corruption
> > problems maybe once every three to four years with xfs or ext4 (and not
> > yet on the bxoes I use currently).
>=20
> I can't really parse the suggestion that you are seeing md5 mismatches
> (indicating data changes) on Btrfs, where Btrfs doesn't produce a csum
> warning along with EIO on those files? Are these files nodatacow,
> either by mount option nodatasum or nodatacow, or using chattr +C on
> these files?
>=20
> A mechanism explaining this anecdote isn't clear. Not even crc32c
> checksum collision would explain more than maybe one instance of it.
>=20
> I'm curious what Zygo thinks about this.

Hardware bugs and failures are certainly common, and fleetwide hardware
failures do happen.  They're also recognizable as hardware bugs--some
specific failure modes (e.g. single-bit data value errors, parent transid
verify failure after crashes) are definitely hardware and can be easily
spotted with only a few lines of kernel logs.  Some components of btrfs
(e.g.  scrubs, csum verification, raid1 corruption recovery) are very
reliable detectors of hardware or firmware misbehavior (although sometimes
it is not trivial to identify _which_ hardware is at fault).  Some parts
of btrfs (like free space management) are completely btrfs, and cannot
be affected by hardware failures without destroying the entire filesystem.

On the other hand, it's not like btrfs or the Linux kernel has been
bug free either, and a lot of serious but hard to detect bugs are 5-10
years old when they get fixed.  All kernels before 5.1 had silent data
corruption bugs for compressed data at hole boundaries.  Kernels 5.1 to
5.4 have use-after-free bugs in btrfs that lead to metadata corruption
(5.1), transaction aborts due to self-detected metadata corruption
(5.2), and crashes (5.3 and 5.4).  5.2 also had a second metadata
corruption with deadlock bug.  Other parts of the kernel are hard on
data as well: somewhere around 4.7 a year-old kernel memory corruption
bug was found in the r8169 network driver, and 4.0, 4.19, and 5.1 all
had famous block-layer bugs that would destroy any filesystem under
certain conditions.

I test every upstream kernel release thoroughly before deploying to
production, because every upstream Linux kernel release has thousands
of bugs (btrfs is usually about 1-2% of those).  I am still waiting
for the very first upstream kernel release for btrfs that can run our
full production stress test workload without any backported fixes and
without crashing or corrupting data or metadata for 30 days.  So far
that goal has never been met.  We upgrade kernels when a new release
gets better than an old one, but the median uptime under stress is
still an order of magnitude short of the 30 day mark, and our testing
on 5.4.5+fixes isn't done yet.

Unfortunately, due to the nature of crashing bugs, we can only work on
the most frequently occurring bug at any time, and each one has to be
fixed before the next most frequently occurring bug can be discovered,
making these fixes a very sequential process.  Then there's the two-month
lag to get patches from the mailing list into stable kernels, which is
plenty of time for new regressions to appear, and we start over again
with a fresh set of bugs to fix.

btrfs dev del bugs are not crashing bugs, so they are so far down my
priority list that I haven't bothered to test for them, or even to report
them when I find one accidentally.  There are a few bugs there though,
especially if you are low on metadata space (which is a likely event if
you just removed an entire disk's worth of storage) or btrfs has a bug in
that kernel version that just makes btrfs _think_ it is low on metadata
space, and the transaction aborts during the delete.  Occasionally I hit
one of these in an array and work around it with a patch like this one:

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 56e35d2e957c..b16539fd2c23 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7350,6 +7350,8 @@ int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_in=
fo)
 #if 0
                ret =3D -EINVAL;
                goto error;
+#else
+               btrfs_set_super_num_devices(fs_info->super_copy, total_dev);
 #endif
        }
        if (btrfs_super_total_bytes(fs_info->super_copy) <

Probably not a good idea for general use, but it may solve an immediate
problem if the problem is simply that the wrong number of devices is
stored in the superblock.

>=20
>=20
>=20
>=20
>=20
>=20
> >
> > Please take these issues seriously - the trend of "it's a hardware
> > problem" will not remove the "unstable" stigma from btrfs as long as bt=
rfs
> > is clearly more buggy then other filesystems.
>=20
> > Sorry to be so blunt, but I am a bit sensitive with always being told
> > "it's probably a hardware problem" when it clearly affects practically =
any
> > server and any laptop I administrate. I believe in btrfs, and detecting
> > corruption early is a feature to me.
>=20
> The problem with the anecdotal method of arguing in favor of software
> bugs as the explanation? It directly goes against my own experience,
> also anecdote. I've had no problems that I can attribute to Btrfs. All
> were hardware or user sabotage. And I've had zero data loss, outside
> of user sabotage.

You are definitely not testing hard enough.  ;)

At one point in 2016 there were 145 active bugs known today.  About 10
of those 145 were discovered in the last few months alone (i.e. it was
broken in 2016, and we only know now how broken it was then after 3
years of hindsight).  https://imgur.com/a/A2sXcQB

Thankfully, many of those bugs were mostly harmless, but some were not:
I've found at least 5 distinct data or metadata corrupting bugs since
2014, and confirmed the existence of several more in regression testing.

> I have seen device UNC read errors, corrected automatically by Btrfs.
> And I have seen devices return bad data that Btrfs caught, that would
> otherwise have been silent corruption of either metadata or data, and
> this was corrected in the raid1 cases, and merely reported in the
> non-raid cases. And I've also seen considerable corruption reported
> upon SD Cards in the midst of implosion and becoming read only. But
> even read only, I was able to get all the data out.

btrfs data recovery on raid1 from csum and UNC sector failures is
excellent.  I've seen no issues there since 3.18ish.  I do test that
=66rom time to time with VMs and fault injection and also with real
disk failures.

btrfs on raid5 (internal or external raid5 implementation), device delete,
and some unfortunate degraded mode behaviors still need some work.

> But in your case, practically ever server and laptop? That's weird and
> unexpected. And it makes me wonder what's in common. Btrfs is much
> fussier than other file systems because the by far largest target for
> corruption, isn't file system metadata, but data. The actual payload
> of a file system isn't the file system. And Btrfs is the only Linux
> native file system that checksums data. The other file systems check
> only metadata, and only somewhat recently, depending on the
> distribution you're using.

If the "corruption" consists of large quantities of zeros, the problem
might be using the (default) noflushoncommit mount option, or using
applications that don't fsync() religiously.  This is correct filesystem
behavior, though maybe not behavior any application developer wants.

If the corruption affects compressed data adjacent to holes, then it's
a known problem fixed in 5.1 and later.

If the corruption is specifically and only parent transid verify failures
after a crash, UNC sector read, or power failure, then we'd be looking for
drive firmware issues or non-default kernel settings to get a fleetwide
effect.

If the corruption is general metadata corruption without metadata page
csum failures, then it could be host RAM failure, general kernel memory
corruption (i.e. you have to look at all the other device drivers in the
system), or known bugs in btrfs kernel 5.1 and later.

If the corruption is all csum failures, then there's a long list of
drive issues that could cause it, or the partition could be trampled by
other software (BIOSes are sometimes surprisingly bad at this).

> > I understand it can be frustrating to be confronted with hard to explain
> > accidents, and I understand if you can't find the bug with the sparse i=
nfo
> > I gave, especially as the bug might not even be in btrfs. But keep in m=
ind
> > that the people who boldly/dumbly use btrfs in production and restore
> > dozens of terabytes from backup every so and so many months are also be=
ing
> > frustrated if they present evidence from multiple machines and get told
> > "its probably a hardware problem".
>=20
> For sure. But take the contrary case that other file systems have
> depended on for more than a decade: assuming the hardware is returning
> valid data. This is intrinsic to their design. And go back before they
> had metadata checksumming, and you'd see it stated on their lists that
> they do assume this, and if your devices return any bad data, it's not
> the file system's fault at all. Not even the lack of reporting any
> kind of problem whatsoever. How is that better?
>=20
> Well indeed, not long after Btrfs was demonstrating these are actually
> more common problems that suspected, metadata checksumming started
> creeping into other file systems, finally becoming the default (a
> while ago on XFS, and very recently on ext4). And they are catching a
> lot of these same kinds of layer and hardware bugs. Hardware does not
> just mean the drive, it can be power supply, logic board, controller,
> cables, drive write caches, drive firmware, and other drive internals.
>=20
> And the only way any problem can be fixed, is to understand how, when
> and where it happened.
>=20
> --
> Chris Murphy
>=20

--R3G7APHDIzY6R/pk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXf57RgAKCRCB+YsaVrMb
nAOlAJ9XuU3KSIrmubSj7ukeHnX4VOh2TQCg1ppo/Ak+wwoSVpjCNXCcMauN81c=
=66PJ
-----END PGP SIGNATURE-----

--R3G7APHDIzY6R/pk--
