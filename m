Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A075344C1
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 May 2022 22:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233881AbiEYURG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 May 2022 16:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345360AbiEYUPh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 May 2022 16:15:37 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15EACBE07
        for <linux-btrfs@vger.kernel.org>; Wed, 25 May 2022 13:15:33 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-3003cb4e064so53956777b3.3
        for <linux-btrfs@vger.kernel.org>; Wed, 25 May 2022 13:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=2l6BSzDjAGPpF/ceeq5SPip6R9J2pSYTg3oFPWLdoQM=;
        b=OSNchd5PcI3haN3cTDaJwxnquPlNX6qnvLgH5QbIFfUV4iysrU4QfLmvGF7NKb8+b/
         1TFB80Pcjhizq+d67Z4Z4htOqUksIdhstHlPbc9G2pLReMP7uqiKSPre9GSPCtzx86iN
         vmm50gV0TSREL2JnfTKM95gDPb0veAVGa+PgT5msg5ep0r0+laU5vnyuXvEx2G9FpbaI
         ejuJxQhbl3sW3UEH0jeG8l9CwigF/twPh9UfeTvh+fy6iCXV5FYi9K8cOoAZOUrKtDvc
         GWCp02fKBlQ5KbHyIRfiLg9oiUhVhnEuJSRLVg9Bl05VH+YCe48Cv7EQDBwQrQFZsfIm
         R8gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=2l6BSzDjAGPpF/ceeq5SPip6R9J2pSYTg3oFPWLdoQM=;
        b=HZUfDdGutKCxiTZZ83TSoOQZQtF24PhDTIMTFDIJCoA/MCWyBBvuzkDjSknWbgdsN5
         DNgvcbMDw+Elp3oZ3LtbP1zBgxTqIIzcoXQjrSlca1G8l8y7aHej9JIMsSDT1dGLHiEB
         VrkmwUy3QCot3sBfeepgtcVXz8jLOUvh/ClSBQrKVWVEf8eSdWhX6KMpUIqlDyOIOn4v
         FN0EBxxfFGDVEPNu1W0nS9I3KflWvel4In2QbcbVcoJvqIsHPxT65tkdgR/HkwcBGFGn
         CrVjuCdX8PLBK/zky5rapHiIwiU8MQp/XPXdSfhylyV0Z02q9xcU3iWc8olSZsCREMcb
         1iTw==
X-Gm-Message-State: AOAM533yqvg14aqcpHNYxdSrT7XXFVWpr7ioXT7Z/6B7+PAEA+E2gfGu
        FptQZHy/k+jIrw9GKoW2mNJs/01xcanF9UKWdUisdSOtoHc=
X-Google-Smtp-Source: ABdhPJwesRUCVRF1AYPLXOhA0IlwxFTf9t+QgX3Oe5XxbKacKsiiuOJNwIOPRPvIyiD6XUg9VpJsV/ck1V7ypUribb8=
X-Received: by 2002:a81:1f89:0:b0:2f7:c6bc:9680 with SMTP id
 f131-20020a811f89000000b002f7c6bc9680mr36531240ywf.234.1653509731831; Wed, 25
 May 2022 13:15:31 -0700 (PDT)
MIME-Version: 1.0
From:   Nathan Henrie <n8henrie@gmail.com>
Date:   Wed, 25 May 2022 14:14:55 -0600
Message-ID: <CAOMt5FCSFC8d-cioM39wZ3jME9+5=C4P8omZOfmQz34P9a8MdA@mail.gmail.com>
Subject: Quota consistently brings machine to a crawl
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

I've been using BTRFS root (BTRFS RAID1) on a reasonably powerful
Linux machine for a couple of years now, and I've generally been very
happy with it. The only persistent issue that I can't seem to resolve
is that the entire system consistently slows to a complete crawl
(several minutes to register keystrokes) if I enable quota.

