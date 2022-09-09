Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 818DB5B2AC5
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Sep 2022 02:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbiIIAHV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Sep 2022 20:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbiIIAHS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Sep 2022 20:07:18 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F76810F8EA
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Sep 2022 17:07:13 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 681FB240103
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Sep 2022 02:07:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1662682032; bh=jzFvfVgsNTvWhpjIDy8EOYqRp0UWNGBjSxVB1EmBk74=;
        h=Date:From:To:Subject:From;
        b=RbsgChKwecCjgoahr73eY7VEsKsv3ZD/LUsYVDIXRd5ZVJdLYHcYjtYKPhRLj38i4
         efhxA94sr89fm8hIFEPiodFMW2WFlaOMH2o5hAkBuTlj9alVdupC8PPWSBWdrp8vvi
         fGF9dbuP11jWymh0LxMmEjukU1eGZRSJHFjEThbys/aRJQ1cH7PiBoKDWP+UiFdsmJ
         xSnhYlSHPZxZOfgnNs4QDbwSpBUPBHb3GJEGHYwKyEdVYOy/p/Aul4ZtLzMZAdErVI
         2lXEvRGzl7DOGTY/O1EVTIqn09Q1Aqv1fcs8acujSS69S7LuMQ/1jEupquf2qjg6U6
         VxkOdwnBQQ5Vw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4MNxBR5bvsz9rxF;
        Fri,  9 Sep 2022 02:07:11 +0200 (CEST)
Date:   Fri,  9 Sep 2022 00:07:11 +0000
From:   development.rex@posteo.net
To:     linux-btrfs@vger.kernel.org
Subject: Read only because of enospc
Message-ID: <20220909000446.zzsniu7rc6tl6sz7@regina>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Dear BTRFS team,

I ran out of space on a 10 disk btrfs cluster with raid5 for data and
raid1c4 for meta.
The people in the irc channel were wery kind and helpful
but unfortunately it didn't work.
Even after >50 attempts of cancelling the balance the device gets thrown ba=
ck to ro.
The balance in progress, if not skipped,
will also throw the fs to ro before any commits can be made.
Adding a device also fails because of the fallback to ro.
Is there a way to get the cluster back to stable rw so I can make deletions=
 or run
a conversion of the metadata to raid1?

I'm looking forward to an answer and hope you can help me.

rex

uname -a:
Linux my-pc 5.17.3-arch1-1 #1 SMP PREEMPT Thu, 14 Apr 2022 01:18:36 +0000 x=
86_64 GNU/Linux

btrfs --version:
btrfs-progs v5.16.2=20

btrfs fi show:
Label: 'label'  uuid: UUID
        Total devices 10 FS bytes used 32.37TiB
        devid    1 size 3.64TiB used 3.64TiB path /dev/mapper/disk01_crypt
        devid    2 size 3.64TiB used 3.64TiB path /dev/mapper/disk02_crypt=
=20
        devid    3 size 3.64TiB used 3.64TiB path /dev/mapper/disk03_crypt
        devid    4 size 3.64TiB used 3.64TiB path /dev/mapper/disk04_crypt
        devid    5 size 3.64TiB used 3.64TiB path /dev/mapper/disk05_crypt
        devid    6 size 3.64TiB used 3.64TiB path /dev/mapper/disk06_crypt
        devid    7 size 3.64TiB used 3.64TiB path /dev/mapper/disk07_crypt
        devid    8 size 3.64TiB used 3.64TiB path /dev/mapper/disk08_crypt
        devid    9 size 3.64TiB used 3.64TiB path /dev/mapper/disk09_crypt
        devid   10 size 3.64TiB used 3.61TiB path /dev/mapper/disk10_crypt

btrfs fi df:
Data, RAID5: total=3D32.46TiB, used=3D32.30TiB
System, RAID1C4: total=3D20.00MiB, used=3D1.48MiB
Metadata, RAID1C4: total=3D74.27GiB, used=3D74.07GiB
GlobalReserve, single: total=3D512.00MiB, used=3D0.00B

relevant output of dmesg after running mount && balance cancel

