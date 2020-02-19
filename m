Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C96F41637F8
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2020 01:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbgBSAFm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Feb 2020 19:05:42 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:36325 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbgBSAFm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Feb 2020 19:05:42 -0500
Received: by mail-yb1-f196.google.com with SMTP id u26so7906271ybd.3
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Feb 2020 16:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=NC3ZbOggDylBT09l7Vlerw8w0eAVci5KzQCC1cGIPws=;
        b=G4hRElh8RtKmSD4WD835HYae7yq2fQKfjCtq14fQREhW/Sr5jdQQ9Al/4Ica0WVJ16
         214vMnwaqoPMWSEZXge5vsXDGcqX1ijSeP3wPzhj1zItoGFrlSs7S/FAZDtQjvPV4pFv
         yiIZwDtojjuJyNV1pY+EZ7xhj7t3NXMY4fGRG+F6v+dLRENiNO8HRacnQcp4Z3sy7igm
         U+8tieoorRmdM8B0ndKPXKlrTmtaLkxoLjrylDLC931SXy+wggLaPYll36tXMltrJJN2
         HJD/JxONTfl39t0GusxqD1sYQnysAag5ZI0rBQFpPgazN4DMWNFOQG6gFVcRt80bpsFO
         PLIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=NC3ZbOggDylBT09l7Vlerw8w0eAVci5KzQCC1cGIPws=;
        b=DfCjfuoUMC0VOwKPyofB47qhImz6OjgTmMF1lXXqJTWawXOPgekF607S1GcouvIkEx
         QLAV9zPDgmxwaHNJeRZsDJ441cV69NbngKf+9i5viQwYFHDZjSdo/hnIgp4E2IKAzjpj
         OAGPzQtPv6nNPfR0wetuCNJrqJXzdIpV4GQoK+NNle13ojnB/dFJnbXWMcAkPBC5YhvK
         ZSnaWT4UpHlO3HQ/GqgGPVBN87PpL0yDrBYwi6nEb5ZiE1b81z4lXat56FzpTKNNfPJB
         Lvwg+vBBRD3hKDhp3O6lKoji/DOwyb4eUydejW+cFU75r76j9NnUdS96zgyStR8BdxL0
         jaJw==
X-Gm-Message-State: APjAAAWkr7PDSYLDBDJodk76dSIyKTGGagJiRsIxhc6ULV6jE7Do07XS
        Hpnp2XsPPLP6PucY1ap7ecR7Lee/0AyCSq1U4L2VERmY
X-Google-Smtp-Source: APXvYqzxrfXBXgh3iZWFMikTIVER74BPotA9Xp4dZsZr4OVdw45ZTE+TGhB56vqsaXkVXha9txfbW4IxEUcy5BqLzCU=
X-Received: by 2002:a5b:9ca:: with SMTP id y10mr21664483ybq.195.1582070739246;
 Tue, 18 Feb 2020 16:05:39 -0800 (PST)
MIME-Version: 1.0
From:   Steven Fosdick <stevenfosdick@gmail.com>
Date:   Wed, 19 Feb 2020 00:05:28 +0000
Message-ID: <CAG_8rEeESu5Dv=4GbazRBPbRDonfwfpDY8pTZtsYWq1kZ7Zruw@mail.gmail.com>
Subject: Balance / Remove Device Errors and Loops
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Guys,

The recent patch to allow a balance operation to be cancelled more
quickly is very welcome.  I have applied that to 5.5.4 and it has
already avoided me having to do a hard reset.

On a filesystem which has suffered one disc failure I am trying to get
the data properly redundant across the remaining discs.  According to
the documentation 'device replace' needs to be able to read the
superblock on the outgoing device.  As this one has failed and that is
not possible so I mounted the filesystem in degraded mode, added a new
device, which worked fine, and then tried removing the missing device
which did not work.  After some checsum warnings:

Feb 10 19:49:44 meije kernel: BTRFS warning (device sda): csum failed
root -9 ino 272 off 1494749184 csum 0x8941f998 expected csum
0x4c946d24 mirror 2
Feb 10 19:49:44 meije kernel: BTRFS warning (device sda): csum failed
root -9 ino 272 off 1494753280 csum 0x8941f998 expected csum
0x3cacfa54 mirror 2
Feb 10 19:49:44 meije kernel: BTRFS warning (device sda): csum failed
root -9 ino 272 off 1494757376 csum 0x8941f998 expected csum
0x453f4f60 mirror 2
Feb 10 19:49:44 meije kernel: BTRFS warning (device sda): csum failed
root -9 ino 272 off 1494761472 csum 0x8941f998 expected csum
0x5630f6fa mirror 2
Feb 10 19:49:44 meije kernel: BTRFS warning (device sda): csum failed
root -9 ino 272 off 1494765568 csum 0x8941f998 expected csum
0xbf215c7a mirror 2
Feb 10 19:49:44 meije kernel: BTRFS warning (device sda): csum failed
root -9 ino 272 off 1494769664 csum 0x8941f998 expected csum
0x242df5b3 mirror 2
Feb 10 19:49:44 meije kernel: BTRFS warning (device sda): csum failed
root -9 ino 272 off 1494773760 csum 0x8941f998 expected csum
0x84d8643c mirror 2
Feb 10 19:49:44 meije kernel: BTRFS warning (device sda): csum failed
root -9 ino 272 off 1494777856 csum 0x8941f998 expected csum
0xcd4799e3 mirror 2
Feb 10 19:49:44 meije kernel: BTRFS warning (device sda): csum failed
root -9 ino 272 off 1494781952 csum 0x8941f998 expected csum
0x84e72065 mirror 2
Feb 10 19:49:44 meije kernel: BTRFS warning (device sda): csum failed
root -9 ino 272 off 1494786048 csum 0x8941f998 expected csum
0xa1a55d97 mirror 2

