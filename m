Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B96E12C03C1
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Nov 2020 12:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbgKWK65 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Nov 2020 05:58:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbgKWK65 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Nov 2020 05:58:57 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC46C0613CF
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Nov 2020 02:58:57 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id l11so8680429plt.1
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Nov 2020 02:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1BP877PWB5Il1SFAjpxaeZ28lPYZJMPEFFDP6HWqH3c=;
        b=Oy2SWK52l81VgZZKxKTe4aBoY3vt1C4E/zVy2iIcxGUOyQngf+zOtbANPCPNjPF/Rg
         GHmin8QUgBlcA2vQZpJfGjf6fVb0RwbWJjaZ3WzHIHxGfXmdUlAWCcCTZ67phFzneF5o
         7MI90cEriU+iTathjn1CmuaJnz4YM8iE11k6lINIKjrFobKgIB5LoCnZMRWafHdOsjXV
         3Q4uAFXDluxkR6hbeOX4E8ooVt76vbB6T/GEjZwsKs1O3sCOrNHoqjuWznZ5DWTjHVJ8
         ywdQLdsLjtDGNLx5eIuSUBqoHyYkRBZaOWR1BpMO2f00ymAHHsA2kWI6ENOmFk1p78sR
         Xu9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1BP877PWB5Il1SFAjpxaeZ28lPYZJMPEFFDP6HWqH3c=;
        b=hqaj9GEj0pRKqPLJcr+/QBYZ2y62Wtw1Eb0V8CSJR+3yeaDpbVNqk5ZMHK/7kS1kyK
         gKAUdoh0AuMR0Wdps9T1dqcXz1GIitBVW6u92gL7awjRIuz1zYeg+LDuDpF+D1J6ILCN
         4hbM2vbBFyq6AeQxdl4Zz0iWxhVwrJG4JusRJ7YosvLkuvA7S45bR8pof0VQb5i1Rbh/
         1+T8+M6SQ7mWn37QcMb1Fz+y9E4FHfj5zxWZtjSt5FjIx9VhlBlLeOvi3niPZ+M6cfld
         IQ2iH/47g8mrmdPFM5wTZ3H5n9qfULZFt/NgCJXFldv5JT7S+CuUnGbT0LT71PF3zp9s
         6iqQ==
X-Gm-Message-State: AOAM531rZIG3gcM0kr+CfLtQN9mQiNjZRPFHHhINJkxQJP5JUK1zN8lo
        XJUAenMDOU9PtRNIEKaqrBr6FkvxUxJLJ4jm0+MTVk8YGYw=
X-Google-Smtp-Source: ABdhPJy7iH76qVTQcVj7vFRj2uUrnEhtBEY5tCNF2mFfIZ5hgYKEjNDO/b6wYhdU+Zh0kJT0oGwExu49fOZ2z3UVbTI=
X-Received: by 2002:a17:902:6546:b029:d8:f81c:ef8c with SMTP id
 d6-20020a1709026546b02900d8f81cef8cmr23446196pln.31.1606129136114; Mon, 23
 Nov 2020 02:58:56 -0800 (PST)
MIME-Version: 1.0
References: <d949e51d-0122-12ff-6aa2-083a7e5628b1@mendix.com>
 <1534322561-2058-1-git-send-email-ethanwu@synology.com> <54f38af8-ecd2-4410-f18a-0cfbe68bed4b@suse.com>
