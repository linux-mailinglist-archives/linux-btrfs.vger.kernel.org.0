Return-Path: <linux-btrfs+bounces-7074-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A316594D8CB
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Aug 2024 00:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AE381F22712
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Aug 2024 22:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5AB16B3B4;
	Fri,  9 Aug 2024 22:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXLp84HR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D82C2232A
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Aug 2024 22:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723243547; cv=none; b=o6Ntt2oWGGsVYnGdoKK/wJhwzn6OQ+9Ey7II4ikTZoWqHdmy+zaW5t4bW3wpVuM34zmaMBz2wJcNgP5B6HfF33FjNqFjCAfyulPXIrIrr9nPnDu7AkrnUnRLWthLzLKAWRTx5xpOtsKl6ftiEoM164YRKiovoamsFqdlAawAzDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723243547; c=relaxed/simple;
	bh=wK54eJIWqazhX4Zw1ihr15CCyKt5osoYfLLgJ0yuBhs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=bALxFhGGXbAxXJpPgKyleEeBuvNYE6vueCXy1TU2U6BJjErkW0Bh1qybtkyifkcKWYZ/6Tu1y67gSZAUUAvVH60og70AVrNbu17Rr8xC8f1jBXYMP6HmbO5xQrYIEvxeAYdqJ71nX0JOC+pQo9qKPJ0iJZTEe2lI5oX94y5Ffpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DXLp84HR; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4ef2006dcdbso939998e0c.3
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Aug 2024 15:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723243544; x=1723848344; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0SGu7rNWw1yccOszm/5t/xC7aHPHs2sDPoMQdLd2AyI=;
        b=DXLp84HRbTo894ItwXBJpX1WVWDCdh5h6bnUsts43jYer+0V6UG/I0TZwNWNwGI+Eg
         UpyYdAO/OHfN7GcTv7WRBQxiTZIz5zxahqaF+NGT+rstWFn8Z35B7eIbq6A2tykim4Yn
         s0E2NwDpFy6vUdZjo0NPRSAKVtiGuCQa4pmUHvCVxHPlZPMXEacJK9bi62weupl97QZY
         P41VeA20zw3YlZbnUixomw5m5/fNIDiug7qlOK642XkDvq248pRSLLKY+24qNUobSm36
         qxHhzz9ydTOvnEszulwJ+zw7VANBZ2xbkDuADvoq6XY5lmi8PMo/gzyO5b7P8v9mJWE4
         1ksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723243544; x=1723848344;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0SGu7rNWw1yccOszm/5t/xC7aHPHs2sDPoMQdLd2AyI=;
        b=nuoAecGWi19dTgyDN3PrBa5KH3wsjsutwFXgVE+MhDFikTYr3flD8HWh04i5ItdXCR
         nqz/Hkr+86sWQgmGcFJkQfjhrPWD+7/d6xLV/8tEyyFi/58V8In6piMhWM2cRc4CBbJ/
         /vzZBYHlGOCnBIduT4QTnZPL2pTQ95+jtPFhVsBwDU+gHwfIiGPdIrkcRdcP9W5Q4vDa
         ahl8QmfwBcpOQoVJL+EZXCtNDTakXW8LvfI6ezvkzXp8ojCF/oFMV3i8X8qKQYLL8z0H
         i4uZQvlwt298e/zCGvY+gzeKCguz0zgYme5XZXvktdqT89rC1wwtOHNWix1FmzR/6e02
         K4hw==
X-Gm-Message-State: AOJu0Yx5nMCR5J2bdrOF3Zfjcj5exsZxJOX/lcjIStEHJMCctY4vjYRD
	28TSnEiPnTgcvlPPXAo4DHAbbyEDAv9SUcKRjqKITpMMH500IjDJNEzYupaBesqJAoi4bLfvH41
	L9dGxrajw89T3InNJM5bUpAkEKWen+j0y
X-Google-Smtp-Source: AGHT+IH6qliCTUoH8w8gBfJ+STHZC1rggIa4cyv1oLrBefM9dI1A33z+bzhJJLWNMzarscxovtPuUgaJioIV0N8RaeY=
X-Received: by 2002:a05:6122:c94:b0:4f6:a697:d380 with SMTP id
 71dfb90a1353d-4f912e8de50mr3490314e0c.10.1723243544146; Fri, 09 Aug 2024
 15:45:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Octavia Togami <octavia.togami@gmail.com>
Date: Fri, 9 Aug 2024 15:45:33 -0700
Message-ID: <CAHPNGSSt-a4ZZWrtJdVyYnJFscFjP9S7rMcvEMaNSpR556DdLA@mail.gmail.com>
Subject: [REGRESSION] bisected: btrfs: spin locks way too much when accessing
 many files concurrently
To: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

[1.] One line summary of the problem: BTRFS spin locks way too much
when accessing many files concurrently
[2.] Full description of the problem/report:

Accessing many files concurrently at once causes BTRFS to spin lock
too much and basically lock up all other processes for seconds at a
time.

Mostly happens when accessing their content, not the other metadata.

This appears to be a performance regression since v6.9. I bisected to
this commit: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=956a17d9d050761e34ae6f2624e9c1ce456de204

The commit before this one has no issues, this one reliably reproduces
the issue for me.

