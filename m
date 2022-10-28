Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C336113DE
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Oct 2022 16:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbiJ1OCX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Fri, 28 Oct 2022 10:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbiJ1OCW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Oct 2022 10:02:22 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0221843EB
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Oct 2022 07:02:20 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id l14-20020a056e021c0e00b00300770134f9so4881547ilh.16
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Oct 2022 07:02:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ES985dHPWKyWPHfJsUGGlW647AbQEJf3Is3EBAKAYd8=;
        b=y68Z2xusU8FlZTURO1f165MCxOf4MAyIVTbpZLBL5F2ju6oMr5L5TLgLNqAUsHNx02
         Sp0MvHOXFiwAmP5QLaSkTt+tvP8LoShA4cBya+k/6DKxPXutPHTKk/gOe1r8WdI2luqd
         r+RpEDhECeY7o7MQDjRzJCrvV0yEpd0CH2jju/oSW9dZvRwPSm+O96YAnPWzfMA+DfLr
         rag3pr5VuHp1MFSgRzaCokNceiVnYXlR37C3u9/bJ6KymzNLJWbFV+uZrNrGv+FKiem5
         GJ0OS3kJ6bRdPcDi43S7+bEYWnNgCS24fPkTfr5n7mAh0ZhIkr4KQu7QzicrMGyUgzgf
         ppnQ==
X-Gm-Message-State: ACrzQf2DswmZqGyKupo2OdmbMD46FEywv3MDa32wIvErt+a36ZfnErNV
        McuEXK78HGcHoLnJGtZ/+asTIAVceTHHCGw4dN0jD2BsA/vT
X-Google-Smtp-Source: AMsMyM54OoUIBWlkXCBmMTzuW6u1rZg9iRnRfJLMFYeLxp78Id44cPLrNHHCFM+HLk0tMwVZIb9MK3SH/T4mVKBWC5IvlVxC6ujb
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:16cb:b0:2fa:88cf:9486 with SMTP id
 11-20020a056e0216cb00b002fa88cf9486mr31760588ilx.322.1666965739748; Fri, 28
 Oct 2022 07:02:19 -0700 (PDT)
Date:   Fri, 28 Oct 2022 07:02:19 -0700
In-Reply-To: <20221028111321.45437-1-yin31149@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c5461a05ec18b4e6@google.com>
Subject: Re: [syzbot] WARNING in btrfs_block_rsv_release
From:   syzbot <syzbot+dde7e853812ed57835ea@syzkaller.appspotmail.com>
To:     18801353760@163.com, clm@fb.com, dsterba@suse.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com,
        yin31149@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

