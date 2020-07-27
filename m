Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99B4522F8F6
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Jul 2020 21:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbgG0TXn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Jul 2020 15:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbgG0TXm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Jul 2020 15:23:42 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FACBC061794
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Jul 2020 12:23:42 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id r12so15946443wrj.13
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Jul 2020 12:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CoNoIh+Li7/x2v71DYkUEzPq/qWW36nmWw/PEfKbGig=;
        b=FuiLTHMf/CS5Vtv4pIU1xPjgkU9g5VGnm8A0kGdJj/4uPuklF9GMAEgB8BqiWV/oFo
         vz107gqvO56y3kiCuwb+/elbfdz3PxN1+AEeIOmeDbR4sJ4I4b0kiut0iwN2u64xfOzl
         njjdtqtp2N1Eu9XWgMGrScN1BRb+feSyVxMCzs4uOdH/MdDxyX+ytpxXTBZXwUnpJPRE
         XDppLxL0O4ZYnGlETfmHdC80miJcMlIApWy9AwvKkWMahyVbWCqeg56D8D+iYw2iHnhI
         7Ca5aE+uKBNYqQPJpuVKclDGu6yxq74Oa6q3fur+XKU5bTi2+cuQN4QzAiHxVcRA5770
         Eyjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CoNoIh+Li7/x2v71DYkUEzPq/qWW36nmWw/PEfKbGig=;
        b=glmJirBf1qG6nQwBOIH52ul2jPAV8GWEJFh5Un6rxEwPBiN4qz2aBwQWBJ0rhKwR5X
         8xAtBHGB5MivoIcy4JxWIqAry4roN4DStx0udvKQnIPCazCTXKgULevPvxRCp+NXF3XY
         b5Ij6V2bPnwYUjFbYIPorB9iwwHPCBxDJsLHnfD/xQ193vu/VG2G4DmXtciuBkhFJoUE
         U99pfrJ8VxZq186VKoKmYNk48XlJnZGe4MYhpCRBlXSM7rkRpDbbvl9zZwdYAYLGknxx
         qjvlk7FklJWMQ9MQY5E+tt6m8xeUD00bmRcC+ONIzTo4RF0YYRswp37ypm1Rv45h0aWf
         svtw==
X-Gm-Message-State: AOAM5318kMPKD7RXduyfp34Exm9pUpKT6aJeV3I26cFNUQu78OLcDfRw
        b/ZpQ4n2BoidbLPqok+r3FvM3xTWzGgPDorIF+ppKA==
X-Google-Smtp-Source: ABdhPJwaVUeXoWvlKq9ED1Pd4ywPPG4/zFxSnPT33Oaq3dakpiGnoS3AhUBrLBc/npOfPDIc2AVnzw8bHU0mZqSruWg=
X-Received: by 2002:adf:a19e:: with SMTP id u30mr21252304wru.274.1595877821220;
 Mon, 27 Jul 2020 12:23:41 -0700 (PDT)
MIME-Version: 1.0
References: <2523ce77-31a3-ecec-f36d-8d74132eae02@knorrie.org>
 <f3cba5f0-8cc4-a521-3bba-2c02ff6c93a2@gmx.com> <ae50b6a5-0f1e-282e-61d0-4ff37372a3ca@knorrie.org>
In-Reply-To: <ae50b6a5-0f1e-282e-61d0-4ff37372a3ca@knorrie.org>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 27 Jul 2020 13:23:24 -0600
Message-ID: <CAJCQCtTMVSzm6KrPamaw6dnLO2amcHMrQNJ5z8GWD9Wcn+XYuA@mail.gmail.com>
Subject: Re: Debugging abysmal write performance with 100% cpu kworker/u16:X+flush-btrfs-2
To:     Hans van Kranenburg <hans@knorrie.org>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 27, 2020 at 11:17 AM Hans van Kranenburg <hans@knorrie.org> wrote:
>
> https://syrinx.knorrie.org/~knorrie/btrfs/keep/2020-07-25-find_free_extent.txt
>
> From the timestamps you can see how long this takes. It's not much that
> gets done per second.
>
> The spin lock part must be spin_lock(&space_info->lock) because that's
> the only one in find_free_extent.
>
> So, what I think is that, like I mentioned on saturday already,
> find_free_extent is probably doing things in a really inefficient way,
> scanning around for a small single free space gap all the time in a
> really expensive way, and doing that over again for each tiny metadata
> block or file that needs to be placed somewhere (also notice the
> empty_size=0), instead of just throwing all of it on disk after each
> other, when it's otherwise slowing down everyone.

What are the latencies for the iscsi device while this is happening?
Does your trace have the ability to distinguish between inefficiency
in find_free_extent versus waiting on IO latency?

However, this hypothesis could be tested by completely balancing all
metadata block groups, then trying to reproduce this workload. If it's
really this expensive to do metadata insertions, eliminating the need
for insertions should show up as a remarkable performance improvement
that degrades as metadata block groups become fragmented again.


> What I *can* try is switch to the ssd_spread option, to force it to do
> much more yolo allocation, but I'm afraid this will result in a sudden
> blast of metadata block groups getting allocated. Or, maybe try it for a
> minute or so and compare the trace pipe output...

OK or this.


-- 
Chris Murphy
