Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 368056E22E1
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Apr 2023 14:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjDNMMC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Apr 2023 08:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbjDNMMA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Apr 2023 08:12:00 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2247EF1
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Apr 2023 05:11:55 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MLR1f-1q560q2yDz-00ISFg; Fri, 14
 Apr 2023 14:11:52 +0200
Message-ID: <c3bf3d9d-9be4-713f-64b8-769d2a014d1a@gmx.com>
Date:   Fri, 14 Apr 2023 20:11:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
To:     Otto Strassen <otto@tostr.ch>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <sY9YYJrpztwzxhv_9p28An7hkWNiF8hHF0we0ToIQ69b3lpaeBc7l77Kd4jYdsXA6Rps73Xa3guq3XA8c3mZdxDIvSwO5Cyh2eeO5Aqh3-s=@tostr.ch>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Filesystem ro mode, check shows a lot of missing backrefs, no
 idea on how to proceed
In-Reply-To: <sY9YYJrpztwzxhv_9p28An7hkWNiF8hHF0we0ToIQ69b3lpaeBc7l77Kd4jYdsXA6Rps73Xa3guq3XA8c3mZdxDIvSwO5Cyh2eeO5Aqh3-s=@tostr.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:nzhs7PAlCisinkP1PXESw9+YLeQNqTOPikSK4pgTcQRrL0IqWtp
 hGR67RQhLpLGRc2Dhh1Rb0jCfilz9RIcAo3f1r6Yk6F8c6GAYNzGRpp+NCpwoOWkdyOPw1D
 THOGKtCubyZNI4gq0005guxZ44HvNV6YfvDWiXezT+9pXKn+EhXWz1X0ZjUP1uvKo6JO7lJ
 NGWfKsercwcqqjp4nSK7Q==
