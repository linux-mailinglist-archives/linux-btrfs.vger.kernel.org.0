Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03A002DD3D7
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Dec 2020 16:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbgLQPMj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Dec 2020 10:12:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:35060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726595AbgLQPMj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Dec 2020 10:12:39 -0500
X-Gm-Message-State: AOAM532Rl0yznEmj+QQohruLYePrKbympAOKRQtkri1W6TEQtqsb3B7O
        mvutZdVwXyEt77sYWF024qQu12DHJIWyPz5L1Hg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608217918;
        bh=BAwehZip/RoV1l3RjQU6AdXRTREUFyRP2C4bm0yjmbc=;
        h=References:In-Reply-To:From:Date:Subject:To:From;
        b=LFT5a/2geMEO2bBUxjb+S0MY2B/OuiiBgdG7ZFj8jI57obDQICgVQS8XT8GTDXOyD
         oGqkcZk+MF+esSpHUL8BNUqJVw2G46Af27MPgXKaN6ZKd+n6VOEHeMQzRlmqYfYGvn
         csGwwHq0M2/X4nitVijZ2ZluluMSR/pMlrXXyFsEaQ2il6+CQmbnf3gfr0Ryo8250x
         0VT6CWJOQ9j0sjFVY4aZQ//u5/785bM1AJJAmmWQN0T0qjtwcw1kGRprDfgxDtCHLK
         Z3KtcS8PSZfVPsa1hxVWVh/OUzlnP3G70v0mltc34LLPgHd/WfFp8ucnHZsraEOQbO
         Pe+rzTypAZrEQ==
X-Google-Smtp-Source: ABdhPJxc8h17rNafmp7Ve8THHNSmBNNK1sNHraEchmSw/7Xc/O5gfmiBHNDOjSgCBGaa87LXZXNQWMB9jRhWpHizHQ8=
X-Received: by 2002:a0c:ac44:: with SMTP id m4mr49283954qvb.45.1608217917329;
 Thu, 17 Dec 2020 07:11:57 -0800 (PST)
MIME-Version: 1.0
References: <cover.1607939569.git.fdmanana@suse.com> <20201217150203.GP6430@twin.jikos.cz>
In-Reply-To: <20201217150203.GP6430@twin.jikos.cz>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Thu, 17 Dec 2020 15:11:46 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4ZacbJg_UL6RXv-j+RG4E6csQxW4M=Ea7_QchT4PcU-Q@mail.gmail.com>
Message-ID: <CAL3q7H4ZacbJg_UL6RXv-j+RG4E6csQxW4M=Ea7_QchT4PcU-Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] btrfs: fix races between clone, fallocate and memory
 mapped writes
To:     dsterba@suse.cz, Filipe Manana <fdmanana@kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 17, 2020 at 3:03 PM David Sterba <dsterba@suse.cz> wrote:
>
> On Mon, Dec 14, 2020 at 09:56:40AM +0000, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > For a very long time there's been a race between clone/dedupe and memory
> > mapped writes as well as between fallocate and memory mapped writes. For
> > both cases the consequence of the race is that it can makes us deadlock
> > when we are low on available metadata space, since clone/dedupe/fallocate
> > start a transaction while holding file ranges locked, and allocating the
> > metadata can result in the async reclaim task to flush the inodes being
> > used by clone/dedupe/fallocate, if a memory mapped write happened before
> > we locked the file ranges.
> >
> > For the dedupe case, Josef's recent fix [1] ("btrfs: fix race between dedupe
> > and mmap") happens to fix this deadlock problem as well. The first patch
> > in this patchset fixes the issue for both clone and dedupe, as it's centered
> > on the shared extent locking function, and it is independent of Josef's fix
> > (works both with and without that fix).
>
> Thanks, I was wondering how all the patches are related.
> >
> > [1] https://lore.kernel.org/linux-btrfs/afdc2109f83fff1a925d7a66a6a047d4400721d4.1607724668.git.josef@toxicpanda.com/
> >
> > Filipe Manana (2):
> >   btrfs: fix race between cloning and memory mapped writes leading to
> >     deadlock
> >   btrfs: fix race between fallocate and memory mapped writes leading to
> >     deadlock
>
> Added to misc-next, thanks.

Something I haven't mentioned afterwards, as I have been waiting for
vger to deliver me the mails for another patchset from Josef (have
been having 2 to 4 days delays) is that that patchset from Josef:

https://lore.kernel.org/linux-btrfs/cover.1607969636.git.josef@toxicpanda.com/

replaces this patchset and the following RFC patch:

https://lore.kernel.org/linux-btrfs/afdc2109f83fff1a925d7a66a6a047d4400721d4.1607724668.git.josef@toxicpanda.com/

We agreed on Slack that a more generic solution was better, even
because the RFC patch above from Josef ended up being racy and didn't
fully fix the problem.
It doesn't help either that the cover letter for the above patchset
from Josef did not mention this, nor was it discussed in the thread
for the RFC patch.

So please drop this one and replace it with Josef's patchset. I had
just given the review on github:
https://github.com/btrfs/linux/issues/163

Thanks.
