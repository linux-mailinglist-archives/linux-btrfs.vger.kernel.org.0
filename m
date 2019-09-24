Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8C60BC641
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2019 13:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504544AbfIXLIQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Sep 2019 07:08:16 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:41562 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504517AbfIXLIP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Sep 2019 07:08:15 -0400
Received: by mail-vs1-f67.google.com with SMTP id l2so1016418vsr.8
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Sep 2019 04:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ndctJhoRHCC+qxNgc9m3CnahrITUysjKelj0cqBG3Lc=;
        b=mqvGHQ8BF5JR4SMDnfliR/XtLWqazPTpqLNx2lxRNYqfNSk1GwLP9q9Ie3I+E86wv3
         TwTeK1fUNX5sdgVU6UO+JjekYazh+Es8KcUA3oNa1JjEB4Mu0eHFu6aVm/s5eQFn/AKo
         pJxxOARhEeMLz/4Xo+skuZ50GlVlCJYnVC7utCH9vbWHDzf/AjcZYjTeaECyKRReQgzV
         6VeBvjYHJ1F2r0WfEV8pFTAFCY4d2SMEKjAgI4I51gjsgpq087313UvmpMqbMW5whujY
         iFqcxATFwevgHuf+QJftDorHVputwYERN9ZnqGtTb3IeUmXQtxssU6gEU1QMydt5IBfK
         Efvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ndctJhoRHCC+qxNgc9m3CnahrITUysjKelj0cqBG3Lc=;
        b=lBT1qtT/OnKuLNqbUNN0vfjbFqw+dWoYiSnh/bV+a0mQRax+NGRAh+HB5Eon9iSdx0
         XBZgaXJOYG6VE3BaU5+5lP437cSq7py1Vvb+bBdrtY3m/UO6ORyA8qlJ9yRW7rnRBX/q
         aEw7s5cMV5QCrVkM3HZjE2Yhj1LiayXr3OpUehCMmwDLC5Gcl1SvNetDf6TQ/RBAvWjF
         mYojvxfn01LdloYFJWbXyOk0t9KanRRNNyTM8fTdTIBIb30hNbNbgs88Ga1aGEFXbSN+
         D02Ivq+oYvxxXl6qfABjNamsF4O7pZNA4Cx4iGgf3ZB0IKSdE4w3Qr/bd3cGUAzvbV3V
         xbqA==
X-Gm-Message-State: APjAAAV7ubqirBfrQQMTea7IDgD6dA0nDv7UDgwPWgwFysUCzD2JUByx
        Q8rL25JBzS20mDcNKlTiD6TuDRS1h2Sridpdpls=
X-Google-Smtp-Source: APXvYqyMBQUMFYfFU/aSyrz8U84Uz5TwOlvlEtuH8RUerGMIbKiFJ+98WmR0xr4YcpAxOCHVEvkjtW2xyE8LenBNg+M=
X-Received: by 2002:a67:2d95:: with SMTP id t143mr1102634vst.47.1569323294538;
 Tue, 24 Sep 2019 04:08:14 -0700 (PDT)
MIME-Version: 1.0
References: <CA+X5Wn7Rtw4rTqXTG8wrEc883uFV7JpGo-zD8FhhD9gM+_Vpfg@mail.gmail.com>
 <CAL3q7H41BpuVTHOAMOFcVvVsJuc4iR10KKPDVfgEsG=ZEpwmWw@mail.gmail.com> <CAL3q7H4wDdzfA+H0HPk7oKNO3PDiN1nYHpRu5v6rRXvxQFVLbQ@mail.gmail.com>
In-Reply-To: <CAL3q7H4wDdzfA+H0HPk7oKNO3PDiN1nYHpRu5v6rRXvxQFVLbQ@mail.gmail.com>
From:   James Harvey <jamespharvey20@gmail.com>
Date:   Tue, 24 Sep 2019 07:07:41 -0400
Message-ID: <CA+X5Wn4ZmwnJry0zjyAYow-jEU7PSdE16ROSqfaKyGavLoGVQQ@mail.gmail.com>
Subject: Re: WITH regression patch, still btrfs-transacti blocked for... (forever)
To:     Filipe Manana <fdmanana@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 24, 2019 at 5:58 AM Filipe Manana <fdmanana@gmail.com> wrote:
>
> On Sun, Sep 15, 2019 at 2:55 PM Filipe Manana <fdmanana@gmail.com> wrote:
> >
> > On Sun, Sep 15, 2019 at 1:46 PM James Harvey <jamespharvey20@gmail.com> wrote:
> > > ...
> > > You'll see they're different looking backtraces than without the
> > > patch, so I don't actually know if it's related to the original
> > > regression that several others reported or not.
> >
> > It's a different problem.
>
> So the good news is that on upcoming 5.4 the problem can't happen, due
> to a large patch series from Josef regarding space reservation
> handling which, as a side effect, solves that problem and doesn't
> introduce new ones with concurrent fsyncs.
>
> However that's a large patch set which depends on a lot of previous
> cleanups, some of which landed in the 5.3 merge window,
> Backporting all those patches is against the backport policies for
> stable release [1], since many of the dependencies are cleanup patches
> and many are large (well over the 100 lines limit).
>
> On the other it's not possible to send a fix for stable releases that
> doesn't land on Linus' tree first, as there's nothing to fix on the
> current merge window (5.4) since that deadlock can't happen there.
>
> So it seems like a dead end to me.
>
> Fortunately, as you told me privately, you only hit this once and it's
> not a frequent issue for you (unlike the 5.2 regression which
> caused you the hang very often). You can workaround it by mounting the
> fs with "-o notreelog", which makes fsyncs more expensive,
> so you'll likely see some performance degradation for your
> applications (higher latency, less throughput).
>
> [1] https://www.kernel.org/doc/html/v4.15/process/stable-kernel-rules.html


All understood, thanks for letting me know.  Not a problem.  I have
still only ran into this crash once, about 9 days ago.  I haven't had
another btrfs problem since then, unlike the hourly hangs on 5.2 with
heavy I/O.
