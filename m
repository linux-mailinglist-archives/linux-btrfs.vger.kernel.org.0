Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 523193566B9
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Apr 2021 10:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234400AbhDGIYe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Apr 2021 04:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232650AbhDGIYb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Apr 2021 04:24:31 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492A3C06174A
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Apr 2021 01:24:21 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id v29so9221350vsi.7
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Apr 2021 01:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=VKh7tv1EE483d/3cNWsv0nX9oYdJxM3VIkDiF1nTZTc=;
        b=UvKtTY79OJ9Kuib0WrIvhX8rxoq1AjeSiG1uTMeyLTB0JmiG2l2RcpcW0l7WjLQ14H
         EW0toZdsKIutP5DPFWr253bLaiQINmIobVU8QGTOm52/6zoT1dtrmtLHeQggSaPDi3y4
         Gum3jyl7jA8OStWmUJ/ApScuesnScNQrBZGXXmn/6MMDpr6nokX71xEEYrqUa0jFjBAU
         dvLVs6hjdrcyKZIa5N55E1gT/e18yPUZZOp+qMVsskyVMoMW+8p92xV0znwAnxqCT4Ki
         ENrXctK5OnEXBb0g9jbp8SjgKEKJzSbrO0D/+tiE5WkzGErzd0ec8veX1UVBUToXRd2B
         tHaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=VKh7tv1EE483d/3cNWsv0nX9oYdJxM3VIkDiF1nTZTc=;
        b=b+SEMZ3I78nZVuJMXW/uhdZGbyBgkIxyqNQTPfUD8prrhDLRbBOKhIFjTEIitHGEHH
         tNl7IoOfDbcB+hC8FhNqbHRwPIC6uvQ5Eq1C5BDDIjBTs6t71dFeqzvL4fb9O0XSAXCs
         zlIsSQRAVuOE4woY2YQuE9af1d+S/yoMZ4+L6MgEbpPmwUjEoMNnln2lAkQlADyqoXaU
         AJCUDJvqyV0RR6rV/Q268sQuoR1gB25yw1MvM1XbdJqqrjsGw8sN2xPFrF531Z1f9D88
         XiEemyQHyrFI1gX19aEYZOYnnLHR0R/RsgwWHRvfSXmwRHBpuVikYnB9KNXTfJt2ys4Q
         arwA==
X-Gm-Message-State: AOAM530+Q5/AgdjsQwqR8J/XnGEwh0AVvrU2p3IJS2V0/KMe9ht0aVuR
        odY1E9HjloaGBBKZ9Ul/OGNyLGJm1dIaX/JGgELwvQ0DX7A=
X-Google-Smtp-Source: ABdhPJwTBtEpCHvPeS6v08r79dZ/icQ2F4b0OBzPhRa6BE8qqVu94htJ0ipQGui147B+xlP7Z4rsjU1k7khLr3e2nM4=
X-Received: by 2002:a67:e982:: with SMTP id b2mr1127527vso.57.1617783860586;
 Wed, 07 Apr 2021 01:24:20 -0700 (PDT)
MIME-Version: 1.0
References: <23a8830f3be500995e74b45f18862e67c0634c3d.1614793362.git.anand.jain@oracle.com>
 <b0caf058-3bb5-2ceb-d1d4-d352deee636e@oracle.com> <83ecd955-560f-14e5-ab97-33e0c0a3d3d0@oracle.com>
 <a6qdw0jr.fsf@damenly.su> <20210406164816.GK7604@suse.cz>
In-Reply-To: <20210406164816.GK7604@suse.cz>
From:   Su Yue <damenly.su@gmail.com>
Date:   Wed, 7 Apr 2021 16:24:16 +0800
Message-ID: <CABnRu55cYnn3=doLyObDRJByzDxOLNmuAdmToxoDnBMYFP1GOg@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: fix lockdep warning while mounting sprout fs
To:     dsterba@suse.cz, Su Yue <l@damenly.su>,
        Anand Jain <anand.jain@oracle.com>,
        "dsterba@suse.com" <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 7, 2021 at 3:24 PM David Sterba <dsterba@suse.cz> wrote:
>
> On Mon, Apr 05, 2021 at 05:18:32PM +0800, Su Yue wrote:
> >
> > On Mon 05 Apr 2021 at 16:38, Anand Jain <anand.jain@oracle.com>
> > wrote:
> >
> > > Ping again.
> > >
> > It's already queued in misc-next.
>
> > commit 441737bb30f83914bb8517f52088c0130138d74b (misc-next)
> > Author: Anand Jain <anand.jain@oracle.com>
> > Date:   Fri Jul 17 18:05:25 2020 +0800
>
> No it's not, you must have checked some very old snapshot of misc-next,
> I don't even have 441737bb30f83914bb8517f52088c0130138d74b in my stale
> commit objects so it's been 'git gc'ed already.
Indeed. Sorry for the wrong info.

--
Su
