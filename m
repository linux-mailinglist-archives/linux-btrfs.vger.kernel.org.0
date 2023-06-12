Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C7572BFC6
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jun 2023 12:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjFLKrO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Jun 2023 06:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234330AbjFLKqu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Jun 2023 06:46:50 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331EB4228
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Jun 2023 03:31:27 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id 006d021491bc7-55b3d77c9deso2835984eaf.0
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Jun 2023 03:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686565885; x=1689157885;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e4V7UGq+0u75cuKND+G8sjvotERD8/Y+1kS/wpv6w9c=;
        b=mm9UXMS2025j5YhguylHJD47M+JcWOCMhLjdh2QaPgAN7RVAE/roqvOn59Id62suPM
         yPah/RVQ9Y9lBjHwnKy5l32PUCBt8R3y47QiGlncArKYgQfOKoLi02zoa4ppFodwAsp6
         kcnP2fyACr3CmBzEuv9bG701yx3o6CWWkwq8oR93RVVEygQPkcpGxJ6Vkn2hmIpu4yYY
         gJ7g7NDpnhQQspAkHBqtjCMy859XeyLZNIbUpPGHkDPqI2qI1cP8cLerH5WSzeOQvvI7
         hiJOkue5/vyuJ9EeDSXnVHcIUK6j0gQdbXqIUJF4Ua4DbhM/SYrBiltKcoNQ7u2eDPfZ
         KNEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686565885; x=1689157885;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e4V7UGq+0u75cuKND+G8sjvotERD8/Y+1kS/wpv6w9c=;
        b=GRnVKfl0c0mZCm8GTDWA1lUlVgMKtkZvljtddWYFpcsdoV4gT/WDE2E3PpPVVDWcBZ
         FwNwhnFv12yzTR5EZKlOghrKabzq4U+tZ89+VpoZ7+pTEWc+Z6cD9RGFT0jSCNmjkRQn
         sEyenAsr3x/R6hMgAbhnDaRutVyPNrBXAp+gPqEASMIZe24olh1qPeQ3yrcW250qswxh
         btDZUhZaJizsniIwxCzKcC+fjRKUbFCr8foOoqXEAn6pvHcAqgB2luPLVTK2Nrg4cOt1
         BDAOqs7MV0nkeqWmsUVFjL0d5YxwT+tHExlpx7IHgQiuv88w7a2nloXWTtlcqpbsO/il
         Bgzg==
X-Gm-Message-State: AC+VfDy+FWjNG4wN0jRTgChqZdV7RuWJv2BnM5a6LKiFRSRfBB5yo6ee
        zUJAQQ5I31WjjXiniO8OYERMC07fxKqIbn4FKe7D9E29Ujulmg==
X-Google-Smtp-Source: ACHHUZ5F5bEIqzg88h1I4dFEIZgCyNyaZPX++nfv5ccFr92yRTZHc0oOQqcM8RW8cD620zK0m4LYYyN9W30Afh+C0UU=
X-Received: by 2002:a4a:ead6:0:b0:555:91b1:546a with SMTP id
 s22-20020a4aead6000000b0055591b1546amr4488170ooh.2.1686565885077; Mon, 12 Jun
 2023 03:31:25 -0700 (PDT)
MIME-Version: 1.0
References: <CA+W5K0r4Lv4fPf+mWWf-ppgsjyz+wOKdBRgBR6UnQafwL7HPtg@mail.gmail.com>
 <1ee0e330-1226-7abf-44bc-033decbe43e0@gmx.com>
In-Reply-To: <1ee0e330-1226-7abf-44bc-033decbe43e0@gmx.com>
From:   Stefan N <stefannnau@gmail.com>
Date:   Mon, 12 Jun 2023 20:01:13 +0930
Message-ID: <CA+W5K0ow+95pWnzam8N6=c5Ff61ZeHyv7_yDK0LG6ujU48=yBA@mail.gmail.com>
Subject: Re: Out of space loop: skip_balance not working
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Qu,

Thanks for the quick helpful response, though perhaps it may not be
sufficient in my case.

I've tried using the latest ubuntu livecd which has btrfs-progs v6.2
on kernel 6.20.0-20

Unfortunately I haven't been able to get any further as even when
doing a rm, truncate, btrfs fi sync or btrfs dev add immediately after
mounting it still results in i/o error or read only. I tried removing
a small file or two or directories with no difference.

The stack trace below still suggests no space left but space_info does
clarify that metadata is -124M but data has 149G and system 31M free.

When I mount I get:
using crc32c (crc32c-intel) checksum algorithm
disk space caching is enabled
bdev /dev/sdf errs: wr 0, rd 0, flush 0, corrupt 845, gen 0
bdev /dev/sdg errs: wr 41089, rd 1556, flush 0, corrupt 0, gen 0
bdev /dev/sdc errs: wr 3, rd 7, flush 0, corrupt 0, gen 0
bdev /dev/sde errs: wr 41, rd 0, flush 0, corrupt 0, gen 0
balance: resume skipped
checking UUID tree

