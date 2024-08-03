Return-Path: <linux-btrfs+bounces-6966-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B92FA946B16
	for <lists+linux-btrfs@lfdr.de>; Sat,  3 Aug 2024 21:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA8231C21052
	for <lists+linux-btrfs@lfdr.de>; Sat,  3 Aug 2024 19:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27D4219EB;
	Sat,  3 Aug 2024 19:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zetafleet.com header.i=@zetafleet.com header.b="iUpWkQpD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from zero.acitia.com (zero.acitia.com [69.164.212.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F251B94F
	for <linux-btrfs@vger.kernel.org>; Sat,  3 Aug 2024 19:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.164.212.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722714143; cv=none; b=gOHoqqe6HGU2mkdNl0XciOsRWMe84mWanwUvP/RrPHx5AO9dInhfz3d6AccGDlF3QUp06s5d18cqRwdHY1p1TQEL9yknqktjKKh/vqghcI9CKyKjDUXdhAc9eeSO5XhNLPfIaPUXVJSZ7/2b1rPh7QHh8b3bB3iHesbnuHAHWoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722714143; c=relaxed/simple;
	bh=rrPMac4qcn4g7dL+h3kak43VCXnY9/njQ1ar2VMEVbc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tSmj7X0SRoR4ujsUQcrfTkAkjWjHuH6NIbCr6TszRuXfnkas/M5UohhXpBhg14L0v22waKVKRIcORfUU0Ac+jBic8UwnUaDGFTlyBJM2wmWdBAKfmj2qwX0R3nbL2hCaYjZlLMWCwqXNo6SVS7CuKtVxHMHDU2yb34UXpQGrPco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zetafleet.com; spf=pass smtp.mailfrom=zetafleet.com; dkim=pass (2048-bit key) header.d=zetafleet.com header.i=@zetafleet.com header.b=iUpWkQpD; arc=none smtp.client-ip=69.164.212.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zetafleet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zetafleet.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=zetafleet.com; s=20190620; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8mQiFlDabHVpZT4m2MtC5ooWPf3UEm28MPergqxrqfA=; b=iUpWkQpDOwqFrz/zWJ50vIodUN
	2uZr8Pn6yn0Vv4d39R4ujBJXCBIR2TxLcBlqDz6hhESupm0rg80yaGz3e2sEW3VreK/erYIMrZITR
	Quk8Iuf8rMAUeU2lKuh8blYSFyvMAIjNZ6kQRcwmUBbwpVL1OR2hY8TwQT2qHjXkfw4oQA//Mgi0x
	cipNHknF7OGaZpyfDkU2AKtGYHNhio+rPe0E0Mi2p4PIwXoaTSXLwigy43xvle7NTuQqhPKIG9Xbu
	8Kdn/Y7K/cCcZEG6Fx4QY9PhfDtPkYDeiH/Wv5S+uDVKX994bD3agiaamqPgqjt7iy0wJEcwJzgHa
	5zwwceOA==;
Received: from authenticated by zero.acitia.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(envelope-from <linux-btrfs-ml@zetafleet.com>)
	id 1saKdo-0006OC-3h
	for linux-btrfs@vger.kernel.org; Sat, 03 Aug 2024 19:42:14 +0000
Message-ID: <ba51784b-ba20-4bf4-865a-2670a9ddde74@zetafleet.com>
Date: Sat, 3 Aug 2024 14:42:11 -0500
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Handling recovery from 2-device btrfs raid1 with bad generation
 on one device due to partial hardware failure
To: linux-btrfs@vger.kernel.org
References: <113200b0-7584-4ada-ba40-0637478ac390@zetafleet.com>
Content-Language: en-GB
From: Colin S <linux-btrfs-ml@zetafleet.com>
In-Reply-To: <113200b0-7584-4ada-ba40-0637478ac390@zetafleet.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.9
X-Spam-Report: No, score=-1.9 required=5.0 tests=BAYES_00=-1.9,NO_RELAYS=-0.001 autolearn=ham autolearn_force=no version=3.4.2

Hello again,

I have a follow-up report on this that I have now encountered evidence 
of filesystem metadata corruption that btrfs cannot auto-heal.

I have still not tried running any read-write scrub or btrfs check to 
try to heal the filesystem due to a lack of understanding of what may 
turn this from a recoverable situation to an unrecoverable situation. 
Instead, I encountered this failure when I tried to btrfs-send btrbk 
snapshots to a faster external disk in case I have to create a new 
filesystem and copy from backups. The fifth incremental snapshot 
transfer failed with this critical error:

 > BTRFS critical (device dm-0): corrupted leaf, root=1348 