UI-OutboundReport: notjunk:1;M01:P0:ynL4uxc9A2Q=;tt+m/TTTa3vQ/zpEKeG+3OZkhuX
 FkdyoDhkEZx3oFYXE1hwL8KNq3AVT/jfuOvriDPaAw4N7LLvpTTvPEZ9jWd+OZyLIyohF6suO
 bkwmMyXQFte19rR3BDiuCrrsYEBdYEgaT/KUC3/sleUoyPufeklFy0nQTEveZTn1B12uczinK
 1oeZG7CFuA6Hy2377d7Ri+PDkct2t6E0HMM4ujfd1NbSxfatM4mJqVGh/Sockvv+bTA/SVC7Q
 JQ9v3WImva7mMqDxpfxf6ftxBCQagFO3NgoA1zWzHltEbUl9jiFiYcYdwBwHARI09Vr8shBMH
 smelyFK0G2m4CixnpfKWwlc9P1Ukzg74E/OjXFOnt+idAIp1JWAhsqvpm6+whINOY+DdSLase
 sSxZgxYjeAnalioIm7iSUyCpa5LE81BJ6AA2tdTMlBcmrkOKhKXtXCwlgkCQ/eZm+dkfr96gT
 0alTgNY5Uguyw7ZnpDMi+6YP2J8Y46CFqAp5sv2C1RHb1lYdvx30TvUnhBLA5X5i+5RZ8BU/l
 YTB/7W90ZzlChvGE5lJ7tSAKztVJu2ttHTGwgmn+Claq7tVTIAOz2XpzSRMCypUUN0hNUCGZ9
 KUFVHHIu1OdpoAiAi6X8F3Gsdb/5qEtVQsiFtXbxvkBeOGyGwFB1R27gE2uWltSrbMjPfxezj
 uKIoIJYnUfbmrc46XWIaFcS4eyhus3w1+WQlMPmfzjDv0Ar57ukiY0EnfqdgVw99JZdnWuD+J
 W068fVQBrzSTKP7u9s0fOVmme3I7g8/6idyS7fUbm5WbMjz+2wTmOeXVBDRY7/TjDutCk/MPP
 95WgNRom1iGW6Ov+n8LBYjeGfFfDmw+xZL41CdUOo8pSTXQXBPFHqkPsaoE3BeP4X2BwinNs7
 pps1hJy+tXRfp5VLBrQ9/gamiCjBp8Oai2NKHjFkJtwWY3RA+So0Z4NLmYchDmKKU/Y8pHIPx
 VRbNXna7ClJW6kTTd4maeREFJwI=
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/4/14 19:33, Otto Strassen wrote:
> Hi
> 
> I am the sysadmin for a small nonprofit library/archive, and we store physical media (books, posters etc.) as well as a lot of data (the catalogue database itself, digitalised movies, recordings etc.). Now the budget is tight, while the amount of data is high-ish and the expectations are "archival" storage. So avoiding data rot is important.
> 
> So, our solution to the problem was to buy a Synology (DS1821+) which supports btrfs. We have 8 HDDs (10.9TB reported size), and 2 SSDs for caching.
> 
> The setup is the following: HDD -> MD(RAID 6) -> LVM (2 volumes) -> btrfs on each volume
> 
> A couple days ago 'volume 1', which is the big storage we actually use in day-to-day operation (~60TB capacity, about 18TB used) switched to 'ro' mode. I have been trying to fix that ever since, and will give an overview of the steps taken as well as the results so far. I am unsure how much difference exists between the synology provided btrfs and mainline, but maybe someone here will be better able to assess that.
> 
> Currently we are looking to do a restore, but this is time intensive, and I am also worried that this problem might happen again. My gut tells me that there is probably faulty hardware somewhere, but all tests came up fine so far.
> 
> I hope that maybe someone can help provide a bit of insight on how to proceed, what we are dealing with and how to avoid this in the future.
> 
> Some notes:
> - Quick SMART is clean for all drives
> - Extended SMART I will try to run this weekend
> - No power-loss happened prior to this
> - mdadm shows no problems whatsoever
> - I tried to zero-log, but that failed due to a missing 'ctree-something' (might also have been 'btree-something', but I did not save the output)
> - super-recover claims nothing to do, all is fine
> - I have considered --init-csum-tree and even more --init-extent-tree, but given the potential runtime of these and unknown benefit I have refrained from doing so
> - LVM looks fine as well
> - memtest (there is one provided by synology) comes up clean, the memory is branded synology, and we have 2x16GB
> - All problems so far only happen on volume1, volume2 (which is not used right now, but formatted and ready) has the same exact underlying hardware/setup
> 
> 
> The relevant versions of the affected components:
> 
> $ btrfs --version
> btrfs-progs v4.0
> 
> $ uname -srm
> Linux 4.4.180+ x86_64

Although Synology is a great contributor to btrfs, their kernel and 
progs can sometimes be very old and heavily backported, thus from 
upstream point of view, it's not the best situation to go.

So is the btrfs-progs.

> 
> Synology: DSM 7.1.1-42962 Update 4
> 
> 
> $ btrfs scrub start -Bdr /volume1
> scrub status for c14c923f-2038-4841-aa89-504f1044d3be
> scrub device /dev/mapper/cachedev_0 (id 1) history
>          scrub started at Tue Apr 11 18:35:45 2023 and finished after 04:11:48
>          total bytes scrubbed: 18.58TiB with 0 errors
> 
> $ btrfs fi show /volume1
> Label: '2022.05.04-10:06:00 v42218'  uuid: c14c923f-2038-4841-aa89-504f1044d3be
>          Total devices 1 FS bytes used 18.58TiB
>          devid    1 size 64.48TiB used 18.63TiB path /dev/mapper/cachedev_0
> 
> $ btrfs device stats /volume1
> [/dev/mapper/cachedev_0].write_io_errs   0
> [/dev/mapper/cachedev_0].read_io_errs    0
> [/dev/mapper/cachedev_0].flush_io_errs   0
> [/dev/mapper/cachedev_0].corruption_errs 0
> [/dev/mapper/cachedev_0].generation_errs 0
> 
> 
> I was able to get the volume into a working order with this (the clear_cache is what makes the difference here):
> $ mount -o remount,rw,clear_cache /volume1

No, it should not work, and it looks like a bug that older kernel can 
allow RW mount after transaction abort.
Which can cause further problems.

