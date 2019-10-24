Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 598D1E2F42
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2019 12:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407948AbfJXKmR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Oct 2019 06:42:17 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42115 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393146AbfJXKmR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Oct 2019 06:42:17 -0400
Received: by mail-ed1-f68.google.com with SMTP id s20so12249518edq.9
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Oct 2019 03:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gO2VLBmmvvu9+CAuaDsVVCk9Mpn2vZu/y3Zcjvcedxg=;
        b=ulL01thwXTIH5L5379Po2JxVBCKlCu+dzFyVjjY4v7PCW+Ch3TLGSgFs+tokoqBVls
         hRxZrW8Rkl43sazI69WqdsNR7QFZuBBiNY28iXS2KPdRaQhbEJircTFiaDRWY6g+DTEf
         Vlaz3LmeOgbcZgWqW8nL1H9UB2jTN6Src/E2IZLVemzIXgznx/7xBs1NrNBm9PV7NCOs
         /7caHaXrcVqj4nsoQZRAcRI0nTNUWhHCTtlPxX9tGJxRDmqCvXF4OxS8FHG7WLb6WxKN
         ZOPrWJ+1VJB69L3TMvxmp+uQyV3HMjkfKT9xPlHu/DXy72DZB7C+CjDyHzhyRPFWEOo4
         N9CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gO2VLBmmvvu9+CAuaDsVVCk9Mpn2vZu/y3Zcjvcedxg=;
        b=bU3NCx6UsJH0eZ92F2G/JHzw8yA2qdUF0Z6wEiODuBGAA2PMXFTL3WVFTLtu6vYQeR
         7NLyo0wNcIz482GogOY2ZZ6equNXz4bvMSo0y68THhFklD3Xppu2qAzi3Ahnt59/qHvp
         TpJ0lVilhijMba6Vjg7BcJs+IPAv9U19oTU2o2qQ5CZNy2cAbfByRXiC8YBhreSXbDkk
         8hZvuEFvPGwVty+bfszrzJo7a9LeiqfXQlNMX/aYl0jRdRGpbS8PyGsn9FrjZf1JN/aM
         tiEzD3fjYfKIzMa+3WX1c82RW+ezhmwT0QyfESLtpnCMvHcqoTL+N6uM1j5VVvYfB1j0
         SJcA==
X-Gm-Message-State: APjAAAWmxcodjcinQEWVa50EoNadqiX3zf+MLn5Bc7JRnOMQXcd1Hj+s
        jIgsowAdpGTFnlkkZ9U3pQ3hXMhdC8IT3uNbwjDN
X-Google-Smtp-Source: APXvYqxxH9SAcaK73+BdmFX8iWZCmvGDfTAtCsuicVBCM41q9IMIjPg3vnJrOEJhUK0JSaYQHj5zSknimW5hjCo3Euc=
X-Received: by 2002:aa7:dcd4:: with SMTP id w20mr23134948edu.52.1571913733814;
 Thu, 24 Oct 2019 03:42:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAKbQEqE7xN1q3byFL7-_pD=_pGJ0Vm9pj7d-g+rRgtONeH-GrA@mail.gmail.com>
 <CAKbQEqG35D_=8raTFH75-yCYoqH2OvpPEmpj2dxgo+PTc=cfhA@mail.gmail.com>
 <4608b644-0fa3-7212-af45-0f4eebfb0be9@gmx.com> <CAKbQEqG8Sb-5+wx4NMfjORc-XnCtytuoqRw4J9hk2Pj9BNY_9g@mail.gmail.com>
 <CAKbQEqGwYCB1N+MQVYLNVm5o10acOFAa_JyO8NefGZfVtdyVBQ@mail.gmail.com>
 <fe882b36-0f7b-5ad5-e62e-06def50acd30@gmx.com> <CAKbQEqEuYqxO8pFk3sDQwEayTPiggLAFtCT8LmoNPF4Zc+-uzw@mail.gmail.com>
 <e0c57aba-9baf-b375-6ba3-1201131a2844@gmail.com> <CAKbQEqFdY8hSko2jW=3BzpiZ6H4EV9yhncozoy=Kzroh3KfD5g@mail.gmail.com>
 <20f660ea-d659-7ad5-a84d-83d8bfa3d019@gmx.com> <CAKbQEqGPY0qwrSLMT03H=s5Tg=C-UCscyUMXK-oLrt5+YjFMqQ@mail.gmail.com>
 <0d6683ee-4a2c-f2ab-857b-c7cd44442dce@gmail.com>
In-Reply-To: <0d6683ee-4a2c-f2ab-857b-c7cd44442dce@gmail.com>
From:   Christian Pernegger <pernegger@gmail.com>
Date:   Thu, 24 Oct 2019 12:41:37 +0200
Message-ID: <CAKbQEqGoiGbV+Q=LVfSbKLxYeQ5XmLFMMBdq_yxSR7XE3SwsmA@mail.gmail.com>
Subject: Re: first it froze, now the (btrfs) root fs won't mount ...
To:     "Austin S. Hemmelgarn" <ahferroin7@gmail.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I must admit, this discussion is going (technical) places I don't know
anything about, and much as I enjoy learning things, I'd rather not
waste your time (go make btrfs better! :-p). When all is said and done
I'm just a user. I still don't understand how (barring creatively
defective hardware, which is of course always in the cards) a crash
that looked comparatively benign could lead to an fs that's not only
unmountable but unfixable; how metadata that's effectively a single
point of failure could not have backup copies designed in that are
neither stale nor left to the elements, seems awfully fragile -- but I
can accept it. Repair is out.

Recovery it is, then. I'd like to try and build this rescue branch of
yours. Does it have to be the whole thing, or can btrfs alone be built
against the headers of the distro kernel somehow, or can the distro
kernel source be patched with the rescue stuff? Git wasn't a thing the
last time I played with kernels, a shove in the right direction would
be appreciated.

Relapse prevention. "Update everything and pray it's either been fixed
or at least isn't triggered any more" isn't all to
confidence-inspiring. Desktop computers running remotely current
software will crash from time to time, after all, if not amdgpu then
something else. At which point we're back at "a crash shouldn't have
caused this". If excerpts from the damaged image are any help in
finding the actual issue, I can keep it around for a while.

Disaster recovery. What do people use to quickly get back up and
running from bare metal that integrates well with btrfs (and is
suitable just for a handful of machines)?

Cheers,
C.

P.S.: MemTest86 hasn't found anything in (as yet) 6 passes, nothing
glaringly wrong with the RAM.
