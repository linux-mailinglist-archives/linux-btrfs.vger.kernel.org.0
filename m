Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8AD3148E2A
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jan 2020 20:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391454AbgAXTDO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jan 2020 14:03:14 -0500
Received: from mail.as397444.net ([69.59.18.99]:37582 "EHLO mail.as397444.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387918AbgAXTDO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jan 2020 14:03:14 -0500
X-Greylist: delayed 327 seconds by postgrey-1.27 at vger.kernel.org; Fri, 24 Jan 2020 14:03:11 EST
Received: from [10.233.42.100] (unknown [69.59.18.156])
        by mail.as397444.net (Postfix) with ESMTPSA id 19410181038
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jan 2020 18:57:43 +0000 (UTC)
To:     linux-btrfs@vger.kernel.org
From:   Matt Corallo <linux@bluematt.me>
Subject: BUG_ON in btrfs check & fs/btrfs/extent-tree.c:3071
Message-ID: <57f3f3bb-b3cb-df2d-9ce6-7b546200c009@bluematt.me>
Date:   Fri, 24 Jan 2020 18:57:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In a 10 disk spinning-rust array on top of dm-crypt thats pretty old
(was built year ago, most recently running on 4.20 with no issues for
quite some time), I had a drive fail. Let btrfs device remove $(devid)
run for some time, spewing errors to dmesg cause the backing device is
gone but btrfs still hands dm the I/Os. After about a day of this, I got
in a new drive, and had to reshuffle some things to install it, so the
machine got shut down during the device remove, upgrading to 5.4 in the
process.

Boot it back up on 5.4, mount -odegraded, balance -mdevid=$(missing),
let it run for a while, then I get a series of corrupt leafs, ala:

[ 6754.454755] BTRFS critical (device dm-6): corrupt leaf:
block=55800649400320 slot=149 extent bytenr=41634764488704
len=1007496932043095647 invalid extent data ref hash, item has
0x0dfb591f2ab97e5e key has 0x0dfb591f2ab97e5f

(note only the low bit in the key is different, this is true for all the
similar issues, with  different block, but the same bytenr for several
attempts)

All of the dumping of the blocks that show up show only as extent data
backref root FS_TREE, so unmount and btrfs check -p --clear-space-cache
v1...oops:

Opening filesystem to check...
Checking filesystem on /dev/mapper/bigraid1_crypt
UUID: bde0d0ab-31e6-47b8-8d7f-eef17af4f37e
Failed to find [22566682869760, 168, 16384]
btrfs unable to find ref byte nr 22566682869760 parent 0 root 2  owner 0
offset 0
transaction.c:195: btrfs_commit_transaction: BUG_ON `ret` triggered,
value -5
btrfs(+0x45718)[0x117ad5718]
btrfs(btrfs_commit_transaction+0x13c)[0x117ad5c58]
btrfs(btrfs_clear_free_space_cache+0x144)[0x117ac8fd0]
btrfs(+0x59564)[0x117ae9564]
btrfs(cmd_check+0x6c8)[0x117af5690]
btrfs(main+0xc0)[0x117aa4660]
/lib/powerpc64le-linux-gnu/libc.so.6(+0x28328)[0x3fff86e97328]
/lib/powerpc64le-linux-gnu/libc.so.6(__libc_start_main+0xd4)[0x3fff86e97524]
Aborted

now if I mount it tries to replay the transaction and gets the same from
the kernel:

[70990.689101] ------------[ cut here ]------------
[70990.689126] WARNING: CPU: 23 PID: 37489 at
fs/btrfs/extent-tree.c:3071 __btrfs_free_extent.isra.0+0x304/0xf20 [btrfs]
[70990.689127] Modules linked in: binfmt_misc(E) veth(E) xt_tcpudp(E)
xt_nat(E) wireguard(OE) ip6_udp_tunnel(E) udp_tunnel(E) essiv(E)
authenc(E) nft_counter(E) nft_chain_nat(E) xt_MASQUERADE(E) nf_nat(E)
nf_conntrack(E) nf_defrag_ipv6(E) nf_defrag_ipv4(E) nft_compat(E)
nf_tables(E) nfnetlink(E) btrfs(E) zstd_compress(E) zstd_decompress(E)
amdgpu(E) snd_hda_codec_hdmi(E) ast(E) gpu_sched(E) drm_vram_helper(E)
ttm(E) snd_hda_intel(E) drm_kms_helper(E) snd_hda_codec(E) sg(E)
snd_hda_core(E) snd_hwdep(E) drm(E) uas(E) snd_pcm(E) tg3(E) ofpart(E)
mpt3sas(E) libphy(E) drm_panel_orientation_quirks(E) syscopyarea(E)
snd_timer(E) powernv_flash(E) ipmi_powernv(E) sysfillrect(E)
sysimgblt(E) ipmi_devintf(E) opal_prd(E) fb_sys_fops(E) snd(E) ptp(E)
mtd(E) i2c_algo_bit(E) ipmi_msghandler(E) pps_core(E) raid_class(E)
soundcore(E) scsi_transport_sas(E) at24(E) ip_tables(E) x_tables(E)
autofs4(E) ext4(E) crc16(E) mbcache(E) jbd2(E) sd_mod(E) raid10(E)
raid456(E) crc32c_generic(E) libcrc32c(E)
[70990.689166]  async_raid6_recov(E) async_memcpy(E) async_pq(E)
evdev(E) hid_generic(E) usbhid(E) hid(E) raid6_pq(E) async_xor(E) xor(E)
async_tx(E) raid1(E) raid0(E) multipath(E) linear(E) md_mod(E)
usb_storage(E) dm_crypt(E) dm_mod(E) algif_skcipher(E) af_alg(E)
xhci_pci(E) xhci_hcd(E) usbcore(E) vmx_crypto(E) nvme(E) nvme_core(E)
usb_common(E)
[70990.689182] CPU: 23 PID: 37489 Comm: btrfs-transacti Tainted: G
    OE     5.4.0-3-powerpc64le #1 Debian 5.4.14-1
[70990.689184] NIP:  c0080000073921ec LR: c008000007392698 CTR:
c000000000ab7950
[70990.689185] REGS: c000000ead03b650 TRAP: 0700   Tainted: G
OE      (5.4.0-3-powerpc64le Debian 5.4.14-1)
[70990.689185] MSR:  9000000002029033 <SF,HV,VEC,EE,ME,IR,DR,RI,LE>  CR:
88022824  XER: 00000000
[70990.689190] CFAR: c008000007391ffc IRQMASK: 0
               GPR00: c008000007392698 c000000ead03b8e0 c008000007502800
fffffffffffffffe
               GPR04: 0000000000000000 0000000000000002 0000000000000002
0000000000000093
               GPR08: 0000000000000000 0000000000000001 0000000000000000
c000000a0727a288
               GPR12: 0000000028022422 c000000fffff0a00 c000000000155528
0000000000000000
               GPR16: c000000fbcacddd0 0000000000000002 0000000000000000
0000000000000002
               GPR20: c0000000db9a1690 0000000000000000 c00020073eaec000
0000000000000000
               GPR24: c000200acdfe4000 0000000000000000 0000000000000001
0000000000004000
               GPR28: c00000066af57958 0000000000000000 00001486371dc000
fffffffffffffffe
[70990.689205] NIP [c0080000073921ec]
__btrfs_free_extent.isra.0+0x304/0xf20 [btrfs]
[70990.689211] LR [c008000007392698]
__btrfs_free_extent.isra.0+0x7b0/0xf20 [btrfs]
[70990.689212] Call Trace:
[70990.689218] [c000000ead03b8e0] [c008000007392698]
__btrfs_free_extent.isra.0+0x7b0/0xf20 [btrfs] (unreliable)
[70990.689225] [c000000ead03ba10] [c00800000739447c]
__btrfs_run_delayed_refs+0x8c4/0x14f0 [btrfs]
[70990.689232] [c000000ead03bb90] [c008000007395164]
btrfs_run_delayed_refs+0xbc/0x320 [btrfs]
[70990.689239] [c000000ead03bc50] [c0080000073b0604]
btrfs_commit_transaction+0x5bc/0xcf0 [btrfs]
[70990.689247] [c000000ead03bd40] [c0080000073a9d44]
transaction_kthread+0x24c/0x2d0 [btrfs]
[70990.689251] [c000000ead03bdb0] [c000000000155668] kthread+0x148/0x1a0
[70990.689254] [c000000ead03be20] [c00000000000bd54]
ret_from_kernel_thread+0x5c/0x68
[70990.689254] Instruction dump:
[70990.689257] 60000000 2c1a0001 4182012c fa0100b0 fa2100b8 0fe00000
60000000 60000000
[70990.689261] 60000000 393f0002 7d290034 5529d97e <0b090000> 2c1ffffe
41820664 e93c0050
[70990.689264] ---[ end trace 336665b21c6bbe64 ]---
[70990.689268] BTRFS info (device dm-7): leaf 15419643854848 gen 5027094
total ptrs 186 free space 2147 owner 2
[70990.689269] 	item 0 key (22566681542656 168 16384) itemoff 16232
itemsize 51
[70990.689270] 		extent refs 1 gen 4485125 flags 2
[70990.689271] 		tree block key (285998948 1 0) level 0
[70990.689272] 		ref#0: shared block backref parent 56041398337536
[70990.689274] 	item 1 key (22566681559040 168 16384) itemoff 16181
itemsize 51
[70990.689275] 		extent refs 1 gen 4485251 flags 2
[70990.689275] 		tree block key (514106746 108 0) level 0
[70990.689276] 		ref#0: tree block backref root 5
[70990.689277] 	item 2 key (22566681575424 168 16384) itemoff 16130
itemsize 51
[70990.689278] 		extent refs 1 gen 4485190 flags 2
[70990.689279] 		tree block key (376592665 108 0) level 0
[70990.689279] 		ref#0: tree block backref root 5
[70990.689281] 	item 3 key (22566681591808 168 16384) itemoff 16079
itemsize 51
[70990.689281] 		extent refs 1 gen 4485251 flags 2
[70990.689282] 		tree block key (514106753 108 0) level 0
[70990.689282] 		ref#0: tree block backref root 5
[70990.689284] 	item 4 key (22566681608192 168 16384) itemoff 16028
itemsize 51
[70990.689284] 		extent refs 1 gen 4252351 flags 2
[70990.689285] 		tree block key (579475832 108 0) level 0
[70990.689285] 		ref#0: tree block backref root 5
[70990.689287] 	item 5 key (22566681624576 168 16384) itemoff 15977
itemsize 51
[70990.689287] 		extent refs 1 gen 4485125 flags 2
[70990.689288] 		tree block key (285998973 1 0) level 0
[70990.689288] 		ref#0: shared block backref parent 56041398337536
[70990.689290] 	item 6 key (22566681657344 168 16384) itemoff 15926
itemsize 51
[70990.689290] 		extent refs 1 gen 4485251 flags 2
[70990.689291] 		tree block key (514106772 108 0) level 0
[70990.689291] 		ref#0: tree block backref root 5
[70990.689293] 	item 7 key (22566681673728 168 16384) itemoff 15875
itemsize 51
[70990.689293] 		extent refs 1 gen 4512317 flags 2
[70990.689294] 		tree block key (648786505 108 0) level 0
[70990.689294] 		ref#0: shared block backref parent 56271599386624
[70990.689296] 	item 8 key (22566681690112 168 16384) itemoff 15824
itemsize 51
[70990.689296] 		extent refs 1 gen 4299011 flags 2
[70990.689297] 		tree block key (587641399 96 102267) level 0
[70990.689297] 		ref#0: tree block backref root 5
[70990.689299] 	item 9 key (22566681722880 168 16384) itemoff 15773
itemsize 51
[70990.689299] 		extent refs 1 gen 4485251 flags 2
[70990.689300] 		tree block key (514106789 1 0) level 0
[70990.689300] 		ref#0: tree block backref root 5
[70990.689301] 	item 10 key (22566681739264 168 16384) itemoff 15722
itemsize 51
[70990.689302] 		extent refs 1 gen 4485190 flags 2
[70990.689303] 		tree block key (376592680 1 0) level 0
[70990.689303] 		ref#0: tree block backref root 5
[70990.689304] 	item 11 key (22566681755648 168 16384) itemoff 15671
itemsize 51
[70990.689305] 		extent refs 1 gen 4485190 flags 2
[70990.689306] 		tree block key (376592695 108 0) level 0
[70990.689306] 		ref#0: tree block backref root 5
[70990.689307] 	item 12 key (22566681772032 168 16384) itemoff 15620
itemsize 51
[70990.689308] 		extent refs 1 gen 4290737 flags 2
[70990.689309] 		tree block key (586186166 108 0) level 0
[70990.689309] 		ref#0: tree block backref root 5
[70990.689310] 	item 13 key (22566681788416 168 16384) itemoff 15569
itemsize 51
[70990.689311] 		extent refs 1 gen 4301682 flags 2
[70990.689312] 		tree block key (588132963 84 1557312906) level 0
[70990.689312] 		ref#0: tree block backref root 5
[70990.689313] 	item 14 key (22566681804800 168 16384) itemoff 15518
itemsize 51
[70990.689314] 		extent refs 1 gen 4485190 flags 2
[70990.689315] 		tree block key (376592710 108 0) level 0
[70990.689315] 		ref#0: tree block backref root 5
[70990.689316] 	item 15 key (22566681821184 168 16384) itemoff 15467
itemsize 51
[70990.689317] 		extent refs 1 gen 4252351 flags 2
[70990.689317] 		tree block key (579475875 1 0) level 0
[70990.689318] 		ref#0: tree block backref root 5
[70990.689319] 	item 16 key (22566681837568 168 16384) itemoff 15416
itemsize 51
[70990.689320] 		extent refs 1 gen 4485190 flags 2
[70990.689320] 		tree block key (376592725 108 0) level 0
[70990.689321] 		ref#0: tree block backref root 5
[70990.689322] 	item 17 key (22566681853952 168 16384) itemoff 15365
itemsize 51
[70990.689322] 		extent refs 1 gen 4274325 flags 2
[70990.689323] 		tree block key (582945778 96 1231) level 0
[70990.689324] 		ref#0: shared block backref parent 56267840716800
[70990.689325] 	item 18 key (22566681870336 168 16384) itemoff 15314
itemsize 51
[70990.689325] 		extent refs 1 gen 4485190 flags 2
[70990.689326] 		tree block key (376592740 108 0) level 0
[70990.689326] 		ref#0: tree block backref root 5
[70990.689328] 	item 19 key (22566681886720 168 16384) itemoff 15263
itemsize 51
[70990.689328] 		extent refs 1 gen 4274325 flags 2
[70990.689329] 		tree block key (582947061 1 0) level 0
[70990.689329] 		ref#0: shared block backref parent 56267840716800
[70990.689331] 	item 20 key (22566681903104 168 16384) itemoff 15212
itemsize 51
[70990.689331] 		extent refs 1 gen 4453119 flags 2
[70990.689332] 		tree block key (615911960 1 0) level 0
[70990.689332] 		ref#0: tree block backref root 5
[70990.689333] 	item 21 key (22566681919488 168 16384) itemoff 15161
itemsize 51
[70990.689334] 		extent refs 1 gen 4290737 flags 2
[70990.689335] 		tree block key (586186209 1 0) level 0
[70990.689335] 		ref#0: tree block backref root 5
[70990.689336] 	item 22 key (22566681935872 168 16384) itemoff 15110
itemsize 51
[70990.689337] 		extent refs 1 gen 4422862 flags 2
[70990.689337] 		tree block key (604266922 1 0) level 0
[70990.689338] 		ref#0: tree block backref root 5
[70990.689339] 	item 23 key (22566681952256 168 16384) itemoff 15059
itemsize 51
[70990.689340] 		extent refs 1 gen 4422862 flags 2
[70990.689340] 		tree block key (604307979 108 0) level 0
[70990.689341] 		ref#0: shared block backref parent 24625417060352
[70990.689342] 	item 24 key (22566681968640 168 16384) itemoff 15008
itemsize 51
[70990.689342] 		extent refs 1 gen 4299011 flags 2
[70990.689343] 		tree block key (587743739 1 0) level 0
[70990.689344] 		ref#0: tree block backref root 5
[70990.689345] 	item 25 key (22566681985024 168 16384) itemoff 14957
itemsize 51
[70990.689345] 		extent refs 1 gen 4850382 flags 2
[70990.689346] 		tree block key (118895093 1 0) level 0
[70990.689346] 		ref#0: shared block backref parent 56268633030656
[70990.689348] 	item 26 key (22566682001408 168 16384) itemoff 14906
itemsize 51
[70990.689348] 		extent refs 1 gen 4299011 flags 2
[70990.689349] 		tree block key (587743785 1 0) level 0
[70990.689349] 		ref#0: tree block backref root 5
[70990.689350] 	item 27 key (22566682017792 168 16384) itemoff 14855
itemsize 51
[70990.689351] 		extent refs 1 gen 4301682 flags 2
[70990.689352] 		tree block key (588132963 84 1440329257) level 0
[70990.689352] 		ref#0: tree block backref root 5
[70990.689353] 	item 28 key (22566682034176 168 16384) itemoff 14804
itemsize 51
[70990.689354] 		extent refs 1 gen 4274325 flags 2
[70990.689355] 		tree block key (582947076 108 0) level 0
[70990.689355] 		ref#0: shared block backref parent 56267840716800
[70990.689356] 	item 29 key (22566682050560 168 16384) itemoff 14753
itemsize 51
[70990.689357] 		extent refs 1 gen 4415165 flags 2
[70990.689358] 		tree block key (602851940 12 602833949) level 0
[70990.689358] 		ref#0: tree block backref root 5
[70990.689359] 	item 30 key (22566682066944 168 16384) itemoff 14702
itemsize 51
[70990.689360] 		extent refs 1 gen 3963441 flags 258
[70990.689360] 		tree block key (328 108 348078346240) level 0
[70990.689361] 		ref#0: shared block backref parent 24608194379776
[70990.689362] 	item 31 key (22566682083328 168 16384) itemoff 14651
itemsize 51
[70990.689363] 		extent refs 1 gen 5023448 flags 2
[70990.689363] 		tree block key (21751457169408 168 4096) level 0
[70990.689364] 		ref#0: tree block backref root 2
[70990.689365] 	item 32 key (22566682099712 168 16384) itemoff 14600
itemsize 51
[70990.689366] 		extent refs 1 gen 4252351 flags 2
[70990.689366] 		tree block key (579463170 84 4129464922) level 0
[70990.689367] 		ref#0: tree block backref root 5
[70990.689368] 	item 33 key (22566682116096 168 16384) itemoff 14549
itemsize 51
[70990.689368] 		extent refs 1 gen 4485190 flags 2
[70990.689369] 		tree block key (376592764 12 376592763) level 0
[70990.689369] 		ref#0: tree block backref root 5
[70990.689371] 	item 34 key (22566682132480 168 16384) itemoff 14498
itemsize 51
[70990.689371] 		extent refs 1 gen 4422862 flags 2
[70990.689372] 		tree block key (604308022 1 0) level 0
[70990.689372] 		ref#0: shared block backref parent 24625417060352
[70990.689373] 	item 35 key (22566682148864 168 16384) itemoff 14447
itemsize 51
[70990.689374] 		extent refs 1 gen 4481525 flags 2
[70990.689375] 		tree block key (621590482 108 0) level 0
[70990.689375] 		ref#0: shared block backref parent 56068675993600
[70990.689376] 	item 36 key (22566682165248 168 16384) itemoff 14396
itemsize 51
[70990.689377] 		extent refs 1 gen 4478217 flags 2
[70990.689378] 		tree block key (620063095 108 0) level 0
[70990.689378] 		ref#0: tree block backref root 5
[70990.689379] 	item 37 key (22566682181632 168 16384) itemoff 14345
itemsize 51
[70990.689380] 		extent refs 1 gen 4485190 flags 2
[70990.689380] 		tree block key (376592776 1 0) level 0
[70990.689381] 		ref#0: tree block backref root 5
[70990.689382] 	item 38 key (22566682198016 168 16384) itemoff 14294
itemsize 51
[70990.689383] 		extent refs 1 gen 4422862 flags 2
[70990.689383] 		tree block key (604308064 108 0) level 0
[70990.689384] 		ref#0: shared block backref parent 24625417060352
[70990.689385] 	item 39 key (22566682214400 168 16384) itemoff 14243
itemsize 51
[70990.689385] 		extent refs 1 gen 4915102 flags 2
[70990.689386] 		tree block key (737648473 1 0) level 0
[70990.689386] 		ref#0: shared block backref parent 56262596591616
[70990.689388] 	item 40 key (22566682230784 168 16384) itemoff 14192
itemsize 51
[70990.689388] 		extent refs 1 gen 4453119 flags 2
[70990.689389] 		tree block key (615912006 1 0) level 0
[70990.689389] 		ref#0: tree block backref root 5
[70990.689391] 	item 41 key (22566682247168 168 16384) itemoff 14141
itemsize 51
[70990.689391] 		extent refs 1 gen 4751329 flags 2
[70990.689392] 		tree block key (701953831 1 0) level 0
[70990.689392] 		ref#0: shared block backref parent 24626253889536
[70990.689393] 	item 42 key (22566682263552 168 16384) itemoff 14090
itemsize 51
[70990.689394] 		extent refs 1 gen 4485190 flags 2
[70990.689395] 		tree block key (376592795 12 376592794) level 0
[70990.689395] 		ref#0: tree block backref root 5
[70990.689396] 	item 43 key (22566682279936 168 16384) itemoff 14039
itemsize 51
[70990.689397] 		extent refs 1 gen 4453119 flags 2
[70990.689397] 		tree block key (615912052 1 0) level 0
[70990.689398] 		ref#0: tree block backref root 5
[70990.689399] 	item 44 key (22566682296320 168 16384) itemoff 13988
itemsize 51
[70990.689400] 		extent refs 1 gen 4485190 flags 2
[70990.689400] 		tree block key (376592812 1 0) level 0
[70990.689401] 		ref#0: tree block backref root 5
[70990.689402] 	item 45 key (22566682312704 168 16384) itemoff 13937
itemsize 51
[70990.689402] 		extent refs 1 gen 5023096 flags 258
[70990.689403] 		tree block key (570610468 108 0) level 0
[70990.689403] 		ref#0: shared block backref parent 56267826331648
[70990.689405] 	item 46 key (22566682329088 168 16384) itemoff 13886
itemsize 51
[70990.689405] 		extent refs 1 gen 5023448 flags 2
[70990.689406] 		tree block key (21751457169408 178 1007496933981820108)
level 0
[70990.689406] 		ref#0: tree block backref root 2
[70990.689408] 	item 47 key (22566682345472 168 16384) itemoff 13835
itemsize 51
[70990.689408] 		extent refs 1 gen 4301682 flags 2
[70990.689409] 		tree block key (588132963 84 2868119543) level 0
[70990.689409] 		ref#0: tree block backref root 5
[70990.689410] 	item 48 key (22566682361856 168 16384) itemoff 13784
itemsize 51
[70990.689411] 		extent refs 1 gen 4485190 flags 2
[70990.689412] 		tree block key (376592845 96 20) level 0
[70990.689412] 		ref#0: tree block backref root 5
[70990.689413] 	item 49 key (22566682378240 168 16384) itemoff 13733
itemsize 51
[70990.689414] 		extent refs 1 gen 4915102 flags 2
[70990.689414] 		tree block key (737648515 1 0) level 0
[70990.689415] 		ref#0: shared block backref parent 56262596591616
[70990.689416] 	item 50 key (22566682411008 168 16384) itemoff 13682
itemsize 51
[70990.689417] 		extent refs 1 gen 4485190 flags 2
[70990.689417] 		tree block key (376592872 1 0) level 0
[70990.689418] 		ref#0: tree block backref root 5
[70990.689419] 	item 51 key (22566682427392 168 16384) itemoff 13631
itemsize 51
[70990.689419] 		extent refs 1 gen 4850485 flags 2
[70990.689420] 		tree block key (511549066 108 0) level 0
[70990.689420] 		ref#0: tree block backref root 5
[70990.689422] 	item 52 key (22566682443776 168 16384) itemoff 13580
itemsize 51
[70990.689422] 		extent refs 1 gen 4158091 flags 2
[70990.689423] 		tree block key (564446882 1 0) level 0
[70990.689423] 		ref#0: shared block backref parent 24625419403264
[70990.689424] 	item 53 key (22566682460160 168 16384) itemoff 13529
itemsize 51
[70990.689425] 		extent refs 1 gen 4301682 flags 2
[70990.689426] 		tree block key (588132963 84 558498297) level 0
[70990.689426] 		ref#0: tree block backref root 5
[70990.689427] 	item 54 key (22566682476544 168 16384) itemoff 13478
itemsize 51
[70990.689428] 		extent refs 1 gen 4485190 flags 2
[70990.689429] 		tree block key (376592882 96 291) level 0
[70990.689429] 		ref#0: tree block backref root 5
[70990.689430] 	item 55 key (22566682492928 168 16384) itemoff 13427
itemsize 51
[70990.689431] 		extent refs 1 gen 4301682 flags 2
[70990.689431] 		tree block key (588132963 84 1204569644) level 0
[70990.689432] 		ref#0: tree block backref root 5
[70990.689433] 	item 56 key (22566682509312 168 16384) itemoff 13376
itemsize 51
[70990.689434] 		extent refs 1 gen 4447665 flags 2
[70990.689434] 		tree block key (614889298 96 109351) level 0
[70990.689435] 		ref#0: tree block backref root 5
[70990.689436] 	item 57 key (22566682525696 168 16384) itemoff 13325
itemsize 51
[70990.689436] 		extent refs 1 gen 4485190 flags 2
[70990.689437] 		tree block key (376592898 108 0) level 0
[70990.689437] 		ref#0: tree block backref root 5
[70990.689439] 	item 58 key (22566682542080 168 16384) itemoff 13274
itemsize 51
[70990.689439] 		extent refs 1 gen 3871319 flags 2
[70990.689440] 		tree block key (79175605 108 524288) level 0
[70990.689440] 		ref#0: tree block backref root 5
[70990.689442] 	item 59 key (22566682558464 168 16384) itemoff 13223
itemsize 51
[70990.689442] 		extent refs 1 gen 4485190 flags 2
[70990.689443] 		tree block key (376592926 12 376592882) level 0
[70990.689443] 		ref#0: tree block backref root 5
[70990.689444] 	item 60 key (22566682574848 168 16384) itemoff 13172
itemsize 51
[70990.689445] 		extent refs 1 gen 4301682 flags 2
[70990.689446] 		tree block key (588132963 84 3578086199) level 0
[70990.689446] 		ref#0: tree block backref root 5
[70990.689447] 	item 61 key (22566682591232 168 16384) itemoff 13121
itemsize 51
[70990.689448] 		extent refs 1 gen 4290737 flags 2
[70990.689448] 		tree block key (586177863 96 8286) level 0
[70990.689449] 		ref#0: tree block backref root 5
[70990.689450] 	item 62 key (22566682607616 168 16384) itemoff 13070
itemsize 51
[70990.689451] 		extent refs 1 gen 4301682 flags 2
[70990.689451] 		tree block key (588132963 84 4202331249) level 0
[70990.689452] 		ref#0: tree block backref root 5
[70990.689453] 	item 63 key (22566682624000 168 16384) itemoff 13019
itemsize 51
[70990.689453] 		extent refs 1 gen 4485190 flags 2
[70990.689454] 		tree block key (376592975 108 0) level 0
[70990.689454] 		ref#0: tree block backref root 5
[70990.689456] 	item 64 key (22566682640384 168 16384) itemoff 12968
itemsize 51
[70990.689456] 		extent refs 1 gen 4485190 flags 2
[70990.689457] 		tree block key (376592990 12 376592882) level 0
[70990.689457] 		ref#0: tree block backref root 5
[70990.689458] 	item 65 key (22566682656768 168 16384) itemoff 12917
itemsize 51
[70990.689459] 		extent refs 1 gen 4158091 flags 2
[70990.689460] 		tree block key (564403549 96 43216) level 0
[70990.689460] 		ref#0: tree block backref root 5
[70990.689461] 	item 66 key (22566682673152 168 16384) itemoff 12866
itemsize 51
[70990.689462] 		extent refs 1 gen 4453119 flags 2
[70990.689463] 		tree block key (615912098 1 0) level 0
[70990.689463] 		ref#0: tree block backref root 5
[70990.689464] 	item 67 key (22566682689536 168 16384) itemoff 12815
itemsize 51
[70990.689465] 		extent refs 1 gen 4485190 flags 2
[70990.689465] 		tree block key (376593006 1 0) level 0
[70990.689466] 		ref#0: tree block backref root 5
[70990.689467] 	item 68 key (22566682705920 168 16384) itemoff 12764
itemsize 51
[70990.689467] 		extent refs 1 gen 4850337 flags 2
[70990.689468] 		tree block key (41387852 108 0) level 0
[70990.689469] 		ref#0: tree block backref root 5
[70990.689470] 	item 69 key (22566682722304 168 16384) itemoff 12713
itemsize 51
[70990.689470] 		extent refs 1 gen 4453119 flags 2
[70990.689471] 		tree block key (615912144 1 0) level 0
[70990.689471] 		ref#0: tree block backref root 5
[70990.689473] 	item 70 key (22566682738688 168 16384) itemoff 12662
itemsize 51
[70990.689473] 		extent refs 1 gen 4485190 flags 2
[70990.689474] 		tree block key (376593021 108 0) level 0
[70990.689474] 		ref#0: tree block backref root 5
[70990.689475] 	item 71 key (22566682755072 168 16384) itemoff 12611
itemsize 51
[70990.689476] 		extent refs 1 gen 4301682 flags 2
[70990.689477] 		tree block key (588132963 84 1083458397) level 0
[70990.689477] 		ref#0: tree block backref root 5
[70990.689478] 	item 72 key (22566682771456 168 16384) itemoff 12560
itemsize 51
[70990.689479] 		extent refs 1 gen 4158091 flags 2
[70990.689480] 		tree block key (564446924 108 0) level 0
[70990.689480] 		ref#0: shared block backref parent 24625419403264
[70990.689481] 	item 73 key (22566682787840 168 16384) itemoff 12509
itemsize 51
[70990.689482] 		extent refs 1 gen 4485190 flags 2
[70990.689482] 		tree block key (376593037 1 0) level 0
[70990.689483] 		ref#0: tree block backref root 5
[70990.689484] 	item 74 key (22566682804224 168 16384) itemoff 12458
itemsize 51
[70990.689484] 		extent refs 1 gen 4485190 flags 2
[70990.689485] 		tree block key (376593052 108 0) level 0
[70990.689486] 		ref#0: tree block backref root 5
[70990.689487] 	item 75 key (22566682820608 168 16384) itemoff 12407
itemsize 51
[70990.689487] 		extent refs 1 gen 4485251 flags 2
[70990.689488] 		tree block key (514106804 108 0) level 0
[70990.689488] 		ref#0: tree block backref root 5
[70990.689489] 	item 76 key (22566682836992 168 16384) itemoff 12356
itemsize 51
[70990.689490] 		extent refs 1 gen 4485251 flags 2
[70990.689491] 		tree block key (514106814 108 0) level 0
[70990.689491] 		ref#0: tree block backref root 5
[70990.689492] 	item 77 key (22566682853376 168 16384) itemoff 12305
itemsize 51
[70990.689493] 		extent refs 1 gen 4301682 flags 2
[70990.689494] 		tree block key (588132963 84 1030321547) level 0
[70990.689494] 		ref#0: tree block backref root 5
[70990.689495] 	item 78 key (22566682886144 168 16384) itemoff 12254
itemsize 51
[70990.689496] 		extent refs 1 gen 4485190 flags 2
[70990.689496] 		tree block key (376593068 108 0) level 0
[70990.689497] 		ref#0: tree block backref root 5
[70990.689498] 	item 79 key (22566682918912 168 16384) itemoff 12203
itemsize 51
[70990.689498] 		extent refs 1 gen 4301682 flags 2
[70990.689499] 		tree block key (588132963 84 3497237588) level 0
[70990.689500] 		ref#0: tree block backref root 5
[70990.689501] 	item 80 key (22566682935296 168 16384) itemoff 12152
itemsize 51
[70990.689501] 		extent refs 1 gen 4241171 flags 2
[70990.689502] 		tree block key (577613991 1 0) level 0
[70990.689502] 		ref#0: tree block backref root 5
[70990.689503] 	item 81 key (22566682951680 168 16384) itemoff 12101
itemsize 51
[70990.689504] 		extent refs 1 gen 4485190 flags 2
[70990.689505] 		tree block key (376593084 108 0) level 0
[70990.689505] 		ref#0: tree block backref root 5
[70990.689506] 	item 82 key (22566682968064 168 16384) itemoff 12050
itemsize 51
[70990.689507] 		extent refs 1 gen 4485190 flags 2
[70990.689508] 		tree block key (376593100 108 0) level 0
[70990.689508] 		ref#0: tree block backref root 5
[70990.689509] 	item 83 key (22566682984448 168 16384) itemoff 11999
itemsize 51
[70990.689510] 		extent refs 1 gen 4485226 flags 2
[70990.689510] 		tree block key (507513680 1 0) level 0
[70990.689511] 		ref#0: tree block backref root 5
[70990.689512] 	item 84 key (22566683000832 168 16384) itemoff 11948
itemsize 51
[70990.689512] 		extent refs 1 gen 4478217 flags 2
[70990.689513] 		tree block key (620048447 96 14613) level 0
[70990.689514] 		ref#0: tree block backref root 5
[70990.689515] 	item 85 key (22566683017216 168 16384) itemoff 11897
itemsize 51
[70990.689515] 		extent refs 1 gen 4301682 flags 2
[70990.689516] 		tree block key (588132963 84 3927223752) level 0
[70990.689516] 		ref#0: tree block backref root 5
[70990.689518] 	item 86 key (22566683033600 168 16384) itemoff 11846
itemsize 51
[70990.689518] 		extent refs 1 gen 4485251 flags 2
[70990.689519] 		tree block key (514106823 1 0) level 0
[70990.689519] 		ref#0: tree block backref root 5
[70990.689520] 	item 87 key (22566683049984 168 16384) itemoff 11795
itemsize 51
[70990.689521] 		extent refs 1 gen 4485226 flags 2
[70990.689522] 		tree block key (507513704 12 507804680) level 0
[70990.689522] 		ref#0: tree block backref root 5
[70990.689523] 	item 88 key (22566683066368 168 16384) itemoff 11744
itemsize 51
[70990.689524] 		extent refs 1 gen 4139476 flags 2
[70990.689524] 		tree block key (561008662 1 0) level 0
[70990.689525] 		ref#0: tree block backref root 5
[70990.689526] 	item 89 key (22566683082752 168 16384) itemoff 11693
itemsize 51
[70990.689527] 		extent refs 1 gen 4301682 flags 2
[70990.689527] 		tree block key (588132963 84 467210338) level 0
[70990.689528] 		ref#0: tree block backref root 5
[70990.689529] 	item 90 key (22566683099136 168 16384) itemoff 11642
itemsize 51
[70990.689529] 		extent refs 1 gen 4301682 flags 2
[70990.689530] 		tree block key (588132963 84 1527294668) level 0
[70990.689530] 		ref#0: tree block backref root 5
[70990.689532] 	item 91 key (22566683115520 168 16384) itemoff 11591
itemsize 51
[70990.689532] 		extent refs 1 gen 4301682 flags 2
[70990.689533] 		tree block key (588132963 84 1491525260) level 0
[70990.689533] 		ref#0: tree block backref root 5
[70990.689534] 	item 92 key (22566683131904 168 16384) itemoff 11540
itemsize 51
[70990.689535] 		extent refs 1 gen 4485251 flags 2
[70990.689536] 		tree block key (514106836 108 0) level 0
[70990.689536] 		ref#0: tree block backref root 5
[70990.689537] 	item 93 key (22566683148288 168 16384) itemoff 11489
itemsize 51
[70990.689538] 		extent refs 1 gen 4850337 flags 2
[70990.689538] 		tree block key (41387860 108 0) level 0
[70990.689539] 		ref#0: tree block backref root 5
[70990.689540] 	item 94 key (22566683164672 168 16384) itemoff 11438
itemsize 51
[70990.689541] 		extent refs 1 gen 4485251 flags 2
[70990.689541] 		tree block key (514106857 1 0) level 0
[70990.689542] 		ref#0: tree block backref root 5
[70990.689543] 	item 95 key (22566683181056 168 16384) itemoff 11387
itemsize 51
[70990.689543] 		extent refs 1 gen 4485190 flags 2
[70990.689544] 		tree block key (376593116 108 0) level 0
[70990.689544] 		ref#0: tree block backref root 5
[70990.689546] 	item 96 key (22566683197440 168 16384) itemoff 11336
itemsize 51
[70990.689546] 		extent refs 1 gen 4453119 flags 2
[70990.689547] 		tree block key (615816665 96 95434) level 0
[70990.689547] 		ref#0: tree block backref root 5
[70990.689548] 	item 97 key (22566683213824 168 16384) itemoff 11285
itemsize 51
[70990.689549] 		extent refs 1 gen 4485190 flags 2
[70990.689550] 		tree block key (376593132 108 0) level 0
[70990.689550] 		ref#0: tree block backref root 5
[70990.689551] 	item 98 key (22566683230208 168 16384) itemoff 11234
itemsize 51
[70990.689552] 		extent refs 1 gen 4301682 flags 2
[70990.689552] 		tree block key (588132963 84 1372603877) level 0
[70990.689553] 		ref#0: tree block backref root 5
[70990.689554] 	item 99 key (22566683246592 168 16384) itemoff 11183
itemsize 51
[70990.689555] 		extent refs 1 gen 4485190 flags 2
[70990.689555] 		tree block key (376593148 108 0) level 0
[70990.689556] 		ref#0: tree block backref root 5
[70990.689557] 	item 100 key (22566683262976 168 16384) itemoff 11132
itemsize 51
[70990.689557] 		extent refs 1 gen 4301682 flags 2
[70990.689558] 		tree block key (588132963 84 113680255) level 0
[70990.689559] 		ref#0: tree block backref root 5
[70990.689560] 	item 101 key (22566683279360 168 16384) itemoff 11081
itemsize 51
[70990.689560] 		extent refs 1 gen 4485190 flags 2
[70990.689561] 		tree block key (376593164 1 0) level 0
[70990.689561] 		ref#0: tree block backref root 5
[70990.689563] 	item 102 key (22566683295744 168 16384) itemoff 11030
itemsize 51
[70990.689563] 		extent refs 1 gen 4485251 flags 2
[70990.689564] 		tree block key (514106869 108 0) level 0
[70990.689564] 		ref#0: tree block backref root 5
[70990.689565] 	item 103 key (22566683312128 168 16384) itemoff 10979
itemsize 51
[70990.689566] 		extent refs 1 gen 4301682 flags 2
[70990.689567] 		tree block key (588132963 84 25825195) level 0
[70990.689567] 		ref#0: tree block backref root 5
[70990.689568] 	item 104 key (22566683328512 168 16384) itemoff 10928
itemsize 51
[70990.689569] 		extent refs 1 gen 4139476 flags 2
[70990.689570] 		tree block key (561008708 1 0) level 0
[70990.689570] 		ref#0: tree block backref root 5
[70990.689571] 	item 105 key (22566683344896 168 16384) itemoff 10877
itemsize 51
[70990.689572] 		extent refs 1 gen 4301682 flags 2
[70990.689572] 		tree block key (588132963 84 2956350278) level 0
[70990.689573] 		ref#0: tree block backref root 5
[70990.689574] 	item 106 key (22566683361280 168 16384) itemoff 10826
itemsize 51
[70990.689575] 		extent refs 1 gen 4282705 flags 2
[70990.689575] 		tree block key (584471465 108 0) level 0
[70990.689576] 		ref#0: shared block backref parent 18770019352576
[70990.689577] 	item 107 key (22566683377664 168 16384) itemoff 10775
itemsize 51
[70990.689577] 		extent refs 1 gen 4485190 flags 2
[70990.689578] 		tree block key (376593180 108 0) level 0
[70990.689578] 		ref#0: tree block backref root 5
[70990.689580] 	item 108 key (22566683394048 168 16384) itemoff 10724
itemsize 51
[70990.689580] 		extent refs 1 gen 4485190 flags 2
[70990.689581] 		tree block key (376593197 1 0) level 0
[70990.689581] 		ref#0: tree block backref root 5
[70990.689582] 	item 109 key (22566683410432 168 16384) itemoff 10673
itemsize 51
[70990.689583] 		extent refs 1 gen 4301682 flags 2
[70990.689584] 		tree block key (588132963 84 3214189081) level 0
[70990.689584] 		ref#0: tree block backref root 5
[70990.689585] 	item 110 key (22566683426816 168 16384) itemoff 10622
itemsize 51
[70990.689586] 		extent refs 1 gen 4485190 flags 2
[70990.689586] 		tree block key (376593213 108 0) level 0
[70990.689587] 		ref#0: tree block backref root 5
[70990.689588] 	item 111 key (22566683443200 168 16384) itemoff 10571
itemsize 51
[70990.689589] 		extent refs 1 gen 4301682 flags 2
[70990.689589] 		tree block key (588132963 84 3218118645) level 0
[70990.689590] 		ref#0: tree block backref root 5
[70990.689591] 	item 112 key (22566683459584 168 16384) itemoff 10520
itemsize 51
[70990.689591] 		extent refs 1 gen 4453119 flags 2
[70990.689592] 		tree block key (615912190 1 0) level 0
[70990.689592] 		ref#0: tree block backref root 5
[70990.689594] 	item 113 key (22566683475968 168 16384) itemoff 10469
itemsize 51
[70990.689594] 		extent refs 1 gen 4301682 flags 2
[70990.689595] 		tree block key (588132963 84 1422052175) level 0
[70990.689595] 		ref#0: tree block backref root 5
[70990.689596] 	item 114 key (22566683492352 168 16384) itemoff 10418
itemsize 51
[70990.689597] 		extent refs 1 gen 4850485 flags 2
[70990.689598] 		tree block key (511549086 108 0) level 0
[70990.689598] 		ref#0: tree block backref root 5
[70990.689599] 	item 115 key (22566683508736 168 16384) itemoff 10367
itemsize 51
[70990.689600] 		extent refs 1 gen 4241171 flags 2
[70990.689600] 		tree block key (577614027 12 577610237) level 0
[70990.689601] 		ref#0: tree block backref root 5
[70990.689602] 	item 116 key (22566683525120 168 16384) itemoff 10316
itemsize 51
[70990.689603] 		extent refs 1 gen 4301682 flags 2
[70990.689603] 		tree block key (588132963 84 3091222936) level 0
[70990.689604] 		ref#0: tree block backref root 5
[70990.689605] 	item 117 key (22566683541504 168 16384) itemoff 10265
itemsize 51
[70990.689605] 		extent refs 1 gen 4241171 flags 2
[70990.689606] 		tree block key (577610237 96 3748) level 0
[70990.689606] 		ref#0: tree block backref root 5
[70990.689608] 	item 118 key (22566683557888 168 16384) itemoff 10214
itemsize 51
[70990.689608] 		extent refs 1 gen 4485190 flags 2
[70990.689609] 		tree block key (376593245 12 376591703) level 0
[70990.689609] 		ref#0: tree block backref root 5
[70990.689610] 	item 119 key (22566683574272 168 16384) itemoff 10163
itemsize 51
[70990.689611] 		extent refs 1 gen 4485251 flags 2
[70990.689612] 		tree block key (514106881 108 0) level 0
[70990.689612] 		ref#0: tree block backref root 5
[70990.689613] 	item 120 key (22566683590656 168 16384) itemoff 10112
itemsize 51
[70990.689614] 		extent refs 1 gen 4241171 flags 2
[70990.689614] 		tree block key (577614049 12 577610237) level 0
[70990.689615] 		ref#0: tree block backref root 5
[70990.689616] 	item 121 key (22566683607040 168 16384) itemoff 10061
itemsize 51
[70990.689616] 		extent refs 1 gen 4485190 flags 2
[70990.689617] 		tree block key (376593262 12 376593245) level 0
[70990.689617] 		ref#0: tree block backref root 5
[70990.689619] 	item 122 key (22566683623424 168 16384) itemoff 10010
itemsize 51
[70990.689619] 		extent refs 1 gen 4241171 flags 2
[70990.689620] 		tree block key (577614068 1 0) level 0
[70990.689620] 		ref#0: tree block backref root 5
[70990.689621] 	item 123 key (22566683639808 168 16384) itemoff 9959
itemsize 51
[70990.689622] 		extent refs 1 gen 4850485 flags 2
[70990.689623] 		tree block key (511549117 108 0) level 0
[70990.689623] 		ref#0: tree block backref root 5
[70990.689624] 	item 124 key (22566683656192 168 16384) itemoff 9908
itemsize 51
[70990.689625] 		extent refs 1 gen 5023448 flags 2
[70990.689626] 		tree block key (21751457173504 178 1007496932925245727)
level 0
[70990.689626] 		ref#0: tree block backref root 2
[70990.689627] 	item 125 key (22566683672576 168 16384) itemoff 9857
itemsize 51
[70990.689628] 		extent refs 1 gen 4485251 flags 2
[70990.689628] 		tree block key (514106890 108 0) level 0
[70990.689629] 		ref#0: tree block backref root 5
[70990.689630] 	item 126 key (22566683688960 168 16384) itemoff 9806
itemsize 51
[70990.689630] 		extent refs 1 gen 4453119 flags 2
[70990.689631] 		tree block key (615912236 1 0) level 0
[70990.689632] 		ref#0: tree block backref root 5
[70990.689633] 	item 127 key (22566683705344 168 16384) itemoff 9755
itemsize 51
[70990.689633] 		extent refs 1 gen 4241171 flags 2
[70990.689634] 		tree block key (577614095 1 0) level 0
[70990.689634] 		ref#0: tree block backref root 5
[70990.689635] 	item 128 key (22566683721728 168 16384) itemoff 9704
itemsize 51
[70990.689636] 		extent refs 1 gen 4301682 flags 2
[70990.689637] 		tree block key (588132963 84 1966710761) level 0
[70990.689637] 		ref#0: tree block backref root 5
[70990.689638] 	item 129 key (22566683738112 168 16384) itemoff 9653
itemsize 51
[70990.689639] 		extent refs 1 gen 4850485 flags 2
[70990.689640] 		tree block key (511519986 84 3684143889) level 0
[70990.689640] 		ref#0: tree block backref root 5
[70990.689641] 	item 130 key (22566683754496 168 16384) itemoff 9602
itemsize 51
[70990.689642] 		extent refs 1 gen 4158091 flags 2
[70990.689642] 		tree block key (564446967 12 564403549) level 0
[70990.689643] 		ref#0: shared block backref parent 24625419403264
[70990.689644] 	item 131 key (22566683770880 168 16384) itemoff 9551
itemsize 51
[70990.689645] 		extent refs 1 gen 4850485 flags 2
[70990.689645] 		tree block key (511549128 1 0) level 0
[70990.689646] 		ref#0: tree block backref root 5
[70990.689647] 	item 132 key (22566683787264 168 16384) itemoff 9500
itemsize 51
[70990.689647] 		extent refs 1 gen 4485190 flags 2
[70990.689648] 		tree block key (376593281 12 376593245) level 0
[70990.689648] 		ref#0: tree block backref root 5
[70990.689650] 	item 133 key (22566683803648 168 16384) itemoff 9449
itemsize 51
[70990.689650] 		extent refs 1 gen 4241171 flags 2
[70990.689651] 		tree block key (577614132 108 0) level 0
[70990.689651] 		ref#0: tree block backref root 5
[70990.689652] 	item 134 key (22566683820032 168 16384) itemoff 9398
itemsize 51
[70990.689653] 		extent refs 1 gen 4485190 flags 2
[70990.689654] 		tree block key (376593297 108 0) level 0
[70990.689654] 		ref#0: tree block backref root 5
[70990.689655] 	item 135 key (22566683836416 168 16384) itemoff 9347
itemsize 51
[70990.689656] 		extent refs 1 gen 4453119 flags 2
[70990.689656] 		tree block key (615912282 1 0) level 0
[70990.689657] 		ref#0: tree block backref root 5
[70990.689658] 	item 136 key (22566683852800 168 16384) itemoff 9296
itemsize 51
[70990.689658] 		extent refs 1 gen 4850485 flags 2
[70990.689659] 		tree block key (511549139 108 0) level 0
[70990.689660] 		ref#0: tree block backref root 5
[70990.689661] 	item 137 key (22566683869184 168 16384) itemoff 9245
itemsize 51
[70990.689661] 		extent refs 1 gen 4485251 flags 2
[70990.689662] 		tree block key (514106900 108 0) level 0
[70990.689662] 		ref#0: tree block backref root 5
[70990.689663] 	item 138 key (22566683885568 168 16384) itemoff 9194
itemsize 51
[70990.689664] 		extent refs 1 gen 4485251 flags 2
[70990.689665] 		tree block key (514106910 108 0) level 0
[70990.689665] 		ref#0: tree block backref root 5
[70990.689666] 	item 139 key (22566683901952 168 16384) itemoff 9143
itemsize 51
[70990.689667] 		extent refs 1 gen 4453119 flags 2
[70990.689668] 		tree block key (615816665 96 95582) level 0
[70990.689668] 		ref#0: tree block backref root 5
[70990.689669] 	item 140 key (22566683918336 168 16384) itemoff 9092
itemsize 51
[70990.689670] 		extent refs 1 gen 5023448 flags 2
[70990.689670] 		tree block key (21751457177600 178 1007496935602293784)
level 0
[70990.689671] 		ref#0: tree block backref root 2
[70990.689672] 	item 141 key (22566683934720 168 16384) itemoff 9041
itemsize 51
[70990.689672] 		extent refs 1 gen 4485190 flags 2
[70990.689673] 		tree block key (376593319 84 2526080920) level 0
[70990.689674] 		ref#0: tree block backref root 5
[70990.689675] 	item 142 key (22566683951104 168 16384) itemoff 8990
itemsize 51
[70990.689675] 		extent refs 1 gen 4850337 flags 2
[70990.689676] 		tree block key (41387871 1 0) level 0
[70990.689676] 		ref#0: tree block backref root 5
[70990.689677] 	item 143 key (22566683967488 168 16384) itemoff 8939
itemsize 51
[70990.689678] 		extent refs 1 gen 4241171 flags 2
[70990.689679] 		tree block key (577610237 96 3869) level 0
[70990.689679] 		ref#0: tree block backref root 5
[70990.689680] 	item 144 key (22566683983872 168 16384) itemoff 8888
itemsize 51
[70990.689681] 		extent refs 1 gen 4241171 flags 2
[70990.689682] 		tree block key (577614175 108 0) level 0
[70990.689682] 		ref#0: tree block backref root 5
[70990.689683] 	item 145 key (22566684000256 168 16384) itemoff 8837
itemsize 51
[70990.689684] 		extent refs 1 gen 4139476 flags 2
[70990.689684] 		tree block key (560998324 96 10366) level 0
[70990.689685] 		ref#0: tree block backref root 5
[70990.689686] 	item 146 key (22566684016640 168 16384) itemoff 8786
itemsize 51
[70990.689686] 		extent refs 1 gen 4485251 flags 2
[70990.689687] 		tree block key (514106926 1 0) level 0
[70990.689687] 		ref#0: tree block backref root 5
[70990.689689] 	item 147 key (22566684033024 168 16384) itemoff 8735
itemsize 51
[70990.689689] 		extent refs 1 gen 4485190 flags 2
[70990.689690] 		tree block key (376564886 108 0) level 0
[70990.689690] 		ref#0: tree block backref root 5
[70990.689691] 	item 148 key (22566684049408 168 16384) itemoff 8684
itemsize 51
[70990.689692] 		extent refs 1 gen 4485190 flags 2
[70990.689693] 		tree block key (376564894 108 0) level 0
[70990.689693] 		ref#0: tree block backref root 5
[70990.689694] 	item 149 key (22566684065792 168 16384) itemoff 8633
itemsize 51
[70990.689695] 		extent refs 1 gen 4139476 flags 2
[70990.689695] 		tree block key (561008754 1 0) level 0
[70990.689696] 		ref#0: tree block backref root 5
[70990.689697] 	item 150 key (22566684082176 168 16384) itemoff 8582
itemsize 51
[70990.689697] 		extent refs 1 gen 4485251 flags 2
[70990.689698] 		tree block key (514106951 108 0) level 0
[70990.689698] 		ref#0: tree block backref root 5
[70990.689700] 	item 151 key (22566684098560 168 16384) itemoff 8531
itemsize 51
[70990.689700] 		extent refs 1 gen 4485190 flags 2
[70990.689701] 		tree block key (376593324 1 0) level 0
[70990.689701] 		ref#0: tree block backref root 5
[70990.689702] 	item 152 key (22566684114944 168 16384) itemoff 8480
itemsize 51
[70990.689703] 		extent refs 1 gen 4387045 flags 2
[70990.689704] 		tree block key (598281926 12 598261348) level 0
[70990.689704] 		ref#0: tree block backref root 5
[70990.689705] 	item 153 key (22566684131328 168 16384) itemoff 8429
itemsize 51
[70990.689706] 		extent refs 1 gen 4485190 flags 2
[70990.689706] 		tree block key (376593339 108 0) level 0
[70990.689707] 		ref#0: tree block backref root 5
[70990.689708] 	item 154 key (22566684147712 168 16384) itemoff 8378
itemsize 51
[70990.689708] 		extent refs 1 gen 4850485 flags 2
[70990.689709] 		tree block key (511549156 108 0) level 0
[70990.689710] 		ref#0: tree block backref root 5
[70990.689711] 	item 155 key (22566684164096 168 16384) itemoff 8327
itemsize 51
[70990.689711] 		extent refs 1 gen 4241171 flags 2
[70990.689712] 		tree block key (577614208 108 0) level 0
[70990.689712] 		ref#0: tree block backref root 5
[70990.689713] 	item 156 key (22566684180480 168 16384) itemoff 8276
itemsize 51
[70990.689714] 		extent refs 1 gen 4485251 flags 2
[70990.689715] 		tree block key (514106964 108 0) level 0
[70990.689715] 		ref#0: tree block backref root 5
[70990.689716] 	item 157 key (22566684196864 168 16384) itemoff 8225
itemsize 51
[70990.689717] 		extent refs 1 gen 4301682 flags 2
[70990.689717] 		tree block key (588132963 84 1867225020) level 0
[70990.689718] 		ref#0: tree block backref root 5
[70990.689719] 	item 158 key (22566684213248 168 16384) itemoff 8174
itemsize 51
[70990.689720] 		extent refs 1 gen 4485089 flags 2
[70990.689720] 		tree block key (281636307 1 0) level 0
[70990.689721] 		ref#0: tree block backref root 5
[70990.689722] 	item 159 key (22566684229632 168 16384) itemoff 8123
itemsize 51
[70990.689722] 		extent refs 1 gen 4301682 flags 2
[70990.689723] 		tree block key (588132963 84 160509381) level 0
[70990.689724] 		ref#0: tree block backref root 5
[70990.689725] 	item 160 key (22566684246016 168 16384) itemoff 8072
itemsize 51
[70990.689725] 		extent refs 1 gen 4485251 flags 2
[70990.689726] 		tree block key (514106975 108 0) level 0
[70990.689726] 		ref#0: tree block backref root 5
[70990.689728] 	item 161 key (22566684262400 168 16384) itemoff 8021
itemsize 51
[70990.689728] 		extent refs 1 gen 4387045 flags 2
[70990.689729] 		tree block key (598261348 84 2660219736) level 0
[70990.689729] 		ref#0: shared block backref parent 56271821225984
[70990.689730] 	item 162 key (22566684278784 168 16384) itemoff 7970
itemsize 51
[70990.689731] 		extent refs 1 gen 4485190 flags 2
[70990.689732] 		tree block key (376593356 1 0) level 0
[70990.689732] 		ref#0: tree block backref root 5
[70990.689733] 	item 163 key (22566684295168 168 16384) itemoff 7919
itemsize 51
[70990.689734] 		extent refs 1 gen 4485251 flags 2
[70990.689734] 		tree block key (514106993 1 0) level 0
[70990.689735] 		ref#0: tree block backref root 5
[70990.689736] 	item 164 key (22566684311552 168 16384) itemoff 7868
itemsize 51
[70990.689737] 		extent refs 1 gen 4387045 flags 2
[70990.689737] 		tree block key (598281964 108 0) level 0
[70990.689738] 		ref#0: tree block backref root 5
[70990.689739] 	item 165 key (22566684327936 168 16384) itemoff 7817
itemsize 51
[70990.689739] 		extent refs 1 gen 4485190 flags 2
[70990.689740] 		tree block key (376593371 108 0) level 0
[70990.689740] 		ref#0: tree block backref root 5
[70990.689741] 	item 166 key (22566684344320 168 16384) itemoff 7766
itemsize 51
[70990.689742] 		extent refs 1 gen 4850337 flags 2
[70990.689743] 		tree block key (41387881 108 0) level 0
[70990.689743] 		ref#0: tree block backref root 5
[70990.689744] 	item 167 key (22566684360704 168 16384) itemoff 7715
itemsize 51
[70990.689745] 		extent refs 1 gen 4485190 flags 2
[70990.689745] 		tree block key (376593386 108 0) level 0
[70990.689746] 		ref#0: tree block backref root 5
[70990.689747] 	item 168 key (22566684377088 168 16384) itemoff 7664
itemsize 51
[70990.689748] 		extent refs 1 gen 4375793 flags 2
[70990.689748] 		tree block key (596545771 108 0) level 0
[70990.689749] 		ref#0: shared block backref parent 56079002402816
[70990.689750] 	item 169 key (22566684393472 168 16384) itemoff 7613
itemsize 51
[70990.689750] 		extent refs 1 gen 4485284 flags 2
[70990.689751] 		tree block key (520570776 108 13893632) level 0
[70990.689751] 		ref#0: shared block backref parent 56041349529600
[70990.689753] 	item 170 key (22566684409856 168 16384) itemoff 7562
itemsize 51
[70990.689753] 		extent refs 1 gen 4485190 flags 2
[70990.689754] 		tree block key (376593403 108 0) level 0
[70990.689754] 		ref#0: tree block backref root 5
[70990.689755] 	item 171 key (22566684426240 168 16384) itemoff 7511
itemsize 51
[70990.689756] 		extent refs 1 gen 4453119 flags 2
[70990.689757] 		tree block key (615912328 1 0) level 0
[70990.689757] 		ref#0: tree block backref root 5
[70990.689758] 	item 172 key (22566684442624 168 16384) itemoff 7460
itemsize 51
[70990.689759] 		extent refs 1 gen 4485251 flags 2
[70990.689759] 		tree block key (514107015 108 0) level 0
[70990.689760] 		ref#0: tree block backref root 5
[70990.689761] 	item 173 key (22566684459008 168 16384) itemoff 7409
itemsize 51
[70990.689761] 		extent refs 1 gen 4859961 flags 2
[70990.689762] 		tree block key (723918688 12 723910379) level 0
[70990.689763] 		ref#0: shared block backref parent 56043540594688
[70990.689764] 	item 174 key (22566684475392 168 16384) itemoff 7358
itemsize 51
[70990.689764] 		extent refs 1 gen 4387045 flags 2
[70990.689765] 		tree block key (598261348 84 2702349876) level 0
[70990.689765] 		ref#0: shared block backref parent 56271821225984
[70990.689767] 	item 175 key (22566684491776 168 16384) itemoff 7307
itemsize 51
[70990.689767] 		extent refs 1 gen 4485251 flags 2
[70990.689768] 		tree block key (514107025 108 0) level 0
[70990.689768] 		ref#0: tree block backref root 5
[70990.689769] 	item 176 key (22566684508160 168 16384) itemoff 7256
itemsize 51
[70990.689770] 		extent refs 1 gen 4485251 flags 2
[70990.689771] 		tree block key (514107047 108 0) level 0
[70990.689771] 		ref#0: tree block backref root 5
[70990.689772] 	item 177 key (22566684524544 168 16384) itemoff 7205
itemsize 51
[70990.689773] 		extent refs 1 gen 4850485 flags 2
[70990.689773] 		tree block key (511549200 108 0) level 0
[70990.689774] 		ref#0: tree block backref root 5
[70990.689775] 	item 178 key (22566684540928 168 16384) itemoff 7154
itemsize 51
[70990.689775] 		extent refs 1 gen 4850485 flags 2
[70990.689776] 		tree block key (511549207 96 16) level 0
[70990.689777] 		ref#0: tree block backref root 5
[70990.689778] 	item 179 key (22566684557312 168 16384) itemoff 7103
itemsize 51
[70990.689778] 		extent refs 1 gen 4485190 flags 2
[70990.689779] 		tree block key (376593418 96 733) level 0
[70990.689779] 		ref#0: tree block backref root 5
[70990.689780] 	item 180 key (22566684573696 168 16384) itemoff 7052
itemsize 51
[70990.689781] 		extent refs 1 gen 4485190 flags 2
[70990.689782] 		tree block key (376593426 12 376593418) level 0
[70990.689782] 		ref#0: tree block backref root 5
[70990.689783] 	item 181 key (22566684590080 168 16384) itemoff 7001
itemsize 51
[70990.689784] 		extent refs 1 gen 4485251 flags 2
[70990.689785] 		tree block key (514107079 108 0) level 0
[70990.689785] 		ref#0: tree block backref root 5
[70990.689786] 	item 182 key (22566684606464 168 16384) itemoff 6950
itemsize 51
[70990.689787] 		extent refs 1 gen 4485190 flags 2
[70990.689787] 		tree block key (376593480 108 0) level 0
[70990.689788] 		ref#0: tree block backref root 5
[70990.689789] 	item 183 key (22566684622848 168 16384) itemoff 6899
itemsize 51
[70990.689789] 		extent refs 1 gen 4301682 flags 2
[70990.689790] 		tree block key (588132963 84 62158200) level 0
[70990.689790] 		ref#0: tree block backref root 5
[70990.689792] 	item 184 key (22566684639232 168 16384) itemoff 6848
itemsize 51
[70990.689792] 		extent refs 1 gen 4485190 flags 2
[70990.689793] 		tree block key (376593534 108 0) level 0
[70990.689793] 		ref#0: tree block backref root 5
[70990.689794] 	item 185 key (22566684655616 168 16384) itemoff 6797
itemsize 51
[70990.689795] 		extent refs 1 gen 4485251 flags 2
[70990.689796] 		tree block key (514107091 108 0) level 0
[70990.689796] 		ref#0: tree block backref root 5
[70990.689798] BTRFS error (device dm-7): unable to find ref byte nr
22566682869760 parent 0 root 2  owner 0 offset 0
[70990.689819] ------------[ cut here ]------------
[70990.689820] BTRFS: Transaction aborted (error -2)
[70990.689833] WARNING: CPU: 23 PID: 37489 at
fs/btrfs/extent-tree.c:3077 __btrfs_free_extent.isra.0+0x9e4/0xf20 [btrfs]
[70990.689833] Modules linked in: binfmt_misc(E) veth(E) xt_tcpudp(E)
xt_nat(E) wireguard(OE) ip6_udp_tunnel(E) udp_tunnel(E) essiv(E)
authenc(E) nft_counter(E) nft_chain_nat(E) xt_MASQUERADE(E) nf_nat(E)
nf_conntrack(E) nf_defrag_ipv6(E) nf_defrag_ipv4(E) nft_compat(E)
nf_tables(E) nfnetlink(E) btrfs(E) zstd_compress(E) zstd_decompress(E)
amdgpu(E) snd_hda_codec_hdmi(E) ast(E) gpu_sched(E) drm_vram_helper(E)
ttm(E) snd_hda_intel(E) drm_kms_helper(E) snd_hda_codec(E) sg(E)
snd_hda_core(E) snd_hwdep(E) drm(E) uas(E) snd_pcm(E) tg3(E) ofpart(E)
mpt3sas(E) libphy(E) drm_panel_orientation_quirks(E) syscopyarea(E)
snd_timer(E) powernv_flash(E) ipmi_powernv(E) sysfillrect(E)
sysimgblt(E) ipmi_devintf(E) opal_prd(E) fb_sys_fops(E) snd(E) ptp(E)
mtd(E) i2c_algo_bit(E) ipmi_msghandler(E) pps_core(E) raid_class(E)
soundcore(E) scsi_transport_sas(E) at24(E) ip_tables(E) x_tables(E)
autofs4(E) ext4(E) crc16(E) mbcache(E) jbd2(E) sd_mod(E) raid10(E)
raid456(E) crc32c_generic(E) libcrc32c(E)
[70990.689850]  async_raid6_recov(E) async_memcpy(E) async_pq(E)
evdev(E) hid_generic(E) usbhid(E) hid(E) raid6_pq(E) async_xor(E) xor(E)
async_tx(E) raid1(E) raid0(E) multipath(E) linear(E) md_mod(E)
usb_storage(E) dm_crypt(E) dm_mod(E) algif_skcipher(E) af_alg(E)
xhci_pci(E) xhci_hcd(E) usbcore(E) vmx_crypto(E) nvme(E) nvme_core(E)
usb_common(E)
[70990.689858] CPU: 23 PID: 37489 Comm: btrfs-transacti Tainted: G
 W  OE     5.4.0-3-powerpc64le #1 Debian 5.4.14-1
[70990.689860] NIP:  c0080000073928cc LR: c0080000073928c8 CTR:
0000000000000000
[70990.689861] REGS: c000000ead03b650 TRAP: 0700   Tainted: G        W
OE      (5.4.0-3-powerpc64le Debian 5.4.14-1)
[70990.689861] MSR:  9000000002029033 <SF,HV,VEC,EE,ME,IR,DR,RI,LE>  CR:
28022224  XER: 20040000
[70990.689864] CFAR: c00000000012055c IRQMASK: 0
               GPR00: c0080000073928c8 c000000ead03b8e0 c008000007502800
0000000000000025
               GPR04: 0000000000000001 c000200fff047080 0000000000000f19
0000000000000001
               GPR08: 0000000000000007 0000000000000007 0000000000000001
0000000000000000
               GPR12: 0000000000002000 c000000fffff0a00 c000000000155528
0000000000000000
               GPR16: c000000fbcacddd0 0000000000000002 0000000000000000
0000000000000002
               GPR20: c0000000db9a1690 0000000000000000 c00020073eaec000
0000000000000000
               GPR24: c000200acdfe4000 0000000000000000 0000000000000001
0000000000004000
               GPR28: c00000066af57958 0000000000000000 00001486371dc000
fffffffffffffffe
[70990.689879] NIP [c0080000073928cc]
__btrfs_free_extent.isra.0+0x9e4/0xf20 [btrfs]
[70990.689884] LR [c0080000073928c8]
__btrfs_free_extent.isra.0+0x9e0/0xf20 [btrfs]
[70990.689885] Call Trace:
[70990.689891] [c000000ead03b8e0] [c0080000073928c8]
__btrfs_free_extent.isra.0+0x9e0/0xf20 [btrfs] (unreliable)
[70990.689897] [c000000ead03ba10] [c00800000739447c]
__btrfs_run_delayed_refs+0x8c4/0x14f0 [btrfs]
[70990.689903] [c000000ead03bb90] [c008000007395164]
btrfs_run_delayed_refs+0xbc/0x320 [btrfs]
[70990.689910] [c000000ead03bc50] [c0080000073b0604]
btrfs_commit_transaction+0x5bc/0xcf0 [btrfs]
[70990.689917] [c000000ead03bd40] [c0080000073a9d44]
transaction_kthread+0x24c/0x2d0 [btrfs]
[70990.689918] [c000000ead03bdb0] [c000000000155668] kthread+0x148/0x1a0
[70990.689920] [c000000ead03be20] [c00000000000bd54]
ret_from_kernel_thread+0x5c/0x68
[70990.689921] Instruction dump:
[70990.689922] 7d4048a8 7d474378 7ce049ad 40c2fff4 7c0004ac 71490004
4082001c 3d220000
[70990.689925] 3880fffe e8698b30 480f2e6d e8410018 <0fe00000> 3d220000
7f83e378 38c0fffe
[70990.689928] ---[ end trace 336665b21c6bbe65 ]---
[70990.689931] BTRFS: error (device dm-7) in __btrfs_free_extent:3077:
errno=-2 No such entry
[70990.689951] BTRFS info (device dm-7): forced readonly
[70990.689953] BTRFS: error (device dm-7) in
btrfs_run_delayed_refs:2188: errno=-2 No such entry
[70990.689965] BTRFS warning (device dm-7): Skipping commit of aborted
transaction.
[70990.689967] BTRFS: error (device dm-7) in cleanup_transaction:1828:
errno=-2 No such entry
[70990.778203] BTRFS info (device dm-7): balance: resume
-dusage=90,devid=9,vrange=0..41634339225599
[70990.816444] BTRFS info (device dm-7): balance: ended with status: 0
