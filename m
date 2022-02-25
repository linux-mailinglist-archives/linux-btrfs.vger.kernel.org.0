Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A484C3D91
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Feb 2022 06:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237470AbiBYFRa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Feb 2022 00:17:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbiBYFR3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Feb 2022 00:17:29 -0500
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1116FA23F;
        Thu, 24 Feb 2022 21:16:56 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id y4so4413957vsd.11;
        Thu, 24 Feb 2022 21:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YI624CeWI9F1Un2gJZmusBAPR0ogE5tqYAS2WUpf0us=;
        b=XRI0iJIbBg7tzwGHoTgZsR3OUpqvwYSFs8egTL3gP7sw4HWbPbxiQW4nv8iVLLjbyR
         PKKBUbSL84TbBdsbzxtuu28tlAOhxXdc3avwEgM5F6WAg/fnCTy41Vy4jbcQSSuFoXYq
         cFKZbE/fPcNllnQKHSUJgD4KW4ckkFwgFxkpfpYV9PEFi/BsmU3ON4aBT4zbP8SdHmCb
         NV5hpn4ps1DDaYiiXUDhi5j0C9P8AuGDtwzBpplkq0o/euqPodCq1MP1vigMhpjV49Vk
         nCdB9/rOY0tZy35gAvkPYCoPdY/CAesYiJQDZaSpwe3xAnKTxj7GcD/E7LvWNBVfBJG8
         kpyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YI624CeWI9F1Un2gJZmusBAPR0ogE5tqYAS2WUpf0us=;
        b=GaABnaqXtYurnxdjsz3f2QMDu5WUOSihUWI+8otz3fbPYyoRbaOgsDlkUbLV6hEHJ+
         gmYH4w5xn1oVW5UVC8glJA7ZmMDPl2HEbI/yFj+rzcalEpDUvmwmvhqFu78Qbz23sz2r
         yp5rjM88MHz9h9TvUY5cozJOpkUkjxZIKdUYjNXL+D1m5r6/Zw+ETg1xmLS1hOT1DfYM
         HiOcHflPiNRyTWSHKEx86W3v24kCVmENG8gPvUO7BsHBIBeZz8KzV0skjBhKfjIKZ5xJ
         fODNf6PDRawqEaCpb8pFsxIeluvbb300sjdIMg1LdmrX6ETU9vChH8/0JCI64Ugnh4fq
         ihaQ==
X-Gm-Message-State: AOAM533zaUsBLzoIr0vmod3SwQ5kSDwpSugUcS6vuvUUQQmXyh4wtAGB
        SF+lesMJBQc4njZiej1UTI2SGfeQ/O9sFtoPENIFy4YDWZwYpg==
X-Google-Smtp-Source: ABdhPJxRToTIe0juJIqTwtdLyel6cMUDMaMZd/qiWhRmTkjAwvw6Ofk/GDYWuDZ6PG/E+x1zOVqWOheP4e4HIHiWmBI=
X-Received: by 2002:a67:e14d:0:b0:31b:9356:40ff with SMTP id
 o13-20020a67e14d000000b0031b935640ffmr2740966vsl.51.1645766215755; Thu, 24
 Feb 2022 21:16:55 -0800 (PST)
MIME-Version: 1.0
References: <20220220144606.5695-1-jrdr.linux@gmail.com> <0a2e57ad-2973-ea01-ceda-3262cde1f5aa@gmx.com>
 <CAFqt6zZsv+bMwbdqrcOMCZE08O_q7DGa0ejVAbokLybsSch5fw@mail.gmail.com>
 <a1d126df-a5ee-d47d-bfaa-95b3b221e41a@suse.com> <b2536c4b-bf0f-a2ff-58cf-ef7d17acaf48@intel.com>
