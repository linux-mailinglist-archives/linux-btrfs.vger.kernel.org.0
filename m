Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F423D2CBAD9
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Dec 2020 11:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729466AbgLBKn2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 05:43:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbgLBKn2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Dec 2020 05:43:28 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF630C0613CF
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Dec 2020 02:42:41 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id u21so635125qtw.11
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Dec 2020 02:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=lPUeIjqZkseRZzicmfs6D20y9IZ2T4pIzThppChJKq8=;
        b=qLJ3lWNrDq37KqV3QZLDgSxTi81Oo4nAyD9E54aB9G5zxNf+1XlXTys04/dKeP+MT5
         CXeBImqp0hJ2ws8qwU9nRUxEtIcg9fF4GGlq7RT//ct6z8+J+0ikLH/LfyMpBA/JdM2W
         vxyiCiT8b5XyhHcIs9wKH6XIToPZpVB8Cki71PEBWZnAhp5R9qj56HpgAD3otukHgL8y
         6PQ9bb4oGAhSHdC42S3bUDg0Fy+ZeHztya9P3EONGsIRsyLI3Om/glHIvb/d2bX7jJgY
         Kf/sYx+Lr1/8pY3TIZkrwTCWTZwqdMLtQeTmD5Nj4E17Bve4mh0tlSpI3Oi2ubiyXCcB
         Zuag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=lPUeIjqZkseRZzicmfs6D20y9IZ2T4pIzThppChJKq8=;
        b=UlA48/aIK0zoYbrshU7QSxhxKuXmpuUxzRRhqgX1qbzvEGtY6/nIHCpHHxqEd/U4A3
         lkk8j5Vr9Bi007aD1pKZ2px5M7gqJ8QaxU5oCzr0UNK3Mpi93lzZDKkfEjaiiITEn1ul
         dTf43hDFkbegszTCJkHhnUcdt7IGIWyukeYu7RK/1LRkFT8r0E4VkuRTPKP+UTKN5jWw
         Nk2d8RaBciEaluIJf45ckyEo9kR0R6Eys5dt8Lsw+WUttk9BzSDoHTM8ukuNjQRFEACG
         KJYd9oJGLATn6gEEeSKWMFv7gh4tlhb+xUsJ7lgpycG0xXs9VKEFDSmUNG4w8a1Jsptz
         dicw==
X-Gm-Message-State: AOAM531W6BoPt6ec0cKUKKAoMl7N741pa0+HDUXqNDBzLcy8FBtAr6lh
        QtLwgpHS7F4jaQyM2uit+TKCOiUFLpASAt+NbH3Oz3um
X-Google-Smtp-Source: ABdhPJyHfRrnjKRkIHRFRp7Sa+85elaMOas31qWboqV5wQXe+EM4ZA/T0B2278oViX9FporBW/OSAAm9rupGLY8bdJk=
X-Received: by 2002:ac8:74d3:: with SMTP id j19mr1863642qtr.259.1606905761014;
 Wed, 02 Dec 2020 02:42:41 -0800 (PST)
MIME-Version: 1.0
References: <20201201092512.1487765-1-ethanwu@synology.com>
In-Reply-To: <20201201092512.1487765-1-ethanwu@synology.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 2 Dec 2020 10:42:29 +0000
Message-ID: <CAL3q7H6gHD+h59NVt8QaszS8BLqjvrvf3+Rw-nR97pzw6n89Tg@mail.gmail.com>
Subject: Re: [PATCH V4] btrfs: correctly calculate item size used when item
 key collision happens
To:     ethanwu <ethanwu@synology.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 1, 2020 at 9:30 AM ethanwu <ethanwu@synology.com> wrote:
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
> space check in collision case. This fix will not account
> sizeof(struct btrfs_item) when item already exists.
> There are two places where ins_len doesn't contain
> sizeof(struct btrfs_item), however.
>
> 1. extent-tree.c: lookup_inline_extent_backref
> 2. file-item.c: btrfs_csum_file_blocks
>
> to make the logic of btrfs_search_slot more clear, we add a flag
> search_for_extension in btrfs_path.
>
> This flag indicates that ins_len passed to btrfs_search_slot doesn't
> contain sizeof(struct btrfs_item). When key exists, btrfs_search_slot
> will use the actual size needed to calculate the required leaf space.
>
> Signed-off-by: ethanwu <ethanwu@synology.com>
> ---
> v4: modify comment for btrfs_search_lot parameter ins_len,
>     add search_for_extension to btrfs_path
>     add assert in btrfs_search_slot

Thanks, it's exactly what I had in mind, perfect.

Reviewed-by: Filipe Manana <fdmanana@suse.com>


