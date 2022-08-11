Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 356E258F594
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Aug 2022 03:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233470AbiHKBcs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Aug 2022 21:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbiHKBcr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Aug 2022 21:32:47 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6852844EC;
        Wed, 10 Aug 2022 18:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660181560;
        bh=7YxhFVbkAeVguKwx/9nHtpvcE1ikrjJgdSj4Kr+qlOw=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=EDHIT2Dxdb9M49VEHlpG+6YswuHYz5y3UcaPK4nhDlt3Q+uz8iRtrk4pU6SWdzWib
         OQ4JlOJDzwFcnWTaW7I/t+Jp76KAXjpEGuYOlB/K8WhfnJeN2OXz/RrOzYGCy3TNi+
         EbPwPWVy4CSYkpSZ8KLJh2BzFRz67cEJ1lp3jx0g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MAfUe-1oFNTr1mEC-00B2KZ; Thu, 11
 Aug 2022 03:32:40 +0200
Message-ID: <073b7d19-b02b-cbfc-9b61-dbacbf08ed93@gmx.com>
Date:   Thu, 11 Aug 2022 09:32:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: 5.19.0: dnf install hangs when system is under load
Content-Language: en-US
To:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <f7c14f0f-56e5-4748-a3f7-d44bc635b020@www.fastmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <f7c14f0f-56e5-4748-a3f7-d44bc635b020@www.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CP+fLWItP6KQn35Vfpr/saXGOZ2vhVcWqjH/JwMICT0NLX2b5MW
 61L+zzCbi8eBhdbTVTYovNaHGx4KLM42igOiOVGXVK7L0X9hhQ/n9I4egFNEj0DG9cODn2S
 snCE78QxGqS09wFKJ4Od6C0d6+OjZQF/cYeZEi2bKSpF4h9F48tAr7vwAG82II0qZvqmrPI
 5kxPyOCepAuv291aFxL7A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gnUmbA/R940=:2A8poYYMHqJ/eUOlOyawVS
 a67+I2/MNVw+L4RDbyMtkqjQS+stpRAL5tqN7q/AcVsGTkKXlJznI8dA9TtUOSpiWRaQgTuF5
 Ua2I6SPMVmKfW3vZGxLKvbB+BtTbC5oEuCv+VAX9e5IpO380DwT2V+JrnYIUD+diYJvHjvVys
 edm/G1Nldcx34PqP84tjG8B7IukQ9gXwJeNKrzqH3c8t7HR932/h37aqLeB2BBXqnzyY4NWXx
 0/6P0gy7OPUxABsHBX4Pp/HoIpxEJkC+vi1oCvbCpFi8YHJQxcP7DpzNCkcCd2UEiOlTzMfHM
 n1cUNelWXY49XzgviVLsRzRZTlD8g379J94XKc73d1tpWmKEWdKJTxQU+OOD+rHFIPyab10Ib
 9ifetLsiyGJ7+xpKtL6PpjyCWqGFi4oinXCDg+FtF5S43sPsUrlVXjDBHIkT4kMV8rZYaxR+3
 jyWyufn0b1eV3fQUQM3Lkb9vwga/5J7pjj1SJe3GHtPkF/n8LH6RVpWZZUFsxuTDJBLVPM/S0
 MusSfzTCLBwi/Q/G4c6XKYqk55+8g6/dBHLYqy106d+2LDIk+6+yW/GzajXm15kVh3zUsDySP
 n7SnwiTDLl/MjkexEmeqBaJ5P1sHCOALhuqo30g9sd2OGFG/eaWhy2MKfQ/CtC/TG+EOL+sJa
 tCSQ527W5YjJ2ZTvyQ/1G16ZMHIQe9lhoWPzrl6MYzfBdy1hmFpgUpNN1WFtgKxoyAC1gS+lz
 CgvfiJvSy2I/ZLVHuI3i4ecvEsUxXBQbrFmfMWRRBLbmiP8XkONwtGwAPloUCjep4RahgMfCv
 kM0OpxWoZWVqsWEQ2hXhKZkp2JkkDkTTgzOscSmnIMk1rT1NwmGnhDAGi6cTocr3G9kQU/U8G
 6pM4Ygo1S84oIW5H5Rs6npmkP+fj7E4xmiKkopGeIi/KOlgA3j/GeKifkMEvmXybH7yO9/ILY
 nxxoyv7re5pL6IeMWJalgZpd4uVwy+AOWgTB0ZFQGXPov2e8LuHmh42j+ZagLI1On6W2h7yRH
 8FfH7dXh19g3QIVoBE+TFgzXuUw0g6m7eVLc2A+semvD1RUTwNkaRtg7PuW0iCYGv9iO+zVeV
 M9pWq2zwxQECkUGs6/FC9/aE7gJaC1f1KMb/bQmG2jpUU0G5XSzox9fjQ==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/8/11 00:19, Chris Murphy wrote:
