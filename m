Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD2D76E3ED
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Aug 2023 11:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233403AbjHCJGs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Aug 2023 05:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbjHCJGq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Aug 2023 05:06:46 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1992A2
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Aug 2023 02:06:45 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1bba254a7d4so460262fac.2
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Aug 2023 02:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691053605; x=1691658405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZPkFCL3mz/LW5mqlUEWpWoYN+kFFxt/SI72ldDCXwu4=;
        b=jfg3W82uB0gGs1lbt6WlW07BJnWPH+vqzJKqnfhtfTn+qJbahxG3kFrXL79u9lPVYn
         pqHOXeKuCa0rW8b9cj0ejwkoRvCNWmlwYI4IvVeNjLMxJrFxZMnHMfHM07QqyHJV/n6H
         vYir1lt+ZeqkqXrZra102lwNtZv0lpqPSN2cJzpMclCPDUg7Y9qxDqfPOzF2fxdpa7zV
         YCV/W2bZiPPevdVuRmZ9+2gaD/MGTA/1qdpyBM8BFGM2ieGGHFwuHdBjQRmyh+9zu52P
         A+RKtjHQsl9ROIjd5SMNJVR4+h5r9iC1ZSfl0Ushy8YiVfFbGCiXfs0yio53C6ijNgnt
         hnCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691053605; x=1691658405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZPkFCL3mz/LW5mqlUEWpWoYN+kFFxt/SI72ldDCXwu4=;
        b=jplukPSMK0oZ6E05svU0j3zjEO4FgXsq7n9KmJrG82DnHkCiXrYxQgeUw8704O3AbQ
         BSuzX7BYIoQbgJOJK9oJAHtLs9pKKQ00P+WcNxdzg++PCLtfE6lP7MZmsW7CrGm7PYPn
         mivTKR8b9Bt5j4oYqnEkV0oLrYEY6atbd1cs/Wf4fagCstZRbONojKGCG1h6o3ESISc4
         yCG0z/wvFh/JiOYCD69cFoYqP7SI2jXVGJzJJg2/kox74puyfyDxMgVFZShYzm+a7q3L
         btm3GbDyOY8BtlMML8hf80skETVl9DEtCXjyQDS0Odjs2DPzUYT76tU6heeeLTOqVRGL
         gRNQ==
X-Gm-Message-State: ABy/qLaw0FOUFZr1FuJEmLLB0Cs8MKJtTVck9+CQ/nLWAVyHO/ipwGk3
        0nctsfnJXlJUpV9tx9DTnfORcwOzV1PTkt18scg=
X-Google-Smtp-Source: APBJJlFrKqEHfjD+g1FfZXhavzeMmS5xP/fIXk4oh9fCbObyBWunyOvVlpkb9h8+K20IfgUo46IBUcqCd2SLL9IHE20=
X-Received: by 2002:a05:6870:568e:b0:1b0:5141:4c6e with SMTP id
 p14-20020a056870568e00b001b051414c6emr20534057oao.26.1691053604820; Thu, 03
 Aug 2023 02:06:44 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1691042474.git.wqu@suse.com> <b54f02c1204998a7dfa4e284af07f96365b99467.1691042474.git.wqu@suse.com>
In-Reply-To: <b54f02c1204998a7dfa4e284af07f96365b99467.1691042474.git.wqu@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 3 Aug 2023 10:06:08 +0100
Message-ID: <CAL3q7H78BWeDhh1tkEM==sRbgPiAx=y4EeiQQiXfXjNmvqfCZw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] btrfs: exit gracefully if reloc roots don't match
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        syzbot+ae97a827ae1c3336bbb4@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 3, 2023 at 7:40=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> Syzbot reported a crash that an ASSERT() got triggered inside
> prepare_to_merge().
>
> [CAUSE]
> The root cause of the triggered ASSERT() is we can have a race between
> quota tree creation and relocation.
>
> This leads us to create a duplicated quota tree in the
> btrfs_read_fs_root() path, and since it's treated as fs tree, it would
> have ROOT_SHAREABLE flag, causing us to create a reloc tree for it.
>
> The bug itself is fixed by a dedicated patch for it, but this already
> taught us the ASSERT() is not something straightforward for
> developers.
>
> [ENHANCEMENT]
> Instead of using an ASSERT(), let's handle it gracefully and output
> extra info about the mismatch reloc roots to help debug.
>
> Also with the above ASSERT() removed, we can trigger ASSERT(0)s inside
> merge_reloc_roots() later.
> Also replace those ASSERT(0)s with WARN_ON()s.
>
> Reported-by: syzbot+ae97a827ae1c3336bbb4@syzkaller.appspotmail.com
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/relocation.c | 44 +++++++++++++++++++++++++++++++++++--------
>  1 file changed, 36 insertions(+), 8 deletions(-)
>
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 9db2e6fa2cb2..28139a47c227 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -1916,7 +1916,38 @@ int prepare_to_merge(struct reloc_control *rc, int=
 err)
