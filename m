Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3DB1E152F
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 May 2020 22:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390118AbgEYUYX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 May 2020 16:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389665AbgEYUYW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 May 2020 16:24:22 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A27EC061A0E
        for <linux-btrfs@vger.kernel.org>; Mon, 25 May 2020 13:24:21 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id r7so1522359wro.1
        for <linux-btrfs@vger.kernel.org>; Mon, 25 May 2020 13:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oFAyvfNNs4hEL0sQW27PIf6PxgPtgMdXIDqVPzTVCqU=;
        b=g1DubMuj/TBcKQampDlKH8A8mMHFF1JfqKruq3855TYgXgYAj1EdF1wyqy/VF2Cxoo
         /Yc9KKmFbVzTuJzNg2/STYR/snHCNQ+wrBF6d60eWpHT8B8FUG6HCDNLPgwQl1AuGWLo
         Bv2TkSMMq1iKM4GGQqCO+w9Fef9uyyR73ihrzNycrgoZUmgZjMgbtLI4Qe9fTnCiF3Qb
         wIime+C3UQeSccYW8hcUVo3i9qbEkPIl9eCjpfBxWNkmf/ARX+JEblmL/BJFasv4HKtD
         W9Ya/Ds2LrKdEPiXtMp650390A9XJr0XXwmOyZiuLJ8yKbUfYkLwyXJEdJG/08Ufsevr
         hNig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oFAyvfNNs4hEL0sQW27PIf6PxgPtgMdXIDqVPzTVCqU=;
        b=PxNHF9Xjs/gRDNLfCt8IQ+eZ32NElRNxOpa+frQM6IfQZkUk7rB4Ba3RetxtNcE+sF
         0+e4AjI7Kdll5sRZHN7g0E7surPlTYL/2alsXq9HEcTQohDlfv6jszyg/x1+yaRYzkYz
         /HeHFuURMsmuF187irP6+5GZ4jGoIL6ddq0LGMwyhad/Mw/0oQo3RbDq8RfW77NXcOrS
         SfX9pQXx05HNFlUA1/W1GLny+m/FLzeOvKXZIfF7410XgFtOXWuJ7ia1WQHyOoDYsTK8
         04XTMg73Y5TnIv4KRvp4klDjQnnT+iVaBI8xcGLVIlepAdmhuTwYQSru5DGrleRPEPOA
         xBaQ==
X-Gm-Message-State: AOAM532aMxr6gwcrTQapkMj88bmVUEhUDbcLcRkoZcdi+rL3rWUs4/ta
        dHo5OedVLD4ahRHdvUzFzRayO3um8ZRLQ89PzrMlR7bAvR8=
X-Google-Smtp-Source: ABdhPJzsE8orAOzcM7Yv8q2GEQ4x18HjTt+NKcO8p48oled3DBLMdsS5JyGrGjyh2iNRsGP4QAzdyGKE8Mt3jvCJHQg=
X-Received: by 2002:a5d:5092:: with SMTP id a18mr16597150wrt.42.1590438260137;
 Mon, 25 May 2020 13:24:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200524213059.GI23519@merlins.org> <CAJCQCtTWkRijC51qny+gLqFO=z-Jek4mbKN0O6udLKzzeNe_vw@mail.gmail.com>
 <20200525201620.GA19850@merlins.org>
In-Reply-To: <20200525201620.GA19850@merlins.org>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 25 May 2020 14:24:03 -0600
Message-ID: <CAJCQCtSqdJnVCPQEEeE1W3ux48tWerQuu-2_rySUdYM7GZJR9Q@mail.gmail.com>
Subject: Re: 5.5 kernel and btrfs-progs v5.6 create and cannot fix 'root
 204162 inode 14058737 errors 1000, some csum missing'
To:     Marc MERLIN <marc@merlins.org>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Su Yue <Damenly_Su@gmx.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Su Yue <suy.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 25, 2020 at 2:16 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Mon, May 25, 2020 at 10:37:58AM -0600, Chris Murphy wrote:
> > On Sun, May 24, 2020 at 3:31 PM Marc MERLIN <marc@merlins.org> wrote:
> > >
> > > My data is fine, it's double backed up and the filesystem is still mountable without issues.
> > > But I had an error that broke btrfs send, and after fixing it with repair, I'm stuck with thses 'csum missing'
> >
> > I'm not following the sequence of events. The send|receive failed? Did
> > you try deleting the failed received snapshot?
>
> btrfs send failed because there was an error on the source filesystem.
> Then I found this in the logs
> BTRFS error (device dm-0): did not find backref in send_root.  inode=14058737, offset=0, disk_byte=2694234112 found extent=2694234112
>
> then I ran the btrfs check repair, with and without lowmem.
> They fixed some things, but leave me


OK I didn't understand that the problem is with only the sending file
system, not the receive file system. And also it sounds like the send
did not cause the problem, but it's somehow a pre-existing problem
that --repair isn't completely fixing up, or maybe is making different
(or worse).

So I guess the real question is what happened to this file system
before the send, that got it into this weird state.


>
> > Is no-holes enabled on either file system?
>
> Not intentionally. How do I check?

btrfs insp dump-s

It's not yet the default and can't be inadvertently enabled so chances
are it's the original holes implementation.

-- 
Chris Murphy