I use snapper for automated snapshots, and thinking that the number of
snapshots may be the issue, I've increased the cleanup frequency to
hourly and reduced the total number to <100 at all times.

```
$ sudo btrfs subvol list -s / | wc -l
89
```

However, the issue persists. A little conversation on number of
snapshots: https://www.reddit.com/r/btrfs/comments/tiqkh2/how_many_snapshots_are_too_many_with_quotas/

My mount options are:
`noatime,discard=async,autodefrag,compress-force=zstd:1,subvol=@`

My machine is a Ryzen threadripper with 128G RAM, across 3 NVME drives
as BTRFS RAID1.

```
$ uname -a
Linux n8machine 5.17.7-arch1-2 #1 SMP PREEMPT Sun, 15 May 2022
05:00:14 +0000 x86_64 GNU/Linux
$ btrfs --version
btrfs-progs v5.17
$ sudo btrfs fi show
Label: 'Arch Linux' uuid: 0507d652-8d7a-4897-a843-2fb170634055
           Total devices 3 FS bytes used 612.94GiB
           devid 1 size 931.01GiB used 582.00GiB path /dev/nvme0n1p1
           devid 3 size 418.00GiB used 69.03GiB path /dev/nvme2n1p1
           devid 4 size 931.51GiB used 583.03GiB path /dev/nvme1n1
$ sudo btrfs fi df /
Data, RAID1: total=573.00GiB, used=570.19GiB
System, RAID1: total=32.00MiB, used=128.00KiB
Metadata, RAID1: total=44.00GiB, used=42.75GiB
GlobalReserve, single: total=512.00MiB, used=0.00B
$ sudo dmesg | grep -i btrfs
[649854.872742] audit: type=1130 audit(1653481410.602:7814): pid=1
uid=0 auid=4294967295 ses=4294967295 msg='unit=grub-btrfs
comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=?
terminal=? res=success' [649854.872749] audit: type=1131
audit(1653481410.602:7815): pid=1 uid=0 auid=4294967295 ses=4294967295
msg='unit=grub-btrfs comm="systemd" exe="/usr/lib/systemd/systemd"
hostname=? addr=? terminal=? res=success' [652048.645431] audit:
type=1130 audit(1653483604.377:7830): pid=1 uid=0 auid=4294967295
ses=4294967295 msg='unit=grub-btrfs comm="systemd"
exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=?
res=success' [652048.645438] audit: type=1131
audit(1653483604.377:7831): pid=1 uid=0 auid=4294967295 ses=4294967295
msg='unit=grub-btrfs comm="systemd" exe="/usr/lib/systemd/systemd"
hostname=? addr=? terminal=? res=success' [653331.753733] BTRFS:
device label NIXOS_SD devid 1 transid 7 /dev/loop1p3 scanned by mount
(3237081) [653331.760159] BTRFS info (device loop1p3): flagging fs
with big metadata feature [653331.760166] BTRFS info (device loop1p3):
enabling ssd optimizations [653331.760168] BTRFS info (device
loop1p3): using spread ssd allocation scheme [653331.760172] BTRFS
info (device loop1p3): enabling free space tree [653331.760174] BTRFS
info (device loop1p3): using free space tree [653331.760175] BTRFS
info (device loop1p3): has skinny extents [653331.768221] BTRFS info
(device loop1p3): creating free space tree [653331.771396] BTRFS info
(device loop1p3): setting compat-ro feature flag for FREE_SPACE_TREE
(0x1) [653331.771400] BTRFS info (device loop1p3): setting compat-ro
feature flag for FREE_SPACE_TREE_VALID (0x2) [653331.902916] BTRFS
info (device loop1p3): cleaning free space cache v1 [653331.980709]
BTRFS info (device loop1p3): checking UUID tree [653332.061223] BTRFS
info (device loop1p3): resize device /dev/loop1p3 (devid 1) from
3352297472 to 4426039296 [653343.373112] BTRFS warning: duplicate
device /dev/sde3 devid 1 generation 154 scanned by systemd-udevd
(3237098) [653344.276810] BTRFS info (device loop1p3): flagging fs
with big metadata feature [653344.276817] BTRFS info (device loop1p3):
enabling ssd optimizations [653344.276819] BTRFS info (device
loop1p3): using spread ssd allocation scheme [653344.276822] BTRFS
info (device loop1p3): using free space tree [653344.276823] BTRFS
info (device loop1p3): has skinny extents [653455.859628] audit:
type=1130 audit(1653485011.610:7859): pid=1 uid=0 auid=4294967295
ses=4294967295 msg='unit=grub-btrfs comm="systemd"
exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=?
res=success' [653455.859640] audit: type=1131
audit(1653485011.610:7860): pid=1 uid=0 auid=4294967295 ses=4294967295
msg='unit=grub-btrfs comm="systemd" exe="/usr/lib/systemd/systemd"
hostname=? addr=? terminal=? res=success' [655648.680024] audit:
type=1130 audit(1653487204.432:7877): pid=1 uid=0 auid=4294967295
ses=4294967295 msg='unit=grub-btrfs comm="systemd"
exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=?
res=success' [655648.680032] audit: type=1131
audit(1653487204.432:7878): pid=1 uid=0 auid=4294967295 ses=4294967295
msg='unit=grub-btrfs comm="systemd" exe="/usr/lib/systemd/systemd"
hostname=? addr=? terminal=? res=success' [655661.645800] BTRFS:
device label NIXOS_SD devid 1 transid 7 /dev/loop1p3 scanned by mount
(3296995) [655661.652011] BTRFS info (device loop1p3): flagging fs
with big metadata feature [655661.652017] BTRFS info (device loop1p3):
enabling ssd optimizations [655661.652020] BTRFS info (device
loop1p3): using spread ssd allocation scheme [655661.652023] BTRFS
info (device loop1p3): enabling free space tree [655661.652026] BTRFS
info (device loop1p3): using free space tree [655661.652027] BTRFS
info (device loop1p3): has skinny extents [655661.659897] BTRFS info
(device loop1p3): creating free space tree [655661.662665] BTRFS info
(device loop1p3): setting compat-ro feature flag for FREE_SPACE_TREE
(0x1) [655661.662670] BTRFS info (device loop1p3): setting compat-ro
feature flag for FREE_SPACE_TREE_VALID (0x2) [655661.977751] BTRFS
info (device loop1p3): cleaning free space cache v1 [655662.148361]
BTRFS info (device loop1p3): checking UUID tree [655662.321729] BTRFS
info (device loop1p3): resize device /dev/loop1p3 (devid 1) from
3352297472 to 4426039296 [655675.379516] BTRFS info (device loop1p3):
flagging fs with big metadata feature [655675.379524] BTRFS info
(device loop1p3): enabling ssd optimizations [655675.379526] BTRFS
info (device loop1p3): using spread ssd allocation scheme
[655675.379530] BTRFS info (device loop1p3): using free space tree
[655675.379532] BTRFS info (device loop1p3): has skinny extents
[655798.563024] BTRFS: device label NIXOS_SD devid 1 transid 7
/dev/loop1p3 scanned by mount (3300821) [655798.569517] BTRFS info
(device loop1p3): flagging fs with big metadata feature
[655798.569525] BTRFS info (device loop1p3): enabling ssd
optimizations [655798.569527] BTRFS info (device loop1p3): using
spread ssd allocation scheme [655798.569532] BTRFS info (device
loop1p3): enabling free space tree [655798.569534] BTRFS info (device
loop1p3): using free space tree [655798.569536] BTRFS info (device
loop1p3): has skinny extents [655798.578555] BTRFS info (device
loop1p3): creating free space tree [655798.581715] BTRFS info (device
loop1p3): setting compat-ro feature flag for FREE_SPACE_TREE (0x1)
[655798.581719] BTRFS info (device loop1p3): setting compat-ro feature
flag for FREE_SPACE_TREE_VALID (0x2) [655798.737827] BTRFS info
(device loop1p3): cleaning free space cache v1 [655798.764508] BTRFS
info (device loop1p3): checking UUID tree [655798.794795] BTRFS info
(device loop1p3): resize device /dev/loop1p3 (devid 1) from 3352297472
to 4426039296 [655809.880095] BTRFS info (device loop1p3): flagging fs
with big metadata feature [655809.880104] BTRFS info (device loop1p3):
enabling ssd optimizations [655809.880106] BTRFS info (device
loop1p3): using spread ssd allocation scheme [655809.880110] BTRFS
info (device loop1p3): using free space tree [655809.880111] BTRFS
info (device loop1p3): has skinny extents [657063.131573] audit:
type=1130 audit(1653488618.896:7945): pid=1 uid=0 auid=4294967295
ses=4294967295 msg='unit=grub-btrfs comm="systemd"
exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=?
res=success' [657063.131583] audit: type=1131
audit(1653488618.899:7946): pid=1 uid=0 auid=4294967295 ses=4294967295
msg='unit=grub-btrfs comm="systemd" exe="/usr/lib/systemd/systemd"
hostname=? addr=? terminal=? res=success' [659255.485198] audit:
type=1130 audit(1653490811.280:7961): pid=1 uid=0 auid=4294967295
ses=4294967295 msg='unit=grub-btrfs comm="systemd"
exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=?
res=success' [659255.485205] audit: type=1131
audit(1653490811.280:7962): pid=1 uid=0 auid=4294967295 ses=4294967295
msg='unit=grub-btrfs comm="systemd" exe="/usr/lib/systemd/systemd"
hostname=? addr=? terminal=? res=success' [660665.821187] audit:
type=1130 audit(1653492221.609:7980): pid=1 uid=0 auid=4294967295
ses=4294967295 msg='unit=grub-btrfs comm="systemd"
exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=?
res=success' [660665.821200] audit: type=1131
audit(1653492221.609:7981): pid=1 uid=0 auid=4294967295 ses=4294967295
msg='unit=grub-btrfs comm="systemd" exe="/usr/lib/systemd/systemd"
hostname=? addr=? terminal=? res=success' [662860.351399] audit:
type=1130 audit(1653494416.155:7996): pid=1 uid=0 auid=4294967295
ses=4294967295 msg='unit=grub-btrfs comm="systemd"
exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=?
res=success' [662860.351407] audit: type=1131
audit(1653494416.155:7997): pid=1 uid=0 auid=4294967295 ses=4294967295
msg='unit=grub-btrfs comm="systemd" exe="/usr/lib/systemd/systemd"
hostname=? addr=? terminal=? res=success' [664268.696715] audit:
type=1130 audit(1653495824.532:8015): pid=1 uid=0 auid=4294967295
ses=4294967295 msg='unit=grub-btrfs comm="systemd"
exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=?
res=success' [664268.696728] audit: type=1131
audit(1653495824.532:8016): pid=1 uid=0 auid=4294967295 ses=4294967295
msg='unit=grub-btrfs comm="systemd" exe="/usr/lib/systemd/systemd"
hostname=? addr=? terminal=? res=success' [666455.434235] audit:
type=1130 audit(1653498011.262:8031): pid=1 uid=0 auid=4294967295
ses=4294967295 msg='unit=grub-btrfs comm="systemd"
exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=?
res=success' [666455.434242] audit: type=1131
audit(1653498011.262:8032): pid=1 uid=0 auid=4294967295 ses=4294967295
msg='unit=grub-btrfs comm="systemd" exe="/usr/lib/systemd/systemd"
hostname=? addr=? terminal=? res=success' [667871.982919] audit:
type=1130 audit(1653499427.830:8050): pid=1 uid=0 auid=4294967295
ses=4294967295 msg='unit=grub-btrfs comm="systemd"
exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=?
res=success' [667871.982926] audit: type=1131
audit(1653499427.830:8051): pid=1 uid=0 auid=4294967295 ses=4294967295
msg='unit=grub-btrfs comm="systemd" exe="/usr/lib/systemd/systemd"
hostname=? addr=? terminal=? res=success' [670052.877326] audit:
type=1130 audit(1653501608.743:8065): pid=1 uid=0 auid=4294967295
ses=4294967295 msg='unit=grub-btrfs comm="systemd"
exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=?
res=success' [670052.877335] audit: type=1131
audit(1653501608.743:8066): pid=1 uid=0 auid=4294967295 ses=4294967295
msg='unit=grub-btrfs comm="systemd" exe="/usr/lib/systemd/systemd"
hostname=? addr=? terminal=? res=success' [671474.908959] audit:
type=1130 audit(1653503030.786:8111): pid=1 uid=0 auid=4294967295
ses=4294967295 msg='unit=grub-btrfs comm="systemd"
exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=?
res=success' [671474.908968] audit: type=1131
audit(1653503030.786:8112): pid=1 uid=0 auid=4294967295 ses=4294967295
msg='unit=grub-btrfs comm="systemd" exe="/usr/lib/systemd/systemd"
hostname=? addr=? terminal=? res=success' [673667.158937] audit:
type=1130 audit(1653505223.038:8126): pid=1 uid=0 auid=4294967295
ses=4294967295 msg='unit=grub-btrfs comm="systemd"
exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=?
res=success' [673667.158950] audit: type=1131
audit(1653505223.038:8127): pid=1 uid=0 auid=4294967295 ses=4294967295
msg='unit=grub-btrfs comm="systemd" exe="/usr/lib/systemd/systemd"
hostname=? addr=? terminal=? res=success' [675077.960417] audit:
type=1130 audit(1653506633.852:8146): pid=1 uid=0 auid=4294967295
ses=4294967295 msg='unit=grub-btrfs comm="systemd"
exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=?
res=success' [675077.960427] audit: type=1131
audit(1653506633.852:8147): pid=1 uid=0 auid=4294967295 ses=4294967295
msg='unit=grub-btrfs comm="systemd" exe="/usr/lib/systemd/systemd"
hostname=? addr=? terminal=? res=success' [677264.824892] audit:
type=1130 audit(1653508820.737:8173): pid=1 uid=0 auid=4294967295
ses=4294967295 msg='unit=grub-btrfs comm="systemd"
exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=?
res=success' [677264.824903] audit: type=1131
audit(1653508820.737:8174): pid=1 uid=0 auid=4294967295 ses=4294967295
msg='unit=grub-btrfs comm="systemd" exe="/usr/lib/systemd/systemd"
hostname=? addr=? terminal=? res=success'
```

(The messages about the loop devices have to do with a separate issue,
having trouble booting (u-boot) a NixOS-based Raspberry Pi from a
compressed subvolume:
https://lists.denx.de/pipermail/u-boot/2022-May/484855.html )

The machine has no issues with a `balance --full-blance`, and `btrfs
check` and `scrub` all complete without errors.
If I disable quotas, it runs perfectly.

When I enable quotas, it runs for a few days until it starts locking
up and lagging, with `btrfs-transacti` taking up 100% CPU.

I've enabled and subsequently disabled quota support at least a dozen
times now, hoping I can get it working reliably (especially in order
to leverage snapper's quota-based cleanup algorithms to help avoid
unanticipated out-of-space issues). Is there anything obvious in my
setup or configuration that seems problematic? For example, I've
specifically wondered about whether `autodefrag` could be breaking COW
and causing the snapper cleanups to be more resource-intensive, but
removing `autodefrag` didn't seem to noticeably change things a few
months ago.

Many thanks in advance for your attention and any suggestions.

Nate
