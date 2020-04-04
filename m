Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1F619E23E
	for <lists+linux-btrfs@lfdr.de>; Sat,  4 Apr 2020 03:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbgDDB1F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Apr 2020 21:27:05 -0400
Received: from mail-ua1-f41.google.com ([209.85.222.41]:33490 "EHLO
        mail-ua1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbgDDB1F (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Apr 2020 21:27:05 -0400
Received: by mail-ua1-f41.google.com with SMTP id v24so3481343uak.0
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Apr 2020 18:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0dDVwAUsogZB/r+sdMuWqraVuekifVNKuZt4BeBAyBw=;
        b=NfzG1T7vKAsMvwIptP1Hqy/NxX/5JSAIbysJ1Pn6AkIIR1KeqQ6Zro3oPWCtV0GEih
         y3Mfkzg+b0YFT2kgXxPfFAC0GySiyIwXbfwuEJekxUBGMvqhSALQBbR1BCUa1mtXFH0a
         aJKSoU0F3UwPcyJvTsGkYnuDR+5tDUvhouBCxBH1slp93USk8rpgd301pg8zVeqkyaue
         6jgpPMoXk7lWOTeUQyrQ94epO2h2PsH6wBrt/mDK+SUuA5+QFOw8u9AuiMZzLhM3RepL
         p404PEtxJK1m36h7tIYQZxhhGn2uCHoYUFfQsrQunuDQccdpj7ntbCoqAdQ74h/09rbf
         v7Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0dDVwAUsogZB/r+sdMuWqraVuekifVNKuZt4BeBAyBw=;
        b=A+F1ozC8Dv5NLm2S9CFSjNJq7QedovRjFIZxbbS/CbLLQ7BB7LOCtVdrQcoRmc72et
         FgfKRdkcbtD4McZCavldxsWmOrDq5HJl8xyANIZJXrMdyKAyEsRyHE3RH4PI9Xu9caM7
         eXWExY24lZ8cT/aIyulpIWqxcrZkuvfZpYt9ZneU0d3euVbWEg7hzNX3veR+1CVzzDUp
         He0NQZpddordCs/eH6jnj1r8oi/qKcYqHkybGdlBKvCdi3cYRiN+TPOIIdhgcrvcyq87
         maVafZIzHOpBPEZ0+k7EGX4xZuQOVOKquubFQMnuSbih0ZA0YVWJLeatc7pPeUncel/X
         gV0w==
X-Gm-Message-State: AGi0PuatnB7C0Y3OxdVFvYX31GRVCSDtXA3vWLSKjqUj8dF+bVW4NHbj
        UakAfQOnqH2SPWoEquM3gPCvzzAQh1jkALLwY45/5A==
X-Google-Smtp-Source: APiQypLfYDUMINJNv0SKoYRnYiqNHDq9omM3g2eFuPjpdorqHVaDXbfLC9dEme4z6gU0iWRCk9WC6SYoydjSuwmBzho=
X-Received: by 2002:ab0:5fd4:: with SMTP id g20mr8626193uaj.125.1585963624315;
 Fri, 03 Apr 2020 18:27:04 -0700 (PDT)
MIME-Version: 1.0
References: <CANs+87QtdRhxx8gSsHzweMfbznJXLXRdn3SQDPd5uv-K-BZM=w@mail.gmail.com>
 <58f96768-79cb-89c4-7335-0db1d2976b59@cobb.uk.net> <CANs+87Tk=Havdiowgqt3NP6Q5VaJM4X6jVx0yXg+PidME1mT9w@mail.gmail.com>
 <CAJCQCtQ8HySYrYRyuyNB3Gpc=qHPgj9W32=xF3tR7_-NH8LP+Q@mail.gmail.com>
In-Reply-To: <CAJCQCtQ8HySYrYRyuyNB3Gpc=qHPgj9W32=xF3tR7_-NH8LP+Q@mail.gmail.com>
From:   Helper Son <helperson2000@gmail.com>
Date:   Fri, 3 Apr 2020 22:26:52 -0300
Message-ID: <CANs+87RpjKgCHLnogTOh1ovOrRJa5bmy5cWCo3RSdTmJ=dEj8w@mail.gmail.com>
Subject: Re: btrfs filesystem takes too long to mount, fails the first time it
 attempts during system boot
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I appreciate the information. Honestly, after applying the solution
posted here so it mounts successfully on bootup I was only really
concerned if this was normal behavior or not. The longer mount time is
an acceptable price to pay for the features I get out of btrfs as long
as it is not indicative of an actual problem.

I did convert to space_cache=v2 as part of my testing on trying to
reduce mount times, it took a few minutes to generate the new cache.
I'd say mount times were reduced by 10-15%.

I'll keep an eye on the mailing list and on the updates released and
hope this improves in the future. Thanks for all the assistance.

On Fri, Apr 3, 2020 at 7:02 PM Chris Murphy <lists@colorremedies.com> wrote:
>
> On Thu, Apr 2, 2020 at 8:36 PM Helper Son <helperson2000@gmail.com> wrote:
>
> > Thanks for the suggestion, the main problem is fixed on my end. At
> > this point I'm just wandering if taking this long to mount is normal
> > behavior and if there is anything else I can do to reduce the time,
> > but I suppose it's part of how btrfs works.
>
> It's normal on large file systems. There is work in progress to make
> this faster, but I'm not sure when it'll be merged. I think this does
> some short cuts when reading the chunk and extent trees at mount time.
>
> You could try switching to space_cache=v2 if you aren't already using
> it. It's safe to do: mount -o remount,clear_cache,space_cache=v2.
> Usually the rebuild goes fast, on 1T file system. Maybe it takes a
> minute on a 20T file system? Just a guess. I can't estimate how much
> it'll improve mount time, but it should somewhat at least.
>
>
>
> --
> Chris Murphy
