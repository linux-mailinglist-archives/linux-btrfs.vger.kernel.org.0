Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9208C130AF6
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jan 2020 01:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgAFApH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Jan 2020 19:45:07 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:45912 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgAFApH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 5 Jan 2020 19:45:07 -0500
Received: by mail-il1-f195.google.com with SMTP id p8so41250877iln.12
        for <linux-btrfs@vger.kernel.org>; Sun, 05 Jan 2020 16:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=hRtUTtByVuAyw1VSw0CFqQLrnnKFKurPGHUsFQlfsUA=;
        b=L9bAmMlhjkg8ZWN14lpGJMI3022pZycwDSH+Yd0sdTWbpkt3WdmqzeoUmRHI5BFR5E
         O3R7tpsJNP1UHmrgooYTeqhxFA9jq6EdmXEWNI+XE/ygRjTZZKVtfd/fH9GE9k8pjxcV
         E9Vn8Cch3oQSrQxt+6QlXatFbr/k0k982PMKaa1bhJv+H3QlVQJWEMOElbwDKEia78Da
         jdUvCucXofVNYpEjaYO33P2E30uJ7Pbr8K1A8wnGnak1dCNNMLnGxWoihxQQpaJ5ZIUP
         +v6RCL1hYYGMaDhmrl8jcKDbJL20B2BL1otdkBd4sBvG8g4/3+VoEeMXEw0EFt0h2+7M
         A8yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=hRtUTtByVuAyw1VSw0CFqQLrnnKFKurPGHUsFQlfsUA=;
        b=ZmvuUkDleXe6JJ645mSCYfdjrDNl71yrWZQWmJPRXdfSghneH3m2W3ZNdq1AG6XMVP
         Jwk/BUlNNE6FzT/IVElnvSEcfyx3/b3NVaOVFNv9mSJofJKrZd1ZoxxIGqKZDrbE2CB3
         Cu9YlPN/RdtcPddNzMkS0sNDLTGD9b0oKSZ7C7rpk0rYou1NQdz0u+TqiCcCK/srQcjC
         dsy5R6Vyw+0GK0b6Cswmw9h4+qoQvIqLIdvpwkXaDA1mvZvWlWVCdXNpQBY15UMEKmG6
         wnx1pivzdQnlZFLvonZZA+iv+poybo0S/a2ysPRTDiUu3DlFfCCDMHNDiDlkZQcsAsbk
         LaJg==
X-Gm-Message-State: APjAAAWu+IywBg9GWMV+OL5V/VA/zL1zYoS3vcED7TJki5jJmsR3APeh
        dA4oy6EWaV+k0iGSwUzmAKSOv/Df2QL8y6YklBoGy3ln
X-Google-Smtp-Source: APXvYqxVTz2Z91kobAieriAxyyoqL/v3Shfpdu7qmWaLr1FdS06G59Had8u9htpByeVTdEwxF7KNrk0TPPOCmHPdPO8=
X-Received: by 2002:a92:15c1:: with SMTP id 62mr82492566ilv.216.1578271505235;
 Sun, 05 Jan 2020 16:45:05 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?B?5b6M6Jek6ZqG6LyU?= <ryusuke1925@gmail.com>
Date:   Mon, 6 Jan 2020 09:46:09 +0900
Message-ID: <CACh0PmEOx7KGY8vMYbNqNEkJtkws2VkvzKn6g3h66QQm7pSqiA@mail.gmail.com>
Subject: BUG_ON() in __do_readpage function of fs/btrfs/extent_io.c in page
 fault sequence.
To:     linux-btrfs@vger.kernel.org
Cc:     tomoyuki.fujino.bn@hco.ntt.co.jp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We encounted a BUG_ON() case when we use a JAVA's persistent caching
library Ehcache on BTRFS.
And we tried to find out the cause of BUG_ON() case and we also tried
the experiental code for eliminating this program.
Details are following.

[Bug]
BUG_ON() in __do_readpage function of fs/btrfs/extent_io.c in page
fault sequence.

[Environment]
develop@develop-PowerEdge-R720:~$ uname -a
Linux develop-PowerEdge-R720 5.3.0-19-generic #20~18.04.2-Ubuntu SMP
Tue Oct 22 18:09:07 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux

develop@develop-PowerEdge-R720:~$ btrfs --version
btrfs-progs v4.15.1

develop@develop-PowerEdge-R720:~$ sudo btrfs fi show
Label: none  uuid: 607f4f97-e229-490b-9102-8e0f1eee88c4
        Total devices 1 FS bytes used 4.95MiB
        devid    1 size 186.31GiB used 2.02GiB path /dev/sdb1

develop@develop-PowerEdge-R720:~$ sudo btrfs fi df /mnt/btrfs-bug/
Data, single: total=3D1.01GiB, used=3D4.79MiB
System, single: total=3D4.00MiB, used=3D16.00KiB
Metadata, single: total=3D1.01GiB, used=3D144.00KiB
GlobalReserve, single: total=3D16.00MiB, used=3D0.00B

[How to reproduce]
Keep this program running on btrfs. This program is a simplified JAVA
program which uses Ehcache. The bug can be reproduced in 30 minutes to
2 hours.
We tried to find out easier reproduction code (it may be a user space
C program), but we have not yet.
=E2=86=92[Reproduction program]

