Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5C81B859B
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Apr 2020 12:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbgDYKY2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 25 Apr 2020 06:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726050AbgDYKY1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 25 Apr 2020 06:24:27 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E381C09B04A
        for <linux-btrfs@vger.kernel.org>; Sat, 25 Apr 2020 03:24:27 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id m67so12859169qke.12
        for <linux-btrfs@vger.kernel.org>; Sat, 25 Apr 2020 03:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=m+9VyDUuRx/9GINA7rJQ+EHThQJ/NAsJP+uTxxFvwDs=;
        b=Iy4m3eCW+HxxedTOHuQrCLleuI22TX4pBPQ9zmekwpIbzBFn3u4gALh477FZPbQH+z
         HQl+Xx2k31/c+A/Q6YmHjLYz7TTBbPvreO2QzF4MmRTyoJAJct+dT2rgFWp/nQ7kbbij
         gsf1YsNGh8/UrrUF12a8LQL7/5jDaAwOWnhm+ihhoq4BF8zBc28pB888GqE3unOitYz9
         kL8AW6jYXAp6/Lrleog0jY1Gdjmb93U+/sw+O36w8mqR7UX9LsHiXiVB8mtVOypsHNJe
         BzvTunuMDQNseMaVRo5WBQlPegXuS/6ZI8eZShBUmRKGfUsyOebieHDgcffgniUd1XbT
         yAMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=m+9VyDUuRx/9GINA7rJQ+EHThQJ/NAsJP+uTxxFvwDs=;
        b=LQVT+ZoMLK/PC31d5Tlul9Fni0P8ejQmA7kOdbQvFOQFF6kNCuIDxepD+pSn/Ff3di
         0O3g6glyZi2Ut1doIFIuIbZUZPIzqs4sFqUyz8NCGQy5nxCBOtpUD8owxSFU1HrU+O9Z
         Ye3/8bsrv4isINCMoXAnEXYx2b4IhQCHULh6XiFPIZ7oQIMeSlDevLfREAwFOfo32bRa
         q+exQP44wnvxiA618VauWfapy+o6xaK8DkAaXxxA/vSk3RoYcdWig/n+97xeR5DdWta7
         GVIJi+XGJpaWdTdRaK7IV3UFCV7qRGeFDT9EybrMQAmiETSscOZhSd8xSgjb/TbDp89I
         VzMQ==
X-Gm-Message-State: AGi0PuZRw0GGejOKmnX5RbiDO+cJau20JVHUraeTnzn5Jor+jMHOPAF9
        8JcPq/KPSEWsRyO9pCHdxKtCNNb8mp1rzZj7K+uSDuoi53Q=
X-Google-Smtp-Source: APiQypIkOCHp7n/4UiU+rgEjDtyZ2EYvX5vCDBnwxQJyT5cYt7eYxoNOphTMfWJJNirznf3nf7psW9D8SVycRgs528c=
X-Received: by 2002:a37:9b0a:: with SMTP id d10mr13540285qke.50.1587810266024;
 Sat, 25 Apr 2020 03:24:26 -0700 (PDT)
MIME-Version: 1.0
From:   Yegor Yegorov <gochkin@gmail.com>
Date:   Sat, 25 Apr 2020 13:24:14 +0300
Message-ID: <CAP7ccd__ozu0xvp5yiFW8CuyDBPhD4jOV1auXE5U-z9oBKmn-g@mail.gmail.com>
Subject: Help needed to recover from partition resize/move
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi, I have been stupid enough to try to move and extend my btrfs
partition using a GUI software of my distro. The operation ended with
an error. From the logs of the operation, I understood that the
movement of the partition succeeded, but some finishing operation is
failed. I don't have this log anymore, so I can't provide further
information on that.

Now I ended up with btrfs partition that can't be mounted. Here the
output of the various system and btrfs tools:

$> mount -t btrfs /dev/nvme0n1p3 /mnt/
mount: /mnt/: wrong fs type, bad option, bad superblock on
/dev/nvme0n1p3, missing codepage or helper program, or other error.

