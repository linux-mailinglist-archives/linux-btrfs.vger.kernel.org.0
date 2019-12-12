Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 609E311CBB2
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2019 12:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728944AbfLLLBk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Dec 2019 06:01:40 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35923 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728871AbfLLLBj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Dec 2019 06:01:39 -0500
Received: by mail-pg1-f196.google.com with SMTP id k3so979539pgc.3
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Dec 2019 03:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lCXGc/wSJhn4wzphnffaLhuDhHbrWuw4a01//wlA3rw=;
        b=QgnBPjbMbZsEb7rWFYgAATgcEvm7TNsNazJpkpIQ98oyqM0Gdxn9sAIvELvP0+SBTt
         GE/5Qh98MsDLN+HiuUc8xeETw+j2pE8n9Aaqv/Q3krBOpNE6TS4JsvHdhIrpBnHg0JHJ
         BkBNSj3QcpDv/HiB4ByxQ4RCP3ESXEc0or9i4zloYyMBwRk3xh3rIYp92JRjnAHgBx8z
         PIpEJoN/kzHARUptG5btPQ44rAzJPuCJjKhXZAnyZexX5RVnqGAHt722bTovavV7YPvu
         NYTN3XXffHrC3syGeKPkvhePWxzZdVxxZ/JaCfy5zjYhXnrlTSjWHYP+CLs+0JMWxJBu
         EaBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lCXGc/wSJhn4wzphnffaLhuDhHbrWuw4a01//wlA3rw=;
        b=a2COamEyulJeMflqmZywqtO3CQMXGMXoS/RaTJzGz9fPtIE1o5N7OhQYwBFgEvwddP
         oqZ//SPMM+JvsGbYjVRrv0fnoloVP2O7OHzcDbNlaiisxfbi3EP+PKI15ukdsw7pcyM8
         /WkWN3x7TUl3wjHYWKa3/SlB5EusQvdz4hQ3B4zCytN76EdWhme18ba4t7muf/um/OrO
         KnQvv0/0G6vAVdLbYuYA3WXjYbneUkNMNPvJ4Iklovgg3xoaANiy6XLXMJsQa1MxKLab
         r8/BcoT53L9CpZ9d4VHeOcnDMEJW+HCfVQ6la/p3vh2LjrR66ScoSZ6tzrdNvEvP9YN2
         tiVg==
X-Gm-Message-State: APjAAAV7KQKdysRhcAlKIFr+GbK4Cl2W/CBSYc8Wld6XDBqs44wFcMrR
        gOTKFy6dGI5SvEOEkaCy6d22eXRuVXc=
X-Google-Smtp-Source: APXvYqx4bzdO8rCWCz0CLckrVwuwr0VL4+opDaVYXn+joDt3acp46LY0w1pwdhIxFoxFesDdLMjJyA==
X-Received: by 2002:a65:6842:: with SMTP id q2mr9973911pgt.345.1576148498487;
        Thu, 12 Dec 2019 03:01:38 -0800 (PST)
Received: from p.lan ([45.58.38.246])
        by smtp.gmail.com with ESMTPSA id w11sm6682387pfn.4.2019.12.12.03.01.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Dec 2019 03:01:38 -0800 (PST)
From:   damenly.su@gmail.com
X-Google-Original-From: Damenly_Su@gmx.com
To:     linux-btrfs@vger.kernel.org
Cc:     Su Yue <Damenly_Su@gmx.com>
Subject: [PATCH 1/6] btrfs: metadata_uuid: fix failed assertion due to unsuccessful device scan
Date:   Thu, 12 Dec 2019 19:01:27 +0800
Message-Id: <20191212110132.11063-2-Damenly_Su@gmx.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
In-Reply-To: <20191212110132.11063-1-Damenly_Su@gmx.com>
References: <20191212110132.11063-1-Damenly_Su@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Su Yue <Damenly_Su@gmx.com>

