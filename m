Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55585408C2C
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Sep 2021 15:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240047AbhIMNOO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Sep 2021 09:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236675AbhIMNNz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Sep 2021 09:13:55 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44573C061760
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Sep 2021 06:12:39 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id p2so13981429oif.1
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Sep 2021 06:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=k6cSVKU1e44RP91DAh5s7in03pflQmRKbBJalfQ3J+M=;
        b=mocmSBYvRffa+b3CYDb+oYRgOIfTOlgPfilIDcc34A+JQ/wSVEtUf9jOML6vyylXwL
         szGDEoM7pwTKQJrzYye5QwkGyUzomPMrbOqbfZnTFJAv1eYYRPLWke3AsNYJdX0B6YnN
         cyGhzKDjn7cUAR7tK0ngQ90ClemhXUC/PU5dOxB1YKpNjSbpSXNpK3yEeWtr7mYFiBfc
         Khz5Fe85RUDYZba/ml+eDs4+B6l2SAgXdXzx+6Qu7KOpQ1lHUW3Ht08fT1TS8t6L92+F
         +9VdnrjDpPx2e1bwmAqQ4SFWjRTkPSuKbxgP6aopryb3Hr3gI1+MVNLI1RHzwC8Qw1+I
         B9og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=k6cSVKU1e44RP91DAh5s7in03pflQmRKbBJalfQ3J+M=;
        b=oU4Chj+1u73L1Rte7UI9MYa40scDFvjAqJeZwLrAdPZCgToLPXf2CoGvo6yAxSZzrh
         fHuQAE1LSTKt+ZwPXk5igtpbKSvvNR8g8RlEWq6zjxYiRJBPxouVePxGt/JvF+l9keKG
         zsk7NBVh42NmvL4NwHCKzevd8iQyyIGeH/RPP9Tqhhk5WbOy0R7xYGzImCmx9H19ZLYd
         K34nLtGQXeBzci+pg1wqiJq7d0JGbURXzpEPDA0V6EdmyItcquWdjrjwBmHgqa+r92df
         Mn6Y7F2IiRgBhgbhw3uBS2LTwdxvMxa4O9oEON3BzOlD1qC82ISTCQ+zEwZ9H05mQ4Ga
         ZxSw==
X-Gm-Message-State: AOAM530FZkuWo1L8WIsvq8zbDKn7FyVIauSYRQGrUbRzoX5DA2uRP9f1
        6JkO3d9rOk3E4AaGUKcsO6T97H15A2mehm880kCpUqm2YH0=
X-Google-Smtp-Source: ABdhPJy+oOgrJa0V1E2PUYf61uzLcgVFMpz2kLpKZ0DkUALTq2+Xh7tiORC2yfGBnYWLZnDZyplOMuiCIeezHJ+Jscg=
X-Received: by 2002:a05:6808:3099:: with SMTP id bl25mr4436171oib.44.1631538758595;
 Mon, 13 Sep 2021 06:12:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAGdWbB5i2QumFah3aCxC7Zwg1TPGMS-_7nsPxeuJu+JZ-bGYew@mail.gmail.com>
 <CAGdWbB57aE9fmuS3ZU1oBxK3Gqd+7YMRL2oGYzwhvT3=s=45MQ@mail.gmail.com>
 <f041b06.ddfa8457.17bd6e185d0@tnonline.net> <CAGdWbB5-uN57GF90K06yE8bw5O-S4Le+YZ-aNx3-BUSoa6hWbQ@mail.gmail.com>
 <68ab63fd-5981-5b8c-cad1-f11b22a33169@tnonline.net>
In-Reply-To: <68ab63fd-5981-5b8c-cad1-f11b22a33169@tnonline.net>
From:   Dave T <davestechshop@gmail.com>
Date:   Mon, 13 Sep 2021 09:12:27 -0400
Message-ID: <CAGdWbB5xH=AfZVyJ+Biy5go5Aqm0JXfw=SU0gxh5OSrkXgr-aw@mail.gmail.com>
Subject: Re: seeking advice for a backup server (accepting btrfs receive
 streams via SSH)
To:     Forza <forza@tnonline.net>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> >> * deleting snapshots can cause increased I/O.
> >
> > Under what circumstances? Do you mean that when there are a lot of
> > snapshots, deleting some may cause increased I/O? Deletions are
> > managed per client by the btrbk config running on that client. btrbk
> > sends snapshot diffs (incremental backups) to the backup server
> > according to the schedule on each client, and it removes existing
> > backups that exceed the allotted qty.
>
> It would be some time after someone (btrbk) issue a "btrfs subvolume
> delete".
>
> An alternative can be to to "rm -rf", which itself is slower, but can
> have less of an overall impact.

That's interesting. I would have guessed that using "rm -rf" to remove
subvolumes that are part of a chain of incremental backups would lead
to problems such as the backups not being complete or future
incremental backups failing.

> > The connected clients will freeze for several minutes, up to 15
> > minutes or more sometimes. It was not just "normal slow" it was
> > unusable. These periods of extreme slowness did not correspond, as far
> > as I could tell, to the moments when clients were running any btrbk
> > operations. It seemed random.
> >
> > I started over with a "new" (i.e., repurposed) server and so far it
> > seems OK in testing with just a few clients. But before I go too far
> > down this path I want to make sure the general idea is workable,
> > assuming I have adequate hardware.
>
> This sounds like it is connected to snapshot deletions. They can cause
> long stalls while btrfs is in transaction. I am using btrfs myself like
> this for backups and I have not noticed it myself, however I have heard
> from users in the IRC forum #btrfs (https://web.libera.chat/#btrfs) that
> it can happen. Mostly, I think, those systems are heavily loaded.
>

OK, I think you may be right that it is related to snapshot deletions.
This gives me some ideas to pursue.

> >>
> > Thank you for replying. Can I assume that it is generally OK to use a
> > backup server in this way where it will receive (over time) hundreds
> > or thousands of backups (incremental usually) via btrbk running on
> > different clients?
> >
>
> I would say it is generally OK!

Thanks again. This is enough to encourage me to persist with this plan.

> What I mean here is to avoid running close to full as that is not good for a COW filesystem.

I never let btrfs storage devices get more than about 75 or 80% full
according to btrfs fi usage cmd, and most are at 50% or less. Sending
cmd output wouldn't help now because I recently deleted everything
from the backup target drive to start over. The drive is nearly empty,
atm.

In terms of hardware, it hasn't changed recently. I've been doing
hourly btrfs snapshots and daily send | receive backups for years on
generally the same hardware and there were no performance issues. The
problems started recently when I did 2 things:

1. switched to btrbk
2. started sending the daily send | receive backups to a server on the
LAN instead of to local USB attached storage.

The SMR backup disk in the server is currently a HGST HUH721212ALE600
10.9T, which is definitely a better disk than what is inside the
low-end WD Passport USB HDDs I was using.

The client devices (hosts) are generally running Samsung SSD's like:

Samsung SSD 970 EVO Plus
Samsung SSD 980 PRO

Since the recent performance problems don't coincide with any hardware
changes, and I am not seeing any hardware-related errors, I will focus
my troubleshooting on my btrbk configuration.
