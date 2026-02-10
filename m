Return-Path: <linux-btrfs+bounces-21620-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBhMLge2i2kKZAAAu9opvQ
	(envelope-from <linux-btrfs+bounces-21620-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 23:49:43 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AE011FD3A
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 23:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5AD84306241B
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 22:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7B1310782;
	Tue, 10 Feb 2026 22:49:28 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from giraffe.ash.relay.mailchannels.net (giraffe.ash.relay.mailchannels.net [23.83.222.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6B02DB781
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Feb 2026 22:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.222.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770763767; cv=pass; b=LT58ZZRC43KGHHlQVDk3WCNE1aSdYmtVdUXTe0x/oKlUID2COKL+UVfGdsTJ/hjLfpMUiKk0RFDyhAxWmf1QI3DORw+NHgw8uMnmM3tPFltt0Q4Syblp1VBASAuBHUDTSpLKkrnKfJ+piQtTGj9rMRXFUMZ0tL+L1stl3YeB3H0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770763767; c=relaxed/simple;
	bh=5S6P3o1tUI1zj1IcbpBF8xcsaeUGyMmI70F8ucddrws=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WYhBZF5lWkkMGky/jwMOad8Ev66hSmbuelaK6Rxor5GeK5n4jhuyofbfOQqs6ngHkq7HIq25h864WyX7a8DkRYYm5hloumW+FSzIQChWZPZwdObp1jDNXI9uP/DHypLHPOsUi4VhSoW0C78RqmxfTTIz2fBsvmof1HZkem8qra8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org; spf=pass smtp.mailfrom=scientia.org; arc=pass smtp.client-ip=23.83.222.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id EAB44181A81;
	Tue, 10 Feb 2026 22:49:16 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (100-97-187-84.trex-nlb.outbound.svc.cluster.local [100.97.187.84])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id C926F181373;
	Tue, 10 Feb 2026 22:49:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1770763756;
	b=5KYGyrO/uU2GNNPgHQbycxEWAfx5HIuY7m+a0evmTGWU1+yOTUGRQ+n7P/Ai+6FbV/mi7P
	9ile2IdMgNWwNspgxOj4Z4VwpaNZyGLK+Rfq8b68kqXvRH5dVp4V7UHmJS07fJVUI3J0/s
	5wIJCz2ukpv1Ga2zO4LCiECTprH60/avYTOGMGGjtgz8UgRHkGof1AbIjhdGnDHPNaZBjr
	8VXbaHA0z+6kMzSmYMkT9Z6B25TEBeZAHuubTNwvroe4MIBiQrmkQCGTJKR4eZPWlNRL/W
	Mhala7a8DZTJd/6m0k6dWqsNfT4+Li2d47xzQD0IG6hAqSH7pG+Z9oEBJWbV2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1770763756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9UU4LLhJwDW4YqYasdAhE5j8HQ1VfHNdIW+VhzEU75A=;
	b=P4XwC4vjxADyrM6IxrnDlG/9J+LeE/J0OEih/bb+H/qT/uTdrI9OzK8/cbop+r+RKrg9/o
	abIDpOvrHTtKiSHoHPeG+dhLpXQxCQW9iUQiNGHF1eqYubsZyP0aCIYpFZ4QNf/UF2fVwx
	a1d/pLHxne+xInV1faHNCM8lqhX6Vfo/PX1xuPQ1ikRgBoQRMEpmI5sFvSjnhGrlgwxm/u
	pQhcyiaTT1lTRxMbpAB4vEuyuPoT6/PwldzisPyXwiXjT016vajezpZegV1Pbjq8cUQZYc
	Zlo5Xjixfa5n60oq1dG8gYWTzIupKSFXCI4ZUAljpm1X9ZI3D2M90LFd/AbscQ==
ARC-Authentication-Results: i=1;
	rspamd-79bdc9947c-hz27d;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Print-Quick: 19552aa63566e269_1770763756839_3931853525
X-MC-Loop-Signature: 1770763756839:2490802413
X-MC-Ingress-Time: 1770763756839
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.97.187.84 (trex/7.1.3);
	Tue, 10 Feb 2026 22:49:16 +0000
Received: from [212.104.214.84] (port=36978 helo=[10.2.0.2])
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.1)
	(envelope-from <calestyo@scientia.org>)
	id 1vpwXh-00000005lfi-2YfK;
	Tue, 10 Feb 2026 22:49:14 +0000
Message-ID: <f94503a645b3d3f20fb7d311268363cb4d67b061.camel@scientia.org>
Subject: Re: space_info METADATA (sub-group id 0) has 691535872 free, is not
 full // open_ctree failed: -2
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>
Date: Tue, 10 Feb 2026 23:49:11 +0100
In-Reply-To: <1d7f6937ca045573661fb32334e4d18948cd97a8.camel@scientia.org>
References: <f3574976d7b5bc8f05e42055d85d4b61263bc5c5.camel@scientia.org>
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
		 <89188b7b8b5a1f9bb64af37777aec906134ad75c.camel@scientia.org>
		 <9b05f9a3-5efe-4e57-9585-a3886bb419fa@suse.com>
		 <3137a2417287037a2ed52ded55fab35181254009.camel@scientia.org>
		 <54b7e6a4-7a08-434c-b7e0-849d3f961de3@suse.com>
		 <4aa883f597c4d12ddfb50912cc03349594d4fdd7.camel@scientia.org>
		 <c8fe54d5-d088-4326-a5ec-4c9687f89902@suse.com>
	 <1d7f6937ca045573661fb32334e4d18948cd97a8.camel@scientia.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	DMARC_NA(0.00)[scientia.org];
	TAGGED_RCPT(0.00)[linux-btrfs];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[calestyo@scientia.org,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-21620-lists,linux-btrfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_ALL(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C2AE011FD3A
X-Rspamd-Action: no action

Hey.

I've tried again (with another, much bigger, fs) that also has "We have
a space info key for a block group that doesn't exist".

As that fs is precious (despite having backups), I set the blockdev
--setro and made a snapshot of it (via dmsetup) and worked on that.

Here me findings:

1) What at least seems to work is:
   btrfs rescue clear-space-cache v2 /dev/mapper/snapdev
   mount -o space_cache=3Dv2,clear_cache,rw /dev/mapper/snapdev /mnt/

   no kernel errors, and fsck works afterwards

   However, there are unexpected differences in fsck:
   Original device:
      # btrfs check /dev/mapper/data-a-2 ; echo $? ; beep
      Opening filesystem to check...
      Checking filesystem on /dev/mapper/data-a-2
      UUID: e1a465db-0227-46e1-9917-d6be986266cd
      [1/8] checking log skipped (none written)
      [2/8] checking root items
      [3/8] checking extents
      [4/8] checking free space tree
      We have a space info key for a block group that doesn't exist
      [5/8] checking fs roots
      [6/8] checking only csums items (without verifying data)
      [7/8] checking root refs
      [8/8] checking quota groups skipped (not enabled on this FS)
      found 15679604916224 bytes used, error(s) found
      total csum bytes: 15285505424
      total tree bytes: 27247362048
      total fs tree bytes: 9524903936
      total extent tree bytes: 671170560
      btree space waste bytes: 3364698078
      file data blocks allocated: 20371926761472
       referenced 17314900869120
      1
   snapshot after the above fix:
      # btrfs check /dev/mapper/snapdev ; echo $? ; beep
      Opening filesystem to check...
      Checking filesystem on /dev/mapper/snapdev
      UUID: e1a465db-0227-46e1-9917-d6be986266cd
      [1/8] checking log skipped (none written)
      [2/8] checking root items
      [3/8] checking extents
      [4/8] checking free space tree
      [5/8] checking fs roots
      [6/8] checking only csums items (without verifying data)
      [7/8] checking root refs
      [8/8] checking quota groups skipped (not enabled on this FS)
      found 15679604752384 bytes used, no error found
      total csum bytes: 15285505424
      total tree bytes: 27247198208
      total fs tree bytes: 9524903936
      total extent tree bytes: 671203328
      btree space waste bytes: 3364544224
      file data blocks allocated: 20371926761472
       referenced 17314900869120
      0

   Now I can imagine why "found ... bytes", tree bytes and space waste
   bytes differ (I assume because of the removed & newly created free
   space tree?)

   But why do extent tree bytes differ?


   So would you say the above procedure is safe for precious
   filesystems?


I've also tried to check whether *only* using
mount -o space_cache=3Dv2,clear_cache,rw (without btrfs rescue clear-
space-cache v2)
leads to fs breakage again?

2) On a fresh snapshot from the original:
      # mount -o space_cache=3Dv2,clear_cache,rw /dev/mapper/snapdev /mnt/ =
; echo $?
      mount: /mnt: fsconfig() failed: No such file or directory.
             dmesg(1) may have more information after failed mount system c=
all.
      32

   kernel log errors as before, due to the timeout

   But if I now try:
      # btrfs rescue clear-space-cache v2 /dev/mapper/snapdev ; echo $?
      Clear free space cache v2
      corrupt leaf: root=3D1 block=3D11636200325120 slot=3D0, invalid root,=
 root 1 must never be empty
      leaf 11636200325120 items 0 free space 16283 generation 2623 owner RO=
OT_TREE
      leaf 11636200325120 flags 0x0() backref revision 1
      fs uuid e1a465db-0227-46e1-9917-d6be986266cd
      chunk uuid 27bbffc5-5af5-4957-84b9-494df59ebe51
      ERROR: failed to clear free space cache v2: -1
      ERROR: commit_root already set when starting transaction
      WARNING: reserved space leaked, flag=3D0x4 bytes_reserved=3D114688
      extent buffer leak: start 11041772257280 len 16384
      extent buffer leak: start 10877071310848 len 16384
      WARNING: dirty eb leak (aborted trans): start 10877071310848 len 1638=
4
      extent buffer leak: start 9411384377344 len 16384
      WARNING: dirty eb leak (aborted trans): start 9411384377344 len 16384
      extent buffer leak: start 11041577304064 len 16384
      WARNING: dirty eb leak (aborted trans): start 11041577304064 len 1638=
4
      extent buffer leak: start 11636200325120 len 16384
      WARNING: dirty eb leak (aborted trans): start 11636200325120 len 1638=
4
      1
     =20
   and I get these:
      Feb 10 23:29:20 heisenberg kernel: BTRFS info (device dm-2): rebuildi=
ng free space tree
      Feb 10 23:29:54 heisenberg kernel: BTRFS critical (device dm-2): unab=
le to find root key (10 132 0) in tree 1
      Feb 10 23:29:54 heisenberg kernel: ------------[ cut here ]----------=
--
      Feb 10 23:29:54 heisenberg kernel: BTRFS: Transaction aborted (error =
-117)
      Feb 10 23:29:54 heisenberg kernel: WARNING: CPU: 14 PID: 90038 at fs/=
btrfs/root-tree.c:153 btrfs_update_root+0x229/0x3e0 [btrfs]
      Feb 10 23:29:54 heisenberg kernel: Modules linked in: sg uas dm_snaps=
hot dm_bufio loop nft_fib_ipv6 nft_ct nft_fib_ipv4 nft_fib wireguard libcur=
ve25519 libchacha20poly1305 libchacha ip6_udp_tunnel udp_tunnel libpoly1305=
 cmac ccm snd_seq_dummy snd_hrtimer snd_seq snd_ctl_led snd_soc_skl_hda_dsp=
 snd_soc_intel_sof_board_helpers snd_sof_probes snd_soc_intel_hda_dsp_commo=
n xe snd_hda_codec_intelhdmi snd_hda_codec_alc269 drm_gpuvm drm_gpusvm_help=
er snd_hda_scodec_component gpu_sched snd_hda_codec_realtek_lib drm_ttm_hel=
per snd_hda_codec_generic snd_soc_dmic drm_exec snd_hda_intel drm_suballoc_=
helper ip6t_REJECT nf_reject_ipv6 snd_sof_pci_intel_tgl ipt_REJECT snd_sof_=
pci_intel_cnl nf_reject_ipv4 snd_sof_intel_hda_generic xt_tcpudp soundwire_=
intel xt_conntrack nf_conntrack snd_sof_intel_hda_sdw_bpt snd_sof_intel_hda=
_common nf_defrag_ipv6 nf_defrag_ipv4 snd_soc_hdac_hda nft_compat snd_sof_i=
ntel_hda_mlink snd_sof_intel_hda nf_tables snd_hda_codec_hdmi soundwire_cad=
ence binfmt_misc x_tables snd_sof_pci snd_sof_xtensa_dsp snd_sof i915
      Feb 10 23:29:54 heisenberg kernel:  intel_uncore_frequency intel_unco=
re_frequency_common x86_pkg_temp_thermal snd_sof_utils snd_soc_acpi_intel_m=
atch intel_powerclamp snd_soc_acpi_intel_sdca_quirks soundwire_generic_allo=
cation snd_soc_acpi crc8 soundwire_bus coretemp snd_soc_sdca iwlmvm joydev =
snd_soc_avs kvm_intel snd_soc_hda_codec mac80211 snd_hda_ext_core kvm snd_h=
da_codec drm_buddy snd_hda_core ttm processor_thermal_device_pci uvcvideo s=
nd_usb_audio libarc4 btusb processor_thermal_device drm_display_helper snd_=
intel_dspcfg processor_thermal_wt_hint videobuf2_vmalloc platform_temperatu=
re_control btmtk irqbypass snd_intel_sdw_acpi processor_thermal_soc_slider =
iTCO_wdt uvc iwlwifi snd_soc_core cec btrtl hid_multitouch snd_usbmidi_lib =
videobuf2_memops ghash_clmulni_intel platform_profile intel_pmc_bxt snd_hwd=
ep rc_core btbcm sdhci_pci videobuf2_v4l2 snd_rawmidi btintel rapl snd_comp=
ress drm_client_lib iTCO_vendor_support processor_thermal_rfim intel_rapl_m=
sr hid_generic sdhci_uhs2 bluetooth cfg80211 videodev mei_pxp mei_hdcp watc=
hdog
      Feb 10 23:29:54 heisenberg kernel:  intel_pmc_core wmi_bmof ee1004 sn=
d_pcm_dmaengine processor_thermal_rapl snd_seq_device intel_cstate ucsi_acp=
i drm_kms_helper sdhci videobuf2_common pmt_telemetry snd_pcm intel_rapl_co=
mmon i2c_hid_acpi typec_ucsi i2c_algo_bit pmt_discovery processor_thermal_w=
t_req i2c_hid ecdh_generic cqhci fujitsu_laptop mc usbhid snd_timer intel_u=
ncore mmc_core crc16 typec int3400_thermal pmt_class hid video processor_th=
ermal_power_floor intel_lpss_pci intel_pmc_ssram_telemetry roles battery bu=
tton acpi_thermal_rel snd mei_me intel_lpss processor_thermal_mbox wmi mei =
acpi_pad i2c_i801 intel_vsec int340x_thermal_zone rfkill soundcore ac acpi_=
tad idma64 i2c_smbus igen6_edac ppdev parport_pc lp drm parport efi_pstore =
configfs nfnetlink autofs4 crc32c_cryptoapi sd_mod dm_crypt dm_mod raid10 r=
aid456 async_raid6_recov async_memcpy async_pq async_xor async_tx raid1 rai=
d0 md_mod usb_storage scsi_mod scsi_common btrfs blake2b_generic xor raid6_=
pq xhci_pci xhci_hcd nvme evdev nvme_core thunderbolt usbcore serio_raw aes=
ni_intel
      Feb 10 23:29:54 heisenberg kernel:  e1000e pcspkr nvme_keyring intel_=
hid nvme_auth hkdf sparse_keymap fan usb_common efivarfs
      Feb 10 23:29:54 heisenberg kernel: CPU: 14 UID: 0 PID: 90038 Comm: bt=
rfs-transacti Tainted: G        W           6.18.9+deb14-amd64 #1 PREEMPT(l=
azy)  Debian 6.18.9-1=20
      Feb 10 23:29:54 heisenberg kernel: Tainted: [W]=3DWARN
      Feb 10 23:29:54 heisenberg kernel: Hardware name: FUJITSU CLIENT COMP=
UTING LIMITED LIFEBOOK U7512/FJNB2F4, BIOS Version 2.35 07/01/2025
      Feb 10 23:29:54 heisenberg kernel: RIP: 0010:btrfs_update_root+0x229/=
0x3e0 [btrfs]
      Feb 10 23:29:54 heisenberg kernel: Code: 84 21 c6 49 8b 45 60 48 05 b=
0 0a 00 00 f0 48 0f ba 28 02 0f 82 b5 3b 0e 00 be 8b ff ff ff 48 c7 c7 c8 0=
d 8e c0 e8 b7 6e 13 c6 <0f> 0b 41 b8 01 00 00 00 41 83 e0 01 b9 8b ff ff ff=
 ba 99 00 00 00
      Feb 10 23:29:54 heisenberg kernel: RSP: 0018:ffffcfc0e5ad7d28 EFLAGS:=
 00010246
      Feb 10 23:29:54 heisenberg kernel: RAX: 0000000000000000 RBX: ffff8df=
592343d90 RCX: 0000000000000027
      Feb 10 23:29:54 heisenberg kernel: RDX: ffff8e022f79ce48 RSI: 0000000=
000000001 RDI: ffff8e022f79ce40
      Feb 10 23:29:54 heisenberg kernel: RBP: 0000000000000001 R08: 0000000=
000000000 R09: ffffcfc0e5ad7bc8
      Feb 10 23:29:54 heisenberg kernel: R10: ffffffff888d86c0 R11: 0000000=
0ffffff6c R12: ffff8df882fb1000
      Feb 10 23:29:54 heisenberg kernel: R13: ffff8df2c62cf930 R14: ffff8df=
5b95dd000 R15: ffff8dff6c1a9840
      Feb 10 23:29:54 heisenberg kernel: FS:  0000000000000000(0000) GS:fff=
f8e02a634c000(0000) knlGS:0000000000000000
      Feb 10 23:29:54 heisenberg kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0=
000000080050033
      Feb 10 23:29:54 heisenberg kernel: CR2: 000015341260b000 CR3: 0000000=
a1642c004 CR4: 0000000000f72ef0
      Feb 10 23:29:54 heisenberg kernel: PKRU: 55555554
      Feb 10 23:29:54 heisenberg kernel: Call Trace:
      Feb 10 23:29:54 heisenberg kernel:  <TASK>
      Feb 10 23:29:54 heisenberg kernel:  commit_cowonly_roots+0x1d5/0x250 =
[btrfs]
      Feb 10 23:29:54 heisenberg kernel:  btrfs_commit_transaction+0x371/0x=
df0 [btrfs]
      Feb 10 23:29:54 heisenberg kernel:  ? start_transaction+0x228/0x840 [=
btrfs]
      Feb 10 23:29:54 heisenberg kernel:  ? __pfx_autoremove_wake_function+=
0x10/0x10
      Feb 10 23:29:54 heisenberg kernel:  transaction_kthread+0x157/0x1c0 [=
btrfs]
      Feb 10 23:29:54 heisenberg kernel:  ? __pfx_transaction_kthread+0x10/=
0x10 [btrfs]
      Feb 10 23:29:54 heisenberg kernel:  kthread+0xfc/0x240
      Feb 10 23:29:54 heisenberg kernel:  ? __pfx_kthread+0x10/0x10
      Feb 10 23:29:54 heisenberg kernel:  ret_from_fork+0x1cc/0x200
      Feb 10 23:29:54 heisenberg kernel:  ? __pfx_kthread+0x10/0x10
      Feb 10 23:29:54 heisenberg kernel:  ret_from_fork_asm+0x1a/0x30
      Feb 10 23:29:54 heisenberg kernel:  </TASK>
      Feb 10 23:29:54 heisenberg kernel: ---[ end trace 0000000000000000 ]-=
--
      Feb 10 23:29:54 heisenberg kernel: BTRFS: error (device dm-2 state A)=
 in btrfs_update_root:153: errno=3D-117 Filesystem corrupted
      Feb 10 23:29:54 heisenberg kernel: BTRFS warning (device dm-2 state E=
A): Skipping commit of aborted transaction.
      Feb 10 23:29:54 heisenberg kernel: BTRFS: error (device dm-2 state EA=
) in cleanup_transaction:2021: errno=3D-117 Filesystem corrupted
      Feb 10 23:29:54 heisenberg kernel: BTRFS warning (device dm-2 state E=
A): failed to rebuild free space tree: -30
      Feb 10 23:29:54 heisenberg kernel: BTRFS error (device dm-2 state EA)=
: commit super ret -30
      Feb 10 23:29:54 heisenberg kernel: BTRFS error (device dm-2 state EA)=
: open_ctree failed: -30
      Feb 10 23:29:54 heisenberg kernel: BTRFS: device label data-a-2 devid=
 1 transid 2622 /dev/mapper/snapdev (253:2) scanned by mount (90020)
      Feb 10 23:29:54 heisenberg kernel: BTRFS info (device dm-2): first mo=
unt of filesystem e1a465db-0227-46e1-9917-d6be986266cd
      Feb 10 23:29:54 heisenberg kernel: BTRFS info (device dm-2): using cr=
c32c (crc32c-lib) checksum algorithm
      Feb 10 23:30:12 heisenberg kernel: BTRFS info (device dm-2): force cl=
earing of disk cache
      Feb 10 23:30:32 heisenberg kernel: BTRFS info (device dm-2): last unm=
ount of filesystem e1a465db-0227-46e1-9917-d6be986266cd
      Feb 10 23:30:33 heisenberg kernel: BTRFS: device label data-a-2 devid=
 1 transid 2622 /dev/mapper/snapdev (253:2) scanned by mount (90632)
      Feb 10 23:30:33 heisenberg kernel: BTRFS info (device dm-2): first mo=
unt of filesystem e1a465db-0227-46e1-9917-d6be986266cd
      Feb 10 23:30:33 heisenberg kernel: BTRFS info (device dm-2): using cr=
c32c (crc32c-lib) checksum algorithm

   "unable to find root key".... "errno=3D-117 Filesystem corrupted"...

3) Similarly if I (from a fresh snapshot) do:
   # mount -o space_cache=3Dv2,clear_cache,rw /dev/mapper/snapdev /mnt/ ; e=
