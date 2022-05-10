Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D417A521E96
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 May 2022 17:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244032AbiEJPb4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 May 2022 11:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345745AbiEJPaB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 May 2022 11:30:01 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765B16B679
        for <linux-btrfs@vger.kernel.org>; Tue, 10 May 2022 08:21:03 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id z18so18879178iob.5
        for <linux-btrfs@vger.kernel.org>; Tue, 10 May 2022 08:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WslHeMv5sPSvtyqEN2PmMVOW0oUjSvAB2mOFL4HMmfM=;
        b=M9leVNpNM8lHL9d1++RdQ1D14k7I+kd+FjjU8rzT0BDSPJrU3fegAAzxRcdkAa0IFy
         I3D+0pLeDhI8Olu01yYJ52zg+HqXBhHbIZJaPOmmXA/uTH3/KTt59YUBFBWfhvewbCC2
         0nTz+Hj4jMmgHWuyqjZWqPpunT5di6LO/y4bkKifxgw1JxjBOyfHB6eJ/vsZiujH2WAz
         eMXpbJwiJ6Lm3NZSZrgLmn+Y5NK8gerSdGYrlnLCsiDDSixJyli7+OkiPjf9OMrzrMeO
         0ZG03rQI1Cv70ZQkbgTIsVHo0zH+T7SGvj7pa+SOWYrvY/R8WBcxZBaMVI9it8nbZEhO
         +WeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WslHeMv5sPSvtyqEN2PmMVOW0oUjSvAB2mOFL4HMmfM=;
        b=qD7X8HER8n2aOYXO0vsifsMY4leWelmbkDA5cwuQYlQ0dJ8jC4saFNKUI1EQoW14o9
         bw6RoYcoEehfVXYVkfr1ftlnfN1lr++p3xC7htzfTZwTtacjH8s+DLDhpjMv4gqHUGLy
         uPfeZAPrmRjIgWSyc7wlutDSxIcGuT6MTuT/oLqEAPybVOzYLduOFHt/nk0kenhayAzL
         RSqGqCOgOwjELw8BfPzUxoad6UnU3XYZqejPYehcP9N7BVjpKdNdyEBv+hvyn9lwzPwi
         sA7A3CG4+8UuD3RjoUw0gOs7nE8QDqVdgtCU8YaG8MxY05VD0TsitCHpEWPO7ywgQ282
         XVKg==
X-Gm-Message-State: AOAM531iuP9zzTyDrYXVNeNLBOd62fKPQOEVlkNtq5hyohQXWu0jVrW4
        SFzBbAzPbgS74l8UWvpL7/3kcjjbL4oXH4OK4cb8qJB7dTI=
X-Google-Smtp-Source: ABdhPJwCV/kQdTlJ1AFYLs7szhgindFLxoHteAfdrMFoDe8N4VMvUsLzHU/hqFGVbCqoPHWtYFV1zX94OIPQJxbyU50=
X-Received: by 2002:a02:ccd0:0:b0:32a:e2da:1e1f with SMTP id
 k16-20020a02ccd0000000b0032ae2da1e1fmr10122560jaq.313.1652196062734; Tue, 10
 May 2022 08:21:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220509170054.GW12542@merlins.org> <CAEzrpqccXWAEELYsY0NQ+ZzecQygJFasipt3yE=0L1KA3GgzYg@mail.gmail.com>
 <20220509171929.GY12542@merlins.org> <CAEzrpqft5yq1cMFC_zdHDpOyHc0POQTNkKyW2rKhyHuoN+av6Q@mail.gmail.com>
 <20220510010826.GG29107@merlins.org> <CAEzrpqfePZhBvRy_G2kpo=oRPqoJx=F3Xmh7YF5m6pjMjGJ=Fg@mail.gmail.com>
 <20220510013201.GH29107@merlins.org> <CAEzrpqft3qwSdNYsNbjXDZmjO8Kg2L4zoo8qJzbnCcEDT3tMRA@mail.gmail.com>
 <20220510021916.GB12542@merlins.org> <CAEzrpqf9hy0_oZm8kQMK9PwESFcey0aOO3LUFTMDsCP+9t2JRQ@mail.gmail.com>
 <20220510143739.GC12542@merlins.org>
