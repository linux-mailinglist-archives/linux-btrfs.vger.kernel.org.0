Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 317E244DE42
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Nov 2021 00:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234258AbhKKXI5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Nov 2021 18:08:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234260AbhKKXI4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Nov 2021 18:08:56 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343FDC061766
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Nov 2021 15:06:06 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id z10so3735128edc.11
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Nov 2021 15:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5D3+4vJF30PnckXaBwwWrlTwdIUWKxzS4vTsfPc8j0o=;
        b=J6EayESLNmMLm+bc+qFM6+QK9dseJHiwJiSt9baF/ify2YbXjSf8dA5d0PAANCtBOZ
         EKqoZTX9ZI6RNKYH8gkWuUOhT/cy1q7QHkV821rFCovm5m0SsE4H9JuMCKZB8LyK+6Tm
         P17xBqI21hEG9tIWnia3OVm/bzGh88eGB1qg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5D3+4vJF30PnckXaBwwWrlTwdIUWKxzS4vTsfPc8j0o=;
        b=Eow/X+MNiTLLZ7HYN8sYs1lsjoVYz8DcTZK3jPHjQTTLMHMulTJ7kACB4inlOHgP3m
         Dbo48VCb5JINiA+sdAINZB0QaYjnrn5s6BrsQJVJT0SlL9OzrtLdyDUhey7e0DbsFCtf
         f8tK6staubwzOa5f+YAAPRNr2qPl6vNhX26lkyriBssso1nyKNAsLjlQqWl4j6sP9pcl
         6eeI86NQlEYL+edxOpKhMFEKsw6O0sMZBEFElqCi0eFFrpQh3wdym8OglkjwH/Qz5ryF
         pSHOn7aSqwALfWa3C4gui/S/KgSN/Q3AyF58GdRQ4olzQg7GuPQ+prBUMi/eW2HrB2HV
         FoyQ==
X-Gm-Message-State: AOAM5337Zg9gQQmFdUB71iQDt1q8akW2FD2+d5FbH7JN8fs9jQxw5aW8
        dtTrxeSVKDaJPOhQ3Qz70Xr4K0bph3pzBajXAxs=
X-Google-Smtp-Source: ABdhPJzuk/RElxomZI0CUlwgCZcV2ZmjtLXfaYKfi4qkXCbGSAF2Qqnq9uY6oWAZOXpn7FI1pd8sXQ==
X-Received: by 2002:a17:906:b184:: with SMTP id w4mr13742767ejy.418.1636671964578;
        Thu, 11 Nov 2021 15:06:04 -0800 (PST)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id jg32sm2075251ejc.43.2021.11.11.15.06.04
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Nov 2021 15:06:04 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id o8so30074363edc.3
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Nov 2021 15:06:04 -0800 (PST)
X-Received: by 2002:a2e:530b:: with SMTP id h11mr10485841ljb.95.1636671592076;
 Thu, 11 Nov 2021 14:59:52 -0800 (PST)
MIME-Version: 1.0
References: <20211109013058.22224-1-nickrterrell@gmail.com> <471E6457-AF14-4E84-9197-BF30C3DCFFEB@fb.com>
In-Reply-To: <471E6457-AF14-4E84-9197-BF30C3DCFFEB@fb.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 11 Nov 2021 14:59:36 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg3Bqbn=V5kbd-5Rz9xzC_hNyOpNLPPTavZ1Zhdz1dt=w@mail.gmail.com>
Message-ID: <CAHk-=wg3Bqbn=V5kbd-5Rz9xzC_hNyOpNLPPTavZ1Zhdz1dt=w@mail.gmail.com>
Subject: Re: [GIT PULL] zstd changes for v5.16
To:     Nick Terrell <terrelln@fb.com>
Cc:     Nick Terrell <nickrterrell@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        "squashfs-devel@lists.sourceforge.net" 
        <squashfs-devel@lists.sourceforge.net>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>, Chris Mason <clm@fb.com>,
        Petr Malat <oss@malat.biz>, Yann Collet <cyan@fb.com>,
        Christoph Hellwig <hch@infradead.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        David Sterba <dsterba@suse.cz>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Felix Handte <felixh@fb.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Paul Jones <paul@pauljones.id.au>,
        Tom Seewald <tseewald@gmail.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Jean-Denis Girard <jd.girard@sysnux.pf>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 10, 2021 at 10:47 AM Nick Terrell <terrelln@fb.com> wrote:
>
> I just wanted to make sure that you=E2=80=99ve received my pull request. =
I=E2=80=99m a newbie
> here, so I want to make sure I=E2=80=99m not making a stupid mistake that=
 means you=E2=80=99ve
> missed my message. I=E2=80=99d hate for this PR to not even be considered=
 for merging
> in this window because of some mistake I=E2=80=99ve made.

Oh, it's in my queue, but it's basically at the end of my queue
because I will need to take a much deeper look into what's going on.

It's not just that you're a new source of pulls, it's also that this
is a big change and completely changes the organization of the zlib
stuff. So every time I look at my list of pending pulls, this always
ends up being "I'll do all the normal ones first".

So it's not lost, but this is the kind of pull that I tend to do when
my queues have emptied. Which they haven't done yet..

               Linus
