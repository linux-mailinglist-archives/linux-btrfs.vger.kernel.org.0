Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B63442FF63
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Oct 2021 02:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239250AbhJPARH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Oct 2021 20:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbhJPARE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Oct 2021 20:17:04 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B01AC061570
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Oct 2021 17:14:57 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id i15so21384352uap.0
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Oct 2021 17:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=u3jJCQw+zAjxYaqKw+c3CgPaunhwH0sdbdJ3dnNswi4=;
        b=JHH+YwW+GKADT/U0NPNHTYbN22caXBowAKH1eXGy1NhUonJjvh6ZhnsW7Zw4VgofB0
         fx3SGW309bzITacln4q3IVR7X8aFd9JXoRA0huMiL3kGo20bhLce66Y3i+g58JrLd74V
         WpPRhz3V3QMypSVq8606vqnx5/bEKmXDrEAq0hU0QZSEt0lqaIjYIWzxBZT4aPZZrlN0
         eQHNJeFE6/cHtbpj6adjjbV2AhyOfed+nY71m8k/Y5XTEeQzNjI+jCDY1EkyQ/T+Q4rT
         Gz+1N9xV/8G7a8OOMRGBJQryik35T4YnnlMD/AD/5njz+hZYlAcosbl3o8pdOnnmBDdP
         V9gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=u3jJCQw+zAjxYaqKw+c3CgPaunhwH0sdbdJ3dnNswi4=;
        b=NdQrB+NAk4ZCRJ9nSRKz+GSoigU/el3DYS1HlEzMU54dSXWGlAbjKXiWvwpT6A0Ity
         4IbxeKBOMKrvYbfSnS5HuBV/MJsk3nz2wnt+DqjbHTCiEtLip8fYFz/QvoYbU2FC7Cuf
         k7+WxaVChezDXTDb2xLqjKqtz5Q5C/0QrFN389kVjfSONDW4iqLGAEnbpYhiS+aeMr6S
         zEIefkDcZ3crSxcbs7AVU+OJxyFQb2kHH310VjwgvVjIvI74UY4ozSbzKAnSH2VLV2ki
         bqX1tOKAGCUkLH2rkzFrXKsnxLdGX54uD8dfi3L3ci8fYqLAqeY0uVbpqODbtGaTTDpF
         KcVw==
X-Gm-Message-State: AOAM530f+vcTglevVgsGyVYoN4ByVQ3r+FRbs1JaXNu7rgRwnij65vYR
        AyI0xJ65FRuk59y0Ntv5J3hx2woibSnV9MkxPL3v9diFe9g=
X-Google-Smtp-Source: ABdhPJxK22dtL1wGFrzDLU1MyNo5aWBGgmPnde4ZeKIpPwjB8WBkU3wAQC/LSQ7VxoWXLaiU7s2i+ZpWd8bEZuwy7tA=
X-Received: by 2002:a67:d310:: with SMTP id a16mr17884043vsj.53.1634343296539;
 Fri, 15 Oct 2021 17:14:56 -0700 (PDT)
MIME-Version: 1.0
From:   James Harvey <jmsharvey771@gmail.com>
Date:   Sat, 16 Oct 2021 01:14:45 +0100
Message-ID: <CAHB2pq_Dhp7X0zRQhzbtMxKP8rC=Z8DvAaB33EF56jZHg0=+rA@mail.gmail.com>
Subject: csum failed, bad tree, block, IO failures. Is my drive dead or has my
 BTRFS broke itself?
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

My server consists of a single 16TB external drive (I have backups,
and I was planning to make a proper server at some point) and I used
BTRFS for the drive's filesystem. Recently, the file system would go
into read only and put a load of errors into the system logs. Running
a BTRFS scrub returned no errors, a readonly BTRFS check returned no
errors, and a SMART check showed no issues/bad sectors. Has BTRFS
broke itself or is this a drive issue:

