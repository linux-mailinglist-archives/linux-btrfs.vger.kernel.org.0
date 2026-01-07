Return-Path: <linux-btrfs+bounces-20183-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 46837CFB904
	for <lists+linux-btrfs@lfdr.de>; Wed, 07 Jan 2026 02:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 54840300F6AB
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jan 2026 01:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95EBB267729;
	Wed,  7 Jan 2026 01:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RgXp+pbK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yx1-f66.google.com (mail-yx1-f66.google.com [74.125.224.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E856248F6F
	for <linux-btrfs@vger.kernel.org>; Wed,  7 Jan 2026 01:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767748261; cv=none; b=LhCHN16MLyLEso13fsBEZItZikt8l6Ja8y9V0kej5DzhNZznSqrfl7izzt3q8ltAGL9LOwBt+lLnXsH5TRnKU68MOEGq66l0IdQ/nHxKK1OdYhS27zCeWjL15pIjwIli+DPqdWItaTLx6FvKMZEZ+kLVl4VUMwaM4MEuPhXI73k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767748261; c=relaxed/simple;
	bh=n2aNp7uOvKvisx/hglF4owMFjgfN8Z00VOkHKJvtvDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EbqrBdj9jv9BRyLqw5nWe/Xr3uhlCciIVtLYVk5/gIcBzPz9HaLLyVNKOkEWPsIO3JQtNzI1Vw3ZtCbsgz1+lul1dCTJut4rahauXQ0DGaYKWwy0M1DC6WigAYnM3LSgC/h9gZoqhoHHDRSqiWFbVXP2rLkdEl2C84OG4OHNXFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RgXp+pbK; arc=none smtp.client-ip=74.125.224.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f66.google.com with SMTP id 956f58d0204a3-6420c08f886so2164052d50.3
        for <linux-btrfs@vger.kernel.org>; Tue, 06 Jan 2026 17:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767748259; x=1768353059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ffmRrSiHnrHdT9n5g9Vg0KpczzpVvEX6zn8BgzzArQ=;
        b=RgXp+pbKowif01cc8JMZuf7weiB8BAZSoc+O9F1UJVnkpa2OvmDugS5rHBR4yL3uMm
         eq7tLRQH3ce3aOwFQg70DGHn7QLB6ErRWBI3L0PVOSNDjSt7JVstEUPCGXq9GLJ1j9iF
         An4L9u5O0Kh8gl7sJGoBZIkGiTuGq1+Lwei0e2v4KzAhwW22M7XJE+sZzwwjov0V29C4
         2RhJKPGS5blN6+vvyKhR6jJQDG7DVHdJFO+ewJ+p4OQAT3DTDyI6aKCt5ZTv+5K26a02
         LBT06CX/glQvxfT+Of9AFY8N+F2U5JQy7AbYHOH8uGvaW+DCquLTxRXRvNg1iUqjorXx
         VlDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767748259; x=1768353059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6ffmRrSiHnrHdT9n5g9Vg0KpczzpVvEX6zn8BgzzArQ=;
        b=jYgXsqPFajB5tRNV6T1SpY3GxxSz5inRIaVDADtwSNla7JSscyiAxdNdHAhw1bOESg
         5vWYoixn93Le1WF9H9u2S0v9EC5uHKV3bhCfgUo7ncJslgZQeLlWe2cnOoQ7OtkI+OMp
         7aVnNmg1z+uVLZqk9T/NNWm70+ihw452Q7fl4qSezFgCs2ns9s5o2VmWmYwlkwGakZ2B
         xvUCGP46TnOu/3BIAz5W0ZBnUWgTgHT6I/8cmnps/u3dWxxPX7IA0GkuZmELQudxScQl
         NZxLcyLVkvPfC0m4quDyMSt8AfJumgocwvZ8yZb7E+/InGsPtKRGDeKrunKm4j/FQetP
         taZg==
X-Gm-Message-State: AOJu0YzrooPZmh4lqLCocJhMikwki7OHjwqHH/dbz4vKFo3Tw5+NVATm
	0jbyKj1+o8CgD8bqBtEpW3CSfVKqcUST6W+pXq2+U5Xvt9TtA+BJbx2BAQCa8raD
X-Gm-Gg: AY/fxX4h9cVxkasG5c4QqfCjhMX5Qkqf3tCC1+UcmNAhAsAwquFQtcoaEsndVfZp7HH
	0DvNxH6RWCBc1ppE/N/w5Hsiu31UwI51c7v0k4XAbGKFxmjmkdlmpdhLH2P5aoOafEX2FR3cdEp
	YE4QglIlq4fj/GbGhnJPaCtdEvYb6yzMvY8/i+jsQAUWUwwNr05nYom240/2CRuu86FVzSVqWvt
	kqWedQjm2KYijrtIR1y7HNY/QzL7atClkirgCoDAwEDSK4GPWKfoXiR3CkizTi6AnAxk8Eq85QR
	JFV5OGSGV90qUq4TkNvxXvc1QU5q6YFI55WYrc/VtL1L9x97jOp3h5uLHjV30KGuH/6MRKj07Lt
	sQZ6GOKMEoF8/lcCsoEmyP3UvbktQEjDsYIv4vJqxLvRgzulBgi85ooM/cScrrJoiRJ9q/VD/5f
	+gEi93XZmumi2ZBWY7ULEA8KXYF0HG
X-Google-Smtp-Source: AGHT+IFYc2BopkGGlAQTq4lDxV0l7TcQ+Qv1XIiQfTEMOrqk/kCOT8LmBsn4ym/JygKCvCU2GVUirg==
X-Received: by 2002:a05:690e:1241:b0:645:5ac1:8c0 with SMTP id 956f58d0204a3-64716c73f80mr807616d50.65.1767748258785;
        Tue, 06 Jan 2026 17:10:58 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:4e::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6470d80da68sm1500598d50.9.2026.01.06.17.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 17:10:58 -0800 (PST)
From: Leo Martins <loemra.dev@gmail.com>
To: "Gideon Farrell" <gideon@solnickfarrell.co.uk>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: refcount_warn_saturate in __btrfs_release_delayed_node for 6.18.2-arch2-1
Date: Tue,  6 Jan 2026 17:10:20 -0800
Message-ID: <20260107011054.2694891-1-loemra.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <DFHUFTKLUCB5.11QUC5R2L77DO@solnickfarrell.co.uk>
References: 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 06 Jan 2026 22:01:58 +0000 "Gideon Farrell" <gideon@solnickfarrell.=
co.uk> wrote:

> Hi there,
>=20
> I recently experienced a type of crash I haven't seen before on this syst=
em which seems to originate in __btrfs_release_delayed_node on Kernel 6.18.=
2-arch2-1.

Hey, thanks for the report. This looks very similar to a different
report that has been fixed in 6.19-rc5.
Report: https://lore.kernel.org/oe-lkp/202511262228.6dda231e-lkp@intel.com/
Fix: https://lore.kernel.org/linux-btrfs/7c89417ac3352ce3cb0a6373a1746155c1=
e2754d.1765588168.git.loemra.dev@gmail.com/

Please let me know if this fixes your issue.

>=20
> Here's the stack trace:
>=20
> ```

Are these the first refcount_t: warnings in your dmesg? I would
expect an earlier warning that looks like
refcount_t: addition on 0; use-after-free.

> Jan 06 16:46:07 leviathan kernel: ------------[ cut here ]------------
> Jan 06 16:46:07 leviathan kernel: refcount_t: saturated; leaking memory.
> Jan 06 16:46:07 leviathan kernel: WARNING: CPU: 5 PID: 299428 at lib/refc=
ount.c:22 refcount_warn_saturate+0x55/0x110
> Jan 06 16:46:07 leviathan kernel: Modules linked in: uinput uas usb_stora=
ge rfcomm tun ip6table_nat ip6table_filter ip6_tables iptable_nat iptable_f=
ilter ip_tables x_tables cmac algif_hash algif_skcipher af_alg bnep 8021q g=
arp mrp stp llc vfat fat amd_atl intel_rapl_msr intel_rapl_common mt7921e s=
nd_hda_codec_atihdmi mt7921_common snd_hda_codec_hdmi mt792x_lib snd_hda_in=
tel mt76_connac_lib uvcvideo kvm_amd snd_hda_codec mt76 videobuf2_vmalloc s=
nd_usb_audio uvc btusb snd_hda_core snd_usbmidi_lib videobuf2_memops kvm bt=
mtk asus_nb_wmi snd_ump snd_intel_dspcfg videobuf2_v4l2 btrtl asus_wmi mac8=
0211 snd_rawmidi spd5118 asus_ec_sensors snd_intel_sdw_acpi btbcm videobuf2=
_common platform_profile irqbypass snd_hwdep snd_seq_device btintel sp5100_=
tco rapl pcspkr videodev snd_pcm sparse_keymap wmi_bmof cfg80211 bluetooth =
snd_timer i2c_piix4 igc snd k10temp i2c_smbus soundcore ptp mousedev mc joy=
dev rfkill libarc4 pps_core wacom gpio_amdpt gpio_generic mac_hid nft_rejec=
t_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_chain_nat nf_nat nf_con=
ntrack
> Jan 06 16:46:07 leviathan kernel:  nf_defrag_ipv6 nf_defrag_ipv4 nf_table=
s crypto_user pkcs8_key_parser ntsync nfnetlink dm_crypt encrypted_keys tru=
sted asn1_encoder tee dm_mod hid_logitech_hidpp amdgpu amdxcp i2c_algo_bit =
drm_ttm_helper ttm drm_exec drm_panel_backlight_quirks gpu_sched drm_suball=
oc_helper drm_buddy nvme polyval_clmulni hid_logitech_dj drm_display_helper=
 ghash_clmulni_intel nvme_core ccp cec aesni_intel video nvme_keyring nvme_=
auth hkdf wmi
> Jan 06 16:46:07 leviathan kernel: CPU: 5 UID: 0 PID: 299428 Comm: kworker=
/u97:4 Tainted: G        W           6.18.2-arch2-1 #1 PREEMPT(full)  e9d53=
cde2ee9d1bdaa4464d2214ad0f22bd43723
> Jan 06 16:46:07 leviathan kernel: Tainted: [W]=3DWARN
> Jan 06 16:46:07 leviathan kernel: Hardware name: ASUS System Product Name=
/ROG STRIX B650E-I GAMING WIFI, BIOS 3057 10/29/2024
> Jan 06 16:46:07 leviathan kernel: Workqueue: btrfs-delalloc btrfs_work_he=
lper
> Jan 06 16:46:07 leviathan kernel: RIP: 0010:refcount_warn_saturate+0x55/0=
x110
> Jan 06 16:46:07 leviathan kernel: Code: 84 bc 00 00 00 e9 76 ff 56 ff 85 =
f6 74 46 80 3d b4 ce ae 01 00 75 ee 48 c7 c7 60 4a 5d 8f c6 05 a4 ce ae 01 =
01 e8 4b 7d 7b ff <0f> 0b e9 4f ff 56 ff 80 3d 8d ce ae 01 00 75 cb 48 c7 c=
7 10 4b 5d
> Jan 06 16:46:07 leviathan kernel: RSP: 0018:ffffcff6e1687b90 EFLAGS: 0001=
0246
> Jan 06 16:46:07 leviathan kernel: RAX: 0000000000000000 RBX: ffff8e330174=
b110 RCX: 0000000000000027
> Jan 06 16:46:07 leviathan kernel: RDX: ffff8e41de15d008 RSI: 000000000000=
0001 RDI: ffff8e41de15d000
> Jan 06 16:46:07 leviathan kernel: RBP: ffff8e32d3349060 R08: 000000000000=
0000 R09: 00000000ffffdfff
> Jan 06 16:46:07 leviathan kernel: R10: ffffffff90bbaa40 R11: ffffcff6e168=
7a28 R12: 0000000000020000
> Jan 06 16:46:07 leviathan kernel: R13: 0000000000000000 R14: ffff8e330174=
b228 R15: 0000000000000000
> Jan 06 16:46:07 leviathan kernel: FS:  0000000000000000(0000) GS:ffff8e42=
4d632000(0000) knlGS:0000000000000000
> Jan 06 16:46:07 leviathan kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 000000=
0080050033
> Jan 06 16:46:07 leviathan kernel: CR2: 000033b723ba6004 CR3: 0000000024a2=
4000 CR4: 0000000000f50ef0
> Jan 06 16:46:07 leviathan kernel: PKRU: 55555554
> Jan 06 16:46:07 leviathan kernel: Call Trace:
> Jan 06 16:46:07 leviathan kernel:  <TASK>
> Jan 06 16:46:07 leviathan kernel:  __btrfs_release_delayed_node.part.0+0x=
2e7/0x310
> Jan 06 16:46:07 leviathan kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> Jan 06 16:46:07 leviathan kernel:  btrfs_delayed_update_inode+0xf5/0x1e0
> Jan 06 16:46:07 leviathan kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> Jan 06 16:46:07 leviathan kernel:  ? btrfs_update_root_times+0x75/0xa0
> Jan 06 16:46:07 leviathan kernel:  btrfs_update_inode+0x59/0xc0
> Jan 06 16:46:07 leviathan kernel:  __cow_file_range_inline+0x16c/0x3f0
> Jan 06 16:46:07 leviathan kernel:  cow_file_range_inline.constprop.0+0xd7=
/0x140
> Jan 06 16:46:07 leviathan kernel:  compress_file_range+0x3d6/0x5c0
> Jan 06 16:46:07 leviathan kernel:  ? __pfx_submit_compressed_extents+0x10=
/0x10
> Jan 06 16:46:07 leviathan kernel:  btrfs_work_helper+0xe1/0x380
> Jan 06 16:46:07 leviathan kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> Jan 06 16:46:07 leviathan kernel:  process_one_work+0x193/0x350
> Jan 06 16:46:07 leviathan kernel:  worker_thread+0x2d7/0x410
> Jan 06 16:46:07 leviathan kernel:  ? __pfx_worker_thread+0x10/0x10
> Jan 06 16:46:07 leviathan kernel:  kthread+0xfc/0x240
> Jan 06 16:46:07 leviathan kernel:  ? __pfx_kthread+0x10/0x10
> Jan 06 16:46:07 leviathan kernel:  ? __pfx_kthread+0x10/0x10
> Jan 06 16:46:07 leviathan kernel:  ret_from_fork+0x1c2/0x1f0
> Jan 06 16:46:07 leviathan kernel:  ? __pfx_kthread+0x10/0x10
> Jan 06 16:46:07 leviathan kernel:  ret_from_fork_asm+0x1a/0x30
> Jan 06 16:46:07 leviathan kernel:  </TASK>
> Jan 06 16:46:07 leviathan kernel: ---[ end trace 0000000000000000 ]---
> Jan 06 16:46:07 leviathan kernel: ------------[ cut here ]------------
> Jan 06 16:46:07 leviathan kernel: refcount_t: decrement hit 0; leaking me=
mory.
> Jan 06 16:46:07 leviathan kernel: WARNING: CPU: 5 PID: 327490 at lib/refc=
ount.c:31 refcount_warn_saturate+0xff/0x110
> Jan 06 16:46:07 leviathan kernel: Modules linked in: uinput uas usb_stora=
ge rfcomm tun ip6table_nat ip6table_filter ip6_tables iptable_nat iptable_f=
ilter ip_tables x_tables cmac algif_hash algif_skcipher af_alg bnep 8021q g=
arp mrp stp llc vfat fat amd_atl intel_rapl_msr intel_rapl_common mt7921e s=
nd_hda_codec_atihdmi mt7921_common snd_hda_codec_hdmi mt792x_lib snd_hda_in=
tel mt76_connac_lib uvcvideo kvm_amd snd_hda_codec mt76 videobuf2_vmalloc s=
nd_usb_audio uvc btusb snd_hda_core snd_usbmidi_lib videobuf2_memops kvm bt=
mtk asus_nb_wmi snd_ump snd_intel_dspcfg videobuf2_v4l2 btrtl asus_wmi mac8=
0211 snd_rawmidi spd5118 asus_ec_sensors snd_intel_sdw_acpi btbcm videobuf2=
_common platform_profile irqbypass snd_hwdep snd_seq_device btintel sp5100_=
tco rapl pcspkr videodev snd_pcm sparse_keymap wmi_bmof cfg80211 bluetooth =
snd_timer i2c_piix4 igc snd k10temp i2c_smbus soundcore ptp mousedev mc joy=
dev rfkill libarc4 pps_core wacom gpio_amdpt gpio_generic mac_hid nft_rejec=
t_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_chain_nat nf_nat nf_con=
ntrack
> Jan 06 16:46:07 leviathan kernel:  nf_defrag_ipv6 nf_defrag_ipv4 nf_table=
s crypto_user pkcs8_key_parser ntsync nfnetlink dm_crypt encrypted_keys tru=
sted asn1_encoder tee dm_mod hid_logitech_hidpp amdgpu amdxcp i2c_algo_bit =
drm_ttm_helper ttm drm_exec drm_panel_backlight_quirks gpu_sched drm_suball=
oc_helper drm_buddy nvme polyval_clmulni hid_logitech_dj drm_display_helper=
 ghash_clmulni_intel nvme_core ccp cec aesni_intel video nvme_keyring nvme_=
auth hkdf wmi
> Jan 06 16:46:07 leviathan kernel: CPU: 5 UID: 1000 PID: 327490 Comm: Back=
gro~ol #189 Tainted: G        W           6.18.2-arch2-1 #1 PREEMPT(full)  =
e9d53cde2ee9d1bdaa4464d2214ad0f22bd43723
> Jan 06 16:46:07 leviathan kernel: Tainted: [W]=3DWARN
> Jan 06 16:46:07 leviathan kernel: Hardware name: ASUS System Product Name=
/ROG STRIX B650E-I GAMING WIFI, BIOS 3057 10/29/2024
> Jan 06 16:46:07 leviathan kernel: RIP: 0010:refcount_warn_saturate+0xff/0=
x110
> Jan 06 16:46:07 leviathan kernel: Code: 88 4a 5d 8f c6 05 13 ce ae 01 01 =
e8 bb 7c 7b ff 0f 0b e9 bf fe 56 ff 48 c7 c7 e0 4a 5d 8f c6 05 f7 cd ae 01 =
01 e8 a1 7c 7b ff <0f> 0b e9 a5 fe 56 ff 66 2e 0f 1f 84 00 00 00 00 00 90 9=
0 90 90 90
> Jan 06 16:46:07 leviathan kernel: RSP: 0018:ffffcff6eed07868 EFLAGS: 0001=
0246
> Jan 06 16:46:07 leviathan kernel: RAX: 0000000000000000 RBX: ffff8e330174=
b110 RCX: 0000000000000027
> Jan 06 16:46:07 leviathan kernel: RDX: ffff8e41de15d008 RSI: 000000000000=
0001 RDI: ffff8e41de15d000
> Jan 06 16:46:07 leviathan kernel: RBP: ffff8e32d3349060 R08: 000000000000=
0000 R09: 00000000ffffdfff
> Jan 06 16:46:07 leviathan kernel: R10: ffffffff90bbaa40 R11: ffffcff6eed0=
7700 R12: 0000000000000000
> Jan 06 16:46:07 leviathan kernel: R13: ffff8e32d35393f0 R14: ffff8e330174=
b228 R15: 0000000000000000
> Jan 06 16:46:07 leviathan kernel: FS:  00007fb4ae5e56c0(0000) GS:ffff8e42=
4d632000(0000) knlGS:00007fa800000000
> Jan 06 16:46:07 leviathan kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 000000=
0080050033
> Jan 06 16:46:07 leviathan kernel: CR2: 00007f87aaf44000 CR3: 000000012615=
c000 CR4: 0000000000f50ef0
> Jan 06 16:46:07 leviathan kernel: PKRU: 55555554
> Jan 06 16:46:07 leviathan kernel: Call Trace:
> Jan 06 16:46:07 leviathan kernel:  <TASK>
> Jan 06 16:46:07 leviathan kernel:  __btrfs_release_delayed_node.part.0+0x=
2f6/0x310
> Jan 06 16:46:07 leviathan kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> Jan 06 16:46:07 leviathan kernel:  ? balance_dirty_pages_ratelimited_flag=
s+0x190/0x380
> Jan 06 16:46:07 leviathan kernel:  btrfs_commit_inode_delayed_inode+0xda/=
0x120
> Jan 06 16:46:07 leviathan kernel:  btrfs_evict_inode+0x286/0x3e0
> Jan 06 16:46:07 leviathan kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> Jan 06 16:46:07 leviathan kernel:  ? xas_load+0xd/0xd0
> Jan 06 16:46:07 leviathan kernel:  evict+0x117/0x290
> Jan 06 16:46:07 leviathan kernel:  __dentry_kill+0x6b/0x190
> Jan 06 16:46:07 leviathan kernel:  dput+0xeb/0x1c0
> Jan 06 16:46:07 leviathan kernel:  do_renameat2+0x41e/0x580
> Jan 06 16:46:07 leviathan kernel:  __x64_sys_rename+0x7a/0xc0
> Jan 06 16:46:07 leviathan kernel:  do_syscall_64+0x81/0x7f0
> Jan 06 16:46:07 leviathan kernel:  ? __mark_inode_dirty+0x273/0x350
> Jan 06 16:46:07 leviathan kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> Jan 06 16:46:07 leviathan kernel:  ? btrfs_block_rsv_release+0x105/0x1f0
> Jan 06 16:46:07 leviathan kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> Jan 06 16:46:07 leviathan kernel:  ? __btrfs_qgroup_free_meta+0x2b/0x160
> Jan 06 16:46:07 leviathan kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> Jan 06 16:46:07 leviathan kernel:  ? btrfs_inode_rsv_release+0x60/0xf0
> Jan 06 16:46:07 leviathan kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> Jan 06 16:46:07 leviathan kernel:  ? btrfs_drop_folio+0x3c/0x60
> Jan 06 16:46:07 leviathan kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> Jan 06 16:46:07 leviathan kernel:  ? btrfs_buffered_write+0x527/0x8a0
> Jan 06 16:46:07 leviathan kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> Jan 06 16:46:07 leviathan kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> Jan 06 16:46:07 leviathan kernel:  ? vfs_write+0x2e6/0x480
> Jan 06 16:46:07 leviathan kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> Jan 06 16:46:07 leviathan kernel:  ? xas_load+0xd/0xd0
> Jan 06 16:46:07 leviathan kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> Jan 06 16:46:07 leviathan kernel:  ? xa_load+0x76/0xb0
> Jan 06 16:46:07 leviathan kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> Jan 06 16:46:07 leviathan kernel:  ? refill_obj_stock+0x12e/0x240
> Jan 06 16:46:07 leviathan kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> Jan 06 16:46:07 leviathan kernel:  ? __memcg_slab_free_hook+0xf4/0x140
> Jan 06 16:46:07 leviathan kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> Jan 06 16:46:07 leviathan kernel:  ? kmem_cache_free+0x549/0x5d0
> Jan 06 16:46:07 leviathan kernel:  ? __x64_sys_close+0x3d/0x80
> Jan 06 16:46:07 leviathan kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> Jan 06 16:46:07 leviathan kernel:  ? __x64_sys_close+0x3d/0x80
> Jan 06 16:46:07 leviathan kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> Jan 06 16:46:07 leviathan kernel:  ? do_syscall_64+0x81/0x7f0
> Jan 06 16:46:07 leviathan kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> Jan 06 16:46:07 leviathan kernel:  ? switch_fpu_return+0x4e/0xd0
> Jan 06 16:46:07 leviathan kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> Jan 06 16:46:07 leviathan kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x=
7e
> Jan 06 16:46:07 leviathan kernel: RIP: 0033:0x7fb53e460adb
> Jan 06 16:46:07 leviathan kernel: Code: c0 48 8b 5d f8 c9 c3 0f 1f 84 00 =
00 00 00 00 b8 ff ff ff ff eb eb 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa b8 =
52 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 05 c3 0f 1f 40 00 48 8b 15 01 72 1=
a 00 f7 d8
> Jan 06 16:46:07 leviathan kernel: RSP: 002b:00007fb4ae5e3d88 EFLAGS: 0000=
0246 ORIG_RAX: 0000000000000052
> Jan 06 16:46:07 leviathan kernel: RAX: ffffffffffffffda RBX: 000000000000=
0055 RCX: 00007fb53e460adb
> Jan 06 16:46:07 leviathan kernel: RDX: 0000000000000055 RSI: 00007fb4ae5e=
3d90 RDI: 00007fb4ae5e3f10
> Jan 06 16:46:07 leviathan kernel: RBP: 00007fb4ae5e4100 R08: 808080808080=
8080 R09: 0101010101010100
> Jan 06 16:46:07 leviathan kernel: R10: fffefffffefffcff R11: 000000000000=
0246 R12: 00007fb4ae5e3d90
> Jan 06 16:46:07 leviathan kernel: R13: 0000000000000054 R14: 00007fb47174=
0790 R15: 00007fb4ae5e3f10
> Jan 06 16:46:07 leviathan kernel:  </TASK>
> Jan 06 16:46:07 leviathan kernel: ---[ end trace 0000000000000000 ]---
> ```
>=20
> ~gtf
>=20