cho $?
   mount: /mnt: fsconfig() failed: No such file or directory.
          dmesg(1) may have more information after failed mount system call=
.
   32

   # mount -o clear_cache,nospace_cache,rw /dev/mapper/snapdev /mnt/ ; echo=
 $?
   mount: /mnt: WARNING: source write-protected, mounted read-only.
   0
  =20
   While the clear_cache,nospace_cache seems to have worked, I still get:
      Feb 10 23:30:51 heisenberg kernel: BTRFS info (device dm-2): rebuildi=
ng free space tree
      Feb 10 23:31:25 heisenberg kernel: BTRFS critical (device dm-2): unab=
le to find root key (10 132 0) in tree 1
      Feb 10 23:31:25 heisenberg kernel: ------------[ cut here ]----------=
--
      Feb 10 23:31:25 heisenberg kernel: BTRFS: Transaction aborted (error =
-117)
      Feb 10 23:31:25 heisenberg kernel: WARNING: CPU: 15 PID: 90703 at fs/=
btrfs/root-tree.c:153 btrfs_update_root+0x229/0x3e0 [btrfs]
      Feb 10 23:31:25 heisenberg kernel: Modules linked in: sg uas dm_snaps=
hot dm_bufio loop nft_fib_ipv6 nft_ct nft_fib_ipv4 nft_fib wireguard libcur=
ve25519 libchacha20poly1305 libchacha ip6_udp_tunnel udp_tunnel libpoly1305=
 cmac ccm snd_seq_dummy snd_hrtimer snd_seq snd_ctl_led snd_soc_skl_hda_dsp=
 snd_soc_intel_sof_board_helpers snd_sof_probes snd_soc_intel_hda_dsp_commo=
