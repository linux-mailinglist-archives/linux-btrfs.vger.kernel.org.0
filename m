Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94590BBED7
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2019 01:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404010AbfIWXK7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Sep 2019 19:10:59 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39473 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729283AbfIWXK7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Sep 2019 19:10:59 -0400
Received: by mail-wm1-f66.google.com with SMTP id v17so10972072wml.4
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Sep 2019 16:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3NtOVglgyj/dvT1dH7+kSfUDKEY4+aUblgakmCLnaIY=;
        b=CNRpLGeEfymgvMfY8f27FdICitRzOAMei4bgrmygey8sHTOiZLHTxfx9RMqhQhVU5t
         m3pE4DHwwYkjOI7S7V5l0twoer69fQYzyQM1tjp/oK79uK218oj2Xr6kx5HKJHUc6B89
         IgU33lyoiVD5c7jiVmLDMoHMutfrq0OrXyYhGH//hlLeUdY5Qnqh1QLYBLnrQiSEqQDR
         IaJPEc0DS7XPpfl8y2tyGfoxylhZoVqTWuaaHz5O9qE5DYic3Egz85HamcJ4wAzL4RaB
         xV47m7OIvnq/65wp5MDRL6eddbXK9K6Jo+4l6N2PvI89Y8thFvT46yCLCukS1dmeYOc3
         Vaag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3NtOVglgyj/dvT1dH7+kSfUDKEY4+aUblgakmCLnaIY=;
        b=LQJzgjHimpz6FDTBkx0j9htmROSw9uT9kSsqbhYg4OO13EI1BOhMcbr1BzF0Urg33l
         wlsPFlLv09W277XDHpp/CmCTuKxLkvMsckIK6lLzqw7OktCht5CQl4XIbGpiAGk/venr
         mhCYziafWY109izACLh1GjdNrlozAqenhrLm/TKWbYcYDYs//hTK4xLk1hMjyx//uRyk
         cgE65GkX9/Aic64Y2oieUBMw6Z1FIRB16zL5Gy4fVcryX+HILunl2mTqbU0l6+61K42d
         eakc8bsQBHl+4axFs5oIb8izTa+z6dPEwG1QDFms0xsKl8qsHG+TiHOyNiWFhvoSv+mg
         6MYg==
X-Gm-Message-State: APjAAAV9JgPVjbe284qmcRbpNuOLRzqFX0JRhZ0LAIu5/cz4+CUMFXRj
        kBvk8ub6i4l1CQ3wJE6IKMT/HVMZfi5IgEJhHYNyZIcbkewOqQ==
X-Google-Smtp-Source: APXvYqx0GrqUOVLlqMjFwEatrOZAQWoAi1LhOdwPSxAghXC5x4H4w5Vo/c3BrIeGCf1BFXl/JYAsERM071eYHeh1n6s=
X-Received: by 2002:a1c:4102:: with SMTP id o2mr33688wma.66.1569280257191;
 Mon, 23 Sep 2019 16:10:57 -0700 (PDT)
MIME-Version: 1.0
References: <94ebf95b-c8c2-e2d5-8db6-77a74c19644a@petezilla.co.uk>
 <CAJCQCtRAnJR+Z8Z8Bq91YXiMpfmwOiHK0tQ+9zAJvSVvexHnxg@mail.gmail.com>
 <54fa8ba3-0d02-7153-ce47-80f10732ef14@petezilla.co.uk> <CAJCQCtQLk1m8yAxPPDLVZBr3MehdDD3EpNZ6O_OCRsO-FFzRNw@mail.gmail.com>
 <eb9fdaee-ec76-5285-4384-7a615d3cd5c1@petezilla.co.uk> <00be81e2-bca2-3906-c27d-68f252a6ffe1@petezilla.co.uk>
 <CAJCQCtRbjz138p_DVX4=v0e38rtDFjpqrOhBTc4o7Mc=s_zcEw@mail.gmail.com> <fe29580c-3239-f338-6a27-28739fbe7415@petezilla.co.uk>
In-Reply-To: <fe29580c-3239-f338-6a27-28739fbe7415@petezilla.co.uk>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 23 Sep 2019 17:10:46 -0600
Message-ID: <CAJCQCtQrLfqzraCVsMpw99CkHjbAJcfJTrKAdLg6A2G3wtzZtQ@mail.gmail.com>
Subject: Re: Balance ENOSPC during balance despite additional storage added
To:     Pete <pete@petezilla.co.uk>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 23, 2019 at 4:11 PM Pete <pete@petezilla.co.uk> wrote:
>
> On 9/23/19 10:52 PM, Chris Murphy wrote:
> > What features do you have set?
> >
> > # btrfs insp dump-s /dev/
> >
>
> root@phoenix:/var/lib/lxc# btrfs insp dump-s /dev/nvme0_vg/lxc
...
> sectorsize              4096
> nodesize                16384
...
> compat_ro_flags         0x0
> incompat_flags          0x161
>                         ( MIXED_BACKREF |
>                           BIG_METADATA |
>                           EXTENDED_IREF |
>                           SKINNY_METADATA )

Totally a default file system, looks like to me.

Bug 204973 - ERROR: error during balancing '/': No space left on device (edit)
https://bugzilla.kernel.org/show_bug.cgi?id=204973

Since I've reproduced it with all new progs and kernel I don't think
you need to add anything there.

-- 
Chris Murphy
