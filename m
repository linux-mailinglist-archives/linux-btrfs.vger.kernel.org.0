Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D88783B0F73
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Jun 2021 23:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbhFVVf6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Jun 2021 17:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbhFVVf6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Jun 2021 17:35:58 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735F8C061574
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Jun 2021 14:33:40 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id p10-20020a05600c430ab02901df57d735f7so2672203wme.3
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Jun 2021 14:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Qwnh6KJ8kA+JQY3mT9MJ+HvW2MwTtSA4qWYFa3KO1o=;
        b=V06hgjAv975HFw2gKuTB9Djj8GUDZ+49loj12iC5za5WSX3NswIUUg2enAlIgIK+EE
         C6jf+tQf4y71ThHFD7VFLmBqEtOITCbZDpgukFvINmvJ7kmoYP+1XFmvGtndbKH0migr
         +EZndQeiFvrwMKaviI18u2d18V8IGNt/nh+fzQqe3MXxtdYoAslo8SE8diih/iOwI9Kc
         Q8MhnWsETY0ojPlDvur4G3hOyeBnqXuOQyvw7SYLm1HM9vkcawTGwNNJdQXv0tiVCRIb
         JKNWK0SoLQnctCAV2/7WixhzWsKpp8lqTokEuTHL1ulSovyv7Z90mPMxAXNWULpodcbQ
         Rs9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Qwnh6KJ8kA+JQY3mT9MJ+HvW2MwTtSA4qWYFa3KO1o=;
        b=bBGHGeO0iYdpcjBv5JWCOLGmVjiko0cyCiNqErvXXrwqSPh96mOZ4BheIK4z+Jzw14
         ydZaY4azxqfTQbJ81MKapXmhdOZCawn8pTmMQYfxf8HfO8ot8j+KtvBgtaJYfiBytzOd
         0PgrAIvi/DKMltghvp5//qLHESEcZCCFS1caS+tZp3iMISF7dsuip2oV03W5vUOVJANK
         jMOq9RbRtdtq/TWob1PV/FDAIYAkDy+2Hawh+0KbgkvtCBS5BWGFn8MAed3Zxi3kBuud
         L5Lhcn7rzijPEF5McOueCwFrFEIjjjw4O8pvUF/M6dO54kyxVuJbrKSCOdAcpV5NGdET
         BD0g==
X-Gm-Message-State: AOAM531ji9omY9cOL7pr2r5TPmHPE2ZZhqFx68fBGYm8GD1fu/g13WUa
        P781/barZV4hR9MLAmc4BsR5RLKNKbznBF3WS46D6Q==
X-Google-Smtp-Source: ABdhPJy0KIN7W6TpBT9g1HTNM0i6eMKYo7gbYvQ5iKQHBuq9OPqbW3EgE/8eO1dnkX3z8dNSXoU2rxAIVWMipan1HTQ=
X-Received: by 2002:a05:600c:1c87:: with SMTP id k7mr6815888wms.168.1624397618985;
 Tue, 22 Jun 2021 14:33:38 -0700 (PDT)
MIME-Version: 1.0
References: <2bb832db-3c33-d3ba-d9ae-4ebd44c1c7f3@gmail.com>
 <1b89f8a3-42a4-3c6d-aec8-1b91a7b43713@gmx.com> <CAHw5_hk9Uy-q=9n+TvtiCtLH5A08gVo=G4rUhpuQyZwzuF68dQ@mail.gmail.com>
 <60a9b119-c842-9fea-3fb3-5cd29a8869ef@gmx.com> <CAHw5_hmN3XTYDhRy4jMfV4YN6jcRZsKs-Q_+K-o3fLhC9MXHJA@mail.gmail.com>
 <06661dd5-520b-c1b5-061e-748e695f98a6@suse.com> <CAHw5_hkUhV8OvrdZOWTnQU_ksh3z94+ivskyw_h069HwYhvNXg@mail.gmail.com>
 <CAHw5_hmUda4hO7=sNQNWtSxyyzm7i9MU50nsQkrZRw7fsAW3NA@mail.gmail.com>
 <e12010fe-6881-c01c-f05f-899b8b76c4fd@gmx.com> <CAHw5_hmeUWf0RdqXcFjfSEEeK4+jTb1yxRuRB5JSnK1Avha0JQ@mail.gmail.com>
 <83e8fa57-fc20-bc5b-8a63-3153327961a6@gmx.com> <CAHw5_hm+UX2EHSdZHcMXWMNYxOtccKMQ1qtfbu1gKUm-WZFXYg@mail.gmail.com>
In-Reply-To: <CAHw5_hm+UX2EHSdZHcMXWMNYxOtccKMQ1qtfbu1gKUm-WZFXYg@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 22 Jun 2021 15:33:22 -0600
Message-ID: <CAJCQCtTW0tR-55UkkE=r0ONQucCO7_An2ASOQeBjZiZXtPrLSg@mail.gmail.com>
Subject: Re: Filesystem goes readonly soon after mount, cannot free space or rebalance
To:     Asif Youssuff <yoasif@gmail.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 22, 2021 at 12:37 AM Asif Youssuff <yoasif@gmail.com> wrote:

> I went ahead and also created two partitions each on the two new usb
> disks (for a two of four new partitions) and added them to the btrfs
> filesystem using "btrfs device add", then removing a snapshot followed
> by a "btrfs fi sync". The filesystem still goes ro after a while.

Yeah Qu is correct, and I had it wrong. Two devices have enough space
for a new metadata BG, but no other disks. And it requires four. All
you need is to add two but it won't even let you add one before it
goes ro. So it's stuck. Until there is a kernel fix for this, it's
permanently read-only (unless we're missing some other work around).


> Would mounting as degraded make it possible to add the disks and have
> it stick?

No, that's even more fragile and you're sure to run into myriad
degraded raid5 bugs, not least of which are the bogus errors. And it
won't be obvious which ones are important and which ones are not.


-- 
Chris Murphy