So in short, if you hit such sudden RO, do not try any thing RW.
Btrfs flops to read-only to prevent further corruption, doing the 
opposite thing is not that helpful.

> 
> The device is mounted like this now, normally is would not have clear_cache and space_cache=v2
> $ mount | grep volume1
> /dev/mapper/cachedev_0 on /volume1 type btrfs (rw,nodev,relatime,ssd,synoacl,nospace_cache,clear_cache,auto_reclaim_space,metadata_ratio=50,block_group_cache_tree,syno_allocator,subvolid=256,subvol=/@syno)
> 
> However, as soon as the device does a backup at night (just a couple of MB of data), it ends up in a 'ro' state again.
> 
> The fsck from btrfs shows a lot of errors (about 50k lines). How these errors came to be, and how severe they are is currently not clear. These errors persist regardless of the volume being currently broken or not.
> 
> $ btrfs check -p /dev/mapper/cachedev_0
> Syno caseless feature on.
> checking extents
> ref mismatch on [4184732463104 4096] extent item 2, found 1
> Incorrect local backref count on 4184732463104 parent 19908052926464 owner 0 offset 0 found 0 wanted 1 back 0x55f31169f400
> Backref disk bytenr does not match extent record, bytenr=4184732463104, ref bytenr=0
> backpointer mismatch on [4184732463104 4096]
> ref mismatch on [8291880861696 16384] extent item 3, found 1
> Backref 8291880861696 root 2315 not referenced back 0x55f306f5c270
> Backref 8291880861696 root 2711 not referenced back 0x55f306f5c2a0
> Incorrect global backref count on 8291880861696 found 3 wanted 1
> <--- skip 50k similar lines --->
> Backref 21189054693376 root 2763 not referenced back 0x55f306859410
> Incorrect global backref count on 21189054693376 found 4 wanted 0
> backpointer mismatch on [21189054693376 16384]
> owner ref check failed [21189054693376 16384]

Extent tree corruption.

> Syno block group cache is sync
> checking free space tree
> checking fs roots

Subvolume trees looks fine, which means the files and its contents 
should be fine.

But considering the version (btrfs-progs 4.0), I'm not that confident.

Would you please boot into some newer distros (Archlinux or OpenSUSE 
tumbleweed etc), and run "btrfs check --readonly" on the fs?

> warning line 4386
> checking csums
> checking root refs
> Checking filesystem on /dev/mapper/cachedev_0
> UUID: c14c923f-2038-4841-aa89-504f1044d3be
> found 20423782981633 bytes used err is 0
> total csum bytes: 938305868
> total tree bytes: 2463318016
> total fs tree bytes: 1220673536
> total extent tree bytes: 176783360
> btree space waste bytes: 332682766
> file data blocks allocated: 21039730896896
>   referenced 20420441374720
> 
> One error that only happens when the volume goes into 'ro' mode can be found in the kernel log.
> 
> $ cat /var/log/kern.log
> 2023-04-08T03:14:46+02:00 Windhoek kernel: [453142.491317] ------------[ cut here ]------------
> 2023-04-08T03:14:46+02:00 Windhoek kernel: [453142.491324] BTRFS: error (device dm-3) in __btrfs_inc_extent_ref:2388: errno=-17 Object already exists
> 2023-04-08T03:14:46+02:00 Windhoek kernel: [453142.491328] BTRFS: error (device dm-3) in __btrfs_inc_extent_ref:2388: errno=-17 Object already exists

Yeah, extent tree corruption, some backref, which should not exist, 
exists by somehow. (I believe it's a fixed btrfs bug, but no clue 
considering how old the kernel is)
This matches with the btrfs check report.

For now, the safest method is to mount the fs ro, and copy out all the data.
If the old btrfs-progs is trustworthy, you should get everything without 
any problem.

Then if you feel like to enjoy an adventure, you can go newer 
btrfs-progs from some other distros, and try "btrfs check --repair".

I don't have the full "btrfs check --readonly" output, but so far the 
extent tree corruption looks more or less fixable.

But still, after "btrfs check --repair" it's still recommended to run 
"btrfs check --readonly" on the fs to see if the errors at least reduced.

