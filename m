Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C46F130110
	for <lists+linux-btrfs@lfdr.de>; Sat,  4 Jan 2020 06:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725794AbgADFip (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 4 Jan 2020 00:38:45 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:37920 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgADFio (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 4 Jan 2020 00:38:44 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id C961F558AA0; Sat,  4 Jan 2020 00:38:43 -0500 (EST)
Date:   Sat, 4 Jan 2020 00:38:43 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Leszek Dubiel <leszek@dubiel.pl>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: very slow "btrfs dev delete" 3x6Tb, 7Tb of data
Message-ID: <20200104053843.GK13306@hungrycats.org>
References: <6058c4c4-fcb3-c7cd-6517-10b5908b34da@georgianit.com>
 <602a4895-f2f7-f024-c312-d880f12e1360@dubiel.pl>
 <CAJCQCtQEpXvgbs+Y0+A4cLZUft3oqp+sLW8xVPfxt2aqYhMj_g@mail.gmail.com>
 <2c135c87-d01b-53f1-9f76-a5653918a4e7@dubiel.pl>
 <cc364577-1bb8-1512-4d2e-dc7e465ca2d6@dubiel.pl>
 <20191228202344.GE13306@hungrycats.org>
 <c278f501-f5a5-c905-5431-2d735e97fa13@dubiel.pl>
 <CAJCQCtRvAZS1CNgJLdUZTNeUma6A74oPT-SeQe7NYHhXKrMzoA@mail.gmail.com>
 <5e6e2ff8-89be-45db-49d3-802de42663ed@dubiel.pl>
 <CAJCQCtSr9j8AzLRfguHb8+9n_snxmpXkw0V+LiuDnqqvLVAxKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="SLauP2uySp+9cKYP"
Content-Disposition: inline
In-Reply-To: <CAJCQCtSr9j8AzLRfguHb8+9n_snxmpXkw0V+LiuDnqqvLVAxKQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--SLauP2uySp+9cKYP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 02, 2020 at 04:22:37PM -0700, Chris Murphy wrote:
> On Thu, Jan 2, 2020 at 3:39 PM Leszek Dubiel <leszek@dubiel.pl> wrote:
>=20
> >  > Almost no reads, all writes, but slow. And rather high write request
> >  > per second, almost double for sdc. And sdc is near it's max
> >  > utilization so it might be ear to its iops limit?
> >  >
> >  > ~210 rareq-sz =3D 210KiB is the average size of the read request for
> > sda and sdb
> >  >
> >  > Default mkfs and default mount options? Or other and if so what othe=
r?
> >  >
> >  > Many small files on this file system? Or possibly large files with a
> >  > lot of fragmentation?
> >
> > Default mkfs and default mount options.
> >
> > This system could have a few million (!) of small files.
> > On reiserfs it takes about 40 minutes, to do "find /".
> > Rsync runs for 6 hours to backup data.
>=20
> There is a mount option:  max_inline=3D<bytes> which the man page says
> (default: min(2048, page size) )

It's half the page size per a commit from some years ago.  For compressed
size, it's the compressed data size (i.e. you can have a 4095-byte
inline file with max_inline=3D2048 due to the compression).

> I've never used it, so in theory the max_inline byte size is 2KiB.
> However, I have seen substantially larger inline extents than 2KiB
> when using a nodesize larger than 16KiB at mkfs time.
>=20
> I've wondered whether it makes any difference for the "many small
> files" case to do more aggressive inlining of extents.
>=20
> I've seen with 16KiB leaf size, often small files that could be
> inlined, are instead put into a data block group, taking up a minimum
> 4KiB block size (on x64_64 anyway). I'm not sure why, but I suspect
> there just isn't enough room in that leaf to always use inline
> extents, and yet there is enough room to just reference it as a data
> block group extent. When using a larger node size, a larger percentage
> of small files ended up using inline extents. I'd expect this to be
> quite a bit more efficient, because it eliminates a time expensive (on
> HDD anyway) seek.

Putting a lot of inline file data into metadata pages makes them less
dense, which is either good or bad depending on which bottleneck you're
currently hitting.  If you have snapshots there is an up-to-300x metadata
write amplification penalty to update extent item references every time
a shared metadata page is unshared.  Inline extents reduce the write
amplification.  On the other hand, if you are doing a lot of 'find'-style
tree sweeps, then inline extents will reduce their efficiency because more
pages will have to be read to scan the same number of dirents and inodes.

For workloads that reiserfs was good at, there's no reliable rule of
thumb to guess which is better--you have to try both, and measure results.

> Another optimization, using compress=3Dzstd:1, which is the lowest
> compression setting. That'll increase the chance a file can use inline
> extents, in particular with a larger nodesize.
>=20
> And still another optimization, at the expense of much more
> complexity, is LVM cache with an SSD. You'd have to pick a suitable
> policy for the workload, but I expect that if the iostat utilizations
> you see of often near max utilization in normal operation, you'll see
> improved performance. SSD's can handle way higher iops than HDD. But a
> lot of this optimization stuff is use case specific. I'm not even sure
> what your mean small file size is.

I've found an interesting result in cache configuration testing: btrfs's
writes with datacow seem to be very well optimized, to the point that
adding a writeback SSD cache between btrfs and a HDD makes btrfs commits
significantly slower.  A writeback cache adds latency to the write path
without removing many seeks--btrfs already does writes in big contiguous
bursts--so the extra latency makes the writeback cache slow compared to
writethrough.  A writethrough SSD cache helps with reads (which are very
seeky and benefit a lot from caching) without adding latency to writes,
and btrfs reads a _lot_ during commits.
=20
> > # iotop -d30
> >
> > Total DISK READ:        34.12 M/s | Total DISK WRITE: 40.36 M/s
> > Current DISK READ:      34.12 M/s | Current DISK WRITE:      79.22 M/s
> >    TID  PRIO  USER     DISK READ  DISK WRITE  SWAPIN     IO> COMMAND
> >   4596 be/4 root       34.12 M/s   37.79 M/s  0.00 % 91.77 % btrfs
>=20
> Not so bad for many small file reads and writes with HDD. I've see
> this myself with single spindle when doing small file reads and
> writes.
>=20
>=20
> --=20
> Chris Murphy

--SLauP2uySp+9cKYP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSnOVjcfGcC/+em7H2B+YsaVrMbnAUCXhAk3gAKCRCB+YsaVrMb
nNRFAKCd0um/fqen3XA7rfg4ctF4clLsKQCgzfS/2404o0U9645ztSEpUwIPZJ4=
=ElGk
-----END PGP SIGNATURE-----

--SLauP2uySp+9cKYP--
