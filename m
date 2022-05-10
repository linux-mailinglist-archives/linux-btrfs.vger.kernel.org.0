Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED9B1520AF3
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 May 2022 04:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234478AbiEJCHh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 May 2022 22:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbiEJCHg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 May 2022 22:07:36 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95ACA289BE4
        for <linux-btrfs@vger.kernel.org>; Mon,  9 May 2022 19:03:39 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id y11so10492582ilp.4
        for <linux-btrfs@vger.kernel.org>; Mon, 09 May 2022 19:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ong1VIhZc//DKJIGQtLazrM+aosyXe8ov5MU6My3u98=;
        b=M1MjQr6/VoxSx9FMvqPflzUhI1jnFd21+Aj97EBeFcziyPhUm0jdEVKd4ylaWpJ1Ve
         czJcztk/k8xxNS7sjVjyqgTXRTRu+5SXKgO7KzfU8xxCDrIYuZbreINNgXFRnbHpt6jl
         1X6LsamHY89d/a0tz7z0xSQ3dFVmM+9lEN741Yeu6dbfqlbvH1USXFS0PG8/RACRhCKA
         q4RsDx2J43sd8iZl/wY3HPNC6uPtPMw5n0+jELd6GlFqIU6R6SNzTEhuNXPU71HqYIB0
         ukwkDib0nDFcoZOrmitz7BK7VSMXa4f/bdZqphNHizUG2EgSUSMuWgIkWRy0KhSLUZwM
         HNxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ong1VIhZc//DKJIGQtLazrM+aosyXe8ov5MU6My3u98=;
        b=nYHmnnd0/6vmDXn3Wa+0D/PtacbNUwp0aTqoHstMR5I4/4z5D6nuD3WaQWq9NJdHJp
         KGligNP5DE1sR5B0S9FGHnXopqUGkmtYEgA9VBH7tqOMo/rJhi3tDD1ZAvXrToHXQ3SP
         gUKoim9tABFCSLp/rb4nb1/du/hBtq4hm4ksC9rvVzmqQXzCYh/MtUPpCmd8VyHeoHRn
         ZX9cz1tz9uSGkBzNDcaH3xTh2bH5EanojQ71LSta+OvWqM6j1bGOgwmVG+/NeJDaKPpt
         UvzC0MoffV0IgvSxrNRcpjOaoEkw78y0DZxO30C3maHcwQCRuP3rAjlw/513rt1OWAOW
         2zhA==
X-Gm-Message-State: AOAM533M/joAIo6g0WOcrIQTTqv4cIP3dTB23dlokV9W8/Bmtc4aFGP8
        cueSsMChNrC7Ss/uLTsPodN5dU3LF4haQkf9bN2WlEj+KAk=
X-Google-Smtp-Source: ABdhPJx5b2IEU5DnlI34P54XQhHcSxQCX5kNpR3vy3l4QDUsbecHgxp9nThj1E7CHzsZH8/pm8l7W8M0l9b2KFpJSjA=
X-Received: by 2002:a05:6e02:198e:b0:2cf:4a7a:faf8 with SMTP id
 g14-20020a056e02198e00b002cf4a7afaf8mr7587725ilf.206.1652148218815; Mon, 09
 May 2022 19:03:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220508221444.GS12542@merlins.org> <CAEzrpqe=qUMdC-8UTeuSy7niO9i8PhFGa6auMmQk_ave30gKUw@mail.gmail.com>
 <20220509004635.GT12542@merlins.org> <CAEzrpqfYRkASd+7ac_2dO+bNtacYwE9ndcYDWsp9B4Esq9Hwug@mail.gmail.com>
 <20220509170054.GW12542@merlins.org> <CAEzrpqccXWAEELYsY0NQ+ZzecQygJFasipt3yE=0L1KA3GgzYg@mail.gmail.com>
 <20220509171929.GY12542@merlins.org> <CAEzrpqft5yq1cMFC_zdHDpOyHc0POQTNkKyW2rKhyHuoN+av6Q@mail.gmail.com>
 <20220510010826.GG29107@merlins.org> <CAEzrpqfePZhBvRy_G2kpo=oRPqoJx=F3Xmh7YF5m6pjMjGJ=Fg@mail.gmail.com>
 <20220510013201.GH29107@merlins.org>
In-Reply-To: <20220510013201.GH29107@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Mon, 9 May 2022 22:03:27 -0400
Message-ID: <CAEzrpqft3qwSdNYsNbjXDZmjO8Kg2L4zoo8qJzbnCcEDT3tMRA@mail.gmail.com>
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

On Mon, May 9, 2022 at 9:32 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Mon, May 09, 2022 at 09:18:32PM -0400, Josef Bacik wrote:
> > On Mon, May 9, 2022 at 9:08 PM Marc MERLIN <marc@merlins.org> wrote:
> > >
> > > On Mon, May 09, 2022 at 09:04:36PM -0400, Josef Bacik wrote:
> > > > On Mon, May 9, 2022 at 1:19 PM Marc MERLIN <marc@merlins.org> wrote:
> > > > >
> > > > > On Mon, May 09, 2022 at 01:09:37PM -0400, Josef Bacik wrote:
> > > > > > Ugh shit, I had an off by one error, that's not great.  I've fixed
> > > > > > that up and adjusted the debugging, lets see how that goes.  Thanks,
> > > > >
> > > >
> > > > Sorry my laptop battery died while I was at the dealership, and of
> > > > course that took allllll day.  Anyway pushed some debugging, am
> > > > confused, hopefully won't be confused long.  Thanks,
> > >
> > > Sorry :-/
> > > Yeah, I bring my power supply in such cases :)
> > >
> > > Did you upload?
> > > sauron:/var/local/src/btrfs-progs-josefbacik# git pull
> > > Already up to date.
> >
> > Sorry, long day, try it again.  Thanks,
>
> processed 49152 of 75792384 possible bytes, 0%
> Recording extents for root 165098
> processed 1015808 of 108756992 possible bytes, 0%
> Recording extents for root 165100
> processed 16384 of 49479680 possible bytes, 0%
> Recording extents for root 165198
> processed 491520 of 108756992 possible bytes, 0%WTF???? we think we already inserted this bytenr?? [76300, 108, 0] dumping paths 10467695652864 8675328
> misc/add0/new/file
> Failed to find [10467695652864, 168, 8675328]

Ugh such a pain, lets try this again,

Josef
