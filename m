Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A141131C3CB
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Feb 2021 22:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbhBOVve (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Feb 2021 16:51:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhBOVvd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Feb 2021 16:51:33 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1D8C061756
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Feb 2021 13:50:53 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id c17so8576827ljn.0
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Feb 2021 13:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vlad.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=N556KfB4Z1Hu9LqtJGqeZgOWWsxOerYL8+sWhfP0EYk=;
        b=F/Izbkl+B7Sgw3exgZRCQnCTtWGbu9ppql7aiAY3Moee2pb2ntL+Dtl7Qh/cBwvaIG
         8uJidyd2KIctHKRIJSTvNjOAPb8ipP6xjBemy2CjZTSOtOjSoJIxkLKgEIQpWDrL+/2G
         zdL/swpSa6Lunu2awb/7MCizAzsATPpDvBj/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=N556KfB4Z1Hu9LqtJGqeZgOWWsxOerYL8+sWhfP0EYk=;
        b=jme00btfSxhv8z03IrDNGBd2+kbAlutk2+cWHVQx6AJRGIU2eyd4uVOv5yXWDYuTGh
         5WJ0vra5oHhdvQ7OFGMPJ7GD5CZBkF6DgEoltfZr8lqvGGOXKGvMDCHwQH5czq3tAKEg
         mXv7GaD4iXdrkckGsGIJoArKuy/jTzKIeXiZl0E7aJGdj+XWsU9TBWGH/JMQYrmCIQX9
         Y8DdKvvBqFTqFjl1Tq4d8Czx10CBNHNOmFyKbfBY5RdyaryxgmNOd9dc9MjdX6eAYrQP
         sKNvAAa0CqKrA81UrpPsZjT0eySnkCs3DZVpH/JRmztF3MWjm9tw92cKcHBEAN6coH7s
         34Vg==
X-Gm-Message-State: AOAM530WAZ770DtR6tUw4anabNNt0Lnw7YPYGCWLLZKKq99cRcwP1Vbs
        qwZUrhDuJDMbhVP0SrWUkTyC8NFRoEreW4ciALtVVOLLOl8xF+LSQUE=
X-Google-Smtp-Source: ABdhPJwZSlV8y2lzVFG3/s3+MV9mpOQ/F95ZMYKzEWK7Cdhrx5d2XI93iiFy18eCXZl+4sZSNUAAspwRa3X13xhLjOI=
X-Received: by 2002:a05:651c:399:: with SMTP id e25mr2291675ljp.87.1613425851243;
 Mon, 15 Feb 2021 13:50:51 -0800 (PST)
MIME-Version: 1.0
References: <CAFTxqD_-OiGjA3EEycKwKGteYPmA6OjPhMxce8f1w8Ly=wd2pg@mail.gmail.com>
 <CAFTxqD8fGcL1j904b=yFPUwYjJi_bz5iVcxkNC5BoLZ8Wm12ZA@mail.gmail.com> <B7BDEFC2-2444-4926-8FFC-D78B6CE5CB4E@vlad.hu>
In-Reply-To: <B7BDEFC2-2444-4926-8FFC-D78B6CE5CB4E@vlad.hu>
From:   "Pal, Laszlo" <vlad@vlad.hu>
Date:   Mon, 15 Feb 2021 22:50:15 +0100
Message-ID: <CAFTxqD8OtnY3AGV6YCyU_GypTdHjSVmuzLsRi5E_ojs=p+GsFA@mail.gmail.com>
Subject: Re: performance recommendations
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

So,

After booting on rescuecd and adding the mount options below the
system can be booted, but it still performing terribly=E2=80=A6 the main
observation is this

# time rm -f qradar-leef-17.log
real        0m13.648s
user       0m0.000s
sys          0m0.105s

This is a 2Mbyte file and it takes 13 secs to rm=E2=80=A6. what can be the
reason behind it and how to fix such weird behavior? Is this a file
system corruption? Some misconfiguration? Or should I start planning
to use some more traditional filesystem for this use-case?


Thank you for your help

P=C3=A1l, L=C3=A1szl=C3=B3
vlad@vlad.hu

>
> On 2021. Feb 15., at 20:30, Pal, Laszlo <vlad@vlad.hu> wrote:
>
> So,
>
> I'm trying to recover this stuff... this is a CentOS7 based system
> running for almost two years. It was never too fast, but did what I
> intended to do, but today I've observed very very bad performance on
> ls, rm and other complicated commands. Like rm <any single file> takes
> forever and in iotop I can see this command is using 50% of i/o
> together with btrfs-transacti, so something definitely wrong
>
> I've added ram and cpu to the VM, but it does not help. Now, I'm also
> trying to modify fstab to add noatime, autodefrag
>
> In the journal I can see some "free cache file invalid, skip" warnings
>
> Can anyone offer me some help, so at least I can boot the machine
> (right now the boot times out on mount task, so I can have either
> emergency mode or rescuecd)
>
> Thank you
> Laszlo
>
> On Mon, Feb 15, 2021 at 3:53 PM Pal, Laszlo <vlad@vlad.hu> wrote:
>
>
> Hi,
>
> I'm not sure this is the right place to ask, but let me try :) I have
> a server where I mainly using btrfs because of the builtin compress
> feature. This is a central log server, storing logs from tens of
> thousands devices, using a text files in thousands of directories in
> millions of files.
>
> I've started to think it was not the best idea to choose btrfs for this :=
)
>
> The performance of this server was always worst than others where I
> don't use btrfs, but I thought this is just because the i/o overhead
> of compression and the not-so-good esx host providing the disk to this
> machine. But now, even rm a single file takes ages, so there is
> something definitely wrong. So, I'm looking for some recommendations
> for such an environment where the data-security functions of btrfs is
> not as important than the performance.
>
> I was searching the net for some comprehensive performance documents
> for months, but I cannot find it so far.
>
> Thank you in advance
> Laszlo
>
>
