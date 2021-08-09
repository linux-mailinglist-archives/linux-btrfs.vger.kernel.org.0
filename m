Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1052B3E3F1F
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Aug 2021 06:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233017AbhHIEuj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Aug 2021 00:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbhHIEui (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Aug 2021 00:50:38 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DEBDC061760
        for <linux-btrfs@vger.kernel.org>; Sun,  8 Aug 2021 21:50:18 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id f9-20020a05600c1549b029025b0f5d8c6cso13549571wmg.4
        for <linux-btrfs@vger.kernel.org>; Sun, 08 Aug 2021 21:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qfQO4Bp1Wp9jVOCzXPtgiY9weuvyZ8A+ZumObNVInTs=;
        b=zbtnIdA22VoCI/GQNrc4hN6MT72ffXGztqgcOV/ZRE0Jz/w5EPr6a+BQt7oHsnK0MT
         /el0TjeVlutDYTuONwwqeWW4TQ0Lb4mE5EU4WtUBg3L0ne2dvVPDJVzDTxaYdS4Bzagk
         pHhtOC52dnb8iQD8WHIGm6CCVujDmcttkb3DPcWoTd0mMg7Pqclw4XALHqWUOdIfWIL7
         zK+0ZivGD8+bhxJcqkgNa+e7TjSQYW8f0Oj7Us80P3P87uX7KGwUbv/OBmYSv0uj3Rk3
         aPnuPwFsFAkangIzh2nXn6LEaMTzZZDkAsQqJllamRwEivEtNEyf8pAiMcQRGuZE/LuR
         9jLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qfQO4Bp1Wp9jVOCzXPtgiY9weuvyZ8A+ZumObNVInTs=;
        b=rQoDxDYThJxl6PiJXegERCWvo93mM0OP2sQGlzvBiDW9L3nhFneP/GEsPaTB2SW21l
         DQTLA/LMgC2e0ofdE/4nkp42qUhn1U2YiC0pZ5DLDheD+1QMiScy5E91zqxlhAG5VdGn
         HCouBe2Tin8DAJfHOLjzeEGlfryO9Pic1pk52ZUg/SAhpDXIaLv2AGQX2e31f/b6NOFS
         f3vG/+dqlbtVpanAnnVkfo6JOUe8CIFaeiyc+1r6l4vFtHYNGPt3GoZDIJI8eQ1hQjaL
         AlT2+0cMvgTJAwYrtoj5cGCvkisVegTRuoHELK/X+w2GTW/+9aE+cBpLtl4Bx40m+W2i
         rW6Q==
X-Gm-Message-State: AOAM530y7qdVpMOhJEP0n4+V4eSaTc6QPtdJLEFIzJdRNzjswi7i4Kui
        EgHgMfXFUox/M36Bez9wcJszTIwpBrtVKYkW82wcLw==
X-Google-Smtp-Source: ABdhPJx7hCVrTOWO13rnDR3gbNzA+G7ILRM8/xm4LKfIMBcW1e/+wgGHRlzl4Os17dkXWGWLlNGIK8rKa6UK0Vvlte8=
X-Received: by 2002:a7b:c396:: with SMTP id s22mr14351831wmj.11.1628484616466;
 Sun, 08 Aug 2021 21:50:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAGdWbB59ULVxpNnq5Og0SCri+qyz_cwDLFTLr5N7iVT9gb0w1A@mail.gmail.com>
 <87eeb7pysj.fsf@vps.thesusis.net> <CAGdWbB5+UOxxF21JxbzvVP3F-0zhDF4rpBc820fmc54Hyv-5WQ@mail.gmail.com>
 <YQ8eH/SuXpF6p0b6@angband.pl>
In-Reply-To: <YQ8eH/SuXpF6p0b6@angband.pl>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 8 Aug 2021 22:50:00 -0600
Message-ID: <CAJCQCtQ52Pa5yZ8TYDpZfuNSxwxbjdcTNhXBthq+C+no5gTp9A@mail.gmail.com>
Subject: Re: why is the same mount point repeatedly mounted in nested manner?
To:     Adam Borowski <kilobyte@angband.pl>
Cc:     Dave T <davestechshop@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Phillip Susi <phill@thesusis.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Aug 7, 2021 at 6:25 PM Adam Borowski <kilobyte@angband.pl> wrote:
>
> On Thu, Aug 05, 2021 at 04:41:03PM -0400, Dave T wrote:
> > On Thu, Aug 5, 2021 at 1:49 PM Phillip Susi <phill@thesusis.net> wrote:
> > > Dave T <davestechshop@gmail.com> writes:
> > >
> > > > I'm using btrbk via a systemd timer. I have a daily and hourly timer
> > > > set up. Each timer starts by mounting the btrfs root, performing the
> > > > btrbk task, and unmounting the btrfs root.
>
> > Not exactly... that path should not be unmounted. I do not mount that
> > location explicitly for the btrbk tasks. It is mounted when the server
> > boots up with the bind mount line I showed in fstab:
> >
> > /var/cache/pacman       /srv/nfs/var/cache/pacman       none  bind  0 0
> >
> > It should not be unmounted (or remounted) just because the top level
> > btrfs volume is (un)mounted for btrbk tasks. That's the part that is
> > confusing me.
> >
> > There is no command associated with my btrbk tasks that mounts
> > /srv/nfs/var/cache/pacman (or /var/cache/pacman). There's no other
> > entry in fstab for it except the bind mount I showed.
>
> I've seen systemd randomly mount and/or unmount filesystems listed in fstab
> when their state somehow differs from what systemd thinks should be (which
> can happen either by you or a program doing a mount, or due to systemd
> misreading the state reported by the kernel).
>
> So I wonder, can you test with an init/rc other than systemd?

We just need logs, systemd will put a message that it's mounting
something into the journal: journalctl -b --no-hostname | grep mount


-- 
Chris Murphy
