Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71D64CD913
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Mar 2022 17:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237547AbiCDQ06 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Mar 2022 11:26:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240778AbiCDQ05 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Mar 2022 11:26:57 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2251C3D11
        for <linux-btrfs@vger.kernel.org>; Fri,  4 Mar 2022 08:26:09 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id n11so7786458qtk.8
        for <linux-btrfs@vger.kernel.org>; Fri, 04 Mar 2022 08:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=m79mACAosM0YV+5LEMo5W+dczEUnLhRoNG+WwSCajcs=;
        b=XzGmQj1cRSX15qiuV0hVdFlrnO4rmNfyNVJw5ytZqxJulfzCnMXyiuBQVU74Y6t9xn
         CjGu5FnXH/32ed9PXMTTLbSW17m+WPQPTSD5fFIWunM9TflyAWYpHgL1W5xFMOdHrzQY
         /+iR+qMpB8CJFfoHmNDvjYG3Mzh4orVJUYDf9E7lc8QgIWazhTyloLYM8hepc98AWRH5
         uD5rABscxSuoebrNpfdNLhN9x8VfzwMikZKVq+0xF2YPu1uTYz3jEJP8amqWJZ1G/sSS
         8dk4rqBy0Zz4Bn+dnZB7l3NGRNFyJITx4Ck8lWpq6GTCauSMywdF+TcEk6TvogRRUyFU
         Ayww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=m79mACAosM0YV+5LEMo5W+dczEUnLhRoNG+WwSCajcs=;
        b=caZeLdpnVEB9mS8CGKxEBbNY83JxiyqxjS45qPRzbcb3Lm8cmwRwOKeKjj9JRLeL1t
         0w5MbKllcWyxqCYxBKnPycDjPe7vat2dZhNBG2WFPZMxHA4jB2o26C+NZP8kTj55FqSP
         kuI186NiTqQ61/CX6roVq7t8o7TSCOTNV78Jrls0S7yprGgmNN75G0pffZqg0Z2FVF5K
         7x0CdfPmv8SRHlkiaNQt3yGWc0zxuwu+O195CikpJsahLoGbIe3NvhZzY2ucAOgMJNHz
         x+bWuRhPYARmkgWnc6rdHPcjkSHIHgZxa9kLkhRTDPmA6ksqE2Ok2kI0liY2LpeNiXEU
         IvoA==
X-Gm-Message-State: AOAM532CgzVHFpCLlwDEmhURCZf20UKHBuEAXdLp3s4etVr2W+qhYNQo
        R8ybATeijVrDr6r/AfmEqK+cVllc+O6FezBfOgceAErfmzI=
X-Google-Smtp-Source: ABdhPJynwr6+1ui1lfkWYG6tNsbByq1w1tzTK5eG489s5iluEOOC24XzVf7tDY+bRSQge9nbUqLUN0FkWXsOdnuiGF0=
X-Received: by 2002:a05:622a:110:b0:2dd:461a:6126 with SMTP id
 u16-20020a05622a011000b002dd461a6126mr32665423qtw.379.1646411167913; Fri, 04
 Mar 2022 08:26:07 -0800 (PST)
