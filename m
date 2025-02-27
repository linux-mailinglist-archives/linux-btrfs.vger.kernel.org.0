Return-Path: <linux-btrfs+bounces-11913-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48696A48643
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Feb 2025 18:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEAF5176266
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Feb 2025 17:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83DE61DB122;
	Thu, 27 Feb 2025 17:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="nPLbWaPu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="3b5gWVd6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641FE1A2C27
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Feb 2025 17:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740675714; cv=none; b=hmN2elTLwN4xKm/ABt277mB6yImxdWrUG1vJuhLgvBNNlNY2cFUHXB/P2pJDxlB7Rm1WYIKX1H2sS3eOy6jBxWp2moixnZC6+wnp8qiLNZjttbIhUn+et1WMSP6M+5zd/qiZ1elAy9bMDr/SqFIs+snn/IsS2ptCfXjIuU6JCVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740675714; c=relaxed/simple;
	bh=m/JPzNbmGKBv13dXBqpO4PW4z4oVdkPWE4pUgFqvzlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ajcIJyeyj0ejlQHgDTgikVCMzKfZZNBtZMpV6YX3euIo6qWIqgUkExtKPhZU7UEMhdJ0caZhEzmUXUGoK/2ItCJHQF+8QblIR2UmmvX36i33+n7l3gZSKY8UGgg10/4oyBlkW73GXTncdxzygzqPDEg0DgXTsjAmYw2wYPROC+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=nPLbWaPu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=3b5gWVd6; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 3553D1140098;
	Thu, 27 Feb 2025 12:01:50 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Thu, 27 Feb 2025 12:01:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1740675710;
	 x=1740762110; bh=FQR0FXECdXWTSS/P15Ssv0PyzGFJgTAFA6UUC2u/juE=; b=
	nPLbWaPurx1Tp3w4vEbUMFEr/xUG162etytUKGbp6geTT2R/w0RwEubtziGKlQm5
	YzyHpOuwgECa/Z8vzIuDEpSJ7prNlblEkeo2B55QbJopA93NWNQouja9JiwGJ1fd
	TJP1uvyMobIhfancU/j8a8XFJ64MgOr+TLWWhTd9aDg5l4Jl5ik2gQjr89wVqz4j
	JmV6k0p5j3JW0Zy/hYuZ0jf47kBLqw6y4JP1XyNC58THrfHd8d9XOIaC3F++ExQE
	tqlTgkVzYKwer3YWyJ1G0VRDFkMy5D3tOT0ZOTdEpRpmLaN84Mo9WtEU7HkfZPHa
	d5co2Zxro6cblWmfQyQoMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740675710; x=
	1740762110; bh=FQR0FXECdXWTSS/P15Ssv0PyzGFJgTAFA6UUC2u/juE=; b=3
	b5gWVd6WO+36r/fRUUvD+Pi/OFsBPEv4bX8Sug4PY60w6yOK1jjBIQc8u/8IU8mD
	0livy2IOQz42I1vVyMO+Hyh09Ix0HKGj3f9yMCXkJNyVkzaeuTUmBNmRIanpTb+F
	dpzKJvexoAAkITz0fdtzyXB+usdTaEdLMQTwMUCaDAjZ43JB76lNawjzt899P2MC
	ifIrLEA+DQT+cNtxw3ESYZ8XfX0vACAPAUk5utZuQfiZcuqMg4ggNxBthX7HxIVO
	LahpAT9DS0UIBM36HDqaPvGZ2jwKgXpoyltrw2VVU1czPNA7DOOWOnCksqqZ9lkr
	eZCq1K4fJnPI1qgrbMtFw==
X-ME-Sender: <xms:fZrAZ7yyfdTxzxu2wrtMQHF0roqy0_bmBHPIfx86Y6gQ7E6CM_UojQ>
    <xme:fZrAZzQeYH02PqQlwHWqhwj_R4NqPj1O2VdsMtEHu7a8_VWRZ9F_wPL2RnL3jYBX4
    YbX4lAYxPqItrveD08>
