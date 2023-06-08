Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDA04727BD9
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jun 2023 11:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234055AbjFHJsF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jun 2023 05:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjFHJsF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jun 2023 05:48:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3AAF26BB
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 02:47:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F0FB61341
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 09:47:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9D2BC4339B
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 09:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686217677;
        bh=CjWy8Fx1bewGujexwHjymS1P/6Fb6uOR+h+pPhVm4TI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gNsz1+0ACOU5dcLcsdz4ClOJypXcnPwnHW4gKWeDrtsgVS4mJsRPc2q/tsJ0JhcZf
         uUk6s3Ruc735PXrdFHb6pqmPIVulxF0cNykOksQmt0i4kfGu2R+XmO+gMVdEfCLLXZ
         41EJqq1fzZ6q1eK/sLJ/R9qXM/p1BHj+iMWf+orr9ioa8teA72rFio2GoalJ7IOnbO
         ZptfbMqacuGWlgF28LZOen9qS3SJAQ2JXAhfo0WB4T85oSAMNWIFEt6lDRlgRXs5yS
         WJND7Z1Ne9Xl8tgazbvp8NNG0wezgQNSCZ8u+UyCTDk3/hsjaT8quYyj/bHMwKEDuQ
         Z5tfI257DWkCg==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5559cd68b67so285508eaf.3
        for <linux-btrfs@vger.kernel.org>; Thu, 08 Jun 2023 02:47:57 -0700 (PDT)
X-Gm-Message-State: AC+VfDw4jHd+UsoGGzIIEb8zA4pp+SrF1aN0EPQmP3vru15zL3wfRJFB
        /6wD+ZckVqpVIgwba09WcitMo+PU0U3Z5vejRIc=
X-Google-Smtp-Source: ACHHUZ6u+9AJYYL47xIU4tCoO5o16NkYrwb9+G0SeiBM52lJ8YpiEyf3R2faVl1sQp2R1SCE3JfZqZPlWuNjtA9dPP4=
X-Received: by 2002:a4a:d18f:0:b0:558:a42c:3337 with SMTP id
 j15-20020a4ad18f000000b00558a42c3337mr7092872oor.8.1686217677120; Thu, 08 Jun
 2023 02:47:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1686164789.git.fdmanana@suse.com> <a7914cc7ab662f8bf4e0ab5622e81622acbc186e.1686164819.git.fdmanana@suse.com>
 <88b90700-8034-46fe-0969-dfe6e7eabdba@gmx.com>
In-Reply-To: <88b90700-8034-46fe-0969-dfe6e7eabdba@gmx.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Thu, 8 Jun 2023 10:47:21 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6a0SSn0fTg--G7Y8UMqdezN-+kKR7_tSJRhbr+v+BXcg@mail.gmail.com>
Message-ID: <CAL3q7H6a0SSn0fTg--G7Y8UMqdezN-+kKR7_tSJRhbr+v+BXcg@mail.gmail.com>
Subject: Re: [PATCH 09/13] btrfs: abort transaction at update_ref_for_cow()
 when ref count is zero
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

On Thu, Jun 8, 2023 at 9:58=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.com> w=
rote:
>
>
>
> On 2023/6/8 03:24, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > At update_ref_for_cow() we are calling btrfs_handle_fs_error() if we fi=
nd
> > that the extent buffer has an unexpected ref count of zero, however we =
can
> > simply use btrfs_abort_transaction(), which achieves the same purposes:=
 to
> > turn the fs to error state, abort the current transaction and turn the =
fs
> > to RO mode as well. Besides that, btrfs_abort_transaction() also prints=
 a
> > stack trace which makes it more useful.
> >
> > Also, as this is a very unexpected situation, indicating a serious
> > corruption/inconsistency, tag the if branch as 'unlikely' and set the
> > error code to -EUCLEAN instead of -EROFS.
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >   fs/btrfs/ctree.c | 6 +++---
> >   1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> > index e2943047b01d..2971e7d70d04 100644
> > --- a/fs/btrfs/ctree.c
> > +++ b/fs/btrfs/ctree.c
> > @@ -421,9 +421,9 @@ static noinline int update_ref_for_cow(struct btrfs=
_trans_handle *trans,
> >                                              &refs, &flags);
> >               if (ret)
> >                       return ret;
> > -             if (refs =3D=3D 0) {
> > -                     ret =3D -EROFS;
> > -                     btrfs_handle_fs_error(fs_info, ret, NULL);
> > +             if (unlikely(refs =3D=3D 0)) {
> > +                     ret =3D -EUCLEAN;
>
> The same as previous patch, just one extra error message explaining the
> reason for EUCLEAN would be better.

Sure... I didn't see a strong need for that because the transaction
abort's stack
trace will be obvious. But I can add it in v2.

Thanks.

>
> Thanks,
> Qu
> > +                     btrfs_abort_transaction(trans, ret);
> >                       return ret;
> >               }
> >       } else {
