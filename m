Return-Path: <linux-btrfs+bounces-11914-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A72A48673
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Feb 2025 18:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 082A37A727E
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Feb 2025 17:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFD11DDC0B;
	Thu, 27 Feb 2025 17:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="YOktFPq7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nPyZtf57"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26611D6DA8
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Feb 2025 17:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740676847; cv=none; b=jAZekZrQeMvGu7yxYZBs3kJZnecrSzr2TVtE/Shpm0MmJcRA5SWfL0YkAFnjNeCs8ODlpO14Y3isSsbqIItTljDXhT2sSg0mDXaGz9SKlxwMef6b5z/c93OyiPnG31MBYxmWdRs/HWUqlzM7SUARtwYmp2edrJ35G7l1bvDHhM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740676847; c=relaxed/simple;
	bh=m+OuesS5/0wTuhdL2NsKxL5ftodvorrU2TpSlUqCFc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QVOOJfn/v6Lh5+Dfe+31+IFL8cNe9s608qh5s8UIk6F1RGUekG98J2hpek/HNw8c2sl6b22Rr/0iBR5ez4wzxpeFW41XOK+Fcs3V8brYdsPuL/rkJxoPUmkC4Bdak14Mwsl1l1dmOiDG/HWzaAxyOF4JVaw292ZSRJo3zgN8yDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=YOktFPq7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nPyZtf57; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E986525401CD;
	Thu, 27 Feb 2025 12:20:42 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Thu, 27 Feb 2025 12:20:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1740676842;
	 x=1740763242; bh=0ZkoCW7LqT7C2s79TmL+xLcNzxvEuuc+RJypFkC6ff8=; b=
	YOktFPq7VIa/0zbJHpkBp9eFBmr2sJKJFma6NOkgkw2EGGVYxfoxopGKKjTkw6LU
	KcLnOHa3iYulq89tlXWE+bq2fFZ3RWjGXXs83/GW8KC14/z19Pn9l3HtUjx+3oRQ
	6+lTsZJu/ppyNKeieAO/tingsj/fduquC6ZQM9wEHk9nk7hEDC6LDfuaSjvzy/V3
	iaZzSA/YViiHtqmgIZ9hqEwHAXXD05JubC+zrP6Id5CLuCqRKzHTdJQnhV6lD40w
	4P+IASf5QAHmzkfIx+nhv++zHUxVuxbK8cLaWCjUII9rI7pU5qWPRQ+ChFYYSvrP
	jNlACB27wq9sANbs5I1NEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740676842; x=
	1740763242; bh=0ZkoCW7LqT7C2s79TmL+xLcNzxvEuuc+RJypFkC6ff8=; b=n
	PyZtf57NmvxX15uP9KV/YuYTRUGCjfy4gAEYi3FKd3rnBoTo460mpDweSdTFQx5F
	9ho3Q7crw9NzlCrLAzTIVBD4qqIZn4VZ7cacrSO9JSjzQ7BG6CxIZhoMMOnxPf6S
	db0EIkZ+Oy3FZoyS1/TuTbE/dZ3C/C9piokxuCjX8GkteWol7hjQmH2We056Nu74
	dM83I1jUHVkdv47hxqPGP4ul6ed1j0jBtZpiTLcCjVnKTrDIykWtNrDXC//Po7Q/
	MhH3fTQxOnnfRR7cdALF4xUH/A0acaX2mP1fpnMirAS8oU51BW5EGvMOlXw6OJQC
	58T5N0dq3FypxYpkg/BqQ==
X-ME-Sender: <xms:6p7AZ7yV_CVrDF7iGl54bcADVZ3fyVYEB4H5a4qMSXRIaRBWwTKnWg>
    <xme:6p7AZzTFWHTIufoyex_GNqM2WNOuMb4wJRZNKbq4CRutYlHakOUrq12p3ZRQtZqan
    2ATUiBwZIP1QuGkArI>
X-ME-Received: <xmr:6p7AZ1UHSSYIjy3D91cni2cm5XC6SgtyrjQid1NT6JnF7DhIuKXNsbusqYqhhgRBnu8mPI-DRsA9A5w0vi9bASipLMk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekkedtgecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:6p7AZ1jp7aZAf8Ek5GV8roSZ9epHUb_khRX39naUeyVbpayMYncqiA>
    <xmx:6p7AZ9AuVXy-zkOp5f0bk75X4bnxdQtVATPG0Jh9SAOUi09LWkGsvw>
    <xmx:6p7AZ-Jq-oDVXSGBFVAkAD_BT7VsfNaUY5muBN2bnxHvlPCfzvuabw>
    <xmx:6p7AZ8AfnN3M338hcbJiJkT2OQcrioVKie2DY1zBD8PvW55Jfyfojw>
    <xmx:6p7AZwNG6Z-spWU8QzGFiJnvcF--sjKG0vfm9QIBwCnMEH45-IIM3qE3>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Feb 2025 12:20:42 -0500 (EST)
