Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418FB58F03F
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Aug 2022 18:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbiHJQUQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Aug 2022 12:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiHJQUP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Aug 2022 12:20:15 -0400
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71BF94B0D2
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Aug 2022 09:20:14 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id EE2905808F8
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Aug 2022 12:20:11 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Wed, 10 Aug 2022 12:20:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        colorremedies.com; h=cc:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1660148411; x=1660152011; bh=e3g91IGliV
        QkQSIjW+HdESuEVmMXsuB1u0sea5LriDo=; b=nG3LBj+8LDTfQmejn2keQASiEY
        Qz45yhCzt8EJaa8UyNtOzA2cHetO1o3+Wz6dEjvMS1tTExnHfV8yK2Pk407CgLrz
        1XwhLENpj12bb82tJNmn9vPiB3/NWIg3/6nhjKTJPFXM6dJ1SHnDsC37u1hx6ggA
        xz7jOdWKusSa7xrAqFNdwHo+ys6aAZquTIRqBlzcFuzIpkAm7EQM0tkZh8TbuusM
        odIlD2hne2RUcJNCYniVD7Rpb98sC5c/ESLxvCCRQgdft6+6amoKbut9eWPkCwVp
        rDdIMIO7iap9HKWHnuOqAyqyb6iIviQjxrbw3PTz9cTQ2Yo4GlVAKUiBOFeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:message-id:mime-version
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1660148411; x=
        1660152011; bh=e3g91IGliVQkQSIjW+HdESuEVmMXsuB1u0sea5LriDo=; b=d
        NHbrc/ZS5zkIcLTWSK3vihdeQQpR4kXWCUXeorBjfFqzyMRFNlj7NCQJbKh7wWTw
        eTfu/p4saSSjlBM9K5WUtqxqSmPRe1ENFC4jVAm4qUlHUPHdBb9O7y55CywbifGE
        funi5la4nMEj7bnQqGwgtje9hrhBnF3S6OLjC8uLlP+A+10/ZZl8VamL7xFlUrwL
        c8L+Eqsh2gg5eLwtDtnaBfbvVYxP77Fgzg6a8O/L5qRekC81YRpyI6P/kZVV3OE0
        R0GHhtz0E0ixnfbL7ZdxDCi158kpgy3qJgwKLqCVmdKjULIgJh/Vqn7bdhFHssOI
        VET1XyDQ5gYkT4W+VMSKg==
X-ME-Sender: <xms:u9rzYnVqsjbWrBCtIo-dWuerDpd8jlstmitJ3Hq0vJhDv7C5ahO24g>
    <xme:u9rzYvmNbncNIYZYptR0BcDvjVV6e97xBiIROp69wAdVNh9JidRjEfm94ygLJ7Ry_
    D9hObvlbMkwNB81RR4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdegvddgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkfffhvffutgesthdtredtreertdenucfhrhhomhepfdevhhhrihhs
    ucfouhhrphhhhidfuceolhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomheqne
    cuggftrfgrthhtvghrnhepfeefledtjeehfeduteejvdelffdvveeigeeugeffvdffveff
    veekiedvhfekieeknecuffhomhgrihhnpehrvgguhhgrthdrtghomhenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehlihhsthhssegtohhlohhr
    rhgvmhgvughivghsrdgtohhm
X-ME-Proxy: <xmx:u9rzYjaBjPSoRNUbypJ7mt4rJ-g526bbN-0qZXVhCVYnrHmhS6Glog>
    <xmx:u9rzYiX0lJLVxvFHDtbFDRAbTq9omjRhfHlHmZ9bdqlVmYGBCy3yFA>
    <xmx:u9rzYhn2JKEfiWoulKPff_gzQlEZ2p_eTjg4srhSlQzF787saEEblg>
    <xmx:u9rzYtzOV3cNhSrKro6bJeYRC6sXl0nlbsEJNnrsxBdNDkq-wiB8uQ>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 6EF3A1700083; Wed, 10 Aug 2022 12:20:11 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-811-gb808317eab-fm-20220801.001-gb808317e
Mime-Version: 1.0
Message-Id: <f7c14f0f-56e5-4748-a3f7-d44bc635b020@www.fastmail.com>
Date:   Wed, 10 Aug 2022 12:19:46 -0400
From:   "Chris Murphy" <lists@colorremedies.com>
To:     "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Subject: 5.19.0: dnf install hangs when system is under load
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Downstream bug - 5.19.0: dnf install hangs when system is under load
https://bugzilla.redhat.com/show_bug.cgi?id=2117326

5.19.0-65.fc37.x86_64

Setup
btrfs raid10 on 8x plain partitions

Command
sudo dnf install pciutils

Reproducible:
About 1 in 3, correlates with the system being under heavy load, otherwise it's not happening

Get stuck at 
Running scriptlet: sg3_utils-1.46-3.fc36.x86_64   2/2 

