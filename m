Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A49143CC068
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Jul 2021 02:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbhGQBA7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Jul 2021 21:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbhGQBA7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Jul 2021 21:00:59 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA9DC06175F
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Jul 2021 17:58:02 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id s23so13108196oij.0
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Jul 2021 17:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9noMsw/+F9OxT2etIKN7oDRObpI+wPiNOkOTcpfs9Oo=;
        b=TolBu8DyZTR3rNaUdyk2JS8Cbj4N7d7JmixNaCLvHjVGM4jXidZ7IH/mGJj8/Cc0Mm
         g9IZf4gJxOdSttpConNVAxmkmdXa8xBMjQW4Xk/92o1I2yEsCA4Nt39SglQfE9PDWk79
         Bld4oWioMz/b0x5nHJRhzNiNaQbqGlKTzGV6Af95oKo0va4wJxm3kOspdA4NnLBINknG
         8CQyf6SiPYoOsWaJxAyyYtnLrqX9C8ST+WI0zfN9bBpdw6ubbmzdHgOn2uTce0+hgLSS
         Y3sE8EMGstsC3lQ5UVbSfSG4q+nedIxtkP6Siq6x7HH4k2rWfVgSPjYUltRsYSNxJ8ih
         4vhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9noMsw/+F9OxT2etIKN7oDRObpI+wPiNOkOTcpfs9Oo=;
        b=Rm+HUY2fK59fEF6Ch9IUHkYc4q1jR/uGi8yZMSbuke4o0CkyZmnum3gkV9BfFxwoTc
         B+JY0fYOTrMyHl3JxPMtFpdLmsb0lnwHQY95HPZpdp4FyTm7tN3zqzGO6R0m0RqmCTDe
         JuYg+LBTY0lgx/iK8k+EIUdjy6Y3zl/Qz+/DL5H9kx/4uPM41vNSh3WokmE1rbhfToYL
         k/QnAOS/Jlnp0eeezDnm6o1OrqcwKTSF8AaeZSDr35VCabhoyP0AbUuC+mpLieceIRB6
         Od86h3hGCf8dBFYj0RvPgrYzyoJBmn8qn35S9+eOpq6JBCFEK8t0+0yVCXjc4GiT1+nE
         VR8w==
X-Gm-Message-State: AOAM533dV/LCuEJSMCHlDWmINcCc0GNlyvvWK0/gM3hIruE367+8XRh/
        FsbAxqP+UDbQg/ojkTWZkBVvQoooB1LFZ/p6K+I=
X-Google-Smtp-Source: ABdhPJxLw3kKLdUogRFGtw+y3jfN7u5v2fRtqGiwh4YG+MKIGiPjOhJgc70FufMUXmTfHQwgW+ForSGDBV63YUxproA=
X-Received: by 2002:aca:47d6:: with SMTP id u205mr9954330oia.44.1626483481798;
 Fri, 16 Jul 2021 17:58:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAGdWbB6qxBtVc1XtSF_wOR3NyR9nGpr5_Nc5RCLGT5NK=C4iRA@mail.gmail.com>
 <3be8bba9-60cd-2cce-a05d-6c24b8895f3f@gmx.com> <CAGdWbB44nH7dgdP3qO_bFYZwbkrW37OwFEVTE2Bn+rn4d7zWiQ@mail.gmail.com>
 <43e7dc04-c862-fff1-45af-fd779206d71c@gmx.com> <CAGdWbB7Q98tSbPgHUBF+yjqYRBPZ-a42hd=xLwMZUMO46gfd0A@mail.gmail.com>
 <CAGdWbB47rKnLoSBZ7Ez+inkeKRgE+SbOAp5QEpB=VWfM_5AmRA@mail.gmail.com>
 <520a696d-d747-ef86-4560-0ec25897e0e1@suse.com> <CAGdWbB6CrFc319fwRwmkd=zrVE4jabF0GTpqZd5Jjzx2RcAo9Q@mail.gmail.com>
 <e4cc8998-fc9e-4ef3-3a49-0f6d98960a75@gmx.com> <CAGdWbB6Y0p3dc6+00eTnf1XSS1rUMbPUckQabi6VJQXdjRt2jg@mail.gmail.com>
 <88005f9b-d596-f2f9-21f0-97fc7be4c662@gmx.com> <CAGdWbB59w+5=3AoKU0uRHHkA1zeya0cRhqRn8sDYpea+hZOunA@mail.gmail.com>
 <e42fcd8e-23d4-ee98-aab6-2210e408ad3f@gmx.com> <CAGdWbB7z2Q8hCFx_VriHaV1Ve1Yg7P38Rm63hMS6QxbVR=V-jQ@mail.gmail.com>
 <6982c092-22dc-d145-edea-2d33e1a0dced@gmx.com>
In-Reply-To: <6982c092-22dc-d145-edea-2d33e1a0dced@gmx.com>
From:   Dave T <davestechshop@gmail.com>
Date:   Fri, 16 Jul 2021 20:57:50 -0400
Message-ID: <CAGdWbB7XqoJaVsdbG7VkvSj78hVPt-HnZxOw_nvX7GaTziaiwg@mail.gmail.com>
Subject: Re: bad file extent, some csum missing - how to check that restored
 volumes are error-free?
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> But before that, would you mind to run "btrfs check" again on the fs to
> see if it reports any error?

> I'm interested to see the result though.

First I will send you the full output of the command I ran:
btrfs check --repair --init-csum-tree /dev/mapper/xyz
It's a lot of output - around 50MB before I zip it up.
How about if I send that to you as an attachment and mail it directly
to you, not the list?

Next step: I have remounted the old fs and I'm going to run a scrub on it.

Then I will unmount it and run btrfs check again and send you the
output. Again, I'll send it to you privately, OK?
