Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 153113433FC
	for <lists+linux-btrfs@lfdr.de>; Sun, 21 Mar 2021 19:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbhCUSEQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 21 Mar 2021 14:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbhCUSDw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 21 Mar 2021 14:03:52 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13C5C061574
        for <linux-btrfs@vger.kernel.org>; Sun, 21 Mar 2021 11:03:51 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id c8so1418584wrq.11
        for <linux-btrfs@vger.kernel.org>; Sun, 21 Mar 2021 11:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=34my5uGmzHOI0JnurbTHPkpYWOjsiN0HqHHFPcX0qJM=;
        b=F+K0pZjGa9+fLJog6efVwIh66WVsSJd7RV8cjU2gnw2rS+ABkOW8U5wCQ5Z4YuhNUI
         Kszk1jqi+WRoSz3WyQwVzuzM7LzTmTMx/b2605+dO3Ww86X3lRN2TFyqLGpQHrsDUL+m
         azk023moOOpcjYKQ0yKg5lqztYZbydj+NkpDAgQEAWiUabhxjAvszLe+Ee52IWKKMcuA
         EQn2oMFVpYqtjc2gnjOScqNZhHF7FBb+H4hXoYS6Co+Mj/ChMF398vE2PuouNm1zXOqR
         K+3nXd9yC/nOMT8X2dN+tiGEVLWQJCC+MTesJERoNWH+rHJptI5tIUq9PxKMg6orW3+2
         c30Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=34my5uGmzHOI0JnurbTHPkpYWOjsiN0HqHHFPcX0qJM=;
        b=QP4qmx7zk8/8XME0kyP91KSWhEbMuESZ+l/bh90LJoFjsq4zgCmoiuCXx6qgyJn3GS
         hZY22RN6wEW2jbNegidJEbHg+NzJ7cwm2Nc9hAObrAOVon60/kJGBuO+sMDn6xLEHyBO
         L80wZ9oZ7zDe1kn/QOGxB1+UYe52o971t/tFs4WIYeNl33xQJnaXbxQpES8nju2AqnZZ
         e5nnp4EyiUHDDxaJKYSQWFLOCORICPKxORZ/+3IQG4CsXcw+fCobJkBQQYqHtiGruLzl
         Hg0SW+aE9oix74aS5Nk0usOwxbCBmq5EKC1b1bHBOm3H81iBZDTwABH3U6iTcVxlZvDI
         KnRw==
X-Gm-Message-State: AOAM530bCGKrvVq+XTGmGxI4w6TU//pBY6533Q+rxYaSQ0UCVJPR+VgQ
        HhdkBXssgCQJpmsCGG52VIDD2tfxJY11AIq7v47Pbw==
X-Google-Smtp-Source: ABdhPJwmck9MNEs8beL+RcQPUi+ece3S/1CIOwagM3+s4DBuR+8+ZfbClIpkX7hY6XhXJR+Gvomi53STjheVZDRXR+c=
X-Received: by 2002:a5d:42ca:: with SMTP id t10mr14430578wrr.274.1616349830576;
 Sun, 21 Mar 2021 11:03:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAGdWbB6JtU54uEOotj=H-DG_7oeUT5KZQG5uM-ibiC2YDbV5Nw@mail.gmail.com>
 <CAJCQCtSBc-Dmks2jdgr-Bcpdh_iLvVevtGOa4LdYgHc2eZE6Hg@mail.gmail.com>
 <CAGdWbB4dN45=4T_WbF7tXmm2UsmF0bh=Lb_z-H=QVQWaW=C=Bw@mail.gmail.com> <CAGdWbB61y3CXTbSxe9Rc7ijs9vsLg7qcX4JZ_WpW-73m_1-6_g@mail.gmail.com>
In-Reply-To: <CAGdWbB61y3CXTbSxe9Rc7ijs9vsLg7qcX4JZ_WpW-73m_1-6_g@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 21 Mar 2021 12:03:34 -0600
Message-ID: <CAJCQCtRyhh6AY25+RwikJKk_HUW1xveVxYzGvPpFDdWq618KUg@mail.gmail.com>
Subject: Re: parent transid verify failed / ERROR: could not setup extent tree
To:     Dave T <davestechshop@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Mar 20, 2021 at 11:54 PM Dave T <davestechshop@gmail.com> wrote:
>
> # btrfs check -r 2853787942912 /dev/mapper/xyz
> Opening filesystem to check...
> parent transid verify failed on 2853787942912 wanted 29436 found 29433
> parent transid verify failed on 2853787942912 wanted 29436 found 29433
> parent transid verify failed on 2853787942912 wanted 29436 found 29433
> Ignoring transid failure
> parent transid verify failed on 2853827723264 wanted 29433 found 29435
> parent transid verify failed on 2853827723264 wanted 29433 found 29435
> parent transid verify failed on 2853827723264 wanted 29433 found 29435
> Ignoring transid failure
> leaf parent key incorrect 2853827723264
> ERROR: could not setup extent tree
> ERROR: cannot open file system

btrfs insp dump-t -t 2853827723264 /dev/

> It appears the backup root is already stale.

I'm not sure. If you can post the contents of that leaf (I don't think
it will contain filenames but double check) Qu might have an idea if
it's safe to try a read-write mount with -o usebackuproot without
causing problems later.

> > What you eventually need to look at is what precipitated the transid
> > failures, and avoid it.
>
> The USB drive was disconnected by the user (an accident). I have other
> devices with the same hardware that have never experienced this issue.
>
> Do you have further ideas or suggestions I can try? Thank you for your
> time and for sharing your expertise.

The drive could be getting write ordering wrong all the time, and it
only turns into a problem with a crash, power fail, or accidental
disconnect.  More common is the write ordering is only sometimes
wrong, and a crash or powerfail is usually survivable, but leads to a
false sense of security about the drive.

The simple theory of write order is data->metadata->sync->super->sync.
It shouldn't ever be the case that a newer superblock generation is on
stable media before the metadata it points to.


-- 
Chris Murphy
