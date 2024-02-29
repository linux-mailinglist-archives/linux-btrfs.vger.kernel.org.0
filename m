Return-Path: <linux-btrfs+bounces-2902-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 355F486BFDA
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 05:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B7451C22C61
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 04:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3E6381AA;
	Thu, 29 Feb 2024 04:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=pj.opensuse@gmx.com header.b="J+MJZuzC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C0B224DC
	for <linux-btrfs@vger.kernel.org>; Thu, 29 Feb 2024 04:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709180592; cv=none; b=DTShSNiLXKCPa/WJpl83WodFvPzoyN0F769JTqRq6cuaUQLzipmVN/meZqa1HWOIMHCkZ+Fa0k5PAB3qr+jHW7BzQTWhun0MkB3rIqSQMrw/RCmRdM7bFlZoXdiEHCOobwcWXDDKMn2P1vhwfKy+AvFLriPw9VdsCSKihsYLiys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709180592; c=relaxed/simple;
	bh=VyEI3wWWQYApLsIosCXwtmJ5Vd5ESw61XZlRaPd1RlM=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=DX3JFZfvcRY5baAUv4qz3JuTKI5Uh3kFq3nJi5NIReaZalPxlpbB1ilk8aV851P4guAQ6ooPqGRHs7kNN5UTWHZTtO64MOsS1yAZ26an9kEkMT1+y0/UlSbeLUZBASHSAQ7/cnDbxrjK8E6H4eiTMF2ewZdItA/ApC2Y/t8HEl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=pj.opensuse@gmx.com header.b=J+MJZuzC; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1709180584; x=1709785384; i=pj.opensuse@gmx.com;
	bh=VyEI3wWWQYApLsIosCXwtmJ5Vd5ESw61XZlRaPd1RlM=;
	h=X-UI-Sender-Class:Date:To:From:Subject;
	b=J+MJZuzCDQ2wtwooLkKYRUJ9aUiUS2bcyCCQzJuS+mzjisQHDP97Eb1z9d7Zarzt
	 O33uh9Iutoy+TsIf45+vjcG4IoSb7QUUi6VR7MnkIEGiVi9Qxqv08tk8raA/Ck09g
	 BYbxJa2HUOknQcEb6YO3y7dNfS0/7o4iF2nBFkHrjDG9U/LVWmyqIR4ccJw9pbco7
	 NgRZtPvUJCHighC+yYidVBPr1p8nEczt9S+dX4OJ7u6JvklSA5efB5Ybv87behTZ+
	 RhidpDEOAcMhDTowfdSg8O9L/03jYAatTEmDY5X/Xas6mT2fgD4CIrAYtcSGFGS2u
	 md5GbBp72nqVZE/RCA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.12] ([65.128.144.138]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MEUzA-1rdxFN1mlW-00G2db for
 <linux-btrfs@vger.kernel.org>; Thu, 29 Feb 2024 05:23:04 +0100
Message-ID: <bcb5aaf9-fabd-4b24-8d5f-acdc358f174a@gmx.com>
Date: Wed, 28 Feb 2024 22:23:02 -0600
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-btrfs@vger.kernel.org
From: -pj <pj.opensuse@gmx.com>
Subject: balance switches drive mount to read only:
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:B/EwFMnQKfqjlmbw5pRUTUnwmeqHXin5x74hupqrR8DDY+jCOPD
 idjexL0zqr9CBO/6jfGDi63B1aPH/Ulk6ljpsNqzcIYDaiEHM4r/a6QQRN9X4YJB+AZ5I2P
 hmy7aqTHIM3IfwfloDDEfIxK1j1qPgCXO6L551RdcucBMg2BGTufin882nwrcnem1AkSJXP
 OhDxLa4wk3WmhZN5TQezQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:X7zXVCdTT9U=;gjLZjKAWfSgQA3VoyL3RQxLZrdW
 MdrxiHDWxOcNfU1dorVaz9YNYSUfa8RHsdwQdmFyhW1dc70HCc88RlueFbmEH+GxRfCYagXP9
 0zRaWO9ZUGmz4eDDzPYW0n6PcEAuSX5WB1kCtxAJwQhDAuwy6+9NQZ4bznChpC86G2CZlprA7
 ZP8UplNK7RTvRp2OJsii7Aj6PHntI5lzCcU8BfjNEl24V2rs00xfuhhMB28vsJGZnGK8gTLLC
 eqccQxap599b9dt2IPbyPPTWGTJMrtjibIA9rThlkl+3quGhdb6VryBs5TW6yLmHkXLryGKy6
 Me3l/Aaj+AluabLQHeUhSy6Dtauzhn05v0WdHVc4vQ+p6v4GURBYTdV/9xof9NVqOi3gJ6HXM
 K0Sg4DLlAsHE6exCkSfgjaZW/2pf4VFuaXSaNrdzAHWyhcWFXEnY8bHhv2f07IAju+BqcfN0v
 WD98OpU8V1DoKHIUFSavrnOi7IFHdfyHBaLQD3QlXAeZ/p25ZjIdUnSHSs8TTnQ3cNmfI5dXy
 tS5DnJisQ0s34TPzORACVqeOEURE8R9CvQPXxGb3YVd0P9XTFWI5+EmVm3rC2a3Czz31raoDK
 g+Ej+4zAisIfVBo2C65qzA54SsPhhCzwuYkIKcw3wGhES+Z88+1fygj5XTUo24GmM2jRUb5kX
 ppFPcsz6sFyk4Mql2KU73BITvR9KjeRsuIjFHV/EgGjQ4rqCGYpYQiQNPixZE73REiZvcrwTZ
 Ga17jjc44xcE9qPKFwcJ2F2jpDqh+BPcU6Yu42Cmw1HoTHj8Ii/MduYdNWLecOMzJHoR45ww2
 y3S/3AZbAOxznvIm1ajxfTvO68pYBt7UiyOZAIKTclChI=

Hi i'm having a problem running balance on my mechanical drive which is
cloned from my primary ssd drive. I spoke with IRC btrfs channel and was
refered here. Turns drive in read only with alot of errors.

Thinkcentre-M57p:~> uname -a
Linux Thinkcentre-M57p 6.7.6-1-default #1 SMP PREEMPT_DYNAMIC Fri Feb 23
09:15:04 UTC 2024 (b9dc7c6) x86_64 x86_64 x86_64 GNU/Linux

-
Below is output from the primary drive:

btrfs-progs v6.7.1

btrfs fi show
Label: none uuid: 605560ad-fe93-4d09-8760-df0725b43ee1
Total devices 1 FS bytes used 132.52GiB
devid 1 size 915.98GiB used 151.07GiB path /dev/mapper/system-root

btrfs fi df /
Data, single: total=3D145.01GiB, used=3D129.83GiB
System, DUP: total=3D32.00MiB, used=3D16.00KiB
Metadata, DUP: total=3D3.00GiB, used=3D2.69GiB
GlobalReserve, single: total=3D241.52MiB, used=3D0.00B

btrfs clean
yes, provide a complete description, and all the log after 11660.526696]
BTRFS info (device dm-2): relocating block group 60294168576 flags
metadata|dup

-
Below: Is from the cloned drive after balance has been run:

All Logs -> http://cwillu.com:8080/65.128.157.101

'btrfsck clean --readonly /dev/mapper/system-root'

[1/7] checking root items
[2/7] checking extents
[3/7] checking free space cache
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups
ERROR: failed to add qgroup relation, member=3D1212
parent=3D281474976710656: No such file or directory
ERROR: loading qgroups from disk: -2
ERROR: failed to check quota groups
extent buffer leak: start 156676964352 len 16384
extent buffer leak: start 155760427008 len 16384
Opening filesystem to check...
Checking filesystem on /dev/mapper/system-root
UUID: 605560ad-fe93-4d09-8760-df0725b43ee1
found 142244990976 bytes used, error(s) found
total csum bytes: 133137492
total tree bytes: 2885664768
total fs tree bytes: 2632204288
total extent tree bytes: 86687744
btree space waste bytes: 711984982
file data blocks allocated: 487941488640
referenced 456996900864

-
'btrfs balance start /'

