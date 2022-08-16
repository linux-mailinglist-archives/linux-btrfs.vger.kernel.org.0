Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1283459582C
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Aug 2022 12:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234577AbiHPK1a (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Aug 2022 06:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234531AbiHPK1E (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Aug 2022 06:27:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1071417E14
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Aug 2022 01:35:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B410AB80EB2
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Aug 2022 08:35:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 587EAC433C1
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Aug 2022 08:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660638903;
        bh=ncx3aaUGLzw7bbFG8aKkt88R038nEkdko7aczTU9vD8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fx1GFUlub3XOJgCeFMF76bQxhtSKzouM0J0COSLLG7zsJBux5N1xClarxraWRok5o
         C7dE5gJrG1gzw2d1Y6N7oGHMjOY98dYVCt5ukG4h8UB9hPQVA3aPC63v4GmVIioH4q
         JbcQGsCzAccfaYDHuc6s2PIRukATFTYisPR16txKshXWOycqfjUhatKko3AU8tGd22
         oTFzEPRFv9HNbdX8tWNuBjOotYoA7SmKLZJLv3Cz2xC5WNj/rtFEnX/GJFJkpbeaNR
         kUd3pkZwbCX75Ky1QOGCG7choDKQHQaOn7yfAGcCX+8MoX5VeucU/sD14n+GcLVLMP
         zpN9QewLzeAhA==
Received: by mail-oi1-f171.google.com with SMTP id w197so11353843oie.5
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Aug 2022 01:35:03 -0700 (PDT)
X-Gm-Message-State: ACgBeo3kFHM4whtnAOdKSHfyWQ612+JEOeDgE71b8ILpWjz2E4XqyjHD
        OnPt2+DuP6mZjoXU5nvF20PXn8hf496Wnary2Vk=
X-Google-Smtp-Source: AA6agR5JERWiLjScDJNjiZxoDIE2MSrNR1PFgzAJrUU75vvabeBCNrMgkgM9QPmrHvQBqU7+xvzp5ItC9pNJAVlOK7A=
X-Received: by 2002:a05:6808:1b85:b0:33a:7a2b:3ff7 with SMTP id
 cj5-20020a0568081b8500b0033a7a2b3ff7mr8298933oib.152.1660638902428; Tue, 16
 Aug 2022 01:35:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220815193402.7fmuwafu3qpalniz@fiona>
In-Reply-To: <20220815193402.7fmuwafu3qpalniz@fiona>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Tue, 16 Aug 2022 09:34:25 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4LQ0THXa-1bAa3knvJEKeOHYeLKn8ZMZ669ccTebcj6w@mail.gmail.com>
Message-ID: <CAL3q7H4LQ0THXa-1bAa3knvJEKeOHYeLKn8ZMZ669ccTebcj6w@mail.gmail.com>
Subject: Re: [PATCH] Check if root is readonly while setting xattr
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 16, 2022 at 1:40 AM Goldwyn Rodrigues <rgoldwyn@suse.de> wrote:
>
> For a filesystem which has btrfs read-only property set to true, all
> write operations including xattr should be denied. However, security
> xattr can still be changed even if btrfs ro property is true.

Why does that happen only for security xattrs, and not  for xattrs in
the user.* and btrfs.* namespaces?

>
> This patch checks if the root is read-only before performing the set
> xattr operation.
>
> Testcase:
>
> #!/bin/bash
>
> DEV=/dev/vdb
> MNT=/mnt
>
> mkfs.btrfs -f $DEV
> mount $DEV $MNT
> echo "file one" > $MNT/f1
> setfattr -n "security.one" -v 2 $MNT/f1
> btrfs property set $MNT ro true
>
> # Following statement should fail
> setfattr -n "security.one" -v 1 $MNT/f1
>
> umount $MNT

A test case only in a changelog isn't super useful to prevent future
regressions :)

Can you send a test case for fstests, that also tests user.* and
btrfs.* namespaces, and creating and deleting xattrs too?

>
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
>
>
> diff --git a/fs/btrfs/xattr.c b/fs/btrfs/xattr.c
> index 7421abcf325a..5bb8d8c86311 100644
> --- a/fs/btrfs/xattr.c
> +++ b/fs/btrfs/xattr.c
> @@ -371,6 +371,9 @@ static int btrfs_xattr_handler_set(const struct xattr_handler *handler,
>                                    const char *name, const void *buffer,
>                                    size_t size, int flags)
>  {
> +       if (btrfs_root_readonly(BTRFS_I(inode)->root))
> +               return -EROFS;
> +

The same type of check should be done at btrfs_xattr_handler_set_prop() as well.
Even though trying the same test on a btrfs.compression xattr fails with -EROFS.

I'm still curious why trying the same on a user.* xattr happens to
fail with -EROFS,
but not for a secutiry.* xattr, since both have
btrfs_xattr_handler_set() as their entry point.

I think this should be detailed in the changelog, and presume you
verified why that happens.

Thanks.

>         name = xattr_full_name(handler, name);
>         return btrfs_setxattr_trans(inode, name, buffer, size, flags);
>  }
>
> --
> Goldwyn
