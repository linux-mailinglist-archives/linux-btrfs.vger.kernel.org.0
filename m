Return-Path: <linux-btrfs+bounces-11326-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD30A2AE83
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Feb 2025 18:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EFE5165759
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Feb 2025 17:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B597239574;
	Thu,  6 Feb 2025 17:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=merlins.org header.i=@merlins.org header.b="OWGh0jNY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630D623956A
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Feb 2025 17:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.81.13.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738861655; cv=none; b=pOla9t07+IZIn8tEKu367sZ1Wa4ylH4xjwdz0H8j7m69BfgoUqzq94p30XdOxAAGUhCZ/uTtN9muHGNZmIeGVgLJQOKlkjD+UdsAd5FMNmwx5AjjgbDnIRxlFQdgcw3jHu3Xxm99/1Ff1lXVvOfjA7G3ctpZPPYSYU4meFC2yDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738861655; c=relaxed/simple;
	bh=4AR6jl9ZOANS05B46dvC6nlrj/HHxFFgyxcVmJ12hag=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QVZoJABpDhtUnRNilkSq2+AVB1kqyWxtzSR2JfNh5c7M3oLnDQZz8YR/gS9ppCK1gzqU+dVb5NJ9pH3oBsGNgnhZIZw2dG572V3S5n3cFVYVTOZao0MbqgZ0ivCJtOwgiL2/6nllBLwNBLq15KgYx/FHlGgee81FpvEzWTWp978=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=merlins.org; spf=pass smtp.mailfrom=merlins.org; dkim=fail (0-bit key) header.d=merlins.org header.i=@merlins.org header.b=OWGh0jNY reason="key not found in DNS"; arc=none smtp.client-ip=209.81.13.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=merlins.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=merlins.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=merlins.org
	; s=key; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Subject:To:From:Date:Sender:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=eQhvZiGnyD8O41UM1RKTkhOhWt0iu7dvJAWIneBOOx0=; b=OWGh0jNY+f7WHnOAtneDiUZCyg
	Lzmix9dVEufWQBe/KAmj6F0EPXvRjKnr+OH2u3dSZlUYUJ+XNbF2VsHjUWFuTTAaCIWjOKiAH1FxT
	L36t/CkqunHFtdg23RobI/c/nQQW4V2iuSrGsBzdeDrweQRjWniDmj4ljZvKmWmg6q4mmd4wDmQ7Z
	VjsYyf6rzbUm6jtpe8Wsh59Pxwv/CQMX6aICC5no9GMwjk5LdqKCoxG7N6vu6NbWxXUWHgnd2quSi
	DmwJlWloJiaYt81ikOP3HPgkFz3Ak6VaXLbab2clPW8GuRZWpsRD0cyugIkakr+PrwBypldxCYHji
	MDl4bsGg==;
Received: from [204.250.24.206] (port=39543 helo=sauron.svh.merlins.org)
	by mail1.merlins.org with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
	id 1tg3zM-0006LZ-T2 by authid <merlins.org> with srv_auth_plain; Thu, 06 Feb 2025 09:07:31 -0800
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.96)
	(envelope-from <marc@merlins.org>)
	id 1tg5Lf-0003px-0t;
	Thu, 06 Feb 2025 09:07:31 -0800
Date: Thu, 6 Feb 2025 09:07:31 -0800
From: Marc MERLIN <marc@merlins.org>
To: linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: BTRFS error (device dm-4): failed to run delayed ref for logical
 350223581184 num_bytes 16384 type 176 action 1 ref_mod 1: -117 (kernel
 6.11.2)
Message-ID: <Z6TsUwR7tyKJrZ7w@merlins.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-Sysadmin: BOFH
X-URL: http://marc.merlins.org/
X-Broken-Reverse-DNS: no host name for IP address 204.250.24.206
X-SA-Exim-Connect-IP: 204.250.24.206
X-SA-Exim-Mail-From: marc@merlins.org

Balance ended with btrfs_run_delayed_refs:2199: errno=3D-117 Filesystem cor=
rupted

btrfs check says it's not
sauron:~# btrfs check /dev/mapper/pool1
Opening filesystem to check...
Checking filesystem on /dev/mapper/pool1
UUID: 4542883b-d8bc-4d7f-8a2e-944dc355dc44
[1/7] checking root items
[2/7] checking extents
[3/7] checking free space tree
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups skipped (not enabled on this FS)
found 228820946944 bytes used, no error found
total csum bytes: 219270232
total tree bytes: 4539334656
total fs tree bytes: 3719593984
total extent tree bytes: 481935360
btree space waste bytes: 1075469196
file data blocks allocated: 15390875832320
 referenced 290833076224

