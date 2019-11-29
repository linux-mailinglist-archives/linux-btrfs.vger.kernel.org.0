Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B72510D93C
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Nov 2019 18:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbfK2R56 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Nov 2019 12:57:58 -0500
Received: from mail-wm1-f51.google.com ([209.85.128.51]:52054 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbfK2R56 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Nov 2019 12:57:58 -0500
Received: by mail-wm1-f51.google.com with SMTP id g206so15036425wme.1
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Nov 2019 09:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rsXjY7pLflFzD6Nh6fAqBVzcZS7mIb93Z2UzousvdLo=;
        b=A8IvzZJOlzWTwl7MhIrQB53Er2T3QT8nHwzdmFVp3FizkUM5t3dZE0OnhecrHfchej
         oCnq7HcxMhYyaqG9uPHMrWmWUUtbtmhZd6H6F/KnJszxDR7RvJVnWqaCc4D340R/MYnv
         cOgQIFIUTRoZagKMxvVfTFUH3IGZJ00ncNVeRRaIYG3gBwjfE5knFE+yUuRoLnBDNFEx
         vjUm2mlhQw1HJgb46JhTJNvQ0tw3vkbpvs+adPnMQPfrRD2izrqaxvn/I5Mr10PUQ3fh
         68cG1NT1LT1hMfmvi0IqnPP4taRWejzBGZlsNzlUQwTNFi1m9rqG3R+CdjqKrO+/FQLL
         qU0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rsXjY7pLflFzD6Nh6fAqBVzcZS7mIb93Z2UzousvdLo=;
        b=qgWPUri05NTMjNV9UC4c10hsN6zrw8g6Vrj5UAGqfDvyuc/tS94TzboQWURAd/Ac6d
         cM4PyrCCYvN1nfgluM/3TZytel5ZtkU0caIedZXufis1sNvbEGPhSsJ7VA3ZiqjqWzTr
         lYU8X5efAEdwekreuvxYXb/aZRU+wd+FmenKaMF6HMSLc2WwgI+SitHW3Wv09ySn54V+
         m4IZqpGtI7ZstXPLTPqqtui2BGt/BCuau+sZTRYcX1CO85+1TQncOrFZ+mIayvpijepX
         /HET8ooTslb3hFdJ3kzoo0Hx6ZKi2pqb75sDxaQZez551ZuGU7CJmvcwJ09TDioU/FeK
         mJSA==
X-Gm-Message-State: APjAAAVHJ+9IIOr3TBNyU2oqcUCAa1ULazlXVp1aIczG3jposKdawmeI
        l7kMk72AvGIuPy0QGcsRrs+2kqF1iGnp9HsBFnCbCw==
X-Google-Smtp-Source: APXvYqw0V7RbkbmktaQpSfumtg17YhyQCu7qEWUNBwJ0T4+p8rJy9BSTP/DgctZAWyGcgqZCc+gr206hSrr4alTOGdM=
X-Received: by 2002:a7b:c5d9:: with SMTP id n25mr16348265wmk.8.1575050276155;
 Fri, 29 Nov 2019 09:57:56 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtSeZu8fRzjABXh3wxvBDEajGutAU4LWu0RcJv-6pd+RGQ@mail.gmail.com>
 <a48a6c50-3a03-0420-ad8c-f589fafe6035@libero.it> <CAJCQCtR6zMNKnhL7OZ8ZGCDwPfjC9a1cBOg+wt2VqoJTA_NbCQ@mail.gmail.com>
 <CAJCQCtS2CP75JTT4a6y=rzqVtkMTqTRoCvJK9z3mMwLRfKo9Xw@mail.gmail.com>
 <12f98aaa-14f0-a059-379a-1d1a53375f97@inwind.it> <CAJCQCtQF6xtBDWc+i3FezWZUqGsj8hJrAzYpWG+=huFkmOK==g@mail.gmail.com>
 <69aaf772-9eb0-945a-5277-40895e6901de@inwind.it> <CAJCQCtS6V+f5hq2Cu4r7g9nXB-nRPwUaL+=rh_Ets2mWtHrMcA@mail.gmail.com>
 <35b330e9-6ed7-8a34-7e96-601c19ec635c@inwind.it>
In-Reply-To: <35b330e9-6ed7-8a34-7e96-601c19ec635c@inwind.it>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Fri, 29 Nov 2019 10:57:40 -0700
Message-ID: <CAJCQCtQaq7r2G7Ff--n5g2eVknPtKcQjebj-=eoNjM-18hwhKw@mail.gmail.com>
Subject: Re: GRUB bug with Btrfs multiple devices
To:     Goffredo Baroncelli <kreijack@inwind.it>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 28, 2019 at 2:57 PM Goffredo Baroncelli <kreijack@inwind.it> wrote:
>
> It seems that my supposition is true: the problem exists independently of btrfs.
> It would be useful to see the debug (set debug=all + set pager=1) when doing "ls". It is a not so huge set of information (however it is composed by few pages).

OK I did debug=all on the grub command line instead of in the
grub.cfg, and it's much more manageable.
https://photos.app.goo.gl/75Lbobg39R4D9QUk6

It's a very strange coincidence that these errors only began soon
after the Btrfs volume becomes a two device fs. I forgot to mention
that while grub.cfg is on hfsplus, Fedora GRUB now uses blscfg.mod by
default which goes looking for BLS snippets, which happen to be on
/boot/loader/entries, which is on Btrfs. So even drawing the GRUB menu
does in fact need to read from the 2 device Btrfs.

> Grub sees hd0..hd3 as disks of ~120GB; to be exactly, the size is 125753602048 bytes. The error is reported as unable to access sector 0xea3bfc8, which is locate at 0xea3bf00*512=125753491456 byte, which is less than the previous value...

Looks to me that hd0, hd1, hd2, hd3, hd4 are all phantom devices. hd5
is the SSD, /dev/sda. cd0 is the empty dvd-rom drive.


>
> It seems that  GRUB is correct in complaining. It is trying to access a valid disk location which return an error.
> Why grub is trying to access this location ? My supposition is that grub is trying to probe a filesystem (or a partition type...)
>
> The problem seems to be related to the first 4 disks, which have all the same size and are "phantom" disks...
> May be that the problem is that GRUB incorrectly detects disks ?
> >
> > But without rebooting, just repeating the ls for the same devices, I
> > don't get the error for hd4 again.
> > https://photos.app.goo.gl/M6yraHfgfAsMigaP8
>
> My understanding is that GRUB tried to load some external modules (zfs, ufs2, ...) without success. However this tentative was attempted only the first time. This could explain the fact that the error appeared only one time.

These errors may be misleading because the Fedora grubx64.efi doesn't
contain them, and I've only copied a few GRUB modules from
/usr/lib/grub/x86_64-efi to /boot/efi/EFI/fedora/x86_64-efi

The default installation on Fedora doesn't copy external modules to
the ESP at all, so only the ones already in the grubx64.efi are
available.

-- 
Chris Murphy
