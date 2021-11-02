Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9096644308A
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Nov 2021 15:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhKBOih (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Nov 2021 10:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbhKBOih (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Nov 2021 10:38:37 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C85C061714
        for <linux-btrfs@vger.kernel.org>; Tue,  2 Nov 2021 07:36:02 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id s186so29476020yba.12
        for <linux-btrfs@vger.kernel.org>; Tue, 02 Nov 2021 07:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SYil15jWr5CRlFoW8GLSwS7jX/sPu73o0181WhkgJCo=;
        b=j+OMiKv/x+Q5R9Vep0Y/mvZEX9jHHFzpu7l5fHrzlreeN+udHrdrMaa+q8cwigflHS
         AZoU/FFC6QhniTlboxZoMQ8jMOx8KABa8OGn3z+ZiRfVaZovWEn79gidIVgcmKnV02FD
         3ueJXfV6A1i7YYV8mtnmBRIfyMC9VS2k54M8seRhWW65TLWnq8LC8nnBC13n3IAgaOE9
         Do0N1SBU+EWpoJ8Dfg+gkZB9OpVAVt910h4UGUr9Y5ZS13j+P3sBEsGpTFvMC61pH7OW
         4CaEocJeedpBuzdSimy+A7eIEv1SgVkV7EB65q7MPYhHW/7ujJNEsPvaIjkPze9YxMGb
         0XcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SYil15jWr5CRlFoW8GLSwS7jX/sPu73o0181WhkgJCo=;
        b=Z2KNRZrlbQT7eJxPu/UKjI2cEvp8w8LaHuGnQP1YRHZrf98HK+6tgR0KEI6RpYzUV7
         gEaWvbXZx6EqQp1paazW94+RY4vSEQjDP4JzxzxMkQN2+cWP3HMfbuEEX3MZgVPjhJGe
         xqHWh5jO/Fq7Hy9YMj5RO5h7tmzZwQfEO2mUbl0clZXNSOg+L5awTJ19TMqdH+WPZRgw
         I0/9Rg7Gh3GQ9sPTzCVNLbqBSLuVGJdbtMNOjX6UKeSWYVT96diwSCTQ+BxJhiEEFtJM
         hJD3iEMgLcggB7oU28OhAAR8+6Sp+pky5fQeIPAXxoP1mOF1pj+hYfMEIFLiW46JWon5
         bSWQ==
X-Gm-Message-State: AOAM532fZoh929knrOvzqFHJnKtCrTaABdSSfI4FP3gV60aJ+A5OKeD0
        F1q7dn5mGAEWrfgqgoSxhkBy/NUO3YWXedSdLaFNXg==
X-Google-Smtp-Source: ABdhPJzLDdMbmFGAAJ3hAzGi2tpCwpvFcxcIQw3uu3gsRKlr0qoExB4YXoFFMxsRX11RrEkmOunYGVVQLEnk9M6x6Iw=
X-Received: by 2002:a25:4d83:: with SMTP id a125mr39721121ybb.277.1635863761750;
 Tue, 02 Nov 2021 07:36:01 -0700 (PDT)
MIME-Version: 1.0
References: <20211102124916.433836-1-nborisov@suse.com>
In-Reply-To: <20211102124916.433836-1-nborisov@suse.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 2 Nov 2021 10:35:45 -0400
Message-ID: <CAJCQCtTD3yxU8oHtDzBHakc1vMXK_zAjmoigNCUHM=if=oZjzg@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix memory ordering between normal and ordered
 work functions
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Chris Murphy <lists@colorremedies.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 2, 2021 at 8:49 AM Nikolay Borisov <nborisov@suse.com> wrote:
>
> Ordered work functions aren't guaranteed to be handled by the same thread
> which executed the normal work functions. The only way execution between
> normal/ordered functions is synchronized is via the WORK_DONE_BIT,
> unfortunately the used bitops don't guarantee any ordering whatsoever.
>
> This manifested as seemingly inexplicable crashes on arm64, where
> async_chunk::inode is seens as non-null in async_cow_submit which causes
> submit_compressed_extents to be called and crash occurs because
> async_chunk::inode suddenly became NULL. The call trace was similar to:
>
>     pc : submit_compressed_extents+0x38/0x3d0
>     lr : async_cow_submit+0x50/0xd0
>     sp : ffff800015d4bc20
>
>     <registers omitted for brevity>
>
>     Call trace:
>      submit_compressed_extents+0x38/0x3d0
>      async_cow_submit+0x50/0xd0
>      run_ordered_work+0xc8/0x280
>      btrfs_work_helper+0x98/0x250
>      process_one_work+0x1f0/0x4ac
>      worker_thread+0x188/0x504
>      kthread+0x110/0x114
>      ret_from_fork+0x10/0x18
>
> Fix this by adding respective barrier calls which ensure that all
> accesses preceding setting of WORK_DONE_BIT are strictly ordered before
> settint the flag. At the same time add a read barrier after reading of
> WORK_DONE_BIT in run_ordered_work which ensures all subsequent loads
> would be strictly ordered after reading the bit. This in turn ensures
> are all accesses before WORK_DONE_BIT are going to be strictly ordered
> before any access that can occur in ordered_func.
>
> Fixes: 08a9ff326418 ("btrfs: Added btrfs_workqueue_struct implemented ordered execution based on kernel workqueue")
> Reported-by: Chris Murphy <lists@colorremedies.com>
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=2011928
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>
> David,
>
> IMO this is stable material.
>
>  fs/btrfs/async-thread.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/fs/btrfs/async-thread.c b/fs/btrfs/async-thread.c
> index 309516e6a968..d39af03b456c 100644
> --- a/fs/btrfs/async-thread.c
> +++ b/fs/btrfs/async-thread.c
> @@ -234,6 +234,13 @@ static void run_ordered_work(struct __btrfs_workqueue *wq,
>                                   ordered_list);
>                 if (!test_bit(WORK_DONE_BIT, &work->flags))
>                         break;
> +               /*
> +                * Orders all subsequent loads after reading WORK_DONE_BIT,
> +                * paired with the smp_mb__before_atomic in btrfs_work_helper
> +                * this guarantees that the ordered function will see all
> +                * updates from ordinary work function.
> +                */
> +               smp_rmb();
>
>                 /*
>                  * we are going to call the ordered done function, but
> @@ -317,6 +324,13 @@ static void btrfs_work_helper(struct work_struct *normal_work)
>         thresh_exec_hook(wq);
>         work->func(work);
>         if (need_order) {
> +               /*
> +                * Ensures all memory accesses done in the work function are
> +                * ordered before setting the WORK_DONE_BIT.Ensuring the thread
> +                * which is going to executed the ordered work sees them.
> +                * Pairs with the smp_rmb in run_ordered_work.
> +                */
> +               smp_mb__before_atomic();
>                 set_bit(WORK_DONE_BIT, &work->flags);
>                 run_ordered_work(wq, work);
>         } else {
> --
> 2.25.1
>

Tested-by: Chris Murphy <chris@colorremedies.com>

-- 
Chris Murphy