[11676.093143] ------------[ cut here ]------------
[11676.093162] WARNING: CPU: 1 PID: 11611 at fs/btrfs/extent-tree.c:861
lookup_inline_extent_backref+0x5ee/0x7e0 [btrfs]
[11676.093320] Modules linked in: nls_iso8859_1 nls_cp437 vfat fat uas
usb_storage snd_hrtimer af_packet nft_fib_inet nft_fib_ipv4 nft_fib_ipv6
nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct
nft_chain_nat nf_tables ebtable_nat ebtable_broute ip6table_nat
ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw
iptable_security ip_set nfnetlink ebtable_filter ebtables
ip6table_filter ip6_tables iptable_filter bpfilter qrtr nvidia_drm(POE)
nvidia_modeset(POE) nvidia_uvm(POE) snd_seq_dummy snd_seq_oss
snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss snd_mixer_oss
nvidia(POE) snd_hda_codec_analog rt61pci snd_hda_codec_generic rt2x00pci
ledtrig_audio rt2x00mmio rt2x00lib snd_hda_codec_hdmi mac80211
snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi libarc4 snd_hda_codec
pktcdvd snd_hda_core cfg80211 snd_hwdep snd_pcm eeprom_93cx6 rfkill
coretemp crc_itu_t snd_timer iTCO_wdt snd at24 kvm_intel mei_wdt mei_me
i2c_i801
[11676.093384] ppdev gpio_ich intel_pmc_bxt soundcore
iTCO_vendor_support mei pcspkr i2c_smbus kvm e1000e parport_pc lpc_ich
irqbypass acpi_cpufreq parport tiny_power_button fuse efi_pstore
configfs dmi_sysfs ip_tables x_tables crypto_simd cryptd xts dm_crypt
essiv authenc trusted asn1_encoder tee sr_mod cdrom hid_generic usbhid
ata_piix ahci libahci ata_generic libata sd_mod scsi_dh_emc scsi_dh_rdac
scsi_dh_alua sha512_ssse3 t10_pi sha256_ssse3 sha1_ssse3 sg uhci_hcd
ehci_pci ehci_hcd video floppy wmi scsi_mod usbcore scsi_common button
serio_raw btrfs blake2b_generic libcrc32c xor raid6_pq dm_mirror
dm_region_hash dm_log dm_mod msr
[11676.093494] CPU: 1 PID: 11611 Comm: IndexedDB #324 Tainted: P OE
6.7.6-1-default #1 openSUSE Tumbleweed
cd9816be5099dbe04750b2583fe34462de6dcdca
[11676.093505] Hardware name: LENOVO 9088A83/LENOVO, BIOS 2RKT64BUS
01/08/2014
[11676.093512] RIP: 0010:lookup_inline_extent_backref+0x5ee/0x7e0 [btrfs]
[11676.093616] Code: c7 c8 6b 4b c0 e8 b2 f8 c2 c9 0f 0b 48 8b 03 31 ed
48 89 44 24 28 e9 78 fc ff ff 48 8b 5c 24 40 b8 8b ff ff ff e9 8b fb ff
ff <0f> 0b 48 89 cf e8 d8 8a 00 00 ff b4 24 b8 00 00 00 48 c7 c6 60 6e
[11676.093626] RSP: 0018:ffffa1e2437a7a48 EFLAGS: 00010202
[11676.093633] RAX: 0000000000000001 RBX: ffff8e94e5ad92a0 RCX:
ffff8e94e5aee0e8
[11676.093640] RDX: 0000000000000000 RSI: 0000000000000001 RDI:
0000000000000000
[11676.093647] RBP: 0000000000000000 R08: 0000000000000000 R09:
0000000000000011
[11676.093654] R10: 00000000000017ee R11: 0000000000000000 R12:
0000000002c84000
[11676.093661] R13: 0000000000004000 R14: ffff8e95804067e0 R15:
ffff8e958c78a800
[11676.093667] FS: 00007f6b5f6be6c0(0000) GS:ffff8e96a8080000(0000)
knlGS:0000000000000000
[11676.093675] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[11676.093681] CR2: 00007f543c2dd008 CR3: 0000000152be4000 CR4:
00000000000406f0
[11676.093689] Call Trace:
[11676.093697] <TASK>
[11676.093703] ? lookup_inline_extent_backref+0x5ee/0x7e0 [btrfs
9fe3ae0d97dca82fbee6feb90e34ae2e7e636218]
[11676.093807] ? __warn+0x81/0x130
[11676.093818] ? lookup_inline_extent_backref+0x5ee/0x7e0 [btrfs
9fe3ae0d97dca82fbee6feb90e34ae2e7e636218]
[11676.093923] ? report_bug+0x171/0x1a0
[11676.093933] ? handle_bug+0x3c/0x80
[11676.093941] ? exc_invalid_op+0x17/0x70
[11676.093948] ? asm_exc_invalid_op+0x1a/0x20
[11676.093958] ? lookup_inline_extent_backref+0x5ee/0x7e0 [btrfs
9fe3ae0d97dca82fbee6feb90e34ae2e7e636218]
[11676.094062] ? lookup_inline_extent_backref+0x171/0x7e0 [btrfs
9fe3ae0d97dca82fbee6feb90e34ae2e7e636218]
[11676.094167] insert_inline_extent_backref+0x73/0x150 [btrfs
9fe3ae0d97dca82fbee6feb90e34ae2e7e636218]
[11676.094272] __btrfs_inc_extent_ref+0x88/0x240 [btrfs
9fe3ae0d97dca82fbee6feb90e34ae2e7e636218]
[11676.094376] ? btrfs_merge_delayed_refs+0x1d4/0x390 [btrfs
9fe3ae0d97dca82fbee6feb90e34ae2e7e636218]
[11676.094494] __btrfs_run_delayed_refs+0xb61/0x1280 [btrfs
9fe3ae0d97dca82fbee6feb90e34ae2e7e636218]
[11676.094600] btrfs_run_delayed_refs+0x33/0x110 [btrfs
9fe3ae0d97dca82fbee6feb90e34ae2e7e636218]
[11676.094704] btrfs_commit_transaction+0x76/0xe80 [btrfs
9fe3ae0d97dca82fbee6feb90e34ae2e7e636218]
[11676.094814] btrfs_sync_file+0x477/0x5a0 [btrfs
9fe3ae0d97dca82fbee6feb90e34ae2e7e636218]
[11676.094928] __x64_sys_fsync+0x3b/0x70
[11676.094938] do_syscall_64+0x64/0xe0
[11676.094948] ? syscall_exit_to_user_mode+0x2b/0x40
[11676.094956] ? do_syscall_64+0x70/0xe0
[11676.094964] ? do_syscall_64+0x70/0xe0
[11676.094972] ? do_syscall_64+0x70/0xe0
[11676.094980] ? do_syscall_64+0x70/0xe0
[11676.094988] ? exc_page_fault+0x71/0x160
[11676.094995] entry_SYSCALL_64_after_hwframe+0x6e/0x76
[11676.095004] RIP: 0033:0x7f6b7210933a
[11676.095047] Code: 00 00 0f 05 48 3d 00 f0 ff ff 77 44 c3 0f 1f 00 48
83 ec 18 89 7c 24 0c e8 41 54 f8 ff 8b 7c 24 0c 89 c2 b8 4a 00 00 00 0f
05 <48> 3d 00 f0 ff ff 77 36 89 d7 89 44 24 0c e8 b1 54 f8 ff 8b 44 24
[11676.095057] RSP: 002b:00007f6b5f6bccc0 EFLAGS: 00000293 ORIG_RAX:
000000000000004a
[11676.095065] RAX: ffffffffffffffda RBX: 00007f6ac8254078 RCX:
00007f6b7210933a
[11676.095072] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
0000000000000094
[11676.095079] RBP: 0000000000000003 R08: 00007f6b411527b0 R09:
00007f6b1c17ac80
[11676.095085] R10: 0000000000000004 R11: 0000000000000293 R12:
0000000000000001
[11676.095092] R13: 0000000000000004 R14: 00007f6b1c17acb0 R15:
00007f6b5f6bcec0
[11676.095100] </TASK>
[11676.095106] ---[ end trace 0000000000000000 ]---
[11676.095114] BTRFS info (device dm-2): leaf 269883310080 gen 243571
total ptrs 242 free space 21 owner 2
[11676.095123] item 0 key (44089344 169 0) itemoff 16241 itemsize 42
[11676.095131] extent refs 2 gen 203711 flags 258
[11676.095137] ref#0: shared block backref parent 61030088704
[11676.095145] ref#1: shared block backref parent 577601536
[11676.095152] item 1 key (44105728 169 0) itemoff 16199 itemsize 42
[11676.095160] extent refs 2 gen 199295 flags 258
[11676.095166] ref#0: shared block backref parent 443203584
[11676.095172] ref#1: shared block backref parent 155582464
[11676.095179] item 2 key (44122112 169 0) itemoff 16157 itemsize 42
[11676.095186] extent refs 2 gen 71590 flags 2
[11676.095192] ref#0: tree block backref root 258
[11676.095199] ref#1: shared block backref parent 195782443008
[11676.095206] item 3 key (44138496 169 0) itemoff 16115 itemsize 42
[11676.095213] extent refs 2 gen 152708 flags 2
[11676.095219] ref#0: tree block backref root 258
[11676.095225] ref#1: shared block backref parent 195782443008
[11676.095232] item 4 key (44154880 169 0) itemoff 16073 itemsize 42
[11676.095239] extent refs 2 gen 243518 flags 258
[11676.095245] ref#0: shared block backref parent 1066958848
[11676.095252] ref#1: shared block backref parent 863076352
[11676.095258] item 5 key (44171264 169 0) itemoff 16031 itemsize 42
[11676.095265] extent refs 2 gen 193946 flags 258
[11676.095271] ref#0: shared block backref parent 1011482624
[11676.095278] ref#1: shared block backref parent 282836992
[11676.095284] item 6 key (44187648 169 0) itemoff 15845 itemsize 186
[11676.095291] extent refs 18 gen 121958 flags 258
[11676.095297] ref#0: shared block backref parent 195761602560
[11676.095304] ref#1: shared block backref parent 195761586176
[11676.095311] ref#2: shared block backref parent 195761537024
[11676.095317] ref#3: shared block backref parent 195761471488
[11676.095324] ref#4: shared block backref parent 195761455104
[11676.095330] ref#5: shared block backref parent 195761143808
[11676.095336] ref#6: shared block backref parent 195761078272
[11676.095343] ref#7: shared block backref parent 195761061888
[11676.095349] ref#8: shared block backref parent 195760586752
[11676.095356] ref#9: shared block backref parent 61189439488
[11676.095362] ref#10: shared block backref parent 60917825536
[11676.095369] ref#11: shared block backref parent 60579119104
[11676.095376] ref#12: shared block backref parent 980795392
[11676.095382] ref#13: shared block backref parent 975011840
[11676.095388] ref#14: shared block backref parent 781172736
[11676.095395] ref#15: shared block backref parent 454180864
[11676.095401] ref#16: shared block backref parent 211910656
[11676.095408] ref#17: shared block backref parent 46743552
[11676.095414] item 7 key (44204032 169 0) itemoff 15785 itemsize 60
[11676.095421] extent refs 4 gen 243518 flags 258
[11676.095427] ref#0: shared block backref parent 1068023808
[11676.095434] ref#1: shared block backref parent 1067941888
[11676.095440] ref#2: shared block backref parent 930594816
[11676.095447] ref#3: shared block backref parent 930545664
[11676.095454] item 8 key (44220416 169 0) itemoff 15743 itemsize 42
[11676.095461] extent refs 2 gen 199295 flags 258
[11676.095467] ref#0: shared block backref parent 61136011264
[11676.095473] ref#1: shared block backref parent 630489088
[11676.095480] item 9 key (44236800 169 0) itemoff 15701 itemsize 42
[11676.095487] extent refs 2 gen 243518 flags 258
[11676.095493] ref#0: shared block backref parent 1066844160
[11676.095499] ref#1: shared block backref parent 863502336
[11676.095506] item 10 key (44253184 169 0) itemoff 15641 itemsize 60
[11676.095513] extent refs 4 gen 185224 flags 258
[11676.095519] ref#0: shared block backref parent 61313597440
[11676.095526] ref#1: shared block backref parent 699990016
[11676.095532] ref#2: shared block backref parent 688668672
[11676.095539] ref#3: shared block backref parent 610435072
[11676.095545] item 11 key (44269568 169 0) itemoff 15347 itemsize 294
[11676.095552] extent refs 30 gen 180934 flags 258
[11676.095558] ref#0: shared block backref parent 195240738816
[11676.095565] ref#1: shared block backref parent 195240722432
[11676.095572] ref#2: shared block backref parent 195240689664
[11676.095578] ref#3: shared block backref parent 195240181760
[11676.095585] ref#4: shared block backref parent 195240165376
[11676.095591] ref#5: shared block backref parent 195240148992
[11676.095598] ref#6: shared block backref parent 195240132608
[11676.095604] ref#7: shared block backref parent 195240116224
[11676.095611] ref#8: shared block backref parent 195240067072
[11676.095655] ref#9: shared block backref parent 195234414592
[11676.095664] ref#10: shared block backref parent 195234299904
[11676.095671] ref#11: shared block backref parent 195234267136
[11676.095678] ref#12: shared block backref parent 195234152448
[11676.095685] ref#13: shared block backref parent 195234103296
[11676.095692] ref#14: shared block backref parent 195233923072
[11676.095699] ref#15: shared block backref parent 96518144
[11676.095705] ref#16: shared block backref parent 78004224
[11676.095712] ref#17: shared block backref parent 77987840
[11676.095718] ref#18: shared block backref parent 77971456
[11676.095724] ref#19: shared block backref parent 75431936
[11676.095731] ref#20: shared block backref parent 75415552
[11676.095737] ref#21: shared block backref parent 75399168
[11676.095744] ref#22: shared block backref parent 75382784
[11676.095750] ref#23: shared block backref parent 75366400
[11676.095756] ref#24: shared block backref parent 58146816
[11676.095763] ref#25: shared block backref parent 58130432
[11676.095769] ref#26: shared block backref parent 58114048
[11676.095775] ref#27: shared block backref parent 51200000
[11676.095782] ref#28: shared block backref parent 50855936
[11676.095788] ref#29: shared block backref parent 50200576
[11676.095795] item 12 key (44285952 169 0) itemoff 15287 itemsize 60
[11676.095802] extent refs 4 gen 237989 flags 258
[11676.095808] ref#0: shared block backref parent 195596730368
[11676.095815] ref#1: shared block backref parent 195596681216
[11676.095821] ref#2: shared block backref parent 740802560
[11676.095828] ref#3: shared block backref parent 740671488
[11676.095834] item 13 key (44302336 169 0) itemoff 15245 itemsize 42
[11676.095842] extent refs 2 gen 240909 flags 2
[11676.095848] ref#0: shared block backref parent 61142450176
[11676.095855] ref#1: shared block backref parent 185352192
[11676.095862] item 14 key (44318720 169 0) itemoff 15203 itemsize 42
[11676.095869] extent refs 2 gen 192487 flags 258
[11676.095875] ref#0: shared block backref parent 743227392
[11676.095881] ref#1: shared block backref parent 725434368
[11676.095888] item 15 key (44335104 169 0) itemoff 15161 itemsize 42
[11676.095895] extent refs 2 gen 71590 flags 2
[11676.095901] ref#0: tree block backref root 258
[11676.095908] ref#1: shared block backref parent 195782443008
[11676.095914] item 16 key (44351488 169 0) itemoff 15047 itemsize 114
[11676.095922] extent refs 10 gen 200806 flags 258
[11676.095928] ref#0: shared block backref parent 1029292032
[11676.095934] ref#1: shared block backref parent 1029029888
[11676.095941] ref#2: shared block backref parent 1028947968
[11676.095947] ref#3: shared block backref parent 1028734976
[11676.095954] ref#4: shared block backref parent 983482368
[11676.095960] ref#5: shared block backref parent 608403456
[11676.095966] ref#6: shared block backref parent 596852736
[11676.095973] ref#7: shared block backref parent 596803584
[11676.095979] ref#8: shared block backref parent 596328448
[11676.095986] ref#9: shared block backref parent 596312064
[11676.095992] item 17 key (44367872 169 0) itemoff 14969 itemsize 78
[11676.095999] extent refs 6 gen 192487 flags 258
[11676.096005] ref#0: shared block backref parent 61136748544
[11676.096012] ref#1: shared block backref parent 61136699392
[11676.096018] ref#2: shared block backref parent 61134635008
[11676.096025] ref#3: shared block backref parent 749486080
[11676.096031] ref#4: shared block backref parent 749322240
[11676.096038] ref#5: shared block backref parent 408125440
[11676.096045] item 18 key (44384256 169 0) itemoff 14927 itemsize 42
[11676.096052] extent refs 2 gen 230859 flags 258
[11676.096058] ref#0: shared block backref parent 195755114496
[11676.096065] ref#1: shared block backref parent 195235676160
[11676.096071] item 19 key (44400640 169 0) itemoff 14813 itemsize 114
[11676.096079] extent refs 10 gen 237989 flags 258
[11676.096085] ref#0: shared block backref parent 195422257152
[11676.096091] ref#1: shared block backref parent 195422240768
[11676.096098] ref#2: shared block backref parent 195422224384
[11676.096105] ref#3: shared block backref parent 195422208000
[11676.096111] ref#4: shared block backref parent 195422191616
[11676.096118] ref#5: shared block backref parent 1076461568
[11676.096124] ref#6: shared block backref parent 1076445184
[11676.096131] ref#7: shared block backref parent 1068171264
[11676.096138] ref#8: shared block backref parent 1068154880
[11676.096144] ref#9: shared block backref parent 1068138496
[11676.096151] item 20 key (44417024 169 1) itemoff 14780 itemsize 33
[11676.096158] extent refs 1 gen 243571 flags 258
[11676.096164] ref#0: shared block backref parent 195755163648
[11676.096171] item 21 key (44433408 169 0) itemoff 14684 itemsize 96
[11676.096178] extent refs 8 gen 192487 flags 258
[11676.096184] ref#0: shared block backref parent 60830515200
[11676.096191] ref#1: shared block backref parent 60542877696
[11676.096197] ref#2: shared block backref parent 725630976
[11676.096204] ref#3: shared block backref parent 701251584
[11676.096211] ref#4: shared block backref parent 689979392
[11676.096217] ref#5: shared block backref parent 688537600
[11676.096224] ref#6: shared block backref parent 688521216
[11676.096230] ref#7: shared block backref parent 541556736
[11676.096236] item 22 key (44449792 169 1) itemoff 14651 itemsize 33
[11676.096243] extent refs 1 gen 243571 flags 258
[11676.096249] ref#0: shared block backref parent 195756851200
[11676.096256] item 23 key (44466176 169 1) itemoff 14618 itemsize 33
[11676.096263] extent refs 1 gen 243571 flags 258
[11676.096269] ref#0: shared block backref parent 195756294144
[11676.096276] item 24 key (44482560 169 0) itemoff 14504 itemsize 114
[11676.096283] extent refs 10 gen 230859 flags 258
[11676.096289] ref#0: shared block backref parent 195545513984
[11676.096295] ref#1: shared block backref parent 195512991744
[11676.096302] ref#2: shared block backref parent 195508404224
[11676.096309] ref#3: shared block backref parent 195502817280
[11676.096315] ref#4: shared block backref parent 195482517504
[11676.096322] ref#5: shared block backref parent 874381312
[11676.096328] ref#6: shared block backref parent 874053632
[11676.096335] ref#7: shared block backref parent 873709568
[11676.096341] ref#8: shared block backref parent 782188544
[11676.096348] ref#9: shared block backref parent 88031232
[11676.096355] item 25 key (44498944 169 0) itemoff 14462 itemsize 42
[11676.096362] extent refs 2 gen 243518 flags 258
[11676.096368] ref#0: shared block backref parent 1068236800
[11676.096374] ref#1: shared block backref parent 930480128
[11676.096381] item 26 key (44515328 169 0) itemoff 14429 itemsize 33
[11676.096388] extent refs 1 gen 240909 flags 2
[11676.096394] ref#0: shared block backref parent 61282959360
[11676.096401] item 27 key (44531712 169 1) itemoff 14396 itemsize 33
[11676.096408] extent refs 1 gen 243571 flags 258
[11676.096414] ref#0: shared block backref parent 195755917312
[11676.096421] item 28 key (44548096 169 0) itemoff 14354 itemsize 42
[11676.096428] extent refs 2 gen 192487 flags 258
[11676.096434] ref#0: shared block backref parent 195760275456
[11676.096441] ref#1: shared block backref parent 61325230080
[11676.096447] item 29 key (44564480 169 0) itemoff 14240 itemsize 114
[11676.096454] extent refs 10 gen 187377 flags 258
[11676.096461] ref#0: shared block backref parent 195773628416
[11676.096467] ref#1: shared block backref parent 195771514880
[11676.096474] ref#2: shared block backref parent 195771482112
[11676.096481] ref#3: shared block backref parent 60321234944
[11676.096487] ref#4: shared block backref parent 60321005568
[11676.096494] ref#5: shared block backref parent 60297052160
[11676.096500] ref#6: shared block backref parent 60296790016
[11676.096507] ref#7: shared block backref parent 60296757248
[11676.096513] ref#8: shared block backref parent 290209792
[11676.096520] ref#9: shared block backref parent 290177024
[11676.096526] item 30 key (44580864 169 0) itemoff 14198 itemsize 42
[11676.096533] extent refs 2 gen 220751 flags 258
[11676.096539] ref#0: shared block backref parent 195765567488
[11676.096546] ref#1: shared block backref parent 195445751808
[11676.096553] item 31 key (44597248 169 0) itemoff 14138 itemsize 60
[11676.096560] extent refs 4 gen 220751 flags 258
[11676.096566] ref#0: shared block backref parent 195766960128
[11676.096573] ref#1: shared block backref parent 61135978496
[11676.096579] ref#2: shared block backref parent 61135732736
[11676.096586] ref#3: shared block backref parent 618217472
[11676.096592] item 32 key (44613632 169 1) itemoff 14105 itemsize 33
[11676.096599] extent refs 1 gen 200844 flags 258
[11676.096606] ref#0: tree block backref root 1416
[11676.096612] item 33 key (44630016 169 1) itemoff 14063 itemsize 42
[11676.096619] extent refs 2 gen 243571 flags 258
[11676.096625] ref#0: shared block backref parent 195758030848
[11676.096632] ref#1: shared block backref parent 195755982848
[11676.096639] item 34 key (44646400 169 0) itemoff 14030 itemsize 33
[11676.096646] extent refs 1 gen 20421 flags 2
[11676.096652] ref#0: tree block backref root 7
[11676.096658] item 35 key (44662784 169 0) itemoff 13898 itemsize 132
[11676.096665] extent refs 12 gen 230859 flags 258
[11676.096671] ref#0: shared block backref parent 61234692096
[11676.096678] ref#1: shared block backref parent 61234577408
[11676.096684] ref#2: shared block backref parent 61218734080
[11676.096691] ref#3: shared block backref parent 61218684928
[11676.096697] ref#4: shared block backref parent 61202317312
[11676.096704] ref#5: shared block backref parent 61202284544
[11676.096710] ref#6: shared block backref parent 766574592
[11676.096717] ref#7: shared block backref parent 766525440
[11676.096724] ref#8: shared block backref parent 766115840
[11676.096730] ref#9: shared block backref parent 766001152
[11676.096736] ref#10: shared block backref parent 765739008
[11676.096743] ref#11: shared block backref parent 661012480
[11676.096749] item 36 key (44679168 169 0) itemoff 13856 itemsize 42
[11676.096757] extent refs 2 gen 220751 flags 258
[11676.096763] ref#0: shared block backref parent 60304850944
[11676.096770] ref#1: shared block backref parent 978927616
[11676.096776] item 37 key (44695552 169 0) itemoff 13814 itemsize 42
[11676.096784] extent refs 2 gen 187377 flags 258
[11676.096790] ref#0: shared block backref parent 195771514880
[11676.096796] ref#1: shared block backref parent 60296790016
[11676.096803] item 38 key (44711936 169 0) itemoff 13772 itemsize 42
[11676.096810] extent refs 2 gen 187377 flags 258
[11676.096816] ref#0: shared block backref parent 195771514880
[11676.096823] ref#1: shared block backref parent 60296790016
[11676.096829] item 39 key (44728320 169 1) itemoff 13739 itemsize 33
[11676.096836] extent refs 1 gen 243571 flags 258
[11676.096843] ref#0: shared block backref parent 195755229184
[11676.096849] item 40 key (44744704 169 0) itemoff 13661 itemsize 78
[11676.096856] extent refs 6 gen 192487 flags 258
[11676.096862] ref#0: shared block backref parent 60540272640
[11676.096869] ref#1: shared block backref parent 725352448
[11676.096875] ref#2: shared block backref parent 539721728
[11676.096882] ref#3: shared block backref parent 533643264
[11676.096888] ref#4: shared block backref parent 528646144
[11676.096895] ref#5: shared block backref parent 292929536
[11676.096901] item 41 key (44761088 169 1) itemoff 13628 itemsize 33
[11676.096908] extent refs 1 gen 243571 flags 258
[11676.096914] ref#0: shared block backref parent 195757867008
[11676.096921] item 42 key (44777472 169 0) itemoff 13118 itemsize 510
[11676.096928] extent refs 54 gen 243211 flags 258
[11676.096934] ref#0: shared block backref parent 195776462848
[11676.096941] ref#1: shared block backref parent 195776430080
[11676.096948] ref#2: shared block backref parent 195763552256
[11676.096954] ref#3: shared block backref parent 60493742080
[11676.096961] ref#4: shared block backref parent 60493529088
[11676.096967] ref#5: shared block backref parent 60493332480
[11676.096974] ref#6: shared block backref parent 60493266944
[11676.096980] ref#7: shared block backref parent 60493168640
[11676.096987] ref#8: shared block backref parent 60493119488
[11676.096994] ref#9: shared block backref parent 60493053952
[11676.097000] ref#10: shared block backref parent 60493004800
[11676.097007] ref#11: shared block backref parent 60492922880
[11676.097013] ref#12: shared block backref parent 60492578816
[11676.097020] ref#13: shared block backref parent 60492546048
[11676.097026] ref#14: shared block backref parent 60492464128
[11676.097033] ref#15: shared block backref parent 60492349440
[11676.097040] ref#16: shared block backref parent 60492251136
[11676.097046] ref#17: shared block backref parent 60491956224
[11676.097053] ref#18: shared block backref parent 60475441152
[11676.097059] ref#19: shared block backref parent 60475228160
[11676.097066] ref#20: shared block backref parent 60475195392
[11676.097073] ref#21: shared block backref parent 60474982400
[11676.097079] ref#22: shared block backref parent 60474949632
[11676.097086] ref#23: shared block backref parent 60472999936
[11676.097092] ref#24: shared block backref parent 60438528000
[11676.097099] ref#25: shared block backref parent 60438347776
[11676.097105] ref#26: shared block backref parent 60438085632
[11676.097112] ref#27: shared block backref parent 60437872640
[11676.097119] ref#28: shared block backref parent 60358426624
[11676.097125] ref#29: shared block backref parent 60356231168
[11676.097132] ref#30: shared block backref parent 578371584
[11676.097138] ref#31: shared block backref parent 578256896
[11676.097145] ref#32: shared block backref parent 578240512
[11676.097151] ref#33: shared block backref parent 578224128
[11676.097158] ref#34: shared block backref parent 578174976
[11676.097164] ref#35: shared block backref parent 578158592
[11676.097171] ref#36: shared block backref parent 578142208
[11676.097177] ref#37: shared block backref parent 578125824
[11676.097184] ref#38: shared block backref parent 578109440
[11676.097190] ref#39: shared block backref parent 578093056
[11676.097197] ref#40: shared block backref parent 578043904
[11676.097203] ref#41: shared block backref parent 578027520
[11676.097210] ref#42: shared block backref parent 578011136
[11676.097216] ref#43: shared block backref parent 577994752
[11676.097223] ref#44: shared block backref parent 577978368
[11676.097229] ref#45: shared block backref parent 577945600
[11676.097236] ref#46: shared block backref parent 577929216
[11676.097242] ref#47: shared block backref parent 577912832
[11676.097249] ref#48: shared block backref parent 577896448
[11676.097255] ref#49: shared block backref parent 577880064
[11676.097262] ref#50: shared block backref parent 577863680
[11676.097268] ref#51: shared block backref parent 577847296
[11676.097275] ref#52: shared block backref parent 577830912
[11676.097282] ref#53: shared block backref parent 577781760
[11676.097288] item 43 key (44793856 169 0) itemoff 13076 itemsize 42
[11676.097295] extent refs 2 gen 187377 flags 258
[11676.097301] ref#0: shared block backref parent 993902592
[11676.097308] ref#1: shared block backref parent 246497280
[11676.097315] item 44 key (44810240 169 0) itemoff 13034 itemsize 42
[11676.097322] extent refs 2 gen 187377 flags 258
[11676.097328] ref#0: shared block backref parent 195771514880
[11676.097335] ref#1: shared block backref parent 60296790016
[11676.097342] item 45 key (44826624 169 1) itemoff 13001 itemsize 33
[11676.097349] extent refs 1 gen 243571 flags 258
[11676.097355] ref#0: shared block backref parent 195757948928
[11676.097362] item 46 key (44843008 169 1) itemoff 12968 itemsize 33
[11676.097369] extent refs 1 gen 243571 flags 258
[11676.097375] ref#0: shared block backref parent 195756195840
[11676.097382] item 47 key (44859392 169 0) itemoff 12908 itemsize 60
[11676.097389] extent refs 4 gen 200844 flags 258
[11676.097396] ref#0: shared block backref parent 195761618944
[11676.097402] ref#1: shared block backref parent 195761094656
[11676.097409] ref#2: shared block backref parent 60879749120
[11676.097416] ref#3: shared block backref parent 44613632
[11676.097422] item 48 key (44875776 169 0) itemoff 12866 itemsize 42
[11676.097429] extent refs 2 gen 203711 flags 258
[11676.097436] ref#0: shared block backref parent 61065265152
[11676.097442] ref#1: shared block backref parent 203292672
[11676.097449] item 49 key (44892160 169 0) itemoff 12824 itemsize 42
[11676.097456] extent refs 2 gen 192487 flags 258
[11676.097462] ref#0: shared block backref parent 195777445888
[11676.097469] ref#1: shared block backref parent 664961024
[11676.097475] item 50 key (44908544 169 0) itemoff 12782 itemsize 42
[11676.097482] extent refs 2 gen 44691 flags 258
[11676.097488] ref#0: shared block backref parent 908525568
[11676.097495] ref#1: shared block backref parent 75563008
[11676.097501] item 51 key (44924928 169 0) itemoff 12722 itemsize 60
[11676.097508] extent refs 4 gen 220751 flags 258
[11676.097514] ref#0: shared block backref parent 387186688
[11676.097521] ref#1: shared block backref parent 374685696
[11676.097527] ref#2: shared block backref parent 366215168
[11676.097534] ref#3: shared block backref parent 366149632
[11676.097540] item 52 key (44941312 169 0) itemoff 12662 itemsize 60
[11676.097547] extent refs 4 gen 220751 flags 258
[11676.097554] ref#0: shared block backref parent 61284712448
[11676.097560] ref#1: shared block backref parent 61283467264
[11676.097567] ref#2: shared block backref parent 735444992
[11676.097573] ref#3: shared block backref parent 630964224
[11676.097580] item 53 key (44957696 169 0) itemoff 12620 itemsize 42
[11676.097587] extent refs 2 gen 199295 flags 258
[11676.097593] ref#0: shared block backref parent 61136011264
[11676.097600] ref#1: shared block backref parent 630489088
[11676.097606] item 54 key (44974080 169 0) itemoff 12578 itemsize 42
[11676.097613] extent refs 2 gen 220751 flags 258
[11676.097619] ref#0: shared block backref parent 195766960128
[11676.097626] ref#1: shared block backref parent 61135978496
[11676.097633] item 55 key (44990464 169 0) itemoff 12518 itemsize 60
[11676.097640] extent refs 4 gen 200400 flags 258
[11676.097646] ref#0: shared block backref parent 195766042624
[11676.097653] ref#1: shared block backref parent 195766026240
[11676.097660] ref#2: shared block backref parent 61239885824
[11676.097666] ref#3: shared block backref parent 61239787520
[11676.097673] item 56 key (45006848 169 0) itemoff 12458 itemsize 60
[11676.097680] extent refs 4 gen 200844 flags 258
[11676.097686] ref#0: shared block backref parent 994787328
[11676.097692] ref#1: shared block backref parent 994754560
[11676.097699] ref#2: shared block backref parent 266092544
[11676.097706] ref#3: shared block backref parent 232079360
[11676.097712] item 57 key (45023232 169 0) itemoff 12416 itemsize 42
[11676.097719] extent refs 2 gen 200400 flags 258
[11676.097725] ref#0: shared block backref parent 61143531520
[11676.097732] ref#1: shared block backref parent 476348416
[11676.097739] item 58 key (45039616 169 0) itemoff 12374 itemsize 42
[11676.097746] extent refs 2 gen 187377 flags 258
[11676.097752] ref#0: shared block backref parent 195771514880
[11676.097758] ref#1: shared block backref parent 60296790016
[11676.097765] item 59 key (45056000 169 0) itemoff 12332 itemsize 42
[11676.097772] extent refs 2 gen 220751 flags 258
[11676.097779] ref#0: shared block backref parent 195764584448
[11676.097786] ref#1: shared block backref parent 195662217216
[11676.097793] item 60 key (45072384 169 0) itemoff 12272 itemsize 60
[11676.097800] extent refs 4 gen 200844 flags 258
[11676.097806] ref#0: shared block backref parent 195761618944
[11676.097813] ref#1: shared block backref parent 195761094656
[11676.097820] ref#2: shared block backref parent 60879749120
[11676.097827] ref#3: shared block backref parent 44613632
[11676.097834] item 61 key (45088768 169 0) itemoff 12212 itemsize 60
[11676.097841] extent refs 4 gen 200844 flags 258
[11676.097847] ref#0: shared block backref parent 195761618944
[11676.097854] ref#1: shared block backref parent 195761094656
[11676.097861] ref#2: shared block backref parent 60879749120
[11676.097867] ref#3: shared block backref parent 44613632
[11676.097874] item 62 key (45105152 169 0) itemoff 12098 itemsize 114
[11676.097881] extent refs 10 gen 193019 flags 258
[11676.097887] ref#0: shared block backref parent 60882599936
[11676.097894] ref#1: shared block backref parent 60838674432
[11676.097900] ref#2: shared block backref parent 674693120
[11676.097907] ref#3: shared block backref parent 638271488
[11676.097913] ref#4: shared block backref parent 264945664
[11676.097919] ref#5: shared block backref parent 263995392
[11676.097926] ref#6: shared block backref parent 263962624
[11676.097932] ref#7: shared block backref parent 263618560
[11676.097939] ref#8: shared block backref parent 263585792
[11676.097946] ref#9: shared block backref parent 135053312
[11676.097952] item 63 key (45121536 169 0) itemoff 12020 itemsize 78
[11676.097959] extent refs 6 gen 237989 flags 258
[11676.097965] ref#0: shared block backref parent 195649208320
[11676.097972] ref#1: shared block backref parent 195649191936
[11676.097979] ref#2: shared block backref parent 195424436224
[11676.097985] ref#3: shared block backref parent 523419648
[11676.097992] ref#4: shared block backref parent 523370496
[11676.097998] ref#5: shared block backref parent 522158080
[11676.098005] item 64 key (45137920 169 0) itemoff 11978 itemsize 42
[11676.098012] extent refs 2 gen 243335 flags 258
[11676.098018] ref#0: tree block backref root 263
[11676.098024] ref#1: shared block backref parent 375799808
[11676.098031] item 65 key (45154304 169 0) itemoff 11936 itemsize 42
[11676.098038] extent refs 2 gen 240909 flags 2
[11676.098044] ref#0: shared block backref parent 195574710272
[11676.098051] ref#1: shared block backref parent 278593536
[11676.098058] item 66 key (45170688 169 0) itemoff 11858 itemsize 78
[11676.098065] extent refs 6 gen 237989 flags 258
[11676.098071] ref#0: shared block backref parent 195506438144
[11676.098078] ref#1: shared block backref parent 195470016512
[11676.098084] ref#2: shared block backref parent 195469967360
[11676.098091] ref#3: shared block backref parent 350027776
[11676.098098] ref#4: shared block backref parent 350011392
[11676.098104] ref#5: shared block backref parent 349896704
[11676.098111] item 67 key (45187072 169 0) itemoff 11816 itemsize 42
[11676.098118] extent refs 2 gen 240909 flags 2
[11676.098124] ref#0: shared block backref parent 60652191744
[11676.098131] ref#1: shared block backref parent 109953024
[11676.098138] item 68 key (45203456 169 0) itemoff 11432 itemsize 384
[11676.098145] extent refs 40 gen 243546 flags 258
[11676.098152] ref#0: shared block backref parent 195764158464
[11676.098158] ref#1: shared block backref parent 194982461440
[11676.098165] ref#2: shared block backref parent 194982445056
[11676.098171] ref#3: shared block backref parent 194982428672
[11676.098178] ref#4: shared block backref parent 194982117376
[11676.098185] ref#5: shared block backref parent 194982100992
[11676.098191] ref#6: shared block backref parent 194982084608
[11676.098198] ref#7: shared block backref parent 194982068224
[11676.098204] ref#8: shared block backref parent 194981609472
[11676.098211] ref#9: shared block backref parent 194981593088
[11676.098218] ref#10: shared block backref parent 194981576704
[11676.098225] ref#11: shared block backref parent 822951936
[11676.098232] ref#12: shared block backref parent 822902784
[11676.098238] ref#13: shared block backref parent 822870016
[11676.098245] ref#14: shared block backref parent 822837248
[11676.098252] ref#15: shared block backref parent 776323072
[11676.098258] ref#16: shared block backref parent 776175616
[11676.098265] ref#17: shared block backref parent 775798784
[11676.098272] ref#18: shared block backref parent 775602176
[11676.098279] ref#19: shared block backref parent 516882432
[11676.098285] ref#20: shared block backref parent 333545472
[11676.098292] ref#21: shared block backref parent 333529088
[11676.098298] ref#22: shared block backref parent 333512704
[11676.098305] ref#23: shared block backref parent 330956800
[11676.098312] ref#24: shared block backref parent 330940416
[11676.098318] ref#25: shared block backref parent 330924032
[11676.098325] ref#26: shared block backref parent 330907648
[11676.098331] ref#27: shared block backref parent 330891264
[11676.098338] ref#28: shared block backref parent 330858496
[11676.098345] ref#29: shared block backref parent 330842112
[11676.098351] ref#30: shared block backref parent 330825728
[11676.098358] ref#31: shared block backref parent 325828608
[11676.098364] ref#32: shared block backref parent 325812224
[11676.098371] ref#33: shared block backref parent 325795840
[11676.098377] ref#34: shared block backref parent 325369856
[11676.098384] ref#35: shared block backref parent 325353472
[11676.098390] ref#36: shared block backref parent 325337088
[11676.098397] ref#37: shared block backref parent 325320704
[11676.098403] ref#38: shared block backref parent 323715072
[11676.098410] ref#39: shared block backref parent 323682304
[11676.098416] item 69 key (45219840 169 0) itemoff 11372 itemsize 60
[11676.098424] extent refs 4 gen 203711 flags 258
[11676.098430] ref#0: shared block backref parent 195761160192
[11676.098436] ref#1: shared block backref parent 195761045504
[11676.098443] ref#2: shared block backref parent 61252288512
[11676.098449] ref#3: shared block backref parent 60538142720
[11676.098456] item 70 key (45236224 169 0) itemoff 11330 itemsize 42
[11676.098463] extent refs 2 gen 203711 flags 258
[11676.098469] ref#0: shared block backref parent 61065265152
[11676.098476] ref#1: shared block backref parent 203292672
[11676.098482] item 71 key (45252608 169 1) itemoff 11297 itemsize 33
[11676.098490] extent refs 1 gen 243571 flags 258
[11676.098496] ref#0: shared block backref parent 195755786240
[11676.098502] item 72 key (45268992 169 0) itemoff 11255 itemsize 42
[11676.098509] extent refs 2 gen 237989 flags 258
[11676.098515] ref#0: shared block backref parent 195424731136
[11676.098522] ref#1: shared block backref parent 1065467904
[11676.098529] item 73 key (45285376 169 0) itemoff 11213 itemsize 42
[11676.098536] extent refs 2 gen 192819 flags 258
[11676.098543] ref#0: shared block backref parent 195761537024
[11676.098549] ref#1: shared block backref parent 454180864
[11676.098556] item 74 key (45301760 169 0) itemoff 11171 itemsize 42
[11676.098563] extent refs 2 gen 240909 flags 2
[11676.098569] ref#0: shared block backref parent 60628172800
[11676.098576] ref#1: shared block backref parent 279199744
[11676.098582] item 75 key (45318144 169 0) itemoff 11129 itemsize 42
[11676.098589] extent refs 2 gen 192487 flags 258
[11676.098595] ref#0: shared block backref parent 743227392
[11676.098602] ref#1: shared block backref parent 725434368
[11676.098609] item 76 key (45334528 169 0) itemoff 11051 itemsize 78
[11676.098616] extent refs 6 gen 226875 flags 258
[11676.098622] ref#0: shared block backref parent 195729899520
[11676.098629] ref#1: shared block backref parent 195727032320
[11676.098636] ref#2: shared block backref parent 195727015936
[11676.098642] ref#3: shared block backref parent 550584320
[11676.098649] ref#4: shared block backref parent 550387712
[11676.098656] ref#5: shared block backref parent 549945344
[11676.098662] item 77 key (45350912 169 0) itemoff 11009 itemsize 42
[11676.098669] extent refs 2 gen 192487 flags 258
[11676.098675] ref#0: shared block backref parent 545406976
[11676.098681] ref#1: shared block backref parent 268304384
[11676.098688] item 78 key (45367296 169 0) itemoff 10949 itemsize 60
[11676.098695] extent refs 4 gen 189208 flags 258
[11676.098701] ref#0: shared block backref parent 929480704
[11676.098708] ref#1: shared block backref parent 851935232
[11676.098714] ref#2: shared block backref parent 851804160
[11676.098721] ref#3: shared block backref parent 99139584
[11676.098728] item 79 key (45383680 169 1) itemoff 10916 itemsize 33
[11676.098735] extent refs 1 gen 243571 flags 258
[11676.098741] ref#0: shared block backref parent 195755376640
[11676.098747] item 80 key (45400064 169 1) itemoff 10883 itemsize 33
[11676.098755] extent refs 1 gen 243571 flags 258
[11676.098761] ref#0: shared block backref parent 195755278336
[11676.098767] item 81 key (45416448 169 0) itemoff 10841 itemsize 42
[11676.098774] extent refs 2 gen 243571 flags 258
[11676.098780] ref#0: shared block backref parent 195773890560
[11676.098787] ref#1: shared block backref parent 195773841408
[11676.098794] item 82 key (45432832 169 0) itemoff 10799 itemsize 42
[11676.098801] extent refs 2 gen 243518 flags 258
[11676.098807] ref#0: shared block backref parent 1070039040
[11676.098813] ref#1: shared block backref parent 930054144
[11676.098820] item 83 key (45449216 169 0) itemoff 10739 itemsize 60
[11676.098827] extent refs 4 gen 200844 flags 258
[11676.098833] ref#0: shared block backref parent 195761618944
[11676.098840] ref#1: shared block backref parent 195761094656
[11676.098846] ref#2: shared block backref parent 60879749120
[11676.098853] ref#3: shared block backref parent 44613632
[11676.098859] item 84 key (45465600 169 0) itemoff 10697 itemsize 42
[11676.098867] extent refs 2 gen 192487 flags 258
[11676.098873] ref#0: shared block backref parent 61136699392
[11676.098879] ref#1: shared block backref parent 408125440
[11676.098886] item 85 key (45481984 169 0) itemoff 10655 itemsize 42
[11676.098893] extent refs 2 gen 197680 flags 258
[11676.098899] ref#0: shared block backref parent 60365799424
[11676.098906] ref#1: shared block backref parent 375193600
[11676.098912] item 86 key (45498368 169 0) itemoff 10613 itemsize 42
[11676.098919] extent refs 2 gen 192487 flags 258
[11676.098925] ref#0: shared block backref parent 545406976
[11676.098932] ref#1: shared block backref parent 268304384
[11676.098939] item 87 key (45514752 169 0) itemoff 10571 itemsize 42
[11676.098946] extent refs 2 gen 192487 flags 258
[11676.098960] ref#0: shared block backref parent 61136699392
[11676.098968] ref#1: shared block backref parent 408125440
[11676.098974] item 88 key (45531136 169 0) itemoff 10268 itemsize 303
[11676.098982] extent refs 111 gen 118954 flags 258
[11676.098988] ref#0: shared block backref parent 195435167744
[11676.098994] ref#1: shared block backref parent 195435151360
[11676.099001] ref#2: shared block backref parent 195435134976
[11676.099007] ref#3: shared block backref parent 195435102208
[11676.099014] ref#4: shared block backref parent 195426320384
[11676.099021] ref#5: shared block backref parent 195419783168
[11676.099027] ref#6: shared block backref parent 195417833472
[11676.099034] ref#7: shared block backref parent 195417800704
[11676.099040] ref#8: shared block backref parent 195412279296
[11676.099046] ref#9: shared block backref parent 195412246528
[11676.099053] ref#10: shared block backref parent 61178134528
[11676.099059] ref#11: shared block backref parent 61036675072
[11676.099066] ref#12: shared block backref parent 60782411776
[11676.099073] ref#13: shared block backref parent 60733652992
[11676.099080] ref#14: shared block backref parent 60720250880
[11676.099086] ref#15: shared block backref parent 60602433536
[11676.099093] ref#16: shared block backref parent 60301410304
[11676.099099] ref#17: shared block backref parent 1044201472
[11676.099106] ref#18: shared block backref parent 968540160
[11676.099112] ref#19: shared block backref parent 899121152
[11676.099119] ref#20: shared block backref parent 771686400
[11676.099125] ref#21: shared block backref parent 640876544
[11676.099132] ref#22: shared block backref parent 505544704
[11676.099138] ref#23: shared block backref parent 478150656
[11676.099145] ref#24: shared block backref parent 436912128
[11676.099151] ref#25: shared block backref parent 357351424
[11676.099158] ref#26: shared block backref parent 308428800
[11676.099164] ref#27: shared block backref parent 177635328
[11676.099171] ref#28: shared block backref parent 110493696
[11676.099177] ref#29: shared block backref parent 60325888
[11676.099184] ref#30: shared block backref parent 37421056
[11676.099190] item 89 key (45531136 182 195362816) itemoff 10268 itemsize=
 0
