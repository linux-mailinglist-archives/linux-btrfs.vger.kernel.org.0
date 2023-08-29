Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 116D578C312
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Aug 2023 13:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbjH2LFk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Aug 2023 07:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233361AbjH2LFJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Aug 2023 07:05:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA50C3
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Aug 2023 04:05:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C5036551F
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Aug 2023 11:05:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 732EDC433CA
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Aug 2023 11:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693307100;
        bh=4VEGpbZUVjANxgaN8q/atnCmx4ZfU+Jj4IRT9n9gfXo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EObg6sFmLMKsXIdKiyF4FJLPdY7+LAB+TX+iDc02K54cPWuQfIxVOACssLNja2LfZ
         AkQ2qiulWV8K3X9i5var+wG8O3QlMB4XUCCmzhqeP3cCeMBH7+FtXCA4L4wv235gOq
         0HzpkbLUipt/xasmv26NT2TY6rpw46XwZTcs6st8Xv1tv7huLhCsszmElmbz1MSxJn
         wldbTfC6s0poRmExblDEveeKuDam2uCkl/6+86kR7JkP2X1G5PfcHl0QH/m166KnRc
         Ev65U7z9VnoFiS2InIFqKwFD9eYitb7u6uaCjO9qiZCW4JxpNhJm9HfnHul/QpwGid
         iKb8xz0BGnN4Q==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5717f7b932aso2626409eaf.0
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Aug 2023 04:05:00 -0700 (PDT)
X-Gm-Message-State: AOJu0YwPrnk7pwNE2NsEI/hcyLjULClS+WBiNSohIiPegAaXzHrcj9hn
        ++A1bUZn9BBaVpgBC6G3pgoUx0hrtfeH4sytLis=
X-Google-Smtp-Source: AGHT+IGtUU4bmpIVTAKrmo1C7G0z8Qebqt3h8b1r0JfTcihSdoOfO1hzmmx8QCQwXVceeE6MUgV7m/BTiao5xovkr1o=
X-Received: by 2002:a4a:6c1d:0:b0:56c:8d61:f66f with SMTP id
 q29-20020a4a6c1d000000b0056c8d61f66fmr14364657ooc.2.1693307099512; Tue, 29
 Aug 2023 04:04:59 -0700 (PDT)
MIME-Version: 1.0
References: <44e189b505bff8ae9d281a7765141563d6dee3bb.1693271263.git.wqu@suse.com>
 <ZO3MmTSkdN1kq2va@debian0.Home> <a1f5976d-a297-4421-be3c-f5611d1b60dd@suse.com>