n xe snd_hda_codec_intelhdmi snd_hda_codec_alc269 drm_gpuvm drm_gpusvm_help=
er snd_hda_scodec_component gpu_sched snd_hda_codec_realtek_lib drm_ttm_hel=
per snd_hda_codec_generic snd_soc_dmic drm_exec snd_hda_intel drm_suballoc_=
helper ip6t_REJECT nf_reject_ipv6 snd_sof_pci_intel_tgl ipt_REJECT snd_sof_=
pci_intel_cnl nf_reject_ipv4 snd_sof_intel_hda_generic xt_tcpudp soundwire_=
intel xt_conntrack nf_conntrack snd_sof_intel_hda_sdw_bpt snd_sof_intel_hda=
_common nf_defrag_ipv6 nf_defrag_ipv4 snd_soc_hdac_hda nft_compat snd_sof_i=
ntel_hda_mlink snd_sof_intel_hda nf_tables snd_hda_codec_hdmi soundwire_cad=
ence binfmt_misc x_tables snd_sof_pci snd_sof_xtensa_dsp snd_sof i915
      Feb 10 23:31:25 heisenberg kernel:  intel_uncore_frequency intel_unco=
re_frequency_common x86_pkg_temp_thermal snd_sof_utils snd_soc_acpi_intel_m=
atch intel_powerclamp snd_soc_acpi_intel_sdca_quirks soundwire_generic_allo=
cation snd_soc_acpi crc8 soundwire_bus coretemp snd_soc_sdca iwlmvm joydev =
snd_soc_avs kvm_intel snd_soc_hda_codec mac80211 snd_hda_ext_core kvm snd_h=
da_codec drm_buddy snd_hda_core ttm processor_thermal_device_pci uvcvideo s=
nd_usb_audio libarc4 btusb processor_thermal_device drm_display_helper snd_=
intel_dspcfg processor_thermal_wt_hint videobuf2_vmalloc platform_temperatu=
re_control btmtk irqbypass snd_intel_sdw_acpi processor_thermal_soc_slider =
iTCO_wdt uvc iwlwifi snd_soc_core cec btrtl hid_multitouch snd_usbmidi_lib =
videobuf2_memops ghash_clmulni_intel platform_profile intel_pmc_bxt snd_hwd=
ep rc_core btbcm sdhci_pci videobuf2_v4l2 snd_rawmidi btintel rapl snd_comp=
ress drm_client_lib iTCO_vendor_support processor_thermal_rfim intel_rapl_m=
sr hid_generic sdhci_uhs2 bluetooth cfg80211 videodev mei_pxp mei_hdcp watc=
hdog
      Feb 10 23:31:25 heisenberg kernel:  intel_pmc_core wmi_bmof ee1004 sn=
d_pcm_dmaengine processor_thermal_rapl snd_seq_device intel_cstate ucsi_acp=
i drm_kms_helper sdhci videobuf2_common pmt_telemetry snd_pcm intel_rapl_co=
mmon i2c_hid_acpi typec_ucsi i2c_algo_bit pmt_discovery processor_thermal_w=
t_req i2c_hid ecdh_generic cqhci fujitsu_laptop mc usbhid snd_timer intel_u=
ncore mmc_core crc16 typec int3400_thermal pmt_class hid video processor_th=
ermal_power_floor intel_lpss_pci intel_pmc_ssram_telemetry roles battery bu=
tton acpi_thermal_rel snd mei_me intel_lpss processor_thermal_mbox wmi mei =
acpi_pad i2c_i801 intel_vsec int340x_thermal_zone rfkill soundcore ac acpi_=
tad idma64 i2c_smbus igen6_edac ppdev parport_pc lp drm parport efi_pstore =
configfs nfnetlink autofs4 crc32c_cryptoapi sd_mod dm_crypt dm_mod raid10 r=
aid456 async_raid6_recov async_memcpy async_pq async_xor async_tx raid1 rai=
d0 md_mod usb_storage scsi_mod scsi_common btrfs blake2b_generic xor raid6_=
pq xhci_pci xhci_hcd nvme evdev nvme_core thunderbolt usbcore serio_raw aes=
ni_intel
      Feb 10 23:31:25 heisenberg kernel:  e1000e pcspkr nvme_keyring intel_=
hid nvme_auth hkdf sparse_keymap fan usb_common efivarfs
      Feb 10 23:31:25 heisenberg kernel: CPU: 15 UID: 0 PID: 90703 Comm: bt=
rfs-transacti Tainted: G        W           6.18.9+deb14-amd64 #1 PREEMPT(l=
azy)  Debian 6.18.9-1=20
      Feb 10 23:31:25 heisenberg kernel: Tainted: [W]=3DWARN
      Feb 10 23:31:25 heisenberg kernel: Hardware name: FUJITSU CLIENT COMP=
UTING LIMITED LIFEBOOK U7512/FJNB2F4, BIOS Version 2.35 07/01/2025
      Feb 10 23:31:25 heisenberg kernel: RIP: 0010:btrfs_update_root+0x229/=