>
> v3: modify comment for btrfs_search_lot parameter ins_len,
>     fix incorrect ins_len in lookup_inline_extent_backref and btrfs_csum_=
file_blocks
>
> v2: modify change log, add call trace and way to reproduce it
>
>  fs/btrfs/ctree.c       | 20 ++++++++++++++++++--
>  fs/btrfs/ctree.h       |  7 +++++++
>  fs/btrfs/extent-tree.c |  2 ++
>  fs/btrfs/file-item.c   |  2 ++
>  4 files changed, 29 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index 32a57a70b98d..452b08439385 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -2557,8 +2557,11 @@ static struct extent_buffer *btrfs_search_slot_get=
_root(struct btrfs_root *root,
>   * @p:         Holds all btree nodes along the search path
>   * @root:      The root node of the tree
>   * @key:       The key we are looking for
> - * @ins_len:   Indicates purpose of search, for inserts it is 1, for
> - *             deletions it's -1. 0 for plain searches
> + * @ins_len:   Indicates purpose of search, for inserts it is a positive
> + *             number (size of item inserted), for deletions it's a nega=
tive number and
> + *             0 for plain searches, not modifying the tree. If size of =
item inserted
> + *             doesn't contain sizeof(struct btrfs_item), then p->search=
_for_extension
> + *             should be set.
>   * @cow:       boolean should CoW operations be performed. Must always b=
e 1
>   *             when modifying the tree.
>   *
> @@ -2719,6 +2722,19 @@ int btrfs_search_slot(struct btrfs_trans_handle *t=
rans, struct btrfs_root *root,
>
>                 if (level =3D=3D 0) {
>                         p->slots[level] =3D slot;
> +                       /*
> +                        * Item key already exists. In this case, if we a=
re allowed
> +                        * to insert the item (for example, in dir_item c=
ase, item key
> +                        * collision is allowed), it will be merged with =
the original
> +                        * item. Only the item size grows, no new btrfs i=
tem will be
> +                        * added. If search_for_extension is not set, ins=
_len already
> +                        * accounts the size btrfs_item, deduct it here s=
o leaf space
> +                        * check will be correct.
> +                        */
> +                       if (ret =3D=3D 0 && ins_len > 0 && !p->search_for=
_extension) {
> +                               ASSERT(ins_len >=3D sizeof(struct btrfs_i=
tem));
> +                               ins_len -=3D sizeof(struct btrfs_item);
> +                       }
>                         if (ins_len > 0 &&
>                             btrfs_leaf_free_space(b) < ins_len) {
>                                 if (write_lock_level < 1) {
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index e7099f550b7e..b82a969f4954 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -374,6 +374,13 @@ struct btrfs_path {
>         unsigned int search_commit_root:1;
>         unsigned int need_commit_sem:1;
>         unsigned int skip_release_on_error:1;
> +       /*
> +        * set when
> +        * 1. ins_len > 0 AND
> +        * 2. ins_len only contains data size required when key already e=
xists,
> +        *    i.e. sizeof(struct btrfs_item) is excluded.
> +        */
> +       unsigned int search_for_extension:1;
>  };
>  #define BTRFS_MAX_EXTENT_ITEM_SIZE(r) ((BTRFS_LEAF_DATA_SIZE(r->fs_info)=
 >> 4) - \
>                                         sizeof(struct btrfs_item))
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index fc942759a04c..b6d774803a2c 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -844,6 +844,7 @@ int lookup_inline_extent_backref(struct btrfs_trans_h=
andle *trans,
>         want =3D extent_ref_type(parent, owner);
>         if (insert) {
>                 extra_size =3D btrfs_extent_inline_ref_size(want);
> +               path->search_for_extension =3D 1;
>                 path->keep_locks =3D 1;
>         } else
>                 extra_size =3D -1;
> @@ -996,6 +997,7 @@ int lookup_inline_extent_backref(struct btrfs_trans_h=
andle *trans,
>  out:
>         if (insert) {
>                 path->keep_locks =3D 0;
> +               path->search_for_extension =3D 0;
>                 btrfs_unlock_up_safe(path, 1);
>         }
>         return err;
> diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
> index 1a5651bebbaf..0ef40289dc43 100644
> --- a/fs/btrfs/file-item.c
> +++ b/fs/btrfs/file-item.c
> @@ -924,8 +924,10 @@ int btrfs_csum_file_blocks(struct btrfs_trans_handle=
 *trans,
>         }
>
>         btrfs_release_path(path);
> +       path->search_for_extension =3D 1;
>         ret =3D btrfs_search_slot(trans, root, &file_key, path,
>                                 csum_size, 1);
> +       path->search_for_extension =3D 0;
>         if (ret < 0)
>                 goto out;
>
> --
> 2.25.1
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
