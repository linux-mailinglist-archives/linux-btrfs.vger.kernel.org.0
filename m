Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB4056AC47
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Jul 2022 21:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236499AbiGGT45 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Jul 2022 15:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235829AbiGGT44 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Jul 2022 15:56:56 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5865C9D1
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Jul 2022 12:56:53 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id p17so1983294qkj.10
        for <linux-btrfs@vger.kernel.org>; Thu, 07 Jul 2022 12:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=TnQuyclsYx1Vik2i9m8UJq7idHEWCrrJzBHvqeiPxAk=;
        b=ILVMJI4Og7Fz2hVTYhbgzaV881U5twzG18jdln8u0rwwcBlEMsbxI+W5fopw/GBj2G
         XG0cCOIeLj4qROB9pT8+OeHjDencyyJ3cTm02zhymPKRgZXZmi97zwBmkMglRJTfX6DE
         eO2FTSkKZ6HuVzE/RE3b/sOrRzdbGnwMRuBNH8hN5XaP/BwfgjIgRTTqrv+Q7B9x+LpW
         aD8S7izGIcFksSh2gZ2Ku+viWLPKH2J+yX7DJxU6ANVv086+uG7RkscjXWS/7i8q23Hu
         rS+g2bRztjp586TIJ9fQxdLICMyYie7zrH1Z4wyA+KTsVJnPbRi6g0ZuPT0nqxiAB6Fl
         Vr5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TnQuyclsYx1Vik2i9m8UJq7idHEWCrrJzBHvqeiPxAk=;
        b=zXncucEPK/5VCONv4YZ5vGwtYmNC9+jXdr664ilpDA2EmoLygmwj/Ld+iPdByKNzUX
         gbjUhETsa3e6SZxhvIrsuPLA+WbsBY9RGzrejNz5mjCqBA9yYxr/VHrVy9mWtY7KKOqb
         NOZZzCXanbYpnuxWdKxpB/2oXbI9WaI5X11V+sUoENzZp+wOv3dVMlL9VO356gGarnsB
         /HSvwGsb+lsM3Jn/LGT0v6XIeRr/n2kCMLkT6aLdOaltW2sSilxKCU+QKj1kfSy7LNBm
         Rovod1q4t9qxPoW03TxzmqZzTsG7rTikbNGOIkta3zgfO/hQu2IHVpSo0VcWvLlfeaAD
         YRqw==
X-Gm-Message-State: AJIora+jDzam6y5R8rNpt+IcroVGQjw/hfgyZYJUecwIvE6RcuuKZzpE
        +ApAmhAJvibTFu+Q8tE18s0NQ5OclfU=
X-Google-Smtp-Source: AGRyM1vYKeboMZL6ZcFnl/PaqLOcTN82cvrUhhYpPc64Vtw3NJbfgGxP+/fV7WIoMt1MbW22V7Bp5Q==
X-Received: by 2002:a05:620a:1374:b0:6ae:e8e5:5e3c with SMTP id d20-20020a05620a137400b006aee8e55e3cmr32503791qkl.607.1657223811352;
        Thu, 07 Jul 2022 12:56:51 -0700 (PDT)
Received: from [10.5.100.6] (modemcable117.130-83-70.mc.videotron.ca. [70.83.130.117])
        by smtp.gmail.com with ESMTPSA id x7-20020ac81207000000b00304e4bbc369sm26993134qti.10.2022.07.07.12.56.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jul 2022 12:56:51 -0700 (PDT)
Message-ID: <d359fd6c-4ced-c195-bf1c-08238bcf7d61@gmail.com>
Date:   Thu, 7 Jul 2022 15:56:49 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: BTRFS critical (device md126): corrupt node: root=1
 block=13404298215424 slot=307, unaligned pointer, have 12567101254720864896
 should be aligned to 4096
Content-Language: en-CA
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <6a3407a3-2f24-c959-a00c-ec183ca466ed@gmail.com>
 <3ed7ee56-24fe-4fe6-b9ec-857adc8924cf@gmx.com>
From:   Denis Roy <denisjroy@gmail.com>
In-Reply-To: <3ed7ee56-24fe-4fe6-b9ec-857adc8924cf@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Thank you for your quick reply, Just to let you know, I emulated what 
others has successfully tried. Took my drives out of my nas to a old 
desktop, I have Mint 18.3 on it (so I can use the commands they used at 
the time they tried it). Installed the btrfs-tools, assembled with a 
scan then, cat /proc/mdstat. The last command didn't work mount -t btrfs 
-o ro /dev/md127 /mnt. I went to the disk gui and I was able to bring up 
the array there, don't know why. I'm now copying my data, I like to 
finish this and then do want ever to fix my problem. Is that ok? I 
should be done by tonight.

If you don't know by now don't know much in Linux. Please be explicit 
with the commands.

