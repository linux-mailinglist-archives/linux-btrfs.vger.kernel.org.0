Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59A1E2A67A3
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Nov 2020 16:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730245AbgKDP3Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Nov 2020 10:29:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730196AbgKDP3P (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Nov 2020 10:29:15 -0500
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B5AC0613D3
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Nov 2020 07:29:14 -0800 (PST)
Received: by mail-oo1-xc41.google.com with SMTP id l4so601815oos.7
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Nov 2020 07:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KMJnWqVtiUqJyCWV1g8Xa59THK5Gud7UZMLHyBYsRO8=;
        b=E8GlDDUpTa2xu4DAlUG+8mHM+Zdu+N9oWUMzNN4z2kQIc0kJh28nfKsohswQg3kAyU
         rKxFRwJPR6hQrl5a0x/tAljNAo9asFwpnDJqQmqrkuusd62hEGNPjeSsHVaKAw5jLrzL
         2CvYNfGtDAlpN08blm80Hzbhrhm2ncT0ZCUY+jveRFiMlqcaj6YgyRKZbPwCbS+UVcH0
         5DYORLuZXlLR4UWAHrzhb+2qdD8/9WGxH6HGTiEU5M5HetfBsbKWa7cPYUOB4dVSx4x7
         Xm+954FQ85elgWDmuXiLbBYqLW9cWP+gOTVK/cSKhtF2QJ2pgAV1Vny+AdF6WHUbM5Z+
         PQTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KMJnWqVtiUqJyCWV1g8Xa59THK5Gud7UZMLHyBYsRO8=;
        b=T1Z9dRLvMo8PMZOIC5vtwG1tt4D+L2VneQZTIByWd1nr8hu6CVhHBwufYznjFWyMvl
         sc469qGgzTIN9pXqrm50HHnmwVPXRtXV8j9JFBHWS+Kt56vDbQLKQoWa2v9rbPH5sP8w
         fha1X0MWrylcQ5+MSO+KGE6Xt0kNSCeQoMu0P9fGCSBcVKxr5oA3KxP071I/lZwHfowB
         yVYeymlRQB74xNPZtd0tvndyNthXobIdR6t3FcyJ3ZdoQuThc/BfDiIGzJ9/MhRnchrj
         SDSX8ZnB00sz8TxvyfteJfCSxEUb6lNPVUejhxvs1Gub8oCi389k0AO45mk/FGiAvkQM
         Z71w==
X-Gm-Message-State: AOAM533wWweFZtdf7Iud1/0d7dMQz/rIe04gSX/6ueHZVnqGqzAYc8pm
        6bq/Rr1bQKuRSNFeP3MmbNft4dwlkpZDj1SESWc=
X-Google-Smtp-Source: ABdhPJwkFxgQrr9244Ca9+onYd2xF7krojzy1ZOFF+ucI/EU8j848Z3meekwsNIsg/4sJfvhrdSDTiIyj/MAF6kYS14=
X-Received: by 2002:a4a:9cc3:: with SMTP id d3mr19072528ook.4.1604503754239;
 Wed, 04 Nov 2020 07:29:14 -0800 (PST)
MIME-Version: 1.0
References: <cover.1604444952.git.asml.silence@gmail.com> <2a3d84dfc9384eed8659963d1dafedabb3f17c75.1604444952.git.asml.silence@gmail.com>
In-Reply-To: <2a3d84dfc9384eed8659963d1dafedabb3f17c75.1604444952.git.asml.silence@gmail.com>
From:   Amy Parker <enbyamy@gmail.com>
Date:   Wed, 4 Nov 2020 07:29:03 -0800
Message-ID: <CAE1WUT5+3xLHe54Mk0wEmp1GtbRhkMkdSi=QPERZegphk=ecLw@mail.gmail.com>
Subject: Re: [PATCH 1/4] btrfs: discard: speed up discard up to iops_limit
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 4, 2020 at 1:50 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
>
> Instead of using iops_limit only for cutting off extremes, calculate the
> discard delay directly from it, so it closely follows iops_limit and
> doesn't under-discarding even though quotas are not saturated.

This sounds like it potentially be a great performance boost, do you
have any performance metrics regarding this patch?

>
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
>  fs/btrfs/discard.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
> index 741c7e19c32f..76796a90e88d 100644
> --- a/fs/btrfs/discard.c
> +++ b/fs/btrfs/discard.c
> @@ -519,7 +519,6 @@ void btrfs_discard_calc_delay(struct btrfs_discard_ctl *discard_ctl)
>         s64 discardable_bytes;
>         u32 iops_limit;
>         unsigned long delay;
> -       unsigned long lower_limit = BTRFS_DISCARD_MIN_DELAY_MSEC;
>
>         discardable_extents = atomic_read(&discard_ctl->discardable_extents);
>         if (!discardable_extents)
> @@ -550,11 +549,12 @@ void btrfs_discard_calc_delay(struct btrfs_discard_ctl *discard_ctl)
>
>         iops_limit = READ_ONCE(discard_ctl->iops_limit);
>         if (iops_limit)
> -               lower_limit = max_t(unsigned long, lower_limit,
> -                                   MSEC_PER_SEC / iops_limit);
> +               delay = MSEC_PER_SEC / iops_limit;
> +       else
> +               delay = BTRFS_DISCARD_TARGET_MSEC / discardable_extents;

Looks good to me. I wonder why there wasn't handling of if iops_limit
was unfindable
before?

>
> -       delay = BTRFS_DISCARD_TARGET_MSEC / discardable_extents;
> -       delay = clamp(delay, lower_limit, BTRFS_DISCARD_MAX_DELAY_MSEC);
> +       delay = clamp(delay, BTRFS_DISCARD_MIN_DELAY_MSEC,
> +                     BTRFS_DISCARD_MAX_DELAY_MSEC);
>         discard_ctl->delay = msecs_to_jiffies(delay);
>
>         spin_unlock(&discard_ctl->lock);
> --
> 2.24.0
>

This patch looks all great to me.

Best regards,
Amy Parker
(they/them)
