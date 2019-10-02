Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2C14C4ADF
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2019 11:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfJBJ4A (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Oct 2019 05:56:00 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34554 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbfJBJ4A (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Oct 2019 05:56:00 -0400
Received: by mail-ot1-f67.google.com with SMTP id m19so14189231otp.1
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Oct 2019 02:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NS3jQrXc1/atst38SrKcGDTmo2lIysFAx0E7NyTdYqA=;
        b=kSMOrYueFesuxpN01fcqFcMFliepoJRqghVqQsaBE9KM9ZDIPd6UNy3lX8aAvw97kP
         UVjmx4vl8/vGps7wHut4vuFGCcRYZGKzIVEsBmnVQzecK8IrU8BNcec+LDPdycipAe6X
         BmJa/Duiv/qIDhWsNbCVfaBpwpVVbRHo77J5F9uHOwaPLkaaTJm9cyJwNo/PoO2FEaE/
         lAFka2Vqwrf7Zofpr4kTEGcWAXe3iCVDRcgTXPjTp9uLrh0jCIirLvCoGly0IklBCttI
         F5P/DVyu+X7W8ZXyQoZELxJYI0P5RqZ7zt5HXFPYShu1Jk3euhxMuu0A+/SXgtloc0HI
         8iMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NS3jQrXc1/atst38SrKcGDTmo2lIysFAx0E7NyTdYqA=;
        b=KywlBK4a5wdydpiuqOxGEwk+Y6ERTzAZPF4dzOkf407f0AQZbDB8A5CKwEUg64mZRA
         E5sZBeX4cnYcRCIvCnZwt0DXYaoMfV325TAgR2JK8m2p+rgUmjibPzklyAydatDzWNHf
         p6xRL5q1/oUPSr/cetzUst1pFDka7/1vh3Pbc9oGzC/D0uTqA0id+7R69eg8LZcJbkbs
         Z96mpucYKDViORASZl8uq8RCqsWv2ppyMmY9bJV8pNZFkGx2eIlGeQLG+rsf/ad3EOXp
         o0UY6foiGPd3OJ3lVmmLmUPLdplS8PFsuenCZQzZRx0uFIRwr0mHQugKhlJVXCzQiGY9
         x+UQ==
X-Gm-Message-State: APjAAAXDz3G9e4HeKimq8CZ7O/UaiPOs3NSVjDfLDFlOeRvqLKdrV9cP
        6vhNftuqfTyt/q13FiXHadNmXlDZ5RLcOFUwspY=
X-Google-Smtp-Source: APXvYqwtaiExKfCQ31EiTE0BwrZVJRWxnDDFIejRtuPX9C75RvEfOTIS8ftxgxpcmaWofnYvlKq++sFbUnFBn6qa14E=
X-Received: by 2002:a9d:1428:: with SMTP id h37mr2010088oth.14.1570010159233;
 Wed, 02 Oct 2019 02:55:59 -0700 (PDT)
MIME-Version: 1.0
References: <9fe6ad9b-d53f-614c-5651-6de8bad93f1e@oracle.com>
In-Reply-To: <9fe6ad9b-d53f-614c-5651-6de8bad93f1e@oracle.com>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
Date:   Wed, 2 Oct 2019 12:55:47 +0300
Message-ID: <CAA91j0UjpNycY0xhGVCzAkUJiwmrBPmk9PU6MpvW7mO0Zgki-g@mail.gmail.com>
Subject: Re: [bug] strange systemd-udevd scan for btrfs device
To:     Anand Jain <anand.jain@oracle.com>
Cc:     systemd-bugs@lists.freedesktop.org,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 2, 2019 at 12:27 PM Anand Jain <anand.jain@oracle.com> wrote:
>
>
>
> I am looking for systemd part of the answers to understand what
> is triggering a strange problem. Any help is appreciated.
>
> After mkfs.btrfs creates btrfs filesystem it scans to register the
> device in btrfs.ko.
> And we have 'btrfs dev scan --forget' command to undo the process of
> register.
>
> But the problem is - immediately after 'btrfs dev scan --forget' the
> systemd-udevd scans the device again, defeating the purpose of the
> forget as show below (scanned-by).
>
> mkfs.btrfs -fq /dev/sdc && btrfs dev scan --forget /dev/sdc
>
> -------------------
> kernel: BTRFS: device fsid 8ea20bb2-888a-4b3b-9f4c-1db9117dc219 devid 1
> transid 5 /dev/sdc scanned-by mkfs.btrfs
> kernel: BTRFS: device fsid 8ea20bb2-888a-4b3b-9f4c-1db9117dc219 devid 1
> transid 5 /dev/sdc scanned-by systemd-udevd
> -------------------
>
> And the problem does _not_ happen if there is a sleep of 3 secs after
> the mkfs.btrfs, as below.
>
> mkfs.btrfs -fq /dev/sdc && sleep 3 && btrfs dev scan --forget /dev/sdc
>
> ------------------
> kernel: BTRFS: device fsid 601bd01a-5e6b-488a-b020-0e7556c83087 devid 1
> transid 5 /dev/sdc scanned-by mkfs.btrfs
> ------------------
>
> Any idea what happening from the systemd point of view?
>

run

udevadm monitor -ku

in both cases and post results. My educated guess is that udev scan is
in response to mkfs and you have unfortunate race condition here.
