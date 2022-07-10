Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA5356CFA4
	for <lists+linux-btrfs@lfdr.de>; Sun, 10 Jul 2022 17:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiGJPHZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 10 Jul 2022 11:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGJPHY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 10 Jul 2022 11:07:24 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A2A64E7;
        Sun, 10 Jul 2022 08:07:22 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id s16-20020a056830149000b0061c47ed7755so1025711otq.9;
        Sun, 10 Jul 2022 08:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Xx3IW60PiM/kk65JgHOXdGXF3xEjQI2L5RhginSCzW4=;
        b=qIAgpHmLUgpAPXm6meQvGxPAVtN4cU7IeNFNHtOhigLJhrR1U/t37Apf4RZMGZVv9a
         XGspAue3e3U3W9AAMOcwXa9QGy52jY4E5sCapDv87EOzz2LxreyVv6ofI6Kv8ibaTpft
         fJfjtXtwCLy2ZrE6kBV1xwJKrc+4LY0KPg240F+iCTKaPVPTxN5ITr1aDxoT5dw66tbB
         +Xk0e7LFN3+MGihFFn+QLsTuhTT4qySuiwqMMoUUA7Wcq2Kcf2ZpMS23+u5KyTPfybhH
         DFN+dpTzI9rgp/RoUMIGo3TJc7QuG7zYkB1Q5pBMhaTX/EXzo7GuPntBVMHpf3qxwmwo
         dS/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Xx3IW60PiM/kk65JgHOXdGXF3xEjQI2L5RhginSCzW4=;
        b=LNIFhMLrvPKMkk9hVOi9tM93f4AKLXFrURsJb3fWcUw7o8GpNCtfyT4GaYECsuzy9Z
         xp8R9JQErlngyuOCJEzzz6dPL1s+FsdLl0GxBaOaGRBnziC1lhc6U5wb/W1LeimmONyx
         gFNWbP2pNUf/Ll8+Kb38e8SKR/HwND+5SFNBNmpfaHjZ8OV+6EmtNxC9wtD5/+ZVn1Pb
         84bju8ksNLKsq2KinZcrNlbeGP/orhhjR1QQ57gNHm31/FMM2/tAwmADuoB7e5SNMZD7
         KZu+HQFpmM34AnV6zw6FXi4Iugo8IwrcgWqKbwDOsNvdJlvWZ7x17Aq2z5pQ00ZgdXrK
         6OCw==
X-Gm-Message-State: AJIora9DgG5oRUSOFw7EqIWcBU6c2KtOIBwwdU+g8gH9nSvIttAcWhJM
        PlupXGA9Wt8DbCeJuHKQ3bg5UxMPfdhKmAIe1telr3PRqxsz+A==
X-Google-Smtp-Source: AGRyM1uRWINY9eHkqxDHqc44/1Jn0avoNYW+YyGCXuMI+L26Dzd0p0jVonnRJsmHBl0p+RnF2+DKmetIsRbzJy16eXs=
X-Received: by 2002:a9d:77c9:0:b0:616:ceb8:1776 with SMTP id
 w9-20020a9d77c9000000b00616ceb81776mr5498938otl.256.1657465641944; Sun, 10
 Jul 2022 08:07:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220706130903.1661-1-bingjingc@synology.com> <20220706130903.1661-3-bingjingc@synology.com>
 <20220706160357.GA826504@falcondesktop>
In-Reply-To: <20220706160357.GA826504@falcondesktop>
From:   bingjing chang <bxxxjxxg@gmail.com>
Date:   Sun, 10 Jul 2022 23:07:10 +0800
Message-ID: <CAMmgxWE5Ph4hF7d1N8M1btf2FsFro6mBsQDDf=Cx8szeg207vQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] btrfs: send: fix a bug that sending a link command on
 existing file path
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     bingjingc <bingjingc@synology.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Robbie Ko <robbieko@synology.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Filipe,

Thank you for the review and comments. It really helps.
I will submit a patch v2 to fix the problems.

