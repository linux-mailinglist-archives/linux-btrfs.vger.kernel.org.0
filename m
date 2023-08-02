Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F6376CC46
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Aug 2023 14:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233453AbjHBMGX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Aug 2023 08:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbjHBMGW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Aug 2023 08:06:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2FBB10C1
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Aug 2023 05:06:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5886A6193B
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Aug 2023 12:06:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E0FC433CA
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Aug 2023 12:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690977980;
        bh=okAogiQ6d++elQl7Rd4CidS7IsGYan2egR5WASwTmy4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ma7wn9JdbSkRTQtepwGPrwmm4RVJw5Y9K6yr3OO57mZITpn2+J0UuU1WwlKAEOImz
         f6u7n8VxgYitzby30VZXegSB9MjbyIvoHEHMb74z3kYbQf4MFPtRQXX77+/Mz0goff
         5hFmzaPG/WKYysHKAF2OiVvzc5L9H+/28AR/p9SqAoUpoxHP/kU16WHZy6twe2HQyQ
         ga27DbH4xZMFGJfrH5AKO+JpeCGHdZ27MhGqM2BVq6WCwSxPrNnf24Z6SqT/wxZajJ
         pxDJkitQ3hrcxDaQ1/5BJenKVMIUr1d6IoANM8HmoTLlnJ+yYMsYYt8+R1ht6bZSeE
         hymxfwoKxASow==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-56cb1e602e7so2256784eaf.1
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Aug 2023 05:06:20 -0700 (PDT)
X-Gm-Message-State: ABy/qLYQJ56h+M8evRajq59Zqkgq9gI7cpbr4jJKnM35BK1l9NGyBoVA
        +leNw2WfXrUTncNnZc2L+TsxJv7Pp0eY4nPiQyc=
X-Google-Smtp-Source: APBJJlGohEoTvr3/Pv69X6q0kPYJHuaH+ATraTjIu10WDsu0XdlWCVykQei35nITV9qqTNhXn7qILNDqKKdpVu9GK5w=
X-Received: by 2002:a4a:6c59:0:b0:56d:e6:21bf with SMTP id u25-20020a4a6c59000000b0056d00e621bfmr3190955oof.0.1690977979867;
 Wed, 02 Aug 2023 05:06:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1690970028.git.wqu@suse.com> <33e75a646274b3c844744dfec54c46ae89aa3d33.1690970028.git.wqu@suse.com>
In-Reply-To: <33e75a646274b3c844744dfec54c46ae89aa3d33.1690970028.git.wqu@suse.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Wed, 2 Aug 2023 13:05:43 +0100
X-Gmail-Original-Message-ID: <CAL3q7H58tdy0RU6dq3+mesM=boqH1eDQYbTU+8FecTihyykurw@mail.gmail.com>
Message-ID: <CAL3q7H58tdy0RU6dq3+mesM=boqH1eDQYbTU+8FecTihyykurw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] btrfs: exit gracefully if reloc roots don't match
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

On Wed, Aug 2, 2023 at 11:25=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
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
> Reported-by: syzbot+ae97a827ae1c3336bbb4@syzkaller.appspotmail.com
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/relocation.c | 40 ++++++++++++++++++++++++++++++++++------
>  1 file changed, 34 insertions(+), 6 deletions(-)
>
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 9db2e6fa2cb2..32a8bdc08488 100644
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
> +"reloc tree mismatch, root %lld has reloc root key (%lld, %u, %llu) gen =
%llu, expect reloc root key (%lld, %u, %llu) gen %llu",

Please remove the commas when printing keys, use (%llu %u %llu).
This is the style we follow (tree checker, ctree.c, etc).

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
 (%lld, %u, %llu) gen %llu",

Same here.

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
>                         if (root->reloc_root !=3D reloc_root) {

As the ASSERT below is gone, maybe adding a WARN_ON(root->reloc_root
!=3D reloc_root) is helpful too, so that if this ever happens and
relocation fails with -EINVAL, it will point to this location.

>                                 /*
> -                                * This is actually impossible without so=
mething
> -                                * going really wrong (like weird race co=
ndition
> -                                * or cosmic rays).
> +                                * This can happen if on-disk data has so=
me

data -> metadata

Other than that it looks fine to me, thanks.

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
