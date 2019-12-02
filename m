Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0C710EFFC
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Dec 2019 20:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbfLBT12 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Dec 2019 14:27:28 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:44628 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727686AbfLBT12 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Dec 2019 14:27:28 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id EEAD25075FB; Mon,  2 Dec 2019 14:27:26 -0500 (EST)
Date:   Mon, 2 Dec 2019 14:27:26 -0500
From:   Zygo Blaxell <zblaxell@furryterror.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs: More intelligent degraded chunk allocator
Message-ID: <20191202192726.GP22121@hungrycats.org>
References: <20191107062710.67964-1-wqu@suse.com>
 <20191118201834.GN3001@twin.jikos.cz>
 <f6dfede7-c65c-2321-ab8f-ba16a6a3c71f@gmx.com>
 <20191202032259.GN22121@hungrycats.org>
 <78acb42f-071f-8d78-c335-71c2af5da841@gmx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="7KvBbaRjXS2SFKKp"
Content-Disposition: inline
In-Reply-To: <78acb42f-071f-8d78-c335-71c2af5da841@gmx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--7KvBbaRjXS2SFKKp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 02, 2019 at 12:41:53PM +0800, Qu Wenruo wrote:
>=20
>=20
> On 2019/12/2 =E4=B8=8A=E5=8D=8811:22, Zygo Blaxell wrote:
> > On Tue, Nov 19, 2019 at 07:32:26AM +0800, Qu Wenruo wrote:
> >>
> >>
> >> On 2019/11/19 =E4=B8=8A=E5=8D=884:18, David Sterba wrote:
> >>> On Thu, Nov 07, 2019 at 02:27:07PM +0800, Qu Wenruo wrote:
> >>>> This patchset will make btrfs degraded mount more intelligent and
> >>>> provide more consistent profile keeping function.
> >>>>
> >>>> One of the most problematic aspect of degraded mount is, btrfs may
> >>>> create unwanted profiles.
> >>>>
> >>>>  # mkfs.btrfs -f /dev/test/scratch[12] -m raid1 -d raid1
> >>>>  # wipefs -fa /dev/test/scratch2
> >>>>  # mount -o degraded /dev/test/scratch1 /mnt/btrfs
> >>>>  # fallocate -l 1G /mnt/btrfs/foobar
> >>>>  # btrfs ins dump-tree -t chunk /dev/test/scratch1
> >>>>         item 7 key (FIRST_CHUNK_TREE CHUNK_ITEM 1674575872) itemoff =
15511 itemsize 80
> >>>>                 length 536870912 owner 2 stripe_len 65536 type DATA
> >>>>  New data chunk will fallback to SINGLE or DUP.
> >>>>
> >>>>
> >>>> The cause is pretty simple, when mounted degraded, missing devices c=
an't
> >>>> be used for chunk allocation.
> >>>> Thus btrfs has to fall back to SINGLE profile.
> >>>>
> >>>> This patchset will make btrfs to consider missing devices as last re=
sort if
> >>>> current rw devices can't fulfil the profile request.
> >>>>
> >>>> This should provide a good balance between considering all missing
> >>>> device as RW and completely ruling out missing devices (current main=
line
> >>>> behavior).
> >>>
> >>> Thanks. This is going to change the behaviour with a missing device, =
so
> >>> the question is if we should make this configurable first and then
> >>> switch the default.
> >>
> >> Configurable then switch makes sense for most cases, but for this
> >> degraded chunk case, IIRC the new behavior is superior in all cases.
> >>
> >> For 2 devices RAID1 with one missing device (the main concern), old
> >> behavior will create SINGLE/DUP chunk, which has no tolerance for extra
> >> missing devices.
> >>
> >> The new behavior will create degraded RAID1, which still lacks toleran=
ce
> >> for extra missing devices.
> >>
> >> The difference is, for degraded chunk, if we have the device back, and
> >> do proper scrub, then we're completely back to proper RAID1.
> >> No need to do extra balance/convert, only scrub is needed.
> >=20
> > I think you meant to say "replace" instead of "scrub" above.
>=20
> "scrub" for missing-then-back case.
>=20
> As at the time of write, I didn't even take the replace case into
> consideration...

