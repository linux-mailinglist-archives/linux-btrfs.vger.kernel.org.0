Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B19FD75B04A
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jul 2023 15:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjGTNnN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jul 2023 09:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbjGTNnE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jul 2023 09:43:04 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E15919B5
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 06:43:01 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 5BA3F3201CE1
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 09:42:58 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute5.internal (MEProxy); Thu, 20 Jul 2023 09:42:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        colorremedies.com; h=cc:content-type:content-type:date:date:from
        :from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1689860577; x=1689946977; bh=HW
        7po4tZOhmjF1fSbj/wAMNJpCh46PCO/N1T6kwDNF8=; b=Aa8nGy066c2jdPg8b7
        wtRFZcpcYEsppW1eax6pgq4XoXWCsZ42QVF8c3aooOo39eYbGoa13/0IxEQIfhZt
        feWiq7tVtAz/3ST3TcKiuiafVycEPJZBVVdEXkjoFZvRp5zFqG34KbhljINg3jHh
        9eOKSeOv5Z2o0JjvP44XyKTcm0JU7/80//JkYAv6ZRNSCx7taU96YTALbgxHpWGQ
        nrEWG23kYd4w418UyxnS67SkFa+2U4q+LVW1n+lT8iwRRy17gMia4U8dSfP4Xh2Y
        jzPKfvz3ovteZWomwgR2Pah5wfVbD0t8LaMGyKmc215I1sb4Z71fHcRmSndjr875
        hHeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1689860577; x=1689946977; bh=HW7po4tZOhmjF1fSbj/wAMNJpCh46PCO/N1
        T6kwDNF8=; b=WEfOelFU+jfLiqiK04OkbldN6PD2Upc2fdG9ZaZlqp6tlfcROP8
        bDguXbpyJ3BC6FM2uXB0T19a4/71e+ukAG6nYYP+8j+zvHjYqEnzWJQPpuzmY8hZ
        e6oG2tzL7WKn5FBDecCXPPkXDhc8jq3KO8v5nrd7l9Es85e4Tka6BtgMMWWnc3Gv
        5vNXjGNSe5EReEZN7LXOGczCWddkNCco3w0gTJF3Cy0pfW4IQ0uMwY8lryXG5Efh
        O7+vawrG3zU3mKatch5hE/xBbkN8eERnJ9+F+A1X8bB60aSUmZrB8HHqDwPN7aiI
        fu/E5074GW5lySHjiIjmpbpyskg46FW5avw==
X-ME-Sender: <xms:4Tm5ZB5b9sDb1H8c3rJUotoSMDnhrz2SIqtR4O1-KdAg3tBxH-gbHQ>
    <xme:4Tm5ZO7bX8oaTuxFhX1C_zqg_gTRAAevVBNDYsZiLg7GFwZmdurnLahEsWZn4bvnc
    CIgqkrM48ocwRRBQWU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrhedtgdeiiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfffhffvufgtsehttdertderredtnecuhfhrohhmpedfvehhrhhishcu
    ofhurhhphhihfdcuoehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpeettddvkeefkeekleethedtudetfeeuleevffekudeiledvfeef
    geefjeetgfeuveenucffohhmrghinheprhgvughhrghtrdgtohhmpdhkvghrnhgvlhdroh
    hrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehl
    ihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtohhm
X-ME-Proxy: <xmx:4Tm5ZIfQMGWrzoxZo8nW9h-Fwo3n4pKVr7iXnfIPHfQfbiCdUMQt1g>
    <xmx:4Tm5ZKJ_eYQd6jz5cvU3JoFUPIUAh4S77SuoqaEeQQgDgpeunzPXoA>
    <xmx:4Tm5ZFKoAvJsNLPyCfFMXGCtOH0Cfj9zPxDqp7zQDaW-jgJlTspokQ>
    <xmx:4Tm5ZKXL_zs5CIg50EXUyOYwWdf75uzYUnIj04ZHKa1vma39S3Y3ug>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 725FE1700097; Thu, 20 Jul 2023 09:42:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-531-gfdfa13a06d-fm-20230703.001-gfdfa13a0
Mime-Version: 1.0
Message-Id: <a44b85f5-01b5-40d5-a067-883d9223366a@app.fastmail.com>
Date:   Thu, 20 Jul 2023 09:42:37 -0400
From:   "Chris Murphy" <lists@colorremedies.com>
To:     "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Subject: permanently wedged in filesystem, fs/btrfs/relocation.c:1937 prepare_to_merge
Content-Type: text/plain
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

kernel 6.3.12
btrfs-progs 6.3.2

User reports converting from metadata single to dup, which fails midway through and goes read-only. Following a reboot the file system progressively reports no free space even though `btrfs fi us` reports plenty of unused space in all block groups (but no unallocated space).

We were able to capture some information about file system state, but ordinary filtered balance measures failed so the user reformatted.

