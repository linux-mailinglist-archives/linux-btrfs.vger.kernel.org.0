Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAD8121F6E6
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jul 2020 18:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbgGNQOK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Jul 2020 12:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgGNQOI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Jul 2020 12:14:08 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E09C061755
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Jul 2020 09:14:08 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id t27so14646362ill.9
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Jul 2020 09:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=h6MaszkxCTs22j/q9AZ4opuH9hUqC91oaUBPZpquS3c=;
        b=BI8FF5tgMdsraApeJoGqxIUDXOqekJ1B1k4C5ZURiNCu5Cn4+PdZyBRP5LVlQ9B5T3
         i9ub+50yFKL1GxINXdvooXzFoke+6TtiKHmYBgRQDsbHCPNr8fZ5g9a1YszKtfDV8cL9
         9btiKDDxUIfUwmJveT4og35eeNOesll4lBCIoLdmmud+X/G6W09TDTC2/uQ+jWKPokFZ
         BeO9+wsqjSXL4xs8suq5IvUzlgBbk4mOsxPWVGNM7g4/fuQRKwQG3iARtyGkRbJ8Tmvx
         bQrIvCkRNwHB9WMhfZeF8oct1NvsRhnQYUGSGSJ9z7NHU/9sW/E9w4WtIeMDmzuWEG6J
         ZNtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=h6MaszkxCTs22j/q9AZ4opuH9hUqC91oaUBPZpquS3c=;
        b=PS/p+GnS20zqQ2c/2h4vMwBz3UBTzj6H+kxlQLKCzE8MigEFaJ/spBmUS+UjfYd0Hh
         HwnyKZQIhrmsAOFjx6VlZDQ6tyyx6G+mNAeWNPYBksTWsGRPEEygkU5euBhpPbyztu0k
         MKVYHUT7o5dzmG4EqkYCQ+sEpJTp+JQjkoZj5s8T97FapLeBNGBV6qYnSIgiTdJG4oVL
         DWvU/GogJwoRLin2wRQRsVFUWd9XJSjasuCqawSrN+xIVDbn7/ahw9c+4zMD8eNNlLD+
         ZnH3bTrLMC6DzWn4HiIvbzVBbGXP40tG362VbCR0ca2XbL2KHuqlLG0ImL6duz5Op1qi
         vuKQ==
X-Gm-Message-State: AOAM533nASk7t3+UJRhukC8+WP2BGEgGNENVWuUeAwH63PUKSwhKJdzU
        9pGxwaVvN6kl895WMCZZp/ZBppQY3A72B4iwJ1vr9VDi
X-Google-Smtp-Source: ABdhPJzkVRf/sfgWWZnoULK8CDAy6LmXTn0y+TmK4ZKSe1P60xdGF296GxRfZmpOkq4nGoAKyc4E1p67ayp/hh/te+U=
X-Received: by 2002:a92:aa92:: with SMTP id p18mr5370737ill.199.1594743247092;
 Tue, 14 Jul 2020 09:14:07 -0700 (PDT)
MIME-Version: 1.0
From:   John Petrini <john.d.petrini@gmail.com>
Date:   Tue, 14 Jul 2020 12:13:56 -0400
Message-ID: <CADvYWxeiNynEWUYwfQxP7fQTK4k2Q+eDZsA8j7rLcaTSeND9fg@mail.gmail.com>
Subject: Filesystem Went Read Only During Raid-10 to Raid-6 Data Conversion
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello All,

My filesystem went read only while converting data from raid-10 to
raid-6. I attempted a scrub but it immediately aborted. Can anyone
provide some guidance on possibly recovering?

Thank you!

##System Details##
Ubuntu 18.04

# This shows some read errors but they are not new. I had a SATA cable
come loose on a drive some months back that caused these. They haven't
increased since I reseated the cable
sudo btrfs device stats /mnt/storage-array/ | grep sde
[/dev/sde].write_io_errs    0
[/dev/sde].read_io_errs     237
[/dev/sde].flush_io_errs    0
[/dev/sde].corruption_errs  0
[/dev/sde].generation_errs  0


btrfs fi df /mnt/storage-array/
Data, RAID10: total=32.68TiB, used=32.64TiB
Data, RAID6: total=1.04TiB, used=1.04TiB
System, RAID10: total=96.00MiB, used=3.06MiB
Metadata, RAID10: total=40.84GiB, used=39.94GiB
GlobalReserve, single: total=512.00MiB, used=512.00MiB

