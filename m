Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A34624022C
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Aug 2020 09:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725873AbgHJHD2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Aug 2020 03:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbgHJHD2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Aug 2020 03:03:28 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3694AC061756
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Aug 2020 00:03:28 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id b2so3752593qvp.9
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Aug 2020 00:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dallalba.com.ar; s=google;
        h=message-id:subject:from:to:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=BuDUPhWlITXM9jg5ruMt07RQnHCdlUOiW/Yo1LkIFUw=;
        b=LE6EzlyXkNiovAK5W+1zB8WzffWqEt9664hCoAvly2TsseRZVFxkcAPdNY7jFErnVs
         qxsvlsjOiEq/6DhgB75FX9OVHQwlKZHTCWgUXYWXx9tbyDtE8i9DDmIYFCMjYc+2DG60
         E9M/BmZYE3hkXdTwfF0L3dh3K8TC0rS/URxPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=BuDUPhWlITXM9jg5ruMt07RQnHCdlUOiW/Yo1LkIFUw=;
        b=cjL3f/H2B6Y6g0sEiMhUSJ3KSD9zEqOwqjZfH61lUnZ5c17aVvjsspheR5vOsYs014
         XgfDEfCQTJrsQXKHAHnjNjUYjJ/3Z8rwPsRH32k1c4bPWm4qHF/MehZVLy2ffH7OwsZH
         4gyZTGsop2BWOwsSBv8pv5yzU0ilS3uzl+zMYTXO9AjFueOLEk8fs7oS0kRofS7JpwGa
         eGwJ3TiGc8FAhiorKg3+gmanOW00aAkCA1lTftbECOie1o5AB7T8ZIDQ4+7gvJi6jDhU
         1EbZNNcmCr2EQLGPa9uyCekBbjkbVVYAkg4lwXC+O8JCCmuoa1JrjA23eGVEC8oFLtIr
         K3wg==
X-Gm-Message-State: AOAM531NyyVJbjuWQfLkhyZywiu9ulvcksvb/1jFmh+09m+El8+rZ7g8
        w7bu0l9BSmkEeWhDj658pzU43H01Lg==
X-Google-Smtp-Source: ABdhPJxpRj7UnBaG64ckOrjhRhdwmcbMPEy8VyKl8nf3iPbm9PccpLfQzSXHAcUkqe0FlUZcsMGdIQ==
X-Received: by 2002:a0c:b599:: with SMTP id g25mr27252900qve.118.1597043006753;
        Mon, 10 Aug 2020 00:03:26 -0700 (PDT)
Received: from atomica ([2803:9800:a011:8d29:a588:5e7f:26f:986])
        by smtp.gmail.com with ESMTPSA id i65sm13500726qkf.126.2020.08.10.00.03.25
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 00:03:26 -0700 (PDT)
Message-ID: <3dc4d28e81b3336311c979bda35ceb87b9645606.camel@dallalba.com.ar>
Subject: raid10 corruption while removing failing disk
From:   =?UTF-8?Q?Agust=C3=ADn_Dall=CA=BCAlba?= <agustin@dallalba.com.ar>
To:     linux-btrfs@vger.kernel.org
Date:   Mon, 10 Aug 2020 04:03:24 -0300
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello!

The last quarterly scrub on our btrfs filesystem found a few bad
sectors in one of its devices (/dev/sdd), and because there's nobody on
site to replace the failing disk I decided to remove it from the array
with `btrfs device remove` before the problem could get worse.

The removal was going relatively well (although slowly and I had to
reboot a few times due to the bad sectors) until it had about 200 GB
left to move. Now the filesystem turns read only when I try to finish
the removal and `btrfs check` complains about wrong metadata checksums.
However as far as I can tell none of the copies of the corrupt data are
in the failing disk.

How could this happen? Is it possible to fix this filesystem?

I have refrained from trying anything so far, like upgrading to a newer
kernel or disconnecting the failing drive, before confirming with you
that it's safe.

Kind regards.


# uname -a
Linux susanita 4.15.0-111-generic #112-Ubuntu SMP Thu Jul 9 20:32:34
UTC 2020 x86_64 x86_64 x86_64 GNU/Linux


