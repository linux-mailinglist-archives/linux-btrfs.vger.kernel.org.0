Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45B5D11BBD3
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2019 19:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbfLKSgc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Dec 2019 13:36:32 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:42784 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbfLKSgc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Dec 2019 13:36:32 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id DE08151EA04; Wed, 11 Dec 2019 13:36:30 -0500 (EST)
Date:   Wed, 11 Dec 2019 13:36:30 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Cerem Cem ASLAN <ceremcem@ceremcem.net>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: Is it logical to use a disk that scrub fails but smartctl
 succeeds?
Message-ID: <20191211183630.GK22121@hungrycats.org>
References: <CAN4oSBdH-+BmSLO7DC3u-oBwabNRH2jY2UUO+J0zdxeJTu5FCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="2EejY7RDPU7h6CFd"
Content-Disposition: inline
In-Reply-To: <CAN4oSBdH-+BmSLO7DC3u-oBwabNRH2jY2UUO+J0zdxeJTu5FCg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--2EejY7RDPU7h6CFd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2019 at 04:11:05PM +0300, Cerem Cem ASLAN wrote:
> This is the second time after a year that the server's disk throws
> "INPUT OUTPUT ERROR" and "btrfs scrub" finds some uncorrectable errors
> along with some corrected errors.=20

Some minor failures (e.g. a bad sector event every N drive-years)
are expected and recoverable during normal drive operation.  The
expected rates are laid out in the drive model's detailed spec sheets.
More than one failure per drive-year is quite high.  You are correct
to suspect the drive might be failing.

> However, "smartctl -x" displays
> "SMART overall-health self-assessment test result: PASSED".

When firwmare reports a "PASSED" result in SMART, it means that there
are no known unrecoverable failures.  PASSED does not mean that there
are no failures, nor does it mean all detected failures will in fact be
recoverable--it simply means that the drive has not failed so much that
it is no longer possible to try recovery any more.

"FAILED" can indicate the drive firmware has detected a truly
unrecoverable condition, or it has violated a theoretical (but possibly
harmless) constraint.  FAILED could also be the result of a drive
firmware bug.

In practical terms, the health self-assessment is useless, as it has
only two possible results and neither provides actionable information.

Try 'smartctl -t long', then wait some minutes (it will give you an
estimate of how many), then look at the detailed self-test log output from
'smartctl -x'.  The long self-test usually reads all sectors on the disk
and will quantify errors (giving UNC sector counts and locations).

Spinning hard drives normally grow a few bad sectors over multi-year
time scales.  They are often recoverable: simply write replacement data
into the sector, and the drive will remap the write to a good area of the
disk; however, if there are thousands of errors, and new bad sectors show
up in later tests that were not present in tests from a few days before,
then the drive is likely failing and should be replaced.

> Should we interpret "btrfs scrub"'s "uncorrectable error count" as
> "time to replace the disk" or are those unrelated events?

You need to look at the specific error counts individually, as they
indicate different problems.  There are 5 kinds of uncorrectable
error:

	- verify errors -> bad drive firmware (buy a different model
	disk, or try disabling write caching) or you are using a virtual
	storage stack (e.g. the btrfs is running in a VM and the VM disk
	image file is not configured correctly).  The disk told btrfs
	a write was completed, but btrfs later read the data and found
	something unexpected in its place.  If the underlying problem
	is not corrected the filesystem will eventually be destroyed.

        - corruption or csum errors -> usually RAM failure, either in the
        host or the hard drive, but can also be a symptom of firmware
        bugs or cable issues.  SMART cannot detect any of these errors
        except bad cables (as SATA/UDMA CRC errors).  Replace hardware,
        but see below for details about *which* hardware.

        - read errors -> one event per year is OK, maybe 2 on a cheap
        drive.  A single failure event should add no more than a few
        hundred unreadable blocks.  Replace hardware on the third event
        in a 365-day period, or if more than 1000 errors per TB are
        found in a single scrub.  Read errors can occur temporarily
        when the drive is outside of its operating temperature range
        (in which case fix the temperature not the drive).

        - write / flush errors -> sector remapping failed, probably
        because there are too many errors on the disk and the remap
        reserved area is now full.  Replace hardware.

Note that the hardware you have to replace is not necessarily the disk.
Bad cables (data or power) and bad power supplies can cause many of
these symptoms.  Host RAM failure can result in csum errors, though
usually btrfs is severely damaged before the csum errors are apparent.
For bad firmware you have to replace the disk with a model that has
different firmware, or upgrade the firmware if possible.

Also note that btrfs raid5/6 profiles have issues that make scrub output
unusable for the purpose of assessing drive health: accurate attribution
of csum failures to devices is not possible, and there's at least one
outstanding btrfs data corruption bug on raid5/6 that will show up in
scrub as csum failures.

> Thanks in advance.

--2EejY7RDPU7h6CFd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXfE3KgAKCRCB+YsaVrMb
nCMQAJ91AtAhH3rja6/++WyHHPVOb90Y2QCg1s8yZATbuKr7W40W2W54+aDLsDE=
=gxCy
-----END PGP SIGNATURE-----

--2EejY7RDPU7h6CFd--
