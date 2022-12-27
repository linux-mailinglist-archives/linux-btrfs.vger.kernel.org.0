Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1E96570F8
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Dec 2022 00:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbiL0XVA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Dec 2022 18:21:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiL0XU6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Dec 2022 18:20:58 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A73DEB3
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Dec 2022 15:20:55 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MyKHc-1ow33T3FFM-00yivb; Wed, 28
 Dec 2022 00:20:48 +0100
Message-ID: <5ce6e59d-6c79-4d15-aa8a-990a299cd20c@gmx.com>
Date:   Wed, 28 Dec 2022 07:20:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: recurring corruption with latest kernels
To:     Oliver Neukum <oneukum@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <148b838a-897a-90d6-7e6b-564238d58eb0@suse.com>
 <ddc034c6-655d-c3f1-8d69-544b743b7ac9@gmx.com>
 <3dbe35f1-0815-73d9-f53e-86aacabf13e8@suse.com>
 <4531be20-470e-9984-6535-fd822c6c157e@gmx.com>
 <f6987484-b084-c6f8-31b4-dd2e3f3eb9d5@suse.com>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <f6987484-b084-c6f8-31b4-dd2e3f3eb9d5@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:poeOR7Dt9QKRh/9O8ZgeDd8QvAT6/AWAbiW/LiZ6jm85mLMShsF
 e/Uhel70GXEYxJsk1kqnPe9mS+Y2XOFTDjicKl6VoN36s44nz5AoNbz7ZkrdA7LdiFATiEr
 fKxeg1yHAkyQ2ULI6q85H+RgpsBSmMFMDf+NLtRkc+sqBIF8FYDuX+eyE6/sK/Dm+Ozo21l
 Mu9RWNL82EtbcsaI5HmYg==
