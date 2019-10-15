Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0B94D6CE1
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2019 03:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbfJOB2B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Oct 2019 21:28:01 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37900 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfJOB2B (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Oct 2019 21:28:01 -0400
Received: by mail-wr1-f68.google.com with SMTP id y18so12250497wrn.5
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Oct 2019 18:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=64CXXKHZC+Idrw4ap0YUHex1DaHO8qsbwGq10zlxmgw=;
        b=0GkxAYfAlMmdhCnkvq1421ibzRfOc58zyBkClAVEFM8yl0wgVHG42vLGSE58e4jsYK
         R0QoM3pHR77lO5yO47PCelSoCRbo1NBzf69H0Zn5oXTMiTm7kxHKb8Fwfdbxoxtj49pF
         8XqcmtchUuYKL1JsRJnwzuLZEpH1Xpevpw4Ba140vt9aLQjkO882s1AI1kF+OWs7AaHD
         QSJBUb859MxNhi4m9XdyZqh25gNRptxhXjUQXK6WvrgzW1gyzbrK+im/oF7dcX+83lzq
         ZNomtjcftHrneMS9TFqQXv0XyLibcNgm81hI/ac4v+SRwToBswlUt53nuR8Dg6+1G5mT
         v6DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=64CXXKHZC+Idrw4ap0YUHex1DaHO8qsbwGq10zlxmgw=;
        b=XeZeJo+uYMakD+Hq1o9dAR9EtBe3XCW/mtwn9Ba2rdz3DqlfOjags3Vg2wAOs0EIsA
         DYUFKogQ5GYYihTZdTnEIyYGTSkH5e6bq+jkTSgGqbgPFsUYqyh/fS1zQ+g7Xsh/GFCe
         J2EmgieVUjL0Ydpubc/AhTyoJLye1POKT3+8LkIiyTpAhaFka0Hi/fGv/wg0j7iDx8l5
         LMvlvg0RydtkcZhs2bgjs9ToUWD2OrOuuEQhW2FPxlOpP/tQHvBa7vselaa7OtrsPPdn
         GOLJrBq6d4l7Zcbj/KRulUmmrihYA9XIYTssbp3iiUUvw5mWlTl4lCYDqUxSxeBB8OE3
         IxcQ==
X-Gm-Message-State: APjAAAV3VSaHNNe01KcLvO/X070JfziUHkLV/b+6uZnMc1mBg5UzBsVP
        Qmx5/KTlYVYIdHylMlVyZ16viRFC+QbCW78JJEnboA==
X-Google-Smtp-Source: APXvYqyIjvLeYGPhXUW1ZeSvutjU/IVa4YW3xSGUwZZRYHbyVuO9o73XDO77CZ6dVIqxfQOgE7uS9ZBPeqqMXDsm72Y=
X-Received: by 2002:a5d:6246:: with SMTP id m6mr29160899wrv.262.1571102877861;
 Mon, 14 Oct 2019 18:27:57 -0700 (PDT)
MIME-Version: 1.0
References: <CA+X5Wn72nYqoMLLHAUZeO43_rLL9c=zwjDYG9MKV+rcZ7x6SXw@mail.gmail.com>
 <CAJCQCtT6=msmaMJg-GrV8x=oPUEwuMjHxtXLQMrtSDHkq-DDZw@mail.gmail.com> <CA+X5Wn6DbccBXWe0uA2n-mRq-hU0WP20YTFDNw-mEWcdXxO=Hg@mail.gmail.com>
In-Reply-To: <CA+X5Wn6DbccBXWe0uA2n-mRq-hU0WP20YTFDNw-mEWcdXxO=Hg@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 14 Oct 2019 19:27:41 -0600
Message-ID: <CAJCQCtTz-ie6Pdmj72UHrUS4SJGd8fdxXGXXi6Roz0n6xaw6+Q@mail.gmail.com>
Subject: Re: 5.3.0 deadlock: btrfs_sync_file / btrfs_async_reclaim_metadata_space
 / btrfs_page_mkwrite
To:     James Harvey <jamespharvey20@gmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 14, 2019 at 7:05 PM James Harvey <jamespharvey20@gmail.com> wrote:
>
> On Sun, Oct 13, 2019 at 9:46 PM Chris Murphy <lists@colorremedies.com> wrote:
> >
> > On Sat, Oct 12, 2019 at 5:29 PM James Harvey <jamespharvey20@gmail.com> wrote:
> > >
> > > Was using a temporary BTRFS volume to compile mongodb, which is quite
> > > intensive and takes quite a bit of time.  The volume has been
> > > deadlocked for about 12 hours.
> > >
> > > Being a temporary volume, I just used mount without options, so it
> > > used the defaults:  rw,relatime,ssd,space_cache,subvolid=5,subvol=/
> > >
> > > Apologies if upgrading to 5.3.5+ will fix this.  I didn't see
> > > discussions of a deadlock looking like this.
> >
> > I think it's a bug in any case, in particular because its all default
> > mount options, but it'd be interesting if any of the following make a
> > difference:
> >
> > - space_cache=v2
> > - noatime
>
> Interesting.
>
> This isn't 100% reproducible.  Before my original post, after my
> initial deadlock, I tried again and immediately hit another deadlock.
> But, yesterday, in response to your email, I tried again still without
> "space_cache=v2,noatime" to re-confirm the deadlock.  I had to
> re-compile mongodb about 6 times to hit another deadlock.  I was
> almost at the point of thinking I wouldn't see it again.
>
> After re-confirming it, I re-created the BTRFS volume to use
> "space_cache=v2,noatime" mount options.  It deadlocked during the
> first mongodb compilation.  w > sysrq_trigger is a little bit
> different.  No trace including "btrfs_sync_log" or
> "btrfs_async_reclaim_metadata_space".  Only traces including the
> "btrfs_btrfs_async_reclaim_metadata_space".  Viewable here:
> http://ix.io/1YGe

I think it's some kind of disk or lock contention, but I don't really
know much about it. The v1 space_cache is basically data extents, so
they use data chunks and I guess can conflict with heavy data writes.
Whereas v2 space_cache is a dedicated metadata btree. So yeah - and
I'm not sure if mongo builds use atime at all so the noatime could be
a goose chase, but figured it might help reduce unnecessary metadata
updates.


> Also, as I'm testing some issues with the mongodb compilation process
> (upstream always forces debug symbols...), as a workaround to be able
> to test its issues, I've used a temporary ext4 volume for it, which I
> haven't had a single issue with.

Adds to the notion this is some kind of bug.

-- 
Chris Murphy
