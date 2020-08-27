Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2B5253E1D
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Aug 2020 08:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbgH0Gsd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Aug 2020 02:48:33 -0400
Received: from mail-40132.protonmail.ch ([185.70.40.132]:36701 "EHLO
        mail-40132.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbgH0Gsc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Aug 2020 02:48:32 -0400
Date:   Thu, 27 Aug 2020 06:48:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1598510910;
        bh=ND01zNZi6jOuqfQxbwM1/s8EG457C3cmb9a3JFmfipc=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=aplHtk0huI0F6xtHPVNyrwFcDmyn2rx/gK34BcOteX2jrhUPnvic/xuIJk5VftmmZ
         mCd1OQQCXRWi8ExgoOVYNkpo2fDWmYMVwIPOTdNErxPXWw46VDHYT0LJIxag3mA1ag
         Kq/qxaXW+NzpxeaFEj6+VKPNQ9huV5CFfV2HJAKQ=
To:     Chris Murphy <lists@colorremedies.com>
From:   Andrii Zymohliad <azymohliad@protonmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Andrei Borzenkov <arvidjaar@gmail.com>
Reply-To: Andrii Zymohliad <azymohliad@protonmail.com>
Subject: Re: [Help] Can't login to my systemd-homed user account due to fallocate failure
Message-ID: <KzGwc4OhDq6qR43tQSjynifhYV7E1mfeZeQjBWWRNwithi65kenn7yS22w-bbi_OHYXAkYA6y44iMYCYLAWu2g2V3s47Uor_aYMRk-NgoOU=@protonmail.com>
In-Reply-To: <CAJCQCtStgn4WjisTf6628UEcB8_eP0_9WETDSB6YtGa4VDPgPw@mail.gmail.com>
References: <bdJVxLiFr_PyQSXRUbZJfFW_jAjsGgoMetqPHJMbg-hdy54Xt_ZHhRetmnJ6cJ99eBlcX76wy-AvWwV715c3YndkxneSlod11P1hlaADx0s=@protonmail.com> <VTDsoZlxoD7U7UxD61VnBts_awxM0n5PgKgeH-fCQOy4VeCCCj27DmdMt_oP490t0cKWbsY9qlK1hci8o-1uD7vtBcVQLub1Gl3JjIGU-o0=@protonmail.com> <CAJCQCtT8gLGNU6E+f=eM9SBPa4+tG+K7AbiCd=KjD2o8QrpxpA@mail.gmail.com> <dHPyoaNUuxoqxJjpSUjcxZvk21ew2ObKWFFhX0efJKBqjG8m27px3mPupviQuM3HYQDEcYQGFQ9jOprBuAX4x1Em3oVOyDl6EhKwEJSiuXs=@protonmail.com> <CAJCQCtSVMAEZP5OT77yCEBw9Z3C=oyVKcicWbRV9p_+pKcRwoQ@mail.gmail.com> <gp99KJ83xX5hsbU2_hXblYTSDI6Rmkk2fbRYAcKNoQik1CH8siYdTw11qFuFdAqo-iC48cJcB_vbMJgY8HuSySoWoBW3hcYHewIgB87Kzzw=@protonmail.com> <CAJCQCtQZW2ps1i4b6kGBd_d8icYZWyz5Ha+Ozo0VjsbvVNf03w@mail.gmail.com> <CAJCQCtR4y180_96BGu08ePGLxo8dq7mAV7H248d8X85FcS0MOw@mail.gmail.com> <CAJCQCtStgn4WjisTf6628UEcB8_eP0_9WETDSB6YtGa4VDPgPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> > > OK is the sysfs output from before or after the homectl resize? And i=
t
> > > matches with the second strace fallocate -l 300g ?
> >
> > Figured it out. The sysfs is the first strace before the resize.
>
> Shoot. I confused myself and am not sure, so I need you to tell me
> which strace that sysfs goes with, the 403g or 300g.

Sorry, I haven't put it clear. I've resized it right after I was able to lo=
g in a couple of days ago. So both straces and /sys/fs outputs are after re=
size. And /sys/fs output is after the second strace (-l 300G).
