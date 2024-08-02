Return-Path: <linux-btrfs+bounces-6964-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B804E94651F
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Aug 2024 23:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D8E32823C1
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Aug 2024 21:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B4E6E5FD;
	Fri,  2 Aug 2024 21:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zetafleet.com header.i=@zetafleet.com header.b="a3Gociqo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from zero.acitia.com (zero.acitia.com [69.164.212.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B615F1396
	for <linux-btrfs@vger.kernel.org>; Fri,  2 Aug 2024 21:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.164.212.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722634784; cv=none; b=BAlN33rXz6rnvgpIMSmBlaPdkwuSTilptSQtLi2mtmBCdlSnPARdq4BXMU75ZZJ8ynsEiajxEnprqLcm95rdX+3VEvZCHvK8SUgQHGM4hZvvLZtX1/LG5ZB0VoCC3X311DLbStzk1tKm4gnjyZ5aZAB27PVenriTcFnrQ8LNGV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722634784; c=relaxed/simple;
	bh=OYeXxZMShfKQCr14cvpKXN9fVgcChr17ZNpElmbxFqI=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=PCHxB145NXNao5D+nIaoc9uOTi/T88v84mx1SBEWS8V+tV4u4pI2XcMledOaPOToxiL7y2ieNiX95MwtQOEk54+YZijY8q3ZmreONL+EZ5iLsNderFfjrLpu2ITBqZWOmz6Pokip+KramQXYAvMq5496qO02XFVM6ZvYM3gbVjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zetafleet.com; spf=pass smtp.mailfrom=zetafleet.com; dkim=pass (2048-bit key) header.d=zetafleet.com header.i=@zetafleet.com header.b=a3Gociqo; arc=none smtp.client-ip=69.164.212.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zetafleet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zetafleet.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=zetafleet.com; s=20190620; h=Content-Transfer-Encoding:Content-Type:Subject
	:From:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wfuZN48Q1PIGXzdNqrzaKN2QGJma03x4HicAAapMUns=; b=a3Gociqo7fC0SMpn1ZCamLB7h/
	1CFInzwh4/KdJPgc6IDKZnMKjqpyZ5/w6JduMZmaqsvrgdBKZ0oSmi4OdoNScNMxJQ56Sml2zM8Gs
	jhC24iJMT1I6DHcSuylpphXIg3phPGdpb0pkmEw+IbQJIqA5dLSpg8LEhKFJC3AiZMnBKnqgxOVtc
	5A4KUx+2KIFvN2GouqAApgz7bnsStyN+lXzl/PCxPwumBhjIAM1WEQiHkyb3vkLHF+1nAAJMLBcqi
	/3qQ4zy178VHC0laNvOKonrrzBRyQaeoTMkPc9vwyd71sl5BYj5RYfBU7ivSrj7j8aGj/BHrHzS2c
	bREPhz8w==;
Received: from authenticated by zero.acitia.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(envelope-from <linux-btrfs-ml@zetafleet.com>)
	id 1sZzzx-0002Ur-6s
	for linux-btrfs@vger.kernel.org; Fri, 02 Aug 2024 21:39:41 +0000
Message-ID: <113200b0-7584-4ada-ba40-0637478ac390@zetafleet.com>
Date: Fri, 2 Aug 2024 16:39:40 -0500
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-btrfs@vger.kernel.org
Content-Language: en-GB
From: Colin S <linux-btrfs-ml@zetafleet.com>
Subject: Handling recovery from 2-device btrfs raid1 with bad generation on
 one device due to partial hardware failure
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -0.9
X-Spam-Report: No, score=-0.9 required=5.0 tests=BAYES_00=-1.9,HEXHASH_WORD=1,NO_RELAYS=-0.001 autolearn=no autolearn_force=no version=3.4.2

Hi there,