0x3e0 [btrfs]
      Feb 10 23:31:25 heisenberg kernel: Code: 84 21 c6 49 8b 45 60 48 05 b=
0 0a 00 00 f0 48 0f ba 28 02 0f 82 b5 3b 0e 00 be 8b ff ff ff 48 c7 c7 c8 0=
d 8e c0 e8 b7 6e 13 c6 <0f> 0b 41 b8 01 00 00 00 41 83 e0 01 b9 8b ff ff ff=
 ba 99 00 00 00
      Feb 10 23:31:25 heisenberg kernel: RSP: 0018:ffffcfc0c2ef3d28 EFLAGS:=
 00010246
      Feb 10 23:31:25 heisenberg kernel: RAX: 0000000000000000 RBX: ffff8df=
f1af48e00 RCX: 0000000000000027
      Feb 10 23:31:25 heisenberg kernel: RDX: ffff8e022f7dce48 RSI: 0000000=
000000001 RDI: ffff8e022f7dce40
      Feb 10 23:31:25 heisenberg kernel: RBP: 0000000000000001 R08: 0000000=
000000000 R09: ffffcfc0c2ef3bc8
      Feb 10 23:31:25 heisenberg kernel: R10: ffffffff888d98f8 R11: 0000000=
0ffffffa1 R12: ffff8df3007dc000
      Feb 10 23:31:25 heisenberg kernel: R13: ffff8df301ba8150 R14: ffff8df=
3707b5000 R15: ffff8df8994b4040
      Feb 10 23:31:25 heisenberg kernel: FS:  0000000000000000(0000) GS:fff=
f8e02a638c000(0000) knlGS:0000000000000000
      Feb 10 23:31:25 heisenberg kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0=
000000080050033
      Feb 10 23:31:25 heisenberg kernel: CR2: 00007f45ffa20000 CR3: 0000000=
a1642c004 CR4: 0000000000f72ef0
      Feb 10 23:31:25 heisenberg kernel: PKRU: 55555554
      Feb 10 23:31:25 heisenberg kernel: Call Trace:
      Feb 10 23:31:25 heisenberg kernel:  <TASK>
      Feb 10 23:31:25 heisenberg kernel:  commit_cowonly_roots+0x1d5/0x250 =
[btrfs]
      Feb 10 23:31:25 heisenberg kernel:  btrfs_commit_transaction+0x371/0x=
df0 [btrfs]
      Feb 10 23:31:25 heisenberg kernel:  ? start_transaction+0x228/0x840 [=
btrfs]
      Feb 10 23:31:25 heisenberg kernel:  ? __pfx_autoremove_wake_function+=
0x10/0x10
      Feb 10 23:31:25 heisenberg kernel:  transaction_kthread+0x157/0x1c0 [=
btrfs]
      Feb 10 23:31:25 heisenberg kernel:  ? __pfx_transaction_kthread+0x10/=
0x10 [btrfs]
      Feb 10 23:31:25 heisenberg kernel:  kthread+0xfc/0x240
      Feb 10 23:31:25 heisenberg kernel:  ? __pfx_kthread+0x10/0x10
      Feb 10 23:31:25 heisenberg kernel:  ret_from_fork+0x1cc/0x200
      Feb 10 23:31:25 heisenberg kernel:  ? __pfx_kthread+0x10/0x10
      Feb 10 23:31:25 heisenberg kernel:  ret_from_fork_asm+0x1a/0x30
      Feb 10 23:31:25 heisenberg kernel:  </TASK>
      Feb 10 23:31:25 heisenberg kernel: ---[ end trace 0000000000000000 ]-=
--
      Feb 10 23:31:25 heisenberg kernel: BTRFS: error (device dm-2 state A)=
 in btrfs_update_root:153: errno=3D-117 Filesystem corrupted
      Feb 10 23:31:25 heisenberg kernel: BTRFS warning (device dm-2 state E=
A): Skipping commit of aborted transaction.
      Feb 10 23:31:25 heisenberg kernel: BTRFS: error (device dm-2 state EA=
) in cleanup_transaction:2021: errno=3D-117 Filesystem corrupted
      Feb 10 23:31:25 heisenberg kernel: BTRFS warning (device dm-2 state E=
A): failed to rebuild free space tree: -30
      Feb 10 23:31:25 heisenberg kernel: BTRFS error (device dm-2 state EA)=
: commit super ret -30
      Feb 10 23:31:25 heisenberg kernel: BTRFS error (device dm-2 state EA)=
: open_ctree failed: -30
      Feb 10 23:31:25 heisenberg kernel: BTRFS: device label data-a-2 devid=
 1 transid 2622 /dev/mapper/snapdev (253:2) scanned by mount (90632)
      Feb 10 23:31:25 heisenberg kernel: BTRFS info (device dm-2): first mo=
unt of filesystem e1a465db-0227-46e1-9917-d6be986266cd
      Feb 10 23:31:25 heisenberg kernel: BTRFS info (device dm-2): using cr=
c32c (crc32c-lib) checksum algorithm
      Feb 10 23:31:42 heisenberg kernel: BTRFS info (device dm-2): force cl=
earing of disk cache
      Feb 10 23:31:50 heisenberg kernel: BTRFS info (device dm-2): last unm=
ount of filesystem e1a465db-0227-46e1-9917-d6be986266cd
     =20
   If I now just:
   # mount -o rw /dev/mapper/snapdev /mnt/ ; echo $?
   0
  =20
   it seems to work, but kernel gives:
      Feb 10 23:31:55 heisenberg kernel: BTRFS: device label data-a-2 devid=
 1 transid 2622 /dev/mapper/snapdev (253:2) scanned by mount (90897)
      Feb 10 23:31:55 heisenberg kernel: BTRFS info (device dm-2): first mo=
unt of filesystem e1a465db-0227-46e1-9917-d6be986266cd
      Feb 10 23:31:55 heisenberg kernel: BTRFS info (device dm-2): using cr=
c32c (crc32c-lib) checksum algorithm
      Feb 10 23:32:12 heisenberg kernel: BTRFS info (device dm-2): checking=
 UUID tree
      Feb 10 23:32:12 heisenberg kernel: BTRFS info (device dm-2): enabling=
 free space tree
      Feb 10 23:32:18 heisenberg kernel: BTRFS warning (device dm-2): missi=
ng free space info for 12249277136896
      Feb 10 23:32:18 heisenberg kernel: BTRFS warning (device dm-2): missi=
ng free space info for 12491942789120
      Feb 10 23:32:18 heisenberg kernel: BTRFS warning (device dm-2): missi=
ng free space info for 13270405611520
      Feb 10 23:32:18 heisenberg kernel: BTRFS warning (device dm-2): missi=
ng free space info for 13459384172544
      Feb 10 23:32:18 heisenberg kernel: BTRFS warning (device dm-2): missi=
ng free space info for 13979075215360
      Feb 10 23:32:18 heisenberg kernel: BTRFS warning (device dm-2): missi=
ng free space info for 14367769755648
      Feb 10 23:32:18 heisenberg kernel: BTRFS warning (device dm-2): missi=
ng free space info for 14839142416384
      Feb 10 23:32:18 heisenberg kernel: BTRFS warning (device dm-2): missi=
ng free space info for 15028120977408
      Feb 10 23:32:18 heisenberg kernel: BTRFS warning (device dm-2): missi=
ng free space info for 15582171758592
      Feb 10 23:32:18 heisenberg kernel: ------------[ cut here ]----------=
--
      Feb 10 23:32:18 heisenberg kernel: WARNING: CPU: 5 PID: 90970 at fs/b=
trfs/extent-tree.c:3230 __btrfs_free_extent.isra.0+0x7ac/0x1010 [btrfs]
      Feb 10 23:32:18 heisenberg kernel: Modules linked in: sg uas dm_snaps=
hot dm_bufio loop nft_fib_ipv6 nft_ct nft_fib_ipv4 nft_fib wireguard libcur=
ve25519 libchacha20poly1305 libchacha ip6_udp_tunnel udp_tunnel libpoly1305=
 cmac ccm snd_seq_dummy snd_hrtimer snd_seq snd_ctl_led snd_soc_skl_hda_dsp=
 snd_soc_intel_sof_board_helpers snd_sof_probes snd_soc_intel_hda_dsp_commo=
n xe snd_hda_codec_intelhdmi snd_hda_codec_alc269 drm_gpuvm drm_gpusvm_help=
er snd_hda_scodec_component gpu_sched snd_hda_codec_realtek_lib drm_ttm_hel=
per snd_hda_codec_generic snd_soc_dmic drm_exec snd_hda_intel drm_suballoc_=
helper ip6t_REJECT nf_reject_ipv6 snd_sof_pci_intel_tgl ipt_REJECT snd_sof_=
pci_intel_cnl nf_reject_ipv4 snd_sof_intel_hda_generic xt_tcpudp soundwire_=
intel xt_conntrack nf_conntrack snd_sof_intel_hda_sdw_bpt snd_sof_intel_hda=
_common nf_defrag_ipv6 nf_defrag_ipv4 snd_soc_hdac_hda nft_compat snd_sof_i=
ntel_hda_mlink snd_sof_intel_hda nf_tables snd_hda_codec_hdmi soundwire_cad=
ence binfmt_misc x_tables snd_sof_pci snd_sof_xtensa_dsp snd_sof i915
      Feb 10 23:32:18 heisenberg kernel:  intel_uncore_frequency intel_unco=