In-Reply-To: <54f38af8-ecd2-4410-f18a-0cfbe68bed4b@suse.com>
From:   =?UTF-8?B?5ZCz5a2Q5p2w?= <ethan198912@gmail.com>
Date:   Mon, 23 Nov 2020 18:58:44 +0800
Message-ID: <CACKp3fmhO2xDA-OUywRciwOF3SY9_ArBWTqd51mGjw_n42_Lzg@mail.gmail.com>
Subject: Re: [PATCH v2] Btrfs: correctly calculate item size used when item
 key collision happends
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     ethanwu <ethanwu@synology.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Nikolay Borisov <nborisov@suse.com> =E6=96=BC 2018=E5=B9=B48=E6=9C=8815=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=887:09=E5=AF=AB=E9=81=93=EF=BC=9A
>
>
>
> On 15.08.2018 11:42, ethanwu wrote:
> > Item key collision is allowed for some item types, like dir item and
> > inode refs, but the overall item size is limited by the leafsize.
> >
> > item size(ins_len) passed from btrfs_insert_empty_items to
> > btrfs_search_slot already contains size of btrfs_item.
> >
> > When btrfs_search_slot reaches leaf, we'll see if we need to split leaf=
.
> > The check incorrectly reports that split leaf is required, because
> > it treats the space required by the newly inserted item as
> > btrfs_item + item data. But in item key collision case, only item data
> > is actually needed, the newly inserted item could merge into the existi=
ng
> > one. No new btrfs_item will be inserted.
> >
> > And split_leaf return -EOVERFLOW from following code:
> > if (extend && data_size + btrfs_item_size_nr(l, slot) +
> >     sizeof(struct btrfs_item) > BTRFS_LEAF_DATA_SIZE(fs_info))
> >     return -EOVERFLOW;
> >
> > In most cases, when callers receive -EOVERFLOW, they either return
> > this error or handle in different ways. For example, in normal dir item
> > creation the userspace will get errno EOVERFLOW; in inode ref case
> > INODE_EXTREF is used instead.
> >
> > However, this is not the case for rename. To avoid the unrecoverable
> > situation in rename, btrfs_check_dir_item_collision is called in
> > early phase of rename. In this function, when item key collision is
> > detected leaf space is checked:
> >
> > data_size =3D sizeof(*di) + name_len;
> > if (data_size + btrfs_item_size_nr(leaf, slot) +
> >     sizeof(struct btrfs_item) > BTRFS_LEAF_DATA_SIZE(root->fs_info))
> >
> > the sizeof(struct btrfs_item) + btrfs_item_size_nr(leaf, slot) here
> > refers to existing item size, the condition here correctly calculate
> > the needed size for collision case rather than the wrong case at
> > above.
> >
> > The consequence of inconsistent condition check between
> > btrfs_check_dir_item_collision and btrfs_search_slot when item key
> > collision happens is that we might pass check here but fail
> > later at btrfs_search_slot. Rename fails and volume is forced readonly
> >
> > [436149.586170] ------------[ cut here ]------------
> > [436149.586173] BTRFS: Transaction aborted (error -75)
> > [436149.586196] WARNING: CPU: 0 PID: 16733 at fs/btrfs/inode.c:9870 btr=
fs_rename2+0x1938/0x1b70 [btrfs]
> > [436149.586197] Modules linked in: btrfs zstd_compress xor raid6_pq ufs=
 qnx4 hfsplus hfs minix ntfs msdos jfs xfs libcrc32c rpcsec_gss_krb5 corete=
mp crct10dif_pclmul crc32_pclmul ghash_clmulni_intel pcbc aesni_intel aes_x=
86_64 vmw_balloon crypto_simd cryptd glue_helper joydev input_leds intel_ra=
pl_perf serio_raw vmw_vmci mac_hid sch_fq_codel nfsd auth_rpcgss nfs_acl lo=
ckd grace sunrpc parport_pc ppdev lp parport ip_tables x_tables autofs4 vmw=
gfx ttm drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops drm ps=
mouse mptspi mptscsih mptbase scsi_transport_spi ahci vmxnet3 libahci i2c_p=
iix4 floppy pata_acpi
> > [436149.586227] CPU: 0 PID: 16733 Comm: python Tainted: G      D       =
    4.18.0-rc5+ #1