# btrfs --version
btrfs-progs v4.15.1


# btrfs fi show
Label: 'Susanita'  uuid: 4d3acf20-d408-49ab-b0a6-182396a9f27c
	Total devices 5 FS bytes used 4.90TiB
	devid    1 size 3.64TiB used 3.42TiB path /dev/sda
	devid    2 size 3.64TiB used 3.42TiB path /dev/sde
	devid    3 size 1.82TiB used 1.59TiB path /dev/sdb
	devid    5 size 0.00B used 185.50GiB path /dev/sdd
	devid    6 size 1.82TiB used 1.22TiB path /dev/sdc


# btrfs fi df /
Data, RAID1: total=4.90TiB, used=4.90TiB
System, RAID10: total=64.00MiB, used=880.00KiB
Metadata, RAID10: total=9.00GiB, used=7.57GiB
GlobalReserve, single: total=512.00MiB, used=0.00B


# btrfs check --force --readonly /dev/sda
WARNING: filesystem mounted, continuing because of --force
Checking filesystem on /dev/sda
UUID: 4d3acf20-d408-49ab-b0a6-182396a9f27c
checksum verify failed on 10919566688256 found BAB1746E wanted A8A48266
checksum verify failed on 10919566688256 found BAB1746E wanted A8A48266
bytenr mismatch, want=10919566688256, have=17196831625821864417
ERROR: failed to repair root items: Input/output error

# btrfs-map-logical -l 10919566688256 /dev/sda
mirror 1 logical 10919566688256 physical 394473357312 device /dev/sdc
mirror 2 logical 10919566688256 physical 477218586624 device /dev/sda


Relevant dmesg output:
[    4.963420] Btrfs loaded, crc32c=crc32c-generic
[    5.072878] BTRFS: device label Susanita devid 6 transid 4241535 /dev/sdc
[    5.073165] BTRFS: device label Susanita devid 3 transid 4241535 /dev/sdb
[    5.073713] BTRFS: device label Susanita devid 2 transid 4241535 /dev/sde
[    5.073916] BTRFS: device label Susanita devid 5 transid 4241535 /dev/sdd
[    5.074398] BTRFS: device label Susanita devid 1 transid 4241535 /dev/sda
[    5.152479] BTRFS info (device sda): disk space caching is enabled
[    5.152551] BTRFS info (device sda): has skinny extents
[    5.332538] BTRFS info (device sda): bdev /dev/sdd errs: wr 0, rd 24, flush 0, corrupt 0, gen 0
[   38.869423] BTRFS info (device sda): enabling auto defrag
[   38.869490] BTRFS info (device sda): use lzo compression, level 0
[   38.869547] BTRFS info (device sda): disk space caching is enabled


