Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 141FA1AB4D3
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Apr 2020 02:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404380AbgDPAcK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Apr 2020 20:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404155AbgDPAcD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Apr 2020 20:32:03 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1FB3C061A0C
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Apr 2020 17:32:02 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id v2so682125plp.9
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Apr 2020 17:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version;
        bh=gnj9iCo7L54WYunG3/3l1pdtUyEGUOMLqw1I52a04zY=;
        b=PDknfNKa5zNauJbFzMQa7Z2qtb90v/ui3OA0/f9/XEXvfQGYSctFLpK7Cb2EFDjrv+
         86ckbohr/ozxAp+iR/7QyGTDALacQJUDdfBGZpKQm6bQ5/5RIC569VRSPahhpJkVIGge
         K9PQNZI7edMux5Vn4Zzj60r03RUYeU3VANTWHsmyE3aVmxAlhcihVWmxyGtCUSjxNOOj
         utYAkNW+OdR2/9+k3afQW7S6V6OgpRpHPk3KZNfxedT8lCr5SQV4yCx8eH18kXfKlI0Y
         mkoHNyGiFsW4dX45FPT6QVXl4lfKdF9X6/Oa5ycvsGTJ0YoFcu+ordsNNO5Ppcsj3dNB
         CBpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version;
        bh=gnj9iCo7L54WYunG3/3l1pdtUyEGUOMLqw1I52a04zY=;
        b=eQ+c6/ZlaTMCxx0nGZDxAJWbpQpMdfDUg1iBmNnw/yo9GGtz5H+vxns+JpIR5ka1KI
         R2A/ZBY+/eTs568FxR6rEmRGghklf1AtCx4R7KdVCyK0xSgwijbUSfv/2lyj1IACn5q3
         8l9bMCc1w5BjdIvUBilLlmeDYiRZV3Gymy7+pNC385PzX5VVZMO3eUyw87jeUc/iXXn5
         g2iTxPoPdjdvTeZAvNg+X03590nDo4bAKsGnfc2YIuZxj5fGqh+Ir7T0mdjMjvq1zBkr
         BxhSWSpD/GLTv5IFuj/xhH8D6fTFDpFT+BOcw7wtyGlZRybYjPDq/PfmXfcQeu9ra7nu
         8lCw==
X-Gm-Message-State: AGi0PuY2nCdzQdUAdxpURypCkjzjDC62bswH/mdqJHf17eKa8PI1fgqU
        P7l9/p6IRmKusdweWc2ZfuZBfB23Mhs=
X-Google-Smtp-Source: APiQypKsWsxeigVobKApffk8IRl7f+pmsyS3ZrVr7t8TU8J9DS9kgze1RchOW1h7nh/9GKytEcHqvw==
X-Received: by 2002:a17:902:d716:: with SMTP id w22mr7662173ply.200.1586997121740;
        Wed, 15 Apr 2020 17:32:01 -0700 (PDT)
Received: from ryzen3950 (c-73-71-89-135.hsd1.ca.comcast.net. [73.71.89.135])
        by smtp.gmail.com with ESMTPSA id a13sm2637992pfo.96.2020.04.15.17.31.59
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 17:32:00 -0700 (PDT)
From:   Matt Huszagh <huszaghmatt@gmail.com>
To:     linux-btrfs@vger.kernel.org
Subject: Backup failing with "failed to clone extents" error
Date:   Wed, 15 Apr 2020 17:31:57 -0700
Message-ID: <87blnsuv7m.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I'm attempting to perform a backup to an external hard drive. Both the
native drive and external drive use a BTRFS filesystem. I do this by
first creating a read-only snapshot of my home directory:

# btrfs subvolume snapshot -r /home /.snapshots/home/BACKUP

Followed by a send/receive to the backup drive:

# btrfs send /.snapshots/home/BACKUP | btrfs receive /.backup/home

I get this output:

At subvol /.snapshots/home/BACKUP
At subvol BACKUP
ERROR: failed to clone extents to matt/.local/share/Anki2/Matt/collection.anki2: Invalid argument

There several files that trigger this error (most of them .sqlite
files). I can delete the offending files, which causes the backup to
work. However, new offending files are created that recreate the error
(e.g. Firefox generates lots of offending .sqlite files).

I performed

# btrfs scrub start -B /

which exited without errors and failed to resolve the issue and I even
ran check --repair on my filesystem unmounted:

