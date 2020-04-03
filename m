Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAB8C19CEBA
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Apr 2020 04:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389366AbgDCCgb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Apr 2020 22:36:31 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39335 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731842AbgDCCgb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Apr 2020 22:36:31 -0400
Received: by mail-pf1-f196.google.com with SMTP id k15so2756615pfh.6
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Apr 2020 19:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc;
        bh=P9ohGrdaIruWuIUt2OJjrgvAhWLgiXYV/iv1ztH5eYc=;
        b=upcDZ6/W2y8TK0xdgFNLqizxsRfPcUlSrVlbW2xGF/08z4l5ZFcxd8LX2MxMITwcdu
         1N+pkdlj1HIxnFAwHxE4RPv1F8zTR3Thq8ppGbcU6HAxJpjnKAUqsqX2JBiIoHVdUpCG
         xAKisomaQqjlzuas8ZhAb0uL8P9bOB895bBxuZ7Lt93CDwwCnNCUbq/94S57oRNmK4wA
         QK5KFr6cgzJXofpfa/rbPmSkGbEUvweje2RQGhpj3a0gMAcFunmYCYNzXOU6aelHLrki
         ipa7x8H2robRZL7gjQxcfaV3k7K2gSOVqf1sL69epSjGWtSp3Asyo23pyfM/Dhti7n5m
         khDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc;
        bh=P9ohGrdaIruWuIUt2OJjrgvAhWLgiXYV/iv1ztH5eYc=;
        b=WUiwwTdD2l2ZnuFyvfd1J4V4OdZYe4/wTHfs2mWxE3Yx6t9iFf2FLNnpH3PN9diK5Y
         TWWG1pMS4iVW65CtO0DiHXUIOTkChVF9Oe3/g81b1lEy3XuIE/FR/achErxiynH21BCL
         gC6Snb8ZbiZvLomkJbn2ohuCu1WaClUnFCl7v/RTn4OK2Qcys+2/sOTf19wVe1/qX3g8
         M1+5IRnD0pSSk3JwCbSfa08SkEEw1SXKupWfW/eoeP/7kdRj2vANvO7RTlbzbXQwM+4F
         Yp4/IrZ6OX3kyaECpi3/vkORF/whRHf9CCSWaBzIhcsK1iIulTK1w5yQo5Fqm2akKdJ+
         Da4w==
X-Gm-Message-State: AGi0PuZ301E9cuSSCbEeYmjn9e+/tjBg5KKEYPewoa4/jLBTRnjzv6TY
        GhhW0P8UmjlIeXokeriJZUXIwQRoO3UOr5SB1Nhh7WNJ
X-Google-Smtp-Source: APiQypKkw3ndDzVu7lM69p0eDSqf+InrKQnySkSUbeyqaMPcYiaF3E65ttL8g4fS/A5gop3jX/dan8q9xjpyYgeGfT8=
X-Received: by 2002:a63:7419:: with SMTP id p25mr5820185pgc.217.1585881390035;
 Thu, 02 Apr 2020 19:36:30 -0700 (PDT)
MIME-Version: 1.0
References: <CANs+87QtdRhxx8gSsHzweMfbznJXLXRdn3SQDPd5uv-K-BZM=w@mail.gmail.com>
 <58f96768-79cb-89c4-7335-0db1d2976b59@cobb.uk.net>
In-Reply-To: <58f96768-79cb-89c4-7335-0db1d2976b59@cobb.uk.net>
From:   Helper Son <helperson2000@gmail.com>
Date:   Thu, 2 Apr 2020 23:36:18 -0300
Message-ID: <CANs+87Tk=Havdiowgqt3NP6Q5VaJM4X6jVx0yXg+PidME1mT9w@mail.gmail.com>
Subject: Re: btrfs filesystem takes too long to mount, fails the first time it
 attempts during system boot
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Interesting. I tried adding x-systemd.mount-timeout=300 to fstab and
removed the nofail option. It now takes roughly two minutes to start,
but mounts successfully on the first attempt. I figured that nofail
would have been enough for it to ignore the time limit since it ran on
the background while the rest of the system was already running, but
apparently I was wrong.

Thanks for the suggestion, the main problem is fixed on my end. At
this point I'm just wandering if taking this long to mount is normal
behavior and if there is anything else I can do to reduce the time,
but I suppose it's part of how btrfs works.

On Thu, Apr 2, 2020 at 7:11 PM Graham Cobb <g.btrfs@cobb.uk.net> wrote:
>
> On 02/04/2020 21:55, Helper Son wrote:
> > Hello,
> >
> > I'm running a fully updated Manjaro install on kernel
> > 5.5.13-1-MANJARO, but this problem occurs on other kernel versions as
> > well. I believe I tried 5.4 and 5.6.
> >
> > I have a btrfs filesystem that looks like this:
> >
> > Overall:
> >     Device size:                  14.55TiB
> ...
> >
> > When the system was at only a couple terabytes of usage, everything
> > was fine. But, as it got progressively filled with more data, it
> > started to take longer to mount during bootup. At one point it
> > extrapolated the 90 second limit and the system failed to boot because
> > of that; I then added nofail to the fstab entry so boot would continue
> > while the system mounted.
> >
> > However, even after taking around two minutes to mount, it still fails:
>
> I see the same problem (I am running Debian Testing - Bullseye).
>
> I *think* (I haven't bothered to test carefully) the problem is that
> when the 90 second default mount timer runs out, systemd cancels the
> mount.  The fix is simple: increase the systemd timeout for that mount.
>
> In fstab, add the option: x-systemd.mount-timeout=N with N long enough
> (I am using 180). More info is available (at least in my distribution)
> in systemd.mount(5).
>
> If anyone else is a Debian user, they may want to add a comment to my
> bug report (https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=955413)
> asking for a warning to that effect to be added to the NEWS file for
> btrfs-progs and the bullseye release notes.
>
