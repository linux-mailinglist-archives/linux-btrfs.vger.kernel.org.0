Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B58271268E
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 May 2023 14:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243436AbjEZMZF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 May 2023 08:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243254AbjEZMZC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 May 2023 08:25:02 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479B819C;
        Fri, 26 May 2023 05:25:01 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f3baf04f0cso695189e87.1;
        Fri, 26 May 2023 05:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685103899; x=1687695899;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aCxaS8AedR5E5f0cNOyUXubK0dk8IWGEj4t+P6r+HeI=;
        b=LkxAiNKEAAAMKe2rW8QXkXdxnSvJ5eCuQRj7d1ZSfE1XmtA8Q5wgjowp4t6SU3V1lf
         GQ0qJ53oMEZ7UT6h++UuqhPr7hHbnU+0OP9VAs65NPgF0hx8jNLchNftfuR9+CoRmjwx
         hZ94TuUsOsmdDvB2W3mm/ew/puxpE2bDlwWMR+ha2DpIvspHeode5mG0XXQ/WPlBBjuD
         PdTW0tXwWYVwIfbB9/G2K2Jz/mQHvYXNzC6u9egCFrQEqLFpolqt+7DfE3RCx1CJ7FDM
         5CzXLE88GGohMDX9L+UWICOOdVFJ59np0czUvRfRxbGSBjVELiIWoWwc4u4lsiY/NW8j
         bIWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685103899; x=1687695899;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aCxaS8AedR5E5f0cNOyUXubK0dk8IWGEj4t+P6r+HeI=;
        b=KDxpdCVRYhHeZl5tHClwTQ0W7zB0VQxsOjhK3r+nG9p9boE/K7ZaBidc24vP80/BMc
         QSPwFBTcml1usepCVKHhzm5KO2Y3KIeS6ah5Ph5TbqsAssXdgf1bMwgZMHZeFqfuNdxr
         95Lr5wmm/xO5eKq8UvZb8KdY7sDvyf8YLmRH9NKLUCAtVkETajyyC7XOdY7dk0gfoHah
         0Ry4cW8cU0rRjlpsJUhmEx6DpbuopUrca69nUaRE6SzW8ZmZl0lZAMsO1g0+OS+kIXjO
         mldFik0Yn0owVdb/r9CKJiD28HLJbmYLfJcKvRu3L5EtiQbV8s0D21Z6fkRPWIsTDze5
         /2yA==
X-Gm-Message-State: AC+VfDxAEBN8FjnKLdQFc+yHDM+hm5K20FpAHHj3SspbkBWyo7ZTj33Q
        vO7k+4c6VLAYgBeQBRq/zR8=
X-Google-Smtp-Source: ACHHUZ4eTnmzk1lK5/dd1vKKhpQkVvv/HpqoM9Sp71Yr4VMD4WScS/aHaG2S/g3yVI///f7Q8zDjlw==
X-Received: by 2002:a19:f816:0:b0:4f3:a812:5ae with SMTP id a22-20020a19f816000000b004f3a81205aemr518235lff.37.1685103899083;
        Fri, 26 May 2023 05:24:59 -0700 (PDT)
Received: from pc636 (host-90-235-19-70.mobileonline.telia.com. [90.235.19.70])
        by smtp.gmail.com with ESMTPSA id b12-20020ac247ec000000b004f3830143f2sm593797lfp.253.2023.05.26.05.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 05:24:58 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Fri, 26 May 2023 14:24:56 +0200
To:     Forza <forza@tnonline.net>, Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Forza <forza@tnonline.net>, Uladzislau Rezki <urezki@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Stable <stable@vger.kernel.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, a1bert@atlas.cz
Subject: Re: Fwd: vmalloc error: btrfs-delalloc btrfs_work_helper [btrfs] in
 kernel 6.3.x
Message-ID: <ZHClGA9szxSqzDf8@pc636>
References: <efa04d56-cd7f-6620-bca7-1df89f49bf4b@gmail.com>
 <fcf1d04.faed4a1a.18844d8e78f@tnonline.net>
 <ZGwcVTpQNBoJHBB+@debian.me>
 <ZGyVVQxnw6Tn7Xb8@pc636>
 <c9db92d.faed4a1c.1884c5550fb@tnonline.net>
 <20230524091357.GH32559@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230524091357.GH32559@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 24, 2023 at 11:13:57AM +0200, David Sterba wrote:
