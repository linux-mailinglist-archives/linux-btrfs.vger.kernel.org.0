Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76A4C270062
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Sep 2020 17:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbgIRPA6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Sep 2020 11:00:58 -0400
Received: from mail2.mystoragebox.com ([64.120.46.178]:44223 "EHLO
        mail.mystoragebox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725955AbgIRPA6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Sep 2020 11:00:58 -0400
X-Greylist: delayed 1048 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Sep 2020 11:00:57 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=intellasoft.net; s=20190502; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4gHWgJ+REP0S9MmnZmovyWAv7PfizbPeKHja3GX4++M=; b=2gGC2FxTrVEuIQNH8mQLLCfTCr
        bBj+e+2Y3gsuHzqPnh10dwFjrJ8iYzmRaQYg7Eb/wJl6JbvQZ5sYfGWqd8rS2p3kBsgtgtjOvm9WQ
        BuCakP3Ifs06Z3unK5DX/CSzsN+olqQq1L+Kp9LQdb42CNSWVkfAGxTEfMl58Rby0l8UqqPCJHfir
        I6+QdmEAnHVgi3XfOVGw9QlCogaU9Ebx7TnyRemve1SqueIQxObTbWircEb6LmNnjD7Y663EuH8o2
        nvsWUOGVCrwco541cCgqvpo9ZSq5aNKTRY/1rnV1zAde7/mAxxq55IQJAMWS9uhcSvs5uU0uy3Zyp
        Y+3sm57A==;
To:     linux-btrfs@vger.kernel.org
From:   Mark Murawski <markm-lists@intellasoft.net>
Subject: Bit of emergency, btrfs cannot mount root
Message-ID: <59845114-3277-86f7-50eb-2b7b2b1c00b8@intellasoft.net>
Date:   Fri, 18 Sep 2020 10:43:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Interesting parts:

[Fri Sep 18 09:58:17 2020] BTRFS: Transaction aborted (error -28)
[Fri Sep 18 09:58:17 2020] WARNING: CPU: 2 PID: 1 at 
fs/btrfs/block-group.c:2128 btrfs_create_pending_block_groups+0x1d1/0x1f0


But!  I do not get this error on debian's 5.6.0-0.bpo.2-rt-amd64

If I try 5.7.0, 5.8.0 or 5.3.8 or any other kernels I have handy.  I get 
this error in btrfs_create_pending_block_groups.


Here is usage:
Overall:
     Device size:                  46.56GiB
     Device allocated:             46.52GiB
     Device unallocated:           50.00MiB
     Device missing:                  0.00B
     Used:                         39.23GiB
     Free (estimated):              3.24GiB      (min: 3.24GiB)
     Data ratio:                       2.00
     Metadata ratio:                   2.00
     Global reserve:               48.61MiB      (used: 0.00B)

Data,RAID1: Size:22.48GiB, Used:19.26GiB
    /dev/sdc1      22.48GiB
    /dev/sdd1      22.48GiB

Metadata,RAID1: Size:768.00MiB, Used:359.50MiB
    /dev/sdc1     768.00MiB
    /dev/sdd1     768.00MiB

System,RAID1: Size:32.00MiB, Used:16.00KiB
    /dev/sdc1      32.00MiB
    /dev/sdd1      32.00MiB

Unallocated:
    /dev/sdc1      25.00MiB
    /dev/sdd1      25.00MiB



The dmesg
[Fri Sep 18 09:58:14 2020] pci_bus 0000:00: root bus resource [io 
0x03e0-0x0cf7 window]
[Fri Sep 18 09:58:14 2020] pci_bus 0000:00: root bus resource [io 
0x03b0-0x03df window]
[Fri Sep 18 09:58:14 2020] pci_bus 0000:00: root bus resource [io 
0x1000-0xffff window]
[Fri Sep 18 09:58:14 2020] pci_bus 0000:00: root bus resource [mem 
0x000a0000-0x000bffff window]
[Fri Sep 18 09:58:14 2020] pci_bus 0000:00: root bus resource [mem 
0x90000000-0xfbffbfff window]
[Fri Sep 18 09:58:14 2020] pci_bus 0000:00: root bus resource [bus 00-fe]
[Fri Sep 18 09:58:14 2020] pci 0000:00:00.0: [8086:2f00] type 00 class 
0x060000
[Fri Sep 18 09:58:14 2020] pci 0000:00:01.0: [8086:2f02] type 01 class 
0x060400
[Fri Sep 18 09:58:14 2020] pci 0000:00:01.0: PME# supported from D0 
D3hot D3cold
[Fri Sep 18 09:58:14 2020] pci 0000:00:02.0: [8086:2f04] type 01 class 
0x060400
[Fri Sep 18 09:58:14 2020] pci 0000:00:02.0: PME# supported from D0 
D3hot D3cold
[Fri Sep 18 09:58:14 2020] pci 0000:00:02.2: [8086:2f06] type 01 class 
0x060400
[Fri Sep 18 09:58:14 2020] pci 0000:00:02.2: PME# supported from D0 
D3hot D3cold
[Fri Sep 18 09:58:14 2020] pci 0000:00:03.0: [8086:2f08] type 01 class 
0x060400
[Fri Sep 18 09:58:14 2020] pci 0000:00:03.0: PME# supported from D0 
D3hot D3cold
[Fri Sep 18 09:58:14 2020] pci 0000:00:05.0: [8086:2f28] type 00 class 
0x088000
[Fri Sep 18 09:58:14 2020] pci 0000:00:05.1: [8086:2f29] type 00 class 
0x088000
[Fri Sep 18 09:58:14 2020] pci 0000:00:05.2: [8086:2f2a] type 00 class 
0x088000
[Fri Sep 18 09:58:14 2020] pci 0000:00:05.4: [8086:2f2c] type 00 class 
0x080020
[Fri Sep 18 09:58:14 2020] pci 0000:00:05.4: reg 0x10: [mem 
0xfb51d000-0xfb51dfff]
[Fri Sep 18 09:58:14 2020] pci 0000:00:11.0: [8086:8d7c] type 00 class 
0xff0000
[Fri Sep 18 09:58:14 2020] pci 0000:00:11.4: [8086:8d62] type 00 class 
0x010601
[Fri Sep 18 09:58:14 2020] pci 0000:00:11.4: reg 0x10: [io  0xf110-0xf117]
[Fri Sep 18 09:58:14 2020] pci 0000:00:11.4: reg 0x14: [io  0xf100-0xf103]
[Fri Sep 18 09:58:14 2020] pci 0000:00:11.4: reg 0x18: [io  0xf0f0-0xf0f7]
[Fri Sep 18 09:58:14 2020] pci 0000:00:11.4: reg 0x1c: [io  0xf0e0-0xf0e3]
[Fri Sep 18 09:58:14 2020] pci 0000:00:11.4: reg 0x20: [io  0xf020-0xf03f]
[Fri Sep 18 09:58:14 2020] pci 0000:00:11.4: reg 0x24: [mem 
0xfb51c000-0xfb51c7ff]
[Fri Sep 18 09:58:14 2020] pci 0000:00:11.4: PME# supported from D3hot
[Fri Sep 18 09:58:14 2020] pci 0000:00:14.0: [8086:8d31] type 00 class 
0x0c0330
[Fri Sep 18 09:58:14 2020] pci 0000:00:14.0: reg 0x10: [mem 
0xfb500000-0xfb50ffff 64bit]
[Fri Sep 18 09:58:14 2020] pci 0000:00:14.0: PME# supported from D3hot 
D3cold
[Fri Sep 18 09:58:14 2020] pci 0000:00:1a.0: [8086:8d2d] type 00 class 
0x0c0320
[Fri Sep 18 09:58:14 2020] pci 0000:00:1a.0: reg 0x10: [mem 
0xfb518000-0xfb5183ff]
[Fri Sep 18 09:58:14 2020] pci 0000:00:1a.0: PME# supported from D0 
D3hot D3cold
[Fri Sep 18 09:58:14 2020] pci 0000:00:1b.0: [8086:8d20] type 00 class 
0x040300
[Fri Sep 18 09:58:14 2020] pci 0000:00:1b.0: reg 0x10: [mem 
0xfb510000-0xfb513fff 64bit]
[Fri Sep 18 09:58:14 2020] pci 0000:00:1b.0: PME# supported from D0 
D3hot D3cold
[Fri Sep 18 09:58:14 2020] pci 0000:00:1c.0: [8086:8d10] type 01 class 
0x060400
[Fri Sep 18 09:58:14 2020] pci 0000:00:1c.0: PME# supported from D0 
D3hot D3cold
[Fri Sep 18 09:58:14 2020] pci 0000:00:1c.2: [8086:8d14] type 01 class 
0x060400
[Fri Sep 18 09:58:14 2020] pci 0000:00:1c.2: PME# supported from D0 
D3hot D3cold
[Fri Sep 18 09:58:14 2020] pci 0000:00:1c.3: [8086:8d16] type 01 class 
0x060400
[Fri Sep 18 09:58:14 2020] pci 0000:00:1c.3: PME# supported from D0 
D3hot D3cold
[Fri Sep 18 09:58:14 2020] pci 0000:00:1c.4: [8086:8d18] type 01 class 
0x060400
[Fri Sep 18 09:58:14 2020] pci 0000:00:1c.4: PME# supported from D0 
D3hot D3cold
[Fri Sep 18 09:58:14 2020] pci 0000:00:1c.7: [8086:8d1e] type 01 class 
0x060400
[Fri Sep 18 09:58:14 2020] pci 0000:00:1c.7: PME# supported from D0 
D3hot D3cold
[Fri Sep 18 09:58:14 2020] pci 0000:00:1d.0: [8086:8d26] type 00 class 
0x0c0320
[Fri Sep 18 09:58:14 2020] pci 0000:00:1d.0: reg 0x10: [mem 
0xfb517000-0xfb5173ff]
[Fri Sep 18 09:58:14 2020] pci 0000:00:1d.0: PME# supported from D0 
D3hot D3cold
[Fri Sep 18 09:58:14 2020] pci 0000:00:1f.0: [8086:8d44] type 00 class 
0x060100
[Fri Sep 18 09:58:14 2020] pci 0000:00:1f.2: [8086:8d02] type 00 class 
0x010601
[Fri Sep 18 09:58:14 2020] pci 0000:00:1f.2: reg 0x10: [io  0xf070-0xf077]
[Fri Sep 18 09:58:14 2020] pci 0000:00:1f.2: reg 0x14: [io  0xf060-0xf063]
[Fri Sep 18 09:58:14 2020] pci 0000:00:1f.2: reg 0x18: [io  0xf050-0xf057]
[Fri Sep 18 09:58:14 2020] pci 0000:00:1f.2: reg 0x1c: [io  0xf040-0xf043]
[Fri Sep 18 09:58:14 2020] pci 0000:00:1f.2: reg 0x20: [io  0xf000-0xf01f]
[Fri Sep 18 09:58:14 2020] pci 0000:00:1f.2: reg 0x24: [mem 
0xfb516000-0xfb5167ff]
[Fri Sep 18 09:58:14 2020] pci 0000:00:1f.2: PME# supported from D3hot
[Fri Sep 18 09:58:14 2020] pci 0000:00:1f.3: [8086:8d22] type 00 class 
0x0c0500
[Fri Sep 18 09:58:14 2020] pci 0000:00:1f.3: reg 0x10: [mem 
0xfb515000-0xfb5150ff 64bit]
[Fri Sep 18 09:58:14 2020] pci 0000:00:1f.3: reg 0x20: [io  0x0580-0x059f]
[Fri Sep 18 09:58:14 2020] pci 0000:00:1f.6: [8086:8d24] type 00 class 
0x118000
[Fri Sep 18 09:58:14 2020] pci 0000:00:1f.6: reg 0x10: [mem 
0xfb514000-0xfb514fff 64bit]
[Fri Sep 18 09:58:14 2020] pci 0000:00:01.0: PCI bridge to [bus 01]
[Fri Sep 18 09:58:14 2020] pci 0000:00:02.0: PCI bridge to [bus 02]
[Fri Sep 18 09:58:14 2020] pci 0000:00:02.2: PCI bridge to [bus 03]
[Fri Sep 18 09:58:14 2020] pci 0000:04:00.0: [10de:0641] type 00 class 
0x030000
[Fri Sep 18 09:58:14 2020] pci 0000:04:00.0: reg 0x10: [mem 
0xfa000000-0xfaffffff]
[Fri Sep 18 09:58:14 2020] pci 0000:04:00.0: reg 0x14: [mem 
0xe0000000-0xefffffff 64bit pref]
[Fri Sep 18 09:58:14 2020] pci 0000:04:00.0: reg 0x1c: [mem 
0xf8000000-0xf9ffffff 64bit]
[Fri Sep 18 09:58:14 2020] pci 0000:04:00.0: reg 0x24: [io  0xe000-0xe07f]
[Fri Sep 18 09:58:14 2020] pci 0000:04:00.0: reg 0x30: [mem 
0xfb000000-0xfb07ffff pref]
[Fri Sep 18 09:58:14 2020] pci 0000:04:00.0: enabling Extended Tags
[Fri Sep 18 09:58:14 2020] pci 0000:04:00.0: 16.000 Gb/s available PCIe 
bandwidth, limited by 2.5 GT/s PCIe x8 link at 0000:00:03.0 (capable of 
32.000 Gb/s with 2.5 GT/s PCIe x16 link)
[Fri Sep 18 09:58:14 2020] pci 0000:00:03.0: PCI bridge to [bus 04]
[Fri Sep 18 09:58:14 2020] pci 0000:00:03.0:   bridge window [io 
0xe000-0xefff]
[Fri Sep 18 09:58:14 2020] pci 0000:00:03.0:   bridge window [mem 
0xf8000000-0xfb0fffff]
[Fri Sep 18 09:58:14 2020] pci 0000:00:03.0:   bridge window [mem 
0xe0000000-0xefffffff 64bit pref]
[Fri Sep 18 09:58:14 2020] pci 0000:05:00.0: [1b21:1142] type 00 class 
0x0c0330
[Fri Sep 18 09:58:14 2020] pci 0000:05:00.0: reg 0x10: [mem 
0xfb400000-0xfb407fff 64bit]
[Fri Sep 18 09:58:14 2020] pci 0000:05:00.0: PME# supported from D3cold
[Fri Sep 18 09:58:14 2020] pci 0000:00:1c.0: PCI bridge to [bus 05]
[Fri Sep 18 09:58:14 2020] pci 0000:00:1c.0:   bridge window [mem 
0xfb400000-0xfb4fffff]
[Fri Sep 18 09:58:14 2020] pci 0000:06:00.0: [8086:1533] type 00 class 
0x020000
[Fri Sep 18 09:58:14 2020] pci 0000:06:00.0: reg 0x10: [mem 
0xfb300000-0xfb37ffff]
[Fri Sep 18 09:58:14 2020] pci 0000:06:00.0: reg 0x18: [io  0xd000-0xd01f]
[Fri Sep 18 09:58:14 2020] pci 0000:06:00.0: reg 0x1c: [mem 
0xfb380000-0xfb383fff]
[Fri Sep 18 09:58:14 2020] pci 0000:06:00.0: PME# supported from D0 
D3hot D3cold
[Fri Sep 18 09:58:14 2020] pci 0000:00:1c.2: PCI bridge to [bus 06]
[Fri Sep 18 09:58:14 2020] pci 0000:00:1c.2:   bridge window [io 
0xd000-0xdfff]
[Fri Sep 18 09:58:14 2020] pci 0000:00:1c.2:   bridge window [mem 
0xfb300000-0xfb3fffff]
[Fri Sep 18 09:58:14 2020] pci 0000:07:00.0: [8086:1533] type 00 class 
0x020000
[Fri Sep 18 09:58:14 2020] pci 0000:07:00.0: reg 0x10: [mem 
0xfb200000-0xfb27ffff]
[Fri Sep 18 09:58:14 2020] pci 0000:07:00.0: reg 0x18: [io  0xc000-0xc01f]
[Fri Sep 18 09:58:14 2020] pci 0000:07:00.0: reg 0x1c: [mem 
0xfb280000-0xfb283fff]
[Fri Sep 18 09:58:14 2020] pci 0000:07:00.0: PME# supported from D0 
D3hot D3cold
[Fri Sep 18 09:58:14 2020] pci 0000:00:1c.3: PCI bridge to [bus 07]
[Fri Sep 18 09:58:14 2020] pci 0000:00:1c.3:   bridge window [io 
0xc000-0xcfff]
[Fri Sep 18 09:58:14 2020] pci 0000:00:1c.3:   bridge window [mem 
0xfb200000-0xfb2fffff]
[Fri Sep 18 09:58:14 2020] pci 0000:08:00.0: [1b21:1142] type 00 class 
0x0c0330
[Fri Sep 18 09:58:14 2020] pci 0000:08:00.0: reg 0x10: [mem 
0xfb100000-0xfb107fff 64bit]
[Fri Sep 18 09:58:14 2020] pci 0000:08:00.0: PME# supported from D3cold
[Fri Sep 18 09:58:14 2020] pci 0000:00:1c.4: PCI bridge to [bus 08]
[Fri Sep 18 09:58:14 2020] pci 0000:00:1c.4:   bridge window [mem 
0xfb100000-0xfb1fffff]
[Fri Sep 18 09:58:14 2020] pci 0000:09:00.0: [1b21:1182] type 01 class 
0x060400
[Fri Sep 18 09:58:14 2020] pci 0000:09:00.0: enabling Extended Tags
[Fri Sep 18 09:58:14 2020] pci 0000:09:00.0: PME# supported from D0 
D3hot D3cold
[Fri Sep 18 09:58:14 2020] pci 0000:00:1c.7: PCI bridge to [bus 09-0c]
[Fri Sep 18 09:58:14 2020] pci 0000:0a:03.0: [1b21:1182] type 01 class 
0x060400
[Fri Sep 18 09:58:14 2020] pci 0000:0a:03.0: enabling Extended Tags
[Fri Sep 18 09:58:14 2020] pci 0000:0a:03.0: PME# supported from D0 
D3hot D3cold
[Fri Sep 18 09:58:14 2020] pci 0000:0a:07.0: [1b21:1182] type 01 class 
0x060400
[Fri Sep 18 09:58:14 2020] pci 0000:0a:07.0: enabling Extended Tags
[Fri Sep 18 09:58:14 2020] pci 0000:0a:07.0: PME# supported from D0 
D3hot D3cold
[Fri Sep 18 09:58:14 2020] pci 0000:09:00.0: PCI bridge to [bus 0a-0c]
[Fri Sep 18 09:58:14 2020] pci 0000:0a:03.0: PCI bridge to [bus 0b]
[Fri Sep 18 09:58:14 2020] pci 0000:0a:07.0: PCI bridge to [bus 0c]
[Fri Sep 18 09:58:14 2020] pci_bus 0000:00: on NUMA node 0
[Fri Sep 18 09:58:14 2020] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 
7 10 *11 12 14 15)
[Fri Sep 18 09:58:14 2020] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 
6 7 10 11 12 14 15)
[Fri Sep 18 09:58:14 2020] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 
10 *11 12 14 15)
[Fri Sep 18 09:58:14 2020] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 
*10 11 12 14 15)
[Fri Sep 18 09:58:14 2020] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 
7 10 11 12 14 15) *0, disabled.
[Fri Sep 18 09:58:14 2020] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 
7 10 11 12 14 15) *0, disabled.
[Fri Sep 18 09:58:14 2020] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 
*7 10 11 12 14 15)
[Fri Sep 18 09:58:14 2020] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 
7 10 11 12 14 15) *0, disabled.
[Fri Sep 18 09:58:14 2020] pci 0000:04:00.0: vgaarb: setting as boot VGA 
device
[Fri Sep 18 09:58:14 2020] pci 0000:04:00.0: vgaarb: VGA device added: 
decodes=io+mem,owns=io+mem,locks=none
[Fri Sep 18 09:58:14 2020] pci 0000:04:00.0: vgaarb: bridge control possible
[Fri Sep 18 09:58:14 2020] vgaarb: loaded
[Fri Sep 18 09:58:14 2020] SCSI subsystem initialized
[Fri Sep 18 09:58:14 2020] libata version 3.00 loaded.
[Fri Sep 18 09:58:14 2020] ACPI: bus type USB registered
[Fri Sep 18 09:58:14 2020] usbcore: registered new interface driver usbfs
[Fri Sep 18 09:58:14 2020] usbcore: registered new interface driver hub
[Fri Sep 18 09:58:14 2020] usbcore: registered new device driver usb
[Fri Sep 18 09:58:14 2020] pps_core: LinuxPPS API ver. 1 registered
[Fri Sep 18 09:58:14 2020] pps_core: Software ver. 5.3.6 - Copyright 
2005-2007 Rodolfo Giometti <giometti@linux.it>
[Fri Sep 18 09:58:14 2020] PTP clock support registered
[Fri Sep 18 09:58:14 2020] Advanced Linux Sound Architecture Driver 
Initialized.
[Fri Sep 18 09:58:14 2020] PCI: Using ACPI for IRQ routing
[Fri Sep 18 09:58:14 2020] PCI: pci_cache_line_size set to 64 bytes
[Fri Sep 18 09:58:14 2020] e820: reserve RAM buffer [mem 
0x0009e800-0x0009ffff]
[Fri Sep 18 09:58:14 2020] e820: reserve RAM buffer [mem 
0x7793a000-0x77ffffff]
[Fri Sep 18 09:58:14 2020] e820: reserve RAM buffer [mem 
0x7877c000-0x7bffffff]
[Fri Sep 18 09:58:14 2020] e820: reserve RAM buffer [mem 
0x7b2bc000-0x7bffffff]
[Fri Sep 18 09:58:14 2020] e820: reserve RAM buffer [mem 
0x7b558000-0x7bffffff]
[Fri Sep 18 09:58:14 2020] clocksource: Switched to clocksource tsc-early
[Fri Sep 18 09:58:14 2020] VFS: Disk quotas dquot_6.6.0
[Fri Sep 18 09:58:14 2020] VFS: Dquot-cache hash table entries: 512 
(order 0, 4096 bytes)
[Fri Sep 18 09:58:14 2020] FS-Cache: Loaded
[Fri Sep 18 09:58:14 2020] CacheFiles: Loaded
[Fri Sep 18 09:58:14 2020] pnp: PnP ACPI init
[Fri Sep 18 09:58:14 2020] pnp 00:00: Plug and Play ACPI device, IDs 
PNP0b00 (active)
[Fri Sep 18 09:58:14 2020] system 00:01: [io  0x0500-0x057f] has been 
reserved
[Fri Sep 18 09:58:14 2020] system 00:01: [io  0x0400-0x047f] has been 
reserved
[Fri Sep 18 09:58:14 2020] system 00:01: [io  0x0580-0x059f] has been 
reserved
[Fri Sep 18 09:58:14 2020] system 00:01: [io  0x0600-0x061f] has been 
reserved
[Fri Sep 18 09:58:14 2020] system 00:01: [io  0x0880-0x0883] has been 
reserved
[Fri Sep 18 09:58:14 2020] system 00:01: [io  0x0800-0x081f] has been 
reserved
[Fri Sep 18 09:58:14 2020] system 00:01: [mem 0xfed1c000-0xfed3ffff] 
could not be reserved
[Fri Sep 18 09:58:14 2020] system 00:01: [mem 0xfed45000-0xfed8bfff] has 
been reserved
[Fri Sep 18 09:58:14 2020] system 00:01: [mem 0xff000000-0xffffffff] has 
been reserved
[Fri Sep 18 09:58:14 2020] system 00:01: [mem 0xfee00000-0xfeefffff] has 
been reserved
[Fri Sep 18 09:58:14 2020] system 00:01: [mem 0xfed12000-0xfed1200f] has 
been reserved
[Fri Sep 18 09:58:14 2020] system 00:01: [mem 0xfed12010-0xfed1201f] has 
been reserved
[Fri Sep 18 09:58:14 2020] system 00:01: [mem 0xfed1b000-0xfed1bfff] has 
been reserved
[Fri Sep 18 09:58:14 2020] system 00:01: Plug and Play ACPI device, IDs 
PNP0c02 (active)
[Fri Sep 18 09:58:14 2020] system 00:02: [io  0x0a00-0x0a2f] has been 
reserved
[Fri Sep 18 09:58:14 2020] system 00:02: [io  0x0a30-0x0a3f] has been 
reserved
[Fri Sep 18 09:58:14 2020] system 00:02: [io  0x0a40-0x0a4f] has been 
reserved
[Fri Sep 18 09:58:14 2020] system 00:02: [io  0x0a60-0x0a6f] has been 
reserved
[Fri Sep 18 09:58:14 2020] system 00:02: Plug and Play ACPI device, IDs 
PNP0c02 (active)
[Fri Sep 18 09:58:14 2020] pnp 00:03: [dma 0 disabled]
[Fri Sep 18 09:58:14 2020] pnp 00:03: Plug and Play ACPI device, IDs 
PNP0501 (active)
[Fri Sep 18 09:58:14 2020] system 00:04: Plug and Play ACPI device, IDs 
PNP0c02 (active)
[Fri Sep 18 09:58:14 2020] pnp: PnP ACPI: found 5 devices
[Fri Sep 18 09:58:14 2020] clocksource: acpi_pm: mask: 0xffffff 
max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[Fri Sep 18 09:58:14 2020] NET: Registered protocol family 2
[Fri Sep 18 09:58:14 2020] tcp_listen_portaddr_hash hash table entries: 
32768 (order: 7, 524288 bytes, linear)
[Fri Sep 18 09:58:14 2020] TCP established hash table entries: 524288 
(order: 10, 4194304 bytes, linear)
[Fri Sep 18 09:58:14 2020] TCP bind hash table entries: 65536 (order: 8, 
1048576 bytes, linear)
[Fri Sep 18 09:58:14 2020] TCP: Hash tables configured (established 
524288 bind 65536)
[Fri Sep 18 09:58:14 2020] UDP hash table entries: 32768 (order: 8, 
1048576 bytes, linear)
[Fri Sep 18 09:58:14 2020] UDP-Lite hash table entries: 32768 (order: 8, 
1048576 bytes, linear)
[Fri Sep 18 09:58:14 2020] NET: Registered protocol family 1
[Fri Sep 18 09:58:14 2020] RPC: Registered named UNIX socket transport 
module.
[Fri Sep 18 09:58:14 2020] RPC: Registered udp transport module.
[Fri Sep 18 09:58:14 2020] RPC: Registered tcp transport module.
[Fri Sep 18 09:58:14 2020] RPC: Registered tcp NFSv4.1 backchannel 
transport module.
[Fri Sep 18 09:58:14 2020] pci 0000:00:01.0: PCI bridge to [bus 01]
[Fri Sep 18 09:58:14 2020] pci 0000:00:02.0: PCI bridge to [bus 02]
[Fri Sep 18 09:58:14 2020] pci 0000:00:02.2: PCI bridge to [bus 03]
[Fri Sep 18 09:58:14 2020] pci 0000:00:03.0: PCI bridge to [bus 04]
[Fri Sep 18 09:58:14 2020] pci 0000:00:03.0:   bridge window [io 
0xe000-0xefff]
[Fri Sep 18 09:58:14 2020] pci 0000:00:03.0:   bridge window [mem 
0xf8000000-0xfb0fffff]
[Fri Sep 18 09:58:14 2020] pci 0000:00:03.0:   bridge window [mem 
0xe0000000-0xefffffff 64bit pref]
[Fri Sep 18 09:58:14 2020] pci 0000:00:1c.0: PCI bridge to [bus 05]
[Fri Sep 18 09:58:14 2020] pci 0000:00:1c.0:   bridge window [mem 
0xfb400000-0xfb4fffff]
[Fri Sep 18 09:58:14 2020] pci 0000:00:1c.2: PCI bridge to [bus 06]
[Fri Sep 18 09:58:14 2020] pci 0000:00:1c.2:   bridge window [io 
0xd000-0xdfff]
[Fri Sep 18 09:58:14 2020] pci 0000:00:1c.2:   bridge window [mem 
0xfb300000-0xfb3fffff]
[Fri Sep 18 09:58:14 2020] pci 0000:00:1c.3: PCI bridge to [bus 07]
[Fri Sep 18 09:58:14 2020] pci 0000:00:1c.3:   bridge window [io 
0xc000-0xcfff]
[Fri Sep 18 09:58:14 2020] pci 0000:00:1c.3:   bridge window [mem 
0xfb200000-0xfb2fffff]
[Fri Sep 18 09:58:14 2020] pci 0000:00:1c.4: PCI bridge to [bus 08]
[Fri Sep 18 09:58:14 2020] pci 0000:00:1c.4:   bridge window [mem 
0xfb100000-0xfb1fffff]
[Fri Sep 18 09:58:14 2020] pci 0000:0a:03.0: PCI bridge to [bus 0b]
[Fri Sep 18 09:58:14 2020] pci 0000:0a:07.0: PCI bridge to [bus 0c]
[Fri Sep 18 09:58:14 2020] pci 0000:09:00.0: PCI bridge to [bus 0a-0c]
[Fri Sep 18 09:58:14 2020] pci 0000:00:1c.7: PCI bridge to [bus 09-0c]
[Fri Sep 18 09:58:14 2020] pci_bus 0000:00: resource 4 [io 
0x0000-0x03af window]
[Fri Sep 18 09:58:14 2020] pci_bus 0000:00: resource 5 [io 
0x03e0-0x0cf7 window]
[Fri Sep 18 09:58:14 2020] pci_bus 0000:00: resource 6 [io 
0x03b0-0x03df window]
[Fri Sep 18 09:58:14 2020] pci_bus 0000:00: resource 7 [io 
0x1000-0xffff window]
[Fri Sep 18 09:58:14 2020] pci_bus 0000:00: resource 8 [mem 
0x000a0000-0x000bffff window]
[Fri Sep 18 09:58:14 2020] pci_bus 0000:00: resource 9 [mem 
0x90000000-0xfbffbfff window]
[Fri Sep 18 09:58:14 2020] pci_bus 0000:04: resource 0 [io  0xe000-0xefff]
[Fri Sep 18 09:58:14 2020] pci_bus 0000:04: resource 1 [mem 
0xf8000000-0xfb0fffff]
[Fri Sep 18 09:58:14 2020] pci_bus 0000:04: resource 2 [mem 
0xe0000000-0xefffffff 64bit pref]
[Fri Sep 18 09:58:14 2020] pci_bus 0000:05: resource 1 [mem 
0xfb400000-0xfb4fffff]
[Fri Sep 18 09:58:14 2020] pci_bus 0000:06: resource 0 [io  0xd000-0xdfff]
[Fri Sep 18 09:58:14 2020] pci_bus 0000:06: resource 1 [mem 
0xfb300000-0xfb3fffff]
[Fri Sep 18 09:58:14 2020] pci_bus 0000:07: resource 0 [io  0xc000-0xcfff]
[Fri Sep 18 09:58:14 2020] pci_bus 0000:07: resource 1 [mem 
0xfb200000-0xfb2fffff]
[Fri Sep 18 09:58:14 2020] pci_bus 0000:08: resource 1 [mem 
0xfb100000-0xfb1fffff]
[Fri Sep 18 09:58:14 2020] pci 0000:00:05.0: disabled boot interrupts on 
device [8086:2f28]
[Fri Sep 18 09:58:14 2020] pci 0000:00:1a.0: 
quirk_usb_early_handoff+0x0/0x650 took 22677 usecs
[Fri Sep 18 09:58:14 2020] pci 0000:00:1d.0: 
quirk_usb_early_handoff+0x0/0x650 took 23320 usecs
[Fri Sep 18 09:58:14 2020] pci 0000:04:00.0: Video device with shadowed 
ROM at [mem 0x000c0000-0x000dffff]
[Fri Sep 18 09:58:14 2020] PCI: CLS 32 bytes, default 64
[Fri Sep 18 09:58:14 2020] Unpacking initramfs...
[Fri Sep 18 09:58:14 2020] Freeing initrd memory: 16K
[Fri Sep 18 09:58:14 2020] PCI-DMA: Using software bounce buffering for 
IO (SWIOTLB)
[Fri Sep 18 09:58:14 2020] software IO TLB: mapped [mem 
0x7393a000-0x7793a000] (64MB)
[Fri Sep 18 09:58:14 2020] RAPL PMU: API unit is 2^-32 Joules, 1 fixed 
counters, 655360 ms ovfl timer
[Fri Sep 18 09:58:14 2020] RAPL PMU: hw unit of domain package 2^-14 Joules
[Fri Sep 18 09:58:14 2020] workingset: timestamp_bits=46 max_order=24 
bucket_order=0
[Fri Sep 18 09:58:14 2020] NFS: Registering the id_resolver key type
[Fri Sep 18 09:58:14 2020] Key type id_resolver registered
[Fri Sep 18 09:58:14 2020] Key type id_legacy registered
[Fri Sep 18 09:58:14 2020] nfs4filelayout_init: NFSv4 File Layout Driver 
Registering...
[Fri Sep 18 09:58:14 2020] Installing knfsd (copyright (C) 1996 
okir@monad.swb.de).
[Fri Sep 18 09:58:14 2020] FS-Cache: Netfs 'cifs' registered for caching
[Fri Sep 18 09:58:14 2020] Key type cifs.idmap registered
[Fri Sep 18 09:58:14 2020] fuse: init (API version 7.31)
[Fri Sep 18 09:58:14 2020] FS-Cache: Netfs 'ceph' registered for caching
[Fri Sep 18 09:58:14 2020] ceph: loaded (mds proto 32)
[Fri Sep 18 09:58:14 2020] io scheduler mq-deadline registered
[Fri Sep 18 09:58:14 2020] io scheduler kyber registered
[Fri Sep 18 09:58:14 2020] io scheduler bfq registered
[Fri Sep 18 09:58:14 2020] input: Power Button as 
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[Fri Sep 18 09:58:14 2020] ACPI: Power Button [PWRB]
[Fri Sep 18 09:58:14 2020] input: Power Button as 
/devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[Fri Sep 18 09:58:14 2020] ACPI: Power Button [PWRF]
[Fri Sep 18 09:58:14 2020] ACPI: \_SB_.SCK0.CP00: Found 2 idle states
[Fri Sep 18 09:58:14 2020] ACPI: \_SB_.SCK0.CP01: Found 2 idle states
[Fri Sep 18 09:58:14 2020] ACPI: \_SB_.SCK0.CP02: Found 2 idle states
[Fri Sep 18 09:58:14 2020] ACPI: \_SB_.SCK0.CP03: Found 2 idle states
[Fri Sep 18 09:58:14 2020] ACPI: \_SB_.SCK0.CP04: Found 2 idle states
[Fri Sep 18 09:58:14 2020] ACPI: \_SB_.SCK0.CP05: Found 2 idle states
[Fri Sep 18 09:58:14 2020] ACPI: \_SB_.SCK0.CP06: Found 2 idle states
[Fri Sep 18 09:58:14 2020] ACPI: \_SB_.SCK0.CP07: Found 2 idle states
[Fri Sep 18 09:58:14 2020] Serial: 8250/16550 driver, 4 ports, IRQ 
sharing disabled
[Fri Sep 18 09:58:14 2020] 00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud 
= 115200) is a 16550A
[Fri Sep 18 09:58:14 2020] Linux agpgart interface v0.103
[Fri Sep 18 09:58:14 2020] loop: module loaded
[Fri Sep 18 09:58:14 2020] megasas: 07.714.04.00-rc1
[Fri Sep 18 09:58:14 2020] ahci 0000:00:11.4: version 3.0
[Fri Sep 18 09:58:14 2020] ahci 0000:00:11.4: AHCI 0001.0300 32 slots 4 
ports 6 Gbps 0xf impl SATA mode
[Fri Sep 18 09:58:14 2020] ahci 0000:00:11.4: flags: 64bit ncq pm led 
clo pio slum part ems apst
[Fri Sep 18 09:58:14 2020] scsi host0: ahci
[Fri Sep 18 09:58:14 2020] scsi host1: ahci
[Fri Sep 18 09:58:14 2020] scsi host2: ahci
[Fri Sep 18 09:58:14 2020] scsi host3: ahci
[Fri Sep 18 09:58:14 2020] ata1: SATA max UDMA/133 abar m2048@0xfb51c000 
port 0xfb51c100 irq 16
[Fri Sep 18 09:58:14 2020] ata2: SATA max UDMA/133 abar m2048@0xfb51c000 
port 0xfb51c180 irq 16
[Fri Sep 18 09:58:14 2020] ata3: SATA max UDMA/133 abar m2048@0xfb51c000 
port 0xfb51c200 irq 16
[Fri Sep 18 09:58:14 2020] ata4: SATA max UDMA/133 abar m2048@0xfb51c000 
port 0xfb51c280 irq 16
[Fri Sep 18 09:58:14 2020] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 
ports 6 Gbps 0x3f impl SATA mode
[Fri Sep 18 09:58:14 2020] ahci 0000:00:1f.2: flags: 64bit ncq pm led 
clo pio slum part ems apst
[Fri Sep 18 09:58:14 2020] scsi host4: ahci
[Fri Sep 18 09:58:14 2020] scsi host5: ahci
[Fri Sep 18 09:58:14 2020] scsi host6: ahci
[Fri Sep 18 09:58:14 2020] scsi host7: ahci
[Fri Sep 18 09:58:14 2020] scsi host8: ahci
[Fri Sep 18 09:58:14 2020] scsi host9: ahci
[Fri Sep 18 09:58:14 2020] ata5: SATA max UDMA/133 abar m2048@0xfb516000 
port 0xfb516100 irq 16
[Fri Sep 18 09:58:14 2020] ata6: SATA max UDMA/133 abar m2048@0xfb516000 
port 0xfb516180 irq 16
[Fri Sep 18 09:58:14 2020] ata7: SATA max UDMA/133 abar m2048@0xfb516000 
port 0xfb516200 irq 16
[Fri Sep 18 09:58:14 2020] ata8: SATA max UDMA/133 abar m2048@0xfb516000 
port 0xfb516280 irq 16
[Fri Sep 18 09:58:14 2020] ata9: SATA max UDMA/133 abar m2048@0xfb516000 
port 0xfb516300 irq 16
[Fri Sep 18 09:58:14 2020] ata10: SATA max UDMA/133 abar 
m2048@0xfb516000 port 0xfb516380 irq 16
[Fri Sep 18 09:58:14 2020] libphy: Fixed MDIO Bus: probed
[Fri Sep 18 09:58:14 2020] tun: Universal TUN/TAP device driver, 1.6
[Fri Sep 18 09:58:14 2020] cnic: QLogic cnicDriver v2.5.22 (July 20, 2015)
[Fri Sep 18 09:58:14 2020] thunder_xcv, ver 1.0
[Fri Sep 18 09:58:14 2020] thunder_bgx, ver 1.0
[Fri Sep 18 09:58:14 2020] nicpf, ver 1.0
[Fri Sep 18 09:58:14 2020] nicvf, ver 1.0
[Fri Sep 18 09:58:14 2020] ata3: SATA link down (SStatus 0 SControl 300)
[Fri Sep 18 09:58:14 2020] ata4: SATA link down (SStatus 0 SControl 300)
[Fri Sep 18 09:58:14 2020] ata1: SATA link up 6.0 Gbps (SStatus 133 
SControl 300)
[Fri Sep 18 09:58:14 2020] ata2: SATA link up 6.0 Gbps (SStatus 133 
SControl 300)
[Fri Sep 18 09:58:14 2020] ata2.00: supports DRM functions and may not 
be fully accessible
[Fri Sep 18 09:58:14 2020] ata2.00: ATA-10: CT2000MX500SSD1, M3CR023, 
max UDMA/133
[Fri Sep 18 09:58:14 2020] ata2.00: 3907029168 sectors, multi 1: LBA48 
NCQ (depth 32), AA
[Fri Sep 18 09:58:14 2020] ata1.00: supports DRM functions and may not 
be fully accessible
[Fri Sep 18 09:58:14 2020] ata2.00: supports DRM functions and may not 
be fully accessible
[Fri Sep 18 09:58:14 2020] ata2.00: configured for UDMA/133
[Fri Sep 18 09:58:14 2020] ata1.00: ATA-11: Samsung SSD 860 EVO 2TB, 
RVT02B6Q, max UDMA/133
[Fri Sep 18 09:58:14 2020] ata1.00: 3907029168 sectors, multi 1: LBA48 
NCQ (depth 32), AA
[Fri Sep 18 09:58:14 2020] ata1.00: supports DRM functions and may not 
be fully accessible
[Fri Sep 18 09:58:14 2020] ata1.00: configured for UDMA/133
[Fri Sep 18 09:58:14 2020] ata10: SATA link up 6.0 Gbps (SStatus 133 
SControl 300)
[Fri Sep 18 09:58:14 2020] ata7: SATA link up 6.0 Gbps (SStatus 133 
SControl 300)
[Fri Sep 18 09:58:14 2020] ata5: SATA link up 6.0 Gbps (SStatus 133 
SControl 300)
[Fri Sep 18 09:58:14 2020] ata8: SATA link up 6.0 Gbps (SStatus 133 
SControl 300)
[Fri Sep 18 09:58:14 2020] ata6: SATA link up 6.0 Gbps (SStatus 133 
SControl 300)
[Fri Sep 18 09:58:14 2020] ata10.00: supports DRM functions and may not 
be fully accessible
[Fri Sep 18 09:58:14 2020] ata9: SATA link up 6.0 Gbps (SStatus 133 
SControl 300)
[Fri Sep 18 09:58:14 2020] ata10.00: ATA-10: CT500MX500SSD1, M3CR010, 
max UDMA/133
[Fri Sep 18 09:58:14 2020] ata10.00: 976773168 sectors, multi 1: LBA48 
NCQ (depth 32), AA
[Fri Sep 18 09:58:14 2020] ata10.00: supports DRM functions and may not 
be fully accessible
[Fri Sep 18 09:58:14 2020] ata8.00: ATA-9: SanDisk SD8SB8U1T001122, 
X4120000, max UDMA/133
[Fri Sep 18 09:58:14 2020] ata8.00: 2000409264 sectors, multi 1: LBA48 
NCQ (depth 32), AA
[Fri Sep 18 09:58:14 2020] ata5.00: supports DRM functions and may not 
be fully accessible
[Fri Sep 18 09:58:14 2020] ata9.00: ATA-9: SanDisk SD8SB8U1T001122, 
X4120000, max UDMA/133
[Fri Sep 18 09:58:14 2020] ata9.00: 2000409264 sectors, multi 1: LBA48 
NCQ (depth 32), AA
[Fri Sep 18 09:58:14 2020] ata10.00: configured for UDMA/133
[Fri Sep 18 09:58:14 2020] ata6.00: supports DRM functions and may not 
be fully accessible
[Fri Sep 18 09:58:14 2020] ata7.00: supports DRM functions and may not 
be fully accessible
[Fri Sep 18 09:58:14 2020] ata7.00: ATA-11: Samsung SSD 860 EVO 500GB, 
RVT01B6Q, max UDMA/133
[Fri Sep 18 09:58:14 2020] ata7.00: 976773168 sectors, multi 1: LBA48 
NCQ (depth 32), AA
[Fri Sep 18 09:58:14 2020] ata8.00: configured for UDMA/133
[Fri Sep 18 09:58:14 2020] ata9.00: configured for UDMA/133
[Fri Sep 18 09:58:14 2020] ata7.00: supports DRM functions and may not 
be fully accessible
[Fri Sep 18 09:58:14 2020] ata5.00: NCQ Send/Recv Log not supported
[Fri Sep 18 09:58:14 2020] ata5.00: ATA-9: Samsung SSD 850 EVO 1TB, 
EMT01B6Q, max UDMA/133
[Fri Sep 18 09:58:14 2020] ata5.00: 1953525168 sectors, multi 1: LBA48 
NCQ (depth 32), AA
[Fri Sep 18 09:58:14 2020] ata7.00: configured for UDMA/133
[Fri Sep 18 09:58:14 2020] ata6.00: NCQ Send/Recv Log not supported
[Fri Sep 18 09:58:14 2020] ata6.00: ATA-9: Samsung SSD 850 EVO 1TB, 
EMT01B6Q, max UDMA/133
[Fri Sep 18 09:58:14 2020] ata6.00: 1953525168 sectors, multi 1: LBA48 
NCQ (depth 32), AA
[Fri Sep 18 09:58:14 2020] ata5.00: supports DRM functions and may not 
be fully accessible
[Fri Sep 18 09:58:14 2020] ata6.00: supports DRM functions and may not 
be fully accessible
[Fri Sep 18 09:58:14 2020] ata5.00: NCQ Send/Recv Log not supported
[Fri Sep 18 09:58:14 2020] ata6.00: NCQ Send/Recv Log not supported
[Fri Sep 18 09:58:14 2020] ata5.00: configured for UDMA/133
[Fri Sep 18 09:58:14 2020] ata6.00: configured for UDMA/133
[Fri Sep 18 09:58:15 2020] tsc: Refined TSC clocksource calibration: 
3491.914 MHz
[Fri Sep 18 09:58:15 2020] clocksource: tsc: mask: 0xffffffffffffffff 
max_cycles: 0x32557ae966b, max_idle_ns: 440795369289 ns
[Fri Sep 18 09:58:15 2020] clocksource: Switched to clocksource tsc
[Fri Sep 18 09:58:15 2020] e100: Intel(R) PRO/100 Network Driver, 
3.5.24-k2-NAPI
[Fri Sep 18 09:58:15 2020] e100: Copyright(c) 1999-2006 Intel Corporation
[Fri Sep 18 09:58:15 2020] e1000: Intel(R) PRO/1000 Network Driver - 
version 7.3.21-k8-NAPI
[Fri Sep 18 09:58:15 2020] e1000: Copyright (c) 1999-2006 Intel Corporation.
[Fri Sep 18 09:58:15 2020] e1000e: Intel(R) PRO/1000 Network Driver - 
3.2.6-k
[Fri Sep 18 09:58:15 2020] e1000e: Copyright(c) 1999 - 2015 Intel 
Corporation.
[Fri Sep 18 09:58:15 2020] igb: Intel(R) Gigabit Ethernet Network Driver 
- version 5.6.0-k
[Fri Sep 18 09:58:15 2020] igb: Copyright (c) 2007-2014 Intel Corporation.
[Fri Sep 18 09:58:15 2020] pps pps0: new PPS source ptp0
[Fri Sep 18 09:58:15 2020] igb 0000:06:00.0: added PHC on eth0
[Fri Sep 18 09:58:15 2020] igb 0000:06:00.0: Intel(R) Gigabit Ethernet 
Network Connection
[Fri Sep 18 09:58:15 2020] igb 0000:06:00.0: eth0: (PCIe:2.5Gb/s:Width 
x1) 0c:c4:7a:4f:4b:76
[Fri Sep 18 09:58:15 2020] igb 0000:06:00.0: eth0: PBA No: 013000-000
[Fri Sep 18 09:58:15 2020] igb 0000:06:00.0: Using legacy interrupts. 1 
rx queue(s), 1 tx queue(s)
[Fri Sep 18 09:58:15 2020] pps pps1: new PPS source ptp1
[Fri Sep 18 09:58:15 2020] igb 0000:07:00.0: added PHC on eth1
[Fri Sep 18 09:58:15 2020] igb 0000:07:00.0: Intel(R) Gigabit Ethernet 
Network Connection
[Fri Sep 18 09:58:15 2020] igb 0000:07:00.0: eth1: (PCIe:2.5Gb/s:Width 
x1) 0c:c4:7a:4f:4b:77
[Fri Sep 18 09:58:15 2020] igb 0000:07:00.0: eth1: PBA No: 011000-000
[Fri Sep 18 09:58:15 2020] igb 0000:07:00.0: Using legacy interrupts. 1 
rx queue(s), 1 tx queue(s)
[Fri Sep 18 09:58:15 2020] igbvf: Intel(R) Gigabit Virtual Function 
Network Driver - version 2.4.0-k
[Fri Sep 18 09:58:15 2020] igbvf: Copyright (c) 2009 - 2012 Intel 
Corporation.
[Fri Sep 18 09:58:15 2020] ixgbe: Intel(R) 10 Gigabit PCI Express 
Network Driver - version 5.1.0-k
[Fri Sep 18 09:58:15 2020] ixgbe: Copyright (c) 1999-2016 Intel Corporation.
[Fri Sep 18 09:58:15 2020] i40e: Intel(R) Ethernet Connection XL710 
Network Driver - version 2.8.20-k
[Fri Sep 18 09:58:15 2020] i40e: Copyright (c) 2013 - 2019 Intel 
Corporation.
[Fri Sep 18 09:58:15 2020] ixgb: Intel(R) PRO/10GbE Network Driver - 
version 1.0.135-k2-NAPI
[Fri Sep 18 09:58:15 2020] ixgb: Copyright (c) 1999-2008 Intel Corporation.
[Fri Sep 18 09:58:15 2020] jme: JMicron JMC2XX ethernet driver version 1.0.8
[Fri Sep 18 09:58:15 2020] sky2: driver version 1.30
[Fri Sep 18 09:58:15 2020] myri10ge: Version 1.5.3-1.534
[Fri Sep 18 09:58:15 2020] ns83820.c: National Semiconductor DP83820 
10/100/1000 driver.
[Fri Sep 18 09:58:15 2020] vxge: Copyright(c) 2002-2010 Exar Corp.
[Fri Sep 18 09:58:15 2020] vxge: Driver version: 2.5.3.22640-k
[Fri Sep 18 09:58:15 2020] QLogic 1/10 GbE Converged/Intelligent 
Ethernet Driver v5.3.66
[Fri Sep 18 09:58:15 2020] QLogic/NetXen Network Driver v4.0.82
[Fri Sep 18 09:58:15 2020] QLogic FastLinQ 4xxxx Core Module qed 8.37.0.20
[Fri Sep 18 09:58:15 2020] Solarflare NET driver v4.1
[Fri Sep 18 09:58:15 2020] tlan: ThunderLAN driver v1.17
[Fri Sep 18 09:58:15 2020] tlan: 0 devices installed, PCI: 0  EISA: 0
[Fri Sep 18 09:58:15 2020] usbcore: registered new interface driver catc
[Fri Sep 18 09:58:15 2020] usbcore: registered new interface driver kaweth
[Fri Sep 18 09:58:15 2020] pegasus: v0.9.3 (2013/04/25), Pegasus/Pegasus 
II USB Ethernet driver
[Fri Sep 18 09:58:15 2020] usbcore: registered new interface driver pegasus
[Fri Sep 18 09:58:15 2020] usbcore: registered new interface driver rtl8150
[Fri Sep 18 09:58:15 2020] usbcore: registered new interface driver r8152
[Fri Sep 18 09:58:15 2020] usbcore: registered new interface driver lan78xx
[Fri Sep 18 09:58:15 2020] usbcore: registered new interface driver asix
[Fri Sep 18 09:58:15 2020] usbcore: registered new interface driver 
ax88179_178a
[Fri Sep 18 09:58:15 2020] usbcore: registered new interface driver 
cdc_ether
[Fri Sep 18 09:58:15 2020] usbcore: registered new interface driver cdc_eem
[Fri Sep 18 09:58:15 2020] usbcore: registered new interface driver dm9601
[Fri Sep 18 09:58:15 2020] usbcore: registered new interface driver sr9700
[Fri Sep 18 09:58:15 2020] usbcore: registered new interface driver 
CoreChips
[Fri Sep 18 09:58:15 2020] usbcore: registered new interface driver smsc75xx
[Fri Sep 18 09:58:15 2020] usbcore: registered new interface driver smsc95xx
[Fri Sep 18 09:58:15 2020] usbcore: registered new interface driver gl620a
[Fri Sep 18 09:58:15 2020] usbcore: registered new interface driver net1080
[Fri Sep 18 09:58:15 2020] usbcore: registered new interface driver plusb
[Fri Sep 18 09:58:15 2020] usbcore: registered new interface driver 
rndis_host
[Fri Sep 18 09:58:15 2020] usbcore: registered new interface driver 
cdc_subset
[Fri Sep 18 09:58:15 2020] usbcore: registered new interface driver zaurus
[Fri Sep 18 09:58:15 2020] usbcore: registered new interface driver 
MOSCHIP usb-ethernet driver
[Fri Sep 18 09:58:15 2020] usbcore: registered new interface driver int51x1
[Fri Sep 18 09:58:15 2020] usbcore: registered new interface driver kalmia
[Fri Sep 18 09:58:15 2020] usbcore: registered new interface driver ipheth
[Fri Sep 18 09:58:15 2020] usbcore: registered new interface driver 
sierra_net
[Fri Sep 18 09:58:15 2020] usbcore: registered new interface driver 
cx82310_eth
[Fri Sep 18 09:58:15 2020] usbcore: registered new interface driver cdc_ncm
[Fri Sep 18 09:58:15 2020] usbcore: registered new interface driver 
huawei_cdc_ncm
[Fri Sep 18 09:58:15 2020] usbcore: registered new interface driver lg-vl600
[Fri Sep 18 09:58:15 2020] usbcore: registered new interface driver qmi_wwan
[Fri Sep 18 09:58:15 2020] usbcore: registered new interface driver cdc_mbim
[Fri Sep 18 09:58:15 2020] usbcore: registered new interface driver ch9200
[Fri Sep 18 09:58:15 2020] ehci_hcd: USB 2.0 'Enhanced' Host Controller 
(EHCI) Driver
[Fri Sep 18 09:58:15 2020] ehci-pci: EHCI PCI platform driver
[Fri Sep 18 09:58:15 2020] ehci-pci 0000:00:1a.0: EHCI Host Controller
[Fri Sep 18 09:58:15 2020] ehci-pci 0000:00:1a.0: new USB bus 
registered, assigned bus number 1
[Fri Sep 18 09:58:15 2020] ehci-pci 0000:00:1a.0: debug port 2
[Fri Sep 18 09:58:15 2020] ehci-pci 0000:00:1a.0: cache line size of 32 
is not supported
[Fri Sep 18 09:58:15 2020] ehci-pci 0000:00:1a.0: irq 18, io mem 0xfb518000
[Fri Sep 18 09:58:15 2020] ehci-pci 0000:00:1a.0: USB 2.0 started, EHCI 1.00
[Fri Sep 18 09:58:15 2020] hub 1-0:1.0: USB hub found
[Fri Sep 18 09:58:15 2020] hub 1-0:1.0: 2 ports detected
[Fri Sep 18 09:58:15 2020] ehci-pci 0000:00:1d.0: EHCI Host Controller
[Fri Sep 18 09:58:15 2020] ehci-pci 0000:00:1d.0: new USB bus 
registered, assigned bus number 2
[Fri Sep 18 09:58:15 2020] ehci-pci 0000:00:1d.0: debug port 2
[Fri Sep 18 09:58:15 2020] ehci-pci 0000:00:1d.0: cache line size of 32 
is not supported
[Fri Sep 18 09:58:15 2020] ehci-pci 0000:00:1d.0: irq 18, io mem 0xfb517000
[Fri Sep 18 09:58:15 2020] ehci-pci 0000:00:1d.0: USB 2.0 started, EHCI 1.00
[Fri Sep 18 09:58:15 2020] hub 2-0:1.0: USB hub found
[Fri Sep 18 09:58:15 2020] hub 2-0:1.0: 2 ports detected
[Fri Sep 18 09:58:15 2020] ehci-platform: EHCI generic platform driver
[Fri Sep 18 09:58:15 2020] ohci_hcd: USB 1.1 'Open' Host Controller 
(OHCI) Driver
[Fri Sep 18 09:58:15 2020] ohci-pci: OHCI PCI platform driver
[Fri Sep 18 09:58:15 2020] ohci-platform: OHCI generic platform driver
[Fri Sep 18 09:58:15 2020] uhci_hcd: USB Universal Host Controller 
Interface driver
[Fri Sep 18 09:58:15 2020] xhci_hcd 0000:00:14.0: xHCI Host Controller
[Fri Sep 18 09:58:15 2020] xhci_hcd 0000:00:14.0: new USB bus 
registered, assigned bus number 3
[Fri Sep 18 09:58:15 2020] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 
hci version 0x100 quirks 0x0000000000009810
[Fri Sep 18 09:58:15 2020] xhci_hcd 0000:00:14.0: cache line size of 32 
is not supported
[Fri Sep 18 09:58:15 2020] hub 3-0:1.0: USB hub found
[Fri Sep 18 09:58:15 2020] hub 3-0:1.0: 15 ports detected
[Fri Sep 18 09:58:15 2020] xhci_hcd 0000:00:14.0: xHCI Host Controller
[Fri Sep 18 09:58:15 2020] xhci_hcd 0000:00:14.0: new USB bus 
registered, assigned bus number 4
[Fri Sep 18 09:58:15 2020] xhci_hcd 0000:00:14.0: Host supports USB 3.0 
SuperSpeed
[Fri Sep 18 09:58:15 2020] hub 4-0:1.0: USB hub found
[Fri Sep 18 09:58:15 2020] hub 4-0:1.0: 6 ports detected
[Fri Sep 18 09:58:15 2020] xhci_hcd 0000:05:00.0: xHCI Host Controller
[Fri Sep 18 09:58:15 2020] xhci_hcd 0000:05:00.0: new USB bus 
registered, assigned bus number 5
[Fri Sep 18 09:58:15 2020] xhci_hcd 0000:05:00.0: hcc params 0x0200e081 
hci version 0x100 quirks 0x0000000010000410
[Fri Sep 18 09:58:15 2020] hub 5-0:1.0: USB hub found
[Fri Sep 18 09:58:15 2020] hub 5-0:1.0: 2 ports detected
[Fri Sep 18 09:58:15 2020] xhci_hcd 0000:05:00.0: xHCI Host Controller
[Fri Sep 18 09:58:15 2020] xhci_hcd 0000:05:00.0: new USB bus 
registered, assigned bus number 6
[Fri Sep 18 09:58:15 2020] xhci_hcd 0000:05:00.0: Host supports USB 3.0 
SuperSpeed
[Fri Sep 18 09:58:15 2020] usb usb6: We don't know the algorithms for 
LPM for this host, disabling LPM.
[Fri Sep 18 09:58:15 2020] hub 6-0:1.0: USB hub found
[Fri Sep 18 09:58:15 2020] hub 6-0:1.0: 2 ports detected
[Fri Sep 18 09:58:15 2020] xhci_hcd 0000:08:00.0: xHCI Host Controller
[Fri Sep 18 09:58:15 2020] xhci_hcd 0000:08:00.0: new USB bus 
registered, assigned bus number 7
[Fri Sep 18 09:58:15 2020] xhci_hcd 0000:08:00.0: hcc params 0x0200e081 
hci version 0x100 quirks 0x0000000010000410
[Fri Sep 18 09:58:15 2020] hub 7-0:1.0: USB hub found
[Fri Sep 18 09:58:15 2020] hub 7-0:1.0: 2 ports detected
[Fri Sep 18 09:58:15 2020] xhci_hcd 0000:08:00.0: xHCI Host Controller
[Fri Sep 18 09:58:15 2020] xhci_hcd 0000:08:00.0: new USB bus 
registered, assigned bus number 8
[Fri Sep 18 09:58:15 2020] xhci_hcd 0000:08:00.0: Host supports USB 3.0 
SuperSpeed
[Fri Sep 18 09:58:15 2020] usb usb8: We don't know the algorithms for 
LPM for this host, disabling LPM.
[Fri Sep 18 09:58:15 2020] hub 8-0:1.0: USB hub found
[Fri Sep 18 09:58:15 2020] hub 8-0:1.0: 2 ports detected
[Fri Sep 18 09:58:15 2020] fotg210_hcd: FOTG210 Host Controller (EHCI) 
Driver
[Fri Sep 18 09:58:15 2020] Warning! fotg210_hcd should always be loaded 
before uhci_hcd and ohci_hcd, not after
[Fri Sep 18 09:58:15 2020] usbcore: registered new interface driver cdc_acm
[Fri Sep 18 09:58:15 2020] cdc_acm: USB Abstract Control Model driver 
for USB modems and ISDN adapters
[Fri Sep 18 09:58:15 2020] usbcore: registered new interface driver usblp
[Fri Sep 18 09:58:15 2020] usbcore: registered new interface driver cdc_wdm
[Fri Sep 18 09:58:15 2020] usbcore: registered new interface driver 
usb-storage
[Fri Sep 18 09:58:15 2020] usbcore: registered new interface driver pl2303
[Fri Sep 18 09:58:15 2020] usbserial: USB Serial support registered for 
pl2303
[Fri Sep 18 09:58:15 2020] i8042: PNP: No PS/2 controller found.
[Fri Sep 18 09:58:15 2020] mousedev: PS/2 mouse device common for all mice
[Fri Sep 18 09:58:15 2020] rtc_cmos 00:00: RTC can wake from S4
[Fri Sep 18 09:58:15 2020] rtc_cmos 00:00: registered as rtc0
[Fri Sep 18 09:58:15 2020] rtc_cmos 00:00: setting system clock to 
2020-09-18T13:58:16 UTC (1600437496)
[Fri Sep 18 09:58:15 2020] rtc_cmos 00:00: alarms up to one month, y3k, 
114 bytes nvram, hpet irqs
[Fri Sep 18 09:58:15 2020] IR NEC protocol handler initialized
[Fri Sep 18 09:58:15 2020] IR RC5(x/sz) protocol handler initialized
[Fri Sep 18 09:58:15 2020] IR RC6 protocol handler initialized
[Fri Sep 18 09:58:15 2020] IR JVC protocol handler initialized
[Fri Sep 18 09:58:15 2020] IR Sony protocol handler initialized
[Fri Sep 18 09:58:15 2020] IR SANYO protocol handler initialized
[Fri Sep 18 09:58:15 2020] IR Sharp protocol handler initialized
[Fri Sep 18 09:58:15 2020] IR MCE Keyboard/mouse protocol handler 
initialized
[Fri Sep 18 09:58:15 2020] IR XMP protocol handler initialized
[Fri Sep 18 09:58:15 2020] device-mapper: ioctl: 4.42.0-ioctl 
(2020-02-27) initialised: dm-devel@redhat.com
[Fri Sep 18 09:58:15 2020] device-mapper: raid: Loading target version 
1.15.1
[Fri Sep 18 09:58:15 2020] intel_pstate: Intel P-state driver initializing
[Fri Sep 18 09:58:15 2020] usbcore: registered new interface driver usbhid
[Fri Sep 18 09:58:15 2020] usbhid: USB HID core driver
[Fri Sep 18 09:58:15 2020] GACT probability on
[Fri Sep 18 09:58:15 2020] Mirror/redirect action on
[Fri Sep 18 09:58:15 2020] netem: version 1.3
[Fri Sep 18 09:58:15 2020] u32 classifier
[Fri Sep 18 09:58:15 2020]     Performance counters on
[Fri Sep 18 09:58:15 2020]     input device check on
[Fri Sep 18 09:58:15 2020]     Actions configured
[Fri Sep 18 09:58:15 2020] xt_time: kernel timezone is -0000
[Fri Sep 18 09:58:15 2020] ipip: IPv4 and MPLS over IPv4 tunneling driver
[Fri Sep 18 09:58:15 2020] ipt_CLUSTERIP: ClusterIP Version 0.8 loaded 
successfully
[Fri Sep 18 09:58:15 2020] Initializing XFRM netlink socket
[Fri Sep 18 09:58:15 2020] NET: Registered protocol family 10
[Fri Sep 18 09:58:15 2020] Segment Routing with IPv6
[Fri Sep 18 09:58:15 2020] mip6: Mobile IPv6
[Fri Sep 18 09:58:15 2020] sit: IPv6, IPv4 and MPLS over IPv4 tunneling 
driver
[Fri Sep 18 09:58:15 2020] bpfilter: Loaded bpfilter_umh pid 2944
[Fri Sep 18 09:58:15 2020] NET: Registered protocol family 17
[Fri Sep 18 09:58:15 2020] NET: Registered protocol family 15
[Fri Sep 18 09:58:15 2020] Bridge firewalling registered
[Fri Sep 18 09:58:15 2020] NET: Registered protocol family 33
[Fri Sep 18 09:58:15 2020] Key type rxrpc registered
[Fri Sep 18 09:58:15 2020] Key type rxrpc_s registered
[Fri Sep 18 09:58:15 2020] l2tp_core: L2TP core driver, V2.0
[Fri Sep 18 09:58:15 2020] l2tp_ip: L2TP IP encapsulation support (L2TPv3)
[Fri Sep 18 09:58:15 2020] l2tp_netlink: L2TP netlink interface
[Fri Sep 18 09:58:15 2020] l2tp_eth: L2TP ethernet pseudowire support 
(L2TPv3)
[Fri Sep 18 09:58:15 2020] l2tp_ip6: L2TP IP encapsulation support for 
IPv6 (L2TPv3)
[Fri Sep 18 09:58:15 2020] 8021q: 802.1Q VLAN Support v1.8
[Fri Sep 18 09:58:15 2020] lib80211: common routines for IEEE802.11 drivers
[Fri Sep 18 09:58:15 2020] lib80211_crypt: registered algorithm 'NULL'
[Fri Sep 18 09:58:15 2020] lib80211_crypt: registered algorithm 'WEP'
[Fri Sep 18 09:58:15 2020] lib80211_crypt: registered algorithm 'CCMP'
[Fri Sep 18 09:58:15 2020] lib80211_crypt: registered algorithm 'TKIP'
[Fri Sep 18 09:58:15 2020] Key type dns_resolver registered
[Fri Sep 18 09:58:15 2020] Key type ceph registered
[Fri Sep 18 09:58:15 2020] libceph: loaded (mon/osd proto 15/24)
[Fri Sep 18 09:58:15 2020] openvswitch: Open vSwitch switching datapath
[Fri Sep 18 09:58:15 2020] NET: Registered protocol family 40
[Fri Sep 18 09:58:15 2020] mpls_gso: MPLS GSO support
[Fri Sep 18 09:58:15 2020] IPI shorthand broadcast: enabled
[Fri Sep 18 09:58:15 2020] sched_clock: Marking stable (3839361627, 
10404341)->(4032535954, -182769986)
[Fri Sep 18 09:58:15 2020] registered taskstats version 1
[Fri Sep 18 09:58:15 2020] kAFS: Red Hat AFS client v0.1 registering.
[Fri Sep 18 09:58:15 2020] kAFS: failed to register: -97
[Fri Sep 18 09:58:15 2020] Btrfs loaded, crc32c=crc32c-generic
[Fri Sep 18 09:58:15 2020] ALSA device list:
[Fri Sep 18 09:58:15 2020]   No soundcards found.
[Fri Sep 18 09:58:15 2020] Warning: unable to open an initial console.
[Fri Sep 18 09:58:16 2020] usb 1-1: new high-speed USB device number 2 
using ehci-pci
[Fri Sep 18 09:58:16 2020] usb 2-1: new high-speed USB device number 2 
using ehci-pci
[Fri Sep 18 09:58:16 2020] usb 3-7: new full-speed USB device number 2 
using xhci_hcd
[Fri Sep 18 09:58:16 2020] hub 1-1:1.0: USB hub found
[Fri Sep 18 09:58:16 2020] hub 1-1:1.0: 6 ports detected
[Fri Sep 18 09:58:16 2020] hub 2-1:1.0: USB hub found
[Fri Sep 18 09:58:16 2020] hub 2-1:1.0: 8 ports detected
[Fri Sep 18 09:58:16 2020] hid-generic 0003:051D:0002.0001: hiddev96: 
USB HID v1.00 Device [American Power Conversion Back-UPS RS 1300G 
FW:863.L3 .D USB FW:L3 ] on usb-0000:00:14.0-7/input0
[Fri Sep 18 09:58:16 2020] usb 3-8: new low-speed USB device number 3 
using xhci_hcd
[Fri Sep 18 09:58:16 2020] input: No brand KVM as 
/devices/pci0000:00/0000:00:14.0/usb3/3-8/3-8:1.0/0003:10D5:5A08.0002/input/input2
[Fri Sep 18 09:58:16 2020] hid-generic 0003:10D5:5A08.0002: input: USB 
HID v1.10 Keyboard [No brand KVM] on usb-0000:00:14.0-8/input0
[Fri Sep 18 09:58:16 2020] input: No brand KVM Mouse as 
/devices/pci0000:00/0000:00:14.0/usb3/3-8/3-8:1.1/0003:10D5:5A08.0003/input/input3
[Fri Sep 18 09:58:16 2020] input: No brand KVM System Control as 
/devices/pci0000:00/0000:00:14.0/usb3/3-8/3-8:1.1/0003:10D5:5A08.0003/input/input4
[Fri Sep 18 09:58:16 2020] input: No brand KVM Consumer Control as 
/devices/pci0000:00/0000:00:14.0/usb3/3-8/3-8:1.1/0003:10D5:5A08.0003/input/input5
[Fri Sep 18 09:58:16 2020] hid-generic 0003:10D5:5A08.0003: input: USB 
HID v1.10 Mouse [No brand KVM] on usb-0000:00:14.0-8/input1
[Fri Sep 18 09:58:16 2020] usb 3-12: new high-speed USB device number 4 
using xhci_hcd
[Fri Sep 18 09:58:16 2020] usb-storage 3-12:1.0: USB Mass Storage device 
detected
[Fri Sep 18 09:58:16 2020] scsi host10: usb-storage 3-12:1.0
[Fri Sep 18 09:58:17 2020] floppy0: no floppy controllers found
[Fri Sep 18 09:58:17 2020] scsi 0:0:0:0: Direct-Access     ATA 
Samsung SSD 860  2B6Q PQ: 0 ANSI: 5
[Fri Sep 18 09:58:17 2020] sd 0:0:0:0: Attached scsi generic sg0 type 0
[Fri Sep 18 09:58:17 2020] ata1.00: Enabling discard_zeroes_data
[Fri Sep 18 09:58:17 2020] scsi 1:0:0:0: Direct-Access     ATA 
CT2000MX500SSD1  023  PQ: 0 ANSI: 5
[Fri Sep 18 09:58:17 2020] sd 0:0:0:0: [sda] 3907029168 512-byte logical 
blocks: (2.00 TB/1.82 TiB)
[Fri Sep 18 09:58:17 2020] sd 0:0:0:0: [sda] Write Protect is off
[Fri Sep 18 09:58:17 2020] sd 1:0:0:0: Attached scsi generic sg1 type 0
[Fri Sep 18 09:58:17 2020] sd 1:0:0:0: [sdb] 3907029168 512-byte logical 
blocks: (2.00 TB/1.82 TiB)
[Fri Sep 18 09:58:17 2020] sd 1:0:0:0: [sdb] 4096-byte physical blocks
[Fri Sep 18 09:58:17 2020] sd 1:0:0:0: [sdb] Write Protect is off
[Fri Sep 18 09:58:17 2020] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[Fri Sep 18 09:58:17 2020] sd 1:0:0:0: [sdb] Write cache: enabled, read 
cache: enabled, doesn't support DPO or FUA
[Fri Sep 18 09:58:17 2020] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[Fri Sep 18 09:58:17 2020] scsi 4:0:0:0: Direct-Access     ATA 
Samsung SSD 850  1B6Q PQ: 0 ANSI: 5
[Fri Sep 18 09:58:17 2020] sd 0:0:0:0: [sda] Write cache: enabled, read 
cache: enabled, doesn't support DPO or FUA
[Fri Sep 18 09:58:17 2020] sd 4:0:0:0: Attached scsi generic sg2 type 0
[Fri Sep 18 09:58:17 2020] sd 4:0:0:0: [sdc] 1953525168 512-byte logical 
blocks: (1.00 TB/932 GiB)
[Fri Sep 18 09:58:17 2020] sd 4:0:0:0: [sdc] Write Protect is off
[Fri Sep 18 09:58:17 2020] sd 4:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[Fri Sep 18 09:58:17 2020] sd 4:0:0:0: [sdc] Write cache: enabled, read 
cache: enabled, doesn't support DPO or FUA
[Fri Sep 18 09:58:17 2020]  sdb: sdb1
[Fri Sep 18 09:58:17 2020] scsi 5:0:0:0: Direct-Access     ATA 
Samsung SSD 850  1B6Q PQ: 0 ANSI: 5
[Fri Sep 18 09:58:17 2020] ata1.00: Enabling discard_zeroes_data
[Fri Sep 18 09:58:17 2020] sd 1:0:0:0: [sdb] Attached SCSI disk
[Fri Sep 18 09:58:17 2020] sd 5:0:0:0: Attached scsi generic sg3 type 0
[Fri Sep 18 09:58:17 2020] sd 5:0:0:0: [sdd] 1953525168 512-byte logical 
blocks: (1.00 TB/932 GiB)
[Fri Sep 18 09:58:17 2020] scsi 6:0:0:0: Direct-Access     ATA 
Samsung SSD 860  1B6Q PQ: 0 ANSI: 5
[Fri Sep 18 09:58:17 2020] sd 5:0:0:0: [sdd] Write Protect is off
[Fri Sep 18 09:58:17 2020] sd 5:0:0:0: [sdd] Mode Sense: 00 3a 00 00
[Fri Sep 18 09:58:17 2020] sd 5:0:0:0: [sdd] Write cache: enabled, read 
cache: enabled, doesn't support DPO or FUA
[Fri Sep 18 09:58:17 2020] ata7.00: Enabling discard_zeroes_data
[Fri Sep 18 09:58:17 2020] sd 6:0:0:0: Attached scsi generic sg4 type 0
[Fri Sep 18 09:58:17 2020] scsi 7:0:0:0: Direct-Access     ATA 
SanDisk SD8SB8U1 0000 PQ: 0 ANSI: 5
[Fri Sep 18 09:58:17 2020] sd 6:0:0:0: [sde] 976773168 512-byte logical 
blocks: (500 GB/466 GiB)
[Fri Sep 18 09:58:17 2020] sd 6:0:0:0: [sde] Write Protect is off
[Fri Sep 18 09:58:17 2020] sd 7:0:0:0: Attached scsi generic sg5 type 0
[Fri Sep 18 09:58:17 2020] sd 7:0:0:0: [sdf] 2000409264 512-byte logical 
blocks: (1.02 TB/954 GiB)
[Fri Sep 18 09:58:17 2020] sd 7:0:0:0: [sdf] Write Protect is off
[Fri Sep 18 09:58:17 2020] sd 7:0:0:0: [sdf] Mode Sense: 00 3a 00 00
[Fri Sep 18 09:58:17 2020] sd 7:0:0:0: [sdf] Write cache: enabled, read 
cache: enabled, doesn't support DPO or FUA
[Fri Sep 18 09:58:17 2020] sd 6:0:0:0: [sde] Mode Sense: 00 3a 00 00
[Fri Sep 18 09:58:17 2020] scsi 8:0:0:0: Direct-Access     ATA 
SanDisk SD8SB8U1 0000 PQ: 0 ANSI: 5
[Fri Sep 18 09:58:17 2020] sd 6:0:0:0: [sde] Write cache: enabled, read 
cache: enabled, doesn't support DPO or FUA
[Fri Sep 18 09:58:17 2020] sd 8:0:0:0: Attached scsi generic sg6 type 0
[Fri Sep 18 09:58:17 2020] sd 8:0:0:0: [sdg] 2000409264 512-byte logical 
blocks: (1.02 TB/954 GiB)
[Fri Sep 18 09:58:17 2020] sd 8:0:0:0: [sdg] Write Protect is off
[Fri Sep 18 09:58:17 2020] sd 8:0:0:0: [sdg] Mode Sense: 00 3a 00 00
[Fri Sep 18 09:58:17 2020] sd 8:0:0:0: [sdg] Write cache: enabled, read 
cache: enabled, doesn't support DPO or FUA
[Fri Sep 18 09:58:17 2020] scsi 9:0:0:0: Direct-Access     ATA 
CT500MX500SSD1   010  PQ: 0 ANSI: 5
[Fri Sep 18 09:58:17 2020] ata7.00: Enabling discard_zeroes_data
[Fri Sep 18 09:58:17 2020] sd 9:0:0:0: Attached scsi generic sg7 type 0
[Fri Sep 18 09:58:17 2020] sd 9:0:0:0: [sdh] 976773168 512-byte logical 
blocks: (500 GB/466 GiB)
[Fri Sep 18 09:58:17 2020] sd 9:0:0:0: [sdh] 4096-byte physical blocks
[Fri Sep 18 09:58:17 2020]  sda: sda1
[Fri Sep 18 09:58:17 2020] sd 9:0:0:0: [sdh] Write Protect is off
[Fri Sep 18 09:58:17 2020] ata1.00: Enabling discard_zeroes_data
[Fri Sep 18 09:58:17 2020] sd 9:0:0:0: [sdh] Mode Sense: 00 3a 00 00
[Fri Sep 18 09:58:17 2020] sd 9:0:0:0: [sdh] Write cache: enabled, read 
cache: enabled, doesn't support DPO or FUA
[Fri Sep 18 09:58:17 2020] sd 0:0:0:0: [sda] Attached SCSI disk
[Fri Sep 18 09:58:17 2020]  sdh: sdh1
[Fri Sep 18 09:58:17 2020]  sdc: sdc1 sdc2 < sdc5 >
[Fri Sep 18 09:58:17 2020] sd 9:0:0:0: [sdh] Attached SCSI disk
[Fri Sep 18 09:58:17 2020] sd 4:0:0:0: [sdc] Attached SCSI disk
[Fri Sep 18 09:58:17 2020]  sde: sde1
[Fri Sep 18 09:58:17 2020]  sdd: sdd1 sdd2 < sdd5 >
[Fri Sep 18 09:58:17 2020] ata7.00: Enabling discard_zeroes_data
[Fri Sep 18 09:58:17 2020] sd 6:0:0:0: [sde] Attached SCSI disk
[Fri Sep 18 09:58:17 2020] sd 5:0:0:0: [sdd] Attached SCSI disk
[Fri Sep 18 09:58:17 2020]  sdf: sdf1
[Fri Sep 18 09:58:17 2020] sd 7:0:0:0: [sdf] Attached SCSI disk
[Fri Sep 18 09:58:17 2020]  sdg: sdg1
[Fri Sep 18 09:58:17 2020] sd 8:0:0:0: [sdg] Attached SCSI disk
[Fri Sep 18 09:58:17 2020] Freeing unused kernel image (initmem) memory: 
6864K
[Fri Sep 18 09:58:17 2020] Write protecting the kernel read-only data: 
32768k
[Fri Sep 18 09:58:17 2020] Freeing unused kernel image (text/rodata gap) 
memory: 2040K
[Fri Sep 18 09:58:17 2020] Freeing unused kernel image (rodata/data gap) 
memory: 1200K
[Fri Sep 18 09:58:17 2020] rodata_test: all tests were successful
[Fri Sep 18 09:58:17 2020] Run /init as init process
[Fri Sep 18 09:58:17 2020]   with arguments:
[Fri Sep 18 09:58:17 2020]     /init
[Fri Sep 18 09:58:17 2020]   with environment:
[Fri Sep 18 09:58:17 2020]     HOME=/
[Fri Sep 18 09:58:17 2020]     TERM=linux
[Fri Sep 18 09:58:17 2020]     BOOT_IMAGE=/boot/vmlinuz-5.8.10
[Fri Sep 18 09:58:17 2020] random: fast init done
[Fri Sep 18 09:58:17 2020] fuseblk: Unknown parameter 'space_cache'
[Fri Sep 18 09:58:17 2020] UDF-fs: bad mount option "space_cache=v2" or 
missing value
[Fri Sep 18 09:58:17 2020] BTRFS: device fsid 
20916588-dd3c-41da-8f46-7521d263bce1 devid 2 transid 334922 /dev/sdd1 
scanned by init (1)
[Fri Sep 18 09:58:17 2020] BTRFS info (device sdd1): allowing degraded 
mounts
[Fri Sep 18 09:58:17 2020] BTRFS info (device sdd1): using free space tree
[Fri Sep 18 09:58:17 2020] BTRFS warning (device sdd1): devid 1 uuid 
1f49a809-96e9-4f81-bc73-504af4b0d13f is missing
[Fri Sep 18 09:58:17 2020] BTRFS warning (device sdd1): devid 1 uuid 
1f49a809-96e9-4f81-bc73-504af4b0d13f is missing
[Fri Sep 18 09:58:17 2020] BTRFS info (device sdd1): enabling ssd 
optimizations
[Fri Sep 18 09:58:17 2020] ------------[ cut here ]------------
[Fri Sep 18 09:58:17 2020] BTRFS: Transaction aborted (error -28)
[Fri Sep 18 09:58:17 2020] WARNING: CPU: 2 PID: 1 at 
fs/btrfs/block-group.c:2128 btrfs_create_pending_block_groups+0x1d1/0x1f0
[Fri Sep 18 09:58:17 2020] Modules linked in:
[Fri Sep 18 09:58:17 2020] CPU: 2 PID: 1 Comm: init Not tainted 5.8.10 #1
[Fri Sep 18 09:58:17 2020] Hardware name: Supermicro X10SRA/X10SRA, BIOS 
1.0a 11/27/2014
[Fri Sep 18 09:58:17 2020] RIP: 
0010:btrfs_create_pending_block_groups+0x1d1/0x1f0
[Fri Sep 18 09:58:17 2020] Code: 50 f0 48 0f ba a8 40 0a 00 00 02 72 1f 
41 83 fc e2 74 19 41 83 fc fb 74 13 44 89 e6 48 c7 c7 58 0b d7 82 31 c0 
e8 bf cd b9 ff <0f> 0b 44 89 e1 ba 50 08 00 00 48 c7 c6 c0 6b 9d 82 48 
89 ef e8 6b
[Fri Sep 18 09:58:17 2020] RSP: 0018:ffffc9000002fb98 EFLAGS: 00010282
[Fri Sep 18 09:58:17 2020] RAX: 0000000000000000 RBX: ffff889035abd508 
RCX: 0000000000000000
[Fri Sep 18 09:58:17 2020] RDX: 0000000000000000 RSI: 0000000000000096 
RDI: 00000000ffffffff
[Fri Sep 18 09:58:17 2020] RBP: ffff8890394b9000 R08: 0000000000000001 
R09: 00000000000003d8
[Fri Sep 18 09:58:17 2020] R10: 0000000000100001 R11: 00000000000003d8 
R12: 00000000ffffffe4
[Fri Sep 18 09:58:17 2020] R13: ffff8890394b9058 R14: ffff889038b9a000 
R15: ffff889038b9a000
[Fri Sep 18 09:58:17 2020] FS:  00007fbc6a746800(0000) 
GS:ffff88903fc80000(0000) knlGS:0000000000000000
[Fri Sep 18 09:58:17 2020] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[Fri Sep 18 09:58:17 2020] CR2: 00007fbc6aa7c730 CR3: 0000001035b3c003 
CR4: 00000000001606e0
[Fri Sep 18 09:58:17 2020] Call Trace:
[Fri Sep 18 09:58:17 2020]  __btrfs_end_transaction+0x59/0x190
[Fri Sep 18 09:58:17 2020]  btrfs_create+0x7a/0x1f0
[Fri Sep 18 09:58:17 2020]  path_openat+0xdd0/0xed0
[Fri Sep 18 09:58:17 2020]  ? set_next_entity+0x20d/0x5d0
[Fri Sep 18 09:58:17 2020]  do_filp_open+0x94/0x110
[Fri Sep 18 09:58:17 2020]  ? follow_down+0x80/0x80
[Fri Sep 18 09:58:17 2020]  ? preempt_schedule_thunk+0x16/0x18
[Fri Sep 18 09:58:17 2020]  ? __alloc_fd+0xa4/0x160
[Fri Sep 18 09:58:17 2020]  ? do_sys_openat2+0x1ac/0x2b0
[Fri Sep 18 09:58:17 2020]  do_sys_openat2+0x1ac/0x2b0
[Fri Sep 18 09:58:17 2020]  do_sys_open+0x55/0x70
[Fri Sep 18 09:58:17 2020]  do_syscall_64+0x43/0x2a0
[Fri Sep 18 09:58:17 2020]  ? __prepare_exit_to_usermode+0x7d/0x1a0
[Fri Sep 18 09:58:17 2020]  ? asm_exc_page_fault+0x8/0x30
[Fri Sep 18 09:58:17 2020]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[Fri Sep 18 09:58:17 2020] RIP: 0033:0x7fbc6aac91ae
[Fri Sep 18 09:58:17 2020] Code: 25 00 00 41 00 3d 00 00 41 00 74 48 48 
8d 05 59 65 0d 00 8b 00 85 c0 75 69 89 f2 b8 01 01 00 00 48 89 fe bf 9c 
ff ff ff 0f 05 <48> 3d 00 f0 ff ff 0f 87 a6 00 00 00 48 8b 4c 24 28 64 
48 33 0c 25
[Fri Sep 18 09:58:17 2020] RSP: 002b:00007ffc8ce34080 EFLAGS: 00000246 
ORIG_RAX: 0000000000000101
[Fri Sep 18 09:58:17 2020] RAX: ffffffffffffffda RBX: 00007ffc8ce34188 
RCX: 00007fbc6aac91ae
[Fri Sep 18 09:58:17 2020] RDX: 0000000000000241 RSI: 000056414a3423e1 
RDI: 00000000ffffff9c
[Fri Sep 18 09:58:17 2020] RBP: 00007ffc8ce34180 R08: 000056414a346fa0 
R09: 00007ffc8ce34080
[Fri Sep 18 09:58:17 2020] R10: 00000000000001a4 R11: 0000000000000246 
R12: 0000000000000000
[Fri Sep 18 09:58:17 2020] R13: 000056414a33c150 R14: 000056414a33c1a0 
R15: 0000000000000000
[Fri Sep 18 09:58:17 2020] ---[ end trace 8c77e1cbd8f75b2d ]---
[Fri Sep 18 09:58:17 2020] BTRFS: error (device sdd1) in 
btrfs_create_pending_block_groups:2128: errno=-28 No space left
[Fri Sep 18 09:58:17 2020] BTRFS info (device sdd1): forced readonly
[Fri Sep 18 09:58:17 2020] scsi 10:0:0:0: Direct-Access     SanDisk 
Cruzer Fit       1.00 PQ: 0 ANSI: 6
[Fri Sep 18 09:58:17 2020] sd 10:0:0:0: Attached scsi generic sg8 type 0
[Fri Sep 18 09:58:17 2020] sd 10:0:0:0: [sdi] 62521344 512-byte logical 
blocks: (32.0 GB/29.8 GiB)
[Fri Sep 18 09:58:17 2020] sd 10:0:0:0: [sdi] Write Protect is off
[Fri Sep 18 09:58:17 2020] sd 10:0:0:0: [sdi] Mode Sense: 43 00 00 00
[Fri Sep 18 09:58:17 2020] sd 10:0:0:0: [sdi] Write cache: disabled, 
read cache: enabled, doesn't support DPO or FUA
[Fri Sep 18 09:58:17 2020]  sdi:
[Fri Sep 18 09:58:17 2020] sd 10:0:0:0: [sdi] Attached SCSI removable disk
[Fri Sep 18 09:58:18 2020] systemd-udevd[3272]: Using default interface 
naming scheme 'v240'.
[Fri Sep 18 09:58:18 2020] systemd-udevd[3272]: link_config: 
autonegotiation is unset or enabled, the speed and duplex are not writable.
[Fri Sep 18 09:58:18 2020] systemd-udevd[3242]: Using default interface 
naming scheme 'v240'.
[Fri Sep 18 09:58:18 2020] systemd-udevd[3242]: link_config: 
autonegotiation is unset or enabled, the speed and duplex are not writable.
[Fri Sep 18 09:58:18 2020] systemd-udevd[3262]: could not open moddep 
file '/lib/modules/5.8.10/modules.dep.bin'
[Fri Sep 18 09:58:18 2020] systemd-udevd[3262]: could not open moddep 
file '/lib/modules/5.8.10/modules.dep.bin'
[Fri Sep 18 09:58:18 2020] BTRFS: device fsid 
91f7e8ce-39ba-4849-80f4-5030d69063ff devid 8 transid 39988287 /dev/sda1 
scanned by systemd-udevd (3241)
[Fri Sep 18 09:58:18 2020] BTRFS: device fsid 
91f7e8ce-39ba-4849-80f4-5030d69063ff devid 7 transid 39988287 /dev/sdb1 
scanned by systemd-udevd (3275)
[Fri Sep 18 09:58:18 2020] BTRFS: device fsid 
91f7e8ce-39ba-4849-80f4-5030d69063ff devid 6 transid 39988287 /dev/sdh1 
scanned by systemd-udevd (3271)
[Fri Sep 18 09:58:18 2020] BTRFS: device fsid 
91f7e8ce-39ba-4849-80f4-5030d69063ff devid 3 transid 39988287 /dev/sdg1 
scanned by systemd-udevd (3241)
[Fri Sep 18 09:58:18 2020] systemd-udevd[3271]: Using default interface 
naming scheme 'v240'.
[Fri Sep 18 09:58:18 2020] systemd-udevd[3233]: link_config: 
autonegotiation is unset or enabled, the speed and duplex are not writable.
[Fri Sep 18 09:58:18 2020] systemd-udevd[3279]: link_config: 
autonegotiation is unset or enabled, the speed and duplex are not writable.
[Fri Sep 18 09:58:18 2020] systemd-udevd[3238]: link_config: 
autonegotiation is unset or enabled, the speed and duplex are not writable.
[Fri Sep 18 09:58:18 2020] BTRFS: device fsid 
91f7e8ce-39ba-4849-80f4-5030d69063ff devid 5 transid 39988287 /dev/sde1 
scanned by systemd-udevd (3275)
[Fri Sep 18 09:58:18 2020] BTRFS: device fsid 
91f7e8ce-39ba-4849-80f4-5030d69063ff devid 1 transid 39988287 /dev/sdc5 
scanned by systemd-udevd (3217)
[Fri Sep 18 09:58:18 2020] BTRFS: device fsid 
91f7e8ce-39ba-4849-80f4-5030d69063ff devid 4 transid 39988287 /dev/sdf1 
scanned by systemd-udevd (3278)
[Fri Sep 18 09:58:18 2020] BTRFS: device fsid 
91f7e8ce-39ba-4849-80f4-5030d69063ff devid 2 transid 39988287 /dev/sdd5 
scanned by systemd-udevd (3217)
[Fri Sep 18 09:58:18 2020] BTRFS info (device sdd1): not using ssd 
optimizations
[Fri Sep 18 09:58:18 2020] BTRFS info (device sdd1): using free space tree
[Fri Sep 18 09:58:18 2020] BTRFS error (device sdd1): Remounting 
read-write after error is not allowed
[Fri Sep 18 09:58:18 2020] BTRFS info (device sdd1): not using ssd 
optimizations
[Fri Sep 18 09:58:18 2020] BTRFS info (device sdd1): using free space tree
[Fri Sep 18 09:58:18 2020] BTRFS error (device sdd1): Remounting 
read-write after error is not allowed
[Fri Sep 18 09:58:18 2020] BTRFS info (device sdc5): using free space tree
[Fri Sep 18 09:58:19 2020] 8021q: adding VLAN 0 to HW filter on device eth0
[Fri Sep 18 09:58:19 2020] random: dbus-daemon: uninitialized urandom 
read (12 bytes read)
[Fri Sep 18 09:58:19 2020] random: dbus-daemon: uninitialized urandom 
read (12 bytes read)
[Fri Sep 18 09:58:20 2020] NFSD: Using /var/lib/nfs/v4recovery as the 
NFSv4 state recovery directory
[Fri Sep 18 09:58:20 2020] NFSD: Using legacy client tracking operations.
[Fri Sep 18 09:58:20 2020] NFSD: starting 90-second grace period (net 
f0000098)
[Fri Sep 18 09:58:22 2020] igb 0000:06:00.0 eth0: igb: eth0 NIC Link is 
Up 1000 Mbps Full Duplex, Flow Control: RX
[Fri Sep 18 09:58:22 2020] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link 
becomes ready
[Fri Sep 18 09:58:22 2020] IPv6: ADDRCONF(NETDEV_CHANGE): eth0.0125: 
link becomes ready
[Fri Sep 18 09:58:22 2020] IPv6: ADDRCONF(NETDEV_CHANGE): eth0.1125: 
link becomes ready
[Fri Sep 18 09:58:33 2020] random: crng init done
[Fri Sep 18 09:59:51 2020] nfsd4: failed to purge old clients from 
recovery directory v4recovery
[Fri Sep 18 10:01:33 2020] BTRFS info (device sdd1): using free space tree
[Fri Sep 18 10:01:33 2020] BTRFS error (device sdd1): Remounting 
read-write after error is not allowed
[Fri Sep 18 10:01:35 2020] BTRFS info (device sdd1): using free space tree
[Fri Sep 18 10:01:35 2020] BTRFS error (device sdd1): Remounting 
read-write after error is not allowed
