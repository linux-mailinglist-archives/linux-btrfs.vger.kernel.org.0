Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD23173CB97
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Jun 2023 17:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjFXP3y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 24 Jun 2023 11:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbjFXP3o (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 24 Jun 2023 11:29:44 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12F41987
        for <linux-btrfs@vger.kernel.org>; Sat, 24 Jun 2023 08:29:39 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6b5d6a05b6dso1404750a34.0
        for <linux-btrfs@vger.kernel.org>; Sat, 24 Jun 2023 08:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687620579; x=1690212579;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2SPjFOJUqJ8jzQGzz+Ilzkep4Tr3ZkgJXXxaiI3y7iA=;
        b=isr7yDDqnfZ3mu1+PmeT4znRp4Iy1+HMig9vAl2ZrGiI497SGoo0yw30PyDvFLQHOI
         EdmN0gEVe3yZtK6NVDmyrSQGubRfKzIs1AS3JmZukcRjeTxPCSzyCk1qcJuyO0VwYpSc
         yiytsQ9FooF1xJXv3THZAQDe1XjWrWkBOEnH2dnsPJHYtJnWqnhh5O+IhLwYuTtPLVFO
         bdgHdosC5wlnAr54qnySk/IQ3Vv8bh4xwnzTdKLWjmblYkFBSkCxzmTOeVhN9EGIcr/o
         VigQOin0/lHSoXEduv5p8fOK1FwrcOu9Luxr5AQhzdic1kDSbEdXk+6xVCCG6S1mW6i7
         Zyqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687620579; x=1690212579;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2SPjFOJUqJ8jzQGzz+Ilzkep4Tr3ZkgJXXxaiI3y7iA=;
        b=TxgwCKWmxlyccbz/zW/CH5c5sBXH48X8h+Y3CyCd/MlyHASS7GjYsN/uwPJCRcVIYg
         qg/mbFwVCvIYFvzhiqv2TuACw0c4T8n759jnDMpdveJVdrHj0S7LDlZMmUjKnnsgNfKD
         SZn9l1+xTWyX+aTiLOIjOmRrWI5yDNzAS4HBuKADG4CO5Mv9QGhI22jGoUf2s1Z75CWv
         Q3a5GScK+GCYfd+y8w5hZ8YHI7V/5WrXyKf04C4ajmJSRC/sWkk9i0zvGZXLasM3Ii4p
         waVxApy4Rf00BFTsF8ZzTH9UdzPaPbXYcaZ6qVRzAV5UdrqtD+AgDi1KNOPrJZv6swpB
         gFmg==
X-Gm-Message-State: AC+VfDxUEJ2uJlwe1RexrHNEzGqnga5/9/CxLZC2Kz0rcNr1r2E1Oo4T
        9MvIRcLimm/9jdAYrgoONVNqvCKhFKPlew6LEpPcZOTg0iE=
X-Google-Smtp-Source: ACHHUZ5qg5ka+d8Z41Sc5gDb45v+tAMTFINsHOse0XvcjOBmUBTfG5Smg3CVI//lyg9/Rw0E/vlvRhOYhgunIhXzp7E=
X-Received: by 2002:a05:6870:d88b:b0:19f:a340:232 with SMTP id
 dv11-20020a056870d88b00b0019fa3400232mr16032341oab.10.1687620578649; Sat, 24
 Jun 2023 08:29:38 -0700 (PDT)
MIME-Version: 1.0
References: <CA+W5K0r4Lv4fPf+mWWf-ppgsjyz+wOKdBRgBR6UnQafwL7HPtg@mail.gmail.com>
 <1ee0e330-1226-7abf-44bc-033decbe43e0@gmx.com> <CA+W5K0ow+95pWnzam8N6=c5Ff61ZeHyv7_yDK0LG6ujU48=yBA@mail.gmail.com>
 <40ecba88-9de2-7315-4ac5-e3eb892aac39@gmx.com> <CA+W5K0qLN3SaqQ242Jerp_fiyBw407e2h_BEA9rQ45HU-TfaZA@mail.gmail.com>
 <SYCPR01MB46856D101B81641A6CE21FB99E55A@SYCPR01MB4685.ausprd01.prod.outlook.com>
 <CA+W5K0oKO2Vxu3D2jOLET1RrM=wOxTEH2a_uH1w44H2x9kT2tQ@mail.gmail.com>
 <16ab1898-1714-a927-b8df-4a20eb39b8cd@gmx.com> <CA+W5K0pm+Aum0vQGeRfUCsH_4x8+L3O+baUfRJM-iWdh+tDwNA@mail.gmail.com>
 <403c9e19-e58e-8857-bee8-dd9f9d8fc34f@suse.com> <CA+W5K0qzk0Adt2a_Xp5qh=JYyO02mh5YK3c1wgvQEyS3mHSR_w@mail.gmail.com>
 <e559f54f-c5b8-0132-b420-22b6db5539f3@gmx.com> <CA+W5K0r3jpw-zN1y9=essSUUwCRrsGveV1qHSFsKfmrM40OgJQ@mail.gmail.com>
 <1d920a8b-efd8-468b-3abe-f998f0b0966a@gmx.com> <CA+W5K0o-aVROdCH+qWacW_96oAVXGpWSXqSSsM=1R024WhLgXQ@mail.gmail.com>
 <124f60c9-4df1-20d0-1884-3d868329608d@suse.com>
In-Reply-To: <124f60c9-4df1-20d0-1884-3d868329608d@suse.com>
From:   Stefan N <stefannnau@gmail.com>
Date:   Sun, 25 Jun 2023 00:59:26 +0930
Message-ID: <CA+W5K0r=5RSEvKwN03iTSYwf_5c2QNU02jtumwbXwdo3iV1ZfQ@mail.gmail.com>
Subject: Re: Out of space loop: skip_balance not working
To:     Qu Wenruo <wqu@suse.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Whoops, I had left --dry-run on the first debug patch you commited, so
that didn't run correctly.

I've included the output from both patches, as they result in different output.

Rerunning the older patch first, with loop devices (I tried both
4x100mb and 4x1gb) I get the following:

$ sudo mount -o skip_balance -t btrfs /dev/sde /mnt/data ; sudo btrfs
dev add -K -f /dev/loop16 /dev/loop17 /dev/loop18 /dev/loop19
/mnt/data ; sudo btrfs fi sync /mnt/data
ERROR: error adding device '/dev/loop16': Input/output error
ERROR: error adding device '/dev/loop17': Read-only file system
ERROR: error adding device '/dev/loop18': Read-only file system
ERROR: error adding device '/dev/loop19': Read-only file system
ERROR: Could not sync filesystem: Read-only file system
$

kernel: [  299.846627] BTRFS info (device sdd): using crc32c
(crc32c-intel) checksum algorithm
kernel: [  299.846648] BTRFS info (device sdd): disk space caching is enabled
kernel: [  304.864437] BTRFS info (device sdd): bdev /dev/sdh errs: wr
0, rd 0, flush 0, corrupt 845, gen 0
kernel: [  304.864454] BTRFS info (device sdd): bdev /dev/sdb errs: wr
41089, rd 1556, flush 0, corrupt 0, gen 0
kernel: [  304.864465] BTRFS info (device sdd): bdev /dev/sdi errs: wr
3, rd 7, flush 0, corrupt 0, gen 0
kernel: [  304.864473] BTRFS info (device sdd): bdev /dev/sde errs: wr
41, rd 0, flush 0, corrupt 0, gen 0
kernel: [  516.646032] BTRFS info (device sdd): balance: resume skipped
kernel: [  516.646046] BTRFS info (device sdd): checking UUID tree
kernel: [  722.307267] ------------[ cut here ]------------
kernel: [  722.307274] BTRFS: Transaction aborted (error -28)
kernel: [  722.307352] WARNING: CPU: 3 PID: 3984 at
fs/btrfs/extent-tree.c:2847 do_free_extent_accounting+0x21a/0x220
[btrfs]
kernel: [  722.307507] Modules linked in: ipmi_devintf ipmi_msghandler
overlay iwlwifi_compat(O) binfmt_misc nls_iso8859_1 intel_rapl_msr
intel_rapl_common edac_mce_amd kvm_amd snd_hda_codec_realtek
snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi snd_hda_intel
snd_intel_dspcfg snd_intel_sdw_acpi snd_hda_codec kvm snd_hda_core
irqbypass snd_hwdep rapl snd_pcm wmi_bmof snd_timer k10temp snd
soundcore ccp input_leds mac_hid dm_multipath scsi_dh_rdac scsi_dh_emc
scsi_dh_alua nfsd bonding auth_rpcgss nfs_acl tls lockd grace msr
efi_pstore sunrpc dmi_sysfs ip_tables x_tables autofs4 btrfs
blake2b_generic raid10 raid456 async_raid6_recov async_memcpy async_pq
async_xor async_tx xor raid6_pq libcrc32c raid1 raid0 multipath linear
hid_generic usbhid hid amdgpu uas usb_storage iommu_v2 drm_buddy
gpu_sched drm_ttm_helper ttm drm_display_helper cec rc_core mpt3sas
drm_kms_helper crct10dif_pclmul crc32_pclmul polyval_clmulni
polyval_generic syscopyarea sysfillrect ghash_clmulni_intel
sha512_ssse3
kernel: [  722.307642]  sysimgblt aesni_intel nvme crypto_simd
raid_class cryptd ahci drm i2c_piix4 scsi_transport_sas igb libahci
xhci_pci nvme_core xhci_pci_renesas qlcnic dca nvme_common
i2c_algo_bit video wmi
kernel: [  722.307677] CPU: 3 PID: 3984 Comm: kworker/u64:1 Tainted: G
       W  O       6.2.0-23-generic #23+btrdebug1b
kernel: [  722.307685] Hardware name: To Be Filled By O.E.M. X570M
Pro4/X570M Pro4, BIOS P3.70 02/23/2022
kernel: [  722.307690] Workqueue: events_unbound
btrfs_async_reclaim_metadata_space [btrfs]
kernel: [  722.307853] RIP: 0010:do_free_extent_accounting+0x21a/0x220 [btrfs]
kernel: [  722.307977] Code: d3 0f 0b eb b8 44 89 e6 48 c7 c7 a0 49 88
c1 e8 2c c5 96 d3 0f 0b e9 78 ff ff ff 44 89 e6 48 c7 c7 a0 49 88 c1
e8 16 c5 96 d3 <0f> 0b eb b9 66 90 90 90 90 90 90 90 90 90 90 90 90 90
90 90 90 90
kernel: [  722.307982] RSP: 0018:ffffbde605a4bb58 EFLAGS: 00010246
kernel: [  722.307988] RAX: 0000000000000000 RBX: ffff9b276c9d9d68
RCX: 0000000000000000
kernel: [  722.307992] RDX: 0000000000000000 RSI: 0000000000000000
RDI: 0000000000000000
kernel: [  722.307995] RBP: ffffbde605a4bb80 R08: 0000000000000000
R09: 0000000000000000
kernel: [  722.307998] R10: 0000000000000000 R11: 0000000000000000
R12: 00000000ffffffe4
kernel: [  722.308002] R13: 00005cd8260e0000 R14: 00000000001a0000
R15: ffff9b28dde0bcb0
kernel: [  722.308006] FS:  0000000000000000(0000)
GS:ffff9b2e20ac0000(0000) knlGS:0000000000000000
kernel: [  722.308010] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
kernel: [  722.308014] CR2: 00007f45b173a0e0 CR3: 0000000143f8e000
CR4: 00000000003506e0
kernel: [  722.308018] Call Trace:
kernel: [  722.308022]  <TASK>
kernel: [  722.308029]  __btrfs_free_extent+0x6bc/0xf50 [btrfs]
kernel: [  722.308156]  run_delayed_data_ref+0x8b/0x180 [btrfs]
kernel: [  722.308281]  btrfs_run_delayed_refs_for_head+0x196/0x520 [btrfs]
kernel: [  722.308406]  __btrfs_run_delayed_refs+0xe6/0x1d0 [btrfs]
kernel: [  722.308530]  btrfs_run_delayed_refs+0x6d/0x1f0 [btrfs]
kernel: [  722.308653]  flush_space+0x23c/0x2c0 [btrfs]
kernel: [  722.308812]  btrfs_async_reclaim_metadata_space+0x19b/0x2b0 [btrfs]
kernel: [  722.308969]  process_one_work+0x225/0x430
kernel: [  722.308980]  worker_thread+0x50/0x3e0
kernel: [  722.308986]  ? __pfx_worker_thread+0x10/0x10
kernel: [  722.308992]  kthread+0xe9/0x110
kernel: [  722.309000]  ? __pfx_kthread+0x10/0x10
kernel: [  722.309008]  ret_from_fork+0x2c/0x50
kernel: [  722.309018]  </TASK>
kernel: [  722.309020] ---[ end trace 0000000000000000 ]---
kernel: [  722.309024] BTRFS info (device sdd: state A): dumping space info:
kernel: [  722.309029] BTRFS info (device sdd: state A): space_info
DATA has 160778199040 free, is not full
kernel: [  722.309034] BTRFS info (device sdd: state A): space_info
total=71201958395904, used=71018502324224, pinned=22674333696,
reserved=0, may_use=0, readonly=3538944 zone_unusable=0
kernel: [  722.309042] BTRFS info (device sdd: state A): space_info
METADATA has -124960768 free, is full
kernel: [  722.309047] BTRFS info (device sdd: state A): space_info
total=83530612736, used=82790334464, pinned=242483200,
reserved=497795072, may_use=124960768, readonly=0 zone_unusable=0
kernel: [  722.309054] BTRFS info (device sdd: state A): space_info
SYSTEM has 33439744 free, is not full
kernel: [  722.309058] BTRFS info (device sdd: state A): space_info
total=38797312, used=5357568, pinned=0, reserved=0, may_use=0,
readonly=0 zone_unusable=0
kernel: [  722.309065] BTRFS info (device sdd: state A):
global_block_rsv: size 536870912 reserved 124960768
kernel: [  722.309069] BTRFS info (device sdd: state A):
trans_block_rsv: size 0 reserved 0
kernel: [  722.309072] BTRFS info (device sdd: state A):
chunk_block_rsv: size 0 reserved 0
kernel: [  722.309076] BTRFS info (device sdd: state A):
delayed_block_rsv: size 0 reserved 0
kernel: [  722.309079] BTRFS info (device sdd: state A):
delayed_refs_rsv: size 255294439424 reserved 0
kernel: [  722.309083] BTRFS: error (device sdd: state A) in
do_free_extent_accounting:2847: errno=-28 No space left
kernel: [  722.309128] BTRFS info (device sdd: state EA): forced readonly
kernel: [  722.309132] BTRFS error (device sdd: state EA): failed to
run delayed ref for logical 102083421143040 num_bytes 1703936 type 184
action 2 ref_mod 1: -28
kernel: [  722.309188] BTRFS: error (device sdd: state EA) in
btrfs_run_delayed_refs:2151: errno=-28 No space left
kernel: [  722.309348] BTRFS warning (device sdd: state EA):
btrfs_uuid_scan_kthread failed -5
kernel: [  722.309350] BTRFS error (device sdd: state EA): failed to
start trans: -5
kernel: [  722.309585] BTRFS error (device sdd: state EA): failed to
add disk /dev/loop16: -5
kernel: [  722.324775] BTRFS: error (device sdd: state EA) in
do_free_extent_accounting:2847: errno=-28 No space left
kernel: [  722.324825] BTRFS error (device sdd: state EA): failed to
run delayed ref for logical 102084102217728 num_bytes 245760 type 184
action 2 ref_mod 1: -28
kernel: [  722.324870] BTRFS: error (device sdd: state EA) in
btrfs_run_delayed_refs:2151: errno=-28 No space left
kernel: [  722.329276] BTRFS error (device sdd: state EA): failed to
add disk /dev/loop17: -30
kernel: [  722.332629] BTRFS error (device sdd: state EA): failed to
add disk /dev/loop18: -30
kernel: [  722.336018] BTRFS error (device sdd: state EA): failed to
add disk /dev/loop19: -30

*** The above is using the original patch as follows:
$ diff fs/btrfs/ ../linux-6.2.0-dist/fs/btrfs/
diff fs/btrfs/ioctl.c ../linux-6.2.0-dist/fs/btrfs/ioctl.c
2656,2658d2655
<       else
<               btrfs_err(fs_info, "failed to add disk %s: %d",
<                         vol_args->name, ret);
diff fs/btrfs/transaction.c ../linux-6.2.0-dist/fs/btrfs/transaction.c
1029d1028
<               /*
1031d1029
<               */
diff fs/btrfs/volumes.c ../linux-6.2.0-dist/fs/btrfs/volumes.c
2680d2679
<               btrfs_err(fs_info, "failed to start trans: %d", ret);
2769d2767
<               btrfs_err(fs_info, "failed to add dev item: %d", ret);
2787,2789c2785
<       ret = btrfs_end_transaction(trans);
<       if (ret < 0)
<               btrfs_err(fs_info, "failed to end trans: %d", ret);
---
>       ret = btrfs_commit_transaction(trans);
$

*** The below is using the newer patch as follows:
$ diff fs/btrfs/ ../linux-6.2.0-dist/fs/btrfs/
diff fs/btrfs/ioctl.c ../linux-6.2.0-dist/fs/btrfs/ioctl.c
2656,2658d2655
<       else
<               btrfs_err(fs_info, "failed to add disk %s: %d",
<                         vol_args->name, ret);
diff fs/btrfs/transaction.c ../linux-6.2.0-dist/fs/btrfs/transaction.c
1029d1028
<               /*
1031d1029
<               */
diff fs/btrfs/volumes.c ../linux-6.2.0-dist/fs/btrfs/volumes.c
2677c2677
<       trans = btrfs_join_transaction(root);
---
>       trans = btrfs_start_transaction(root, 0);
2680d2679
<               btrfs_err(fs_info, "failed to start trans: %d", ret);
2769d2767
<               btrfs_err(fs_info, "failed to add dev item: %d", ret);
2787,2789c2785
<       ret = btrfs_end_transaction(trans);
<       if (ret < 0)
<               btrfs_err(fs_info, "failed to end trans: %d", ret);
---
>       ret = btrfs_commit_transaction(trans);
$

$ sudo mount -o skip_balance -t btrfs /dev/sde /mnt/data ; sudo btrfs
dev add -K -f /dev/loop12 /dev/loop13 /dev/loop14 /dev/loop15
/mnt/data ; sudo btrfs fi sync /mnt/data
ERROR: Could not sync filesystem: No space left on device
$

kernel: [ 1811.846087] BTRFS info (device sdc): using crc32c
(crc32c-intel) checksum algorithm
kernel: [ 1811.846107] BTRFS info (device sdc): disk space caching is enabled
kernel: [ 1817.852850] BTRFS info (device sdc): bdev /dev/sde errs: wr
0, rd 0, flush 0, corrupt 845, gen 0
kernel: [ 1817.852866] BTRFS info (device sdc): bdev /dev/sda errs: wr
41089, rd 1556, flush 0, corrupt 0, gen 0
kernel: [ 1817.852877] BTRFS info (device sdc): bdev /dev/sdh errs: wr
3, rd 7, flush 0, corrupt 0, gen 0
kernel: [ 1817.852884] BTRFS info (device sdc): bdev /dev/sdd errs: wr
41, rd 0, flush 0, corrupt 0, gen 0
kernel: [ 2037.562050] BTRFS info (device sdc): balance: resume skipped
kernel: [ 2037.562064] BTRFS info (device sdc): checking UUID tree
kernel: [ 2037.581550] BTRFS info (device sdc): disk added /dev/loop12
kernel: [ 2037.591163] BTRFS info (device sdc): disk added /dev/loop13
kernel: [ 2037.599477] BTRFS info (device sdc): disk added /dev/loop14
kernel: [ 2037.607064] BTRFS info (device sdc): disk added /dev/loop15
kernel: [ 2176.124630] INFO: task btrfs:7783 blocked for more than 120 seconds.
kernel: [ 2176.124678]       Tainted: G        W  O
6.2.0-23-generic #23+btrdebug2c
kernel: [ 2176.124710] "echo 0 >
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
kernel: [ 2176.124742] task:btrfs           state:D stack:0
pid:7783  ppid:7782   flags:0x00004002
kernel: [ 2176.124753] Call Trace:
kernel: [ 2176.124758]  <TASK>
kernel: [ 2176.124765]  __schedule+0x2aa/0x610
kernel: [ 2176.124780]  schedule+0x63/0x110
kernel: [ 2176.124788]  btrfs_commit_transaction+0x9b7/0xbc0 [btrfs]
kernel: [ 2176.124929]  ? __pfx_autoremove_wake_function+0x10/0x10
kernel: [ 2176.124941]  btrfs_sync_fs+0x5a/0x1b0 [btrfs]
kernel: [ 2176.125060]  btrfs_ioctl+0x643/0x14d0 [btrfs]
kernel: [ 2176.125225]  __x64_sys_ioctl+0xa0/0xe0
kernel: [ 2176.125235]  do_syscall_64+0x5b/0x90
kernel: [ 2176.125242]  ? do_sys_openat2+0xab/0x180
kernel: [ 2176.125251]  ? exit_to_user_mode_prepare+0x30/0xb0
kernel: [ 2176.125260]  ? syscall_exit_to_user_mode+0x29/0x50
kernel: [ 2176.125268]  ? do_syscall_64+0x67/0x90
kernel: [ 2176.125275]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
kernel: [ 2176.125282] RIP: 0033:0x7f2e8eb119ef
kernel: [ 2176.125288] RSP: 002b:00007ffd632b6aa0 EFLAGS: 00000246
ORIG_RAX: 0000000000000010
kernel: [ 2176.125295] RAX: ffffffffffffffda RBX: 0000000000000003
RCX: 00007f2e8eb119ef
kernel: [ 2176.125300] RDX: 0000000000000000 RSI: 0000000000009408
RDI: 0000000000000003
kernel: [ 2176.125303] RBP: 0000000000000007 R08: 0000000000000000
R09: 0000000000000000
kernel: [ 2176.125306] R10: 0000000000000000 R11: 0000000000000246
R12: 00007f2e8ebf642c
kernel: [ 2176.125310] R13: 0000000000000001 R14: 000055cdb7940578
R15: 0000000000000000
kernel: [ 2176.125318]  </TASK>
kernel: [ 2296.956781] INFO: task btrfs:7783 blocked for more than 241 seconds.
kernel: [ 2296.956824]       Tainted: G        W  O
6.2.0-23-generic #23+btrdebug2c
kernel: [ 2296.956856] "echo 0 >
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
kernel: [ 2296.956887] task:btrfs           state:D stack:0
pid:7783  ppid:7782   flags:0x00004002
kernel: [ 2296.956898] Call Trace:
kernel: [ 2296.956902]  <TASK>
kernel: [ 2296.956908]  __schedule+0x2aa/0x610
kernel: [ 2296.956921]  schedule+0x63/0x110
kernel: [ 2296.956928]  btrfs_commit_transaction+0x9b7/0xbc0 [btrfs]
kernel: [ 2296.957069]  ? __pfx_autoremove_wake_function+0x10/0x10
kernel: [ 2296.957080]  btrfs_sync_fs+0x5a/0x1b0 [btrfs]
kernel: [ 2296.957200]  btrfs_ioctl+0x643/0x14d0 [btrfs]
kernel: [ 2296.957366]  __x64_sys_ioctl+0xa0/0xe0
kernel: [ 2296.957375]  do_syscall_64+0x5b/0x90
kernel: [ 2296.957383]  ? do_sys_openat2+0xab/0x180
kernel: [ 2296.957391]  ? exit_to_user_mode_prepare+0x30/0xb0
kernel: [ 2296.957399]  ? syscall_exit_to_user_mode+0x29/0x50
kernel: [ 2296.957407]  ? do_syscall_64+0x67/0x90
kernel: [ 2296.957414]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
kernel: [ 2296.957420] RIP: 0033:0x7f2e8eb119ef
kernel: [ 2296.957426] RSP: 002b:00007ffd632b6aa0 EFLAGS: 00000246
ORIG_RAX: 0000000000000010
kernel: [ 2296.957433] RAX: ffffffffffffffda RBX: 0000000000000003
RCX: 00007f2e8eb119ef
kernel: [ 2296.957438] RDX: 0000000000000000 RSI: 0000000000009408
RDI: 0000000000000003
kernel: [ 2296.957441] RBP: 0000000000000007 R08: 0000000000000000
R09: 0000000000000000
kernel: [ 2296.957444] R10: 0000000000000000 R11: 0000000000000246
R12: 00007f2e8ebf642c
kernel: [ 2296.957448] R13: 0000000000000001 R14: 000055cdb7940578
R15: 0000000000000000
kernel: [ 2296.957468]  </TASK>
kernel: [ 2314.043258] ------------[ cut here ]------------
kernel: [ 2314.043264] BTRFS: Transaction aborted (error -28)
kernel: [ 2314.043334] WARNING: CPU: 2 PID: 7739 at
fs/btrfs/extent-tree.c:2847 do_free_extent_accounting+0x21a/0x220
[btrfs]
kernel: [ 2314.043467] Modules linked in: ipmi_devintf ipmi_msghandler
overlay iwlwifi_compat(O) binfmt_misc nls_iso8859_1 intel_rapl_msr
snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio
intel_rapl_common snd_hda_codec_hdmi edac_mce_amd snd_hda_intel
snd_intel_dspcfg kvm_amd snd_intel_sdw_acpi snd_hda_codec kvm
snd_hda_core snd_hwdep snd_pcm snd_timer irqbypass rapl wmi_bmof snd
k10temp ccp soundcore input_leds mac_hid dm_multipath scsi_dh_rdac
scsi_dh_emc scsi_dh_alua bonding tls msr nfsd efi_pstore auth_rpcgss
nfs_acl lockd grace sunrpc dmi_sysfs ip_tables x_tables autofs4 btrfs
blake2b_generic raid10 raid456 async_raid6_recov async_memcpy async_pq
async_xor async_tx xor raid6_pq libcrc32c raid1 raid0 multipath linear
amdgpu iommu_v2 drm_buddy gpu_sched drm_ttm_helper hid_generic ttm
drm_display_helper cec uas rc_core usbhid hid drm_kms_helper
crct10dif_pclmul syscopyarea usb_storage crc32_pclmul polyval_clmulni
sysfillrect polyval_generic sysimgblt nvme ghash_clmulni_intel
sha512_ssse3
kernel: [ 2314.043599]  nvme_core aesni_intel crypto_simd mpt3sas drm
cryptd raid_class ahci i2c_piix4 scsi_transport_sas nvme_common igb
xhci_pci qlcnic dca xhci_pci_renesas libahci i2c_algo_bit video wmi
kernel: [ 2314.043631] CPU: 2 PID: 7739 Comm: btrfs-transacti Tainted:
G        W  O       6.2.0-23-generic #23+btrdebug2c
kernel: [ 2314.043638] Hardware name: To Be Filled By O.E.M. X570M
Pro4/X570M Pro4, BIOS P3.70 02/23/2022
kernel: [ 2314.043641] RIP: 0010:do_free_extent_accounting+0x21a/0x220 [btrfs]
kernel: [ 2314.043766] Code: ce 0f 0b eb b8 44 89 e6 48 c7 c7 a8 39 a0
c1 e8 2c d5 1e ce 0f 0b e9 78 ff ff ff 44 89 e6 48 c7 c7 a8 39 a0 c1
e8 16 d5 1e ce <0f> 0b eb b9 66 90 90 90 90 90 90 90 90 90 90 90 90 90
90 90 90 90
kernel: [ 2314.043771] RSP: 0018:ffffad0b11b7bb38 EFLAGS: 00010246
kernel: [ 2314.043777] RAX: 0000000000000000 RBX: ffff9c80e40e8f08
RCX: 0000000000000000
kernel: [ 2314.043781] RDX: 0000000000000000 RSI: 0000000000000000
RDI: 0000000000000000
kernel: [ 2314.043784] RBP: ffffad0b11b7bb60 R08: 0000000000000000
R09: 0000000000000000
kernel: [ 2314.043787] R10: 0000000000000000 R11: 0000000000000000
R12: 00000000ffffffe4
kernel: [ 2314.043790] R13: 00005e4c359ba000 R14: 0000000000020000
R15: ffff9c824d9a58c0
kernel: [ 2314.043794] FS:  0000000000000000(0000)
GS:ffff9c87a0a80000(0000) knlGS:0000000000000000
kernel: [ 2314.043798] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
kernel: [ 2314.043802] CR2: 00007f54adc86000 CR3: 00000001471d8000
CR4: 00000000003506e0
kernel: [ 2314.043806] Call Trace:
kernel: [ 2314.043809]  <TASK>
kernel: [ 2314.043815]  __btrfs_free_extent+0x6bc/0xf50 [btrfs]
kernel: [ 2314.043943]  run_delayed_data_ref+0x8b/0x180 [btrfs]
kernel: [ 2314.044068]  btrfs_run_delayed_refs_for_head+0x196/0x520 [btrfs]
kernel: [ 2314.044192]  __btrfs_run_delayed_refs+0xe6/0x1d0 [btrfs]
kernel: [ 2314.044316]  btrfs_run_delayed_refs+0x6d/0x1f0 [btrfs]
kernel: [ 2314.044439]  btrfs_start_dirty_block_groups+0x36b/0x530 [btrfs]
kernel: [ 2314.044598]  btrfs_commit_transaction+0xb3/0xbc0 [btrfs]
kernel: [ 2314.044754]  ? start_transaction+0xc8/0x600 [btrfs]
kernel: [ 2314.044890]  transaction_kthread+0x14b/0x1c0 [btrfs]
kernel: [ 2314.045021]  ? __pfx_transaction_kthread+0x10/0x10 [btrfs]
kernel: [ 2314.045151]  kthread+0xe9/0x110
kernel: [ 2314.045162]  ? __pfx_kthread+0x10/0x10
kernel: [ 2314.045170]  ret_from_fork+0x2c/0x50
kernel: [ 2314.045180]  </TASK>
kernel: [ 2314.045182] ---[ end trace 0000000000000000 ]---
kernel: [ 2314.045186] BTRFS info (device sdc: state A): dumping space info:
kernel: [ 2314.045191] BTRFS info (device sdc: state A): space_info
DATA has 160777674752 free, is not full
kernel: [ 2314.045197] BTRFS info (device sdc: state A): space_info
total=71201958395904, used=71013439856640, pinned=27737325568,
reserved=0, may_use=0, readonly=3538944 zone_unusable=0
kernel: [ 2314.045205] BTRFS info (device sdc: state A): space_info
METADATA has -429047808 free, is full
kernel: [ 2314.045209] BTRFS info (device sdc: state A): space_info
total=83634421760, used=82789777408, pinned=244891648,
reserved=599687168, may_use=429047808, readonly=65536 zone_unusable=0
kernel: [ 2314.045217] BTRFS info (device sdc: state A): space_info
SYSTEM has 33390592 free, is not full
kernel: [ 2314.045221] BTRFS info (device sdc: state A): space_info
total=38797312, used=5373952, pinned=16384, reserved=16384, may_use=0,
readonly=0 zone_unusable=0
kernel: [ 2314.045227] BTRFS info (device sdc: state A):
global_block_rsv: size 536870912 reserved 428523520
kernel: [ 2314.045231] BTRFS info (device sdc: state A):
trans_block_rsv: size 524288 reserved 524288
kernel: [ 2314.045235] BTRFS info (device sdc: state A):
chunk_block_rsv: size 0 reserved 0
kernel: [ 2314.045239] BTRFS info (device sdc: state A):
delayed_block_rsv: size 0 reserved 0
kernel: [ 2314.045242] BTRFS info (device sdc: state A):
delayed_refs_rsv: size 249756909568 reserved 0
kernel: [ 2314.045251] BTRFS: error (device sdc: state A) in
do_free_extent_accounting:2847: errno=-28 No space left
kernel: [ 2314.045265] BTRFS warning (device sdc: state A):
btrfs_uuid_scan_kthread failed -28
kernel: [ 2314.045295] BTRFS info (device sdc: state EA): forced readonly
kernel: [ 2314.045300] BTRFS error (device sdc: state EA): failed to
run delayed ref for logical 103681409916928 num_bytes 131072 type 184
action 2 ref_mod 1: -28
kernel: [ 2314.045360] BTRFS: error (device sdc: state EA) in
btrfs_run_delayed_refs:2151: errno=-28 No space left
kernel: [ 2314.049204] BTRFS: error (device sdc: state EA) in
btrfs_create_pending_block_groups:2487: errno=-28 No space left
kernel: [ 2314.049331] BTRFS: error (device sdc: state EA) in
btrfs_create_pending_block_groups:2499: errno=-28 No space left
kernel: [ 2314.053259] BTRFS: error (device sdc: state EA) in
do_free_extent_accounting:2847: errno=-28 No space left
kernel: [ 2314.053318] BTRFS error (device sdc: state EA): failed to
run delayed ref for logical 103681419366400 num_bytes 131072 type 184
action 2 ref_mod 1: -28
kernel: [ 2314.053375] BTRFS: error (device sdc: state EA) in
btrfs_run_delayed_refs:2151: errno=-28 No space left
kernel: [ 2314.053430] BTRFS warning (device sdc: state EA): Skipping
commit of aborted transaction.
kernel: [ 2314.053435] BTRFS: error (device sdc: state EA) in
cleanup_transaction:1986: errno=-28 No space left



On Fri, 23 Jun 2023 at 19:16, Qu Wenruo <wqu@suse.com> wrote:
>
>
>
> On 2023/6/23 17:00, Stefan N wrote:
> > Apologies, I thought I included the log output too, though I can't see
> > any additional output
> >
> >  From a fresh run, still using the same kernel
> > $ sudo mount -o skip_balance -t btrfs /dev/sde /mnt/data ; sudo btrfs
> > dev add -f /dev/sdl /dev/sdm /dev/sdn /dev/sdo /mnt/data ; sudo btrfs
> > fi sync /mnt/data
> > ERROR: error adding device '/dev/sdl': Input/output error
> > ERROR: error adding device '/dev/sdm': Read-only file system
> > ERROR: error adding device '/dev/sdn': Read-only file system
> > ERROR: error adding device '/dev/sdo': Read-only file system
> > ERROR: Could not sync filesystem: Read-only file system
> > $
> >
> > Output from kern.log, syslog or dmesg -k
> >
> [...]
>
> None of the newly added debug lines triggered, so there is something
> else causing the problem.
>
> And furthermore the backtrace is not that helpful, it only shows it's
> some async metadata reclaim kthread causing the problem.
>
> Although I guess the async metadata reclaim is triggered by the
> btrfs_start_transaction() call when adding a device.
> So I updated my github branch to go btrfs_join_transaction() which would
> not flush any metadata, thus avoid the problem.
>
> Would you please give it a try again?
>
> >
> > However, now I started digging into logs to check I hadn't missed
> > where the errors were being logged, I've found this from roughly a
> > week before I started having issues, which I had not previously
> > noticed
>
> You don't need to bother most error messages after the fs flipped RO.
> As it's known to have some false alerts.
>
> Thanks,
> Qu
>
> > [ 1990.495861] BTRFS error (device sdh): failed to run delayed ref for
> > logical 107988943355904 num_bytes 245760 type 184 action 2 ref_mod 1:
> > -28
> > [ 1990.518282] BTRFS error (device sdh): failed to run delayed ref for
> > logical 107989043494912 num_bytes 245760 type 184 action 2 ref_mod 1:
> > -28
> > [  620.104065] BTRFS error (device sdk): failed to run delayed ref for
> > logical 123187655077888 num_bytes 176128 type 184 action 2 ref_mod 1:
> > -28
> > [  620.126209] BTRFS error (device sdk): failed to run delayed ref for
> > logical 123190279929856 num_bytes 134217728 type 184 action 2 ref_mod
> > 1: -28
> > [  620.126241] BTRFS error (device sdk): failed to run delayed ref for
> > logical 123189970468864 num_bytes 134217728 type 184 action 2 ref_mod
> > 1: -28
> > [  620.126271] BTRFS error (device sdk): failed to run delayed ref for
> > logical 123190414409728 num_bytes 134217728 type 184 action 2 ref_mod
> > 1: -28
> > [  476.565308] BTRFS error (device sdh): failed to run delayed ref for
> > logical 101906434228224 num_bytes 651264 type 184 action 2 ref_mod 1:
> > -28
> > [  476.565932] BTRFS error (device sdh): failed to run delayed ref for
> > logical 101906434031616 num_bytes 180224 type 184 action 2 ref_mod 1:
> > -28
> > [  447.371754] BTRFS error (device sdh): failed to run delayed ref for
> > logical 101946151927808 num_bytes 262144 type 184 action 2 ref_mod 1:
> > -28
> > [  447.372362] BTRFS error (device sdh): failed to run delayed ref for
> > logical 101946083725312 num_bytes 245760 type 184 action 2 ref_mod 1:
> > -28
> > [  439.839007] BTRFS error (device sdj): failed to run delayed ref for
> > logical 101923102179328 num_bytes 192512 type 184 action 2 ref_mod 1:
> > -28
> > [  439.839578] BTRFS error (device sdj): failed to run delayed ref for
> > logical 101923401629696 num_bytes 245760 type 184 action 2 ref_mod 1:
> > -28
> > [  466.393884] BTRFS error (device sdh): failed to run delayed ref for
> > logical 101981116137472 num_bytes 245760 type 184 action 2 ref_mod 1:
> > -28
> > [  466.394451] BTRFS error (device sdh): failed to run delayed ref for
> > logical 101981122854912 num_bytes 1720320 type 184 action 2 ref_mod 1:
> > -28
> > [  431.541367] BTRFS error (device sdh): failed to run delayed ref for
> > logical 101876426952704 num_bytes 126976 type 184 action 2 ref_mod 1:
> > -28
> > [  431.542010] BTRFS error (device sdh): failed to run delayed ref for
> > logical 101876427780096 num_bytes 126976 type 184 action 2 ref_mod 1:
> > -28
> > [  597.487948] BTRFS error (device sdj): failed to run delayed ref for
> > logical 108127459409920 num_bytes 196608 type 184 action 2 ref_mod 1:
> > -28
> > [  597.488539] BTRFS error (device sdj): failed to run delayed ref for
> > logical 108124677865472 num_bytes 126976 type 184 action 2 ref_mod 1:
> > -28
> > [  534.717509] BTRFS error (device sdh): failed to run delayed ref for
> > logical 101958618710016 num_bytes 1597440 type 184 action 2 ref_mod 1:
> > -28
> > [  534.718494] BTRFS error (device sdh): failed to run delayed ref for
> > logical 101958756335616 num_bytes 368640 type 184 action 2 ref_mod 1:
> > -28
> > [  508.089394] BTRFS error (device sdk): failed to run delayed ref for
> > logical 101911627694080 num_bytes 126976 type 184 action 2 ref_mod 1:
> > -28
> > [  508.090007] BTRFS error (device sdk): failed to run delayed ref for
> > logical 101911627415552 num_bytes 126976 type 184 action 2 ref_mod 1:
> > -28
> > [ 1632.112084] BTRFS error (device sdh): failed to run delayed ref for
> > logical 102203759886336 num_bytes 229376 type 184 action 2 ref_mod 1:
> > -28
> > [ 1632.112885] BTRFS error (device sdh): failed to run delayed ref for
> > logical 102203764379648 num_bytes 126976 type 184 action 2 ref_mod 1:
> > -28
> >
> > and today, when leaving the disks mounted read-only for a while, I
> > found many occurances similar to:
> > BTRFS error (device sdc: state EA): level verify failed on logical
> > 201329754554368 mirror 1 wanted 2 found 0
> > BTRFS error (device sdc: state EA): level verify failed on logical
> > 201329754554368 mirror 2 wanted 2 found 0
> > BTRFS error (device sdc: state EA): level verify failed on logical
> > 201329754554368 mirror 3 wanted 2 found 0
> > BTRFS error (device sdc: state EA): level verify failed on logical
> > 201329754554368 mirror 4 wanted 2 found 0
> > BTRFS error (device sdc: state EA): level verify failed on logical
> > 201329754554368 mirror 1 wanted 2 found 0
> > BTRFS error (device sdc: state EA): level verify failed on logical
> > 201329754554368 mirror 2 wanted 2 found 0
> > BTRFS error (device sdc: state EA): level verify failed on logical
> > 201329754554368 mirror 3 wanted 2 found 0
> > BTRFS error (device sdc: state EA): level verify failed on logical
> > 201350830227456 mirror 4 wanted 2 found 0
> > BTRFS error (device sdc: state EA): level verify failed on logical
> > 201350830227456 mirror 1 wanted 2 found 0
> > BTRFS error (device sdc: state EA): level verify failed on logical
> > 201350830227456 mirror 2 wanted 2 found 0
> >
> > On Fri, 23 Jun 2023 at 10:27, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> >>
> >>
> >>
> >> On 2023/6/23 06:18, Stefan N wrote:
> >>> Hi Qu,
> >>>
> >>> I got one new line this time, but it doesn't seem to match your commit
> >>> ERROR: zoned: unable to stat /dev/loop/13
> >>
> >> Please provide the dmesg of that attempt, as all the extra debug info is
> >> inside dmesg.
> >>
> >> With that info provided, we can determine what to do next.
> >>
> >> Thanks,
> >> Qu
> >>
> >>>
> >>> I tried it on the USB flash drives too and didn't get any extra line
> >>>
> >>> In context
> >>> $ sudo mount -o skip_balance -t btrfs /dev/sde /mnt/data ; sudo btrfs
> >>> dev add -K -f /dev/loop12 /dev/loop/13 /dev/loop14 /dev/loop15
> >>> /mnt/data ; sudo btrfs fi sync /mnt/data
> >>> ERROR: error adding device '/dev/loop12': Input/output error
> >>> ERROR: zoned: unable to stat /dev/loop/13
> >>> ERROR: checking status of /dev/loop/13: No such file or directory
> >>> ERROR: error adding device '/dev/loop14': Read-only file system
> >>> ERROR: error adding device '/dev/loop15': Read-only file system
> >>> ERROR: Could not sync filesystem: Read-only file system
> >>> $
> >>>
> >>> $ sudo mount -o skip_balance -t btrfs /dev/sde /mnt/data ; sudo btrfs
> >>> dev add -f /dev/sdl /dev/sdm /dev/sdn /dev/sdo /mnt/data ; sudo btrfs
> >>> fi sync /mnt/data
> >>> ERROR: error adding device '/dev/sdl': Input/output error
> >>> ERROR: error adding device '/dev/sdm': Read-only file system
> >>> ERROR: error adding device '/dev/sdn': Read-only file system
> >>> ERROR: error adding device '/dev/sdo': Read-only file system
> >>> ERROR: Could not sync filesystem: Read-only file system
> >>> $
> >>>
> >>> On Thu, 22 Jun 2023 at 18:48, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 2023/6/22 16:33, Stefan N wrote:
> >>>>> Hi Qu,
> >>>>>
> >>>>> Many thanks for the detailed instructions and your patience. I got it
> >>>>> working combined with
> >>>>> https://wiki.ubuntu.com/Kernel/BuildYourOwnKernel on the main system
> >>>>> OS instead, tagged +btrfix
> >>>>> $ uname -vr
> >>>>> 6.2.0-23-generic #23+btrfix SMP PREEMPT_DYNAMIC Thu Jun 22
> >>>>>
> >>>>> However, I've not had luck with the commands suggested, and would
> >>>>> appreciate any further ideas.
> >>>>>
> >>>>> Outputs follow below, with /mnt/data as the btrfs mount point that
> >>>>> currently contains 8x disks sd[a-j] with an additional 4x 64gb USB
> >>>>> flash drives being added sd[l-o]
> >>>>> $ sudo mount -o skip_balance -t btrfs /dev/sde /mnt/data ; sudo btrfs
> >>>>> dev add -f /dev/sdl /dev/sdm /dev/sdn /dev/sdo /mnt/data ; sudo btrfs
> >>>>> fi sync /mnt/data
> >>>>> ERROR: error adding device '/dev/sdl': Input/output error
> >>>>> ERROR: error adding device '/dev/sdm': Read-only file system
> >>>>> ERROR: error adding device '/dev/sdn': Read-only file system
> >>>>> ERROR: error adding device '/dev/sdo': Read-only file system
> >>>>> ERROR: Could not sync filesystem: Read-only file system
> >>>>> $
> >>>>>
> >>>>> The same occurs if I try to add 4x 100mb loop devices (on a ssd so
> >>>>> they're super quick to zero);
> >>>>> $ sudo mount -o skip_balance -t btrfs /dev/sde /mnt/data ; sudo btrfs
> >>>>> dev add -K -f /dev/loop16 /dev/loop17 /dev/loop18 /dev/loop19
> >>>>> /mnt/data ; sudo btrfs fi sync /mnt/data
> >>>>> ERROR: error adding device '/dev/loop16': Input/output error
> >>>>
> >>>> This is the interesting part, this means we're erroring out due to -EIO
> >>>> (not -ENOSPC) during the first device add.
> >>>>
> >>>> And by somehow, after the first device add, we already got the trans abort.
> >>>>
> >>>> Would you please try the following branch?
> >>>>
> >>>> https://github.com/adam900710/linux/tree/dev_add_no_commit
> >>>>
> >>>> It has not only the patch to skip the commit, but also extra debug
> >>>> output for the situation.
> >>>>
> >>>> Thanks,
> >>>> Qu
> >>>>
> >>>>> ERROR: error adding device '/dev/loop17': Read-only file system
> >>>>> ERROR: error adding device '/dev/loop18': Read-only file system
> >>>>> ERROR: error adding device '/dev/loop19': Read-only file system
> >>>>> ERROR: Could not sync filesystem: Read-only file system
> >>>>> $
> >>>>>
> >>>>> I confirmed before both these kernel builds that the replaced line was
> >>>>> btrfs_end_transaction rather than btrfs_commit_transaction (anyone
> >>>>> else following, I needed to remove the -n in the patch command
> >>>>> earlier)
> >>>>> $ grep -A3 -ri btrfs_sysfs_update_sprout */fs/btrfs/volumes.c*
> >>>>> linux-6.2.0-dist/fs/btrfs/volumes.c:
> >>>>> btrfs_sysfs_update_sprout_fsid(fs_devices);
> >>>>> linux-6.2.0-dist/fs/btrfs/volumes.c-    }
> >>>>> linux-6.2.0-dist/fs/btrfs/volumes.c-
> >>>>> linux-6.2.0-dist/fs/btrfs/volumes.c-    ret = btrfs_commit_transaction(trans);
> >>>>> --
> >>>>> linux-6.2.0-v2/fs/btrfs/volumes.c:
> >>>>> btrfs_sysfs_update_sprout_fsid(fs_devices);
> >>>>> linux-6.2.0-v2/fs/btrfs/volumes.c-      }
> >>>>> linux-6.2.0-v2/fs/btrfs/volumes.c-
> >>>>> linux-6.2.0-v2/fs/btrfs/volumes.c-      ret = btrfs_end_transaction(trans);
> >>>>> --
> >>>>> linux-6.2.0-v3/fs/btrfs/volumes.c:
> >>>>> btrfs_sysfs_update_sprout_fsid(fs_devices);
> >>>>> linux-6.2.0-v3/fs/btrfs/volumes.c-      }
> >>>>> linux-6.2.0-v3/fs/btrfs/volumes.c-
> >>>>> linux-6.2.0-v3/fs/btrfs/volumes.c-      ret = btrfs_end_transaction(trans);
> >>>>> $
> >>>>>
> >>>>> $ btrfs fi usage /mnt/data
> >>>>> Overall:
> >>>>>        Device size:                  87.31TiB
> >>>>>        Device allocated:             87.31TiB
> >>>>>        Device unallocated:            1.94GiB
> >>>>>        Device missing:                  0.00B
> >>>>>        Device slack:                    0.00B
> >>>>>        Used:                         87.08TiB
> >>>>>        Free (estimated):            173.29GiB      (min: 172.33GiB)
> >>>>>        Free (statfs, df):           171.84GiB
> >>>>>        Data ratio:                       1.34
> >>>>>        Metadata ratio:                   4.00
> >>>>>        Global reserve:              512.00MiB      (used: 371.25MiB)
> >>>>>        Multiple profiles:                  no
> >>>>>
> >>>>> Data,RAID6: Size:64.76TiB, Used:64.59TiB (99.74%)
> >>>>>       /dev/sdc       10.90TiB
> >>>>>       /dev/sdf       10.90TiB
> >>>>>       /dev/sda       10.86TiB
> >>>>>       /dev/sdg       10.87TiB
> >>>>>       /dev/sdh       10.86TiB
> >>>>>       /dev/sdd       10.87TiB
> >>>>>       /dev/sde       10.88TiB
> >>>>>       /dev/sdb       10.88TiB
> >>>>>
> >>>>> Metadata,RAID1C4: Size:77.79GiB, Used:77.11GiB (99.12%)
> >>>>>       /dev/sdc       15.33GiB
> >>>>>       /dev/sdf       18.41GiB
> >>>>>       /dev/sda       49.63GiB
> >>>>>       /dev/sdg       49.50GiB
> >>>>>       /dev/sdh       51.52GiB
> >>>>>       /dev/sdd       48.70GiB
> >>>>>       /dev/sde       39.09GiB
> >>>>>       /dev/sdb       39.01GiB
> >>>>>
> >>>>> System,RAID1C4: Size:37.00MiB, Used:5.11MiB (13.81%)
> >>>>>       /dev/sdc        1.00MiB
> >>>>>       /dev/sda       37.00MiB
> >>>>>       /dev/sdg       37.00MiB
> >>>>>       /dev/sdh       36.00MiB
> >>>>>       /dev/sdd       37.00MiB
> >>>>>
> >>>>> Unallocated:
> >>>>>       /dev/sdc        1.00MiB
> >>>>>       /dev/sdf        1.00MiB
> >>>>>       /dev/sda        1.27GiB
> >>>>>       /dev/sdg        1.00MiB
> >>>>>       /dev/sdh        1.00MiB
> >>>>>       /dev/sdd      687.00MiB
> >>>>>       /dev/sde        1.00MiB
> >>>>>       /dev/sdb        1.00MiB
> >>>>> $
> >>>>>
> >>>>>
> >>>>> This first attempt generated the following syslog output:
> >>>>> kernel: [  868.435387] BTRFS info (device sde): using crc32c
> >>>>> (crc32c-intel) checksum algorithm
> >>>>> kernel: [  868.435407] BTRFS info (device sde): disk space caching is enabled
> >>>>> kernel: [  874.477712] BTRFS info (device sde): bdev /dev/sdg errs: wr
> >>>>> 0, rd 0, flush 0, corrupt 845, gen 0
> >>>>> kernel: [  874.477727] BTRFS info (device sde): bdev /dev/sdc errs: wr
> >>>>> 41089, rd 1556, flush 0, corrupt 0, gen 0
> >>>>> kernel: [  874.477735] BTRFS info (device sde): bdev /dev/sdj errs: wr
> >>>>> 3, rd 7, flush 0, corrupt 0, gen 0
> >>>>> kernel: [  874.477740] BTRFS info (device sde): bdev /dev/sdf errs: wr
> >>>>> 41, rd 0, flush 0, corrupt 0, gen 0
> >>>>> kernel: [ 1082.645551] BTRFS info (device sde): balance: resume skipped
> >>>>> kernel: [ 1082.645564] BTRFS info (device sde): checking UUID tree
> >>>>> kernel: [ 1082.645551] BTRFS info (device sde): balance: resume skipped
> >>>>> kernel: [ 1082.645564] BTRFS info (device sde): checking UUID tree
> >>>>> kernel: [ 1267.280506] BTRFS: Transaction aborted (error -28)
> >>>>> kernel: [ 1267.280553] BTRFS: error (device sde: state A) in
> >>>>> do_free_extent_accounting:2847: errno=-28 No space left
> >>>>> kernel: [ 1267.280604] BTRFS info (device sde: state EA): forced readonly
> >>>>> kernel: [ 1267.280610] BTRFS error (device sde: state EA): failed to
> >>>>> run delayed ref for logical 102255404044288 num_bytes 294912 type 184
> >>>>> action 2 ref_mod 1: -28
> >>>>> kernel: [ 1267.280584] WARNING: CPU: 3 PID: 14519 at
> >>>>> fs/btrfs/extent-tree.c:2847 do_free_extent_accounting+0x21a/0x220
> >>>>> [btrfs]
> >>>>> kernel: [ 1267.280666] BTRFS: error (device sde: state EA) in
> >>>>> btrfs_run_delayed_refs:2151: errno=-28 No space left
> >>>>> kernel: [ 1267.280695] BTRFS warning (device sde: state EA):
> >>>>> btrfs_uuid_scan_kthread failed -5
> >>>>> kernel: [ 1267.280794] Modules linked in: xt_nat xt_tcpudp veth
> >>>>> xt_conntrack nft_chain_nat xt_MASQUERADE nf_nat nf_conntrack_netlink
> >>>>> nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 xfrm_user xfrm_algo
> >>>>> xt_addrtype nft_compat nf_tables nfnetlink br_netfilter bridge stp llc
> >>>>> ipmi_devintf ipmi_msghandler overlay iwlwifi_compat(O) binfmt_misc
> >>>>> nls_iso8859_1 intel_rapl_msr intel_rapl_common edac_mce_amd
> >>>>> snd_hda_codec_realtek kvm_amd snd_hda_codec_generic ledtrig_audio kvm
> >>>>> snd_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi
> >>>>> snd_hda_codec irqbypass snd_hda_core snd_hwdep rapl snd_pcm snd_timer
> >>>>> wmi_bmof k10temp snd ccp soundcore input_leds mac_hid dm_multipath
> >>>>> scsi_dh_rdac scsi_dh_emc scsi_dh_alua bonding tls efi_pstore msr nfsd
> >>>>> auth_rpcgss nfs_acl lockd grace sunrpc dmi_sysfs ip_tables x_tables
> >>>>> autofs4 btrfs blake2b_generic raid10 raid456 async_raid6_recov
> >>>>> async_memcpy async_pq async_xor async_txxor raid6_pq libcrc32c raid1
> >>>>> raid0 multipath linear hid_generic usbhid hid amdgpu uas usb_storage
> >>>>> kernel: [ 1267.280994] CPU: 3 PID: 14519 Comm: btrfs-transacti
> >>>>> Tainted: G        W  O       6.2.0-23-generic #23+btrfix
> >>>>> kernel: [ 1267.281005] RIP: 0010:do_free_extent_accounting+0x21a/0x220 [btrfs]
> >>>>> kernel: [ 1267.281181]  __btrfs_free_extent+0x6bc/0xf50 [btrfs]
> >>>>> kernel: [ 1267.281310]  run_delayed_data_ref+0x8b/0x180 [btrfs]
> >>>>> kernel: [ 1267.281444]  btrfs_run_delayed_refs_for_head+0x196/0x520 [btrfs]
> >>>>> kernel: [ 1267.281570]  __btrfs_run_delayed_refs+0xe6/0x1d0 [btrfs]
> >>>>> kernel: [ 1267.281694]  btrfs_run_delayed_refs+0x6d/0x1f0 [btrfs]
> >>>>> kernel: [ 1267.281818]  btrfs_start_dirty_block_groups+0x36b/0x530 [btrfs]
> >>>>> kernel: [ 1267.281976]  btrfs_commit_transaction+0xb3/0xbc0 [btrfs]
> >>>>> kernel: [ 1267.282110]  ? start_transaction+0xc8/0x600 [btrfs]
> >>>>> kernel: [ 1267.282244]  transaction_kthread+0x14b/0x1c0 [btrfs]
> >>>>> kernel: [ 1267.282375]  ? __pfx_transaction_kthread+0x10/0x10 [btrfs]
> >>>>> kernel: [ 1267.282548] BTRFS info (device sde: state EA): dumping space info:
> >>>>> kernel: [ 1267.282552] BTRFS info (device sde: state EA): space_info
> >>>>> DATA has 160777674752 free, is not full
> >>>>> kernel: [ 1267.282558] BTRFS info (device sde: state EA): space_info
> >>>>> total=71201958395904, used=71018191273984, pinned=22985908224,
> >>>>> reserved=0, may_use=0, readonly=3538944 zone_unusable=0
> >>>>> kernel: [ 1267.282566] BTRFS info (device sde: state EA): space_info
> >>>>> METADATA has -124944384 free, is full
> >>>>> kernel: [ 1267.282571] BTRFS info (device sde: state EA): space_info
> >>>>> total=83530612736, used=82791497728, pinned=242745344,
> >>>>> reserved=496369664, may_use=124944384, readonly=0 zone_unusable=0
> >>>>> kernel: [ 1267.282577] BTRFS info (device sde: state EA): space_info
> >>>>> SYSTEM has 33439744 free, is not full
> >>>>> kernel: [ 1267.282582] BTRFS info (device sde: state EA): space_info
> >>>>> total=38797312, used=5357568, pinned=0, reserved=0, may_use=0,
> >>>>> readonly=0 zone_unusable=0
> >>>>> kernel: [ 1267.282588] BTRFS info (device sde: state EA):
> >>>>> global_block_rsv: size 536870912 reserved 124944384
> >>>>> kernel: [ 1267.282592] BTRFS info (device sde: state EA):
> >>>>> trans_block_rsv: size 0 reserved 0
> >>>>> kernel: [ 1267.282595] BTRFS info (device sde: state EA):
> >>>>> chunk_block_rsv: size 0 reserved 0
> >>>>> kernel: [ 1267.282599] BTRFS info (device sde: state EA):
> >>>>> delayed_block_rsv: size 0 reserved 0
> >>>>> kernel: [ 1267.282602] BTRFS info (device sde: state EA):
> >>>>> delayed_refs_rsv: size 251322957824 reserved 0
> >>>>> kernel: [ 1267.282608] BTRFS: error (device sde: state EA) in
> >>>>> do_free_extent_accounting:2847: errno=-28 No space left
> >>>>> kernel: [ 1267.282653] BTRFS error (device sde: state EA): failed to
> >>>>> run delayed ref for logical 102255401897984 num_bytes 126976 type 184
> >>>>> action 2 ref_mod 1: -28
> >>>>> kernel: [ 1267.282708] BTRFS: error (device sde: state EA) in
> >>>>> btrfs_run_delayed_refs:2151: errno=-28 No space left
> >>>>>
> >>>>> A couple of kernel recompiles later, the second attempt on the SSD
> >>>>> generated similar:
> >>>>> kernel: [ 1472.203470] BTRFS info (device sdc): using crc32c
> >>>>> (crc32c-intel) checksum algorithm
> >>>>> kernel: [ 1472.203491] BTRFS info (device sdc): disk space caching is enabled
> >>>>> kernel: [ 1478.155004] BTRFS info (device sdc): bdev /dev/sdf errs: wr
> >>>>> 0, rd 0, flush 0, corrupt 845, gen 0
> >>>>> kernel: [ 1478.155022] BTRFS info (device sdc): bdev /dev/sda errs: wr
> >>>>> 41089, rd 1556, flush 0, corrupt 0, gen 0
> >>>>> kernel: [ 1478.155034] BTRFS info (device sdc): bdev /dev/sdh errs: wr
> >>>>> 3, rd 7, flush 0, corrupt 0, gen 0
> >>>>> kernel: [ 1478.155041] BTRFS info (device sdc): bdev /dev/sdd errs: wr
> >>>>> 41, rd 0, flush 0, corrupt 0, gen 0
> >>>>> kernel: [ 1696.662526] BTRFS info (device sdc): balance: resume skipped
> >>>>> kernel: [ 1696.662537] BTRFS info (device sdc): checking UUID tree
> >>>>> kernel: [ 1919.452464] BTRFS: Transaction aborted (error -28)
> >>>>> kernel: [ 1919.452534] WARNING: CPU: 1 PID: 161 at
> >>>>> fs/btrfs/extent-tree.c:2847 do_free_extent_accounting+0x21a/0x220
> >>>>> [btrfs]
> >>>>> kernel: [ 1919.452655] Modules linked in: xt_nat xt_tcpudp veth
> >>>>> xt_conntrack nft_chain_nat xt_MASQUERADE nf_nat nf_conntrack_netlink
> >>>>> nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 xfrm_user xfrm_algo
> >>>>> xt_addrtype nft_compat nf_tables nfnetlink br_netfilter bridge stp llc
> >>>>> ipmi_devintf ipmi_msghandler overlay iwlwifi_compat(O) binfmt_misc
> >>>>> nls_iso8859_1 snd_hda_codec_realtek snd_hda_codec_generic
> >>>>> ledtrig_audio snd_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg
> >>>>> snd_intel_sdw_acpi snd_hda_codec intel_rapl_msr snd_hda_core
> >>>>> intel_rapl_common edac_mce_amd snd_hwdep kvm_amd snd_pcm snd_timer kvm
> >>>>> irqbypass rapl wmi_bmof snd k10temp soundcore ccp input_leds mac_hid
> >>>>> dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua bonding tls nfsd
> >>>>> msr auth_rpcgss efi_pstore nfs_acl lockd grace sunrpc dmi_sysfs
> >>>>> ip_tables x_tables autofs4 btrfs blake2b_generic raid10 raid456
> >>>>> async_raid6_recov async_memcpy async_pq async_xor async_tx xor
> >>>>> raid6_pq libcrc32c raid1 raid0 multipath linear hid_generic usbhid
> >>>>> amdgpu uas hid iommu_v2
> >>>>> kernel: [ 1919.452839] Workqueue: events_unbound
> >>>>> btrfs_async_reclaim_metadata_space [btrfs]
> >>>>> kernel: [ 1919.452985] RIP: 0010:do_free_extent_accounting+0x21a/0x220 [btrfs]
> >>>>> kernel: [ 1919.453141]  __btrfs_free_extent+0x6bc/0xf50 [btrfs]
> >>>>> kernel: [ 1919.453256]  run_delayed_data_ref+0x8b/0x180 [btrfs]
> >>>>> kernel: [ 1919.453368]  btrfs_run_delayed_refs_for_head+0x196/0x520 [btrfs]
> >>>>> kernel: [ 1919.453480]  __btrfs_run_delayed_refs+0xe6/0x1d0 [btrfs]
> >>>>> kernel: [ 1919.453592]  btrfs_run_delayed_refs+0x6d/0x1f0 [btrfs]
> >>>>> kernel: [ 1919.453703]  flush_space+0x23c/0x2c0 [btrfs]
> >>>>> kernel: [ 1919.453845]  btrfs_async_reclaim_metadata_space+0x19b/0x2b0 [btrfs]
> >>>>> kernel: [ 1919.454034] BTRFS info (device sdc: state A): dumping space info:
> >>>>> kernel: [ 1919.454038] BTRFS info (device sdc: state A): space_info
> >>>>> DATA has 160778723328 free, is not full
> >>>>> kernel: [ 1919.454043] BTRFS info (device sdc: state A): space_info
> >>>>> total=71201958395904, used=71017442181120, pinned=23733952512,
> >>>>> reserved=0, may_use=0, readonly=3538944 zone_unusable=0
> >>>>> kernel: [ 1919.454050] BTRFS info (device sdc: state A): space_info
> >>>>> METADATA has -147570688 free, is full
> >>>>> kernel: [ 1919.454054] BTRFS info (device sdc: state A): space_info
> >>>>> total=83530612736, used=82792185856, pinned=238059520,
> >>>>> reserved=500367360, may_use=147570688, readonly=0 zone_unusable=0
> >>>>> kernel: [ 1919.454060] BTRFS info (device sdc: state A): space_info
> >>>>> SYSTEM has 33439744 free, is not full
> >>>>> kernel: [ 1919.454064] BTRFS info (device sdc: state A): space_info
> >>>>> total=38797312, used=5357568, pinned=0, reserved=0, may_use=0,
> >>>>> readonly=0 zone_unusable=0
> >>>>> kernel: [ 1919.454070] BTRFS info (device sdc: state A):
> >>>>> global_block_rsv: size 536870912 reserved 147570688
> >>>>> kernel: [ 1919.454074] BTRFS info (device sdc: state A):
> >>>>> trans_block_rsv: size 0 reserved 0
> >>>>> kernel: [ 1919.454077] BTRFS info (device sdc: state A):
> >>>>> chunk_block_rsv: size 0 reserved 0
> >>>>> kernel: [ 1919.454080] BTRFS info (device sdc: state A):
> >>>>> delayed_block_rsv: size 0 reserved 0
> >>>>> kernel: [ 1919.454083] BTRFS info (device sdc: state A):
> >>>>> delayed_refs_rsv: size 254292787200 reserved 0
> >>>>> kernel: [ 1919.454086] BTRFS: error (device sdc: state A) in
> >>>>> do_free_extent_accounting:2847: errno=-28 No space left
> >>>>> kernel: [ 1919.454123] BTRFS info (device sdc: state EA): forced readonly
> >>>>> kernel: [ 1919.454127] BTRFS error (device sdc: state EA): failed to
> >>>>> run delayed ref for logical 102538713931776 num_bytes 245760 type 184
> >>>>> action 2 ref_mod 1: -28
> >>>>> kernel: [ 1919.454176] BTRFS: error (device sdc: state EA) in
> >>>>> btrfs_run_delayed_refs:2151: errno=-28 No space left
> >>>>> kernel: [ 1919.454249] BTRFS warning (device sdc: state EA):
> >>>>> btrfs_uuid_scan_kthread failed -5
> >>>>> kernel: [ 1919.472381] BTRFS: error (device sdc: state EA) in
> >>>>> __btrfs_free_extent:3077: errno=-28 No space left
> >>>>> kernel: [ 1919.472417] BTRFS error (device sdc: state EA): failed to
> >>>>> run delayed ref for logical 102538732191744 num_bytes 245760 type 184
> >>>>> action 2 ref_mod 1: -28
> >>>>> kernel: [ 1919.472442] BTRFS: error (device sdc: state EA) in
> >>>>> btrfs_run_delayed_refs:2151: errno=-28 No space left
> >>>>>
> >>>>>
> >>>>> On Sat, 17 Jun 2023 at 15:00, Qu Wenruo <wqu@suse.com> wrote:
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> On 2023/6/17 13:11, Stefan N wrote:
> >>>>>>> Hi Qu,
> >>>>>>>
> >>>>>>> I believe I've got this environment ready, with the 6.2.0 kernel as
> >>>>>>> before using the Ubuntu kernel, but can switch to vanilla if required.
> >>>>>>>
> >>>>>>> I've not done anything kernel modifications for a solid decade, so
> >>>>>>> would be keen for a bit of guidance.
> >>>>>>
> >>>>>> Sure no problem.
> >>>>>>
> >>>>>> Please fetch the kernel source tar ball (6.2.x) first, decompress, then
> >>>>>> apply the attached one-line patch by:
> >>>>>>
> >>>>>> $ tar czf linux*.tar.xz
> >>>>>> $ cd linux*
> >>>>>> $ patch -np1 -i <the patch file>
> >>>>>>
> >>>>>> Then use your running system kernel config if possible:
> >>>>>>
> >>>>>> $ cp /proc/config.gz .
> >>>>>> $ gunzip config.gz
> >>>>>> $ mv config .config
> >>>>>> $ make olddefconfig
> >>>>>>
> >>>>>> Then you can start your kernel compiling, and considering you're using
> >>>>>> your distro's default, it would include tons of drivers, thus would be
> >>>>>> very slow. (Replace the number to something more suitable to your
> >>>>>> system, using all CPU cores can be very hot)
> >>>>>>
> >>>>>> $ make -j12
> >>>>>>
> >>>>>> Finally you need to install the modules/kernel.
> >>>>>>
> >>>>>> Unfortunately this is distro specific, but if you're using Ubuntu, it
> >>>>>> may be much easier:
> >>>>>>
> >>>>>> $ make bindeb-pkg
> >>>>>>
> >>>>>> Then install the generated dpkg I guess? I have never tried kernel
> >>>>>> building using deb/rpm, but only manual installation, which is also
> >>>>>> distro dependent in the initramfs generation part.
> >>>>>>
> >>>>>> # cp arch/x86/boot/bzImage /boot/vmlinuz-custom
> >>>>>> # make modules_install
> >>>>>> # mkinitcpio -k /boot/vmlinuz-custom -g /boot/initramfs-custom.img
> >>>>>>
> >>>>>>
> >>>>>> The last step is to update your bootloader to add the new kernel, which
> >>>>>> is not only distro dependent but also bootloader dependent.
> >>>>>>
> >>>>>> In my case, I go with systemd-boot with manually crafted entries.
> >>>>>> But if you go Ubuntu I believe just installing the kernel dpkg would
> >>>>>> have everything handled?
> >>>>>>
> >>>>>> Finally you can try reboot into the newer kernel, and try device add
> >>>>>> (need to add 4 disks), then sync and see if things work as expected.
> >>>>>>
> >>>>>> Thanks,
> >>>>>> Qu
> >>>>>>>
> >>>>>>> I will recover a 1tb SSD and partition it into 4 in a USB enclosure,
> >>>>>>> but failing this will use 4x loop devices.
> >>>>>>>
> >>>>>>> On Tue, 13 Jun 2023 at 11:28, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> >>>>>>>> In your particular case, since you're running RAID1C4 you need to add 4
> >>>>>>>> devices in one transaction.
> >>>>>>>>
> >>>>>>>> I can easily craft a patch to avoid commit transaction, but still you'll
> >>>>>>>> need to add at least 4 disks, and then sync to see if things would work.
> >>>>>>>>
> >>>>>>>> Furthermore this means you need a liveCD with full kernel compiling
> >>>>>>>> environment.
> >>>>>>>>
> >>>>>>>> If you want to go this path, I can send you the patch when you've
> >>>>>>>> prepared the needed environment.
