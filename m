Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8561C2A56
	for <lists+linux-btrfs@lfdr.de>; Sun,  3 May 2020 08:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbgECGF3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 3 May 2020 02:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbgECGF2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 3 May 2020 02:05:28 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F17C061A0C
        for <linux-btrfs@vger.kernel.org>; Sat,  2 May 2020 23:05:27 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id x17so16912149wrt.5
        for <linux-btrfs@vger.kernel.org>; Sat, 02 May 2020 23:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WVf59aC75v/6hCO+qKHmZhC4VJfVWO0I5ZKyzvy2xjQ=;
        b=JeDEX5FHPoNu0nFVlt3Cug5itx0OpL3UKUgvsDoZPz9Lamg0s4YeI74Qm6bH/Zzllo
         GqOHzi9O85e90WtZKNxzB+kXXUxKF4SWqub+7Lo2pi5knNXNCaQsnUhDJnNWiyQxKmwB
         TR2SlXffzj2sTqWo5shEJHPhdUMs1Bpt/NQ4IlR0v+v6jVU0tdjjEcDjnIhOC5FxGtfv
         fboEBxj6HnbcAC/AmhXrMsi4RVWH0D2Vv1pahmzWPuE9Y6x7cT9nzsRyehtMDohMdMfF
         QXXo+y7mkuBIv+dcHJHo7EZ8x1VBWmmlj6YEe5QGr++pkEh+ZSN3eRgk4KpGaU/SMjYJ
         a1zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WVf59aC75v/6hCO+qKHmZhC4VJfVWO0I5ZKyzvy2xjQ=;
        b=B0rpkzkR2M5uf9UGVqPCbllj49OnIFeYrLiIRknho9YFfMiLk6Wsphcr03SQt3O7G+
         C6hG1d5vewmRGbwCz0GSdHdjt0okFZosElGVDYOCuqmwM4e6Yps7Gi90Ai116FKi4dc6
         +rU4UFHyN5oQhPJZ9kT+1BYSrkj8uBDa1CSajFp3jCWWFcnjFHe8LWPcrYZRWlZeoFr8
         KQhSv2xYWACka5oPWb8eE8GxKSp9j+kk4TrcENBusIGZcmwPHumTuC+B/pnhcT3wL1wF
         Tjw/hyZ+LWQlnto90YR2tN8CPQgRDkxG2FU3J4gunoEjoNrUQnlSFcqHKnP+AOvGEy9g
         BNEg==
X-Gm-Message-State: AGi0PuZjrvFgj98zk8V4oX+aTwQl5CAfZp57WFmSyQNazUs6cyfoHKsz
        Y5eDFIw5lflevpdM8RJ0yOFqxfe9bsi3e5syf52/hOOuQY8=
X-Google-Smtp-Source: APiQypIq3XMWa9/9ruZVVuS9BaU2iaemU6i5rrBhXsv/1uWZUwSk62WSkpVdXFxmc+cmGfNFlQhHmScmcWRQ1n3HVGc=
X-Received: by 2002:adf:e702:: with SMTP id c2mr12846226wrm.252.1588485926248;
 Sat, 02 May 2020 23:05:26 -0700 (PDT)
MIME-Version: 1.0
References: <bc4c477a-dd68-9584-f383-369b65113d21@ka9q.net>
 <20200502033509.GG10769@hungrycats.org> <SYBPR01MB3897D20A8185249BF2A26B139EA80@SYBPR01MB3897.ausprd01.prod.outlook.com>
 <20200502060038.GK10769@hungrycats.org> <SYBPR01MB389730010988EC44E7D109EE9EA80@SYBPR01MB3897.ausprd01.prod.outlook.com>
 <CAMwB8mhGkcM3DCTusuHAi-cQcr-FrA5cq4hVYfv+65zn_QjAig@mail.gmail.com>
 <20200502074237.GM10769@hungrycats.org> <CAMwB8mg5npwzxFrBw8gdBt7KPbTb=M8d_MAGtbQbCoJS0GoMgA@mail.gmail.com>
 <20200502090946.GO10769@hungrycats.org> <CAJCQCtTGg+Rmisw9QAj4SMaDcZ5e_2h_83-3Hjd=FDC5krgjCg@mail.gmail.com>
 <20200503052637.GE10796@hungrycats.org> <CAJCQCtSr-1dM7DwUh0TQ0d-B9gAfrMVzHEZ=ZTzv7utf30WGcw@mail.gmail.com>
In-Reply-To: <CAJCQCtSr-1dM7DwUh0TQ0d-B9gAfrMVzHEZ=ZTzv7utf30WGcw@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 3 May 2020 00:05:10 -0600
Message-ID: <CAJCQCtQaTH1S-MRMOWAJXgq-NRNq1U5kaksj6Xr3z_MCj2YVGw@mail.gmail.com>
Subject: Re: Extremely slow device removals
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Phil Karn <karn@ka9q.net>, Paul Jones <paul@pauljones.id.au>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, May 2, 2020 at 11:39 PM Chris Murphy <lists@colorremedies.com> wrote:
>
> On Sat, May 2, 2020 at 11:26 PM Zygo Blaxell
> <ce3g8jdj@umail.furryterror.org> wrote:
> >
> > On Sat, May 02, 2020 at 11:48:18AM -0600, Chris Murphy wrote:
> > > On Sat, May 2, 2020 at 3:09 AM Zygo Blaxell
> > > <ce3g8jdj@umail.furryterror.org> wrote:
> > > >
> > > > On SD/MMC and below-$50 SSDs, silent data corruption is the most common
> > > > failure mode.  I don't think these disks are capable of detecting or
> > > > reporting individual sector errors.  I've never seen it happen.  They
> > > > either fall off the bus or they have a catastrophic failure and give
> > > > an error on every single access.
> > >
> > > I'm still curious about the allocator to use for this device class. SD
> > > Cards usually self-report rotational=0. Whereas USB sticks report
> > > rotational=1. The man page seems to suggest nossd or ssd_spread.
> >
> > Use dup metadata on all single-disk filesystems, unless you are making
> > an intentionally temporary filesystem (like a RAM disk, or a cache with
> > totally expendable contents).  The correct function for maximizing btrfs
> > lifetime does not have "rotational" as a parameter.
>
> Btrfs defaults need to do the right thing. Currently it's single
> metadata for mkfs, and ssd mount option when sysfs reports the device
> rotational is false. This applies to eMMC and SD Cards. Whereas USB
> sticks report they're rotational for whatever reason, and in that case
> the default is DUP and nossd. But I don't know that rotational is the
> best way of assuming an allocator.

You address this in another thread: It's a bit unfortunate that
btrfs's default is still to use single metadata on SSD.


All I care about is detection on cheap SSDs. At least in my use cases,
I'm not sure it's worth the extra writes from DUP to be able to
recover from silent corruption.


-- 
Chris Murphy
