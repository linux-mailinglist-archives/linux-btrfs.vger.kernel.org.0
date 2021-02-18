Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78C6331E45B
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Feb 2021 03:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbhBRCmF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Feb 2021 21:42:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhBRCmE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Feb 2021 21:42:04 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8706BC061574
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Feb 2021 18:41:24 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 75so215653pgf.13
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Feb 2021 18:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=tLv8jxmvRI7Y4yo6leFRHUBSIxciuc7m1nPYq9wEjMU=;
        b=t53hXplok/e0O2Vr8M+S0ZXHrISxgQwPLA6mlQ1J4RKJW+9gNOK0haAlFE1iM3AEvV
         r887xkyaxCPstadMFB065/L0Z0Tj+xLg0OlUsFTKPlKqTu70ep5a/KcMQj2tmvA4WO6z
         S5fW8jCudE88S7GdfenBpYofm9+5/YfyCzrtT36PZmrOkNJVnMlyvBCpWrcebtYYJznz
         vyYfRCrY3p4wHsJCGwVG2PgHecbUqVM8mY6fzoB1qmxDseckjHnVspuf78xL2xS4l4B6
         kP87NuxN/BYDTm5d7UuD2aeav7lg1ebxH2HSe9+zfDgrluh49qBhHPcO9NvCMp/YJ8qf
         yV+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=tLv8jxmvRI7Y4yo6leFRHUBSIxciuc7m1nPYq9wEjMU=;
        b=edJ8XXJYy3Xkd6WsYrXUpeyY8hlzqhJEXM9CbSvqE/qvD0Mnr4P42OO+RG1ie3BbZm
         EtPe6ofBEb4fG6zwhd6p2dH67abaSvGn2PUQGpPD/nIuJdBCnLr3EChUnu1mFAZftARE
         +xip5h6aU8mTE63oFtPFFw6gijDHLdBnBTLcvnmsLiiD2OLX37UcoOSzn6Lw1aAC9Kzx
         1USFqGnlyo9BWprlHup+6o4lmck5+lEY1fpIDw3RExUCvakIOqj4tnbYnNh2ZzDnwRwm
         CMsCkKAwq5+qDMgT0a9X99pij9vO9duU/llQ3oiF/crwNzaz5hk/GuZHp0JIY/zT8bHu
         D52Q==
X-Gm-Message-State: AOAM531d9fQdiLQG80oFEA8i0dQlmPhtwoSxVeAhXBgrtK8WBQCSATA7
        i4Zy4wMef0q1auDbXB6zgPrXy2TmC8o=
X-Google-Smtp-Source: ABdhPJwcoF6OG2jTQ/8sBTviHAAo2+JiLlYlSWM0s+4Zo+lV1dkt8HUAc3GFHnx0l9CNIcnMifZjaQ==
X-Received: by 2002:a62:b416:0:b029:1e4:fb5a:55bb with SMTP id h22-20020a62b4160000b02901e4fb5a55bbmr2124177pfn.80.1613616083445;
        Wed, 17 Feb 2021 18:41:23 -0800 (PST)
Received: from ddawson.local ([2602:ae:1f30:4900:7285:c2ff:fe89:df61])
        by smtp.gmail.com with ESMTPSA id z1sm3756486pfn.101.2021.02.17.18.41.22
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 18:41:22 -0800 (PST)
Received: from localhost.local ([::1] helo=ddawson.local)
        by ddawson.local with esmtp (Exim 4.94)
        (envelope-from <danielcdawson@gmail.com>)
        id 1lCZFk-000TgY-B9
        for linux-btrfs@vger.kernel.org; Wed, 17 Feb 2021 18:41:16 -0800
To:     linux-btrfs@vger.kernel.org
From:   Daniel Dawson <danielcdawson@gmail.com>
Subject: corrupt leaf, unexpected item end, unmountable
Message-ID: <83750bf0-19a8-4f97-155c-b3e36cb227da@gmail.com>
Date:   Wed, 17 Feb 2021 18:41:16 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I was attempting to replace the drives in an array with RAID6 profile.
The first replacement was seemingly successful (and there was a scrub
afterward, with no errors). However, about 0.6% into the second
replacement (sdc), something went wrong, and it went read-only (I should
have copied the log of that somehow). Now it refuses to mount, and a
(readonly) check cannot get started.


