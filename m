Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32C40609736
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Oct 2022 01:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiJWXRY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 23 Oct 2022 19:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiJWXRX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 23 Oct 2022 19:17:23 -0400
Received: from len.romanrm.net (len.romanrm.net [IPv6:2001:41d0:1:8b3b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F3369BEA
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Oct 2022 16:17:19 -0700 (PDT)
Received: from nvm (nvm2.home.romanrm.net [IPv6:fd39::4a:3cff:fe57:d6b5])
        by len.romanrm.net (Postfix) with SMTP id 5CEA44005D
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Oct 2022 23:17:17 +0000 (UTC)
Date:   Mon, 24 Oct 2022 04:17:13 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     linux-btrfs@vger.kernel.org
Subject: WARN_ON in __writeback_inodes_sb_nr when btrfs mounted with
 flushoncommit
Message-ID: <20221024041713.76aeff42@nvm>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

Just wanted to report that I still get the same warning with flushoncommit as
someone posted[1][2] back in 2017, also today on kernel 5.10.149. Was that
supposed to be fixed? Or maybe fixed in 6.0+?

Thanks

[1] https://www.spinics.net/lists/linux-btrfs/msg72483.html
[2] https://marc.info/?l=linux-btrfs&m=151315564008773

[Mon Oct 24 03:49:18 2022] WARNING: CPU: 9 PID: 8883 at fs/fs-writeback.c:2456 __writeback_inodes_sb_nr+0xba/0xd0
[Mon Oct 24 03:49:18 2022] Modules linked in: dm_snapshot(E) nls_ascii(E) nls_cp437(E) vfat(E) fat(E) uas(E) usb_storage(E) xt_set(E) ip_set_hash_net(E) ip_set(E) nfnetlink(E) veth(E) vhost_net(E) vhost(E) vhost_iotlb(E) tap(E) tun(E) i2c_dev(E) sit(E) tunnel4(E) ip_tunnel(E) xt_comment(E) xt_multiport(E) xt_limit(E) xt_length(E) xt_CT(E) xt_tcpudp(E) xt_state(E) xt_conntrack(E) ip6t_rpfilter(E) ipt_rpfilter(E) ip6table_nat(E) ip6table_raw(E) ip6table_mangle(E) iptable_nat(E) nf_nat(E) nf_conntrack(E) nf_defrag_ipv6(E) nf_defrag_ipv4(E) iptable_raw(E) iptable_mangle(E) ip6table_filter(E) ip6_tables(E) iptable_filter(E) ip_tables(E) x_tables(E) cpufreq_userspace(E) cpufreq_conservative(E) cpufreq_ondemand(E) cpufreq_powersave(E) fuse(E) nbd(E) 8021q(E) garp(E) mrp(E) bridge(E) stp(E) llc(E) tcp_bbr(E) xfs(E) dm_thin_pool(E) crc32_generic(E) loop(E) radeon(E) edac_mce_amd(E) kvm_amd(E) ttm(E) drm_kms_helper(E) kvm(E) cec(E) drm(E) snd_pcsp(E) i2c_algo_bit(E) irqbypass(E) snd_pcm(E) evd
 ev(E) cp210x(E)
[Mon Oct 24 03:49:18 2022]  rapl(E) joydev(E) snd_timer(E) usbserial(E) snd(E) sg(E) wmi_bmof(E) soundcore(E) sp5100_tco(E) ccp(E) watchdog(E) rng_core(E) k10temp(E) acpi_cpufreq(E) button(E) ext4(E) crc16(E) mbcache(E) jbd2(E) btrfs(E) blake2b_generic(E) dm_crypt(E) raid10(E) raid456(E) async_raid6_recov(E) async_memcpy(E) async_pq(E) async_xor(E) async_tx(E) xor(E) raid6_pq(E) raid0(E) multipath(E) linear(E) dm_cache_smq(E) dm_cache(E) dm_persistent_data(E) dm_bio_prison(E) dm_bufio(E) dm_mod(E) libcrc32c(E) crc32c_generic(E) sd_mod(E) hid_generic(E) usbhid(E) hid(E) raid1(E) r8169(E) ahci(E) crc32_pclmul(E) realtek(E) libahci(E) crc32c_intel(E) md_mod(E) ghash_clmulni_intel(E) xhci_pci(E) aesni_intel(E) libaes(E) crypto_simd(E) cryptd(E) glue_helper(E) mdio_devres(E) nvme(E) libata(E) i2c_piix4(E) xhci_hcd(E) libphy(E) nvme_core(E) t10_pi(E) scsi_mod(E) usbcore(E) crc_t10dif(E) usb_common(E) crct10dif_generic(E) crct10dif_pclmul(E) crct10dif_common(E) wmi(E) gpio_amdpt(E) gpio_gen
 eric(E)
[Mon Oct 24 03:49:18 2022] CPU: 9 PID: 8883 Comm: btrfs-transacti Tainted: G        W   E     5.10.149-rm1+ #308
[Mon Oct 24 03:49:18 2022] Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./B550 PG Velocita, BIOS P2.10 08/04/2021
[Mon Oct 24 03:49:18 2022] RIP: 0010:__writeback_inodes_sb_nr+0xba/0xd0
[Mon Oct 24 03:49:18 2022] Code: c7 0f b6 d1 e8 47 fc ff ff 48 89 e7 e8 bf fb ff ff 48 8b 44 24 48 65 48 33 04 25 28 00 00 00 75 11 48 83 c4 50 c3 cc cc cc cc <0f> 0b 0f 1f 40 00 eb c7 e8 e9 7e 59 00 66 0f 1f 84 00 00 00 00 00
[Mon Oct 24 03:49:18 2022] RSP: 0018:ffffba9303a3be00 EFLAGS: 00010246
[Mon Oct 24 03:49:18 2022] RAX: ffff95c0e044dc00 RBX: ffff95bc04f4f340 RCX: 0000000000000000
[Mon Oct 24 03:49:18 2022] RDX: 0000000000000000 RSI: 0000000000088d13 RDI: ffff95bd2556b000
[Mon Oct 24 03:49:18 2022] RBP: ffff95bd011e0000 R08: ffff95c0e044df58 R09: 000000000000001f
[Mon Oct 24 03:49:18 2022] R10: 000000000000003c R11: 0000000000000000 R12: ffff95c022220e00
[Mon Oct 24 03:49:18 2022] R13: ffff95bd011e0460 R14: ffff95bd011e0488 R15: ffff95bd2556c000
[Mon Oct 24 03:49:18 2022] FS:  0000000000000000(0000) GS:ffff95cbfec40000(0000) knlGS:0000000000000000
[Mon Oct 24 03:49:18 2022] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[Mon Oct 24 03:49:18 2022] CR2: fffffa8000048000 CR3: 000000035f8ba000 CR4: 0000000000750ee0
[Mon Oct 24 03:49:18 2022] PKRU: 55555554
[Mon Oct 24 03:49:18 2022] Call Trace:
[Mon Oct 24 03:49:18 2022]  btrfs_commit_transaction+0x39c/0xb80 [btrfs]
[Mon Oct 24 03:49:18 2022]  ? start_transaction+0xe8/0x5b0 [btrfs]
[Mon Oct 24 03:49:18 2022]  transaction_kthread+0x163/0x180 [btrfs]
[Mon Oct 24 03:49:18 2022]  ? btrfs_cleanup_transaction+0x580/0x580 [btrfs]
[Mon Oct 24 03:49:18 2022]  kthread+0x117/0x130
[Mon Oct 24 03:49:18 2022]  ? __kthread_cancel_work+0x50/0x50
[Mon Oct 24 03:49:18 2022]  ret_from_fork+0x22/0x30
[Mon Oct 24 03:49:18 2022] ---[ end trace 88a48b38d299109e ]---

-- 
With respect,
Roman
