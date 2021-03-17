Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64B3B33EC1F
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Mar 2021 10:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbhCQJCi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Mar 2021 05:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbhCQJCZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Mar 2021 05:02:25 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E11C06174A
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Mar 2021 02:02:25 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id k2so40201375ioh.5
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Mar 2021 02:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=S3nulBGtr3o1c+oLK910N4Y4nGt7EbRVwe94p5724Xk=;
        b=Qv3bV9cUm4p8LzNpU3SVN1jUhlmK6w2FrYm/iljxZNQ1gftm0pIwRSkpk50/8kP84R
         lhBpYO2m16n1jsLIWa6Ds8HLoBMfjPYbNOAxuDkOinIIYyw3KSQEp1YpQvHRZwX/Myqg
         +5mXJF6D5ZLDZNuwhG9uB3ktuOkHPg0WcEaXxOTwAemIU9dCfJ+0ovc4vwEInfb6bxAS
         +MgxRZd/Fni/Z1AQaSnE2pnTlbhkp8Jds8Bz6RWNRvSRoNOaZj4L/HPpQ2sl4Sysrond
         +bJO+PnE5E5BK8ZZj6PU5QfOr5Pynjax8w680G/4QjSEjQow/DULqv4wFi5RwOUBGNBD
         5veQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=S3nulBGtr3o1c+oLK910N4Y4nGt7EbRVwe94p5724Xk=;
        b=mhOxxjSIYRgrshZe4kTqn9oYKXdwSRpvWTKZlPr3HWOYz6/so+JJEyCpQQQH9pTf1U
         czrHk3q68qSGQAXq2flDReWlqlYkVCAtRcbRwCqneav0QETg4gVVEro3csWHGcc2/XHR
         UrKAmYVuJEuhkx9zmDv0AxtWkemLrcCW4WlWkTF8tW/CHoFnhM9KzCMDGvkECk+b7cbi
         ff6sbq0RbjcX2ZENnaikKBsdDU6q0X7T8Y5QM/sevg2ZNy9JTkCoGlQynF2T1r1K24MU
         dMlvKCirMzUIFSXzjbBjEnph/+EnPaRF0e92gDITp3suweKDp2rndYI1U2gMc4YNIgh9
         w4uQ==
X-Gm-Message-State: AOAM531Z+/qsKImaFcxb5PI7s8VCPAQBw8Nd42r4sbBe8aOfN0bc8QCg
        IsiiT1xBL4GRCvW9FsSfJrc++MbvVGBDKjoHFN4=
X-Google-Smtp-Source: ABdhPJwQPAf4z8NnG3nWqQ6Il/P6IN2qcnPFCv68Zd0aPkidxGffeftrH+vbDo4t3bhBeajevKDp3taiqWLXxdy5hcw=
X-Received: by 2002:a05:6638:1508:: with SMTP id b8mr2011663jat.134.1615971744866;
 Wed, 17 Mar 2021 02:02:24 -0700 (PDT)
MIME-Version: 1.0
References: <CALS+qHMo-XVzXKEfd44E6BG7TPnWKT+r2m7p1wFtFs5XjQApEA@mail.gmail.com>
 <2411012e-0b50-ff76-2710-5fa55b8487eb@gmx.com> <CAJCQCtQ7o1_Kkxf3Gh8bM+r4-e3tXuZsFM1mHUQakRvJUA9mqA@mail.gmail.com>
In-Reply-To: <CAJCQCtQ7o1_Kkxf3Gh8bM+r4-e3tXuZsFM1mHUQakRvJUA9mqA@mail.gmail.com>
From:   Sebastian Roller <sebastian.roller@gmail.com>
Date:   Wed, 17 Mar 2021 10:01:47 +0100
Message-ID: <CALS+qHNq1YJr-sYfeGUpr=zjTJjUe3cC6PTwUuWKhEMni3pmbA@mail.gmail.com>
Subject: Re: All files are damaged after btrfs restore
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Am Mi., 17. M=C3=A4rz 2021 um 03:59 Uhr schrieb Chris Murphy
<lists@colorremedies.com>:
>
> On Tue, Mar 16, 2021 at 7:39 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> > > Using that restore I was able to restore approx. 7 TB of the
> > > originally stored 22 TB under that directory.
> > > Unfortunately nearly all the files are damaged. Small text files are
> > > still OK. But every larger binary file is useless.
> > > Is there any possibility to fix the filesystem in a way, that I get
> > > the data less damaged?
> >
> >  From the result, it looks like the on-disk data get (partially) wiped =
out.
> > I doubt if it's just simple controller failure, but more likely
> > something not really reaching disk or something more weird.
>
> Hey Qu, thanks for the reply.
>
> So it's not clear until further downthread that it's bcache in
> writeback mode with an SSD that failed. And I've probably
> underestimated the significance of how much data (in this case both
> Btrfs metadata and user data) and for how long it can stay *only* on
> the SSD with this policy.

Sorry Chris. I might have expressed this wrongly. But the
btrfs-filesystem was never on bcache. On bcache was a xfs-filesystem
that I backed up (rsynced) to the btrfs-filesystem when everything
went wrong. And I quickly gave up hope for that xfs afterwards, due to
the (lost) cached data of the directory-structure. That's why I'm
focusing on getting the backup on the btrfs-filesystem back.
But the possibility that some data is really wiped out or as Qu said,
that something is not reaching the disk gives me a direction to
investigate further. Maybe the raid-enclosure or the FC got damaged (I
ruled that out in the beginning). Eventually a failed raid-rebuild or
so. That would explain why so much data is missing.
Thank you.

Sebastian