Then when it inevitably crashes, something like:
BTRFS: Transaction aborted (error -28)
WARNING: CPU: 3 PID: 24859 at fs/btrfs/extent-tree.c:2847
do_free_extent_accounting+0x21a/0x220 [btrfs]
Modules linked in: nfnetlink ufs qnx4 hfsplus hfs minix ntfs msdos jfs
xfs cfg80211 snd_seq_dummy snd_hrtimer binfmt_misc zfs(PO)
zunicode(PO) zzstd(O) zlua(O) zavl(PO) icp(PO) zcommon(PO) znvpair(PO)
snd_hda_codec_realtek spl(O) snd_hda_codec_generic ledtrig_audio
snd_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi
snd_hda_codec snd_hda_core intel_rapl_msr snd_hwdep intel_rapl_common
snd_pcm snd_seq_midi snd_seq_midi_event edac_mce_amd snd_rawmidi
kvm_amd snd_seq snd_seq_device snd_timer kvm snd irqbypass soundcore
rapl k10temp wmi_bmof ccp input_leds mac_hid msr parport_pc ppdev lp
parport efi_pstore dmi_sysfs ip_tables x_tables autofs4 overlay isofs
nls_iso8859_1 btrfs blake2b_generic xor raid6_pq libcrc32c dm_mirror
dm_region_hash dm_loghid_generic usbhid hid amdgpu iommu_v2 drm_buddy
gpu_sched drm_ttm_helper ttm drm_display_helper cec rc_core uas
usb_storage mpt3sas drm_kms_helper raid_class crct10dif_pclmul nvme
crc32_pclmul syscopyarea
polyval_clmulni polyval_generic sysfillrect ghash_clmulni_intel
sha512_ssse3 sysimgblt aesni_intel crypto_simd xhci_pci drm igb cryptd
i2c_piix4 qlcnic xhci_pci_renesas scsi_transport_sas nvme_core ahci
libahci dca nvme_common i2c_algo_bit videowmi
CPU: 3 PID: 24859 Comm: kworker/u8:8 Tainted: P        W  O
6.2.0-20-generic #20-Ubuntu
Hardware name: To Be Filled By O.E.M. X570M Pro4/X570M Pro4, BIOS
P3.70 02/23/2022
Workqueue: events_unbound btrfs_async_reclaim_metadata_space [btrfs]
RIP: 0010:do_free_extent_accounting+0x21a/0x220 [btrfs]
Code: f4 0f 0b eb b8 44 89 e6 48 c7 c7 20 99 8d c1 e8 7c 74 b1 f4 0f
0b e9 78 ff ff ff 44 89 e6 48 c7 c7 20 99 8d c1 e8 66 74 b1 f4 <0f> 0b
eb b9 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffb4374719fb58 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff9babc07adf08 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffb4374719fb80 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 00000000ffffffe4
R13: 00005cd6df95f000 R14: 000000000001f000 R15: ffff9baad11628c0
FS:  0000000000000000(0000) GS:ffff9bb1e1180000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000306c962cc000 CR3: 0000000126e4e000 CR4: 00000000003506e0
Call Trace:
<TASK>
__btrfs_free_extent+0x6bc/0xf50 [btrfs]
run_delayed_data_ref+0x8b/0x180 [btrfs]
btrfs_run_delayed_refs_for_head+0x196/0x520 [btrfs]
__btrfs_run_delayed_refs+0xe6/0x1d0 [btrfs]
btrfs_run_delayed_refs+0x6d/0x1f0 [btrfs]
flush_space+0x23c/0x2c0 [btrfs]
btrfs_async_reclaim_metadata_space+0x1d4/0x300 [btrfs]
process_one_work+0x225/0x430
worker_thread+0x50/0x3e0
? __pfx_worker_thread+0x10/0x10
kthread+0xe9/0x110
? __pfx_kthread+0x10/0x10
ret_from_fork+0x2c/0x50
</TASK>
---[ end trace 0000000000000000 ]---
BTRFS info (device sdi: state A): dumping space info:
BTRFS info (device sdi: state A): space_info DATA has 160778199040
free, is not full
BTRFS info (device sdi: state A): space_info total=71201958395904,
used=71018527428608, pinned=22649229312, reserved=0, may_use=0,
readonly=3538944 zone_unusable=0
BTRFS info (device sdi: state A): space_info METADATA has -130809856
free, is full
BTRFS info (device sdi: state A): space_info total=83530612736,
used=82789154816, pinned=245710848, reserved=495747072,
may_use=130809856, readonly=0 zone_unusable=0
BTRFS info (device sdi: state A): space_info SYSTEM has 33439744 free,
is not full
BTRFS info (device sdi: state A): space_info total=38797312,
used=5357568, pinned=0, reserved=0, may_use=0, readonly=0
zone_unusable=0
BTRFS info (device sdi: state A): global_block_rsv: size 536870912
reserved 130809856
BTRFS info (device sdi: state A): trans_block_rsv: size 0 reserved 0
BTRFS info (device sdi: state A): chunk_block_rsv: size 0 reserved 0
BTRFS info (device sdi: state A): delayed_block_rsv: size 0 reserved 0
BTRFS info (device sdi: state A): delayed_refs_rsv: size 220645556224 reserved 0
BTRFS: error (device sdi: state A) in do_free_extent_accounting:2847:
errno=-28 No space left
BTRFS info (device sdi: state EA): forced readonly