MIME-Version: 1.0
References: <cover.1645515599.git.wqu@suse.com> <1040e11d4075c8e61158126c5ddc2ee803a86143.1645515599.git.wqu@suse.com>
In-Reply-To: <1040e11d4075c8e61158126c5ddc2ee803a86143.1645515599.git.wqu@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 4 Mar 2022 16:25:31 +0000
Message-ID: <CAL3q7H5CsrCN61zUY1-Vf5aEb6uJu9u2MdNSZtP1aEmyYi1TQA@mail.gmail.com>
Subject: Re: [PATCH 3/3] btrfs: check extent buffer owner against the owner rootid
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 22, 2022 at 7:42 AM Qu Wenruo <wqu@suse.com> wrote:
>
> Btrfs doesn't really check whether the tree block really respects the
> root owner.
>
> This means, if a tree block referred by a parent in extent tree, but has
> owner of 5, btrfs can still continue reading the tree block, as long as
> it doesn't trigger other sanity checks.
>
> Normally this is fine, but combined with the empty tree check in
> check_leaf(), if we hit an empty extent tree, but the root node has
> csum tree owner, we can let such extent buffer to sneak in.
>
> Shrink the hole by:
>
> - Do extra eb owner check at tree read time
>
> - Make sure the root owner extent buffer exactly match the root id.
>
> Unfortunately we can't yet completely patch the hole, there are several
> call sites can't pass all info we need:
>
> - For reloc/log trees
>   Their owner is key::offset, not key::objectid.
>   We need the full root key to do that accurate check.
>
>   For now, we just skip the ownership check for those trees.
>
> - For add_data_references() of relocation
>   That call site doesn't have any parent/ownership info, as all the
>   bytenrs are all from btrfs_find_all_leafs().
>
>   Thankfully, btrfs_find_all_leafs() still do the ownership check,
>   and even for the read_tree_block() caller inside
>   add_data_references(), we know that all tree blocks there are
>   subvolume tree blocks.
>   Just manually convert root_owner 0 to FS_TREE to continue the check.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/ctree.c        |  6 +++++
>  fs/btrfs/disk-io.c      | 21 +++++++++++++++
>  fs/btrfs/tree-checker.c | 57 +++++++++++++++++++++++++++++++++++++++++
>  fs/btrfs/tree-checker.h |  1 +
>  4 files changed, 85 insertions(+)
>
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index 0eecf98d0abb..d904fe0973bd 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -16,6 +16,7 @@
>  #include "volumes.h"
>  #include "qgroup.h"
>  #include "tree-mod-log.h"
> +#include "tree-checker.h"
>
>  static int split_node(struct btrfs_trans_handle *trans, struct btrfs_roo=
t
>                       *root, struct btrfs_path *path, int level);
> @@ -1443,6 +1444,11 @@ read_block_for_search(struct btrfs_root *root, str=
uct btrfs_path *p,
>                         btrfs_release_path(p);
>                         return -EIO;
>                 }
> +               if (btrfs_check_eb_owner(tmp, root->root_key.objectid)) {
> +                       free_extent_buffer(tmp);
> +                       btrfs_release_path(p);
> +                       return -EUCLEAN;
> +               }
>                 *eb_ret =3D tmp;
>                 return 0;
>         }
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 8165ee3ae8a5..018a230efca5 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -1109,6 +1109,10 @@ struct extent_buffer *read_tree_block(struct btrfs=
_fs_info *fs_info, u64 bytenr,
>                 free_extent_buffer_stale(buf);
>                 return ERR_PTR(ret);
>         }
> +       if (btrfs_check_eb_owner(buf, owner_root)) {
> +               free_extent_buffer_stale(buf);
> +               return ERR_PTR(-EUCLEAN);
> +       }
>         return buf;
>
>  }
> @@ -1548,6 +1552,23 @@ static struct btrfs_root *read_tree_root_path(stru=
ct btrfs_root *tree_root,
>                 ret =3D -EIO;
>                 goto fail;
>         }
> +
> +       /*
> +        * For real fs, and not log/reloc trees, root owner must
> +        * match its root node owner
> +        */
> +       if (!test_bit(BTRFS_FS_STATE_DUMMY_FS_INFO, &fs_info->fs_state) &=
&
> +           root->root_key.objectid !=3D BTRFS_TREE_LOG_OBJECTID &&
> +           root->root_key.objectid !=3D BTRFS_TREE_RELOC_OBJECTID &&
> +           root->root_key.objectid !=3D btrfs_header_owner(root->node)) =
{
> +               btrfs_crit(fs_info,
> +"root=3D%llu block=3D%llu, tree root owner mismatch, have %llu expect %l=
lu",
> +                          root->root_key.objectid, root->node->start,
> +                          btrfs_header_owner(root->node),
> +                          root->root_key.objectid);
> +               ret =3D -EUCLEAN;
> +               goto fail;
> +       }
>         root->commit_root =3D btrfs_root_node(root);
>         return root;
>  fail:
> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> index 2c1072923590..f50bde52f466 100644
> --- a/fs/btrfs/tree-checker.c
> +++ b/fs/btrfs/tree-checker.c
> @@ -1855,3 +1855,60 @@ int btrfs_check_node(struct extent_buffer *node)
>         return ret;
>  }
>  ALLOW_ERROR_INJECTION(btrfs_check_node, ERRNO);
> +
> +int btrfs_check_eb_owner(struct extent_buffer *eb, u64 root_owner)
> +{
> +       bool is_subvol =3D is_fstree(root_owner);
> +       const u64 eb_owner =3D btrfs_header_owner(eb);
> +
> +       /*
> +        * Skip dummy fs, as selftest doesn't bother to create unique ebs=
 for
> +        * each dummy root.
> +        */
> +       if (test_bit(BTRFS_FS_STATE_DUMMY_FS_INFO, &eb->fs_info->fs_state=
))
> +               return 0;
> +
> +       /*
> +        * Those trees uses key.offset as their owner, our callers don't
> +        * have the extra capacity to pass key.offset here.
> +        * So we just skip those trees.
> +        */
> +       if (root_owner =3D=3D BTRFS_TREE_LOG_OBJECTID ||
> +           root_owner =3D=3D BTRFS_TREE_RELOC_OBJECTID)
> +               return 0;
> +
> +       /*
> +        * This happens for add_data_references() of balance, at that cal=
l site
> +        * we don't have owner info.
> +        * But we know all tree blocks there are subvolume tree blocks.
> +        */
> +       if (root_owner =3D=3D 0)
> +               is_subvol =3D true;
> +
> +       if (!is_subvol) {
> +               /* For non-subvolume trees, the eb owner should match roo=
t owner */
> +               if (root_owner !=3D eb_owner) {
> +                       btrfs_crit(eb->fs_info,
> +"corrupted %s, root=3D%llu block=3D%llu owner mismatch, have %llu expect=
 %llu",
> +                               btrfs_header_level(eb) =3D=3D 0 ? "leaf" =
: "node",
> +                               root_owner, btrfs_header_bytenr(eb), eb_o=
wner,
> +                               root_owner);
> +                       return -EUCLEAN;
> +               }
> +               return 0;
> +       }
> +
> +       /*
> +        * For subvolume trees, owner can mismatch, but they should all b=
elong
> +        * to subvolume trees.
> +        */
> +       if (is_subvol !=3D is_fstree(eb_owner)) {
> +               btrfs_crit(eb->fs_info,
> +"corrupted %s, root=3D%llu block=3D%llu owner mismatch, have %llu expect=
 [%llu, %llu]",
> +                       btrfs_header_level(eb) =3D=3D 0 ? "leaf" : "node"=
,
> +                       root_owner, btrfs_header_bytenr(eb), eb_owner,
> +                       BTRFS_FIRST_FREE_OBJECTID, BTRFS_LAST_FREE_OBJECT=
ID);
> +               return -EUCLEAN;

This causes a failure when using free space cache v1 and doing balance:

BTRFS critical (device sdb): corrupted leaf, root=3D0 block=3D12320768
owner mismatch, have 1 expect [256, 18446744073709551360]

It's triggered from add_data_references() (relocation), for root tree
leaves that contain data extents for v1 space caches.
In that case the header owner is 1 (root tree), root_owner is 0, so
is_subvol is set to true, and is_fstree(1) returns false, triggering
the false corruption error here.

Thanks.

> +       }
> +       return 0;
> +}
> diff --git a/fs/btrfs/tree-checker.h b/fs/btrfs/tree-checker.h
> index 32fecc9dc1dd..c48719485687 100644
> --- a/fs/btrfs/tree-checker.h
> +++ b/fs/btrfs/tree-checker.h
> @@ -25,5 +25,6 @@ int btrfs_check_node(struct extent_buffer *node);
>
>  int btrfs_check_chunk_valid(struct extent_buffer *leaf,
>                             struct btrfs_chunk *chunk, u64 logical);
> +int btrfs_check_eb_owner(struct extent_buffer *eb, u64 root_owner);
>
>  #endif
> --
> 2.35.1
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