> This looks like a different set of problems, though all of them seem to
> start on the compression write path in btrfs.
> 
> On Wed, May 24, 2023 at 07:57:19AM +0200, Forza wrote:
> > [   8.641506] 8021q: adding VLAN 0 to HW filter on device enp4s0
> > [   13.841691] wireguard: WireGuard 1.0.0 loaded. See www.wireguard.com for information.
> > [   13.841705] wireguard: Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
> > [13917.280527] ------------[ cut here ]------------
> > [13917.280753] default_enter_idle leaked IRQ state
> > [13917.281004] WARNING: CPU: 3 PID: 0 at drivers/cpuidle/cpuidle.c:269 cpuidle_enter_state+0x3bb/0x430
> 
> Warning in cpuilde
> 
> > [13917.281046] Modules linked in: wireguard curve25519_x86_64 libcurve25519_generic ip6_udp_tunnel udp_tunnel cfg80211 rfkill 8021q garp mrp stp llc binfmt_misc intel_rapl_msr intel_rapl_common kvm_amd iTCO_wdt ccp intel_pmc_bxt iTCO_vendor_support kvm i2c_i801 virtio_gpu irqbypass pcspkr virtio_dma_buf joydev i2c_smbus drm_shmem_helper lpc_ich virtio_balloon drm_kms_helper crct10dif_pclmul crc32_pclmul crc32c_intel polyval_clmulni polyval_generic ghash_clmulni_intel sha512_ssse3 virtio_console virtio_net net_failover virtio_scsi failover serio_raw virtio_blk qemu_fw_cfg
> > [13917.281140] CPU: 3 PID: 0 Comm: swapper/3 Not tainted 6.3.1-gentoo-mm-patched #4
> > [13917.281150] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.0-20220807_005459-localhost 04/01/2014
> > [13917.281154] RIP: 0010:cpuidle_enter_state+0x3bb/0x430
> > [13917.281176] RSP: 0018:ffffa153c00b7ea0 EFLAGS: 00010286
> > [13917.281182] RAX: ffff8c15ebfafa28 RBX: ffffc153bfd80900 RCX: 000000000000083f
> > [13917.281186] RDX: 000000000118feed RSI: 00000000000000f6 RDI: 000000000000083f
> > [13917.281189] RBP: 0000000000000001 R08: 0000000000000000 R09: ffffa153c00b7d60
> > [13917.281193] R10: 0000000000000003 R11: ffffffffacb399e8 R12: ffffffffacc2e320
> > [13917.281196] R13: ffffffffacc2e3a0 R14: 0000000000000001 R15: 0000000000000000
> > [13917.281202] FS:  0000000000000000(0000) GS:ffff8c15ebf80000(0000) knlGS:0000000000000000
> > [13917.281206] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [13917.281210] CR2: 00007f71840b39c8 CR3: 0000000102998000 CR4: 00000000003506e0
> > [13917.281217] Call Trace:
> > [13917.281221]  <TASK>
> > [13917.281228]  cpuidle_enter+0x29/0x40
> > [13917.281244]  do_idle+0x19b/0x200
> > [13917.281292]  cpu_startup_entry+0x19/0x20
> > [13917.281297]  start_secondary+0x101/0x120
> > [13917.281324]  secondary_startup_64_no_verify+0xe5/0xeb
> > [13917.281343]  </TASK>
> > [13917.281346] ---[ end trace 0000000000000000 ]---
> > [17206.750165] BTRFS info (device vdb): using xxhash64 (xxhash64-generic) checksum algorithm
> > [17206.750190] BTRFS info (device vdb): using free space tree
> > [17206.904010] BTRFS info (device vdb): auto enabling async discard
> > [17206.933302] BTRFS info (device vdb): checking UUID tree
> > [17344.541839] sched: RT throttling activated
> > [18284.216538] hrtimer: interrupt took 23434934 ns
> > [18737.100477] BUG: unable to handle page fault for address: 0000000079e0afc0
> 
> BUG
> 
> > [18737.100883] #PF: supervisor read access in kernel mode
> > [18737.101155] #PF: error_code(0x0000) - not-present page
> > [18737.101462] PGD 0 P4D 0 
> > [18737.101715] Oops: 0000 [#1] PREEMPT SMP NOPTI
> > [18737.101968] CPU: 1 PID: 25287 Comm: kworker/u8:7 Tainted: G        W          6.3.1-gentoo-mm-patched #4
> > [18737.102391] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.0-20220807_005459-localhost 04/01/2014
> > [18737.102860] Workqueue: btrfs-delalloc btrfs_work_helper
> > [18737.103346] RIP: 0010:find_free_extent+0x20a/0x15c0
> > [18737.103900] Code: 4d 8d ba 10 ff ff ff 48 83 c0 0f 49 8d 97 f0 00 00 00 48 c1 e0 04 48 01 d8 48 39 c2 0f 84 c5 03 00 00 41 c6 85 84 00 00 00 00 <45> 8b 9f b0 00 00 00 45 85 db 0f 85 d8 0c 00 00 45 8b 75 28 4c 89
> > [18737.104851] RSP: 0018:ffffa153c0923bd0 EFLAGS: 00010203
> > [18737.105456] RAX: ffff8c14869240f0 RBX: ffff8c1486924000 RCX: 0000000000000001
> > [18737.106044] RDX: 0000000079e0b000 RSI: 0000000000000100 RDI: ffff8c14869bcc00
> > [18737.106519] RBP: ffff8c148b100000 R08: 0000000000000000 R09: 0000000000000000
> > [18737.107036] R10: 0000000079e0b000 R11: 000000000000151b R12: ffffa153c0923dd7
> > [18737.107363] R13: ffffa153c0923c90 R14: 0000000000000001 R15: 0000000079e0af10
> > [18737.107676] FS:  0000000000000000(0000) GS:ffff8c15ebe80000(0000) knlGS:0000000000000000
> > [18737.107971] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [18737.108260] CR2: 0000000079e0afc0 CR3: 00000001055e8000 CR4: 00000000003506e0
> > [18737.108606] Call Trace:
> > [18737.108964]  <TASK>
> > [18737.109273]  btrfs_reserve_extent+0x148/0x260
> > [18737.109601]  submit_compressed_extents+0x14f/0x490
> > [18737.109934]  async_cow_submit+0x37/0x90
> > [18737.110237]  btrfs_work_helper+0x13d/0x360
> > [18737.110542]  process_one_work+0x20f/0x410
> > [18737.110883]  worker_thread+0x4a/0x3b0
> > [18737.111185]  ? __pfx_worker_thread+0x10/0x10
> > [18737.111482]  kthread+0xda/0x100
> > [18737.111800]  ? __pfx_kthread+0x10/0x10
> > [18737.112097]  ret_from_fork+0x2c/0x50
> > [18737.112387]  </TASK>
> > [18737.112676] Modules linked in: wireguard curve25519_x86_64 libcurve25519_generic ip6_udp_tunnel udp_tunnel cfg80211 rfkill 8021q garp mrp stp llc binfmt_misc intel_rapl_msr intel_rapl_common kvm_amd iTCO_wdt ccp intel_pmc_bxt iTCO_vendor_support kvm i2c_i801 virtio_gpu irqbypass pcspkr virtio_dma_buf joydev i2c_smbus drm_shmem_helper lpc_ich virtio_balloon drm_kms_helper crct10dif_pclmul crc32_pclmul crc32c_intel polyval_clmulni polyval_generic ghash_clmulni_intel sha512_ssse3 virtio_console virtio_net net_failover virtio_scsi failover serio_raw virtio_blk qemu_fw_cfg
> > [18737.114021] CR2: 0000000079e0afc0
> > [18737.114366] ---[ end trace 0000000000000000 ]---
> > [18737.114712] RIP: 0010:find_free_extent+0x20a/0x15c0
> > [18737.115059] Code: 4d 8d ba 10 ff ff ff 48 83 c0 0f 49 8d 97 f0 00 00 00 48 c1 e0 04 48 01 d8 48 39 c2 0f 84 c5 03 00 00 41 c6 85 84 00 00 00 00 <45> 8b 9f b0 00 00 00 45 85 db 0f 85 d8 0c 00 00 45 8b 75 28 4c 89
> > [18737.115864] RSP: 0018:ffffa153c0923bd0 EFLAGS: 00010203
> > [18737.116415] RAX: ffff8c14869240f0 RBX: ffff8c1486924000 RCX: 0000000000000001
> > [18737.117090] RDX: 0000000079e0b000 RSI: 0000000000000100 RDI: ffff8c14869bcc00
> > [18737.117882] RBP: ffff8c148b100000 R08: 0000000000000000 R09: 0000000000000000
> > [18737.118611] R10: 0000000079e0b000 R11: 000000000000151b R12: ffffa153c0923dd7
> > [18737.119416] R13: ffffa153c0923c90 R14: 0000000000000001 R15: 0000000079e0af10
> > [18737.120221] FS:  0000000000000000(0000) GS:ffff8c15ebe80000(0000) knlGS:0000000000000000
> > [18737.120994] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [18737.121868] CR2: 0000000079e0afc0 CR3: 00000001055e8000 CR4: 00000000003506e0
> > [18737.122624] note: kworker/u8:7[25287] exited with irqs disabled
> > [19006.920558] BUG: unable to handle page fault for address: 0000000079e0afc0
> 
> And again, so something is going wrong
> 
Indeed.

I suggest you run your kernel with CONFIG_KASAN=y to see if there are
any use-after-free or out-of-bounds bugs.

--
Uladzislau Rezki
