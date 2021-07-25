Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4E513D4B39
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Jul 2021 05:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbhGYCyM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 24 Jul 2021 22:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbhGYCyL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 24 Jul 2021 22:54:11 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0C6C061757
        for <linux-btrfs@vger.kernel.org>; Sat, 24 Jul 2021 20:34:41 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id j6-20020a05600c1906b029023e8d74d693so4045314wmq.3
        for <linux-btrfs@vger.kernel.org>; Sat, 24 Jul 2021 20:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=liUCJ3ymAhCfuIY4sGlaXHFTRX3wyXAIRM0uO6AXVow=;
        b=JIkz/47oyRqcWuFh+Kikrl9fLJx86DuSN6yXUGGJFxZ51OU89SU2Vt45nitSrRWI9A
         tchh75DZSaEvZHYN/5Ou31yIH6EqN1bv9tAR0vztpgaC/uKddyY+/RK1xXWWMKrHcCz5
         lSGMV21loa0QQXXkBsVpL0LX37QC3RXYVnmu0Qz89nqqdMmuyWzYD2zz629199FG8dZF
         X/5QevWM1dqYMQgyL3EZNQQd7jFd9Xn9LtoIdVSJlKN8IDS2oYNC3zOkySGRN/muZJfh
         iNyPZlVj/ma8pZI55ZqcMNyy0qmU04DR22KIraj6Ln+yQNvmu3x0LSuS27HK161HC3/7
         8pxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=liUCJ3ymAhCfuIY4sGlaXHFTRX3wyXAIRM0uO6AXVow=;
        b=a419ML1oa+q4CMILMIoM8uHBmZGVsH5dD9jvNMpDWuqv5KABEuKGAuP4XJWY9D4SFv
         206Ko6HgHqRgPpQMKZW7xUjDof7yqHDFPujds9v1OTCzYWbLE3lzZgwV26cofR1a1B44
         +z01E9TcaCs2hbiv/BAWHxQ8fKI2//p0t4gqTuXnYm3JJcB9YKZ5TwVra6w7RbO402/3
         xP6siVOPB9bdgGkQD6y58DZbgaVWT5n30kV6Ohoc+G2A2XOT6qqSNO9pFWEb2uAFek0i
         uc+jNoHI+3m6M+st/5Qx2RcK3MjDpL8uleH6m+yNU2sLXe7FTMiSSgMFh4ysoZYF9Pf9
         ZYLg==
X-Gm-Message-State: AOAM530aK6+/Yr5d2v6YtWbRocO0aran7lG9xZ9dNwtMoHmU5e/Dgjti
        PeRhZYkdAi1Y2Ej6bMTdvSB9J67V3jUZ7xuptkgtEQ==
X-Google-Smtp-Source: ABdhPJyNINsUj+TIUNtuHUmTKnDZtx1mimuUcZ6RgCWP6U//lt0IfvYOMNezb51fxludUDqnBUcmflNrJ2nu9U2ZAa8=
X-Received: by 2002:a1c:2b04:: with SMTP id r4mr8170977wmr.168.1627184079494;
 Sat, 24 Jul 2021 20:34:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAHzMYBT+pMxrnDXrbTJqP-ZrPN5iDHEsW_nSjjD3R_w3wq5ZLg@mail.gmail.com>
 <20210721174433.GO19710@twin.jikos.cz> <8b830dc8-11d4-9b21-abe4-5f44e6baa013@gmx.com>
 <20210722135455.GU19710@twin.jikos.cz> <20210724231527.GF10170@hungrycats.org>
In-Reply-To: <20210724231527.GF10170@hungrycats.org>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sat, 24 Jul 2021 21:34:23 -0600
Message-ID: <CAJCQCtSc8x3xLKb2yyBchgvMn-0ecGi56CEDtQcFD74WyEOzUw@mail.gmail.com>
Subject: Re: Maybe we want to maintain a bad driver list? (Was 'Re: "bad tree
 block start, want 419774464 have 0" after a clean shutdown, could it be a
 disk firmware issue?')
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     David Sterba <dsterba@suse.cz>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Jorge Bastos <jorge.mrbastos@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jul 24, 2021 at 5:16 PM Zygo Blaxell
<ce3g8jdj@umail.furryterror.org> wrote:
>
> SSDs are a different story:  there are so many models, firmware revisions
> are far more diverse, and vendors are still rapidly updating their
> designs, so we never see exactly the same firmware in any two incident
> reports.  A firmware list would be obsolete in days.  There is nothing
> in SSD firmware like the decade-long stability there is in HDD firmware.

It might still be worth having reports act as a counter. 0-3 might be
"not enough info", 4-7 might be "suspicious", 8+ might be "consider
yourself warned".

But the scale could be a problem due to the small sample size.



-- 
Chris Murphy
