Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF06241A4C
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Aug 2020 13:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbgHKLZM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Aug 2020 07:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728423AbgHKLZM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Aug 2020 07:25:12 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD62C06174A
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Aug 2020 04:25:11 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id j23so5786141vsq.7
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Aug 2020 04:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=ZMGGfcHhc9KWs5B9DsskxLvTPI2cMJjnKI77g7i+KCI=;
        b=sBeUz9hO24FKhbLX5RI2dCIV0Aq0twT8C2TT8c5qYH0wlT7sM2RAoilFvNkLw3bxYF
         OcnDeIGtjWTVW29gzpiw0jQw/PFhGN0RZ5Ch/UyDgmtKa06rd0AWakTIbhWnxinj+LvB
         FLo9rIxXdyyxjhSbop/Z7gSTIsK9EmUDp8O57f5mB4yw8Fs+80O/nuKuK0VObi9+ZJOq
         o4cTzomPjZ6ITM3LGx0Ma0zrJjT9p9KCkAPGvUkEy18b2aSUoIedKLnzm4vOv+Dnt0zn
         qj449Lc6T79K6nww786wpTj6RlaT20tlEQbp5oJbBEPF66yMp3mj0/gh6Bk//wtvJsuV
         gEUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=ZMGGfcHhc9KWs5B9DsskxLvTPI2cMJjnKI77g7i+KCI=;
        b=RmfvSvcgeVXp3TmBYW6t69fsyfRwYqKwYxDm0xZlSrqetO2dXtKPnx1gfxEVKVMtyX
         8n6+auYDuzDRsXrCaD4JUGLGfzmvu2guTALDazDL3v7exItxuMsUq8mIDv0sx0Jgw6wx
         PLi6JKAKe4lT0VDeDfOTRSRBsUSMRRQQGpl2WOVkK/klC+ZJ2sElHNzTGAWTLmSTn6Ww
         JP2THq5wS5qyF1dN9TYjGxfXYksTnFbHhfYwFGDi3Vk3eG8c4uKiPvyUoeuLRfYNmzhb
         iedT8XxsXvUEwnMKNWgWkaiUkbO59AssCULgeweYB4xco5hXFznTNyPcbWN13jk919KE
         xkwQ==
X-Gm-Message-State: AOAM530S7Dy/G9FLKATF5el1/hNhlk7zfxJScMsvRX3KcAw0uFZ8J5kC
        7Kf4Zuk/xSomPNrkeeKEQCvZl/mGAqWc6ntOlRfekYUH
X-Google-Smtp-Source: ABdhPJwWwUD4dT2x35E/SgnweyFw+4qqyfZ+0bjnj68kB/43DUlvxESKmF78qtZeF+F/oEzcK5AGpFbtni7LhSeE5jw=
X-Received: by 2002:a05:6102:1ca:: with SMTP id s10mr21554274vsq.14.1597145111018;
 Tue, 11 Aug 2020 04:25:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200810154242.782802-1-josef@toxicpanda.com> <20200810154242.782802-6-josef@toxicpanda.com>
In-Reply-To: <20200810154242.782802-6-josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Tue, 11 Aug 2020 12:25:00 +0100
Message-ID: <CAL3q7H77N2T26ESbA3oWVn-=Fb=d9tNJ41A0Xn4tut05tMcYoQ@mail.gmail.com>
Subject: Re: [PATCH 05/17] btrfs: set the correct lockdep class for new nodes
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 10, 2020 at 4:44 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> When flipping over to the rw_semaphore I noticed I'd get a lockdep splat
> in replace_path(), which is weird because we're swapping the reloc root
> with the actual target root.  Turns out this is because we're using the
> root->root_key.objectid as the root id for the newly allocated tree
> block when setting the lockdep class, however we need to be using the
> actual owner of this new block, which is saved in owner.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/extent-tree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index fa7d83051587..84029851f094 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -4522,7 +4522,7 @@ btrfs_init_new_buffer(struct btrfs_trans_handle *tr=
ans, struct btrfs_root *root,
>                 return ERR_PTR(-EUCLEAN);
>         }
>
> -       btrfs_set_buffer_lockdep_class(root->root_key.objectid, buf, leve=
l);
> +       btrfs_set_buffer_lockdep_class(owner, buf, level);
>         btrfs_tree_lock(buf);
>         btrfs_clean_tree_block(buf);
>         clear_bit(EXTENT_BUFFER_STALE, &buf->bflags);
> --
> 2.24.1
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
