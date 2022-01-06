Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72B63486AB8
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jan 2022 20:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243493AbiAFT7P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Jan 2022 14:59:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243460AbiAFT7P (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Jan 2022 14:59:15 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42ECEC061245
        for <linux-btrfs@vger.kernel.org>; Thu,  6 Jan 2022 11:59:15 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id g80so10817725ybf.0
        for <linux-btrfs@vger.kernel.org>; Thu, 06 Jan 2022 11:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gJQ6DA/tW2oHmqGwxi0pKF/3mTns+lolkcRnlNUVcwg=;
        b=h8RDFRwdHH39r6jG0RxV906tEAZfBQKiJk62kYQlVODp117nd9bjzxXdT228wraGWN
         hyCYEHbtbDlKIUE2MHXLp1CR91haLc62uBm1uxDonHLYkil09V4SXKVrZkk1FmMon/o4
         bolp2zB8Ji5ESg5KBNA7eu+x7polq6UlMft+8CK4tSpSxQfxZ6tU6xZB31MUvOFZi/fu
         9lmsUYm7zacJtSjpxkVa5fNBq6ji/b9XeOfPLrLba/XUFEVKA+uRRi5IavNz29zVQP3o
         Z/QmEkJbN23sX5W9oplfNq+Fq2F7Ts2W9MJAUFnbIOphuLxpI22FIMn1NJOAHxxuytss
         J6jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gJQ6DA/tW2oHmqGwxi0pKF/3mTns+lolkcRnlNUVcwg=;
        b=jjj1BvI1+gY9RIiDP4Sb8NhmEzbXuryk0svSt5fVcAvxGNSNCSRUDta4tQab5lsIh/
         0hQqvRAqhLiNDHwbhch6HXia4wcho/+EdEBTk92mUYtMWwJOf9fAuSZeIH7sT7ev5FFK
         L8taUPSKaMNrt/ScyZfPGTdQO2c4jFg5f/D3ybZRKxV8EbOaZma07un+43vZW1yj5GSJ
         IEfYGPh624pJBOJSLmSvKoQgwAXdBe0n616IAuY9KABhSDcP3F8FbXRxmyKhY80lclGs
         b28QOYwRj8mjuBJKzJFNLeS3sLbHP/dOd/vCxd1UioGMOGgU4W+D9DqS7Ofe3cxBsDL5
         XIaw==
X-Gm-Message-State: AOAM533RqQqz7xxKB/gfqqIURAeLuz+HM8ZnI1vrSyxo9qWx8vu42iBN
        f4gj+I2eKpJH9BHeZMsod9Qsh0hqWXrwQIWFK05gIEseqK6TDIzo
X-Google-Smtp-Source: ABdhPJyl+7HstNawaSFrL7DaU5ZL9jP5ZOjb5Ie+Ohn1lHvQywe0p1qjBdG9tLHnvK2Gg3PNqibVVjKZKDEGNbDwSH8=
X-Received: by 2002:a5b:c43:: with SMTP id d3mr69000549ybr.385.1641499154410;
 Thu, 06 Jan 2022 11:59:14 -0800 (PST)
MIME-Version: 1.0
References: <CAMQzBqCSzr4UO1VFTjtSDPt+0ukhf6yqK=q+eLA+Tp1hiB_weA@mail.gmail.com>
In-Reply-To: <CAMQzBqCSzr4UO1VFTjtSDPt+0ukhf6yqK=q+eLA+Tp1hiB_weA@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 6 Jan 2022 12:58:58 -0700
Message-ID: <CAJCQCtR_oogvxKozaMM8UUiW2kKxFUnc+1cqTuwT12ZBOTDFgQ@mail.gmail.com>
Subject: Re: 48 seconds to mount a BTRFS hard disk drive seems too long to me
To:     =?UTF-8?Q?Juan_Sim=C3=B3n?= <decedion@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 6, 2022 at 8:48 AM Juan Sim=C3=B3n <decedion@gmail.com> wrote:
>
> Hard disk: 16TB SEAGATE IRONWOLF PRO 3.5", 7200 RPM 256MB CACHE
> Arch Linux
> Linux juan-PC 5.15.13-xanmod1-tt-1 #1 SMP Thu, 06 Jan 2022 12:14:06
> +0000 x86_64 GNU/Linux
> btrfs-progs v5.15.1
>
> $ btrfs fi df /multimedia
> Data, single: total=3D10.89TiB, used=3D10.72TiB
> System, DUP: total=3D8.00MiB, used=3D1.58MiB
> Metadata, DUP: total=3D15.00GiB, used=3D13.19GiB
> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
>
> I have formatted it as BTRFS and the mounting options (fstab) are:
>
> /multimedia     btrfs
> rw,noatime,autodefrag,compress-force=3Dzstd,nossd,space_cache=3Dv2    0 0
>
> The disk works fine, I have not detected any problems but every time I
> reboot the system takes a long time due to the mounting of this drive
>
> $ systemd-analyze blame
> 48.575s multimedia.mount
> ....
>
> I find it too long to mount a drive, is this normal, is it because of
> one of the mounting options, or because of the size of the hard drive?

I think it's due to reading all the block group items which are buried
in the extent tree. And on large file systems with a large extent
tree, it results in a lot of random IO reads, so on spinning drives
you get a ton of latency hits for this search.

This thread discusses some of the details as it relates to zoned
devices, which have even longer mount times I guess. But the comments
about block groups and extent tree apply the same to non-zoned.
https://lore.kernel.org/linux-btrfs/CAHQ7scVGPAwEGQOq3Kmn75GJzyzSQ9qrBBZrHF=
u+4YWQhGE0Lw@mail.gmail.com/

The mount options you're using aren't causing the mount delay. But be
certain you really want autodefrag - it's designed for the desktop,
small databases used by desktops, web browsers, and the like. If you
use it with bigger and/or very busy databases, it just results in a
ton of I/O and can really slow things down rather than speed them up.
You're better off in such a use case with scheduled defragment on a
dir by dir basis, which you can do using the btrfsmaintenance
package's btrfs-defrag.timer and .service unit, which you can
customize. It's maintained by kdave, also maintainer of btrfs-progs.
https://github.com/kdave/btrfsmaintenance


--
Chris Murphy
