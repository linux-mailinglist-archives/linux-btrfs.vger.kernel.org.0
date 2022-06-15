Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3A554D525
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jun 2022 01:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350242AbiFOXSK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jun 2022 19:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353050AbiFOXR6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jun 2022 19:17:58 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A3757114
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Jun 2022 16:17:04 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id h8so14255403iof.11
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Jun 2022 16:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JeCiTATq0ScLeiRXLzs6JbB5vgTMPTBkoCs/Y56IzYU=;
        b=wce4gomDMlGxPgzoTH2BUS0CbwjLajRYkjxcNj6a14OiKHLLqPt9nzYNz25+RNxSWD
         Mmy9+QHxp9uIHsGHS1hyIjXgE34PBc76bYopvdlEn06p4VAqTeu/zlfAZtkKXYa/C+3r
         niQsPzDnzYws/wbXHKFE5EjhG9Ah/jHB/yjlL7Hei9ZESajSZ3NwkGPKVW+X460md7xV
         6ii6sit04uw26e0aiYgJO9smf6dmZW69kjw8WTb7AGTfgynpA2pELg2ypQbi+HAGfLcr
         jYaY+42dvjZotj6HGu+PZvR9YiUnD+IoKy6nvT4tbYmPFpcaOVRlsdQ9v+U8BtntOAu3
         TVhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JeCiTATq0ScLeiRXLzs6JbB5vgTMPTBkoCs/Y56IzYU=;
        b=MuOiCMhMEllrmCcq+sF1fNScjXqLqrl0CmW1XizfhJWx4WegPxG98IZZXnZH/FtAJo
         OtDhQZ73yNpFc6lpq33WRskb9fznihoODEHrEbqsCl0OdsCt1e1S2LLNnBjUMP8exhMt
         s2XCH2PzTGk5N4ShEHTbCKu2fEvFVq+QCY2Ew/O1vpFG1BmIIAtmYXw2I1j9cAR2Q377
         +W1R0tftu9v0h7jsRVkv06s8RQLNpfrIOsEo6cjYSo+l83I3/uKzFe/KESy4cvLfVXvy
         BuyUQOSnJeMxQ0sm2QHHhBFakbA1PijCrCFvcqUuTFVZIuhEno+a4KfQA5N8hwypkVWj
         wo0A==
X-Gm-Message-State: AJIora+QQJe2YSbLsrTR/dzb0jkTZQ/i/Zsb73hXCRr7tSUbvIeyMe2H
        eSyzY9Nntl3WoCuGjGBGOhsdCS38tpeUPKMut1krQCuspy4=
X-Google-Smtp-Source: AGRyM1tJkpRk5csY1p69gx1JvadU8+SyApzqyBxx+37VDGu2b2/HFvzVgtbsg6UJImNtZC+QJKRMaFcu4TVquxS4uYU=
X-Received: by 2002:a05:6638:3e85:b0:335:caf5:42b5 with SMTP id
 ch5-20020a0566383e8500b00335caf542b5mr1168843jab.313.1655335023769; Wed, 15
 Jun 2022 16:17:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAEzrpqfy-sf_xGMohK1EVgtP58tLTso6e7s9iyd3t5XnM3zjCg@mail.gmail.com>
 <20220609211511.GW1745079@merlins.org> <CAEzrpqfhUMDjkaJaa4ZugSuKOWpLyTVJ8nLu9nep5n_qzo-PiA@mail.gmail.com>
 <20220610191156.GB1664812@merlins.org> <CAEzrpqfEj3c5wodYzibBXg34NxtXmQCB60=MtD+Nic2PN8i5bQ@mail.gmail.com>
 <20220613175651.GM1664812@merlins.org> <CAEzrpqdrRJGKPe8C1VvbyPaV3iEDtD1kB_oMiUP=bCs37NfSZw@mail.gmail.com>
 <20220615142929.GP22722@merlins.org> <20220615145547.GQ22722@merlins.org>
 <CAEzrpqdRn9mO0pDOogf37qWH07GryACqidHDbZcpoe7t73GDeQ@mail.gmail.com> <20220615215314.GW1664812@merlins.org>
In-Reply-To: <20220615215314.GW1664812@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Wed, 15 Jun 2022 19:16:52 -0400
Message-ID: <CAEzrpqfZMA=NjqAaS1XKZgguD5L73kc7zKFL+cVHnMGxdK6rXw@mail.gmail.com>
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

On Wed, Jun 15, 2022 at 5:53 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Wed, Jun 15, 2022 at 05:18:54PM -0400, Josef Bacik wrote:
> > On Wed, Jun 15, 2022 at 10:55 AM Marc MERLIN <marc@merlins.org> wrote:
> > >
> > > On Wed, Jun 15, 2022 at 07:29:29AM -0700, Marc MERLIN wrote:
> > > > gargamel:/mnt/mnt# btrfs scrub start -B .
> > > > running that now, I expect it will take a while.
> > >
> > > Never mind, it was fast:
> > > gargamel:/mnt/mnt# btrfs scrub start -B .
> > > scrub done for 96539b8c-ccc9-47bf-9e6c-29305890941e
> > > Scrub started:    Wed Jun 15 07:28:02 2022
> > > Status:           finished
> > > Duration:         0:03:33
> > > Total to scrub:   111.00GiB
> >
> > Hrm shit, this isn't good, don't you have a lot more data than 111gib?
>
> Yep, it was closer to 14TB. Ok, so it's probably gone after the many
> commands we ran in the last 2 months.
>
> > Oh oops, I must have missed this in the init-extent-tree.  Let me look
> > into this and I'll let you know when you can run the code again.
>
> Is there even a reasonable chance to get the data back at this point, or
> are we spending effort in not as useful ways?
>
> > Ok the rest of these are going to take some work to fix up.  I'll work
> > on that as well.  Thanks,
>
> Up to you, happy to continue if it helps your efforts, but it looks like
> my data is mostly gone.
> I do remember one command along this thread that had over 100,000 lines
> of inodes that were cleared once that bit got automated.
>

Yeah I'm going to go rip that code out.  I should have paid more
attention to what was happening instead of just assuming we had a few
corrupt extents that needed to be removed.

I think we've gotten plenty out of this exercise, sorry I ended up
nuking all of your data.  I know what I need to change to fix these
tools to be more useful later on, and I'll just make a bunch of test
images to validate the work.  Thanks,

Josef
