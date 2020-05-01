Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58D691C1C4C
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 May 2020 19:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729661AbgEARwl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 May 2020 13:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729611AbgEARwk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 1 May 2020 13:52:40 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361FCC061A0C
        for <linux-btrfs@vger.kernel.org>; Fri,  1 May 2020 10:52:40 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id s8so2042524wrt.9
        for <linux-btrfs@vger.kernel.org>; Fri, 01 May 2020 10:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mMqVSxrMj8pv45x/DXgKeyNBm7tPbIuLSSRyy2WNu4g=;
        b=EwSsEcoZBiSGB6txaFG1I0I9IfI4CxFgtmK/HSWW59/Rt/pleCi0Pu5ez23XzXU354
         CfZZOhTNoY/RbBPd84Zy6fhVGdZ/ojnQdG+R/T4YlIQJVFAjiIics7bo1/MNdKaVv+Gr
         jliCmqF+Pqdj88w3ev9rlo0q6TcQ3E0bR/EoPnwxYiiP2vz75TS854h9rJXJNmhb1low
         7jqUQhS08xYgRZUpPbWweo9IHrRmicCjeogSSlxS0pDfPHUmwU6Ahkh/uSKobQFPdH6e
         RfB9SsufOnaiGudp9iHtpCzyN21uKrvQDLPZnxG0x3XOALZfrZANaOxAwpHVrNNOdkMj
         ZC7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mMqVSxrMj8pv45x/DXgKeyNBm7tPbIuLSSRyy2WNu4g=;
        b=YULTSoU90PiKOVOPKSz1sD993BRu4Nb2z8stIrEI13nqiIseEbe94ldaJ4zhJ3M75S
         hum9eBtkoMBt4BuaZx4aaALcErdDmFNgT2frTJ7R9g3IgDXRBwETPvar8slK8lUPGlzG
         sxBPz+0LQRtEU0eu4whCTOql95Z/PfTEU8Y1j+FTzSbdxqsq1bQ9pjvHWLVYZwkVBrLu
         YuuhYL3I/SblCw3JjksuZ018vX73WxCP3salmJ/k54Zr/dWTTmd62vOvWjQb+0FDHmfn
         mdK0d1mePSKtuIyvWXTy7d9RG2RdUaVCTDEkSrDM9DXMh6onxbVjrbuCNcL25HA+twb+
         IveA==
X-Gm-Message-State: AGi0PuZqmCpJb2LgcOOYkmdV/KHh5gAFjBGkuUm32O/aLXh9fsNR7i5r
        pabbfqHJcwNM6zbJ4tX4fBWwhMIly9hh6p/U/57h3Q==
X-Google-Smtp-Source: APiQypIExgUkBG733kOftVdZKqQedy5Fqn6gOo1pAjJyX9LGDB/QYd90NMOSI74esEeexLhZHpR0WZlx18B1/+VwTqw=
X-Received: by 2002:a5d:5273:: with SMTP id l19mr5248733wrc.42.1588355558844;
 Fri, 01 May 2020 10:52:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAAhjAp1zghNnRpbA2WypBU9+Azeui8kTQiTj+DfbK-iX-z71WQ@mail.gmail.com>
In-Reply-To: <CAAhjAp1zghNnRpbA2WypBU9+Azeui8kTQiTj+DfbK-iX-z71WQ@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Fri, 1 May 2020 11:52:22 -0600
Message-ID: <CAJCQCtS7mbjEVchwbJS86ujAW+TrKHBk23oYtTNQnruiUr0XSg@mail.gmail.com>
Subject: Re: Can't repair raid 1 array after drive failure
To:     Rollo ro <rollodroid@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 1, 2020 at 11:02 AM Rollo ro <rollodroid@gmail.com> wrote:
>
> Hi again,
> I'm still running into problems with btrfs. For testing purposes, I
> created a raid 1 filesystem yesterday and let the computer copy a ton
> of data on it over night:
>
> Label: 'BTRFS1'  uuid: 61e5aba9-6811-46ae-9396-35a72d3b1117
>         Total devices 3 FS bytes used 1.15TiB
>         devid    1 size 5.46TiB used 1.16TiB path /dev/sdc1
>         devid    3 size 698.64GiB used 10.00GiB path /dev/sdf
>         devid    4 size 1.82TiB used 1.15TiB path /dev/sde
>
> Today I started scrub and looked at the status some hours later, which
> gave thousands of errors on drive 4:

