Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 773A5DE881
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2019 11:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbfJUJwT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Oct 2019 05:52:19 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:40800 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727194AbfJUJwT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Oct 2019 05:52:19 -0400
Received: by mail-vs1-f65.google.com with SMTP id v10so8433863vsc.7
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 02:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=J9fot9Wo9YLjX8mDoE06Yqlq9Gtl5xFcsdoynR6Rimc=;
        b=sXllcTbkMrg/DUl5HHbN6HNoLcvcrZ8jogeaZYsE9NOVAMgKhdrRxNShGgp4T0dPLK
         03VibvwagtpYYnsMrFsbFAz7MAMhRlcU42UFr2SCSf/140Hb6jhA7X0zYEFq12LK+Fkh
         L8hxFVYBtD8J57Mig5o95mVVcSUIQ7ZHQF4TNGvxJwIUukE6HqRYT/UTgXT3Tq2DDMRY
         n7zBOvhogJvm+HLnNrECOE5D5NUUtsw27XuhkpizIEK8j2/qz7ryuDOQ/NuJR47QuWwY
         xVFq7DFIdjesSZsRLu1m/itp8HZQCmQq8U9IJlQHIMXCTCo1Ft2LlQ3iqUWPu18GC0lC
         KqCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=J9fot9Wo9YLjX8mDoE06Yqlq9Gtl5xFcsdoynR6Rimc=;
        b=GbbHjm4Qk5B6n9E1nYW0dq+BLEROf8LR3tSawI3lM6duesXLaIPpIRpKkwkiHb3+T8
         WNfshLydxwwjsmgD8yWfdgvBHi+gCe1g6pEzMZvnh+YxYvCIQ1fKcnkcd/fkIRrCRWlB
         Z/6FFE+YHUjM17rUwmmFb6fQnu+xHfphYfQpzLUldLRaUPM10knfoUwennD51SlXrns/
         q0UOOXb6zY6GCrZU9ZUt5ik9bi2QrgTMGJuZH8AxvqNcQwT8aiSw38sIOUZv32q7Os5e
         H93t5VRIiuxLeu8O1P4Q2QHo4KESYP2ZAAiNtlQT/6RzluNZ1J0xjVhGR9supOSB8SVI
         hGJQ==
X-Gm-Message-State: APjAAAX7S+4PSQc8GqmBl1FaO3aWh7nN+dGDEPxJCgW+UP7kaTY8P0WF
        oDiHxJgK0Ksx3dAb4mj6mFGoqSv+HPEAFZzj5b0=
X-Google-Smtp-Source: APXvYqwvhNzHZyW1TzQozygjaAB0raRvqjUWanRNscT3sa59xuzgo3Une9k6nRufotL6ivXO/1kD9M/FdH3pPvT65CU=
X-Received: by 2002:a67:ba16:: with SMTP id l22mr12668900vsn.14.1571651537751;
 Mon, 21 Oct 2019 02:52:17 -0700 (PDT)
MIME-Version: 1.0
References: <20191018181544.26515-1-rgoldwyn@suse.de>
In-Reply-To: <20191018181544.26515-1-rgoldwyn@suse.de>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 21 Oct 2019 10:52:06 +0100
Message-ID: <CAL3q7H7kvKGFmKgoMuQFv7Qx4PCV02gfX6yWMa-tL5RakU1h=Q@mail.gmail.com>
Subject: Re: [PATCH] btrfs: Do not check for PagePrivate twice
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Oct 19, 2019 at 10:05 AM Goldwyn Rodrigues <rgoldwyn@suse.de> wrote=
:
>
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
>
> We are checking PagePrivate twice, once with lock and once without.
> Perform the check only once.

Have you checked if there's some performance degradation after
removing the check?
My guess is it's there to avoid taking the lock, as the lock can be
heavily used on a system under heavy load (maybe even if it's not too
heavy, since we generate a lot of dirty metadata due to cow).
The page may have been released after locking the mapping, that's why
we check it twice, and after unlocking we are sure it can not be
released due to taking a reference on the extent buffer.

Thanks.

>
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> ---
>  fs/btrfs/extent_io.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index cceaf05aada2..425ba359178c 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -3959,9 +3959,6 @@ int btree_write_cache_pages(struct address_space *m=
apping,
>                 for (i =3D 0; i < nr_pages; i++) {
>                         struct page *page =3D pvec.pages[i];
>
> -                       if (!PagePrivate(page))
> -                               continue;
> -
>                         spin_lock(&mapping->private_lock);
>                         if (!PagePrivate(page)) {
>                                 spin_unlock(&mapping->private_lock);
> --
> 2.16.4
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
