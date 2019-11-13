Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4D39FB5D3
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2019 18:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbfKMRA5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Nov 2019 12:00:57 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40532 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727254AbfKMRA5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Nov 2019 12:00:57 -0500
Received: by mail-wm1-f67.google.com with SMTP id f3so2834785wmc.5
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Nov 2019 09:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c8MsDOx+XnNsG9QFCinxJLPBgZ2/bxXvS8asLAnc2bA=;
        b=aIflILkieoF//tBWfejneAI5mdrJjtouv6yObDla3JYmtPEfrEG2HcZYI37XU4wUzs
         Aixy6+pgacpKVzmoIv614/BgjikzB4YuXXQkKWIPjQTjNQwcwtiSr97+ACjKaXQAWrVA
         1U2XkDsqe5mjhubFsT/I3XLcGtkCK8w6Fmwd53SwBUV6DDVOCZ1NHDEkOIHFDc0QXZ25
         1VF2Z3eHzGGXUFlh40+SvrD4+IRDrh6lFJhNNydr3FOBXFUleFOUKfen+BbPzFreqNbm
         Xx6VvGfcBTo7a8QlHL+1vr1/5SZUBGIxnHJnWyNw3c9NjsmdhkML0TKdUbQWlhTkc0hO
         DlPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c8MsDOx+XnNsG9QFCinxJLPBgZ2/bxXvS8asLAnc2bA=;
        b=bc1Fy2L6JyzGZ6WmnZAelmFd3BSIorJioyuEUwy51zBTz/o3ad2CFpvFgwWMW+qayE
         R/qSSE1cyuKf/SL5bohPDuM8vZok+M/6EvRRYXmiDP1HTI4Dgtw6RzPypUcUAO1NLJmZ
         7b7uDrOnsX0mMf3XsFUpU1WPnCakz3knml16nUx/sBwBmt5QoV1HY6YJ5dZy5ImJFnOD
         L9OsnA+cQtC5RK+KlB02aA4gXfjamWGmEGTyuyU0D4bIAx3RjsPtsAOuWr81UeXkKiu5
         Y+tlVmVpXPX3PQk/AjIr0c4wooJ7Td5AwAwPcukZUEQTL2leGwBQc4YCwicwquW2jz/O
         +70Q==
X-Gm-Message-State: APjAAAVa1xmI4pBo2EvO2cT3n+LHHHo+IKtyJ0Wk7FeLBJ8eixl4GOsN
        ye3gtjpBedE/X431WeptzcLES1u7Ci4Lw83u6R7ERg==
X-Google-Smtp-Source: APXvYqzEwMdsyjHyvG7+hJ41l6/MqSuSAcTQ7h1yEDcMxGdt3vxhBFYyMK5tLiNLTJZU7nOQ1+z4MDyxpBQIeK3X3sM=
X-Received: by 2002:a7b:cb4a:: with SMTP id v10mr3536436wmj.106.1573664455972;
 Wed, 13 Nov 2019 09:00:55 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtS1v7waFA=ERafSCSCHmPJVytdFZkJLqNTC3U3Gw3Y7tA@mail.gmail.com>
 <d1874d17-700a-d78d-34be-eec0544c9de2@gmail.com> <CAJCQCtTpLTJdRjD7aNJEYXuMO+E65=GiYpKP3Wy5sgOWYs3Hsw@mail.gmail.com>
 <20191104193454.GD3001@twin.jikos.cz> <CAJCQCtSiDQA4919YDTyQkW7jPkxMds1K32ym=HgO6KHQLzHw+w@mail.gmail.com>
 <d2301902-bd5b-7c5a-0354-a5df21ca8eb3@libero.it>
In-Reply-To: <d2301902-bd5b-7c5a-0354-a5df21ca8eb3@libero.it>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 13 Nov 2019 17:00:20 +0000
Message-ID: <CAJCQCtQm_5L9uvH53O3Qby3Ktwpvsc2_6rUhkBLGeD07RP5a7Q@mail.gmail.com>
Subject: Re: Does GRUB btrfs support log tree?
To:     Goffredo Baroncelli <kreijack@inwind.it>
Cc:     Chris Murphy <lists@colorremedies.com>,
        David Sterba <dsterba@suse.cz>,
        Andrei Borzenkov <arvidjaar@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 12, 2019 at 8:04 PM Goffredo Baroncelli <kreijack@libero.it> wrote:
>
> On 11/11/2019 20.37, Chris Murphy wrote:
> > Anyway, the lack of a generic (file system independent) way to handle
> > this use case is actually a bit concerning.
>
> I think that a more simpler approach would be developing a GRUB fs, where is the kernel to be adapted to the needing of GRUB...
> So we can lowering the requirement...

I do really agree with this. It seems like a neat idea that a
bootloader can just read any file system, but when it cannot have a
true/complete view of the file system state because it just flat out
ignores critical parts of the file system? Egads.


> The GRUB-fs should have the following main requirements:
> - allow the atomicity guarantee
> - allow molti-disk setup
> - allow grub to update some file (grubenv come me as first)
> - it should require a simple implementation (easy to porting to multiple system, which basically means linux, *bsd and solaris ?)
> - the speed should be not important

Plausibly we're most of the way there already, adapting the existing
"BIOS Boot" partition.

>
>
> Anyway GRUB on BTRFS suffers of a big limitation: GRUB can't update the grubenv file; and until GRUB will learn how update a COW filesystem, this limit will be impossible to avoid (*)

Yep. And I've discussed it with XFS and ext4 devs and they're not keen
on anything writing into file system space outside of their (kernel or
user space repair too) code, which is a reasonable concern. XFS
doesn't have inline extents yet, but it's proposed. ext4 does have
inline extents I think but not enabled by default, and I also think it
takes a non-default inode size to support the ~1KiB typical grubenv
file size: but inline extents would be subject to metadata
checksumming, same as on Btrfs. So in effect, there are valid use
cases that are, or may soon become, invalid for grubenv use as
currently implemented, on the most common Linux file systems.

> (*) Even tough implementing the update of a NOCSUM file should be not so difficult...

So far I've seen 1KiB grubenv is pretty much always an inline extent
on Btrfs. Even if flagged nocow it ends up being subject to leaf
checksum. If GRUB modifies this grubenv, now that whole leaf is
invalid which could mean data loss for things not even related to the
grubenv, depending on what else is in the leaf.

I mean, GRUB is very cool in many ways, but it's so complicated that
maintaining it all I think is a real challenge and concern. And then
on top of that, the various distributions actively fork it into their
own mutually incompatible flavors. It's like GRUB is a set of LEGOs
and everyone can really optionally build their own whatever.

-- 
Chris Murphy
