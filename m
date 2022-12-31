Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8036C65A849
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Jan 2023 00:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbiLaXwS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 31 Dec 2022 18:52:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbiLaXwQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 31 Dec 2022 18:52:16 -0500
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B325FF6
        for <linux-btrfs@vger.kernel.org>; Sat, 31 Dec 2022 15:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1672530732; bh=vuZkYatIJtYmiKltGHxTNJG/sZ0TW2+YQzH01b7f1RM=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=trfbJd+HjsU9+bKgZC0VTZhHZEHqGWYgkm8qjXJBzwjL9nGJIoZo8wiMQshR0xGGQ
         klH+8zRocx/PtsAI6836BFUw3qaOl5d72Y9XVxX5QuJWe1jBDfjP7SOXVPfxOS/azj
         aFn+tNeqiY2PTDk06G76TjSocz2/m1EpJF1sUIE+/Bz1XpU2DUOH1Uc+BZJpeWiGyD
         bqfNb4eLoK12xHr+hNdehQeK0ngO4SAjEGbZQmLBAXFU6J0k1pXRUONXOnhuMqOqVp
         /racVFbPaEIQlGSPm+qO0hRY+9DB/U9aBLUUw/RyHPNFERpriOiQrY9BEHjJEu/CVX
         fcw73kUIzsZTg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from gecko.fritz.box ([82.207.254.103]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MTOli-1pNpPE0iRo-00U7TC for
 <linux-btrfs@vger.kernel.org>; Sun, 01 Jan 2023 00:52:12 +0100
Date:   Sat, 31 Dec 2022 23:51:49 +0000
From:   Lukas Straub <lukasstraub2@web.de>
To:     Btrfs <linux-btrfs@vger.kernel.org>
Subject: btrfs blocks suspend while scrub is running
Message-ID: <20221231235128.0c86b7c5@gecko.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/zsFT+u+5L.fmurSGU/LiVe=";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Provags-ID: V03:K1:c1ruGpJKSCuCMwQehuf1p+boDewZ1u3NpgfLV6VgEhYh17L2HR+
 LGT0QPn+SDXLMzgjmVzNtz0i4YlVZjlCli7WIx7T4NNfm0Q4zwMGbBLytDoVYhfBZH2MW2Y
 3lVih6U0l6sDW5lTgwLHreKU2PZdNqxGVnIj3imMwpsr0suiE+I+HGUbKlqddetRJYNcneq
 7FnGablAeJ4LZyU+RvycA==
UI-OutboundReport: notjunk:1;M01:P0:1p4Vkrdp7ig=;cWAoxh2t7NHkxP0A8N/lqwC59+u
 YlquP5NKJU84jBELl0nEipJg48SXiDMIc3e2TbkokZc1w6bDVD2HVkZxTMzWism5Yb6aH1G2q
 vNtGk9UTymwjZ5bpKBfaGXb4s68wpsEdClI532lU2vAZGEqv+1nyaTnAtDVtK9DU5Hpoi5d6e
 ZWHW1zHM7K134gcC90TQUvymq5uuYjaaRN0aa2UQcuuycS7l9mxChv6q1KGI4p/JwFUmpf8jR
 HddIdeH5t46RhL7CJb1/9MfwUw1VocY1sTzsrQVU9+wfacnu8CVqk03ss3Cad8Xej8qJlxzfh
 9UbtNMBTuQnZqvDXDFKsMPSEso8u7K7PqxS7pzGqTRN+Y/L1AHgWeH71qL6UW3TcPwFAvOAOe
 6qNAI0TzFCtOuq1I/RpIwOM9HTLcu7xER8+XbiwYvfo2xF6Cz8L7JLrOxhru+8yIqPVS1YWcZ
 A75iD77asPoRZ0er18EUq78b4D6IY5NW9J5+IGud0jRx44YiH6/LdYQw3ajlHTiGWJ46UrBDW
 1dOuwqJXBcwbP4qHJJu+KFyD2aPYbWQNLdc9c5pypYvj7+HgqTD4m7E+BnpqcWPhn9cBaCPj2
 MuwjhixtsKuOz4mSLBXgUvzDBYmOA4MDMxPipdKYA8/EYUBqFWBt+EtpV0Mju4pPQClpz8f2s
 2X7lREFkbdQS9a3a8zpGseH48sqGeBICN+toEjZhXf7L+YPYDmWQhx/NwtMa2DZcSCui9+vrK
 nNAtP3gwBk4WmOFZHL3j2VBqJf2jFg+3v4sG725rHwABdRNc1NQvQCCHtFlVNYQm75Fl6+Nv+
 xVhANfgmYY7LG+flcLfJZv6FdpHqtLUB819mXQVADBF47DgJbhXLTTzNXOc+xirJ2MCwd43eS
 Z3Zx0wnuLgLq7fUgjWAu39eW43jo1uIHhD706qWQwPH6Ni1GspVTUc+55Nz3rxCYvUKawkPbW
 i2+kf7iUQG1JNQMvpSpN/wSfwSw=
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--Sig_/zsFT+u+5L.fmurSGU/LiVe=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hello Everyone,
I just noticed that btrfs blocks the kernel from suspending while scrub is =
running:

Happy new year btw :)