[11676.099198] shared block backref
[11676.099203] item 90 key (45531136 182 195395584) itemoff 10268 itemsize=
 0
[11676.099210] shared block backref
[11676.099215] item 91 key (45531136 182 302841856) itemoff 10268 itemsize=
 0
[11676.099222] shared block backref
[11676.099227] item 92 key (45531136 182 423952384) itemoff 10268 itemsize=
 0
[11676.099234] shared block backref
[11676.099240] item 93 key (45531136 182 423985152) itemoff 10268 itemsize=
 0
[11676.099246] shared block backref
[11676.099252] item 94 key (45531136 182 482164736) itemoff 10268 itemsize=
 0
[11676.099259] shared block backref
[11676.099264] item 95 key (45531136 182 482410496) itemoff 10268 itemsize=
 0
[11676.099271] shared block backref
[11676.099276] item 96 key (45531136 182 500989952) itemoff 10268 itemsize=
 0
[11676.099283] shared block backref
[11676.099288] item 97 key (45531136 182 543604736) itemoff 10268 itemsize=
 0
[11676.099295] shared block backref
[11676.099300] item 98 key (45531136 182 543670272) itemoff 10268 itemsize=
 0
[11676.099307] shared block backref
[11676.099312] item 99 key (45531136 182 588759040) itemoff 10268 itemsize=
 0