uname -r
5.3.0-40-generic

##dmesg##
[3813499.479570] BTRFS info (device sdd): no csum found for inode
44197278 start 401276928
[3813499.480211] BTRFS warning (device sdd): csum failed root 5 ino
44197278 off 401276928 csum 0x0573112f expected csum 0x00000000 mirror
2
[3813506.750924] BTRFS error (device sdd): parent transid verify
failed on 98952926429184 wanted 6618521 found 6618515
[3813506.751395] BTRFS error (device sdd): parent transid verify
failed on 98952926429184 wanted 6618521 found 6618515
[3813506.751783] BTRFS info (device sdd): no csum found for inode
44197278 start 152698880
[3813506.773031] BTRFS warning (device sdd): csum failed root 5 ino
44197278 off 152698880 csum 0x9b7d599f expected csum 0x00000000 mirror
1
[3813506.773070] BTRFS error (device sdd): parent transid verify
failed on 98952926429184 wanted 6618521 found 6618515
[3813506.773596] BTRFS error (device sdd): parent transid verify
failed on 98952926429184 wanted 6618521 found 6618515
[3813506.774073] BTRFS info (device sdd): no csum found for inode
44197278 start 152698880
[3813506.813401] BTRFS warning (device sdd): csum failed root 5 ino
44197278 off 152698880 csum 0x9b7d599f expected csum 0x00000000 mirror
2
[3813506.813431] BTRFS error (device sdd): parent transid verify
failed on 98952926429184 wanted 6618521 found 6618515
[3813506.813439] BTRFS error (device sdd): parent transid verify
failed on 98952926429184 wanted 6618521 found 6618515
[3813506.813444] BTRFS info (device sdd): no csum found for inode
44197278 start 152698880
[3813506.813612] BTRFS warning (device sdd): csum failed root 5 ino
44197278 off 152698880 csum 0x9b7d599f expected csum 0x00000000 mirror
3
[3813506.813624] BTRFS error (device sdd): parent transid verify
failed on 98952926429184 wanted 6618521 found 6618515
[3813506.813628] BTRFS error (device sdd): parent transid verify
failed on 98952926429184 wanted 6618521 found 6618515
[3813506.813632] BTRFS info (device sdd): no csum found for inode
44197278 start 152698880
[3813506.816222] BTRFS warning (device sdd): csum failed root 5 ino
44197278 off 152698880 csum 0x9b7d599f expected csum 0x00000000 mirror
4
[3813510.542147] BTRFS error (device sdd): parent transid verify
failed on 104091430649856 wanted 6618521 found 6618516
[3813510.542731] BTRFS error (device sdd): parent transid verify
failed on 104091430649856 wanted 6618521 found 6618516
[3813510.543216] BTRFS info (device sdd): no csum found for inode
44197278 start 288227328
[3813510.558299] BTRFS warning (device sdd): csum failed root 5 ino
44197278 off 288227328 csum 0xa0775535 expected csum 0x00000000 mirror
1
[3813510.558341] BTRFS info (device sdd): no csum found for inode
44197278 start 288227328
[3813510.574681] BTRFS warning (device sdd): csum failed root 5 ino
44197278 off 288227328 csum 0xa0775535 expected csum 0x00000000 mirror
2
[3813510.574714] BTRFS info (device sdd): no csum found for inode
44197278 start 288227328
[3813510.574965] BTRFS warning (device sdd): csum failed root 5 ino
44197278 off 288227328 csum 0xa0775535 expected csum 0x00000000 mirror
3
[3813510.574980] BTRFS info (device sdd): no csum found for inode
44197278 start 288227328
[3813510.576050] BTRFS warning (device sdd): csum failed root 5 ino
44197278 off 288227328 csum 0xa0775535 expected csum 0x00000000 mirror
4
[3813510.576070] BTRFS info (device sdd): no csum found for inode
44197278 start 288227328
[3813510.577198] BTRFS warning (device sdd): csum failed root 5 ino
44197278 off 288227328 csum 0xa0775535 expected csum 0x00000000 mirror
5
[3813510.577214] BTRFS info (device sdd): no csum found for inode
44197278 start 288227328
[3813510.578222] BTRFS warning (device sdd): csum failed root 5 ino
44197278 off 288227328 csum 0xa0775535 expected csum 0x00000000 mirror
6