X-ME-Received: <xmr:fZrAZ1XsX6SOZjVlnFj-kc7dMP8WHSWfABxnF0EhtcT9R5pSMwpzfJ1r1OpCJq6PmCGBfhPUOSQ8w0Q9Q22QrDUvtLw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekkedttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthhqredttddt
    vdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihhoqe
    enucggtffrrghtthgvrhhnpeduvdetuedvueffieduveeltefhjeevtddtuefhveffveeu
    geetkeelleethefggeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhmvghrlhhinh
    hsrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopedvpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehmrghrtgesmhgvrhhlihhnshdrohhrghdprhgtphhtthho
    pehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:fZrAZ1hqawQsl5GH_oXtRxkeNuI5yyQZApSEdsla17rK3k7jCNlX_A>
    <xmx:fZrAZ9Abq_jBlgPTYmBXQN5O7Fh74padUgnkWsDgaPlSIajhS2XGOg>
    <xmx:fZrAZ-JTfiD8RUGRSA0OpVSHkz_2RTW3UyCHsZpTQ8iakjqVpoHp1g>
    <xmx:fZrAZ8BUHBhb26DgJBuhNN0Opf_hTCB0asgJ9O9g3cizrmIkZQFoZg>
    <xmx:fprAZwPTL0YVCLBresirwUodhfDOmQABZbscP-pW5AidD6y7Pi9HLqcc>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Feb 2025 12:01:49 -0500 (EST)
Date: Thu, 27 Feb 2025 09:02:20 -0800
From: Boris Burkov <boris@bur.io>
To: Marc MERLIN <marc@merlins.org>
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: BTRFS error (device dm-4): failed to run delayed ref for logical
 350223581184 num_bytes 16384 type 176 action 1 ref_mod 1: -117 (kernel
 6.11.2)
Message-ID: <20250227170220.GA2202481@zen.localdomain>
References: <Z6TsUwR7tyKJrZ7w@merlins.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <Z6TsUwR7tyKJrZ7w@merlins.org>

On Thu, Feb 06, 2025 at 09:07:31AM -0800, Marc MERLIN wrote:
> Balance ended with btrfs_run_delayed_refs:2199: errno=3D-117 Filesystem c=
orrupted
>=20
> btrfs check says it's not
> sauron:~# btrfs check /dev/mapper/pool1
> Opening filesystem to check...
> Checking filesystem on /dev/mapper/pool1
> UUID: 4542883b-d8bc-4d7f-8a2e-944dc355dc44
> [1/7] checking root items
> [2/7] checking extents
> [3/7] checking free space tree
> [4/7] checking fs roots
> [5/7] checking only csums items (without verifying data)
> [6/7] checking root refs
> [7/7] checking quota groups skipped (not enabled on this FS)
> found 228820946944 bytes used, no error found
> total csum bytes: 219270232
> total tree bytes: 4539334656
> total fs tree bytes: 3719593984
> total extent tree bytes: 481935360
> btree space waste bytes: 1075469196
> file data blocks allocated: 15390875832320
>  referenced 290833076224
>=20
> Any ideas? this obviously caused downtime, but after the btrfs check sayi=
ng I'm supposedly
> ok, I'm back up for now, hoping it won't happen again and hope is not a s=
trategy :)

I haven't carefully read the entire thread because it looks like it was
focused on memtest stuff, so apologies if I missed something.

This looks exactly like a bug Josef and I debugged extensively last
year.

https://lore.kernel.org/linux-btrfs/68766e66ed15ca2e7550585ed09434249db912a=
2.1727212293.git.josef@toxicpanda.com/
and
https://lore.kernel.org/linux-btrfs/fc61fb63e534111f5837c204ec341c876637af6=
9.1731513908.git.josef@toxicpanda.com/

I'll dig through the rest of the emails now, confirm whether you have
the fixes, etc. but just wanted to get that on your radar.

Boris