On Mon, 12 Jun 2023 at 14:50, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2023/6/12 12:47, Stefan N wrote:
> > Hi,
> >
> > I'm having trouble trying to break my array out of an out of space loop.
> >
> > On reboot I'm able to mount the filesystem and read files fine but as
> > soon as I try to delete/write it hangs until the mount is made read
> > only when it then fails.
> >
> > The following command (immediately after boot, no fstab) suggests
> > perhaps the skip_balance is not working as expected:
> > $ mount -o skip_balance -t btrfs /dev/sde /mnt/point && btrfs device
> > add /dev/loop12 /mnt/point/
> > ERROR: unable to start device add, another exclusive operation
> > 'balance' in progress
>
> skip_balance makes the balance into the paused status.
> You still need to cancel it first.
>
> > and ps shows a [btrfs-balance] process.
>
> Furthermore, balance won't help for your case.
>
> Both metadata and data are almost full.
>
> >
> > If I perform a rm or truncate during this window it fails to perform
> > any action before being marked read only. The same applies if I
> > attempt to cancel the balance.
> >
> > How can I get out of this cycle? I've previously run out of space and
> > been able to recover by deleting a few files etc without needing to
> > invoke skip_balance, but that was likely on older versions.
> >
> > Any help would be greatly appreciated.
> >
> > - Stefan
> >
> > $ uname -a
> > Linux my.host 5.15.0-73-generic #80-Ubuntu SMP Mon May 15 15:18:26 UTC
> > 2023 x86_64 x86_64 x86_64 GNU/Linux
> > $ btrfs --version
> > btrfs-progs v5.16.2
> > $ btrfs fi show
> > Label: none  uuid: ---
> >          Total devices 8 FS bytes used 64.67TiB
> >          devid    1 size 10.91TiB used 10.91TiB path /dev/sdk
> >          devid    2 size 10.91TiB used 10.91TiB path /dev/sdh
> >          devid    3 size 10.91TiB used 10.91TiB path /dev/sdj
> >          devid    4 size 10.91TiB used 10.91TiB path /dev/sdi
> >          devid    5 size 10.91TiB used 10.91TiB path /dev/sdf
> >          devid    6 size 10.91TiB used 10.91TiB path /dev/sdg
> >          devid    7 size 10.91TiB used 10.91TiB path /dev/sdd
> >          devid    8 size 10.91TiB used 10.91TiB path /dev/sde
> > $ btrfs fi df /mnt/point/
> > Data, RAID6: total=64.76TiB, used=64.59TiB
> > System, RAID1C4: total=37.00MiB, used=5.11MiB
> > Metadata, RAID1C4: total=77.79GiB, used=77.10GiB
> > GlobalReserve, single: total=512.00MiB, used=387.11MiB
> > $
> >
>
> My recommendation is, try some newer kernel (easier with a rolling
> distro liveCD).
>
> Still with skip_balance, cancel the balance, and delete a small file
> first, then sync, and check if the fs is still fine.
>
> Then start with larger and larger files/subvolumes.
>
> Thanks,
> Qu
>
> > BTRFS: Transaction aborted (error -28)
> > BTRFS: error (device sdk) in __btrfs_free_extent:3180: errno=-28 No space left
> > BTRFS info (device sdk): forced readonly
> > BTRFS error (device sdk): failed to run delayed ref for logical
> > 101911627694080 num_bytes 126976 type 184 action 2 ref_mod 1: -28
> > WARNING: CPU: 2 PID: 7851 at fs/btrfs/extent-tree.c:3180
> > __btrfs_free_extent+0x7e4/0x950 [btrfs]
> > BTRFS: error (device sdk) in btrfs_run_delayed_refs:2152: errno=-28 No
> > space left
> > BTRFS warning (device sdk): btrfs_uuid_scan_kthread failed -28
> > Modules linked in: xt_nat xt_tcpudp veth xt_conntrack nft_chain_nat
> > xt_MASQUERADE nf_nat nf_conntrack_netlink nf_conntrack nf_defrag_ipv6
> > nf_defrag_ipv4 xfrm_user xfrm_algo nft_counter xt_addrtype nft_compat
> > nf_tables nfnetlink br_netfilter bridge stp llc ipmi_devintf
> > ipmi_msghandler overlay binfmt_misc intel_rapl_msr intel_rapl_common
> > edac_mce_amd snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio
> > snd_hda_codec_hdmi kvm_amd nls_iso8859_1 kvm snd_hda_intel rapl
> > snd_intel_dspcfg snd_intel_sdw_acpi snd_hda_codec snd_hda_core
> > wmi_bmof input_leds snd_hwdep snd_pcm k10temp snd_timer snd ccp
> > soundcore mac_hid sch_fq_codel dm_multipath scsi_dh_rdac scsi_dh_emc
> > scsi_dh_alua bonding tls ramoops pstore_blk msr reed_solomon
> > pstore_zone efi_pstore nfsd auth_rpcgss nfs_acl lockd grace sunrpc
> > ip_tables x_tables autofs4 btrfs blake2b_generic zstd_compress raid10
> > raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor
> > raid6_pq libcrc32c raid1 raid0 multipath linear
> > hid_generic usbhid hid uas usb_storage amdgpu iommu_v2 gpu_sched
> > drm_ttm_helper crct10dif_pclmul ttm drm_kms_helper syscopyarea
> > sysfillrect sysimgblt fb_sys_fops crc32_pclmul cec ghash_clmulni_intel
> > aesni_intel mpt3sas rc_core raid_class crypto_simd drm nvme i2c_piix4
> > cryptd scsi_transport_sas igb dca ahci libahci xhci_pci qlcnic
> > i2c_algo_bit nvme_core xhci_pci_renesas wmi video
> > CPU: 2 PID: 7851 Comm: btrfs-transacti Not tainted 5.15.0-73-generic #80-Ubuntu
> > Hardware name: To Be Filled By O.E.M. X570M Pro4/X570M Pro4, BIOS
> > P3.70 02/23/2022
> > RIP: 0010:__btrfs_free_extent+0x7e4/0x950 [btrfs]
> > Code: a0 48 05 50 0a 00 00 f0 48 0f ba 28 03 72 1d 8b 45 84 83 f8 fb
> > 74 32 83 f8 e2 74 2d 89 c6 48 c7 c7 98 f6 34 c1 e8 ed 42 a9 e6 <0f> 0b
> > 8b 4d 84 48 8b 7d 90 ba 6c 0c 00 00 48 c7 c6 60 39 34 c1 e8
> > RSP: 0018:ffffb63581c9fb68 EFLAGS: 00010286
> > RAX: 0000000000000000 RBX: 00000000000000d1 RCX: 0000000000000027
> > RDX: ffff8ceda0aa0588 RSI: 0000000000000001 RDI: ffff8ceda0aa0580
> > RBP: ffffb63581c9fc10 R08: 0000000000000003 R09: fffffffffffe2710
> > R10: 000000002938322d R11: 00000000322d2072 R12: 00005cb02659c000
> > R13: 00000000000014ce R14: ffff8ce8ab3fb7e0 R15: ffff8ce8de433800
> > FS:  0000000000000000(0000) GS:ffff8ceda0a80000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 000055f2f46bb4c8 CR3: 000000010814c000 CR4: 00000000003506e0
> > Call Trace:
> > <TASK>
> > run_delayed_data_ref+0x93/0x160 [btrfs]
> > btrfs_run_delayed_refs_for_head+0x193/0x520 [btrfs]
> > __btrfs_run_delayed_refs+0x8c/0x1d0 [btrfs]
> > btrfs_run_delayed_refs+0x73/0x200 [btrfs]
> > btrfs_start_dirty_block_groups+0x296/0x4f0 [btrfs]
> > btrfs_commit_transaction+0x716/0xaa0 [btrfs]
> > ? start_transaction+0xd1/0x5b0 [btrfs]
> > ? __bpf_trace_hrtimer_init+0x20/0x20
> > transaction_kthread+0x13c/0x1b0 [btrfs]
> > ? btrfs_cleanup_transaction.isra.0+0x3c0/0x3c0 [btrfs]
> > kthread+0x12a/0x150
> > ? set_kthread_struct+0x50/0x50
> > ret_from_fork+0x22/0x30
> > </TASK>
> > ---[ end trace 8a20922ac453f776 ]---
> > BTRFS: error (device sdk) in __btrfs_free_extent:3180: errno=-28 No space left
> > BTRFS error (device sdk): failed to run delayed ref for logical
> > 101911627415552 num_bytes 126976 type 184 action 2 ref_mod 1: -28
> > BTRFS: error (device sdk) in btrfs_run_delayed_refs:2152: errno=-28 No
> > space left
