Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6153A6E47E1
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Apr 2023 14:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjDQMgB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Apr 2023 08:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjDQMgA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Apr 2023 08:36:00 -0400
X-Greylist: delayed 3571 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 17 Apr 2023 05:35:54 PDT
Received: from mail-41103.protonmail.ch (mail-41103.protonmail.ch [185.70.41.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E4291
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Apr 2023 05:35:54 -0700 (PDT)
Date:   Mon, 17 Apr 2023 11:16:58 +0000
Authentication-Results: mail-41103.protonmail.ch;
        dkim=pass (2048-bit key) header.d=tostr.ch header.i=@tostr.ch header.b="cr1G6aMq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tostr.ch;
        s=protonmail3; t=1681730233; x=1681989433;
        bh=1/Ov3zRk//q21bNOEz+jjOYOWAEd5yVeWQcS1OGnZtE=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=cr1G6aMqC+1FqBuZtyKKTle2s9lnX0I42qP32jM7ZKHQ58/oFQgyAIcCo3zI9M1J2
         ObGtAH06D7Zh6AKDtXVoMVo+wdJDQal07QOwMtbtAj9+rrX4yEkJMYINlkTBItlEsu
         bM5WRHLc6g4mNYLfFhgslOVCmGzU6b/T2owXpExgV369sO5WWOCK5DzXC/6mLV08vk
         XSjtuvfu5pJk4+FfRc/uNVqYFFrLULhiaKMvCAeKok0PcS4O3XK0V0dxp5Y1s8Bhim
         KTdO3XdkSXLUe9FKrItHqWhsoPOgfFcx5uvZaY+/ZLtIBBCqGJq2BMKoXaWzQ+Nzlu
         WvEFXyYdxwbLg==
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
From:   Otto Strassen <otto@tostr.ch>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Filesystem ro mode, check shows a lot of missing backrefs, no idea on how to proceed
Message-ID: <OIBWDuFqZbh7w1v3A2Nxs13HKeULqY96iN3so8KdD5YfpqhzoxglwFYxQj7rS2f2tnz9jMkJFzl4w4jTVSRzw9wuLKCyMv_gkn17caOy1H0=@tostr.ch>
In-Reply-To: <974217d6-0246-3732-0fe5-e443c8158edc@gmx.com>
References: <sY9YYJrpztwzxhv_9p28An7hkWNiF8hHF0we0ToIQ69b3lpaeBc7l77Kd4jYdsXA6Rps73Xa3guq3XA8c3mZdxDIvSwO5Cyh2eeO5Aqh3-s=@tostr.ch> <c3bf3d9d-9be4-713f-64b8-769d2a014d1a@gmx.com> <BWQf5N5kpHk5W540zTSqzDYn2kLi7lwJt-3odaRz1xs751TcwplGjnVGU-ytnar_lcoaKZHghhONSHAdSPtC98yyq52HXIUTCq1x65RWGwU=@tostr.ch> <fb3714a3-ab30-30b0-f336-68e2717b20d8@gmx.com> <vU62kpQ14yw_mYWcogz5KZy0j0wZ_1bNBQnJvvc-zqlqZAYpjFderRCnigBCG3F2Sv5g9PKexYTf9_dO8H1OxDkQQg1Vlz4UZzMmkwsx7Z0=@tostr.ch> <974217d6-0246-3732-0fe5-e443c8158edc@gmx.com>
Feedback-ID: 42428327:user:proton
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha512; boundary="------545e8fdb785ca77864f6e918cc5401db53cab04208ea2b957f0740e96f938927"; charset=utf-8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------545e8fdb785ca77864f6e918cc5401db53cab04208ea2b957f0740e96f938927
Content-Type: multipart/mixed;boundary=---------------------3151515cea3d6b6a1dde5b58be637bbc

-----------------------3151515cea3d6b6a1dde5b58be637bbc
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

------- Original Message -------
On Monday, April 17th, 2023 at 12:54, Qu Wenruo <quwenruo.btrfs@gmx.com> w=
rote:


> =


> On 2023/4/17 18:10, Otto Strassen wrote:
> [...]
> =


> > > That's the tradeoff one has to take when sticking to a specific vend=
or.
> > =


> > > But if you're going to rebuild, then why not just try "btrfs check
> > > --repair" in this case?
> > =


> > Ok, some development here. I had to hard-poweroff the NAS because it h=
ad become completely unresponsive. After that two disks were failed. I rem=
oved them, and re-integrated them (no replacement of disks) and md rebuilt=
 the array (no problems). That in itself I find a bit strange, but maybe I=
 did the poweroff at a very bad time?
> > =


> > Now here is the result from repair etc.
> > =


> > $ btrfs check --clear-space-cache v2 /dev/mapper/cachedev_0
> > # I had to do this before it would let me repair
> > =


> > $ btrfs check --repair /dev/mapper/cachedev_0
> > # Went through the ~50k lines
> > <snip>
> > backpointer mismatch on [21189054693376 16384]
> > =


> > owner ref check failed [21189054693376 16384]
> > =


> > repaired damaged extent references
> > =


> > Fixed 0 roots.
> > =


> > block group cache tree generation not match actul 238649, expect 24074=
1
> > =


> > checking free space cache
> > =


> > checking fs roots
> > =


> > checking csums
> > =


> > checking root refs
> > =


> > found 20419805880336 bytes used err is 0
> > total csum bytes: 938142472
> > total tree bytes: 2908684288
> > =


> > total fs tree bytes: 1667170304
> > total extent tree bytes: 178520064
> > btree space waste bytes: 427759440
> > file data blocks allocated: 28059017342976
> > referenced 26999960571904
> > =


> > $ btrfs check --readonly /dev/mapper/cachedev_0
> > Syno caseless feature on.
> > Checking filesystem on /dev/mapper/cachedev_0
> > UUID: c14c923f-2038-4841-aa89-504f1044d3be
> > checking extents
> > Found dropping subvolume ID:2632 dropping progress: key (458271 INODE_=
REF 457325) level: 1
> > Process dropping snap root: key (2632 ROOT_ITEM 0) dropping progress: =
key (458271 INODE_REF 457325)
> > block group cache tree generation not match actul 238649, expect 24074=
1
> =


> =


> The result is in fact pretty good.
> =


> This means no more extent tree problems.
> =


> The weird part is, I can not find any code responsible outputting above
> 3 lines, the whole "git log -S" shows no match, I doubt if it's some
> Synology proprietary code?
> =


> In that case, I'm not sure what they are handling, especially for the
> "block group cache tree generation" line.
> =


> > checking free space cache
> > checking fs roots
> > checking csums
> > checking root refs
> > found 20419801194496 bytes used err is 0
> > total csum bytes: 938142472
> > total tree bytes: 2907209728
> > total fs tree bytes: 1667170304
> > total extent tree bytes: 177045504
> > btree space waste bytes: 427205612
> > file data blocks allocated: 28059017342976
> > referenced 26999960571904
> > =


> > So there is only one problem left, I ran a second repair (You Don't On=
ly Repair Once), to see what would happen. Same result.
> > =


> > After a reboot the thing is back in ro... So I guess a rebuild it is t=
hen?
> =


> =


> What's the dmesg of the RO flipping?

All logs are filtered 'grep -i btrfs' and limited to today.

This is the dmesg

[   34.596250] systemd[1]: Created slice BTRFS Optimization.
[   34.606240] systemd[1]: Starting BTRFS Optimization.
[   34.657037] systemd[1]: Created slice BTRFS Space Reclaim.
[   34.667201] systemd[1]: Starting BTRFS Space Reclaim.
[   46.361813] Btrfs loaded, crc32c=3Dcrc32c-intel
[   46.366895] BTRFS: device label 2022.05.04-10:06:00 v42218 devid 1 tran=
sid 240742 /dev/mapper/cachedev_0
[   46.376657] BTRFS: device label 2022.05.04-10:06:47 v42218 devid 1 tran=
sid 23878 /dev/mapper/cachedev_1
[   46.386638] BTRFS info (device dm-3): enabling auto syno reclaim space
[   46.393174] BTRFS info (device dm-3): use ssd allocation scheme
[   46.399103] BTRFS info (device dm-3): using free block group cache tree
[   46.405723] BTRFS info (device dm-3): has skinny extents
[   46.411064] BTRFS info (device dm-4): enabling auto syno reclaim space
[   46.417592] BTRFS info (device dm-4): use ssd allocation scheme
[   46.423517] BTRFS info (device dm-4): using free space tree
[   46.429095] BTRFS info (device dm-4): using free block group cache tree
[   46.435711] BTRFS info (device dm-4): has skinny extents
[   46.531776] BTRFS info (device dm-4): BTRFS: root of syno feature tree =
is null
[   46.564148] WARNING: CPU: 0 PID: 11955 at fs/btrfs/disk-io.c:3314 open_=
ctree+0x2fc3/0x3350 [btrfs]()
[   46.573288] Modules linked in: btrfs ecryptfs zstd_decompress zstd_comp=
ress xxhash raid456 async_raid6_recov async_memcpy async_pq async_xor xor =
async_tx raid6_pq leds_lp3943 aesni_intel glue_helper lrw gf128mul openvsw=
itch zram gre ablk_helper nf_defrag_ipv6 bnxt_en(O) nf_conntrack v1000_syn=
obios(PO) hid_generic usbhid hid usblp adt7475 hwmon_vid etxhci_hcd usb_st=
orage bnx2x(O) mdio qede(O) qed(O) mlx5_core(O) mlx4_en(O) mlx4_core(O) ml=
x_compat(O) atlantic_v2(O) atlantic(O) r8168(O) i40e(O) ixgbe(O) amd_xgbe =
marvell10g sg dm_snapshot dm_bufio crc_itu_t crc_ccitt psnap p8022 llc hfs=
plus md4 hmac sit tunnel4 ipv6 flashcache_syno(O) flashcache(O) syno_flash=
cache_control(O) dm_mod arc4 crc32c_intel cryptd ecb aes_x86_64 authenc de=
s_generic ansi_cprng cts md5 cbc cpufreq_powersave cpufreq_performance
[   46.723067]  [<ffffffffa10fe4d3>] open_ctree+0x2fc3/0x3350 [btrfs]
[   46.729255]  [<ffffffffa10ca642>] btrfs_mount+0xaf2/0xc60 [btrfs]
[   46.763310]  [<ffffffffa10c9ce9>] btrfs_mount+0x199/0xc60 [btrfs]
[   47.621353] BTRFS critical (device dm-3): corrupt leaf: block=3D1105429=
5220224 slot=3D76 extent bytenr=3D9957296721920 len=3D589824 invalid gener=
ation, have 4306501632 expect (0, 240743]
[   47.760094] BTRFS critical (device dm-3): corrupt leaf: block=3D1105429=
5220224 slot=3D76 extent bytenr=3D9957296721920 len=3D589824 invalid gener=
ation, have 4306501632 expect (0, 240743]
[   48.146261] BTRFS critical (device dm-3): corrupt leaf: block=3D1105429=
5220224 slot=3D76 extent bytenr=3D9957296721920 len=3D589824 invalid gener=
ation, have 4306501632 expect (0, 240743]
[   48.166801] WARNING: CPU: 5 PID: 4188 at fs/btrfs/disk-io.c:924 btree_i=
o_failed_hook+0x12d/0x220 [btrfs]()
[   48.176452] Modules linked in: synoacl_vfs(PO) btrfs ecryptfs zstd_deco=
mpress zstd_compress xxhash raid456 async_raid6_recov async_memcpy async_p=
q async_xor xor async_tx raid6_pq leds_lp3943 aesni_intel glue_helper lrw =
gf128mul openvswitch zram gre ablk_helper nf_defrag_ipv6 bnxt_en(O) nf_con=
ntrack v1000_synobios(PO) hid_generic usbhid hid usblp adt7475 hwmon_vid e=
txhci_hcd usb_storage bnx2x(O) mdio qede(O) qed(O) mlx5_core(O) mlx4_en(O)=
 mlx4_core(O) mlx_compat(O) atlantic_v2(O) atlantic(O) r8168(O) i40e(O) ix=
gbe(O) amd_xgbe marvell10g sg dm_snapshot dm_bufio crc_itu_t crc_ccitt psn=
ap p8022 llc hfsplus md4 hmac sit tunnel4 ipv6 flashcache_syno(O) flashcac=
he(O) syno_flashcache_control(O) dm_mod arc4 crc32c_intel cryptd ecb aes_x=
86_64 authenc des_generic ansi_cprng cts md5 cbc cpufreq_powersave cpufreq=
_performance
[   48.286469] Workqueue: btrfs-endio-meta btrfs_endio_meta_helper [btrfs]
[   48.335031]  [<ffffffffa10f694d>] btree_io_failed_hook+0x12d/0x220 [btr=
fs]
[   48.341916]  [<ffffffffa112a5aa>] end_bio_extent_readpage+0x18a/0x910 [=
btrfs]
[   48.361353]  [<ffffffffa10f5307>] end_workqueue_fn+0x27/0x40 [btrfs]
[   48.367720]  [<ffffffffa113a496>] btrfs_worker_helper+0xc6/0x390 [btrfs=
]
[   48.380179]  [<ffffffffa113a7c9>] btrfs_endio_meta_helper+0x9/0x10 [btr=
fs]
[   48.392638]  [<ffffffffa113a7c0>] ? btrfs_endio_helper+0x10/0x10 [btrfs=
]
[   48.453716] BTRFS critical (device dm-3): corrupt leaf: block=3D1105429=
5220224 slot=3D76 extent bytenr=3D9957296721920 len=3D589824 invalid gener=
ation, have 4306501632 expect (0, 240743]
[   48.592300] BTRFS critical (device dm-3): corrupt leaf: block=3D1105429=
5220224 slot=3D76 extent bytenr=3D9957296721920 len=3D589824 invalid gener=
ation, have 4306501632 expect (0, 240743]
[   48.978477] BTRFS critical (device dm-3): corrupt leaf: block=3D1105429=
5220224 slot=3D76 extent bytenr=3D9957296721920 len=3D589824 invalid gener=
ation, have 4306501632 expect (0, 240743]
[   48.994980] BTRFS critical (device dm-3): corrupt leaf: block=3D1105429=
5220224 slot=3D76 extent bytenr=3D9957296721920 len=3D589824 invalid gener=
ation, have 4306501632 expect (0, 240743]
[   49.010905] BTRFS error (device dm-3): failed to read block groups: -5
[   49.034464] BTRFS: open_ctree failed
[   49.140834] BTRFS info (device dm-3): enabling auto syno reclaim space
[   49.147366] BTRFS info (device dm-3): use ssd allocation scheme
[   49.153289] BTRFS info (device dm-3): using free block group cache tree
[   49.159907] BTRFS info (device dm-3): has skinny extents
[   49.641488] BTRFS critical (device dm-3): corrupt leaf: block=3D1105429=
5220224 slot=3D76 extent bytenr=3D9957296721920 len=3D589824 invalid gener=
ation, have 4306501632 expect (0, 240743]
[   49.780327] BTRFS critical (device dm-3): corrupt leaf: block=3D1105429=
5220224 slot=3D76 extent bytenr=3D9957296721920 len=3D589824 invalid gener=
ation, have 4306501632 expect (0, 240743]
[   50.166612] BTRFS critical (device dm-3): corrupt leaf: block=3D1105429=
5220224 slot=3D76 extent bytenr=3D9957296721920 len=3D589824 invalid gener=
ation, have 4306501632 expect (0, 240743]
[   50.183130] BTRFS critical (device dm-3): corrupt leaf: block=3D1105429=
5220224 slot=3D76 extent bytenr=3D9957296721920 len=3D589824 invalid gener=
ation, have 4306501632 expect (0, 240743]
[   50.321970] BTRFS critical (device dm-3): corrupt leaf: block=3D1105429=
5220224 slot=3D76 extent bytenr=3D9957296721920 len=3D589824 invalid gener=
ation, have 4306501632 expect (0, 240743]
[   50.709391] BTRFS critical (device dm-3): corrupt leaf: block=3D1105429=
5220224 slot=3D76 extent bytenr=3D9957296721920 len=3D589824 invalid gener=
ation, have 4306501632 expect (0, 240743]
[   50.725846] BTRFS critical (device dm-3): corrupt leaf: block=3D1105429=
5220224 slot=3D76 extent bytenr=3D9957296721920 len=3D589824 invalid gener=
ation, have 4306501632 expect (0, 240743]
[   50.741774] BTRFS error (device dm-3): failed to read block groups: -5
[   50.764722] BTRFS: open_ctree failed
[   50.788040] BTRFS info (device dm-3): enabling auto syno reclaim space
[   50.794578] BTRFS info (device dm-3): use ssd allocation scheme
[   50.800503] BTRFS info (device dm-3): using free block group cache tree
[   50.807119] BTRFS info (device dm-3): has skinny extents
[   50.974290] BTRFS critical (device dm-3): corrupt leaf: block=3D1105429=
5220224 slot=3D76 extent bytenr=3D9957296721920 len=3D589824 invalid gener=
ation, have 4306501632 expect (0, 240743]
[   51.112924] BTRFS critical (device dm-3): corrupt leaf: block=3D1105429=
5220224 slot=3D76 extent bytenr=3D9957296721920 len=3D589824 invalid gener=
ation, have 4306501632 expect (0, 240743]
[   51.500803] BTRFS critical (device dm-3): corrupt leaf: block=3D1105429=
5220224 slot=3D76 extent bytenr=3D9957296721920 len=3D589824 invalid gener=
ation, have 4306501632 expect (0, 240743]
[   51.517251] BTRFS critical (device dm-3): corrupt leaf: block=3D1105429=
5220224 slot=3D76 extent bytenr=3D9957296721920 len=3D589824 invalid gener=
ation, have 4306501632 expect (0, 240743]
[   51.656495] BTRFS critical (device dm-3): corrupt leaf: block=3D1105429=
5220224 slot=3D76 extent bytenr=3D9957296721920 len=3D589824 invalid gener=
ation, have 4306501632 expect (0, 240743]
[   52.042224] BTRFS critical (device dm-3): corrupt leaf: block=3D1105429=
5220224 slot=3D76 extent bytenr=3D9957296721920 len=3D589824 invalid gener=
ation, have 4306501632 expect (0, 240743]
[   52.058747] BTRFS critical (device dm-3): corrupt leaf: block=3D1105429=
5220224 slot=3D76 extent bytenr=3D9957296721920 len=3D589824 invalid gener=
ation, have 4306501632 expect (0, 240743]
[   52.074674] BTRFS error (device dm-3): failed to read block groups: -5
[   52.096755] BTRFS: open_ctree failed
[   52.125295] BTRFS info (device dm-3): enabling auto syno reclaim space
[   52.131839] BTRFS info (device dm-3): use ssd allocation scheme
[   52.137776] BTRFS info (device dm-3): disabling log replay at mount tim=
e
[   52.144477] BTRFS info (device dm-3): using free block group cache tree
[   52.151090] BTRFS info (device dm-3): has skinny extents
[   52.160941] BTRFS error (device dm-3): qgroup generation mismatch, mark=
ed as inconsistent
[   52.169325] BTRFS error (device dm-3): set inconsistent
[   52.360887] BTRFS info (device dm-3): BTRFS: root of syno feature tree =
is null
[   52.368318] BTRFS warning (device dm-3): Failed to generation mismatch =
for syno usage
[  241.442261] BTRFS error (device dm-3): no_block_group must be used with=
 ro mount option
[  280.060783] BTRFS info (device dm-4): using free space tree
[  280.066365] BTRFS info (device dm-4): using free block group cache tree


This is the /var/log/kern.log

2023-04-17T12:01:05+02:00 Windhoek kernel: [   46.564148] WARNING: CPU: 0 =
PID: 11955 at fs/btrfs/disk-io.c:3314 open_ctree+0x2fc3/0x3350 [btrfs]()
2023-04-17T12:01:05+02:00 Windhoek kernel: [   46.573288] Modules linked i=
n: btrfs ecryptfs zstd_decompress zstd_compress xxhash raid456 async_raid6=
_recov async_memcpy async_pq async_xor xor async_tx raid6_pq leds_lp3943 a=
esni_intel glue_helper lrw gf128mul openvswitch zram gre ablk_helper nf_de=
frag_ipv6 bnxt_en(O) nf_conntrack v1000_synobios(PO) hid_generic usbhid hi=
d usblp adt7475 hwmon_vid etxhci_hcd usb_storage bnx2x(O) mdio qede(O) qed=
(O) mlx5_core(O) mlx4_en(O) mlx4_core(O) mlx_compat(O) atlantic_v2(O) atla=
ntic(O) r8168(O) i40e(O) ixgbe(O) amd_xgbe marvell10g sg dm_snapshot dm_bu=
fio crc_itu_t crc_ccitt psnap p8022 llc hfsplus md4 hmac sit tunnel4 ipv6 =
flashcache_syno(O) flashcache(O) syno_flashcache_control(O) dm_mod arc4 cr=
c32c_intel cryptd ecb aes_x86_64 authenc des_generic ansi_cprng cts md5 cb=
c cpufreq_powersave cpufreq_performance
2023-04-17T12:01:05+02:00 Windhoek kernel: [   46.723067]  [<ffffffffa10fe=
4d3>] open_ctree+0x2fc3/0x3350 [btrfs]
2023-04-17T12:01:05+02:00 Windhoek kernel: [   46.729255]  [<ffffffffa10ca=
642>] btrfs_mount+0xaf2/0xc60 [btrfs]
2023-04-17T12:01:05+02:00 Windhoek kernel: [   46.763310]  [<ffffffffa10c9=
ce9>] btrfs_mount+0x199/0xc60 [btrfs]
2023-04-17T12:01:06+02:00 Windhoek kernel: [   47.621353] BTRFS critical (=
device dm-3): corrupt leaf: block=3D11054295220224 slot=3D76 extent bytenr=
=3D9957296721920 len=3D589824 invalid generation, have 4306501632 expect (=
0, 240743]
2023-04-17T12:01:06+02:00 Windhoek kernel: [   47.760094] BTRFS critical (=
device dm-3): corrupt leaf: block=3D11054295220224 slot=3D76 extent bytenr=
=3D9957296721920 len=3D589824 invalid generation, have 4306501632 expect (=
0, 240743]
2023-04-17T12:01:07+02:00 Windhoek kernel: [   48.146261] BTRFS critical (=
device dm-3): corrupt leaf: block=3D11054295220224 slot=3D76 extent bytenr=
=3D9957296721920 len=3D589824 invalid generation, have 4306501632 expect (=
0, 240743]
2023-04-17T12:01:07+02:00 Windhoek kernel: [   48.166801] WARNING: CPU: 5 =
PID: 4188 at fs/btrfs/disk-io.c:924 btree_io_failed_hook+0x12d/0x220 [btrf=
s]()
2023-04-17T12:01:07+02:00 Windhoek kernel: [   48.176452] Modules linked i=
n: synoacl_vfs(PO) btrfs ecryptfs zstd_decompress zstd_compress xxhash rai=
d456 async_raid6_recov async_memcpy async_pq async_xor xor async_tx raid6_=
pq leds_lp3943 aesni_intel glue_helper lrw gf128mul openvswitch zram gre a=
blk_helper nf_defrag_ipv6 bnxt_en(O) nf_conntrack v1000_synobios(PO) hid_g=
eneric usbhid hid usblp adt7475 hwmon_vid etxhci_hcd usb_storage bnx2x(O) =
mdio qede(O) qed(O) mlx5_core(O) mlx4_en(O) mlx4_core(O) mlx_compat(O) atl=
antic_v2(O) atlantic(O) r8168(O) i40e(O) ixgbe(O) amd_xgbe marvell10g sg d=
m_snapshot dm_bufio crc_itu_t crc_ccitt psnap p8022 llc hfsplus md4 hmac s=
it tunnel4 ipv6 flashcache_syno(O) flashcache(O) syno_flashcache_control(O=
) dm_mod arc4 crc32c_intel cryptd ecb aes_x86_64 authenc des_generic ansi_=
cprng cts md5 cbc cpufreq_powersave cpufreq_performance
2023-04-17T12:01:07+02:00 Windhoek kernel: [   48.286469] Workqueue: btrfs=
-endio-meta btrfs_endio_meta_helper [btrfs]
2023-04-17T12:01:07+02:00 Windhoek kernel: [   48.335031]  [<ffffffffa10f6=
94d>] btree_io_failed_hook+0x12d/0x220 [btrfs]
2023-04-17T12:01:07+02:00 Windhoek kernel: [   48.341916]  [<ffffffffa112a=
5aa>] end_bio_extent_readpage+0x18a/0x910 [btrfs]
2023-04-17T12:01:07+02:00 Windhoek kernel: [   48.361353]  [<ffffffffa10f5=
307>] end_workqueue_fn+0x27/0x40 [btrfs]
2023-04-17T12:01:07+02:00 Windhoek kernel: [   48.367720]  [<ffffffffa113a=
496>] btrfs_worker_helper+0xc6/0x390 [btrfs]
2023-04-17T12:01:07+02:00 Windhoek kernel: [   48.380179]  [<ffffffffa113a=
7c9>] btrfs_endio_meta_helper+0x9/0x10 [btrfs]
2023-04-17T12:01:07+02:00 Windhoek kernel: [   48.392638]  [<ffffffffa113a=
7c0>] ? btrfs_endio_helper+0x10/0x10 [btrfs]
2023-04-17T12:01:07+02:00 Windhoek kernel: [   48.453716] BTRFS critical (=
device dm-3): corrupt leaf: block=3D11054295220224 slot=3D76 extent bytenr=
=3D9957296721920 len=3D589824 invalid generation, have 4306501632 expect (=
0, 240743]
2023-04-17T12:01:07+02:00 Windhoek kernel: [   48.592300] BTRFS critical (=
device dm-3): corrupt leaf: block=3D11054295220224 slot=3D76 extent bytenr=
=3D9957296721920 len=3D589824 invalid generation, have 4306501632 expect (=
0, 240743]
2023-04-17T12:01:07+02:00 Windhoek kernel: [   48.978477] BTRFS critical (=
device dm-3): corrupt leaf: block=3D11054295220224 slot=3D76 extent bytenr=
=3D9957296721920 len=3D589824 invalid generation, have 4306501632 expect (=
0, 240743]
2023-04-17T12:01:07+02:00 Windhoek kernel: [   48.994980] BTRFS critical (=
device dm-3): corrupt leaf: block=3D11054295220224 slot=3D76 extent bytenr=
=3D9957296721920 len=3D589824 invalid generation, have 4306501632 expect (=
0, 240743]
2023-04-17T12:01:07+02:00 Windhoek kernel: [   49.010905] BTRFS error (dev=
ice dm-3): failed to read block groups: -5
2023-04-17T12:01:07+02:00 Windhoek kernel: [   49.034464] BTRFS: open_ctre=
e failed
2023-04-17T12:01:08+02:00 Windhoek kernel: [   49.641488] BTRFS critical (=
device dm-3): corrupt leaf: block=3D11054295220224 slot=3D76 extent bytenr=
=3D9957296721920 len=3D589824 invalid generation, have 4306501632 expect (=
0, 240743]
2023-04-17T12:01:08+02:00 Windhoek kernel: [   49.780327] BTRFS critical (=
device dm-3): corrupt leaf: block=3D11054295220224 slot=3D76 extent bytenr=
=3D9957296721920 len=3D589824 invalid generation, have 4306501632 expect (=
0, 240743]
2023-04-17T12:01:09+02:00 Windhoek kernel: [   50.166612] BTRFS critical (=
device dm-3): corrupt leaf: block=3D11054295220224 slot=3D76 extent bytenr=
=3D9957296721920 len=3D589824 invalid generation, have 4306501632 expect (=
0, 240743]
2023-04-17T12:01:09+02:00 Windhoek kernel: [   50.183130] BTRFS critical (=
device dm-3): corrupt leaf: block=3D11054295220224 slot=3D76 extent bytenr=
=3D9957296721920 len=3D589824 invalid generation, have 4306501632 expect (=
0, 240743]
2023-04-17T12:01:09+02:00 Windhoek kernel: [   50.321970] BTRFS critical (=
device dm-3): corrupt leaf: block=3D11054295220224 slot=3D76 extent bytenr=
=3D9957296721920 len=3D589824 invalid generation, have 4306501632 expect (=
0, 240743]
2023-04-17T12:01:09+02:00 Windhoek kernel: [   50.709391] BTRFS critical (=
device dm-3): corrupt leaf: block=3D11054295220224 slot=3D76 extent bytenr=
=3D9957296721920 len=3D589824 invalid generation, have 4306501632 expect (=
0, 240743]
2023-04-17T12:01:09+02:00 Windhoek kernel: [   50.725846] BTRFS critical (=
device dm-3): corrupt leaf: block=3D11054295220224 slot=3D76 extent bytenr=
=3D9957296721920 len=3D589824 invalid generation, have 4306501632 expect (=
0, 240743]
2023-04-17T12:01:09+02:00 Windhoek kernel: [   50.741774] BTRFS error (dev=
ice dm-3): failed to read block groups: -5
2023-04-17T12:01:09+02:00 Windhoek kernel: [   50.764722] BTRFS: open_ctre=
e failed
2023-04-17T12:01:09+02:00 Windhoek kernel: [   50.974290] BTRFS critical (=
device dm-3): corrupt leaf: block=3D11054295220224 slot=3D76 extent bytenr=
=3D9957296721920 len=3D589824 invalid generation, have 4306501632 expect (=
0, 240743]
2023-04-17T12:01:10+02:00 Windhoek kernel: [   51.112924] BTRFS critical (=
device dm-3): corrupt leaf: block=3D11054295220224 slot=3D76 extent bytenr=
=3D9957296721920 len=3D589824 invalid generation, have 4306501632 expect (=
0, 240743]
2023-04-17T12:01:10+02:00 Windhoek kernel: [   51.500803] BTRFS critical (=
device dm-3): corrupt leaf: block=3D11054295220224 slot=3D76 extent bytenr=
=3D9957296721920 len=3D589824 invalid generation, have 4306501632 expect (=
0, 240743]
2023-04-17T12:01:10+02:00 Windhoek kernel: [   51.517251] BTRFS critical (=
device dm-3): corrupt leaf: block=3D11054295220224 slot=3D76 extent bytenr=
=3D9957296721920 len=3D589824 invalid generation, have 4306501632 expect (=
0, 240743]
2023-04-17T12:01:10+02:00 Windhoek kernel: [   51.656495] BTRFS critical (=
device dm-3): corrupt leaf: block=3D11054295220224 slot=3D76 extent bytenr=
=3D9957296721920 len=3D589824 invalid generation, have 4306501632 expect (=
0, 240743]
2023-04-17T12:01:10+02:00 Windhoek kernel: [   52.042224] BTRFS critical (=
device dm-3): corrupt leaf: block=3D11054295220224 slot=3D76 extent bytenr=
=3D9957296721920 len=3D589824 invalid generation, have 4306501632 expect (=
0, 240743]
2023-04-17T12:01:10+02:00 Windhoek kernel: [   52.058747] BTRFS critical (=
device dm-3): corrupt leaf: block=3D11054295220224 slot=3D76 extent bytenr=
=3D9957296721920 len=3D589824 invalid generation, have 4306501632 expect (=
0, 240743]
2023-04-17T12:01:11+02:00 Windhoek kernel: [   52.074674] BTRFS error (dev=
ice dm-3): failed to read block groups: -5
2023-04-17T12:01:11+02:00 Windhoek kernel: [   52.096755] BTRFS: open_ctre=
e failed
2023-04-17T12:01:11+02:00 Windhoek kernel: [   52.160941] BTRFS error (dev=
ice dm-3): qgroup generation mismatch, marked as inconsistent
2023-04-17T12:01:11+02:00 Windhoek kernel: [   52.169325] BTRFS error (dev=
ice dm-3): set inconsistent
2023-04-17T12:01:11+02:00 Windhoek kernel: [   52.368318] BTRFS warning (d=
evice dm-3): Failed to generation mismatch for syno usage
2023-04-17T12:04:21+02:00 Windhoek kernel: [  241.442261] BTRFS error (dev=
ice dm-3): no_block_group must be used with ro mount option

And the /var/log/messages

2023-04-17T11:17:51+02:00 Windhoek synostgd-volume[12576]: Failed to fopen=
 /sys/kernel/debug/btrfs/c14c923f-2038-4841-aa89-504f1044d3be/volume_eb_mi=
ss
2023-04-17T11:17:51+02:00 Windhoek synostgd-volume[12576]: Failed to fopen=
 /sys/kernel/debug/btrfs/c14c923f-2038-4841-aa89-504f1044d3be/volume_meta_=
write_pages
2023-04-17T11:17:51+02:00 Windhoek synostgd-volume[12576]: Failed to fopen=
 /sys/kernel/debug/btrfs/c14c923f-2038-4841-aa89-504f1044d3be/volume_data_=
write_pages
2023-04-17T11:17:51+02:00 Windhoek synostgd-volume[12576]: Failed to fopen=
 /sys/kernel/debug/btrfs/c14c923f-2038-4841-aa89-504f1044d3be/write_fua
2023-04-17T11:17:51+02:00 Windhoek synostgd-volume[12576]: Failed to fopen=
 /sys/kernel/debug/btrfs/1a33aa07-a170-4cd9-ba2a-c3d8e2314088/volume_eb_mi=
ss
2023-04-17T11:17:51+02:00 Windhoek synostgd-volume[12576]: Failed to fopen=
 /sys/kernel/debug/btrfs/1a33aa07-a170-4cd9-ba2a-c3d8e2314088/volume_meta_=
write_pages
2023-04-17T11:17:51+02:00 Windhoek synostgd-volume[12576]: Failed to fopen=
 /sys/kernel/debug/btrfs/1a33aa07-a170-4cd9-ba2a-c3d8e2314088/volume_data_=
write_pages
2023-04-17T11:17:51+02:00 Windhoek synostgd-volume[12576]: Failed to fopen=
 /sys/kernel/debug/btrfs/1a33aa07-a170-4cd9-ba2a-c3d8e2314088/write_fua
2023-04-17T11:18:01+02:00 Windhoek synostgd-volume[12576]: Failed to fopen=
 /sys/kernel/debug/btrfs/c14c923f-2038-4841-aa89-504f1044d3be/volume_eb_mi=
ss
2023-04-17T11:18:01+02:00 Windhoek synostgd-volume[12576]: Failed to fopen=
 /sys/kernel/debug/btrfs/c14c923f-2038-4841-aa89-504f1044d3be/volume_meta_=
write_pages
2023-04-17T12:01:05+02:00 Windhoek kernel: [   46.564148] WARNING: CPU: 0 =
PID: 11955 at fs/btrfs/disk-io.c:3314 open_ctree+0x2fc3/0x3350 [btrfs]()
2023-04-17T12:01:05+02:00 Windhoek kernel: [   46.573288] Modules linked i=
n: btrfs ecryptfs zstd_decompress zstd_compress xxhash raid456 async_raid6=
_recov async_memcpy async_pq async_xor xor async_tx raid6_pq leds_lp3943 a=
esni_intel glue_helper lrw gf128mul openvswitch zram gre ablk_helper nf_de=
frag_ipv6 bnxt_en(O) nf_conntrack v1000_synobios(PO) hid_generic usbhid hi=
d usblp adt7475 hwmon_vid etxhci_hcd usb_storage bnx2x(O) mdio qede(O) qed=
(O) mlx5_core(O) mlx4_en(O) mlx4_core(O) mlx_compat(O) atlantic_v2(O) atla=
ntic(O) r8168(O) i40e(O) ixgbe(O) amd_xgbe marvell10g sg dm_snapshot dm_bu=
fio crc_itu_t crc_ccitt psnap p8022 llc hfsplus md4 hmac sit tunnel4 ipv6 =
flashcache_syno(O) flashcache(O) syno_flashcache_control(O) dm_mod arc4 cr=
c32c_intel cryptd ecb aes_x86_64 authenc des_generic ansi_cprng cts md5 cb=
c cpufreq_powersave cpufreq_performance
2023-04-17T12:01:05+02:00 Windhoek kernel: [   46.723067]  [<ffffffffa10fe=
4d3>] open_ctree+0x2fc3/0x3350 [btrfs]
2023-04-17T12:01:05+02:00 Windhoek kernel: [   46.729255]  [<ffffffffa10ca=
642>] btrfs_mount+0xaf2/0xc60 [btrfs]
2023-04-17T12:01:05+02:00 Windhoek kernel: [   46.763310]  [<ffffffffa10c9=
ce9>] btrfs_mount+0x199/0xc60 [btrfs]
2023-04-17T12:01:06+02:00 Windhoek kernel: [   47.621353] BTRFS critical (=
device dm-3): corrupt leaf: block=3D11054295220224 slot=3D76 extent bytenr=
=3D9957296721920 len=3D589824 invalid generation, have 4306501632 expect (=
0, 240743]
2023-04-17T12:01:06+02:00 Windhoek kernel: [   47.760094] BTRFS critical (=
device dm-3): corrupt leaf: block=3D11054295220224 slot=3D76 extent bytenr=
=3D9957296721920 len=3D589824 invalid generation, have 4306501632 expect (=
0, 240743]
2023-04-17T12:01:07+02:00 Windhoek kernel: [   48.146261] BTRFS critical (=
device dm-3): corrupt leaf: block=3D11054295220224 slot=3D76 extent bytenr=
=3D9957296721920 len=3D589824 invalid generation, have 4306501632 expect (=
0, 240743]
2023-04-17T12:01:07+02:00 Windhoek kernel: [   48.166801] WARNING: CPU: 5 =
PID: 4188 at fs/btrfs/disk-io.c:924 btree_io_failed_hook+0x12d/0x220 [btrf=
s]()
2023-04-17T12:01:07+02:00 Windhoek kernel: [   48.176452] Modules linked i=
n: synoacl_vfs(PO) btrfs ecryptfs zstd_decompress zstd_compress xxhash rai=
d456 async_raid6_recov async_memcpy async_pq async_xor xor async_tx raid6_=
pq leds_lp3943 aesni_intel glue_helper lrw gf128mul openvswitch zram gre a=
blk_helper nf_defrag_ipv6 bnxt_en(O) nf_conntrack v1000_synobios(PO) hid_g=
eneric usbhid hid usblp adt7475 hwmon_vid etxhci_hcd usb_storage bnx2x(O) =
mdio qede(O) qed(O) mlx5_core(O) mlx4_en(O) mlx4_core(O) mlx_compat(O) atl=
antic_v2(O) atlantic(O) r8168(O) i40e(O) ixgbe(O) amd_xgbe marvell10g sg d=
m_snapshot dm_bufio crc_itu_t crc_ccitt psnap p8022 llc hfsplus md4 hmac s=
it tunnel4 ipv6 flashcache_syno(O) flashcache(O) syno_flashcache_control(O=
) dm_mod arc4 crc32c_intel cryptd ecb aes_x86_64 authenc des_generic ansi_=
cprng cts md5 cbc cpufreq_powersave cpufreq_performance
2023-04-17T12:01:07+02:00 Windhoek kernel: [   48.286469] Workqueue: btrfs=
-endio-meta btrfs_endio_meta_helper [btrfs]
2023-04-17T12:01:07+02:00 Windhoek kernel: [   48.335031]  [<ffffffffa10f6=
94d>] btree_io_failed_hook+0x12d/0x220 [btrfs]
2023-04-17T12:01:07+02:00 Windhoek kernel: [   48.341916]  [<ffffffffa112a=
5aa>] end_bio_extent_readpage+0x18a/0x910 [btrfs]
2023-04-17T12:01:07+02:00 Windhoek kernel: [   48.361353]  [<ffffffffa10f5=
307>] end_workqueue_fn+0x27/0x40 [btrfs]
2023-04-17T12:01:07+02:00 Windhoek kernel: [   48.367720]  [<ffffffffa113a=
496>] btrfs_worker_helper+0xc6/0x390 [btrfs]
2023-04-17T12:01:07+02:00 Windhoek kernel: [   48.380179]  [<ffffffffa113a=
7c9>] btrfs_endio_meta_helper+0x9/0x10 [btrfs]
2023-04-17T12:01:07+02:00 Windhoek kernel: [   48.392638]  [<ffffffffa113a=
7c0>] ? btrfs_endio_helper+0x10/0x10 [btrfs]
2023-04-17T12:01:07+02:00 Windhoek kernel: [   48.453716] BTRFS critical (=
device dm-3): corrupt leaf: block=3D11054295220224 slot=3D76 extent bytenr=
=3D9957296721920 len=3D589824 invalid generation, have 4306501632 expect (=
0, 240743]
2023-04-17T12:01:07+02:00 Windhoek kernel: [   48.592300] BTRFS critical (=
device dm-3): corrupt leaf: block=3D11054295220224 slot=3D76 extent bytenr=
=3D9957296721920 len=3D589824 invalid generation, have 4306501632 expect (=
0, 240743]
2023-04-17T12:01:07+02:00 Windhoek kernel: [   48.978477] BTRFS critical (=
device dm-3): corrupt leaf: block=3D11054295220224 slot=3D76 extent bytenr=
=3D9957296721920 len=3D589824 invalid generation, have 4306501632 expect (=
0, 240743]
2023-04-17T12:01:07+02:00 Windhoek kernel: [   48.994980] BTRFS critical (=
device dm-3): corrupt leaf: block=3D11054295220224 slot=3D76 extent bytenr=
=3D9957296721920 len=3D589824 invalid generation, have 4306501632 expect (=
0, 240743]
2023-04-17T12:01:07+02:00 Windhoek kernel: [   49.010905] BTRFS error (dev=
ice dm-3): failed to read block groups: -5
2023-04-17T12:01:07+02:00 Windhoek spacetool[11954]: volume_mount.c:69 Fai=
l to do [/bin/mount -t btrfs -o auto_reclaim_space,ssd,synoacl,relatime,no=
dev /dev/mapper/cachedev_0 /volume1]
2023-04-17T12:01:07+02:00 Windhoek kernel: [   49.034464] BTRFS: open_ctre=
e failed
2023-04-17T12:01:08+02:00 Windhoek kernel: [   49.641488] BTRFS critical (=
device dm-3): corrupt leaf: block=3D11054295220224 slot=3D76 extent bytenr=
=3D9957296721920 len=3D589824 invalid generation, have 4306501632 expect (=
0, 240743]
2023-04-17T12:01:08+02:00 Windhoek kernel: [   49.780327] BTRFS critical (=
device dm-3): corrupt leaf: block=3D11054295220224 slot=3D76 extent bytenr=
=3D9957296721920 len=3D589824 invalid generation, have 4306501632 expect (=
0, 240743]
2023-04-17T12:01:09+02:00 Windhoek kernel: [   50.166612] BTRFS critical (=
device dm-3): corrupt leaf: block=3D11054295220224 slot=3D76 extent bytenr=
=3D9957296721920 len=3D589824 invalid generation, have 4306501632 expect (=
0, 240743]
2023-04-17T12:01:09+02:00 Windhoek kernel: [   50.183130] BTRFS critical (=
device dm-3): corrupt leaf: block=3D11054295220224 slot=3D76 extent bytenr=
=3D9957296721920 len=3D589824 invalid generation, have 4306501632 expect (=
0, 240743]
2023-04-17T12:01:09+02:00 Windhoek kernel: [   50.321970] BTRFS critical (=
device dm-3): corrupt leaf: block=3D11054295220224 slot=3D76 extent bytenr=
=3D9957296721920 len=3D589824 invalid generation, have 4306501632 expect (=
0, 240743]
2023-04-17T12:01:09+02:00 Windhoek kernel: [   50.709391] BTRFS critical (=
device dm-3): corrupt leaf: block=3D11054295220224 slot=3D76 extent bytenr=
=3D9957296721920 len=3D589824 invalid generation, have 4306501632 expect (=
0, 240743]
2023-04-17T12:01:09+02:00 Windhoek kernel: [   50.725846] BTRFS critical (=
device dm-3): corrupt leaf: block=3D11054295220224 slot=3D76 extent bytenr=
=3D9957296721920 len=3D589824 invalid generation, have 4306501632 expect (=
0, 240743]
2023-04-17T12:01:09+02:00 Windhoek kernel: [   50.741774] BTRFS error (dev=
ice dm-3): failed to read block groups: -5
2023-04-17T12:01:09+02:00 Windhoek kernel: [   50.764722] BTRFS: open_ctre=
e failed
2023-04-17T12:01:09+02:00 Windhoek spacetool[12254]: volume_mount.c:69 Fai=
l to do [/bin/mount -t btrfs -o auto_reclaim_space,ssd,synoacl,relatime,no=
dev, /dev/mapper/cachedev_0 /volume1]
2023-04-17T12:01:09+02:00 Windhoek kernel: [   50.974290] BTRFS critical (=
device dm-3): corrupt leaf: block=3D11054295220224 slot=3D76 extent bytenr=
=3D9957296721920 len=3D589824 invalid generation, have 4306501632 expect (=
0, 240743]
2023-04-17T12:01:10+02:00 Windhoek kernel: [   51.112924] BTRFS critical (=
device dm-3): corrupt leaf: block=3D11054295220224 slot=3D76 extent bytenr=
=3D9957296721920 len=3D589824 invalid generation, have 4306501632 expect (=
0, 240743]
2023-04-17T12:01:10+02:00 Windhoek kernel: [   51.500803] BTRFS critical (=
device dm-3): corrupt leaf: block=3D11054295220224 slot=3D76 extent bytenr=
=3D9957296721920 len=3D589824 invalid generation, have 4306501632 expect (=
0, 240743]
2023-04-17T12:01:10+02:00 Windhoek kernel: [   51.517251] BTRFS critical (=
device dm-3): corrupt leaf: block=3D11054295220224 slot=3D76 extent bytenr=
=3D9957296721920 len=3D589824 invalid generation, have 4306501632 expect (=
0, 240743]
2023-04-17T12:01:10+02:00 Windhoek kernel: [   51.656495] BTRFS critical (=
device dm-3): corrupt leaf: block=3D11054295220224 slot=3D76 extent bytenr=
=3D9957296721920 len=3D589824 invalid generation, have 4306501632 expect (=
0, 240743]
2023-04-17T12:01:10+02:00 Windhoek kernel: [   52.042224] BTRFS critical (=
device dm-3): corrupt leaf: block=3D11054295220224 slot=3D76 extent bytenr=
=3D9957296721920 len=3D589824 invalid generation, have 4306501632 expect (=
0, 240743]
2023-04-17T12:01:10+02:00 Windhoek kernel: [   52.058747] BTRFS critical (=
device dm-3): corrupt leaf: block=3D11054295220224 slot=3D76 extent bytenr=
=3D9957296721920 len=3D589824 invalid generation, have 4306501632 expect (=
0, 240743]
2023-04-17T12:01:11+02:00 Windhoek kernel: [   52.074674] BTRFS error (dev=
ice dm-3): failed to read block groups: -5
2023-04-17T12:01:11+02:00 Windhoek spacetool[12574]: volume_mount.c:69 Fai=
l to do [/bin/mount -t btrfs -o auto_reclaim_space,ssd,synoacl,relatime,no=
dev,drop_log_tree /dev/mapper/cachedev_0 /volume1]
2023-04-17T12:01:11+02:00 Windhoek kernel: [   52.096755] BTRFS: open_ctre=
e failed
2023-04-17T12:01:11+02:00 Windhoek kernel: [   52.160941] BTRFS error (dev=
ice dm-3): qgroup generation mismatch, marked as inconsistent
2023-04-17T12:01:11+02:00 Windhoek kernel: [   52.169325] BTRFS error (dev=
ice dm-3): set inconsistent
2023-04-17T12:01:11+02:00 Windhoek kernel: [   52.368318] BTRFS warning (d=
evice dm-3): Failed to generation mismatch for syno usage
2023-04-17T12:01:12+02:00 Windhoek synobtrfssnap[13112]: fs_btrfs_snapshot=
_count.c:276 Failed to setxattr on /volume1, name: user.snapcount, value: =
1, strerror: Read-only file system
2023-04-17T12:01:12+02:00 Windhoek synobtrfssnap[13112]: fs_btrfs_snapshot=
_count.c:453 Fail to set Btrfs snap count of [/volume1] to 1.[0x0000 volum=
e_mount_vol_info_enum.c:29]
2023-04-17T12:04:21+02:00 Windhoek kernel: [  241.442261] BTRFS error (dev=
ice dm-3): no_block_group must be used with ro mount option
2023-04-17T12:05:04+02:00 Windhoek synostgd-volume[13227]: Failed to fopen=
 /sys/kernel/debug/btrfs/c14c923f-2038-4841-aa89-504f1044d3be/volume_eb_mi=
ss
2023-04-17T12:05:04+02:00 Windhoek synostgd-volume[13227]: Failed to fopen=
 /sys/kernel/debug/btrfs/c14c923f-2038-4841-aa89-504f1044d3be/volume_meta_=
write_pages
2023-04-17T12:05:04+02:00 Windhoek synostgd-volume[13227]: Failed to fopen=
 /sys/kernel/debug/btrfs/c14c923f-2038-4841-aa89-504f1044d3be/volume_data_=
write_pages
2023-04-17T12:05:04+02:00 Windhoek synostgd-volume[13227]: Failed to fopen=
 /sys/kernel/debug/btrfs/c14c923f-2038-4841-aa89-504f1044d3be/write_fua
2023-04-17T12:05:04+02:00 Windhoek synostgd-volume[13227]: Failed to fopen=
 /sys/kernel/debug/btrfs/1a33aa07-a170-4cd9-ba2a-c3d8e2314088/volume_eb_mi=
ss
2023-04-17T12:05:04+02:00 Windhoek synostgd-volume[13227]: Failed to fopen=
 /sys/kernel/debug/btrfs/1a33aa07-a170-4cd9-ba2a-c3d8e2314088/volume_meta_=
write_pages
2023-04-17T12:05:04+02:00 Windhoek synostgd-volume[13227]: Failed to fopen=
 /sys/kernel/debug/btrfs/1a33aa07-a170-4cd9-ba2a-c3d8e2314088/volume_data_=
write_pages
2023-04-17T12:05:04+02:00 Windhoek synostgd-volume[13227]: Failed to fopen=
 /sys/kernel/debug/btrfs/1a33aa07-a170-4cd9-ba2a-c3d8e2314088/write_fua
2023-04-17T12:05:14+02:00 Windhoek synostgd-volume[13227]: Failed to fopen=
 /sys/kernel/debug/btrfs/c14c923f-2038-4841-aa89-504f1044d3be/volume_eb_mi=
ss
2023-04-17T12:05:14+02:00 Windhoek synostgd-volume[13227]: Failed to fopen=
 /sys/kernel/debug/btrfs/c14c923f-2038-4841-aa89-504f1044d3be/volume_meta_=
write_pages


Thanks and best
Otto


> =


> Thanks,
> Qu
> =


> > Thanks and best
> > Otto
> > =


> > > If it doesn't work, go the rebuild as planned.
> > > But if it works, you saved a lot of time and should be able to use t=
he
> > > fs without any problem (as long as btrfs check --readonly returns no=
 error).
> > > <snip>
-----------------------3151515cea3d6b6a1dde5b58be637bbc--

--------545e8fdb785ca77864f6e918cc5401db53cab04208ea2b957f0740e96f938927
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wnUEARYKACcFgmQ9KpAJkOprz5XYRobAFiEEzgw+qhyRVYuktNGm6mvPldhG
hsAAABcMAP4+h9ocmXO8zoE1j3px5R1uq5yqno7iHSvTq0IYoVNVcwEA9SiA
Cz9rO0R45KfB6un/YLEZANa1xb1OjPoyLOXf6Qk=
=HaCy
-----END PGP SIGNATURE-----


--------545e8fdb785ca77864f6e918cc5401db53cab04208ea2b957f0740e96f938927--