> Downstream bug - 5.19.0: dnf install hangs when system is under load
> https://bugzilla.redhat.com/show_bug.cgi?id=3D2117326
>
> 5.19.0-65.fc37.x86_64
>
> Setup
> btrfs raid10 on 8x plain partitions
>
> Command
> sudo dnf install pciutils
>
> Reproducible:
> About 1 in 3, correlates with the system being under heavy load, otherwi=
se it's not happening
>
> Get stuck at
> Running scriptlet: sg3_utils-1.46-3.fc36.x86_64   2/2
>
> ps aux status for dnf is D+, kill -9 does nothing, strace shows nothing.=
 The hang last at least 10 minutes, didn't test beyond that.
>
> Full dmesg with sysrq+w is attached to the bug report.
>
> snippet
>
> [ 2268.057017] sysrq: Show Blocked State
> [ 2268.057866] task:kworker/u97:11  state:D stack:    0 pid:  340 ppid: =
    2 flags:0x00004000
> [ 2268.058361] Workqueue: writeback wb_workfn (flush-btrfs-1)
> [ 2268.058825] Call Trace:
> [ 2268.059261]  <TASK>
> [ 2268.059692]  __schedule+0x335/0x1240
> [ 2268.060145]  ? __blk_mq_sched_dispatch_requests+0xe0/0x130
> [ 2268.060611]  schedule+0x4e/0xb0
> [ 2268.061059]  io_schedule+0x42/0x70
> [ 2268.061473]  blk_mq_get_tag+0x10c/0x290

All the hanging processes are waiting at blk_mq_get_tag(), thus I'm not
sure if it's really btrfs, or something in the block layer.

Adding block layer guys into the thread.

Thanks,
Qu

> [ 2268.061910]  ? dequeue_task_stop+0x70/0x70
> [ 2268.062359]  __blk_mq_alloc_requests+0x16e/0x2a0
> [ 2268.062797]  blk_mq_submit_bio+0x2a2/0x590
> [ 2268.063226]  __submit_bio+0xf5/0x180
> [ 2268.063660]  submit_bio_noacct_nocheck+0x1f9/0x2b0
> [ 2268.064055]  btrfs_map_bio+0x170/0x410
> [ 2268.064451]  btrfs_submit_data_bio+0x134/0x220
> [ 2268.064859]  ? __mod_memcg_lruvec_state+0x93/0x110
> [ 2268.065246]  submit_extent_page+0x17a/0x4b0
> [ 2268.065637]  ? page_vma_mkclean_one.constprop.0+0x1b0/0x1b0
> [ 2268.066018]  __extent_writepage_io.constprop.0+0x271/0x550
> [ 2268.066363]  ? end_extent_writepage+0x100/0x100
> [ 2268.066720]  ? writepage_delalloc+0x8a/0x180
> [ 2268.067094]  __extent_writepage+0x115/0x490
> [ 2268.067472]  extent_write_cache_pages+0x178/0x500
> [ 2268.067889]  extent_writepages+0x60/0x140
> [ 2268.068274]  do_writepages+0xac/0x1a0
> [ 2268.068643]  __writeback_single_inode+0x3d/0x350
> [ 2268.069022]  ? _raw_spin_lock+0x13/0x40
> [ 2268.069419]  writeback_sb_inodes+0x1c5/0x460
> [ 2268.069824]  __writeback_inodes_wb+0x4c/0xe0
> [ 2268.070230]  wb_writeback+0x1c9/0x2a0
> [ 2268.070622]  wb_workfn+0x298/0x490
> [ 2268.070988]  process_one_work+0x1c7/0x380
> [ 2268.071366]  worker_thread+0x4d/0x380
> [ 2268.071775]  ? process_one_work+0x380/0x380
> [ 2268.072179]  kthread+0xe9/0x110
> [ 2268.072588]  ? kthread_complete_and_exit+0x20/0x20
> [ 2268.073002]  ret_from_fork+0x22/0x30
> [ 2268.073408]  </TASK>
> [ 2268.073912] task:systemd-journal state:D stack:    0 pid: 1208 ppid: =
    1 flags:0x00000002
