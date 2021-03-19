Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F277434273D
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Mar 2021 21:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbhCSU4J (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Mar 2021 16:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbhCSUzj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Mar 2021 16:55:39 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6A2C061761
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Mar 2021 13:55:39 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id s17so13581707ljc.5
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Mar 2021 13:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9gSNHi6NTmtoKVPXfvXjUk8vksN+CdXfq9GZf+lE6jM=;
        b=bUGF4gcA+WukYQXfGQLoGyybVAjlhABK6I/XqjqtqYvJ4D7eQPjfRnQeRuio9j5bEz
         cyzSyc3J6pa5V0lLZzzKp7+aZH433a3GUMmcdCJNw0OSjNw6QOKQ1QaLomw3Qc3ajfcP
         pOBwf4lY3oMRCDjHadRcMRbVaj2tYTuB7VRqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9gSNHi6NTmtoKVPXfvXjUk8vksN+CdXfq9GZf+lE6jM=;
        b=fRc9Hf3WRCETV+IPE5dmUBaIsn8w4UUOyJZDuMAtA9gjmnQru2ZNK9xVL0iSlIj+sw
         X8zyfSfbEd8oFnl68jhPmVdwGERAO9rOkL2z35lMYR12JWuWjd/P4EOqEXWotKIUC2SK
         xvxw3fxnDagNvhRM6qFvlm/Kkit/LsiZIYwXXLgk8Q8wXbgRdadD+pKTFXlVzvHv0Mvw
         OHc9Gt5mzoHIFv2A0X89/zlvtiMvR6TeV1+MvQz0ig1DcLceg0Yx1svVeQELewbVzgTt
         9lnY8VjCqPAC9lcc5XXtYwA6mpW5SGbW0679FJUh3v6Z7duse1/dnBT7MNJLDXtJEwTo
         3FDA==
X-Gm-Message-State: AOAM533ERuLGbxt/Ua6scVZPceqDDIPwsPqOSyfV9F+a7KfnS9dbXEC8
        RRrharKivHveu/tE1G9X9vjAHd8c4fHXwg==
X-Google-Smtp-Source: ABdhPJydGQQwzkenJHIpllCiNccOt/5b8n7BJrSw4hvaU6qBqPnHFZqA2J4hR6aH8SmmrTMJGebs2w==
X-Received: by 2002:a2e:854a:: with SMTP id u10mr2057224ljj.309.1616187336129;
        Fri, 19 Mar 2021 13:55:36 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id l10sm737686lfc.147.2021.03.19.13.55.34
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Mar 2021 13:55:34 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id u10so11993516lff.1
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Mar 2021 13:55:34 -0700 (PDT)
X-Received: by 2002:a05:6512:33cc:: with SMTP id d12mr1755762lfg.487.1616187334375;
 Fri, 19 Mar 2021 13:55:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1615922644.git.osandov@fb.com> <8f741746-fd7f-c81a-3cdf-fb81aeea34b5@toxicpanda.com>
 <CAHk-=wj6MjPt+V7VrQ=muspc0DZ-7bg5bvmE2ZF-1Ea_AQh8Xg@mail.gmail.com> <YFUJLUnXnsv9X/vN@relinquished.localdomain>
In-Reply-To: <YFUJLUnXnsv9X/vN@relinquished.localdomain>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 19 Mar 2021 13:55:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=whGEM0YX4eavgGuoOqhGU1g=bhdOK=vUiP1Qeb5ZxK56Q@mail.gmail.com>
Message-ID: <CAHk-=whGEM0YX4eavgGuoOqhGU1g=bhdOK=vUiP1Qeb5ZxK56Q@mail.gmail.com>
Subject: Re: [PATCH v8 00/10] fs: interface for directly reading/writing
 compressed data
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 19, 2021 at 1:27 PM Omar Sandoval <osandov@osandov.com> wrote:
>
> For RWF_ENCODED, iov[0] is always used as the entirety of the struct. I
> made the helper more generic to support other use cases, but if that's
> the main objection I can easily make it specifically use iov[0].

Honestly, with new interfaces, I'd prefer to always start off as
limited as possible.

And read/write is not very limited (but O_ALLOW_ENCODED and
RWF_ENCODED at least helps with the "fool suid program to do it"). But
at least we could make sure that the structure then has to be as
strict as humanly possible.

So it's not so much a "main objection" as more about trying to make
the rules stricter in the hope that that at least makes only one very
particular way of doing things valid. I'd hate for user space to start
'streaming" struct data.

> > Also I see references to the man-page, but honestly, that's not how
> > the kernel UAPI should be defined ("just read the man-page"), plus I
> > refuse to live in the 70's, and consider troff to be an atrocious
> > format.
>
> No disagreement here, troff is horrible to read.
>
> > So make the UAPI explanation for this horror be in a legible format
> > that is actually part of the kernel so that I can read what the intent
> > is, instead of having to decode hieroglypics.
>
> I didn't want to document the UAPI in two places that would need to be
> kept in sync

Honestly, I would suggest that nobody ever write troff format stuff.
I don't think it supports UTF-8 properly, for example, which means
that you can't even give credit to people properly etc.

RST isn't perfect, but at least it's human-legible, and it's obviously
what we're encouraging for kernel use. You can use rst2man to convert
to bad formats (and yes, you might lose something in the translation,
eg proper names etc).

Almost anything else(*) is better than troff. But at least I can read
the formatted version.

          Linus

(*) With the possible exception of "info" files. Now *there* is a
truly pointless format maximally designed to make it inconvenient for
users.
