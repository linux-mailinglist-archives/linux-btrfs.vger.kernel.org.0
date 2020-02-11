Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6E561591AC
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Feb 2020 15:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729913AbgBKORJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Feb 2020 09:17:09 -0500
Received: from mout.gmx.net ([212.227.15.15]:57355 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729894AbgBKORJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Feb 2020 09:17:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1581430628;
        bh=Kfsu1Ry2ZOGm7olD4s5Rf+J8qbeQ5jrK+t8ZBG76rpM=;
        h=X-UI-Sender-Class:To:From:Subject:Date;
        b=dls63aN+PyVntGKE7JhQQHupaWF8TtT5Jyw7E4hesXS1YaO3xP3Q6Z2gIimEarOZR
         B2vehzSXSWURcTJYICVURo4Rx9UNobTjZvE+c37BrH4tDfl1Yz+ht1e7EHeiOXK2Tb
         V/B5dKps7lP3incjvbOkrfNNbp8ra1Dw0O+oT5m4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.19.20] ([77.191.244.223]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MNKhs-1iq1sc00Hy-00OpLV for
 <linux-btrfs@vger.kernel.org>; Tue, 11 Feb 2020 15:17:08 +0100
To:     linux-btrfs@vger.kernel.org
From:   telsch <telsch@gmx.de>
Subject: tree-checker read time corruption
Message-ID: <5b974158-4691-c33e-71a7-1e5417eb258a@gmx.de>
Date:   Tue, 11 Feb 2020 15:17:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aoLZoBYnH+lGe56MYZXG7sMay0+BqsOuLpNFZn3dusdbSl4Thcu
 lYXpbwa43MhkIIKGLeVSAzv6oHJb1OvQOiDCISNTfxFlPQdOSBfep5VTJdr83NrTSI+DHWd
 ptqKP8F/4Hqoj+my7k6wSu1DtU7Bj3OKK3FhjBcewbeIwOYOjer8keH14Hej5Xp/AYct6mX
 chN56dltrcdPHRzH+JSlw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:DMr00veyGzY=:9l3cTz2lef6wrLMAV/QnuZ
 cutiHjgd8rU55euccfEeV/ui8+xY4tbP8UlJy9EMBeJ++0U/SbNXiCbgNJrQMqGhUcb2gda0J
 8GCgTGqbuchNTbN1fCZa1LCIARt+U2cpQ0RD03djOdhR7Z7aUI7Dom0yRStg62HG+k0Tzs/S+
 kNBUUx5e6PO6HFb4danc05UT1naTHZK06FGfqh4gnOEdE9n4UGNUXRk+4h98dWUZQ3JjK4NNJ
 kPbTE6ji9/bIzIXzQpCORxmTYzY5WqWnpuv7nyx3K9xsezr3y6468HqfLRwj75P+03AhdCUiP
 iShhck6HcWzcBMXvrJAnTDg+OgD2x45jqt3JTgf+efSxMowwpHZQcHP3zYQ4cXOeziPtVmJDi
 +Bx+2iQHV6RlCF1ihQcNBpNjnwJe+kLCnLMZYt7zcwwxxCx1oOLX6WY1WX9Mq5mCgj8AmRKXm
 +jqwldDmyFLGcbX2eNSYcntC/s5SXbOeuviCfsCEu6QGHwfOeWru9hh7esThs+PW1HbxxIIWb
 4yNQ94/H7B0CXiufXxvSSWBp7fPvUTFY7fb/RZRiu6Izi3CxQ7Vvicha9QyTTdoK6kIJUVK6B
 9w5SiRPiUKKmuXmqtYEqC1R0nXtW5m3zFkHCkTBQ77wT/bHPpKBRz8kYt5PNde5OAx5dU+Wzv
 EAsR3rIcNOc6fHU+XMsjakBXfqJBe5x0zkLc7oaIqoWFh+zRK3YD4uWuMdPL09qKXbd6GP0GN
 QsKKeBmEkw+saCl2thbro0Hn8Ogm6cD/sLKZ1CPisAphQPzNwAu70pF8U1s0AhY1Uqznahoqr
 ZXiW6qVa6T/G9tPt0iRWDatsyi0YzRC/WAqF8iDsUpHNZnJuy2KDjHgKRt5AuElgdOmQpmdf4
 H8qu/RhVm4uKHKmc8LGThiH4jX2ZfmMxHNLhfAcCWSCAf4tNpY/idgGMahN6EKGCEu8y5tHoJ
 0Tq6wIiyvw5eJSak946xNKcdwxLm/ZXnHtVQB9y2am4GkbtVRT9h6PSoHQGopspfklQc97JMp
 C9lYe7dCcKwGoJaCq1y6nMQyW3/MaLOk2Q61Y/1jS+KD050aNn7HgM7IaAk6C0igUXWHM9MaJ
 yfmpLxTJS76BY/se2Asjwh+Ef0g02zgiVsVGEbCLpECdOeqGX4VHOnnOHcJxioPswJNseC1oS
 44pwSiDVUVM8skQFqy8EFNGy8OeCeGVK/Ia0K68zOFJHz1Phi2xZl9RBBL5+lH4U7hdxxiyYQ
 kfU2jmL+1LBNR7K6I
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Dear devs,



after upgrading from kernel 4.19.101 to 5.5.2 i got read time tree block
error as

described here:

     https://btrfs.wiki.kernel.org/index.php/Tree-checker#For_end_users



Working with kernel 4.19.101:



Linux Arch 4.19.101-1-lts #1 SMP Sat, 01 Feb 2020 16:35:36 +0000 x86_64
GNU/Linux



btrfs --version

btrfs-progs v5.4



btrfs fi show

Label: none  uuid: 56e753f4-1346-49ad-a34f-e93a0235b82a

         Total devices 1 FS bytes used 92.54GiB

         devid    1 size 95.14GiB used 95.14GiB path /dev/mapper/home



btrfs fi df /home

Data, single: total=3D94.11GiB, used=3D91.95GiB

System, single: total=3D31.00MiB, used=3D12.00KiB

Metadata, single: total=3D1.00GiB, used=3D599.74MiB

GlobalReserve, single: total=3D199.32MiB, used=3D0.00B



After upgrading to kernel 5.5.2:



[   13.413025] BTRFS: device fsid 56e753f4-1346-49ad-a34f-e93a0235b82a
devid 1 transid 468295 /dev/dm-1 scanned by systemd-udevd (417)

[   13.589952] BTRFS info (device dm-1): force zstd compression, level 3

[   13.589956] BTRFS info (device dm-1): disk space caching is enabled

[   13.594707] BTRFS info (device dm-1): bdev /dev/mapper/home errs: wr
0, rd 47, flush 0, corrupt 0, gen 0

[   13.622912] BTRFS info (device dm-1): enabling ssd optimizations

[   13.624300] BTRFS critical (device dm-1): corrupt leaf: root=3D5
block=3D122395779072 slot=3D10 ino=3D265, invalid inode generation: has
18446744073709551492 expect [0, 468296]

[   13.624381] BTRFS error (device dm-1): block=3D122395779072 read time
tree block corruption detected





Booting from 4.19 kernel can mount fs again.
