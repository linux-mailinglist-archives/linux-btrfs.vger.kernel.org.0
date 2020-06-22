Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC06E202E02
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jun 2020 02:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731016AbgFVA5s (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 21 Jun 2020 20:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbgFVA5s (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 21 Jun 2020 20:57:48 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1864AC061794
        for <linux-btrfs@vger.kernel.org>; Sun, 21 Jun 2020 17:57:48 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id g18so5869544wrm.2
        for <linux-btrfs@vger.kernel.org>; Sun, 21 Jun 2020 17:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=krE3T8vfeRK+7o00GHjqmm1ItHD7ogQv1ThUgveUgHI=;
        b=kLSVswn+BHlJuw8vCVyez0qN653rdhtocLeN7JmVWBlrSfLPIYypv2AQAPmg75NHHW
         AjkdWbHU7/ohxPF2inNrHZjOwO33W8f8PzumL2FL0S835ki3sZwsJmFShtwGdu0cFj3I
         uyy8BlNpmWokM0nCEjaTn0X5ksaCxUJiXZxmXI0/UwQL/fzHYXZlS8+tPo79NW8khiTK
         u7JJcvllg0Lug3kU1LI5q75zOaRsmNyBD6mN4YfmHoal4GHBaLq85qdRuynx+GjSgkcS
         QwaeZbCSSQJIkJpunUqMmeVpS+7jRE4EQJB20y1qJGG2myiP9ORzj6CpVIc5griD+EPl
         aHMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=krE3T8vfeRK+7o00GHjqmm1ItHD7ogQv1ThUgveUgHI=;
        b=UveYh+yDM0RKv4mkgymTqbDNC94WqZFgSE50rdTZe7paT+key4rJGj1IJSijpUpqTz
         zl1Wtj/iGAak+M0FtqqBMrAPFd0heIyki19kq3SkkrV6XMmKvIrdLL3IekeHFxUZIMMt
         A3a7ASdDrSZbO3Ys3Sbb4YjkXnHhI3LAr/6kRcwXsDyHjdLqymWa1CyMs3g7TscJLsMk
         rchUGi/pCFMghpRJDcen3Vxf5oP3EXG69F7VIIxWxftk970gKIyKc8aH03RSV1JH7AHV
         RTF297nFX4Ktuapk3CEl8Z13Nr47dLCGT5U6zA0Cq7DPvNSmQ0h3FGeE3ymUAwWbofzj
         rNsA==
X-Gm-Message-State: AOAM530DjpvOSIgEL77UJu/LvUGnI0PJP9xB7a4h9PnetFzQgHHymIBV
        yYbQDcj0nJMVaaIz3bp4svP6kY7di7vnQPFw0bFlfM6qYdY=
X-Google-Smtp-Source: ABdhPJxEwgNm4SmM3qz0ZUtvbtLc5DUhEi1uIvchI3aV1O7EQ8Ksg3xxrBHfGqTiPCpXXrfHAwOqMuM5lBt+5xMsNBU=
X-Received: by 2002:a5d:5092:: with SMTP id a18mr16016067wrt.42.1592787466689;
 Sun, 21 Jun 2020 17:57:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200621054240.GA25387@tik.uni-stuttgart.de> <CAJCQCtSbCid6OzvjK9fxXZosS_PAk2Lr7=VTpNijuuZXmRVVEg@mail.gmail.com>
 <20200621235202.GA16871@tik.uni-stuttgart.de> <CAJCQCtQmrc5m=H6d6xZiGvuzRrxBhf=wgf8bAMXZ_4p8F3AJFw@mail.gmail.com>
 <20200622000611.GB16871@tik.uni-stuttgart.de>
In-Reply-To: <20200622000611.GB16871@tik.uni-stuttgart.de>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 21 Jun 2020 18:57:30 -0600
Message-ID: <CAJCQCtQ8GFAdg2HJY_HqDgW8WAp5L1GoLbKqUN2mZ7s_kS-8XA@mail.gmail.com>
Subject: Re: weekly fstrim (still) necessary?
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jun 21, 2020 at 6:06 PM Ulli Horlacher
<framstag@rus.uni-stuttgart.de> wrote:
>
> On Sun 2020-06-21 (17:57), Chris Murphy wrote:
>
> > > > util-linux provides fstrim.service and fstrim.timer for a while now.
> > > > fstrim.timer runs on Monday at 00:00 local time. The upstream default
> > > > is disabled, some distributions enable it by default.
> > >
> > > On Ubuntu 18.04 and RHEL 7.8 "systemctl is-enabled fstrim" returns
> > > "static"
> >
> > You need to check fstrim.timer, which in turn triggers fstrim.service.
>
> root@fex:~# cat /lib/systemd/system/fstrim.timer
> [Unit]
> Description=Discard unused blocks once a week
> Documentation=man:fstrim
> ConditionVirtualization=!container
>
> [Timer]
> OnCalendar=weekly
> AccuracySec=1h
> Persistent=true
>
> [Install]
> WantedBy=timers.target
>
>
> root@fex:~# cat /lib/systemd/system/fstrim.service
> [Unit]
> Description=Discard unused blocks
> ConditionVirtualization=!container
>
> [Service]
> Type=oneshot
> ExecStart=/sbin/fstrim -av
>

I'm familiar with the contents of the files. Do you have a question?


-- 
Chris Murphy