In-Reply-To: <b2536c4b-bf0f-a2ff-58cf-ef7d17acaf48@intel.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Fri, 25 Feb 2022 10:46:43 +0530
Message-ID: <CAFqt6zbCootaOTU3hGXZ0cBcMHoiNtXynzzG8oGw8R6fO4muhg@mail.gmail.com>
Subject: Re: [PATCH] btrfs: Initialize ret to 0 in scrub_simple_mirror()
To:     Yujie Liu <yujie.liu@intel.com>
Cc:     Qu Wenruo <wqu@suse.com>, Chris Mason <clm@fb.com>,
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

On Thu, Feb 24, 2022 at 3:18 PM Yujie Liu <yujie.liu@intel.com> wrote:
>
> Hi,
>
> Sorry for the noise of this false alert.
>
> For clang analyzer reports, usually we do internal check firstly. We'll send out the
> report only when we think that it is highly possible to be a true alert.
>
> We scanned our report history and found this report was produced on 1/26, but it was
> still in the internal check domain and was not likely to be sent to Qu or mailing lists,
> so we are kind of confusing about this consequence.
>
> Souptick, could you help to provide the original report by link or attachment?

https://marc.info/?l=linux-mm&m=164487037605771&w=2

> Then we can do some check to figure out whether we have any flaw in our process.
>
> Thanks,
> Yujie
>
> On 2/22/2022 16:04, Qu Wenruo wrote:
> >
> >
> > On 2022/2/22 15:50, Souptick Joarder wrote:
> >> On Mon, Feb 21, 2022 at 5:46 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> >>>
> >>>
> >>>
> >>> On 2022/2/20 22:46, Souptick Joarder wrote:
> >>>> From: "Souptick Joarder (HPE)" <jrdr.linux@gmail.com>
> >>>>
> >>>> Kernel test robot reported below warning ->
> >>>> fs/btrfs/scrub.c:3439:2: warning: Undefined or garbage value
> >>>> returned to caller [clang-analyzer-core.uninitialized.UndefReturn]
> >>>>
> >>>> Initialize ret to 0.
> >>>>
> >>>> Reported-by: kernel test robot <lkp@intel.com>
> >>>> Signed-off-by: Souptick Joarder (HPE) <jrdr.linux@gmail.com>
> >>>
> >>> Although the patch is not yet merged, but I have to say, it's a false alert.
> >>
> >> Yes, I agree it is a false positive but this patch will at least keep
> >> kernel test robot happy :)
> >
> > I'd say we should enhance the compiler to fix the false alert.
> >
> > Thus adding LLVM list here is correct.
> >
> >
> > To me, the root problem is that, we lack the hint to allow clang to know that, @logical_length passed in would not cause u64 overflow.
> >
> > Unfortunately the sanity check to prevent overflow is hidden far away inside tree-checker.c.
> >
> > Maybe some ASSERT() for overflow check would help LLVM to know that?
> >
> > Thanks,
> > Qu
> >
> >>>
> >>> Firstly, the while loop will always get at least one run.
> >>>
> >>> Secondly, in that loop, we either set ret to some error value and break,
> >>> or after at least one find_first_extent_item() and scrub_extent() call,
> >>> we increase cur_logical and reached the limit of the while loop and exit.
> >>>
> >>> So there is no possible routine to leave @ret uninitialized and returned
> >>> to caller.
> >>>
> >>> Thanks,
> >>> Qu
> >>>
> >>>> ---
> >>>>    fs/btrfs/scrub.c | 2 +-
> >>>>    1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> >>>> index 4baa8e43d585..5ca7e5ffbc96 100644
> >>>> --- a/fs/btrfs/scrub.c
> >>>> +++ b/fs/btrfs/scrub.c
> >>>> @@ -3325,7 +3325,7 @@ static int scrub_simple_mirror(struct scrub_ctx *sctx,
> >>>>        const u32 max_length = SZ_64K;
> >>>>        struct btrfs_path path = {};
> >>>>        u64 cur_logical = logical_start;
> >>>> -     int ret;
> >>>> +     int ret = 0;
> >>>>
> >>>>        /* The range must be inside the bg */
> >>>>        ASSERT(logical_start >= bg->start &&
> >>
> >
