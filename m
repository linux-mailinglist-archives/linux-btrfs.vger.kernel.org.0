Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59FC71C2A2D
	for <lists+linux-btrfs@lfdr.de>; Sun,  3 May 2020 07:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbgECFjj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 3 May 2020 01:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbgECFji (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 3 May 2020 01:39:38 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74EF0C061A0C
        for <linux-btrfs@vger.kernel.org>; Sat,  2 May 2020 22:39:38 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id v4so12854800wme.1
        for <linux-btrfs@vger.kernel.org>; Sat, 02 May 2020 22:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5NLUHJ42u/wUdyFZ3vBwH4RBaGWjuw40+XwTreczlvc=;
        b=btKsRzB0QK61m2y4Cyp6aFd2wNKkOkelPVs7dNE8m3R0uojLJ0HsKbC03c8vAfthpN
         rre74XcaScfPW7Vo8K1kunfd2sUPuG6B+0zlctLoiK+Dh4HLUFio0rN4A6tyTHxHkUdy
         bXiUEtNTzMVqt5jNaK+eUVSTUokPX341y7krTijgLHi4SN8RwD8R+/nTsUzB6KHcviKT
         BlnW0OX9/6NBerACDr4u8kEpNyaSqK6N8vGVzAyHOZm6yoaqnRwZ023hf3v9cKbT18Cb
         idKfbhWqBgyipgoSeqXTlc/FAcNPSYLcyaFip79KOiZqr7nwcksgicdfck2AcRa4IVds
         r5bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5NLUHJ42u/wUdyFZ3vBwH4RBaGWjuw40+XwTreczlvc=;
        b=oPoBbiffqpiopMRf8KPAoI8YeOBe5ck+Kv23206lEbgJrEWiRIiEB8yqCU9POWv/Cb
         iatCPzRfMMBWxXVhETXgLePso17CWoPB3n3VDDbdQOlaUADaSmGoOeOMKL7QTJl7QoFb
         e1W23Jms+VMOuoSDMFsI8P7//whRANjWi5K2ttRssk46FgWYaUlaz0ljWkxY5IBRg+Vd
         gq70qXpqFiaBvPocBBiJODubzPjRlNDKwoM0kJQF5LBvXPtq9/QxtK22gBTOQYQnffkw
         Xj6O/Cv9ZmEJYlbcuQgHtaQJr5AP7obPXxx40nDcjCDXVRn3kdH2SxsP2yCKIXD0+UgK
         1p2Q==
X-Gm-Message-State: AGi0PuaXDkYnlwZnYNYHx0dv61qT/TsDBR4z1SygjbaLCVA6HL015Dnd
        vYauSBj+AvQQdT8cA3RK6U+3zZZTdXTCc0Mt6UgZzjOx
X-Google-Smtp-Source: APiQypLOHikrBFkJn4XS0j3WAk2XEgfKSPnXXscz830crWy/Hs5pewvyr8/qX3/1xOM9idliF1yJSWqnFUuWRRC2OJc=
X-Received: by 2002:a1c:1b0b:: with SMTP id b11mr8171687wmb.182.1588484376846;
 Sat, 02 May 2020 22:39:36 -0700 (PDT)
MIME-Version: 1.0
References: <bc4c477a-dd68-9584-f383-369b65113d21@ka9q.net>
 <20200502033509.GG10769@hungrycats.org> <SYBPR01MB3897D20A8185249BF2A26B139EA80@SYBPR01MB3897.ausprd01.prod.outlook.com>
 <20200502060038.GK10769@hungrycats.org> <SYBPR01MB389730010988EC44E7D109EE9EA80@SYBPR01MB3897.ausprd01.prod.outlook.com>
 <CAMwB8mhGkcM3DCTusuHAi-cQcr-FrA5cq4hVYfv+65zn_QjAig@mail.gmail.com>
 <20200502074237.GM10769@hungrycats.org> <CAMwB8mg5npwzxFrBw8gdBt7KPbTb=M8d_MAGtbQbCoJS0GoMgA@mail.gmail.com>
 <20200502090946.GO10769@hungrycats.org> <CAJCQCtTGg+Rmisw9QAj4SMaDcZ5e_2h_83-3Hjd=FDC5krgjCg@mail.gmail.com>
 <20200503052637.GE10796@hungrycats.org>
In-Reply-To: <20200503052637.GE10796@hungrycats.org>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sat, 2 May 2020 23:39:20 -0600
Message-ID: <CAJCQCtSr-1dM7DwUh0TQ0d-B9gAfrMVzHEZ=ZTzv7utf30WGcw@mail.gmail.com>
Subject: Re: Extremely slow device removals
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Chris Murphy <lists@colorremedies.com>, Phil Karn <karn@ka9q.net>,
        Paul Jones <paul@pauljones.id.au>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, May 2, 2020 at 11:26 PM Zygo Blaxell
<ce3g8jdj@umail.furryterror.org> wrote:
>
> On Sat, May 02, 2020 at 11:48:18AM -0600, Chris Murphy wrote:
> > On Sat, May 2, 2020 at 3:09 AM Zygo Blaxell
> > <ce3g8jdj@umail.furryterror.org> wrote:
> > >
> > > On SD/MMC and below-$50 SSDs, silent data corruption is the most common
> > > failure mode.  I don't think these disks are capable of detecting or
> > > reporting individual sector errors.  I've never seen it happen.  They
> > > either fall off the bus or they have a catastrophic failure and give
> > > an error on every single access.
> >
> > I'm still curious about the allocator to use for this device class. SD
> > Cards usually self-report rotational=0. Whereas USB sticks report
> > rotational=1. The man page seems to suggest nossd or ssd_spread.
>
> Use dup metadata on all single-disk filesystems, unless you are making
> an intentionally temporary filesystem (like a RAM disk, or a cache with
> totally expendable contents).  The correct function for maximizing btrfs
> lifetime does not have "rotational" as a parameter.

Btrfs defaults need to do the right thing. Currently it's single
metadata for mkfs, and ssd mount option when sysfs reports the device
rotational is false. This applies to eMMC and SD Cards. Whereas USB
sticks report they're rotational for whatever reason, and in that case
the default is DUP and nossd. But I don't know that rotational is the
best way of assuming an allocator.


-- 
Chris Murphy
