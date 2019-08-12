Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4A9A8A2C8
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2019 18:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbfHLQAZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Aug 2019 12:00:25 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45672 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbfHLQAZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Aug 2019 12:00:25 -0400
Received: by mail-wr1-f67.google.com with SMTP id q12so14765697wrj.12
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Aug 2019 09:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tXcnnJCnxUMls+bWIuvgK8z1IU5uXmFN2ALhvbpr7E4=;
        b=rXf/Q+GLMNj3ncMfMZODKYJ7uCmIWlipCaW6s6kv6SxAycp8zLLexgqmRn0jNM7V7K
         E7EsiYNL2Ny+Si3Nnc+OQwTlyOYdYMY49f4ksOY2ZUquGiDyUWUTkaYG4uAbScfdZvBV
         jZlsl3vLTH48cWS0vvaBMiMqDTRFt1jLPZXCnzirOMwOnhsHrOprv+NTzt6bIess6/z3
         oAeKZgWfv3yQq2j4/fktm/4oS1YoADVS7ZLmVzJAX2lHhLth28njqHgJnK5jMSJ5lg3u
         0b71rZbFYsJRaAfcaur9onGDmY0CxmeHGfOUJ18w4rtIZkLBIpRa+PxToK5itHZHizSL
         BxzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tXcnnJCnxUMls+bWIuvgK8z1IU5uXmFN2ALhvbpr7E4=;
        b=q8RWUuw4pzsbc6KzmeIN5rjYkdIv5qqN3UfhsjtEytAjxnBpBjvKR7czrfuzap1kFp
         Vq/B5tOt93ED6xiV8IIY1bWuQk8Djr5kDSUzpKNelgDP+2qtVfqQ4BxO7BeopD9g8bnD
         3r82rnyEFfPsSW9NB9uAT4ZnXubw/0bbcETFbXsLSh375KLidl3hEvqM60hj8B3qy484
         OsUm1gNuVLPiRgK4ww34CQBzkvlcYNO5xdXzKfC21O0d9BPYtwrvybkVtdIn9d+Rck/e
         yrVnzzFOfBnSuzgbmpL/EuYIeaiAAb5WbPD0vP/P7nNUlV0i4EIx1GGFu3r6OwCGVRxm
         LhSw==
X-Gm-Message-State: APjAAAW9Fu3lViFxbfCIBOVLsM0IuqHM1h9KRymv47TNaK1Me5Nyglxx
        TSZBiDqdiotqVJuEXA5mh5cMmOBluUy0xJoo3I1JCQ==
X-Google-Smtp-Source: APXvYqxjZU9cmjXDB0w7s40aamQTFxyX5XBnVbyj0XA8mVwV5Sjxf4TajsGmDJP34RzgmEgMjXBPfST9x2wuyBzeNGE=
X-Received: by 2002:adf:ed85:: with SMTP id c5mr11443926wro.268.1565625623978;
 Mon, 12 Aug 2019 09:00:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtSZ=0p-hFFgFW6hXmAHF=3yv+29DQO_=coc1Kmtzh-bvg@mail.gmail.com>
 <e70b4ea0-3416-14ce-79de-4a4c0bf2c9cd@gmx.com>
In-Reply-To: <e70b4ea0-3416-14ce-79de-4a4c0bf2c9cd@gmx.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 12 Aug 2019 10:00:13 -0600
Message-ID: <CAJCQCtTxrK1pWaqVd2NbT1d+P_UFxGD=a_i3i7xn7K7v+3vSxQ@mail.gmail.com>
Subject: Re: many busy btrfs processes during heavy cpu and memory pressure
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Aug 11, 2019 at 11:43 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2019/8/12 =E4=B8=8A=E5=8D=8810:27, Chris Murphy wrote:
> > I'm not sure this is a bug, but I'm also not sure if the behavior is ex=
pected.
> >
> > Test system as follows:
> >
> > Intel i7-2820QM, 4/8 cores
> > 8 GiB RAM, 8 GiB swap on SSD plain partition
> > Samsung SSD 840 EVO 250GB
> > kernel 5.3.0-0.rc3.git0.1.fc31.x86_64+debug, but same behavior seen on =
5.2.6
> >
> > Test involves using a desktop, GNOME shell, while building webkitgtk.
> > This uses all available RAM, and eventually all available swap.
> >
> > While the build fails on ext4 as well as on Btrfs, the difference on
> > Btrfs is many btrfs processes taking up quite a lot of cpu resources.
> > And iotop shows many processes with unexpectedly high read IO. I don't
> > have enough data collected to be certain, but it does seem on Btrfs
> > the oom killer is substantially delayed. Realistically, by the time
> > the system is in this state, practically speaking it's lost.
> >
> > Screenshot shows iotop and top state information for this system, at
> > the time sysrq+t is taken.
> >
> > Full 'journalctl -k' output is rather excessive, 13MB uncompressed,
> > 714K zstd compressed
> > https://drive.google.com/open?id=3D1bYYedsj1O4pii51MUy-7cWhnWGXb67XE
> >
> > from last sysrq+t
> > https://drive.google.com/open?id=3D1vhnIki9lpiWK8T5Qsl81_RToQ8CFdnfU
> >
> > last screenshot, matching above sysrq+t
> > https://drive.google.com/open?id=3D12jpQeskPsvHmfvDjWSPOwIWSz09JIUlk
>
> This shows it's btrfs endio workqueue, which do the data verification
> against csum tree.
>
> So you see the point, ext* just doesn't support data csum.

But 10-17% CPU, times 8 processes? Even during scrub at maximum SSD
read there isn't such a load doing csum computations.

Get a load of this screenshot:
https://drive.google.com/file/d/1IDboR1fzP4onu_tzyZxsx7M5cT_RJ7Iz/view

That doesn't even make sense. How is it possible Btrfs is using 100%
CPU times 10 processes? There aren't even that many cores. And then
Firefox is using 800% CPU? Another 8 cores that don't exist. And then
look at iotop which is reporting 28G/s reads? This is an ordinary SATA
SSD that can't do more than maybe 600M/s reads. Something is very
weird and misreporting. But again, only on Btrfs. It doesn't happen
with ext4, even though the system hang user experience is the same and
not worse on Btrfs. Just the system statistics seems much crazier on
Btrfs.

The other time I've seen this behavior? Running Firefox through gdb
with certain kinds of crashes, that have nothing to do with swap.

--=20
Chris Murphy
