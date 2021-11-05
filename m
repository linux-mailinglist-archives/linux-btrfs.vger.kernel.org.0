Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1210344667F
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 16:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbhKEPyx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 11:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbhKEPyw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 11:54:52 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C10C061714
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Nov 2021 08:52:12 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id d10so23927702ybe.3
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Nov 2021 08:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lDMQTg5MfIujCVrbwa+r7BlGdFxhT8NwinrBP1NzNwg=;
        b=Mgowi0I7S6bMvxrXhoDTZpXjbxfY96ClSUyej+6WCsxBc+IgNCQndRiPLMvQ/pllah
         /1+ozHC8LPnX+0eM5rKgeRBDEeDvY0wZ2bFtfGTx3DOVwSyKVOg06Gdmb/F/1dYPlFNB
         Mgm9rfWcgLF+NHEq7UsRzq//W9NdQSVy04UlJMSk+lP/pV8jCsIvKt8PMuvLR+qESx8Q
         ivbUz81aRWFBhNMSKzFaiYFtXSRLIrdA8opJg2ymfcJPqu7JHfMDPoAMcT/wyTvzyC3G
         7S2hTPISZSTBUJSYPr0vNLxytpnElc4SKzIaHe3swfUQdo2Kk1MQ9KBcSnmxfCefW8By
         ASSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lDMQTg5MfIujCVrbwa+r7BlGdFxhT8NwinrBP1NzNwg=;
        b=HMz0H+mibonJvVqE02Bs4d3kTXixmArUvWmden5J8rWF6Grye3W0qgQnOr2HfF0Wfw
         hNPjvWkA4ZadoAJxF/CSeaCIbguq0uqP8DaQ/jgQpQo5l0UYXGyM6vvDAKog2pvKSSfl
         rRc7bGFgNVfaz4aVFi0VqLc9hYb+f1Rt9JC8u0DMDFZJjdHQvWisuCByxGv3E81NAXKV
         YHC/7mW7bH4B04Ctmf9yE1RO0NNVDPHAVGWntqvAz5L7ETc18mLlo+Jg22/QiueGtQ+7
         BDlJFiYCOQ8vdj59s+dPAR9DU1lmK7vQBjh6cEn6S7aDbaijssJOslMVA/1Jy/+x8LOD
         jwzA==
X-Gm-Message-State: AOAM5300w/RMr8m9rik7jl3sraKQmh6U6PeOxeD/5z5T3RPz6Fk4oweB
        in/P9j3Jk54y/XZGaeUwStJa3v0tfnXRE8St6Sf799992dfCaqoc
X-Google-Smtp-Source: ABdhPJztszdhZ5A0OWuh9345v28ayfBHu3bLLVsS/QN8SCrnSdB3goNzQuiByD54lwtWh/8MSEaT/eJzzEULz6Hej8A=
X-Received: by 2002:a25:4d83:: with SMTP id a125mr63793245ybb.277.1636127532084;
 Fri, 05 Nov 2021 08:52:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtS7YqzmWGta7uCAv-cOMuhiFG1M-idrO4_VotWi_Tpu7g@mail.gmail.com>
 <1f6eacb5-5e60-8f4b-e993-38f1917d4cc2@suse.com>
In-Reply-To: <1f6eacb5-5e60-8f4b-e993-38f1917d4cc2@suse.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Fri, 5 Nov 2021 11:51:56 -0400
Message-ID: <CAJCQCtSKAt3BQ74OCZb+AMmk++dJM_yuQOhrTPfSb_Cz2ve8og@mail.gmail.com>
Subject: Re: Moby/Docker gradually exhausts disk space on BTRFS
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 4, 2021 at 8:22 AM Nikolay Borisov <nborisov@suse.com> wrote:
>
>
>
> On 2.11.21 =D0=B3. 20:44, Chris Murphy wrote:
> > Docker gradually exhausts disk space on BTRFS #27653
> > https://github.com/moby/moby/issues/27653
> >
> > This bug goes back to 2016 and could really use some attention to
> > figure out what's going on. I'm not sure even whose bug it is. It
> > could be docker itself, or the btrfs "graph" driver that docker uses,
> > or if it's a (btrfs) kernel bug.
> >
> > It could be there's more than one bug.
>
> I don't think there is a bug rather  people not being aware of how
> docker does pruning. Just deleting a container doesn't free up the space
> so if you never run prune -a space taken by images won't be freed up. I
> did a bunch of tests today with starting a container, stopping, deleting
> it, pruning images and everything works as expected.

Thanks Nikolay,

I wonder if this behavior is unique to the btrfs graphdriver though?
i.e. I guess we need to do the same set of tests with btrfs
graphdriver, reset, and then do it again with the overlay2 graphdriver
and see if there's a meaningful difference.



--=20
Chris Murphy
