Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E44BE620C
	for <lists+linux-btrfs@lfdr.de>; Sun, 27 Oct 2019 11:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfJ0Kdy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 27 Oct 2019 06:33:54 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:46377 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbfJ0Kdy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 27 Oct 2019 06:33:54 -0400
Received: by mail-wr1-f51.google.com with SMTP id n15so6842877wrw.13
        for <linux-btrfs@vger.kernel.org>; Sun, 27 Oct 2019 03:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KnRP0jvJApfInCyqcwYz48U11jOSqCTVT8kRHkgosMY=;
        b=UfvGG+RyXFp9tk4kO9dNfuIFlY/DFt5OOqhVfCTkGNvtZujUAFVcJWczcApBDKZ1Rm
         0RoXNu5ZCtjqeRxLAr6tzMW7YCvdnBu26BP/FjypwcJJNWvcUUxugPxCqOI/uSXA5E3Q
         F/kA9KWAlSPwAaV16toGlNDdAru9Qc4u1RoNrrlQbkkpmCpbWqWaoedv3JfPJRGZkmII
         C8CEYQmTgZalgakZAbsvgsjTpQTiZTy33eHDCa+v2IgupyiEDx7WZjiZBedJojbhEdw1
         91GKGjLUX7YjXwfRFFEqmsUqg4R6tOGD8U3+pXXV0YtsUhiKJlNmO4xG165hvH7kUwv4
         +83w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KnRP0jvJApfInCyqcwYz48U11jOSqCTVT8kRHkgosMY=;
        b=JpJlFyhKHcNk9DI3RZCNm4yPlyhPeuJPDgcpgKYmPIIPNksSb8PtN6uZb79TGN02vR
         YX5g1DBooZmTn2BB6/qOc7CzLdl8tpqUANW5Lk9J7ZScseiYecJF5RQnx3wC5yAWvadd
         +onGY9DVsEnIO3vHWBIfdecpIW314vnncpcrRxKtkYVksGAVFF+TjrAoyXUndPjYUv5l
         ZG+E1FMKhV7N9Eru92WHcvKirwtMawsi/gGXk/2MtiGUTuXYXVLJvaw4q0kFcNa0ZSJv
         nlNfIcI9ri2KnY6AtdzoFgVOJIgCdRDPYWqeZ1Pp9e4karTZ4kluFtfmZ8CjG92rRvjb
         O1ig==
X-Gm-Message-State: APjAAAVcionqsLXWi4LQ+WVozhnbcqOiHsLEWUSoCzCoWIzLce80p5Sj
        FXbnG+/TLZd4fMFQKxfMmAOW/PIFdNbN2FSeF2o=
X-Google-Smtp-Source: APXvYqymtH0AgQ6WurufNn4kBnTPbstY2fG6ZXRc12GB7AqOQVkPO65gDa9vTDkMSCH1g7qxpN7K/93rwsPI4MysXHg=
X-Received: by 2002:adf:ea11:: with SMTP id q17mr10504937wrm.83.1572172432073;
 Sun, 27 Oct 2019 03:33:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAE4GHg=W+a319=Ra_PNh3LV0hdD-Y12k-0N5ej72FSt=Fq520Q@mail.gmail.com>
 <cb5f9048-919f-0ff9-0765-d5a33e58afa7@gmx.com>
In-Reply-To: <cb5f9048-919f-0ff9-0765-d5a33e58afa7@gmx.com>
From:   Atemu <atemu.main@gmail.com>
Date:   Sun, 27 Oct 2019 11:33:40 +0100
Message-ID: <CAE4GHgmW2A-2SUUw8FzgafRhQ2BoViBx2DsLigwBrrbbp=oOsw@mail.gmail.com>
Subject: Re: BUG: btrfs send: Kernel's memory usage rises until OOM kernel
 panic after sending ~37GiB
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> That's the problem.
>
> Deduped files caused heavy overload for backref walk.
> And send has to do backref walk, and you see the problem...

Interesting!
But should it really be able to make btrfs send use up >15GiB of RAM
and cause a kernel panic because of that? The btrfs doesn't even have
that much metadata on-disk in total.

> I'm very interested how heavily deduped the file is.

So am I, how could I get my hands on that information?

Are that particular file's extents what causes btrfs send's memory
usage to spiral out of control?

> If it's just all 0 pages, hole punching is more effective than dedupe,
> and causes 0 backref overhead.

I did punch holes into the disk images I have stored on it by mounting
and fstrim'ing them and the duperemove command I used has a flag that
ignores all 0 pages (those get compressed down to next to nothing
anyways) but it's likely that I ran duperememove once or twice before
I knew about that flag.

Is there a way to find such extents that could cause the backref walk
to overload?

Thanks,
Atemu
