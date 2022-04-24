Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4473950D5DD
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Apr 2022 00:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239854AbiDXW7P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 24 Apr 2022 18:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238037AbiDXW7O (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 24 Apr 2022 18:59:14 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B1760DB9
        for <linux-btrfs@vger.kernel.org>; Sun, 24 Apr 2022 15:56:13 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id y85so14142698iof.3
        for <linux-btrfs@vger.kernel.org>; Sun, 24 Apr 2022 15:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MRGUkzZnhYUh3t79ei+GyP3s4Yi3mvGZV9g5myWOoPU=;
        b=XNhi4AC6HSXLDfx03f+SzRJj4XEfQQzvQvoCe3AtMvpliHvQxx1j8WK/vXKMkC5HH4
         uOutx3q9AIIvN7wcRruM17hNbmGBFqSnV4scgWDxil/p7UBoJsR+1skgIEGhxgDE5PfH
         FwYzxJOopUQ6tnezzoSKxpR7zk5k5xT6MXMg53XW4xG4+wfvV6UuFXP8QHrBqmzkrl89
         x+Qjn8+pKdbLGkV/KVXt5WQ8sUmu0rb9BzOgsBTHOT5Puw1LVVxf0Syh+aTL6ZvWeGCZ
         tlLFwhSlvF8BF8ROnwN3aDLhVCSaNNooNJm+evCe1L0lnQpxn3XXJqT76xJ2aF8lTNZM
         w7FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MRGUkzZnhYUh3t79ei+GyP3s4Yi3mvGZV9g5myWOoPU=;
        b=7qDJz1eZIzRf/LcWeQelGF6UGBHxUhSqVPNnM1oYutqkv/vwwH+82N85aAIqnxh+cB
         MbeoPGuQdLrBtIchc+xx9XTEcSDp5CUtgFjC3Yf0JHLwLiOJsgNGyirlBmLPxlOUGEVj
         lnFJotD4MiiJoU20iQChYpVzA5kaflvRpoRFX9AIpeX/oA764UdGuhMXWJuoZmoK9jJ2
         PoRBr3yT/iqTPJZ6TH+aF56XeYgXwgk2vRlrtZDvBAg3lUtZ159GjJCorgJhjsxb+qo7
         Kpyx7uDFV6qfuuPXI9aKGHigl8xfTE3pQiXkdY/z1uLy7xxGYfpCfAuwabFJO22633Yl
         qPeg==
X-Gm-Message-State: AOAM530EqSdudDBn5WWFPCKO8aCj9xuDvZJz+12hIAq/BAW5Kipgff6W
        rgf+k1H8elXTCbLjh9YwwnYP/IRvBxD9c5kzACohDQuAPnQ=
X-Google-Smtp-Source: ABdhPJzFf7M/FZ1TquZdHqzL0CHGnA5TaIn4Y76gc/3h1qiCI/ViLBvCB3NSpblPm1jNsYFxelONk2RMfpDRY/uHqbE=
X-Received: by 2002:a02:6010:0:b0:31a:6d4f:d9ca with SMTP id
 i16-20020a026010000000b0031a6d4fd9camr6265909jac.46.1650840972450; Sun, 24
 Apr 2022 15:56:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220424194444.GA12542@merlins.org> <CAEzrpqeY_BAMLdL7NQmtC7ROBkZLrx=FHr=JC4KHoPF6Kwn3Kg@mail.gmail.com>
 <20220424203133.GA29107@merlins.org> <CAEzrpqemyJ8PS5-eF3iSKugy6u3UAzkwwM=o+bHPOh2_7aPHFA@mail.gmail.com>
 <20220424205454.GB29107@merlins.org> <CAEzrpqeVQQ+42Lnn9+3gevnRgrU=vsBEwczF41gmTukn=a2ycw@mail.gmail.com>
 <20220424210732.GC29107@merlins.org> <CAEzrpqcMV+paWShgAnF8d9WaSQ1Fd5R_DZPRQp-+VNsJGDoASg@mail.gmail.com>
 <20220424212058.GD29107@merlins.org> <CAEzrpqcBvh0MC6WeXQ+-80igZhg6t68OcgZnKi6xu+r=njifeA@mail.gmail.com>
 <20220424223819.GE29107@merlins.org>
In-Reply-To: <20220424223819.GE29107@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Sun, 24 Apr 2022 18:56:01 -0400
Message-ID: <CAEzrpqdBWMcai2uMe=kPxYshUe8wV0YX3Ge1pZW8aG_BSO-i-w@mail.gmail.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent transid
 verify failed + open_ctree failed)
To:     Marc MERLIN <marc@merlins.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Apr 24, 2022 at 6:38 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Sun, Apr 24, 2022 at 05:26:11PM -0400, Josef Bacik wrote:
> > On Sun, Apr 24, 2022 at 5:20 PM Marc MERLIN <marc@merlins.org> wrote:
> > >
> > > On Sun, Apr 24, 2022 at 05:13:22PM -0400, Josef Bacik wrote:
> > > > On Sun, Apr 24, 2022 at 5:07 PM Marc MERLIN <marc@merlins.org> wrote:
> > > > >
> > > > > On Sun, Apr 24, 2022 at 05:01:38PM -0400, Josef Bacik wrote:
> > > > > > Wtf, it's reading the right bytenr, but it's not failing here but
> > > > > > failing when we do the init-extent-tree.  I've pushed something again
> > > > > > to force reads, maybe that's the problem, can you run tree-recover and
> > > > > > then init-extent-tree again?  Thanks,
> > > > >
> > > > > off-list:
> > > > > Seeing this, that kind of worried me so I stopped it. Is it ok to
> > > > > continue?
> > > >
> > > > Sorry, my printf was wrong, pushed.  Thanks,
> > >
> > > Better?
> > > Do I worry about those new "had to be read from a different mirror" ?
> > >
> >
> > Ooooh ok, the other mirror is bad, but it finds the right thing.  Ok
> > that makes sense.  I pushed another patch just to make sure.  Once
> > this is all done you'll need to run a scrub to fix the mirrors but
> > this is fine.  Thanks,
>
> No more crash, but:
> ERROR: Error adding block group
> ERROR: commit_root already set when starting transaction
>

I feel like this thing is purposefully changing itself between each
run so I can't get a grasp on wtf is going on.  I pushed some stuff,
lets see how that goes.  Thanks,

Josef