$>dmesg | tail
[11637.931751] BTRFS info (device nvme0n1p3): disk space caching is enabled
[11637.931754] BTRFS info (device nvme0n1p3): has skinny extents
[11637.936339] BTRFS error (device nvme0n1p3): bad tree block start,
want 1048576 have 6267530653245814412
[11637.936350] BTRFS error (device nvme0n1p3): failed to read chunk root
[11637.950289] BTRFS error (device nvme0n1p3): open_ctree failed
[11637.950893] audit: type=1106 audit(1587809374.388:663): pid=14229
uid=0 auid=1000 ses=2 msg='op=PAM:session_close
grantors=pam_limits,pam_unix,pam_permit acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/1 res=success'
[11637.951039] audit: type=1104 audit(1587809374.388:664): pid=14229
uid=0 auid=1000 ses=2 msg='op=PAM:setcred
grantors=pam_unix,pam_permit,pam_env acct="root" exe="/usr/bin/sudo"
hostname=? addr=? terminal=/dev/pts/1 res=success'
[11674.981082] audit: type=1101 audit(1587809411.415:665): pid=14277
uid=1000 auid=1000 ses=2 msg='op=PAM:accounting
grantors=pam_unix,pam_permit,pam_time acct="go4a" exe="/usr/bin/sudo"
hostname=? addr=? terminal=/dev/pts/1 res=success'
[11674.981423] audit: type=1110 audit(1587809411.415:666): pid=14277
uid=0 auid=1000 ses=2 msg='op=PAM:setcred
grantors=pam_unix,pam_permit,pam_env acct="root" exe="/usr/bin/sudo"
hostname=? addr=? terminal=/dev/pts/1 res=success'
[11674.985959] audit: type=1105 audit(1587809411.422:667): pid=14277
uid=0 auid=1000 ses=2 msg='op=PAM:session_open
grantors=pam_limits,pam_unix,pam_permit acct="root"
exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/1 res=success'

$> btrfs check /dev/nvme0n1p3
Opening filesystem to check...
checksum verify failed on 1048576 found 00000067 wanted 0000006E
checksum verify failed on 1048576 found 00000067 wanted 0000006E
bad tree block 1048576, bytenr mismatch, want=1048576, have=6267530653245814412
ERROR: cannot read chunk root
ERROR: cannot open file system

$> btrfs restore /dev/nvme0n1p3 /mnt/
checksum verify failed on 1048576 found 00000067 wanted 0000006E
checksum verify failed on 1048576 found 00000067 wanted 0000006E
bad tree block 1048576, bytenr mismatch, want=1048576, have=6267530653245814412
ERROR: cannot read chunk root
Could not open root, trying backup super
checksum verify failed on 1048576 found 00000067 wanted 0000006E
checksum verify failed on 1048576 found 00000067 wanted 0000006E
bad tree block 1048576, bytenr mismatch, want=1048576, have=6267530653245814412
ERROR: cannot read chunk root
Could not open root, trying backup super
ERROR: superblock bytenr 274877906944 is larger than device size 188743680000
Could not open root, trying backup super

$> btrfs rescue chunk-recover /dev/nvme0n1p3
Scanning: DONE in dev0
Check chunks successfully with no orphans
Chunk tree recovered successfully

$>btrfs rescue super-recover /dev/nvme0n1p3
All supers are valid, no need to recover

$>btrfs rescue zero-log /dev/nvme0n1p3
checksum verify failed on 1048576 found 00000067 wanted 0000006E
checksum verify failed on 1048576 found 00000067 wanted 0000006E
bad tree block 1048576, bytenr mismatch, want=1048576, have=6267530653245814412
ERROR: cannot read chunk root
ERROR: could not open ctree

$>btrfs-find-root /dev/nvme0n1p3
WARNING: cannot read chunk root, continue anyway
Superblock thinks the generation is 49
Superblock thinks the level is 1

$>btrfs check --repair /dev/nvme0n1p3
Starting repair.
Opening filesystem to check...
checksum verify failed on 1048576 found 00000067 wanted 0000006E
checksum verify failed on 1048576 found 00000067 wanted 0000006E
bad tree block 1048576, bytenr mismatch, want=1048576, have=6267530653245814412
ERROR: cannot read chunk root
ERROR: cannot open file system


$> btrfs check --repair --init-csum-tree --init-extent-tree /dev/nvme0n1p3
Starting repair.
Opening filesystem to check...
checksum verify failed on 1048576 found 00000067 wanted 0000006E
checksum verify failed on 1048576 found 00000067 wanted 0000006E
bad tree block 1048576, bytenr mismatch, want=1048576, have=6267530653245814412
ERROR: cannot read chunk root
ERROR: cannot open file system




$> uname -a
Linux go4a-HP-Spectre 5.7.0-1-MANJARO #1 SMP PREEMPT Tue Apr 21
20:48:43 UTC 2020 x86_64 GNU/Linux

$> btrfs --version
btrfs-progs v5.6

$>  btrfs fi show
Label: none  uuid: 1e1d4296-9d34-4070-9d8b-18d5dfbad486
        Total devices 1 FS bytes used 85.02GiB
        devid    1 size 97.17GiB used 97.17GiB path /dev/nvme0n1p7

Label: 'data'  uuid: 90e9d74c-3606-4028-9e72-c10e76f44a7c
        Total devices 1 FS bytes used 169.51GiB
        devid    1 size 175.78GiB used 172.02GiB path /dev/nvme0n1p3
