Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87307C89BA
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2019 15:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbfJBNdS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Oct 2019 09:33:18 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:38194 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbfJBNdS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Oct 2019 09:33:18 -0400
Received: by mail-oi1-f193.google.com with SMTP id m16so17635557oic.5
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Oct 2019 06:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bg2vq2F4tMxUOPKoQDBxhALTmY3gNeWFcsyX2h0q8gU=;
        b=p38d9t/8C2/C/kp4DgSO4wp79ARvNt0gcHPrQCIPy+QjpWpx8J0iXo/wSOKQB0V/UM
         nhwK7lTjRVFwh+YSwULbaLQBrPYZ6BrLZ9b7mh6tlSbKtEcXfSP/pBAdA+rHWIwzTQXh
         YJ5anY/fBzTqWDe622tNP84OcjDKViALwDhGeAysunFG41DGHxHHYKriSzkY7kbfqE7r
         m4Jyp8szgvKV7r9J6buF2Ln3CVpe5o/qKbOuv3daMA5lnMvgOCvksUUJ+49Opeic+prz
         Ck9/Qz5sKYJ+d9x6sk5RFENUkJ3uz0bM5p8ePamw7FDxL1uIsfAE4EeKX/XZB2HfEVMS
         h0Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bg2vq2F4tMxUOPKoQDBxhALTmY3gNeWFcsyX2h0q8gU=;
        b=OwCDZmiqL3ghW9tQHwsiMR+jcU9o0Pl+xQMXeeTUz6BNMHrQwSBkzfrUToR5pjDvoa
         3UTzaRD898iuZhBAbeDqEqEHPSk8PZEzSiBBhvVra1IvZ8kb60Dc9grGlPVLkcOQvURI
         YUmR0e5WC4MF+0P/DOtDLjCVdGVHrNERP4OlM+UDOVipVdQ0sg4MreAchvm+p7XkyF7U
         kGUDjJ/pqfZbpnwWoxLFt3MThkPUvC1bERV8uLKBH+exXJ5ba1L5E5GMBXD2n3/Fg83k
         duBetwIjZ1rr5BbTCAJyKim+9PU9RF53RIfi7b6DVaa0QKq/HgkbU+Pf5p7fqo3NYl+W
         JKHw==
X-Gm-Message-State: APjAAAUZxGCuXT3svVsW2iqh2ZzGJDSUy0GOXCezzJX5/Lp2JAJ45pKK
        kah+B65x7NiaPpdy0/8zsfx+cHYW9R7TlP1WbE0=
X-Google-Smtp-Source: APXvYqw6g9oc8RP5AgGqKVCXqpfBzclu1JrljumYZ0VfSf66zSy9nZLqYCdC1f5QJRjOlJn+MPMxtXXkxPORnze92Hk=
X-Received: by 2002:aca:5a88:: with SMTP id o130mr2951649oib.54.1570023197595;
 Wed, 02 Oct 2019 06:33:17 -0700 (PDT)
MIME-Version: 1.0
References: <9fe6ad9b-d53f-614c-5651-6de8bad93f1e@oracle.com>
 <CAA91j0UjpNycY0xhGVCzAkUJiwmrBPmk9PU6MpvW7mO0Zgki-g@mail.gmail.com>
 <c520c4f9-8d1c-41f9-0b80-fbff8fa966a3@oracle.com> <7256e3a7-1336-9921-05af-dda48ba71375@oracle.com>
