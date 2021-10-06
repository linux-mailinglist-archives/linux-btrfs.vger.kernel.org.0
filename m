Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDE234243D4
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Oct 2021 19:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbhJFRTA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Oct 2021 13:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbhJFRS7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Oct 2021 13:18:59 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394BEC061746
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Oct 2021 10:17:07 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d8so3377919qtd.5
        for <linux-btrfs@vger.kernel.org>; Wed, 06 Oct 2021 10:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=mW6F/OHlrM+2RbhRVyL4Z9/1WIdDUxagbjGOS8bg/Vw=;
        b=pMGTJxW9U149fW8w5F5L8/gA3NrkdjfYyZUl52jnog6BtkdlHKySARGIe0HDMSB0KG
         BwSNjCbQwLmEXuMafrTvYUlpkICRBBum/btucYxhemnccnG7ROaTj9RkrpX/nenCb1+1
         ao+N3BjcOqKWqu4gY+lz2U6HWpSH5rNA6cUJyp+eji1Df7ba6OyYZ25yL9MnwfRxSBAH
         eFFv/CmZcLWsv9OypD2Et1E4HTdHCIXu02HDxjvh3YNKwcw0FnVTPT5qRB7fsRXuZV05
         8D6FEwSJs+DsrlGlvSDDtOnukC7HDl8oFdjazS2ll5dQdOYFJn/hWODhNC5SAQsEj816
         koEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=mW6F/OHlrM+2RbhRVyL4Z9/1WIdDUxagbjGOS8bg/Vw=;
        b=ypfZPoyoXLSPp+4VZEJlHymZMhLZ2zaKEMOpk3UDteKXeUO4SbxaBiMTGcktS0EF1O
         Ugm47mlsMglcN+mrfTim4g7YZ/t/PKsud2Wbx32vm9CMl/XciDlgYtNn8iAmuSJnqi4V
         ZeNvDpOCGlot6qafZdQdbxm6jti5f0mjTJkcneDoGNoH41vwU9MR1sqz+WO51h7pSJ4s
         tQInnmHKQCz87+Ll4xM9NXTXgGRppuSlUbTyLPdz/mLlhCO8w95gMGGVGwdqxxJgLakL
         MuPbe1RxOZsgaIuSqsVAKYzvwmwKjtk1TCCm5PNR6WMIWVpheh7RyfVWUA5Jv2g0acAa
         HqLQ==
X-Gm-Message-State: AOAM530CV6zTySAPPwmxk8djHaCcnvsOObhKmoj6n60IWvkwkKwl8ATH
        w3SVYioIOligPdJ/0cymNuykegGxP+wzKolvthM=
X-Google-Smtp-Source: ABdhPJwR/RWHKiK0v2xVaJYpBOMsJpo89betpQCPPpF8mzLzrv81QUVbBqfgw3ajEUQlgyTZG8HCEPmUu002OCjzO9s=
X-Received: by 2002:a05:622a:180c:: with SMTP id t12mr28270681qtc.304.1633540625867;
 Wed, 06 Oct 2021 10:17:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1633465964.git.josef@toxicpanda.com> <92149e1c4fadff139a893282389e16f0a2f0da31.1633465964.git.josef@toxicpanda.com>
In-Reply-To: <92149e1c4fadff139a893282389e16f0a2f0da31.1633465964.git.josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 6 Oct 2021 18:16:29 +0100
Message-ID: <CAL3q7H63tUHYX58hVfnk=vvDs5xxYiCQTogULfK3zo=1QEqnjA@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] btrfs: fix abort logic in btrfs_replace_file_extents
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 5, 2021 at 9:37 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> Error injection testing uncovered a case where we'd end up with a
> corrupt file system with a missing extent in the middle of a file.  This
> occurs because the if statement to decide if we should abort is wrong.
> The only way we would abort in this case is if we got a ret !=3D
> -EOPNOTSUPP and we called from the file clone code.  However the
> prealloc code uses this path too.  Instead we need to abort if there is
> an error, and the only error we _don't_ abort on is -EOPNOTSUPP and only
> if we came from the clone file code.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Now it looks good, thanks.

> ---
>  fs/btrfs/file.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 62673ad5f0ba..f908ef14d3a2 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -2710,14 +2710,16 @@ int btrfs_replace_file_extents(struct btrfs_inode=
 *inode,
>                                                  drop_args.bytes_found);
>                 if (ret !=3D -ENOSPC) {
>                         /*
> -                        * When cloning we want to avoid transaction abor=
ts when
> -                        * nothing was done and we are attempting to clon=
e parts
> -                        * of inline extents, in such cases -EOPNOTSUPP i=
s
> -                        * returned by __btrfs_drop_extents() without hav=
ing
> -                        * changed anything in the file.
> +                        * The only time we don't want to abort is if we =
are
> +                        * attempting to clone a partial inline extent, i=
n which
> +                        * case we'll get EOPNOTSUPP.  However if we aren=
't
> +                        * clone we need to abort no matter what, because=
 if we
> +                        * got EOPNOTSUPP via prealloc then we messed up =
and
> +                        * need to abort.
>                          */
> -                       if (extent_info && !extent_info->is_new_extent &&
> -                           ret && ret !=3D -EOPNOTSUPP)
> +                       if (ret &&
> +                           (ret !=3D -EOPNOTSUPP ||
> +                            (extent_info && extent_info->is_new_extent))=
)
>                                 btrfs_abort_transaction(trans, ret);
>                         break;
>                 }
> --
> 2.26.3
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
