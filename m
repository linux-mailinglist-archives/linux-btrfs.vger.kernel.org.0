Return-Path: <linux-btrfs+bounces-13168-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F87A9409B
	for <lists+linux-btrfs@lfdr.de>; Sat, 19 Apr 2025 02:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94DC9189C3EC
	for <lists+linux-btrfs@lfdr.de>; Sat, 19 Apr 2025 00:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D1B182D7;
	Sat, 19 Apr 2025 00:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="TTa2jJOi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD061EEE9
	for <linux-btrfs@vger.kernel.org>; Sat, 19 Apr 2025 00:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745022709; cv=none; b=mZxe45Tc3mb6Q8x67VfChinbgY/4Ij9JLvUhupDL4ROdjA6jpz9qUfygYygxD4naJdWMmUj66QTKaD2nF5Q1WH4mM2JVMpzELyY1ySwfnDy2jJBjJ+DMXPKXA6mh+rsyF7Nafg9+kr++CLw+g9xeXCb/p7pDWoZMxoElttCaWuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745022709; c=relaxed/simple;
	bh=dc9HPjaSyT6q964+BESXjMqZVe40KZkMUVbMnyEMPyk=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=UgV5f8QbLRxF7Jvx+DAdIMf5W6qd6OzCJitIlIzgiYfgwF68oEvpBlwNSDGiMAleniqZ4Nq+iBQzktzczKgyuqNDCM4b/d7DfoURRBMPlHMtRxhjhhxd2TabV1VSaxygC/N0kPybK8IKrdgjl4YWAl5MUpMd7QYYzKyxRtqO8vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=TTa2jJOi; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1745022701; x=1745627501; i=quwenruo.btrfs@gmx.com;
	bh=Cbw7vlkOeiKxVg20iBgymBx1HfO7Ue124GJtV9HQsdU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=TTa2jJOiVdztRLufpuqk57KrrBtaYDQtTyigguyJ5n76znhzagEa42UYU32LQOZ9
	 wJoPglNDNOODq8LA/n0q+0ZMeT4SwiaxyhZlFLMUsCdNshL/+ZMimCkrWFgnNXiRL
	 qFlcRb5Eyy0+tgHD1+SJ6l3EwuxZlTYoz2HQNoie/khTVoAZL4iSS3KMKFZ/9GjIR
	 utvt8N1oXT60bHdR9nmFq3jxsJ8j9ksTQj1y5wnaM4tvToDqjh3w1Uxkljz9W7NcF
	 S4sQz/PKHM9Z0+gfnyvSxLR12c8TIEucxU00ihWAgDFRH+C8vvph25p/onpAh3CBV
	 dO0Jx5hUrFDOz5aj5g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N4hzZ-1v66uY0XxP-00zQrB; Sat, 19
 Apr 2025 02:31:41 +0200
Message-ID: <392fdddd-918e-4a5d-9067-b6dce7a4eeb2@gmx.com>
Date: Sat, 19 Apr 2025 10:01:38 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linux Memory Management List <linux-mm@kvack.org>,
 linux-btrfs <linux-btrfs@vger.kernel.org>
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: x86 32bit kernel (HIGHMEM + PAE) BUGs
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aaOC24X04qp8UAaDuhhNE75+o2fgWK7CBX2W0hdr+yBzNbXKPu6
 uyhS9aFGRLblyjjsuiUZiBOvthpLuCH1eN7LiytPc9+mq/obZesNN56FXTqmuV+RD4CMgc+
 wIADEE2nZNMN3e8KrzVu3nbaV1u0RsYeQyIqb6QaMcTHkCbWe1EnxP/O21He6DhqtMSjKOX
 By9937Gs+eHBunKSkzcog==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fr3jSmpnm1s=;r7NeoStFopUI5KF7IK2iiDU3315
 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

Hi,

When running btrfs tests with high memory pressure, the 32bit x86 kernel=
=20
with HIGHMEM and PAE (VM with 6GiB memory) trigger a crash with the=20
following crash:

[ 1578.590032] BTRFS info (device dm-4): checking UUID tree
[ 1593.756090] BUG: unable to handle page fault for address: f7c66430
[ 1593.756769] #PF: supervisor read access in kernel mode
[ 1593.757294] #PF: error_code(0x0000) - not-present page
[ 1593.757763] *pdpt =3D 0000000012496001 *pde =3D 000000000112c067 *pte =
=3D=20
0000000000000000
[ 1593.758462] Oops: Oops: 0000 [#1] SMP NOPTI
[ 1593.758845] CPU: 3 UID: 0 PID: 84 Comm: kswapd0 Not tainted=20
6.15.0-rc2-custom+ #8 PREEMPT(full)=20
f507b09d7d211cc6dbc5158483bab51fd03422b1
[ 1593.760665] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),=20
BIOS Arch Linux 1.16.3-1-1 04/01/2014
[ 1593.762052] EIP: scomp_acomp_comp_decomp+0xb9/0x3b0
[ 1593.762653] Code: d7 8b 55 d8 c1 ee 0c 81 e7 ff 0f 00 00 8d 34 b6 8d=20
34 f1 89 d1 81 e2 ff 0f 00 00 8d 54 17 ff c1 e9 0c c1 ea 0c 01 ca 8d 14=20
92 <8b> 14 d6 c1 ea 1e 83 fa 02 0f 84 08 02 00 00 83 fa 03 0f 84 ef 01
[ 1593.764644] EAX: 00000400 EBX: c22c0240 ECX: 00000001 EDX: 00500000
[ 1593.765395] ESI: f5466430 EDI: 00000000 EBP: c18b3990 ESP: c18b395c
[ 1593.766024] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 000102=
16
[ 1593.766696] CR0: 80050033 CR2: f7c66430 CR3: 13705e60 CR4: 000006f0
[ 1593.767271] Call Trace:
[ 1593.767488]  scomp_acomp_compress+0x17/0x50
[ 1593.767860]  acomp_do_req_chain+0xd1/0xf0
[ 1593.768231]  crypto_acomp_compress+0x13/0x20
[ 1593.768639]  zswap_store+0x37b/0x9e0
[ 1593.768988]  swap_writepage+0xf7/0x280
[ 1593.769351]  shmem_writepage+0x35b/0x460
[ 1593.769738]  pageout+0x126/0x260
[ 1593.770050]  shrink_folio_list+0x6a4/0xd40
[ 1593.770439]  ? cgroup_rstat_updated+0xf5/0x1f0
[ 1593.770868]  ? __mod_memcg_lruvec_state+0xaa/0x1e0
[ 1593.771319]  ? __count_memcg_events+0x12d/0x180
[ 1593.771772]  evict_folios+0xd7b/0x1210
[ 1593.772135]  try_to_shrink_lruvec+0x1c0/0x290
[ 1593.772563]  shrink_one+0xec/0x1e0
[ 1593.772888]  shrink_node+0x96d/0xb10
[ 1593.773230]  ? psi_group_change+0x127/0x330
[ 1593.773637]  ? mem_cgroup_exit+0x40/0x60
[ 1593.774020]  balance_pgdat+0x3f0/0x8e0
[ 1593.774326]  ? __switch_to_asm+0x83/0xf0
[ 1593.774688]  ? calibrate_delay+0x410/0x41d
[ 1593.775068]  ? __switch_to_asm+0x41/0xf0
[ 1593.775408]  ? __switch_to_asm+0x3b/0xf0
[ 1593.775799]  ? finish_task_switch.isra.0+0x85/0x2c0
[ 1593.776291]  kswapd+0x199/0x310
[ 1593.776624]  ? prepare_to_wait_exclusive+0xb0/0xb0
[ 1593.777239]  kthread+0x100/0x200
[ 1593.777598]  ? kthreads_online_cpu+0xe0/0xe0
[ 1593.778046]  ? balance_pgdat+0x8e0/0x8e0
[ 1593.778467]  ? kthreads_online_cpu+0xe0/0xe0
[ 1593.778891]  ret_from_fork+0x38/0x60
[ 1593.779241]  ? kthreads_online_cpu+0xe0/0xe0
[ 1593.779652]  ret_from_fork_asm+0x12/0x18
[ 1593.780042]  entry_INT80_32+0xf0/0xf0
[ 1593.780398] Modules linked in: dm_log_writes dm_flakey crc32c_generic=
=20
btrfs blake2b_generic xor raid6_pq snd_hda_codec_generic snd_hda_intel=20
snd_intel_dspcfg snd_hda_codec snd_hwdep snd_hda_core snd_pcm vfat fat=20
snd_timer snd psmouse pcspkr joydev i2c_piix4 soundcore e1000 mousedev=20
i2c_smbus fuse loop nfnetlink qemu_fw_cfg ip_tables x_tables ext4 crc16=20
mbcache jbd2 dm_mod ata_generic serio_raw virtio_blk virtio_balloon=20
pata_acpi atkbd libps2 virtio_console virtio_rng vivaldi_fmap sr_mod=20
i8042 virtio_pci floppy ata_piix cdrom virtio_pci_legacy_dev=20
virtio_pci_modern_dev serio intel_agp intel_gtt usbhid
[ 1593.785273] CR2: 00000000f7c66430
[ 1593.785641] ---[ end trace 0000000000000000 ]---
[ 1593.786139] EIP: scomp_acomp_comp_decomp+0xb9/0x3b0
[ 1593.786617] Code: d7 8b 55 d8 c1 ee 0c 81 e7 ff 0f 00 00 8d 34 b6 8d=20
34 f1 89 d1 81 e2 ff 0f 00 00 8d 54 17 ff c1 e9 0c c1 ea 0c 01 ca 8d 14=20
92 <8b> 14 d6 c1 ea 1e 83 fa 02 0f 84 08 02 00 00 83 fa 03 0f 84 ef 01
[ 1593.788426] EAX: 00000400 EBX: c22c0240 ECX: 00000001 EDX: 00500000
[ 1593.789056] ESI: f5466430 EDI: 00000000 EBP: c18b3990 ESP: c18b395c
[ 1593.789671] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 000102=
16
[ 1593.790319] CR0: 80050033 CR2: f7c66430 CR3: 13705e60 CR4: 000006f0
[ 1593.790922] note: kswapd0[84] exited with irqs disabled

So far I didn't see any btrfs involvement in the call trace, thus I=20
guess it may be something related to MM layer.

Furthermore, to boot the VM with HIGHMEM + PAE, I have applied this patch:

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=3D1=
e07b9fad022e0e02215150ca1e20912e78e8ec1

But that also means I'm not really able to test the HIGHMEM cases.

Thanks,
Qu

