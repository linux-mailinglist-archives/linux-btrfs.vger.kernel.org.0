Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A48023B16F1
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Jun 2021 11:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbhFWJe7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Jun 2021 05:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbhFWJe7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Jun 2021 05:34:59 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2466FC061574
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Jun 2021 02:32:41 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id c138so3491992qkg.5
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Jun 2021 02:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4f80nrKQDuPoIYvaKQ80zP9Banfb25KUfVX4ZAYQmAg=;
        b=rF5XLUCp6VQQjkaKioMRmeA/GQBypI1KUXlfFS9bLxU/w4NBRlcMPNvZGaL6rwgVvB
         HvLj92MFsykekMQGkkn+AoIujuFL5/WJatErnFr4Y2Kr9oc5CI1kpBb35RQFlQdJARlz
         LYZGaVFUPo6/oLoksAPBvN7zhE+OhxK52dcYU6bb68N5p4IVLwSSF8zyZcKtL8cqrCTY
         nn7pD7A48Hp7j+ZwutVxrS2zhVHlrHTxR9cSaSbCD6TlHhyHHehjx+x1OlYUl471HjaD
         miU+Lod2BYZSfFnLB9Q0Load8ahrNzlEuFXNTtrAo63gsWKBojBc9uo+wxowY0BlTuw8
         yyAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4f80nrKQDuPoIYvaKQ80zP9Banfb25KUfVX4ZAYQmAg=;
        b=osbm1ZMSUsGUXPobJYjGYBD1lOJgzzewfjD7q7HPbOC9tG/4UL+4eSqXxYK5+XRjkB
         dgk7d0C7Lr7jGStf17Gi8NySkpju9H7gzLHuOBC2tTsjGJpD6grNvCRBSvSMGRwLS43j
         7dBPh9VVcbGPS2lp67gTm5s0KwRXUTmgS2u5aDyKyWdfF7BIHjXzMmF0p4EKXzNZUddw
         TUqQ5X/3PuI0La8XSPFFYq0GNYqOipatbnWD5hh48ZvefS1B0NiSiW0BSiC1r3leV9T9
         sUGxs6N8teZBYDxG0pWwNtjutdcJOE+Zse6CLWe9HOtHSImA5GCqADv1HdhP6GWCUpmJ
         yT+Q==
X-Gm-Message-State: AOAM533A6tOMunSjjWUyMb18ZivZHqTLeaCOkE9q3gHgqjBN2fJQlQAN
        WGY4d6FTNU7tKFhOfANDuMJS3p+ORgEttbf6hzXjhjr5
X-Google-Smtp-Source: ABdhPJyuzr0aEmbXl95qkdjb8+xDy5+/OHDeLlvuEe4tYE91yqaU+baq3tVtKr8RCtL6qTV1TZT0dmx9Vp0/TZFhosE=
X-Received: by 2002:a25:b903:: with SMTP id x3mr10878453ybj.82.1624440760378;
 Wed, 23 Jun 2021 02:32:40 -0700 (PDT)
MIME-Version: 1.0
References: <2bb832db-3c33-d3ba-d9ae-4ebd44c1c7f3@gmail.com>
 <1b89f8a3-42a4-3c6d-aec8-1b91a7b43713@gmx.com> <CAHw5_hk9Uy-q=9n+TvtiCtLH5A08gVo=G4rUhpuQyZwzuF68dQ@mail.gmail.com>
 <60a9b119-c842-9fea-3fb3-5cd29a8869ef@gmx.com> <CAHw5_hmN3XTYDhRy4jMfV4YN6jcRZsKs-Q_+K-o3fLhC9MXHJA@mail.gmail.com>
 <06661dd5-520b-c1b5-061e-748e695f98a6@suse.com> <CAHw5_hkUhV8OvrdZOWTnQU_ksh3z94+ivskyw_h069HwYhvNXg@mail.gmail.com>
 <CAHw5_hmUda4hO7=sNQNWtSxyyzm7i9MU50nsQkrZRw7fsAW3NA@mail.gmail.com>
 <e12010fe-6881-c01c-f05f-899b8b76c4fd@gmx.com> <CAHw5_hmeUWf0RdqXcFjfSEEeK4+jTb1yxRuRB5JSnK1Avha0JQ@mail.gmail.com>
 <83e8fa57-fc20-bc5b-8a63-3153327961a6@gmx.com> <CAHw5_hm+UX2EHSdZHcMXWMNYxOtccKMQ1qtfbu1gKUm-WZFXYg@mail.gmail.com>
 <CAJCQCtTW0tR-55UkkE=r0ONQucCO7_An2ASOQeBjZiZXtPrLSg@mail.gmail.com>
In-Reply-To: <CAJCQCtTW0tR-55UkkE=r0ONQucCO7_An2ASOQeBjZiZXtPrLSg@mail.gmail.com>
From:   Asif Youssuff <yoasif@gmail.com>
Date:   Wed, 23 Jun 2021 05:32:29 -0400
Message-ID: <CAHw5_hnLSwMBqNxE6pPvau+-9LQoCmWp7fy6vuxtT-UPPLL4Fw@mail.gmail.com>
Subject: Re: Filesystem goes readonly soon after mount, cannot free space or rebalance
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 22, 2021 at 5:33 PM Chris Murphy <lists@colorremedies.com> wrote:
>
> On Tue, Jun 22, 2021 at 12:37 AM Asif Youssuff <yoasif@gmail.com> wrote:
>
> > I went ahead and also created two partitions each on the two new usb
> > disks (for a two of four new partitions) and added them to the btrfs
> > filesystem using "btrfs device add", then removing a snapshot followed
> > by a "btrfs fi sync". The filesystem still goes ro after a while.
>
> Yeah Qu is correct, and I had it wrong. Two devices have enough space
> for a new metadata BG, but no other disks. And it requires four. All
> you need is to add two but it won't even let you add one before it
> goes ro. So it's stuck. Until there is a kernel fix for this, it's
> permanently read-only (unless we're missing some other work around).

Hmm, would this be something that would be fixed in the near term?
Just wondering how long I'd have to leave this as ro.

Happy to continue to try any other ideas of course, but I'd rather not
destroy the fs and start over.

>
>
> > Would mounting as degraded make it possible to add the disks and have
> > it stick?
>
> No, that's even more fragile and you're sure to run into myriad
> degraded raid5 bugs, not least of which are the bogus errors. And it
> won't be obvious which ones are important and which ones are not.
>
>
> --
> Chris Murphy



-- 
Thanks,
Asif
