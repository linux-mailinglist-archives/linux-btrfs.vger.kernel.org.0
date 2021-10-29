Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDF8C440555
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Oct 2021 00:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbhJ2WPW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Oct 2021 18:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbhJ2WPW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Oct 2021 18:15:22 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F030DC061570
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Oct 2021 15:12:52 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id j2so23714415lfg.3
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Oct 2021 15:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wiegert-link.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=azia4deySUsclg9aTlFAn+WYIkwoa4CbyakHmzs7gGk=;
        b=Uk+rLJsx9r8Ve22KeGFCAmSjZNjhuV529HoKKsvt7abdozEMx9QMmYuAMHYuygVJFT
         Gqwrm16igkLKdfTrS/77GG5TjjAck0a/GEWV569f5FXZ9k1/LTahdkJ1TReGDaRNHvu2
         A5sNtWo6gOxXLvjHiHdVfiuDVUrspPKKI8Msh8l2bsSoGNmV5J2dKitmgTM2n03bnatw
         3tIQvTUhXgyM4K8zXh0CPv3Kqj/Sm4neaYH3tu9JggMA7II7tcXJzFeHymdyhFY0rzcO
         8MwQXxaBhTGADq/hkpkX4yUOOQuddREaOaTbC5Esgxvh4Mh4Ddq8XtXeFmRC4VfAvio1
         m/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=azia4deySUsclg9aTlFAn+WYIkwoa4CbyakHmzs7gGk=;
        b=BbChw90qNFcfXh535cPbb/d1e5HW2ru9Mcn4NR7oSdfP9i3VPNJWZpbiiiWbr29NXS
         TZwalJfeNVB10+RJ+vKXjzx+LeYyU0XcYD6453r1alHy2QiEZJptd7bENoXXxejyD5rY
         ysxWF4bLwLpEgwz7vswpMcZydk8eslxWOCmUuRki5oyyim0ASr7zPsnjA96HLExOviY6
         jD7kORs03DF7uALxH/GZhsw3GJbJajWJ7e8dKGexiAOBNeUGcrHs2hl5roKCUwvrTxeO
         rBY4C+jcJUYPKlB1NQR4jHnsL1q3SWPHsmvrDRRTIFlC+4uitT1+WHrJnhSK4ZTyPMkD
         x+HA==
X-Gm-Message-State: AOAM532qBjsQmiW8G3pRiCaIbf7zKhuyU4skNOXHUp73dPBrcLLmOc17
        q2NfvoNPvetD7VwQ6eitpfoHGD7KP2cxnUCexez7XF6Y72cjAA==
X-Google-Smtp-Source: ABdhPJwE6Ci4nsRppnHeZ0hTZIHEpsMQ79Rhq37WT0DGrd2ZkeQbk7H7Ba9OHjJPwwH27lWZczc8CDMTq6YCiejYzLI=
X-Received: by 2002:a05:6512:32a3:: with SMTP id q3mr2807282lfe.127.1635545570835;
 Fri, 29 Oct 2021 15:12:50 -0700 (PDT)
MIME-Version: 1.0
From:   Daniel Wiegert <daniel@wiegert.link>
Date:   Sat, 30 Oct 2021 00:12:40 +0200
Message-ID: <CADPUUGGsP29ByH32GajUsy8EiLQ4uY6950qpBxf3Cwb2+zUgFA@mail.gmail.com>
Subject: BTRFS ran out of space, forced read-only - unable to remount
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello everyone,

I might have stumbled on a bug while running out of space for a btrfs drive.
Running kernel 5.10.73-1-lts and btrfs-progs v5.14.2.
md126 is a raid5 mdadm device without read or write errors.

I forgot my btrfs device was almost full and started writing a file to
it, got the following error:

Oct 28 22:46:04 Queen kernel: ------------[ cut here ]------------
Oct 28 22:46:04 Queen kernel: BTRFS: Transaction aborted (error -28)
Oct 28 22:46:04 Queen kernel: WARNING: CPU: 55 PID: 1738 at
fs/btrfs/extent-tree.c:2148 btrfs_run_delayed_refs+0x1ad/0x200 [btrfs]
Oct 28 22:46:04 Queen kernel: Modules linked in: i2c_dev
rpcsec_gss_krb5 vhost_net vhost vhost_iotlb tap tun veth xt_nat
xt_tcpudp xt_conntrack xt_MASQUERADE nf_conntrack_netlink xt_addrtype
iptable_filter iptable_nat br_netfilter nfnetlink_cttimeout nfnetlink
openvswitch nsh nf_conncount nf_nat nf_conntrack nf_defrag_ipv6
nf_defrag_ipv4 xfs iTCO_wdt intel_rapl_msr intel_pmc_bxt
iTCO_vendor_support 8021q garp mrp dcdbas intel_rapl_common sb_edac
x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm
crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel
crypto_simd cryptd glue_helper rapl intel_cstate intel_uncore pcspkr
snd_hda_intel snd_intel_dspcfg soundwire_intel
soundwire_generic_allocation soundwire_cadence snd_hda_codec
snd_hda_core snd_hwdep soundwire_bus snd_soc_core snd_compress nouveau
ac97_bus snd_pcm_dmaengine mxm_wmi snd_pcm video snd_timer snd
soundcore ttm mgag200 drm_kms_helper cec syscopyarea sysfillrect
sysimgblt fb_sys_fops lpc_ich igb i2c_algo_bit joydev mousedev cdc_acm
Oct 28 22:46:04 Queen kernel:  ixgbe mei_me mei ch341 mdio_devres
libphy mdio ipmi_ssif ioatdma dca ipmi_si ipmi_devintf ipmi_msghandler
wmi bridge stp llc bonding acpi_power_meter mac_hid acpi_pad zfs(POE)
zunicode(POE) zzstd(OE) zlua(OE) zavl(POE) icp(POE) zcommon(POE)
znvpair(POE) spl(OE) drm agpgart fuse nfsd auth_rpcgss nfs_acl lockd
grace sunrpc nfs_ssc ip_tables x_tables dm_cache_smq dm_cache
dm_thin_pool dm_persistent_data dm_bio_prison dm_bufio sr_mod cdrom
uas usb_storage usbhid ses enclosure mpt3sas xhci_pci xhci_pci_renesas
raid_class scsi_transport_sas vfio_pci irqbypass vfio_virqfd
vfio_iommu_type1 vfio raid10 raid1 raid0 dm_raid raid456
async_raid6_recov async_memcpy async_pq async_xor async_tx dm_mod
md_mod ext4 crc16 mbcache jbd2 btrfs blake2b_generic libcrc32c
crc32c_generic crc32c_intel xor raid6_pq [last unloaded: i2c_dev]
Oct 28 22:46:04 Queen kernel: CPU: 55 PID: 1738 Comm: btrfs-transacti
Tainted: P           OE     5.10.73-1-lts #1
Oct 28 22:46:04 Queen kernel: Hardware name: Dell Inc. PowerEdge
R730xd/072T6D, BIOS 2.12.1 12/04/2020
Oct 28 22:46:04 Queen kernel: RIP:
0010:btrfs_run_delayed_refs+0x1ad/0x200 [btrfs]
Oct 28 22:46:04 Queen kernel: Code: 48 81 c2 40 0a 00 00 f0 48 0f ba
2a 02 72 20 83 f8 fb 74 3c 83 f8 e2 74 37 89 c6 48 c7 c7 20 6b 3f c0
89 04 24 e8 a6 7b 4d e3 <0f> 0b 8b 04 24 89 c1 ba 64 08 00 00 4c 89 e7
89 04 24 48 c7 c6 40
Oct 28 22:46:04 Queen kernel: RSP: 0018:ffffa334e37e7d28 EFLAGS: 00010282
Oct 28 22:46:04 Queen kernel: RAX: 0000000000000000 RBX:
ffffffffffffffff RCX: 0000000000000027
Oct 28 22:46:04 Queen kernel: RDX: ffff8bf73fd58bb8 RSI:
0000000000000001 RDI: ffff8bf73fd58bb0
Oct 28 22:46:04 Queen kernel: RBP: ffff8bb897684178 R08:
0000000000000000 R09: ffffa334e37e7b48
Oct 28 22:46:04 Queen kernel: R10: ffffa334e37e7b40 R11:
ffff8bf77ff6bc28 R12: ffff8be8354f7f70
Oct 28 22:46:04 Queen kernel: R13: ffff8bf14b976910 R14:
ffff8bf14b976900 R15: ffff8bf14b976960
Oct 28 22:46:04 Queen kernel: FS:  0000000000000000(0000)
GS:ffff8bf73fd40000(0000) knlGS:0000000000000000
Oct 28 22:46:04 Queen kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Oct 28 22:46:04 Queen kernel: CR2: 000000c0001d1010 CR3:
00000034c6a10004 CR4: 00000000003726e0
Oct 28 22:46:04 Queen kernel: DR0: 0000000000000000 DR1:
0000000000000000 DR2: 0000000000000000
Oct 28 22:46:04 Queen kernel: DR3: 0000000000000000 DR6:
00000000fffe0ff0 DR7: 0000000000000400
Oct 28 22:46:04 Queen kernel: Call Trace:
Oct 28 22:46:04 Queen kernel:  commit_cowonly_roots+0x104/0x310 [btrfs]
Oct 28 22:46:04 Queen kernel:  ? btrfs_qgroup_account_extents+0xbe/0x220 [btrfs]
Oct 28 22:46:04 Queen kernel:  btrfs_commit_transaction+0x62e/0xc00 [btrfs]
Oct 28 22:46:04 Queen kernel:  ? start_transaction+0xc8/0x560 [btrfs]
Oct 28 22:46:04 Queen kernel:  transaction_kthread+0x149/0x170 [btrfs]
Oct 28 22:46:04 Queen kernel:  ?
btrfs_cleanup_transaction.isra.0+0x5a0/0x5a0 [btrfs]
Oct 28 22:46:04 Queen kernel:  kthread+0x11b/0x140
Oct 28 22:46:04 Queen kernel:  ? kthread_associate_blkcg+0xa0/0xa0
Oct 28 22:46:04 Queen kernel:  ret_from_fork+0x1f/0x30
Oct 28 22:46:04 Queen kernel: ---[ end trace 548eaa8bd5f85659 ]---
Oct 28 22:46:04 Queen kernel: BTRFS: error (device md126) in
btrfs_run_delayed_refs:2148: errno=-28 No space left
Oct 28 22:46:04 Queen kernel: BTRFS info (device md126): forced readonly
Oct 28 22:46:05 Queen kernel: BTRFS warning (device md126): Skipping
commit of aborted transaction.
Oct 28 22:46:05 Queen kernel: BTRFS: error (device md126) in
cleanup_transaction:1944: errno=-28 No space left