In-Reply-To: <20220510143739.GC12542@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Tue, 10 May 2022 11:20:51 -0400
Message-ID: <CAEzrpqf7As9tL28+Rb1kVqeO4G=MqBPQw0fKF6Mwa=_4fzsjSQ@mail.gmail.com>
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

On Tue, May 10, 2022 at 10:37 AM Marc MERLIN <marc@merlins.org> wrote:
>
> On Tue, May 10, 2022 at 09:21:33AM -0400, Josef Bacik wrote:
> > On Mon, May 9, 2022 at 10:19 PM Marc MERLIN <marc@merlins.org> wrote:
> > >
> > > On Mon, May 09, 2022 at 10:03:27PM -0400, Josef Bacik wrote:
> > > > On Mon, May 9, 2022 at 9:32 PM Marc MERLIN <marc@merlins.org> wrote:
> > > > >
> > > > > On Mon, May 09, 2022 at 09:18:32PM -0400, Josef Bacik wrote:
> > > > > > On Mon, May 9, 2022 at 9:08 PM Marc MERLIN <marc@merlins.org> wrote:
> > > > > > >
> > > > > > > On Mon, May 09, 2022 at 09:04:36PM -0400, Josef Bacik wrote:
> > > > > > > > On Mon, May 9, 2022 at 1:19 PM Marc MERLIN <marc@merlins.org> wrote:
> > > > > > > > >
> > > > > > > > > On Mon, May 09, 2022 at 01:09:37PM -0400, Josef Bacik wrote:
> > > > > > > > > > Ugh shit, I had an off by one error, that's not great.  I've fixed
> > > > > > > > > > that up and adjusted the debugging, lets see how that goes.  Thanks,
> > > > > > > > >
> > > > > > > >
> > > > > > > > Sorry my laptop battery died while I was at the dealership, and of
> > > > > > > > course that took allllll day.  Anyway pushed some debugging, am
> > > > > > > > confused, hopefully won't be confused long.  Thanks,
> > > > > > >
> > > > > > > Sorry :-/
> > > > > > > Yeah, I bring my power supply in such cases :)
> > > > > > >
> > > > > > > Did you upload?
> > > > > > > sauron:/var/local/src/btrfs-progs-josefbacik# git pull
> > > > > > > Already up to date.
> > > > > >
> > > > > > Sorry, long day, try it again.  Thanks,
> > > > >
> > > > > processed 49152 of 75792384 possible bytes, 0%
> > > > > Recording extents for root 165098
> > > > > processed 1015808 of 108756992 possible bytes, 0%
> > > > > Recording extents for root 165100
> > > > > processed 16384 of 49479680 possible bytes, 0%
> > > > > Recording extents for root 165198
> > > > > processed 491520 of 108756992 possible bytes, 0%WTF???? we think we already inserted this bytenr?? [76300, 108, 0] dumping paths 10467695652864 8675328
> > > > > misc/add0/new/file
> > > > > Failed to find [10467695652864, 168, 8675328]
> > > >
> > > > Ugh such a pain, lets try this again,
> > >
> > >
> > > Looks the same?
> >
> > There's no other debug printing before this?  Can I get the full
> > output from the run?  If there isn't something really wonky is going
> > on and I'm confused.  Thanks,
>
> looking for this?
> processed 49152 of 0 possible bytes, 0%adding a bytenr that overlaps our thing, dumping paths for [4075, 108, 0]
> Couldn't find any paths for this inode
>

Yup that was it, now it makes sense, I've fixed it hopefully.  Thanks,

Josef
