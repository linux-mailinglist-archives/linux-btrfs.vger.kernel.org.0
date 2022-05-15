Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81340527888
	for <lists+linux-btrfs@lfdr.de>; Sun, 15 May 2022 17:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237441AbiEOPsP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 15 May 2022 11:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbiEOPsN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 15 May 2022 11:48:13 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899D6101DD
        for <linux-btrfs@vger.kernel.org>; Sun, 15 May 2022 08:48:12 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id e194so13642458iof.11
        for <linux-btrfs@vger.kernel.org>; Sun, 15 May 2022 08:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HzrannfyYf9cD+H0s/gkuA6P5AJpQ1oEYMO8/BvCK7E=;
        b=I1zbEHH5XJ0V6EkteBORyiYay+eVipcc4N2DLdERI95M2k7OTqwDlVKd0QHiaXthmc
         s3rsDAoc3FUCFFivFAlIe2+hPAObY8ijMSfZLLSv/cLogp2K7LvIomvKSPJjwK9e0su/
         bKkbrnFZhSuh9Qv5ZRPGYZpw02XU53CW+XrymBTAXNYzD7ZAZCSos8elOrONn0VnoDN8
         nadr4CKKzWO9NDczZRNIZ7QcTwqTm6ga0JoaYf9y2vr08CXuFjNKEAIWxPt38b+U52GR
         UKVyyJCCZrlUvgO5uuIzNGzouFyb90h02Yh82i4mGgVsvhGkMN/JDazLGee0J2J+xAtV
         Q3sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HzrannfyYf9cD+H0s/gkuA6P5AJpQ1oEYMO8/BvCK7E=;
        b=KKrAMlbp82QqHPQ9T38mJcdT8K/6DuOIUrTSvNP31SqsuSFaUrjXSqpdyyYeWr/9xS
         FWD2pt/GprEcfARnmJH9+2/vSEVU1v0YKW0Db+4SxIbkgsemuyhahsBYDnCvYBBCTC1n
         l/LRzSHfW+l15U2QHpACMVlXUBAIX3Q/R5CGf5JGnBHtNo+mgce4yhGAx9cYpTQW7rxC
         Pm/pZOXDgx4u+bMQc9YhV3LKolpS0oDby6NLjkzyoNpDKbnnrl+BcrXISmf1TRE7J0gB
         vJGIZaGpaguZEHBXmuTj1SuDvZKbw8inJJaL2GLBRoRirYqBT+3T69Rm3TnbtUmTnrb/
         29Qg==
X-Gm-Message-State: AOAM533JnofKxXpTYR6D+g5TsTtXEltQ7+pPwYYIF6dyCmCgGh5wAKBt
        ypQzAM9W8wYv0chThb+9THI4D5EWDSJBlulMYRWIzb+cg40=
X-Google-Smtp-Source: ABdhPJxOrhXlzHqz4vjdSymEGZOcUiqfwscCc7faldH2wdcEe3VxWTBT74OHpC6pGs8AQFOatBslULSusXDSqivbfvg=
X-Received: by 2002:a02:9984:0:b0:32d:aeff:c592 with SMTP id
 a4-20020a029984000000b0032daeffc592mr6970843jal.46.1652629691794; Sun, 15 May
 2022 08:48:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220511160009.GN12542@merlins.org> <CAEzrpqdO4FX0A1b9xYycJQuMsvzUegSLcze4hpkMOD9dn2F-pQ@mail.gmail.com>
 <20220513144113.GA16501@merlins.org> <CAEzrpqfYg=Zf_GYjyvc+WZsnoCjiPTAS-08C_rB=gey74DGUqA@mail.gmail.com>
 <20220515025703.GA13006@merlins.org> <CAEzrpqfpXVBoWdAzXEYG+RdhOMZFUbWBf6GKcQ6AwL77Mtzjgg@mail.gmail.com>
 <20220515144145.GB13006@merlins.org> <CAEzrpqcVRJFS6HN4L7=tu0Z8SA+E2GsLJzWEADRK3iJvdVy4EA@mail.gmail.com>
 <20220515153347.GA8056@merlins.org> <CAEzrpqcZQVWwt1JSDg6z44dBYKW6fmmXmOTFoXiDWpoGXxufwQ@mail.gmail.com>
 <20220515154122.GB8056@merlins.org>
In-Reply-To: <20220515154122.GB8056@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Sun, 15 May 2022 11:48:00 -0400
Message-ID: <CAEzrpqc6MyW0t1H9ue_GQL-1AhgpWfumBfj3MK0eGstwJ3R1aw@mail.gmail.com>
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

On Sun, May 15, 2022 at 11:41 AM Marc MERLIN <marc@merlins.org> wrote:
>
> On Sun, May 15, 2022 at 11:35:28AM -0400, Josef Bacik wrote:
> > On Sun, May 15, 2022 at 11:33 AM Marc MERLIN <marc@merlins.org> wrote:
> > >
> > > On Sun, May 15, 2022 at 11:24:34AM -0400, Josef Bacik wrote:
> > > > Ok I pushed something new, but completely untested as I'm sitting at a
> > > > park with the kids and my kdevops thing is broken on my laptop.  You
> > > > should be able to do
> > > >
> > > > btrfs rescue init-csum-tree <device>
> > > >
> > > > and it'll rebuild the csum tree.  It'll give you a progress bar as
> > > > well.  I expect the normal amount of back and forth before it actually
> > > > works, but it should work faster for you.  Thanks,
> > >
> > > Thanks. Actually I'm past that, I'm doing
> > > ./btrfs check --init-csum-tree /dev/mapper/dshelf1
> > > that's the one that's been running for days.
> > >
> > > Are you saying init-csum-tree was moved to rescue which does run faster,
> > > and after that I should run the last step, check --repair, that you
> > > suggested?
> > >
> >
> > Yes, I've replaced the rescue --init-csum-tree with rescue
> > init-csum-tree, which will repopulate the csum extents.
> >
> > So you should cancel what you're doing, and then run
> >
> > btrfs rescue init-csum-tree <device>
> > btrfs check --repair <device>
> >
> > and then you should be good to go.  Thanks,
>
> Gotcha, so let's work through the new version, looks like a recursive loop
>

Fixed, thanks,

Josef