> [ 2268.074334] Call Trace:
> [ 2268.074756]  <TASK>
> [ 2268.075165]  __schedule+0x335/0x1240
> [ 2268.075586]  ? __blk_flush_plug+0xf2/0x130
> [ 2268.075950]  schedule+0x4e/0xb0
> [ 2268.076305]  io_schedule+0x42/0x70
> [ 2268.076692]  folio_wait_bit_common+0x116/0x390
> [ 2268.077075]  ? filemap_alloc_folio+0xc0/0xc0
> [ 2268.077447]  filemap_fault+0xcf/0x980
> [ 2268.077821]  __do_fault+0x36/0x130
> [ 2268.078153]  do_fault+0x1da/0x440
> [ 2268.078483]  __handle_mm_fault+0x9cf/0xed0
> [ 2268.078837]  handle_mm_fault+0xae/0x280
> [ 2268.079202]  do_user_addr_fault+0x1c5/0x670
> [ 2268.079567]  exc_page_fault+0x70/0x170
> [ 2268.079929]  asm_exc_page_fault+0x22/0x30
> [ 2268.080282] RIP: 0033:0x7f3d8efd6519
> [ 2268.080657] RSP: 002b:00007ffd4a073ac0 EFLAGS: 00010202
> [ 2268.081017] RAX: 00007f3d8c6586d8 RBX: 00000000016bb6d8 RCX: 00007f3d=
8efe1309
> [ 2268.081374] RDX: 00007ffd4a073ac0 RSI: 000055d6da7a52e8 RDI: 000055d6=
da7a52a0
> [ 2268.081756] RBP: 00007ffd4a073b48 R08: 000055d6da7b7a00 R09: 000055d6=
da7aaea8
> [ 2268.082147] R10: 0000000000000004 R11: 00007ffd4a073e00 R12: 000055d6=
da7aae70
> [ 2268.082511] R13: 0000000000000001 R14: 00007ffd4a073ac0 R15: 00000000=
016bb6d8
> [ 2268.082883]  </TASK>
> [ 2268.083757] task:kworker/u97:0   state:D stack:    0 pid: 7664 ppid: =
    2 flags:0x00004000
