Return-Path: <linux-btrfs+bounces-12122-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D92A58AB6
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Mar 2025 03:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF8973AD0A9
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Mar 2025 02:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7221A9B34;
	Mon, 10 Mar 2025 02:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mK2/l9nJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2904B153BF0
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Mar 2025 02:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741574960; cv=none; b=ePePvMzU+PzTxjJ0EDW7lKMaYRiQDcM+/sXGd6LzsqeBOkcvs3OLGdggnaoiaOqZOZ+K8KwGcMHCZJa/MJhOWZW9RIkTGKSTsYVgvqzS3YFQPlW1+igJVF5G8WH1vkZNyRVlTQ5tP8bQ2r1k2/zRNqByi2pKBe87LS+tUzT7QFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741574960; c=relaxed/simple;
	bh=fXZcAUGisPi9Kg9O0i+nxT/zIgbTwBm7X94aOTLN7jo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=UTs4B/x7oUuVjoSQkyPnxpJ/UH7HbCu6tFijl/bE2rYbYw+0iunphA3ln9PhLCdFkIA+QmPaQTT6W3gyjc5uD8NRlJNIBq3YXaVqpZchHKZa0ti+2hpB8HuBEW+WRILjqPkF5f/M4z7cAVYX8MSQB5SQ2hN92Xwtfnv34rTpq3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mK2/l9nJ; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3914bc3e01aso104864f8f.2
        for <linux-btrfs@vger.kernel.org>; Sun, 09 Mar 2025 19:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741574956; x=1742179756; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4HSpGGinzE7Gg32JKh9n7lOHc4ePlv6AKU1sKnBQOXY=;
        b=mK2/l9nJbF7gM5bsyfaiLZKYdN2t5aZk0qfUZ+SSpiXOhvzm7HmNFrqfTQy7fSDztS
         Ge7+Hro0Wel4HDWs1pvbZ7+SRzheIhLU+YPKh+gTI/HSbzn4snv6eSzuV1fkfrKj6qVc
         8VpAx1L97fjdxNIVFykw+g3FWqsKUIP/np5rXsp+ff0/6m1G7niIeKyprB26pQfLjL+d
         wdufrF8tIwC3mrgYYD/IvPEpSP3W/AhFcv7gJbfj61fsX6569ILQnUlDmmc7Z57QexbR
         HQLoklVojRxmz3+1+kJcrW52dB85N0Ff4pmklQwNG66Op5Lb7Mi3YT1gZUU1iQIuyIUN
         31Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741574956; x=1742179756;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4HSpGGinzE7Gg32JKh9n7lOHc4ePlv6AKU1sKnBQOXY=;
        b=nAdmxyQhoH2fadEP1J9LKWMa8pUkU7dy7sunchEhtHsG7tdXK2LvRYPDutWAoNi1bL
         tygbArlFZ1h8lomJZ4Mx/jfvMpYdwiRoD1msGjU/L77kobLJUC7RybcA/5Nzb9PRxg6z
         sp5lBmxgggGmKpIpYXfYcJkIWOnTX5BK46gvGDt3F2v49upBnSQZtKYAjcyvpWK0XGoI
         WoWM4zkGB8gE+idNEf9UymK2oegca8QKlIAVLiOVqAZ72EsMYWjXeViJIJHe2b1JzFd1
         p5iGTNNh9EmfXZ2yZAxDg3n5Ki52g3UpwWp0pJSTN4/L7a1TDgafxzvif2nL5WBn0Wlp
         gkBw==
X-Gm-Message-State: AOJu0YyFxHCWp8a5jlT3c/HWQe4VX36y4izBhQm7xUrmReUiS6OKz71Q
	uPKXay5GmfNRrlkAGsh9hbogQHQ7PGohVpr7lCHEebYgZqFAenXw0YVmymrLOpiNMDS3f8Oz7AP
	WAI4XC+fAkWEwrjSEkoI/NziaPxfKPL1ne9E=
X-Gm-Gg: ASbGnculS8gHRIDLpfBOGbHvnEoRk2cBXIttU9sQQZnsAkb2asI/0ruIRPheY+SNUl9
	Bahc1Ee7MhQxHciYSfPUkxdgB01RJrRG/YR/VPDwrzgiLFoSK+pH1nLisunKnVKjTQ3ILTUVfi7
	0xfbppVYS6ZSg5HmQO4/qwdg==
X-Google-Smtp-Source: AGHT+IHvv3hdUaR1kNRqQ3lNmWqdYQvOaMW146TxqJV2eTdAr4epDENuVMiJDA4pdBkOeU/esZs6yyctFVuxOPNmXUc=
X-Received: by 2002:a05:6000:4718:b0:390:e8d4:6517 with SMTP id
 ffacd0b85a97d-39132d29464mr9021528f8f.21.1741574955922; Sun, 09 Mar 2025
 19:49:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?6KW/5pyo6YeO576w5Z+6?= <yanqiyu01@gmail.com>
