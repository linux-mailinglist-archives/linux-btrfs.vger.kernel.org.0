Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E02860D46
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2019 23:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbfGEVsS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Jul 2019 17:48:18 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]:51701 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfGEVsS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Jul 2019 17:48:18 -0400
Received: by mail-wm1-f44.google.com with SMTP id 207so10436716wma.1
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Jul 2019 14:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z2V4k/Xxk2I0dd0pInRhE70uj3nvnJfVnri3DkBuxm0=;
        b=gcuket2klH6H40miWR8Vl4xNfJ+1ofJ/yyH5WyKgGJ36EOjwbrMlX3CrkQn8435mKd
         si7zdiud8/1l+Ra3wkfPYsgQWn8gyYGfqzAttwJFgNGz+syHN+yGPBu3JEen186K8F4e
         TyLopy+uqM2Kx1HLY/1ISLIfXfiYuQeZDbESaIZNSBESPlrSHk8g0PtTrpBT6gBF235H
         HKP3cfuhGlfqs/5uG8wnPTom5JNyCyEIZP2y7Q8X+PfObgmjVxUb25zI6Afkk66sUynZ
         oGdmJ/cGHmCI/uweT5S+ZdUymRb+rKn39zDAXYO//eA8wp/g6blCjd1P9o8p+s/qKqzR
         sWDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z2V4k/Xxk2I0dd0pInRhE70uj3nvnJfVnri3DkBuxm0=;
        b=pyAqO/t2cZEQlPKk8be2PUAuqrzQ3NgemhBXnsm7shQL9GQaEPkwaplcUo+bZf2kws
         YOvL0x8J8RrWze0LaC2YL5QzaWKGJEb74teCZSI4hn2KB0gS1XzXdCLnlx0uAAv1N+xj
         v5Uwvl1rqEH4pIduCJwqGn5/fGexqO9C2nnSCkD2vyrF7/gGeyAoNzbaNwCcchy/+LVq
         6E1L04MxfREv/lS8S+rwGmnJ1FHV5qWYvYaBxwfcxw8B8xujkb08ZTp2Rx957t0srPmG
         wa7AVVD7V0r85pz38mkhmFfBWHMhvSqNv/YhrjNnaDbalEmu5+3ncPFEST4Nbz1qfw0S
         OcjA==
X-Gm-Message-State: APjAAAWlCv2Bq1jOwHjke+mKN79pa7mPqYTuR/9pdzpTZ83qANayhNQg
        lOdiGFlBZ6MLm4qUmlH1R1ottJP//S+UdZFyP2EtnQ==
X-Google-Smtp-Source: APXvYqzAB2L/Sz4S1Svm5MLWXYfI2cWYBiz8QNRk3f2SARqGIJRU3zWNhW6cL/ssrpWcoMhFCGSCCEDYB/uJAW6zxZQ=
X-Received: by 2002:a1c:f018:: with SMTP id a24mr4600274wmb.66.1562363295738;
 Fri, 05 Jul 2019 14:48:15 -0700 (PDT)
MIME-Version: 1.0
References: <966f5562-1993-2a4f-0d6d-5cea69d6e1c6@gmail.com>
 <CAA91j0W+UhJ2O+K1SJs3JaOfzkCnRhWgGjfFxXju5_sUsCj18A@mail.gmail.com> <a0d34e0a-f2bb-abd5-bb6f-f82a8d2da190@gmail.com>
In-Reply-To: <a0d34e0a-f2bb-abd5-bb6f-f82a8d2da190@gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Fri, 5 Jul 2019 15:48:04 -0600
Message-ID: <CAJCQCtTiYn3XrMQVVHhnttt_5ys-gaAq5maihNpDiFPRRqr8YA@mail.gmail.com>
Subject: Re: "kernel BUG" and segmentation fault with "device delete"
To:     Vladimir Panteleev <thecybershadow@gmail.com>
Cc:     Andrei Borzenkov <arvidjaar@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 5, 2019 at 4:20 AM Vladimir Panteleev
<thecybershadow@gmail.com> wrote:
>
> On 05/07/2019 09.42, Andrei Borzenkov wrote:
> > On Fri, Jul 5, 2019 at 7:45 AM Vladimir Panteleev
> > <thecybershadow@gmail.com> wrote:
> >>
> >> Hi,
> >>
> >> I'm trying to convert a data=RAID10,metadata=RAID1 (4 disks) array to
> >> RAID1 (2 disks). The array was less than half full, and I disconnected
> >> two parity drives,
> >
> > btrfs does not have dedicated parity drives; it is quite possible that
> > some chunks had their mirror pieces on these two drives, meaning you
> > effectively induced data loss. You had to perform "btrfs device
> > delete" *first*, then disconnect unused drive after this process has
> > completed.
>
> Hi Andrei,
>
> Thank you for replying. However, I'm pretty sure this is not the case as
> you describe it, and in fact, unrelated to the actual problem I'm having.
>
> - I can access all the data on the volumes just fine.
>
> - All the RAID10 block profiles had been successfully converted to
> RAID1. Currently, there are no RAID10 blocks left anywhere on the
> filesystem.
>
> - Only the data was in the RAID10 profile. Metadata was and is in RAID1.
> It is also metadata which btrfs cannot move away from the missing device.
>
> If you can propose a test to verify your hypothesis, I'd be happy to
> check. But, as far as my understanding of btrfs allows me to see, your
> conclusion rests on a bad assumption.
>
> Also, IIRC, your suggestion is not applicable. btrfs refuses to remove a
> device from a 4-device filesystem with RAID10 blocks, as that would put
> it under the minimum number of devices for RAID10 blocks. I think the
> "correct" approach would be first to convert all RAID10 blocks to RAID1
> and only then remove the devices, however, this was not an option for me
> due to other constraints I was working under at the time.

We need to see a list of commands issued in order, along with the
physical connected state of each drive. I thought I understood what
you did from the previous email, but this paragraph contradicts my
understanding, especially when you say "correct approach would be
first to convert all RAID 10 to RAID1 and then remove devices but that
wasn't an option"

OK so what did you do, in order, each command, interleaving the
physical device removals.


Thanks,


-- 
Chris Murphy
