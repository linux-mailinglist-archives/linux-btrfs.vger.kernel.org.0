Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7F3BBF60
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2019 02:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391581AbfIXAe5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Sep 2019 20:34:57 -0400
Received: from mail-io1-f43.google.com ([209.85.166.43]:33203 "EHLO
        mail-io1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388800AbfIXAe5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Sep 2019 20:34:57 -0400
Received: by mail-io1-f43.google.com with SMTP id z19so167414ior.0
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Sep 2019 17:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=tbCrvngXkI3ZzumMZ4B6ItNLzNyA89YvVlKByFOCGVw=;
        b=ekLO5ZYFTkZUiMw8KH61svB1ODDiOhko6xQ4gs5+XcaWc4mMtirn1e+AHGSnxWhwJn
         fLkzoo043I4kx40nBWpWZcsWU1AVsc6MkWVJkoEtuKu+lvnrJTOE2Ptz0PxJuPYOvVi2
         UXQMOiUMKKz0UEPRpAbTa/txEeCqrRt+QlnALjtDp7WUWXqqzy6JGmbvNe31NwDmmvFq
         6W58ThcTV2HHl0MSuMcjVBB6mdUbRk9dumdMsrGCNG2Ke8/H2HF3znQS7UieysrA6dam
         QYF+M/uynTUa0756nGG/xmTQXKrEOzSLOy84CkVkMX8rHGuEolbAdLE+hUWwNAc70nNI
         zMZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=tbCrvngXkI3ZzumMZ4B6ItNLzNyA89YvVlKByFOCGVw=;
        b=VaR9JQXWty+1iteF++gd4ja2LKe/PZdMjz1QmqYLIi05qVudccHBJChrHV2ZT35p2d
         nGjuUmNblUOOAMBim27PUX91+mly1jXdANbX7fBUIww6u6UxZr4OEilNKijt9MIHD5pc
         QrugjNV234zvXghR9wKsJPkO1iHEvHlTpLLAMC9aOPSnlAlWRglsEuNn+DEPyJYLnJKK
         jvF1WHHyQCXJvOYc+wx5yhaUxrp18q6QHzmyAdJMTPSk6CZ2340j1T3Ek9ErDkP9yhQi
         hzD8V4boxhdxfJ2wiZbo396NLDNq71bt/1Bor3F5ulExeq06ocdadkuxkrb9vwAgsBN0
         aNIA==
X-Gm-Message-State: APjAAAUGZZIBcUC7Ff94jZ7T/J4QcvDXzU5bxiwnGbx7TEOTfYFqWtjU
        7/GxK5KMog/Pvxcexl13OGV8OUHw5+H41I13Tm2+b8Sw
X-Google-Smtp-Source: APXvYqx9Vf6vWvZNxCpWGvUsVEtYSzySY9vX355QavtE9MtfANjRoaPf3KdiVtA/NIL1eUSWDrih8CJyDwYOdV6A9aY=
X-Received: by 2002:a6b:148a:: with SMTP id 132mr299113iou.55.1569285296363;
 Mon, 23 Sep 2019 17:34:56 -0700 (PDT)
MIME-Version: 1.0
From:   Charles Wright <charles.v.wright@gmail.com>
Date:   Mon, 23 Sep 2019 20:34:45 -0400
Message-ID: <CAFN5=-NhtmJ5NTePqdyUPaWm2r0oTbbCrmC0dOhC5fm2EtWwHA@mail.gmail.com>
Subject: Tree checker
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

OK so I got an update to a 5.3.0-12 Ubuntu Kernel 3-4 day's ago and
started having problems on my user data drive a 1TB drive that that I
keep the usual ~/ directories (Documents , Downloads , Music, ect,ect)
on and link back to ~/ in 4 installs on this box , so whatever install
I'm booted to I have my data .

story hear https://www.kubuntuforums.net/showthread.php/75909-strange-probl=
em-on-testing-with-hwe-edge-5-3-0-12-kernel

the error I get in dmesg ,,,
[  476.437134] BTRFS error (device sdb1): block=3D150186876928 read time
tree block corruption detected
[  476.437323] BTRFS critical (device sdb1): corrupt leaf: root=3D5
block=3D150186876928 slot=3D3 ino=3D49938688, invalid inode generation: has
18446744073709551492 expect [0, 80501]

and

[  762.622905] BTRFS error (device sdb1): block=3D150186876928 read time
tree block corruption detected
[  805.852391] BTRFS critical (device sdb1): corrupt leaf: root=3D5
block=3D149315502080 slot=3D0 ino=3D49938701, invalid inode generation: has
18446744073709551492 expect [0, 80501]

this seems to be 2 directorys  the first "dwhelper" I can still see
the directory but it lists as empty (it has 44 youtube videos in it )
the second you cant see the directory "steam" in Dolphin but "ls -la"
shows this "d????????? ? ? ? ? ? steam"

if I boot the 5.0.0-30 kernel and enter the "dwhelper" directory and
do "dmesg" their is this

[  199.522886] ata2.00: exception Emask 0x10 SAct 0x8000 SErr 0x2d0100
action 0x6 frozen
[  199.522891] ata2.00: irq_stat 0x08000000, interface fatal error
[  199.522893] ata2: SError: { UnrecovData PHYRdyChg CommWake 10B8B BadCRC =
}
[  199.522897] ata2.00: failed command: READ FPDMA QUEUED
[  199.522902] ata2.00: cmd 60/08:78:a8:57:f3/00:00:12:00:00/40 tag 15
ncq dma 4096 in
                        res 50/00:08:a8:57:f3/00:00:12:00:00/40 Emask
0x10 (ATA bus error)
[  199.522904] ata2.00: status: { DRDY }
[  199.522908] ata2: hard resetting link
[  199.837384] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[  199.840579] ata2.00: configured for UDMA/133
[  199.840771] ata2: EH complete

but all works  as in I can access the files as normal

and in the 5.0.0-29 and 4.15.0-65 kernels no errors at all .

basic system info

Operating System: KDE neon Testing Edition
KDE Plasma Version: 5.16.90
KDE Frameworks Version: 5.63.0
Qt Version: 5.12.3
Kernel Version: 5.0.0-30-generic
OS Type: 64-bit
Processors: 8 =C3=97 Intel=C2=AE Core=E2=84=A2 i7-4910MQ CPU @ 2.90GHz
Memory: 15.6 GiB of RAM

the web page https://btrfs.wiki.kernel.org/index.php/Tree-checker
asked to report an error like this hear , so her I am :)

