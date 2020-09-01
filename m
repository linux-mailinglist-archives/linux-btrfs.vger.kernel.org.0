Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D621E259BBB
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Sep 2020 19:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbgIARGR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Sep 2020 13:06:17 -0400
Received: from mail4.protonmail.ch ([185.70.40.27]:57954 "EHLO
        mail4.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729752AbgIARGP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Sep 2020 13:06:15 -0400
Date:   Tue, 01 Sep 2020 17:06:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1598979972;
        bh=Ff1Y3Hens4ZpeZVm4N47cWprKx7+0MyY6Hh5QLU1B0Q=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=dybJ4qKnadO8Tn08SIq59Mfx519wCg+a9x9QG+vnAXmtyJI8f7o+AWYNhjfJmdSEF
         8KnojsGetwKunYUAg+D5DJpxZhxLZ24QIkC1oz2+noBcHWZEK1YxUlqrMkMxiGtu49
         T3oL3/JF95aHbY3WbupvbqCkWbfXkmOQJBngCo+A=
To:     Chris Murphy <lists@colorremedies.com>
From:   Andrii Zymohliad <azymohliad@protonmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Reply-To: Andrii Zymohliad <azymohliad@protonmail.com>
Subject: Re: [Help] Can't login to my systemd-homed user account due to fallocate failure
Message-ID: <OpaR4q6qHHmnUMeRS6_aPu4cgwiwIXFIuVFcCyTJ5tR96gqj0wjAJDnspXY0SydaKgAD79u8CxC_8-XiSRkL7kkDf-Oqmz5-awgn4g4-eqw=@protonmail.com>
In-Reply-To: <CAJCQCtSB3QrA74tAH=_Fa-f8WWXJUANgt1_0PRbLcDUgBho-GQ@mail.gmail.com>
References: <bdJVxLiFr_PyQSXRUbZJfFW_jAjsGgoMetqPHJMbg-hdy54Xt_ZHhRetmnJ6cJ99eBlcX76wy-AvWwV715c3YndkxneSlod11P1hlaADx0s=@protonmail.com> <dHPyoaNUuxoqxJjpSUjcxZvk21ew2ObKWFFhX0efJKBqjG8m27px3mPupviQuM3HYQDEcYQGFQ9jOprBuAX4x1Em3oVOyDl6EhKwEJSiuXs=@protonmail.com> <CAJCQCtSVMAEZP5OT77yCEBw9Z3C=oyVKcicWbRV9p_+pKcRwoQ@mail.gmail.com> <gp99KJ83xX5hsbU2_hXblYTSDI6Rmkk2fbRYAcKNoQik1CH8siYdTw11qFuFdAqo-iC48cJcB_vbMJgY8HuSySoWoBW3hcYHewIgB87Kzzw=@protonmail.com> <CAJCQCtQZW2ps1i4b6kGBd_d8icYZWyz5Ha+Ozo0VjsbvVNf03w@mail.gmail.com> <CAJCQCtR4y180_96BGu08ePGLxo8dq7mAV7H248d8X85FcS0MOw@mail.gmail.com> <CAJCQCtStgn4WjisTf6628UEcB8_eP0_9WETDSB6YtGa4VDPgPw@mail.gmail.com> <KzGwc4OhDq6qR43tQSjynifhYV7E1mfeZeQjBWWRNwithi65kenn7yS22w-bbi_OHYXAkYA6y44iMYCYLAWu2g2V3s47Uor_aYMRk-NgoOU=@protonmail.com> <CAJCQCtSB3QrA74tAH=_Fa-f8WWXJUANgt1_0PRbLcDUgBho-GQ@mail.gmail.com>
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

Hi, sure!

> 1.  ls -li /home/azymohliad.home

43141 -rw------- 1 root root 322122547200 =D0=B2=D0=B5=D1=80  1 19:57 /home=
/azymohliad.home

> 2.  filefrag -v /home/azymohliad.home | grep -m 10 shared

87954: 52756487..52756516:  291198215.. 291198244:     30:  291722503: shar=
ed
87955: 52756518..52756522:  291198246.. 291198250:      5:             shar=
ed
87956: 52756524..52756528:  291198252.. 291198256:      5:             shar=
ed
87957: 52756530..52756530:  291198258.. 291198258:      1:             shar=
ed
87958: 52756532..52756534:  291198260.. 291198262:      3:             shar=
ed
87959: 52756536..52756546:  291198264.. 291198274:     11:             shar=
ed
87960: 52756548..52756553:  291198276.. 291198281:      6:             shar=
ed
87961: 52756555..52756557:  291198283.. 291198285:      3:             shar=
ed
87962: 52756559..52756578:  291198287.. 291198306:     20:             shar=
ed
87963: 52756582..52756595:  291198310.. 291198323:     14:             shar=
ed


> 3.  Pick any line, multiply the first extent (4th column) by 4096, this
>     is the bytenr
>
> 4.  btrfs inspect-internal dump-tree -t 5 /dev/nvme0n1p2 | grep -C 10 <by=
tenr>

No output for any of the extents above. For example:

291198215 * 4096 =3D 1192747888640

Then the following produces no output:

    sudo btrfs inspect-internal dump-tree -t 5 /dev/nvme0n1p2 | grep -C 10 =
1192747888640