What happened to devid 2?

>
> root@OMV:/var# btrfs scrub status /srv/dev-disk-by-label-BTRFS1/
> scrub status for 61e5aba9-6811-46ae-9396-35a72d3b1117
>         scrub started at Fri May  1 11:37:36 2020, running for 04:37:48
>         total bytes scrubbed: 1.58TiB with 75751000 errors
>         error details: read=75751000
>         corrected errors: 0, uncorrectable errors: 75750996,
> unverified errors: 0
>
> (Not shown here that it was drive 4, but it was)
>
> Then found that the drive is missing:
>
> Label: 'BTRFS1'  uuid: 61e5aba9-6811-46ae-9396-35a72d3b1117
>         Total devices 3 FS bytes used 1.15TiB
>         devid    1 size 5.46TiB used 1.16TiB path /dev/sdc1
>         devid    3 size 698.64GiB used 10.00GiB path /dev/sdf
>         *** Some devices missing
>
> Canceled scrub:
> root@OMV:/var# btrfs scrub cancel /srv/dev-disk-by-label-BTRFS1/
> scrub cancelled
>
> Stats showing lots of error on sde, which is the missing drive:
> root@OMV:/var# btrfs device stats /srv/dev-disk-by-label-BTRFS1/
> [/dev/sdc1].write_io_errs    0
> [/dev/sdc1].read_io_errs     0
> [/dev/sdc1].flush_io_errs    0
> [/dev/sdc1].corruption_errs  0
> [/dev/sdc1].generation_errs  0
> [/dev/sdf].write_io_errs    0
> [/dev/sdf].read_io_errs     0
> [/dev/sdf].flush_io_errs    0
> [/dev/sdf].corruption_errs  0
> [/dev/sdf].generation_errs  0
> [/dev/sde].write_io_errs    154997860
> [/dev/sde].read_io_errs     77170574
> [/dev/sde].flush_io_errs    310
> [/dev/sde].corruption_errs  0
> [/dev/sde].generation_errs  0
>
>
> I tried to replace
> root@OMV:/var# btrfs replace start 2 /dev/sdb /srv/dev-disk-by-label-BTRFS1/ &
> [1] 1809
> root@OMV:/var# ERROR: '2' is not a valid devid for filesystem
> '/srv/dev-disk-by-label-BTRFS1/'
>
> --> That's inconsistent with the device remove syntax, as it allows to
> use a non-existing number? I try again using the /dev/sdx syntax, but
> as sde is gone, I rescan and now it's sdi!

devid 2 was missing from the very start of the email, so it is not a
valid source for removal.

And devices vanishing and reappearing as other nodes suggests they're
on a flakey or transient bus. Are these SATA drives in USB enclosures?
And if so how are they connected?

A complete dmesg please (not trimmed, starting at boot) would be useful.

One device is missing, and another one vanished and reappeared, I
don't know whether Btrfs can really handle this case perfectly.

> Version info:
> btrfs-progs v4.20.1
> Kernel 5.4.0-0.bpo.4-amd64

It's probably not related to the problem, which seems to be hardware
related. But btrfs-progs v4.20.1 is ~16 months development behind v5.6
which is current. And thousands of changes in the kernel just for
Btrfs.
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/diff/?id=v5.6.8&id2=v5.4&dt=2


-- 
Chris Murphy
