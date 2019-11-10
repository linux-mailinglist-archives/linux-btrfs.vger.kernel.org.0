Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1812BF6B34
	for <lists+linux-btrfs@lfdr.de>; Sun, 10 Nov 2019 21:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfKJUKT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 10 Nov 2019 15:10:19 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:32872 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbfKJUKT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 10 Nov 2019 15:10:19 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id E1CAE4C4C55; Sun, 10 Nov 2019 15:10:17 -0500 (EST)
Date:   Sun, 10 Nov 2019 15:10:17 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Timothy Pearson <tpearson@raptorengineering.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Unusual crash -- data rolled back ~2 weeks?
Message-ID: <20191110201017.GV22121@hungrycats.org>
References: <344827358.67114.1573338809278.JavaMail.zimbra@raptorengineeringinc.com>
 <5d2a48c3-b0ea-1da8-bf53-fb27de45b3c6@gmx.com>
 <1848426246.125326.1573368477888.JavaMail.zimbra@raptorengineeringinc.com>
 <64be1293-5845-4054-8d5f-b9ff79168a17@gmx.com>
 <1503948411.128656.1573370293214.JavaMail.zimbra@raptorengineeringinc.com>
 <4c5b062b-30c7-2707-2bef-0ea5f18265c5@gmx.com>
 <825354711.177110.1573380131178.JavaMail.zimbra@raptorengineeringinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="zgY/UHCnsaNnNXRx"
Content-Disposition: inline
In-Reply-To: <825354711.177110.1573380131178.JavaMail.zimbra@raptorengineeringinc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--zgY/UHCnsaNnNXRx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 10, 2019 at 04:02:11AM -0600, Timothy Pearson wrote:
>=20
>=20
> ----- Original Message -----
> > From: "Qu Wenruo" <quwenruo.btrfs@gmx.com>
> > To: "Timothy Pearson" <tpearson@raptorengineering.com>
> > Cc: "linux-btrfs" <linux-btrfs@vger.kernel.org>
> > Sent: Sunday, November 10, 2019 1:45:14 AM
> > Subject: Re: Unusual crash -- data rolled back ~2 weeks?
>=20
> > On 2019/11/10 =E4=B8=8B=E5=8D=883:18, Timothy Pearson wrote:
> >>=20
> >>=20
> >> ----- Original Message -----
> >>> From: "Qu Wenruo" <quwenruo.btrfs@gmx.com>
> >>> To: "Timothy Pearson" <tpearson@raptorengineering.com>
> >>> Cc: "linux-btrfs" <linux-btrfs@vger.kernel.org>
> >>> Sent: Sunday, November 10, 2019 6:54:55 AM
> >>> Subject: Re: Unusual crash -- data rolled back ~2 weeks?
> >>=20
> >>> On 2019/11/10 =E4=B8=8B=E5=8D=882:47, Timothy Pearson wrote:
> >>>>
> >>>>
> >>>> ----- Original Message -----
> >>>>> From: "Qu Wenruo" <quwenruo.btrfs@gmx.com>
> >>>>> To: "Timothy Pearson" <tpearson@raptorengineering.com>, "linux-btrf=
s"
> >>>>> <linux-btrfs@vger.kernel.org>
> >>>>> Sent: Saturday, November 9, 2019 9:38:21 PM
> >>>>> Subject: Re: Unusual crash -- data rolled back ~2 weeks?
> >>>>
> >>>>> On 2019/11/10 =E4=B8=8A=E5=8D=886:33, Timothy Pearson wrote:
> >>>>>> We just experienced a very unusual crash on a Linux 5.3 file serve=
r using NFS to
> >>>>>> serve a BTRFS filesystem.  NFS went into deadlock (D wait) with no=
 apparent
> >>>>>> underlying disk subsystem problems, and when the server was hard r=
ebooted to
> >>>>>> clear the D wait the BTRFS filesystem remounted itself in the stat=
e that it was
> >>>>>> in approximately two weeks earlier (!).
> >>>>>
> >>>>> This means during two weeks, the btrfs is not committed.
> >>>>
> >>>> Is there any hope of getting the data from that interval back via bt=
rfs-recover
> >>>> or a similar tool, or does the lack of commit mean the data was stor=
ed in RAM
> >>>> only and is therefore gone after the server reboot?

