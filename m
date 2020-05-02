Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3C41C2750
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 May 2020 19:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbgEBRsg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 2 May 2020 13:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728343AbgEBRsg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 2 May 2020 13:48:36 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F710C061A0C
        for <linux-btrfs@vger.kernel.org>; Sat,  2 May 2020 10:48:36 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id h4so3599011wmb.4
        for <linux-btrfs@vger.kernel.org>; Sat, 02 May 2020 10:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u3sKNqROg+ZeWmz7mSpvZqTVPoKnG+ikgPL5nuH9NrU=;
        b=kau06bg3RcMMoEwiBwt+u6we+8o+qddxaTV/9C6N8qpbYAVWzAHP8nU5IBRtzGMSbC
         YvHPzTz5+s1by+8xGkCzxwiNyOE+KvpPjIITIlCy6po41uQgR+2bP49sCqi0Zi0edELK
         IFqyFZuf39gsQEb5g+DVMeineR4GlL267chTg8Z8phPOHMb95Fs7x5qVYzmTCUoeMRh2
         BHdmFJf2QfVN/syJ5ER2xE9Fs4wY6B2yjDE5Yo8+nDDfumvqo/LCKfyJLU7lTtcj6WLa
         liLx2KOauoggDlF2QCQSk9var5MmJtFu/JemRD78Odjr75HYW5TL3mkOSxRFoXhU1RTu
         JpSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u3sKNqROg+ZeWmz7mSpvZqTVPoKnG+ikgPL5nuH9NrU=;
        b=Tbjbiljnf6gWTaiAcGVIFHMwqY/kwSJN55WTCmD2o8oqXHrf0pTPQiBTEpWblDlhTm
         140QGdVQyP7OoAt4RiRvXIE8PiqbAebycZAfvbPkyuj3wy8xUQ35yGB0TH+8ygrisoHt
         ViK7PJyLpfpsZcoBJD/eeLiAJ7XG6ewM3qf3L6HJf7IhBKVcq00qBLPOJxf6TkJb6KE9
         o9RON4mYYSxAmdeNMAEfRxYJhIWJmgpy7HoCcm+ipJg+OOZjNkbY5RhAxUrUOejKXcr9
         JmwrVvi2CtB0hviocRz97YGiBlHOGUpHra1iXtuEAiFCvUvC5mtRea+GBeE0IE7axvGz
         a07g==
X-Gm-Message-State: AGi0PuafV01DOyIG7Gx1lTkEiJljMmXFmxc56CtbmAVesE3o3bATB0Ix
        FNUOzWdCpPA0pW2p3YRNYlLlNZRMeVooBnVA7Z29Vg==
X-Google-Smtp-Source: APiQypJnl+MCOtJGvDlCHmhtXNJG8DRHLw+2dTb9BloQ3hAmQu1WPszzUmDPUJejFc30P9quh8LWrCnNQMnk6srkzl8=
X-Received: by 2002:a1c:6455:: with SMTP id y82mr5459086wmb.128.1588441714712;
 Sat, 02 May 2020 10:48:34 -0700 (PDT)
MIME-Version: 1.0
References: <14a8e382-0541-0f18-b969-ccf4b3254461@ka9q.net>
 <r8f4gb$8qt$1@ciao.gmane.io> <bc4c477a-dd68-9584-f383-369b65113d21@ka9q.net>
 <20200502033509.GG10769@hungrycats.org> <SYBPR01MB3897D20A8185249BF2A26B139EA80@SYBPR01MB3897.ausprd01.prod.outlook.com>
 <20200502060038.GK10769@hungrycats.org> <SYBPR01MB389730010988EC44E7D109EE9EA80@SYBPR01MB3897.ausprd01.prod.outlook.com>
 <CAMwB8mhGkcM3DCTusuHAi-cQcr-FrA5cq4hVYfv+65zn_QjAig@mail.gmail.com>
 <20200502074237.GM10769@hungrycats.org> <CAMwB8mg5npwzxFrBw8gdBt7KPbTb=M8d_MAGtbQbCoJS0GoMgA@mail.gmail.com>
 <20200502090946.GO10769@hungrycats.org>
In-Reply-To: <20200502090946.GO10769@hungrycats.org>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sat, 2 May 2020 11:48:18 -0600
Message-ID: <CAJCQCtTGg+Rmisw9QAj4SMaDcZ5e_2h_83-3Hjd=FDC5krgjCg@mail.gmail.com>
Subject: Re: Extremely slow device removals
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Phil Karn <karn@ka9q.net>, Paul Jones <paul@pauljones.id.au>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, May 2, 2020 at 3:09 AM Zygo Blaxell
<ce3g8jdj@umail.furryterror.org> wrote:
>
> On SD/MMC and below-$50 SSDs, silent data corruption is the most common
> failure mode.  I don't think these disks are capable of detecting or
> reporting individual sector errors.  I've never seen it happen.  They
> either fall off the bus or they have a catastrophic failure and give
> an error on every single access.

I'm still curious about the allocator to use for this device class. SD
Cards usually self-report rotational=0. Whereas USB sticks report
rotational=1. The man page seems to suggest nossd or ssd_spread.

In my very limited sample size from a single vendor, I've only seen SD
Card fail by becoming read only. i.e. hardware read-only, with the
kernel spewing sd/mmc related debugging info about the card (or card's
firmware). Maybe that's a good example? I suppose it's better to go
read-only with data still readable, and insofar as Btrfs was concerned
the data was correct, rather than start returning transiently bad
data. However, I only knew this due to data checksums.


-- 
Chris Murphy