I realized my mistake, and I tried deleting my latest file but it
failed due to readonly. Fine, I'll leave the system alone during the
night then.. dmesg was also quiet so I left it alone.

Well, about 2 hours later, while sleeping, my logs started getting
flooded with the following messages:
Oct 29 00:25:58 Queen kernel: BTRFS error (device md126): parent
transid verify failed on 7012644388864 wanted 13105 found 13101
Oct 29 00:25:58 Queen kernel: BTRFS error (device md126): parent
transid verify failed on 7012644388864 wanted 13105 found 13101
Oct 29 00:25:58 Queen kernel: BTRFS info (device md126): no csum found
for inode 488 start 80969633792
Oct 29 00:25:58 Queen kernel: BTRFS error (device md126): parent
transid verify failed on 7012644388864 wanted 13105 found 13101
Oct 29 00:25:58 Queen kernel: BTRFS error (device md126): parent
transid verify failed on 7012644388864 wanted 13105 found 13101
Oct 29 00:25:58 Queen kernel: BTRFS info (device md126): no csum found
for inode 488 start 80969637888
Oct 29 00:25:58 Queen kernel: BTRFS error (device md126): parent
transid verify failed on 7012644388864 wanted 13105 found 13101
Oct 29 00:25:58 Queen kernel: BTRFS error (device md126): parent
transid verify failed on 7012644388864 wanted 13105 found 13101
Oct 29 00:25:58 Queen kernel: BTRFS info (device md126): no csum found
for inode 488 start 80969641984
Oct 29 00:25:58 Queen kernel: BTRFS warning (device md126): csum
failed root 5 ino 488 off 80969633792 csum 0x012ff27b expected csum
0x00000000 mirror 1
Oct 29 00:25:58 Queen kernel: BTRFS error (device md126): bdev
/dev/md126 errs: wr 0, rd 0, flush 0, corrupt 1, gen 0
Oct 29 00:25:58 Queen kernel: BTRFS error (device md126): parent
transid verify failed on 7012644388864 wanted 13105 found 13101
Oct 29 00:25:58 Queen kernel: BTRFS error (device md126): parent
transid verify failed on 7012644388864 wanted 13105 found 13101
Oct 29 00:25:58 Queen kernel: BTRFS info (device md126): no csum found
for inode 488 start 80969633792
Oct 29 00:25:58 Queen kernel: BTRFS warning (device md126): csum
failed root 5 ino 488 off 80969633792 csum 0x012ff27b expected csum
0x00000000 mirror 1
Oct 29 00:25:58 Queen kernel: BTRFS error (device md126): bdev
/dev/md126 errs: wr 0, rd 0, flush 0, corrupt 2, gen 0
Oct 29 00:51:51 Queen kernel: BTRFS error (device md126): parent
transid verify failed on 3201475280896 wanted 13105 found 10122
Oct 29 00:51:51 Queen kernel: BTRFS error (device md126): parent
transid verify failed on 3201475280896 wanted 13105 found 10122
Oct 29 00:51:51 Queen kernel: BTRFS info (device md126): no csum found
for inode 606 start 107503611904
Oct 29 00:51:51 Queen kernel: BTRFS error (device md126): parent
transid verify failed on 3201475280896 wanted 13105 found 10122
Oct 29 00:51:51 Queen kernel: BTRFS error (device md126): parent
transid verify failed on 3201475280896 wanted 13105 found 10122
Oct 29 00:51:51 Queen kernel: BTRFS info (device md126): no csum found
for inode 606 start 107503616000
Oct 29 00:51:51 Queen kernel: BTRFS error (device md126): parent
transid verify failed on 3201475280896 wanted 13105 found 10122
Oct 29 00:51:51 Queen kernel: BTRFS error (device md126): parent
transid verify failed on 3201475280896 wanted 13105 found 10122
Oct 29 00:51:51 Queen kernel: BTRFS info (device md126): no csum found
for inode 606 start 107503620096
Oct 29 00:51:51 Queen kernel: BTRFS warning (device md126): csum
failed root 5 ino 606 off 107503611904 csum 0x72bdda92 expected csum
0x00000000 mirror 1
Oct 29 00:51:51 Queen kernel: BTRFS error (device md126): bdev
/dev/md126 errs: wr 0, rd 0, flush 0, corrupt 3, gen 0
Oct 29 00:51:51 Queen kernel: BTRFS error (device md126): parent
transid verify failed on 3201475280896 wanted 13105 found 10122
Oct 29 00:51:51 Queen kernel: BTRFS error (device md126): parent
transid verify failed on 3201475280896 wanted 13105 found 10122
Oct 29 00:51:51 Queen kernel: BTRFS info (device md126): no csum found
for inode 606 start 107503611904
Oct 29 00:51:51 Queen kernel: BTRFS warning (device md126): csum
failed root 5 ino 606 off 107503611904 csum 0x72bdda92 expected csum
0x00000000 mirror 1
Oct 29 00:51:51 Queen kernel: BTRFS error (device md126): bdev
/dev/md126 errs: wr 0, rd 0, flush 0, corrupt 4, gen 0
Oct 29 00:54:23 Queen kernel: BTRFS error (device md126): parent
transid verify failed on 7012670406656 wanted 13105 found 13101
Oct 29 00:54:23 Queen kernel: BTRFS error (device md126): parent
transid verify failed on 7012670406656 wanted 13105 found 13101
Oct 29 00:54:23 Queen kernel: BTRFS info (device md126): no csum found
for inode 576 start 42903543808
Oct 29 00:54:23 Queen kernel: BTRFS error (device md126): parent
transid verify failed on 7012670406656 wanted 13105 found 13101
Oct 29 00:54:23 Queen kernel: BTRFS error (device md126): parent
transid verify failed on 7012670406656 wanted 13105 found 13101
Oct 29 00:54:23 Queen kernel: BTRFS info (device md126): no csum found
for inode 576 start 42903547904
Oct 29 00:54:23 Queen kernel: BTRFS error (device md126): parent
transid verify failed on 7012670406656 wanted 13105 found 13101
Oct 29 00:54:23 Queen kernel: BTRFS error (device md126): parent
transid verify failed on 7012670406656 wanted 13105 found 13101
Oct 29 00:54:23 Queen kernel: BTRFS info (device md126): no csum found
for inode 576 start 42903552000
Oct 29 00:54:23 Queen kernel: BTRFS warning (device md126): csum
failed root 5 ino 576 off 42903543808 csum 0x8dabdb84 expected csum
0x00000000 mirror 1
Oct 29 00:54:23 Queen kernel: BTRFS error (device md126): bdev
/dev/md126 errs: wr 0, rd 0, flush 0, corrupt 5, gen 0
Oct 29 00:54:23 Queen kernel: BTRFS error (device md126): parent
transid verify failed on 7012670406656 wanted 13105 found 13101
Oct 29 00:54:23 Queen kernel: BTRFS error (device md126): parent
transid verify failed on 7012670406656 wanted 13105 found 13101
Oct 29 00:54:24 Queen kernel: BTRFS info (device md126): no csum found
for inode 576 start 42903543808
Oct 29 00:54:24 Queen kernel: BTRFS warning (device md126): csum
failed root 5 ino 576 off 42903543808 csum 0x8dabdb84 expected csum
0x00000000 mirror 1
Oct 29 00:54:24 Queen kernel: BTRFS error (device md126): bdev
/dev/md126 errs: wr 0, rd 0, flush 0, corrupt 6, gen 0