00
[   10.626735][    T1] IPVS: Registered protocols (TCP, UDP, SCTP, AH, ESP)
[   10.628295][    T1] IPVS: Connection hash table configured (size=4096, memory=32Kbytes)
[   10.630010][    T1] IPVS: ipvs loaded.
[   10.630584][    T1] IPVS: [rr] scheduler registered.
[   10.631355][    T1] IPVS: [wrr] scheduler registered.
[   10.632191][    T1] IPVS: [lc] scheduler registered.
[   10.632912][    T1] IPVS: [wlc] scheduler registered.
[   10.633714][    T1] IPVS: [fo] scheduler registered.
[   10.634448][    T1] IPVS: [ovf] scheduler registered.
[   10.635695][    T1] IPVS: [lblc] scheduler registered.
[   10.636621][    T1] IPVS: [lblcr] scheduler registered.
[   10.637562][    T1] IPVS: [dh] scheduler registered.
[   10.638341][    T1] IPVS: [sh] scheduler registered.
[   10.639064][    T1] IPVS: [mh] scheduler registered.
[   10.639829][    T1] IPVS: [sed] scheduler registered.
[   10.640648][    T1] IPVS: [nq] scheduler registered.
[   10.641358][    T1] IPVS: [twos] scheduler registered.
[   10.642344][    T1] IPVS: [sip] pe registered.
[   10.643158][    T1] ipip: IPv4 and MPLS over IPv4 tunneling driver
[   10.646785][    T1] gre: GRE over IPv4 demultiplexor driver
[   10.647988][    T1] ip_gre: GRE over IPv4 tunneling driver
[   10.657614][    T1] IPv4 over IPsec tunneling driver
[   10.661973][    T1] ipt_CLUSTERIP: ClusterIP Version 0.8 loaded successfully
[   10.663721][    T1] Initializing XFRM netlink socket
[   10.664715][    T1] IPsec XFRM device driver
[   10.667985][    T1] NET: Registered PF_INET6 protocol family
[   10.681339][    T1] Segment Routing with IPv6
[   10.682209][    T1] RPL Segment Routing with IPv6
[   10.683200][    T1] In-situ OAM (IOAM) with IPv6
[   10.684506][    T1] mip6: Mobile IPv6
[   10.688852][    T1] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[   10.697537][    T1] ip6_gre: GRE over IPv6 tunneling driver
[   10.702064][    T1] NET: Registered PF_PACKET protocol family
[   10.702972][    T1] NET: Registered PF_KEY protocol family
[   10.704733][    T1] Bridge firewalling registered
[   10.706424][    T1] NET: Registered PF_X25 protocol family
[   10.707669][    T1] X25: Linux Version 0.2
[   10.752465][    T1] NET: Registered PF_NETROM protocol family
[   10.784421][ T2696] kworker/u4:1 (2696) used greatest stack depth: 21784 bytes left
[   10.796283][    T1] NET: Registered PF_ROSE protocol family
[   10.797639][    T1] NET: Registered PF_AX25 protocol family
[   10.798728][    T1] can: controller area network core
[   10.800391][    T1] NET: Registered PF_CAN protocol family
[   10.801334][    T1] can: raw protocol
[   10.802160][    T1] can: broadcast manager protocol
[   10.803237][    T1] can: netlink gateway - max_hops=1
[   10.806626][    T1] can: SAE J1939
[   10.807406][    T1] can: isotp protocol
[   10.808488][    T1] Bluetooth: RFCOMM TTY layer initialized
[   10.809368][    T1] Bluetooth: RFCOMM socket layer initialized
[   10.810432][    T1] Bluetooth: RFCOMM ver 1.11
[   10.811200][    T1] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   10.812344][    T1] Bluetooth: BNEP filters: protocol multicast
[   10.813472][    T1] Bluetooth: BNEP socket layer initialized
[   10.814580][    T1] Bluetooth: CMTP (CAPI Emulation) ver 1.0
[   10.816401][    T1] Bluetooth: CMTP socket layer initialized
[   10.817384][    T1] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
[   10.818502][    T1] Bluetooth: HIDP socket layer initialized
[   10.824139][    T1] NET: Registered PF_RXRPC protocol family
[   10.825345][    T1] Key type rxrpc registered
[   10.826078][    T1] Key type rxrpc_s registered
[   10.828240][    T1] NET: Registered PF_KCM protocol family
[   10.829783][    T1] lec:lane_module_init: lec.c: initialized
[   10.830626][    T1] mpoa:atm_mpoa_init: mpc.c: initialized
[   10.831616][    T1] l2tp_core: L2TP core driver, V2.0
[   10.832528][    T1] l2tp_ppp: PPPoL2TP kernel driver, V2.0
[   10.833478][    T1] l2tp_ip: L2TP IP encapsulation support (L2TPv3)
[   10.834838][    T1] l2tp_netlink: L2TP netlink interface
[   10.836503][    T1] l2tp_eth: L2TP ethernet pseudowire support (L2TPv3)
[   10.837696][    T1] l2tp_ip6: L2TP IP encapsulation support for IPv6 (L2TPv3)
[   10.839207][    T1] NET: Registered PF_PHONET protocol family
[   10.841155][    T1] 8021q: 802.1Q VLAN Support v1.8
[   10.862660][    T1] DCCP: Activated CCID 2 (TCP-like)
[   10.864236][    T1] DCCP: Activated CCID 3 (TCP-Friendly Rate Control)
[   10.868242][    T1] sctp: Hash tables configured (bind 32/56)
[   10.871963][    T1] NET: Registered PF_RDS protocol family
[   10.874058][    T1] Registered RDS/infiniband transport
[   10.876434][    T1] Registered RDS/tcp transport
[   10.877245][    T1] tipc: Activated (version 2.0.0)
[   10.878883][    T1] NET: Registered PF_TIPC protocol family
[   10.880418][    T1] tipc: Started in single node mode
[   10.882583][    T1] NET: Registered PF_SMC protocol family
[   10.883886][    T1] 9pnet: Installing 9P2000 support
[   10.885340][    T1] NET: Registered PF_CAIF protocol family
[   10.893240][    T1] NET: Registered PF_IEEE802154 protocol family
[   10.894764][    T1] Key type dns_resolver registered
[   10.895597][    T1] Key type ceph registered
[   10.897286][    T1] libceph: loaded (mon/osd proto 15/24)
[   10.900756][    T1] batman_adv: B.A.T.M.A.N. advanced 2022.3 (compatibility version 15) loaded
[   10.902106][    T1] openvswitch: Open vSwitch switching datapath
[   10.905615][    T1] ------------[ cut here ]------------
[   10.906603][    T1] WARNING: CPU: 0 PID: 1 at net/netlink/genetlink.c:383 genl_register_family+0x13c0/0x1540
[   10.908115][    T1] Modules linked in:
[   10.908691][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.1.0-rc2-syzkaller-00189-g23758867219c-dirty #0
[   10.910145][    T1] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
[   10.911770][    T1] RIP: 0010:genl_register_family+0x13c0/0x1540
[   10.912959][    T1] Code: 5d 41 5e 41 5f 5d c3 e8 fe 71 1b f9 0f 0b 41 be ea ff ff ff eb a2 e8 ef 71 1b f9 0f 0b 41 be ea ff ff ff eb 93 e8 e0 71 1b f9 <0f> 0b 41 be ea ff ff ff eb 84 44 89 e1 80 e1 07 38 c1 0f 8c bd ec
[   10.915895][    T1] RSP: 0000:ffffc90000067820 EFLAGS: 00010293
[   10.916967][    T1] RAX: ffffffff886c5e00 RBX: 0000000000000001 RCX: ffff888140170000
[   10.918151][    T1] RDX: 0000000000000000 RSI: 0000000000000003 RDI: 0000000000000000
[   10.919312][    T1] RBP: ffffc90000067950 R08: ffffffff886c4e33 R09: fffffbfff1c1b606
[   10.920882][    T1] R10: fffffbfff1c1b606 R11: 1ffffffff1c1b605 R12: dffffc0000000000
[   10.922497][    T1] R13: ffffffff8c582448 R14: 0000000000000000 R15: 0000000000000003
[   10.924081][    T1] FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
[   10.925774][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   10.926982][    T1] CR2: ffff88823ffff000 CR3: 000000000c88e000 CR4: 00000000003506f0
[   10.928082][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   10.929173][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   10.930397][    T1] Call Trace:
[   10.931035][    T1]  <TASK>
[   10.931558][    T1]  ? nlmsg_trim+0xa0/0xa0
[   10.932566][    T1]  ? genl_unlock+0x20/0x20
[   10.933372][    T1]  dp_register_genl+0x40/0x136
[   10.934400][    T1]  dp_init+0x11a/0x140
[   10.935312][    T1]  ? psample_module_init+0x11/0x11
[   10.936082][    T1]  do_one_initcall+0x1c9/0x400
[   10.936955][    T1]  ? IS_ERR_OR_NULL+0x20/0x20
[   10.937621][    T1]  ? lockdep_hardirqs_on_prepare+0x428/0x790
[   10.939048][    T1]  ? print_irqtrace_events+0x220/0x220
[   10.939975][    T1]  ? asm_sysvec_reschedule_ipi+0x16/0x20
[   10.941100][    T1]  ? lockdep_hardirqs_on+0x8d/0x130
[   10.942031][    T1]  ? asm_sysvec_reschedule_ipi+0x16/0x20
[   10.942955][    T1]  ? parameq+0xba/0x210
[   10.943611][    T1]  ? strlen+0x41/0x60
[   10.944217][    T1]  ? parameq+0x198/0x210
[   10.944962][    T1]  ? parse_one+0x141/0x520
[   10.945749][    T1]  ? do_initcall_level+0x218/0x218
[   10.946940][    T1]  ? ignore_unknown_bootoption+0x5/0x8
[   10.948340][    T1]  ? parse_args+0x4e1/0x590
[   10.949153][    T1]  ? rcu_read_lock_sched_held+0x87/0x110
[   10.950180][    T1]  ? __bpf_trace_rcu_stall_warning+0x10/0x10
[   10.951083][    T1]  ? rcu_read_lock_sched_held+0x87/0x110
[   10.952908][    T1]  ? __bpf_trace_rcu_stall_warning+0x10/0x10
[   10.953863][    T1]  do_initcall_level+0x168/0x218
[   10.954847][    T1]  do_initcalls+0x4b/0x8c
[   10.955707][    T1]  kernel_init_freeable+0x428/0x5d5
[   10.957030][    T1]  ? report_meminit+0x64/0x64
[   10.957791][    T1]  ? _raw_spin_lock_irq+0xba/0xf0
[   10.958675][    T1]  ? do_raw_spin_unlock+0x134/0x8a0
[   10.959494][    T1]  ? _raw_spin_unlock_irq+0x1f/0x40
[   10.960315][    T1]  ? lockdep_hardirqs_on+0x8d/0x130
[   10.961095][    T1]  ? rest_init+0x270/0x270
[   10.961718][    T1]  kernel_init+0x19/0x2b0
[   10.962440][    T1]  ? rest_init+0x270/0x270
[   10.963209][    T1]  ret_from_fork+0x1f/0x30
[   10.964022][    T1]  </TASK>
[   10.964468][    T1] Kernel panic - not syncing: panic_on_warn set ...
[   10.965668][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.1.0-rc2-syzkaller-00189-g23758867219c-dirty #0
[   10.965668][    T1] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
[   10.965668][    T1] Call Trace:
[   10.965668][    T1]  <TASK>
[   10.965668][    T1]  dump_stack_lvl+0x1b1/0x28e
[   10.965668][    T1]  ? nf_tcp_handle_invalid+0x62e/0x62e
[   10.965668][    T1]  ? panic+0x710/0x710
[   10.965668][    T1]  ? vscnprintf+0x59/0x80
[   10.965668][    T1]  ? genl_register_family+0x13c0/0x1540
[   10.965668][    T1]  panic+0x2d6/0x710
[   10.965668][    T1]  ? __warn+0x131/0x220
[   10.965668][    T1]  ? memcpy_page_flushcache+0xfc/0xfc
[   10.965668][    T1]  ? ret_from_fork+0x1f/0x30
[   10.965668][    T1]  ? genl_register_family+0x13c0/0x1540
[   10.965668][    T1]  __warn+0x1fa/0x220
[   10.965668][    T1]  ? genl_register_family+0x13c0/0x1540
[   10.965668][    T1]  report_bug+0x1b3/0x2d0
[   10.965668][    T1]  handle_bug+0x3d/0x70
[   10.965668][    T1]  exc_invalid_op+0x16/0x40
[   10.965668][    T1]  asm_exc_invalid_op+0x16/0x20
[   10.965668][    T1] RIP: 0010:genl_register_family+0x13c0/0x1540
[   10.965668][    T1] Code: 5d 41 5e 41 5f 5d c3 e8 fe 71 1b f9 0f 0b 41 be ea ff ff ff eb a2 e8 ef 71 1b f9 0f 0b 41 be ea ff ff ff eb 93 e8 e0 71 1b f9 <0f> 0b 41 be ea ff ff ff eb 84 44 89 e1 80 e1 07 38 c1 0f 8c bd ec
[   10.965668][    T1] RSP: 0000:ffffc90000067820 EFLAGS: 00010293
[   10.965668][    T1] RAX: ffffffff886c5e00 RBX: 0000000000000001 RCX: ffff888140170000
[   10.965668][    T1] RDX: 0000000000000000 RSI: 0000000000000003 RDI: 0000000000000000
[   10.965668][    T1] RBP: ffffc90000067950 R08: ffffffff886c4e33 R09: fffffbfff1c1b606
[   10.965668][    T1] R10: fffffbfff1c1b606 R11: 1ffffffff1c1b605 R12: dffffc0000000000
[   10.965668][    T1] R13: ffffffff8c582448 R14: 0000000000000000 R15: 0000000000000003
[   10.965668][    T1]  ? genl_register_family+0x3f3/0x1540
[   10.965668][    T1]  ? genl_register_family+0x13c0/0x1540
[   10.965668][    T1]  ? nlmsg_trim+0xa0/0xa0
[   10.965668][    T1]  ? genl_unlock+0x20/0x20
[   10.965668][    T1]  dp_register_genl+0x40/0x136
[   10.965668][    T1]  dp_init+0x11a/0x140
[   10.965668][    T1]  ? psample_module_init+0x11/0x11
[   10.965668][    T1]  do_one_initcall+0x1c9/0x400
[   10.965668][    T1]  ? IS_ERR_OR_NULL+0x20/0x20
[   10.965668][    T1]  ? lockdep_hardirqs_on_prepare+0x428/0x790
[   10.965668][    T1]  ? print_irqtrace_events+0x220/0x220
[   10.965668][    T1]  ? asm_sysvec_reschedule_ipi+0x16/0x20
[   10.965668][    T1]  ? lockdep_hardirqs_on+0x8d/0x130
[   10.965668][    T1]  ? asm_sysvec_reschedule_ipi+0x16/0x20
[   10.965668][    T1]  ? parameq+0xba/0x210
[   10.965668][    T1]  ? strlen+0x41/0x60
[   10.965668][    T1]  ? parameq+0x198/0x210
[   10.965668][    T1]  ? parse_one+0x141/0x520
[   10.965668][    T1]  ? do_initcall_level+0x218/0x218
[   10.965668][    T1]  ? ignore_unknown_bootoption+0x5/0x8
[   10.965668][    T1]  ? parse_args+0x4e1/0x590
[   10.965668][    T1]  ? rcu_read_lock_sched_held+0x87/0x110
[   10.965668][    T1]  ? __bpf_trace_rcu_stall_warning+0x10/0x10
[   10.965668][    T1]  ? rcu_read_lock_sched_held+0x87/0x110
[   10.965668][    T1]  ? __bpf_trace_rcu_stall_warning+0x10/0x10
[   10.965668][    T1]  do_initcall_level+0x168/0x218
[   10.965668][    T1]  do_initcalls+0x4b/0x8c
[   10.965668][    T1]  kernel_init_freeable+0x428/0x5d5
[   10.965668][    T1]  ? report_meminit+0x64/0x64
[   10.965668][    T1]  ? _raw_spin_lock_irq+0xba/0xf0
[   10.965668][    T1]  ? do_raw_spin_unlock+0x134/0x8a0
[   10.965668][    T1]  ? _raw_spin_unlock_irq+0x1f/0x40
[   10.965668][    T1]  ? lockdep_hardirqs_on+0x8d/0x130
[   10.965668][    T1]  ? rest_init+0x270/0x270
[   10.965668][    T1]  kernel_init+0x19/0x2b0
[   10.965668][    T1]  ? rest_init+0x270/0x270
[   10.965668][    T1]  ret_from_fork+0x1f/0x30
[   10.965668][    T1]  </TASK>
[   10.965668][    T1] Kernel Offset: disabled
[   10.965668][    T1] Rebooting in 86400 seconds..


syzkaller build log:
go env (err=<nil>)
GO111MODULE="auto"
GOARCH="amd64"
GOBIN=""
GOCACHE="/syzkaller/.cache/go-build"
GOENV="/syzkaller/.config/go/env"
GOEXE=""
GOEXPERIMENT=""
GOFLAGS=""
GOHOSTARCH="amd64"
GOHOSTOS="linux"
GOINSECURE=""
GOMODCACHE="/syzkaller/jobs/linux/gopath/pkg/mod"
GONOPROXY=""
GONOSUMDB=""
GOOS="linux"
GOPATH="/syzkaller/jobs/linux/gopath"
GOPRIVATE=""
GOPROXY="https://proxy.golang.org,direct"
GOROOT="/usr/local/go"
GOSUMDB="sum.golang.org"
GOTMPDIR=""
GOTOOLDIR="/usr/local/go/pkg/tool/linux_amd64"
GOVCS=""
GOVERSION="go1.17"
GCCGO="gccgo"
AR="ar"
CC="gcc"
CXX="g++"
CGO_ENABLED="1"
GOMOD="/syzkaller/jobs/linux/gopath/src/github.com/google/syzkaller/go.mod"
CGO_CFLAGS="-g -O2"
CGO_CPPFLAGS=""
CGO_CXXFLAGS="-g -O2"
CGO_FFLAGS="-g -O2"
CGO_LDFLAGS="-g -O2"
PKG_CONFIG="pkg-config"
GOGCCFLAGS="-fPIC -m64 -pthread -fmessage-length=0 -fdebug-prefix-map=/tmp/go-build1720647648=/tmp/go-build -gno-record-gcc-switches"

git status (err=<nil>)
HEAD detached at a0fd4dab4
nothing to commit, working tree clean


tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:32: run command via tools/syz-env for best compatibility, see:
Makefile:33: https://github.com/google/syzkaller/blob/master/docs/contributing.md#using-syz-env
go list -f '{{.Stale}}' ./sys/syz-sysgen | grep -q false || go install ./sys/syz-sysgen
make .descriptions
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
bin/syz-sysgen
touch .descriptions
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=a0fd4dab4eac71d7b3237bb1000352206a6a82f5 -X 'github.com/google/syzkaller/prog.gitRevisionDate=20221020-182546'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer github.com/google/syzkaller/syz-fuzzer
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=a0fd4dab4eac71d7b3237bb1000352206a6a82f5 -X 'github.com/google/syzkaller/prog.gitRevisionDate=20221020-182546'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execprog github.com/google/syzkaller/tools/syz-execprog
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=a0fd4dab4eac71d7b3237bb1000352206a6a82f5 -X 'github.com/google/syzkaller/prog.gitRevisionDate=20221020-182546'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-stress github.com/google/syzkaller/tools/syz-stress
mkdir -p ./bin/linux_amd64
gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wframe-larger-than=16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-format-overflow -static-pie -fpermissive -w -DGOOS_linux=1 -DGOARCH_amd64=1 \
	-DHOSTGOOS_linux=1 -DGIT_REVISION=\"a0fd4dab4eac71d7b3237bb1000352206a6a82f5\"


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=15b1c4ca880000


Tested on:

commit:         23758867 Merge tag 'net-6.1-rc3-2' of git://git.kernel..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d3548a4365ba17d
dashboard link: https://syzkaller.appspot.com/bug?extid=dde7e853812ed57835ea
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14540cfc880000