Any ideas? this obviously caused downtime, but after the btrfs check saying=
 I'm supposedly
ok, I'm back up for now, hoping it won't happen again and hope is not a str=
ategy :)

Is it safe to run balance again? any idea why it failed?

[1821331.015652] BTRFS info (device dm-4): balance: start -dusage=3D20
[1821331.015805] BTRFS info (device dm-4): relocating block group 761212698=
624 flags data
[1821331.090338] BTRFS info (device dm-4): found 31 extents, stage: move da=
ta extents
[1821331.237707] BTRFS info (device dm-4): leaf 471333519360 gen 4808182 to=
tal ptrs 168 free space 3533 owner 2
[1821331.237716] 	item 0 key (350222417920 169 0) itemoff 16250 itemsize 33
[1821331.237718] 		extent refs 1 gen 2907391 flags 2
[1821331.237719] 		ref#0: tree block backref root 398
(...(
[1821331.238559] 	item 167 key (350225678336 169 0) itemoff 7733 itemsize 1=
68
[1821331.238560] 		extent refs 16 gen 4619087 flags 2
[1821331.238561] 		ref#0: tree block backref root 398
[1821331.238562] 		ref#1: shared block backref parent 737084112896
[1821331.238563] 		ref#2: shared block backref parent 736609173504
[1821331.238564] 		ref#3: shared block backref parent 471099588608
[1821331.238565] 		ref#4: shared block backref parent 471017488384
[1821331.238567] 		ref#5: shared block backref parent 470665625600
[1821331.238568] 		ref#6: shared block backref parent 350806835200
[1821331.238569] 		ref#7: shared block backref parent 350292066304
[1821331.238570] 		ref#8: shared block backref parent 349856350208
[1821331.238571] 		ref#9: shared block backref parent 153429573632
[1821331.238572] 		ref#10: shared block backref parent 153014337536
[1821331.238573] 		ref#11: shared block backref parent 152976048128
[1821331.238575] 		ref#12: shared block backref parent 152753946624
[1821331.238576] 		ref#13: shared block backref parent 152639225856
[1821331.238577] 		ref#14: shared block backref parent 50782617600
[1821331.238578] 		ref#15: shared block backref parent 394002432
[1821331.238579] BTRFS critical (device dm-4): adding refs to an existing t=
ree ref, bytenr 350223581184 num_bytes 16384 root_objectid 398 slot 51
[1821331.238582] BTRFS error (device dm-4): failed to run delayed ref for l=
ogical 350223581184 num_bytes 16384 type 176 action 1 ref_mod 1: -117
[1821331.238584] ------------[ cut here ]------------
[1821331.238585] BTRFS: Transaction aborted (error -117)
[1821331.238593] WARNING: CPU: 1 PID: 2457672 at fs/btrfs/extent-tree.c:219=
9 btrfs_run_delayed_refs+0x107/0x140
[1821331.238599] Modules linked in: mmc_block exfat uinput rpcsec_gss_krb5 =
nfsv4 dns_resolver nfs netfs sg uas usb_storage nf_conntrack_netlink xfrm_u=
ser xfrm_algo xt_addrtype br_netfilter bridge stp llc xt_tcpudp xt_conntrac=
k rfcomm snd_seq_dummy snd_hrtimer ccm overlay ipt_REJECT nf_reject_ipv4 xt=
_MASQUERADE xt_LOG nf_log_syslog nft_compat nft_chain_nat nf_nat nf_conntra=
ck nf_defrag_ipv6 nf_defrag_ipv4 cmac algif_hash algif_skcipher af_alg nf_t=
ables bnep binfmt_misc uvcvideo videobuf2_vmalloc uvc videobuf2_memops btus=
b videobuf2_v4l2 btrtl btbcm videodev btmtk btintel videobuf2_common mc blu=
etooth nls_utf8 nls_cp437 vfat fat squashfs loop snd_hda_codec_hdmi iwlmvm =
snd_hda_codec_realtek snd_hda_codec_generic snd_soc_dmic snd_hda_scodec_com=
ponent mac80211 intel_uncore_frequency snd_sof_pci_intel_tgl intel_uncore_f=
requency_common snd_sof_pci_intel_cnl intel_tcc_cooling snd_sof_intel_hda_g=
eneric snd_sof_intel_hda_common x86_pkg_temp_thermal snd_sof_intel_hda inte=
l_powerclamp libarc4 snd_sof_pci snd_sof_xtensa_dsp kvm_intel
[1821331.238644]  snd_soc_hdac_hda iwlwifi kvm thinkpad_acpi snd_soc_acpi_i=
ntel_match mei_hdcp mei_pxp snd_soc_acpi cfg80211 processor_thermal_device_=
pci_legacy nvram tpm_crb processor_thermal_device rapl platform_profile pro=
cessor_thermal_wt_hint processor_thermal_rfim snd_soc_avs processor_thermal=
_rapl ucsi_acpi intel_rapl_common nvidiafb processor_thermal_wt_req intel_c=
state think_lmi vgastate iTCO_wdt typec_ucsi snd_soc_hda_codec pcspkr proce=
ssor_thermal_power_floor firmware_attributes_class wmi_bmof snd_hda_intel e=
e1004 iTCO_vendor_support fb_ddc typec processor_thermal_mbox mei_me roles =
intel_soc_dts_iosf int3403_thermal rfkill int340x_thermal_zone ac intel_pmc=
_core intel_vsec tpm_tis tpm_tis_core int3400_thermal pmt_telemetry acpi_pa=
d intel_hid acpi_thermal_rel sparse_keymap pmt_class acpi_tad input_leds ev=
dev joydev serio_raw vboxdrv(OE) soundwire_intel soundwire_cadence snd_sof_=
intel_hda_mlink soundwire_generic_allocation snd_sof_probes snd_sof snd_sof=
_utils snd_intel_dspcfg snd_intel_sdw_acpi snd_soc_skl_hda_dsp
[1821331.238682]  snd_soc_intel_hda_dsp_common snd_hda_codec snd_hwdep snd_=
soc_hdac_hdmi snd_hda_ext_core snd_soc_core snd_compress snd_pcm_dmaengine =
snd_hda_core snd_pcm_oss snd_mixer_oss snd_pcm snd_seq_midi snd_seq_midi_ev=
ent snd_seq snd_timer snd_rawmidi snd_seq_device snd_ctl_led snd soundcore =
ac97_bus configs coretemp msr fuse efi_pstore nfsd auth_rpcgss nfs_acl lock=
d grace sunrpc nfnetlink ip_tables x_tables autofs4 essiv authenc dm_crypt =
trusted asn1_encoder tee tpm rng_core libaescfb ecdh_generic dm_mod ecc rai=
d456 async_raid6_recov async_memcpy async_pq async_xor async_tx sata_sil24 =
r8169 realtek mdio_devres libphy mii hid_generic usbhid hid i915 crct10dif_=
pclmul drm_buddy i2c_algo_bit rtsx_pci_sdmmc crc32_pclmul xhci_pci ttm mmc_=
core crc32c_intel xhci_hcd polyval_clmulni drm_display_helper polyval_gener=
ic usbcore cec i2c_i801 rc_core video ptp spi_intel_pci i2c_mux ghash_clmul=
ni_intel sha512_ssse3 sha256_ssse3 sha1_ssse3 psmouse thunderbolt rtsx_pci =
spi_intel i2c_smbus pps_core usb_common thermal hwmon battery
[1821331.238731]  wmi aesni_intel crypto_simd cryptd [last unloaded: igc]
[1821331.238737] CPU: 1 UID: 0 PID: 2457672 Comm: btrfs Tainted: G     U   =
  OE      6.11.2-amd64-preempt-sysrq-20241007 #1 1a512c2db5f087f236d90ecfb3=
0551fddcc51243
[1821331.238740] Tainted: [U]=3DUSER, [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODU=
LE
[1821331.238742] Hardware name: LENOVO 20YU002JUS/20YU002JUS, BIOS N37ET49W=
 (1.30 ) 11/15/2023
[1821331.238743] RIP: 0010:btrfs_run_delayed_refs+0x107/0x140
[1821331.238745] Code: 01 00 00 00 eb b6 e8 18 8e b7 00 31 db 89 d8 5b 5d 4=
1 5c 41 5d 41 5e c3 cc cc cc cc 89 de 48 c7 c7 40 bb b7 86 e8 f9 0c 9f ff <=
0f> 0b eb d0 66 66 2e 0f 1f 84 00 00 00 00 00 66 66 2e 0f 1f 84 00
[1821331.238747] RSP: 0018:ffffaf1a6f167858 EFLAGS: 00010282
[1821331.238749] RAX: 0000000000000000 RBX: 00000000ffffff8b RCX: 000000000=
0000027
[1821331.238750] RDX: ffff8fcf2f2a1848 RSI: 0000000000000001 RDI: ffff8fcf2=
f2a1840
[1821331.238752] RBP: ffff8fb06efb8150 R08: 0000000000000000 R09: 000000000=
0000003
[1821331.238753] R10: ffffaf1a6f1676f8 R11: ffff8fcfaf7d5028 R12: 000000000=
0000000
[1821331.238754] R13: ffff8fb146731358 R14: ffff8fb146731200 R15: 000000000=
0000000
[1821331.238755] FS:  00007fd91883d380(0000) GS:ffff8fcf2f280000(0000) knlG=
S:0000000000000000
[1821331.238756] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[1821331.238757] CR2: 00007e4901001000 CR3: 00000001c3cb6004 CR4: 000000000=
0770ef0
[1821331.238759] PKRU: 55555554
[1821331.238760] Call Trace:
[1821331.238762]  <TASK>
[1821331.238765]  ? __warn+0x7c/0x140
[1821331.238769]  ? btrfs_run_delayed_refs+0x107/0x140
[1821331.238771]  ? report_bug+0x160/0x1c0
[1821331.238774]  ? handle_bug+0x41/0x80
[1821331.238777]  ? exc_invalid_op+0x15/0x100
[1821331.238780]  ? asm_exc_invalid_op+0x16/0x40
[1821331.238783]  ? btrfs_run_delayed_refs+0x107/0x140
[1821331.238785]  ? btrfs_run_delayed_refs+0x107/0x140
[1821331.238786]  btrfs_commit_transaction+0x69/0xe80
[1821331.238790]  ? btrfs_update_reloc_root+0x12d/0x240
[1821331.238793]  prepare_to_merge+0x4f0/0x600
[1821331.238796]  relocate_block_group+0x113/0x500
[1821331.238798]  btrfs_relocate_block_group+0x27a/0x440
[1821331.238800]  btrfs_relocate_chunk+0x3b/0x180
[1821331.238803]  btrfs_balance+0x8c1/0x1340
[1821331.238805]  ? btrfs_ioctl+0x18db/0x26c0
[1821331.238811]  btrfs_ioctl+0x2285/0x26c0
[1821331.238813]  ? __mod_memcg_lruvec_state+0x91/0x140
[1821331.238817]  ? vsnprintf+0x323/0x580
[1821331.238819]  ? __slab_free+0x53/0x2c0
[1821331.238822]  ? sysfs_emit+0x68/0xc0
[1821331.238826]  __x64_sys_ioctl+0x90/0x100
[1821331.238830]  do_syscall_64+0x69/0x140
[1821331.238832]  ? __memcg_slab_free_hook+0xf3/0x140
[1821331.238835]  ? __x64_sys_close+0x38/0x80
[1821331.238838]  ? kmem_cache_free+0x336/0x400
[1821331.238840]  ? do_syscall_64+0x75/0x140
[1821331.238842]  ? ksys_read+0x63/0x100
[1821331.238845]  ? __mod_memcg_lruvec_state+0x91/0x140
[1821331.238848]  ? mod_objcg_state+0x19d/0x2c0
[1821331.238850]  ? __memcg_slab_free_hook+0xf3/0x140
[1821331.238852]  ? seq_release+0x24/0x40
[1821331.238854]  ? __memcg_slab_free_hook+0xf3/0x140
[1821331.238856]  ? __x64_sys_close+0x38/0x80
[1821331.238858]  ? kmem_cache_free+0x336/0x400
[1821331.238860]  ? clear_bhb_loop+0x45/0xc0
[1821331.238862]  ? clear_bhb_loop+0x45/0xc0
[1821331.238864]  ? clear_bhb_loop+0x45/0xc0
[1821331.238866]  ? clear_bhb_loop+0x45/0xc0
[1821331.238867]  ? clear_bhb_loop+0x45/0xc0
[1821331.238869]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[1821331.238872] RIP: 0033:0x7fd9189564bb
[1821331.238874] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 0=
0 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <=
89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
[1821331.238876] RSP: 002b:00007ffd5896d7a0 EFLAGS: 00000246 ORIG_RAX: 0000=
000000000010
[1821331.238878] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fd91=
89564bb
[1821331.238879] RDX: 00007ffd5896d8a8 RSI: 00000000c4009420 RDI: 000000000=
0000003
[1821331.238880] RBP: 0000000000000000 R08: 0000000000000073 R09: 000000000=
0000013
[1821331.238881] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffd5=
896d8a8
[1821331.238882] R13: 0000000000000000 R14: 00007ffd5896ee24 R15: 000000000=
0000001
[1821331.238884]  </TASK>
[1821331.238885] ---[ end trace 0000000000000000 ]---
[1821331.238886] BTRFS: error (device dm-4 state A) in btrfs_run_delayed_re=
fs:2199: errno=3D-117 Filesystem corrupted

--=20
"A mouse is a device used to point at the xterm you want to type in" - A.S.=
R.
=20
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AA=
F9D08