ps aux status for dnf is D+, kill -9 does nothing, strace shows nothing. The hang last at least 10 minutes, didn't test beyond that.

Full dmesg with sysrq+w is attached to the bug report.

snippet

[ 2268.057017] sysrq: Show Blocked State
[ 2268.057866] task:kworker/u97:11  state:D stack:    0 pid:  340 ppid:     2 flags:0x00004000
[ 2268.058361] Workqueue: writeback wb_workfn (flush-btrfs-1)
[ 2268.058825] Call Trace:
[ 2268.059261]  <TASK>
[ 2268.059692]  __schedule+0x335/0x1240
[ 2268.060145]  ? __blk_mq_sched_dispatch_requests+0xe0/0x130
[ 2268.060611]  schedule+0x4e/0xb0
[ 2268.061059]  io_schedule+0x42/0x70
[ 2268.061473]  blk_mq_get_tag+0x10c/0x290
[ 2268.061910]  ? dequeue_task_stop+0x70/0x70
[ 2268.062359]  __blk_mq_alloc_requests+0x16e/0x2a0
[ 2268.062797]  blk_mq_submit_bio+0x2a2/0x590
[ 2268.063226]  __submit_bio+0xf5/0x180
[ 2268.063660]  submit_bio_noacct_nocheck+0x1f9/0x2b0
[ 2268.064055]  btrfs_map_bio+0x170/0x410
[ 2268.064451]  btrfs_submit_data_bio+0x134/0x220
[ 2268.064859]  ? __mod_memcg_lruvec_state+0x93/0x110
[ 2268.065246]  submit_extent_page+0x17a/0x4b0
[ 2268.065637]  ? page_vma_mkclean_one.constprop.0+0x1b0/0x1b0
[ 2268.066018]  __extent_writepage_io.constprop.0+0x271/0x550
[ 2268.066363]  ? end_extent_writepage+0x100/0x100
[ 2268.066720]  ? writepage_delalloc+0x8a/0x180
[ 2268.067094]  __extent_writepage+0x115/0x490
[ 2268.067472]  extent_write_cache_pages+0x178/0x500
[ 2268.067889]  extent_writepages+0x60/0x140
[ 2268.068274]  do_writepages+0xac/0x1a0
[ 2268.068643]  __writeback_single_inode+0x3d/0x350
[ 2268.069022]  ? _raw_spin_lock+0x13/0x40
[ 2268.069419]  writeback_sb_inodes+0x1c5/0x460
[ 2268.069824]  __writeback_inodes_wb+0x4c/0xe0
[ 2268.070230]  wb_writeback+0x1c9/0x2a0
[ 2268.070622]  wb_workfn+0x298/0x490
[ 2268.070988]  process_one_work+0x1c7/0x380
[ 2268.071366]  worker_thread+0x4d/0x380
[ 2268.071775]  ? process_one_work+0x380/0x380
[ 2268.072179]  kthread+0xe9/0x110
[ 2268.072588]  ? kthread_complete_and_exit+0x20/0x20
[ 2268.073002]  ret_from_fork+0x22/0x30
[ 2268.073408]  </TASK>
[ 2268.073912] task:systemd-journal state:D stack:    0 pid: 1208 ppid:     1 flags:0x00000002
[ 2268.074334] Call Trace:
[ 2268.074756]  <TASK>
[ 2268.075165]  __schedule+0x335/0x1240
[ 2268.075586]  ? __blk_flush_plug+0xf2/0x130
[ 2268.075950]  schedule+0x4e/0xb0
[ 2268.076305]  io_schedule+0x42/0x70
[ 2268.076692]  folio_wait_bit_common+0x116/0x390
[ 2268.077075]  ? filemap_alloc_folio+0xc0/0xc0
[ 2268.077447]  filemap_fault+0xcf/0x980
[ 2268.077821]  __do_fault+0x36/0x130
[ 2268.078153]  do_fault+0x1da/0x440
[ 2268.078483]  __handle_mm_fault+0x9cf/0xed0
[ 2268.078837]  handle_mm_fault+0xae/0x280
[ 2268.079202]  do_user_addr_fault+0x1c5/0x670
[ 2268.079567]  exc_page_fault+0x70/0x170
[ 2268.079929]  asm_exc_page_fault+0x22/0x30
[ 2268.080282] RIP: 0033:0x7f3d8efd6519
[ 2268.080657] RSP: 002b:00007ffd4a073ac0 EFLAGS: 00010202
[ 2268.081017] RAX: 00007f3d8c6586d8 RBX: 00000000016bb6d8 RCX: 00007f3d8efe1309
[ 2268.081374] RDX: 00007ffd4a073ac0 RSI: 000055d6da7a52e8 RDI: 000055d6da7a52a0
[ 2268.081756] RBP: 00007ffd4a073b48 R08: 000055d6da7b7a00 R09: 000055d6da7aaea8
[ 2268.082147] R10: 0000000000000004 R11: 00007ffd4a073e00 R12: 000055d6da7aae70
[ 2268.082511] R13: 0000000000000001 R14: 00007ffd4a073ac0 R15: 00000000016bb6d8
[ 2268.082883]  </TASK>
[ 2268.083757] task:kworker/u97:0   state:D stack:    0 pid: 7664 ppid:     2 flags:0x00004000
[ 2268.084149] Workqueue: writeback wb_workfn (flush-btrfs-1)
[ 2268.084537] Call Trace:
[ 2268.084918]  <TASK>
[ 2268.085289]  __schedule+0x335/0x1240
[ 2268.085675]  ? __blk_flush_plug+0xf2/0x130
[ 2268.086056]  schedule+0x4e/0xb0
[ 2268.086406]  io_schedule+0x42/0x70
[ 2268.086786]  blk_mq_get_tag+0x10c/0x290
[ 2268.087160]  ? dequeue_task_stop+0x70/0x70
[ 2268.087539]  __blk_mq_alloc_requests+0x16e/0x2a0
[ 2268.087912]  blk_mq_submit_bio+0x2a2/0x590
[ 2268.088287]  __submit_bio+0xf5/0x180
[ 2268.088676]  submit_bio_noacct_nocheck+0x1f9/0x2b0
[ 2268.089052]  btrfs_map_bio+0x170/0x410
[ 2268.089426]  btrfs_submit_data_bio+0x134/0x220
[ 2268.089813]  ? __mod_memcg_lruvec_state+0x93/0x110
[ 2268.090192]  submit_extent_page+0x17a/0x4b0
[ 2268.090587]  ? page_vma_mkclean_one.constprop.0+0x1b0/0x1b0
[ 2268.090975]  __extent_writepage_io.constprop.0+0x271/0x550
[ 2268.091365]  ? end_extent_writepage+0x100/0x100
[ 2268.091757]  ? writepage_delalloc+0x8a/0x180
[ 2268.092141]  __extent_writepage+0x115/0x490
[ 2268.092534]  extent_write_cache_pages+0x178/0x500
[ 2268.092890]  extent_writepages+0x60/0x140
[ 2268.093247]  do_writepages+0xac/0x1a0
[ 2268.093624]  ? __blk_mq_sched_dispatch_requests+0xe0/0x130
[ 2268.094004]  __writeback_single_inode+0x3d/0x350
[ 2268.094376]  ? _raw_spin_lock+0x13/0x40
[ 2268.094765]  writeback_sb_inodes+0x1c5/0x460
[ 2268.095151]  __writeback_inodes_wb+0x4c/0xe0
[ 2268.095531]  wb_writeback+0x1c9/0x2a0
[ 2268.095913]  wb_workfn+0x306/0x490
[ 2268.096291]  process_one_work+0x1c7/0x380
[ 2268.096686]  worker_thread+0x4d/0x380
[ 2268.097070]  ? process_one_work+0x380/0x380
[ 2268.097448]  kthread+0xe9/0x110
[ 2268.097842]  ? kthread_complete_and_exit+0x20/0x20
[ 2268.098224]  ret_from_fork+0x22/0x30
[ 2268.098623]  </TASK>
[ 2268.099008] task:kworker/u97:7   state:D stack:    0 pid: 7665 ppid:     2 flags:0x00004000
[ 2268.099410] Workqueue: blkcg_punt_bio blkg_async_bio_workfn
[ 2268.099815] Call Trace:
[ 2268.100198]  <TASK>
[ 2268.100589]  __schedule+0x335/0x1240
[ 2268.100982]  ? __blk_mq_sched_dispatch_requests+0xe0/0x130
[ 2268.101377]  schedule+0x4e/0xb0
[ 2268.101772]  io_schedule+0x42/0x70
[ 2268.102153]  blk_mq_get_tag+0x10c/0x290
[ 2268.102537]  ? dequeue_task_stop+0x70/0x70
[ 2268.102902]  __blk_mq_alloc_requests+0x16e/0x2a0
[ 2268.103275]  blk_mq_submit_bio+0x2a2/0x590
[ 2268.103659]  __submit_bio+0xf5/0x180
[ 2268.104032]  submit_bio_noacct_nocheck+0x1f9/0x2b0
[ 2268.104408]  blkg_async_bio_workfn+0x66/0x90
[ 2268.104797]  process_one_work+0x1c7/0x380
[ 2268.105181]  worker_thread+0x1d6/0x380
[ 2268.105572]  ? process_one_work+0x380/0x380
[ 2268.105949]  kthread+0xe9/0x110
[ 2268.106319]  ? kthread_complete_and_exit+0x20/0x20
[ 2268.106667]  ret_from_fork+0x22/0x30
[ 2268.106882]  </TASK>



--
Chris Murphy
