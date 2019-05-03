Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF6912778
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2019 08:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfECGFd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 May 2019 02:05:33 -0400
Received: from mail-lj1-f181.google.com ([209.85.208.181]:34466 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfECGFd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 May 2019 02:05:33 -0400
Received: by mail-lj1-f181.google.com with SMTP id s7so4290745ljh.1
        for <linux-btrfs@vger.kernel.org>; Thu, 02 May 2019 23:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1JyeENOs3Isd5Fb18JyTo+kELH4kBQVVz6AOukmWa28=;
        b=b8+JACnRh6/flJHWAvC/YGM9+bBjPeSSffZLFUKbuOB5VzlcJ799z4i9kXvNX90KUE
         pHUdhJ6c9aK4rKKA8qmNLENWLLkg9u6XueIxoji1Dw5fDE5aqiQGS7SidVg/4A+tkCFS
         MLEDyZHDXnxK7GXsKnc9WWQIElzkLHRP/gypiuptvJK71SoF5WbTKUX4lSUNf9dZ4LPa
         ZqudaqScbJVz3Rhl3VI55S7b2PxO0k5JQpQ7ojNMUV11usjhoTahcPZ/wMiiIxDJBwSA
         j0ZqV1qNV9GzNPqNkVRDZub70+PgKHKHal3o3ZglzU7gtrXkjdIzzNF9bXhNafmaXow+
         OlsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1JyeENOs3Isd5Fb18JyTo+kELH4kBQVVz6AOukmWa28=;
        b=FV5HMloqYfYJyTPSm2sDto+CD/sh35QPzWd7sgvjJyNJ7zR+x4QqlatYCy/Cu+Wj+P
         baAvTSAh4VGrlythPWP6Ol4UUBbYQPvHhMUa5XMdtoDIQotFI1gxwDGM2mAfmal9OHRi
         mox7pHWmrmQqCCIK7/VYrV4cWLlMoTzuNNgysifg0RHyApynUcxVqkmfgybVFP9N2so6
         VR4nmWMzkUNnZxWJn56VDqEfDqez42/swbvO6uGCm0INO4e9zuyT7VX5LlwX+sNKwNVw
         xKsVUfDeDofrLk6GcLZY1sgKaI4jF+FPH5Fi/4cL5Er1/sL7CQWkpAJEysypn/iQxvj0
         MvPg==
X-Gm-Message-State: APjAAAWiEVcxqIjXVgY1L9nkDvq2d9+sKXrO1wOFLpEIuT2BRBcbCXNB
        X/yxEbyFi+BXJXiI7YHYcKxKu+ZdqntvOMesj5n2EQ==
X-Google-Smtp-Source: APXvYqzHTAsdXQ4tlWUQK+Fcac8rzxcn47KtjoZzletTSLfr5DnhEFOQnlKQFSLt3R7iMuiUXTCYjpsjS4L9qBMTEHM=
X-Received: by 2002:a2e:9d4c:: with SMTP id y12mr4004825ljj.132.1556863531323;
 Thu, 02 May 2019 23:05:31 -0700 (PDT)
MIME-Version: 1.0
References: <em9eba60a7-2c0d-4399-8712-c134f0f50d4d@ryzen> <e6918268-1e3e-6c2d-853c-aa1eaf8e9693@gmx.com>
 <ema5c33b0a-936b-48f6-99ba-4c5a50e8a88a@ryzen>
In-Reply-To: <ema5c33b0a-936b-48f6-99ba-4c5a50e8a88a@ryzen>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Fri, 3 May 2019 00:05:20 -0600
Message-ID: <CAJCQCtTHFi8uR1JndoXju0HvfGvBwXK6Pq4oqJiop82FaT_J-A@mail.gmail.com>
Subject: Re: Re[2]: Rough (re)start with btrfs
To:     Hendrik Friedel <hendrik@friedels.name>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 2, 2019 at 11:41 PM Hendrik Friedel <hendrik@friedels.name> wrote:
>
> Hello,
>
> -by the way: I think my mail did not appear in the list, but only
> reached Chris and Qu directly. I just tried to re-send it. Could this be
> caused by
> 1) me not a subscriber of the list
> 2) combined with me sending attachments
> I did *not* get any error message by the server.
>
> >>  I was tempted to ask, whether this should be fixed. On the other hand, I
> >>  am not even sure anything bad happened (except, well, the system -at
> >>  least the copy- seemed to hang).
> >
> >Definitely needs to be fixed.
> >
> >With full dmesg, it's now clear that is a real dead lock.
> >Something wrong with the free space cache, blocking the whole fs to be
> >committed.
> >
> So, what's the next step? Shall I open a bug report somewhere, or is it
> already on some list?
>
> >If you still want to try btrfs, you could try "nosapce_cache" mount option.
> >Free space cache of btrfs is just an optimization, you can completely
> >ignore that with minor performance drop.
> >
> I will try that, yes.
> Can you confirm, that it is unlikely, that I lost any data / damaged the
> Filesystem?

Not likely. You can do a scrub to check for metadata and data
corruption. And you can do an offline (unmounted) 'btrfs check
--readonly' to check the validity of the metadata. The Btrfs call
traces during the blocked task are INFO, not warnings or errors, so
the file system and data is likely fine. There's no read, write,
corruption, or generation errors in the dmesg; but you can also check
'btfs dev stats <mountpoint>' which is a persistent counter for this
particular device.

-- 
Chris Murphy