While running misc-tests/034 of btrfs-progs, easy to hit:
======================================================================
[ 1318.749685] BTRFS: device fsid 55abf31c-6b3a-47ad-8711-cfd5a249dd4c devid 2 transid 8 /dev/loop0 scanned by systemd-udevd (3530)
[ 1318.846791] BTRFS: device fsid 55abf31c-6b3a-47ad-8711-cfd5a249dd4c devid 2 transid 8 /dev/loop0 scanned by systemd-udevd (3530)
[ 1318.847812] BTRFS: device fsid 55abf31c-6b3a-47ad-8711-cfd5a249dd4c devid 2 transid 8 /dev/loop0 scanned by mount (3540)
[ 1318.901278] assertion failed: !memcmp(fs_info->fs_devices->fsid, fs_info->super_copy->fsid, BTRFS_FSID_SIZE), in fs/btrfs/disk-io.c:2874
[ 1318.901499] ------------[ cut here ]------------
[ 1318.901503] kernel BUG at fs/btrfs/ctree.h:3118!
[ 1318.901582] invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
[ 1318.901644] CPU: 4 PID: 3540 Comm: mount Tainted: G           O      5.5.0-rc1-custom+ #41
[ 1318.901720] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
[ 1318.901836] RIP: 0010:assfail.constprop.0+0x1c/0x1e [btrfs]
[ 1318.901894] Code: 00 00 44 89 c0 5b 41 5c 41 5d 41 5e 5d c3 55 89 f1 48 c7 c2 40 13 0f c1 48 89 fe 48 c7 c7 00 1b 0f c1 48 89 e5 e8 3e 12 0f dc <0f> 0b e8 93 01 39 dc be 56 03 00 00 48 c7 c7 a0 1b 0f c1 e8 cc ff
[ 1318.902069] RSP: 0018:ffff88814fea76e0 EFLAGS: 00010282
[ 1318.902124] RAX: 000000000000007c RBX: ffff88814d862400 RCX: 0000000000000000
[ 1318.902191] RDX: 0000000000000001 RSI: 0000000000000008 RDI: ffffed1029fd4ecf
[ 1318.902259] RBP: ffff88814fea76e0 R08: 000000000000007c R09: ffffed102b3fe719
[ 1318.902326] R10: ffffed102b3fe718 R11: ffff888159ff38c7 R12: ffff8881398ac000
[ 1318.902394] R13: ffff888145742930 R14: ffff88812f56e000 R15: ffff88812f56e000
[ 1318.902464] FS:  00007f0753032500(0000) GS:ffff888159e00000(0000) knlGS:0000000000000000
[ 1318.902539] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1318.902595] CR2: 0000560357a9c018 CR3: 00000001502d4000 CR4: 0000000000340ee0
[ 1318.903852] Call Trace:
[ 1318.904958]  open_ctree+0x166c/0x373e [btrfs]
[ 1318.906029]  ? congestion_wait+0x2d0/0x2d0
[ 1318.907500]  ? wb_init+0x31e/0x400
[ 1318.908699]  ? close_ctree+0x52b/0x52b [btrfs]
[ 1318.909734]  btrfs_mount_root.cold+0xe/0x118 [btrfs]
[ 1318.910764]  ? btrfs_decode_error+0x40/0x40 [btrfs]
[ 1318.911784]  ? vfs_parse_fs_string+0xdc/0x130
[ 1318.912798]  ? rcu_read_lock_sched_held+0xa1/0xd0
[ 1318.913835]  ? rcu_read_lock_bh_held+0xb0/0xb0
[ 1318.914878]  ? legacy_parse_param+0x75/0x340
[ 1318.915946]  ? __lookup_constant+0x54/0x90
[ 1318.917005]  ? debug_lockdep_rcu_enabled.part.0+0x1a/0x30
[ 1318.918099]  ? kfree+0x2fd/0x360
[ 1318.919233]  ? btrfs_decode_error+0x40/0x40 [btrfs]
[ 1318.920361]  legacy_get_tree+0x89/0xd0
[ 1318.921480]  vfs_get_tree+0x52/0x140
[ 1318.922625]  fc_mount+0x14/0x70
[ 1318.923713]  vfs_kern_mount.part.0+0x78/0x90
[ 1318.924789]  vfs_kern_mount+0x13/0x20
[ 1318.925885]  btrfs_mount+0x1f3/0xb30 [btrfs]
[ 1318.926922]  ? sched_clock_cpu+0x1b/0x130
[ 1318.927936]  ? find_held_lock+0x95/0xb0
[ 1318.928964]  ? btrfs_remount+0x7e0/0x7e0 [btrfs]
[ 1318.929939]  ? vfs_parse_fs_string+0xdc/0x130
[ 1318.930875]  ? vfs_parse_fs_string+0xdc/0x130
[ 1318.931784]  ? rcu_read_lock_sched_held+0xa1/0xd0
[ 1318.932651]  ? rcu_read_lock_bh_held+0xb0/0xb0
[ 1318.933497]  ? legacy_parse_param+0x75/0x340
[ 1318.934327]  ? __lookup_constant+0x54/0x90
[ 1318.935173]  ? debug_lockdep_rcu_enabled.part.0+0x1a/0x30
[ 1318.936023]  ? kfree+0x2fd/0x360
[ 1318.937372]  ? cap_capable+0xb3/0xf0
[ 1318.938323]  ? btrfs_remount+0x7e0/0x7e0 [btrfs]
[ 1318.939126]  legacy_get_tree+0x89/0xd0
[ 1318.939921]  ? legacy_get_tree+0x89/0xd0
[ 1318.940687]  vfs_get_tree+0x52/0x140
[ 1318.941431]  do_mount+0xe01/0x1220
[ 1318.942189]  ? rcu_read_lock_bh_held+0xb0/0xb0
[ 1318.942935]  ? copy_mount_string+0x20/0x20
[ 1318.943690]  ? __kasan_check_write+0x14/0x20
[ 1318.944438]  ? memdup_user+0x52/0x90
[ 1318.945190]  ksys_mount+0x82/0xd0
[ 1318.945921]  __x64_sys_mount+0x67/0x80
[ 1318.946640]  do_syscall_64+0x79/0xe0
[ 1318.947364]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[ 1318.948109] RIP: 0033:0x7f07531b5e4e
[ 1318.948851] Code: 48 8b 0d 35 00 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 02 00 0c 00 f7 d8 64 89 01 48
[ 1318.951249] RSP: 002b:00007ffeffa9c9f8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
[ 1318.952119] RAX: ffffffffffffffda RBX: 00007f07532dc204 RCX: 00007f07531b5e4e
[ 1318.952988] RDX: 0000560357a97430 RSI: 0000560357a96230 RDI: 0000560357a93500
[ 1318.953867] RBP: 0000560357a932f0 R08: 0000000000000000 R09: 0000560357a990e0
[ 1318.954757] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
[ 1318.955638] R13: 0000560357a93500 R14: 0000560357a97430 R15: 0000560357a932f0
[ 1318.956540] Modules linked in: btrfs(O) xor zstd_decompress zstd_compress raid6_pq loop mousedev nls_iso8859_1 nls_cp437 vfat fat iTCO_wdt crct10dif_pclmul iTCO_vendor_support snd_hda_codec_generic crc32_pclmul crc32c_intel ghash_clmulni_intel snd_hda_intel snd_intel_dspcfg snd_hda_codec snd_hwdep snd_hda_core snd_pcm input_leds snd_timer led_class psmouse pcspkr aesni_intel i2c_i801 snd intel_agp glue_helper crypto_simd cryptd soundcore lpc_ich intel_gtt rtc_cmos qemu_fw_cfg agpgart evdev mac_hid ip_tables x_tables xfs sr_mod cdrom sd_mod dm_mod virtio_scsi virtio_balloon virtio_rng virtio_blk virtio_console rng_core virtio_net net_failover failover ahci serio_raw libahci atkbd libps2 libata scsi_mod virtio_pci virtio_ring virtio i8042 serio [last unloaded: btrfs]
[ 1318.965122] ---[ end trace 51f0adac8fc1fe76 ]---
======================================================================

