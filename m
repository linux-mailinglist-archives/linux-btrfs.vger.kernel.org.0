Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67332520A95
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 May 2022 03:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbiEJBWk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 May 2022 21:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiEJBWj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 May 2022 21:22:39 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03FD1C0F28
        for <linux-btrfs@vger.kernel.org>; Mon,  9 May 2022 18:18:43 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id f4so17130157iov.2
        for <linux-btrfs@vger.kernel.org>; Mon, 09 May 2022 18:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D+bwXvMORQ4HjVmTlil5bXODh95VHj8C/gZ17ASXFoo=;
        b=7y9Y4oVvzf1OUxBF04Eo/6oqHSmyV9YNHJWuAI5rgHl/gM9FRnuCKi63QUTfK6+6Nb
         SZ8NYcdXbL/RSQwLHz8vbi+lccLO1gOReDhN9EgAaTVGdHGp+ANLJJTqD9Xue20/1Zue
         LeUPXi3ABvU7n5k5pufZxVymXCR699xRRH5FLToqp1t0N1lJnkCFxpZpuCxw72WEOD5v
         2Q5kAWD++s3S6h0y0dZ9Gt30GNI+YHwyWw7ExSRe9Tv43zOIIZbAq8GYrzg8eN5S51qO
         m870NIl5M4kr60YR8wqhxXGN7LC9U4O500urQJk9jPZ/OBmvOsU2OuRp8fJXXaoSv34e
         FuTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D+bwXvMORQ4HjVmTlil5bXODh95VHj8C/gZ17ASXFoo=;
        b=BwaoyyyDwPhHADhzWuF7G26hzkAeH02IgTb6II8HannVhGGm44EDoD2RpQ12YDfLvo
         dpPHCn9buh9onaa3W6VOkdAp9lvoUTJdjzD9KjWzapUGctaPS6LSdBCoH/A7KkS1V3jJ
         U8QcT7p0rqYGxzxwjFWHuNzjHc5PvXtoDsvqKNv7YKX+jhs7KFqnIW++hpaRsLiZ2weP
         1TlrKaWe5BZn8L74AVu7YLsujI/mRqTLPgJM2l0b3uM4n4iUo9Xn6rHJ2CRVXWvyGlcE
         v6RtXFslSI+PR3VfUe7/dKHVoJZBUglPnrdXXXOmw9PqGKeXv/1Xh4mt7MZuigH1tM0G
         IbzQ==
X-Gm-Message-State: AOAM5318sTK+f6OKeDKZYBLUAaKcrxGCctabJrjzbNPio9YR/jDNs8yQ
        SNKoqMCwWfvNbtSNydIFzWg6vPuMv8+RobVYUybqCnlTmQw=
X-Google-Smtp-Source: ABdhPJz4ZH4e8f8ZPg/HDb3+Ytnut3N4exC0BHTXz0XKWXZk37KrcMLH7o2OBgOI9a6+iNUVs/imTF1gHQvN//Q5s6s=
X-Received: by 2002:a05:6638:30e:b0:32a:f864:e4d4 with SMTP id
 w14-20020a056638030e00b0032af864e4d4mr8217519jap.218.1652145522941; Mon, 09
 May 2022 18:18:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220508212050.GR12542@merlins.org> <CAEzrpqdMFJ2cm0URWqwFehkQQzmrgYO+CdoibSUqqfN1hkGOvQ@mail.gmail.com>
 <20220508221444.GS12542@merlins.org> <CAEzrpqe=qUMdC-8UTeuSy7niO9i8PhFGa6auMmQk_ave30gKUw@mail.gmail.com>
 <20220509004635.GT12542@merlins.org> <CAEzrpqfYRkASd+7ac_2dO+bNtacYwE9ndcYDWsp9B4Esq9Hwug@mail.gmail.com>
 <20220509170054.GW12542@merlins.org> <CAEzrpqccXWAEELYsY0NQ+ZzecQygJFasipt3yE=0L1KA3GgzYg@mail.gmail.com>
 <20220509171929.GY12542@merlins.org> <CAEzrpqft5yq1cMFC_zdHDpOyHc0POQTNkKyW2rKhyHuoN+av6Q@mail.gmail.com>
 <20220510010826.GG29107@merlins.org>
In-Reply-To: <20220510010826.GG29107@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Mon, 9 May 2022 21:18:32 -0400
Message-ID: <CAEzrpqfePZhBvRy_G2kpo=oRPqoJx=F3Xmh7YF5m6pjMjGJ=Fg@mail.gmail.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent transid
 verify failed + open_ctree failed)
To:     Marc MERLIN <marc@merlins.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 9, 2022 at 9:08 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Mon, May 09, 2022 at 09:04:36PM -0400, Josef Bacik wrote:
> > On Mon, May 9, 2022 at 1:19 PM Marc MERLIN <marc@merlins.org> wrote:
> > >
> > > On Mon, May 09, 2022 at 01:09:37PM -0400, Josef Bacik wrote:
> > > > Ugh shit, I had an off by one error, that's not great.  I've fixed
> > > > that up and adjusted the debugging, lets see how that goes.  Thanks,
> > >
> >
> > Sorry my laptop battery died while I was at the dealership, and of
> > course that took allllll day.  Anyway pushed some debugging, am
> > confused, hopefully won't be confused long.  Thanks,
>
> Sorry :-/
> Yeah, I bring my power supply in such cases :)
>
> Did you upload?
> sauron:/var/local/src/btrfs-progs-josefbacik# git pull
> Already up to date.
>

Sorry, long day, try it again.  Thanks,

Josef
