Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 744A63CB95A
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Jul 2021 17:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237326AbhGPPI6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Jul 2021 11:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237590AbhGPPI6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Jul 2021 11:08:58 -0400
Received: from mail.lichtvoll.de (lichtvoll.de [IPv6:2001:67c:14c:12f::11:100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E73BC06175F
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Jul 2021 08:06:03 -0700 (PDT)
Received: from ananda.localnet (unknown [IPv6:2001:a62:1a32:4600:ff4b:9862:35d:64af])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id B113E28A32E
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Jul 2021 17:06:00 +0200 (CEST)
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     linux-btrfs@vger.kernel.org
Subject: Corruption errors on Samsung 980 Pro
Date:   Fri, 16 Jul 2021 17:05:59 +0200
Message-ID: <2729231.WZja5ltl65@ananda>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin2 smtp.mailfrom=martin@lichtvoll.de
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello.

I migrated to a different laptop and this one has a 2TB Samsung 980 Pro drive
(not a 2TB Samsung 870 Evo Plus which previously had problems).

I thought this time I would be fine, but I just got:

[63168.287911] BTRFS warning (device dm-3): csum failed root 1372 ino 2295743 off 2718461952 csum 0x48be03222606a29d expected csum 0x0100000026004000 mirror 1
[63168.287925] BTRFS error (device dm-3): bdev /dev/mapper/nvme-home errs: wr 0, rd 0, flush 0, corrupt 1, gen 0
[63168.346552] BTRFS warning (device dm-3): csum failed root 1372 ino 2295743 off 2718461952 csum 0x48be03222606a29d expected csum 0x0100000026004000 mirror 1
[63168.346567] BTRFS error (device dm-3): bdev /dev/mapper/nvme-home errs: wr 0, rd 0, flush 0, corrupt 2, gen 0
[63168.346685] BTRFS warning (device dm-3): csum failed root 1372 ino 2295743 off 2718461952 csum 0x48be03222606a29d expected csum 0x0100000026004000 mirror 1
[63168.346708] BTRFS error (device dm-3): bdev /dev/mapper/nvme-home errs: wr 0, rd 0, flush 0, corrupt 3, gen 0
[63168.346859] BTRFS warning (device dm-3): csum failed root 1372 ino 2295743 off 2718461952 csum 0x48be03222606a29d expected csum 0x0100000026004000 mirror 1
[63168.346873] BTRFS error (device dm-3): bdev /dev/mapper/nvme-home errs: wr 0, rd 0, flush 0, corrupt 4, gen 0
[63299.490367] BTRFS warning (device dm-3): csum failed root 1372 ino 2295743 off 2718461952 csum 0x48be03222606a29d expected csum 0x0100000026004000 mirror 1
[63299.490384] BTRFS error (device dm-3): bdev /dev/mapper/nvme-home errs: wr 0, rd 0, flush 0, corrupt 5, gen 0
[63299.572849] BTRFS warning (device dm-3): csum failed root 1372 ino 2295743 off 2718461952 csum 0x48be03222606a29d expected csum 0x0100000026004000 mirror 1
[63299.572866] BTRFS error (device dm-3): bdev /dev/mapper/nvme-home errs: wr 0, rd 0, flush 0, corrupt 6, gen 0
[63299.573151] BTRFS warning (device dm-3): csum failed root 1372 ino 2295743 off 2718461952 csum 0x48be03222606a29d expected csum 0x0100000026004000 mirror 1
[63299.573168] BTRFS error (device dm-3): bdev /dev/mapper/nvme-home errs: wr 0, rd 0, flush 0, corrupt 7, gen 0
[63299.573286] BTRFS warning (device dm-3): csum failed root 1372 ino 2295743 off 2718461952 csum 0x48be03222606a29d expected csum 0x0100000026004000 mirror 1
[63299.573295] BTRFS error (device dm-3): bdev /dev/mapper/nvme-home errs: wr 0, rd 0, flush 0, corrupt 8, gen 0
[63588.902631] BTRFS warning (device dm-3): csum failed root 1372 ino 4895964 off 34850111488 csum 0x21941ce6e9739bd6 expected csum 0xc113140701000000 mirror 1
[63588.902647] BTRFS error (device dm-3): bdev /dev/mapper/nvme-home errs: wr 0, rd 0, flush 0, corrupt 13, gen 0
[63588.949614] BTRFS warning (device dm-3): csum failed root 1372 ino 4895964 off 34850111488 csum 0x21941ce6e9739bd6 expected csum 0xc113140701000000 mirror 1
[63588.949628] BTRFS error (device dm-3): bdev /dev/mapper/nvme-home errs: wr 0, rd 0, flush 0, corrupt 14, gen 0
[63588.949849] BTRFS warning (device dm-3): csum failed root 1372 ino 4895964 off 34850111488 csum 0x21941ce6e9739bd6 expected csum 0xc113140701000000 mirror 1
[63588.949855] BTRFS error (device dm-3): bdev /dev/mapper/nvme-home errs: wr 0, rd 0, flush 0, corrupt 15, gen 0
[63588.950087] BTRFS warning (device dm-3): csum failed root 1372 ino 4895964 off 34850111488 csum 0x21941ce6e9739bd6 expected csum 0xc113140701000000 mirror 1
[63588.950099] BTRFS error (device dm-3): bdev /dev/mapper/nvme-home errs: wr 0, rd 0, flush 0, corrupt 16, gen 0

during a backup.

According to rsync this is related (why does BTRFS does not report the
affected file?)

Create a snapshot of '/home' in '/zeit/home/backup-2021-07-16-16:40:13'
rsync: [sender] read errors mapping "/zeit/home/backup-2021-07-16-16:40:13/martin/.local/share/akonadi/search_db/email/postlist.glass": Input/output error (5)
rsync: [sender] read errors mapping "/zeit/home/backup-2021-07-16-16:40:13/martin/.local/share/akonadi/search_db/email/postlist.glass": Input/output error (5)
ERROR: martin/.local/share/akonadi/search_db/email/postlist.glass failed verification -- update discarded.
rsync: [sender] read errors mapping "/zeit/home/backup-2021-07-16-16:40:13/martin/.local/share/baloo/index": Input/output error (5)
rsync: [sender] read errors mapping "/zeit/home/backup-2021-07-16-16:40:13/martin/.local/share/baloo/index": Input/output error (5)
ERROR: martin/.local/share/baloo/index failed verification -- update discarded.

Both are frequently written to files (both Baloo and Akonadi have very crazy
I/O patterns that, I would not have thought so, can even satisfy an NVMe SSD).

I thought that a Samsung 980 Pro can easily handle "discard=async" so I
used it.

This is on a ThinkPad T14 Gen1 with AMD Ryzen 7 PRO 4750U and 32 GiB of RAM.

It is BTRFS single profile on LVM on LUKS. Mount options are:

rw,relatime,lazytime,compress=zstd:3,ssd,space_cache=v2,subvolid=1054,subvol=/home

Smartctl has no errors.

I only use a few (less than 10) subvolumes.

I do not have any other errors in kernel log, so I bet this may not be
"discard=async" related. Any idea?

Could it have to do with a sudden switching off the laptop (there had
been quite some reasons cause at least with a AMD model of this laptop
in combination with an USB-C dock by Lenovo there are quite some stability
issues)? I would have hoped that the Samsung 980 Pro would still be
equipped to complete the outstanding write operation, but maybe it has
no capacitor for this.

I am really surprised by the what I experienced about the reliability of
SSDs I recently bought. I did not see a failure within a month with any
of the older SSDs. I hope this does not point at a severe worsening of
the quality. Probably I have to fit another SSD in there and use BTRFS
RAID 1 again to protect at least part of the data from errors like this.

Any idea about this? I bet you may not have any, as there is not block
I/O related errors in the log, but if you have, by all means share your
thoughts. Thank you.

Both files can be recreated. So I bet I will just remove them.

Best,
-- 
Martin