block=364876496896 owner mismatch, have 7 expect [256, 
18446744073709551360]

This snapshot was taken two days *before* the hardware failure event, 
and was already successfully transferred to a different, slower, 
external backup device prior to the hardware failure.

The healthy device in the RAID1 continues to show zero errors on 
read-only scrub and I was also able to run rsync to pull all data from 
the root filesystem without any errors. (Since rsync will not 
deduplicate, I did not try to recover the damaged snapshots this way.)

I would greatly appreciate advice here on how to heal this filesystem, 
or at least, clarity on whether this is an expected failure mode for 
brtfs after a single device failure in RAID1. To me, what happened is a 
typical disk hardware failure, so to encounter an uncorrected filesystem 
corruption now in a RAID1 mode with a still healthy device in the 
filesystem seems like a grave bug somewhere in btrfs.

I forgot to mention also in the previous mail that I am running kernel 
6.9.10.

Apologies for the length of these mails and I hope to hear some thoughts 
when you have a moment.

Best regards,

On 02/08/2024 16:39, Colin S wrote:
> Hi there,
>
> I am experiencing a documentation issue regarding the correct way to 
> handle a partial hardware failure of a 2-device btrfs raid1 
> configuration. The failing device dropped itself from the bus until a 
> reboot. It reinitialised after reboot, but is now SMART failed with 
> multiple bad sectors and continues to degrade rapidly. In between the 
> time that it dropped from the bus and the system was rebooted, more 
> data was written to the healthy disk, so now there is a condition 
> where the failing device has “bad generation” in its metadata.
>
> This computer has only two slots for storage so I think I cannot add a 
> third device before removing the bad second device. Thus, I would like 
> to just eject the failing device from the array before I enter a total 
> error state where recovery becomes more difficult, but I don’t know 
> how to do this. The other device in the array is fully healthy, so 
> ideally, I would take these steps (while the filesystem is online, 
> since it is my root filesystem):
>
> 1. Remove the bad device from the btrfs raid1 filesystem, running 
> temporarily with no redundancy, using only the known good device (i.e. 
> as-if I only ever had this one device and was always running in single 
> disk mode on that one device with the normal dup metadata and single 
> data)
> 2. Once replacement hardware arrives, add the new device to the array 
> to restore redundancy
>
> I also have the following questions and concerns and I am unable to 
> find clear, concise, up-to-date answers about them (there are some 
> mentions on Stack Exchange, but they are very old, and seem to 
> reference bugs that may or may not still exist, and commands that no 
> longer exist; also, I am having a bad time with stress, so it is 
> possible I overlooked some thing obvious, so apologies in advance if 
> there is some obvious FAQ that I missed):
>
> 1. Will`btrfs scrub` make things better or worse, since there are also 
> metadata issues on the failing device due to how it dropped off the 
> bus without btrfs being fully aware of it (presumably because the 
> dm-crypt mapping device never disappeared)? The documentation for 
> `btrfs scrub` suggests it cannot deal with metadata issues.
> 2. Is `btrfs check --repair` required, or would it even be helpful 
> here? The documentation says not it needs to be running on an offline 
> filesystem, and also not to run it without talking to you guys first.
> 3. Is there a risk the remaining healthy device becomes corrupted if I 
> try to keep using this filesystem as the failing device continues to 
> get worse?
> 4. How to recover if the failing device drops permanently? Should I 
> add `-o degraded` to my fstab preemptively to plan for this 
> possibility, so I can continue to use the machine while I wait for a 
> hardware replacement?
> 5. How can `btrfs scrub` report uncorrectable errors when there is a 
> fully healthy device in the raid1 from which data can be taken to 
> restore consistency? What does this mean for the health of this 
> filesystem?
>
> Here is what my btrfs configuration looks like, device states, and 
> some kernel error logs. Please note that the dm-crypt mapping names 
> are currently reversed in the output because the NVMe bus enumeration 
> order is not consistent across reboots on this machine. (i.e. The 
> failing device is nvme0, but dm-crypt calls it nvm1n1p3_crypt.)
>
> $ cat /etc/fstab
>
> UUID=<root uuid> /               btrfs noatime,subvol=@rootfs 0       0
> # /boot was on /dev/nvme0n1p2 during installation
> UUID=<boot uuid> /boot           btrfs noatime,defaults        0       0
> # /boot/efi was on /dev/nvme0n1p1 during installation
> UUID=<nvme0 fatid>  /boot/efi       vfat    umask=0077 0       1
> UUID=<nvme1 fatid>  /boot/efi1      vfat    umask=0077 0       1
>
> $ cat /etc/crypttab
>
> nvme0n1p3_crypt UUID=<nvme1 partid> none 
> luks,discard,keyscript=decrypt_keyctl
> nvme1n1p3_crypt UUID=<nvme0 partid> none 
> luks,discard,keyscript=decrypt_keyctl
>
> $ brtfs filesystem show
>
> Label: none  uuid: <root uuid>
>         Total devices 2 FS bytes used 543.04GiB
>         devid    1 size 1.82TiB used 600.06GiB path 
> /dev/mapper/nvme0n1p3_crypt
>         devid    2 size 1.82TiB used 600.06GiB path 
> /dev/mapper/nvme1n1p3_crypt
>
> Label: none  uuid: <boot uuid>
>         Total devices 2 FS bytes used 311.05MiB
>         devid    1 size 1.00GiB used 784.62MiB path /dev/nvme1n1p2
>         devid    2 size 1.00GiB used 784.62MiB path /dev/nvme0n1p2
>
> $ btrfs device usage /boot
>
> /dev/nvme1n1p2, ID: 1
>    Device size:             1.00GiB
>    Device slack:              0.00B
>    Data,RAID1:            672.62MiB
>    Metadata,RAID1:         80.00MiB
>    System,RAID1:           32.00MiB
>    Unallocated:           239.38MiB
>
> /dev/nvme0n1p2, ID: 2
>    Device size:             1.00GiB
>    Device slack:              0.00B
>    Data,RAID1:            672.62MiB
>    Metadata,RAID1:         80.00MiB
>    System,RAID1:           32.00MiB
>    Unallocated:           239.38MiB
>
> $ brtfs device stats /boot
>
> [/dev/nvme1n1p2].write_io_errs    0
> [/dev/nvme1n1p2].read_io_errs     0
> [/dev/nvme1n1p2].flush_io_errs    0
> [/dev/nvme1n1p2].corruption_errs  0
> [/dev/nvme1n1p2].generation_errs  0
> [/dev/nvme0n1p2].write_io_errs    0
> [/dev/nvme0n1p2].read_io_errs     0
> [/dev/nvme0n1p2].flush_io_errs    0
> [/dev/nvme0n1p2].corruption_errs  0
> [/dev/nvme0n1p2].generation_errs  0
>
> $ btrfs scrub start -d -r -B /boot
> Starting scrub on devid 1
> Starting scrub on devid 2
>
> Scrub device /dev/nvme1n1p2 (id 1) done
> Scrub started:    Fri Aug  2 15:13:50 2024
> Status:           finished
> Duration:         0:00:00
> Total to scrub:   311.05MiB
> Rate:             311.05MiB/s
> Error summary:    no errors found
>
> Scrub device /dev/nvme0n1p2 (id 2) done
> Scrub started:    Fri Aug  2 15:13:50 2024
> Status:           finished
> Duration:         0:00:00
> Total to scrub:   311.05MiB
> Rate:             311.05MiB/s
> Error summary:    no errors found
>
> $ brtfs device usage /
>
> /dev/mapper/nvme0n1p3_crypt, ID: 1
>    Device size:             1.82TiB
>    Device slack:              0.00B
>    Data,RAID1:            591.00GiB
>    Metadata,RAID1:          9.00GiB
>    System,RAID1:           64.00MiB
>    Unallocated:             1.23TiB
>
> /dev/mapper/nvme1n1p3_crypt, ID: 2
>    Device size:             1.82TiB
>    Device slack:              0.00B
>    Data,RAID1:            591.00GiB
>    Metadata,RAID1:          9.00GiB
>    System,RAID1:           64.00MiB
>    Unallocated:             1.23TiB
>
> $ btrfs device stats /
>
> [/dev/mapper/nvme0n1p3_crypt].write_io_errs    0
> [/dev/mapper/nvme0n1p3_crypt].read_io_errs     0
> [/dev/mapper/nvme0n1p3_crypt].flush_io_errs    0
> [/dev/mapper/nvme0n1p3_crypt].corruption_errs  0
> [/dev/mapper/nvme0n1p3_crypt].generation_errs  0
> [/dev/mapper/nvme1n1p3_crypt].write_io_errs    1168898
> [/dev/mapper/nvme1n1p3_crypt].read_io_errs     19740
> [/dev/mapper/nvme1n1p3_crypt].flush_io_errs    10889
> [/dev/mapper/nvme1n1p3_crypt].corruption_errs  2255
> [/dev/mapper/nvme1n1p3_crypt].generation_errs  0
>
> btrfs scrub start -d -r -B /
> Starting scrub on devid 1
> Starting scrub on devid 2
>
> Scrub device /dev/mapper/nvme0n1p3_crypt (id 1) done
> Scrub started:    Fri Aug  2 12:05:01 2024
> Status:           finished
> Duration:         0:01:53
> Total to scrub:   542.93GiB
> Rate:             4.80GiB/s
> Error summary:    no errors found
>
> Scrub device /dev/mapper/nvme1n1p3_crypt (id 2) done
> Scrub started:    Fri Aug  2 12:05:01 2024
> Status:           finished
> Duration:         0:02:53
> Total to scrub:   542.93GiB
> Rate:             3.14GiB/s
> Error summary:    read=352 verify=7324 csum=736860
>   Corrected:      744520
>   Uncorrectable:  16
>   Unverified:     0
> ERROR: there are uncorrectable errors
>
> brtfs logs for the bad partition show bad generation errors in tree 
> blocks as well as data errors:
>
> […]
> kernel: BTRFS warning (device dm-0): tree block 364798279680 mirror 1 
> has bad generation, has 112055 want 112057
> kernel: BTRFS warning (device dm-0): tree block 364798509056 mirror 1 
> has bad generation, has 112055 want 112057
> kernel: BTRFS warning (device dm-0): tree block 364800294912 mirror 1 
> has bad generation, has 112056 want 112057
> kernel: BTRFS warning (device dm-0): tree block 364801097728 mirror 1 
> has bad generation, has 112056 want 112057
> kernel: BTRFS warning (device dm-0): tree block 364803555328 mirror 1 
> has bad generation, has 111409 want 112056
> kernel: BTRFS warning (device dm-0): tree block 364806144000 mirror 1 
> has bad generation, has 111409 want 112057
> kernel: BTRFS warning (device dm-0): tree block 364811190272 mirror 1 
> has bad generation, has 111410 want 112056
> kernel: scrub_stripe_report_errors: 1322 callbacks suppressed
> kernel: BTRFS error (device dm-0): fixed up error at logical 
> 375795023872 on dev /dev/mapper/nvme1n1p3_crypt physical 365028245504
> kernel: BTRFS error (device dm-0): fixed up error at logical 
> 375795023872 on dev /dev/mapper/nvme1n1p3_crypt physical 365028245504
> kernel: BTRFS error (device dm-0): fixed up error at logical 
> 375795023872 on dev /dev/mapper/nvme1n1p3_crypt physical 365028245504
> kernel: BTRFS error (device dm-0): fixed up error at logical 
> 375795023872 on dev /dev/mapper/nvme1n1p3_crypt physical 365028245504
> kernel: BTRFS error (device dm-0): fixed up error at logical 
> 375795023872 on dev /dev/mapper/nvme1n1p3_crypt physical 365028245504
> kernel: BTRFS error (device dm-0): fixed up error at logical 
> 375795023872 on dev /dev/mapper/nvme1n1p3_crypt physical 365028245504
> kernel: BTRFS error (device dm-0): fixed up error at logical 
> 375795023872 on dev /dev/mapper/nvme1n1p3_crypt physical 365028245504
> kernel: BTRFS error (device dm-0): fixed up error at logical 
> 375795023872 on dev /dev/mapper/nvme1n1p3_crypt physical 365028245504
> kernel: BTRFS error (device dm-0): fixed up error at logical 
> 375795023872 on dev /dev/mapper/nvme1n1p3_crypt physical 365028245504
> kernel: BTRFS error (device dm-0): fixed up error at logical 
> 375795023872 on dev /dev/mapper/nvme1n1p3_crypt physical 365028245504
> kernel: nvme0n1: I/O Cmd(0x2) @ LBA 100776464, 32 blocks, I/O Error 
> (sct 0x2 / sc 0x81) MORE DNR
> kernel: critical medium error, dev nvme0n1, sector 806211712 op 
> 0x0:(READ) flags 0x4000 phys_seg 3 prio class 3
> kernel: scrub_stripe_report_errors: 58352 callbacks suppressed
> […]
>
> Please let me know what I can do to handle this situation. Bonus 
> points if I can do it all without having to boot to a USB recovery. 
> Please let me know if more information is needed. Thank you for your 
> assistance and I hope that this feedback also helps to drive some 
> improvements to the documentation and/or options to recover from 
> situations like this which I would think are quite common (so common 
> that I am surprised that I am having such a difficult time here; 
> again, it could be a me-problem, and I apologise if so).
>
> Best regards, 