After running btrfs device remove /dev/sdd /:
[  193.684703] BTRFS info (device sda): relocating block group 10593404846080 flags metadata|raid10
[  312.921934] BTRFS error (device sda): bad tree block start 10597444141056 10919566688256
[  313.034339] BTRFS error (device sda): bad tree block start 17196831625821864417 10919566688256
[  313.034595] BTRFS error (device sda): bad tree block start 10597444141056 10919566688256
[  313.034621] BTRFS: error (device sda) in btrfs_run_delayed_refs:3083: errno=-5 IO failure
[  313.034627] BTRFS info (device sda): forced readonly
[  313.036328] BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
[  313.036596] IP: merge_reloc_roots+0x19f/0x2c0 [btrfs]
[  313.036650] PGD 0 P4D 0 
[  313.036704] Oops: 0000 [#1] SMP PTI
[  313.036756] Modules linked in: veth nft_fib_ipv4 nft_fib nft_ct nft_meta nf_tables_ipv4 nf_tables nfnetlink wireguard ip6_udp_tunnel udp_tunnel tcp_lp i2c_i801 8021q garp mrp bridge stp llc nfsd auth_rpcgss nfs_acl ipt_MASQUERADE nf_nat_masquerade_ipv4 xt_nat iptable_nat nf_nat_ipv4 nf_nat xt_DSCP xt_TCPMSS iptable_mangle ipt_REJECT nf_reject_ipv4 nf_log_ipv4 nf_log_common xt_LOG xt_limit xt_comment xt_tcpudp lockd nf_conntrack_ipv4 nf_defrag_ipv4 xt_multiport xt_conntrack nf_conntrack iptable_filter grace sunrpc input_leds shpchp intel_powerclamp serio_raw lpc_ich mac_hid e752x_edac tcp_bbr sch_fq_codel ib_iser rdma_cm iw_cm ib_cm ib_core iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi lm85 hwmon_vid ip_tables x_tables autofs4 btrfs zstd_compress raid10 raid456 async_raid6_recov async_memcpy
[  313.037035]  async_pq async_xor async_tx xor raid6_pq libcrc32c raid1 raid0 multipath linear mpt3sas 8139too 8139cp pata_acpi mii raid_class sky2 scsi_transport_sas
[  313.037156] CPU: 0 PID: 1173 Comm: btrfs Not tainted 4.15.0-111-generic #112-Ubuntu
[  313.037230] Hardware name:  /SE7525RP2, BIOS SE7525RP20.86B.P.05.00.0020.121620050818 12/16/2005
[  313.037390] RIP: 0010:merge_reloc_roots+0x19f/0x2c0 [btrfs]
[  313.037452] RSP: 0018:ffff98ff4080faf8 EFLAGS: 00010246
[  313.037516] RAX: 0000000000000000 RBX: ffff8dd5b656b000 RCX: 0000000000000000
[  313.037582] RDX: ffff8dd576745800 RSI: 00000000000027e6 RDI: ffff8dd5733a0078
[  313.037658] RBP: ffff98ff4080fb58 R08: ffff8dd5b0c51240 R09: ffff8dd576745800
[  313.037718] R10: 0000000000000040 R11: 0000000000000000 R12: ffff8dd5b656a000
[  313.037777] R13: ffff98ff4080fb18 R14: ffff8dd576745800 R15: ffff8dd5b656b3a0
[  313.037839] FS:  00007f1d2da398c0(0000) GS:ffff8dd5bfc00000(0000) knlGS:0000000000000000
[  313.037912] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  313.037971] CR2: 0000000000000000 CR3: 00000000359c8000 CR4: 00000000000006f0
[  313.038035] Call Trace:
[  313.038153]  relocate_block_group+0x17a/0x640 [btrfs]
[  313.038266]  btrfs_relocate_block_group+0x18f/0x280 [btrfs]
[  313.038377]  btrfs_relocate_chunk+0x38/0xd0 [btrfs]
[  313.038488]  btrfs_shrink_device+0x1d1/0x560 [btrfs]
[  313.038597]  btrfs_rm_device+0x19e/0x590 [btrfs]
[  313.038676]  ? _copy_from_user+0x3e/0x60
[  313.038787]  btrfs_ioctl+0x221c/0x2490 [btrfs]
[  313.038850]  ? _copy_to_user+0x26/0x30
[  313.038914]  ? cp_new_stat+0x152/0x180
[  313.038977]  do_vfs_ioctl+0xa8/0x630
[  313.039082]  ? btrfs_ioctl_get_supported_features+0x30/0x30 [btrfs]
[  313.039146]  ? do_vfs_ioctl+0xa8/0x630
[  313.039206]  ? SYSC_newstat+0x50/0x70
[  313.039266]  SyS_ioctl+0x79/0x90
[  313.039337]  do_syscall_64+0x73/0x130
[  313.039410]  entry_SYSCALL_64_after_hwframe+0x41/0xa6
[  313.039476] RIP: 0033:0x7f1d2c81b6d7
[  313.039533] RSP: 002b:00007ffc0c0bee08 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[  313.039606] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f1d2c81b6d7
[  313.039661] RDX: 00007ffc0c0bfe28 RSI: 000000005000943a RDI: 0000000000000003
[  313.039717] RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
[  313.039772] R10: 00007ffc0c0c3e80 R11: 0000000000000246 R12: 00007ffc0c0c0f78
[  313.039829] R13: 0000000000000000 R14: 0000000000000003 R15: 0000000000000003
[  313.039884] Code: 08 4c 89 f7 e8 a3 47 ae d5 49 8b 17 49 8b 47 08 48 89 42 08 48 89 10 4d 89 3f 4d 89 7f 08 e9 53 ff ff ff 49 c7 46 18 00 00 00 00 <48> 8b 3c 25 00 00 00 00 e8 74 9a fc ff 49 8b 56 18 48 8b 7a 08 
[  313.040037] RIP: merge_reloc_roots+0x19f/0x2c0 [btrfs] RSP: ffff98ff4080faf8
[  313.040093] CR2: 0000000000000000
[  313.040192] ---[ end trace c981300ad343d57c ]---
[  313.175005] BTRFS error (device sda): pending csums is 323584


