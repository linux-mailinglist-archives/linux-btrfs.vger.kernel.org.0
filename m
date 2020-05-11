Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 465FB1CDAD6
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 May 2020 15:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729763AbgEKNL7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 May 2020 09:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726687AbgEKNL7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 May 2020 09:11:59 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A566C061A0C
        for <linux-btrfs@vger.kernel.org>; Mon, 11 May 2020 06:11:58 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id n14so9591394qke.8
        for <linux-btrfs@vger.kernel.org>; Mon, 11 May 2020 06:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clarafamily.com; s=google;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=LYw+wjZATmpSJ8tJp28A2Eefmb7wiJrV+s9FoCJs7EM=;
        b=G0BOGl4v6rs5fl2u+b789LHdrJdxlmSfRbnIuh2M4UO+ASiBvHmRyXHzv174LTj+wb
         An83MXhIugXPVudTxwRFe1ZS58JVit5edrQvqUagLrybSnKDJEdTr+DcP4HZagQWF70t
         7dBHpUyFaDArD8bNbN/I4ymNsfJWGVgfaJzU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=LYw+wjZATmpSJ8tJp28A2Eefmb7wiJrV+s9FoCJs7EM=;
        b=BATEMaDX2w3GZepqFjwQpo5Ye384XtGLbUsHIPJkNbU3VVauH9hTXIWtXH2CWVnVop
         +Kphzt9mUeX2JLrhYFH0xJj7c+7wV04e9kjZHOZj7VDRI9oqoFVdAj+2M2y8kIEqX6Yk
         xWdMdeNeNfj0823U9KnKG8GbzQrTKFC8R6uF4bFgqiNtNqRa5dOOis5om3HZR91ChJHP
         lcPsycMgvqVPAFE2koBBtpbURomfuKh+SzUghV7G2M4R99c+GFKKd5NJxafGUrJBf04z
         T8TZiScjfl0/EAz+Ja1RV/3QTxpQdEwwqStnjsoJYqRsglGvSuwD23zyUVuf/wjyR7+Q
         6mjw==
X-Gm-Message-State: AGi0PuawNSeuHpvJCF3WTStr8q/SNtfaTFShi5HQkeOh3Q1RB4WoQrPx
        H9vQRQTWSyObvswecZKbACGGWun1pz4=
X-Google-Smtp-Source: APiQypIE3NrM5TCA31Rn+IiLjvW1CsMVLf2o4RZIeaS/YiDoO/A+89QhDgyE6fF8cClV/2TUUVHRxA==
X-Received: by 2002:a37:9c4e:: with SMTP id f75mr14926168qke.175.1589202717270;
        Mon, 11 May 2020 06:11:57 -0700 (PDT)
Received: from jasons-mbp.clara (CPE40623100049e-CM9050cac9ddf0.cpe.net.cable.rogers.com. [99.247.249.188])
        by smtp.gmail.com with ESMTPSA id a24sm5799311qto.10.2020.05.11.06.11.56
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 May 2020 06:11:56 -0700 (PDT)
From:   Jason Clara <jason@clarafamily.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.5\))
Subject: Help with unmountable boot volume
Message-Id: <14907AA2-4E26-4025-945E-4BCB87A32254@clarafamily.com>
Date:   Mon, 11 May 2020 09:11:55 -0400
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
X-Mailer: Apple Mail (2.3445.9.5)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I woke up this morning and my system had crashed and my root filesystem =
was readonly.

Reboot failed when mounting the root filesystem, and now my system will =
not boot.

I had a USB I setup for recovery and booted into that and to help with =
recovery but I am currently stuck.

Some background into.
Root file system is RAID 1 with two 1TB drives (Both M.2 one is NVME and =
one is SATA)
Original system is Ubuntu 18.04 with kernel 5.5.7 and btrfs-progs I =
think was version 5.6
I think last scrub on the pool was maybe 1-2 months ago.  But sure exact =
timing.

My recovery environment is ubuntu 20.04 with kernel 5.6.7 and =
btrfs-progs 5.6 and that is what I am running under at the moment

When I try to mount the filesystem I get the following error.
boot@boot-live-usb:~$ sudo mount /dev/sdm2 /media/root/
[sudo] password for boot:=20
mount: /media/root: wrong fs type, bad option, bad superblock on =
/dev/sdm2, missing codepage or helper program, or other error.

With dmesg showing
[Mon May 11 08:56:47 2020] BTRFS info (device nvme0n1p2): disk space =
caching is enabled
[Mon May 11 08:56:47 2020] BTRFS info (device nvme0n1p2): has skinny =
extents
[Mon May 11 08:56:47 2020] BTRFS error (device nvme0n1p2): bad tree =
block start, want 2728265449472 have 5440864628575810330
[Mon May 11 08:56:47 2020] BTRFS error (device nvme0n1p2): bad tree =
block start, want 2728265449472 have 0
[Mon May 11 08:56:47 2020] BTRFS error (device nvme0n1p2): failed to =
read block groups: -5
[Mon May 11 08:56:47 2020] BTRFS error (device nvme0n1p2): open_ctree =
failed


Trying a readonly check on the filesystem gave me the following error
boot@boot-live-usb:~$ sudo btrfs check --readonly /dev/sdm2=20
Opening filesystem to check...
checksum verify failed on 2728265449472 found 0000008B wanted 00000017
checksum verify failed on 2728265449472 found 000000B6 wanted 00000000
checksum verify failed on 2728265449472 found 0000008B wanted 00000017
bad tree block 2728265449472, bytenr mismatch, want=3D2728265449472, =
have=3D5440864628575810330
ERROR: failed to read block groups: Input/output error
ERROR: cannot open file system

I tried a restore (with -io options) to at least get as much data as I =
could off just to be safe and it finished but there was a number of =
checksum errors, bad tree block error and loop errors.  So not sure how =
good the backup will be.

Any help would be appreciated.  I have backups so I could format and =
setup the system again, but would rather not if I don=E2=80=99t have =
too.=
