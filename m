Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33F1D202DC6
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jun 2020 01:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730939AbgFUX6C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 21 Jun 2020 19:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730916AbgFUX6C (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 21 Jun 2020 19:58:02 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22DCBC061794
        for <linux-btrfs@vger.kernel.org>; Sun, 21 Jun 2020 16:58:02 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id u26so12405720wmn.1
        for <linux-btrfs@vger.kernel.org>; Sun, 21 Jun 2020 16:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=z92cOUtRJx2Mjw8yaos/bwWgTMx9WPM8IguNQK/BEn0=;
        b=TQ0V3mgLp7HoYXqbzHT6X86OLZTiMUgDP4t/r6FFEPxRG42QWAJyHatt7+mpkTgxF6
         g1rijx1LJ12py0aPdivnz4/OeZqSZhme6B7ZS/JM00OUwnsa2wyJtamkSLrukvkRso5H
         bcFq5r3pfiiwvKAMzNmJUGNRVUrB7jcjzStL3Loo+SwpU020RS3P2+CBAxkD5Z7vjaEK
         S1ezXZyfHbQVs/Ize0Mv9/4B9+DH1hEHR/e4MAJX7xMHb/4vKaX9R3Rlo6VzTG+Z4NRv
         4cZp0FHKg2Uy76m/GOEtF+yOmyLViZu0N/5LvIcUUc3bFV4aq1VFuKi4JKwO1ssqK3lV
         AcWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=z92cOUtRJx2Mjw8yaos/bwWgTMx9WPM8IguNQK/BEn0=;
        b=Pln5BE75lAYE3GJyU37FhoKyPbgT1JE0WQk/Ukgey/7lnW+2VvvTCxoW6mnvNvmpAD
         Uqvhprb9e1bUmBYskkA/Mk585xyPgpLNK/hlh9bBu8TDoHU7TkIMdTxXrePQuyH/cfHj
         2v+q8iKcivz3lLlkaoW3X/Y+Bs9c6xlrLAjYVuMt1tMUi2jEbK97k28vTyo5mS7x9hqD
         IfmjMb0xcpd2s/zYi8MWFWw24xFJTla1yEBzoa/mEnqo5N3IOgSZP3hqHiM3UINtUjsh
         NAXFUPkNuEvi74d02guDl5OYcCyu0oQFJaCSa7ElZtVi3ldKQjmtvO4xWYyb8mKz5dwL
         AaWg==
X-Gm-Message-State: AOAM530ixn3zHkmFH9EVeym4NZZS2IZVR17K/1/ut7VEfbhAYqarSRv+
        afX93unwNdTifrjDT17voBhctWIW6MxNJSpcAxloKIAtg2I=
X-Google-Smtp-Source: ABdhPJxHU8Kd7CMIeaNfdrrFpTNLts8g/NBGJhKtvkC5subPrG5pajYoSA06BB2aQsBdVK0qXx3xzBtf5yjoO1kiMWg=
X-Received: by 2002:a1c:4105:: with SMTP id o5mr15156777wma.168.1592783880526;
 Sun, 21 Jun 2020 16:58:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200621054240.GA25387@tik.uni-stuttgart.de> <CAJCQCtSbCid6OzvjK9fxXZosS_PAk2Lr7=VTpNijuuZXmRVVEg@mail.gmail.com>
 <20200621235202.GA16871@tik.uni-stuttgart.de>
In-Reply-To: <20200621235202.GA16871@tik.uni-stuttgart.de>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 21 Jun 2020 17:57:44 -0600
Message-ID: <CAJCQCtQmrc5m=H6d6xZiGvuzRrxBhf=wgf8bAMXZ_4p8F3AJFw@mail.gmail.com>
Subject: Re: weekly fstrim (still) necessary?
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jun 21, 2020 at 5:52 PM Ulli Horlacher
<framstag@rus.uni-stuttgart.de> wrote:
>
> On Sun 2020-06-21 (13:39), Chris Murphy wrote:
>
> > > Shall I call fstrim via /etc/cron.weekly ?
> >
> > util-linux provides fstrim.service and fstrim.timer for a while now.
> > fstrim.timer runs on Monday at 00:00 local time. The upstream default
> > is disabled, some distributions enable it by default.
>
> On Ubuntu 18.04 and RHEL 7.8 "systemctl is-enabled fstrim" returns
> "static"

You need to check fstrim.timer, which in turn triggers fstrim.service.


-- 
Chris Murphy
