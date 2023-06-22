Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC7873A0B4
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jun 2023 14:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbjFVMRR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Jun 2023 08:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbjFVMRQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Jun 2023 08:17:16 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF8F10F4
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Jun 2023 05:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1687436231; x=1688041031; i=quwenruo.btrfs@gmx.com;
 bh=JMrhRaSCHWqRrG2IkhgMmVeguY7UwoLB4O/AUHYeez8=;
 h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
 b=cWDOC/e3rW6XS5U2VQaph1NyDc9GtAuB9qqwZdM++IH2Ek3q5/1mujDy2itx3xj+GC8+Hap
 RCT+nmOoPf1Kz65YoW6QJH/VM9SCux1kqeoct6x6+11VdlqSZpF8XW7Kuy3M7CYLKpVcR2//3
 cYwRNGxRCZ74/pdkekT7ntpot3Zduevr5qDbajuNy8rDhOP1OuBHsKQrWifgUG6NyNp+zt/Fi
 K4B+WaF0/c4M4JiIciamwzPzcLFe7OAiSgKyknCINn9MqZ9hoyI5a65bM04ondGY0vUIxnIKd
 jfPpfRkOnwbHGLgJZmN7pEIrAz0hjtCa1CuPki3KqOdY6JRkogsw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MJmGP-1qWRSx3ED3-00KCUL; Thu, 22
 Jun 2023 14:17:11 +0200
Message-ID: <0b30d749-2f5d-7d8d-4843-0554224642e5@gmx.com>
Date:   Thu, 22 Jun 2023 20:17:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
To:     Bernhard Bock <bernhard.bock@quesive.de>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <9840EC62-B18F-4AB7-B3F6-E61B05800EB2@quesive.de>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: IO failure (Failed to recover log tree)
In-Reply-To: <9840EC62-B18F-4AB7-B3F6-E61B05800EB2@quesive.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aiRslb9BrQocL/yJRl+5FyvSWXx2mAW1NsZ3UHq38cormEEYsEY
 +fseZc6zfBdk1S70jJYep+X5z/hWYVBFHzrLwDoDbkOxP7xXqjf+U2bkK+CD4A3QKkTDYlw
 hC427Kk3Cu9dvDjslTrFrdZV6mDKTZVNk33INQ9aOgLNTsMkcB4JBftOO71NhV79um8Mf6I
 BVDNcRGPh0D2BOHU7CWgA==
UI-OutboundReport: notjunk:1;M01:P0:rAtslFR+Kic=;NwZMmWV1LXayfs0ffNBkiiMVLIU
 H9HSauAZC2+nu0Cf4KPm8VOoNgRxSeYgfzPAk5M6YnHjJa7BEL6GOFLzhnfEmPiC187PE+ap/
 rNkEKejFc422T8/9VGfXECPSclvylU5xfb+crQNfHKrfdqf6U1FIaDPn3VtbV34sXBqSZtxoU
 H2pHSAAySM5FoBtRw6Slr4Tr/VIKUwP61JrqqPXkER8ejyS36e/y6vCFJq7xonCJORb7aC/C1
 67/fmMiaSA48lCxAA1uaTKbZTAUJdR1+Id3sy2zpJQVNCrMxfQp8qoB1BJIFFSlMjnZtSTrie
 LEqZJNogmt2RMytgAZDo56md8ojfs3LZ03YmT67EPuQ67VVdIv7Yn2i1xxIMjGY5pNAgqF2gk
 aI+iQx/jl9udIfvP40TgshRmfyGXCZ8WVjdwK6tddyN4cVjruBPiWXpghjve5a+r3/TnqYwO+
 svBvWp++lolVpPsImUNiv7NF/bwiYY1s98JoRt8El10X/0bbHzAeQfZ4ZWztk/2Vj3JK7FSck
 4LtXiDVU7l0i7+pY7j3A49ikjWrhBZx8w2HBBCfUVFBvu2LLHkxIk1hp/E2bfWeX3W7exKan7
 fvKjZvsxjSdF7u1bhUMhfAmbW5HpvcOY4Q9ri1ivFVrEzJDmk3OTr5Qbk1lDncnatOE1ADBoP
 NGizZ+BCtEt9mwwbwz6xa7QFiSfJraPOz7lwftuokFXjKCX/1jaKCYkfy85My3/dyqEs8xLu+
 TkcV8hC4k4brONiaDNq17kIr2t1gcBx2lUvSIuUkC0Pl/Uki3pNB2h1Vt6MW0MX9EekstJLRW
 blfNV6RLjvTwdpB4mFX69Ap1hedQVq+mn6zHiwNZTJLVdv3RHInqnDq1NJ/Y7/VuDC1Jp7MO2
 fSXl4XULSnTTewXif2Mwn/a3rKt259JaG79NHEYqw5Nm277/m75Lh+tVD67Zt97LMLo1qavWP
 WEOqpx5TNN2FpY2QHR4aeIxfpw8=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/6/22 19:56, Bernhard Bock wrote:
