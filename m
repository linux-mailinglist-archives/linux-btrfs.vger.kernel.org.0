Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCA09FC160
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2019 09:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbfKNITG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Nov 2019 03:19:06 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33581 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfKNITG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Nov 2019 03:19:06 -0500
Received: by mail-ot1-f67.google.com with SMTP id u13so4152351ote.0
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Nov 2019 00:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wb73C+QUqe3h+xiBLMsz9fIER74MN/gy6SxROK3lnTc=;
        b=Nrx1y0IE5h70Ge9O9C6y9cfd4YPiWOyFXWIGBW1K9LbMc4VKLK5kPZjH2tGnywL8rT
         nNAX578PT/Irv8ZR9nmbgC2xyw3pyjuho8UwYFdUiRuxthuzf87ACMF0MREp4qtp/vPk
         GM6gxz9xC5thQLEhDA4+CMXXjd/EPta6dyw9xD/8qhziLSGLDnf1h5fTjpoHmHbuwy6p
         KIMUnZ3Hgp7vUn+ePQ/oCdBze4S2hLldH6Mq3WsJmZDfM9Wh1FbVPTuowbxeJQr6Zz2m
         zMwkL4l90i1wIRFNaywzN+1b7ZU+HzPJwJBz9I3Xe0CryC6O+VHUerqo2x7NDAHRwMix
         V1zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wb73C+QUqe3h+xiBLMsz9fIER74MN/gy6SxROK3lnTc=;
        b=Ia9FBmJWibvm+GegA/6GOQYE93H6OBfABw3zDwVoUcpNs0bD91iWjjVjdyHkaxjK/h
         zofYagKTForlCki34+nKA8EtEsiXs60gAMu8L8GHAsiONPd2po4heBdmvzhUq02ARJqi
         rpwEz96LHnBKHPDdHCTlhzac8ZlxMP78Ss6AQe8EdlWqKGneAtOfnqvU1ZKsdUmQyKTc
         1vUe6lt7hqZdvWUcdmfCPAxjdhm7yY4u5aFUL8JwocvpoMb0oxUXgxOoT3Oq1v0+ssld
         sZqT3L5/yK3QUSWt6xTU3LuzuHaHJ4ZeEurOwmlkzESwRkAk68e9dKG2VY3E2bhgv+P2
         leUg==
X-Gm-Message-State: APjAAAXbsyK1yODtb6xOjzaZtqOj+JGZAuO1yzL1dpNCqGsOY8/9acJm
        2XuxPvnRDVcfKNeS+yaI4HBGU6pUr6aHK0Ivsfg=
X-Google-Smtp-Source: APXvYqw/teysYa6NAQOIymbrDM/FY7jo9EA6j5im9hxdlbVvwMbqL/VgSNFDLf6ikBz7JVj1JixKaKJd95ymsBvOBvo=
X-Received: by 2002:a9d:68cf:: with SMTP id i15mr6879253oto.14.1573719545216;
 Thu, 14 Nov 2019 00:19:05 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtS1v7waFA=ERafSCSCHmPJVytdFZkJLqNTC3U3Gw3Y7tA@mail.gmail.com>
 <d1874d17-700a-d78d-34be-eec0544c9de2@gmail.com> <CAJCQCtTpLTJdRjD7aNJEYXuMO+E65=GiYpKP3Wy5sgOWYs3Hsw@mail.gmail.com>
 <20191104193454.GD3001@twin.jikos.cz> <CAJCQCtSiDQA4919YDTyQkW7jPkxMds1K32ym=HgO6KHQLzHw+w@mail.gmail.com>
 <d2301902-bd5b-7c5a-0354-a5df21ca8eb3@libero.it> <CAJCQCtQm_5L9uvH53O3Qby3Ktwpvsc2_6rUhkBLGeD07RP5a7Q@mail.gmail.com>
 <4480d47f-1b1e-d99d-e480-b31220433340@inwind.it> <CAJCQCtTeYNvU-FueRKW6tnkNaRDDCAAUUCb5ZitA2VT+PR+K-A@mail.gmail.com>
