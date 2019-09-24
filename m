Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA1F7BCA33
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2019 16:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437260AbfIXO2K (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Sep 2019 10:28:10 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41263 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394254AbfIXO2K (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Sep 2019 10:28:10 -0400
Received: by mail-qk1-f193.google.com with SMTP id p10so1963455qkg.8
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Sep 2019 07:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VLMte1ZrK21LBLWW9Tvw/xsXEgy4P+ghMTchDq3KxYI=;
        b=vtx3icra2Zkfv/83LmcCNN3+x+nrKc55nCrxh09lnhVQlcJ5SFsTsMPHGTsVze+tD7
         i1WUkHwElTLEGwcwVARlcvIDy2+vwUtmPSJBhAyz00J4w8kInfKW92Z4fet4xQR9c5G4
         JwrHLqPST+FTpNohTwqmtF/plEVraGl1LP1/VkbkKIN/BObn+ytzM2jPjpgXUBrZLx47
         e7FEvjxnylqiK5nT5vVP0X8PnUqEJH7IFU3HbIYQunrXPuew3CO2mcYs5dR1FakW3YhE
         rXSSfO8LNZOi5XnsjO/1mLW4K8PxsGct84cyiimg6dP/ZTmJLzXyN5c13WRZSV0nre21
         ZyIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VLMte1ZrK21LBLWW9Tvw/xsXEgy4P+ghMTchDq3KxYI=;
        b=dP0Z9fwtV0iFRjXY4g+0W3ieQfTO3gVH608pzs+80nPtCsDSZ/EJcn6rd9LJwP1gx3
         nq+QG750/vo1jVKFE9LTRSwwftHEme4+RuK6q7zs3VLt6hb8Pzj1qIB08rgHvuIY3jlk
         TL9ZZmh2dlgd0EBaTy1bOmsea6T1E7J5W1EWkUgiIwN9XsYKYvek+VD3U2DHPbtFzwpx
         ZqLBKShXoJF9QYmNC80dSHqViAqe762/mNsd621Um+OEYWcmN6IMz+n1B8NJLDHpMRTz
         vuJuYQ1N/e2vkFrnuN8tN6Wgca3uV1I8aaxT/3nan0TYlFcpZhBgZpS01XI3C+VhG7fb
         qW4w==
X-Gm-Message-State: APjAAAVyvWixd+4Ny4TeZjrrTei9V8ouKKVrqjKzF4DPhPPnH4dIpyjf
        hUKRgzbkO22+4TCZ5+hkSq1OJQ==
X-Google-Smtp-Source: APXvYqwOWeRvRUFvZ9f9cfvAF0FSsJyqiUswJzJjgg9AudAXpAl6+3dPgZZHKaDZdG77YDYavVIf8Q==
X-Received: by 2002:ae9:f404:: with SMTP id y4mr2671444qkl.225.1569335288803;
        Tue, 24 Sep 2019 07:28:08 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::b7c9])
        by smtp.gmail.com with ESMTPSA id d23sm940843qkc.127.2019.09.24.07.28.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Sep 2019 07:28:07 -0700 (PDT)
Date:   Tue, 24 Sep 2019 10:28:06 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Filipe Manana <fdmanana@gmail.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        James Harvey <jamespharvey20@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: WITH regression patch, still btrfs-transacti blocked for...
 (forever)
Message-ID: <20190924142805.n4k4skgbx5mwwf2b@macbook-pro-91.dhcp.thefacebook.com>
References: <CA+X5Wn7Rtw4rTqXTG8wrEc883uFV7JpGo-zD8FhhD9gM+_Vpfg@mail.gmail.com>
 <CAL3q7H41BpuVTHOAMOFcVvVsJuc4iR10KKPDVfgEsG=ZEpwmWw@mail.gmail.com>
 <CAL3q7H4wDdzfA+H0HPk7oKNO3PDiN1nYHpRu5v6rRXvxQFVLbQ@mail.gmail.com>
 <CA+X5Wn4ZmwnJry0zjyAYow-jEU7PSdE16ROSqfaKyGavLoGVQQ@mail.gmail.com>
 <20190924132118.egtvk6mxmh37wl3h@macbook-pro-91.dhcp.thefacebook.com>
 <CAL3q7H4ZUdhZEyUsVFOmzF=L7890MxHndrXwJ=KPR1vwdNQPWQ@mail.gmail.com>
 <20190924141935.2qsfljijmv76door@macbook-pro-91.dhcp.thefacebook.com>
 <CAL3q7H7GHui8hdMO_grffhsoVo8mbDFK=mvbf8usHrFqxxNgcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H7GHui8hdMO_grffhsoVo8mbDFK=mvbf8usHrFqxxNgcA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 24, 2019 at 03:23:06PM +0100, Filipe Manana wrote:
