Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C51FA3E1D6C
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Aug 2021 22:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241124AbhHEUla (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Aug 2021 16:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237913AbhHEUla (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Aug 2021 16:41:30 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91DC2C061765
        for <linux-btrfs@vger.kernel.org>; Thu,  5 Aug 2021 13:41:15 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id w6so9046136oiv.11
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Aug 2021 13:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SRSYoP6v39VhSzHkUdH6tf6R7019Zo4cXNG9LhehyKc=;
        b=nUn8UEtzJtsUFsESUDq1GYkFDj3hG4LK0B3lQ0DWDrvnM/5olPzIk4XcOgskyM2I4R
         MTXxXDm8vw/aBhqQFq9N/E46R5Ozp+hk4VBRrhnCUVsRVJdADy81VS7KAbO0PiPoWSjd
         L2Y+FiVuB1le0910x+bKKF6ja72mDZ/u0sHkoz7uai8DTbmf4j4+qT9JP62gs069s/cI
         ndQIxajIfV7XK7OJYlcXqWzMVze3R47oBYqJGkqY2sChRGha8Wt8B9pPM9JLIeEKfxDt
         V/32pKb+nHoHye271bhaKJTvbowt9GYJZBP5S+mIorKmHX90vgWx+A0jSAZha2s5TDCD
         Extg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SRSYoP6v39VhSzHkUdH6tf6R7019Zo4cXNG9LhehyKc=;
        b=G/S7scHfo1/AE435Sysfj4ZRlRSU5la6H9nhCNk/nvWhRleqDhEoLUquEigPio6wW3
         yp2TvgMrHsgDwnoe8e8J7o9tXDJe6i/gZuU3OPiba4aaELmz/SDgV+Dmw4iOEMH5hbcm
         Pb3GLoUkw5YV30iZvJGkbMqsVDd3Ns3O2fcswXhTHLErUXA5I2J1sywjayZ571cgWaVr
         /UdeOCNTmRBKbKkMjR9tywUtUgVA63wRwjvPL3SkfwkCxRKXG+gwpB2j3QyMTroZi1HJ
         CVluntSpJVf2sExug4fb9FNqT3PorRY+AzHmwzccOjFf4VphNtwz5hKk58vgh1aM2MJL
         lX0w==
X-Gm-Message-State: AOAM531Nb4uFRSNli507Uj2nDS5XZrm0dzE8Z2S6xk76lfqt84N30DfL
        EbWlTCXsRxDphlmfisf27U1Q7xeMawTdGofBeHgEIXxuao0=
X-Google-Smtp-Source: ABdhPJyAZMaCiIPMjQMOIxAAJuOUP42NSWJAkmi0FvWlAhBUNy9pT72Qit+kLR3bTq2fgbsU0RljYyEQRqima2ffeJ4=
X-Received: by 2002:a54:4096:: with SMTP id i22mr7592072oii.26.1628196074768;
 Thu, 05 Aug 2021 13:41:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAGdWbB59ULVxpNnq5Og0SCri+qyz_cwDLFTLr5N7iVT9gb0w1A@mail.gmail.com>
 <87eeb7pysj.fsf@vps.thesusis.net>
In-Reply-To: <87eeb7pysj.fsf@vps.thesusis.net>
From:   Dave T <davestechshop@gmail.com>
Date:   Thu, 5 Aug 2021 16:41:03 -0400
Message-ID: <CAGdWbB5+UOxxF21JxbzvVP3F-0zhDF4rpBc820fmc54Hyv-5WQ@mail.gmail.com>
Subject: Re: why is the same mount point repeatedly mounted in nested manner?
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Cc:     Phillip Susi <phill@thesusis.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 5, 2021 at 1:49 PM Phillip Susi <phill@thesusis.net> wrote:
>
>
> Dave T <davestechshop@gmail.com> writes:
>
> > I'm using btrbk via a systemd timer. I have a daily and hourly timer
> > set up. Each timer starts by mounting the btrfs root, performing the
> > btrbk task, and unmounting the btrfs root.
>
> It looks like the unmounting is not being done, so it just keeps
> mounting it over again on the next backup.
>

Not exactly... that path should not be unmounted. I do not mount that
location explicitly for the btrbk tasks. It is mounted when the server
boots up with the bind mount line I showed in fstab:

/var/cache/pacman       /srv/nfs/var/cache/pacman       none  bind  0 0

It should not be unmounted (or remounted) just because the top level
btrfs volume is (un)mounted for btrbk tasks. That's the part that is
confusing me.

There is no command associated with my btrbk tasks that mounts
/srv/nfs/var/cache/pacman (or /var/cache/pacman). There's no other
entry in fstab for it except the bind mount I showed.