Date: Thu, 27 Feb 2025 09:21:13 -0800
From: Boris Burkov <boris@bur.io>
To: Marc MERLIN <marc@merlins.org>
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: BTRFS error (device dm-4): failed to run delayed ref for logical
 350223581184 num_bytes 16384 type 176 action 1 ref_mod 1: -117 (kernel
 6.11.2)
Message-ID: <20250227172113.GA2210558@zen.localdomain>
References: <Z6TsUwR7tyKJrZ7w@merlins.org>
 <20250227170220.GA2202481@zen.localdomain>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250227170220.GA2202481@zen.localdomain>

On Thu, Feb 27, 2025 at 09:02:20AM -0800, Boris Burkov wrote:
> On Thu, Feb 06, 2025 at 09:07:31AM -0800, Marc MERLIN wrote:
> > Balance ended with btrfs_run_delayed_refs:2199: errno=3D-117 Filesystem=
 corrupted
> >=20
> > btrfs check says it's not
> > sauron:~# btrfs check /dev/mapper/pool1
> > Opening filesystem to check...
> > Checking filesystem on /dev/mapper/pool1
> > UUID: 4542883b-d8bc-4d7f-8a2e-944dc355dc44
> > [1/7] checking root items
> > [2/7] checking extents
> > [3/7] checking free space tree
> > [4/7] checking fs roots
> > [5/7] checking only csums items (without verifying data)
> > [6/7] checking root refs
> > [7/7] checking quota groups skipped (not enabled on this FS)
> > found 228820946944 bytes used, no error found
> > total csum bytes: 219270232
> > total tree bytes: 4539334656
> > total fs tree bytes: 3719593984
> > total extent tree bytes: 481935360
> > btree space waste bytes: 1075469196
> > file data blocks allocated: 15390875832320
> >  referenced 290833076224
> >=20
> > Any ideas? this obviously caused downtime, but after the btrfs check sa=
ying I'm supposedly
> > ok, I'm back up for now, hoping it won't happen again and hope is not a=
 strategy :)
>=20
> I haven't carefully read the entire thread because it looks like it was
> focused on memtest stuff, so apologies if I missed something.
>=20
> This looks exactly like a bug Josef and I debugged extensively last
> year.
>=20
> https://lore.kernel.org/linux-btrfs/68766e66ed15ca2e7550585ed09434249db91=
2a2.1727212293.git.josef@toxicpanda.com/
> and
> https://lore.kernel.org/linux-btrfs/fc61fb63e534111f5837c204ec341c876637a=
f69.1731513908.git.josef@toxicpanda.com/
>=20
> I'll dig through the rest of the emails now, confirm whether you have
> the fixes, etc. but just wanted to get that on your radar.

Your kernel is 6.11.2 and those fixes went in to 6.12-rc2:
https://lore.kernel.org/linux-btrfs/cover.1728050979.git.dsterba@suse.com/
and 6.12-rc8:
https://lore.kernel.org/linux-btrfs/cover.1731619157.git.dsterba@suse.com/

so unless you have backported those fixes, that is almost certainly the iss=
ue.=20

