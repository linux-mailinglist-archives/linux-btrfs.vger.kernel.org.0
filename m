Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE4CA771D5
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2019 21:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388387AbfGZTGc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Jul 2019 15:06:32 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40393 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388306AbfGZTGc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Jul 2019 15:06:32 -0400
Received: by mail-wr1-f67.google.com with SMTP id r1so55453923wrl.7
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2019 12:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=67O98rHEEh5oOE0+SKgwgR/F2WncUVVjC5D10v2GtxI=;
        b=m3Kigfgb6IOLZkxu/o+rw02f1WmLpGS9ugl9s+Hvye6y0Bq/iq8ZZ0Hu0lXhLvfmzR
         PYGZSt7GHdYRaVX8jGk43o7Ub4ONnCWWHnLryzsSQIo2enVoVYlY3bPA7p43+4/ivvAY
         1HKey8x5AbagHVuyrLdxFEai0UCs0c96NKN4shqwpq96wKC3q93l3KrKKYqIT4ndI5mh
         /8J8P3WJ2OVlQ7pEoONmEwuKppXAkT4Sp/pcAuoVMphVziZOvuzFWj0pQkd+XwVCIj1Z
         huB0+Xqhz7npcrRGJsQdWiE9ML0hGZ/41pNO06i3fT2by7SWkPdJEPnXdt0S0fEhHDzS
         9pCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=67O98rHEEh5oOE0+SKgwgR/F2WncUVVjC5D10v2GtxI=;
        b=D+jIhmeG1J9+WRsqL9IZ7FdY71DqjKdYNyPl5FgyT8U51b0Gq07CDRP54D/TxrCpsq
         qfHMoDcJCW3H4OsUGnta8L+Guo3R37YONnihi9wakEPpT/+PsPvWxyb5tOG0T4No5i55
         aM1o9YWcVhoAFyNMIi7dVLQ41YHKIUUpbSogMgyEqS+bLxA3SMlMQxJC4xMoqQZT/Et6
         WV3QJ2BTxYKKw2ovnUm6dsQbM2NZMkFy50jxzSQWKoHBr8x10BNKetpnnJ7Mh9pFa1bT
         JxxJYNwFgrwyfcB7h2zhK9Lv/PSfYX/engPbS50bMpBnqLmFSyOXzZSd4B/Qv1gU3NPe
         OC3w==
X-Gm-Message-State: APjAAAX8AT2FIuh7bjSWrJna1cxZ6E0m2eHsDKl7xUE66GehA9A/SwLd
        aztDmBjD1ADyT6vA7fJVQNRZ0NBZB3fEYeQxJfk=
X-Google-Smtp-Source: APXvYqwGQ8/hgf5jl/8omGQvDvb9+1gBzidmKWqD7MLjE7OWGMOubFXxg43yk6V/Jok4AgazOOd3VqfNU96N7ltstdM=
X-Received: by 2002:adf:dd01:: with SMTP id a1mr13844067wrm.12.1564167990522;
 Fri, 26 Jul 2019 12:06:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190703135405.kwzg2am7voldx7ac@macbook-pro-91.dhcp.thefacebook.com>
 <20190703211210.GJ16275@worktop.programming.kicks-ass.net>
 <20190705134727.q62geiy4sniol4gg@macbook-pro-91.dhcp.thefacebook.com> <CAJCQCtTs-Lag_r-e6FEw1nRug3qymry15XBDjD_Rtv0QXdG05A@mail.gmail.com>
In-Reply-To: <CAJCQCtTs-Lag_r-e6FEw1nRug3qymry15XBDjD_Rtv0QXdG05A@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Fri, 26 Jul 2019 13:06:19 -0600
Message-ID: <CAJCQCtT3reeTf9ZYygSJZZGBMTY27TjS0gNgUp=G-rhO7E2FVw@mail.gmail.com>
Subject: Re: Need help with a lockdep splat, possibly perf related?
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 26, 2019 at 10:56 AM Chris Murphy <lists@colorremedies.com> wrote:
>
> Looks like Fedora have run into this in automated testing, and think
> it's causing OS installations to hang, which would be a release
> blocking bug. Is this really a Btrfs bug or is it something else that
> Btrfs merely is exposing?
> https://bugzilla.redhat.com/show_bug.cgi?id=1733388

I think this Fedora install hang bug is unrelated to the lockdep
splat, and is something else, so I started a new thread.

Re: 5.3.0-0.rc1 various tasks blocked for more than 120 seconds
https://lore.kernel.org/linux-btrfs/CAJCQCtSFNVTNNAEP9hSY3cbWike5VkdH8EZnaojjgZZ3tf-SfQ@mail.gmail.com/

-- 
Chris Murphy