> Hi,
>
> I have a btrfs volume that was created on a Ubuntu 20.04 (not available =
any more) and shall now be mounted on a new Debian 12 Proxmox system. The =
mount fails. btrfsck finds no errors.
>
> Any guidance how to move forward is appreciated.
>
>
> # mount /dev/mapper/ssd_raid /data -o recovery,ro
> mount: /data: can't read superblock on /dev/mapper/ssd_raid.
>         dmesg(1) may have more information after failed mount system cal=
l.
>
>
> # btrfsck /dev/mapper/ssd_raid
> Opening filesystem to check...
> Checking filesystem on /dev/mapper/ssd_raid
> UUID: c0197b8c-ee83-4069-9852-ffeff996ee1d
> [1/7] checking root items
> [2/7] checking extents
> [3/7] checking free space cache
> [4/7] checking fs roots
> [5/7] checking only csums items (without verifying data)
> [6/7] checking root refs
> [7/7] checking quota groups skipped (not enabled on this FS)
> found 9729818120192 bytes used, no error found
> total csum bytes: 9483575720
> total tree bytes: 15738404864
> total fs tree bytes: 3182084096
> total extent tree bytes: 1451343872
> btree space waste bytes: 2253812020
> file data blocks allocated: 25114950897664
>   referenced 19054873636864

If btrfs check returns no error, you can easily fix the problem by

# btrfs rescue zero-log /dev/mapper/ssd_raid

But I'm more interested in how the corruption happened.
>
> Here=E2=80=99s the details:
>
> # uname -a
> Linux epyc 6.2.16-3-pve #1 SMP PREEMPT_DYNAMIC PVE 6.2.16-3 (2023-06-17T=
05:58Z) x86_64 GNU/Linux
>
> # btrfs --version
> btrfs-progs v6.2
>
> # btrfs fi show
> Label: 'sas-ssd-cryptraid6'  uuid: c0197b8c-ee83-4069-9852-ffeff996ee1d
> 	Total devices 1 FS bytes used 8.85TiB
> 	devid    1 size 18.00TiB used 8.90TiB path /dev/mapper/ssd_raid
>
> # dmesg
> BTRFS: device label sas-ssd-cryptraid6 devid 1 transid 4648768 /dev/mapp=
er/ssd_raid scanned by mount (37208)
> BTRFS info (device dm-3): using crc32c (crc32c-intel) checksum algorithm
> BTRFS warning (device dm-3): 'recovery' is deprecated, use 'rescue=3Duse=
backuproot' instead
> BTRFS info (device dm-3): trying to use backup root at mount time
> BTRFS info (device dm-3): disk space caching is enabled
> BTRFS info (device dm-3): bdev /dev/mapper/ssd_raid errs: wr 0, rd 0, fl=
ush 0, corrupt 4, gen 0
> BTRFS info (device dm-3): enabling ssd optimizations
> BTRFS info (device dm-3): start tree-log replay
> BTRFS info (device dm-3): the free space cache file (10715973812224) is =
invalid, skip it
> BTRFS error (device dm-3): tree first key mismatch detected, bytenr=3D38=
34898874368 parent_transid=3D4647622 key expected=3D(8498035142656,168,184=
46633622288485976) has=3D(8498035142656,168,4096)
> BTRFS error (device dm-3): tree first key mismatch detected, bytenr=3D38=
34898874368 parent_transid=3D4647622 key expected=3D(8498035142656,168,184=
46633622288485976) has=3D(8498035142656,168,4096)

Please dump the involved tree block by:

# btrfs ins dump-tree -b 3834898874368 --follow /dev/mapper/ssd_raid

The direct problem is the key offset mismatch, the expected one looks
like something underflow or garbage, but not obvious bitflip.

The one from parent node is definitely incorrect, but I can not explain
just from the dmesg.

Thanks,
Qu