In-Reply-To: <CAJCQCtTeYNvU-FueRKW6tnkNaRDDCAAUUCb5ZitA2VT+PR+K-A@mail.gmail.com>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
Date:   Thu, 14 Nov 2019 11:18:53 +0300
Message-ID: <CAA91j0WMinT4YP3oSZaPLc_aLHjL2ODXz=QQd6NynphvRJ2hBw@mail.gmail.com>
Subject: Re: Does GRUB btrfs support log tree?
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Goffredo Baroncelli <kreijack@inwind.it>,
        David Sterba <dsterba@suse.cz>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 14, 2019 at 12:50 AM Chris Murphy <lists@colorremedies.com> wrote:
>
> On Wed, Nov 13, 2019 at 6:54 PM Goffredo Baroncelli <kreijack@inwind.it> wrote:
> >
> > On 13/11/2019 18.00, Chris Murphy wrote:
> > >> The GRUB-fs should have the following main requirements:
> > >> - allow the atomicity guarantee
> > >> - allow molti-disk setup
> > >> - allow grub to update some file (grubenv come me as first)
> > >> - it should require a simple implementation (easy to porting to multiple system, which basically means linux, *bsd and solaris ?)
> > >> - the speed should be not important
> > > Plausibly we're most of the way there already, adapting the existing
> > > "BIOS Boot" partition.
> > >
> > Unfortunately the BIOS Boot partition (which means basically FAT), doesn't have support for "atomicity" nor multidisk..
>
> It's definitely not FAT. It's a blob of space owned by the bootloader.
> No file system at all. As far as I know only the BIOS variant of GRUB
> uses it.

And only on GPT.

> But GRUB does have a way of detecting core.img on it, and

No. GRUB does not "detect" core.img at all. On Legacy BIOS stage0 code
in MBR includes hardcoded absolute disk location of core.img (as list
of extents). Stage0 does not care whether this location is post-MBR
gap, BIOS boot partition or file inside another file system, it simply
loads absolute disk blocks and jumps to loaded code.

> avoids overwriting it by preferring to write in free space within that
> partition, ostensibly to support multiple instances of GRUB (multiple
> distributions),

Sorry? What are you talking about? grub itself (code executed at boot
time) does not write anything anywhere except very limited support for
environment block. grub-install simply writes either to post-MBR gap
or to BIOS Boot partition; it has absolutely no way to reliably detect
presence of "another" core.img there. BIOS Boot partition does not
have any metadata at all.

> and some degree of atomicity as the core.img is
> written first to this partition before the boot.img or "jump code" is
> written in the first 440 bytes of the MBR.
>

core.img must match block list recorded in MBR; as soon as core.img is
overwritten in-place you cannot guarantee that whatever stage0 will
read matches what has been written if stage0 update was aborted for
whatever reasons.

> Obviously this is BIOS specific, which is also x86 specific. So it
> needs to grow to be more arch and firmware agnostic. But it's so
> simple it might actually be more practical than alternatives like a
> new file system or building a transactional based FAT.
>
> I'm sorta annoyed with the UEFI spec using FAT, having not solved the
> problem of atomic updating of the EFI System partition. But we could
> agree to only use the EFI System partition for the sole purpose of the
> firmware loading an EFI file system driver, immediately allowing the
> firmware to read/write to a more reliable file system.
>

This is outside of scope of EFI, really. GRUB consists of two parts -
kernel (which is implicitly embedded in core.img/core.efi) and
loadable modules. They must match. So to ensure atomic update on any
architecture one has to

1. Write new core.img.
2. Write new /boot/grub/$platform content (new modules).
3. Switch boot information to use new version.

On EFI this would simple mean to write grubx64.efi with different name
or location on ESP and then update EFI boot variable to point to it.
Like

\EFI\vendor\image1\grubx64.efi
\EFI\vendor\image2\grubx64.efi

If you want make it alternate between two independent ESP for
additional redundancy.

/boot/grub/$platform is more involved, as a lot of code in grub2
assumes location is always under /boot/grub ($prefix more precisely).
SUSE had to introduce concept of "mounting" subvolumes on btrfs as
quick hack to overcome it.

On Legacy BIOS having two copy of core.img even more involved as it
likely really needs some primitive filesystem to manage multiple
copies.

> www.datalight.com/assets/files/secure/resources/Where%20Does%20FAT%20Fail%202016.pdf
> https://elinux.org/images/5/54/Elc2011_munegowda.pdf
>
> Those PDFs are kind interesting.
>
