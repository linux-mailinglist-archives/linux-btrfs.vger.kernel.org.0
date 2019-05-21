Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5575E24B52
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2019 11:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbfEUJSo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 May 2019 05:18:44 -0400
Received: from frost.carfax.org.uk ([85.119.82.111]:53720 "EHLO
        frost.carfax.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbfEUJSo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 May 2019 05:18:44 -0400
Received: from hrm by frost.carfax.org.uk with local (Exim 4.80)
        (envelope-from <hrm@carfax.org.uk>)
        id 1hT0uw-00047Q-Cm; Tue, 21 May 2019 09:18:42 +0000
Date:   Tue, 21 May 2019 09:18:42 +0000
From:   Hugo Mills <hugo@carfax.org.uk>
To:     Erik Jensen <erikjensen@rkjnsn.net>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: "bad tree block start" when trying to mount on ARM
Message-ID: <20190521091842.GS1667@carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo@carfax.org.uk>,
        Erik Jensen <erikjensen@rkjnsn.net>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <CAMj6ewO7PGBoN565WYz_bqL6nGszweNouP-Fphok9+GGpGn8gg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="eu12+zRL7gQwOC+E"
Content-Disposition: inline
In-Reply-To: <CAMj6ewO7PGBoN565WYz_bqL6nGszweNouP-Fphok9+GGpGn8gg@mail.gmail.com>
X-GPG-Fingerprint: DD84 D558 9D81 DDEE 930D  2054 585E 1475 E2AB 1DE4
X-GPG-Key: E2AB1DE4
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: darksatanic darkersatanic darkling darkthing
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--eu12+zRL7gQwOC+E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 21, 2019 at 01:34:42AM -0700, Erik Jensen wrote:
> I have a 5-drive btrfs filesystem. (raid-5 data, dup metadata). I can
> mount it fine on my x86_64 system, and running `btrfs check` there
> reveals no errors. However, I am not able to mount the filesystem on
> my 32-bit ARM board, which I am hoping to use for lower-power file
> serving. dmesg shows the following:
> 
> [   83.066301] BTRFS info (device dm-3): disk space caching is enabled
> [   83.072817] BTRFS info (device dm-3): has skinny extents
> [   83.553973] BTRFS error (device dm-3): bad tree block start, want
> 17628726968320 have 396461950000496896
> [   83.554089] BTRFS error (device dm-3): bad tree block start, want
> 17628727001088 have 5606876608493751477
> [   83.601176] BTRFS error (device dm-3): bad tree block start, want
> 17628727001088 have 5606876608493751477
> [   83.610811] BTRFS error (device dm-3): failed to verify dev extents
> against chunks: -5
> [   83.639058] BTRFS error (device dm-3): open_ctree failed
> 
> Is this expected to work? I did notice that there are gotchas on the
> wiki related to filesystems over 8TiB on 32-bit systems, but it
> sounded like they were mostly related to running the tools, as opposed
> to the filesystem driver itself. (Each of the five drives is
> 8TB/7.28TiB)

   Yes, it should work. We had problems with ARM several years ago,
because of its unusual behaviour with unaligned word accesses, but
those were in userspace, and, as far as I know, fixed now. Looking at
the want/have numbers, it doesn't look like an endianness problem or
an ARM-unaligned-access problem.

> If this isn't expected, what should I do to help track down the issue?

   Can you show us the output of "btrfs check --readonly", on both the
x86_64 machine and the ARM machine? It might give some more insight
into the nature of the breakage.

   Possibly also "btrfs inspect dump-super" on both machines.

> Also potentially relevant: The x86_64 system is currently running
> 4.19.27, while the ARM system is running 5.1.3.

   Shouldn't make a difference.

> Finally, just in case it's relevant, I just finished reencrypting the
> array, which involved doing a `btrfs replace` on each device in the
> array.

   If you can still mount on x86_64, then the FS is at least
reasonably complete and undamaged. I don't think this will make a
difference.  However, it's worth checking whether there are any
funnies about your encryption layer on ARM (I wouldn't expect any,
since it's recognising the decrypted device as btrfs, rather than
random crud).

   Hugo.

-- 
Hugo Mills             | Prisoner unknown: Return to Zenda.
hugo@... carfax.org.uk |
http://carfax.org.uk/  |
PGP: E2AB1DE4          |

--eu12+zRL7gQwOC+E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJc48JxAAoJEFheFHXiqx3kxtYQALdihgJ9EwxGzKbjgQn1qcAA
PNTKM2tK/2W7MJV1nxblIbYVOdKyW1ecQ/UrchGEXTDK0Vu53CHxcsjDlGnJ9nA2
mn9tBBG73Ac3nP7c8PMetEWzypyQchbyiDCqjH+VobfzjWSFLXi9xlG6RCqpr6yo
EZqzHmeDdMvmhaFt8C7kyle3pAhgnGrF+9YiGaxs5QcrIRIx2vBk3e977rQH4Lzq
oZ3zLaKj/rvKkl97XsRxrfuiN30Y3rcGJtCZ0bCZw5ncRWLatKlcNHMvJuxgV18M
WMPCZhBI3xxFmPYj9immJ4Qx5ZW62FMSLdMyiH2yWbVNNUeG+m63BH/54ni4HYoG
LQRzFIeZdN0ocMOXpVVxjCrm3pul3SxdmMfi5lvZOOVFRweOY/rpXTztsAp37kAY
kUTLyMe7z7XKIewTHEFSfl2H5WCe7RF/TjjRy8aX1kRENInuUn54FUHbkbSbeU+F
YZ+Otua5NOKPhGDwWNwCJU4nAa9SpvUWMfTksP8dT0adIJzxFaMAryXbMs5nt5ev
ZAubOZRej1UpT5xT90y2LPshxyQHt/jE35ePgE/s1Qb7ma2hXLh9fYvM/rr0+bw4
HxBZ5myeVXbKkD+YPJM7GmY+HRWdPUCkHjGrt9X9ipj6nIpa4FaurOfA/1LlX47a
vi3MBhkA2DFUNMtNtk0o
=pRzC
-----END PGP SIGNATURE-----

--eu12+zRL7gQwOC+E--
