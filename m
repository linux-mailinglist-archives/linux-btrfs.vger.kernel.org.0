Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96A6910DE68
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Nov 2019 18:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbfK3Re7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 30 Nov 2019 12:34:59 -0500
Received: from mail-wr1-f43.google.com ([209.85.221.43]:39035 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbfK3Re7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 30 Nov 2019 12:34:59 -0500
Received: by mail-wr1-f43.google.com with SMTP id y11so35649328wrt.6
        for <linux-btrfs@vger.kernel.org>; Sat, 30 Nov 2019 09:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rwh7RlkpsoRn/PKbfEN3jUDubw1StnLMkl4hUnLT1tA=;
        b=r819GCJ5SJ3HYpNwi53hG06ZpJcmfHXSBWVKBjpFxAhyQXozhuMRiVs+RXE5bJIJPJ
         19ydb7QAJcVJFJlh/kq/oX4zuQLEYgTGALS3pMV9F+BsRztYM+2Y1RMQMY4zs8/AMWhI
         XjRIEFNpG6hxWRfkG7EdbZCyHi6pw52/UYkFzRubK5rKGcSS28IEJ3ZdfXUXmRL/mH/E
         O12NfzHu26T3KKAjXu+Qlv7+s+c6qDPC4ylsyHKQMzI+M0P4aDY1DPPcQy8qsJYvoFBC
         LXTHyuzvmuyowjUam/g3a2INCjuQWEpC+hcdX58X3seJEbp/mgeXHhdfsBv9u9BNgksW
         +zKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rwh7RlkpsoRn/PKbfEN3jUDubw1StnLMkl4hUnLT1tA=;
        b=eYM7Xn7DGcz1fqzHmD1IMtGGRM6B2yfpt+yhzVAE/djppsx4bWib+krXLhXNo07qV0
         H5A7BHlz6z5gxMVLnnrHaPCg8crLY5e5xixh9XbVAw6TzayP6A9ooBqSnKZvVi9yPrb8
         sz9YiylPRyEb4URsJCA27QsjZybUsclVfZwGXrSFfkTaTZe6TMGT4JrNbuY5jkjRn23d
         EuMWe3EaK1owJgFTjPPX5DRtgFDKxUeA4qUe4weoBTAnYS/IN8zhV1c9DL7+98AUELEa
         8o+x7XudqECQbvnLYEfaa6pKalM/FodjTtzPIES1sCpid2p6E9RZ7PNXkkD6naFK0pHH
         DWAQ==
X-Gm-Message-State: APjAAAWaaAFkdv0DG2RbMYZh/LDprjFQrwiJVeK219c77JAIwYAnaTI+
        1h4b3IA2dCh/FhGWYDaqFFfDW9OB9SCanaiNg6WXDQ==
X-Google-Smtp-Source: APXvYqz9+bAbT5xXHkNzDIj9Th4RqXxQz7mMIyLWuZGLWfOj7eVAqFjevCOidmbTfnlVXAcDohKB3l60T3UcAG8Tq9I=
X-Received: by 2002:adf:ea4e:: with SMTP id j14mr12055741wrn.101.1575135295833;
 Sat, 30 Nov 2019 09:34:55 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtSeZu8fRzjABXh3wxvBDEajGutAU4LWu0RcJv-6pd+RGQ@mail.gmail.com>
 <a48a6c50-3a03-0420-ad8c-f589fafe6035@libero.it> <CAJCQCtR6zMNKnhL7OZ8ZGCDwPfjC9a1cBOg+wt2VqoJTA_NbCQ@mail.gmail.com>
 <be389a15-4659-2cc8-ffe3-f2305f6f4775@gmail.com> <CAJCQCtTuu=k3FsKYmon4zP2b7c9D3zYzJwGZ3pLzFXMoJTepYA@mail.gmail.com>
 <6bc5b69e-188e-a7b2-e695-bd1bcb6a9ba3@gmail.com> <CAJCQCtQxR4Xnikz7vVxOX-gzU6aWzu5eHeG95HOKsx40ziTGLg@mail.gmail.com>
 <8a86c7ef-39ab-7c35-f39b-e05ab7543a11@gmail.com> <CAJCQCtRsjA=TTY8XY3QLO_uJVsGD1-E7k3OvnOdTnOJ76pezVw@mail.gmail.com>
In-Reply-To: <CAJCQCtRsjA=TTY8XY3QLO_uJVsGD1-E7k3OvnOdTnOJ76pezVw@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sat, 30 Nov 2019 10:34:39 -0700
Message-ID: <CAJCQCtTP1oqGys_ORPyEqWnR1=HXq4qkZnU9gXMOgNuOD-e7JA@mail.gmail.com>
Subject: Re: GRUB bug with Btrfs multiple devices
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Andrei Borzenkov <arvidjaar@gmail.com>,
        Goffredo Baroncelli <kreijack@inwind.it>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Nov 30, 2019 at 10:14 AM Chris Murphy <lists@colorremedies.com> wrote:
>
> On Sat, Nov 30, 2019 at 10:02 AM Andrei Borzenkov <arvidjaar@gmail.com> wrote:
> >
> > GRUB is normally using hints - grub-install (and grub-mkconfig) tries to
> > guess firmware device name. At boot time grub tries to access hinted
> > device first, if it succeeds, it does not try anything else. With second
> > btrfs partition grub needs to find second device at boot time so it now
> > probes everything and hits those vendor media devices.
> >
> > At least this explains what you see as well as ...
> >
> > > Last time this
> > > happened, all I did was remove the 2nd device and the problem went
> > > away.
> >
> > ... this.
>
> Ahhh, that makes complete sense. So it is Btrfs multiple device
> related, but not a bug in btrfs.c per se.
>
> >
> > If you go in grub shell in this state (without errors), do you see those
> > ghost devices?
>
> Uncertain. My vague memory recall is that yes they are there, because
> I found their existence strange and different compared to pre-GRUB
> 2.02 where on this same system I'd see only either hd0 or hd1 (one
> without the other), along with cd0. But something changed either with
> a firmware update from Apple, or GRUB, that resulted in additional
> GRUB devices, hd2, hd3, hd4, hd5.

OK my vague memory  is correct with respect to phantom devices still
present after Brfs device removal.


>
> > > I'm ready to try that again (remove the 2nd device) and see if
> > > the problem goes away, but has enough information been collected about
> > > the present state?
> > >
> > >
> >
> > If you are reasonably sure that all errors are related to those phantom
> > devices - I would say yes, the reason for these phantom devices to exist
> > is already clear.
>
> I'll give it a shot in a bit.

Yep, the errors no longer happen; but phantom devices still there.
I've posted to grub-devel@ and updated it with this latest
information.


-- 
Chris Murphy
