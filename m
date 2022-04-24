Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEE7050D33F
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Apr 2022 18:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234400AbiDXQX4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 24 Apr 2022 12:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234404AbiDXQXz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 24 Apr 2022 12:23:55 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502D93AA56
        for <linux-btrfs@vger.kernel.org>; Sun, 24 Apr 2022 09:20:54 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id d3so7954859ilr.10
        for <linux-btrfs@vger.kernel.org>; Sun, 24 Apr 2022 09:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3ZaO1F+SQIoBRAGZFF1WOCuPrBbs02qzajwjDE651ZA=;
        b=VVVbg44WvJxU1sWGjIMNMBh+5TRFwMRhb6FfJebw4TSfaj9B/c0OGJf4+wMigAUILb
         0cAZlPbl5X+D7E8OT6ZBQXebjz+OTOmyNvOkMyMk12NmbKXmvsGlLPaIAh/i9a7495iR
         pyfl85Ul8Qew7FbNYlCTjGj+EoJzc7k5vnN3lKN/6ep1yMWclH6BPIUcxoDf2P3vJtTy
         FCnRWg7yIZ84xQnGI6LGdYs5Df8ha5ZaHgEK2biSs1O/LPHqYoAY3mdmBLE4xN6eLUAb
         JimM1ndK4q1Dg7g6IdkkrwzyAqS/9T+h9cnt2c03WQKFaO2a9JVC42OUYD9b/jRK4Cxc
         tbHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3ZaO1F+SQIoBRAGZFF1WOCuPrBbs02qzajwjDE651ZA=;
        b=OfNQ3kj7czaPdPnO3nkMTCCAUmwRcnSFDZyunHGhzIsnUBfcbAs1rrTL39WsDZYWvn
         j4dsirqk3YKMtL6j5cPYk4LExF+p44zUSBgyC+UJYkDUqrne+B7oF7mB9IkVzusG1vcs
         ov/nMF+7qkBBh8jxBCiZOEJqH6x4SoK8miPorV7hfqTUOFzXEz4E1acuhv1LlvSmxGUr
         cS8HLcpZWCB+MxOliqqJI6ubYBj9wHhX/jSbma9mcFK3hjIZUYjy+z3tXXoBN3ZmYodw
         2XhajA4yxCDdkWm3nshqs+Op1XUL8c6YDluNwjqN4fEHE+wMYcVBktJi+GZPL/cmN7a/
         SYEw==
X-Gm-Message-State: AOAM5332njjqQes8XcknFUYiJw2Pq+uEf1BPOyDEVrdunlrSTuvfBz9l
        iUFPXBO1GMRcy0AQmWOFRCRCb4qPyqiFkEtvPLdNJgvsodk=
X-Google-Smtp-Source: ABdhPJxqS1fCGQKdnRAe2PIdhTB7QUn0UWp1xXwZJA/5ny64VJCrWvuPTuSnbmDUzRrQ5mdXMvl0qsf0380f/XMNP4Y=
X-Received: by 2002:a92:d2ca:0:b0:2ca:ca3a:de89 with SMTP id
 w10-20020a92d2ca000000b002caca3ade89mr5517767ilg.127.1650817253207; Sun, 24
 Apr 2022 09:20:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAEzrpqf0Gz=UuJ83woXOsRvcdC7vhH-b2UphuG-1+dUOiRc2Kw@mail.gmail.com>
 <YkzWAZtf7rcY/d+7@hungrycats.org> <20220406000844.GK28707@merlins.org>
 <Ykzvoz47Rvknw7aH@hungrycats.org> <20220406040913.GE3307770@merlins.org>
 <Yk3W88Eyh0pSm9mQ@hungrycats.org> <20220406191317.GC14804@merlins.org>
 <20220422184850.GX13115@merlins.org> <CAEzrpqfhCHL=pWXvQK9rYftQFe+Z6CyQPwRYxgCaX1w6JaqOTA@mail.gmail.com>
 <20220422200115.GV11868@merlins.org> <20220423201225.GZ13115@merlins.org> <CAEzrpqeo4U4SXH7LVz_Yx8ydX5BiqzFNJmAhQv1jCpjOessjHA@mail.gmail.com>
In-Reply-To: <CAEzrpqeo4U4SXH7LVz_Yx8ydX5BiqzFNJmAhQv1jCpjOessjHA@mail.gmail.com>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Sun, 24 Apr 2022 12:20:42 -0400
Message-ID: <CAEzrpqdHAS2E1iuoSFVX-A-T-vsMoCo6CoW0ebw42vkCjqpMPw@mail.gmail.com>
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

On Sat, Apr 23, 2022 at 4:53 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> On Sat, Apr 23, 2022 at 4:12 PM Marc MERLIN <marc@merlins.org> wrote:
> >
> > On Fri, Apr 22, 2022 at 01:01:15PM -0700, Marc MERLIN wrote:
> > > > Now if we get to Monday and it's still running I can take a crack at
> > > > making it faster.  I was hoping it would only take a day or two, but
> > > > we're balancing me trying to make it better and possibly fucking it up
> > > > with letting it take the rest of our lives but be correct.  Thanks,
> > >
> > > Makes sense. I don't need faster, and it may not be able to go faster
> > > anyway, it's a lot of data. Just wanted to make sure the output and
> > > relative slow results were expected.
> >
> > Looking at the output, is there any way I can figure out if it's at 5%
> > or 80% completion?
> >
> > tree backref 238026752 parent 236814336 not found in extent tree
> > backpointer mismatch on [238026752 16384]
> > adding new tree backref on start 238026752 len 16384 parent 236814336 root 236814336
> > Repaired extent references for 238026752
> > ref mismatch on [238043136 16384] extent item 0, found 1
> > tree backref 238043136 parent 236814336 not found in extent tree
> > backpointer mismatch on [238043136 16384]
> > adding new tree backref on start 238043136 len 16384 parent 236814336 root 236814336
> > Repaired extent references for 238043136
> > ref mismatch on [238059520 16384] extent item 0, found 1
> > tree backref 238059520 parent 236814336 not found in extent tree
> > backpointer mismatch on [238059520 16384]
> > adding new tree backref on start 238059520 len 16384 parent 236814336 root 236814336
> >
>
> Hmm I don't know, that's byte 227, but you're in fs trees now, so
> hopefully soon?  I've got some free time, let me rewrite this to be
> less stupid and see if I can get it done before your thing finishes,
> and I'll add some sort of progress indicator.  Thanks,
>

Alright you can kill the command, pull my tree, then run

btrfs rescue init-extent-tree <blah>

This do the straight re-init of the extent tree without all the
looping and extra stuff that fsck does, so hopefully will be faster?
Also it keeps track of how many bytes we've processed, as well as how
many bytes we may have to process, so you'll get a better feel for the
progress.  I have a scratch fs here that has like 30gib of metadata
with 1tib of data and it took around 30 seconds to run.  It has no
snapshots, I ran it on a fsstress generated fs with like 5k snapshots
and it took about a minute, but with significantly less metadata/data.

Once you run this you'll still have to run --repair, but it shouldn't
have to touch the extent tree.  If you see it messing with the extent
tree stop it and let me know what it's complaining about and I'll fix
it up.  I'm pretty sure my thing is going to work, but your fs is more
complex than I can generate on the fly.

Also, the indicator may show "processed" as less than "possible" bytes
when it moves onto the next root, this is normal for snapshots, if
we've already processed a subtree we won't walk down it, so it's fine
if you see that.  Thanks,

Josef
