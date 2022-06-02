Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AEBA53B0B3
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jun 2022 02:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232624AbiFBAEQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Jun 2022 20:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232619AbiFBAEP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Jun 2022 20:04:15 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8202A87A29
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Jun 2022 17:04:14 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id y8so3356694iof.10
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Jun 2022 17:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2Pq3AAolXve1vycAqPglvPXf8Q8uapfXmXG7H6D7tG8=;
        b=ytAMXIYmo3pkXn5cM8nXyohoJzsvrdXoTSWnIItLcyMCgJmrTFZjmBJvfy5NmPnADq
         k/DYYI8uezOFNMGYPLgZ9Psw5P1C7KJOZriLpPPhTe5Q7AMboDLsL01iLdWn9f3YyqGv
         YVud+3E6oua8RwlBVkXrBtiCwXHj01a0mClBDD7EwW9rcurAzOLybDLNzfYiSdiwOFQ/
         58okAQmffUYe/D5/LulZKpAIHgHyUvakh3m/UEpXK+lZCrln+CWMmzthIbyeySob6O6K
         ou1II0mxfYw1T3MKJB35Iw5+T6G5tyemVl/d0JTZZnct2oXfDR9OzNdT7LLTCy6ln7eP
         +svQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Pq3AAolXve1vycAqPglvPXf8Q8uapfXmXG7H6D7tG8=;
        b=27GIIpIeVtjvLLy11W1YkGTrS8RhvwXi/up3C7b/Wz0kpjeKj1bDpb/4ZRDF3K0e7v
         xZX14GSnj4GljwoZELpbk40RC32557z27Bh/WeAbGEfO8ykkLnuAN3aRQHPVwe8j/X/y
         wyb45aWJcoNOMxkL+bleqm5BdOfm6sP94tXTItzO6gvo6oaAjLhFjrqdKttfrOd8Djqh
         d3Uotp1Ki51R4p4Uq+AMwNOgH9qmPJXdXPNrpT+zCWZdYGqco87I0kcOWkLmmeJkAy5E
         AIVVwmrKbNf+npw5FuNZSG8oz+nBs36U4KG2ojORgefrOEFMfT5eO/sey1i6eAlwbQdo
         fRtw==
X-Gm-Message-State: AOAM532LNIhQvMIHCkUWbi+cDbGSIcB5vYz0AXsbCjBB949iF3gwKAUU
        0F33L47AGTWkWIOGs8QreJRI/vsgxGvFqlljEXVsk/rszWs=
X-Google-Smtp-Source: ABdhPJyvdTBZ86TfYDnb2IfvY8Kmyz06iOK5wf0r8eLm0jMNEggub/e/WEUQwiyGeVvjooEYm467BKlawB+rrNT2JdA=
X-Received: by 2002:a05:6602:80a:b0:665:7139:4c4b with SMTP id
 z10-20020a056602080a00b0066571394c4bmr1305085iow.134.1654128253813; Wed, 01
 Jun 2022 17:04:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAEzrpqc1cFHwb8fczUatznbwzDFi87j-kuXMMcUf2rmKWzu5Lw@mail.gmail.com>
 <20220601185027.GG22722@merlins.org> <CAEzrpqcY-F4WOiaJcDfHykok0LB=JEX1DnZj53+KvM7a6j+daQ@mail.gmail.com>
 <CAEzrpqeTEuRzP_Nj1qoSerCObJLA4fJYDfR1u3XMatuG=RZf-g@mail.gmail.com>
 <20220601214054.GH22722@merlins.org> <CAEzrpqduFy+7LkgWyyEnvYLgdJU6zDEWv25JM-niOg9tjmZ3Nw@mail.gmail.com>
 <20220601223639.GI22722@merlins.org> <CAEzrpqdfz5FMFDiBbb1mrUTXqxNvJ2RkuqJCdE2VQ6op01k61g@mail.gmail.com>
 <20220601225643.GJ22722@merlins.org> <CAEzrpqe7Fm8d62GnRs5EZeggkbXdsF2JCxkSOWnQAU+pzFtG9g@mail.gmail.com>
 <20220601231008.GK22722@merlins.org>
In-Reply-To: <20220601231008.GK22722@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Wed, 1 Jun 2022 20:04:03 -0400
Message-ID: <CAEzrpqen1AXAYBq0M0LVzB8AVXMhAD_ve1Yj_+e=kPyCfdUiow@mail.gmail.com>
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

On Wed, Jun 1, 2022 at 7:10 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Wed, Jun 01, 2022 at 07:04:32PM -0400, Josef Bacik wrote:
> > On Wed, Jun 1, 2022 at 6:56 PM Marc MERLIN <marc@merlins.org> wrote:
> > >
> > > On Wed, Jun 01, 2022 at 06:54:31PM -0400, Josef Bacik wrote:
> > > > Ah right, I have to mock up free space since we can't read our normal
> > > > stuff.  Fixed, lets go again.  Thanks,
> > >
> > > Found missing chunk 15483956887552-15485030629376 type 0
> > > Found missing chunk 15485030629376-15486104371200 type 0
> > > Found missing chunk 15486104371200-15487178113024 type 0
> > > Found missing chunk 15487178113024-15488251854848 type 0
> > > Found missing chunk 15488251854848-15489325596672 type 0
> > > Found missing chunk 15671861706752-15672935448576 type 0
> > > Found missing chunk 15672935448576-15674009190400 type 0
> > > Found missing chunk 15772793438208-15773867180032 type 0
> > > Found missing chunk 15773867180032-15774940921856 type 0
> > > Found missing chunk 15774940921856-15776014663680 type 0
> > > Found missing chunk 15776014663680-15777088405504 type 0
> > > Found missing chunk 15777088405504-15778162147328 type 0
> > >
> >
> > I swear there's so much tech-debt here.  Try again please.  Thanks,
>
> Well, hopefully we'll get to the bottom of it all, thanks again for all
> your efforts on this.
>
> Found missing chunk 15772793438208-15773867180032 type 0
> Found missing chunk 15773867180032-15774940921856 type 0
> Found missing chunk 15774940921856-15776014663680 type 0
> Found missing chunk 15776014663680-15777088405504 type 0
> Found missing chunk 15777088405504-15778162147328 type 0
>

This segfault makes no sense, we check to make sure any of this stuff
is NULL.  I've added some debugging, hopefully that'll shed some
light.  Thanks,

Josef