re_frequency_common x86_pkg_temp_thermal snd_sof_utils snd_soc_acpi_intel_m=
atch intel_powerclamp snd_soc_acpi_intel_sdca_quirks soundwire_generic_allo=
cation snd_soc_acpi crc8 soundwire_bus coretemp snd_soc_sdca iwlmvm joydev =
snd_soc_avs kvm_intel snd_soc_hda_codec mac80211 snd_hda_ext_core kvm snd_h=
da_codec drm_buddy snd_hda_core ttm processor_thermal_device_pci uvcvideo s=
nd_usb_audio libarc4 btusb processor_thermal_device drm_display_helper snd_=
intel_dspcfg processor_thermal_wt_hint videobuf2_vmalloc platform_temperatu=
re_control btmtk irqbypass snd_intel_sdw_acpi processor_thermal_soc_slider =
iTCO_wdt uvc iwlwifi snd_soc_core cec btrtl hid_multitouch snd_usbmidi_lib =
videobuf2_memops ghash_clmulni_intel platform_profile intel_pmc_bxt snd_hwd=
ep rc_core btbcm sdhci_pci videobuf2_v4l2 snd_rawmidi btintel rapl snd_comp=
ress drm_client_lib iTCO_vendor_support processor_thermal_rfim intel_rapl_m=
sr hid_generic sdhci_uhs2 bluetooth cfg80211 videodev mei_pxp mei_hdcp watc=
hdog
      Feb 10 23:32:18 heisenberg kernel:  intel_pmc_core wmi_bmof ee1004 sn=
d_pcm_dmaengine processor_thermal_rapl snd_seq_device intel_cstate ucsi_acp=
i drm_kms_helper sdhci videobuf2_common pmt_telemetry snd_pcm intel_rapl_co=
mmon i2c_hid_acpi typec_ucsi i2c_algo_bit pmt_discovery processor_thermal_w=
t_req i2c_hid ecdh_generic cqhci fujitsu_laptop mc usbhid snd_timer intel_u=
ncore mmc_core crc16 typec int3400_thermal pmt_class hid video processor_th=
ermal_power_floor intel_lpss_pci intel_pmc_ssram_telemetry roles battery bu=
tton acpi_thermal_rel snd mei_me intel_lpss processor_thermal_mbox wmi mei =
acpi_pad i2c_i801 intel_vsec int340x_thermal_zone rfkill soundcore ac acpi_=
tad idma64 i2c_smbus igen6_edac ppdev parport_pc lp drm parport efi_pstore =
configfs nfnetlink autofs4 crc32c_cryptoapi sd_mod dm_crypt dm_mod raid10 r=
aid456 async_raid6_recov async_memcpy async_pq async_xor async_tx raid1 rai=
d0 md_mod usb_storage scsi_mod scsi_common btrfs blake2b_generic xor raid6_=
pq xhci_pci xhci_hcd nvme evdev nvme_core thunderbolt usbcore serio_raw aes=
ni_intel
      Feb 10 23:32:18 heisenberg kernel:  e1000e pcspkr nvme_keyring intel_=
hid nvme_auth hkdf sparse_keymap fan usb_common efivarfs
      Feb 10 23:32:18 heisenberg kernel: CPU: 5 UID: 0 PID: 90970 Comm: umo=
unt Tainted: G        W           6.18.9+deb14-amd64 #1 PREEMPT(lazy)  Debi=
an 6.18.9-1=20
      Feb 10 23:32:18 heisenberg kernel: Tainted: [W]=3DWARN
      Feb 10 23:32:18 heisenberg kernel: Hardware name: FUJITSU CLIENT COMP=
UTING LIMITED LIFEBOOK U7512/FJNB2F4, BIOS Version 2.35 07/01/2025
      Feb 10 23:32:18 heisenberg kernel: RIP: 0010:__btrfs_free_extent.isra=
.0+0x7ac/0x1010 [btrfs]
      Feb 10 23:32:18 heisenberg kernel: Code: 00 f0 48 0f ba 28 02 0f 82 7=
2 08 00 00 be 8b ff ff ff 48 c7 c7 60 f9 8d c0 e8 f0 ee 13 c6 0f 0b c6 44 2=
4 2f 01 e9 00 b6 0e 00 <0f> 0b f0 48 0f ba a8 b0 0a 00 00 02 0f 82 7a b3 0e=
 00 be 8b ff ff
      Feb 10 23:32:18 heisenberg kernel: RSP: 0018:ffffcfc0e6d77b48 EFLAGS:=
 00010246
      Feb 10 23:32:18 heisenberg kernel: RAX: ffff8df2c5273000 RBX: 0000088=
f48cf4000 RCX: ffff8dfbae1da620
      Feb 10 23:32:18 heisenberg kernel: RDX: 0000000000000000 RSI: 0000000=
000000002 RDI: ffff8dfbae1da620
      Feb 10 23:32:18 heisenberg kernel: RBP: 0000000000000000 R08: 0000000=
000000000 R09: 0000000000000001
      Feb 10 23:32:18 heisenberg kernel: R10: 0000000000000fff R11: 0000000=
000000002 R12: 0000000000000000
      Feb 10 23:32:18 heisenberg kernel: R13: 0000000000000000 R14: ffff8df=
bae1da620 R15: ffff8dfbae1da7e0
      Feb 10 23:32:18 heisenberg kernel: FS:  00007efcdcd72840(0000) GS:fff=
f8e02a610c000(0000) knlGS:0000000000000000
      Feb 10 23:32:18 heisenberg kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0=
000000080050033
      Feb 10 23:32:18 heisenberg kernel: CR2: 00007f556ff20000 CR3: 0000000=
f2c00b004 CR4: 0000000000f72ef0
      Feb 10 23:32:18 heisenberg kernel: PKRU: 55555554
      Feb 10 23:32:18 heisenberg kernel: Call Trace:
      Feb 10 23:32:18 heisenberg kernel:  <TASK>
      Feb 10 23:32:18 heisenberg kernel:  ? btrfs_merge_delayed_refs+0x1bb/=
0x290 [btrfs]
      Feb 10 23:32:18 heisenberg kernel:  __btrfs_run_delayed_refs+0x2dc/0x=
f70 [btrfs]
      Feb 10 23:32:18 heisenberg kernel:  btrfs_run_delayed_refs+0x8c/0x120=
 [btrfs]
      Feb 10 23:32:18 heisenberg kernel:  commit_cowonly_roots+0x1fd/0x250 =
[btrfs]
      Feb 10 23:32:18 heisenberg kernel:  btrfs_commit_transaction+0x371/0x=
df0 [btrfs]
      Feb 10 23:32:18 heisenberg kernel:  ? btrfs_attach_transaction_barrie=
r+0x25/0x70 [btrfs]
      Feb 10 23:32:18 heisenberg kernel:  sync_filesystem+0x7e/0xa0
      Feb 10 23:32:18 heisenberg kernel:  generic_shutdown_super+0x2a/0x100
      Feb 10 23:32:18 heisenberg kernel:  kill_anon_super+0x16/0x40
      Feb 10 23:32:18 heisenberg kernel:  btrfs_kill_super+0x16/0x20 [btrfs=
]
      Feb 10 23:32:18 heisenberg kernel:  deactivate_locked_super+0x33/0xb0
      Feb 10 23:32:18 heisenberg kernel:  cleanup_mnt+0xb4/0x140
      Feb 10 23:32:18 heisenberg kernel:  task_work_run+0x5d/0x90
      Feb 10 23:32:18 heisenberg kernel:  exit_to_user_mode_loop+0x117/0x13=
0
      Feb 10 23:32:18 heisenberg kernel:  do_syscall_64+0x1f6/0x7f0
      Feb 10 23:32:18 heisenberg kernel:  ? exc_page_fault+0x7e/0x1a0
      Feb 10 23:32:18 heisenberg kernel:  entry_SYSCALL_64_after_hwframe+0x=
76/0x7e
      Feb 10 23:32:18 heisenberg kernel: RIP: 0033:0x7efcdcfcc7d7
      Feb 10 23:32:18 heisenberg kernel: Code: 0d 00 f7 d8 64 89 02 b8 ff f=
f ff ff c3 66 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 0=
0 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 8b 15 09 26 0d 00 f7=
 d8 64 89 02 b8
      Feb 10 23:32:18 heisenberg kernel: RSP: 002b:00007ffce0e170d8 EFLAGS:=
 00000246 ORIG_RAX: 00000000000000a6
      Feb 10 23:32:18 heisenberg kernel: RAX: 0000000000000000 RBX: 0000000=
000000000 RCX: 00007efcdcfcc7d7
      Feb 10 23:32:18 heisenberg kernel: RDX: 0000000000000000 RSI: 0000000=
000000000 RDI: 0000556b55193fc0
      Feb 10 23:32:18 heisenberg kernel: RBP: 00007efcdd12926c R08: 00007ff=
ce0e15ec0 R09: 0000000000000000
      Feb 10 23:32:18 heisenberg kernel: R10: 0000000000000000 R11: 0000000=
000000246 R12: 0000556b55193c88
      Feb 10 23:32:18 heisenberg kernel: R13: 0000556b55193fc0 R14: 0000556=
b55193b80 R15: 0000000000000000
      Feb 10 23:32:18 heisenberg kernel:  </TASK>
      Feb 10 23:32:18 heisenberg kernel: ---[ end trace 0000000000000000 ]-=
--
      Feb 10 23:32:18 heisenberg kernel: ------------[ cut here ]----------=
--
      Feb 10 23:32:18 heisenberg kernel: BTRFS: Transaction aborted (error =
-117)
      Feb 10 23:32:18 heisenberg kernel: WARNING: CPU: 5 PID: 90970 at fs/b=
trfs/extent-tree.c:3231 __btrfs_free_extent.isra.0+0x7cf/0x1010 [btrfs]
      Feb 10 23:32:18 heisenberg kernel: Modules linked in: sg uas dm_snaps=
