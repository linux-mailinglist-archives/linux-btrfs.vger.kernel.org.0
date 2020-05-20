Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A649E1DBD83
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 May 2020 21:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgETTBq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 May 2020 15:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgETTBp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 May 2020 15:01:45 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978DFC061A0E
        for <linux-btrfs@vger.kernel.org>; Wed, 20 May 2020 12:01:45 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id u188so4027970wmu.1
        for <linux-btrfs@vger.kernel.org>; Wed, 20 May 2020 12:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nz8pI7+CvZtfz1DVUU1CuN5DLmLipSnRcseAJTFLYNw=;
        b=PDusE6kLzzhvEC5DzHDilKLvOSzOV98XxsjSxoKNWsRkW3t8l8fTErT+bkgI+TmBoD
         ULeSS33LJohHHZry62pkvDWZ3Do6yR2ve8/RyH0SWpKV0IAljByDXF9h+zS5YScXpC3O
         2F0SHxqosSDzox7vlNXAspeYcJwk5AH6bVfigJh3H1wak3pzYHkOknWNekQ0G6G8kI4J
         EXqn9nl83QA39P81UUZOiGEFxidx7rOfuwrJLZYJaMI9bvyEypZ/qldk6/6XFPnH2Yio
         OYcyFbo9NTDwSlkRz7vzn4U1vf47xhY5IimN77b4M9q3v1P5tiJMUUFhMHgb9541MMIQ
         VN0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nz8pI7+CvZtfz1DVUU1CuN5DLmLipSnRcseAJTFLYNw=;
        b=AL7oXlb/0QN6dN9qdG0icrRZrPx9bT0uocKgXnYkeArFnh8o2jbAWXtgBiN9mSVmjH
         Bg3OgdAPrRF3HHP7ln8b1q5QUs/lJBuRE0IxiOEwfpmoWTxDSjOc5YgWIKC2Xy76tihz
         8ztLUtpqVa1Q5XsTONPI/grjo/5qtUQ4TpOAHOA91O4RyxFYefNw3H6de2T7km7ZSn/r
         gJow1a84U+fhE/iAuWSKFrIBOyNypHe8W9wPOIp7+eZBwYBNiIQO6xkgm5HNMKOwyyDh
         CUjD3s+AqEJi44WAgc2yGAck0Xo20VXSmUEA/7tNL3cfdeb4HFkR605AyZXGcHOt48q1
         /T4w==
X-Gm-Message-State: AOAM530tv+ObYgbG7sU0PwHLoXjyAWmeks7vWxl9+OZMPqGE770IxbNV
        p1FM9TZfqrOAd7v0xVKhks9ApVnktJrMNmy7Lf4P93FgxHc=
X-Google-Smtp-Source: ABdhPJwO924wKfy7nuNk/HFptVPT1TyAmgNqO+WXyArpXUQRlyLL0ujkC4CTJkAfi2PTy5kCjtxmS8oEfBIsvOFJQoA=
X-Received: by 2002:a7b:c4cc:: with SMTP id g12mr5667623wmk.168.1590001304288;
 Wed, 20 May 2020 12:01:44 -0700 (PDT)
MIME-Version: 1.0
References: <9d2d57e7-29d9-42c2-be55-fb8ee50db40e@localhost>
 <CAJCQCtQ9HzjjaV20txtoHAWG7tTVWaqdk6wf5QtB5v+w2p4b2Q@mail.gmail.com>
 <f6d9ee8a-c0da-4b19-af3a-3c58c9c1478e@localhost> <343f7aa9-4cff-45b7-8635-4ca19014c4e5@localhost>
In-Reply-To: <343f7aa9-4cff-45b7-8635-4ca19014c4e5@localhost>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 20 May 2020 13:01:28 -0600
Message-ID: <CAJCQCtQi3KZvKGO17YoQ3AroiePjywhhNAFjdKFD0DwL3tkbLg@mail.gmail.com>
Subject: Re: Need help recovering broken RAID5 array (parent transid verify failed)
To:     Emil Heimpel <broetchenrackete@gmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 20, 2020 at 5:56 AM Emil Heimpel <broetchenrackete@gmail.com> w=
rote:
>
> Hi again,
>
> I ran find-root and using the first found root (that is not in the superb=
lock) seems to be finding data with btrfs-restore (only did a dry-run, beca=
use I don't have the space at the moment to do a full restore). At least I =
got warnings about folders where it stopped looping and I recognized the fo=
lders. It is still not showing any files, but maybe I misunderstood what th=
e dry-run option is suppose to be doing.
>
> Because the generation of the root is higher than expected, I don't know =
which root is expected to be the best option to choose from. One that is cl=
osest to the root the super thinks is the correct one (fe 30122555883520(ge=
n: 116442 level: 0)) or the one with the highest generation (30122107502592=
(gen: 116502 level: 1))? To be honest I don't think I quite understand gene=
rations and levels :)

Yeah it's confusing.

I think there's extent tree corruption and I'm not sure it can be
repaired. I suggest 'btrfs restore' until you're satisfied, and then
you can try 'btrfs check --init-extent-tree' and see if it can fix the
extent tree. It's maybe a 50/50 chance, hard to say. If it completes,
follow it up with 'btrfs check' without options, and see if it
complains about anything else.

One thing that's important to consider is using space_cache v2. The
default space_cache v1 puts free space metadata into data chunks,
subjecting them to raid56, which is not great. Since you went to the
effort to use raid1 metadata, best to also use space_cache=3Dv2 at first
mount, putting free space metadata into metadata chunks. It's expected
to be the default soon, I guess, but I'm not sure what the time frame
is.

Also consider using hdparm -W (capital W not lower case, see man page)
to disable the write cache on all drives if you're not certain they
consistently honor FUA or fsync.


--=20
Chris Murphy