The device remove failed with I/O error.  As another way to move the
data onto the three remaining discs I tried using a balance filter.  I
was able, I think, to move all the metadata to the remaining discs
with:

btrfs balance start -mdevid=3

and then start on the data.  Trying to do the whole device at once
fails after a checksum warning so I tried working in units of 100Gb,
for example:

btrfs balance start -ddevid=3,drange=0..107374182400 /data

and then:

btrfs balance start -ddevid=3,drange=107374182400..214748364800 /data

etc.  The first ten of these succeeded, though three found nothing to
move.  The next, 1073741824000..1181116006400 failed after a checksum
warning:

Feb 18 23:50:23 meije kernel: BTRFS warning (device sda): csum failed
root -9 ino 601 off 2070544384 csum 0x8941f998 expected csum
0x963bbe29 mirror 2
Feb 18 23:50:23 meije kernel: BTRFS warning (device sda): csum failed
root -9 ino 601 off 2070552576 csum 0x8941f998 expected csum
0xb1aa5076 mirror 2
Feb 18 23:50:23 meije kernel: BTRFS warning (device sda): csum failed
root -9 ino 601 off 2070556672 csum 0x8941f998 expected csum
0x8eefa0c0 mirror 2
Feb 18 23:50:23 meije kernel: BTRFS warning (device sda): csum failed
root -9 ino 601 off 2070548480 csum 0x8941f998 expected csum
0xf865c292 mirror 2
Feb 18 23:50:23 meije kernel: BTRFS warning (device sda): csum failed
root -9 ino 601 off 2070560768 csum 0x8941f998 expected csum
0x8e37b369 mirror 2
Feb 18 23:50:23 meije kernel: BTRFS warning (device sda): csum failed
root -9 ino 601 off 2070564864 csum 0x8941f998 expected csum
0xcf28e045 mirror 2
Feb 18 23:50:23 meije kernel: BTRFS warning (device sda): csum failed
root -9 ino 601 off 2070568960 csum 0x8941f998 expected csum
0xe37e32c0 mirror 2
Feb 18 23:50:23 meije kernel: BTRFS warning (device sda): csum failed
root -9 ino 601 off 2070573056 csum 0x8941f998 expected csum
0xed9dd8b2 mirror 2
Feb 18 23:50:23 meije kernel: BTRFS warning (device sda): csum failed
root -9 ino 601 off 2070577152 csum 0x8941f998 expected csum
0x2f48ca31 mirror 2
Feb 18 23:50:23 meije kernel: BTRFS warning (device sda): csum failed
root -9 ino 601 off 2070581248 csum 0x8941f998 expected csum
0xfb166087 mirror 2

Thereafter, all higher offsets seem to get stuck in a loop.  For example:

Feb 18 23:55:02 meije kernel: BTRFS info (device sda): balance: start
-ddevid=3,drange=1181116006400..1288490188800
Feb 18 23:55:02 meije kernel: BTRFS info (device sda): relocating
block group 2573789560832 flags data|raid5
Feb 18 23:55:27 meije kernel: BTRFS info (device sda): found 865 extents
Feb 18 23:55:30 meije kernel: BTRFS info (device sda): found 862 extents
Feb 18 23:55:31 meije kernel: BTRFS info (device sda): found 855 extents
Feb 18 23:55:32 meije kernel: BTRFS info (device sda): found 855 extents
Feb 18 23:55:33 meije kernel: BTRFS info (device sda): found 855 extents
Feb 18 23:55:34 meije kernel: BTRFS info (device sda): found 855 extents
...

Any idea what is going on here?  There are no errors logged for the
case of being stuck in a loop.  What would cause that loop to go round
again?  I don't even understand why it normally goes round twice.

This doesn't seem close to balancing the majority of the data onto the
working devices:

Data,RAID5: Size:8.95TiB, Used:8.93TiB (99.73%)
   /dev/sda    4.48TiB
   /dev/sdc    4.48TiB
   missing    3.52TiB
   /dev/sdb 976.00GiB # the new device.

This is kernel version 5.5.4-arch1-1 and btrfs --version v5.4.  I
cannot see any changes to btrfs, i.e. the fs/btrfs directory, between
the arch kernel and the vanilla 5.4 (though I have installed the
balance cancel patch from this list as mentioned previously).

Regards,
Steve.
