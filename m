Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A325C6E3160
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Apr 2023 14:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjDOM1b (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 15 Apr 2023 08:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjDOM1a (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 15 Apr 2023 08:27:30 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F383C3AB7
        for <linux-btrfs@vger.kernel.org>; Sat, 15 Apr 2023 05:27:27 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MowGU-1q7t3K0IhC-00qUAu; Sat, 15
 Apr 2023 14:27:24 +0200
Message-ID: <fb3714a3-ab30-30b0-f336-68e2717b20d8@gmx.com>
Date:   Sat, 15 Apr 2023 20:27:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
To:     Otto Strassen <otto@tostr.ch>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <sY9YYJrpztwzxhv_9p28An7hkWNiF8hHF0we0ToIQ69b3lpaeBc7l77Kd4jYdsXA6Rps73Xa3guq3XA8c3mZdxDIvSwO5Cyh2eeO5Aqh3-s=@tostr.ch>
 <c3bf3d9d-9be4-713f-64b8-769d2a014d1a@gmx.com>
 <BWQf5N5kpHk5W540zTSqzDYn2kLi7lwJt-3odaRz1xs751TcwplGjnVGU-ytnar_lcoaKZHghhONSHAdSPtC98yyq52HXIUTCq1x65RWGwU=@tostr.ch>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Filesystem ro mode, check shows a lot of missing backrefs, no
 idea on how to proceed
In-Reply-To: <BWQf5N5kpHk5W540zTSqzDYn2kLi7lwJt-3odaRz1xs751TcwplGjnVGU-ytnar_lcoaKZHghhONSHAdSPtC98yyq52HXIUTCq1x65RWGwU=@tostr.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:q/2yRAuw0a2l55MMwIvHtvSkKF2g/ZzW7bMR9hiUJHUh5AXSTj6
 0j0bKiV+k8m1rhyLmZTU1cGzjhrgr5VfNDFLu77PY2t7zzuXv6OHg937O9sJHB+qS9QJrsA
 DnEiJORcr8gDG8MWPFUeG6UQED5liw2W3H9aAkLShC/A74gexeEkLx1Sd3GlNA/3Nxjpjaq
 /AieLaXdvrzGFHPSh31ww==
UI-OutboundReport: notjunk:1;M01:P0:7dT9NDq493E=;jjPFkljAAZGdNz8gEKLgGOHQ78D
 iRbMpMrSopJ+dvzPV/TVQB5MJv3nBJTdYDpFpwe4qu6Vx5PPLt5Qz3XPQke1g8wvpMJt6cwDh
 AiL/bTL9UQHuX0hsDYoUOkS8TPGhSnjdlKJjp2so/zyyx7LgGs6rGecBveSD3IfGpPUwSsXbO
 QJzr+dHnuKRLobI/xa37QSGw0gDfak+5UYSaybN9kG1RLTUXv38VNHpdT6vzd7MxXPpfEIJat
 ItUxwKt7RsKpay/dcqxpI+d8YOlRl+45DD2vGXjmLzoJXlOw9athnq/CxZTeMy26BXHl4mot6
 PeFtVWq+HdKgffU5n/Hkz+YQOJFibxdfyYhW1TQH6/MLeLy+2s6YpIsK36wHSWfy/JwgPqFXb
 3jylHcfOGRRQM/8jRPobmJ2XXhQnQiwhlub9farXw2Jvc5xkm5rDfjHi/9qdvdFlDCgDDSsVc
 DpfrdHw1iV377QHK0sDwNBAc1S4s67C4cXkfrBsFoxg4vfP7GVH2Pr1oej+EESQFzSMR78H8d
 PYUxsgOPwXT/5f2s5QqNl+eglEhr5QqmZJDMPOjvIUJwRsqJzTxnzZ9oVOFO2EuSSIfr8uvRC
 82PiHpMAsXPKlNsnfnMmelxAzzjr0UeX5RdZ4HZrbKe84lYmVIpoNSJJSSJh/NwokzF3P2EdF
 pE5cgDf9wYtTOiHvtOmlxy215m/xth41Kv/fyrEWuifHtqOWR962D/QOdM3zCpQRH5qKqHz6m
 ZvqR5iv36jTeUec4fEoAuO0UTq5K0D+DeZrQRfl6IFMHgOKtPH4hBBQffm+2VpGOPRVdA7stN
 cEnz8v1+zrj3tbbl24mMaZxsqj7p5ttzzpuBkslVSkjyRnDSw2ggy3Zg4JSyapFkVj/iHFP9G
 xH/28/iPeMsCc2SvTwOjh6JpSxda5uU8OavBmjq5CQiX8F75ZXPEVf3tUw/NjQU1fhdCFaU1p
 TTSWRZ5AWHMiH4nkPbMtE/dhllM=
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/4/15 19:04, Otto Strassen wrote:
> Hi Qu, thanks for your answer.
> 
[...]
>> But considering the version (btrfs-progs 4.0), I'm not that confident.
>>
> 
>> Would you please boot into some newer distros (Archlinux or OpenSUSE
>> tumbleweed etc), and run "btrfs check --readonly" on the fs?
> 
> I think getting a more modern kernel/btrfs might be pretty difficult, since I can't really boot a synology from a USB stick, nor is there a system around that would allow me to hook up 8 disks. But with the information you gave me so far I am leaning more towards a rebuild of the storage anyway.
> 
> What is still puzzling me is how it ended up like this? What would be the best bet here, some underlying hardware is faulty?

No clue either.

To understand what's going wrong in the extent tree, we need not only 
the full btrfs check output, but also better with newer btrfs-progs.


But the existing ones already shows 3 different errors:

- Backref disk bytenr does not match extent record, 
bytenr=4184732463104, ref bytenr=0

   This shows one extent backref shows bad bytenr (0, not the expected
   4184732463104).

   This could cause problem when deleting the extent.

- ref mismatch on [8291880861696 16384] extent item 3, found 1
   This means one extent shows 3 backrefs, but in subvolumes tree, there
   is only one extent.

   This may be the cause of the RO flip.

- Incorrect global backref count on 21189054693376 found 4 wanted 0
   This shows one extent which is not referred by anyone in subvolumes.

   This may be the cause of the RO flip either.

Unfortunately older kernel doesn't give enough output to pin down which 
extent caused the problem (newer one has much better output).

Considering you have some forced RW (which itself is a bug in btrfs) 
after flipped RO, I'm not sure if this makes the case worse.

But overall, no transid mismatch, no obvious bitflip, and you mentioned 
no power loss (which should not cause any obvious problem by the nature 
of COW), the remaining causes are very limited:

- Some btrfs bugs
   At least we know there is one bug that allowed you to remount the fs
   RW after a RO flip.

   And considering how old the kernel is, it's not that weird to hit some
   old but already fixed bugs.

- That RW mounts caused something wrong
   But that still doesn't explain the initial RO flip.


> As stated in my first mail, all testing so far came up empty. But I would prefer for this to not happen again since it basically blocks work at the place. (A second system for failover is unfortunately noy possible right now, but at least we have several backups)

Unfortunately that's something I can never ensure, especially for a 
vendor specific kernel.

Remember it's the vendor who should take the responsibility, especially 
when they are still using EOL kernels.

[...]
>> But I would still strongly recommend to go a newer enough (5.15 at
>> least) kernel and progs.
> 
> Once I have done the extended SMART test, and am ready for a rebuilt, I will give this a try. I will have to do it with the synology provided versions though.

That's the tradeoff one has to take when sticking to a specific vendor.

But if you're going to rebuild, then why not just try "btrfs check 
--repair" in this case?

If it doesn't work, go the rebuild as planned.
But if it works, you saved a lot of time and should be able to use the 
fs without any problem (as long as btrfs check --readonly returns no error).

Thanks,
Qu

> 
>>
> 
>> Thanks,
>> Qu
> 
> Thanks and best,
> Otto
> 
> 
>>
> 
>>> 2023-04-08T03:14:46+02:00 Windhoek kernel: [453142.491332] BTRFS: error (device dm-3) in btrfs_run_delayed_refs_and_get_processed:3489: errno=-17 Object already exists
>>> 2023-04-08T03:14:46+02:00 Windhoek kernel: [453142.4913 34] BTRFS: error (device dm-3) in btrfs_run_delayed_refs_and_get_processed:3489: errno=-17 Object already exists
>>> 2023-04-08T03:14:46+02:00 Windhoek kernel: [453142.541893] WARNING: CPU: 2 PID: 19064 at fs/btrfs/extent-tree.c:2388 __btrfs_inc_extent_ref+0x250/0x320 btrfs
>>> 2023-04-08T03:14:46+02:00 Windhoek kernel: [453142.552326] Modules linked in: tun nf_conntrack_ipv6 ip6table_filter ip6_tables ipt_MASQUERADE xt_REDIRECT nf_nat_masquerade_ipv4 xt_nat iptable_nat nf_nat_ipv4 nf_nat_redirect nf_nat xt_recent xt_iprange xt_limit xt_state xt_multiport xt_LOG nf_conntrack_ipv4 nf_defrag_ipv4 xt_tcpudp iptable_filter ip_tables x_tables fuse 8021q vfat fat vhost_scsi(O) vhost(O) tcm_loop(O) iscsi_target_mod(O) target_core_user(O) target_core_ep(O) target_core_multi_file(O) target_core_file(O) target_core_iblock(O) target_core_mod(O) syno_extent_pool(PO) rodsp_ep(O) udf isofs synoacl_vfs(PO) btrfs ecryptfs zstd_decompress zstd_compress xxhash raid456 async_raid6_recov async_memcpy async_pq async_xor xor async_tx raid6_pq openvswitch gre bnxt_en(O) nf_defrag_ipv6 leds_lp3943 nf_conntrack aesni_intel glue_helper lrw gf128mul
>>> 2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.624953] ablk_helper v1000_synobios(PO) hid_generic usbhid hid usblp adt7475 hwmon_vid etxhci_hcd usb_storage bnx2x(O) mdio qede(O) qed(O) mlx5_core(O) mlx4_en(O) mlx4_core(O) mlx_compat(O) atlantic_v2(O) atlantic(O) r8168(O) zram i40e(O) ixgbe(O) amd_xgbe marvell10g sg dm_snapshot dm_bufio crc_itu_t crc_ccitt psnap p8022 llc hfsplus md4 hmac sit tunnel4 ipv6 flashcache_syno(O) flashcache(O) syno_flashcache_control(O) dm_mod arc4 crc32c_intel cryptd ecb aes_x86_64 authenc des_generic ansi_cprng cts md5 cbc cpufreq_powersave cpufreq_performance acpi_cpufreq processor cpufreq_stats vxlan ip6_udp_tunnel udp_tunnel ip_tunnel loop sha256_generic synorbd(PO) synofsbd(PO) xhci_pci xhci_hcd uhci_hcd ehci_pci ehci_hcd usbcore usb_common mv14xx(O) [last unloaded: nf_defrag_ipv4]
>>> 2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.694014] CPU: 2 PID: 19064 Comm: kworker/u16:0 Tainted: P W O 4.4.180+ #42962
>>> 2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.702444] Hardware name: Synology Inc. DS1821+/Bilby, BIOS M.209.00 08/05/2020
>>> 2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.709941] Workqueue: btrfs-extent-refs btrfs_extent_refs_helper [btrfs]
>>> 2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.716836] 0000000000000000 ffff880271673a60 ffffffff812e2d5b 0000000000000009
>>> 2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.724425] ffff880271673aa8 ffff880271673a98 ffffffff81056522 ffff880704b68908
>>> 2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.731996] 00000000ffffffef 0000000000000a4a ffff8807f838ccb0 0000000000003325
>>> 2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.739567] Call Trace:
>>> 2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.742111] [<ffffffff812e2d5b>] dump_stack+0x4d/0x72
>>> 2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.747340] [<ffffffff81056522>] warn_slowpath_common+0x82/0xa0
>>> 2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.753429] [<ffffffff81056587>] warn_slowpath_fmt+0x47/0x50
>>> 2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.759272] [<ffffffffa10ff8a7>] ? insert_tree_block_ref+0x47/0x60 [btrfs]
>>> 2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.766327] [<ffffffffa11067f0>] __btrfs_inc_extent_ref+0x250/0x320 [btrfs]
>>> 2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.773487] [<ffffffffa110abfa>] __btrfs_run_delayed_refs+0x13ea/0x18c0 [btrfs]
>>> 2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.780987] [<ffffffffa1108a7b>] ? btrfs_block_rsv_check+0x1b/0x60 [btrfs]
>>> 2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.788044] [<ffffffffa110e993>] btrfs_run_delayed_refs_and_get_processed+0xc3/0x4b0 [btrfs]
>>> 2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.796668] [<ffffffffa112a465>] ? start_transaction+0x95/0x460 [btrfs]
>>> 2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.803464] [<ffffffffa110ee35>] delayed_ref_async_start+0xb5/0x100 [btrfs]
>>> 2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.810612] [<ffffffffa1162496>] btrfs_worker_helper+0xc6/0x390 [btrfs]
>>> 2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.817413] [<ffffffffa11628a9>] btrfs_extent_refs_helper+0x9/0x10 [btrfs]
>>> 2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.824460] [<ffffffff810768da>] worker_run_work+0x9a/0xe0
>>> 2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.830139] [<ffffffffa11628a0>] ? btrfs_usrquota_rescan_helper+0x10/0x10 [btrfs]
>>> 2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.837797] [<ffffffff8106e67b>] process_one_work+0x1db/0x4e0
>>> 2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.843719] [<ffffffff8106e9ad>] worker_thread+0x2d/0x4a0
>>> 2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.849296] [<ffffffff8106e980>] ? process_one_work+0x4e0/0x4e0
>>> 2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.855391] [<ffffffff81072d73>] kthread+0xd3/0xf0
>>> 2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.860357] [<ffffffff81072ca0>] ? kthread_worker_fn+0x160/0x160
>>> 2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.866539] [<ffffffff81571def>] ret_from_fork+0x3f/0x80
>>> 2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.872027] [<ffffffff81072ca0>] ? kthread_worker_fn+0x160/0x160
>>> 2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.878220] ---[ end trace 11b6552e7d6527ab ]---
>>> --- skip ---
>>> 2023-04-11T08:28:25+02:00 Windhoek kernel: [731152.211084] BTRFS error (device dm-3): Remounting read-write after error is not allowed
>>> 2023-04-11T08:28:25+02:00 Windhoek kernel: [731152.352390] BTRFS error (device dm-3): cleaner transaction attach returned -30
>>> --- skip ---
>>> 2023-04-11T23:56:06+02:00 Windhoek kernel: [ 619.485264] BTRFS: error (device dm-3) in __btrfs_inc_extent_ref:2388: errno=-17 Object already exists
>>> 2023-04-11T23:56:06+02:00 Windhoek kernel: [ 619.499619] BTRFS: error (device dm-3) in btrfs_run_delayed_refs_and_get_processed:3489: errno=-17 Object already exists
>>> 2023-04-11T23:56:06+02:00 Windhoek kernel: [ 619.510480] BTRFS: error (device dm-3) in btrfs_drop_snapshot:12020: errno=-17 Object already exists
>>> 2023-04-11T23:56:06+02:00 Windhoek kernel: [ 619.519614] BTRFS: error (device dm-3) in btrfs_drop_snapshot:12205: errno=-17 Object already exists
>>> 2023-04-11T23:58:17+02:00 Windhoek kernel: [ 750.742562] BTRFS error (device dm-3): Remounting read-write after error is not allowed
>>> 2023-04-11T23:58:19+02:00 Windhoek kernel: [ 752.504619] BTRFS error (device dm-3): cleaner transaction attach returned -30
>>>
> 
>>> Thanks and best
>>> Otto
