Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16EC150CD72
	for <lists+linux-btrfs@lfdr.de>; Sat, 23 Apr 2022 22:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237009AbiDWU5H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 23 Apr 2022 16:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236075AbiDWU5F (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 23 Apr 2022 16:57:05 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EAA312C434
        for <linux-btrfs@vger.kernel.org>; Sat, 23 Apr 2022 13:54:07 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e1so7087107ile.2
        for <linux-btrfs@vger.kernel.org>; Sat, 23 Apr 2022 13:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+86Ed/isXjevaMMTvI2TKVPVCkUG1nFNM21bvVYiNq4=;
        b=ZQOhaNPmZhGjeXdFp2cyyhAJ93mfDEWZ05qPO6vD520doP6YKsM7fNTqDGow2w5E7K
         30OHejDsi1e6d6K+04iQphTugwETdmJ4Y5juAd+wTMldsrqpubHNBoInoj3KIEXbab+B
         oPq3YLnb7CEZ6/DfqtnkET4HYwxqSv9p1Tptw6QWoa9w4brLuZAnaZI57t1BgfhMhfjJ
         vwR5ipfvCb5jWk+dmqH2vog77GjAiB0ROBlSRbCTYBKN8e80nPAdJc1Xcbu0bgJkaQ48
         C5p7V0H03Lv4mNBfPenZiCD0hbUNuF2fP2nofKMFArGLxeJMNFGB6tsJProMM5Q/Xqer
         EEhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+86Ed/isXjevaMMTvI2TKVPVCkUG1nFNM21bvVYiNq4=;
        b=k6s6Y3hm66oNDQcsSZNaBhRiV3hr1fvXuMQDUxzy1DFwDTpi2vUZRgTRTHhKqHs7Me
         CdL8JRBbLrSEyhzWltNou7BtO8bZHRxeRQxNaFmm4HjQnsqg8cZau03VhhP8dKAXhVBu
         I8aLJg8dV7fDmuP4VVff23zoBCWg0zi11WnAHJV9lmQ70B1QEhk1DInyIIcMNrkwWRaf
         VOtr5H9hrxYQG0/3skECy2pGYHdz4ll2S2Pyyrzj/mDio5CVJcmdNAXOlb4DkC5PGIMv
         2jB0dH1fKKrPPu8duYm07NOKrb/iWPaQwAU5Zc4A6EWQPSxIIj8CyiuyKTt2XU6aceqh
         pXGw==
X-Gm-Message-State: AOAM531nDGM85uIpTUuHyJHSWYiPiJc1ei8nB1zdVnU3oGQ/3U4JxPeY
        MlBZPizSiH6Xm+mYxo2D2+bhvZFdjFYnr8szzBsuAlsabHA=
X-Google-Smtp-Source: ABdhPJy9r1oRJ+0q1GelSm8IxnOTYW+YliiC7QQGZm+Y4NKXUU4vXl/17yvxM7jvjLwmj0v6vBXljG7YNYHuWRgS6u0=
X-Received: by 2002:a92:d6c9:0:b0:2c7:aba1:6231 with SMTP id
 z9-20020a92d6c9000000b002c7aba16231mr3889757ilp.206.1650747246206; Sat, 23
 Apr 2022 13:54:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAEzrpqf0Gz=UuJ83woXOsRvcdC7vhH-b2UphuG-1+dUOiRc2Kw@mail.gmail.com>
 <YkzWAZtf7rcY/d+7@hungrycats.org> <20220406000844.GK28707@merlins.org>
 <Ykzvoz47Rvknw7aH@hungrycats.org> <20220406040913.GE3307770@merlins.org>
 <Yk3W88Eyh0pSm9mQ@hungrycats.org> <20220406191317.GC14804@merlins.org>
 <20220422184850.GX13115@merlins.org> <CAEzrpqfhCHL=pWXvQK9rYftQFe+Z6CyQPwRYxgCaX1w6JaqOTA@mail.gmail.com>
 <20220422200115.GV11868@merlins.org> <20220423201225.GZ13115@merlins.org>
In-Reply-To: <20220423201225.GZ13115@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Sat, 23 Apr 2022 16:53:55 -0400
Message-ID: <CAEzrpqeo4U4SXH7LVz_Yx8ydX5BiqzFNJmAhQv1jCpjOessjHA@mail.gmail.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent transid
 verify failed + open_ctree failed)
To:     Marc MERLIN <marc@merlins.org>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Apr 23, 2022 at 4:12 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Fri, Apr 22, 2022 at 01:01:15PM -0700, Marc MERLIN wrote:
> > > Now if we get to Monday and it's still running I can take a crack at
> > > making it faster.  I was hoping it would only take a day or two, but
> > > we're balancing me trying to make it better and possibly fucking it up
> > > with letting it take the rest of our lives but be correct.  Thanks,
> >
> > Makes sense. I don't need faster, and it may not be able to go faster
> > anyway, it's a lot of data. Just wanted to make sure the output and
> > relative slow results were expected.
>
> Looking at the output, is there any way I can figure out if it's at 5%
> or 80% completion?
>
> tree backref 238026752 parent 236814336 not found in extent tree
> backpointer mismatch on [238026752 16384]
> adding new tree backref on start 238026752 len 16384 parent 236814336 root 236814336
> Repaired extent references for 238026752
> ref mismatch on [238043136 16384] extent item 0, found 1
> tree backref 238043136 parent 236814336 not found in extent tree
> backpointer mismatch on [238043136 16384]
> adding new tree backref on start 238043136 len 16384 parent 236814336 root 236814336
> Repaired extent references for 238043136
> ref mismatch on [238059520 16384] extent item 0, found 1
> tree backref 238059520 parent 236814336 not found in extent tree
> backpointer mismatch on [238059520 16384]
> adding new tree backref on start 238059520 len 16384 parent 236814336 root 236814336
>

Hmm I don't know, that's byte 227, but you're in fs trees now, so
hopefully soon?  I've got some free time, let me rewrite this to be
less stupid and see if I can get it done before your thing finishes,
and I'll add some sort of progress indicator.  Thanks,

Josef
