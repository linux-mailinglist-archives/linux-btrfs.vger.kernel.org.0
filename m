Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7503B384F
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Jun 2021 23:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbhFXVJn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Jun 2021 17:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232163AbhFXVJn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Jun 2021 17:09:43 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902ECC061574
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Jun 2021 14:07:22 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id k8so9600429lja.4
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Jun 2021 14:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zAsYzzhXkdofQZ/91vxC7T2pQLg/Al6Inx2IRm0Ut3U=;
        b=UhgrjmazbjVyroDGAIMCaeMq5+n4Zq0zIRTShHEICkP3b4QusYEcd395MUEp8AFCQx
         pZlB6wuYan6cRqYD5qIM9Csv3iJOOilTEZiCgxQS1D+CqOSIuFTCsEE+d9Qip5KXOrRx
         3AN8UMYj0rqX8g6GxPrgltXzQqGcgVwxVdXIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zAsYzzhXkdofQZ/91vxC7T2pQLg/Al6Inx2IRm0Ut3U=;
        b=f52xyTiDgu04KnTBeTnRaMhkfTAyEOz8f3idUvkXAMxOxr0DlXEbaQtr5sgYTG503q
         fjZnGdGxvTE4U1FmIlgkXAVt55hdjB4a6NbTP3VnlLYGIacX3XHOtmDQ/3rimtrp8siq
         1CKdbzdyDnU0GJn2SWLb9b11lYaQcqMkIX47wwLI/HUjE/NurjyfVgdtGSMwe9ifWdTB
         eAT7Z/pGxA2rZD472vQ5rN1DM6r9jBMkSZqSxjslRhyNN5E7tgmDw5udCHU2pDvQ6Vtd
         h92RLUh+TIyfwNlgOxUBAQun9oDS2Rtr26BGmzy7yl9IVwcr8VLeKiXmz96agBFle1xk
         Kx5Q==
X-Gm-Message-State: AOAM533nqz8Ec5+aIecQV+kCJZqhj1Soz6pAeXu1YPsD033K8LPNvEtk
        mMTMoFOAzU79+2QJ21eNtKABziRqjEgxC02xofo=
X-Google-Smtp-Source: ABdhPJxvCxc1DJ89/UupNJZILFrLqdg59JIwyD2/hxc5Dn+MGh+0Bnj024oQZ/Zolc4PedcrJEVFzg==
X-Received: by 2002:a05:651c:a07:: with SMTP id k7mr5597461ljq.477.1624568840791;
        Thu, 24 Jun 2021 14:07:20 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id w24sm323482lfa.143.2021.06.24.14.07.19
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jun 2021 14:07:19 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id k8so9600330lja.4
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Jun 2021 14:07:19 -0700 (PDT)
X-Received: by 2002:a2e:a276:: with SMTP id k22mr5247591ljm.465.1624568838796;
 Thu, 24 Jun 2021 14:07:18 -0700 (PDT)
MIME-Version: 1.0
References: <YND8p7ioQRfoWTOU@relinquished.localdomain> <20210622220639.GH2419729@dread.disaster.area>
 <YNN0P4KWH+Uj7dTE@relinquished.localdomain> <YNOPdy14My+MHmy8@zeniv-ca.linux.org.uk>
 <YNOdunP+Fvhbsixb@relinquished.localdomain> <YNOqJIto1t13rPYZ@zeniv-ca.linux.org.uk>
 <YNOuiMfRO51kLcOE@relinquished.localdomain> <YNPnRyasHVq9NF79@casper.infradead.org>
 <YNQi3vgCLVs/ExiK@relinquished.localdomain> <CAHk-=whmRQWm_gVek32ekPqBi3zAKOsdK6_6Hx8nHp3H5JAMew@mail.gmail.com>
 <YNTO1T6BEzmG6Uj5@relinquished.localdomain>
In-Reply-To: <YNTO1T6BEzmG6Uj5@relinquished.localdomain>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 24 Jun 2021 14:07:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi37_ccWmq1EKTduS8ms_=KpyY2LwJV7roD+s=ZkBkjCw@mail.gmail.com>
Message-ID: <CAHk-=wi37_ccWmq1EKTduS8ms_=KpyY2LwJV7roD+s=ZkBkjCw@mail.gmail.com>
Subject: Re: [PATCH RESEND x3 v9 1/9] iov_iter: add copy_struct_from_iter()
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Chinner <dchinner@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 24, 2021 at 11:28 AM Omar Sandoval <osandov@osandov.com> wrote:
>
> I'll suggest the fixed-size struct encoded_iov again, then. If we're
> willing to give up some of the flexibility of a variable size, then
> userspace can always put the fixed-size structure in its own iovec or
> include it inline with the data, depending on what's more convenient and
> whether it's using O_DIRECT.

I really would prefer to have the separate pointer to it.

Fixed size doesn't help. It's still "mixed in" unless you have a
clearly separate pointer. Sure, user space *could* use a separate iov
entry if it wants to, but then it becomes a user choice rather than
part of the design.

That separate data structure would be the only way to do it for a
ioctl() interface, but in the readv/writev world the whole separate
"first iov entry" does that too.

I also worry that this "raw compressed data" thing isn't the only
thing people will want to do. I could easily see some kind of
"end-to-end CRC read/write" where the user passes in not just the
data, but also checksums for it to validate it (maybe because you're
doing a file copy and had the original checksums, but also maybe
because user space simply has a known good copy and doesn't want
errors re-introduced due to memory corruption).

And I continue to think that this whole issue isn't all that different
from the FSVERITY thing.

Of course, the real take-away is that "preadv2/pwritev2()" is a
horrible interface. It should have been more extensible, rather than
the lazy "just add another flag argument".

I think we finally may have gotten a real extensible interface right
with openat2(), and that "open_how" thing, but maybe I'm being naive
and it will turn out that that wasn't so great either.

Maybe we'll some day end up with a "preadv3()" that has an extensible
"struct io_how" argument.

Interfaces are hard.

                Linus
