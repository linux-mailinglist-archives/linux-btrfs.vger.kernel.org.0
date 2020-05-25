Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E84AD1E17EC
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 May 2020 00:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388093AbgEYWrt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 May 2020 18:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729554AbgEYWrt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 May 2020 18:47:49 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4458DC061A0E
        for <linux-btrfs@vger.kernel.org>; Mon, 25 May 2020 15:47:49 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x6so4919642wrm.13
        for <linux-btrfs@vger.kernel.org>; Mon, 25 May 2020 15:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IOPgJmKYSQAFEbVqqBHVC75KIoQJNmlm3TIJkAsErWY=;
        b=aXXQ+8E/Ly6+/PA5+8mLz8bASoGtqi95Je7URWa9mR2mJ8URgAEPT70FfCeJJnKrIy
         z1yez57l9PnDicXDerYXqqKi8mZI9iMbTI+495qMcG6C0CBMoIh7DkGUi1p7ZLK1B36z
         +77fCirt1+2GC5CMiM//pVHKfI1X5znipb2L/CmWlE6pNc7ukJGUGUE9HIfCUGC5J1lJ
         A+1bxPQq06VoLwmpjQ3mCHZrZnujPcfx8g692Nyonp0EIW4R6yESEKhifM6Hc1LmWUcg
         FWK+ZnvnIB1tctgu1Ziegp/YI5dWLveYXM0rWB1PGaFy2VRzyxWZrQd1OxDO5REC5GEX
         vV9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IOPgJmKYSQAFEbVqqBHVC75KIoQJNmlm3TIJkAsErWY=;
        b=kBp0kgAGkuZKt9ShMGXnxtcRedZadvRHepwYSaNUOE06QsHNndmFKtx0Drx89qTeeh
         ukvmWPGezXpktZd7Unu6M5dn07lfjuyZXidEGizPQQ9o4OngknYG+62m954i8qgbgYLe
         s3HAOVA/AmMfqyQNJJuOOB/BgLyOTwhM4t9V7EvXu0otVDawBsxvhPK5JTpHEpK9CgSJ
         YhM0qGqIqit2YrOJShhEfhScIRqv5BOPcwl/iAtSJom5Xzva/vYIlJdtqsFI194MA2fn
         2fu9k6XLDgHwh6kS7JWGCVtJBti7zYFz9RalHYTfiK3qRDA66ySOwUGdZSkNx3XThRV5
         l/Cg==
X-Gm-Message-State: AOAM531Jm05S0VfAkduU1GG70imGmpifTkj0gf5dlxFT+pVprPAgMRDA
        svsh/FwyzbR3eg3oqGqbQnCscFsN99NkqcMfQtOyVdgeDjATFg==
X-Google-Smtp-Source: ABdhPJyHJW3Q3UarEVfNQnSPGE7Gg8UApDUuiM7a5cFB+3KZ0pssuosY9t0bu461oTbvpxhzbZg8391IqSkLtpYc5/k=
X-Received: by 2002:a5d:4d4d:: with SMTP id a13mr8045942wru.252.1590446867770;
 Mon, 25 May 2020 15:47:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200524213059.GI23519@merlins.org> <CAJCQCtTWkRijC51qny+gLqFO=z-Jek4mbKN0O6udLKzzeNe_vw@mail.gmail.com>
 <20200525201620.GA19850@merlins.org> <CAJCQCtSqdJnVCPQEEeE1W3ux48tWerQuu-2_rySUdYM7GZJR9Q@mail.gmail.com>
 <20200525203916.GB19850@merlins.org>
In-Reply-To: <20200525203916.GB19850@merlins.org>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 25 May 2020 16:47:31 -0600
Message-ID: <CAJCQCtQgeYE3XPFACru08qhSOTxv5N9icj4xV27rG81UeaVa=g@mail.gmail.com>
Subject: Re: 5.5 kernel and btrfs-progs v5.6 create and cannot fix 'root
 204162 inode 14058737 errors 1000, some csum missing'
To:     Marc MERLIN <marc@merlins.org>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Su Yue <Damenly_Su@gmx.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Su Yue <suy.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 25, 2020 at 2:39 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Mon, May 25, 2020 at 02:24:03PM -0600, Chris Murphy wrote:
> > OK I didn't understand that the problem is with only the sending file
> > system, not the receive file system. And also it sounds like the send
> > did not cause the problem, but it's somehow a pre-existing problem
> > that --repair isn't completely fixing up, or maybe is making different
> > (or worse).
>
> Correct on all points.
>
> > So I guess the real question is what happened to this file system
> > before the send, that got it into this weird state.
>
> That too, but honestly there are a lot of variables, and it feels like a
> bit of wild goose chase.

Maybe. The story arc on Btrfs is that check --repair only fixes the
things it knows how to fix. It's gotten better but still has the scary
warning, and lately has a 10 second delay to really make sure the user
meant to use it. And regardless of mode, it's slow and just can't
scale. Neither does "wipe and restore from backup". So the problems of
inconsistency need to be understood to avoid the problem in the first
place.


>
> Basically it looked like the issues with the FS are pretty minor (I was
> able to cp -av the entire data without any file error), but that btrfs
> check --repair is unable to make it right, which will likely force me to
> wipe and restore.
> I know chedk is WIP, and that's why I'm providing feedback :)

What about finding inode 14058737 and deleting it? In all of the
listed subvolumes? And then unmount and check again?


> > > > Is no-holes enabled on either file system?
> > >
> > > Not intentionally. How do I check?
> >
> > btrfs insp dump-s
> >
> > It's not yet the default and can't be inadvertently enabled so chances
> > are it's the original holes implementation.
>
> The filesystem was definitely created a while ago (2-3 years?)
>
> I have been recently been playing with bees, but I'm reasonably sure I didn't run in on that filesystem
> it lists support for "HOLE extents and btrfs no-holes feature"

It's default except for LZO.


-- 
Chris Murphy