>                                 err =3D PTR_ERR(root);
>                         break;
>                 }
> -               ASSERT(root->reloc_root =3D=3D reloc_root);
> +
> +               if (unlikely(root->reloc_root !=3D reloc_root)) {
> +                       if (root->reloc_root)
> +                               btrfs_err(fs_info,
> +"reloc tree mismatch, root %lld has reloc root key (%lld %u %llu) gen %l=
lu, expect reloc root key (%lld, %u, %llu) gen %llu",

My comment about printing the key elements with commas still remains,
there's still one key printed as "(%lld, %u, %llu)" while
the other cases don't use the commas.

Otherwise it looks good, thanks.

> +                                         root->root_key.objectid,
> +                                         root->reloc_root->root_key.obje=
ctid,
> +                                         root->reloc_root->root_key.type=
,
> +                                         root->reloc_root->root_key.offs=
et,
> +                                         btrfs_root_generation(
> +                                                 &root->reloc_root->root=
_item),
> +                                         reloc_root->root_key.objectid,
> +                                         reloc_root->root_key.type,
> +                                         reloc_root->root_key.offset,
> +                                         btrfs_root_generation(
> +                                                 &reloc_root->root_item)=
);
> +                       else
> +                               btrfs_err(fs_info,
> +"reloc tree mismatch, root %lld has no reloc root, expect reloc root key=
 (%lld %u %llu) gen %llu",
> +                                         root->root_key.objectid,
> +                                         reloc_root->root_key.objectid,
> +                                         reloc_root->root_key.type,
> +                                         reloc_root->root_key.offset,
> +                                         btrfs_root_generation(
> +                                                 &reloc_root->root_item)=
);
> +                       list_add(&reloc_root->root_list, &reloc_roots);
> +                       btrfs_put_root(root);
> +                       btrfs_abort_transaction(trans, -EUCLEAN);
> +                       if (!err)
> +                               err =3D -EUCLEAN;
> +                       break;
> +               }
>
>                 /*
>                  * set reference count to 1, so btrfs_recover_relocation
> @@ -1989,7 +2020,7 @@ void merge_reloc_roots(struct reloc_control *rc)
>                 root =3D btrfs_get_fs_root(fs_info, reloc_root->root_key.=
offset,
>                                          false);
>                 if (btrfs_root_refs(&reloc_root->root_item) > 0) {
> -                       if (IS_ERR(root)) {
> +                       if (WARN_ON(IS_ERR(root))) {
>                                 /*
>                                  * For recovery we read the fs roots on m=
ount,
>                                  * and if we didn't find the root then we=
 marked
> @@ -1998,17 +2029,14 @@ void merge_reloc_roots(struct reloc_control *rc)
>                                  * memory.  However there's no reason we =
can't
>                                  * handle the error properly here just in=
 case.
>                                  */
> -                               ASSERT(0);
>                                 ret =3D PTR_ERR(root);
>                                 goto out;
>                         }
> -                       if (root->reloc_root !=3D reloc_root) {
> +                       if (WARN_ON(root->reloc_root !=3D reloc_root)) {
>                                 /*
> -                                * This is actually impossible without so=
mething
> -                                * going really wrong (like weird race co=
ndition
> -                                * or cosmic rays).
> +                                * This can happen if on-disk metadata ha=
s some
> +                                * corruption, e.g. bad reloc tree key of=
fset.
>                                  */
> -                               ASSERT(0);
>                                 ret =3D -EINVAL;
>                                 goto out;
>                         }
> --
> 2.41.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
