Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91577407AA7
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 Sep 2021 00:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbhIKWXs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 11 Sep 2021 18:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbhIKWXr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 11 Sep 2021 18:23:47 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9566CC061574
        for <linux-btrfs@vger.kernel.org>; Sat, 11 Sep 2021 15:22:34 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id c8-20020a9d6c88000000b00517cd06302dso7628204otr.13
        for <linux-btrfs@vger.kernel.org>; Sat, 11 Sep 2021 15:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Z3f3ORpCN5dmioEQxJT6DQyP5/xPbWrqoTnhUWvcMwg=;
        b=XZDVR/QlrGALoVgHH/tyrmrRtd3C66d6FzRSsj+r3yR9CeaJTCuF75rLb1Vc1t7bwa
         gJmiVah2TFYnyzim5KTHScPw3/ISna+6NLTI25MtukiQcFRGTbBz0N59MVLCYbJa+d9K
         KnWad5Ua8Jpgy5mOf8YhYSM6HEero+OjAkX/2ZVwWAJYquugDileM7za5yojGRh+XBRn
         qE8R24b1NzYwySVgYDGS6aAKs7ENTXFuBdtHBshra1zRdcHPifggss6Cr1ewuIgH2joq
         c2lmgo0FfAf3QbgqdYyN47ocF28GCaR+V/wcvoHy484HJgHyNjfrKJMnogWmzqc+6Xx1
         8tkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Z3f3ORpCN5dmioEQxJT6DQyP5/xPbWrqoTnhUWvcMwg=;
        b=5mYbzFjGXMcJlh3LYYyrZZ2GrkFHwv/5/VWpeWFfPKlNwY5IFCd5L3HXnWfTWyt1Y/
         8NvUk+609jeg+xF84pfFLkcSMUK/P5qAbdKzJmNhprn08T0eefwlw/LiRpEj+nyyJ99p
         XjGj/hFydLtW89n3ArwmdcnU/GtoYe2f2j0cpJa5B6SSgquovoich7OEu9TXZAlVEgx9
         aWF6/kK5EUbIeiyxztcg3sHeH+vmhY4d/Ej6jloNSZgbKtKjbeIDDxGy5kEdWDVHuol1
         pr3Vo1rl+KmrzTeAJZkTNcrdmblnxgERAsRiBHK8Ry9tYlZnycQze/RfWKP+eo/+o1dI
         P37Q==
X-Gm-Message-State: AOAM533bc2lz96r8lbRhAdjXuWxi6axvjCcZm2gsfeOnQiJkcquKWrE8
        2t83QBP0FHJAkf4HwHe3CD43rPcLJVv1nEACmxkxhL1dGRc=
X-Google-Smtp-Source: ABdhPJwlaimwgvjcVYfKwFseD70RkZ8EraGMT0ecSMduZIAEfLFKBUAzpXkjtLl/U947yWq++Zc+G2pKJssvTyIl+cg=
X-Received: by 2002:a9d:721b:: with SMTP id u27mr3929814otj.214.1631398953947;
 Sat, 11 Sep 2021 15:22:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAGdWbB5i2QumFah3aCxC7Zwg1TPGMS-_7nsPxeuJu+JZ-bGYew@mail.gmail.com>
 <CAGdWbB57aE9fmuS3ZU1oBxK3Gqd+7YMRL2oGYzwhvT3=s=45MQ@mail.gmail.com> <f041b06.ddfa8457.17bd6e185d0@tnonline.net>
In-Reply-To: <f041b06.ddfa8457.17bd6e185d0@tnonline.net>
From:   Dave T <davestechshop@gmail.com>
Date:   Sat, 11 Sep 2021 18:22:22 -0400
Message-ID: <CAGdWbB5-uN57GF90K06yE8bw5O-S4Le+YZ-aNx3-BUSoa6hWbQ@mail.gmail.com>
Subject: Re: seeking advice for a backup server (accepting btrfs receive
 streams via SSH)
To:     Forza <forza@tnonline.net>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Sep 11, 2021 at 6:01 PM Forza <forza@tnonline.net> wrote:
>
>
>
> ---- From: Dave T <davestechshop@gmail.com> -- Sent: 2021-09-11 - 22:41 ----
>
> > Hello. I have a server on a LAN that will act as a backup target for
> > clients that use btrbk to send snapshots via SSH.
> >
> > After my initial attempt, the backup server became extremely slow. I
> > don't know the cause yet, and I'm starting to investigate.
> >
> > The first thing I would like to know from this group is whether there
> > are special considerations for configuring or managing a server that
> > will receive many btrfs snapshots from other devices.
> >
> > For example, do the general rules about limiting the number of
> > snapshots on a volume still apply in this case?
> >
> > Thanks for any input.
>
>
> It's hard to say much without more detailed information about your set up, such as hardware configuration, filesystem setup, etc.

I can offer any additional info needed. Rather than guess at what
anyone wants to see, I will respond with the info upon request.

> What do you consider slow?

The connected clients will freeze for several minutes, up to 15
minutes or more sometimes. It was not just "normal slow" it was
unusable. These periods of extreme slowness did not correspond, as far
as I could tell, to the moments when clients were running any btrbk
operations. It seemed random.

I started over with a "new" (i.e., repurposed) server and so far it
seems OK in testing with just a few clients. But before I go too far
down this path I want to make sure the general idea is workable,
assuming I have adequate hardware.

> Some pointers to look at may be

Thank you for offering these pointers.

> * deleting snapshots can cause increased I/O.

Under what circumstances? Do you mean that when there are a lot of
snapshots, deleting some may cause increased I/O? Deletions are
managed per client by the btrbk config running on that client. btrbk
sends snapshot diffs (incremental backups) to the backup server
according to the schedule on each client, and it removes existing
backups that exceed the allotted qty.

> * atimes can affect snapshots as they mean cow of metadata. Mount as noatime.

I am already doing that.

> * exclude snapshots from mlocate/updatedb and other indexing services. I forgot once and ended up with several gb database... :D

I am not aware of these services (mlocate/updatedb and other indexing
services). Do you have tips for finding any such running services or
what some of the others might be?

# which mlocate
which: no mlocate in
(/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl)
# man mlocate
No manual entry for mlocate

The mlocate package is not installed by my package manager.

I got similar results for updatedb.

> * space_cache=v2 can be helpful, but it increases metadata usage a little.

I am using space_cache=v2 on the main volumes, which includes where
these "backups" are saved. The root (os) volume itself hasn't been
converted from space_cache v1 yet (b/c I haven't had time to read up
on that).

> * monitor disk usage allocation with 'btrfs filesystem usage /mnt'

That's a very vague recommendation. I'm already doing regular balance,
scrub and making sure the disks are not out of space.
>
> Good luck.
>
Thank you for replying. Can I assume that it is generally OK to use a
backup server in this way where it will receive (over time) hundreds
or thousands of backups (incremental usually) via btrbk running on
different clients?
