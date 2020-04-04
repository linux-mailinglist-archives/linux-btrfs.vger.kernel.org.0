Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 367BC19E7B3
	for <lists+linux-btrfs@lfdr.de>; Sat,  4 Apr 2020 23:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgDDVPr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 4 Apr 2020 17:15:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:49836 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726388AbgDDVPr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 4 Apr 2020 17:15:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E4A69AB5C;
        Sat,  4 Apr 2020 21:15:44 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Andrea Gelmini <andrea.gelmini@gmail.com>
Date:   Sun, 05 Apr 2020 07:15:38 +1000
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, fdmanana@gmail.com,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: RAID5/6 permanent corruption of metadata and data extents
In-Reply-To: <20200404145846.GK13306@hungrycats.org>
References: <CAL3q7H4oa70DUhOFE7kot62KjxcbvvZKxu62VfLpAcmgsinBFw@mail.gmail.com> <7b4f5744-0e22-3691-6470-b35908ab2c2c@gmx.com> <20200402211415.GH13306@hungrycats.org> <CAK-xaQbbadKhN75FhVeMkfDOBvY0N_=CaUVLs0HxYKyVLFyx4g@mail.gmail.com> <20200404145846.GK13306@hungrycats.org>
Message-ID: <87zhbrvtol.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Sat, Apr 04 2020, Zygo Blaxell wrote:

> mdadm does one thing very well, but only the one thing.  I don't imagine
> Neil would extend mdadm to the point where it can handle handle silent

You are correct, I wouldn't.
md provides a block devices, btrfs provides a filesystem. They are
totally different things.  Saying that btrfs/RAID6 is "better" than
mdadm/raid6 is like saying the ext4 is "better" than a SCSI drive.  It
doesn't really mean anything.

I could argue that calling what btrfs does "RAID6" is misleading and
possibly the cause of confusion.  I think the decision to call what ZFS
does "RAID-Z" was probably a good idea - it is somewhat like RAID, but
on a whole new level.  Maybe the stuff btrfs does could be RAID-B :-)

NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl6I+PoACgkQOeye3VZi
gblMpRAAnORWw2HCOy4ZcfrSOyBEYgLxZQ//bvxE0uDB0xpH9Nr80pQqV4rDp6oy
kA6Majv6pSSFaVGbshdSG0bsNKDBzetMP48IYnJdkl1dh6vf7rFsCzRe4/RJBw8D
0+v2unnkCZG+AI1Wu3hRB9J5giNTasD904PriM0L9N5ZI3SErvLWZTvMMYcfG7NK
B/H6ewD74JgiLbTsh18ya/Q1581sijlHRixkBOTX2DVrMY2fUNlALzhmtWjC4P/B
KM/jl8sF+rwx6ypBbDZEwkDmeQMdEBbcYC75gNmnCbsEZKLCj15R/TX07n+oo5kZ
CULessyZKbcRNJeynjQlxIRMbVYO8Wxbjcy0UcGdJwt7rSY1KWSEg0WkZhv2Fb9W
WQgpQFLUBA8pMDeNLaHIgvdwjw3TA5JxlyBE5WP42Nqsyv2hRaJNr+LYRll33wZS
bjzhPl2McsUhV0neUwebjKpZPPyqe2DmVY5udu0n07xRD42374E1D/ke82k0guiB
qTl/lnrcPpao2j4GV0WZSpHKWGnDXEF5nAyno3r5y1npDVTS5d0KNGXdMXyBEURG
Umt5Pcwf6JP15TWmwMbvqckxXQptyjmnS1fryx81fj1FQWsf6ubeS2yWKXGUFgcT
eKQbSNcvnInlVYltmRw473SxxJ2LVd+t3HQ3k7AJzZRepFgrptk=
=GWVy
-----END PGP SIGNATURE-----
--=-=-=--
