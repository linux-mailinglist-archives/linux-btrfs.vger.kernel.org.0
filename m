Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBC4EFEAE9
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Nov 2019 07:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbfKPGQj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 16 Nov 2019 01:16:39 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:36396 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfKPGQj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 16 Nov 2019 01:16:39 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id BB9CD4D8501; Sat, 16 Nov 2019 01:16:33 -0500 (EST)
Date:   Sat, 16 Nov 2019 01:16:33 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Richard Weinberger <richard@nod.at>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Decoding "unable to fixup (regular)" errors
Message-ID: <20191116061633.GB22121@hungrycats.org>
References: <1591390.YpsIS3gr9g@blindfold>
 <20191108220927.GR22121@hungrycats.org>
 <1374130535.78772.1573251716407.JavaMail.zimbra@nod.at>
 <20191108222557.GT22121@hungrycats.org>
 <1063943113.78786.1573252282368.JavaMail.zimbra@nod.at>
 <20191108233933.GU22121@hungrycats.org>
 <1389491920.79042.1573293642654.JavaMail.zimbra@nod.at>
 <CAJCQCtTeqxxO=xAw5ogLORoNCvx7E7n0NQ4uF725bYX6vab25Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="5PFZVUeDPxlnBcQp"
Content-Disposition: inline
In-Reply-To: <CAJCQCtTeqxxO=xAw5ogLORoNCvx7E7n0NQ4uF725bYX6vab25Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--5PFZVUeDPxlnBcQp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2019 at 06:17:25PM +0000, Chris Murphy wrote:
> On Sat, Nov 9, 2019 at 10:00 AM Richard Weinberger <richard@nod.at> wrote:
> > I didn't claim that my setup is perfect. What strikes me a little is th=
at
> > the only possible explanation from your side are super corner cases like
> > silent data corruption within an enterprise disk, followed by silent fa=
ilure
> > of my RAID1, etc..
> >
> > I fully agree that such things *can* happen but it is not the most like=
ly
> > kind of failure.
> > All devices are being checked by SMART. Sure, SMART could also be lying=
 to me, but...
>=20
> I don't think Zygo is saying it's definitely not a Btrfs bug.=20

I...kind of was?  Or at least as definite as possible with limited
information.

All I see presented so far is the normal output of scrub's csum checker
after detecting a routine drive data integrity failure.  That's what scrub
is _for_: scrub tells you stuff that SMART and md-raid1 don't (and can't).
I would not expect csum failures on otherwise healthy hardware to be
a bug--I'd expect them to be the result of scrub working exactly as
intended, identifying a failing drive so it can be promptly replaced.

There's also evidence pointing _away_ from the host machine and its
software:  ECC RAM, kernel maintained by SUSE, good testing and production
history on 4.4 and 4.12, no unrelated errors reported, other machines
running same software without problems.

> I think
> he's saying there is a much easier way to isolate where this bug is
> coming from

Unfortunately md-raid1 doesn't provide good enough historical data to do
this isolation, but there may be some information that can be extracted
=66rom the current state of the system.

Start by copying the drives to another machine while offline (NOT
with md-raid1, do it with 'dd' while not mounted).  Mount each drive
separately (on separate machines to avoid accidentally recombining them
into an array) and run 'btrfs scrub' on each one.  If Richard is lucky,
only one of the disks corrupted data and the other one has no errors.
In that case, simply replace the corrupted disk, and maybe avoid buying
any more of that model.

There are 6 hypotheses to test, in roughly decreasing order of frequency:

	1.  Drive A corrupts data, drive B is OK

	2.  Drive B corrupts data, drive A is OK

	3.  Drive A and B both corrupt data, differently

	4.  Drive A and B both corrupt data, identically
	(due to firmware bug or defect in common controller hardware)

	5.  Memory corruption (due to kernel memory access bug like
	use-after-free or use-uninitialized-variable, unreported ECC
	failure, or failure in memory transport components not protected
	by ECC hardware)

	6.  btrfs or md-raid1 bug

[Here I am using "drive A" to refer to the drive that mdadm resync would
copy to drive B during a resync.  Usually drive A would be the one with
the lowest mdadm unit number.]

Hypothesis 6 (btrfs/md-raid1 bug) would be plausible if it were kernel
5.1 or 5.2, which are recent kernels with short testing histories that
already include known data corrupting bugs.  4.12 has been in testing
and production use for 2 years, most of its bugs are well known by now,
and none of those bugs looked like false reports of disk corruption.

