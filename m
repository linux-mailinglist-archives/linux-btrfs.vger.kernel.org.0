Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5137E373E9E
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 May 2021 17:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbhEEPge (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 May 2021 11:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233487AbhEEPgc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 May 2021 11:36:32 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B72C061574
        for <linux-btrfs@vger.kernel.org>; Wed,  5 May 2021 08:35:35 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id p15so2090095iln.3
        for <linux-btrfs@vger.kernel.org>; Wed, 05 May 2021 08:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vI5N++2M5vM4eoFPeUjEJkFfUl2hmd9bV5XY83Vp/dg=;
        b=GIIfqrS2b7SYH6lU4jMOskwmnsGXawI5puCCWpcxrNySCIXpf/R3YzbN53gnHheVBY
         bAjQoPeBsQkaxOJq+5zjMbvVnOIKkFk8OVbSHZLsbm981SaUXE6QMffSdd+p60JlF0ZG
         922rWqk9vtxCIioRBJCX5H9Oxf3xvakADD1AiHpItZbxKFOVoBE1qom2H5QiQ/O81FBY
         aKBbQ78BskbJl2LHERhfenfQw9P/0wynL4euQ4SqU8nUyE4thkXgs8zdVRtVhpCAHp3e
         YBVPLfXilB0KJGgrbVT7Wr4IVUkJXWpQjhrlwXQJ6R5tuT9k72+aQ/gZDv2vo38QtWqe
         2Vpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vI5N++2M5vM4eoFPeUjEJkFfUl2hmd9bV5XY83Vp/dg=;
        b=dFG3eRlZjN+qQ34Aay9eLnW7ewdjO8PLyRbuNbxjebLpS+tWUI9BGuH3ussTsgmnRm
         TmVAHE6LyQZoo/mMc1dDiBa21j+/mlCS5uE0u9k1ydBG7llE41LcPYajWBguujPYG/Op
         90ikbUcViQTeYxFGoSMclxfJA+fY/u5MBOHFdZUVGOtJHnwV6kcvtUtf+NQp67Zyf/dg
         BJuRtfA32w6zIkcaY9tEM5WAH3e5jvD3CDt2pSEuXMOOE6sS+UIRQpkuhm7yOd7tY7aV
         tfGfuM7AQ0qN9pzw12vtI0YMBlzX/sqXpgZeLCj65Dldo/e0KauBTDPlqqxyIyPJbCVD
         jNuA==
X-Gm-Message-State: AOAM530qUJOKacr3Hj/MxD3FbEj9UUDSoEurQRaWXIZKbQUPzPkekGtd
        0pYpys7swrvrIOJKA9m1deyX33ZALwnXVZ8ZTbAP1jzNjwo=
X-Google-Smtp-Source: ABdhPJyvkzygDUEuJQlATtS1bovfvjobhhk4NahouCIsmNXVDpg8xgj24TkSqo/vB0+OdeJy3Pt7+xPFfemfCxW+qa4=
X-Received: by 2002:a92:d3c1:: with SMTP id c1mr25954344ilh.21.1620228934379;
 Wed, 05 May 2021 08:35:34 -0700 (PDT)
MIME-Version: 1.0
References: <CADOXG6Fj3zCzu46q-nLKOdszxQHPGLk6r5rDn80KNLKY5sn3iQ@mail.gmail.com>
 <20210505144949.GB32440@hungrycats.org>
In-Reply-To: <20210505144949.GB32440@hungrycats.org>
From:   Abdulla Bubshait <darkstego@gmail.com>
Date:   Wed, 5 May 2021 11:35:23 -0400
Message-ID: <CADOXG6H7U7grsq0nmEgykYKMwSfOxKiwB0tSaz3_sJAVTGigCA@mail.gmail.com>
Subject: Re: Array extremely unbalanced after convert to Raid5
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 5, 2021 at 10:49 AM Zygo Blaxell
<ce3g8jdj@umail.furryterror.org> wrote:
>
> Balancing a full single array to raid5 requires a better device selection
> algorithm than the kernel provides, especially if the disks are of
> different sizes and were added to the array over a long period of time.
> The kernel will strictly relocate the newest block groups first, which
> may leave space occupied on some disks for most of the balance, and
> cause many chunks to be created with suboptimal stripe width.
>

Is this also true of running a full balance after conversion to raid5?
Is it able to optimize the stripe width or would a balance run into
the same issue due to
the disks being full?


> Now use the stripes filter to get rid of all chunks that have fewer
> than the optimum number of stripes on each disk.  Cycle through these
> commands until they report 0 chunks relocated (you can just leave these
> running in a shell loop and check on it every few hours, when they get
> to 0 they will just become no-ops):
>
>         btrfs balance start -dlimit=100,convert=raid5,stripes=1..3,devid=3 /fs
>
>         btrfs balance start -dlimit=100,convert=raid5,stripes=1..2,devid=2 /fs
>
>         btrfs balance start -dlimit=100,convert=raid5,stripes=1..1,devid=1 /fs
>
>         btrfs balance start -dlimit=100,convert=raid5,stripes=1..1,devid=4 /fs
>
> The filters select chunks that have undesirable stripe counts and force
> them into raid5 profile.  Single chunks have stripe count 1 and will
> be converted to raid5.  RAID5 chunks have stripe count >1 and will be
> relocated (converted from raid5 to raid5, but in a different location
> with more disks in the chunk).  RAID5 chunks that already occupy the
> correct number of drives will not be touched.

That is what I was looking to do, I must have missed the stripes
filter. I think I can figure out a script that is able to spread the
data enough.

But here is a question. At what point does the fs stop striping onto a
disk? Does it stop at 1MB unallocated and if so does that cause issues
in practice if the need arises to allocate metadata chunks due to
raid1c3?
