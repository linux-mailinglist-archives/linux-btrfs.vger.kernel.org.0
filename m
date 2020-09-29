Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 105AF27D682
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Sep 2020 21:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728521AbgI2TLd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Sep 2020 15:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728166AbgI2TLd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Sep 2020 15:11:33 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC0BC061755
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Sep 2020 12:11:33 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id x69so6686547oia.8
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Sep 2020 12:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=cmfHqsxtaCskEfooxpuFu29HFu74HbIR1Plr4LjdJt4=;
        b=Y1gdWpWiUiFnqw6k3BRtvhFvLvR7LtDQx3f5i3VRrGk05uAkDjrY8/x+/yZMpKvNcb
         sTdI1z3S704Wk1VGBtDh5V8EWX1qBEisfDO07+WHbDlJNo2SKV74K4yjxjT6lIJBMimv
         W5P239X1/hGIuVah0JKye2Ado+/SIRKTaP5YQmqXlu2gmF+LEQ/4ia61WJMneo7bo2dR
         EIH8gXSNs9g1YFTzU6KJFD0lMPyvAwGo+Gt/qfGbnO6tN450WlmNf1IUBWjRPJuW9q/S
         qKxwuYF2ggyeXoIObkV2L2Wx+V1eVb2D2MShSvylqS5flb+E0dYh+ZCuhyoY/iQctoTv
         mCfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=cmfHqsxtaCskEfooxpuFu29HFu74HbIR1Plr4LjdJt4=;
        b=iHbE8nx8rD1wvng+wumFaaoqEMMSqvZlaI2lIARZsmc9YGWQ7oh027MxgigyPHJmnH
         GMylEvsywAhUxJdszCmbNXpbyeoWnNv931nvBUNm49BnXKXjcA/1zW4l1qx4i0ImqdGh
         t+tn46ZHVEOgn6/00FDhCX91DYF21aC3jBpfHb26K4bRIiHQymgbmVtW4d9q1hg1CQPx
         DMLDbFdmVXrD9J/DrgqP9z3/dp3XK8SNI0LZYya43Vum3JSQUYzZa/U811Vre+2pLXFH
         6oJnvJ2fqq9JWW7ICpr+8USqEQ7UsyziTijq4z+SdswQDZ/sa4y5UMT4795BrvOiM1XD
         M3xA==
X-Gm-Message-State: AOAM53242DiXdr4yazJ4T2Fm5SNDBLsfBlQblzhsqxV8vvTY8tpm8Ozk
        woJtf9rQCrxWTJJW1YxlKiQ+rG+0KNlQK+6hqldqrJvzJaI=
X-Google-Smtp-Source: ABdhPJxFEOGKFgc+uuZjbMztdESH8YsU5SuHttNRl0uCe7qlGZcF2UrD0r3kmFKBi9i2LRQ4SXNpjNvQ3MHS2TuGjEE=
X-Received: by 2002:aca:b144:: with SMTP id a65mr3443570oif.53.1601406692282;
 Tue, 29 Sep 2020 12:11:32 -0700 (PDT)
MIME-Version: 1.0
From:   gumbi 2400 <gumbi2400@gmail.com>
Date:   Tue, 29 Sep 2020 20:11:21 +0100
Message-ID: <CAPw8+313EMnUXRWcacFqUqpOSQ2N1oQ2Fq0ubykzTy0F+t_ykA@mail.gmail.com>
Subject: RAID 5 disk full, can't balance
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello all,

I have a RAID5 array of mixed disks as follows:

Label: 'MEDIA'  uuid: e59ff456-aa03-4954-887f-b616ae0dc270
Total devices 5 FS bytes used 13.07TiB
devid    1 size 3.64TiB used 3.64TiB path /dev/mapper/crypt-sdb
devid    2 size 7.28TiB used 4.54TiB path /dev/mapper/crypt-sdd
devid    3 size 7.28TiB used 4.54TiB path /dev/mapper/crypt-sde
devid    4 size 1.36TiB used 1.36TiB path /dev/mapper/crypt-sdf
devid    5 size 3.64TiB used 3.64TiB path /dev/mapper/crypt-sdc

I had a full server rebuild recently and when setting everything back
up needed to run a chown across the array to reflect new UIDs. This
failed due to not enough space and dropped into read-only. I'm aware
that this is a common issue that is usually fixed by a rebalance and
proceeded to kick off the following:

btrfs balance start -dusage=90 /media

This ran briefly and rebalanced a couple of chunks before I realised I
had mistakenly not put this into the background. I canceled the
balance and attempted to start a new one after remounting. However, on
mount the previous balance tried to start again, which immediately
kicked the fs back into read-only. At which point I attempted the
following:

mount -o skip_balance /media && btrfs balance cancel /media

This again kicked it back into read-only as it couldn't wrote to
cancel the balance. Next step was to try a temp 10G loopback device.

mount -o skip_balance /media && btrfs device add /dev/loop3 /media &&
btrfs balance cancel /media

Again, back into read-only.

Last attempt. It was suggested on reddit that running zero-log may
blow out any pending transactions getting in the way, tried this and
again back into read-only.

btrfs rescue zero-log /dev/crypt-sdb
mount -o skip_balance /media&& btrfs device add /dev/loop3 /media&&
btrfs balance cancel /media

At this point, I'm wondering if it's possible to figure out what
transaction is causing issues even without trying to run anything
other than a skip_balance it still drops into read-only after about 30
seconds. I'd like to add a device and rebalance, but it can't seem to
get that far. Any suggestions on what to look at next?

