Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2515381D75
	for <lists+linux-btrfs@lfdr.de>; Sun, 16 May 2021 10:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234274AbhEPIzL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 16 May 2021 04:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234255AbhEPIzK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 16 May 2021 04:55:10 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66166C061573;
        Sun, 16 May 2021 01:53:56 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id h202so4564964ybg.11;
        Sun, 16 May 2021 01:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ftA4ti5/6sdNr5V36MO+h2jetmzHwEt9RUH/PLBAxY8=;
        b=T3INqGrrLTawY2PwrwMmaYPaml4dU/Rdtv9onK4veMKqZfCLrH+MtgtiqV8SJxuEBW
         4O4oBeb1ZgGuHDlxzGOWtEgiRHvRgc2llDO1j3lLaLWCai9S/I9vl0t3Hfk9bTOB/TxN
         I6kULP9fgm7OqkutPGzBXkzcU9lvYXzL2M+hclSTDedWbiGTjPxS1kRhivxc9VJ9fIBG
         01z4coeHSbAKu1CXhJWvo8NoGOIHx7nqtqc1a2gG2Ih7b3jbIr3GOro8jnXqLZdV0EzW
         PdBXCS+R/BeCtHGCuPuNvljEGCztPi38NQEC73QTNRjqpEfjVwncnCmTcrezUAOv0cWq
         5W2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ftA4ti5/6sdNr5V36MO+h2jetmzHwEt9RUH/PLBAxY8=;
        b=tL9uyLLm4n0wtjL5hEmfZofSvPbvfl+XY/pqwfB2sXsDJTZbJM+FqvgVQXy+EuIe+x
         6ARt/doorRPZKX9vco/J6amSu7QXAlU5ghLytCpnJf/ux5jR6I4YdttD9T1frzmMX54Z
         lJyqBxhDCMVe2S+5Pzc3nwBXmy/6O8hzbTt9CwBb4uTUDHfU+SsbP8zeELq6UIk5GV2w
         eZF/cS9AyVd66koMlj40uHvGOA4L0KE3OlcUH1Y2gfbSQz9Zr0wr4YkHl6UNAYLx0OkE
         2TmZ5spda0ZaZG+60IVIh8+u+xF0nNo2oDf2AS8iqVTG+91Mws2TtLUQMSegotDjlalu
         3BLA==
X-Gm-Message-State: AOAM531WlCy4fqCC33ItLCEVlOe1m/3RSeMNt/gWwib0hm45mkJg+M4G
        62aU+/HSAHuNllqSJJrhGuQqLOnlvMUoI9jBsQY=
X-Google-Smtp-Source: ABdhPJwdE7SKwM/V6kVaWp2lglaUuvcCjKHhym7fG+KaZH0aaxYr/3ygl8L8rstWVwMUF3i7TUyi5a4r8R345gEfr3U=
X-Received: by 2002:a25:7909:: with SMTP id u9mr72457023ybc.22.1621155235692;
 Sun, 16 May 2021 01:53:55 -0700 (PDT)
MIME-Version: 1.0
References: <1620984265-53916-1-git-send-email-yang.lee@linux.alibaba.com>
In-Reply-To: <1620984265-53916-1-git-send-email-yang.lee@linux.alibaba.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Sun, 16 May 2021 10:53:57 +0200
Message-ID: <CAKXUXMyjh1mnLpyu_xa4vWAv9Bn_EN3YdhQ_r1aD58YvFTRORA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: Remove redundant initialization of 'to_add'
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     clm@fb.com, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-btrfs@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 14, 2021 at 11:24 AM Yang Li <yang.lee@linux.alibaba.com> wrote:
>
> Variable 'to_add' is being initialized however this value is never
> read as 'to_add' is assigned a new value in if statement. Remove the
> redundant assignment. At the same time, move its declaration into the
> if statement, because the variable is not used elsewhere.
>
> Clean up clang warning:
>
> fs/btrfs/extent-tree.c:2773:8: warning: Value stored to 'to_add' during
> its initialization is never read [clang-analyzer-deadcode.DeadStores]
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  fs/btrfs/extent-tree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index f1d15b6..e7b2289 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -2774,10 +2774,10 @@ static int unpin_extent_range(struct btrfs_fs_info *fs_info,
>                 spin_unlock(&cache->lock);
>                 if (!readonly && return_free_space &&
>                     global_rsv->space_info == space_info) {
> -                       u64 to_add = len;
>
>                         spin_lock(&global_rsv->lock);
>                         if (!global_rsv->full) {
> +                               u64 to_add;
>                                 to_add = min(len, global_rsv->size -
>                                              global_rsv->reserved);

Yang Li, you could just combine these two lines above, right?

So:
u64 to_add = min(len, ...);

By the way, great contribution on addressing all those dead stores
identified by clang analyzer... I wish I would also have more time on
addressing some of those remaining...

Lukas
