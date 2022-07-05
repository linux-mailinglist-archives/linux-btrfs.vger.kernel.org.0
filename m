Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87B2456650A
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Jul 2022 10:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiGEIaq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Jul 2022 04:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiGEIap (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Jul 2022 04:30:45 -0400
X-Greylist: delayed 568 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Jul 2022 01:30:41 PDT
Received: from aldebaran.samara.com.es (25.red-83-55-111.dynamicip.rima-tde.net [83.55.111.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C179E97
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Jul 2022 01:30:41 -0700 (PDT)
Received: from [192.168.2.3] (andromeda.samara.com.es [192.168.2.3])
        by aldebaran.samara.com.es (Postfix) with ESMTP id C31FB9406F3
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Jul 2022 10:21:12 +0200 (CEST)
Message-ID: <71ee4e58-678d-a8d1-9376-45eaead69ad5@samara.com.es>
Date:   Tue, 5 Jul 2022 10:21:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: es-ES
To:     linux-btrfs@vger.kernel.org
From:   Fernando Peral <fernando@samara.com.es>
Subject: Help with btrfs error
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=3.4 required=5.0 tests=BAYES_00,HEXHASH_WORD,
        KHOP_HELO_FCRDNS,RCVD_IN_PBL,RCVD_IN_SORBS_DUL,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I have a Opensuse leap 15.3 installed in a ssd disk, on some system 
updates it crashed. I mouted the disk in other computer to test it and 
the fs has some errors. I have tried scrub and check and I don't know 
what to do next, this is the info


andromeda:~ # uname -a
Linux andromeda 5.3.18-150300.59.76-default #1 SMP Thu Jun 16 04:23:47 
UTC 2022 (2cc2ade) x86_64 x86_64 x86_64 GNU/Linux

andromeda:~ # btrfs --version
btrfs-progs v4.19.1

andromeda:~ # btrfs fi show
Label: none  uuid: 5b000355-3a1a-49f5-8005-f10668008aa7
         Total devices 1 FS bytes used 634.88GiB
         devid    1 size 931.51GiB used 639.05GiB path /dev/nvme0n1p1

Label: none  uuid: 2294e96a-9ccc-4e81-910b-002305654a08
         Total devices 1 FS bytes used 25.84GiB
         devid    1 size 215.80GiB used 29.05GiB path /dev/sdb2

andromeda:~ # mount /dev/sdb2 /mnt/ssd
andromeda:~ # btrfs fi df /mnt/ssd
Data, single: total=27.01GiB, used=25.26GiB
System, single: total=32.00MiB, used=16.00KiB
Metadata, single: total=2.01GiB, used=590.83MiB
GlobalReserve, single: total=72.78MiB, used=0.00B

andromeda:~ # mount /dev/sdb2 /mnt/ssd
andromeda:~ # btrfs scrub start /mnt/ssd
scrub started on /mnt/ssd, fsid 2294e96a-9ccc-4e81-910b-002305654a08 
(pid=10588)
andromeda:~ # btrfs scrub status /mnt/ssd
scrub status for 2294e96a-9ccc-4e81-910b-002305654a08
         scrub started at Tue Jul  5 10:17:08 2022 and was aborted after 
00:00:17
         total bytes scrubbed: 4.52GiB with 3 errors
         error details: verify=2 csum=1
         corrected errors: 0, uncorrectable errors: 3, unverified errors: 0
andromeda:~ #


andromeda:~ # umount /mnt/ssd

andromeda:~ # btrfs check /dev/sdb2
Opening filesystem to check...
Checking filesystem on /dev/sdb2
UUID: 2294e96a-9ccc-4e81-910b-002305654a08
[1/7] checking root items
[2/7] checking extents
ref mismatch on [1619607552 16384] extent item 95, found 1
ref mismatch on [1619623936 16384] extent item 24577, found 1
tree backref 1619623936 parent 267 root 267 not found in extent tree
backref 1619623936 root 351 not referenced back 0x56497bdbe350
incorrect global backref count on 1619623936 found 2 wanted 1
backpointer mismatch on [1619623936 16384]
tree backref 1619640320 parent 267 root 267 not found in extent tree
backref 1619640320 root 24843 not referenced back 0x56497bdbe450
incorrect global backref count on 1619640320 found 2 wanted 1
backpointer mismatch on [1619640320 16384]
ref mismatch on [17392717824 69632] extent item 816043786241, found 1
data backref 17392717824 root 267 owner 671118 offset 0 num_refs 0 not 
found in extent tree
incorrect local backref count on 17392717824 root 267 owner 671118 
offset 0 found 1 wanted 0 back 0x56497ebf0940
incorrect local backref count on 17392717824 root 16777483 owner 671118 
offset 3456106496 found 0 wanted 1 back 0x56497a25c840
backref disk bytenr does not match extent record, bytenr=17392717824, 
ref bytenr=0
backpointer mismatch on [17392717824 69632]
incorrect local backref count on 17392787456 root 263 owner 562554 
offset 0 found 1 wanted 0 back 0x56497a25c970
backpointer mismatch on [17392787456 12288]
data backref 17772953600 parent 1619623936 owner 0 offset 0 num_refs 0 
not found in extent tree
incorrect local backref count on 17772953600 parent 1619623936 owner 0 
offset 0 found 1 wanted 0 back 0x56497a2578b0
incorrect local backref count on 17772953600 root 267 owner 317811 
offset 0 found 0 wanted 1 back 0x56497a2dcf40
backref disk bytenr does not match extent record, bytenr=17772953600, 
ref bytenr=0
backpointer mismatch on [17772953600 24576]
data backref 17772978176 parent 1619623936 owner 0 offset 0 num_refs 0 
not found in extent tree
incorrect local backref count on 17772978176 parent 1619623936 owner 0 
offset 0 found 1 wanted 0 back 0x56497a8c8d50
incorrect local backref count on 17772978176 root 267 owner 317812 
offset 0 found 0 wanted 1 back 0x56497a2dd070
backref disk bytenr does not match extent record, bytenr=17772978176, 
ref bytenr=0
backpointer mismatch on [17772978176 4096]
data backref 17772982272 parent 1619623936 owner 0 offset 0 num_refs 0 
not found in extent tree
incorrect local backref count on 17772982272 parent 1619623936 owner 0 
offset 0 found 1 wanted 0 back 0x56497a8c9a60
incorrect local backref count on 17772982272 root 267 owner 317814 
offset 0 found 0 wanted 1 back 0x56497a2dd1a0
backref disk bytenr does not match extent record, bytenr=17772982272, 
ref bytenr=0
backpointer mismatch on [17772982272 24576]
data backref 17773006848 parent 1619623936 owner 0 offset 0 num_refs 0 
not found in extent tree
incorrect local backref count on 17773006848 parent 1619623936 owner 0 
offset 0 found 1 wanted 0 back 0x56497dd26a50
incorrect local backref count on 17773006848 root 267 owner 317816 
offset 0 found 0 wanted 1 back 0x56497a2dd2d0
backref disk bytenr does not match extent record, bytenr=17773006848, 
ref bytenr=0
backpointer mismatch on [17773006848 4096]
data backref 17773010944 parent 1619623936 owner 0 offset 0 num_refs 0 
not found in extent tree
incorrect local backref count on 17773010944 parent 1619623936 owner 0 
offset 0 found 1 wanted 0 back 0x56497a8c9210
incorrect local backref count on 17773010944 root 267 owner 317817 
offset 0 found 0 wanted 1 back 0x56497a2dd400
backref disk bytenr does not match extent record, bytenr=17773010944, 
ref bytenr=0
backpointer mismatch on [17773010944 8192]
data backref 17773019136 parent 1619623936 owner 0 offset 0 num_refs 0 
not found in extent tree
incorrect local backref count on 17773019136 parent 1619623936 owner 0 
offset 0 found 1 wanted 0 back 0x56497a8c9cc0
incorrect local backref count on 17773019136 root 267 owner 317818 
offset 0 found 0 wanted 1 back 0x56497a2dd530
backref disk bytenr does not match extent record, bytenr=17773019136, 
ref bytenr=0
backpointer mismatch on [17773019136 8192]
data backref 17773027328 parent 1619623936 owner 0 offset 0 num_refs 0 
not found in extent tree
incorrect local backref count on 17773027328 parent 1619623936 owner 0 
offset 0 found 1 wanted 0 back 0x56497a8c9930
incorrect local backref count on 17773027328 root 267 owner 317819 
offset 0 found 0 wanted 1 back 0x56497a2dd660
backref disk bytenr does not match extent record, bytenr=17773027328, 
ref bytenr=0
backpointer mismatch on [17773027328 12288]
data backref 17773039616 parent 1619623936 owner 0 offset 0 num_refs 0 
not found in extent tree
incorrect local backref count on 17773039616 parent 1619623936 owner 0 
offset 0 found 1 wanted 0 back 0x56497f68e560
incorrect local backref count on 17773039616 root 267 owner 317820 
offset 0 found 0 wanted 1 back 0x56497a2dd790
backref disk bytenr does not match extent record, bytenr=17773039616, 
ref bytenr=0
backpointer mismatch on [17773039616 8192]
data backref 17773047808 parent 1619623936 owner 0 offset 0 num_refs 0 
not found in extent tree
incorrect local backref count on 17773047808 parent 1619623936 owner 0 
offset 0 found 1 wanted 0 back 0x56497ec6fbd0
incorrect local backref count on 17773047808 root 267 owner 317821 
offset 0 found 0 wanted 1 back 0x56497a2dd8c0
backref disk bytenr does not match extent record, bytenr=17773047808, 
ref bytenr=0
backpointer mismatch on [17773047808 4096]
data backref 17773051904 parent 1619623936 owner 0 offset 0 num_refs 0 
not found in extent tree
incorrect local backref count on 17773051904 parent 1619623936 owner 0 
offset 0 found 1 wanted 0 back 0x56497fe8e2d0
incorrect local backref count on 17773051904 root 267 owner 317822 
offset 0 found 0 wanted 1 back 0x56497a2dd9f0
backref disk bytenr does not match extent record, bytenr=17773051904, 
ref bytenr=0
backpointer mismatch on [17773051904 8192]
data backref 17773060096 parent 1619623936 owner 0 offset 0 num_refs 0 
not found in extent tree
incorrect local backref count on 17773060096 parent 1619623936 owner 0 
offset 0 found 1 wanted 0 back 0x5649781bd0d0
incorrect local backref count on 17773060096 root 267 owner 317823 
offset 0 found 0 wanted 1 back 0x56497a2ddb20
backref disk bytenr does not match extent record, bytenr=17773060096, 
ref bytenr=0
backpointer mismatch on [17773060096 8192]
data backref 17773068288 parent 1619623936 owner 0 offset 0 num_refs 0 
not found in extent tree
incorrect local backref count on 17773068288 parent 1619623936 owner 0 
offset 0 found 1 wanted 0 back 0x5649781bc430
incorrect local backref count on 17773068288 root 267 owner 317824 
offset 0 found 0 wanted 1 back 0x56497a2ddc50
backref disk bytenr does not match extent record, bytenr=17773068288, 
ref bytenr=0
backpointer mismatch on [17773068288 4096]
data backref 17773072384 parent 1619623936 owner 0 offset 0 num_refs 0 
not found in extent tree
incorrect local backref count on 17773072384 parent 1619623936 owner 0 
offset 0 found 1 wanted 0 back 0x56497f67a710
incorrect local backref count on 17773072384 root 267 owner 317825 
offset 0 found 0 wanted 1 back 0x56497a2ddd80
backref disk bytenr does not match extent record, bytenr=17773072384, 
ref bytenr=0
backpointer mismatch on [17773072384 4096]
data backref 17773076480 parent 1619623936 owner 0 offset 0 num_refs 0 
not found in extent tree
incorrect local backref count on 17773076480 parent 1619623936 owner 0 
offset 0 found 1 wanted 0 back 0x5649781be490
incorrect local backref count on 17773076480 root 267 owner 317827 
offset 0 found 0 wanted 1 back 0x56497a2ddeb0
backref disk bytenr does not match extent record, bytenr=17773076480, 
ref bytenr=0
backpointer mismatch on [17773076480 8192]
data backref 17773084672 parent 1619623936 owner 0 offset 0 num_refs 0 
not found in extent tree
incorrect local backref count on 17773084672 parent 1619623936 owner 0 
offset 0 found 1 wanted 0 back 0x5649781c1eb0
incorrect local backref count on 17773084672 root 267 owner 317828 
offset 0 found 0 wanted 1 back 0x56497a2ddfe0
backref disk bytenr does not match extent record, bytenr=17773084672, 
ref bytenr=0
backpointer mismatch on [17773084672 12288]
data backref 17773096960 parent 1619623936 owner 0 offset 0 num_refs 0 
not found in extent tree
incorrect local backref count on 17773096960 parent 1619623936 owner 0 
offset 0 found 1 wanted 0 back 0x5649781baf30
incorrect local backref count on 17773096960 root 267 owner 317829 
offset 0 found 0 wanted 1 back 0x56497a2de110
backref disk bytenr does not match extent record, bytenr=17773096960, 
ref bytenr=0
backpointer mismatch on [17773096960 4096]
ERROR: errors found in extent allocation tree or chunk allocation
[3/7] checking free space cache
[4/7] checking fs roots
warning line 3495
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups skipped (not enabled on this FS)
found 27741847552 bytes used, error(s) found
total csum bytes: 22551584
total tree bytes: 619544576
total fs tree bytes: 543129600
total extent tree bytes: 44253184
btree space waste bytes: 114922539
file data blocks allocated: 34178977792
  referenced 26964791296





  and from dmes I have extrated this info I thibk is related to the error



  andromeda:~ # dmesg
    25.462249] FS-Cache: Duplicate cookie detected
[   25.462252] FS-Cache: O-cookie c=000000006e887df3 [p=000000009b0e82e2 
fl=222 nc=0 na=1]
[   25.462253] FS-Cache: O-cookie d=00000000c5fcf0f1 n=00000000d1874371
[   25.462254] FS-Cache: O-key=[16] '040000000200000002000801c0a80205'
[   25.462257] FS-Cache: N-cookie c=00000000767b8725 [p=000000009b0e82e2 
fl=2 nc=0 na=1]
[   25.462258] FS-Cache: N-cookie d=00000000c5fcf0f1 n=000000004607c04a
[   25.462258] FS-Cache: N-key=[16] '040000000200000002000801c0a80205'
[   25.465479] FS-Cache: Duplicate cookie detected
[   25.465482] FS-Cache: O-cookie c=000000006e887df3 [p=000000009b0e82e2 
fl=222 nc=0 na=1]
[   25.465483] FS-Cache: O-cookie d=00000000c5fcf0f1 n=00000000d1874371
[   25.465483] FS-Cache: O-key=[16] '040000000200000002000801c0a80205'
[   25.465487] FS-Cache: N-cookie c=000000004babe7dc [p=000000009b0e82e2 
fl=2 nc=0 na=1]
[   25.465488] FS-Cache: N-cookie d=00000000c5fcf0f1 n=000000000f8f2c42
[   25.465489] FS-Cache: N-key=[16] '040000000200000002000801c0a80205'
[   25.469760] FS-Cache: Duplicate cookie detected
[   25.469763] FS-Cache: O-cookie c=000000006e887df3 [p=000000009b0e82e2 
fl=222 nc=0 na=1]
[   25.469764] FS-Cache: O-cookie d=00000000c5fcf0f1 n=00000000d1874371
[   25.469765] FS-Cache: O-key=[16] '040000000200000002000801c0a80205'
[   25.469768] FS-Cache: N-cookie c=00000000cbd8f6ee [p=000000009b0e82e2 
fl=2 nc=0 na=1]
[   25.469769] FS-Cache: N-cookie d=00000000c5fcf0f1 n=00000000f6cb9c5d
[   25.469770] FS-Cache: N-key=[16] '040000000200000002000801c0a80205'
[   25.473544] FS-Cache: Duplicate cookie detected
[   25.473547] FS-Cache: O-cookie c=000000006e887df3 [p=000000009b0e82e2 
fl=222 nc=0 na=1]
[   25.473547] FS-Cache: O-cookie d=00000000c5fcf0f1 n=00000000d1874371
[   25.473548] FS-Cache: O-key=[16] '040000000200000002000801c0a80205'
[   25.473551] FS-Cache: N-cookie c=000000004babe7dc [p=000000009b0e82e2 
fl=2 nc=0 na=1]
[   25.473552] FS-Cache: N-cookie d=00000000c5fcf0f1 n=00000000d80c8158
[   25.473553] FS-Cache: N-key=[16] '040000000200000002000801c0a80205'
[   25.482359] FS-Cache: Duplicate cookie detected
[   25.482362] FS-Cache: O-cookie c=000000006e887df3 [p=000000009b0e82e2 
fl=222 nc=0 na=1]
[   25.482363] FS-Cache: O-cookie d=00000000c5fcf0f1 n=00000000d1874371
[   25.482364] FS-Cache: O-key=[16] '040000000200000002000801c0a80205'
[   25.482368] FS-Cache: N-cookie c=000000004babe7dc [p=000000009b0e82e2 
fl=2 nc=0 na=1]
[   25.482368] FS-Cache: N-cookie d=00000000c5fcf0f1 n=000000007f8ac7e9
[   25.482369] FS-Cache: N-key=[16] '040000000200000002000801c0a80205'
[   26.549799] userif-3: sent link down event.
[   26.549803] userif-3: sent link up event.
[   26.973019] resource sanity check: requesting [mem 
0x000c0000-0x000fffff], which spans more than PCI Bus 0000:00 [mem 
0x000d0000-0x000dffff window]
[   26.973745] caller _nv001015rm+0x1bf/0x1f0 [nvidia] mapping multiple BARs
[  740.484134] BTRFS info (device nvme0n1p1): qgroup scan completed 
(inconsistency flag cleared)
[ 1425.490641] usb 6-2.2: new SuperSpeed Gen 1 USB device number 5 using 
xhci_hcd
[ 1425.517211] usb 6-2.2: New USB device found, idVendor=174c, 
idProduct=55aa, bcdDevice= 1.00
[ 1425.517217] usb 6-2.2: New USB device strings: Mfr=2, Product=3, 
SerialNumber=1
[ 1425.517220] usb 6-2.2: Product: ASM1156-PM
[ 1425.517222] usb 6-2.2: Manufacturer: ASMT
[ 1425.517224] usb 6-2.2: SerialNumber: 00000000000000000000
[ 1425.532744] scsi host11: uas
[ 1425.534144] scsi 11:0:0:0: Direct-Access     ASMT ASM1156-PM       
0    PQ: 0 ANSI: 6
[ 1425.535172] sd 11:0:0:0: Attached scsi generic sg2 type 0
[ 1425.536095] sd 11:0:0:0: [sdb] 468862128 512-byte logical blocks: 
(240 GB/224 GiB)
[ 1425.536231] sd 11:0:0:0: [sdb] Write Protect is off
[ 1425.536233] sd 11:0:0:0: [sdb] Mode Sense: 43 00 00 00
[ 1425.536481] sd 11:0:0:0: [sdb] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[ 1425.536909] sd 11:0:0:0: [sdb] Optimal transfer size 33553920 bytes
[ 1425.560157]  sdb: sdb1 sdb2 sdb3
[ 1425.562647] sd 11:0:0:0: [sdb] Attached SCSI disk
[ 1425.880052] BTRFS: device fsid 2294e96a-9ccc-4e81-910b-002305654a08 
devid 1 transid 63215 /dev/sdb2
[ 1646.542763] BTRFS info (device sdb2): disk space caching is enabled
[ 1646.542766] BTRFS info (device sdb2): has skinny extents
[ 1646.546409] BTRFS info (device sdb2): bdev /dev/sdb2 errs: wr 0, rd 
0, flush 0, corrupt 68, gen 8
[ 1678.755497] ------------[ cut here ]------------
[ 1678.755638] WARNING: CPU: 2 PID: 8255 at 
../fs/btrfs/extent-tree.c:3105 __btrfs_free_extent.isra.47+0x20b/0xe60 
[btrfs]
[ 1678.755638] Modules linked in: rpcsec_gss_krb5 auth_rpcgss vmnet(OEX) 
ppdev parport_pc parport vmw_vsock_vmci_transport vsock vmw_vmci nfsv4 
vmmon(OEX) dns_resolver nfs lockd grace sunrpc fscache af_packet 
nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet 
nft_reject nft_ct nft_chain_nat nf_tables ebtable_nat ebtable_broute 
ip6table_nat ip6table_mangle ip6table_raw ip6table_security iptable_nat 
nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle 
iptable_raw iptable_security ip_set nfnetlink iscsi_ibft 
iscsi_boot_sysfs ebtable_filter ebtables ip6table_filter ip6_tables 
rfkill iptable_filter ip_tables x_tables bpfilter vboxnetadp(OEN) 
vboxnetflt(OEN) vboxdrv(OEN) dmi_sysfs hwmon_vid ext4 crc16 mbcache jbd2 
squashfs loop nvidia_drm(POEX) nvidia_modeset(POEX) nvidia_uvm(POEX) 
snd_hda_codec_realtek snd_hda_codec_generic snd_hda_codec_hdmi 
ledtrig_audio snd_hda_intel snd_intel_dspcfg soundwire_intel 
soundwire_generic_allocation nvidia(POEX) soundwire_cadence
[ 1678.755666]  soundwire_bus snd_hda_codec drm_kms_helper edac_mce_amd 
snd_hda_core cec snd_hwdep kvm_amd snd_soc_core rc_core ccp snd_compress 
ipmi_devintf kvm snd_pcm_dmaengine irqbypass snd_pcm wmi_bmof pcspkr 
ipmi_msghandler k10temp snd_timer sp5100_tco(N) syscopyarea r8169 
sysfillrect snd sysimgblt i2c_piix4 realtek fb_sys_fops libphy soundcore 
asus_atk0110(N) acpi_cpufreq drm fuse configfs sd_mod uas usb_storage 
hid_generic usbhid btrfs libcrc32c xor raid6_pq sr_mod cdrom xhci_pci 
ohci_pci ata_generic xhci_hcd pata_jmicron ehci_pci ahci ohci_hcd 
libahci pata_atiixp ehci_hcd serio_raw nvme firewire_ohci usbcore libata 
nvme_core firewire_core t10_pi wmi crc_itu_t button sg dm_multipath 
dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua scsi_mod msr
[ 1678.755689] Supported: No, Proprietary and Unsupported modules are loaded
[ 1678.755692] CPU: 2 PID: 8255 Comm: btrfs-transacti Tainted: 
P           OE  X  N 5.3.18-150300.59.76-default #1 SLE15-SP3
[ 1678.755693] Hardware name: System manufacturer System Product 
Name/M4A89TD PRO USB3, BIOS 3029    09/07/2012
[ 1678.755709] RIP: 0010:__btrfs_free_extent.isra.47+0x20b/0xe60 [btrfs]
[ 1678.755711] Code: 89 e6 e8 68 cc ff ff 41 89 c5 58 45 85 ed 0f 84 91 
00 00 00 41 83 fd fe 0f 85 11 ff ff ff 48 c7 c7 50 9d 64 c0 e8 f3 81 78 
e1 <0f> 0b 49 8b 3c 24 e8 4a 6c 00 00 ff b4 24 b8 00 00 00 48 8b 7c 24
[ 1678.755712] RSP: 0018:ffffae71066d7c58 EFLAGS: 00010282
[ 1678.755713] RAX: 0000000000000024 RBX: 00000000000a3d8e RCX: 
0000000000000000
[ 1678.755714] RDX: 0000000000000000 RSI: ffff88d963a99558 RDI: 
ffff88d963a99558
[ 1678.755715] RBP: 000000040cafd000 R08: 00000000000004be R09: 
0000000000000001
[ 1678.755715] R10: 0000000000000000 R11: 0000000000000001 R12: 
ffff88d6c1139bd0
[ 1678.755716] R13: 00000000fffffffe R14: 0000000000000000 R15: 
000000000000010b
[ 1678.755717] FS:  0000000000000000(0000) GS:ffff88d963a80000(0000) 
knlGS:0000000000000000
[ 1678.755718] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1678.755719] CR2: 0000369f2edc7000 CR3: 0000000270330000 CR4: 
00000000000006e0
[ 1678.755719] Call Trace:
[ 1678.755740]  __btrfs_run_delayed_refs+0x54c/0x1180 [btrfs]
[ 1678.755757]  btrfs_run_delayed_refs+0x62/0x1f0 [btrfs]
[ 1678.755774]  btrfs_commit_transaction+0x50/0xa60 [btrfs]
[ 1678.755791]  ? start_transaction+0xc5/0x540 [btrfs]
[ 1678.755811]  transaction_kthread+0x148/0x160 [btrfs]
[ 1678.755826]  ? btrfs_cleanup_transaction+0x5c0/0x5c0 [btrfs]
[ 1678.755829]  kthread+0x10d/0x130
[ 1678.755830]  ? kthread_park+0xa0/0xa0
[ 1678.755832]  ret_from_fork+0x35/0x40
[ 1678.755834] ---[ end trace da68b410b6e3cde9 ]---
[ 1678.755837] BTRFS info (device sdb2): leaf 1251753984 gen 63216 total 
ptrs 133 free space 5909 owner 2
[ 1678.755838]  item 0 key (17378979840 168 28672) itemoff 16230 itemsize 53
[ 1678.755839]          extent refs 1 gen 44106 flags 1
[ 1678.755840]          ref#0: extent data backref root 267 objectid 
836076 offset 0 count 1
[ 1678.755842]  item 1 key (17379008512 168 16384) itemoff 16177 itemsize 53
[ 1678.755842]          extent refs 1 gen 44106 flags 1
[ 1678.755842]          ref#0: extent data backref root 267 objectid 
836077 offset 0 count 1
[ 1678.755844]  item 2 key (17379024896 168 8192) itemoff 16124 itemsize 53
[ 1678.755844]          extent refs 1 gen 44106 flags 1
[ 1678.755845]          ref#0: extent data backref root 267 objectid 
836078 offset 0 count 1
[ 1678.755846]  item 3 key (17379033088 168 4096) itemoff 16071 itemsize 53
[ 1678.755847]          extent refs 1 gen 44106 flags 1
[ 1678.755847]          ref#0: extent data backref root 267 objectid 
836079 offset 0 count 1
[ 1678.755848]  item 4 key (17379037184 168 36864) itemoff 16018 itemsize 53
[ 1678.755849]          extent refs 1 gen 44106 flags 1
[ 1678.755849]          ref#0: extent data backref root 267 objectid 
836080 offset 0 count 1
[ 1678.755850]  item 5 key (17379074048 168 4096) itemoff 15965 itemsize 53
[ 1678.755851]          extent refs 1 gen 44106 flags 1
[ 1678.755851]          ref#0: extent data backref root 267 objectid 
836081 offset 0 count 1
[ 1678.755853]  item 6 key (17379078144 168 28672) itemoff 15912 itemsize 53
[ 1678.755853]          extent refs 1 gen 44106 flags 1
[ 1678.755853]          ref#0: extent data backref root 267 objectid 
836082 offset 0 count 1
[ 1678.755855]  item 7 key (17379106816 168 4096) itemoff 15859 itemsize 53
[ 1678.755855]          extent refs 1 gen 44106 flags 1
[ 1678.755856]          ref#0: extent data backref root 267 objectid 
836083 offset 0 count 1
[ 1678.755857]  item 8 key (17379110912 168 20480) itemoff 15806 itemsize 53
[ 1678.755857]          extent refs 1 gen 44106 flags 1
[ 1678.755858]          ref#0: extent data backref root 267 objectid 
836084 offset 0 count 1
[ 1678.755859]  item 9 key (17379131392 168 12288) itemoff 15753 itemsize 53
[ 1678.755860]          extent refs 1 gen 44106 flags 1
[ 1678.755860]          ref#0: extent data backref root 267 objectid 
836085 offset 0 count 1
[ 1678.755861]  item 10 key (17379143680 168 4096) itemoff 15700 itemsize 53
[ 1678.755862]          extent refs 1 gen 44106 flags 1
[ 1678.755862]          ref#0: extent data backref root 267 objectid 
836086 offset 0 count 1
[ 1678.755863]  item 11 key (17379147776 168 4096) itemoff 15647 itemsize 53
[ 1678.755864]          extent refs 1 gen 44106 flags 1
[ 1678.755864]          ref#0: extent data backref root 267 objectid 
836087 offset 0 count 1
[ 1678.755865]  item 12 key (17379151872 168 16384) itemoff 15594 
itemsize 53
[ 1678.755866]          extent refs 1 gen 44106 flags 1
[ 1678.755866]          ref#0: extent data backref root 267 objectid 
836088 offset 0 count 1
[ 1678.755868]  item 13 key (17379168256 168 16384) itemoff 15541 
itemsize 53
[ 1678.755868]          extent refs 1 gen 44106 flags 1
[ 1678.755868]          ref#0: extent data backref root 267 objectid 
836089 offset 0 count 1
[ 1678.755870]  item 14 key (17379184640 168 90112) itemoff 15488 
itemsize 53
[ 1678.755870]          extent refs 1 gen 44106 flags 1
[ 1678.755871]          ref#0: extent data backref root 267 objectid 
836090 offset 0 count 1
[ 1678.755872]  item 15 key (17379274752 168 16384) itemoff 15435 
itemsize 53
[ 1678.755872]          extent refs 1 gen 44106 flags 1
[ 1678.755873]          ref#0: extent data backref root 267 objectid 
836091 offset 0 count 1
[ 1678.755874]  item 16 key (17379291136 168 4096) itemoff 15382 itemsize 53
[ 1678.755875]          extent refs 1 gen 44106 flags 1
[ 1678.755875]          ref#0: extent data backref root 267 objectid 
836092 offset 0 count 1
[ 1678.755876]  item 17 key (17379295232 168 8192) itemoff 15329 itemsize 53
[ 1678.755877]          extent refs 1 gen 44106 flags 1
[ 1678.755877]          ref#0: extent data backref root 267 objectid 
836093 offset 0 count 1
[ 1678.755878]  item 18 key (17379303424 168 16384) itemoff 15276 
itemsize 53
[ 1678.755879]          extent refs 1 gen 44106 flags 1
[ 1678.755879]          ref#0: extent data backref root 267 objectid 
836094 offset 0 count 1
[ 1678.755880]  item 19 key (17379319808 168 24576) itemoff 15223 
itemsize 53
[ 1678.755881]          extent refs 1 gen 44106 flags 1
[ 1678.755881]          ref#0: extent data backref root 267 objectid 
836095 offset 0 count 1
[ 1678.755883]  item 20 key (17379344384 168 4096) itemoff 15170 itemsize 53
[ 1678.755883]          extent refs 1 gen 44106 flags 1
[ 1678.755883]          ref#0: extent data backref root 267 objectid 
836096 offset 0 count 1
[ 1678.755885]  item 21 key (17379348480 168 4096) itemoff 15117 itemsize 53
[ 1678.755885]          extent refs 1 gen 44106 flags 1
[ 1678.755885]          ref#0: extent data backref root 267 objectid 
836097 offset 0 count 1
[ 1678.755887]  item 22 key (17379352576 168 4096) itemoff 15064 itemsize 53
[ 1678.755887]          extent refs 1 gen 44106 flags 1
[ 1678.755888]          ref#0: extent data backref root 267 objectid 
836098 offset 0 count 1
[ 1678.755889]  item 23 key (17379356672 168 4096) itemoff 15011 itemsize 53
[ 1678.755889]          extent refs 1 gen 44106 flags 1
[ 1678.755890]          ref#0: extent data backref root 267 objectid 
836100 offset 0 count 1
[ 1678.755891]  item 24 key (17379360768 168 4096) itemoff 14958 itemsize 53
[ 1678.755892]          extent refs 1 gen 44106 flags 1
[ 1678.755892]          ref#0: extent data backref root 267 objectid 
836102 offset 0 count 1
[ 1678.755893]  item 25 key (17379364864 168 8192) itemoff 14905 itemsize 53
[ 1678.755894]          extent refs 1 gen 44106 flags 1
[ 1678.755894]          ref#0: extent data backref root 267 objectid 
836105 offset 0 count 1
[ 1678.755895]  item 26 key (17379483648 168 172032) itemoff 14852 
itemsize 53
[ 1678.755896]          extent refs 1 gen 37108 flags 1
[ 1678.755896]          ref#0: extent data backref root 267 objectid 
667708 offset 0 count 1
[ 1678.755898]  item 27 key (17379713024 168 4096) itemoff 14799 itemsize 53
[ 1678.755898]          extent refs 1 gen 37434 flags 1
[ 1678.755898]          ref#0: extent data backref root 267 objectid 
757604 offset 0 count 1
[ 1678.755900]  item 28 key (17379717120 168 36864) itemoff 14746 
itemsize 53
[ 1678.755900]          extent refs 1 gen 44106 flags 1
[ 1678.755901]          ref#0: extent data backref root 267 objectid 
836104 offset 0 count 1
[ 1678.755902]  item 29 key (17379753984 168 28672) itemoff 14693 
itemsize 53
[ 1678.755902]          extent refs 1 gen 44106 flags 1
[ 1678.755903]          ref#0: extent data backref root 267 objectid 
836106 offset 0 count 1
[ 1678.755904]  item 30 key (17379782656 168 4096) itemoff 14640 itemsize 53
[ 1678.755904]          extent refs 1 gen 44106 flags 1
[ 1678.755905]          ref#0: extent data backref root 267 objectid 
836107 offset 0 count 1
[ 1678.755906]  item 31 key (17379786752 168 4096) itemoff 14587 itemsize 53
[ 1678.755907]          extent refs 1 gen 44106 flags 1
[ 1678.755907]          ref#0: extent data backref root 267 objectid 
836109 offset 0 count 1
[ 1678.755908]  item 32 key (17379790848 168 4096) itemoff 14534 itemsize 53
[ 1678.755909]          extent refs 1 gen 44106 flags 1
[ 1678.755909]          ref#0: extent data backref root 267 objectid 
836111 offset 0 count 1
[ 1678.755910]  item 33 key (17379794944 168 69632) itemoff 14481 
itemsize 53
[ 1678.755911]          extent refs 1 gen 34879 flags 1
[ 1678.755911]          ref#0: extent data backref root 263 objectid 
604285 offset 0 count 1
[ 1678.755912]  item 34 key (17379864576 168 4096) itemoff 14428 itemsize 53
[ 1678.755913]          extent refs 1 gen 37434 flags 1
[ 1678.755913]          ref#0: extent data backref root 267 objectid 
757614 offset 0 count 1
[ 1678.755915]  item 35 key (17379868672 168 409600) itemoff 14375 
itemsize 53
[ 1678.755915]          extent refs 1 gen 56897 flags 1
[ 1678.755915]          ref#0: extent data backref root 263 objectid 
1930767 offset 0 count 1
[ 1678.755917]  item 36 key (17380278272 168 176128) itemoff 14322 
itemsize 53
[ 1678.755917]          extent refs 1 gen 55004 flags 1
[ 1678.755918]          ref#0: extent data backref root 263 objectid 
1784622 offset 0 count 1
[ 1678.755919]  item 37 key (17380462592 168 1298432) itemoff 14269 
itemsize 53
[ 1678.755920]          extent refs 1 gen 54162 flags 1
[ 1678.755920]          ref#0: extent data backref root 263 objectid 
1701216 offset 0 count 1
[ 1678.755921]  item 38 key (17381761024 168 176128) itemoff 14216 
itemsize 53
[ 1678.755922]          extent refs 1 gen 55004 flags 1
[ 1678.755922]          ref#0: extent data backref root 263 objectid 
1784628 offset 0 count 1
[ 1678.755923]  item 39 key (17381937152 168 8192) itemoff 14163 itemsize 53
[ 1678.755924]          extent refs 1 gen 53797 flags 1
[ 1678.755924]          ref#0: extent data backref root 263 objectid 
1650155 offset 0 count 1
[ 1678.755925]  item 40 key (17382264832 168 8192) itemoff 14110 itemsize 53
[ 1678.755926]          extent refs 1 gen 53797 flags 1
[ 1678.755926]          ref#0: extent data backref root 263 objectid 
1340329 offset 0 count 1
[ 1678.755928]  item 41 key (17382273024 168 389120) itemoff 14057 
itemsize 53
[ 1678.755928]          extent refs 1 gen 56941 flags 1
[ 1678.755928]          ref#0: extent data backref root 263 objectid 
1934062 offset 0 count 1
[ 1678.755930]  item 42 key (17382719488 168 778240) itemoff 14004 
itemsize 53
[ 1678.755930]          extent refs 1 gen 33683 flags 1
[ 1678.755930]          ref#0: extent data backref root 263 objectid 
571711 offset 0 count 1
[ 1678.755932]  item 43 key (17383497728 168 237568) itemoff 13951 
itemsize 53
[ 1678.755932]          extent refs 1 gen 49129 flags 1
[ 1678.755933]          ref#0: extent data backref root 263 objectid 
1181977 offset 0 count 1
[ 1678.755934]  item 44 key (17383735296 168 425984) itemoff 13898 
itemsize 53
[ 1678.755935]          extent refs 1 gen 50601 flags 1
[ 1678.755935]          ref#0: extent data backref root 267 objectid 
882244 offset 0 count 1
[ 1678.755936]  item 45 key (17384161280 168 368640) itemoff 13845 
itemsize 53
[ 1678.755937]          extent refs 1 gen 56897 flags 1
[ 1678.755937]          ref#0: extent data backref root 263 objectid 
1930937 offset 0 count 1
[ 1678.755938]  item 46 key (17384615936 168 12288) itemoff 13792 
itemsize 53
[ 1678.755939]          extent refs 1 gen 57780 flags 1
[ 1678.755939]          ref#0: extent data backref root 257 objectid 
234160 offset 3739648 count 1
[ 1678.755940]  item 47 key (17384730624 168 24576) itemoff 13739 
itemsize 53
[ 1678.755941]          extent refs 1 gen 44106 flags 1
[ 1678.755941]          ref#0: extent data backref root 267 objectid 
836108 offset 0 count 1
[ 1678.755943]  item 48 key (17384755200 168 73728) itemoff 13686 
itemsize 53
[ 1678.755943]          extent refs 1 gen 44106 flags 1
[ 1678.755943]          ref#0: extent data backref root 267 objectid 
836110 offset 0 count 1
[ 1678.755945]  item 49 key (17384828928 168 1433600) itemoff 13633 
itemsize 53
[ 1678.755945]          extent refs 1 gen 34172 flags 1
[ 1678.755946]          ref#0: extent data backref root 263 objectid 
582416 offset 0 count 1
[ 1678.755947]  item 50 key (17386262528 168 921600) itemoff 13580 
itemsize 53
[ 1678.755947]          extent refs 1 gen 34863 flags 1
[ 1678.755948]          ref#0: extent data backref root 263 objectid 
599294 offset 0 count 1
[ 1678.755949]  item 51 key (17387184128 168 225280) itemoff 13527 
itemsize 53
[ 1678.755950]          extent refs 1 gen 34863 flags 1
[ 1678.755950]          ref#0: extent data backref root 263 objectid 
600312 offset 0 count 1
[ 1678.755951]  item 52 key (17387433984 168 4096) itemoff 13474 itemsize 53
[ 1678.755952]          extent refs 1 gen 37434 flags 1
[ 1678.755952]          ref#0: extent data backref root 267 objectid 
757606 offset 0 count 1
[ 1678.755953]  item 53 key (17387438080 168 1421312) itemoff 13421 
itemsize 53
[ 1678.755954]          extent refs 1 gen 53357 flags 1
[ 1678.755954]          ref#0: extent data backref root 263 objectid 
1572874 offset 0 count 1
[ 1678.755955]  item 54 key (17388859392 168 401408) itemoff 13368 
itemsize 53
[ 1678.755956]          extent refs 1 gen 56898 flags 1
[ 1678.755956]          ref#0: extent data backref root 263 objectid 
1931128 offset 0 count 1
[ 1678.755958]  item 55 key (17389281280 168 8192) itemoff 13315 itemsize 53
[ 1678.755958]          extent refs 1 gen 44106 flags 1
[ 1678.755958]          ref#0: extent data backref root 267 objectid 
836112 offset 0 count 1
[ 1678.755960]  item 56 key (17389289472 168 65536) itemoff 13262 
itemsize 53
[ 1678.755960]          extent refs 1 gen 44106 flags 1
[ 1678.755961]          ref#0: extent data backref root 267 objectid 
836114 offset 0 count 1
[ 1678.755962]  item 57 key (17389355008 168 12288) itemoff 13209 
itemsize 53
[ 1678.755962]          extent refs 1 gen 44106 flags 1
[ 1678.755963]          ref#0: extent data backref root 267 objectid 
836117 offset 0 count 1
[ 1678.755964]  item 58 key (17389367296 168 40960) itemoff 13156 
itemsize 53
[ 1678.755964]          extent refs 1 gen 44106 flags 1
[ 1678.755965]          ref#0: extent data backref root 267 objectid 
836119 offset 0 count 1
[ 1678.755966]  item 59 key (17389408256 168 24576) itemoff 13103 
itemsize 53
[ 1678.755967]          extent refs 1 gen 44106 flags 1
[ 1678.755967]          ref#0: extent data backref root 267 objectid 
836121 offset 0 count 1
[ 1678.755968]  item 60 key (17389432832 168 28672) itemoff 13050 
itemsize 53
[ 1678.755969]          extent refs 1 gen 44106 flags 1
[ 1678.755969]          ref#0: extent data backref root 267 objectid 
836122 offset 0 count 1
[ 1678.755970]  item 61 key (17389461504 168 28672) itemoff 12997 
itemsize 53
[ 1678.755971]          extent refs 1 gen 44106 flags 1
[ 1678.755971]          ref#0: extent data backref root 267 objectid 
836123 offset 0 count 1
[ 1678.755973]  item 62 key (17389490176 168 32768) itemoff 12944 
itemsize 53
[ 1678.755973]          extent refs 1 gen 44106 flags 1
[ 1678.755973]          ref#0: extent data backref root 267 objectid 
836124 offset 0 count 1
[ 1678.755975]  item 63 key (17389522944 168 28672) itemoff 12891 
itemsize 53
[ 1678.755975]          extent refs 1 gen 44106 flags 1
[ 1678.755976]          ref#0: extent data backref root 267 objectid 
836125 offset 0 count 1
[ 1678.755977]  item 64 key (17389551616 168 28672) itemoff 12838 
itemsize 53
[ 1678.755977]          extent refs 1 gen 44106 flags 1
[ 1678.755978]          ref#0: extent data backref root 267 objectid 
836126 offset 0 count 1
[ 1678.755979]  item 65 key (17389580288 168 12288) itemoff 12785 
itemsize 53
[ 1678.755980]          extent refs 1 gen 44106 flags 1
[ 1678.755980]          ref#0: extent data backref root 267 objectid 
836127 offset 0 count 1
[ 1678.755981]  item 66 key (17389592576 168 118784) itemoff 12732 
itemsize 53
[ 1678.755982]          extent refs 1 gen 44106 flags 1
[ 1678.755982]          ref#0: extent data backref root 267 objectid 
836129 offset 0 count 1
[ 1678.755983]  item 67 key (17389711360 168 118784) itemoff 12679 
itemsize 53
[ 1678.755984]          extent refs 1 gen 44106 flags 1
[ 1678.755984]          ref#0: extent data backref root 267 objectid 
836131 offset 0 count 1
[ 1678.755985]  item 68 key (17389830144 168 110592) itemoff 12626 
itemsize 53
[ 1678.755986]          extent refs 1 gen 44106 flags 1
[ 1678.755986]          ref#0: extent data backref root 267 objectid 
836133 offset 0 count 1
[ 1678.755987]  item 69 key (17389940736 168 110592) itemoff 12573 
itemsize 53
[ 1678.755988]          extent refs 1 gen 44106 flags 1
[ 1678.755988]          ref#0: extent data backref root 267 objectid 
836135 offset 0 count 1
[ 1678.755990]  item 70 key (17390051328 168 20480) itemoff 12520 
itemsize 53
[ 1678.755990]          extent refs 1 gen 44106 flags 1
[ 1678.755990]          ref#0: extent data backref root 267 objectid 
836137 offset 0 count 1
[ 1678.755992]  item 71 key (17390071808 168 8192) itemoff 12467 itemsize 53
[ 1678.755992]          extent refs 1 gen 44106 flags 1
[ 1678.755993]          ref#0: extent data backref root 267 objectid 
836139 offset 0 count 1
[ 1678.755994]  item 72 key (17390080000 168 20480) itemoff 12414 
itemsize 53
[ 1678.755994]          extent refs 1 gen 44106 flags 1
[ 1678.755995]          ref#0: extent data backref root 267 objectid 
836141 offset 0 count 1
[ 1678.755996]  item 73 key (17390100480 168 118784) itemoff 12361 
itemsize 53
[ 1678.755997]          extent refs 1 gen 44106 flags 1
[ 1678.755997]          ref#0: extent data backref root 267 objectid 
836146 offset 0 count 1
[ 1678.755998]  item 74 key (17390219264 168 16384) itemoff 12308 
itemsize 53
[ 1678.755999]          extent refs 1 gen 44106 flags 1
[ 1678.755999]          ref#0: extent data backref root 267 objectid 
836156 offset 0 count 1
[ 1678.756000]  item 75 key (17390268416 168 208896) itemoff 12255 
itemsize 53
[ 1678.756001]          extent refs 1 gen 34863 flags 1
[ 1678.756001]          ref#0: extent data backref root 263 objectid 
600268 offset 0 count 1
[ 1678.756002]  item 76 key (17390477312 168 69632) itemoff 12202 
itemsize 53
[ 1678.756003]          extent refs 1 gen 34879 flags 1
[ 1678.756003]          ref#0: extent data backref root 263 objectid 
604085 offset 0 count 1
[ 1678.756005]  item 77 key (17390555136 168 16384) itemoff 12149 
itemsize 53
[ 1678.756005]          extent refs 1 gen 33115 flags 1
[ 1678.756005]          ref#0: extent data backref root 263 objectid 
562548 offset 0 count 1
[ 1678.756007]  item 78 key (17390571520 168 32768) itemoff 12096 
itemsize 53
[ 1678.756007]          extent refs 1 gen 33115 flags 1
[ 1678.756008]          ref#0: extent data backref root 263 objectid 
562549 offset 0 count 1
[ 1678.756009]  item 79 key (17390645248 168 671744) itemoff 12043 
itemsize 53
[ 1678.756010]          extent refs 1 gen 56672 flags 1
[ 1678.756010]          ref#0: extent data backref root 263 objectid 
1926763 offset 0 count 1
[ 1678.756011]  item 80 key (17391316992 168 892928) itemoff 11990 
itemsize 53
[ 1678.756012]          extent refs 1 gen 36106 flags 1
[ 1678.756012]          ref#0: extent data backref root 263 objectid 
601056 offset 0 count 1
[ 1678.756014]  item 81 key (17392209920 168 409600) itemoff 11937 
itemsize 53
[ 1678.756014]          extent refs 1 gen 44106 flags 1
[ 1678.756014]          ref#0: extent data backref root 267 objectid 
836144 offset 0 count 1
[ 1678.756016]  item 82 key (17392619520 168 45056) itemoff 11884 
itemsize 53
[ 1678.756016]          extent refs 1 gen 44106 flags 1
[ 1678.756017]          ref#0: extent data backref root 267 objectid 
836154 offset 0 count 1
[ 1678.756018]  item 83 key (17392664576 168 4096) itemoff 11831 itemsize 53
[ 1678.756018]          extent refs 1 gen 44106 flags 1
[ 1678.756019]          ref#0: extent data backref root 267 objectid 
836158 offset 0 count 1
[ 1678.756020]  item 84 key (17392668672 168 16384) itemoff 11778 
itemsize 53
[ 1678.756021]          extent refs 1 gen 44106 flags 1
[ 1678.756021]          ref#0: extent data backref root 267 objectid 
836160 offset 0 count 1
[ 1678.756022]  item 85 key (17392685056 168 16384) itemoff 11725 
itemsize 53
[ 1678.756023]          extent refs 1 gen 44106 flags 1
[ 1678.756023]          ref#0: extent data backref root 267 objectid 
836162 offset 0 count 1
[ 1678.756024]  item 86 key (17392701440 168 12288) itemoff 11672 
itemsize 53
[ 1678.756025]          extent refs 1 gen 44106 flags 1
[ 1678.756025]          ref#0: extent data backref root 267 objectid 
836174 offset 0 count 1
[ 1678.756026]  item 87 key (17392713728 168 4096) itemoff 11619 itemsize 53
[ 1678.756027]          extent refs 1 gen 44106 flags 1
[ 1678.756027]          ref#0: extent data backref root 267 objectid 
836199 offset 0 count 1
[ 1678.756028]  item 88 key (17392717824 168 69632) itemoff 11566 
itemsize 53
[ 1678.756029]          extent refs 816043786241 gen 37431 flags 1
[ 1678.756029]          ref#0: extent data backref root 16777483 
objectid 671118 offset 3456106496 count 1
[ 1678.756031]  item 89 key (17392787456 168 12288) itemoff 11513 
itemsize 53
[ 1678.756031]          extent refs 1 gen 33115 flags 1
[ 1678.756032]          ref#0: extent data backref root 263 objectid 
562554 offset 0 count 0
[ 1678.756033]  item 90 key (17392799744 168 12288) itemoff 11460 
itemsize 53
[ 1678.756033]          extent refs 1 gen 33115 flags 1
[ 1678.756034]          ref#0: extent data backref root 263 objectid 
562555 offset 0 count 1
[ 1678.756035]  item 91 key (17392812032 168 4096) itemoff 11407 itemsize 53
[ 1678.756035]          extent refs 1 gen 37434 flags 1
[ 1678.756036]          ref#0: extent data backref root 267 objectid 
757608 offset 0 count 1
[ 1678.756037]  item 92 key (17392816128 168 8192) itemoff 11354 itemsize 53
[ 1678.756038]          extent refs 1 gen 44106 flags 1
[ 1678.756038]          ref#0: extent data backref root 267 objectid 
836186 offset 0 count 1
[ 1678.756039]  item 93 key (17392824320 168 286720) itemoff 11301 
itemsize 53
[ 1678.756040]          extent refs 1 gen 34863 flags 1
[ 1678.756040]          ref#0: extent data backref root 263 objectid 
600269 offset 0 count 1
[ 1678.756041]  item 94 key (17393111040 168 28672) itemoff 11248 
itemsize 53
[ 1678.756042]          extent refs 1 gen 37431 flags 1
[ 1678.756042]          ref#0: extent data backref root 267 objectid 
671127 offset 0 count 1
[ 1678.756043]  item 95 key (17393139712 168 24576) itemoff 11195 
itemsize 53
[ 1678.756044]          extent refs 1 gen 37431 flags 1
[ 1678.756044]          ref#0: extent data backref root 267 objectid 
671129 offset 0 count 1
[ 1678.756046]  item 96 key (17393164288 168 28672) itemoff 11142 
itemsize 53
[ 1678.756046]          extent refs 1 gen 33115 flags 1
[ 1678.756046]          ref#0: extent data backref root 263 objectid 
562556 offset 0 count 1
[ 1678.756048]  item 97 key (17393192960 168 495616) itemoff 11089 
itemsize 53
[ 1678.756048]          extent refs 1 gen 34863 flags 1
[ 1678.756048]          ref#0: extent data backref root 263 objectid 
599969 offset 0 count 1
[ 1678.756050]  item 98 key (17393688576 168 8192) itemoff 11036 itemsize 53
[ 1678.756050]          extent refs 1 gen 37431 flags 1
[ 1678.756051]          ref#0: extent data backref root 267 objectid 
671135 offset 0 count 1
[ 1678.756052]  item 99 key (17393696768 168 8192) itemoff 10983 itemsize 53
[ 1678.756053]          extent refs 1 gen 37431 flags 1
[ 1678.756053]          ref#0: extent data backref root 267 objectid 
671136 offset 0 count 1
[ 1678.756054]  item 100 key (17393704960 168 8192) itemoff 10930 
itemsize 53
[ 1678.756055]          extent refs 1 gen 37431 flags 1
[ 1678.756055]          ref#0: extent data backref root 267 objectid 
671151 offset 0 count 1
[ 1678.756056]  item 101 key (17393713152 168 16384) itemoff 10877 
itemsize 53
[ 1678.756057]          extent refs 1 gen 33115 flags 1
[ 1678.756057]          ref#0: extent data backref root 263 objectid 
562563 offset 0 count 1
[ 1678.756059]  item 102 key (17393729536 168 16384) itemoff 10824 
itemsize 53
[ 1678.756059]          extent refs 1 gen 33115 flags 1
[ 1678.756059]          ref#0: extent data backref root 263 objectid 
562564 offset 0 count 1
[ 1678.756061]  item 103 key (17393745920 168 12288) itemoff 10771 
itemsize 53
[ 1678.756061]          extent refs 1 gen 33115 flags 1
[ 1678.756061]          ref#0: extent data backref root 263 objectid 
562565 offset 0 count 1
[ 1678.756063]  item 104 key (17393758208 168 167936) itemoff 10718 
itemsize 53
[ 1678.756063]          extent refs 1 gen 34863 flags 1
[ 1678.756064]          ref#0: extent data backref root 263 objectid 
600581 offset 0 count 1
[ 1678.756065]  item 105 key (17393926144 168 4096) itemoff 10665 
itemsize 53
[ 1678.756065]          extent refs 1 gen 37434 flags 1
[ 1678.756066]          ref#0: extent data backref root 267 objectid 
757616 offset 0 count 1
[ 1678.756067]  item 106 key (17393930240 168 12288) itemoff 10612 
itemsize 53
[ 1678.756067]          extent refs 1 gen 33115 flags 1
[ 1678.756068]          ref#0: extent data backref root 263 objectid 
562572 offset 0 count 1
[ 1678.756069]  item 107 key (17393942528 168 20480) itemoff 10559 
itemsize 53
[ 1678.756070]          extent refs 1 gen 33115 flags 1
[ 1678.756070]          ref#0: extent data backref root 263 objectid 
562573 offset 0 count 1
[ 1678.756071]  item 108 key (17393963008 168 16384) itemoff 10506 
itemsize 53
[ 1678.756072]          extent refs 1 gen 37431 flags 1
[ 1678.756072]          ref#0: extent data backref root 267 objectid 
671137 offset 0 count 1
[ 1678.756073]  item 109 key (17393979392 168 16384) itemoff 10453 
itemsize 53
[ 1678.756074]          extent refs 1 gen 37431 flags 1
[ 1678.756074]          ref#0: extent data backref root 267 objectid 
671138 offset 0 count 1
[ 1678.756075]  item 110 key (17393995776 168 8192) itemoff 10400 
itemsize 53
[ 1678.756076]          extent refs 1 gen 37431 flags 1
[ 1678.756076]          ref#0: extent data backref root 267 objectid 
671173 offset 0 count 1
[ 1678.756077]  item 111 key (17394003968 168 10285056) itemoff 10347 
itemsize 53
[ 1678.756078]          extent refs 1 gen 41762 flags 1
[ 1678.756078]          ref#0: extent data backref root 263 objectid 
763090 offset 0 count 1
[ 1678.756079]  item 112 key (17404289024 168 757760) itemoff 10294 
itemsize 53
[ 1678.756080]          extent refs 1 gen 56672 flags 1
[ 1678.756080]          ref#0: extent data backref root 263 objectid 
1926757 offset 0 count 1
[ 1678.756082]  item 113 key (17405186048 168 208896) itemoff 10241 
itemsize 53
[ 1678.756082]          extent refs 1 gen 48783 flags 1
[ 1678.756082]          ref#0: extent data backref root 263 objectid 
1141563 offset 0 count 1
[ 1678.756084]  item 114 key (17405394944 168 380928) itemoff 10188 
itemsize 53
[ 1678.756084]          extent refs 1 gen 56898 flags 1
[ 1678.756085]          ref#0: extent data backref root 263 objectid 
1931137 offset 0 count 1
[ 1678.756086]  item 115 key (17405919232 168 57344) itemoff 10135 
itemsize 53
[ 1678.756086]          extent refs 1 gen 48784 flags 1
[ 1678.756087]          ref#0: extent data backref root 263 objectid 
1141538 offset 0 count 1
[ 1678.756088]  item 116 key (17405976576 168 45056) itemoff 10082 
itemsize 53
[ 1678.756088]          extent refs 1 gen 48784 flags 1
[ 1678.756089]          ref#0: extent data backref root 263 objectid 
1141539 offset 0 count 1
[ 1678.756090]  item 117 key (17406156800 168 253952) itemoff 10029 
itemsize 53
[ 1678.756091]          extent refs 1 gen 46129 flags 1
[ 1678.756091]          ref#0: extent data backref root 263 objectid 
1022873 offset 0 count 1
[ 1678.756092]  item 118 key (17406410752 168 159744) itemoff 9976 
itemsize 53
[ 1678.756093]          extent refs 1 gen 44106 flags 1
[ 1678.756093]          ref#0: extent data backref root 267 objectid 
836148 offset 0 count 1
[ 1678.756094]  item 119 key (17406570496 168 249856) itemoff 9923 
itemsize 53
[ 1678.756095]          extent refs 1 gen 44106 flags 1
[ 1678.756095]          ref#0: extent data backref root 267 objectid 
836150 offset 0 count 1
[ 1678.756096]  item 120 key (17406820352 168 32768) itemoff 9870 
itemsize 53
[ 1678.756097]          extent refs 1 gen 44106 flags 1
[ 1678.756097]          ref#0: extent data backref root 267 objectid 
836164 offset 0 count 1
[ 1678.756099]  item 121 key (17406853120 168 8192) itemoff 9817 itemsize 53
[ 1678.756099]          extent refs 1 gen 44106 flags 1
[ 1678.756099]          ref#0: extent data backref root 267 objectid 
836187 offset 0 count 1
[ 1678.756101]  item 122 key (17406861312 168 8192) itemoff 9764 itemsize 53
[ 1678.756101]          extent refs 1 gen 37431 flags 1
[ 1678.756101]          ref#0: extent data backref root 267 objectid 
671174 offset 0 count 1
[ 1678.756103]  item 123 key (17406869504 168 2588672) itemoff 9711 
itemsize 53
[ 1678.756103]          extent refs 1 gen 50602 flags 1
[ 1678.756104]          ref#0: extent data backref root 267 objectid 
885938 offset 0 count 1
[ 1678.756105]  item 124 key (17409458176 168 2588672) itemoff 9658 
itemsize 53
[ 1678.756105]          extent refs 1 gen 50602 flags 1
[ 1678.756106]          ref#0: extent data backref root 267 objectid 
885943 offset 0 count 1
[ 1678.756107]  item 125 key (17412046848 168 2588672) itemoff 9605 
itemsize 53
[ 1678.756107]          extent refs 1 gen 50602 flags 1
[ 1678.756108]          ref#0: extent data backref root 267 objectid 
886048 offset 0 count 1
[ 1678.756109]  item 126 key (17414635520 168 2588672) itemoff 9552 
itemsize 53
[ 1678.756110]          extent refs 1 gen 50602 flags 1
[ 1678.756110]          ref#0: extent data backref root 267 objectid 
886121 offset 0 count 1
[ 1678.756111]  item 127 key (17417224192 168 2588672) itemoff 9499 
itemsize 53
[ 1678.756112]          extent refs 1 gen 50602 flags 1
[ 1678.756112]          ref#0: extent data backref root 267 objectid 
886141 offset 0 count 1
[ 1678.756113]  item 128 key (17419812864 168 2588672) itemoff 9446 
itemsize 53
[ 1678.756114]          extent refs 1 gen 50602 flags 1
[ 1678.756114]          ref#0: extent data backref root 267 objectid 
886182 offset 0 count 1
[ 1678.756115]  item 129 key (17422401536 168 2588672) itemoff 9393 
itemsize 53
[ 1678.756116]          extent refs 1 gen 50602 flags 1
[ 1678.756116]          ref#0: extent data backref root 267 objectid 
886198 offset 0 count 1
[ 1678.756117]  item 130 key (17424990208 168 2588672) itemoff 9340 
itemsize 53
[ 1678.756118]          extent refs 1 gen 50602 flags 1
[ 1678.756118]          ref#0: extent data backref root 267 objectid 
886211 offset 0 count 1
[ 1678.756119]  item 131 key (17427578880 168 2588672) itemoff 9287 
itemsize 53
[ 1678.756120]          extent refs 1 gen 50602 flags 1
[ 1678.756120]          ref#0: extent data backref root 267 objectid 
886262 offset 0 count 1
[ 1678.756122]  item 132 key (17430167552 168 2592768) itemoff 9234 
itemsize 53
[ 1678.756122]          extent refs 1 gen 50602 flags 1
[ 1678.756122]          ref#0: extent data backref root 267 objectid 
886295 offset 0 count 1
[ 1678.756124] BTRFS error (device sdb2): unable to find ref byte nr 
17392717824 parent 0 root 267  owner 671118 offset 0
[ 1678.756125] ------------[ cut here ]------------
[ 1678.756125] BTRFS: Transaction aborted (error -2)
[ 1678.756150] WARNING: CPU: 2 PID: 8255 at 
../fs/btrfs/extent-tree.c:3111 __btrfs_free_extent.isra.47+0x265/0xe60 
[btrfs]
[ 1678.756151] Modules linked in: rpcsec_gss_krb5 auth_rpcgss vmnet(OEX) 
ppdev parport_pc parport vmw_vsock_vmci_transport vsock vmw_vmci nfsv4 
vmmon(OEX) dns_resolver nfs lockd grace sunrpc fscache af_packet 
nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet 
nft_reject nft_ct nft_chain_nat nf_tables ebtable_nat ebtable_broute 
ip6table_nat ip6table_mangle ip6table_raw ip6table_security iptable_nat 
nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle 
iptable_raw iptable_security ip_set nfnetlink iscsi_ibft 
iscsi_boot_sysfs ebtable_filter ebtables ip6table_filter ip6_tables 
rfkill iptable_filter ip_tables x_tables bpfilter vboxnetadp(OEN) 
vboxnetflt(OEN) vboxdrv(OEN) dmi_sysfs hwmon_vid ext4 crc16 mbcache jbd2 
squashfs loop nvidia_drm(POEX) nvidia_modeset(POEX) nvidia_uvm(POEX) 
snd_hda_codec_realtek snd_hda_codec_generic snd_hda_codec_hdmi 
ledtrig_audio snd_hda_intel snd_intel_dspcfg soundwire_intel 
soundwire_generic_allocation nvidia(POEX) soundwire_cadence
[ 1678.756165]  soundwire_bus snd_hda_codec drm_kms_helper edac_mce_amd 
snd_hda_core cec snd_hwdep kvm_amd snd_soc_core rc_core ccp snd_compress 
ipmi_devintf kvm snd_pcm_dmaengine irqbypass snd_pcm wmi_bmof pcspkr 
ipmi_msghandler k10temp snd_timer sp5100_tco(N) syscopyarea r8169 
sysfillrect snd sysimgblt i2c_piix4 realtek fb_sys_fops libphy soundcore 
asus_atk0110(N) acpi_cpufreq drm fuse configfs sd_mod uas usb_storage 
hid_generic usbhid btrfs libcrc32c xor raid6_pq sr_mod cdrom xhci_pci 
ohci_pci ata_generic xhci_hcd pata_jmicron ehci_pci ahci ohci_hcd 
libahci pata_atiixp ehci_hcd serio_raw nvme firewire_ohci usbcore libata 
nvme_core firewire_core t10_pi wmi crc_itu_t button sg dm_multipath 
dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua scsi_mod msr
[ 1678.756179] Supported: No, Proprietary and Unsupported modules are loaded
[ 1678.756180] CPU: 2 PID: 8255 Comm: btrfs-transacti Tainted: P        
W  OE  X  N 5.3.18-150300.59.76-default #1 SLE15-SP3
[ 1678.756180] Hardware name: System manufacturer System Product 
Name/M4A89TD PRO USB3, BIOS 3029    09/07/2012
[ 1678.756193] RIP: 0010:__btrfs_free_extent.isra.47+0x265/0xe60 [btrfs]
[ 1678.756194] Code: 8b 44 24 08 48 8b 40 50 f0 48 0f ba a8 98 09 00 00 
03 0f 92 c0 84 c0 41 59 75 11 44 89 ee 48 c7 c7 40 9e 64 c0 e8 5b 88 71 
e1 <0f> 0b 48 8b 3c 24 b9 fe ff ff ff ba 27 0c 00 00 48 c7 c6 40 b3 63
[ 1678.756195] RSP: 0018:ffffae71066d7c58 EFLAGS: 00010286
[ 1678.756195] RAX: 0000000000000000 RBX: 00000000000a3d8e RCX: 
0000000000000007
[ 1678.756196] RDX: 0000000000000000 RSI: 0000000000000082 RDI: 
ffff88d963a99550
[ 1678.756197] RBP: 000000040cafd000 R08: 000000000000066d R09: 
0000000000000001
[ 1678.756197] R10: 0000000000000002 R11: 0000000000000001 R12: 
ffff88d6c1139bd0
[ 1678.756198] R13: 00000000fffffffe R14: 0000000000000000 R15: 
000000000000010b
[ 1678.756198] FS:  0000000000000000(0000) GS:ffff88d963a80000(0000) 
knlGS:0000000000000000
[ 1678.756199] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1678.756200] CR2: 0000369f2edc7000 CR3: 0000000270330000 CR4: 
00000000000006e0
[ 1678.756200] Call Trace:
[ 1678.756214]  __btrfs_run_delayed_refs+0x54c/0x1180 [btrfs]
[ 1678.756227]  btrfs_run_delayed_refs+0x62/0x1f0 [btrfs]
[ 1678.756242]  btrfs_commit_transaction+0x50/0xa60 [btrfs]
[ 1678.756256]  ? start_transaction+0xc5/0x540 [btrfs]
[ 1678.756270]  transaction_kthread+0x148/0x160 [btrfs]
[ 1678.756284]  ? btrfs_cleanup_transaction+0x5c0/0x5c0 [btrfs]
[ 1678.756285]  kthread+0x10d/0x130
[ 1678.756286]  ? kthread_park+0xa0/0xa0
[ 1678.756287]  ret_from_fork+0x35/0x40
[ 1678.756289] ---[ end trace da68b410b6e3cdea ]---
[ 1678.756290] BTRFS: error (device sdb2) in __btrfs_free_extent:3111: 
errno=-2 No such entry
[ 1678.756291] BTRFS info (device sdb2): forced readonly
[ 1678.756293] BTRFS: error (device sdb2) in 
btrfs_run_delayed_refs:2147: errno=-2 No such entry
andromeda:~ #







