Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF59D433ADB
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Oct 2021 17:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbhJSPmt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Oct 2021 11:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231947AbhJSPms (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Oct 2021 11:42:48 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC9BC06161C
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Oct 2021 08:40:35 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id o11so6911126ljg.10
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Oct 2021 08:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M5qLpGOaG+oQiwUY6IZoloZawU2xGFjPWL0KZDD5Sqk=;
        b=Wmr7RZGDwVuUUI0LgeG+526Yzd808WwmB0Gv3Ef8vlN4fSo+FWdGkt2ewAZlHCizf2
         AOj6nKdkBK/50v2SslKwFKgXMONLSaQQZm/2hQbpblrN5k/KDVfxEf5XH7GllHiFtRBq
         4jqVHC4XfB57XB9V0yinVHJ5h8DIkkpImv8f0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M5qLpGOaG+oQiwUY6IZoloZawU2xGFjPWL0KZDD5Sqk=;
        b=FTrd1zRWpM1SOQfhkWwRRA90YUBofSYf3ERyBIjsiTg4QK4xkNRN6ti/eTDztcBeyj
         lyDgV97izc1rZzHD6lGUriPEi+j8yJv3VyiFkkRhQXCwbjEiiqCKq9XMrjrDRPS0ORoX
         Ezp1feTYqQyJEw4G2944XKbKM6rchrdYUQLwY2/WUk94G1a4CBc7JX7sI4XgUsYQMSbZ
         LI/CtUPOwcq/7LyWlV1wFJd2ULFZhYz0P+1gzCx37O8HM2E5Mq4vk2kaTNdwOXQU89Aq
         PyraQJTUl19mORD5QAig+0u0K8BJr2HX34QaFs1OQBtkC5Ep/JtS16OLCK5REFg1UroU
         3n4w==
X-Gm-Message-State: AOAM533aMsjmaLGyuNJHod4qlZ9d1BznRQszXsmIUwJ4m7+oaZdQI8eX
        NINEJshwGv0z/xKVp8EY+7+bs/N5PRMbu/GT
X-Google-Smtp-Source: ABdhPJz1LxE4EJTiatZuksf2HG4BzAnq/gKXJEhHRTZe5y+4JsgpaKCVCHDwjaAcbg4kAAKMUZUKYg==
X-Received: by 2002:a05:651c:204d:: with SMTP id t13mr7374360ljo.267.1634658031720;
        Tue, 19 Oct 2021 08:40:31 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id x34sm1770316lfa.170.2021.10.19.08.40.29
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Oct 2021 08:40:29 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id x192so8334291lff.12
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Oct 2021 08:40:29 -0700 (PDT)
X-Received: by 2002:a05:6512:398a:: with SMTP id j10mr6559053lfu.402.1634658028835;
 Tue, 19 Oct 2021 08:40:28 -0700 (PDT)
MIME-Version: 1.0
References: <20211019134204.3382645-1-agruenba@redhat.com>
In-Reply-To: <20211019134204.3382645-1-agruenba@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 19 Oct 2021 05:40:13 -1000
X-Gmail-Original-Message-ID: <CAHk-=wh0_3y5s7-G74U0Pcjm7Y_yHB608NYrQSvgogVNBxsWSQ@mail.gmail.com>
Message-ID: <CAHk-=wh0_3y5s7-G74U0Pcjm7Y_yHB608NYrQSvgogVNBxsWSQ@mail.gmail.com>
Subject: Re: [PATCH v8 00/17] gfs2: Fix mmap + page fault deadlocks
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com, kvm-ppc@vger.kernel.org,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 19, 2021 at 3:42 AM Andreas Gruenbacher <agruenba@redhat.com> wrote:
>
> From my point of view, the following questions remain:
>
>  * I hope these patches will be merged for v5.16, but what process
>    should I follow for that?  The patch queue contains mm and iomap
>    changes, so a pull request from the gfs2 tree would be unusual.

Oh, I'd much rather get these as one pull request from the author and
from the person that actually ended up testing this.

It might be "unusual", but it's certainly not unheard of, and trying
to push different parts of the series through different maintainers
would just cause lots of extra churn.

Yes, normally I'd expect filesystem changes to have a diffstat that
clearly shows that "yes, it's all local to this filesystem", and when
I see anything else it raises red flags.

But it raises red flags not because it would be wrong to have changes
to other parts, but simply because when cross-subsystem development
happens, it needs to be discussed and cleared with people. And you've
done that.

So I'd take this as one pull request from you. You've been doing the
work, you get the questionable glory of being in charge of it all.
You'll get the blame too ;)

>  * Will Catalin Marinas's work for supporting arm64 sub-page faults
>    be queued behind these patches?  We have an overlap in
>    fault_in_[pages_]readable fault_in_[pages_]writeable, so one of
>    the two patch queues will need some adjustments.

I think that on the whole they should be developed separately, I don't
think it's going to be a particularly difficult conflict.

That whole discussion does mean that I suspect that we'll have to
change fault_in_iov_iter_writeable() to do the "every 16 bytes" or
whatever thing, and make it use an actual atomic "add zero" or
whatever rather than walk the page tables. But that's a conceptually
separate discussion from this one, I wouldn't actually want to mix up
the two issues too much.

Sure, they touch the same code, so there is _that_ overlap, but one is
about "the hardware rules are a-changing" and the other is about
filesystem use of - and expansion of - the things we do. Let's keep
them separate until ready, and then fix up the fallout at that point
(either as a merge resolution, or even partly after-the-fact).

                     Linus
