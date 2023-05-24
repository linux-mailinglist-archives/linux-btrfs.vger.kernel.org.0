Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C063E70ED74
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 May 2023 07:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239558AbjEXF5k convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 24 May 2023 01:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239557AbjEXF5j (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 May 2023 01:57:39 -0400
Received: from ste-pvt-msa2.bahnhof.se (ste-pvt-msa2.bahnhof.se [213.80.101.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615D518C
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 22:57:31 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 64FAB3F625;
        Wed, 24 May 2023 07:57:28 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -1.909
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id rVVekqIJHOZ4; Wed, 24 May 2023 07:57:27 +0200 (CEST)
Received: by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 65C073F61C;
        Wed, 24 May 2023 07:57:26 +0200 (CEST)
Received: from [192.168.0.126] (port=38166)
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <forza@tnonline.net>)
        id 1q1hUu-000241-UK; Wed, 24 May 2023 07:57:25 +0200
Date:   Wed, 24 May 2023 07:57:19 +0200 (GMT+02:00)
From:   Forza <forza@tnonline.net>
To:     Uladzislau Rezki <urezki@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Stable <stable@vger.kernel.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, a1bert@atlas.cz,
        urezki@gmail.com
Message-ID: <c9db92d.faed4a1c.1884c5550fb@tnonline.net>
In-Reply-To: <ZGyVVQxnw6Tn7Xb8@pc636>
References: <efa04d56-cd7f-6620-bca7-1df89f49bf4b@gmail.com> <fcf1d04.faed4a1a.18844d8e78f@tnonline.net> <ZGwcVTpQNBoJHBB+@debian.me> <ZGyVVQxnw6Tn7Xb8@pc636>
Subject: Re: Fwd: vmalloc error: btrfs-delalloc btrfs_work_helper [btrfs] in
 kernel 6.3.x
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
X-Mailer: R2Mail2
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



---- From: Uladzislau Rezki <urezki@gmail.com> -- Sent: 2023-05-23 - 12:28 ----

> On Tue, May 23, 2023 at 08:52:21AM +0700, Bagas Sanjaya wrote:
>> On Mon, May 22, 2023 at 09:04:05PM +0200, Forza wrote:
>> > I have a similar experience with kernel 6.3 where vmalloc fails in a similar way. I was able to reproduce it in a QEMU VM as well as on my system. 
>> > 
>> > https://lore.kernel.org/all/d11418b6-38e5-eb78-1537-c39245dc0b78@tnonline.net/T/
>> 
>> Thanks for your similar report. Telling regzbot about it:
>> 
>> #regzbot link: https://lore.kernel.org/all/d11418b6-38e5-eb78-1537-c39245dc0b78@tnonline.net/
>> 
> It is good that you can reproduce it. Could you please test below patch?
> 
> <snip>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 31ff782d368b..7a06452f7807 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2957,14 +2957,18 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>                         page = alloc_pages(alloc_gfp, order);
>                 else
>                         page = alloc_pages_node(nid, alloc_gfp, order);
> +
>                 if (unlikely(!page)) {
> -                       if (!nofail)
> -                               break;
> +                       if (nofail)
> +                               alloc_gfp |= __GFP_NOFAIL;
> 
> -                       /* fall back to the zero order allocations */
> -                       alloc_gfp |= __GFP_NOFAIL;
> -                       order = 0;
> -                       continue;
> +                       /* Fall back to the zero order allocations. */
> +                       if (order || nofail) {
> +                               order = 0;
> +                               continue;
> +                       }
> +
> +                       break;
>                 }
> 
>                 /*
> <snip>
> 
> Thanks!
> 
> --
> Uladzislau Rezki


There is a different result now that I have not seen before. The full dmesg is available at https://paste.tnonline.net/files/pnnW6gYASxWX_dmesg-mm-patch.txt


[   8.641506] 8021q: adding VLAN 0 to HW filter on device enp4s0
[   13.841691] wireguard: WireGuard 1.0.0 loaded. See www.wireguard.com for information.
[   13.841705] wireguard: Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
[13917.280527] ------------[ cut here ]------------
[13917.280753] default_enter_idle leaked IRQ state
[13917.281004] WARNING: CPU: 3 PID: 0 at drivers/cpuidle/cpuidle.c:269 cpuidle_enter_state+0x3bb/0x430
[13917.281046] Modules linked in: wireguard curve25519_x86_64 libcurve25519_generic ip6_udp_tunnel udp_tunnel cfg80211 rfkill 8021q garp mrp stp llc binfmt_misc intel_rapl_msr intel_rapl_common kvm_amd iTCO_wdt ccp intel_pmc_bxt iTCO_vendor_support kvm i2c_i801 virtio_gpu irqbypass pcspkr virtio_dma_buf joydev i2c_smbus drm_shmem_helper lpc_ich virtio_balloon drm_kms_helper crct10dif_pclmul crc32_pclmul crc32c_intel polyval_clmulni polyval_generic ghash_clmulni_intel sha512_ssse3 virtio_console virtio_net net_failover virtio_scsi failover serio_raw virtio_blk qemu_fw_cfg
[13917.281140] CPU: 3 PID: 0 Comm: swapper/3 Not tainted 6.3.1-gentoo-mm-patched #4
[13917.281150] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.0-20220807_005459-localhost 04/01/2014
[13917.281154] RIP: 0010:cpuidle_enter_state+0x3bb/0x430
[13917.281162] Code: 0f 1f 44 00 00 e9 a7 fd ff ff 80 3d 3a 3b d7 00 00 75 19 49 8b 75 50 48 c7 c7 ab b6 79 ac c6 05 26 3b d7 00 01 e8 a5 c4 20 ff <0f> 0b fa 0f 1f 44 00 00 e9 ca fc ff ff 83 c0 01 48 83 c1 40 39 f8
[13917.281176] RSP: 0018:ffffa153c00b7ea0 EFLAGS: 00010286
[13917.281182] RAX: ffff8c15ebfafa28 RBX: ffffc153bfd80900 RCX: 000000000000083f
[13917.281186] RDX: 000000000118feed RSI: 00000000000000f6 RDI: 000000000000083f
[13917.281189] RBP: 0000000000000001 R08: 0000000000000000 R09: ffffa153c00b7d60
[13917.281193] R10: 0000000000000003 R11: ffffffffacb399e8 R12: ffffffffacc2e320
[13917.281196] R13: ffffffffacc2e3a0 R14: 0000000000000001 R15: 0000000000000000
[13917.281202] FS:  0000000000000000(0000) GS:ffff8c15ebf80000(0000) knlGS:0000000000000000
[13917.281206] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[13917.281210] CR2: 00007f71840b39c8 CR3: 0000000102998000 CR4: 00000000003506e0
[13917.281217] Call Trace:
[13917.281221]  <TASK>
[13917.281228]  cpuidle_enter+0x29/0x40
[13917.281244]  do_idle+0x19b/0x200
[13917.281292]  cpu_startup_entry+0x19/0x20
[13917.281297]  start_secondary+0x101/0x120
[13917.281324]  secondary_startup_64_no_verify+0xe5/0xeb
[13917.281343]  </TASK>
[13917.281346] ---[ end trace 0000000000000000 ]---
[17206.750165] BTRFS info (device vdb): using xxhash64 (xxhash64-generic) checksum algorithm
[17206.750190] BTRFS info (device vdb): using free space tree
[17206.904010] BTRFS info (device vdb): auto enabling async discard
[17206.933302] BTRFS info (device vdb): checking UUID tree
[17344.541839] sched: RT throttling activated
[18284.216538] hrtimer: interrupt took 23434934 ns
[18737.100477] BUG: unable to handle page fault for address: 0000000079e0afc0
[18737.100883] #PF: supervisor read access in kernel mode
[18737.101155] #PF: error_code(0x0000) - not-present page
[18737.101462] PGD 0 P4D 0 
[18737.101715] Oops: 0000 [#1] PREEMPT SMP NOPTI
[18737.101968] CPU: 1 PID: 25287 Comm: kworker/u8:7 Tainted: G        W          6.3.1-gentoo-mm-patched #4
[18737.102391] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.0-20220807_005459-localhost 04/01/2014
[18737.102860] Workqueue: btrfs-delalloc btrfs_work_helper
[18737.103346] RIP: 0010:find_free_extent+0x20a/0x15c0
[18737.103900] Code: 4d 8d ba 10 ff ff ff 48 83 c0 0f 49 8d 97 f0 00 00 00 48 c1 e0 04 48 01 d8 48 39 c2 0f 84 c5 03 00 00 41 c6 85 84 00 00 00 00 <45> 8b 9f b0 00 00 00 45 85 db 0f 85 d8 0c 00 00 45 8b 75 28 4c 89
[18737.104851] RSP: 0018:ffffa153c0923bd0 EFLAGS: 00010203
[18737.105456] RAX: ffff8c14869240f0 RBX: ffff8c1486924000 RCX: 0000000000000001
[18737.106044] RDX: 0000000079e0b000 RSI: 0000000000000100 RDI: ffff8c14869bcc00
[18737.106519] RBP: ffff8c148b100000 R08: 0000000000000000 R09: 0000000000000000
[18737.107036] R10: 0000000079e0b000 R11: 000000000000151b R12: ffffa153c0923dd7
[18737.107363] R13: ffffa153c0923c90 R14: 0000000000000001 R15: 0000000079e0af10
[18737.107676] FS:  0000000000000000(0000) GS:ffff8c15ebe80000(0000) knlGS:0000000000000000
[18737.107971] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[18737.108260] CR2: 0000000079e0afc0 CR3: 00000001055e8000 CR4: 00000000003506e0
[18737.108606] Call Trace:
[18737.108964]  <TASK>
[18737.109273]  btrfs_reserve_extent+0x148/0x260
[18737.109601]  submit_compressed_extents+0x14f/0x490
[18737.109934]  async_cow_submit+0x37/0x90
[18737.110237]  btrfs_work_helper+0x13d/0x360
[18737.110542]  process_one_work+0x20f/0x410
[18737.110883]  worker_thread+0x4a/0x3b0
[18737.111185]  ? __pfx_worker_thread+0x10/0x10
[18737.111482]  kthread+0xda/0x100
[18737.111800]  ? __pfx_kthread+0x10/0x10
[18737.112097]  ret_from_fork+0x2c/0x50
[18737.112387]  </TASK>
[18737.112676] Modules linked in: wireguard curve25519_x86_64 libcurve25519_generic ip6_udp_tunnel udp_tunnel cfg80211 rfkill 8021q garp mrp stp llc binfmt_misc intel_rapl_msr intel_rapl_common kvm_amd iTCO_wdt ccp intel_pmc_bxt iTCO_vendor_support kvm i2c_i801 virtio_gpu irqbypass pcspkr virtio_dma_buf joydev i2c_smbus drm_shmem_helper lpc_ich virtio_balloon drm_kms_helper crct10dif_pclmul crc32_pclmul crc32c_intel polyval_clmulni polyval_generic ghash_clmulni_intel sha512_ssse3 virtio_console virtio_net net_failover virtio_scsi failover serio_raw virtio_blk qemu_fw_cfg
[18737.114021] CR2: 0000000079e0afc0
[18737.114366] ---[ end trace 0000000000000000 ]---
[18737.114712] RIP: 0010:find_free_extent+0x20a/0x15c0
[18737.115059] Code: 4d 8d ba 10 ff ff ff 48 83 c0 0f 49 8d 97 f0 00 00 00 48 c1 e0 04 48 01 d8 48 39 c2 0f 84 c5 03 00 00 41 c6 85 84 00 00 00 00 <45> 8b 9f b0 00 00 00 45 85 db 0f 85 d8 0c 00 00 45 8b 75 28 4c 89
[18737.115864] RSP: 0018:ffffa153c0923bd0 EFLAGS: 00010203
[18737.116415] RAX: ffff8c14869240f0 RBX: ffff8c1486924000 RCX: 0000000000000001
[18737.117090] RDX: 0000000079e0b000 RSI: 0000000000000100 RDI: ffff8c14869bcc00
[18737.117882] RBP: ffff8c148b100000 R08: 0000000000000000 R09: 0000000000000000
[18737.118611] R10: 0000000079e0b000 R11: 000000000000151b R12: ffffa153c0923dd7
[18737.119416] R13: ffffa153c0923c90 R14: 0000000000000001 R15: 0000000079e0af10
[18737.120221] FS:  0000000000000000(0000) GS:ffff8c15ebe80000(0000) knlGS:0000000000000000
[18737.120994] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[18737.121868] CR2: 0000000079e0afc0 CR3: 00000001055e8000 CR4: 00000000003506e0
[18737.122624] note: kworker/u8:7[25287] exited with irqs disabled
[19006.920558] BUG: unable to handle page fault for address: 0000000079e0afc0
[19006.922015] #PF: supervisor read access in kernel mode
[19006.923354] #PF: error_code(0x0000) - not-present page
[19006.924636] PGD 0 P4D 0 
[19006.925868] Oops: 0000 [#2] PREEMPT SMP NOPTI
[19006.927066] CPU: 0 PID: 24329 Comm: crawl_writeback Tainted: G      D W          6.3.1-gentoo-mm-patched #4
[19006.928510] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.0-20220807_005459-localhost 04/01/2014
[19006.929817] RIP: 0010:find_free_extent+0x20a/0x15c0
[19006.931050] Code: 4d 8d ba 10 ff ff ff 48 83 c0 0f 49 8d 97 f0 00 00 00 48 c1 e0 04 48 01 d8 48 39 c2 0f 84 c5 03 00 00 41 c6 85 84 00 00 00 00 <45> 8b 9f b0 00 00 00 45 85 db 0f 85 d8 0c 00 00 45 8b 75 28 4c 89
[19006.933653] RSP: 0018:ffffa153c0d0f568 EFLAGS: 00010203
[19006.934972] RAX: ffff8c14869240f0 RBX: ffff8c1486924000 RCX: 0000000000000001
[19006.936236] RDX: 0000000079e0b000 RSI: 0000000000000100 RDI: ffff8c14869bcc00
[19006.937480] RBP: ffff8c148b100000 R08: 0000000000000000 R09: 0000000000000000
[19006.938750] R10: 0000000079e0b000 R11: 000000000000151b R12: ffffa153c0d0f757
[19006.939986] R13: ffffa153c0d0f628 R14: 0000000000000001 R15: 0000000079e0af10
[19006.941255] FS:  00007fb245ffb6c0(0000) GS:ffff8c15ebe00000(0000) knlGS:0000000000000000
[19006.942579] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[19006.943830] CR2: 0000000079e0afc0 CR3: 00000001055e8000 CR4: 00000000003506f0
[19006.945278] Call Trace:
[19006.946730]  <TASK>
[19006.947792]  ? release_pages+0x13e/0x490
[19006.948741]  btrfs_reserve_extent+0x148/0x260
[19006.949637]  cow_file_range+0x199/0x610
[19006.950396]  btrfs_run_delalloc_range+0x103/0x520
[19006.951135]  ? find_lock_delalloc_range+0x1ea/0x210
[19006.951802]  writepage_delalloc+0xb9/0x180
[19006.952401]  __extent_writepage+0xeb/0x410
[19006.952985]  extent_write_cache_pages+0x152/0x3d0
[19006.953552]  extent_writepages+0x4c/0x100
[19006.954116]  do_writepages+0xbe/0x1d0
[19006.954672]  ? memcmp_extent_buffer+0xa2/0xe0
[19006.955199]  filemap_fdatawrite_wbc+0x5f/0x80
[19006.955726]  __filemap_fdatawrite_range+0x4a/0x60
[19006.956219]  btrfs_rename+0x529/0xb60
[19006.956711]  ? psi_group_change+0x168/0x400
[19006.957280]  btrfs_rename2+0x2a/0x60
[19006.957799]  vfs_rename+0x5d4/0xeb0
[19006.958308]  ? lookup_dcache+0x17/0x60
[19006.958784]  ? do_renameat2+0x507/0x580
[19006.959239]  do_renameat2+0x507/0x580
[19006.959702]  __x64_sys_renameat+0x45/0x60
[19006.960293]  do_syscall_64+0x5b/0xc0
[19006.960848]  ? syscall_exit_to_user_mode+0x17/0x40
[19006.961331]  ? do_syscall_64+0x67/0xc0
[19006.961812]  ? syscall_exit_to_user_mode+0x17/0x40
[19006.962401]  ? do_syscall_64+0x67/0xc0
[19006.963371]  ? do_syscall_64+0x67/0xc0
[19006.964020]  ? do_syscall_64+0x67/0xc0
[19006.965001]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[19006.965952] RIP: 0033:0x7fb25eba492a
[19006.966485] Code: 48 8b 15 d9 44 17 00 f7 d8 64 89 02 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 08 01 00 00 0f 05 <48> 3d 00 f0 ff ff 77 06 c3 0f 1f 44 00 00 48 8b 15 a1 44 17 00 f7
[19006.967545] RSP: 002b:00007fb245ff8a08 EFLAGS: 00000246 ORIG_RAX: 0000000000000108
[19006.968076] RAX: ffffffffffffffda RBX: 0000559a70a039f0 RCX: 00007fb25eba492a
[19006.968623] RDX: 0000000000000004 RSI: 00007fb134000fc0 RDI: 0000000000000004
[19006.977319] RBP: 00007fb245ff8c60 R08: 0000000000000000 R09: 0000000000000000
[19006.977877] R10: 0000559a70a03a00 R11: 0000000000000246 R12: 00007fb245ff8c80
[19006.978301] R13: 0000000000000004 R14: 00007fb245ff8c60 R15: 00000000000070b5
[19006.978727]  </TASK>
[19006.979118] Modules linked in: wireguard curve25519_x86_64 libcurve25519_generic ip6_udp_tunnel udp_tunnel cfg80211 rfkill 8021q garp mrp stp llc binfmt_misc intel_rapl_msr intel_rapl_common kvm_amd iTCO_wdt ccp intel_pmc_bxt iTCO_vendor_support kvm i2c_i801 virtio_gpu irqbypass pcspkr virtio_dma_buf joydev i2c_smbus drm_shmem_helper lpc_ich virtio_balloon drm_kms_helper crct10dif_pclmul crc32_pclmul crc32c_intel polyval_clmulni polyval_generic ghash_clmulni_intel sha512_ssse3 virtio_console virtio_net net_failover virtio_scsi failover serio_raw virtio_blk qemu_fw_cfg
[19006.981463] CR2: 0000000079e0afc0
[19006.982193] ---[ end trace 0000000000000000 ]---
[19006.982938] RIP: 0010:find_free_extent+0x20a/0x15c0
[19006.983565] Code: 4d 8d ba 10 ff ff ff 48 83 c0 0f 49 8d 97 f0 00 00 00 48 c1 e0 04 48 01 d8 48 39 c2 0f 84 c5 03 00 00 41 c6 85 84 00 00 00 00 <45> 8b 9f b0 00 00 00 45 85 db 0f 85 d8 0c 00 00 45 8b 75 28 4c 89
[19006.984863] RSP: 0018:ffffa153c0923bd0 EFLAGS: 00010203
[19006.985500] RAX: ffff8c14869240f0 RBX: ffff8c1486924000 RCX: 0000000000000001
[19006.986195] RDX: 0000000079e0b000 RSI: 0000000000000100 RDI: ffff8c14869bcc00
[19006.986877] RBP: ffff8c148b100000 R08: 0000000000000000 R09: 0000000000000000
[19006.987581] R10: 0000000079e0b000 R11: 000000000000151b R12: ffffa153c0923dd7
[19006.988252] R13: ffffa153c0923c90 R14: 0000000000000001 R15: 0000000079e0af10
[19006.988984] FS:  00007fb245ffb6c0(0000) GS:ffff8c15ebe00000(0000) knlGS:0000000000000000
[19006.989646] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[19006.990336] CR2: 0000000079e0afc0 CR3: 00000001055e8000 CR4: 00000000003506f0
[19006.991037] note: crawl_writeback[24329] exited with irqs disabled

 