Filipe Manana <fdmanana@kernel.org> =E6=96=BC 2022=E5=B9=B47=E6=9C=887=E6=
=97=A5 =E9=80=B1=E5=9B=9B =E5=87=8C=E6=99=A812:04=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> On Wed, Jul 06, 2022 at 09:09:03PM +0800, bingjingc wrote:
> > From: BingJing Chang <bingjingc@synology.com>
> >
> > btrfs_ioctl_send processes recorded btrfs_keys in a defined order. (Fir=
st,
> > we process a btrfs_key with a samller objectid. If btrfs_keys have the =
same
> > objectid, then we compare their types and offsets accordingly.)
>
> That's a very convoluted way to simply say that send processes keys in th=
e order
> they are found in the btrees, from the leftmost to the rightmost.
>
> > However,
> > reference paths for an inode can be stored in either BTRFS_INODE_REF_KE=
Y
> > btrfs_keys or BTRFS_INODE_EXTREF_KEY btrfs_keys. And due to the limitat=
ion
> > of the helper function - iterate_inode_ref, we can only iterate the ent=
ries
> > of ONE btrfs_inode_ref or btrfs_inode_extref. That is, there must be a =
bug
> > in processing the same reference paths, which are stored in different w=
ays.
>
> When you say "there must be a bug", you want to say "there is a bug", and=
 then
> explain what the bug is.
>
> However the bug has nothing to do with the order of how keys are processe=
d.
>
> What happens is that when we are processing an inode we go over all refer=
ences
> and add all the new names to the "new_refs" list and add all the deleted =
names
> to the "deleted_refs" list.
>
> Then in the end, when we finish processing the inode, we iterate over all=
 the
> new names in the "new_refs" list and send link commands for those names. =
After
> that we go over all the names in the "deleted_refs" list and send unlink =
commands
> for those names.
>
> The problem in this case, is that we have names duplicated in both lists.
> So we try to create them before we remove them, therefore the receiver ge=
ts an
> -EEXIST error when trying the link operations.
>

Yes, the problem happens when we have names duplicated in both lists.
And with the current logics in process_recorded_refs(), we will issue
links on existing files.

I will try to make the description clear in patch v2.

> >
> > Here is an exmple that btrfs_ioctl_send will send a link command on an
>
> exmple -> example
>
> > existing file path:
> >
> >   $ btrfs subvolume create test
> >
> >   # create a file and 2000 hard links to the same inode
> >   $ dd if=3D/dev/zero of=3Dtest/1M bs=3D1M count=3D1
>
> touch test/1M
>
> The data is completely irrelevant here, all we care about are the
> hard links of the file. Making the reproducer the minimum necessary
> to trigger a bug, makes it much less distracting and easier to grasp.
>
> >   $ for i in {1..2000}; do link test/1M test/$i ; done
> >
> >   # take a snapshot for parent snapshot
> >   $ btrfs sub snap -r test snap1
> >
> >   # remove 2000 hard links and re-create the last 1000 links
> >   $ for i in {1..2000}; do rm test/$i; done;
> >   $ for i in {1001..2000}; do link test/1M test/$i; done
> >
> >   # take another one for sned snapshot
>
> sned -> send
>
> >   $ btrfs sub snap -r test snap2
> >
> >   $ mkdir tmp
> >   $ btrfs send -e snap2 -p snap1 | btrfs receive tmp/
>
> The -e is not necessary.
>
> >   At subvol snap2
> >   link 1238 -> 1M
> >   ERROR: link 1238 -> 1M failed: File exists
> >
> > In the parent snapshot snap1, reference paths 1 - 1237 are stored in a
> > INODE_REF item and the rest ones are stored in other INODE_EXTREF items=
.
> > But in the send snapshot snap2, all reference paths can be stored withi=
n a
> > INODE_REF item. During the send process, btrfs_ioctl_send will process =
the
> > INODE_REF item first. Then it found that reference paths 1 - 1000 were
> > gone in the send snapshot, so it recorded them in sctx->deleted_refs fo=
r
> > unlink. And it found that reference paths 1238 - 2000 were new paths in
> > the send snapshot, so it recorded them in sctx->new_refs for link. Sinc=
e
> > we do not load all contents of its INODE_EXTREF items to make compariso=
n,
> > afterwards, btrfs_ioctl_send may make a mistake sending a link command =
on
> > an existing file path.
>
> So this explanation is not correct, it's neither about the names being st=
ored
> in an INODE_REF or INODE_EXTREF item nor about processing one item before=
 or
> after the other. As mentioned before, it's because we always process the
> "new_refs" list before the "deleted_refs" list, and in this case we have =
the
> same names (paths) in both lists.
>

Sorry, I didn't make this paragraph easy to understand.
Here, I want to address that there is already a function find_iref(), which
can be used to check duplications. But it has limitations.