Using scrub for that purpose has some pretty bad failure modes, e.g.

	https://www.mail-archive.com/linux-btrfs@vger.kernel.org/msg78254.html

mdadm raid1 has many problems, but this is not one of them.  Drives that
exit a mdadm raid1 array are marked of date on the remaining drives'
superblocks (using sequence numbers and time stamps to avoid colliding
sequence numbers from split-brain raid1 cases).  If the drive returns,
it cannot simply reenter the array, it has to be resynced using online
drives as a replacement data source (partial resyncs are possible with
mdadm bitmaps, a similar thing could be done with btrfs block groups).
mdadm will do all this for you automatically.

> >> So the new behavior is kinda of a super set of old behavior, using the
> >> new behavior by default should not cause extra concern.
> >=20
> > It sounds OK to me, provided that the missing device is going away
> > permanently, and a new device replaces it.
> >=20
> > If the missing device comes back, we end up relying on scrub and 32-bit
> > CRCs to figure out which disk has correct data, and it will be wrong
> > 1/2^32 of the time.  For nodatasum files there are no CRCs so the data
> > will be wrong much more often.  This patch doesn't change that, but
> > maybe another patch should.
>=20
> Yep, the patchset won't change it.
>=20
> But this also remind me, so far we are all talking about "degraded"
> mount option.
> Under most case, user is only using "degraded" when they completely
> understands that device is missing, not using that option as a daily opti=
on.

That makes certain high-availability setups (e.g. when btrfs is /)
difficult in practice.  To do it by the book, you'd need to:

	1.  Experience a total disk failure
	2.  Reconfigure bootloader to mount -o degraded
	3.  Shut system down
	4.  Remove old drive, add=20
	5.  Boot system
	6.  btrfs replace
	7.  Reconfigure bootloader to mount without degraded

That's hard (or just expensive and risky) to do in headless remote setups,
especially if step 1 causes a crash, step 2 gets skipped, and the system
has neither a console to reconfigure the bootloader nor will btrfs boot
without reconfiguring the bootloader.

(Note:  I'm assuming that for whatever reason you can't just hotswap the
drive and run replace immediately--or maybe you did hotswap the drive,
then there was a crash or power failure and you had to go back to mounting
with -o degraded to finish the replace anyway.)

In practice, what happens is more like:

	1.  Bootloader configured to mount -o degraded all the time
	2.  Hard disk has a partial failure, drops off bus or firmware crash
	3.  Reboot (due to crash, power failure, adding replacement drive, etc)
	4.  System comes back up with bad disk present
	5.  Lots of csum failures, 0.0000004% of which are not recovered
	    in scrub with CRC32C csums, and nodatacow files damaged
	6.  Repeat from step 2 several times

If users on IRC are representative, most of them do not know that step #2
is a data-losing failure (btrfs does, but btrfs currently doesn't act on
the information as long as only one drive has failed).  Users also don't
know that scrub is not replace (resync in mdadm terms), and will keep
using the drive and filesystem until something more visible goes wrong.
After several loops they show up on IRC asking for help, but by that
point there has been unrecoverable data loss.

> So that shouldn't be a big problem so far.

It isn't a big problem if you follow exactly the single correct procedure,
and know precisely which tools to use in what order.

This is mostly a usability concern:  other RAID systems cope with this
kind of event automatically, without requiring all the explicit operator
intervention.

> Thanks,
> Qu
>=20
> >=20
> >>> How does this work with scrub? Eg. if there are 2 devices in RAID1, o=
ne
> >>> goes missing and then scrub is started. It makes no sense to try to
> >>> repair the missing blocks, but given the logic in the patches all the
> >>> data will be rewritten, right?
> >>
> >> Scrub is unchanged at all.
> >>
> >> Missing device will not go through scrub at all, as scrub is per-device
> >> based, missing device will be ruled out at very beginning of scrub.
> >>
> >> Thanks,
> >> Qu
> >>>
> >>
> >=20
> >=20
> >=20
>=20




--7KvBbaRjXS2SFKKp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXeVlmAAKCRCB+YsaVrMb
nM0tAJ9LPwV1Hisjj3vHYHpyFjA8Fd395gCeJh4WWqSOHvMzWNyHsGyJWALPI/E=
=d2jJ
-----END PGP SIGNATURE-----

--7KvBbaRjXS2SFKKp--
