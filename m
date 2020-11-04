Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 830A42A67CD
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Nov 2020 16:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730614AbgKDPfs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Nov 2020 10:35:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730450AbgKDPfl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Nov 2020 10:35:41 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB14C0613D3
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Nov 2020 07:35:40 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id w145so16896589oie.9
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Nov 2020 07:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wikYiBq4R/aR+EqEQM/XKTaOxfr2LwRQ1S/9Oy97+Bc=;
        b=XCcB/4U86saZSi2ci/Mo5YuX4CdSCxuQ8n8feRZRWcjBJ5OMZLrX5JH2Q7rAl9CqOK
         hwtyEpHCEsT2xxdVM7+ODSLlV8EwFS8d/w9velanZzaYfWAO4cQETKt1k0pRJ3yP0sbB
         2UGajnqJpFXfT/jf9QLYE7AGwxXd+QVKC+ycJIveI7XW9m2GvT1ZhYbGQbG+liHb0m7m
         jFYawPYjvm2q65rEntcw/0x32fpRhiNQr7IW+zkIwmaSZP8vCLjduHCr4VKv3kc7WjYk
         HcGpVW8ZoewUlcMPjV/byI2hiJ7nzT7FIASaTkdwVkkL9U+oJ75fTamgoAjbiTQd2Tht
         0mbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wikYiBq4R/aR+EqEQM/XKTaOxfr2LwRQ1S/9Oy97+Bc=;
        b=tbSOG9PnDtowgrGbZJ0bCRF3TIjupFCFLUCUbuTplbjf9q/O7T6km7Uy5iK/WWV1fo
         vsYlst3e+rcayZ42+loELXP94fXyS4xpZe45RzoJxt5++Vb3SXvLUoW52u30bjG8f/io
         RVcRdH2k3jrtx9s7+duTbZ9H0bkcN3sp4+OadpLDx7AtW0q4kL8SOsTBWfNpZqmbDy1R
         8G9dmXRdkUC5s7hheYa9DHl1mxH8e52GibnLiDV05+ybrqDmATfNcB/Ng52n7AuvnJcE
         Zy2CZDd6qJe1pzpj1IaCWKiTMpmWSFMmhUWanIXwIRSCY0v5aP0c+4jEp6qLh3N0cpSu
         mmlQ==
X-Gm-Message-State: AOAM530d4HGx+6IlhD8Tt62X7mXFZKkQmeXyuZc8gzjzCC/rwLRTxm1Z
        ct6W++d8/6DI/Ab3AsyGO1TGwnSGY54vBwMKcJ0=
X-Google-Smtp-Source: ABdhPJy2oPq4CYrgRmKIAvlgtg0l5a2WNVb2J4WQ0s5lAH11PEx4HaVpTzx1BmgUa52EUQScZEc+bz/TVzGmK1sFdzQ=
X-Received: by 2002:aca:cc08:: with SMTP id c8mr2718950oig.161.1604504140013;
 Wed, 04 Nov 2020 07:35:40 -0800 (PST)
MIME-Version: 1.0
References: <cover.1604444952.git.asml.silence@gmail.com> <5be2ccce4a6ebe7c96274f63091a04aeba9af9d8.1604444952.git.asml.silence@gmail.com>
In-Reply-To: <5be2ccce4a6ebe7c96274f63091a04aeba9af9d8.1604444952.git.asml.silence@gmail.com>
From:   Amy Parker <enbyamy@gmail.com>
Date:   Wed, 4 Nov 2020 07:35:29 -0800
Message-ID: <CAE1WUT5k8e_twhb8yZX7=kYFX-ikzUuQwunRkPCCH-zJ80Q6TA@mail.gmail.com>
Subject: Re: [PATCH 2/4] btrfs: discard: save discard delay as ns not jiffy
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 4, 2020 at 1:52 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
>
> Most of calculations are done in ns or ms, so store discard_ctl->delay
> in ms and convert the final delay to jiffies only in the end.

Great idea.