So, what have I tried? Simple check gave me:
% btrfs check -p /dev/md126
Opening filesystem to check...
Checking filesystem on /dev/md126
UUID: 98cc8994-eaee-4195-80ea-b2a5bb60f355
[1/7] checking root items                      (0:02:54 elapsed,
3459065 items checked)
[2/7] checking extents                         (0:08:02 elapsed,
2945760 items checked)
cache and super generation don't match, space cache will be invalidated
[3/7] checking free space cache                (0:00:00 elapsed)
[4/7] checking fs roots                        (0:00:10 elapsed, 2482
items checked)
[5/7] checking csums (without verifying data)  (0:00:02 elapsed,
4013808 items checked)
[6/7] checking root refs                       (0:00:00 elapsed, 3
items checked)
[7/7] checking quota groups skipped (not enabled on this FS)
found 44458862993408 bytes used, no error found
total csum bytes: 43359010840
total tree bytes: 48263200768
total fs tree bytes: 40779776
total extent tree bytes: 263651328
btree space waste bytes: 4144336018
file data blocks allocated: 44410599792640
 referenced 44410585600000

I unmounted the filesystem and tried to remount normally and with %
mount -o clear_cache,ro but only get :
BTRFS error (device md126): Remounting read-write after error is not allowed

I've also tried mounting in between but always the same remount error as above.
% btrfs check --clear-space-cache /dev/md126
% btrfs check--clear-ino-cache /dev/md126
% btrfs rescue zero-log /dev/md126
* I have NOT tried btrfs check --repair yet.

