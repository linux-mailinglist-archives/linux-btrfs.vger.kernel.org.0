Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3394F150A8E
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2020 17:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728637AbgBCQMg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Feb 2020 11:12:36 -0500
Received: from mail-wr1-f46.google.com ([209.85.221.46]:38047 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727708AbgBCQMf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Feb 2020 11:12:35 -0500
Received: by mail-wr1-f46.google.com with SMTP id y17so18976868wrh.5
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Feb 2020 08:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4N0QmASCFX46LFIaeYN1POeGNExQvlaR2/FlI/XPDaY=;
        b=wI2pclgdqgXkS8yRhA3UV2GhbEeGLe0cU1kheurPlBcp5rvdxvFuMKTq9Zx9miSeNf
         ckapo7krkF+oJJP5QU9GuMMH/I2IJ5AiF+Tbgr07b88r9mPZLQfKutRPvy7Oc46F1RV/
         AcGsyLjZ7P7EIQTKGCol+ShXw5hDAkBloJpI80tmlZPNIQ2+RzT/A5he0a+t17SXCvEp
         NYiuY70ry0NukfhfQglS878H7KX6YmsiAwn6MnMUZzHu7GtlnHyfA1ufl5sI2QSMKFfJ
         Jn2kaO2JAndemQLrtJ+F5e5z91lcGB9+CyDJGkfHEG1hkQve7nF19BYyIPXjUuuwWGjj
         w+RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4N0QmASCFX46LFIaeYN1POeGNExQvlaR2/FlI/XPDaY=;
        b=m7dVQkb0vm78yvfyYnINXSpWEQgHh6eVAFoPqdOB2se2gdlHc7xXRX3j8jHqNEn5a8
         u4+tByy5bHcobDnkhJmYJ5YNg5F3G48H9mSvGdkW7DE+R8tegE6GtiQkKmW0tNu58fj0
         YlbMJHR8oJyu7zeL1eXItoiYrzYAVSI1NyJwEvfApl0y2+4Di+mT/ta+s6PwZA67YNoj
         WgGte0zW1b0u84a37zqTAteIo/MEbO/IGuAkdlgoWqSXpkXeW5zD4WbtEKr6OaIrlDfA
         R//eEjyej/J20685NaU9HD7T947fcfmXejoeQBdluQ5bjepHGyH01hflClTNOkfEzkwo
         C8lA==
X-Gm-Message-State: APjAAAUscCe8LHqoJYOwgxlhd9HGdBHy9vT5d16DGPNTNjvXHrNFDfQV
        Zi3FtwEB6x7E/umRUVedbJrzG/7d88OoFag07OE53A==
X-Google-Smtp-Source: APXvYqyddGjg8hHfQg5GPfppy2Hof9PcINileIVfuasxzI648b+uZSJJ4g0evkx2VpqI5mXUOBsuShhmsds84bnIEQU=
X-Received: by 2002:adf:fa43:: with SMTP id y3mr16167603wrr.65.1580746353474;
 Mon, 03 Feb 2020 08:12:33 -0800 (PST)
MIME-Version: 1.0
References: <CACN+yT_AYiLc29M41U+WrQHtk4t==D-4AkH+wRROKJY=WstGAA@mail.gmail.com>
 <a9069bcb-73d2-09fa-e156-a1a3037303c5@petaramesh.org> <20200202233446.GT13306@hungrycats.org>
 <CACN+yT-0B7ytOTEh-uv4T+NBShQBgpRGUhYMv4O=zFi5K0QRoQ@mail.gmail.com>
In-Reply-To: <CACN+yT-0B7ytOTEh-uv4T+NBShQBgpRGUhYMv4O=zFi5K0QRoQ@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 3 Feb 2020 09:12:17 -0700
Message-ID: <CAJCQCtRhTWJuF_=BC0Ak2UtU7RcT2xruHpkYew6zSz2jH3916A@mail.gmail.com>
Subject: Re: My first attempt to use btrfs failed miserably
To:     Skibbi <skibbi@gmail.com>
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        =?UTF-8?Q?Sw=C3=A2mi_Petaramesh?= <swami@petaramesh.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Feb 2, 2020 at 11:28 PM Skibbi <skibbi@gmail.com> wrote:
>
> pon., 3 lut 2020 o 00:34 Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
> napisa=C5=82(a):
> >
> > Same here, except I have seen problems as well as successes.  Some hint=
s:
> >
> > The log is incomplete but there is some evidence of USB disconnects.
> > These are bad.  Fix those before you try to use this hardware to store
> > data.
>
> Yeah, I found out some errors in dmesg suggesting this:
> [  370.569700] usb 2-1: reset SuperSpeed Gen 1 USB device number 2
> using xhci_hcd
> [  428.820969] usb 2-1: reset SuperSpeed Gen 1 USB device number 2
> using xhci_hcd
> [  473.621875] usb 2-1: reset SuperSpeed Gen 1 USB device number 2
> using xhci_hcd
> [  618.254211] usb 2-1: reset SuperSpeed Gen 1 USB device number 2
> using xhci_hcd
> [  664.334958] usb 2-1: reset SuperSpeed Gen 1 USB device number 2
> using xhci_hcd

I get these with a very common USB-SATA enclosure bridge chipset,
plugged directly into an Intel NUC. I also sometimes see dropped
writes. When I use a Dyconn USB hub (externally powered) it never
happens. I'm not a USB expert, but my understanding is a hub isn't a
simple thing, it's reading and rewriting the whole stream to and from
host and device. So any peculiarities between them tend to get cleaned
up.

> Yeah, WD Passport Drives are using USB-SATA. I will experiment a bit
> more with that.

It might be defaulting to using the Linux kernel's uas driver, there's
a way to blacklist that if it's causing problems. I have yet another
enclosure that gives me fits with uas driver, but again no problem if
connected through the hub.


> Yeah, I need to check if my Pi is not having power issues under heavy
> load (save data on encrypted partition).

A laptop drive will draw more than 1A on startup. And about 0.3A while
spinning and writing. That's quite a lot, hence also why I stick it on
a hub with an external power supply.


--=20
Chris Murphy
