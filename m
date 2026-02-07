Return-Path: <linux-btrfs+bounces-21465-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BoBDMZsh2lVXwQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21465-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sat, 07 Feb 2026 17:48:06 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE151068D8
	for <lists+linux-btrfs@lfdr.de>; Sat, 07 Feb 2026 17:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B3FE93015A56
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Feb 2026 16:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66EC333431;
	Sat,  7 Feb 2026 16:47:56 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from iguana.tulip.relay.mailchannels.net (iguana.tulip.relay.mailchannels.net [23.83.218.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAB724B28
	for <linux-btrfs@vger.kernel.org>; Sat,  7 Feb 2026 16:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.253
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770482876; cv=pass; b=FS8bsnMhxbqroA1DgMHR94GTKbS3Kmg/fWhihcKI6XD4vvk2gL5DWrHByCDGepM0f30rMW/ppZuw7yHlklWyioConvmQMTZrchmEwQD1XUvVCbq/rhnIeikj5G+HBbBAaagYX9hQYAS91nDkRUNb23JG3LuKxLlzRsLT1oyNE2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770482876; c=relaxed/simple;
	bh=tgTEXgqA/oFTYJu4qhc1cuBqzBNoxgaRLmQxetHyxHk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YV+20j25gUIupDU+t4bVLS7QPiXml5QcCg8Npt2H4lo+CTkzphE9rPabKVrMwKvTa2/vAT8RMYfscmQTGUcnoSMCnzUzTufQ3TdcTrRhMxGJZ8dFe4JUm2WFiHJZ1qRXFVtP/zv7unhI3ohvlmHUvQf3IEbQN4VstOZIQZ73HxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org; spf=pass smtp.mailfrom=scientia.org; arc=pass smtp.client-ip=23.83.218.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 31987121B57;
	Sat, 07 Feb 2026 16:47:32 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (100-123-63-54.trex-nlb.outbound.svc.cluster.local [100.123.63.54])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id 5585A121A72;
	Sat, 07 Feb 2026 16:47:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1770482851;
	b=wb3F08UM4dTQf2baUBU4W4rQ9EXjuRLYevsrVTI/6MXxHL1YfXlUzdNQ1srfYT7FnYWWxI
	mXfgys12RcRtXlJjf4Gjo5/NBZbI2V5hNBWCRTfAXKFan2acIlOVIAmraM6xwCdw2+m/y3
	JfRBiX2axFZH+4OAXsifKIKij/FVlj2uDavai+G6GfFY81iryLSsUrLaFJOyFj0EjWE8FR
	vPLXWFEIyxqo6K8H02XgFtPdBRu+Uw2v9oSZOaIF1Pieodx40ShPUwjW4clJXGNjyeeHf/
	D2G0xAdWk+IR2Bsxx5JlAY+e3uthiw+oOf6LTkvDPc5EOGBnnG+/zFZWlT8Cnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1770482851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Upcy982v/epe7OOHQA4guDiW1odKyjNY+wCTq7XEAnQ=;
	b=cneS7Wv24+p7H9RNGVTDgvzBfT8HCB17hPjGBTF8HUyhgooyN2WwGwdHTWVTrUrox0a5we
	j6wiz7DgnT2yetWM2SA9FihSE/bBd8VjNsSRny6rRF+0cZ/JGObYcqesChx1Ryo+ltVHvF
	xCbZZcl5TCVu2szxKuYGBNgvsYRx8I0n1xjeMcbgVAShZAZdQR0EP5IxIbCKOckt69eGa3
	EAAQPi1hDju5wj85+TO5Kf6HToLm28P+EFRNn+AyTtXWKKoFqM1ViS8Ez+dK6wZ8WSs5Y/
	WM0Pe9da3RJdPECRZuYznTkE6g2SOHZXdx79GacR4obg6t7VlOa0CYQhKwv5Pg==
ARC-Authentication-Results: i=1;
	rspamd-79bdc9947c-vvhqt;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Bottle-Eyes: 0f9c5d5c48139a61_1770482852057_4032252186
X-MC-Loop-Signature: 1770482852057:2889018720
X-MC-Ingress-Time: 1770482852057
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.123.63.54 (trex/7.1.3);
	Sat, 07 Feb 2026 16:47:32 +0000
Received: from [79.127.207.161] (port=13796 helo=[10.2.0.2])
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.1)
	(envelope-from <calestyo@scientia.org>)
	id 1volT1-0000000EckV-3VEK;
	Sat, 07 Feb 2026 16:47:28 +0000
Message-ID: <89188b7b8b5a1f9bb64af37777aec906134ad75c.camel@scientia.org>
Subject: Re: space_info METADATA (sub-group id 0) has 691535872 free, is not
 full  //  open_ctree failed: -2
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>
Date: Sat, 07 Feb 2026 17:47:27 +0100
In-Reply-To: <05e63d59951cfb8612c876d5bc7fdb76b272b01c.camel@scientia.org>
References: <f3574976d7b5bc8f05e42055d85d4b61263bc5c5.camel@scientia.org>
		 <c07b6fde-03a3-4c97-9f59-866c81e78b85@suse.com>
		 <31615495f428dbe499ae5f5a109cc6c74c8979ca.camel@scientia.org>
		 <fc2f1d31-7f2c-493f-be42-2cb8c1fd5a17@gmx.com>
		 <84b22b2cc7534be60eb423973336101c9e9b9ad3.camel@scientia.org>
		 <b681834e-7b0f-4606-8c52-f2b4dafba246@suse.com>
		 <4e6ad7ef198de72edaf890a2257bf63864984197.camel@scientia.org>
		 <cca8b4ea-97ef-433e-9db9-4eca67b89576@suse.com>
		 <f1aaada378adad0da020bd679531c7f503ad6f93.camel@scientia.org>
		 <914a6a60-6bb6-4255-a8cc-ea6f28e7a9cf@suse.com>
		 <a75537dc77e5b6fac922a97409ca4636805147dc.camel@scientia.org>
		 <fff60222-0b9f-4f09-b3a6-d415aa64b6d7@gmx.com>
		 <18a87dd4f3155bb1d9c9884f39dbf53c802a10cd.camel@scientia.org>
		 <572f0ac4-90f6-4c56-aa4c-2a64e365d526@suse.com>
		 <52c813cf8dffe11325ce291d3f3bd41bcce21936.camel@scientia.org>
		 <f094ddbb70cabd2e329615269519b1844f786629.camel@scientia.org>
		 <a6d825eb-3e8c-404f-90f6-6b4e5621479d@suse.com>
	 <05e63d59951cfb8612c876d5bc7fdb76b272b01c.camel@scientia.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-8 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-AuthUser: calestyo@scientia.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21465-lists,linux-btrfs=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[scientia.org];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[calestyo@scientia.org,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-0.921];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EAE151068D8
X-Rspamd-Action: no action

Hey again.


I've had another fs for backups only (so no precious data and no
problem if it would be lost), which I do fsck basically after each
backup (and which showed no errors last time).

I blindly assume it would also suffer from the:
  We have a space info key for a block group that doesn't exist
issue.

So I've mounted it straight away with:
  # mount -o space_cache=3Dv2,clear_cache /dev/mapper/data-f /data/f
 (again, fstab has ro, .... don't recall right now if that's used if
 I specify device and mountpoint)

This already gave me:

Feb 07 17:10:35 heisenberg kernel: BTRFS: device label data-f devid 1 trans=
id 2928 /dev/mapper/data-f (253:2) scanned by mount (157055)
Feb 07 17:10:35 heisenberg kernel: BTRFS info (device dm-2): first mount of=
 filesystem 84ee379c-29da-4513-b31b-db5e6097ebc8
Feb 07 17:10:35 heisenberg kernel: BTRFS info (device dm-2): using crc32c (=
crc32c-lib) checksum algorithm
Feb 07 17:10:55 heisenberg kernel: BTRFS info (device dm-2): rebuilding fre=
e space tree
Feb 07 17:11:27 heisenberg kernel: ------------[ cut here ]------------
Feb 07 17:11:27 heisenberg kernel: WARNING: CPU: 10 PID: 157101 at fs/btrfs=
/transaction.c:144 btrfs_put_transaction+0x141/0x180 [btrfs]
Feb 07 17:11:27 heisenberg kernel: Modules linked in: cpuid ext4 mbcache jb=
d2 sg uas nft_fib_ipv6 nft_ct nft_fib_ipv4 nft_fib wireguard libcurve25519 =
libchacha20poly1305 libchacha ip6_udp_tunnel udp_tunnel libpoly1305 cmac cc=
m snd_seq_dummy snd_hrtimer snd_seq snd_ctl_led snd_soc_skl_hda_dsp snd_soc=
_intel_sof_board_helpers snd_sof_probes snd_soc_intel_hda_dsp_common xe snd=
_hda_codec_intelhdmi snd_hda_codec_alc269 snd_hda_scodec_component drm_gpuv=
m snd_hda_codec_realtek_lib drm_gpusvm_helper snd_hda_codec_generic gpu_sch=
ed snd_soc_dmic drm_ttm_helper drm_exec drm_suballoc_helper ip6t_REJECT nf_=
reject_ipv6 ipt_REJECT nf_reject_ipv4 snd_hda_intel xt_tcpudp snd_sof_pci_i=
ntel_tgl xt_conntrack snd_sof_pci_intel_cnl nf_conntrack snd_sof_intel_hda_=
generic nf_defrag_ipv6 soundwire_intel nf_defrag_ipv4 snd_sof_intel_hda_sdw=
_bpt nft_compat nf_tables snd_sof_intel_hda_common intel_uncore_frequency j=
oydev intel_uncore_frequency_common binfmt_misc x_tables snd_soc_hdac_hda x=
86_pkg_temp_thermal snd_sof_intel_hda_mlink intel_powerclamp snd_sof_intel_=
hda
Feb 07 17:11:27 heisenberg kernel:  i915 snd_hda_codec_hdmi soundwire_caden=
ce snd_sof_pci coretemp snd_sof_xtensa_dsp snd_sof kvm_intel snd_sof_utils =
snd_soc_acpi_intel_match snd_soc_acpi_intel_sdca_quirks soundwire_generic_a=
llocation kvm snd_soc_acpi hid_multitouch crc8 soundwire_bus iwlmvm snd_soc=
_sdca snd_soc_avs btusb uvcvideo btmtk irqbypass snd_soc_hda_codec btrtl vi=
deobuf2_vmalloc ghash_clmulni_intel drm_buddy btbcm snd_hda_ext_core uvc hi=
d_generic snd_hda_codec btintel iTCO_wdt rapl videobuf2_memops ttm sdhci_pc=
i snd_usb_audio intel_pmc_bxt processor_thermal_device_pci mac80211 intel_r=
apl_msr videobuf2_v4l2 snd_hda_core sdhci_uhs2 drm_display_helper bluetooth=
 intel_cstate iTCO_vendor_support snd_usbmidi_lib videodev processor_therma=
l_device sdhci snd_intel_dspcfg processor_thermal_wt_hint platform_temperat=
ure_control snd_rawmidi cec videobuf2_common snd_intel_sdw_acpi cqhci proce=
ssor_thermal_soc_slider snd_seq_device snd_hwdep mei_hdcp watchdog mei_pxp =
ee1004 wmi_bmof usbhid mc ecdh_generic libarc4 intel_uncore crc16 intel_pmc=
_core
Feb 07 17:11:27 heisenberg kernel:  mmc_core snd_soc_core rc_core platform_=
profile pmt_telemetry snd_compress ucsi_acpi processor_thermal_rfim drm_cli=
ent_lib snd_pcm_dmaengine processor_thermal_rapl typec_ucsi iwlwifi pmt_dis=
covery drm_kms_helper snd_pcm i2c_hid_acpi intel_rapl_common typec pmt_clas=
s i2c_hid i2c_algo_bit int3400_thermal hid roles fujitsu_laptop intel_pmc_s=
sram_telemetry acpi_thermal_rel acpi_pad acpi_tad cfg80211 battery button v=
ideo processor_thermal_wt_req i2c_i801 snd_timer processor_thermal_power_fl=
oor i2c_smbus mei_me snd intel_lpss_pci processor_thermal_mbox soundcore in=
tel_lpss mei rfkill wmi idma64 intel_vsec ac int340x_thermal_zone igen6_eda=
c parport_pc lp ppdev drm parport efi_pstore configfs nfnetlink autofs4 crc=
32c_cryptoapi sd_mod dm_crypt dm_mod raid10 raid456 async_raid6_recov async=
_memcpy async_pq async_xor async_tx raid1 raid0 md_mod usb_storage scsi_mod=
 scsi_common btrfs blake2b_generic xor raid6_pq xhci_pci xhci_hcd nvme thun=
derbolt nvme_core usbcore e1000e evdev nvme_keyring nvme_auth serio_raw int=
el_hid
Feb 07 17:11:27 heisenberg kernel:  fan pcspkr aesni_intel usb_common hkdf =
sparse_keymap efivarfs
Feb 07 17:11:27 heisenberg kernel: CPU: 10 UID: 0 PID: 157101 Comm: btrfs-t=
ransacti Not tainted 6.18.8+deb14-amd64 #1 PREEMPT(lazy)  Debian 6.18.8-1=
=20
Feb 07 17:11:27 heisenberg kernel: Hardware name: FUJITSU CLIENT COMPUTING =
LIMITED LIFEBOOK U7512/FJNB2F4, BIOS Version 2.35 07/01/2025
Feb 07 17:11:27 heisenberg kernel: RIP: 0010:btrfs_put_transaction+0x141/0x=
180 [btrfs]
Feb 07 17:11:27 heisenberg kernel: Code: 48 89 ef 5d 41 5c 41 5d e9 8c c3 4=
9 eb 5b be 03 00 00 00 5d 41 5c 41 5d e9 fc 8b 7f eb 0f 0b e9 e2 fe ff ff 0=
f 0b 0f 0b eb d5 <0f> 0b e9 1a ff ff ff 0f 0b e9 21 ff ff ff e8 3c 24 20 eb=
 48 8b 95
Feb 07 17:11:27 heisenberg kernel: RSP: 0018:ffffd1b2ccfa3de0 EFLAGS: 00010=
282
Feb 07 17:11:27 heisenberg kernel: RAX: ffff8dd177afa628 RBX: ffff8dd177afa=
600 RCX: ffff8dd16e1d1488
Feb 07 17:11:27 heisenberg kernel: RDX: ffff8dd177afa628 RSI: ffff8dd177afa=
628 RDI: ffff8dd177afa610
Feb 07 17:11:27 heisenberg kernel: RBP: ffff8dd177afa600 R08: 0000000000000=
000 R09: ffffd1b2ccfa3db0
Feb 07 17:11:27 heisenberg kernel: R10: ffffd1b2ccfa3db0 R11: 0000000000000=
000 R12: ffff8ddf8743bf18
Feb 07 17:11:27 heisenberg kernel: R13: ffff8dd177afa628 R14: ffff8dd16e1d1=
460 R15: 0000000000000000
Feb 07 17:11:27 heisenberg kernel: FS:  0000000000000000(0000) GS:ffff8de10=
124c000(0000) knlGS:0000000000000000
Feb 07 17:11:27 heisenberg kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000=
080050033
Feb 07 17:11:27 heisenberg kernel: CR2: 00007f2584729a00 CR3: 00000003de22c=
001 CR4: 0000000000f72ef0
Feb 07 17:11:27 heisenberg kernel: PKRU: 55555554
Feb 07 17:11:27 heisenberg kernel: Call Trace:
Feb 07 17:11:27 heisenberg kernel:  <TASK>
Feb 07 17:11:27 heisenberg kernel:  btrfs_commit_transaction+0x72a/0xdf0 [b=
trfs]
Feb 07 17:11:27 heisenberg kernel:  ? __pfx_autoremove_wake_function+0x10/0=
x10
Feb 07 17:11:27 heisenberg kernel:  transaction_kthread+0x157/0x1c0 [btrfs]
Feb 07 17:11:27 heisenberg kernel:  ? __pfx_transaction_kthread+0x10/0x10 [=
btrfs]
Feb 07 17:11:27 heisenberg kernel:  kthread+0xfc/0x240
Feb 07 17:11:27 heisenberg kernel:  ? __pfx_kthread+0x10/0x10
Feb 07 17:11:27 heisenberg kernel:  ret_from_fork+0x1cc/0x200
Feb 07 17:11:27 heisenberg kernel:  ? __pfx_kthread+0x10/0x10
Feb 07 17:11:27 heisenberg kernel:  ret_from_fork_asm+0x1a/0x30
Feb 07 17:11:27 heisenberg kernel:  </TASK>
Feb 07 17:11:27 heisenberg kernel: ---[ end trace 0000000000000000 ]---
Feb 07 17:12:00 heisenberg kernel: ------------[ cut here ]------------
Feb 07 17:12:00 heisenberg kernel: WARNING: CPU: 10 PID: 157101 at fs/btrfs=
/transaction.c:144 btrfs_put_transaction+0x141/0x180 [btrfs]
Feb 07 17:12:00 heisenberg kernel: Modules linked in: cpuid ext4 mbcache jb=
d2 sg uas nft_fib_ipv6 nft_ct nft_fib_ipv4 nft_fib wireguard libcurve25519 =
libchacha20poly1305 libchacha ip6_udp_tunnel udp_tunnel libpoly1305 cmac cc=
m snd_seq_dummy snd_hrtimer snd_seq snd_ctl_led snd_soc_skl_hda_dsp snd_soc=
_intel_sof_board_helpers snd_sof_probes snd_soc_intel_hda_dsp_common xe snd=
_hda_codec_intelhdmi snd_hda_codec_alc269 snd_hda_scodec_component drm_gpuv=
m snd_hda_codec_realtek_lib drm_gpusvm_helper snd_hda_codec_generic gpu_sch=
ed snd_soc_dmic drm_ttm_helper drm_exec drm_suballoc_helper ip6t_REJECT nf_=
reject_ipv6 ipt_REJECT nf_reject_ipv4 snd_hda_intel xt_tcpudp snd_sof_pci_i=
ntel_tgl xt_conntrack snd_sof_pci_intel_cnl nf_conntrack snd_sof_intel_hda_=
generic nf_defrag_ipv6 soundwire_intel nf_defrag_ipv4 snd_sof_intel_hda_sdw=
_bpt nft_compat nf_tables snd_sof_intel_hda_common intel_uncore_frequency j=
oydev intel_uncore_frequency_common binfmt_misc x_tables snd_soc_hdac_hda x=
86_pkg_temp_thermal snd_sof_intel_hda_mlink intel_powerclamp snd_sof_intel_=
hda
Feb 07 17:12:00 heisenberg kernel:  i915 snd_hda_codec_hdmi soundwire_caden=
ce snd_sof_pci coretemp snd_sof_xtensa_dsp snd_sof kvm_intel snd_sof_utils =
snd_soc_acpi_intel_match snd_soc_acpi_intel_sdca_quirks soundwire_generic_a=
llocation kvm snd_soc_acpi hid_multitouch crc8 soundwire_bus iwlmvm snd_soc=
_sdca snd_soc_avs btusb uvcvideo btmtk irqbypass snd_soc_hda_codec btrtl vi=
deobuf2_vmalloc ghash_clmulni_intel drm_buddy btbcm snd_hda_ext_core uvc hi=
d_generic snd_hda_codec btintel iTCO_wdt rapl videobuf2_memops ttm sdhci_pc=
i snd_usb_audio intel_pmc_bxt processor_thermal_device_pci mac80211 intel_r=
apl_msr videobuf2_v4l2 snd_hda_core sdhci_uhs2 drm_display_helper bluetooth=
 intel_cstate iTCO_vendor_support snd_usbmidi_lib videodev processor_therma=
l_device sdhci snd_intel_dspcfg processor_thermal_wt_hint platform_temperat=
ure_control snd_rawmidi cec videobuf2_common snd_intel_sdw_acpi cqhci proce=
ssor_thermal_soc_slider snd_seq_device snd_hwdep mei_hdcp watchdog mei_pxp =
ee1004 wmi_bmof usbhid mc ecdh_generic libarc4 intel_uncore crc16 intel_pmc=
_core
Feb 07 17:12:00 heisenberg kernel:  mmc_core snd_soc_core rc_core platform_=
profile pmt_telemetry snd_compress ucsi_acpi processor_thermal_rfim drm_cli=
ent_lib snd_pcm_dmaengine processor_thermal_rapl typec_ucsi iwlwifi pmt_dis=
covery drm_kms_helper snd_pcm i2c_hid_acpi intel_rapl_common typec pmt_clas=
s i2c_hid i2c_algo_bit int3400_thermal hid roles fujitsu_laptop intel_pmc_s=
sram_telemetry acpi_thermal_rel acpi_pad acpi_tad cfg80211 battery button v=
ideo processor_thermal_wt_req i2c_i801 snd_timer processor_thermal_power_fl=
oor i2c_smbus mei_me snd intel_lpss_pci processor_thermal_mbox soundcore in=
tel_lpss mei rfkill wmi idma64 intel_vsec ac int340x_thermal_zone igen6_eda=
c parport_pc lp ppdev drm parport efi_pstore configfs nfnetlink autofs4 crc=
32c_cryptoapi sd_mod dm_crypt dm_mod raid10 raid456 async_raid6_recov async=
_memcpy async_pq async_xor async_tx raid1 raid0 md_mod usb_storage scsi_mod=
 scsi_common btrfs blake2b_generic xor raid6_pq xhci_pci xhci_hcd nvme thun=
derbolt nvme_core usbcore e1000e evdev nvme_keyring nvme_auth serio_raw int=
el_hid
Feb 07 17:12:00 heisenberg kernel:  fan pcspkr aesni_intel usb_common hkdf =
sparse_keymap efivarfs
Feb 07 17:12:00 heisenberg kernel: CPU: 10 UID: 0 PID: 157101 Comm: btrfs-t=
ransacti Tainted: G        W           6.18.8+deb14-amd64 #1 PREEMPT(lazy) =
 Debian 6.18.8-1=20
Feb 07 17:12:00 heisenberg kernel: Tainted: [W]=3DWARN
Feb 07 17:12:00 heisenberg kernel: Hardware name: FUJITSU CLIENT COMPUTING =
LIMITED LIFEBOOK U7512/FJNB2F4, BIOS Version 2.35 07/01/2025
Feb 07 17:12:00 heisenberg kernel: RIP: 0010:btrfs_put_transaction+0x141/0x=
180 [btrfs]
Feb 07 17:12:00 heisenberg kernel: Code: 48 89 ef 5d 41 5c 41 5d e9 8c c3 4=
9 eb 5b be 03 00 00 00 5d 41 5c 41 5d e9 fc 8b 7f eb 0f 0b e9 e2 fe ff ff 0=
f 0b 0f 0b eb d5 <0f> 0b e9 1a ff ff ff 0f 0b e9 21 ff ff ff e8 3c 24 20 eb=
 48 8b 95
Feb 07 17:12:00 heisenberg kernel: RSP: 0018:ffffd1b2ccfa3de0 EFLAGS: 00010=
282
Feb 07 17:12:00 heisenberg kernel: RAX: ffff8ddb24c57428 RBX: ffff8ddb24c57=
400 RCX: ffff8dd16e1d1488
Feb 07 17:12:00 heisenberg kernel: RDX: ffff8ddb24c57428 RSI: ffff8ddb24c57=
428 RDI: ffff8ddb24c57410
Feb 07 17:12:00 heisenberg kernel: RBP: ffff8ddb24c57400 R08: 0000000000000=
000 R09: ffffd1b2ccfa3db0
Feb 07 17:12:00 heisenberg kernel: R10: ffffd1b2ccfa3db0 R11: 0000000000000=
000 R12: ffff8ddf8743bf18
Feb 07 17:12:00 heisenberg kernel: R13: ffff8ddb24c57428 R14: ffff8dd16e1d1=
460 R15: 0000000000000000
Feb 07 17:12:00 heisenberg kernel: FS:  0000000000000000(0000) GS:ffff8de10=
124c000(0000) knlGS:0000000000000000
Feb 07 17:12:00 heisenberg kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000=
080050033
Feb 07 17:12:00 heisenberg kernel: CR2: 00007fa211f04ff8 CR3: 00000003de22c=
003 CR4: 0000000000f72ef0
Feb 07 17:12:00 heisenberg kernel: PKRU: 55555554
Feb 07 17:12:00 heisenberg kernel: Call Trace:
Feb 07 17:12:00 heisenberg kernel:  <TASK>
Feb 07 17:12:00 heisenberg kernel:  btrfs_commit_transaction+0x72a/0xdf0 [b=
trfs]
Feb 07 17:12:00 heisenberg kernel:  ? __pfx_autoremove_wake_function+0x10/0=
x10
Feb 07 17:12:00 heisenberg kernel:  transaction_kthread+0x157/0x1c0 [btrfs]
Feb 07 17:12:00 heisenberg kernel:  ? __pfx_transaction_kthread+0x10/0x10 [=
btrfs]
Feb 07 17:12:00 heisenberg kernel:  kthread+0xfc/0x240
Feb 07 17:12:00 heisenberg kernel:  ? __pfx_kthread+0x10/0x10
Feb 07 17:12:00 heisenberg kernel:  ret_from_fork+0x1cc/0x200
Feb 07 17:12:00 heisenberg kernel:  ? __pfx_kthread+0x10/0x10
Feb 07 17:12:00 heisenberg kernel:  ret_from_fork_asm+0x1a/0x30
Feb 07 17:12:00 heisenberg kernel:  </TASK>
Feb 07 17:12:00 heisenberg kernel: ---[ end trace 0000000000000000 ]---
Feb 07 17:12:32 heisenberg kernel: ------------[ cut here ]------------
Feb 07 17:12:32 heisenberg kernel: WARNING: CPU: 10 PID: 157101 at fs/btrfs=
/transaction.c:144 btrfs_put_transaction+0x141/0x180 [btrfs]
Feb 07 17:12:32 heisenberg kernel: Modules linked in: cpuid ext4 mbcache jb=
d2 sg uas nft_fib_ipv6 nft_ct nft_fib_ipv4 nft_fib wireguard libcurve25519 =
libchacha20poly1305 libchacha ip6_udp_tunnel udp_tunnel libpoly1305 cmac cc=
m snd_seq_dummy snd_hrtimer snd_seq snd_ctl_led snd_soc_skl_hda_dsp snd_soc=
_intel_sof_board_helpers snd_sof_probes snd_soc_intel_hda_dsp_common xe snd=
_hda_codec_intelhdmi snd_hda_codec_alc269 snd_hda_scodec_component drm_gpuv=
m snd_hda_codec_realtek_lib drm_gpusvm_helper snd_hda_codec_generic gpu_sch=
ed snd_soc_dmic drm_ttm_helper drm_exec drm_suballoc_helper ip6t_REJECT nf_=
reject_ipv6 ipt_REJECT nf_reject_ipv4 snd_hda_intel xt_tcpudp snd_sof_pci_i=
ntel_tgl xt_conntrack snd_sof_pci_intel_cnl nf_conntrack snd_sof_intel_hda_=
generic nf_defrag_ipv6 soundwire_intel nf_defrag_ipv4 snd_sof_intel_hda_sdw=
_bpt nft_compat nf_tables snd_sof_intel_hda_common intel_uncore_frequency j=
oydev intel_uncore_frequency_common binfmt_misc x_tables snd_soc_hdac_hda x=
86_pkg_temp_thermal snd_sof_intel_hda_mlink intel_powerclamp snd_sof_intel_=
hda
Feb 07 17:12:32 heisenberg kernel:  i915 snd_hda_codec_hdmi soundwire_caden=
ce snd_sof_pci coretemp snd_sof_xtensa_dsp snd_sof kvm_intel snd_sof_utils =
snd_soc_acpi_intel_match snd_soc_acpi_intel_sdca_quirks soundwire_generic_a=
llocation kvm snd_soc_acpi hid_multitouch crc8 soundwire_bus iwlmvm snd_soc=
_sdca snd_soc_avs btusb uvcvideo btmtk irqbypass snd_soc_hda_codec btrtl vi=
deobuf2_vmalloc ghash_clmulni_intel drm_buddy btbcm snd_hda_ext_core uvc hi=
d_generic snd_hda_codec btintel iTCO_wdt rapl videobuf2_memops ttm sdhci_pc=
i snd_usb_audio intel_pmc_bxt processor_thermal_device_pci mac80211 intel_r=
apl_msr videobuf2_v4l2 snd_hda_core sdhci_uhs2 drm_display_helper bluetooth=
 intel_cstate iTCO_vendor_support snd_usbmidi_lib videodev processor_therma=
l_device sdhci snd_intel_dspcfg processor_thermal_wt_hint platform_temperat=
ure_control snd_rawmidi cec videobuf2_common snd_intel_sdw_acpi cqhci proce=
ssor_thermal_soc_slider snd_seq_device snd_hwdep mei_hdcp watchdog mei_pxp =
ee1004 wmi_bmof usbhid mc ecdh_generic libarc4 intel_uncore crc16 intel_pmc=
_core
Feb 07 17:12:32 heisenberg kernel:  mmc_core snd_soc_core rc_core platform_=
profile pmt_telemetry snd_compress ucsi_acpi processor_thermal_rfim drm_cli=
ent_lib snd_pcm_dmaengine processor_thermal_rapl typec_ucsi iwlwifi pmt_dis=
covery drm_kms_helper snd_pcm i2c_hid_acpi intel_rapl_common typec pmt_clas=
s i2c_hid i2c_algo_bit int3400_thermal hid roles fujitsu_laptop intel_pmc_s=
sram_telemetry acpi_thermal_rel acpi_pad acpi_tad cfg80211 battery button v=
ideo processor_thermal_wt_req i2c_i801 snd_timer processor_thermal_power_fl=
oor i2c_smbus mei_me snd intel_lpss_pci processor_thermal_mbox soundcore in=
tel_lpss mei rfkill wmi idma64 intel_vsec ac int340x_thermal_zone igen6_eda=
c parport_pc lp ppdev drm parport efi_pstore configfs nfnetlink autofs4 crc=
32c_cryptoapi sd_mod dm_crypt dm_mod raid10 raid456 async_raid6_recov async=
_memcpy async_pq async_xor async_tx raid1 raid0 md_mod usb_storage scsi_mod=
 scsi_common btrfs blake2b_generic xor raid6_pq xhci_pci xhci_hcd nvme thun=
derbolt nvme_core usbcore e1000e evdev nvme_keyring nvme_auth serio_raw int=
el_hid
Feb 07 17:12:32 heisenberg kernel:  fan pcspkr aesni_intel usb_common hkdf =
sparse_keymap efivarfs
Feb 07 17:12:32 heisenberg kernel: CPU: 10 UID: 0 PID: 157101 Comm: btrfs-t=
ransacti Tainted: G        W           6.18.8+deb14-amd64 #1 PREEMPT(lazy) =
 Debian 6.18.8-1=20
Feb 07 17:12:32 heisenberg kernel: Tainted: [W]=3DWARN
Feb 07 17:12:32 heisenberg kernel: Hardware name: FUJITSU CLIENT COMPUTING =
LIMITED LIFEBOOK U7512/FJNB2F4, BIOS Version 2.35 07/01/2025
Feb 07 17:12:32 heisenberg kernel: RIP: 0010:btrfs_put_transaction+0x141/0x=
180 [btrfs]
Feb 07 17:12:32 heisenberg kernel: Code: 48 89 ef 5d 41 5c 41 5d e9 8c c3 4=
9 eb 5b be 03 00 00 00 5d 41 5c 41 5d e9 fc 8b 7f eb 0f 0b e9 e2 fe ff ff 0=
f 0b 0f 0b eb d5 <0f> 0b e9 1a ff ff ff 0f 0b e9 21 ff ff ff e8 3c 24 20 eb=
 48 8b 95
Feb 07 17:12:32 heisenberg kernel: RSP: 0018:ffffd1b2ccfa3de0 EFLAGS: 00010=
286
Feb 07 17:12:32 heisenberg kernel: RAX: ffff8dd66b0e4c28 RBX: ffff8dd66b0e4=
c00 RCX: ffff8dd16e1d1488
Feb 07 17:12:32 heisenberg kernel: RDX: ffff8dd66b0e4c28 RSI: ffff8dd66b0e4=
c28 RDI: ffff8dd66b0e4c10
Feb 07 17:12:32 heisenberg kernel: RBP: ffff8dd66b0e4c00 R08: 0000000000000=
000 R09: ffffd1b2ccfa3db0
Feb 07 17:12:32 heisenberg kernel: R10: ffffd1b2ccfa3db0 R11: 0000000000000=
000 R12: ffff8ddf8743bf18
Feb 07 17:12:32 heisenberg kernel: R13: ffff8dd66b0e4c28 R14: ffff8dd16e1d1=
460 R15: 0000000000000000
Feb 07 17:12:32 heisenberg kernel: FS:  0000000000000000(0000) GS:ffff8de10=
124c000(0000) knlGS:0000000000000000
Feb 07 17:12:32 heisenberg kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000=
080050033
Feb 07 17:12:32 heisenberg kernel: CR2: 0000175b6812a000 CR3: 00000003de22c=
002 CR4: 0000000000f72ef0
Feb 07 17:12:32 heisenberg kernel: PKRU: 55555554
Feb 07 17:12:32 heisenberg kernel: Call Trace:
Feb 07 17:12:32 heisenberg kernel:  <TASK>
Feb 07 17:12:32 heisenberg kernel:  btrfs_commit_transaction+0x72a/0xdf0 [b=
trfs]
Feb 07 17:12:32 heisenberg kernel:  ? __pfx_autoremove_wake_function+0x10/0=
x10
Feb 07 17:12:32 heisenberg kernel:  transaction_kthread+0x157/0x1c0 [btrfs]
Feb 07 17:12:32 heisenberg kernel:  ? __pfx_transaction_kthread+0x10/0x10 [=
btrfs]
Feb 07 17:12:32 heisenberg kernel:  kthread+0xfc/0x240
Feb 07 17:12:32 heisenberg kernel:  ? __pfx_kthread+0x10/0x10
Feb 07 17:12:32 heisenberg kernel:  ret_from_fork+0x1cc/0x200
Feb 07 17:12:32 heisenberg kernel:  ? __pfx_kthread+0x10/0x10
Feb 07 17:12:32 heisenberg kernel:  ret_from_fork_asm+0x1a/0x30
Feb 07 17:12:32 heisenberg kernel:  </TASK>
Feb 07 17:12:32 heisenberg kernel: ---[ end trace 0000000000000000 ]---

Feb 07 17:13:02 heisenberg kernel: ------------[ cut here ]------------
Feb 07 17:13:02 heisenberg kernel: WARNING: CPU: 10 PID: 157101 at fs/btrfs=
/transaction.c:144 btrfs_put_transaction+0x141/0x180 [btrfs]
Feb 07 17:13:02 heisenberg kernel: Modules linked in: cpuid ext4 mbcache jb=
d2 sg uas nft_fib_ipv6 nft_ct nft_fib_ipv4 nft_fib wireguard libcurve25519 =
libchacha20poly1305 libchacha ip6_udp_tunnel udp_tunnel libpoly1305 cmac cc=
m snd_seq_dummy snd_hrtimer snd_seq snd_ctl_led snd_soc_skl_hda_dsp snd_soc=
_intel_sof_board_helpers snd_sof_probes snd_soc_intel_hda_dsp_common xe snd=
_hda_codec_intelhdmi snd_hda_codec_alc269 snd_hda_scodec_component drm_gpuv=
m snd_hda_codec_realtek_lib drm_gpusvm_helper snd_hda_codec_generic gpu_sch=
ed snd_soc_dmic drm_ttm_helper drm_exec drm_suballoc_helper ip6t_REJECT nf_=
reject_ipv6 ipt_REJECT nf_reject_ipv4 snd_hda_intel xt_tcpudp snd_sof_pci_i=
ntel_tgl xt_conntrack snd_sof_pci_intel_cnl nf_conntrack snd_sof_intel_hda_=
generic nf_defrag_ipv6 soundwire_intel nf_defrag_ipv4 snd_sof_intel_hda_sdw=
_bpt nft_compat nf_tables snd_sof_intel_hda_common intel_uncore_frequency j=
oydev intel_uncore_frequency_common binfmt_misc x_tables snd_soc_hdac_hda x=
86_pkg_temp_thermal snd_sof_intel_hda_mlink intel_powerclamp snd_sof_intel_=
hda
Feb 07 17:13:02 heisenberg kernel:  i915 snd_hda_codec_hdmi soundwire_caden=
ce snd_sof_pci coretemp snd_sof_xtensa_dsp snd_sof kvm_intel snd_sof_utils =
snd_soc_acpi_intel_match snd_soc_acpi_intel_sdca_quirks soundwire_generic_a=
llocation kvm snd_soc_acpi hid_multitouch crc8 soundwire_bus iwlmvm snd_soc=
_sdca snd_soc_avs btusb uvcvideo btmtk irqbypass snd_soc_hda_codec btrtl vi=
deobuf2_vmalloc ghash_clmulni_intel drm_buddy btbcm snd_hda_ext_core uvc hi=
d_generic snd_hda_codec btintel iTCO_wdt rapl videobuf2_memops ttm sdhci_pc=
i snd_usb_audio intel_pmc_bxt processor_thermal_device_pci mac80211 intel_r=
apl_msr videobuf2_v4l2 snd_hda_core sdhci_uhs2 drm_display_helper bluetooth=
 intel_cstate iTCO_vendor_support snd_usbmidi_lib videodev processor_therma=
l_device sdhci snd_intel_dspcfg processor_thermal_wt_hint platform_temperat=
ure_control snd_rawmidi cec videobuf2_common snd_intel_sdw_acpi cqhci proce=
ssor_thermal_soc_slider snd_seq_device snd_hwdep mei_hdcp watchdog mei_pxp =
ee1004 wmi_bmof usbhid mc ecdh_generic libarc4 intel_uncore crc16 intel_pmc=
_core
Feb 07 17:13:02 heisenberg kernel:  mmc_core snd_soc_core rc_core platform_=
profile pmt_telemetry snd_compress ucsi_acpi processor_thermal_rfim drm_cli=
ent_lib snd_pcm_dmaengine processor_thermal_rapl typec_ucsi iwlwifi pmt_dis=
covery drm_kms_helper snd_pcm i2c_hid_acpi intel_rapl_common typec pmt_clas=
s i2c_hid i2c_algo_bit int3400_thermal hid roles fujitsu_laptop intel_pmc_s=
sram_telemetry acpi_thermal_rel acpi_pad acpi_tad cfg80211 battery button v=
ideo processor_thermal_wt_req i2c_i801 snd_timer processor_thermal_power_fl=
oor i2c_smbus mei_me snd intel_lpss_pci processor_thermal_mbox soundcore in=
tel_lpss mei rfkill wmi idma64 intel_vsec ac int340x_thermal_zone igen6_eda=
c parport_pc lp ppdev drm parport efi_pstore configfs nfnetlink autofs4 crc=
32c_cryptoapi sd_mod dm_crypt dm_mod raid10 raid456 async_raid6_recov async=
_memcpy async_pq async_xor async_tx raid1 raid0 md_mod usb_storage scsi_mod=
 scsi_common btrfs blake2b_generic xor raid6_pq xhci_pci xhci_hcd nvme thun=
derbolt nvme_core usbcore e1000e evdev nvme_keyring nvme_auth serio_raw int=
el_hid
Feb 07 17:13:02 heisenberg kernel:  fan pcspkr aesni_intel usb_common hkdf =
sparse_keymap efivarfs
Feb 07 17:13:02 heisenberg kernel: CPU: 10 UID: 0 PID: 157101 Comm: btrfs-t=
ransacti Tainted: G        W           6.18.8+deb14-amd64 #1 PREEMPT(lazy) =
 Debian 6.18.8-1=20
Feb 07 17:13:02 heisenberg kernel: Tainted: [W]=3DWARN
Feb 07 17:13:02 heisenberg kernel: Hardware name: FUJITSU CLIENT COMPUTING =
LIMITED LIFEBOOK U7512/FJNB2F4, BIOS Version 2.35 07/01/2025
Feb 07 17:13:02 heisenberg kernel: RIP: 0010:btrfs_put_transaction+0x141/0x=
180 [btrfs]
Feb 07 17:13:02 heisenberg kernel: Code: 48 89 ef 5d 41 5c 41 5d e9 8c c3 4=
9 eb 5b be 03 00 00 00 5d 41 5c 41 5d e9 fc 8b 7f eb 0f 0b e9 e2 fe ff ff 0=
f 0b 0f 0b eb d5 <0f> 0b e9 1a ff ff ff 0f 0b e9 21 ff ff ff e8 3c 24 20 eb=
 48 8b 95
Feb 07 17:13:02 heisenberg kernel: RSP: 0018:ffffd1b2ccfa3de0 EFLAGS: 00010=
282
Feb 07 17:13:02 heisenberg kernel: RAX: ffff8dd282d69e28 RBX: ffff8dd282d69=
e00 RCX: ffff8dd16e1d1488
Feb 07 17:13:02 heisenberg kernel: RDX: ffff8dd282d69e28 RSI: ffff8dd282d69=
e28 RDI: ffff8dd282d69e10
Feb 07 17:13:02 heisenberg kernel: RBP: ffff8dd282d69e00 R08: 0000000000000=
000 R09: ffffd1b2ccfa3db0
Feb 07 17:13:02 heisenberg kernel: R10: ffffd1b2ccfa3db0 R11: 0000000000000=
000 R12: ffff8ddf8743bf18
Feb 07 17:13:02 heisenberg kernel: R13: ffff8dd282d69e28 R14: ffff8dd16e1d1=
460 R15: 0000000000000000
Feb 07 17:13:02 heisenberg kernel: FS:  0000000000000000(0000) GS:ffff8de10=
124c000(0000) knlGS:0000000000000000
Feb 07 17:13:02 heisenberg kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000=
080050033
Feb 07 17:13:02 heisenberg kernel: CR2: 00001d6aa4397fe0 CR3: 00000003de22c=
003 CR4: 0000000000f72ef0
Feb 07 17:13:02 heisenberg kernel: PKRU: 55555554
Feb 07 17:13:02 heisenberg kernel: Call Trace:
Feb 07 17:13:02 heisenberg kernel:  <TASK>
Feb 07 17:13:02 heisenberg kernel:  btrfs_commit_transaction+0x72a/0xdf0 [b=
trfs]
Feb 07 17:13:02 heisenberg kernel:  ? __pfx_autoremove_wake_function+0x10/0=
x10
Feb 07 17:13:02 heisenberg kernel:  transaction_kthread+0x157/0x1c0 [btrfs]
Feb 07 17:13:02 heisenberg kernel:  ? __pfx_transaction_kthread+0x10/0x10 [=
btrfs]
Feb 07 17:13:02 heisenberg kernel:  kthread+0xfc/0x240
Feb 07 17:13:02 heisenberg kernel:  ? __pfx_kthread+0x10/0x10
Feb 07 17:13:02 heisenberg kernel:  ret_from_fork+0x1cc/0x200
Feb 07 17:13:02 heisenberg kernel:  ? __pfx_kthread+0x10/0x10
Feb 07 17:13:02 heisenberg kernel:  ret_from_fork_asm+0x1a/0x30
Feb 07 17:13:02 heisenberg kernel:  </TASK>
Feb 07 17:13:02 heisenberg kernel: ---[ end trace 0000000000000000 ]---
Feb 07 17:13:33 heisenberg kernel: ------------[ cut here ]------------
Feb 07 17:13:33 heisenberg kernel: WARNING: CPU: 10 PID: 157101 at fs/btrfs=
/transaction.c:144 btrfs_put_transaction+0x141/0x180 [btrfs]
Feb 07 17:13:33 heisenberg kernel: Modules linked in: cpuid ext4 mbcache jb=
d2 sg uas nft_fib_ipv6 nft_ct nft_fib_ipv4 nft_fib wireguard libcurve25519 =
libchacha20poly1305 libchacha ip6_udp_tunnel udp_tunnel libpoly1305 cmac cc=
m snd_seq_dummy snd_hrtimer snd_seq snd_ctl_led snd_soc_skl_hda_dsp snd_soc=
_intel_sof_board_helpers snd_sof_probes snd_soc_intel_hda_dsp_common xe snd=
_hda_codec_intelhdmi snd_hda_codec_alc269 snd_hda_scodec_component drm_gpuv=
m snd_hda_codec_realtek_lib drm_gpusvm_helper snd_hda_codec_generic gpu_sch=
ed snd_soc_dmic drm_ttm_helper drm_exec drm_suballoc_helper ip6t_REJECT nf_=
reject_ipv6 ipt_REJECT nf_reject_ipv4 snd_hda_intel xt_tcpudp snd_sof_pci_i=
ntel_tgl xt_conntrack snd_sof_pci_intel_cnl nf_conntrack snd_sof_intel_hda_=
generic nf_defrag_ipv6 soundwire_intel nf_defrag_ipv4 snd_sof_intel_hda_sdw=
_bpt nft_compat nf_tables snd_sof_intel_hda_common intel_uncore_frequency j=
oydev intel_uncore_frequency_common binfmt_misc x_tables snd_soc_hdac_hda x=
86_pkg_temp_thermal snd_sof_intel_hda_mlink intel_powerclamp snd_sof_intel_=
hda
Feb 07 17:13:33 heisenberg kernel:  i915 snd_hda_codec_hdmi soundwire_caden=
ce snd_sof_pci coretemp snd_sof_xtensa_dsp snd_sof kvm_intel snd_sof_utils =
snd_soc_acpi_intel_match snd_soc_acpi_intel_sdca_quirks soundwire_generic_a=
llocation kvm snd_soc_acpi hid_multitouch crc8 soundwire_bus iwlmvm snd_soc=
_sdca snd_soc_avs btusb uvcvideo btmtk irqbypass snd_soc_hda_codec btrtl vi=
deobuf2_vmalloc ghash_clmulni_intel drm_buddy btbcm snd_hda_ext_core uvc hi=
d_generic snd_hda_codec btintel iTCO_wdt rapl videobuf2_memops ttm sdhci_pc=
i snd_usb_audio intel_pmc_bxt processor_thermal_device_pci mac80211 intel_r=
apl_msr videobuf2_v4l2 snd_hda_core sdhci_uhs2 drm_display_helper bluetooth=
 intel_cstate iTCO_vendor_support snd_usbmidi_lib videodev processor_therma=
l_device sdhci snd_intel_dspcfg processor_thermal_wt_hint platform_temperat=
ure_control snd_rawmidi cec videobuf2_common snd_intel_sdw_acpi cqhci proce=
ssor_thermal_soc_slider snd_seq_device snd_hwdep mei_hdcp watchdog mei_pxp =
ee1004 wmi_bmof usbhid mc ecdh_generic libarc4 intel_uncore crc16 intel_pmc=
_core
Feb 07 17:13:33 heisenberg kernel:  mmc_core snd_soc_core rc_core platform_=
profile pmt_telemetry snd_compress ucsi_acpi processor_thermal_rfim drm_cli=
ent_lib snd_pcm_dmaengine processor_thermal_rapl typec_ucsi iwlwifi pmt_dis=
covery drm_kms_helper snd_pcm i2c_hid_acpi intel_rapl_common typec pmt_clas=
s i2c_hid i2c_algo_bit int3400_thermal hid roles fujitsu_laptop intel_pmc_s=
sram_telemetry acpi_thermal_rel acpi_pad acpi_tad cfg80211 battery button v=
ideo processor_thermal_wt_req i2c_i801 snd_timer processor_thermal_power_fl=
oor i2c_smbus mei_me snd intel_lpss_pci processor_thermal_mbox soundcore in=
tel_lpss mei rfkill wmi idma64 intel_vsec ac int340x_thermal_zone igen6_eda=
c parport_pc lp ppdev drm parport efi_pstore configfs nfnetlink autofs4 crc=
32c_cryptoapi sd_mod dm_crypt dm_mod raid10 raid456 async_raid6_recov async=
_memcpy async_pq async_xor async_tx raid1 raid0 md_mod usb_storage scsi_mod=
 scsi_common btrfs blake2b_generic xor raid6_pq xhci_pci xhci_hcd nvme thun=
derbolt nvme_core usbcore e1000e evdev nvme_keyring nvme_auth serio_raw int=
el_hid
Feb 07 17:13:33 heisenberg kernel:  fan pcspkr aesni_intel usb_common hkdf =
sparse_keymap efivarfs
Feb 07 17:13:33 heisenberg kernel: CPU: 10 UID: 0 PID: 157101 Comm: btrfs-t=
ransacti Tainted: G        W           6.18.8+deb14-amd64 #1 PREEMPT(lazy) =
 Debian 6.18.8-1=20
Feb 07 17:13:33 heisenberg kernel: Tainted: [W]=3DWARN
Feb 07 17:13:33 heisenberg kernel: Hardware name: FUJITSU CLIENT COMPUTING =
LIMITED LIFEBOOK U7512/FJNB2F4, BIOS Version 2.35 07/01/2025
Feb 07 17:13:33 heisenberg kernel: RIP: 0010:btrfs_put_transaction+0x141/0x=
180 [btrfs]
Feb 07 17:13:33 heisenberg kernel: Code: 48 89 ef 5d 41 5c 41 5d e9 8c c3 4=
9 eb 5b be 03 00 00 00 5d 41 5c 41 5d e9 fc 8b 7f eb 0f 0b e9 e2 fe ff ff 0=
f 0b 0f 0b eb d5 <0f> 0b e9 1a ff ff ff 0f 0b e9 21 ff ff ff e8 3c 24 20 eb=
 48 8b 95
Feb 07 17:13:33 heisenberg kernel: RSP: 0000:ffffd1b2ccfa3de0 EFLAGS: 00010=
282
Feb 07 17:13:33 heisenberg kernel: RAX: ffff8ddb24c54a28 RBX: ffff8ddb24c54=
a00 RCX: ffff8dd16e1d1488
Feb 07 17:13:33 heisenberg kernel: RDX: ffff8ddb24c54a28 RSI: ffff8ddb24c54=
a28 RDI: ffff8ddb24c54a10
Feb 07 17:13:33 heisenberg kernel: RBP: ffff8ddb24c54a00 R08: 0000000000000=
000 R09: ffffd1b2ccfa3db0
Feb 07 17:13:33 heisenberg kernel: R10: ffffd1b2ccfa3db0 R11: 0000000000000=
000 R12: ffff8ddf8743bf18
Feb 07 17:13:33 heisenberg kernel: R13: ffff8ddb24c54a28 R14: ffff8dd16e1d1=
460 R15: 0000000000000000
Feb 07 17:13:33 heisenberg kernel: FS:  0000000000000000(0000) GS:ffff8de10=
124c000(0000) knlGS:0000000000000000
Feb 07 17:13:33 heisenberg kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000=
080050033
Feb 07 17:13:33 heisenberg kernel: CR2: 00000aabee386004 CR3: 00000003de22c=
004 CR4: 0000000000f72ef0
Feb 07 17:13:33 heisenberg kernel: PKRU: 55555554
Feb 07 17:13:33 heisenberg kernel: Call Trace:
Feb 07 17:13:33 heisenberg kernel:  <TASK>
Feb 07 17:13:33 heisenberg kernel:  btrfs_commit_transaction+0x72a/0xdf0 [b=
trfs]
Feb 07 17:13:33 heisenberg kernel:  ? __pfx_autoremove_wake_function+0x10/0=
x10
Feb 07 17:13:33 heisenberg kernel:  transaction_kthread+0x157/0x1c0 [btrfs]
Feb 07 17:13:33 heisenberg kernel:  ? __pfx_transaction_kthread+0x10/0x10 [=
btrfs]
Feb 07 17:13:33 heisenberg kernel:  kthread+0xfc/0x240
Feb 07 17:13:33 heisenberg kernel:  ? __pfx_kthread+0x10/0x10
Feb 07 17:13:33 heisenberg kernel:  ret_from_fork+0x1cc/0x200
Feb 07 17:13:33 heisenberg kernel:  ? __pfx_kthread+0x10/0x10
Feb 07 17:13:33 heisenberg kernel:  ret_from_fork_asm+0x1a/0x30
Feb 07 17:13:33 heisenberg kernel:  </TASK>
Feb 07 17:13:33 heisenberg kernel: ---[ end trace 0000000000000000 ]---
Feb 07 17:14:04 heisenberg kernel: ------------[ cut here ]------------
Feb 07 17:14:04 heisenberg kernel: WARNING: CPU: 13 PID: 157101 at fs/btrfs=
/transaction.c:144 btrfs_put_transaction+0x141/0x180 [btrfs]
Feb 07 17:14:04 heisenberg kernel: Modules linked in: cpuid ext4 mbcache jb=
d2 sg uas nft_fib_ipv6 nft_ct nft_fib_ipv4 nft_fib wireguard libcurve25519 =
libchacha20poly1305 libchacha ip6_udp_tunnel udp_tunnel libpoly1305 cmac cc=
m snd_seq_dummy snd_hrtimer snd_seq snd_ctl_led snd_soc_skl_hda_dsp snd_soc=
_intel_sof_board_helpers snd_sof_probes snd_soc_intel_hda_dsp_common xe snd=
_hda_codec_intelhdmi snd_hda_codec_alc269 snd_hda_scodec_component drm_gpuv=
m snd_hda_codec_realtek_lib drm_gpusvm_helper snd_hda_codec_generic gpu_sch=
ed snd_soc_dmic drm_ttm_helper drm_exec drm_suballoc_helper ip6t_REJECT nf_=
reject_ipv6 ipt_REJECT nf_reject_ipv4 snd_hda_intel xt_tcpudp snd_sof_pci_i=
ntel_tgl xt_conntrack snd_sof_pci_intel_cnl nf_conntrack snd_sof_intel_hda_=
generic nf_defrag_ipv6 soundwire_intel nf_defrag_ipv4 snd_sof_intel_hda_sdw=
_bpt nft_compat nf_tables snd_sof_intel_hda_common intel_uncore_frequency j=
oydev intel_uncore_frequency_common binfmt_misc x_tables snd_soc_hdac_hda x=
86_pkg_temp_thermal snd_sof_intel_hda_mlink intel_powerclamp snd_sof_intel_=
hda
Feb 07 17:14:04 heisenberg kernel:  i915 snd_hda_codec_hdmi soundwire_caden=
ce snd_sof_pci coretemp snd_sof_xtensa_dsp snd_sof kvm_intel snd_sof_utils =
snd_soc_acpi_intel_match snd_soc_acpi_intel_sdca_quirks soundwire_generic_a=
llocation kvm snd_soc_acpi hid_multitouch crc8 soundwire_bus iwlmvm snd_soc=
_sdca snd_soc_avs btusb uvcvideo btmtk irqbypass snd_soc_hda_codec btrtl vi=
deobuf2_vmalloc ghash_clmulni_intel drm_buddy btbcm snd_hda_ext_core uvc hi=
d_generic snd_hda_codec btintel iTCO_wdt rapl videobuf2_memops ttm sdhci_pc=
i snd_usb_audio intel_pmc_bxt processor_thermal_device_pci mac80211 intel_r=
apl_msr videobuf2_v4l2 snd_hda_core sdhci_uhs2 drm_display_helper bluetooth=
 intel_cstate iTCO_vendor_support snd_usbmidi_lib videodev processor_therma=
l_device sdhci snd_intel_dspcfg processor_thermal_wt_hint platform_temperat=
ure_control snd_rawmidi cec videobuf2_common snd_intel_sdw_acpi cqhci proce=
ssor_thermal_soc_slider snd_seq_device snd_hwdep mei_hdcp watchdog mei_pxp =
ee1004 wmi_bmof usbhid mc ecdh_generic libarc4 intel_uncore crc16 intel_pmc=
_core
Feb 07 17:14:04 heisenberg kernel:  mmc_core snd_soc_core rc_core platform_=
profile pmt_telemetry snd_compress ucsi_acpi processor_thermal_rfim drm_cli=
ent_lib snd_pcm_dmaengine processor_thermal_rapl typec_ucsi iwlwifi pmt_dis=
covery drm_kms_helper snd_pcm i2c_hid_acpi intel_rapl_common typec pmt_clas=
s i2c_hid i2c_algo_bit int3400_thermal hid roles fujitsu_laptop intel_pmc_s=
sram_telemetry acpi_thermal_rel acpi_pad acpi_tad cfg80211 battery button v=
ideo processor_thermal_wt_req i2c_i801 snd_timer processor_thermal_power_fl=
oor i2c_smbus mei_me snd intel_lpss_pci processor_thermal_mbox soundcore in=
tel_lpss mei rfkill wmi idma64 intel_vsec ac int340x_thermal_zone igen6_eda=
c parport_pc lp ppdev drm parport efi_pstore configfs nfnetlink autofs4 crc=
32c_cryptoapi sd_mod dm_crypt dm_mod raid10 raid456 async_raid6_recov async=
_memcpy async_pq async_xor async_tx raid1 raid0 md_mod usb_storage scsi_mod=
 scsi_common btrfs blake2b_generic xor raid6_pq xhci_pci xhci_hcd nvme thun=
derbolt nvme_core usbcore e1000e evdev nvme_keyring nvme_auth serio_raw int=
el_hid
Feb 07 17:14:04 heisenberg kernel:  fan pcspkr aesni_intel usb_common hkdf =
sparse_keymap efivarfs
Feb 07 17:14:04 heisenberg kernel: CPU: 13 UID: 0 PID: 157101 Comm: btrfs-t=
ransacti Tainted: G        W           6.18.8+deb14-amd64 #1 PREEMPT(lazy) =
 Debian 6.18.8-1=20
Feb 07 17:14:04 heisenberg kernel: Tainted: [W]=3DWARN
Feb 07 17:14:04 heisenberg kernel: Hardware name: FUJITSU CLIENT COMPUTING =
LIMITED LIFEBOOK U7512/FJNB2F4, BIOS Version 2.35 07/01/2025
Feb 07 17:14:04 heisenberg kernel: RIP: 0010:btrfs_put_transaction+0x141/0x=
180 [btrfs]
Feb 07 17:14:04 heisenberg kernel: Code: 48 89 ef 5d 41 5c 41 5d e9 8c c3 4=
9 eb 5b be 03 00 00 00 5d 41 5c 41 5d e9 fc 8b 7f eb 0f 0b e9 e2 fe ff ff 0=
f 0b 0f 0b eb d5 <0f> 0b e9 1a ff ff ff 0f 0b e9 21 ff ff ff e8 3c 24 20 eb=
 48 8b 95
Feb 07 17:14:04 heisenberg kernel: RSP: 0018:ffffd1b2ccfa3de0 EFLAGS: 00010=
282
Feb 07 17:14:04 heisenberg kernel: RAX: ffff8dd82eda0828 RBX: ffff8dd82eda0=
800 RCX: ffff8dd16e1d1488
Feb 07 17:14:04 heisenberg kernel: RDX: ffff8dd82eda0828 RSI: ffff8dd82eda0=
828 RDI: ffff8dd82eda0810
Feb 07 17:14:04 heisenberg kernel: RBP: ffff8dd82eda0800 R08: 0000000000000=
000 R09: ffffd1b2ccfa3db0
Feb 07 17:14:04 heisenberg kernel: R10: ffffd1b2ccfa3db0 R11: 0000000000000=
000 R12: ffff8ddf8743bf18
Feb 07 17:14:04 heisenberg kernel: R13: ffff8dd82eda0828 R14: ffff8dd16e1d1=
460 R15: 0000000000000000
Feb 07 17:14:04 heisenberg kernel: FS:  0000000000000000(0000) GS:ffff8de10=
130c000(0000) knlGS:0000000000000000
Feb 07 17:14:04 heisenberg kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000=
080050033
Feb 07 17:14:04 heisenberg kernel: CR2: 00007fd7ae106020 CR3: 00000003de22c=
004 CR4: 0000000000f72ef0
Feb 07 17:14:04 heisenberg kernel: PKRU: 55555554
Feb 07 17:14:04 heisenberg kernel: Call Trace:
Feb 07 17:14:04 heisenberg kernel:  <TASK>
Feb 07 17:14:04 heisenberg kernel:  btrfs_commit_transaction+0x72a/0xdf0 [b=
trfs]
Feb 07 17:14:04 heisenberg kernel:  ? __pfx_autoremove_wake_function+0x10/0=
x10
Feb 07 17:14:04 heisenberg kernel:  transaction_kthread+0x157/0x1c0 [btrfs]
Feb 07 17:14:04 heisenberg kernel:  ? __pfx_transaction_kthread+0x10/0x10 [=
btrfs]
Feb 07 17:14:04 heisenberg kernel:  kthread+0xfc/0x240
Feb 07 17:14:04 heisenberg kernel:  ? __pfx_kthread+0x10/0x10
Feb 07 17:14:04 heisenberg kernel:  ret_from_fork+0x1cc/0x200
Feb 07 17:14:04 heisenberg kernel:  ? __pfx_kthread+0x10/0x10
Feb 07 17:14:04 heisenberg kernel:  ret_from_fork_asm+0x1a/0x30
Feb 07 17:14:04 heisenberg kernel:  </TASK>
Feb 07 17:14:04 heisenberg kernel: ---[ end trace 0000000000000000 ]---
Feb 07 17:14:14 heisenberg kernel: ------------[ cut here ]------------
Feb 07 17:14:14 heisenberg kernel: WARNING: CPU: 4 PID: 157055 at fs/btrfs/=
extent-tree.c:3230 __btrfs_free_extent.isra.0+0x7ac/0x1010 [btrfs]
Feb 07 17:14:14 heisenberg kernel: Modules linked in: cpuid ext4 mbcache jb=
d2 sg uas nft_fib_ipv6 nft_ct nft_fib_ipv4 nft_fib wireguard libcurve25519 =
libchacha20poly1305 libchacha ip6_udp_tunnel udp_tunnel libpoly1305 cmac cc=
m snd_seq_dummy snd_hrtimer snd_seq snd_ctl_led snd_soc_skl_hda_dsp snd_soc=
_intel_sof_board_helpers snd_sof_probes snd_soc_intel_hda_dsp_common xe snd=
_hda_codec_intelhdmi snd_hda_codec_alc269 snd_hda_scodec_component drm_gpuv=
m snd_hda_codec_realtek_lib drm_gpusvm_helper snd_hda_codec_generic gpu_sch=
ed snd_soc_dmic drm_ttm_helper drm_exec drm_suballoc_helper ip6t_REJECT nf_=
reject_ipv6 ipt_REJECT nf_reject_ipv4 snd_hda_intel xt_tcpudp snd_sof_pci_i=
ntel_tgl xt_conntrack snd_sof_pci_intel_cnl nf_conntrack snd_sof_intel_hda_=
generic nf_defrag_ipv6 soundwire_intel nf_defrag_ipv4 snd_sof_intel_hda_sdw=
_bpt nft_compat nf_tables snd_sof_intel_hda_common intel_uncore_frequency j=
oydev intel_uncore_frequency_common binfmt_misc x_tables snd_soc_hdac_hda x=
86_pkg_temp_thermal snd_sof_intel_hda_mlink intel_powerclamp snd_sof_intel_=
hda
Feb 07 17:14:14 heisenberg kernel:  i915 snd_hda_codec_hdmi soundwire_caden=
ce snd_sof_pci coretemp snd_sof_xtensa_dsp snd_sof kvm_intel snd_sof_utils =
snd_soc_acpi_intel_match snd_soc_acpi_intel_sdca_quirks soundwire_generic_a=
llocation kvm snd_soc_acpi hid_multitouch crc8 soundwire_bus iwlmvm snd_soc=
_sdca snd_soc_avs btusb uvcvideo btmtk irqbypass snd_soc_hda_codec btrtl vi=
deobuf2_vmalloc ghash_clmulni_intel drm_buddy btbcm snd_hda_ext_core uvc hi=
d_generic snd_hda_codec btintel iTCO_wdt rapl videobuf2_memops ttm sdhci_pc=
i snd_usb_audio intel_pmc_bxt processor_thermal_device_pci mac80211 intel_r=
apl_msr videobuf2_v4l2 snd_hda_core sdhci_uhs2 drm_display_helper bluetooth=
 intel_cstate iTCO_vendor_support snd_usbmidi_lib videodev processor_therma=
l_device sdhci snd_intel_dspcfg processor_thermal_wt_hint platform_temperat=
ure_control snd_rawmidi cec videobuf2_common snd_intel_sdw_acpi cqhci proce=
ssor_thermal_soc_slider snd_seq_device snd_hwdep mei_hdcp watchdog mei_pxp =
ee1004 wmi_bmof usbhid mc ecdh_generic libarc4 intel_uncore crc16 intel_pmc=
_core
Feb 07 17:14:14 heisenberg kernel:  mmc_core snd_soc_core rc_core platform_=
profile pmt_telemetry snd_compress ucsi_acpi processor_thermal_rfim drm_cli=
ent_lib snd_pcm_dmaengine processor_thermal_rapl typec_ucsi iwlwifi pmt_dis=
covery drm_kms_helper snd_pcm i2c_hid_acpi intel_rapl_common typec pmt_clas=
s i2c_hid i2c_algo_bit int3400_thermal hid roles fujitsu_laptop intel_pmc_s=
sram_telemetry acpi_thermal_rel acpi_pad acpi_tad cfg80211 battery button v=
ideo processor_thermal_wt_req i2c_i801 snd_timer processor_thermal_power_fl=
oor i2c_smbus mei_me snd intel_lpss_pci processor_thermal_mbox soundcore in=
tel_lpss mei rfkill wmi idma64 intel_vsec ac int340x_thermal_zone igen6_eda=
c parport_pc lp ppdev drm parport efi_pstore configfs nfnetlink autofs4 crc=
32c_cryptoapi sd_mod dm_crypt dm_mod raid10 raid456 async_raid6_recov async=
_memcpy async_pq async_xor async_tx raid1 raid0 md_mod usb_storage scsi_mod=
 scsi_common btrfs blake2b_generic xor raid6_pq xhci_pci xhci_hcd nvme thun=
derbolt nvme_core usbcore e1000e evdev nvme_keyring nvme_auth serio_raw int=
el_hid
Feb 07 17:14:14 heisenberg kernel:  fan pcspkr aesni_intel usb_common hkdf =
sparse_keymap efivarfs
Feb 07 17:14:14 heisenberg kernel: CPU: 4 UID: 0 PID: 157055 Comm: mount Ta=
inted: G        W           6.18.8+deb14-amd64 #1 PREEMPT(lazy)  Debian 6.1=
8.8-1=20
Feb 07 17:14:14 heisenberg kernel: Tainted: [W]=3DWARN
Feb 07 17:14:14 heisenberg kernel: Hardware name: FUJITSU CLIENT COMPUTING =
LIMITED LIFEBOOK U7512/FJNB2F4, BIOS Version 2.35 07/01/2025
Feb 07 17:14:14 heisenberg kernel: RIP: 0010:__btrfs_free_extent.isra.0+0x7=
ac/0x1010 [btrfs]
Feb 07 17:14:14 heisenberg kernel: Code: 00 f0 48 0f ba 28 02 0f 82 72 08 0=
0 00 be 8b ff ff ff 48 c7 c7 68 29 c1 c0 e8 f0 ee 13 eb 0f 0b c6 44 24 2f 0=
1 e9 80 b6 0e 00 <0f> 0b f0 48 0f ba a8 b0 0a 00 00 02 0f 82 fa b3 0e 00 be=
 8b ff ff
Feb 07 17:14:14 heisenberg kernel: RSP: 0018:ffffd1b300ce7680 EFLAGS: 00010=
246
Feb 07 17:14:14 heisenberg kernel: RAX: ffff8dd16e1d1000 RBX: 000000000ef0c=
000 RCX: ffff8de05fd70e00
Feb 07 17:14:14 heisenberg kernel: RDX: 0000000000000000 RSI: 0000000000000=
003 RDI: ffff8de05fd70e00
Feb 07 17:14:14 heisenberg kernel: RBP: 0000000000000000 R08: 0000000000000=
000 R09: 0000000000000001
Feb 07 17:14:14 heisenberg kernel: R10: 0000000000000fff R11: 0000000000000=
002 R12: 0000000000000001
Feb 07 17:14:14 heisenberg kernel: R13: 0000000000000000 R14: ffff8de05fd70=
e00 R15: ffff8dda5f16dd90
Feb 07 17:14:14 heisenberg kernel: FS:  00007f80ecec9840(0000) GS:ffff8de10=
10cc000(0000) knlGS:0000000000000000
Feb 07 17:14:14 heisenberg kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000=
080050033
Feb 07 17:14:14 heisenberg kernel: CR2: 00007f2584823f80 CR3: 0000000e03722=
004 CR4: 0000000000f72ef0
Feb 07 17:14:14 heisenberg kernel: PKRU: 55555554
Feb 07 17:14:14 heisenberg kernel: Call Trace:
Feb 07 17:14:14 heisenberg kernel:  <TASK>
Feb 07 17:14:14 heisenberg kernel:  ? btrfs_merge_delayed_refs+0x1bb/0x290 =
[btrfs]
Feb 07 17:14:14 heisenberg kernel:  __btrfs_run_delayed_refs+0x2dc/0xf70 [b=
trfs]
Feb 07 17:14:14 heisenberg kernel:  ? setup_items_for_insert.isra.0+0x196/0=
x420 [btrfs]
Feb 07 17:14:14 heisenberg kernel:  ? release_extent_buffer+0x33/0x120 [btr=
fs]
Feb 07 17:14:14 heisenberg kernel:  ? __btrfs_add_to_free_space_tree+0x294/=
0x3f0 [btrfs]
Feb 07 17:14:14 heisenberg kernel:  btrfs_run_delayed_refs+0x3b/0x120 [btrf=
s]
Feb 07 17:14:14 heisenberg kernel:  btrfs_commit_transaction+0x6d/0xdf0 [bt=
rfs]
Feb 07 17:14:14 heisenberg kernel:  ? populate_free_space_tree+0x89/0x220 [=
btrfs]
Feb 07 17:14:14 heisenberg kernel:  btrfs_rebuild_free_space_tree+0x1c5/0x2=
70 [btrfs]
Feb 07 17:14:14 heisenberg kernel:  btrfs_start_pre_rw_mount+0x2df/0x610 [b=
trfs]
Feb 07 17:14:14 heisenberg kernel:  ? btrfs_get_root_ref+0x2a7/0x3b0 [btrfs=
]
Feb 07 17:14:14 heisenberg kernel:  open_ctree+0x113e/0x15a0 [btrfs]
Feb 07 17:14:14 heisenberg kernel:  btrfs_get_tree.cold+0xb/0xb6 [btrfs]
Feb 07 17:14:14 heisenberg kernel:  ? __fs_parse+0x68/0x1c0
Feb 07 17:14:14 heisenberg kernel:  vfs_get_tree+0x29/0xd0
Feb 07 17:14:14 heisenberg kernel:  vfs_cmd_create+0x57/0xd0
Feb 07 17:14:14 heisenberg kernel:  __do_sys_fsconfig+0x4b6/0x650
Feb 07 17:14:14 heisenberg kernel:  do_syscall_64+0x81/0x7f0
Feb 07 17:14:14 heisenberg kernel:  ? rw_verify_area+0x56/0x180
Feb 07 17:14:14 heisenberg kernel:  ? vfs_read+0xbf/0x390
Feb 07 17:14:14 heisenberg kernel:  ? fscontext_read+0x16a/0x180
Feb 07 17:14:14 heisenberg kernel:  ? rw_verify_area+0x56/0x180
Feb 07 17:14:14 heisenberg kernel:  ? fs_param_is_enum+0x53/0xa0
Feb 07 17:14:14 heisenberg kernel:  ? __fs_parse+0xac/0x1c0
Feb 07 17:14:14 heisenberg kernel:  ? ksys_read+0x73/0xf0
Feb 07 17:14:14 heisenberg kernel:  ? do_syscall_64+0xb9/0x7f0
Feb 07 17:14:14 heisenberg kernel:  ? __do_sys_fsconfig+0x359/0x650
Feb 07 17:14:14 heisenberg kernel:  ? do_syscall_64+0xb9/0x7f0
Feb 07 17:14:14 heisenberg kernel:  ? do_faccessat+0x1d7/0x2d0
Feb 07 17:14:14 heisenberg kernel:  ? __x64_sys_access+0x1c/0x30
Feb 07 17:14:14 heisenberg kernel:  ? do_syscall_64+0xb9/0x7f0
Feb 07 17:14:14 heisenberg kernel:  ? do_syscall_64+0xb9/0x7f0
Feb 07 17:14:14 heisenberg kernel:  ? do_syscall_64+0xb9/0x7f0
Feb 07 17:14:14 heisenberg kernel:  ? exc_page_fault+0x7e/0x1a0
Feb 07 17:14:14 heisenberg kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7=
e
Feb 07 17:14:14 heisenberg kernel: RIP: 0033:0x7f80ed0f2a6a
Feb 07 17:14:14 heisenberg kernel: Code: 73 01 c3 48 8b 0d a6 23 0d 00 f7 d=
8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 a=
f 01 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 76 23 0d 00 f7 d8 64=
 89 01 48
Feb 07 17:14:14 heisenberg kernel: RSP: 002b:00007ffee20bd628 EFLAGS: 00000=
246 ORIG_RAX: 00000000000001af
Feb 07 17:14:14 heisenberg kernel: RAX: ffffffffffffffda RBX: 00005607c7efa=
b80 RCX: 00007f80ed0f2a6a
Feb 07 17:14:14 heisenberg kernel: RDX: 0000000000000000 RSI: 0000000000000=
006 RDI: 0000000000000003
Feb 07 17:14:14 heisenberg kernel: RBP: 0000000000000000 R08: 0000000000000=
000 R09: 0000000000000000
Feb 07 17:14:14 heisenberg kernel: R10: 0000000000000000 R11: 0000000000000=
246 R12: 00005607c7efc960
Feb 07 17:14:14 heisenberg kernel: R13: 00007f80ed28026c R14: 00007f80ed27e=
560 R15: 00007f80ed28026c
Feb 07 17:14:14 heisenberg kernel:  </TASK>
Feb 07 17:14:14 heisenberg kernel: ---[ end trace 0000000000000000 ]---
Feb 07 17:14:14 heisenberg kernel: ------------[ cut here ]------------
Feb 07 17:14:14 heisenberg kernel: BTRFS: Transaction aborted (error -117)
Feb 07 17:14:14 heisenberg kernel: WARNING: CPU: 4 PID: 157055 at fs/btrfs/=
extent-tree.c:3231 __btrfs_free_extent.isra.0+0x7cf/0x1010 [btrfs]
Feb 07 17:14:14 heisenberg kernel: Modules linked in: cpuid ext4 mbcache jb=
d2 sg uas nft_fib_ipv6 nft_ct nft_fib_ipv4 nft_fib wireguard libcurve25519 =
libchacha20poly1305 libchacha ip6_udp_tunnel udp_tunnel libpoly1305 cmac cc=
m snd_seq_dummy snd_hrtimer snd_seq snd_ctl_led snd_soc_skl_hda_dsp snd_soc=
_intel_sof_board_helpers snd_sof_probes snd_soc_intel_hda_dsp_common xe snd=
_hda_codec_intelhdmi snd_hda_codec_alc269 snd_hda_scodec_component drm_gpuv=
m snd_hda_codec_realtek_lib drm_gpusvm_helper snd_hda_codec_generic gpu_sch=
ed snd_soc_dmic drm_ttm_helper drm_exec drm_suballoc_helper ip6t_REJECT nf_=
reject_ipv6 ipt_REJECT nf_reject_ipv4 snd_hda_intel xt_tcpudp snd_sof_pci_i=
ntel_tgl xt_conntrack snd_sof_pci_intel_cnl nf_conntrack snd_sof_intel_hda_=
generic nf_defrag_ipv6 soundwire_intel nf_defrag_ipv4 snd_sof_intel_hda_sdw=
_bpt nft_compat nf_tables snd_sof_intel_hda_common intel_uncore_frequency j=
oydev intel_uncore_frequency_common binfmt_misc x_tables snd_soc_hdac_hda x=
86_pkg_temp_thermal snd_sof_intel_hda_mlink intel_powerclamp snd_sof_intel_=
hda
Feb 07 17:14:14 heisenberg kernel:  i915 snd_hda_codec_hdmi soundwire_caden=
ce snd_sof_pci coretemp snd_sof_xtensa_dsp snd_sof kvm_intel snd_sof_utils =
snd_soc_acpi_intel_match snd_soc_acpi_intel_sdca_quirks soundwire_generic_a=
llocation kvm snd_soc_acpi hid_multitouch crc8 soundwire_bus iwlmvm snd_soc=
_sdca snd_soc_avs btusb uvcvideo btmtk irqbypass snd_soc_hda_codec btrtl vi=
deobuf2_vmalloc ghash_clmulni_intel drm_buddy btbcm snd_hda_ext_core uvc hi=
d_generic snd_hda_codec btintel iTCO_wdt rapl videobuf2_memops ttm sdhci_pc=
i snd_usb_audio intel_pmc_bxt processor_thermal_device_pci mac80211 intel_r=
apl_msr videobuf2_v4l2 snd_hda_core sdhci_uhs2 drm_display_helper bluetooth=
 intel_cstate iTCO_vendor_support snd_usbmidi_lib videodev processor_therma=
l_device sdhci snd_intel_dspcfg processor_thermal_wt_hint platform_temperat=
ure_control snd_rawmidi cec videobuf2_common snd_intel_sdw_acpi cqhci proce=
ssor_thermal_soc_slider snd_seq_device snd_hwdep mei_hdcp watchdog mei_pxp =
ee1004 wmi_bmof usbhid mc ecdh_generic libarc4 intel_uncore crc16 intel_pmc=
_core
Feb 07 17:14:14 heisenberg kernel:  mmc_core snd_soc_core rc_core platform_=
profile pmt_telemetry snd_compress ucsi_acpi processor_thermal_rfim drm_cli=
ent_lib snd_pcm_dmaengine processor_thermal_rapl typec_ucsi iwlwifi pmt_dis=
covery drm_kms_helper snd_pcm i2c_hid_acpi intel_rapl_common typec pmt_clas=
s i2c_hid i2c_algo_bit int3400_thermal hid roles fujitsu_laptop intel_pmc_s=
sram_telemetry acpi_thermal_rel acpi_pad acpi_tad cfg80211 battery button v=
ideo processor_thermal_wt_req i2c_i801 snd_timer processor_thermal_power_fl=
oor i2c_smbus mei_me snd intel_lpss_pci processor_thermal_mbox soundcore in=
tel_lpss mei rfkill wmi idma64 intel_vsec ac int340x_thermal_zone igen6_eda=
c parport_pc lp ppdev drm parport efi_pstore configfs nfnetlink autofs4 crc=
32c_cryptoapi sd_mod dm_crypt dm_mod raid10 raid456 async_raid6_recov async=
_memcpy async_pq async_xor async_tx raid1 raid0 md_mod usb_storage scsi_mod=
 scsi_common btrfs blake2b_generic xor raid6_pq xhci_pci xhci_hcd nvme thun=
derbolt nvme_core usbcore e1000e evdev nvme_keyring nvme_auth serio_raw int=
el_hid
Feb 07 17:14:14 heisenberg kernel:  fan pcspkr aesni_intel usb_common hkdf =
sparse_keymap efivarfs
Feb 07 17:14:14 heisenberg kernel: CPU: 4 UID: 0 PID: 157055 Comm: mount Ta=
inted: G        W           6.18.8+deb14-amd64 #1 PREEMPT(lazy)  Debian 6.1=
8.8-1=20
Feb 07 17:14:14 heisenberg kernel: Tainted: [W]=3DWARN
Feb 07 17:14:14 heisenberg kernel: Hardware name: FUJITSU CLIENT COMPUTING =
LIMITED LIFEBOOK U7512/FJNB2F4, BIOS Version 2.35 07/01/2025
Feb 07 17:14:14 heisenberg kernel: RIP: 0010:__btrfs_free_extent.isra.0+0x7=
cf/0x1010 [btrfs]
Feb 07 17:14:14 heisenberg kernel: Code: 2f 01 e9 80 b6 0e 00 0f 0b f0 48 0=
f ba a8 b0 0a 00 00 02 0f 82 fa b3 0e 00 be 8b ff ff ff 48 c7 c7 68 29 c1 c=
0 e8 c1 ee 13 eb <0f> 0b c6 44 24 2f 01 e9 dd b3 0e 00 89 04 24 e8 6d 79 21=
 eb 48 8b
Feb 07 17:14:14 heisenberg kernel: RSP: 0018:ffffd1b300ce7680 EFLAGS: 00010=
246
Feb 07 17:14:14 heisenberg kernel: RAX: 0000000000000000 RBX: 000000000ef0c=
000 RCX: 0000000000000027
Feb 07 17:14:14 heisenberg kernel: RDX: ffff8de0af51ce48 RSI: 0000000000000=
001 RDI: ffff8de0af51ce40
Feb 07 17:14:14 heisenberg kernel: RBP: 0000000000000000 R08: 0000000000000=
000 R09: ffffd1b300ce7520
Feb 07 17:14:14 heisenberg kernel: R10: ffffffffad8db948 R11: 00000000ffffe=
fff R12: 0000000000000001
Feb 07 17:14:14 heisenberg kernel: R13: 0000000000000000 R14: ffff8de05fd70=
e00 R15: ffff8dda5f16dd90
Feb 07 17:14:14 heisenberg kernel: FS:  00007f80ecec9840(0000) GS:ffff8de10=
10cc000(0000) knlGS:0000000000000000
Feb 07 17:14:14 heisenberg kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000=
080050033
Feb 07 17:14:14 heisenberg kernel: CR2: 00007f2584823f80 CR3: 0000000e03722=
004 CR4: 0000000000f72ef0
Feb 07 17:14:14 heisenberg kernel: PKRU: 55555554
Feb 07 17:14:14 heisenberg kernel: Call Trace:
Feb 07 17:14:14 heisenberg kernel:  <TASK>
Feb 07 17:14:14 heisenberg kernel:  ? btrfs_merge_delayed_refs+0x1bb/0x290 =
[btrfs]
Feb 07 17:14:14 heisenberg kernel:  __btrfs_run_delayed_refs+0x2dc/0xf70 [b=
trfs]
Feb 07 17:14:14 heisenberg kernel:  ? setup_items_for_insert.isra.0+0x196/0=
x420 [btrfs]
Feb 07 17:14:14 heisenberg kernel:  ? release_extent_buffer+0x33/0x120 [btr=
fs]
Feb 07 17:14:14 heisenberg kernel:  ? __btrfs_add_to_free_space_tree+0x294/=
0x3f0 [btrfs]
Feb 07 17:14:14 heisenberg kernel:  btrfs_run_delayed_refs+0x3b/0x120 [btrf=
s]
Feb 07 17:14:14 heisenberg kernel:  btrfs_commit_transaction+0x6d/0xdf0 [bt=
rfs]
Feb 07 17:14:14 heisenberg kernel:  ? populate_free_space_tree+0x89/0x220 [=
btrfs]
Feb 07 17:14:14 heisenberg kernel:  btrfs_rebuild_free_space_tree+0x1c5/0x2=
70 [btrfs]
Feb 07 17:14:14 heisenberg kernel:  btrfs_start_pre_rw_mount+0x2df/0x610 [b=
trfs]
Feb 07 17:14:14 heisenberg kernel:  ? btrfs_get_root_ref+0x2a7/0x3b0 [btrfs=
]
Feb 07 17:14:14 heisenberg kernel:  open_ctree+0x113e/0x15a0 [btrfs]
Feb 07 17:14:14 heisenberg kernel:  btrfs_get_tree.cold+0xb/0xb6 [btrfs]
Feb 07 17:14:14 heisenberg kernel:  ? __fs_parse+0x68/0x1c0
Feb 07 17:14:14 heisenberg kernel:  vfs_get_tree+0x29/0xd0
Feb 07 17:14:14 heisenberg kernel:  vfs_cmd_create+0x57/0xd0
Feb 07 17:14:14 heisenberg kernel:  __do_sys_fsconfig+0x4b6/0x650
Feb 07 17:14:14 heisenberg kernel:  do_syscall_64+0x81/0x7f0
Feb 07 17:14:14 heisenberg kernel:  ? rw_verify_area+0x56/0x180
Feb 07 17:14:14 heisenberg kernel:  ? vfs_read+0xbf/0x390
Feb 07 17:14:14 heisenberg kernel:  ? fscontext_read+0x16a/0x180
Feb 07 17:14:14 heisenberg kernel:  ? rw_verify_area+0x56/0x180
Feb 07 17:14:14 heisenberg kernel:  ? fs_param_is_enum+0x53/0xa0
Feb 07 17:14:14 heisenberg kernel:  ? __fs_parse+0xac/0x1c0
Feb 07 17:14:14 heisenberg kernel:  ? ksys_read+0x73/0xf0
Feb 07 17:14:14 heisenberg kernel:  ? do_syscall_64+0xb9/0x7f0
Feb 07 17:14:14 heisenberg kernel:  ? __do_sys_fsconfig+0x359/0x650
Feb 07 17:14:14 heisenberg kernel:  ? do_syscall_64+0xb9/0x7f0
Feb 07 17:14:14 heisenberg kernel:  ? do_faccessat+0x1d7/0x2d0
Feb 07 17:14:14 heisenberg kernel:  ? __x64_sys_access+0x1c/0x30
Feb 07 17:14:14 heisenberg kernel:  ? do_syscall_64+0xb9/0x7f0
Feb 07 17:14:14 heisenberg kernel:  ? do_syscall_64+0xb9/0x7f0
Feb 07 17:14:14 heisenberg kernel:  ? do_syscall_64+0xb9/0x7f0
Feb 07 17:14:14 heisenberg kernel:  ? exc_page_fault+0x7e/0x1a0
Feb 07 17:14:14 heisenberg kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7=
e
Feb 07 17:14:14 heisenberg kernel: RIP: 0033:0x7f80ed0f2a6a
Feb 07 17:14:14 heisenberg kernel: Code: 73 01 c3 48 8b 0d a6 23 0d 00 f7 d=
8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 a=
f 01 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 76 23 0d 00 f7 d8 64=
 89 01 48
Feb 07 17:14:14 heisenberg kernel: RSP: 002b:00007ffee20bd628 EFLAGS: 00000=
246 ORIG_RAX: 00000000000001af
Feb 07 17:14:14 heisenberg kernel: RAX: ffffffffffffffda RBX: 00005607c7efa=
b80 RCX: 00007f80ed0f2a6a
Feb 07 17:14:14 heisenberg kernel: RDX: 0000000000000000 RSI: 0000000000000=
006 RDI: 0000000000000003
Feb 07 17:14:14 heisenberg kernel: RBP: 0000000000000000 R08: 0000000000000=
000 R09: 0000000000000000
Feb 07 17:14:14 heisenberg kernel: R10: 0000000000000000 R11: 0000000000000=
246 R12: 00005607c7efc960
Feb 07 17:14:14 heisenberg kernel: R13: 00007f80ed28026c R14: 00007f80ed27e=
560 R15: 00007f80ed28026c
Feb 07 17:14:14 heisenberg kernel:  </TASK>
Feb 07 17:14:14 heisenberg kernel: ---[ end trace 0000000000000000 ]---
Feb 07 17:14:14 heisenberg kernel: BTRFS: error (device dm-2 state A) in __=
btrfs_free_extent:3231: errno=3D-117 Filesystem corrupted
Feb 07 17:14:14 heisenberg kernel: BTRFS info (device dm-2 state EA): leaf =
265814016 gen 2935 total ptrs 116 free space 9276 owner 2
Feb 07 17:14:14 heisenberg kernel:         item 0 key (248840192 METADATA_I=
TEM 0) itemoff 16250 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2716 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 283
Feb 07 17:14:14 heisenberg kernel:         item 1 key (248856576 METADATA_I=
TEM 0) itemoff 16217 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2756 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 286
Feb 07 17:14:14 heisenberg kernel:         item 2 key (248872960 METADATA_I=
TEM 0) itemoff 16157 itemsize 60
Feb 07 17:14:14 heisenberg kernel:                 extent refs 4 gen 2756 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 289
Feb 07 17:14:14 heisenberg kernel:                 ref#1: tree block backre=
f root 288
Feb 07 17:14:14 heisenberg kernel:                 ref#2: tree block backre=
f root 287
Feb 07 17:14:14 heisenberg kernel:                 ref#3: tree block backre=
f root 286
Feb 07 17:14:14 heisenberg kernel:         item 3 key (248889344 METADATA_I=
TEM 0) itemoff 16124 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2630 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 2
Feb 07 17:14:14 heisenberg kernel:         item 4 key (248905728 METADATA_I=
TEM 0) itemoff 16091 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2772 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 5
Feb 07 17:14:14 heisenberg kernel:         item 5 key (248922112 METADATA_I=
TEM 1) itemoff 16031 itemsize 60
Feb 07 17:14:14 heisenberg kernel:                 extent refs 4 gen 2871 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 295
Feb 07 17:14:14 heisenberg kernel:                 ref#1: tree block backre=
f root 294
Feb 07 17:14:14 heisenberg kernel:                 ref#2: tree block backre=
f root 293
Feb 07 17:14:14 heisenberg kernel:                 ref#3: tree block backre=
f root 292
Feb 07 17:14:14 heisenberg kernel:         item 6 key (248938496 METADATA_I=
TEM 0) itemoff 15998 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2609 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 278
Feb 07 17:14:14 heisenberg kernel:         item 7 key (248954880 METADATA_I=
TEM 0) itemoff 15965 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2630 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 2
Feb 07 17:14:14 heisenberg kernel:         item 8 key (248971264 METADATA_I=
TEM 0) itemoff 15932 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2609 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 278
Feb 07 17:14:14 heisenberg kernel:         item 9 key (248987648 METADATA_I=
TEM 0) itemoff 15899 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2871 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 292
Feb 07 17:14:14 heisenberg kernel:         item 10 key (249004032 METADATA_=
ITEM 0) itemoff 15857 itemsize 42
Feb 07 17:14:14 heisenberg kernel:                 extent refs 2 gen 2609 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 279
Feb 07 17:14:14 heisenberg kernel:                 ref#1: tree block backre=
f root 278
Feb 07 17:14:14 heisenberg kernel:         item 11 key (249020416 METADATA_=
ITEM 0) itemoff 15824 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2723 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 284
Feb 07 17:14:14 heisenberg kernel:         item 12 key (249036800 METADATA_=
ITEM 0) itemoff 15791 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2609 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 278
Feb 07 17:14:14 heisenberg kernel:         item 13 key (249053184 METADATA_=
ITEM 0) itemoff 15722 itemsize 69
Feb 07 17:14:14 heisenberg kernel:                 extent refs 5 gen 2631 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 283
Feb 07 17:14:14 heisenberg kernel:                 ref#1: tree block backre=
f root 282
Feb 07 17:14:14 heisenberg kernel:                 ref#2: tree block backre=
f root 281
Feb 07 17:14:14 heisenberg kernel:                 ref#3: tree block backre=
f root 280
Feb 07 17:14:14 heisenberg kernel:                 ref#4: tree block backre=
f root 279
Feb 07 17:14:14 heisenberg kernel:         item 14 key (249069568 METADATA_=
ITEM 0) itemoff 15680 itemsize 42
Feb 07 17:14:14 heisenberg kernel:                 extent refs 2 gen 2631 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 280
Feb 07 17:14:14 heisenberg kernel:                 ref#1: tree block backre=
f root 279
Feb 07 17:14:14 heisenberg kernel:         item 15 key (249085952 METADATA_=
ITEM 0) itemoff 15638 itemsize 42
Feb 07 17:14:14 heisenberg kernel:                 extent refs 2 gen 2631 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 280
Feb 07 17:14:14 heisenberg kernel:                 ref#1: tree block backre=
f root 279
Feb 07 17:14:14 heisenberg kernel:         item 16 key (249102336 METADATA_=
ITEM 0) itemoff 15605 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2610 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 278
Feb 07 17:14:14 heisenberg kernel:         item 17 key (249118720 METADATA_=
ITEM 0) itemoff 15572 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2609 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 278
Feb 07 17:14:14 heisenberg kernel:         item 18 key (249135104 METADATA_=
ITEM 0) itemoff 15539 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2871 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 292
Feb 07 17:14:14 heisenberg kernel:         item 19 key (249151488 METADATA_=
ITEM 0) itemoff 15506 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2609 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 278
Feb 07 17:14:14 heisenberg kernel:         item 20 key (249167872 METADATA_=
ITEM 0) itemoff 15473 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2772 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 7
Feb 07 17:14:14 heisenberg kernel:         item 21 key (249184256 METADATA_=
ITEM 0) itemoff 15440 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2716 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 283
Feb 07 17:14:14 heisenberg kernel:         item 22 key (249200640 METADATA_=
ITEM 0) itemoff 15407 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2669 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 281
Feb 07 17:14:14 heisenberg kernel:         item 23 key (249217024 METADATA_=
ITEM 0) itemoff 15374 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2716 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 283
Feb 07 17:14:14 heisenberg kernel:         item 24 key (249233408 METADATA_=
ITEM 0) itemoff 15341 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2716 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 283
Feb 07 17:14:14 heisenberg kernel:         item 25 key (249249792 METADATA_=
ITEM 0) itemoff 15308 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2772 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 7
Feb 07 17:14:14 heisenberg kernel:         item 26 key (249266176 METADATA_=
ITEM 0) itemoff 15275 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2723 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 7
Feb 07 17:14:14 heisenberg kernel:         item 27 key (249282560 METADATA_=
ITEM 0) itemoff 15242 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2609 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 278
Feb 07 17:14:14 heisenberg kernel:         item 28 key (249298944 METADATA_=
ITEM 0) itemoff 15209 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2609 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 278
Feb 07 17:14:14 heisenberg kernel:         item 29 key (249315328 METADATA_=
ITEM 0) itemoff 15176 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2769 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 2
Feb 07 17:14:14 heisenberg kernel:         item 30 key (249331712 METADATA_=
ITEM 0) itemoff 15143 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2769 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 2
Feb 07 17:14:14 heisenberg kernel:         item 31 key (249348096 METADATA_=
ITEM 0) itemoff 15110 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2769 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 2
Feb 07 17:14:14 heisenberg kernel:         item 32 key (249364480 METADATA_=
ITEM 0) itemoff 15077 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2769 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 2
Feb 07 17:14:14 heisenberg kernel:         item 33 key (249380864 METADATA_=
ITEM 0) itemoff 15044 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2769 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 2
Feb 07 17:14:14 heisenberg kernel:         item 34 key (249397248 METADATA_=
ITEM 0) itemoff 15011 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2630 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 2
Feb 07 17:14:14 heisenberg kernel:         item 35 key (249413632 METADATA_=
ITEM 0) itemoff 14978 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2769 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 2
Feb 07 17:14:14 heisenberg kernel:         item 36 key (249430016 METADATA_=
ITEM 0) itemoff 14945 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2769 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 2
Feb 07 17:14:14 heisenberg kernel:         item 37 key (249446400 METADATA_=
ITEM 0) itemoff 14912 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2769 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 2
Feb 07 17:14:14 heisenberg kernel:         item 38 key (249462784 METADATA_=
ITEM 0) itemoff 14879 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2772 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 7
Feb 07 17:14:14 heisenberg kernel:         item 39 key (249479168 METADATA_=
ITEM 0) itemoff 14846 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2904 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 295
Feb 07 17:14:14 heisenberg kernel:         item 40 key (249495552 METADATA_=
ITEM 0) itemoff 14813 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2716 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 283
Feb 07 17:14:14 heisenberg kernel:         item 41 key (249511936 METADATA_=
ITEM 0) itemoff 14762 itemsize 51
Feb 07 17:14:14 heisenberg kernel:                 extent refs 3 gen 2688 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 284
Feb 07 17:14:14 heisenberg kernel:                 ref#1: tree block backre=
f root 283
Feb 07 17:14:14 heisenberg kernel:                 ref#2: tree block backre=
f root 282
Feb 07 17:14:14 heisenberg kernel:         item 42 key (249528320 METADATA_=
ITEM 0) itemoff 14729 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2922 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 7
Feb 07 17:14:14 heisenberg kernel:         item 43 key (249544704 METADATA_=
ITEM 0) itemoff 14687 itemsize 42
Feb 07 17:14:14 heisenberg kernel:                 extent refs 2 gen 2884 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 295
Feb 07 17:14:14 heisenberg kernel:                 ref#1: tree block backre=
f root 293
Feb 07 17:14:14 heisenberg kernel:         item 44 key (249561088 METADATA_=
ITEM 0) itemoff 14654 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2769 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 2
Feb 07 17:14:14 heisenberg kernel:         item 45 key (249577472 METADATA_=
ITEM 0) itemoff 14621 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2609 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 278
Feb 07 17:14:14 heisenberg kernel:         item 46 key (249593856 METADATA_=
ITEM 0) itemoff 14588 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2904 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 295
Feb 07 17:14:14 heisenberg kernel:         item 47 key (249610240 METADATA_=
ITEM 0) itemoff 14555 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2738 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 285
Feb 07 17:14:14 heisenberg kernel:         item 48 key (249626624 METADATA_=
ITEM 0) itemoff 14522 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2772 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 7
Feb 07 17:14:14 heisenberg kernel:         item 49 key (249643008 METADATA_=
ITEM 0) itemoff 14489 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2738 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 285
Feb 07 17:14:14 heisenberg kernel:         item 50 key (249659392 METADATA_=
ITEM 0) itemoff 14456 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2904 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 295
Feb 07 17:14:14 heisenberg kernel:         item 51 key (249675776 METADATA_=
ITEM 0) itemoff 14423 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2772 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 7
Feb 07 17:14:14 heisenberg kernel:         item 52 key (249692160 METADATA_=
ITEM 0) itemoff 14390 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2609 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 278
Feb 07 17:14:14 heisenberg kernel:         item 53 key (249708544 METADATA_=
ITEM 0) itemoff 14357 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2769 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 2
Feb 07 17:14:14 heisenberg kernel:         item 54 key (249724928 METADATA_=
ITEM 0) itemoff 14324 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2772 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 7
Feb 07 17:14:14 heisenberg kernel:         item 55 key (249741312 METADATA_=
ITEM 0) itemoff 14291 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2769 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 2
Feb 07 17:14:14 heisenberg kernel:         item 56 key (249757696 METADATA_=
ITEM 0) itemoff 14258 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2769 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 2
Feb 07 17:14:14 heisenberg kernel:         item 57 key (249774080 METADATA_=
ITEM 0) itemoff 14225 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2922 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 7
Feb 07 17:14:14 heisenberg kernel:         item 58 key (249790464 METADATA_=
ITEM 0) itemoff 14192 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2769 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 2
Feb 07 17:14:14 heisenberg kernel:         item 59 key (249806848 METADATA_=
ITEM 0) itemoff 14159 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2769 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 2
Feb 07 17:14:14 heisenberg kernel:         item 60 key (249823232 METADATA_=
ITEM 0) itemoff 14126 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2630 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 2
Feb 07 17:14:14 heisenberg kernel:         item 61 key (249839616 METADATA_=
ITEM 0) itemoff 14093 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2630 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 2
Feb 07 17:14:14 heisenberg kernel:         item 62 key (249856000 METADATA_=
ITEM 0) itemoff 14060 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2769 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 2
Feb 07 17:14:14 heisenberg kernel:         item 63 key (249872384 METADATA_=
ITEM 0) itemoff 14027 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2769 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 2
Feb 07 17:14:14 heisenberg kernel:         item 64 key (249888768 METADATA_=
ITEM 0) itemoff 13994 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2769 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 2
Feb 07 17:14:14 heisenberg kernel:         item 65 key (249905152 METADATA_=
ITEM 0) itemoff 13961 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2716 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 283
Feb 07 17:14:14 heisenberg kernel:         item 66 key (249921536 METADATA_=
ITEM 0) itemoff 13928 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2630 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 2
Feb 07 17:14:14 heisenberg kernel:         item 67 key (249937920 METADATA_=
ITEM 0) itemoff 13895 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2772 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 7
Feb 07 17:14:14 heisenberg kernel:         item 68 key (249954304 METADATA_=
ITEM 0) itemoff 13862 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2904 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 295
Feb 07 17:14:14 heisenberg kernel:         item 69 key (249970688 METADATA_=
ITEM 0) itemoff 13829 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2821 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 288
Feb 07 17:14:14 heisenberg kernel:         item 70 key (249987072 METADATA_=
ITEM 0) itemoff 13787 itemsize 42
Feb 07 17:14:14 heisenberg kernel:                 extent refs 2 gen 2716 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 284
Feb 07 17:14:14 heisenberg kernel:                 ref#1: tree block backre=
f root 283
Feb 07 17:14:14 heisenberg kernel:         item 71 key (250003456 METADATA_=
ITEM 0) itemoff 13754 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2922 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 7
Feb 07 17:14:14 heisenberg kernel:         item 72 key (250019840 METADATA_=
ITEM 0) itemoff 13721 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2827 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 288
Feb 07 17:14:14 heisenberg kernel:         item 73 key (250036224 METADATA_=
ITEM 0) itemoff 13688 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2893 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 294
Feb 07 17:14:14 heisenberg kernel:         item 74 key (250052608 METADATA_=
ITEM 0) itemoff 13655 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2630 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 2
Feb 07 17:14:14 heisenberg kernel:         item 75 key (250068992 METADATA_=
ITEM 0) itemoff 13622 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2893 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 294
Feb 07 17:14:14 heisenberg kernel:         item 76 key (250085376 METADATA_=
ITEM 0) itemoff 13589 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2871 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 292
Feb 07 17:14:14 heisenberg kernel:         item 77 key (250101760 METADATA_=
ITEM 0) itemoff 13556 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2827 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 288
Feb 07 17:14:14 heisenberg kernel:         item 78 key (250118144 METADATA_=
ITEM 0) itemoff 13523 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2893 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 294
Feb 07 17:14:14 heisenberg kernel:         item 79 key (250134528 METADATA_=
ITEM 0) itemoff 13490 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2922 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 7
Feb 07 17:14:14 heisenberg kernel:         item 80 key (250150912 METADATA_=
ITEM 0) itemoff 13403 itemsize 87
Feb 07 17:14:14 heisenberg kernel:                 extent refs 7 gen 2716 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 289
Feb 07 17:14:14 heisenberg kernel:                 ref#1: tree block backre=
f root 288
Feb 07 17:14:14 heisenberg kernel:                 ref#2: tree block backre=
f root 287
Feb 07 17:14:14 heisenberg kernel:                 ref#3: tree block backre=
f root 286
Feb 07 17:14:14 heisenberg kernel:                 ref#4: tree block backre=
f root 285
Feb 07 17:14:14 heisenberg kernel:                 ref#5: tree block backre=
f root 284
Feb 07 17:14:14 heisenberg kernel:                 ref#6: tree block backre=
f root 283
Feb 07 17:14:14 heisenberg kernel:         item 81 key (250167296 METADATA_=
ITEM 0) itemoff 13370 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2827 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 288
Feb 07 17:14:14 heisenberg kernel:         item 82 key (250183680 METADATA_=
ITEM 0) itemoff 13337 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2871 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 292
Feb 07 17:14:14 heisenberg kernel:         item 83 key (250200064 METADATA_=
ITEM 0) itemoff 13304 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2871 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 292
Feb 07 17:14:14 heisenberg kernel:         item 84 key (250216448 METADATA_=
ITEM 0) itemoff 13271 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2827 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 288
Feb 07 17:14:14 heisenberg kernel:         item 85 key (250232832 METADATA_=
ITEM 0) itemoff 13238 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2904 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 295
Feb 07 17:14:14 heisenberg kernel:         item 86 key (250249216 METADATA_=
ITEM 0) itemoff 13205 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2827 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 288
Feb 07 17:14:14 heisenberg kernel:         item 87 key (250265600 METADATA_=
ITEM 0) itemoff 13172 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2893 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 294
Feb 07 17:14:14 heisenberg kernel:         item 88 key (250281984 METADATA_=
ITEM 0) itemoff 13139 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2922 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 7
Feb 07 17:14:14 heisenberg kernel:         item 89 key (250298368 METADATA_=
ITEM 0) itemoff 13106 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2903 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 2
Feb 07 17:14:14 heisenberg kernel:         item 90 key (250314752 METADATA_=
ITEM 0) itemoff 13073 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2922 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 7
Feb 07 17:14:14 heisenberg kernel:         item 91 key (250331136 METADATA_=
ITEM 0) itemoff 13040 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2630 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 2
Feb 07 17:14:14 heisenberg kernel:         item 92 key (250347520 METADATA_=
ITEM 0) itemoff 13007 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2630 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 2
Feb 07 17:14:14 heisenberg kernel:         item 93 key (250363904 METADATA_=
ITEM 0) itemoff 12974 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2893 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 294
Feb 07 17:14:14 heisenberg kernel:         item 94 key (250380288 METADATA_=
ITEM 0) itemoff 12941 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2893 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 294
Feb 07 17:14:14 heisenberg kernel:         item 95 key (250396672 METADATA_=
ITEM 0) itemoff 12908 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2893 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 294
Feb 07 17:14:14 heisenberg kernel:         item 96 key (250413056 METADATA_=
ITEM 0) itemoff 12866 itemsize 42
Feb 07 17:14:14 heisenberg kernel:                 extent refs 2 gen 2893 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 295
Feb 07 17:14:14 heisenberg kernel:                 ref#1: tree block backre=
f root 294
Feb 07 17:14:14 heisenberg kernel:         item 97 key (250429440 METADATA_=
ITEM 0) itemoff 12833 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2922 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 7
Feb 07 17:14:14 heisenberg kernel:         item 98 key (250462208 METADATA_=
ITEM 0) itemoff 12800 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2922 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 7
Feb 07 17:14:14 heisenberg kernel:         item 99 key (250494976 METADATA_=
ITEM 0) itemoff 12767 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2630 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 2
Feb 07 17:14:14 heisenberg kernel:         item 100 key (250511360 METADATA=
_ITEM 0) itemoff 12734 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2922 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 7
Feb 07 17:14:14 heisenberg kernel:         item 101 key (250527744 METADATA=
_ITEM 0) itemoff 12701 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2922 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 7
Feb 07 17:14:14 heisenberg kernel:         item 102 key (250544128 METADATA=
_ITEM 0) itemoff 12668 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2922 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 7
Feb 07 17:14:14 heisenberg kernel:         item 103 key (250560512 METADATA=
_ITEM 0) itemoff 12635 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2610 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 278
Feb 07 17:14:14 heisenberg kernel:         item 104 key (250576896 METADATA=
_ITEM 0) itemoff 12602 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2610 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 278
Feb 07 17:14:14 heisenberg kernel:         item 105 key (250593280 METADATA=
_ITEM 0) itemoff 12569 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2871 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 292
Feb 07 17:14:14 heisenberg kernel:         item 106 key (250609664 METADATA=
_ITEM 0) itemoff 12536 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2609 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 278
Feb 07 17:14:14 heisenberg kernel:         item 107 key (250642432 METADATA=
_ITEM 0) itemoff 12503 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2921 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 2
Feb 07 17:14:14 heisenberg kernel:         item 108 key (250724352 METADATA=
_ITEM 0) itemoff 12470 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2609 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 278
Feb 07 17:14:14 heisenberg kernel:         item 109 key (250740736 METADATA=
_ITEM 0) itemoff 12437 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2871 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 292
Feb 07 17:14:14 heisenberg kernel:         item 110 key (250757120 METADATA=
_ITEM 0) itemoff 12404 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 1098 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 7
Feb 07 17:14:14 heisenberg kernel:         item 111 key (250773504 METADATA=
_ITEM 0) itemoff 12362 itemsize 42
Feb 07 17:14:14 heisenberg kernel:                 extent refs 2 gen 2609 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 279
Feb 07 17:14:14 heisenberg kernel:                 ref#1: tree block backre=
f root 278
Feb 07 17:14:14 heisenberg kernel:         item 112 key (250789888 METADATA=
_ITEM 0) itemoff 12329 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2772 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 2
Feb 07 17:14:14 heisenberg kernel:         item 113 key (250806272 METADATA=
_ITEM 0) itemoff 12251 itemsize 78
Feb 07 17:14:14 heisenberg kernel:                 extent refs 6 gen 2609 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 283
Feb 07 17:14:14 heisenberg kernel:                 ref#1: tree block backre=
f root 282
Feb 07 17:14:14 heisenberg kernel:                 ref#2: tree block backre=
f root 281
Feb 07 17:14:14 heisenberg kernel:                 ref#3: tree block backre=
f root 280
Feb 07 17:14:14 heisenberg kernel:                 ref#4: tree block backre=
f root 279
Feb 07 17:14:14 heisenberg kernel:                 ref#5: tree block backre=
f root 278
Feb 07 17:14:14 heisenberg kernel:         item 114 key (250822656 METADATA=
_ITEM 0) itemoff 12218 itemsize 33
Feb 07 17:14:14 heisenberg kernel:                 extent refs 1 gen 2893 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 294
Feb 07 17:14:14 heisenberg kernel:         item 115 key (250839040 METADATA=
_ITEM 0) itemoff 12176 itemsize 42
Feb 07 17:14:14 heisenberg kernel:                 extent refs 2 gen 2871 f=
lags 2
Feb 07 17:14:14 heisenberg kernel:                 ref#0: tree block backre=
f root 293
Feb 07 17:14:14 heisenberg kernel:                 ref#1: tree block backre=
f root 292
Feb 07 17:14:14 heisenberg kernel: BTRFS critical (device dm-2 state EA): u=
nable to find ref byte nr 250658816 parent 0 root 10 owner 1 offset 0 slot =
108
Feb 07 17:14:14 heisenberg kernel: BTRFS error (device dm-2 state EA): fail=
ed to run delayed ref for logical 250658816 num_bytes 16384 type 176 action=
 2 ref_mod 1: -2
Feb 07 17:14:14 heisenberg kernel: BTRFS: error (device dm-2 state EA) in b=
trfs_run_delayed_refs:2161: errno=3D-2 No such entry
Feb 07 17:14:14 heisenberg kernel: BTRFS warning (device dm-2 state EA): fa=
iled to rebuild free space tree: -2
Feb 07 17:14:14 heisenberg kernel: BTRFS error (device dm-2 state EA): comm=
it super ret -30
Feb 07 17:14:14 heisenberg kernel: ------------[ cut here ]------------
Feb 07 17:14:14 heisenberg kernel: WARNING: CPU: 4 PID: 157055 at fs/btrfs/=
block-group.c:172 btrfs_put_block_group+0xe0/0xf0 [btrfs]
Feb 07 17:14:14 heisenberg kernel: Modules linked in: cpuid ext4 mbcache jb=
d2 sg uas nft_fib_ipv6 nft_ct nft_fib_ipv4 nft_fib wireguard libcurve25519 =
libchacha20poly1305 libchacha ip6_udp_tunnel udp_tunnel libpoly1305 cmac cc=
m snd_seq_dummy snd_hrtimer snd_seq snd_ctl_led snd_soc_skl_hda_dsp snd_soc=
_intel_sof_board_helpers snd_sof_probes snd_soc_intel_hda_dsp_common xe snd=
_hda_codec_intelhdmi snd_hda_codec_alc269 snd_hda_scodec_component drm_gpuv=
m snd_hda_codec_realtek_lib drm_gpusvm_helper snd_hda_codec_generic gpu_sch=
ed snd_soc_dmic drm_ttm_helper drm_exec drm_suballoc_helper ip6t_REJECT nf_=
reject_ipv6 ipt_REJECT nf_reject_ipv4 snd_hda_intel xt_tcpudp snd_sof_pci_i=
ntel_tgl xt_conntrack snd_sof_pci_intel_cnl nf_conntrack snd_sof_intel_hda_=
generic nf_defrag_ipv6 soundwire_intel nf_defrag_ipv4 snd_sof_intel_hda_sdw=
_bpt nft_compat nf_tables snd_sof_intel_hda_common intel_uncore_frequency j=
oydev intel_uncore_frequency_common binfmt_misc x_tables snd_soc_hdac_hda x=
86_pkg_temp_thermal snd_sof_intel_hda_mlink intel_powerclamp snd_sof_intel_=
hda
Feb 07 17:14:14 heisenberg kernel:  i915 snd_hda_codec_hdmi soundwire_caden=
ce snd_sof_pci coretemp snd_sof_xtensa_dsp snd_sof kvm_intel snd_sof_utils =
snd_soc_acpi_intel_match snd_soc_acpi_intel_sdca_quirks soundwire_generic_a=
llocation kvm snd_soc_acpi hid_multitouch crc8 soundwire_bus iwlmvm snd_soc=
_sdca snd_soc_avs btusb uvcvideo btmtk irqbypass snd_soc_hda_codec btrtl vi=
deobuf2_vmalloc ghash_clmulni_intel drm_buddy btbcm snd_hda_ext_core uvc hi=
d_generic snd_hda_codec btintel iTCO_wdt rapl videobuf2_memops ttm sdhci_pc=
i snd_usb_audio intel_pmc_bxt processor_thermal_device_pci mac80211 intel_r=
apl_msr videobuf2_v4l2 snd_hda_core sdhci_uhs2 drm_display_helper bluetooth=
 intel_cstate iTCO_vendor_support snd_usbmidi_lib videodev processor_therma=
l_device sdhci snd_intel_dspcfg processor_thermal_wt_hint platform_temperat=
ure_control snd_rawmidi cec videobuf2_common snd_intel_sdw_acpi cqhci proce=
ssor_thermal_soc_slider snd_seq_device snd_hwdep mei_hdcp watchdog mei_pxp =
ee1004 wmi_bmof usbhid mc ecdh_generic libarc4 intel_uncore crc16 intel_pmc=
_core
Feb 07 17:14:14 heisenberg kernel:  mmc_core snd_soc_core rc_core platform_=
profile pmt_telemetry snd_compress ucsi_acpi processor_thermal_rfim drm_cli=
ent_lib snd_pcm_dmaengine processor_thermal_rapl typec_ucsi iwlwifi pmt_dis=
covery drm_kms_helper snd_pcm i2c_hid_acpi intel_rapl_common typec pmt_clas=
s i2c_hid i2c_algo_bit int3400_thermal hid roles fujitsu_laptop intel_pmc_s=
sram_telemetry acpi_thermal_rel acpi_pad acpi_tad cfg80211 battery button v=
ideo processor_thermal_wt_req i2c_i801 snd_timer processor_thermal_power_fl=
oor i2c_smbus mei_me snd intel_lpss_pci processor_thermal_mbox soundcore in=
tel_lpss mei rfkill wmi idma64 intel_vsec ac int340x_thermal_zone igen6_eda=
c parport_pc lp ppdev drm parport efi_pstore configfs nfnetlink autofs4 crc=
32c_cryptoapi sd_mod dm_crypt dm_mod raid10 raid456 async_raid6_recov async=
_memcpy async_pq async_xor async_tx raid1 raid0 md_mod usb_storage scsi_mod=
 scsi_common btrfs blake2b_generic xor raid6_pq xhci_pci xhci_hcd nvme thun=
derbolt nvme_core usbcore e1000e evdev nvme_keyring nvme_auth serio_raw int=
el_hid
Feb 07 17:14:14 heisenberg kernel:  fan pcspkr aesni_intel usb_common hkdf =
sparse_keymap efivarfs
Feb 07 17:14:14 heisenberg kernel: CPU: 4 UID: 0 PID: 157055 Comm: mount Ta=
inted: G        W           6.18.8+deb14-amd64 #1 PREEMPT(lazy)  Debian 6.1=
8.8-1=20
Feb 07 17:14:14 heisenberg kernel: Tainted: [W]=3DWARN
Feb 07 17:14:14 heisenberg kernel: Hardware name: FUJITSU CLIENT COMPUTING =
LIMITED LIFEBOOK U7512/FJNB2F4, BIOS Version 2.35 07/01/2025
Feb 07 17:14:14 heisenberg kernel: RIP: 0010:btrfs_put_block_group+0xe0/0xf=
0 [btrfs]
Feb 07 17:14:14 heisenberg kernel: Code: b6 28 74 eb 0f 0b 48 8b 03 48 89 d=
e 48 8d b8 a8 08 00 00 e8 82 79 00 00 eb 88 be 03 00 00 00 48 83 c7 1c e8 9=
2 28 74 eb eb a3 <0f> 0b e9 5e ff ff ff 66 0f 1f 84 00 00 00 00 00 90 90 90=
 90 90 90
Feb 07 17:14:14 heisenberg kernel: RSP: 0018:ffffd1b300ce7948 EFLAGS: 00010=
206
Feb 07 17:14:14 heisenberg kernel: RAX: 0000000000000204 RBX: ffff8dd725b51=
800 RCX: 0000000000000000
Feb 07 17:14:14 heisenberg kernel: RDX: ffff8dd16e1d1000 RSI: 0000000008000=
000 RDI: ffff8dd725b51800
Feb 07 17:14:14 heisenberg kernel: RBP: ffff8dd725b51800 R08: ffff8ddb53f61=
6e8 R09: 0000000000270013
Feb 07 17:14:14 heisenberg kernel: R10: ffff8dd831afe9c0 R11: 0000000000008=
000 R12: ffff8dd16e1d1090
Feb 07 17:14:14 heisenberg kernel: R13: ffff8dd16e1d1098 R14: ffff8dd725b51=
8d8 R15: dead000000000100
Feb 07 17:14:14 heisenberg kernel: FS:  00007f80ecec9840(0000) GS:ffff8de10=
10cc000(0000) knlGS:0000000000000000
Feb 07 17:14:14 heisenberg kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000=
080050033
Feb 07 17:14:14 heisenberg kernel: CR2: 00007f2584823f80 CR3: 0000000e03722=
004 CR4: 0000000000f72ef0
Feb 07 17:14:14 heisenberg kernel: PKRU: 55555554
Feb 07 17:14:14 heisenberg kernel: Call Trace:
Feb 07 17:14:14 heisenberg kernel:  <TASK>
Feb 07 17:14:14 heisenberg kernel:  btrfs_free_block_groups+0x24d/0x3d0 [bt=
rfs]
Feb 07 17:14:14 heisenberg kernel:  close_ctree+0x457/0x490 [btrfs]
Feb 07 17:14:14 heisenberg kernel:  ? btrfs_get_root_ref+0x2a7/0x3b0 [btrfs=
]
Feb 07 17:14:14 heisenberg kernel:  open_ctree+0x12d6/0x15a0 [btrfs]
Feb 07 17:14:14 heisenberg kernel:  btrfs_get_tree.cold+0xb/0xb6 [btrfs]
Feb 07 17:14:14 heisenberg kernel:  ? __fs_parse+0x68/0x1c0
Feb 07 17:14:14 heisenberg kernel:  vfs_get_tree+0x29/0xd0
Feb 07 17:14:14 heisenberg kernel:  vfs_cmd_create+0x57/0xd0
Feb 07 17:14:14 heisenberg kernel:  __do_sys_fsconfig+0x4b6/0x650
Feb 07 17:14:14 heisenberg kernel:  do_syscall_64+0x81/0x7f0
Feb 07 17:14:14 heisenberg kernel:  ? rw_verify_area+0x56/0x180
Feb 07 17:14:14 heisenberg kernel:  ? vfs_read+0xbf/0x390
Feb 07 17:14:14 heisenberg kernel:  ? fscontext_read+0x16a/0x180
Feb 07 17:14:14 heisenberg kernel:  ? rw_verify_area+0x56/0x180
Feb 07 17:14:14 heisenberg kernel:  ? fs_param_is_enum+0x53/0xa0
Feb 07 17:14:14 heisenberg kernel:  ? __fs_parse+0xac/0x1c0
Feb 07 17:14:14 heisenberg kernel:  ? ksys_read+0x73/0xf0
Feb 07 17:14:14 heisenberg kernel:  ? do_syscall_64+0xb9/0x7f0
Feb 07 17:14:14 heisenberg kernel:  ? __do_sys_fsconfig+0x359/0x650
Feb 07 17:14:14 heisenberg kernel:  ? do_syscall_64+0xb9/0x7f0
Feb 07 17:14:14 heisenberg kernel:  ? do_faccessat+0x1d7/0x2d0
Feb 07 17:14:14 heisenberg kernel:  ? __x64_sys_access+0x1c/0x30
Feb 07 17:14:14 heisenberg kernel:  ? do_syscall_64+0xb9/0x7f0
Feb 07 17:14:14 heisenberg kernel:  ? do_syscall_64+0xb9/0x7f0
Feb 07 17:14:14 heisenberg kernel:  ? do_syscall_64+0xb9/0x7f0
Feb 07 17:14:14 heisenberg kernel:  ? exc_page_fault+0x7e/0x1a0
Feb 07 17:14:14 heisenberg kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7=
e
Feb 07 17:14:14 heisenberg kernel: RIP: 0033:0x7f80ed0f2a6a
Feb 07 17:14:14 heisenberg kernel: Code: 73 01 c3 48 8b 0d a6 23 0d 00 f7 d=
8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 a=
f 01 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 76 23 0d 00 f7 d8 64=
 89 01 48
Feb 07 17:14:14 heisenberg kernel: RSP: 002b:00007ffee20bd628 EFLAGS: 00000=
246 ORIG_RAX: 00000000000001af
Feb 07 17:14:14 heisenberg kernel: RAX: ffffffffffffffda RBX: 00005607c7efa=
b80 RCX: 00007f80ed0f2a6a
Feb 07 17:14:14 heisenberg kernel: RDX: 0000000000000000 RSI: 0000000000000=
006 RDI: 0000000000000003
Feb 07 17:14:14 heisenberg kernel: RBP: 0000000000000000 R08: 0000000000000=
000 R09: 0000000000000000
Feb 07 17:14:14 heisenberg kernel: R10: 0000000000000000 R11: 0000000000000=
246 R12: 00005607c7efc960
Feb 07 17:14:14 heisenberg kernel: R13: 00007f80ed28026c R14: 00007f80ed27e=
560 R15: 00007f80ed28026c
Feb 07 17:14:14 heisenberg kernel:  </TASK>
Feb 07 17:14:14 heisenberg kernel: ---[ end trace 0000000000000000 ]---
Feb 07 17:14:14 heisenberg kernel: ------------[ cut here ]------------
Feb 07 17:14:14 heisenberg kernel: WARNING: CPU: 4 PID: 157055 at fs/btrfs/=
block-rsv.c:465 btrfs_release_global_block_rsv+0xc8/0xd0 [btrfs]
Feb 07 17:14:14 heisenberg kernel: Modules linked in: cpuid ext4 mbcache jb=
d2 sg uas nft_fib_ipv6 nft_ct nft_fib_ipv4 nft_fib wireguard libcurve25519 =
libchacha20poly1305 libchacha ip6_udp_tunnel udp_tunnel libpoly1305 cmac cc=
m snd_seq_dummy snd_hrtimer snd_seq snd_ctl_led snd_soc_skl_hda_dsp snd_soc=
_intel_sof_board_helpers snd_sof_probes snd_soc_intel_hda_dsp_common xe snd=
_hda_codec_intelhdmi snd_hda_codec_alc269 snd_hda_scodec_component drm_gpuv=
m snd_hda_codec_realtek_lib drm_gpusvm_helper snd_hda_codec_generic gpu_sch=
ed snd_soc_dmic drm_ttm_helper drm_exec drm_suballoc_helper ip6t_REJECT nf_=
reject_ipv6 ipt_REJECT nf_reject_ipv4 snd_hda_intel xt_tcpudp snd_sof_pci_i=
ntel_tgl xt_conntrack snd_sof_pci_intel_cnl nf_conntrack snd_sof_intel_hda_=
generic nf_defrag_ipv6 soundwire_intel nf_defrag_ipv4 snd_sof_intel_hda_sdw=
_bpt nft_compat nf_tables snd_sof_intel_hda_common intel_uncore_frequency j=
oydev intel_uncore_frequency_common binfmt_misc x_tables snd_soc_hdac_hda x=
86_pkg_temp_thermal snd_sof_intel_hda_mlink intel_powerclamp snd_sof_intel_=
hda
Feb 07 17:14:14 heisenberg kernel:  i915 snd_hda_codec_hdmi soundwire_caden=
ce snd_sof_pci coretemp snd_sof_xtensa_dsp snd_sof kvm_intel snd_sof_utils =
snd_soc_acpi_intel_match snd_soc_acpi_intel_sdca_quirks soundwire_generic_a=
llocation kvm snd_soc_acpi hid_multitouch crc8 soundwire_bus iwlmvm snd_soc=
_sdca snd_soc_avs btusb uvcvideo btmtk irqbypass snd_soc_hda_codec btrtl vi=
deobuf2_vmalloc ghash_clmulni_intel drm_buddy btbcm snd_hda_ext_core uvc hi=
d_generic snd_hda_codec btintel iTCO_wdt rapl videobuf2_memops ttm sdhci_pc=
i snd_usb_audio intel_pmc_bxt processor_thermal_device_pci mac80211 intel_r=
apl_msr videobuf2_v4l2 snd_hda_core sdhci_uhs2 drm_display_helper bluetooth=
 intel_cstate iTCO_vendor_support snd_usbmidi_lib videodev processor_therma=
l_device sdhci snd_intel_dspcfg processor_thermal_wt_hint platform_temperat=
ure_control snd_rawmidi cec videobuf2_common snd_intel_sdw_acpi cqhci proce=
ssor_thermal_soc_slider snd_seq_device snd_hwdep mei_hdcp watchdog mei_pxp =
ee1004 wmi_bmof usbhid mc ecdh_generic libarc4 intel_uncore crc16 intel_pmc=
_core
Feb 07 17:14:14 heisenberg kernel:  mmc_core snd_soc_core rc_core platform_=
profile pmt_telemetry snd_compress ucsi_acpi processor_thermal_rfim drm_cli=
ent_lib snd_pcm_dmaengine processor_thermal_rapl typec_ucsi iwlwifi pmt_dis=
covery drm_kms_helper snd_pcm i2c_hid_acpi intel_rapl_common typec pmt_clas=
s i2c_hid i2c_algo_bit int3400_thermal hid roles fujitsu_laptop intel_pmc_s=
sram_telemetry acpi_thermal_rel acpi_pad acpi_tad cfg80211 battery button v=
ideo processor_thermal_wt_req i2c_i801 snd_timer processor_thermal_power_fl=
oor i2c_smbus mei_me snd intel_lpss_pci processor_thermal_mbox soundcore in=
tel_lpss mei rfkill wmi idma64 intel_vsec ac int340x_thermal_zone igen6_eda=
c parport_pc lp ppdev drm parport efi_pstore configfs nfnetlink autofs4 crc=
32c_cryptoapi sd_mod dm_crypt dm_mod raid10 raid456 async_raid6_recov async=
_memcpy async_pq async_xor async_tx raid1 raid0 md_mod usb_storage scsi_mod=
 scsi_common btrfs blake2b_generic xor raid6_pq xhci_pci xhci_hcd nvme thun=
derbolt nvme_core usbcore e1000e evdev nvme_keyring nvme_auth serio_raw int=
el_hid
Feb 07 17:14:14 heisenberg kernel:  fan pcspkr aesni_intel usb_common hkdf =
sparse_keymap efivarfs
Feb 07 17:14:14 heisenberg kernel: CPU: 4 UID: 0 PID: 157055 Comm: mount Ta=
inted: G        W           6.18.8+deb14-amd64 #1 PREEMPT(lazy)  Debian 6.1=
8.8-1=20
Feb 07 17:14:14 heisenberg kernel: Tainted: [W]=3DWARN
Feb 07 17:14:14 heisenberg kernel: Hardware name: FUJITSU CLIENT COMPUTING =
LIMITED LIFEBOOK U7512/FJNB2F4, BIOS Version 2.35 07/01/2025
Feb 07 17:14:14 heisenberg kernel: RIP: 0010:btrfs_release_global_block_rsv=
+0xc8/0xd0 [btrfs]
Feb 07 17:14:14 heisenberg kernel: Code: 01 00 00 00 74 a6 0f 0b 48 83 bb 7=
0 01 00 00 00 74 a4 0f 0b 48 83 bb 78 01 00 00 00 74 a2 0f 0b 48 83 bb a8 0=
1 00 00 00 74 a0 <0f> 0b eb 9c 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90=
 90 90 90
Feb 07 17:14:14 heisenberg kernel: RSP: 0018:ffffd1b300ce7948 EFLAGS: 00010=
206
Feb 07 17:14:14 heisenberg kernel: RAX: 000000001ffc8000 RBX: ffff8dd16e1d1=
000 RCX: 0000000020000000
Feb 07 17:14:14 heisenberg kernel: RDX: 000000001ffc8000 RSI: ffff8dd725b55=
800 RDI: ffff8dd725b5581c
Feb 07 17:14:14 heisenberg kernel: RBP: ffff8dd725b50400 R08: ffff8dd725b50=
400 R09: 0000000000200003
Feb 07 17:14:14 heisenberg kernel: R10: 00000000003d4000 R11: ffff8dd725b55=
800 R12: ffff8dd16e1d1090
Feb 07 17:14:14 heisenberg kernel: R13: ffff8dd16e1d1718 R14: 0000000000000=
000 R15: dead000000000100
Feb 07 17:14:14 heisenberg kernel: FS:  00007f80ecec9840(0000) GS:ffff8de10=
10cc000(0000) knlGS:0000000000000000
Feb 07 17:14:14 heisenberg kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000=
080050033
Feb 07 17:14:14 heisenberg kernel: CR2: 00007f2584823f80 CR3: 0000000e03722=
004 CR4: 0000000000f72ef0
Feb 07 17:14:14 heisenberg kernel: PKRU: 55555554
Feb 07 17:14:14 heisenberg kernel: Call Trace:
Feb 07 17:14:14 heisenberg kernel:  <TASK>
Feb 07 17:14:14 heisenberg kernel:  btrfs_free_block_groups+0x34a/0x3d0 [bt=
rfs]
Feb 07 17:14:14 heisenberg kernel:  close_ctree+0x457/0x490 [btrfs]
Feb 07 17:14:14 heisenberg kernel:  ? btrfs_get_root_ref+0x2a7/0x3b0 [btrfs=
]
Feb 07 17:14:14 heisenberg kernel:  open_ctree+0x12d6/0x15a0 [btrfs]
Feb 07 17:14:14 heisenberg kernel:  btrfs_get_tree.cold+0xb/0xb6 [btrfs]
Feb 07 17:14:14 heisenberg kernel:  ? __fs_parse+0x68/0x1c0
Feb 07 17:14:14 heisenberg kernel:  vfs_get_tree+0x29/0xd0
Feb 07 17:14:14 heisenberg kernel:  vfs_cmd_create+0x57/0xd0
Feb 07 17:14:14 heisenberg kernel:  __do_sys_fsconfig+0x4b6/0x650
Feb 07 17:14:14 heisenberg kernel:  do_syscall_64+0x81/0x7f0
Feb 07 17:14:14 heisenberg kernel:  ? rw_verify_area+0x56/0x180
Feb 07 17:14:14 heisenberg kernel:  ? vfs_read+0xbf/0x390
Feb 07 17:14:14 heisenberg kernel:  ? fscontext_read+0x16a/0x180
Feb 07 17:14:14 heisenberg kernel:  ? rw_verify_area+0x56/0x180
Feb 07 17:14:14 heisenberg kernel:  ? fs_param_is_enum+0x53/0xa0
Feb 07 17:14:14 heisenberg kernel:  ? __fs_parse+0xac/0x1c0
Feb 07 17:14:14 heisenberg kernel:  ? ksys_read+0x73/0xf0
Feb 07 17:14:14 heisenberg kernel:  ? do_syscall_64+0xb9/0x7f0
Feb 07 17:14:14 heisenberg kernel:  ? __do_sys_fsconfig+0x359/0x650
Feb 07 17:14:14 heisenberg kernel:  ? do_syscall_64+0xb9/0x7f0
Feb 07 17:14:14 heisenberg kernel:  ? do_faccessat+0x1d7/0x2d0
Feb 07 17:14:14 heisenberg kernel:  ? __x64_sys_access+0x1c/0x30
Feb 07 17:14:14 heisenberg kernel:  ? do_syscall_64+0xb9/0x7f0
Feb 07 17:14:14 heisenberg kernel:  ? do_syscall_64+0xb9/0x7f0
Feb 07 17:14:14 heisenberg kernel:  ? do_syscall_64+0xb9/0x7f0
Feb 07 17:14:14 heisenberg kernel:  ? exc_page_fault+0x7e/0x1a0
Feb 07 17:14:14 heisenberg kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7=
e
Feb 07 17:14:14 heisenberg kernel: RIP: 0033:0x7f80ed0f2a6a
Feb 07 17:14:14 heisenberg kernel: Code: 73 01 c3 48 8b 0d a6 23 0d 00 f7 d=
8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 a=
f 01 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 76 23 0d 00 f7 d8 64=
 89 01 48
Feb 07 17:14:14 heisenberg kernel: RSP: 002b:00007ffee20bd628 EFLAGS: 00000=
246 ORIG_RAX: 00000000000001af
Feb 07 17:14:14 heisenberg kernel: RAX: ffffffffffffffda RBX: 00005607c7efa=
b80 RCX: 00007f80ed0f2a6a
Feb 07 17:14:14 heisenberg kernel: RDX: 0000000000000000 RSI: 0000000000000=
006 RDI: 0000000000000003
Feb 07 17:14:14 heisenberg kernel: RBP: 0000000000000000 R08: 0000000000000=
000 R09: 0000000000000000
Feb 07 17:14:14 heisenberg kernel: R10: 0000000000000000 R11: 0000000000000=
246 R12: 00005607c7efc960
Feb 07 17:14:14 heisenberg kernel: R13: 00007f80ed28026c R14: 00007f80ed27e=
560 R15: 00007f80ed28026c
Feb 07 17:14:14 heisenberg kernel:  </TASK>
Feb 07 17:14:14 heisenberg kernel: ---[ end trace 0000000000000000 ]---
Feb 07 17:14:14 heisenberg kernel: ------------[ cut here ]------------
Feb 07 17:14:14 heisenberg kernel: WARNING: CPU: 4 PID: 157055 at fs/btrfs/=
block-rsv.c:466 btrfs_release_global_block_rsv+0x78/0xd0 [btrfs]
Feb 07 17:14:14 heisenberg kernel: Modules linked in: cpuid ext4 mbcache jb=
d2 sg uas nft_fib_ipv6 nft_ct nft_fib_ipv4 nft_fib wireguard libcurve25519 =
libchacha20poly1305 libchacha ip6_udp_tunnel udp_tunnel libpoly1305 cmac cc=
m snd_seq_dummy snd_hrtimer snd_seq snd_ctl_led snd_soc_skl_hda_dsp snd_soc=
_intel_sof_board_helpers snd_sof_probes snd_soc_intel_hda_dsp_common xe snd=
_hda_codec_intelhdmi snd_hda_codec_alc269 snd_hda_scodec_component drm_gpuv=
m snd_hda_codec_realtek_lib drm_gpusvm_helper snd_hda_codec_generic gpu_sch=
ed snd_soc_dmic drm_ttm_helper drm_exec drm_suballoc_helper ip6t_REJECT nf_=
reject_ipv6 ipt_REJECT nf_reject_ipv4 snd_hda_intel xt_tcpudp snd_sof_pci_i=
ntel_tgl xt_conntrack snd_sof_pci_intel_cnl nf_conntrack snd_sof_intel_hda_=
generic nf_defrag_ipv6 soundwire_intel nf_defrag_ipv4 snd_sof_intel_hda_sdw=
_bpt nft_compat nf_tables snd_sof_intel_hda_common intel_uncore_frequency j=
oydev intel_uncore_frequency_common binfmt_misc x_tables snd_soc_hdac_hda x=
86_pkg_temp_thermal snd_sof_intel_hda_mlink intel_powerclamp snd_sof_intel_=
hda
Feb 07 17:14:14 heisenberg kernel:  i915 snd_hda_codec_hdmi soundwire_caden=
ce snd_sof_pci coretemp snd_sof_xtensa_dsp snd_sof kvm_intel snd_sof_utils =
snd_soc_acpi_intel_match snd_soc_acpi_intel_sdca_quirks soundwire_generic_a=
llocation kvm snd_soc_acpi hid_multitouch crc8 soundwire_bus iwlmvm snd_soc=
_sdca snd_soc_avs btusb uvcvideo btmtk irqbypass snd_soc_hda_codec btrtl vi=
deobuf2_vmalloc ghash_clmulni_intel drm_buddy btbcm snd_hda_ext_core uvc hi=
d_generic snd_hda_codec btintel iTCO_wdt rapl videobuf2_memops ttm sdhci_pc=
i snd_usb_audio intel_pmc_bxt processor_thermal_device_pci mac80211 intel_r=
apl_msr videobuf2_v4l2 snd_hda_core sdhci_uhs2 drm_display_helper bluetooth=
 intel_cstate iTCO_vendor_support snd_usbmidi_lib videodev processor_therma=
l_device sdhci snd_intel_dspcfg processor_thermal_wt_hint platform_temperat=
ure_control snd_rawmidi cec videobuf2_common snd_intel_sdw_acpi cqhci proce=
ssor_thermal_soc_slider snd_seq_device snd_hwdep mei_hdcp watchdog mei_pxp =
ee1004 wmi_bmof usbhid mc ecdh_generic libarc4 intel_uncore crc16 intel_pmc=
_core
Feb 07 17:14:14 heisenberg kernel:  mmc_core snd_soc_core rc_core platform_=
profile pmt_telemetry snd_compress ucsi_acpi processor_thermal_rfim drm_cli=
ent_lib snd_pcm_dmaengine processor_thermal_rapl typec_ucsi iwlwifi pmt_dis=
covery drm_kms_helper snd_pcm i2c_hid_acpi intel_rapl_common typec pmt_clas=
s i2c_hid i2c_algo_bit int3400_thermal hid roles fujitsu_laptop intel_pmc_s=
sram_telemetry acpi_thermal_rel acpi_pad acpi_tad cfg80211 battery button v=
ideo processor_thermal_wt_req i2c_i801 snd_timer processor_thermal_power_fl=
oor i2c_smbus mei_me snd intel_lpss_pci processor_thermal_mbox soundcore in=
tel_lpss mei rfkill wmi idma64 intel_vsec ac int340x_thermal_zone igen6_eda=
c parport_pc lp ppdev drm parport efi_pstore configfs nfnetlink autofs4 crc=
32c_cryptoapi sd_mod dm_crypt dm_mod raid10 raid456 async_raid6_recov async=
_memcpy async_pq async_xor async_tx raid1 raid0 md_mod usb_storage scsi_mod=
 scsi_common btrfs blake2b_generic xor raid6_pq xhci_pci xhci_hcd nvme thun=
derbolt nvme_core usbcore e1000e evdev nvme_keyring nvme_auth serio_raw int=
el_hid
Feb 07 17:14:14 heisenberg kernel:  fan pcspkr aesni_intel usb_common hkdf =
sparse_keymap efivarfs
Feb 07 17:14:14 heisenberg kernel: CPU: 4 UID: 0 PID: 157055 Comm: mount Ta=
inted: G        W           6.18.8+deb14-amd64 #1 PREEMPT(lazy)  Debian 6.1=
8.8-1=20
Feb 07 17:14:14 heisenberg kernel: Tainted: [W]=3DWARN
Feb 07 17:14:14 heisenberg kernel: Hardware name: FUJITSU CLIENT COMPUTING =
LIMITED LIFEBOOK U7512/FJNB2F4, BIOS Version 2.35 07/01/2025
Feb 07 17:14:14 heisenberg kernel: RIP: 0010:btrfs_release_global_block_rsv=
+0x78/0xd0 [btrfs]
Feb 07 17:14:14 heisenberg kernel: Code: 01 00 00 00 75 5c 48 83 bb 78 01 0=
0 00 00 75 5e 48 83 bb a8 01 00 00 00 75 60 48 83 bb a0 01 00 00 00 75 06 5=
b c3 cc cc cc cc <0f> 0b 5b c3 cc cc cc cc 0f 0b 48 83 bb 18 01 00 00 00 74=
 aa 0f 0b
Feb 07 17:14:14 heisenberg kernel: RSP: 0018:ffffd1b300ce7948 EFLAGS: 00010=
206
Feb 07 17:14:14 heisenberg kernel: RAX: 000000001ffc8000 RBX: ffff8dd16e1d1=
000 RCX: 0000000020000000
Feb 07 17:14:14 heisenberg kernel: RDX: 000000001ffc8000 RSI: ffff8dd725b55=
800 RDI: ffff8dd725b5581c
Feb 07 17:14:14 heisenberg kernel: RBP: ffff8dd725b50400 R08: ffff8dd725b50=
400 R09: 0000000000200003
Feb 07 17:14:14 heisenberg kernel: R10: 00000000003d4000 R11: ffff8dd725b55=
800 R12: ffff8dd16e1d1090
Feb 07 17:14:14 heisenberg kernel: R13: ffff8dd16e1d1718 R14: 0000000000000=
000 R15: dead000000000100
Feb 07 17:14:14 heisenberg kernel: FS:  00007f80ecec9840(0000) GS:ffff8de10=
10cc000(0000) knlGS:0000000000000000
Feb 07 17:14:14 heisenberg kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000=
080050033
Feb 07 17:14:14 heisenberg kernel: CR2: 00007f2584823f80 CR3: 0000000e03722=
004 CR4: 0000000000f72ef0
Feb 07 17:14:14 heisenberg kernel: PKRU: 55555554
Feb 07 17:14:14 heisenberg kernel: Call Trace:
Feb 07 17:14:14 heisenberg kernel:  <TASK>
Feb 07 17:14:14 heisenberg kernel:  btrfs_free_block_groups+0x34a/0x3d0 [bt=
rfs]
Feb 07 17:14:14 heisenberg kernel:  close_ctree+0x457/0x490 [btrfs]
Feb 07 17:14:14 heisenberg kernel:  ? btrfs_get_root_ref+0x2a7/0x3b0 [btrfs=
]
Feb 07 17:14:14 heisenberg kernel:  open_ctree+0x12d6/0x15a0 [btrfs]
Feb 07 17:14:14 heisenberg kernel:  btrfs_get_tree.cold+0xb/0xb6 [btrfs]
Feb 07 17:14:14 heisenberg kernel:  ? __fs_parse+0x68/0x1c0
Feb 07 17:14:14 heisenberg kernel:  vfs_get_tree+0x29/0xd0
Feb 07 17:14:14 heisenberg kernel:  vfs_cmd_create+0x57/0xd0
Feb 07 17:14:14 heisenberg kernel:  __do_sys_fsconfig+0x4b6/0x650
Feb 07 17:14:14 heisenberg kernel:  do_syscall_64+0x81/0x7f0
Feb 07 17:14:14 heisenberg kernel:  ? rw_verify_area+0x56/0x180
Feb 07 17:14:14 heisenberg kernel:  ? vfs_read+0xbf/0x390
Feb 07 17:14:14 heisenberg kernel:  ? fscontext_read+0x16a/0x180
Feb 07 17:14:14 heisenberg kernel:  ? rw_verify_area+0x56/0x180
Feb 07 17:14:14 heisenberg kernel:  ? fs_param_is_enum+0x53/0xa0
Feb 07 17:14:14 heisenberg kernel:  ? __fs_parse+0xac/0x1c0
Feb 07 17:14:14 heisenberg kernel:  ? ksys_read+0x73/0xf0
Feb 07 17:14:14 heisenberg kernel:  ? do_syscall_64+0xb9/0x7f0
Feb 07 17:14:14 heisenberg kernel:  ? __do_sys_fsconfig+0x359/0x650
Feb 07 17:14:14 heisenberg kernel:  ? do_syscall_64+0xb9/0x7f0
Feb 07 17:14:14 heisenberg kernel:  ? do_faccessat+0x1d7/0x2d0
Feb 07 17:14:14 heisenberg kernel:  ? __x64_sys_access+0x1c/0x30
Feb 07 17:14:14 heisenberg kernel:  ? do_syscall_64+0xb9/0x7f0
Feb 07 17:14:14 heisenberg kernel:  ? do_syscall_64+0xb9/0x7f0
Feb 07 17:14:14 heisenberg kernel:  ? do_syscall_64+0xb9/0x7f0
Feb 07 17:14:14 heisenberg kernel:  ? exc_page_fault+0x7e/0x1a0
Feb 07 17:14:14 heisenberg kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7=
e
Feb 07 17:14:14 heisenberg kernel: RIP: 0033:0x7f80ed0f2a6a
Feb 07 17:14:14 heisenberg kernel: Code: 73 01 c3 48 8b 0d a6 23 0d 00 f7 d=
8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 a=
f 01 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 76 23 0d 00 f7 d8 64=
 89 01 48
Feb 07 17:14:14 heisenberg kernel: RSP: 002b:00007ffee20bd628 EFLAGS: 00000=
246 ORIG_RAX: 00000000000001af
Feb 07 17:14:14 heisenberg kernel: RAX: ffffffffffffffda RBX: 00005607c7efa=
b80 RCX: 00007f80ed0f2a6a
Feb 07 17:14:14 heisenberg kernel: RDX: 0000000000000000 RSI: 0000000000000=
006 RDI: 0000000000000003
Feb 07 17:14:14 heisenberg kernel: RBP: 0000000000000000 R08: 0000000000000=
000 R09: 0000000000000000
Feb 07 17:14:14 heisenberg kernel: R10: 0000000000000000 R11: 0000000000000=
246 R12: 00005607c7efc960
Feb 07 17:14:14 heisenberg kernel: R13: 00007f80ed28026c R14: 00007f80ed27e=
560 R15: 00007f80ed28026c
Feb 07 17:14:14 heisenberg kernel:  </TASK>
Feb 07 17:14:14 heisenberg kernel: ---[ end trace 0000000000000000 ]---
Feb 07 17:14:14 heisenberg kernel: ------------[ cut here ]------------
Feb 07 17:14:14 heisenberg kernel: WARNING: CPU: 4 PID: 157055 at fs/btrfs/=
block-group.c:4462 check_removing_space_info+0x6e/0xa0 [btrfs]
Feb 07 17:14:14 heisenberg kernel: Modules linked in: cpuid ext4 mbcache jb=
d2 sg uas nft_fib_ipv6 nft_ct nft_fib_ipv4 nft_fib wireguard libcurve25519 =
libchacha20poly1305 libchacha ip6_udp_tunnel udp_tunnel libpoly1305 cmac cc=
m snd_seq_dummy snd_hrtimer snd_seq snd_ctl_led snd_soc_skl_hda_dsp snd_soc=
_intel_sof_board_helpers snd_sof_probes snd_soc_intel_hda_dsp_common xe snd=
_hda_codec_intelhdmi snd_hda_codec_alc269 snd_hda_scodec_component drm_gpuv=
m snd_hda_codec_realtek_lib drm_gpusvm_helper snd_hda_codec_generic gpu_sch=
ed snd_soc_dmic drm_ttm_helper drm_exec drm_suballoc_helper ip6t_REJECT nf_=
reject_ipv6 ipt_REJECT nf_reject_ipv4 snd_hda_intel xt_tcpudp snd_sof_pci_i=
ntel_tgl xt_conntrack snd_sof_pci_intel_cnl nf_conntrack snd_sof_intel_hda_=
generic nf_defrag_ipv6 soundwire_intel nf_defrag_ipv4 snd_sof_intel_hda_sdw=
_bpt nft_compat nf_tables snd_sof_intel_hda_common intel_uncore_frequency j=
oydev intel_uncore_frequency_common binfmt_misc x_tables snd_soc_hdac_hda x=
86_pkg_temp_thermal snd_sof_intel_hda_mlink intel_powerclamp snd_sof_intel_=
hda
Feb 07 17:14:14 heisenberg kernel:  i915 snd_hda_codec_hdmi soundwire_caden=
ce snd_sof_pci coretemp snd_sof_xtensa_dsp snd_sof kvm_intel snd_sof_utils =
snd_soc_acpi_intel_match snd_soc_acpi_intel_sdca_quirks soundwire_generic_a=
llocation kvm snd_soc_acpi hid_multitouch crc8 soundwire_bus iwlmvm snd_soc=
_sdca snd_soc_avs btusb uvcvideo btmtk irqbypass snd_soc_hda_codec btrtl vi=
deobuf2_vmalloc ghash_clmulni_intel drm_buddy btbcm snd_hda_ext_core uvc hi=
d_generic snd_hda_codec btintel iTCO_wdt rapl videobuf2_memops ttm sdhci_pc=
i snd_usb_audio intel_pmc_bxt processor_thermal_device_pci mac80211 intel_r=
apl_msr videobuf2_v4l2 snd_hda_core sdhci_uhs2 drm_display_helper bluetooth=
 intel_cstate iTCO_vendor_support snd_usbmidi_lib videodev processor_therma=
l_device sdhci snd_intel_dspcfg processor_thermal_wt_hint platform_temperat=
ure_control snd_rawmidi cec videobuf2_common snd_intel_sdw_acpi cqhci proce=
ssor_thermal_soc_slider snd_seq_device snd_hwdep mei_hdcp watchdog mei_pxp =
ee1004 wmi_bmof usbhid mc ecdh_generic libarc4 intel_uncore crc16 intel_pmc=
_core
Feb 07 17:14:14 heisenberg kernel:  mmc_core snd_soc_core rc_core platform_=
profile pmt_telemetry snd_compress ucsi_acpi processor_thermal_rfim drm_cli=
ent_lib snd_pcm_dmaengine processor_thermal_rapl typec_ucsi iwlwifi pmt_dis=
covery drm_kms_helper snd_pcm i2c_hid_acpi intel_rapl_common typec pmt_clas=
s i2c_hid i2c_algo_bit int3400_thermal hid roles fujitsu_laptop intel_pmc_s=
sram_telemetry acpi_thermal_rel acpi_pad acpi_tad cfg80211 battery button v=
ideo processor_thermal_wt_req i2c_i801 snd_timer processor_thermal_power_fl=
oor i2c_smbus mei_me snd intel_lpss_pci processor_thermal_mbox soundcore in=
tel_lpss mei rfkill wmi idma64 intel_vsec ac int340x_thermal_zone igen6_eda=
c parport_pc lp ppdev drm parport efi_pstore configfs nfnetlink autofs4 crc=
32c_cryptoapi sd_mod dm_crypt dm_mod raid10 raid456 async_raid6_recov async=
_memcpy async_pq async_xor async_tx raid1 raid0 md_mod usb_storage scsi_mod=
 scsi_common btrfs blake2b_generic xor raid6_pq xhci_pci xhci_hcd nvme thun=
derbolt nvme_core usbcore e1000e evdev nvme_keyring nvme_auth serio_raw int=
el_hid
Feb 07 17:14:14 heisenberg kernel:  fan pcspkr aesni_intel usb_common hkdf =
sparse_keymap efivarfs
Feb 07 17:14:14 heisenberg kernel: CPU: 4 UID: 0 PID: 157055 Comm: mount Ta=
inted: G        W           6.18.8+deb14-amd64 #1 PREEMPT(lazy)  Debian 6.1=
8.8-1=20
Feb 07 17:14:14 heisenberg kernel: Tainted: [W]=3DWARN
Feb 07 17:14:14 heisenberg kernel: Hardware name: FUJITSU CLIENT COMPUTING =
LIMITED LIFEBOOK U7512/FJNB2F4, BIOS Version 2.35 07/01/2025
Feb 07 17:14:14 heisenberg kernel: RIP: 0010:check_removing_space_info+0x6e=
/0xa0 [btrfs]
Feb 07 17:14:14 heisenberg kernel: Code: 00 00 00 04 74 0c 48 8b 85 b0 0a 0=
0 00 f6 c4 01 75 07 48 83 7b 38 00 75 2d 48 83 bb d0 00 00 00 00 75 1a 5b 5=
d c3 cc cc cc cc <0f> 0b 31 c9 31 d2 48 89 de 48 89 ef e8 81 d9 ff ff eb c0=
 0f 0b 5b
Feb 07 17:14:14 heisenberg kernel: RSP: 0018:ffffd1b300ce7940 EFLAGS: 00010=
206
Feb 07 17:14:14 heisenberg kernel: RAX: 0000000000000000 RBX: ffff8dd725b55=
800 RCX: 0000002171792004
Feb 07 17:14:14 heisenberg kernel: RDX: 0000002171790004 RSI: ffffffffae46b=
0c0 RDI: 0000000000000000
Feb 07 17:14:14 heisenberg kernel: RBP: ffff8dd16e1d1000 R08: 0000000000000=
000 R09: ffffffffac8ea912
Feb 07 17:14:14 heisenberg kernel: R10: ffff8ddd4f3e1c70 R11: ffff8dd140042=
400 R12: ffff8dd725b55800
Feb 07 17:14:14 heisenberg kernel: R13: ffff8dd16e1d1718 R14: dead000000000=
122 R15: dead000000000100
Feb 07 17:14:14 heisenberg kernel: FS:  00007f80ecec9840(0000) GS:ffff8de10=
10cc000(0000) knlGS:0000000000000000
Feb 07 17:14:14 heisenberg kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000=
080050033
Feb 07 17:14:14 heisenberg kernel: CR2: 00007f2584823f80 CR3: 0000000e03722=
004 CR4: 0000000000f72ef0
Feb 07 17:14:14 heisenberg kernel: PKRU: 55555554
Feb 07 17:14:14 heisenberg kernel: Call Trace:
Feb 07 17:14:14 heisenberg kernel:  <TASK>
Feb 07 17:14:14 heisenberg kernel:  btrfs_free_block_groups+0x380/0x3d0 [bt=
rfs]
Feb 07 17:14:14 heisenberg kernel:  close_ctree+0x457/0x490 [btrfs]
Feb 07 17:14:14 heisenberg kernel:  ? btrfs_get_root_ref+0x2a7/0x3b0 [btrfs=
]
Feb 07 17:14:14 heisenberg kernel:  open_ctree+0x12d6/0x15a0 [btrfs]
Feb 07 17:14:14 heisenberg kernel:  btrfs_get_tree.cold+0xb/0xb6 [btrfs]
Feb 07 17:14:14 heisenberg kernel:  ? __fs_parse+0x68/0x1c0
Feb 07 17:14:14 heisenberg kernel:  vfs_get_tree+0x29/0xd0
Feb 07 17:14:14 heisenberg kernel:  vfs_cmd_create+0x57/0xd0
Feb 07 17:14:14 heisenberg kernel:  __do_sys_fsconfig+0x4b6/0x650
Feb 07 17:14:14 heisenberg kernel:  do_syscall_64+0x81/0x7f0
Feb 07 17:14:14 heisenberg kernel:  ? rw_verify_area+0x56/0x180
Feb 07 17:14:14 heisenberg kernel:  ? vfs_read+0xbf/0x390
Feb 07 17:14:14 heisenberg kernel:  ? fscontext_read+0x16a/0x180
Feb 07 17:14:14 heisenberg kernel:  ? rw_verify_area+0x56/0x180
Feb 07 17:14:14 heisenberg kernel:  ? fs_param_is_enum+0x53/0xa0
Feb 07 17:14:14 heisenberg kernel:  ? __fs_parse+0xac/0x1c0
Feb 07 17:14:14 heisenberg kernel:  ? ksys_read+0x73/0xf0
Feb 07 17:14:14 heisenberg kernel:  ? do_syscall_64+0xb9/0x7f0
Feb 07 17:14:14 heisenberg kernel:  ? __do_sys_fsconfig+0x359/0x650
Feb 07 17:14:14 heisenberg kernel:  ? do_syscall_64+0xb9/0x7f0
Feb 07 17:14:14 heisenberg kernel:  ? do_faccessat+0x1d7/0x2d0
Feb 07 17:14:14 heisenberg kernel:  ? __x64_sys_access+0x1c/0x30
Feb 07 17:14:14 heisenberg kernel:  ? do_syscall_64+0xb9/0x7f0
Feb 07 17:14:14 heisenberg kernel:  ? do_syscall_64+0xb9/0x7f0
Feb 07 17:14:14 heisenberg kernel:  ? do_syscall_64+0xb9/0x7f0
Feb 07 17:14:14 heisenberg kernel:  ? exc_page_fault+0x7e/0x1a0
Feb 07 17:14:14 heisenberg kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7=
e
Feb 07 17:14:14 heisenberg kernel: RIP: 0033:0x7f80ed0f2a6a
Feb 07 17:14:14 heisenberg kernel: Code: 73 01 c3 48 8b 0d a6 23 0d 00 f7 d=
8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 a=
f 01 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 76 23 0d 00 f7 d8 64=
 89 01 48
Feb 07 17:14:14 heisenberg kernel: RSP: 002b:00007ffee20bd628 EFLAGS: 00000=
246 ORIG_RAX: 00000000000001af
Feb 07 17:14:14 heisenberg kernel: RAX: ffffffffffffffda RBX: 00005607c7efa=
b80 RCX: 00007f80ed0f2a6a
Feb 07 17:14:14 heisenberg kernel: RDX: 0000000000000000 RSI: 0000000000000=
006 RDI: 0000000000000003
Feb 07 17:14:14 heisenberg kernel: RBP: 0000000000000000 R08: 0000000000000=
000 R09: 0000000000000000
Feb 07 17:14:14 heisenberg kernel: R10: 0000000000000000 R11: 0000000000000=
246 R12: 00005607c7efc960
Feb 07 17:14:14 heisenberg kernel: R13: 00007f80ed28026c R14: 00007f80ed27e=
560 R15: 00007f80ed28026c
Feb 07 17:14:14 heisenberg kernel:  </TASK>
Feb 07 17:14:14 heisenberg kernel: ---[ end trace 0000000000000000 ]---
Feb 07 17:14:14 heisenberg kernel: BTRFS info (device dm-2 state EA): space=
_info METADATA (sub-group id 0) has 691552256 free, is not full
Feb 07 17:14:14 heisenberg kernel: BTRFS info (device dm-2 state EA): space=
_info total=3D17716740096, used=3D17020256256, pinned=3D0, reserved=3D85196=
8, may_use=3D4014080, readonly=3D65536 zone_unusable=3D0
Feb 07 17:14:14 heisenberg kernel: BTRFS info (device dm-2 state EA): globa=
l_block_rsv: size 0 reserved 0
Feb 07 17:14:14 heisenberg kernel: BTRFS info (device dm-2 state EA): trans=
_block_rsv: size 0 reserved 0
Feb 07 17:14:14 heisenberg kernel: BTRFS info (device dm-2 state EA): chunk=
_block_rsv: size 0 reserved 0
Feb 07 17:14:14 heisenberg kernel: BTRFS info (device dm-2 state EA): delay=
ed_block_rsv: size 0 reserved 0
Feb 07 17:14:14 heisenberg kernel: BTRFS info (device dm-2 state EA): delay=
ed_refs_rsv: size 64487424 reserved 4014080
Feb 07 17:14:14 heisenberg kernel: ------------[ cut here ]------------
Feb 07 17:14:14 heisenberg kernel: WARNING: CPU: 4 PID: 157055 at fs/btrfs/=
block-group.c:4473 check_removing_space_info+0x8a/0xa0 [btrfs]
Feb 07 17:14:14 heisenberg kernel: Modules linked in: cpuid ext4 mbcache jb=
d2 sg uas nft_fib_ipv6 nft_ct nft_fib_ipv4 nft_fib wireguard libcurve25519 =
libchacha20poly1305 libchacha ip6_udp_tunnel udp_tunnel libpoly1305 cmac cc=
m snd_seq_dummy snd_hrtimer snd_seq snd_ctl_led snd_soc_skl_hda_dsp snd_soc=
_intel_sof_board_helpers snd_sof_probes snd_soc_intel_hda_dsp_common xe snd=
_hda_codec_intelhdmi snd_hda_codec_alc269 snd_hda_scodec_component drm_gpuv=
m snd_hda_codec_realtek_lib drm_gpusvm_helper snd_hda_codec_generic gpu_sch=
ed snd_soc_dmic drm_ttm_helper drm_exec drm_suballoc_helper ip6t_REJECT nf_=
reject_ipv6 ipt_REJECT nf_reject_ipv4 snd_hda_intel xt_tcpudp snd_sof_pci_i=
ntel_tgl xt_conntrack snd_sof_pci_intel_cnl nf_conntrack snd_sof_intel_hda_=
generic nf_defrag_ipv6 soundwire_intel nf_defrag_ipv4 snd_sof_intel_hda_sdw=
_bpt nft_compat nf_tables snd_sof_intel_hda_common intel_uncore_frequency j=
oydev intel_uncore_frequency_common binfmt_misc x_tables snd_soc_hdac_hda x=
86_pkg_temp_thermal snd_sof_intel_hda_mlink intel_powerclamp snd_sof_intel_=
hda
Feb 07 17:14:14 heisenberg kernel:  i915 snd_hda_codec_hdmi soundwire_caden=
ce snd_sof_pci coretemp snd_sof_xtensa_dsp snd_sof kvm_intel snd_sof_utils =
snd_soc_acpi_intel_match snd_soc_acpi_intel_sdca_quirks soundwire_generic_a=
llocation kvm snd_soc_acpi hid_multitouch crc8 soundwire_bus iwlmvm snd_soc=
_sdca snd_soc_avs btusb uvcvideo btmtk irqbypass snd_soc_hda_codec btrtl vi=
deobuf2_vmalloc ghash_clmulni_intel drm_buddy btbcm snd_hda_ext_core uvc hi=
d_generic snd_hda_codec btintel iTCO_wdt rapl videobuf2_memops ttm sdhci_pc=
i snd_usb_audio intel_pmc_bxt processor_thermal_device_pci mac80211 intel_r=
apl_msr videobuf2_v4l2 snd_hda_core sdhci_uhs2 drm_display_helper bluetooth=
 intel_cstate iTCO_vendor_support snd_usbmidi_lib videodev processor_therma=
l_device sdhci snd_intel_dspcfg processor_thermal_wt_hint platform_temperat=
ure_control snd_rawmidi cec videobuf2_common snd_intel_sdw_acpi cqhci proce=
ssor_thermal_soc_slider snd_seq_device snd_hwdep mei_hdcp watchdog mei_pxp =
ee1004 wmi_bmof usbhid mc ecdh_generic libarc4 intel_uncore crc16 intel_pmc=
_core
Feb 07 17:14:14 heisenberg kernel:  mmc_core snd_soc_core rc_core platform_=
profile pmt_telemetry snd_compress ucsi_acpi processor_thermal_rfim drm_cli=
ent_lib snd_pcm_dmaengine processor_thermal_rapl typec_ucsi iwlwifi pmt_dis=
covery drm_kms_helper snd_pcm i2c_hid_acpi intel_rapl_common typec pmt_clas=
s i2c_hid i2c_algo_bit int3400_thermal hid roles fujitsu_laptop intel_pmc_s=
sram_telemetry acpi_thermal_rel acpi_pad acpi_tad cfg80211 battery button v=
ideo processor_thermal_wt_req i2c_i801 snd_timer processor_thermal_power_fl=
oor i2c_smbus mei_me snd intel_lpss_pci processor_thermal_mbox soundcore in=
tel_lpss mei rfkill wmi idma64 intel_vsec ac int340x_thermal_zone igen6_eda=
c parport_pc lp ppdev drm parport efi_pstore configfs nfnetlink autofs4 crc=
32c_cryptoapi sd_mod dm_crypt dm_mod raid10 raid456 async_raid6_recov async=
_memcpy async_pq async_xor async_tx raid1 raid0 md_mod usb_storage scsi_mod=
 scsi_common btrfs blake2b_generic xor raid6_pq xhci_pci xhci_hcd nvme thun=
derbolt nvme_core usbcore e1000e evdev nvme_keyring nvme_auth serio_raw int=
el_hid
Feb 07 17:14:14 heisenberg kernel:  fan pcspkr aesni_intel usb_common hkdf =
sparse_keymap efivarfs
Feb 07 17:14:14 heisenberg kernel: CPU: 4 UID: 0 PID: 157055 Comm: mount Ta=
inted: G        W           6.18.8+deb14-amd64 #1 PREEMPT(lazy)  Debian 6.1=
8.8-1=20
Feb 07 17:14:14 heisenberg kernel: Tainted: [W]=3DWARN
Feb 07 17:14:14 heisenberg kernel: Hardware name: FUJITSU CLIENT COMPUTING =
LIMITED LIFEBOOK U7512/FJNB2F4, BIOS Version 2.35 07/01/2025
Feb 07 17:14:14 heisenberg kernel: RIP: 0010:check_removing_space_info+0x8a=
/0xa0 [btrfs]
Feb 07 17:14:14 heisenberg kernel: Code: d0 00 00 00 00 75 1a 5b 5d c3 cc c=
c cc cc 0f 0b 31 c9 31 d2 48 89 de 48 89 ef e8 81 d9 ff ff eb c0 0f 0b 5b 5=
d c3 cc cc cc cc <0f> 0b 31 c9 31 d2 48 89 de 48 89 ef e8 65 d9 ff ff eb c0=
 0f 1f 00
Feb 07 17:14:14 heisenberg kernel: RSP: 0018:ffffd1b300ce7940 EFLAGS: 00010=
206
Feb 07 17:14:14 heisenberg kernel: RAX: 0000000000000204 RBX: ffff8dd725b55=
800 RCX: 0000000000000027
Feb 07 17:14:14 heisenberg kernel: RDX: 0000000000000000 RSI: 0000000000000=
001 RDI: ffff8dd725b5581c
Feb 07 17:14:14 heisenberg kernel: RBP: ffff8dd16e1d1000 R08: 0000000000000=
000 R09: ffffd1b300ce76e8
Feb 07 17:14:14 heisenberg kernel: R10: ffffffffad8db948 R11: 00000000ffffe=
fff R12: ffff8dd725b55800
Feb 07 17:14:14 heisenberg kernel: R13: ffff8dd16e1d1718 R14: dead000000000=
122 R15: dead000000000100
Feb 07 17:14:14 heisenberg kernel: FS:  00007f80ecec9840(0000) GS:ffff8de10=
10cc000(0000) knlGS:0000000000000000
Feb 07 17:14:14 heisenberg kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000=
080050033
Feb 07 17:14:14 heisenberg kernel: CR2: 00007f2584823f80 CR3: 0000000e03722=
004 CR4: 0000000000f72ef0
Feb 07 17:14:14 heisenberg kernel: PKRU: 55555554
Feb 07 17:14:14 heisenberg kernel: Call Trace:
Feb 07 17:14:14 heisenberg kernel:  <TASK>
Feb 07 17:14:14 heisenberg kernel:  btrfs_free_block_groups+0x380/0x3d0 [bt=
rfs]
Feb 07 17:14:14 heisenberg kernel:  close_ctree+0x457/0x490 [btrfs]
Feb 07 17:14:14 heisenberg kernel:  ? btrfs_get_root_ref+0x2a7/0x3b0 [btrfs=
]
Feb 07 17:14:14 heisenberg kernel:  open_ctree+0x12d6/0x15a0 [btrfs]
Feb 07 17:14:14 heisenberg kernel:  btrfs_get_tree.cold+0xb/0xb6 [btrfs]
Feb 07 17:14:14 heisenberg kernel:  ? __fs_parse+0x68/0x1c0
Feb 07 17:14:14 heisenberg kernel:  vfs_get_tree+0x29/0xd0
Feb 07 17:14:14 heisenberg kernel:  vfs_cmd_create+0x57/0xd0
Feb 07 17:14:14 heisenberg kernel:  __do_sys_fsconfig+0x4b6/0x650
Feb 07 17:14:14 heisenberg kernel:  do_syscall_64+0x81/0x7f0
Feb 07 17:14:14 heisenberg kernel:  ? rw_verify_area+0x56/0x180
Feb 07 17:14:14 heisenberg kernel:  ? vfs_read+0xbf/0x390
Feb 07 17:14:14 heisenberg kernel:  ? fscontext_read+0x16a/0x180
Feb 07 17:14:14 heisenberg kernel:  ? rw_verify_area+0x56/0x180
Feb 07 17:14:14 heisenberg kernel:  ? fs_param_is_enum+0x53/0xa0
Feb 07 17:14:14 heisenberg kernel:  ? __fs_parse+0xac/0x1c0
Feb 07 17:14:14 heisenberg kernel:  ? ksys_read+0x73/0xf0
Feb 07 17:14:14 heisenberg kernel:  ? do_syscall_64+0xb9/0x7f0
Feb 07 17:14:14 heisenberg kernel:  ? __do_sys_fsconfig+0x359/0x650
Feb 07 17:14:14 heisenberg kernel:  ? do_syscall_64+0xb9/0x7f0
Feb 07 17:14:14 heisenberg kernel:  ? do_faccessat+0x1d7/0x2d0
Feb 07 17:14:14 heisenberg kernel:  ? __x64_sys_access+0x1c/0x30
Feb 07 17:14:14 heisenberg kernel:  ? do_syscall_64+0xb9/0x7f0
Feb 07 17:14:14 heisenberg kernel:  ? do_syscall_64+0xb9/0x7f0
Feb 07 17:14:14 heisenberg kernel:  ? do_syscall_64+0xb9/0x7f0
Feb 07 17:14:14 heisenberg kernel:  ? exc_page_fault+0x7e/0x1a0
Feb 07 17:14:14 heisenberg kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7=
e
Feb 07 17:14:14 heisenberg kernel: RIP: 0033:0x7f80ed0f2a6a
Feb 07 17:14:14 heisenberg kernel: Code: 73 01 c3 48 8b 0d a6 23 0d 00 f7 d=
8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 a=
f 01 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 76 23 0d 00 f7 d8 64=
 89 01 48
Feb 07 17:14:14 heisenberg kernel: RSP: 002b:00007ffee20bd628 EFLAGS: 00000=
246 ORIG_RAX: 00000000000001af
Feb 07 17:14:14 heisenberg kernel: RAX: ffffffffffffffda RBX: 00005607c7efa=
b80 RCX: 00007f80ed0f2a6a
Feb 07 17:14:14 heisenberg kernel: RDX: 0000000000000000 RSI: 0000000000000=
006 RDI: 0000000000000003
Feb 07 17:14:14 heisenberg kernel: RBP: 0000000000000000 R08: 0000000000000=
000 R09: 0000000000000000
Feb 07 17:14:14 heisenberg kernel: R10: 0000000000000000 R11: 0000000000000=
246 R12: 00005607c7efc960
Feb 07 17:14:14 heisenberg kernel: R13: 00007f80ed28026c R14: 00007f80ed27e=
560 R15: 00007f80ed28026c
Feb 07 17:14:14 heisenberg kernel:  </TASK>
Feb 07 17:14:14 heisenberg kernel: ---[ end trace 0000000000000000 ]---
Feb 07 17:14:14 heisenberg kernel: BTRFS info (device dm-2 state EA): space=
_info METADATA (sub-group id 0) has 691552256 free, is not full
Feb 07 17:14:14 heisenberg kernel: BTRFS info (device dm-2 state EA): space=
_info total=3D17716740096, used=3D17020256256, pinned=3D0, reserved=3D85196=
8, may_use=3D4014080, readonly=3D65536 zone_unusable=3D0
Feb 07 17:14:14 heisenberg kernel: BTRFS info (device dm-2 state EA): globa=
l_block_rsv: size 0 reserved 0
Feb 07 17:14:14 heisenberg kernel: BTRFS info (device dm-2 state EA): trans=
_block_rsv: size 0 reserved 0
Feb 07 17:14:14 heisenberg kernel: BTRFS info (device dm-2 state EA): chunk=
_block_rsv: size 0 reserved 0
Feb 07 17:14:14 heisenberg kernel: BTRFS info (device dm-2 state EA): delay=
ed_block_rsv: size 0 reserved 0
Feb 07 17:14:14 heisenberg kernel: BTRFS info (device dm-2 state EA): delay=
ed_refs_rsv: size 64487424 reserved 4014080
Feb 07 17:14:14 heisenberg kernel: BTRFS error (device dm-2 state EA): open=
_ctree failed: -2

(and the mount failed)

Just to be sure I did again with:
  $ mount -o space_cache=3Dv2,clear_cache,rw /dev/mapper/data-f /mnt/
but same:
Feb 07 17:15:32 heisenberg kernel: BTRFS: device label data-f devid 1 trans=
id 2934 /dev/mapper/data-f (253:2) scanned by mount (157318)
Feb 07 17:15:32 heisenberg kernel: BTRFS info (device dm-2): first mount of=
 filesystem 84ee379c-29da-4513-b31b-db5e6097ebc8
Feb 07 17:15:32 heisenberg kernel: BTRFS info (device dm-2): using crc32c (=
crc32c-lib) checksum algorithm
Feb 07 17:15:53 heisenberg kernel: BTRFS info (device dm-2): rebuilding fre=
e space tree
Feb 07 17:16:23 heisenberg kernel: ------------[ cut here ]------------
Feb 07 17:16:23 heisenberg kernel: WARNING: CPU: 8 PID: 157336 at fs/btrfs/=
transaction.c:144 btrfs_put_transaction+0x141/0x180 [btrfs]
Feb 07 17:16:23 heisenberg kernel: Modules linked in: cpuid ext4 mbcache jb=
d2 sg uas nft_fib_ipv6 nft_ct nft_fib_ipv4 nft_fib wireguard libcurve25519 =
libchacha20poly1305 libchacha ip6_udp_tunnel udp_tunnel libpoly1305 cmac cc=
m snd_seq_dummy snd_hrtimer snd_seq snd_ctl_led snd_soc_skl_hda_dsp snd_soc=
_intel_sof_board_helpers snd_sof_probes snd_soc_intel_hda_dsp_common xe snd=
_hda_codec_intelhdmi snd_hda_codec_alc269 snd_hda_scodec_component drm_gpuv=
m snd_hda_codec_realtek_lib drm_gpusvm_helper snd_hda_codec_generic gpu_sch=
ed snd_soc_dmic drm_ttm_helper drm_exec drm_suballoc_helper ip6t_REJECT nf_=
reject_ipv6 ipt_REJECT nf_reject_ipv4 snd_hda_intel xt_tcpudp snd_sof_pci_i=
ntel_tgl xt_conntrack snd_sof_pci_intel_cnl nf_conntrack snd_sof_intel_hda_=
generic nf_defrag_ipv6 soundwire_intel nf_defrag_ipv4 snd_sof_intel_hda_sdw=
_bpt nft_compat nf_tables snd_sof_intel_hda_common intel_uncore_frequency j=
oydev intel_uncore_frequency_common binfmt_misc x_tables snd_soc_hdac_hda x=
86_pkg_temp_thermal snd_sof_intel_hda_mlink intel_powerclamp snd_sof_intel_=
hda
Feb 07 17:16:23 heisenberg kernel:  i915 snd_hda_codec_hdmi soundwire_caden=
ce snd_sof_pci coretemp snd_sof_xtensa_dsp snd_sof kvm_intel snd_sof_utils =
snd_soc_acpi_intel_match snd_soc_acpi_intel_sdca_quirks soundwire_generic_a=
llocation kvm snd_soc_acpi hid_multitouch crc8 soundwire_bus iwlmvm snd_soc=
_sdca snd_soc_avs btusb uvcvideo btmtk irqbypass snd_soc_hda_codec btrtl vi=
deobuf2_vmalloc ghash_clmulni_intel drm_buddy btbcm snd_hda_ext_core uvc hi=
d_generic snd_hda_codec btintel iTCO_wdt rapl videobuf2_memops ttm sdhci_pc=
i snd_usb_audio intel_pmc_bxt processor_thermal_device_pci mac80211 intel_r=
apl_msr videobuf2_v4l2 snd_hda_core sdhci_uhs2 drm_display_helper bluetooth=
 intel_cstate iTCO_vendor_support snd_usbmidi_lib videodev processor_therma=
l_device sdhci snd_intel_dspcfg processor_thermal_wt_hint platform_temperat=
ure_control snd_rawmidi cec videobuf2_common snd_intel_sdw_acpi cqhci proce=
ssor_thermal_soc_slider snd_seq_device snd_hwdep mei_hdcp watchdog mei_pxp =
ee1004 wmi_bmof usbhid mc ecdh_generic libarc4 intel_uncore crc16 intel_pmc=
_core
Feb 07 17:16:23 heisenberg kernel:  mmc_core snd_soc_core rc_core platform_=
profile pmt_telemetry snd_compress ucsi_acpi processor_thermal_rfim drm_cli=
ent_lib snd_pcm_dmaengine processor_thermal_rapl typec_ucsi iwlwifi pmt_dis=
covery drm_kms_helper snd_pcm i2c_hid_acpi intel_rapl_common typec pmt_clas=
s i2c_hid i2c_algo_bit int3400_thermal hid roles fujitsu_laptop intel_pmc_s=
sram_telemetry acpi_thermal_rel acpi_pad acpi_tad cfg80211 battery button v=
ideo processor_thermal_wt_req i2c_i801 snd_timer processor_thermal_power_fl=
oor i2c_smbus mei_me snd intel_lpss_pci processor_thermal_mbox soundcore in=
tel_lpss mei rfkill wmi idma64 intel_vsec ac int340x_thermal_zone igen6_eda=
c parport_pc lp ppdev drm parport efi_pstore configfs nfnetlink autofs4 crc=
32c_cryptoapi sd_mod dm_crypt dm_mod raid10 raid456 async_raid6_recov async=
_memcpy async_pq async_xor async_tx raid1 raid0 md_mod usb_storage scsi_mod=
 scsi_common btrfs blake2b_generic xor raid6_pq xhci_pci xhci_hcd nvme thun=
derbolt nvme_core usbcore e1000e evdev nvme_keyring nvme_auth serio_raw int=
el_hid
Feb 07 17:16:23 heisenberg kernel:  fan pcspkr aesni_intel usb_common hkdf =
sparse_keymap efivarfs
Feb 07 17:16:23 heisenberg kernel: CPU: 8 UID: 0 PID: 157336 Comm: btrfs-tr=
ansacti Tainted: G        W           6.18.8+deb14-amd64 #1 PREEMPT(lazy)  =
Debian 6.18.8-1=20
Feb 07 17:16:23 heisenberg kernel: Tainted: [W]=3DWARN
Feb 07 17:16:23 heisenberg kernel: Hardware name: FUJITSU CLIENT COMPUTING =
LIMITED LIFEBOOK U7512/FJNB2F4, BIOS Version 2.35 07/01/2025
Feb 07 17:16:23 heisenberg kernel: RIP: 0010:btrfs_put_transaction+0x141/0x=
180 [btrfs]
Feb 07 17:16:23 heisenberg kernel: Code: 48 89 ef 5d 41 5c 41 5d e9 8c c3 4=
9 eb 5b be 03 00 00 00 5d 41 5c 41 5d e9 fc 8b 7f eb 0f 0b e9 e2 fe ff ff 0=
f 0b 0f 0b eb d5 <0f> 0b e9 1a ff ff ff 0f 0b e9 21 ff ff ff e8 3c 24 20 eb=
 48 8b 95
Feb 07 17:16:23 heisenberg kernel: RSP: 0018:ffffd1b2cc677de0 EFLAGS: 00010=
282
Feb 07 17:16:23 heisenberg kernel: RAX: ffff8ddbdc7bd628 RBX: ffff8ddbdc7bd=
600 RCX: ffff8dd2101b8488
Feb 07 17:16:23 heisenberg kernel: RDX: ffff8ddbdc7bd628 RSI: ffff8ddbdc7bd=
628 RDI: ffff8ddbdc7bd610
Feb 07 17:16:23 heisenberg kernel: RBP: ffff8ddbdc7bd600 R08: 0000000000000=
000 R09: ffffd1b2cc677db0
Feb 07 17:16:23 heisenberg kernel: R10: ffffd1b2cc677db0 R11: 0000000000000=
000 R12: ffff8dd28d95de70
Feb 07 17:16:23 heisenberg kernel: R13: ffff8ddbdc7bd628 R14: ffff8dd2101b8=
460 R15: 0000000000000000
Feb 07 17:16:23 heisenberg kernel: FS:  0000000000000000(0000) GS:ffff8de10=
11cc000(0000) knlGS:0000000000000000
Feb 07 17:16:23 heisenberg kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000=
080050033
Feb 07 17:16:23 heisenberg kernel: CR2: 0000267fd2eb7004 CR3: 00000003de22c=
002 CR4: 0000000000f72ef0
Feb 07 17:16:23 heisenberg kernel: PKRU: 55555554
Feb 07 17:16:23 heisenberg kernel: Call Trace:
Feb 07 17:16:23 heisenberg kernel:  <TASK>
Feb 07 17:16:23 heisenberg kernel:  btrfs_commit_transaction+0x72a/0xdf0 [b=
trfs]
Feb 07 17:16:23 heisenberg kernel:  ? __pfx_autoremove_wake_function+0x10/0=
x10
Feb 07 17:16:23 heisenberg kernel:  transaction_kthread+0x157/0x1c0 [btrfs]
Feb 07 17:16:23 heisenberg kernel:  ? __pfx_transaction_kthread+0x10/0x10 [=
btrfs]
Feb 07 17:16:23 heisenberg kernel:  kthread+0xfc/0x240
Feb 07 17:16:23 heisenberg kernel:  ? __pfx_kthread+0x10/0x10
Feb 07 17:16:23 heisenberg kernel:  ret_from_fork+0x1cc/0x200
Feb 07 17:16:23 heisenberg kernel:  ? __pfx_kthread+0x10/0x10
Feb 07 17:16:23 heisenberg kernel:  ret_from_fork_asm+0x1a/0x30
Feb 07 17:16:23 heisenberg kernel:  </TASK>
Feb 07 17:16:23 heisenberg kernel: ---[ end trace 0000000000000000 ]---
Feb 07 17:16:54 heisenberg kernel: ------------[ cut here ]------------
Feb 07 17:16:54 heisenberg kernel: WARNING: CPU: 9 PID: 157336 at fs/btrfs/=
transaction.c:144 btrfs_put_transaction+0x141/0x180 [btrfs]
Feb 07 17:16:54 heisenberg kernel: Modules linked in: cpuid ext4 mbcache jb=
d2 sg uas nft_fib_ipv6 nft_ct nft_fib_ipv4 nft_fib wireguard libcurve25519 =
libchacha20poly1305 libchacha ip6_udp_tunnel udp_tunnel libpoly1305 cmac cc=
m snd_seq_dummy snd_hrtimer snd_seq snd_ctl_led snd_soc_skl_hda_dsp snd_soc=
_intel_sof_board_helpers snd_sof_probes snd_soc_intel_hda_dsp_common xe snd=
_hda_codec_intelhdmi snd_hda_codec_alc269 snd_hda_scodec_component drm_gpuv=
m snd_hda_codec_realtek_lib drm_gpusvm_helper snd_hda_codec_generic gpu_sch=
ed snd_soc_dmic drm_ttm_helper drm_exec drm_suballoc_helper ip6t_REJECT nf_=
reject_ipv6 ipt_REJECT nf_reject_ipv4 snd_hda_intel xt_tcpudp snd_sof_pci_i=
ntel_tgl xt_conntrack snd_sof_pci_intel_cnl nf_conntrack snd_sof_intel_hda_=
generic nf_defrag_ipv6 soundwire_intel nf_defrag_ipv4 snd_sof_intel_hda_sdw=
_bpt nft_compat nf_tables snd_sof_intel_hda_common intel_uncore_frequency j=
oydev intel_uncore_frequency_common binfmt_misc x_tables snd_soc_hdac_hda x=
86_pkg_temp_thermal snd_sof_intel_hda_mlink intel_powerclamp snd_sof_intel_=
hda
Feb 07 17:16:54 heisenberg kernel:  i915 snd_hda_codec_hdmi soundwire_caden=
ce snd_sof_pci coretemp snd_sof_xtensa_dsp snd_sof kvm_intel snd_sof_utils =
snd_soc_acpi_intel_match snd_soc_acpi_intel_sdca_quirks soundwire_generic_a=
llocation kvm snd_soc_acpi hid_multitouch crc8 soundwire_bus iwlmvm snd_soc=
_sdca snd_soc_avs btusb uvcvideo btmtk irqbypass snd_soc_hda_codec btrtl vi=
deobuf2_vmalloc ghash_clmulni_intel drm_buddy btbcm snd_hda_ext_core uvc hi=
d_generic snd_hda_codec btintel iTCO_wdt rapl videobuf2_memops ttm sdhci_pc=
i snd_usb_audio intel_pmc_bxt processor_thermal_device_pci mac80211 intel_r=
apl_msr videobuf2_v4l2 snd_hda_core sdhci_uhs2 drm_display_helper bluetooth=
 intel_cstate iTCO_vendor_support snd_usbmidi_lib videodev processor_therma=
l_device sdhci snd_intel_dspcfg processor_thermal_wt_hint platform_temperat=
ure_control snd_rawmidi cec videobuf2_common snd_intel_sdw_acpi cqhci proce=
ssor_thermal_soc_slider snd_seq_device snd_hwdep mei_hdcp watchdog mei_pxp =
ee1004 wmi_bmof usbhid mc ecdh_generic libarc4 intel_uncore crc16 intel_pmc=
_core
Feb 07 17:16:54 heisenberg kernel:  mmc_core snd_soc_core rc_core platform_=
profile pmt_telemetry snd_compress ucsi_acpi processor_thermal_rfim drm_cli=
ent_lib snd_pcm_dmaengine processor_thermal_rapl typec_ucsi iwlwifi pmt_dis=
covery drm_kms_helper snd_pcm i2c_hid_acpi intel_rapl_common typec pmt_clas=
s i2c_hid i2c_algo_bit int3400_thermal hid roles fujitsu_laptop intel_pmc_s=
sram_telemetry acpi_thermal_rel acpi_pad acpi_tad cfg80211 battery button v=
ideo processor_thermal_wt_req i2c_i801 snd_timer processor_thermal_power_fl=
oor i2c_smbus mei_me snd intel_lpss_pci processor_thermal_mbox soundcore in=
tel_lpss mei rfkill wmi idma64 intel_vsec ac int340x_thermal_zone igen6_eda=
c parport_pc lp ppdev drm parport efi_pstore configfs nfnetlink autofs4 crc=
32c_cryptoapi sd_mod dm_crypt dm_mod raid10 raid456 async_raid6_recov async=
_memcpy async_pq async_xor async_tx raid1 raid0 md_mod usb_storage scsi_mod=
 scsi_common btrfs blake2b_generic xor raid6_pq xhci_pci xhci_hcd nvme thun=
derbolt nvme_core usbcore e1000e evdev nvme_keyring nvme_auth serio_raw int=
el_hid
Feb 07 17:16:54 heisenberg kernel:  fan pcspkr aesni_intel usb_common hkdf =
sparse_keymap efivarfs
Feb 07 17:16:54 heisenberg kernel: CPU: 9 UID: 0 PID: 157336 Comm: btrfs-tr=
ansacti Tainted: G        W           6.18.8+deb14-amd64 #1 PREEMPT(lazy)  =
Debian 6.18.8-1=20
Feb 07 17:16:54 heisenberg kernel: Tainted: [W]=3DWARN
Feb 07 17:16:54 heisenberg kernel: Hardware name: FUJITSU CLIENT COMPUTING =
LIMITED LIFEBOOK U7512/FJNB2F4, BIOS Version 2.35 07/01/2025
Feb 07 17:16:54 heisenberg kernel: RIP: 0010:btrfs_put_transaction+0x141/0x=
180 [btrfs]
Feb 07 17:16:54 heisenberg kernel: Code: 48 89 ef 5d 41 5c 41 5d e9 8c c3 4=
9 eb 5b be 03 00 00 00 5d 41 5c 41 5d e9 fc 8b 7f eb 0f 0b e9 e2 fe ff ff 0=
f 0b 0f 0b eb d5 <0f> 0b e9 1a ff ff ff 0f 0b e9 21 ff ff ff e8 3c 24 20 eb=
 48 8b 95
Feb 07 17:16:54 heisenberg kernel: RSP: 0018:ffffd1b2cc677de0 EFLAGS: 00010=
286
Feb 07 17:16:54 heisenberg kernel: RAX: ffff8dd34ce01e28 RBX: ffff8dd34ce01=
e00 RCX: ffff8dd2101b8488
Feb 07 17:16:54 heisenberg kernel: RDX: ffff8dd34ce01e28 RSI: ffff8dd34ce01=
e28 RDI: ffff8dd34ce01e10
Feb 07 17:16:54 heisenberg kernel: RBP: ffff8dd34ce01e00 R08: 0000000000000=
000 R09: ffffd1b2cc677db0
Feb 07 17:16:54 heisenberg kernel: R10: ffffd1b2cc677db0 R11: 0000000000000=
000 R12: ffff8dd28d95de70
Feb 07 17:16:54 heisenberg kernel: R13: ffff8dd34ce01e28 R14: ffff8dd2101b8=
460 R15: 0000000000000000
Feb 07 17:16:54 heisenberg kernel: FS:  0000000000000000(0000) GS:ffff8de10=
120c000(0000) knlGS:0000000000000000
Feb 07 17:16:54 heisenberg kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000=
080050033
Feb 07 17:16:54 heisenberg kernel: CR2: 000034eb31910004 CR3: 00000003de22c=
005 CR4: 0000000000f72ef0
Feb 07 17:16:54 heisenberg kernel: PKRU: 55555554
Feb 07 17:16:54 heisenberg kernel: Call Trace:
Feb 07 17:16:54 heisenberg kernel:  <TASK>
Feb 07 17:16:54 heisenberg kernel:  btrfs_commit_transaction+0x72a/0xdf0 [b=
trfs]
Feb 07 17:16:54 heisenberg kernel:  ? __pfx_autoremove_wake_function+0x10/0=
x10
Feb 07 17:16:54 heisenberg kernel:  transaction_kthread+0x157/0x1c0 [btrfs]
Feb 07 17:16:54 heisenberg kernel:  ? __pfx_transaction_kthread+0x10/0x10 [=
btrfs]
Feb 07 17:16:54 heisenberg kernel:  kthread+0xfc/0x240
Feb 07 17:16:54 heisenberg kernel:  ? __pfx_kthread+0x10/0x10
Feb 07 17:16:54 heisenberg kernel:  ret_from_fork+0x1cc/0x200
Feb 07 17:16:54 heisenberg kernel:  ? __pfx_kthread+0x10/0x10
Feb 07 17:16:54 heisenberg kernel:  ret_from_fork_asm+0x1a/0x30
Feb 07 17:16:54 heisenberg kernel:  </TASK>
Feb 07 17:16:54 heisenberg kernel: ---[ end trace 0000000000000000 ]---
Feb 07 17:17:25 heisenberg kernel: ------------[ cut here ]------------
Feb 07 17:17:25 heisenberg kernel: WARNING: CPU: 9 PID: 157336 at fs/btrfs/=
transaction.c:144 btrfs_put_transaction+0x141/0x180 [btrfs]
Feb 07 17:17:25 heisenberg kernel: Modules linked in: cpuid ext4 mbcache jb=
d2 sg uas nft_fib_ipv6 nft_ct nft_fib_ipv4 nft_fib wireguard libcurve25519 =
libchacha20poly1305 libchacha ip6_udp_tunnel udp_tunnel libpoly1305 cmac cc=
m snd_seq_dummy snd_hrtimer snd_seq snd_ctl_led snd_soc_skl_hda_dsp snd_soc=
_intel_sof_board_helpers snd_sof_probes snd_soc_intel_hda_dsp_common xe snd=
_hda_codec_intelhdmi snd_hda_codec_alc269 snd_hda_scodec_component drm_gpuv=
m snd_hda_codec_realtek_lib drm_gpusvm_helper snd_hda_codec_generic gpu_sch=
ed snd_soc_dmic drm_ttm_helper drm_exec drm_suballoc_helper ip6t_REJECT nf_=
reject_ipv6 ipt_REJECT nf_reject_ipv4 snd_hda_intel xt_tcpudp snd_sof_pci_i=
ntel_tgl xt_conntrack snd_sof_pci_intel_cnl nf_conntrack snd_sof_intel_hda_=
generic nf_defrag_ipv6 soundwire_intel nf_defrag_ipv4 snd_sof_intel_hda_sdw=
_bpt nft_compat nf_tables snd_sof_intel_hda_common intel_uncore_frequency j=
oydev intel_uncore_frequency_common binfmt_misc x_tables snd_soc_hdac_hda x=
86_pkg_temp_thermal snd_sof_intel_hda_mlink intel_powerclamp snd_sof_intel_=
hda
Feb 07 17:17:25 heisenberg kernel:  i915 snd_hda_codec_hdmi soundwire_caden=
ce snd_sof_pci coretemp snd_sof_xtensa_dsp snd_sof kvm_intel snd_sof_utils =
snd_soc_acpi_intel_match snd_soc_acpi_intel_sdca_quirks soundwire_generic_a=
llocation kvm snd_soc_acpi hid_multitouch crc8 soundwire_bus iwlmvm snd_soc=
_sdca snd_soc_avs btusb uvcvideo btmtk irqbypass snd_soc_hda_codec btrtl vi=
deobuf2_vmalloc ghash_clmulni_intel drm_buddy btbcm snd_hda_ext_core uvc hi=
d_generic snd_hda_codec btintel iTCO_wdt rapl videobuf2_memops ttm sdhci_pc=
i snd_usb_audio intel_pmc_bxt processor_thermal_device_pci mac80211 intel_r=
apl_msr videobuf2_v4l2 snd_hda_core sdhci_uhs2 drm_display_helper bluetooth=
 intel_cstate iTCO_vendor_support snd_usbmidi_lib videodev processor_therma=
l_device sdhci snd_intel_dspcfg processor_thermal_wt_hint platform_temperat=
ure_control snd_rawmidi cec videobuf2_common snd_intel_sdw_acpi cqhci proce=
ssor_thermal_soc_slider snd_seq_device snd_hwdep mei_hdcp watchdog mei_pxp =
ee1004 wmi_bmof usbhid mc ecdh_generic libarc4 intel_uncore crc16 intel_pmc=
_core
Feb 07 17:17:25 heisenberg kernel:  mmc_core snd_soc_core rc_core platform_=
profile pmt_telemetry snd_compress ucsi_acpi processor_thermal_rfim drm_cli=
ent_lib snd_pcm_dmaengine processor_thermal_rapl typec_ucsi iwlwifi pmt_dis=
covery drm_kms_helper snd_pcm i2c_hid_acpi intel_rapl_common typec pmt_clas=
s i2c_hid i2c_algo_bit int3400_thermal hid roles fujitsu_laptop intel_pmc_s=
sram_telemetry acpi_thermal_rel acpi_pad acpi_tad cfg80211 battery button v=
ideo processor_thermal_wt_req i2c_i801 snd_timer processor_thermal_power_fl=
oor i2c_smbus mei_me snd intel_lpss_pci processor_thermal_mbox soundcore in=
tel_lpss mei rfkill wmi idma64 intel_vsec ac int340x_thermal_zone igen6_eda=
c parport_pc lp ppdev drm parport efi_pstore configfs nfnetlink autofs4 crc=
32c_cryptoapi sd_mod dm_crypt dm_mod raid10 raid456 async_raid6_recov async=
_memcpy async_pq async_xor async_tx raid1 raid0 md_mod usb_storage scsi_mod=
 scsi_common btrfs blake2b_generic xor raid6_pq xhci_pci xhci_hcd nvme thun=
derbolt nvme_core usbcore e1000e evdev nvme_keyring nvme_auth serio_raw int=
el_hid
Feb 07 17:17:25 heisenberg kernel:  fan pcspkr aesni_intel usb_common hkdf =
sparse_keymap efivarfs
Feb 07 17:17:25 heisenberg kernel: CPU: 9 UID: 0 PID: 157336 Comm: btrfs-tr=
ansacti Tainted: G        W           6.18.8+deb14-amd64 #1 PREEMPT(lazy)  =
Debian 6.18.8-1=20
Feb 07 17:17:25 heisenberg kernel: Tainted: [W]=3DWARN
Feb 07 17:17:25 heisenberg kernel: Hardware name: FUJITSU CLIENT COMPUTING =
LIMITED LIFEBOOK U7512/FJNB2F4, BIOS Version 2.35 07/01/2025
Feb 07 17:17:25 heisenberg kernel: RIP: 0010:btrfs_put_transaction+0x141/0x=
180 [btrfs]
Feb 07 17:17:25 heisenberg kernel: Code: 48 89 ef 5d 41 5c 41 5d e9 8c c3 4=
9 eb 5b be 03 00 00 00 5d 41 5c 41 5d e9 fc 8b 7f eb 0f 0b e9 e2 fe ff ff 0=
f 0b 0f 0b eb d5 <0f> 0b e9 1a ff ff ff 0f 0b e9 21 ff ff ff e8 3c 24 20 eb=
 48 8b 95
Feb 07 17:17:25 heisenberg kernel: RSP: 0018:ffffd1b2cc677de0 EFLAGS: 00010=
282
Feb 07 17:17:25 heisenberg kernel: RAX: ffff8ddfee99d228 RBX: ffff8ddfee99d=
200 RCX: ffff8dd2101b8488
Feb 07 17:17:25 heisenberg kernel: RDX: ffff8ddfee99d228 RSI: ffff8ddfee99d=
228 RDI: ffff8ddfee99d210
Feb 07 17:17:25 heisenberg kernel: RBP: ffff8ddfee99d200 R08: 0000000000000=
000 R09: ffffd1b2cc677db0
Feb 07 17:17:25 heisenberg kernel: R10: ffffd1b2cc677db0 R11: 0000000000000=
000 R12: ffff8ddfffda43f0
Feb 07 17:17:25 heisenberg kernel: R13: ffff8ddfee99d228 R14: ffff8dd2101b8=
460 R15: 0000000000000000
Feb 07 17:17:25 heisenberg kernel: FS:  0000000000000000(0000) GS:ffff8de10=
120c000(0000) knlGS:0000000000000000
Feb 07 17:17:25 heisenberg kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000=
080050033
Feb 07 17:17:25 heisenberg kernel: CR2: 00007fa22d0f8000 CR3: 00000003de22c=
003 CR4: 0000000000f72ef0
Feb 07 17:17:25 heisenberg kernel: PKRU: 55555554
Feb 07 17:17:25 heisenberg kernel: Call Trace:
Feb 07 17:17:25 heisenberg kernel:  <TASK>
Feb 07 17:17:25 heisenberg kernel:  btrfs_commit_transaction+0x72a/0xdf0 [b=
trfs]
Feb 07 17:17:25 heisenberg kernel:  ? __pfx_autoremove_wake_function+0x10/0=
x10
Feb 07 17:17:25 heisenberg kernel:  transaction_kthread+0x157/0x1c0 [btrfs]
Feb 07 17:17:25 heisenberg kernel:  ? __pfx_transaction_kthread+0x10/0x10 [=
btrfs]
Feb 07 17:17:25 heisenberg kernel:  kthread+0xfc/0x240
Feb 07 17:17:25 heisenberg kernel:  ? __pfx_kthread+0x10/0x10
Feb 07 17:17:25 heisenberg kernel:  ret_from_fork+0x1cc/0x200
Feb 07 17:17:25 heisenberg kernel:  ? __pfx_kthread+0x10/0x10
Feb 07 17:17:25 heisenberg kernel:  ret_from_fork_asm+0x1a/0x30
Feb 07 17:17:25 heisenberg kernel:  </TASK>
Feb 07 17:17:25 heisenberg kernel: ---[ end trace 0000000000000000 ]---
Feb 07 17:17:58 heisenberg kernel: ------------[ cut here ]------------
Feb 07 17:17:58 heisenberg kernel: WARNING: CPU: 9 PID: 157336 at fs/btrfs/=
transaction.c:144 btrfs_put_transaction+0x141/0x180 [btrfs]
Feb 07 17:17:58 heisenberg kernel: Modules linked in: cpuid ext4 mbcache jb=
d2 sg uas nft_fib_ipv6 nft_ct nft_fib_ipv4 nft_fib wireguard libcurve25519 =
libchacha20poly1305 libchacha ip6_udp_tunnel udp_tunnel libpoly1305 cmac cc=
m snd_seq_dummy snd_hrtimer snd_seq snd_ctl_led snd_soc_skl_hda_dsp snd_soc=
_intel_sof_board_helpers snd_sof_probes snd_soc_intel_hda_dsp_common xe snd=
_hda_codec_intelhdmi snd_hda_codec_alc269 snd_hda_scodec_component drm_gpuv=
m snd_hda_codec_realtek_lib drm_gpusvm_helper snd_hda_codec_generic gpu_sch=
ed snd_soc_dmic drm_ttm_helper drm_exec drm_suballoc_helper ip6t_REJECT nf_=
reject_ipv6 ipt_REJECT nf_reject_ipv4 snd_hda_intel xt_tcpudp snd_sof_pci_i=
ntel_tgl xt_conntrack snd_sof_pci_intel_cnl nf_conntrack snd_sof_intel_hda_=
generic nf_defrag_ipv6 soundwire_intel nf_defrag_ipv4 snd_sof_intel_hda_sdw=
_bpt nft_compat nf_tables snd_sof_intel_hda_common intel_uncore_frequency j=
oydev intel_uncore_frequency_common binfmt_misc x_tables snd_soc_hdac_hda x=
86_pkg_temp_thermal snd_sof_intel_hda_mlink intel_powerclamp snd_sof_intel_=
hda
Feb 07 17:17:58 heisenberg kernel:  i915 snd_hda_codec_hdmi soundwire_caden=
ce snd_sof_pci coretemp snd_sof_xtensa_dsp snd_sof kvm_intel snd_sof_utils =
snd_soc_acpi_intel_match snd_soc_acpi_intel_sdca_quirks soundwire_generic_a=
llocation kvm snd_soc_acpi hid_multitouch crc8 soundwire_bus iwlmvm snd_soc=
_sdca snd_soc_avs btusb uvcvideo btmtk irqbypass snd_soc_hda_codec btrtl vi=
deobuf2_vmalloc ghash_clmulni_intel drm_buddy btbcm snd_hda_ext_core uvc hi=
d_generic snd_hda_codec btintel iTCO_wdt rapl videobuf2_memops ttm sdhci_pc=
i snd_usb_audio intel_pmc_bxt processor_thermal_device_pci mac80211 intel_r=
apl_msr videobuf2_v4l2 snd_hda_core sdhci_uhs2 drm_display_helper bluetooth=
 intel_cstate iTCO_vendor_support snd_usbmidi_lib videodev processor_therma=
l_device sdhci snd_intel_dspcfg processor_thermal_wt_hint platform_temperat=
ure_control snd_rawmidi cec videobuf2_common snd_intel_sdw_acpi cqhci proce=
ssor_thermal_soc_slider snd_seq_device snd_hwdep mei_hdcp watchdog mei_pxp =
ee1004 wmi_bmof usbhid mc ecdh_generic libarc4 intel_uncore crc16 intel_pmc=
_core
Feb 07 17:17:58 heisenberg kernel:  mmc_core snd_soc_core rc_core platform_=
profile pmt_telemetry snd_compress ucsi_acpi processor_thermal_rfim drm_cli=
ent_lib snd_pcm_dmaengine processor_thermal_rapl typec_ucsi iwlwifi pmt_dis=
covery drm_kms_helper snd_pcm i2c_hid_acpi intel_rapl_common typec pmt_clas=
s i2c_hid i2c_algo_bit int3400_thermal hid roles fujitsu_laptop intel_pmc_s=
sram_telemetry acpi_thermal_rel acpi_pad acpi_tad cfg80211 battery button v=
ideo processor_thermal_wt_req i2c_i801 snd_timer processor_thermal_power_fl=
oor i2c_smbus mei_me snd intel_lpss_pci processor_thermal_mbox soundcore in=
tel_lpss mei rfkill wmi idma64 intel_vsec ac int340x_thermal_zone igen6_eda=
c parport_pc lp ppdev drm parport efi_pstore configfs nfnetlink autofs4 crc=
32c_cryptoapi sd_mod dm_crypt dm_mod raid10 raid456 async_raid6_recov async=
_memcpy async_pq async_xor async_tx raid1 raid0 md_mod usb_storage scsi_mod=
 scsi_common btrfs blake2b_generic xor raid6_pq xhci_pci xhci_hcd nvme thun=
derbolt nvme_core usbcore e1000e evdev nvme_keyring nvme_auth serio_raw int=
el_hid
Feb 07 17:17:58 heisenberg kernel:  fan pcspkr aesni_intel usb_common hkdf =
sparse_keymap efivarfs
Feb 07 17:17:58 heisenberg kernel: CPU: 9 UID: 0 PID: 157336 Comm: btrfs-tr=
ansacti Tainted: G        W           6.18.8+deb14-amd64 #1 PREEMPT(lazy)  =
Debian 6.18.8-1=20
Feb 07 17:17:58 heisenberg kernel: Tainted: [W]=3DWARN
Feb 07 17:17:58 heisenberg kernel: Hardware name: FUJITSU CLIENT COMPUTING =
LIMITED LIFEBOOK U7512/FJNB2F4, BIOS Version 2.35 07/01/2025
Feb 07 17:17:58 heisenberg kernel: RIP: 0010:btrfs_put_transaction+0x141/0x=
180 [btrfs]
Feb 07 17:17:58 heisenberg kernel: Code: 48 89 ef 5d 41 5c 41 5d e9 8c c3 4=
9 eb 5b be 03 00 00 00 5d 41 5c 41 5d e9 fc 8b 7f eb 0f 0b e9 e2 fe ff ff 0=
f 0b 0f 0b eb d5 <0f> 0b e9 1a ff ff ff 0f 0b e9 21 ff ff ff e8 3c 24 20 eb=
 48 8b 95
Feb 07 17:17:58 heisenberg kernel: RSP: 0018:ffffd1b2cc677de0 EFLAGS: 00010=
286
Feb 07 17:17:58 heisenberg kernel: RAX: ffff8dd148734628 RBX: ffff8dd148734=
600 RCX: ffff8dd2101b8488
Feb 07 17:17:58 heisenberg kernel: RDX: ffff8dd148734628 RSI: ffff8dd148734=
628 RDI: ffff8dd148734610
Feb 07 17:17:58 heisenberg kernel: RBP: ffff8dd148734600 R08: 0000000000000=
000 R09: ffffd1b2cc677db0
Feb 07 17:17:58 heisenberg kernel: R10: ffffd1b2cc677db0 R11: 0000000000000=
000 R12: ffff8ddfffda43f0
Feb 07 17:17:58 heisenberg kernel: R13: ffff8dd148734628 R14: ffff8dd2101b8=
460 R15: 0000000000000000
Feb 07 17:17:58 heisenberg kernel: FS:  0000000000000000(0000) GS:ffff8de10=
120c000(0000) knlGS:0000000000000000
Feb 07 17:17:58 heisenberg kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000=
080050033
Feb 07 17:17:58 heisenberg kernel: CR2: 00007fb628b9ff98 CR3: 00000003de22c=
006 CR4: 0000000000f72ef0
Feb 07 17:17:58 heisenberg kernel: PKRU: 55555554
Feb 07 17:17:58 heisenberg kernel: Call Trace:
Feb 07 17:17:58 heisenberg kernel:  <TASK>
Feb 07 17:17:58 heisenberg kernel:  btrfs_commit_transaction+0x72a/0xdf0 [b=
trfs]
Feb 07 17:17:58 heisenberg kernel:  ? __pfx_autoremove_wake_function+0x10/0=
x10
Feb 07 17:17:58 heisenberg kernel:  transaction_kthread+0x157/0x1c0 [btrfs]
Feb 07 17:17:58 heisenberg kernel:  ? __pfx_transaction_kthread+0x10/0x10 [=
btrfs]
Feb 07 17:17:58 heisenberg kernel:  kthread+0xfc/0x240
Feb 07 17:17:58 heisenberg kernel:  ? __pfx_kthread+0x10/0x10
Feb 07 17:17:58 heisenberg kernel:  ret_from_fork+0x1cc/0x200
Feb 07 17:17:58 heisenberg kernel:  ? __pfx_kthread+0x10/0x10
Feb 07 17:17:58 heisenberg kernel:  ret_from_fork_asm+0x1a/0x30
Feb 07 17:17:58 heisenberg kernel:  </TASK>
Feb 07 17:17:58 heisenberg kernel: ---[ end trace 0000000000000000 ]---
Feb 07 17:18:30 heisenberg kernel: ------------[ cut here ]------------
Feb 07 17:18:30 heisenberg kernel: WARNING: CPU: 9 PID: 157336 at fs/btrfs/=
transaction.c:144 btrfs_put_transaction+0x141/0x180 [btrfs]
Feb 07 17:18:30 heisenberg kernel: Modules linked in: cpuid ext4 mbcache jb=
d2 sg uas nft_fib_ipv6 nft_ct nft_fib_ipv4 nft_fib wireguard libcurve25519 =
libchacha20poly1305 libchacha ip6_udp_tunnel udp_tunnel libpoly1305 cmac cc=
m snd_seq_dummy snd_hrtimer snd_seq snd_ctl_led snd_soc_skl_hda_dsp snd_soc=
_intel_sof_board_helpers snd_sof_probes snd_soc_intel_hda_dsp_common xe snd=
_hda_codec_intelhdmi snd_hda_codec_alc269 snd_hda_scodec_component drm_gpuv=
m snd_hda_codec_realtek_lib drm_gpusvm_helper snd_hda_codec_generic gpu_sch=
ed snd_soc_dmic drm_ttm_helper drm_exec drm_suballoc_helper ip6t_REJECT nf_=
reject_ipv6 ipt_REJECT nf_reject_ipv4 snd_hda_intel xt_tcpudp snd_sof_pci_i=
ntel_tgl xt_conntrack snd_sof_pci_intel_cnl nf_conntrack snd_sof_intel_hda_=
generic nf_defrag_ipv6 soundwire_intel nf_defrag_ipv4 snd_sof_intel_hda_sdw=
_bpt nft_compat nf_tables snd_sof_intel_hda_common intel_uncore_frequency j=
oydev intel_uncore_frequency_common binfmt_misc x_tables snd_soc_hdac_hda x=
86_pkg_temp_thermal snd_sof_intel_hda_mlink intel_powerclamp snd_sof_intel_=
hda
Feb 07 17:18:30 heisenberg kernel:  i915 snd_hda_codec_hdmi soundwire_caden=
ce snd_sof_pci coretemp snd_sof_xtensa_dsp snd_sof kvm_intel snd_sof_utils =
snd_soc_acpi_intel_match snd_soc_acpi_intel_sdca_quirks soundwire_generic_a=
llocation kvm snd_soc_acpi hid_multitouch crc8 soundwire_bus iwlmvm snd_soc=
_sdca snd_soc_avs btusb uvcvideo btmtk irqbypass snd_soc_hda_codec btrtl vi=
deobuf2_vmalloc ghash_clmulni_intel drm_buddy btbcm snd_hda_ext_core uvc hi=
d_generic snd_hda_codec btintel iTCO_wdt rapl videobuf2_memops ttm sdhci_pc=
i snd_usb_audio intel_pmc_bxt processor_thermal_device_pci mac80211 intel_r=
apl_msr videobuf2_v4l2 snd_hda_core sdhci_uhs2 drm_display_helper bluetooth=
 intel_cstate iTCO_vendor_support snd_usbmidi_lib videodev processor_therma=
l_device sdhci snd_intel_dspcfg processor_thermal_wt_hint platform_temperat=
ure_control snd_rawmidi cec videobuf2_common snd_intel_sdw_acpi cqhci proce=
ssor_thermal_soc_slider snd_seq_device snd_hwdep mei_hdcp watchdog mei_pxp =
ee1004 wmi_bmof usbhid mc ecdh_generic libarc4 intel_uncore crc16 intel_pmc=
_core
Feb 07 17:18:30 heisenberg kernel:  mmc_core snd_soc_core rc_core platform_=
profile pmt_telemetry snd_compress ucsi_acpi processor_thermal_rfim drm_cli=
ent_lib snd_pcm_dmaengine processor_thermal_rapl typec_ucsi iwlwifi pmt_dis=
covery drm_kms_helper snd_pcm i2c_hid_acpi intel_rapl_common typec pmt_clas=
s i2c_hid i2c_algo_bit int3400_thermal hid roles fujitsu_laptop intel_pmc_s=
sram_telemetry acpi_thermal_rel acpi_pad acpi_tad cfg80211 battery button v=
ideo processor_thermal_wt_req i2c_i801 snd_timer processor_thermal_power_fl=
oor i2c_smbus mei_me snd intel_lpss_pci processor_thermal_mbox soundcore in=
tel_lpss mei rfkill wmi idma64 intel_vsec ac int340x_thermal_zone igen6_eda=
c parport_pc lp ppdev drm parport efi_pstore configfs nfnetlink autofs4 crc=
32c_cryptoapi sd_mod dm_crypt dm_mod raid10 raid456 async_raid6_recov async=
_memcpy async_pq async_xor async_tx raid1 raid0 md_mod usb_storage scsi_mod=
 scsi_common btrfs blake2b_generic xor raid6_pq xhci_pci xhci_hcd nvme thun=
derbolt nvme_core usbcore e1000e evdev nvme_keyring nvme_auth serio_raw int=
el_hid
Feb 07 17:18:30 heisenberg kernel:  fan pcspkr aesni_intel usb_common hkdf =
sparse_keymap efivarfs
Feb 07 17:18:30 heisenberg kernel: CPU: 9 UID: 0 PID: 157336 Comm: btrfs-tr=
ansacti Tainted: G        W           6.18.8+deb14-amd64 #1 PREEMPT(lazy)  =
Debian 6.18.8-1=20
Feb 07 17:18:30 heisenberg kernel: Tainted: [W]=3DWARN
Feb 07 17:18:30 heisenberg kernel: Hardware name: FUJITSU CLIENT COMPUTING =
LIMITED LIFEBOOK U7512/FJNB2F4, BIOS Version 2.35 07/01/2025
Feb 07 17:18:30 heisenberg kernel: RIP: 0010:btrfs_put_transaction+0x141/0x=
180 [btrfs]
Feb 07 17:18:30 heisenberg kernel: Code: 48 89 ef 5d 41 5c 41 5d e9 8c c3 4=
9 eb 5b be 03 00 00 00 5d 41 5c 41 5d e9 fc 8b 7f eb 0f 0b e9 e2 fe ff ff 0=
f 0b 0f 0b eb d5 <0f> 0b e9 1a ff ff ff 0f 0b e9 21 ff ff ff e8 3c 24 20 eb=
 48 8b 95
Feb 07 17:18:30 heisenberg kernel: RSP: 0018:ffffd1b2cc677de0 EFLAGS: 00010=
282
Feb 07 17:18:30 heisenberg kernel: RAX: ffff8dd145840a28 RBX: ffff8dd145840=
a00 RCX: ffff8dd2101b8488
Feb 07 17:18:30 heisenberg kernel: RDX: ffff8dd145840a28 RSI: ffff8dd145840=
a28 RDI: ffff8dd145840a10
Feb 07 17:18:30 heisenberg kernel: RBP: ffff8dd145840a00 R08: 0000000000000=
000 R09: ffffd1b2cc677db0
Feb 07 17:18:30 heisenberg kernel: R10: ffffd1b2cc677db0 R11: 0000000000000=
000 R12: ffff8ddfffda4000
Feb 07 17:18:30 heisenberg kernel: R13: ffff8dd145840a28 R14: ffff8dd2101b8=
460 R15: 0000000000000000
Feb 07 17:18:30 heisenberg kernel: FS:  0000000000000000(0000) GS:ffff8de10=
120c000(0000) knlGS:0000000000000000
Feb 07 17:18:30 heisenberg kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000=
080050033
Feb 07 17:18:30 heisenberg kernel: CR2: 00002d71c154a004 CR3: 00000003de22c=
002 CR4: 0000000000f72ef0
Feb 07 17:18:30 heisenberg kernel: PKRU: 55555554
Feb 07 17:18:30 heisenberg kernel: Call Trace:
Feb 07 17:18:30 heisenberg kernel:  <TASK>
Feb 07 17:18:30 heisenberg kernel:  btrfs_commit_transaction+0x72a/0xdf0 [b=
trfs]
Feb 07 17:18:30 heisenberg kernel:  ? __pfx_autoremove_wake_function+0x10/0=
x10
Feb 07 17:18:30 heisenberg kernel:  transaction_kthread+0x157/0x1c0 [btrfs]
Feb 07 17:18:30 heisenberg kernel:  ? __pfx_transaction_kthread+0x10/0x10 [=
btrfs]
Feb 07 17:18:30 heisenberg kernel:  kthread+0xfc/0x240
Feb 07 17:18:30 heisenberg kernel:  ? __pfx_kthread+0x10/0x10
Feb 07 17:18:30 heisenberg kernel:  ret_from_fork+0x1cc/0x200
Feb 07 17:18:30 heisenberg kernel:  ? __pfx_kthread+0x10/0x10
Feb 07 17:18:30 heisenberg kernel:  ret_from_fork_asm+0x1a/0x30
Feb 07 17:18:30 heisenberg kernel:  </TASK>
Feb 07 17:18:30 heisenberg kernel: ---[ end trace 0000000000000000 ]---
Feb 07 17:19:02 heisenberg kernel: ------------[ cut here ]------------
Feb 07 17:19:02 heisenberg kernel: WARNING: CPU: 4 PID: 157336 at fs/btrfs/=
transaction.c:144 btrfs_put_transaction+0x141/0x180 [btrfs]
Feb 07 17:19:02 heisenberg kernel: Modules linked in: cpuid ext4 mbcache jb=
d2 sg uas nft_fib_ipv6 nft_ct nft_fib_ipv4 nft_fib wireguard libcurve25519 =
libchacha20poly1305 libchacha ip6_udp_tunnel udp_tunnel libpoly1305 cmac cc=
m snd_seq_dummy snd_hrtimer snd_seq snd_ctl_led snd_soc_skl_hda_dsp snd_soc=
_intel_sof_board_helpers snd_sof_probes snd_soc_intel_hda_dsp_common xe snd=
_hda_codec_intelhdmi snd_hda_codec_alc269 snd_hda_scodec_component drm_gpuv=
m snd_hda_codec_realtek_lib drm_gpusvm_helper snd_hda_codec_generic gpu_sch=
ed snd_soc_dmic drm_ttm_helper drm_exec drm_suballoc_helper ip6t_REJECT nf_=
reject_ipv6 ipt_REJECT nf_reject_ipv4 snd_hda_intel xt_tcpudp snd_sof_pci_i=
ntel_tgl xt_conntrack snd_sof_pci_intel_cnl nf_conntrack snd_sof_intel_hda_=
generic nf_defrag_ipv6 soundwire_intel nf_defrag_ipv4 snd_sof_intel_hda_sdw=
_bpt nft_compat nf_tables snd_sof_intel_hda_common intel_uncore_frequency j=
oydev intel_uncore_frequency_common binfmt_misc x_tables snd_soc_hdac_hda x=
86_pkg_temp_thermal snd_sof_intel_hda_mlink intel_powerclamp snd_sof_intel_=
hda
Feb 07 17:19:02 heisenberg kernel:  i915 snd_hda_codec_hdmi soundwire_caden=
ce snd_sof_pci coretemp snd_sof_xtensa_dsp snd_sof kvm_intel snd_sof_utils =
snd_soc_acpi_intel_match snd_soc_acpi_intel_sdca_quirks soundwire_generic_a=
llocation kvm snd_soc_acpi hid_multitouch crc8 soundwire_bus iwlmvm snd_soc=
_sdca snd_soc_avs btusb uvcvideo btmtk irqbypass snd_soc_hda_codec btrtl vi=
deobuf2_vmalloc ghash_clmulni_intel drm_buddy btbcm snd_hda_ext_core uvc hi=
d_generic snd_hda_codec btintel iTCO_wdt rapl videobuf2_memops ttm sdhci_pc=
i snd_usb_audio intel_pmc_bxt processor_thermal_device_pci mac80211 intel_r=
apl_msr videobuf2_v4l2 snd_hda_core sdhci_uhs2 drm_display_helper bluetooth=
 intel_cstate iTCO_vendor_support snd_usbmidi_lib videodev processor_therma=
l_device sdhci snd_intel_dspcfg processor_thermal_wt_hint platform_temperat=
ure_control snd_rawmidi cec videobuf2_common snd_intel_sdw_acpi cqhci proce=
ssor_thermal_soc_slider snd_seq_device snd_hwdep mei_hdcp watchdog mei_pxp =
ee1004 wmi_bmof usbhid mc ecdh_generic libarc4 intel_uncore crc16 intel_pmc=
_core
Feb 07 17:19:02 heisenberg kernel:  mmc_core snd_soc_core rc_core platform_=
profile pmt_telemetry snd_compress ucsi_acpi processor_thermal_rfim drm_cli=
ent_lib snd_pcm_dmaengine processor_thermal_rapl typec_ucsi iwlwifi pmt_dis=
covery drm_kms_helper snd_pcm i2c_hid_acpi intel_rapl_common typec pmt_clas=
s i2c_hid i2c_algo_bit int3400_thermal hid roles fujitsu_laptop intel_pmc_s=
sram_telemetry acpi_thermal_rel acpi_pad acpi_tad cfg80211 battery button v=
ideo processor_thermal_wt_req i2c_i801 snd_timer processor_thermal_power_fl=
oor i2c_smbus mei_me snd intel_lpss_pci processor_thermal_mbox soundcore in=
tel_lpss mei rfkill wmi idma64 intel_vsec ac int340x_thermal_zone igen6_eda=
c parport_pc lp ppdev drm parport efi_pstore configfs nfnetlink autofs4 crc=
32c_cryptoapi sd_mod dm_crypt dm_mod raid10 raid456 async_raid6_recov async=
_memcpy async_pq async_xor async_tx raid1 raid0 md_mod usb_storage scsi_mod=
 scsi_common btrfs blake2b_generic xor raid6_pq xhci_pci xhci_hcd nvme thun=
derbolt nvme_core usbcore e1000e evdev nvme_keyring nvme_auth serio_raw int=
el_hid
Feb 07 17:19:02 heisenberg kernel:  fan pcspkr aesni_intel usb_common hkdf =
sparse_keymap efivarfs
Feb 07 17:19:02 heisenberg kernel: CPU: 4 UID: 0 PID: 157336 Comm: btrfs-tr=
ansacti Tainted: G        W           6.18.8+deb14-amd64 #1 PREEMPT(lazy)  =
Debian 6.18.8-1=20
Feb 07 17:19:02 heisenberg kernel: Tainted: [W]=3DWARN
Feb 07 17:19:02 heisenberg kernel: Hardware name: FUJITSU CLIENT COMPUTING =
LIMITED LIFEBOOK U7512/FJNB2F4, BIOS Version 2.35 07/01/2025
Feb 07 17:19:02 heisenberg kernel: RIP: 0010:btrfs_put_transaction+0x141/0x=
180 [btrfs]
Feb 07 17:19:02 heisenberg kernel: Code: 48 89 ef 5d 41 5c 41 5d e9 8c c3 4=
9 eb 5b be 03 00 00 00 5d 41 5c 41 5d e9 fc 8b 7f eb 0f 0b e9 e2 fe ff ff 0=
f 0b 0f 0b eb d5 <0f> 0b e9 1a ff ff ff 0f 0b e9 21 ff ff ff e8 3c 24 20 eb=
 48 8b 95
Feb 07 17:19:02 heisenberg kernel: RSP: 0018:ffffd1b2cc677de0 EFLAGS: 00010=
282
Feb 07 17:19:02 heisenberg kernel: RAX: ffff8dddba6fe428 RBX: ffff8dddba6fe=
400 RCX: ffff8dd2101b8488
Feb 07 17:19:02 heisenberg kernel: RDX: ffff8dddba6fe428 RSI: ffff8dddba6fe=
428 RDI: ffff8dddba6fe410
Feb 07 17:19:02 heisenberg kernel: RBP: ffff8dddba6fe400 R08: 0000000000000=
000 R09: ffffd1b2cc677db0
Feb 07 17:19:02 heisenberg kernel: R10: ffffd1b2cc677db0 R11: 0000000000000=
000 R12: ffff8ddfffda4000
Feb 07 17:19:02 heisenberg kernel: R13: ffff8dddba6fe428 R14: ffff8dd2101b8=
460 R15: 0000000000000000
Feb 07 17:19:02 heisenberg kernel: FS:  0000000000000000(0000) GS:ffff8de10=
10cc000(0000) knlGS:0000000000000000
Feb 07 17:19:02 heisenberg kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000=
080050033
Feb 07 17:19:02 heisenberg kernel: CR2: 00007fd79ae77000 CR3: 00000003de22c=
004 CR4: 0000000000f72ef0
Feb 07 17:19:02 heisenberg kernel: PKRU: 55555554
Feb 07 17:19:02 heisenberg kernel: Call Trace:
Feb 07 17:19:02 heisenberg kernel:  <TASK>
Feb 07 17:19:02 heisenberg kernel:  btrfs_commit_transaction+0x72a/0xdf0 [b=
trfs]
Feb 07 17:19:02 heisenberg kernel:  ? __pfx_autoremove_wake_function+0x10/0=
x10
Feb 07 17:19:02 heisenberg kernel:  transaction_kthread+0x157/0x1c0 [btrfs]
Feb 07 17:19:02 heisenberg kernel:  ? __pfx_transaction_kthread+0x10/0x10 [=
btrfs]
Feb 07 17:19:02 heisenberg kernel:  kthread+0xfc/0x240
Feb 07 17:19:02 heisenberg kernel:  ? __pfx_kthread+0x10/0x10
Feb 07 17:19:02 heisenberg kernel:  ret_from_fork+0x1cc/0x200
Feb 07 17:19:02 heisenberg kernel:  ? __pfx_kthread+0x10/0x10
Feb 07 17:19:02 heisenberg kernel:  ret_from_fork_asm+0x1a/0x30
Feb 07 17:19:02 heisenberg kernel:  </TASK>
Feb 07 17:19:02 heisenberg kernel: ---[ end trace 0000000000000000 ]---
Feb 07 17:19:09 heisenberg kernel: ------------[ cut here ]------------
Feb 07 17:19:09 heisenberg kernel: WARNING: CPU: 3 PID: 157318 at fs/btrfs/=
extent-tree.c:3230 __btrfs_free_extent.isra.0+0x7ac/0x1010 [btrfs]
Feb 07 17:19:09 heisenberg kernel: Modules linked in: cpuid ext4 mbcache jb=
d2 sg uas nft_fib_ipv6 nft_ct nft_fib_ipv4 nft_fib wireguard libcurve25519 =
libchacha20poly1305 libchacha ip6_udp_tunnel udp_tunnel libpoly1305 cmac cc=
m snd_seq_dummy snd_hrtimer snd_seq snd_ctl_led snd_soc_skl_hda_dsp snd_soc=
_intel_sof_board_helpers snd_sof_probes snd_soc_intel_hda_dsp_common xe snd=
_hda_codec_intelhdmi snd_hda_codec_alc269 snd_hda_scodec_component drm_gpuv=
m snd_hda_codec_realtek_lib drm_gpusvm_helper snd_hda_codec_generic gpu_sch=
ed snd_soc_dmic drm_ttm_helper drm_exec drm_suballoc_helper ip6t_REJECT nf_=
reject_ipv6 ipt_REJECT nf_reject_ipv4 snd_hda_intel xt_tcpudp snd_sof_pci_i=
ntel_tgl xt_conntrack snd_sof_pci_intel_cnl nf_conntrack snd_sof_intel_hda_=
generic nf_defrag_ipv6 soundwire_intel nf_defrag_ipv4 snd_sof_intel_hda_sdw=
_bpt nft_compat nf_tables snd_sof_intel_hda_common intel_uncore_frequency j=
oydev intel_uncore_frequency_common binfmt_misc x_tables snd_soc_hdac_hda x=
86_pkg_temp_thermal snd_sof_intel_hda_mlink intel_powerclamp snd_sof_intel_=
hda
Feb 07 17:19:09 heisenberg kernel:  i915 snd_hda_codec_hdmi soundwire_caden=
ce snd_sof_pci coretemp snd_sof_xtensa_dsp snd_sof kvm_intel snd_sof_utils =
snd_soc_acpi_intel_match snd_soc_acpi_intel_sdca_quirks soundwire_generic_a=
llocation kvm snd_soc_acpi hid_multitouch crc8 soundwire_bus iwlmvm snd_soc=
_sdca snd_soc_avs btusb uvcvideo btmtk irqbypass snd_soc_hda_codec btrtl vi=
deobuf2_vmalloc ghash_clmulni_intel drm_buddy btbcm snd_hda_ext_core uvc hi=
d_generic snd_hda_codec btintel iTCO_wdt rapl videobuf2_memops ttm sdhci_pc=
i snd_usb_audio intel_pmc_bxt processor_thermal_device_pci mac80211 intel_r=
apl_msr videobuf2_v4l2 snd_hda_core sdhci_uhs2 drm_display_helper bluetooth=
 intel_cstate iTCO_vendor_support snd_usbmidi_lib videodev processor_therma=
l_device sdhci snd_intel_dspcfg processor_thermal_wt_hint platform_temperat=
ure_control snd_rawmidi cec videobuf2_common snd_intel_sdw_acpi cqhci proce=
ssor_thermal_soc_slider snd_seq_device snd_hwdep mei_hdcp watchdog mei_pxp =
ee1004 wmi_bmof usbhid mc ecdh_generic libarc4 intel_uncore crc16 intel_pmc=
_core
Feb 07 17:19:09 heisenberg kernel:  mmc_core snd_soc_core rc_core platform_=
profile pmt_telemetry snd_compress ucsi_acpi processor_thermal_rfim drm_cli=
ent_lib snd_pcm_dmaengine processor_thermal_rapl typec_ucsi iwlwifi pmt_dis=
covery drm_kms_helper snd_pcm i2c_hid_acpi intel_rapl_common typec pmt_clas=
s i2c_hid i2c_algo_bit int3400_thermal hid roles fujitsu_laptop intel_pmc_s=
sram_telemetry acpi_thermal_rel acpi_pad acpi_tad cfg80211 battery button v=
ideo processor_thermal_wt_req i2c_i801 snd_timer processor_thermal_power_fl=
oor i2c_smbus mei_me snd intel_lpss_pci processor_thermal_mbox soundcore in=
tel_lpss mei rfkill wmi idma64 intel_vsec ac int340x_thermal_zone igen6_eda=
c parport_pc lp ppdev drm parport efi_pstore configfs nfnetlink autofs4 crc=
32c_cryptoapi sd_mod dm_crypt dm_mod raid10 raid456 async_raid6_recov async=
_memcpy async_pq async_xor async_tx raid1 raid0 md_mod usb_storage scsi_mod=
 scsi_common btrfs blake2b_generic xor raid6_pq xhci_pci xhci_hcd nvme thun=
derbolt nvme_core usbcore e1000e evdev nvme_keyring nvme_auth serio_raw int=
el_hid
Feb 07 17:19:09 heisenberg kernel:  fan pcspkr aesni_intel usb_common hkdf =
sparse_keymap efivarfs
Feb 07 17:19:09 heisenberg kernel: CPU: 3 UID: 0 PID: 157318 Comm: mount Ta=
inted: G        W           6.18.8+deb14-amd64 #1 PREEMPT(lazy)  Debian 6.1=
8.8-1=20
Feb 07 17:19:09 heisenberg kernel: Tainted: [W]=3DWARN
Feb 07 17:19:09 heisenberg kernel: Hardware name: FUJITSU CLIENT COMPUTING =
LIMITED LIFEBOOK U7512/FJNB2F4, BIOS Version 2.35 07/01/2025
Feb 07 17:19:09 heisenberg kernel: RIP: 0010:__btrfs_free_extent.isra.0+0x7=
ac/0x1010 [btrfs]
Feb 07 17:19:09 heisenberg kernel: Code: 00 f0 48 0f ba 28 02 0f 82 72 08 0=
0 00 be 8b ff ff ff 48 c7 c7 68 29 c1 c0 e8 f0 ee 13 eb 0f 0b c6 44 24 2f 0=
1 e9 80 b6 0e 00 <0f> 0b f0 48 0f ba a8 b0 0a 00 00 02 0f 82 fa b3 0e 00 be=
 8b ff ff
Feb 07 17:19:09 heisenberg kernel: RSP: 0018:ffffd1b2e7103960 EFLAGS: 00010=
246
Feb 07 17:19:09 heisenberg kernel: RAX: ffff8dd2101b8000 RBX: 000000000b778=
000 RCX: ffff8dd1a80beaf0
Feb 07 17:19:09 heisenberg kernel: RDX: 0000000000000000 RSI: 0000000000000=
003 RDI: ffff8dd1a80beaf0
Feb 07 17:19:09 heisenberg kernel: RBP: 0000000000000000 R08: 0000000000000=
000 R09: 0000000000000001
Feb 07 17:19:09 heisenberg kernel: R10: 0000000000000fff R11: 0000000000000=
002 R12: 0000000000000001
Feb 07 17:19:09 heisenberg kernel: R13: 0000000000000000 R14: ffff8dd1a80be=
af0 R15: ffff8dd1a80be7e0
Feb 07 17:19:09 heisenberg kernel: FS:  00007f3b3256b840(0000) GS:ffff8de10=
108c000(0000) knlGS:0000000000000000
Feb 07 17:19:09 heisenberg kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000=
080050033
Feb 07 17:19:09 heisenberg kernel: CR2: 00007fb628a2bff0 CR3: 0000000824a1b=
006 CR4: 0000000000f72ef0
Feb 07 17:19:09 heisenberg kernel: PKRU: 55555554
Feb 07 17:19:09 heisenberg kernel: Call Trace:
Feb 07 17:19:09 heisenberg kernel:  <TASK>
Feb 07 17:19:09 heisenberg kernel:  ? btrfs_merge_delayed_refs+0x1bb/0x290 =
[btrfs]
Feb 07 17:19:09 heisenberg kernel:  __btrfs_run_delayed_refs+0x2dc/0xf70 [b=
trfs]
Feb 07 17:19:09 heisenberg kernel:  ? setup_items_for_insert.isra.0+0x196/0=
x420 [btrfs]
Feb 07 17:19:09 heisenberg kernel:  ? release_extent_buffer+0x33/0x120 [btr=
fs]
Feb 07 17:19:09 heisenberg kernel:  ? __btrfs_add_to_free_space_tree+0x294/=
0x3f0 [btrfs]
Feb 07 17:19:09 heisenberg kernel:  btrfs_run_delayed_refs+0x3b/0x120 [btrf=
s]
Feb 07 17:19:09 heisenberg kernel:  btrfs_commit_transaction+0x6d/0xdf0 [bt=
rfs]
Feb 07 17:19:09 heisenberg kernel:  ? populate_free_space_tree+0x89/0x220 [=
btrfs]
Feb 07 17:19:09 heisenberg kernel:  btrfs_rebuild_free_space_tree+0x1c5/0x2=
70 [btrfs]
Feb 07 17:19:09 heisenberg kernel:  btrfs_start_pre_rw_mount+0x2df/0x610 [b=
trfs]
Feb 07 17:19:09 heisenberg kernel:  ? btrfs_get_root_ref+0x2a7/0x3b0 [btrfs=
]
Feb 07 17:19:09 heisenberg kernel:  open_ctree+0x113e/0x15a0 [btrfs]
Feb 07 17:19:09 heisenberg kernel:  btrfs_get_tree.cold+0xb/0xb6 [btrfs]
Feb 07 17:19:09 heisenberg kernel:  ? btrfs_parse_param+0x4f/0x920 [btrfs]
Feb 07 17:19:09 heisenberg kernel:  ? strndup_user+0x4f/0x70
Feb 07 17:19:09 heisenberg kernel:  vfs_get_tree+0x29/0xd0
Feb 07 17:19:09 heisenberg kernel:  vfs_cmd_create+0x57/0xd0
Feb 07 17:19:09 heisenberg kernel:  __do_sys_fsconfig+0x4b6/0x650
Feb 07 17:19:09 heisenberg kernel:  do_syscall_64+0x81/0x7f0
Feb 07 17:19:09 heisenberg kernel:  ? do_syscall_64+0xb9/0x7f0
Feb 07 17:19:09 heisenberg kernel:  ? from_kuid_munged+0x13/0x30
Feb 07 17:19:09 heisenberg kernel:  ? __do_sys_geteuid+0x27/0x30
Feb 07 17:19:09 heisenberg kernel:  ? do_syscall_64+0xb9/0x7f0
Feb 07 17:19:09 heisenberg kernel:  ? exc_page_fault+0x7e/0x1a0
Feb 07 17:19:09 heisenberg kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7=
e
Feb 07 17:19:09 heisenberg kernel: RIP: 0033:0x7f3b32794a6a
Feb 07 17:19:09 heisenberg kernel: Code: 73 01 c3 48 8b 0d a6 23 0d 00 f7 d=
8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 a=
f 01 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 76 23 0d 00 f7 d8 64=
 89 01 48
Feb 07 17:19:09 heisenberg kernel: RSP: 002b:00007ffc7f7d62c8 EFLAGS: 00000=
246 ORIG_RAX: 00000000000001af
Feb 07 17:19:09 heisenberg kernel: RAX: ffffffffffffffda RBX: 000055687071f=
b80 RCX: 00007f3b32794a6a
Feb 07 17:19:09 heisenberg kernel: RDX: 0000000000000000 RSI: 0000000000000=
006 RDI: 0000000000000003
Feb 07 17:19:09 heisenberg kernel: RBP: 0000000000000000 R08: 0000000000000=
000 R09: 0000000000000000
Feb 07 17:19:09 heisenberg kernel: R10: 0000000000000000 R11: 0000000000000=
246 R12: 0000556870720120
Feb 07 17:19:09 heisenberg kernel: R13: 00007f3b3292226c R14: 00007f3b32920=
560 R15: 00007f3b3292226c
Feb 07 17:19:09 heisenberg kernel:  </TASK>
Feb 07 17:19:09 heisenberg kernel: ---[ end trace 0000000000000000 ]---
Feb 07 17:19:09 heisenberg kernel: ------------[ cut here ]------------
Feb 07 17:19:09 heisenberg kernel: BTRFS: Transaction aborted (error -117)
Feb 07 17:19:09 heisenberg kernel: WARNING: CPU: 3 PID: 157318 at fs/btrfs/=
extent-tree.c:3231 __btrfs_free_extent.isra.0+0x7cf/0x1010 [btrfs]
Feb 07 17:19:09 heisenberg kernel: Modules linked in: cpuid ext4 mbcache jb=
d2 sg uas nft_fib_ipv6 nft_ct nft_fib_ipv4 nft_fib wireguard libcurve25519 =
libchacha20poly1305 libchacha ip6_udp_tunnel udp_tunnel libpoly1305 cmac cc=
m snd_seq_dummy snd_hrtimer snd_seq snd_ctl_led snd_soc_skl_hda_dsp snd_soc=
_intel_sof_board_helpers snd_sof_probes snd_soc_intel_hda_dsp_common xe snd=
_hda_codec_intelhdmi snd_hda_codec_alc269 snd_hda_scodec_component drm_gpuv=
m snd_hda_codec_realtek_lib drm_gpusvm_helper snd_hda_codec_generic gpu_sch=
ed snd_soc_dmic drm_ttm_helper drm_exec drm_suballoc_helper ip6t_REJECT nf_=
reject_ipv6 ipt_REJECT nf_reject_ipv4 snd_hda_intel xt_tcpudp snd_sof_pci_i=
ntel_tgl xt_conntrack snd_sof_pci_intel_cnl nf_conntrack snd_sof_intel_hda_=
generic nf_defrag_ipv6 soundwire_intel nf_defrag_ipv4 snd_sof_intel_hda_sdw=
_bpt nft_compat nf_tables snd_sof_intel_hda_common intel_uncore_frequency j=
oydev intel_uncore_frequency_common binfmt_misc x_tables snd_soc_hdac_hda x=
86_pkg_temp_thermal snd_sof_intel_hda_mlink intel_powerclamp snd_sof_intel_=
hda
Feb 07 17:19:09 heisenberg kernel:  i915 snd_hda_codec_hdmi soundwire_caden=
ce snd_sof_pci coretemp snd_sof_xtensa_dsp snd_sof kvm_intel snd_sof_utils =
snd_soc_acpi_intel_match snd_soc_acpi_intel_sdca_quirks soundwire_generic_a=
llocation kvm snd_soc_acpi hid_multitouch crc8 soundwire_bus iwlmvm snd_soc=
_sdca snd_soc_avs btusb uvcvideo btmtk irqbypass snd_soc_hda_codec btrtl vi=
deobuf2_vmalloc ghash_clmulni_intel drm_buddy btbcm snd_hda_ext_core uvc hi=
d_generic snd_hda_codec btintel iTCO_wdt rapl videobuf2_memops ttm sdhci_pc=
i snd_usb_audio intel_pmc_bxt processor_thermal_device_pci mac80211 intel_r=
apl_msr videobuf2_v4l2 snd_hda_core sdhci_uhs2 drm_display_helper bluetooth=
 intel_cstate iTCO_vendor_support snd_usbmidi_lib videodev processor_therma=
l_device sdhci snd_intel_dspcfg processor_thermal_wt_hint platform_temperat=
ure_control snd_rawmidi cec videobuf2_common snd_intel_sdw_acpi cqhci proce=
ssor_thermal_soc_slider snd_seq_device snd_hwdep mei_hdcp watchdog mei_pxp =
ee1004 wmi_bmof usbhid mc ecdh_generic libarc4 intel_uncore crc16 intel_pmc=
_core
Feb 07 17:19:09 heisenberg kernel:  mmc_core snd_soc_core rc_core platform_=
profile pmt_telemetry snd_compress ucsi_acpi processor_thermal_rfim drm_cli=
ent_lib snd_pcm_dmaengine processor_thermal_rapl typec_ucsi iwlwifi pmt_dis=
covery drm_kms_helper snd_pcm i2c_hid_acpi intel_rapl_common typec pmt_clas=
s i2c_hid i2c_algo_bit int3400_thermal hid roles fujitsu_laptop intel_pmc_s=
sram_telemetry acpi_thermal_rel acpi_pad acpi_tad cfg80211 battery button v=
ideo processor_thermal_wt_req i2c_i801 snd_timer processor_thermal_power_fl=
oor i2c_smbus mei_me snd intel_lpss_pci processor_thermal_mbox soundcore in=
tel_lpss mei rfkill wmi idma64 intel_vsec ac int340x_thermal_zone igen6_eda=
c parport_pc lp ppdev drm parport efi_pstore configfs nfnetlink autofs4 crc=
32c_cryptoapi sd_mod dm_crypt dm_mod raid10 raid456 async_raid6_recov async=
_memcpy async_pq async_xor async_tx raid1 raid0 md_mod usb_storage scsi_mod=
 scsi_common btrfs blake2b_generic xor raid6_pq xhci_pci xhci_hcd nvme thun=
derbolt nvme_core usbcore e1000e evdev nvme_keyring nvme_auth serio_raw int=
el_hid
Feb 07 17:19:09 heisenberg kernel:  fan pcspkr aesni_intel usb_common hkdf =
sparse_keymap efivarfs
Feb 07 17:19:09 heisenberg kernel: CPU: 3 UID: 0 PID: 157318 Comm: mount Ta=
inted: G        W           6.18.8+deb14-amd64 #1 PREEMPT(lazy)  Debian 6.1=
8.8-1=20
Feb 07 17:19:09 heisenberg kernel: Tainted: [W]=3DWARN
Feb 07 17:19:09 heisenberg kernel: Hardware name: FUJITSU CLIENT COMPUTING =
LIMITED LIFEBOOK U7512/FJNB2F4, BIOS Version 2.35 07/01/2025
Feb 07 17:19:09 heisenberg kernel: RIP: 0010:__btrfs_free_extent.isra.0+0x7=
cf/0x1010 [btrfs]
Feb 07 17:19:09 heisenberg kernel: Code: 2f 01 e9 80 b6 0e 00 0f 0b f0 48 0=
f ba a8 b0 0a 00 00 02 0f 82 fa b3 0e 00 be 8b ff ff ff 48 c7 c7 68 29 c1 c=
0 e8 c1 ee 13 eb <0f> 0b c6 44 24 2f 01 e9 dd b3 0e 00 89 04 24 e8 6d 79 21=
 eb 48 8b
Feb 07 17:19:09 heisenberg kernel: RSP: 0018:ffffd1b2e7103960 EFLAGS: 00010=
246
Feb 07 17:19:09 heisenberg kernel: RAX: 0000000000000000 RBX: 000000000b778=
000 RCX: 0000000000000027
Feb 07 17:19:09 heisenberg kernel: RDX: ffff8de0af4dce48 RSI: 0000000000000=
001 RDI: ffff8de0af4dce40
Feb 07 17:19:09 heisenberg kernel: RBP: 0000000000000000 R08: 0000000000000=
000 R09: ffffd1b2e7103800
Feb 07 17:19:09 heisenberg kernel: R10: ffffffffad8db948 R11: 00000000ffffe=
fff R12: 0000000000000001
Feb 07 17:19:09 heisenberg kernel: R13: 0000000000000000 R14: ffff8dd1a80be=
af0 R15: ffff8dd1a80be7e0
Feb 07 17:19:09 heisenberg kernel: FS:  00007f3b3256b840(0000) GS:ffff8de10=
108c000(0000) knlGS:0000000000000000
Feb 07 17:19:09 heisenberg kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000=
080050033
Feb 07 17:19:09 heisenberg kernel: CR2: 00007fb628a2bff0 CR3: 0000000824a1b=
006 CR4: 0000000000f72ef0
Feb 07 17:19:09 heisenberg kernel: PKRU: 55555554
Feb 07 17:19:09 heisenberg kernel: Call Trace:
Feb 07 17:19:09 heisenberg kernel:  <TASK>
Feb 07 17:19:09 heisenberg kernel:  ? btrfs_merge_delayed_refs+0x1bb/0x290 =
[btrfs]
Feb 07 17:19:09 heisenberg kernel:  __btrfs_run_delayed_refs+0x2dc/0xf70 [b=
trfs]
Feb 07 17:19:09 heisenberg kernel:  ? setup_items_for_insert.isra.0+0x196/0=
x420 [btrfs]
Feb 07 17:19:09 heisenberg kernel:  ? release_extent_buffer+0x33/0x120 [btr=
fs]
Feb 07 17:19:09 heisenberg kernel:  ? __btrfs_add_to_free_space_tree+0x294/=
0x3f0 [btrfs]
Feb 07 17:19:09 heisenberg kernel:  btrfs_run_delayed_refs+0x3b/0x120 [btrf=
s]
Feb 07 17:19:09 heisenberg kernel:  btrfs_commit_transaction+0x6d/0xdf0 [bt=
rfs]
Feb 07 17:19:09 heisenberg kernel:  ? populate_free_space_tree+0x89/0x220 [=
btrfs]
Feb 07 17:19:09 heisenberg kernel:  btrfs_rebuild_free_space_tree+0x1c5/0x2=
70 [btrfs]
Feb 07 17:19:09 heisenberg kernel:  btrfs_start_pre_rw_mount+0x2df/0x610 [b=
trfs]
Feb 07 17:19:09 heisenberg kernel:  ? btrfs_get_root_ref+0x2a7/0x3b0 [btrfs=
]
Feb 07 17:19:09 heisenberg kernel:  open_ctree+0x113e/0x15a0 [btrfs]
Feb 07 17:19:09 heisenberg kernel:  btrfs_get_tree.cold+0xb/0xb6 [btrfs]
Feb 07 17:19:09 heisenberg kernel:  ? btrfs_parse_param+0x4f/0x920 [btrfs]
Feb 07 17:19:09 heisenberg kernel:  ? strndup_user+0x4f/0x70
Feb 07 17:19:09 heisenberg kernel:  vfs_get_tree+0x29/0xd0
Feb 07 17:19:09 heisenberg kernel:  vfs_cmd_create+0x57/0xd0
Feb 07 17:19:09 heisenberg kernel:  __do_sys_fsconfig+0x4b6/0x650
Feb 07 17:19:09 heisenberg kernel:  do_syscall_64+0x81/0x7f0
Feb 07 17:19:09 heisenberg kernel:  ? do_syscall_64+0xb9/0x7f0
Feb 07 17:19:09 heisenberg kernel:  ? from_kuid_munged+0x13/0x30
Feb 07 17:19:09 heisenberg kernel:  ? __do_sys_geteuid+0x27/0x30
Feb 07 17:19:09 heisenberg kernel:  ? do_syscall_64+0xb9/0x7f0
Feb 07 17:19:09 heisenberg kernel:  ? exc_page_fault+0x7e/0x1a0
Feb 07 17:19:09 heisenberg kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7=
e
Feb 07 17:19:09 heisenberg kernel: RIP: 0033:0x7f3b32794a6a
Feb 07 17:19:09 heisenberg kernel: Code: 73 01 c3 48 8b 0d a6 23 0d 00 f7 d=
8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 a=
f 01 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 76 23 0d 00 f7 d8 64=
 89 01 48
Feb 07 17:19:09 heisenberg kernel: RSP: 002b:00007ffc7f7d62c8 EFLAGS: 00000=
246 ORIG_RAX: 00000000000001af
Feb 07 17:19:09 heisenberg kernel: RAX: ffffffffffffffda RBX: 000055687071f=
b80 RCX: 00007f3b32794a6a
Feb 07 17:19:09 heisenberg kernel: RDX: 0000000000000000 RSI: 0000000000000=
006 RDI: 0000000000000003
Feb 07 17:19:09 heisenberg kernel: RBP: 0000000000000000 R08: 0000000000000=
000 R09: 0000000000000000
Feb 07 17:19:09 heisenberg kernel: R10: 0000000000000000 R11: 0000000000000=
246 R12: 0000556870720120
Feb 07 17:19:09 heisenberg kernel: R13: 00007f3b3292226c R14: 00007f3b32920=
560 R15: 00007f3b3292226c
Feb 07 17:19:09 heisenberg kernel:  </TASK>
Feb 07 17:19:09 heisenberg kernel: ---[ end trace 0000000000000000 ]---
Feb 07 17:19:09 heisenberg kernel: BTRFS: error (device dm-2 state A) in __=
btrfs_free_extent:3231: errno=3D-117 Filesystem corrupted
Feb 07 17:19:09 heisenberg kernel: BTRFS info (device dm-2 state EA): leaf =
252116992 gen 2941 total ptrs 201 free space 2789 owner 2
Feb 07 17:19:09 heisenberg kernel:         item 0 key (190398464 METADATA_I=
TEM 0) itemoff 16241 itemsize 42
Feb 07 17:19:09 heisenberg kernel:                 extent refs 2 gen 2608 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 279
Feb 07 17:19:09 heisenberg kernel:                 ref#1: tree block backre=
f root 278
Feb 07 17:19:09 heisenberg kernel:         item 1 key (190414848 METADATA_I=
TEM 0) itemoff 16208 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2716 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 283
Feb 07 17:19:09 heisenberg kernel:         item 2 key (190431232 METADATA_I=
TEM 1) itemoff 16175 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2716 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 283
Feb 07 17:19:09 heisenberg kernel:         item 3 key (190447616 METADATA_I=
TEM 0) itemoff 16079 itemsize 96
Feb 07 17:19:09 heisenberg kernel:                 extent refs 8 gen 2716 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 290
Feb 07 17:19:09 heisenberg kernel:                 ref#1: tree block backre=
f root 289
Feb 07 17:19:09 heisenberg kernel:                 ref#2: tree block backre=
f root 288
Feb 07 17:19:09 heisenberg kernel:                 ref#3: tree block backre=
f root 287
Feb 07 17:19:09 heisenberg kernel:                 ref#4: tree block backre=
f root 286
Feb 07 17:19:09 heisenberg kernel:                 ref#5: tree block backre=
f root 285
Feb 07 17:19:09 heisenberg kernel:                 ref#6: tree block backre=
f root 284
Feb 07 17:19:09 heisenberg kernel:                 ref#7: tree block backre=
f root 283
Feb 07 17:19:09 heisenberg kernel:         item 4 key (190464000 METADATA_I=
TEM 0) itemoff 16046 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2716 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 283
Feb 07 17:19:09 heisenberg kernel:         item 5 key (190480384 METADATA_I=
TEM 0) itemoff 16013 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2771 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 7
Feb 07 17:19:09 heisenberg kernel:         item 6 key (190496768 METADATA_I=
TEM 0) itemoff 15980 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2771 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 5
Feb 07 17:19:09 heisenberg kernel:         item 7 key (190513152 METADATA_I=
TEM 0) itemoff 15947 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2716 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 283
Feb 07 17:19:09 heisenberg kernel:         item 8 key (190529536 METADATA_I=
TEM 0) itemoff 15914 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2723 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 284
Feb 07 17:19:09 heisenberg kernel:         item 9 key (190545920 METADATA_I=
TEM 0) itemoff 15881 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2669 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 281
Feb 07 17:19:09 heisenberg kernel:         item 10 key (190562304 METADATA_=
ITEM 0) itemoff 15848 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2771 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 7
Feb 07 17:19:09 heisenberg kernel:         item 11 key (190578688 METADATA_=
ITEM 0) itemoff 15815 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2610 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 2
Feb 07 17:19:09 heisenberg kernel:         item 12 key (190595072 METADATA_=
ITEM 0) itemoff 15782 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2771 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 7
Feb 07 17:19:09 heisenberg kernel:         item 13 key (190611456 METADATA_=
ITEM 0) itemoff 15749 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2716 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 283
Feb 07 17:19:09 heisenberg kernel:         item 14 key (190627840 METADATA_=
ITEM 0) itemoff 15716 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2771 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 7
Feb 07 17:19:09 heisenberg kernel:         item 15 key (190644224 METADATA_=
ITEM 0) itemoff 15683 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2756 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 286
Feb 07 17:19:09 heisenberg kernel:         item 16 key (190660608 METADATA_=
ITEM 0) itemoff 15650 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2771 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 7
Feb 07 17:19:09 heisenberg kernel:         item 17 key (190676992 METADATA_=
ITEM 0) itemoff 15617 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2771 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 7
Feb 07 17:19:09 heisenberg kernel:         item 18 key (190693376 METADATA_=
ITEM 0) itemoff 15584 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2716 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 283
Feb 07 17:19:09 heisenberg kernel:         item 19 key (190709760 METADATA_=
ITEM 0) itemoff 15551 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2716 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 283
Feb 07 17:19:09 heisenberg kernel:         item 20 key (190726144 METADATA_=
ITEM 0) itemoff 15518 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2610 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 2
Feb 07 17:19:09 heisenberg kernel:         item 21 key (190742528 METADATA_=
ITEM 0) itemoff 15467 itemsize 51
Feb 07 17:19:09 heisenberg kernel:                 extent refs 3 gen 2738 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 287
Feb 07 17:19:09 heisenberg kernel:                 ref#1: tree block backre=
f root 286
Feb 07 17:19:09 heisenberg kernel:                 ref#2: tree block backre=
f root 285
Feb 07 17:19:09 heisenberg kernel:         item 22 key (190758912 METADATA_=
ITEM 0) itemoff 15434 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2723 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 284
Feb 07 17:19:09 heisenberg kernel:         item 23 key (190775296 METADATA_=
ITEM 1) itemoff 15383 itemsize 51
Feb 07 17:19:09 heisenberg kernel:                 extent refs 3 gen 2716 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 285
Feb 07 17:19:09 heisenberg kernel:                 ref#1: tree block backre=
f root 284
Feb 07 17:19:09 heisenberg kernel:                 ref#2: tree block backre=
f root 283
Feb 07 17:19:09 heisenberg kernel:         item 24 key (190791680 METADATA_=
ITEM 0) itemoff 15350 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2716 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 283
Feb 07 17:19:09 heisenberg kernel:         item 25 key (190808064 METADATA_=
ITEM 0) itemoff 15317 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2716 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 283
Feb 07 17:19:09 heisenberg kernel:         item 26 key (190824448 METADATA_=
ITEM 0) itemoff 15284 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2716 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 283
Feb 07 17:19:09 heisenberg kernel:         item 27 key (190840832 METADATA_=
ITEM 0) itemoff 15251 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2716 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 283
Feb 07 17:19:09 heisenberg kernel:         item 28 key (190857216 METADATA_=
ITEM 0) itemoff 15218 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2716 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 283
Feb 07 17:19:09 heisenberg kernel:         item 29 key (190873600 METADATA_=
ITEM 0) itemoff 15185 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2716 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 283
Feb 07 17:19:09 heisenberg kernel:         item 30 key (190889984 METADATA_=
ITEM 0) itemoff 15089 itemsize 96
Feb 07 17:19:09 heisenberg kernel:                 extent refs 8 gen 2688 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 295
Feb 07 17:19:09 heisenberg kernel:                 ref#1: tree block backre=
f root 293
Feb 07 17:19:09 heisenberg kernel:                 ref#2: tree block backre=
f root 292
Feb 07 17:19:09 heisenberg kernel:                 ref#3: tree block backre=
f root 289
Feb 07 17:19:09 heisenberg kernel:                 ref#4: tree block backre=
f root 288
Feb 07 17:19:09 heisenberg kernel:                 ref#5: tree block backre=
f root 287
Feb 07 17:19:09 heisenberg kernel:                 ref#6: tree block backre=
f root 286
Feb 07 17:19:09 heisenberg kernel:                 ref#7: tree block backre=
f root 282
Feb 07 17:19:09 heisenberg kernel:         item 31 key (190971904 METADATA_=
ITEM 0) itemoff 15047 itemsize 42
Feb 07 17:19:09 heisenberg kernel:                 extent refs 2 gen 2738 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 286
Feb 07 17:19:09 heisenberg kernel:                 ref#1: tree block backre=
f root 285
Feb 07 17:19:09 heisenberg kernel:         item 32 key (190988288 METADATA_=
ITEM 0) itemoff 15014 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2771 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 7
Feb 07 17:19:09 heisenberg kernel:         item 33 key (191004672 METADATA_=
ITEM 0) itemoff 14981 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2610 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 2
Feb 07 17:19:09 heisenberg kernel:         item 34 key (191021056 METADATA_=
ITEM 0) itemoff 14885 itemsize 96
Feb 07 17:19:09 heisenberg kernel:                 extent refs 8 gen 2756 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 294
Feb 07 17:19:09 heisenberg kernel:                 ref#1: tree block backre=
f root 293
Feb 07 17:19:09 heisenberg kernel:                 ref#2: tree block backre=
f root 292
Feb 07 17:19:09 heisenberg kernel:                 ref#3: tree block backre=
f root 291
Feb 07 17:19:09 heisenberg kernel:                 ref#4: tree block backre=
f root 289
Feb 07 17:19:09 heisenberg kernel:                 ref#5: tree block backre=
f root 288
Feb 07 17:19:09 heisenberg kernel:                 ref#6: tree block backre=
f root 287
Feb 07 17:19:09 heisenberg kernel:                 ref#7: tree block backre=
f root 286
Feb 07 17:19:09 heisenberg kernel:         item 35 key (191037440 METADATA_=
ITEM 0) itemoff 14852 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2771 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 7
Feb 07 17:19:09 heisenberg kernel:         item 36 key (191053824 METADATA_=
ITEM 0) itemoff 14819 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2771 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 7
Feb 07 17:19:09 heisenberg kernel:         item 37 key (191070208 METADATA_=
ITEM 0) itemoff 14723 itemsize 96
Feb 07 17:19:09 heisenberg kernel:                 extent refs 8 gen 2688 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 295
Feb 07 17:19:09 heisenberg kernel:                 ref#1: tree block backre=
f root 293
Feb 07 17:19:09 heisenberg kernel:                 ref#2: tree block backre=
f root 292
Feb 07 17:19:09 heisenberg kernel:                 ref#3: tree block backre=
f root 289
Feb 07 17:19:09 heisenberg kernel:                 ref#4: tree block backre=
f root 288
Feb 07 17:19:09 heisenberg kernel:                 ref#5: tree block backre=
f root 287
Feb 07 17:19:09 heisenberg kernel:                 ref#6: tree block backre=
f root 286
Feb 07 17:19:09 heisenberg kernel:                 ref#7: tree block backre=
f root 282
Feb 07 17:19:09 heisenberg kernel:         item 38 key (191086592 METADATA_=
ITEM 0) itemoff 14690 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2771 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 7
Feb 07 17:19:09 heisenberg kernel:         item 39 key (191102976 METADATA_=
ITEM 0) itemoff 14657 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2771 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 7
Feb 07 17:19:09 heisenberg kernel:         item 40 key (191119360 METADATA_=
ITEM 0) itemoff 14624 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2866 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 291
Feb 07 17:19:09 heisenberg kernel:         item 41 key (191135744 METADATA_=
ITEM 0) itemoff 14591 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2771 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 7
Feb 07 17:19:09 heisenberg kernel:         item 42 key (191152128 METADATA_=
ITEM 0) itemoff 14558 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2771 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 7
Feb 07 17:19:09 heisenberg kernel:         item 43 key (191168512 METADATA_=
ITEM 0) itemoff 14489 itemsize 69
Feb 07 17:19:09 heisenberg kernel:                 extent refs 5 gen 2756 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 291
Feb 07 17:19:09 heisenberg kernel:                 ref#1: tree block backre=
f root 289
Feb 07 17:19:09 heisenberg kernel:                 ref#2: tree block backre=
f root 288
Feb 07 17:19:09 heisenberg kernel:                 ref#3: tree block backre=
f root 287
Feb 07 17:19:09 heisenberg kernel:                 ref#4: tree block backre=
f root 286
Feb 07 17:19:09 heisenberg kernel:         item 44 key (191184896 METADATA_=
ITEM 0) itemoff 14456 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2770 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 7
Feb 07 17:19:09 heisenberg kernel:         item 45 key (191201280 METADATA_=
ITEM 0) itemoff 14423 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2770 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 7
Feb 07 17:19:09 heisenberg kernel:         item 46 key (191217664 METADATA_=
ITEM 0) itemoff 14390 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2770 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 7
Feb 07 17:19:09 heisenberg kernel:         item 47 key (191234048 METADATA_=
ITEM 0) itemoff 14357 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2770 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 7
Feb 07 17:19:09 heisenberg kernel:         item 48 key (191250432 METADATA_=
ITEM 0) itemoff 14324 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2770 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 7
Feb 07 17:19:09 heisenberg kernel:         item 49 key (191266816 METADATA_=
ITEM 0) itemoff 14291 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2768 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 7
Feb 07 17:19:09 heisenberg kernel:         item 50 key (191283200 METADATA_=
ITEM 0) itemoff 14258 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2756 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 286
Feb 07 17:19:09 heisenberg kernel:         item 51 key (191299584 METADATA_=
ITEM 1) itemoff 14225 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2716 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 283
Feb 07 17:19:09 heisenberg kernel:         item 52 key (191315968 METADATA_=
ITEM 0) itemoff 14192 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2716 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 283
Feb 07 17:19:09 heisenberg kernel:         item 53 key (191332352 METADATA_=
ITEM 0) itemoff 14159 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2716 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 283
Feb 07 17:19:09 heisenberg kernel:         item 54 key (191348736 METADATA_=
ITEM 0) itemoff 14090 itemsize 69
Feb 07 17:19:09 heisenberg kernel:                 extent refs 5 gen 2723 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 288
Feb 07 17:19:09 heisenberg kernel:                 ref#1: tree block backre=
f root 287
Feb 07 17:19:09 heisenberg kernel:                 ref#2: tree block backre=
f root 286
Feb 07 17:19:09 heisenberg kernel:                 ref#3: tree block backre=
f root 285
Feb 07 17:19:09 heisenberg kernel:                 ref#4: tree block backre=
f root 284
Feb 07 17:19:09 heisenberg kernel:         item 55 key (191365120 METADATA_=
ITEM 0) itemoff 14057 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2716 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 283
Feb 07 17:19:09 heisenberg kernel:         item 56 key (191381504 METADATA_=
ITEM 0) itemoff 14024 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2716 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 283
Feb 07 17:19:09 heisenberg kernel:         item 57 key (191397888 METADATA_=
ITEM 0) itemoff 13991 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2716 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 283
Feb 07 17:19:09 heisenberg kernel:         item 58 key (191414272 METADATA_=
ITEM 0) itemoff 13958 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2716 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 283
Feb 07 17:19:09 heisenberg kernel:         item 59 key (191430656 METADATA_=
ITEM 0) itemoff 13916 itemsize 42
Feb 07 17:19:09 heisenberg kernel:                 extent refs 2 gen 2688 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 286
Feb 07 17:19:09 heisenberg kernel:                 ref#1: tree block backre=
f root 282
Feb 07 17:19:09 heisenberg kernel:         item 60 key (191447040 METADATA_=
ITEM 0) itemoff 13856 itemsize 60
Feb 07 17:19:09 heisenberg kernel:                 extent refs 4 gen 2723 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 287
Feb 07 17:19:09 heisenberg kernel:                 ref#1: tree block backre=
f root 286
Feb 07 17:19:09 heisenberg kernel:                 ref#2: tree block backre=
f root 285
Feb 07 17:19:09 heisenberg kernel:                 ref#3: tree block backre=
f root 284
Feb 07 17:19:09 heisenberg kernel:         item 61 key (191463424 METADATA_=
ITEM 1) itemoff 13823 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2716 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 283
Feb 07 17:19:09 heisenberg kernel:         item 62 key (191479808 METADATA_=
ITEM 0) itemoff 13790 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2716 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 283
Feb 07 17:19:09 heisenberg kernel:         item 63 key (191496192 METADATA_=
ITEM 0) itemoff 13757 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2716 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 283
Feb 07 17:19:09 heisenberg kernel:         item 64 key (191512576 METADATA_=
ITEM 0) itemoff 13724 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2771 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 7
Feb 07 17:19:09 heisenberg kernel:         item 65 key (191528960 METADATA_=
ITEM 0) itemoff 13691 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2716 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 283
Feb 07 17:19:09 heisenberg kernel:         item 66 key (191545344 METADATA_=
ITEM 0) itemoff 13658 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2723 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 284
Feb 07 17:19:09 heisenberg kernel:         item 67 key (191561728 METADATA_=
ITEM 0) itemoff 13625 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2716 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 283
Feb 07 17:19:09 heisenberg kernel:         item 68 key (191578112 METADATA_=
ITEM 0) itemoff 13592 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2716 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 283
Feb 07 17:19:09 heisenberg kernel:         item 69 key (191594496 METADATA_=
ITEM 0) itemoff 13559 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2716 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 283
Feb 07 17:19:09 heisenberg kernel:         item 70 key (191610880 METADATA_=
ITEM 1) itemoff 13526 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2716 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 283
Feb 07 17:19:09 heisenberg kernel:         item 71 key (191627264 METADATA_=
ITEM 0) itemoff 13493 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2716 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 283
Feb 07 17:19:09 heisenberg kernel:         item 72 key (191643648 METADATA_=
ITEM 0) itemoff 13451 itemsize 42
Feb 07 17:19:09 heisenberg kernel:                 extent refs 2 gen 2716 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 284
Feb 07 17:19:09 heisenberg kernel:                 ref#1: tree block backre=
f root 283
Feb 07 17:19:09 heisenberg kernel:         item 73 key (191660032 METADATA_=
ITEM 0) itemoff 13418 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2771 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 7
Feb 07 17:19:09 heisenberg kernel:         item 74 key (191676416 METADATA_=
ITEM 0) itemoff 13385 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2716 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 283
Feb 07 17:19:09 heisenberg kernel:         item 75 key (191692800 METADATA_=
ITEM 0) itemoff 13352 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2716 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 283
Feb 07 17:19:09 heisenberg kernel:         item 76 key (191709184 METADATA_=
ITEM 0) itemoff 13319 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2756 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 286
Feb 07 17:19:09 heisenberg kernel:         item 77 key (191725568 METADATA_=
ITEM 0) itemoff 13286 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2770 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 7
Feb 07 17:19:09 heisenberg kernel:         item 78 key (191741952 METADATA_=
ITEM 0) itemoff 13253 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2922 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 7
Feb 07 17:19:09 heisenberg kernel:         item 79 key (191758336 METADATA_=
ITEM 0) itemoff 13220 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2922 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 7
Feb 07 17:19:09 heisenberg kernel:         item 80 key (191774720 METADATA_=
ITEM 0) itemoff 13187 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2770 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 7
Feb 07 17:19:09 heisenberg kernel:         item 81 key (191791104 METADATA_=
ITEM 0) itemoff 13064 itemsize 123
Feb 07 17:19:09 heisenberg kernel:                 extent refs 11 gen 2738 =
flags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 295
Feb 07 17:19:09 heisenberg kernel:                 ref#1: tree block backre=
f root 294
Feb 07 17:19:09 heisenberg kernel:                 ref#2: tree block backre=
f root 293
Feb 07 17:19:09 heisenberg kernel:                 ref#3: tree block backre=
f root 292
Feb 07 17:19:09 heisenberg kernel:                 ref#4: tree block backre=
f root 291
Feb 07 17:19:09 heisenberg kernel:                 ref#5: tree block backre=
f root 290
Feb 07 17:19:09 heisenberg kernel:                 ref#6: tree block backre=
f root 289
Feb 07 17:19:09 heisenberg kernel:                 ref#7: tree block backre=
f root 288
Feb 07 17:19:09 heisenberg kernel:                 ref#8: tree block backre=
f root 287
Feb 07 17:19:09 heisenberg kernel:                 ref#9: tree block backre=
f root 286
Feb 07 17:19:09 heisenberg kernel:                 ref#10: tree block backr=
ef root 285
Feb 07 17:19:09 heisenberg kernel:         item 82 key (191807488 METADATA_=
ITEM 0) itemoff 13031 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2771 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 7
Feb 07 17:19:09 heisenberg kernel:         item 83 key (191823872 METADATA_=
ITEM 0) itemoff 12962 itemsize 69
Feb 07 17:19:09 heisenberg kernel:                 extent refs 5 gen 2756 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 291
Feb 07 17:19:09 heisenberg kernel:                 ref#1: tree block backre=
f root 289
Feb 07 17:19:09 heisenberg kernel:                 ref#2: tree block backre=
f root 288
Feb 07 17:19:09 heisenberg kernel:                 ref#3: tree block backre=
f root 287
Feb 07 17:19:09 heisenberg kernel:                 ref#4: tree block backre=
f root 286
Feb 07 17:19:09 heisenberg kernel:         item 84 key (191840256 METADATA_=
ITEM 0) itemoff 12929 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2771 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 7
Feb 07 17:19:09 heisenberg kernel:         item 85 key (191856640 METADATA_=
ITEM 0) itemoff 12896 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2771 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 7
Feb 07 17:19:09 heisenberg kernel:         item 86 key (191873024 METADATA_=
ITEM 0) itemoff 12854 itemsize 42
Feb 07 17:19:09 heisenberg kernel:                 extent refs 2 gen 2716 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 284
Feb 07 17:19:09 heisenberg kernel:                 ref#1: tree block backre=
f root 283
Feb 07 17:19:09 heisenberg kernel:         item 87 key (191889408 METADATA_=
ITEM 0) itemoff 12821 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2770 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 7
Feb 07 17:19:09 heisenberg kernel:         item 88 key (191905792 METADATA_=
ITEM 0) itemoff 12788 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2770 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 7
Feb 07 17:19:09 heisenberg kernel:         item 89 key (191922176 METADATA_=
ITEM 0) itemoff 12755 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2768 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 7
Feb 07 17:19:09 heisenberg kernel:         item 90 key (191987712 METADATA_=
ITEM 0) itemoff 12722 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2756 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 286
Feb 07 17:19:09 heisenberg kernel:         item 91 key (192004096 METADATA_=
ITEM 0) itemoff 12689 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2651 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 280
Feb 07 17:19:09 heisenberg kernel:         item 92 key (192020480 METADATA_=
ITEM 0) itemoff 12629 itemsize 60
Feb 07 17:19:09 heisenberg kernel:                 extent refs 4 gen 2738 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 288
Feb 07 17:19:09 heisenberg kernel:                 ref#1: tree block backre=
f root 287
Feb 07 17:19:09 heisenberg kernel:                 ref#2: tree block backre=
f root 286
Feb 07 17:19:09 heisenberg kernel:                 ref#3: tree block backre=
f root 285
Feb 07 17:19:09 heisenberg kernel:         item 93 key (192036864 METADATA_=
ITEM 0) itemoff 12596 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2771 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 7
Feb 07 17:19:09 heisenberg kernel:         item 94 key (192053248 METADATA_=
ITEM 0) itemoff 12509 itemsize 87
Feb 07 17:19:09 heisenberg kernel:                 extent refs 7 gen 2688 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 293
Feb 07 17:19:09 heisenberg kernel:                 ref#1: tree block backre=
f root 292
Feb 07 17:19:09 heisenberg kernel:                 ref#2: tree block backre=
f root 289
Feb 07 17:19:09 heisenberg kernel:                 ref#3: tree block backre=
f root 288
Feb 07 17:19:09 heisenberg kernel:                 ref#4: tree block backre=
f root 287
Feb 07 17:19:09 heisenberg kernel:                 ref#5: tree block backre=
f root 286
Feb 07 17:19:09 heisenberg kernel:                 ref#6: tree block backre=
f root 282
Feb 07 17:19:09 heisenberg kernel:         item 95 key (192118784 METADATA_=
ITEM 0) itemoff 12476 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2756 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 286
Feb 07 17:19:09 heisenberg kernel:         item 96 key (192135168 METADATA_=
ITEM 0) itemoff 12380 itemsize 96
Feb 07 17:19:09 heisenberg kernel:                 extent refs 8 gen 2756 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 294
Feb 07 17:19:09 heisenberg kernel:                 ref#1: tree block backre=
f root 293
Feb 07 17:19:09 heisenberg kernel:                 ref#2: tree block backre=
f root 292
Feb 07 17:19:09 heisenberg kernel:                 ref#3: tree block backre=
f root 291
Feb 07 17:19:09 heisenberg kernel:                 ref#4: tree block backre=
f root 289
Feb 07 17:19:09 heisenberg kernel:                 ref#5: tree block backre=
f root 288
Feb 07 17:19:09 heisenberg kernel:                 ref#6: tree block backre=
f root 287
Feb 07 17:19:09 heisenberg kernel:                 ref#7: tree block backre=
f root 286
Feb 07 17:19:09 heisenberg kernel:         item 97 key (192151552 METADATA_=
ITEM 0) itemoff 12347 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2771 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 7
Feb 07 17:19:09 heisenberg kernel:         item 98 key (192167936 METADATA_=
ITEM 0) itemoff 12314 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2771 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 7
Feb 07 17:19:09 heisenberg kernel:         item 99 key (192184320 METADATA_=
ITEM 0) itemoff 12281 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2723 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 284
Feb 07 17:19:09 heisenberg kernel:         item 100 key (192200704 METADATA=
_ITEM 0) itemoff 12248 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2771 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 7
Feb 07 17:19:09 heisenberg kernel:         item 101 key (192217088 METADATA=
_ITEM 0) itemoff 12215 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2651 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 280
Feb 07 17:19:09 heisenberg kernel:         item 102 key (192233472 METADATA=
_ITEM 0) itemoff 12155 itemsize 60
Feb 07 17:19:09 heisenberg kernel:                 extent refs 4 gen 2738 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 288
Feb 07 17:19:09 heisenberg kernel:                 ref#1: tree block backre=
f root 287
Feb 07 17:19:09 heisenberg kernel:                 ref#2: tree block backre=
f root 286
Feb 07 17:19:09 heisenberg kernel:                 ref#3: tree block backre=
f root 285
Feb 07 17:19:09 heisenberg kernel:         item 103 key (192249856 METADATA=
_ITEM 0) itemoff 12122 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2771 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 7
Feb 07 17:19:09 heisenberg kernel:         item 104 key (192266240 METADATA=
_ITEM 0) itemoff 12089 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2716 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 283
Feb 07 17:19:09 heisenberg kernel:         item 105 key (192282624 METADATA=
_ITEM 0) itemoff 12056 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2771 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 7
Feb 07 17:19:09 heisenberg kernel:         item 106 key (192299008 METADATA=
_ITEM 0) itemoff 12023 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2716 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 283
Feb 07 17:19:09 heisenberg kernel:         item 107 key (192315392 METADATA=
_ITEM 0) itemoff 11963 itemsize 60
Feb 07 17:19:09 heisenberg kernel:                 extent refs 4 gen 2651 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 283
Feb 07 17:19:09 heisenberg kernel:                 ref#1: tree block backre=
f root 282
Feb 07 17:19:09 heisenberg kernel:                 ref#2: tree block backre=
f root 281
Feb 07 17:19:09 heisenberg kernel:                 ref#3: tree block backre=
f root 280
Feb 07 17:19:09 heisenberg kernel:         item 108 key (192331776 METADATA=
_ITEM 0) itemoff 11930 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2770 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 7
Feb 07 17:19:09 heisenberg kernel:         item 109 key (192413696 METADATA=
_ITEM 0) itemoff 11897 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2716 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 283
Feb 07 17:19:09 heisenberg kernel:         item 110 key (192430080 METADATA=
_ITEM 0) itemoff 11855 itemsize 42
Feb 07 17:19:09 heisenberg kernel:                 extent refs 2 gen 2884 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 294
Feb 07 17:19:09 heisenberg kernel:                 ref#1: tree block backre=
f root 293
Feb 07 17:19:09 heisenberg kernel:         item 111 key (192446464 METADATA=
_ITEM 0) itemoff 11822 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2771 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 7
Feb 07 17:19:09 heisenberg kernel:         item 112 key (192462848 METADATA=
_ITEM 0) itemoff 11789 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2716 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 283
Feb 07 17:19:09 heisenberg kernel:         item 113 key (192479232 METADATA=
_ITEM 0) itemoff 11756 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2862 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 291
Feb 07 17:19:09 heisenberg kernel:         item 114 key (192495616 METADATA=
_ITEM 0) itemoff 11723 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2770 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 5
Feb 07 17:19:09 heisenberg kernel:         item 115 key (192512000 METADATA=
_ITEM 0) itemoff 11672 itemsize 51
Feb 07 17:19:09 heisenberg kernel:                 extent refs 3 gen 2871 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 294
Feb 07 17:19:09 heisenberg kernel:                 ref#1: tree block backre=
f root 293
Feb 07 17:19:09 heisenberg kernel:                 ref#2: tree block backre=
f root 292
Feb 07 17:19:09 heisenberg kernel:         item 116 key (192528384 METADATA=
_ITEM 0) itemoff 11630 itemsize 42
Feb 07 17:19:09 heisenberg kernel:                 extent refs 2 gen 2651 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 281
Feb 07 17:19:09 heisenberg kernel:                 ref#1: tree block backre=
f root 280
Feb 07 17:19:09 heisenberg kernel:         item 117 key (192544768 METADATA=
_ITEM 0) itemoff 11570 itemsize 60
Feb 07 17:19:09 heisenberg kernel:                 extent refs 4 gen 2651 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 283
Feb 07 17:19:09 heisenberg kernel:                 ref#1: tree block backre=
f root 282
Feb 07 17:19:09 heisenberg kernel:                 ref#2: tree block backre=
f root 281
Feb 07 17:19:09 heisenberg kernel:                 ref#3: tree block backre=
f root 280
Feb 07 17:19:09 heisenberg kernel:         item 118 key (192561152 METADATA=
_ITEM 0) itemoff 11528 itemsize 42
Feb 07 17:19:09 heisenberg kernel:                 extent refs 2 gen 2651 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 281
Feb 07 17:19:09 heisenberg kernel:                 ref#1: tree block backre=
f root 280
Feb 07 17:19:09 heisenberg kernel:         item 119 key (192577536 METADATA=
_ITEM 0) itemoff 11486 itemsize 42
Feb 07 17:19:09 heisenberg kernel:                 extent refs 2 gen 2651 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 281
Feb 07 17:19:09 heisenberg kernel:                 ref#1: tree block backre=
f root 280
Feb 07 17:19:09 heisenberg kernel:         item 120 key (192593920 METADATA=
_ITEM 0) itemoff 11444 itemsize 42
Feb 07 17:19:09 heisenberg kernel:                 extent refs 2 gen 2651 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 281
Feb 07 17:19:09 heisenberg kernel:                 ref#1: tree block backre=
f root 280
Feb 07 17:19:09 heisenberg kernel:         item 121 key (192610304 METADATA=
_ITEM 0) itemoff 11411 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2771 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 7
Feb 07 17:19:09 heisenberg kernel:         item 122 key (192626688 METADATA=
_ITEM 0) itemoff 11369 itemsize 42
Feb 07 17:19:09 heisenberg kernel:                 extent refs 2 gen 2651 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 281
Feb 07 17:19:09 heisenberg kernel:                 ref#1: tree block backre=
f root 280
Feb 07 17:19:09 heisenberg kernel:         item 123 key (192643072 METADATA=
_ITEM 0) itemoff 11336 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2771 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 7
Feb 07 17:19:09 heisenberg kernel:         item 124 key (192659456 METADATA=
_ITEM 0) itemoff 11303 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2862 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 291
Feb 07 17:19:09 heisenberg kernel:         item 125 key (192675840 METADATA=
_ITEM 0) itemoff 11261 itemsize 42
Feb 07 17:19:09 heisenberg kernel:                 extent refs 2 gen 2651 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 281
Feb 07 17:19:09 heisenberg kernel:                 ref#1: tree block backre=
f root 280
Feb 07 17:19:09 heisenberg kernel:         item 126 key (192692224 METADATA=
_ITEM 0) itemoff 11201 itemsize 60
Feb 07 17:19:09 heisenberg kernel:                 extent refs 4 gen 2738 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 288
Feb 07 17:19:09 heisenberg kernel:                 ref#1: tree block backre=
f root 287
Feb 07 17:19:09 heisenberg kernel:                 ref#2: tree block backre=
f root 286
Feb 07 17:19:09 heisenberg kernel:                 ref#3: tree block backre=
f root 285
Feb 07 17:19:09 heisenberg kernel:         item 127 key (192708608 METADATA=
_ITEM 0) itemoff 11159 itemsize 42
Feb 07 17:19:09 heisenberg kernel:                 extent refs 2 gen 2651 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 281
Feb 07 17:19:09 heisenberg kernel:                 ref#1: tree block backre=
f root 280
Feb 07 17:19:09 heisenberg kernel:         item 128 key (192724992 METADATA=
_ITEM 0) itemoff 11117 itemsize 42
Feb 07 17:19:09 heisenberg kernel:                 extent refs 2 gen 2651 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 281
Feb 07 17:19:09 heisenberg kernel:                 ref#1: tree block backre=
f root 280
Feb 07 17:19:09 heisenberg kernel:         item 129 key (192741376 METADATA=
_ITEM 0) itemoff 11075 itemsize 42
Feb 07 17:19:09 heisenberg kernel:                 extent refs 2 gen 2651 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 281
Feb 07 17:19:09 heisenberg kernel:                 ref#1: tree block backre=
f root 280
Feb 07 17:19:09 heisenberg kernel:         item 130 key (192757760 METADATA=
_ITEM 0) itemoff 11042 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2651 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 280
Feb 07 17:19:09 heisenberg kernel:         item 131 key (192774144 METADATA=
_ITEM 0) itemoff 11009 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2608 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 2
Feb 07 17:19:09 heisenberg kernel:         item 132 key (192790528 METADATA=
_ITEM 0) itemoff 10976 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2771 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 7
Feb 07 17:19:09 heisenberg kernel:         item 133 key (192806912 METADATA=
_ITEM 0) itemoff 10844 itemsize 132
Feb 07 17:19:09 heisenberg kernel:                 extent refs 12 gen 2723 =
flags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 295
Feb 07 17:19:09 heisenberg kernel:                 ref#1: tree block backre=
f root 294
Feb 07 17:19:09 heisenberg kernel:                 ref#2: tree block backre=
f root 293
Feb 07 17:19:09 heisenberg kernel:                 ref#3: tree block backre=
f root 292
Feb 07 17:19:09 heisenberg kernel:                 ref#4: tree block backre=
f root 291
Feb 07 17:19:09 heisenberg kernel:                 ref#5: tree block backre=
f root 290
Feb 07 17:19:09 heisenberg kernel:                 ref#6: tree block backre=
f root 289
Feb 07 17:19:09 heisenberg kernel:                 ref#7: tree block backre=
f root 288
Feb 07 17:19:09 heisenberg kernel:                 ref#8: tree block backre=
f root 287
Feb 07 17:19:09 heisenberg kernel:                 ref#9: tree block backre=
f root 286
Feb 07 17:19:09 heisenberg kernel:                 ref#10: tree block backr=
ef root 285
Feb 07 17:19:09 heisenberg kernel:                 ref#11: tree block backr=
ef root 284
Feb 07 17:19:09 heisenberg kernel:         item 134 key (192823296 METADATA=
_ITEM 0) itemoff 10811 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2608 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 2
Feb 07 17:19:09 heisenberg kernel:         item 135 key (192839680 METADATA=
_ITEM 0) itemoff 10679 itemsize 132
Feb 07 17:19:09 heisenberg kernel:                 extent refs 12 gen 2723 =
flags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 295
Feb 07 17:19:09 heisenberg kernel:                 ref#1: tree block backre=
f root 294
Feb 07 17:19:09 heisenberg kernel:                 ref#2: tree block backre=
f root 293
Feb 07 17:19:09 heisenberg kernel:                 ref#3: tree block backre=
f root 292
Feb 07 17:19:09 heisenberg kernel:                 ref#4: tree block backre=
f root 291
Feb 07 17:19:09 heisenberg kernel:                 ref#5: tree block backre=
f root 290
Feb 07 17:19:09 heisenberg kernel:                 ref#6: tree block backre=
f root 289
Feb 07 17:19:09 heisenberg kernel:                 ref#7: tree block backre=
f root 288
Feb 07 17:19:09 heisenberg kernel:                 ref#8: tree block backre=
f root 287
Feb 07 17:19:09 heisenberg kernel:                 ref#9: tree block backre=
f root 286
Feb 07 17:19:09 heisenberg kernel:                 ref#10: tree block backr=
ef root 285
Feb 07 17:19:09 heisenberg kernel:                 ref#11: tree block backr=
ef root 284
Feb 07 17:19:09 heisenberg kernel:         item 136 key (192856064 METADATA=
_ITEM 0) itemoff 10646 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2651 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 280
Feb 07 17:19:09 heisenberg kernel:         item 137 key (192872448 METADATA=
_ITEM 0) itemoff 10613 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2771 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 7
Feb 07 17:19:09 heisenberg kernel:         item 138 key (192888832 METADATA=
_ITEM 0) itemoff 10517 itemsize 96
Feb 07 17:19:09 heisenberg kernel:                 extent refs 8 gen 2688 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 295
Feb 07 17:19:09 heisenberg kernel:                 ref#1: tree block backre=
f root 293
Feb 07 17:19:09 heisenberg kernel:                 ref#2: tree block backre=
f root 292
Feb 07 17:19:09 heisenberg kernel:                 ref#3: tree block backre=
f root 289
Feb 07 17:19:09 heisenberg kernel:                 ref#4: tree block backre=
f root 288
Feb 07 17:19:09 heisenberg kernel:                 ref#5: tree block backre=
f root 287
Feb 07 17:19:09 heisenberg kernel:                 ref#6: tree block backre=
f root 286
Feb 07 17:19:09 heisenberg kernel:                 ref#7: tree block backre=
f root 282
Feb 07 17:19:09 heisenberg kernel:         item 139 key (192905216 METADATA=
_ITEM 0) itemoff 10484 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2608 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 2
Feb 07 17:19:09 heisenberg kernel:         item 140 key (192921600 METADATA=
_ITEM 0) itemoff 10442 itemsize 42
Feb 07 17:19:09 heisenberg kernel:                 extent refs 2 gen 2651 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 281
Feb 07 17:19:09 heisenberg kernel:                 ref#1: tree block backre=
f root 280
Feb 07 17:19:09 heisenberg kernel:         item 141 key (192937984 METADATA=
_ITEM 0) itemoff 10409 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2608 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 2
Feb 07 17:19:09 heisenberg kernel:         item 142 key (192954368 METADATA=
_ITEM 0) itemoff 10376 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2608 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 2
Feb 07 17:19:09 heisenberg kernel:         item 143 key (192970752 METADATA=
_ITEM 0) itemoff 10280 itemsize 96
Feb 07 17:19:09 heisenberg kernel:                 extent refs 8 gen 2688 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 295
Feb 07 17:19:09 heisenberg kernel:                 ref#1: tree block backre=
f root 293
Feb 07 17:19:09 heisenberg kernel:                 ref#2: tree block backre=
f root 292
Feb 07 17:19:09 heisenberg kernel:                 ref#3: tree block backre=
f root 289
Feb 07 17:19:09 heisenberg kernel:                 ref#4: tree block backre=
f root 288
Feb 07 17:19:09 heisenberg kernel:                 ref#5: tree block backre=
f root 287
Feb 07 17:19:09 heisenberg kernel:                 ref#6: tree block backre=
f root 286
Feb 07 17:19:09 heisenberg kernel:                 ref#7: tree block backre=
f root 282
Feb 07 17:19:09 heisenberg kernel:         item 144 key (192987136 METADATA=
_ITEM 0) itemoff 10193 itemsize 87
Feb 07 17:19:09 heisenberg kernel:                 extent refs 7 gen 2669 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 287
Feb 07 17:19:09 heisenberg kernel:                 ref#1: tree block backre=
f root 286
Feb 07 17:19:09 heisenberg kernel:                 ref#2: tree block backre=
f root 285
Feb 07 17:19:09 heisenberg kernel:                 ref#3: tree block backre=
f root 284
Feb 07 17:19:09 heisenberg kernel:                 ref#4: tree block backre=
f root 283
Feb 07 17:19:09 heisenberg kernel:                 ref#5: tree block backre=
f root 282
Feb 07 17:19:09 heisenberg kernel:                 ref#6: tree block backre=
f root 281
Feb 07 17:19:09 heisenberg kernel:         item 145 key (193003520 METADATA=
_ITEM 0) itemoff 10160 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2608 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 278
Feb 07 17:19:09 heisenberg kernel:         item 146 key (193019904 METADATA=
_ITEM 0) itemoff 10127 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2723 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 284
Feb 07 17:19:09 heisenberg kernel:         item 147 key (193036288 METADATA=
_ITEM 0) itemoff 10094 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2723 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 284
Feb 07 17:19:09 heisenberg kernel:         item 148 key (193052672 METADATA=
_ITEM 0) itemoff 10061 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2608 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 2
Feb 07 17:19:09 heisenberg kernel:         item 149 key (193069056 METADATA=
_ITEM 0) itemoff 9965 itemsize 96
Feb 07 17:19:09 heisenberg kernel:                 extent refs 8 gen 2723 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 291
Feb 07 17:19:09 heisenberg kernel:                 ref#1: tree block backre=
f root 290
Feb 07 17:19:09 heisenberg kernel:                 ref#2: tree block backre=
f root 289
Feb 07 17:19:09 heisenberg kernel:                 ref#3: tree block backre=
f root 288
Feb 07 17:19:09 heisenberg kernel:                 ref#4: tree block backre=
f root 287
Feb 07 17:19:09 heisenberg kernel:                 ref#5: tree block backre=
f root 286
Feb 07 17:19:09 heisenberg kernel:                 ref#6: tree block backre=
f root 285
Feb 07 17:19:09 heisenberg kernel:                 ref#7: tree block backre=
f root 284
Feb 07 17:19:09 heisenberg kernel:         item 150 key (193085440 METADATA=
_ITEM 0) itemoff 9932 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2716 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 283
Feb 07 17:19:09 heisenberg kernel:         item 151 key (193101824 METADATA=
_ITEM 0) itemoff 9899 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2716 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 7
Feb 07 17:19:09 heisenberg kernel:         item 152 key (193118208 METADATA=
_ITEM 0) itemoff 9866 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2716 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 283
Feb 07 17:19:09 heisenberg kernel:         item 153 key (193134592 METADATA=
_ITEM 0) itemoff 9824 itemsize 42
Feb 07 17:19:09 heisenberg kernel:                 extent refs 2 gen 2651 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 281
Feb 07 17:19:09 heisenberg kernel:                 ref#1: tree block backre=
f root 280
Feb 07 17:19:09 heisenberg kernel:         item 154 key (193150976 METADATA=
_ITEM 0) itemoff 9791 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2716 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 283
Feb 07 17:19:09 heisenberg kernel:         item 155 key (193167360 METADATA=
_ITEM 0) itemoff 9758 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2771 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 7
Feb 07 17:19:09 heisenberg kernel:         item 156 key (193183744 METADATA=
_ITEM 0) itemoff 9725 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2862 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 291
Feb 07 17:19:09 heisenberg kernel:         item 157 key (193200128 METADATA=
_ITEM 0) itemoff 9692 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2723 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 284
Feb 07 17:19:09 heisenberg kernel:         item 158 key (193216512 METADATA=
_ITEM 0) itemoff 9659 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2716 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 283
Feb 07 17:19:09 heisenberg kernel:         item 159 key (193232896 METADATA=
_ITEM 0) itemoff 9626 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2723 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 284
Feb 07 17:19:09 heisenberg kernel:         item 160 key (193249280 METADATA=
_ITEM 0) itemoff 9593 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2862 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 291
Feb 07 17:19:09 heisenberg kernel:         item 161 key (193265664 METADATA=
_ITEM 0) itemoff 9560 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2768 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 7
Feb 07 17:19:09 heisenberg kernel:         item 162 key (193282048 METADATA=
_ITEM 0) itemoff 9527 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2893 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 294
Feb 07 17:19:09 heisenberg kernel:         item 163 key (193298432 METADATA=
_ITEM 0) itemoff 9494 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2716 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 283
Feb 07 17:19:09 heisenberg kernel:         item 164 key (193314816 METADATA=
_ITEM 0) itemoff 9461 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2669 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 281
Feb 07 17:19:09 heisenberg kernel:         item 165 key (193331200 METADATA=
_ITEM 0) itemoff 9428 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2669 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 281
Feb 07 17:19:09 heisenberg kernel:         item 166 key (193347584 METADATA=
_ITEM 0) itemoff 9395 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2771 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 7
Feb 07 17:19:09 heisenberg kernel:         item 167 key (193363968 METADATA=
_ITEM 0) itemoff 9362 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2716 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 283
Feb 07 17:19:09 heisenberg kernel:         item 168 key (193380352 METADATA=
_ITEM 0) itemoff 9329 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2716 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 283
Feb 07 17:19:09 heisenberg kernel:         item 169 key (193396736 METADATA=
_ITEM 0) itemoff 9296 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2669 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 281
Feb 07 17:19:09 heisenberg kernel:         item 170 key (193413120 METADATA=
_ITEM 0) itemoff 9263 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2772 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 7
Feb 07 17:19:09 heisenberg kernel:         item 171 key (193429504 METADATA=
_ITEM 0) itemoff 9230 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2716 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 283
Feb 07 17:19:09 heisenberg kernel:         item 172 key (193445888 METADATA=
_ITEM 0) itemoff 9197 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2771 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 7
Feb 07 17:19:09 heisenberg kernel:         item 173 key (193462272 METADATA=
_ITEM 0) itemoff 9137 itemsize 60
Feb 07 17:19:09 heisenberg kernel:                 extent refs 4 gen 2669 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 284
Feb 07 17:19:09 heisenberg kernel:                 ref#1: tree block backre=
f root 283
Feb 07 17:19:09 heisenberg kernel:                 ref#2: tree block backre=
f root 282
Feb 07 17:19:09 heisenberg kernel:                 ref#3: tree block backre=
f root 281
Feb 07 17:19:09 heisenberg kernel:         item 174 key (193478656 METADATA=
_ITEM 0) itemoff 9104 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2771 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 7
Feb 07 17:19:09 heisenberg kernel:         item 175 key (193495040 METADATA=
_ITEM 0) itemoff 9071 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2723 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 284
Feb 07 17:19:09 heisenberg kernel:         item 176 key (193511424 METADATA=
_ITEM 0) itemoff 9011 itemsize 60
Feb 07 17:19:09 heisenberg kernel:                 extent refs 4 gen 2669 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 284
Feb 07 17:19:09 heisenberg kernel:                 ref#1: tree block backre=
f root 283
Feb 07 17:19:09 heisenberg kernel:                 ref#2: tree block backre=
f root 282
Feb 07 17:19:09 heisenberg kernel:                 ref#3: tree block backre=
f root 281
Feb 07 17:19:09 heisenberg kernel:         item 177 key (193527808 METADATA=
_ITEM 0) itemoff 8978 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2688 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 282
Feb 07 17:19:09 heisenberg kernel:         item 178 key (193544192 METADATA=
_ITEM 0) itemoff 8945 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2771 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 7
Feb 07 17:19:09 heisenberg kernel:         item 179 key (193560576 METADATA=
_ITEM 0) itemoff 8894 itemsize 51
Feb 07 17:19:09 heisenberg kernel:                 extent refs 3 gen 2669 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 283
Feb 07 17:19:09 heisenberg kernel:                 ref#1: tree block backre=
f root 282
Feb 07 17:19:09 heisenberg kernel:                 ref#2: tree block backre=
f root 281
Feb 07 17:19:09 heisenberg kernel:         item 180 key (193576960 METADATA=
_ITEM 0) itemoff 8861 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2771 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 7
Feb 07 17:19:09 heisenberg kernel:         item 181 key (193593344 METADATA=
_ITEM 0) itemoff 8828 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2771 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 7
Feb 07 17:19:09 heisenberg kernel:         item 182 key (193609728 METADATA=
_ITEM 0) itemoff 8795 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2669 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 281
Feb 07 17:19:09 heisenberg kernel:         item 183 key (193626112 METADATA=
_ITEM 0) itemoff 8762 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2771 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 7
Feb 07 17:19:09 heisenberg kernel:         item 184 key (193642496 METADATA=
_ITEM 0) itemoff 8729 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2716 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 283
Feb 07 17:19:09 heisenberg kernel:         item 185 key (193658880 METADATA=
_ITEM 0) itemoff 8687 itemsize 42
Feb 07 17:19:09 heisenberg kernel:                 extent refs 2 gen 2716 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 284
Feb 07 17:19:09 heisenberg kernel:                 ref#1: tree block backre=
f root 283
Feb 07 17:19:09 heisenberg kernel:         item 186 key (193675264 METADATA=
_ITEM 0) itemoff 8645 itemsize 42
Feb 07 17:19:09 heisenberg kernel:                 extent refs 2 gen 2608 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 279
Feb 07 17:19:09 heisenberg kernel:                 ref#1: tree block backre=
f root 278
Feb 07 17:19:09 heisenberg kernel:         item 187 key (193691648 METADATA=
_ITEM 0) itemoff 8612 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2608 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 278
Feb 07 17:19:09 heisenberg kernel:         item 188 key (193708032 METADATA=
_ITEM 0) itemoff 8579 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2771 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 7
Feb 07 17:19:09 heisenberg kernel:         item 189 key (193724416 METADATA=
_ITEM 0) itemoff 8546 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2771 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 7
Feb 07 17:19:09 heisenberg kernel:         item 190 key (193740800 METADATA=
_ITEM 0) itemoff 8513 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2862 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 291
Feb 07 17:19:09 heisenberg kernel:         item 191 key (193757184 METADATA=
_ITEM 0) itemoff 8480 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2771 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 7
Feb 07 17:19:09 heisenberg kernel:         item 192 key (193773568 METADATA=
_ITEM 0) itemoff 8429 itemsize 51
Feb 07 17:19:09 heisenberg kernel:                 extent refs 3 gen 2738 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 287
Feb 07 17:19:09 heisenberg kernel:                 ref#1: tree block backre=
f root 286
Feb 07 17:19:09 heisenberg kernel:                 ref#2: tree block backre=
f root 285
Feb 07 17:19:09 heisenberg kernel:         item 193 key (193789952 METADATA=
_ITEM 0) itemoff 8396 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2688 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 282
Feb 07 17:19:09 heisenberg kernel:         item 194 key (193806336 METADATA=
_ITEM 0) itemoff 8282 itemsize 114
Feb 07 17:19:09 heisenberg kernel:                 extent refs 10 gen 2608 =
flags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 295
Feb 07 17:19:09 heisenberg kernel:                 ref#1: tree block backre=
f root 293
Feb 07 17:19:09 heisenberg kernel:                 ref#2: tree block backre=
f root 292
Feb 07 17:19:09 heisenberg kernel:                 ref#3: tree block backre=
f root 289
Feb 07 17:19:09 heisenberg kernel:                 ref#4: tree block backre=
f root 288
Feb 07 17:19:09 heisenberg kernel:                 ref#5: tree block backre=
f root 287
Feb 07 17:19:09 heisenberg kernel:                 ref#6: tree block backre=
f root 286
Feb 07 17:19:09 heisenberg kernel:                 ref#7: tree block backre=
f root 282
Feb 07 17:19:09 heisenberg kernel:                 ref#8: tree block backre=
f root 279
Feb 07 17:19:09 heisenberg kernel:                 ref#9: tree block backre=
f root 278
Feb 07 17:19:09 heisenberg kernel:         item 195 key (193822720 METADATA=
_ITEM 0) itemoff 8168 itemsize 114
Feb 07 17:19:09 heisenberg kernel:                 extent refs 10 gen 2608 =
flags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 295
Feb 07 17:19:09 heisenberg kernel:                 ref#1: tree block backre=
f root 293
Feb 07 17:19:09 heisenberg kernel:                 ref#2: tree block backre=
f root 292
Feb 07 17:19:09 heisenberg kernel:                 ref#3: tree block backre=
f root 289
Feb 07 17:19:09 heisenberg kernel:                 ref#4: tree block backre=
f root 288
Feb 07 17:19:09 heisenberg kernel:                 ref#5: tree block backre=
f root 287
Feb 07 17:19:09 heisenberg kernel:                 ref#6: tree block backre=
f root 286
Feb 07 17:19:09 heisenberg kernel:                 ref#7: tree block backre=
f root 282
Feb 07 17:19:09 heisenberg kernel:                 ref#8: tree block backre=
f root 279
Feb 07 17:19:09 heisenberg kernel:                 ref#9: tree block backre=
f root 278
Feb 07 17:19:09 heisenberg kernel:         item 196 key (193839104 METADATA=
_ITEM 0) itemoff 8054 itemsize 114
Feb 07 17:19:09 heisenberg kernel:                 extent refs 10 gen 2608 =
flags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 295
Feb 07 17:19:09 heisenberg kernel:                 ref#1: tree block backre=
f root 293
Feb 07 17:19:09 heisenberg kernel:                 ref#2: tree block backre=
f root 292
Feb 07 17:19:09 heisenberg kernel:                 ref#3: tree block backre=
f root 289
Feb 07 17:19:09 heisenberg kernel:                 ref#4: tree block backre=
f root 288
Feb 07 17:19:09 heisenberg kernel:                 ref#5: tree block backre=
f root 287
Feb 07 17:19:09 heisenberg kernel:                 ref#6: tree block backre=
f root 286
Feb 07 17:19:09 heisenberg kernel:                 ref#7: tree block backre=
f root 282
Feb 07 17:19:09 heisenberg kernel:                 ref#8: tree block backre=
f root 279
Feb 07 17:19:09 heisenberg kernel:                 ref#9: tree block backre=
f root 278
Feb 07 17:19:09 heisenberg kernel:         item 197 key (193855488 METADATA=
_ITEM 0) itemoff 8021 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2669 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 281
Feb 07 17:19:09 heisenberg kernel:         item 198 key (193871872 METADATA=
_ITEM 0) itemoff 7988 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2716 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 283
Feb 07 17:19:09 heisenberg kernel:         item 199 key (193888256 METADATA=
_ITEM 0) itemoff 7847 itemsize 141
Feb 07 17:19:09 heisenberg kernel:                 extent refs 13 gen 2716 =
flags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 295
Feb 07 17:19:09 heisenberg kernel:                 ref#1: tree block backre=
f root 294
Feb 07 17:19:09 heisenberg kernel:                 ref#2: tree block backre=
f root 293
Feb 07 17:19:09 heisenberg kernel:                 ref#3: tree block backre=
f root 292
Feb 07 17:19:09 heisenberg kernel:                 ref#4: tree block backre=
f root 291
Feb 07 17:19:09 heisenberg kernel:                 ref#5: tree block backre=
f root 290
Feb 07 17:19:09 heisenberg kernel:                 ref#6: tree block backre=
f root 289
Feb 07 17:19:09 heisenberg kernel:                 ref#7: tree block backre=
f root 288
Feb 07 17:19:09 heisenberg kernel:                 ref#8: tree block backre=
f root 287
Feb 07 17:19:09 heisenberg kernel:                 ref#9: tree block backre=
f root 286
Feb 07 17:19:09 heisenberg kernel:                 ref#10: tree block backr=
ef root 285
Feb 07 17:19:09 heisenberg kernel:                 ref#11: tree block backr=
ef root 284
Feb 07 17:19:09 heisenberg kernel:                 ref#12: tree block backr=
ef root 283
Feb 07 17:19:09 heisenberg kernel:         item 200 key (193904640 METADATA=
_ITEM 0) itemoff 7814 itemsize 33
Feb 07 17:19:09 heisenberg kernel:                 extent refs 1 gen 2716 f=
lags 2
Feb 07 17:19:09 heisenberg kernel:                 ref#0: tree block backre=
f root 283
Feb 07 17:19:09 heisenberg kernel: BTRFS critical (device dm-2 state EA): u=
nable to find ref byte nr 192380928 parent 0 root 10 owner 1 offset 0 slot =
109
Feb 07 17:19:09 heisenberg kernel: BTRFS error (device dm-2 state EA): fail=
ed to run delayed ref for logical 192380928 num_bytes 16384 type 176 action=
 2 ref_mod 1: -2
Feb 07 17:19:09 heisenberg kernel: BTRFS: error (device dm-2 state EA) in b=
trfs_run_delayed_refs:2161: errno=3D-2 No such entry
Feb 07 17:19:09 heisenberg kernel: BTRFS warning (device dm-2 state EA): fa=
iled to rebuild free space tree: -2
Feb 07 17:19:09 heisenberg kernel: BTRFS error (device dm-2 state EA): comm=
it super ret -30
Feb 07 17:19:09 heisenberg kernel: ------------[ cut here ]------------
Feb 07 17:19:09 heisenberg kernel: WARNING: CPU: 3 PID: 157318 at fs/btrfs/=
block-group.c:172 btrfs_put_block_group+0xe0/0xf0 [btrfs]
Feb 07 17:19:09 heisenberg kernel: Modules linked in: cpuid ext4 mbcache jb=
d2 sg uas nft_fib_ipv6 nft_ct nft_fib_ipv4 nft_fib wireguard libcurve25519 =
libchacha20poly1305 libchacha ip6_udp_tunnel udp_tunnel libpoly1305 cmac cc=
m snd_seq_dummy snd_hrtimer snd_seq snd_ctl_led snd_soc_skl_hda_dsp snd_soc=
_intel_sof_board_helpers snd_sof_probes snd_soc_intel_hda_dsp_common xe snd=
_hda_codec_intelhdmi snd_hda_codec_alc269 snd_hda_scodec_component drm_gpuv=
m snd_hda_codec_realtek_lib drm_gpusvm_helper snd_hda_codec_generic gpu_sch=
ed snd_soc_dmic drm_ttm_helper drm_exec drm_suballoc_helper ip6t_REJECT nf_=
reject_ipv6 ipt_REJECT nf_reject_ipv4 snd_hda_intel xt_tcpudp snd_sof_pci_i=
ntel_tgl xt_conntrack snd_sof_pci_intel_cnl nf_conntrack snd_sof_intel_hda_=
generic nf_defrag_ipv6 soundwire_intel nf_defrag_ipv4 snd_sof_intel_hda_sdw=
_bpt nft_compat nf_tables snd_sof_intel_hda_common intel_uncore_frequency j=
oydev intel_uncore_frequency_common binfmt_misc x_tables snd_soc_hdac_hda x=
86_pkg_temp_thermal snd_sof_intel_hda_mlink intel_powerclamp snd_sof_intel_=
hda
Feb 07 17:19:09 heisenberg kernel:  i915 snd_hda_codec_hdmi soundwire_caden=
ce snd_sof_pci coretemp snd_sof_xtensa_dsp snd_sof kvm_intel snd_sof_utils =
snd_soc_acpi_intel_match snd_soc_acpi_intel_sdca_quirks soundwire_generic_a=
llocation kvm snd_soc_acpi hid_multitouch crc8 soundwire_bus iwlmvm snd_soc=
_sdca snd_soc_avs btusb uvcvideo btmtk irqbypass snd_soc_hda_codec btrtl vi=
deobuf2_vmalloc ghash_clmulni_intel drm_buddy btbcm snd_hda_ext_core uvc hi=
d_generic snd_hda_codec btintel iTCO_wdt rapl videobuf2_memops ttm sdhci_pc=
i snd_usb_audio intel_pmc_bxt processor_thermal_device_pci mac80211 intel_r=
apl_msr videobuf2_v4l2 snd_hda_core sdhci_uhs2 drm_display_helper bluetooth=
 intel_cstate iTCO_vendor_support snd_usbmidi_lib videodev processor_therma=
l_device sdhci snd_intel_dspcfg processor_thermal_wt_hint platform_temperat=
ure_control snd_rawmidi cec videobuf2_common snd_intel_sdw_acpi cqhci proce=
ssor_thermal_soc_slider snd_seq_device snd_hwdep mei_hdcp watchdog mei_pxp =
ee1004 wmi_bmof usbhid mc ecdh_generic libarc4 intel_uncore crc16 intel_pmc=
_core
Feb 07 17:19:09 heisenberg kernel:  mmc_core snd_soc_core rc_core platform_=
profile pmt_telemetry snd_compress ucsi_acpi processor_thermal_rfim drm_cli=
ent_lib snd_pcm_dmaengine processor_thermal_rapl typec_ucsi iwlwifi pmt_dis=
covery drm_kms_helper snd_pcm i2c_hid_acpi intel_rapl_common typec pmt_clas=
s i2c_hid i2c_algo_bit int3400_thermal hid roles fujitsu_laptop intel_pmc_s=
sram_telemetry acpi_thermal_rel acpi_pad acpi_tad cfg80211 battery button v=
ideo processor_thermal_wt_req i2c_i801 snd_timer processor_thermal_power_fl=
oor i2c_smbus mei_me snd intel_lpss_pci processor_thermal_mbox soundcore in=
tel_lpss mei rfkill wmi idma64 intel_vsec ac int340x_thermal_zone igen6_eda=
c parport_pc lp ppdev drm parport efi_pstore configfs nfnetlink autofs4 crc=
32c_cryptoapi sd_mod dm_crypt dm_mod raid10 raid456 async_raid6_recov async=
_memcpy async_pq async_xor async_tx raid1 raid0 md_mod usb_storage scsi_mod=
 scsi_common btrfs blake2b_generic xor raid6_pq xhci_pci xhci_hcd nvme thun=
derbolt nvme_core usbcore e1000e evdev nvme_keyring nvme_auth serio_raw int=
el_hid
Feb 07 17:19:09 heisenberg kernel:  fan pcspkr aesni_intel usb_common hkdf =
sparse_keymap efivarfs
Feb 07 17:19:09 heisenberg kernel: CPU: 3 UID: 0 PID: 157318 Comm: mount Ta=
inted: G        W           6.18.8+deb14-amd64 #1 PREEMPT(lazy)  Debian 6.1=
8.8-1=20
Feb 07 17:19:09 heisenberg kernel: Tainted: [W]=3DWARN
Feb 07 17:19:09 heisenberg kernel: Hardware name: FUJITSU CLIENT COMPUTING =
LIMITED LIFEBOOK U7512/FJNB2F4, BIOS Version 2.35 07/01/2025
Feb 07 17:19:09 heisenberg kernel: RIP: 0010:btrfs_put_block_group+0xe0/0xf=
0 [btrfs]
Feb 07 17:19:09 heisenberg kernel: Code: b6 28 74 eb 0f 0b 48 8b 03 48 89 d=
e 48 8d b8 a8 08 00 00 e8 82 79 00 00 eb 88 be 03 00 00 00 48 83 c7 1c e8 9=
2 28 74 eb eb a3 <0f> 0b e9 5e ff ff ff 66 0f 1f 84 00 00 00 00 00 90 90 90=
 90 90 90
Feb 07 17:19:09 heisenberg kernel: RSP: 0018:ffffd1b2e7103c28 EFLAGS: 00010=
206
Feb 07 17:19:09 heisenberg kernel: RAX: 0000000000000204 RBX: ffff8dddde624=
400 RCX: 0000000000000000
Feb 07 17:19:09 heisenberg kernel: RDX: ffff8dd2101b8000 RSI: 0000000008000=
000 RDI: ffff8dddde624400
Feb 07 17:19:09 heisenberg kernel: RBP: ffff8dddde624400 R08: ffff8ddd3adad=
820 R09: 000000000027000d
Feb 07 17:19:09 heisenberg kernel: R10: ffff8dda4f6f7500 R11: 0000000000008=
000 R12: ffff8dd2101b8090
Feb 07 17:19:09 heisenberg kernel: R13: ffff8dd2101b8098 R14: ffff8dddde624=
4d8 R15: dead000000000100
Feb 07 17:19:09 heisenberg kernel: FS:  00007f3b3256b840(0000) GS:ffff8de10=
108c000(0000) knlGS:0000000000000000
Feb 07 17:19:09 heisenberg kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000=
080050033
Feb 07 17:19:09 heisenberg kernel: CR2: 00007fb628a2bff0 CR3: 0000000824a1b=
006 CR4: 0000000000f72ef0
Feb 07 17:19:09 heisenberg kernel: PKRU: 55555554
Feb 07 17:19:09 heisenberg kernel: Call Trace:
Feb 07 17:19:09 heisenberg kernel:  <TASK>
Feb 07 17:19:09 heisenberg kernel:  btrfs_free_block_groups+0x24d/0x3d0 [bt=
rfs]
Feb 07 17:19:09 heisenberg kernel:  close_ctree+0x457/0x490 [btrfs]
Feb 07 17:19:09 heisenberg kernel:  ? btrfs_get_root_ref+0x2a7/0x3b0 [btrfs=
]
Feb 07 17:19:09 heisenberg kernel:  open_ctree+0x12d6/0x15a0 [btrfs]
Feb 07 17:19:09 heisenberg kernel:  btrfs_get_tree.cold+0xb/0xb6 [btrfs]
Feb 07 17:19:09 heisenberg kernel:  ? btrfs_parse_param+0x4f/0x920 [btrfs]
Feb 07 17:19:09 heisenberg kernel:  ? strndup_user+0x4f/0x70
Feb 07 17:19:09 heisenberg kernel:  vfs_get_tree+0x29/0xd0
Feb 07 17:19:09 heisenberg kernel:  vfs_cmd_create+0x57/0xd0
Feb 07 17:19:09 heisenberg kernel:  __do_sys_fsconfig+0x4b6/0x650
Feb 07 17:19:09 heisenberg kernel:  do_syscall_64+0x81/0x7f0
Feb 07 17:19:09 heisenberg kernel:  ? do_syscall_64+0xb9/0x7f0
Feb 07 17:19:09 heisenberg kernel:  ? from_kuid_munged+0x13/0x30
Feb 07 17:19:09 heisenberg kernel:  ? __do_sys_geteuid+0x27/0x30
Feb 07 17:19:09 heisenberg kernel:  ? do_syscall_64+0xb9/0x7f0
Feb 07 17:19:09 heisenberg kernel:  ? exc_page_fault+0x7e/0x1a0
Feb 07 17:19:09 heisenberg kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7=
e
Feb 07 17:19:09 heisenberg kernel: RIP: 0033:0x7f3b32794a6a
Feb 07 17:19:09 heisenberg kernel: Code: 73 01 c3 48 8b 0d a6 23 0d 00 f7 d=
8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 a=
f 01 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 76 23 0d 00 f7 d8 64=
 89 01 48
Feb 07 17:19:09 heisenberg kernel: RSP: 002b:00007ffc7f7d62c8 EFLAGS: 00000=
246 ORIG_RAX: 00000000000001af
Feb 07 17:19:09 heisenberg kernel: RAX: ffffffffffffffda RBX: 000055687071f=
b80 RCX: 00007f3b32794a6a
Feb 07 17:19:09 heisenberg kernel: RDX: 0000000000000000 RSI: 0000000000000=
006 RDI: 0000000000000003
Feb 07 17:19:09 heisenberg kernel: RBP: 0000000000000000 R08: 0000000000000=
000 R09: 0000000000000000
Feb 07 17:19:09 heisenberg kernel: R10: 0000000000000000 R11: 0000000000000=
246 R12: 0000556870720120
Feb 07 17:19:09 heisenberg kernel: R13: 00007f3b3292226c R14: 00007f3b32920=
560 R15: 00007f3b3292226c
Feb 07 17:19:09 heisenberg kernel:  </TASK>
Feb 07 17:19:09 heisenberg kernel: ---[ end trace 0000000000000000 ]---
Feb 07 17:19:09 heisenberg kernel: ------------[ cut here ]------------
Feb 07 17:19:09 heisenberg kernel: WARNING: CPU: 3 PID: 157318 at fs/btrfs/=
block-rsv.c:465 btrfs_release_global_block_rsv+0xc8/0xd0 [btrfs]
Feb 07 17:19:09 heisenberg kernel: Modules linked in: cpuid ext4 mbcache jb=
d2 sg uas nft_fib_ipv6 nft_ct nft_fib_ipv4 nft_fib wireguard libcurve25519 =
libchacha20poly1305 libchacha ip6_udp_tunnel udp_tunnel libpoly1305 cmac cc=
m snd_seq_dummy snd_hrtimer snd_seq snd_ctl_led snd_soc_skl_hda_dsp snd_soc=
_intel_sof_board_helpers snd_sof_probes snd_soc_intel_hda_dsp_common xe snd=
_hda_codec_intelhdmi snd_hda_codec_alc269 snd_hda_scodec_component drm_gpuv=
m snd_hda_codec_realtek_lib drm_gpusvm_helper snd_hda_codec_generic gpu_sch=
ed snd_soc_dmic drm_ttm_helper drm_exec drm_suballoc_helper ip6t_REJECT nf_=
reject_ipv6 ipt_REJECT nf_reject_ipv4 snd_hda_intel xt_tcpudp snd_sof_pci_i=
ntel_tgl xt_conntrack snd_sof_pci_intel_cnl nf_conntrack snd_sof_intel_hda_=
generic nf_defrag_ipv6 soundwire_intel nf_defrag_ipv4 snd_sof_intel_hda_sdw=
_bpt nft_compat nf_tables snd_sof_intel_hda_common intel_uncore_frequency j=
oydev intel_uncore_frequency_common binfmt_misc x_tables snd_soc_hdac_hda x=
86_pkg_temp_thermal snd_sof_intel_hda_mlink intel_powerclamp snd_sof_intel_=
hda
Feb 07 17:19:09 heisenberg kernel:  i915 snd_hda_codec_hdmi soundwire_caden=
ce snd_sof_pci coretemp snd_sof_xtensa_dsp snd_sof kvm_intel snd_sof_utils =
snd_soc_acpi_intel_match snd_soc_acpi_intel_sdca_quirks soundwire_generic_a=
llocation kvm snd_soc_acpi hid_multitouch crc8 soundwire_bus iwlmvm snd_soc=
_sdca snd_soc_avs btusb uvcvideo btmtk irqbypass snd_soc_hda_codec btrtl vi=
deobuf2_vmalloc ghash_clmulni_intel drm_buddy btbcm snd_hda_ext_core uvc hi=
d_generic snd_hda_codec btintel iTCO_wdt rapl videobuf2_memops ttm sdhci_pc=
i snd_usb_audio intel_pmc_bxt processor_thermal_device_pci mac80211 intel_r=
apl_msr videobuf2_v4l2 snd_hda_core sdhci_uhs2 drm_display_helper bluetooth=
 intel_cstate iTCO_vendor_support snd_usbmidi_lib videodev processor_therma=
l_device sdhci snd_intel_dspcfg processor_thermal_wt_hint platform_temperat=
ure_control snd_rawmidi cec videobuf2_common snd_intel_sdw_acpi cqhci proce=
ssor_thermal_soc_slider snd_seq_device snd_hwdep mei_hdcp watchdog mei_pxp =
ee1004 wmi_bmof usbhid mc ecdh_generic libarc4 intel_uncore crc16 intel_pmc=
_core
Feb 07 17:19:09 heisenberg kernel:  mmc_core snd_soc_core rc_core platform_=
profile pmt_telemetry snd_compress ucsi_acpi processor_thermal_rfim drm_cli=
ent_lib snd_pcm_dmaengine processor_thermal_rapl typec_ucsi iwlwifi pmt_dis=
covery drm_kms_helper snd_pcm i2c_hid_acpi intel_rapl_common typec pmt_clas=
s i2c_hid i2c_algo_bit int3400_thermal hid roles fujitsu_laptop intel_pmc_s=
sram_telemetry acpi_thermal_rel acpi_pad acpi_tad cfg80211 battery button v=
ideo processor_thermal_wt_req i2c_i801 snd_timer processor_thermal_power_fl=
oor i2c_smbus mei_me snd intel_lpss_pci processor_thermal_mbox soundcore in=
tel_lpss mei rfkill wmi idma64 intel_vsec ac int340x_thermal_zone igen6_eda=
c parport_pc lp ppdev drm parport efi_pstore configfs nfnetlink autofs4 crc=
32c_cryptoapi sd_mod dm_crypt dm_mod raid10 raid456 async_raid6_recov async=
_memcpy async_pq async_xor async_tx raid1 raid0 md_mod usb_storage scsi_mod=
 scsi_common btrfs blake2b_generic xor raid6_pq xhci_pci xhci_hcd nvme thun=
derbolt nvme_core usbcore e1000e evdev nvme_keyring nvme_auth serio_raw int=
el_hid
Feb 07 17:19:09 heisenberg kernel:  fan pcspkr aesni_intel usb_common hkdf =
sparse_keymap efivarfs
Feb 07 17:19:09 heisenberg kernel: CPU: 3 UID: 0 PID: 157318 Comm: mount Ta=
inted: G        W           6.18.8+deb14-amd64 #1 PREEMPT(lazy)  Debian 6.1=
8.8-1=20
Feb 07 17:19:09 heisenberg kernel: Tainted: [W]=3DWARN
Feb 07 17:19:09 heisenberg kernel: Hardware name: FUJITSU CLIENT COMPUTING =
LIMITED LIFEBOOK U7512/FJNB2F4, BIOS Version 2.35 07/01/2025
Feb 07 17:19:09 heisenberg kernel: RIP: 0010:btrfs_release_global_block_rsv=
+0xc8/0xd0 [btrfs]
Feb 07 17:19:09 heisenberg kernel: Code: 01 00 00 00 74 a6 0f 0b 48 83 bb 7=
0 01 00 00 00 74 a4 0f 0b 48 83 bb 78 01 00 00 00 74 a2 0f 0b 48 83 bb a8 0=
1 00 00 00 74 a0 <0f> 0b eb 9c 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90=
 90 90 90
Feb 07 17:19:09 heisenberg kernel: RSP: 0018:ffffd1b2e7103c28 EFLAGS: 00010=
206
Feb 07 17:19:09 heisenberg kernel: RAX: 000000001ffc8000 RBX: ffff8dd2101b8=
000 RCX: 0000000020000000
Feb 07 17:19:09 heisenberg kernel: RDX: 000000001ffc8000 RSI: ffff8ddc1cbe4=
000 RDI: ffff8ddc1cbe401c
Feb 07 17:19:09 heisenberg kernel: RBP: ffff8dddde624000 R08: ffff8dddde624=
000 R09: 0000000000200006
Feb 07 17:19:09 heisenberg kernel: R10: 00000000003d0000 R11: ffff8ddc1cbe4=
000 R12: ffff8dd2101b8090
Feb 07 17:19:09 heisenberg kernel: R13: ffff8dd2101b8718 R14: 0000000000000=
000 R15: dead000000000100
Feb 07 17:19:09 heisenberg kernel: FS:  00007f3b3256b840(0000) GS:ffff8de10=
108c000(0000) knlGS:0000000000000000
Feb 07 17:19:09 heisenberg kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000=
080050033
Feb 07 17:19:09 heisenberg kernel: CR2: 00007fb628a2bff0 CR3: 0000000824a1b=
006 CR4: 0000000000f72ef0
Feb 07 17:19:09 heisenberg kernel: PKRU: 55555554
Feb 07 17:19:09 heisenberg kernel: Call Trace:
Feb 07 17:19:09 heisenberg kernel:  <TASK>
Feb 07 17:19:09 heisenberg kernel:  btrfs_free_block_groups+0x34a/0x3d0 [bt=
rfs]
Feb 07 17:19:09 heisenberg kernel:  close_ctree+0x457/0x490 [btrfs]
Feb 07 17:19:09 heisenberg kernel:  ? btrfs_get_root_ref+0x2a7/0x3b0 [btrfs=
]
Feb 07 17:19:09 heisenberg kernel:  open_ctree+0x12d6/0x15a0 [btrfs]
Feb 07 17:19:09 heisenberg kernel:  btrfs_get_tree.cold+0xb/0xb6 [btrfs]
Feb 07 17:19:09 heisenberg kernel:  ? btrfs_parse_param+0x4f/0x920 [btrfs]
Feb 07 17:19:09 heisenberg kernel:  ? strndup_user+0x4f/0x70
Feb 07 17:19:09 heisenberg kernel:  vfs_get_tree+0x29/0xd0
Feb 07 17:19:09 heisenberg kernel:  vfs_cmd_create+0x57/0xd0
Feb 07 17:19:09 heisenberg kernel:  __do_sys_fsconfig+0x4b6/0x650
Feb 07 17:19:09 heisenberg kernel:  do_syscall_64+0x81/0x7f0
Feb 07 17:19:09 heisenberg kernel:  ? do_syscall_64+0xb9/0x7f0
Feb 07 17:19:09 heisenberg kernel:  ? from_kuid_munged+0x13/0x30
Feb 07 17:19:09 heisenberg kernel:  ? __do_sys_geteuid+0x27/0x30
Feb 07 17:19:09 heisenberg kernel:  ? do_syscall_64+0xb9/0x7f0
Feb 07 17:19:09 heisenberg kernel:  ? exc_page_fault+0x7e/0x1a0
Feb 07 17:19:09 heisenberg kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7=
e
Feb 07 17:19:09 heisenberg kernel: RIP: 0033:0x7f3b32794a6a
Feb 07 17:19:09 heisenberg kernel: Code: 73 01 c3 48 8b 0d a6 23 0d 00 f7 d=
8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 a=
f 01 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 76 23 0d 00 f7 d8 64=
 89 01 48
Feb 07 17:19:09 heisenberg kernel: RSP: 002b:00007ffc7f7d62c8 EFLAGS: 00000=
246 ORIG_RAX: 00000000000001af
Feb 07 17:19:09 heisenberg kernel: RAX: ffffffffffffffda RBX: 000055687071f=
b80 RCX: 00007f3b32794a6a
Feb 07 17:19:09 heisenberg kernel: RDX: 0000000000000000 RSI: 0000000000000=
006 RDI: 0000000000000003
Feb 07 17:19:09 heisenberg kernel: RBP: 0000000000000000 R08: 0000000000000=
000 R09: 0000000000000000
Feb 07 17:19:09 heisenberg kernel: R10: 0000000000000000 R11: 0000000000000=
246 R12: 0000556870720120
Feb 07 17:19:09 heisenberg kernel: R13: 00007f3b3292226c R14: 00007f3b32920=
560 R15: 00007f3b3292226c
Feb 07 17:19:09 heisenberg kernel:  </TASK>
Feb 07 17:19:09 heisenberg kernel: ---[ end trace 0000000000000000 ]---
Feb 07 17:19:09 heisenberg kernel: ------------[ cut here ]------------
Feb 07 17:19:09 heisenberg kernel: WARNING: CPU: 3 PID: 157318 at fs/btrfs/=
block-rsv.c:466 btrfs_release_global_block_rsv+0x78/0xd0 [btrfs]
Feb 07 17:19:09 heisenberg kernel: Modules linked in: cpuid ext4 mbcache jb=
d2 sg uas nft_fib_ipv6 nft_ct nft_fib_ipv4 nft_fib wireguard libcurve25519 =
libchacha20poly1305 libchacha ip6_udp_tunnel udp_tunnel libpoly1305 cmac cc=
m snd_seq_dummy snd_hrtimer snd_seq snd_ctl_led snd_soc_skl_hda_dsp snd_soc=
_intel_sof_board_helpers snd_sof_probes snd_soc_intel_hda_dsp_common xe snd=
_hda_codec_intelhdmi snd_hda_codec_alc269 snd_hda_scodec_component drm_gpuv=
m snd_hda_codec_realtek_lib drm_gpusvm_helper snd_hda_codec_generic gpu_sch=
ed snd_soc_dmic drm_ttm_helper drm_exec drm_suballoc_helper ip6t_REJECT nf_=
reject_ipv6 ipt_REJECT nf_reject_ipv4 snd_hda_intel xt_tcpudp snd_sof_pci_i=
ntel_tgl xt_conntrack snd_sof_pci_intel_cnl nf_conntrack snd_sof_intel_hda_=
generic nf_defrag_ipv6 soundwire_intel nf_defrag_ipv4 snd_sof_intel_hda_sdw=
_bpt nft_compat nf_tables snd_sof_intel_hda_common intel_uncore_frequency j=
oydev intel_uncore_frequency_common binfmt_misc x_tables snd_soc_hdac_hda x=
86_pkg_temp_thermal snd_sof_intel_hda_mlink intel_powerclamp snd_sof_intel_=
hda
Feb 07 17:19:09 heisenberg kernel:  i915 snd_hda_codec_hdmi soundwire_caden=
ce snd_sof_pci coretemp snd_sof_xtensa_dsp snd_sof kvm_intel snd_sof_utils =
snd_soc_acpi_intel_match snd_soc_acpi_intel_sdca_quirks soundwire_generic_a=
llocation kvm snd_soc_acpi hid_multitouch crc8 soundwire_bus iwlmvm snd_soc=
_sdca snd_soc_avs btusb uvcvideo btmtk irqbypass snd_soc_hda_codec btrtl vi=
deobuf2_vmalloc ghash_clmulni_intel drm_buddy btbcm snd_hda_ext_core uvc hi=
d_generic snd_hda_codec btintel iTCO_wdt rapl videobuf2_memops ttm sdhci_pc=
i snd_usb_audio intel_pmc_bxt processor_thermal_device_pci mac80211 intel_r=
apl_msr videobuf2_v4l2 snd_hda_core sdhci_uhs2 drm_display_helper bluetooth=
 intel_cstate iTCO_vendor_support snd_usbmidi_lib videodev processor_therma=
l_device sdhci snd_intel_dspcfg processor_thermal_wt_hint platform_temperat=
ure_control snd_rawmidi cec videobuf2_common snd_intel_sdw_acpi cqhci proce=
ssor_thermal_soc_slider snd_seq_device snd_hwdep mei_hdcp watchdog mei_pxp =
ee1004 wmi_bmof usbhid mc ecdh_generic libarc4 intel_uncore crc16 intel_pmc=
_core
Feb 07 17:19:09 heisenberg kernel:  mmc_core snd_soc_core rc_core platform_=
profile pmt_telemetry snd_compress ucsi_acpi processor_thermal_rfim drm_cli=
ent_lib snd_pcm_dmaengine processor_thermal_rapl typec_ucsi iwlwifi pmt_dis=
covery drm_kms_helper snd_pcm i2c_hid_acpi intel_rapl_common typec pmt_clas=
s i2c_hid i2c_algo_bit int3400_thermal hid roles fujitsu_laptop intel_pmc_s=
sram_telemetry acpi_thermal_rel acpi_pad acpi_tad cfg80211 battery button v=
ideo processor_thermal_wt_req i2c_i801 snd_timer processor_thermal_power_fl=
oor i2c_smbus mei_me snd intel_lpss_pci processor_thermal_mbox soundcore in=
tel_lpss mei rfkill wmi idma64 intel_vsec ac int340x_thermal_zone igen6_eda=
c parport_pc lp ppdev drm parport efi_pstore configfs nfnetlink autofs4 crc=
32c_cryptoapi sd_mod dm_crypt dm_mod raid10 raid456 async_raid6_recov async=
_memcpy async_pq async_xor async_tx raid1 raid0 md_mod usb_storage scsi_mod=
 scsi_common btrfs blake2b_generic xor raid6_pq xhci_pci xhci_hcd nvme thun=
derbolt nvme_core usbcore e1000e evdev nvme_keyring nvme_auth serio_raw int=
el_hid
Feb 07 17:19:09 heisenberg kernel:  fan pcspkr aesni_intel usb_common hkdf =
sparse_keymap efivarfs
Feb 07 17:19:09 heisenberg kernel: CPU: 3 UID: 0 PID: 157318 Comm: mount Ta=
inted: G        W           6.18.8+deb14-amd64 #1 PREEMPT(lazy)  Debian 6.1=
8.8-1=20
Feb 07 17:19:09 heisenberg kernel: Tainted: [W]=3DWARN
Feb 07 17:19:09 heisenberg kernel: Hardware name: FUJITSU CLIENT COMPUTING =
LIMITED LIFEBOOK U7512/FJNB2F4, BIOS Version 2.35 07/01/2025
Feb 07 17:19:09 heisenberg kernel: RIP: 0010:btrfs_release_global_block_rsv=
+0x78/0xd0 [btrfs]
Feb 07 17:19:09 heisenberg kernel: Code: 01 00 00 00 75 5c 48 83 bb 78 01 0=
0 00 00 75 5e 48 83 bb a8 01 00 00 00 75 60 48 83 bb a0 01 00 00 00 75 06 5=
b c3 cc cc cc cc <0f> 0b 5b c3 cc cc cc cc 0f 0b 48 83 bb 18 01 00 00 00 74=
 aa 0f 0b
Feb 07 17:19:09 heisenberg kernel: RSP: 0018:ffffd1b2e7103c28 EFLAGS: 00010=
206
Feb 07 17:19:09 heisenberg kernel: RAX: 000000001ffc8000 RBX: ffff8dd2101b8=
000 RCX: 0000000020000000
Feb 07 17:19:09 heisenberg kernel: RDX: 000000001ffc8000 RSI: ffff8ddc1cbe4=
000 RDI: ffff8ddc1cbe401c
Feb 07 17:19:09 heisenberg kernel: RBP: ffff8dddde624000 R08: ffff8dddde624=
000 R09: 0000000000200006
Feb 07 17:19:09 heisenberg kernel: R10: 00000000003d0000 R11: ffff8ddc1cbe4=
000 R12: ffff8dd2101b8090
Feb 07 17:19:09 heisenberg kernel: R13: ffff8dd2101b8718 R14: 0000000000000=
000 R15: dead000000000100
Feb 07 17:19:09 heisenberg kernel: FS:  00007f3b3256b840(0000) GS:ffff8de10=
108c000(0000) knlGS:0000000000000000
Feb 07 17:19:09 heisenberg kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000=
080050033
Feb 07 17:19:09 heisenberg kernel: CR2: 00007fb628a2bff0 CR3: 0000000824a1b=
006 CR4: 0000000000f72ef0
Feb 07 17:19:09 heisenberg kernel: PKRU: 55555554
Feb 07 17:19:09 heisenberg kernel: Call Trace:
Feb 07 17:19:09 heisenberg kernel:  <TASK>
Feb 07 17:19:09 heisenberg kernel:  btrfs_free_block_groups+0x34a/0x3d0 [bt=
rfs]
Feb 07 17:19:09 heisenberg kernel:  close_ctree+0x457/0x490 [btrfs]
Feb 07 17:19:09 heisenberg kernel:  ? btrfs_get_root_ref+0x2a7/0x3b0 [btrfs=
]
Feb 07 17:19:09 heisenberg kernel:  open_ctree+0x12d6/0x15a0 [btrfs]
Feb 07 17:19:09 heisenberg kernel:  btrfs_get_tree.cold+0xb/0xb6 [btrfs]
Feb 07 17:19:09 heisenberg kernel:  ? btrfs_parse_param+0x4f/0x920 [btrfs]
Feb 07 17:19:09 heisenberg kernel:  ? strndup_user+0x4f/0x70
Feb 07 17:19:09 heisenberg kernel:  vfs_get_tree+0x29/0xd0
Feb 07 17:19:09 heisenberg kernel:  vfs_cmd_create+0x57/0xd0
Feb 07 17:19:09 heisenberg kernel:  __do_sys_fsconfig+0x4b6/0x650
Feb 07 17:19:09 heisenberg kernel:  do_syscall_64+0x81/0x7f0
Feb 07 17:19:09 heisenberg kernel:  ? do_syscall_64+0xb9/0x7f0
Feb 07 17:19:09 heisenberg kernel:  ? from_kuid_munged+0x13/0x30
Feb 07 17:19:09 heisenberg kernel:  ? __do_sys_geteuid+0x27/0x30
Feb 07 17:19:09 heisenberg kernel:  ? do_syscall_64+0xb9/0x7f0
Feb 07 17:19:09 heisenberg kernel:  ? exc_page_fault+0x7e/0x1a0
Feb 07 17:19:09 heisenberg kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7=
e
Feb 07 17:19:09 heisenberg kernel: RIP: 0033:0x7f3b32794a6a
Feb 07 17:19:09 heisenberg kernel: Code: 73 01 c3 48 8b 0d a6 23 0d 00 f7 d=
8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 a=
f 01 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 76 23 0d 00 f7 d8 64=
 89 01 48
Feb 07 17:19:09 heisenberg kernel: RSP: 002b:00007ffc7f7d62c8 EFLAGS: 00000=
246 ORIG_RAX: 00000000000001af
Feb 07 17:19:09 heisenberg kernel: RAX: ffffffffffffffda RBX: 000055687071f=
b80 RCX: 00007f3b32794a6a
Feb 07 17:19:09 heisenberg kernel: RDX: 0000000000000000 RSI: 0000000000000=
006 RDI: 0000000000000003
Feb 07 17:19:09 heisenberg kernel: RBP: 0000000000000000 R08: 0000000000000=
000 R09: 0000000000000000
Feb 07 17:19:09 heisenberg kernel: R10: 0000000000000000 R11: 0000000000000=
246 R12: 0000556870720120
Feb 07 17:19:09 heisenberg kernel: R13: 00007f3b3292226c R14: 00007f3b32920=
560 R15: 00007f3b3292226c
Feb 07 17:19:09 heisenberg kernel:  </TASK>
Feb 07 17:19:09 heisenberg kernel: ---[ end trace 0000000000000000 ]---
Feb 07 17:19:09 heisenberg kernel: ------------[ cut here ]------------
Feb 07 17:19:09 heisenberg kernel: WARNING: CPU: 3 PID: 157318 at fs/btrfs/=
block-group.c:4462 check_removing_space_info+0x6e/0xa0 [btrfs]
Feb 07 17:19:09 heisenberg kernel: Modules linked in: cpuid ext4 mbcache jb=
d2 sg uas nft_fib_ipv6 nft_ct nft_fib_ipv4 nft_fib wireguard libcurve25519 =
libchacha20poly1305 libchacha ip6_udp_tunnel udp_tunnel libpoly1305 cmac cc=
m snd_seq_dummy snd_hrtimer snd_seq snd_ctl_led snd_soc_skl_hda_dsp snd_soc=
_intel_sof_board_helpers snd_sof_probes snd_soc_intel_hda_dsp_common xe snd=
_hda_codec_intelhdmi snd_hda_codec_alc269 snd_hda_scodec_component drm_gpuv=
m snd_hda_codec_realtek_lib drm_gpusvm_helper snd_hda_codec_generic gpu_sch=
ed snd_soc_dmic drm_ttm_helper drm_exec drm_suballoc_helper ip6t_REJECT nf_=
reject_ipv6 ipt_REJECT nf_reject_ipv4 snd_hda_intel xt_tcpudp snd_sof_pci_i=
ntel_tgl xt_conntrack snd_sof_pci_intel_cnl nf_conntrack snd_sof_intel_hda_=
generic nf_defrag_ipv6 soundwire_intel nf_defrag_ipv4 snd_sof_intel_hda_sdw=
_bpt nft_compat nf_tables snd_sof_intel_hda_common intel_uncore_frequency j=
oydev intel_uncore_frequency_common binfmt_misc x_tables snd_soc_hdac_hda x=
86_pkg_temp_thermal snd_sof_intel_hda_mlink intel_powerclamp snd_sof_intel_=
hda
Feb 07 17:19:09 heisenberg kernel:  i915 snd_hda_codec_hdmi soundwire_caden=
ce snd_sof_pci coretemp snd_sof_xtensa_dsp snd_sof kvm_intel snd_sof_utils =
snd_soc_acpi_intel_match snd_soc_acpi_intel_sdca_quirks soundwire_generic_a=
llocation kvm snd_soc_acpi hid_multitouch crc8 soundwire_bus iwlmvm snd_soc=
_sdca snd_soc_avs btusb uvcvideo btmtk irqbypass snd_soc_hda_codec btrtl vi=
deobuf2_vmalloc ghash_clmulni_intel drm_buddy btbcm snd_hda_ext_core uvc hi=
d_generic snd_hda_codec btintel iTCO_wdt rapl videobuf2_memops ttm sdhci_pc=
i snd_usb_audio intel_pmc_bxt processor_thermal_device_pci mac80211 intel_r=
apl_msr videobuf2_v4l2 snd_hda_core sdhci_uhs2 drm_display_helper bluetooth=
 intel_cstate iTCO_vendor_support snd_usbmidi_lib videodev processor_therma=
l_device sdhci snd_intel_dspcfg processor_thermal_wt_hint platform_temperat=
ure_control snd_rawmidi cec videobuf2_common snd_intel_sdw_acpi cqhci proce=
ssor_thermal_soc_slider snd_seq_device snd_hwdep mei_hdcp watchdog mei_pxp =
ee1004 wmi_bmof usbhid mc ecdh_generic libarc4 intel_uncore crc16 intel_pmc=
_core
Feb 07 17:19:09 heisenberg kernel:  mmc_core snd_soc_core rc_core platform_=
profile pmt_telemetry snd_compress ucsi_acpi processor_thermal_rfim drm_cli=
ent_lib snd_pcm_dmaengine processor_thermal_rapl typec_ucsi iwlwifi pmt_dis=
covery drm_kms_helper snd_pcm i2c_hid_acpi intel_rapl_common typec pmt_clas=
s i2c_hid i2c_algo_bit int3400_thermal hid roles fujitsu_laptop intel_pmc_s=
sram_telemetry acpi_thermal_rel acpi_pad acpi_tad cfg80211 battery button v=
ideo processor_thermal_wt_req i2c_i801 snd_timer processor_thermal_power_fl=
oor i2c_smbus mei_me snd intel_lpss_pci processor_thermal_mbox soundcore in=
tel_lpss mei rfkill wmi idma64 intel_vsec ac int340x_thermal_zone igen6_eda=
c parport_pc lp ppdev drm parport efi_pstore configfs nfnetlink autofs4 crc=
32c_cryptoapi sd_mod dm_crypt dm_mod raid10 raid456 async_raid6_recov async=
_memcpy async_pq async_xor async_tx raid1 raid0 md_mod usb_storage scsi_mod=
 scsi_common btrfs blake2b_generic xor raid6_pq xhci_pci xhci_hcd nvme thun=
derbolt nvme_core usbcore e1000e evdev nvme_keyring nvme_auth serio_raw int=
el_hid
Feb 07 17:19:09 heisenberg kernel:  fan pcspkr aesni_intel usb_common hkdf =
sparse_keymap efivarfs
Feb 07 17:19:09 heisenberg kernel: CPU: 3 UID: 0 PID: 157318 Comm: mount Ta=
inted: G        W           6.18.8+deb14-amd64 #1 PREEMPT(lazy)  Debian 6.1=
8.8-1=20
Feb 07 17:19:09 heisenberg kernel: Tainted: [W]=3DWARN
Feb 07 17:19:09 heisenberg kernel: Hardware name: FUJITSU CLIENT COMPUTING =
LIMITED LIFEBOOK U7512/FJNB2F4, BIOS Version 2.35 07/01/2025
Feb 07 17:19:09 heisenberg kernel: RIP: 0010:check_removing_space_info+0x6e=
/0xa0 [btrfs]
Feb 07 17:19:09 heisenberg kernel: Code: 00 00 00 04 74 0c 48 8b 85 b0 0a 0=
0 00 f6 c4 01 75 07 48 83 7b 38 00 75 2d 48 83 bb d0 00 00 00 00 75 1a 5b 5=
d c3 cc cc cc cc <0f> 0b 31 c9 31 d2 48 89 de 48 89 ef e8 81 d9 ff ff eb c0=
 0f 0b 5b
Feb 07 17:19:09 heisenberg kernel: RSP: 0018:ffffd1b2e7103c20 EFLAGS: 00010=
206
Feb 07 17:19:09 heisenberg kernel: RAX: 0000000000000000 RBX: ffff8ddc1cbe4=
000 RCX: 00000000820001ef
Feb 07 17:19:09 heisenberg kernel: RDX: 0000000082000101 RSI: fffff853f43cf=
840 RDI: 0000000000000000
Feb 07 17:19:09 heisenberg kernel: RBP: ffff8dd2101b8000 R08: ffff8ddd4f3e1=
7c8 R09: 00000000820001ef
Feb 07 17:19:09 heisenberg kernel: R10: ffff8ddd4f3e17c8 R11: ffff8dd140042=
400 R12: ffff8ddc1cbe4000
Feb 07 17:19:09 heisenberg kernel: R13: ffff8dd2101b8718 R14: dead000000000=
122 R15: dead000000000100
Feb 07 17:19:09 heisenberg kernel: FS:  00007f3b3256b840(0000) GS:ffff8de10=
108c000(0000) knlGS:0000000000000000
Feb 07 17:19:09 heisenberg kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000=
080050033
Feb 07 17:19:09 heisenberg kernel: CR2: 00007fb628a2bff0 CR3: 0000000824a1b=
006 CR4: 0000000000f72ef0
Feb 07 17:19:09 heisenberg kernel: PKRU: 55555554
Feb 07 17:19:09 heisenberg kernel: Call Trace:
Feb 07 17:19:09 heisenberg kernel:  <TASK>
Feb 07 17:19:09 heisenberg kernel:  btrfs_free_block_groups+0x380/0x3d0 [bt=
rfs]
Feb 07 17:19:09 heisenberg kernel:  close_ctree+0x457/0x490 [btrfs]
Feb 07 17:19:09 heisenberg kernel:  ? btrfs_get_root_ref+0x2a7/0x3b0 [btrfs=
]
Feb 07 17:19:09 heisenberg kernel:  open_ctree+0x12d6/0x15a0 [btrfs]
Feb 07 17:19:09 heisenberg kernel:  btrfs_get_tree.cold+0xb/0xb6 [btrfs]
Feb 07 17:19:09 heisenberg kernel:  ? btrfs_parse_param+0x4f/0x920 [btrfs]
Feb 07 17:19:09 heisenberg kernel:  ? strndup_user+0x4f/0x70
Feb 07 17:19:09 heisenberg kernel:  vfs_get_tree+0x29/0xd0
Feb 07 17:19:09 heisenberg kernel:  vfs_cmd_create+0x57/0xd0
Feb 07 17:19:09 heisenberg kernel:  __do_sys_fsconfig+0x4b6/0x650
Feb 07 17:19:09 heisenberg kernel:  do_syscall_64+0x81/0x7f0
Feb 07 17:19:09 heisenberg kernel:  ? do_syscall_64+0xb9/0x7f0
Feb 07 17:19:09 heisenberg kernel:  ? from_kuid_munged+0x13/0x30
Feb 07 17:19:09 heisenberg kernel:  ? __do_sys_geteuid+0x27/0x30
Feb 07 17:19:09 heisenberg kernel:  ? do_syscall_64+0xb9/0x7f0
Feb 07 17:19:09 heisenberg kernel:  ? exc_page_fault+0x7e/0x1a0
Feb 07 17:19:09 heisenberg kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7=
e
Feb 07 17:19:09 heisenberg kernel: RIP: 0033:0x7f3b32794a6a
Feb 07 17:19:09 heisenberg kernel: Code: 73 01 c3 48 8b 0d a6 23 0d 00 f7 d=
8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 a=
f 01 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 76 23 0d 00 f7 d8 64=
 89 01 48
Feb 07 17:19:09 heisenberg kernel: RSP: 002b:00007ffc7f7d62c8 EFLAGS: 00000=
246 ORIG_RAX: 00000000000001af
Feb 07 17:19:09 heisenberg kernel: RAX: ffffffffffffffda RBX: 000055687071f=
b80 RCX: 00007f3b32794a6a
Feb 07 17:19:09 heisenberg kernel: RDX: 0000000000000000 RSI: 0000000000000=
006 RDI: 0000000000000003
Feb 07 17:19:09 heisenberg kernel: RBP: 0000000000000000 R08: 0000000000000=
000 R09: 0000000000000000
Feb 07 17:19:09 heisenberg kernel: R10: 0000000000000000 R11: 0000000000000=
246 R12: 0000556870720120
Feb 07 17:19:09 heisenberg kernel: R13: 00007f3b3292226c R14: 00007f3b32920=
560 R15: 00007f3b3292226c
Feb 07 17:19:09 heisenberg kernel:  </TASK>
Feb 07 17:19:09 heisenberg kernel: ---[ end trace 0000000000000000 ]---
Feb 07 17:19:09 heisenberg kernel: BTRFS info (device dm-2 state EA): space=
_info METADATA (sub-group id 0) has 691535872 free, is not full
Feb 07 17:19:09 heisenberg kernel: BTRFS info (device dm-2 state EA): space=
_info total=3D17716740096, used=3D17020256256, pinned=3D0, reserved=3D88473=
6, may_use=3D3997696, readonly=3D65536 zone_unusable=3D0
Feb 07 17:19:09 heisenberg kernel: BTRFS info (device dm-2 state EA): globa=
l_block_rsv: size 0 reserved 0
Feb 07 17:19:09 heisenberg kernel: BTRFS info (device dm-2 state EA): trans=
_block_rsv: size 0 reserved 0
Feb 07 17:19:09 heisenberg kernel: BTRFS info (device dm-2 state EA): chunk=
_block_rsv: size 0 reserved 0
Feb 07 17:19:09 heisenberg kernel: BTRFS info (device dm-2 state EA): delay=
ed_block_rsv: size 0 reserved 0
Feb 07 17:19:09 heisenberg kernel: BTRFS info (device dm-2 state EA): delay=
ed_refs_rsv: size 56098816 reserved 3997696
Feb 07 17:19:09 heisenberg kernel: ------------[ cut here ]------------
Feb 07 17:19:09 heisenberg kernel: WARNING: CPU: 3 PID: 157318 at fs/btrfs/=
block-group.c:4473 check_removing_space_info+0x8a/0xa0 [btrfs]
Feb 07 17:19:09 heisenberg kernel: Modules linked in: cpuid ext4 mbcache jb=
d2 sg uas nft_fib_ipv6 nft_ct nft_fib_ipv4 nft_fib wireguard libcurve25519 =
libchacha20poly1305 libchacha ip6_udp_tunnel udp_tunnel libpoly1305 cmac cc=
m snd_seq_dummy snd_hrtimer snd_seq snd_ctl_led snd_soc_skl_hda_dsp snd_soc=
_intel_sof_board_helpers snd_sof_probes snd_soc_intel_hda_dsp_common xe snd=
_hda_codec_intelhdmi snd_hda_codec_alc269 snd_hda_scodec_component drm_gpuv=
m snd_hda_codec_realtek_lib drm_gpusvm_helper snd_hda_codec_generic gpu_sch=
ed snd_soc_dmic drm_ttm_helper drm_exec drm_suballoc_helper ip6t_REJECT nf_=
reject_ipv6 ipt_REJECT nf_reject_ipv4 snd_hda_intel xt_tcpudp snd_sof_pci_i=
ntel_tgl xt_conntrack snd_sof_pci_intel_cnl nf_conntrack snd_sof_intel_hda_=
generic nf_defrag_ipv6 soundwire_intel nf_defrag_ipv4 snd_sof_intel_hda_sdw=
_bpt nft_compat nf_tables snd_sof_intel_hda_common intel_uncore_frequency j=
oydev intel_uncore_frequency_common binfmt_misc x_tables snd_soc_hdac_hda x=
86_pkg_temp_thermal snd_sof_intel_hda_mlink intel_powerclamp snd_sof_intel_=
hda
Feb 07 17:19:09 heisenberg kernel:  i915 snd_hda_codec_hdmi soundwire_caden=
ce snd_sof_pci coretemp snd_sof_xtensa_dsp snd_sof kvm_intel snd_sof_utils =
snd_soc_acpi_intel_match snd_soc_acpi_intel_sdca_quirks soundwire_generic_a=
llocation kvm snd_soc_acpi hid_multitouch crc8 soundwire_bus iwlmvm snd_soc=
_sdca snd_soc_avs btusb uvcvideo btmtk irqbypass snd_soc_hda_codec btrtl vi=
deobuf2_vmalloc ghash_clmulni_intel drm_buddy btbcm snd_hda_ext_core uvc hi=
d_generic snd_hda_codec btintel iTCO_wdt rapl videobuf2_memops ttm sdhci_pc=
i snd_usb_audio intel_pmc_bxt processor_thermal_device_pci mac80211 intel_r=
apl_msr videobuf2_v4l2 snd_hda_core sdhci_uhs2 drm_display_helper bluetooth=
 intel_cstate iTCO_vendor_support snd_usbmidi_lib videodev processor_therma=
l_device sdhci snd_intel_dspcfg processor_thermal_wt_hint platform_temperat=
ure_control snd_rawmidi cec videobuf2_common snd_intel_sdw_acpi cqhci proce=
ssor_thermal_soc_slider snd_seq_device snd_hwdep mei_hdcp watchdog mei_pxp =
ee1004 wmi_bmof usbhid mc ecdh_generic libarc4 intel_uncore crc16 intel_pmc=
_core
Feb 07 17:19:09 heisenberg kernel:  mmc_core snd_soc_core rc_core platform_=
profile pmt_telemetry snd_compress ucsi_acpi processor_thermal_rfim drm_cli=
ent_lib snd_pcm_dmaengine processor_thermal_rapl typec_ucsi iwlwifi pmt_dis=
covery drm_kms_helper snd_pcm i2c_hid_acpi intel_rapl_common typec pmt_clas=
s i2c_hid i2c_algo_bit int3400_thermal hid roles fujitsu_laptop intel_pmc_s=
sram_telemetry acpi_thermal_rel acpi_pad acpi_tad cfg80211 battery button v=
ideo processor_thermal_wt_req i2c_i801 snd_timer processor_thermal_power_fl=
oor i2c_smbus mei_me snd intel_lpss_pci processor_thermal_mbox soundcore in=
tel_lpss mei rfkill wmi idma64 intel_vsec ac int340x_thermal_zone igen6_eda=
c parport_pc lp ppdev drm parport efi_pstore configfs nfnetlink autofs4 crc=
32c_cryptoapi sd_mod dm_crypt dm_mod raid10 raid456 async_raid6_recov async=
_memcpy async_pq async_xor async_tx raid1 raid0 md_mod usb_storage scsi_mod=
 scsi_common btrfs blake2b_generic xor raid6_pq xhci_pci xhci_hcd nvme thun=
derbolt nvme_core usbcore e1000e evdev nvme_keyring nvme_auth serio_raw int=
el_hid
Feb 07 17:19:09 heisenberg kernel:  fan pcspkr aesni_intel usb_common hkdf =
sparse_keymap efivarfs
Feb 07 17:19:09 heisenberg kernel: CPU: 3 UID: 0 PID: 157318 Comm: mount Ta=
inted: G        W           6.18.8+deb14-amd64 #1 PREEMPT(lazy)  Debian 6.1=
8.8-1=20
Feb 07 17:19:09 heisenberg kernel: Tainted: [W]=3DWARN
Feb 07 17:19:09 heisenberg kernel: Hardware name: FUJITSU CLIENT COMPUTING =
LIMITED LIFEBOOK U7512/FJNB2F4, BIOS Version 2.35 07/01/2025
Feb 07 17:19:09 heisenberg kernel: RIP: 0010:check_removing_space_info+0x8a=
/0xa0 [btrfs]
Feb 07 17:19:09 heisenberg kernel: Code: d0 00 00 00 00 75 1a 5b 5d c3 cc c=
c cc cc 0f 0b 31 c9 31 d2 48 89 de 48 89 ef e8 81 d9 ff ff eb c0 0f 0b 5b 5=
d c3 cc cc cc cc <0f> 0b 31 c9 31 d2 48 89 de 48 89 ef e8 65 d9 ff ff eb c0=
 0f 1f 00
Feb 07 17:19:09 heisenberg kernel: RSP: 0018:ffffd1b2e7103c20 EFLAGS: 00010=
206
Feb 07 17:19:09 heisenberg kernel: RAX: 0000000000000204 RBX: ffff8ddc1cbe4=
000 RCX: 0000000000000027
Feb 07 17:19:09 heisenberg kernel: RDX: 0000000000000000 RSI: 0000000000000=
001 RDI: ffff8ddc1cbe401c
Feb 07 17:19:09 heisenberg kernel: RBP: ffff8dd2101b8000 R08: 0000000000000=
000 R09: ffffd1b2e71039c8
Feb 07 17:19:09 heisenberg kernel: R10: ffffffffad884970 R11: 00000000fffff=
02e R12: ffff8ddc1cbe4000
Feb 07 17:19:09 heisenberg kernel: R13: ffff8dd2101b8718 R14: dead000000000=
122 R15: dead000000000100
Feb 07 17:19:09 heisenberg kernel: FS:  00007f3b3256b840(0000) GS:ffff8de10=
108c000(0000) knlGS:0000000000000000
Feb 07 17:19:09 heisenberg kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000=
080050033
Feb 07 17:19:09 heisenberg kernel: CR2: 00007fb628a2bff0 CR3: 0000000824a1b=
006 CR4: 0000000000f72ef0
Feb 07 17:19:09 heisenberg kernel: PKRU: 55555554
Feb 07 17:19:09 heisenberg kernel: Call Trace:
Feb 07 17:19:09 heisenberg kernel:  <TASK>
Feb 07 17:19:09 heisenberg kernel:  btrfs_free_block_groups+0x380/0x3d0 [bt=
rfs]
Feb 07 17:19:09 heisenberg kernel:  close_ctree+0x457/0x490 [btrfs]
Feb 07 17:19:09 heisenberg kernel:  ? btrfs_get_root_ref+0x2a7/0x3b0 [btrfs=
]
Feb 07 17:19:09 heisenberg kernel:  open_ctree+0x12d6/0x15a0 [btrfs]
Feb 07 17:19:09 heisenberg kernel:  btrfs_get_tree.cold+0xb/0xb6 [btrfs]
Feb 07 17:19:09 heisenberg kernel:  ? btrfs_parse_param+0x4f/0x920 [btrfs]
Feb 07 17:19:09 heisenberg kernel:  ? strndup_user+0x4f/0x70
Feb 07 17:19:09 heisenberg kernel:  vfs_get_tree+0x29/0xd0
Feb 07 17:19:09 heisenberg kernel:  vfs_cmd_create+0x57/0xd0
Feb 07 17:19:09 heisenberg kernel:  __do_sys_fsconfig+0x4b6/0x650
Feb 07 17:19:09 heisenberg kernel:  do_syscall_64+0x81/0x7f0
Feb 07 17:19:09 heisenberg kernel:  ? do_syscall_64+0xb9/0x7f0
Feb 07 17:19:09 heisenberg kernel:  ? from_kuid_munged+0x13/0x30
Feb 07 17:19:09 heisenberg kernel:  ? __do_sys_geteuid+0x27/0x30
Feb 07 17:19:09 heisenberg kernel:  ? do_syscall_64+0xb9/0x7f0
Feb 07 17:19:09 heisenberg kernel:  ? exc_page_fault+0x7e/0x1a0
Feb 07 17:19:09 heisenberg kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7=
e
Feb 07 17:19:09 heisenberg kernel: RIP: 0033:0x7f3b32794a6a
Feb 07 17:19:09 heisenberg kernel: Code: 73 01 c3 48 8b 0d a6 23 0d 00 f7 d=
8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 a=
f 01 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 76 23 0d 00 f7 d8 64=
 89 01 48
Feb 07 17:19:09 heisenberg kernel: RSP: 002b:00007ffc7f7d62c8 EFLAGS: 00000=
246 ORIG_RAX: 00000000000001af
Feb 07 17:19:09 heisenberg kernel: RAX: ffffffffffffffda RBX: 000055687071f=
b80 RCX: 00007f3b32794a6a
Feb 07 17:19:09 heisenberg kernel: RDX: 0000000000000000 RSI: 0000000000000=
006 RDI: 0000000000000003
Feb 07 17:19:09 heisenberg kernel: RBP: 0000000000000000 R08: 0000000000000=
000 R09: 0000000000000000
Feb 07 17:19:09 heisenberg kernel: R10: 0000000000000000 R11: 0000000000000=
246 R12: 0000556870720120
Feb 07 17:19:09 heisenberg kernel: R13: 00007f3b3292226c R14: 00007f3b32920=
560 R15: 00007f3b3292226c
Feb 07 17:19:09 heisenberg kernel:  </TASK>
Feb 07 17:19:09 heisenberg kernel: ---[ end trace 0000000000000000 ]---
Feb 07 17:19:09 heisenberg kernel: BTRFS info (device dm-2 state EA): space=
_info METADATA (sub-group id 0) has 691535872 free, is not full
Feb 07 17:19:09 heisenberg kernel: BTRFS info (device dm-2 state EA): space=
_info total=3D17716740096, used=3D17020256256, pinned=3D0, reserved=3D88473=
6, may_use=3D3997696, readonly=3D65536 zone_unusable=3D0
Feb 07 17:19:09 heisenberg kernel: BTRFS info (device dm-2 state EA): globa=
l_block_rsv: size 0 reserved 0
Feb 07 17:19:09 heisenberg kernel: BTRFS info (device dm-2 state EA): trans=
_block_rsv: size 0 reserved 0
Feb 07 17:19:09 heisenberg kernel: BTRFS info (device dm-2 state EA): chunk=
_block_rsv: size 0 reserved 0
Feb 07 17:19:09 heisenberg kernel: BTRFS info (device dm-2 state EA): delay=
ed_block_rsv: size 0 reserved 0
Feb 07 17:19:09 heisenberg kernel: BTRFS info (device dm-2 state EA): delay=
ed_refs_rsv: size 56098816 reserved 3997696
Feb 07 17:19:09 heisenberg kernel: BTRFS error (device dm-2 state EA): open=
_ctree failed: -2


A fsck brought:
# btrfs check /dev/mapper/data-f ; echo $? ; beep
Opening filesystem to check...
Checking filesystem on /dev/mapper/data-f
UUID: 84ee379c-29da-4513-b31b-db5e6097ebc8
[1/8] checking log skipped (none written)
[2/8] checking root items
[3/8] checking extents
ref mismatch on [157433856 16384] extent item 0, found 1
tree extent[157433856, 16384] root 10 has no backref item in extent tree
backpointer mismatch on [157433856 16384]
ref mismatch on [166985728 16384] extent item 0, found 1
tree extent[166985728, 16384] root 10 has no backref item in extent tree
backpointer mismatch on [166985728 16384]
ref mismatch on [167870464 16384] extent item 0, found 1
tree extent[167870464, 16384] root 10 has no backref item in extent tree
backpointer mismatch on [167870464 16384]
ref mismatch on [168148992 16384] extent item 0, found 1
tree extent[168148992, 16384] root 10 has no backref item in extent tree
backpointer mismatch on [168148992 16384]
metadata level mismatch on [171638784, 16384]
ref mismatch on [171638784 16384] extent item 0, found 1
tree extent[171638784, 16384] root 4 has no backref item in extent tree
backpointer mismatch on [171638784 16384]
ref mismatch on [171655168 16384] extent item 0, found 1
tree extent[171655168, 16384] root 4 has no backref item in extent tree
backpointer mismatch on [171655168 16384]
ref mismatch on [176553984 16384] extent item 0, found 1
tree extent[176553984, 16384] root 10 has no backref item in extent tree
backpointer mismatch on [176553984 16384]
ref mismatch on [176570368 16384] extent item 0, found 1
tree extent[176570368, 16384] root 10 has no backref item in extent tree
backpointer mismatch on [176570368 16384]
ref mismatch on [176586752 16384] extent item 0, found 1
tree extent[176586752, 16384] root 10 has no backref item in extent tree
backpointer mismatch on [176586752 16384]
ref mismatch on [177209344 16384] extent item 0, found 1
tree extent[177209344, 16384] root 10 has no backref item in extent tree
backpointer mismatch on [177209344 16384]
ref mismatch on [189743104 16384] extent item 0, found 1
tree extent[189743104, 16384] root 10 has no backref item in extent tree
backpointer mismatch on [189743104 16384]
ref mismatch on [189759488 16384] extent item 0, found 1
tree extent[189759488, 16384] root 10 has no backref item in extent tree
backpointer mismatch on [189759488 16384]
ref mismatch on [190906368 16384] extent item 0, found 1
tree extent[190906368, 16384] root 10 has no backref item in extent tree
backpointer mismatch on [190906368 16384]
ref mismatch on [190922752 16384] extent item 0, found 1
tree extent[190922752, 16384] root 10 has no backref item in extent tree
backpointer mismatch on [190922752 16384]
ref mismatch on [191971328 16384] extent item 0, found 1
tree extent[191971328, 16384] root 10 has no backref item in extent tree
backpointer mismatch on [191971328 16384]
ref mismatch on [192069632 16384] extent item 0, found 1
tree extent[192069632, 16384] root 10 has no backref item in extent tree
backpointer mismatch on [192069632 16384]
metadata level mismatch on [192380928, 16384]
ref mismatch on [192380928 16384] extent item 0, found 1
tree extent[192380928, 16384] root 10 has no backref item in extent tree
backpointer mismatch on [192380928 16384]
ref mismatch on [192397312 16384] extent item 0, found 1
tree extent[192397312, 16384] root 10 has no backref item in extent tree
backpointer mismatch on [192397312 16384]
ref mismatch on [194084864 16384] extent item 0, found 1
tree extent[194084864, 16384] root 10 has no backref item in extent tree
backpointer mismatch on [194084864 16384]
ref mismatch on [194101248 16384] extent item 0, found 1
tree extent[194101248, 16384] root 10 has no backref item in extent tree
backpointer mismatch on [194101248 16384]
ref mismatch on [194117632 16384] extent item 0, found 1
tree extent[194117632, 16384] root 10 has no backref item in extent tree
backpointer mismatch on [194117632 16384]
ref mismatch on [218218496 16384] extent item 0, found 1
tree extent[218218496, 16384] root 10 has no backref item in extent tree
backpointer mismatch on [218218496 16384]
ref mismatch on [218234880 16384] extent item 0, found 1
tree extent[218234880, 16384] root 10 has no backref item in extent tree
backpointer mismatch on [218234880 16384]
ref mismatch on [218873856 16384] extent item 0, found 1
tree extent[218873856, 16384] root 10 has no backref item in extent tree
backpointer mismatch on [218873856 16384]
ref mismatch on [219021312 16384] extent item 0, found 1
tree extent[219021312, 16384] root 10 has no backref item in extent tree
backpointer mismatch on [219021312 16384]
ref mismatch on [220823552 16384] extent item 1, found 0
tree extent[220823552, 16384] root 4 has no tree block found
incorrect global backref count on 220823552 found 1 wanted 0
backpointer mismatch on [220823552 16384]
owner ref check failed [220823552 16384]
ref mismatch on [221364224 16384] extent item 0, found 1
tree extent[221364224, 16384] root 10 has no backref item in extent tree
backpointer mismatch on [221364224 16384]
ref mismatch on [221380608 16384] extent item 0, found 1
tree extent[221380608, 16384] root 10 has no backref item in extent tree
backpointer mismatch on [221380608 16384]
ref mismatch on [221396992 16384] extent item 0, found 1
tree extent[221396992, 16384] root 10 has no backref item in extent tree
backpointer mismatch on [221396992 16384]
ref mismatch on [237371392 16384] extent item 0, found 1
tree extent[237371392, 16384] root 10 has no backref item in extent tree
backpointer mismatch on [237371392 16384]
metadata level mismatch on [237977600, 16384]
ref mismatch on [237977600 16384] extent item 0, found 1
tree extent[237977600, 16384] root 1 has no backref item in extent tree
backpointer mismatch on [237977600 16384]
ref mismatch on [245202944 16384] extent item 0, found 1
tree extent[245202944, 16384] root 1 has no backref item in extent tree
backpointer mismatch on [245202944 16384]
ref mismatch on [3689627664384 16384] extent item 1, found 0
tree extent[3689627664384, 16384] root 10 has no tree block found
incorrect global backref count on 3689627664384 found 1 wanted 0
backpointer mismatch on [3689627664384 16384]
owner ref check failed [3689627664384 16384]
ref mismatch on [3689964093440 16384] extent item 1, found 0
tree extent[3689964093440, 16384] root 10 has no tree block found
incorrect global backref count on 3689964093440 found 1 wanted 0
backpointer mismatch on [3689964093440 16384]
owner ref check failed [3689964093440 16384]
ref mismatch on [9196136939520 16384] extent item 1, found 0
tree extent[9196136939520, 16384] root 10 has no tree block found
incorrect global backref count on 9196136939520 found 1 wanted 0
backpointer mismatch on [9196136939520 16384]
owner ref check failed [9196136939520 16384]
ref mismatch on [11533647839232 16384] extent item 1, found 0
tree extent[11533647839232, 16384] root 10 has no tree block found
incorrect global backref count on 11533647839232 found 1 wanted 0
backpointer mismatch on [11533647839232 16384]
owner ref check failed [11533647839232 16384]
ref mismatch on [11533648068608 16384] extent item 1, found 0
tree extent[11533648068608, 16384] root 10 has no tree block found
incorrect global backref count on 11533648068608 found 1 wanted 0
backpointer mismatch on [11533648068608 16384]
owner ref check failed [11533648068608 16384]
metadata level mismatch on [11533908279296, 16384]
ref mismatch on [11533908279296 16384] extent item 1, found 0
tree extent[11533908279296, 16384] root 4 has no tree block found
incorrect global backref count on 11533908279296 found 1 wanted 0
backpointer mismatch on [11533908279296 16384]
owner ref check failed [11533908279296 16384]
metadata level mismatch on [11534158413824, 16384]
ref mismatch on [11534158413824 16384] extent item 1, found 0
tree extent[11534158413824, 16384] root 10 has no tree block found
incorrect global backref count on 11534158413824 found 1 wanted 0
backpointer mismatch on [11534158413824 16384]
owner ref check failed [11534158413824 16384]
ref mismatch on [11534159904768 16384] extent item 1, found 0
tree extent[11534159904768, 16384] root 10 has no tree block found
incorrect global backref count on 11534159904768 found 1 wanted 0
backpointer mismatch on [11534159904768 16384]
owner ref check failed [11534159904768 16384]
ref mismatch on [11534160035840 16384] extent item 1, found 0
tree extent[11534160035840, 16384] root 10 has no tree block found
incorrect global backref count on 11534160035840 found 1 wanted 0
backpointer mismatch on [11534160035840 16384]
owner ref check failed [11534160035840 16384]
ref mismatch on [11534160265216 16384] extent item 1, found 0
tree extent[11534160265216, 16384] root 10 has no tree block found
incorrect global backref count on 11534160265216 found 1 wanted 0
backpointer mismatch on [11534160265216 16384]
owner ref check failed [11534160265216 16384]
ref mismatch on [11534160330752 16384] extent item 1, found 0
tree extent[11534160330752, 16384] root 10 has no tree block found
incorrect global backref count on 11534160330752 found 1 wanted 0
backpointer mismatch on [11534160330752 16384]
owner ref check failed [11534160330752 16384]
ref mismatch on [11534161166336 16384] extent item 1, found 0
tree extent[11534161166336, 16384] root 10 has no tree block found
incorrect global backref count on 11534161166336 found 1 wanted 0
backpointer mismatch on [11534161166336 16384]
owner ref check failed [11534161166336 16384]
ref mismatch on [11534162329600 16384] extent item 1, found 0
tree extent[11534162329600, 16384] root 10 has no tree block found
incorrect global backref count on 11534162329600 found 1 wanted 0
backpointer mismatch on [11534162329600 16384]
owner ref check failed [11534162329600 16384]
metadata level mismatch on [11534162345984, 16384]
ref mismatch on [11534162345984 16384] extent item 1, found 0
tree extent[11534162345984, 16384] root 10 has no tree block found
incorrect global backref count on 11534162345984 found 1 wanted 0
backpointer mismatch on [11534162345984 16384]
owner ref check failed [11534162345984 16384]
ref mismatch on [11534162837504 16384] extent item 1, found 0
tree extent[11534162837504, 16384] root 10 has no tree block found
incorrect global backref count on 11534162837504 found 1 wanted 0
backpointer mismatch on [11534162837504 16384]
owner ref check failed [11534162837504 16384]
ref mismatch on [11534163181568 16384] extent item 1, found 0
tree extent[11534163181568, 16384] root 10 has no tree block found
incorrect global backref count on 11534163181568 found 1 wanted 0
backpointer mismatch on [11534163181568 16384]
owner ref check failed [11534163181568 16384]
ref mismatch on [11534163378176 16384] extent item 1, found 0
tree extent[11534163378176, 16384] root 10 has no tree block found
incorrect global backref count on 11534163378176 found 1 wanted 0
backpointer mismatch on [11534163378176 16384]
owner ref check failed [11534163378176 16384]
metadata level mismatch on [11534163394560, 16384]
ref mismatch on [11534163394560 16384] extent item 1, found 0
tree extent[11534163394560, 16384] root 10 has no tree block found
incorrect global backref count on 11534163394560 found 1 wanted 0
backpointer mismatch on [11534163394560 16384]
owner ref check failed [11534163394560 16384]
ref mismatch on [11534176518144 16384] extent item 1, found 0
tree extent[11534176518144, 16384] root 10 has no tree block found
incorrect global backref count on 11534176518144 found 1 wanted 0
backpointer mismatch on [11534176518144 16384]
owner ref check failed [11534176518144 16384]
ref mismatch on [11534176632832 16384] extent item 1, found 0
tree extent[11534176632832, 16384] root 10 has no tree block found
incorrect global backref count on 11534176632832 found 1 wanted 0
backpointer mismatch on [11534176632832 16384]
owner ref check failed [11534176632832 16384]
ref mismatch on [11534176894976 16384] extent item 1, found 0
tree extent[11534176894976, 16384] root 10 has no tree block found
incorrect global backref count on 11534176894976 found 1 wanted 0
backpointer mismatch on [11534176894976 16384]
owner ref check failed [11534176894976 16384]
metadata level mismatch on [11534177026048, 16384]
ref mismatch on [11534177026048 16384] extent item 1, found 0
tree extent[11534177026048, 16384] root 10 has no tree block found
incorrect global backref count on 11534177026048 found 1 wanted 0
backpointer mismatch on [11534177026048 16384]
owner ref check failed [11534177026048 16384]
ref mismatch on [11534177042432 16384] extent item 1, found 0
tree extent[11534177042432, 16384] root 10 has no tree block found
incorrect global backref count on 11534177042432 found 1 wanted 0
backpointer mismatch on [11534177042432 16384]
owner ref check failed [11534177042432 16384]
ref mismatch on [11534177320960 16384] extent item 1, found 0
tree extent[11534177320960, 16384] root 10 has no tree block found
incorrect global backref count on 11534177320960 found 1 wanted 0
backpointer mismatch on [11534177320960 16384]
owner ref check failed [11534177320960 16384]
ref mismatch on [11534177861632 16384] extent item 1, found 0
tree extent[11534177861632, 16384] root 10 has no tree block found
incorrect global backref count on 11534177861632 found 1 wanted 0
backpointer mismatch on [11534177861632 16384]
owner ref check failed [11534177861632 16384]
ref mismatch on [11534178123776 16384] extent item 1, found 0
tree extent[11534178123776, 16384] root 10 has no tree block found
incorrect global backref count on 11534178123776 found 1 wanted 0
backpointer mismatch on [11534178123776 16384]
owner ref check failed [11534178123776 16384]
ref mismatch on [11534178353152 16384] extent item 1, found 0
tree extent[11534178353152, 16384] root 10 has no tree block found
incorrect global backref count on 11534178353152 found 1 wanted 0
backpointer mismatch on [11534178353152 16384]
owner ref check failed [11534178353152 16384]
metadata level mismatch on [11534178467840, 16384]
ref mismatch on [11534178467840 16384] extent item 1, found 0
tree extent[11534178467840, 16384] root 10 has no tree block found
incorrect global backref count on 11534178467840 found 1 wanted 0
backpointer mismatch on [11534178467840 16384]
owner ref check failed [11534178467840 16384]
ref mismatch on [11534178942976 16384] extent item 1, found 0
tree extent[11534178942976, 16384] root 10 has no tree block found
incorrect global backref count on 11534178942976 found 1 wanted 0
backpointer mismatch on [11534178942976 16384]
owner ref check failed [11534178942976 16384]
ref mismatch on [11534179041280 16384] extent item 1, found 0
tree extent[11534179041280, 16384] root 10 has no tree block found
incorrect global backref count on 11534179041280 found 1 wanted 0
backpointer mismatch on [11534179041280 16384]
owner ref check failed [11534179041280 16384]
ref mismatch on [11534179450880 16384] extent item 1, found 0
tree extent[11534179450880, 16384] root 10 has no tree block found
incorrect global backref count on 11534179450880 found 1 wanted 0
backpointer mismatch on [11534179450880 16384]
owner ref check failed [11534179450880 16384]
ref mismatch on [11534179893248 16384] extent item 1, found 0
tree extent[11534179893248, 16384] root 10 has no tree block found
incorrect global backref count on 11534179893248 found 1 wanted 0
backpointer mismatch on [11534179893248 16384]
owner ref check failed [11534179893248 16384]
ref mismatch on [11534180073472 16384] extent item 1, found 0
tree extent[11534180073472, 16384] root 10 has no tree block found
incorrect global backref count on 11534180073472 found 1 wanted 0
backpointer mismatch on [11534180073472 16384]
owner ref check failed [11534180073472 16384]
ref mismatch on [11534180548608 16384] extent item 1, found 0
tree extent[11534180548608, 16384] root 10 has no tree block found
incorrect global backref count on 11534180548608 found 1 wanted 0
backpointer mismatch on [11534180548608 16384]
owner ref check failed [11534180548608 16384]
ref mismatch on [11534181777408 16384] extent item 1, found 0
tree extent[11534181777408, 16384] root 10 has no tree block found
incorrect global backref count on 11534181777408 found 1 wanted 0
backpointer mismatch on [11534181777408 16384]
owner ref check failed [11534181777408 16384]
ref mismatch on [11534182006784 16384] extent item 1, found 0
tree extent[11534182006784, 16384] root 10 has no tree block found
incorrect global backref count on 11534182006784 found 1 wanted 0
backpointer mismatch on [11534182006784 16384]
owner ref check failed [11534182006784 16384]
ref mismatch on [11534182514688 16384] extent item 1, found 0
tree extent[11534182514688, 16384] root 10 has no tree block found
incorrect global backref count on 11534182514688 found 1 wanted 0
backpointer mismatch on [11534182514688 16384]
owner ref check failed [11534182514688 16384]
ref mismatch on [11534183268352 16384] extent item 1, found 0
tree extent[11534183268352, 16384] root 10 has no tree block found
incorrect global backref count on 11534183268352 found 1 wanted 0
backpointer mismatch on [11534183268352 16384]
owner ref check failed [11534183268352 16384]
ref mismatch on [11534192181248 16384] extent item 1, found 0
tree extent[11534192181248, 16384] root 10 has no tree block found
incorrect global backref count on 11534192181248 found 1 wanted 0
backpointer mismatch on [11534192181248 16384]
owner ref check failed [11534192181248 16384]
metadata level mismatch on [11534208352256, 16384]
ref mismatch on [11534208352256 16384] extent item 1, found 0
tree extent[11534208352256, 16384] root 10 has no tree block found
incorrect global backref count on 11534208352256 found 1 wanted 0
backpointer mismatch on [11534208352256 16384]
owner ref check failed [11534208352256 16384]
metadata level mismatch on [11534208368640, 16384]
ref mismatch on [11534208368640 16384] extent item 1, found 0
tree extent[11534208368640, 16384] root 10 has no tree block found
incorrect global backref count on 11534208368640 found 1 wanted 0
backpointer mismatch on [11534208368640 16384]
owner ref check failed [11534208368640 16384]
ref mismatch on [11534208647168 16384] extent item 1, found 0
tree extent[11534208647168, 16384] root 10 has no tree block found
incorrect global backref count on 11534208647168 found 1 wanted 0
backpointer mismatch on [11534208647168 16384]
owner ref check failed [11534208647168 16384]
ref mismatch on [11534208811008 16384] extent item 1, found 0
tree extent[11534208811008, 16384] root 10 has no tree block found
incorrect global backref count on 11534208811008 found 1 wanted 0
backpointer mismatch on [11534208811008 16384]
owner ref check failed [11534208811008 16384]
ref mismatch on [11534208892928 16384] extent item 1, found 0
tree extent[11534208892928, 16384] root 10 has no tree block found
incorrect global backref count on 11534208892928 found 1 wanted 0
backpointer mismatch on [11534208892928 16384]
owner ref check failed [11534208892928 16384]
ref mismatch on [11534209400832 16384] extent item 1, found 0
tree extent[11534209400832, 16384] root 10 has no tree block found
incorrect global backref count on 11534209400832 found 1 wanted 0
backpointer mismatch on [11534209400832 16384]
owner ref check failed [11534209400832 16384]
metadata level mismatch on [11534210465792, 16384]
ref mismatch on [11534210465792 16384] extent item 1, found 0
tree extent[11534210465792, 16384] root 1 has no tree block found
incorrect global backref count on 11534210465792 found 1 wanted 0
backpointer mismatch on [11534210465792 16384]
owner ref check failed [11534210465792 16384]
ref mismatch on [11534210580480 16384] extent item 1, found 0
tree extent[11534210580480, 16384] root 1 has no tree block found
incorrect global backref count on 11534210580480 found 1 wanted 0
backpointer mismatch on [11534210580480 16384]
owner ref check failed [11534210580480 16384]
ref mismatch on [11534684995584 16384] extent item 1, found 0
tree extent[11534684995584, 16384] root 10 has no tree block found
incorrect global backref count on 11534684995584 found 1 wanted 0
backpointer mismatch on [11534684995584 16384]
owner ref check failed [11534684995584 16384]
ERROR: errors found in extent allocation tree or chunk allocation
[4/8] checking free space tree
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
could not load free space tree: No such file or directory
[5/8] checking fs roots
[6/8] checking only csums items (without verifying data)
[7/8] checking root refs
[8/8] checking quota groups skipped (not enabled on this FS)
found 3158562811904 bytes used, error(s) found
total csum bytes: 3067911580
total tree bytes: 17020551168
total fs tree bytes: 12739821568
total extent tree bytes: 794050560
btree space waste bytes: 2806440458
file data blocks allocated: 12774436143104
 referenced 5635122405376
1


But if I do a plain mount:
# mount -o ro /dev/mapper/data-f /data/f

it works:
Feb 07 17:43:15 heisenberg kernel: BTRFS info (device dm-2): last unmount o=
f filesystem 84ee379c-29da-4513-b31b-db5e6097ebc8
Feb 07 17:43:28 heisenberg kernel: BTRFS: device label data-f devid 1 trans=
id 2940 /dev/mapper/data-f (253:2) scanned by mount (158875)
Feb 07 17:43:28 heisenberg kernel: BTRFS info (device dm-2): first mount of=
 filesystem 84ee379c-29da-4513-b31b-db5e6097ebc8
Feb 07 17:43:28 heisenberg kernel: BTRFS info (device dm-2): using crc32c (=
crc32c-lib) checksum algorithm
Feb 07 17:43:47 heisenberg kernel: BTRFS info (device dm-2): enabling free =
space tree

remount,ro also works


I didn't try a btrfs check --clear-space-cache v2 because I thought
maybe it clears stuff you'd want to test.


Also:
# btrfs inspect-internal dump-super /dev/mapper/data-f=20
superblock: bytenr=3D65536, device=3D/dev/mapper/data-f
---------------------------------------------------------
csum_type		0 (crc32c)
csum_size		4
csum			0xa4421d4b [match]
bytenr			65536
flags			0x1
			( WRITTEN )
magic			_BHRfS_M [match]
fsid			84ee379c-29da-4513-b31b-db5e6097ebc8
metadata_uuid		00000000-0000-0000-0000-000000000000
label			data-f
generation		2940
root			237977600
sys_array_size		129
chunk_root_generation	2927
root_level		1
chunk_root		23773184
chunk_root_level	1
log_root		0
log_root_transid (deprecated)	0
log_root_level		0
total_bytes		8000433553408
bytes_used		3158562304000
sectorsize		4096
nodesize		16384
leafsize (deprecated)	16384
stripesize		4096
root_dir		6
num_devices		1
compat_flags		0x0
compat_ro_flags		0x3
			( FREE_SPACE_TREE |
			  FREE_SPACE_TREE_VALID )
incompat_flags		0x361
			( MIXED_BACKREF |
			  BIG_METADATA |
			  EXTENDED_IREF |
			  SKINNY_METADATA |
			  NO_HOLES )
cache_generation	0
uuid_tree_generation	2735
dev_item.uuid		1fd86dd6-71e3-43a0-9ab4-c0b748b9aafb
dev_item.fsid		84ee379c-29da-4513-b31b-db5e6097ebc8 [match]
dev_item.type		0
dev_item.total_bytes	8000433553408
dev_item.bytes_used	4317532651520
dev_item.io_align	4096
dev_item.io_width	4096
dev_item.sector_size	4096
dev_item.devid		1
dev_item.dev_group	0
dev_item.seek_speed	0
dev_item.bandwidth	0
dev_item.generation	0

# btrfs inspect-internal dump-tree -t root /dev/mapper/data-f
btrfs-progs v6.17.1
root tree
node 237977600 level 1 items 2 free space 491 generation 2940 owner ROOT_TR=
EE
node 237977600 flags 0x1(WRITTEN) backref revision 1
fs uuid 84ee379c-29da-4513-b31b-db5e6097ebc8
chunk uuid 3a6ae352-88b5-4ee3-a556-d0f468194f3c
	key (EXTENT_TREE ROOT_ITEM 0) block 245202944 gen 2940
	key (264 ROOT_ITEM 2109) block 11534210482176 gen 2928
leaf 245202944 items 44 free space 9924 generation 2940 owner ROOT_TREE
leaf 245202944 flags 0x1(WRITTEN) backref revision 1
fs uuid 84ee379c-29da-4513-b31b-db5e6097ebc8
chunk uuid 3a6ae352-88b5-4ee3-a556-d0f468194f3c
	item 0 key (EXTENT_TREE ROOT_ITEM 0) itemoff 15844 itemsize 439
		generation 2928 root_dirid 0 bytenr 11534208303104 byte_limit 0 bytes_use=
d 794050560
		last_snapshot 0 flags 0x0(none) refs 1
		drop_progress key (0 UNKNOWN.0 0) drop_level 0
		level 2 generation_v2 2928
		uuid 00000000-0000-0000-0000-000000000000
		parent_uuid 00000000-0000-0000-0000-000000000000
		received_uuid 00000000-0000-0000-0000-000000000000
		ctransid 0 otransid 0 stransid 0 rtransid 0
		ctime 0.0 (1970-01-01 01:00:00)
		otime 0.0 (1970-01-01 01:00:00)
		stime 0.0 (1970-01-01 01:00:00)
		rtime 0.0 (1970-01-01 01:00:00)
	item 1 key (DEV_TREE ROOT_ITEM 0) itemoff 15405 itemsize 439
		generation 2935 root_dirid 0 bytenr 171638784 byte_limit 0 bytes_used 393=
216
		last_snapshot 0 flags 0x0(none) refs 1
		drop_progress key (0 UNKNOWN.0 0) drop_level 0
		level 1 generation_v2 2935
		uuid 00000000-0000-0000-0000-000000000000
		parent_uuid 00000000-0000-0000-0000-000000000000
		received_uuid 00000000-0000-0000-0000-000000000000
		ctransid 0 otransid 0 stransid 0 rtransid 0
		ctime 0.0 (1970-01-01 01:00:00)
		otime 0.0 (1970-01-01 01:00:00)
		stime 0.0 (1970-01-01 01:00:00)
		rtime 0.0 (1970-01-01 01:00:00)
	item 2 key (FS_TREE INODE_REF 6) itemoff 15388 itemsize 17
		index 0 namelen 7 name: default
	item 3 key (FS_TREE ROOT_ITEM 0) itemoff 14949 itemsize 439
		generation 2903 root_dirid 256 bytenr 32047104 byte_limit 0 bytes_used 44=
466176
		last_snapshot 0 flags 0x0(none) refs 1
		drop_progress key (0 UNKNOWN.0 0) drop_level 0
		level 2 generation_v2 2903
		uuid 79001bea-319c-47b4-bf1c-142ca6efe1e6
		parent_uuid 00000000-0000-0000-0000-000000000000
		received_uuid 00000000-0000-0000-0000-000000000000
		ctransid 2903 otransid 0 stransid 0 rtransid 0
		ctime 1768586382.22896989 (2026-01-16 18:59:42)
		otime 1667652458.0 (2022-11-05 13:47:38)
		stime 0.0 (1970-01-01 01:00:00)
		rtime 0.0 (1970-01-01 01:00:00)
	item 4 key (FS_TREE ROOT_REF 257) itemoff 14919 itemsize 30
		root ref key dirid 267 sequence 2 name 2022-11-01_1
	item 5 key (FS_TREE ROOT_REF 260) itemoff 14889 itemsize 30
		root ref key dirid 267 sequence 3 name 2022-11-25_1
	item 6 key (FS_TREE ROOT_REF 262) itemoff 14854 itemsize 35
		root ref key dirid 267 sequence 4 name 2023-01-15_1_live
	item 7 key (FS_TREE ROOT_REF 264) itemoff 14819 itemsize 35
		root ref key dirid 267 sequence 5 name 2023-03-02_1_live
	item 8 key (FS_TREE ROOT_REF 265) itemoff 14784 itemsize 35
		root ref key dirid 267 sequence 6 name 2023-04-23_1_live
	item 9 key (FS_TREE ROOT_REF 267) itemoff 14722 itemsize 62
		root ref key dirid 267 sequence 8 name 2023-06-04_1_live-DO-NOT-USE-FOR-S=
ENDRECEIVE
	item 10 key (FS_TREE ROOT_REF 272) itemoff 14687 itemsize 35
		root ref key dirid 267 sequence 9 name 2023-07-16_1_live
	item 11 key (FS_TREE ROOT_REF 273) itemoff 14657 itemsize 30
		root ref key dirid 267 sequence 10 name 2023-08-28_1
	item 12 key (FS_TREE ROOT_REF 275) itemoff 14622 itemsize 35
		root ref key dirid 267 sequence 11 name 2023-10-22_1_live
	item 13 key (FS_TREE ROOT_REF 277) itemoff 14587 itemsize 35
		root ref key dirid 267 sequence 12 name 2023-11-29_1_live
	item 14 key (FS_TREE ROOT_REF 278) itemoff 14552 itemsize 35
		root ref key dirid 267 sequence 13 name 2024-02-10_1_live
	item 15 key (FS_TREE ROOT_REF 279) itemoff 14517 itemsize 35
		root ref key dirid 267 sequence 14 name 2024-03-29_1_live
	item 16 key (FS_TREE ROOT_REF 280) itemoff 14482 itemsize 35
		root ref key dirid 267 sequence 15 name 2024-04-19_1_live
	item 17 key (FS_TREE ROOT_REF 281) itemoff 14452 itemsize 30
		root ref key dirid 267 sequence 16 name 2024-05-22_1
	item 18 key (FS_TREE ROOT_REF 282) itemoff 14417 itemsize 35
		root ref key dirid 267 sequence 17 name 2024-08-14_1_live
	item 19 key (FS_TREE ROOT_REF 283) itemoff 14382 itemsize 35
		root ref key dirid 267 sequence 18 name 2024-08-22_3_live
	item 20 key (FS_TREE ROOT_REF 284) itemoff 14347 itemsize 35
		root ref key dirid 267 sequence 19 name 2024-09-07_1_live
	item 21 key (FS_TREE ROOT_REF 285) itemoff 14312 itemsize 35
		root ref key dirid 267 sequence 20 name 2024-10-22_1_live
	item 22 key (FS_TREE ROOT_REF 286) itemoff 14277 itemsize 35
		root ref key dirid 267 sequence 21 name 2024-11-24_1_live
	item 23 key (FS_TREE ROOT_REF 287) itemoff 14242 itemsize 35
		root ref key dirid 267 sequence 22 name 2025-01-14_1_live
	item 24 key (FS_TREE ROOT_REF 288) itemoff 14207 itemsize 35
		root ref key dirid 267 sequence 23 name 2025-02-23_2_live
	item 25 key (FS_TREE ROOT_REF 289) itemoff 14172 itemsize 35
		root ref key dirid 267 sequence 24 name 2025-05-09_1_live
	item 26 key (FS_TREE ROOT_REF 290) itemoff 14137 itemsize 35
		root ref key dirid 267 sequence 25 name 2025-06-07_1_live
	item 27 key (FS_TREE ROOT_REF 291) itemoff 14102 itemsize 35
		root ref key dirid 267 sequence 26 name 2025-07-27_1_live
	item 28 key (FS_TREE ROOT_REF 292) itemoff 14067 itemsize 35
		root ref key dirid 267 sequence 27 name 2025-09-05_1_live
	item 29 key (FS_TREE ROOT_REF 293) itemoff 14032 itemsize 35
		root ref key dirid 267 sequence 28 name 2025-09-30_1_live
	item 30 key (FS_TREE ROOT_REF 294) itemoff 13997 itemsize 35
		root ref key dirid 267 sequence 29 name 2025-11-03_1_live
	item 31 key (FS_TREE ROOT_REF 295) itemoff 13962 itemsize 35
		root ref key dirid 267 sequence 30 name 2026-01-16_1_live
	item 32 key (ROOT_TREE_DIR INODE_ITEM 0) itemoff 13802 itemsize 160
		generation 3 transid 0 size 0 nbytes 16384
		block group 0 mode 40755 links 1 uid 0 gid 0 rdev 0
		sequence 0 flags 0x0(none)
		atime 1667652458.0 (2022-11-05 13:47:38)
		ctime 1667652458.0 (2022-11-05 13:47:38)
		mtime 1667652458.0 (2022-11-05 13:47:38)
		otime 1667652458.0 (2022-11-05 13:47:38)
	item 33 key (ROOT_TREE_DIR INODE_REF 6) itemoff 13790 itemsize 12
		index 0 namelen 2 name: ..
	item 34 key (ROOT_TREE_DIR DIR_ITEM 2378154706) itemoff 13753 itemsize 37
		location key (FS_TREE ROOT_ITEM 18446744073709551615) type DIR
		transid 0 data_len 0 name_len 7
		name: default
	item 35 key (CSUM_TREE ROOT_ITEM 0) itemoff 13314 itemsize 439
		generation 2928 root_dirid 0 bytenr 11534203142144 byte_limit 0 bytes_use=
d 3485188096
		last_snapshot 0 flags 0x0(none) refs 1
		drop_progress key (0 UNKNOWN.0 0) drop_level 0
		level 3 generation_v2 2928
		uuid 00000000-0000-0000-0000-000000000000
		parent_uuid 00000000-0000-0000-0000-000000000000
		received_uuid 00000000-0000-0000-0000-000000000000
		ctransid 0 otransid 0 stransid 0 rtransid 0
		ctime 0.0 (1970-01-01 01:00:00)
		otime 0.0 (1970-01-01 01:00:00)
		stime 0.0 (1970-01-01 01:00:00)
		rtime 0.0 (1970-01-01 01:00:00)
	item 36 key (UUID_TREE ROOT_ITEM 0) itemoff 12875 itemsize 439
		generation 2927 root_dirid 0 bytenr 11534158348288 byte_limit 0 bytes_use=
d 16384
		last_snapshot 0 flags 0x0(none) refs 1
		drop_progress key (0 UNKNOWN.0 0) drop_level 0
		level 0 generation_v2 2927
		uuid 00000000-0000-0000-0000-000000000000
		parent_uuid 00000000-0000-0000-0000-000000000000
		received_uuid 00000000-0000-0000-0000-000000000000
		ctransid 0 otransid 0 stransid 0 rtransid 0
		ctime 0.0 (1970-01-01 01:00:00)
		otime 0.0 (1970-01-01 01:00:00)
		stime 0.0 (1970-01-01 01:00:00)
		rtime 0.0 (1970-01-01 01:00:00)
	item 37 key (FREE_SPACE_TREE ROOT_ITEM 0) itemoff 12436 itemsize 439
		generation 2940 root_dirid 0 bytenr 192380928 byte_limit 0 bytes_used 442=
368
		last_snapshot 0 flags 0x0(none) refs 1
		drop_progress key (0 UNKNOWN.0 0) drop_level 0
		level 1 generation_v2 2940
		uuid 00000000-0000-0000-0000-000000000000
		parent_uuid 00000000-0000-0000-0000-000000000000
		received_uuid 00000000-0000-0000-0000-000000000000
		ctransid 0 otransid 0 stransid 0 rtransid 0
		ctime 0.0 (1970-01-01 01:00:00)
		otime 0.0 (1970-01-01 01:00:00)
		stime 0.0 (1970-01-01 01:00:00)
		rtime 0.0 (1970-01-01 01:00:00)
	item 38 key (257 ROOT_ITEM 0) itemoff 11997 itemsize 439
		generation 1965 root_dirid 256 bytenr 5008533897216 byte_limit 0 bytes_us=
ed 1028194304
		last_snapshot 1965 flags 0x1(RDONLY) refs 1
		drop_progress key (0 UNKNOWN.0 0) drop_level 0
		level 2 generation_v2 1965
		uuid bb90bf09-f94a-b44f-9eed-a24a48ea108b
		parent_uuid 00000000-0000-0000-0000-000000000000
		received_uuid d5c7dec7-f667-6b4f-8595-284ca248d16e
		ctransid 875 otransid 834 stransid 1616 rtransid 872
		ctime 1667789428.840077216 (2022-11-07 03:50:28)
		otime 1667785180.288603374 (2022-11-07 02:39:40)
		stime 0.0 (1970-01-01 01:00:00)
		rtime 1667789385.756533739 (2022-11-07 03:49:45)
	item 39 key (257 ROOT_BACKREF 5) itemoff 11967 itemsize 30
		root backref key dirid 267 sequence 2 name 2022-11-01_1
	item 40 key (260 ROOT_ITEM 1965) itemoff 11528 itemsize 439
		generation 2041 root_dirid 256 bytenr 8872905883648 byte_limit 0 bytes_us=
ed 1270202368
		last_snapshot 2041 flags 0x1(RDONLY) refs 1
		drop_progress key (0 UNKNOWN.0 0) drop_level 0
		level 2 generation_v2 2041
		uuid 7a09ebcb-7f9f-c14e-b9da-6bf2010a7441
		parent_uuid bb90bf09-f94a-b44f-9eed-a24a48ea108b
		received_uuid dd4938ab-7692-8f48-84db-230779aef6b7
		ctransid 1975 otransid 1965 stransid 42506 rtransid 1973
		ctime 1669484586.194689046 (2022-11-26 18:43:06)
		otime 1669484067.471547251 (2022-11-26 18:34:27)
		stime 0.0 (1970-01-01 01:00:00)
		rtime 1669484558.526265242 (2022-11-26 18:42:38)
	item 41 key (260 ROOT_BACKREF 5) itemoff 11498 itemsize 30
		root backref key dirid 267 sequence 3 name 2022-11-25_1
	item 42 key (262 ROOT_ITEM 2041) itemoff 11059 itemsize 439
		generation 2109 root_dirid 256 bytenr 9196475252736 byte_limit 0 bytes_us=
ed 1272446976
		last_snapshot 2109 flags 0x1(RDONLY) refs 1
		drop_progress key (0 UNKNOWN.0 0) drop_level 0
		level 2 generation_v2 2109
		uuid b28cace6-98b7-514a-8229-011d7d9c762b
		parent_uuid 7a09ebcb-7f9f-c14e-b9da-6bf2010a7441
		received_uuid eb3cfe95-b9f5-1f4c-9d58-84f73ba9797b
		ctransid 2053 otransid 2041 stransid 117879 rtransid 2051
		ctime 1673887395.925468006 (2023-01-16 17:43:15)
		otime 1673886617.970733771 (2023-01-16 17:30:17)
		stime 0.0 (1970-01-01 01:00:00)
		rtime 1673887359.449299021 (2023-01-16 17:42:39)
	item 43 key (262 ROOT_BACKREF 5) itemoff 11024 itemsize 35
		root backref key dirid 267 sequence 4 name 2023-01-15_1_live
leaf 11534210482176 items 51 free space 2702 generation 2928 owner ROOT_TRE=
E
leaf 11534210482176 flags 0x1(WRITTEN) backref revision 1
fs uuid 84ee379c-29da-4513-b31b-db5e6097ebc8
chunk uuid 3a6ae352-88b5-4ee3-a556-d0f468194f3c
	item 0 key (264 ROOT_ITEM 2109) itemoff 15844 itemsize 439
		generation 2125 root_dirid 256 bytenr 31162368 byte_limit 0 bytes_used 13=
14947072
		last_snapshot 2125 flags 0x1(RDONLY) refs 1
		drop_progress key (0 UNKNOWN.0 0) drop_level 0
		level 2 generation_v2 2125
		uuid 2383fb9f-092b-9140-8bf6-99202e77ce81
		parent_uuid b28cace6-98b7-514a-8229-011d7d9c762b
		received_uuid a95a4755-2a73-ed4e-be0d-6d296754a4ec
		ctransid 2123 otransid 2109 stransid 170870 rtransid 2121
		ctime 1677894168.621737788 (2023-03-04 02:42:48)
		otime 1677893428.705412271 (2023-03-04 02:30:28)
		stime 0.0 (1970-01-01 01:00:00)
		rtime 1677894137.512533951 (2023-03-04 02:42:17)
	item 1 key (264 ROOT_BACKREF 5) itemoff 15809 itemsize 35
		root backref key dirid 267 sequence 5 name 2023-03-02_1_live
	item 2 key (265 ROOT_ITEM 2125) itemoff 15370 itemsize 439
		generation 2190 root_dirid 256 bytenr 1936211574784 byte_limit 0 bytes_us=
ed 1105100800
		last_snapshot 2190 flags 0x1(RDONLY) refs 1
		drop_progress key (0 UNKNOWN.0 0) drop_level 0
		level 2 generation_v2 2190
		uuid 63069e8e-47d7-5245-94c6-8ce98afdf35c
		parent_uuid 2383fb9f-092b-9140-8bf6-99202e77ce81
		received_uuid bc1c274c-a305-384b-824b-20859e65fdc9
		ctransid 2136 otransid 2125 stransid 215318 rtransid 2133
		ctime 1682374758.458918354 (2023-04-25 00:19:18)
		otime 1682374204.3180636 (2023-04-25 00:10:04)
		stime 0.0 (1970-01-01 01:00:00)
		rtime 1682374718.386287144 (2023-04-25 00:18:38)
	item 3 key (265 ROOT_BACKREF 5) itemoff 15335 itemsize 35
		root backref key dirid 267 sequence 6 name 2023-04-23_1_live
	item 4 key (267 ROOT_ITEM 2190) itemoff 14896 itemsize 439
		generation 2321 root_dirid 256 bytenr 9794675113984 byte_limit 0 bytes_us=
ed 1110769664
		last_snapshot 2321 flags 0x1(RDONLY) refs 1
		drop_progress key (0 UNKNOWN.0 0) drop_level 0
		level 2 generation_v2 2321
		uuid 34567cef-747e-fb48-bb5e-8e710540857d
		parent_uuid 63069e8e-47d7-5245-94c6-8ce98afdf35c
		received_uuid 50988f97-18a9-e24e-bfae-9cbfea95d8a1
		ctransid 2198 otransid 2190 stransid 253579 rtransid 2196
		ctime 1685901971.282905628 (2023-06-04 20:06:11)
		otime 1685901681.140605443 (2023-06-04 20:01:21)
		stime 0.0 (1970-01-01 01:00:00)
		rtime 1685901934.709468414 (2023-06-04 20:05:34)
	item 5 key (267 ROOT_BACKREF 5) itemoff 14834 itemsize 62
		root backref key dirid 267 sequence 8 name 2023-06-04_1_live-DO-NOT-USE-F=
OR-SENDRECEIVE
	item 6 key (272 ROOT_ITEM 2321) itemoff 14395 itemsize 439
		generation 2333 root_dirid 256 bytenr 1936220733440 byte_limit 0 bytes_us=
ed 1081589760
		last_snapshot 2333 flags 0x1(RDONLY) refs 1
		drop_progress key (0 UNKNOWN.0 0) drop_level 0
		level 2 generation_v2 2333
		uuid 8cfb8ada-d1c2-9c43-b9eb-22cc9fcccf06
		parent_uuid 34567cef-747e-fb48-bb5e-8e710540857d
		received_uuid d42d2007-98e7-4049-bee4-39f626a08b36
		ctransid 2331 otransid 2321 stransid 294601 rtransid 2329
		ctime 1689612440.429911312 (2023-07-17 18:47:20)
		otime 1689611961.661587857 (2023-07-17 18:39:21)
		stime 0.0 (1970-01-01 01:00:00)
		rtime 1689612385.385260741 (2023-07-17 18:46:25)
	item 7 key (272 ROOT_BACKREF 5) itemoff 14360 itemsize 35
		root backref key dirid 267 sequence 9 name 2023-07-16_1_live
	item 8 key (273 ROOT_ITEM 2333) itemoff 13921 itemsize 439
		generation 2374 root_dirid 256 bytenr 50692096 byte_limit 0 bytes_used 10=
58570240
		last_snapshot 2374 flags 0x1(RDONLY) refs 1
		drop_progress key (0 UNKNOWN.0 0) drop_level 0
		level 2 generation_v2 2374
		uuid db528597-0b37-d04b-a706-a06a71e4b15b
		parent_uuid 8cfb8ada-d1c2-9c43-b9eb-22cc9fcccf06
		received_uuid d01737a3-988c-d241-a301-a63bbf639e33
		ctransid 2343 otransid 2333 stransid 342695 rtransid 2340
		ctime 1693255924.481284996 (2023-08-28 22:52:04)
		otime 1693255386.529355974 (2023-08-28 22:43:06)
		stime 0.0 (1970-01-01 01:00:00)
		rtime 1693255868.716173131 (2023-08-28 22:51:08)
	item 9 key (273 ROOT_BACKREF 5) itemoff 13891 itemsize 30
		root backref key dirid 267 sequence 10 name 2023-08-28_1
	item 10 key (275 ROOT_ITEM 2374) itemoff 13452 itemsize 439
		generation 2578 root_dirid 256 bytenr 878968832 byte_limit 0 bytes_used 1=
059913728
		last_snapshot 2578 flags 0x1(RDONLY) refs 1
		drop_progress key (0 UNKNOWN.0 0) drop_level 0
		level 2 generation_v2 2578
		uuid 14148a82-5256-654b-9109-d05f0760cfe4
		parent_uuid db528597-0b37-d04b-a706-a06a71e4b15b
		received_uuid 4ea20bd4-33ba-ed4c-9d09-08f69b825325
		ctransid 2381 otransid 2374 stransid 393039 rtransid 2379
		ctime 1698265242.569609002 (2023-10-25 22:20:42)
		otime 1698264678.459963517 (2023-10-25 22:11:18)
		stime 0.0 (1970-01-01 01:00:00)
		rtime 1698265187.162781224 (2023-10-25 22:19:47)
	item 11 key (275 ROOT_BACKREF 5) itemoff 13417 itemsize 35
		root backref key dirid 267 sequence 11 name 2023-10-22_1_live
	item 12 key (277 ROOT_ITEM 2578) itemoff 12978 itemsize 439
		generation 2607 root_dirid 256 bytenr 138297344 byte_limit 0 bytes_used 1=
087504384
		last_snapshot 2607 flags 0x1(RDONLY) refs 1
		drop_progress key (0 UNKNOWN.0 0) drop_level 0
		level 2 generation_v2 2607
		uuid 5431a3fb-6577-0f4c-931d-982e996a4c37
		parent_uuid 14148a82-5256-654b-9109-d05f0760cfe4
		received_uuid 9971aeab-b0ff-a240-8c9e-fc8b6df4450b
		ctransid 2586 otransid 2578 stransid 442097 rtransid 2584
		ctime 1701442399.471600404 (2023-12-01 15:53:19)
		otime 1701441940.628649465 (2023-12-01 15:45:40)
		stime 0.0 (1970-01-01 01:00:00)
		rtime 1701442363.763458657 (2023-12-01 15:52:43)
	item 13 key (277 ROOT_BACKREF 5) itemoff 12943 itemsize 35
		root backref key dirid 267 sequence 12 name 2023-11-29_1_live
	item 14 key (278 ROOT_ITEM 2607) itemoff 12504 itemsize 439
		generation 2629 root_dirid 256 bytenr 30441472 byte_limit 0 bytes_used 11=
79156480
		last_snapshot 2629 flags 0x1(RDONLY) refs 1
		drop_progress key (0 UNKNOWN.0 0) drop_level 0
		level 2 generation_v2 2629
		uuid 3ec88167-40c1-eb4e-8d8c-ccfa33a537dc
		parent_uuid 5431a3fb-6577-0f4c-931d-982e996a4c37
		received_uuid d08612b2-82c3-0a4a-84a7-de8e9c965c74
		ctransid 2627 otransid 2607 stransid 536794 rtransid 2625
		ctime 1707598996.369613511 (2024-02-10 22:03:16)
		otime 1707597748.711084482 (2024-02-10 21:42:28)
		stime 0.0 (1970-01-01 01:00:00)
		rtime 1707598956.784177890 (2024-02-10 22:02:36)
	item 15 key (278 ROOT_BACKREF 5) itemoff 12469 itemsize 35
		root backref key dirid 267 sequence 13 name 2024-02-10_1_live
	item 16 key (279 ROOT_ITEM 2629) itemoff 12030 itemsize 439
		generation 2650 root_dirid 256 bytenr 30408704 byte_limit 0 bytes_used 12=
43660288
		last_snapshot 2650 flags 0x1(RDONLY) refs 1
		drop_progress key (0 UNKNOWN.0 0) drop_level 0
		level 2 generation_v2 2650
		uuid 843212dc-8452-1e4c-8e28-71b4670fbabb
		parent_uuid 3ec88167-40c1-eb4e-8d8c-ccfa33a537dc
		received_uuid 2bde8caf-fe50-bb46-b7a7-173568c74585
		ctransid 2648 otransid 2629 stransid 586717 rtransid 2645
		ctime 1711735134.109459375 (2024-03-29 18:58:54)
		otime 1711733993.558405595 (2024-03-29 18:39:53)
		stime 0.0 (1970-01-01 01:00:00)
		rtime 1711735086.633009228 (2024-03-29 18:58:06)
	item 17 key (279 ROOT_BACKREF 5) itemoff 11995 itemsize 35
		root backref key dirid 267 sequence 14 name 2024-03-29_1_live
	item 18 key (280 ROOT_ITEM 2650) itemoff 11556 itemsize 439
		generation 2668 root_dirid 256 bytenr 30457856 byte_limit 0 bytes_used 12=
80753664
		last_snapshot 2668 flags 0x1(RDONLY) refs 1
		drop_progress key (0 UNKNOWN.0 0) drop_level 0
		level 2 generation_v2 2668
		uuid 0374c3e1-d12d-ee41-bbb5-446c5c06aa18
		parent_uuid 843212dc-8452-1e4c-8e28-71b4670fbabb
		received_uuid 1f1e6931-2e0a-8043-8c6e-9580108d3ac9
		ctransid 2666 otransid 2650 stransid 614024 rtransid 2665
		ctime 1713716525.118335261 (2024-04-21 18:22:05)
		otime 1713714497.487554070 (2024-04-21 17:48:17)
		stime 0.0 (1970-01-01 01:00:00)
		rtime 1713716482.158541435 (2024-04-21 18:21:22)
	item 19 key (280 ROOT_BACKREF 5) itemoff 11521 itemsize 35
		root backref key dirid 267 sequence 15 name 2024-04-19_1_live
	item 20 key (281 ROOT_ITEM 2668) itemoff 11082 itemsize 439
		generation 2687 root_dirid 256 bytenr 30474240 byte_limit 0 bytes_used 13=
29364992
		last_snapshot 2687 flags 0x1(RDONLY) refs 1
		drop_progress key (0 UNKNOWN.0 0) drop_level 0
		level 2 generation_v2 2687
		uuid 3115d678-2d73-bb42-9464-bf407bb358b2
		parent_uuid 0374c3e1-d12d-ee41-bbb5-446c5c06aa18
		received_uuid 88f47c74-e45a-1346-9696-e2801ff0dc27
		ctransid 2685 otransid 2668 stransid 653464 rtransid 2683
		ctime 1716492262.163006721 (2024-05-23 21:24:22)
		otime 1716491269.43776512 (2024-05-23 21:07:49)
		stime 0.0 (1970-01-01 01:00:00)
		rtime 1716492224.830899042 (2024-05-23 21:23:44)
	item 21 key (281 ROOT_BACKREF 5) itemoff 11052 itemsize 30
		root backref key dirid 267 sequence 16 name 2024-05-22_1
	item 22 key (282 ROOT_ITEM 2687) itemoff 10613 itemsize 439
		generation 2715 root_dirid 256 bytenr 30490624 byte_limit 0 bytes_used 13=
68457216
		last_snapshot 2715 flags 0x1(RDONLY) refs 1
		drop_progress key (0 UNKNOWN.0 0) drop_level 0
		level 2 generation_v2 2715
		uuid 74b15f22-5aae-3848-8ecd-c07e4ceceb39
		parent_uuid 3115d678-2d73-bb42-9464-bf407bb358b2
		received_uuid 3899eff4-e4c2-6b43-82f3-0b9fff5f0e33
		ctransid 2713 otransid 2687 stransid 743201 rtransid 2710
		ctime 1723677233.966537778 (2024-08-15 01:13:53)
		otime 1723675608.338081817 (2024-08-15 00:46:48)
		stime 0.0 (1970-01-01 01:00:00)
		rtime 1723677194.866098398 (2024-08-15 01:13:14)
	item 23 key (282 ROOT_BACKREF 5) itemoff 10578 itemsize 35
		root backref key dirid 267 sequence 17 name 2024-08-14_1_live
	item 24 key (283 ROOT_ITEM 2715) itemoff 10139 itemsize 439
		generation 2722 root_dirid 256 bytenr 30507008 byte_limit 0 bytes_used 13=
28660480
		last_snapshot 2722 flags 0x1(RDONLY) refs 1
		drop_progress key (0 UNKNOWN.0 0) drop_level 0
		level 2 generation_v2 2722
		uuid c897c839-34f7-0c48-8a25-93e3f2004ead
		parent_uuid 74b15f22-5aae-3848-8ecd-c07e4ceceb39
		received_uuid 98cda6a1-57d0-ae4d-8792-ab5d6a97bfc6
		ctransid 2720 otransid 2715 stransid 752535 rtransid 2717
		ctime 1724354513.950765603 (2024-08-22 21:21:53)
		otime 1724354362.317774160 (2024-08-22 21:19:22)
		stime 0.0 (1970-01-01 01:00:00)
		rtime 1724354471.49047425 (2024-08-22 21:21:11)
	item 25 key (283 ROOT_BACKREF 5) itemoff 10104 itemsize 35
		root backref key dirid 267 sequence 18 name 2024-08-22_3_live
	item 26 key (284 ROOT_ITEM 2722) itemoff 9665 itemsize 439
		generation 2737 root_dirid 256 bytenr 30588928 byte_limit 0 bytes_used 15=
62165248
		last_snapshot 2737 flags 0x1(RDONLY) refs 1
		drop_progress key (0 UNKNOWN.0 0) drop_level 0
		level 2 generation_v2 2737
		uuid 3d26041e-17a4-ed4e-a6a3-6005a4172a69
		parent_uuid c897c839-34f7-0c48-8a25-93e3f2004ead
		received_uuid 14cd4187-7ca3-fb4b-9a4f-3a564ba983de
		ctransid 2734 otransid 2722 stransid 769059 rtransid 2732
		ctime 1725729488.300644782 (2024-09-07 19:18:08)
		otime 1725728529.381918112 (2024-09-07 19:02:09)
		stime 0.0 (1970-01-01 01:00:00)
		rtime 1725729456.746595666 (2024-09-07 19:17:36)
	item 27 key (284 ROOT_BACKREF 5) itemoff 9630 itemsize 35
		root backref key dirid 267 sequence 19 name 2024-09-07_1_live
	item 28 key (285 ROOT_ITEM 2737) itemoff 9191 itemsize 439
		generation 2755 root_dirid 256 bytenr 30605312 byte_limit 0 bytes_used 15=
93163776
		last_snapshot 2755 flags 0x1(RDONLY) refs 1
		drop_progress key (0 UNKNOWN.0 0) drop_level 0
		level 2 generation_v2 2755
		uuid dca0440b-a8e1-7f48-b3aa-f7b8400b5a22
		parent_uuid 3d26041e-17a4-ed4e-a6a3-6005a4172a69
		received_uuid b0dae321-8f29-2a40-819a-8c66340ebe0d
		ctransid 2754 otransid 2737 stransid 803143 rtransid 2752
		ctime 1729607589.683406445 (2024-10-22 16:33:09)
		otime 1729606370.169174110 (2024-10-22 16:12:50)
		stime 0.0 (1970-01-01 01:00:00)
		rtime 1729607550.250730507 (2024-10-22 16:32:30)
	item 29 key (285 ROOT_BACKREF 5) itemoff 9156 itemsize 35
		root backref key dirid 267 sequence 20 name 2024-10-22_1_live
	item 30 key (286 ROOT_ITEM 2755) itemoff 8717 itemsize 439
		generation 2784 root_dirid 256 bytenr 1936533274624 byte_limit 0 bytes_us=
ed 1623359488
		last_snapshot 2784 flags 0x1(RDONLY) refs 1
		drop_progress key (0 UNKNOWN.0 0) drop_level 0
		level 2 generation_v2 2784
		uuid c960f3ce-54ef-9245-9d0b-3c11768476b8
		parent_uuid dca0440b-a8e1-7f48-b3aa-f7b8400b5a22
		received_uuid 52854293-e7ad-6144-8b0c-d747c435035c
		ctransid 2766 otransid 2755 stransid 844110 rtransid 2764
		ctime 1732555951.649613336 (2024-11-25 18:32:31)
		otime 1732555260.314901494 (2024-11-25 18:21:00)
		stime 0.0 (1970-01-01 01:00:00)
		rtime 1732555901.391354339 (2024-11-25 18:31:41)
	item 31 key (286 ROOT_BACKREF 5) itemoff 8682 itemsize 35
		root backref key dirid 267 sequence 21 name 2024-11-24_1_live
	item 32 key (287 ROOT_ITEM 2784) itemoff 8243 itemsize 439
		generation 2829 root_dirid 256 bytenr 30736384 byte_limit 0 bytes_used 16=
57372672
		last_snapshot 2829 flags 0x1(RDONLY) refs 1
		drop_progress key (0 UNKNOWN.0 0) drop_level 0
		level 2 generation_v2 2829
		uuid d85dceb9-33a4-244a-9535-3ebeb95feb25
		parent_uuid c960f3ce-54ef-9245-9d0b-3c11768476b8
		received_uuid 2bec8139-bb0b-7745-98e2-f5e2b44ffff6
		ctransid 2802 otransid 2784 stransid 899043 rtransid 2799
		ctime 1736893395.322042592 (2025-01-14 23:23:15)
		otime 1736891736.184284935 (2025-01-14 22:55:36)
		stime 0.0 (1970-01-01 01:00:00)
		rtime 1736893332.661428424 (2025-01-14 23:22:12)
	item 33 key (287 ROOT_BACKREF 5) itemoff 8208 itemsize 35
		root backref key dirid 267 sequence 22 name 2025-01-14_1_live
	item 34 key (288 ROOT_ITEM 2820) itemoff 7769 itemsize 439
		generation 2828 root_dirid 256 bytenr 11322400604160 byte_limit 0 bytes_u=
sed 1675493376
		last_snapshot 2820 flags 0x1(RDONLY) refs 1
		drop_progress key (0 UNKNOWN.0 0) drop_level 0
		level 2 generation_v2 2828
		uuid ec1bf2a1-d363-cd42-8b6c-5c757c005bd3
		parent_uuid d85dceb9-33a4-244a-9535-3ebeb95feb25
		received_uuid df08f225-2c47-e14e-8d3a-e1b6958df9f5
		ctransid 2828 otransid 2820 stransid 936026 rtransid 2827
		ctime 1740329700.899958817 (2025-02-23 17:55:00)
		otime 1740327358.730742602 (2025-02-23 17:15:58)
		stime 0.0 (1970-01-01 01:00:00)
		rtime 1740329243.876126309 (2025-02-23 17:47:23)
	item 35 key (288 ROOT_BACKREF 5) itemoff 7734 itemsize 35
		root backref key dirid 267 sequence 23 name 2025-02-23_2_live
	item 36 key (289 ROOT_ITEM 2829) itemoff 7295 itemsize 439
		generation 2847 root_dirid 256 bytenr 30654464 byte_limit 0 bytes_used 16=
72478720
		last_snapshot 2847 flags 0x1(RDONLY) refs 1
		drop_progress key (0 UNKNOWN.0 0) drop_level 0
		level 2 generation_v2 2847
		uuid 3aa7371e-d1c3-af4f-a3b0-02ce0505504e
		parent_uuid d85dceb9-33a4-244a-9535-3ebeb95feb25
		received_uuid ac7b5b54-fcb2-5041-8fb0-e4ca1c891a94
		ctransid 2846 otransid 2829 stransid 1005789 rtransid 2845
		ctime 1746751590.94994411 (2025-05-09 02:46:30)
		otime 1746748099.138038540 (2025-05-09 01:48:19)
		stime 0.0 (1970-01-01 01:00:00)
		rtime 1746751472.678993995 (2025-05-09 02:44:32)
	item 37 key (289 ROOT_BACKREF 5) itemoff 7260 itemsize 35
		root backref key dirid 267 sequence 24 name 2025-05-09_1_live
	item 38 key (290 ROOT_ITEM 2847) itemoff 6821 itemsize 439
		generation 2861 root_dirid 256 bytenr 30752768 byte_limit 0 bytes_used 18=
57748992
		last_snapshot 2861 flags 0x1(RDONLY) refs 1
		drop_progress key (0 UNKNOWN.0 0) drop_level 0
		level 2 generation_v2 2861
		uuid 1b90355d-65ae-8949-9d96-3a1f49931e43
		parent_uuid 3aa7371e-d1c3-af4f-a3b0-02ce0505504e
		received_uuid 38acbd40-4a17-bb4b-a111-86b77a2e41b4
		ctransid 2860 otransid 2847 stransid 1032437 rtransid 2858
		ctime 1749589557.710925796 (2025-06-10 23:05:57)
		otime 1749587880.693642910 (2025-06-10 22:38:00)
		stime 0.0 (1970-01-01 01:00:00)
		rtime 1749589481.482609679 (2025-06-10 23:04:41)
	item 39 key (290 ROOT_BACKREF 5) itemoff 6786 itemsize 35
		root backref key dirid 267 sequence 25 name 2025-06-07_1_live
	item 40 key (291 ROOT_ITEM 2861) itemoff 6347 itemsize 439
		generation 2870 root_dirid 256 bytenr 30883840 byte_limit 0 bytes_used 18=
58289664
		last_snapshot 2870 flags 0x1(RDONLY) refs 1
		drop_progress key (0 UNKNOWN.0 0) drop_level 0
		level 2 generation_v2 2870
		uuid 7de5c39b-4861-4e40-917a-8a54fa188b0b
		parent_uuid 1b90355d-65ae-8949-9d96-3a1f49931e43
		received_uuid f69333e9-f276-074c-814d-2a12e31d2a42
		ctransid 2869 otransid 2861 stransid 1095168 rtransid 2867
		ctime 1753652119.427269578 (2025-07-27 23:35:19)
		otime 1753650765.453298664 (2025-07-27 23:12:45)
		stime 0.0 (1970-01-01 01:00:00)
		rtime 1753652086.981101594 (2025-07-27 23:34:46)
	item 41 key (291 ROOT_BACKREF 5) itemoff 6312 itemsize 35
		root backref key dirid 267 sequence 26 name 2025-07-27_1_live
	item 42 key (292 ROOT_ITEM 2870) itemoff 5873 itemsize 439
		generation 2883 root_dirid 256 bytenr 30916608 byte_limit 0 bytes_used 15=
44667136
		last_snapshot 2883 flags 0x1(RDONLY) refs 1
		drop_progress key (0 UNKNOWN.0 0) drop_level 0
		level 2 generation_v2 2883
		uuid e8a867d4-cb9f-964b-a790-e4c36bfa7a8a
		parent_uuid 7de5c39b-4861-4e40-917a-8a54fa188b0b
		received_uuid cb33ae2b-2945-dc46-859b-aab6b635ad1b
		ctransid 2881 otransid 2870 stransid 1147542 rtransid 2880
		ctime 1757104798.128137778 (2025-09-05 22:39:58)
		otime 1757103880.649176097 (2025-09-05 22:24:40)
		stime 0.0 (1970-01-01 01:00:00)
		rtime 1757104634.88275990 (2025-09-05 22:37:14)
	item 43 key (292 ROOT_BACKREF 5) itemoff 5838 itemsize 35
		root backref key dirid 267 sequence 27 name 2025-09-05_1_live
	item 44 key (293 ROOT_ITEM 2883) itemoff 5399 itemsize 439
		generation 2892 root_dirid 256 bytenr 30965760 byte_limit 0 bytes_used 15=
84087040
		last_snapshot 2892 flags 0x1(RDONLY) refs 1
		drop_progress key (0 UNKNOWN.0 0) drop_level 0
		level 2 generation_v2 2892
		uuid 971d80b4-bc23-9040-b182-050bc5dc62f9
		parent_uuid e8a867d4-cb9f-964b-a790-e4c36bfa7a8a
		received_uuid 46887243-8712-9f42-a0c3-b7bf05b75ecd
		ctransid 2891 otransid 2883 stransid 1178903 rtransid 2888
		ctime 1759264775.93663767 (2025-09-30 22:39:35)
		otime 1759263633.896114075 (2025-09-30 22:20:33)
		stime 0.0 (1970-01-01 01:00:00)
		rtime 1759264716.34274437 (2025-09-30 22:38:36)
	item 45 key (293 ROOT_BACKREF 5) itemoff 5364 itemsize 35
		root backref key dirid 267 sequence 28 name 2025-09-30_1_live
	item 46 key (294 ROOT_ITEM 2892) itemoff 4925 itemsize 439
		generation 2903 root_dirid 256 bytenr 30982144 byte_limit 0 bytes_used 16=
72282112
		last_snapshot 2903 flags 0x1(RDONLY) refs 1
		drop_progress key (0 UNKNOWN.0 0) drop_level 0
		level 2 generation_v2 2903
		uuid 046a67df-7319-174f-b008-5eb9cfb6072f
		parent_uuid 971d80b4-bc23-9040-b182-050bc5dc62f9
		received_uuid 03a6ac27-c8eb-6f45-ab10-2ef6b552db85
		ctransid 2902 otransid 2892 stransid 1216590 rtransid 2900
		ctime 1762191180.211993738 (2025-11-03 18:33:00)
		otime 1762188534.712841975 (2025-11-03 17:48:54)
		stime 0.0 (1970-01-01 01:00:00)
		rtime 1762191133.182883745 (2025-11-03 18:32:13)
	item 47 key (294 ROOT_BACKREF 5) itemoff 4890 itemsize 35
		root backref key dirid 267 sequence 29 name 2025-11-03_1_live
	item 48 key (295 ROOT_ITEM 2903) itemoff 4451 itemsize 439
		generation 2928 root_dirid 256 bytenr 11534202617856 byte_limit 0 bytes_u=
sed 1707016192
		last_snapshot 2903 flags 0x1(RDONLY) refs 1
		drop_progress key (0 UNKNOWN.0 0) drop_level 0
		level 2 generation_v2 2928
		uuid 98e1fa38-96b6-8c46-8e0a-45667b27b88a
		parent_uuid 046a67df-7319-174f-b008-5eb9cfb6072f
		received_uuid 2cdf09e0-9aff-c64c-b43b-df529e637c22
		ctransid 2928 otransid 2903 stransid 1283544 rtransid 2927
		ctime 1768589600.758013589 (2026-01-16 19:53:20)
		otime 1768586381.930525587 (2026-01-16 18:59:41)
		stime 0.0 (1970-01-01 01:00:00)
		rtime 1768589513.923083173 (2026-01-16 19:51:53)
	item 49 key (295 ROOT_BACKREF 5) itemoff 4416 itemsize 35
		root backref key dirid 267 sequence 30 name 2026-01-16_1_live
	item 50 key (DATA_RELOC_TREE ROOT_ITEM 0) itemoff 3977 itemsize 439
		generation 5 root_dirid 256 bytenr 30523392 byte_limit 0 bytes_used 16384
		last_snapshot 0 flags 0x0(none) refs 1
		drop_progress key (0 UNKNOWN.0 0) drop_level 0
		level 0 generation_v2 5
		uuid 00000000-0000-0000-0000-000000000000
		parent_uuid 00000000-0000-0000-0000-000000000000
		received_uuid 00000000-0000-0000-0000-000000000000
		ctransid 0 otransid 0 stransid 0 rtransid 0
		ctime 0.0 (1970-01-01 01:00:00)
		otime 0.0 (1970-01-01 01:00:00)
		stime 0.0 (1970-01-01 01:00:00)
		rtime 0.0 (1970-01-01 01:00:00)




Any ideas?

And after we'd have done any bug finding, if you think that's
necessary,... would you rather recommend to trash the fs?
That one is small and really easy for me to re-create.


Thanks,
Chris.