hot dm_bufio loop nft_fib_ipv6 nft_ct nft_fib_ipv4 nft_fib wireguard libcur=
ve25519 libchacha20poly1305 libchacha ip6_udp_tunnel udp_tunnel libpoly1305=
 cmac ccm snd_seq_dummy snd_hrtimer snd_seq snd_ctl_led snd_soc_skl_hda_dsp=
 snd_soc_intel_sof_board_helpers snd_sof_probes snd_soc_intel_hda_dsp_commo=
n xe snd_hda_codec_intelhdmi snd_hda_codec_alc269 drm_gpuvm drm_gpusvm_help=
er snd_hda_scodec_component gpu_sched snd_hda_codec_realtek_lib drm_ttm_hel=
per snd_hda_codec_generic snd_soc_dmic drm_exec snd_hda_intel drm_suballoc_=
helper ip6t_REJECT nf_reject_ipv6 snd_sof_pci_intel_tgl ipt_REJECT snd_sof_=
pci_intel_cnl nf_reject_ipv4 snd_sof_intel_hda_generic xt_tcpudp soundwire_=
intel xt_conntrack nf_conntrack snd_sof_intel_hda_sdw_bpt snd_sof_intel_hda=
_common nf_defrag_ipv6 nf_defrag_ipv4 snd_soc_hdac_hda nft_compat snd_sof_i=
ntel_hda_mlink snd_sof_intel_hda nf_tables snd_hda_codec_hdmi soundwire_cad=
ence binfmt_misc x_tables snd_sof_pci snd_sof_xtensa_dsp snd_sof i915
      Feb 10 23:32:18 heisenberg kernel:  intel_uncore_frequency intel_unco=
re_frequency_common x86_pkg_temp_thermal snd_sof_utils snd_soc_acpi_intel_m=
atch intel_powerclamp snd_soc_acpi_intel_sdca_quirks soundwire_generic_allo=
cation snd_soc_acpi crc8 soundwire_bus coretemp snd_soc_sdca iwlmvm joydev =
snd_soc_avs kvm_intel snd_soc_hda_codec mac80211 snd_hda_ext_core kvm snd_h=
da_codec drm_buddy snd_hda_core ttm processor_thermal_device_pci uvcvideo s=
nd_usb_audio libarc4 btusb processor_thermal_device drm_display_helper snd_=
intel_dspcfg processor_thermal_wt_hint videobuf2_vmalloc platform_temperatu=
re_control btmtk irqbypass snd_intel_sdw_acpi processor_thermal_soc_slider =
iTCO_wdt uvc iwlwifi snd_soc_core cec btrtl hid_multitouch snd_usbmidi_lib =
videobuf2_memops ghash_clmulni_intel platform_profile intel_pmc_bxt snd_hwd=
ep rc_core btbcm sdhci_pci videobuf2_v4l2 snd_rawmidi btintel rapl snd_comp=
ress drm_client_lib iTCO_vendor_support processor_thermal_rfim intel_rapl_m=
sr hid_generic sdhci_uhs2 bluetooth cfg80211 videodev mei_pxp mei_hdcp watc=
hdog
      Feb 10 23:32:18 heisenberg kernel:  intel_pmc_core wmi_bmof ee1004 sn=
d_pcm_dmaengine processor_thermal_rapl snd_seq_device intel_cstate ucsi_acp=
i drm_kms_helper sdhci videobuf2_common pmt_telemetry snd_pcm intel_rapl_co=
mmon i2c_hid_acpi typec_ucsi i2c_algo_bit pmt_discovery processor_thermal_w=
t_req i2c_hid ecdh_generic cqhci fujitsu_laptop mc usbhid snd_timer intel_u=
ncore mmc_core crc16 typec int3400_thermal pmt_class hid video processor_th=
ermal_power_floor intel_lpss_pci intel_pmc_ssram_telemetry roles battery bu=
tton acpi_thermal_rel snd mei_me intel_lpss processor_thermal_mbox wmi mei =
acpi_pad i2c_i801 intel_vsec int340x_thermal_zone rfkill soundcore ac acpi_=
tad idma64 i2c_smbus igen6_edac ppdev parport_pc lp drm parport efi_pstore =
configfs nfnetlink autofs4 crc32c_cryptoapi sd_mod dm_crypt dm_mod raid10 r=
aid456 async_raid6_recov async_memcpy async_pq async_xor async_tx raid1 rai=
d0 md_mod usb_storage scsi_mod scsi_common btrfs blake2b_generic xor raid6_=
pq xhci_pci xhci_hcd nvme evdev nvme_core thunderbolt usbcore serio_raw aes=
ni_intel
      Feb 10 23:32:18 heisenberg kernel:  e1000e pcspkr nvme_keyring intel_=
hid nvme_auth hkdf sparse_keymap fan usb_common efivarfs
      Feb 10 23:32:18 heisenberg kernel: CPU: 5 UID: 0 PID: 90970 Comm: umo=
unt Tainted: G        W           6.18.9+deb14-amd64 #1 PREEMPT(lazy)  Debi=
an 6.18.9-1=20
      Feb 10 23:32:18 heisenberg kernel: Tainted: [W]=3DWARN
      Feb 10 23:32:18 heisenberg kernel: Hardware name: FUJITSU CLIENT COMP=
UTING LIMITED LIFEBOOK U7512/FJNB2F4, BIOS Version 2.35 07/01/2025
      Feb 10 23:32:18 heisenberg kernel: RIP: 0010:__btrfs_free_extent.isra=
.0+0x7cf/0x1010 [btrfs]
      Feb 10 23:32:18 heisenberg kernel: Code: 2f 01 e9 00 b6 0e 00 0f 0b f=
0 48 0f ba a8 b0 0a 00 00 02 0f 82 7a b3 0e 00 be 8b ff ff ff 48 c7 c7 60 f=
9 8d c0 e8 c1 ee 13 c6 <0f> 0b c6 44 24 2f 01 e9 5d b3 0e 00 89 04 24 e8 ed=
 79 21 c6 48 8b
      Feb 10 23:32:18 heisenberg kernel: RSP: 0018:ffffcfc0e6d77b48 EFLAGS:=
 00010246
      Feb 10 23:32:18 heisenberg kernel: RAX: 0000000000000000 RBX: 0000088=
f48cf4000 RCX: 0000000000000027
      Feb 10 23:32:18 heisenberg kernel: RDX: ffff8e022f55ce48 RSI: 0000000=
000000001 RDI: ffff8e022f55ce40
      Feb 10 23:32:18 heisenberg kernel: RBP: 0000000000000000 R08: 0000000=
000000000 R09: ffffcfc0e6d779e8
      Feb 10 23:32:18 heisenberg kernel: R10: ffffffff88883f78 R11: 0000000=
100000011 R12: 0000000000000000
      Feb 10 23:32:18 heisenberg kernel: R13: 0000000000000000 R14: ffff8df=
bae1da620 R15: ffff8dfbae1da7e0
      Feb 10 23:32:18 heisenberg kernel: FS:  00007efcdcd72840(0000) GS:fff=
f8e02a610c000(0000) knlGS:0000000000000000
      Feb 10 23:32:18 heisenberg kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0=
000000080050033
      Feb 10 23:32:18 heisenberg kernel: CR2: 00007f556ff20000 CR3: 0000000=
f2c00b004 CR4: 0000000000f72ef0
      Feb 10 23:32:18 heisenberg kernel: PKRU: 55555554
      Feb 10 23:32:18 heisenberg kernel: Call Trace:
      Feb 10 23:32:18 heisenberg kernel:  <TASK>
      Feb 10 23:32:18 heisenberg kernel:  ? btrfs_merge_delayed_refs+0x1bb/=
0x290 [btrfs]
      Feb 10 23:32:18 heisenberg kernel:  __btrfs_run_delayed_refs+0x2dc/0x=
f70 [btrfs]
      Feb 10 23:32:18 heisenberg kernel:  btrfs_run_delayed_refs+0x8c/0x120=
 [btrfs]
      Feb 10 23:32:18 heisenberg kernel:  commit_cowonly_roots+0x1fd/0x250 =
[btrfs]
      Feb 10 23:32:18 heisenberg kernel:  btrfs_commit_transaction+0x371/0x=
df0 [btrfs]
      Feb 10 23:32:18 heisenberg kernel:  ? btrfs_attach_transaction_barrie=
r+0x25/0x70 [btrfs]
      Feb 10 23:32:18 heisenberg kernel:  sync_filesystem+0x7e/0xa0
      Feb 10 23:32:18 heisenberg kernel:  generic_shutdown_super+0x2a/0x100
      Feb 10 23:32:18 heisenberg kernel:  kill_anon_super+0x16/0x40
      Feb 10 23:32:18 heisenberg kernel:  btrfs_kill_super+0x16/0x20 [btrfs=
]
      Feb 10 23:32:18 heisenberg kernel:  deactivate_locked_super+0x33/0xb0
      Feb 10 23:32:18 heisenberg kernel:  cleanup_mnt+0xb4/0x140
      Feb 10 23:32:18 heisenberg kernel:  task_work_run+0x5d/0x90
      Feb 10 23:32:18 heisenberg kernel:  exit_to_user_mode_loop+0x117/0x13=
0
      Feb 10 23:32:18 heisenberg kernel:  do_syscall_64+0x1f6/0x7f0
      Feb 10 23:32:18 heisenberg kernel:  ? exc_page_fault+0x7e/0x1a0
      Feb 10 23:32:18 heisenberg kernel:  entry_SYSCALL_64_after_hwframe+0x=
76/0x7e
      Feb 10 23:32:18 heisenberg kernel: RIP: 0033:0x7efcdcfcc7d7
      Feb 10 23:32:18 heisenberg kernel: Code: 0d 00 f7 d8 64 89 02 b8 ff f=
