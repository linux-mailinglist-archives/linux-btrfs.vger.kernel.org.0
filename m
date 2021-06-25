Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2F5C3B474A
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Jun 2021 18:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbhFYQS4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Jun 2021 12:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbhFYQS4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Jun 2021 12:18:56 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B238C061767
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Jun 2021 09:16:35 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id f30so17193890lfj.1
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Jun 2021 09:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LoG9DHygRjJYEXURLzSM71rAKIxITMJD9Hkh3VbJzrY=;
        b=av+bQrr5b5kQTmtUU/uB7PzdV8FL54n4I97oc56slPbT6MAKkVqessm0tDlUDEN1H2
         UVsQbC1465BjkFLIUxy9E3tycgt4lSFot0VGHK2oOfPjc0R96+xfjLDkO1VRswqjHvpI
         01nxEx5e0aw9US6zIfsCjApiakA55LRBturTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LoG9DHygRjJYEXURLzSM71rAKIxITMJD9Hkh3VbJzrY=;
        b=GAFSXvcM3+C7xdyNzvGt+GNJ92aoGZD6Ra59B3Bm5RvHKYxnTi0fiEvonHG8YbYxBh
         wcbWsCqckow6JUYJSHnhUdU+4f981tShD3QRQxm8mlUfwiHhqpBOyehy4bOxIQC4pqie
         AgnaS0YYHMi6fmNW/Poh3AmeglRtADVxxg5JAw+NxFcVnXyhVqrqqB7f0k4bQSXyUvQZ
         OFsw9f9Ex/vpbtEtfMbJ5hL1kuUiSouJURqadxN5tQxILsIAEHKhuxD2m0DJ1IPhf3pU
         jqY0DZ4yTGeDKJtLVKCbzNSxvHP8ah5pjIAgldpAhT2oLAxtZBsGX7hcL0CpRtb3emDI
         oapQ==
X-Gm-Message-State: AOAM531gbxpzSUEJps3TKIKhGayLodaJ3VpT5k7Iq+pNijwUONBEkoKy
        JZkuQ9hgk/gbD9waoA5KZgFjF7nt6kN7fBXLoa8=
X-Google-Smtp-Source: ABdhPJwUn0v2z8kBoV2lVdxP6VCRx+QBNRjQG1/pK9U2DTuMyvjVpMkxWQWYM1X/WokJRG05tOujnQ==
X-Received: by 2002:a05:6512:b84:: with SMTP id b4mr9293612lfv.477.1624637793037;
        Fri, 25 Jun 2021 09:16:33 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id k11sm545817lfv.291.2021.06.25.09.16.31
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jun 2021 09:16:31 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id a11so17071627lfg.11
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Jun 2021 09:16:31 -0700 (PDT)
X-Received: by 2002:a05:6512:3f82:: with SMTP id x2mr8373954lfa.421.1624637791386;
 Fri, 25 Jun 2021 09:16:31 -0700 (PDT)
MIME-Version: 1.0
References: <YNOPdy14My+MHmy8@zeniv-ca.linux.org.uk> <YNOdunP+Fvhbsixb@relinquished.localdomain>
 <YNOqJIto1t13rPYZ@zeniv-ca.linux.org.uk> <YNOuiMfRO51kLcOE@relinquished.localdomain>
 <YNPnRyasHVq9NF79@casper.infradead.org> <YNQi3vgCLVs/ExiK@relinquished.localdomain>
 <CAHk-=whmRQWm_gVek32ekPqBi3zAKOsdK6_6Hx8nHp3H5JAMew@mail.gmail.com>
 <YNTO1T6BEzmG6Uj5@relinquished.localdomain> <CAHk-=wi37_ccWmq1EKTduS8ms_=KpyY2LwJV7roD+s=ZkBkjCw@mail.gmail.com>
 <yq1tulmoqxf.fsf@ca-mkp.ca.oracle.com> <YNVPp/Pgqshami3U@casper.infradead.org>
In-Reply-To: <YNVPp/Pgqshami3U@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 25 Jun 2021 09:16:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgH5pUbrL7CM5v6TWyNzDYpVM9k1qYCEgmY+b3Gx9nEAA@mail.gmail.com>
Message-ID: <CAHk-=wgH5pUbrL7CM5v6TWyNzDYpVM9k1qYCEgmY+b3Gx9nEAA@mail.gmail.com>
Subject: Re: [PATCH RESEND x3 v9 1/9] iov_iter: add copy_struct_from_iter()
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Omar Sandoval <osandov@osandov.com>,
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

On Thu, Jun 24, 2021 at 8:38 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> Does it make any kind of sense to talk about doing this for buffered I/O,
> given that we can't generate them for (eg) mmaped files?

Sure we can.

Or rather, some people might very well like to do it even for mutable
data. In fact, _especially_ for mutable data.

You might want to do things like "write out the state I verified just
a moment ago", and if it has changed since then, you *want* the result
to be invalid because the checksums no longer match - in case somebody
else changed the data you used for the state calculation and
verification in the meantime. It's very much why you'd want a separate
checksum in the first place.

Yeah, yeah,  you can - and people do - just do things like this with a
separate checksum. But if you know that the filesystem has internal
checksumming support _anyway_, you might want to use it, and basically
say "use this checksum, if the data doesn't match when I read it back
I want to get an IO error".

(The "data doesn't match" _could_ be just due to DRAM corruption etc,
of course. Some people care about things like that. You want
"verified" filesystem contents - it might not be about security, it
might simply be about "I have validated this data and if it's not the
same data any more it's useless and I need to re-generate it").

Am I a big believer in this model? No. Portability concerns (across
OS'es, across filesystems, even just across backups on the same exact
system) means that even if we did this, very few people would use it.

People who want this end up using an external checksum instead and do
it outside of and separately from the actual IO, because then they can
do it on existing systems.

So my argument is not "we want this". My argument is purely that some
buffered filesystem IO case isn't actually any different from the
traditional "I want access to the low-level sector hardware checksum
data". The use cases are basically exactly the same.

Of course, basically nobody does that hw sector checksum either, for
all the same reasons, even if it's been around for decades.

So my "checksum metadata interface" is not something I'm a big
believer in, but I really don't think it's really all _that_ different
from the whole "compressed format interface" that this whole patch
series is about. They are pretty much the same thing in many ways.

                Linus