>
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
>  fs/btrfs/ctree.h   |  2 +-
>  fs/btrfs/discard.c | 14 +++++++-------
>  2 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index aac3d6f4e35b..d43a82dcdfc0 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -472,7 +472,7 @@ struct btrfs_discard_ctl {
>         atomic_t discardable_extents;
>         atomic64_t discardable_bytes;
>         u64 max_discard_size;
> -       unsigned long delay;
> +       u64 delay_ms;

Thanks for converting this from the ambiguous unsigned long to the
more specific u64.

>         u32 iops_limit;
>         u32 kbps_limit;
>         u64 discard_extent_bytes;
> diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
> index 76796a90e88d..b6c68e5711f0 100644
> --- a/fs/btrfs/discard.c
> +++ b/fs/btrfs/discard.c
> @@ -355,7 +355,7 @@ void btrfs_discard_schedule_work(struct btrfs_discard_ctl *discard_ctl,
>
>         block_group = find_next_block_group(discard_ctl, now);
>         if (block_group) {
> -               unsigned long delay = discard_ctl->delay;
> +               u64 delay = discard_ctl->delay_ms * NSEC_PER_MSEC;

I worry about a potential performance impact with this, but it should be
minimal at most.

>                 u32 kbps_limit = READ_ONCE(discard_ctl->kbps_limit);
>
>                 /*
> @@ -366,9 +366,9 @@ void btrfs_discard_schedule_work(struct btrfs_discard_ctl *discard_ctl,
>                 if (kbps_limit && discard_ctl->prev_discard) {
>                         u64 bps_limit = ((u64)kbps_limit) * SZ_1K;
>                         u64 bps_delay = div64_u64(discard_ctl->prev_discard *
> -                                                 MSEC_PER_SEC, bps_limit);
> +                                                 NSEC_PER_SEC, bps_limit);
>
> -                       delay = max(delay, msecs_to_jiffies(bps_delay));
> +                       delay = max(delay, bps_delay);

Great that we got this down to just passing max() a value. Same thing on
the instance below.

>                 }
>
>                 /*
> @@ -378,11 +378,11 @@ void btrfs_discard_schedule_work(struct btrfs_discard_ctl *discard_ctl,
>                 if (now < block_group->discard_eligible_time) {
>                         u64 bg_timeout = block_group->discard_eligible_time - now;
>
> -                       delay = max(delay, nsecs_to_jiffies(bg_timeout));
> +                       delay = max(delay, bg_timeout);
>                 }
>
>                 mod_delayed_work(discard_ctl->discard_workers,
> -                                &discard_ctl->work, delay);
> +                                &discard_ctl->work, nsecs_to_jiffies(delay));
>         }
>  out:
>         spin_unlock(&discard_ctl->lock);
> @@ -555,7 +555,7 @@ void btrfs_discard_calc_delay(struct btrfs_discard_ctl *discard_ctl)
>
>         delay = clamp(delay, BTRFS_DISCARD_MIN_DELAY_MSEC,
>                       BTRFS_DISCARD_MAX_DELAY_MSEC);
> -       discard_ctl->delay = msecs_to_jiffies(delay);
> +       discard_ctl->delay_ms = delay;
>
>         spin_unlock(&discard_ctl->lock);
>  }
> @@ -687,7 +687,7 @@ void btrfs_discard_init(struct btrfs_fs_info *fs_info)
>         atomic_set(&discard_ctl->discardable_extents, 0);
>         atomic64_set(&discard_ctl->discardable_bytes, 0);
>         discard_ctl->max_discard_size = BTRFS_ASYNC_DISCARD_DEFAULT_MAX_SIZE;
> -       discard_ctl->delay = BTRFS_DISCARD_MAX_DELAY_MSEC;
> +       discard_ctl->delay_ms = BTRFS_DISCARD_MAX_DELAY_MSEC;
>         discard_ctl->iops_limit = BTRFS_DISCARD_MAX_IOPS;
>         discard_ctl->kbps_limit = 0;
>         discard_ctl->discard_extent_bytes = 0;
> --
> 2.24.0
>

Looks all fine to me.

Best regards,
Amy Parker
(they/them)