I am experiencing a documentation issue regarding the correct way to 
handle a partial hardware failure of a 2-device btrfs raid1 
configuration. The failing device dropped itself from the bus until a 
reboot. It reinitialised after reboot, but is now SMART failed with 
multiple bad sectors and continues to degrade rapidly. In between the 
time that it dropped from the bus and the system was rebooted, more data 
was written to the healthy disk, so now there is a condition where the 
failing device has “bad generation” in its metadata.

This computer has only two slots for storage so I think I cannot add a 
third device before removing the bad second device. Thus, I would like 
to just eject the failing device from the array before I enter a total 
error state where recovery becomes more difficult, but I don’t know how 
to do this. The other device in the array is fully healthy, so ideally, 
I would take these steps (while the filesystem is online, since it is my 
root filesystem):

1. Remove the bad device from the btrfs raid1 filesystem, running 
temporarily with no redundancy, using only the known good device (i.e. 
as-if I only ever had this one device and was always running in single 
disk mode on that one device with the normal dup metadata and single data)
2. Once replacement hardware arrives, add the new device to the array to 
restore redundancy

I also have the following questions and concerns and I am unable to find 
clear, concise, up-to-date answers about them (there are some mentions 
on Stack Exchange, but they are very old, and seem to reference bugs 
that may or may not still exist, and commands that no longer exist; 
also, I am having a bad time with stress, so it is possible I overlooked 
some thing obvious, so apologies in advance if there is some obvious FAQ 
that I missed):

1. Will`btrfs scrub` make things better or worse, since there are also 
metadata issues on the failing device due to how it dropped off the bus 
without btrfs being fully aware of it (presumably because the dm-crypt 
mapping device never disappeared)? The documentation for `btrfs scrub` 
suggests it cannot deal with metadata issues.
2. Is `btrfs check --repair` required, or would it even be helpful here? 
The documentation says not it needs to be running on an offline 
filesystem, and also not to run it without talking to you guys first.
3. Is there a risk the remaining healthy device becomes corrupted if I 
try to keep using this filesystem as the failing device continues to get 
worse?
4. How to recover if the failing device drops permanently? Should I add 
`-o degraded` to my fstab preemptively to plan for this possibility, so 
I can continue to use the machine while I wait for a hardware replacement?
5. How can `btrfs scrub` report uncorrectable errors when there is a 
fully healthy device in the raid1 from which data can be taken to 
restore consistency? What does this mean for the health of this filesystem?

Here is what my btrfs configuration looks like, device states, and some 
kernel error logs. Please note that the dm-crypt mapping names are 
currently reversed in the output because the NVMe bus enumeration order 
is not consistent across reboots on this machine. (i.e. The failing 
device is nvme0, but dm-crypt calls it nvm1n1p3_crypt.)

$ cat /etc/fstab

UUID=<root uuid> /               btrfs noatime,subvol=@rootfs 0       0
# /boot was on /dev/nvme0n1p2 during installation
UUID=<boot uuid> /boot           btrfs noatime,defaults        0       0
# /boot/efi was on /dev/nvme0n1p1 during installation
UUID=<nvme0 fatid>  /boot/efi       vfat    umask=0077 0       1
UUID=<nvme1 fatid>  /boot/efi1      vfat    umask=0077 0       1

$ cat /etc/crypttab

nvme0n1p3_crypt UUID=<nvme1 partid> none 
luks,discard,keyscript=decrypt_keyctl
nvme1n1p3_crypt UUID=<nvme0 partid> none 
luks,discard,keyscript=decrypt_keyctl

$ brtfs filesystem show

Label: none  uuid: <root uuid>
         Total devices 2 FS bytes used 543.04GiB
         devid    1 size 1.82TiB used 600.06GiB path 
/dev/mapper/nvme0n1p3_crypt
         devid    2 size 1.82TiB used 600.06GiB path 
/dev/mapper/nvme1n1p3_crypt

