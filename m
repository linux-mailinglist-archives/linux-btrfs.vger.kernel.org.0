Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07ACA14444
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 May 2019 07:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725813AbfEFFkl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 May 2019 01:40:41 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39350 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbfEFFkl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 May 2019 01:40:41 -0400
Received: by mail-lf1-f67.google.com with SMTP id z124so2055533lfd.6
        for <linux-btrfs@vger.kernel.org>; Sun, 05 May 2019 22:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8B/t0cxp1AND99JdhFwysNmQTFoQOnCTbpMHYY5G5Mw=;
        b=qsWO2JqEDVrjmlmnR4wjPrAeYUy6iuUxUbSpQ7VtNz2rBkldSbiUWbgqLpx8Ww1iwv
         LZq/04PYejRCh+uzUxQnX4A9o3EV65M/JnTTRNse2KOxB9EFoNAPhqu4csPFT9Kq9WWZ
         LMdkxoaTsocoihA7KEU7gvpwCDO0WgfBIVx4J/cGsVTJhoufCuKO0hTdLTcJPqcFT2vm
         HGgL75EvfZu82Cy/vL0xvKfdiOAyLLdfWW6I6/uj1mtXM8Z+uiWZGf6wBOgPynrT9Ep7
         Cz6+zveu1p/UJ6y8CFefBl6PEe/qk7q4yzZLPPtqbxO3I7wByILTmr0QkTqdrARgJjfT
         p3OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8B/t0cxp1AND99JdhFwysNmQTFoQOnCTbpMHYY5G5Mw=;
        b=kZq69PlK8hfQG6Chq2aOdHRWB4J4ewx1kvrMPstDpyqO+sw7qK4OWw6QyWX/cVSvd4
         r32xQyeKYpBr7xbmceDgwkk0uRFBH4mjpr56hYqwBW4W+fxwTLU/kkCK2TjJYCleE6fD
         DAJ7H2elES1P/A0FI8ZWZkR/YYs/qyq4UlU710OaFW6tlt0weOPVjr2+n0R/ZNFfpguk
         2nCJK5bZfq9lvNuQj5ckfyccgs3IIpXdE4AISCRNILECT7tVMoc/6PgZcKj9hDXfaqHT
         K99dHy3Q07FLGuKdZSFpRJght34MPyqi55PdZMGt3tWqJpsEvhVzU69M1DEml8fMF4/+
         kBRw==
X-Gm-Message-State: APjAAAUzsRDmDN3lYW0SDWrbIjIxQidy/uhrh2cj9XQO+/tVaoxRxMZ5
        HUy8JgC2rngl1d71jLc4cKXY9inljjOcCKn3lsfqkQ==
X-Google-Smtp-Source: APXvYqzDWaPuq26EWH3buULt5YEy/8JPTuetE0skIVJHGbXIMcU6kSkXPQpWh3sq+xBUtv/o97vkR4CM8wUPVEF47/g=
X-Received: by 2002:a19:189:: with SMTP id 131mr10010210lfb.74.1557121238947;
 Sun, 05 May 2019 22:40:38 -0700 (PDT)
MIME-Version: 1.0
References: <aeo6MlQ5-4Bg33XbJZWCvdhKuo0Cgca_eNE4xv7rqzCzgvyxG-cobpf8R3bGdh6VT2LLPcXlZu69EyL_rV8K7gRLQ4HtYIyXnWCWb3zR6UM=@fomin.one>
 <596643ce-64f8-121f-3319-676e58d700e7@gmail.com>
In-Reply-To: <596643ce-64f8-121f-3319-676e58d700e7@gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 5 May 2019 23:40:27 -0600
Message-ID: <CAJCQCtTsSRAHR-zwPq6GgmiCjDjE2MV-QekNUdQ2mWMAzVU89A@mail.gmail.com>
Subject: Re: Hibernation into swap file
To:     Andrei Borzenkov <arvidjaar@gmail.com>
Cc:     Maksim Fomin <maxim@fomin.one>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, May 5, 2019 at 3:09 AM Andrei Borzenkov <arvidjaar@gmail.com> wrote=
:
>
> 05.05.2019 10:50, Maksim Fomin =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > Good day.
> >
> > Since 5.0 btrfs supports swap files. Does it support hibernation into
> > a swap file?
> >
> > With kernel version 5.0.10 (archlinux) and btrfs-progs 4.20.2
> > (unlikely to be relevant, but still) when I try to hibernate with
> > systemctl or by directly manipulating '/sys/power/resume' and
> > '/sys/power/resume_offset', the kernel logs:
> >
> > PM: Cannot find swap device, try swapon -a PM: Cannot get swap
> > writer
> >
>
> How exactly do you compute resume_offset? What are exact commands you
> ise to initiate hibernation? systemctl will likely not work anyway as
> systemd is using FIEMAP which returns logical offset of file extents in
> btrfs address space, not physical offset on containing device. You will
> need to jump from extent vaddr to device offset manually.


https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/Docum=
entation/power/swsusp-and-swap-files.txt?h=3Dv5.0.13

This says the  resume_offset=3D is an "offset, in <PAGE_SIZE> units,
from the beginning of the partition which holds the swap file"

Use filefrag (uses FIEMAP) to get the virtual address, multiply by
4KIB to get bytes, and plug that into

btrfs-map-logical -l vaddrbyte <dev>

The physical number returned is also in bytes. Normally to get LBA
you'd divide by 512 (for anything other than a 4Kn drive), but if I
understand the kernel document correctly, it needs to be in x86_64
page size, so divide by 4096 instead.



> > After digging into this issue I suspect that currently btrfs does not
> > support hibernation into swap file (or does it?). Furthermore, I
> > suspect that kernel mechanism of accessing swap file via
> > 'resume_offset' is unreliable in btrfs case because it is more likely
> > (comparing to other fs) to move files across filesystem which
> > invalidates swap file offset, so the whole idea is dubious. So,
> >
> > 1) does btrfs supports hibernation into swap file? 2) is there
> > mechanism to lock swap file?
> >
>
> btrfs performs some checks before allowing file as swap and it also
> implicitly locks it during swap usage. Note that btrfs will disable
> snapshots of subvolume with swapfile.

Yes I think it's probably a best practice to have a "swaps" subvolume
created at the top level of the file system, to make sure contained
swapfiles are separate and immune from snapshotting the top level
subvolume itself. It's also reasonable to set chattr +C on that
subvolume, and files created there will inherit it.


>
> File also must be using single allocation profile. There is no way to
> force allocation profile for individual file I am aware of in case
> filesytem defaults to something else. Also for multi-device btrfs I am
> not aware of any way to force allocation of file on specific physical
> device, and this is required to use file as swap on btrfs. So you are
> likely restricted to single device single data profile.

Yes the man page specifically says it's supported only for single
device volumes.

> Finally you are not allowed to mount any filesystem read-write (or
> replay any pending log/journal) before doing resume. Does btrfs support
> "true" read-only mount, which is guaranteed to not change filesystem
> state in any way?

Resume is done by the kernel just after initramfs is unpacked, well
before the file system is ro mounted. I think it's probably a good
idea to make sure bootloader kernel command line contains the 'ro'
parameter. I don't know if Btrfs ro is guaranteed to change on-disk
metadata, I know logreplay affects the in-memory state of Btrfs but I
don't think it changes on-disk metadata.

But yeah, worth testing and making sure the backups are kept current.


--=20
Chris Murphy
