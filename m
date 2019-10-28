Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E98FFE7204
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Oct 2019 13:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbfJ1Mos (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Oct 2019 08:44:48 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:37352 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728059AbfJ1Mos (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Oct 2019 08:44:48 -0400
Received: by mail-wr1-f51.google.com with SMTP id e11so9736263wrv.4
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Oct 2019 05:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zN2TeyWgGFgT48WVx1g9wpfAi2tJH+jM1Oi9SsadHGw=;
        b=WECPATgBCknEj6NOZw9zudn3wB4VgPbKLhWuaO2L2G7BwDIaibBd7uDX/+fAbW7/Ni
         pmxrRG2CctyDPWd7sVj4lx/KVTp0hQZ7ZoV9ujB4ezMcmEALJPs5iS2/bwH9I5E8elQR
         9E4yFcHNvHVPgSzV7WfNLRhh4chpt4BctQ4c1R/PgKXFjqxrgv1eTXrXgjwAdEK9rUDk
         +ngXHLVFn7nstPpZbrmdHBrCWdY2AJ/MIat+JGdTlYKI7QfbXwOIUBdkyD9X8kS0LY2y
         NvRb3MLj1rM4IKdGEuMtMANFlAzOvRazPuAxtpA8vJiLwlSYH2FOn6aOgYKsws299Oz4
         lhTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zN2TeyWgGFgT48WVx1g9wpfAi2tJH+jM1Oi9SsadHGw=;
        b=puARvr+hZNsnmPCthZI1+5B/VrL0lEa/gliNid5P+DHaHa5dS+gryoyg7IISJ0x7qT
         huq1ek67X5NRROwVVCrCmdbc8I89iRL8i4XGY7ArpzqPhxqWz2FQi6b0VVVrkFfzWi3I
         EOSTJrAF0NJNZ1lvQc2G6PTBrQ3IeTSC/dAzzNxT7ldYexrT/zG+UKUbHkmybM/k2foB
         VJkPOve+P65xl5ebIWh/V8rRybO8M9x76Xs8Bx89xnLGgLRfhq+1N483bNURHxOmihpo
         /Xwij1ypGq51KgYP0bRIQ8yS3v6Ffeqptd6IaLZyWYviVMPttXrRgiZISptW7g40GaXT
         F1SA==
X-Gm-Message-State: APjAAAUwpk/TH4hJ2YA6MH18ddvE0vW5udHGwP6j1MAzpb2L+0w+Vfyb
        mgaqRQrvJU4u8ZuEgw0Jyr3JiDiDB1EWGXhpNG4=
X-Google-Smtp-Source: APXvYqwJZPYoNrQOQVctdBHLM8zfRcfoKATHjOW21nvIcfACTn21o1/WFIZlUb6uss1i8xT9Sb1z+RnjpDA5ObgKehg=
X-Received: by 2002:a5d:66c1:: with SMTP id k1mr15738155wrw.73.1572266685908;
 Mon, 28 Oct 2019 05:44:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAE4GHg=W+a319=Ra_PNh3LV0hdD-Y12k-0N5ej72FSt=Fq520Q@mail.gmail.com>
 <cb5f9048-919f-0ff9-0765-d5a33e58afa7@gmx.com> <CAE4GHgmW2A-2SUUw8FzgafRhQ2BoViBx2DsLigwBrrbbp=oOsw@mail.gmail.com>
 <b4673e3b-b9b2-e8e5-2783-4b5eac7f656d@gmx.com> <CAE4GHg=4S4KqzBGHo-7T3cmmgECZxWZ-vXJMq8SYnnwy16h3xg@mail.gmail.com>
 <CAL3q7H4Wc0GnKNORVvwCOEk1QhzUweJr1JnN=+Scx5-TpQ5+yA@mail.gmail.com>
In-Reply-To: <CAL3q7H4Wc0GnKNORVvwCOEk1QhzUweJr1JnN=+Scx5-TpQ5+yA@mail.gmail.com>
From:   Atemu <atemu.main@gmail.com>
Date:   Mon, 28 Oct 2019 13:44:34 +0100
Message-ID: <CAE4GHgntuxsoqv5vGMRTy6QYOTpQOocHgA2RxxeN6YKLgr5rNA@mail.gmail.com>
Subject: Re: BUG: btrfs send: Kernel's memory usage rises until OOM kernel
 panic after sending ~37GiB
To:     fdmanana@gmail.com
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> That's quite a lot of extents shared many times.
> That indeed slows backreference walking and therefore send which uses it.
> While the slowdown is known, the memory consumption I wasn't aware of,
> but from your logs, it's not clear

Is there anything else I could monitor to find out?

> where it comes exactly from, something to be looked at. There's also a
> significant number of data checksum errors.

As I said, those seem to be false; the file is in-tact (it happens to
be a 7z archive) and scrubs before triggering the bug don't report
anything either.

Could be related to running OOM or its own bug.

> I think in the meanwhile send can just skip backreference walking and
> attempt to clone whenever the number of
> backreferences for an inode exceeds some limit, in which case it would
> fallback to writes instead of cloning.

Wouldn't it be better to make it dynamic in case it's run under low
memory conditions?

> I'll look into it, thanks for the report (and Qu for telling how to
> get the backreference counts).

Thanks to you both!
-Atemu
