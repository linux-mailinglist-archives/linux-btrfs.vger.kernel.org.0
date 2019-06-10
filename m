Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E202A3C04F
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jun 2019 02:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390756AbfFKADh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Jun 2019 20:03:37 -0400
Received: from dog.birch.relay.mailchannels.net ([23.83.209.48]:61857 "EHLO
        dog.birch.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390738AbfFKADh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Jun 2019 20:03:37 -0400
X-Greylist: delayed 419 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 Jun 2019 20:03:32 EDT
X-Sender-Id: dreamhost|x-authsender|eric@ericmesa.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 3E35F6A2BA7
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Jun 2019 23:56:32 +0000 (UTC)
Received: from pdx1-sub0-mail-a21.g.dreamhost.com (100-96-88-48.trex.outbound.svc.cluster.local [100.96.88.48])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 9A65B6A2A1F
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Jun 2019 23:56:31 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|eric@ericmesa.com
Received: from pdx1-sub0-mail-a21.g.dreamhost.com ([TEMPUNAVAIL].
 [64.90.62.162])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:2500 (trex/5.17.2);
        Mon, 10 Jun 2019 23:56:32 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|eric@ericmesa.com
X-MailChannels-Auth-Id: dreamhost
X-Spill-Soft: 1b2b36dc5ef09552_1560210992119_1536760022
X-MC-Loop-Signature: 1560210992118:2282565992
X-MC-Ingress-Time: 1560210992118
Received: from pdx1-sub0-mail-a21.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a21.g.dreamhost.com (Postfix) with ESMTP id 4CAB2804CE
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Jun 2019 16:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=ericmesa.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=
        ericmesa.com; bh=3xq+MBXzgcAGZjK8bzf9+PA1KVo=; b=cpVZtlboo3pAFz7
        2dzwJVXa+GMPyZsnglrGSZ9gttmZppzMg3hUAElnBBThTABnt2ZuO5OhmgEf97jZ
        CnMCXxZeIlo4KqtmrwHWKOzGiC6kjvkUBMRGCQa7CNAx3haU9wVLV7/mlWiE0lQm
        hneYYU0e3t2prK29SK7wAp+A9pzY=
Received: from supermario.mushroomkingdom (pool-68-134-39-132.bltmmd.fios.verizon.net [68.134.39.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: eric@ericmesa.com)
        by pdx1-sub0-mail-a21.g.dreamhost.com (Postfix) with ESMTPSA id 9CD3E804C3
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Jun 2019 16:56:25 -0700 (PDT)
X-DH-BACKEND: pdx1-sub0-mail-a21
From:   Eric Mesa <eric@ericmesa.com>
To:     linux-btrfs@vger.kernel.org
Subject: Issues with btrfs send/receive with parents
Date:   Mon, 10 Jun 2019 19:56:19 -0400
Message-ID: <3884539.zL6soEQT1V@supermario.mushroomkingdom>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2342564.lkeB5KmT8W"; micalg="pgp-sha256"; protocol="application/pgp-signature"
X-VR-OUT-STATUS: OK
X-VR-OUT-SCORE: 0
X-VR-OUT-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudehfedgvdelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuggftfghnshhusghstghrihgsvgdpffftgfetoffjqffuvfenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkgggtsehgtderredttddvnecuhfhrohhmpefgrhhitgcuofgvshgruceovghrihgtsegvrhhitghmvghsrgdrtghomheqnecuffhomhgrihhnpehrvgguughithdrtghomhenucfkphepieekrddufeegrdefledrudefvdenucfrrghrrghmpehmohguvgepshhmthhppdhhvghlohepshhuphgvrhhmrghrihhordhmuhhshhhrohhomhhkihhnghguohhmpdhinhgvthepieekrddufeegrdefledrudefvddprhgvthhurhhnqdhprghthhepgfhrihgtucfovghsrgcuoegvrhhitgesvghrihgtmhgvshgrrdgtohhmqedpmhgrihhlfhhrohhmpegvrhhitgesvghrihgtmhgvshgrrdgtohhmpdhnrhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--nextPart2342564.lkeB5KmT8W
Content-Type: multipart/mixed; boundary="nextPart2188587.dLfUqzFI6W"
Content-Transfer-Encoding: 7Bit

This is a multi-part message in MIME format.

--nextPart2188587.dLfUqzFI6W
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

First of all, as per instruction on the wiki for the mailing list, you can 
find everything asked for from the "What information to provide when asking a 
support question" section is at the end of my email. Look for a series of ## 
to know when this info is located.

So, the setup is that I've got a system with 3 drives containing btrfs on them 
- SSDHome, NotHome, and Photos. Recently, I finally have a server in the 
basement with two btrfs drives - backups1 and backups2. It will, naturally, be 
used for backups. The whole reason I'm using btrfs is for this awesome ability 
that comes from snapshots and it not taking up too much space because of COW. 

When I did the btrfs send / receive for SSDHome it took 2.5 days to send 
~500GiB over a 1GBps cable to the 3GBps drive in the server. It also had the 
error: 
ERROR: failed to clone extents to ermesa/.cache/krunner/
bookmarkrunnerfirefoxfavdbfile.sqlite: Invalid argument

and took like 99% CPU according to top for the btrfs process. The subvols in 
NotHome, by contrast, took MUCH LESS time for the same amount of data. 

So I did a bunch of internet research and I found a thread on the mailing list 
that relinks can cause send to take a lot longer. And I didn't have autodefrag 
on SSDHome mount options in fstab, but had it in the other drives that dont' 
have a problem. So I ran btrfs fi defrag -v -r /home/ and it listed 5 
failures. But after that, I did send/receive again with SSDHome and it was SO 
MUCH BETTER! btrfs never (or almost never) took more than 2.5% of CPU for 
btrfs while it was running and it took just 18 hours to send the data over the 
same cables and to the same drive. 

So I thought I'd solved the problem. (Although at the cost of my snapshots 
taking up more space on the SSD) I was able to do a send/receive with the -p 
option so that the next time it went faster. Life was good. 

But then....

Here's a situation I am pretty consistently running into (but only with 
SSDHome - it works fine with the other drives so far....)

Let's say that snapshot A is a snapshot sent to the server without -p. It 
sends the entire 500GB for 18 hours. 

Then I do snapshot B. I send it with -p - takes 15 minutes or so depending on 
how much data I've added. 

Then I do snapshot C - and here I always get an error. 

And it always is something like:

ERROR: link ermesa/.mozilla/firefox/n35gu0fb.default/bookmarkbackups/
bookmarks-2019-06-09_679_I1bs5PtgsPwtyXvcvcRdSg==.jsonlz4 -> ermesa/.mozilla/
firefox/n35gu0fb.default/bookmarkbackups/
bookmarks-2019-06-08_679_I1bs5PtgsPwtyXvcvcRdSg==.jsonlz4 failed: No such file 
or directory

It always involves either .cache or .mozilla - the types of files that are 
constantly changing. 

It doesn't matter if I do a defrag before snapshot C followed by the sync 
command. It seems that for SSDHome I can only do one full snap send and then 
one parent send. 

Again, so far it seems to be working fine with the other drives which seems to 
suggest to me that it's maybe not the version of my kernel or btrfs progs or 
anything else. 

I've got the info below, but when I ran a scrub and a btrfs check everything 
came back fine. 

So any help you can give me here would be awesome because I'd prefer not to 
have to either always start from snapshot A (as time increases from A, each 
snap is going to take longer to send) and it's weird that it's only happening 
with that drive. 

#########################################################


uname -a : Linux supermario.mushroomkingdom 5.0.9-200.fc29.x86_64 #1 SMP Mon 
Apr 22 00:55:30 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux

btrfs --version: btrfs-progs v4.20.2 


btrfs fi show:
Label: 'SSDHome'  uuid: 1080b060-4f1d-4b72-8544-ada43ec3cb54
        Total devices 1 FS bytes used 604.32GiB
        devid    1 size 931.51GiB used 805.05GiB path /dev/sdb1

Label: 'NotHome'  uuid: 09344d53-db1e-43d0-8e43-c41a5884e172
        Total devices 1 FS bytes used 2.57TiB
        devid    1 size 3.64TiB used 2.59TiB path /dev/sdc1

Label: 'Photos'  uuid: 27cc1330-c4e3-404f-98f6-f23becec76b5
        Total devices 2 FS bytes used 2.88TiB
        devid    1 size 5.46TiB used 2.88TiB path /dev/sdd
        devid    2 size 3.64TiB used 2.88TiB path /dev/sda1


btrfs fi df /home:
Data, single: total=788.01GiB, used=601.54GiB
System, single: total=36.00MiB, used=112.00KiB
Metadata, single: total=17.01GiB, used=2.78GiB
GlobalReserve, single: total=512.00MiB, used=0.00B

And dmesg.log is attached


Plus some additional information: 

btrfs scrub status /home/
scrub status for 1080b060-4f1d-4b72-8544-ada43ec3cb54
        scrub started at Wed Jun  5 18:51:01 2019 and finished after 00:30:30
        total bytes scrubbed: 586.34GiB with 0 errors