Here are the errors:

Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
failed root 5 ino 97395 off 14105460736 csum 0x75ab540e expected csum
0xaeb99694 mirror 1
Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bdev
/dev/sdb1 errs: wr 0, rd 0, flush 0, corrupt 1, gen 0
Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
failed root 5 ino 97395 off 14105464832 csum 0xe83b4c2a expected csum
0xb9a65172 mirror 1
Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bdev
/dev/sdb1 errs: wr 0, rd 0, flush 0, corrupt 2, gen 0
Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
failed root 5 ino 97395 off 14105468928 csum 0x4769b37a expected csum
0x3598cf9e mirror 1
Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bdev
/dev/sdb1 errs: wr 0, rd 0, flush 0, corrupt 3, gen 0
Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
failed root 5 ino 97395 off 14105473024 csum 0x7c39a990 expected csum
0x9c523a6c mirror 1
Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bdev
/dev/sdb1 errs: wr 0, rd 0, flush 0, corrupt 4, gen 0
Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
failed root 5 ino 97395 off 14105477120 csum 0xfedc09f1 expected csum
0x68386e9a mirror 1
Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bdev
/dev/sdb1 errs: wr 0, rd 0, flush 0, corrupt 5, gen 0
Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
failed root 5 ino 97395 off 14105481216 csum 0xf9f25835 expected csum
0x96d2dea3 mirror 1
Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bdev
/dev/sdb1 errs: wr 0, rd 0, flush 0, corrupt 6, gen 0
Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
failed root 5 ino 97395 off 14105485312 csum 0x37643155 expected csum
0x6139f8a1 mirror 1
Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bdev
/dev/sdb1 errs: wr 0, rd 0, flush 0, corrupt 7, gen 0
Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
failed root 5 ino 97395 off 14105489408 csum 0x13893c06 expected csum
0xb28c00a8 mirror 1
Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bdev
/dev/sdb1 errs: wr 0, rd 0, flush 0, corrupt 8, gen 0
Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
failed root 5 ino 97395 off 14105493504 csum 0x2a89fcff expected csum
0x4c5758ed mirror 1
Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bdev
/dev/sdb1 errs: wr 0, rd 0, flush 0, corrupt 9, gen 0
Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
failed root 5 ino 97395 off 14105497600 csum 0x7484b77c expected csum
0x0a9f3138 mirror 1
Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bdev
/dev/sdb1 errs: wr 0, rd 0, flush 0, corrupt 10, gen 0
Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bad
tree block start, want 9343812173824 have 9856732008096476660
Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bad
tree block start, want 9343806013440 have 757116834938933
Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bad
tree block start, want 9343812173824 have 9856732008096476660
Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
hole found for disk bytenr range [9622003011584, 9622003015680)
Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bad
tree block start, want 9343806013440 have 757116834938933
Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bad
tree block start, want 9343812173824 have 9856732008096476660
Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
failed root 5 ino 173568 off 3875945435136 csum 0x23ed6941 expected
csum 0xc096fec5 mirror 1
Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bad
tree block start, want 9343812173824 have 9856732008096476660
Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
hole found for disk bytenr range [9622003015680, 9622003019776)
Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bad
tree block start, want 9343947784192 have 17536680014548819927
Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
failed root 5 ino 173568 off 3875945435136 csum 0x23ed6941 expected
csum 0xc096fec5 mirror 1
Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bad
tree block start, want 9343812173824 have 9856732008096476660
Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bad
tree block start, want 9343947784192 have 17536680014548819927
Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
hole found for disk bytenr range [9644356001792, 9644356005888)
Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
failed root 5 ino 173568 off 3875945435136 csum 0x23ed6941 expected
csum 0xc096fec5 mirror 1
Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bad
tree block start, want 9343812173824 have 9856732008096476660
Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
hole found for disk bytenr range [9622003019776, 9622003023872)
Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
failed root 5 ino 173568 off 3875945435136 csum 0x23ed6941 expected
csum 0xc096fec5 mirror 1
Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
hole found for disk bytenr range [9644356005888, 9644356009984)
Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
failed root 5 ino 173568 off 3875945435136 csum 0x23ed6941 expected
csum 0xc096fec5 mirror 1
Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
hole found for disk bytenr range [9622003023872, 9622003027968)
Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
failed root 5 ino 173568 off 3875945435136 csum 0x23ed6941 expected
csum 0xc096fec5 mirror 1
Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
hole found for disk bytenr range [9633973551104, 9633973555200)
Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
hole found for disk bytenr range [9644356009984, 9644356014080)
Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
failed root 5 ino 173568 off 3875945435136 csum 0x23ed6941 expected
csum 0xc096fec5 mirror 1
Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
hole found for disk bytenr range [9622003027968, 9622003032064)
Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
hole found for disk bytenr range [9633973555200, 9633973559296)
Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
failed root 5 ino 173568 off 3875945435136 csum 0x23ed6941 expected
csum 0xc096fec5 mirror 1
Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
failed root 5 ino 173568 off 3875945435136 csum 0x23ed6941 expected
csum 0xc096fec5 mirror 1
Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
failed root 5 ino 173568 off 3875945435136 csum 0x23ed6941 expected
csum 0xc096fec5 mirror 1
Oct 14 21:50:41 James-Server kernel: BTRFS: error (device sdb1) in
btrfs_finish_ordered_io:3064: errno=-5 IO failure
Oct 14 21:50:41 James-Server kernel: BTRFS info (device sdb1): forced readonly

uname -a: Linux James-Server 5.14.11-arch1-1 #1 SMP PREEMPT Sun, 10
Oct 2021 00:48:26 +0000 x86_64 GNU/Linux

btrfs --version: btrfs-progs v5.14.2

btrfs fi show:

Label: 'Seagate 16TB 1'  uuid: e183a876-95e0-4d15-a641-69f4a8e8e7e7
       Total devices 1 FS bytes used 9.61TiB
       devid    1 size 14.55TiB used 9.62TiB path /dev/sdb1

btrfs fi df:

Data, single: total=9.60TiB, used=9.60TiB
System, DUP: total=8.00MiB, used=1.09MiB
Metadata, DUP: total=11.00GiB, used=10.74GiB
GlobalReserve, single: total=512.00MiB, used=0.00B

Mount options: rw,noatime,compress=zstd:3,space_cache=v2,autodefrag,subvolid=5,subvol=/
