Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0F1812CB4F
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Dec 2019 00:12:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfL2XLz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 29 Dec 2019 18:11:55 -0500
Received: from mail-wm1-f48.google.com ([209.85.128.48]:34547 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbfL2XLz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 29 Dec 2019 18:11:55 -0500
Received: by mail-wm1-f48.google.com with SMTP id c127so10582491wme.1
        for <linux-btrfs@vger.kernel.org>; Sun, 29 Dec 2019 15:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=THryYSdGjfStS1b218ESt5GbaOA5WU+UdN6/mNDplTA=;
        b=a0wSqh3vMAP7Vaxl3q3zcDM7nV8pY0PlwhdHP/i23QGkcFF8vS572NYPbbUGxYUx7V
         Cy/Iu2O6a5y+VyBE24T7P+roiV/WOXXKzAF+XSwcpBEcBf4KLUHUxyNZ9pQN5B5NXTqK
         1j7q5P22SOAop2NqI+2A/gserZ6OL8iQHaUMppSt/S6BzoWBmCy8SbeYMX5v7EkHS10r
         q80vIeFq1VlRQKFMGHsSckSdYvrZ5PT4rkzL3p0Kxfj5HhuQkRTl4q91rTtEqe8lNuCN
         wCFHW0nmZXbMXQJXeUCq52AutFY8EHLA7ASlkJ1j1L55MSMeyFWuOpJvCrnUKpT15B5k
         i86w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=THryYSdGjfStS1b218ESt5GbaOA5WU+UdN6/mNDplTA=;
        b=Rx9AzZBDCFbvwDGqTGTv9h8j0OXykDtIkRBqy1hz4HHl35DVap3E7z489q7YUpF53J
         ych8hxHMwblXaC5eGHdYy2qeLhWTVzqISs2GZlTEOvdHIdJA02Dy7hAiI2iIereJsI2I
         zZISbi9pDMReEnHkJm8XBmyRZZgBZo7dMWobUirM57tYvFxJ1Skx1ZKOkEgT+Yd4qNu7
         m1UJSYHOMHwlJeCc4JY6JSEElx0FNODcqWgbvSH+1GzpPLC0uQOO85k2hs96lUmGQKu3
         LKmj/VLtnYi2Vfd9UgNqanbSJ/H6l+yRxi/eaOqK+g1IjHSo0TLDJcliiTbvZ7+6/BvG
         RAhw==
X-Gm-Message-State: APjAAAXqkenkatPI7tovoVhedFz+cfQpvdgumS/VhBzD/QcAZVVLDOiS
        JKnL9yLnD43oS5ViPjyz+IBmnzyBpc4A+rtqMtkAvA==
X-Google-Smtp-Source: APXvYqxoI36BEOmwOjCnbhaBUtc4hFB3L0uFniYIls3Z8yOcOENadZJce1vY0musujlUe4V4GuZqwUF78l91Tdv6UEY=
X-Received: by 2002:a1c:4d03:: with SMTP id o3mr31489305wmh.164.1577661112869;
 Sun, 29 Dec 2019 15:11:52 -0800 (PST)
MIME-Version: 1.0
References: <CAOB=O_jxu5JOe=JiYVW_VZ1rgs9+mdHpAHkscXkc4MVRLrBKDw@mail.gmail.com>
 <CAJCQCtQwLrZxfc7xb8FpVcV9r9rpEpD0SRPebRtRpS5SPYM_3A@mail.gmail.com>
 <CAOB=O_hLvVaSdnvXwFeC5h6=AySnb4Fh9Fzx-zjFmw92odSLzQ@mail.gmail.com>
 <CAJCQCtQogopy56foRdqb6+3ejYL=gofVyYKwoAWFjYRgyaVZew@mail.gmail.com> <CAOB=O_jmoMJ=Tt7wRqv6btofDQCxefYC7LaNKye7MOiQ98Djbw@mail.gmail.com>
In-Reply-To: <CAOB=O_jmoMJ=Tt7wRqv6btofDQCxefYC7LaNKye7MOiQ98Djbw@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 29 Dec 2019 16:11:36 -0700
Message-ID: <CAJCQCtTBFeBLA3DhwyHqXmkQ6KCSkZaj7e8KGY8q5TU7Fi1PAA@mail.gmail.com>
Subject: Re: read time tree block corruption detected
To:     Patrick Erley <pat-lkml@erley.org>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Dec 29, 2019 at 3:36 PM Patrick Erley <pat-lkml@erley.org> wrote:
>
> K.  Gotta roll a new initrd with btrfs 5.4, then will reboot into it
> and grab logs of btrfs check (both iterations, against each of my
> volumes).  Probably be a few hours, so don't expect another follow up
> until tomorrow.  Thanks for chiming in.
>
> Would it be worth creating an image of the drive while I'm in single
> user mode for faster analysis/iteration?

Depends on the developer who replies. These days they usually just ask
for selected dump-tree output. The image might be useful if you can't
wait and want to blow away the file system and start over sooner than
later.



-- 
Chris Murphy