> > [436149.586228] Hardware name: VMware, Inc. VMware Virtual Platform/440=
BX Desktop Reference Platform, BIOS 6.00 04/05/2016
> > [436149.586238] RIP: 0010:btrfs_rename2+0x1938/0x1b70 [btrfs]
> > [436149.586238] Code: 50 f0 48 0f ba a8 10 ce 00 00 02 72 27 41 83 f8 f=
b 74 6f 44 89 c6 48 c7 c7 48 09 85 c0 44 89 55 80 44 89 45 98 e8 f8 5e 4c c=
5 <0f> 0b 44 8b 45 98 44 8b 55 80 44 89 55 80 44 89 c1 44 89 45 98 ba
> > [436149.586254] RSP: 0018:ffffa327043a7ce0 EFLAGS: 00010286
> > [436149.586255] RAX: 0000000000000000 RBX: ffff8d8a17d13340 RCX: 000000=
0000000006
> > [436149.586256] RDX: 0000000000000007 RSI: 0000000000000096 RDI: ffff8d=
8a7fc164b0
> > [436149.586257] RBP: ffffa327043a7da0 R08: 0000000000000560 R09: 726528=
2064657472
> > [436149.586258] R10: 0000000000000000 R11: 6361736e61725420 R12: ffff8d=
8a0d4c8b08
> > [436149.586258] R13: ffff8d8a17d13340 R14: ffff8d8a33e0a540 R15: 000000=
00000001fe
> > [436149.586260] FS:  00007fa313933740(0000) GS:ffff8d8a7fc00000(0000) k=
nlGS:0000000000000000
> > [436149.586261] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [436149.586262] CR2: 000055d8d9c9a720 CR3: 000000007aae0003 CR4: 000000=
00003606f0
> > [436149.586295] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000=
0000000000
> > [436149.586296] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000=
0000000400
> > [436149.586296] Call Trace:
> > [436149.586311]  vfs_rename+0x383/0x920
> > [436149.586313]  ? vfs_rename+0x383/0x920
> > [436149.586315]  do_renameat2+0x4ca/0x590
> > [436149.586317]  __x64_sys_rename+0x20/0x30
> > [436149.586324]  do_syscall_64+0x5a/0x120
> > [436149.586330]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > [436149.586332] RIP: 0033:0x7fa3133b1d37
> > [436149.586332] Code: 75 12 48 89 df e8 89 60 09 00 85 c0 0f 95 c0 0f b=
6 c0 f7 d8 5b c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 b8 52 00 00 00 0f 0=
5 <48> 3d 00 f0 ff ff 77 09 f3 c3 0f 1f 80 00 00 00 00 48 8b 15 19 f1
> > [436149.586348] RSP: 002b:00007fffd3e43908 EFLAGS: 00000246 ORIG_RAX: 0=
000000000000052
> > [436149.586349] RAX: ffffffffffffffda RBX: 00007fa3133b1d30 RCX: 00007f=
a3133b1d37
> > [436149.586350] RDX: 000055d8da06b5e0 RSI: 000055d8da225d60 RDI: 000055=
d8da2c4da0
> > [436149.586351] RBP: 000055d8da2252f0 R08: 00007fa313782000 R09: 000000=
00000177e0
> > [436149.586351] R10: 000055d8da010680 R11: 0000000000000246 R12: 00007f=
a313840b00
> >
> > Thanks to Hans van Kranenburg for information about crc32 hash collisio=
n tools,
> > I was able to reproduce the dir item collision with following python sc=
ript.
> > https://github.com/wutzuchieh/misc_tools/blob/master/crc32_forge.py
> > Run it under a btrfs volume will trigger the abort transaction.
> > It simply creates files and rename them to forged names that leads to
> > hash collision.
> >
> > There are two ways to fix this. One is to simply revert the patch
> > "878f2d2cb355 Btrfs: fix max dir item size calculation"
> > to make the condition consistent although that patch is correct
> > about the size.
> >
> > The other way is to handle the leaf space check correctly when
> > collision happens. I prefer the second one since it correct leaf
> > space check in collision case. This fix needs unify the usage of ins_le=
n
> > in btrfs_search_slot to contain btrfs_item anyway and adjust all caller=
s
> > of btrfs_search_slot that intentionally pass ins_len without btrfs_item
> > size to add size of btrfs_item from now.
> >
> > Fixes: 878f2d2cb355 Btrfs: fix max dir item size calculation
> > Signed-off-by: ethanwu <ethanwu@synology.com>
> > ---
> >
> > v2: modify change log, add call trace and way to reproduce it
> >
> >  fs/btrfs/ctree.c       | 15 +++++++++++++--
> >  fs/btrfs/extent-tree.c |  5 +++--
> >  fs/btrfs/file-item.c   |  2 +-
> >  3 files changed, 17 insertions(+), 5 deletions(-)
> >
> > diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> > index 4bc326d..3614dd9 100644
> > --- a/fs/btrfs/ctree.c
> > +++ b/fs/btrfs/ctree.c
> > @@ -2678,8 +2678,8 @@ static struct extent_buffer *btrfs_search_slot_ge=
t_root(struct btrfs_root *root,
> >   * @p:               Holds all btree nodes along the search path
> >   * @root:    The root node of the tree
> >   * @key:     The key we are looking for
> > - * @ins_len: Indicates purpose of search, for inserts it is 1, for
> > - *           deletions it's -1. 0 for plain searches
> > + * @ins_len: Indicates purpose of search, for inserts it is item size
> > + *           including btrfs_item, for deletions it's -1. 0 for plain =
searches
>
> This must be reworded - even my initial commit adding the documentation
> was wrong:
>
> * @ins_len:     Indicates purpose of search, for inserts it is a positive
> number (size of item inserted), for deletions it's a negative number and
> 0 for plain searches, not modifying the tree.
>

OK I'll modify the comment as well, and thanks for providing the sample.

> >   * @cow:     boolean should CoW operations be performed. Must always b=
e 1
> >   *           when modifying the tree.
> >   *
> > @@ -2893,6 +2893,17 @@ int btrfs_search_slot(struct btrfs_trans_handle =
*trans, struct btrfs_root *root,
> >                       }
> >               } else {
> >                       p->slots[level] =3D slot;
> > +                     /*
> > +                      * item key collision happens. In this case, if w=
e are allow
> > +                      * to insert the item(for example, in dir_item ca=
se, item key
> > +                      * collision is allowed), it will be merged with =
the original
> > +                      * item. Only the item size grows, no new btrfs i=
tem will be
> > +                      * added. Since the ins_len already accounts the =
size btrfs_item,
> > +                      * this value is counted twice. Duduct this value=
 here so the
> > +                      * leaf space check will be correct.
> > +                      */
> > +                     if (ret =3D=3D 0 && ins_len > 0)
> > +                             ins_len -=3D sizeof(struct btrfs_item);
> >                       if (ins_len > 0 &&
> >                           btrfs_leaf_free_space(fs_info, b) < ins_len) =
{
> >                               if (write_lock_level < 1) {
> > diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> > index 3d9fe58..4e3aa09 100644
> > --- a/fs/btrfs/extent-tree.c
> > +++ b/fs/btrfs/extent-tree.c
> > @@ -1094,7 +1094,7 @@ static int convert_extent_item_v0(struct btrfs_tr=
ans_handle *trans,
> >
> >       new_size -=3D sizeof(*ei0);
> >       ret =3D btrfs_search_slot(trans, root, &key, path,
> > -                             new_size + extra_size, 1);
> > +                             new_size + extra_size + sizeof(struct btr=
fs_item), 1);
>
> You are using an old kernel tree since convert_extent_item_v0 (and all
> v0) code for that matter has been removed from upstream. Rebase the
> patch on current misc-next
>
Sorry, I'll rebase. I didn't find misc-next, I think it's for-next right no=
w?

> >       if (ret < 0)
> >               return ret;
> >       BUG_ON(ret); /* Corruption */
> > @@ -1644,7 +1644,8 @@ int lookup_inline_extent_backref(struct btrfs_tra=
ns_handle *trans,
> >       }
> >
> >  again:
> > -     ret =3D btrfs_search_slot(trans, root, &key, path, extra_size, 1)=
;
> > +     ret =3D btrfs_search_slot(trans, root, &key, path,
> > +                         extra_size + sizeof(struct btrfs_item), 1);
>
> So you add the size of the struct btrfs_item but in case collision
> happens then the newly added code in btrfs_search_slot will negate this
> and the code will act as before the patch. Is my understanding correct?
>
Yes, checking all the places where ins_len > 0, only these two places
needs to be fix.
But I handled these two places incorrectly in this patch.

extra_size might be -1, and in this case I should not add
sizeof(struct btrfs_item);

I'll change to this

...
int ins_len
...

if (insert) {
    extra_size =3D btrfs_extent_inline_ref_size(want);
    ins_len =3D extra_size + sizeof(struct btrfs_item);
    ...
} else {
    extra_size =3D -1;
    ins_len =3D -1;
}

,,,
ret =3D btrfs_search_slot(trans, root, &key, path, ins_len, 1);

> >       if (ret < 0) {
> >               err =3D ret;
> >               goto out;
> > diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
> > index f9dd6d1..0b6c581 100644
> > --- a/fs/btrfs/file-item.c
> > +++ b/fs/btrfs/file-item.c
> > @@ -804,7 +804,7 @@ int btrfs_csum_file_blocks(struct btrfs_trans_handl=
e *trans,
> >        */
> >       btrfs_release_path(path);
> >       ret =3D btrfs_search_slot(trans, root, &file_key, path,
> > -                             csum_size, 1);
> > +                             csum_size + sizeof(struct btrfs_item), 1)=
;
> >       if (ret < 0)
> >               goto fail_unlock;
> >
> >

This code is wrong as well.
Reaching here means we got -EFBIG from btrfs_lookup_csum earlier in
btrfs_csum_file_blocks.
This indicates that we found a checksum item that ends at an offset
matching the start of the checksum range we want to insert. Therefore,
btrfs_search_slot won't find the item with file_key we want, so
sizeof(struct btrfs_item) is not needed here.

I'll resend v3 patch set.

thanks,
ethanwu
