Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75E2134F07A
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Mar 2021 20:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbhC3SGL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Mar 2021 14:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232672AbhC3SF6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Mar 2021 14:05:58 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB59C061574
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Mar 2021 11:05:58 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id d8-20020a1c1d080000b029010f15546281so10820478wmd.4
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Mar 2021 11:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=SgWUFfe4ePadL3u4ajYSroX5z7sptvjU7b0NTQ0CNNQ=;
        b=L3RF9OlgDM717+8og78wYG4VPWY13SIwNL89MB7gBaGJzzWlHUlYRvJDYyQFUJxJQh
         e+KQ+1qIvVU8tyV60GCcRc6PxlaYM++Uvve3UgBkp2+F3jABwXEpYtp/b8NeQtqawCYK
         8INDMBtQnjq5vI93KpJYI9YbXxtlST11wqQSenApg8HH06OAc5s4F8I7mzjzOEaAz/1Q
         3A+Rf8iDD78IFXVmdPT7LZH6MweiBhbmNUsnH1Vc+ozQbrDWs5uDVWrLoI65Rur1vwhp
         WgaDzBCCKQro8dnWcs7l9es4aSLdf9EPR+6iVSck/rVDArsfoy9XubRt0GUuIqc6SPpK
         7c8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=SgWUFfe4ePadL3u4ajYSroX5z7sptvjU7b0NTQ0CNNQ=;
        b=UyzEy8t7O7ikF1S3QR0v2is5+XO2LgOAi3+Iv631DQBkwPj1GTHpBuWxJ9l8GTgKUQ
         EfJKBWs21iLfvQE3y9x1kDIWt9E2H4DhuXKFZZoWKB0da2ZBmQw2B8hmnGciXDRXZKJg
         e8MOSg0JSXc2sswJECRlqOpRKhxNEzf0BnwSVn2dFYPXpeTNM4JQK1fFBGHtMQKPyI70
         CFo9G/i0NpuuctX0TO67zm1pxaD/aNsSDPgAi9uxTzGwN/KZ59NXPmzEfMY64UcMh3OJ
         G7a+E5mTRXWniJ33hkZpoha3vZawxWb8XCMqL63umsrM7EbIR8vPh9Ar4Rot3hxrblgS
         j/Vg==
X-Gm-Message-State: AOAM533BdHVDsuqO84+gYebr4q9qlQ7y3Xzx4+2P5KJ0avx0ZbZr1jXA
        KbMqeqVvIiohDVthnyEGBfAFjdpfH2hZng==
X-Google-Smtp-Source: ABdhPJyK26G0lM+vrqNSDbVDmJmlYupHVikk/9NyGOF7I4j/fAxs7xm64tair4pZomxdcIwF5H8WdA==
X-Received: by 2002:a1c:e341:: with SMTP id a62mr5460605wmh.152.1617127557010;
        Tue, 30 Mar 2021 11:05:57 -0700 (PDT)
Received: from yuna.elaboris.de (dslb-002-202-189-052.002.202.pools.vodafone-ip.de. [2.202.189.52])
        by smtp.gmail.com with ESMTPSA id y18sm36168116wrq.61.2021.03.30.11.05.56
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Mar 2021 11:05:56 -0700 (PDT)
To:     linux-btrfs@vger.kernel.org
From:   Markus Schaaf <markuschaaf@gmail.com>
Subject: Any ideas what this warnings are about?
Message-ID: <43acc426-d683-d1b6-729d-c6bc4a2fff4d@gmail.com>
Date:   Tue, 30 Mar 2021 20:05:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi all,

on one of my machines I'm seeing these warnings a lot lately:

