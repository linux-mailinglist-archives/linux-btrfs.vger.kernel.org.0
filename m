Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0A0843D3AA
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Oct 2021 23:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244249AbhJ0VRk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Oct 2021 17:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244244AbhJ0VRg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Oct 2021 17:17:36 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3223C061767
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Oct 2021 14:15:09 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id i26so5076613ljg.7
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Oct 2021 14:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hiXmABk2yLJcTBwV/OV64LUSAMHnd37fHZz79FC6JvU=;
        b=ZWNMOoSkuRaQ/lv8qizXhk55H0ec5K7RYuCkQOMY0yln4tyxGOGFp3Gs+/CZY7p6bT
         3CZlT/Neco4TP12/d9wLKcFuseqO24iEpPL6jwtGtY8MUiJAI9mKP12Z7SKjitGg++uj
         lH3CUAw1rGdqhKUixiRRtsMf0iuWhbOzVZTJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hiXmABk2yLJcTBwV/OV64LUSAMHnd37fHZz79FC6JvU=;
        b=NXnitOMZn5p8SATc1HORIhqjS21o8R1DioBRwMixaPvvlPBr1hGnVjWzi9nC/WKoE9
         ngyJEtyy0Kn1Xm2iYmm+SC1roV/cfqd0MagfTOaxT58YHS2/17McdKBTmNShpzQI0IhL
         EyBT47vkChFfPKxofkXsNch9PEBcFdotseJ68JAoraeSDpcxQRbnKBl7W78c2hP3vgEc
         OkwNUvvmIPRGSxpJL2pluq8yr0n9gSs/wauus3gXZxVVkpzYIbP7ZKGxBYI+PtXViJSf
         2km1/2C86M3nKD4JQTDY7yLwYOfGCU0rziGx5JWcnbDsXGmv3MckHS3ErBvVr2veWNzu
         Beww==
X-Gm-Message-State: AOAM531Zix2ksLZ6YErmt4Dqzzcb+hxPBe1ZzARz0HBakxS8J1JQGnNp
        Xgxa0V6lJYxHnLOwZe+r+TkYoEwxw2ucw+Gi
X-Google-Smtp-Source: ABdhPJw/E+snwh/SOWpZkQoWSRG3v/oQoXa1Y3pQs/WgqF2g0AXe1SU1FyyNTDGgQnz49xuRjHBjCA==
X-Received: by 2002:a2e:a90b:: with SMTP id j11mr331916ljq.282.1635369307470;
        Wed, 27 Oct 2021 14:15:07 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id q10sm104947lfu.68.2021.10.27.14.15.04
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Oct 2021 14:15:05 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id f3so790969lfu.12
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Oct 2021 14:15:04 -0700 (PDT)
X-Received: by 2002:a19:f619:: with SMTP id x25mr90493lfe.141.1635369304547;
 Wed, 27 Oct 2021 14:15:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wh0_3y5s7-G74U0Pcjm7Y_yHB608NYrQSvgogVNBxsWSQ@mail.gmail.com>
 <YXBFqD9WVuU8awIv@arm.com> <CAHk-=wgv=KPZBJGnx_O5-7hhST8CL9BN4wJwtVuycjhv_1MmvQ@mail.gmail.com>
 <YXCbv5gdfEEtAYo8@arm.com> <CAHk-=wgP058PNY8eoWW=5uRMox-PuesDMrLsrCWPS+xXhzbQxQ@mail.gmail.com>
 <YXL9tRher7QVmq6N@arm.com> <CAHk-=wg4t2t1AaBDyMfOVhCCOiLLjCB5TFVgZcV4Pr8X2qptJw@mail.gmail.com>
 <CAHc6FU7BEfBJCpm8wC3P+8GTBcXxzDWcp6wAcgzQtuaJLHrqZA@mail.gmail.com>
 <YXhH0sBSyTyz5Eh2@arm.com> <CAHk-=wjWDsB-dDj+x4yr8h8f_VSkyB7MbgGqBzDRMNz125sZxw@mail.gmail.com>
 <YXmkvfL9B+4mQAIo@arm.com>
In-Reply-To: <YXmkvfL9B+4mQAIo@arm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 27 Oct 2021 14:14:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjQqi9cw1Guz6a8oBB0xiQNF_jtFzs3gW0k7+fKN-mB1g@mail.gmail.com>
Message-ID: <CAHk-=wjQqi9cw1Guz6a8oBB0xiQNF_jtFzs3gW0k7+fKN-mB1g@mail.gmail.com>
Subject: Re: [PATCH v8 00/17] gfs2: Fix mmap + page fault deadlocks
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
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

On Wed, Oct 27, 2021 at 12:13 PM Catalin Marinas
<catalin.marinas@arm.com> wrote:
>
> As an alternative, you mentioned earlier that a per-thread fault status
> was not feasible on x86 due to races. Was this only for the hw poison
> case? I think the uaccess is slightly different.

It's not x86-specific, it's very generic.

If we set some flag in the per-thread status, we'll need to be careful
about not overwriting it if we then have a subsequent NMI that _also_
takes a (completely unrelated) page fault - before we then read the
per-thread flag.

Think 'perf' and fetching backtraces etc.

Note that the NMI page fault can easily also be a pointer coloring
fault on arm64, for exactly the same reason that whatever original
copy_from_user() code was. So this is not a "oh, pointer coloring
faults are different". They have the same re-entrancy issue.

And both the "pagefault_disable" and "fault happens in interrupt
context" cases are also the exact same 'faulthandler_disabled()'
thing. So even at fault time they look very similar.

So we'd have to have some way to separate out only the one we care about.

               Linus
