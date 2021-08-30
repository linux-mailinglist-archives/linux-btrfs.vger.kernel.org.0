Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 257BC3FB6E2
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Aug 2021 15:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234032AbhH3NWY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Aug 2021 09:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhH3NWY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Aug 2021 09:22:24 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509FDC061575
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Aug 2021 06:21:30 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id v1so8222438qva.7
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Aug 2021 06:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=lK6aoffWk8h0QHaQwDF6fxDpwOCzYgJtMctzQJLtCxE=;
        b=a0wPk0dHIfz/WDP7J8WK2Xb4RSd3OhuzmvovDVrYaPTPHAey7qz2mOwPqEXIA1v7c/
         04/JwhjfOdVuXDnQ4Soll6pxbzh9YPr3k1dWhe/7unt1lHIszzRvDRZkVA7z8h6ikqf6
         Ol+Fk7gWAZm2nkLyKLy2Cz66WJULXwY+iUzE6H8LfogmJoZ/d17O8wd4009DyuPI7Mh0
         T8BwGV1sO7iFK/5kbnxbBwwXmKhBt+DefpvrtsHAe2trvThZrVsM5rjmsxxGRonBRAZ2
         1LscbvOz/njziPkr1F4zY5YT5XC6K/7aUFtOTy2vAXfDsk42Vy41q/eGfGisRGjHnJyE
         YXMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=lK6aoffWk8h0QHaQwDF6fxDpwOCzYgJtMctzQJLtCxE=;
        b=QLium9V0O56aM0tvtMTYk/B3QigUfxH5IQhO8JmineXYqi9Ml1RzJWoXNWO7+OIY+a
         R7nA29dGjetyTVl3IEmSiRKwjH2+pukxtuLHABZvOpBFZK/k6Fa6IeY9wYnBvZOx7Lep
         fpOjRraqesXJuhqT2vb2dBXTqSiJ6CwGY36Kw71VeX0RhpxBi71AgAL0E7ZxQJB2L9H8
         RhjCg2shsdnOojoC5cbewm2ik3feZTuFNkpTNTPSa4c2VlM0EGWxLp8jtEd81UZAPp0a
         ppSbF2OC8oFwm6YnrUkgIopGej8fMUdjrLNuge3jBZuG00gzURE086uUV5ijFtWtHeEB
         qVYQ==
X-Gm-Message-State: AOAM533gl9B94B4gKFwiUp/1qNJaheaRZksIbAoZyehaF1dp2t/smsJI
        /Q+d1pgA1/dcln2AGhgVT7z/TNnZf3E8l+DddmItRmnNbN0T6w==
X-Google-Smtp-Source: ABdhPJyKHp0aLwianVxZXJfCZwfwEYC31wuEhiC298c0YwzKfDJTRfNvfx5pu4Dh9o0QLwxUd710s/ABSRQIrOujPXg=
X-Received: by 2002:a05:6214:acd:: with SMTP id g13mr23509668qvi.23.1630329689273;
 Mon, 30 Aug 2021 06:21:29 -0700 (PDT)
MIME-Version: 1.0
From:   Andrej Friesen <andre.friesen@gmail.com>
Date:   Mon, 30 Aug 2021 15:20:53 +0200
Message-ID: <CABFqJH6acH=240RxRhVj5Y9geh-QG7vdDWAgFespwu0nk3wgaQ@mail.gmail.com>
Subject: Questions about BTRFS balance and scrub on non-RAID setup
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hey folks,

I have used btrfs now for a few years on my home server and have had a
good experience so far.

But now I need some advice because I and my team want to use BTRFs in
a product. And personal use is something really different than
enterprise :-)

Use case and context for my questions:

A file system as a service for our customers.
This will be offered to the customer as a network share via NFS. That
also means we do not have any control over the usage patterns.
No idea about how often, how much they write small or big files to
that file system.

Technically we only create one block device with several terabytes and
format this with btrfs. The actual block device which we format is
backed by a ceph cluster.
So the actual block device is already been on a distributed storage,
therefore we will not do any raid configuration.

The kernel will be a recent 5.10.

Scrub:

Do I need to regularly scrub?
If so, what would be a recommendation for my use case?

My conclusion after reading about the scrub. This checks for damaged
data and will recover the data if this filesystem has another copy of
that data.
Since we will run without raid in btrfs this is not needed in my opinion.
Am I right with my conclusion here?

Balance:

Do I need to regularly balance my filesystem?
If so, what would be a recommendation for my use case?

I am a little bit confused about this one.
The FAQ (https://btrfs.wiki.kernel.org/index.php/FAQ#Do_I_need_to_run_a_bal=
ance_regularly.3F)
says:

> In general usage, no. A full unfiltered balance typically takes a long ti=
me, and will rewrite huge amounts of data unnecessarily. You may wish to ru=
n a balance on metadata only (see Balance_Filters) if you find you have ver=
y large amounts of metadata space allocated but unused, but this should be =
a last resort. At some point, this kind of clean-up will be made an automat=
ic background process.

Others on the wide internet however say it makes sense to regularly balance=
:

https://github.com/netdata/netdata/issues/3203#issuecomment-356026930

Something like this every day:
`btrfs balance start -dusage=3D50 -dlimit=3D2 -musage=3D50 -mlimit=3D4`

I also asked on IRC (username ajfriesen) about regular balance and
people seem to have different opinions on that topic as well.


What would a recommendation look like for my use case?
Would it make sense to update the FAQ in that regard?

PS: First-time mailing list user, please tell me if I did something wrong.


All the best
---
Andrej Friesen

https://www.ajfriesen.com/
