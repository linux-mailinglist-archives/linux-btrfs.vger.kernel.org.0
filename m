Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B59971DD43A
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 May 2020 19:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728717AbgEURY0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 May 2020 13:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728553AbgEURY0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 May 2020 13:24:26 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3181EC061A0E
        for <linux-btrfs@vger.kernel.org>; Thu, 21 May 2020 10:24:26 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id r10so3471273pgv.8
        for <linux-btrfs@vger.kernel.org>; Thu, 21 May 2020 10:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mautobu-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6jW7odiwO4H4GQl0b2ws7CCn/lijJK6trRTlGtHpzcs=;
        b=WAKc8ltbkDS+Z6D9yMjWElSiUk7wRW4ntGBQ4NHL12MxR67aFHqqeU+7asxJXgtHhE
         8lwyuagV2j3vez3PKR4u3QeA3mWEze8aFc6+V8ZnEL8zJpoeihFt/b3lDMq4gxwoDj6n
         gok6gJTOBvJMJmS4ylXJpEuDq32XX7i7V/LAit8prJJn9rMTYumZTpFrQWkACHAWMotR
         dyQEeU8n0VN9Y8zkpMwuFgTameOwCDvgFQZGH1q8lCyuURiJuy6gWV/IwXjJ1dA3h66f
         R7hEwcSWIq+qTaXuSQgBaGJckQKYu82NPVe3ngyyqSXDe6rKKVA7mdmMvPv57rA96RHX
         IqkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6jW7odiwO4H4GQl0b2ws7CCn/lijJK6trRTlGtHpzcs=;
        b=W0VFOq+SwmOhFgJEdiqgn98vL5yFcLCvG/ZpHHabuGe8YWbIVZnddPLp1Hz99WBxKe
         OzlMUTQEq1Ni7vfNfFNV4bNnOOft7g1ooR7DNoBX9DY3KoC8Sj4JdMiaEEuH8d3bnFfO
         NLOrXinTvYNaL5Jvp9mGp5TxRqmhFdnko9wBNMHIuCJ99R8Ord7Z0dKU3O2tB4GTY1Dn
         4ceMgO/HB2tsNLFGbeeoYpTD4LlQbsnUxn3IwuQYa22aqe3UPyYIk9SnKt8/D0pvx59n
         rtDnYRJutIPKffYLUOUk6JyUOz/EGYLX9keNhHalhCWhEtnbYdHsKu2maWzFI5X8Yl9O
         21WA==
X-Gm-Message-State: AOAM530E8p8nmLnzRlG2xWqeWn7Nt36S8yP9agrzxQj4Hb4TRg7rlAWz
        qemcm5edd/NZxoKjZuwut42h+fKYhQEOqO8Kf5RlGxl+9dg=
X-Google-Smtp-Source: ABdhPJyBuwQHyimKPRlu7X9tKYyRytXP0lHGNNVd01VcU/5vk37tMypt9S2I5b1xEN8Bgc6UJseXz4qwqxAkSsOwISc=
X-Received: by 2002:a62:1702:: with SMTP id 2mr10544751pfx.243.1590081865517;
 Thu, 21 May 2020 10:24:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAGAeKuuvqGsJaZr_JWBYk3uhQoJz+07+Sgo_YVrwL9C_UF=cfA@mail.gmail.com>
 <20200520013255.GD10769@hungrycats.org> <20200520205319.GA26435@latitude> <20200521062043.GE10769@hungrycats.org>
In-Reply-To: <20200521062043.GE10769@hungrycats.org>
From:   Justin Engwer <justin@mautobu.com>
Date:   Thu, 21 May 2020 10:24:14 -0700
Message-ID: <CAGAeKuvtrXwFrLN+PmPNfKSv0UVkxzzro+dckXJAXxrSkq4ZSg@mail.gmail.com>
Subject: Re: I think he's dead, Jim
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Johannes Hirte <johannes.hirte@datenkhaos.de>,
        linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

So, in my case at least, I'd guess that dropping the kernel from 4.16
to 4.4 combined with a failed disk is what the root cause was.

I've done what little recovery I can of the current state of files
using btrfs restore. Is there a means of rebuilding the metadata using
the existing data on the drives? Can I put that metadata elsewhere in
a different location so not to overwrite anything? I'm thinking of
moving onto destructive recovery at this point anyway.

Cheers,
Justin

On Wed, May 20, 2020 at 11:20 PM Zygo Blaxell
<ce3g8jdj@umail.furryterror.org> wrote:
>
> On Wed, May 20, 2020 at 10:53:19PM +0200, Johannes Hirte wrote:
> > On 2020 Mai 19, Zygo Blaxell wrote:
> > >
> > > Corollary:  Never use space_cache=v1 with raid5 or raid6 data.
> > > space_cache=v1 puts some metadata (free space cache) in data block
> > > groups, so it violates the "never use raid5 or raid6 for metadata" rule.
> > > space_cache=v2 eliminates this problem by storing the free space tree
> > > in metadata block groups.
> > >
> >
> > This should not be a real problem, as the space-cache can be discarded
> > and rebuild anytime. Or do I miss something?
>
> Keep in mind that there are multiple reasons to not use space_cache=v1;
> space_cache=v1 is quite slow, especially on filesystems big enough that
> raid5 is in play, even when it's not recovering from integrity failures.
>
> The free space cache (v1) is stored in nodatacow inodes, so it has all
> the btrfs RAID data integrity problems of nodatasum, plus the parity
> corruption and write hole issues of raid5.  Free space tree (v2) is
> stored in metadata, so it has csums to detect data corruption and transid
> checks for dropped writes, and if you are using raid1 metadata you also
> avoid the parity corruption bug in btrfs's raid5/6 implementation and
> the write hole.  v2 is faster too, especially at commit time.
>
> The probability of undetected space_cache=v1 failure is low, but not zero.
> In the event of failure, the filesystem should detect the error when it
> tries to create new entries in the extent tree--they'll overlap existing
> allocated blocks, and the filesystem will force itself read-only, so
> there should be no permanent damage other than killing any application
> that was writing to the disk at the time.
>
> Come to think of it, though, the space_cache=v1 problems are not specific
> to raid5.  You shouldn't use space_cache=v1 with raid1 or raid10 data
> either, for the same reasons.
>
> In the raid5/6 case it's a bit simpler:   kernels that can't do
> space_cache=v2 (4.4 and earlier) don't have working raid5 recovery either.
>
> > --
> > Regards,
> >   Johannes Hirte
> >



-- 

Justin Engwer
Mautobu Business Services
250-415-3709
