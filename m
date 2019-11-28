Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9C2110C5F0
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Nov 2019 10:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfK1JZC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Nov 2019 04:25:02 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36247 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfK1JZC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Nov 2019 04:25:02 -0500
Received: by mail-ot1-f68.google.com with SMTP id d7so4766259otq.3
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Nov 2019 01:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Msqc4hrZMLo82kPzKil3GClIwProm013Kf/7HMfdoEA=;
        b=s7+BitBlwDeahn/M0Og449oE0N1/RSXRbWilYMfvgpqSDyY75uF9RUKjpVRztqCCjR
         tlLsQTYtYsw/vfz1KqJm+YSCYV/wd0FtxwxjQEL8vdc0Y9ldz337lPVuEVbnQUwvaw65
         uEnyqrpJQyDbkfHqLmr6/SCZp+B3XBdIpBrB+bxZxJZkz6zwc4nG0zuNz62GpGaSa8hJ
         BVa7rS3gyUeffR3rsNEMJnnhyMTiwOBzxn8h+QBQavNto9leLlJk1TtjxgcG7GYg1Uxm
         9b8GOXE35MGDc6rz7OLw4aodHXcNljBiNBXIOvir2BlLXVYNFIkIfRBVwE4rCDh5uwlO
         6GGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Msqc4hrZMLo82kPzKil3GClIwProm013Kf/7HMfdoEA=;
        b=nEsr+PEodLMYujSwXE5XqCeyJi1ILJ+BCCtlFlyMNK7xMupNPdtZiVDGTIS/sj8HK1
         JePSxhalnDd0W/bvcPxOOG6zAQOGrP8rxRYJ+Q6/oaGWPnq+ryDkBZxKS5uJVlNPRxE6
         Y427QGT9xhH+Pp0ci/+c2T4IBE35BD31ucHcvV5WViRsYGzSNVZqxK+XB2ewHBCptIwb
         Dke+fm+FnZvEi6CZYvByyFJv9NSeoeVMFg0UovvOracrAocFgrziKjWylAbKAUHftZIA
         iaNCOutiycpJZEBi2COdDBxcMFZlLmkNeYP6NUzA5L647+Nyi/1JZgTfDe3FjFSwoeN9
         mpHA==
X-Gm-Message-State: APjAAAVjK7rAhSXltVG+EM2mVAyZmCFyp52AKPhe3DMb1BD4I2bZ/74a
        sgTZTOd0zOvTVQ9N1/uqxAtCMnGOfEVGGIXOmK+KIM39
X-Google-Smtp-Source: APXvYqzF8onvWBivKE7Gpfrjyy0/52ZPiqU/O6hmQYFiFta3fkowFayKeW/PeC4uBbE4CEcJnPATSsuNGXsVYA55IGA=
X-Received: by 2002:a05:6830:1583:: with SMTP id i3mr6388604otr.221.1574933101280;
 Thu, 28 Nov 2019 01:25:01 -0800 (PST)
MIME-Version: 1.0
References: <CAHzMYBTXvY1VgcoFDUvc2NFmVKq2HJRHuS0VXzoneUMh79cySA@mail.gmail.com>
 <2b0e5191-740f-0530-4825-0b0b6b653efb@gmx.com>
In-Reply-To: <2b0e5191-740f-0530-4825-0b0b6b653efb@gmx.com>
From:   Jorge Bastos <jorge.mrbastos@gmail.com>
Date:   Thu, 28 Nov 2019 09:24:50 +0000
Message-ID: <CAHzMYBS5asoCqa-DCjutED69SyvXVx+ht7x_QsJZyJTNZUcOiQ@mail.gmail.com>
Subject: Re: RAID5 scrub performance
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

HI,

Thanks for the reply, but I'm not sure I understand, if I start the
scrub for a single device on the raid5 pool it still scrubs the whole
filesystem, and speeds are the same.

Jorge




On Thu, Nov 28, 2019 at 12:01 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2019/11/27 =E4=B8=8B=E5=8D=8811:11, Jorge Bastos wrote:
> > I believe this is a known issue but wonder if there's something I can
> > do do optimize raid5 scrub speed, or if anything is in the works to
> > improve it.
> >
> > kernel 5.3.8
> > btrfs-progs 5.3.1
> >
> >
> > Single disk filesystem is performing as expected:
> >
> > UUID:             9c0ed213-d9c5-4e93-b9db-218b43533c15
> > Scrub started:    Tue Nov 26 21:58:20 2019
> > Status:           finished
> > Duration:         2:24:32
> > Total to scrub:   1.04TiB
> > Rate:             125.17MiB/s
> > Error summary:    no errors found
> >
> >
> >
> > 4 disk raid5 (raid1 metadata) on the same server using the same model
> > disks as above:
> >
> > UUID:             b75ee8b5-ae1c-4395-aa39-bebf10993057
> > Scrub started:    Wed Nov 27 07:32:46 2019
> > Status:           running
> > Duration:         7:34:50
> > Time left:        1:52:37
> > ETA:              Wed Nov 27 17:00:18 2019
> > Total to scrub:   1.20TiB
> > Bytes scrubbed:   982.05GiB
> > Rate:             36.85MiB/s
> > Error summary:    no errors found
> >
> >
> >
> > 6 SSD raid5 (raid1 metadata) also on the same server, still slow for
> > SSDs but at least scrub performance is acceptable:
> >
> > UUID:             e072aa60-33e2-4756-8496-c58cd8ba6053
> > Scrub started:    Wed Nov 27 15:08:31 2019
> > Status:           running
> > Duration:         0:01:40
> > Time left:        1:40:11
> > ETA:              Wed Nov 27 16:50:24 2019
> > Total to scrub:   3.24TiB
> > Bytes scrubbed:   54.37GiB
> > Rate:             556.73MiB/s
> > Error summary:    no errors found
> >
> > I still have some reservations about btrfs raid5/6, so use mostly for
> > smaller filesystems for now, but this slow scrub performance will
> > result in multi-day scrubs for a large filesystem, which isn't very
> > practical.
>
> Btrfs uses a not-so-optimal way for multi-disks scrub:
> Queuing scrub for each disk at the same time.
>
> So it's common to cause a lot of race and even conflicting seek requests.
>
> Have you tried to only scrub one disk for such case?
>
> Thanks,
> Qu
>
> >
> > Thanks,
> > Jorge
> >
>
