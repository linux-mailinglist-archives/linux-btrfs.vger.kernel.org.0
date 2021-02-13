Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C88F031AC82
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Feb 2021 16:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbhBMPHe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 13 Feb 2021 10:07:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbhBMPHe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 13 Feb 2021 10:07:34 -0500
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DC3C061574
        for <linux-btrfs@vger.kernel.org>; Sat, 13 Feb 2021 07:06:53 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id e7so1901245ile.7
        for <linux-btrfs@vger.kernel.org>; Sat, 13 Feb 2021 07:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ceremcem-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=ycT31mE6592yttaf5CzmUzMEZN8wfEgCZNrqSBF8lIY=;
        b=AAaV3Gp67QWrn2vA7DqCtaPilhjDEgG3vysCcz0EQaFNweo/P+h/AVaKu/khEwVZnv
         ndpwKs4LzuC1Jph9iw6YZSDcp1imZTOlh2/DuUmYzrI+xFmBomcuteUp32Ea9owg4KSs
         6vP2IhKDtac3UoTCas+J38+5YbH0Y7gGch2JxT8R1EVcPOYJTqbRcoKQKe9tOoHJxxtL
         4W6jU2nF9lyeHRtz1/T/He/qQW4Lz2IF2UbKNZqXaPt3s5QMOdJWj0Z6U1XSOCkhIYEf
         oogx3dPDyi+I7dXTQotFmWWZryZH7nHx22we6ih3w2FPjdSJqH3ECZ1y5otS8yGy4FOH
         wZMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ycT31mE6592yttaf5CzmUzMEZN8wfEgCZNrqSBF8lIY=;
        b=AXf/II1rOPL66RVaeMJDbqXqQqsiGTtevhTPjVkPjkvBuemNicvbvCioLBUttZo1+P
         fIYiybBiwFdSwEQ7nxvqWqRPz4AS8A3xwjbu+0a0YAfGX8KVwwFEc4p6JdZ75nQT40G2
         hy66X7It4Td4GTerZT/9+i+ZgGJRy9q8R1XABnUCgdwo/XvDwRFdgsR5NvZSjgx4QX/O
         AVWjWibkKsJAYu8HaOXUdfGTxGIn58kEkWtxVUd6Szy+9NjxBri2ukKKCQBSarsDbGUT
         ch3k4wLydcHYbvGrzKIfHXtLqFvNuDYvc+ANVtDggqVCCsNitYT74Q9k3kgQRpvg0s/L
         fcLw==
X-Gm-Message-State: AOAM530scTFG0ppCoZ4njKeyMsbMLK4MJtNK4nrP51pOObWKgoIfOM52
        vlnfDAmrGNQ9NNvkk8J605AqE96dUikg783R9YoI41aor0STSLitdms=
X-Google-Smtp-Source: ABdhPJxh60dPoHvdViEbHkqcqEKhO8usGsZ1hT+j0ozVbhlOR4Y54YlaSWC78F6taY+9lMulLBLvCXGtna6tpQLu1RI=
X-Received: by 2002:a92:d30d:: with SMTP id x13mr6568497ila.217.1613228812923;
 Sat, 13 Feb 2021 07:06:52 -0800 (PST)
MIME-Version: 1.0
From:   Cerem Cem ASLAN <ceremcem@ceremcem.net>
Date:   Sat, 13 Feb 2021 18:06:41 +0300
Message-ID: <CAN4oSBftCwpZvm-96bvOQzCVCsWHW1e8r6hWjWOtMr9ntCDcxg@mail.gmail.com>
Subject: btrfs receive started to fail constantly for a subvolume
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Basically I'm using btrbk to create snapshots on main disk (MMM) and
send them 2 distinct disks (AAA and BBB). I have many nested
subvolumes (X, X/foo/Y, etc), so every distinct subvolume is
enumerated separately, like X.111, X.112, ..., X/foo/Y.111,
X/foo/Y.112, etc. Setup worked well for 100s of snapshots and backups
(send/receive) within the last 2 months.

Currently there is one offending subvolume that couldn't be sent to
disk AAA (say X.111). I tried to send it a couple of times even though
the huge size (230GB, takes 4 hour for every test) but there was no
success.

Error was like:

ERROR: ... sh: btrfs send -p
/mnt/MMM-root/snapshots/erik3/rootfs.20210213T0356 -c
/mnt/MMM-root/snapshots/erik3/rootfs.20210213T0414
/mnt/MMM-root/snapshots/erik3/home/ceremcem.20210213T0356 | mbuffer -v
1 | btrfs receive /mnt/AAA-root/snapshots/erik3/home/
ERROR: ... cannot open
/mnt/AAA-root/snapshots/erik3/home/ceremcem.20210213T0356/o10179316-137012-0:
No such file or directory

I tried to issue `btrfs send
/mnt/MMM-root/snapshots/erik3/home/ceremcem.20210213T0356 | pv >
/dev/null` to see if there is anything wrong with the source snapshot,
but it succeeded.

Skipping the other intermediate attempts, I tried to remove every
snapshot in AAA, BBB, reformat AAA and BBB with mkfs.btrfs, deleted
all snapshots and created a new set on MMM, tried to send everything
from scratch. It failed with nearly the same error (can't remember
now) on the same subvolume
(/mnt/MMM-root/snapshots/erik3/home/ceremcem.XXX).

I ran a btrfs scrub on /mnt/MMM-root and there were no errors.

Why do I keep getting this error?

uname -a
Linux erik3 5.9.0-0.bpo.5-amd64 #1 SMP Debian 5.9.15-1~bpo10+1
(2020-12-31) x86_64 GNU/Linux

btrfs-progs v5.10
