Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 718374AA7C
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jun 2019 20:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730441AbfFRS6G (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Jun 2019 14:58:06 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:42036 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730434AbfFRS6G (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Jun 2019 14:58:06 -0400
Received: by mail-wr1-f50.google.com with SMTP id x17so628230wrl.9
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Jun 2019 11:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uq+Xjo/QVlbjKMMa9kPCPiSGyPObx2SlIMjOdw9Vy0U=;
        b=1nbq1mQXjxOTpCMCBSBr36c2YoZ4p3ygbTC6WpzZGDy4einzn12MYPj0DzmkXqzxuC
         GLSlT4EA82RpnIGuf0SUgwwtwjrO3nhrAA5LLgtlCxe0UpblYW32fIQ+9sjR0BXcVeIW
         Czhtld5V6OxFCIw7GWydOp2b/tF1a0KBqAvRhBu3H553kyfiVd35vZvKEMHPavA7uyDr
         jh/ZBJu4o9M3ksjf2geuBhIbK4J+ODmKrfJgLInAIR6WAFTGl9p6nMm33lyxW5/Sc9cA
         c7N7gNOqyrvitiJgSUnYQn1LFCPjevLyUoHFMtIPqQuqHjW8l41wf10otd803H/ZlVbi
         f+mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uq+Xjo/QVlbjKMMa9kPCPiSGyPObx2SlIMjOdw9Vy0U=;
        b=Lr3qKI1t3lNLRUaN0A1kJkieZiE6GIGwD35/WqGxwIUJZN+EMuoJNKOPv830/hbf32
         Uk4QGTS4374I6GqjKdIY4RZ3VIjZa/fvvCu+FWx5ac4FQfSpz0JAG0YERX6AZ4oXg9o9
         1fftXIv0PphgU+RsSPOQIZ4Umjc0R47nWqYyvvGWjKKDtHDusgp9n8OLynwHqMwpR8DN
         IelQQkWA5QtpWw72t+R40IjQOBSYk6+jnT6MGdXOmYvYSQKHv/a+VOscTaqtTzkTWSI4
         HE5erIX+UzRBITGKucLt9H4xr3l6ZNDf12DLNkxb4ZO+0nzz8bw61drmqBL+0AYxLdEx
         QY7w==
X-Gm-Message-State: APjAAAU89rbT1lYa0qtUo74V+11i8pFKA3IFfsr8Cn/FmNMjopdrFUZS
        1utaEBUf7LnsJ8AWn9fatqi4kABW8ORcVZcv89BRCw==
X-Google-Smtp-Source: APXvYqyBhqu08CHygX0U1++Kft2PFQXug7THT11Qub/oOJvW8ZdV6wgaMSzHlgBYPUTH3c7BPddVp3ph21ATAOfxdko=
X-Received: by 2002:adf:afd5:: with SMTP id y21mr81170947wrd.12.1560884283969;
 Tue, 18 Jun 2019 11:58:03 -0700 (PDT)
MIME-Version: 1.0
References: <16b6bd72bc0.2787.faeb54a6cf393cf366ff7c8c6259040e@lesimple.fr>
 <20190618184501.GJ21016@carfax.org.uk> <51e41a52-cbec-dae8-afec-ec171ec36eaa@gmail.com>
In-Reply-To: <51e41a52-cbec-dae8-afec-ec171ec36eaa@gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 18 Jun 2019 12:57:53 -0600
Message-ID: <CAJCQCtRNrQJKcS6BPZX4evp38uZCWkJW+CEYGeyqGzjiOFyvTg@mail.gmail.com>
Subject: Re: Rebalancing raid1 after adding a device
To:     "Austin S. Hemmelgarn" <ahferroin7@gmail.com>
Cc:     Hugo Mills <hugo@carfax.org.uk>,
        =?UTF-8?Q?St=C3=A9phane_Lesimple?= <stephane_btrfs@lesimple.fr>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 18, 2019 at 12:50 PM Austin S. Hemmelgarn
<ahferroin7@gmail.com> wrote:
>
> On 2019-06-18 14:45, Hugo Mills wrote:
> >     -dlimit=100 will only move 100 GiB of data (i.e. 200 GiB), so it'll
> > be a pretty limited change. You'll need to use a larger number than
> > that if you want it to have a significant visible effect.
> Last I checked, that's not how the limit filter works.  AFAIUI, it's an
> upper limit on how full a chunk can be to be considered for the balance
> operation.  So, balancing with only `-dlimit=100` should actually
> balance all data chunks (but only data chunks, because you haven't asked
> for metadata balancing).

You're thinking of -dusage filter, which is what I mostly use, and is
a percentage value (or a range), whereas the limit filter is a
quantity of block groups, or a range.

-- 
Chris Murphy
