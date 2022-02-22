Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA7A4BF331
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Feb 2022 09:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbiBVIKX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Feb 2022 03:10:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiBVIKW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Feb 2022 03:10:22 -0500
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9151516BC;
        Tue, 22 Feb 2022 00:09:58 -0800 (PST)
Received: by mail-ua1-x92b.google.com with SMTP id k5so3376959uao.2;
        Tue, 22 Feb 2022 00:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rNUlZ9WlMz/js+2zPgbd3d3iplRTIRckUNmfnnX+KWM=;
        b=qcnTsYNOiGwWL/iGe1tnCtR305MAs7FNyolLmASeYF64GJ2m56jp1CoRHlcBe8KVLK
         bIB2N6SVtq1sYhnyLWiXqp3Tnre+vXO+rGqxxd2QNBoXZ30sZ9/OtPmW2zPH3uCsSCfa
         DgfNCn/dM1nksn/EXmn2NFUR44xwzK7treModBk3GeQbndBs3LRALDOuV5IRD6dwDSNk
         Arrh1pm2RVeWJMQ6GXjpNCfiTmTVYZRFWTXpm7EJ9L/yYAUZW3myJUAUOkLRhAutR8NU
         hlupIjaWqWb5ajde4U+/Usy5j06QJuKqgcusLyx0YMYePnfELzKWPiQPV5zYKdH6CVnE
         qA3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rNUlZ9WlMz/js+2zPgbd3d3iplRTIRckUNmfnnX+KWM=;
        b=w2PtUdAfmMsyYcppsFzP0QA11ijpIyaSD4KjuLDQds/gamXsWSyHGx2XhpkcjS9jjz
         cpW8Bn+/LoenlHEvUL3YErQvp2YrIbAsWHOaxlwAxcvBeb7AGmjIus/3mo0jULlJJK+y
         zyfpS3lvkXp/dddhvl3c2E+qjyPx80jBOpfguy6gH9Cf6opHZwc6g9+qnj/yZBF5UPH2
         ymyGAF+rP/uljzdvnhGxracIdbxW84Jx3V2Zkrq9p2kJq4g18BI54eo3rbADY9Yi2F+F
         lEFVPBP1ZM/9RVkQglIUv0imNjSrI5lU+uXfNP8kO5l7XZ9SYgiSFrDm4aZpcheODc2Q
         yXnQ==
X-Gm-Message-State: AOAM532/r3/BNopHd6SOKkvpFMBQi2kxuA9wTBtdqZ4EImbm5A9iGy/h
        5rcJsd6NjpLVtQKwhbnnU4tJ+iCYP6SqXLGeNlA=
X-Google-Smtp-Source: ABdhPJz1ThsZFtrkOPkN5AmZWUPmOZsvHH4xj9LeYLtIVYaVVuDtwsRefSFkRtkSVase0gmBBg0gcbKi5LtBT17ELgw=
X-Received: by 2002:ab0:16d9:0:b0:342:4791:1b86 with SMTP id
 g25-20020ab016d9000000b0034247911b86mr4010668uaf.82.1645517397183; Tue, 22
 Feb 2022 00:09:57 -0800 (PST)
MIME-Version: 1.0
References: <20220220144606.5695-1-jrdr.linux@gmail.com> <0a2e57ad-2973-ea01-ceda-3262cde1f5aa@gmx.com>
 <CAFqt6zZsv+bMwbdqrcOMCZE08O_q7DGa0ejVAbokLybsSch5fw@mail.gmail.com> <a1d126df-a5ee-d47d-bfaa-95b3b221e41a@suse.com>
In-Reply-To: <a1d126df-a5ee-d47d-bfaa-95b3b221e41a@suse.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Tue, 22 Feb 2022 13:39:45 +0530
Message-ID: <CAFqt6zZQyA2TC=H7FemimaM++j6ncX43anOtWsOFEV9=46hONg@mail.gmail.com>
Subject: Re: [PATCH] btrfs: Initialize ret to 0 in scrub_simple_mirror()
To:     Qu Wenruo <wqu@suse.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, dsterba@suse.com,
        nathan@kernel.org, Nick Desaulniers <ndesaulniers@google.com>,
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

On Tue, Feb 22, 2022 at 1:34 PM Qu Wenruo <wqu@suse.com> wrote:
>
>
>
> On 2022/2/22 15:50, Souptick Joarder wrote:
> > On Mon, Feb 21, 2022 at 5:46 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> >>
> >>
> >>
> >> On 2022/2/20 22:46, Souptick Joarder wrote:
> >>> From: "Souptick Joarder (HPE)" <jrdr.linux@gmail.com>
> >>>
> >>> Kernel test robot reported below warning ->
> >>> fs/btrfs/scrub.c:3439:2: warning: Undefined or garbage value
> >>> returned to caller [clang-analyzer-core.uninitialized.UndefReturn]
> >>>
> >>> Initialize ret to 0.
> >>>
> >>> Reported-by: kernel test robot <lkp@intel.com>
> >>> Signed-off-by: Souptick Joarder (HPE) <jrdr.linux@gmail.com>
> >>
> >> Although the patch is not yet merged, but I have to say, it's a false alert.
> >
> > Yes, I agree it is a false positive but this patch will at least keep
> > kernel test robot happy :)
>
> I'd say we should enhance the compiler to fix the false alert.
>
> Thus adding LLVM list here is correct.

Hmm, kernel test robot reported similar false alert in few other
modules as well.

>
>
> To me, the root problem is that, we lack the hint to allow clang to know
> that, @logical_length passed in would not cause u64 overflow.
>
> Unfortunately the sanity check to prevent overflow is hidden far away
> inside tree-checker.c.
>
> Maybe some ASSERT() for overflow check would help LLVM to know that?
>
> Thanks,
> Qu
>
> >>
> >> Firstly, the while loop will always get at least one run.
> >>
> >> Secondly, in that loop, we either set ret to some error value and break,
> >> or after at least one find_first_extent_item() and scrub_extent() call,
> >> we increase cur_logical and reached the limit of the while loop and exit.
> >>
> >> So there is no possible routine to leave @ret uninitialized and returned
> >> to caller.
> >>
> >> Thanks,
> >> Qu
> >>
> >>> ---
> >>>    fs/btrfs/scrub.c | 2 +-
> >>>    1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> >>> index 4baa8e43d585..5ca7e5ffbc96 100644
> >>> --- a/fs/btrfs/scrub.c
> >>> +++ b/fs/btrfs/scrub.c
> >>> @@ -3325,7 +3325,7 @@ static int scrub_simple_mirror(struct scrub_ctx *sctx,
> >>>        const u32 max_length = SZ_64K;
> >>>        struct btrfs_path path = {};
> >>>        u64 cur_logical = logical_start;
> >>> -     int ret;
> >>> +     int ret = 0;
> >>>
> >>>        /* The range must be inside the bg */
> >>>        ASSERT(logical_start >= bg->start &&
> >
>
