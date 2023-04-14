Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD676E2242
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Apr 2023 13:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjDNLeB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Apr 2023 07:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjDNLeA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Apr 2023 07:34:00 -0400
Received: from mail-40136.proton.ch (mail-40136.proton.ch [185.70.40.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743B2186
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Apr 2023 04:33:58 -0700 (PDT)
Date:   Fri, 14 Apr 2023 11:33:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tostr.ch;
        s=protonmail3; t=1681472036; x=1681731236;
        bh=CHjNm5AlsYdqksQOWqFJ4Hhh92qfFEVezd/kS9UNlFU=;
        h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=kSqY3JDrwItsGtQ1u8+JBoBC6Aye81cikyg1yZ3HoS4CiG6vgwbfWzvoiVg3wwUc0
         00tM0ak9Z5RUCnPMRGqvsUMbJnUiDq1m/iDpT/hZF5PDHZGhBtS1rlU/4BU99GRogb
         nOm9W1PC38fpnRMJph4hFGMmaxArPoTHvY8t6ldFTQPdXQ7+8Ry2jCcPn8UUO4Dogw
         nghrYDXaWQeD9tqds+8JLmiqmVd1q9JJNUAsidFZvOojpMY+6FO+mBZwGFSnOkbNBT
         98Fqpebdo1xw89wijgwRtPtVtW1AZTHLTVnxks8HXs08vN3ZEQVpm2gGe4TrwdPijI
         sqWow3SURq6oQ==
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From:   Otto Strassen <otto@tostr.ch>
Subject: Filesystem ro mode, check shows a lot of missing backrefs, no idea on how to proceed
Message-ID: <sY9YYJrpztwzxhv_9p28An7hkWNiF8hHF0we0ToIQ69b3lpaeBc7l77Kd4jYdsXA6Rps73Xa3guq3XA8c3mZdxDIvSwO5Cyh2eeO5Aqh3-s=@tostr.ch>
Feedback-ID: 42428327:user:proton
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha512; boundary="------c045c796b022f06d8f8656338f7b17f48789c9b92b497dd132ddadc1ca500d7d"; charset=utf-8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------c045c796b022f06d8f8656338f7b17f48789c9b92b497dd132ddadc1ca500d7d
Content-Type: multipart/mixed;boundary=---------------------c8ad0ebd240a89c9496872e85d8320d2

-----------------------c8ad0ebd240a89c9496872e85d8320d2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

Hi

I am the sysadmin for a small nonprofit library/archive, and we store phys=
ical media (books, posters etc.) as well as a lot of data (the catalogue d=
atabase itself, digitalised movies, recordings etc.). Now the budget is ti=
ght, while the amount of data is high-ish and the expectations are "archiv=
al" storage. So avoiding data rot is important.

So, our solution to the problem was to buy a Synology (DS1821+) which supp=
orts btrfs. We have 8 HDDs (10.9TB reported size), and 2 SSDs for caching.

The setup is the following: HDD -> MD(RAID 6) -> LVM (2 volumes) -> btrfs =
on each volume

A couple days ago 'volume 1', which is the big storage we actually use in =
day-to-day operation (~60TB capacity, about 18TB used) switched to 'ro' mo=
de. I have been trying to fix that ever since, and will give an overview o=
f the steps taken as well as the results so far. I am unsure how much diff=
erence exists between the synology provided btrfs and mainline, but maybe =
someone here will be better able to assess that.

Currently we are looking to do a restore, but this is time intensive, and =
I am also worried that this problem might happen again. My gut tells me th=
at there is probably faulty hardware somewhere, but all tests came up fine=
 so far.

I hope that maybe someone can help provide a bit of insight on how to proc=
eed, what we are dealing with and how to avoid this in the future.

Some notes:
- Quick SMART is clean for all drives
- Extended SMART I will try to run this weekend
- No power-loss happened prior to this
- mdadm shows no problems whatsoever
- I tried to zero-log, but that failed due to a missing 'ctree-something' =
(might also have been 'btree-something', but I did not save the output)
- super-recover claims nothing to do, all is fine
- I have considered --init-csum-tree and even more --init-extent-tree, but=
 given the potential runtime of these and unknown benefit I have refrained=
 from doing so
- LVM looks fine as well
- memtest (there is one provided by synology) comes up clean, the memory i=
s branded synology, and we have 2x16GB
- All problems so far only happen on volume1, volume2 (which is not used r=
ight now, but formatted and ready) has the same exact underlying hardware/=
setup


The relevant versions of the affected components:

$ btrfs --version
btrfs-progs v4.0

$ uname -srm
Linux 4.4.180+ x86_64

Synology: DSM 7.1.1-42962 Update 4


$ btrfs scrub start -Bdr /volume1
scrub status for c14c923f-2038-4841-aa89-504f1044d3be
scrub device /dev/mapper/cachedev_0 (id 1) history
        scrub started at Tue Apr 11 18:35:45 2023 and finished after 04:11=
:48
        total bytes scrubbed: 18.58TiB with 0 errors

$ btrfs fi show /volume1
Label: '2022.05.04-10:06:00 v42218'  uuid: c14c923f-2038-4841-aa89-504f104=
4d3be
        Total devices 1 FS bytes used 18.58TiB
        devid    1 size 64.48TiB used 18.63TiB path /dev/mapper/cachedev_0

$ btrfs device stats /volume1
[/dev/mapper/cachedev_0].write_io_errs   0
[/dev/mapper/cachedev_0].read_io_errs    0
[/dev/mapper/cachedev_0].flush_io_errs   0
[/dev/mapper/cachedev_0].corruption_errs 0
[/dev/mapper/cachedev_0].generation_errs 0


I was able to get the volume into a working order with this (the clear_cac=
he is what makes the difference here):
$ mount -o remount,rw,clear_cache /volume1

The device is mounted like this now, normally is would not have clear_cach=
e and space_cache=3Dv2
$ mount | grep volume1
/dev/mapper/cachedev_0 on /volume1 type btrfs (rw,nodev,relatime,ssd,synoa=
cl,nospace_cache,clear_cache,auto_reclaim_space,metadata_ratio=3D50,block_=
group_cache_tree,syno_allocator,subvolid=3D256,subvol=3D/@syno)

However, as soon as the device does a backup at night (just a couple of MB=
 of data), it ends up in a 'ro' state again.

The fsck from btrfs shows a lot of errors (about 50k lines). How these err=
ors came to be, and how severe they are is currently not clear. These erro=
rs persist regardless of the volume being currently broken or not.

$ btrfs check -p /dev/mapper/cachedev_0
Syno caseless feature on.
checking extents
ref mismatch on [4184732463104 4096] extent item 2, found 1
Incorrect local backref count on 4184732463104 parent 19908052926464 owner=
 0 offset 0 found 0 wanted 1 back 0x55f31169f400
Backref disk bytenr does not match extent record, bytenr=3D4184732463104, =
ref bytenr=3D0
backpointer mismatch on [4184732463104 4096]
ref mismatch on [8291880861696 16384] extent item 3, found 1
Backref 8291880861696 root 2315 not referenced back 0x55f306f5c270
Backref 8291880861696 root 2711 not referenced back 0x55f306f5c2a0
Incorrect global backref count on 8291880861696 found 3 wanted 1
<--- skip 50k similar lines --->
Backref 21189054693376 root 2763 not referenced back 0x55f306859410
Incorrect global backref count on 21189054693376 found 4 wanted 0
backpointer mismatch on [21189054693376 16384]
owner ref check failed [21189054693376 16384]
Syno block group cache is sync
checking free space tree
checking fs roots
warning line 4386
checking csums
checking root refs
Checking filesystem on /dev/mapper/cachedev_0
UUID: c14c923f-2038-4841-aa89-504f1044d3be
found 20423782981633 bytes used err is 0
total csum bytes: 938305868
total tree bytes: 2463318016
total fs tree bytes: 1220673536
total extent tree bytes: 176783360
btree space waste bytes: 332682766
file data blocks allocated: 21039730896896
 referenced 20420441374720

One error that only happens when the volume goes into 'ro' mode can be fou=
nd in the kernel log.

$ cat /var/log/kern.log
2023-04-08T03:14:46+02:00 Windhoek kernel: [453142.491317] ------------[ c=
ut here ]------------
2023-04-08T03:14:46+02:00 Windhoek kernel: [453142.491324] BTRFS: error (d=
evice dm-3) in __btrfs_inc_extent_ref:2388: errno=3D-17 Object already exi=
sts
2023-04-08T03:14:46+02:00 Windhoek kernel: [453142.491328] BTRFS: error (d=
evice dm-3) in __btrfs_inc_extent_ref:2388: errno=3D-17 Object already exi=
sts
2023-04-08T03:14:46+02:00 Windhoek kernel: [453142.491332] BTRFS: error (d=
evice dm-3) in btrfs_run_delayed_refs_and_get_processed:3489: errno=3D-17 =
Object already exists
2023-04-08T03:14:46+02:00 Windhoek kernel: [453142.4913 34] BTRFS: error (=
device dm-3) in btrfs_run_delayed_refs_and_get_processed:3489: errno=3D-17=
 Object already exists
2023-04-08T03:14:46+02:00 Windhoek kernel: [453142.541893] WARNING: CPU: 2=
 PID: 19064 at fs/btrfs/extent-tree.c:2388 __btrfs_inc_extent_ref+0x250/0x=
320 [btrfs]()
2023-04-08T03:14:46+02:00 Windhoek kernel: [453142.552326] Modules linked =
in: tun nf_conntrack_ipv6 ip6table_filter ip6_tables ipt_MASQUERADE xt_RED=
IRECT nf_nat_masquerade_ipv4 xt_nat iptable_nat nf_nat_ipv4 nf_nat_redirec=
t nf_nat xt_recent xt_iprange xt_limit xt_state xt_multiport xt_LOG nf_con=
ntrack_ipv4 nf_defrag_ipv4 xt_tcpudp iptable_filter ip_tables x_tables fus=
e 8021q vfat fat vhost_scsi(O) vhost(O) tcm_loop(O) iscsi_target_mod(O) ta=
rget_core_user(O) target_core_ep(O) target_core_multi_file(O) target_core_=
file(O) target_core_iblock(O) target_core_mod(O) syno_extent_pool(PO) rods=
p_ep(O) udf isofs synoacl_vfs(PO) btrfs ecryptfs zstd_decompress zstd_comp=
ress xxhash raid456 async_raid6_recov async_memcpy async_pq async_xor xor =
async_tx raid6_pq openvswitch gre bnxt_en(O) nf_defrag_ipv6 leds_lp3943 nf=
_conntrack aesni_intel glue_helper lrw gf128mul
2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.624953]  ablk_helper v1=
000_synobios(PO) hid_generic usbhid hid usblp adt7475 hwmon_vid etxhci_hcd=
 usb_storage bnx2x(O) mdio qede(O) qed(O) mlx5_core(O) mlx4_en(O) mlx4_cor=
e(O) mlx_compat(O) atlantic_v2(O) atlantic(O) r8168(O) zram i40e(O) ixgbe(=
O) amd_xgbe marvell10g sg dm_snapshot dm_bufio crc_itu_t crc_ccitt psnap p=
8022 llc hfsplus md4 hmac sit tunnel4 ipv6 flashcache_syno(O) flashcache(O=
) syno_flashcache_control(O) dm_mod arc4 crc32c_intel cryptd ecb aes_x86_6=
4 authenc des_generic ansi_cprng cts md5 cbc cpufreq_powersave cpufreq_per=
formance acpi_cpufreq processor cpufreq_stats vxlan ip6_udp_tunnel udp_tun=
nel ip_tunnel loop sha256_generic synorbd(PO) synofsbd(PO) xhci_pci xhci_h=
cd uhci_hcd ehci_pci ehci_hcd usbcore usb_common mv14xx(O) [last unloaded:=
 nf_defrag_ipv4]
2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.694014] CPU: 2 PID: 190=
64 Comm: kworker/u16:0 Tainted: P        W  O    4.4.180+ #42962
2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.702444] Hardware name: =
Synology Inc. DS1821+/Bilby, BIOS M.209.00 08/05/2020
2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.709941] Workqueue: btrf=
s-extent-refs btrfs_extent_refs_helper [btrfs]
2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.716836]  00000000000000=
00 ffff880271673a60 ffffffff812e2d5b 0000000000000009
2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.724425]  ffff880271673a=
a8 ffff880271673a98 ffffffff81056522 ffff880704b68908
2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.731996]  00000000ffffff=
ef 0000000000000a4a ffff8807f838ccb0 0000000000003325
2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.739567] Call Trace:
2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.742111]  [<ffffffff812e=
2d5b>] dump_stack+0x4d/0x72
2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.747340]  [<ffffffff8105=
6522>] warn_slowpath_common+0x82/0xa0
2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.753429]  [<ffffffff8105=
6587>] warn_slowpath_fmt+0x47/0x50
2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.759272]  [<ffffffffa10f=
f8a7>] ? insert_tree_block_ref+0x47/0x60 [btrfs]
2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.766327]  [<ffffffffa110=
67f0>] __btrfs_inc_extent_ref+0x250/0x320 [btrfs]
2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.773487]  [<ffffffffa110=
abfa>] __btrfs_run_delayed_refs+0x13ea/0x18c0 [btrfs]
2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.780987]  [<ffffffffa110=
8a7b>] ? btrfs_block_rsv_check+0x1b/0x60 [btrfs]
2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.788044]  [<ffffffffa110=
e993>] btrfs_run_delayed_refs_and_get_processed+0xc3/0x4b0 [btrfs]
2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.796668]  [<ffffffffa112=
a465>] ? start_transaction+0x95/0x460 [btrfs]
2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.803464]  [<ffffffffa110=
ee35>] delayed_ref_async_start+0xb5/0x100 [btrfs]
2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.810612]  [<ffffffffa116=
2496>] btrfs_worker_helper+0xc6/0x390 [btrfs]
2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.817413]  [<ffffffffa116=
28a9>] btrfs_extent_refs_helper+0x9/0x10 [btrfs]
2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.824460]  [<ffffffff8107=
68da>] worker_run_work+0x9a/0xe0
2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.830139]  [<ffffffffa116=
28a0>] ? btrfs_usrquota_rescan_helper+0x10/0x10 [btrfs]
2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.837797]  [<ffffffff8106=
e67b>] process_one_work+0x1db/0x4e0
2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.843719]  [<ffffffff8106=
e9ad>] worker_thread+0x2d/0x4a0
2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.849296]  [<ffffffff8106=
e980>] ? process_one_work+0x4e0/0x4e0
2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.855391]  [<ffffffff8107=
2d73>] kthread+0xd3/0xf0
2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.860357]  [<ffffffff8107=
2ca0>] ? kthread_worker_fn+0x160/0x160
2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.866539]  [<ffffffff8157=
1def>] ret_from_fork+0x3f/0x80
2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.872027]  [<ffffffff8107=
2ca0>] ? kthread_worker_fn+0x160/0x160
2023-04-08T03:14:47+02:00 Windhoek kernel: [453142.878220] ---[ end trace =
11b6552e7d6527ab ]---
--- skip ---
2023-04-11T08:28:25+02:00 Windhoek kernel: [731152.211084] BTRFS error (de=
vice dm-3): Remounting read-write after error is not allowed
2023-04-11T08:28:25+02:00 Windhoek kernel: [731152.352390] BTRFS error (de=
vice dm-3): cleaner transaction attach returned -30
--- skip ---
2023-04-11T23:56:06+02:00 Windhoek kernel: [  619.485264] BTRFS: error (de=
vice dm-3) in __btrfs_inc_extent_ref:2388: errno=3D-17 Object already exis=
ts
2023-04-11T23:56:06+02:00 Windhoek kernel: [  619.499619] BTRFS: error (de=
vice dm-3) in btrfs_run_delayed_refs_and_get_processed:3489: errno=3D-17 O=
bject already exists
2023-04-11T23:56:06+02:00 Windhoek kernel: [  619.510480] BTRFS: error (de=
vice dm-3) in btrfs_drop_snapshot:12020: errno=3D-17 Object already exists
2023-04-11T23:56:06+02:00 Windhoek kernel: [  619.519614] BTRFS: error (de=
vice dm-3) in btrfs_drop_snapshot:12205: errno=3D-17 Object already exists
2023-04-11T23:58:17+02:00 Windhoek kernel: [  750.742562] BTRFS error (dev=
ice dm-3): Remounting read-write after error is not allowed
2023-04-11T23:58:19+02:00 Windhoek kernel: [  752.504619] BTRFS error (dev=
ice dm-3): cleaner transaction attach returned -30


Thanks and best
Otto
-----------------------c8ad0ebd240a89c9496872e85d8320d2--

--------c045c796b022f06d8f8656338f7b17f48789c9b92b497dd132ddadc1ca500d7d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wnUEARYKACcFgmQ5OgQJkOprz5XYRobAFiEEzgw+qhyRVYuktNGm6mvPldhG
hsAAAFkWAPwP/LaIZWJb54do0tzmKATGMnSMrxqKCzKmWM4BR3YFiwD/aJdM
HjWfnUhmayD1HNrBS3W/2kaQnCNyobvXesV3uw0=
=FwFj
-----END PGP SIGNATURE-----


--------c045c796b022f06d8f8656338f7b17f48789c9b92b497dd132ddadc1ca500d7d--

