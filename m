Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC11A41ACA0
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Sep 2021 12:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240063AbhI1KJd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Sep 2021 06:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240055AbhI1KJd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Sep 2021 06:09:33 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33972C061575
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Sep 2021 03:07:54 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id j13so19300470qtq.6
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Sep 2021 03:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=RZlvGQG+Uv04d7qjTz8tDFnD5oP0At8YTAtjHjzQyfI=;
        b=SiPjp3Tw75DB++1Odrjk5q6cs5Q6paF/H1Zj/WfG9Smv1XmUQ6kZgVL+WAb+GuVaI+
         pHAA387zTFtZAUlaxqKnRBysMXKhCKorU7Gzx9QVI7qvpgFSitzZBvOhWMRZvbHkBgml
         tb/RGUrrqYJwKV5IwsOl1y/Falk501PZIXzEI6vT/tOx+0STrpjFE6gROwP8OQmW5aUn
         ERQnKkrrRNyy9VkdfVryWzM+vtpQ9RzFBFs7RbizIp5KVKZ7a27X1For71nZGASB6cy4
         /QrEGAOyEUwqbvZu/EbkoHJbkuqi1+HXNzYHCp+qYUvaUkKOPuqIGWuqRzEw4SRNPuWe
         Af4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=RZlvGQG+Uv04d7qjTz8tDFnD5oP0At8YTAtjHjzQyfI=;
        b=Azd76xIH0Ce4ir9n8UUdf6WhQ0RTdbFBN81F3tV/A51o80gBki9BiF8C7stScPg+fs
         6CF8GPjdqt+lXPwE+W9T36cbo74v+LRXy+c+Bv64196ht+09pBT3dtbFed0BywWUyF0i
         1gjJvvk1VhsCvHpmql+krIRwHI5PhI+0RwSW/Y84vi5d3pmcqlWE6m8cx7YhQq8OzFRU
         yUbh5QyiniCEiM0S4t4WbgDL8FQHyIilS7dms42F39GJhSsyEZZE1vBYw7rLi+CLNMmF
         ZZeY+1L5Lu1IxM993CMcpWsvu6qtEm5v9sM1vE0t7jVXOwwBrTNXcHkegO1G/qODCvZh
         bi8A==
X-Gm-Message-State: AOAM531rGKRoyQAB7E2Bx1BDVYGqb4gceuVibXdn2t2831OcXzahWxGY
        6Kxd5QyO156DfRr1EqkR1BaRz2oB7OWv9YxVoi1u3DGN
X-Google-Smtp-Source: ABdhPJwmZ6K3b3WHfieaN98XO/Pm/mZkS9ZSTNtZfypA7Ujt40oBn7PjIuy2V4KPhdyUsROULNG8GYbcyVSzGGNzxO4=
X-Received: by 2002:ac8:7959:: with SMTP id r25mr4546511qtt.29.1632823673322;
 Tue, 28 Sep 2021 03:07:53 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1632765815.git.josef@toxicpanda.com> <6d8adc363ee08747d4e5ee2f521b1e0e155516a1.1632765815.git.josef@toxicpanda.com>
In-Reply-To: <6d8adc363ee08747d4e5ee2f521b1e0e155516a1.1632765815.git.josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Tue, 28 Sep 2021 11:07:17 +0100
Message-ID: <CAL3q7H4jFw5W-hrs=PaAPSRLuR0=MYT55NHaijKxAD6HyNW2yQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] btrfs: fix abort logic in btrfs_replace_file_extents
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 27, 2021 at 7:07 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> Error injection testing uncovered a case where we'd end up with a
> corrupt file system with a missing extent in the middle of a file.  This
> occurs because the if statement to decide if we should abort is wrong.
> The only way we would abort in this case is if we got a ret !=3D
> -EOPNOTSUPP and we called from the file clone code.  However the
> prealloc code uses this path too.  Instead we need to abort if there is
> an error, and the only error we _don't_ abort on is -EOPNOTSUPP and only
> if we came from the clone file code.

Looks good, but the comment above the conditional in the code needs to
be updated, to reflect the new logic as mentioned in the changelog.

Thanks.

>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/file.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index fdceab28587e..f9a1498cf030 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -2710,8 +2710,9 @@ int btrfs_replace_file_extents(struct btrfs_inode *=
inode,
>                          * returned by __btrfs_drop_extents() without hav=
ing
>                          * changed anything in the file.
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
