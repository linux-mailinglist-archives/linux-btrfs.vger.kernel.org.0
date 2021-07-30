Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 043223DB44E
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Jul 2021 09:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237517AbhG3HMY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Jul 2021 03:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237403AbhG3HMW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Jul 2021 03:12:22 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20B0C061765
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Jul 2021 00:12:17 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id b25-20020a4ac2990000b0290263aab95660so2219532ooq.13
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Jul 2021 00:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZRSviXohDHIkiAFJ5gjIff/08r3n80IaaXOHz0+0/WI=;
        b=Qftr141/vUde1fXs/xvlhwQIxkBnAuTSxE8CJ8Ry3W4HgfC22T63Ewa7kpiUfXuKJK
         Pt7FkK5YrHqIYDDhGcLnc4Jq80iR0kSlJ8MT+Siq5TVVeYAK7/5hsxohgsyqbkXxj0OD
         WDef8VmREJHtR/Ie3ax/KN0xc+QNkStk2nvzWHMBbtkvqDLQpgJgfdN+VjVtM/JmXOES
         Dk0IqG679vNFNgWQmrt3PAC3cWWE+2PMptERNBTQ0STalH81BHgac2sFSX1CvSF/AY9m
         akBKFeN6XxPuayxefE9aj3IpXHQdbO6q+bdtVd2iceCJA2t1gJZ2LB1jNG2NNyoRmlGd
         aXGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZRSviXohDHIkiAFJ5gjIff/08r3n80IaaXOHz0+0/WI=;
        b=h6EETdKOUXsnVsKBBy1/3H7BqFDC8/9LmREOYf7c8ZE4Chd+pmLknC4NQ0qJZeSOTL
         PRvG9louEPOfUWAqAStSX4DEDbPPqa78v31cdr+pWsclbdCdlBdCIcNQHGcyqscWx4Np
         1TJasWRCJgUTGUbDzMaim2glKiR+/nYKm8CDpSUkdchHRL3nEz6aAEeuFy02htKLhWNK
         RHGTEKHm4dc+KRjk1x+wjJIqYXF3OgymiNFIuUwmXRHkPr6474zm2wzTzKhQ9VySbtyp
         WWV993nV1LQVDQPWIVwLsJli/4gMAJuAXjvZeq7JmiXpWodtqNXbPW7kKlRC1cHMbUwm
         kP7A==
X-Gm-Message-State: AOAM530VSLMAZv9b/PhODTdO2C1DHoCxg9AhaiDQpUTLze6gclP5n21x
        gXwcO0Q0QJxIpIMrR3ta3F+0RSmXfE3ugB/TRDY=
X-Google-Smtp-Source: ABdhPJyinKg/9/A+k1iYoXX6SpUcsyud3Uvyn6yP0IBQyDURyyENwB9CLoJ1YZbSsYN1e1XKxlnyoBoMtxehEyrN8Ls=
X-Received: by 2002:a4a:e907:: with SMTP id z7mr743927ood.20.1627629137130;
 Fri, 30 Jul 2021 00:12:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAHzMYBSap30NbnPnv4ka+fDA2nYGHfjYvD-NgT04t4vvN4q2sw@mail.gmail.com>
 <a5dd8f30-48f0-4954-f3fb-1a0722ae468f@gmail.com>
In-Reply-To: <a5dd8f30-48f0-4954-f3fb-1a0722ae468f@gmail.com>
From:   Jorge Bastos <jorge.mrbastos@gmail.com>
Date:   Fri, 30 Jul 2021 08:12:07 +0100
Message-ID: <CAHzMYBQ+ALSKJbNqDy_=pyHEB_Y3CZ4X=hRYpx+7SWAcF58qiw@mail.gmail.com>
Subject: Re: Why usable space can be so different?
To:     Andrei Borzenkov <arvidjaar@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 30, 2021 at 5:47 AM Andrei Borzenkov <arvidjaar@gmail.com> wrote:
>
>
> Is you "plot" (whatever it is) 100MiB or 100GiB? Because your first
> example has 34GiB available and from your description you cannot write
> anything - but I would be very surprised if you could not write another
> 100MiB to it.
>
> 100GiB would fit your description.
>
Yes, sorry, each file is around 100GiB.
