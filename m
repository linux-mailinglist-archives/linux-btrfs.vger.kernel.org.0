Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62F5A1F12D7
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jun 2020 08:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728979AbgFHG1X (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Jun 2020 02:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728538AbgFHG1W (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Jun 2020 02:27:22 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513E9C08C5C3
        for <linux-btrfs@vger.kernel.org>; Sun,  7 Jun 2020 23:27:22 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id x6so15972957wrm.13
        for <linux-btrfs@vger.kernel.org>; Sun, 07 Jun 2020 23:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=YROsqR7QhRZMF7DbXQcTq+lfLAI0GpQsKEquv4f06P0=;
        b=HVlcsPzHIZ9puh4G/AwpyjdPE61qVFWdVLOCU3pI1IVJYmThj5fohJ0cKLj6wKZARZ
         y5oSkupW/1mRzVzDYTWdsNdH3HHeUxDt271wdc6ipRWaFkoD+YozNxSUMJzleIt55RmH
         fHR5AiXV9CvGR0j27yCswgKLKJp3+CgsuUop/6R/63CBjIQ46m+9HMrGQDdXlI/TiayP
         Y4nxzmTqqcqqgUKmQTrFW5Cs/dQyj7DF83Sor3QybNpKYUJUOigeYRFPDmcLHaudJWhO
         OO+dZ4JaPHsBfrM5kDUp/sqEbZCyssZp+IWvJBu4mAPA2whOD+MBvIz2U6mDV4cGEiKM
         3Jww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=YROsqR7QhRZMF7DbXQcTq+lfLAI0GpQsKEquv4f06P0=;
        b=mPFFU4l8AY/5RxC7vX223wMPZ3Oxc3e/AfusBfeCR6DVrEJ6Pl7sV4MsQJcMhgVxmf
         hnGrdDAFVV7EpkbPX80WVtcLl9DtQFCYIP779bhKtZ/tsEYyxl2CpwvDjARA1Xvd0M7u
         B/GFd631qncGw/UMRaikpeTQOlZXe4ofocB+4gN8DtixUmtw/NjYneoOYdvSYyVeUlkF
         p6sHxOOk9wb/WMPfvpzMX95ZmfTHTs6hHnSPV3Bgg4RO5SCs6CzvDgYUGO75K3OqKyz9
         Lnxfy2z2gkGal74lc5XEUL15Z2NWGcvIVp1Z6WD7SCNKBAUbo4SP5JvWs2H6pF4C9wWq
         BZEQ==
X-Gm-Message-State: AOAM532B+qDsoxZ1Ubt8iLdZOl2eKPD3jbDgf+1hsY7KGHjTFXHh2erS
        V6qWKhJtuGoXYzIk6dmOOnc/Jrjq3QRwbH+XejqKtw0S
X-Google-Smtp-Source: ABdhPJzEWNWFh13kFBAZ/5LuYkHMw2oNEgpOgh8PQZ+/07LBKFDqY/l9PRniWrjFZ37lnUvfryZOwVSfZNLJX5yGYEM=
X-Received: by 2002:a5d:558a:: with SMTP id i10mr23316124wrv.207.1591597639683;
 Sun, 07 Jun 2020 23:27:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAGn6XV84WRvbFujZw+7NDOqrQxKALwtAv3Qe-Tsbc6nt-DJrQQ@mail.gmail.com>
In-Reply-To: <CAGn6XV84WRvbFujZw+7NDOqrQxKALwtAv3Qe-Tsbc6nt-DJrQQ@mail.gmail.com>
From:   Jason Daly <lyceel@gmail.com>
Date:   Sun, 7 Jun 2020 23:27:08 -0700
Message-ID: <CAGn6XV8XvNya-XH5ydJ8Y5z_wkwwUMrrARtKqSpb9jpH1wuLcA@mail.gmail.com>
Subject: Re: btrfs balance: ended with status: -30
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

OK, so I did my digging and figured out this is an ENOSPC error, and
that led me to the btrfs-balance docs about this issue.

A quick "btrfs balance start -dusage=0 -musage=0" seems to have me
back on track.

Apologies for the noise.

On Sun, Jun 7, 2020 at 10:34 PM Jason Daly <lyceel@gmail.com> wrote:
>
> Not sure how serious this is yet, but it seemed to bear reporting.
> (Data seems OK so far, but the filesystem was remounted ro).  I'd
> appreciate any advice on how to proceed.
>
> Was trying to rebalance from RAID1 to RAID10, and it aborted near the end:
>
> [427938.250436] ------------[ cut here ]------------
> [427938.250439] BTRFS: Transaction aborted (error -28)
> [427938.250475] WARNING: CPU: 3 PID: 70178 at
> fs/btrfs/extent-tree.c:2209 btrfs_run_delayed_refs+0x1a1/0x1f0 [btrfs]
> [427938.250475] Modules linked in: uas usb_storage rfkill
> nf_conntrack_netbios_ns nf_conntrack_broadcast xt_CT ip6t_REJECT
> nf_reject_ipv6 ip6t_rpfilter ipt_REJECT nf_reject_ipv4 xt_conntrack
> ebtable_nat ebtable_broute ip6table_nat ip6table_mangle ip6table_raw
> ip6table_security iptable_nat nf_nat iptable_mangle iptable_raw
> iptable_security nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set
> nfnetlink ebtable_filter ebtables ip6table_filter ip6_tables
> iptable_filter sunrpc vfat fat intel_rapl_msr snd_sof_pci
> intel_rapl_common snd_sof_intel_byt snd_sof_intel_ipc
> snd_sof_xtensa_dsp snd_sof_intel_hda_common snd_soc_hdac_hda
> snd_sof_intel_hda snd_sof x86_pkg_temp_thermal intel_powerclamp
> coretemp snd_soc_skl kvm_intel snd_hda_codec_hdmi snd_soc_sst_ipc
> snd_soc_sst_dsp snd_hda_ext_core snd_soc_acpi_intel_match snd_soc_acpi
> kvm snd_hda_codec_realtek snd_soc_core snd_hda_codec_generic
> ledtrig_audio snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel
> irqbypass snd_intel_dspcfg crct10dif_pclmul
> [427938.250487]  snd_hda_codec crc32_pclmul iTCO_wdt mei_hdcp
> iTCO_vendor_support snd_hda_core ghash_clmulni_intel snd_hwdep ppdev
> snd_seq intel_cstate snd_seq_device intel_uncore intel_rapl_perf
> snd_pcm wmi_bmof btrfs snd_timer snd blake2b_generic i2c_i801
> soundcore xor zstd_compress mei_me raid6_pq zstd_decompress joydev mei
> intel_pch_thermal ie31200_edac parport_pc parport acpi_pad ip_tables
> xfs libcrc32c i915 i2c_algo_bit drm_kms_helper crc32c_intel drm e1000e
> wmi video pinctrl_cannonlake pinctrl_intel
> [427938.250497] CPU: 3 PID: 70178 Comm: btrfs Not tainted
> 5.5.10-200.fc31.x86_64 #1
> [427938.250498] Hardware name: Gigabyte Technology Co., Ltd. H310M
> A/H310M A-CF, BIOS F2 04/19/2018
> [427938.250507] RIP: 0010:btrfs_run_delayed_refs+0x1a1/0x1f0 [btrfs]
> [427938.250508] Code: 41 5f c3 49 8b 54 24 50 f0 48 0f ba aa 30 ce 00
> 00 02 72 1b 83 f8 fb 74 37 89 c6 48 c7 c7 48 51 c9 c0 89 04 24 e8 21
> b6 50 c8 <0f> 0b 8b 04 24 89 c1 ba a1 08 00 00 4c 89 e7 89 04 24 48 c7
> c6 e0
> [427938.250508] RSP: 0018:ffff9cee408538f8 EFLAGS: 00010282
> [427938.250509] RAX: 0000000000000000 RBX: ffffffffffffffff RCX:
> 0000000000000007
> [427938.250509] RDX: 0000000000000007 RSI: 0000000000000082 RDI:
> ffff90409e599cc0
> [427938.250510] RBP: ffff904090316158 R08: 000000000000409b R09:
> 0000000000000003
> [427938.250510] R10: 0000000000000000 R11: 0000000000000001 R12:
> ffff90409c4a5888
> [427938.250510] R13: ffff904099af6e20 R14: ffff904099af6e10 R15:
> ffff904099af6e70
> [427938.250511] FS:  00007f4bda0328c0(0000) GS:ffff90409e580000(0000)
> knlGS:0000000000000000
> [427938.250512] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [427938.250512] CR2: 0000555fed2fe000 CR3: 000000041bcfa006 CR4:
> 00000000003606e0
> [427938.250512] Call Trace:
> [427938.250529]  btrfs_write_dirty_block_groups+0x17a/0x3a0 [btrfs]
> [427938.250538]  ? btrfs_run_delayed_refs+0x9c/0x1f0 [btrfs]
> [427938.250548]  commit_cowonly_roots+0x245/0x300 [btrfs]
> [427938.250557]  btrfs_commit_transaction+0x4cf/0xa20 [btrfs]
> [427938.250570]  prepare_to_merge+0x23e/0x260 [btrfs]
> [427938.250582]  relocate_block_group+0x371/0x600 [btrfs]
> [427938.250593]  btrfs_relocate_block_group+0x161/0x2f0 [btrfs]
> [427938.250604]  btrfs_relocate_chunk+0x25/0x80 [btrfs]
> [427938.250615]  btrfs_balance+0x770/0xf50 [btrfs]
> [427938.250617]  ? _cond_resched+0x15/0x30
> [427938.250629]  btrfs_ioctl_balance+0x28f/0x340 [btrfs]
> [427938.250640]  btrfs_ioctl+0x588/0x2df0 [btrfs]
> [427938.250642]  ? mem_cgroup_charge_statistics+0x79/0x100
> [427938.250643]  ? mem_cgroup_commit_charge+0xcb/0x1a0
> [427938.250645]  ? __handle_mm_fault+0xc4c/0x15d0
> [427938.250646]  ? arch_get_unmapped_area_topdown+0x56/0x2b0
> [427938.250648]  ? do_vfs_ioctl+0x461/0x6d0
> [427938.250658]  ? btrfs_ioctl_get_supported_features+0x30/0x30 [btrfs]
> [427938.250658]  do_vfs_ioctl+0x461/0x6d0
> [427938.250660]  ? handle_mm_fault+0xc4/0x1f0
> [427938.250661]  ksys_ioctl+0x5e/0x90
> [427938.250662]  __x64_sys_ioctl+0x16/0x20
> [427938.250663]  do_syscall_64+0x5b/0x1c0
> [427938.250665]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [427938.250666] RIP: 0033:0x7f4bda12d38b
> [427938.250668] Code: 0f 1e fa 48 8b 05 fd 9a 0c 00 64 c7 00 26 00 00
> 00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00
> 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d cd 9a 0c 00 f7 d8 64 89
> 01 48
> [427938.250668] RSP: 002b:00007fffaf458988 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000010
> [427938.250669] RAX: ffffffffffffffda RBX: 00007fffaf458a30 RCX:
> 00007f4bda12d38b
> [427938.250669] RDX: 00007fffaf458a30 RSI: 00000000c4009420 RDI:
> 0000000000000003
> [427938.250670] RBP: 0000000000000003 R08: 000055aaadc692a0 R09:
> 0000000000000231
> [427938.250670] R10: 0000000000000000 R11: 0000000000000246 R12:
> 0000000000000001
> [427938.250670] R13: 00007fffaf45a897 R14: 0000000000000001 R15:
> 0000000000000000
> [427938.250671] ---[ end trace 05260ed1d5d845cc ]---
> [427938.250673] BTRFS: error (device sdb) in
> btrfs_run_delayed_refs:2209: errno=-28 No space left
> [427938.250676] BTRFS info (device sdb): forced readonly
> [427938.256594] BTRFS warning (device sdb): Skipping commit of aborted
> transaction.
> [427938.256595] BTRFS: error (device sdb) in cleanup_transaction:1894:
> errno=-28 No space left
> [427938.257602] BTRFS info (device sdb): balance: ended with status: -30
>
> # uname -a
> Linux rauru 5.5.10-200.fc31.x86_64 #1 SMP Wed Mar 18 14:21:38 UTC 2020
> x86_64 x86_64 x86_64 GNU/Linux
>
> # btrfs --version
> btrfs-progs v5.4
>
> # btrfs fi show
> Label: none  uuid: 4e95ee05-8639-4776-98d3-eb4ca54045a1
>         Total devices 6 FS bytes used 5.50TiB
>         devid    1 size 3.64TiB used 3.64TiB path /dev/sdb
>         devid    2 size 3.64TiB used 3.64TiB path /dev/sde
>         devid    3 size 3.64TiB used 3.64TiB path /dev/sdd
>         devid    4 size 3.64TiB used 3.19TiB path /dev/sdg
>         devid    5 size 3.64TiB used 3.14TiB path /dev/sdf
>         devid    6 size 3.64TiB used 2.66TiB path /dev/sdc
>
> # btrfs fi df /export/data
> Data, RAID10: total=9.49TiB, used=5.04TiB
> Data, RAID1: total=465.00GiB, used=464.98GiB
> System, RAID10: total=160.00MiB, used=1008.00KiB
> Metadata, RAID10: total=6.09GiB, used=6.08GiB
> Metadata, RAID1: total=1.00GiB, used=406.02MiB
> GlobalReserve, single: total=512.00MiB, used=272.00KiB
>
> dmesg.log attached
