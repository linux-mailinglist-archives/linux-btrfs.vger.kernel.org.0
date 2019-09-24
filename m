Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 923CABCA0A
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2019 16:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393078AbfIXOTj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Sep 2019 10:19:39 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42878 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbfIXOTj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Sep 2019 10:19:39 -0400
Received: by mail-qk1-f193.google.com with SMTP id f16so1922408qkl.9
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Sep 2019 07:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=APyivguzsSa+d4m45gnysb2NQRxy2bmU27HvgSyxalQ=;
        b=V1PSqAaIcWq2SJCSkNVjpjhgum/1ngVNv2LKP6MahBeJty+XcmLHVQusTk1u8aup+H
         KGpuoZF3sd3VhniEx6ARW+c7gbzDsNdF9g+3zKblmc1wxVKPo2+3MwaWht4wY7y21gR9
         cBml/1CZ95efRT+PKEsXfdUryp240G24fLkZ2ymp1WyXcwtDKMb/9WC5rtGWPT2v/6lc
         zW2ck0pE5T55yRx/DDsQE7d65NRsqbVgD2SlsoAMHxsVc8muqonclwScyOofrWoezsRd
         zs2eQGQMWLyUiesrJDLXEXHLjWuOq+Mn7vshwK1xjQVZk3zWD53MxzLVYztwf84iS/YM
         f1Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=APyivguzsSa+d4m45gnysb2NQRxy2bmU27HvgSyxalQ=;
        b=Pf4hutzC6RMBg7hPnv9IHMipe4hcy9166Arkgo8x0tmF1bb0ZX+7xkWP7fg8FNj18G
         5Id7IIHjdTpaOUuT1z1NbDyR7FJbBGYeCYw/cF5ZotSXa6PYM1yHosgGdR36okv38hzm
         vSPie3WVnw50r/vjWSBGGcGZ2C8oZdrWLMNLOolemZzHAP9UGsUXGnnteDgbFpxXBfxX
         iKLySNJRCBbOVcEGR3nNjc1k4vhpdCclzLatfM3p0BOBsxrRmpfWSMMFoZhIm6cxXI2x
         BLAmJj4IWcTZRuhK3mKTobPTwcGfLbi8rlLsAXu1HG5BYvzB8JZysBOg4ivgV/8IK7L0
         k1fw==
X-Gm-Message-State: APjAAAUQVuB7uDKQCuI+iBvfdQWFguu8OebSGuYrLwExW8lNq+3HvBtL
        vG7sqZL74HWxp7VounpzsWTKAQ==
X-Google-Smtp-Source: APXvYqxDCPxWWh4/jFkQpVDqsOMUph51McPNcZHN+z72YaGMzNDeORv0MyKps+ZB+Y/uonbsPF7H/w==
X-Received: by 2002:a37:9d93:: with SMTP id g141mr2698358qke.188.1569334777855;
        Tue, 24 Sep 2019 07:19:37 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::b7c9])
        by smtp.gmail.com with ESMTPSA id w2sm1211458qtc.59.2019.09.24.07.19.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Sep 2019 07:19:37 -0700 (PDT)
Date:   Tue, 24 Sep 2019 10:19:36 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Filipe Manana <fdmanana@gmail.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        James Harvey <jamespharvey20@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: WITH regression patch, still btrfs-transacti blocked for...
 (forever)
Message-ID: <20190924141935.2qsfljijmv76door@macbook-pro-91.dhcp.thefacebook.com>
References: <CA+X5Wn7Rtw4rTqXTG8wrEc883uFV7JpGo-zD8FhhD9gM+_Vpfg@mail.gmail.com>
 <CAL3q7H41BpuVTHOAMOFcVvVsJuc4iR10KKPDVfgEsG=ZEpwmWw@mail.gmail.com>
 <CAL3q7H4wDdzfA+H0HPk7oKNO3PDiN1nYHpRu5v6rRXvxQFVLbQ@mail.gmail.com>
 <CA+X5Wn4ZmwnJry0zjyAYow-jEU7PSdE16ROSqfaKyGavLoGVQQ@mail.gmail.com>
 <20190924132118.egtvk6mxmh37wl3h@macbook-pro-91.dhcp.thefacebook.com>
 <CAL3q7H4ZUdhZEyUsVFOmzF=L7890MxHndrXwJ=KPR1vwdNQPWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H4ZUdhZEyUsVFOmzF=L7890MxHndrXwJ=KPR1vwdNQPWQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 24, 2019 at 03:16:56PM +0100, Filipe Manana wrote:
> On Tue, Sep 24, 2019 at 2:21 PM Josef Bacik <josef@toxicpanda.com> wrote:
> >
> > On Tue, Sep 24, 2019 at 07:07:41AM -0400, James Harvey wrote:
> > > On Tue, Sep 24, 2019 at 5:58 AM Filipe Manana <fdmanana@gmail.com> wrote:
> > > >
> > > > On Sun, Sep 15, 2019 at 2:55 PM Filipe Manana <fdmanana@gmail.com> wrote:
> > > > >
> > > > > On Sun, Sep 15, 2019 at 1:46 PM James Harvey <jamespharvey20@gmail.com> wrote:
> > > > > > ...
> > > > > > You'll see they're different looking backtraces than without the
> > > > > > patch, so I don't actually know if it's related to the original
> > > > > > regression that several others reported or not.
> > > > >
> > > > > It's a different problem.
> > > >
> > > > So the good news is that on upcoming 5.4 the problem can't happen, due
> > > > to a large patch series from Josef regarding space reservation
> > > > handling which, as a side effect, solves that problem and doesn't
> > > > introduce new ones with concurrent fsyncs.
> > > >
> > > > However that's a large patch set which depends on a lot of previous
> > > > cleanups, some of which landed in the 5.3 merge window,
> > > > Backporting all those patches is against the backport policies for
> > > > stable release [1], since many of the dependencies are cleanup patches
> > > > and many are large (well over the 100 lines limit).
> > > >
> > > > On the other it's not possible to send a fix for stable releases that
> > > > doesn't land on Linus' tree first, as there's nothing to fix on the
> > > > current merge window (5.4) since that deadlock can't happen there.
> > > >
> > > > So it seems like a dead end to me.
> > > >
> > > > Fortunately, as you told me privately, you only hit this once and it's
> > > > not a frequent issue for you (unlike the 5.2 regression which
> > > > caused you the hang very often). You can workaround it by mounting the
> > > > fs with "-o notreelog", which makes fsyncs more expensive,
> > > > so you'll likely see some performance degradation for your
> > > > applications (higher latency, less throughput).
> > > >
> > > > [1] https://www.kernel.org/doc/html/v4.15/process/stable-kernel-rules.html
> > >
> > >
> > > All understood, thanks for letting me know.  Not a problem.  I have
> > > still only ran into this crash once, about 9 days ago.  I haven't had
> > > another btrfs problem since then, unlike the hourly hangs on 5.2 with
> > > heavy I/O.
> >
> > We are seeing this crash internally on our testing tier, we're still running it
> > down but it's pretty elusive.  I'll CC you when we find it and fix it.  Thanks,
> 
> Which crash?
> There are 2 different deadlocks being mentioned in this thread.
> 

The BUG_ON(!PageLocked(page)) crash, we're hunting that guy right now.  Thanks,

Josef
