Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5991A2E9266
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Jan 2021 10:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbhADJQC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Jan 2021 04:16:02 -0500
Received: from eu-shark1.inbox.eu ([195.216.236.81]:57098 "EHLO
        eu-shark1.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbhADJQC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Jan 2021 04:16:02 -0500
Received: from eu-shark1.inbox.eu (localhost [127.0.0.1])
        by eu-shark1-out.inbox.eu (Postfix) with ESMTP id 1868A6C00705;
        Mon,  4 Jan 2021 11:15:14 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1609751714; bh=Ez9d9cF3De7yNR5SVrd3p1jjx7CIve4tOdVt7BvTXDw=;
        h=References:From:To:Cc:Subject:In-reply-to:Date;
        b=ihM/c35TmPoTC+NRCtGLZ+GwB6/Yem26WSYM9iWRYQ6WamPOjAUkNCcZBex36IUUX
         zJE3e5ggPu4h040E2J3R81Q+SzOU4egxJYkYeiVssbq7zs7/NZoPvpTBUSw46aI4ls
         QrAjAl2RExSkF3ObdKrgCYN/a/YMUKYMegjjAjXk=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id 05ADF6C004B9;
        Mon,  4 Jan 2021 11:15:14 +0200 (EET)
Received: from eu-shark1.inbox.eu ([127.0.0.1])
        by localhost (eu-shark1.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id Q592e_S_9KSO; Mon,  4 Jan 2021 11:15:13 +0200 (EET)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id 34E5D6C00661;
        Mon,  4 Jan 2021 11:15:13 +0200 (EET)
Received: from nas (unknown [211.106.132.202])
        (Authenticated sender: l@damenly.su)
        by mail.inbox.eu (Postfix) with ESMTPA id 851FD1BE00CC;
        Mon,  4 Jan 2021 11:15:11 +0200 (EET)
References: <20210103092804.756-1-l@damenly.su>
 <20210103092804.756-3-l@damenly.su>
 <1a8dbe6a-f2db-4e0d-3b5f-dcd2073d6e1d@oracle.com>
User-agent: mu4e 1.4.13; emacs 27.1
From:   Su Yue <l@damenly.su>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 2/2] btrfs: tree-checker: check if chunk item end
 oveflows
In-reply-to: <1a8dbe6a-f2db-4e0d-3b5f-dcd2073d6e1d@oracle.com>
Message-ID: <y2h9kqqx.fsf@damenly.su>
Date:   Mon, 04 Jan 2021 17:15:02 +0800
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Virus-Scanned: OK
X-ESPOL: +dBm1NUOBk3XhyXDXxmqCAcxrytLVO7k/+Gmsm5UnmeDUSOGf0kTURCxg211T2K6vj0X
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On Mon 04 Jan 2021 at 16:31, Anand Jain <anand.jain@oracle.com> 
wrote:

> On 3/1/21 5:28 pm, Su Yue wrote:
>> while mounting the poc image user-provided, kernel panics due 
>> to the
>> invalid chunk item whose end is less than start.
>> ========================================================================
>> [   66.387422] loop: module loaded
>> [   66.389773] loop0: detected capacity change from 262144 to 0
>> [   66.427708] BTRFS: device fsid 
>> a62e00e8-e94e-4200-8217-12444de93c2e devid 1 transid 12 
>> /dev/loop0 scanned by mount (613)
>> [   66.431061] BTRFS info (device loop0): disk space caching is 
>> enabled
>> [   66.431078] BTRFS info (device loop0): has skinny extents
>> [   66.437101] BTRFS error: insert state: end < start 29360127 
>> 37748736
>> [   66.437136] ------------[ cut here ]------------
>> [   66.437140] WARNING: CPU: 16 PID: 613 at 
>> fs/btrfs/extent_io.c:557 insert_state.cold+0x1a/0x46 [btrfs]
>> [   66.437193] Modules linked in: loop btrfs(O) blake2b_generic 
>> xor zstd_compress nls_iso8859_1 nls_cp437 vfat fat raid6_pq 
>> joydev mousedev crct10dif_pclmul psmouse crc32_pclmul 
>> crc32c_intel ghash_clmulni_intel aesni_intel glue_helper 
>> crypto_simd cryptd pcspkr rtc_cmos evdev intel_agp intel_gtt 
>> qemu_fw_cfg drm agpgart ip_tables x_tables xfs virtio_balloon 
>> virtio_console virtio_net net_failover failover dm_mod sd_mod 
>> hid_generic usbhid hid uhci_hcd serio_raw atkbd libps2 ahci 
>> libahci ehci_pci ehci_hcd libata usbcore scsi_mod virtio_pci 
>> virtio_ring usb_common virtio i8042 serio
>> [   66.437369] CPU: 16 PID: 613 Comm: mount Tainted: G 
>> O      5.11.0-rc1-custom #45
>> [   66.437374] Hardware name: QEMU Standard PC (i440FX + PIIX, 
>> 1996), BIOS ArchLinux 1.14.0-1 04/01/2014
>> [   66.437378] RIP: 0010:insert_state.cold+0x1a/0x46 [btrfs]
>> [   66.437416] Code: 39 01 00 00 48 c7 c7 85 38 9e c0 e8 3c fd 
>> ff ff 48 8b 7f 08 48 89 d1 48 89 da 4c 89 45 d0 48 c7 c6 20 b0 
>> 9e c0 e8 49 97 ff ff <0f> 0b 4c 8b 45 d0 e9 ff 28 f7 ff 49 8b 
>> 7d 08 49 89 d9 4d 89 f8 41
>> [   66.437420] RSP: 0018:ffff93e5414c3908 EFLAGS: 00010286
>> [   66.437427] RAX: 0000000000000000 RBX: 0000000001bfffff RCX: 
>> 0000000000000000
>> [   66.437431] RDX: 0000000000000000 RSI: ffffffffb90d4660 RDI: 
>> 00000000ffffffff
>> [   66.437434] RBP: ffff93e5414c3938 R08: 0000000000000001 R09: 
>> 0000000000000001
>> [   66.437438] R10: ffff93e5414c3658 R11: 0000000000000000 R12: 
>> ffff8ec782d72aa0
>> [   66.437441] R13: ffff8ec78bc71628 R14: 0000000000000000 R15: 
>> 0000000002400000
>> [   66.437447] FS:  00007f01386a8580(0000) 
>> GS:ffff8ec809000000(0000) knlGS:0000000000000000
>> [   66.437451] CS:  0010 DS: 0000 ES: 0000 CR0: 
>> 0000000080050033
>> [   66.437455] CR2: 00007f01382fa000 CR3: 0000000109a34000 CR4: 
>> 0000000000750ee0
>> [   66.437460] PKRU: 55555554
>> [   66.437464] Call Trace:
>> [   66.437475]  set_extent_bit+0x652/0x740 [btrfs]
>> [   66.437539]  set_extent_bits_nowait+0x1d/0x20 [btrfs]
>> [   66.437576]  add_extent_mapping+0x1e0/0x2f0 [btrfs]
>> [   66.437621]  read_one_chunk+0x33c/0x420 [btrfs]
>> [   66.437674]  btrfs_read_chunk_tree+0x6a4/0x870 [btrfs]
>> [   66.437708]  ? kvm_sched_clock_read+0x18/0x40
>> [   66.437739]  open_ctree+0xb32/0x1734 [btrfs]
>> [   66.437781]  ? bdi_register_va+0x1b/0x20
>> [   66.437788]  ? super_setup_bdi_name+0x79/0xd0
>> [   66.437810]  btrfs_mount_root.cold+0x12/0xeb [btrfs]
>> [   66.437854]  ? __kmalloc_track_caller+0x217/0x3b0
>> [   66.437873]  legacy_get_tree+0x34/0x60
>> [   66.437880]  vfs_get_tree+0x2d/0xc0
>> [   66.437888]  vfs_kern_mount.part.0+0x78/0xc0
>> [   66.437897]  vfs_kern_mount+0x13/0x20
>> [   66.437902]  btrfs_mount+0x11f/0x3c0 [btrfs]
>> [   66.437940]  ? kfree+0x5ff/0x670
>> [   66.437944]  ? __kmalloc_track_caller+0x217/0x3b0
>> [   66.437962]  legacy_get_tree+0x34/0x60
>> [   66.437974]  vfs_get_tree+0x2d/0xc0
>> [   66.437983]  path_mount+0x48c/0xd30
>> [   66.437998]  __x64_sys_mount+0x108/0x140
>> [   66.438011]  do_syscall_64+0x38/0x50
>> [   66.438018]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>> [   66.438023] RIP: 0033:0x7f0138827f6e
>> [   66.438029] Code: 48 8b 0d 05 0f 0c 00 f7 d8 64 89 01 48 83 
>> c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca 
>> b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d2 
>> 0e 0c 00 f7 d8 64 89 01 48
>> [   66.438033] RSP: 002b:00007ffecd79edf8 EFLAGS: 00000246 
>> ORIG_RAX: 00000000000000a5
>> [   66.438040] RAX: ffffffffffffffda RBX: 00007f013894c264 RCX: 
>> 00007f0138827f6e
>> [   66.438044] RDX: 00005593a4a41360 RSI: 00005593a4a33690 RDI: 
>> 00005593a4a3a6c0
>> [   66.438047] RBP: 00005593a4a33440 R08: 0000000000000000 R09: 
>> 0000000000000001
>> [   66.438050] R10: 0000000000000000 R11: 0000000000000246 R12: 
>> 0000000000000000
>> [   66.438054] R13: 00005593a4a3a6c0 R14: 00005593a4a41360 R15: 
>> 00005593a4a33440
>> [   66.438078] irq event stamp: 18169
>> [   66.438082] hardirqs last  enabled at (18175): 
>> [<ffffffffb81154bf>] console_unlock+0x4ff/0x5f0
>> [   66.438088] hardirqs last disabled at (18180): 
>> [<ffffffffb8115427>] console_unlock+0x467/0x5f0
>> [   66.438092] softirqs last  enabled at (16910): 
>> [<ffffffffb8a00fe2>] asm_call_irq_on_stack+0x12/0x20
>> [   66.438097] softirqs last disabled at (16905): 
>> [<ffffffffb8a00fe2>] asm_call_irq_on_stack+0x12/0x20
>> [   66.438103] ---[ end trace e114b111db64298b ]---
>> [   66.438107] BTRFS error: found node 12582912 29360127 on 
>> insert of 37748736 29360127
>> [   66.438127] BTRFS critical: panic in 
>> extent_io_tree_panic:679: locking error: extent tree was 
>> modified by another thread while locked (errno=-17 Object 
>> already exists)
>> [   66.441069] ------------[ cut here ]------------
>> [   66.441072] kernel BUG at fs/btrfs/extent_io.c:679!
>> [   66.442064] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
>> [   66.443018] CPU: 16 PID: 613 Comm: mount Tainted: G        W 
>> O      5.11.0-rc1-custom #45
>> [   66.444538] Hardware name: QEMU Standard PC (i440FX + PIIX, 
>> 1996), BIOS ArchLinux 1.14.0-1 04/01/2014
>> [   66.446223] RIP: 0010:extent_io_tree_panic.isra.0+0x23/0x25 
>> [btrfs]
>> [   66.447419] Code: 9e c0 e8 d1 ff ff ff 0f 1f 44 00 00 55 89 
>> f1 49 c7 c0 70 ae 9e c0 ba a7 02 00 00 48 c7 c6 00 b5 9d c0 48 
>> 89 e5 e8 15 a0 ff ff <0f> 0b 42 8d 14 10 4c 89 4d a8 89 c1 81 
>> fa 00 10 00 00 89 45 b0 44
>> [   66.450878] RSP: 0018:ffff93e5414c3948 EFLAGS: 00010246
>> [   66.451840] RAX: 0000000000000000 RBX: 0000000001bfffff RCX: 
>> 0000000000000000
>> [   66.453141] RDX: 0000000000000000 RSI: ffffffffb90d4660 RDI: 
>> 00000000ffffffff
>> [   66.454445] RBP: ffff93e5414c3948 R08: 0000000000000001 R09: 
>> 0000000000000001
>> [   66.455743] R10: ffff93e5414c3658 R11: 0000000000000000 R12: 
>> ffff8ec782d728c0
>> [   66.457055] R13: ffff8ec78bc71628 R14: ffff8ec782d72aa0 R15: 
>> 0000000002400000
>> [   66.458356] FS:  00007f01386a8580(0000) 
>> GS:ffff8ec809000000(0000) knlGS:0000000000000000
>> [   66.459841] CS:  0010 DS: 0000 ES: 0000 CR0: 
>> 0000000080050033
>> [   66.460895] CR2: 00007f01382fa000 CR3: 0000000109a34000 CR4: 
>> 0000000000750ee0
>> [   66.462196] PKRU: 55555554
>> [   66.462692] Call Trace:
>> [   66.463139]  set_extent_bit.cold+0x30/0x98 [btrfs]
>> [   66.464049]  set_extent_bits_nowait+0x1d/0x20 [btrfs]
>> [   66.490466]  add_extent_mapping+0x1e0/0x2f0 [btrfs]
>> [   66.514097]  read_one_chunk+0x33c/0x420 [btrfs]
>> [   66.534976]  btrfs_read_chunk_tree+0x6a4/0x870 [btrfs]
>> [   66.555718]  ? kvm_sched_clock_read+0x18/0x40
>> [   66.575758]  open_ctree+0xb32/0x1734 [btrfs]
>> [   66.595272]  ? bdi_register_va+0x1b/0x20
>> [   66.614638]  ? super_setup_bdi_name+0x79/0xd0
>> [   66.633809]  btrfs_mount_root.cold+0x12/0xeb [btrfs]
>> [   66.652938]  ? __kmalloc_track_caller+0x217/0x3b0
>> [   66.671925]  legacy_get_tree+0x34/0x60
>> [   66.690300]  vfs_get_tree+0x2d/0xc0
>> [   66.708221]  vfs_kern_mount.part.0+0x78/0xc0
>> [   66.725808]  vfs_kern_mount+0x13/0x20
>> [   66.742730]  btrfs_mount+0x11f/0x3c0 [btrfs]
>> [   66.759350]  ? kfree+0x5ff/0x670
>> [   66.775441]  ? __kmalloc_track_caller+0x217/0x3b0
>> [   66.791750]  legacy_get_tree+0x34/0x60
>> [   66.807494]  vfs_get_tree+0x2d/0xc0
>> [   66.823349]  path_mount+0x48c/0xd30
>> [   66.838753]  __x64_sys_mount+0x108/0x140
>> [   66.854412]  do_syscall_64+0x38/0x50
>> [   66.869673]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>> [   66.885093] RIP: 0033:0x7f0138827f6e
>> [   66.899790] Code: 48 8b 0d 05 0f 0c 00 f7 d8 64 89 01 48 83 
>> c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca 
>> b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d2 
>> 0e 0c 00 f7 d8 64 89 01 48
>> [   66.945613] RSP: 002b:00007ffecd79edf8 EFLAGS: 00000246 
>> ORIG_RAX: 00000000000000a5
>> [   66.977214] RAX: ffffffffffffffda RBX: 00007f013894c264 RCX: 
>> 00007f0138827f6e
>> [   66.994266] RDX: 00005593a4a41360 RSI: 00005593a4a33690 RDI: 
>> 00005593a4a3a6c0
>> [   67.011544] RBP: 00005593a4a33440 R08: 0000000000000000 R09: 
>> 0000000000000001
>> [   67.028836] R10: 0000000000000000 R11: 0000000000000246 R12: 
>> 0000000000000000
>> [   67.045812] R13: 00005593a4a3a6c0 R14: 00005593a4a41360 R15: 
>> 00005593a4a33440
>> [   67.062965] Modules linked in: loop btrfs(O) blake2b_generic 
>> xor zstd_compress nls_iso8859_1 nls_cp437 vfat fat raid6_pq 
>> joydev mousedev crct10dif_pclmul psmouse crc32_pclmul 
>> crc32c_intel ghash_clmulni_intel aesni_intel glue_helper 
>> crypto_simd cryptd pcspkr rtc_cmos evdev intel_agp intel_gtt 
>> qemu_fw_cfg drm agpgart ip_tables x_tables xfs virtio_balloon 
>> virtio_console virtio_net net_failover failover dm_mod sd_mod 
>> hid_generic usbhid hid uhci_hcd serio_raw atkbd libps2 ahci 
>> libahci ehci_pci ehci_hcd libata usbcore scsi_mod virtio_pci 
>> virtio_ring usb_common virtio i8042 serio
>> [   67.216138] ---[ end trace e114b111db64298c ]---
>> [   67.237089] RIP: 0010:extent_io_tree_panic.isra.0+0x23/0x25 
>> [btrfs]
>> [   67.258567] Code: 9e c0 e8 d1 ff ff ff 0f 1f 44 00 00 55 89 
>> f1 49 c7 c0 70 ae 9e c0 ba a7 02 00 00 48 c7 c6 00 b5 9d c0 48 
>> 89 e5 e8 15 a0 ff ff <0f> 0b 42 8d 14 10 4c 89 4d a8 89 c1 81 
>> fa 00 10 00 00 89 45 b0 44
>> [   67.325317] RSP: 0018:ffff93e5414c3948 EFLAGS: 00010246
>> [   67.347946] RAX: 0000000000000000 RBX: 0000000001bfffff RCX: 
>> 0000000000000000
>> [   67.371343] RDX: 0000000000000000 RSI: ffffffffb90d4660 RDI: 
>> 00000000ffffffff
>> [   67.394757] RBP: ffff93e5414c3948 R08: 0000000000000001 R09: 
>> 0000000000000001
>> [   67.418409] R10: ffff93e5414c3658 R11: 0000000000000000 R12: 
>> ffff8ec782d728c0
>> [   67.441906] R13: ffff8ec78bc71628 R14: ffff8ec782d72aa0 R15: 
>> 0000000002400000
>> [   67.465436] FS:  00007f01386a8580(0000) 
>> GS:ffff8ec809000000(0000) knlGS:0000000000000000
>> [   67.511660] CS:  0010 DS: 0000 ES: 0000 CR0: 
>> 0000000080050033
>> [   67.535047] CR2: 00007f01382fa000 CR3: 0000000109a34000 CR4: 
>> 0000000000750ee0
>> [   67.558449] PKRU: 55555554
>> [   67.581146] note: mount[613] exited with preempt_count 2
>> ========================================================================
>> The image has a chunk item which has a logical start 37748736 
>> and length
>> 18446744073701163008. The calculated end 29360127 is overflowed 
>> obviously.
>> -EEXIST was caught by insert_state() because of the duplicate 
>> end and
>> extent_io_tree_panic() was called.
>> Add overflow check of chunk item end in tree checker then the 
>> image will
>> be rejected to be mounted.
>> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=208929
>> Signed-off-by: Su Yue <l@damenly.su>
>> ---
>>   fs/btrfs/tree-checker.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
>> index 028e733e42f3..39c65c1cbe96 100644
>> --- a/fs/btrfs/tree-checker.c
>> +++ b/fs/btrfs/tree-checker.c
>> @@ -760,6 +760,7 @@ int btrfs_check_chunk_valid(struct 
>> extent_buffer *leaf,
>>   {
>>   	struct btrfs_fs_info *fs_info = leaf->fs_info;
>>   	u64 length;
>> +	u64 chunk_end;
>>   	u64 stripe_len;
>>   	u16 num_stripes;
>>   	u16 sub_stripes;
>> @@ -814,6 +815,12 @@ int btrfs_check_chunk_valid(struct 
>> extent_buffer *leaf,
>>   			  "invalid chunk length, have %llu", length);
>>   		return -EUCLEAN;
>>   	}
>> +	if (unlikely(check_add_overflow(logical, length, 
>> &chunk_end))) {
>> +		chunk_err(leaf, chunk, logical,
>> +			  "invalid chunk logical/length, have logical %llu 
>> length %llu",
>> +			  logical, length);
>> +		return -EUCLEAN;
>> +	}
>>   	if (unlikely(!is_power_of_2(stripe_len) || stripe_len != 
>>   BTRFS_STRIPE_LEN)) {
>>   		chunk_err(leaf, chunk, logical,
>>   			  "invalid chunk stripe length: %llu",
>>
>
> So this is a system chunk? It is not so evident from the trace 
> above.
>
It's a chunk item located in chunk tree leaf, not in system chunk 
array.
Tree checker checks chunk items in both locations.

Thanks.
> Thanks, Anand