> [ 2268.084149] Workqueue: writeback wb_workfn (flush-btrfs-1)
> [ 2268.084537] Call Trace:
> [ 2268.084918]  <TASK>
> [ 2268.085289]  __schedule+0x335/0x1240
> [ 2268.085675]  ? __blk_flush_plug+0xf2/0x130
> [ 2268.086056]  schedule+0x4e/0xb0
> [ 2268.086406]  io_schedule+0x42/0x70
> [ 2268.086786]  blk_mq_get_tag+0x10c/0x290
> [ 2268.087160]  ? dequeue_task_stop+0x70/0x70
> [ 2268.087539]  __blk_mq_alloc_requests+0x16e/0x2a0
> [ 2268.087912]  blk_mq_submit_bio+0x2a2/0x590
> [ 2268.088287]  __submit_bio+0xf5/0x180
> [ 2268.088676]  submit_bio_noacct_nocheck+0x1f9/0x2b0
> [ 2268.089052]  btrfs_map_bio+0x170/0x410
> [ 2268.089426]  btrfs_submit_data_bio+0x134/0x220
> [ 2268.089813]  ? __mod_memcg_lruvec_state+0x93/0x110
> [ 2268.090192]  submit_extent_page+0x17a/0x4b0
> [ 2268.090587]  ? page_vma_mkclean_one.constprop.0+0x1b0/0x1b0
> [ 2268.090975]  __extent_writepage_io.constprop.0+0x271/0x550
> [ 2268.091365]  ? end_extent_writepage+0x100/0x100
> [ 2268.091757]  ? writepage_delalloc+0x8a/0x180
> [ 2268.092141]  __extent_writepage+0x115/0x490
> [ 2268.092534]  extent_write_cache_pages+0x178/0x500
> [ 2268.092890]  extent_writepages+0x60/0x140
> [ 2268.093247]  do_writepages+0xac/0x1a0
> [ 2268.093624]  ? __blk_mq_sched_dispatch_requests+0xe0/0x130
> [ 2268.094004]  __writeback_single_inode+0x3d/0x350
> [ 2268.094376]  ? _raw_spin_lock+0x13/0x40
> [ 2268.094765]  writeback_sb_inodes+0x1c5/0x460
> [ 2268.095151]  __writeback_inodes_wb+0x4c/0xe0
> [ 2268.095531]  wb_writeback+0x1c9/0x2a0
> [ 2268.095913]  wb_workfn+0x306/0x490
> [ 2268.096291]  process_one_work+0x1c7/0x380
> [ 2268.096686]  worker_thread+0x4d/0x380
> [ 2268.097070]  ? process_one_work+0x380/0x380
> [ 2268.097448]  kthread+0xe9/0x110
> [ 2268.097842]  ? kthread_complete_and_exit+0x20/0x20
> [ 2268.098224]  ret_from_fork+0x22/0x30
> [ 2268.098623]  </TASK>
> [ 2268.099008] task:kworker/u97:7   state:D stack:    0 pid: 7665 ppid: =
    2 flags:0x00004000
> [ 2268.099410] Workqueue: blkcg_punt_bio blkg_async_bio_workfn
> [ 2268.099815] Call Trace:
> [ 2268.100198]  <TASK>
> [ 2268.100589]  __schedule+0x335/0x1240
> [ 2268.100982]  ? __blk_mq_sched_dispatch_requests+0xe0/0x130
> [ 2268.101377]  schedule+0x4e/0xb0
> [ 2268.101772]  io_schedule+0x42/0x70
> [ 2268.102153]  blk_mq_get_tag+0x10c/0x290
> [ 2268.102537]  ? dequeue_task_stop+0x70/0x70
> [ 2268.102902]  __blk_mq_alloc_requests+0x16e/0x2a0
> [ 2268.103275]  blk_mq_submit_bio+0x2a2/0x590
> [ 2268.103659]  __submit_bio+0xf5/0x180
> [ 2268.104032]  submit_bio_noacct_nocheck+0x1f9/0x2b0
> [ 2268.104408]  blkg_async_bio_workfn+0x66/0x90
> [ 2268.104797]  process_one_work+0x1c7/0x380
> [ 2268.105181]  worker_thread+0x1d6/0x380
> [ 2268.105572]  ? process_one_work+0x380/0x380
> [ 2268.105949]  kthread+0xe9/0x110
> [ 2268.106319]  ? kthread_complete_and_exit+0x20/0x20
> [ 2268.106667]  ret_from_fork+0x22/0x30
> [ 2268.106882]  </TASK>
>
>
>
> --
> Chris Murphy