btrfs check --force (because even in single user mode, I couldn't unmount /
home - even though it's on its own drive):

Checking filesystem on /dev/sdb1
UUID: 1080b060-4f1d-4b72-8544-ada43ec3cb54
found 648822566912 bytes used, no error found
total csum bytes: 630493176
total tree bytes: 2977923072
total fs tree bytes: 2119663616
total extent tree bytes: 132972544
btree space waste bytes: 509661764
file data blocks allocated: 1882978136064
 referenced 1827744911360

And you can see some of the info from me trying to figure this out on the 
following reddit posts: https://www.reddit.com/r/btrfs/comments/byq7gr/
list_of_folders_to_exclude_from_btrfs_if_home_is/ and https://www.reddit.com/
r/btrfs/comments/bwh2wa/extremely_slow_sendreceive_and_errors_upon/




--
Eric Mesa
--nextPart2188587.dLfUqzFI6W
Content-Disposition: attachment; filename="dmesg.log"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-log; charset="UTF-8"; name="dmesg.log"

[    0.000000] Linux version 5.0.9-200.fc29.x86_64 (mockbuild@bkernel03.phx2.fedoraproject.org) (gcc version 8.3.1 20190223 (Red Hat 8.3.1-2) (GCC)) #1 SMP Mon Apr 22 00:55:30 UTC 2019
[    0.000000] Command line: BOOT_IMAGE=//vmlinuz-5.0.9-200.fc29.x86_64 root=/dev/mapper/fedora-root ro rd.lvm.lv=fedora/root rd.lvm.lv=fedora/swap rhgb quiet LANG=en_US.UTF-8 rd.driver.blacklist=nouveau single
[    0.000000] random: get_random_u32 called from bsp_init_amd+0x20b/0x2b0 with crng_init=0
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'standard' format.
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009ffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000be863fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000be864000-0x00000000bea3bfff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000bea3c000-0x00000000bea45fff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000bea46000-0x00000000bee34fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000bee35000-0x00000000bf159fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000bf15a000-0x00000000bf15afff] usable
[    0.000000] BIOS-e820: [mem 0x00000000bf15b000-0x00000000bf360fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000bf361000-0x00000000bf7fffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000f8000000-0x00000000fbffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec10000-0x00000000fec10fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec20000-0x00000000fec20fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed61000-0x00000000fed70fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed80000-0x00000000fed8ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fef00000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100001000-0x000000063effffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] e820: update [mem 0xb0494018-0xb04b4657] usable ==> usable
[    0.000000] e820: update [mem 0xb0494018-0xb04b4657] usable ==> usable
[    0.000000] e820: update [mem 0xb0483018-0xb0493057] usable ==> usable
[    0.000000] e820: update [mem 0xb0483018-0xb0493057] usable ==> usable
[    0.000000] extended physical RAM map:
[    0.000000] reserve setup_data: [mem 0x0000000000000000-0x000000000009ffff] usable
[    0.000000] reserve setup_data: [mem 0x0000000000100000-0x00000000b0483017] usable
[    0.000000] reserve setup_data: [mem 0x00000000b0483018-0x00000000b0493057] usable
[    0.000000] reserve setup_data: [mem 0x00000000b0493058-0x00000000b0494017] usable
[    0.000000] reserve setup_data: [mem 0x00000000b0494018-0x00000000b04b4657] usable
[    0.000000] reserve setup_data: [mem 0x00000000b04b4658-0x00000000be863fff] usable
[    0.000000] reserve setup_data: [mem 0x00000000be864000-0x00000000bea3bfff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000bea3c000-0x00000000bea45fff] ACPI data
[    0.000000] reserve setup_data: [mem 0x00000000bea46000-0x00000000bee34fff] ACPI NVS
[    0.000000] reserve setup_data: [mem 0x00000000bee35000-0x00000000bf159fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000bf15a000-0x00000000bf15afff] usable
[    0.000000] reserve setup_data: [mem 0x00000000bf15b000-0x00000000bf360fff] ACPI NVS
[    0.000000] reserve setup_data: [mem 0x00000000bf361000-0x00000000bf7fffff] usable
[    0.000000] reserve setup_data: [mem 0x00000000f8000000-0x00000000fbffffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fec10000-0x00000000fec10fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fec20000-0x00000000fec20fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fed00000-0x00000000fed00fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fed61000-0x00000000fed70fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fed80000-0x00000000fed8ffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fef00000-0x00000000ffffffff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000100001000-0x000000063effffff] usable
[    0.000000] efi: EFI v2.31 by American Megatrends
[    0.000000] efi:  ACPI=0xbea3e000  ACPI 2.0=0xbea3e000  SMBIOS=0xf04c0  MPS=0xfd4b0 
[    0.000000] secureboot: Secure boot disabled
[    0.000000] SMBIOS 2.7 present.
[    0.000000] DMI: Gigabyte Technology Co., Ltd. To be filled by O.E.M./970A-UD3P, BIOS F1 08/06/2013
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 3515.947 MHz processor
[    0.003115] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.003116] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.003122] last_pfn = 0x63f000 max_arch_pfn = 0x400000000
[    0.003126] MTRR default type: uncachable
[    0.003127] MTRR fixed ranges enabled:
[    0.003128]   00000-9FFFF write-back
[    0.003129]   A0000-BFFFF write-through
[    0.003129]   C0000-CFFFF write-protect
[    0.003130]   D0000-DFFFF uncachable
[    0.003131]   E0000-FFFFF write-protect
[    0.003131] MTRR variable ranges enabled:
[    0.003132]   0 base 000000000000 mask FFFF80000000 write-back
[    0.003134]   1 base 000080000000 mask FFFFC0000000 write-back
[    0.003135]   2 base 0000BF800000 mask FFFFFF800000 uncachable
[    0.003135]   3 disabled
[    0.003136]   4 disabled
[    0.003136]   5 disabled
[    0.003137]   6 disabled
[    0.003137]   7 disabled
[    0.003138] TOM2: 000000063f000000 aka 25584M
[    0.004148] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.004207] e820: update [mem 0xbf800000-0xffffffff] usable ==> reserved
[    0.004212] last_pfn = 0xbf800 max_arch_pfn = 0x400000000
[    0.008387] found SMP MP-table at [mem 0x000fd810-0x000fd81f]
[    0.008410] Base memory trampoline at [(____ptrval____)] 98000 size 24576
[    0.008413] Using GB pages for direct mapping
[    0.008415] BRK [0x51e001000, 0x51e001fff] PGTABLE
[    0.008417] BRK [0x51e002000, 0x51e002fff] PGTABLE
[    0.008418] BRK [0x51e003000, 0x51e003fff] PGTABLE
[    0.008490] BRK [0x51e004000, 0x51e004fff] PGTABLE
[    0.008492] BRK [0x51e005000, 0x51e005fff] PGTABLE
[    0.008880] BRK [0x51e006000, 0x51e006fff] PGTABLE
[    0.008947] BRK [0x51e007000, 0x51e007fff] PGTABLE
[    0.009057] BRK [0x51e008000, 0x51e008fff] PGTABLE
[    0.009137] BRK [0x51e009000, 0x51e009fff] PGTABLE
[    0.009476] RAMDISK: [mem 0x5c8bf000-0x5dfd3fff]
[    0.009504] ACPI: Early table checksum verification disabled
[    0.009507] ACPI: RSDP 0x00000000BEA3E000 000024 (v02 ALASKA)
[    0.009509] ACPI: XSDT 0x00000000BEA3E070 00005C (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.009514] ACPI: FACP 0x00000000BEA43BA0 0000F4 (v04 ALASKA A M I    01072009 AMI  00010013)
[    0.009517] ACPI BIOS Warning (bug): Optional FADT field Pm2ControlBlock has valid Length but zero Address: 0x0000000000000000/0x1 (20181213/tbfadt-624)
[    0.009521] ACPI: DSDT 0x00000000BEA3E158 005A42 (v02 ALASKA A M I    00000000 INTL 20051117)
[    0.009523] ACPI: FACS 0x00000000BEE2FF80 000040
[    0.009525] ACPI: APIC 0x00000000BEA43C98 00009E (v03 ALASKA A M I    01072009 AMI  00010013)
[    0.009528] ACPI: FPDT 0x00000000BEA43D38 000044 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.009530] ACPI: MCFG 0x00000000BEA43D80 00003C (v01 ALASKA A M I    01072009 MSFT 00010013)
[    0.009532] ACPI: HPET 0x00000000BEA43DC0 000038 (v01 ALASKA A M I    01072009 AMI  00000005)
[    0.009534] ACPI: BGRT 0x00000000BEA43DF8 000038 (v00 ALASKA A M I    01072009 AMI  00010013)
[    0.009536] ACPI: SSDT 0x00000000BEA43E30 001714 (v01 AMD    POWERNOW 00000001 AMD  00000001)
[    0.009544] ACPI: Local APIC address 0xfee00000
[    0.009865] No NUMA configuration found
[    0.009866] Faking a node at [mem 0x0000000000000000-0x000000063effffff]
[    0.009877] NODE_DATA(0) allocated [mem 0x63efd3000-0x63effdfff]
[    0.085453] Zone ranges:
[    0.085455]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.085456]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.085457]   Normal   [mem 0x0000000100000000-0x000000063effffff]
[    0.085458]   Device   empty
[    0.085459] Movable zone start for each node
[    0.085462] Early memory node ranges
[    0.085463]   node   0: [mem 0x0000000000001000-0x000000000009ffff]
[    0.085463]   node   0: [mem 0x0000000000100000-0x00000000be863fff]
[    0.085464]   node   0: [mem 0x00000000bf15a000-0x00000000bf15afff]
[    0.085464]   node   0: [mem 0x00000000bf361000-0x00000000bf7fffff]
[    0.085465]   node   0: [mem 0x0000000100001000-0x000000063effffff]
[    0.085544] Zeroed struct page in unavailable ranges: 4958 pages
[    0.085545] Initmem setup node 0 [mem 0x0000000000001000-0x000000063effffff]
[    0.085547] On node 0 totalpages: 6282402
[    0.085548]   DMA zone: 64 pages used for memmap
[    0.085548]   DMA zone: 24 pages reserved
[    0.085549]   DMA zone: 3999 pages, LIFO batch:0
[    0.085642]   DMA32 zone: 12149 pages used for memmap
[    0.085643]   DMA32 zone: 777476 pages, LIFO batch:63
[    0.104390]   Normal zone: 85952 pages used for memmap
[    0.104392]   Normal zone: 5500927 pages, LIFO batch:63
[    0.229609] ACPI: PM-Timer IO Port: 0x808
[    0.229612] ACPI: Local APIC address 0xfee00000
[    0.229619] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
[    0.229626] IOAPIC[0]: apic_id 9, version 33, address 0xfec00000, GSI 0-23
[    0.229628] IOAPIC[1]: apic_id 10, version 33, address 0xfec20000, GSI 24-55
[    0.229629] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.229631] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.229632] ACPI: IRQ0 used by override.
[    0.229632] ACPI: IRQ9 used by override.
[    0.229634] Using ACPI (MADT) for SMP configuration information
[    0.229635] ACPI: HPET id: 0x43538210 base: 0xfed00000
[    0.229645] smpboot: Allowing 8 CPUs, 0 hotplug CPUs
[    0.229663] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.229665] PM: Registered nosave memory: [mem 0x000a0000-0x000fffff]
[    0.229666] PM: Registered nosave memory: [mem 0xb0483000-0xb0483fff]
[    0.229668] PM: Registered nosave memory: [mem 0xb0493000-0xb0493fff]
[    0.229668] PM: Registered nosave memory: [mem 0xb0494000-0xb0494fff]
[    0.229669] PM: Registered nosave memory: [mem 0xb04b4000-0xb04b4fff]
[    0.229671] PM: Registered nosave memory: [mem 0xbe864000-0xbea3bfff]
[    0.229671] PM: Registered nosave memory: [mem 0xbea3c000-0xbea45fff]
[    0.229672] PM: Registered nosave memory: [mem 0xbea46000-0xbee34fff]
[    0.229672] PM: Registered nosave memory: [mem 0xbee35000-0xbf159fff]
[    0.229674] PM: Registered nosave memory: [mem 0xbf15b000-0xbf360fff]
[    0.229675] PM: Registered nosave memory: [mem 0xbf800000-0xf7ffffff]
[    0.229676] PM: Registered nosave memory: [mem 0xf8000000-0xfbffffff]
[    0.229676] PM: Registered nosave memory: [mem 0xfc000000-0xfebfffff]
[    0.229676] PM: Registered nosave memory: [mem 0xfec00000-0xfec00fff]
[    0.229677] PM: Registered nosave memory: [mem 0xfec01000-0xfec0ffff]
[    0.229677] PM: Registered nosave memory: [mem 0xfec10000-0xfec10fff]
[    0.229678] PM: Registered nosave memory: [mem 0xfec11000-0xfec1ffff]
[    0.229678] PM: Registered nosave memory: [mem 0xfec20000-0xfec20fff]
[    0.229679] PM: Registered nosave memory: [mem 0xfec21000-0xfecfffff]
[    0.229679] PM: Registered nosave memory: [mem 0xfed00000-0xfed00fff]
[    0.229680] PM: Registered nosave memory: [mem 0xfed01000-0xfed60fff]
[    0.229680] PM: Registered nosave memory: [mem 0xfed61000-0xfed70fff]
[    0.229681] PM: Registered nosave memory: [mem 0xfed71000-0xfed7ffff]
[    0.229681] PM: Registered nosave memory: [mem 0xfed80000-0xfed8ffff]
[    0.229682] PM: Registered nosave memory: [mem 0xfed90000-0xfeefffff]
[    0.229682] PM: Registered nosave memory: [mem 0xfef00000-0xffffffff]
[    0.229683] PM: Registered nosave memory: [mem 0x100000000-0x100000fff]
[    0.229684] [mem 0xbf800000-0xf7ffffff] available for PCI devices
[    0.229685] Booting paravirtualized kernel on bare hardware
[    0.229688] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.350676] setup_percpu: NR_CPUS:1024 nr_cpumask_bits:8 nr_cpu_ids:8 nr_node_ids:1
[    0.351183] percpu: Embedded 45 pages/cpu @(____ptrval____) s147456 r8192 d28672 u262144
[    0.351190] pcpu-alloc: s147456 r8192 d28672 u262144 alloc=1*2097152
[    0.351191] pcpu-alloc: [0] 0 1 2 3 4 5 6 7 
[    0.351218] Built 1 zonelists, mobility grouping on.  Total pages: 6184213
[    0.351219] Policy zone: Normal
[    0.351220] Kernel command line: BOOT_IMAGE=//vmlinuz-5.0.9-200.fc29.x86_64 root=/dev/mapper/fedora-root ro rd.lvm.lv=fedora/root rd.lvm.lv=fedora/swap rhgb quiet LANG=en_US.UTF-8 rd.driver.blacklist=nouveau single
[    0.465411] Memory: 24429324K/25129608K available (12291K kernel code, 1523K rwdata, 4148K rodata, 2204K init, 4688K bss, 700284K reserved, 0K cma-reserved)
[    0.465551] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[    0.465557] ftrace: allocating 39080 entries in 153 pages
[    0.483625] rcu: Hierarchical RCU implementation.
[    0.483626] rcu: 	RCU restricting CPUs from NR_CPUS=1024 to nr_cpu_ids=8.
[    0.483626] 	Tasks RCU enabled.
[    0.483627] rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
[    0.483628] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=8
[    0.486272] NR_IRQS: 65792, nr_irqs: 1032, preallocated irqs: 16
[    0.486565] Console: colour dummy device 80x25
[    0.486569] printk: console [tty0] enabled
[    0.486583] ACPI: Core revision 20181213
[    0.486726] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484873504 ns
[    0.486734] hpet clockevent registered
[    0.486737] APIC: Switch to symmetric I/O mode setup
[    0.487325] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.491738] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x32ae29645e6, max_idle_ns: 440795275062 ns
[    0.491747] Calibrating delay loop (skipped), value calculated using timer frequency.. 7031.89 BogoMIPS (lpj=3515947)
[    0.491749] pid_max: default: 32768 minimum: 301
[    0.499200] LSM: Security Framework initializing
[    0.499201] Yama: becoming mindful.
[    0.499205] SELinux:  Initializing.
[    0.506331] Dentry cache hash table entries: 4194304 (order: 13, 33554432 bytes)
[    0.510021] Inode-cache hash table entries: 2097152 (order: 12, 16777216 bytes)
[    0.510152] Mount-cache hash table entries: 65536 (order: 7, 524288 bytes)
[    0.510265] Mountpoint-cache hash table entries: 65536 (order: 7, 524288 bytes)
[    0.510477] mce: CPU supports 7 MCE banks
[    0.510485] LVT offset 1 assigned for vector 0xf9
[    0.510489] Last level iTLB entries: 4KB 512, 2MB 1024, 4MB 512
[    0.510490] Last level dTLB entries: 4KB 1024, 2MB 1024, 4MB 512, 1GB 0
[    0.510492] Spectre V2 : Mitigation: Full AMD retpoline
[    0.510492] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.510498] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[    0.510499] Spectre V2 : User space: Vulnerable
[    0.510500] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl and seccomp
[    0.510661] Freeing SMP alternatives memory: 36K
[    0.512739] smpboot: CPU0: AMD FX(tm)-8320 Eight-Core Processor (family: 0x15, model: 0x2, stepping: 0x0)
[    0.512739] Performance Events: Fam15h core perfctr, AMD PMU driver.
[    0.512739] ... version:                0
[    0.512739] ... bit width:              48
[    0.512739] ... generic registers:      6
[    0.512739] ... value mask:             0000ffffffffffff
[    0.512739] ... max period:             00007fffffffffff
[    0.512739] ... fixed-purpose events:   0
[    0.512739] ... event mask:             000000000000003f
[    0.512739] rcu: Hierarchical SRCU implementation.
[    0.512739] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    0.512739] smp: Bringing up secondary CPUs ...
[    0.512739] x86: Booting SMP configuration:
[    0.512739] .... node  #0, CPUs:      #1 #2 #3 #4 #5 #6 #7
[    0.539784] smp: Brought up 1 node, 8 CPUs
[    0.539784] smpboot: Max logical packages: 1
[    0.539784] smpboot: Total of 8 processors activated (56255.15 BogoMIPS)
[    0.542242] devtmpfs: initialized
[    0.542242] x86/mm: Memory block size: 128MB
[    0.544192] PM: Registering ACPI NVS region [mem 0xbea46000-0xbee34fff] (4124672 bytes)
[    0.544192] PM: Registering ACPI NVS region [mem 0xbf15b000-0xbf360fff] (2121728 bytes)
[    0.544192] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.544192] futex hash table entries: 2048 (order: 5, 131072 bytes)
[    0.544192] pinctrl core: initialized pinctrl subsystem
[    0.544192] RTC time: 23:21:45, date: 2019-06-10
[    0.544798] NET: Registered protocol family 16
[    0.544905] audit: initializing netlink subsys (disabled)
[    0.544910] audit: type=2000 audit(1560208905.058:1): state=initialized audit_enabled=0 res=1
[    0.544910] cpuidle: using governor menu
[    0.544910] ACPI: bus type PCI registered
[    0.544910] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.544910] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    0.544910] PCI: not using MMCONFIG
[    0.544910] PCI: Using configuration type 1 for base access
[    0.544910] PCI: Using configuration type 1 for extended access
[    0.547297] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    0.547297] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.547297] cryptd: max_cpu_qlen set to 1000
[    0.547297] ACPI: Added _OSI(Module Device)
[    0.547297] ACPI: Added _OSI(Processor Device)
[    0.547297] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.547297] ACPI: Added _OSI(Processor Aggregator Device)
[    0.547297] ACPI: Added _OSI(Linux-Dell-Video)
[    0.547297] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.547297] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    0.550751] ACPI: 2 ACPI AML tables successfully acquired and loaded
[    0.551846] ACPI: Interpreter enabled
[    0.551863] ACPI: (supports S0 S3 S4 S5)
[    0.551863] ACPI: Using IOAPIC for interrupt routing
[    0.551977] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    0.552009] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in ACPI motherboard resources
[    0.552021] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.552230] ACPI: Enabled 10 GPEs in block 00 to 1F
[    0.557337] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.557341] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    0.557344] acpi PNP0A08:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    0.557613] PCI host bridge to bus 0000:00
[    0.557616] pci_bus 0000:00: root bus resource [io  0x0000-0x03af window]
[    0.557617] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
[    0.557618] pci_bus 0000:00: root bus resource [io  0x03b0-0x03df window]
[    0.557619] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.557621] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.557622] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000dffff window]
[    0.557623] pci_bus 0000:00: root bus resource [mem 0xc0000000-0xffffffff window]
[    0.557625] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.557633] pci 0000:00:00.0: [1002:5a14] type 00 class 0x060000
[    0.557745] pci 0000:00:02.0: [1002:5a16] type 01 class 0x060400
[    0.557762] pci 0000:00:02.0: enabling Extended Tags
[    0.557783] pci 0000:00:02.0: PME# supported from D0 D3hot D3cold
[    0.557859] pci 0000:00:04.0: [1002:5a18] type 01 class 0x060400
[    0.557874] pci 0000:00:04.0: enabling Extended Tags
[    0.557895] pci 0000:00:04.0: PME# supported from D0 D3hot D3cold
[    0.557970] pci 0000:00:09.0: [1002:5a1c] type 01 class 0x060400
[    0.557986] pci 0000:00:09.0: enabling Extended Tags
[    0.558006] pci 0000:00:09.0: PME# supported from D0 D3hot D3cold
[    0.558091] pci 0000:00:11.0: [1002:4391] type 00 class 0x010601
[    0.558107] pci 0000:00:11.0: reg 0x10: [io  0xf090-0xf097]
[    0.558114] pci 0000:00:11.0: reg 0x14: [io  0xf080-0xf083]
[    0.558120] pci 0000:00:11.0: reg 0x18: [io  0xf070-0xf077]
[    0.558127] pci 0000:00:11.0: reg 0x1c: [io  0xf060-0xf063]
[    0.558134] pci 0000:00:11.0: reg 0x20: [io  0xf050-0xf05f]
[    0.558141] pci 0000:00:11.0: reg 0x24: [mem 0xfe30b000-0xfe30b3ff]
[    0.558235] pci 0000:00:12.0: [1002:4397] type 00 class 0x0c0310
[    0.558248] pci 0000:00:12.0: reg 0x10: [mem 0xfe30a000-0xfe30afff]
[    0.558356] pci 0000:00:12.2: [1002:4396] type 00 class 0x0c0320
[    0.558371] pci 0000:00:12.2: reg 0x10: [mem 0xfe309000-0xfe3090ff]
[    0.558430] pci 0000:00:12.2: supports D1 D2
[    0.558431] pci 0000:00:12.2: PME# supported from D0 D1 D2 D3hot
[    0.558508] pci 0000:00:13.0: [1002:4397] type 00 class 0x0c0310
[    0.558522] pci 0000:00:13.0: reg 0x10: [mem 0xfe308000-0xfe308fff]
[    0.558629] pci 0000:00:13.2: [1002:4396] type 00 class 0x0c0320
[    0.558645] pci 0000:00:13.2: reg 0x10: [mem 0xfe307000-0xfe3070ff]
[    0.558703] pci 0000:00:13.2: supports D1 D2
[    0.558704] pci 0000:00:13.2: PME# supported from D0 D1 D2 D3hot
[    0.558784] pci 0000:00:14.0: [1002:4385] type 00 class 0x0c0500
[    0.558902] pci 0000:00:14.1: [1002:439c] type 00 class 0x01018a
[    0.558915] pci 0000:00:14.1: reg 0x10: [io  0xf040-0xf047]
[    0.558922] pci 0000:00:14.1: reg 0x14: [io  0xf030-0xf033]
[    0.558929] pci 0000:00:14.1: reg 0x18: [io  0xf020-0xf027]
[    0.558935] pci 0000:00:14.1: reg 0x1c: [io  0xf010-0xf013]
[    0.558942] pci 0000:00:14.1: reg 0x20: [io  0xf000-0xf00f]
[    0.558957] pci 0000:00:14.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    0.558958] pci 0000:00:14.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    0.558959] pci 0000:00:14.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    0.558960] pci 0000:00:14.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    0.559030] pci 0000:00:14.2: [1002:4383] type 00 class 0x040300
[    0.559048] pci 0000:00:14.2: reg 0x10: [mem 0xfe300000-0xfe303fff 64bit]
[    0.559097] pci 0000:00:14.2: PME# supported from D0 D3hot D3cold
[    0.559166] pci 0000:00:14.3: [1002:439d] type 00 class 0x060100
[    0.559280] pci 0000:00:14.4: [1002:4384] type 01 class 0x060401
[    0.559373] pci 0000:00:14.5: [1002:4399] type 00 class 0x0c0310
[    0.559386] pci 0000:00:14.5: reg 0x10: [mem 0xfe306000-0xfe306fff]
[    0.559524] pci 0000:00:16.0: [1002:4397] type 00 class 0x0c0310
[    0.559537] pci 0000:00:16.0: reg 0x10: [mem 0xfe305000-0xfe305fff]
[    0.559645] pci 0000:00:16.2: [1002:4396] type 00 class 0x0c0320
[    0.559660] pci 0000:00:16.2: reg 0x10: [mem 0xfe304000-0xfe3040ff]
[    0.559719] pci 0000:00:16.2: supports D1 D2
[    0.559720] pci 0000:00:16.2: PME# supported from D0 D1 D2 D3hot
[    0.559796] pci 0000:00:18.0: [1022:1600] type 00 class 0x060000
[    0.559864] pci 0000:00:18.1: [1022:1601] type 00 class 0x060000
[    0.559931] pci 0000:00:18.2: [1022:1602] type 00 class 0x060000
[    0.559995] pci 0000:00:18.3: [1022:1603] type 00 class 0x060000
[    0.560063] pci 0000:00:18.4: [1022:1604] type 00 class 0x060000
[    0.560128] pci 0000:00:18.5: [1022:1605] type 00 class 0x060000
[    0.560229] pci 0000:01:00.0: [10de:1380] type 00 class 0x030000
[    0.560248] pci 0000:01:00.0: reg 0x10: [mem 0xfd000000-0xfdffffff]
[    0.560258] pci 0000:01:00.0: reg 0x14: [mem 0xc0000000-0xcfffffff 64bit pref]
[    0.560268] pci 0000:01:00.0: reg 0x1c: [mem 0xd0000000-0xd1ffffff 64bit pref]
[    0.560274] pci 0000:01:00.0: reg 0x24: [io  0xe000-0xe07f]
[    0.560281] pci 0000:01:00.0: reg 0x30: [mem 0xfe000000-0xfe07ffff pref]
[    0.560286] pci 0000:01:00.0: enabling Extended Tags
[    0.560296] pci 0000:01:00.0: BAR 3: assigned to efifb
[    0.560362] pci 0000:01:00.0: 32.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s x16 link at 0000:00:02.0 (capable of 126.016 Gb/s with 8 GT/s x16 link)
[    0.560398] pci 0000:01:00.1: [10de:0fbc] type 00 class 0x040300
[    0.560411] pci 0000:01:00.1: reg 0x10: [mem 0xfe080000-0xfe083fff]
[    0.560440] pci 0000:01:00.1: enabling Extended Tags
[    0.560524] pci 0000:00:02.0: ASPM: current common clock configuration is broken, reconfiguring
[    0.562759] pci 0000:00:02.0: PCI bridge to [bus 01]
[    0.562762] pci 0000:00:02.0:   bridge window [io  0xe000-0xefff]
[    0.562764] pci 0000:00:02.0:   bridge window [mem 0xfd000000-0xfe0fffff]
[    0.562767] pci 0000:00:02.0:   bridge window [mem 0xc0000000-0xd1ffffff 64bit pref]
[    0.562804] pci 0000:02:00.0: [1106:3483] type 00 class 0x0c0330
[    0.562820] pci 0000:02:00.0: reg 0x10: [mem 0xfe200000-0xfe200fff 64bit]
[    0.562877] pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.565751] pci 0000:00:04.0: PCI bridge to [bus 02]
[    0.565755] pci 0000:00:04.0:   bridge window [mem 0xfe200000-0xfe2fffff]
[    0.565802] pci 0000:03:00.0: [10ec:8168] type 00 class 0x020000
[    0.565823] pci 0000:03:00.0: reg 0x10: [io  0xd000-0xd0ff]
[    0.565841] pci 0000:03:00.0: reg 0x18: [mem 0xfe100000-0xfe100fff 64bit]
[    0.565853] pci 0000:03:00.0: reg 0x20: [mem 0xd2100000-0xd2103fff 64bit pref]
[    0.565921] pci 0000:03:00.0: supports D1 D2
[    0.565922] pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.568756] pci 0000:00:09.0: PCI bridge to [bus 03]
[    0.568759] pci 0000:00:09.0:   bridge window [io  0xd000-0xdfff]
[    0.568761] pci 0000:00:09.0:   bridge window [mem 0xfe100000-0xfe1fffff]
[    0.568764] pci 0000:00:09.0:   bridge window [mem 0xd2100000-0xd21fffff 64bit pref]
[    0.568775] pci_bus 0000:04: extended config space not accessible
[    0.568826] pci 0000:00:14.4: PCI bridge to [bus 04] (subtractive decode)
[    0.568832] pci 0000:00:14.4:   bridge window [io  0x0000-0x03af window] (subtractive decode)
[    0.568833] pci 0000:00:14.4:   bridge window [io  0x03e0-0x0cf7 window] (subtractive decode)
[    0.568834] pci 0000:00:14.4:   bridge window [io  0x03b0-0x03df window] (subtractive decode)
[    0.568836] pci 0000:00:14.4:   bridge window [io  0x0d00-0xffff window] (subtractive decode)
[    0.568837] pci 0000:00:14.4:   bridge window [mem 0x000a0000-0x000bffff window] (subtractive decode)
[    0.568838] pci 0000:00:14.4:   bridge window [mem 0x000c0000-0x000dffff window] (subtractive decode)
[    0.568839] pci 0000:00:14.4:   bridge window [mem 0xc0000000-0xffffffff window] (subtractive decode)
[    0.569214] ACPI: PCI Interrupt Link [LNKA] (IRQs 4 7 10 11 14 15) *0
[    0.569268] ACPI: PCI Interrupt Link [LNKB] (IRQs 4 7 10 11 14 15) *0
[    0.569323] ACPI: PCI Interrupt Link [LNKC] (IRQs 4 7 10 11 14 15) *0
[    0.569378] ACPI: PCI Interrupt Link [LNKD] (IRQs 4 7 10 11 14 15) *0
[    0.569422] ACPI: PCI Interrupt Link [LNKE] (IRQs 4 10 11 14 15) *0
[    0.569457] ACPI: PCI Interrupt Link [LNKF] (IRQs 4 10 11 14 15) *0
[    0.569493] ACPI: PCI Interrupt Link [LNKG] (IRQs 4 10 11 14 15) *0
[    0.569528] ACPI: PCI Interrupt Link [LNKH] (IRQs 4 10 11 14 15) *0
[    0.569758] pci 0000:01:00.0: vgaarb: setting as boot VGA device
[    0.569758] pci 0000:01:00.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    0.569758] pci 0000:01:00.0: vgaarb: bridge control possible
[    0.569758] vgaarb: loaded
[    0.569845] SCSI subsystem initialized
[    0.569866] libata version 3.00 loaded.
[    0.569866] ACPI: bus type USB registered
[    0.569866] usbcore: registered new interface driver usbfs
[    0.569866] usbcore: registered new interface driver hub
[    0.569866] usbcore: registered new device driver usb
[    0.569866] pps_core: LinuxPPS API ver. 1 registered
[    0.569866] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.569866] PTP clock support registered
[    0.569869] EDAC MC: Ver: 3.0.0
[    0.569869] Registered efivars operations
[    0.575811] PCI: Using ACPI for IRQ routing
[    0.581996] PCI: pci_cache_line_size set to 64 bytes
[    0.582042] e820: reserve RAM buffer [mem 0xb0483018-0xb3ffffff]
[    0.582044] e820: reserve RAM buffer [mem 0xb0494018-0xb3ffffff]
[    0.582044] e820: reserve RAM buffer [mem 0xbe864000-0xbfffffff]
[    0.582045] e820: reserve RAM buffer [mem 0xbf15b000-0xbfffffff]
[    0.582046] e820: reserve RAM buffer [mem 0xbf800000-0xbfffffff]
[    0.582047] e820: reserve RAM buffer [mem 0x63f000000-0x63fffffff]
[    0.582740] NetLabel: Initializing
[    0.582740] NetLabel:  domain hash size = 128
[    0.582740] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.582740] NetLabel:  unlabeled traffic allowed by default
[    0.582815] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.582817] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
[    0.584792] clocksource: Switched to clocksource tsc-early
[    0.600022] VFS: Disk quotas dquot_6.6.0
[    0.600036] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.600091] pnp: PnP ACPI init
[    0.600204] system 00:00: [mem 0xe0000000-0xefffffff] has been reserved
[    0.600208] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.600430] system 00:01: [io  0x040b] has been reserved
[    0.600431] system 00:01: [io  0x04d6] has been reserved
[    0.600433] system 00:01: [io  0x0c00-0x0c01] has been reserved
[    0.600434] system 00:01: [io  0x0c14] has been reserved
[    0.600435] system 00:01: [io  0x0c50-0x0c51] has been reserved
[    0.600436] system 00:01: [io  0x0c52] has been reserved
[    0.600438] system 00:01: [io  0x0c6c] has been reserved
[    0.600440] system 00:01: [io  0x0c6f] has been reserved
[    0.600442] system 00:01: [io  0x0cd0-0x0cd1] has been reserved
[    0.600443] system 00:01: [io  0x0cd2-0x0cd3] has been reserved
[    0.600445] system 00:01: [io  0x0cd4-0x0cd5] has been reserved
[    0.600446] system 00:01: [io  0x0cd6-0x0cd7] has been reserved
[    0.600447] system 00:01: [io  0x0cd8-0x0cdf] has been reserved
[    0.600449] system 00:01: [io  0x0800-0x089f] has been reserved
[    0.600450] system 00:01: [io  0x0b20-0x0b3f] has been reserved
[    0.600451] system 00:01: [io  0x0900-0x090f] has been reserved
[    0.600452] system 00:01: [io  0x0910-0x091f] has been reserved
[    0.600454] system 00:01: [io  0xfe00-0xfefe] has been reserved
[    0.600456] system 00:01: [mem 0xfec00000-0xfec00fff] could not be reserved
[    0.600458] system 00:01: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.600459] system 00:01: [mem 0xfed80000-0xfed8ffff] has been reserved
[    0.600461] system 00:01: [mem 0xfed61000-0xfed70fff] has been reserved
[    0.600462] system 00:01: [mem 0xfec10000-0xfec10fff] has been reserved
[    0.600464] system 00:01: [mem 0xfed00000-0xfed00fff] could not be reserved
[    0.600466] system 00:01: [mem 0xffc00000-0xffffffff] has been reserved
[    0.600469] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.600603] system 00:02: [io  0x0220-0x0227] has been reserved
[    0.600605] system 00:02: [io  0x0228-0x0237] has been reserved
[    0.600606] system 00:02: [io  0x0a20-0x0a2f] has been reserved
[    0.600609] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.600825] pnp 00:03: [dma 0 disabled]
[    0.600863] pnp 00:03: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.600883] pnp 00:04: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.600934] system 00:05: [io  0x04d0-0x04d1] has been reserved
[    0.600938] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.600972] system 00:06: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.601077] system 00:07: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.601166] system 00:08: [mem 0xfec20000-0xfec200ff] could not be reserved
[    0.601169] system 00:08: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.601259] pnp: PnP ACPI: found 9 devices
[    0.607495] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.607532] pci 0000:00:02.0: PCI bridge to [bus 01]
[    0.607534] pci 0000:00:02.0:   bridge window [io  0xe000-0xefff]
[    0.607536] pci 0000:00:02.0:   bridge window [mem 0xfd000000-0xfe0fffff]
[    0.607538] pci 0000:00:02.0:   bridge window [mem 0xc0000000-0xd1ffffff 64bit pref]
[    0.607541] pci 0000:00:04.0: PCI bridge to [bus 02]
[    0.607543] pci 0000:00:04.0:   bridge window [mem 0xfe200000-0xfe2fffff]
[    0.607546] pci 0000:00:09.0: PCI bridge to [bus 03]
[    0.607547] pci 0000:00:09.0:   bridge window [io  0xd000-0xdfff]
[    0.607549] pci 0000:00:09.0:   bridge window [mem 0xfe100000-0xfe1fffff]
[    0.607551] pci 0000:00:09.0:   bridge window [mem 0xd2100000-0xd21fffff 64bit pref]
[    0.607554] pci 0000:00:14.4: PCI bridge to [bus 04]
[    0.607563] pci_bus 0000:00: resource 4 [io  0x0000-0x03af window]
[    0.607564] pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7 window]
[    0.607566] pci_bus 0000:00: resource 6 [io  0x03b0-0x03df window]
[    0.607567] pci_bus 0000:00: resource 7 [io  0x0d00-0xffff window]
[    0.607568] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000bffff window]
[    0.607569] pci_bus 0000:00: resource 9 [mem 0x000c0000-0x000dffff window]
[    0.607570] pci_bus 0000:00: resource 10 [mem 0xc0000000-0xffffffff window]
[    0.607572] pci_bus 0000:01: resource 0 [io  0xe000-0xefff]
[    0.607573] pci_bus 0000:01: resource 1 [mem 0xfd000000-0xfe0fffff]
[    0.607574] pci_bus 0000:01: resource 2 [mem 0xc0000000-0xd1ffffff 64bit pref]
[    0.607576] pci_bus 0000:02: resource 1 [mem 0xfe200000-0xfe2fffff]
[    0.607581] pci_bus 0000:03: resource 0 [io  0xd000-0xdfff]
[    0.607582] pci_bus 0000:03: resource 1 [mem 0xfe100000-0xfe1fffff]
[    0.607583] pci_bus 0000:03: resource 2 [mem 0xd2100000-0xd21fffff 64bit pref]
[    0.607584] pci_bus 0000:04: resource 4 [io  0x0000-0x03af window]
[    0.607586] pci_bus 0000:04: resource 5 [io  0x03e0-0x0cf7 window]
[    0.607587] pci_bus 0000:04: resource 6 [io  0x03b0-0x03df window]
[    0.607588] pci_bus 0000:04: resource 7 [io  0x0d00-0xffff window]
[    0.607589] pci_bus 0000:04: resource 8 [mem 0x000a0000-0x000bffff window]
[    0.607590] pci_bus 0000:04: resource 9 [mem 0x000c0000-0x000dffff window]
[    0.607591] pci_bus 0000:04: resource 10 [mem 0xc0000000-0xffffffff window]
[    0.607645] NET: Registered protocol family 2
[    0.607803] tcp_listen_portaddr_hash hash table entries: 16384 (order: 6, 262144 bytes)
[    0.607941] TCP established hash table entries: 262144 (order: 9, 2097152 bytes)
[    0.608465] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.608697] TCP: Hash tables configured (established 262144 bind 65536)
[    0.608764] UDP hash table entries: 16384 (order: 7, 524288 bytes)
[    0.608898] UDP-Lite hash table entries: 16384 (order: 7, 524288 bytes)
[    0.609059] NET: Registered protocol family 1
[    0.609064] NET: Registered protocol family 44
[    0.638239] pci 0000:00:12.0: quirk_usb_early_handoff+0x0/0x6a7 took 28471 usecs
[    0.661258] pci 0000:00:13.0: quirk_usb_early_handoff+0x0/0x6a7 took 22373 usecs
[    0.684227] pci 0000:00:14.5: quirk_usb_early_handoff+0x0/0x6a7 took 22318 usecs
[    0.707225] pci 0000:00:16.0: quirk_usb_early_handoff+0x0/0x6a7 took 22451 usecs
[    0.707374] pci 0000:01:00.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.707386] pci 0000:01:00.1: Linked as a consumer to 0000:01:00.0
[    0.707522] PCI: CLS 64 bytes, default 64
[    0.707559] Unpacking initramfs...
[    1.036855] Freeing initrd memory: 23636K
[    1.036869] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    1.036870] software IO TLB: mapped [mem 0xac482000-0xb0482000] (64MB)
[    1.036944] amd_uncore: AMD NB counters detected
[    1.037088] LVT offset 0 assigned for vector 0x400
[    1.037154] perf: AMD IBS detected (0x000000ff)
[    1.039459] Initialise system trusted keyrings
[    1.039469] Key type blacklist registered
[    1.039513] workingset: timestamp_bits=36 max_order=23 bucket_order=0
[    1.041002] zbud: loaded
[    1.041734] Platform Keyring initialized
[    1.221195] alg: No test for 842 (842-generic)
[    1.222068] alg: No test for 842 (842-scomp)
[    1.247173] NET: Registered protocol family 38
[    1.247176] Key type asymmetric registered
[    1.247177] Asymmetric key parser 'x509' registered
[    1.247190] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 242)
[    1.247239] io scheduler mq-deadline registered
[    1.247240] io scheduler kyber registered
[    1.247286] io scheduler bfq registered
[    1.247401] atomic64_test: passed for x86-64 platform with CX8 and with SSE
[    1.247758] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    1.247779] efifb: probing for efifb
[    1.247791] efifb: showing boot graphics
[    1.248886] efifb: framebuffer at 0xd1000000, using 3072k, total 3072k
[    1.248887] efifb: mode is 1024x768x32, linelength=4096, pages=1
[    1.248887] efifb: scrolling: redraw
[    1.248888] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    1.248930] fbcon: Deferring console take-over
[    1.248931] fb0: EFI VGA frame buffer device
[    1.249010] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    1.249033] ACPI: Power Button [PWRB]
[    1.249081] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    1.249097] ACPI: Power Button [PWRF]
[    1.249985] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    1.270530] 00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    1.272106] Non-volatile memory driver v1.3
[    1.272138] Linux agpgart interface v0.103
[    1.273085] ahci 0000:00:11.0: version 3.0
[    1.273214] ahci 0000:00:11.0: AHCI 0001.0200 32 slots 4 ports 6 Gbps 0xf impl SATA mode
[    1.273217] ahci 0000:00:11.0: flags: 64bit ncq sntf ilck pm led clo pmp pio slum part 
[    1.273661] scsi host0: ahci
[    1.273863] scsi host1: ahci
[    1.273980] scsi host2: ahci
[    1.274092] scsi host3: ahci
[    1.274155] ata1: SATA max UDMA/133 abar m1024@0xfe30b000 port 0xfe30b100 irq 19
[    1.274157] ata2: SATA max UDMA/133 abar m1024@0xfe30b000 port 0xfe30b180 irq 19
[    1.274158] ata3: SATA max UDMA/133 abar m1024@0xfe30b000 port 0xfe30b200 irq 19
[    1.274160] ata4: SATA max UDMA/133 abar m1024@0xfe30b000 port 0xfe30b280 irq 19
[    1.274254] libphy: Fixed MDIO Bus: probed
[    1.274339] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.274341] ehci-pci: EHCI PCI platform driver
[    1.274423] QUIRK: Enable AMD PLL fix
[    1.274437] ehci-pci 0000:00:12.2: EHCI Host Controller
[    1.274475] ehci-pci 0000:00:12.2: new USB bus registered, assigned bus number 1
[    1.274478] ehci-pci 0000:00:12.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
[    1.274485] ehci-pci 0000:00:12.2: debug port 1
[    1.274517] ehci-pci 0000:00:12.2: irq 17, io mem 0xfe309000
[    1.281396] ehci-pci 0000:00:12.2: USB 2.0 started, EHCI 1.00
[    1.281452] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.00
[    1.281454] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.281455] usb usb1: Product: EHCI Host Controller
[    1.281456] usb usb1: Manufacturer: Linux 5.0.9-200.fc29.x86_64 ehci_hcd
[    1.281457] usb usb1: SerialNumber: 0000:00:12.2
[    1.281557] hub 1-0:1.0: USB hub found
[    1.281563] hub 1-0:1.0: 5 ports detected
[    1.281828] ehci-pci 0000:00:13.2: EHCI Host Controller
[    1.281862] ehci-pci 0000:00:13.2: new USB bus registered, assigned bus number 2
[    1.281865] ehci-pci 0000:00:13.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
[    1.281872] ehci-pci 0000:00:13.2: debug port 1
[    1.281893] ehci-pci 0000:00:13.2: irq 17, io mem 0xfe307000
[    1.288396] ehci-pci 0000:00:13.2: USB 2.0 started, EHCI 1.00
[    1.288452] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.00
[    1.288454] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.288455] usb usb2: Product: EHCI Host Controller
[    1.288456] usb usb2: Manufacturer: Linux 5.0.9-200.fc29.x86_64 ehci_hcd
[    1.288457] usb usb2: SerialNumber: 0000:00:13.2
[    1.288545] hub 2-0:1.0: USB hub found
[    1.288550] hub 2-0:1.0: 5 ports detected
[    1.288809] ehci-pci 0000:00:16.2: EHCI Host Controller
[    1.288843] ehci-pci 0000:00:16.2: new USB bus registered, assigned bus number 3
[    1.288845] ehci-pci 0000:00:16.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
[    1.288852] ehci-pci 0000:00:16.2: debug port 1
[    1.288873] ehci-pci 0000:00:16.2: irq 17, io mem 0xfe304000
[    1.295412] ehci-pci 0000:00:16.2: USB 2.0 started, EHCI 1.00
[    1.295487] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.00
[    1.295489] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.295490] usb usb3: Product: EHCI Host Controller
[    1.295491] usb usb3: Manufacturer: Linux 5.0.9-200.fc29.x86_64 ehci_hcd
[    1.295492] usb usb3: SerialNumber: 0000:00:16.2
[    1.295582] hub 3-0:1.0: USB hub found
[    1.295588] hub 3-0:1.0: 4 ports detected
[    1.295773] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    1.295778] ohci-pci: OHCI PCI platform driver
[    1.295864] ohci-pci 0000:00:12.0: OHCI PCI host controller
[    1.295899] ohci-pci 0000:00:12.0: new USB bus registered, assigned bus number 4
[    1.295918] ohci-pci 0000:00:12.0: irq 18, io mem 0xfe30a000
[    1.351470] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 5.00
[    1.351472] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.351473] usb usb4: Product: OHCI PCI host controller
[    1.351474] usb usb4: Manufacturer: Linux 5.0.9-200.fc29.x86_64 ohci_hcd
[    1.351475] usb usb4: SerialNumber: 0000:00:12.0
[    1.351579] hub 4-0:1.0: USB hub found
[    1.351586] hub 4-0:1.0: 5 ports detected
[    1.351821] ohci-pci 0000:00:13.0: OHCI PCI host controller
[    1.351856] ohci-pci 0000:00:13.0: new USB bus registered, assigned bus number 5
[    1.351871] ohci-pci 0000:00:13.0: irq 18, io mem 0xfe308000
[    1.407450] usb usb5: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 5.00
[    1.407452] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.407453] usb usb5: Product: OHCI PCI host controller
[    1.407454] usb usb5: Manufacturer: Linux 5.0.9-200.fc29.x86_64 ohci_hcd
[    1.407454] usb usb5: SerialNumber: 0000:00:13.0
[    1.407551] hub 5-0:1.0: USB hub found
[    1.407559] hub 5-0:1.0: 5 ports detected
[    1.407800] ohci-pci 0000:00:14.5: OHCI PCI host controller
[    1.407837] ohci-pci 0000:00:14.5: new USB bus registered, assigned bus number 6
[    1.407853] ohci-pci 0000:00:14.5: irq 18, io mem 0xfe306000
[    1.463463] usb usb6: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 5.00
[    1.463465] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.463466] usb usb6: Product: OHCI PCI host controller
[    1.463467] usb usb6: Manufacturer: Linux 5.0.9-200.fc29.x86_64 ohci_hcd
[    1.463468] usb usb6: SerialNumber: 0000:00:14.5
[    1.463570] hub 6-0:1.0: USB hub found
[    1.463577] hub 6-0:1.0: 2 ports detected
[    1.463783] ohci-pci 0000:00:16.0: OHCI PCI host controller
[    1.463822] ohci-pci 0000:00:16.0: new USB bus registered, assigned bus number 7
[    1.463838] ohci-pci 0000:00:16.0: irq 18, io mem 0xfe305000
[    1.519436] usb usb7: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 5.00
[    1.519438] usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.519439] usb usb7: Product: OHCI PCI host controller
[    1.519440] usb usb7: Manufacturer: Linux 5.0.9-200.fc29.x86_64 ohci_hcd
[    1.519441] usb usb7: SerialNumber: 0000:00:16.0
[    1.519546] hub 7-0:1.0: USB hub found
[    1.519553] hub 7-0:1.0: 4 ports detected
[    1.519713] uhci_hcd: USB Universal Host Controller Interface driver
[    1.519804] xhci_hcd 0000:02:00.0: xHCI Host Controller
[    1.519839] xhci_hcd 0000:02:00.0: new USB bus registered, assigned bus number 8
[    1.519900] xhci_hcd 0000:02:00.0: hcc params 0x002841eb hci version 0x100 quirks 0x0000000000000090
[    1.520025] usb usb8: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.00
[    1.520026] usb usb8: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.520027] usb usb8: Product: xHCI Host Controller
[    1.520028] usb usb8: Manufacturer: Linux 5.0.9-200.fc29.x86_64 xhci-hcd
[    1.520029] usb usb8: SerialNumber: 0000:02:00.0
[    1.520103] hub 8-0:1.0: USB hub found
[    1.520109] hub 8-0:1.0: 1 port detected
[    1.520179] xhci_hcd 0000:02:00.0: xHCI Host Controller
[    1.520216] xhci_hcd 0000:02:00.0: new USB bus registered, assigned bus number 9
[    1.520219] xhci_hcd 0000:02:00.0: Host supports USB 3.0  SuperSpeed
[    1.520232] usb usb9: We don't know the algorithms for LPM for this host, disabling LPM.
[    1.520252] usb usb9: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.00
[    1.520254] usb usb9: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.520255] usb usb9: Product: xHCI Host Controller
[    1.520256] usb usb9: Manufacturer: Linux 5.0.9-200.fc29.x86_64 xhci-hcd
[    1.520257] usb usb9: SerialNumber: 0000:02:00.0
[    1.520328] hub 9-0:1.0: USB hub found
[    1.520335] hub 9-0:1.0: 4 ports detected
[    1.520464] usbcore: registered new interface driver usbserial_generic
[    1.520469] usbserial: USB Serial support registered for generic
[    1.520491] i8042: PNP: No PS/2 controller found.
[    1.520526] mousedev: PS/2 mouse device common for all mice
[    1.520620] rtc_cmos 00:04: RTC can wake from S4
[    1.520725] rtc_cmos 00:04: registered as rtc0
[    1.520726] rtc_cmos 00:04: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[    1.520805] device-mapper: uevent: version 1.0.3
[    1.520858] device-mapper: ioctl: 4.39.0-ioctl (2018-04-03) initialised: dm-devel@redhat.com
[    1.521115] hidraw: raw HID events driver (C) Jiri Kosina
[    1.521148] usbcore: registered new interface driver usbhid
[    1.521148] usbhid: USB HID core driver
[    1.521230] drop_monitor: Initializing network drop monitor service
[    1.521338] Initializing XFRM netlink socket
[    1.521445] NET: Registered protocol family 10
[    1.524450] Segment Routing with IPv6
[    1.524467] mip6: Mobile IPv6
[    1.524469] NET: Registered protocol family 17
[    1.524968] RAS: Correctable Errors collector initialized.
[    1.524972] microcode: microcode updated early to new patch_level=0x06000852
[    1.524991] microcode: CPU0: patch_level=0x06000852
[    1.525025] microcode: CPU1: patch_level=0x06000852
[    1.525032] microcode: CPU2: patch_level=0x06000852
[    1.525038] microcode: CPU3: patch_level=0x06000852
[    1.525046] microcode: CPU4: patch_level=0x06000852
[    1.525051] microcode: CPU5: patch_level=0x06000852
[    1.525058] microcode: CPU6: patch_level=0x06000852
[    1.525064] microcode: CPU7: patch_level=0x06000852
[    1.525092] microcode: Microcode Update Driver: v2.2.
[    1.525100] AVX version of gcm_enc/dec engaged.
[    1.525101] AES CTR mode by8 optimization enabled
[    1.553252] sched_clock: Marking stable (1553047059, 199567)->(1681544884, -128298258)
[    1.553519] registered taskstats version 1
[    1.553526] Loading compiled-in X.509 certificates
[    1.561766] usb 2-5: new high-speed USB device number 2 using ehci-pci
[    1.592180] Loaded X.509 cert 'Fedora kernel signing key: 6f4b0dfe2ebeeac4fb22935af6b2fffa759129af'
[    1.592202] zswap: loaded using pool lzo/zbud
[    1.597702] Key type big_key registered
[    1.600545] Key type encrypted registered
[    1.600879] ima: No TPM chip found, activating TPM-bypass!
[    1.600884] ima: Allocated hash algorithm: sha1
[    1.600889] No architecture policies found
[    1.601164]   Magic number: 7:16:403
[    1.601319] rtc_cmos 00:04: setting system clock to 2019-06-10T23:21:46 UTC (1560208906)
[    1.692623] usb 2-5: New USB device found, idVendor=1a40, idProduct=0101, bcdDevice= 1.11
[    1.692625] usb 2-5: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[    1.692626] usb 2-5: Product: USB 2.0 Hub
[    1.692889] hub 2-5:1.0: USB hub found
[    1.692995] hub 2-5:1.0: 4 ports detected
[    1.717849] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    1.717877] ata4: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    1.719488] ata4.00: ATA-8: HGST HDN724040ALE640, MJAOA5E0, max UDMA/133
[    1.719489] ata4.00: 7814037168 sectors, multi 16: LBA48 NCQ (depth 32), AA
[    1.719706] ata1.00: ATAPI: HL-DT-ST BD-RE  WH14NS40, 1.00, max UDMA/133
[    1.720724] ata1.00: configured for UDMA/133
[    1.721162] ata4.00: configured for UDMA/133
[    1.725767] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    1.725816] ata3: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    1.726798] ata3.00: supports DRM functions and may not be fully accessible
[    1.726839] ata3.00: ATA-10: CT1000MX500SSD1, M3CR022, max UDMA/133
[    1.726842] ata3.00: 1953525168 sectors, multi 1: LBA48 NCQ (depth 32), AA
[    1.727296] scsi 0:0:0:0: CD-ROM            HL-DT-ST BD-RE  WH14NS40  1.00 PQ: 0 ANSI: 5
[    1.727352] ata2.00: ATA-8: HGST HDN724040ALE640, MJAOA5E0, max UDMA/133
[    1.727358] ata2.00: 7814037168 sectors, multi 16: LBA48 NCQ (depth 32), AA
[    1.727450] ata3.00: supports DRM functions and may not be fully accessible
[    1.727958] ata3.00: configured for UDMA/133
[    1.729054] ata2.00: configured for UDMA/133
[    1.744144] usb 9-1: new SuperSpeed Gen 1 USB device number 2 using xhci_hcd
[    1.763784] sr 0:0:0:0: [sr0] scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 cdda tray
[    1.763785] cdrom: Uniform CD-ROM driver Revision: 3.20
[    1.764014] sr 0:0:0:0: Attached scsi CD-ROM sr0
[    1.764146] sr 0:0:0:0: Attached scsi generic sg0 type 5
[    1.764378] scsi 1:0:0:0: Direct-Access     ATA      HGST HDN724040AL A5E0 PQ: 0 ANSI: 5
[    1.764532] sd 1:0:0:0: Attached scsi generic sg1 type 0
[    1.764569] sd 1:0:0:0: [sda] 7814037168 512-byte logical blocks: (4.00 TB/3.64 TiB)
[    1.764571] sd 1:0:0:0: [sda] 4096-byte physical blocks
[    1.764585] sd 1:0:0:0: [sda] Write Protect is off
[    1.764586] sd 1:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    1.764612] sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    1.764706] scsi 2:0:0:0: Direct-Access     ATA      CT1000MX500SSD1  022  PQ: 0 ANSI: 5
[    1.764859] sd 2:0:0:0: Attached scsi generic sg2 type 0
[    1.764926] sd 2:0:0:0: [sdb] 1953525168 512-byte logical blocks: (1.00 TB/932 GiB)
[    1.764927] sd 2:0:0:0: [sdb] 4096-byte physical blocks
[    1.764942] sd 2:0:0:0: [sdb] Write Protect is off
[    1.764944] sd 2:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    1.764971] sd 2:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    1.765029] scsi 3:0:0:0: Direct-Access     ATA      HGST HDN724040AL A5E0 PQ: 0 ANSI: 5
[    1.765185] sd 3:0:0:0: Attached scsi generic sg3 type 0
[    1.765215] sd 3:0:0:0: [sdc] 7814037168 512-byte logical blocks: (4.00 TB/3.64 TiB)
[    1.765217] sd 3:0:0:0: [sdc] 4096-byte physical blocks
[    1.765229] sd 3:0:0:0: [sdc] Write Protect is off
[    1.765231] sd 3:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[    1.765251] sd 3:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    1.766291]  sdb: sdb1
[    1.766813] sd 2:0:0:0: [sdb] supports TCG Opal
[    1.766815] sd 2:0:0:0: [sdb] Attached SCSI disk
[    1.805826] usb 7-4: new full-speed USB device number 2 using ohci-pci
[    1.817781]  sda: sda1
[    1.818247] sd 1:0:0:0: [sda] Attached SCSI disk
[    1.831314]  sdc: sdc1
[    1.831768] sd 3:0:0:0: [sdc] Attached SCSI disk
[    1.833613] Freeing unused decrypted memory: 2040K
[    1.834166] Freeing unused kernel image memory: 2204K
[    1.839860] Write protecting the kernel read-only data: 20480k
[    1.840606] Freeing unused kernel image memory: 2020K
[    1.841154] Freeing unused kernel image memory: 1996K
[    1.849844] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    1.849848] rodata_test: all tests were successful
[    1.849855] Run /init as init process
[    1.872906] systemd[1]: systemd 239 running in system mode. (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN +PCRE2 default-hierarchy=hybrid)
[    1.884972] systemd[1]: Detected architecture x86-64.
[    1.884979] systemd[1]: Running in initial RAM disk.
[    1.888376] systemd[1]: Set hostname to <supermario.mushroomkingdom>.
[    1.940108] random: systemd: uninitialized urandom read (16 bytes read)
[    1.940178] systemd[1]: Listening on udev Control Socket.
[    1.940216] random: systemd: uninitialized urandom read (16 bytes read)
[    1.940255] systemd[1]: Listening on udev Kernel Socket.
[    1.940263] random: systemd: uninitialized urandom read (16 bytes read)
[    1.940269] systemd[1]: Reached target Slices.
[    1.940347] systemd[1]: Listening on Journal Audit Socket.
[    1.940357] systemd[1]: Reached target Timers.
[    1.940367] systemd[1]: Reached target Local File Systems.
[    1.974421] usb 7-4: New USB device found, idVendor=057e, idProduct=0337, bcdDevice= 1.00
[    1.974423] usb 7-4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    1.974424] usb 7-4: Product: WUP-028
[    1.974426] usb 7-4: Manufacturer: Nintendo
[    1.974427] usb 7-4: SerialNumber: 15/07/2014
[    1.984108] hid-generic 0003:057E:0337.0001: hiddev96,hidraw0: USB HID v1.10 Device [Nintendo WUP-028] on usb-0000:00:16.0-4/input0
[    1.991514] usb 9-1: New USB device found, idVendor=2109, idProduct=0812, bcdDevice=90.91
[    1.991516] usb 9-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    1.991517] usb 9-1: Product: USB3.0 Hub             
[    1.991518] usb 9-1: Manufacturer: VIA Labs, Inc.         
[    1.992112] hub 9-1:1.0: USB hub found
[    1.992282] hub 9-1:1.0: 4 ports detected
[    2.053754] tsc: Refined TSC clocksource calibration: 3516.079 MHz
[    2.053762] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x32aea62f38f, max_idle_ns: 440795333041 ns
[    2.053785] clocksource: Switched to clocksource tsc
[    2.085762] usb 2-5.2: new low-speed USB device number 3 using ehci-pci
[    2.103751] usb 8-1: new high-speed USB device number 2 using xhci_hcd
[    2.230912] usb 8-1: New USB device found, idVendor=2109, idProduct=3431, bcdDevice= 4.20
[    2.230913] usb 8-1: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[    2.230915] usb 8-1: Product: USB2.0 Hub
[    2.231493] hub 8-1:1.0: USB hub found
[    2.231637] hub 8-1:1.0: 4 ports detected
[    2.280490] usb 2-5.2: New USB device found, idVendor=046d, idProduct=c05a, bcdDevice=63.00
[    2.280492] usb 2-5.2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.280493] usb 2-5.2: Product: USB Optical Mouse
[    2.280494] usb 2-5.2: Manufacturer: Logitech
[    2.282855] input: Logitech USB Optical Mouse as /devices/pci0000:00/0000:00:13.2/usb2/2-5/2-5.2/2-5.2:1.0/0003:046D:C05A.0002/input/input2
[    2.282947] hid-generic 0003:046D:C05A.0002: input,hidraw1: USB HID v1.11 Mouse [Logitech USB Optical Mouse] on usb-0000:00:13.2-5.2/input0
[    2.365223] audit: type=1130 audit(1560208907.262:2): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-journald comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    2.367027] usb 9-1.1: new SuperSpeed Gen 1 USB device number 3 using xhci_hcd
[    2.374471] audit: type=1130 audit(1560208907.272:3): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-tmpfiles-setup comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    2.381267] usb 9-1.1: New USB device found, idVendor=05e3, idProduct=0743, bcdDevice= 8.19
[    2.381269] usb 9-1.1: New USB device strings: Mfr=3, Product=4, SerialNumber=5
[    2.381270] usb 9-1.1: Product: USB Storage
[    2.381271] usb 9-1.1: Manufacturer: Generic
[    2.381272] usb 9-1.1: SerialNumber: 000000000819
[    2.461808] usb 2-5.4: new low-speed USB device number 4 using ehci-pci
[    2.509808] usb 8-1.1: new high-speed USB device number 3 using xhci_hcd
[    2.537089] audit: type=1130 audit(1560208907.434:4): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-udevd comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    2.547722] usb-storage 9-1.1:1.0: USB Mass Storage device detected
[    2.547853] scsi host4: usb-storage 9-1.1:1.0
[    2.547947] usbcore: registered new interface driver usb-storage
[    2.550486] usbcore: registered new interface driver uas
[    2.588235] usb 8-1.1: New USB device found, idVendor=2109, idProduct=2812, bcdDevice=90.90
[    2.588238] usb 8-1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.588240] usb 8-1.1: Product: USB2.0 Hub             
[    2.588241] usb 8-1.1: Manufacturer: VIA Labs, Inc.         
[    2.589721] hub 8-1.1:1.0: USB hub found
[    2.590030] hub 8-1.1:1.0: 4 ports detected
[    2.622652] audit: type=1130 audit(1560208907.519:5): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-udev-trigger comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    2.638555] r8169 0000:03:00.0: can't disable ASPM; OS doesn't have ASPM control
[    2.640816] libphy: r8169: probed
[    2.641224] audit: type=1130 audit(1560208907.538:6): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=plymouth-start comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    2.641290] r8169 0000:03:00.0 eth0: RTL8168evl/8111evl, 74:d4:35:99:7c:2d, XID 2c9, IRQ 29
[    2.641292] r8169 0000:03:00.0 eth0: jumbo features [frames: 9200 bytes, tx checksumming: ko]
[    2.641320] scsi host5: pata_atiixp
[    2.641591] scsi host6: pata_atiixp
[    2.641634] ata5: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xf000 irq 14
[    2.641635] ata6: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xf008 irq 15
[    2.641818] fbcon: Taking over console
[    2.641910] Console: switching to colour frame buffer device 128x48
[    2.656848] random: fast init done
[    2.663757] usb 8-1.3: new high-speed USB device number 4 using xhci_hcd
[    2.677140] r8169 0000:03:00.0 enp3s0: renamed from eth0
[    2.678132] usb 2-5.4: New USB device found, idVendor=04f2, idProduct=0603, bcdDevice= 2.10
[    2.678134] usb 2-5.4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.678135] usb 2-5.4: Product: USB keyboard
[    2.678136] usb 2-5.4: Manufacturer: Chicony
[    2.687105] input: Chicony USB keyboard as /devices/pci0000:00/0000:00:13.2/usb2/2-5/2-5.4/2-5.4:1.0/0003:04F2:0603.0003/input/input3
[    2.739965] hid-generic 0003:04F2:0603.0003: input,hidraw2: USB HID v1.11 Keyboard [Chicony USB keyboard] on usb-0000:00:13.2-5.4/input0
[    2.743496] usb 8-1.3: New USB device found, idVendor=2080, idProduct=0001, bcdDevice= 3.22
[    2.743497] usb 8-1.3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    2.743498] usb 8-1.3: Product: NOOK
[    2.743500] usb 8-1.3: Manufacturer: Linux 2.6.27-svn40739 with s3c-udc
[    2.743501] usb 8-1.3: SerialNumber: 372041756775
[    2.745267] usb-storage 8-1.3:1.0: USB Mass Storage device detected
[    2.745371] scsi host7: usb-storage 8-1.3:1.0
[    2.757813] input: Chicony USB keyboard System Control as /devices/pci0000:00/0000:00:13.2/usb2/2-5/2-5.4/2-5.4:1.1/0003:04F2:0603.0004/input/input4
[    2.810901] input: Chicony USB keyboard Consumer Control as /devices/pci0000:00/0000:00:13.2/usb2/2-5/2-5.4/2-5.4:1.1/0003:04F2:0603.0004/input/input5
[    2.810954] input: Chicony USB keyboard as /devices/pci0000:00/0000:00:13.2/usb2/2-5/2-5.4/2-5.4:1.1/0003:04F2:0603.0004/input/input7
[    2.811035] hid-generic 0003:04F2:0603.0004: input,hiddev97,hidraw3: USB HID v1.11 Device [Chicony USB keyboard] on usb-0000:00:13.2-5.4/input1
[    2.826317] ata5.00: ATA-9: HGST HDN726060ALE614, APGNW7JH, max UDMA/133
[    2.826322] ata5.00: 11721045168 sectors, multi 16: LBA48 NCQ (depth 0/32)
[    2.828713] ata5.01: supports DRM functions and may not be fully accessible
[    2.828716] ata5.01: ATA-9: Samsung SSD 850 EVO 250GB, EMT02B6Q, max UDMA/133
[    2.828717] ata5.01: 488397168 sectors, multi 1: LBA48 NCQ (depth 0/32)
[    2.829962] ata5.00: limited to UDMA/33 due to 40-wire cable
[    2.829963] ata5.01: limited to UDMA/33 due to 40-wire cable
[    2.837940] ata5.01: supports DRM functions and may not be fully accessible
[    2.839283] scsi 5:0:0:0: Direct-Access     ATA      HGST HDN726060AL W7JH PQ: 0 ANSI: 5
[    2.839514] sd 5:0:0:0: Attached scsi generic sg4 type 0
[    2.839540] sd 5:0:0:0: [sdd] 11721045168 512-byte logical blocks: (6.00 TB/5.46 TiB)
[    2.839543] sd 5:0:0:0: [sdd] 4096-byte physical blocks
[    2.839573] sd 5:0:0:0: [sdd] Write Protect is off
[    2.839575] sd 5:0:0:0: [sdd] Mode Sense: 00 3a 00 00
[    2.839603] sd 5:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.839719] scsi 5:0:1:0: Direct-Access     ATA      Samsung SSD 850  2B6Q PQ: 0 ANSI: 5
[    2.840051] sd 5:0:1:0: Attached scsi generic sg5 type 0
[    2.853898] sd 5:0:1:0: [sde] 488397168 512-byte logical blocks: (250 GB/233 GiB)
[    2.853991] sd 5:0:1:0: [sde] Write Protect is off
[    2.853993] sd 5:0:1:0: [sde] Mode Sense: 00 3a 00 00
[    2.854025] sd 5:0:1:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.854410] sd 5:0:0:0: [sdd] Attached SCSI disk
[    2.856441]  sde: sde1 sde2 sde3
[    2.857546] sd 5:0:1:0: [sde] supports TCG Opal
[    2.857548] sd 5:0:1:0: [sde] Attached SCSI disk
[    3.105497] random: crng init done
[    3.105499] random: 7 urandom warning(s) missed due to ratelimiting
[    3.231571] audit: type=1130 audit(1560208908.129:7): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=dracut-initqueue comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    3.265299] audit: type=1130 audit(1560208908.162:8): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-fsck-root comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    3.283387] EXT4-fs (dm-0): mounted filesystem with ordered data mode. Opts: (null)
[    3.406361] audit: type=1130 audit(1560208908.303:9): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=initrd-parse-etc comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    3.406365] audit: type=1131 audit(1560208908.303:10): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=initrd-parse-etc comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    3.590479] scsi 4:0:0:0: Direct-Access     Generic  STORAGE DEVICE   0819 PQ: 0 ANSI: 6
[    3.590814] sd 4:0:0:0: Attached scsi generic sg6 type 0
[    3.591942] sd 4:0:0:0: [sdf] Attached SCSI removable disk
[    3.690804] systemd-journald[314]: Received SIGTERM from PID 1 (systemd).
[    3.716926] printk: systemd: 19 output lines suppressed due to ratelimiting
[    3.782362] scsi 7:0:0:0: Direct-Access     B&N      NOOK             0322 PQ: 0 ANSI: 2
[    3.782577] sd 7:0:0:0: Attached scsi generic sg7 type 0
[    3.782927] sd 7:0:0:0: Power-on or device reset occurred
[    3.783757] sd 7:0:0:0: [sdg] Attached SCSI removable disk
[    4.184416] SELinux:  Class xdp_socket not defined in policy.
[    4.184417] SELinux: the above unknown classes and permissions will be allowed
[    4.184420] SELinux:  policy capability network_peer_controls=1
[    4.184421] SELinux:  policy capability open_perms=1
[    4.184421] SELinux:  policy capability extended_socket_class=1
[    4.184422] SELinux:  policy capability always_check_network=0
[    4.184422] SELinux:  policy capability cgroup_seclabel=1
[    4.184423] SELinux:  policy capability nnp_nosuid_transition=1
[    4.207772] systemd[1]: Successfully loaded SELinux policy in 379.142ms.
[    4.263852] systemd[1]: Relabelled /dev, /run and /sys/fs/cgroup in 37.933ms.
[    4.267674] systemd[1]: systemd 239 running in system mode. (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN +PCRE2 default-hierarchy=hybrid)
[    4.279992] systemd[1]: Detected architecture x86-64.
[    4.281115] systemd[1]: Set hostname to <supermario.mushroomkingdom>.
[    4.589012] systemd[1]: Stopped Switch Root.
[    4.589253] systemd[1]: systemd-journald.service: Service has no hold-off time (RestartSec=0), scheduling restart.
[    4.589288] systemd[1]: systemd-journald.service: Scheduled restart job, restart counter is at 1.
[    4.589307] systemd[1]: Stopped Journal Service.
[    4.590504] systemd[1]: Starting Journal Service...
[    4.591661] systemd[1]: Mounting Huge Pages File System...
[    4.595663] systemd[1]: Starting Create list of required static device nodes for the current kernel...
[    4.611295] Adding 12386300k swap on /dev/mapper/fedora-swap.  Priority:-2 extents:1 across:12386300k SSFS
[    4.626102] EXT4-fs (dm-0): re-mounted. Opts: (null)
[    4.984565] systemd-journald[688]: Received request to flush runtime journal from PID 1
[    5.308966] acpi_cpufreq: overriding BIOS provided _PSD data
[    5.312539] piix4_smbus 0000:00:14.0: SMBus Host Controller at 0xb00, revision 0
[    5.312546] piix4_smbus 0000:00:14.0: Using register 0x2c for SMBus port selection
[    5.312894] piix4_smbus 0000:00:14.0: Auxiliary SMBus Host Controller at 0xb20
[    5.347048] sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver
[    5.347203] sp5100-tco sp5100-tco: Using 0xfed80b00 for watchdog MMIO address
[    5.347989] sp5100-tco sp5100-tco: initialized. heartbeat=60 sec (nowayout=0)
[    5.363416] IPMI message handler: version 39.2
[    5.366698] ipmi device interface
[    5.436395] raid6: using algorithm sse2x4 gen() 0 MB/s
[    5.436397] raid6: .... xor() 0 MB/s, rmw enabled
[    5.436398] raid6: using ssse3x2 recovery algorithm
[    5.449720] xor: automatically using best checksumming function   avx       
[    5.487307] snd_hda_intel 0000:01:00.1: enabling device (0000 -> 0002)
[    5.487380] snd_hda_intel 0000:01:00.1: Disabling MSI
[    5.487389] snd_hda_intel 0000:01:00.1: Handle vga_switcheroo audio client
[    5.509168] snd_hda_codec_via hdaudioC0D0: autoconfig for VT2020: line_outs=4 (0x24/0x25/0x26/0x27/0x0) type:line
[    5.509171] snd_hda_codec_via hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[    5.509173] snd_hda_codec_via hdaudioC0D0:    hp_outs=1 (0x28/0x0/0x0/0x0/0x0)
[    5.509174] snd_hda_codec_via hdaudioC0D0:    mono: mono_out=0x0
[    5.509175] snd_hda_codec_via hdaudioC0D0:    dig-out=0x2d/0x2e
[    5.509177] snd_hda_codec_via hdaudioC0D0:    inputs:
[    5.509178] snd_hda_codec_via hdaudioC0D0:      Front Mic=0x29
[    5.509180] snd_hda_codec_via hdaudioC0D0:      Rear Mic=0x2b
[    5.509182] snd_hda_codec_via hdaudioC0D0:      Line=0x2a
[    5.531306] input: HDA ATI SB Front Mic as /devices/pci0000:00/0000:00:14.2/sound/card0/input8
[    5.531409] input: HDA ATI SB Rear Mic as /devices/pci0000:00/0000:00:14.2/sound/card0/input9
[    5.531477] input: HDA ATI SB Line as /devices/pci0000:00/0000:00:14.2/sound/card0/input10
[    5.531564] input: HDA ATI SB Line Out Front as /devices/pci0000:00/0000:00:14.2/sound/card0/input11
[    5.531626] input: HDA ATI SB Line Out Surround as /devices/pci0000:00/0000:00:14.2/sound/card0/input12
[    5.531691] input: HDA ATI SB Line Out CLFE as /devices/pci0000:00/0000:00:14.2/sound/card0/input13
[    5.531775] input: HDA ATI SB Line Out Side as /devices/pci0000:00/0000:00:14.2/sound/card0/input14
[    5.531866] input: HDA ATI SB Front Headphone as /devices/pci0000:00/0000:00:14.2/sound/card0/input15
[    5.560215] Btrfs loaded, crc32c=crc32c-intel
[    5.561152] BTRFS: device label SSDHome devid 1 transid 3033100 /dev/sdb1
[    5.561561] BTRFS: device label Photos devid 1 transid 326576 /dev/sdd
[    5.627879] kvm: Nested Virtualization enabled
[    5.627883] kvm: Nested Paging enabled
[    5.635109] MCE: In-kernel MCE decoding enabled.
[    5.639979] EDAC amd64: Node 0: DRAM ECC disabled.
[    5.639981] EDAC amd64: ECC disabled in the BIOS or no ECC capability, module will not load.
                Either enable ECC checking or force module loading by setting 'ecc_enable_override'.
                (Note that use of the override may cause unknown side effects.)