If you're lucky enough, after "btrfs check --repair", no more errors 
from "btrfs check --readonly", you're able to continue use the fs 
without any data loss.

But I would still strongly recommend to go a newer enough (5.15 at 
least) kernel and progs.

Thanks,
Qu
> 2023-04-08T03:14:46+02:00 Windhoek kernel: [453142.491332] BTRFS: error (device dm-3) in btrfs_run_delayed_refs_and_get_processed:3489: errno=-17 Object already exists
> 2023-04-08T03:14:46+02:00 Windhoek kernel: [453142.4913 34] BTRFS: error (device dm-3) in btrfs_run_delayed_refs_and_get_processed:3489: errno=-17 Object already exists
> 2023-04-08T03:14:46+02:00 Windhoek kernel: [453142.541893] WARNING: CPU: 2 PID: 19064 at fs/btrfs/extent-tree.c:2388 __btrfs_inc_extent_ref+0x250/0x320 [btrfs]()
> 2023-04-08T03:14:46+02:00 Windhoek kernel: [453142.552326] Modules linked in: tun nf_conntrack_ipv6 ip6table_filter ip6_tables ipt_MASQUERADE xt_REDIRECT nf_nat_masquerade_ipv4 xt_nat iptable_nat nf_nat_ipv4 nf_nat_redirect nf_nat xt_recent xt_iprange xt_limit xt_state xt_multiport xt_LOG nf_conntrack_ipv4 nf_defrag_ipv4 xt_tcpudp iptable_filter ip_tables x_tables fuse 8021q vfat fat vhost_scsi(O) vhost(O) tcm_loop(O) iscsi_target_mod(O) target_core_user(O) target_core_ep(O) target_core_multi_file(O) target_core_file(O) target_core_iblock(O) target_core_mod(O) syno_extent_pool(PO) rodsp_ep(O) udf isofs synoacl_vfs(PO) btrfs ecryptfs zstd_decompress zstd_compress xxhash raid456 async_raid6_recov async_memcpy async_pq async_xor xor async_tx raid6_pq openvswitch gre bnxt_en(O) nf_defrag_ipv6 leds_lp3943 nf_conntrack aesni_intel glue_helper lrw gf128mul
> 2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.624953]  ablk_helper v1000_synobios(PO) hid_generic usbhid hid usblp adt7475 hwmon_vid etxhci_hcd usb_storage bnx2x(O) mdio qede(O) qed(O) mlx5_core(O) mlx4_en(O) mlx4_core(O) mlx_compat(O) atlantic_v2(O) atlantic(O) r8168(O) zram i40e(O) ixgbe(O) amd_xgbe marvell10g sg dm_snapshot dm_bufio crc_itu_t crc_ccitt psnap p8022 llc hfsplus md4 hmac sit tunnel4 ipv6 flashcache_syno(O) flashcache(O) syno_flashcache_control(O) dm_mod arc4 crc32c_intel cryptd ecb aes_x86_64 authenc des_generic ansi_cprng cts md5 cbc cpufreq_powersave cpufreq_performance acpi_cpufreq processor cpufreq_stats vxlan ip6_udp_tunnel udp_tunnel ip_tunnel loop sha256_generic synorbd(PO) synofsbd(PO) xhci_pci xhci_hcd uhci_hcd ehci_pci ehci_hcd usbcore usb_common mv14xx(O) [last unloaded: nf_defrag_ipv4]
> 2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.694014] CPU: 2 PID: 19064 Comm: kworker/u16:0 Tainted: P        W  O    4.4.180+ #42962
> 2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.702444] Hardware name: Synology Inc. DS1821+/Bilby, BIOS M.209.00 08/05/2020
> 2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.709941] Workqueue: btrfs-extent-refs btrfs_extent_refs_helper [btrfs]
> 2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.716836]  0000000000000000 ffff880271673a60 ffffffff812e2d5b 0000000000000009
> 2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.724425]  ffff880271673aa8 ffff880271673a98 ffffffff81056522 ffff880704b68908
> 2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.731996]  00000000ffffffef 0000000000000a4a ffff8807f838ccb0 0000000000003325
> 2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.739567] Call Trace:
> 2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.742111]  [<ffffffff812e2d5b>] dump_stack+0x4d/0x72
> 2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.747340]  [<ffffffff81056522>] warn_slowpath_common+0x82/0xa0
> 2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.753429]  [<ffffffff81056587>] warn_slowpath_fmt+0x47/0x50
> 2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.759272]  [<ffffffffa10ff8a7>] ? insert_tree_block_ref+0x47/0x60 [btrfs]
> 2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.766327]  [<ffffffffa11067f0>] __btrfs_inc_extent_ref+0x250/0x320 [btrfs]
> 2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.773487]  [<ffffffffa110abfa>] __btrfs_run_delayed_refs+0x13ea/0x18c0 [btrfs]
> 2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.780987]  [<ffffffffa1108a7b>] ? btrfs_block_rsv_check+0x1b/0x60 [btrfs]
> 2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.788044]  [<ffffffffa110e993>] btrfs_run_delayed_refs_and_get_processed+0xc3/0x4b0 [btrfs]
> 2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.796668]  [<ffffffffa112a465>] ? start_transaction+0x95/0x460 [btrfs]
> 2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.803464]  [<ffffffffa110ee35>] delayed_ref_async_start+0xb5/0x100 [btrfs]
> 2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.810612]  [<ffffffffa1162496>] btrfs_worker_helper+0xc6/0x390 [btrfs]
> 2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.817413]  [<ffffffffa11628a9>] btrfs_extent_refs_helper+0x9/0x10 [btrfs]
> 2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.824460]  [<ffffffff810768da>] worker_run_work+0x9a/0xe0
> 2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.830139]  [<ffffffffa11628a0>] ? btrfs_usrquota_rescan_helper+0x10/0x10 [btrfs]
> 2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.837797]  [<ffffffff8106e67b>] process_one_work+0x1db/0x4e0
> 2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.843719]  [<ffffffff8106e9ad>] worker_thread+0x2d/0x4a0
> 2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.849296]  [<ffffffff8106e980>] ? process_one_work+0x4e0/0x4e0
> 2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.855391]  [<ffffffff81072d73>] kthread+0xd3/0xf0
> 2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.860357]  [<ffffffff81072ca0>] ? kthread_worker_fn+0x160/0x160
> 2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.866539]  [<ffffffff81571def>] ret_from_fork+0x3f/0x80
> 2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.872027]  [<ffffffff81072ca0>] ? kthread_worker_fn+0x160/0x160
> 2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.878220] ---[ end trace 11b6552e7d6527ab ]---
> --- skip ---
> 2023-04-11T08:28:25+02:00 Windhoek kernel: [731152.211084] BTRFS error (device dm-3): Remounting read-write after error is not allowed
> 2023-04-11T08:28:25+02:00 Windhoek kernel: [731152.352390] BTRFS error (device dm-3): cleaner transaction attach returned -30
> --- skip ---
> 2023-04-11T23:56:06+02:00 Windhoek kernel: [  619.485264] BTRFS: error (device dm-3) in __btrfs_inc_extent_ref:2388: errno=-17 Object already exists
> 2023-04-11T23:56:06+02:00 Windhoek kernel: [  619.499619] BTRFS: error (device dm-3) in btrfs_run_delayed_refs_and_get_processed:3489: errno=-17 Object already exists
> 2023-04-11T23:56:06+02:00 Windhoek kernel: [  619.510480] BTRFS: error (device dm-3) in btrfs_drop_snapshot:12020: errno=-17 Object already exists
> 2023-04-11T23:56:06+02:00 Windhoek kernel: [  619.519614] BTRFS: error (device dm-3) in btrfs_drop_snapshot:12205: errno=-17 Object already exists
> 2023-04-11T23:58:17+02:00 Windhoek kernel: [  750.742562] BTRFS error (device dm-3): Remounting read-write after error is not allowed
> 2023-04-11T23:58:19+02:00 Windhoek kernel: [  752.504619] BTRFS error (device dm-3): cleaner transaction attach returned -30
> 
> 
> Thanks and best
> Otto