UI-OutboundReport: notjunk:1;M01:P0:ZswOGk1kTOg=;VXnJr/EDRYZGZKomcogcr2bWOFn
 t2zY8Nmeu9SCvPkUD8gocwB9B2SJkKtvZcgJyMuMuJLtz1pDUEMgggLLx68fJdtbnQSUXkmc/
 Ntj74uMVkSkL2kl3j4dLh+4/j8ECHB0hoFBdkkbv8LAy5SJOAbLbgEm8yBO0gWaaE3FARmnMn
 FB+HjSWBFlGFUoJfcs9DQg457B6lEm823zocUZT0bl0gljhcCSb3P58myXQ404ZjJXKPAnttA
 VVxYxPs8OyjvTFTcagl3myK+jNvQ6PFxd76Cndtbk91sPyD0EBhVqfkk+NxImCZKCtK1xK0N2
 3x3ZmR7lXl/+mFLC/9dqCeRMDWvIAQV8ZeS7m7BEfYBRJhvOL6XNRJjKAXbOFxOlWbfhcIrxA
 /gxm+2R16jt/3Ir0u/hMemopfeEE4PEz20y5egbwON9N5r6qx2ZyyEQ5uUwo3rDdMn6lex4vG
 Ufq+RZm5VHtPOerVIqPRCC8HjjBBXTx6uOmtPIzv2J+DqEJKY2jDdZaM1DUZvaqrxEKNbXMKu
 5BsW3s5EIpXpFy3Fy3sMj1RJWUSK3fGzJLZE/EnKCETSwZiIevFQ4LUcgOGiI6rYIFO3vQtZw
 TsjpP5yuyBhYVTMFA+W35OLn+SMkDn+hoWXE2ZFyEqKPT4p27ndmKkwYs3qHpSDG9/ps2wIL9
 KxEdEnb47vxR61sks6UGJ5AzMn5emZXXcjQn5vExJmriHuMloWsW+pxfxoIjGvWUvr1X+Eg6f
 DrkfotJSddE77pnyq+q6Lx0vu8pBrwXd+ZtZQ0zMnRf5ZNwYD1vs5zs+MT60Voo/TTxEZnRhZ
 a1FRnwowITQD27nFb8AW8PA3KBUO/55v18JxdRb+bybr3pCk8gDfE/6gYazyxYa1dChzhfgTq
 2SBkyL3utggsYQc5v6fMqM7zfjH8Jf8vPnctNhuYfCuK5wrLToYK699N4c9YdvMlz1QZCITzr
 w+Lrs7A606WB9TGCNadKQgbEhF4=
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/12/27 23:47, Oliver Neukum wrote:
> 
> 
> On 22.12.22 00:48, Qu Wenruo wrote:
>>
>>
>> On 2022/12/21 23:00, Oliver Neukum wrote:
> 
>> And when the problem happens, what else did you see in your workload?
> 
> Nothing. I have found no way of triggering this but by just waiting.
>>
>> The system hangs or the fs falls to read-only?
> 
> It goes to read-only.
> 
>> If possible, a uptodate btrfs-progs build and check output would be 
>> more helpful. (You can use tumbleweed ISO as liveCD and run btrfs 
>> check on the fs).
> 
> Latest failure with new tools:
> 
> Opening filesystem to check...
> Checking filesystem on /dev/nvme0n1p2
> UUID: 6b557439-a722-46c6-b9fa-e3395a5f4d40
> Rescan hasn't been initialzied, a difference in qgroup accounting is 
> expected
> Counts for qgroup id: 0/257 are different
> our:        referenced 27139301376 referenced compressed 27139301376
> disk:        referenced 27137921024 referenced compressed 27137921024
> diff:        referenced 1380352 referenced compressed 1380352
> our:        exclusive 27139301376 exclusive compressed 27139301376
> disk:        exclusive 27137921024 exclusive compressed 27137921024
> diff:        exclusive 1380352 exclusive compressed 1380352
> Counts for qgroup id: 0/259 are different
> our:        referenced 1564332032 referenced compressed 1564332032
> disk:        referenced 1536905216 referenced compressed 1536905216
> diff:        referenced 27426816 referenced compressed 27426816
> our:        exclusive 1564332032 exclusive compressed 1564332032
> disk:        exclusive 1536905216 exclusive compressed 1536905216
> diff:        exclusive 27426816 exclusive compressed 27426816
> Counts for qgroup id: 0/265 are different
> our:        referenced 155648 referenced compressed 155648
> disk:        referenced 122880 referenced compressed 122880
> diff:        referenced 32768 referenced compressed 32768
> our:        exclusive 155648 exclusive compressed 155648
> disk:        exclusive 122880 exclusive compressed 122880
> diff:        exclusive 32768 exclusive compressed 32768
> Counts for qgroup id: 0/266 are different
> our:        referenced 125206056960 referenced compressed 125206056960
> disk:        referenced 125205323776 referenced compressed 125205323776
> diff:        referenced 733184 referenced compressed 733184
> our:        exclusive 234156032 exclusive compressed 234156032
> disk:        exclusive 16384 exclusive compressed 16384
> diff:        exclusive 234139648 exclusive compressed 234139648
> Counts for qgroup id: 0/1832 are different
> our:        referenced 125205323776 referenced compressed 125205323776
> disk:        referenced 125205323776 referenced compressed 125205323776
> our:        exclusive 9371648 exclusive compressed 9371648
> disk:        exclusive 16384 exclusive compressed 16384
> diff:        exclusive 9355264 exclusive compressed 9355264
> Counts for qgroup id: 0/1833 are different
> our:        referenced 125209817088 referenced compressed 125209817088
> disk:        referenced 125205323776 referenced compressed 125205323776
> diff:        referenced 4493312 referenced compressed 4493312
> our:        exclusive 7954432 exclusive compressed 7954432
> disk:        exclusive 16384 exclusive compressed 16384
> diff:        exclusive 7938048 exclusive compressed 7938048
> Counts for qgroup id: 1/0 are different
> our:        referenced 125677809664 referenced compressed 125677809664
> disk:        referenced 125564411904 referenced compressed 125564411904
> diff:        referenced 113397760 referenced compressed 113397760
> our:        exclusive 705908736 exclusive compressed 705908736
> disk:        exclusive 397996032 exclusive compressed 397996032
> diff:        exclusive 307912704 exclusive compressed 307912704
> found 154905903104 bytes used, no error found
> total csum bytes: 124005924
> total tree bytes: 884539392
> total fs tree bytes: 677527552
> total extent tree bytes: 55820288
> btree space waste bytes: 150882496
> file data blocks allocated: 187945013248
>   referenced 175985745920
> 
> 
>> And the interesting part in dmesg is not much:
>>
>>    BTRFS warning (device nvme0n1p2): block group 389723193344 has 
>> wrong amount of free space
>>    BTRFS warning (device nvme0n1p2): failed to load free space cache 
>> for block group 389723193344, rebuilding it now
>>
>> This shows that the space cache is not correct, and it needs rebuild.
> 
> [89838.714476] Bluetooth: hci0: Found Intel DDC parameters: 
> intel/ibt-18-16-1.ddc
> [89838.722396] Bluetooth: hci0: Applying Intel DDC parameters completed
> [89838.726428] Bluetooth: hci0: Firmware revision 0.1 build 86 week 46 2021
> [89838.753061] BTRFS error (device nvme0n1p2: state EA): parent transid 
> verify failed on logical 146997903360 mirror 1 wanted 771073 found 770869
> [89838.754038] BTRFS error (device nvme0n1p2: state EA): parent transid 
> verify failed on logical 146997903360 mirror 1 wanted 771073 found 770869
> [89838.777282] BTRFS error (device nvme0n1p2: state EA): parent transid 
> verify failed on logical 146997903360 mirror 1 wanted 771073 found 770869
> [89838.844847] BTRFS error (device nvme0n1p2: state EA): parent transid 
> verify failed on logical 146997903360 mirror 1 wanted 771073 found 770869
> [89838.915502] Bluetooth: MGMT ver 1.22
> [89839.106923] BTRFS error (device nvme0n1p2: state EA): parent transid 
> verify failed on logical 146997903360 mirror 1 wanted 771073 found 770869
> [89839.107102] BTRFS error (device nvme0n1p2: state EA): parent transid 
> verify failed on logical 146997903360 mirror 1 wanted 771073 found 770869
> [89839.119831] BTRFS error (device nvme0n1p2: state EA): parent transid 
> verify failed on logical 146997903360 mirror 1 wanted 771073 found 770869
> [89839.122112] BTRFS error (device nvme0n1p2: state EA): parent transid 
> verify failed on logical 146997903360 mirror 1 wanted 771073 found 770869
> [89839.141460] BTRFS error (device nvme0n1p2: state EA): parent transid 
> verify failed on logical 146997903360 mirror 1 wanted 771073 found 770869
> [89839.702819] r8169 0000:04:00.0 eth1: Link is Up - 100Mbps/Full - flow 
> control rx/tx
> [89839.702836] IPv6: ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready
> [89842.931652] wlan0: authenticate with cc:ce:1e:f4:37:95
> [89842.931690] wlan0: 80 MHz not supported, disabling VHT
> [89842.936987] wlan0: send auth to cc:ce:1e:f4:37:95 (try 1/3)
> [89843.084376] wlan0: send auth to cc:ce:1e:f4:37:95 (try 2/3)
> [89843.201803] wlan0: send auth to cc:ce:1e:f4:37:95 (try 3/3)
> [89843.244013] wlan0: authenticated
> [89843.248371] wlan0: associate with cc:ce:1e:f4:37:95 (try 1/3)
> [89843.267094] wlan0: RX AssocResp from cc:ce:1e:f4:37:95 (capab=0x1431 
> status=0 aid=3)
> [89843.269826] wlan0: associated
> [89843.290208] wlan0: Limiting TX power to 20 (20 - 0) dBm as advertised 
> by cc:ce:1e:f4:37:95
> [89843.456661] IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
> [89917.808164] BTRFS error (device nvme0n1p2: state EA): parent transid 
> verify failed on logical 146997903360 mirror 1 wanted 771073 found 770869
> [89917.809186] BTRFS error (device nvme0n1p2: state EA): parent transid 
> verify failed on logical 146997903360 mirror 1 wanted 771073 found 770869
> [89917.834402] BTRFS error (device nvme0n1p2: state EA): parent transid 
> verify failed on logical 146997903360 mirror 1 wanted 771073 found 770869
> [89917.834573] BTRFS error (device nvme0n1p2: state EA): parent transid 
> verify failed on logical 146997903360 mirror 1 wanted 771073 found 770869
> [89929.522089] r8169 0000:04:00.0 eth1: Link is Down
> [89930.271562] BTRFS error (device nvme0n1p2: state EA): parent transid 
> verify failed on logical 146997903360 mirror 1 wanted 771073 found 770869
> [89930.702286] PM: suspend entry (deep)
> [89930.706132] Filesystems sync: 0.003 seconds
> [89930.777022] Freezing user space processes
> [89930.780125] Freezing user space processes completed (elapsed 0.003 
> seconds)
> [89930.780132] OOM killer disabled.
> [89930.780134] Freezing remaining freezable tasks
> [89930.817977] Freezing remaining freezable tasks completed (elapsed 
> 0.037 seconds)
> [89930.818003] printk: Suspending console(s) (use no_console_suspend to 
> debug)
> [89930.819058] wlan0: deauthenticating from cc:ce:1e:f4:37:95 by local 
> choice (Reason: 3=DEAUTH_LEAVING)
> [89931.361406] ACPI: EC: interrupt blocked
> [89931.426248] ACPI: PM: Preparing to enter system sleep state S3
> [89931.432877] ACPI: EC: event blocked
> [89931.432878] ACPI: EC: EC stopped
> [89931.432879] ACPI: PM: Saving platform NVS memory
> [89931.433101] Disabling non-boot CPUs ...
> [89931.435662] smpboot: CPU 1 is now offline
> [89931.437709] smpboot: CPU 2 is now offline
> [89931.439661] smpboot: CPU 3 is now offline
> [89931.441634] smpboot: CPU 4 is now offline
> [89931.443507] smpboot: CPU 5 is now offline
> [89931.445478] smpboot: CPU 6 is now offline
> [89931.447217] smpboot: CPU 7 is now offline
> [89931.447972] ACPI: PM: Low-level resume complete
> [89931.448002] ACPI: EC: EC started
> [89931.448002] ACPI: PM: Restoring platform NVS memory
> [89931.492881] AMD-Vi: Virtual APIC enabled
> [89931.522906] AMD-Vi: Virtual APIC enabled
> [89931.523491] Enabling non-boot CPUs ...
> [89931.523549] x86: Booting SMP configuration:
> [89931.523550] smpboot: Booting Node 0 Processor 1 APIC 0x1
> [89931.526137] ACPI: \_PR_.C001: Found 2 idle states
> [89931.526506] CPU1 is up
> [89931.526556] smpboot: Booting Node 0 Processor 2 APIC 0x2
> [89931.529127] ACPI: \_PR_.C002: Found 2 idle states
> [89931.529467] CPU2 is up
> [89931.529495] smpboot: Booting Node 0 Processor 3 APIC 0x3
> [89931.532103] ACPI: \_PR_.C003: Found 2 idle states
> [89931.532536] CPU3 is up
> [89931.532558] smpboot: Booting Node 0 Processor 4 APIC 0x4
> [89931.535202] ACPI: \_PR_.C004: Found 2 idle states
> [89931.535702] CPU4 is up
> [89931.535722] smpboot: Booting Node 0 Processor 5 APIC 0x5
> [89931.538296] ACPI: \_PR_.C005: Found 2 idle states
> [89931.538995] CPU5 is up
> [89931.539015] smpboot: Booting Node 0 Processor 6 APIC 0x6
> [89931.541573] ACPI: \_PR_.C006: Found 2 idle states
> [89931.542264] CPU6 is up
> [89931.542287] smpboot: Booting Node 0 Processor 7 APIC 0x7
> [89931.544866] ACPI: \_PR_.C007: Found 2 idle states
> [89931.545690] CPU7 is up
> [89931.547516] ACPI: PM: Waking up from system sleep state S3
> [89932.084201] ACPI: EC: interrupt unblocked
> [89932.154631] ACPI: EC: event unblocked
> [89932.154926] usb usb1: root hub lost power or was reset
> [89932.156560] [drm] PCIE GART of 1024M enabled.
> [89932.156563] [drm] PTB located at 0x000000F400A00000
> [89932.156581] [drm] PSP is resuming...
> [89932.176450] [drm] reserve 0x400000 from 0xf401c00000 for PSP TMR
> [89932.276813] amdgpu 0000:06:00.0: amdgpu: RAS: optional ras ta ucode 
> is not available
> [89932.290965] amdgpu 0000:06:00.0: amdgpu: RAP: optional rap ta ucode 
> is not available
> [89932.290967] amdgpu 0000:06:00.0: amdgpu: SECUREDISPLAY: securedisplay 
> ta ucode is not available
> [89932.291045] amdgpu: restore the fine grain parameters
> [89932.443349] nvme nvme0: 16/0/0 default/read/poll queues
> [89932.444140] usb 4-2: reset high-speed USB device number 3 using xhci_hcd
> [89932.603191] usb 2-1.3.3.1: reset full-speed USB device number 7 using 
> xhci_hcd
> [89932.719101] usb 4-1: reset full-speed USB device number 2 using xhci_hcd
> [89932.966687] [drm] kiq ring mec 2 pipe 1 q 0
> [89932.977509] [drm] VCN decode and encode initialized 
> successfully(under SPG Mode).
> [89932.977524] amdgpu 0000:06:00.0: amdgpu: ring gfx uses VM inv eng 0 
> on hub 0
> [89932.977527] amdgpu 0000:06:00.0: amdgpu: ring gfx_low uses VM inv eng 
> 1 on hub 0
> [89932.977528] amdgpu 0000:06:00.0: amdgpu: ring gfx_high uses VM inv 
> eng 4 on hub 0
> [89932.977530] amdgpu 0000:06:00.0: amdgpu: ring comp_1.0.0 uses VM inv 
> eng 5 on hub 0
> [89932.977531] amdgpu 0000:06:00.0: amdgpu: ring comp_1.1.0 uses VM inv 
> eng 6 on hub 0
> [89932.977532] amdgpu 0000:06:00.0: amdgpu: ring comp_1.2.0 uses VM inv 
> eng 7 on hub 0
> [89932.977533] amdgpu 0000:06:00.0: amdgpu: ring comp_1.3.0 uses VM inv 
> eng 8 on hub 0
> [89932.977535] amdgpu 0000:06:00.0: amdgpu: ring comp_1.0.1 uses VM inv 
> eng 9 on hub 0
> [89932.977536] amdgpu 0000:06:00.0: amdgpu: ring comp_1.1.1 uses VM inv 
> eng 10 on hub 0
> [89932.977537] amdgpu 0000:06:00.0: amdgpu: ring comp_1.2.1 uses VM inv 
> eng 11 on hub 0
> [89932.977539] amdgpu 0000:06:00.0: amdgpu: ring comp_1.3.1 uses VM inv 
> eng 12 on hub 0
> [89932.977540] amdgpu 0000:06:00.0: amdgpu: ring kiq_2.1.0 uses VM inv 
> eng 13 on hub 0
> [89932.977541] amdgpu 0000:06:00.0: amdgpu: ring sdma0 uses VM inv eng 0 
> on hub 1
> [89932.977542] amdgpu 0000:06:00.0: amdgpu: ring vcn_dec uses VM inv eng 
> 1 on hub 1
> [89932.977544] amdgpu 0000:06:00.0: amdgpu: ring vcn_enc0 uses VM inv 
> eng 4 on hub 1
> [89932.977545] amdgpu 0000:06:00.0: amdgpu: ring vcn_enc1 uses VM inv 
> eng 5 on hub 1
> [89932.977546] amdgpu 0000:06:00.0: amdgpu: ring jpeg_dec uses VM inv 
> eng 6 on hub 1
> [89932.988418] usb 4-2.1: reset high-speed USB device number 4 using 
> xhci_hcd
> [89933.023143] psmouse serio1: synaptics: queried max coordinates: x 
> [..5678], y [..4694]
> [89933.067096] psmouse serio1: synaptics: queried min coordinates: x 
> [1266..], y [1162..]
> [89933.180142] usb 4-2.4: reset full-speed USB device number 6 using 
> xhci_hcd
> [89933.372144] usb 4-2.2: reset full-speed USB device number 5 using 
> xhci_hcd
> [89933.509036] [drm] Fence fallback timer expired on ring gfx
> [89933.518076] OOM killer enabled.
> [89933.518079] Restarting tasks ...
> [89933.518323] pci_bus 0000:01: Allocating resources
> [89933.518432] pci_bus 0000:02: Allocating resources
> [89933.518448] pci_bus 0000:03: Allocating resources
> [89933.518479] pci_bus 0000:04: Allocating resources
> [89933.518494] pci_bus 0000:05: Allocating resources
> [89933.519424] pci_bus 0000:06: Allocating resources
> [89933.521662] Bluetooth: hci0: Bootloader revision 0.1 build 42 week 52 
> 2015
> [89933.523366] done.
> [89933.523464] random: crng reseeded on system resumption
> [89933.524084] Bluetooth: hci0: Device revision is 2
> [89933.524095] Bluetooth: hci0: Secure boot is enabled
> [89933.524097] Bluetooth: hci0: OTP lock is enabled
> [89933.524099] Bluetooth: hci0: API lock is enabled
> [89933.524101] Bluetooth: hci0: Debug lock is disabled
> [89933.524102] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
> [89933.524113] Bluetooth: hci0: Found device firmware: 
> intel/ibt-18-16-1.sfi
> [89933.524209] Bluetooth: hci0: Boot Address: 0x40800
> [89933.524211] Bluetooth: hci0: Firmware Version: 86-46.21
> [89933.669795] PM: suspend exit
> [89934.097061] Generic FE-GE Realtek PHY r8169-0-300:00: attached PHY 
> driver (mii_bus:phy_addr=r8169-0-300:00, irq=MAC)
> [89934.222008] r8169 0000:03:00.0 eth0: Link is Down
> [89934.257066] Generic FE-GE Realtek PHY r8169-0-400:00: attached PHY 
> driver (mii_bus:phy_addr=r8169-0-400:00, irq=MAC)
> [89934.388247] BTRFS error (device nvme0n1p2: state EA): parent transid 
> verify failed on logical 146997903360 mirror 1 wanted 771073 found 770869
> [89934.388539] BTRFS error (device nvme0n1p2: state EA): parent transid 
> verify failed on logical 146997903360 mirror 1 wanted 771073 found 770869
> [89934.441399] r8169 0000:04:00.0 eth1: Link is Down
> [89934.849697] Bluetooth: hci0: Waiting for firmware download to complete
> [89934.850009] Bluetooth: hci0: Firmware loaded in 1294820 usecs
> [89934.850048] Bluetooth: hci0: Waiting for device to boot
> [89934.867019] Bluetooth: hci0: Malformed MSFT vendor event: 0x02, 
> length requested 9 length available 6
> [89934.867026] Bluetooth: hci0: Device booted in 16610 usecs
> [89934.867030] Buggy packet:00 02 01 02 ff 01
> [89934.867034] CPU: 1 PID: 24918 Comm: kworker/u33:3 Tainted: G        
> W   E      6.1.0-59.40-default+ #336
> [89934.867036] Bluetooth: hci0: Found Intel DDC parameters: 
> intel/ibt-18-16-1.ddc
> [89934.867038] Hardware name: LENOVO 20NJS0KQ07/20NJS0KQ07, BIOS 
> R12ET55W(1.25 ) 07/06/2020
> [89934.867041] Workqueue: hci0 hci_rx_work [bluetooth]
> [89934.867111] Call Trace:
> [89934.867117]  <TASK>
> [89934.867121]  dump_stack_lvl+0x44/0x5c
> [89934.867130]  msft_skb_pull+0x97/0xa0 [bluetooth]
> [89934.867184]  msft_vendor_evt+0x115/0x2f0 [bluetooth]
> [89934.867229]  hci_event_packet+0x2d1/0x560 [bluetooth]
> [89934.867279]  ? __pfx_msft_vendor_evt+0x10/0x10 [bluetooth]
> [89934.867327]  hci_rx_work+0x29f/0x580 [bluetooth]
> [89934.867365]  ? __schedule+0x323/0x9c0
> [89934.867372]  process_one_work+0x226/0x440
> [89934.867379]  worker_thread+0x2a/0x3b0
> [89934.867382]  ? __pfx_worker_thread+0x10/0x10
> [89934.867385]  kthread+0xe8/0x110
> [89934.867390]  ? __pfx_kthread+0x10/0x10
> [89934.867395]  ret_from_fork+0x2c/0x50
> [89934.867403]  </TASK>
> [89934.875009] Bluetooth: hci0: Applying Intel DDC parameters completed
> [89934.879015] Bluetooth: hci0: Firmware revision 0.1 build 86 week 46 2021
> [89935.068088] Bluetooth: MGMT ver 1.22
> [89935.744075] BTRFS error (device nvme0n1p2: state EA): parent transid 
> verify failed on logical 146997903360 mirror 1 wanted 771073 found 770869
> [89935.744681] BTRFS error (device nvme0n1p2: state EA): parent transid 
> verify failed on logical 146997903360 mirror 1 wanted 771073 found 770869
> [89935.762082] BTRFS error (device nvme0n1p2: state EA): parent transid 
> verify failed on logical 146997903360 mirror 1 wanted 771073 found 770869
> [89935.823974] BTRFS error (device nvme0n1p2: state EA): parent transid 
> verify failed on logical 146997903360 mirror 1 wanted 771073 found 770869
> [89936.029941] r8169 0000:04:00.0 eth1: Link is Up - 100Mbps/Full - flow 
> control rx/tx
> [89936.029962] IPv6: ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready
> [89936.852715] BTRFS error (device nvme0n1p2: state EA): parent transid 
> verify failed on logical 146997903360 mirror 1 wanted 771073 found 770869
> [89936.852873] BTRFS error (device nvme0n1p2: state EA): parent transid 
> verify failed on logical 146997903360 mirror 1 wanted 771073 found 770869
> [89936.858246] BTRFS error (device nvme0n1p2: state EA): parent transid 
> verify failed on logical 146997903360 mirror 1 wanted 771073 found 770869
> [89936.862563] BTRFS error (device nvme0n1p2: state EA): parent transid 
> verify failed on logical 146997903360 mirror 1 wanted 771073 found 770869
> [89939.497404] wlan0: authenticate with cc:ce:1e:f4:37:95
> [89939.497447] wlan0: 80 MHz not supported, disabling VHT
> [89939.504565] wlan0: send auth to cc:ce:1e:f4:37:95 (try 1/3)
> [89939.548507] wlan0: authenticated
> [89939.549089] wlan0: associate with cc:ce:1e:f4:37:95 (try 1/3)
> [89939.653040] wlan0: associate with cc:ce:1e:f4:37:95 (try 2/3)
> [89939.757064] wlan0: associate with cc:ce:1e:f4:37:95 (try 3/3)
> [89939.790528] wlan0: RX AssocResp from cc:ce:1e:f4:37:95 (capab=0x1431 
> status=0 aid=3)
> [89939.793220] wlan0: associated
> [89939.804558] wlan0: Limiting TX power to 20 (20 - 0) dBm as advertised 
> by cc:ce:1e:f4:37:95
> [89940.917316] IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
> [90774.020890] BTRFS error (device nvme0n1p2: state EA): parent transid 
> verify failed on logical 146997903360 mirror 1 wanted 771073 found 770869
> [90774.021846] BTRFS error (device nvme0n1p2: state EA): parent transid 
> verify failed on logical 146997903360 mirror 1 wanted 771073 found 770869
> [90774.022345] BTRFS error (device nvme0n1p2: state EA): parent transid 
> verify failed on logical 146997903360 mirror 1 wanted 771073 found 770869
> [90774.107284] BTRFS error (device nvme0n1p2: state EA): parent transid 
> verify failed on logical 146997903360 mirror 1 wanted 771073 found 770869
> [90774.107438] BTRFS error (device nvme0n1p2: state EA): parent transid 
> verify failed on logical 146997903360 mirror 1 wanted 771073 found 770869
> [90774.107580] BTRFS error (device nvme0n1p2: state EA): parent transid 
> verify failed on logical 146997903360 mirror 1 wanted 771073 found 770869
> [90774.142624] BTRFS error (device nvme0n1p2: state EA): parent transid 
> verify failed on logical 146997903360 mirror 1 wanted 771073 found 770869
> [90774.142768] BTRFS error (device nvme0n1p2: state EA): parent transid 
> verify failed on logical 146997903360 mirror 1 wanted 771073 found 770869
> [90774.142898] BTRFS error (device nvme0n1p2: state EA): parent transid 
> verify failed on logical 146997903360 mirror 1 wanted 771073 found 770869
> [90774.168431] BTRFS error (device nvme0n1p2: state EA): parent transid 
> verify failed on logical 146997903360 mirror 1 wanted 771073 found 770869
> [90779.089137] validate_extent_buffer: 302 callbacks suppressed
> [90779.089142] BTRFS error (device nvme0n1p2: state EA): parent transid 
> verify failed on logical 146997903360 mirror 1 wanted 771073 found 770869
> [90779.089363] BTRFS error (device nvme0n1p2: state EA): parent transid 
> verify failed on logical 146997903360 mirror 1 wanted 771073 found 770869
> [90779.089538] BTRFS error (device nvme0n1p2: state EA): parent transid 
> verify failed on logical 146997903360 mirror 1 wanted 771073 found 770869
> [90779.101242] BTRFS error (device nvme0n1p2: state EA): parent transid 
> verify failed on logical 146997903360 mirror 1 wanted 771073 found 770869
> [90779.101424] BTRFS error (device nvme0n1p2: state EA): parent transid 
> verify failed on logical 146997903360 mirror 1 wanted 771073 found 770869
> [90779.101572] BTRFS error (device nvme0n1p2: state EA): parent transid 
> verify failed on logical 146997903360 mirror 1 wanted 771073 found 770869
> [90779.111754] BTRFS error (device nvme0n1p2: state EA): parent transid 
> verify failed on logical 146997903360 mirror 1 wanted 771073 found 770869
> [90779.111931] BTRFS error (device nvme0n1p2: state EA): parent transid 
> verify failed on logical 146997903360 mirror 1 wanted 771073 found 770869
> [90779.112093] BTRFS error (device nvme0n1p2: state EA): parent transid 
> verify failed on logical 146997903360 mirror 1 wanted 771073 found 770869
> [90779.135026] BTRFS error (device nvme0n1p2: state EA): parent transid 
> verify failed on logical 146997903360 mirror 1 wanted 771073 found 770869
> 
>>
>> This may indicate a problem, as we rely on space cache to do a lot of 
>> COW work, if that's the case, I'd recommend to at least clear all the 
>> space cache by:
>>
>>    # btrfs check --clear-space-cache v1 /dev/nvme0n1p2
> 
> In addition to --repair or instead of?

--clear-space-cache is an independent option, no need to --repair.

The only problem reported is qgroup, which you can easily repair by 
using "btrfs qgroup rescan".

Thanks,
QU

> 
>      Regards
>          Oliver