Linux gecko 6.1.1-1-default #1 SMP PREEMPT_DYNAMIC Thu Dec 22 15:37:40 UTC =
2022 (e71748d) x86_64 x86_64 x86_64 GNU/Linux

dmesg:
[139539.490791] BTRFS info (device dm-0): scrub: started on devid 1
[139825.355413] PM: suspend entry (deep)
[139825.457561] Filesystems sync: 0.102 seconds
[139825.459266] Freezing user space processes ...=20
[139845.467124] Freezing of tasks failed after 20.007 seconds (1 tasks refu=
sing to freeze, wq_busy=3D0):
[139845.467315] task:btrfs           state:D stack:0     pid:29703 ppid:297=
00  flags:0x00004006
[139845.467321] Call Trace:
[139845.467323]  <TASK>
[139845.467327]  __schedule+0x360/0x1350
[139845.467340]  schedule+0x5a/0xd0
[139845.467344]  io_schedule+0x42/0x70
[139845.467348]  blk_mq_get_tag+0x11a/0x2a0
[139845.467353]  ? destroy_sched_domains_rcu+0x30/0x30
[139845.467358]  __blk_mq_alloc_requests+0x189/0x2e0
[139845.467362]  blk_mq_submit_bio+0x2d6/0x5e0
[139845.467366]  __submit_bio+0xf5/0x180
[139845.467370]  submit_bio_noacct_nocheck+0xe5/0x2d0
[139845.467376]  scrub_add_sector_to_rd_bio+0x2a8/0x320 [btrfs c8c8418dedbc=
5b328d9ff38d6a65c4e4e45be0e5]
[139845.467485]  scrub_sectors+0x1a8/0x4d0 [btrfs c8c8418dedbc5b328d9ff38d6=
a65c4e4e45be0e5]
[139845.467585]  scrub_simple_mirror+0x393/0x800 [btrfs c8c8418dedbc5b328d9=
ff38d6a65c4e4e45be0e5]
[139845.467689]  ? blk_mq_sched_dispatch_requests+0x30/0x60
[139845.467695]  ? __wake_up_common_lock+0x87/0xc0
[139845.467702]  scrub_stripe+0x36d/0x6d0 [btrfs c8c8418dedbc5b328d9ff38d6a=
65c4e4e45be0e5]
[139845.467803]  ? start_transaction+0x218/0x5b0 [btrfs c8c8418dedbc5b328d9=
ff38d6a65c4e4e45be0e5]
[139845.467888]  ? kmem_cache_alloc+0x16a/0x360
[139845.467895]  scrub_chunk+0xcb/0x130 [btrfs c8c8418dedbc5b328d9ff38d6a65=
c4e4e45be0e5]
[139845.468000]  scrub_enumerate_chunks+0x2d4/0x750 [btrfs c8c8418dedbc5b32=
8d9ff38d6a65c4e4e45be0e5]
[139845.468164]  ? destroy_sched_domains_rcu+0x30/0x30
[139845.468170]  btrfs_scrub_dev+0x241/0x660 [btrfs c8c8418dedbc5b328d9ff38=
d6a65c4e4e45be0e5]
[139845.468323]  ? __check_object_size+0x1e6/0x200
[139845.468330]  btrfs_ioctl+0x6fa/0x25c0 [btrfs c8c8418dedbc5b328d9ff38d6a=
65c4e4e45be0e5]
[139845.468475]  ? page_add_new_anon_rmap+0x6c/0x120
[139845.468481]  ? cap_safe_nice+0x3f/0x80
[139845.468487]  ? security_task_setioprio+0x2f/0x50
[139845.468495]  ? set_task_ioprio+0xa3/0x130
[139845.468503]  __x64_sys_ioctl+0x8d/0xd0
[139845.468511]  do_syscall_64+0x58/0x80
[139845.468518]  ? syscall_exit_to_user_mode+0x17/0x40
[139845.468524]  ? do_syscall_64+0x67/0x80
[139845.468528]  ? do_syscall_64+0x67/0x80
[139845.468533]  ? sigprocmask+0xa5/0xd0
[139845.468539]  ? __x64_sys_rt_sigprocmask+0x76/0xd0
[139845.468544]  ? syscall_exit_to_user_mode+0x17/0x40
[139845.468550]  ? do_syscall_64+0x67/0x80
[139845.468554]  ? exc_page_fault+0x66/0x150
[139845.468560]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[139845.468567] RIP: 0033:0x7f05370ac9bf
[139845.468572] RSP: 002b:00007f0536f9ec80 EFLAGS: 00000246 ORIG_RAX: 00000=
00000000010
[139845.468577] RAX: ffffffffffffffda RBX: 000055e227629420 RCX: 00007f0537=
0ac9bf
[139845.468581] RDX: 000055e227629420 RSI: 00000000c400941b RDI: 0000000000=
000004
[139845.468584] RBP: 0000000000000000 R08: 00007ffdc579f777 R09: 0000000000=
000000
[139845.468586] R10: 0000000000000000 R11: 0000000000000246 R12: ffffffffff=
fffdb8
[139845.468589] R13: 000000000000006b R14: 00007ffdc579f680 R15: 00007f0536=
79f000
[139845.468595]  </TASK>

