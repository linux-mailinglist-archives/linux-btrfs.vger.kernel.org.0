Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1511282A3C
	for <lists+linux-btrfs@lfdr.de>; Sun,  4 Oct 2020 12:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725854AbgJDKop (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 4 Oct 2020 06:44:45 -0400
Received: from mout.gmx.net ([212.227.17.22]:45025 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725825AbgJDKop (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 4 Oct 2020 06:44:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1601808282;
        bh=++b1AYS2h10UPRYr7P0wdvF0svYSA4NPdgzNO50/S0c=;
        h=X-UI-Sender-Class:From:To:Subject:Date;
        b=HKzaWzVpuoqVPvkq6yz6DI6d5Faibh3+ptxn+KKQiFpY+0WyrfHeHaHAokiVARiNL
         dhvZOPm3jrri7P4R+0ASpyo9sjcHHsSF5z1SC6hrR+LhBOj7m87cC362js74XJ0ZSy
         /raS+zikPynM0MsCqjeZS3LnVy72QTr1ucvEhOT4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [82.171.125.112] ([82.171.125.112]) by web-mail.gmx.net
 (3c-app-mailcom-bs04.server.lan [172.19.170.170]) (via HTTP); Sun, 4 Oct
 2020 12:44:42 +0200
MIME-Version: 1.0
Message-ID: <trinity-8bafe7e4-3944-4586-8ccf-01fca6664979-1601808281835@3c-app-mailcom-bs04>
From:   Pet Eren <peteren@gmx.com>
To:     linux-btrfs@vger.kernel.org
Subject: BTRFS device unmountable after system freeze
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 4 Oct 2020 12:44:42 +0200
Importance: normal
Sensitivity: Normal
Content-Transfer-Encoding: quoted-printable
X-Priority: 3
X-Provags-ID: V03:K1:98yjI5w7/0LJNzH8mDo0X/DHMJcixD5lp3jpE3wS08zSKlWeLSv46Zy6IX2B7H/LRtoyb
 OnTD3uulD1dVOQuPimW+TVqs0xuBu/K1WTUvGeDtz+oRX6GXzc2Yn4qpE8pCqjjS/ofMMyIOz6NV
 PwSGDZnBtyo2uor2QV8gl5QJnlD1pAZR2zcqeykGdRMComNLzB/sPDTDA+2y+xT4uDzd7FhQP/eL
 +T8ZsvjZO3dxvLLqbhRYRD79dyQRgRJyOGJIchRR7u2noIWSxz7WNy6rbnbJOsvIW++yoz3+nV72
 ho=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:A/yvz2k/udQ=:VkvLF06Ui8A1kwSjsdLnoI
 QUi5Ey4a653SNVHOsrjkH2gDRMUwBn8NSI4+Hp4n1+Ep6KOk1X1np6aSmFzH7vdsbsTNlNIwD
 ie5bymFwDWUn47stBrJ49eF1xA6Qg6A5U9jpzB6eMusR2wu3PsmwnrUAaQTowafcb0xtNEzlf
 uWlqo5LyUFPN7oRl05RBTl8HKopyqDh5MjukJrY6U1GcTd35Q2mPn6Hs47X+fHZFlF1TqNlok
 09JjOcaV3NM+MA5t+xuF5QiC4G34xqkbvNCsFfJacivRuJ6KqMv85OCCvJ60cRmuB9FAV6T6x
 yOBP30vNqH1ugu5JQWcehNkPpwUWqb+UzkOaEWCucd0js+PzvPspVKukc0EW2zkcvPqJCnlRh
 Npq0oS020J836vX18rk8CqpO4rofCakC/VRZnExwntZdfIGTktP1QspUe3ZWUoQoiN8eHlJq6
 5deJ8dZ17fD30NeZLWwLCdTXOrc/oa5dJTujSNHclotQSta+j6TuZdAPdt3rRP1TBW+R50xQd
 1WlnYObTbGkGSh12xxHrh1BM/vFEa6FvT/i6uyGCW8cCf4RhlaFnR3UbjERs+w4tcyJGPOhfJ
 n3zEpCOzCiCcHJLrgSj8aYHvz7ZFI3N4Q2bYV5v1ZqPzh3A4xmr2vKTxkdS2wUDfcGIEj4NNU
 BHA3x8N7CcfXCCNEtYN+JxcCkQLyZVFIsSVosyYJ9eYh5uBBzP+5AQvPiFC9UaQWGjXk=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi there!
=C2=A0
I have been using BTRFS on an external hdd (WD Elements 8TB, Single mode, =
data, metadata and system in DUP)=2E The device is LUKS encrypted=2E
After my Ubuntu 18=2E04 freezed, I can unlock LUKS, but I am not able to m=
ount the BTRFS filesystem=2E

- uname -a =3D 5=2E8=2E6-1-MANJARO
- btrfs --version =3D btrfs-progs v5=2E7
- btrfs fi show =3D Label: 'Elements'=C2=A0 uuid: 62a62962-2ad6-45db-a3ad-=
77d7f64983e8
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 Total devices 1 FS bytes used 2=2E81TiB
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 1 size 7=2E28TiB used 5=2E77T=
iB path /dev/mapper/elements
- btrfs fi df /home =3D Unfortunatly I am not able to mount de btrfs files=
ystem
- dmesg:
[560852=2E004810] BTRFS info (device dm-4): disk space caching is enabled
[560852=2E004812] BTRFS info (device dm-4): has skinny extents
[560852=2E552878] BTRFS critical (device dm-4): corrupt leaf: block=3D2907=
83232 slot=3D81 extent bytenr=3D2054053203968 len=3D262144 invalid generati=
on, have 878116864 expect (0, 1475717]
[560852=2E552884] BTRFS error (device dm-4): block=3D290783232 read time t=
ree block corruption detected
[560852=2E557557] BTRFS critical (device dm-4): corrupt leaf: block=3D2907=
83232 slot=3D81 extent bytenr=3D2054053203968 len=3D262144 invalid generati=
on, have 878116864 expect (0, 1475717]
[560852=2E557564] BTRFS error (device dm-4): block=3D290783232 read time t=
ree block corruption detected
[560852=2E557605] BTRFS error (device dm-4): failed to read block groups: =
-5
[560852=2E616539] BTRFS error (device dm-4): open_ctree failed
=C2=A0
I also tried to mount the device on another system (where the volume is cr=
eated) with the same results:
- uname -a =3D 4=2E15=2E0-118-generic
- btrfs --version =3D btrfs-progs v4=2E15=2E1=C2=A0
=C2=A0

sudo btrfs check --readonly /dev/mapper/elements=20
Ends like this (with many more "Error: invalid generation for extent" line=
s)
=2E=2E
ERROR: invalid generation for extent 4552998985728, have 15046180803710188=
199 expect (0, 1475717]
ERROR: invalid generation for extent 4555984134144, have 69219449903502607=
20 expect (0, 1475717]
ERROR: invalid generation for extent 4556810252288, have 13383730893851772=
781 expect (0, 1475717]
ERROR: invalid generation for extent 4558174781440, have 86490674675929866=
78 expect (0, 1475717]
ERROR: invalid generation for extent 4558308999168, have 12953021474535714=
951 expect (0, 1475717]
ERROR: errors found in extent allocation tree or chunk allocation
[3/7] checking free space cache
cache and super generation don't match, space cache will be invalidated
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups skipped (not enabled on this FS)
found 3086706528256 bytes used, error(s) found
total csum bytes: 3008753956
total tree bytes: 4968366080
total fs tree bytes: 1722761216
total extent tree bytes: 103022592
btree space waste bytes: 352037386
file data blocks allocated: 3189338202112
 referenced 3189312909312


Do you have any solutions how I can fix this problem?
=C2=A0
Kind regards,
=C2=A0
Peter
=C2=A0