uname -a:
Linux magickbrick 5.8.0-19-generic #20-Ubuntu SMP Fri Sep 11 09:08:26
UTC 2020 x86_64 x86_64 x86_64 GNU/Linux

btrfs --version: btrfs-progs v5.7

btrfs fi show:

Data, RAID5: total=13.16TiB, used=13.05TiB
System, RAID1C3: total=32.00MiB, used=960.00KiB
Metadata, RAID1C3: total=14.00GiB, used=13.86GiB
GlobalReserve, single: total=512.00MiB, used=656.00KiB

Label: 'MEDIA'  uuid: e59ff456-aa03-4954-887f-b616ae0dc270
Total devices 5 FS bytes used 13.07TiB
devid    1 size 3.64TiB used 3.64TiB path /dev/mapper/crypt-sdb
devid    2 size 7.28TiB used 4.54TiB path /dev/mapper/crypt-sdd
devid    3 size 7.28TiB used 4.54TiB path /dev/mapper/crypt-sde
devid    4 size 1.36TiB used 1.36TiB path /dev/mapper/crypt-sdf
devid    5 size 3.64TiB used 3.64TiB path /dev/mapper/crypt-sdc



Most recent dmesg:

BTRFS info (device dm-4): use lzo compression, level 0
BTRFS info (device dm-4): disk space caching is enabled
BTRFS info (device dm-4): has skinny extents
BTRFS info (device dm-4): bdev /dev/mapper/crypt-sdb errs: wr 0, rd 1,
flush 0, corrupt 0, gen 0
BTRFS info (device dm-4): bdev /dev/mapper/crypt-sdf errs: wr 18, rd
136, flush 0, corrupt 0, gen 0
BTRFS info (device dm-4): disk space caching is enabled
BTRFS info (device dm-4): balance: resume skipped
------------[ cut here ]------------
BTRFS: Transaction aborted (error -28)
WARNING: CPU: 3 PID: 11529 at fs/btrfs/extent-tree.c:3070
__btrfs_free_extent.isra.0+0x589/0x930 [btrfs]
Modules linked in: binfmt_misc xfs nls_iso8859_1 reiserfs dm_multipath
scsi_dh_rdac scsi_dh_emc scsi_dh_alua snd_hda_codec_realtek
snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi snd_hda_intel
snd_intel_dspcfg edac_mce_amd snd_hda_codec snd_hda_core snd_hwdep
snd_pcm kvm snd_timer snd rapl efi_pstore wmi_bmof soundcore k10temp
ccp input_leds joydev mac_hid sch_fq_codel ip_tables x_tables autofs4
btrfs blake2b_generic dm_crypt raid10 raid456 async_raid6_recov
async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c raid1
raid0 multipath linear hid_generic usbhid hid nouveau crct10dif_pclmul
mxm_wmi crc32_pclmul video i2c_algo_bit ttm ghash_clmulni_intel
drm_kms_helper aesni_intel syscopyarea sysfillrect sysimgblt
fb_sys_fops crypto_simd cec cryptd glue_helper rc_core drm i2c_piix4
r8169 realtek ahci xhci_pci libahci xhci_pci_renesas nvme nvme_core
wmi gpio_amdpt gpio_generic
CPU: 3 PID: 11529 Comm: btrfs-transacti Tainted: G        W
5.8.0-19-generic #20-Ubuntu
Hardware name: Gigabyte Technology Co., Ltd. B450M GAMING/B450M
GAMING, BIOS F50 11/27/2019
RIP: 0010:__btrfs_free_extent.isra.0+0x589/0x930 [btrfs]
Code: 84 48 8b 7d 88 ba 5c 0c 00 00 48 c7 c6 c0 30 8a c0 e8 4e f7 0a
00 e9 af fe ff ff 44 89 ee 48 c7 c7 08 dc 8a c0 e8 5c 31 2c fa <0f> 0b
48 8b 7d 88 44 89 e9 ba fe 0b 00 00 48 c7 c6 c0 30 8a c0 e8
RSP: 0018:ffffb7a0413d3b70 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff91bb168d8cd8
RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: ffff91bb168d8cd0
RBP: ffffb7a0413d3c20 R08: 0000000000000004 R09: 0000000000000c8d
R10: 0000000000000000 R11: 0000000000000001 R12: 00002177776b4000
R13: 00000000ffffffe4 R14: ffff91b99abc00e0 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff91bb168c0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa3e5cdcb20 CR3: 0000000212ae8000 CR4: 00000000003406e0
Call Trace:
 run_delayed_tree_ref+0x7f/0x160 [btrfs]
 btrfs_run_delayed_refs_for_head+0x2e1/0x480 [btrfs]
 __btrfs_run_delayed_refs+0x8c/0x1d0 [btrfs]
 btrfs_run_delayed_refs+0x73/0x200 [btrfs]
 btrfs_start_dirty_block_groups+0x2c0/0x480 [btrfs]
 btrfs_commit_transaction+0xc6/0x9e0 [btrfs]
 ? start_transaction+0xd7/0x550 [btrfs]
 ? __next_timer_interrupt+0xa0/0xe0
 transaction_kthread+0x146/0x190 [btrfs]
 kthread+0x12f/0x150
 ? btrfs_cleanup_transaction.isra.0+0x2a0/0x2a0 [btrfs]
 ? __kthread_bind_mask+0x70/0x70
 ret_from_fork+0x22/0x30
---[ end trace 5734fd11b340fd6d ]---
BTRFS: error (device dm-4) in __btrfs_free_extent:3070: errno=-28 No space left
BTRFS info (device dm-4): forced readonly
BTRFS: error (device dm-4) in btrfs_run_delayed_refs:2174: errno=-28
No space left
