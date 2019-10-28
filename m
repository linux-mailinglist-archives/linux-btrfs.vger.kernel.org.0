Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3173E7240
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Oct 2019 14:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbfJ1NBW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Oct 2019 09:01:22 -0400
Received: from mail-ua1-f41.google.com ([209.85.222.41]:40235 "EHLO
        mail-ua1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728242AbfJ1NBW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Oct 2019 09:01:22 -0400
Received: by mail-ua1-f41.google.com with SMTP id i13so2647625uaq.7
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Oct 2019 06:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=Cz/5mQSERO5+UkXwlx5jIUgsovYc7qRTMDJK88Vx/mI=;
        b=FH+bpsnXmD4PsEC4SdcCO87fhVsKiTM2qgm1Lj/eQNXsUxKqgJHaSNFcsFaRSPeuG7
         sEhtcDbvT96u7jIaKJu1bG719T6T2sKPlT4vQ/NreipGSsrvd9A4oiJg8iCMLUnsV8bM
         TIt2qY+Q6vGRzyfYN5dXSmFBXtHgSRP7TZ0KowAwl30WLsE/M1p0kiyVBo0aCBlr4crH
         NA2CYr5FkzZlKXey+jvrsZ4ThEgv2JR7RuYvLhchn5MoYLJ4YBDVKGHty0JHH9KeHvjt
         6I6SzWpvA9AGBYvhoB7hyPyxml6Ei5hsO8TS6FOPESlqjfZhwFP4mhBbjIMt0h+R81yG
         JbiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=Cz/5mQSERO5+UkXwlx5jIUgsovYc7qRTMDJK88Vx/mI=;
        b=aq0ph3Y9o9AnY2l4Az40fSB41T138I3L167yUtnhMuzwoBEq/KmwRxg16HnfkUbbfY
         8qWjldPULyljMFPhqu/NjpOAvSnBJ0su4uIHzSBMJVbQCwiWnQ3VB86BVP4HFFgcb1KV
         1C5bCzUD+48YXZnLzPBbOQAqlZwwMzcn6v37U9/rbTHxUaWedgJY0yjKvm/cO2mIGfiF
         BqcDhhu1TmDR/h+jsJcBy4CmYhGdk6yorjsalaCvS8dLiOsuW5tdc+YXkY42cHLstgd4
         08fSDGmFXuqb8S1OU7gpW8V+HGwialDumCE8ADxJ9ZN9ZPYdMz8l//JZCn797f7HJ6Sh
         qxwQ==
X-Gm-Message-State: APjAAAVpvZlFMfyQEanbv2Zlv3Rx6EQzMjvYvgPcP4OD1ub+4/FbaZ6T
        mHd2X/kqqdF/oZiCT1LtwdGLYQNVKf/gnsDw6+s=
X-Google-Smtp-Source: APXvYqzlExfZ5njBP5FdY07PGbJyeMTreIfspzVfqviekQ66ni4FpMH3RgPirhCHmt/VKwyCdKPqimVK660EN1tpqFI=
X-Received: by 2002:ab0:59ed:: with SMTP id k42mr7917855uad.27.1572267681428;
 Mon, 28 Oct 2019 06:01:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAE4GHg=W+a319=Ra_PNh3LV0hdD-Y12k-0N5ej72FSt=Fq520Q@mail.gmail.com>
 <cb5f9048-919f-0ff9-0765-d5a33e58afa7@gmx.com> <CAE4GHgmW2A-2SUUw8FzgafRhQ2BoViBx2DsLigwBrrbbp=oOsw@mail.gmail.com>
 <b4673e3b-b9b2-e8e5-2783-4b5eac7f656d@gmx.com> <CAE4GHg=4S4KqzBGHo-7T3cmmgECZxWZ-vXJMq8SYnnwy16h3xg@mail.gmail.com>
 <CAL3q7H4Wc0GnKNORVvwCOEk1QhzUweJr1JnN=+Scx5-TpQ5+yA@mail.gmail.com> <CAE4GHgntuxsoqv5vGMRTy6QYOTpQOocHgA2RxxeN6YKLgr5rNA@mail.gmail.com>
In-Reply-To: <CAE4GHgntuxsoqv5vGMRTy6QYOTpQOocHgA2RxxeN6YKLgr5rNA@mail.gmail.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 28 Oct 2019 13:01:10 +0000
Message-ID: <CAL3q7H5+xDr=0ZzW0+CnNqBh8ox9=rh8Vpp2aD4-jnXXnWCpgg@mail.gmail.com>
Subject: Re: BUG: btrfs send: Kernel's memory usage rises until OOM kernel
 panic after sending ~37GiB
To:     Atemu <atemu.main@gmail.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 28, 2019 at 12:44 PM Atemu <atemu.main@gmail.com> wrote:
>
> > That's quite a lot of extents shared many times.
> > That indeed slows backreference walking and therefore send which uses i=
t.
> > While the slowdown is known, the memory consumption I wasn't aware of,
> > but from your logs, it's not clear
>
> Is there anything else I could monitor to find out?

You can run 'slabtop' while doing the send operation.
That might be enough.

It's very likely the backreference walking code, due to huge ulists
(kmalloc-N slab), lots of btrfs_prelim_ref structures
(btrfs_prelim_ref slab), etc.

>
> > where it comes exactly from, something to be looked at. There's also a
> > significant number of data checksum errors.
>
> As I said, those seem to be false; the file is in-tact (it happens to
> be a 7z archive) and scrubs before triggering the bug don't report
> anything either.
>
> Could be related to running OOM or its own bug.

Yes, it's likely a different bug. I don't think it's related either.

>
> > I think in the meanwhile send can just skip backreference walking and
> > attempt to clone whenever the number of
> > backreferences for an inode exceeds some limit, in which case it would
> > fallback to writes instead of cloning.
>
> Wouldn't it be better to make it dynamic in case it's run under low
> memory conditions?

Ideally yes. But that's a lot harder to do for several reasons and in
the end might not be worth it.

Thanks.

>
> > I'll look into it, thanks for the report (and Qu for telling how to
> > get the backreference counts).
>
> Thanks to you both!
> -Atemu



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
