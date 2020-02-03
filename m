Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3DD11501BC
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2020 07:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbgBCG24 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Feb 2020 01:28:56 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:40137 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgBCG24 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Feb 2020 01:28:56 -0500
Received: by mail-io1-f67.google.com with SMTP id x1so15401293iop.7
        for <linux-btrfs@vger.kernel.org>; Sun, 02 Feb 2020 22:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eHjoW/vPYPURctA/E8gcp2fMMRKPgY73W4jlThCXRps=;
        b=gheWxT2wFFrZ66lN8+qNq/+nvSu3MjYIbC4fJB3StYV7rbrh/u+3golZ77OovLIJFN
         tm2Clqo1HoMCXRir+hSWz+xxeAf+a0yIQlESp6HMA79IaBdVJDf71+YOajHbm4MnBvhT
         NRA6pUYhHb3zPcagSJBzzcgvrethBD5mJUkUGOVaHL9bL/KDU+E/kEhSGznQ6BKMbZpk
         jpSnh0TggllgJ5FZPpmRuwTp3rC0oNdNOwHKevGU6i6WApzkk17Vy1J65ISUoXHUyu5k
         2d/K3KnDm6oecHW3yEC7s1NA3w3pdu+s8RgvdIK9ilLTEz7oqzTch8SjSgWLiekiuQLA
         +ogg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eHjoW/vPYPURctA/E8gcp2fMMRKPgY73W4jlThCXRps=;
        b=EK/JuAgw277vD/bZX6luCJ+TTv5WVz/qy4D7QFHYvZv5Gdqo0bQ4dPZTbDqlRFN8Y6
         qVa7P3BBQfv+ew+28jDn2P5NEblTmVVA4t6q4sE6vjv93ZsMUL88GvNcIbT44Q+M6rCz
         Tegd8sU3Lrkro5ZpcydAWpgMWA7yyyyF0dWogi9TICuU5cfy8lhgvvyjHX7+9akP6GOI
         VwUv9eZtxCahcbHrUtre3f4pKFDP8AQpBUpdy0JdNNzbRH5s7KoL8k928iJDFXWdXpgI
         +qq+Jb/JJtGoBEkcYUZBmjAKqQ/hD4MiMosZxcr4qIIOqVizpFzBDb2yPGXlwv2xnxjY
         y0XA==
X-Gm-Message-State: APjAAAUFAxFsJ1nl9AYY63kQWVLrJZKLt2pd5/edLYuYA55Q/XqcMfEC
        5+U8XmM5NTYbybVE2YClU5mR9LCqqampr1l40w0Ui7R/
X-Google-Smtp-Source: APXvYqzvBSlG6tIgKfekbQmMRrqC3nbIukrIxXI2UC3BHbudfE/6B8d4t5fMTWNANbWB8SJU5PRDI3zV37UWhuGJEhc=
X-Received: by 2002:a5d:9509:: with SMTP id d9mr417815iom.127.1580711335156;
 Sun, 02 Feb 2020 22:28:55 -0800 (PST)
MIME-Version: 1.0
References: <CACN+yT_AYiLc29M41U+WrQHtk4t==D-4AkH+wRROKJY=WstGAA@mail.gmail.com>
 <a9069bcb-73d2-09fa-e156-a1a3037303c5@petaramesh.org> <20200202233446.GT13306@hungrycats.org>
In-Reply-To: <20200202233446.GT13306@hungrycats.org>
From:   Skibbi <skibbi@gmail.com>
Date:   Mon, 3 Feb 2020 07:28:44 +0100
Message-ID: <CACN+yT-0B7ytOTEh-uv4T+NBShQBgpRGUhYMv4O=zFi5K0QRoQ@mail.gmail.com>
Subject: Re: My first attempt to use btrfs failed miserably
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     =?UTF-8?Q?Sw=C3=A2mi_Petaramesh?= <swami@petaramesh.org>,
        linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

