Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE17D36A2D0
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Apr 2021 21:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232560AbhDXTjc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 24 Apr 2021 15:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbhDXTjb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 24 Apr 2021 15:39:31 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41BCEC061574
        for <linux-btrfs@vger.kernel.org>; Sat, 24 Apr 2021 12:38:52 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id g9so35731546wrx.0
        for <linux-btrfs@vger.kernel.org>; Sat, 24 Apr 2021 12:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rqCGWAna01ZJwYeMWuabqxTL3eUWZ/D6UA+//1ZIAN4=;
        b=GA+a/gyamoqv7w2GH2AVHZ1M/ViC5iT5F2ciUZ58Phft5/28xsRYRqxGhlMmkY7WBW
         pNEJr1lxXfUGikEzeXCWVF7aem/kAx4gJaxEiVrWfGyMklBkrWYW4C2h+wFDTzDnRxkZ
         IdOPJsTaDm42FPXNJTQwRTSfV7pnSPlaL2xoSqBdVO4w5MUQryJsauHm8U6CZ2Vf1mjU
         Tcpr/i6PHKzcys1rBi3DijnYGxdwcirqelEOjcNjMA5ChTjhIioDzPK2quJ4lCEDsMsg
         viItWhcnxCGE8XHS/F1pQlUIdjoMMBtAnezZTBQfN/F3SngBqfAx7eedWSIrIhwT/NWl
         RMwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rqCGWAna01ZJwYeMWuabqxTL3eUWZ/D6UA+//1ZIAN4=;
        b=iHHV0oxe+qK6+Vc9JkZ+GxUN8icTbaA70T5kuIj88m67dmu5tqCwSmHo1rYE2vFNaM
         N8i4nBpJKmhXBveSwZIYOrQluqMLilDdfqGGFlYU46PIcpvClUg214uMbnuD2834ZQpM
         /2aoc1ZlGBEnFUbG61ZT8ld6uCy6R0trSu0rcqM2Vwty5IkF4kti5TFWy6Zi4K06Ro8w
         OmbgAmvRuDcIRTcWax3ywhp041lU3ADZMFF4bGYFkSty7bS2tAWziArBK6srz41ynT+4
         1Ls8X8ck2ubM8/6Sd/3oTMHWsyMEYlBBdeDSHtUil+f9kRePEj6tq6SK64csOeyzUBLk
         fQsA==
X-Gm-Message-State: AOAM532D90qL5kvw3M5/jAARMUNa/4dc64CvuO1J3XzAWeFpaeXrEAxH
        qXUDG2JaPZh28eV+UjFcwoRlDA55SX6nbRC9yrGFCw==
X-Google-Smtp-Source: ABdhPJyPkTl9wSylKXJQF8q3JxzVQ+BY6t9vDdR+5FrQjKFwFk3wrl/hMteNOtOxErYFnC0iJnVj6y2kcHZ/ol2WQEc=
X-Received: by 2002:adf:bbd2:: with SMTP id z18mr12431785wrg.274.1619293130898;
 Sat, 24 Apr 2021 12:38:50 -0700 (PDT)
MIME-Version: 1.0
References: <be7a946f-c5c6-c95b-4715-a7132bedd7ee@gmail.com>
In-Reply-To: <be7a946f-c5c6-c95b-4715-a7132bedd7ee@gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sat, 24 Apr 2021 13:38:34 -0600
Message-ID: <CAJCQCtQUPernQR2h+6HQHt7qSSm3NtTG7r6Eqo6++DPM2AJV9w@mail.gmail.com>
Subject: Re: Converting EXT4
To:     Forrest Aldrich <forrie@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 20, 2021 at 9:50 AM Forrest Aldrich <forrie@gmail.com> wrote:
>
> I have been experimenting with both BTRFS and EXT4 on hacked up,
> external RAID5 array made of USB disks.  Yes, I know, crazy -- but
> they're laying around, so I figured why not use them for long-term storage?
>
> Anyway, in my latest transfer of multiple terabytes of data, to an EXT4
> filesystem (it was BTRFS before), I used the open-source tool "rclone"
> which was pretty fast.   I ended up with (for example) images files that
> are now of file type "data" and others that appear to not be what
> they're supposed to be.   There are checksumming operations that go on,
> I repeated the process a couple of times to ensure all data were copied.
>
> My question here is if I convert this to BTRFS might that correct some
> of these issues or did I run into another issue?

I'm not familiar with what rclone does at any level of detail. My
expectation is that whatever state the ext4 file system is in, will be
reflected in a converted Btrfs. The conversion process doesn't have
the ability to correct pre-existing problems.

-- 
Chris Murphy