f ff ff c3 66 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 0=
0 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 8b 15 09 26 0d 00 f7=
 d8 64 89 02 b8
      Feb 10 23:32:18 heisenberg kernel: RSP: 002b:00007ffce0e170d8 EFLAGS:=
 00000246 ORIG_RAX: 00000000000000a6
      Feb 10 23:32:18 heisenberg kernel: RAX: 0000000000000000 RBX: 0000000=
000000000 RCX: 00007efcdcfcc7d7
      Feb 10 23:32:18 heisenberg kernel: RDX: 0000000000000000 RSI: 0000000=
000000000 RDI: 0000556b55193fc0
      Feb 10 23:32:18 heisenberg kernel: RBP: 00007efcdd12926c R08: 00007ff=
ce0e15ec0 R09: 0000000000000000
      Feb 10 23:32:18 heisenberg kernel: R10: 0000000000000000 R11: 0000000=
000000246 R12: 0000556b55193c88
      Feb 10 23:32:18 heisenberg kernel: R13: 0000556b55193fc0 R14: 0000556=
b55193b80 R15: 0000000000000000
      Feb 10 23:32:18 heisenberg kernel:  </TASK>
      Feb 10 23:32:18 heisenberg kernel: ---[ end trace 0000000000000000 ]-=
--
      Feb 10 23:32:18 heisenberg kernel: BTRFS: error (device dm-2 state A)=
 in __btrfs_free_extent:3231: errno=3D-117 Filesystem corrupted
      Feb 10 23:32:18 heisenberg kernel: BTRFS info (device dm-2 state EA):=
 forced readonly
      Feb 10 23:32:18 heisenberg kernel: BTRFS info (device dm-2 state EA):=
 leaf 10371698147328 gen 2623 total ptrs 170 free space 6387 owner 2
      Feb 10 23:32:18 heisenberg kernel:         item 0 key (9411494248448 =
METADATA_ITEM 0) itemoff 16250 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1964 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 1 key (9411494264832 =
METADATA_ITEM 0) itemoff 16217 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1819 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 2 key (9411494281216 =
METADATA_ITEM 0) itemoff 16184 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1819 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 3 key (9411494297600 =
METADATA_ITEM 0) itemoff 16151 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1819 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 4 key (9411494313984 =
METADATA_ITEM 0) itemoff 16118 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1819 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 5 key (9411494330368 =
METADATA_ITEM 0) itemoff 16085 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1819 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 6 key (9411494346752 =
METADATA_ITEM 0) itemoff 16052 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1819 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 7 key (9411494363136 =
METADATA_ITEM 0) itemoff 16019 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1819 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 8 key (9411494379520 =
METADATA_ITEM 0) itemoff 15986 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1819 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 9 key (9411494395904 =
METADATA_ITEM 0) itemoff 15953 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1964 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 10 key (9411494412288=
 METADATA_ITEM 0) itemoff 15920 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1964 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 11 key (9411494428672=
 METADATA_ITEM 0) itemoff 15887 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1819 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 12 key (9411494445056=
 METADATA_ITEM 0) itemoff 15854 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1819 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 13 key (9411494461440=
 METADATA_ITEM 0) itemoff 15821 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1819 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 14 key (9411494477824=
 METADATA_ITEM 0) itemoff 15788 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1819 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 15 key (9411494494208=
 METADATA_ITEM 0) itemoff 15755 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1819 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 16 key (9411494510592=
 METADATA_ITEM 0) itemoff 15722 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1819 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 17 key (9411494526976=
 METADATA_ITEM 0) itemoff 15689 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1819 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 18 key (9411494543360=
 METADATA_ITEM 0) itemoff 15656 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1819 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 19 key (9411494559744=
 METADATA_ITEM 0) itemoff 15623 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1819 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 20 key (9411494576128=
 METADATA_ITEM 0) itemoff 15590 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1819 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 21 key (9411494592512=
 METADATA_ITEM 0) itemoff 15557 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1819 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 22 key (9411494608896=
 METADATA_ITEM 0) itemoff 15524 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1819 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 23 key (9411494625280=
 METADATA_ITEM 0) itemoff 15491 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1819 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 24 key (9411494641664=
 METADATA_ITEM 0) itemoff 15458 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1819 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 25 key (9411494658048=
 METADATA_ITEM 0) itemoff 15425 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1963 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 26 key (9411494674432=
 METADATA_ITEM 0) itemoff 15392 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1963 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 27 key (9411494690816=
 METADATA_ITEM 0) itemoff 15359 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1963 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 28 key (9411494707200=
 METADATA_ITEM 0) itemoff 15326 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1963 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 29 key (9411494723584=
 METADATA_ITEM 0) itemoff 15293 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1964 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 30 key (9411494739968=
 METADATA_ITEM 0) itemoff 15224 itemsize 69
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 5 gen =
2161 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 275
      Feb 10 23:32:18 heisenberg kernel:                 ref#1: tree block =
backref root 272
      Feb 10 23:32:18 heisenberg kernel:                 ref#2: tree block =
backref root 267
      Feb 10 23:32:18 heisenberg kernel:                 ref#3: tree block =
backref root 266
      Feb 10 23:32:18 heisenberg kernel:                 ref#4: tree block =
backref root 264
      Feb 10 23:32:18 heisenberg kernel:         item 31 key (9411494756352=
 METADATA_ITEM 0) itemoff 15191 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1964 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 32 key (9411494772736=
 METADATA_ITEM 0) itemoff 15158 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1978 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 2
      Feb 10 23:32:18 heisenberg kernel:         item 33 key (9411494789120=
 METADATA_ITEM 0) itemoff 15125 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1963 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 34 key (9411494805504=
 METADATA_ITEM 0) itemoff 15092 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1963 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 35 key (9411494821888=
 METADATA_ITEM 0) itemoff 15059 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1963 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 36 key (9411494838272=
 METADATA_ITEM 0) itemoff 15026 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1963 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 37 key (9411494854656=
 METADATA_ITEM 0) itemoff 14993 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
2201 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 264
      Feb 10 23:32:18 heisenberg kernel:         item 38 key (9411494871040=
 METADATA_ITEM 0) itemoff 14960 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1978 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 2
      Feb 10 23:32:18 heisenberg kernel:         item 39 key (9411494887424=
 METADATA_ITEM 0) itemoff 14927 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
