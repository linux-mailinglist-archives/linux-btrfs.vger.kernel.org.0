Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC6D4F92D7
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Apr 2022 12:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbiDHK0N (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Apr 2022 06:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiDHK0L (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Apr 2022 06:26:11 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4010D219AF2
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Apr 2022 03:24:08 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id y16so6157043ilc.7
        for <linux-btrfs@vger.kernel.org>; Fri, 08 Apr 2022 03:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C3hQitwRNiO5YMSlxm/qbyVEbRt9SseRehZa80SLjmM=;
        b=ttTg+YZ11GIYYZiT2c4TpyvIWp/wtY9WuvAvg64ODxBmE2lq4iPiaOfAQ7I3wOYm+y
         Lk60wC17NxSlJ3ee8jTBmNBJV8mnyzpRRpYznZLC4CUcntWI0ynFPgA38Bblv6JdsGdF
         cnVhByFEWulDqSBYMglR9Nrg5ApLUgLw8lkOjIp9wUGvEWAIU0FNxLMzmnF0nlxm8nqD
         70RT+5rqPDW72bMQLmWGcaim8T7YcWbIGJM31N4oBQABFZ5pNB2EJ1+efW1a95iB2u2u
         Anx2i8tLtuyRAD83Wp8XLZi8pJh4I1PxAD5zMNGoV6gSkHG9ECOS8o3IESYNgAwkCmff
         Df9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C3hQitwRNiO5YMSlxm/qbyVEbRt9SseRehZa80SLjmM=;
        b=zeXxalEWUucISNnqTQqCqFtURQb5Vu63IMuPlbFFot8ZLRJGQTtKLYUCpmyL6Y7ULi
         8PHYBoE/4h6PYfyGNZ+JgcPn4+Uy26qazV0Zrs9bzYptlpJvBbV7lyNxU17NUMbnAeHP
         O3Y58Lf8l2e0HgWA2AeH3O6aHZOUAIM6L3HkQ5A6GSEVJc/+p8zqXwgCWMIjeMs67vLR
         wtKtAgtZqvCVR0u3ku3QnqdfFrNiZAg3zZU3kv9dYqDL6BaZ3oG8TEHf4QJQnH/8IwhR
         MwSiMdAJ7L4dWZ15PU1miJcq+OYCcFgMtjVbspPVvZPhEj9tyjOoRsXZ53uMozy+dsG7
         Oj9g==
X-Gm-Message-State: AOAM533vI1XcM91kjZsLly9HpZ0204cqQB0yV9Yu1wIpWU1n9B+bVAmG
        NQ/lri2MiiBhkecd4uz6QoB7Q6c8Tp50adntfEkF9suqGks=
X-Google-Smtp-Source: ABdhPJx74CFUyhrru2Qg6vPaa3+5gzydY+vUYgidPAljVOzCWeYc8wlOpPxnlaWgYftn6+eKTtiFrcNeeJSErvJ0Jy4=
X-Received: by 2002:a05:6e02:1889:b0:2ca:2105:78 with SMTP id
 o9-20020a056e02188900b002ca21050078mr8677570ilu.6.1649413447609; Fri, 08 Apr
 2022 03:24:07 -0700 (PDT)
MIME-Version: 1.0
References: <11970220.O9o76ZdvQC@ananda> <20220407052022.GC25669@merlins.org>
 <20220407162951.GD25669@merlins.org> <CAEzrpqdeph1AM74habMeOg_VURv5AFvZZ-9aUM9ZVEkM+-3Xkg@mail.gmail.com>
 <CAEzrpqdjKE3ehKjEqWOuBHPuScpjDG+B7r81SP1Vd+G8RVK6rA@mail.gmail.com> <20220408102209.GG25669@merlins.org>
In-Reply-To: <20220408102209.GG25669@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Fri, 8 Apr 2022 06:23:56 -0400
Message-ID: <CAEzrpqf+64jMsWnddCuoiVPEWyHOK+U3cGJMHrFAdHRn2Vbd0g@mail.gmail.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent transid
 verify failed + open_ctree failed)
To:     Marc MERLIN <marc@merlins.org>
Cc:     Martin Steigerwald <martin@lichtvoll.de>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 8, 2022 at 6:22 AM Marc MERLIN <marc@merlins.org> wrote:
>
> On Thu, Apr 07, 2022 at 06:09:53PM -0400, Josef Bacik wrote:
> > Just following up on this, I've got hungry kids, I'm about halfway
> > through the new shit.  Depending on how much help kids need with
> > homework I may have this done later tonight, or it'll be tomorrow
> > morning.  Thanks,
>
> It finished after more than 24H, but that didn't seem to be enough, quite.
> Hopefully we're getting closer, though :)
>

Yup we're getting there, I'm about 90% done with the new stuff, and
that'll delete block pointers that we can't find good matches for.

Also it'll cache the results of the disk wide search, so it'll have to
do it once per root instead of for every bad block we find, which will
drastically cut down on the runtime.  I'll let you know when it's
ready, figure another hour or so.  Thanks,

Josef