# btrfs check --repair /dev/mapper/...

which didn't make a difference.

uname -a:
Linux ryzen3950 5.5.0 #1-NixOS SMP Mon Jan 27 00:23:03 UTC 2020 x86_64 GNU/Linux

btrfs --version
btrfs-progs v5.4.1

btrfs fi show
Label: 'btrfs'  uuid: d31878d6-3a77-4f0f-9fdd-bb9a2c4e578b
        Total devices 2 FS bytes used 737.53GiB
        devid    1 size 931.01GiB used 853.03GiB path /dev/mapper/cryptnvme
        devid    2 size 931.50GiB used 853.03GiB path /dev/mapper/cryptnvme1

Label: 'backup'  uuid: 0bd10808-0330-4736-9425-059d4a0a300e
        Total devices 2 FS bytes used 473.34GiB
        devid    1 size 1.82TiB used 475.01GiB path /dev/mapper/cryptsda1
        devid    2 size 1.82TiB used 475.01GiB path /dev/mapper/cryptsdb1

btrfs fi df /
Data, RAID0: total=1.44TiB, used=730.13GiB
System, RAID1: total=32.00MiB, used=144.00KiB
Metadata, RAID1: total=20.00GiB, used=7.40GiB
GlobalReserve, single: total=512.00MiB, used=0.00B

Here's the output of dmesg. I've only taken the lines containing
dmesg. Please let me know if this is insufficient and I'll provide the
full log.

[    1.168132] stage-1-init: loading module btrfs...
[    1.442869] Btrfs loaded, crc32c=crc32c-intel
[   14.552850] BTRFS: device label backup devid 2 transid 303 /dev/mapper/cryptsdb1 scanned by btrfs (857)
[   14.553396] BTRFS: device label backup devid 1 transid 303 /dev/mapper/cryptsda1 scanned by btrfs (857)
[   14.553487] BTRFS: device label btrfs devid 2 transid 409463 /dev/mapper/cryptnvme1 scanned by btrfs (857)
[   14.553573] BTRFS: device label btrfs devid 1 transid 409463 /dev/mapper/cryptnvme scanned by btrfs (857)
[   14.553634] stage-1-init: Scanning for Btrfs filesystems
[   14.561445] BTRFS info (device dm-0): use lzo compression, level 0
[   14.561447] BTRFS info (device dm-0): enabling ssd optimizations
[   14.561447] BTRFS info (device dm-0): disk space caching is enabled
[   14.561448] BTRFS info (device dm-0): has skinny extents
[   14.637769] BTRFS info (device dm-0): checking UUID tree
[   14.786327] BTRFS info (device dm-0): disk space caching is enabled
[   15.926714] BTRFS info (device dm-0): device fsid d31878d6-3a77-4f0f-9fdd-bb9a2c4e578b devid 1 moved old:/dev/mapper/cryptnvme new:/dev/dm-0
[   15.926763] BTRFS info (device dm-0): device fsid d31878d6-3a77-4f0f-9fdd-bb9a2c4e578b devid 2 moved old:/dev/disk/by-uuid/d31878d6-3a77-4f0f-9fdd-bb9a2c4e578b new:/dev/dm-1
[   16.043567] BTRFS info (device dm-0): disk space caching is enabled
[   16.074722] BTRFS info (device dm-2): use lzo compression, level 0
[   16.074723] BTRFS info (device dm-2): disk space caching is enabled
[   16.074724] BTRFS info (device dm-2): has skinny extents
[27057.785935] BTRFS info (device dm-0): scrub: started on devid 1
[27057.800078] BTRFS info (device dm-0): scrub: started on devid 2
[27107.287558] BTRFS info (device dm-0): scrub: not finished on devid 1 with status: -125
[27107.316437] BTRFS info (device dm-0): scrub: not finished on devid 2 with status: -125
[27109.542589] BTRFS info (device dm-0): scrub: started on devid 1
[27109.556751] BTRFS info (device dm-0): scrub: started on devid 2
[27243.975463] BTRFS info (device dm-0): scrub: finished on devid 1 with status: 0
[27247.857511] BTRFS info (device dm-0): scrub: finished on devid 2 with status: 0
[250470.993201] [  23284]     0 23284     3204       25    45056        0             0 btrfs
[250470.993203] [  23286]     0 23286     1155       53    40960        0             0 btrfs

Thanks!
Matt