In-Reply-To: <a1f5976d-a297-4421-be3c-f5611d1b60dd@suse.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Tue, 29 Aug 2023 12:04:23 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5EoADt8X5i945ucinX945GRVXFunWUDf3A7LOTWZ3J_g@mail.gmail.com>
Message-ID: <CAL3q7H5EoADt8X5i945ucinX945GRVXFunWUDf3A7LOTWZ3J_g@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: qgroup: pre-allocate btrfs_qgroup to reduce
 GFP_ATOMIC usage
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 29, 2023 at 11:59=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
>
>
> On 2023/8/29 18:46, Filipe Manana wrote:
> > On Tue, Aug 29, 2023 at 09:08:08AM +0800, Qu Wenruo wrote:
> >> Qgroup is the heaviest user of GFP_ATOMIC, but one call site does not
> >> really need GFP_ATOMIC, that is add_qgroup_rb().
> >>
> >> That function only search the rb tree to find if we already have such
> >> tree.
> >> If there is no such tree, then it would try to allocate memory for it.
> >>
> >> This means we can afford to pre-allocate such structure unconditionall=
y,
> >> then free the memory if it's not needed.
> >>
> >> Considering this function is not a hot path, only utilized by the
> >> following functions:
> >>
> >> - btrfs_qgroup_inherit()
> >>    For "btrfs subvolume snapshot -i" option.
> >>
> >> - btrfs_read_qgroup_config()
> >>    At mount time, and we're ensured there would be no existing rb tree
> >>    entry for each qgroup.
> >>
> >> - btrfs_create_qgroup()
> >>
> >> Thus we're completely safe to pre-allocate the extra memory for btrfs_=
qgroup
> >> structure, and reduce unnecessary GFP_ATOMIC usage.
> >>
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >> ---
> >> Changelog:
> >> v2:
> >> - Loose the GFP flag for btrfs_read_qgroup_config()
> >>    At that stage we can go GFP_KERNEL instead of GFP_NOFS.
> >>
> >> - Do not mark qgroup inconsistent if memory allocation failed at
> >>    btrfs_qgroup_inherit()
> >>    At the very beginning, if we hit -ENOMEM, we haven't done anything,
> >>    thus qgroup is still consistent.
> >> ---
> >>   fs/btrfs/qgroup.c | 79 ++++++++++++++++++++++++++++++++-------------=
--
> >>   1 file changed, 54 insertions(+), 25 deletions(-)
> >>
> >> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> >> index b99230db3c82..2a3da93fd266 100644
> >> --- a/fs/btrfs/qgroup.c
> >> +++ b/fs/btrfs/qgroup.c
> >> @@ -182,28 +182,31 @@ static struct btrfs_qgroup *find_qgroup_rb(struc=
t btrfs_fs_info *fs_info,
> >>
> >>   /* must be called with qgroup_lock held */
> >>   static struct btrfs_qgroup *add_qgroup_rb(struct btrfs_fs_info *fs_i=
nfo,
> >> +                                      struct btrfs_qgroup *prealloc,
> >>                                        u64 qgroupid)
> >>   {
> >>      struct rb_node **p =3D &fs_info->qgroup_tree.rb_node;
> >>      struct rb_node *parent =3D NULL;
> >>      struct btrfs_qgroup *qgroup;
> >>
> >> +    /* Caller must have pre-allocated @prealloc. */
> >> +    ASSERT(prealloc);
> >> +
> >>      while (*p) {
> >>              parent =3D *p;
> >>              qgroup =3D rb_entry(parent, struct btrfs_qgroup, node);
> >>
> >> -            if (qgroup->qgroupid < qgroupid)
> >> +            if (qgroup->qgroupid < qgroupid) {
> >>                      p =3D &(*p)->rb_left;
> >> -            else if (qgroup->qgroupid > qgroupid)
> >> +            } else if (qgroup->qgroupid > qgroupid) {
> >>                      p =3D &(*p)->rb_right;
> >> -            else
> >> +            } else {
> >> +                    kfree(prealloc);
> >>                      return qgroup;
> >> +            }
> >>      }
> >>
> >> -    qgroup =3D kzalloc(sizeof(*qgroup), GFP_ATOMIC);
> >> -    if (!qgroup)
> >> -            return ERR_PTR(-ENOMEM);
> >> -
> >> +    qgroup =3D prealloc;
> >>      qgroup->qgroupid =3D qgroupid;
> >>      INIT_LIST_HEAD(&qgroup->groups);
> >>      INIT_LIST_HEAD(&qgroup->members);
> >> @@ -434,11 +437,15 @@ int btrfs_read_qgroup_config(struct btrfs_fs_inf=
o *fs_info)
> >>                      qgroup_mark_inconsistent(fs_info);
> >>              }
> >>              if (!qgroup) {
> >> -                    qgroup =3D add_qgroup_rb(fs_info, found_key.offse=
t);
> >> -                    if (IS_ERR(qgroup)) {
> >> -                            ret =3D PTR_ERR(qgroup);
> >> +                    struct btrfs_qgroup *prealloc =3D NULL;
> >> +
> >> +                    prealloc =3D kzalloc(sizeof(*prealloc), GFP_KERNE=
L);
> >> +                    if (!prealloc) {
> >> +                            ret =3D -ENOMEM;
> >>                              goto out;
> >>                      }
> >> +                    qgroup =3D add_qgroup_rb(fs_info, prealloc, found=
_key.offset);
> >> +                    prealloc =3D NULL;
> >>              }
> >>              ret =3D btrfs_sysfs_add_one_qgroup(fs_info, qgroup);
> >>              if (ret < 0)
> >> @@ -959,6 +966,7 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_in=
fo)
> >>      struct btrfs_key key;
> >>      struct btrfs_key found_key;
> >>      struct btrfs_qgroup *qgroup =3D NULL;
> >> +    struct btrfs_qgroup *prealloc =3D NULL;
> >>      struct btrfs_trans_handle *trans =3D NULL;
> >>      struct ulist *ulist =3D NULL;
> >>      int ret =3D 0;
> >> @@ -1094,6 +1102,15 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs=
_info)
> >>                      /* Release locks on tree_root before we access qu=
ota_root */
> >>                      btrfs_release_path(path);
> >>
> >> +                    /* We should not have a stray @prealloc pointer. =
*/
> >> +                    ASSERT(prealloc =3D=3D NULL);
> >> +                    prealloc =3D kzalloc(sizeof(*prealloc), GFP_NOFS)=
;
> >> +                    if (!prealloc) {
> >> +                            ret =3D -ENOMEM;
> >> +                            btrfs_abort_transaction(trans, ret);
> >> +                            goto out_free_path;
> >> +                    }
> >> +
> >>                      ret =3D add_qgroup_item(trans, quota_root,
> >>                                            found_key.offset);
> >>                      if (ret) {
> >> @@ -1101,7 +1118,8 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_=
info)
> >>                              goto out_free_path;
> >>                      }
> >>
> >> -                    qgroup =3D add_qgroup_rb(fs_info, found_key.offse=
t);
> >> +                    qgroup =3D add_qgroup_rb(fs_info, prealloc, found=
_key.offset);
> >> +                    prealloc =3D NULL;
> >>                      if (IS_ERR(qgroup)) {
> >>                              ret =3D PTR_ERR(qgroup);
> >>                              btrfs_abort_transaction(trans, ret);
> >> @@ -1144,12 +1162,14 @@ int btrfs_quota_enable(struct btrfs_fs_info *f=
s_info)
> >>              goto out_free_path;
> >>      }
> >>
> >> -    qgroup =3D add_qgroup_rb(fs_info, BTRFS_FS_TREE_OBJECTID);
> >> -    if (IS_ERR(qgroup)) {
> >> -            ret =3D PTR_ERR(qgroup);
> >> -            btrfs_abort_transaction(trans, ret);
> >> +    ASSERT(prealloc =3D=3D NULL);
> >> +    prealloc =3D kzalloc(sizeof(*prealloc), GFP_NOFS);
> >> +    if (!prealloc) {
> >> +            ret =3D -ENOMEM;
> >>              goto out_free_path;
> >>      }
> >> +    qgroup =3D add_qgroup_rb(fs_info, prealloc, BTRFS_FS_TREE_OBJECTI=
D);
> >> +    prealloc =3D NULL;
> >>      ret =3D btrfs_sysfs_add_one_qgroup(fs_info, qgroup);
> >>      if (ret < 0) {
> >>              btrfs_abort_transaction(trans, ret);
> >> @@ -1222,6 +1242,7 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_=
info)
> >>      else if (trans)
> >>              ret =3D btrfs_end_transaction(trans);
> >>      ulist_free(ulist);
> >> +    kfree(prealloc);
> >>      return ret;
> >>   }
> >>
> >> @@ -1608,6 +1629,7 @@ int btrfs_create_qgroup(struct btrfs_trans_handl=
e *trans, u64 qgroupid)
> >>      struct btrfs_fs_info *fs_info =3D trans->fs_info;
> >>      struct btrfs_root *quota_root;
> >>      struct btrfs_qgroup *qgroup;
> >> +    struct btrfs_qgroup *prealloc =3D NULL;
> >>      int ret =3D 0;
> >>
> >>      mutex_lock(&fs_info->qgroup_ioctl_lock);
> >> @@ -1622,21 +1644,25 @@ int btrfs_create_qgroup(struct btrfs_trans_han=
dle *trans, u64 qgroupid)
> >>              goto out;
> >>      }
> >>
> >> +    prealloc =3D kzalloc(sizeof(*prealloc), GFP_NOFS);
> >> +    if (!prealloc) {
> >> +            ret =3D -ENOMEM;
> >> +            goto out;
> >> +    }
> >> +
> >>      ret =3D add_qgroup_item(trans, quota_root, qgroupid);
> >>      if (ret)
> >>              goto out;
> >>
> >>      spin_lock(&fs_info->qgroup_lock);
> >> -    qgroup =3D add_qgroup_rb(fs_info, qgroupid);
> >> +    qgroup =3D add_qgroup_rb(fs_info, prealloc, qgroupid);
> >>      spin_unlock(&fs_info->qgroup_lock);
> >> +    prealloc =3D NULL;
> >>
> >> -    if (IS_ERR(qgroup)) {
> >> -            ret =3D PTR_ERR(qgroup);
> >> -            goto out;
> >> -    }
> >>      ret =3D btrfs_sysfs_add_one_qgroup(fs_info, qgroup);
> >>   out:
> >>      mutex_unlock(&fs_info->qgroup_ioctl_lock);
> >> +    kfree(prealloc);
> >>      return ret;
> >>   }
> >>
> >> @@ -2906,10 +2932,15 @@ int btrfs_qgroup_inherit(struct btrfs_trans_ha=
ndle *trans, u64 srcid,
> >>      struct btrfs_root *quota_root;
> >>      struct btrfs_qgroup *srcgroup;
> >>      struct btrfs_qgroup *dstgroup;
> >> +    struct btrfs_qgroup *prealloc =3D NULL;
> >
> > This initialization is not needed, since we never read prealloc before
> > the allocation below.
>
> This is mostly for consistency and static checkers.
>
> I'm pretty sure compiler is able to optimize it out.

It's not about compiler optimizations, or being too picky.
It's about some tools producing warnings for cases like this one.
See the following example:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D966de47ff0c9e64d74e1719e4480b7c34f6190fa

>
> Thanks,
> Qu
> >
> > With that fixed:
> >
> > Reviewed-by: Filipe Manana <fdmanana@suse.com>
> >
> > Thanks.
> >
> >>      bool need_rescan =3D false;
> >>      u32 level_size =3D 0;
> >>      u64 nums;
> >>
> >> +    prealloc =3D kzalloc(sizeof(*prealloc), GFP_NOFS);
> >> +    if (!prealloc)
> >> +            return -ENOMEM;
> >> +
> >>      /*
> >>       * There are only two callers of this function.
> >>       *
> >> @@ -2987,11 +3018,8 @@ int btrfs_qgroup_inherit(struct btrfs_trans_han=
dle *trans, u64 srcid,
> >>
> >>      spin_lock(&fs_info->qgroup_lock);
> >>
> >> -    dstgroup =3D add_qgroup_rb(fs_info, objectid);
> >> -    if (IS_ERR(dstgroup)) {
> >> -            ret =3D PTR_ERR(dstgroup);
> >> -            goto unlock;
> >> -    }
> >> +    dstgroup =3D add_qgroup_rb(fs_info, prealloc, objectid);
> >> +    prealloc =3D NULL;
> >>
> >>      if (inherit && inherit->flags & BTRFS_QGROUP_INHERIT_SET_LIMITS) =
{
> >>              dstgroup->lim_flags =3D inherit->lim.flags;
> >> @@ -3102,6 +3130,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_hand=
le *trans, u64 srcid,
> >>              mutex_unlock(&fs_info->qgroup_ioctl_lock);
> >>      if (need_rescan)
> >>              qgroup_mark_inconsistent(fs_info);
> >> +    kfree(prealloc);
> >>      return ret;
> >>   }
> >>
> >> --
> >> 2.41.0
> >>
