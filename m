Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 312402CBB35
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Dec 2020 12:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgLBLFb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 06:05:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbgLBLFb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Dec 2020 06:05:31 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8AF6C0613D4
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Dec 2020 03:04:50 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id y18so739357qki.11
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Dec 2020 03:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=LpHXyIi01Re6mnEEzAmGB+lBIhJtOu27UUAc4sAde1g=;
        b=Qw/Y8XjyTCDLBQP4mdxMuSc2G6uNt3cASyvvqKt0Z+tYr6bIrU64IFfFWCZ0tTFnbB
         k5M0lrsFXl2bUuWZHAwjzo9mLHV85f3sDICdHryVo3mwhhIgkzLtP9yLQfrwnCrdq1Xx
         5KYRhqqBLC//XU+Qnh4kCvbZJ3N99zez8G/eFbJeqfhcOKQmRa4FD045IZaWSpxGsrNC
         z/vZj6bncqzO0HNhCP+PQ+yUxtV6+UtNQKXSTJZSht1Pdt5iNyKeOMG2w0s/wUHOmplU
         1UxeNzlJp9+5clkqVbeEDs/sXnUcUmKv9c2okQ1C6uJnvxMchE3ZOT845cLtChvsvns9
         zlKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=LpHXyIi01Re6mnEEzAmGB+lBIhJtOu27UUAc4sAde1g=;
        b=i/2j3Wzvv+KJIAEa0EgNIoZ+DXu8cObkFkVqoFJzbQhVLuBF7N1ozaeHYRwqW5HRTd
         Iteub1YnUIfyd6q601kuJUzIxORixUJi5gj+hy3ys0YfkIeYVcf1sn0ifQKZSSa7r6Em
         4EvOEKXTJXRyE33xJvQwu4O/B6/wjQfQhjEZFptXMeiHWa0HJ+kYE7P9xVvITgC9QPE4
         6kp/xSJFA0/wyHr+BtJRNh0vRIFKIUXSpFTbP4JDIaB77RqcwPyHnFYPO6h3xb9/IHuk
         Wnmq1n9F6ueixIk1R6yVOrsxXe3KLhIFaSSz2aqsA4c4VdBqnAsoMUnqgB37f1Mgn6Vd
         pq/g==
X-Gm-Message-State: AOAM530efm7E7V9rcwECrsvT9PhceEyCExswLFea8PVdQmYhLie2JL7x
        m5TeWbeiYLw20JD9fsw1DLqwvvOtpOVdYwqn0hEUWNdL8as=
X-Google-Smtp-Source: ABdhPJwA22OEny/1jcnhDxji+CQcbY2QRIBnEep49HGr13GtNnZH66MicjAdmu+Zz55SVsv0eO4diqXbCijdlSdev1E=
X-Received: by 2002:a05:620a:1387:: with SMTP id k7mr1828192qki.338.1606907089967;
 Wed, 02 Dec 2020 03:04:49 -0800 (PST)
MIME-Version: 1.0
References: <6ae34776e85912960a253a8327068a892998e685.camel@gmx.net>
In-Reply-To: <6ae34776e85912960a253a8327068a892998e685.camel@gmx.net>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 2 Dec 2020 11:04:39 +0000
Message-ID: <CAL3q7H72N5q6ROhfvuaNNfUvQTe-mtHJVvZaS25oTycJ=3Um3w@mail.gmail.com>
Subject: Re: btrfs send -p failing: chown o257-1571-0 failed: No such file or directory
To:     "Massimo B." <massimo.b@gmx.net>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 2, 2020 at 10:22 AM Massimo B. <massimo.b@gmx.net> wrote:
>
> Hello everybody,
>
> trying to use btrbk archive, it's failing with
> chown o257-1571-0 failed: No such file or directory.
>
> It is doing a btrbk send -p... | btrbk receive ...:
>
> The command is:
> btrfs send -p /mnt/usb/mobiledata/snapshots/mobalindesk/root/root.2020080=
3T060030+0200 /mnt/usb/mobiledata/snapshots/mobalindesk/root/root.20180114T=
131123+0100 | mbuffer -v 1 -q -m 2% | btrfs receive /mnt/local/data/snapsho=
ts/root/
>
> So it takes some newer snapshot as parent to send the older snapshot miss=
ing on the target.
> Maybe btrbk just selected the wrong parent?
> Doing the same without -p is working. What's failing here with the parent=
?
> I tried sending other snapshots with the same parent, but also failing.
> We had several discussions about that in the btrbk tickets with the resul=
t, it's
> a btrfs issue.

Yes, it's a btrfs issue.
Pretty much there were always bugs where an incremental send generates
wrong path names depending on how things changed between snapshots,
causing the receiving end to fail.
I have fixed several over the years.

>
> I have 3 btrfs. One is my working one, then I have a local backup and a r=
emote
> backup. Local backup has less snapshots than the remote backup, so I like=
 to
> send some of the remote snapshots back to the local.
>
> Kernel: 5.8.15-gentoo

There were two such bug fixes in 5.9 that are not included in a
vanilla 5.8.15 (dunno if gentoo picked them into their 5.8.15 kernel):

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D98272bb77bf4cc20ed1ffca89832d713e70ebf09
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D9c2b4e0347067396ceb3ae929d6888c81d610259

Might be worth trying them, however I think it's probably a different bug.

> Could bees have corrupted something? I'm running it on all 3 btrfs.

Very unlikely, user applications shouldn't be able to do anything that
corrupts a filesystem.

If those don't solve your problem. then the output of 'btrfs receive
-vvv ...' could be used to help debug the issue.

Thanks.

>
> Best regards,
> Massimo
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