[3.] Keywords (i.e., modules, networking, kernel): btrfs, spin_lock,
super_cache_scan
[4.] Kernel information
[4.1.] Kernel version (from /proc/version): Linux version
6.10.3-arch1-1 (linux@archlinux) (gcc (GCC) 14.2.1 20240802, GNU ld
(GNU Binutils) 2.42.0) #1 SMP PREEMPT_DYNAMIC Sun, 04 Aug 2024
05:11:32 +0000
[4.2.] Kernel .config file:
https://gist.github.com/octylFractal/1344722b55f0a9eef4fc22fcfcc34177
[5.] Most recent kernel version which did not have the bug: v6.9
[6.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/admin-guide/bug-hunting.rst): N/A
[7.] A small shell script or example program which triggers the
     problem (if possible): Not possible as it appears to need a
specific set of data and/or an NVMe-speed drive (1-2GB/s). I was using
`rg --no-ignore uncommon-phrase ~/Documents/` but it didn't appear to
work in QEMU or on a different drive, only when using my NVMe SSD. I
have 1,425,292 files comprising 424GB in my `~/Documents`.
[8.] Environment
[8.1.] Software (add the output of the ver_linux script here)
Linux Draconnet 6.10.1-arch1-1 #1 SMP PREEMPT_DYNAMIC Wed, 24 Jul 2024
22:25:43 +0000 x86_64 GNU/Linux

GNU C                   14.1.1
GNU Make                4.4.1
Binutils                2.42.0
Util-linux              2.40.2
Mount                   2.40.2
Module-init-tools       32
E2fsprogs               1.47.1
Jfsutils                1.1.15
Reiserfsprogs           3.6.27
Xfsprogs                6.9.0
PPP                     2.5.0
Bison                   3.8.2
Flex                    2.6.4
Linux C++ Library       6.0.33
Linux C++ Library       5.0.7
Dynamic linker (ldd)    2.40
Procps                  4.0.4
Net-tools               2.10
Kbd                     2.6.4
Console-tools           2.6.4
Sh-utils                9.5
Udev                    256
Wireless-tools          30
Modules Loaded          aesni_intel af_alg algif_hash algif_skcipher
amd_atl amdgpu amdxcp asus_wmi blake2b_generic bluetooth bnep bridge
btbcm btintel btmtk btrfs btrtl b
tusb ccp cec cmac crc16 crc32c_generic crc32c_intel crc32_pclmul
crct10dif_pclmul cryptd crypto_simd crypto_user dm_mod drm_buddy
drm_display_helper drm_exec drm_suballoc_
helper drm_ttm_helper eeepc_wmi enclosure ext4 fat gf128mul
ghash_clmulni_intel gpio_amdpt gpio_generic gpu_sched hid_generic
hwmon_vid i2c_algo_bit i2c_dev i2c_piix4 i804
2 intel_rapl_common intel_rapl_msr ip_tables jbd2 jfs joydev kvm
kvm_amd ledtrig_timer libcrc32c libphy llc loop mac_hid mbcache mc
mdio_devres mousedev nct6775 nct6775_co
re nf_conntrack nf_defrag_ipv4 nf_defrag_ipv6 nf_nat nfnetlink
nf_reject_ipv4 nf_tables nft_chain_nat nft_compat nft_ct nft_masq
nft_reject nft_reject_ipv4 nilfs2 nls_iso8
859_1 nls_ucs2_utils nvidia nvidia_drm nvidia_modeset nvidia_uvm nvme
nvme_auth nvme_core pkcs8_key_parser platform_profile polyval_clmulni
polyval_generic r8169 raid6_pq
rapl realtek rfcomm rfkill scsi_transport_sas serio ses sg sha1_ssse3
sha256_ssse3 sha512_ssse3 snd snd_hda_codec snd_hda_codec_generic
snd_hda_codec_hdmi snd_hda_codec_re
altek snd_hda_core snd_hda_intel snd_hda_scodec_component snd_hrtimer
snd_hwdep snd_intel_dspcfg snd_intel_sdw_acpi snd_pcm snd_seq
snd_seq_device snd_seq_dummy snd_timer
soundcore sp5100_tco sparse_keymap stp ttm tun uas uinput usbhid usblp
usb_storage uvc uvcvideo vfat video videobuf2_common videobuf2_memops
videobuf2_v4l2 videobuf2_vmall
oc videodev wacom wmi wmi_bmof xfs xhci_pci xhci_pci_renesas xor
x_tables xt_conntrack xt_mark xt_MASQUERADE xt_tcpudp zenpower

[8.2.] Processor information (from /proc/cpuinfo):
https://gist.github.com/octylFractal/1dcb65816561aab9205fce590ec85e59
[8.3.] Module information (from /proc/modules):
https://gist.github.com/octylFractal/9c78960190b12e3634ae87e895858cb2
[8.4.] Loaded driver and hardware information (/proc/ioports,
/proc/iomem): https://gist.github.com/octylFractal/40a9f67dbaabac78cd2d03028dd994f7
[8.5.] PCI information ('lspci -vvv' as root):
https://gist.github.com/octylFractal/325a0f211094ff11643c16f1d1f63362
[8.6.] SCSI information (from /proc/scsi/scsi):
Attached devices:
Host: scsi4 Channel: 00 Id: 00 Lun: 00
 Vendor: ATA      Model: CT4000MX500SSD1  Rev: 045
 Type:   Direct-Access                    ANSI  SCSI revision: 05
[8.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant): The NVMe SSD I'm using is a WDS100T3X0C-00SJG0.

#regzbot introduced: 956a17d9d050761e34ae6f2624e9c1ce456de204

