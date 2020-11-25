Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 203222C3F49
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Nov 2020 12:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgKYLsX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Nov 2020 06:48:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgKYLsX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Nov 2020 06:48:23 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D877DC0613D4
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Nov 2020 03:48:22 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id f93so1324552qtb.10
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Nov 2020 03:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=X+O/phVo8iUZ8Z00IXhW5ThJ5AUA6N2MMuOUnkiqtAg=;
        b=Ewi7urdzSIHYgs2VeNhPnBLioTd4ix15mW1tt0ZrQ/v7uXyO7u92Wvb/5EIGyV7cls
         x6Q55Vvi4DXsRoDV1kOeuzs6Ujgl3LH56mKR+U2/zWjqO5zVnFZOa+X3DjiIUHE3AM3N
         Qxh13KLdyCKYXw2M8bzSb8TwmobbmrkrkAFdm9aCt9vbs+5rHNV862FmC5gCaxjvLh2J
         ObNJweyqT6ZNIpYZLE8VNTLOZnCnx+D7Rqclfu0PcLde3JnJFqp+A/QjIfIRWERKB51A
         /6SACsHlDtJan0tA/92xKdQtjtRd50Jcb6HcOG5Su2iKonl3cmBWsg5q6UrCSXGiv/Tz
         Gihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=X+O/phVo8iUZ8Z00IXhW5ThJ5AUA6N2MMuOUnkiqtAg=;
        b=BhjTsoZIvyO3wc2IXfDHOrixE/KPxth5SRXl2qzqGPk+y7ZLKOoRuAIMuDWCc+lZq+
         xKVv4EtUXA+rH1tfK53M4Ie+fLb6LEpKCBdFx0zkt7UJvmhqowZMUQ7lhEovOFdV4uuM
         y+/tkLlEWfCVWMdDDn5lq3EYiTgup/gYZXRV+qZ+oGWUi30Qk5F9d+xEBMNIQaswdoty
         PqDsNFkAJELoSETbtQU25qFwKYS3AHqiyBbWKOyNUOwqdvRRwRn0R1tkMjx98m9KQ0aT
         hlU6iBqXYmo2/Hvt3zB6UkcuAab+VJDS9ODdrm/FrSqjlK5wB+pKkuuR7kZCJMsbsD+e
         S3FQ==
X-Gm-Message-State: AOAM530HvKtVYBdx56HjIU3xMAIArg9xIuyMR8HtyyTUDACBpyDDnDf7
        7bS0Q3tpz/1Q8Z6FSeVmWmMPsQ7VYP0ZmJTTLTE=
X-Google-Smtp-Source: ABdhPJy2XNKQeKFgJf718oZJuFu6fVOZCUJg3OePKb7YVuw0mtlZo7kPudVFsNA8v38P/BhuQTOBXa16IRyK1O5LJDM=
X-Received: by 2002:a05:622a:109:: with SMTP id u9mr2495511qtw.213.1606304901850;
 Wed, 25 Nov 2020 03:48:21 -0800 (PST)
MIME-Version: 1.0
References: <20201124022036.2840981-1-ethanwu@synology.com>
 <CAL3q7H7oOwQs8OR31DdZm16YbU0KKjux_ZGuvQVjbDdePqk0AQ@mail.gmail.com> <CACKp3fmXQ1aB+evXcu04eYi9eXuEPvfq+oGgMgUb809neJHSRw@mail.gmail.com>
In-Reply-To: <CACKp3fmXQ1aB+evXcu04eYi9eXuEPvfq+oGgMgUb809neJHSRw@mail.gmail.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 25 Nov 2020 11:48:10 +0000
Message-ID: <CAL3q7H6rKZLw3VL4dgV-RTg3Zrh6_MrSO+VEwFCjzkzq4v4Lsw@mail.gmail.com>
Subject: Re: [PATCH 1/1] Btrfs: correctly calculate item size used when item
 key collision happends
