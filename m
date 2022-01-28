Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B088549FFEF
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jan 2022 19:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343725AbiA1SIQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Jan 2022 13:08:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343609AbiA1SIQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Jan 2022 13:08:16 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278BEC061714
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jan 2022 10:08:16 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id d3so6095302ilr.10
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jan 2022 10:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5Q4YTz5O3AJGkFe7PmaFfjJmKMJ3e0rtG4xjip7G9/g=;
        b=JZMLqkXqjDUDDD0OP7Rzwtwyolx6FNQTmqrfkfo4DYlsJdyttN07oUUOqLzN2DIWJQ
         SLDE6XOELabKtbN7kT3QRD4TGVA9Sup9yg9+wYks4esEvP18syvmNqE/DOd7JMXQEoBC
         B7I0+etdx39nvrMIg4nmbV2vZMWc7XoxMGa+ejemCrV+hS0bVBqTufK47aPVdZmRyEOF
         zAYtt101Ui436I4m3NjEZuYt+0AiEP5oZ8EKmmyW5EgRaba/uMhnoiHfWsCf0IB13Ju5
         wzFGCV58gbIM9wd/jxufZTYu7lf1MsiaBrs96yZou3q/BRn0ZFlAfHDdau//M5fzFPkS
         28vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Q4YTz5O3AJGkFe7PmaFfjJmKMJ3e0rtG4xjip7G9/g=;
        b=MX56NLgBAuDFuAS+9GcKzb9WG8NVgk6biTo0yqiriuR6J3LZu/FsxliEwopcToxw1g
         8Ic18IeZIbstHe/vlkc1MOdvHOY3SB5PdVdDR8hEd7JtXp0RwYQXiv14+Fjw+1zPcAPQ
         aFoWncvihIeBMck9p1K5au90YuNCC305Y0Z6A0EGTgUWhjr4RC9ssyhsIc9jLLKpQuzS
         fDZY/wutldH/2LT9zbibbogUVxEOiDc4KIyso+VK8xs92XM+eOkh73iGibSrgHHWaiL6
         M+q6hng03GAumcmoJJ+6VTC4ljQFZnTZnx4sgYVtwFg5prLG/pX4Q0x0BNSfy0HIPXZD
         tulA==
X-Gm-Message-State: AOAM530C2lB6TsJ8QUQByt3rJ81KWp64L9vNrKisCkWgD92iFyQd08Yh
        Zm+qkECoVVbfBpIsimtaRTfNLjBAsqvCDA38O0AfTx8O
X-Google-Smtp-Source: ABdhPJwFGQ4m5/bPgfYUQRA4MhC0+wHl4Mxw9wk66G/vQ4BqdYGcmzZ12WLrVEcRNpxUHQQB+wlbadUR7DMDkKifYmg=
X-Received: by 2002:a92:c952:: with SMTP id i18mr6865436ilq.317.1643393295468;
 Fri, 28 Jan 2022 10:08:15 -0800 (PST)
MIME-Version: 1.0
References: <10e51417-2203-f0a4-2021-86c8511cc367@gmx.com> <CAMthOuOg8SVYrehoS4VS=Gj4paYyobmqX85bKzGxYcG-2oJBDA@mail.gmail.com>
 <5e538d4d-e540-0dfd-0ad6-286bbe5739e8@georgianit.com>
In-Reply-To: <5e538d4d-e540-0dfd-0ad6-286bbe5739e8@georgianit.com>
From:   Kai Krakow <hurikhan77+btrfs@gmail.com>
Date:   Fri, 28 Jan 2022 19:07:49 +0100
Message-ID: <CAMthOuNVxu5b9=RLYMbTnz=zcwtC9K5GHD_hjcGyb80sps_MOA@mail.gmail.com>
Subject: Re: fstab autodegrag with 5.10 & 5.15 kernels, Debian?
To:     Remi Gauvin <remi@georgianit.com>
Cc:     piorunz <piorunz@gmx.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Am Fr., 28. Jan. 2022 um 17:25 Uhr schrieb Remi Gauvin <remi@georgianit.com>:
>
> On 2022-01-28 6:55 a.m., Kai Krakow wrote:
>
> > Yes, it will. You could run the bees daemon instead to recombine
> > duplicate extents. It usually gives better space savings than forcing
> > compression. Using forced compression is probably only useful for
> > archive storage, or when every single byte counts.
> >
> >
>
> I have also found compress-force  (with lzo) to be very beneficial for
> SATA SSD's.  Not only does it improve the sequential read speed, but
> forcing the smaller extent size makes it easier to reclaim space lost to
> fragmentation.
>
> I found that heavily fragmented files, (with no snapshots or reflinks.)
> could take almost 2X as much space as the file size unless they were
> defragged with a large (100M) target size, which causes senseless wear
> on SSD.  With compress-force, autodefrag (or manual 128k defrag)
> alleviates this issue.
>
> Conversely, compress-force on HDD completely destroys any semblance of
> sequential read speed.

Interesting observations, I'll keep that in mind. I never used btrfs
natively on SSD, I started using hybrid solutions some years back now
(bcache) and lately moved metadata to native SSD (which improves btrfs
performance by a lot).

So the question is: Does the space and performance overhead just come
from metadata? And using compress-force just "fixes" that from the
other side? For HDD, the seek overhead is probably the dominant
performance factor and you'd want to avoid that by all means.

With my new setup (metadata on SSD, data on bcache) the performance
difference between cold and hot bcache is really not that much: The
system feels smooth and responsive in both cases, this is even better
in both cases than metadata on bcache.
