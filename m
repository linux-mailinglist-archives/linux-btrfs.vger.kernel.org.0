Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7910723A045
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Aug 2020 09:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725957AbgHCH2G (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Aug 2020 03:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbgHCH2G (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Aug 2020 03:28:06 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E838DC06174A;
        Mon,  3 Aug 2020 00:28:05 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id g33so1973190pgb.4;
        Mon, 03 Aug 2020 00:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=N8zgir2t6iz+UzxYd4zks8afHq+WgZA6FxDNrIQU9Os=;
        b=Ayp/5J2QerO98j5FTZXgOsm/l7P13p1jZTmxOiPYzilbU3iF4mOJ963AdohSAxIarp
         tUpf77dm/pgjeBVnKt6kOkQBcjo/qMHVf+ZHRblG6+4HGgns4nIWUNGdKApPCrZWQPNq
         1MQYTS24sK9qMyflFSOtYPSjMKUMEoOFm33ZQE7B//nJLcZic9M15NCMfEUjWPLJ1K2v
         c1BCs8Sn1BhbeXWkDS6/160JlKVphA2DNOPnNPW41A+lkJ1/GXzMctWeNtxiXtbH7ML+
         T/RgNadtDGFnFDLospGXMcXKtPxDjezWxM0PtOB2qNPlC5bwQF5b5Z/aNbEyq3c1tJSL
         V0Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=N8zgir2t6iz+UzxYd4zks8afHq+WgZA6FxDNrIQU9Os=;
        b=W67fiU9PROW+FjhyOt6Sh4skl/cp6TKYMTDj00xIBD+UpMIB/ui+9+zQO0DkcYfdrE
         9v52csPf+OuDsmCZyM0DjkA4ljD9J0YJAYGHyYYwp6UUsj9eQAcVqMXoJl4C3ys0bGNL
         02ZLHEAlfbE+z3i8iJxjZkizrDFCdjQctgcpGESHhsCBsZDHhAsB02NOBEYKW8KUs6Yj
         CjDpr+foDMVtoigvB4oSp2Uvit2Enoc7u80HTTXU0LYocysqszRw2F9UpulQ1nj+qXOw
         RyEitlaiyNCPR8ed/pZ4scnewUcfsdHfCTRxLQtMYAFX7Op0S5LmcF/+p89fjjkNAyKK
         3ToA==
X-Gm-Message-State: AOAM5320Q5QAstdG2cUay8ggmJzb+O+WTpcfl665mUpmXj5CG3qCueup
        tIl07qB8KdtVJdQVhizTFj1esLs+BA/FnhdFsqw=
X-Google-Smtp-Source: ABdhPJxh35hxOxLvbxYM11D1X/DCFK3iTFLAPLT06Tw2ajS2oTu5VgSzssa5npOEGiWLd9bsOX5S0j8EHiIUrBhS230=
X-Received: by 2002:a62:7b4e:: with SMTP id w75mr14134631pfc.130.1596439685437;
 Mon, 03 Aug 2020 00:28:05 -0700 (PDT)
MIME-Version: 1.0
References: <1908555.IiAGLGrh1Z@kreacher> <d1e90fa3-d978-90ae-a015-288139be3450@gmx.com>
 <CAHp75VcbSR1NSSPemg5dMyfp00uC4wkktVjKSFx4sjSgFC-_vQ@mail.gmail.com>
In-Reply-To: <CAHp75VcbSR1NSSPemg5dMyfp00uC4wkktVjKSFx4sjSgFC-_vQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 3 Aug 2020 10:27:50 +0300
Message-ID: <CAHp75Ve0AozEbB_kc+S4qaZJxJJWf20toDK-T2QHYi1o2hfJBg@mail.gmail.com>
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

On Mon, Aug 3, 2020 at 10:25 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Mon, Aug 3, 2020 at 9:47 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> > On 2020/6/5 =E4=B8=8A=E5=8D=881:46, Rafael J. Wysocki wrote:

> > > +void kobject_del(struct kobject *kobj)
> > > +{
> > > +     struct kobject *parent =3D kobj->parent;
> > > +
> > > +     __kobject_del(kobj);
> > > +     kobject_put(parent);
> >
> > Could you please add an extra check on kobj before accessing kobj->pare=
nt?
>
> I do not understand. Where do we access it?
> kobject_put() is NULL-aware.

Ah, I see, now.

Should be something like
    struct kobject *parent =3D kobj ? kobj->parent : NULL;

> > This patch in fact removes the ability to call kobject_del() on NULL
> > pointer while not cause anything wrong.
> >
> > I know this is not a big deal, but such behavior change has already
> > caused some problem for the incoming btrfs code.
> > (Now I feels guilty just by looking into the old
> > kobject_del()/kobject_put() and utilize that feature in btrfs)
> >
> > Since the old kobject_del() accepts NULL pointer intentionally, it woul=
d
> > be much better to keep such behavior.


--=20
With Best Regards,
Andy Shevchenko
