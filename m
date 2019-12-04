Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA225113576
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Dec 2019 20:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbfLDTIu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Dec 2019 14:08:50 -0500
Received: from mail-wm1-f54.google.com ([209.85.128.54]:51174 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728229AbfLDTIu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Dec 2019 14:08:50 -0500
Received: by mail-wm1-f54.google.com with SMTP id p9so935986wmg.0
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Dec 2019 11:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b+LcPjJLoHjjmM9heQx4gS6k83AeDAzwVJYG8bSm96U=;
        b=qwm8bee1y/+I4/7HGu8jQbLYCqLBsu8k6F/3udRqKIQP3u+LeYIPgQ0y1COwusJ2lB
         qRvUyadl5GiQDVN8Yakmm6D7M/0mzmQCo23KG706l0hvhJJ2Z/vyFx8j3osYMmuRVN1F
         ZH0wG8LJ4+b4pR0FJqGbznkTATitIvR+PMhBEm4Q0BzeeA2Tc/0SjMjyv1v/UVI7S//k
         IafQyokXtv1JAIoi1VOjnrsmEY9HmhqN58qBk4LyVv9cVmYrs4lZwhmTTS2dGlAp272+
         ZUOrRyuhWuwYNVreoCFp8hvSxhI9QCZgVSS25tcF34AeG7PZjwt409J5YUiHr+CgCQtf
         eTIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b+LcPjJLoHjjmM9heQx4gS6k83AeDAzwVJYG8bSm96U=;
        b=IpV+ovfDYcXxmRys0jn1SrHga+LgD4NE4Rffe2RDZnICzn2ly5Kuv7oq8nnR7liD+m
         gSEw3k1hSkAH3HSCP3fh8do4z0yCDCDVZAAm6S+V1p5dgKGvh8wtttHMiKKoioLNROwY
         qzFu4sM8C8Q5bVvoJJ0Gk81DeHLu/fN7/Pu7OnhOoUmn5lmHLy4sLTQHzUaCT53C0yXO
         3amU+SOBE+ybB1cyFs7Ay5HP7ImHm6jF1ivcPfAeaPpMkfrSHD2kvdmb1nvFvt2U2IhG
         41PcPrIHYm3NMAgjtO78HEoBH8k3RG50UQwSmnt2iPaR4SWGtYtYJIzsEIfQZe9gQumZ
         OJsg==
X-Gm-Message-State: APjAAAUI8rXFfXWJpLTs84X6BT65eR3aKCgo/MHkbUHTQM6uQZaYJx56
        Jtx6ZXmyx406pudP+QjH1rmLqENt2Uac9Oq9GR1qBGtpdQ4=
X-Google-Smtp-Source: APXvYqyfjm/EkatWf2I1SDBNQRRACcykSYF4woZkcHitVpWJYmh0S6y8JCJUfXpcvLGbbcrNkVf4+7tDAvrQSd1KTKc=
X-Received: by 2002:a1c:81c9:: with SMTP id c192mr1279759wmd.44.1575486527906;
 Wed, 04 Dec 2019 11:08:47 -0800 (PST)
MIME-Version: 1.0
References: <7D7AA867-8B53-4CD5-83EF-95EABAD2A77C@megacandy.net> <F7C74BD8-4505-4E74-81F2-EB0D603ABCEC@megacandy.net>
In-Reply-To: <F7C74BD8-4505-4E74-81F2-EB0D603ABCEC@megacandy.net>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 4 Dec 2019 12:08:31 -0700
Message-ID: <CAJCQCtRA2+X-ke4yJ4H8o49ZA9mSOFabLpNeXd=4ULDg99rFgQ@mail.gmail.com>
Subject: Re: Unrecoverable corruption after loss of cache
To:     Gard Vaaler <gardv@megacandy.net>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 4, 2019 at 8:50 AM Gard Vaaler <gardv@megacandy.net> wrote:
>
> > 1. des. 2019 kl. 18:27 skrev Gard Vaaler <gardv@megacandy.net>:
> >
> > Trying to recover a filesystem that was corrupted by losing writes due to a failing caching device, I get the following error:
> >> ERROR: child eb corrupted: parent bytenr=2529690976256 item=0 parent level=2 child level=0
> >
> > Trying to zero the journal or reinitialising the extent tree yields the same error. Is there any way to recover the filesystem?
>
> Update: using 5.4, btrfs claims to have zeroed the journal:
>
> > [liveuser@localhost-live btrfs-progs-5.4]$ sudo ./btrfs rescue zero-log /dev/bcache0
> > Clearing log on /dev/bcache0, previous log_root 2529694416896, level 0
>
> ... but still complains about the journal on mount:
>
> > [  703.964344] BTRFS info (device bcache1): disk space caching is enabled
> > [  703.964347] BTRFS info (device bcache1): has skinny extents
> > [  704.215748] BTRFS error (device bcache1): parent transid verify failed on 2529691090944 wanted 319147 found 310171
> > [  704.216131] BTRFS error (device bcache1): parent transid verify failed on 2529691090944 wanted 319147 found 314912
> > [  704.216137] BTRFS error (device bcache1): failed to read block groups: -5
> > [  704.227110] BTRFS error (device bcache1): open_ctree failed
>

Why do you think it's complaining about the journal? I'm not seeing
tree log related messages here. Is the output provided complete or are
there additional messages? What do you get for:

btrfs insp dump-s /dev/X

What kernel version was being used at the time of the first problem instance?

The transid messages above suggest some kind of failure to actually
commit what should have ended up on stable media. Also please provide:

btrfs-find-root /dev/
btrfs check --mode=lowmem /dev/

The latter will take a while and since it is an offline check will
need to be done in initramfs, or better from Live media which will
make it easier to capture the output. I recommend btrfs-progs not
older than 5.1.1 if possible. It is only for check, not with --repair,
so the version matters somewhat less if it's not too old.

-- 
Chris Murphy