# mount -o ro,degraded /dev/sda3 /mnt
mount: /mnt: can't read superblock on /dev/sda3.
# btrfs rescue super-recover /dev/sda3
All supers are valid, no need to recover


For this, dmesg shows:

[=C2=A0 202.675384] BTRFS info (device sdc3): allowing degraded mounts
[=C2=A0 202.675387] BTRFS info (device sdc3): disk space caching is enabl=
ed
[=C2=A0 202.675389] BTRFS info (device sdc3): has skinny extents
[=C2=A0 202.676302] BTRFS warning (device sdc3): devid 3 uuid
911a642e-0a4c-4483-9a1f-cde7b87c5519 is missing
[=C2=A0 202.676601] BTRFS warning (device sdc3): devid 3 uuid
911a642e-0a4c-4483-9a1f-cde7b87c5519 is missing
[=C2=A0 202.985528] BTRFS info (device sdc3): bdev /dev/sdb3 errs: wr 0, =
rd
0, flush 0, corrupt 26, gen 0
[=C2=A0 202.985533] BTRFS info (device sdc3): bdev /dev/sdd3 errs: wr 0, =
rd
0, flush 0, corrupt 98, gen 0
[=C2=A0 203.278131] BTRFS info (device sdc3): start tree-log replay
[=C2=A0 203.454496] BTRFS critical (device sdc3): corrupt leaf: root=3D7
block=3D371567214592 slot=3D0, unexpected item end, have 16315 expect 162=
83
[=C2=A0 203.454499] BTRFS error (device sdc3): block=3D371567214592 read =
time
tree block corruption detected
[=C2=A0 203.454634] BTRFS critical (device sdc3): corrupt leaf: root=3D7
block=3D371567214592 slot=3D0, unexpected item end, have 16315 expect 162=
83
[=C2=A0 203.454636] BTRFS error (device sdc3): block=3D371567214592 read =
time
tree block corruption detected
[=C2=A0 203.455794] BTRFS critical (device sdc3): corrupt leaf: root=3D7
block=3D371567214592 slot=3D0, unexpected item end, have 16315 expect 162=
83
[=C2=A0 203.455796] BTRFS error (device sdc3): block=3D371567214592 read =
time
tree block corruption detected
[=C2=A0 203.455820] BTRFS: error (device sdc3) in __btrfs_free_extent:310=
5:
errno=3D-5 IO failure
[=C2=A0 203.455823] BTRFS: error (device sdc3) in
btrfs_run_delayed_refs:2208: errno=3D-5 IO failure
[=C2=A0 203.455833] BTRFS: error (device sdc3) in btrfs_replay_log:2287:
errno=3D-5 IO failure (Failed to recover log tree)
[=C2=A0 203.747758] BTRFS error (device sdc3): open_ctree failed


I've looked for, but can't find, any bad blocks on the devices. Also, if
it adds any info...

# btrfs check --readonly /dev/sda3
Opening filesystem to check...
warning, device 3 is missing
checksum verify failed on 371587727360 found 000000FF wanted 00000049
checksum verify failed on 371587727360 found 00000005 wanted 00000010
checksum verify failed on 371587727360 found 00000005 wanted 00000010
bad tree block 371587727360, bytenr mismatch, want=3D371587727360,
have=3D1076190010624
ERROR: could not setup extent tree
ERROR: cannot open file system


Note: I'm running this off of System Rescue 7.01, which has earlier
versions of things than what the machine in question has installed (the
latter being Linux 5.10.16, with btrfs-progs v5.10.1).

# uname -a
Linux sysrescue 5.4.78-1-lts #1 SMP Wed, 18 Nov 2020 19:51:49 +0000
x86_64 GNU/Linux
# btrfs --version
btrfs-progs v5.4.1
# btrfs filesystem show
Label: 'vroot2020'=C2=A0 uuid: 5214d903-783a-4d14-ac78-046da5ac1db7
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Total devices 4 FS bytes used =
65.98GiB
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 0 size=
 457.64GiB used 39.53GiB path /dev/sdc3
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 1 size=
 457.64GiB used 39.56GiB path /dev/sda3
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 2 size=
 457.64GiB used 39.56GiB path /dev/sdb3
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 4 size=
 457.64GiB used 39.53GiB path /dev/sdd3

--=20
Skype: fllthdcrb   PGP public key: 0xF7B4422A
PGP fingerprint: 5BBD 5080 FEB0 EF7F 142F  8173 D572 B791 F7B4 422A


