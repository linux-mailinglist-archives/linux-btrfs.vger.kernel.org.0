Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FED83A7154
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Jun 2021 23:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234622AbhFNVbo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Jun 2021 17:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234042AbhFNVbn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Jun 2021 17:31:43 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7C9C061767
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Jun 2021 14:29:40 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id d184so12929130wmd.0
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Jun 2021 14:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KVw5OLXMEvmuBwfWCuctqzQ+ZxRx+RuP9ph2B+HXvlY=;
        b=dyK+R0yKyCzuSIEVUzXMmhK3EFLE2JAI4hv/RsGREy8jWtkiE8z/QONejh6XjgsjEp
         1iV3X0K2wbJ+qorlp6tbXpWbuoqvxZQMgMUcc8wJ41wGiSIq+PHobmyMGGgAdT8a6/vZ
         qEH3x0Vd+iTBXhVo2ZNSh5KOwmpBKWixZ1N+FJZhz7YmmFHHlPeRIBfE2E7Ps1Amz8/1
         DutmKB6pxZQdiqSiKtpxNdi37Jmxl0X496H4Cb2DQS/BfUjxCTbKj+lmPQWEW0q93iGf
         GqZYK02lSngXk1F3/bRoR8LlqCif19gRZLk1kTgvEVDpPjua+g69EIfblbGrB15sfzgt
         hH+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KVw5OLXMEvmuBwfWCuctqzQ+ZxRx+RuP9ph2B+HXvlY=;
        b=iDB2/u3YCMh9wgHtkp14NzfwrZxJr6/a3mPem88S6wiXX14xZhiidCVYdMCrTUawwy
         Yhpubz1vz0V+HsH7SAiZ3/iAlpol4MwXOwkUedDZl5kwFrf1jKBui4BUvFzv+Dt6ROsL
         o4mZ7QKb/A5HvpvaINzITqNKObkVTP/litdFpgdXWM/flydtx3N2dO3no48Xi4xbUt/w
         wFGCcj4bNMx1/gMWTMqzJ9TVwPySIBBl9d0GCJs+flmVKLoPEHl6aRXTOtq0mW8o0eGt
         qYlTyIJhR0hBCEKetL86V0TWLCKCoRE5PE31r92N+cd+Y+Uoq2lAtF03Z0VnlwoBgR8L
         Tn+Q==
X-Gm-Message-State: AOAM5308UqP92NcWJKXC6nohtY3TMuj+MvQukGFZtuVt+wbjs2AyzAAv
        IgWKVpP38SHsktRjXSssTJaSikUupM7ln8YhAtm5IQ==
X-Google-Smtp-Source: ABdhPJwhslZGy31lqM8shtoXAi/hnyEkXnQ7IJJBsCrdPGDuWcd6r8189EE2suGj7Iph5adL9R7+x7QLXggpD65Kb8Y=
X-Received: by 2002:a05:600c:1d0a:: with SMTP id l10mr1239677wms.124.1623706178579;
 Mon, 14 Jun 2021 14:29:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtRQ57=qXo3kygwpwEBOU_CA_eKvdmjP52sU=eFvuVOEGw@mail.gmail.com>
 <CAL3q7H7iOfFFq_vh80Zwb4jJY8NLq-DFBA4yvj7=EbG0AadOzg@mail.gmail.com>
 <CAJCQCtSDYJKq7rrjMLyaHVz3ELgM7g8DBGJrFMOkrw7aBQW+kA@mail.gmail.com> <CAL3q7H7kCNs+fbqyHqwpuJvUudeMKOSWewEfCSdTKc1qFkSiJg@mail.gmail.com>
In-Reply-To: <CAL3q7H7kCNs+fbqyHqwpuJvUudeMKOSWewEfCSdTKc1qFkSiJg@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 14 Jun 2021 15:29:22 -0600
Message-ID: <CAJCQCtR0AEEkzR=K2eJjeUhm5TnwCUy945LLLUciFw+tOwrSnA@mail.gmail.com>
Subject: Re: WARNING at asm/kfence.h:44 kfence_protect_page
To:     Filipe Manana <fdmanana@gmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 14, 2021 at 2:43 PM Filipe Manana <fdmanana@gmail.com> wrote:
>
> On Mon, Jun 14, 2021 at 9:07 PM Chris Murphy <lists@colorremedies.com> wrote:
> > No, but Fedora debug kernels do have it enabled so I can ask the
> > reporter to use 5.12.10-debug or 5.13-rc6. Any preference?
>
> No preference.
> It's a problem that has been around for several years now, and not
> something recent.
>
> Ok, so it was reported before. Anywhere public, or was it something private?

https://bugzilla.redhat.com/show_bug.cgi?id=1971327



>
> >
> >
> > > That would trigger an assertion right away:
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/fs/btrfs/transaction.c?h=v5.12.10#n584
> > >
> > > With assertions disabled, we just cast current->journal_info into a
> > > transaction handle and dereference it, which is obviously wrong since
> > > ->jornal_info has a value that is not a pointer to a transaction
> > > handle, resulting in the crash.
> > >
> > > How easy is it to reproduce for you?
> >
> > I'm not sure.
> >
> > Do you think following this splat we could have somehow been IO
> > limited or stalled without any other kernel messages appearing? That
> > would then cause reclaim activity, and high memory and swap usage? I'm
> > wondering if it's likely or unlikely, because at the moment I think
> > it's unlikely since /var/log/journal was successfully recording
> > systemd-journald journals for the 81 minutes between this call trace
> > and when systemd-oomd started killing things. I'm trying to separate
> > out what's causing what.
>
> Don't know about that. And honestly I don't think that it matters.
> The send task writes to a pipe and writing to a pipe allocates pages
> without GFP_NOFS (with GFP_HIGHUSER | __GFP_ACCOUNT to be precise),
> meaning we can end up evicting an inode, which in turn needs to start
> a transaction.
>
> That patch would be my preferred way to fix it.
> If it doesn't work for any reason, then we can simply set up a NOFS
> context surrounding the calls in send to write to the pipe, like this:
>
> https://pastebin.com/raw/tTrfAw0m
> (also attached)
>
> I would have to test the first patch in a scenario under heavy memory
> pressure to see if there isn't anything I might have missed, but I
> think it should work just fine.
> I'll test it tomorrow too.
>

The system was under heavy swap and memory pressure, but the logs
don't tell us the contributors or their relative amounts. But logs
show that Bees continued to make progress for almost an hour and a
half after the splat, up until the wayland+shell service was killed by
oomd. I'd expect any blocked tasks to result in warnings about it
every 2 minutes in the journal.

Swap being on zram during the memory pressure period might be a
complicating factor, combining IO, CPU and memory pressure.


-- 
Chris Murphy