To:     =?UTF-8?B?5ZCz5a2Q5p2w?= <ethan198912@gmail.com>
Cc:     ethanwu <ethanwu@synology.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 25, 2020 at 2:29 AM =E5=90=B3=E5=AD=90=E6=9D=B0 <ethan198912@gm=
ail.com> wrote:
>
> Filipe Manana <fdmanana@gmail.com> =E6=96=BC 2020=E5=B9=B411=E6=9C=8824=
=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=887:31=E5=AF=AB=E9=81=93=EF=BC=
=9A
> >
> > On Tue, Nov 24, 2020 at 4:39 AM ethanwu <ethanwu@synology.com> wrote:
> > >
> > > Item key collision is allowed for some item types, like dir item and
> > > inode refs, but the overall item size is limited by the leafsize.
> > >
> > > item size(ins_len) passed from btrfs_insert_empty_items to
> > > btrfs_search_slot already contains size of btrfs_item.
> > >
> > > When btrfs_search_slot reaches leaf, we'll see if we need to split le=
af.
> > > The check incorrectly reports that split leaf is required, because
> > > it treats the space required by the newly inserted item as
> > > btrfs_item + item data. But in item key collision case, only item dat=
a
> > > is actually needed, the newly inserted item could merge into the exis=
ting
> > > one. No new btrfs_item will be inserted.
> > >
> > > And split_leaf return -EOVERFLOW from following code:
> > > if (extend && data_size + btrfs_item_size_nr(l, slot) +
> > >     sizeof(struct btrfs_item) > BTRFS_LEAF_DATA_SIZE(fs_info))
> > >     return -EOVERFLOW;
> > >
> > > In most cases, when callers receive -EOVERFLOW, they either return
> > > this error or handle in different ways. For example, in normal dir it=
em
> > > creation the userspace will get errno EOVERFLOW; in inode ref case
> > > INODE_EXTREF is used instead.
> > >
> > > However, this is not the case for rename. To avoid the unrecoverable
> > > situation in rename, btrfs_check_dir_item_collision is called in
> > > early phase of rename. In this function, when item key collision is
> > > detected leaf space is checked:
> > >
> > > data_size =3D sizeof(*di) + name_len;
> > > if (data_size + btrfs_item_size_nr(leaf, slot) +
> > >     sizeof(struct btrfs_item) > BTRFS_LEAF_DATA_SIZE(root->fs_info))
> > >
> > > the sizeof(struct btrfs_item) + btrfs_item_size_nr(leaf, slot) here
> > > refers to existing item size, the condition here correctly calculate
> > > the needed size for collision case rather than the wrong case at
> > > above.
> > >
> > > The consequence of inconsistent condition check between
> > > btrfs_check_dir_item_collision and btrfs_search_slot when item key
> > > collision happens is that we might pass check here but fail
> > > later at btrfs_search_slot. Rename fails and volume is forced readonl=
y
> > >
> > > [436149.586170] ------------[ cut here ]------------
> > > [436149.586173] BTRFS: Transaction aborted (error -75)
> > > [436149.586196] WARNING: CPU: 0 PID: 16733 at fs/btrfs/inode.c:9870 b=
trfs_rename2+0x1938/0x1b70 [btrfs]
> > > [436149.586197] Modules linked in: btrfs zstd_compress xor raid6_pq u=
fs qnx4 hfsplus hfs minix ntfs msdos jfs xfs libcrc32c rpcsec_gss_krb5 core=
temp crct10dif_pclmul crc32_pclmul ghash_clmulni_intel pcbc aesni_intel aes=
_x86_64 vmw_balloon crypto_simd cryptd glue_helper joydev input_leds intel_=
rapl_perf serio_raw vmw_vmci mac_hid sch_fq_codel nfsd auth_rpcgss nfs_acl =
lockd grace sunrpc parport_pc ppdev lp parport ip_tables x_tables autofs4 v=
mwgfx ttm drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops drm =
psmouse mptspi mptscsih mptbase scsi_transport_spi ahci vmxnet3 libahci i2c=
_piix4 floppy pata_acpi
> > > [436149.586227] CPU: 0 PID: 16733 Comm: python Tainted: G      D     =
      4.18.0-rc5+ #1
> > > [436149.586228] Hardware name: VMware, Inc. VMware Virtual Platform/4=
40BX Desktop Reference Platform, BIOS 6.00 04/05/2016
> > > [436149.586238] RIP: 0010:btrfs_rename2+0x1938/0x1b70 [btrfs]
> > > [436149.586238] Code: 50 f0 48 0f ba a8 10 ce 00 00 02 72 27 41 83 f8=
 fb 74 6f 44 89 c6 48 c7 c7 48 09 85 c0 44 89 55 80 44 89 45 98 e8 f8 5e 4c=
 c5 <0f> 0b 44 8b 45 98 44 8b 55 80 44 89 55 80 44 89 c1 44 89 45 98 ba
