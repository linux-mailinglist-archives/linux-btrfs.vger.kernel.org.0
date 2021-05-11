Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6F0E37A896
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 May 2021 16:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbhEKOKi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 May 2021 10:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbhEKOKh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 May 2021 10:10:37 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A52C061574
        for <linux-btrfs@vger.kernel.org>; Tue, 11 May 2021 07:09:29 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id g65so11210933wmg.2
        for <linux-btrfs@vger.kernel.org>; Tue, 11 May 2021 07:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bookwar-info.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JQgOnRgOel2l9KZqC5IKCS8//x2iw98DmvIjyZPHtC0=;
        b=FM63gUMlOw0VDCXw0KtnaKTQQYS5S658woDYMyxhT0+/tU/LuX048z4/2eWj0qWXhl
         /rRWuL08rqgRNqHcTPY4o/tJeiawct9TcpurRZmZg0ovkaxsYOBLImSfgzp3W4S9NlxW
         Wy9yuwWQplqgrQ5yvZ5eUIO9xkVUR0g3RNNCqgyRgLnY72QXZNGV2BXIpJy1j47fl7rE
         TysvSupn9NyPmw394BpGWUMCgNPK03AI37SuZZAXixapINIDuOE5h/U83e65A3UUm+70
         Yz/TcwAzjhcCtwlo1eqUBg8xdIfn6trY1nHrr4TziexBSFraDsH/JsklRFBlCJg9COiO
         eTvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JQgOnRgOel2l9KZqC5IKCS8//x2iw98DmvIjyZPHtC0=;
        b=ddL0LQVNPWU1MGsHXLjZylzQsN6xC7nQC+DxAt6UtdsLaHKQgQ8jQaRd1id6j7aDGS
         S4GO3ECQ1ZTTzDmy440+kTizlIevrZVJ1istmgfL0Ti1kV2DBcp3vmzA0m+Lho/fUuNm
         blshZ6DZzVYDYgwVzJQu5NZTkVgqjzQnpmyJ2Uu+9W5dF+sGj9sWxlK/lnH1tD2YT8ws
         Aw9ngz6TaCfZ4y1jsyuBr9yfxaVFdpxsGqaViCITdVATq2Tf+bgullpQYGrK2Tmgl9CA
         Af7ELGiQ3c63c1P9bhJYwPd9GZSHomGGlBZ9hjHiIgex6xVebx8o7dnNh0yNeSpgNs7m
         rJdA==
X-Gm-Message-State: AOAM531kacZ0Wjg6X+6tiefy7hOnuJrO6VvN56jCRmPqHxVDaB5mCisz
        mYwm0ce7vXBU1DNfJxQhx4otbbJz3yXdunIypOM=
X-Google-Smtp-Source: ABdhPJwnUKPS31m4lf6PPPkz+wBW6AaRxhKpRJU2bWDCH9LIB27UKKC0BZtXo/q84SCY7LuszlwwdFk4IwUv/Hx0Pdk=
X-Received: by 2002:a7b:cf3a:: with SMTP id m26mr33344289wmg.49.1620742168194;
 Tue, 11 May 2021 07:09:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAEg-Je-s+9qZYFgqheW991EgUjA7OAUBM3+LvJB6px4hc15J+w@mail.gmail.com>
In-Reply-To: <CAEg-Je-s+9qZYFgqheW991EgUjA7OAUBM3+LvJB6px4hc15J+w@mail.gmail.com>
From:   Aleksandra Fedorova <alpha@bookwar.info>
Date:   Tue, 11 May 2021 16:09:12 +0200
Message-ID: <CAJ2r3Z3wKvomfW8N32KEPFuH=VTf7LCjuPVTE87=ROkZjj4fkQ@mail.gmail.com>
Subject: Re: Fedora CI for btrfs-progs? (was Btrfs progs release 5.12)
To:     Neal Gompa <ngompa13@gmail.com>
Cc:     David Sterba <dsterba@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Davide Cavalca <dcavalca@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Continuous Integration and Continuous Delivery for
         Fedora <ci@lists.fedoraproject.org>, ttomecek@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi, Neal,

On Mon, May 10, 2021 at 8:50 PM Neal Gompa <ngompa13@gmail.com> wrote:
>
> On Mon, May 10, 2021 at 11:04 AM David Sterba <dsterba@suse.com> wrote:
> >
> > Hi,
> >
> > btrfs-progs version 5.12 have been released.
> >
> > Notable things:
> >
> [...]
> >
> > * travis-ci integration has been disabled, I'd like to find another hosted CI
> >   but so far none provides a recent kernel so more tests won't pass, last option
> >   is to self-host some VMs and monitor git, getting just build tests works but
> >   we need to run the testsuite
> >
>
> This is unfortunate. However, I've been noodling around the idea of
> asking the Fedora CI folks if we could add upstream CI using Fedora on
> VMs. I guess now is as good of a time as any...
>
> Aleksandra, are there any resources we could use to wire up
> btrfs-progs against Fedora latest stable and Rawhide across
> architectures so the code could be continually tested as changes are
> landed? There's that fancy Zuul instance[1] that might be useful here.

I suggest that you talk with the Packit team.

Packit provides Packit As a Service [1] approach to test upstream
changes packaged on top of the latest Fedora or CentOS Stream
environment.
For example you can use it on GitHub by enabling the Packit GitHub App
for you repository and adding the rpm spec file in the repo.

Afaik Packit can run tests not only on containers but also on virtual
machines. So it is technically possible to run more complex scenarios
which require latest Fedora kernel.

CC'ed Tomas Tomecheck from Packit.

[1]  https://packit.dev/docs/packit-as-a-service/


-- 
Aleksandra Fedorova
bookwar
