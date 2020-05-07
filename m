Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08A4A1C8646
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 May 2020 12:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgEGKAk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 May 2020 06:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726587AbgEGKAE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 7 May 2020 06:00:04 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38AB8C061A41
        for <linux-btrfs@vger.kernel.org>; Thu,  7 May 2020 03:00:04 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id a15so362780qvt.9
        for <linux-btrfs@vger.kernel.org>; Thu, 07 May 2020 03:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xIIlIbxNm8YnMEaQ1RWyeJXqyhEpKzPdTOxxiIKLG78=;
        b=PTY22LtZIh2nBXAAG0Vc6DwGbPg9QhVdsXS2ARoyeYoc7LP8dWKVKR6y1yljUY6Emt
         2hLxNfTi1gui7kx8avgQV8AqCILTC7mxYD6Rcuvo1JIJvxWXOfaFLXPhImstf4CiejeO
         aZX+zY67ww9Lc9hkFxm+tiH429rzSXIAF0NN3BzJ2wMTQH4JlgFQp1iADeI5RAYOu2fx
         Kzk94NIxBpJWqRlOONWI1I4B7IWSjlJjjbUwDA20sridvMUElIszSZpRWY+TxXWVG6uo
         lqqLtVI2lLxq3AnCau9/UhngOyPs92dm82gGSOQyPtmUohEm8W92JJH/wEGLCxC/tt1R
         23JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xIIlIbxNm8YnMEaQ1RWyeJXqyhEpKzPdTOxxiIKLG78=;
        b=IqnIBlFo4ty0iVpMzfmslfs6TCnaOuPeYy9DkaGTpT0ngm6Gd7AjPN2YgIlIToz8rd
         ppY1Ml5xyvL7z/JtlIlbofQcHt7F0EGPTLXv2wZcn1JiLpZT9aCpZ3Apb27LHutUlWoM
         vSzlsH3zwQXxfk7UwCNQZcDmom0PhpN64AlluCsj/RyUVpl4lxmExboGZdggCEvXR0bu
         8nQfDIPdm8eEAISuiToOP1Tz9xD889YpiYhWEyzUMaLuNJ3N8OY5HEYr3fy9UO1wBkLt
         IOGy005EzwAzPGVtQKSB6P9daIJQdo+IzhwHMWXWLOOOA2Lu4zBXtFgo2D9PdeCjKpGf
         6yUA==
X-Gm-Message-State: AGi0PubPFOt4E1HwFal5yKok+61VqPzRgAXtlUspfSTXk29UJAUcT3A2
        D2mNBbQ5+RfM5dypZgHRXXbUutZEOo8/0BOp2SI=
X-Google-Smtp-Source: APiQypJ7Sw715Jhve3XtaR2Olc0bt3u4HGp+siiSsHvLgdKwYSrNzNdqxldyAqeWkwkVy0hcIp3NwGXee27RLfVuRkk=
X-Received: by 2002:ad4:5843:: with SMTP id de3mr12475008qvb.92.1588845602990;
 Thu, 07 May 2020 03:00:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200411211414.GP13306@hungrycats.org> <b3e80e75-5d27-ec58-19af-11ba5a20e08c@gmx.com>
 <20200428045500.GA10769@hungrycats.org> <ea42b9cb-3754-3f47-8d3c-208760e1c2ac@gmx.com>
 <CAK-xaQYvgXuUtX6DKpOZ2NrvkYBfW9qgGOvMUCovAjVBO2Ay7g@mail.gmail.com>
 <a7d16528-b5c2-0dcb-27fa-8eee455fee55@gmx.com> <CAK-xaQajcwVdwBZ6DhZ5EYax2FL28a6_+ZfsPjV7sqXeQ3RVKQ@mail.gmail.com>
 <628479cc-9cc2-ac05-9a0f-20f3987284f3@gmx.com> <CAK-xaQYTNCv8tA=_cR1H4u-ZCy80UFFNjP+CLM1=zuNhoU_x_Q@mail.gmail.com>
In-Reply-To: <CAK-xaQYTNCv8tA=_cR1H4u-ZCy80UFFNjP+CLM1=zuNhoU_x_Q@mail.gmail.com>
From:   Andrea Gelmini <andrea.gelmini@gmail.com>
Date:   Thu, 7 May 2020 11:59:51 +0200
Message-ID: <CAK-xaQYRwuRV3y77Osz65K4icJF76=qG4CPW_7LQdSJPYHFVxg@mail.gmail.com>
Subject: Re: Balance loops: what we know so far
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Linux BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Il giorno mer 6 mag 2020 alle ore 20:24 Andrea Gelmini
<andrea.gelmini@gmail.com> ha scritto:
> I'm uploading it. It takes lot of hours. I tell you know when done.

Here you can find the complete image:
http://mail.gelma.net/btrfs-vm/live.dd.bz2

md5sum:
ea34712f83a5db647298c33b7b274f77  live.dd.bz2

Ciao,
Gelma