Label: none  uuid: <boot uuid>
         Total devices 2 FS bytes used 311.05MiB
         devid    1 size 1.00GiB used 784.62MiB path /dev/nvme1n1p2
         devid    2 size 1.00GiB used 784.62MiB path /dev/nvme0n1p2

$ btrfs device usage /boot

/dev/nvme1n1p2, ID: 1
    Device size:             1.00GiB
    Device slack:              0.00B
    Data,RAID1:            672.62MiB
    Metadata,RAID1:         80.00MiB
    System,RAID1:           32.00MiB
    Unallocated:           239.38MiB

/dev/nvme0n1p2, ID: 2
    Device size:             1.00GiB
    Device slack:              0.00B
    Data,RAID1:            672.62MiB
    Metadata,RAID1:         80.00MiB
    System,RAID1:           32.00MiB
    Unallocated:           239.38MiB

$ brtfs device stats /boot

[/dev/nvme1n1p2].write_io_errs    0
[/dev/nvme1n1p2].read_io_errs     0
[/dev/nvme1n1p2].flush_io_errs    0
[/dev/nvme1n1p2].corruption_errs  0
[/dev/nvme1n1p2].generation_errs  0
[/dev/nvme0n1p2].write_io_errs    0
[/dev/nvme0n1p2].read_io_errs     0
[/dev/nvme0n1p2].flush_io_errs    0
[/dev/nvme0n1p2].corruption_errs  0
[/dev/nvme0n1p2].generation_errs  0

$ btrfs scrub start -d -r -B /boot
Starting scrub on devid 1
Starting scrub on devid 2

Scrub device /dev/nvme1n1p2 (id 1) done
Scrub started:    Fri Aug  2 15:13:50 2024
Status:           finished
Duration:         0:00:00
Total to scrub:   311.05MiB
Rate:             311.05MiB/s
Error summary:    no errors found

Scrub device /dev/nvme0n1p2 (id 2) done
Scrub started:    Fri Aug  2 15:13:50 2024
Status:           finished
Duration:         0:00:00
Total to scrub:   311.05MiB
Rate:             311.05MiB/s
Error summary:    no errors found

$ brtfs device usage /

/dev/mapper/nvme0n1p3_crypt, ID: 1
    Device size:             1.82TiB
    Device slack:              0.00B
    Data,RAID1:            591.00GiB
    Metadata,RAID1:          9.00GiB
    System,RAID1:           64.00MiB
    Unallocated:             1.23TiB

/dev/mapper/nvme1n1p3_crypt, ID: 2
    Device size:             1.82TiB
    Device slack:              0.00B
    Data,RAID1:            591.00GiB
    Metadata,RAID1:          9.00GiB
    System,RAID1:           64.00MiB
    Unallocated:             1.23TiB

$ btrfs device stats /

[/dev/mapper/nvme0n1p3_crypt].write_io_errs    0
[/dev/mapper/nvme0n1p3_crypt].read_io_errs     0
[/dev/mapper/nvme0n1p3_crypt].flush_io_errs    0
[/dev/mapper/nvme0n1p3_crypt].corruption_errs  0
[/dev/mapper/nvme0n1p3_crypt].generation_errs  0
[/dev/mapper/nvme1n1p3_crypt].write_io_errs    1168898
[/dev/mapper/nvme1n1p3_crypt].read_io_errs     19740
[/dev/mapper/nvme1n1p3_crypt].flush_io_errs    10889
[/dev/mapper/nvme1n1p3_crypt].corruption_errs  2255
[/dev/mapper/nvme1n1p3_crypt].generation_errs  0

btrfs scrub start -d -r -B /
Starting scrub on devid 1
Starting scrub on devid 2

Scrub device /dev/mapper/nvme0n1p3_crypt (id 1) done
Scrub started:    Fri Aug  2 12:05:01 2024
Status:           finished
Duration:         0:01:53
Total to scrub:   542.93GiB
Rate:             4.80GiB/s
Error summary:    no errors found