Date: Mon, 10 Mar 2025 10:49:04 +0800
X-Gm-Features: AQ5f1Jr1YodDMD-g9MOX7WAcYMfrcnwtYPt43n8RUu3LgZA6TnLQsG6dxRutsEw
Message-ID: <CAB_b4sBhDe3tscz=duVyhc9hNE+gu=B8CrgLO152uMyanR8BEA@mail.gmail.com>
Subject: [bug report] NULL pointer dereference after a balance error on zoned device
To: linux-btrfs@vger.kernel.org
Cc: naohiro.aota@wdc.com, wqu@suse.com, Johannes.Thumshirn@wdc.com
Content-Type: text/plain; charset="UTF-8"

Hi all,

I encountered a NULL pointer dereference while attempting to balance a
Btrfs volume using the following command:

    sudo btrfs balance start -mconvert=raid1 /media/cold

BTRFS error (device sdc): zoned: write pointer offset mismatch of
zones in raid1 profile
BUG: kernel NULL pointer dereference, address: 0000000000000058
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0
Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
CPU: 20 UID: 0 PID: 73595 Comm: btrfs Kdump: loaded Tainted: G OE
6.13.5-200.fc41.x86_64 #1
Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./EPYCD8,
BIOS L2.52 11/25/2020
RIP: 0010:__btrfs_add_free_space_zoned.isra.0+0x61/0x1a0
Code: 74 24 08 48 89 04 24 e8 bd a9 a8 00 48 39 6b 20 48 8b 74 24 08
0f 84 ff 00 00 00 48 8d 14 2e 48 39 93 18 02 00 00 73 02 0f 0b <45> 8b
64 24 58 49 89 ef 45 84 f6 0f 85 b8 00 00 00 4c 89 ef e8 86
RSP: 0018:ffffa236b6f3f6d0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff96c8132f3400 RCX: 0000000000000001
RDX: 0000000010000000 RSI: 0000000000000000 RDI: ffff96c8132f3410
RBP: 0000000010000000 R08: 0000000000000003 R09: 0000000000000000
R10: 0000000000000000 R11: 00000000ffffffff R12: 0000000000000000
R13: ffff96c758f65a40 R14: 0000000000000001 R15: 000011aac0000000
FS: 00007fdab1cb2900(0000) GS:ffff96e60ca00000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000058 CR3: 00000001a05ae000 CR4: 0000000000350ef0
Call Trace:
<TASK>
? __die_body.cold+0x19/0x27
? page_fault_oops+0x15c/0x2f0
? exc_page_fault+0x7e/0x180
? asm_exc_page_fault+0x26/0x30
? __btrfs_add_free_space_zoned.isra.0+0x61/0x1a0
btrfs_add_free_space_async_trimmed+0x34/0x40
btrfs_add_new_free_space+0x107/0x120
btrfs_make_block_group+0x104/0x2b0
btrfs_create_chunk+0x977/0xf20
btrfs_chunk_alloc+0x174/0x510
? srso_return_thunk+0x5/0x5f
btrfs_inc_block_group_ro+0x1b1/0x230
btrfs_relocate_block_group+0x9e/0x410
btrfs_relocate_chunk+0x3f/0x130
btrfs_balance+0x8ac/0x12b0
? srso_return_thunk+0x5/0x5f
? srso_return_thunk+0x5/0x5f
? __kmalloc_cache_noprof+0x14c/0x3e0
btrfs_ioctl+0x2686/0x2a80
? srso_return_thunk+0x5/0x5f
? ioctl_has_perm.constprop.0.isra.0+0xd2/0x120
__x64_sys_ioctl+0x97/0xc0
do_syscall_64+0x82/0x160
? srso_return_thunk+0x5/0x5f
? __memcg_slab_free_hook+0x11a/0x170
? srso_return_thunk+0x5/0x5f
? kmem_cache_free+0x3f0/0x450
? srso_return_thunk+0x5/0x5f
? srso_return_thunk+0x5/0x5f
? syscall_exit_to_user_mode+0x10/0x210
? srso_return_thunk+0x5/0x5f
? do_syscall_64+0x8e/0x160
? sysfs_emit+0xaf/0xc0
? srso_return_thunk+0x5/0x5f
? srso_return_thunk+0x5/0x5f
? seq_read_iter+0x207/0x460
? srso_return_thunk+0x5/0x5f
? vfs_read+0x29c/0x370
? srso_return_thunk+0x5/0x5f
? srso_return_thunk+0x5/0x5f
? syscall_exit_to_user_mode+0x10/0x210
? srso_return_thunk+0x5/0x5f
? do_syscall_64+0x8e/0x160
? srso_return_thunk+0x5/0x5f
? exc_page_fault+0x7e/0x180
entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7fdab1e0ca6d
Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10 c7 45 b0 10 00
00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 0f 05 <89> c2
3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00
RSP: 002b:00007ffeb2b60c80 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fdab1e0ca6d
RDX: 00007ffeb2b60d80 RSI: 00000000c4009420 RDI: 0000000000000003
RBP: 00007ffeb2b60cd0 R08: 0000000000000000 R09: 0000000000000013
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffeb2b6343b R14: 00007ffeb2b60d80 R15: 0000000000000001
</TASK>
Modules linked in: xsk_diag macvlan nft_nat nft_fib_inet nft_fib_ipv4
nft_fib_ipv6 nft_fib rpcrdma rdma_cm iw_cm ib_cm ib_core
nft_flow_offload nf_flow_table_inet nf_flow_table cfg80211 veth bridge
stp llc wireguard curve25519_x86_64 libcurve25519_generic
ip6_udp_tunnel udp_tunnel nf_conntrack_netbios_ns
nf_conntrack_broadcast nft_masq nft_reject_inet nf_reject_ipv4
nf_reject_ipv6 nft_reject nft_chain_nat nf_nat rfkill ip_set
nft_socket nf_socket_ipv4 nf_socket_ipv6 nft_ct nf_conntrack
nf_defrag_ipv6 nf_defrag_ipv4 nf_tables nct6775 nct6775_core hwmon_vid
binfmt_misc amd_atl intel_rapl_msr intel_rapl_common amd64_edac vfat
edac_mce_amd fat snd_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg
snd_intel_sdw_acpi ucsi_ccg kvm_amd snd_hda_codec typec_ucsi ipmi_ssif
typec kvm snd_hda_core xfs snd_hwdep snd_seq rapl snd_seq_device
pcspkr acpi_cpufreq snd_pcm i2c_nvidia_gpu snd_timer acpi_ipmi snd
ipmi_si i2c_piix4 soundcore ptdma ipmi_devintf k10temp i2c_smbus
ipmi_msghandler nvidia_drm(OE) nvidia_modeset(OE)
nvidia_uvm(OE) tcp_bbr nvidia(OE) nfsd drm_ttm_helper auth_rpcgss
drivetemp ttm nfs_acl tun video lockd wmi loop grace nfs_localio
dm_multipath sunrpc nfnetlink zram lz4hc_compress lz4_compress
crct10dif_pclmul crc32_pclmul crc32c_intel nvme_tcp polyval_clmulni
polyval_generic ghash_clmulni_intel nvme_fabrics sha512_ssse3
nvme_keyring sha256_ssse3 ixgbe sha1_ssse3 ast nvme igb nvme_core dca
i2c_algo_bit sp5100_tco nvme_auth be2iscsi bnx2i cnic uio cxgb4i cxgb4
tls cxgb3i cxgb3 mdio libcxgbi libcxgb qla4xxx iscsi_boot_sysfs
iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi scsi_dh_rdac
scsi_dh_emc scsi_dh_alua fuse
CR2: 0000000000000058
---[ end trace 0000000000000000 ]---
RIP: 0010:__btrfs_add_free_space_zoned.isra.0+0x61/0x1a0
Code: 74 24 08 48 89 04 24 e8 bd a9 a8 00 48 39 6b 20 48 8b 74 24 08
0f 84 ff 00 00 00 48 8d 14 2e 48 39 93 18 02 00 00 73 02 0f 0b <45> 8b
64 24 58 49 89 ef 45 84 f6 0f 85 b8 00 00 00 4c 89 ef e8 86
RSP: 0018:ffffa236b6f3f6d0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff96c8132f3400 RCX: 0000000000000001
RDX: 0000000010000000 RSI: 0000000000000000 RDI: ffff96c8132f3410
RBP: 0000000010000000 R08: 0000000000000003 R09: 0000000000000000
R10: 0000000000000000 R11: 00000000ffffffff R12: 0000000000000000
R13: ffff96c758f65a40 R14: 0000000000000001 R15: 000011aac0000000
FS: 00007fdab1cb2900(0000) GS:ffff96e60ca00000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000058 CR3: 00000001a05ae000 CR4: 0000000000350ef0
note: btrfs[73595] exited with irqs disabled
note: btrfs[73595] exited with preempt_count 1
------------[ cut here ]------------

This occurred on a volume with two HC650 drives. After the error
appeared, I attempted to unmount the volume, which triggered another
warning and left the umount command in a D state. A forced reboot
resulted in the same balance error and NULL pointer dereference
immediately upon the automatic resumption of the balance operation.

To restore the volume to a functional state, I used skip_balance to
cancel the balance operation and reverted the metadata profile back to
DUP. However, the NULL pointer dereference suggests a potential bug in
Btrfs/Zoned.

The full dmesg logs for the 2 boots are available here:
https://gist.github.com/karuboniru/3c9c12b06c039e77aee3d1a818f7bca0

System details:
Kernel: 6.13.5-200.fc41.x86_64
Out-of-tree modules: nvidia-open (out-of-tree)

Please let me know if any further information is needed to diagnose this issue.

Best,
Qiyu

