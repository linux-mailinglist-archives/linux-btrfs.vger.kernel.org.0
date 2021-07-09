Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2633A3C296D
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jul 2021 21:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbhGITM4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Jul 2021 15:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhGITMz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Jul 2021 15:12:55 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E94FC0613DD
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Jul 2021 12:10:12 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id d12so10881112pgd.9
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Jul 2021 12:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=e9QisSr2GII0VMeTljMLtJbGoXh8gr891kjxYtyzaRE=;
        b=TFUAgAU8xod7uwHPswWo6DV8gLcQSpttNhtLtv0M4QmGpkrEG88HfphtsDcP7kQ25r
         YxX095aBWjZIJZnC0n/dvACSgiUYU9q5KD8y5xOJm0LUm+VfNdhQVk/7qhn1/0NJE6Zw
         gbR7AKURr6Zt3Gjv6SV0mef6HZmv61XO+ROKHI9JHtzDQ8kzF7yVdM6P2xb2Sg2QWJge
         gd3fcVS/lz9YjANRanl7wUAbRjwW92Q7pULDrQZ5wRGszkDgBQXrmDYNMGyhDl9TDc5O
         S1UQnO8a+az5vH2HV/t6MaDeDfYsC6veBMkPhcIToECVK7A4meVMOQHJTbIuNlgfiYM1
         IjjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=e9QisSr2GII0VMeTljMLtJbGoXh8gr891kjxYtyzaRE=;
        b=tthoQy+kXQq0cTgRgnLR3KDJUWfuhON1kDtWUpvTXj6DNs8hJrSHfWY+MCifZZBFbW
         yccoE1OrnAnje+J4U84XahXltf8nYGnUvMnsTxJYXe1oAQ/ctTviutMzX9JhypJWW9s9
         8Po0KZvV5hT31n/h19oL/S7VdCVFa6oINFLZHeOxVc7DUydVY3K7xYOtvR0E4Olb0GWD
         JWLjEZVwLfeIOIVb/+zYDTdaqFPQe9uxrw+hxPnVmpWJlp29VxKNfRZg2FOztISysKJT
         pNKyqMU818d6CQpFdfv4wLP44Ak559gFvCOpJI9XRiy1qZXzx1dtttpj/7ekEXpLjDJK
         wOHw==
X-Gm-Message-State: AOAM5303+d8NNhsR1vsqwthUr+TRTE4rnW5jkPfHmqLCQOjnyWNefi7b
        jNbrmDL98X1hu7SCMw795T7Ox0XyRY3DQ9kyzYs=
X-Google-Smtp-Source: ABdhPJzPehbNiUmPWHNvixkXaWwpx8fMoEWGJbUmndLwHnDzE8tN8dYFOYfwmmHTJ8vmsV3VqiGOmVhJ1VvgHaR7CIw=
X-Received: by 2002:a05:6a00:bd3:b029:329:3e4f:eadb with SMTP id
 x19-20020a056a000bd3b02903293e4feadbmr2393902pfu.44.1625857811775; Fri, 09
 Jul 2021 12:10:11 -0700 (PDT)
MIME-Version: 1.0
References: <CALc-jWwheBvcKKM79AD7BA5ZZQs7D407acgwOiwyo9R=U98Nwg@mail.gmail.com>
 <20210707190032.GT2610@twin.jikos.cz>
In-Reply-To: <20210707190032.GT2610@twin.jikos.cz>
From:   Yan Li <elliot.li.tech@gmail.com>
Date:   Fri, 9 Jul 2021 12:10:00 -0700
Message-ID: <CALc-jWzcGL0Jsb+K6ziokFMmJwLKy-ibDC_h-xcTBu7fh4NeXQ@mail.gmail.com>
Subject: Re: autodefrag causing freezes under heavy writes?
To:     dsterba@suse.cz, Yan Li <elliot.li.tech@gmail.com>,
        linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 7, 2021 at 12:03 PM David Sterba <dsterba@suse.cz> wrote:
> On Mon, Jul 05, 2021 at 08:56:23PM -0700, Yan Li wrote:
> > I found that when I added the autodefrag mount option, the system
> > would freeze under heavy write workload for a long time before the
>
> Do you have an estimate for 'long time' ? Like human percievable
> "seconds" or like 5 seconds and more.

It would freeze for minutes, during which the GUI was totally
unresponsive. After a few minutes, presumably after the dd was
finished, the machine would resume normal operation.

The full dmesg is here: https://pastebin.com/TwChmFmC

You could see that the blocked I/O messed up journald's output so that
the message towards the end were not even ordered by the timestamp.

> The autodefrag can cause problems like this, yes, but it depends on
> other factors too. Autodefrag can read additional pages from disk in
> case they aren't contiguous and then writes them (in a small cluster)
> together. You're using compression, so this may add a slightly more
> delay before the data are written. On the default level it should be
> unnoticeable and you mention that's on a Ryzen 5 so I'd rule that out.

The workload was just a simple:
dd if=/dev/urandom of=test_data bs=1M count=2000
so there should be no reason for it to block for such a long time.
And, yes, it's was a new workstation, and works flawlessly on much
heavier workloads when autodefrag was removed.

> IIRC autodefrag can help some workloads but may hurt others so if it's
> making things worse you, then drop it. It helps when seeks are expensive
> ie. on rotational disks but you use SSD so it should not be necessary.

I was advised to add it since I'm running VirtualBox VMs out of these
btrfs. But autodefrag made *everything* worse on this filesystem. It's
weird.

> If you'd still like to debug it, please take a snapshot of all process
> stacks at the time the hang happens.

This was from before I removed the autodefrag option.
https://pastebin.com/TwChmFmC

It's a production system so I can't reboot it every day. I can try to
add autodefrag back a few days later and retest.

Thanks!

-- 
Yan
