Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02C222C2429
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Nov 2020 12:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732645AbgKXL3x (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Nov 2020 06:29:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732077AbgKXL3w (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Nov 2020 06:29:52 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF63C0613D6
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Nov 2020 03:29:52 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id i199so6570319qke.5
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Nov 2020 03:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=ZSD0myNiIn6+IPcsYxo4ZyfwyNKn4uvUm90nFusPDQg=;
        b=E00EZ0a68/eRRSJSLi99lCstGi7Ji2OzmyM3iQFOCP33AKz4REMSoZwqQCTz+L1PfV
         sZU+OR7H7kj7IvPsV+hGuvGhmVj4sp+VCwAFDAKnjDQWXrBA5lDP1pDCVdqqxS5Nja6t
         LCPPWZqwJdlPTDmRaYxRI7AUIq8LOIVv6eW3SFXA7GMnU3adRz9P1fVbcyKfgOeJURHA
         3SPbxKJSTVYSgzJd0MQJ0rIEJQJXtFiis2kHO3TE1LzFhJVsKdhVFcnVsnWR8EsnZgRX
         4aLRe/Fp+1VpRC61/TGWkphrtymfYwr1SuNROSQIFjuGQe3WC2PmTzmyn7UzNtymDt1I
         amEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=ZSD0myNiIn6+IPcsYxo4ZyfwyNKn4uvUm90nFusPDQg=;
        b=FVVMYvWe0ycLvLpinq9fPa7MREhCcto3Qn8IoZRDGtVvl0IDSe7IG/WtV9nuBojehI
         arm15HuKiK54iyveAxECILsr+L3eWMFo61m6SD+kNpUn9hvY2/okpDTmONvvsgDc9wHf
         RStNfKwGGxPqlpeZEGUulFiid0UwhFTIAU5+6L8hcLPi4Ngyon9EohA3vqp3FzKp9GDq
         Zl17VO9ySIdUakxTWNGiB0O32SxmdZX4+WFKfMJO0hlCX58Tlw/NFfrcwBPY4H73tX2E
         SzYE3go4Gq2fQOQ0RxXCw7m47WF5zD7PkzOaVQWJ5TVJsnlvnIEPsxRKGgCZdGCN9HLX
         hZSw==
X-Gm-Message-State: AOAM533oXN4c6WIG5wXPfTZuooT30r/aRX8Ttw6E5zgdi0AQGOl+WYdC
        isU3mtewXZkKctp0aDLfkgI3FD1NaYxGM7qHePXnSoIYCUC1Pg==
X-Google-Smtp-Source: ABdhPJxeMmZ9OzSE6geUe+AxxqpRNf7LiqJx3s6Mg/Pm+Pdo2Qi5GavAT3AQd1aNiCGBIbbsu9vriWiD7EcNtbrq5LY=
X-Received: by 2002:a05:620a:a90:: with SMTP id v16mr4038647qkg.479.1606217391572;
 Tue, 24 Nov 2020 03:29:51 -0800 (PST)
MIME-Version: 1.0
References: <20201124022036.2840981-1-ethanwu@synology.com>
In-Reply-To: <20201124022036.2840981-1-ethanwu@synology.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Tue, 24 Nov 2020 11:29:40 +0000
Message-ID: <CAL3q7H7oOwQs8OR31DdZm16YbU0KKjux_ZGuvQVjbDdePqk0AQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] Btrfs: correctly calculate item size used when item
 key collision happends
To:     ethanwu <ethanwu@synology.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 24, 2020 at 4:39 AM ethanwu <ethanwu@synology.com> wrote:
>
> Item key collision is allowed for some item types, like dir item and
> inode refs, but the overall item size is limited by the leafsize.
>
> item size(ins_len) passed from btrfs_insert_empty_items to
> btrfs_search_slot already contains size of btrfs_item.
>
> When btrfs_search_slot reaches leaf, we'll see if we need to split leaf.
> The check incorrectly reports that split leaf is required, because
> it treats the space required by the newly inserted item as
> btrfs_item + item data. But in item key collision case, only item data
> is actually needed, the newly inserted item could merge into the existing
> one. No new btrfs_item will be inserted.
>
> And split_leaf return -EOVERFLOW from following code:
> if (extend && data_size + btrfs_item_size_nr(l, slot) +
>     sizeof(struct btrfs_item) > BTRFS_LEAF_DATA_SIZE(fs_info))
>     return -EOVERFLOW;
>
> In most cases, when callers receive -EOVERFLOW, they either return
> this error or handle in different ways. For example, in normal dir item
> creation the userspace will get errno EOVERFLOW; in inode ref case
> INODE_EXTREF is used instead.
>
> However, this is not the case for rename. To avoid the unrecoverable
> situation in rename, btrfs_check_dir_item_collision is called in
> early phase of rename. In this function, when item key collision is
> detected leaf space is checked:
>
> data_size =3D sizeof(*di) + name_len;
> if (data_size + btrfs_item_size_nr(leaf, slot) +
>     sizeof(struct btrfs_item) > BTRFS_LEAF_DATA_SIZE(root->fs_info))
>
> the sizeof(struct btrfs_item) + btrfs_item_size_nr(leaf, slot) here
> refers to existing item size, the condition here correctly calculate
> the needed size for collision case rather than the wrong case at
> above.
>
> The consequence of inconsistent condition check between
> btrfs_check_dir_item_collision and btrfs_search_slot when item key
> collision happens is that we might pass check here but fail
> later at btrfs_search_slot. Rename fails and volume is forced readonly
>
> [436149.586170] ------------[ cut here ]------------
> [436149.586173] BTRFS: Transaction aborted (error -75)
> [436149.586196] WARNING: CPU: 0 PID: 16733 at fs/btrfs/inode.c:9870 btrfs=
_rename2+0x1938/0x1b70 [btrfs]
> [436149.586197] Modules linked in: btrfs zstd_compress xor raid6_pq ufs q=
nx4 hfsplus hfs minix ntfs msdos jfs xfs libcrc32c rpcsec_gss_krb5 coretemp=
 crct10dif_pclmul crc32_pclmul ghash_clmulni_intel pcbc aesni_intel aes_x86=
_64 vmw_balloon crypto_simd cryptd glue_helper joydev input_leds intel_rapl=
_perf serio_raw vmw_vmci mac_hid sch_fq_codel nfsd auth_rpcgss nfs_acl lock=
d grace sunrpc parport_pc ppdev lp parport ip_tables x_tables autofs4 vmwgf=
x ttm drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops drm psmo=
use mptspi mptscsih mptbase scsi_transport_spi ahci vmxnet3 libahci i2c_pii=
x4 floppy pata_acpi
> [436149.586227] CPU: 0 PID: 16733 Comm: python Tainted: G      D         =
  4.18.0-rc5+ #1
> [436149.586228] Hardware name: VMware, Inc. VMware Virtual Platform/440BX=
 Desktop Reference Platform, BIOS 6.00 04/05/2016
> [436149.586238] RIP: 0010:btrfs_rename2+0x1938/0x1b70 [btrfs]
> [436149.586238] Code: 50 f0 48 0f ba a8 10 ce 00 00 02 72 27 41 83 f8 fb =
74 6f 44 89 c6 48 c7 c7 48 09 85 c0 44 89 55 80 44 89 45 98 e8 f8 5e 4c c5 =
<0f> 0b 44 8b 45 98 44 8b 55 80 44 89 55 80 44 89 c1 44 89 45 98 ba
> [436149.586254] RSP: 0018:ffffa327043a7ce0 EFLAGS: 00010286
> [436149.586255] RAX: 0000000000000000 RBX: ffff8d8a17d13340 RCX: 00000000=
00000006
> [436149.586256] RDX: 0000000000000007 RSI: 0000000000000096 RDI: ffff8d8a=
7fc164b0
> [436149.586257] RBP: ffffa327043a7da0 R08: 0000000000000560 R09: 72652820=
64657472
> [436149.586258] R10: 0000000000000000 R11: 6361736e61725420 R12: ffff8d8a=
0d4c8b08
> [436149.586258] R13: ffff8d8a17d13340 R14: ffff8d8a33e0a540 R15: 00000000=
000001fe
> [436149.586260] FS:  00007fa313933740(0000) GS:ffff8d8a7fc00000(0000) knl=
GS:0000000000000000
> [436149.586261] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [436149.586262] CR2: 000055d8d9c9a720 CR3: 000000007aae0003 CR4: 00000000=
003606f0
> [436149.586295] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000=
00000000
> [436149.586296] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000=
00000400
> [436149.586296] Call Trace:
> [436149.586311]  vfs_rename+0x383/0x920
> [436149.586313]  ? vfs_rename+0x383/0x920
> [436149.586315]  do_renameat2+0x4ca/0x590
> [436149.586317]  __x64_sys_rename+0x20/0x30
> [436149.586324]  do_syscall_64+0x5a/0x120
> [436149.586330]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [436149.586332] RIP: 0033:0x7fa3133b1d37
> [436149.586332] Code: 75 12 48 89 df e8 89 60 09 00 85 c0 0f 95 c0 0f b6 =
c0 f7 d8 5b c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 b8 52 00 00 00 0f 05 =
<48> 3d 00 f0 ff ff 77 09 f3 c3 0f 1f 80 00 00 00 00 48 8b 15 19 f1
> [436149.586348] RSP: 002b:00007fffd3e43908 EFLAGS: 00000246 ORIG_RAX: 000=
0000000000052
> [436149.586349] RAX: ffffffffffffffda RBX: 00007fa3133b1d30 RCX: 00007fa3=
133b1d37
> [436149.586350] RDX: 000055d8da06b5e0 RSI: 000055d8da225d60 RDI: 000055d8=
da2c4da0
> [436149.586351] RBP: 000055d8da2252f0 R08: 00007fa313782000 R09: 00000000=
000177e0
> [436149.586351] R10: 000055d8da010680 R11: 0000000000000246 R12: 00007fa3=
13840b00
>
> Thanks to Hans van Kranenburg for information about crc32 hash collision =
tools,
> I was able to reproduce the dir item collision with following python scri=
pt.
> https://github.com/wutzuchieh/misc_tools/blob/master/crc32_forge.py

Great that you made a reproducer, thanks for that!

So we should have a test case in fstests for this.
We want to catch future regressions.

Do you think you can convert the test to fstests?

That would mean converting it to bash and instead of generating the
names with a colliding crc32c hash at run time, use a list of
hardcoded names - which would have to be all printable characters
(a-z, A-Z, 0-9, _, -)
The filesystem in the test should be created with a node size of 64K,
so that the test runs on all architectures.
Running your script, for a node size of 64K, it took 1211 iterations
(file names) to hit the transaction abort.
To make the file name list shorter, try getting much longer file names
(200+ characters for e.g.).

The alternative would be to add there a small C program to generate
names with colliding hashes.
In btrfs-progs you have btrfs-crc.c that does that, although slow, so
perhaps it could be a starting point:

fdmanana 10:49:20 ~/git/hub/btrfs-progs ((v5.6.1))> make btrfs-crc
    [CC]     btrfs-crc.o
(...)
fdmanana 10:49:23 ~/git/hub/btrfs-progs ((v5.6.1))> ./btrfs-crc -c 11691779=
69
  1169177969 - =EF=BF=BDI=EF=BF=BDJ&+| =EF=BF=BD{=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BDgW<nTc
(...)

Either way, it will give some work, so I understand if you are
reluctant to do it.

> Run it under a btrfs volume will trigger the abort transaction.
> It simply creates files and rename them to forged names that leads to
> hash collision.
>
> There are two ways to fix this. One is to simply revert the patch
> "878f2d2cb355 Btrfs: fix max dir item size calculation"
> to make the condition consistent although that patch is correct
> about the size.
>
> The other way is to handle the leaf space check correctly when
> collision happens. I prefer the second one since it correct leaf
> space check in collision case. This fix needs unify the usage of ins_len
> in btrfs_search_slot to contain btrfs_item anyway and adjust all callers
> of btrfs_search_slot that intentionally pass ins_len without btrfs_item
> size to add size of btrfs_item from now.
>
> Signed-off-by: ethanwu <ethanwu@synology.com>
> ---
>
> v3: modify comment for btrfs_search_lot parameter ins_len,
>     fix incorrect ins_len in lookup_inline_extent_backref and btrfs_csum_=
file_blocks
>
>  fs/btrfs/ctree.c       | 16 ++++++++++++++--
>  fs/btrfs/extent-tree.c |  8 ++++++--
>  2 files changed, 20 insertions(+), 4 deletions(-)
>
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index 32a57a70b98d..084b55d4c397 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -2557,8 +2557,9 @@ static struct extent_buffer *btrfs_search_slot_get_=
root(struct btrfs_root *root,
>   * @p:         Holds all btree nodes along the search path
>   * @root:      The root node of the tree
>   * @key:       The key we are looking for
> - * @ins_len:   Indicates purpose of search, for inserts it is 1, for
> - *             deletions it's -1. 0 for plain searches
> + * @ins_len:   Indicates purpose of search, for inserts it is a positive
> + *             number (size of item inserted), for deletions it's a nega=
tive number and
> + *             0 for plain searches, not modifying the tree.

Please mention that in case ins_len > 0, then the value must account
for sizeof(struct btrfs_item).

>   * @cow:       boolean should CoW operations be performed. Must always b=
e 1
>   *             when modifying the tree.
>   *
> @@ -2719,6 +2720,17 @@ int btrfs_search_slot(struct btrfs_trans_handle *t=
rans, struct btrfs_root *root,
>
>                 if (level =3D=3D 0) {
>                         p->slots[level] =3D slot;
> +                       /*
> +                        * item key collision happens. In this case, if w=
e are allow

item -> Item (start of sentence),  allow -> allowed

> +                        * to insert the item(for example, in dir_item ca=
se, item key

Please add a space before opening the parenthesis -> "item (for
example..." instead

> +                        * collision is allowed), it will be merged with =
the original
> +                        * item. Only the item size grows, no new btrfs i=
tem will be
> +                        * added. Since the ins_len already accounts the =
size btrfs_item,
> +                        * this value is counted twice. Duduct this value=
 here so the

Duduct -> deduct

> +                        * leaf space check will be correct.
> +                        */
> +                       if (ret =3D=3D 0 && ins_len > 0)
> +                               ins_len -=3D sizeof(struct btrfs_item);

So lets add an assert to make sure ins_len is never less than
sizeof(struct btrfs_item).

At the start of the function something like:

if (ins_len > 0) ASSERT(ins_len >=3D sizeof(struct btrfs_item));

Other than that, it looks good.
Thanks.

>                         if (ins_len > 0 &&
>                             btrfs_leaf_free_space(b) < ins_len) {
>                                 if (write_lock_level < 1) {
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index fc942759a04c..ead62b7ba954 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -830,6 +830,7 @@ int lookup_inline_extent_backref(struct btrfs_trans_h=
andle *trans,
>         unsigned long ptr;
>         unsigned long end;
>         int extra_size;
> +       int ins_len;
>         int type;
>         int want;
>         int ret;
> @@ -844,9 +845,12 @@ int lookup_inline_extent_backref(struct btrfs_trans_=
handle *trans,
>         want =3D extent_ref_type(parent, owner);
>         if (insert) {
>                 extra_size =3D btrfs_extent_inline_ref_size(want);
> +               ins_len =3D extra_size + sizeof(struct btrfs_item);
>                 path->keep_locks =3D 1;
> -       } else
> +       } else {
>                 extra_size =3D -1;
> +               ins_len =3D -1;
> +       }
>
>         /*
>          * Owner is our level, so we can just add one to get the level fo=
r the
> @@ -858,7 +862,7 @@ int lookup_inline_extent_backref(struct btrfs_trans_h=
andle *trans,
>         }
>
>  again:
> -       ret =3D btrfs_search_slot(trans, root, &key, path, extra_size, 1)=
;
> +       ret =3D btrfs_search_slot(trans, root, &key, path, ins_len, 1);
>         if (ret < 0) {
>                 err =3D ret;
>                 goto out;
> --
> 2.25.1
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
