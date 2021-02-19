Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2676031F490
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Feb 2021 06:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbhBSFEu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Feb 2021 00:04:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhBSFEt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Feb 2021 00:04:49 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DB5C061574
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Feb 2021 21:04:08 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id v15so5983810wrx.4
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Feb 2021 21:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AbumKpQLCg2bsYrWXfQvii/76Oo1ZqteIwhqplpjCs0=;
        b=NDk8oLXzEDIUznAqt/KguWKZkyhgJ7Enzp0ERyVXf740RHUQL7q+EUo33sKbq79xCE
         TAgJLp9i9M445By+gK7sM/havGff4dqAUac2aFadEsrsjytD8g0W6o/SFWnHb9v/RSGh
         WVlw702GgtshiqIkXpQdJu3SFfUZ2DymA8tNbi5KyiurWjvjlUu3lvNXfid43DdutIU8
         UiGll4b403b17wa6Nsuii/XnDQzBjYmz/mHT8ZsrdNegjtlYpph0BHFkHyVh23uB+hIa
         CMlfItjvL7io8LVAvilg2cjLThQDNt9NZxLJ2KHB++YaiFOPbQb6jXss3yUh3pv4Nl/J
         3L4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AbumKpQLCg2bsYrWXfQvii/76Oo1ZqteIwhqplpjCs0=;
        b=Qzwfe8bYpTzuvR+poaF51/4Xm93K5D9j18fwLRgPqT1Q9sBAdFfInf8tuDRQfFmfKF
         7vyrCW5JQDOquWOcqOlMyfWEXoppOPPG3b38dwBYakSoNdAtoYOMPlIx63EAqnryUa3s
         /AXLHD8E2R4mGBVUmYohphcB6tx3GF2lXl4Xis9JmA7I/UuaAjo6AlrOfUkzhkuweL7U
         qRoDXydeRkpngBG6B9Y2XeoT75icVDhDKzRHlhA3zxolIWJUzbdfhiABpsf1tTwkB8V9
         TINaRmWs60j1XazKn5qh5bsZiFx1HQPfo1DAx0xykE7Rr9Pja2km4RWoHrfgtOUV3EQW
         tckw==
X-Gm-Message-State: AOAM530+nXIm6BXejdH/sGkom8Xs9C/UYQOdeNPOcEmQQ5k32DkcCz8S
        aF6qkPmdV3U0yI7WUgvtdi51nkb6CVfDDTrM0z8X8g==
X-Google-Smtp-Source: ABdhPJwo++4YtsfCJdoYiYkRZQbyhqqs8FahR/tjVr0CSBrhcPpSq65Bn90O7nBGD4KA178wHYbfw4vhR89xbGUEKfA=
X-Received: by 2002:adf:a2c7:: with SMTP id t7mr7271386wra.42.1613711047499;
 Thu, 18 Feb 2021 21:04:07 -0800 (PST)
MIME-Version: 1.0
References: <83750bf0-19a8-4f97-155c-b3e36cb227da@gmail.com>
 <CAJCQCtQGyHJjPwmKxwxCBptfeb0jgdgyEXF=qvGf-1HBDvX1=w@mail.gmail.com> <80058635-0bd9-05cc-2f5e-b4986a065be3@gmail.com>
In-Reply-To: <80058635-0bd9-05cc-2f5e-b4986a065be3@gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 18 Feb 2021 22:03:51 -0700
Message-ID: <CAJCQCtTCKSC46kNaoENdEpCNTxB1_MeD6PHwbmtRnJdbGWBswA@mail.gmail.com>
Subject: Re: corrupt leaf, unexpected item end, unmountable
To:     Daniel Dawson <danielcdawson@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 18, 2021 at 6:12 PM Daniel Dawson <danielcdawson@gmail.com> wrote:
>
> On 2/18/21 3:57 PM, Chris Murphy wrote:
> > metadata raid6 as well?
>
> Yes.

Once everything else is figured out, you should consider converting
metadata to raid1c3.

https://lore.kernel.org/linux-btrfs/20200627032414.GX10769@hungrycats.org/


> > What replacement command(s) are you using?
>
> For this drive, it was "btrfs replace start -r 3 /dev/sda3 /"

OK replace is good.


> > Do a RAM test for as long as you can tolerate it, or it finds the
> > defect. Sometimes they show up quickly, other times days.
> I didn't think of a flipped bit. Thanks.
> >>         devid    0 size 457.64GiB used 39.53GiB path /dev/sdc3
> >>         devid    1 size 457.64GiB used 39.56GiB path /dev/sda3
> >>         devid    2 size 457.64GiB used 39.56GiB path /dev/sdb3
> >>         devid    4 size 457.64GiB used 39.53GiB path /dev/sdd3
> >
> > This is confusing. devid 3 is claimed to be missing, but fi show isn't
> > showing any missing devices. If none of sd[abcd] are devid 3, then
> > what dev node is devid 3 and where is it?
> It looks to me like btrfs is temporarily assigning devid 0 to the new
> device being used as a replacement.That is what I observed before; once
> the replace operation was complete, it went back to the normal number.
> Since the replacement didn't finish this time, sdc3 is still devid 0.

The new replacement is devid 0 during the replacement. The drive being
replaced keeps its devid until the end, and then there's a switch,
that device is removed, and the signature on the old drive is wiped.
Sooo.... something is still wrong with the above because there's no
devid 3, there's kernel and btrfs check messages saying devid 3 is
missing.

It doesn't seem likely that /dev/sdc3 is devid 3 because it can't be
both missing and be the mounted dev node.

>[  202.676601] BTRFS warning (device sdc3): devid 3 uuid 911a642e-0a4c-4483-9a1f-cde7b87c5519 is missing

Try a reboot, and use blkid to check you've got all devices + 1 (the
new one that failed replacement). Verify all supers as well with
'btrfs rescue super-recover -v' and that it all correlates with 'btrfs
filesystem show' as well.

What should be true is the replace will resume upon being normally
mounted. But for that to happen, all the drives + 1 must be available.

If a tree log is damaged and prevents mount then, you need to make a
calculation. You can try to mount with ro,nologreplay and freshen
backups for anything you'd rather not lose - just in case things get
worse. And then you can zero the log and see if that'll let you
normally mount the device (i.e. rw and not degraded). But some of it
will depend on what's wrong.



-- 
Chris Murphy
