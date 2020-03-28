Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24D9619699F
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Mar 2020 22:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbgC1VwO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 28 Mar 2020 17:52:14 -0400
Received: from mx.h4ck.space ([159.69.146.50]:60492 "EHLO mx.h4ck.space"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727484AbgC1VwO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 28 Mar 2020 17:52:14 -0400
X-Greylist: delayed 545 seconds by postgrey-1.27 at vger.kernel.org; Sat, 28 Mar 2020 17:52:12 EDT
Date:   Sat, 28 Mar 2020 22:43:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=linux-btrfs.l.notmuch.email; s=mail; t=1585431786;
        bh=RMemDrsoGa87VPAR5AE+YHHSDer8XJOaaadPIT1Sjr8=;
        h=Date:From:To:Subject;
        b=KJ5THzGu2GTP9MNEP++q/0Er77sddPfm+fy3YOzAkxROwVMiFsT374eI+cQEVFnWX
         PozQSUnjsMBlgkMkuVrusQbZVZoxIT07EByYPzTIcJZ2ceqNiyZjLUL9fgceUuSvfY
         l09h0USxqpxN8qLSbeHBDc4V0LY4WxEHNyQdaA3o=
From:   Andreas Rammhold <andi@linux-btrfs.l.notmuch.email>
To:     linux-btrfs@vger.kernel.org
Subject: nullptr deref bug in btrfs compress_file_range
Message-ID: <20200328214306.ujfchjfokdes6iwv@wrt>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

I every few weeks or so I am seeing the below kernel bug trace. The root
fielsystem starts to block on all IO operations afterwards. This is
currently on 5.4.24. I am not aware of any special load that might be
triggering this issue.

The root filesystem is a RAID1 across two dm-crypt volumes. Once upon a
time I had compression enabled on the filesystem but disabled that some
(>6) months ago. The error occured long before that and I thought by
disabling compression and did run defrag after disabling it. That
doesn't seem to have changed anything.

I also had this bug happen back on 4.19.75 (and potentially older; don't
have all the logs anymore).


Is this known or even fixed on some newer kernel? What else can I
provide to solve this? I am happy to test patches, different kernel
versions, =E2=80=A6.

Regards,

andi

> BUG: kernel NULL pointer dereference, address: 0000000000000000
> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> PGD 1f5976067 P4D 1f5976067 PUD 1b1a95067 PMD 0=20
> Oops: 0000 [#1] SMP NOPTI
> CPU: 5 PID: 12681 Comm: kworker/u24:12 Tainted: P           O      5.4.24=
 #1-NixOS
> Hardware name: Supermicro Super Server/A2SDi-12C-HLN4F, BIOS 1.1b 12/17/2=
018
> Workqueue: btrfs-delalloc btrfs_work_helper [btrfs]
> RIP: 0010:compress_file_range+0x6f4/0x7a0 [btrfs]
> Code: 00 00 31 db 41 83 e1 20 41 83 c9 0f e8 05 ac 01 00 31 c0 48 83 7c 2=
4 40 00 75 0f eb 33 83 c3 01 48 63 c3 48 3b 44 24 40 73 26 <49> 8b 3c c6 48=
 83 7f 18 00 75 2b 48 8b 47 08 48 8d 50 ff a8 01 48
> RSP: 0018:ffffb8c307267da0 EFLAGS: 00010202
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffe91c95f29ac7
> RDX: 0000000000000000 RSI: 000000000000001e RDI: ffffe91ca155bd00
> RBP: 0000000000000410 R08: ffff9fdfbfffc002 R09: ffff9fdfbfffc000
> R10: 000000000002e520 R11: ffffffffffffffb8 R12: 0000000000001000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffff9fdf9f940000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000000 CR3: 0000000152a42000 CR4: 00000000003406e0
> Call Trace:
>  ? submit_compressed_extents+0x440/0x440 [btrfs]
>  async_cow_start+0x12/0x30 [btrfs]
>  btrfs_work_helper+0xbe/0x370 [btrfs]
>  process_one_work+0x206/0x3c0
>  worker_thread+0x2d/0x3e0
>  ? process_one_work+0x3c0/0x3c0
>  kthread+0x112/0x130
>  ? kthread_park+0x80/0x80
>  ret_from_fork+0x35/0x40
> Modules linked in: tcp_diag inet_diag sctp ccm algif_aead cmac algif_hash=
 bluetooth ecdh_generic ecc crc16 af_packet cfg80211 msr rfkill 8021q xt_co=
mment iptable_nat nf_nat xt_conntrack nf_conntrack nf_defrag_ipv4 ip6t_rpfi=
lter ipt_rpfilter ip6table_raw iptable_raw xt_pkttype nf_log_ipv6 nf_log_ip=
v4 nf_log_common xt_LOG xt_tcpudp ip6table_filter sch_fq_codel ip6_tables i=
ptable_filter atkbd libps2 serio loop cpufreq_ondemand pnd2_edac edac_core =
intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal intel_powerclamp ipmi=
_ssif ast drm_vram_helper ttm drm_kms_helper nls_iso8859_1 coretemp nls_cp4=
37 vfat drm fat deflate ixgbe efi_pstore crct10dif_pclmul mousedev ftdi_sio=
 crc32_pclmul evdev pstore zfs(PO) usbserial ghash_clmulni_intel wdat_wdt x=
frm_algo intel_cstate mac_hid agpgart cmdlinepart libphy intel_spi_pci inte=
l_spi intel_rapl_perf ptp spi_nor pps_core efivars i2c_algo_bit mdio watchd=
og mtd i2c_i801 fb_sys_fops dca syscopyarea ipmi_si sysfillrect i2c_ismt sy=
simgblt i2c_core
>  ipmi_devintf ipmi_msghandler zunicode(PO) zavl(PO) hed icp(PO) acpi_cpuf=
req button zlua(PO) zcommon(PO) znvpair(PO) spl(O) tun tap macvlan bridge s=
tp llc kvm_intel kvm irqbypass efivarfs ip_tables x_tables ipv6 nf_defrag_i=
pv6 crc_ccitt autofs4 dm_crypt algif_skcipher af_alg input_leds led_class h=
id_generic usbhid hid sd_mod xhci_pci xhci_hcd ahci libahci libata usbcore =
aesni_intel scsi_mod nvme crypto_simd cryptd glue_helper nvme_core usb_comm=
on rtc_cmos dm_mod btrfs libcrc32c crc32c_generic crc32c_intel xor zstd_dec=
ompress zstd_compress raid6_pq
> CR2: 0000000000000000
> ---[ end trace f3d14d793f393d09 ]---
> RIP: 0010:compress_file_range+0x6f4/0x7a0 [btrfs]
> Code: 00 00 31 db 41 83 e1 20 41 83 c9 0f e8 05 ac 01 00 31 c0 48 83 7c 2=
4 40 00 75 0f eb 33 83 c3 01 48 63 c3 48 3b 44 24 40 73 26 <49> 8b 3c c6 48=
 83 7f 18 00 75 2b 48 8b 47 08 48 8d 50 ff a8 01 48
> RSP: 0018:ffffb8c307267da0 EFLAGS: 00010202
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffe91c95f29ac7
> RDX: 0000000000000000 RSI: 000000000000001e RDI: ffffe91ca155bd00
> RBP: 0000000000000410 R08: ffff9fdfbfffc002 R09: ffff9fdfbfffc000
> R10: 000000000002e520 R11: ffffffffffffffb8 R12: 0000000000001000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffff9fdf9f940000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000000 CR3: 0000000152a42000 CR4: 00000000003406e0
