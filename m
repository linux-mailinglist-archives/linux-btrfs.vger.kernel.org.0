Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34CC93D4D90
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Jul 2021 14:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbhGYMNq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 25 Jul 2021 08:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbhGYMNq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 25 Jul 2021 08:13:46 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DAE0C061757
        for <linux-btrfs@vger.kernel.org>; Sun, 25 Jul 2021 05:54:15 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id n12so4051109wrr.2
        for <linux-btrfs@vger.kernel.org>; Sun, 25 Jul 2021 05:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=references:subject:to:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=/nxWbHleV3vPPn6No84sKFG/zeafUKt9nuPWxLPV4W4=;
        b=KneS0yvnBR9S8kQCcqwrdZJJxf+pHxpo89Q25icq881RnxfEhSmU0BQRShV6fxmZPy
         8BB6zz5r6XF5IacVMtOn9G/zUsA1aUq0zC/dXqKCkqZp2O7pcf8DUxK8yixal4JdMQYC
         jtsbSoyUyjUoGaRLUkkewnZdy5hTDlwyZy74ms64vR6KN9GFx8Lyv1bSVjUGhn8EL+VS
         VoGnWQBeSTDnjI5ZtnKRphr97bsUmupQizxJ9iaFmLDff6E8cMuMdVUwrwyVpdsayFnw
         sI1+k4q3fu0slyEn+2Ndp1imcKBurEBAyjLLvCip0xdBVBEAm3W38j5PKuGTjSgBapga
         cXvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:subject:to:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=/nxWbHleV3vPPn6No84sKFG/zeafUKt9nuPWxLPV4W4=;
        b=h2dNvQyxST94hxbxIvXiuGpH+x/pXr7xQCk1XyTxtK2cIb58IIzO43vmifPhn7cGQJ
         db0h/hLY8YDpyJ33d1DnNBsQBlxH4o4mLzfiYcyL1HPPIqtK1LmuVlQXLj2dyfxSXL9j
         rAsO/l55EArGv/6rrwy392AkMxg6XVrFxnq9F2PnaVlZFDIoQvNNM1+KICkYeV9R6IC7
         giwsMRjCSLt62z+CFtLv6ZXhmakVZkuUsKgy+DOaOYHR63J6+FFxc9N4hMzDew6kabj1
         rSwfEltZkkHjVhRWmFvg07DsM3X/+H1lte0kjcLbod7yrbDhIg92jsgJSkU3SZ/UB0vO
         zSgw==
X-Gm-Message-State: AOAM532cCaH/nkQi1kvAtQ0dXSnU/m8E2FPXBU8EP/JaQ2sXSNcQHht3
        wMHlVO/VPwrgRQhg1KWVD7SRdCyI+rs=
X-Google-Smtp-Source: ABdhPJyTFDbgTbmxK1lJNFsZ2ZHWEdGB9CWSyX8W2f0XVxnW4MSNZ9gN7Y3DZgxk3eiiBAHkRAXL0Q==
X-Received: by 2002:a05:6000:1844:: with SMTP id c4mr14521596wri.38.1627217652823;
        Sun, 25 Jul 2021 05:54:12 -0700 (PDT)
Received: from [192.168.0.5] (80-44-88-78.dynamic.dsl.as9105.com. [80.44.88.78])
        by smtp.gmail.com with ESMTPSA id r4sm39534551wre.84.2021.07.25.05.54.12
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Jul 2021 05:54:12 -0700 (PDT)
References: <8efe8a3f-9c00-3201-c0c1-414240335fe8@gmail.com>
Subject: Fwd: Inactive volume netgear NAS, data is still in tacked. (REPOST
 with Subject!)
To:     linux-btrfs@vger.kernel.org
From:   Ian B <ianpeterball@gmail.com>
X-Forwarded-Message-Id: <8efe8a3f-9c00-3201-c0c1-414240335fe8@gmail.com>
Message-ID: <8843c315-ef73-8826-180f-761d81c97128@gmail.com>
Date:   Sun, 25 Jul 2021 13:54:11 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <8efe8a3f-9c00-3201-c0c1-414240335fe8@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-Antivirus: AVG (VPS 210725-0, 25/7/2021), Outbound message
X-Antivirus-Status: Clean
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Sorry for not including a subject on my earlier email.



Hello

This is the first time I've used a mailing list, so I'm in the dark as 
to how it works. I've not used unix for over 20 years. But I'm still 
able to follow instructions, like "can you put the bins out", "let the 
dog in", etc.

Your requested outputs are at the end.

Ok, the problem as posted (after getting past the spam filters) below.

https://community.netgear.com/t5/Using-your-ReadyNAS-in-Business/Test-posting/m-p/2119388/highlight/true#M192942

I have a Netgear ReadyNAS RNDP6000 v-2 running 6.10.5 version of their 
software.

If I've not given enough detail, please let me know.

The problem is that my rndp6000 is giving me the message "Remove 
inactive volumes to use the disk. Disk #1,2,3,4,5,6,1,2,3,4,5,6,2,3,5,6.".

Is this retrievable? If so, how?

It's on firmware 6.10.5 Hot fix 1.

I can send the logs if needed.


Therefore the volume isn't accessible. It's been established it's there, 
but now what's the best way to move forward to restoring access.

Below is some of the chatter I've had so far....

**

Your data raid and disks are OK, so that is good. I was a little worried 
about this, as you mentioned the NAS had some unexpected shutdowns due 
to a thunderstorm. But the hardware looks OK at least.

I can also see that the reason for the cryptic message of:/"Remove 
inactive volumes"/happens because the NAS cannot mount the data 
volume, despite the raid running fine. This would indicate filesystem 
issues and indeed, the kernel log confirms that the BTRFS (filesystem) 
log tree is damaged. As BTRFS is a journaled filesystem, the NAS would 
have tried to do a journal check post the unexpected shutdown, but it 
seems the filesystem journal got corrupted or damaged during those 
shutdowns.

Jul 20 20:37:43 Pro kernel: BTRFS info (device md125): has skinny extents
Jul 20 20:38:42 Pro kernel: BTRFS info (device md125): start tree-log replay
Jul 20 20:38:42 Pro kernel: BTRFS error (device md125): parent transid 
verify failed on 25029252612096 wanted 8127492 found 8126807
Jul 20 20:38:42 Pro kernel: BTRFS error (device md125): parent transid 
verify failed on 25029252612096 wanted 8127492 found 8126807
Jul 20 20:38:42 Pro kernel: BTRFS warning (device md125): failed to read 
log tree
Jul 20 20:38:42 Pro kernel: BTRFS error (device md125): open_ctree failed

This_should_be easy enough to fix as you can simply reset the filesystem 
journal. You will need to log into the NAS over SSH (*via the root 
user*). Not sure if you have used SSH before?

The command to reset the log tree/journal is:

btrfs rescue zero-log /dev/md125


root@Pro:~# btrfs rescue zero-log /dev/md125
parent transid verify failed on 25029252612096 wanted 8127492 found 8126807
parent transid verify failed on 25029252612096 wanted 8127492 found 8126807
parent transid verify failed on 25029252612096 wanted 8127492 found 8126807


**

Then there are more issues than just log tree problems.

In this case,  you likely need to mount with auto recovery mode from 
a different tree root.

Attempting to mount like this, should be safe as it is read-only:

btrfs device scan

mount -o ro,usebackuproot /dev/md125 /Dual

ReadyNAS uses a pretty old version of BTRFS so "usebackuproot" might not 
work or even be an option on your NAS. If it spews "unrecognised 
command" errors (or similar), you can instead try the original mount 
recovery method:

mount -o ro,recovery /dev/md125 /Dual

If that doesn't work, then you likely need to recover the data 
using/BTRFS restore/, but you are entering serious data recovery 
territory at that point.

Anyway, try and mount like the above first and see if that works. It 
will be a read-only mount but at least it will show you if the volume 
can be mounted at all.



root@Pro:~# btrfs device scan
Scanning for Btrfs filesystems


root@Pro:~# mount -o ro,usebackuproot /dev/md125 /Dual
mount: wrong fs type, bad option, bad superblock on /dev/md125,
missing codepage or helper program, or other error

In some cases useful info is found in syslog - try
dmesg | tail or so.


root@Pro:~# dmesg | tail
[ 235.447123] nr_pdflush_threads exported in /proc is scheduled for removal
[ 3622.532329] BTRFS info (device md125): unrecognized mount option 
'usebackuproot'
[ 3622.536050] BTRFS error (device md125): open_ctree failed
[ 3696.939674] BTRFS info (device md125): enabling auto recovery
[ 3696.939679] BTRFS info (device md125): has skinny extents
[ 3764.470376] BTRFS info (device md125): start tree-log replay
[ 3764.475305] BTRFS error (device md125): parent transid verify failed 
on 25029252612096 wanted 8127492 found 8126807
[ 3764.486455] BTRFS error (device md125): parent transid verify failed 
on 25029252612096 wanted 8127492 found 8126807
[ 3764.486458] BTRFS warning (device md125): failed to read log tree
[ 3764.565029] BTRFS error (device md125): open_ctree failed


root@Pro:~# mount -o ro,recovery /dev/md125 /Dual
mount: /dev/md125: can't read superblock


*********


root@Pro:~# btrfs restore -DviF /dev/md125 /dev/null
parent transid verify failed on 25029252612096 wanted 8127492 found 8126807
parent transid verify failed on 25029252612096 wanted 8127492 found 8126807
parent transid verify failed on 25029252612096 wanted 8127492 found 8126807
This is a dry-run, no files are going to be restored
Restoring /dev/null/.purge
Reached the end of the tree searching the directory
Restoring /dev/null/._share
Restoring /dev/null/._share/.snapshot_prune
Restoring /dev/null/._share/Media
Restoring /dev/null/._share/Media/recycle.conf
....etc.
Eventualy it lists my files.

