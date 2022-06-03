Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7A8253D260
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jun 2022 21:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349284AbiFCTav (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Jun 2022 15:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349283AbiFCTau (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Jun 2022 15:30:50 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631E75A0BA
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Jun 2022 12:30:49 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id y29so9438483ljd.7
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Jun 2022 12:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PThABRmxbBiN9eWSZXt5B0ivbhoOQ0+Hx/lkUF8W3kM=;
        b=fsTVcCrq9E4OLjANgqtNcVrw4DbSNCDvnFL3GHrvQ/nhnzTROkvK9XeTdkbFtwynqN
         uiAQ9dSTeiCRO/qPdfvdx/NSvFLlhvaowpr/t/PjuQbIupzmIoGturPi3+pX23i0Ynwb
         IXyl+QRnGNSOhSI6uAAVaD35902TbJTmIgxcj/Oum4+dqki22x/zFz+k+BVg3vDUNf5R
         c8MMSrModfiXZb1tR2j7DNvpPSlwKTKcxss8YZAG03KX5W2WsaKOkAAJNYfMrRpOLyrp
         Ae/p7m2hR9gAOuOiY/9oRvJ467Aj9kBKc6JELY/Qamq1ZSvIlJrJOExrN2/CgWAPLP1P
         heHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PThABRmxbBiN9eWSZXt5B0ivbhoOQ0+Hx/lkUF8W3kM=;
        b=rgvgKTFlAbhTm+nbXpMHjMmf7DdewmVs+DKO+f1F6ZRPZA59fSU5+XGj4weomIYok2
         H+gJUPLgrDXGSAg31BsNN6O5dBzlcRdtKuJtVJ9qyAi7aD/R3nxKxFtFRwMYquqynHPz
         T79BfqtHOR5egrSxUORx+YniM3mX9mgVN+CxGNzOymHWutQMA6yYPjL0n+loCKUks7Qy
         Pi+cxO9g/Ivn7hy/zklJz2nYJSgEqMBcDj4BMUHTSiwnJ556614QUxaN4E7IV2iszltL
         3rqx9JPw1jQZLPbzqkBB84LftlmbABeCIol3XPLplLiQdzsiUmwdK6PcNijbOL2S7mPb
         e6Og==
X-Gm-Message-State: AOAM530gJywx7wIVcvFvnCyd3Qyn0JVoiyRBvptWLdRSi8YSC9eLN+l0
        jfmRQNZG5M/j4oZpfOEkyBVu2ua7vKHmpGMg9vpmGVrYUEtWotFk
X-Google-Smtp-Source: ABdhPJw5PQ4ADcd1eYQgpfoVla6JPAAtXZrvaIh+xu+D3AEn11YS9oA3qO+xweAHxhgZSJZVQ44g8V8Ds5j5h0PkN6M=
X-Received: by 2002:a2e:9a82:0:b0:255:77fd:1c2c with SMTP id
 p2-20020a2e9a82000000b0025577fd1c2cmr4752342lji.357.1654284647176; Fri, 03
 Jun 2022 12:30:47 -0700 (PDT)
MIME-Version: 1.0
References: <CA+H1V9xQEDf0G-Nvcv3irtSPF+09dJ6VMs7F8LBLpUGEUSfxmg@mail.gmail.com>
 <7762988d-0a64-695a-4ccd-ba7b51c0754a@gmx.com> <CA+H1V9wSZXVrLdz9ZELx8gc3nOHOJz4b48DQMFcmc8cTEJgXAQ@mail.gmail.com>
 <760a98d8-3524-d24f-b5f9-3653ee46661d@gmx.com> <CA+H1V9wD0Ndrnt5bV85nJPd7Go3gbyTs0K5pZBCybvwbeB3z3w@mail.gmail.com>
 <CA+H1V9wbYyBLH550-kUNNzAYJ9QRfCjmdi6yFrhos=u7t8W8sg@mail.gmail.com>
In-Reply-To: <CA+H1V9wbYyBLH550-kUNNzAYJ9QRfCjmdi6yFrhos=u7t8W8sg@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Fri, 3 Jun 2022 15:30:30 -0400
Message-ID: <CAJCQCtQHRw=8JkAx716n+O_b6jFKWSqYAf8BMb5KLkxSwowm0Q@mail.gmail.com>
Subject: Re: Manual intervention options for csum errors
To:     Matthew Warren <matthewwarren101010@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jun 3, 2022 at 1:05 PM Matthew Warren
<matthewwarren101010@gmail.com> wrote:
>
> > >> This is not a good sign.
> > >>
> > >> Such bitflip can only happen in memory, as if it's a bitflip from disk,
> > >> then it will cause the metadata csum mismatch.
> > >>
> > >> So this means, your memory is unreliable, and a memtest is strongly
> > >> recommended before doing anything.
> > >
> > > I don't think that's the case. The files were last modified all the
> > > way back in 2020, but there hasn't been any file modifications near
> > > them since the end of April this year.
> >
> > Since the bitflip is in csum tree, it doesn't matter if that specific
> > file get modified.
> >
> > Any other file modification can trigger CoW on that csum tree block.
> >
> > > There's also been 2 scrubs
> > > before the last one where there were no issues at all. Does this mean
> > > that at some point in the last half month (since that's the time
> > > between the last successful scrub and the scrub which errored) BTRFS
> > > read and re-wrote the file to disk?
> >
> > I'd say yes. And it doesn't even need to modify that specific file.
> >
> > That's why memory bitflip is so concerning.
> >
> > Thanks,
> > Qu
>
> Would using BTRFS raid 1 add resiliency to this particular issue?

No, the corruption from bad RAM will affect both copies. So you really
need to do a thorough memory test.

-- 
Chris Murphy