For this example, we delete 2000 files and recreate 1000 files. Not all of
the 2000 file paths are added to the "deleted_refs" list. And not all of
the 1000 re-created file paths are added to the "new_refs" list. With
find_iref(), when processing inode references, {1001..1237} are not added
to any lists because they appear in both inode references. Afterwards,
two lists contain items as below:
"new_refs" list: {1238..2000}
"deleted_refs" list: {1..1000} + {1238..2000}
Therefore, there are duplicated items {1238..2000} in both lists. It result=
s
in link failure.

> >
> > To fix the bug, we can either remove the duplicated items both in
> > sctx->new_refs and sctx->deleted_refs before generating link/unlink
> > commands or prevent them from being added into list. Both of them requi=
re
> > efficient data structures like C++ sets to look up duplicated items.
>
> There's a much more obvious alternative, which is processing first the
> "deleted_refs" list before the "new_refs" list.
>
> It's inefficient because we do a bunch of unlinks followed by links for
> the same paths. On the other hand, it does not require maintaining two
> new rbtrees and allocating memory for records in these rbtrees.
>

Thank you for mentioning this. I will describe the intuition idea and the
difficulties. I was unable to reshuffle the processing order. If someone ca=
n
do this, we are glad to pick that solution.

> Plus this type of scenario should be very rare. It requires having at lea=
st
> hundreds of hard links in an inode in order to trigger the creation of ex=
tended
> references, and then removing and recreating a bunch of those hard links =
in the
> send snapshot. How common is that?
>
> Is this a case you got into in some user workload, or was it found by rea=
ding
> and inspecting the code?
>

It's not common. But it happened in the real world. Some version backup
applications seem to use large hard links for some purposes.

> I would like to have in the changelog this alternative mentioned, and if =
it's
> not good, then explain why it is not, and why we must follow a different =
solution.
>

> It's probably not easy, because at process_recorded_refs() when we unlink=
 we
> need to know if any ancestor was orphanized before, which we figure out w=
hen
> we iterate over the "new_refs" list. So it would likely need some reshuff=
ling
> in the logic of how we do things there.
>
> > And
> > we also need to take two scenarios into consideration. One is the most
> > common case that one inode has only one reference path. The other is th=
e
> > worst case that there are ten thousands of hard links of an inode.
> > (BTRFS_LINK_MAX is 65536) So we'd like to introduce rbtree to store the
> > computing references. (The tree depth of the worst cases is just 16. An=
d
>
> computing -> computed
>
> > it takes less memory to store few entries than hash sets.) And in order
> > not to occupy too much moemory, we also introduce
>
> moemory -> memory
>
> > __record_new_ref_if_needed() and __record_deleted_ref_if_needed() for
> > changed_ref() to check and remove the duplications early.
>
> Also, the subject:
>
> "btrfs: send: fix a bug that sending a link command on existing file path=
"
>
> sounds a bit awkward, mostly because of the "that".
> Something like the following would be more concise:
>
> "btrfs: send: fix sending link commands for existing file paths"
>
> >
> > Reviewed-by: Robbie Ko <robbieko@synology.com>
> > Signed-off-by: BingJing Chang <bingjingc@synology.com>
> > ---
> >  fs/btrfs/send.c | 160 ++++++++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 156 insertions(+), 4 deletions(-)
> >
> > diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> > index 420a86720aa2..23ae631ef23b 100644
> > --- a/fs/btrfs/send.c
> > +++ b/fs/btrfs/send.c
> > @@ -234,6 +234,9 @@ struct send_ctx {
> >        * Indexed by the inode number of the directory to be deleted.
> >        */
> >       struct rb_root orphan_dirs;
> > +
> > +     struct rb_root rbtree_new_refs;
> > +     struct rb_root rbtree_deleted_refs;
> >  };
> >
> >  struct pending_dir_move {
> > @@ -2747,6 +2750,8 @@ struct recorded_ref {
> >       u64 dir;
> >       u64 dir_gen;
> >       int name_len;
> > +     struct rb_node node;
> > +     struct rb_root *root;
> >  };
> >
> >  static struct recorded_ref *recorded_ref_alloc(void)
> > @@ -2756,6 +2761,7 @@ static struct recorded_ref *recorded_ref_alloc(vo=
id)
> >       ref =3D kzalloc(sizeof(*ref), GFP_KERNEL);
> >       if (!ref)
> >               return NULL;
> > +     RB_CLEAR_NODE(&ref->node);
> >       INIT_LIST_HEAD(&ref->list);
> >       return ref;
> >  }
> > @@ -2764,6 +2770,8 @@ static void recorded_ref_free(struct recorded_ref=
 *ref)
