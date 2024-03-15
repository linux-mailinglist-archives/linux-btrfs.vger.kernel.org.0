Return-Path: <linux-btrfs+bounces-3327-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D093987D497
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Mar 2024 20:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 001DC1C20F31
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Mar 2024 19:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B1E53803;
	Fri, 15 Mar 2024 19:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=devzero@web.de header.b="k2OPjkZM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AEE537E3
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Mar 2024 19:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710531985; cv=none; b=FLn/G5Bn75uqJEgnZ7+azrNs5Ms3UHSddbDeRqGcR+D4yohUg1DqI8qMRmAEUSytXVJrzPNHOA/9TZz/tvQA05BkkbCMW/NqLe0uIGm6H8yCp7ro8BO/WrkBYaMaDIxiABCrbzkv9bGOHR5Ed1j1twmG99PWjD7kfFVm2ywun24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710531985; c=relaxed/simple;
	bh=x4h3Jvok6x/jyf/1jeNZRxMpf7pN+lWk3OAW11kPYB8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=bUiSSLibr1Po+0PKj4zkoDxj8M7XhLnF9vWZw2AYjC/eW/q0FRFduFO1uMNZHlAWLQqL+pybMCHRf1efK2NEbLHDMkiyVfa77BMkHICdfMAVeEnLOVYItWX3xph4WwV6xYgPi2o1sV3q9Dbse019PI1SpZsmRhBd0L4tR28D1Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=devzero@web.de header.b=k2OPjkZM; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1710531980; x=1711136780; i=devzero@web.de;
	bh=x4h3Jvok6x/jyf/1jeNZRxMpf7pN+lWk3OAW11kPYB8=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:In-Reply-To;
	b=k2OPjkZMmNARQUQTnrv4s7SNkQkUf7Fmb/3CkWTQuQYvWpotRM9m2QnBhLuDJTer
	 bZqa1B7g8WmCUWWymPfThwimm5jDnex3s9iDRxsMwoQW5NKF+05Y2RA+Upi7jBF7C
	 baRnAOykHNYmcSPfq1fZPUBH3waDClnkkN0OtrWkFWKmJKejt9D+dKwYVemKTWqqu
	 vaGz954Lo3DFpFUXlswRGTO6iAhSwG3TAdl6vROsj0oz2xU0LjWM27NKMKC7iCpQU
	 4ZxVBiTMk2g4KLEwjCSKtMHeAEx0X1EKcHbCjBXRhuBOUGSmUj7CySAlec0yfX9ME
	 65NbEFOZvU6fXJHNpw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.179.103] ([213.196.208.136]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MHEXc-1rY06e26sK-00DDbY for
 <linux-btrfs@vger.kernel.org>; Fri, 15 Mar 2024 20:46:20 +0100
Message-ID: <617ae25d-6b8e-4ae0-8d07-685a59417035@web.de>
Date: Fri, 15 Mar 2024 20:46:20 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: compression silently skipped with O_DIRECT & checksum/corruption
 issue with qemu live migration ?
From: Roland <devzero@web.de>
To: linux-btrfs@vger.kernel.org
References: <e7ce9995-93cb-4904-875c-684d4494765f@web.de>
In-Reply-To: <e7ce9995-93cb-4904-875c-684d4494765f@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nY15WqkwKYDJNDZIOa4Sofwdv2M85XTXgr8xEmOJV9rYIf3Ns5F
 BPtlUchr2h2UXHsUcpc1tZ7PrjTu86j07pwgo/G87tI5Cbe2P3vICaGoWKwyi21t1t0pvXD
 BhnRew36WC5QS8xlIxUBeUA8LpF6bROErPzvrTsrTv0aL17GdgMlM3/ZbhKACYmzLQkPx86
 dj8Uuvazwrx46Dk88F/kQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:m50ev1gJ1L0=;au577WwYoc1/7/9x1hj+IkuP2tM
 Y2Wonv1GaQO0LJPyFkcsw7S2Ihd/A3zUIx7ovTlpdilQLGmKycd9N92WISwKOejGJyPA6Vhom
 FAcXq1yxV8u7OtEejiOpyj8NQzDkekUfqh6AxR8VvhECTdT2IVkACVewi5RO4KcOW5CqDNwMH
 vgDCMWkXZnm2lCQWyTPoPHcGrxWZ479Q6swgWqnNVzWdagrr0ykzuSsDym6sP5iES0pIA2ORz
 yug1gg0wCEkeOFKoYuB5swmzROi/C3J7Q74pnv/3qVUdvo1eVlP7lWxfXaHWN2sMJCjcJn72a
 vB2h7Quq4BBkdhbhWxMWbxPSEUfxH14upkEGSeg74N4KPGRrRhaySJ/jRU75+mhduENUCDLo4
 RE7blExj+Hf41EC3Ffk/7lm9+8h8X6JWf4njY25Duz97jOzTgu6XPtJQZ8zc8vNG3NpsB/hR4
 Dz/RhY4vtYBb+lapDTxlhqkrsMIUXSojACtsmSQInJ9S/HUS/HqkvZU8tGW4Tk8vek2H9zHub
 V6Y4aEMa97LuKotok4mClPM4Duk9ADd67sXtng8lohyXG/RVyOyDJZEXRG173zrnGpjlGSOaA
 2l/EazxrLa6B8YhVeUNNcKcEv2Zn14b/a4ISdHAoeLTs+AReZmOavtZI3T2IRUXImjDbfU9mf
 CMSWCVxucG04Pa0iVowg0ZUdyziseR22GRGD/ixhQiBXvZMizEcRan0xEUUmtziJfdqj2h/f2
 4FK9qgYEaTBab8mAHUCEA+aTppPfIcGtKDB+CJ0CiJYbEThtH8L6u/os8I2caG36KSZ3DeJZC
 DezPQppYBBx2eU1roLEibNR5D2wEfowxRte0OFPfWe3To=

 > happens on hdd and also on hdd, so this seems not to be disk related

sorry, i meant hdd + ssd , and it happens with compress + compress-force

# cat /etc/fstab |grep btrfs
UUID=3D2fb42259-2c95-4250-b49c-5f3067f2f991 /btrfs-ssd-zstd btrfs
compress=3Dzstd,defaults 0 1
UUID=3D2578a21c-0ba1-408a-b2cc-b54653a65b33 /btrfs-hdd-zstd btrfs
compress-force=3Dzstd,defaults 0 2

Am 15.03.24 um 20:39 schrieb Roland:
> Hello,
>
> can someone explain why compression is skipped when writing with
> direct-i/o ?
>
> is this to be expected ?
>
> i wondered why i got uncompressed raw disk images in proxmox after
> disk migration to btrfs fs with compress-force=3Dzstd, so i tried with
> dd if i can reproduce - and i can.
>
> the problem is, that i cannot seem to disable direct I/O for different
> proxmox gui actions, will discuss in proxmox community what can be
> done, but i need more infos on this behaviour.
>
> root@pve-test1:/btrfs-hdd-zstd/vms-raw/images/106/vm-106-disk-0# dd
> if=3Ddisk.raw of=3Dtest.dat bs=3D1024k
> 20480+0 Datens=C3=A4tze ein
> 20480+0 Datens=C3=A4tze aus
> 21474836480 Bytes (21 GB, 20 GiB) kopiert, 46,411 s, 463 MB/s
>
> root@pve-test1:/btrfs-hdd-zstd/vms-raw/images/106/vm-106-disk-0#
> compsize test.dat
> Processed 1 file, 161844 regular extents (161844 refs), 0 inline,
> 85412 fragments.
> Type=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Perc=C2=A0=C2=A0=C2=A0=C2=A0 Di=
sk Usage=C2=A0=C2=A0 Uncompressed Referenced
> TOTAL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 7%=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 1.5G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 20G=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 20G
> none=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 100%=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 339M=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 339M=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 339M
> zstd=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6%=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 1.2G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 19G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 19G
>
> root@pve-test1:/btrfs-hdd-zstd/vms-raw/images/106/vm-106-disk-0# dd
> if=3Ddisk.raw of=3Dtest.dat oflag=3Ddirect bs=3D1024k
> 20480+0 Datens=C3=A4tze ein
> 20480+0 Datens=C3=A4tze aus
> 21474836480 Bytes (21 GB, 20 GiB) kopiert, 161,319 s, 133 MB/s
>
> root@pve-test1:/btrfs-hdd-zstd/vms-raw/images/106/vm-106-disk-0#
> compsize test.dat
> Processed 1 file, 20480 regular extents (20480 refs), 0 inline, 1035
> fragments.
> Type=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Perc=C2=A0=C2=A0=C2=A0=C2=A0 Di=
sk Usage=C2=A0=C2=A0 Uncompressed Referenced
> TOTAL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 100%=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 20G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 20G=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 20G
> none=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 100%=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 20G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 20G=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 20G
>
> furthermore,=C2=A0 with qemu/proxmox virtual disk live migration, i'm
> getting reproducible checksum error with btrfs/compress-force=3Dzstd
> when live migrating virtual disk within same harddisk , whereas
> copying the same disk/file with dd (cached and direct) does not
> trigger that.
>
> happens on hdd and also on hdd, so this seems not to be disk related
>
> # uname -a
> Linux pve-test1 6.5.13-1-pve #1 SMP PREEMPT_DYNAMIC PMX 6.5.13-1
> (2024-02-05T13:50Z) x86_64 GNU/Linux
>
> regards
> Roland
>
>
> [Fr M=C3=A4r 15 20:07:23 2024] BTRFS warning (device sda1): csum failed
> root 260 ino 257 off 6655332352 csum 0x5517115a expected csum
> 0x6b2af31e mirror 1
> [Fr M=C3=A4r 15 20:07:23 2024] BTRFS error (device sda1): bdev /dev/sda1
> errs: wr 0, rd 0, flush 0, corrupt 1, gen 0
> [Fr M=C3=A4r 15 20:07:23 2024] BTRFS warning (device sda1): direct IO
> failed ino 257 op 0x0 offset 0x18cb05000 len 4096 err no 10
> [Fr M=C3=A4r 15 20:08:24 2024] BTRFS warning (device sda1): csum failed
> root 260 ino 257 off 6655332352 csum 0xd1d1c892 expected csum
> 0x0c24b5cd mirror 1
> [Fr M=C3=A4r 15 20:08:24 2024] BTRFS error (device sda1): bdev /dev/sda1
> errs: wr 0, rd 0, flush 0, corrupt 2, gen 0
> [Fr M=C3=A4r 15 20:08:24 2024] BTRFS warning (device sda1): direct IO
> failed ino 257 op 0x0 offset 0x18cb05000 len 4096 err no 10
> [Fr M=C3=A4r 15 20:09:25 2024] BTRFS warning (device sda1): csum failed
> root 260 ino 257 off 6655332352 csum 0x809096c2 expected csum
> 0x56b58dc6 mirror 1
> [Fr M=C3=A4r 15 20:09:25 2024] BTRFS error (device sda1): bdev /dev/sda1
> errs: wr 0, rd 0, flush 0, corrupt 3, gen 0
> [Fr M=C3=A4r 15 20:09:25 2024] BTRFS warning (device sda1): direct IO
> failed ino 257 op 0x0 offset 0x18cb05000 len 4096 err no 10
> [Fr M=C3=A4r 15 20:29:10 2024] BTRFS warning (device sda1): csum failed
> root 260 ino 257 off 6655332352 csum 0xc8a6977d expected csum
> 0xdfc1f678 mirror 1
> [Fr M=C3=A4r 15 20:29:10 2024] BTRFS error (device sda1): bdev /dev/sda1
> errs: wr 0, rd 0, flush 0, corrupt 4, gen 0
> [Fr M=C3=A4r 15 20:29:10 2024] BTRFS warning (device sda1): direct IO
> failed ino 257 op 0x0 offset 0x18cb05000 len 4096 err no 10
>
> [Fr M=C3=A4r 15 20:33:41 2024] BTRFS warning (device sdc1): csum failed
> root 260 ino 257 off 6655332352 csum 0x20ff0887 expected csum
> 0x08ed0bce mirror 1
> [Fr M=C3=A4r 15 20:33:41 2024] BTRFS error (device sdc1): bdev /dev/sdc1
> errs: wr 0, rd 0, flush 0, corrupt 1, gen 0
> [Fr M=C3=A4r 15 20:33:41 2024] BTRFS warning (device sdc1): direct IO
> failed ino 257 op 0x0 offset 0x18cb02000 len 16384 err no 10
> [Fr M=C3=A4r 15 20:35:18 2024] BTRFS warning (device sdc1): csum failed
> root 256 ino 290 off 6655332352 csum 0xb023863a expected csum
> 0x4f8e355d mirror 1
> [Fr M=C3=A4r 15 20:35:18 2024] BTRFS error (device sdc1): bdev /dev/sdc1
> errs: wr 0, rd 0, flush 0, corrupt 2, gen 0
> [Fr M=C3=A4r 15 20:35:18 2024] BTRFS warning (device sdc1): direct IO
> failed ino 290 op 0x0 offset 0x18cb05000 len 4096 err no 10
>
> create full clone of drive scsi0
> (btrfs-ssd-zstd-qcow2:106/vm-106-disk-0.raw)
> drive mirror is starting for drive-scsi0
> drive-scsi0: transferred 34.2 MiB of 20.0 GiB (0.17%) in 0s
> drive-scsi0: transferred 301.6 MiB of 20.0 GiB (1.47%) in 1s
> drive-scsi0: transferred 489.1 MiB of 20.0 GiB (2.39%) in 2s
> drive-scsi0: transferred 679.9 MiB of 20.0 GiB (3.32%) in 3s
> drive-scsi0: transferred 1.1 GiB of 20.0 GiB (5.70%) in 4s
> drive-scsi0: transferred 1.4 GiB of 20.0 GiB (6.89%) in 5s
> drive-scsi0: transferred 1.7 GiB of 20.0 GiB (8.55%) in 6s
> drive-scsi0: transferred 1.9 GiB of 20.0 GiB (9.53%) in 7s
> drive-scsi0: transferred 2.2 GiB of 20.0 GiB (10.97%) in 8s
> drive-scsi0: transferred 2.4 GiB of 20.0 GiB (11.84%) in 9s
> drive-scsi0: transferred 2.8 GiB of 20.0 GiB (13.89%) in 10s
> drive-scsi0: transferred 2.9 GiB of 20.0 GiB (14.74%) in 11s
> drive-scsi0: transferred 6.2 GiB of 20.0 GiB (31.14%) in 12s
> drive-scsi0: transferred 8.2 GiB of 20.0 GiB (41.17%) in 13s
> drive-scsi0: transferred 10.3 GiB of 20.0 GiB (51.27%) in 14s
> drive-scsi0: transferred 10.5 GiB of 20.0 GiB (52.75%) in 15s
> drive-scsi0: transferred 19.2 GiB of 20.0 GiB (95.86%) in 16s
> drive-scsi0: transferred 19.3 GiB of 20.0 GiB (96.66%) in 17s
> drive-scsi0: transferred 19.5 GiB of 20.0 GiB (97.46%) in 18s
> drive-scsi0: transferred 19.7 GiB of 20.0 GiB (98.27%) in 19s
> drive-scsi0: transferred 19.8 GiB of 20.0 GiB (99.08%) in 20s
> drive-scsi0: Cancelling block job
> drive-scsi0: Done.
> TASK ERROR: storage migration failed: block job (mirror) error:
> drive-scsi0: 'mirror' has been cancelled
>

