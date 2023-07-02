Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8619174530A
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jul 2023 01:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjGBX23 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sun, 2 Jul 2023 19:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjGBX22 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 2 Jul 2023 19:28:28 -0400
Received: from ste-pvt-msa2.bahnhof.se (ste-pvt-msa2.bahnhof.se [213.80.101.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721F9E40;
        Sun,  2 Jul 2023 16:28:24 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 1F9BC3F4EA;
        Mon,  3 Jul 2023 01:28:21 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -1.91
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id FD9DfBm3SItY; Mon,  3 Jul 2023 01:28:19 +0200 (CEST)
Received: by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id D59743F358;
        Mon,  3 Jul 2023 01:28:17 +0200 (CEST)
Received: from [192.168.0.132] (port=50956)
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <forza@tnonline.net>)
        id 1qG6UK-0005AA-2x;
        Mon, 03 Jul 2023 01:28:17 +0200
Date:   Mon, 3 Jul 2023 01:28:16 +0200 (GMT+02:00)
From:   Forza <forza@tnonline.net>
To:     Uladzislau Rezki <urezki@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Stable <stable@vger.kernel.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, a1bert@atlas.cz
Message-ID: <cf07f03.70397026.18918ef7f95@tnonline.net>
In-Reply-To: <ZHClGA9szxSqzDf8@pc636>
References: <efa04d56-cd7f-6620-bca7-1df89f49bf4b@gmail.com> <fcf1d04.faed4a1a.18844d8e78f@tnonline.net> <ZGwcVTpQNBoJHBB+@debian.me> <ZGyVVQxnw6Tn7Xb8@pc636> <c9db92d.faed4a1c.1884c5550fb@tnonline.net> <20230524091357.GH32559@suse.cz> <ZHClGA9szxSqzDf8@pc636>
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



---- From: Uladzislau Rezki <urezki@gmail.com> -- Sent: 2023-05-26 - 14:24 ----

> On Wed, May 24, 2023 at 11:13:57AM +0200, David Sterba wrote:
>> This looks like a different set of problems, though all of them seem to
>> start on the compression write path in btrfs.
>> 
>> On Wed, May 24, 2023 at 07:57:19AM +0200, Forza wrote:
>> > [   8.641506] 8021q: adding VLAN 0 to HW filter on device enp4s0
>> > [   13.841691] wireguard: WireGuard 1.0.0 loaded. See www.wireguard.com for information.
>> > [   13.841705] wireguard: Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
>> > [13917.280527] ------------[ cut here ]------------
>> > [13917.280753] default_enter_idle leaked IRQ state
>> > [13917.281004] WARNING: CPU: 3 PID: 0 at drivers/cpuidle/cpuidle.c:269 cpuidle_enter_state+0x3bb/0x430
>> 
>> 
... Snip
>> 
>> And again, so something is going wrong
>> 
> Indeed.
> 
> I suggest you run your kernel with CONFIG_KASAN=y to see if there are
> any use-after-free or out-of-bounds bugs.
> 
> --
> Uladzislau Rezki


Pardon the delay... I have enabled KASAN and UBSAN on this kernel. It produced a lot of output and plenty of warnings for misalignment. 

The full dmesg is at https://paste.tnonline.net/files/aBoUMuTd5KBC_dmesg.ubsan.txt (approx 1.7MiB)

The full kernel .conf is. at https://paste.tnonline.net/files/z1mX8TWFgZQ3_kernel.conf-kasan-ubsan.txt

A small exctract around what I think is the  default_enter_idle leaked IRQ event. Is this helpful?

================================================================================
Jul 03 00:33:57 git kernel: UBSAN: misaligned-access in net/ipv4/tcp_ipv4.c:1848:13
Jul 03 00:33:57 git kernel: member access within misaligned address 000000007604d82f for type 'const struct tcphdr'
Jul 03 00:33:57 git kernel: which requires 4 byte alignment
Jul 03 00:33:57 git kernel: CPU: 2 PID: 29 Comm: ksoftirqd/2 Not tainted 6.3.10-ksan-ubsan #8
Jul 03 00:33:57 git kernel: Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.0-20220807_005459-localhost 04/01/2014
Jul 03 00:33:57 git kernel: Call Trace:
Jul 03 00:33:57 git kernel:  <TASK>
Jul 03 00:33:57 git kernel:  dump_stack_lvl+0x86/0xd0
Jul 03 00:33:57 git kernel:  ubsan_type_mismatch_common+0xdf/0x240
Jul 03 00:33:57 git kernel:  __ubsan_handle_type_mismatch_v1+0x44/0x60
Jul 03 00:33:57 git kernel:  tcp_add_backlog+0x1fac/0x3ab0
Jul 03 00:33:57 git kernel:  ? sk_filter_trim_cap+0xcc/0xb60
Jul 03 00:33:57 git kernel:  ? __pfx_tcp_add_backlog+0x10/0x10
Jul 03 00:33:57 git kernel:  ? __pfx__raw_spin_lock+0x10/0x10
Jul 03 00:33:57 git kernel:  tcp_v4_rcv+0x3583/0x4c40
Jul 03 00:33:57 git kernel:  ? __pfx_tcp_v4_rcv+0x10/0x10
Jul 03 00:33:57 git kernel:  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
Jul 03 00:33:57 git kernel:  ip_protocol_deliver_rcu+0x6c/0x480
Jul 03 00:33:57 git kernel:  ip_local_deliver_finish+0x2ae/0x4d0
Jul 03 00:33:57 git kernel:  ? __pfx_ip_local_deliver+0x10/0x10
Jul 03 00:33:57 git kernel:  ? __pfx_ip_local_deliver+0x10/0x10
Jul 03 00:33:57 git kernel:  ip_local_deliver+0x1ba/0x380
Jul 03 00:33:57 git kernel:  ? __pfx_ip_local_deliver+0x10/0x10
Jul 03 00:33:57 git kernel:  ? ipv4_dst_check+0x104/0x250
Jul 03 00:33:57 git kernel:  ? __ubsan_handle_type_mismatch_v1+0x44/0x60
Jul 03 00:33:57 git kernel:  ip_sublist_rcv_finish+0x172/0x380
Jul 03 00:33:57 git kernel: ------------[ cut here ]------------
Jul 03 00:33:57 git kernel:  ip_sublist_rcv+0x3cd/0x900
Jul 03 00:33:57 git kernel: default_enter_idle leaked IRQ state
Jul 03 00:33:57 git kernel:  ? __pfx_ip_sublist_rcv+0x10/0x10
Jul 03 00:33:57 git kernel:  ? __ubsan_handle_type_mismatch_v1+0x44/0x60
Jul 03 00:33:57 git kernel:  ? ip_rcv_core+0x972/0x1b20
Jul 03 00:33:57 git kernel:  ip_list_rcv+0x318/0x750
Jul 03 00:33:57 git kernel:  ? __pfx_ip_list_rcv+0x10/0x10
Jul 03 00:33:57 git kernel:  ? __pfx_ip_list_rcv+0x10/0x10
Jul 03 00:33:57 git kernel:  __netif_receive_skb_list_core+0x5ad/0x1170
Jul 03 00:33:57 git kernel:  ? tcp_gro_receive+0x1f45/0x2990
Jul 03 00:33:57 git kernel:  ? __pfx___netif_receive_skb_list_core+0x10/0x10
Jul 03 00:33:57 git kernel:  ? kvm_clock_read+0x16/0x40
Jul 03 00:33:57 git kernel:  ? ktime_get_with_offset+0xd0/0x1f0
Jul 03 00:33:57 git kernel:  netif_receive_skb_list_internal+0x76f/0x1530
Jul 03 00:33:57 git kernel:  ? __pfx_netif_receive_skb_list_internal+0x10/0x10
Jul 03 00:33:57 git kernel:  ? dev_gro_receive+0x67f/0x4900
Jul 03 00:33:57 git kernel:  ? free_unref_page+0x2fd/0x680
Jul 03 00:33:57 git kernel:  ? put_page+0x69/0x2b0
Jul 03 00:33:57 git kernel:  ? __pfx_eth_type_trans+0x10/0x10
Jul 03 00:33:57 git kernel:  napi_gro_receive+0x77b/0xdc0
Jul 03 00:33:57 git kernel:  receive_buf+0x1001/0xac40
Jul 03 00:33:57 git kernel:  ? _raw_spin_lock_irqsave+0xaa/0x180
Jul 03 00:33:57 git kernel:  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
Jul 03 00:33:57 git kernel:  ? __pfx_receive_buf+0x10/0x10
Jul 03 00:33:57 git kernel:  ? _raw_spin_unlock_irqrestore+0x40/0x80
Jul 03 00:33:57 git kernel:  ? trace_hardirqs_on+0x2d/0xd0
Jul 03 00:33:57 git kernel:  ? detach_buf_split+0x27e/0xa70
Jul 03 00:33:57 git kernel:  ? virtqueue_get_buf_ctx_split+0x3c3/0x1400
Jul 03 00:33:57 git kernel:  ? virtqueue_enable_cb_delayed+0x5d0/0x1180
Jul 03 00:33:57 git kernel:  virtnet_poll+0x7c7/0x2030
Jul 03 00:33:57 git kernel:  ? __pfx_virtnet_poll+0x10/0x10
Jul 03 00:33:57 git kernel:  ? __pfx__raw_spin_lock+0x10/0x10
Jul 03 00:33:57 git kernel:  ? __run_timers+0x43d/0xf70
Jul 03 00:33:57 git kernel:  __napi_poll.constprop.0+0xd4/0x840
Jul 03 00:33:57 git kernel:  net_rx_action+0x7a0/0x26e0
Jul 03 00:33:57 git kernel:  ? __pfx_net_rx_action+0x10/0x10
Jul 03 00:33:57 git kernel:  __do_softirq+0x277/0x95d
Jul 03 00:33:57 git kernel:  ? __pfx___do_softirq+0x10/0x10
Jul 03 00:33:57 git kernel:  ? __pfx_run_ksoftirqd+0x10/0x10
Jul 03 00:33:57 git kernel:  ? __pfx_run_ksoftirqd+0x10/0x10
Jul 03 00:33:57 git kernel:  run_ksoftirqd+0x2c/0x40
Jul 03 00:33:57 git kernel:  smpboot_thread_fn+0x380/0xbc0
Jul 03 00:33:57 git kernel:  ? __kthread_parkme+0xdc/0x280
Jul 03 00:33:57 git kernel:  ? schedule+0x158/0x360
Jul 03 00:33:57 git kernel:  ? __pfx_smpboot_thread_fn+0x10/0x10
Jul 03 00:33:57 git kernel:  kthread+0x259/0x3d0
Jul 03 00:33:57 git kernel:  ? __pfx_kthread+0x10/0x10
Jul 03 00:33:57 git kernel:  ret_from_fork+0x2c/0x50
Jul 03 00:33:57 git kernel:  </TASK>
Jul 03 00:33:57 git kernel: ================================================================================