> >  {
> >       if (!ref)
> >               return;
> > +     if (!RB_EMPTY_NODE(&ref->node))
> > +             rb_erase(&ref->node, ref->root);
> >       list_del(&ref->list);
> >       fs_path_free(ref->full_path);
> >       kfree(ref);
> > @@ -4373,12 +4381,152 @@ static int __record_deleted_ref(int num, u64 d=
ir, int index,
> >                         &sctx->deleted_refs);
> >  }
> >
> > +static int rbtree_ref_comp(const void *k, const struct rb_node *node)
> > +{
> > +     const struct recorded_ref *data =3D k;
> > +     const struct recorded_ref *ref =3D rb_entry(node, struct recorded=
_ref, node);
> > +     int result;
> > +
> > +     if (data->dir > ref->dir)
> > +             return 1;
> > +     if (data->dir < ref->dir)
> > +             return -1;
> > +     if (data->dir_gen > ref->dir_gen)
> > +             return 1;
> > +     if (data->dir_gen < ref->dir_gen)
> > +             return -1;
> > +     if (data->name_len > ref->name_len)
> > +             return 1;
> > +     if (data->name_len < ref->name_len)
> > +             return -1;
> > +     result =3D strcmp(data->name, ref->name);
> > +     if (result > 0)
> > +             return 1;
> > +     if (result < 0)
> > +             return -1;
> > +     return 0;
> > +}
> > +
> > +static bool rbtree_ref_less(struct rb_node *node, const struct rb_node=
 *parent)