[    5.741994] input: HDA NVidia HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:02.0/0000:01:00.1/sound/card1/input16
[    5.742166] input: HDA NVidia HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:02.0/0000:01:00.1/sound/card1/input17
[    5.742270] input: HDA NVidia HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:02.0/0000:01:00.1/sound/card1/input18
[    5.765543] BTRFS: device label NotHome devid 1 transid 184019 /dev/sdc1
[    5.790767] BTRFS: device label Photos devid 2 transid 326576 /dev/sda1
[    5.899075] kauditd_printk_skb: 51 callbacks suppressed
[    5.899076] audit: type=1130 audit(1560208910.796:62): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=lvm2-pvscan@8:67 comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    5.940730] audit: type=1130 audit(1560208910.837:63): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=lvm2-monitor comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    6.245440] nvidia: loading out-of-tree module taints kernel.
[    6.245449] nvidia: module license 'NVIDIA' taints kernel.
[    6.245449] Disabling lock debugging due to kernel taint
[    6.256179] nvidia: module verification failed: signature and/or required key missing - tainting kernel
[    6.266996] nvidia-nvlink: Nvlink Core is being initialized, major device number 236
[    6.267432] nvidia 0000:01:00.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=none:owns=io+mem
[    6.467987] NVRM: loading NVIDIA UNIX x86_64 Kernel Module  418.56  Fri Mar 15 12:59:26 CDT 2019
[    6.512293] nvidia-uvm: Loaded the UVM driver in 8 mode, major device number 234
[    6.549569] nvidia-modeset: Loading NVIDIA Kernel Mode Setting Driver for UNIX platforms  418.56  Fri Mar 15 12:32:40 CDT 2019
[    6.553409] [drm] [nvidia-drm] [GPU ID 0x00000100] Loading driver
[    6.553411] [drm] Initialized nvidia-drm 0.0.0 20160202 for 0000:01:00.0 on minor 0
[    6.717436] audit: type=1130 audit(1560208911.614:64): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=systemd-udev-settle comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    6.886687] audit: type=1130 audit(1560208911.784:65): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=dmraid-activation comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    6.886719] audit: type=1131 audit(1560208911.784:66): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=dmraid-activation comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    6.921293] loop: module loaded
[    6.924200] audit: type=1130 audit(1560208911.821:67): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=systemd-fsck@dev-disk-by\x2duuid-1080b060\x2d4f1d\x2d4b72\x2d8544\x2dada43ec3cb54 comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    6.924922] audit: type=1130 audit(1560208911.822:68): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=systemd-fsck@dev-disk-by\x2duuid-09344d53\x2ddb1e\x2d43d0\x2d8e43\x2dc41a5884e172 comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    6.932901] BTRFS info (device sdc1): enabling auto defrag
[    6.932905] BTRFS info (device sdc1): disk space caching is enabled
[    6.932906] BTRFS info (device sdc1): has skinny extents
[    6.945451] audit: type=1130 audit(1560208911.842:69): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=systemd-fsck@dev-disk-by\x2duuid-27cc1330\x2dc4e3\x2d404f\x2d98f6\x2df23becec76b5 comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    6.949344] BTRFS info (device sdb1): enabling ssd optimizations
[    6.949347] BTRFS info (device sdb1): enabling auto defrag
[    6.949350] BTRFS info (device sdb1): disk space caching is enabled
[    6.949351] BTRFS info (device sdb1): has skinny extents
[    6.959766] EXT4-fs (loop0): mounted filesystem with ordered data mode. Opts: user_xattr
[    6.961681] BTRFS info (device sdd): enabling auto defrag
[    6.961686] BTRFS info (device sdd): disk space caching is enabled
[    6.961688] BTRFS info (device sdd): has skinny extents
[    6.967395] audit: type=1130 audit(1560208911.864:70): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=systemd-fsck@dev-disk-by\x2duuid-F7B7\x2dFE7E comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    6.994979] audit: type=1130 audit(1560208911.892:71): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=systemd-fsck@dev-disk-by\x2duuid-ac23cfa4\x2df93d\x2d4fd8\x2db9a9\x2d11ee4bb84889 comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    7.016231] EXT4-fs (sde2): mounted filesystem with ordered data mode. Opts: (null)
[    9.616434] usb 8-1.3: USB disconnect, device number 4
[    9.826834] usb 8-1.3: new high-speed USB device number 5 using xhci_hcd
[    9.903714] usb 8-1.3: New USB device found, idVendor=2080, idProduct=0001, bcdDevice= 3.22
[    9.903719] usb 8-1.3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    9.903722] usb 8-1.3: Product: NOOK
[    9.903725] usb 8-1.3: Manufacturer: Linux 2.6.27-svn40739 with s3c-udc
[    9.903727] usb 8-1.3: SerialNumber: 372041756775
[    9.906695] usb-storage 8-1.3:1.0: USB Mass Storage device detected
[    9.907006] scsi host7: usb-storage 8-1.3:1.0
[   10.950446] scsi 7:0:0:0: Direct-Access     B&N      NOOK             0322 PQ: 0 ANSI: 2
[   10.951110] sd 7:0:0:0: Attached scsi generic sg7 type 0
[   10.951161] sd 7:0:0:0: Power-on or device reset occurred
[   10.952880] sd 7:0:0:0: [sdg] Attached SCSI removable disk
[   15.391085] audit: type=1130 audit(1560208920.289:72): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=dracut-shutdown comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   15.403089] audit: type=1130 audit(1560208920.300:73): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=plymouth-read-write comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   15.403098] audit: type=1131 audit(1560208920.300:74): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=plymouth-read-write comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   15.474819] audit: type=1130 audit(1560208920.371:75): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=systemd-tmpfiles-setup comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   15.491780] audit: type=1127 audit(1560208920.389:76): pid=1060 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg=' comm="systemd-update-utmp" exe="/usr/lib/systemd/systemd-update-utmp" hostname=? addr=? terminal=? res=success'
[   15.498414] audit: type=1130 audit(1560208920.396:77): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=systemd-update-utmp comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   15.501014] audit: type=1130 audit(1560208920.398:78): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=alsa-state comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   15.503455] audit: type=1130 audit(1560208920.400:79): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=rescue comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   15.518177] audit: type=1129 audit(1560208920.415:80): pid=1063 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='old-level=N new-level=1 comm="systemd-update-utmp" exe="/usr/lib/systemd/systemd-update-utmp" hostname=? addr=? terminal=? res=success'
[   15.520002] audit: type=1130 audit(1560208920.418:81): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=systemd-update-utmp-runlevel comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[  267.794434] usb 9-1.1: reset SuperSpeed Gen 1 USB device number 3 using xhci_hcd
[  272.838054] usb 9-1.1: device descriptor read/8, error -110
[  272.941832] usb 9-1.1: reset SuperSpeed Gen 1 USB device number 3 using xhci_hcd
[  277.958049] usb 9-1.1: device descriptor read/8, error -110
[  278.236339] usb 9-1.1: reset SuperSpeed Gen 1 USB device number 3 using xhci_hcd

--nextPart2188587.dLfUqzFI6W--

--nextPart2342564.lkeB5KmT8W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEBs24pwhCu/Z7g0Sb2bE1K6FAnEUFAlz+7iMACgkQ2bE1K6FA
nEXz3wf+NVVkkkhZuKrt3PCcJP2UtB6EGN5XzH8W1lOXVBvkGtPia1X4qZW6Zf/G
kzg1O5BDnlhPducYyKU6mlNdFEWT1MJXTZG6kvIsBD4XQwmeUhYMSnC8y+KYFzwU
5nggry2fhuiDSTSYI05lcw/FFDHVOQ9w9q/11eKAD/JvgKTQFZAGBQEnOcb0362j
oL0rSBI5bJE+hXRml/WIrFvDHvkyDa2wVc9z67ziVsXHDy4m+n/o6fYF1PWtIYLL
0q8R/lRwVD5CdcmCtVHB3ErmJIFkI7yKU5Nrl0I2KgLZkK6Hy9DMs9Il6lO0Gy9+
7Ozmi0pzfEXnCt5YuvNsTfrervdbpg==
=uoXO
-----END PGP SIGNATURE-----

--nextPart2342564.lkeB5KmT8W--



