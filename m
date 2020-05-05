Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 599871C4BE4
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 May 2020 04:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgEECWm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 May 2020 22:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726531AbgEECWm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 4 May 2020 22:22:42 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9B0C061A0F
        for <linux-btrfs@vger.kernel.org>; Mon,  4 May 2020 19:22:41 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id h4so455285wmb.4
        for <linux-btrfs@vger.kernel.org>; Mon, 04 May 2020 19:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YvtOJ6OnXxi8N+V9ajSGW4uUb5yRuZ82sqRrCAUJenk=;
        b=S9VUkrfWpxd7kYdBGdxcu6aklJg6qHTU0aK2LlH5X70MYbjJ/qKdbG4Be+wG/Upr0p
         q14NH00LEmBP3pWrlTOuNFeh3bxPtz+Pz5QNq5b8+U6cqp1xFVL1Rq9yaSBJOc3GWVqF
         aG6AO5lEUBa2Ws/22QI6R6+cqSGK/GlZt+XwxhpSLVDZ4IHNyUEu0hmxPtfjw9yZ3gxt
         Hp2SdouqXpZ3w12N7KzzDBazzvlJNvdRL3TQdhT3q8Vc0YhvSPzuyXz2Xw6d5SsDhE5F
         clILsNQ5QwlAEl6Iy4SohKWvEmLEH+nfpy96RV6Ifc/5Zu9i7Gyaaso5y/npoWqZdgw4
         i5zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YvtOJ6OnXxi8N+V9ajSGW4uUb5yRuZ82sqRrCAUJenk=;
        b=akwf1myUnjReusg2sl3O+X0ng/BKSCZefnTvKnFTqeV5neJhpbG2s9dmIL+JFFKY7r
         5wm2Oey/TLMTSgDqGVMLxaxxdcgZkZtbmnEXw//bvnpwfr1hzItCpilSRA03oP/8yEiX
         PfaWQcVyt0OmZHuF522qIT3ElEkX8qn2yc09RrT+ihVnSMTcq7SFwCKAZp5Cv737rCyv
         ihqXiS6eWSZO01t5Da63VyUb7ICpZgO7yZKiDZQGUqVqzQ9VhSWdC35v4IDliskThrtF
         WnP23lzwGHjItC+XlwtSVgz9EL8b6srk14UNflXNs5iRquI+B6sv5zGXLVvMQ36yxZpt
         H5QQ==
X-Gm-Message-State: AGi0PuZwkGkxcA88DPzV/fqM31FsGlp6gPypD15hV29izV7XkLrmzSJ2
        02vLcpLT/TuFuQqA9FNpq+rI8Oqv8RS15CjhgttEAQ==
X-Google-Smtp-Source: APiQypI2MOJ0fCG3YDJ2tlDNzfFeQJqQnKpj+p4QVWEc2W+3cLh3kb0XD/lmB6yK4zRrOUM9F/THWxd6QmfJmU7MJ54=
X-Received: by 2002:a1c:6455:: with SMTP id y82mr553393wmb.128.1588645360605;
 Mon, 04 May 2020 19:22:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAG+QAKXuaah3tkhQLd7mD3bx+pc3JZdXkUg6yr0R8=Zv2vXnhw@mail.gmail.com>
 <20200504230857.GQ10769@hungrycats.org> <CAJCQCtQt0S6b66yKRFT6bV=z4r+CEvjss3o66EoT=oiz7UKuxQ@mail.gmail.com>
 <20200505020021.GR10769@hungrycats.org>
In-Reply-To: <20200505020021.GR10769@hungrycats.org>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 4 May 2020 20:22:24 -0600
Message-ID: <CAJCQCtTxtY696bFwhOscOHc5fjsRz_=EzO5Zf9spBFez_59Ltg@mail.gmail.com>
Subject: Re: Western Digital Red's SMR and btrfs?
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Rich Rauenzahn <rrauenza@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 4, 2020 at 8:00 PM Zygo Blaxell
<ce3g8jdj@umail.furryterror.org> wrote:
>
> On Mon, May 04, 2020 at 05:24:11PM -0600, Chris Murphy wrote:
> > On Mon, May 4, 2020 at 5:09 PM Zygo Blaxell
> > <ce3g8jdj@umail.furryterror.org> wrote:
> >
> > > Some kinds of RAID rebuild don't provide sufficient idle time to complete
> > > the CMR-to-SMR writeback, so the host gets throttled.  If the drive slows
> > > down too much, the kernel times out on IO, and reports that the drive
> > > has failed.  The RAID system running on top thinks the drive is faulty
> > > (a false positive failure) and the fun begins (hope you don't have two
> > > of these drives in the same array!).
> >
> > This came up on linux-raid@ list today also, and someone posted this
> > smartmontools bug.
> > https://www.smartmontools.org/ticket/1313
> >
> > It notes in part this error, which is not a time out.
>
> Uhhh...wow.  If that's not an individual broken disk, but the programmed
> behavior of the firmware, that would mean the drive model is not usable
> at all.

I haven't gone looking for a spec, but "sector ID not found" makes me
think of a trim/remap related failure, which, yeah it's gotta be a
firmware bug. This can't be "works as designed".


-- 
Chris Murphy
