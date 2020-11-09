Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8412AB4C3
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Nov 2020 11:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbgKIKXi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Nov 2020 05:23:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbgKIKXi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Nov 2020 05:23:38 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F19C0613CF
        for <linux-btrfs@vger.kernel.org>; Mon,  9 Nov 2020 02:23:38 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id i7so5594271qti.6
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Nov 2020 02:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=yzTgnLEtJKxwbw8a+/1B+f1DLgQiFFiwPpsnVx+lkW8=;
        b=FwduV4OBSQUtCkvcNTk4rWw5kw94UPskoKPs08VwVFtJixstY/p7fx5LJKS8dvCQRj
         NewwjW6hDih/xZqM21FPjmfcVE1fkoeqeaR+eAxu6+xeItamUozLP35vxLUh7yQ+hnqI
         mG+T/E0OkPlMGrzq/Yue63mj0bKH0/qtwIhQqXYU7UGMKeM8JQQKFZo2L6LY14HLtnMJ
         iEijQd160C9Wl2L48f26vnhzKA8m9Y2ScHDuFWvMLLhqK+mFau1W20yV4BYkrDp4M6DW
         BZGrUqIfxZI7lb2YFY/B8QORV85pp7BPTTh0LVFDPOU28hfyyR+mEWrAqZtQC9IJEInj
         vX3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=yzTgnLEtJKxwbw8a+/1B+f1DLgQiFFiwPpsnVx+lkW8=;
        b=ofFT1oeoustD16YlGEUGnuxGZt4OTEGXgsDvzJr9bfInFSRQUT8V4AaCY+K5HwWeLB
         Oha90DenFCX3inPHxnpYOmHgML9/J22T94kUXEXtZcfpoFOuXbOS7xEj0/V3BBl/rdiu
         k7XFLvWZW+oHYBM0+R0Ran3ee6rLC7cq7FyteasG6XnfhAeW3j1vLoWROwBrjl4cGo2s
         nMmnrUd8DE+D2aAnPvOTeqKzHkPs4ymP2+mOVikfxqxtsj5xd1aS2vfiWRLx00dl6cka
         Z0KNLK81ocaZ6PSmLhlhK345EKo1K9J2nzJFsGBzIfk1Bim7IpnNYWXDmit9jqg2ORI2
         nLmg==
X-Gm-Message-State: AOAM533O131IjxVyItd2CXqGYMCTVVTjFB8/YEitjfc7ayoOHeBEgRMT
        Tsycsxov+nXNIsIAgfh8iIXlW5Gx1zy9FIBrcmxMlXPbiKin1A==
X-Google-Smtp-Source: ABdhPJz2KMc8VhiIRAjKtGO17HrmeLAnBgLvQpe7P/5ovvaHh4oL4qf0pYMALIHTv/Dibd14YoWVTxVId3GvE4hpVeM=
X-Received: by 2002:aed:30e2:: with SMTP id 89mr12705229qtf.259.1604917417430;
 Mon, 09 Nov 2020 02:23:37 -0800 (PST)
MIME-Version: 1.0
References: <cover.1604697895.git.josef@toxicpanda.com> <da026377e9de7867dd377005cb9ddd6121651348.1604697895.git.josef@toxicpanda.com>
In-Reply-To: <da026377e9de7867dd377005cb9ddd6121651348.1604697895.git.josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 9 Nov 2020 10:23:26 +0000
Message-ID: <CAL3q7H7-_U+hOdBj+ivDQ8Lj6Cb25j+-xQw0+EDKGRGnF+e9gQ@mail.gmail.com>
Subject: Re: [PATCH 8/8] btrfs: remove ->recursed from extent_buffer
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 6, 2020 at 9:29 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> It is unused everywhere now, it can be removed.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/extent_io.c | 1 -
>  fs/btrfs/extent_io.h | 1 -
>  2 files changed, 2 deletions(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 119ced4a501b..32c2000a2269 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -4955,7 +4955,6 @@ __alloc_extent_buffer(struct btrfs_fs_info *fs_info=
, u64 start,
>         eb->fs_info =3D fs_info;
>         eb->bflags =3D 0;
>         init_rwsem(&eb->lock);
> -       eb->lock_recursed =3D false;
>
>         btrfs_leak_debug_add(&fs_info->eb_leak_lock, &eb->leak_list,
>                              &fs_info->allocated_ebs);
> diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
> index 3c2bf21c54eb..b0bf7f75b113 100644
> --- a/fs/btrfs/extent_io.h
> +++ b/fs/btrfs/extent_io.h
> @@ -87,7 +87,6 @@ struct extent_buffer {
>         int read_mirror;
>         struct rcu_head rcu_head;
>         pid_t lock_owner;
> -       bool lock_recursed;
>         /* >=3D 0 if eb belongs to a log tree, -1 otherwise */
>         s8 log_index;
>
> --
> 2.26.2
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
