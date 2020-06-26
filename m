Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF24E20B60E
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jun 2020 18:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgFZQlF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Jun 2020 12:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgFZQlE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Jun 2020 12:41:04 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D308FC03E979
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jun 2020 09:41:03 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id q5so10106217wru.6
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jun 2020 09:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=o5pv9IrsZiTbS/YeVGBDpboEkAl5e9XF6h1yDiP+IZo=;
        b=fK78LtuZdmDKtKO/Zsd/hNFnOaIp/alTeiSufjTrRAucRwlwu7FltKtrNvPHrVauHL
         Gro8i/9JxJCe1tuPtle2+3IzGW1/s3ysGQ7QZ3GaIhbXGWlSt+DoEZAZlG0D/inSM3w8
         Qo15maUbhp47YL9uSJlhr4riYRNlRMV6dmn3bhhqtv2yXJFFIspFeAHDY2pr7Phuc3Vl
         RcJrrTfL4BIkpHQYS4qa3nesljtW4PueFzPu2VOB2I5FUFAIcNnnSL3ntZOg6gN5vqQO
         tgDxNotf4yVX/ZKJaFlrFNFUSewuREJTNzDr44FY8jSVyErgaYSXDiSQ3yA4xktwf5kH
         k+Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=o5pv9IrsZiTbS/YeVGBDpboEkAl5e9XF6h1yDiP+IZo=;
        b=m5WGW78wJ/OuG+zJREHXKGJEefMMAIhsn9vBibpmEyjox3XPtWYBs4yE4CHdrK5PrX
         /90vyQks74VqFAhOd9xwQf/cGW6DGNqsIqweg8B6ZOzb5z6YtX6FHsMfTqi3m+vCqcAT
         kgRl/P0k2Oe0so604oJUs0bUvlXmnxGgjKKyJKC5o1fMn1+j97HcoftWLY9IIMcJloYc
         J1t/a07yfkQxug5gSai8B5U6W5mCJBQgRAV0YIEQNiLC6X4bby5P0hnPNwFxEkLUN2/H
         b8myPPEa5MG8VkEiU+580n5jHjwYnGOaowxjQMy1T7dueHRcsN8zx+deCCrZgiwBdRWx
         HIbQ==
X-Gm-Message-State: AOAM531WJsTdfffiN/aD2EcJHFqlhkxHD8DduFW/ISvsohidVY0a0/oi
        kJbtaHFS5rs2cvZsvSDDQP8Y6b0nN2XUBqV7TD3rpQ==
X-Google-Smtp-Source: ABdhPJzZr9oHfIyTuEjPU1VI60zLPHQAQ5rdmHZcS/c6/Omq5Q0SOWEUyIRPtJRjKEauuctLrJMiejAX/orCMNm6OA8=
X-Received: by 2002:adf:e944:: with SMTP id m4mr4729521wrn.252.1593189662591;
 Fri, 26 Jun 2020 09:41:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200621054240.GA25387@tik.uni-stuttgart.de> <CAJCQCtSbCid6OzvjK9fxXZosS_PAk2Lr7=VTpNijuuZXmRVVEg@mail.gmail.com>
 <20200621235202.GA16871@tik.uni-stuttgart.de> <CAJCQCtQmrc5m=H6d6xZiGvuzRrxBhf=wgf8bAMXZ_4p8F3AJFw@mail.gmail.com>
 <20200622000611.GB16871@tik.uni-stuttgart.de> <CAJCQCtQ8GFAdg2HJY_HqDgW8WAp5L1GoLbKqUN2mZ7s_kS-8XA@mail.gmail.com>
 <20200622140234.GA4512@tik.uni-stuttgart.de> <20200622142319.GG27795@twin.jikos.cz>
 <2E6403C5-072D-4E71-8501-6D90FB539C15@fb.com> <CAAKzf7=gQCMCECtnFwry8+LzuVCkkfeYX6VsAUcrnONtyaF18A@mail.gmail.com>
 <650BA0CA-449A-48DD-9E0D-A824B5D41904@fb.com>
In-Reply-To: <650BA0CA-449A-48DD-9E0D-A824B5D41904@fb.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Fri, 26 Jun 2020 10:40:46 -0600
Message-ID: <CAJCQCtQQJkwB-Yt+ogQUXSZLVxNzTWw0voorALSwfKLXBz7pHQ@mail.gmail.com>
Subject: Re: weekly fstrim (still) necessary?
To:     Chris Mason <clm@fb.com>
Cc:     Tim Cuthbertson <ratcheer@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jun 26, 2020 at 9:40 AM Chris Mason <clm@fb.com> wrote:
>
> On 26 Jun 2020, at 8:08, Tim Cuthbertson wrote:
>
> > ---------- Forwarded message ---------
> > From: Chris Mason <clm@fb.com>
> > Date: Mon, Jun 22, 2020 at 10:57 AM
> > Subject: Re: weekly fstrim (still) necessary?
> > To: David Sterba <dsterba@suse.cz>
> > Cc: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
> >
> >
> > On 22 Jun 2020, at 10:23, David Sterba wrote:
> >
> >> On Mon, Jun 22, 2020 at 04:02:34PM +0200, Ulli Horlacher wrote:
> >>> On Sun 2020-06-21 (18:57), Chris Murphy wrote:
> >>>
> >>>>>> You need to check fstrim.timer, which in turn triggers
> >>>>>> fstrim.service.
> >>>>>
> >>>>> root@fex:~# cat /lib/systemd/system/fstrim.timer
> >>>>>
> >>>>> root@fex:~# cat /lib/systemd/system/fstrim.service
> >>>
> >>>> I'm familiar with the contents of the files. Do you have a
> >>>> question?
> >>>
> >>>
> >>> You have deleted my question, it have asked:
> >>>
> >>> This means: an extra fstrim (via btrfsmaintenance script, etc) is
> >>> unnecessary?
> >>
> >> You need only one service, either from the fstrim or from
> >> btrfsmaintenance.
> >
> > Dennis=E2=80=99s async discard features are working much better here th=
an
> > either periodic trims or the traditional mount -o discard.  I=E2=80=99d
> > suggest moving to mount -o discard=3Dasync instead.
> >
> > -chris
> >
> > Apparently, discard=3Dasync is still unsafe on Samsung SSDs, at least
> > older models. I enabled it on my 850 Pro, and within two days I was
> > getting uncorrectable errors (for csums). Scrub showed 12,936
> > uncorrectable errors.
> >
> > While I was trying to recover, a long SMART analysis showed the actual
> > drive to have no errors.
> >
> > Then, the first recovery attempt failed. I had deleted and recreated
> > the partition. When I was copying the backup snapshots back to the
> > SSD, uncorrectable errors showed up, again (4,119 of them after
> > copying one snapshot). I then overwrote the partition with all zeros,
> > and when I copied the snapshots back to it, there were no errors.
> > After recovering my filesystem, scrub still showed no errors. So, alls
> > well that ends well, I guess.
>
> We=E2=80=99re using this on a pretty wide variety of hardware, so I=E2=80=
=99m
> surprised to hear this.  Are you able to reproduce the problem?  Is a
> periodic fstrim still happening?
>

I'm curious if there's a possibility of confusion/conflict between
scheduled fstrim combined with either discard or discard=3Dasync.

As in, if it's a big enough concern, maybe the scheduled fstrim needs
to get smarter and parse mount options, and automatically deconflict.

--=20
Chris Murphy
