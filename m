Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC2CA488A9F
	for <lists+linux-btrfs@lfdr.de>; Sun,  9 Jan 2022 17:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234237AbiAIQiJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 9 Jan 2022 11:38:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbiAIQiJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 9 Jan 2022 11:38:09 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1303BC06173F
        for <linux-btrfs@vger.kernel.org>; Sun,  9 Jan 2022 08:38:09 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id i3so31852724ybh.11
        for <linux-btrfs@vger.kernel.org>; Sun, 09 Jan 2022 08:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VFR5kZGPcI8EHNmofKcBohcDRBqDojWotp0YP27NPHI=;
        b=1y4sET0Je4mH6fzKKNveAHSsKZnBVRE+JcoRB9aOwyQGkRANY+iRQ6JxBRhEQPIL1w
         Z71/j+J3lJgqt+ovA9RTIdjPvIOHNWBpr9kpCZbn9Q9hdB/5eEFcTU4jQfj4LmIxeTU8
         BUYyl0z+Hfu4z2KUWwSTqTpYvrfn056kusPqX8KoDbq6hCu73/9U+IIQ944G9hY+Dngc
         0z97uhgT6wIe3I0c9eunnUeqjUB1mKkWEJzRmTKSFIkJIemEnBGL4FSkQGCweuWvw8bY
         1uIGAs3lzv7te9kpsNzAMXCgktrBILseO6uERJ+2cBoQNGbUynMY7f6wbQJTEARqDp8c
         eZng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VFR5kZGPcI8EHNmofKcBohcDRBqDojWotp0YP27NPHI=;
        b=ZR1P9QiIidvBi9SSBF504pRsNkJgOIf2X9CiIBoz2RUl5LgAF/0bopEHTIcPc4r/Ux
         fTiemagwgKfnwdc7js9cIIzSPR91Cuz/DPmwBYYGXGMgG0EtB56ao50nCQu/hpXVt3IY
         ZqwpVgRp+p0mbVjtyXBBb26oERmdLws8rVFxuhoxfTeBa6py7XLpN5nJGgFNTTxmR2yr
         J45/ZVDVqfD7Mq43WW+TILNzKl8L/slcUOW/yEk1NZX3g1FlIbPNWtY8aSVDylf75t23
         N57FIq79SPWOeBQLLMW/9gS0w94ShrHDo5sKAvcKTeKOMhPe4h2gRH+i2ALWeo63Te0j
         ta7Q==
X-Gm-Message-State: AOAM531ZFuwAzTXLx6H65Ah4XgQ8F8Va/MUBSL3ZT5vkU1Kr1/Sh2wy2
        kZhgf7jUuu9DCpyIXBjT3Yr0y3kKRI7bALgXBFIV/AzL/aBj1O2f
X-Google-Smtp-Source: ABdhPJzB4a5O6kIVnMOAKT310Ou1R/YMKFOvYVuC1Blfi7kgVgJVaoeJwG9S7v+ByHEshYxSn3aMByiE61B5l7jmRDQ=
X-Received: by 2002:a05:6902:110:: with SMTP id o16mr11675395ybh.385.1641746288215;
 Sun, 09 Jan 2022 08:38:08 -0800 (PST)
MIME-Version: 1.0
References: <42e747ca-faf1-ed7c-9823-4ab333c07104@georgianit.com>
In-Reply-To: <42e747ca-faf1-ed7c-9823-4ab333c07104@georgianit.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 9 Jan 2022 09:37:52 -0700
Message-ID: <CAJCQCtR6_65_38PFp49_0HuH5-zd5Sf7C-B8tyYQ4oGNKNg0-A@mail.gmail.com>
Subject: Re: Case for "datacow-forced" option
To:     Remi Gauvin <remi@georgianit.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 7, 2022 at 6:30 PM Remi Gauvin <remi@georgianit.com> wrote:
>
> I notice some software is silently creating files with +C attribute
> without user input.  (Systemd journals, libvert qcow files, etc.)... I
> can appreciate the goal of a performance boost, but I can only see this
> as disaster for users of btrfs RAID, which will lead to inconsistent
> mirrors on unclean shutdown, (and no way to fix, other than full balance.)
>
> I think a datacow-forced option would be a good idea to prevent
> accidental creation of critical files with nocow attribute.

libvirt sets file attribute C on the directory specified at the time
of pool creation. You can unset it and it won't be reset.

systemd defaults to nodatacow on Btrfs, but you can `touch
/etc/tmpfiles.d/journal-nocow.conf` and then also recursively remote
file attribute C from /var/log/journal

I know that zoned disallows nodatacow, but I have no idea what happens
to files being copied over with file attribute C. Does the entire copy
fail or just an error when trying to set chattr +C on the file while
it's still zero length.



-- 
Chris Murphy
