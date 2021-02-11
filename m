Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCD031841D
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Feb 2021 04:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbhBKDxo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Feb 2021 22:53:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbhBKDxm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Feb 2021 22:53:42 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB3AC061574
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Feb 2021 19:53:01 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id u14so3877173wmq.4
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Feb 2021 19:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+NlD/tZ31KVpEgbfyyvAU7j8b6l3z78lDmvqrMElvSU=;
        b=m8wqN1/e70zwmY6NyYuJRHsO8xzlCZfB0N71R0aA3L1l4KaQTqg9C+QiYfLVVjFt/A
         I4M8H+GMbk1ECoIkXVo1tWx0fcJUZ/nBdn1n1bekjky1ZAdwCSPYLXjngi+qwBB8ACQT
         +8r+eQ3ZWAoOSf0QiHDPBQyfVv/bcfHTUSy69y/nFptk2WQ7eA6IvftsoZF+c5mCDTKp
         YYGONPlDjG9Byps6eNPe9u6Lm5wVi+d9rbSIAuGgUGtBza9nXkDO8ZIuGvY4z4LJdM+q
         hqqXLxuJVsak9ufRvusvhtSs9mzbXA1l0AMnd2bmj8Paf0JpQ+9NhUenw9o/bSjFGyU4
         r98w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+NlD/tZ31KVpEgbfyyvAU7j8b6l3z78lDmvqrMElvSU=;
        b=qVGXTCqjTZOUrBGxFxSPrqIEhxcosMS8Kv103oVwvoiQ+RaGBIn+Qm8m8q2JAIciYQ
         Muj3T+9GYTg0Q2xVYHt9LbDEdZAJLXvvAyk/oQJ/1mfZZ4c06gT+Zs7qIbDSvRkaPPn6
         WnAgiC1ak7TwUXWpDbUU8fjjaFT3s0fd7KqtOAmNVeejMJ5dJETpfYmaKueVtpP4H8FT
         tvpGWGBW92QpXAurMVxFh0HDGTX6m5GtutOWlhmZSTfdL7xahZdp62WoETbn7E6rjTEo
         +71/dP19KvoXwirxBMhk94+01N5i8q4u4BksLVR+BCKVoT9t7wlQMzuLyDZCPrc8tvWi
         sxzQ==
X-Gm-Message-State: AOAM531iEZ5pKTmpESSkpV6PCbaB6nSKva21/6wg2lflHUtXi+7LPi2B
        ue50rqBq0wkZkg58aOfEyz3Vbkt0qXQtgqhcaln4rg==
X-Google-Smtp-Source: ABdhPJzOrwqj6jBYoheUNU/llo1OwQPgKpn1IqDU1Ohv97wB5todBKA8WKRMXW2BxhrwRm8uXH0RNCHyOI9DDy8Gk1E=
X-Received: by 2002:a7b:cb58:: with SMTP id v24mr2759612wmj.182.1613015580706;
 Wed, 10 Feb 2021 19:53:00 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtSx=HcCRMiE0eganPWJVTB+b4zfb_mnd68L2VapGGKi7Q@mail.gmail.com>
 <3897f126-e977-d842-f91d-b48b74958f3d@libero.it> <CAJCQCtScUYMoMpw==HTbBB6s0BFnXuT=MvSuVJYEVBrA7-RbHA@mail.gmail.com>
 <839d9baa-8df5-7efd-94ee-b28f282ef9ec@inwind.it> <CAJCQCtSqESuYawuh6E8b6Xd=z4D13J2=v-6rn8+0mwuThXNtkg@mail.gmail.com>
 <7650c455-297a-f746-c59e-3104fdbf8896@inwind.it> <CAJCQCtR1fCSFYYbo7YvDPTmhALNvUyZB5C4zfMsUH-iU0xs6zQ@mail.gmail.com>
 <CAJCQCtSqvv6RRvtcbFBNEXTBbvNEAqE9twNtRE=4sF9+jcjh9A@mail.gmail.com>
 <4b01d738-5930-1100-03a4-6f1b7af445e5@inwind.it> <20210211030836.GE32440@hungrycats.org>
 <20210211031306.GL28049@hungrycats.org>
In-Reply-To: <20210211031306.GL28049@hungrycats.org>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 10 Feb 2021 20:52:44 -0700
Message-ID: <CAJCQCtQ80jPFPduRqTcLhbSx+UzdaoKg8b5HeveaL=mESV9s8g@mail.gmail.com>
Subject: Re: is BTRFS_IOC_DEFRAG behavior optimal?
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Goffredo Baroncelli <kreijack@inwind.it>,
        Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 10, 2021 at 8:13 PM Zygo Blaxell
<ce3g8jdj@umail.furryterror.org> wrote:
>
> > At file close, the systemd should copy the data to a new file with no
> > special attributes and discard or recycle the old inode.  This copy
> > will be mostly contiguous and have desirable properties like csums and
> > compression, and will have iops equivalent to btrfs fi defrag.

Or switch to a cow-friendly format that's no worse on overwriting file
systems, but improves things on Btrfs and ZFS. RocksDB does well.


-- 
Chris Murphy
