Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15E632F0073
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Jan 2021 15:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbhAIOOR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 9 Jan 2021 09:14:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbhAIOOR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 9 Jan 2021 09:14:17 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19670C061786
        for <linux-btrfs@vger.kernel.org>; Sat,  9 Jan 2021 06:13:37 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id t8so12838844iov.8
        for <linux-btrfs@vger.kernel.org>; Sat, 09 Jan 2021 06:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ceremcem-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HauJ+Zr8V0QdZ7MLgF8LBDZcNv8m5GubtSjlVb0v0PE=;
        b=Xi/3FMWHdB0yys7VESXun2Cokxxl4qMQpLO2solrbvRqiFA7H/mY9Kiyb13wUm6l7y
         GUuY3jsQJRdz4zDqsKySL5BOeyXG7/c8zOJ4Zgwhm1BzpqcW2we6UJ8/Db1YDR8kXNB6
         2E+h5HaWp6o0IdwqSptqOXDjHJ+Ibvu5X+W90SmCDhDo5HZQ3oe4KgLj0iyxY9EWAvLm
         0I7+H9RMAWhZhd20oTBV+rBFLI2zO/1D1d14ycBi7hgVQBq9xnTYF943oHMyX1dW8+NI
         5EBk/h6gxrr+FWWaOcL4Fopcx3PW5QonOALmqZrwepNTZu6VKzRJcS7wpShOZr7S8Dzk
         cCjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HauJ+Zr8V0QdZ7MLgF8LBDZcNv8m5GubtSjlVb0v0PE=;
        b=AeWx4X6lvv3qADfM26Q1JQ9oYQPgAKxbCBN3CsX1Er5keUe+H3fCs9ES8y9PJjm5s8
         2rnfpB2JJjWzBKgjogQlMQEI+q6pZifnRdPvwBaZRdWuKQ1o6olWHz1jcFTAVw4vfnQf
         mZhuJFCSMlfkSEqq0h4FCY/uYsyl5jdeqhHuTEJqBiYTh0tpNAP4ysjJ+Pa4fsp8zGy8
         HTlSXICghFndpcpIenti0uE1eG/rPG2FVRP/jAWcj3z/xc++1RihDhHxG43xL/z8K+P2
         EuBAHF+ujYYVCfkhjsM/SgdMAspcMKAckaMr59MIvfI75SzLRo9S6VrxDQcifROio8Pj
         ihLA==
X-Gm-Message-State: AOAM531PZjJWEzaPixwiG04FE7vVIRBhAc7Hflh8d0AcOfQlzuCOjVUw
        jJ0lGd2tudxvzIYBES72RW5Ukwa48ID9qrE5tY9CsueXtOxjzlsC
X-Google-Smtp-Source: ABdhPJyfhHNdpuChMKj7Eb1uycxWC06/qEixcOY6ydz0ondcgPXj+wq2l3/VSxAx91DZOB1D+UBABkmLH0ZeA+kzP8s=
X-Received: by 2002:a6b:dc0f:: with SMTP id s15mr9197590ioc.180.1610201616291;
 Sat, 09 Jan 2021 06:13:36 -0800 (PST)
MIME-Version: 1.0
References: <CAN4oSBehVoPJxcdwD6wiohR9pSfAdSvzXabz6ohyFQibQ_VrxQ@mail.gmail.com>
 <CAJCQCtRx1kRDdDF7vK=9Y8vLS1azX5-Bh+_OosyqU=GuHhEv1w@mail.gmail.com>
In-Reply-To: <CAJCQCtRx1kRDdDF7vK=9Y8vLS1azX5-Bh+_OosyqU=GuHhEv1w@mail.gmail.com>
From:   Cerem Cem ASLAN <ceremcem@ceremcem.net>
Date:   Sat, 9 Jan 2021 17:13:25 +0300
Message-ID: <CAN4oSBcQsdKFVAn1yrpC+rzeOjmnWc5BWXVR_FWu5-yxqfTWng@mail.gmail.com>
Subject: Re: btrfs receive eats CoW attributes
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I agree that the "--exclude" filter is the most necessary feature for
'btrfs send' but I guess there must be some kind of technical issues
which forced the author use "exclude by subvolume" approach.

I guess any explicit settings should be transferred by default or
there would be no default behavior and user should be required for an
action explicitly.

There isn't a workaround till that day, is there?

Chris Murphy <lists@colorremedies.com>, 5 Oca 2021 Sal, 06:00
tarihinde =C5=9Funu yazd=C4=B1:
>
> On Mon, Jan 4, 2021 at 7:42 PM Cerem Cem ASLAN <ceremcem@ceremcem.net> wr=
ote:
> >
> > I need my backups exactly same data, including the file attributes.
> > Apparently "btrfs receive" ignores the CoW attribute. Here is the
> > reproduction:
> >
> > btrfs sub create ./a
> > mkdir a/b
> > chattr +C a/b
> > echo "hello" > a/b/file
> > btrfs sub snap -r ./a ./a.ro
> > mkdir x
> > btrfs send a.ro | btrfs receive x
> > lsattr a.ro
> > lsattr x/a.ro
> >
> > Result is:
> >
> > # lsattr a.ro
> > ---------------C--- a.ro/b
> > # lsattr x/a.ro
> > ------------------- x/a.ro/b
> >
> > Expected: x/a.ro/b folder should have CoW disabled (same as a.ro/b fold=
er)
> >
> > How can I workaround this issue in order to have correct attributes in
> > my backups?
>
> It's the exact opposite issue with chattr +c (or btrfs property set
> compression), you can't shake it off :)
>
> I think we might need 'btrfs receive' to gain a new flag that filters
> some or all of these? And the filter would be something like
> --exclude=3D$1,$2,$3 and --exclude=3Dall
>
> I have no strong opinion on what should be the default. But I think
> probably the default should be "do not preserve any" because these
> features aren't mkfs or mount time defaults, so I'd make preservation
> explicitly opt in like they were on the original file system.
>
>
> --
> Chris Murphy
