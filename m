Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA166727D6D
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jun 2023 13:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234190AbjFHLCA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jun 2023 07:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234703AbjFHLBx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jun 2023 07:01:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6902712
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 04:01:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05E436159F
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 11:01:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63959C433EF
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 11:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686222073;
        bh=O28xAUfQwrfFC5JBiAKUCakol3VBKQlxri6HPpHnBbc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=R1D9UFROsyxdl/e3IYAvlY1KhJLy0hBjjkOudA2H6bF8IxA70iPPZFcrxP/jvatqW
         GwQBAtNolzqLB7VISqOzSIT8cOBtMi5baTGoJvSTAVTIH2CdR+LFidm0EgJIL4/7Ya
         Qri43yBwc8b/DvcoLLxMhnoDi18gPAqu1/H9rPPbC3iNJ1goKF2TcfZL5xcZqDxJCJ
         nE04MydaN0SB+dsbmAXcVIwZzsQbyq4zvee7arSXDl39iN01ZD4EElyTYqx7vj0MpS
         21kUFkFCtaUFKpoKQQo77SLXyD5H4xXeOshqeKRhRCmIpMsILaZqyECA9b1jre1zcB
         i+aJxCLeYjPdw==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-19f6211d4e1so373572fac.1
        for <linux-btrfs@vger.kernel.org>; Thu, 08 Jun 2023 04:01:13 -0700 (PDT)
X-Gm-Message-State: AC+VfDw+7pFZl8Jg3kUPDqIrc5B68ogfg+kSztDlPmLbA3unlX5/HI01
        MpcnwJSkli+RwvFWpQSrkGKpJgcuUItUmYHP7DY=
X-Google-Smtp-Source: ACHHUZ7Hlbs/ldUJvNKNVSvhIZP3EA0MjAULclT8CTZB32evtZdxIMU9cb6p+ItBRv1K0t0R93OZ8a7stQW/yqrXxJc=
X-Received: by 2002:a05:6870:a3d6:b0:1a2:7012:1ca7 with SMTP id
 h22-20020a056870a3d600b001a270121ca7mr4433870oak.19.1686222072500; Thu, 08
 Jun 2023 04:01:12 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1686219923.git.fdmanana@suse.com> <f566e1432b19f82d9c647b1c0e8e43743818bd7a.1686219923.git.fdmanana@suse.com>
 <dda1adff-2813-0ff8-1f88-fe14cc73c9eb@gmx.com>
In-Reply-To: <dda1adff-2813-0ff8-1f88-fe14cc73c9eb@gmx.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Thu, 8 Jun 2023 12:00:36 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7=T8HP+Q-OTqNxjtQDOZQS1KbRHEwX=kLv4UoZBd6MEQ@mail.gmail.com>
Message-ID: <CAL3q7H7=T8HP+Q-OTqNxjtQDOZQS1KbRHEwX=kLv4UoZBd6MEQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/13] btrfs: avoid unnecessarily setting the fs to RO
 and error state at balance_level()
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 8, 2023 at 11:51=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
>
>
>
> On 2023/6/8 18:27, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > At balance_level(), when trying to promote a child node to a root node,=
 if
> > we fail to read the child we call btrfs_handle_fs_error(), which turns =
the
> > fs to RO mode and sets it to error state as well, causing any ongoing
> > transaction to abort. This however is not necessary because at that poi=
nt
> > we have not made any change yet at balance_level(), so any error readin=
g
> > the child node does not leaves us in any inconsistent state. Therefore =
we
> > can just return the error to the caller.
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
>
> Reviewed-by: Qu Wenruo <wqu@suse.com>
>
> Although I'd like to add some comments on the error handling.
>
> The catch here is, we can only hit the branch because @mid is already
> the highest tree block of the path.
> Thus the path has no CoWed tree block in it at all.

Even if it's not the highest level, there's no problem at all.
COWing blocks without doing anything else doesn't leave a tree in an
inconsistent state,
as long as each parent points to the new (COWed) child.

>
> If the condition is not met, we will return an error while some CoWed
> tree blocks are still in the path.

As said before, the COWed blocks are fine, the tree is consistent as
long as each
parent points to the new blocks.

> In that case, a simple btrfs_release_path() will only reduce the refs
> and unlock, but not remove the delayed refs.

btrfs_release_path() is never responsible for adding delayed blocks.
That happens during COW, when we call btrfs_free_tree_block().

>
> Thus this is more like an exception, other locations can not follow the
> practice here.
>
> Thanks,
> Qu
>
> > ---
> >   fs/btrfs/ctree.c | 1 -
> >   1 file changed, 1 deletion(-)
> >
> > diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> > index e98f9e205e25..4dcdcf25c3fe 100644
> > --- a/fs/btrfs/ctree.c
> > +++ b/fs/btrfs/ctree.c
> > @@ -1040,7 +1040,6 @@ static noinline int balance_level(struct btrfs_tr=
ans_handle *trans,
> >               child =3D btrfs_read_node_slot(mid, 0);
> >               if (IS_ERR(child)) {
> >                       ret =3D PTR_ERR(child);
> > -                     btrfs_handle_fs_error(fs_info, ret, NULL);
> >                       goto out;
> >               }
> >
