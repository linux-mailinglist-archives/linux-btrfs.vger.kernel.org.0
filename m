Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42CC1727BDC
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jun 2023 11:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234656AbjFHJs3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jun 2023 05:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234131AbjFHJs2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jun 2023 05:48:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6983126AD
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 02:48:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F3CAB64B57
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 09:48:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63A08C433D2
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 09:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686217706;
        bh=A2gDFGWkxfPtH0CJ/rgdHBivo1wr75MpEhsKHTfabxo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fMrz0+1qC7e3F071MIUQ34O+SmysdxZvcidM2peHaLQ7S+L5aFIuMli4IUePZX2CL
         rJjmBmkRsR6l7H5A0V9O082okCvziTh6CAPE+gsJHwF0ZyVNVssvLqdxwStCu1R8sC
         +lYuHmzur3x2fDqry8sCOsZ4+03ddHa1K5V7Bk52QYyC6jHNxSAYj3pkkOyGwsWNpu
         B8fnnwiXFKVtjfb9yxY9qWnfW6ONHsUez7EyfSgUSfIX88UIZ4f6ZQayFamYSOR8qH
         z3dQpjkasZvJgVfbE+tHBzrSm7OU6kQRNRSF7h9eGlsX4RKHPdu/LqmZpcbbAv75v+
         CEMD5vXDHGQrA==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5584f8ec30cso278921eaf.0
        for <linux-btrfs@vger.kernel.org>; Thu, 08 Jun 2023 02:48:26 -0700 (PDT)
X-Gm-Message-State: AC+VfDw8g5PKV+NKQ5QOmFQ1xni1Lcn3NtzFzhzUnsZ1V4gtmiZASd2/
        k7fzxwL1PAedd35556afoaHrG4Ono6IRnjES8u0=
X-Google-Smtp-Source: ACHHUZ6NHtnx15C67zgPGDsJkvmn7H9R/GJOfl5cb3GkA5t3ODd6Ww1mwW+qMqoTKCtymYAls63+saTVNssOaV7WXcU=
X-Received: by 2002:a4a:a287:0:b0:558:b4b6:7f8c with SMTP id
 h7-20020a4aa287000000b00558b4b67f8cmr5291196ool.6.1686217705552; Thu, 08 Jun
 2023 02:48:25 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1686164789.git.fdmanana@suse.com> <91e588216500d2aaa7e119e5ac4be927c71bf066.1686164817.git.fdmanana@suse.com>
 <f90ee8a8-65f0-b96b-296c-1720cd9acfe6@gmx.com>
In-Reply-To: <f90ee8a8-65f0-b96b-296c-1720cd9acfe6@gmx.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Thu, 8 Jun 2023 10:47:49 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7astYWHBX2pWL2PqPmSsOArbNMb_CYXfzoXz2L3rKf-w@mail.gmail.com>
Message-ID: <CAL3q7H7astYWHBX2pWL2PqPmSsOArbNMb_CYXfzoXz2L3rKf-w@mail.gmail.com>
Subject: Re: [PATCH 08/13] btrfs: abort transaction at balance_level() when
 left child is missing
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
> > At balance_level() we are calling btrfs_handle_fs_error() when the midd=
le
> > child only has 1 item and the left child is missing, however we can sim=
ply
> > use btrfs_abort_transaction(), which achieves the same purposes: to tur=
n
> > the fs to error state, abort the current transaction and turn the fs to
> > RO mode. Besides that, btrfs_abort_transaction() also prints a stack tr=
ace
> > which makes it more useful.
> >
> > Also, as this is an highly unexpected case and it's about a b+tree
> > inconsistency, change the error code from -EROFS to -EUCLEAN and tag th=
e
> > if branch as 'unlikely'.
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >   fs/btrfs/ctree.c | 6 +++---
> >   1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> > index 4dcdcf25c3fe..e2943047b01d 100644
> > --- a/fs/btrfs/ctree.c
> > +++ b/fs/btrfs/ctree.c
> > @@ -1164,9 +1164,9 @@ static noinline int balance_level(struct btrfs_tr=
ans_handle *trans,
> >                * otherwise we would have pulled some pointers from the
> >                * right
> >                */
> > -             if (!left) {
> > -                     ret =3D -EROFS;
> > -                     btrfs_handle_fs_error(fs_info, ret, NULL);
> > +             if (unlikely(!left)) {
> > +                     ret =3D -EUCLEAN;
>
> I'd prefer to have an message every time we return -EUCLEAN.

Sure... I didn't see a strong need for that because the transaction
abort's stack
trace will be obvious. But I can add it in v2.

Thanks.

>
> Otherwise looks good to me.
>
> Thanks,
> Qu
> > +                     btrfs_abort_transaction(trans, ret);
> >                       goto out;
> >               }
> >               wret =3D balance_node_right(trans, mid, left);