Scrub device /dev/mapper/nvme1n1p3_crypt (id 2) done
Scrub started:    Fri Aug  2 12:05:01 2024
Status:           finished
Duration:         0:02:53
Total to scrub:   542.93GiB
Rate:             3.14GiB/s
Error summary:    read=352 verify=7324 csum=736860
   Corrected:      744520
   Uncorrectable:  16
   Unverified:     0
ERROR: there are uncorrectable errors

brtfs logs for the bad partition show bad generation errors in tree 
blocks as well as data errors:

[…]
kernel: BTRFS warning (device dm-0): tree block 364798279680 mirror 1 
has bad generation, has 112055 want 112057
kernel: BTRFS warning (device dm-0): tree block 364798509056 mirror 1 
has bad generation, has 112055 want 112057
kernel: BTRFS warning (device dm-0): tree block 364800294912 mirror 1 
has bad generation, has 112056 want 112057
kernel: BTRFS warning (device dm-0): tree block 364801097728 mirror 1 
has bad generation, has 112056 want 112057
kernel: BTRFS warning (device dm-0): tree block 364803555328 mirror 1 
has bad generation, has 111409 want 112056
kernel: BTRFS warning (device dm-0): tree block 364806144000 mirror 1 
has bad generation, has 111409 want 112057
kernel: BTRFS warning (device dm-0): tree block 364811190272 mirror 1 
has bad generation, has 111410 want 112056
kernel: scrub_stripe_report_errors: 1322 callbacks suppressed
kernel: BTRFS error (device dm-0): fixed up error at logical 
375795023872 on dev /dev/mapper/nvme1n1p3_crypt physical 365028245504
kernel: BTRFS error (device dm-0): fixed up error at logical 
375795023872 on dev /dev/mapper/nvme1n1p3_crypt physical 365028245504
kernel: BTRFS error (device dm-0): fixed up error at logical 
375795023872 on dev /dev/mapper/nvme1n1p3_crypt physical 365028245504
kernel: BTRFS error (device dm-0): fixed up error at logical 
375795023872 on dev /dev/mapper/nvme1n1p3_crypt physical 365028245504
kernel: BTRFS error (device dm-0): fixed up error at logical 
375795023872 on dev /dev/mapper/nvme1n1p3_crypt physical 365028245504
kernel: BTRFS error (device dm-0): fixed up error at logical 
375795023872 on dev /dev/mapper/nvme1n1p3_crypt physical 365028245504
kernel: BTRFS error (device dm-0): fixed up error at logical 
375795023872 on dev /dev/mapper/nvme1n1p3_crypt physical 365028245504
kernel: BTRFS error (device dm-0): fixed up error at logical 
375795023872 on dev /dev/mapper/nvme1n1p3_crypt physical 365028245504
kernel: BTRFS error (device dm-0): fixed up error at logical 
375795023872 on dev /dev/mapper/nvme1n1p3_crypt physical 365028245504
kernel: BTRFS error (device dm-0): fixed up error at logical 
375795023872 on dev /dev/mapper/nvme1n1p3_crypt physical 365028245504
kernel: nvme0n1: I/O Cmd(0x2) @ LBA 100776464, 32 blocks, I/O Error (sct 
0x2 / sc 0x81) MORE DNR
kernel: critical medium error, dev nvme0n1, sector 806211712 op 
0x0:(READ) flags 0x4000 phys_seg 3 prio class 3
kernel: scrub_stripe_report_errors: 58352 callbacks suppressed
[…]

Please let me know what I can do to handle this situation. Bonus points 
if I can do it all without having to boot to a USB recovery. Please let 
me know if more information is needed. Thank you for your assistance and 
I hope that this feedback also helps to drive some improvements to the 
documentation and/or options to recover from situations like this which 
I would think are quite common (so common that I am surprised that I am 
having such a difficult time here; again, it could be a me-problem, and 
I apologise if so).

Best regards,

