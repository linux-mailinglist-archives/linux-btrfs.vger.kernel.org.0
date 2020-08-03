Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F06923A03D
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Aug 2020 09:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbgHCHZ3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Aug 2020 03:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725270AbgHCHZ0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Aug 2020 03:25:26 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9FBC06174A;
        Mon,  3 Aug 2020 00:25:26 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id i92so7272033pje.0;
        Mon, 03 Aug 2020 00:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=to4odp1EU84jY7NPS+Ne28o7/CevkLRl0Wqah8jQXE8=;
        b=O5SDH4WdNlUsy4HbeFubvtlZJpGBS5lHiqd28mVxNJcoQvt95IPUdwOMzy9qeB/kBL
         J7LSKwEMD7+MFD5DQ+nxSPf3hmOFD5giyledMdrvjGQtJ9S5gDnchD/AQ9OUB6oC5xMe
         HHCj6htwsVAEdxlPw02DH5S5uGqV9zdBidwYEW9RV/2hbulRGMcVZXBxSiFGBWqOZesj
         2kVDa1Hi5IM+Eum/KzNuZ1IZjVDybQe79U1np/gNtS0U/Z165z9ACk7HTPD9ndmaQo/8
         Dcv8ylrYoND8Wv9erH+RZwUL2mqqvPaKN6nQ1t+Tmw+DmvQW/kabPMQ+/g0UAkOUsxlZ
         D0CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=to4odp1EU84jY7NPS+Ne28o7/CevkLRl0Wqah8jQXE8=;
        b=mUx8PptO4Q4CnTx3T8S1N93Qf5LwuVgs3+2S4YH0vwnW5d5AaAyxZibZiGC4OaMT05
         Q4SxiS0rKDpY2vQ/U36nKjkoXJ5SAJHX8nOsikiL2ioJpRO8eJfisK6Ar1JAbkWqb0Yk
         GCLt5RYPtXKttRdjt98t8bknPh3Qejr9m3wee/JJU1SWaxZ0lzCFn4npzH1C7hpDapEW
         NVm0bAkjjz6q7TWxYMK+QXNTPPaLWy3082/9ttsNvQ+P6TCKP2nPKCDwUWOIUHv+C/UP
         QPuyFLvVYa77aTfJWDSACUWaDgRAbRJNR1kJe0ab+350nUO3Zrq2wV8nP+Nl4cUFd7ai
         qxNg==
X-Gm-Message-State: AOAM532Uwz8OIA7+SwGGXbaPIba3ZP9pGhDIbRWLhGgY3vwi+CBcsnl1
        8r6AyF6xXbsKwLaZdFqcP7A+BpmXeZDteCLCc5pLySIE
X-Google-Smtp-Source: ABdhPJzyF4NRF1oPCywZLE6fn/M3iN0NHD1/e5vlz6HFEV3eAV6I/KCbM82H2ys2YV9ReTsyimi4RA1cJmwyxPh3TwM=
X-Received: by 2002:a17:90a:a393:: with SMTP id x19mr16414053pjp.228.1596439526201;
 Mon, 03 Aug 2020 00:25:26 -0700 (PDT)
MIME-Version: 1.0
References: <1908555.IiAGLGrh1Z@kreacher> <d1e90fa3-d978-90ae-a015-288139be3450@gmx.com>
In-Reply-To: <d1e90fa3-d978-90ae-a015-288139be3450@gmx.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 3 Aug 2020 10:25:11 +0300
Message-ID: <CAHp75VcbSR1NSSPemg5dMyfp00uC4wkktVjKSFx4sjSgFC-_vQ@mail.gmail.com>
Subject: Re: [PATCH] kobject: Avoid premature parent object freeing in kobject_cleanup()
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Guenter Roeck <guenter@roeck-us.net>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 3, 2020 at 9:47 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> On 2020/6/5 =E4=B8=8A=E5=8D=881:46, Rafael J. Wysocki wrote:

...

> > +/**
> > + * kobject_del() - Unlink kobject from hierarchy.
> > + * @kobj: object.
> > + *
> > + * This is the function that should be called to delete an object
> > + * successfully added via kobject_add().
> > + */
> > +void kobject_del(struct kobject *kobj)
> > +{
> > +     struct kobject *parent =3D kobj->parent;
> > +
> > +     __kobject_del(kobj);
> > +     kobject_put(parent);
>
> Could you please add an extra check on kobj before accessing kobj->parent=
?

I do not understand. Where do we access it?
kobject_put() is NULL-aware.

> This patch in fact removes the ability to call kobject_del() on NULL
> pointer while not cause anything wrong.
>
> I know this is not a big deal, but such behavior change has already
> caused some problem for the incoming btrfs code.
> (Now I feels guilty just by looking into the old
> kobject_del()/kobject_put() and utilize that feature in btrfs)
>
> Since the old kobject_del() accepts NULL pointer intentionally, it would
> be much better to keep such behavior.

Can you elaborate, please?

--=20
With Best Regards,
Andy Shevchenko