------------[ cut here ]------------
WARNING: CPU: 1 PID: 314 at fs/fs-writeback.c:2472 __writeback_inodes_sb_nr+0xb8/0xd0
Modules linked in: iTCO_wdt wireguard curve25519_x86_64 libchacha20poly1305 intel_pmc_bxt iTCO_vendor_support chacha_x86_64 poly1305_x86_64 libblake2s blake2s_x86_64 ip6_udp_tunnel udp_tunnel libcurve25519_generic libchacha libblake2s_generic psmouse joydev mousedev pcspkr i2c_i801 i2c_smbus lpc_ich iptable_filter xt_nat xt_tcpudp intel_agp intel_gtt iptable_nat nf_nat qemu_fw_cfg nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 mac_hid vfat fat auth_rpcgss sunrpc fuse ip_tables x_tables btrfs blake2b_generic libcrc32c crc32c_generic xor raid6_pq dm_crypt cbc encrypted_keys trusted tpm usbhid dm_mod virtio_gpu virtio_dma_buf drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops cec drm virtio_scsi virtio_balloon virtio_net virtio_console net_failover agpgart failover crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel aesni_intel crypto_simd cryptd glue_helper serio_raw sr_mod cdrom xhci_pci virtio_pci virtio_rng rng_core
CPU: 1 PID: 314 Comm: btrfs-transacti Tainted: G        W         5.10.26-1-MANJARO #1
Hardware name: Hetzner vServer, BIOS 20171111 11/11/2017
RIP: 0010:__writeback_inodes_sb_nr+0xb8/0xd0
Code: 0f b6 d1 48 8d 74 24 10 e8 35 fc ff ff 48 89 e7 e8 7d fb ff ff 48 8b 44 24 48 65 48 2b 04 25 28 00 00 00 75 09 48 83 c4 50 c3 <0f> 0b eb cf e8 df 8c 75 00 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f
RSP: 0018:ffffb1f5448f7d98 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff961185aa5488 RCX: 0000000000000000
RDX: 0000000000000002 RSI: 0000000000004b45 RDI: ffff9611b7220000
RBP: ffff9611b64d3958 R08: ffff961184efc800 R09: 0000000000000140
R10: ffff9611859e6400 R11: ffff961192af3c10 R12: ffff9611838f7c00
R13: ffff961185aa5000 R14: ffff961185aa5460 R15: 0000000000011a0f
FS:  0000000000000000(0000) GS:ffff9611fad00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f654bc76b58 CR3: 0000000002c60000 CR4: 00000000003506e0
Call Trace:
  btrfs_commit_transaction+0x448/0xbc0 [btrfs]
  ? start_transaction+0xcc/0x5b0 [btrfs]
  transaction_kthread+0x143/0x170 [btrfs]
  ? btrfs_cleanup_transaction.isra.0+0x560/0x560 [btrfs]
  kthread+0x133/0x150
  ? __kthread_bind_mask+0x60/0x60
  ret_from_fork+0x22/0x30
---[ end trace 3cefecf5d9d20b50 ]---

------------[ cut here ]------------
WARNING: CPU: 0 PID: 758 at fs/fs-writeback.c:2472 __writeback_inodes_sb_nr+0xb8/0xd0
Modules linked in: iTCO_wdt wireguard curve25519_x86_64 libchacha20poly1305 intel_pmc_bxt iTCO_vendor_support chacha_x86_64 poly1305_x86_64 libblake2s blake2s_x86_>
CPU: 0 PID: 758 Comm: journal-offline Tainted: G        W         5.10.26-1-MANJARO #1
Hardware name: Hetzner vServer, BIOS 20171111 11/11/2017
RIP: 0010:__writeback_inodes_sb_nr+0xb8/0xd0
Code: 0f b6 d1 48 8d 74 24 10 e8 35 fc ff ff 48 89 e7 e8 7d fb ff ff 48 8b 44 24 48 65 48 2b 04 25 28 00 00 00 75 09 48 83 c4 50 c3 <0f> 0b eb cf e8 df 8c 75 00 66>
RSP: 0018:ffffb1f540d7fd40 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff961185aa5488 RCX: 0000000000000000
RDX: 0000000000000002 RSI: 0000000000004be5 RDI: ffff9611b7220000
RBP: ffff961182209208 R08: ffff961184efc800 R09: 0000000000000140
R10: ffff9611859e6400 R11: ffff961192af3c10 R12: ffff961183891200
R13: ffff961185aa5000 R14: ffff961185aa5460 R15: ffff9611b65d5e10
FS:  00007f654b80e640(0000) GS:ffff9611fac00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f654cf39010 CR3: 0000000003884000 CR4: 00000000003506f0
Call Trace:
  btrfs_commit_transaction+0x448/0xbc0 [btrfs]
  ? btrfs_wait_ordered_range+0x1b8/0x210 [btrfs]
  ? btrfs_sync_file+0x2b8/0x4e0 [btrfs]
  btrfs_sync_file+0x343/0x4e0 [btrfs]
  __x64_sys_fsync+0x34/0x60
  do_syscall_64+0x33/0x40
  entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7f654cf26deb
Code: 4a 00 00 00 0f 05 48 3d 00 f0 ff ff 77 41 c3 48 83 ec 18 89 7c 24 0c e8 33 f7 ff ff 8b 7c 24 0c 41 89 c0 b8 4a 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 44 89>
RSP: 002b:00007f654b80db10 EFLAGS: 00000293 ORIG_RAX: 000000000000004a
RAX: ffffffffffffffda RBX: 00005636c966b410 RCX: 00007f654cf26deb
RDX: 0000000000000002 RSI: 00007f654d169d43 RDI: 0000000000000016
RBP: 00007f654d16c6f0 R08: 0000000000000000 R09: 00007f654b80e640
R10: 0000000000000003 R11: 0000000000000293 R12: 0000000000000002
R13: 00007ffc8bd7461f R14: 0000000000000000 R15: 00007f654b80e640
---[ end trace 3cefecf5d9d20b84 ]---

This is a KVM guest on an AMD host. A similar machine on an Intel host doesn't show this.
There is a single BTRFS filesystem on LUKS. It has been created like:

	mkfs.btrfs --csum blake2 -d single -m single /dev/mapper/rootfs

I've tested Manjaro's 5.11.10 kernel too. No change. btrfs-check (5.11.1) shows nothing.
I've even recreated the filesystem. No change. Maybe the machine without warnings uses
the default hash. How can I find out?

Thanks!
Markus