> > +{
> > +     const struct recorded_ref *entry =3D rb_entry(node,
> > +                                                 struct recorded_ref,
> > +                                                 node);
> > +
> > +     return rbtree_ref_comp(entry, parent) < 0;
> > +}
> > +
> > +static int record_ref2(struct rb_root *root, struct list_head *refs,
>
> This is a terrible function name.
>
> If we end up with this solution, please rename it to something more clear
> like record_ref_in_tree() for example. Almost anything other than an exis=
ting
> function name followed by a number is a better choice.
>

Thank you for the naming.

> This bug is a very good finding, and has been around since forever.
>
> Thanks.
>
> > +                          struct fs_path *name, u64 dir, u64 dir_gen,
> > +                          struct send_ctx *sctx)
> > +{
> > +     int ret =3D 0;
> > +     struct fs_path *path =3D NULL;
> > +     struct recorded_ref *ref =3D NULL;
> > +
> > +     path =3D fs_path_alloc();
> > +     if (!path) {
> > +             ret =3D -ENOMEM;
> > +             goto out;
> > +     }
> > +
> > +     ref =3D recorded_ref_alloc();
> > +     if (!ref) {
> > +             ret =3D -ENOMEM;
> > +             goto out;
> > +     }
> > +
> > +     ret =3D get_cur_path(sctx, dir, dir_gen, path);
> > +     if (ret < 0)
> > +             goto out;
> > +     ret =3D fs_path_add_path(path, name);
> > +     if (ret < 0)
> > +             goto out;
> > +
> > +     ref->dir =3D dir;
> > +     ref->dir_gen =3D dir_gen;
> > +     set_ref_path(ref, path);
> > +     list_add_tail(&ref->list, refs);
> > +     rb_add(&ref->node, root, rbtree_ref_less);
> > +     ref->root =3D root;
> > +out:
> > +     if (ret) {
> > +             if (path && (!ref || !ref->full_path))
> > +                     fs_path_free(path);
> > +             recorded_ref_free(ref);
> > +     }
> > +     return ret;
> > +}
> > +
> > +static int __record_new_ref_if_needed(int num, u64 dir, int index,
> > +                                   struct fs_path *name, void *ctx)
> > +{
> > +     int ret =3D 0;
> > +     struct send_ctx *sctx =3D ctx;
> > +     struct rb_node *node =3D NULL;
> > +     struct recorded_ref data;
> > +     struct recorded_ref *ref;
> > +     u64 dir_gen;
> > +
> > +     ret =3D get_inode_info(sctx->send_root, dir, NULL, &dir_gen, NULL=
,
> > +                          NULL, NULL, NULL);
> > +     if (ret < 0)
> > +             goto out;
> > +
> > +     data.dir =3D dir;
> > +     data.dir_gen =3D dir_gen;
> > +     set_ref_path(&data, name);
> > +     node =3D rb_find(&data, &sctx->rbtree_deleted_refs, rbtree_ref_co=
mp);
> > +     if (node) {
> > +             ref =3D rb_entry(node, struct recorded_ref, node);
> > +             recorded_ref_free(ref);
> > +     } else {
> > +             ret =3D record_ref2(&sctx->rbtree_new_refs, &sctx->new_re=
fs,
> > +                               name, dir, dir_gen, sctx);
> > +     }
> > +out:
> > +     return ret;
> > +}
> > +
> > +static int __record_deleted_ref_if_needed(int num, u64 dir, int index,
> > +                         struct fs_path *name,
> > +                         void *ctx)
> > +{
> > +     int ret =3D 0;
> > +     struct send_ctx *sctx =3D ctx;
> > +     struct rb_node *node =3D NULL;
> > +     struct recorded_ref data;
> > +     struct recorded_ref *ref;
> > +     u64 dir_gen;
> > +
> > +     ret =3D get_inode_info(sctx->parent_root, dir, NULL, &dir_gen, NU=
LL,
> > +                          NULL, NULL, NULL);
> > +     if (ret < 0)
> > +             goto out;
> > +
> > +     data.dir =3D dir;
> > +     data.dir_gen =3D dir_gen;
> > +     set_ref_path(&data, name);
> > +     node =3D rb_find(&data, &sctx->rbtree_new_refs, rbtree_ref_comp);
> > +     if (node) {
> > +             ref =3D rb_entry(node, struct recorded_ref, node);
> > +             recorded_ref_free(ref);
> > +     } else {
> > +             ret =3D record_ref2(&sctx->rbtree_deleted_refs,
> > +                               &sctx->deleted_refs, name, dir, dir_gen=
,
> > +                               sctx);
> > +     }
> > +out:
> > +     return ret;
> > +}
> > +
> >  static int record_new_ref(struct send_ctx *sctx)
> >  {
> >       int ret;
> >
> >       ret =3D iterate_inode_ref(sctx->send_root, sctx->left_path,
> > -                             sctx->cmp_key, 0, __record_new_ref, sctx)=
;
> > +                             sctx->cmp_key, 0, __record_new_ref_if_nee=
ded,
> > +                             sctx);
> >       if (ret < 0)
> >               goto out;
> >       ret =3D 0;
> > @@ -4392,7 +4540,8 @@ static int record_deleted_ref(struct send_ctx *sc=
tx)
> >       int ret;
> >
> >       ret =3D iterate_inode_ref(sctx->parent_root, sctx->right_path,
> > -                             sctx->cmp_key, 0, __record_deleted_ref, s=
ctx);
> > +                             sctx->cmp_key, 0,
> > +                             __record_deleted_ref_if_needed, sctx);
> >       if (ret < 0)
> >               goto out;
> >       ret =3D 0;
> > @@ -4475,7 +4624,7 @@ static int __record_changed_new_ref(int num, u64 =
dir, int index,
> >       ret =3D find_iref(sctx->parent_root, sctx->right_path,
> >                       sctx->cmp_key, dir, dir_gen, name);
> >       if (ret =3D=3D -ENOENT)
> > -             ret =3D __record_new_ref(num, dir, index, name, sctx);
> > +             ret =3D __record_new_ref_if_needed(num, dir, index, name,=
 sctx);
> >       else if (ret > 0)
> >               ret =3D 0;
> >
> > @@ -4498,7 +4647,8 @@ static int __record_changed_deleted_ref(int num, =
u64 dir, int index,
> >       ret =3D find_iref(sctx->send_root, sctx->left_path, sctx->cmp_key=
,
> >                       dir, dir_gen, name);
> >       if (ret =3D=3D -ENOENT)
> > -             ret =3D __record_deleted_ref(num, dir, index, name, sctx)=
;
> > +             ret =3D __record_deleted_ref_if_needed(num, dir, index, n=
ame,
> > +                                                  sctx);
> >       else if (ret > 0)
> >               ret =3D 0;
> >
> > @@ -7576,6 +7726,8 @@ long btrfs_ioctl_send(struct inode *inode, struct=
 btrfs_ioctl_send_args *arg)
> >       sctx->pending_dir_moves =3D RB_ROOT;
> >       sctx->waiting_dir_moves =3D RB_ROOT;
> >       sctx->orphan_dirs =3D RB_ROOT;
> > +     sctx->rbtree_new_refs =3D RB_ROOT;
> > +     sctx->rbtree_deleted_refs =3D RB_ROOT;
> >
> >       sctx->clone_roots =3D kvcalloc(sizeof(*sctx->clone_roots),
> >                                    arg->clone_sources_count + 1,
> > --
> > 2.37.0
> >