[139845.468734] OOM killer enabled.
[139845.468736] Restarting tasks ... done.
[139845.486950] random: crng reseeded on system resumption
[139845.603958] PM: suspend exit
[139845.604042] PM: suspend entry (s2idle)
[139845.694115] Filesystems sync: 0.090 seconds
[139845.694367] Freezing user space processes ...=20
[139865.695291] Freezing of tasks failed after 20.000 seconds (1 tasks refu=
sing to freeze, wq_busy=3D0):
[139865.695456] task:btrfs           state:D stack:0     pid:29703 ppid:297=
00  flags:0x00004006
[139865.695460] Call Trace:
[139865.695461]  <TASK>
[139865.695464]  __schedule+0x360/0x1350
[139865.695475]  schedule+0x5a/0xd0
[139865.695478]  io_schedule+0x42/0x70
[139865.695480]  blk_mq_get_tag+0x11a/0x2a0
[139865.695485]  ? destroy_sched_domains_rcu+0x30/0x30
[139865.695488]  __blk_mq_alloc_requests+0x189/0x2e0
[139865.695491]  blk_mq_submit_bio+0x2d6/0x5e0
[139865.695494]  __submit_bio+0xf5/0x180
[139865.695497]  submit_bio_noacct_nocheck+0xe5/0x2d0
[139865.695501]  scrub_add_sector_to_rd_bio+0x106/0x320 [btrfs c8c8418dedbc=
5b328d9ff38d6a65c4e4e45be0e5]
[139865.695588]  scrub_sectors+0x1a8/0x4d0 [btrfs c8c8418dedbc5b328d9ff38d6=
a65c4e4e45be0e5]
[139865.695653]  scrub_simple_mirror+0x393/0x800 [btrfs c8c8418dedbc5b328d9=
ff38d6a65c4e4e45be0e5]
[139865.695748]  ? __wake_up_common_lock+0x87/0xc0
[139865.695754]  scrub_stripe+0x36d/0x6d0 [btrfs c8c8418dedbc5b328d9ff38d6a=
65c4e4e45be0e5]
[139865.695853]  ? start_transaction+0x218/0x5b0 [btrfs c8c8418dedbc5b328d9=
ff38d6a65c4e4e45be0e5]
[139865.695935]  ? kmem_cache_alloc+0x16a/0x360
[139865.695942]  scrub_chunk+0xcb/0x130 [btrfs c8c8418dedbc5b328d9ff38d6a65=
c4e4e45be0e5]
[139865.696038]  scrub_enumerate_chunks+0x2d4/0x750 [btrfs c8c8418dedbc5b32=
8d9ff38d6a65c4e4e45be0e5]
[139865.696125]  ? destroy_sched_domains_rcu+0x30/0x30
[139865.696128]  btrfs_scrub_dev+0x241/0x660 [btrfs c8c8418dedbc5b328d9ff38=
d6a65c4e4e45be0e5]
[139865.696198]  ? __check_object_size+0x1e6/0x200
[139865.696201]  btrfs_ioctl+0x6fa/0x25c0 [btrfs c8c8418dedbc5b328d9ff38d6a=
65c4e4e45be0e5]
[139865.696255]  ? page_add_new_anon_rmap+0x6c/0x120
[139865.696258]  ? cap_safe_nice+0x3f/0x80
[139865.696260]  ? security_task_setioprio+0x2f/0x50
[139865.696264]  ? set_task_ioprio+0xa3/0x130
[139865.696267]  __x64_sys_ioctl+0x8d/0xd0
[139865.696271]  do_syscall_64+0x58/0x80
[139865.696275]  ? syscall_exit_to_user_mode+0x17/0x40
[139865.696277]  ? do_syscall_64+0x67/0x80
[139865.696279]  ? do_syscall_64+0x67/0x80
[139865.696290]  ? sigprocmask+0xa5/0xd0
[139865.696293]  ? __x64_sys_rt_sigprocmask+0x76/0xd0
[139865.696294]  ? syscall_exit_to_user_mode+0x17/0x40
[139865.696296]  ? do_syscall_64+0x67/0x80
[139865.696298]  ? exc_page_fault+0x66/0x150
[139865.696300]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[139865.696303] RIP: 0033:0x7f05370ac9bf
[139865.696305] RSP: 002b:00007f0536f9ec80 EFLAGS: 00000246 ORIG_RAX: 00000=
00000000010
[139865.696307] RAX: ffffffffffffffda RBX: 000055e227629420 RCX: 00007f0537=
0ac9bf
[139865.696308] RDX: 000055e227629420 RSI: 00000000c400941b RDI: 0000000000=
000004
[139865.696309] RBP: 0000000000000000 R08: 00007ffdc579f777 R09: 0000000000=
000000
[139865.696310] R10: 0000000000000000 R11: 0000000000000246 R12: ffffffffff=
fffdb8
[139865.696311] R13: 000000000000006b R14: 00007ffdc579f680 R15: 00007f0536=
79f000
[139865.696313]  </TASK>

