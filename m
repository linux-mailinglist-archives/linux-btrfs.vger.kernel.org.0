Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDCE10AC1E
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Nov 2019 09:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbfK0Iok (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Nov 2019 03:44:40 -0500
Received: from mira.cbaines.net ([212.71.252.8]:49072 "EHLO mira.cbaines.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726143AbfK0Iok (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Nov 2019 03:44:40 -0500
X-Greylist: delayed 462 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Nov 2019 03:44:38 EST
Received: from localhost (cpc102582-walt20-2-0-cust14.13-2.cable.virginm.net [86.27.34.15])
        by mira.cbaines.net (Postfix) with ESMTPSA id 08D93177D8
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Nov 2019 08:36:55 +0000 (GMT)
Received: from capella (localhost [127.0.0.1])
        by localhost (OpenSMTPD) with ESMTP id 1441430a
        for <linux-btrfs@vger.kernel.org>;
        Wed, 27 Nov 2019 08:36:54 +0000 (UTC)
User-agent: mu4e 1.2.0; emacs 26.3
From:   Christopher Baines <mail@cbaines.net>
To:     linux-btrfs@vger.kernel.org
Subject: Slow performance with Btrfs RAID 10 with a failed disk
Date:   Wed, 27 Nov 2019 08:36:52 +0000
Message-ID: <8736e9g1gb.fsf@cbaines.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--=-=-=
Content-Type: text/plain

Hey,

I'm using RAID 10, and one of the disks has recently failed [1], and I'm
seeing plenty of warning and errors in the dmesg output [2].

What kind of performance should be expected from Btrfs when a disk has
failed? [3] At the moment, the system seems very slow. One contributing
factor may be that all the logging that Btrfs is generating is being
written to the btrfs filesystem that's degraded, probably causing more
log messages to be produced.

I guess that replacing the failed disk is the long term solution to get
the filesystem back in to proper operation, but is there anything else
that can be done to get it back operating until then?

Also, is there anything that can stop btrfs logging so much about the
failures, now that I know that a disk has failed?

Thanks,

Chris


1:
Nov 26 19:20:56 localhost vmunix: [5117520.484302] sd 0:1:0:5: [sdf] Unaligned partial completion (resid=52, sector_sz=512)
Nov 26 19:20:56 localhost vmunix: [5117520.525506] sd 0:1:0:5: [sdf] tag#360 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
Nov 26 19:20:56 localhost vmunix: [5117520.525525] sd 0:1:0:5: [sdf] Unaligned partial completion (resid=24384, sector_sz=512)
Nov 26 19:20:56 localhost vmunix: [5117520.566649] sd 0:1:0:5: [sdf] tag#360 Sense Key : Hardware Error [current]
Nov 26 19:20:57 localhost vmunix: [5117520.597829] sd 0:1:0:5: [sdf] tag#363 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
Nov 26 19:20:57 localhost vmunix: [5117520.637610] sd 0:1:0:5: [sdf] tag#360 Add. Sense: Logical unit failure
Nov 26 19:20:57 localhost vmunix: [5117520.668134] sd 0:1:0:5: [sdf] tag#363 Sense Key : Hardware Error [current]
Nov 26 19:20:57 localhost vmunix: [5117520.668136] sd 0:1:0:5: [sdf] tag#363 Add. Sense: Logical unit failure
Nov 26 19:20:58 localhost vmunix: [5117520.707347] sd 0:1:0:5: [sdf] tag#360 CDB: Write(10) 2a 00 46 86 12 00 00 00 80 00
Nov 26 19:20:58 localhost vmunix: [5117520.736962] sd 0:1:0:5: [sdf] tag#363 CDB: Write(10) 2a 00 47 1e 0e 00 00 02 00 00
Nov 26 19:20:58 localhost vmunix: [5117520.774569] print_req_error: critical target error, dev sdf, sector 1183191552 flags 100001
Nov 26 19:20:59 localhost vmunix: [5117520.774573] BTRFS error (device sda3): bdev /dev/sdf errs: wr 2, rd 0, flush 0, corrupt 0, gen 0
Nov 26 19:20:59 localhost vmunix: [5117520.803740] print_req_error: critical target error, dev sdf, sector 1193152000 flags 4001
Nov 26 19:20:59 localhost vmunix: [5117520.803746] BTRFS error (device sda3): bdev /dev/sdf errs: wr 3, rd 0, flush 0, corrupt 0, gen 0
Nov 26 19:20:59 localhost vmunix: [5117520.840559] sd 0:1:0:5: [sdf] Unaligned partial completion (resid=52, sector_sz=512)
Nov 26 19:20:59 localhost vmunix: [5117520.868966] BTRFS error (device sda3): bdev /dev/sdf errs: wr 4, rd 0, flush 0, corrupt 0, gen 0
Nov 26 19:21:00 localhost vmunix: [5117520.869037] sd 0:1:0:5: [sdf] Unaligned partial completion (resid=52, sector_sz=512)
Nov 26 19:21:00 localhost vmunix: [5117520.869042] sd 0:1:0:5: [sdf] tag#385 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE

2:
[5168107.359619] BTRFS error (device sda3): error writing primary super block to device 6
[5168107.932712] BTRFS warning (device sda3): lost page write due to IO error on /dev/sdf
[5168108.091827] BTRFS error (device sda3): error writing primary super block to device 6
[5168108.155217] BTRFS warning (device sda3): lost page write due to IO error on /dev/sdf
[5168108.288296] BTRFS error (device sda3): error writing primary super block to device 6
[5168108.972431] BTRFS warning (device sda3): lost page write due to IO error on /dev/sdf
[5168109.204083] BTRFS error (device sda3): error writing primary super block to device 6
[5168109.595413] btrfs_dev_stat_print_on_error: 296 callbacks suppressed
[5168109.595422] BTRFS error (device sda3): bdev /dev/sdf errs: wr 5071725, rd 408586, flush 0, corrupt 0, gen 0
[5168109.639670] BTRFS error (device sda3): bdev /dev/sdf errs: wr 5071726, rd 408586, flush 0, corrupt 0, gen 0
[5168109.664981] BTRFS error (device sda3): bdev /dev/sdf errs: wr 5071727, rd 408586, flush 0, corrupt 0, gen 0
[5168109.689197] BTRFS error (device sda3): bdev /dev/sdf errs: wr 5071728, rd 408586, flush 0, corrupt 0, gen 0
[5168109.728189] BTRFS error (device sda3): bdev /dev/sdf errs: wr 5071729, rd 408586, flush 0, corrupt 0, gen 0
[5168109.744894] BTRFS error (device sda3): bdev /dev/sdf errs: wr 5071730, rd 408586, flush 0, corrupt 0, gen 0
[5168109.755457] BTRFS error (device sda3): bdev /dev/sdf errs: wr 5071731, rd 408586, flush 0, corrupt 0, gen 0
[5168109.831763] BTRFS warning (device sda3): lost page write due to IO error on /dev/sdf
[5168109.848128] BTRFS error (device sda3): bdev /dev/sdf errs: wr 5071732, rd 408586, flush 0, corrupt 0, gen 0
[5168109.849445] BTRFS error (device sda3): bdev /dev/sdf errs: wr 5071733, rd 408586, flush 0, corrupt 0, gen 0
[5168109.917277] BTRFS error (device sda3): error writing primary super block to device 6
[5168109.941132] BTRFS error (device sda3): bdev /dev/sdf errs: wr 5071734, rd 408586, flush 0, corrupt 0, gen 0
[5168110.009785] BTRFS warning (device sda3): lost page write due to IO error on /dev/sdf

3:
Label: none  uuid: 620115c7-89c7-4d79-a0bb-4957057d9991
	Total devices 6 FS bytes used 1.08TiB
	devid    1 size 72.70GiB used 72.70GiB path /dev/sda3
	devid    2 size 72.70GiB used 72.70GiB path /dev/sdb3
	devid    3 size 931.48GiB used 555.73GiB path /dev/sdc
	devid    4 size 931.48GiB used 555.73GiB path /dev/sdd
	devid    5 size 931.48GiB used 555.73GiB path /dev/sde
	*** Some devices missing

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQKTBAEBCgB9FiEEPonu50WOcg2XVOCyXiijOwuE9XcFAl3eNaRfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldDNF
ODlFRUU3NDU4RTcyMEQ5NzU0RTBCMjVFMjhBMzNCMEI4NEY1NzcACgkQXiijOwuE
9XcBOBAAnwZFDetYj1Y9QCr/GNQ8791obgZx2/HrkBLWQlOFolSqH4zsDoNdMeTN
VmbQ3RSH44vjMBZVrfKFjovKxR9r2jYIaFJS3ROIfdEhtMJOQ8b+WAOspg+WSbiJ
7COCYh+ZJCvJEYdOv1Kwt4aW6YwweTixL4lhUHNpDE8zKwrPc6UE7XUyOgjCDn4n
NzSxsKKfqZRGwaOofzqV+vAZBk5T/0HT/2Ho+x32cKaJQN/bL5tz3+o67U0RWnkn
bFX1JBLH7cEZbLT4Ob3iRE7jc6zrUeFmX/e+cF7O+MVf3XbVW1wiCRQorshlShAl
KSBpI0/fkwBBwLIlJhySW1SRcbFa2SyyNPVfjF2EOB+nRRgD+cV5O6dBrtHo4ThV
ds/24FbMHhbGsH0sFKBikpXQod6pGxd45szhczjw3awZYnYKktopDPeaHaU4igty
Ejgvt4hgP9z/3aps3wDANCti0b4tfOp/7u2zr93w342D1dLcJLWkw5f90CVDrTBg
L/T5T09EkPmFWuQDbzTo3GuuP4xBSkoTyFOWzFlaLmWPOlgruYbt332guFYT+Xie
qbOYSrz/7Z+/0qFlrkVwobGKbySggFOxyWzD7U4QSDphiHg9jnByfCl3tI5nRZ35
BD87Z+39qxdDnspxw6wctohyPuq1ucXNrlRYC8jv7Pfg+J1L//M=
=yWm+
-----END PGP SIGNATURE-----
--=-=-=--
