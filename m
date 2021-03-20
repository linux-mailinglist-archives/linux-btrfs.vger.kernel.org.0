Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98090342975
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Mar 2021 01:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbhCTAcH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Mar 2021 20:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhCTAbi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Mar 2021 20:31:38 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A45C061761
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Mar 2021 17:31:38 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id x28so12627688lfu.6
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Mar 2021 17:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=61j+NwfICNWJWz0XMgFUBwrGhoQDi0J8u1n1is81ZYM=;
        b=CpbSVYpb9YM1T9z1e1UZGf7HmWEG3ed4KwVewC9begrECftVwGF0pqxn4xXjZL6kO3
         A9HqtpleUFq3FaYakT6UFgrfqOt7d3YRtgmx1JZdEDBxycA0My59WwVuumIknimBFEkM
         fCqs/yzGnaUnaQYMf0T5oTP5vCgohxkIx1HUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=61j+NwfICNWJWz0XMgFUBwrGhoQDi0J8u1n1is81ZYM=;
        b=eyY6lCo14JYgmMguMyqh6fiPrS2rIZKKGuIQpBDOmQJ+AdZOvTvd0M2FISyBye/6v9
         CDXvhSRG1KoYMm2RgKPmBcuF9U/opx/wlZFm3oXDZze+yUggUNj0XNEQitfbJvLuLatY
         uU5U04OtK6yMW7AeS2tPpPxPZj1xSIkQN/hFLsnigLwLlji/2eFmav/epxUT2Ju0DwYS
         so9av5neijg/fIE8Mq+77VTzEnzYzv2sRnE/gbL5xsyeq1B7pI7bwrm4Wr4DyFSL5Bgo
         gMYf18e+MdEQseQzVdceLDQpMtIccy0mYQDNfQRtHeANWczc3pojxF/PvVDwWU+ZEwcU
         38wA==
X-Gm-Message-State: AOAM530QtvmbWoKdnT8nXGm8Qpf01FpqwUkIp2RK81JO+ryc46z6u800
        g9YkjvjQnJRrkOngk0xTUoOQ2+9mnMhPXQ==
X-Google-Smtp-Source: ABdhPJzCqabQGpKM2ruU4VVmtq5V36Qi1wklVkinan+Xacg1QQ/jPnXJjwQmLrEvVWPyHmyHTT7nwQ==
X-Received: by 2002:a05:6512:c5:: with SMTP id c5mr2301700lfp.158.1616200296431;
        Fri, 19 Mar 2021 17:31:36 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id b30sm779618lfj.101.2021.03.19.17.31.34
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Mar 2021 17:31:35 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id g8so5503582lfv.12
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Mar 2021 17:31:34 -0700 (PDT)
X-Received: by 2002:ac2:58fc:: with SMTP id v28mr2189309lfo.201.1616200294775;
 Fri, 19 Mar 2021 17:31:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1615922644.git.osandov@fb.com> <8f741746-fd7f-c81a-3cdf-fb81aeea34b5@toxicpanda.com>
 <CAHk-=wj6MjPt+V7VrQ=muspc0DZ-7bg5bvmE2ZF-1Ea_AQh8Xg@mail.gmail.com>
 <YFUJLUnXnsv9X/vN@relinquished.localdomain> <CAHk-=whGEM0YX4eavgGuoOqhGU1g=bhdOK=vUiP1Qeb5ZxK56Q@mail.gmail.com>
 <YFUTnDaCdjWHHht5@relinquished.localdomain> <CAHk-=wjhSP88EcBnqVZQhGa4M6Tp5Zii4GCBoNBBdcAc3PUYbg@mail.gmail.com>
 <YFUpvFyXD0WoUHFu@relinquished.localdomain>
In-Reply-To: <YFUpvFyXD0WoUHFu@relinquished.localdomain>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 19 Mar 2021 17:31:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=whrT6C-fsUex1csb4OSi06LwaCNGVJYnnitaA80w9Ua7g@mail.gmail.com>
Message-ID: <CAHk-=whrT6C-fsUex1csb4OSi06LwaCNGVJYnnitaA80w9Ua7g@mail.gmail.com>
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

On Fri, Mar 19, 2021 at 3:46 PM Omar Sandoval <osandov@osandov.com> wrote:
>
> Not much shorter, but it is easier to follow.

Yeah, that looks about right to me.

You should probably use kmap_local_page() rather than kmap_atomic()
these days, but other than that this looks fairly straightforward, and
I much prefer the model where we very much force that "must be the
first iovec entry".

As you say, maybe not shorter, but a lot more straightforward.

That said, looking through the patch series, I see at least one other
issue. Look at parisc:

    +#define O_ALLOW_ENCODED 100000000

yeah, that's completely wrong. I see how it happened, but that's _really_ wrong.

I would want others to take a look in case there's something else. I'm
not qualified to comment about (nor do I deeply care) about the btrfs
parts, but the generic interface parts should most definitely get more
attention.

By Al, if possible, but other fs people too..

           Linus