[kern.log]
Dec 20 15:09:52 develop-PowerEdge-R720 kernel: [ 6563.412239]
------------[ cut here ]------------
Dec 20 15:09:52 develop-PowerEdge-R720 kernel: [ 6563.412244] kernel
BUG at /build/linux-hwe-edge-6rZAWs/linux-hwe-edge-5.3.0/fs/btrfs/extent_io=
.c:3126!
Dec 20 15:09:52 develop-PowerEdge-R720 kernel: [ 6563.412254] invalid
opcode: 0000 [#1] SMP PTI
Dec 20 15:09:52 develop-PowerEdge-R720 kernel: [ 6563.412258] CPU: 27
PID: 2453 Comm: java Not tainted 5.3.0-19-generic #20~18.04.2-Ubuntu
Dec 20 15:09:52 develop-PowerEdge-R720 kernel: [ 6563.412259] Hardware
name: Dell Inc. PowerEdge R720/0C4Y3R, BIOS 2.0.19 08/29/2013
Dec 20 15:09:52 develop-PowerEdge-R720 kernel: [ 6563.412295] RIP:
0010:__do_readpage+0x688/0x850 [btrfs]
Dec 20 15:09:52 develop-PowerEdge-R720 kernel: [ 6563.412297] Code: 86
fd ff ff 31 c9 48 03 50 20 0f 92 c1 4c 39 fa 77 09 48 85 c9 0f 84 ba
fe ff ff f0 ff 40 78 0f 88 6e e0 06 00 e9 da fa ff ff <0f> 0b 48 8b 5d
c0 48 8b 7d b0 45 31 c9 41 b8 01 00 00 00 b9 02 00
Dec 20 15:09:52 develop-PowerEdge-R720 kernel: [ 6563.412299] RSP:
0000:ffffb64b497d39a8 EFLAGS: 00010287
Dec 20 15:09:52 develop-PowerEdge-R720 kernel: [ 6563.412301] RAX:
ffff8fb942f9c750 RBX: 0000000000001000 RCX: 000000000005b000
Dec 20 15:09:52 develop-PowerEdge-R720 kernel: [ 6563.412302] RDX:
000000000007b000 RSI: 0000000000000000 RDI: 000000000007b000
Dec 20 15:09:52 develop-PowerEdge-R720 kernel: [ 6563.412303] RBP:
ffffb64b497d3a78 R08: ffffb64b497d3ac0 R09: 0000000000000000
Dec 20 15:09:52 develop-PowerEdge-R720 kernel: [ 6563.412304] R10:
ffffb64b497d3ae0 R11: 0000270540dacbbf R12: ffff8fb9b9ac4eb0
Dec 20 15:09:52 develop-PowerEdge-R720 kernel: [ 6563.412305] R13:
0000000000000000 R14: 0000000000000000 R15: 00000000004d0000
Dec 20 15:09:52 develop-PowerEdge-R720 kernel: [ 6563.412306] FS:
00007f081020b700(0000) GS:ffff8fb9bf940000(0000)
knlGS:0000000000000000
Dec 20 15:09:52 develop-PowerEdge-R720 kernel: [ 6563.412307] CS:
0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Dec 20 15:09:52 develop-PowerEdge-R720 kernel: [ 6563.412308] CR2:
00007f06fa3f2000 CR3: 0000001ffa3e4003 CR4: 00000000000606e0
Dec 20 15:09:52 develop-PowerEdge-R720 kernel: [ 6563.412309] Call Trace:
Dec 20 15:09:52 develop-PowerEdge-R720 kernel: [ 6563.412330]  ?
btrfs_lookup_ordered_range+0x13b/0x180 [btrfs]
Dec 20 15:09:52 develop-PowerEdge-R720 kernel: [ 6563.412344]  ?
btrfs_releasepage+0x70/0x70 [btrfs]
Dec 20 15:09:52 develop-PowerEdge-R720 kernel: [ 6563.412361]
extent_readpages+0x1f3/0x360 [btrfs]
Dec 20 15:09:52 develop-PowerEdge-R720 kernel: [ 6563.412376]
btrfs_readpages+0x16/0x20 [btrfs]
Dec 20 15:09:52 develop-PowerEdge-R720 kernel: [ 6563.412380]
read_pages+0x6b/0x190
Dec 20 15:09:52 develop-PowerEdge-R720 kernel: [ 6563.412382]
__do_page_cache_readahead+0x12f/0x190
Dec 20 15:09:52 develop-PowerEdge-R720 kernel: [ 6563.412384]  ?
__do_page_cache_readahead+0x12f/0x190
Dec 20 15:09:52 develop-PowerEdge-R720 kernel: [ 6563.412385]
filemap_fault+0x37e/0x9f0
Dec 20 15:09:52 develop-PowerEdge-R720 kernel: [ 6563.412389]  ?
__alloc_pages_nodemask+0x153/0x320
Dec 20 15:09:52 develop-PowerEdge-R720 kernel: [ 6563.412391]  ?
alloc_pages_current+0x6a/0xe0
Dec 20 15:09:52 develop-PowerEdge-R720 kernel: [ 6563.412394]
__do_fault+0x57/0x117
Dec 20 15:09:52 develop-PowerEdge-R720 kernel: [ 6563.412396]
__handle_mm_fault+0xce6/0x1230
Dec 20 15:09:52 develop-PowerEdge-R720 kernel: [ 6563.412397]  ?
do_mmap+0x3e7/0x590
Dec 20 15:09:52 develop-PowerEdge-R720 kernel: [ 6563.412399]
handle_mm_fault+0xcb/0x210
Dec 20 15:09:52 develop-PowerEdge-R720 kernel: [ 6563.412403]
__do_page_fault+0x2a1/0x4d0
Dec 20 15:09:52 develop-PowerEdge-R720 kernel: [ 6563.412405]
do_page_fault+0x2c/0xe0
Dec 20 15:09:52 develop-PowerEdge-R720 kernel: [ 6563.412408]
page_fault+0x34/0x40
Dec 20 15:09:52 develop-PowerEdge-R720 kernel: [ 6563.412410] RIP:
0033:0x7f07f097e3f6
Dec 20 15:09:52 develop-PowerEdge-R720 kernel: [ 6563.412412] Code: d6
f8 48 f7 da e9 4a 00 00 00 48 8b 44 d7 08 48 89 44 d1 08 48 ff c2 75
f1 48 33 c0 c5 f8 77 c9 c3 66 66 90 c5 fa 6f 44 d7 c8 <c5> fa 7f 44 d1
c8 c5 fa 6f 4c d7 d8 c5 fa 7f 4c d1 d8 c5 fa 6f 54
Dec 20 15:09:52 develop-PowerEdge-R720 kernel: [ 6563.412413] RSP:
002b:00007f081020a4e0 EFLAGS: 00010286
Dec 20 15:09:52 develop-PowerEdge-R720 kernel: [ 6563.412414] RAX:
00000000d6c95500 RBX: 0000000000000000 RCX: 00007f06fa3f23f8
Dec 20 15:09:52 develop-PowerEdge-R720 kernel: [ 6563.412415] RDX:
ffffffffffffff88 RSI: 00007f06fa3f2000 RDI: 00000000d6c954f8
Dec 20 15:09:52 develop-PowerEdge-R720 kernel: [ 6563.412416] RBP:
00007f081020a4e0 R08: 00007f06fa3f2000 R09: 0000000000000000
Dec 20 15:09:52 develop-PowerEdge-R720 kernel: [ 6563.412417] R10:
00007f07f097f160 R11: 00000000fff00038 R12: 0000000000000000
Dec 20 15:09:52 develop-PowerEdge-R720 kernel: [ 6563.412418] R13:
00000000d6c95068 R14: 00000000d6c95068 R15: 00007f0808014800
Dec 20 15:09:52 develop-PowerEdge-R720 kernel: [ 6563.412420] Modules
linked in: xt_CHECKSUM iptable_mangle xt_MASQUERADE iptable_nat nf_nat
xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ipt_REJECT
nf_reject_ipv4 xt_tcpudp bridge stp llc ebtable_filter ebtables
ip6table_filter ip6_tables iptable_filter bpfilter ipmi_ssif kvm_intel
kvm irqbypass crct10dif_pclmul crc32_pclmul joydev input_leds
ghash_clmulni_intel aesni_intel aes_x86_64 crypto_simd cryptd
glue_helper ipmi_si ipmi_devintf ipmi_msghandler sch_fq_codel
parport_pc ppdev lp parport ip_tables x_tables autofs4 btrfs
zstd_compress raid10 raid456 async_raid6_recov async_memcpy async_pq
async_xor async_tx xor raid6_pq libcrc32c raid1 raid0 multipath linear
hid_generic usbhid hid igb ahci libahci megaraid_sas dca i2c_algo_bit
Dec 20 15:09:52 develop-PowerEdge-R720 kernel: [ 6563.412450] ---[ end
trace 4b883e2c3060cd99 ]---
Dec 20 15:09:52 develop-PowerEdge-R720 kernel: [ 6563.415299] RIP:
0010:__do_readpage+0x688/0x850 [btrfs]
Dec 20 15:09:52 develop-PowerEdge-R720 kernel: [ 6563.415301] Code: 86
fd ff ff 31 c9 48 03 50 20 0f 92 c1 4c 39 fa 77 09 48 85 c9 0f 84 ba
fe ff ff f0 ff 40 78 0f 88 6e e0 06 00 e9 da fa ff ff <0f> 0b 48 8b 5d
c0 48 8b 7d b0 45 31 c9 41 b8 01 00 00 00 b9 02 00
Dec 20 15:09:52 develop-PowerEdge-R720 kernel: [ 6563.415302] RSP:
0000:ffffb64b497d39a8 EFLAGS: 00010287
Dec 20 15:09:52 develop-PowerEdge-R720 kernel: [ 6563.415304] RAX:
ffff8fb942f9c750 RBX: 0000000000001000 RCX: 000000000005b000
Dec 20 15:09:52 develop-PowerEdge-R720 kernel: [ 6563.415306] RDX:
000000000007b000 RSI: 0000000000000000 RDI: 000000000007b000
Dec 20 15:09:52 develop-PowerEdge-R720 kernel: [ 6563.415307] RBP:
ffffb64b497d3a78 R08: ffffb64b497d3ac0 R09: 0000000000000000
Dec 20 15:09:52 develop-PowerEdge-R720 kernel: [ 6563.415309] R10:
ffffb64b497d3ae0 R11: 0000270540dacbbf R12: ffff8fb9b9ac4eb0
Dec 20 15:09:52 develop-PowerEdge-R720 kernel: [ 6563.415311] R13:
0000000000000000 R14: 0000000000000000 R15: 00000000004d0000
Dec 20 15:09:52 develop-PowerEdge-R720 kernel: [ 6563.415313] FS:
00007f081020b700(0000) GS:ffff8fb9bf940000(0000)
knlGS:0000000000000000
Dec 20 15:09:52 develop-PowerEdge-R720 kernel: [ 6563.415315] CS:
0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Dec 20 15:09:52 develop-PowerEdge-R720 kernel: [ 6563.415316] CR2:
00007f06fa3f2000 CR3: 0000001ffa3e4003 CR4: 00000000000606e0
Dec 20 15:10:03 develop-PowerEdge-R720 kernel: [ 6574.865743] usb
1-1.2: new low-speed USB device number 5 using ehci-pci
Dec 20 15:10:03 develop-PowerEdge-R720 kernel: [ 6574.980142] usb
1-1.2: New USB device found, idVendor=3D046d, idProduct=3Dc03d,
bcdDevice=3D20.00
Dec 20 15:10:03 develop-PowerEdge-R720 kernel: [ 6574.980149] usb
1-1.2: New USB device strings: Mfr=3D1, Product=3D2, SerialNumber=3D0
Dec 20 15:10:03 develop-PowerEdge-R720 kernel: [ 6574.980153] usb
1-1.2: Product: USB-PS/2 Optical Mouse
Dec 20 15:10:03 develop-PowerEdge-R720 kernel: [ 6574.980156] usb
1-1.2: Manufacturer: Logitech
Dec 20 15:10:03 develop-PowerEdge-R720 kernel: [ 6574.984219] input:
Logitech USB-PS/2 Optical Mouse as
/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.2/1-1.2:1.0/0003:046D:C03D.00=
04/input/input4
Dec 20 15:10:03 develop-PowerEdge-R720 kernel: [ 6574.984788]
hid-generic 0003:046D:C03D.0004: input,hidraw3: USB HID v1.10 Mouse
[Logitech USB-PS/2 Optical Mouse] on usb-0000:00:1a.0-1.2/input0
Dec 20 15:10:11 develop-PowerEdge-R720 kernel: [ 6582.549476] usb
1-1.5: new low-speed USB device number 6 using ehci-pci
Dec 20 15:10:11 develop-PowerEdge-R720 kernel: [ 6582.668145] usb
1-1.5: New USB device found, idVendor=3D413c, idProduct=3D2103, bcdDevice=
=3D
1.00
Dec 20 15:10:11 develop-PowerEdge-R720 kernel: [ 6582.668152] usb
1-1.5: New USB device strings: Mfr=3D1, Product=3D2, SerialNumber=3D0
Dec 20 15:10:11 develop-PowerEdge-R720 kernel: [ 6582.668156] usb
1-1.5: Product: Dell USB/PS2 Combo Rackmount Keyboard
Dec 20 15:10:11 develop-PowerEdge-R720 kernel: [ 6582.668159] usb
1-1.5: Manufacturer: LITE-ON Technology
Dec 20 15:10:11 develop-PowerEdge-R720 kernel: [ 6582.673143] input:
LITE-ON Technology Dell USB/PS2 Combo Rackmount Keyboard as
/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.5/1-1.5:1.0/0003:413C:2103.00=
05/input/input5
Dec 20 15:10:11 develop-PowerEdge-R720 kernel: [ 6582.730090]
hid-generic 0003:413C:2103.0005: input,hidraw4: USB HID v1.00 Keyboard
[LITE-ON Technology Dell USB/PS2 Combo Rackmount Keyboard] on
usb-0000:00:1a.0-1.5/input0
Dec 20 15:10:11 develop-PowerEdge-R720 kernel: [ 6582.733717] input:
LITE-ON Technology Dell USB/PS2 Combo Rackmount Keyboard as
/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.5/1-1.5:1.1/0003:413C:2103.00=
06/input/input6
Dec 20 15:10:11 develop-PowerEdge-R720 kernel: [ 6582.793977]
hid-generic 0003:413C:2103.0006: input,hidraw5: USB HID v1.10 Mouse
[LITE-ON Technology Dell USB/PS2 Combo Rackmount Keyboard] on
usb-0000:00:1a.0-1.5/input1

[Cause]
The immediate cause of BUG_ON is the end of an extent map before start
point (extent_map_end(em) <=3D cur).
However, the extent map has been checked once in function
btrfs_get_extent_map().
We added a bit code for outputting extent map parameters if they were
the same condition as BUG_ON.
The result of experiment shows that the parameter of the extent map is
changed in a short period.
It implies that some other thread may over-write the extent map
parameters while the reader thread is still reading.
Moreover, length of extent map is different before and after BUG_ON.


@@ -3073,6 +3073,7 @@ static int __do_readpage(struct extent_i
        size_t disk_io_size;
        size_t blocksize =3D inode->i_sb->s_blocksize;
        unsigned long this_bio_flag =3D 0;
+       int flag=3D0;

        set_page_extent_mapped(page);

@@ -3128,11 +3129,17 @@ static int __do_readpage(struct extent_i
                if (extent_map_end(em) <=3D cur) {
                        printk("this is temporary code!! bad extent!
em: [%llu %llu] current [%llu]",
                                        em->start, em->len, cur);
+                       flag=3D1;
                }

                BUG_ON(extent_map_end(em) <=3D cur);
                BUG_ON(end < cur);

+               if (flag) {
+                       printk("Confirmation:em: [%llu %llu] current [%llu]=
",
+                                       em->start, em->len, cur);
+               }
+
                if (test_bit(EXTENT_FLAG_COMPRESSED, &em->flags)) {
                        this_bio_flag |=3D EXTENT_BIO_COMPRESSED;
                        extent_set_compress_type(&this_bio_flag,

/var/log/kern.log
***************************************************************************=
*************************************************************
Dec  2 14:30:28 develop-PowerEdge-R720 kernel: [ 1281.899334] this is
temporary code!! bad extent! em: [372736 65536] current [1757184]
Dec  2 14:30:28 develop-PowerEdge-R720 kernel: [ 1281.899335]
Confirmation em: [372736 1396736] current [1757184]
***************************************************************************=
*************************************************************

It is probably merge_extent_mapping() or try_merge_map() that rewrites
the parameters.
But, extent map which is operated by merge_extent_mapping() was not
registered in the tree.
So, merge_extent_mapping() has not rewritten extent map.
However, extent map which is operated by try_merge_map() had been
registered in the tree.

And, extent tree which is operated by try_merge_map() had been done
write_lock().

If reference count of extent map is 2 after write_lock(),
try_merge_map() has not rewritten extent map.
The one is tree, the other is try_merge_map().
But, reference count was 2~4 when we confirm that.
So, try_merge_map() overwrite the extent map parameters while the
reader thread is still reading.

@@ -239,6 +239,8 @@ static void try_merge_map(struct extent_
                if (rb)
                        merge =3D rb_entry(rb, struct extent_map, rb_node);
                if (rb && mergable_maps(merge, em)) {
+
+                       printk("try_merge_map:ref_count(prev)=3D%d",
refcount_read(&(em->refs)));

                        em->start =3D merge->start;
                        em->orig_start =3D merge->orig_start;
@@ -260,6 +262,8 @@ static void try_merge_map(struct extent_
                merge =3D rb_entry(rb, struct extent_map, rb_node);
        if (rb && mergable_maps(em, merge)) {

+               printk("try_merge_map:ref_count(next)=3D%d",
refcount_read(&(em->refs)));
+
                em->len +=3D merge->len;
                em->block_len +=3D merge->block_len;
                rb_erase_cached(&merge->rb_node, &tree->map);

/var/log/kern.log
***************************************************************************=
*************************************************************
Dec 11 11:12:34 develop-PowerEdge-R720 kernel: [  276.872194]
try_merge_map:ref_count(prev)=3D2
Dec 11 11:12:34 develop-PowerEdge-R720 kernel: [  276.872445]
try_merge_map:ref_count(prev)=3D2
Dec 11 11:12:34 develop-PowerEdge-R720 kernel: [  276.872681]
try_merge_map:ref_count(prev)=3D2
Dec 11 11:12:34 develop-PowerEdge-R720 kernel: [  276.872959]
try_merge_map:ref_count(prev)=3D2
Dec 11 11:12:34 develop-PowerEdge-R720 kernel: [  276.873302]
try_merge_map:ref_count(prev)=3D3
Dec 11 11:12:34 develop-PowerEdge-R720 kernel: [  276.873605]
try_merge_map:ref_count(prev)=3D3
Dec 11 11:12:34 develop-PowerEdge-R720 kernel: [  276.873873]
try_merge_map:ref_count(prev)=3D3
Dec 11 11:12:34 develop-PowerEdge-R720 kernel: [  276.874115]
try_merge_map:ref_count(prev)=3D4
Dec 11 11:12:34 develop-PowerEdge-R720 kernel: [  276.874358]
try_merge_map:ref_count(prev)=3D3
Dec 11 11:12:34 develop-PowerEdge-R720 kernel: [  276.874662]
try_merge_map:ref_count(prev)=3D2
Dec 11 11:12:34 develop-PowerEdge-R720 kernel: [  276.882132]
try_merge_map:ref_count(prev)=3D2
Dec 11 11:12:34 develop-PowerEdge-R720 kernel: [  276.882403]
try_merge_map:ref_count(prev)=3D2
Dec 11 11:12:34 develop-PowerEdge-R720 kernel: [  276.882648]
try_merge_map:ref_count(prev)=3D2
Dec 11 11:12:34 develop-PowerEdge-R720 kernel: [  276.882894]
try_merge_map:ref_count(prev)=3D2
Dec 11 11:12:34 develop-PowerEdge-R720 kernel: [  276.883199]
try_merge_map:ref_count(prev)=3D2
Dec 11 11:12:34 develop-PowerEdge-R720 kernel: [  276.888945]
try_merge_map:ref_count(prev)=3D2
Dec 11 11:12:34 develop-PowerEdge-R720 kernel: [  276.889192]
try_merge_map:ref_count(prev)=3D2
Dec 11 11:12:34 develop-PowerEdge-R720 kernel: [  276.889419]
try_merge_map:ref_count(prev)=3D2
***************************************************************************=
*************************************************************

The cause of the bug is conflict between reading by __do_readpage()
and writing by try_merge_map().

[Improvement]
It is necessary to wait to leave all reading threads before over
writing the extent_map in try_merge_map
So that, added busy wait to the code.
By adapting this improvement, no bugs occurred for more than 72 hours
running previous program.

@@ -239,6 +239,9 @@ static void try_merge_map(struct extent_
                if (rb)
                        merge =3D rb_entry(rb, struct extent_map, rb_node);
                if (rb && mergable_maps(merge, em)) {
+
+                       while(refcount_read(&(em->refs))>2){
+                       }

                        em->start =3D merge->start;
                        em->orig_start =3D merge->orig_start;
@@ -260,6 +263,9 @@ static void try_merge_map(struct extent_
                merge =3D rb_entry(rb, struct extent_map, rb_node);
        if (rb && mergable_maps(em, merge)) {

+               while(refcount_read(&(em->refs))>2){
+               }
+
                em->len +=3D merge->len;
                em->block_len +=3D merge->block_len;
                rb_erase_cached(&merge->rb_node, &tree->map);
[Reproduction program]TestEhCache.java-------------------------------------=
---------------------------------------------------------------------------=
-----------------------------------------------------
import org.ehcache.Cache;
import org.ehcache.CacheManager;
import org.ehcache.config.builders.CacheConfigurationBuilder;
import org.ehcache.config.builders.CacheManagerBuilder;
import org.ehcache.config.builders.PooledExecutionServiceConfigurationBuild=
er;
import org.ehcache.config.builders.ResourcePoolsBuilder;
import org.ehcache.config.units.EntryUnit;
import org.ehcache.config.units.MemoryUnit;
import org.ehcache.impl.config.executor.PooledExecutionServiceConfiguration=
;
import java.util.concurrent.ConcurrentHashMap;
import org.ehcache.PersistentCacheManager;
import org.ehcache.CachePersistenceException;

public class TestEhCache {

    /**
     * =E3=82=A4=E3=83=B3=E3=82=B9=E3=82=BF=E3=83=B3=E3=82=B9=E6=83=85=E5=
=A0=B1=E5=90=91=E3=81=91=E3=82=AD=E3=83=A3=E3=83=83=E3=82=B7=E3=83=A5=E9=96=
=A2=E9=80=A3=E3=82=A4=E3=83=B3=E3=82=B9=E3=82=BF=E3=83=B3=E3=82=B9.
     */
    private CacheConfigurationBuilder<String, InstanceAclInfo>
cacheConfigBuilder;

    private CacheManager cacheManager;

    public TestEhCache() {
    }

    public TestEhCache(CacheConfigurationBuilder<String,
InstanceAclInfo> cacheConfigBuilder, CacheManager cacheManager) {
        this.cacheConfigBuilder =3D cacheConfigBuilder;
        this.cacheManager =3D cacheManager;
    }

    private static class EhcachePair {
        private final CacheManager cacheManager;
        private final CacheConfigurationBuilder cacheConfigBuilder;

        EhcachePair(CacheManager cacheManager,
CacheConfigurationBuilder cacheConfBuilder) {
            this.cacheManager =3D cacheManager;
            this.cacheConfigBuilder =3D cacheConfBuilder;
        }

        public CacheConfigurationBuilder cacheConfigBuilder() {
            return cacheConfigBuilder;
        }

        public CacheManager cacheManager() {
            return cacheManager;
        }
    }

    private static EhcachePair buildCacheManager(boolean isPersistent) {

        // 1. Resource Pool Builder
        ResourcePoolsBuilder poolBuilder =3D
                ResourcePoolsBuilder.newResourcePoolsBuilder()
                        .heap(1000, EntryUnit.ENTRIES);
        if (isPersistent) {
            poolBuilder =3D poolBuilder.disk(1024, MemoryUnit.MB, true);
        }

        // 2. Cache Configuration
        CacheConfigurationBuilder cacheConfBuilder =3D

CacheConfigurationBuilder.newCacheConfigurationBuilder(String.class,
InstanceAclInfo.class, poolBuilder);

        // 3. Cache Manager
        CacheManager cacheManager;
        CacheManagerBuilder<CacheManager> cacheMngBuilder =3D
                CacheManagerBuilder.newCacheManagerBuilder();

        if (isPersistent) {
            PooledExecutionServiceConfiguration poolExecutorConfBuilder =3D

PooledExecutionServiceConfigurationBuilder.newPooledExecutionServiceConfigu=
rationBuilder()
                            .defaultPool("defaultPool", (20 + 1) / 2, 20)
                            .build();

            cacheManager =3D
                    cacheMngBuilder
                            .using(poolExecutorConfBuilder)
                            .with(CacheManagerBuilder.persistence("controll=
er"))
                            .build(true);
        } else {
            cacheManager =3D cacheMngBuilder.build(true);
        }

        return new EhcachePair(cacheManager, cacheConfBuilder);
    }

    public static void main(String[] args) {

        // =E5=88=9D=E6=9C=9F=E5=8C=96
        EhcachePair pair;
        pair =3D buildCacheManager(true);
        TestEhCache testEhCache =3D new TestEhCache();
        testEhCache.cacheManager =3D pair.cacheManager;
        testEhCache.cacheConfigBuilder =3D pair.cacheConfigBuilder;

        // =E3=82=AD=E3=83=A3=E3=83=83=E3=82=B7=E3=83=A5
        ConcurrentHashMap<String, InstanceAclInfo> instanceAclMap =3D
new ConcurrentHashMap<>();
        ConcurrentHashMap<Integer, Cache<String, InstanceAclInfo>>
appMap =3D new ConcurrentHashMap<>();

        // =E8=A9=A6=E9=A8=93=E3=83=91=E3=83=A9=E3=83=A1=E3=83=BC=E3=82=BF
        /** =E3=82=A2=E3=83=97=E3=83=AA=E6=95=B0 **/
        int app_num =3D 1;
        /** =E3=82=B3=E3=83=B3=E3=83=88=E3=83=AD=E3=83=BC=E3=83=A9=E6=95=B0=
 **/
        int controller_num =3D 100;
        /** =E3=82=B3=E3=83=B3=E3=83=88=E3=83=AD=E3=83=BC=E3=83=A9=E3=81=82=
=E3=81=9F=E3=82=8A=E3=81=AE=E3=82=A4=E3=83=B3=E3=82=B9=E3=82=BF=E3=83=B3=E3=
=82=B9=E6=95=B0 **/
        int instance_num_per_controller =3D 200;
        // controller=E6=95=B0 * =E3=82=B3=E3=83=B3=E3=83=88=E3=83=AD=E3=83=
=BC=E3=83=A9=E3=81=82=E3=81=9F=E3=82=8A=E3=81=AE=E3=82=A4=E3=83=B3=E3=82=B9=
=E3=82=BF=E3=83=B3=E3=82=B9=E6=95=B0
        int instance_num =3D controller_num * instance_num_per_controller;

        // instance_num=E6=95=B0=E5=88=86=E3=81=AEInstanceAclInfo=E3=82=92=
=E4=BD=9C=E6=88=90
        for (int ins =3D 0; ins < instance_num; ins++) {
            String key =3D "controller_instance_" + ins;
            InstanceAclInfo instanceAclInfo =3D new
InstanceAclInfo(Boolean.TRUE, Boolean.FALSE, Boolean.FALSE,
Boolean.TRUE);
            instanceAclMap.put(key, instanceAclInfo);
        }
        // cache=E3=81=AB=E7=99=BB=E9=8C=B2
        while(true){
            for (int ap =3D 0; ap < app_num; ap++) {
                // =E3=82=AD=E3=83=A3=E3=83=83=E3=82=B7=E3=83=A5=E3=82=92=
=E5=89=8A=E9=99=A4
                testEhCache.cacheManager.removeCache("app-" + ap);
                try {
                    System.out.println("Destroy Cache");
                    ((PersistentCacheManager)
testEhCache.cacheManager).destroyCache("app-" + ap);
                } catch (CachePersistenceException e) {
                    System.out.println(e);
                }

                // =E3=82=AD=E3=83=A3=E3=83=83=E3=82=B7=E3=83=A5=E3=82=92=
=E4=BD=9C=E6=88=90
                Cache<String, InstanceAclInfo> cache =3D
testEhCache.cacheManager.createCache("app-" + ap,
testEhCache.cacheConfigBuilder);
                // =E3=82=AD=E3=83=A3=E3=83=83=E3=82=B7=E3=83=A5=E3=81=AB=
=E7=99=BB=E9=8C=B2
                cache.putAll(instanceAclMap);
            }
        }
    }
}


InstanceAclInfo.java-------------------------------------------------------=
---------------------------------------------------------------------------=
-----------------------------------
 import java.io.Serializable;

/**
 * =E3=82=A4=E3=83=B3=E3=82=B9=E3=82=BF=E3=83=B3=E3=82=B9ACL=E6=83=85=E5=A0=
=B1<br>
 * =E3=82=B3=E3=83=B3=E3=83=88=E3=83=AD=E3=83=BC=E3=83=A9=E3=81=AE=E3=82=A2=
=E3=82=AF=E3=82=BB=E3=82=B9=E5=AF=BE=E8=B1=A1=E3=80=81=E3=82=A2=E3=82=AF=E3=
=82=BB=E3=82=B9=E8=A8=B1=E5=8F=AF=E3=81=AE=E6=83=85=E5=A0=B1=E3=82=92=E4=BF=
=9D=E6=8C=81=E3=81=99=E3=82=8B=E3=80=82 <br>
 * SerializedName=E3=82=A2=E3=83=8E=E3=83=86=E3=83=BC=E3=82=B7=E3=83=A7=E3=
=83=B3=E3=81=A7=E3=80=81=E3=82=A2=E3=82=AF=E3=82=BB=E3=82=B9=E5=88=B6=E5=BE=
=A1=E3=83=AB=E3=83=BC=E3=83=ABJSON=E3=81=A8=E3=81=AE=E5=AF=BE=E5=BF=9C=E4=
=BB=98=E3=81=91=E3=82=92=E8=A1=8C=E3=81=86.
 */
public class InstanceAclInfo implements Serializable {
    private static final long serialVersionUID =3D 1L;

    /** REST=E3=81=A7=E3=81=AE=E3=82=A2=E3=82=AF=E3=82=BB=E3=82=B9=E5=AF=BE=
=E8=B1=A1=E3=83=95=E3=83=A9=E3=82=B0. */
    private Boolean restChecked;

    /** REST=E3=81=A7=E3=81=AE=E3=82=A2=E3=82=AF=E3=82=BB=E3=82=B9=E8=A8=B1=
=E5=8F=AF=E3=83=95=E3=83=A9=E3=82=B0. */
    private Boolean restAllowed;

    /** RPC=E3=81=A7=E3=81=AE=E3=82=A2=E3=82=AF=E3=82=BB=E3=82=B9=E8=A8=B1=
=E5=8F=AF=E3=83=95=E3=83=A9=E3=82=B0. */
    private Boolean rpcAllowed;

    /** =E3=82=B3=E3=83=B3=E3=83=88=E3=83=AD=E3=83=BC=E3=83=A9=E3=82=A4=E3=
=83=B3=E3=82=B9=E3=82=BF=E3=83=B3=E3=82=B9=E3=81=8B=E3=81=A9=E3=81=86=E3=81=
=8B=E3=81=AE=E3=83=95=E3=83=A9=E3=82=B0. */
    private Boolean isController;

    public InstanceAclInfo(
            Boolean restChecked, Boolean restAllowed, Boolean
rpcAllowed, Boolean isController) {
        this.restChecked =3D restChecked;
        this.restAllowed =3D restAllowed;
        this.rpcAllowed =3D rpcAllowed;
        this.isController =3D isController;
    }

    /**
     * REST=E3=81=A7=E3=81=AE=E3=82=A2=E3=82=AF=E3=82=BB=E3=82=B9=E5=AF=BE=
=E8=B1=A1=E3=83=95=E3=83=A9=E3=82=B0=E3=82=92=E8=BF=94=E3=81=99.
     *
     * @return REST=E3=81=A7=E3=81=AE=E3=82=A2=E3=82=AF=E3=82=BB=E3=82=B9=
=E5=AF=BE=E8=B1=A1
     */
    public Boolean getRestChecked() {
        return restChecked;
    }

    /**
     * REST=E3=81=A7=E3=81=AE=E3=82=A2=E3=82=AF=E3=82=BB=E3=82=B9=E5=AF=BE=
=E8=B1=A1=E3=83=95=E3=83=A9=E3=82=B0=E3=82=92=E8=A8=AD=E5=AE=9A=E3=81=99=E3=
=82=8B.
     *
     * @param restChecked REST=E3=81=A7=E3=81=AE=E3=82=A2=E3=82=AF=E3=82=BB=
=E3=82=B9=E5=AF=BE=E8=B1=A1=E3=83=95=E3=83=A9=E3=82=B0
     */
    public void setRestChecked(Boolean restChecked) {
        this.restChecked =3D restChecked;
    }

    /**
     * REST=E3=81=A7=E3=81=AE=E3=82=A2=E3=82=AF=E3=82=BB=E3=82=B9=E8=A8=B1=
=E5=8F=AF=E3=83=95=E3=83=A9=E3=82=B0=E3=82=92=E8=BF=94=E3=81=99.
     *
     * @return REST=E3=81=A7=E3=81=AE=E3=82=A2=E3=82=AF=E3=82=BB=E3=82=B9=
=E8=A8=B1=E5=8F=AF=E3=83=95=E3=83=A9=E3=82=B0
     */
    public Boolean getRestAllowed() {
        return restAllowed;
    }

    /**
     * REST=E3=81=A7=E3=81=AE=E3=82=A2=E3=82=AF=E3=82=BB=E3=82=B9=E8=A8=B1=
=E5=8F=AF=E3=83=95=E3=83=A9=E3=82=B0=E3=82=92=E8=A8=AD=E5=AE=9A=E3=81=99=E3=
=82=8B.
     *
     * @param restAllowed REST=E3=81=A7=E3=81=AE=E3=82=A2=E3=82=AF=E3=82=BB=
=E3=82=B9=E8=A8=B1=E5=8F=AF=E3=83=95=E3=83=A9=E3=82=B0
     */
    public void setRestAllowed(Boolean restAllowed) {
        this.restAllowed =3D restAllowed;
    }

    /**
     * RPC=E3=81=A7=E3=81=AE=E3=82=A2=E3=82=AF=E3=82=BB=E3=82=B9=E8=A8=B1=
=E5=8F=AF=E3=83=95=E3=83=A9=E3=82=B0=E3=82=92=E8=BF=94=E3=81=99.
     *
     * @return RPC=E3=81=A7=E3=81=AE=E3=82=A2=E3=82=AF=E3=82=BB=E3=82=B9=E8=
=A8=B1=E5=8F=AF=E3=83=95=E3=83=A9=E3=82=B0
     */
    public Boolean getRpcAllowed() {
        return rpcAllowed;
    }

    /**
     * RPC=E3=81=A7=E3=81=AE=E3=82=A2=E3=82=AF=E3=82=BB=E3=82=B9=E8=A8=B1=
=E5=8F=AF=E3=83=95=E3=83=A9=E3=82=B0=E3=82=92=E8=A8=AD=E5=AE=9A=E3=81=99=E3=
=82=8B.
     *
     * @param rpcAllowed RPC=E3=81=A7=E3=81=AE=E3=82=A2=E3=82=AF=E3=82=BB=
=E3=82=B9=E8=A8=B1=E5=8F=AF=E3=83=95=E3=83=A9=E3=82=B0
     */
    public void setRpcAllowed(Boolean rpcAllowed) {
        this.rpcAllowed =3D rpcAllowed;
    }

    public Boolean getIsController() {
        return isController;
    }

    public void setIsController(Boolean isController) {
        this.isController =3D isController;
    }
}