Hypothesis 5 (memory corruption) doesn't seem likely because random memory
corruption will have lots of very visible effects prior to affecting
the outcome of a btrfs scrub.  We had a batch of mainboards go bad a
few years back, and in decreasing order the effects were:

	- compiler crashes (daily)

	- unexplained compiler output crashes

	- trivial and mature program crashes (cp, sh, rsync)

	- copied files over ~100M did not match originals

	- git repo SHA1 mismatch failures

	- GPU lockups

	- unrecoverable btrfs and ext4 metadata tree corruption (weekly)

	- numerous strange one-off kernel log messages

	- kernel hangs, panics (monthly)

	- _ONE_(!) btrfs scrub csum error in 20TB of filesystems

	- memtest86 errors (ha ha just kidding, no, every memtest86 test
	passed the whole time because memtest86 didn't heat up the
	bridge chips enough for the memory errors to occur)

There's no way hypothesis 5 could be true without being noticed for
a whole month on a build server, much less a year or long enough
to accumulate as many csum errors as Richard has.

If there have been any mdadm resync events then what we can learn
=66rom examining the present system is limited: evidence for some of
the hypotheses is erased by mdadm resync, so we can't eliminate some
hypotheses by examining the drive contents in the present.

If md-raid1 _always_ gave a zero mismatch count (not just now, but at
all points in the past), and there have been no mdadm resync operations,
then we know hypothesis 1, 2, and 3 are false.  That leaves hypothesis
4 (likely a drive firmware bug if the similarity was not caused by
mdadm itself) as well as the unlikely 5 and 6.  If we don't have the
mismatch_cnt data recorded over time then we can't use it to eliminate
hypotheses.

If md-raid1 gives a non-zero mismatch count then we don't learn anything.
It is possible for mismatch_cnt to have a non-zero value for harmless
reasons (e.g. uncommitted writes sent to one drive but not the other
due to md-raid1 write hole, which btrfs will ignore because they are not
part of the committed filesystem tree) so it is not indicative of failure.

If the two drives are copied offline, mounted individually on separate
machines, and scrubbed, then we could have these results:

	a.  Drive A and B both have at least one error that does not
	appear on the other drive.  Hypothesis 3 is true.

	b.  Drive B has one or more errors that do not appear on drive A.
	Drive B has corruption that didn't come from somewhere else,
	so _at least_ drive B is bad.  Hypothesis 1 is false.

	c.  Drive A has no errors.  Hypothesis 2 is true if drive B has
	errors.  If there was a recent mdadm resync, hypothesis 2 cannot
	be invalidated, but if there are no errors on drive B it cannot
	be proven either.  If there is no mdadm resync and neither drive
	has any errors, either the corrupted blocks have been deleted,
	or this result is unexpected, and we need to look elsewhere for
	probable causes (e.g. bad SATA controller in the original host).

mdadm resync can repair failures on drive B if drive A does not have an
error in the same location at the time of the resync, so we can't draw
any conclusions from the absence of failures on drive B.  It is not
possible to distinguish between hypothesis 4 and a mdadm resync unless
we can prove (by reading logs) there have been no mdadm resyncs since
before errors were detected.

The results can be confirmed by replacing drives that are identified as
bad and observing future scrub errors (or lack thereof).  If hypothesis 4
is not eliminated, replace one drive with a different vendor's model and
hope that two different vendors don't make the same mistakes consistently.

Converting the array to btrfs raid1 eliminates the guesswork:  you get
a permanent record of errors at the time of detection, you don't have
to guess or take the array offline to figure out which drive is failing,
and the scrub/replace operations do not propagate errors silently between
drives so that you can't figure out what's going wrong a year later.

> And the long standing Btrfs developers from the very beginning can
> tell you about their experiences with very high end hardware being
> caught in the act of silent data corruption that Btrfs exposed. This
> is the same sort of things the ZFS developers also discovered ages ago
> and keep on encountering often enough that even now ext4 and XFS do
> metadata checksumming because it's such a known issue.
>=20
> --=20
> Chris Murphy

--5PFZVUeDPxlnBcQp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXc+UPgAKCRCB+YsaVrMb
nEs1AKDLkWowTFFNdDWW5tsLOmMcWRRPFQCglowj48XlB50815dr3yxs8D+9ESM=
=fhmg
-----END PGP SIGNATURE-----

--5PFZVUeDPxlnBcQp--
