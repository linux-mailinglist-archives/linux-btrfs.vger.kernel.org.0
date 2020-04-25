Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D251D1B893A
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Apr 2020 22:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgDYUF5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 25 Apr 2020 16:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbgDYUF5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 25 Apr 2020 16:05:57 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50FFC09B04D
        for <linux-btrfs@vger.kernel.org>; Sat, 25 Apr 2020 13:05:55 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id x25so15120060wmc.0
        for <linux-btrfs@vger.kernel.org>; Sat, 25 Apr 2020 13:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eA99YnEDPOtzwv689Hbi49Lfo/Gj8daHQF6dVQiqHtA=;
        b=ypCwu79tVo7RTolLaxeBYDRmy+GRnDqTFbsOJoeQMDFnFchbgGVSP8pDaV1G+AOXqa
         8u/DYv8nYKKRZIC2ZQ0bKofhNm+I/Sb0DKVQ6wRCpVa5sLROt6Sb02Te2EQT2PWL4wGn
         rK3apsOxHkx5mCakoiCW3BEwk3SLQECOnhYjOOq/6S79AT2xIkP0N2YCTg4fGBXbfKK8
         i7cPX9VtxRK/AklILm9i8iA4YtBcZ9p56EtEqzPiSO/oQvSj0pamYbqA5WG5ZjyjnbE+
         yO4Yvq1jrvtxaA7eKq0CBkqJgnD6B5PmpRMg9JUEIzEq08E8/tQWd+Es5G0IPS320Bkm
         lo6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eA99YnEDPOtzwv689Hbi49Lfo/Gj8daHQF6dVQiqHtA=;
        b=moW1dJIClBk3OUlQDsI/BWRRRHuKvOsquMRocI32bZH4rs97Nn/Ks8yGavWVzxPpNX
         mzpIxFGqrqqdc+4pZLFMCSW1aHeTFWlQsVEPxDmQu1uv5HFCkpxd2SbfGMwtu5049BvT
         4asCXOfqG7JjXT3UDQQ2HTd/rriBmM+e4avD6HC3lj1raXdmBJ2rbaBC6sDQ5LHpvI5R
         Xyodq9O1LNsK2j195ZjrswE8ILR6W+jmE6ZasqM/yu52M4h3zkll50HwYuBaU9zNFsXq
         KzhijqRRmpIfOEJKaJN6GltcRl6DImIpecpUJ4/ekgMPGm5wOGURJdpw0f3M47j02AYw
         cJbw==
X-Gm-Message-State: AGi0PubHKTr7q/NpDPJbwblhXl7pcx+AKII9849xv4L5O9TiB7z7u6TN
        A3cPNQV2WtrX/3/rsXEGTP7KOsD+oeuwmyvjSWIU0Hx9
X-Google-Smtp-Source: APiQypK/8GeKXcU0Zvukqn1JG20dFJ4vTnQvJcvFdl6UOdCmxITqHArkcC0xZvDS92C/gVcyAru3bwNdewuZUzaqTto=
X-Received: by 2002:a1c:1b0b:: with SMTP id b11mr18219706wmb.182.1587845154504;
 Sat, 25 Apr 2020 13:05:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAP7ccd__ozu0xvp5yiFW8CuyDBPhD4jOV1auXE5U-z9oBKmn-g@mail.gmail.com>
