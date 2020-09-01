Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC450259015
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Sep 2020 16:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbgIAOP6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Sep 2020 10:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbgIAOPm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Sep 2020 10:15:42 -0400
X-Greylist: delayed 540 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 01 Sep 2020 07:15:42 PDT
Received: from anderith.bouah.net (anderith.bouah.net [IPv6:2001:19f0:7000:8b29:5400:ff:fe05:5e62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F228C06125C
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Sep 2020 07:15:42 -0700 (PDT)
Date:   Tue, 1 Sep 2020 16:06:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=bouah.net; s=anderith;
        t=1598969201; bh=ud6KIF8SVK3ZB710jRTtvgF2LpacpF/x6duI4v107bw=;
        h=Date:From:To:Subject;
        b=ROoV5G9er6jSTHAOXMXqqSTBtGI5ZBM8l/PRiotey4OvNvYoU7Yzw3F8AhRR4AKSW
         HBFGxlMgbJzyT07YlqOx0mUFXcusbOpd05qfn+dc7gr7iYGUj0AlRIn7qYQwqxdh9g
         CT46WoQJ40b7qD+sbqUln1pF+129zJ0qGH9R7yUI=
From:   Maxime Buquet <pep@bouah.net>
To:     linux-btrfs@vger.kernel.org
Subject: "bad tree block" on Linux 5.8.5
Message-ID: <20200901140634.GA774@caska>
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline
X-PGP-Key: https://bouah.net/0x840FD3DCCA998D434FD2155DDEDA74AEECA9D0F2.asc.pub
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi there,

I'm having bad tree block issues on Linux 5.8.5 since yesterday. I'm not
entirely sure how it happened. Any help is appreciated to try and debug.

Thanks!


Here are some logs:


# uname -a
Linux caska 5.8.5-arch1-1 #1 SMP PREEMPT Thu, 27 Aug 2020 18:53:02 +0000 x8=
6_64 GNU/Linux

# btrfs --version
btrfs-progs v5.7

# cat /dev/kmsg
[..]
 SUBSYSTEM=3Dhid
 DEVICE=3D+hid:0003:1395:0048.0001
6,1212,55540469834,-;usb 2-1: USB disconnect, device number 5
 SUBSYSTEM=3Dusb
 DEVICE=3Dc189:132
6,1213,55546529788,-;usb 2-1: new SuperSpeed Gen 1 USB device number 6 usin=
g xhci_hcd
 SUBSYSTEM=3Dusb
 DEVICE=3D+usb:2-1
6,1214,55546547041,-;usb 2-1: New USB device found, idVendor=3D1058, idProd=
uct=3D25a1, bcdDevice=3D10.14
 SUBSYSTEM=3Dusb
 DEVICE=3Dc189:133
6,1215,55546547043,-;usb 2-1: New USB device strings: Mfr=3D2, Product=3D3,=
 SerialNumber=3D1
 SUBSYSTEM=3Dusb
 DEVICE=3Dc189:133
6,1216,55546547044,-;usb 2-1: Product: Elements 25A1
 SUBSYSTEM=3Dusb
 DEVICE=3Dc189:133
6,1217,55546547045,-;usb 2-1: Manufacturer: Western Digital
 SUBSYSTEM=3Dusb
 DEVICE=3Dc189:133
6,1218,55546547046,-;usb 2-1: SerialNumber: 575853314543374658314C38
 SUBSYSTEM=3Dusb
 DEVICE=3Dc189:133
6,1219,55546548366,-;usb-storage 2-1:1.0: USB Mass Storage device detected
 SUBSYSTEM=3Dusb
 DEVICE=3D+usb:2-1:1.0
6,1220,55546548538,-;scsi host3: usb-storage 2-1:1.0
 SUBSYSTEM=3Dscsi
 DEVICE=3D+scsi:host3
5,1221,55547557024,-;scsi 3:0:0:0: Direct-Access     WD       Elements 25A1=
    1014 PQ: 0 ANSI: 6
 SUBSYSTEM=3Dscsi
 DEVICE=3D+scsi:3:0:0:0
5,1222,55547557710,-;sd 3:0:0:0: Attached scsi generic sg1 type 0
 SUBSYSTEM=3Dscsi
 DEVICE=3D+scsi:3:0:0:0
5,1223,55547558772,-;sd 3:0:0:0: [sdb] Spinning up disk...
 SUBSYSTEM=3Dscsi
 DEVICE=3D+scsi:3:0:0:0
4,1224,55548569673,c;....ready
5,1225,55551610584,-;sd 3:0:0:0: [sdb] Very big device. Trying to use READ =
CAPACITY(16).
 SUBSYSTEM=3Dscsi
 DEVICE=3D+scsi:3:0:0:0
5,1226,55551610752,-;sd 3:0:0:0: [sdb] 7813969920 512-byte logical blocks: =
(4.00 TB/3.64 TiB)
 SUBSYSTEM=3Dscsi
 DEVICE=3D+scsi:3:0:0:0
5,1227,55551610756,-;sd 3:0:0:0: [sdb] 4096-byte physical blocks
 SUBSYSTEM=3Dscsi
 DEVICE=3D+scsi:3:0:0:0
5,1228,55551610971,-;sd 3:0:0:0: [sdb] Write Protect is off
 SUBSYSTEM=3Dscsi
 DEVICE=3D+scsi:3:0:0:0
7,1229,55551610975,-;sd 3:0:0:0: [sdb] Mode Sense: 47 00 10 08
 SUBSYSTEM=3Dscsi
 DEVICE=3D+scsi:3:0:0:0
3,1230,55551611224,-;sd 3:0:0:0: [sdb] No Caching mode page found
 SUBSYSTEM=3Dscsi
 DEVICE=3D+scsi:3:0:0:0
3,1231,55551611232,-;sd 3:0:0:0: [sdb] Assuming drive cache: write through
 SUBSYSTEM=3Dscsi
 DEVICE=3D+scsi:3:0:0:0
6,1232,55551829992,-; sdb: sdb1
5,1233,55551831353,-;sd 3:0:0:0: [sdb] Attached SCSI disk
 SUBSYSTEM=3Dscsi
 DEVICE=3D+scsi:3:0:0:0


# cryptsetup open --type=3Dluks /dev/sdb1 data
Enter passphrase for /dev/sdb1:

# mount -t btrfs -o rw,subvol=3D/data /dev/mapper/data /data
mount: /data: wrong fs type, bad option, bad superblock on /dev/mapper/data=
, missing codepage or helper program, or other error.

# file -s /dev/mapper/data
/dev/mapper/data: symbolic link to ../dm-1
# file -s /dev/dm-1
/dev/dm-1: BTRFS Filesystem sectorsize 4096, nodesize 16384, leafsize 16384=
, UUID=3Ddd439261-afed-4c9e-8685-07d46e46e917, 3829686697984/4000749432832 =
bytes used, 1 devices

# btrfs fi show
Label: none  uuid: dd439261-afed-4c9e-8685-07d46e46e917
        Total devices 1 FS bytes used 3.48TiB
        devid    1 size 3.64TiB used 3.49TiB path /dev/mapper/data

# btrfs check --readonly /dev/mapper/data
Opening filesystem to check...
checksum verify failed on 3972119019520 found 000000FC wanted FFFFFFEE
checksum verify failed on 3972119019520 found 00000001 wanted 00000055
checksum verify failed on 3972119019520 found 00000001 wanted 00000055
bad tree block 3972119019520, bytenr mismatch, want=3D3972119019520, have=
=3D5982236876204203511
Couldn't read tree root
ERROR: cannot open file system

# btrfs rescue chunk-recover /dev/mapper/data
Scanning: DONE in dev0
No valid btrfs found
open with broken chunk error
Chunk tree recovery failed
btrfs rescue chunk-recover /dev/mapper/data  428.09s user 3162.61s system 9=
% cpu 10:28:53.27 total

--=20
Maxime =E2=80=9Cpep=E2=80=9D Buquet

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEhA/T3MqZjUNP0hVd3tp0ruyp0PIFAl9OVWYACgkQ3tp0ruyp
0PJ6tRAAgKfgVmzjENnr26+1jTneUnITAWxLj47ouCsyc+3bwDxrjBNlE0jSR1C4
Q8iwRO7AGMXtyzDAOumsVT+xV21u91d78izwHMaEiA8Jwmx8E9kvhR1wj/nJRzQi
SfyXuAPVK3Fo8trJEwcOCOqMitHBv9wFMl1sZ48nzpm8omioWUbLq76gHZ1/Akfy
hqH02TyfdIHJy9HZbhwHWdJaoTG5HfC7g7Ias8fHQmJsaPLYQ4Ut5i3AoIOeeZj6
814mqMW42K0ydLYTnwYOnqw2Jj/uKdpuHZdWKRka+lGoJ9m4CzTddG4EK+XaHcjs
u8cYP3+bhSyxZerQ+iEbJIDMg9TxyG7WhmThyAW7tIDEQWgiertWJOg/uiUtouEu
8DIJYAhyEncybLGbUv0KnoIAEuhLOjvXOgNAXyHSrT3FSMSGnSp8nONupN9Y1vj3
FZKCN3lKjqPCLNevnwndDnB311K8leCXtMYuvpBFsLlr/6AVQqP8CHKiu7g9POyS
nrenCWFvi07m0VvxOltkCjXfANxH5qFdkJTnoxPHXD2hwCv6B/h//VgJlxWOxqTp
Cnf40m8UOxArk+Ufmeime2zm1+mY+4rdNRpl3u4C1kYDKTwUNDASBBK/TuuKdoIO
gTEGlnJR/FV1AwGT/wJD9Sg1fksJcxrOCDMd/q83/QMYfiAOZ/M=
=Hedm
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--