Downstream bug report
https://bugzilla.redhat.com/show_bug.cgi?id=2224346


 BTRFS info (device sda1): balance: start -mconvert=dup -sconvert=dup
 BTRFS info (device sda1): relocating block group 83480281088 flags metadata
 ------------[ cut here ]------------
 BTRFS: Transaction aborted (error -28)
 WARNING: CPU: 1 PID: 180121 at fs/btrfs/relocation.c:1937 prepare_to_merge+0x41f/0x430
 Modules linked in: [snipped]
 CPU: 1 PID: 180121 Comm: btrfs Not tainted 6.3.12-100.fc37.x86_64 #1
 Hardware name: Dell Inc. Latitude E6500                  /0PP476, BIOS A29 06/04/2013
 RIP: 0010:prepare_to_merge+0x41f/0x430
 Code: ad e8 75 e1 04 00 eb e0 44 89 f6 48 c7 c7 b8 8e 90 ad e8 a4 07 ab ff 0f 0b eb b4 44 89 f6 48 c7 c7 b8 8e 90 ad e8 91 07 ab ff <0f> 0b eb ba e8 38 be 93 00 0f 1f 84 00 00 00 00 00 90 90 90 90 90
 RSP: 0018:ffffb6a64b387af8 EFLAGS: 00010282
 RAX: 0000000000000000 RBX: ffff9ac5cc749000 RCX: 0000000000000027
 RDX: ffff9ac617d21548 RSI: 0000000000000001 RDI: ffff9ac617d21540
 RBP: ffff9ac5004e0680 R08: 0000000000000000 R09: ffffb6a64b387988
 R10: 0000000000000003 R11: ffffffffae146108 R12: 00000000ffffffe4
 R13: ffff9ac50a5f7000 R14: 00000000ffffffe4 R15: ffff9ac4a3464358
 FS:  00007f0d6fc1b900(0000) GS:ffff9ac617d00000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 000000c0010a9008 CR3: 000000001a196000 CR4: 00000000000406e0
 Call Trace:
  <TASK>
  ? prepare_to_merge+0x41f/0x430
  ? __warn+0x81/0x130
  ? prepare_to_merge+0x41f/0x430
  ? report_bug+0x171/0x1a0
  ? prb_read_valid+0x1b/0x30
  ? handle_bug+0x41/0x70
  ? exc_invalid_op+0x17/0x70
  ? asm_exc_invalid_op+0x1a/0x20
  ? prepare_to_merge+0x41f/0x430
  ? prepare_to_merge+0x41f/0x430
  relocate_block_group+0x130/0x500
  btrfs_relocate_block_group+0x296/0x430
  btrfs_relocate_chunk+0x3f/0x160
  btrfs_balance+0x905/0x1390
  ? __kmem_cache_alloc_node+0x187/0x320
  ? btrfs_ioctl+0x2435/0x2640
  btrfs_ioctl+0x224e/0x2640
  ? ioctl_has_perm.constprop.0.isra.0+0xdd/0x140
  __x64_sys_ioctl+0x94/0xd0
  do_syscall_64+0x5f/0x90
  ? exit_to_user_mode_prepare+0x188/0x1f0
  ? syscall_exit_to_user_mode+0x1b/0x40
  ? do_syscall_64+0x6b/0x90
  ? syscall_exit_to_user_mode+0x1b/0x40
  ? do_syscall_64+0x6b/0x90
  ? syscall_exit_to_user_mode+0x1b/0x40
  ? do_syscall_64+0x6b/0x90
  ? exc_page_fault+0x74/0x170
  entry_SYSCALL_64_after_hwframe+0x72/0xdc
 RIP: 0033:0x7f0d6fd66d6f
 Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
 RSP: 002b:00007fff3c9bc290 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
 RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f0d6fd66d6f
 RDX: 00007fff3c9bc390 RSI: 00000000c4009420 RDI: 0000000000000003
 RBP: 0000000000000000 R08: 0000000000000004 R09: 0000000000000073
 R10: 0000000000000000 R11: 0000000000000246 R12: 00007fff3c9be3f4
 R13: 00007fff3c9bc390 R14: 0000000000000001 R15: 0000000000000000
  </TASK>
 ---[ end trace 0000000000000000 ]---
 BTRFS info (device sda1: state A): dumping space info:
 BTRFS info (device sda1: state A): space_info DATA has 22002716672 free, is not full
 BTRFS info (device sda1: state A): space_info total=51514441728, used=29511708672, pinned=0, reserved=0, may_use=16384, readonly=0 zone_unusable=0
 BTRFS info (device sda1: state A): space_info METADATA has 242122752 free, is full
 BTRFS info (device sda1: state A): space_info total=2632974336, used=1418067968, pinned=53788672, reserved=5505024, may_use=365117440, readonly=548372480 zone_unusable=0
 BTRFS info (device sda1: state A): space_info SYSTEM has 39829504 free, is not full
 BTRFS info (device sda1: state A): space_info total=39845888, used=16384, pinned=0, reserved=0, may_use=0, readonly=0 zone_unusable=0
 BTRFS info (device sda1: state A): global_block_rsv: size 107692032 reserved 107692032
 BTRFS info (device sda1: state A): trans_block_rsv: size 0 reserved 0
 BTRFS info (device sda1: state A): chunk_block_rsv: size 0 reserved 0
 BTRFS info (device sda1: state A): delayed_block_rsv: size 655360 reserved 655360
 BTRFS info (device sda1: state A): delayed_refs_rsv: size 2482503680 reserved 254541824
 BTRFS: error (device sda1: state A) in prepare_to_merge:1937: errno=-28 No space left
 BTRFS info (device sda1: state EA): forced readonly
 BTRFS info (device sda1: state EA): balance: ended with status: -30

