Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E77474BF2EA
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Feb 2022 08:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiBVHvZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Feb 2022 02:51:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiBVHvX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Feb 2022 02:51:23 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D2D145E00;
        Mon, 21 Feb 2022 23:50:58 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id j3so5986735vsi.7;
        Mon, 21 Feb 2022 23:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uzFl6sqnppLbE/reSAw0Z5UcOZ1BcsboAOECKBIl91c=;
        b=a5Xuu8aA+xACIZl3B7LWvPIlbuhmt8vIyo1mz/GH3brKs0JizVcUTzmv1gQTT5Iin6
         YrdNLDg2lBUZ9srG4BI/EDO45xLd2v6rUtqD1R5Nh9Xw9DqnJ+PhEclWzGdVv40daqPU
         RkGgdc1v3DfbQHPx8rB1EV4i7YLQGQSkPttx0meFhXJhA42rgK+XGl3CAW/LqFX4nzpo
         g+3m9nXNPC3YKj0507M7//7Hg6mln+Y1UhYFA/7POLikvUd0mz6g5VF5plkog765RCiT
         f3pUlGVT+hRIEoY5L2/S+HvSgl45GLQBndPIu9m7vgDyOw3FUpAuYTZFyRGKZ5kDCxc8
         QwZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uzFl6sqnppLbE/reSAw0Z5UcOZ1BcsboAOECKBIl91c=;
        b=lI4byn5gyVmdCP4GXj1bQDNgR5QfhqBtGOty8VaP1chgiC0HhBIEr9g5GIXghTXoEo
         FXnWA2B8CoTtMpLOOPgByu8j2eHN+8dcZUTqFdYLq6IEUAT6NrBWb3F7KDw+nRODY4Ay
         FnOGtRoFahgNGScSokr6SJGAai6nAQ+BCYFekfFWMavNxc9fBEUMt5LuWRiOOOzauItK
         2zDvw9FmWvET29CaRpUzjb4rCeczpsWhNgReQv4u1HJFd6jjYF2pluBrb6lQ/j/pXCuH
         MBDwZYkqa9HkDRrdJMXdKDo5houMcSyF6ZCQqPu6cGYe2wnnIMbvdGLd2rz8kmlAozAi
         Exbg==
X-Gm-Message-State: AOAM533IUGYpPDpuR3U4wbhrl+O1pEFC9AQQUL54xbMdfTql5fgo0ogU
        rc9iKgk9BZGA+3/uzvbTYkYNVLiTIh/XoTThstk=
X-Google-Smtp-Source: ABdhPJzocCr94zTr+ZAkP6jgRQmORnoaN5tSWsl5OKqascjV1wkde9J5Fpxth9MD5BMsQ4o3FzhOKRbu7zx2QdnUrnA=
X-Received: by 2002:a67:eb9a:0:b0:31b:db46:4c82 with SMTP id
 e26-20020a67eb9a000000b0031bdb464c82mr8999722vso.38.1645516257285; Mon, 21
 Feb 2022 23:50:57 -0800 (PST)
MIME-Version: 1.0
References: <20220220144606.5695-1-jrdr.linux@gmail.com> <0a2e57ad-2973-ea01-ceda-3262cde1f5aa@gmx.com>
In-Reply-To: <0a2e57ad-2973-ea01-ceda-3262cde1f5aa@gmx.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Tue, 22 Feb 2022 13:20:45 +0530
Message-ID: <CAFqt6zZsv+bMwbdqrcOMCZE08O_q7DGa0ejVAbokLybsSch5fw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: Initialize ret to 0 in scrub_simple_mirror()
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        dsterba@suse.com, nathan@kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Feb 21, 2022 at 5:46 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2022/2/20 22:46, Souptick Joarder wrote:
> > From: "Souptick Joarder (HPE)" <jrdr.linux@gmail.com>
> >
> > Kernel test robot reported below warning ->
> > fs/btrfs/scrub.c:3439:2: warning: Undefined or garbage value
> > returned to caller [clang-analyzer-core.uninitialized.UndefReturn]
> >
> > Initialize ret to 0.
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Souptick Joarder (HPE) <jrdr.linux@gmail.com>
>
> Although the patch is not yet merged, but I have to say, it's a false alert.

Yes, I agree it is a false positive but this patch will at least keep
kernel test robot happy :)
>
> Firstly, the while loop will always get at least one run.
>
> Secondly, in that loop, we either set ret to some error value and break,
> or after at least one find_first_extent_item() and scrub_extent() call,
> we increase cur_logical and reached the limit of the while loop and exit.
>
> So there is no possible routine to leave @ret uninitialized and returned
> to caller.
>
> Thanks,
> Qu
>
> > ---
> >   fs/btrfs/scrub.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> > index 4baa8e43d585..5ca7e5ffbc96 100644
> > --- a/fs/btrfs/scrub.c
> > +++ b/fs/btrfs/scrub.c
> > @@ -3325,7 +3325,7 @@ static int scrub_simple_mirror(struct scrub_ctx *sctx,
> >       const u32 max_length = SZ_64K;
> >       struct btrfs_path path = {};
> >       u64 cur_logical = logical_start;
> > -     int ret;
> > +     int ret = 0;
> >
> >       /* The range must be inside the bg */
> >       ASSERT(logical_start >= bg->start &&