>=20
> Is it safe to run balance again? any idea why it failed?
>=20
> [1821331.015652] BTRFS info (device dm-4): balance: start -dusage=3D20
> [1821331.015805] BTRFS info (device dm-4): relocating block group 7612126=
98624 flags data
> [1821331.090338] BTRFS info (device dm-4): found 31 extents, stage: move =
data extents
> [1821331.237707] BTRFS info (device dm-4): leaf 471333519360 gen 4808182 =
total ptrs 168 free space 3533 owner 2
> [1821331.237716] 	item 0 key (350222417920 169 0) itemoff 16250 itemsize =
33
> [1821331.237718] 		extent refs 1 gen 2907391 flags 2
> [1821331.237719] 		ref#0: tree block backref root 398
> (...(
> [1821331.238559] 	item 167 key (350225678336 169 0) itemoff 7733 itemsize=
 168
> [1821331.238560] 		extent refs 16 gen 4619087 flags 2
> [1821331.238561] 		ref#0: tree block backref root 398
> [1821331.238562] 		ref#1: shared block backref parent 737084112896
> [1821331.238563] 		ref#2: shared block backref parent 736609173504
> [1821331.238564] 		ref#3: shared block backref parent 471099588608
> [1821331.238565] 		ref#4: shared block backref parent 471017488384
> [1821331.238567] 		ref#5: shared block backref parent 470665625600
> [1821331.238568] 		ref#6: shared block backref parent 350806835200
> [1821331.238569] 		ref#7: shared block backref parent 350292066304
> [1821331.238570] 		ref#8: shared block backref parent 349856350208
> [1821331.238571] 		ref#9: shared block backref parent 153429573632
> [1821331.238572] 		ref#10: shared block backref parent 153014337536
> [1821331.238573] 		ref#11: shared block backref parent 152976048128
> [1821331.238575] 		ref#12: shared block backref parent 152753946624
> [1821331.238576] 		ref#13: shared block backref parent 152639225856
> [1821331.238577] 		ref#14: shared block backref parent 50782617600
> [1821331.238578] 		ref#15: shared block backref parent 394002432
> [1821331.238579] BTRFS critical (device dm-4): adding refs to an existing=
 tree ref, bytenr 350223581184 num_bytes 16384 root_objectid 398 slot 51
> [1821331.238582] BTRFS error (device dm-4): failed to run delayed ref for=
 logical 350223581184 num_bytes 16384 type 176 action 1 ref_mod 1: -117
> [1821331.238584] ------------[ cut here ]------------
> [1821331.238585] BTRFS: Transaction aborted (error -117)
> [1821331.238593] WARNING: CPU: 1 PID: 2457672 at fs/btrfs/extent-tree.c:2=
199 btrfs_run_delayed_refs+0x107/0x140
> [1821331.238599] Modules linked in: mmc_block exfat uinput rpcsec_gss_krb=
5 nfsv4 dns_resolver nfs netfs sg uas usb_storage nf_conntrack_netlink xfrm=
_user xfrm_algo xt_addrtype br_netfilter bridge stp llc xt_tcpudp xt_conntr=
ack rfcomm snd_seq_dummy snd_hrtimer ccm overlay ipt_REJECT nf_reject_ipv4 =
xt_MASQUERADE xt_LOG nf_log_syslog nft_compat nft_chain_nat nf_nat nf_connt=
rack nf_defrag_ipv6 nf_defrag_ipv4 cmac algif_hash algif_skcipher af_alg nf=
_tables bnep binfmt_misc uvcvideo videobuf2_vmalloc uvc videobuf2_memops bt=
usb videobuf2_v4l2 btrtl btbcm videodev btmtk btintel videobuf2_common mc b=
luetooth nls_utf8 nls_cp437 vfat fat squashfs loop snd_hda_codec_hdmi iwlmv=
m snd_hda_codec_realtek snd_hda_codec_generic snd_soc_dmic snd_hda_scodec_c=
omponent mac80211 intel_uncore_frequency snd_sof_pci_intel_tgl intel_uncore=
_frequency_common snd_sof_pci_intel_cnl intel_tcc_cooling snd_sof_intel_hda=
_generic snd_sof_intel_hda_common x86_pkg_temp_thermal snd_sof_intel_hda in=
tel_powerclamp libarc4 snd_sof_pci snd_sof_xtensa_dsp kvm_intel
> [1821331.238644]  snd_soc_hdac_hda iwlwifi kvm thinkpad_acpi snd_soc_acpi=
_intel_match mei_hdcp mei_pxp snd_soc_acpi cfg80211 processor_thermal_devic=
e_pci_legacy nvram tpm_crb processor_thermal_device rapl platform_profile p=
rocessor_thermal_wt_hint processor_thermal_rfim snd_soc_avs processor_therm=
al_rapl ucsi_acpi intel_rapl_common nvidiafb processor_thermal_wt_req intel=
_cstate think_lmi vgastate iTCO_wdt typec_ucsi snd_soc_hda_codec pcspkr pro=
cessor_thermal_power_floor firmware_attributes_class wmi_bmof snd_hda_intel=
 ee1004 iTCO_vendor_support fb_ddc typec processor_thermal_mbox mei_me role=
s intel_soc_dts_iosf int3403_thermal rfkill int340x_thermal_zone ac intel_p=
mc_core intel_vsec tpm_tis tpm_tis_core int3400_thermal pmt_telemetry acpi_=
pad intel_hid acpi_thermal_rel sparse_keymap pmt_class acpi_tad input_leds =
evdev joydev serio_raw vboxdrv(OE) soundwire_intel soundwire_cadence snd_so=
f_intel_hda_mlink soundwire_generic_allocation snd_sof_probes snd_sof snd_s=
of_utils snd_intel_dspcfg snd_intel_sdw_acpi snd_soc_skl_hda_dsp
> [1821331.238682]  snd_soc_intel_hda_dsp_common snd_hda_codec snd_hwdep sn=
d_soc_hdac_hdmi snd_hda_ext_core snd_soc_core snd_compress snd_pcm_dmaengin=
e snd_hda_core snd_pcm_oss snd_mixer_oss snd_pcm snd_seq_midi snd_seq_midi_=
event snd_seq snd_timer snd_rawmidi snd_seq_device snd_ctl_led snd soundcor=
e ac97_bus configs coretemp msr fuse efi_pstore nfsd auth_rpcgss nfs_acl lo=
ckd grace sunrpc nfnetlink ip_tables x_tables autofs4 essiv authenc dm_cryp=
t trusted asn1_encoder tee tpm rng_core libaescfb ecdh_generic dm_mod ecc r=
aid456 async_raid6_recov async_memcpy async_pq async_xor async_tx sata_sil2=
4 r8169 realtek mdio_devres libphy mii hid_generic usbhid hid i915 crct10di=
f_pclmul drm_buddy i2c_algo_bit rtsx_pci_sdmmc crc32_pclmul xhci_pci ttm mm=
c_core crc32c_intel xhci_hcd polyval_clmulni drm_display_helper polyval_gen=
eric usbcore cec i2c_i801 rc_core video ptp spi_intel_pci i2c_mux ghash_clm=
ulni_intel sha512_ssse3 sha256_ssse3 sha1_ssse3 psmouse thunderbolt rtsx_pc=
i spi_intel i2c_smbus pps_core usb_common thermal hwmon battery
> [1821331.238731]  wmi aesni_intel crypto_simd cryptd [last unloaded: igc]
> [1821331.238737] CPU: 1 UID: 0 PID: 2457672 Comm: btrfs Tainted: G     U =
    OE      6.11.2-amd64-preempt-sysrq-20241007 #1 1a512c2db5f087f236d90ecf=
b30551fddcc51243
> [1821331.238740] Tainted: [U]=3DUSER, [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MO=
DULE
> [1821331.238742] Hardware name: LENOVO 20YU002JUS/20YU002JUS, BIOS N37ET4=
9W (1.30 ) 11/15/2023
> [1821331.238743] RIP: 0010:btrfs_run_delayed_refs+0x107/0x140
> [1821331.238745] Code: 01 00 00 00 eb b6 e8 18 8e b7 00 31 db 89 d8 5b 5d=
 41 5c 41 5d 41 5e c3 cc cc cc cc 89 de 48 c7 c7 40 bb b7 86 e8 f9 0c 9f ff=
 <0f> 0b eb d0 66 66 2e 0f 1f 84 00 00 00 00 00 66 66 2e 0f 1f 84 00
> [1821331.238747] RSP: 0018:ffffaf1a6f167858 EFLAGS: 00010282
> [1821331.238749] RAX: 0000000000000000 RBX: 00000000ffffff8b RCX: 0000000=
000000027
> [1821331.238750] RDX: ffff8fcf2f2a1848 RSI: 0000000000000001 RDI: ffff8fc=
f2f2a1840
> [1821331.238752] RBP: ffff8fb06efb8150 R08: 0000000000000000 R09: 0000000=
000000003
> [1821331.238753] R10: ffffaf1a6f1676f8 R11: ffff8fcfaf7d5028 R12: 0000000=
000000000
> [1821331.238754] R13: ffff8fb146731358 R14: ffff8fb146731200 R15: 0000000=
000000000
> [1821331.238755] FS:  00007fd91883d380(0000) GS:ffff8fcf2f280000(0000) kn=
lGS:0000000000000000
> [1821331.238756] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [1821331.238757] CR2: 00007e4901001000 CR3: 00000001c3cb6004 CR4: 0000000=
000770ef0
> [1821331.238759] PKRU: 55555554
> [1821331.238760] Call Trace:
> [1821331.238762]  <TASK>
> [1821331.238765]  ? __warn+0x7c/0x140
> [1821331.238769]  ? btrfs_run_delayed_refs+0x107/0x140
> [1821331.238771]  ? report_bug+0x160/0x1c0
> [1821331.238774]  ? handle_bug+0x41/0x80
> [1821331.238777]  ? exc_invalid_op+0x15/0x100
> [1821331.238780]  ? asm_exc_invalid_op+0x16/0x40
> [1821331.238783]  ? btrfs_run_delayed_refs+0x107/0x140
> [1821331.238785]  ? btrfs_run_delayed_refs+0x107/0x140
> [1821331.238786]  btrfs_commit_transaction+0x69/0xe80
> [1821331.238790]  ? btrfs_update_reloc_root+0x12d/0x240
> [1821331.238793]  prepare_to_merge+0x4f0/0x600
> [1821331.238796]  relocate_block_group+0x113/0x500
> [1821331.238798]  btrfs_relocate_block_group+0x27a/0x440
> [1821331.238800]  btrfs_relocate_chunk+0x3b/0x180
> [1821331.238803]  btrfs_balance+0x8c1/0x1340
> [1821331.238805]  ? btrfs_ioctl+0x18db/0x26c0
> [1821331.238811]  btrfs_ioctl+0x2285/0x26c0
> [1821331.238813]  ? __mod_memcg_lruvec_state+0x91/0x140
> [1821331.238817]  ? vsnprintf+0x323/0x580
> [1821331.238819]  ? __slab_free+0x53/0x2c0
> [1821331.238822]  ? sysfs_emit+0x68/0xc0
> [1821331.238826]  __x64_sys_ioctl+0x90/0x100
> [1821331.238830]  do_syscall_64+0x69/0x140
> [1821331.238832]  ? __memcg_slab_free_hook+0xf3/0x140
> [1821331.238835]  ? __x64_sys_close+0x38/0x80
> [1821331.238838]  ? kmem_cache_free+0x336/0x400
> [1821331.238840]  ? do_syscall_64+0x75/0x140
> [1821331.238842]  ? ksys_read+0x63/0x100
> [1821331.238845]  ? __mod_memcg_lruvec_state+0x91/0x140
> [1821331.238848]  ? mod_objcg_state+0x19d/0x2c0
> [1821331.238850]  ? __memcg_slab_free_hook+0xf3/0x140
> [1821331.238852]  ? seq_release+0x24/0x40
> [1821331.238854]  ? __memcg_slab_free_hook+0xf3/0x140
> [1821331.238856]  ? __x64_sys_close+0x38/0x80
> [1821331.238858]  ? kmem_cache_free+0x336/0x400
> [1821331.238860]  ? clear_bhb_loop+0x45/0xc0
> [1821331.238862]  ? clear_bhb_loop+0x45/0xc0
> [1821331.238864]  ? clear_bhb_loop+0x45/0xc0
> [1821331.238866]  ? clear_bhb_loop+0x45/0xc0
> [1821331.238867]  ? clear_bhb_loop+0x45/0xc0
> [1821331.238869]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [1821331.238872] RIP: 0033:0x7fd9189564bb
> [1821331.238874] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10=
 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05=
 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
> [1821331.238876] RSP: 002b:00007ffd5896d7a0 EFLAGS: 00000246 ORIG_RAX: 00=
00000000000010
> [1821331.238878] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fd=
9189564bb
> [1821331.238879] RDX: 00007ffd5896d8a8 RSI: 00000000c4009420 RDI: 0000000=
000000003
> [1821331.238880] RBP: 0000000000000000 R08: 0000000000000073 R09: 0000000=
000000013
> [1821331.238881] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ff=
d5896d8a8
> [1821331.238882] R13: 0000000000000000 R14: 00007ffd5896ee24 R15: 0000000=
000000001
> [1821331.238884]  </TASK>
> [1821331.238885] ---[ end trace 0000000000000000 ]---
> [1821331.238886] BTRFS: error (device dm-4 state A) in btrfs_run_delayed_=
refs:2199: errno=3D-117 Filesystem corrupted
>=20
> --=20
> "A mouse is a device used to point at the xterm you want to type in" - A.=
S.R.
> =20
> Home page: http://marc.merlins.org/                       | PGP 7F55D5F27=
AAF9D08

