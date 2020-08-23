Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9EE324EF7D
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Aug 2020 21:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbgHWTgg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 23 Aug 2020 15:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgHWTge (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 23 Aug 2020 15:36:34 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8006EC061573
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Aug 2020 12:36:32 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id x142so1527777vke.0
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Aug 2020 12:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=k9e+6lTsAWhhPRZfSYB364b3Oh2+tw2mxb5UpNriuQM=;
        b=aKWnX031kPhKPUQQgP1aEiWuyH7VsSHh3BohoBhe/n0446Be0NwrL7SokCBdwojiPO
         yxxO6sIVBimbUF7Gi0nkJJbbGBj7nkOT2ohT7Hf1DE2SVbTyrhnuFnw+7XCaeP2u22BC
         6TJ+BlXdqqTIiTUYar8bJZh2OYSqdrQvcU4mLG9VxoswdpTqy2YPJWcKpe548pc0hWgf
         ajAZxalVmAUFK1K1wNHI5xWU9YO1hLDnVxXCXWFjAQQW4Z4pqM3P9lBHR0L9zz+Yl+r1
         N82+XdKTuO3QbEyw8yvlVoqq415I8PhcE3bzqpvrqsg6IOg8FwmH37kQ4TsDggrAwPOH
         U++w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=k9e+6lTsAWhhPRZfSYB364b3Oh2+tw2mxb5UpNriuQM=;
        b=lQejAqwVcxlaz9ZWcn8SFHKbtFEibBniiT2DvOb7138q3GzScPc0GVJAI9x8kBcw0u
         0ScIRBgwBBJIs6PNPbYd0vd4gbxd5M/zzEmaA/mL+hXOQZsdZ1FaLynhnGf3jX/vecH8
         fnCcWR7+1WOVUECnp7ISVES0v8pghM9Z9UpvhXg7N31fQISphfM5O7xafyv3hVUC8KbB
         P6RRpQzTkpyHf36j4tYKJfMDv2qn8EuxRgpvFI4Jv4gbZdh2ptC65rhDyqeUF/noe3yq
         31BPxE4JnTxkM9YdQRCv8jIGJL5I9BdOkB3c9FUbUuBHYc7PhFc796n8Q3IEBOiJ/rOE
         Tbgg==
X-Gm-Message-State: AOAM5310ttxE3+0krL0EaQ8Ce7ZW1ieVtOFXklXXMb9jGEI2whGPLYgm
        V3GMLQ/aJ8UuGxdmEBUhyOHMuccRhWlNPnygWq+XLULIaPc=
X-Google-Smtp-Source: ABdhPJwtad951g5SAI+cJ2MpMppF0oiUsJnoQd98n9hstIo/6UwgNcIn0Jhw9ky+Lm49VJTjD8GwBxpcYe4POYy/tkc=
X-Received: by 2002:a1f:3612:: with SMTP id d18mr966838vka.21.1598211390253;
 Sun, 23 Aug 2020 12:36:30 -0700 (PDT)
MIME-Version: 1.0
From:   Tristan Plumb <wild.rugosa@gmail.com>
Date:   Sun, 23 Aug 2020 15:36:18 -0400
Message-ID: <CALpYhWwfmBNqDgSGf4DawArhSMWDyoCHFWb4dESoRtMV1Dd3Eg@mail.gmail.com>
Subject: [help] bad csum and magic on both superblocks
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I had two nvme drives set up with raid1 metadata and rai0 data. One of
them failed, as far as I
can tell it shorted the 3.3v rail to ground, but the other is mostly
fine. However, neither of the two
superblocks have correct checksums or magic, though they appear to be
practically identical.

None of the tools that I've tried to use so far, other than
inspect-internal dump-super, have
provided an option to skip the superblock checksum and magic test, so
I get results like:

[root@ping:~]# btrfs restore -l -i /dev/nvme1n1p2
No valid Btrfs found on /dev/nvme1n1p2
Could not open root, trying backup super
ERROR: superblock checksum mismatch
No valid Btrfs found on /dev/nvme1n1p2
Could not open root, trying backup super
ERROR: superblock bytenr 274877906944 is larger than device size 190805180416
Could not open root, trying backup super

The other contents of the superblock looks fairly reasonable however.
Would people
recommend that I add an option to ignore the checksum/magic errors
(which is my inclination),
or that I repair the superblock manually somehow? Or (and my real
reason for bothering you all)
is there another option/approach that someone would suggest?

Cheers,
Tristan

[root@ping:~]# uname -a; btrfs --version
Linux ping 5.4.59 #1-NixOS SMP Wed Aug 19 06:16:29 UTC 2020 x86_64 GNU/Linux
btrfs-progs v5.7

[root@ping:~]# btrfs inspect-internal dump-super -s 0 --force /dev/nvme1n1p2
superblock: bytenr=65536, device=/dev/nvme1n1p2
---------------------------------------------------------
csum_type 0 (crc32c)
csum_size 4
csum 0x344a5afc [DON'T MATCH]
bytenr 65536
flags 0x1
( WRITTEN )
magic ........ [DON'T MATCH]
fsid badf716b-44c3-42a5-af84-bb91fccf0f47
metadata_uuid badf716b-44c3-42a5-af84-bb91fccf0f47
label
generation 730413
root 914966282240
sys_array_size 97
chunk_root_generation 730413
root_level 1
chunk_root 912808476672
chunk_root_level 1
log_root 0
log_root_transid 0
log_root_level 0
total_bytes 2171858845696
bytes_used 369171148800
sectorsize 4096
nodesize 16384
leafsize (deprecated) 16384
stripesize 4096
root_dir 6
num_devices 2
compat_flags 0x0
compat_ro_flags 0x0
incompat_flags 0x161
( MIXED_BACKREF |
  BIG_METADATA |
  EXTENDED_IREF |
  SKINNY_METADATA )
cache_generation 730413
uuid_tree_generation 730413
dev_item.uuid a792e7c4-88a8-4e2e-9d68-39baa50b6d0d
dev_item.fsid badf716b-44c3-42a5-af84-bb91fccf0f47 [match]
dev_item.type 0
dev_item.total_bytes 190805180416
dev_item.bytes_used 4328521728
dev_item.io_align 4096
dev_item.io_width 4096
dev_item.sector_size 4096
dev_item.devid 1
dev_item.dev_group 0
dev_item.seek_speed 0
dev_item.bandwidth 0
dev_item.generation 0

[root@ping:~]# btrfs inspect-internal dump-super -s 1 --force /dev/nvme1n1p2
superblock: bytenr=67108864, device=/dev/nvme1n1p2
---------------------------------------------------------
csum_type 0 (crc32c)
csum_size 4
csum 0x942b7232 [DON'T MATCH]
bytenr 67108864
flags 0x1
( WRITTEN )
magic ........ [DON'T MATCH]
fsid badf716b-44c3-42a5-af84-bb91fccf0f47
metadata_uuid badf716b-44c3-42a5-af84-bb91fccf0f47
label
generation 730413
root 914966282240
sys_array_size 97
chunk_root_generation 730413
root_level 1
chunk_root 912808476672
chunk_root_level 1
log_root 0
log_root_transid 0
log_root_level 0
total_bytes 2171858845696
bytes_used 369171148800
sectorsize 4096
nodesize 16384
leafsize (deprecated) 16384
stripesize 4096
root_dir 6
num_devices 2
compat_flags 0x0
compat_ro_flags 0x0
incompat_flags 0x161
( MIXED_BACKREF |
  BIG_METADATA |
  EXTENDED_IREF |
  SKINNY_METADATA )
cache_generation 730413
uuid_tree_generation 730413
dev_item.uuid a792e7c4-88a8-4e2e-9d68-39baa50b6d0d
dev_item.fsid badf716b-44c3-42a5-af84-bb91fccf0f47 [match]
dev_item.type 0
dev_item.total_bytes 190805180416
dev_item.bytes_used 4328521728
dev_item.io_align 4096
dev_item.io_width 4096
dev_item.sector_size 4096
dev_item.devid 1
dev_item.dev_group 0
dev_item.seek_speed 0
dev_item.bandwidth 0
dev_item.generation 0