pon., 3 lut 2020 o 00:34 Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
napisa=C5=82(a):
>
> Same here, except I have seen problems as well as successes.  Some hints:
>
> The log is incomplete but there is some evidence of USB disconnects.
> These are bad.  Fix those before you try to use this hardware to store
> data.

Yeah, I found out some errors in dmesg suggesting this:
[  370.569700] usb 2-1: reset SuperSpeed Gen 1 USB device number 2
using xhci_hcd
[  428.820969] usb 2-1: reset SuperSpeed Gen 1 USB device number 2
using xhci_hcd
[  473.621875] usb 2-1: reset SuperSpeed Gen 1 USB device number 2
using xhci_hcd
[  618.254211] usb 2-1: reset SuperSpeed Gen 1 USB device number 2
using xhci_hcd
[  664.334958] usb 2-1: reset SuperSpeed Gen 1 USB device number 2
using xhci_hcd

> Disable write caching (hdparm -W0).  The worst case is a USB disconnect
> while there are uncompleted writes still in the drive memory.  Filesystem=
s
> get severely damaged when that happens.  Most filesystems silently
> corrupt your data when that happens.  If write cache is disabled (and
> the USB-SATA bridge firmware isn't garbage) then a disconnect doesn't
> do as much damage and most filesystems can recover from it.  btrfs is
> very good at batching up writes so write caching does not contribute
> significantly to performance.

Thanks for the tip - will try this.

> Cables can be a near-bottomless source of problems, because a bad
> cable will trigger USB disconnects.  I find that a USB data cable will
> work for a certain number of connections and disconnections, and once
> that number is exceeded the cable is garbage and should be recycled.
> For cheaper cables that number can be as low as 5.  Some even fail on
> the first connection.

The disk is brand new so I don't expect that cable is broken. I tested
the drive under windows and it was working OK.

> Some USB->SATA bridge firmwares are broken, just swap it out with a
> different model and it'll be fine (though it may be difficult to do this
> with a WD Passport drive without taking the drive apart and placing the
> drive in a generic USB drive enclosure).  It is not possible to tell
> what board revision or chip/firmware revision is used from the outside,
> you have to open the drive and look at the USB-SATA bridge electronics.
> Sometimes you can buy two of the same model USB-SATA bridges from
> the same shop on the same day and the boards (and bugs) are completely
> different inside.  You may find one drive mysteriously works and another
> "identical" drive does not.

Yeah, WD Passport Drives are using USB-SATA. I will experiment a bit
more with that.

> If the drive disconnects, umount it before reconnecting.  Disable any
> configuration settings that might try to hide a USB device disconnection
> from the upper storage layers.  btrfs normally detects this and sets
> itself read-only, but if somehow that doesn't happen, the filesystem will
> be destroyed because part of the commit history will be missing on disk.
> On RAID1 arrays of USB devices it's more complicated, you need to run
> replace or scrub on the disk that disconnected to reconstruct the
> missing data from drives that didn't disconnect.
>
> Once you've purged your setup of broken firmware and cables, it can run
> for years without incident.
>
> 4.19 doesn't have metadata-corrupting bugs that I know of.
>
> I would be wary of 32-bit ARM.  btrfs is most tested on amd64, and
> other architectures sometimes have problems that amd64 simply does not,
> especially on large (8T+) filesystems where uint32 isn't enough for a
> device address.  That said, I have a dozen Raspberry Pis on 5.0.21 and
> haven't encountered issues other than the usual SD card failure every
> few years--but the largest filesystem on these is 128GB.
>
> Also watch out for weak power supplies on Raspberry Pi boards.  The CPU
> and memory run at a significantly lower voltage than the USB interface,
> and one symptom of a power supply that is too small or too old is that
> all the USB devices stop working reliably.

Yeah, I need to check if my Pi is not having power issues under heavy
load (save data on encrypted partition).

> > The only time I lost a filesystem whas when I got hit by the infamous
> > 5.2 bug, and it was on a classical laptop, not on a pi...
> >
> > Kind regards.
> >
Best regards
