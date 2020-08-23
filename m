Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3DFB24EED9
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Aug 2020 18:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbgHWQzm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 23 Aug 2020 12:55:42 -0400
Received: from mail-40130.protonmail.ch ([185.70.40.130]:63496 "EHLO
        mail-40130.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbgHWQzk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 23 Aug 2020 12:55:40 -0400
Date:   Sun, 23 Aug 2020 16:55:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1598201738;
        bh=kc1T9CYpxuZK2yzUPUpwq0qSEu6tKtR3HoDymGhGGQ4=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=UkLGrYiAvZrrkH2Peuzbk/XtI2TGDSAJMYbIwUkCQ43KY2oQ0D7uFhQtojOykJlOc
         0XW18PRcrkqlpiV4yVUUqsPHqWnNhALlpKywyUjp90Ai4z44s0Taw6IfqKoV7D6IlB
         FHMFwRucmyhjwjwHRxMe0+d1da5AlBhfKwz7VIXs=
To:     Andrei Borzenkov <arvidjaar@gmail.com>,
        Hugo Mills <hugo@carfax.org.uk>
From:   Andrii Zymohliad <azymohliad@protonmail.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Reply-To: Andrii Zymohliad <azymohliad@protonmail.com>
Subject: Re: [Help] Can't login to my systemd-homed user account due to fallocate failure
Message-ID: <uE-fvxC5rW1snQPXRetWASSP8a8cJVSTiDa1WNLmtVANT-M_cd6NUZxUlUtLBID2-EBEEJjP0yK7-Knt9-vjWob1dU6H9FE2Dhg0Y1XFOx4=@protonmail.com>
In-Reply-To: <251eb1e3-0fcd-eb22-72b9-8ab2f2a5e962@gmail.com>
References: <bdJVxLiFr_PyQSXRUbZJfFW_jAjsGgoMetqPHJMbg-hdy54Xt_ZHhRetmnJ6cJ99eBlcX76wy-AvWwV715c3YndkxneSlod11P1hlaADx0s=@protonmail.com> <20200823153746.GB1093@savella.carfax.org.uk> <251eb1e3-0fcd-eb22-72b9-8ab2f2a5e962@gmail.com>
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

On Sunday, August 23, 2020 7:21 PM, Andrei Borzenkov <arvidjaar@gmail.com> =
wrote:
> It's not about LUKS container. systemd tool attempts to reserve full
> size of image with LUKS inside using fallocate which fails. It never
> gets as far as actually unlocking it or mounting filesystem inside.

Yes, thanks Andrei for additional clarification. Here I unlocked and mounte=
d home partition manually just to show what's the state of filesystem on it=
 (I guess that's not important here). Usually, it should be unlocked and mo=
unted by systemd, but it fails because of fallocate failure.


On Sunday, August 23, 2020 6:37 PM, Hugo Mills <hugo@carfax.org.uk> wrote:
> The / filesystem is a clear case of needing a data balance. See
> this link for what to do:
>
> https://btrfs.wiki.kernel.org/index.php/FAQ#if_your_device_is_large_.28.3=
E16GiB.29
>
> and see also this link for how to read the data you've pasted here:
>
> https://btrfs.wiki.kernel.org/index.php/FAQ#or_My_filesystem_is_full.2C_a=
nd_I.27ve_put_almost_nothing_into_it.21


Thanks for a very quick response and links, Hugo, those are definitely usef=
ul for me. But the issue here seems more complicated. I forgot to write abo=
ut it, but the state of root filesystem differs before and after fallocate =
attempt (or trying to log in as systemd-homed user).

Before:

    # btrfs fi show

    Label: none  uuid: b68411ce-702a-4259-9121-ac21c9119ddf
    =09Total devices 1 FS bytes used 299.71GiB
    =09devid    1 size 476.44GiB used 301.03GiB path /dev/nvme0n1p2

    # btrfs fi df /

    Data, single: total=3D300.00GiB, used=3D299.29GiB
    System, single: total=3D32.00MiB, used=3D48.00KiB
    Metadata, single: total=3D1.00GiB, used=3D438.38MiB
    GlobalReserve, single: total=3D62.16MiB, used=3D0.00B

After:

    # btrfs fi show

    Label: none  uuid: b68411ce-702a-4259-9121-ac21c9119ddf
    =09Total devices 1 FS bytes used 299.71GiB
    =09devid    1 size 476.44GiB used 476.44GiB path /dev/nvme0n1p2

    btrfs fi df /

    Data, single: total=3D475.41GiB, used=3D299.29GiB
    System, single: total=3D32.00MiB, used=3D80.00KiB
    Metadata, single: total=3D1.00GiB, used=3D438.39MiB
    GlobalReserve, single: total=3D62.16MiB, used=3D0.00B

If I do "btrfs balance start /" it becomes like before fallocate attempt, b=
ut it still doesn't fix the issue for me. fallocate and hence "homectl auth=
enticate" would still fail.
