Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B501AFA74D
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2019 04:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbfKMDbt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Nov 2019 22:31:49 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:47460 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727275AbfKMDbt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Nov 2019 22:31:49 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 510484CDFD6; Tue, 12 Nov 2019 22:31:23 -0500 (EST)
Date:   Tue, 12 Nov 2019 22:31:23 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Decoding "unable to fixup (regular)" errors
Message-ID: <20191113033119.GW22121@hungrycats.org>
References: <1591390.YpsIS3gr9g@blindfold>
 <20191108220927.GR22121@hungrycats.org>
 <1374130535.78772.1573251716407.JavaMail.zimbra@nod.at>
 <20191108222557.GT22121@hungrycats.org>
 <1063943113.78786.1573252282368.JavaMail.zimbra@nod.at>
 <20191108233933.GU22121@hungrycats.org>
 <1389491920.79042.1573293642654.JavaMail.zimbra@nod.at>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="u3bvv0EcKsvvYeex"
Content-Disposition: inline
In-Reply-To: <1389491920.79042.1573293642654.JavaMail.zimbra@nod.at>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--u3bvv0EcKsvvYeex
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 09, 2019 at 11:00:42AM +0100, Richard Weinberger wrote:
> ----- Urspr=FCngliche Mail -----
> > Von: "Zygo Blaxell" <ce3g8jdj@umail.furryterror.org>
> > The most striking thing about the description of your setup is that you
> > have ECC RAM and you have a scrub regime to detect errors...but you have
> > both a huge gap in error detection coverage and a mechanism to propagate
> > errors across what is supposed to be a fault isolation boundary because
> > you're using mdadm raid1 instead of btrfs raid1.  If one of your disks
> > goes bad, not only will it break your filesystem, but you won't know
> > which disk you need to replace.
>=20
> I didn't claim that my setup is perfect. What strikes me a little is that
> the only possible explanation from your side are super corner cases like
> silent data corruption within an enterprise disk, followed by silent fail=
ure
> of my RAID1, etc..

These are not super corner cases.  This is the point you keep missing.

The first event (silent data corruption) is not unusual.  The integrity
mechanisms you are relying on to detect failures (mdadm checkarray and
SMART) don't detect this failure mode very well (or at all).

Your setup goes directly from "double the risk of silent data corruption
by using mdadm-RAID1" to "detect data corruption after the fact by using
btrfs" with *nothing* in between.

Your setup is almost like an incubator for reproducing this kind of issue.
We use a similar arrangement of systems and drives in the test lab
when we want to quickly reproduce data corruption problems with real
drive firmware (as opposed to just corrupting the disks ourselves).
The main difference is that we don't use md-raid1 for this because it's
a slow, unreliable, often manual process to identify which sectors were
corrupted and which were correct.  btrfs-raid1 spits out the physical
sector address and device in the kernel log, all we have to do is read
the blocks on both drives to confirm the good and bad contents.

Silent data corruption in hard drives is an event that happens once or
twice a year somewhere in the fleet (among all the other more visible
failure modes like UNC sectors and total disk failures).  We've identified
4 models of WD hard drive that are capable of returning mangled data
on reads, half of those without reporting a read error or any SMART
indication.

We also have Toshiba, Hitachi, and Seagate hard drives, but so far no
silent corruption failures from those vendors.  I'm sure they can have
data corruption too, but after a decade of testing so far the score is
WD 4, everyone else 0.

I don't know what you're using for "RAID health check", but if it's
mdadm's checkarray script, note that the checkarray script does not
report corruption errors.  It does set up the mdadm mismatch checker, and
mismatches are counted by the kernel in /sys/block/*/md/mismatch_cnt,
but it does *not* report mismatches in an email alert, kernel log,
/proc/mdstat, or in mdadm -D output.  It does not preserve mismatch
counts across reboots, array resyncs, or from one check to the next--in
all these events, the counter resets to zero, and mdadm's one and only
indicator of past corruption events is lost.

Unless you have been going out of your way to scrape mismatch_cnt values
out of /sys/block/*/md, you have ignored all corruption errors mdadm
might have detected so far.  You might find some if you run a check now,
though.

On the other hand, if you *have* been logging mismatch_cnt since before
the first btrfs error was reported, and it's been consistently zero,
then something more interesting may be happening.

> I fully agree that such things *can* happen but it is not the most likely
> kind of failure.

Data corruption in the drive is the best fit for the symptoms presented
so far.  They happen every few years on production systems, usually when
we introduce a new drive model to the fleet and it turns out to have a
much higher than normal failure rate.  Sometimes it happens to otherwise
good drives as they fail (i.e. we get corrupted data first, then a few
weeks or months later the SMART errors start, or the drive just stops).
The likelihood of it happening in your setup is doubled.

The hypothetical bug in scrub you suggest elsewhere in this thread doesn't
happen in the field, and seems to be difficult to implement deliberately,
much less accidentally.  Historically this has been some of the most
correct and robust btrfs code.  Failures here are not likely at all.

> All devices are being checked by SMART. Sure, SMART could also be lying t=
o me, but...

SMART doesn't lie when it doesn't report problems.  To be able to lie,
SMART would first have to know the truth.

A SMART pass means the power supply is working, the drive firmware
successfully booted, and the firmware didn't record any recognized failure
events in a log.

There is a world of difference between "didn't record any recognized
failure events" and "didn't have any failures", which includes various
points like "had failures but didn't successfully record them due to
the failure" and "had failures that the firmware didn't recognize".

Enterprise drives are not immune to these problems; if anything, they're
more vulnerable due to higher SoC and firmware complexity.

> Thanks,
> //richard

--u3bvv0EcKsvvYeex
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXct5BAAKCRCB+YsaVrMb
nEm6AKCWPKf4NnNeQeCePJBuMeZKuS7ufACdEBfMTJQxxtzOA8nRtIebOZqVqLQ=
=WHoa
-----END PGP SIGNATURE-----

--u3bvv0EcKsvvYeex--
