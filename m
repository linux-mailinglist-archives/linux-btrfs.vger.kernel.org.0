Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F056C4965CB
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jan 2022 20:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiAUTjl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Jan 2022 14:39:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiAUTjk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Jan 2022 14:39:40 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE6EC06173B
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Jan 2022 11:39:40 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 133so8998374pgb.0
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Jan 2022 11:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/bu/3iyNydp+mveaftk6LGCY1tRUzSNVH6ZCi92XjbY=;
        b=mjl2/nihZmXQ83VuPvH6p2tG1v1YTgLavE/NHWmVevP2y2tPQpakn5aCDNDC2TYCVk
         RIgUcs6jsyccBDtdbEByS/VuiYGo0fVY8BLccL91WL411y42/trsG1cySK/FbwIKr4jH
         GHkqkH5lN0K8KruRqY/Yb3sD4LDz9vPNXctaaVI/B1zDLLyoal+3Dwiz1/2pKiprmxYJ
         iUx7BjCKFT108Kw0WnAzPU+LtX34wbai0ErKZayBhG6Hv47RE4OLWlaSY+iwSjp60rhA
         Q/N7xPMAKH4LU3biTBaJshQJoKS9oNf+35Jb9PpCZmIR4Yj5EeVUath7Rwtd9SSNLtD7
         aKRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/bu/3iyNydp+mveaftk6LGCY1tRUzSNVH6ZCi92XjbY=;
        b=F1BNjhsHdNUN/5OwzVu3efzI6F1Zt+mF3rANt124deRoD6W2BCVFEDSw64nqEl5Wcg
         ia6kphQn/20SLvc6zcNIqre6KhuLutu6DTjx3rO0E97JwojFosn0+RwZDjoCAwPi93fq
         0dYm3yndT6AnF8lCXALQyI5+Qla1Q9Cz/1Mf19GtEuLmAWJpnIYckIlPh/IR69YsM4sa
         UIPlM/NhYwhdNZxnDc6Py17R7mxqJlmC6FQomVTjbKn8NSHVRxO4xg3aDhCNQXiVsmER
         SsIXAflNuKZ9JHpXJI3KPUzgjftG1ZzFUZ+nZsYiYSPEh1xz+QvRtYAYIj42nZ/0D3Cr
         sU9w==
X-Gm-Message-State: AOAM533vQOYB5Gofs4iBOd9Rzw7LMYO5GYd0ymbajt71qFzFxKOEbt0+
        9z5raN8NhFL7hKPMvg0iRzP66/elXJMoTZz7L//P9Lm6y7A=
X-Google-Smtp-Source: ABdhPJwrRW+/W/LUd1+IKaUG8uiRt+Ki2aUpvy2se+QEp57xaMsvIGOFLo421sUNKoJWfnTMXuwMlo++t44TFK1sEmw=
X-Received: by 2002:a63:9712:: with SMTP id n18mr3966538pge.594.1642793979853;
 Fri, 21 Jan 2022 11:39:39 -0800 (PST)
MIME-Version: 1.0
References: <CAEwRaO4y3PPPUdwYjNDoB9m9CLzfd3DFFk2iK1X6OyyEWG5-mg@mail.gmail.com>
 <YeVawBBE3r6hVhgs@debian9.Home> <YeWgdQ2ZvceLTIej@debian9.Home>
 <CAEwRaO5JcuHkuKs_hx9SJQ6jDr79TSorEPVEkt7BPRLfK2Rp-g@mail.gmail.com>
 <CAEwRaO7LpG+KBYRgB4MGx9td5PO6JvFWpKbyKsHDB=7LKMmAJg@mail.gmail.com>
 <CAL3q7H7UvBzw998MW1wxxBo+EPCePVikNdG-rT1Zs0Guo71beQ@mail.gmail.com>
 <CAEwRaO4PVvGOi86jvY7aBXMMgwMfP0tD3u8-8fxkgRD0wBjVQg@mail.gmail.com>
 <CAL3q7H5SGAYSFU43ceUAAowuR8RxQ6ZN_3ZyL+R-Gn07xs7w_Q@mail.gmail.com>
 <CAEwRaO6CAjfH-qtt9D9NiH2hh4KFTSL-xCvdVZr+UXKe6k=jOA@mail.gmail.com>
 <CAL3q7H7xfcUk_DXEfdsnGX8dWLDsSAPeAugoeSw3tah476xCBQ@mail.gmail.com>
 <CAEwRaO4Doi4Vk4+SU2GxE7JVV5YuqXXU_cw7DY9wQrMnr9umdA@mail.gmail.com> <CAL3q7H4ji1B7zn4=mP4=891XfokkVyOaaqW3dCmUH6uVGjgkjg@mail.gmail.com>
In-Reply-To: <CAL3q7H4ji1B7zn4=mP4=891XfokkVyOaaqW3dCmUH6uVGjgkjg@mail.gmail.com>
From:   =?UTF-8?Q?Fran=C3=A7ois=2DXavier_Thomas?= <fx.thomas@gmail.com>
Date:   Fri, 21 Jan 2022 20:39:27 +0100
Message-ID: <CAEwRaO7cA3bbYMSCoYQ2gqaeJBSes5EBok5Oon-YOm7EQ8JOhw@mail.gmail.com>
Subject: Re: Massive I/O usage from btrfs-cleaner after upgrading to 5.16
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, Qu Wenruo <wqu@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Thanks, will add that to the list and test. FYI the 6 patches didn't
seem to have much additional effect today compared to my previous
stack of 4.

On Fri, Jan 21, 2022 at 11:49 AM Filipe Manana <fdmanana@kernel.org> wrote:
>
> On Thu, Jan 20, 2022 at 6:21 PM Fran=C3=A7ois-Xavier Thomas
> <fx.thomas@gmail.com> wrote:
> >
> > > Ok, so new patches to try
> >
> > Nice, thanks, I'll let you know how that goes tomorrow!
>
> You can also get more one on top of those 6:
>
> https://pastebin.com/raw/p87HX6AF
>
> Thanks.
