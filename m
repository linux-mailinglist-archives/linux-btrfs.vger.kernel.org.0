Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 278FCBDB91
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Sep 2019 11:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731651AbfIYJ6C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Sep 2019 05:58:02 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:39337 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727540AbfIYJ6C (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Sep 2019 05:58:02 -0400
Received: by mail-ua1-f68.google.com with SMTP id b14so1560157uap.6
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Sep 2019 02:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=wS+bALd21QNdsXAyH8jt4i0PSZRzi9q+VClZwR2zI3g=;
        b=qh75j13EqUcg53KrmHPtevvwarpQ71qi4NAwPaK/UdBs+c9lvqTaH8wV6uB0Z1qS1p
         fTjt547vSmLmm8nUQ4PEHfZc1JiihmqbOXfDdOGZpGyRBIRSi3UyTOAAiLYCxN/LPuGm
         ufJulwF4qRcGaGH8tOnjpgmtOWz7emBgpz8SiHzf8YmOZMDQ/emXRqRdDDdVKGQkfgbw
         yIwr2W4a4BQFdGG3c0IYnzYo1TdkbUlcYz1It0l+sW94zsocY9Mt91MvMV9tNXe0BchY
         5bWuziaOPrEM/y9JExSnVAnzmzu4F5nArQYkXIxXYZ0/Rc0OUOFFQEqoHVVNnf7Gc/o3
         o2Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=wS+bALd21QNdsXAyH8jt4i0PSZRzi9q+VClZwR2zI3g=;
        b=LQ1DAqL6nj3XYGTRxBpijBclLH1O6xzV2Mwi6xxEbUxsfwULC6UfzndT1Bncq38+6h
         hGNcgd+C/IcSwowCKUuwBfHdw2csoD5mLNlji6qQ5kfAR+/qG5ZsL+vmzl4z1be4g5HX
         JpdCiGZm3vtHDguHIJyHU61RuKiCkQFNz3LgPro2Kx+MUYv/h0fFiOIlSvskNlfqFqFm
         cvcFzBBCD0aAj7znkwtPKQkcb+2S8h/sCAE5ZuHuCVdAEbNije3FIWHDxszgD+BqF0uC
         EEbmYPeFFtpONfPw3bMzLAOYVsc/zWIPH5eZwAaVEz1KJifWQn646NeFoq4EGJ6ndjTR
         ZQiw==
X-Gm-Message-State: APjAAAUhBd1AIJUYfMVjaQfghAQS6cn0z4QLnl8AGhGiJMAnY/FnPBuF
        JXxStdy/1N9tsiIV8qilxvhEMKYkhcyWaxI7j1c=
X-Google-Smtp-Source: APXvYqynGsFIqKeYfxWkk825AsIlXieEJCDGG0MVsu/qhLGksuGqIcLplCc6BQd4yiEX9Qz70fkevROXbsPa19F59vA=
X-Received: by 2002:ab0:70a2:: with SMTP id q2mr3945574ual.83.1569405480386;
 Wed, 25 Sep 2019 02:58:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190923065614.22481-1-wqu@suse.com>
In-Reply-To: <20190923065614.22481-1-wqu@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 25 Sep 2019 10:57:49 +0100
Message-ID: <CAL3q7H7s8to6yYjymkSuMpifZxJko+RVOXRf7abMuVO5SjS6BQ@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: relocation: Fix KASAN report about
 use-after-free due to dead reloc tree cleanup race
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Cebtenzzre <cebtenzzre@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 25, 2019 at 5:21 AM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> One user reported a reproduciable KASAN report about use-after-free:
>   BTRFS info (device sdi1): balance: start -dvrange=3D1256811659264..1256=
811659265
>   BTRFS info (device sdi1): relocating block group 1256811659264 flags da=
ta|raid0
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   BUG: KASAN: use-after-free in btrfs_init_reloc_root+0x2cd/0x340 [btrfs]
>   Write of size 8 at addr ffff88856f671710 by task kworker/u24:10/261579
>
>   CPU: 2 PID: 261579 Comm: kworker/u24:10 Tainted: P           OE     5.2=
.11-arch1-1-kasan #4
>   Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./X99 Extrem=
e4, BIOS P3.80 04/06/2018
>   Workqueue: btrfs-endio-write btrfs_endio_write_helper [btrfs]
>   Call Trace:
>    dump_stack+0x7b/0xba
>    print_address_description+0x6c/0x22e
>    ? btrfs_init_reloc_root+0x2cd/0x340 [btrfs]
>    __kasan_report.cold+0x1b/0x3b
>    ? btrfs_init_reloc_root+0x2cd/0x340 [btrfs]
>    kasan_report+0x12/0x17
>    __asan_report_store8_noabort+0x17/0x20
>    btrfs_init_reloc_root+0x2cd/0x340 [btrfs]
>    record_root_in_trans+0x2a0/0x370 [btrfs]
>    btrfs_record_root_in_trans+0xf4/0x140 [btrfs]
>    start_transaction+0x1ab/0xe90 [btrfs]
>    btrfs_join_transaction+0x1d/0x20 [btrfs]
>    btrfs_finish_ordered_io+0x7bf/0x18a0 [btrfs]
>    ? lock_repin_lock+0x400/0x400
>    ? __kmem_cache_shutdown.cold+0x140/0x1ad
>    ? btrfs_unlink_subvol+0x9b0/0x9b0 [btrfs]
>    finish_ordered_fn+0x15/0x20 [btrfs]
>    normal_work_helper+0x1bd/0xca0 [btrfs]
>    ? process_one_work+0x819/0x1720
>    ? kasan_check_read+0x11/0x20
>    btrfs_endio_write_helper+0x12/0x20 [btrfs]
>    process_one_work+0x8c9/0x1720
>    ? pwq_dec_nr_in_flight+0x2f0/0x2f0
>    ? worker_thread+0x1d9/0x1030
>    worker_thread+0x98/0x1030
>    kthread+0x2bb/0x3b0
>    ? process_one_work+0x1720/0x1720
>    ? kthread_park+0x120/0x120
>    ret_from_fork+0x35/0x40
>
>   Allocated by task 369692:
>    __kasan_kmalloc.part.0+0x44/0xc0
>    __kasan_kmalloc.constprop.0+0xba/0xc0
>    kasan_kmalloc+0x9/0x10
>    kmem_cache_alloc_trace+0x138/0x260
>    btrfs_read_tree_root+0x92/0x360 [btrfs]
>    btrfs_read_fs_root+0x10/0xb0 [btrfs]
>    create_reloc_root+0x47d/0xa10 [btrfs]
>    btrfs_init_reloc_root+0x1e2/0x340 [btrfs]
>    record_root_in_trans+0x2a0/0x370 [btrfs]
>    btrfs_record_root_in_trans+0xf4/0x140 [btrfs]
>    start_transaction+0x1ab/0xe90 [btrfs]
>    btrfs_start_transaction+0x1e/0x20 [btrfs]
>    __btrfs_prealloc_file_range+0x1c2/0xa00 [btrfs]
>    btrfs_prealloc_file_range+0x13/0x20 [btrfs]
>    prealloc_file_extent_cluster+0x29f/0x570 [btrfs]
>    relocate_file_extent_cluster+0x193/0xc30 [btrfs]
>    relocate_data_extent+0x1f8/0x490 [btrfs]
>    relocate_block_group+0x600/0x1060 [btrfs]
>    btrfs_relocate_block_group+0x3a0/0xa00 [btrfs]
>    btrfs_relocate_chunk+0x9e/0x180 [btrfs]
>    btrfs_balance+0x14e4/0x2fc0 [btrfs]
>    btrfs_ioctl_balance+0x47f/0x640 [btrfs]
>    btrfs_ioctl+0x119d/0x8380 [btrfs]
>    do_vfs_ioctl+0x9f5/0x1060
>    ksys_ioctl+0x67/0x90
>    __x64_sys_ioctl+0x73/0xb0
>    do_syscall_64+0xa5/0x370
>    entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
>   Freed by task 369692:
>    __kasan_slab_free+0x14f/0x210
>    kasan_slab_free+0xe/0x10
>    kfree+0xd8/0x270
>    btrfs_drop_snapshot+0x154c/0x1eb0 [btrfs]
>    clean_dirty_subvols+0x227/0x340 [btrfs]
>    relocate_block_group+0x972/0x1060 [btrfs]
>    btrfs_relocate_block_group+0x3a0/0xa00 [btrfs]
>    btrfs_relocate_chunk+0x9e/0x180 [btrfs]
>    btrfs_balance+0x14e4/0x2fc0 [btrfs]
>    btrfs_ioctl_balance+0x47f/0x640 [btrfs]
>    btrfs_ioctl+0x119d/0x8380 [btrfs]
>    do_vfs_ioctl+0x9f5/0x1060
>    ksys_ioctl+0x67/0x90
>    __x64_sys_ioctl+0x73/0xb0
>    do_syscall_64+0xa5/0x370
>    entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
>   The buggy address belongs to the object at ffff88856f671100
>    which belongs to the cache kmalloc-4k of size 4096
>   The buggy address is located 1552 bytes inside of
>    4096-byte region [ffff88856f671100, ffff88856f672100)
>   The buggy address belongs to the page:
>   page:ffffea0015bd9c00 refcount:1 mapcount:0 mapping:ffff88864400e600 in=
dex:0x0 compound_mapcount: 0
>   flags: 0x2ffff0000010200(slab|head)
>   raw: 02ffff0000010200 dead000000000100 dead000000000200 ffff88864400e60=
0
>   raw: 0000000000000000 0000000000070007 00000001ffffffff 000000000000000=
0
>   page dumped because: kasan: bad access detected
>
>   Memory state around the buggy address:
>    ffff88856f671600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>    ffff88856f671680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>   >ffff88856f671700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                            ^
>    ffff88856f671780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>    ffff88856f671800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   BTRFS info (device sdi1): 1 enospc errors during balance
>   BTRFS info (device sdi1): balance: ended with status: -28
>
> [CAUSE]
> The problem happens when finish_ordered_io() get called with balance
> still running, while the reloc root of that subvolume is already dead.
> (tree swap already done, but tree not yet deleted for possible qgroup
> usage)
>
> That means root->reloc_root still exists, but that reloc_root can be
> under btrfs_drop_snapshot(), thus we shouldn't access it.
>
> The following race could cause the use-after-free problem:
>
>                 CPU1              |                CPU2
> -------------------------------------------------------------------------=
-
>                                   | relocate_block_group()
>                                   | |- unset_reloc_control(rc)
>                                   | |- btrfs_commit_transaction()
> btrfs_finish_ordered_io()         | |- clean_dirty_subvols()
> |- btrfs_join_transaction()       |    |
>    |- record_root_in_trans()      |    |
>       |- btrfs_init_reloc_root()  |    |
>          |- if (root->reloc_root) |    |
>          |                        |    |- root->reloc_root =3D NULL
>          |                        |    |- btrfs_drop_snapshot(reloc_root)=
;
>          |- reloc_root->last_trans|
>                  =3D trans->transid |
>             ^^^^^^^^^^^^^^^^^^^^^^
>             Use after free
>
> [FIX]
> Fix it by the following modifications:
> - Test if the root has dead reloc tree before accessing root->reloc_root
>   If the root has BTRFS_ROOT_DEAD_RELOC_TREE, then we don't need to
>   create or update root->reloc_tree
>
> - Clear the BTRFS_ROOT_DEAD_RELOC_TREE flag until we have fully dropped
>   reloc tree
>   To co-operate with above modification, so as long as
>   BTRFS_ROOT_DEAD_RELOC_TREE is still set, we won't try to re-create
>   reloc tree at record_root_in_trans().
>
> Reported-by: Cebtenzzre <cebtenzzre@gmail.com>
> Fixes: d2311e698578 ("btrfs: relocation: Delay reloc tree deletion after =
merge_reloc_roots")
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Instead of such a long subject "btrfs: relocation: Fix KASAN report
about use-after-free due to dead reloc tree cleanup race", I would use
something smaller like "btrfs: fix use-after-free on dead relocation roots"=
.
You don't need to mention in the subject that KASAN detected it, as
well as the reason for the problem, both can be left in the changelog.

Other than that it looks good to me, thanks.

> ---
> changelog:
> v2:
> - Make the common BTRFS_ROOT_DEAD_RELOC_TREE check the first check
> - Remove one random newline caused by editing
> ---
>  fs/btrfs/relocation.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 7f219851fa23..655f1d5a8c27 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -1434,6 +1434,13 @@ int btrfs_init_reloc_root(struct btrfs_trans_handl=
e *trans,
>         int clear_rsv =3D 0;
>         int ret;
>
> +       /*
> +        * The subvolume has reloc tree but the swap is finished,
> +        * no need to create/update the dead reloc tree
> +        */
> +       if (test_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state))
> +               return 0;
> +
>         if (root->reloc_root) {
>                 reloc_root =3D root->reloc_root;
>                 reloc_root->last_trans =3D trans->transid;
> @@ -2186,7 +2193,6 @@ static int clean_dirty_subvols(struct reloc_control=
 *rc)
>                         /* Merged subvolume, cleanup its reloc root */
>                         struct btrfs_root *reloc_root =3D root->reloc_roo=
t;
>
> -                       clear_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->stat=
e);
>                         list_del_init(&root->reloc_dirty_list);
>                         root->reloc_root =3D NULL;
>                         if (reloc_root) {
> @@ -2195,6 +2201,7 @@ static int clean_dirty_subvols(struct reloc_control=
 *rc)
>                                 if (ret2 < 0 && !ret)
>                                         ret =3D ret2;
>                         }
> +                       clear_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->stat=
e);
>                         btrfs_put_fs_root(root);
>                 } else {
>                         /* Orphan reloc tree, just clean it up */
> --
> 2.23.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