************


That is good news!

It can fetch filesNow, these first files you saw are all config and 
internal ReadyNAS files but if you left if run long enough, you would 
see files from your shares start to show (as you noticed).

BTRFS restore is method for taking a non-mountable volume and dumping 
the data somewhere else (USB, network share, etc.). I guess you are left 
with 2 options:

1. Try to repair the filesystem (BTRFSCK) which might not work either 
and can cause more damage than good.

2. Dump the data somewhere else via BTRFS restore (giving you a backup 
essentially). Then verify all is good with the backup and then factory 
reset the NAS and thereafter you can restore form the backup.

The problem is that you need at least 21.63 TiB (23.8 TB) of storage 
somewhere else, where you can dump the data.

devid 1 size 7.26TiB*used 6.49TiB* path /dev/md127
devid 2 size 14.55TiB*used 12.34TiB* path /dev/md126
devid 3 size 10.91TiB*used 2.80TiB* path /dev/md125

If you don't care about all of it, you can select which data to restore 
though the/BTRFS restore/tool. This will reduce the amount of data you 
need to dump.

Lastly, there are people who know much more about BTRFS than I do, so 
you could also use the mailing list to see if those guys have any ideas 
on how to get the volume repaired/mountable so that you don't have to 
use BTRFS restore to dump the data somewhere else. Actually, you 
probably*should*ask the guys in the mailing list as well

https://btrfs.wiki.kernel.org/index.php/Btrfs_mailing_list 
<https://btrfs.wiki.kernel.org/index.php/Btrfs_mailing_list>

But at least BTRFS restore is an option... and that is good.

AND NOW.........

As rn_enthusiast recommends, I'm reaching out to you.


*****************************************************************************************************************************************************
*********************************************************************************************************************
YOUR REQUESTED OUTPUTS

**************************************************************************************************************

root@Pro:~# uname -a
Linux Pro 4.4.218.x86_64.1 #1 SMP Mon Jan 11 06:25:23 UTC 2021 x86_64 
GNU/Linux

root@Pro:~# btrfs --version
btrfs-progs v4.16


root@Pro:~# btrfs fi show
Label: '33eb0773:root'  uuid: 13624a2a-e24e-48ae-ad2b-f786913ec748
         Total devices 1 FS bytes used 1.03GiB
         devid    1 size 4.00GiB used 4.00GiB path /dev/md0

Label: '33eb0773:Dual'  uuid: 29bccc98-ff07-426d-a82d-1a79b34131a3
         Total devices 3 FS bytes used 21.57TiB
         devid    1 size 7.26TiB used 6.49TiB path /dev/md127
         devid    2 size 14.55TiB used 12.34TiB path /dev/md126
         devid    3 size 10.91TiB used 2.80TiB path /dev/md125


root@Pro:~# btrfs fi df /dev/md127
ERROR: not a btrfs filesystem: /dev/md127