> > > [436149.586254] RSP: 0018:ffffa327043a7ce0 EFLAGS: 00010286
> > > [436149.586255] RAX: 0000000000000000 RBX: ffff8d8a17d13340 RCX: 0000=
000000000006
> > > [436149.586256] RDX: 0000000000000007 RSI: 0000000000000096 RDI: ffff=
8d8a7fc164b0
> > > [436149.586257] RBP: ffffa327043a7da0 R08: 0000000000000560 R09: 7265=
282064657472
> > > [436149.586258] R10: 0000000000000000 R11: 6361736e61725420 R12: ffff=
8d8a0d4c8b08
> > > [436149.586258] R13: ffff8d8a17d13340 R14: ffff8d8a33e0a540 R15: 0000=
0000000001fe
> > > [436149.586260] FS:  00007fa313933740(0000) GS:ffff8d8a7fc00000(0000)=
 knlGS:0000000000000000
> > > [436149.586261] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [436149.586262] CR2: 000055d8d9c9a720 CR3: 000000007aae0003 CR4: 0000=
0000003606f0
> > > [436149.586295] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000=
000000000000
> > > [436149.586296] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000=
000000000400
> > > [436149.586296] Call Trace:
> > > [436149.586311]  vfs_rename+0x383/0x920
> > > [436149.586313]  ? vfs_rename+0x383/0x920
> > > [436149.586315]  do_renameat2+0x4ca/0x590
> > > [436149.586317]  __x64_sys_rename+0x20/0x30
> > > [436149.586324]  do_syscall_64+0x5a/0x120
> > > [436149.586330]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > > [436149.586332] RIP: 0033:0x7fa3133b1d37
> > > [436149.586332] Code: 75 12 48 89 df e8 89 60 09 00 85 c0 0f 95 c0 0f=
 b6 c0 f7 d8 5b c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 b8 52 00 00 00 0f=
 05 <48> 3d 00 f0 ff ff 77 09 f3 c3 0f 1f 80 00 00 00 00 48 8b 15 19 f1
> > > [436149.586348] RSP: 002b:00007fffd3e43908 EFLAGS: 00000246 ORIG_RAX:=
 0000000000000052