Is there some way to recover the file system? I do have backup but
since it's a large array of about 45TB I would prefer to somehow
recover the filesystem, mounting it read only would actually work
too..

The last errors before I unmounted the system are:
Oct 29 21:39:11 Queen kernel: BTRFS info (device md126): no csum found
for inode 264 start 107508629504
Oct 29 21:39:11 Queen kernel: BTRFS warning (device md126): csum
failed root 5 ino 264 off 107508629504 csum 0x88063d71 expected csum
0x00000000 mirror 1
Oct 29 21:39:11 Queen kernel: BTRFS error (device md126): bdev
/dev/md126 errs: wr 0, rd 0, flush 0, corrupt 817, gen 0
Oct 29 21:39:20 Queen kernel: verify_parent_transid: 6 callbacks suppressed
Oct 29 21:39:20 Queen kernel: BTRFS error (device md126): parent
transid verify failed on 9022752768000 wanted 13105 found 13099
Oct 29 21:39:20 Queen kernel: BTRFS error (device md126): parent
transid verify failed on 9022752768000 wanted 13105 found 13099
Oct 29 21:39:20 Queen kernel: BTRFS error (device md126): parent
transid verify failed on 9022752768000 wanted 13105 found 13099
Oct 29 21:39:20 Queen kernel: BTRFS error (device md126): parent
transid verify failed on 9022752768000 wanted 13105 found 13099
Oct 29 21:39:20 Queen kernel: BTRFS error (device md126): parent
transid verify failed on 9022752768000 wanted 13105 found 13099
Oct 29 21:39:20 Queen kernel: BTRFS error (device md126): parent
transid verify failed on 9022752768000 wanted 13105 found 13099
Oct 29 21:39:20 Queen kernel: BTRFS error (device md126): parent
transid verify failed on 9022752768000 wanted 13105 found 13099
Oct 29 21:39:20 Queen kernel: BTRFS error (device md126): parent
transid verify failed on 9022752768000 wanted 13105 found 13099
Oct 29 21:39:39 Queen kernel: BTRFS error (device md126): parent
transid verify failed on 9022762450944 wanted 13105 found 13101
Oct 29 21:39:39 Queen kernel: BTRFS error (device md126): parent
transid verify failed on 9022762450944 wanted 13105 found 13101
Oct 29 21:39:39 Queen kernel: BTRFS info (device md126): no csum found
for inode 406 start 107526569984
Oct 29 21:39:39 Queen kernel: BTRFS error (device md126): parent
transid verify failed on 9022762450944 wanted 13105 found 13101
Oct 29 21:39:39 Queen kernel: BTRFS error (device md126): parent
transid verify failed on 9022762450944 wanted 13105 found 13101
Oct 29 21:39:39 Queen kernel: BTRFS info (device md126): no csum found
for inode 406 start 107526574080
Oct 29 21:39:39 Queen kernel: BTRFS error (device md126): parent
transid verify failed on 9022762450944 wanted 13105 found 13101
Oct 29 21:39:39 Queen kernel: BTRFS error (device md126): parent
transid verify failed on 9022762450944 wanted 13105 found 13101
Oct 29 21:39:39 Queen kernel: BTRFS info (device md126): no csum found
for inode 406 start 107526578176
Oct 29 21:39:39 Queen kernel: BTRFS warning (device md126): csum
failed root 5 ino 406 off 107526569984 csum 0xc48b20c7 expected csum
0x00000000 mirror 1
Oct 29 21:39:39 Queen kernel: BTRFS error (device md126): bdev
/dev/md126 errs: wr 0, rd 0, flush 0, corrupt 818, gen 0
Oct 29 21:39:39 Queen kernel: BTRFS error (device md126): parent
transid verify failed on 9022762450944 wanted 13105 found 13101
Oct 29 21:39:39 Queen kernel: BTRFS error (device md126): parent
transid verify failed on 9022762450944 wanted 13105 found 13101
Oct 29 21:39:39 Queen kernel: BTRFS info (device md126): no csum found
for inode 406 start 107526569984
Oct 29 21:39:39 Queen kernel: BTRFS warning (device md126): csum
failed root 5 ino 406 off 107526569984 csum 0xc48b20c7 expected csum
0x00000000 mirror 1
Oct 29 21:39:39 Queen kernel: BTRFS error (device md126): bdev
/dev/md126 errs: wr 0, rd 0, flush 0, corrupt 819, gen 0
Oct 29 21:40:16 Queen kernel: BTRFS error (device md126): parent
transid verify failed on 9022762450944 wanted 13105 found 13101
Oct 29 21:40:16 Queen kernel: BTRFS error (device md126): parent
transid verify failed on 9022762450944 wanted 13105 found 13101
Oct 29 21:40:16 Queen kernel: BTRFS info (device md126): no csum found
for inode 402 start 107546378240
Oct 29 21:40:16 Queen kernel: BTRFS warning (device md126): csum
failed root 5 ino 402 off 107546378240 csum 0x61054b7d expected csum
0x00000000 mirror 1
Oct 29 21:40:16 Queen kernel: BTRFS error (device md126): bdev
/dev/md126 errs: wr 0, rd 0, flush 0, corrupt 820, gen 0

Best regards
Daniel
