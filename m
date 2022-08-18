Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2579597A9E
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Aug 2022 02:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242507AbiHRAac (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Aug 2022 20:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242505AbiHRAab (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Aug 2022 20:30:31 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61FD7A5715
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Aug 2022 17:30:30 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id o7so137957pfb.9
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Aug 2022 17:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=zXxGzXq7Ta7zj5dP+FgLbvP1ctxgNRKfYlOGN51+aK0=;
        b=FebtVmAU48S2149QHfNn51JNkskBjNC66+X5n3VMcR4X3gBzvnC0mCiB82MtipDw+T
         FBw5LnXn3mhmvQDpbi9A3hXCwO40NK6i3tXMbGzHSGynVgYGs6YqCrGhPJWpF2D5X3wj
         ekev66XcRXrfRWM3eEXsddlB7GEXNohRcoGajdZZMuSrXHJELnclJ43Zx0v6H3iTxxUF
         VxFt5R28e39Gmz0oolNUqj06xL7EwkzT6q40PbiKe4M6iFwADqsrmoSTNoPg1HR1cxUQ
         NcDQN5rzoN1oIj1nI/77+zdHnFuUQluS3kpcS4OkO9jLDjZqrTVWpp49cf6MtV/4hihH
         XQKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=zXxGzXq7Ta7zj5dP+FgLbvP1ctxgNRKfYlOGN51+aK0=;
        b=zgIhRNpxjDs913WfDuaz4y2dgARfRMghT4kCagHvTHe6g25Y+v6bGbTu1+XGwYXsrp
         1a1xN+z9ssalRCx3MwjXr4pAdrbmRnBPwTimYY9Xd1vX15v+3/jo8Dxj8F+kgPB86xL1
         k4yA6wIVZQX+ibHFFjDJKYERCpUNWg5EFvPotFu74nlFCuB2qZAn2ytFT2+Rkey0dKHq
         VxDWMFJIBwEJ+ch/4Mj+aZXbQZe5/d7R8ZtxWgG09CPieB0739+jso2U1heMN+Cy4H7C
         IyTmdPwxJwIJEXig01umVppNuMrI6evD+SUT/WHghc1wpi+0XZNR/B2le7RJEzsbZboL
         E07A==
X-Gm-Message-State: ACgBeo1pJttCgnQDUxThGGicPL9VAJLnutAyJiJmYDUohTPU1p5NsmpS
        B7EW1Q/0aUNVYJrE5a1a/0jqQH9pr5DcIw==
X-Google-Smtp-Source: AA6agR5wUMxURXMdAIXqu005nTbk4Q+wEGCvrsAuUYtF9vWgTZqYYeHu+5eF1o6zPlySoMFoNLHy4Q==
X-Received: by 2002:a63:491a:0:b0:41d:7380:f43e with SMTP id w26-20020a63491a000000b0041d7380f43emr603868pga.44.1660782629827;
        Wed, 17 Aug 2022 17:30:29 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:8ab0])
        by smtp.gmail.com with ESMTPSA id c2-20020aa79522000000b005323a1a9fecsm2293pfp.101.2022.08.17.17.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 17:30:29 -0700 (PDT)
Date:   Wed, 17 Aug 2022 17:30:27 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Christoph Anton Mitterer <calestyo@scientia.org>
Cc:     Linux BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/2] btrfs: fix space cache corruption and potential
 double allocations
Message-ID: <Yv2IIwNQBb3ivK7D@relinquished.localdomain>
References: <cover.1660690698.git.osandov@fb.com>
 <9ee45db86433bb8e4d7daff35502db241c69ad16.1660690698.git.osandov@fb.com>
 <CAK-xaQZYDBuL2DMeOiZDubujSmZTcNJfkgqa03Q+24=nhCmynw@mail.gmail.com>
 <dbc8b0ee60b174f1b2c17a7469918a32a381c51b.camel@scientia.org>
 <Yv2A+Du6J7BWWWih@relinquished.localdomain>
 <b5d37d4d059e220313341d2804cbf1daf2956563.camel@scientia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5d37d4d059e220313341d2804cbf1daf2956563.camel@scientia.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 18, 2022 at 02:22:00AM +0200, Christoph Anton Mitterer wrote:
> On Wed, 2022-08-17 at 16:59 -0700, Omar Sandoval wrote:
> > I'm working on a tool that can be run on a mounted filesystem to
> > detect
> > most of the corruptions that could result from this bug. I'll share
> > that
> > in the next couple of days.
> 
> That sounds quite good.
> 
> Maybe such thing should find it's way into btrfs-progs.
> 
> I remember back then whether there were some corruption issues that
> occurred with holes in compressed files, there were also some ways to
> search for files which may have been affected.
> 
> So I mean such things wouldn't be the day2day tools of btrfs-progs, but
> could be helpful to those who'd like to investigate more... and having
> it as part of btrfs-progrs would make them much more accessible to end-
> users (no need to search for it, no need to compile it, no need to
> trust their author (well at least not more than they anyway need to
> trust btrfs-progs)).
> 
> 
> > 
> > From what I've found, it's much more likely to happen if you delete a
> > lot of data soon after boot with space_cache=v2/nospace_cache and
> > discard/discard=sync. I can't say that it'd never happen outside of
> > those conditions, but I suspect that it's much harder to hit
> > otherwise.
> 
> Okay, but deletion *is* necessary, right?

Yes, but metadata deletions also count, so basically any modification
results in a deletion. We haven't seen this in practice, but I couldn't
find anything that would make it impossible.

In place modifications of files also result in COW and deletion of the
old data, so that also technically counts.