Writeback will dump out some data blocks between commits; however, without
a commit, there will be no metadata pages on disk that point to the data.

Writeback could keep a fileserver running for a long time as long as
nobody calls a nontrivial fsync() (too complex to be sent to the log tree)
or sync(), or renames a file over another existing file (all may trigger a
commit if reservations fill up); however, as soon as one of those happens,
something should be noticeably failing as the calls will block.

> >>> If it's deadlock preventing new transaction to be committed, then no
> >>> metadata is even written back to disk, so no way to recover metadata.
> >>> Maybe you can find some data written, but without metadata it makes no
> >>> sense.
> >>=20
> >> OK, I'll just assume the data written in that window is unrecoverable =
at this
> >> point then.
> >>=20
> >> Would the commit deadlock affect only one btrfs filesystem or all of t=
hem on the
> >> machine?  I take it there is no automatic dmesg spew on extended deadl=
ock?
> >> dmesg was completely clean at the time of the fault / reboot.

Stepping away from btrfs a bit, I've heard rumors of something like this
happening to SSDs (on Windows, so not a btrfs issue).  I guess it may
be possible for a log-structured FTL layer to revert to a significantly
earlier disk content state if there are enough free erase blocks so that
the older data isn't destroyed, and the pointer to the current log record
isn't updated in persistent storage due to a firmware bug.  Obviously this
is not relevant if you're not using SSD, and not likely if you have a
multi-disk filesystem (one disk will appear to be corrupted in that case).

> > It should have some kernel message for things like process hang for over
> > 120s.
> > If you could recover that, it would help us to locate the cause.
> >=20
> > Normally such deadlock should only affect the unlucky fs which meets the
> > condition, not all filesystems.
> > But if you're unlucky enough, it may happen to other filesystems.
> >=20
> > Anyway, without enough info, it's really hard to say.
>=20
> I was able to retrieve complete logs from the kernel for the entire time =
period.  The BTRFS filesystem was online resized five days before the last =
apparent filesystem commit.  Immediately after resize, a couple of csum err=
ors were thrown for a single inode on the resized filesystem, though this w=
as not detected at the time.  The underlying hardware did not experience a =
fault at any point and is passing all diagnostics at this time.  Intriguing=
ly, there are a handful of files accessible from after the last known good =
filesystem commit (Oct. 29), but the vast majority are simply absent.
>=20
> At this point I'm more interested in making sure this type of event does =
not happen in the future than anything else.  At no point did the kernel pr=
int any type of stack trace or deadlock warning.  I'm starting to wonder if=
 we hit a bug in the online resize path, but am just guessing at this point=
=2E  The timing is certainly very close / coincidental.

To detect this kind of failure we use a watchdog script that invokes mkdir
and rmdir every 30 seconds on each filesystem backed by disk (i.e. btrfs,
ext4, and xfs).  If the mkdir/rmdir takes too long (*) then we try to
log some information (mostly 'echo w > /proc/sysrq-trigger') and force
a reboot.  mkdir and rmdir will eventually get stuck on btrfs if there
is a commit that is not making forward progress.  It's a surprisingly
simple and effective bug detector on ext4 and xfs too.

(This doesn't detect the SSD thing--you'd need RAID1 to handle that case).

The lack of kernel messages is unexpected, especially when you have a NFS
process stuck in D state long enough to get admins to force a reboot.
That should have produced at least a stuck task warning if they are
enabled in your kernel.  Did anyone capture the nfsd process stack trace?

(*) too long can be surprisingly long.  Some btrfs algorithms don't have
bounded running time and can delay a commit for several hours if there
are active writers on the system.  We record logs for commits over 100
seconds, send alarms to admins set at one hour, and automatic reboots
after 12 hours.


> Thanks

--zgY/UHCnsaNnNXRx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXchupQAKCRCB+YsaVrMb
nALJAJ9GC8Jd+O7CYLLjtjBMF3zq7m79HACdFaXVEZT50ra4ziDdDKER99SgGY4=
=YFL+
-----END PGP SIGNATURE-----

--zgY/UHCnsaNnNXRx--