> > > [436149.586349] RAX: ffffffffffffffda RBX: 00007fa3133b1d30 RCX: 0000=
7fa3133b1d37
> > > [436149.586350] RDX: 000055d8da06b5e0 RSI: 000055d8da225d60 RDI: 0000=
55d8da2c4da0
> > > [436149.586351] RBP: 000055d8da2252f0 R08: 00007fa313782000 R09: 0000=
0000000177e0
> > > [436149.586351] R10: 000055d8da010680 R11: 0000000000000246 R12: 0000=
7fa313840b00
> > >
> > > Thanks to Hans van Kranenburg for information about crc32 hash collis=
ion tools,
> > > I was able to reproduce the dir item collision with following python =
script.
> > > https://github.com/wutzuchieh/misc_tools/blob/master/crc32_forge.py
> >
> > Great that you made a reproducer, thanks for that!
> >
> > So we should have a test case in fstests for this.
> > We want to catch future regressions.
> >
> > Do you think you can convert the test to fstests?
> >
> > That would mean converting it to bash and instead of generating the
> > names with a colliding crc32c hash at run time, use a list of
> > hardcoded names - which would have to be all printable characters
> > (a-z, A-Z, 0-9, _, -)
> > The filesystem in the test should be created with a node size of 64K,
> > so that the test runs on all architectures.
> > Running your script, for a node size of 64K, it took 1211 iterations
> > (file names) to hit the transaction abort.
> > To make the file name list shorter, try getting much longer file names
> > (200+ characters for e.g.).
> >
> > The alternative would be to add there a small C program to generate
> > names with colliding hashes.
> > In btrfs-progs you have btrfs-crc.c that does that, although slow, so
> > perhaps it could be a starting point:
> >
> > fdmanana 10:49:20 ~/git/hub/btrfs-progs ((v5.6.1))> make btrfs-crc
> >     [CC]     btrfs-crc.o
> > (...)
> > fdmanana 10:49:23 ~/git/hub/btrfs-progs ((v5.6.1))> ./btrfs-crc -c 1169=
177969
> >   1169177969 - =EF=BF=BDI=EF=BF=BDJ&+| =EF=BF=BD{=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BDgW<nTc
> > (...)
> >
> > Either way, it will give some work, so I understand if you are
> > reluctant to do it.
> >
>
> ok, I'll add a xfstests test for this case.

Thanks, very appreciated!

>
> > > Run it under a btrfs volume will trigger the abort transaction.
> > > It simply creates files and rename them to forged names that leads to
> > > hash collision.
> > >
> > > There are two ways to fix this. One is to simply revert the patch
> > > "878f2d2cb355 Btrfs: fix max dir item size calculation"
> > > to make the condition consistent although that patch is correct
> > > about the size.
> > >
> > > The other way is to handle the leaf space check correctly when
> > > collision happens. I prefer the second one since it correct leaf
> > > space check in collision case. This fix needs unify the usage of ins_=
len
> > > in btrfs_search_slot to contain btrfs_item anyway and adjust all call=
ers
> > > of btrfs_search_slot that intentionally pass ins_len without btrfs_it=
em
> > > size to add size of btrfs_item from now.
> > >
> > > Signed-off-by: ethanwu <ethanwu@synology.com>
> > > ---
> > >
> > > v3: modify comment for btrfs_search_lot parameter ins_len,
> > >     fix incorrect ins_len in lookup_inline_extent_backref and btrfs_c=
sum_file_blocks
> > >
> > >  fs/btrfs/ctree.c       | 16 ++++++++++++++--
> > >  fs/btrfs/extent-tree.c |  8 ++++++--
> > >  2 files changed, 20 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> > > index 32a57a70b98d..084b55d4c397 100644
> > > --- a/fs/btrfs/ctree.c
> > > +++ b/fs/btrfs/ctree.c
> > > @@ -2557,8 +2557,9 @@ static struct extent_buffer *btrfs_search_slot_=
get_root(struct btrfs_root *root,
> > >   * @p:         Holds all btree nodes along the search path
> > >   * @root:      The root node of the tree
> > >   * @key:       The key we are looking for
> > > - * @ins_len:   Indicates purpose of search, for inserts it is 1, for
> > > - *             deletions it's -1. 0 for plain searches
> > > + * @ins_len:   Indicates purpose of search, for inserts it is a posi=
tive
> > > + *             number (size of item inserted), for deletions it's a =
negative number and
> > > + *             0 for plain searches, not modifying the tree.
> >
> > Please mention that in case ins_len > 0, then the value must account
> > for sizeof(struct btrfs_item).
> >
>
> I'll added it to the comment, but there's one exception.
> In file-item.c: btrfs_csum_file_blocks
>
> ...
>     /*
>      * At this point, we know the tree has a checksum item that ends
> at an
>      * offset matching the start of the checksum range we want to
> insert.
>      * We try to extend that item as much as possible and then add as
> many
>      * checksums to it as they fit.
>      *
>      * First check if the leaf has enough free space for at least one
>      * checksum. If it has go directly to the item extension code,
> otherwise
>      * release the path and do a search for insertion before the
> extension.
>      */
>     if (btrfs_leaf_free_space(leaf) >=3D csum_size) {
>         btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
>         csum_offset =3D (bytenr - found_key.offset) >>
>             fs_info->sectorsize_bits;
>         goto extend_csum;
>     }
>
>     btrfs_release_path(path);
>     ret =3D btrfs_search_slot(trans, root, &file_key, path,
>                 csum_size, 1);
>     if (ret < 0)
>         goto out;
> ...
>
> We avoid adding the btrfs_item by merging it to the existing one if
> end offset of
> previous item matching the start of the checksum range we want to insert.
> i.e. the -EFBIG case
> In this case we don't need add sizeof btrfs_item into ins_len. Should
> I add a comment
> here or the above exiting comment already makes the purpose of
> btrfs_search_slot clear?

Ah I see, I wrote that comment some time ago.

So this change will break the expected behavior of btrfs_search_slot().

Before we were guaranteed that after btrfs_search_slot() returns 0 we
have at least the requested space in the leaf at path->nodes[0].
But now, by subtracting sizeof(btrfs item) from ins_len, that is not
the case anymore - we can return 0 and still not have enough space -
because we assume ins_len always accounts for btrfs_item (25 bytes).
For example we pass 4 as ins_len, the key already exists and the leaf
has only 3 bytes free:  4 - sizeof(btrfs_item) (25) < 3 - so we don't
call split_leaf() and return 0 with a leaf having only 3 bytes free.
The same happens in case ins_len happens to be >=3D sizeof(btrfs_item).

I see two options:

1) Revert that other commit and add a comment there about the extra
sizeof(btrfs_item). It's gonna be confusing;

2) Allow btrfs_search_slot() to known if ins_len accounts for
btrfs_item or not. Like adding a boolean (int:1 actually) to
btrfs_path named like 'search_for_extension', which is set to 1 when
ins_len does not account for btrfs_item and 0 when it does - so it
would only be set to 1 at btrfs_csum_file_blocks() - and at
btrfs_search_slot() decrement sizeof(btrfs_item) only if
path->search_for_extension is 0. Would need to check if there aren't
any other places like btrfs_csum_file_blocks() where they want to
extend an item but don't account for btrfs_item in ins_len. Then we
would do the ASSERT(ins_len >=3D sizeof(btrfs_item) when
path->search_for_extension is 0. May be simple after all.

Thanks!

>
> > >   * @cow:       boolean should CoW operations be performed. Must alwa=
ys be 1
> > >   *             when modifying the tree.
> > >   *
> > > @@ -2719,6 +2720,17 @@ int btrfs_search_slot(struct btrfs_trans_handl=
e *trans, struct btrfs_root *root,
> > >
> > >                 if (level =3D=3D 0) {
> > >                         p->slots[level] =3D slot;
> > > +                       /*
> > > +                        * item key collision happens. In this case, =
if we are allow
> >
> > item -> Item (start of sentence),  allow -> allowed
> >
> > > +                        * to insert the item(for example, in dir_ite=
m case, item key
> >
> > Please add a space before opening the parenthesis -> "item (for
> > example..." instead
> >
> > > +                        * collision is allowed), it will be merged w=
ith the original
> > > +                        * item. Only the item size grows, no new btr=
fs item will be
> > > +                        * added. Since the ins_len already accounts =
the size btrfs_item,
> > > +                        * this value is counted twice. Duduct this v=
alue here so the
> >
> > Duduct -> deduct
> >
> > > +                        * leaf space check will be correct.
> > > +                        */
> > > +                       if (ret =3D=3D 0 && ins_len > 0)
> > > +                               ins_len -=3D sizeof(struct btrfs_item=
);
> >
> > So lets add an assert to make sure ins_len is never less than
> > sizeof(struct btrfs_item).
> >
> > At the start of the function something like:
> >
> > if (ins_len > 0) ASSERT(ins_len >=3D sizeof(struct btrfs_item));
> >
> > Other than that, it looks good.
> > Thanks.
> >
>
> I'll modify the patch and resend V4 version, and thanks for correcting
> some grammar errors.
>
> > >                         if (ins_len > 0 &&
> > >                             btrfs_leaf_free_space(b) < ins_len) {
> > >                                 if (write_lock_level < 1) {
> > > diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> > > index fc942759a04c..ead62b7ba954 100644
> > > --- a/fs/btrfs/extent-tree.c
> > > +++ b/fs/btrfs/extent-tree.c
> > > @@ -830,6 +830,7 @@ int lookup_inline_extent_backref(struct btrfs_tra=
ns_handle *trans,
> > >         unsigned long ptr;
> > >         unsigned long end;
> > >         int extra_size;
> > > +       int ins_len;
> > >         int type;
> > >         int want;
> > >         int ret;
> > > @@ -844,9 +845,12 @@ int lookup_inline_extent_backref(struct btrfs_tr=
ans_handle *trans,
> > >         want =3D extent_ref_type(parent, owner);
> > >         if (insert) {
> > >                 extra_size =3D btrfs_extent_inline_ref_size(want);
> > > +               ins_len =3D extra_size + sizeof(struct btrfs_item);
> > >                 path->keep_locks =3D 1;
> > > -       } else
> > > +       } else {
> > >                 extra_size =3D -1;
> > > +               ins_len =3D -1;
> > > +       }
> > >
> > >         /*
> > >          * Owner is our level, so we can just add one to get the leve=
l for the
> > > @@ -858,7 +862,7 @@ int lookup_inline_extent_backref(struct btrfs_tra=
ns_handle *trans,
> > >         }
> > >
> > >  again:
> > > -       ret =3D btrfs_search_slot(trans, root, &key, path, extra_size=
, 1);
> > > +       ret =3D btrfs_search_slot(trans, root, &key, path, ins_len, 1=
);
> > >         if (ret < 0) {
> > >                 err =3D ret;
> > >                 goto out;
> > > --
> > > 2.25.1
> > >
> >
> >
> > --
> > Filipe David Manana,
> >
> > =E2=80=9CWhether you think you can, or you think you can't =E2=80=94 yo=
u're right.=E2=80=9D



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