[12167570.541743] BTRFS info (device dm-7): enabling free space tree
[12167570.541746] BTRFS info (device dm-7): disabling free space tree
[12167570.541748] BTRFS info (device dm-7): has skinny extents
[12167572.455439] BTRFS info (device dm-7): bdev /dev/mapper/disc errs: wr =
396469, rd 388982, flush 0, corrupt 3, gen 0
[12167600.020777] BTRFS error (device dm-7): open_ctree failed
[12167616.652264] BTRFS info (device dm-7): flagging fs with big metadata f=
eature
[12167616.652271] BTRFS info (device dm-7): use no compression
[12167616.652274] BTRFS info (device dm-7): enabling free space tree
[12167616.652277] BTRFS info (device dm-7): disabling free space tree
[12167616.652279] BTRFS info (device dm-7): has skinny extents
[12167618.556790] BTRFS info (device dm-7): bdev /dev/mapper/disc errs: wr =
396469, rd 388982, flush 0, corrupt 3, gen 0
[12167650.088560] BTRFS info (device dm-7): balance: resume skipped
[12167650.088567] BTRFS info (device dm-7): checking UUID tree
[12167709.861453] ------------[ cut here ]------------
[12167709.861457] BTRFS: Transaction aborted (error -28)
[12167709.861488] WARNING: CPU: 1 PID: 3460041 at fs/btrfs/extent-tree.c:30=
79 __btrfs_free_extent+0x469/0xa30 [btrfs]
[12167709.861532] Modules linked in: loop udf crc_itu_t ext4 crc16 mbcache =
jbd2 tun cfg80211 nf_log_syslog nft_log nft_limit nft_ct nf_conntrack nf_de=
frag_ipv6 nf_defrag_ipv4 nf_tables nfnetlink nct6775 hwmon_vid uvcvideo vid=
eobuf2_vmalloc snd_usb_audio videobuf2_memops videobuf2_v4l2 videobuf2_comm=
on snd_usbmidi_lib snd_rawmidi videodev snd_seq_device mc mousedev joydev s=
nd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio=
 intel_rapl_msr intel_rapl_common eeepc_wmi snd_hda_intel snd_intel_dspcfg =
asus_wmi x86_pkg_temp_thermal sparse_keymap snd_intel_sdw_acpi intel_powerc=
lamp snd_hda_codec coretemp platform_profile snd_hda_core rfkill snd_hwdep =
r8169 kvm_intel at24 iTCO_wdt kvm snd_pcm intel_pmc_bxt irqbypass snd_timer=
 realtek iTCO_vendor_support rapl wmi_bmof mei_pxp intel_cstate intel_uncor=
e mei_hdcp i2c_i801 mdio_devres pcspkr i2c_smbus lpc_ich snd libphy mei_me =
soundcore mac_hid mei wmi fuse ip_tables x_tables xxhash_generic dm_crypt c=
bc encrypted_keys trusted
[12167709.861578]  asn1_encoder tee tpm rng_core btrfs blake2b_generic libc=
rc32c crc32c_generic xor raid6_pq ses enclosure uas usbhid usb_storage dm_m=
od crct10dif_pclmul crc32_pclmul crc32c_intel mpt3sas ghash_clmulni_intel a=
esni_intel xhci_pci crypto_simd sr_mod raid_class cryptd cdrom xhci_pci_ren=
esas scsi_transport_sas i915 intel_gtt video ttm
[12167709.861597] CPU: 1 PID: 3460041 Comm: btrfs Tainted: G        W      =
   5.17.3-arch1-1 #1 7a55d2374d124bfa80e113bab2e4c0e86120013b