2623 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 2
      Feb 10 23:32:18 heisenberg kernel:         item 40 key (9411494903808=
 METADATA_ITEM 0) itemoff 14894 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1978 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 2
      Feb 10 23:32:18 heisenberg kernel:         item 41 key (9411494920192=
 METADATA_ITEM 0) itemoff 14861 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1978 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 2
      Feb 10 23:32:18 heisenberg kernel:         item 42 key (9411494936576=
 METADATA_ITEM 0) itemoff 14828 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1978 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 2
      Feb 10 23:32:18 heisenberg kernel:         item 43 key (9411494952960=
 METADATA_ITEM 0) itemoff 14795 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 44 key (9411494969344=
 METADATA_ITEM 0) itemoff 14762 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 45 key (9411494985728=
 METADATA_ITEM 0) itemoff 14729 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 46 key (9411495002112=
 METADATA_ITEM 0) itemoff 14696 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 47 key (9411495018496=
 METADATA_ITEM 0) itemoff 14663 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 48 key (9411495034880=
 METADATA_ITEM 0) itemoff 14630 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 49 key (9411495051264=
 METADATA_ITEM 0) itemoff 14597 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1964 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 50 key (9411495067648=
 METADATA_ITEM 0) itemoff 14564 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 51 key (9411495084032=
 METADATA_ITEM 0) itemoff 14531 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 52 key (9411495100416=
 METADATA_ITEM 0) itemoff 14498 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 53 key (9411495116800=
 METADATA_ITEM 0) itemoff 14465 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 54 key (9411495133184=
 METADATA_ITEM 0) itemoff 14432 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 55 key (9411495149568=
 METADATA_ITEM 0) itemoff 14399 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 56 key (9411495165952=
 METADATA_ITEM 0) itemoff 14366 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 57 key (9411495182336=
 METADATA_ITEM 0) itemoff 14333 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 58 key (9411495198720=
 METADATA_ITEM 0) itemoff 14300 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 59 key (9411495215104=
 METADATA_ITEM 0) itemoff 14267 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 60 key (9411495231488=
 METADATA_ITEM 0) itemoff 14234 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 61 key (9411495247872=
 METADATA_ITEM 0) itemoff 14201 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 62 key (9411495264256=
 METADATA_ITEM 0) itemoff 14168 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 63 key (9411495280640=
 METADATA_ITEM 0) itemoff 14135 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 64 key (9411495297024=
 METADATA_ITEM 0) itemoff 14102 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 65 key (9411495313408=
 METADATA_ITEM 0) itemoff 14069 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 66 key (9411495329792=
 METADATA_ITEM 0) itemoff 14036 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 67 key (9411495346176=
 METADATA_ITEM 0) itemoff 14003 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 68 key (9411495362560=
 METADATA_ITEM 0) itemoff 13970 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 69 key (9411495378944=
 METADATA_ITEM 0) itemoff 13937 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 70 key (9411495395328=
 METADATA_ITEM 0) itemoff 13904 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 71 key (9411495411712=
 METADATA_ITEM 0) itemoff 13871 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 72 key (9411495428096=
 METADATA_ITEM 0) itemoff 13838 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 73 key (9411495444480=
 METADATA_ITEM 0) itemoff 13805 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 74 key (9411495460864=
 METADATA_ITEM 0) itemoff 13772 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 75 key (9411495477248=
 METADATA_ITEM 0) itemoff 13739 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 76 key (9411495493632=
 METADATA_ITEM 0) itemoff 13706 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 77 key (9411495510016=
 METADATA_ITEM 0) itemoff 13673 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 78 key (9411495526400=
 METADATA_ITEM 0) itemoff 13640 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 79 key (9411495542784=
 METADATA_ITEM 0) itemoff 13607 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 80 key (9411495559168=
 METADATA_ITEM 0) itemoff 13574 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 81 key (9411495575552=
 METADATA_ITEM 0) itemoff 13541 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 82 key (9411495591936=
 METADATA_ITEM 0) itemoff 13508 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 83 key (9411495608320=
 METADATA_ITEM 0) itemoff 13475 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 84 key (9411495624704=
 METADATA_ITEM 0) itemoff 13442 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 85 key (9411495641088=
 METADATA_ITEM 0) itemoff 13409 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 86 key (9411495657472=
 METADATA_ITEM 0) itemoff 13376 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 87 key (9411495673856=
 METADATA_ITEM 0) itemoff 13343 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 88 key (9411495690240=
 METADATA_ITEM 0) itemoff 13310 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 89 key (9411495706624=
 METADATA_ITEM 0) itemoff 13277 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 90 key (9411495723008=
 METADATA_ITEM 0) itemoff 13244 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 91 key (9411495739392=
 METADATA_ITEM 0) itemoff 13211 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 92 key (9411495755776=
 METADATA_ITEM 0) itemoff 13178 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 93 key (9411495772160=
 METADATA_ITEM 0) itemoff 13145 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 94 key (9411495788544=
 METADATA_ITEM 0) itemoff 13112 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 95 key (9411495804928=
 METADATA_ITEM 0) itemoff 13079 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 96 key (9411495821312=
 METADATA_ITEM 0) itemoff 13046 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 97 key (9411495837696=
 METADATA_ITEM 0) itemoff 13013 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 98 key (9411495854080=
 METADATA_ITEM 0) itemoff 12980 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 99 key (9411495870464=
 METADATA_ITEM 0) itemoff 12947 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 100 key (941149588684=
8 METADATA_ITEM 0) itemoff 12914 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 101 key (941149590323=
2 METADATA_ITEM 0) itemoff 12881 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 102 key (941149591961=
6 METADATA_ITEM 0) itemoff 12848 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 103 key (941149593600=
0 METADATA_ITEM 0) itemoff 12815 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 104 key (941149595238=
4 METADATA_ITEM 0) itemoff 12782 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 105 key (941149596876=
8 METADATA_ITEM 0) itemoff 12749 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 106 key (941149598515=
2 METADATA_ITEM 0) itemoff 12716 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 107 key (941149600153=
6 METADATA_ITEM 0) itemoff 12683 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 108 key (941149601792=
0 METADATA_ITEM 0) itemoff 12650 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 109 key (941149603430=
4 METADATA_ITEM 0) itemoff 12617 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 110 key (941149605068=
8 METADATA_ITEM 0) itemoff 12584 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 111 key (941149606707=
2 METADATA_ITEM 0) itemoff 12551 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 112 key (941149608345=
6 METADATA_ITEM 0) itemoff 12518 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 113 key (941149609984=
0 METADATA_ITEM 0) itemoff 12485 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 114 key (941149611622=
4 METADATA_ITEM 0) itemoff 12452 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 115 key (941149613260=
8 METADATA_ITEM 0) itemoff 12419 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 116 key (941149614899=
2 METADATA_ITEM 0) itemoff 12386 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 117 key (941149616537=
6 METADATA_ITEM 0) itemoff 12353 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1978 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 2
      Feb 10 23:32:18 heisenberg kernel:         item 118 key (941149618176=
0 METADATA_ITEM 0) itemoff 12320 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1978 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 2
      Feb 10 23:32:18 heisenberg kernel:         item 119 key (941149619814=
4 METADATA_ITEM 0) itemoff 12287 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1959 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 120 key (941149621452=
8 METADATA_ITEM 0) itemoff 12254 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1959 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 121 key (941149623091=
2 METADATA_ITEM 0) itemoff 12221 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1959 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 122 key (941149624729=
6 METADATA_ITEM 0) itemoff 12188 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1959 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 123 key (941149626368=
0 METADATA_ITEM 0) itemoff 12155 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1959 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 124 key (941149628006=
4 METADATA_ITEM 0) itemoff 12122 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 125 key (941149629644=
8 METADATA_ITEM 0) itemoff 12089 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 126 key (941149631283=
2 METADATA_ITEM 0) itemoff 12056 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 127 key (941149632921=
6 METADATA_ITEM 0) itemoff 12023 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 128 key (941149634560=
0 METADATA_ITEM 0) itemoff 11990 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 129 key (941149636198=
4 METADATA_ITEM 0) itemoff 11957 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 130 key (941149637836=
8 METADATA_ITEM 0) itemoff 11924 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 131 key (941149639475=
2 METADATA_ITEM 0) itemoff 11891 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 132 key (941149641113=
6 METADATA_ITEM 0) itemoff 11858 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1964 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 133 key (941149642752=
0 METADATA_ITEM 0) itemoff 11825 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1964 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 134 key (941149644390=
4 METADATA_ITEM 0) itemoff 11792 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 135 key (941149646028=
8 METADATA_ITEM 0) itemoff 11759 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 136 key (941149647667=
2 METADATA_ITEM 0) itemoff 11726 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 137 key (941149649305=
6 METADATA_ITEM 0) itemoff 11693 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 138 key (941149650944=
0 METADATA_ITEM 0) itemoff 11660 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 139 key (941149652582=
4 METADATA_ITEM 0) itemoff 11627 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 140 key (941149654220=
8 METADATA_ITEM 0) itemoff 11594 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 141 key (941149655859=
2 METADATA_ITEM 0) itemoff 11561 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 142 key (941149657497=
6 METADATA_ITEM 0) itemoff 11528 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 143 key (941149659136=
0 METADATA_ITEM 0) itemoff 11495 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 144 key (941149660774=
4 METADATA_ITEM 0) itemoff 11462 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 145 key (941149662412=
8 METADATA_ITEM 0) itemoff 11429 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 146 key (941149664051=
2 METADATA_ITEM 0) itemoff 11396 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 147 key (941149665689=
6 METADATA_ITEM 0) itemoff 11363 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 148 key (941149667328=
0 METADATA_ITEM 0) itemoff 11330 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 149 key (941149668966=
4 METADATA_ITEM 0) itemoff 11297 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 150 key (941149670604=
8 METADATA_ITEM 0) itemoff 11264 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 151 key (941149672243=
2 METADATA_ITEM 0) itemoff 11231 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 152 key (941149673881=
6 METADATA_ITEM 0) itemoff 11198 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 153 key (941149675520=
0 METADATA_ITEM 0) itemoff 11165 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 154 key (941149677158=
4 METADATA_ITEM 0) itemoff 11132 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 155 key (941149678796=
8 METADATA_ITEM 0) itemoff 11099 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 156 key (941149680435=
2 METADATA_ITEM 0) itemoff 11066 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 157 key (941149682073=
6 METADATA_ITEM 0) itemoff 11033 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 158 key (941149683712=
0 METADATA_ITEM 0) itemoff 11000 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 159 key (941149685350=
4 METADATA_ITEM 0) itemoff 10967 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 160 key (941149686988=
8 METADATA_ITEM 0) itemoff 10934 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 161 key (941149688627=
2 METADATA_ITEM 0) itemoff 10901 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 162 key (941149690265=
6 METADATA_ITEM 0) itemoff 10868 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 163 key (941149691904=
0 METADATA_ITEM 0) itemoff 10835 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 164 key (941149693542=
4 METADATA_ITEM 0) itemoff 10802 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 165 key (941149695180=
8 METADATA_ITEM 0) itemoff 10769 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 166 key (941149696819=
2 METADATA_ITEM 0) itemoff 10736 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1959 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 167 key (941149698457=
6 METADATA_ITEM 0) itemoff 10703 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1959 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 168 key (941149700096=
0 METADATA_ITEM 0) itemoff 10670 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1959 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel:         item 169 key (941149701734=
4 METADATA_ITEM 0) itemoff 10637 itemsize 33
      Feb 10 23:32:18 heisenberg kernel:                 extent refs 1 gen =
1820 flags 2
      Feb 10 23:32:18 heisenberg kernel:                 ref#0: tree block =
backref root 7
      Feb 10 23:32:18 heisenberg kernel: BTRFS critical (device dm-2 state =
EA): unable to find ref byte nr 9411494887424 parent 0 root 10 owner 0 offs=
et 0 slot 40
      Feb 10 23:32:18 heisenberg kernel: BTRFS error (device dm-2 state EA)=
: failed to run delayed ref for logical 9411494887424 num_bytes 16384 type =
176 action 2 ref_mod 1: -2
      Feb 10 23:32:18 heisenberg kernel: BTRFS: error (device dm-2 state EA=
) in btrfs_run_delayed_refs:2161: errno=3D-2 No such entry
      Feb 10 23:32:18 heisenberg kernel: BTRFS warning (device dm-2 state E=
A): Skipping commit of aborted transaction.
      Feb 10 23:32:18 heisenberg kernel: BTRFS: error (device dm-2 state EA=
) in cleanup_transaction:2021: errno=3D-2 No such entry
      Feb 10 23:32:18 heisenberg kernel: BTRFS info (device dm-2 state EA):=
 last unmount of filesystem e1a465db-0227-46e1-9917-d6be986266cd
     =20

Well I'm not an expert... but these seem more serious (are the extent
refs in the extent tree?)... and AFAICS it can hit anyone how merely
clears/rebuilds the free space tree on a suitably large fs?


Perhaps one should warn people NOT to do this?


Cheers,
Chris.

