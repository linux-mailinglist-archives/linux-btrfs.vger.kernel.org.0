Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC84B1C51F4
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 May 2020 11:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbgEEJb2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 May 2020 05:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727931AbgEEJb2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 May 2020 05:31:28 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D54C061A0F
        for <linux-btrfs@vger.kernel.org>; Tue,  5 May 2020 02:31:27 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id q8so1119608eja.2
        for <linux-btrfs@vger.kernel.org>; Tue, 05 May 2020 02:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanderster.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bRBgUoMD9aVl/dzKCg/TkfzMwdC8Y+X1GZcSawFTx+8=;
        b=JXjPYW/BrOlGCqxl7NM2JXCMin4C0dN5tCtdkGktLQla5d50QY8d5jKjBXmHqLV59h
         4pNhArkh6tEQylN7o8F+xX9X4L0C8ztJyaPWANYQoGcQUicfF8QU4z7e31aVI7HHMB7Z
         xU0gkSiIICr1Y+6lz1kN2aWJ+Fob0ziDyGxOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bRBgUoMD9aVl/dzKCg/TkfzMwdC8Y+X1GZcSawFTx+8=;
        b=afL9PrrbTkfMvthVrXCdpbG/9BYflbvIS11WQ+UyuUZAtkEuBaAhD4f6VlMmOr8zxT
         HCvMTvZ8LnsFSm6DlY4aZvuU5kHbDJcebKlrGdUxqY1LPd2X0K1Ksw8XuWmA2M6qZe/M
         7dSTbyVfqQMmUmoUUTHPUYMlYyDdJFUOGsa0+L5aH0iJkj9dWE8R2DLKXkQsLh/iKgPf
         3EBW7Z71tXl4nVVX1t///2DQBmNs/FptqGuAvejJeNc69vyxyaW5ge3k20582Ue0taiP
         Y4sCVlMUcfM9jPD4O5AJU31d786lC/f/3eCk/lwUQu2T2qWD+W+4Rp4oNpub5u4od9rZ
         yJ/Q==
X-Gm-Message-State: AGi0PuZ8KZTlYrQvxc7udE81PBlFfA/gPlwXoTgHRqNDqmtiikfl5IS/
        yUoIE7SiPNHMeNEgcn+jp+VqHxAux2s=
X-Google-Smtp-Source: APiQypKJBTdVA24uLhBw7+XTQQKm/L0GyQ6lYsW6Z/WvpIuQebpyO8wvCLL7JkLefPR6CSrVlg+DmA==
X-Received: by 2002:a17:906:16d0:: with SMTP id t16mr1654746ejd.303.1588671085825;
        Tue, 05 May 2020 02:31:25 -0700 (PDT)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id a10sm299121ejt.18.2020.05.05.02.31.24
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2020 02:31:24 -0700 (PDT)
Received: by mail-wm1-f46.google.com with SMTP id h4so1479164wmb.4
        for <linux-btrfs@vger.kernel.org>; Tue, 05 May 2020 02:31:24 -0700 (PDT)
X-Received: by 2002:a1c:dfc2:: with SMTP id w185mr2329400wmg.1.1588671083772;
 Tue, 05 May 2020 02:31:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAG+QAKXuaah3tkhQLd7mD3bx+pc3JZdXkUg6yr0R8=Zv2vXnhw@mail.gmail.com>
In-Reply-To: <CAG+QAKXuaah3tkhQLd7mD3bx+pc3JZdXkUg6yr0R8=Zv2vXnhw@mail.gmail.com>
From:   Dan van der Ster <dan@vanderster.com>
Date:   Tue, 5 May 2020 11:30:47 +0200
X-Gmail-Original-Message-ID: <CABZ+qqmT2==GvkD0hMFn8m=v_UYXgitcWdxbUrEEdmdbkUfwmQ@mail.gmail.com>
Message-ID: <CABZ+qqmT2==GvkD0hMFn8m=v_UYXgitcWdxbUrEEdmdbkUfwmQ@mail.gmail.com>
Subject: Re: Western Digital Red's SMR and btrfs?
To:     Rich Rauenzahn <rrauenza@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

FWIW, I've written a little tool to help incrementally, slowly,
balance an array with SMR drives:

   https://gist.github.com/dvanders/c15d490ae380bcf4220a437b18a32f04

It balances 2 data chunks per iteration, and if that took longer than
some threshold (e.g. 60s), it injects an increasingly larger sleep
between subsequent iterations.
I'm just getting started with DM-SMR drives in my home array (3x 8TB
Seagates), but this script seems to be much more usable than a
one-shot full balance, which became ultra slow and made little
progress after the CMR cache filled up.

And my 2 cents: the RAID1 is quite usable for my media storage
use-case; outside of balancing I don't notice any slowness (and in
fact it maybe quicker than usual, due to the CMR cache which
sequentializes up to several gigabytes of random writes)

Cheers, Dan

On Sat, May 2, 2020 at 7:25 AM Rich Rauenzahn <rrauenza@gmail.com> wrote:
>
> Has there been any btrfs discussion off the list (I haven't seen any
> SMR/shingled mails in the archive since 2016 or so) regarding the news
> that WD's Red drives are actually SMR?
>
> I'm using these reds in my btrfs setup (which is 2-3 drives in RAID1
> configuration, not parity based RAIDs.)   I had noticed that adding a
> new drive took a long time, but other than than, I haven't had any
> issues that I know of.  They've lasted quite a long time, although I
> think my NAS would be considered more of a cold storage/archival.
> Photos and Videos.
>
> Is btrfs raid1 going to be the sweet spot on these drives?
>
> If I start swapping these out -- is there a recommended low power
> drive?  I'd buy the red pro's, but they spin faster and produce more
> heat and noise.
>
> Rich