[12167709.861600] Hardware name: System manufacturer System Product Name/P8=
H77-M LE, BIOS 1501 06/20/2014
[12167709.861601] RIP: 0010:__btrfs_free_extent+0x469/0xa30 [btrfs]
[12167709.861631] Code: ff ff 48 8b 44 24 10 48 89 6c 24 57 c6 44 24 5f a8 =
48 89 44 24 60 e9 3f fe ff ff 44 89 e6 48 c7 c7 38 b5 75 c0 e8 67 9d 48 f3 =
<0f> 0b 48 8b 7c 24 08 44 89 e1 ba 07 0c 00 00 48 c7 c6 40 f4 74 c0
[12167709.861632] RSP: 0018:ffffb15c0165f968 EFLAGS: 00010286
[12167709.861634] RAX: 0000000000000000 RBX: ffff8b49493e1b60 RCX: 00000000=
00000027
[12167709.861636] RDX: ffff8b4a57aa16e8 RSI: 0000000000000001 RDI: ffff8b4a=
57aa16e0
[12167709.861637] RBP: 0000811aaeed4000 R08: 0000000000000000 R09: ffffb15c=
0165f798
[12167709.861638] R10: ffffb15c0165f790 R11: ffffffffb4cc6528 R12: 00000000=
ffffffe4
[12167709.861639] R13: 0000000000000000 R14: 0000000000000002 R15: 00000000=
00000000
[12167709.861641] FS:  00007fc3c1e118c0(0000) GS:ffff8b4a57a80000(0000) knl=
GS:0000000000000000
[12167709.861642] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[12167709.861644] CR2: 0000314afabdc000 CR3: 000000012e268001 CR4: 00000000=
000606e0
[12167709.861645] Call Trace:
[12167709.861649]  <TASK>
[12167709.861652]  __btrfs_run_delayed_refs+0x25d/0x1180 [btrfs ad10df01d55=
9cebe24c88b962fa60b578838368d]
[12167709.861684]  btrfs_run_delayed_refs+0x73/0x1f0 [btrfs ad10df01d559ceb=
e24c88b962fa60b578838368d]
[12167709.861714]  btrfs_commit_transaction+0x558/0xbd0 [btrfs ad10df01d559=
cebe24c88b962fa60b578838368d]
[12167709.861746]  ? do_wait_intr_irq+0xa0/0xa0
[12167709.861750]  ? kmem_cache_free+0x3c9/0x420
[12167709.861753]  reset_balance_state+0x142/0x1a0 [btrfs ad10df01d559cebe2=
4c88b962fa60b578838368d]
[12167709.861791]  btrfs_cancel_balance+0x175/0x1a0 [btrfs ad10df01d559cebe=
24c88b962fa60b578838368d]
[12167709.861827]  btrfs_ioctl+0x1653/0x3040 [btrfs ad10df01d559cebe24c88b9=
62fa60b578838368d]
[12167709.861865]  ? __alloc_pages+0xe6/0x230
[12167709.861868]  ? __mod_memcg_lruvec_state+0x41/0x80
[12167709.861871]  ? __mod_lruvec_page_state+0x7d/0xc0
[12167709.861874]  ? set_pte+0x5/0x10
[12167709.861876]  ? __handle_mm_fault+0x124e/0x1530
[12167709.861879]  ? __x64_sys_ioctl+0x82/0xb0
[12167709.861882]  __x64_sys_ioctl+0x82/0xb0
[12167709.861885]  do_syscall_64+0x5c/0x80
[12167709.861890]  ? handle_mm_fault+0xb2/0x280
[12167709.861893]  ? do_user_addr_fault+0x1d7/0x690
[12167709.861896]  ? exc_page_fault+0x72/0x170
[12167709.861899]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[12167709.861902] RIP: 0033:0x7fc3c1f5fe6f
[12167709.861904] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 =
00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 =
<41> 89 c0 3d 00 f0 ff ff 77 1f 48 8b 44 24 18 64 48 2b 04 25 28 00
[12167709.861906] RSP: 002b:00007fff8c15f480 EFLAGS: 00000246 ORIG_RAX: 000=
0000000000010
[12167709.861908] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007fc3=
c1f5fe6f
[12167709.861909] RDX: 0000000000000002 RSI: 0000000040049421 RDI: 00000000=
00000003
[12167709.861910] RBP: 0000000000000003 R08: 0000000000000003 R09: 00007fc3=
c2052b00
[12167709.861911] R10: 0000000000000076 R11: 0000000000000246 R12: 00005555=
deaf45c0
[12167709.861913] R13: 00007fff8c15fd8b R14: 00005555deace5a0 R15: 00007fff=
8c15f680
[12167709.861915]  </TASK>
[12167709.861915] ---[ end trace 0000000000000000 ]---
[12167709.861917] BTRFS: error (device dm-7) in __btrfs_free_extent:3079: e=
rrno=3D-28 No space left
[12167709.861920] BTRFS info (device dm-7): forced readonly
[12167709.861922] BTRFS: error (device dm-7) in btrfs_run_delayed_refs:2159=
: errno=3D-28 No space left
[12167709.861924] BTRFS warning (device dm-7): Skipping commit of aborted t=
ransaction.
[12167709.861925] BTRFS: error (device dm-7) in cleanup_transaction:1974: e=
rrno=3D-28 No space left
[12167709.889246] BTRFS: error (device dm-7) in reset_balance_state:3604: e=
rrno=3D-28 No space left
[12167709.889271] BTRFS info (device dm-7): balance: canceled