> BTRFS: error (device dm-3) in btrfs_replay_log:2496: errno=3D-5 IO failu=
re (Failed to recover log tree)
> ------------[ cut here ]------------
> WARNING: CPU: 2 PID: 37208 at fs/btrfs/block-rsv.c:447 btrfs_release_glo=
bal_block_rsv+0xb6/0xf0 [btrfs]
> Modules linked in: btrfs blake2b_generic overlay tcp_diag inet_diag raid=
456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_p=
q ebtable_filter ebtables ip_set ip6table_raw iptable_raw ip6table_filter =
ip6_tables iptable_filter bpfilter nf_tables libcrc32c cmac algif_hash alg=
if_skcipher af_alg softdog bnep bonding tls sunrpc binfmt_misc nfnetlink_l=
og nfnetlink ipmi_ssif intel_rapl_msr intel_rapl_common amd64_edac edac_mc=
e_amd kvm_amd btusb btrtl kvm btbcm btintel btmtk irqbypass ast rapl drm_s=
hmem_helper pcspkr bluetooth drm_kms_helper syscopyarea ecdh_generic sysfi=
llrect ecc sysimgblt acpi_ipmi ccp joydev input_leds k10temp ptdma ipmi_si=
 ipmi_devintf ipmi_msghandler mac_hid zfs(PO) zunicode(PO) zzstd(O) zlua(O=
) zavl(PO) icp(PO) zcommon(PO) znvpair(PO) spl(O) vhost_net vhost vhost_io=
tlb tap efi_pstore drm dmi_sysfs ip_tables x_tables autofs4 dm_crypt simpl=
efb usbmouse hid_lg_g15 usbkbd hid_generic usbhid hid crct10dif_pclmul crc=
32_pclmul polyval_clmulni
>   polyval_generic ghash_clmulni_intel sha512_ssse3 aesni_intel crypto_si=
md cryptd nvme igb mpt3sas xhci_pci i2c_algo_bit nvme_core xhci_pci_renesa=
s raid_class ahci dca nvme_common scsi_transport_sas libahci i2c_piix4 xhc=
i_hcd
> CPU: 2 PID: 37208 Comm: mount Tainted: P        W  O       6.2.16-3-pve =
#1
> Hardware name: Thomas-Krenn.AG Chenbro Serverchassis SR107+ (USB3.0)/H11=
SSL-i, BIOS 2.1 02/21/2020
> RIP: 0010:btrfs_release_global_block_rsv+0xb6/0xf0 [btrfs]
> Code: 01 00 00 00 74 a4 0f 0b 48 83 bb 50 01 00 00 00 74 a2 0f 0b 48 83 =
bb 58 01 00 00 00 74 a0 0f 0b 48 83 bb 80 01 00 00 00 74 9e <0f> 0b 48 83 =
bb 88 01 00 00 00 74 9c 0f 0b 48 83 bb b8 01 00 00 00
> RSP: 0018:ffffa26ac8977b20 EFLAGS: 00010286
> RAX: 0000000020000000 RBX: ffff8d3995f79000 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: ffffa26ac8977b28 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: ffff8d399fa4f400
> R13: ffff8d3995f79088 R14: dead000000000122 R15: dead000000000100
> FS:  00007efe2b6a9840(0000) GS:ffff8d602ee80000(0000) knlGS:000000000000=
0000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000055ce75226a10 CR3: 000000014f282000 CR4: 0000000000350ee0
> Call Trace:
>   btrfs_free_block_groups+0x296/0x370 [btrfs]
>   open_ctree+0x11d4/0x1810 [btrfs]
>   btrfs_mount_root+0x457/0x540 [btrfs]
>   ? __kmem_cache_alloc_node+0x19d/0x340
>   ? vfs_parse_fs_param_source+0x21/0xa0
>   legacy_get_tree+0x2b/0x60
>   vfs_get_tree+0x2a/0xe0
>   vfs_kern_mount.part.0+0x86/0xd0
>   vfs_kern_mount+0x13/0x40
>   btrfs_mount+0x149/0x450 [btrfs]
>   ? legacy_parse_param+0x29/0x240
>   legacy_get_tree+0x2b/0x60
>   vfs_get_tree+0x2a/0xe0
>   path_mount+0x4e1/0xb20
>   ? putname+0x5d/0x80
>   __x64_sys_mount+0x127/0x160
>   do_syscall_64+0x5b/0x90
>   ? do_syscall_64+0x67/0x90
>   entry_SYSCALL_64_after_hwframe+0x72/0xdc
> RIP: 0033:0x7efe2b8a8b1a
> Code: 48 8b 0d e9 82 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 =
00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 =
ff ff 73 01 c3 48 8b 0d b6 82 0c 00 f7 d8 64 89 01 48
> RSP: 002b:00007fffab9bffc8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 0000563136b03af0 RCX: 00007efe2b8a8b1a
> RDX: 0000563136b0a120 RSI: 0000563136b03d40 RDI: 0000563136b03d20
> RBP: 0000000000000000 R08: 0000563136b03d80 R09: 0000563136b0a140
> R10: 0000000000000001 R11: 0000000000000246 R12: 0000563136b03d20
> R13: 0000563136b0a120 R14: 00007efe2ba10264 R15: 0000563136b03c08
>   </TASK>
> ---[ end trace 0000000000000000 ]---
> BTRFS error (device dm-3: state E): open_ctree failed
>
>
>
> Thanks,
> Bernhard
>
>