[11676.099319] shared block backref
[11676.099324] item 100 key (45531136 182 589037568) itemoff 10268
itemsize 0
[11676.099331] shared block backref
[11676.099337] item 101 key (45531136 182 589086720) itemoff 10268
itemsize 0
[11676.099343] shared block backref
[11676.099349] item 102 key (45531136 182 589119488) itemoff 10268
itemsize 0
[11676.099356] shared block backref
[11676.099361] item 103 key (45531136 182 589152256) itemoff 10268
itemsize 0
[11676.099368] shared block backref
[11676.099373] item 104 key (45531136 182 589168640) itemoff 10268
itemsize 0
[11676.099380] shared block backref
[11676.099385] item 105 key (45531136 182 589185024) itemoff 10268
itemsize 0
[11676.099392] shared block backref
[11676.099397] item 106 key (45531136 182 665681920) itemoff 10268
itemsize 0
[11676.099404] shared block backref
[11676.099409] item 107 key (45531136 182 675971072) itemoff 10268
itemsize 0
[11676.099417] shared block backref
[11676.099422] item 108 key (45531136 182 675987456) itemoff 10268
itemsize 0
[11676.099429] shared block backref
[11676.099434] item 109 key (45531136 182 676003840) itemoff 10268
itemsize 0
[11676.099441] shared block backref
[11676.099446] item 110 key (45531136 182 676675584) itemoff 10268
itemsize 0
[11676.099453] shared block backref
[11676.099459] item 111 key (45531136 182 676691968) itemoff 10268
itemsize 0
[11676.099466] shared block backref
[11676.099471] item 112 key (45531136 182 676708352) itemoff 10268
itemsize 0
[11676.099478] shared block backref
[11676.099484] item 113 key (45531136 182 1041022976) itemoff 10268
itemsize 0
[11676.099491] shared block backref
[11676.099496] item 114 key (45531136 182 194728820736) itemoff 10268
itemsize 0
[11676.099503] shared block backref
[11676.099508] item 115 key (45531136 182 194728919040) itemoff 10268
itemsize 0
[11676.099516] shared block backref
[11676.099521] item 116 key (45531136 182 194728935424) itemoff 10268
itemsize 0
[11676.099528] shared block backref
[11676.099534] item 117 key (45531136 182 194959704064) itemoff 10268
itemsize 0
[11676.099541] shared block backref
[11676.099546] item 118 key (45531136 182 194959753216) itemoff 10268
itemsize 0
[11676.099553] shared block backref
[11676.099558] item 119 key (45531136 182 195008970752) itemoff 10268
itemsize 0
[11676.099566] shared block backref
[11676.099571] item 120 key (45531136 182 195046653952) itemoff 10268
itemsize 0
[11676.099578] shared block backref
[11676.099583] item 121 key (45531136 182 195046948864) itemoff 10268
itemsize 0
[11676.099590] shared block backref
[11676.099596] item 122 key (45531136 182 195063873536) itemoff 10268
itemsize 0
[11676.099603] shared block backref
[11676.099608] item 123 key (45531136 182 195063922688) itemoff 10268
itemsize 0
[11676.099615] shared block backref
[11676.099620] item 124 key (45531136 182 195063955456) itemoff 10268
itemsize 0
[11676.099627] shared block backref
[11676.099632] item 125 key (45531136 182 195063988224) itemoff 10268
itemsize 0
[11676.099639] shared block backref
[11676.099644] item 126 key (45531136 182 195064004608) itemoff 10268
itemsize 0
[11676.099652] shared block backref
[11676.099657] item 127 key (45531136 182 195064020992) itemoff 10268
itemsize 0
[11676.099664] shared block backref
[11676.099669] item 128 key (45531136 182 195064758272) itemoff 10268
itemsize 0
[11676.099676] shared block backref
[11676.099682] item 129 key (45531136 182 195072589824) itemoff 10268
itemsize 0
[11676.099689] shared block backref
[11676.099694] item 130 key (45531136 182 195083485184) itemoff 10268
itemsize 0
[11676.099701] shared block backref
[11676.099706] item 131 key (45531136 182 195083517952) itemoff 10268
itemsize 0
[11676.099713] shared block backref
[11676.099718] item 132 key (45531136 182 195085434880) itemoff 10268
itemsize 0
[11676.099726] shared block backref
[11676.099731] item 133 key (45531136 182 195090776064) itemoff 10268
itemsize 0
[11676.099738] shared block backref
[11676.099743] item 134 key (45531136 182 195107913728) itemoff 10268
itemsize 0
[11676.099751] shared block backref
[11676.099756] item 135 key (45531136 182 195435905024) itemoff 10268
itemsize 0
[11676.099763] shared block backref
[11676.099769] item 136 key (45531136 182 195437969408) itemoff 10268
itemsize 0
[11676.099776] shared block backref
[11676.099781] item 137 key (45531136 182 195445637120) itemoff 10268
itemsize 0
[11676.099788] shared block backref
[11676.099793] item 138 key (45531136 182 195445669888) itemoff 10268
itemsize 0
[11676.099801] shared block backref
[11676.099806] item 139 key (45531136 182 195445686272) itemoff 10268
itemsize 0
[11676.099813] shared block backref
[11676.099819] item 140 key (45531136 182 195452207104) itemoff 10268
itemsize 0
[11676.099826] shared block backref
[11676.099831] item 141 key (45531136 182 195452223488) itemoff 10268
itemsize 0
[11676.099839] shared block backref
[11676.099844] item 142 key (45531136 182 195452469248) itemoff 10268
itemsize 0
[11676.099851] shared block backref
[11676.099857] item 143 key (45531136 182 195452485632) itemoff 10268
itemsize 0
[11676.099864] shared block backref
[11676.099869] item 144 key (45531136 182 195452502016) itemoff 10268
itemsize 0
[11676.099876] shared block backref
[11676.099881] item 145 key (45531136 182 195452518400) itemoff 10268
itemsize 0
[11676.099888] shared block backref
[11676.099893] item 146 key (45531136 182 195452534784) itemoff 10268
itemsize 0
[11676.099901] shared block backref
[11676.099906] item 147 key (45531136 182 195452551168) itemoff 10268
itemsize 0
[11676.099913] shared block backref
[11676.099918] item 148 key (45531136 182 195455680512) itemoff 10268
itemsize 0
[11676.099925] shared block backref
[11676.099930] item 149 key (45531136 182 195462217728) itemoff 10268
itemsize 0
[11676.099938] shared block backref
[11676.099943] item 150 key (45531136 182 195462250496) itemoff 10268
itemsize 0
[11676.099950] shared block backref
[11676.099955] item 151 key (45531136 182 195466051584) itemoff 10268
itemsize 0
[11676.099962] shared block backref
[11676.099968] item 152 key (45531136 182 195466084352) itemoff 10268
itemsize 0
[11676.099975] shared block backref
[11676.099980] item 153 key (45531136 182 195470917632) itemoff 10268
itemsize 0
[11676.099987] shared block backref
[11676.099993] item 154 key (45531136 182 195470950400) itemoff 10268
itemsize 0
[11676.100000] shared block backref
[11676.100005] item 155 key (45531136 182 195470966784) itemoff 10268
itemsize 0
[11676.100012] shared block backref
[11676.100017] item 156 key (45531136 182 195470983168) itemoff 10268
itemsize 0
[11676.100024] shared block backref
[11676.100030] item 157 key (45531136 182 195470999552) itemoff 10268
itemsize 0
[11676.100037] shared block backref
[11676.100042] item 158 key (45531136 182 195471015936) itemoff 10268
itemsize 0
[11676.100049] shared block backref
[11676.100055] item 159 key (45531136 182 195485302784) itemoff 10268
itemsize 0
[11676.100062] shared block backref
[11676.100067] item 160 key (45531136 182 195488825344) itemoff 10268
itemsize 0
[11676.100074] shared block backref
[11676.100080] item 161 key (45531136 182 195488940032) itemoff 10268
itemsize 0
[11676.100087] shared block backref
[11676.100092] item 162 key (45531136 182 195502473216) itemoff 10268
itemsize 0
[11676.100099] shared block backref
[11676.100104] item 163 key (45531136 182 195518971904) itemoff 10268
itemsize 0
[11676.100111] shared block backref
[11676.100117] item 164 key (45531136 182 195577069568) itemoff 10268
itemsize 0
[11676.100124] shared block backref
[11676.100129] item 165 key (45531136 182 195583279104) itemoff 10268
itemsize 0
[11676.100136] shared block backref
[11676.100141] item 166 key (45531136 182 195755687936) itemoff 10268
itemsize 0
[11676.100148] shared block backref
[11676.100154] item 167 key (45531136 182 195762470912) itemoff 10268
itemsize 0
[11676.100161] shared block backref
[11676.100166] item 168 key (45531136 182 269878607872) itemoff 10268
itemsize 0
[11676.100173] shared block backref
[11676.100178] item 169 key (45547520 169 0) itemoff 10190 itemsize 78
[11676.100185] extent refs 6 gen 192819 flags 258
[11676.100192] ref#0: shared block backref parent 195761537024
[11676.100199] ref#1: shared block backref parent 195761143808
[11676.100205] ref#2: shared block backref parent 195761111040
[11676.100212] ref#3: shared block backref parent 60739813376
[11676.100218] ref#4: shared block backref parent 60579119104
[11676.100225] ref#5: shared block backref parent 454180864
[11676.100231] item 170 key (45563904 169 0) itemoff 10148 itemsize 42
[11676.100238] extent refs 2 gen 192487 flags 258
[11676.100245] ref#0: shared block backref parent 725909504
[11676.100251] ref#1: shared block backref parent 725319680
[11676.100258] item 171 key (45580288 169 0) itemoff 10106 itemsize 42
[11676.100265] extent refs 2 gen 243211 flags 258
[11676.100271] ref#0: tree block backref root 258
[11676.100277] ref#1: shared block backref parent 665616384
[11676.100284] item 172 key (45596672 169 0) itemoff 10064 itemsize 42
[11676.100291] extent refs 2 gen 187377 flags 258
[11676.100297] ref#0: shared block backref parent 195771514880
[11676.100304] ref#1: shared block backref parent 60296790016
[11676.100310] item 173 key (45613056 169 0) itemoff 10022 itemsize 42
[11676.100317] extent refs 2 gen 192487 flags 258
[11676.100323] ref#0: shared block backref parent 545406976
[11676.100330] ref#1: shared block backref parent 268304384
[11676.100337] item 174 key (45629440 169 0) itemoff 9980 itemsize 42
[11676.100344] extent refs 2 gen 240909 flags 2
[11676.100350] ref#0: shared block backref parent 61139599360
[11676.100357] ref#1: shared block backref parent 618594304
[11676.100363] item 175 key (45645824 169 0) itemoff 9884 itemsize 96
[11676.100370] extent refs 8 gen 243211 flags 258
[11676.100376] ref#0: shared block backref parent 60467544064
[11676.100383] ref#1: shared block backref parent 60467527680
[11676.100390] ref#2: shared block backref parent 60466462720
[11676.100397] ref#3: shared block backref parent 60383789056
[11676.100403] ref#4: shared block backref parent 1021542400
[11676.100410] ref#5: shared block backref parent 518422528
[11676.100417] ref#6: shared block backref parent 518406144
[11676.100423] ref#7: shared block backref parent 517996544
[11676.100430] item 176 key (45662208 169 0) itemoff 9842 itemsize 42
[11676.100438] extent refs 2 gen 197680 flags 258
[11676.100444] ref#0: shared block backref parent 1063616512
[11676.100451] ref#1: shared block backref parent 174981120
[11676.100458] item 177 key (45678592 169 0) itemoff 9800 itemsize 42
[11676.100465] extent refs 2 gen 203711 flags 258
[11676.100472] ref#0: shared block backref parent 61282385920
[11676.100479] ref#1: shared block backref parent 430587904
[11676.100486] item 178 key (45694976 169 0) itemoff 9758 itemsize 42
[11676.100493] extent refs 2 gen 197680 flags 258
[11676.100499] ref#0: shared block backref parent 60347826176
[11676.100507] ref#1: shared block backref parent 664911872
[11676.100513] item 179 key (45711360 169 0) itemoff 9716 itemsize 42
[11676.100520] extent refs 2 gen 200806 flags 258
[11676.100527] ref#0: shared block backref parent 983482368
[11676.100533] ref#1: shared block backref parent 608403456
[11676.100540] item 180 key (45727744 169 0) itemoff 9656 itemsize 60
[11676.100547] extent refs 4 gen 200844 flags 258
[11676.100553] ref#0: shared block backref parent 994787328
[11676.100560] ref#1: shared block backref parent 994754560
[11676.100566] ref#2: shared block backref parent 266092544
[11676.100573] ref#3: shared block backref parent 232079360
[11676.100579] item 181 key (45744128 169 0) itemoff 9614 itemsize 42
[11676.100587] extent refs 2 gen 200806 flags 258
[11676.100593] ref#0: shared block backref parent 983482368
[11676.100599] ref#1: shared block backref parent 608403456
[11676.100606] item 182 key (45760512 169 0) itemoff 9554 itemsize 60
[11676.100613] extent refs 4 gen 189130 flags 258
[11676.100619] ref#0: shared block backref parent 929480704
[11676.100626] ref#1: shared block backref parent 851935232
[11676.100632] ref#2: shared block backref parent 851804160
[11676.100639] ref#3: shared block backref parent 99139584
[11676.100645] item 183 key (45776896 169 0) itemoff 9512 itemsize 42
[11676.100652] extent refs 2 gen 192487 flags 258
[11676.100658] ref#0: shared block backref parent 743227392
[11676.100665] ref#1: shared block backref parent 725434368
[11676.100672] item 184 key (45793280 169 0) itemoff 9452 itemsize 60
[11676.100679] extent refs 4 gen 189130 flags 258
[11676.100685] ref#0: shared block backref parent 195761602560
[11676.100692] ref#1: shared block backref parent 195760586752
[11676.100698] ref#2: shared block backref parent 980795392
[11676.100705] ref#3: shared block backref parent 46743552
[11676.100711] item 185 key (45809664 169 0) itemoff 9410 itemsize 42
[11676.100719] extent refs 2 gen 50831 flags 2
[11676.100725] ref#0: tree block backref root 258
[11676.100731] ref#1: shared block backref parent 195782443008
[11676.100738] item 186 key (45826048 169 0) itemoff 9350 itemsize 60
[11676.100745] extent refs 4 gen 189208 flags 258
[11676.100752] ref#0: shared block backref parent 194970157056
[11676.100758] ref#1: shared block backref parent 194970075136
[11676.100765] ref#2: shared block backref parent 783106048
[11676.100771] ref#3: shared block backref parent 102219776
[11676.100778] item 187 key (45842432 169 0) itemoff 9308 itemsize 42
[11676.100785] extent refs 2 gen 243211 flags 258
[11676.100792] ref#0: shared block backref parent 60541370368
[11676.100798] ref#1: shared block backref parent 317997056
[11676.100805] item 188 key (45858816 169 0) itemoff 9248 itemsize 60
[11676.100812] extent refs 4 gen 197680 flags 258
[11676.100818] ref#0: shared block backref parent 61137747968
[11676.100825] ref#1: shared block backref parent 61137666048
[11676.100831] ref#2: shared block backref parent 399261696
[11676.100838] ref#3: shared block backref parent 399179776
[11676.100844] item 189 key (45875200 169 0) itemoff 9188 itemsize 60
[11676.100851] extent refs 4 gen 200844 flags 258
[11676.100858] ref#0: shared block backref parent 195761618944
[11676.100864] ref#1: shared block backref parent 195761094656
[11676.100871] ref#2: shared block backref parent 60879749120
[11676.100877] ref#3: shared block backref parent 44613632
[11676.100884] item 190 key (45891584 169 0) itemoff 9146 itemsize 42
[11676.100891] extent refs 2 gen 200806 flags 258
[11676.100898] ref#0: shared block backref parent 994754560
[11676.100904] ref#1: shared block backref parent 232079360
[11676.100910] item 191 key (45907968 169 0) itemoff 9032 itemsize 114
[11676.100918] extent refs 10 gen 200806 flags 258
[11676.100924] ref#0: shared block backref parent 194995273728
[11676.100931] ref#1: shared block backref parent 194995257344
[11676.100937] ref#2: shared block backref parent 194995044352
[11676.100944] ref#3: shared block backref parent 194994995200
[11676.100950] ref#4: shared block backref parent 60400648192
[11676.100957] ref#5: shared block backref parent 60400582656
[11676.100963] ref#6: shared block backref parent 60400517120
[11676.100970] ref#7: shared block backref parent 60400369664
[11676.100976] ref#8: shared block backref parent 983482368
[11676.100983] ref#9: shared block backref parent 608403456
[11676.100989] item 192 key (45924352 169 0) itemoff 8900 itemsize 132
[11676.100997] extent refs 12 gen 192487 flags 258
[11676.101003] ref#0: shared block backref parent 61137764352
[11676.101010] ref#1: shared block backref parent 61137633280
[11676.101016] ref#2: shared block backref parent 61136748544
[11676.101023] ref#3: shared block backref parent 61136699392
[11676.101030] ref#4: shared block backref parent 61134749696
[11676.101036] ref#5: shared block backref parent 61134635008
[11676.101043] ref#6: shared block backref parent 749486080
[11676.101050] ref#7: shared block backref parent 749322240
[11676.101056] ref#8: shared block backref parent 628097024
[11676.101063] ref#9: shared block backref parent 408125440
[11676.101069] ref#10: shared block backref parent 398770176
[11676.101076] ref#11: shared block backref parent 398376960
[11676.101083] item 193 key (45940736 169 0) itemoff 8858 itemsize 42
[11676.101090] extent refs 2 gen 240909 flags 2
[11676.101096] ref#0: shared block backref parent 195550232576
[11676.101103] ref#1: shared block backref parent 1056522240
[11676.101109] item 194 key (45957120 169 0) itemoff 8816 itemsize 42
[11676.101117] extent refs 2 gen 197680 flags 258
[11676.101123] ref#0: shared block backref parent 61137666048
[11676.101129] ref#1: shared block backref parent 399261696
[11676.101136] item 195 key (45973504 169 0) itemoff 8774 itemsize 42
[11676.101143] extent refs 2 gen 220751 flags 258
[11676.101150] ref#0: shared block backref parent 195766960128
[11676.101157] ref#1: shared block backref parent 61135978496
[11676.101163] item 196 key (45989888 169 0) itemoff 8732 itemsize 42
[11676.101170] extent refs 2 gen 192487 flags 258
[11676.101176] ref#0: shared block backref parent 61136699392
[11676.101183] ref#1: shared block backref parent 408125440
[11676.101190] item 197 key (46006272 169 0) itemoff 8690 itemsize 42
[11676.101197] extent refs 2 gen 189130 flags 258
[11676.101203] ref#0: shared block backref parent 195169894400
[11676.101210] ref#1: shared block backref parent 322945024
[11676.101217] item 198 key (46022656 169 0) itemoff 8648 itemsize 42
[11676.101224] extent refs 2 gen 192487 flags 258
[11676.101230] ref#0: shared block backref parent 61136699392
[11676.101237] ref#1: shared block backref parent 408125440
[11676.101243] item 199 key (46039040 169 0) itemoff 8588 itemsize 60
[11676.101250] extent refs 4 gen 189208 flags 258
[11676.101257] ref#0: shared block backref parent 929480704
[11676.101263] ref#1: shared block backref parent 851935232
[11676.101270] ref#2: shared block backref parent 851804160
[11676.101276] ref#3: shared block backref parent 99139584
[11676.101283] item 200 key (46055424 169 0) itemoff 8528 itemsize 60
[11676.101290] extent refs 4 gen 189208 flags 258
[11676.101296] ref#0: shared block backref parent 194970157056
[11676.101303] ref#1: shared block backref parent 194970075136
[11676.101309] ref#2: shared block backref parent 783106048
[11676.101316] ref#3: shared block backref parent 102219776
[11676.101323] item 201 key (46071808 169 0) itemoff 8468 itemsize 60
[11676.101330] extent refs 4 gen 189208 flags 258
[11676.101336] ref#0: shared block backref parent 929480704
[11676.101343] ref#1: shared block backref parent 851935232
[11676.101350] ref#2: shared block backref parent 851804160
[11676.101356] ref#3: shared block backref parent 99139584
[11676.101363] item 202 key (46088192 169 0) itemoff 8408 itemsize 60
[11676.101370] extent refs 4 gen 189208 flags 258
[11676.101377] ref#0: shared block backref parent 194970157056
[11676.101383] ref#1: shared block backref parent 194970075136
[11676.101390] ref#2: shared block backref parent 783106048
[11676.101396] ref#3: shared block backref parent 102219776
[11676.101403] item 203 key (46104576 169 0) itemoff 8366 itemsize 42
[11676.101410] extent refs 2 gen 192487 flags 258
[11676.101416] ref#0: shared block backref parent 743227392
[11676.101422] ref#1: shared block backref parent 725434368
[11676.101429] item 204 key (46120960 169 0) itemoff 8324 itemsize 42
[11676.101436] extent refs 2 gen 192487 flags 258
[11676.101442] ref#0: shared block backref parent 61136699392
[11676.101449] ref#1: shared block backref parent 408125440
[11676.101455] item 205 key (46137344 169 0) itemoff 8282 itemsize 42
[11676.101462] extent refs 2 gen 187377 flags 258
[11676.101468] ref#0: shared block backref parent 61340139520
[11676.101475] ref#1: shared block backref parent 851214336
[11676.101482] item 206 key (46153728 169 0) itemoff 8240 itemsize 42
[11676.101489] extent refs 2 gen 243518 flags 258
[11676.101495] ref#0: shared block backref parent 1071939584
[11676.101502] ref#1: shared block backref parent 929988608
[11676.101508] item 207 key (46170112 169 0) itemoff 7946 itemsize 294
[11676.101515] extent refs 30 gen 187377 flags 258
[11676.101521] ref#0: shared block backref parent 195780591616
[11676.101528] ref#1: shared block backref parent 195780378624
[11676.101535] ref#2: shared block backref parent 195780296704
[11676.101541] ref#3: shared block backref parent 195780263936
[11676.101548] ref#4: shared block backref parent 195776561152
[11676.101554] ref#5: shared block backref parent 195773628416
[11676.101561] ref#6: shared block backref parent 195771514880
[11676.101567] ref#7: shared block backref parent 195771482112
[11676.101574] ref#8: shared block backref parent 195755409408
[11676.101580] ref#9: shared block backref parent 195755294720
[11676.101587] ref#10: shared block backref parent 195755245568
[11676.101594] ref#11: shared block backref parent 195755196416
[11676.101600] ref#12: shared block backref parent 60305293312
[11676.101607] ref#13: shared block backref parent 60302934016
[11676.101613] ref#14: shared block backref parent 60302573568
[11676.101620] ref#15: shared block backref parent 60301819904
[11676.101626] ref#16: shared block backref parent 60297854976
[11676.101633] ref#17: shared block backref parent 60297773056
[11676.101640] ref#18: shared block backref parent 60297756672
[11676.101646] ref#19: shared block backref parent 60297740288
[11676.101653] ref#20: shared block backref parent 60297641984
[11676.101660] ref#21: shared block backref parent 60297281536
[11676.101667] ref#22: shared block backref parent 60297052160
[11676.101673] ref#23: shared block backref parent 60296790016
[11676.101680] ref#24: shared block backref parent 60296757248
[11676.101686] ref#25: shared block backref parent 60296691712
[11676.101693] ref#26: shared block backref parent 60296167424
[11676.101700] ref#27: shared block backref parent 549322752
[11676.101706] ref#28: shared block backref parent 374439936
[11676.101713] ref#29: shared block backref parent 54837248
[11676.101720] item 208 key (46186496 169 0) itemoff 7904 itemsize 42
[11676.101727] extent refs 2 gen 187377 flags 258
[11676.101733] ref#0: shared block backref parent 61134962688
[11676.101740] ref#1: shared block backref parent 414777344
[11676.101747] item 209 key (46202880 169 0) itemoff 7862 itemsize 42
[11676.101754] extent refs 2 gen 243211 flags 258
[11676.101760] ref#0: shared block backref parent 60541435904
[11676.101767] ref#1: shared block backref parent 317931520
[11676.101774] item 210 key (46219264 169 0) itemoff 7820 itemsize 42
[11676.101781] extent refs 2 gen 192487 flags 258
[11676.101787] ref#0: shared block backref parent 61136699392
[11676.101794] ref#1: shared block backref parent 408125440
[11676.101800] item 211 key (46235648 169 0) itemoff 7778 itemsize 42
[11676.101807] extent refs 2 gen 243518 flags 258
[11676.101813] ref#0: shared block backref parent 1068941312
[11676.101820] ref#1: shared block backref parent 930447360
[11676.101826] item 212 key (46252032 169 0) itemoff 7736 itemsize 42
[11676.101833] extent refs 2 gen 192487 flags 258
[11676.101840] ref#0: shared block backref parent 61136699392
[11676.101846] ref#1: shared block backref parent 408125440
[11676.101853] item 213 key (46268416 169 0) itemoff 7676 itemsize 60
[11676.101860] extent refs 4 gen 189130 flags 258
[11676.101866] ref#0: shared block backref parent 195447996416
[11676.101873] ref#1: shared block backref parent 195447701504
[11676.101879] ref#2: shared block backref parent 195040591872
[11676.101886] ref#3: shared block backref parent 195040575488
[11676.101892] item 214 key (46284800 169 0) itemoff 7634 itemsize 42
[11676.101900] extent refs 2 gen 192487 flags 258
[11676.101906] ref#0: shared block backref parent 61136699392
[11676.101912] ref#1: shared block backref parent 408125440
[11676.101919] item 215 key (46301184 169 0) itemoff 7592 itemsize 42
[11676.101926] extent refs 2 gen 164246 flags 2
[11676.101932] ref#0: shared block backref parent 61214048256
[11676.101939] ref#1: shared block backref parent 578879488
[11676.101946] item 216 key (46317568 169 0) itemoff 7550 itemsize 42
[11676.101953] extent refs 2 gen 119775 flags 2
[11676.101959] ref#0: shared block backref parent 61214048256
[11676.101966] ref#1: shared block backref parent 578879488
[11676.101973] item 217 key (46333952 169 0) itemoff 7490 itemsize 60
[11676.101980] extent refs 4 gen 189208 flags 258
[11676.101986] ref#0: shared block backref parent 929480704
[11676.101992] ref#1: shared block backref parent 851935232
[11676.101999] ref#2: shared block backref parent 851804160
[11676.102005] ref#3: shared block backref parent 99139584
[11676.102012] item 218 key (46350336 169 0) itemoff 7430 itemsize 60
[11676.102019] extent refs 4 gen 189208 flags 258
[11676.102025] ref#0: shared block backref parent 194970157056
[11676.102032] ref#1: shared block backref parent 194970075136
[11676.102038] ref#2: shared block backref parent 783106048
[11676.102045] ref#3: shared block backref parent 102219776
[11676.102051] item 219 key (46366720 169 0) itemoff 7370 itemsize 60
[11676.102058] extent refs 4 gen 189208 flags 258
[11676.102064] ref#0: shared block backref parent 929480704
[11676.102071] ref#1: shared block backref parent 851935232
[11676.102078] ref#2: shared block backref parent 851804160
[11676.102084] ref#3: shared block backref parent 99139584
[11676.102091] item 220 key (46383104 169 0) itemoff 7328 itemsize 42
[11676.102098] extent refs 2 gen 243518 flags 258
[11676.102104] ref#0: shared block backref parent 1067794432
[11676.102110] ref#1: shared block backref parent 930660352
[11676.102117] item 221 key (46399488 169 0) itemoff 7286 itemsize 42
[11676.102124] extent refs 2 gen 243518 flags 258
[11676.102130] ref#0: shared block backref parent 1068744704
[11676.102137] ref#1: shared block backref parent 930463744
[11676.102143] item 222 key (46415872 169 0) itemoff 7172 itemsize 114
[11676.102150] extent refs 10 gen 187377 flags 258
[11676.102157] ref#0: shared block backref parent 195780378624
[11676.102163] ref#1: shared block backref parent 195773628416
[11676.102170] ref#2: shared block backref parent 195771514880
[11676.102177] ref#3: shared block backref parent 195771482112
[11676.102183] ref#4: shared block backref parent 195755294720
[11676.102190] ref#5: shared block backref parent 60297773056
[11676.102196] ref#6: shared block backref parent 60297052160
[11676.102203] ref#7: shared block backref parent 60296790016
[11676.102210] ref#8: shared block backref parent 60296757248
[11676.102216] ref#9: shared block backref parent 60296691712
[11676.102223] item 223 key (46432256 169 0) itemoff 7130 itemsize 42
[11676.102230] extent refs 2 gen 187377 flags 258
[11676.102236] ref#0: shared block backref parent 195771514880
[11676.102243] ref#1: shared block backref parent 60296790016
[11676.102249] item 224 key (46448640 169 0) itemoff 7088 itemsize 42
[11676.102256] extent refs 2 gen 187377 flags 258
[11676.102263] ref#0: shared block backref parent 195771514880
[11676.102269] ref#1: shared block backref parent 60296790016
[11676.102276] item 225 key (46465024 169 0) itemoff 7046 itemsize 42
[11676.102291] extent refs 2 gen 192487 flags 258
[11676.102299] ref#0: shared block backref parent 743227392
[11676.102305] ref#1: shared block backref parent 725434368
[11676.102312] item 226 key (46481408 169 0) itemoff 6734 itemsize 312
[11676.102319] extent refs 32 gen 167479 flags 258
[11676.102325] ref#0: shared block backref parent 60332507136
[11676.102332] ref#1: shared block backref parent 60329164800
[11676.102338] ref#2: shared block backref parent 60328411136
[11676.102345] ref#3: shared block backref parent 60325937152
[11676.102351] ref#4: shared block backref parent 60325920768
[11676.102358] ref#5: shared block backref parent 60325691392
[11676.102364] ref#6: shared block backref parent 60325249024
[11676.102371] ref#7: shared block backref parent 60325068800
[11676.102377] ref#8: shared block backref parent 60324773888
[11676.102384] ref#9: shared block backref parent 60324708352
[11676.102390] ref#10: shared block backref parent 60324560896
[11676.102397] ref#11: shared block backref parent 60322529280
[11676.102404] ref#12: shared block backref parent 60322152448
[11676.102410] ref#13: shared block backref parent 60322103296
[11676.102417] ref#14: shared block backref parent 60321955840
[11676.102423] ref#15: shared block backref parent 60321792000
[11676.102430] ref#16: shared block backref parent 523534336
[11676.102437] ref#17: shared block backref parent 481886208
[11676.102443] ref#18: shared block backref parent 478756864
[11676.102449] ref#19: shared block backref parent 418054144
[11676.102456] ref#20: shared block backref parent 417955840
[11676.102463] ref#21: shared block backref parent 417677312
[11676.102469] ref#22: shared block backref parent 417234944
[11676.102476] ref#23: shared block backref parent 394592256
[11676.102482] ref#24: shared block backref parent 394395648
[11676.102489] ref#25: shared block backref parent 394346496
[11676.102496] ref#26: shared block backref parent 392134656
[11676.102503] ref#27: shared block backref parent 372146176
[11676.102509] ref#28: shared block backref parent 360038400
[11676.102516] ref#29: shared block backref parent 358318080
[11676.102523] ref#30: shared block backref parent 357793792
[11676.102529] ref#31: shared block backref parent 356679680
[11676.102536] item 227 key (46497792 169 0) itemoff 6692 itemsize 42
[11676.102543] extent refs 2 gen 192487 flags 258
[11676.102549] ref#0: shared block backref parent 743227392
[11676.102556] ref#1: shared block backref parent 725434368
[11676.102562] item 228 key (46514176 169 0) itemoff 6632 itemsize 60
[11676.102570] extent refs 4 gen 197680 flags 258
[11676.102576] ref#0: shared block backref parent 61137747968
[11676.102582] ref#1: shared block backref parent 61137666048
[11676.102589] ref#2: shared block backref parent 399261696
[11676.102596] ref#3: shared block backref parent 399179776
[11676.102602] item 229 key (46530560 169 0) itemoff 6572 itemsize 60
[11676.102609] extent refs 4 gen 243518 flags 258
[11676.102616] ref#0: shared block backref parent 1069858816
[11676.102622] ref#1: shared block backref parent 1069367296
[11676.102629] ref#2: shared block backref parent 930365440
[11676.102635] ref#3: shared block backref parent 930086912
[11676.102642] item 230 key (46546944 169 0) itemoff 6530 itemsize 42
[11676.102649] extent refs 2 gen 220751 flags 258
[11676.102655] ref#0: shared block backref parent 195766960128
[11676.102662] ref#1: shared block backref parent 61135978496
[11676.102668] item 231 key (46563328 169 0) itemoff 6470 itemsize 60
[11676.102675] extent refs 4 gen 200844 flags 258
[11676.102681] ref#0: shared block backref parent 994787328
[11676.102688] ref#1: shared block backref parent 994754560
[11676.102694] ref#2: shared block backref parent 266092544
[11676.102701] ref#3: shared block backref parent 232079360
[11676.102707] item 232 key (46579712 169 0) itemoff 6428 itemsize 42
[11676.102714] extent refs 2 gen 192487 flags 258
[11676.102721] ref#0: shared block backref parent 61136699392
[11676.102728] ref#1: shared block backref parent 408125440
[11676.102734] item 233 key (46596096 169 0) itemoff 6332 itemsize 96
[11676.102741] extent refs 8 gen 226875 flags 258
[11676.102747] ref#0: shared block backref parent 195577593856
[11676.102754] ref#1: shared block backref parent 195577577472
[11676.102761] ref#2: shared block backref parent 195577561088
[11676.102767] ref#3: shared block backref parent 195493150720
[11676.102774] ref#4: shared block backref parent 1059160064
[11676.102780] ref#5: shared block backref parent 1049411584
[11676.102787] ref#6: shared block backref parent 52822016
[11676.102793] ref#7: shared block backref parent 51445760
[11676.102800] item 234 key (46612480 169 0) itemoff 6290 itemsize 42
[11676.102807] extent refs 2 gen 243518 flags 258
[11676.102813] ref#0: shared block backref parent 1069514752
[11676.102820] ref#1: shared block backref parent 930136064
[11676.102826] item 235 key (46628864 169 0) itemoff 6230 itemsize 60
[11676.102833] extent refs 4 gen 200844 flags 258
[11676.102840] ref#0: shared block backref parent 195761618944
[11676.102846] ref#1: shared block backref parent 195761094656
[11676.102853] ref#2: shared block backref parent 60879749120
[11676.102859] ref#3: shared block backref parent 44613632
[11676.102866] item 236 key (46645248 169 0) itemoff 6170 itemsize 60
[11676.102873] extent refs 4 gen 220751 flags 258
[11676.102880] ref#0: shared block backref parent 195430842368
[11676.102887] ref#1: shared block backref parent 195430793216
[11676.102893] ref#2: shared block backref parent 911425536
[11676.102900] ref#3: shared block backref parent 149979136
[11676.102906] item 237 key (46661632 169 0) itemoff 6128 itemsize 42
[11676.102914] extent refs 2 gen 192487 flags 258
[11676.102920] ref#0: shared block backref parent 60648177664
[11676.102926] ref#1: shared block backref parent 429522944
[11676.102933] item 238 key (46678016 169 0) itemoff 6095 itemsize 33
[11676.102940] extent refs 1 gen 240730 flags 2
[11676.102946] ref#0: shared block backref parent 195248291840
[11676.102953] item 239 key (46694400 169 0) itemoff 6071 itemsize 24
[11676.102960] extent refs 50 gen 167479 flags 258
[11676.102966] item 240 key (46694400 182 60321792000) itemoff 6071
itemsize 0
[11676.102973] shared block backref
[11676.102978] item 241 key (46694400 182 60321955840) itemoff 6071
itemsize 0
[11676.102986] shared block backref
[11676.102991] BTRFS error (device dm-2): extent item not found for
insert, bytenr 46678016 num_bytes 16384 parent 908427264 root_objectid
490 owner 1 offset 0
[11676.103004] BTRFS error (device dm-2): failed to run delayed ref for
logical 46678016 num_bytes 16384 type 182 action 1 ref_mod 1: -117
[11676.103016] ------------[ cut here ]------------
[11676.103022] BTRFS: Transaction aborted (error -117)
[11676.103090] WARNING: CPU: 1 PID: 11611 at fs/btrfs/extent-tree.c:2249
btrfs_run_delayed_refs+0x108/0x110 [btrfs]
[11676.103239] Modules linked in: nls_iso8859_1 nls_cp437 vfat fat uas
usb_storage snd_hrtimer af_packet nft_fib_inet nft_fib_ipv4 nft_fib_ipv6
nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct
nft_chain_nat nf_tables ebtable_nat ebtable_broute ip6table_nat
ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw
iptable_security ip_set nfnetlink ebtable_filter ebtables
ip6table_filter ip6_tables iptable_filter bpfilter qrtr nvidia_drm(POE)
nvidia_modeset(POE) nvidia_uvm(POE) snd_seq_dummy snd_seq_oss
snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss snd_mixer_oss
nvidia(POE) snd_hda_codec_analog rt61pci snd_hda_codec_generic rt2x00pci
ledtrig_audio rt2x00mmio rt2x00lib snd_hda_codec_hdmi mac80211
snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi libarc4 snd_hda_codec
pktcdvd snd_hda_core cfg80211 snd_hwdep snd_pcm eeprom_93cx6 rfkill
coretemp crc_itu_t snd_timer iTCO_wdt snd at24 kvm_intel mei_wdt mei_me
i2c_i801
[11676.103307] ppdev gpio_ich intel_pmc_bxt soundcore
iTCO_vendor_support mei pcspkr i2c_smbus kvm e1000e parport_pc lpc_ich
irqbypass acpi_cpufreq parport tiny_power_button fuse efi_pstore
configfs dmi_sysfs ip_tables x_tables crypto_simd cryptd xts dm_crypt
essiv authenc trusted asn1_encoder tee sr_mod cdrom hid_generic usbhid
ata_piix ahci libahci ata_generic libata sd_mod scsi_dh_emc scsi_dh_rdac
scsi_dh_alua sha512_ssse3 t10_pi sha256_ssse3 sha1_ssse3 sg uhci_hcd
ehci_pci ehci_hcd video floppy wmi scsi_mod usbcore scsi_common button
serio_raw btrfs blake2b_generic libcrc32c xor raid6_pq dm_mirror
dm_region_hash dm_log dm_mod msr
[11676.103416] CPU: 1 PID: 11611 Comm: IndexedDB #324 Tainted: P W OE
6.7.6-1-default #1 openSUSE Tumbleweed
cd9816be5099dbe04750b2583fe34462de6dcdca
[11676.103428] Hardware name: LENOVO 9088A83/LENOVO, BIOS 2RKT64BUS
01/08/2014
[11676.103435] RIP: 0010:btrfs_run_delayed_refs+0x108/0x110 [btrfs]
[11676.103543] Code: 75 1a 48 8b 7d 60 89 da 48 c7 c6 70 6b 4b c0 e8 9e
06 0d 00 41 b8 01 00 00 00 eb b8 89 de 48 c7 c7 98 6b 4b c0 e8 e8 6d b9
c9 <0f> 0b eb e6 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90
[11676.103553] RSP: 0018:ffffa1e2437a7d40 EFLAGS: 00010286
[11676.103561] RAX: 0000000000000000 RBX: 00000000ffffff8b RCX:
0000000000000027
[11676.103567] RDX: ffff8e96a80a7508 RSI: 0000000000000001 RDI:
ffff8e96a80a7500
[11676.103574] RBP: ffff8e95804067e0 R08: 0000000000000000 R09:
ffffa1e2437a7be0
[11676.103580] R10: 0000000000000003 R11: ffffffff8bd58a68 R12:
0000000000000000
[11676.103587] R13: ffff8e95f053c000 R14: ffffa1e2437a7e50 R15:
ffffa1e2437a7dc8
[11676.103593] FS: 00007f6b5f6be6c0(0000) GS:ffff8e96a8080000(0000)
knlGS:0000000000000000
[11676.103601] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[11676.103607] CR2: 00007f543c2dd008 CR3: 0000000152be4000 CR4:
00000000000406f0
[11676.103614] Call Trace:
[11676.103621] <TASK>
[11676.103628] ? btrfs_run_delayed_refs+0x108/0x110 [btrfs
9fe3ae0d97dca82fbee6feb90e34ae2e7e636218]
[11676.103733] ? __warn+0x81/0x130
[11676.103744] ? btrfs_run_delayed_refs+0x108/0x110 [btrfs
9fe3ae0d97dca82fbee6feb90e34ae2e7e636218]
[11676.103849] ? report_bug+0x171/0x1a0
[11676.103858] ? handle_bug+0x3c/0x80
[11676.103866] ? exc_invalid_op+0x17/0x70
[11676.103874] ? asm_exc_invalid_op+0x1a/0x20
[11676.103883] ? btrfs_run_delayed_refs+0x108/0x110 [btrfs
9fe3ae0d97dca82fbee6feb90e34ae2e7e636218]
[11676.103987] btrfs_commit_transaction+0x76/0xe80 [btrfs
9fe3ae0d97dca82fbee6feb90e34ae2e7e636218]
[11676.104098] btrfs_sync_file+0x477/0x5a0 [btrfs
9fe3ae0d97dca82fbee6feb90e34ae2e7e636218]
[11676.104212] __x64_sys_fsync+0x3b/0x70
[11676.104220] do_syscall_64+0x64/0xe0
[11676.104230] ? syscall_exit_to_user_mode+0x2b/0x40
[11676.104237] ? do_syscall_64+0x70/0xe0
[11676.104245] ? do_syscall_64+0x70/0xe0
[11676.104253] ? do_syscall_64+0x70/0xe0
[11676.104261] ? do_syscall_64+0x70/0xe0
[11676.104269] ? exc_page_fault+0x71/0x160
[11676.104276] entry_SYSCALL_64_after_hwframe+0x6e/0x76
[11676.104285] RIP: 0033:0x7f6b7210933a
[11676.104317] Code: 00 00 0f 05 48 3d 00 f0 ff ff 77 44 c3 0f 1f 00 48
83 ec 18 89 7c 24 0c e8 41 54 f8 ff 8b 7c 24 0c 89 c2 b8 4a 00 00 00 0f
05 <48> 3d 00 f0 ff ff 77 36 89 d7 89 44 24 0c e8 b1 54 f8 ff 8b 44 24
[11676.104326] RSP: 002b:00007f6b5f6bccc0 EFLAGS: 00000293 ORIG_RAX:
000000000000004a
[11676.104334] RAX: ffffffffffffffda RBX: 00007f6ac8254078 RCX:
00007f6b7210933a
[11676.104341] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
0000000000000094
[11676.104348] RBP: 0000000000000003 R08: 00007f6b411527b0 R09:
00007f6b1c17ac80
[11676.104354] R10: 0000000000000004 R11: 0000000000000293 R12:
0000000000000001
[11676.104361] R13: 0000000000000004 R14: 00007f6b1c17acb0 R15:
00007f6b5f6bcec0
[11676.104369] </TASK>
[11676.104374] ---[ end trace 0000000000000000 ]---
[11676.104382] BTRFS: error (device dm-2: state A) in
btrfs_run_delayed_refs:2249: errno=3D-117 Filesystem corrupted
[11676.104391] BTRFS info (device dm-2: state EA): forced readonly
[11676.107116] BTRFS info (device dm-2: state EA): balance: ended with
status: -30

-
Any ideas about what went wrong?

