Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6AF1A84A2
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Apr 2020 18:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391485AbgDNQZD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Apr 2020 12:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391431AbgDNQYz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Apr 2020 12:24:55 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D41C061A0C
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Apr 2020 09:24:54 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id k19so336228vsm.6
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Apr 2020 09:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=DlMTCt/gmw4jcJySUvOW1yvGPrcrHeWIoflWd3lHUFs=;
        b=JVYTXa8yLj6PXFsGSRZeVBS08QCeZGuzA27qVnSnfQzz+ES/xKyZA5z5Xn6QcmqgYS
         jZnki6Hk9CMFUEDn8kpuxoStc7WktbdZ9ZmqMdrJE1UGSmyBcMYSWEMIC0TJsbo5+kT6
         g9DS92tYQlKMq9NRpu0bbMUPUc0FgChMeIfIpdsRoW973cpLp7jUjmqxtr6s9CjYNmyw
         qaJF6YWFM9mfS7NsqfjVl0ObKhud7gCTKKxlnouAD35T5E0oZ5+GHOmRyLhUt32La66u
         C8R2pqjAoauMMOYurbYNKT7hcToPaKW5CWxjNAnxrXt12EBv90ESXUmZ+tn0Doio/4Z+
         oTsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=DlMTCt/gmw4jcJySUvOW1yvGPrcrHeWIoflWd3lHUFs=;
        b=NWJNrJnNSSGLbZTb07Of99kh9b+g9PsWDN/jeACbLhX0G7f2lncr2pn6h/28nCDcUu
         smcEdquUWdEn1QQJsY4mqCB7+WWGk7fX9qcUqn9X7wSRafxoSdsx0nUj/VWqU0gpNaHs
         pCKTYU0+EE3WSAnd6GsaFxH6Fd3bSUpmnWJCUgzmCa5y9MOozFZJ9clAoRZKOOmQ1hmP
         edg+SS8K4WbCeMbtkC5juLZ8k8izRIt+J0rDWLXkJB/jmylnRTBGv/w//1ciMNxcitNY
         xxygbbqpK7rOCyVlm7o0hLR8eeq8hY7rz/JmQZl+KRsBmXrMxRYeyddpSRpkdfV/MxaB
         /Isg==
X-Gm-Message-State: AGi0Pua4UIdvTE9a9tP4LjGX2qbD9NlCr5JzFD27J2IbGJtJk+jC/llQ
        BW/Mf1XxIv8J1gmxzZd15ryX2ycrN/lw90GVmmlR+tHl
X-Google-Smtp-Source: APiQypKPk+Nd29Ncb6eNrAX2eBGGVw7/kI2dk98thkmcGbPdGexxdxL8obXJm1EfXG8BzTFd4Fn6Ag+nPWCask7a3TM=
X-Received: by 2002:a67:f4ce:: with SMTP id s14mr783733vsn.99.1586881493877;
 Tue, 14 Apr 2020 09:24:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200410154248.2646406-1-josef@toxicpanda.com>
In-Reply-To: <20200410154248.2646406-1-josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Tue, 14 Apr 2020 17:24:42 +0100
Message-ID: <CAL3q7H4QH+c4JB1khcebHpJpZROuuPjOcKopqswfbdOuWqKbEQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix setting last_trans for reloc roots
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 10, 2020 at 4:44 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> I made a mistake with my previous fix, I assumed that we didn't need to
> mess with the reloc roots once we were out of the part of relocation
> where we are actually moving the extents.
>
> The subtle thing that I missed is that btrfs_init_reloc_root() also
> updates the last_trans for the reloc root when we do
> btrfs_record_root_in_trans() for the corresponding fs_root.  I've added
> a comment to make sure future me doesn't make this mistake again.
>
> This showed up as a WARN_ON() in btrfs_copy_root() because our
> last_trans didn't =3D=3D the current transid.  This could happen if we
> snapshotted a fs root with a reloc root after we set
> rc->create_reloc_tree =3D 0, but before we actually merge the reloc root.
>
> Fixes: 2abc726ab4b8 ("btrfs: do not init a reloc root if we aren't reloca=
ting")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Worth mentioning that the regression produced the following warning
when running snapshot creation and balance in parallel:

85256.545808] BTRFS info (device sdc): relocating block group 30408704
flags metadata|dup
[85256.551956] ------------[ cut here ]------------
[85256.552852] WARNING: CPU: 0 PID: 12823 at fs/btrfs/ctree.c:191
btrfs_copy_root+0x26f/0x430 [btrfs]
[85256.554407] Modules linked in: btrfs dm_log_writes dm_mod
blake2b_generic xor raid6_pq libcrc32c intel_rapl_msr
intel_rapl_common kvm_intel kvm irqbypass bochs_drm drm_vram_helper
crct10dif_pclmul drm_ttm_helper crc32_pclmul ghash_clmulni_intel ttm
drm_kms_helper aesni_intel crypto_simd cryptd glue_helper drm sg
joydev evdev serio_raw qemu_fw_cfg pcspkr button parport_pc ppdev lp
parport ip_tables x_tables autofs4 ext4 crc32c_generic crc16 mbcache
jbd2 sd_mod t10_pi virtio_scsi ata_generic ata_piix libata
crc32c_intel i2c_piix4 scsi_mod virtio_pci psmouse virtio_ring virtio
e1000 [last unloaded: btrfs]
[85256.563623] CPU: 0 PID: 12823 Comm: btrfs Tainted: G        W
  5.6.0-rc7-btrfs-next-58 #1