The most recent scrub found no problems except for the failing drive:
# btrfs scrub status -dR /
scrub status for 4d3acf20-d408-49ab-b0a6-182396a9f27c
scrub device /dev/sda (id 1) history
	scrub started at Wed Jul  8 19:53:52 2020 and finished after 10:04:57
	data_extents_scrubbed: 57444761
	tree_extents_scrubbed: 299537
	data_bytes_scrubbed: 3633406001152
	tree_bytes_scrubbed: 4907614208
	read_errors: 0
	csum_errors: 0
	verify_errors: 0
	no_csum: 1894424
	csum_discards: 0
	super_errors: 0
	malloc_errors: 0
	uncorrectable_errors: 0
	unverified_errors: 0
	corrected_errors: 0
	last_physical: 3642413285376
scrub device /dev/sde (id 2) history
	scrub started at Wed Jul  8 19:53:52 2020 and finished after 10:17:31
	data_extents_scrubbed: 57533871
	tree_extents_scrubbed: 88610
	data_bytes_scrubbed: 3636789604352
	tree_bytes_scrubbed: 1451786240
	read_errors: 0
	csum_errors: 0
	verify_errors: 0
	no_csum: 3596495
	csum_discards: 0
	super_errors: 0
	malloc_errors: 0
	uncorrectable_errors: 0
	unverified_errors: 0
	corrected_errors: 0
	last_physical: 3641977077760
scrub device /dev/sdb (id 3) history
	scrub started at Wed Jul  8 19:53:52 2020 and finished after 05:15:48
	data_extents_scrubbed: 25189397
	tree_extents_scrubbed: 210630
	data_bytes_scrubbed: 1633732304896
	tree_bytes_scrubbed: 3450961920
	read_errors: 0
	csum_errors: 0
	verify_errors: 0
	no_csum: 1966272
	csum_discards: 0
	super_errors: 0
	malloc_errors: 0
	uncorrectable_errors: 0
	unverified_errors: 0
	corrected_errors: 0
	last_physical: 1640678555648
scrub device /dev/sdd (id 5) history
	scrub started at Wed Jul  8 19:53:52 2020 and finished after 05:00:15
	data_extents_scrubbed: 25301261
	tree_extents_scrubbed: 298654
	data_bytes_scrubbed: 1632169230336
	tree_bytes_scrubbed: 4893147136
	read_errors: 24
	csum_errors: 0
	verify_errors: 0
	no_csum: 1515107
	csum_discards: 0
	super_errors: 0
	malloc_errors: 0
	uncorrectable_errors: 0
	unverified_errors: 0
	corrected_errors: 24
	last_physical: 1640175239168
scrub device /dev/sdc (id 6) history
	scrub started at Wed Jul  8 19:53:52 2020 and finished after 01:58:45
	data_extents_scrubbed: 8887668
	tree_extents_scrubbed: 298747
	data_bytes_scrubbed: 565333995520
	tree_bytes_scrubbed: 4894670848
	read_errors: 0
	csum_errors: 0
	verify_errors: 0
	no_csum: 1723495
	csum_discards: 0
	super_errors: 0
	malloc_errors: 0
	uncorrectable_errors: 0
	unverified_errors: 0
	corrected_errors: 0
	last_physical: 574989795328