[139865.696404] OOM killer enabled.
[139865.696405] Restarting tasks ... done.
[139865.701169] random: crng reseeded on system resumption
[139865.815937] PM: suspend exit
[139962.422007] BTRFS info (device dm-0): scrub: finished on devid 1 with s=
tatus: 0
[139962.460093] BTRFS info (device dm-0): balance: start -dusage=3D0
[139962.460673] BTRFS info (device dm-0): balance: ended with status: 0
[139962.520561] BTRFS info (device dm-0): balance: start -dusage=3D5
[139962.520838] BTRFS info (device dm-0): balance: ended with status: 0
[139962.569264] BTRFS info (device dm-0): balance: start -dusage=3D10
[139962.569535] BTRFS info (device dm-0): balance: ended with status: 0
[139962.618005] BTRFS info (device dm-0): balance: start -musage=3D0 -susag=
e=3D0
[139962.618244] BTRFS info (device dm-0): balance: ended with status: 0
[139962.664231] BTRFS info (device dm-0): balance: start -musage=3D5 -susag=
e=3D5
[139962.664424] BTRFS info (device dm-0): relocating block group 3737200885=
76 flags system|dup
[139962.753203] BTRFS info (device dm-0): 1 enospc errors during balance
[139962.753212] BTRFS info (device dm-0): balance: ended with status: -28
[139999.218253] systemd-journald[619]: Data hash table of /var/log/journal/=
7f882ab05c7f4c0d9bdef2f824867aff/system.journal has a fill level at 75.1 (2=
732 of 3640 items, 2097152 file size, 767 bytes per hash table item), sugge=
sting rotation.
[139999.218264] systemd-journald[619]: /var/log/journal/7f882ab05c7f4c0d9bd=
ef2f824867aff/system.journal: Journal header limits reached or header out-o=
f-date, rotating.
[140004.594339] PM: suspend entry (deep)
[140004.679368] Filesystems sync: 0.085 seconds
[140004.680866] Freezing user space processes ... (elapsed 0.002 seconds) d=
one.
[140004.683244] OOM killer disabled.
[140004.683245] Freezing remaining freezable tasks ... (elapsed 0.001 secon=
ds) done.
[140004.684786] printk: Suspending console(s) (use no_console_suspend to de=
bug)
[140004.740165] sd 4:0:0:0: [sda] Synchronizing SCSI cache
[140004.741331] sd 4:0:0:0: [sda] Stopping disk
[140004.840596] sd 6:0:0:0: [sdb] Synchronizing SCSI cache
[140005.132914] ACPI: EC: interrupt blocked
[140005.146380] ACPI: PM: Preparing to enter system sleep state S3
[140005.147123] ACPI: EC: event blocked
[140005.147124] ACPI: EC: EC stopped
[140005.147125] ACPI: PM: Saving platform NVS memory
[140005.147158] Disabling non-boot CPUs ...
[140005.148795] smpboot: CPU 1 is now offline
[140005.150968] smpboot: CPU 2 is now offline
[140005.152542] smpboot: CPU 3 is now offline
[140005.188662] ACPI: PM: Low-level resume complete
[140005.188691] ACPI: EC: EC started
[140005.188691] ACPI: PM: Restoring platform NVS memory
[140005.189028] Enabling non-boot CPUs ...
[140005.189123] x86: Booting SMP configuration:
[140005.189124] smpboot: Booting Node 0 Processor 1 APIC 0x1
[140005.190704] CPU1 is up
[140005.190762] smpboot: Booting Node 0 Processor 2 APIC 0x2
[140005.226147] CPU2 is up
[140005.226225] smpboot: Booting Node 0 Processor 3 APIC 0x3
[140005.227136] CPU3 is up
[140005.228950] ACPI: PM: Waking up from system sleep state S3
[140005.289422] ACPI: EC: interrupt unblocked
[140005.292284] ACPI: EC: event unblocked
[140005.292625] sd 4:0:0:0: [sda] Starting disk
[140005.608953] usb 2-5: reset full-speed USB device number 3 using xhci_hcd
[140005.619847] ata5: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[140005.619866] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[140005.620318] ata5.00: ACPI cmd f5/00:00:00:00:00:a0(SECURITY FREEZE LOCK=
) filtered out
[140005.620568] ata5.00: supports DRM functions and may not be fully access=
ible
[140005.624829] ata5.00: ACPI cmd f5/00:00:00:00:00:a0(SECURITY FREEZE LOCK=
) filtered out
[140005.625230] ata5.00: supports DRM functions and may not be fully access=
ible
[140005.628634] ata5.00: configured for UDMA/133
[140005.639260] ata5.00: Enabling discard_zeroes_data
[140005.714278] ata1.00: ACPI cmd ef/10:03:00:00:00:a0(SET FEATURES) filter=
ed out
[140005.719683] ata1.00: ACPI cmd ef/10:03:00:00:00:a0(SET FEATURES) filter=
ed out
[140005.721876] ata1.00: configured for UDMA/100
[140005.885012] usb 2-11: reset full-speed USB device number 4 using xhci_h=
cd
[140006.160938] usb 2-12: reset high-speed USB device number 5 using xhci_h=
cd
[140006.320745] OOM killer enabled.
[140006.320748] Restarting tasks ... done.
[140006.327551] random: crng reseeded on system resumption
[140006.339319] PM: suspend exit
[140006.353118] Bluetooth: hci0: Legacy ROM 2.5 revision 8.0 build 1 week 4=
5 2013
[140006.353130] Bluetooth: hci0: Intel Bluetooth firmware file: intel/ibt-h=
w-37.7.10-fw-1.80.1.2d.d.bseq
[140006.549106] Bluetooth: hci0: Intel BT fw patch 0x2a completed & activat=
ed
[140006.598316] Bluetooth: MGMT ver 1.22



