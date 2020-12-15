Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3A22DB085
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Dec 2020 16:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730500AbgLOPvF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Dec 2020 10:51:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730423AbgLOPu4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Dec 2020 10:50:56 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9D2C06179C
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Dec 2020 07:50:15 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 23so40570344lfg.10
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Dec 2020 07:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=TVI7WqnEK2Ogz4B8KFmtD8ma23a1CFgvmT/e89YsgyU=;
        b=O8o3scTtQJcLJY5CCW0G072f9uqpwduqg12tCbNB+o3V+0/N0GPOLZYm0DTmR1mlnl
         OGdgyuJwH+So4EU9FGM+ZDiC2iAreWiF0li15aifM3/z042XJXRTZvjpJdo/GjOtAV6v
         OTmwYmRQRwOFZS8ksqp+VrMtXXdeUGDgF3MDEiMtrsC388KF2Ze7D61pQwkpHVrl0ZTL
         fcLXssb4VNgj3EcgApo3GDFDTkKrwuI42B924m7rh6pjUkXemzlNBnWRxJGot9nqp4/j
         Hn845kt8QJfC1Li36atldvm9ZIh4dWT6emM75rHk66HLR3EOXoVNWqu2ypRh1jMPzJnv
         XZcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=TVI7WqnEK2Ogz4B8KFmtD8ma23a1CFgvmT/e89YsgyU=;
        b=lRPns0wKQmQe9NaEdPUQch+v4zRXoFhlunnoF9Pyz7wBJYQ2x/Sz4GnsxQkBPFBhOK
         hGwzNe8RA/6TFXrkTC8wroVSZMBPJ9a0XaB2A21SXPBrlQlldtfSQW0cfzSBckMy0NCi
         OQqZthRU1IypGDc0GctaGlrqzzA/DIieo+5PbynjZhM9OydVVsIv0gDYxpejepDvQIav
         1hImiATa43MNgMFRHT0f6uW0Y/Ua2hZ3PqHoe6hjfw+iOdmyjarHoTP36htud/a6WFBO
         HZl5VOlMNXV6Q7sEA4k4ifJDWBT3yOTRM61o3EyUM/8TfVDFh5D81eXqkyTf4ZpkgL0B
         A0MQ==
X-Gm-Message-State: AOAM531ApSaR60WHde3AuraCbRAhmn1Oyo2Ijm52mXDNal5Cdb4tTlwP
        5qBDPik/8EUJMksywl6UpcPZWh2fUaDlgHM2SEq1rWhkeM0=
X-Google-Smtp-Source: ABdhPJyFw6R/nQ/qr7yzqd+tVqjEyQGNCUUiVZct2CRJFgJDdpOkx14JeH0+1h1B9DpivgdFQ7KPXsG+Ys928PA5/jE=
X-Received: by 2002:a2e:90d6:: with SMTP id o22mr13010896ljg.56.1608047412633;
 Tue, 15 Dec 2020 07:50:12 -0800 (PST)
MIME-Version: 1.0
From:   Nathan Dehnel <ncdehnel@gmail.com>
Date:   Tue, 15 Dec 2020 09:50:01 -0600
Message-ID: <CAEEhgEt-_dk2Ff_3LN-hSd_-G+ogpXFD6RKO8KuGgr4T-AOsKA@mail.gmail.com>
Subject: Transient disk loss on bcache btrfs backing volume, 5.4.80-gentoo-r1-x86-64
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Last night 2 drives of my 10-disk btrfs raid10 volume dropped out,
causing it to go read-only. I tried to shut it down with "systemctl
reboot -f", but "BTRFS error (device bcache4):" errors prevented it
from shutting down, so I left it, and this continued all night. This
morning I forced a power cycle, and it booted with / as read-only. All
drives are present after reboot.

This article https://ownyourbits.com/2019/03/03/how-to-recover-a-btrfs-partition/
suggests "btrfs rescue zero-log", but I would just like confirmation
on how to proceed.

uname -a:
Linux gentooserver 5.4.80-gentoo-r1-x86_64 #1 SMP PREEMPT Tue Dec 1
20:03:37 CST 2020 x86_64 Intel(R) Xeon(R) CPU E5-1620 v3 @ 3.50GHz
GenuineIntel GNU/Linux

btrfs --version:
btrfs-progs v5.4.1

btrfs fi show:
Label: none  uuid: 76189222-b60d-4402-a7ff-141f057e8574
Total devices 10 FS bytes used 1.43TiB
devid    1 size 931.51GiB used 293.63GiB path /dev/bcache8
devid    2 size 931.51GiB used 293.63GiB path /dev/bcache1
devid    3 size 931.51GiB used 293.63GiB path /dev/bcache3
devid    4 size 931.51GiB used 293.63GiB path /dev/bcache6
devid    5 size 931.51GiB used 293.63GiB path /dev/bcache4
devid    6 size 931.51GiB used 293.63GiB path /dev/bcache0
devid    7 size 931.51GiB used 293.63GiB path /dev/bcache2
devid    8 size 931.51GiB used 293.63GiB path /dev/bcache9
devid    9 size 931.51GiB used 293.63GiB path /dev/bcache5
devid   10 size 931.51GiB used 293.63GiB path /dev/bcache7

btrfs fi df /:
Data, RAID10: total=1.43TiB, used=1.42TiB
System, RAID10: total=80.00MiB, used=160.00KiB
Metadata, RAID10: total=8.09GiB, used=7.46GiB
GlobalReserve, single: total=512.00MiB, used=0.00B

