Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7DA105B27
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Nov 2019 21:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbfKUUb0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Nov 2019 15:31:26 -0500
Received: from mail-ed1-f52.google.com ([209.85.208.52]:40905 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbfKUUbZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Nov 2019 15:31:25 -0500
Received: by mail-ed1-f52.google.com with SMTP id p59so4001592edp.7
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Nov 2019 12:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=llg8Byo+AsTg6rpkATzQYfcT1ZzOdvIEqFQ53HNpuEE=;
        b=ogBt+YQPCyvHPPLxYAteYtNaIU0Wf891EWJc18YW4C1HCvvUq2ve+jYaZP7SGD7Bkb
         wNmix8VqqL8DcbMHKEP+alHSskafA+dkQ9jJ5w1GpDslBiLUreucSwpJI1Xzu65jEJbe
         jAU53dSIZk0cp3lcZSOy6pQpysc0MLVUYdIh7oNk2fULzNNM0yKDbRgIfN13q3X3Zq7n
         x5efXGyA6KcFrb1H/bdID8nMpygYhzqHqOum0oHqHScnRYzYrPtSm1etVOc64pZIkFFB
         sHdWyEKCHT21hTP9rb1UHtoPsA55HgFuCL8o7DB+hamHAw8OXhY363oxY8jgoRFlIdNI
         gbmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=llg8Byo+AsTg6rpkATzQYfcT1ZzOdvIEqFQ53HNpuEE=;
        b=SuD/7azbbsGQ1nJ4IGq2W7XJt42w+PDF4R0KiOcTqQhTNageo/NNHMFXP6P+q4q905
         fONW4Sykx7E7CMagTJ7+SItCOVNE2NECjyjR4V8EFQ4TbBazWaY/C+AKsf+iheNbhW+Y
         niVUVeqVhCBZEJCniAq4RSJiwROPfihfD8SxKMLyBIplw8r+tuXYnYQeHahZQ4LDZeXa
         o+6NR7Z57gQRscpJ42BwJPX8eKXyRT0DGa3Veq0maOVlAL+cKVt216gMm/pmoimNJpcl
         15M1FNwk27GSfv9zFUqdOSktIrsF+UCbrSQnKLTaOxjIYzL6yh2iLhNp9wCSbiMsqJJS
         KPFg==
X-Gm-Message-State: APjAAAXhT93UR8LasqcLJAgk3M7Vy6h0FOvCg/J/2n8Jljj5RLoioMRP
        +3ABb8YKrZx/bzQoKJMVs18bP45Nre9PPWN6z1Wl
X-Google-Smtp-Source: APXvYqxsYJWkTaa/o2hiypvw6VyCCxyLmM9EZq8tjflb+2a8rAeiVjH+9fxP4FRctyZflD7LzgTjHDrRYuZNnKY7FkM=
X-Received: by 2002:a17:906:57c3:: with SMTP id u3mr16554617ejr.254.1574368283592;
 Thu, 21 Nov 2019 12:31:23 -0800 (PST)
MIME-Version: 1.0
References: <20191112183425.GA1257@tik.uni-stuttgart.de> <7f628741-b32e-24dc-629f-97338fde3d16@googlemail.com>
 <CAKbQEqGOXNhHUSdHQyjQDijh3ezVK-QZgg7dK5LJJNUNqRiHpg@mail.gmail.com>
 <3e5cd446-3527-17ef-9ab8-d6ad01d740d0@gmx.com> <CAKbQEqFCAYq7Cy6D-x3C8qWvf6SusjkTbLi531AMY3QAakrn6w@mail.gmail.com>
 <4544ecff-b70e-09fb-6fd3-e2c03d848c1c@googlemail.com>
In-Reply-To: <4544ecff-b70e-09fb-6fd3-e2c03d848c1c@googlemail.com>
From:   Christian Pernegger <pernegger@gmail.com>
Date:   Thu, 21 Nov 2019 21:30:47 +0100
Message-ID: <CAKbQEqFELp0TWzM+K9TqAwywYBxX_3jXy0rz6tx9mNXyKEF02A@mail.gmail.com>
Subject: Re: freezes during snapshot creation/deletion -- to be expected?
 (Was: Re: btrfs based backup?)
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> Am 21.11.19 um 17:44 schrieb Christian Pernegger:
> > maybe to quotas. It's possible that Timeshift enables them, how can I check?
>
> You can test with:
>  $ btrfs qgroup show /

Definitely enabled, then. ... ... ... There it is: Timeshift has a
pre-selected checkbox "enable BTRFS qgroups (recommended)" [translated
from German].

1) How can I safely disable qgroups? Is it enough to uncheck the
Timeshift option and then run btrfs quota disable or do I have to
manually remove the qgroups somehow?

2) I'm wondering if this couldn't be improved. Considering qgroups are
only used (in this case) for reporting on allocated space, not
limiting it, and btrfs free space reporting is notoriously lazy [not
meant in a bad way, can't think of a better word right now] anyway,
why does anything need to block at all? Even if I were using quotas, I
might prefer fuzzy quotas [that can be be hit too early/late because
accounting is catching up] to a temporary standstill, as an option.

> This is an interesting observation. I believe this means it is happening when the snapshot deletes are actually going to the storage,
> which usually happens only _after_ btrbk is finished (in case you catch it with top, a kernel thread "btrfs-cleaner" should be doing this job).

Ok, so btrbk runs, finishes, soon (but not immediately) after that
btrfs-cleaner indeed tops the CPU charts, pegging one core to 100 %.
The system is still responsive at this point. A couple of seconds into
the btrfs-cleaner run, the system becomes unresponsive (top still
updates throughout, though). btrfs-cleaner drops off, and
btrfs-transacti[obv. cut off] takes it's place, taking 100 % CPU.
Still unresponsive. As soon as btrfs-transacti is done, the system
immediately recovers. Then btrfs cleaner returns, briefly, with no
impact on performance. (Keep in mind that top only updates every
couple seconds, it's possible btrfs-cleaner is blameless and
btrfs-transacti the culprit.)

> Another interesting test could be to adjust btrbk configuration to:
> btrfs_commit_delete = each

Will do.

Cheers,
C.
