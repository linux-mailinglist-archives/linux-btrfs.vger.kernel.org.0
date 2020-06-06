Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D58541F07E4
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Jun 2020 18:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbgFFQYr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 6 Jun 2020 12:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbgFFQYr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 6 Jun 2020 12:24:47 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED3EC03E96A
        for <linux-btrfs@vger.kernel.org>; Sat,  6 Jun 2020 09:24:45 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id i74so11193996oib.0
        for <linux-btrfs@vger.kernel.org>; Sat, 06 Jun 2020 09:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SztmG0d5WBLUUewvpbaV2qEaKcU+xa0qm1n9EUIQU7U=;
        b=Z8vrSitP3BI7+vDq/TTEx9Qv3gXs7r8M1qEasK224jud9MHrKDrrAr6Ka9kBGBk06H
         V1PCd9UiUSvfe0Ddb9cvqCGeJ+qbFUnC58QVbNp3739hHL9CRvJVPYonAWJm/3DRTgeu
         jEOh3rhsWyL4UlIN6o074EGcTkEAxKXjkCqqpYRRo9kB3pH+gBDXhRLn3OIWRH7nzR5d
         Zi6GFfdbqb8gFvPoxQxvAVU5fmIs76MZM9cLeD/i88YKflHZ8QRfXP5wC1z8A6lVeXk6
         MrwiQhfwaEDxIvlMHTD3PgLrsfN78cgksmLI7pRNdwxZMTft2hG7zwd5Z+vNM3Iiemt5
         rTyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SztmG0d5WBLUUewvpbaV2qEaKcU+xa0qm1n9EUIQU7U=;
        b=k/hdbWDsLSWWkjlPn1RO3NexvZCXFGk4zhvM/aGYHVPkqvgUJJOpSZCeZ+tLuJ0KHz
         f4LKlsAv3Ofttpj63jS3PaGo8pOEtFK8J7H+W7yn3XMRoxgrRx7/Giv2GWOK9lL9SGsK
         TKOxz3aUmCHqrqwqEjeXHsWEfLrK1wDJWp7shRsX3d2ieZzsiTR517+Hzz5xbE2uN543
         Kd98wxijKfZf7GewK/vMxOJJ+t0eYMMlBBEwzD9eASRWeQfbm6CbNfiw8g9fBbEmM721
         /SEeevK+ks+RQl2lN4lcZUQC7BeGKcmX6CkwRZAQpuo7BqR0v9YOpVUbpO8IJJADKciV
         /HrA==
X-Gm-Message-State: AOAM5325uoBzUcAoFm7fei/no975cam7m24IMZ3ixHgZwnAsvXlExoX3
        E5pR0kkvMP7cpdL86hzl8xBmZIEWmm1XmQ/jF53ev76n
X-Google-Smtp-Source: ABdhPJzNF02moQoVwG4Mfgnl0ohLxlxveUijanPCgNEeX0ZR2vSwJWcZHG7LWXmRLFmpR5QmbHwBycu9nMZbCfIGs3o=
X-Received: by 2002:aca:3d09:: with SMTP id k9mr5163152oia.160.1591460684894;
 Sat, 06 Jun 2020 09:24:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtTp+DJ3LQhfLhFh0eFBPvksrCWyDi9_KiWxM_wk+i=45w@mail.gmail.com>
 <CAJCQCtSJWBy23rU2L8Kbo0GgmNXHTZxaE2ewY1yODEF+SKe-QA@mail.gmail.com>
 <2ae5353b-461b-6a87-227c-f13b0c2ccfe2@suse.com> <CAJCQCtT6rnH75f8wC8uf+-NnxEsZtmoRhM9cE37QTR0TF6xqJQ@mail.gmail.com>
 <CAJCQCtSCzD-RtGH1tJjNN=PBgUfJARy0r1p1Ln0pU1eRNTmR9w@mail.gmail.com>
 <CAJCQCtQu4ffJYuOUWkhV_wR7L0ya7mTyt0tuLqbko-O8S+1fmg@mail.gmail.com>
 <CAJCQCtT=rStKTwUc86FyAp8C0D8eoRvgKHWYC3+e=fLJxJNUZA@mail.gmail.com>
 <CAJCQCtT6zXdNOeTh1YTrWwji_QtK00hhiAP96ysrHdeg-DU3bw@mail.gmail.com>
 <CAHzMYBRMqYK4tX5eqoO95=OwZb=uqzWrUE8ngvA1rO2_gqf+Dg@mail.gmail.com>
 <62395bb.90271dad.172426a118f@lechevalier.se> <CAHzMYBTpuEHRBuNNB0seKLL7D+vAdvejdT+JGTjm9c_QyrFwQw@mail.gmail.com>
In-Reply-To: <CAHzMYBTpuEHRBuNNB0seKLL7D+vAdvejdT+JGTjm9c_QyrFwQw@mail.gmail.com>
From:   Jorge Bastos <jorge.mrbastos@gmail.com>
Date:   Sat, 6 Jun 2020 17:24:35 +0100
Message-ID: <CAHzMYBTAnQF=+ioNx4uk1v2+0hsd+H2QujkVKAbCFgZdJF3feg@mail.gmail.com>
Subject: Re: 5.6, slow send/receive, < 1MB/s
To:     A L <mail@lechevalier.se>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Well forget that, it's not pv, it's doing it again without it, will
need to do more testing.

On Sat, Jun 6, 2020 at 5:16 PM Jorge Bastos <jorge.mrbastos@gmail.com> wrote:
>
> Hi there,
>
> Happy to report my issue is not related to btrfs, since I remembered
> reading this post and noticed performance issues after upgrading to
> kernel 5.6 wrongly assumed it was related, my issue is caused by pv,
> for some reason sometimes it starts using a lot of CPU and the
> send/receive barely crawls along, but it's not always, i.e.same
> send/receive can go at 250MB/s one time and the next time it will
> transfer at less than 10Mb/s, anyway sorry to waste everyone's time.
>
> Regards,
> Jorge Bastos