dmesg:
[   17.532015] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   17.532020] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   17.542260] BTRFS error (device bcache8): parent transid verify
failed on 443344175104 wanted 1256788 found 1248582
[   17.556509] repair_io_failure: 14 callbacks suppressed
[   17.556514] BTRFS info (device bcache8): read error corrected: ino
0 off 443344175104 (dev /dev/bcache7 sector 173174688)
[   17.556596] BTRFS info (device bcache8): read error corrected: ino
0 off 443344179200 (dev /dev/bcache7 sector 173174696)
[   17.556678] BTRFS info (device bcache8): read error corrected: ino
0 off 443344183296 (dev /dev/bcache7 sector 173174704)
[   17.556756] BTRFS info (device bcache8): read error corrected: ino
0 off 443344187392 (dev /dev/bcache7 sector 173174712)
[   17.592141] BTRFS error (device bcache8): parent transid verify
failed on 2848647774208 wanted 1256716 found 1239391
[   17.605902] BTRFS info (device bcache8): read error corrected: ino
0 off 2848647774208 (dev /dev/bcache7 sector 628304320)
[   17.605988] BTRFS info (device bcache8): read error corrected: ino
0 off 2848647778304 (dev /dev/bcache7 sector 628304328)
[   17.606072] BTRFS info (device bcache8): read error corrected: ino
0 off 2848647782400 (dev /dev/bcache7 sector 628304336)
[   17.606152] BTRFS info (device bcache8): read error corrected: ino
0 off 2848647786496 (dev /dev/bcache7 sector 628304344)
[   17.649375] BTRFS error (device bcache8): parent transid verify
failed on 1504325484544 wanted 1256562 found 1248715
[   17.658190] BTRFS info (device bcache8): read error corrected: ino
0 off 1504325484544 (dev /dev/bcache7 sector 543580320)
[   17.658273] BTRFS info (device bcache8): read error corrected: ino
0 off 1504325488640 (dev /dev/bcache7 sector 543580328)
[   17.805656] bond1: (slave eno2): link status up, enabling it in 2000 ms
[   17.805662] bond1: (slave eno2): invalid new link 3 on slave
[   17.882033] BTRFS error (device bcache8): parent transid verify
failed on 2848498352128 wanted 1256715 found 1245300
[   18.170360] BTRFS error (device bcache8): parent transid verify
failed on 2848665780224 wanted 1256716 found 1248523
[   18.354428] BTRFS error (device bcache8): parent transid verify
failed on 443313029120 wanted 1256785 found 1248561
[   18.492300] BTRFS error (device bcache8): parent transid verify
failed on 443310080000 wanted 1256785 found 1248582
[   18.556253] BTRFS error (device bcache8): parent transid verify
failed on 2848762806272 wanted 1256730 found 1248524
[   18.815434] BTRFS error (device bcache8): parent transid verify
failed on 2848508198912 wanted 1256715 found 1248514
[   18.848590] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.848596] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.848599] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.848625] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   18.851343] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.851350] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.851353] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.851362] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   18.851453] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.851456] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.851459] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.851465] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   18.851545] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.851548] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.851551] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.851556] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   18.851656] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.851660] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.851663] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.851670] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   18.851751] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.851754] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.851756] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.851762] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   18.851844] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.851847] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.851852] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.851858] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   18.851934] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.851937] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.851940] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.851947] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   18.852023] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.852025] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.852028] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.852034] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   18.852115] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.852118] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.852120] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.852126] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   18.852202] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.852205] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.852208] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.852213] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   18.852289] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.852292] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.852295] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.852300] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   18.852375] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.852378] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.852381] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.852386] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   18.852463] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.852466] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.852468] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.852473] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   18.852548] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.852550] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.852553] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.852558] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   18.852648] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.852651] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.852654] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.852661] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   18.852736] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.852739] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.852742] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.852747] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   18.852823] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.852825] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.852828] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.852833] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   18.852908] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.852911] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.852914] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.852919] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   18.852994] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.852997] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.852999] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.853005] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   18.853080] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.853082] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.853085] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.853090] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   18.853164] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.853167] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.853170] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.853175] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   18.930514] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.930521] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.930524] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.930532] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   18.944375] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.944381] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.944384] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.944393] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   18.947125] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.947130] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.947133] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.947141] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   18.947435] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.947439] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.947441] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.947449] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   18.950216] BTRFS error (device bcache8): parent transid verify
failed on 2848435421184 wanted 1256715 found 1248513
[   18.950871] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.950875] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.950878] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.950885] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   18.957872] BTRFS error (device bcache8): parent transid verify
failed on 2848424591360 wanted 1256715 found 1248513
[   18.958428] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.958432] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.958434] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.958441] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   18.958513] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.958516] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.958518] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.958524] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   18.959549] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.959554] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.959556] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637368885248 level expected=1 has=0
[   18.959564] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   18.960021] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   18.989903] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   18.990444] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   18.990928] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   18.990993] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   19.017898] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   19.033832] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   19.062675] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   19.062777] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   19.230470] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   19.242323] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   19.245795] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   19.278981] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   19.280602] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   19.289444] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   19.304208] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   19.314047] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   19.335671] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   19.336118] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   19.357451] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   19.357729] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   19.370113] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   19.383421] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   19.397479] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   19.403332] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   19.418243] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   19.418310] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   19.432875] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   19.446724] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   19.449438] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   19.459896] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   19.460289] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   19.475718] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   19.498486] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   19.524145] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   19.527282] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   19.540165] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   19.563131] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   19.568326] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   19.597757] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   19.605749] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   19.614299] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   19.632476] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   19.647125] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   19.665956] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   19.671693] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   19.671920] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   19.678505] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   19.678934] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   19.679158] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   19.705596] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   19.706056] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   19.706351] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   19.706568] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   19.721441] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   19.735565] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   19.748064] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   19.764371] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   19.764826] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   19.769704] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   19.779222] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   19.798216] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   19.798685] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   19.853879] bond1: (slave eno2): link status definitely up, 1000
Mbps full duplex
[   22.161067] btrfs_print_data_csum_error: 23 callbacks suppressed
[   22.218047] 8021q: 802.1Q VLAN Support v1.8
[   22.218058] 8021q: adding VLAN 0 to HW filter on device eno1
[   22.218097] 8021q: adding VLAN 0 to HW filter on device eno2
[   22.218135] 8021q: adding VLAN 0 to HW filter on device bond1
[   22.671274] repair_io_failure: 166 callbacks suppressed
[   22.671278] BTRFS info (device bcache8): read error corrected: ino
34688072 off 0 (dev /dev/bcache9 sector 94931256)
[   22.672609] BTRFS info (device bcache8): read error corrected: ino
34688072 off 4096 (dev /dev/bcache9 sector 94931256)
[   22.672674] BTRFS info (device bcache8): read error corrected: ino
34688072 off 12288 (dev /dev/bcache9 sector 94931256)
[   22.672716] BTRFS info (device bcache8): read error corrected: ino
34688072 off 8192 (dev /dev/bcache9 sector 94931256)
[   22.673008] BTRFS info (device bcache8): read error corrected: ino
34688072 off 24576 (dev /dev/bcache9 sector 94931256)
[   22.673480] BTRFS info (device bcache8): read error corrected: ino
34688072 off 32768 (dev /dev/bcache9 sector 94931256)
[   22.673483] BTRFS info (device bcache8): read error corrected: ino
34688072 off 28672 (dev /dev/bcache9 sector 94931256)
[   22.673499] BTRFS info (device bcache8): read error corrected: ino
34688072 off 16384 (dev /dev/bcache9 sector 94931256)
[   22.673530] BTRFS info (device bcache8): read error corrected: ino
34688072 off 20480 (dev /dev/bcache9 sector 94931256)
[   22.673561] BTRFS info (device bcache8): read error corrected: ino
34688072 off 40960 (dev /dev/bcache9 sector 94931256)
[   22.708041] verify_parent_transid: 25 callbacks suppressed
[   22.708044] btrfs_printk: 1156 callbacks suppressed
[   22.708047] BTRFS error (device bcache8): parent transid verify
failed on 443270463488 wanted 1256786 found 1248570
[   24.221682] BTRFS error (device bcache8): parent transid verify
failed on 443387412480 wanted 1256803 found 1248596
[   24.282529] BTRFS error (device bcache8): parent transid verify
failed on 564363264 wanted 1256759 found 1248541
[   24.285926] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.285930] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.285932] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.285940] btrfs_printk: 333 callbacks suppressed
[   24.285942] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   24.290051] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.290055] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.290057] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.290062] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   24.309786] BTRFS error (device bcache8): parent transid verify
failed on 2637398704128 wanted 1249148 found 1248723
[   24.312928] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.312935] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.312940] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.312954] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   24.313090] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.313094] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.313096] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.313103] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   24.313198] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.313201] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.313204] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.313209] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   24.313290] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.313293] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.313296] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.313301] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   24.313383] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.313386] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.313389] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.313395] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   24.345781] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.345788] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.345791] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.345802] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   24.345899] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.345902] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.345904] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.345909] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   24.345978] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.345981] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.345983] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.345989] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   24.346055] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.346057] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.346059] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.346064] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   24.353831] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.353835] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.353837] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.353843] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   24.353909] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.353911] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.353913] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.353917] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   24.394062] BTRFS error (device bcache8): parent transid verify
failed on 2848462962688 wanted 1256715 found 1248513
[   24.399126] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.399132] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.399135] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.399144] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   24.399501] BTRFS error (device bcache8): parent transid verify
failed on 2637836812288 wanted 1255722 found 1248726
[   24.417035] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.417040] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.417042] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.417049] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   24.427731] BTRFS error (device bcache8): parent transid verify
failed on 2637452460032 wanted 1249148 found 1248723
[   24.469849] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.469856] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.469859] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.469869] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   24.495991] BTRFS error (device bcache8): parent transid verify
failed on 2637453754368 wanted 1249148 found 1248723
[   24.507297] BTRFS error (device bcache8): parent transid verify
failed on 2637821394944 wanted 1255722 found 1246708
[   24.546793] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.546799] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.546802] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.546811] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   24.554624] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.554629] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.554646] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.554654] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   24.571833] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.571836] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.571838] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.571843] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   24.583483] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.583487] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.583489] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.583493] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   24.585839] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.585844] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.585846] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.585854] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   24.586247] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.586249] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.586250] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.586253] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   24.586288] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.586289] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.586290] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.586293] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   24.607439] BTRFS error (device bcache8): parent transid verify
failed on 2637533347840 wanted 1249148 found 1248724
[   24.617006] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.617011] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.617013] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.617022] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   24.617104] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.617107] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.617109] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.617115] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   24.630255] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.630259] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.630261] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.630266] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   24.664003] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.664011] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.664014] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.664025] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   24.664089] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.664092] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.664094] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.664098] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   24.688191] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.688198] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.688202] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.688212] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   24.701711] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.701718] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.701721] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637984235520 level expected=1 has=0
[   24.701728] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   24.729574] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   24.831319] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   24.852198] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   24.862406] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   24.883424] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   24.883486] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   24.883531] BTRFS warning (device bcache8): error accounting new
delayed refs extent (err code: -117), quota inconsistent
[   27.234111] btrfs_print_data_csum_error: 3689 callbacks suppressed
[   27.234116] BTRFS warning (device bcache8): csum failed root 5 ino
35130208 off 69171056640 csum 0xb6ec20bf expected csum 0xf4338fec
mirror 1
[   27.234126] BTRFS warning (device bcache8): csum failed root 5 ino
35130208 off 69171138560 csum 0x23f23a76 expected csum 0xff42b9d2
mirror 1
[   27.234135] BTRFS warning (device bcache8): csum failed root 5 ino
35130208 off 69171027968 csum 0xce9b9ee8 expected csum 0x3e33470d
mirror 1
[   27.234140] BTRFS warning (device bcache8): csum failed root 5 ino
35130208 off 69171093504 csum 0x3c507df7 expected csum 0x1d0f16f7
mirror 1
[   27.234932] BTRFS warning (device bcache8): csum failed root 5 ino
35130208 off 69171027968 csum 0xce9b9ee8 expected csum 0x3e33470d
mirror 1
[   27.235395] BTRFS warning (device bcache8): csum failed root 5 ino
35130208 off 69171093504 csum 0x3c507df7 expected csum 0x1d0f16f7
mirror 1
[   27.235750] BTRFS warning (device bcache8): csum failed root 5 ino
35130208 off 69171027968 csum 0xce9b9ee8 expected csum 0x3e33470d
mirror 1
[   27.236056] BTRFS warning (device bcache8): csum failed root 5 ino
35130208 off 69171093504 csum 0x3c507df7 expected csum 0x1d0f16f7
mirror 1
[   27.236516] BTRFS warning (device bcache8): csum failed root 5 ino
35130208 off 69171027968 csum 0xce9b9ee8 expected csum 0x3e33470d
mirror 1
[   27.236847] BTRFS warning (device bcache8): csum failed root 5 ino
35130208 off 69171093504 csum 0xb6ec20bf expected csum 0xf4338fec
mirror 1
[   27.672409] repair_io_failure: 4320 callbacks suppressed
[   27.672413] BTRFS info (device bcache8): read error corrected: ino
35130208 off 52367360 (dev /dev/bcache9 sector 388766288)
[   27.672778] BTRFS info (device bcache8): read error corrected: ino
35130208 off 52498432 (dev /dev/bcache7 sector 388766256)
[   27.672787] BTRFS info (device bcache8): read error corrected: ino
35130208 off 52363264 (dev /dev/bcache9 sector 388766288)
[   27.672881] BTRFS info (device bcache8): read error corrected: ino
35130208 off 52473856 (dev /dev/bcache7 sector 388766256)
[   27.672895] BTRFS info (device bcache8): read error corrected: ino
35130208 off 52371456 (dev /dev/bcache9 sector 388766288)
[   27.672981] BTRFS info (device bcache8): read error corrected: ino
35130208 off 52494336 (dev /dev/bcache7 sector 388766256)
[   27.673075] BTRFS info (device bcache8): read error corrected: ino
35130208 off 52490240 (dev /dev/bcache7 sector 388766256)
[   27.673331] BTRFS info (device bcache8): read error corrected: ino
35130208 off 52486144 (dev /dev/bcache7 sector 388766256)
[   27.673367] BTRFS info (device bcache8): read error corrected: ino
35130208 off 52375552 (dev /dev/bcache9 sector 388766288)
[   27.673476] BTRFS info (device bcache8): read error corrected: ino
35130208 off 52379648 (dev /dev/bcache9 sector 388766288)
[   27.829254] verify_parent_transid: 16 callbacks suppressed
[   27.829256] btrfs_printk: 21 callbacks suppressed
[   27.829258] BTRFS error (device bcache8): parent transid verify
failed on 2637845299200 wanted 1255722 found 1248738
[   27.867864] BTRFS error (device bcache8): parent transid verify
failed on 2637843021824 wanted 1255722 found 1248726
[   28.084720] BTRFS error (device bcache8): parent transid verify
failed on 1503492227072 wanted 1256493 found 1248625
[   28.130912] BTRFS error (device bcache8): parent transid verify
failed on 2638079967232 wanted 1254477 found 1248814
[   28.248286] BTRFS error (device bcache8): parent transid verify
failed on 2637845954560 wanted 1255722 found 1248728
[   28.275762] BTRFS error (device bcache8): parent transid verify
failed on 2637863682048 wanted 1255722 found 1248749
[   28.329918] BTRFS error (device bcache8): parent transid verify
failed on 2638083899392 wanted 1254477 found 1248814
[   28.343927] BTRFS error (device bcache8): parent transid verify
failed on 2637853851648 wanted 1255722 found 1248749
[   28.402251] BTRFS error (device bcache8): parent transid verify
failed on 2637853835264 wanted 1255722 found 1248727
[   28.412029] BTRFS error (device bcache8): parent transid verify
failed on 443368751104 wanted 1256790 found 1248589
[   28.536016] ------------[ cut here ]------------
[   28.536030] WARNING: CPU: 1 PID: 1949 at fs/btrfs/qgroup.c:2532
btrfs_qgroup_account_extents+0x10f/0x23b
[   28.536031] Modules linked in: 8021q amdgpu gpu_sched ipmi_ssif
x86_pkg_temp_thermal kvm_intel kvm radeon irqbypass rapl intel_cstate
intel_uncore pcspkr i2c_i801 input_leds drm_kms_helper led_class
syscopyarea sysfillrect sysimgblt joydev fb_sys_fops ttm backlight
ioatdma hed ipmi_si ipmi_devintf ipmi_msghandler acpi_pad button
coretemp nfsd bonding drm auth_rpcgss oid_registry nfs_acl lockd grace
sunrpc efivarfs usbhid bcache ahci libahci igb xhci_pci i2c_algo_bit
ehci_pci i2c_core xhci_hcd ehci_hcd dca usbcore libata nvme usb_common
nvme_core
[   28.536070] CPU: 1 PID: 1949 Comm: systemd-journal Not tainted
5.4.80-gentoo-r1-x86_64 #1
[   28.536071] Hardware name: Supermicro Super Server/X10SRL-F, BIOS
2.0 12/17/2015
[   28.536076] RIP: 0010:btrfs_qgroup_account_extents+0x10f/0x23b
[   28.536079] Code: 30 e8 ac fd ff ff 49 8b 55 18 45 31 c9 48 83 c9
ff 4c 8d 44 24 10 48 89 ee 48 89 df e8 79 ab ff ff 85 c0 41 89 c4 79
24 eb 71 <0f> 0b 49 8b 55 18 45 31 c9 31 c9 31 ff 4d 8d 45 38 48 89 ee
e8 57
[   28.536081] RSP: 0018:ffffafc200347ba8 EFLAGS: 00010246
[   28.536084] RAX: ffff8fe3e8561ac0 RBX: ffff8fe3ed805888 RCX: 000000000002be80
[   28.536085] RDX: ffff8fe3e8561ac0 RSI: 0000000000000013 RDI: ffff8fe3e61b3558
[   28.536087] RBP: ffff8fe3e38ed000 R08: 0000000000000001 R09: ffffffffae2f99d1
[   28.536089] R10: ffff8fe3cdadaf40 R11: ffff8fe3cdadaf40 R12: 0000000000000000
[   28.536090] R13: ffff8fe3e8561ac0 R14: 0000000000000020 R15: 0000000000000000
[   28.536093] FS:  00007f3875101800(0000) GS:ffff8fe3efa40000(0000)
knlGS:0000000000000000
[   28.536095] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   28.536097] CR2: 00007f40f063c024 CR3: 000000046a3c2004 CR4: 00000000001606e0
[   28.536098] Call Trace:
[   28.536109]  ? _raw_spin_unlock+0x12/0x23
[   28.536115]  btrfs_commit_transaction+0x412/0x822
[   28.536121]  ? remove_wait_queue+0x46/0x46
[   28.536126]  btrfs_rename2+0x10aa/0x12e2
[   28.536129]  ? _raw_read_unlock+0x14/0x25
[   28.536133]  ? btrfs_set_path_blocking+0x27/0x48
[   28.536136]  ? btrfs_search_slot+0x5e6/0x6b0
[   28.536144]  ? vfs_rename+0x255/0x3c6
[   28.536146]  ? btrfs_create+0x1b3/0x1b3
[   28.536149]  vfs_rename+0x255/0x3c6
[   28.536154]  ? _raw_spin_unlock+0x12/0x23
[   28.536159]  do_renameat2+0x306/0x3e9
[   28.536165]  __x64_sys_rename+0x1f/0x22
[   28.536170]  do_syscall_64+0x57/0x65
[   28.536175]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   28.536180] RIP: 0033:0x7f38759445e7
[   28.536185] Code: e8 be 69 09 00 85 c0 0f 95 c0 0f b6 c0 f7 d8 5d
c3 66 90 b8 ff ff ff ff 5d c3 66 0f 1f 84 00 00 00 00 00 b8 52 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 8b 15 51 f8 15 00 f7 d8 64 89
02 b8
[   28.536187] RSP: 002b:00007ffda3fbf988 EFLAGS: 00000202 ORIG_RAX:
0000000000000052
[   28.536191] RAX: ffffffffffffffda RBX: 0000560226dd36a0 RCX: 00007f38759445e7
[   28.536193] RDX: 0000560226dcc0a0 RSI: 0000560226df8e20 RDI: 0000560226dd5340
[   28.536194] RBP: 0000560226dd5340 R08: 0000560226dcc034 R09: 0000000000000003
[   28.536196] R10: 0000000000000090 R11: 0000000000000202 R12: 00000000fffffff4
[   28.536198] R13: 0000560226dcd498 R14: 0000000000000001 R15: 0000000000000056
[   28.536202] ---[ end trace d97290982030e441 ]---
[   28.536304] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637222723584 level expected=1 has=0
[   28.536308] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637222723584 level expected=1 has=0
[   28.536311] BTRFS error (device bcache8): tree level mismatch
detected, bytenr=2637222723584 level expected=1 has=0
[   28.538767] BTRFS warning (device bcache8): Skipping commit of
aborted transaction.
[   28.538769] ------------[ cut here ]------------
[   28.538771] BTRFS: Transaction aborted (error -117)
[   28.538785] WARNING: CPU: 1 PID: 1949 at
fs/btrfs/transaction.c:1832 cleanup_transaction+0x6a/0x1cc
[   28.538786] Modules linked in: 8021q amdgpu gpu_sched ipmi_ssif
x86_pkg_temp_thermal kvm_intel kvm radeon irqbypass rapl intel_cstate
intel_uncore pcspkr i2c_i801 input_leds drm_kms_helper led_class
syscopyarea sysfillrect sysimgblt joydev fb_sys_fops ttm backlight
ioatdma hed ipmi_si ipmi_devintf ipmi_msghandler acpi_pad button
coretemp nfsd bonding drm auth_rpcgss oid_registry nfs_acl lockd grace
sunrpc efivarfs usbhid bcache ahci libahci igb xhci_pci i2c_algo_bit
ehci_pci i2c_core xhci_hcd ehci_hcd dca usbcore libata nvme usb_common
nvme_core
[   28.538815] CPU: 1 PID: 1949 Comm: systemd-journal Tainted: G
 W         5.4.80-gentoo-r1-x86_64 #1
