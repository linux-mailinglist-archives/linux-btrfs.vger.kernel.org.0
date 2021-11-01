Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF4B144214A
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Nov 2021 21:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbhKAUGZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Nov 2021 16:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbhKAUGT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 1 Nov 2021 16:06:19 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF65C061714
        for <linux-btrfs@vger.kernel.org>; Mon,  1 Nov 2021 13:03:44 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id g3so95056ljm.8
        for <linux-btrfs@vger.kernel.org>; Mon, 01 Nov 2021 13:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FR2K5/kGEObb0f9w9HtvEq5L7B0uQm0JuIDp97X/b0s=;
        b=RA3rD8ACX3CuP3TdohPvJvbGOIt80mDkhfWxL6bkh9VQE0rxtINxPHYaql5mavpVG4
         0jgWUU2V+0aZ+9Td9YK1PYi3H6GxiuZGb+WxaFdVCBXxlhsDc51HOst7HDT1XrMpLJL5
         8N4gfMr/EPXNxhJgjbb4LLMUT1mPZpY4w2Tt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FR2K5/kGEObb0f9w9HtvEq5L7B0uQm0JuIDp97X/b0s=;
        b=eDDfS9/TrMbJxya0vLJEBaYSf/jugM02svBWNF0fVT/qIoBNpC1iCZ6DI0OdCJprOK
         mMcaUDU4JFZO/Y24CzPO6x+Nwxd78aYaNoVpWV8IBxyfz81NKc6ubZGDbI8l3Yhy23+F
         PDG5RsdeIJuR+S9aAfRVDloJS/vzCOmzZvTGR4cltl7ZmhAuUHBEqACoxN1cEJHANPz2
         Ercu6OOxl+rvqhBn9rrb7M2EYJToxB5Q0SHrMTzHx2iUQhbyU3rAzVjHpdPpqkQTFS5t
         Sc9KchYy4/JLLePfZpoveoO8gPaeCNQDtNZQbyhKQEgkobgHxecT31Z267nWkjwOCB7o
         1SfA==
X-Gm-Message-State: AOAM530YidIY/6bos0NC+g0LGBkSiuzBuHczwdWKPk2Br60NOU2ACrWF
        XQKL6j5ZskuKXm4dz1AcENgtrc7w1+LRFeLs
X-Google-Smtp-Source: ABdhPJygtgoWgUtKhRV1nSD6RE3TL1VZdUKuxu1ZwEYHH2v3w69zFhDGWxokGKqKuy1gsj7Tc2+Wzg==
X-Received: by 2002:a2e:1546:: with SMTP id 6mr2052383ljv.479.1635797022123;
        Mon, 01 Nov 2021 13:03:42 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id s10sm900405lfs.174.2021.11.01.13.03.41
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Nov 2021 13:03:41 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id 1so25300929ljv.2
        for <linux-btrfs@vger.kernel.org>; Mon, 01 Nov 2021 13:03:41 -0700 (PDT)
X-Received: by 2002:a2e:89d4:: with SMTP id c20mr34338022ljk.191.1635797021035;
 Mon, 01 Nov 2021 13:03:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1635773880.git.dsterba@suse.com>
In-Reply-To: <cover.1635773880.git.dsterba@suse.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 1 Nov 2021 13:03:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjowO+mmVBoiWkCk6LeqVTYVBp0ruSUPN2z0_ObKisPYw@mail.gmail.com>
Message-ID: <CAHk-=wjowO+mmVBoiWkCk6LeqVTYVBp0ruSUPN2z0_ObKisPYw@mail.gmail.com>
Subject: Re: [GIT PULL] Btrfs updates for 5.16
To:     David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 1, 2021 at 9:46 AM David Sterba <dsterba@suse.com> wrote:
>
> There's a merge conflict due to the last minute 5.15 changes (kmap
> reverts) and the conflict is not trivial.

You don't say.

I ended up just re-doing that resolution entirely, and as I did so, I
think I found a bug in the original revert that caused the conflict in
the first place.

And since that revert made it into 5.15, I felt like I had to fix that
bug first - and separately - so that the fix can be backported to
stable.

I then re-did my merge on top of that hopefully fixed state, and maybe
it's correct.

Or maybe I messed up entirely.

I did end up comparing it to your other branch too, but that was
equally as messy, apart from the "ok, I can mindlessly just take your
side".

And it was fairly different from what I had done in my merge
resolution, so who knows.

ANYWAY. What I'm trying to say is that you should look very very
carefully at commits

  2cf3f8133bda ("btrfs: fix lzo_decompress_bio() kmap leakage")
  037c50bfbeb3 ("Merge tag 'for-5.16-tag' of git://git.../linux")

because I marked that first one for stable, and the second is
obviously my entirely untested merge.

It makes sense to me, but apart from "it builds", I've not actually
tested any of it. This is all purely from looking at the code and
trying to figure out what the RightThing(tm) is.

Obviously the kmap thing tends to only be noticeable on 32-bit
platforms, and that lzo_decompress_bio() bug also needs just the
proper filesystem settings to trigger in the first place.

Again - please take a careful look. Both at my merge and at that
alleged kmap fix.

                          Linus