--=20


--Sig_/zsFT+u+5L.fmurSGU/LiVe=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmOwyxUACgkQNasLKJxd
slijgw//RAgf5ZASdPmm9xkMWdi4YmnzGOttuyRExEt0x8O2Du+4GV9jYFBfF6fl
P7FT/hTQkomXWoBIla6j8SVbpMqXPtHrM2wCKaNRqhXA45hqYcIFDCJx0divfnfE
kOgO8cf8GMbywhH7cuogqEGakbOLi6a7hIqdWQ7ODix/jCdZwk16aw7gkdohSsjP
JUNms6kbNcMTP9+H0bPcz/IvyvupR9FrFa3hMinr8lv/pNhIVQJqQO8TtZLTF6ac
lHAo6eZlQtJvwH5Faz3odrOSVnqRxJAEIjh6ag9P36ESTjfAlwsRZf3B4mUStEJC
oCvtXKLq1E+DViRpmcmW/rn/LY3gHt1aIVXXoPF/USuoz/Bpsm8zCilFukfhqXdl
F7PC3fyAzsCvbtEFj/h7veZVPtvL5jK3UhLaWOmmkM5i5rQH8pZ4fcOxAICkAYv5
H1iEco1e73DN+VSGV6euO0ANXyDiZZ7zAzmRdOIXOXOVHhbW8eIfO4oLydknAkFT
n3E5hA5sC/aR4CunYJLIVBVWlviKsS7htGkJxqqN2OfXdJTbCxUsvH+rxy4aAiCZ
TRaSF9g2StayawJdu91yo2OHTcxkGfUIAqFLI8hLeZiGLDJwcL98hMGGjPXKA/nh
1grxXdawlfAv5xpEpm+TWl5qHk0jhOrv4L2ETh7cY7djkTFsCG4=
=mQFg
-----END PGP SIGNATURE-----

--Sig_/zsFT+u+5L.fmurSGU/LiVe=--
