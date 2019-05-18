Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D91362216C
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 May 2019 06:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725446AbfEREGb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 18 May 2019 00:06:31 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44767 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbfEREGb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 18 May 2019 00:06:31 -0400
Received: by mail-lj1-f193.google.com with SMTP id e13so7914599ljl.11
        for <linux-btrfs@vger.kernel.org>; Fri, 17 May 2019 21:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9iPBjl2S+UwngaKyMzDlyxJtl4/YsbX0Oet3snxDCtU=;
        b=Wh3+psFXNTS5E+r8lx/vp4k9azLprxAL9hrKVwQS2fTlHGq9ouYsGQ5GrToT46pilv
         EidhW89iT6uZr/sSwKi4uzUc7OaYcSQ1kvTtnmF0OqKSRfSmCelvWnnSOy/a8TWrIxge
         T+NAkCjqNKu4m7PbU/dgpm8yT2AZgHjj8Ho0iLAuBpCvEiYRssa5GBqsiNsArL8lXlgc
         SqImj3UTT+dlQ+NBvu5QtbXXVKSVPG/5t7fx0DCVvTCpw4kLSzbbFfAJayzxtyq34uGM
         ps+CwqssYo+UKw0A/PXDnjbdsnjQhF8JkvkBddJwhLtJ7RE9WJ1Z6nFuDY71XXZdL2T5
         CEQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9iPBjl2S+UwngaKyMzDlyxJtl4/YsbX0Oet3snxDCtU=;
        b=bSzdt13LbUW5v6C2QVBtoFUEzUz+wVPFYTyaOkqWco/ldYhC02LYbI9I6mcyYfCGcX
         zp62i8kI5hSknP1mMcKSdhsTRv8NOYIJ27mixgvZSqvJpKZyrh9Wm0iaeTumOaiY5QB0
         7sAKBuewjf6mVyucOnce1iVgWu/BqLnn7ncTOSSkPHoPjMtHnXRnDDsQmoX5RtmuiImb
         zy6J5hXm9p0MEZfogcuCJpluVJsC7ldQ038VgZPfuYNHARArMJejwPu5ptTTPJwMSo5H
         JOXEeCNEsEr6OvizmdRnwt+EP2p8Ey3G+RDLMaOoyOzoHlb6s69xfdPGh8EtrkDqRw0i
         4aRA==
X-Gm-Message-State: APjAAAVRWb0GukTvxgJGoMqRJk8xpT+ErkH0J2xAozP296pvCSrqa1Me
        kmAazVWv1WYPcUP+aXazehLh85mH5hnspRtQ1q4jrA==
X-Google-Smtp-Source: APXvYqx1CRS2/bD1MueOPg1CpT9FCJoK3AhW8tmjuvazE348AT0PMUKCtdWTvQCqZEQT591L3YszvqyGpd+s1Qr5o0c=
X-Received: by 2002:a2e:8041:: with SMTP id p1mr5267211ljg.121.1558152389041;
 Fri, 17 May 2019 21:06:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAKS=YrP=z2+rP5AtFKkf7epi+Dr2Arfsaq3pZ9cR3iKif3gV5g@mail.gmail.com>
 <CAJCQCtTmZY-UHeNYp=waTV8TWiAKXr8bJq13DQ7KQg=syvQ=tg@mail.gmail.com> <CAKS=YrMB6SNbCnJsU=rD5gC6cR5yEnSzPDax5eP-VQ-UpzHvAg@mail.gmail.com>
In-Reply-To: <CAKS=YrMB6SNbCnJsU=rD5gC6cR5yEnSzPDax5eP-VQ-UpzHvAg@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Fri, 17 May 2019 22:06:17 -0600
Message-ID: <CAJCQCtQhrh8VBKe11gQUt5BSuWCsDQUdt_Q4a4opnAYE5XoEVQ@mail.gmail.com>
Subject: Re: Unbootable root btrfs
To:     Lee Fleming <leeflemingster@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Cc:     Chris Murphy <lists@colorremedies.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 17, 2019 at 2:18 AM Lee Fleming <leeflemingster@gmail.com> wrot=
e:
>
> I didn't see that particular warning. I did see a warning that it could c=
ause damage and should be tried after trying some other things which I did.=
 The data on this drive isn't important. I just wanted to see if it could b=
e recovered before reinstalling.
>
> There was no crash, just a reboot. I was setting up KVM and I rebooted in=
to a different kernel to see if some performance problems were kernel relat=
ed. And it just didn't boot.

OK the corrupted Btrfs volume is a guest file system?

That's unexpected. There must be some configuration specific issue
that's instigating this. I've done quite a lot of Btrfs testing in
qemu-kvm including the virtioblk devices using unsafe caching, and I
do vile things with the VM's intentionally trying to blow up Btrfs
including force quitting the VM while it's writing. And I haven't
gotten any corruptions.

All I can recommend is to try to reproduce it again and this next time
try to keep track of the exact steps such that anyone can try to
reproduce it. It might be a bug you've found. But we need a
reproducer. Is it using QCOW2 or RAW file backing, or LVM, or plain
partition? What is the qemu command for the VM? You can get that with
'ps -aux | grep qemu' and it should show all the options used
including the kind of block devices and caching. And then what is the
workload inside the VM?



--=20
Chris Murphy
