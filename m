Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A21261C8192
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 May 2020 07:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbgEGFgW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 May 2020 01:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725809AbgEGFgU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 7 May 2020 01:36:20 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33B5C061A0F
        for <linux-btrfs@vger.kernel.org>; Wed,  6 May 2020 22:36:19 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id k1so4759750wrx.4
        for <linux-btrfs@vger.kernel.org>; Wed, 06 May 2020 22:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bhB0Mqhh6oUN2Avv+yE/q7bDMqE9FmD1x1EZNLTinP8=;
        b=V0U54QE+q3dfdNAyVVO3PbFPv7Ud/o5Lj+afsSk5Oz9O/A/5JH+2c2OfAxI1gmy+ym
         Ag2m1R6H+HCWxppW2JrNBMiKgaSmNCKgoLIeU4BLbeYSe1K7juajn0KP/jgc+TGEeo9q
         XPQJDwb6ahNamx+csqcj1T3YFAQ7jZdZM3YTm51AwWguerEyk+Az7lhCgurlWQnOuCfk
         t+uxBlC9ERSq+L7kYE78cU1Vs7dGXKOhC6na/1gXwm0zI9YOlHpTVk5v6RC9EiQ2OlN8
         vDU1EUQtiElEVX3D4MprftWLmXh/4EUOITu94hjYDAVI5iHzrFLyISUUn4S50oDMPT0f
         mWNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bhB0Mqhh6oUN2Avv+yE/q7bDMqE9FmD1x1EZNLTinP8=;
        b=oCEbEq+VxeTEt/s5kV/zrMoVdSGJSbXyY8oVFtlb3vBPTZ1GCLsKkTGKVdZZocjW8B
         +ae+ITLxQ5QDuBeaXsQQUcu576oH8mdTafxzy+UybLwc+cPt7bBXE1wBegWihawsvP05
         YU9jsZLpOP/HFP9bBMnuP/Dsa+z0VkGij1md+woAPxkMmjv6SvwfV72dYiF3nh++gC5b
         JJWCKBoYsXEqM6vC0amqoRO4L97tYtmKpnTNMvoOf0uA3eS72MLeDfsBZVvRuOs6xkLU
         fui99EzgkaxRcDsE/gtlVF25HNgGeFEa0F9ojdOQn7veFC/+mes/PBKKZKNZZAWJdDdA
         cT3g==
X-Gm-Message-State: AGi0PuYxs30EMvR6Qhn4ih23u3jQzcg4WKT0O2E0ZkMWS9BHurCVJy7t
        06c4W5eLmtYsDUw5SW68GVpqNGXPZEPQ1klNQC+HpawEJak7LA==
X-Google-Smtp-Source: APiQypK37UkjjfJEDNrS1hXV5AAe9nuo7trz+8UldHiMLg/I5cMmKiSluXM3jeuA3eaFRtP+ZIS5LkJo9khTytkMyGQ=
X-Received: by 2002:adf:f38b:: with SMTP id m11mr13001032wro.65.1588829778344;
 Wed, 06 May 2020 22:36:18 -0700 (PDT)
MIME-Version: 1.0
References: <0d1cceb6-9295-1bdf-c427-60ba9b1ef0b3@sericyb.com.au>
 <fe7f6b83-aa2c-898e-648d-a8d86f5fd4d5@cobb.uk.net> <76dbd6a1-bddc-9a01-53db-bf3ba9fc8787@sericyb.com.au>
 <CAJCQCtSiEKi=ep-uh3fPVpKp3a8igTdTEm6i7cdPPkfHoDBA_g@mail.gmail.com>
 <9b763f5f-3e42-c26d-296c-e7a7d9cde036@sericyb.com.au> <CAJCQCtTorye5PTcH6crVYES4eAwVphhx3Au6xd7tijef1HU8uA@mail.gmail.com>
In-Reply-To: <CAJCQCtTorye5PTcH6crVYES4eAwVphhx3Au6xd7tijef1HU8uA@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 6 May 2020 23:36:02 -0600
Message-ID: <CAJCQCtRK+jEMVMz1QPCJCYqCciaaMZ5W+STabrdAQ5RyzWHhGA@mail.gmail.com>
Subject: Re: btrfs-progs reports nonsense scrub status
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Andrew Pam <andrew@sericyb.com.au>,
        Graham Cobb <g.btrfs@cobb.uk.net>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 6, 2020 at 11:10 PM Chris Murphy <lists@colorremedies.com> wrote:
>
> On Wed, May 6, 2020 at 7:11 PM Andrew Pam <andrew@sericyb.com.au> wrote:
> >
> > > $ sudo btrfs fi us /mp/
> >
> > Overall:
> >     Device size:                  10.92TiB
> >     Device allocated:              7.32TiB
> >     Device unallocated:            3.59TiB
> >     Device missing:                  0.00B
> >     Used:                          7.31TiB
>
>
> Bytes to scrub should be 7.31TB...
>
>
> > $ sudo btrfs scrub status -d /home
> > UUID:             85069ce9-be06-4c92-b8c1-8a0f685e43c6
> > scrub device /dev/sda (id 1) status
> > Scrub started:    Mon May  4 04:36:54 2020
> > Status:           running
> > Duration:         18:06:28
> > Time left:        31009959:50:08
> > ETA:              Fri Dec 13 03:58:24 5557
> > Total to scrub:   3.66TiB
> > Bytes scrubbed:   9.80TiB
>
>
> So two bugs. Total to scrub is wrong. And scrubbed bytes is bigger
> than both the reported total to scrub and the correct total that
> should be scrubbed.
>
> Three bugs, the time is goofy. This sounds familiar. Maybe just
> upgrade your btrfs-progs.

This was fixed in 5.2.1. I'm not sure why you're seeing this.

commit 96ed8e801fa2fc2d8a99e757566293c05572ebe1
Author: Grzegorz Kowal <grzegorz@amuncode.org>
Date:   Sun Jul 7 14:58:56 2019 -0300

    btrfs-progs: scrub: fix ETA calculation


What I would do is cancel the scrub. And then delete the applicable
file in /var/lib/btrfs, which is the file that keeps track of the
scrub. Then do 'btrfs scrub status' on that file system and it should
say there are no stats, but it'd be interesting to know if Total to
Scrub is sane. You can also start another scrub, and then again check
status and see if it's still sane or not. If not I'd cancel it and
keep troubleshooting.

I was recently on btrfs-progs 5.4.1 and didn't see this behavior
myself on a raid1 volume.



-- 
Chris Murphy