> On Tue, Sep 24, 2019 at 3:19 PM Josef Bacik <josef@toxicpanda.com> wrote:
> >
> > On Tue, Sep 24, 2019 at 03:16:56PM +0100, Filipe Manana wrote:
> > > On Tue, Sep 24, 2019 at 2:21 PM Josef Bacik <josef@toxicpanda.com> wrote:
> > > >
> > > > On Tue, Sep 24, 2019 at 07:07:41AM -0400, James Harvey wrote:
> > > > > On Tue, Sep 24, 2019 at 5:58 AM Filipe Manana <fdmanana@gmail.com> wrote:
> > > > > >
> > > > > > On Sun, Sep 15, 2019 at 2:55 PM Filipe Manana <fdmanana@gmail.com> wrote:
> > > > > > >
> > > > > > > On Sun, Sep 15, 2019 at 1:46 PM James Harvey <jamespharvey20@gmail.com> wrote:
> > > > > > > > ...
> > > > > > > > You'll see they're different looking backtraces than without the
> > > > > > > > patch, so I don't actually know if it's related to the original
> > > > > > > > regression that several others reported or not.
> > > > > > >
> > > > > > > It's a different problem.
> > > > > >
> > > > > > So the good news is that on upcoming 5.4 the problem can't happen, due
> > > > > > to a large patch series from Josef regarding space reservation
> > > > > > handling which, as a side effect, solves that problem and doesn't
> > > > > > introduce new ones with concurrent fsyncs.
> > > > > >
> > > > > > However that's a large patch set which depends on a lot of previous
> > > > > > cleanups, some of which landed in the 5.3 merge window,
> > > > > > Backporting all those patches is against the backport policies for
> > > > > > stable release [1], since many of the dependencies are cleanup patches
> > > > > > and many are large (well over the 100 lines limit).
> > > > > >
> > > > > > On the other it's not possible to send a fix for stable releases that
> > > > > > doesn't land on Linus' tree first, as there's nothing to fix on the
> > > > > > current merge window (5.4) since that deadlock can't happen there.
> > > > > >
> > > > > > So it seems like a dead end to me.
> > > > > >
> > > > > > Fortunately, as you told me privately, you only hit this once and it's
> > > > > > not a frequent issue for you (unlike the 5.2 regression which
> > > > > > caused you the hang very often). You can workaround it by mounting the
> > > > > > fs with "-o notreelog", which makes fsyncs more expensive,
> > > > > > so you'll likely see some performance degradation for your
> > > > > > applications (higher latency, less throughput).
> > > > > >
> > > > > > [1] https://www.kernel.org/doc/html/v4.15/process/stable-kernel-rules.html
> > > > >
> > > > >
> > > > > All understood, thanks for letting me know.  Not a problem.  I have
> > > > > still only ran into this crash once, about 9 days ago.  I haven't had
> > > > > another btrfs problem since then, unlike the hourly hangs on 5.2 with
> > > > > heavy I/O.
> > > >
> > > > We are seeing this crash internally on our testing tier, we're still running it
> > > > down but it's pretty elusive.  I'll CC you when we find it and fix it.  Thanks,
> > >
> > > Which crash?
> > > There are 2 different deadlocks being mentioned in this thread.
> > >
> >
> > The BUG_ON(!PageLocked(page)) crash, we're hunting that guy right now.  Thanks,
> 
> I'm confused.
> Where is that BUG_ON() mentioned in this thread? Only 2 deadlocks are
> mentioned, neither of them involves page locks nor a BUG_ON().
> 

Fuuuck sorry, that was a different thread, IDK how I got them confused.  Sorry
about that,

Josef