In-Reply-To: <7256e3a7-1336-9921-05af-dda48ba71375@oracle.com>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
Date:   Wed, 2 Oct 2019 16:33:06 +0300
Message-ID: <CAA91j0VbpOE=g0ao4aYJkMje+ri1c+ZhvMghv0MTyW-GLdLYhQ@mail.gmail.com>
Subject: Re: [bug] strange systemd-udevd scan for btrfs device
To:     Anand Jain <anand.jain@oracle.com>
Cc:     systemd-bugs@lists.freedesktop.org,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 2, 2019 at 1:19 PM Anand Jain <anand.jain@oracle.com> wrote:
>
>
>
> On 10/2/19 6:02 PM, Anand Jain wrote:
> >
> >
> > On 10/2/19 5:55 PM, Andrei Borzenkov wrote:
> >> On Wed, Oct 2, 2019 at 12:27 PM Anand Jain <anand.jain@oracle.com> wrote:
> >>>
> >>>
> >>>
> >>> I am looking for systemd part of the answers to understand what
> >>> is triggering a strange problem. Any help is appreciated.
> >>>
> >>> After mkfs.btrfs creates btrfs filesystem it scans to register the
> >>> device in btrfs.ko.
> >>> And we have 'btrfs dev scan --forget' command to undo the process of
> >>> register.
> >>>
> >>> But the problem is - immediately after 'btrfs dev scan --forget' the
> >>> systemd-udevd scans the device again, defeating the purpose of the
> >>> forget as show below (scanned-by).
> >>>
> >>> mkfs.btrfs -fq /dev/sdc && btrfs dev scan --forget /dev/sdc
> >>>
> >>> -------------------
> >>> kernel: BTRFS: device fsid 8ea20bb2-888a-4b3b-9f4c-1db9117dc219 devid 1
> >>> transid 5 /dev/sdc scanned-by mkfs.btrfs
> >>> kernel: BTRFS: device fsid 8ea20bb2-888a-4b3b-9f4c-1db9117dc219 devid 1
> >>> transid 5 /dev/sdc scanned-by systemd-udevd
> >>> -------------------
> >>>
> >>> And the problem does _not_ happen if there is a sleep of 3 secs after
> >>> the mkfs.btrfs, as below.
> >>>
> >>> mkfs.btrfs -fq /dev/sdc && sleep 3 && btrfs dev scan --forget /dev/sdc
> >>>
> >>> ------------------
> >>> kernel: BTRFS: device fsid 601bd01a-5e6b-488a-b020-0e7556c83087 devid 1
> >>> transid 5 /dev/sdc scanned-by mkfs.btrfs
> >>> ------------------
> >>>
> >>> Any idea what happening from the systemd point of view?
> >>>
> >>
> >> run
> >>
> >> udevadm monitor -ku
> >>
> >> in both cases and post results. My educated guess is that udev scan is
> >> in response to mkfs and you have unfortunate race condition here.
> >>
> >
> >
> > Looks like what is happening is ..
> >
> >   . Change in fsid (by mkfs.btrfs) notifies and triggers systemd
> >   . Systemd checks if the device is ready by using
> >     BTRFS_IOC_DEVICES_READY.
> >   . However BTRFS_IOC_DEVICES_READY from systemd races with forget
> >     command and the result depends on who wins the race.
> >
>
>
> I get this for the command mkfs.btrfs: (for /dev/sdc)
>
> KERNEL[185263.634507] change
> /devices/pci0000:5d/0000:5d:02.0/0000:65:00.0/host0/target0:2:2/0:2:2:0/block/sdc
> (block)
> UDEV  [185263.637870] change
> /devices/pci0000:5d/0000:5d:02.0/0000:65:00.0/host0/target0:2:2/0:2:2:0/block/sdc
> (block)
> KERNEL[185263.640572] change
> /devices/pci0000:5d/0000:5d:02.0/0000:65:00.0/host0/target0:2:2/0:2:2:0/block/sdc
> (block)
> KERNEL[185263.641552] change
> /devices/pci0000:5d/0000:5d:02.0/0000:65:00.0/host0/target0:2:2/0:2:2:0/block/sdc
> (block)
> UDEV  [185263.644337] change
> /devices/pci0000:5d/0000:5d:02.0/0000:65:00.0/host0/target0:2:2/0:2:2:0/block/sdc
> (block)
> UDEV  [185263.647656] change
> /devices/pci0000:5d/0000:5d:02.0/0000:65:00.0/host0/target0:2:2/0:2:2:0/block/sdc
> (block)
>
> And no notification for mkfs.btrfs -fq /dev/sdb
>
> Looks like there is some rules set. But I don't find any rules
> in /etc/udev/rules.d specific to /dev/sdb can it be set somewhere
> else?
>


Default rules are in /usr/lib/udev, but rules can only block udev
events (if at all), they have no impact on what kernel does. I guess
util-linux would be a better place to ask about mkfs behavior.
