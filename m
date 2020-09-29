Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 919AE27D147
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Sep 2020 16:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729978AbgI2Oe5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Sep 2020 10:34:57 -0400
Received: from ns13.heimat.it ([46.4.214.66]:60092 "EHLO ns13.heimat.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729299AbgI2Oe4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Sep 2020 10:34:56 -0400
X-Greylist: delayed 580 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Sep 2020 10:34:55 EDT
Received: from localhost (ip6-localhost [127.0.0.1])
        by ns13.heimat.it (Postfix) with ESMTP id 32B143021BA
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Sep 2020 14:25:14 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at ns13.heimat.it
Received: from ns13.heimat.it ([127.0.0.1])
        by localhost (ns13.heimat.it [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id czCBeFxyMnkM for <linux-btrfs@vger.kernel.org>;
        Tue, 29 Sep 2020 14:25:12 +0000 (UTC)
Received: from bourrache.mug.xelera.it (unknown [93.56.169.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by ns13.heimat.it (Postfix) with ESMTPSA id AACDD3021B9
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Sep 2020 14:25:12 +0000 (UTC)
Received: from roquette.mug.biscuolo.net (roquette [10.38.2.14])
        by bourrache.mug.xelera.it (Postfix) with SMTP id 75A5B75FECE
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Sep 2020 16:25:09 +0200 (CEST)
Received: (nullmailer pid 14374 invoked by uid 1000);
        Tue, 29 Sep 2020 14:25:07 -0000
From:   Giovanni Biscuolo <g@xelera.eu>
To:     linux-btrfs@vger.kernel.org
Subject: how to recover from "enospc errors during balance"
Organization: Xelera.eu
Date:   Tue, 29 Sep 2020 16:25:06 +0200
Message-ID: <87r1qk4q4d.fsf@roquette.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hello,

please also reply to me since I'm not subscribed to linux-btrfs, thanks!

My BTRFS filesystem is full, I got ENOSPC during a (scheduled) balance:

=2D-8<---------------cut here---------------start------------->8---

[6928066.755704] BTRFS info (device sda3): balance: start -dusage=3D50 -mus=
age=3D70 -susage=3D70
[6928066.760485] BTRFS info (device sda3): relocating block group 139449073=
664 flags metadata|raid1
[6928075.142462] BTRFS: error (device sda3) in btrfs_drop_snapshot:5421: er=
rno=3D-28 No space left
[6928075.146566] BTRFS info (device sda3): forced readonly
[6928075.150851] BTRFS info (device sda3): 2 enospc errors during balance
[6928075.155422] BTRFS info (device sda3): balance: ended with status: -30
[6928083.483820] BTRFS info (device sda3): delayed_refs has NO entry

=2D-8<---------------cut here---------------end--------------->8---

and now it's mounted read-only:

=2D-8<---------------cut here---------------start------------->8---

/dev/sda3 on / type btrfs (ro,relatime,ssd,space_cache,subvolid=3D5,subvol=
=3D/)
/dev/sda3 on /gnu/store type btrfs (ro,relatime,ssd,space_cache,subvolid=3D=
5,subvol=3D/gnu/store)

=2D-8<---------------cut here---------------end--------------->8---

If I try to remount rw (to try to free space) I get:

=2D-8<---------------cut here---------------start------------->8---

[7323937.312122] BTRFS info (device sda3): disk space caching is enabled
[7323937.316478] BTRFS error (device sda3): Remounting read-write after err=
or is not allowed

=2D-8<---------------cut here---------------end--------------->8---

I tried to add a new device (I have 2 spare disks) but it does not work
with a read-only filesystem.

Please how can I remount the filesystem read-write and free some space
deleting some files?

Additional data:

=2D-8<---------------cut here---------------start------------->8---

~$ uname -a
Linux myhost 5.4.50-gnu #1 SMP 1 x86_64 GNU/Linux

~$ btrfs --version
btrfs-progs v5.6

~$ sudo btrfs balance status /
No balance found on '/'

~$ btrfs fi df /
Data, RAID1: total=3D446.50GiB, used=3D446.42GiB
System, RAID1: total=3D32.00MiB, used=3D80.00KiB
Metadata, RAID1: total=3D3.00GiB, used=3D2.11GiB
GlobalReserve, single: total=3D512.00MiB, used=3D5.53MiB

~$ sudo btrfs fi usage /
Overall:
    Device size:                 899.07GiB
    Device allocated:            899.07GiB
    Device unallocated:            2.01MiB
    Device missing:                  0.00B
    Used:                        897.05GiB
    Free (estimated):             85.87MiB      (min: 85.87MiB)
    Data ratio:                       2.00
    Metadata ratio:                   2.00
    Global reserve:              512.00MiB      (used: 5.53MiB)

Data,RAID1: Size:446.50GiB, Used:446.42GiB (99.98%)
   /dev/sda3     446.50GiB
   /dev/sdb3     446.50GiB

Metadata,RAID1: Size:3.00GiB, Used:2.11GiB (70.22%)
   /dev/sda3       3.00GiB
   /dev/sdb3       3.00GiB

System,RAID1: Size:32.00MiB, Used:80.00KiB (0.24%)
   /dev/sda3      32.00MiB
   /dev/sdb3      32.00MiB

Unallocated:
   /dev/sda3       1.00MiB
   /dev/sdb3       1.00MiB

~$ sudo btrfs device stats /
[/dev/sda3].write_io_errs    0
[/dev/sda3].read_io_errs     0
[/dev/sda3].flush_io_errs    0
[/dev/sda3].corruption_errs  0
[/dev/sda3].generation_errs  0
[/dev/sdb3].write_io_errs    0
[/dev/sdb3].read_io_errs     0
[/dev/sdb3].flush_io_errs    0
[/dev/sdb3].corruption_errs  0
[/dev/sdb3].generation_errs  0

=2D-8<---------------cut here---------------end--------------->8---

Thank you for any useful hint!
Best regards, Giovanni

=2D-=20
Giovanni Biscuolo

Xelera IT Infrastructures

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEERcxjuFJYydVfNLI5030Op87MORIFAl9zQ8IACgkQ030Op87M
ORJIyBAA01rMVaiDxV7mKgfL3o6bEfOOTQGTeDxgWkDfeG5BPy7BdDKDGzL09Aiq
D0WWalZBVtwJQ7EUzopvWPI0IVuNugVNAd68kVAVr8PE/ggQOiefbOPQ2gKv5OnC
zXyJ4fi3Gu6qgKe9ZhkRAoIIXhPE/wmwEFc1q9v4lhiJE7+vzTjuKlRoSI50JaSI
chOx47fR+m4n0rjXS6erQ7BPltLbQw5VauRS1dvT0Az3A4GCGdJetG5I2MVyeMSc
uOHVQve/VHelz1KpvOSEK1NX5F3rzK70EMUdwmSVEUut1nHSNPgVLQ9Vd8Hy2TEK
aY+4g9IKQ7pudDdx7EJQqY70fnzyPsIyCiEd/S1H1NO837nJbCIZAnrc7PQLB/OH
7C606zVxvDmpOensO6FjXthxbD++JW1ke326FyT9vlJxja6e6WzP5xZEKaf3Hlg5
Sjb0X7t5+5iQKOaHkEUX84+Mn6v4UH6E2mDFNhDD5ZplQZ/sJgdBOYPeRQvsZstc
Zv5ELetximKFo/CQ92Rk4v7QU57B+t/jL5et8FaIdh0DszrQ9qaSAd4nyVZOEx/8
arBhinYbWD0rm5pnKzsd0Z2TVBizYN6uYFOtqe06zQ40Y2lutze6F9Ha8SPo96y8
pBcHTzBHSzg7GZRIODsZftG4DOsWjp9ZBG6Whke5z/WEmIae6IA=
=KCrL
-----END PGP SIGNATURE-----
--=-=-=--