any more info or tests you want me to run or provide I will ,,,,,, O
hears some drive info

vinny@vinny-Bonobo-Extreme:~$ sudo parted -l
[sudo] password for vinny:
Model: ATA HGST HTS725050A7 (scsi)
Disk /dev/sda: 500GB
Sector size (logical/physical): 512B/4096B
Partition Table: msdos
Disk Flags:

Number  Start   End    Size    Type      File system     Flags
 1      8225kB  323GB  323GB   primary   btrfs           boot
 3      323GB   379GB  56.3GB  primary   ext4
 4      379GB   496GB  117GB   extended
 6      379GB   436GB  57.0GB  logical   ext4
 5      436GB   496GB  59.8GB  logical   ext4
 2      496GB   500GB  4295MB  primary   linux-swap(v1)


Model: ATA HGST HTS721010A9 (scsi)
Disk /dev/sdb: 1000GB
Sector size (logical/physical): 512B/4096B
Partition Table: gpt
Disk Flags:

Number  Start   End     Size    File system  Name     Flags
 1      1049kB  1000GB  1000GB  btrfs        primary


Model: ATA Samsung SSD 860 (scsi)
Disk /dev/sdc: 250GB
Sector size (logical/physical): 512B/512B
Partition Table: loop
Disk Flags:

Number  Start  End    Size   File system  Flags
 1      0.00B  250GB  250GB  btrfs

hope we can help each other .

Charles V. Wright
