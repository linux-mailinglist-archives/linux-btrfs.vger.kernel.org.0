Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42AF810C10E
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Nov 2019 01:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbfK1Am1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Nov 2019 19:42:27 -0500
Received: from mail-wr1-f43.google.com ([209.85.221.43]:39087 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbfK1Am0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Nov 2019 19:42:26 -0500
Received: by mail-wr1-f43.google.com with SMTP id y11so25832821wrt.6
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Nov 2019 16:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UonRBgGwITaOtlHcm0qWPVMdjBwCooxIFvs6Hl+Iq7g=;
        b=rN/+a+JO7feH9vD5xiLUF1yEobE+llukSOPNYHzb7zsDyaIvh4Jmj9bAIhR8gymcgd
         orEX4zS0gGyZJsPpjCEu5WqCEifAR89hwPtAQAOCkBrZi7vvpWGcrvqUbo8jHgQfahxP
         Ph0X5rkHkXH8vOOqFvW0kQL9KnZN6hxt1XjQOPNVksrI45PM7rSWe9GD1UM3GiMwneP7
         h0H/ZStOt7JuSWhsQz9Jn54huS07W8M1JX9GeYuCMuBJEzjNfObjC4moeiuoBF1ev7e4
         r8kxZXJIfcFsSKdM349oqHBc05Vqff8T1EbXBXsjkAZ5qrqtxdo9rnuYKZMCtKDqjRdu
         sdIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UonRBgGwITaOtlHcm0qWPVMdjBwCooxIFvs6Hl+Iq7g=;
        b=RAJySp8c8R+RYMFttkkNNmD81O8BOlhT3omUIcVVkcUwK/8gQNqcL/f9lX3bK+4KXg
         Ko8oAhZICrD19x0yTo+PmeKh5fo0cr3A1Ftldf2vKmywEqLfbbsIXquVGCOMs5CRZmYr
         2tcTsQo77YbUcIUA/ELQgLS6XipEg+MJznS/eGutW8OMpnddU1QFSczh2hhK4qqED/Tb
         S7lwQwS7IGXPzXOLyZZH4W3fdWbBWBzUmGRX0tcXsEqMi+EcT96OAwj1XaZlq/7gQxrb
         WZPbhqSgPL1Ae5I+X6nQG7lHVP2lMigkHuBWqtVrLxlZd9AYAvZ+OoL74wLK9WLj73sZ
         cVCQ==
X-Gm-Message-State: APjAAAUimisQiIN4k4AOkTMiH1CdyvP20gQRTfsurSf3qSiZDfc7Fzpk
        H5k1ST+f9uSrbAt6Et421SwTwbUuQr0Qaqy0MRYoHoAGqds2EQ==
X-Google-Smtp-Source: APXvYqxpTxHE4jwhSPXsUJpCv7NVOzp9yZzPd7/rwjKjrDRK71IdwteIDjraoWFUfXwXYZaHZ47OZ9OvXOMQIIa027E=
X-Received: by 2002:adf:f108:: with SMTP id r8mr14434143wro.390.1574901744373;
 Wed, 27 Nov 2019 16:42:24 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtSeZu8fRzjABXh3wxvBDEajGutAU4LWu0RcJv-6pd+RGQ@mail.gmail.com>
 <a48a6c50-3a03-0420-ad8c-f589fafe6035@libero.it> <CAJCQCtR6zMNKnhL7OZ8ZGCDwPfjC9a1cBOg+wt2VqoJTA_NbCQ@mail.gmail.com>
 <CAJCQCtS2CP75JTT4a6y=rzqVtkMTqTRoCvJK9z3mMwLRfKo9Xw@mail.gmail.com> <12f98aaa-14f0-a059-379a-1d1a53375f97@inwind.it>
In-Reply-To: <12f98aaa-14f0-a059-379a-1d1a53375f97@inwind.it>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 27 Nov 2019 17:42:08 -0700
Message-ID: <CAJCQCtQF6xtBDWc+i3FezWZUqGsj8hJrAzYpWG+=huFkmOK==g@mail.gmail.com>
Subject: Re: GRUB bug with Btrfs multiple devices
To:     Goffredo Baroncelli <kreijack@inwind.it>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 26, 2019 at 11:07 PM Goffredo Baroncelli <kreijack@inwind.it> wrote:
>
> On 27/11/2019 02.35, Chris Murphy wrote:
> > On Tue, Nov 26, 2019 at 4:53 PM Chris Murphy <lists@colorremedies.com> wrote:
> >>
> >> On Tue, Nov 26, 2019 at 2:11 PM Goffredo Baroncelli <kreijack@libero.it> wrote:
> >>>
> >>> I think that the errors is due to the "rescan" logic (see grub commit [1]). Could you try a more recent grub (2.04 instead of 2.02) ?
> >>
> >> Yes Fedora Rawhide has 2.04 in it, so I'll give that a shot next time
> >> I rebuild this particular laptop, which should be relatively soon; or
> >> even maybe I can reproduce this problem in a VM with two virtio
> >> devices.
> >
> > I was able to just update to the Fedora 2.04-4.fc32 packages. It's not
> > upstream's but it's a quick and dirty way to give it a shot. Turns
> > out, the same errors happen, although the line number for efidisk.c
> > has changed:
> > https://photos.app.goo.gl/aKWRYhJkkJRDtC1W7
> >
> > For grins, I dropped to a grub prompt, and issued ls and get a different result:
> > https://photos.app.goo.gl/MvL9QZa6zGsiktAf9
>
> Looking at the second picture, it seems that grub had problem to access the disk 0..3 not only when is doing a btrfs activity.
> No problem accessing hd4 and hd5*
>
> Could you enable the debug, doing
>
>         set pager=1
>         set debug=all

I need to narrow the scope. Adding 'set debug=all', there's just way
too much to video, minutes of pages just holding down space bar full
time which is even too fast to video. There must be over 1000 pages, a
tiny minority contain efidisk.c references, the vast majority are
btrfs.c references. As many pages as there are, I was never able to
stop right on a boundary between efidisk.c and btrfs.c. So I gave up
on that approach.

Since the errors happen with efidisk.c I've enabled 'set
debug=efidisk' and captured 74 photos, available at the link below
(they are in pager order)

https://photos.app.goo.gl/nuDH5hFMRxUVKXpX6

It does seem that the errors only happen in efidisk.c and only when
trying to read from what might be phantom devices; I do not know how a
second device in a Btrfs volume triggers this though. There must be
some interaction between efidisk.c and btrfs.c? The grubx64.efi,
grubenv, grub.cfg, and grub modules are all on an HFS+ (no journal)
file system acting as the EFI System partition (as is the default
behavior in Fedora on Macs for many years now). Only vmlinuz and
initramfs are on Btrfs. So I'm not really even sure why btrfs.c gets
called before the GRUB menu is displayed.

I'll see about reproducing this with a VM using edk2 UEFI and two
virtio devices, at least get to a cleaner environment so we're not
confusing multiple system specific weird things. And I can also leave
this particular Mac laptop as it is for further study.


-- 
Chris Murphy