root@Pro:~# dmesg
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 4.4.218.x86_64.1 (root@blocks) (gcc version 
8.3.0 (Debian 8.3.0-6) ) #1 SMP Mon Jan 11 06:25:23 UTC 2021
[    0.000000] Command line: initrd=initrd.gz reason=normal 
BOOT_IMAGE=kernel
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000] Disabled fast string operations
[    0.000000] x86/fpu: Supporting XSAVE feature 0x01: 'x87 floating 
point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x02: 'SSE registers'
[    0.000000] x86/fpu: Enabled xstate features 0x3, context size is 576 
bytes, using 'standard' format.
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009cbff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009cc00-0x000000000009ffff] 
reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] 
reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000afeaffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000afeb0000-0x00000000afebdfff] 
ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000afebe000-0x00000000afeeffff] 
ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000afef0000-0x00000000afefffff] 
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] 
reserved
[    0.000000] BIOS-e820: [mem 0x00000000ffb00000-0x00000000ffffffff] 
reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x00000001cfffffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.4 present.
[    0.000000] DMI: To Be Filled By O.E.M. To Be Filled By O.E.M./To be 
filled by O.E.M., BIOS 080014  07/26/2010
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] e820: last_pfn = 0x1d0000 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-DFFFF write-protect
[    0.000000]   E0000-EFFFF write-through
[    0.000000]   F0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 1D0000000 mask FF0000000 uncachable
[    0.000000]   1 base 1E0000000 mask FE0000000 uncachable
[    0.000000]   2 base 000000000 mask E00000000 write-back
[    0.000000]   3 base 0B0000000 mask FF0000000 uncachable
[    0.000000]   4 base 0C0000000 mask FC0000000 uncachable
[    0.000000]   5 base 0AFF00000 mask FFFF00000 uncachable
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB WC  UC- WT
[    0.000000] e820: update [mem 0xaff00000-0xffffffff] usable ==> reserved
[    0.000000] e820: last_pfn = 0xafeb0 max_arch_pfn = 0x400000000
[    0.000000] Base memory trampoline at [ffff880000094000] 94000 size 28672
[    0.000000] BRK [0x08f56000, 0x08f56fff] PGTABLE
[    0.000000] BRK [0x08f57000, 0x08f57fff] PGTABLE
[    0.000000] BRK [0x08f58000, 0x08f58fff] PGTABLE
[    0.000000] BRK [0x08f59000, 0x08f59fff] PGTABLE
[    0.000000] BRK [0x08f5a000, 0x08f5afff] PGTABLE
[    0.000000] BRK [0x08f5b000, 0x08f5bfff] PGTABLE
[    0.000000] RAMDISK: [mem 0x7fb9e000-0x7fffffff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000F9C00 000014 (v00 ACPIAM)
[    0.000000] ACPI: RSDT 0x00000000AFEB0000 000038 (v01 A M I OEMRSDT  
07001026 MSFT 00000097)
[    0.000000] ACPI: FACP 0x00000000AFEB0200 000084 (v02 A M I OEMFACP  
07001026 MSFT 00000097)
[    0.000000] ACPI: DSDT 0x00000000AFEB0440 005B7A (v01 1ADHK 1ADHK007 
00000007 INTL 20051117)
[    0.000000] ACPI: FACS 0x00000000AFEBE000 000040
[    0.000000] ACPI: APIC 0x00000000AFEB0390 00006C (v01 A M I OEMAPIC  
07001026 MSFT 00000097)
[    0.000000] ACPI: MCFG 0x00000000AFEB0400 00003C (v01 A M I OEMMCFG  
07001026 MSFT 00000097)
[    0.000000] ACPI: OEMB 0x00000000AFEBE040 000060 (v01 A M I AMI_OEM  
07001026 MSFT 00000097)
[    0.000000] ACPI: GSCI 0x00000000AFEBE0A0 002024 (v01 A M I GMCHSCI  
07001026 MSFT 00000097)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x00000001cfffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009bfff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x00000000afeaffff]
[    0.000000]   node   0: [mem 0x0000000100000000-0x00000001cfffffff]
[    0.000000] Initmem setup node 0 [mem 
0x0000000000001000-0x00000001cfffffff]
[    0.000000] On node 0 totalpages: 1572427
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 22 pages reserved
[    0.000000]   DMA zone: 3995 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 11195 pages used for memmap
[    0.000000]   DMA32 zone: 716464 pages, LIFO batch:31
[    0.000000]   Normal zone: 13312 pages used for memmap
[    0.000000]   Normal zone: 851968 pages, LIFO batch:31
[    0.000000] Reserving Intel graphics stolen memory at 
0xaff00000-0xafffffff
[    0.000000] ACPI: PM-Timer IO Port: 0x808
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 
0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] smpboot: Allowing 4 CPUs, 2 hotplug CPUs
[    0.000000] e820: [mem 0xb0000000-0xfedfffff] available for PCI devices
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff 
max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.000000] setup_percpu: NR_CPUS:8 nr_cpumask_bits:8 nr_cpu_ids:4 
nr_node_ids:1
[    0.000000] PERCPU: Embedded 30 pages/cpu @ffff8801cfc00000 s82392 
r8192 d32296 u524288
[    0.000000] pcpu-alloc: s82392 r8192 d32296 u524288 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  
Total pages: 1547834
[    0.000000] Kernel command line: console=tty0 console=ttyS0,115200 
hpet=disable initrd=initrd.gz reason=normal BOOT_IMAGE=kernel
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Dentry cache hash table entries: 1048576 (order: 11, 
8388608 bytes)
[    0.000000] Inode-cache hash table entries: 524288 (order: 10, 
4194304 bytes)
[    0.000000] Memory: 6092116K/6289708K available (9142K kernel code, 
989K rwdata, 3940K rodata, 872K init, 696K bss, 197592K reserved, 0K 
cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] Kernel/User page tables isolation: enabled
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  RCU debugfs-based tracing is enabled.
[    0.000000]  Build-time adjustment of leaf fanout to 64.
[    0.000000]  RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=4.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=64, nr_cpu_ids=4
[    0.000000] NR_IRQS:4352 nr_irqs:456 16
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] console [ttyS0] enabled
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 2593.536 MHz processor
[    0.001012] Calibrating delay loop (skipped), value calculated using 
timer frequency.. 5187.07 BogoMIPS (lpj=2593536)
[    0.001015] pid_max: default: 32768 minimum: 301
[    0.001022] ACPI: Core revision 20150930
[    0.005346] ACPI: 1 ACPI AML tables successfully acquired and loaded
[    0.005367] Security Framework initialized
[    0.005378] Mount-cache hash table entries: 16384 (order: 5, 131072 
bytes)
[    0.005381] Mountpoint-cache hash table entries: 16384 (order: 5, 
131072 bytes)
[    0.005874] Initializing cgroup subsys io
[    0.005879] Initializing cgroup subsys memory
[    0.005892] Initializing cgroup subsys devices
[    0.005897] Initializing cgroup subsys freezer
[    0.005901] Initializing cgroup subsys net_cls
[    0.005904] Initializing cgroup subsys perf_event
[    0.005908] Initializing cgroup subsys net_prio
[    0.005913] Initializing cgroup subsys pids
[    0.005933] Disabled fast string operations
[    0.005938] CPU: Physical Processor ID: 0
[    0.005939] CPU: Processor Core ID: 0
[    0.005941] mce: CPU supports 6 MCE banks
[    0.005952] CPU0: Thermal monitoring enabled (TM2)
[    0.005956] process: using mwait in idle threads
[    0.005961] Last level iTLB entries: 4KB 128, 2MB 4, 4MB 4
[    0.005963] Last level dTLB entries: 4KB 256, 2MB 0, 4MB 32, 1GB 0
[    0.005966] Spectre V1 : Mitigation: usercopy/swapgs barriers and 
__user pointer sanitization
[    0.005968] Spectre V2 : Mitigation: Full generic retpoline
[    0.005970] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling 
RSB on context switch
[    0.005971] Speculative Store Bypass: Vulnerable
[    0.005995] MDS: Vulnerable: Clear CPU buffers attempted, no microcode
[    0.006442] Freeing SMP alternatives memory: 40K
[    0.008437] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.120478] smpboot: CPU0: Intel Pentium(R) Dual-Core  CPU E5300  @ 
2.60GHz (family: 0x6, model: 0x17, stepping: 0xa)
[    0.120496] Performance Events: PEBS fmt0+, 4-deep LBR, Core2 events, 
Intel PMU driver.
[    0.120508] ... version:                2
[    0.120509] ... bit width:              40
[    0.120510] ... generic registers:      2
[    0.120512] ... value mask:             000000ffffffffff
[    0.120513] ... max period:             000000007fffffff
[    0.120514] ... fixed-purpose events:   3
[    0.120516] ... event mask:             0000000700000003
[    0.121808] x86: Booting SMP configuration:
[    0.121811] .... node  #0, CPUs:      #1
[    0.123050] x86: Booted up 1 node, 2 CPUs
[    0.123054] smpboot: Total of 2 processors activated (10374.14 BogoMIPS)
[    0.124123] NMI watchdog: enabled on all CPUs, permanently consumes 
one hw-PMU counter.
[    0.124180] devtmpfs: initialized
[    0.125223] clocksource: jiffies: mask: 0xffffffff max_cycles: 
0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.125229] futex hash table entries: 1024 (order: 4, 65536 bytes)
[    0.125332] xor: measuring software checksum speed
[    0.135001]    prefetch64-sse: 14780.000 MB/sec
[    0.145001]    generic_sse: 12472.000 MB/sec
[    0.145003] xor: using function: prefetch64-sse (14780.000 MB/sec)
[    0.145009] pinctrl core: initialized pinctrl subsystem
[    0.145186] NET: Registered protocol family 16
[    0.149012] cpuidle: using governor ladder
[    0.152006] cpuidle: using governor menu
[    0.152199] ACPI: bus type PCI registered
[    0.152274] dca service started, version 1.12.1
[    0.152287] PCI: Using configuration type 1 for base access
[    0.178014] raid6: sse2x1   gen()  3640 MB/s
[    0.195012] raid6: sse2x1   xor()  4132 MB/s
[    0.212014] raid6: sse2x2   gen()  4257 MB/s
[    0.229004] raid6: sse2x2   xor()  5281 MB/s
[    0.246008] raid6: sse2x4   gen()  7734 MB/s
[    0.263005] raid6: sse2x4   xor()  5710 MB/s
[    0.263007] raid6: using algorithm sse2x4 gen() 7734 MB/s
[    0.263009] raid6: .... xor() 5710 MB/s, rmw enabled
[    0.263010] raid6: using ssse3x2 recovery algorithm
[    0.263213] ACPI: Added _OSI(Module Device)
[    0.263215] ACPI: Added _OSI(Processor Device)
[    0.263216] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.263218] ACPI: Added _OSI(Processor Aggregator Device)
[    0.264996] ACPI: Executed 1 blocks of module-level executable AML code
[    0.267468] ACPI: Interpreter enabled
[    0.267474] ACPI: (supports S0 S5)
[    0.267476] ACPI: Using IOAPIC for interrupt routing
[    0.267517] PCI: Using host bridge windows from ACPI; if necessary, 
use "pci=nocrs" and report a bug
[    0.274417] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.274425] acpi PNP0A08:00: _OSC: OS supports [ASPM ClockPM Segments 
MSI]
[    0.274432] acpi PNP0A08:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    0.274548] PCI host bridge to bus 0000:00
[    0.274553] pci_bus 0000:00: root bus resource [io 0x0000-0x0cf7 window]
[    0.274556] pci_bus 0000:00: root bus resource [io 0x0d00-0xffff window]
[    0.274558] pci_bus 0000:00: root bus resource [mem 
0x000a0000-0x000bffff window]
[    0.274560] pci_bus 0000:00: root bus resource [mem 
0x000d0000-0x000dffff window]
[    0.274563] pci_bus 0000:00: root bus resource [mem 
0xaff00000-0xffffffff window]
[    0.274565] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.274577] pci 0000:00:00.0: [8086:2990] type 00 class 0x060000
[    0.274711] pci 0000:00:02.0: [8086:2992] type 00 class 0x030000
[    0.274725] pci 0000:00:02.0: reg 0x10: [mem 0xffa00000-0xffafffff]
[    0.274736] pci 0000:00:02.0: reg 0x18: [mem 0xd0000000-0xdfffffff 
64bit pref]
[    0.274742] pci 0000:00:02.0: reg 0x20: [io  0xec00-0xec07]
[    0.274885] pci 0000:00:1a.0: [8086:2834] type 00 class 0x0c0300
[    0.274924] pci 0000:00:1a.0: reg 0x20: [io  0xe000-0xe01f]
[    0.275050] pci 0000:00:1a.1: [8086:2835] type 00 class 0x0c0300
[    0.275090] pci 0000:00:1a.1: reg 0x20: [io  0xdc00-0xdc1f]
[    0.275220] pci 0000:00:1a.7: [8086:283a] type 00 class 0x0c0320
[    0.275245] pci 0000:00:1a.7: reg 0x10: [mem 0xff9fb400-0xff9fb7ff]
[    0.275311] pci 0000:00:1a.7: PME# supported from D0 D3hot D3cold
[    0.275422] pci 0000:00:1b.0: [8086:284b] type 00 class 0x040300
[    0.275445] pci 0000:00:1b.0: reg 0x10: [mem 0xff9f4000-0xff9f7fff 64bit]
[    0.275498] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.275600] pci 0000:00:1c.0: [8086:283f] type 01 class 0x060400
[    0.275660] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.275771] pci 0000:00:1c.1: [8086:2841] type 01 class 0x060400
[    0.275831] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
[    0.275944] pci 0000:00:1d.0: [8086:2830] type 00 class 0x0c0300
[    0.275983] pci 0000:00:1d.0: reg 0x20: [io  0xd880-0xd89f]
[    0.276108] pci 0000:00:1d.1: [8086:2831] type 00 class 0x0c0300
[    0.276149] pci 0000:00:1d.1: reg 0x20: [io  0xd800-0xd81f]
[    0.276273] pci 0000:00:1d.2: [8086:2832] type 00 class 0x0c0300
[    0.276312] pci 0000:00:1d.2: reg 0x20: [io  0xd480-0xd49f]
[    0.276440] pci 0000:00:1d.7: [8086:2836] type 00 class 0x0c0320
[    0.276465] pci 0000:00:1d.7: reg 0x10: [mem 0xff9fb000-0xff9fb3ff]
[    0.276531] pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
[    0.276634] pci 0000:00:1e.0: [8086:244e] type 01 class 0x060401
[    0.276776] pci 0000:00:1f.0: [8086:2810] type 00 class 0x060100
[    0.276858] pci 0000:00:1f.0: quirk: [io  0x0800-0x087f] claimed by 
ICH6 ACPI/GPIO/TCO
[    0.276863] pci 0000:00:1f.0: quirk: [io  0x0480-0x04bf] claimed by 
ICH6 GPIO
[    0.276867] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 1 PIO at 
0a00 (mask 00ff)
[    0.276996] pci 0000:00:1f.2: [8086:2821] type 00 class 0x010601
[    0.277021] pci 0000:00:1f.2: reg 0x10: [io  0xe880-0xe887]
[    0.277029] pci 0000:00:1f.2: reg 0x14: [io  0xe800-0xe803]
[    0.277036] pci 0000:00:1f.2: reg 0x18: [io  0xe480-0xe487]
[    0.277044] pci 0000:00:1f.2: reg 0x1c: [io  0xe400-0xe403]
[    0.277052] pci 0000:00:1f.2: reg 0x20: [io  0xe080-0xe09f]
[    0.277060] pci 0000:00:1f.2: reg 0x24: [mem 0xff9fb800-0xff9fbfff]
[    0.277088] pci 0000:00:1f.2: PME# supported from D3hot
[    0.277193] pci 0000:00:1f.3: [8086:283e] type 00 class 0x0c0500
[    0.277208] pci 0000:00:1f.3: reg 0x10: [mem 0xff9fac00-0xff9facff]
[    0.277233] pci 0000:00:1f.3: reg 0x20: [io  0x0400-0x041f]
[    0.277422] pci 0000:01:00.0: [11ab:4362] type 00 class 0x020000
[    0.277461] pci 0000:01:00.0: reg 0x10: [mem 0xff6fc000-0xff6fffff 64bit]
[    0.277473] pci 0000:01:00.0: reg 0x18: [io  0xb800-0xb8ff]
[    0.277514] pci 0000:01:00.0: reg 0x30: [mem 0xff6c0000-0xff6dffff pref]
[    0.277556] pci 0000:01:00.0: supports D1 D2
[    0.277558] pci 0000:01:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.277624] pci 0000:01:00.0: disabling ASPM on pre-1.1 PCIe device.  
You can enable it with 'pcie_aspm=force'
[    0.277638] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.277642] pci 0000:00:1c.0:   bridge window [io 0xb000-0xbfff]
[    0.277646] pci 0000:00:1c.0:   bridge window [mem 0xff600000-0xff6fffff]
[    0.277726] pci 0000:02:00.0: [11ab:4362] type 00 class 0x020000
[    0.277765] pci 0000:02:00.0: reg 0x10: [mem 0xff7fc000-0xff7fffff 64bit]
[    0.277777] pci 0000:02:00.0: reg 0x18: [io  0xc800-0xc8ff]
[    0.277818] pci 0000:02:00.0: reg 0x30: [mem 0xff7c0000-0xff7dffff pref]
[    0.277861] pci 0000:02:00.0: supports D1 D2
[    0.277863] pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.277931] pci 0000:02:00.0: disabling ASPM on pre-1.1 PCIe device.  
You can enable it with 'pcie_aspm=force'
[    0.277942] pci 0000:00:1c.1: PCI bridge to [bus 02]
[    0.277946] pci 0000:00:1c.1:   bridge window [io 0xc000-0xcfff]
[    0.277950] pci 0000:00:1c.1:   bridge window [mem 0xff700000-0xff7fffff]
[    0.278041] pci 0000:00:1e.0: PCI bridge to [bus 03] (subtractive decode)
[    0.278050] pci 0000:00:1e.0:   bridge window [io 0x0000-0x0cf7 
window] (subtractive decode)
[    0.278053] pci 0000:00:1e.0:   bridge window [io 0x0d00-0xffff 
window] (subtractive decode)
[    0.278055] pci 0000:00:1e.0:   bridge window [mem 
0x000a0000-0x000bffff window] (subtractive decode)
[    0.278058] pci 0000:00:1e.0:   bridge window [mem 
0x000d0000-0x000dffff window] (subtractive decode)
[    0.278060] pci 0000:00:1e.0:   bridge window [mem 
0xaff00000-0xffffffff window] (subtractive decode)
[    0.278075] pci_bus 0000:00: on NUMA node 0
[    0.278919] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 
14 15)
[    0.278977] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 
14 15)
[    0.279038] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 11 12 
*14 15)
[    0.279094] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 10 11 12 
14 15)
[    0.279150] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 
14 15) *0, disabled.
[    0.279207] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 
14 *15)
[    0.279262] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 *7 10 11 12 
14 15)
[    0.279318] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 *10 11 12 
14 15)
[    0.279387] ACPI: Enabled 2 GPEs in block 00 to 1F
[    0.279616] SCSI subsystem initialized
[    0.279653] libata version 3.00 loaded.
[    0.279663] ACPI: bus type USB registered
[    0.279729] usbcore: registered new interface driver usbfs
[    0.279754] usbcore: registered new interface driver hub
[    0.279779] usbcore: registered new device driver usb
[    0.279839] pps_core: LinuxPPS API ver. 1 registered
[    0.279840] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 
Rodolfo Giometti <giometti@linux.it>
[    0.279852] PTP clock support registered
[    0.280054] Advanced Linux Sound Architecture Driver Initialized.
[    0.280077] PCI: Using ACPI for IRQ routing
[    0.280081] PCI: pci_cache_line_size set to 64 bytes
[    0.280129] Expanded resource reserved due to conflict with PCI Bus 
0000:00
[    0.280131] e820: reserve RAM buffer [mem 0x0009cc00-0x0009ffff]
[    0.280133] e820: reserve RAM buffer [mem 0xafeb0000-0xafffffff]
[    0.280388] Bluetooth: Core ver 2.21
[    0.280402] NET: Registered protocol family 31
[    0.280404] Bluetooth: HCI device and connection manager initialized
[    0.280408] Bluetooth: HCI socket layer initialized
[    0.280412] Bluetooth: L2CAP socket layer initialized
[    0.280420] Bluetooth: SCO socket layer initialized
[    0.280665] clocksource: Switched to clocksource refined-jiffies
[    0.280697] FS-Cache: Loaded
[    0.280697] pnp: PnP ACPI init
[    0.280697] system 00:00: [mem 0xfed14000-0xfed19fff] has been reserved
[    0.280697] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.281011] pnp 00:01: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.281026] pnp 00:02: Plug and Play ACPI device, IDs PNP0303 PNP030b 
(active)
[    0.281164] pnp 00:03: [dma 0 disabled]
[    0.281226] pnp 00:03: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.281413] pnp 00:04: [dma 0 disabled]
[    0.281497] pnp 00:04: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.281778] system 00:05: [io  0x0a00-0x0a0f] has been reserved
[    0.281781] system 00:05: [io  0x0a10-0x0a1f] has been reserved
[    0.281785] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.282006] system 00:06: [io  0x04d0-0x04d1] has been reserved
[    0.282006] system 00:06: [io  0x0800-0x087f] has been reserved
[    0.282006] system 00:06: [io  0x0480-0x04bf] has been reserved
[    0.282006] system 00:06: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    0.282006] system 00:06: [mem 0xfed20000-0xfed8ffff] has been reserved
[    0.282006] system 00:06: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.282034] system 00:07: [mem 0xffc00000-0xffefffff] has been reserved
[    0.282038] system 00:07: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.282119] system 00:08: [mem 0xfec00000-0xfec00fff] could not be 
reserved
[    0.282123] system 00:08: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.282126] system 00:08: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.282193] system 00:09: [mem 0xe0000000-0xefffffff] has been reserved
[    0.282197] system 00:09: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.282376] system 00:0a: [mem 0x00000000-0x0009ffff] could not be 
reserved
[    0.282379] system 00:0a: [mem 0x000c0000-0x000cffff] could not be 
reserved
[    0.282382] system 00:0a: [mem 0x000e0000-0x000fffff] could not be 
reserved
[    0.282385] system 00:0a: [mem 0x00100000-0xafefffff] could not be 
reserved
[    0.282388] system 00:0a: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.282508] pnp: PnP ACPI: found 11 devices
[    0.290447] clocksource: acpi_pm: mask: 0xffffff max_cycles: 
0xffffff, max_idle_ns: 2085701024 ns
[    0.290465] clocksource: Switched to clocksource acpi_pm
[    0.290488] pci 0000:00:1c.0: bridge window [mem 
0x00100000-0x000fffff 64bit pref] to [bus 01] add_size 200000 add_align 
100000
[    0.290497] pci 0000:00:1c.1: bridge window [mem 
0x00100000-0x000fffff 64bit pref] to [bus 02] add_size 200000 add_align 
100000
[    0.290513] pci 0000:00:1c.0: res[9]=[mem 0x00100000-0x000fffff 64bit 
pref] res_to_dev_res add_size 200000 min_align 100000
[    0.290516] pci 0000:00:1c.0: res[9]=[mem 0x00100000-0x002fffff 64bit 
pref] res_to_dev_res add_size 200000 min_align 100000
[    0.290519] pci 0000:00:1c.1: res[9]=[mem 0x00100000-0x000fffff 64bit 
pref] res_to_dev_res add_size 200000 min_align 100000
[    0.290522] pci 0000:00:1c.1: res[9]=[mem 0x00100000-0x002fffff 64bit 
pref] res_to_dev_res add_size 200000 min_align 100000
[    0.290533] pci 0000:00:1c.0: BAR 9: assigned [mem 
0xb0000000-0xb01fffff 64bit pref]
[    0.290538] pci 0000:00:1c.1: BAR 9: assigned [mem 
0xb0200000-0xb03fffff 64bit pref]
[    0.290542] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.290546] pci 0000:00:1c.0:   bridge window [io 0xb000-0xbfff]
[    0.290551] pci 0000:00:1c.0:   bridge window [mem 0xff600000-0xff6fffff]
[    0.290555] pci 0000:00:1c.0:   bridge window [mem 
0xb0000000-0xb01fffff 64bit pref]
[    0.290560] pci 0000:00:1c.1: PCI bridge to [bus 02]
[    0.290563] pci 0000:00:1c.1:   bridge window [io 0xc000-0xcfff]
[    0.290568] pci 0000:00:1c.1:   bridge window [mem 0xff700000-0xff7fffff]
[    0.290572] pci 0000:00:1c.1:   bridge window [mem 
0xb0200000-0xb03fffff 64bit pref]
[    0.290578] pci 0000:00:1e.0: PCI bridge to [bus 03]
[    0.290589] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.290592] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.290594] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff 
window]
[    0.290597] pci_bus 0000:00: resource 7 [mem 0x000d0000-0x000dffff 
window]
[    0.290599] pci_bus 0000:00: resource 8 [mem 0xaff00000-0xffffffff 
window]
[    0.290601] pci_bus 0000:01: resource 0 [io  0xb000-0xbfff]
[    0.290604] pci_bus 0000:01: resource 1 [mem 0xff600000-0xff6fffff]
[    0.290606] pci_bus 0000:01: resource 2 [mem 0xb0000000-0xb01fffff 
64bit pref]
[    0.290609] pci_bus 0000:02: resource 0 [io  0xc000-0xcfff]
[    0.290611] pci_bus 0000:02: resource 1 [mem 0xff700000-0xff7fffff]
[    0.290613] pci_bus 0000:02: resource 2 [mem 0xb0200000-0xb03fffff 
64bit pref]
[    0.290616] pci_bus 0000:03: resource 4 [io  0x0000-0x0cf7 window]
[    0.290618] pci_bus 0000:03: resource 5 [io  0x0d00-0xffff window]
[    0.290621] pci_bus 0000:03: resource 6 [mem 0x000a0000-0x000bffff 
window]
[    0.290623] pci_bus 0000:03: resource 7 [mem 0x000d0000-0x000dffff 
window]
[    0.290625] pci_bus 0000:03: resource 8 [mem 0xaff00000-0xffffffff 
window]
[    0.290668] NET: Registered protocol family 2
[    0.290856] TCP established hash table entries: 65536 (order: 7, 
524288 bytes)
[    0.290856] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.291257] TCP: Hash tables configured (established 65536 bind 65536)
[    0.291334] UDP hash table entries: 4096 (order: 5, 131072 bytes)
[    0.291400] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes)
[    0.291565] NET: Registered protocol family 1
[    0.291724] RPC: Registered named UNIX socket transport module.
[    0.291726] RPC: Registered udp transport module.
[    0.291728] RPC: Registered tcp transport module.
[    0.291729] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.291748] pci 0000:00:02.0: Video device with shadowed ROM
[    0.418229] PCI: CLS 32 bytes, default 64
[    0.418315] Unpacking initramfs...
[    1.105273] Freeing initrd memory: 4488K
[    1.105293] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    1.105295] software IO TLB: mapped [mem 0xabeb0000-0xafeb0000] (64MB)
[    1.108094] audit: initializing netlink subsys (disabled)
[    1.108114] audit: type=2000 audit(1627140346.107:1): initialized
[    1.123169] VFS: Disk quotas dquot_6.6.0
[    1.123267] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 
bytes)
[    1.145263] NFS: Registering the id_resolver key type
[    1.145274] Key type id_resolver registered
[    1.145276] Key type id_legacy registered
[    1.145280] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[    1.150225] Key type cifs.spnego registered
[    1.150236] Key type cifs.idmap registered
[    1.150324] fuse init (API version 7.23)
[    1.155407] NET: Registered protocol family 38
[    1.155419] async_tx: api initialized (async)
[    1.155513] Block layer SCSI generic (bsg) driver version 0.4 loaded 
(major 251)
[    1.156387] io scheduler noop registered
[    1.156391] io scheduler deadline registered
[    1.156444] io scheduler cfq registered (default)
[    1.156532] io scheduler bfq registered
[    1.156534] BFQ I/O-scheduler: v7r11
[    1.156602] gpio_it87: no device
[    1.160273] intel_idle: does not run on family 6 model 23
[    1.160381] input: Power Button as 
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    1.160388] ACPI: Power Button [PWRB]
[    1.160449] input: Power Button as 
/devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    1.160452] ACPI: Power Button [PWRF]
[    1.160675] ioatdma: Intel(R) QuickData Technology Driver 4.00
[    1.160797] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    1.181353] 00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) 
is a 16550A
[    1.201959] 00:04: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) 
is a 16550A
[    1.202442] Linux agpgart interface v0.103
[    1.202489] agpgart-intel 0000:00:00.0: Intel 965Q Chipset
[    1.202512] agpgart-intel 0000:00:00.0: detected gtt size: 524288K 
total, 262144K mappable
[    1.203033] agpgart-intel 0000:00:00.0: detected 1024K stolen memory
[    1.203148] agpgart-intel 0000:00:00.0: AGP aperture is 256M @ 0xd0000000
[    1.203212] [drm] Initialized drm 1.1.0 20060810
[    1.203799] [drm] Memory usable by graphics device = 512M
[    1.203801] [drm] Replacing VGA console driver
[    1.204623] Console: switching to colour dummy device 80x25
[    1.204641] pmd_set_huge: Cannot satisfy [mem 0xd0000000-0xd0200000] 
with a huge-page mapping due to MTRR override.
[    1.211369] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    1.211373] [drm] Driver supports precise vblank timestamp query.
[    1.222841] [drm] initialized overlay support
[    1.222924] [drm] Initialized i915 1.6.0 20151010 for 0000:00:02.0 on 
minor 0
[    1.229427] loop: module loaded
[    1.229711] gpio_ich: GPIO from 462 to 511 on gpio_ich
[    1.229830] mpt3sas version 12.100.00.00 loaded
[    1.238950] ahci 0000:00:1f.2: version 3.0
[    1.239197] ahci 0000:00:1f.2: SSS flag set, parallel bus scan disabled
[    1.239229] ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 6 ports 3 Gbps 
0x3f impl SATA mode
[    1.239233] ahci 0000:00:1f.2: flags: 64bit ncq sntf stag pm led clo 
pio slum part ccc ems sxs
[    1.239290] do_marvell_9170_recover: ignoring PCI device (8086:2821) 
at PCI#0
[    1.239338] do_marvell_9170_recover: ignoring PCI device (8086:2821) 
at PCI#0
[    1.241096] do_marvell_9170_recover: ignoring PCI device (8086:2821) 
at PCI#0
[    1.243068] do_marvell_9170_recover: ignoring PCI device (8086:2821) 
at PCI#0
[    1.245072] do_marvell_9170_recover: ignoring PCI device (8086:2821) 
at PCI#0
[    1.247073] do_marvell_9170_recover: ignoring PCI device (8086:2821) 
at PCI#0
[    1.255724] scsi host0: ahci
[    1.256664] scsi host1: ahci
[    1.257520] scsi host2: ahci
[    1.258508] scsi host3: ahci
[    1.259363] scsi host4: ahci
[    1.260195] scsi host5: ahci
[    1.260268] ata1: SATA max UDMA/133 abar m2048@0xff9fb800 port 
0xff9fb900 irq 25
[    1.260272] ata2: SATA max UDMA/133 abar m2048@0xff9fb800 port 
0xff9fb980 irq 25
[    1.260274] ata3: SATA max UDMA/133 abar m2048@0xff9fb800 port 
0xff9fba00 irq 25
[    1.260277] ata4: SATA max UDMA/133 abar m2048@0xff9fb800 port 
0xff9fba80 irq 25
[    1.260279] ata5: SATA max UDMA/133 abar m2048@0xff9fb800 port 
0xff9fbb00 irq 25
[    1.260281] ata6: SATA max UDMA/133 abar m2048@0xff9fb800 port 
0xff9fbb80 irq 25
[    1.260559] Rounding down aligned max_sectors from 4294967295 to 
4294967288
[    1.261822] Ethernet Channel Bonding Driver: v3.7.1 (April 27, 2011)
[    1.261849] tun: Universal TUN/TAP device driver, 1.6
[    1.261850] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[    1.261926] e1000: Intel(R) PRO/1000 Network Driver - version 
7.3.21-k8-NAPI
[    1.261928] e1000: Copyright (c) 1999-2006 Intel Corporation.
[    1.261962] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[    1.261963] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    1.261987] igb: Intel(R) Gigabit Ethernet Network Driver - version 
5.3.0-k
[    1.261989] igb: Copyright (c) 2007-2014 Intel Corporation.
[    1.262024] Intel(R) 10GbE PCI Express Linux Network Driver - version 
5.3.8
[    1.262026] Copyright(c) 1999 - 2018 Intel Corporation.
[    1.263945] i40e: Intel(R) 40-10 Gigabit Ethernet Connection Network 
Driver - version 2.4.10
[    1.263947] i40e: Copyright(c) 2013 - 2018 Intel Corporation.
[    1.264189] bnx2x: QLogic 5771x/578xx 10/20-Gigabit Ethernet Driver 
bnx2x 1.712.30-0 (2014/02/10)
[    1.265063] sk98lin: Network Device Driver v10.93.3.3
(C)Copyright 1999-2012 Marvell(R).
[    1.319877] eth0: Marvell Yukon 88E8053 Gigabit Ethernet Controller
[    1.374756] eth1: Marvell Yukon 88E8053 Gigabit Ethernet Controller
[    1.374792] Fusion MPT base driver 3.04.20
[    1.374793] Copyright (c) 1999-2008 LSI Corporation
[    1.374804] Fusion MPT SAS Host driver 3.04.20
[    1.374841] Fusion MPT misc device (ioctl) driver 3.04.20
[    1.375658] mptctl: Registered with Fusion MPT base driver
[    1.375661] mptctl: /dev/mptctl @ (major,minor=10,220)
[    1.375667] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.375675] ehci-pci: EHCI PCI platform driver
[    1.375828] ehci-pci 0000:00:1a.7: EHCI Host Controller
[    1.375839] ehci-pci 0000:00:1a.7: new USB bus registered, assigned 
bus number 1
[    1.375851] ehci-pci 0000:00:1a.7: debug port 1
[    1.379772] ehci-pci 0000:00:1a.7: cache line size of 32 is not supported
[    1.379789] ehci-pci 0000:00:1a.7: irq 18, io mem 0xff9fb400
[    1.385026] ehci-pci 0000:00:1a.7: USB 2.0 started, EHCI 1.00
[    1.385395] hub 1-0:1.0: USB hub found
[    1.385404] hub 1-0:1.0: 4 ports detected
[    1.385715] ehci-pci 0000:00:1d.7: EHCI Host Controller
[    1.385723] ehci-pci 0000:00:1d.7: new USB bus registered, assigned 
bus number 2
[    1.385735] ehci-pci 0000:00:1d.7: debug port 1
[    1.389660] ehci-pci 0000:00:1d.7: cache line size of 32 is not supported
[    1.389677] ehci-pci 0000:00:1d.7: irq 23, io mem 0xff9fb000
[    1.395034] ehci-pci 0000:00:1d.7: USB 2.0 started, EHCI 1.00
[    1.395326] hub 2-0:1.0: USB hub found
[    1.395335] hub 2-0:1.0: 6 ports detected
[    1.395519] uhci_hcd: USB Universal Host Controller Interface driver
[    1.395621] uhci_hcd 0000:00:1a.0: UHCI Host Controller
[    1.395628] uhci_hcd 0000:00:1a.0: new USB bus registered, assigned 
bus number 3
[    1.395635] uhci_hcd 0000:00:1a.0: detected 2 ports
[    1.395662] uhci_hcd 0000:00:1a.0: irq 16, io base 0x0000e000
[    1.395827] hub 3-0:1.0: USB hub found
[    1.395837] hub 3-0:1.0: 2 ports detected
[    1.395993] uhci_hcd 0000:00:1a.1: UHCI Host Controller
[    1.396000] uhci_hcd 0000:00:1a.1: new USB bus registered, assigned 
bus number 4
[    1.396018] uhci_hcd 0000:00:1a.1: detected 2 ports
[    1.396042] uhci_hcd 0000:00:1a.1: irq 21, io base 0x0000dc00
[    1.396202] hub 4-0:1.0: USB hub found
[    1.396209] hub 4-0:1.0: 2 ports detected
[    1.396365] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[    1.396372] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned 
bus number 5
[    1.396379] uhci_hcd 0000:00:1d.0: detected 2 ports
[    1.396397] uhci_hcd 0000:00:1d.0: irq 23, io base 0x0000d880
[    1.396558] hub 5-0:1.0: USB hub found
[    1.396565] hub 5-0:1.0: 2 ports detected
[    1.396717] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[    1.396723] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned 
bus number 6
[    1.396729] uhci_hcd 0000:00:1d.1: detected 2 ports
[    1.396755] uhci_hcd 0000:00:1d.1: irq 19, io base 0x0000d800
[    1.396912] hub 6-0:1.0: USB hub found
[    1.396920] hub 6-0:1.0: 2 ports detected
[    1.397107] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[    1.397113] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned 
bus number 7
[    1.397120] uhci_hcd 0000:00:1d.2: detected 2 ports
[    1.397138] uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000d480
[    1.397298] hub 7-0:1.0: USB hub found
[    1.397306] hub 7-0:1.0: 2 ports detected
[    1.397517] usbcore: registered new interface driver cdc_acm
[    1.397518] cdc_acm: USB Abstract Control Model driver for USB modems 
and ISDN adapters
[    1.397543] usbcore: registered new interface driver usblp
[    1.397585] usbcore: registered new interface driver usb-storage
[    1.397646] i8042: PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
[    1.397648] i8042: PNP: PS/2 appears to have AUX port disabled, if 
this is incorrect please boot with i8042.nopnp
[    1.398391] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.398620] rtc_cmos 00:01: RTC can wake from S4
[    1.398782] rtc_cmos 00:01: rtc core: registered rtc_cmos as rtc0
[    1.398806] rtc_cmos 00:01: alarms up to one month, y3k, 114 bytes nvram
[    1.398822] i2c /dev entries driver
[    1.401531] i801_smbus 0000:00:1f.3: SMBus using PCI interrupt
[    1.407698] w83627ehf: Found W83627DHG chip at 0xa10
[    1.408101] md: raid0 personality registered for level 0
[    1.408104] md: raid1 personality registered for level 1
[    1.408107] md: raid10 personality registered for level 10
[    1.413368] md: raid6 personality registered for level 6
[    1.413371] md: raid5 personality registered for level 5
[    1.413372] md: raid4 personality registered for level 4
[    1.413548] device-mapper: ioctl: 4.34.0-ioctl (2015-10-28) 
initialised: dm-devel@redhat.com
[    1.417885] usbcore: registered new interface driver btusb
[    1.417969] usbcore: registered new interface driver usbhid
[    1.417970] usbhid: USB HID core driver
[    1.418287] ip_tables: (C) 2000-2006 Netfilter Core Team
[    1.418559] NET: Registered protocol family 10
[    1.420495] NET: Registered protocol family 17
[    1.420520] 8021q: 802.1Q VLAN Support v1.8
[    1.420536] Key type dns_resolver registered
[    1.420754] readynas_io_init: initializing ReadyNAS I/O.
[    1.420756] procfs_init: initializing ReadyNAS procfs.
[    1.420764] ReadyNAS model: To Be Filled By O.E.M.
[    1.420794] pwr_button_state_init: initializing ReadyNAS PWR button 
state handler .
[    1.420801] button_init: initializing ReadyNAS button set.
[    1.420803] __button_init: button 'backup' gpio_ich:15 (POLL)
[    1.420815] __button_init: button 'reset' gpio_ich:8 (POLL)
[    1.424238] snd_hda_intel 0000:00:1b.0: no codecs found!
[    1.425116] input: rn_button as /devices/virtual/input/input3
[    1.426435] readynas_io_init: initialization successfully completed.
[    1.426538] readynas_lcd_init: installing ReadyNAS LCD driver.
[    1.426626] readynas_led_init: installing ReadyNAS LED driver.
[    1.426858] register_led: registering LED "readynas:green:backup"
[    1.427133] microcode: CPU0 sig=0x1067a, pf=0x1, revision=0xa07
[    1.426803] microcode: CPU1 sig=0x1067a, pf=0x1, revision=0xa07
[    1.429653] microcode: Microcode Update Driver: v2.01 
<tigran@aivazian.fsnet.co.uk>, Peter Oruba
[    1.429931] registered taskstats version 1
[    1.435263] Btrfs loaded, crc32c=crc32c-generic
[    1.438819] rtc_cmos 00:01: setting system clock to 2021-07-24 
15:25:46 UTC (1627140346)
[    1.438949] ALSA device list:
[    1.438951]   No soundcards found.
[    1.565027] do_marvell_9170_recover: ignoring PCI device (8086:2821) 
at PCI#0
[    1.565040] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.565665] ata1.00: ATA-9: WDC WD60EFRX-68L0BN1, 82.00A82, max UDMA/133
[    1.565670] ata1.00: 11721045168 sectors, multi 0: LBA48 NCQ (depth 
31/32), AA
[    1.566335] ata1.00: configured for UDMA/133
[    1.566545] scsi 0:0:0:0: Direct-Access     ATA      WDC WD60EFRX-68L 
0A82 PQ: 0 ANSI: 5
[    1.566806] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    1.566881] sd 0:0:0:0: [sda] 11721045168 512-byte logical blocks: 
(6.00 TB/5.46 TiB)
[    1.566884] sd 0:0:0:0: [sda] 4096-byte physical blocks
[    1.566942] sd 0:0:0:0: [sda] Write Protect is off
[    1.566945] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    1.566969] sd 0:0:0:0: [sda] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[    1.604742]  sda: sda1 sda2 sda3 sda4
[    1.605341] sd 0:0:0:0: [sda] Attached SCSI disk
[    1.697027] usb 2-1: new high-speed USB device number 2 using ehci-pci
[    1.813136] usb-storage 2-1:1.0: USB Mass Storage device detected
[    1.813871] usb-storage 2-1:1.0: Quirks match for vid 090c pid 1000: 400
[    1.813903] scsi host6: usb-storage 2-1:1.0
[    1.871027] do_marvell_9170_recover: ignoring PCI device (8086:2821) 
at PCI#0
[    1.871041] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.875793] ata2.00: ATA-9: WDC WD120EFAX-68UNTN0, 81.00A81, max UDMA/133
[    1.875798] ata2.00: 23437770752 sectors, multi 0: LBA48 NCQ (depth 
31/32), AA
[    1.883545] ata2.00: configured for UDMA/133
[    1.883794] scsi 1:0:0:0: Direct-Access     ATA      WDC WD120EFAX-68 
0A81 PQ: 0 ANSI: 5
[    1.884214] sd 1:0:0:0: [sdb] 23437770752 512-byte logical blocks: 
(12.0 TB/10.9 TiB)
[    1.884217] sd 1:0:0:0: [sdb] 4096-byte physical blocks
[    1.884271] sd 1:0:0:0: [sdb] Write Protect is off
[    1.884274] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    1.884298] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[    1.884591] sd 1:0:0:0: Attached scsi generic sg1 type 0
[    1.938400]  sdb: sdb1 sdb2 sdb3 sdb4 sdb5
[    1.939040] sd 1:0:0:0: [sdb] Attached SCSI disk
[    2.108030] tsc: Refined TSC clocksource calibration: 2593.498 MHz
[    2.108039] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 
0x25623df34f9, max_idle_ns: 440795316624 ns
[    2.189029] do_marvell_9170_recover: ignoring PCI device (8086:2821) 
at PCI#0
[    2.189044] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    2.193388] ata3.00: ATA-9: WDC WD120EFBX-68B0EN0, 85.00A85, max UDMA/133
[    2.193394] ata3.00: 23437770752 sectors, multi 0: LBA48 NCQ (depth 
31/32), AA
[    2.200775] ata3.00: configured for UDMA/133
[    2.201037] scsi 2:0:0:0: Direct-Access     ATA      WDC WD120EFBX-68 
0A85 PQ: 0 ANSI: 5
[    2.201338] sd 2:0:0:0: [sdc] 23437770752 512-byte logical blocks: 
(12.0 TB/10.9 TiB)
[    2.201341] sd 2:0:0:0: [sdc] 4096-byte physical blocks
[    2.201393] sd 2:0:0:0: Attached scsi generic sg2 type 0
[    2.201411] sd 2:0:0:0: [sdc] Write Protect is off
[    2.201414] sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[    2.201445] sd 2:0:0:0: [sdc] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[    2.259352]  sdc: sdc1 sdc2 sdc3 sdc4 sdc5
[    2.259963] sd 2:0:0:0: [sdc] Attached SCSI disk
[    2.506028] do_marvell_9170_recover: ignoring PCI device (8086:2821) 
at PCI#0
[    2.506043] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    2.506670] ata4.00: ATA-9: WDC WD60EFRX-68L0BN1, 82.00A82, max UDMA/133
[    2.506676] ata4.00: 11721045168 sectors, multi 0: LBA48 NCQ (depth 
31/32), AA
[    2.507326] ata4.00: configured for UDMA/133
[    2.507529] scsi 3:0:0:0: Direct-Access     ATA      WDC WD60EFRX-68L 
0A82 PQ: 0 ANSI: 5
[    2.507824] sd 3:0:0:0: [sdd] 11721045168 512-byte logical blocks: 
(6.00 TB/5.46 TiB)
[    2.507827] sd 3:0:0:0: [sdd] 4096-byte physical blocks
[    2.507885] sd 3:0:0:0: Attached scsi generic sg3 type 0
[    2.507906] sd 3:0:0:0: [sdd] Write Protect is off
[    2.507909] sd 3:0:0:0: [sdd] Mode Sense: 00 3a 00 00
[    2.507939] sd 3:0:0:0: [sdd] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[    2.562670]  sdd: sdd1 sdd2 sdd3 sdd4
[    2.563263] sd 3:0:0:0: [sdd] Attached SCSI disk
[    2.813029] do_marvell_9170_recover: ignoring PCI device (8086:2821) 
at PCI#0
[    2.813043] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    2.817402] ata5.00: ATA-9: WDC WD120EFBX-68B0EN0, 85.00A85, max UDMA/133
[    2.817409] ata5.00: 23437770752 sectors, multi 0: LBA48 NCQ (depth 
31/32), AA
[    2.824784] ata5.00: configured for UDMA/133
[    2.825050] scsi 4:0:0:0: Direct-Access     ATA      WDC WD120EFBX-68 
0A85 PQ: 0 ANSI: 5
[    2.825313] sd 4:0:0:0: [sde] 23437770752 512-byte logical blocks: 
(12.0 TB/10.9 TiB)
[    2.825316] sd 4:0:0:0: Attached scsi generic sg4 type 0
[    2.825316] sd 4:0:0:0: [sde] 4096-byte physical blocks
[    2.825370] sd 4:0:0:0: [sde] Write Protect is off
[    2.825373] sd 4:0:0:0: [sde] Mode Sense: 00 3a 00 00
[    2.825401] sd 4:0:0:0: [sde] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[    2.878945]  sde: sde1 sde2 sde3 sde4 sde5
[    2.879573] sd 4:0:0:0: [sde] Attached SCSI disk
[    3.108128] clocksource: Switched to clocksource tsc
[    3.130015] do_marvell_9170_recover: ignoring PCI device (8086:2821) 
at PCI#0
[    3.130029] ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    3.134484] ata6.00: ATA-9: WDC WD120EFBX-68B0EN0, 85.00A85, max UDMA/133
[    3.134489] ata6.00: 23437770752 sectors, multi 0: LBA48 NCQ (depth 
31/32), AA
[    3.141860] ata6.00: configured for UDMA/133
[    3.142103] scsi 5:0:0:0: Direct-Access     ATA      WDC WD120EFBX-68 
0A85 PQ: 0 ANSI: 5
[    3.142353] sd 5:0:0:0: [sdf] 23437770752 512-byte logical blocks: 
(12.0 TB/10.9 TiB)
[    3.142356] sd 5:0:0:0: [sdf] 4096-byte physical blocks
[    3.142373] sd 5:0:0:0: Attached scsi generic sg5 type 0
[    3.142400] sd 5:0:0:0: [sdf] Write Protect is off
[    3.142403] sd 5:0:0:0: [sdf] Mode Sense: 00 3a 00 00
[    3.142424] sd 5:0:0:0: [sdf] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[    3.195184]  sdf: sdf1 sdf2 sdf3 sdf4 sdf5
[    3.195747] sd 5:0:0:0: [sdf] Attached SCSI disk
[    3.196630] Freeing unused kernel memory: 872K
[    3.200342] vpd: loading out-of-tree module taints kernel.
[    3.200347] vpd: module license 'Proprietary' taints kernel.
[    3.200349] Disabling lock debugging due to kernel taint
[    3.200498] ReadyNAS VPD init
[    6.768022] nv6lcd v3.1 loaded.
[    6.816879] scsi 6:0:0:0: Direct-Access     SMI      USB DISK         
1100 PQ: 0 ANSI: 0 CCS
[    6.817295] sd 6:0:0:0: Attached scsi generic sg6 type 0
[    6.817298] sd 6:0:0:0: Embedded Enclosure Device
[    6.818357] sd 6:0:0:0: Wrong diagnostic page; asked for 1 got 0
[    6.824384] sd 6:0:0:0: Failed to get diagnostic page 0xffffffea
[    6.830398] sd 6:0:0:0: Failed to bind enclosure -19
[    6.835485] sd 6:0:0:0: [sdg] 250880 512-byte logical blocks: (128 
MB/123 MiB)
[    6.836368] sd 6:0:0:0: [sdg] Write Protect is off
[    6.836376] sd 6:0:0:0: [sdg] Mode Sense: 43 00 00 00
[    6.837237] sd 6:0:0:0: [sdg] No Caching mode page found
[    6.842555] sd 6:0:0:0: [sdg] Assuming drive cache: write through
[    6.852620]  sdg: sdg1
[    6.854859] sd 6:0:0:0: [sdg] Attached SCSI removable disk
[   16.057072] random: nonblocking pool is initialized
[   19.467741] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[   19.470649] IPv6: ADDRCONF(NETDEV_UP): eth1: link is not ready
[   22.006918] eth0: network connection up using port A
[   22.006918]     interrupt src:   MSI
[   22.006918]     speed:           1000
[   22.006918]     autonegotiation: yes
[   22.006918]     duplex mode:     full
[   22.006918]     flowctrl:        symmetric
[   22.006918]     role:            master
[   22.006918]     tcp offload:     enabled
[   22.006918]     scatter-gather:  enabled
[   22.006918]     tx-checksum:     enabled
[   22.006918]     rx-checksum:     enabled
[   22.006918]     rx-polling:      enabled
[   22.006918] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   22.279559] eth1: network connection up using port A
[   22.279559]     interrupt src:   MSI
[   22.279559]     speed:           1000
[   22.279559]     autonegotiation: yes
[   22.279559]     duplex mode:     full
[   22.279559]     flowctrl:        symmetric
[   22.279559]     role:            master
[   22.279559]     tcp offload:     enabled
[   22.279559]     scatter-gather:  enabled
[   22.279559]     tx-checksum:     enabled
[   22.279559]     rx-checksum:     enabled
[   22.279559]     rx-polling:      enabled
[   22.279559] IPv6: ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready
[   24.278922] md: md0 stopped.
[   24.279889] md: bind<sdb1>
[   24.280018] md: bind<sdc1>
[   24.280153] md: bind<sdd1>
[   24.280344] md: bind<sde1>
[   24.280538] md: bind<sdf1>
[   24.280666] md: bind<sda1>
[   24.283504] md/raid1:md0: active with 6 out of 6 mirrors
[   24.283565] md0: detected capacity change from 0 to 4290772992
[   24.321956] md: md1 stopped.
[   24.323595] md: bind<sdb2>
[   24.323841] md: bind<sdc2>
[   24.323985] md: bind<sdd2>
[   24.324226] md: bind<sde2>
[   24.324440] md: bind<sdf2>
[   24.324651] md: bind<sda2>
[   24.325368] md/raid10:md1: active with 6 out of 6 devices
[   24.325437] md1: detected capacity change from 0 to 1604321280
[   24.724766] BTRFS: device label 33eb0773:root devid 1 transid 2759165 
/dev/md0
[   24.725248] BTRFS info (device md0): has skinny extents
[   25.619341] systemd[1]: Failed to insert module 'kdbus': Function not 
implemented
[   25.639249] systemd[1]: systemd 230 running in system mode. (+PAM 
+AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP 
+GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN)
[   25.639425] systemd[1]: Detected architecture x86-64.
[   25.644102] systemd[1]: Set hostname to <Pro>.
[   25.764051] systemd[1]: systemd-journald-audit.socket: Cannot add 
dependency job, ignoring: Unit systemd-journald-audit.socket is masked.
[   25.764122] systemd[1]: systemd-journald-audit.socket: Cannot add 
dependency job, ignoring: Unit systemd-journald-audit.socket is masked.
[   25.764873] systemd[1]: Listening on udev Kernel Socket.
[   25.771147] systemd[1]: Listening on /dev/initctl Compatibility Named 
Pipe.
[   25.778177] systemd[1]: Created slice User and Session Slice.
[   25.784172] systemd[1]: Started Dispatch Password Requests to Console 
Directory Watch.
[   25.793157] systemd[1]: Started Forward Password Requests to Wall 
Directory Watch.
[   25.802079] systemd[1]: Reached target Encrypted Volumes.
[   25.808143] systemd[1]: Listening on Journal Socket (/dev/log).
[   25.814146] systemd[1]: Listening on udev Control Socket.
[   25.820320] systemd[1]: Set up automount Arbitrary Executable File 
Formats File System Automount Point.
[   25.829163] systemd[1]: Listening on Journal Socket.
[   25.835105] systemd[1]: Reached target Paths.
[   25.839152] systemd[1]: Created slice System Slice.
[   25.852247] systemd[1]: Starting Journal Service...
[   25.857284] systemd[1]: Reached target Slices.
[   25.867265] systemd[1]: Started ReadyNAS LCD splasher.
[   25.874086] systemd[1]: Mounting RPC Pipe File System...
[   25.878823] systemd[1]: Starting Remount Root and Kernel File Systems...
[   25.890165] systemd[1]: Mounting RPC Pipe File System...
[   25.895229] systemd[1]: Created slice system-serial\x2dgetty.slice.
[   25.902279] systemd[1]: Created slice system-getty.slice.
[   25.912247] systemd[1]: Starting ReadyNASOS system prep...
[   25.917977] systemd[1]: Starting Create Static Device Nodes in /dev...
[   25.925047] systemd[1]: Mounting POSIX Message Queue File System...
[   25.932337] systemd[1]: Starting Load Kernel Modules...
[   25.937888] systemd[1]: Mounting Debug File System...
[   25.968370] systemd[1]: Mounted RPC Pipe File System.
[   25.974169] systemd[1]: Mounted RPC Pipe File System.
[   25.980125] systemd[1]: Mounted POSIX Message Queue File System.
[   25.986102] systemd[1]: Mounted Debug File System.
[   25.992481] systemd[1]: Started Remount Root and Kernel File Systems.
[   26.000563] systemd[1]: Started Load Kernel Modules.
[   26.006488] systemd[1]: Started ReadyNASOS system prep.
[   26.017201] systemd[1]: Mounting FUSE Control File System...
[   26.022865] systemd[1]: Starting Apply Kernel Variables...
[   26.027858] systemd[1]: Mounting Configuration File System...
[   26.034306] systemd[1]: Starting Rebuild Hardware Database...
[   26.039832] systemd[1]: Starting Load/Save Random Seed...
[   26.059709] systemd[1]: Mounted Configuration File System.
[   26.065211] systemd[1]: Mounted FUSE Control File System.
[   26.071378] systemd[1]: Started Create Static Device Nodes in /dev.
[   26.080040] systemd[1]: Started Apply Kernel Variables.
[   26.086640] systemd[1]: Started Load/Save Random Seed.
[   26.101307] systemd[1]: Starting udev Kernel Device Manager...
[   26.143771] systemd[1]: Started Journal Service.
[   26.175781] systemd-journald[1448]: Received request to flush runtime 
journal from PID 1
[   26.948389] md: md127 stopped.
[   26.949678] md: bind<sdb3>
[   26.949780] md: bind<sdc3>
[   26.949907] md: bind<sdd3>
[   26.950046] md: bind<sde3>
[   26.950193] md: bind<sdf3>
[   26.950330] md: bind<sda3>
[   26.964880] md/raid:md127: device sda3 operational as raid disk 0
[   26.964885] md/raid:md127: device sdf3 operational as raid disk 5
[   26.964887] md/raid:md127: device sde3 operational as raid disk 4
[   26.964889] md/raid:md127: device sdd3 operational as raid disk 3
[   26.964891] md/raid:md127: device sdc3 operational as raid disk 2
[   26.964892] md/raid:md127: device sdb3 operational as raid disk 1
[   26.965688] md/raid:md127: allocated 6474kB
[   26.966548] md/raid:md127: raid level 6 active with 6 out of 6 
devices, algorithm 2
[   26.966552] RAID conf printout:
[   26.966553]  --- level:6 rd:6 wd:6
[   26.966556]  disk 0, o:1, dev:sda3
[   26.966557]  disk 1, o:1, dev:sdb3
[   26.966560]  disk 2, o:1, dev:sdc3
[   26.966562]  disk 3, o:1, dev:sdd3
[   26.966564]  disk 4, o:1, dev:sde3
[   26.966566]  disk 5, o:1, dev:sdf3
[   26.966778] md127: detected capacity change from 0 to 7981731151872
[   27.168984] BTRFS: device label 33eb0773:Dual devid 1 transid 8127491 
/dev/md127
[   27.173912] Adding 1566716k swap on /dev/md1.  Priority:-1 extents:1 
across:1566716k
[   27.269592] md: md126 stopped.
[   27.271015] md: bind<sdd4>
[   27.271172] md: bind<sde4>
[   27.271315] md: bind<sdf4>
[   27.271450] md: bind<sda4>
[   27.271595] md: bind<sdb4>
[   27.271731] md: bind<sdc4>
[   27.272814] md/raid:md126: device sdc4 operational as raid disk 0
[   27.272817] md/raid:md126: device sdb4 operational as raid disk 5
[   27.272819] md/raid:md126: device sda4 operational as raid disk 4
[   27.272821] md/raid:md126: device sdf4 operational as raid disk 3
[   27.272823] md/raid:md126: device sde4 operational as raid disk 2
[   27.272825] md/raid:md126: device sdd4 operational as raid disk 1
[   27.273367] md/raid:md126: allocated 6474kB
[   27.273404] md/raid:md126: raid level 6 active with 6 out of 6 
devices, algorithm 2
[   27.273405] RAID conf printout:
[   27.273407]  --- level:6 rd:6 wd:6
[   27.273409]  disk 0, o:1, dev:sdc4
[   27.273410]  disk 1, o:1, dev:sdd4
[   27.273412]  disk 2, o:1, dev:sde4
[   27.273414]  disk 3, o:1, dev:sdf4
[   27.273416]  disk 4, o:1, dev:sda4
[   27.273417]  disk 5, o:1, dev:sdb4
[   27.273496] md126: detected capacity change from 0 to 16002567897088
[   27.520262] BTRFS: device label 33eb0773:Dual devid 2 transid 8127491 
/dev/md126
[   27.573216] md: md125 stopped.
[   27.574567] md: bind<sdc5>
[   27.574737] md: bind<sde5>
[   27.574885] md: bind<sdf5>
[   27.575194] md: bind<sdb5>
[   27.576106] md/raid:md125: device sdb5 operational as raid disk 0
[   27.576109] md/raid:md125: device sdf5 operational as raid disk 3
[   27.576112] md/raid:md125: device sde5 operational as raid disk 2
[   27.576113] md/raid:md125: device sdc5 operational as raid disk 1
[   27.576576] md/raid:md125: allocated 4362kB
[   27.576765] md/raid:md125: raid level 6 active with 4 out of 4 
devices, algorithm 2
[   27.576768] RAID conf printout:
[   27.576770]  --- level:6 rd:4 wd:4
[   27.576772]  disk 0, o:1, dev:sdb5
[   27.576773]  disk 1, o:1, dev:sdc5
[   27.576775]  disk 2, o:1, dev:sde5
[   27.576777]  disk 3, o:1, dev:sdf5
[   27.576891] md125: detected capacity change from 0 to 11997656383488
[   27.790594] BTRFS: device label 33eb0773:Dual devid 3 transid 8127491 
/dev/md125
[   28.035579] BTRFS info (device md125): has skinny extents
[   86.784537] BTRFS info (device md125): start tree-log replay
[   86.787111] BTRFS error (device md125): parent transid verify failed 
on 25029252612096 wanted 8127492 found 8126807
[   86.803749] BTRFS error (device md125): parent transid verify failed 
on 25029252612096 wanted 8127492 found 8126807
[   86.803753] BTRFS warning (device md125): failed to read log tree
[   86.879033] BTRFS error (device md125): open_ctree failed
[   87.367005] eth0: network connection down
[   87.370057] eth1: network connection down
[   87.506578] NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state 
recovery directory
[   87.506589] NFSD: starting 90-second grace period (net ffffffff88d782c0)
[   87.576551] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[   87.580125] IPv6: ADDRCONF(NETDEV_UP): eth1: link is not ready
[   90.467020] eth1: network connection up using port A
[   90.467020]     interrupt src:   MSI
[   90.467020]     speed:           1000
[   90.467020]     autonegotiation: yes
[   90.467020]     duplex mode:     full
[   90.467020]     flowctrl:        symmetric
[   90.467020]     role:            master
[   90.467020]     tcp offload:     enabled
[   90.467020]     scatter-gather:  enabled
[   90.467020]     tx-checksum:     enabled
[   90.467020]     rx-checksum:     enabled
[   90.467020]     rx-polling:      enabled
[   90.467020] IPv6: ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready
[   91.814754] eth0: network connection up using port A
[   91.814754]     interrupt src:   MSI
[   91.814754]     speed:           1000
[   91.814754]     autonegotiation: yes
[   91.814754]     duplex mode:     full
[   91.814754]     flowctrl:        symmetric
[   91.814754]     role:            slave
[   91.814754]     tcp offload:     enabled
[   91.814754]     scatter-gather:  enabled
[   91.814754]     tx-checksum:     enabled
[   91.814754]     rx-checksum:     enabled
[   91.814754]     rx-polling:      enabled
[   91.814754] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[  109.492320] nfsd: last server has exited, flushing export cache
[  109.561243] NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state 
recovery directory
[  109.561273] NFSD: starting 90-second grace period (net ffffffff88d782c0)
[  235.447123] nr_pdflush_threads exported in /proc is scheduled for removal
[ 3622.532329] BTRFS info (device md125): unrecognized mount option 
'usebackuproot'
[ 3622.536050] BTRFS error (device md125): open_ctree failed
[ 3696.939674] BTRFS info (device md125): enabling auto recovery
[ 3696.939679] BTRFS info (device md125): has skinny extents
[ 3764.470376] BTRFS info (device md125): start tree-log replay
[ 3764.475305] BTRFS error (device md125): parent transid verify failed 
on 25029252612096 wanted 8127492 found 8126807
[ 3764.486455] BTRFS error (device md125): parent transid verify failed 
on 25029252612096 wanted 8127492 found 8126807
[ 3764.486458] BTRFS warning (device md125): failed to read log tree
[ 3764.565029] BTRFS error (device md125): open_ctree failed
root@Pro:~#


Thank you very much

Best regsrds, Ian





-- 
This email has been checked for viruses by AVG.
https://www.avg.com

