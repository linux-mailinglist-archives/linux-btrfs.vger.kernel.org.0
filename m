Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13ECF10A693
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Nov 2019 23:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbfKZWc7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 26 Nov 2019 17:32:59 -0500
Received: from mailgw-02.dd24.net ([193.46.215.43]:57368 "EHLO
        mailgw-02.dd24.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbfKZWc7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Nov 2019 17:32:59 -0500
X-Greylist: delayed 341 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Nov 2019 17:32:57 EST
Received: from mailpolicy-01.live.igb.homer.key-systems.net (mailpolicy-02.live.igb.homer.key-systems.net [192.168.1.27])
        by mailgw-02.dd24.net (Postfix) with ESMTP id 3199B60170
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Nov 2019 22:27:15 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at
        mailpolicy-02.live.igb.homer.key-systems.net
Received: from smtp.dd24.net ([192.168.1.36])
        by mailpolicy-01.live.igb.homer.key-systems.net (mailpolicy-02.live.igb.homer.key-systems.net [192.168.1.25]) (amavisd-new, port 10236)
        with ESMTP id 7IPqUNYq52wt for <linux-btrfs@vger.kernel.org>;
        Tue, 26 Nov 2019 22:27:12 +0000 (UTC)
Received: from heisenberg.fritz.box (ppp-46-244-243-87.dynamic.mnet-online.de [46.244.243.87])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.dd24.net (Postfix) with ESMTPSA
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Nov 2019 22:27:12 +0000 (UTC)
Message-ID: <21cb5e8d059f6e1496a903fa7bfc0a297e2f5370.camel@scientia.net>
Subject: kernel trace, (nearly) every time on send/receive
From:   Christoph Anton Mitterer <calestyo@scientia.net>
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Date:   Tue, 26 Nov 2019 23:27:11 +0100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2+b1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hey.

Since ages (my report on bugzilla[0], where the problem existed however
for probably a year or even longer, is for 4.16.16), a call trace like
the following happens nearly every time I do a send/receive:


Nov 26 23:22:38 heisenberg kernel: ------------[ cut here ]------------
Nov 26 23:22:38 heisenberg kernel: WARNING: CPU: 2 PID: 7186 at fs/btrfs/send.c:6684 btrfs_ioctl_send.cold.57+0xc/0x13 [btrfs]
Nov 26 23:22:38 heisenberg kernel: Modules linked in: uas(E) xt_CHECKSUM(E) xt_MASQUERADE(E) nft_chain_nat(E) nf_nat(E) tun(E) bridge(E) stp(E) llc(E) ctr(E) ccm(E) fuse(E) cpufreq_userspace(E) cpufreq_powersave(E) cpufreq_conservative(E) snd_hda_codec_hdmi(E) intel_rapl(E) arc4(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) coretemp(E) snd_hda_codec_realtek(E) kvm_intel(E) snd_hda_codec_generic(E) hid_generic(E) ledtrig_audio(E) btusb(E) i2c_designware_platform(E) i2c_designware_core(E) btrtl(E) kvm(E) iTCO_wdt(E) btbcm(E) mei_wdt(E) btintel(E) iTCO_vendor_support(E) irqbypass(E) watchdog(E) bluetooth(E) intel_wmi_thunderbolt(E) snd_soc_skl(E) snd_soc_skl_ipc(E) snd_soc_sst_ipc(E) crct10dif_pclmul(E) snd_soc_sst_dsp(E) iwlmvm(E) snd_hda_ext_core(E) snd_soc_acpi_intel_match(E) snd_soc_acpi(E) snd_soc_core(E) crc32_pclmul(E) mac80211(E) uvcvideo(E) snd_compress(E) videobuf2_vmalloc(E) snd_usb_audio(E) drbg(E) videobuf2_memops(E) snd_hda_intel(E) i915(E) snd_usbmidi_lib(E) videobuf2_v4l2(E) ghash_clmulni_intel(E)
Nov 26 23:22:38 heisenberg kernel:  snd_rawmidi(E) intel_cstate(E) snd_seq_device(E) cdc_mbim(E) intel_uncore(E) sdhci_pci(E) snd_hda_codec(E) cdc_wdm(E) videobuf2_common(E) iwlwifi(E) snd_hda_core(E) cdc_ncm(E) intel_rapl_perf(E) snd_hwdep(E) ansi_cprng(E) pcspkr(E) cqhci(E) joydev(E) usbhid(E) videodev(E) snd_pcm(E) snd_timer(E) usbnet(E) drm_kms_helper(E) mii(E) hid(E) snd(E) sdhci(E) soundcore(E) cfg80211(E) sg(E) idma64(E) ecdh_generic(E) media(E) i2c_i801(E) ecc(E) mmc_core(E) rfkill(E) crc16(E) drm(E) intel_lpss_pci(E) mei_me(E) intel_lpss(E) mei(E) mfd_core(E) i2c_algo_bit(E) wmi(E) button(E) battery(E) xt_tcpudp(E) ip6t_REJECT(E) nf_reject_ipv6(E) pcc_cpufreq(E) tpm_crb(E) tpm_tis(E) fujitsu_laptop(E) tpm_tis_core(E) sparse_keymap(E) video(E) tpm(E) ac(E) acpi_pad(E) rng_core(E) nft_counter(E) xt_comment(E) ipt_REJECT(E) nf_reject_ipv4(E) xt_multiport(E) xt_policy(E) xt_state(E) xt_conntrack(E) nf_conntrack(E) nf_defrag_ipv6(E) nf_defrag_ipv4(E) nft_compat(E) nf_tables(E) nfnetlink(E) binfmt_misc(E)
Nov 26 23:22:38 heisenberg kernel:  loop(E) parport_pc(E) ppdev(E) lp(E) parport(E) sunrpc(E) ip_tables(E) x_tables(E) autofs4(E) dm_crypt(E) dm_mod(E) raid10(E) raid456(E) async_raid6_recov(E) async_memcpy(E) async_pq(E) async_xor(E) async_tx(E) raid1(E) raid0(E) multipath(E) linear(E) md_mod(E) btrfs(E) libcrc32c(E) crc32c_generic(E) xor(E) zstd_decompress(E) zstd_compress(E) raid6_pq(E) uhci_hcd(E) ehci_pci(E) ehci_hcd(E) usb_storage(E) sd_mod(E) crc32c_intel(E) aesni_intel(E) xhci_pci(E) xhci_hcd(E) evdev(E) ahci(E) aes_x86_64(E) libahci(E) glue_helper(E) crypto_simd(E) psmouse(E) cryptd(E) serio_raw(E) e1000e(E) libata(E) ptp(E) pps_core(E) usbcore(E) scsi_mod(E) usb_common(E)
Nov 26 23:22:38 heisenberg kernel: CPU: 2 PID: 7186 Comm: btrfs Tainted: G            E     5.2.0-3-amd64 #1 Debian 5.2.17-1
Nov 26 23:22:38 heisenberg kernel: Hardware name: FUJITSU LIFEBOOK U757/FJNB2A5, BIOS Version 1.21 03/19/2018
Nov 26 23:22:38 heisenberg kernel: RIP: 0010:btrfs_ioctl_send.cold.57+0xc/0x13 [btrfs]
Nov 26 23:22:38 heisenberg kernel: Code: fe ff 48 c7 c2 dd 23 48 c0 89 de 4c 89 ff 41 be fb ff ff ff e8 16 fe ff ff e9 88 cf fe ff 48 c7 c7 88 a1 48 c0 e8 09 4b 87 d0 <0f> 0b e9 41 dd fe ff 0f 1f 44 00 00 55 53 48 89 fb 48 83 ec 30 65
Nov 26 23:22:38 heisenberg kernel: RSP: 0018:ffffbb4c8b653c08 EFLAGS: 00010246
Nov 26 23:22:38 heisenberg kernel: RAX: 0000000000000024 RBX: ffff9ba937a0b3f4 RCX: 0000000000000000
Nov 26 23:22:38 heisenberg kernel: RDX: 0000000000000000 RSI: ffff9ba93db17688 RDI: ffff9ba93db17688
Nov 26 23:22:38 heisenberg kernel: RBP: ffff9ba2c6c58840 R08: 00000000000003df R09: 0000000000000033
Nov 26 23:22:38 heisenberg kernel: R10: 0000000000000000 R11: ffffbb4c8b653ab8 R12: ffff9ba8f9b0f100
Nov 26 23:22:38 heisenberg kernel: R13: ffff9ba937a0b000 R14: 00007ffc5a31b230 R15: ffff9ba7c7edc000
Nov 26 23:22:38 heisenberg kernel: FS:  00007ff9744fc8c0(0000) GS:ffff9ba93db00000(0000) knlGS:0000000000000000
Nov 26 23:22:38 heisenberg kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Nov 26 23:22:38 heisenberg kernel: CR2: 00007ff9744fae38 CR3: 00000005b9106005 CR4: 00000000003606e0
Nov 26 23:22:38 heisenberg kernel: DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
Nov 26 23:22:38 heisenberg kernel: DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Nov 26 23:22:38 heisenberg kernel: Call Trace:
Nov 26 23:22:38 heisenberg kernel:  ? __switch_to_asm+0x40/0x70
Nov 26 23:22:38 heisenberg kernel:  ? __switch_to_asm+0x34/0x70
Nov 26 23:22:38 heisenberg kernel:  ? __switch_to_asm+0x40/0x70
Nov 26 23:22:38 heisenberg kernel:  ? __switch_to_asm+0x34/0x70
Nov 26 23:22:38 heisenberg kernel:  ? syscall_return_via_sysret+0x10/0x7f
Nov 26 23:22:38 heisenberg kernel:  ? __switch_to_asm+0x34/0x70
Nov 26 23:22:38 heisenberg kernel:  ? __switch_to_asm+0x40/0x70
Nov 26 23:22:38 heisenberg kernel:  ? __switch_to_asm+0x34/0x70
Nov 26 23:22:38 heisenberg kernel:  ? __switch_to_asm+0x40/0x70
Nov 26 23:22:38 heisenberg kernel:  ? __switch_to_asm+0x34/0x70
Nov 26 23:22:38 heisenberg kernel:  ? __switch_to_asm+0x40/0x70
Nov 26 23:22:38 heisenberg kernel:  ? __switch_to_asm+0x34/0x70
Nov 26 23:22:38 heisenberg kernel:  ? __switch_to_asm+0x40/0x70
Nov 26 23:22:38 heisenberg kernel:  ? __switch_to_asm+0x34/0x70
Nov 26 23:22:38 heisenberg kernel:  ? _cond_resched+0x15/0x30
Nov 26 23:22:38 heisenberg kernel:  ? __kmalloc_track_caller+0x160/0x200
Nov 26 23:22:38 heisenberg kernel:  ? _btrfs_ioctl_send+0xf6/0x110 [btrfs]
Nov 26 23:22:38 heisenberg kernel:  ? __check_object_size+0x162/0x173
Nov 26 23:22:38 heisenberg kernel:  _btrfs_ioctl_send+0xdd/0x110 [btrfs]
Nov 26 23:22:38 heisenberg kernel:  ? task_rq_lock+0x49/0xb0
Nov 26 23:22:38 heisenberg kernel:  ? tomoyo_init_request_info+0x84/0x90
Nov 26 23:22:38 heisenberg kernel:  btrfs_ioctl+0xd47/0x2dc0 [btrfs]
Nov 26 23:22:38 heisenberg kernel:  ? do_vfs_ioctl+0xa4/0x630
Nov 26 23:22:38 heisenberg kernel:  do_vfs_ioctl+0xa4/0x630
Nov 26 23:22:38 heisenberg kernel:  ksys_ioctl+0x60/0x90
Nov 26 23:22:38 heisenberg kernel:  __x64_sys_ioctl+0x16/0x20
Nov 26 23:22:38 heisenberg kernel:  do_syscall_64+0x53/0x130
Nov 26 23:22:38 heisenberg kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xa9
Nov 26 23:22:38 heisenberg kernel: RIP: 0033:0x7ff9745f05b7
Nov 26 23:22:38 heisenberg kernel: Code: 00 00 90 48 8b 05 d9 78 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d a9 78 0c 00 f7 d8 64 89 01 48
Nov 26 23:22:38 heisenberg kernel: RSP: 002b:00007ffc5a31b168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
Nov 26 23:22:38 heisenberg kernel: RAX: ffffffffffffffda RBX: 0000000000003765 RCX: 00007ff9745f05b7
Nov 26 23:22:38 heisenberg kernel: RDX: 00007ffc5a31b230 RSI: 0000000040489426 RDI: 0000000000000004
Nov 26 23:22:38 heisenberg kernel: RBP: 0000000000000004 R08: 0000000000000000 R09: 00007ff9744fb700
Nov 26 23:22:38 heisenberg kernel: R10: 00007ff9744fb9d0 R11: 0000000000000246 R12: 0000000000000001
Nov 26 23:22:38 heisenberg kernel: R13: 0000000000000001 R14: 0000000000000000 R15: 0000557b6f392270
Nov 26 23:22:38 heisenberg kernel: ---[ end trace 9482d6e062565866 ]---


Any chance to get that ever fixed? Any further data or so that would
help?


Thanks,
Chris.


[0] https://bugzilla.kernel.org/show_bug.cgi?id=200255