[   28.538817] Hardware name: Supermicro Super Server/X10SRL-F, BIOS
2.0 12/17/2015
[   28.538821] RIP: 0010:cleanup_transaction+0x6a/0x1cc
[   28.538824] Code: 00 bf 02 00 00 00 e8 9f f1 ff ff 84 c0 75 1d 41
83 fe fb 74 17 41 83 fe e2 74 11 44 89 f6 48 c7 c7 0b 7b d8 ae e8 7d
9f db ff <0f> 0b 44 89 f1 ba 28 07 00 00 48 c7 c6 40 15 c4 ae 4d 8d b5
38 07
[   28.538826] RSP: 0018:ffffafc200347ba0 EFLAGS: 00010286
[   28.538828] RAX: 0000000000000000 RBX: ffff8fe3e38ed000 RCX: 0000000000000007
[   28.538830] RDX: 0000000000000001 RSI: ffffffffaed746a9 RDI: 00000000ffffffff
[   28.538832] RBP: ffff8fe3ed805888 R08: 00000006a50b1701 R09: 0000000000000027
[   28.538834] R10: 0000000000000000 R11: ffffffffaf48b728 R12: ffff8fe3e61b3400
[   28.538835] R13: ffff8fe3e38ed000 R14: 00000000ffffff8b R15: ffff8fe3ed8057c0
[   28.538838] FS:  00007f3875101800(0000) GS:ffff8fe3efa40000(0000)
knlGS:0000000000000000
[   28.538840] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   28.538842] CR2: 00007f40f063c024 CR3: 000000046a3c2004 CR4: 00000000001606e0
[   28.538843] Call Trace:
[   28.538850]  btrfs_commit_transaction+0x7fb/0x822
[   28.538855]  ? remove_wait_queue+0x46/0x46
[   28.538858]  btrfs_rename2+0x10aa/0x12e2
[   28.538862]  ? _raw_read_unlock+0x14/0x25
[   28.538866]  ? btrfs_set_path_blocking+0x27/0x48
[   28.538869]  ? btrfs_search_slot+0x5e6/0x6b0
[   28.538875]  ? vfs_rename+0x255/0x3c6
[   28.538878]  ? btrfs_create+0x1b3/0x1b3
[   28.538881]  vfs_rename+0x255/0x3c6
[   28.538885]  ? _raw_spin_unlock+0x12/0x23
[   28.538890]  do_renameat2+0x306/0x3e9
[   28.538896]  __x64_sys_rename+0x1f/0x22
[   28.538899]  do_syscall_64+0x57/0x65
[   28.538902]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   28.538906] RIP: 0033:0x7f38759445e7
[   28.538909] Code: e8 be 69 09 00 85 c0 0f 95 c0 0f b6 c0 f7 d8 5d
c3 66 90 b8 ff ff ff ff 5d c3 66 0f 1f 84 00 00 00 00 00 b8 52 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 8b 15 51 f8 15 00 f7 d8 64 89
02 b8
[   28.538910] RSP: 002b:00007ffda3fbf988 EFLAGS: 00000202 ORIG_RAX:
0000000000000052
[   28.538913] RAX: ffffffffffffffda RBX: 0000560226dd36a0 RCX: 00007f38759445e7
[   28.538915] RDX: 0000560226dcc0a0 RSI: 0000560226df8e20 RDI: 0000560226dd5340
[   28.538917] RBP: 0000560226dd5340 R08: 0000560226dcc034 R09: 0000000000000003
[   28.538919] R10: 0000000000000090 R11: 0000000000000202 R12: 00000000fffffff4
[   28.538920] R13: 0000560226dcd498 R14: 0000000000000001 R15: 0000000000000056
[   28.538925] ---[ end trace d97290982030e442 ]---
[   28.538940] BTRFS: error (device bcache8) in
cleanup_transaction:1832: errno=-117 unknown
[   28.540146] NFSD: Using old nfsdcld client tracking operations.
[   28.543602] NFSD: starting 90-second grace period (net f0000098)
[   28.543607] BTRFS info (device bcache8): forced readonly
[   28.545503] BTRFS info (device bcache8): delayed_refs has NO entry
[   32.235159] btrfs_print_data_csum_error: 11222 callbacks suppressed
[   32.235164] BTRFS warning (device bcache8): csum failed root 5 ino
35130208 off 42245029888 csum 0x22264492 expected csum 0xda26ce81
mirror 1
[   32.235259] BTRFS warning (device bcache8): csum failed root 5 ino
35130208 off 42001661952 csum 0xb42cb23a expected csum 0xdbd41db8
mirror 1
[   32.235262] BTRFS warning (device bcache8): csum failed root 5 ino
35130208 off 42001661952 csum 0xb42cb23a expected csum 0xdbd41db8
mirror 1
[   32.235277] BTRFS warning (device bcache8): csum failed root 5 ino
35130208 off 42001661952 csum 0xb42cb23a expected csum 0xdbd41db8
mirror 1
[   32.235386] BTRFS warning (device bcache8): csum failed root 5 ino
35130208 off 42001661952 csum 0xb42cb23a expected csum 0xdbd41db8
mirror 1
[   32.235484] BTRFS warning (device bcache8): csum failed root 5 ino
35130208 off 42001661952 csum 0xb42cb23a expected csum 0xdbd41db8
mirror 1
[   32.235606] BTRFS warning (device bcache8): csum failed root 5 ino
35130208 off 42001616896 csum 0xb83d1fa9 expected csum 0x7de51e69
mirror 1
[   32.235626] BTRFS warning (device bcache8): csum failed root 5 ino
35130208 off 42001616896 csum 0xb83d1fa9 expected csum 0x7de51e69
mirror 1
[   32.235882] BTRFS warning (device bcache8): csum failed root 5 ino
35130208 off 42001616896 csum 0xb83d1fa9 expected csum 0x7de51e69
mirror 1
[   32.235908] BTRFS warning (device bcache8): csum failed root 5 ino
35130208 off 42001616896 csum 0xb83d1fa9 expected csum 0x7de51e69
mirror 1
[   33.032976] verify_parent_transid: 33 callbacks suppressed
[   33.032979] BTRFS error (device bcache8): parent transid verify
failed on 2637866614784 wanted 1255722 found 1248750
[   33.534080] BTRFS error (device bcache8): parent transid verify
failed on 443429355520 wanted 1256820 found 1248614
[   33.649976] BTRFS error (device bcache8): parent transid verify
failed on 2637868580864 wanted 1255722 found 1248737
[   33.735128] BTRFS error (device bcache8): parent transid verify
failed on 1504161005568 wanted 1256545 found 1248715
[   33.848209] BTRFS error (device bcache8): parent transid verify
failed on 2637869268992 wanted 1255722 found 1248737
[   34.578484] BTRFS error (device bcache8): parent transid verify
failed on 2637870219264 wanted 1255722 found 1248737
[   34.678192] BTRFS error (device bcache8): parent transid verify
failed on 2637871874048 wanted 1255722 found 1248750
[   34.907962] NFSD: Unable to create client record on stable storage: -121
[   34.923720] BTRFS error (device bcache8): parent transid verify
failed on 2637836156928 wanted 1255722 found 1248726
[   35.187473] BTRFS error (device bcache8): parent transid verify
failed on 2637873823744 wanted 1255722 found 1248737
[   35.520732] BTRFS error (device bcache8): parent transid verify
failed on 2637865287680 wanted 1255722 found 1246710
[   37.239394] btrfs_print_data_csum_error: 11456 callbacks suppressed
[   37.239403] BTRFS warning (device bcache8): csum failed root 5 ino
35130208 off 46802059264 csum 0x66aad3c5 expected csum 0xd7c3ab69
mirror 1
[   37.240179] BTRFS warning (device bcache8): csum failed root 5 ino
35130208 off 23836516352 csum 0xd141894f expected csum 0xcbb9b123
mirror 1
[   37.240278] BTRFS warning (device bcache8): csum failed root 5 ino
35130208 off 23836516352 csum 0xd141894f expected csum 0xcbb9b123
mirror 1
[   37.240328] BTRFS warning (device bcache8): csum failed root 5 ino
35130208 off 23836516352 csum 0xd141894f expected csum 0xcbb9b123
mirror 1
[   37.240413] BTRFS warning (device bcache8): csum failed root 5 ino
35130208 off 23836516352 csum 0xd141894f expected csum 0xcbb9b123
mirror 1
[   37.240506] BTRFS warning (device bcache8): csum failed root 5 ino
35130208 off 23836516352 csum 0xd141894f expected csum 0xcbb9b123
mirror 1
[   37.240621] BTRFS warning (device bcache8): csum failed root 5 ino
35130208 off 23836516352 csum 0xd141894f expected csum 0xcbb9b123
mirror 1
[   37.241163] BTRFS warning (device bcache8): csum failed root 5 ino
35130208 off 23836516352 csum 0xd141894f expected csum 0xcbb9b123
mirror 1
[   37.241230] BTRFS warning (device bcache8): csum failed root 5 ino
35130208 off 23836516352 csum 0xd141894f expected csum 0xcbb9b123
mirror 1
[   37.241253] BTRFS warning (device bcache8): csum failed root 5 ino
35130208 off 46802059264 csum 0x66aad3c5 expected csum 0xd7c3ab69
mirror 1
[   38.332837] verify_parent_transid: 13 callbacks suppressed
[   38.332842] BTRFS error (device bcache8): parent transid verify
failed on 2637872201728 wanted 1255722 found 1248750
[   38.359910] BTRFS error (device bcache8): parent transid verify
failed on 2637873184768 wanted 1255722 found 1248737
[   38.840321] BTRFS error (device bcache8): parent transid verify
failed on 2637874495488 wanted 1255722 found 1244383
[   38.843757] BTRFS error (device bcache8): parent transid verify
failed on 2637873496064 wanted 1255722 found 1248737
[   38.947438] BTRFS error (device bcache8): parent transid verify
failed on 2637870202880 wanted 1255722 found 1248737
[   38.961613] BTRFS error (device bcache8): parent transid verify
failed on 2637874839552 wanted 1255722 found 1248750
[   38.962417] BTRFS error (device bcache8): parent transid verify
failed on 2637872545792 wanted 1255722 found 1248737
[   39.281811] BTRFS error (device bcache8): parent transid verify
failed on 2637825966080 wanted 1255722 found 1246708
[   39.365626] BTRFS error (device bcache8): parent transid verify
failed on 2637827964928 wanted 1255722 found 1248726
[   39.404831] BTRFS error (device bcache8): parent transid verify
failed on 2637828915200 wanted 1255722 found 1248726
[   51.580007] btrfs_print_data_csum_error: 2504 callbacks suppressed
[   51.580014] BTRFS warning (device bcache8): csum failed root 5 ino
29754242 off 4508229632 csum 0x8ad066c0 expected csum 0xa30916e7
mirror 1
[   51.580445] BTRFS warning (device bcache8): csum failed root 5 ino
29754242 off 4508229632 csum 0x8ad066c0 expected csum 0xa30916e7
mirror 1
[   51.580598] BTRFS warning (device bcache8): csum failed root 5 ino
29754242 off 4508229632 csum 0x8ad066c0 expected csum 0xa30916e7
mirror 1
[   51.581524] BTRFS warning (device bcache8): csum failed root 5 ino
29754242 off 4508229632 csum 0x8ad066c0 expected csum 0xa30916e7
mirror 1
[   51.581558] BTRFS warning (device bcache8): csum failed root 5 ino
29754242 off 4508229632 csum 0x8ad066c0 expected csum 0xa30916e7
mirror 1
[   51.581600] BTRFS warning (device bcache8): csum failed root 5 ino
29754242 off 4508229632 csum 0x8ad066c0 expected csum 0xa30916e7
mirror 1
[   51.581654] BTRFS warning (device bcache8): csum failed root 5 ino
29754242 off 4508229632 csum 0x8ad066c0 expected csum 0xa30916e7
mirror 1
[   51.581659] BTRFS warning (device bcache8): csum failed root 5 ino
29754242 off 4508229632 csum 0x8ad066c0 expected csum 0xa30916e7
mirror 1
[   51.581679] BTRFS warning (device bcache8): csum failed root 5 ino
29754242 off 4508229632 csum 0x8ad066c0 expected csum 0xa30916e7
mirror 1
[   51.582702] BTRFS warning (device bcache8): csum failed root 5 ino
29754242 off 4508229632 csum 0x8ad066c0 expected csum 0xa30916e7
mirror 1
[   66.489059] btrfs_print_data_csum_error: 23 callbacks suppressed
[   66.489066] BTRFS warning (device bcache8): csum failed root 5 ino
29415574 off 1135157248 csum 0xe189e80c expected csum 0x20dba345
mirror 1
[   66.489266] BTRFS warning (device bcache8): csum failed root 5 ino
29415574 off 1135157248 csum 0xe189e80c expected csum 0x20dba345
mirror 1
[   66.489335] BTRFS warning (device bcache8): csum failed root 5 ino
29415574 off 1135157248 csum 0xe189e80c expected csum 0x20dba345
mirror 1
[   66.489430] BTRFS warning (device bcache8): csum failed root 5 ino
29415574 off 1135157248 csum 0xe189e80c expected csum 0x20dba345
mirror 1
[   66.489516] BTRFS warning (device bcache8): csum failed root 5 ino
29415574 off 1135157248 csum 0xe189e80c expected csum 0x20dba345
mirror 1
[   66.489602] BTRFS warning (device bcache8): csum failed root 5 ino
29415574 off 1135157248 csum 0xe189e80c expected csum 0x20dba345
mirror 1
[   66.489702] BTRFS warning (device bcache8): csum failed root 5 ino
29415574 off 1135157248 csum 0xe189e80c expected csum 0x20dba345
mirror 1
[   66.489798] BTRFS warning (device bcache8): csum failed root 5 ino
29415574 off 1135157248 csum 0xe189e80c expected csum 0x20dba345
mirror 1
[   66.490085] BTRFS warning (device bcache8): csum failed root 5 ino
29415574 off 1135157248 csum 0xe189e80c expected csum 0x20dba345
mirror 1
[   66.490098] BTRFS warning (device bcache8): csum failed root 5 ino
29415574 off 1135157248 csum 0xe189e80c expected csum 0x20dba345
mirror 1
[   73.211134] verify_parent_transid: 1 callbacks suppressed
[   73.211141] BTRFS error (device bcache8): parent transid verify
failed on 2637944602624 wanted 1255737 found 1248780
[   73.252898] BTRFS error (device bcache8): parent transid verify
failed on 2638151680000 wanted 1256657 found 1248824
[  119.957344] NFSD: Unable to end grace period: -121