# btrfs fi usage /btrfs_root/sda1
Overall:
    Device size:                  50.92GiB
    Device allocated:             50.92GiB
    Device unallocated:            1.00MiB
    Device missing:                  0.00B
    Device slack:                    0.00B
    Used:                         29.20GiB
    Free (estimated):             20.49GiB      (min: 20.49GiB)
    Free (statfs, df):            20.49GiB
    Data ratio:                       1.00
    Metadata ratio:                   1.18
    Global reserve:              102.70MiB      (used: 0.00B)
    Multiple profiles:                 yes      (metadata, system)

Data,single: Size:47.98GiB, Used:27.48GiB (57.29%)
   /dev/sda1      47.98GiB

Metadata,single: Size:2.00GiB, Used:943.66MiB (46.08%)
   /dev/sda1       2.00GiB

Metadata,DUP: Size:463.00MiB, Used:408.33MiB (88.19%)
   /dev/sda1     926.00MiB

System,single: Size:32.00MiB, Used:0.00B (0.00%)
   /dev/sda1      32.00MiB

System,DUP: Size:6.00MiB, Used:16.00KiB (0.26%)
   /dev/sda1      12.00MiB

Unallocated:
   /dev/sda1       1.00MiB


sysfs

allocation/metadata/disk_used:1917665280
allocation/metadata/bytes_pinned:0
allocation/metadata/chunk_size:1073741824
allocation/metadata/bytes_used:1051197440
allocation/metadata/bg_reclaim_threshold:0
allocation/metadata/size_classes:none 0
allocation/metadata/size_classes:small 0
allocation/metadata/size_classes:medium 0
allocation/metadata/size_classes:large 0
allocation/metadata/single/used_bytes:184729600
allocation/metadata/single/total_bytes:2147483648
allocation/metadata/dup/used_bytes:866467840
allocation/metadata/dup/total_bytes:972029952
allocation/metadata/disk_total:4091543552
allocation/metadata/total_bytes:3119513600
allocation/metadata/bytes_reserved:0
allocation/metadata/bytes_readonly:1962754048
allocation/metadata/bytes_zone_unusable:0
allocation/metadata/bytes_may_use:105512960
allocation/metadata/flags:4
allocation/system/disk_used:32768
allocation/system/bytes_pinned:0
allocation/system/chunk_size:33554432
allocation/system/bytes_used:16384
allocation/system/bg_reclaim_threshold:0
allocation/system/size_classes:none 0
allocation/system/size_classes:small 0
allocation/system/size_classes:medium 0
allocation/system/size_classes:large 0
allocation/system/dup/used_bytes:16384
allocation/system/dup/total_bytes:67108864
allocation/system/disk_total:134217728
allocation/system/total_bytes:67108864
allocation/system/bytes_reserved:0
allocation/system/bytes_readonly:0
allocation/system/bytes_zone_unusable:0
allocation/system/bytes_may_use:0
allocation/system/flags:2
allocation/global_rsv_reserved:105512960
allocation/data/disk_used:29451214848
allocation/data/bytes_pinned:0
allocation/data/chunk_size:10737418240
allocation/data/bytes_used:29451214848
allocation/data/bg_reclaim_threshold:0
allocation/data/size_classes:none 5
allocation/data/size_classes:small 32
allocation/data/size_classes:medium 7
allocation/data/size_classes:large 5
allocation/data/single/used_bytes:29451214848
allocation/data/single/total_bytes:50453282816
allocation/data/disk_total:50453282816
allocation/data/total_bytes:50453282816
allocation/data/bytes_reserved:0
allocation/data/bytes_readonly:0
allocation/data/bytes_zone_unusable:0
allocation/data/bytes_may_use:0
allocation/data/flags:1
allocation/global_rsv_size:105512960

Looks similar to this: 
https://lore.kernel.org/lkml/000000000000a3d67705ff730522@google.com/T/



