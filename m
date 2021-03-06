Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A640632F918
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Mar 2021 10:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbhCFJKk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 6 Mar 2021 04:10:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhCFJKY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 6 Mar 2021 04:10:24 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3540C06175F
        for <linux-btrfs@vger.kernel.org>; Sat,  6 Mar 2021 01:10:23 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id f12so4961280wrx.8
        for <linux-btrfs@vger.kernel.org>; Sat, 06 Mar 2021 01:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Na8K6Uiug0mVMoyHO9Ot2LB/3sa0cTLsqJNvA6Bg3+4=;
        b=FYs+LZc5RPx0kNt/oSkrsTfbbI9YNSpb98YIBh4+BTnAM4QEOIKX9ODeywGTXHRBez
         MkfX9Rsqb27XK/ttWNKpFoTAi7+mCCkGz8MRCz9l0xtX1X+DeH7kQiTbg/di/1wJr7yv
         3hd4JA1edBMxHMyDUCcJqXbJtdEcKimZiNrQ2FZeKbYpiBRaJ35i7Eh38KbLjgq/hvdC
         Au3bfOsgItdBqfRh+L6u0JD2hTV7lB5H621PE05L5eCNWTCuPtanXjBQVKqD43Fyq7U/
         BZEfenjno63GN/aYBWUnZCD+wggtMY0r4c7yT+5VFDR1le90TwEFimxyMkeGdWr8sEvY
         MbrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Na8K6Uiug0mVMoyHO9Ot2LB/3sa0cTLsqJNvA6Bg3+4=;
        b=PJQChAt4PJH/mwYrGPNz+VUncN6SqsD4ghqbPlT0VQdArG5Iz9TanUHn+J/DA4xUto
         ijGv6zGXBAzrPfMEnwIlEO9z3GUZCj2w2r1ZpT3zyua7pXWfexYQL+hKI3YsL/VXGVp8
         O6Hy5vWfEuEUqP7Jtptbr1eri6Fnr3v/VMa/oev/pyE6qzxGWdOVQj2P8mtbX12x8RLM
         ueNcAdC1GkT2DdGOItdQncfS3FEv002wKnySkzBKZ2MRPD5UkI8nettADni+/gyM0hH+
         avqtrxumlPyzLGevm4h9wzV2mN0nvdMhhMsz4GKnRrQ7lDumzgvZmPrSY2qE15C5w7Qx
         m03A==
X-Gm-Message-State: AOAM531SwQUkQKKYZ0AleQzwJ9lnk8HsgJuRodFTsuQqj7tRwcAidDiy
        Q/Tni93ooHGtiO/LUAfrU3FmQ3QQufXfOviRAPD7ABXMpD8=
X-Google-Smtp-Source: ABdhPJxchznHNMhdj7SxXCVILx5VUkDK2CfBT9OG2EB99PIlOk+l45ozkLswHdBga/+MKqx5jEXMHGgp5mR0MlGzQR0=
X-Received: by 2002:a5d:6446:: with SMTP id d6mr13165963wrw.328.1615021822318;
 Sat, 06 Mar 2021 01:10:22 -0800 (PST)
MIME-Version: 1.0
From:   chil L1n <devchill1n@gmail.com>
Date:   Sat, 6 Mar 2021 10:10:11 +0100
Message-ID: <CABBhR_6Y=H6Eujw51xkt6_fjAQFjdcp5trVgjtbrNf9iMDxZ0g@mail.gmail.com>
Subject: btrfs error: write time tree block corruption detected
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

Just noticed that one of my btrfs mounts on a server was in read-only mode.

dmesg shows:
[2217355.427810] BTRFS info (device sda3): scrub: started on devid 1
[2221262.216646] BTRFS info (device sda3): scrub: finished on devid 1
with status: 0
[2390153.679168] BTRFS info (device sda4): scrub: started on devid 1
[2393339.627095] BTRFS info (device sda4): scrub: finished on devid 1
with status: 0
[2555511.868642] BTRFS critical (device sda4): corrupt leaf: root=258
block=250975895552 slot=78, bad key order, prev (256703 108 3276800)
current (256703 108 1310720)
[2555511.868650] BTRFS error (device sda4): block=250975895552 write
time tree block corruption detected
[2555511.916529] BTRFS: error (device sda4) in
btrfs_commit_transaction:2279: errno=-5 IO failure (Error while
writing out transaction)
[2555511.916544] BTRFS info (device sda4): forced readonly
[2555511.916547] BTRFS warning (device sda4): Skipping commit of
aborted transaction.
[2555511.916551] BTRFS: error (device sda4) in
cleanup_transaction:1832: errno=-5 IO failure
[2555511.916560] BTRFS info (device sda4): delayed_refs has NO entry
[2555511.916687] BTRFS info (device sda4): delayed_refs has NO entry

Running "btrfs check" shows no further issues:

sudo btrfs check --force --readonly /dev/sda4
Opening filesystem to check...
WARNING: filesystem mounted, continuing because of --force
Checking filesystem on /dev/sda4
UUID: 72deb54c-96dd-42cf-a809-bef1a135f409
[1/7] checking root items
[2/7] checking extents
[3/7] checking free space cache
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups skipped (not enabled on this FS)
found 242436075520 bytes used, no error found
total csum bytes: 235186808
total tree bytes: 961773568
total fs tree bytes: 665829376
total extent tree bytes: 43728896
btree space waste bytes: 122086726
file data blocks allocated: 447700926464
 referenced 257665265664

Kernel:
Linux amd8 5.4.0-65-generic #73-Ubuntu SMP Mon Jan 18 17:25:17 UTC
2021 x86_64 x86_64 x86_64 GNU/Linux

Can someone help me to pinpoint the cause of this issue and prevent it
from happening again?
If more info is needed from my side, please let me know.

Cheers,

chill
