Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E73746263C
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Nov 2021 23:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234733AbhK2WtD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Nov 2021 17:49:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235003AbhK2Ws2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Nov 2021 17:48:28 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE82EC048F74
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Nov 2021 10:40:59 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id o20so75568128eds.10
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Nov 2021 10:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7TgPSN7BGol1Tl+v3cbObp6eM3owptNkUS6MUKapLgk=;
        b=dDhGyayvTiVZ54M7kQkeYpixbZJ21FDA4H+XgW5qfma9xVodQ+ykL0UVDfVCnj3oGS
         XCxC3zzyDIbY203VjKnyF4PRo5sWL2wGeRMysXQpu6w6X3f1ZKzEOJPs+7uJC0mulw3W
         kWegC2qcRszmcWmuLJGCfK9FiXD9y5MpmqsEo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7TgPSN7BGol1Tl+v3cbObp6eM3owptNkUS6MUKapLgk=;
        b=m0uPvOOlExwbmFYPHcFf/fA1HQqNJ0Tk61snUARpCGFF83VRwdnwxXl18NNRUbuQsZ
         O00r3zfrA8aafEQI71KfP/miB5UEnsCWJEbhhl4MxLLE90fYCGJhkVxowlaak4qO8j6T
         vzbRVWPq1SCNienvFyiYKfYiLSgXfckaqgCv25E0TXOgApXE1djaoz1HVyHPcsbwc6X0
         SmDmHv2T9cj/kFM/c9Pk5vJZnc877uRHeiA0/44397Rk2DW4ECvCLEeu+TDfhykGylkQ
         mEx69W3tc1NjOhffKtIUnmgmccu96hJeNw3Km9rF+E90B23aChVeq4bsWEZy5Bx0d0bV
         71gg==
X-Gm-Message-State: AOAM532ER/R/q83MlZ7KQ8KBvdaW0cn8YauAhgKXg+AfbSrJajX9PmEp
        9f7syQQy/q/3Jn6dyTyc3agsxMXltaqimWFXWh4=
X-Google-Smtp-Source: ABdhPJxF7eg9ag9yO7CaOVey5SD+LM1vm7eIcSNOD5JVZpywxBt5jYuW9dqJAzX3haFR8/nbCtJiUw==
X-Received: by 2002:a05:6402:440f:: with SMTP id y15mr78716193eda.22.1638211258279;
        Mon, 29 Nov 2021 10:40:58 -0800 (PST)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id s4sm8173037ejn.25.2021.11.29.10.40.54
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Nov 2021 10:40:58 -0800 (PST)
Received: by mail-wr1-f48.google.com with SMTP id l16so38906483wrp.11
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Nov 2021 10:40:54 -0800 (PST)
X-Received: by 2002:adf:f8c3:: with SMTP id f3mr35865238wrq.495.1638211254717;
 Mon, 29 Nov 2021 10:40:54 -0800 (PST)
MIME-Version: 1.0
References: <20211124192024.2408218-1-catalin.marinas@arm.com>
 <20211124192024.2408218-4-catalin.marinas@arm.com> <YZ6arlsi2L3LVbFO@casper.infradead.org>
 <YZ6idVy3zqQC4atv@arm.com> <CAHc6FU4-P9sVexcNt5CDQxROtMAo=kH8hEu==AAhZ_+Zv53=Ag@mail.gmail.com>
 <20211127123958.588350-1-agruenba@redhat.com> <YaJM4n31gDeVzUGA@arm.com>
 <CAHc6FU7BSL58GVkOh=nsNQczRKG3P+Ty044zs7PjKPik4vzz=Q@mail.gmail.com>
 <YaTEkAahkCwuQdPN@arm.com> <CAHc6FU6zVi9A2D3V3T5zE71YAdkBiJTs0ao1Q6ysSuEp=bz8fQ@mail.gmail.com>
 <YaTziROgnFwB6Ddj@arm.com>
In-Reply-To: <YaTziROgnFwB6Ddj@arm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 29 Nov 2021 10:40:38 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiZgAgcynfLsop+D1xBUAZ-Z+NUBxe9mb-AedecFRNm+w@mail.gmail.com>
Message-ID: <CAHk-=wiZgAgcynfLsop+D1xBUAZ-Z+NUBxe9mb-AedecFRNm+w@mail.gmail.com>
Subject: Re: [PATCH 3/3] btrfs: Avoid live-lock in search_ioctl() on hardware
 with sub-page faults
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 29, 2021 at 7:36 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> That's what this series does when it probes the whole range in
> fault_in_writeable(). The main reason was that it's more efficient to do
> a read than a write on a large range (the latter dirtying the cache
> lines).

The more this thread goes on, the more I'm starting to think that we
should just make "fault_in_writable()" (and readable, of course) only
really work on the beginning of the area.

Not just for the finer-granularity pointer color probing, but for the
page probing too.

I'm looking at our current fault_in_writeable(), and I'm going

 (a) it uses __put_user() without range checks, which is really not great

 (b) it looks like a disaster from another standpoint: essentially
user-controlled loop size with no limit checking, no preemption, and
no check for fatal signals.

Now, (a) should be fixed with a access_ok() or similar.

And (b) can easily be fixed multiple ways, with one option simply just
being adding a can_resched() call and checking for fatal signals.

But faulting in the whole region is actually fundamentally wrong in
low-memory situations - the beginning of the region might be swapped
out by the time we get to the end. That's unlikely to be a problem in
real life, but it's an example of how it's simply not conceptually
sensible.

So I do wonder why we don't just say "fault_in_writable will fault in
_at_most_ X bytes", and simply limit the actual fault-in size to
something reasonable.

That solves _all_ the problems. It solves the lack of preemption and
fatal signals (by virtue of just limiting the amount of work we do).
It solves the low memory situation. And it solves the "excessive dirty
cachelines" case too.

Of course, we want to have some minimum bytes we fault in too, but
that minimum range might well be "we guarantee at least a full page
worth of data" (and in practice make it a couple of pages).

It's not like fault_in_writeable() avoids page faults or anything like
that - it just moves them around. So there's really very little reason
to fault in a large range, and there are multiple reasons _not_ to do
it.

Hmm?

               Linus
