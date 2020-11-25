Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 021742C36CF
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Nov 2020 03:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgKYC3q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Nov 2020 21:29:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725952AbgKYC3p (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Nov 2020 21:29:45 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB66C0613D4
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Nov 2020 18:29:45 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id f17so996370pge.6
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Nov 2020 18:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lWPcLxWGa4y8VPtq6zDLnr8g9nr0wDunbdd5kYXZo8I=;
        b=JgvR7eGqMGMxFK7HfOL61fAX7EnoDvVQdYRBAle77+lukoePgm44xDIg381to/4siC
         kd+xrBpCBzuhNo2hXT2e0e7JNiL89iTvpQVR8ZUraIs3UCUT2/vFQo62m0FrqYpvhGiI
         i57z8oBdQpPlg8MNKO44SWKqJqB/c1vlTY/CicBwfA8gtaqcfRqVPkIfAj48+dd8FxFo
         s7R/V7e3ENT0ErRqGbTbszwZM7jIr5QUIoGQcXwWAMhUwoX8jEsU9csDaUa0TJGyhFU6
         7NAVqDndP0aiady2Hmri9Y3Ik3Z3DuRP8jGmPytNg0EAoJfgabFp47/t5NBXLEcO6P0x
         qiRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lWPcLxWGa4y8VPtq6zDLnr8g9nr0wDunbdd5kYXZo8I=;
        b=WaHMYD+R5cdHotn0T/G8TAJd1AlRkOA1FQCEc3nIlLxgcMYfES1r4ep/1B9fUAyOeF
         lxIErt3JmI2liTqUIQxfZCq1j7QGhks6USeoKL0SFrqg42Yo0wE3t26CSqg12n5R0cGJ
         gocl1hEhKQA1nuq1ygcJSt7lvO5rOS1j0Ux4JxdYlaND4m2v+4MXCwpiFeyP+78jU3vO
         oAjAjpGGW/QOhhU4w+U7AUnyXSS1Wn1gSJqdlnMXR0xaFNBsCmFxDVAZj2BYQgRS/5G0
         4yssyI0BjC72hmSKpSXS7vbjjd36KxbGdPO5eq8jFKTcab+9O7HGkupK5lVC7iW8u3Wp
         4v9A==
X-Gm-Message-State: AOAM531Wx1F935vCmcfwVhZS9EaSX76JukZR9BB9As9HY/xOYkISnJx2
        xH2iP4V362NT2cSZIOv7Qud5aDfaBQuRGTo40k0=
X-Google-Smtp-Source: ABdhPJzo+h2HT7AM+9ZhiaWzbrjtu+5PFYKrhhFIMJ7IFZOp2uodzkDMIA2PeuBjlxnF4d0GxMWYRyDGCNFRdHPKirs=
X-Received: by 2002:a63:985:: with SMTP id 127mr1154761pgj.449.1606271384942;
 Tue, 24 Nov 2020 18:29:44 -0800 (PST)
MIME-Version: 1.0
References: <20201124022036.2840981-1-ethanwu@synology.com> <CAL3q7H7oOwQs8OR31DdZm16YbU0KKjux_ZGuvQVjbDdePqk0AQ@mail.gmail.com>
In-Reply-To: <CAL3q7H7oOwQs8OR31DdZm16YbU0KKjux_ZGuvQVjbDdePqk0AQ@mail.gmail.com>
From:   =?UTF-8?B?5ZCz5a2Q5p2w?= <ethan198912@gmail.com>
Date:   Wed, 25 Nov 2020 10:29:34 +0800
Message-ID: <CACKp3fmXQ1aB+evXcu04eYi9eXuEPvfq+oGgMgUb809neJHSRw@mail.gmail.com>
Subject: Re: [PATCH 1/1] Btrfs: correctly calculate item size used when item
 key collision happends
To:     fdmanana@gmail.com
Cc:     ethanwu <ethanwu@synology.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Filipe Manana <fdmanana@gmail.com> =E6=96=BC 2020=E5=B9=B411=E6=9C=8824=E6=
=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=887:31=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Tue, Nov 24, 2020 at 4:39 AM ethanwu <ethanwu@synology.com> wrote:
> >
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
>
> Great that you made a reproducer, thanks for that!
>
> So we should have a test case in fstests for this.
> We want to catch future regressions.
>
> Do you think you can convert the test to fstests?
>
> That would mean converting it to bash and instead of generating the
> names with a colliding crc32c hash at run time, use a list of
> hardcoded names - which would have to be all printable characters
> (a-z, A-Z, 0-9, _, -)
> The filesystem in the test should be created with a node size of 64K,
> so that the test runs on all architectures.
> Running your script, for a node size of 64K, it took 1211 iterations
> (file names) to hit the transaction abort.
> To make the file name list shorter, try getting much longer file names
> (200+ characters for e.g.).
>
> The alternative would be to add there a small C program to generate
> names with colliding hashes.
> In btrfs-progs you have btrfs-crc.c that does that, although slow, so
> perhaps it could be a starting point:
>
> fdmanana 10:49:20 ~/git/hub/btrfs-progs ((v5.6.1))> make btrfs-crc
>     [CC]     btrfs-crc.o
> (...)
> fdmanana 10:49:23 ~/git/hub/btrfs-progs ((v5.6.1))> ./btrfs-crc -c 116917=
7969
>   1169177969 - =EF=BF=BDI=EF=BF=BDJ&+| =EF=BF=BD{=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BDgW<nTc
> (...)
>
> Either way, it will give some work, so I understand if you are
> reluctant to do it.
>

ok, I'll add a xfstests test for this case.

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
> > Signed-off-by: ethanwu <ethanwu@synology.com>
> > ---
> >
> > v3: modify comment for btrfs_search_lot parameter ins_len,
> >     fix incorrect ins_len in lookup_inline_extent_backref and btrfs_csu=
m_file_blocks
> >
> >  fs/btrfs/ctree.c       | 16 ++++++++++++++--
> >  fs/btrfs/extent-tree.c |  8 ++++++--
> >  2 files changed, 20 insertions(+), 4 deletions(-)
> >
> > diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> > index 32a57a70b98d..084b55d4c397 100644
> > --- a/fs/btrfs/ctree.c
> > +++ b/fs/btrfs/ctree.c
> > @@ -2557,8 +2557,9 @@ static struct extent_buffer *btrfs_search_slot_ge=
t_root(struct btrfs_root *root,
> >   * @p:         Holds all btree nodes along the search path
> >   * @root:      The root node of the tree
> >   * @key:       The key we are looking for
> > - * @ins_len:   Indicates purpose of search, for inserts it is 1, for
> > - *             deletions it's -1. 0 for plain searches
> > + * @ins_len:   Indicates purpose of search, for inserts it is a positi=
ve
> > + *             number (size of item inserted), for deletions it's a ne=
gative number and
> > + *             0 for plain searches, not modifying the tree.
>
> Please mention that in case ins_len > 0, then the value must account
> for sizeof(struct btrfs_item).
>

I'll added it to the comment, but there's one exception.
In file-item.c: btrfs_csum_file_blocks

...
    /*
     * At this point, we know the tree has a checksum item that ends
at an
     * offset matching the start of the checksum range we want to
insert.
     * We try to extend that item as much as possible and then add as
many
     * checksums to it as they fit.
     *
     * First check if the leaf has enough free space for at least one
     * checksum. If it has go directly to the item extension code,
otherwise
     * release the path and do a search for insertion before the
extension.
     */
    if (btrfs_leaf_free_space(leaf) >=3D csum_size) {
        btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
        csum_offset =3D (bytenr - found_key.offset) >>
            fs_info->sectorsize_bits;
        goto extend_csum;
    }

    btrfs_release_path(path);
    ret =3D btrfs_search_slot(trans, root, &file_key, path,
                csum_size, 1);
    if (ret < 0)
        goto out;
...

We avoid adding the btrfs_item by merging it to the existing one if
end offset of
previous item matching the start of the checksum range we want to insert.
i.e. the -EFBIG case
In this case we don't need add sizeof btrfs_item into ins_len. Should
I add a comment
here or the above exiting comment already makes the purpose of
btrfs_search_slot clear?

> >   * @cow:       boolean should CoW operations be performed. Must always=
 be 1
> >   *             when modifying the tree.
> >   *
> > @@ -2719,6 +2720,17 @@ int btrfs_search_slot(struct btrfs_trans_handle =
*trans, struct btrfs_root *root,
> >
> >                 if (level =3D=3D 0) {
> >                         p->slots[level] =3D slot;
> > +                       /*
> > +                        * item key collision happens. In this case, if=
 we are allow
>
> item -> Item (start of sentence),  allow -> allowed
>
> > +                        * to insert the item(for example, in dir_item =
case, item key
>
> Please add a space before opening the parenthesis -> "item (for
> example..." instead
>
> > +                        * collision is allowed), it will be merged wit=
h the original
> > +                        * item. Only the item size grows, no new btrfs=
 item will be
> > +                        * added. Since the ins_len already accounts th=
e size btrfs_item,
> > +                        * this value is counted twice. Duduct this val=
ue here so the
>
> Duduct -> deduct
>
> > +                        * leaf space check will be correct.
> > +                        */
> > +                       if (ret =3D=3D 0 && ins_len > 0)
> > +                               ins_len -=3D sizeof(struct btrfs_item);
>
> So lets add an assert to make sure ins_len is never less than
> sizeof(struct btrfs_item).
>
> At the start of the function something like:
>
> if (ins_len > 0) ASSERT(ins_len >=3D sizeof(struct btrfs_item));
>
> Other than that, it looks good.
> Thanks.
>

I'll modify the patch and resend V4 version, and thanks for correcting
some grammar errors.

> >                         if (ins_len > 0 &&
> >                             btrfs_leaf_free_space(b) < ins_len) {
> >                                 if (write_lock_level < 1) {
> > diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> > index fc942759a04c..ead62b7ba954 100644
> > --- a/fs/btrfs/extent-tree.c
> > +++ b/fs/btrfs/extent-tree.c
> > @@ -830,6 +830,7 @@ int lookup_inline_extent_backref(struct btrfs_trans=
_handle *trans,
> >         unsigned long ptr;
> >         unsigned long end;
> >         int extra_size;
> > +       int ins_len;
> >         int type;
> >         int want;
> >         int ret;
> > @@ -844,9 +845,12 @@ int lookup_inline_extent_backref(struct btrfs_tran=
s_handle *trans,
> >         want =3D extent_ref_type(parent, owner);
> >         if (insert) {
> >                 extra_size =3D btrfs_extent_inline_ref_size(want);
> > +               ins_len =3D extra_size + sizeof(struct btrfs_item);
> >                 path->keep_locks =3D 1;
> > -       } else
> > +       } else {
> >                 extra_size =3D -1;
> > +               ins_len =3D -1;
> > +       }
> >
> >         /*
> >          * Owner is our level, so we can just add one to get the level =
for the
> > @@ -858,7 +862,7 @@ int lookup_inline_extent_backref(struct btrfs_trans=
_handle *trans,
> >         }
> >
> >  again:
> > -       ret =3D btrfs_search_slot(trans, root, &key, path, extra_size, =
1);
> > +       ret =3D btrfs_search_slot(trans, root, &key, path, ins_len, 1);
> >         if (ret < 0) {
> >                 err =3D ret;
> >                 goto out;
> > --
> > 2.25.1
> >
>
>
> --
> Filipe David Manana,
>
> =E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you'=
re right.=E2=80=9D
