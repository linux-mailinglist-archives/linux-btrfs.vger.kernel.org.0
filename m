Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E51776E5A5
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Aug 2023 12:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235220AbjHCK1Z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Aug 2023 06:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234460AbjHCK1Q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Aug 2023 06:27:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F63110
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Aug 2023 03:27:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 092B261D0C
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Aug 2023 10:27:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64491C433C9
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Aug 2023 10:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691058432;
        bh=PAUGTiXdk+25k9hG7idsZnAr+7Jj9XP5lrtcfXnlWZg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OevQZ9xYcYYBA2E8Zufe40Uxb+ydp2gs3L3EHS1CDHwAGaQnuEYaKu8uPr7SZm0IJ
         Y0YzfUWARSZrpoKqURQxaTw/pxJlz+rgLiA78Px1fS/sGSIMO2Kze8zeSRmKBoM012
         OXmEcO3r8fGp6mnCS/XFpKS/DMAoLK1sWM4m91Pw7bjeMSeYxrHJlq022w9l/XIPWs
         7iE8qkAIm9fMlLpTxb5faQyWAyyivZg+DVM7CDCAqm2okj2yEhXa+bGNr4pgs7hMjy
         A4n5npezQbMGeKL+FrFRfqaGTJv4CMTLavnO+z7MyEZ6jC/+lgug1E82XMsWWinTSH
         9SZaTzDCzXUgg==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-1bb7d1f7aeaso540956fac.1
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Aug 2023 03:27:12 -0700 (PDT)
X-Gm-Message-State: ABy/qLbVD9tQRN+JzpdDKsPTMBA5FKp5Xrxax0xxzBXlxoVQJFcc1kIz
        Tid+uOKGMmQLlqIYYNkxeitfKvjvWDKflNW6uOw=
X-Google-Smtp-Source: APBJJlEXV0+KpqSZojvOD/UWamSDAtxSJLt8a+j+muW/5yVC/XsLY1SwVLUCbozhTgj7X+MU4HFeFogn7xWs91tj3XA=
X-Received: by 2002:a05:6870:638b:b0:1be:f8d9:7bdd with SMTP id
 t11-20020a056870638b00b001bef8d97bddmr12148252oap.6.1691058431511; Thu, 03
 Aug 2023 03:27:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1691054362.git.wqu@suse.com> <30acf23be32724aa2cae7e85a6b88e039f290773.1691054362.git.wqu@suse.com>
In-Reply-To: <30acf23be32724aa2cae7e85a6b88e039f290773.1691054362.git.wqu@suse.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Thu, 3 Aug 2023 11:26:35 +0100
X-Gmail-Original-Message-ID: <CAL3q7H65tTsxJyL=ve=eHWX5rCWrT792BhqczpwXTnmUXyL33A@mail.gmail.com>
Message-ID: <CAL3q7H65tTsxJyL=ve=eHWX5rCWrT792BhqczpwXTnmUXyL33A@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] btrfs: exit gracefully if reloc roots don't match
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        syzbot+ae97a827ae1c3336bbb4@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 3, 2023 at 10:45=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
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

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good now, thanks.

> ---
>  fs/btrfs/relocation.c | 44 +++++++++++++++++++++++++++++++++++--------
>  1 file changed, 36 insertions(+), 8 deletions(-)
>
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 9db2e6fa2cb2..2bd97d2cb52e 100644
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
lu, expect reloc root key (%lld %u %llu) gen %llu",
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