In-Reply-To: <CAP7ccd__ozu0xvp5yiFW8CuyDBPhD4jOV1auXE5U-z9oBKmn-g@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sat, 25 Apr 2020 14:05:38 -0600
Message-ID: <CAJCQCtTdghbU1au1AOpeF2v_YxZoh_d1JZpu2Jf7s_xMdT=+rQ@mail.gmail.com>
Subject: Re: Help needed to recover from partition resize/move
To:     Yegor Yegorov <gochkin@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Apr 25, 2020 at 4:24 AM Yegor Yegorov <gochkin@gmail.com> wrote:
>
> Hi, I have been stupid enough to try to move and extend my btrfs
> partition using a GUI software of my distro. The operation ended with
> an error. From the logs of the operation, I understood that the
> movement of the partition succeeded, but some finishing operation is
> failed. I don't have this log anymore, so I can't provide further
> information on that.
>
> Now I ended up with btrfs partition that can't be mounted. Here the
> output of the various system and btrfs tools:
>
> $> mount -t btrfs /dev/nvme0n1p3 /mnt/
> mount: /mnt/: wrong fs type, bad option, bad superblock on
> /dev/nvme0n1p3, missing codepage or helper program, or other error.
>
> $>dmesg | tail
> [11637.931751] BTRFS info (device nvme0n1p3): disk space caching is enabled
> [11637.931754] BTRFS info (device nvme0n1p3): has skinny extents
> [11637.936339] BTRFS error (device nvme0n1p3): bad tree block start,
> want 1048576 have 6267530653245814412
> [11637.936350] BTRFS error (device nvme0n1p3): failed to read chunk root
> [11637.950289] BTRFS error (device nvme0n1p3): open_ctree failed
> [11637.950893] audit: type=1106 audit(1587809374.388:663): pid=14229
> uid=0 auid=1000 ses=2 msg='op=PAM:session_close
> grantors=pam_limits,pam_unix,pam_permit acct="root"
> exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/1 res=success'
> [11637.951039] audit: type=1104 audit(1587809374.388:664): pid=14229
> uid=0 auid=1000 ses=2 msg='op=PAM:setcred
> grantors=pam_unix,pam_permit,pam_env acct="root" exe="/usr/bin/sudo"
> hostname=? addr=? terminal=/dev/pts/1 res=success'
> [11674.981082] audit: type=1101 audit(1587809411.415:665): pid=14277
> uid=1000 auid=1000 ses=2 msg='op=PAM:accounting
> grantors=pam_unix,pam_permit,pam_time acct="go4a" exe="/usr/bin/sudo"
> hostname=? addr=? terminal=/dev/pts/1 res=success'
> [11674.981423] audit: type=1110 audit(1587809411.415:666): pid=14277
> uid=0 auid=1000 ses=2 msg='op=PAM:setcred
> grantors=pam_unix,pam_permit,pam_env acct="root" exe="/usr/bin/sudo"
> hostname=? addr=? terminal=/dev/pts/1 res=success'
> [11674.985959] audit: type=1105 audit(1587809411.422:667): pid=14277
> uid=0 auid=1000 ses=2 msg='op=PAM:session_open
> grantors=pam_limits,pam_unix,pam_permit acct="root"
> exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/1 res=success'
>
> $> btrfs check /dev/nvme0n1p3
> Opening filesystem to check...
> checksum verify failed on 1048576 found 00000067 wanted 0000006E
> checksum verify failed on 1048576 found 00000067 wanted 0000006E
> bad tree block 1048576, bytenr mismatch, want=1048576, have=6267530653245814412
> ERROR: cannot read chunk root
> ERROR: cannot open file system
>
> $> btrfs restore /dev/nvme0n1p3 /mnt/
> checksum verify failed on 1048576 found 00000067 wanted 0000006E
> checksum verify failed on 1048576 found 00000067 wanted 0000006E
> bad tree block 1048576, bytenr mismatch, want=1048576, have=6267530653245814412
> ERROR: cannot read chunk root
> Could not open root, trying backup super
> checksum verify failed on 1048576 found 00000067 wanted 0000006E
> checksum verify failed on 1048576 found 00000067 wanted 0000006E
> bad tree block 1048576, bytenr mismatch, want=1048576, have=6267530653245814412
> ERROR: cannot read chunk root
> Could not open root, trying backup super
> ERROR: superblock bytenr 274877906944 is larger than device size 188743680000


This suggests the partition was changed (shrunk) before the file
system shrink had succeeded; or that the partition was changed even
after file system shrink failed. At this point it's required to make
no changes to the file system, including repairs, until the partition
size matches the file system size as reported by the superblock.


> Could not open root, trying backup super
>
> $> btrfs rescue chunk-recover /dev/nvme0n1p3
> Scanning: DONE in dev0
> Check chunks successfully with no orphans
> Chunk tree recovered successfully


My suspicion is this might have made things worse. I don't see how
chunk-recover can do the right thing, if the partition is wrong. And
further I think that all of the Btrfs tools should do an early check
that the partition size matches file system size, and if that fails,
it should warn and stop.



>
> $>btrfs rescue super-recover /dev/nvme0n1p3
> All supers are valid, no need to recover

True only in the narrow case that their checksum matches contents,
sanity tests, and they match each other. But I still think even this
tool should confirm/deny the very basic thing: partition size (or
block device size) matches file system size.


>
> $>btrfs rescue zero-log /dev/nvme0n1p3
> checksum verify failed on 1048576 found 00000067 wanted 0000006E
> checksum verify failed on 1048576 found 00000067 wanted 0000006E
> bad tree block 1048576, bytenr mismatch, want=1048576, have=6267530653245814412
> ERROR: cannot read chunk root
> ERROR: could not open ctree

OK sorry but now you're just throwing spaghetti at a wall. It's
desperation, which is a great way to cause further damage to a file
system. Fortunately the log is not critical, it just means it's
possible to lose the most recent data being written and fsync'd.



>
> $>btrfs-find-root /dev/nvme0n1p3
> WARNING: cannot read chunk root, continue anyway
> Superblock thinks the generation is 49
> Superblock thinks the level is 1
>
> $>btrfs check --repair /dev/nvme0n1p3
> Starting repair.
> Opening filesystem to check...
> checksum verify failed on 1048576 found 00000067 wanted 0000006E
> checksum verify failed on 1048576 found 00000067 wanted 0000006E
> bad tree block 1048576, bytenr mismatch, want=1048576, have=6267530653245814412
> ERROR: cannot read chunk root
> ERROR: cannot open file system

The want and have are way far apart, the file system is damaged. And I
don't see how it can be fixed when the partition is smaller than the
file system. Too much is missing and repair is impossible.

Doing a repair in this case will make things worse. But again, I argue
check even with --repair should quickly fail if there's a block device
size and file system size mismatch, specifically the case where block
device size is smaller than file system size, as in this case.


> $> btrfs check --repair --init-csum-tree --init-extent-tree /dev/nvme0n1p3
> Starting repair.
> Opening filesystem to check...
> checksum verify failed on 1048576 found 00000067 wanted 0000006E
> checksum verify failed on 1048576 found 00000067 wanted 0000006E
> bad tree block 1048576, bytenr mismatch, want=1048576, have=6267530653245814412
> ERROR: cannot read chunk root
> ERROR: cannot open file system

The heavy hammer. Again, likely to make things worse, but luckily it
can't find enough to proceed with the repair.

You need to fix the partition/filesystem size mismatch first.

fdisk -l /dev/sda
btrfs insp dump-s /dev/sdaN

where N is the partition for this file system


-- 
Chris Murphy
