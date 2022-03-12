Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2B0B4D6B37
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Mar 2022 01:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbiCLADS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Mar 2022 19:03:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiCLADS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Mar 2022 19:03:18 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F8C65B3
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Mar 2022 16:02:13 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id z9-20020a05683020c900b005b22bf41872so7360424otq.13
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Mar 2022 16:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VHXiScQBkvlamojgfhsC3IL7pQirX7DEY3UipVx6qxw=;
        b=EkcR2erdeIQYx1yTwcxu2WFp5ZZQrqp8igw9GroJeLKWsLRoNZoOsDwPzowq3DJEC7
         NtuLIEL/jFdg9t0J6fUkE90lHyqBcyjiFvohqh+HMdxBA7E5uFLI+cTvD/V5PrUsxXkv
         EbMDQtEouM8amnye7zxrjsmTfzegQBMmI037A18m81dZAJb3t9fCoNSnmJqcwRftR1an
         Y1sFfWz7D4uWiibRhgWRIMp5NZbVssiOHNB8PVUs9Rpdh1INQmBJcLBySMIcW5f7kGYm
         I4qapheX/KrJNCcg5VLqCkCwAYYjmCR2p3qt1HtH//vDFRpVHMtxrRpGLBGIbTJ4oMza
         t2cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VHXiScQBkvlamojgfhsC3IL7pQirX7DEY3UipVx6qxw=;
        b=NyVRvZ3oe54O1pil1cIIxxi3t4W7PIn+h1hwM6y+kl4mKN4Z/dQJUDmVqUd38YZUcv
         GLSRAAF2rIFpM8Cz+cPZ/upO6i6OiPitKjQ1OTKSV+F4aLP0N5ADG+vAZHAR4lOeQ4mf
         k79Pz44kvrBJwAK6GznQipLRVpAHdBz5uVzqJcojAdIo36jgImYwyR5hLyePsJbRDryS
         m1toyQrj2P8ePcGT2SFrTvUzX+abtFFGZHF4NezgDBkm3bGADikxuv5+y3CP+uk3RYP0
         dJbOO+hkaJJwN5gvf71hu3TYY9W33nG0KOvweBIeFYlMhFQ4HBo61xl1j4uj5VKcXvc6
         Ovww==
X-Gm-Message-State: AOAM533i0g90czsBqksukppkKdWkphZ3QnYvVOMjBJtSaEJtyD/Tb1w6
        Nbz207WsFnjV0u3dwwwOjR+rNe5TDBYo8VtNPN0=
X-Google-Smtp-Source: ABdhPJxdNSn2OXkpKa8h9yTguJQKCVUbEV5370DBGvkuzR07ttXbVykpEde3LvDQ3nO31fg0UentorMIavp51oJFhi0=
X-Received: by 2002:a05:6830:4406:b0:5af:d53c:18f with SMTP id
 q6-20020a056830440600b005afd53c018fmr6098582otv.236.1647043332365; Fri, 11
 Mar 2022 16:02:12 -0800 (PST)
MIME-Version: 1.0
References: <CAODFU0rZEy064KkSK1juHA6=r2zC4=Go8Me2V2DqHWb-AirL-Q@mail.gmail.com>
 <CAODFU0q56n3UxNyZJYsw2zK0CQ543Fm7fxD6_4ZSfgqPynFU7g@mail.gmail.com>
 <e5bb2e23-2101-dcc3-695e-f3a0f5a4aba7@gmx.com> <3c668ffe-edb0-bbbb-cfe0-e307bad79b1a@gmx.com>
 <CAODFU0pcT73bXwkXOpjQMvG0tYO73mLdeG2i4foxr6kHorh1jQ@mail.gmail.com>
 <70bc749c-4b85-f7e6-b5fd-23eb573aab70@gmx.com> <CAODFU0q7TxxHP6yndndnVtE+62asnbOQmfD_1KjRrG0uJqiqgg@mail.gmail.com>
 <a3d8c748-0ac7-4437-57b7-99735f1ffd2b@gmx.com> <CAODFU0rK7886qv4JBFuCYqaNh9yh_H-8Y+=_gPRbLSCLUfbE1Q@mail.gmail.com>
 <7fc9f5b4-ddb6-bd3b-bb02-2bd4af703e3b@gmx.com> <CAODFU0oj3y3MiGH0t-QbDKBk5+LfrVoHDkomYjWLWv509uA8Hg@mail.gmail.com>
 <078f9f05-3f8f-eef1-8b0b-7d2a26bf1f97@gmx.com> <CAODFU0q+F2Za=pUVsi1uz9CLi4gs-k1hAAndYmVopgmF9673gw@mail.gmail.com>
 <CAODFU0pxmTShj7OrgGH+-_YuObhwoLBrgwVvx-v+WbFerHM01A@mail.gmail.com>
 <e7df8c6e-5185-4bea-2863-211214968153@gmx.com> <CAODFU0r=9i2mOwNXVx74GcKUSt4Z6wGqshgD=5bktFhoXCWE4A@mail.gmail.com>
 <452af644-e871-20e3-60b2-f69a92dc406d@gmx.com>
In-Reply-To: <452af644-e871-20e3-60b2-f69a92dc406d@gmx.com>
From:   Jan Ziak <0xe2.0x9a.0x9b@gmail.com>
Date:   Sat, 12 Mar 2022 01:01:36 +0100
Message-ID: <CAODFU0oWBvRkpM3oirpfitGiTex8=EST021egQzUiBCMYrhVVg@mail.gmail.com>
Subject: Re: Btrfs autodefrag wrote 5TB in one day to a 0.5TB SSD without a
 measurable benefit
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
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

On Sat, Mar 12, 2022 at 12:39 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> On 2022/3/12 07:28, Jan Ziak wrote:
> > On Sat, Mar 12, 2022 at 12:04 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> >> As stated before, autodefrag is not really that useful for database.
> >
> > Do you realize that you are claiming that btrfs autodefrag should not
> > - by design - be effective in the case of high-fragmentation files?
>
> Unfortunately, that's exactly what I mean.
>
> We all know random writes would cause fragments, but autodefrag is not
> like regular defrag ioctl, as it only scan newer extents.
>
> For example:
>
> Our autodefrag is required to defrag writes newer than gen 100, and our
> inode has the following layout:
>
> |---Ext A---|--- Ext B---|---Ext C---|---Ext D---|---Ext E---|
>      Gen 50       Gen 101     Gen 49      Gen 30      Gen 30
>
> Then autodefrag will only try to defrag extent B and extent C.
>
> Extent B meets the generation requirement, and is mergable with the next
> extent C.
>
> But all the remaining extents A, D, E will not be defragged as their
> generations don't meet the requirement.
>
> While for regular defrag ioctl, we don't have such generation
> requirement, and is able to defrag all extents from A to E.
> (But cause way more IO).
>
> Furthermore, autodefrag works by marking the target range dirty, and
> wait for writeback (and hopefully get more writes near it, so it can get
> even larger)
>
> But if the application, like the database, is calling fsync()
> frequently, such re-dirtied range is going to writeback almost
> immediately, without any further chance to get merged larger.

So, basically, what you are saying is that you are refusing to work
together towards fixing/improving the auto-defragmentation algorithm.

Based on your decision in this matter, I am now forced either to find
a replacement filesystem with features similar to btrfs or to
implement a filesystem (where auto-defragmentation works correctly)
myself.

Since I failed to persuade you that there are serious errors/mistakes
in the current btrfs-autodefrag implementation, this is my last email
in this whole forum thread.

Sincerely
Jan