[85256.565139] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
[85256.567134] RIP: 0010:btrfs_copy_root+0x26f/0x430 [btrfs]
[85256.568068] Code: 5f c3 31 d2 4c 89 fe 48 89 ef e8 6c e9 04 00 44
8b 4c 24 08 e9 4d fe ff ff 48 8b 83 60 05 00 00 49 39 04 24 0f 84 e3
fd ff ff <0f> 0b e9 dc fd ff ff 49 8b 86 b0 04 00 00 48 8b 00 48 39 07
0f 84
[85256.571282] RSP: 0018:ffffb96e044279b8 EFLAGS: 00010202
[85256.572193] RAX: 0000000000000009 RBX: ffff9da70bf61000 RCX: ffffb96e044=
27a48
[85256.573422] RDX: ffff9da733a770c8 RSI: ffff9da70bf61000 RDI: ffff9da6941=
63818
[85256.574657] RBP: ffff9da733a770c8 R08: fffffffffffffff8 R09: 00000000000=
00002
[85256.575887] R10: ffffb96e044279a0 R11: 0000000000000000 R12: ffff9da6941=
63818
[85256.577122] R13: fffffffffffffff8 R14: ffff9da6d2512000 R15: ffff9da714c=
dac00
[85256.578352] FS:  00007fdeacf328c0(0000) GS:ffff9da735e00000(0000)
knlGS:0000000000000000
[85256.579741] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[85256.580739] CR2: 000055a2a5b8a118 CR3: 00000001eed78002 CR4: 00000000003=
606f0
[85256.581971] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[85256.583200] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[85256.584431] Call Trace:
[85256.584887]  ? create_reloc_root+0x49/0x2b0 [btrfs]
[85256.585734]  ? kmem_cache_alloc_trace+0xe5/0x200
[85256.586552]  create_reloc_root+0x8b/0x2b0 [btrfs]
[85256.587387]  btrfs_reloc_post_snapshot+0x96/0x5b0 [btrfs]
[85256.588340]  create_pending_snapshot+0x610/0x1010 [btrfs]
[85256.589293]  create_pending_snapshots+0xa8/0xd0 [btrfs]
[85256.590212]  btrfs_commit_transaction+0x4c7/0xc50 [btrfs]
[85256.591166]  ? btrfs_mksubvol+0x3cd/0x560 [btrfs]
[85256.592006]  btrfs_mksubvol+0x455/0x560 [btrfs]
[85256.592640]  __btrfs_ioctl_snap_create+0x15f/0x190 [btrfs]
[85256.593336]  btrfs_ioctl_snap_create_v2+0xa4/0xf0 [btrfs]
[85256.594008]  ? mem_cgroup_commit_charge+0x6e/0x540
[85256.594615]  btrfs_ioctl+0x12d8/0x3760 [btrfs]
[85256.595171]  ? do_raw_spin_unlock+0x49/0xc0
[85256.595695]  ? _raw_spin_unlock+0x29/0x40
[85256.596198]  ? __handle_mm_fault+0x11b3/0x14b0
[85256.596757]  ? ksys_ioctl+0x92/0xb0
[85256.597194]  ksys_ioctl+0x92/0xb0
[85256.597610]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[85256.598194]  __x64_sys_ioctl+0x16/0x20
[85256.598662]  do_syscall_64+0x5c/0x280
[85256.599120]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[85256.599752] RIP: 0033:0x7fdeabd3bdd7

This is actually very easy to trigger after the patchset I just sent
for fstests, that fixes btrfs/014.

Thanks.

> ---
>  fs/btrfs/relocation.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index d4734337127a..76bfb524bf3e 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -830,8 +830,7 @@ int btrfs_init_reloc_root(struct btrfs_trans_handle *=
trans,
>         int clear_rsv =3D 0;
>         int ret;
>
> -       if (!rc || !rc->create_reloc_tree ||
> -           root->root_key.objectid =3D=3D BTRFS_TREE_RELOC_OBJECTID)
> +       if (!rc)
>                 return 0;
>
>         /*
> @@ -841,12 +840,28 @@ int btrfs_init_reloc_root(struct btrfs_trans_handle=
 *trans,
>         if (reloc_root_is_dead(root))
>                 return 0;
>
> +       /*
> +        * This is subtle but important.  We do not do
> +        * record_root_in_transaction for reloc roots, instead we record =
their
> +        * corresponding fs root, and then here we update the last trans =
for the
> +        * reloc root.  This means that we have to do this for the entire=
 life
> +        * of the reloc root, regardless of which stage of the relocation=
 we are
> +        * in.
> +        */
>         if (root->reloc_root) {
>                 reloc_root =3D root->reloc_root;
>                 reloc_root->last_trans =3D trans->transid;
>                 return 0;
>         }
>
> +       /*
> +        * We are merging reloc roots, we do not need new reloc trees.  A=
lso
> +        * reloc trees never need their own reloc tree.
> +        */
> +       if (!rc->create_reloc_tree ||
> +           root->root_key.objectid =3D=3D BTRFS_TREE_RELOC_OBJECTID)
> +               return 0;
> +
>         if (!trans->reloc_reserved) {
>                 rsv =3D trans->block_rsv;
>                 trans->block_rsv =3D rc->block_rsv;
> --
> 2.24.1
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
