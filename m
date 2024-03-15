Return-Path: <linux-btrfs+bounces-3326-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F79187D47E
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Mar 2024 20:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88808B21A43
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Mar 2024 19:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F28537F8;
	Fri, 15 Mar 2024 19:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=devzero@web.de header.b="XIdkiogw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A2B535AC
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Mar 2024 19:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710531596; cv=none; b=S0lSztVZmTU68VBZjwcaxxABvm4ZJxrcJaEHrq8kO5vR0JHVLWaKxFTnaqDDcoHSZV8DnhPBtTaCmNBhKc5Y6q5jZedkYsEHjzSuNvaaLb+ZYsZKnj52lrNwsLc//9UQm47q53a3uy0s05/BtqAZMLams2jC9xu3i6AsTOZ6G4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710531596; c=relaxed/simple;
	bh=jFXlBoPN5bx0N8FaCr59IrJQukFFrxf6J0ncYwZSopw=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=H76TP2gk/86cbOWqXoX0Si0bRZjSFTN2Qe/OuEYj+q4VvOuNy4Q8lwxJzxNQkT8w+uYffebYmQwcHLh/AtVme4opM18Szle+3c3cEWOVcMvTYg1AXoTMymttcY7NrciHQOO+OICMrGjiHJ7NQvJsojzdQTXqqohv4ccJ9Uf1wYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=devzero@web.de header.b=XIdkiogw; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1710531585; x=1711136385; i=devzero@web.de;
	bh=jFXlBoPN5bx0N8FaCr59IrJQukFFrxf6J0ncYwZSopw=;
	h=X-UI-Sender-Class:Date:To:From:Subject;
	b=XIdkiogwojyBpBee0ubK0FCXmgbUjFIivY09n0mJqBjlUQgfLKWyF9sRPOX6Xpdr
	 dma28MirCJ3HjPpS5BhEpw91JAvkTjZCGs4VUYUjir7txQFwrOvxsLsISYe88docc
	 fooZiRZdCqoc5KIK8yE2ocVL9mCndN6SHsGqFnFFNDMSN5THGR8u+5kuKMkmW3AbL
	 Q34QOxqp9SbjZPHz7msCigLy4iheLVUbn2BnPPYnaEHasD5Uy4VlHvfHcUyEt0BIp
	 TugVSubHMO7VP8S5Iuvlj1FUOvneYPKbxBxxOVylNzmRKPnWiuL1iLR7QVQ48e5i5
	 OudOmla00RjfAXuBRg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.179.103] ([213.196.208.136]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Ml4B6-1r49Qj2ojE-00lPce for
 <linux-btrfs@vger.kernel.org>; Fri, 15 Mar 2024 20:39:45 +0100
Message-ID: <e7ce9995-93cb-4904-875c-684d4494765f@web.de>
Date: Fri, 15 Mar 2024 20:39:45 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-btrfs@vger.kernel.org
From: Roland <devzero@web.de>
Subject: compression silently skipped with O_DIRECT & checksum/corruption
 issue with qemu live migration ?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:h09/ZhLDFiXXrVVmh/pNVa81PR6fxulgti1UOY7HJSl59g53lpW
 WijaU/+8re52JCR268CnYTSs7MAOT3KwmmBLaC63zO+Giv+Uh3MTQl/YyweZT3QBo/Vm4Fx
 +79wrRs4XF4H9iUjoQ7ZM67aRvDnaQO5HzeRnddSjTpEVQ2Kn28LTJzjPuzZBj3hfUEoftQ
 Nha9js/wtIgsH/13qCokg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Dn2u7NaabhE=;r0MCQGPF6wit0Jux9tjwczY8kta
 OSq0tAHjvya0qTCedvKCuzqjkOvZWLd0AIHcsopt6ZzjJsIGwoCiJMoYO5yXzhWOs8LqL1Rpx
 O2ldkE5LWFOxSpNfeRA8z4OfYMX8KtFNxtxmrIME1zE5FxxBx3FYeCp2d/TYK44DeOd+dZ3c5
 INV7O6Vf4KR3AQpUMZujPSLrsazIyNMHsyMCEvLeOSEXsnOADxA3QRsnyKNJTD4gmomVfHBiY
 pT7E/sC/rxmmZURjT5mudsU6tc4OVxDGGv5qpP+amXk42WW7A4TsgFheYSN1c+RwwaC52TGPk
 GNdHgzU6F4YWtZpGMinmtmBHDNSLujTGbcLL+eiagMWPP6SaElcaymQlaphm59gbdT1TbP3RN
 s4aqLI0Zgy11BDIOrFVv2gToYzGbhLVNKCDJm7M90w1sAiZuxYcVvneQYluhnnJsLKES/6T54
 fVGiMUP0iBavaBi3hk9AyKk7LEa6gBakmaV3xs/x3hYCw7hxTzYiUSk1AwzDWMawgcDgKIuMO
 TGORW+63HyPNJv+/E3ZWLB+3GA+fwmjG7BWqRRURe3FfLp42KJUFQzYZOfspN7939K1gqdgSB
 YQOY/uiV5FCT07Zvotvs3/g4i1rDGeGQ+RIF8OS5J+8Ldi4QSnOsZyFe3Vs3onZOtHovzMDBZ
 sCen6SXLG27m4K/uYglqc78MPlM4aT1iGnS2s/5NWXRIYta3fXrgTgABAwLYGX4NZNAckWeLj
 K4fe6T0cBtBCrjHFT4AdPQ1fWda5ONcyfffyTu/gvhev8Dkbu9c2/ADJ3ynrsBWE7rdAPgIuQ
 i+4hVmGgQUDV761OGsNmHZTyB1nz6FjrMXyEXGPwfjWvA=

Hello,

can someone explain why compression is skipped when writing with
direct-i/o ?

is this to be expected ?

i wondered why i got uncompressed raw disk images in proxmox after disk
migration to btrfs fs with compress-force=3Dzstd, so i tried with dd if i
can reproduce - and i can.

the problem is, that i cannot seem to disable direct I/O for different
proxmox gui actions, will discuss in proxmox community what can be done,
but i need more infos on this behaviour.

root@pve-test1:/btrfs-hdd-zstd/vms-raw/images/106/vm-106-disk-0# dd
if=3Ddisk.raw of=3Dtest.dat bs=3D1024k
20480+0 Datens=C3=A4tze ein
20480+0 Datens=C3=A4tze aus
21474836480 Bytes (21 GB, 20 GiB) kopiert, 46,411 s, 463 MB/s

root@pve-test1:/btrfs-hdd-zstd/vms-raw/images/106/vm-106-disk-0#
compsize test.dat
Processed 1 file, 161844 regular extents (161844 refs), 0 inline, 85412
fragments.
Type=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Perc=C2=A0=C2=A0=C2=A0=C2=A0 Disk=
 Usage=C2=A0=C2=A0 Uncompressed Referenced
TOTAL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 7%=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 1.5G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 20G=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 20G
none=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 100%=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 339M=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 339M=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 339M
zstd=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6%=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 1.2G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 19=
G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 19G

root@pve-test1:/btrfs-hdd-zstd/vms-raw/images/106/vm-106-disk-0# dd
if=3Ddisk.raw of=3Dtest.dat oflag=3Ddirect bs=3D1024k
20480+0 Datens=C3=A4tze ein
20480+0 Datens=C3=A4tze aus
21474836480 Bytes (21 GB, 20 GiB) kopiert, 161,319 s, 133 MB/s

root@pve-test1:/btrfs-hdd-zstd/vms-raw/images/106/vm-106-disk-0#
compsize test.dat
Processed 1 file, 20480 regular extents (20480 refs), 0 inline, 1035
fragments.
Type=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Perc=C2=A0=C2=A0=C2=A0=C2=A0 Disk=
 Usage=C2=A0=C2=A0 Uncompressed Referenced
TOTAL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 100%=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 20G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 20G=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 20G
none=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 100%=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 20G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 20G=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 20G

furthermore,=C2=A0 with qemu/proxmox virtual disk live migration, i'm gett=
ing
reproducible checksum error with btrfs/compress-force=3Dzstd when live
migrating virtual disk within same harddisk , whereas copying the same
disk/file with dd (cached and direct) does not trigger that.

happens on hdd and also on hdd, so this seems not to be disk related

# uname -a
Linux pve-test1 6.5.13-1-pve #1 SMP PREEMPT_DYNAMIC PMX 6.5.13-1
(2024-02-05T13:50Z) x86_64 GNU/Linux

regards
Roland


[Fr M=C3=A4r 15 20:07:23 2024] BTRFS warning (device sda1): csum failed ro=
ot
260 ino 257 off 6655332352 csum 0x5517115a expected csum 0x6b2af31e mirror=
 1
[Fr M=C3=A4r 15 20:07:23 2024] BTRFS error (device sda1): bdev /dev/sda1
errs: wr 0, rd 0, flush 0, corrupt 1, gen 0
[Fr M=C3=A4r 15 20:07:23 2024] BTRFS warning (device sda1): direct IO fail=
ed
ino 257 op 0x0 offset 0x18cb05000 len 4096 err no 10
[Fr M=C3=A4r 15 20:08:24 2024] BTRFS warning (device sda1): csum failed ro=
ot
260 ino 257 off 6655332352 csum 0xd1d1c892 expected csum 0x0c24b5cd mirror=
 1
[Fr M=C3=A4r 15 20:08:24 2024] BTRFS error (device sda1): bdev /dev/sda1
errs: wr 0, rd 0, flush 0, corrupt 2, gen 0
[Fr M=C3=A4r 15 20:08:24 2024] BTRFS warning (device sda1): direct IO fail=
ed
ino 257 op 0x0 offset 0x18cb05000 len 4096 err no 10
[Fr M=C3=A4r 15 20:09:25 2024] BTRFS warning (device sda1): csum failed ro=
ot
260 ino 257 off 6655332352 csum 0x809096c2 expected csum 0x56b58dc6 mirror=
 1
[Fr M=C3=A4r 15 20:09:25 2024] BTRFS error (device sda1): bdev /dev/sda1
errs: wr 0, rd 0, flush 0, corrupt 3, gen 0
[Fr M=C3=A4r 15 20:09:25 2024] BTRFS warning (device sda1): direct IO fail=
ed
ino 257 op 0x0 offset 0x18cb05000 len 4096 err no 10
[Fr M=C3=A4r 15 20:29:10 2024] BTRFS warning (device sda1): csum failed ro=
ot
260 ino 257 off 6655332352 csum 0xc8a6977d expected csum 0xdfc1f678 mirror=
 1
[Fr M=C3=A4r 15 20:29:10 2024] BTRFS error (device sda1): bdev /dev/sda1
errs: wr 0, rd 0, flush 0, corrupt 4, gen 0
[Fr M=C3=A4r 15 20:29:10 2024] BTRFS warning (device sda1): direct IO fail=
ed
ino 257 op 0x0 offset 0x18cb05000 len 4096 err no 10

[Fr M=C3=A4r 15 20:33:41 2024] BTRFS warning (device sdc1): csum failed ro=
ot
260 ino 257 off 6655332352 csum 0x20ff0887 expected csum 0x08ed0bce mirror=
 1
[Fr M=C3=A4r 15 20:33:41 2024] BTRFS error (device sdc1): bdev /dev/sdc1
errs: wr 0, rd 0, flush 0, corrupt 1, gen 0
[Fr M=C3=A4r 15 20:33:41 2024] BTRFS warning (device sdc1): direct IO fail=
ed
ino 257 op 0x0 offset 0x18cb02000 len 16384 err no 10
[Fr M=C3=A4r 15 20:35:18 2024] BTRFS warning (device sdc1): csum failed ro=
ot
256 ino 290 off 6655332352 csum 0xb023863a expected csum 0x4f8e355d mirror=
 1
[Fr M=C3=A4r 15 20:35:18 2024] BTRFS error (device sdc1): bdev /dev/sdc1
errs: wr 0, rd 0, flush 0, corrupt 2, gen 0
[Fr M=C3=A4r 15 20:35:18 2024] BTRFS warning (device sdc1): direct IO fail=
ed
ino 290 op 0x0 offset 0x18cb05000 len 4096 err no 10

create full clone of drive scsi0
(btrfs-ssd-zstd-qcow2:106/vm-106-disk-0.raw)
drive mirror is starting for drive-scsi0
drive-scsi0: transferred 34.2 MiB of 20.0 GiB (0.17%) in 0s
drive-scsi0: transferred 301.6 MiB of 20.0 GiB (1.47%) in 1s
drive-scsi0: transferred 489.1 MiB of 20.0 GiB (2.39%) in 2s
drive-scsi0: transferred 679.9 MiB of 20.0 GiB (3.32%) in 3s
drive-scsi0: transferred 1.1 GiB of 20.0 GiB (5.70%) in 4s
drive-scsi0: transferred 1.4 GiB of 20.0 GiB (6.89%) in 5s
drive-scsi0: transferred 1.7 GiB of 20.0 GiB (8.55%) in 6s
drive-scsi0: transferred 1.9 GiB of 20.0 GiB (9.53%) in 7s
drive-scsi0: transferred 2.2 GiB of 20.0 GiB (10.97%) in 8s
drive-scsi0: transferred 2.4 GiB of 20.0 GiB (11.84%) in 9s
drive-scsi0: transferred 2.8 GiB of 20.0 GiB (13.89%) in 10s
drive-scsi0: transferred 2.9 GiB of 20.0 GiB (14.74%) in 11s
drive-scsi0: transferred 6.2 GiB of 20.0 GiB (31.14%) in 12s
drive-scsi0: transferred 8.2 GiB of 20.0 GiB (41.17%) in 13s
drive-scsi0: transferred 10.3 GiB of 20.0 GiB (51.27%) in 14s
drive-scsi0: transferred 10.5 GiB of 20.0 GiB (52.75%) in 15s
drive-scsi0: transferred 19.2 GiB of 20.0 GiB (95.86%) in 16s
drive-scsi0: transferred 19.3 GiB of 20.0 GiB (96.66%) in 17s
drive-scsi0: transferred 19.5 GiB of 20.0 GiB (97.46%) in 18s
drive-scsi0: transferred 19.7 GiB of 20.0 GiB (98.27%) in 19s
drive-scsi0: transferred 19.8 GiB of 20.0 GiB (99.08%) in 20s
drive-scsi0: Cancelling block job
drive-scsi0: Done.
TASK ERROR: storage migration failed: block job (mirror) error:
drive-scsi0: 'mirror' has been cancelled


