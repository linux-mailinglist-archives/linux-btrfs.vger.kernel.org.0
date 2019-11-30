Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E32510DE4B
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Nov 2019 17:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfK3QjL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 30 Nov 2019 11:39:11 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34772 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbfK3QjL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 30 Nov 2019 11:39:11 -0500
Received: by mail-wr1-f68.google.com with SMTP id t2so38627359wrr.1
        for <linux-btrfs@vger.kernel.org>; Sat, 30 Nov 2019 08:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LzWK4Jc6TbhIljX6H92OafYfTdQOR2exz7sE2t2K5Dk=;
        b=IU0h7Bz3/sR/HBASdp5PrUSBo+l7PugRPA0H3RPIZ92920Q/JdkYqJ13iZkG5nCwyx
         VUYf5wNaqXV0xk3vusPY2breQPVTeuN7DFCGyq7/7xLRIrBxbA75mGtAX4VQW8E/pyTQ
         0GScpKhYZ/Fdhn8eZluBAN1mYibKXM8g0I0wlr4Wfd43+a7uFu8fB51+SmGC88h9VkCI
         hOCfCBUERMVggCFl28Hd00mp8B9zGlZ5mx2wgS4JQrY+UZxX8gbu3wEDbrln+J5Rf8cd
         z91HS0mGT+BgKsgH6MR/NfhHU3D0hx1QgCqmGonm3IJ9Eq+Fn1v6LoNqjt2SwLX7GBuU
         5dDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LzWK4Jc6TbhIljX6H92OafYfTdQOR2exz7sE2t2K5Dk=;
        b=i5x+KjCtR1Vod7PpY3p6MUOYGdpv7+D2+72Q1g7e5QusJD7C7tpy3TDS/avDDFPhXy
         YN+fX6abapn2VhDK60mKV+ZX1iINJuFtj0DztWFaBJB9Y1BgdMhvw2tj4/755lWBDtlP
         O8Hh2RQU2Bl4WqoPdEpb67qOKeWQHGAcQkWKjo51/2p/I7IbcvfhCuDBYzeddAYY6maA
         VxkrnZPMGW6+HPzIUhJmgWxQ2Gr+JsaN5g8byLDsejFFUiKuLwW+Faj2bjT2Po66Lb8+
         q0Hz5G4BTPEY4YS1KylP2n+oNYwL+jUEhnPIxUooUoA4VcpJ+k5qSkj1efBCX7TQQp0o
         4nBw==
X-Gm-Message-State: APjAAAVzbVLoEwwdUpOZjxlFOOYdH5D5TDJs2VoTul2K7J3a/Deqp2xq
        dklIA8B+MI+rDuOO314qJYucbXV+pxaGOJiQbjJqOMWEoTs=
X-Google-Smtp-Source: APXvYqx0OS/5ke2DT5bDmIad5R4/dhcnUAyhxjuDjufJJfDMb9232rzX/hB0xBYzV8wSYBXzV6iaFQHPi6XjQ7UaBnI=
X-Received: by 2002:adf:82f3:: with SMTP id 106mr15672037wrc.69.1575131948757;
 Sat, 30 Nov 2019 08:39:08 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtSeZu8fRzjABXh3wxvBDEajGutAU4LWu0RcJv-6pd+RGQ@mail.gmail.com>
 <a48a6c50-3a03-0420-ad8c-f589fafe6035@libero.it> <CAJCQCtR6zMNKnhL7OZ8ZGCDwPfjC9a1cBOg+wt2VqoJTA_NbCQ@mail.gmail.com>
 <CAJCQCtS2CP75JTT4a6y=rzqVtkMTqTRoCvJK9z3mMwLRfKo9Xw@mail.gmail.com>
 <12f98aaa-14f0-a059-379a-1d1a53375f97@inwind.it> <CAJCQCtQF6xtBDWc+i3FezWZUqGsj8hJrAzYpWG+=huFkmOK==g@mail.gmail.com>
 <69aaf772-9eb0-945a-5277-40895e6901de@inwind.it> <CAJCQCtS6V+f5hq2Cu4r7g9nXB-nRPwUaL+=rh_Ets2mWtHrMcA@mail.gmail.com>
 <35b330e9-6ed7-8a34-7e96-601c19ec635c@inwind.it> <CAJCQCtQaq7r2G7Ff--n5g2eVknPtKcQjebj-=eoNjM-18hwhKw@mail.gmail.com>
 <0ce1c050-d90c-1351-ff56-4edc054463a4@inwind.it> <CAJCQCtQSgTG=r0+i=M7nKgz5ncqcfEkZmQci5Kk12PmDVzgmbg@mail.gmail.com>
 <7aed9b06-b6e9-abef-0241-f542ffffdfc7@inwind.it>
In-Reply-To: <7aed9b06-b6e9-abef-0241-f542ffffdfc7@inwind.it>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sat, 30 Nov 2019 09:38:52 -0700
Message-ID: <CAJCQCtQSpHLzb8qDDh8eMidoyC5OwyD1aDn=GT0PxYcAoJFmXw@mail.gmail.com>
Subject: Re: GRUB bug with Btrfs multiple devices
To:     Goffredo Baroncelli <kreijack@inwind.it>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Nov 30, 2019 at 1:12 AM Goffredo Baroncelli <kreijack@inwind.it> wrote:
>
> On 29/11/2019 22.17, Chris Murphy wrote:
> > On Fri, Nov 29, 2019 at 12:54 PM Goffredo Baroncelli <kreijack@inwind.it> wrote:
> >> Could you be so kindly to share the picture of the loading of the kernel/initramdisk ? Something like:
> >>
> >> grub> set debug=all
> >> grub> initrd /boot/initrd....
> >>
> >> I hope that the errors come quickly. I don't think that we need the pictuers of all the download. It would be sufficient the pictures until the first (or better second) error....
> >
> > I paged through it for minutes, hundreds of pages and never found any
> > errors. But these are the first pages. This might actually be some
> > kind of search, not load of the kernel, because I pressed tab to
> > autocomplete. But it didn't autocomplete it immediately started
> > spitting out debug pages.
> >
> > https://photos.app.goo.gl/kpa7dJ9spAy29yj26
> >
> > Is it possible to redirect grub debug output to a FAT file?
>
> It is possible to redirect to a serial console ..
> Did the machine has a serial port ?

USB and wired ethernet.

So far I'm unable to reproduce in a VM with 2 partitions used for 2
device Btrfs. It might be a multi-layer bug where the 1st bug must
happen before the 2nd one has a chance of being revealed. The 1st bug
being the issue of phantom devices, which *are* present when the Btrfs
is a single device volume, but none of the errors show up in the
GRUB/pre-boot environment until the 2nd device was added (and new
kernel installed).

It's too bad GRUB doesn't have a debug option to write a file to a FAT
file system. The btrfs debug output is extremely long.


-- 
Chris Murphy