>=20
> Boris
>=20
> >=20
> > Is it safe to run balance again? any idea why it failed?
> >=20
> > [1821331.015652] BTRFS info (device dm-4): balance: start -dusage=3D20
> > [1821331.015805] BTRFS info (device dm-4): relocating block group 76121=
2698624 flags data
> > [1821331.090338] BTRFS info (device dm-4): found 31 extents, stage: mov=
e data extents
> > [1821331.237707] BTRFS info (device dm-4): leaf 471333519360 gen 480818=
2 total ptrs 168 free space 3533 owner 2
> > [1821331.237716] 	item 0 key (350222417920 169 0) itemoff 16250 itemsiz=
e 33
> > [1821331.237718] 		extent refs 1 gen 2907391 flags 2
> > [1821331.237719] 		ref#0: tree block backref root 398
> > (...(
> > [1821331.238559] 	item 167 key (350225678336 169 0) itemoff 7733 itemsi=
ze 168
> > [1821331.238560] 		extent refs 16 gen 4619087 flags 2
> > [1821331.238561] 		ref#0: tree block backref root 398
> > [1821331.238562] 		ref#1: shared block backref parent 737084112896
> > [1821331.238563] 		ref#2: shared block backref parent 736609173504
> > [1821331.238564] 		ref#3: shared block backref parent 471099588608
> > [1821331.238565] 		ref#4: shared block backref parent 471017488384
> > [1821331.238567] 		ref#5: shared block backref parent 470665625600
> > [1821331.238568] 		ref#6: shared block backref parent 350806835200
> > [1821331.238569] 		ref#7: shared block backref parent 350292066304
> > [1821331.238570] 		ref#8: shared block backref parent 349856350208
> > [1821331.238571] 		ref#9: shared block backref parent 153429573632
> > [1821331.238572] 		ref#10: shared block backref parent 153014337536
> > [1821331.238573] 		ref#11: shared block backref parent 152976048128
> > [1821331.238575] 		ref#12: shared block backref parent 152753946624
> > [1821331.238576] 		ref#13: shared block backref parent 152639225856
> > [1821331.238577] 		ref#14: shared block backref parent 50782617600
> > [1821331.238578] 		ref#15: shared block backref parent 394002432
> > [1821331.238579] BTRFS critical (device dm-4): adding refs to an existi=
ng tree ref, bytenr 350223581184 num_bytes 16384 root_objectid 398 slot 51
> > [1821331.238582] BTRFS error (device dm-4): failed to run delayed ref f=
or logical 350223581184 num_bytes 16384 type 176 action 1 ref_mod 1: -117
> > [1821331.238584] ------------[ cut here ]------------
> > [1821331.238585] BTRFS: Transaction aborted (error -117)
> > [1821331.238593] WARNING: CPU: 1 PID: 2457672 at fs/btrfs/extent-tree.c=
:2199 btrfs_run_delayed_refs+0x107/0x140
> > [1821331.238599] Modules linked in: mmc_block exfat uinput rpcsec_gss_k=
rb5 nfsv4 dns_resolver nfs netfs sg uas usb_storage nf_conntrack_netlink xf=
rm_user xfrm_algo xt_addrtype br_netfilter bridge stp llc xt_tcpudp xt_conn=
track rfcomm snd_seq_dummy snd_hrtimer ccm overlay ipt_REJECT nf_reject_ipv=
4 xt_MASQUERADE xt_LOG nf_log_syslog nft_compat nft_chain_nat nf_nat nf_con=
ntrack nf_defrag_ipv6 nf_defrag_ipv4 cmac algif_hash algif_skcipher af_alg =
nf_tables bnep binfmt_misc uvcvideo videobuf2_vmalloc uvc videobuf2_memops =
btusb videobuf2_v4l2 btrtl btbcm videodev btmtk btintel videobuf2_common mc=
 bluetooth nls_utf8 nls_cp437 vfat fat squashfs loop snd_hda_codec_hdmi iwl=
mvm snd_hda_codec_realtek snd_hda_codec_generic snd_soc_dmic snd_hda_scodec=
_component mac80211 intel_uncore_frequency snd_sof_pci_intel_tgl intel_unco=
re_frequency_common snd_sof_pci_intel_cnl intel_tcc_cooling snd_sof_intel_h=
da_generic snd_sof_intel_hda_common x86_pkg_temp_thermal snd_sof_intel_hda =
intel_powerclamp libarc4 snd_sof_pci snd_sof_xtensa_dsp kvm_intel
> > [1821331.238644]  snd_soc_hdac_hda iwlwifi kvm thinkpad_acpi snd_soc_ac=
pi_intel_match mei_hdcp mei_pxp snd_soc_acpi cfg80211 processor_thermal_dev=
ice_pci_legacy nvram tpm_crb processor_thermal_device rapl platform_profile=
 processor_thermal_wt_hint processor_thermal_rfim snd_soc_avs processor_the=
rmal_rapl ucsi_acpi intel_rapl_common nvidiafb processor_thermal_wt_req int=
el_cstate think_lmi vgastate iTCO_wdt typec_ucsi snd_soc_hda_codec pcspkr p=
rocessor_thermal_power_floor firmware_attributes_class wmi_bmof snd_hda_int=
el ee1004 iTCO_vendor_support fb_ddc typec processor_thermal_mbox mei_me ro=
les intel_soc_dts_iosf int3403_thermal rfkill int340x_thermal_zone ac intel=
_pmc_core intel_vsec tpm_tis tpm_tis_core int3400_thermal pmt_telemetry acp=
i_pad intel_hid acpi_thermal_rel sparse_keymap pmt_class acpi_tad input_led=
s evdev joydev serio_raw vboxdrv(OE) soundwire_intel soundwire_cadence snd_=
sof_intel_hda_mlink soundwire_generic_allocation snd_sof_probes snd_sof snd=
_sof_utils snd_intel_dspcfg snd_intel_sdw_acpi snd_soc_skl_hda_dsp
> > [1821331.238682]  snd_soc_intel_hda_dsp_common snd_hda_codec snd_hwdep =
snd_soc_hdac_hdmi snd_hda_ext_core snd_soc_core snd_compress snd_pcm_dmaeng=
ine snd_hda_core snd_pcm_oss snd_mixer_oss snd_pcm snd_seq_midi snd_seq_mid=
i_event snd_seq snd_timer snd_rawmidi snd_seq_device snd_ctl_led snd soundc=
ore ac97_bus configs coretemp msr fuse efi_pstore nfsd auth_rpcgss nfs_acl =
lockd grace sunrpc nfnetlink ip_tables x_tables autofs4 essiv authenc dm_cr=
ypt trusted asn1_encoder tee tpm rng_core libaescfb ecdh_generic dm_mod ecc=
 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx sata_si=
l24 r8169 realtek mdio_devres libphy mii hid_generic usbhid hid i915 crct10=
dif_pclmul drm_buddy i2c_algo_bit rtsx_pci_sdmmc crc32_pclmul xhci_pci ttm =
mmc_core crc32c_intel xhci_hcd polyval_clmulni drm_display_helper polyval_g=
eneric usbcore cec i2c_i801 rc_core video ptp spi_intel_pci i2c_mux ghash_c=
lmulni_intel sha512_ssse3 sha256_ssse3 sha1_ssse3 psmouse thunderbolt rtsx_=
pci spi_intel i2c_smbus pps_core usb_common thermal hwmon battery
> > [1821331.238731]  wmi aesni_intel crypto_simd cryptd [last unloaded: ig=
c]
> > [1821331.238737] CPU: 1 UID: 0 PID: 2457672 Comm: btrfs Tainted: G     =
U     OE      6.11.2-amd64-preempt-sysrq-20241007 #1 1a512c2db5f087f236d90e=
cfb30551fddcc51243
> > [1821331.238740] Tainted: [U]=3DUSER, [O]=3DOOT_MODULE, [E]=3DUNSIGNED_=
MODULE
> > [1821331.238742] Hardware name: LENOVO 20YU002JUS/20YU002JUS, BIOS N37E=
T49W (1.30 ) 11/15/2023
> > [1821331.238743] RIP: 0010:btrfs_run_delayed_refs+0x107/0x140
> > [1821331.238745] Code: 01 00 00 00 eb b6 e8 18 8e b7 00 31 db 89 d8 5b =
5d 41 5c 41 5d 41 5e c3 cc cc cc cc 89 de 48 c7 c7 40 bb b7 86 e8 f9 0c 9f =
ff <0f> 0b eb d0 66 66 2e 0f 1f 84 00 00 00 00 00 66 66 2e 0f 1f 84 00
> > [1821331.238747] RSP: 0018:ffffaf1a6f167858 EFLAGS: 00010282
> > [1821331.238749] RAX: 0000000000000000 RBX: 00000000ffffff8b RCX: 00000=
00000000027
> > [1821331.238750] RDX: ffff8fcf2f2a1848 RSI: 0000000000000001 RDI: ffff8=
fcf2f2a1840
> > [1821331.238752] RBP: ffff8fb06efb8150 R08: 0000000000000000 R09: 00000=
00000000003
> > [1821331.238753] R10: ffffaf1a6f1676f8 R11: ffff8fcfaf7d5028 R12: 00000=
00000000000
> > [1821331.238754] R13: ffff8fb146731358 R14: ffff8fb146731200 R15: 00000=
00000000000
> > [1821331.238755] FS:  00007fd91883d380(0000) GS:ffff8fcf2f280000(0000) =
knlGS:0000000000000000
> > [1821331.238756] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [1821331.238757] CR2: 00007e4901001000 CR3: 00000001c3cb6004 CR4: 00000=
00000770ef0
> > [1821331.238759] PKRU: 55555554
> > [1821331.238760] Call Trace:
> > [1821331.238762]  <TASK>
> > [1821331.238765]  ? __warn+0x7c/0x140
> > [1821331.238769]  ? btrfs_run_delayed_refs+0x107/0x140
> > [1821331.238771]  ? report_bug+0x160/0x1c0
> > [1821331.238774]  ? handle_bug+0x41/0x80
> > [1821331.238777]  ? exc_invalid_op+0x15/0x100
> > [1821331.238780]  ? asm_exc_invalid_op+0x16/0x40
> > [1821331.238783]  ? btrfs_run_delayed_refs+0x107/0x140
> > [1821331.238785]  ? btrfs_run_delayed_refs+0x107/0x140
> > [1821331.238786]  btrfs_commit_transaction+0x69/0xe80
> > [1821331.238790]  ? btrfs_update_reloc_root+0x12d/0x240
> > [1821331.238793]  prepare_to_merge+0x4f0/0x600
> > [1821331.238796]  relocate_block_group+0x113/0x500
> > [1821331.238798]  btrfs_relocate_block_group+0x27a/0x440
> > [1821331.238800]  btrfs_relocate_chunk+0x3b/0x180
> > [1821331.238803]  btrfs_balance+0x8c1/0x1340
> > [1821331.238805]  ? btrfs_ioctl+0x18db/0x26c0
> > [1821331.238811]  btrfs_ioctl+0x2285/0x26c0
> > [1821331.238813]  ? __mod_memcg_lruvec_state+0x91/0x140
> > [1821331.238817]  ? vsnprintf+0x323/0x580
> > [1821331.238819]  ? __slab_free+0x53/0x2c0
> > [1821331.238822]  ? sysfs_emit+0x68/0xc0
> > [1821331.238826]  __x64_sys_ioctl+0x90/0x100
> > [1821331.238830]  do_syscall_64+0x69/0x140
> > [1821331.238832]  ? __memcg_slab_free_hook+0xf3/0x140
> > [1821331.238835]  ? __x64_sys_close+0x38/0x80
> > [1821331.238838]  ? kmem_cache_free+0x336/0x400
> > [1821331.238840]  ? do_syscall_64+0x75/0x140
> > [1821331.238842]  ? ksys_read+0x63/0x100
> > [1821331.238845]  ? __mod_memcg_lruvec_state+0x91/0x140
> > [1821331.238848]  ? mod_objcg_state+0x19d/0x2c0
> > [1821331.238850]  ? __memcg_slab_free_hook+0xf3/0x140
> > [1821331.238852]  ? seq_release+0x24/0x40
> > [1821331.238854]  ? __memcg_slab_free_hook+0xf3/0x140
> > [1821331.238856]  ? __x64_sys_close+0x38/0x80
> > [1821331.238858]  ? kmem_cache_free+0x336/0x400
> > [1821331.238860]  ? clear_bhb_loop+0x45/0xc0
> > [1821331.238862]  ? clear_bhb_loop+0x45/0xc0
> > [1821331.238864]  ? clear_bhb_loop+0x45/0xc0
> > [1821331.238866]  ? clear_bhb_loop+0x45/0xc0
> > [1821331.238867]  ? clear_bhb_loop+0x45/0xc0
> > [1821331.238869]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > [1821331.238872] RIP: 0033:0x7fd9189564bb
> > [1821331.238874] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 =
10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f =
05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
> > [1821331.238876] RSP: 002b:00007ffd5896d7a0 EFLAGS: 00000246 ORIG_RAX: =
0000000000000010
> > [1821331.238878] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007=
fd9189564bb
> > [1821331.238879] RDX: 00007ffd5896d8a8 RSI: 00000000c4009420 RDI: 00000=
00000000003
> > [1821331.238880] RBP: 0000000000000000 R08: 0000000000000073 R09: 00000=
00000000013
> > [1821331.238881] R10: 0000000000000000 R11: 0000000000000246 R12: 00007=
ffd5896d8a8
> > [1821331.238882] R13: 0000000000000000 R14: 00007ffd5896ee24 R15: 00000=
00000000001
> > [1821331.238884]  </TASK>
> > [1821331.238885] ---[ end trace 0000000000000000 ]---
> > [1821331.238886] BTRFS: error (device dm-4 state A) in btrfs_run_delaye=
d_refs:2199: errno=3D-117 Filesystem corrupted
> >=20
> > --=20
> > "A mouse is a device used to point at the xterm you want to type in" - =
A.S.R.
> > =20
> > Home page: http://marc.merlins.org/                       | PGP 7F55D5F=
27AAF9D08