Acutally, there are two devices in the fs. Device 2 with
FSID_CHANGING_V2 allocated a fs_devices. But, device 1 found the
fs_devices but failed to be added into since fs_devices->opened (
the thread is doing mount device 1). But device 1's fsid was copied
to fs_devices->fsid then the assertion failed.

The solution is that only if a new device was added into a existing
fs_device, then the fs_devices->fsid is allowed to be rewritten.

Fixes: 7a62d0f07377 ("btrfs: Handle one more split-brain scenario during fsid change")
Signed-off-by: Su Yue <Damenly_Su@gmx.com>
---
 fs/btrfs/volumes.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index d8e5560db285..9efa4123c335 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -732,6 +732,9 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 		BTRFS_FEATURE_INCOMPAT_METADATA_UUID);
 	bool fsid_change_in_progress = (btrfs_super_flags(disk_super) &
 					BTRFS_SUPER_FLAG_CHANGING_FSID_V2);
+	bool fs_devices_found = false;
+
+	*new_device_added = false;
 
 	if (fsid_change_in_progress) {
 		if (!has_metadata_uuid) {
@@ -772,24 +775,11 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 
 		device = NULL;
 	} else {
+		fs_devices_found = true;
+
 		mutex_lock(&fs_devices->device_list_mutex);
 		device = btrfs_find_device(fs_devices, devid,
 				disk_super->dev_item.uuid, NULL, false);
-
-		/*
-		 * If this disk has been pulled into an fs devices created by
-		 * a device which had the CHANGING_FSID_V2 flag then replace the
-		 * metadata_uuid/fsid values of the fs_devices.
-		 */
-		if (has_metadata_uuid && fs_devices->fsid_change &&
-		    found_transid > fs_devices->latest_generation) {
-			memcpy(fs_devices->fsid, disk_super->fsid,
-					BTRFS_FSID_SIZE);
-			memcpy(fs_devices->metadata_uuid,
-					disk_super->metadata_uuid, BTRFS_FSID_SIZE);
-
-			fs_devices->fsid_change = false;
-		}
 	}
 
 	if (!device) {
@@ -912,6 +902,22 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 		}
 	}
 
+	/*
+	 * If the new added disk has been pulled into an fs devices created by
+	 * a device which had the CHANGING_FSID_V2 flag then replace the
+	 * metadata_uuid/fsid values of the fs_devices.
+	 */
+	if (*new_device_added && fs_devices_found &&
+	    has_metadata_uuid && fs_devices->fsid_change &&
+	    found_transid > fs_devices->latest_generation) {
+		memcpy(fs_devices->fsid, disk_super->fsid,
+		       BTRFS_FSID_SIZE);
+		memcpy(fs_devices->metadata_uuid,
+		       disk_super->metadata_uuid, BTRFS_FSID_SIZE);
+
+		fs_devices->fsid_change = false;
+	}
+
 	/*
 	 * Unmount does not free the btrfs_device struct but would zero
 	 * generation along with most of the other members. So just update
-- 
2.21.0 (Apple Git-122.2)