On 2022-07-06 10:19 p.m., Qu Wenruo wrote:
>
>
> On 2022/7/7 09:32, Denis Roy wrote:
>> I am using netgate readynas firmware 6.10.7, 5 drives ,X-RAID.  I had a
>> power failure, but the nas never did a full shutdown. Nevertheless, the
>> raid was in RO when I notice there was a problem. At the time I thought
>> it was plex app, so I rebooted and then the raid never cam up.  Ever
>> where you read up on BTRFS, they say don’t try commands you can do more
>> dameage. So here I am. I added some info I believe you need and if there
>> anything else, let me know.
>
> That error message means, a tree node is pointing to a location which is
> not aligned to sectorsize (the minimal unit of btrfs read/write).
>
> But there are several problems:
>
> - The bytenr 12567101254720864896, is aligned to 4096
>   A quick python run shows:
>   >>> 12567101254720864896 / 4096.0
>   3068139954765836.0
>
>   So I don't know why kernel would even output it.
>
> - No extra context on the corrupted node.
>   Mind to dump the tree block?
>
>   # btrfs ins dump-tree -b 13404298215424 <dev>
>
>   This should provide enough info on that.
>
> - Extra btrfs check run on the array?
>   Better to use the latest btrfs-progs to provide more comprehensive
>   result.
>
> Thanks,
> Qu
>>
>> root@nas:~# btrfs version
>>
>> btrfs-progs v4.16
>>
>> root@nas:~# uname -a
>>
>> Linux nas 4.4.218.x86_64.1 #1 SMP Sun Nov 7 15:20:05 UTC 2021 x86_64
>> GNU/Linux
>>
>> root@nas:~# btrfs fi show
>>
>> Label: '33ea130b:root'  uuid: 4a0317c0-214d-4204-b722-d6176eae04c0
>>
>>         Total devices 1 FS bytes used 1.70GiB
>>
>>         devid    1 size 4.00GiB used 2.86GiB path /dev/md0
>>
>> Label: '33ea130b:data'  uuid: cdc0bc68-6685-42df-a26f-63b1db286b12
>>
>>         Total devices 2 FS bytes used 8.81TiB
>>
>>         devid    1 size 10.90TiB used 9.00TiB path /dev/md127
>>
>>         devid    2 size 2.73TiB used 19.03GiB path /dev/md126
>>
>> root@nas:~# dmesg version
>>
>> [    0.000000] Initializing cgroup subsys cpuset
>>
>> [    0.000000] Initializing cgroup subsys cpu
>>
>> [    0.000000] Initializing cgroup subsys cpuacct
>>
>> [    0.000000] Linux version 4.4.218.x86_64.1 (root@blocks) (gcc version
>> 8.3.0 (Debian 8.3.0-6) ) #1 SMP Sun Nov 7 15:20:05 UTC 2021
>>
>> [    0.000000] Command line: initrd=initrd.gz reason=normal
>> BOOT_IMAGE=kernel
>>
>> [    0.000000] KERNEL supported cpus:
>>
>> [    0.000000]   Intel GenuineIntel
>>
>> [    0.000000] Disabled fast string operations
>>
>> [    0.000000] x86/fpu: Legacy x87 FPU detected.
>>
>> [    0.000000] e820: BIOS-provided physical RAM map:
>>
>> [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009cbff]
>> usable
>>
>> [    0.000000] BIOS-e820: [mem 0x000000000009cc00-0x000000000009ffff]
>> reserved
>>
>> [    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff]
>> reserved
>>
>> [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000afeaffff]
>> usable
>>
>> [    0.000000] BIOS-e820: [mem 0x00000000afeb0000-0x00000000afebdfff]
>> ACPI data
>>
>> [    0.000000] BIOS-e820: [mem 0x00000000afebe000-0x00000000afeeffff]
>> ACPI NVS
>>
>> [    0.000000] BIOS-e820: [mem 0x00000000afef0000-0x00000000afefffff]
>> reserved
>>
>> [    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff]
>> reserved
>>
>> [    0.000000] BIOS-e820: [mem 0x00000000ffb00000-0x00000000ffffffff]
>> reserved
>>
>> [    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000024fffffff]
>> usable
>>
>> [    0.000000] NX (Execute Disable) protection: active
>>
>> [    0.000000] SMBIOS 2.4 present.
>>
>> [    0.000000] DMI: To Be Filled By O.E.M. To Be Filled By O.E.M./To be
>> filled by O.E.M., BIOS 080014 07/26/2010
>>
>> [    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> 
>> reserved
>>
>> [    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
>>
>> [    0.000000] e820: last_pfn = 0x250000 max_arch_pfn = 0x400000000
>>
>> [    0.000000] MTRR default type: uncachable
>>
>> [    0.000000] MTRR fixed ranges enabled:
>>
>> [    0.000000]   00000-9FFFF write-back
>>
>> [    0.000000]   A0000-BFFFF uncachable
>>
>> [    0.000000]   C0000-DFFFF write-protect
>>
>> [    0.000000]   E0000-EFFFF write-through
>>
>> [    0.000000]   F0000-FFFFF write-protect
>>
>> [    0.000000] MTRR variable ranges enabled:
>>
>> [    0.000000]   0 base 000000000 mask E00000000 write-back
>>
>> [    0.000000]   1 base 200000000 mask FC0000000 write-back
>>
>> [    0.000000]   2 base 240000000 mask FF0000000 write-back
>>
>> [    0.000000]   3 base 0B0000000 mask FF0000000 uncachable
>>
>> [    0.000000]   4 base 0C0000000 mask FC0000000 uncachable
>>
>> [    0.000000]   5 base 0AFF00000 mask FFFF00000 uncachable
>>
>> [    0.000000]   6 disabled
>>
>> [    0.000000]   7 disabled
>>
>> [    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB WC  
>> UC- WT
>>
>> [    0.000000] e820: update [mem 0xaff00000-0xffffffff] usable ==> 
>> reserved
>>
>> [    0.000000] e820: last_pfn = 0xafeb0 max_arch_pfn = 0x400000000
>>
>> [    0.000000] Base memory trampoline at [ffff880000094000] 94000 size
>> 28672
>>
>> [    0.000000] BRK [0x08f56000, 0x08f56fff] PGTABLE
>>
>> [    0.000000] BRK [0x08f57000, 0x08f57fff] PGTABLE
>>
>> [    0.000000] BRK [0x08f58000, 0x08f58fff] PGTABLE
>>
>> [    0.000000] BRK [0x08f59000, 0x08f59fff] PGTABLE
>>
>> [    0.000000] BRK [0x08f5a000, 0x08f5afff] PGTABLE
>>
>> [    0.000000] BRK [0x08f5b000, 0x08f5bfff] PGTABLE
>>
>> [    0.000000] RAMDISK: [mem 0x7fb9f000-0x7fffffff]
>>
>> [    0.000000] ACPI: Early table checksum verification disabled
>>
>> [    0.000000] ACPI: RSDP 0x00000000000F9C00 000014 (v00 ACPIAM)
>>
>> [    0.000000] ACPI: RSDT 0x00000000AFEB0000 000038 (v01 A M I OEMRSDT
>> 07001026 MSFT 00000097)
>>
>> [    0.000000] ACPI: FACP 0x00000000AFEB0200 000084 (v02 A M I OEMFACP
>> 07001026 MSFT 00000097)
>>
>> [    0.000000] ACPI: DSDT 0x00000000AFEB0440 005B7A (v01 1ADHK 1ADHK007
>> 00000007 INTL 20051117)
>>
>> [    0.000000] ACPI: FACS 0x00000000AFEBE000 000040
>>
>> [    0.000000] ACPI: APIC 0x00000000AFEB0390 00006C (v01 A M I OEMAPIC
>> 07001026 MSFT 00000097)
>>
>> [    0.000000] ACPI: MCFG 0x00000000AFEB0400 00003C (v01 A M I OEMMCFG
>> 07001026 MSFT 00000097)
>>
>> [    0.000000] ACPI: OEMB 0x00000000AFEBE040 000060 (v01 A M I AMI_OEM
>> 07001026 MSFT 00000097)
>>
>> [    0.000000] ACPI: GSCI 0x00000000AFEBE0A0 002024 (v01 A M I GMCHSCI
>> 07001026 MSFT 00000097)
>>
>> [    0.000000] ACPI: Local APIC address 0xfee00000
>>
>> [    0.000000] Zone ranges:
>>
>> [    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
>>
>> [    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
>>
>> [    0.000000]   Normal   [mem 0x0000000100000000-0x000000024fffffff]
>>
>> [    0.000000] Movable zone start for each node
>>
>> [    0.000000] Early memory node ranges
>>
>> [    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009bfff]
>>
>> [    0.000000]   node   0: [mem 0x0000000000100000-0x00000000afeaffff]
>>
>> [    0.000000]   node   0: [mem 0x0000000100000000-0x000000024fffffff]
>>
>> [    0.000000] Initmem setup node 0 [mem
>> 0x0000000000001000-0x000000024fffffff]
>>
>> [    0.000000] On node 0 totalpages: 2096715
>>
>> [    0.000000]   DMA zone: 64 pages used for memmap
>>
>> [    0.000000]   DMA zone: 22 pages reserved
>>
>> [    0.000000]   DMA zone: 3995 pages, LIFO batch:0
>>
>> [    0.000000]   DMA32 zone: 11195 pages used for memmap
>>
>> [    0.000000]   DMA32 zone: 716464 pages, LIFO batch:31
>>
>> [    0.000000]   Normal zone: 21504 pages used for memmap
>>
>> [    0.000000]   Normal zone: 1376256 pages, LIFO batch:31
>>
>> [    0.000000] Reserving Intel graphics stolen memory at
>> 0xaff00000-0xafffffff
>>
>> [    0.000000] ACPI: PM-Timer IO Port: 0x808
>>
>> [    0.000000] ACPI: Local APIC address 0xfee00000
>>
>> [    0.000000] IOAPIC[0]: apic_id 4, version 32, address 0xfec00000, GSI
>> 0-23
>>
>> [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
>>
>> [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high 
>> level)
>>
>> [    0.000000] ACPI: IRQ0 used by override.
>>
>> [    0.000000] ACPI: IRQ9 used by override.
>>
>> [    0.000000] Using ACPI (MADT) for SMP configuration information
>>
>> [    0.000000] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
>>
>> [    0.000000] e820: [mem 0xb0000000-0xfedfffff] available for PCI 
>> devices
>>
>> [    0.000000] clocksource: refined-jiffies: mask: 0xffffffff
>> max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
>>
>> [    0.000000] setup_percpu: NR_CPUS:8 nr_cpumask_bits:8 nr_cpu_ids:4
>> nr_node_ids:1
>>
>> [    0.000000] PERCPU: Embedded 30 pages/cpu @ffff88024fc00000 s82392
>> r8192 d32296 u524288
>>
>> [    0.000000] pcpu-alloc: s82392 r8192 d32296 u524288 alloc=1*2097152
>>
>> [    0.000000] pcpu-alloc: [0] 0 1 2 3
>>
>> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
>> Total pages: 2063930
>>
>> [    0.000000] Kernel command line: console=tty0 console=ttyS0,115200
>> hpet=disable initrd=initrd.gz reason=normal BOOT_IMAGE=kernel
>>
>> [    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
>>
>> [    0.000000] Dentry cache hash table entries: 1048576 (order: 11,
>> 8388608 bytes)
>>
>> [    0.000000] Inode-cache hash table entries: 524288 (order: 10,
>> 4194304 bytes)
>>
>> [    0.000000] Memory: 8156496K/8386860K available (9142K kernel code,
>> 989K rwdata, 3940K rodata, 872K init, 696K bss, 230364K reserved, 0K
>> cma-reserved)
>>
>> [    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, 
>> Nodes=1
>>
>> [    0.000000] Kernel/User page tables isolation: enabled
>>
>> [    0.000000] Hierarchical RCU implementation.
>>
>> [    0.000000]      RCU debugfs-based tracing is enabled.
>>
>> [    0.000000]      Build-time adjustment of leaf fanout to 64.
>>
>> [    0.000000]      RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=4.
>>
>> [    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=64, 
>> nr_cpu_ids=4
>>
>> [    0.000000] NR_IRQS:4352 nr_irqs:456 16
>>
>> [    0.000000] Console: colour VGA+ 80x25
>>
>> [    0.000000] console [tty0] enabled
>>
>> [    0.000000] console [ttyS0] enabled
>>
>> [    0.000000] tsc: Fast TSC calibration using PIT
>>
>> [    0.000000] tsc: Detected 2660.100 MHz processor
>>
>> [    0.001011] Calibrating delay loop (skipped), value calculated using
>> timer frequency.. 5320.20 BogoMIPS (lpj=2660100)
>>
>> [    0.001014] pid_max: default: 32768 minimum: 301
>>
>> [    0.001020] ACPI: Core revision 20150930
>>
>> [    0.004916] ACPI: 1 ACPI AML tables successfully acquired and loaded
>>
>> [    0.004937] Security Framework initialized
>>
>> [    0.004948] Mount-cache hash table entries: 16384 (order: 5, 131072
>> bytes)
>>
>> [    0.004951] Mountpoint-cache hash table entries: 16384 (order: 5,
>> 131072 bytes)
>>
>> [    0.005355] Initializing cgroup subsys io
>>
>> [    0.005360] Initializing cgroup subsys memory
>>
>> [    0.005370] Initializing cgroup subsys devices
>>
>> [    0.005374] Initializing cgroup subsys freezer
>>
>> [    0.005378] Initializing cgroup subsys net_cls
>>
>> [    0.005382] Initializing cgroup subsys perf_event
>>
>> [    0.005385] Initializing cgroup subsys net_prio
>>
>> [    0.005389] Initializing cgroup subsys pids
>>
>> [    0.005406] Disabled fast string operations
>>
>> [    0.005410] CPU: Physical Processor ID: 0
>>
>> [    0.005411] CPU: Processor Core ID: 0
>>
>> [    0.005413] mce: CPU supports 6 MCE banks
>>
>> [    0.005423] CPU0: Thermal monitoring enabled (TM2)
>>
>> [    0.005426] process: using mwait in idle threads
>>
>> [    0.005431] Last level iTLB entries: 4KB 128, 2MB 4, 4MB 4
>>
>> [    0.005433] Last level dTLB entries: 4KB 256, 2MB 0, 4MB 32, 1GB 0
>>
>> [    0.005435] Spectre V1 : Mitigation: usercopy/swapgs barriers and
>> __user pointer sanitization
>>
>> [    0.005438] Spectre V2 : Mitigation: Full generic retpoline
>>
>> [    0.005439] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling
>> RSB on context switch
>>
>> [    0.005441] Speculative Store Bypass: Vulnerable
>>
>> [    0.005464] MDS: Vulnerable: Clear CPU buffers attempted, no 
>> microcode
>>
>> [    0.005833] Freeing SMP alternatives memory: 40K
>>
>> [    0.006445] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
>>
>> [    0.118836] smpboot: CPU0: Intel(R) Xeon(R) CPU X3230  @
>> 2.66GHz (family: 0x6, model: 0xf, stepping: 0xb)
>>
>> [    0.118850] Performance Events: PEBS fmt0+, 4-deep LBR, Core2 events,
>> Intel PMU driver.
>>
>> [    0.118861] perf_event_intel: PEBS disabled due to CPU errata
>>
>> [    0.118864] ... version: 2
>>
>> [    0.118865] ... bit width: 40
>>
>> [    0.118866] ... generic registers: 2
>>
>> [    0.118868] ... value mask: 000000ffffffffff
>>
>> [    0.118869] ... max period: 000000007fffffff
>>
>> [    0.118870] ... fixed-purpose events: 3
>>
>> [    0.118872] ... event mask: 0000000700000003
>>
>> [    0.119646] x86: Booting SMP configuration:
>>
>> [    0.119649] .... node  #0, CPUs: #1 #2 #3
>>
>> [    0.124026] x86: Booted up 1 node, 4 CPUs
>>
>> [    0.124031] smpboot: Total of 4 processors activated (21280.80 
>> BogoMIPS)
>>
>> [    0.125124] NMI watchdog: enabled on all CPUs, permanently consumes
>> one hw-PMU counter.
>>
>> [    0.125195] devtmpfs: initialized
>>
>> [    0.126201] clocksource: jiffies: mask: 0xffffffff max_cycles:
>> 0xffffffff, max_idle_ns: 1911260446275000 ns
>>
>> [    0.126209] futex hash table entries: 1024 (order: 4, 65536 bytes)
>>
>> [    0.126263] xor: measuring software checksum speed
>>
>> [    0.136001]    prefetch64-sse: 15092.000 MB/sec
>>
>> [    0.146001]    generic_sse: 12756.000 MB/sec
>>
>> [    0.146003] xor: using function: prefetch64-sse (15092.000 MB/sec)
>>
>> [    0.146010] pinctrl core: initialized pinctrl subsystem
>>
>> [    0.146193] NET: Registered protocol family 16
>>
>> [    0.150006] cpuidle: using governor ladder
>>
>> [    0.154004] cpuidle: using governor menu
>>
>> [    0.154232] ACPI: bus type PCI registered
>>
>> [    0.154339] dca service started, version 1.12.1
>>
>> [    0.154354] PCI: Using configuration type 1 for base access
>>
>> [    0.180775] raid6: sse2x1   gen()  4031 MB/s
>>
>> [    0.197772] raid6: sse2x1   xor()  4281 MB/s
>>
>> [    0.214771] raid6: sse2x2   gen()  4476 MB/s
>>
>> [    0.231775] raid6: sse2x2   xor()  5458 MB/s
>>
>> [    0.248772] raid6: sse2x4   gen()  7894 MB/s
>>
>> [    0.265772] raid6: sse2x4   xor()  5812 MB/s
>>
>> [    0.265774] raid6: using algorithm sse2x4 gen() 7894 MB/s
>>
>> [    0.265775] raid6: .... xor() 5812 MB/s, rmw enabled
>>
>> [    0.265777] raid6: using ssse3x2 recovery algorithm
>>
>> [    0.266024] ACPI: Added _OSI(Module Device)
>>
>> [    0.266024] ACPI: Added _OSI(Processor Device)
>>
>> [    0.266024] ACPI: Added _OSI(3.0 _SCP Extensions)
>>
>> [    0.266024] ACPI: Added _OSI(Processor Aggregator Device)
>>
>> [    0.267725] ACPI: Executed 1 blocks of module-level executable AML 
>> code
>>
>> [    0.270238] ACPI: Interpreter enabled
>>
>> [    0.270244] ACPI: (supports S0 S5)
>>
>> [    0.270246] ACPI: Using IOAPIC for interrupt routing
>>
>> [    0.270278] PCI: Using host bridge windows from ACPI; if necessary,
>> use "pci=nocrs" and report a bug
>>
>> [    0.276431] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
>>
>> [    0.276436] acpi PNP0A08:00: _OSC: OS supports [ASPM ClockPM Segments
>> MSI]
>>
>> [    0.276442] acpi PNP0A08:00: _OSC failed (AE_NOT_FOUND); disabling 
>> ASPM
>>
>> [    0.276535] PCI host bridge to bus 0000:00
>>
>> [    0.276539] pci_bus 0000:00: root bus resource [io 0x0000-0x0cf7
>> window]
>>
>> [    0.276541] pci_bus 0000:00: root bus resource [io 0x0d00-0xffff
>> window]
>>
>> [    0.276544] pci_bus 0000:00: root bus resource [mem
>> 0x000a0000-0x000bffff window]
>>
>> [    0.276546] pci_bus 0000:00: root bus resource [mem
>> 0x000d0000-0x000dffff window]
>>
>> [    0.276549] pci_bus 0000:00: root bus resource [mem
>> 0xaff00000-0xffffffff window]
>>
>> [    0.276551] pci_bus 0000:00: root bus resource [bus 00-ff]
>>
>> [    0.276566] pci 0000:00:00.0: [8086:2990] type 00 class 0x060000
>>
>> [    0.276676] pci 0000:00:02.0: [8086:2992] type 00 class 0x030000
>>
>> [    0.276689] pci 0000:00:02.0: reg 0x10: [mem 0xffa00000-0xffafffff]
>>
>> [    0.276705] pci 0000:00:02.0: reg 0x18: [mem 0xd0000000-0xdfffffff
>> 64bit pref]
>>
>> [    0.276710] pci 0000:00:02.0: reg 0x20: [io  0xec00-0xec07]
>>
>> [    0.276829] pci 0000:00:1a.0: [8086:2834] type 00 class 0x0c0300
>>
>> [    0.276873] pci 0000:00:1a.0: reg 0x20: [io  0xe000-0xe01f]
>>
>> [    0.277017] pci 0000:00:1a.1: [8086:2835] type 00 class 0x0c0300
>>
>> [    0.277023] pci 0000:00:1a.1: reg 0x20: [io  0xdc00-0xdc1f]
>>
>> [    0.277130] pci 0000:00:1a.7: [8086:283a] type 00 class 0x0c0320
>>
>> [    0.277159] pci 0000:00:1a.7: reg 0x10: [mem 0xff9fb400-0xff9fb7ff]
>>
>> [    0.277223] pci 0000:00:1a.7: PME# supported from D0 D3hot D3cold
>>
>> [    0.277312] pci 0000:00:1b.0: [8086:284b] type 00 class 0x040300
>>
>> [    0.277340] pci 0000:00:1b.0: reg 0x10: [mem 0xff9f4000-0xff9f7fff
>> 64bit]
>>
>> [    0.277391] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
>>
>> [    0.277473] pci 0000:00:1c.0: [8086:283f] type 01 class 0x060400
>>
>> [    0.277536] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
>>
>> [    0.277624] pci 0000:00:1c.1: [8086:2841] type 01 class 0x060400
>>
>> [    0.277688] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
>>
>> [    0.277778] pci 0000:00:1d.0: [8086:2830] type 00 class 0x0c0300
>>
>> [    0.277821] pci 0000:00:1d.0: reg 0x20: [io  0xd880-0xd89f]
>>
>> [    0.277920] pci 0000:00:1d.1: [8086:2831] type 00 class 0x0c0300
>>
>> [    0.277963] pci 0000:00:1d.1: reg 0x20: [io  0xd800-0xd81f]
>>
>> [    0.278070] pci 0000:00:1d.2: [8086:2832] type 00 class 0x0c0300
>>
>> [    0.278114] pci 0000:00:1d.2: reg 0x20: [io  0xd480-0xd49f]
>>
>> [    0.278222] pci 0000:00:1d.7: [8086:2836] type 00 class 0x0c0320
>>
>> [    0.278252] pci 0000:00:1d.7: reg 0x10: [mem 0xff9fb000-0xff9fb3ff]
>>
>> [    0.278316] pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
>>
>> [    0.278400] pci 0000:00:1e.0: [8086:244e] type 01 class 0x060401
>>
>> [    0.278535] pci 0000:00:1f.0: [8086:2810] type 00 class 0x060100
>>
>> [    0.278620] pci 0000:00:1f.0: quirk: [io  0x0800-0x087f] claimed by
>> ICH6 ACPI/GPIO/TCO
>>
>> [    0.278625] pci 0000:00:1f.0: quirk: [io  0x0480-0x04bf] claimed by
>> ICH6 GPIO
>>
>> [    0.278629] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 1 PIO at
>> 0a00 (mask 00ff)
>>
>> [    0.278732] pci 0000:00:1f.2: [8086:2821] type 00 class 0x010601
>>
>> [    0.278759] pci 0000:00:1f.2: reg 0x10: [io  0xe880-0xe887]
>>
>> [    0.278766] pci 0000:00:1f.2: reg 0x14: [io  0xe800-0xe803]
>>
>> [    0.278774] pci 0000:00:1f.2: reg 0x18: [io  0xe480-0xe487]
>>
>> [    0.278782] pci 0000:00:1f.2: reg 0x1c: [io  0xe400-0xe403]
>>
>> [    0.278789] pci 0000:00:1f.2: reg 0x20: [io  0xe080-0xe09f]
>>
>> [    0.278797] pci 0000:00:1f.2: reg 0x24: [mem 0xff9fb800-0xff9fbfff]
>>
>> [    0.278825] pci 0000:00:1f.2: PME# supported from D3hot
>>
>> [    0.278907] pci 0000:00:1f.3: [8086:283e] type 00 class 0x0c0500
>>
>> [    0.278920] pci 0000:00:1f.3: reg 0x10: [mem 0xff9fac00-0xff9facff]
>>
>> [    0.278950] pci 0000:00:1f.3: reg 0x20: [io  0x0400-0x041f]
>>
>> [    0.279124] pci 0000:01:00.0: [11ab:4362] type 00 class 0x020000
>>
>> [    0.279168] pci 0000:01:00.0: reg 0x10: [mem 0xff6fc000-0xff6fffff
>> 64bit]
>>
>> [    0.279180] pci 0000:01:00.0: reg 0x18: [io  0xb800-0xb8ff]
>>
>> [    0.279221] pci 0000:01:00.0: reg 0x30: [mem 0xff6c0000-0xff6dffff 
>> pref]
>>
>> [    0.279262] pci 0000:01:00.0: supports D1 D2
>>
>> [    0.279264] pci 0000:01:00.0: PME# supported from D0 D1 D2 D3hot 
>> D3cold
>>
>> [    0.279317] pci 0000:01:00.0: disabling ASPM on pre-1.1 PCIe device.
>> You can enable it with 'pcie_aspm=force'
>>
>> [    0.279328] pci 0000:00:1c.0: PCI bridge to [bus 01]
>>
>> [    0.279332] pci 0000:00:1c.0:   bridge window [io 0xb000-0xbfff]
>>
>> [    0.279336] pci 0000:00:1c.0:   bridge window [mem
>> 0xff600000-0xff6fffff]
>>
>> [    0.279410] pci 0000:02:00.0: [11ab:4362] type 00 class 0x020000
>>
>> [    0.279454] pci 0000:02:00.0: reg 0x10: [mem 0xff7fc000-0xff7fffff
>> 64bit]
>>
>> [    0.279466] pci 0000:02:00.0: reg 0x18: [io  0xc800-0xc8ff]
>>
>> [    0.279506] pci 0000:02:00.0: reg 0x30: [mem 0xff7c0000-0xff7dffff 
>> pref]
>>
>> [    0.279548] pci 0000:02:00.0: supports D1 D2
>>
>> [    0.279550] pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot 
>> D3cold
>>
>> [    0.279599] pci 0000:02:00.0: disabling ASPM on pre-1.1 PCIe device.
>> You can enable it with 'pcie_aspm=force'
>>
>> [    0.279609] pci 0000:00:1c.1: PCI bridge to [bus 02]
>>
>> [    0.279613] pci 0000:00:1c.1:   bridge window [io 0xc000-0xcfff]
>>
>> [    0.279618] pci 0000:00:1c.1:   bridge window [mem
>> 0xff700000-0xff7fffff]
>>
>> [    0.279706] pci 0000:00:1e.0: PCI bridge to [bus 03] (subtractive
>> decode)
>>
>> [    0.279715] pci 0000:00:1e.0:   bridge window [io 0x0000-0x0cf7
>> window] (subtractive decode)
>>
>> [    0.279718] pci 0000:00:1e.0:   bridge window [io 0x0d00-0xffff
>> window] (subtractive decode)
>>
>> [    0.279720] pci 0000:00:1e.0:   bridge window [mem
>> 0x000a0000-0x000bffff window] (subtractive decode)
>>
>> [    0.279723] pci 0000:00:1e.0:   bridge window [mem
>> 0x000d0000-0x000dffff window] (subtractive decode)
>>
>> [    0.279725] pci 0000:00:1e.0:   bridge window [mem
>> 0xaff00000-0xffffffff window] (subtractive decode)
>>
>> [    0.279740] pci_bus 0000:00: on NUMA node 0
>>
>> [    0.280490] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12
>> 14 15)
>>
>> [    0.280545] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12
>> 14 15)
>>
>> [    0.280598] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 11 12
>> *14 15)
>>
>> [    0.280651] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 10 11 12
>> 14 15)
>>
>> [    0.280713] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12
>> 14 15) *0, disabled.
>>
>> [    0.280766] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12
>> 14 *15)
>>
>> [    0.280819] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 *7 10 11 12
>> 14 15)
>>
>> [    0.280871] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 *10 11 12
>> 14 15)
>>
>> [    0.280925] ACPI: Enabled 2 GPEs in block 00 to 1F
>>
>> [    0.281098] SCSI subsystem initialized
>>
>> [    0.281130] libata version 3.00 loaded.
>>
>> [    0.281137] ACPI: bus type USB registered
>>
>> [    0.281175] usbcore: registered new interface driver usbfs
>>
>> [    0.281190] usbcore: registered new interface driver hub
>>
>> [    0.281211] usbcore: registered new device driver usb
>>
>> [    0.281255] pps_core: LinuxPPS API ver. 1 registered
>>
>> [    0.281256] pps_core: Software ver. 5.3.6 - Copyright 2005-2007
>> Rodolfo Giometti <giometti@linux.it>
>>
>> [    0.281266] PTP clock support registered
>>
>> [    0.281307] Advanced Linux Sound Architecture Driver Initialized.
>>
>> [    0.281307] PCI: Using ACPI for IRQ routing
>>
>> [    0.281307] PCI: pci_cache_line_size set to 64 bytes
>>
>> [    0.281307] Expanded resource reserved due to conflict with PCI Bus
>> 0000:00
>>
>> [    0.281307] e820: reserve RAM buffer [mem 0x0009cc00-0x0009ffff]
>>
>> [    0.281307] e820: reserve RAM buffer [mem 0xafeb0000-0xafffffff]
>>
>> [    0.281517] Bluetooth: Core ver 2.21
>>
>> [    0.281534] NET: Registered protocol family 31
>>
>> [    0.281536] Bluetooth: HCI device and connection manager initialized
>>
>> [    0.281540] Bluetooth: HCI socket layer initialized
>>
>> [    0.281543] Bluetooth: L2CAP socket layer initialized
>>
>> [    0.281551] Bluetooth: SCO socket layer initialized
>>
>> [    0.282186] clocksource: Switched to clocksource refined-jiffies
>>
>> [    0.282299] FS-Cache: Loaded
>>
>> [    0.282369] pnp: PnP ACPI init
>>
>> [    0.282461] system 00:00: [mem 0xfed14000-0xfed19fff] has been 
>> reserved
>>
>> [    0.282465] system 00:00: Plug and Play ACPI device, IDs PNP0c01
>> (active)
>>
>> [    0.282547] pnp 00:01: Plug and Play ACPI device, IDs PNP0b00 
>> (active)
>>
>> [    0.282616] pnp 00:02: Plug and Play ACPI device, IDs PNP0303 PNP030b
>> (active)
>>
>> [    0.282829] pnp 00:03: [dma 0 disabled]
>>
>> [    0.282903] pnp 00:03: Plug and Play ACPI device, IDs PNP0501 
>> (active)
>>
>> [    0.283151] pnp 00:04: [dma 0 disabled]
>>
>> [    0.283244] pnp 00:04: Plug and Play ACPI device, IDs PNP0501 
>> (active)
>>
>> [    0.283542] system 00:05: [io 0x0a00-0x0a0f] has been reserved
>>
>> [    0.283545] system 00:05: [io 0x0a10-0x0a1f] has been reserved
>>
>> [    0.283548] system 00:05: Plug and Play ACPI device, IDs PNP0c02
>> (active)
>>
>> [    0.283692] system 00:06: [io 0x04d0-0x04d1] has been reserved
>>
>> [    0.283695] system 00:06: [io 0x0800-0x087f] has been reserved
>>
>> [    0.283698] system 00:06: [io 0x0480-0x04bf] has been reserved
>>
>> [    0.283701] system 00:06: [mem 0xfed1c000-0xfed1ffff] has been 
>> reserved
>>
>> [    0.283704] system 00:06: [mem 0xfed20000-0xfed8ffff] has been 
>> reserved
>>
>> [    0.283707] system 00:06: Plug and Play ACPI device, IDs PNP0c02
>> (active)
>>
>> [    0.283832] system 00:07: [mem 0xffc00000-0xffefffff] has been 
>> reserved
>>
>> [    0.283836] system 00:07: Plug and Play ACPI device, IDs PNP0c02
>> (active)
>>
>> [    0.283933] system 00:08: [mem 0xfec00000-0xfec00fff] could not be
>> reserved
>>
>> [    0.283936] system 00:08: [mem 0xfee00000-0xfee00fff] has been 
>> reserved
>>
>> [    0.283939] system 00:08: Plug and Play ACPI device, IDs PNP0c02
>> (active)
>>
>> [    0.284038] system 00:09: [mem 0xe0000000-0xefffffff] has been 
>> reserved
>>
>> [    0.284042] system 00:09: Plug and Play ACPI device, IDs PNP0c02
>> (active)
>>
>> [    0.284235] system 00:0a: [mem 0x00000000-0x0009ffff] could not be
>> reserved
>>
>> [    0.284238] system 00:0a: [mem 0x000c0000-0x000cffff] could not be
>> reserved
>>
>> [    0.284241] system 00:0a: [mem 0x000e0000-0x000fffff] could not be
>> reserved
>>
>> [    0.284244] system 00:0a: [mem 0x00100000-0xafefffff] could not be
>> reserved
>>
>> [    0.284247] system 00:0a: Plug and Play ACPI device, IDs PNP0c01
>> (active)
>>
>> [    0.284367] pnp: PnP ACPI: found 11 devices
>>
>> [    0.292469] clocksource: acpi_pm: mask: 0xffffff max_cycles:
>> 0xffffff, max_idle_ns: 2085701024 ns
>>
>> [    0.292493] clocksource: Switched to clocksource acpi_pm
>>
>> [    0.292511] pci 0000:00:1c.0: bridge window [mem
>> 0x00100000-0x000fffff 64bit pref] to [bus 01] add_size 200000 add_align
>> 100000
>>
>> [    0.292520] pci 0000:00:1c.1: bridge window [mem
>> 0x00100000-0x000fffff 64bit pref] to [bus 02] add_size 200000 add_align
>> 100000
>>
>> [    0.292530] pci 0000:00:1c.0: res[9]=[mem 0x00100000-0x000fffff 64bit
>> pref] res_to_dev_res add_size 200000 min_align 100000
>>
>> [    0.292533] pci 0000:00:1c.0: res[9]=[mem 0x00100000-0x002fffff 64bit
>> pref] res_to_dev_res add_size 200000 min_align 100000
>>
>> [    0.292536] pci 0000:00:1c.1: res[9]=[mem 0x00100000-0x000fffff 64bit
>> pref] res_to_dev_res add_size 200000 min_align 100000
>>
>> [    0.292539] pci 0000:00:1c.1: res[9]=[mem 0x00100000-0x002fffff 64bit
>> pref] res_to_dev_res add_size 200000 min_align 100000
>>
>> [    0.292547] pci 0000:00:1c.0: BAR 9: assigned [mem
>> 0xb0000000-0xb01fffff 64bit pref]
>>
>> [    0.292552] pci 0000:00:1c.1: BAR 9: assigned [mem
>> 0xb0200000-0xb03fffff 64bit pref]
>>
>> [    0.292555] pci 0000:00:1c.0: PCI bridge to [bus 01]
>>
>> [    0.292559] pci 0000:00:1c.0:   bridge window [io 0xb000-0xbfff]
>>
>> [    0.292563] pci 0000:00:1c.0:   bridge window [mem
>> 0xff600000-0xff6fffff]
>>
>> [    0.292568] pci 0000:00:1c.0:   bridge window [mem
>> 0xb0000000-0xb01fffff 64bit pref]
>>
>> [    0.292573] pci 0000:00:1c.1: PCI bridge to [bus 02]
>>
>> [    0.292576] pci 0000:00:1c.1:   bridge window [io 0xc000-0xcfff]
>>
>> [    0.292581] pci 0000:00:1c.1:   bridge window [mem
>> 0xff700000-0xff7fffff]
>>
>> [    0.292585] pci 0000:00:1c.1:   bridge window [mem
>> 0xb0200000-0xb03fffff 64bit pref]
>>
>> [    0.292591] pci 0000:00:1e.0: PCI bridge to [bus 03]
>>
>> [    0.292601] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
>>
>> [    0.292603] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
>>
>> [    0.292606] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff
>> window]
>>
>> [    0.292608] pci_bus 0000:00: resource 7 [mem 0x000d0000-0x000dffff
>> window]
>>
>> [    0.292611] pci_bus 0000:00: resource 8 [mem 0xaff00000-0xffffffff
>> window]
>>
>> [    0.292613] pci_bus 0000:01: resource 0 [io  0xb000-0xbfff]
>>
>> [    0.292616] pci_bus 0000:01: resource 1 [mem 0xff600000-0xff6fffff]
>>
>> [    0.292618] pci_bus 0000:01: resource 2 [mem 0xb0000000-0xb01fffff
>> 64bit pref]
>>
>> [    0.292620] pci_bus 0000:02: resource 0 [io  0xc000-0xcfff]
>>
>> [    0.292623] pci_bus 0000:02: resource 1 [mem 0xff700000-0xff7fffff]
>>
>> [    0.292625] pci_bus 0000:02: resource 2 [mem 0xb0200000-0xb03fffff
>> 64bit pref]
>>
>> [    0.292628] pci_bus 0000:03: resource 4 [io  0x0000-0x0cf7 window]
>>
>> [    0.292630] pci_bus 0000:03: resource 5 [io  0x0d00-0xffff window]
>>
>> [    0.292632] pci_bus 0000:03: resource 6 [mem 0x000a0000-0x000bffff
>> window]
>>
>> [    0.292635] pci_bus 0000:03: resource 7 [mem 0x000d0000-0x000dffff
>> window]
>>
>> [    0.292637] pci_bus 0000:03: resource 8 [mem 0xaff00000-0xffffffff
>> window]
>>
>> [    0.292667] NET: Registered protocol family 2
>>
>> [    0.292840] TCP established hash table entries: 65536 (order: 7,
>> 524288 bytes)
>>
>> [    0.292996] TCP bind hash table entries: 65536 (order: 8, 1048576 
>> bytes)
>>
>> [    0.292996] TCP: Hash tables configured (established 65536 bind 
>> 65536)
>>
>> [    0.292996] UDP hash table entries: 4096 (order: 5, 131072 bytes)
>>
>> [    0.292996] UDP-Lite hash table entries: 4096 (order: 5, 131072 
>> bytes)
>>
>> [    0.292996] NET: Registered protocol family 1
>>
>> [    0.293156] RPC: Registered named UNIX socket transport module.
>>
>> [    0.293158] RPC: Registered udp transport module.
>>
>> [    0.293159] RPC: Registered tcp transport module.
>>
>> [    0.293160] RPC: Registered tcp NFSv4.1 backchannel transport module.
>>
>> [    0.293173] pci 0000:00:02.0: Video device with shadowed ROM
>>
>> [    1.393031] pci 0000:00:1a.7: EHCI: BIOS handoff failed (BIOS bug?)
>> 01010001
>>
>> [    1.393628] PCI: CLS 32 bytes, default 64
>>
>> [    1.393679] Unpacking initramfs...
>>
>> [    2.059003] Freeing initrd memory: 4484K
>>
>> [    2.059042] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
>>
>> [    2.059045] software IO TLB: mapped [mem 0xabeb0000-0xafeb0000] 
>> (64MB)
>>
>> [    2.060866] audit: initializing netlink subsys (disabled)
>>
>> [    2.060882] audit: type=2000 audit(1656560745.059:1): initialized
>>
>> [    2.069056] VFS: Disk quotas dquot_6.6.0
>>
>> [    2.069111] VFS: Dquot-cache hash table entries: 512 (order 0, 4096
>> bytes)
>>
>> [    2.078991] NFS: Registering the id_resolver key type
>>
>> [    2.079000] Key type id_resolver registered
>>
>> [    2.079039] Key type id_legacy registered
>>
>> [    2.079044] Installing knfsd (copyright (C) 1996okir@monad.swb.de).
>>
>> [    2.082125] Key type cifs.spnego registered
>>
>> [    2.082132] Key type cifs.idmap registered
>>
>> [    2.082186] fuse init (API version 7.23)
>>
>> [    2.084994] NET: Registered protocol family 38
>>
>> [    2.085013] async_tx: api initialized (async)
>>
>> [    2.085146] Block layer SCSI generic (bsg) driver version 0.4 loaded
>> (major 251)
>>
>> [    2.085216] io scheduler noop registered
>>
>> [    2.085221] io scheduler deadline registered
>>
>> [    2.085290] io scheduler cfq registered (default)
>>
>> [    2.085374] io scheduler bfq registered
>>
>> [    2.085376] BFQ I/O-scheduler: v7r11
>>
>> [    2.085432] gpio_it87: no device
>>
>> [    2.089082] intel_idle: does not run on family 6 model 15
>>
>> [    2.089186] input: Power Button as
>> /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
>>
>> [    2.089190] ACPI: Power Button [PWRB]
>>
>> [    2.089249] input: Power Button as
>> /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
>>
>> [    2.089252] ACPI: Power Button [PWRF]
>>
>> [    2.089534] ioatdma: Intel(R) QuickData Technology Driver 4.00
>>
>> [    2.089655] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
>>
>> [    2.110208] 00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200)
>> is a 16550A
>>
>> [    2.130803] 00:04: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200)
>> is a 16550A
>>
>> [    2.131235] Linux agpgart interface v0.103
>>
>> [    2.131278] agpgart-intel 0000:00:00.0: Intel 965Q Chipset
>>
>> [    2.131297] agpgart-intel 0000:00:00.0: detected gtt size: 524288K
>> total, 262144K mappable
>>
>> [    2.132491] agpgart-intel 0000:00:00.0: detected 1024K stolen memory
>>
>> [    2.132612] agpgart-intel 0000:00:00.0: AGP aperture is 256M @
>> 0xd0000000
>>
>> [    2.132686] [drm] Initialized drm 1.1.0 20060810
>>
>> [    2.133252] [drm] Memory usable by graphics device = 512M
>>
>> [    2.133255] [drm] Replacing VGA console driver
>>
>> [    2.133961] Console: switching to colour dummy device 80x25
>>
>> [    2.134000] pmd_set_huge: Cannot satisfy [mem 0xd0000000-0xd0200000]
>> with a huge-page mapping due to MTRR override.
>>
>> [    2.140246] [drm] Supports vblank timestamp caching Rev 2 
>> (21.10.2013).
>>
>> [    2.140247] [drm] Driver supports precise vblank timestamp query.
>>
>> [    2.148755] [drm] initialized overlay support
>>
>> [    2.148812] [drm] Initialized i915 1.6.0 20151010 for 0000:00:02.0 on
>> minor 0
>>
>> [    2.152183] loop: module loaded
>>
>> [    2.152451] gpio_ich: GPIO from 462 to 511 on gpio_ich
>>
>> [    2.152569] mpt3sas version 12.100.00.00 loaded
>>
>> [    2.154374] ahci 0000:00:1f.2: version 3.0
>>
>> [    2.154564] ahci 0000:00:1f.2: SSS flag set, parallel bus scan 
>> disabled
>>
>> [    2.154596] ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 6 ports 3 Gbps
>> 0x3f impl SATA mode
>>
>> [    2.154600] ahci 0000:00:1f.2: flags: 64bit ncq sntf stag pm led clo
>> pio slum part ccc ems sxs
>>
>> [    2.154644] do_marvell_9170_recover: ignoring PCI device (8086:2821)
>> at PCI#0
>>
>> [    2.154685] do_marvell_9170_recover: ignoring PCI device (8086:2821)
>> at PCI#0
>>
>> [    2.156066] do_marvell_9170_recover: ignoring PCI device (8086:2821)
>> at PCI#0
>>
>> [    2.158079] do_marvell_9170_recover: ignoring PCI device (8086:2821)
>> at PCI#0
>>
>> [    2.160076] do_marvell_9170_recover: ignoring PCI device (8086:2821)
>> at PCI#0
>>
>> [    2.162081] do_marvell_9170_recover: ignoring PCI device (8086:2821)
>> at PCI#0
>>
>> [    2.167109] scsi host0: ahci
>>
>> [    2.167359] scsi host1: ahci
>>
>> [    2.168197] scsi host2: ahci
>>
>> [    2.168304] scsi host3: ahci
>>
>> [    2.169170] scsi host4: ahci
>>
>> [    2.169281] scsi host5: ahci
>>
>> [    2.169346] ata1: SATA max UDMA/133 abar m2048@0xff9fb800 port
>> 0xff9fb900 irq 25
>>
>> [    2.169348] ata2: SATA max UDMA/133 abar m2048@0xff9fb800 port
>> 0xff9fb980 irq 25
>>
>> [    2.169351] ata3: SATA max UDMA/133 abar m2048@0xff9fb800 port
>> 0xff9fba00 irq 25
>>
>> [    2.169353] ata4: SATA max UDMA/133 abar m2048@0xff9fb800 port
>> 0xff9fba80 irq 25
>>
>> [    2.169355] ata5: SATA max UDMA/133 abar m2048@0xff9fb800 port
>> 0xff9fbb00 irq 25
>>
>> [    2.169358] ata6: SATA max UDMA/133 abar m2048@0xff9fb800 port
>> 0xff9fbb80 irq 25
>>
>> [    2.169572] Rounding down aligned max_sectors from 4294967295 to
>> 4294967288
>>
>> [    2.169676] Ethernet Channel Bonding Driver: v3.7.1 (April 27, 2011)
>>
>> [    2.169699] tun: Universal TUN/TAP device driver, 1.6
>>
>> [    2.169700] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
>>
>> [    2.169756] e1000: Intel(R) PRO/1000 Network Driver - version
>> 7.3.21-k8-NAPI
>>
>> [    2.169758] e1000: Copyright (c) 1999-2006 Intel Corporation.
>>
>> [    2.169779] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
>>
>> [    2.169781] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
>>
>> [    2.169804] igb: Intel(R) Gigabit Ethernet Network Driver - version
>> 5.3.0-k
>>
>> [    2.169806] igb: Copyright (c) 2007-2014 Intel Corporation.
>>
>> [    2.169825] Intel(R) 10GbE PCI Express Linux Network Driver - version
>> 5.3.8
>>
>> [    2.169827] Copyright(c) 1999 - 2018 Intel Corporation.
>>
>> [    2.169874] i40e: Intel(R) 40-10 Gigabit Ethernet Connection Network
>> Driver - version 2.4.10
>>
>> [    2.169876] i40e: Copyright(c) 2013 - 2018 Intel Corporation.
>>
>> [    2.169922] bnx2x: QLogic 5771x/578xx 10/20-Gigabit Ethernet Driver
>> bnx2x 1.712.30-0 (2014/02/10)
>>
>> [    2.170073] sk98lin: Network Device Driver v10.93.3.3
>>
>> (C)Copyright 1999-2012 Marvell(R).
>>
>> [    2.224898] eth0: Marvell Yukon 88E8053 Gigabit Ethernet Controller
>>
>> [    2.279721] eth1: Marvell Yukon 88E8053 Gigabit Ethernet Controller
>>
>> [    2.279746] Fusion MPT base driver 3.04.20
>>
>> [    2.279747] Copyright (c) 1999-2008 LSI Corporation
>>
>> [    2.279755] Fusion MPT SAS Host driver 3.04.20
>>
>> [    2.279781] Fusion MPT misc device (ioctl) driver 3.04.20
>>
>> [    2.279829] mptctl: Registered with Fusion MPT base driver
>>
>> [    2.279831] mptctl: /dev/mptctl @ (major,minor=10,220)
>>
>> [    2.279835] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) 
>> Driver
>>
>> [    2.279841] ehci-pci: EHCI PCI platform driver
>>
>> [    2.279946] ehci-pci 0000:00:1a.7: EHCI Host Controller
>>
>> [    2.279954] ehci-pci 0000:00:1a.7: new USB bus registered, assigned
>> bus number 1
>>
>> [    2.279966] ehci-pci 0000:00:1a.7: debug port 1
>>
>> [    2.283872] ehci-pci 0000:00:1a.7: cache line size of 32 is not
>> supported
>>
>> [    2.283885] ehci-pci 0000:00:1a.7: irq 18, io mem 0xff9fb400
>>
>> [    2.289048] ehci-pci 0000:00:1a.7: USB 2.0 started, EHCI 1.00
>>
>> [    2.289291] hub 1-0:1.0: USB hub found
>>
>> [    2.289303] hub 1-0:1.0: 4 ports detected
>>
>> [    2.289515] ehci-pci 0000:00:1d.7: EHCI Host Controller
>>
>> [    2.289521] ehci-pci 0000:00:1d.7: new USB bus registered, assigned
>> bus number 2
>>
>> [    2.289531] ehci-pci 0000:00:1d.7: debug port 1
>>
>> [    2.293424] ehci-pci 0000:00:1d.7: cache line size of 32 is not
>> supported
>>
>> [    2.293436] ehci-pci 0000:00:1d.7: irq 23, io mem 0xff9fb000
>>
>> [    2.299045] ehci-pci 0000:00:1d.7: USB 2.0 started, EHCI 1.00
>>
>> [    2.299286] hub 2-0:1.0: USB hub found
>>
>> [    2.299295] hub 2-0:1.0: 6 ports detected
>>
>> [    2.299460] uhci_hcd: USB Universal Host Controller Interface driver
>>
>> [    2.299543] uhci_hcd 0000:00:1a.0: UHCI Host Controller
>>
>> [    2.299550] uhci_hcd 0000:00:1a.0: new USB bus registered, assigned
>> bus number 3
>>
>> [    2.299556] uhci_hcd 0000:00:1a.0: detected 2 ports
>>
>> [    2.299581] uhci_hcd 0000:00:1a.0: irq 16, io base 0x0000e000
>>
>> [    2.299774] hub 3-0:1.0: USB hub found
>>
>> [    2.299797] hub 3-0:1.0: 2 ports detected
>>
>> [    2.299951] uhci_hcd 0000:00:1a.1: UHCI Host Controller
>>
>> [    2.299958] uhci_hcd 0000:00:1a.1: new USB bus registered, assigned
>> bus number 4
>>
>> [    2.299964] uhci_hcd 0000:00:1a.1: detected 2 ports
>>
>> [    2.299987] uhci_hcd 0000:00:1a.1: irq 21, io base 0x0000dc00
>>
>> [    2.300183] hub 4-0:1.0: USB hub found
>>
>> [    2.300208] hub 4-0:1.0: 2 ports detected
>>
>> [    2.300388] uhci_hcd 0000:00:1d.0: UHCI Host Controller
>>
>> [    2.300395] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned
>> bus number 5
>>
>> [    2.300401] uhci_hcd 0000:00:1d.0: detected 2 ports
>>
>> [    2.300418] uhci_hcd 0000:00:1d.0: irq 23, io base 0x0000d880
>>
>> [    2.300584] hub 5-0:1.0: USB hub found
>>
>> [    2.300607] hub 5-0:1.0: 2 ports detected
>>
>> [    2.300751] uhci_hcd 0000:00:1d.1: UHCI Host Controller
>>
>> [    2.300758] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned
>> bus number 6
>>
>> [    2.300764] uhci_hcd 0000:00:1d.1: detected 2 ports
>>
>> [    2.300787] uhci_hcd 0000:00:1d.1: irq 19, io base 0x0000d800
>>
>> [    2.300975] hub 6-0:1.0: USB hub found
>>
>> [    2.301018] hub 6-0:1.0: 2 ports detected
>>
>> [    2.301173] uhci_hcd 0000:00:1d.2: UHCI Host Controller
>>
>> [    2.301180] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned
>> bus number 7
>>
>> [    2.301186] uhci_hcd 0000:00:1d.2: detected 2 ports
>>
>> [    2.301204] uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000d480
>>
>> [    2.301385] hub 7-0:1.0: USB hub found
>>
>> [    2.301413] hub 7-0:1.0: 2 ports detected
>>
>> [    2.301584] usbcore: registered new interface driver cdc_acm
>>
>> [    2.301586] cdc_acm: USB Abstract Control Model driver for USB modems
>> and ISDN adapters
>>
>> [    2.301607] usbcore: registered new interface driver usblp
>>
>> [    2.301643] usbcore: registered new interface driver usb-storage
>>
>> [    2.301691] i8042: PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64
>> irq 1
>>
>> [    2.301693] i8042: PNP: PS/2 appears to have AUX port disabled, if
>> this is incorrect please boot with i8042.nopnp
>>
>> [    2.302419] serio: i8042 KBD port at 0x60,0x64 irq 1
>>
>> [    2.303448] rtc_cmos 00:01: RTC can wake from S4
>>
>> [    2.303609] rtc_cmos 00:01: rtc core: registered rtc_cmos as rtc0
>>
>> [    2.303630] rtc_cmos 00:01: alarms up to one month, y3k, 114 bytes 
>> nvram
>>
>> [    2.303644] i2c /dev entries driver
>>
>> [    2.304042] i801_smbus 0000:00:1f.3: SMBus using PCI interrupt
>>
>> [    2.306134] coretemp coretemp.0: Using relative temperature scale!
>>
>> [    2.306150] coretemp coretemp.0: Using relative temperature scale!
>>
>> [    2.306163] coretemp coretemp.0: Using relative temperature scale!
>>
>> [    2.306178] coretemp coretemp.0: Using relative temperature scale!
>>
>> [    2.306289] w83627ehf: Found W83627DHG chip at 0xa10
>>
>> [    2.306670] md: raid0 personality registered for level 0
>>
>> [    2.306674] md: raid1 personality registered for level 1
>>
>> [    2.306677] md: raid10 personality registered for level 10
>>
>> [    2.309405] md: raid6 personality registered for level 6
>>
>> [    2.309409] md: raid5 personality registered for level 5
>>
>> [    2.309411] md: raid4 personality registered for level 4
>>
>> [    2.309604] device-mapper: ioctl: 4.34.0-ioctl (2015-10-28)
>> initialised:dm-devel@redhat.com
>>
>> [    2.310108] usbcore: registered new interface driver btusb
>>
>> [    2.310189] usbcore: registered new interface driver usbhid
>>
>> [    2.310190] usbhid: USB HID core driver
>>
>> [    2.310452] ip_tables: (C) 2000-2006 Netfilter Core Team
>>
>> [    2.310829] NET: Registered protocol family 10
>>
>> [    2.311209] NET: Registered protocol family 17
>>
>> [    2.311233] 8021q: 802.1Q VLAN Support v1.8
>>
>> [    2.311248] Key type dns_resolver registered
>>
>> [    2.311447] readynas_io_init: initializing ReadyNAS I/O.
>>
>> [    2.311449] procfs_init: initializing ReadyNAS procfs.
>>
>> [    2.311455] ReadyNAS model: To Be Filled By O.E.M.
>>
>> [    2.311483] pwr_button_state_init: initializing ReadyNAS PWR button
>> state handler .
>>
>> [    2.311489] button_init: initializing ReadyNAS button set.
>>
>> [    2.311492] __button_init: button 'backup' gpio_ich:15 (POLL)
>>
>> [    2.311502] __button_init: button 'reset' gpio_ich:8 (POLL)
>>
>> [    2.312880] input: rn_button as /devices/virtual/input/input3
>>
>> [    2.312938] readynas_io_init: initialization successfully completed.
>>
>> [    2.313019] readynas_lcd_init: installing ReadyNAS LCD driver.
>>
>> [    2.313087] readynas_led_init: installing ReadyNAS LED driver.
>>
>> [    2.314957] register_led: registering LED "readynas:green:backup"
>>
>> [    2.315213] microcode: CPU0 sig=0x6fb, pf=0x10, revision=0xb6
>>
>> [    2.315222] microcode: CPU1 sig=0x6fb, pf=0x10, revision=0xb6
>>
>> [    2.315231] microcode: CPU2 sig=0x6fb, pf=0x10, revision=0xb6
>>
>> [    2.315239] microcode: CPU3 sig=0x6fb, pf=0x10, revision=0xb6
>>
>> [    2.315305] microcode: Microcode Update Driver: v2.01
>> <tigran@aivazian.fsnet.co.uk>, Peter Oruba
>>
>> [    2.315516] registered taskstats version 1
>>
>> [    2.318139] Btrfs loaded, crc32c=crc32c-generic
>>
>> [    2.319040] hdaudio hdaudioC0D0: Unable to bind the codec
>>
>> [    2.324456] rtc_cmos 00:01: setting system clock to 2022-06-30
>> 03:45:45 UTC (1656560745)
>>
>> [    2.324599] ALSA device list:
>>
>> [    2.324602]   No soundcards found.
>>
>> [    2.474033] do_marvell_9170_recover: ignoring PCI device (8086:2821)
>> at PCI#0
>>
>> [    2.474044] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
>>
>> [    2.474590] ata1.00: ATA-9: WDC WD30EFRX-68EUZN0, 80.00A80, max 
>> UDMA/133
>>
>> [    2.474594] ata1.00: 5860533168 sectors, multi 0: LBA48 NCQ (depth
>> 31/32), AA
>>
>> [    2.475220] ata1.00: configured for UDMA/133
>>
>> [    2.475452] scsi 0:0:0:0: Direct-Access     ATA      WDC WD30EFRX-68E
>> 0A80 PQ: 0 ANSI: 5
>>
>> [    2.475760] sd 0:0:0:0: [sda] 5860533168 512-byte logical blocks:
>> (3.00 TB/2.73 TiB)
>>
>> [    2.475763] sd 0:0:0:0: [sda] 4096-byte physical blocks
>>
>> [    2.475815] sd 0:0:0:0: [sda] Write Protect is off
>>
>> [    2.475819] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
>>
>> [    2.475841] sd 0:0:0:0: [sda] Write cache: enabled, read cache:
>> enabled, doesn't support DPO or FUA
>>
>> [    2.476084] sd 0:0:0:0: Attached scsi generic sg0 type 0
>>
>> [    2.522051]  sda: sda1 sda2 sda3
>>
>> [    2.522379] sd 0:0:0:0: [sda] Attached SCSI disk
>>
>> [    2.601041] usb 2-1: new high-speed USB device number 2 using 
>> ehci-pci
>>
>> [    2.717033] usb-storage 2-1:1.0: USB Mass Storage device detected
>>
>> [    2.717115] usb-storage 2-1:1.0: Quirks match for vid 090c pid 
>> 1000: 400
>>
>> [    2.717139] scsi host6: usb-storage 2-1:1.0
>>
>> [    2.781032] do_marvell_9170_recover: ignoring PCI device (8086:2821)
>> at PCI#0
>>
>> [    2.781042] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
>>
>> [    2.795031] ata2.00: ATA-11: ST4000NE001-2MA101, EN01, max UDMA/133
>>
>> [    2.795035] ata2.00: 7814037168 sectors, multi 16: LBA48 NCQ (depth
>> 31/32), AA
>>
>> [    2.808741] ata2.00: configured for UDMA/133
>>
>> [    2.808933] scsi 1:0:0:0: Direct-Access     ATA ST4000NE001-2MA1
>> EN01 PQ: 0 ANSI: 5
>>
>> [    2.809213] sd 1:0:0:0: [sdb] 7814037168 512-byte logical blocks:
>> (4.00 TB/3.64 TiB)
>>
>> [    2.809216] sd 1:0:0:0: [sdb] 4096-byte physical blocks
>>
>> [    2.809267] sd 1:0:0:0: [sdb] Write Protect is off
>>
>> [    2.809270] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
>>
>> [    2.809292] sd 1:0:0:0: [sdb] Write cache: enabled, read cache:
>> enabled, doesn't support DPO or FUA
>>
>> [    2.809375] sd 1:0:0:0: Attached scsi generic sg1 type 0
>>
>> [    2.847249]  sdb: sdb1 sdb2 sdb3 sdb4
>>
>> [    2.847649] sd 1:0:0:0: [sdb] Attached SCSI disk
>>
>> [    3.061040] tsc: Refined TSC clocksource calibration: 2659.998 MHz
>>
>> [    3.061046] clocksource: tsc: mask: 0xffffffffffffffff max_cycles:
>> 0x2657a1d9103, max_idle_ns: 440795229008 ns
>>
>> [    3.114032] do_marvell_9170_recover: ignoring PCI device (8086:2821)
>> at PCI#0
>>
>> [    3.114043] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
>>
>> [    3.128035] ata3.00: ATA-11: ST4000NE001-2MA101, EN01, max UDMA/133
>>
>> [    3.128040] ata3.00: 7814037168 sectors, multi 16: LBA48 NCQ (depth
>> 31/32), AA
>>
>> [    3.141737] ata3.00: configured for UDMA/133
>>
>> [    3.141929] scsi 2:0:0:0: Direct-Access     ATA ST4000NE001-2MA1
>> EN01 PQ: 0 ANSI: 5
>>
>> [    3.142203] sd 2:0:0:0: [sdc] 7814037168 512-byte logical blocks:
>> (4.00 TB/3.64 TiB)
>>
>> [    3.142207] sd 2:0:0:0: [sdc] 4096-byte physical blocks
>>
>> [    3.142258] sd 2:0:0:0: [sdc] Write Protect is off
>>
>> [    3.142261] sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
>>
>> [    3.142284] sd 2:0:0:0: [sdc] Write cache: enabled, read cache:
>> enabled, doesn't support DPO or FUA
>>
>> [    3.142475] sd 2:0:0:0: Attached scsi generic sg2 type 0
>>
>> [    3.185724]  sdc: sdc1 sdc2 sdc3 sdc4
>>
>> [    3.186153] sd 2:0:0:0: [sdc] Attached SCSI disk
>>
>> [    3.394037] usb 6-1: new full-speed USB device number 2 using 
>> uhci_hcd
>>
>> [    3.447032] do_marvell_9170_recover: ignoring PCI device (8086:2821)
>> at PCI#0
>>
>> [    3.447043] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
>>
>> [    3.447587] ata4.00: ATA-10: WDC WD40EFRX-68N32N0, 82.00A82, max
>> UDMA/133
>>
>> [    3.447591] ata4.00: 7814037168 sectors, multi 16: LBA48 NCQ (depth
>> 31/32), AA
>>
>> [    3.448159] ata4.00: configured for UDMA/133
>>
>> [    3.448410] scsi 3:0:0:0: Direct-Access     ATA      WDC WD40EFRX-68N
>> 0A82 PQ: 0 ANSI: 5
>>
>> [    3.448789] sd 3:0:0:0: [sdd] 7814037168 512-byte logical blocks:
>> (4.00 TB/3.64 TiB)
>>
>> [    3.448792] sd 3:0:0:0: [sdd] 4096-byte physical blocks
>>
>> [    3.448847] sd 3:0:0:0: [sdd] Write Protect is off
>>
>> [    3.448850] sd 3:0:0:0: [sdd] Mode Sense: 00 3a 00 00
>>
>> [    3.448873] sd 3:0:0:0: [sdd] Write cache: enabled, read cache:
>> enabled, doesn't support DPO or FUA
>>
>> [    3.449186] sd 3:0:0:0: Attached scsi generic sg3 type 0
>>
>> [    3.493627]  sdd: sdd1 sdd2 sdd3 sdd4
>>
>> [    3.494094] sd 3:0:0:0: [sdd] Attached SCSI disk
>>
>> [    3.754033] do_marvell_9170_recover: ignoring PCI device (8086:2821)
>> at PCI#0
>>
>> [    3.754044] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
>>
>> [    3.754592] ata5.00: ATA-10: WDC WD40EFRX-68N32N0, 82.00A82, max
>> UDMA/133
>>
>> [    3.754597] ata5.00: 7814037168 sectors, multi 16: LBA48 NCQ (depth
>> 31/32), AA
>>
>> [    3.755175] ata5.00: configured for UDMA/133
>>
>> [    3.755334] scsi 4:0:0:0: Direct-Access     ATA      WDC WD40EFRX-68N
>> 0A82 PQ: 0 ANSI: 5
>>
>> [    3.755709] sd 4:0:0:0: [sde] 7814037168 512-byte logical blocks:
>> (4.00 TB/3.64 TiB)
>>
>> [    3.755712] sd 4:0:0:0: [sde] 4096-byte physical blocks
>>
>> [    3.755764] sd 4:0:0:0: [sde] Write Protect is off
>>
>> [    3.755767] sd 4:0:0:0: [sde] Mode Sense: 00 3a 00 00
>>
>> [    3.755790] sd 4:0:0:0: [sde] Write cache: enabled, read cache:
>> enabled, doesn't support DPO or FUA
>>
>> [    3.756074] sd 4:0:0:0: Attached scsi generic sg4 type 0
>>
>> [    3.794711]  sde: sde1 sde2 sde3 sde4
>>
>> [    3.795199] sd 4:0:0:0: [sde] Attached SCSI disk
>>
>> [    3.834190] hid-generic 0003:051D:0002.0001: hiddev0: USB HID v1.00
>> Device [American Power Conversion Back-UPS RS 1500MS FW:952.e3 .D USB
>> FW:e3     ] on usb-0000:00:1d.1-1/input0
>>
>> [    4.061032] do_marvell_9170_recover: ignoring PCI device (8086:2821)
>> at PCI#0
>>
>> [    4.061044] ata6: SATA link down (SStatus 0 SControl 300)
>>
>> [    4.061652] Freeing unused kernel memory: 872K
>>
>> [    4.061670] clocksource: Switched to clocksource tsc
>>
>> [    4.064542] vpd: loading out-of-tree module taints kernel.
>>
>> [    4.064547] vpd: module license 'Proprietary' taints kernel.
>>
>> [    4.064549] Disabling lock debugging due to kernel taint
>>
>> [    4.064661] ReadyNAS VPD init
>>
>> [    7.631092] nv6lcd v3.1 loaded.
>>
>> [    7.727886] scsi 6:0:0:0: Direct-Access     SMI      USB DISK 1100
>> PQ: 0 ANSI: 0 CCS
>>
>> [    7.728297] sd 6:0:0:0: Attached scsi generic sg5 type 0
>>
>> [    7.728300] sd 6:0:0:0: Embedded Enclosure Device
>>
>> [    7.729368] sd 6:0:0:0: Wrong diagnostic page; asked for 1 got 0
>>
>> [    7.729747] sd 6:0:0:0: [sdf] 250880 512-byte logical blocks: (128
>> MB/123 MiB)
>>
>> [    7.730615] sd 6:0:0:0: [sdf] Write Protect is off
>>
>> [    7.730617] sd 6:0:0:0: [sdf] Mode Sense: 43 00 00 00
>>
>> [    7.731489] sd 6:0:0:0: [sdf] No Caching mode page found
>>
>> [    7.731490] sd 6:0:0:0: [sdf] Assuming drive cache: write through
>>
>> [    7.735123]  sdf: sdf1
>>
>> [    7.737365] sd 6:0:0:0: [sdf] Attached SCSI removable disk
>>
>> [    7.746853] sd 6:0:0:0: Failed to get diagnostic page 0xffffffea
>>
>> [    7.752858] sd 6:0:0:0: Failed to bind enclosure -19
>>
>> [   20.336052] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
>>
>> [   20.338949] IPv6: ADDRCONF(NETDEV_UP): eth1: link is not ready
>>
>> [   21.359543] random: nonblocking pool is initialized
>>
>> [   22.700903] eth1: network connection up using port A
>>
>> [   22.700903]     interrupt src:   MSI
>>
>> [   22.700903]     speed:           1000
>>
>> [   22.700903]     autonegotiation: yes
>>
>> [   22.700903]     duplex mode:     full
>>
>> [   22.700903]     flowctrl:        none
>>
>> [   22.700903]     role:            slave
>>
>> [   22.700903]     tcp offload: enabled
>>
>> [   22.700903]     scatter-gather: enabled
>>
>> [   22.700903]     tx-checksum: enabled
>>
>> [   22.700903]     rx-checksum: enabled
>>
>> [   22.700903]     rx-polling: enabled
>>
>> [   22.700903] IPv6: ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready
>>
>> [   22.789894] eth0: network connection up using port A
>>
>> [   22.789894]     interrupt src:   MSI
>>
>> [   22.789894]     speed:           1000
>>
>> [   22.789894]     autonegotiation: yes
>>
>> [   22.789894]     duplex mode:     full
>>
>> [   22.789894]     flowctrl:        none
>>
>> [   22.789894]     role:            slave
>>
>> [   22.789894]     tcp offload: enabled
>>
>> [   22.789894]     scatter-gather: enabled
>>
>> [   22.789894]     tx-checksum: enabled
>>
>> [   22.789894]     rx-checksum: enabled
>>
>> [   22.789894]     rx-polling: enabled
>>
>> [   22.789894] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
>>
>> [   29.469809] md: md0 stopped.
>>
>> [   29.470692] md: bind<sdb1>
>>
>> [   29.470859] md: bind<sdc1>
>>
>> [   29.470997] md: bind<sdd1>
>>
>> [   29.471172] md: bind<sde1>
>>
>> [   29.471295] md: bind<sda1>
>>
>> [   29.473870] md/raid1:md0: active with 5 out of 5 mirrors
>>
>> [   29.473956] md0: detected capacity change from 0 to 4290772992
>>
>> [   29.489973] md: md1 stopped.
>>
>> [   29.490924] md: bind<sdc2>
>>
>> [   29.491113] md: bind<sdd2>
>>
>> [   29.491258] md: bind<sde2>
>>
>> [   29.491440] md: bind<sdb2>
>>
>> [   29.491580] md: bind<sda2>
>>
>> [   29.492180] md/raid10:md1: active with 5 out of 5 devices
>>
>> [   29.492275] md1: detected capacity change from 0 to 1336934400
>>
>> [   29.902166] BTRFS: device label 33ea130b:root devid 1 transid 1525025
>> /dev/md0
>>
>> [   29.902551] BTRFS info (device md0): has skinny extents
>>
>> [   30.813394] systemd[1]: Failed to insert module 'kdbus': Function not
>> implemented
>>
>> [   30.816561] systemd[1]: systemd 230 running in system mode. (+PAM
>> +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP
>> +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN)
>>
>> [   30.816755] systemd[1]: Detected architecture x86-64.
>>
>> [   30.821162] systemd[1]: Set hostname to <nas>.
>>
>> [   30.961126] systemd[1]: systemd-journald-audit.socket: Cannot add
>> dependency job, ignoring: Unit systemd-journald-audit.socket is masked.
>>
>> [   30.961195] systemd[1]: systemd-journald-audit.socket: Cannot add
>> dependency job, ignoring: Unit systemd-journald-audit.socket is masked.
>>
>> [   30.961958] systemd[1]: Set up automount Arbitrary Executable File
>> Formats File System Automount Point.
>>
>> [   30.972146] systemd[1]: Created slice User and Session Slice.
>>
>> [   30.978124] systemd[1]: Listening on Journal Socket (/dev/log).
>>
>> [   30.984114] systemd[1]: Listening on udev Control Socket.
>>
>> [   30.990121] systemd[1]: Created slice System Slice.
>>
>> [   30.996083] systemd[1]: Reached target Slices.
>>
>> [   31.000064] systemd[1]: Reached target Remote File Systems (Pre).
>>
>> [   31.006129] systemd[1]: Created slice system-getty.slice.
>>
>> [   31.012137] systemd[1]: Started Forward Password Requests to Wall
>> Directory Watch.
>>
>> [   31.021113] systemd[1]: Listening on /dev/initctl Compatibility Named
>> Pipe.
>>
>> [   31.028127] systemd[1]: Listening on Journal Socket.
>>
>> [   31.039179] systemd[1]: Starting Create Static Device Nodes in 
>> /dev...
>>
>> [   31.045658] systemd[1]: Starting Journal Service...
>>
>> [   31.050823] systemd[1]: Starting Load Kernel Modules...
>>
>> [   31.055736] systemd[1]: Mounting POSIX Message Queue File System...
>>
>> [   31.061761] systemd[1]: Started ReadyNAS LCD splasher.
>>
>> [   31.067831] systemd[1]: Starting ReadyNASOS system prep...
>>
>> [   31.072107] systemd[1]: Reached target Remote File Systems.
>>
>> [   31.078136] systemd[1]: Listening on udev Kernel Socket.
>>
>> [   31.084181] systemd[1]: Created slice system-serial\x2dgetty.slice.
>>
>> [   31.099501] systemd[1]: Mounting Debug File System...
>>
>> [   31.104203] systemd[1]: Reached target Encrypted Volumes.
>>
>> [   31.111731] systemd[1]: Starting Remount Root and Kernel File 
>> Systems...
>>
>> [   31.118206] systemd[1]: Started Dispatch Password Requests to Console
>> Directory Watch.
>>
>> [   31.127120] systemd[1]: Reached target Paths.
>>
>> [   31.141394] systemd[1]: Mounted Debug File System.
>>
>> [   31.146116] systemd[1]: Mounted POSIX Message Queue File System.
>>
>> [   31.152322] systemd[1]: Started Load Kernel Modules.
>>
>> [   31.158382] systemd[1]: Started Create Static Device Nodes in /dev.
>>
>> [   31.165420] systemd[1]: Started ReadyNASOS system prep.
>>
>> [   31.171379] systemd[1]: Started Remount Root and Kernel File Systems.
>>
>> [   31.185199] systemd[1]: Starting Load/Save Random Seed...
>>
>> [   31.190782] systemd[1]: Starting Rebuild Hardware Database...
>>
>> [   31.197725] systemd[1]: Starting udev Kernel Device Manager...
>>
>> [   31.203724] systemd[1]: Starting Apply Kernel Variables...
>>
>> [   31.208719] systemd[1]: Mounting FUSE Control File System...
>>
>> [   31.213707] systemd[1]: Mounting Configuration File System...
>>
>> [   31.219475] systemd[1]: Mounted FUSE Control File System.
>>
>> [   31.225160] systemd[1]: Mounted Configuration File System.
>>
>> [   31.231339] systemd[1]: Started Load/Save Random Seed.
>>
>> [   31.238326] systemd[1]: Started Apply Kernel Variables.
>>
>> [   31.306716] systemd[1]: Started udev Kernel Device Manager.
>>
>> [   31.322191] systemd[1]: Starting MD arrays...
>>
>> [   31.487875] systemd[1]: Started Journal Service.
>>
>> [   31.520876] systemd-journald[1420]: Received request to flush runtime
>> journal from PID 1
>>
>> [   32.202932] md: md127 stopped.
>>
>> [   32.203990] md: bind<sdb3>
>>
>> [   32.204155] md: bind<sdc3>
>>
>> [   32.204286] md: bind<sdd3>
>>
>> [   32.204422] md: bind<sde3>
>>
>> [   32.204560] md: bind<sda3>
>>
>> [   32.217830] md/raid:md127: device sda3 operational as raid disk 0
>>
>> [   32.217835] md/raid:md127: device sde3 operational as raid disk 4
>>
>> [   32.217838] md/raid:md127: device sdd3 operational as raid disk 3
>>
>> [   32.217841] md/raid:md127: device sdc3 operational as raid disk 2
>>
>> [   32.217844] md/raid:md127: device sdb3 operational as raid disk 1
>>
>> [   32.218402] md/raid:md127: allocated 5418kB
>>
>> [   32.218445] md/raid:md127: raid level 5 active with 5 out of 5
>> devices, algorithm 2
>>
>> [   32.218449] RAID conf printout:
>>
>> [   32.218451]  --- level:5 rd:5 wd:5
>>
>> [   32.218454]  disk 0, o:1, dev:sda3
>>
>> [   32.218457]  disk 1, o:1, dev:sdb3
>>
>> [   32.218460]  disk 2, o:1, dev:sdc3
>>
>> [   32.218463]  disk 3, o:1, dev:sdd3
>>
>> [   32.218471]  disk 4, o:1, dev:sde3
>>
>> [   32.218580] md127: detected capacity change from 0 to 11982507343872
>>
>> [   32.390150] Adding 1305596k swap on /dev/md1.  Priority:-1 extents:1
>> across:1305596k
>>
>> [   32.568400] BTRFS: device label 33ea130b:data devid 1 transid 3240438
>> /dev/md127
>>
>> [   32.795849] md: md126 stopped.
>>
>> [   32.796664] md: bind<sde4>
>>
>> [   32.796784] md: bind<sdc4>
>>
>> [   32.796900] md: bind<sdb4>
>>
>> [   32.797136] md: bind<sdd4>
>>
>> [   32.797897] md/raid:md126: device sdd4 operational as raid disk 0
>>
>> [   32.797901] md/raid:md126: device sdb4 operational as raid disk 3
>>
>> [   32.797903] md/raid:md126: device sdc4 operational as raid disk 2
>>
>> [   32.797904] md/raid:md126: device sde4 operational as raid disk 1
>>
>> [   32.798455] md/raid:md126: allocated 4362kB
>>
>> [   32.798760] md/raid:md126: raid level 5 active with 4 out of 4
>> devices, algorithm 2
>>
>> [   32.798762] RAID conf printout:
>>
>> [   32.798764]  --- level:5 rd:4 wd:4
>>
>> [   32.798765]  disk 0, o:1, dev:sdd4
>>
>> [   32.798767]  disk 1, o:1, dev:sde4
>>
>> [   32.798769]  disk 2, o:1, dev:sdc4
>>
>> [   32.798771]  disk 3, o:1, dev:sdb4
>>
>> [   32.798854] md126: detected capacity change from 0 to 3000179490816
>>
>> [   32.905771] BTRFS: device label 33ea130b:data devid 2 transid 3240438
>> /dev/md126
>>
>> [   33.189453] BTRFS info (device md126): has skinny extents
>>
>> [   35.277853] BTRFS critical (device md126): corrupt node: root=1
>> block=13404298215424 slot=307, unaligned pointer, have
>> 12567101254720864896 should be aligned to 4096
>>
>> [   35.298299] BTRFS critical (device md126): corrupt node: root=1
>> block=13404298215424 slot=307, unaligned pointer, have
>> 12567101254720864896 should be aligned to 4096
>>
>> [   35.298341] BTRFS error (device md126): failed to read block 
>> groups: -5
>>
>> [   35.299177] BTRFS error (device md126): failed to read block 
>> groups: -17
>>
>> [   35.379488] BTRFS error (device md126): failed to read block 
>> groups: -17
>>
>> [   35.445317] BTRFS error (device md126): failed to read block 
>> groups: -17
>>
>> [   35.708498] BTRFS error (device md126): failed to read block 
>> groups: -17
>>
>> [   35.729143] BTRFS error (device md126): open_ctree failed
>>
>> [   36.067098] bonding: bond0 is being created...
>>
>> [   36.072256] IPv6: ADDRCONF(NETDEV_UP): bond0: link is not ready
>>
>> [   36.072260] 8021q: adding VLAN 0 to HW filter on device bond0
>>
>> [   36.072653] bond0: Setting min links value to 1
>>
>> [   36.072744] bond0: Setting MII monitoring interval to 100
>>
>> [   36.072788] bond0: Setting xmit hash policy to layer2 (0)
>>
>> [   36.075361] eth0: network connection down
>>
>> [   36.078790] bond0: Adding slave eth0
>>
>> [   36.082048] bond0: Enslaving eth0 as a backup interface with a 
>> down link
>>
>> [   36.095452] eth1: network connection down
>>
>> [   36.100443] bond0: Adding slave eth1
>>
>> [   36.103517] bond0: Enslaving eth1 as a backup interface with a 
>> down link
>>
>> [   36.103741] IPv6: ADDRCONF(NETDEV_UP): bond0: link is not ready
>>
>> [   36.103744] 8021q: adding VLAN 0 to HW filter on device bond0
>>
>> [   36.104163] IPv6: ADDRCONF(NETDEV_UP): bond0: link is not ready
>>
>> [   36.104165] 8021q: adding VLAN 0 to HW filter on device bond0
>>
>> [   39.250788] eth0: network connection up using port A
>>
>> [   39.250788]     interrupt src:   MSI
>>
>> [   39.250788]     speed:           1000
>>
>> [   39.250788]     autonegotiation: yes
>>
>> [   39.250788]     duplex mode:     full
>>
>> [   39.250788]     flowctrl:        none
>>
>> [   39.250788]     role:            slave
>>
>> [   39.250788]     tcp offload: enabled
>>
>> [   39.250788]     scatter-gather: enabled
>>
>> [   39.250788]     tx-checksum: enabled
>>
>> [   39.250788]     rx-checksum: enabled
>>
>> [   39.250788]     rx-polling: enabled
>>
>> [   39.310027] bond0: link status definitely up for interface eth0, 1000
>> Mbps full duplex
>>
>> [   39.310036] bond0: now running without any active interface!
>>
>> [   39.310166] IPv6: ADDRCONF(NETDEV_CHANGE): bond0: link becomes ready
>>
>> [   39.377955] eth1: network connection up using port A
>>
>> [   39.377955]     interrupt src:   MSI
>>
>> [   39.377955]     speed:           1000
>>
>> [   39.377955]     autonegotiation: yes
>>
>> [   39.377955]     duplex mode:     full
>>
>> [   39.377955]     flowctrl:        none
>>
>> [   39.377955]     role:            slave
>>
>> [   39.377955]     tcp offload: enabled
>>
>> [   39.377955]     scatter-gather: enabled
>>
>> [   39.377955]     tx-checksum: enabled
>>
>> [   39.377955]     rx-checksum: enabled
>>
>> [   39.377955]     rx-polling: enabled
>>
>> [   39.410041] bond0: link status definitely up for interface eth1, 1000
>> Mbps full duplex
>>
