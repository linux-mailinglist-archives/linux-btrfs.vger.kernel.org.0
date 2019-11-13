Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DDC4FBB1A
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2019 22:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfKMVur (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Nov 2019 16:50:47 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45595 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfKMVuq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Nov 2019 16:50:46 -0500
Received: by mail-wr1-f67.google.com with SMTP id z10so4112452wrs.12
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Nov 2019 13:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nyooZT8wtbNRMz61o0FZGBCnOr8yYqM/0EJg1xrF8Ak=;
        b=cpMqQPvW7sh/MEFOhW1O7gcGzlN/APKWYBloPwyPKQPlZixE6al/OptOA0zp5yzlKr
         V0ZQxNBXvEwnDubZAW2PZGBwG5hKjRqcifFN8z38tjoZ9FvaR/FAIQpEZBkCQSt/pX8A
         bqD+7LZSyp/eKggZLIgZjEiwMWiILFiv1JKB2Ih/4ajA/aVVMK21na+QhzDR2MPQEHP2
         gBXi/k8NMIvv/KDpO3EjVlghgC9/viNYVdL7Jx0TfGbCk2GJvjoD0wvy7Qunk/Ab4bVO
         xzl/ZYYlQMm3AoGk2vP3rdjeZlQbgb0A2ZWRRNUgc5+YMXkRaLiqn3kMxx7rCjRxsCoA
         0Rcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nyooZT8wtbNRMz61o0FZGBCnOr8yYqM/0EJg1xrF8Ak=;
        b=nds+zA8DJ0NUO5SMniVcSRqATzyg+h4Booqs/rboi24OkGUdba3YwvcMpVrG6bq9fy
         GIZYmpCeq8DbE0/HIGrRW8MUNZe17rErYFW4h5RwXX3Av/fk/RjZktvpOrvW7v85f0Rk
         520y4uj9cYiBGwMYoBImyU0enXRKi1paOWzm8GqA4ShM5q6aSBQM9lLDS2QAtVitl0uM
         IjQiqWm1bjaFT8LqeOsqFL5cj+h0NCURN7c/M3gvXYvS/Guckc9pL426iFVV1xC7YR64
         yN69tMZAI1gB1fnpPyv7RWWYDh2f5ObXR4dgQE/sijEa9CLBEjkGV44fWXxq/MDNUn2b
         uJkw==
X-Gm-Message-State: APjAAAW/88KIrmqofg4SvCyepUIXzuGfQyb39XERmAKYgwDkPquVpJAG
        v6Ystxy3Ht/u2eZyQyuiu2eIrJiA+jFPlm04hGbCWL1cY6VHc6iW
X-Google-Smtp-Source: APXvYqy5kx53qe4W9bAt2sFRcw9TmFvuy6dFaRk6dLKIq70CgVlVIKpN0pBDmHaH/c6XX8kcwJtxLI5Iqpn8yH8WUMg=
X-Received: by 2002:adf:f607:: with SMTP id t7mr4918076wrp.390.1573681844539;
 Wed, 13 Nov 2019 13:50:44 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtS1v7waFA=ERafSCSCHmPJVytdFZkJLqNTC3U3Gw3Y7tA@mail.gmail.com>
 <d1874d17-700a-d78d-34be-eec0544c9de2@gmail.com> <CAJCQCtTpLTJdRjD7aNJEYXuMO+E65=GiYpKP3Wy5sgOWYs3Hsw@mail.gmail.com>
 <20191104193454.GD3001@twin.jikos.cz> <CAJCQCtSiDQA4919YDTyQkW7jPkxMds1K32ym=HgO6KHQLzHw+w@mail.gmail.com>
 <d2301902-bd5b-7c5a-0354-a5df21ca8eb3@libero.it> <CAJCQCtQm_5L9uvH53O3Qby3Ktwpvsc2_6rUhkBLGeD07RP5a7Q@mail.gmail.com>
 <4480d47f-1b1e-d99d-e480-b31220433340@inwind.it>
In-Reply-To: <4480d47f-1b1e-d99d-e480-b31220433340@inwind.it>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 13 Nov 2019 21:50:08 +0000
Message-ID: <CAJCQCtTeYNvU-FueRKW6tnkNaRDDCAAUUCb5ZitA2VT+PR+K-A@mail.gmail.com>
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

On Wed, Nov 13, 2019 at 6:54 PM Goffredo Baroncelli <kreijack@inwind.it> wrote:
>
> On 13/11/2019 18.00, Chris Murphy wrote:
> >> The GRUB-fs should have the following main requirements:
> >> - allow the atomicity guarantee
> >> - allow molti-disk setup
> >> - allow grub to update some file (grubenv come me as first)
> >> - it should require a simple implementation (easy to porting to multiple system, which basically means linux, *bsd and solaris ?)
> >> - the speed should be not important
> > Plausibly we're most of the way there already, adapting the existing
> > "BIOS Boot" partition.
> >
> Unfortunately the BIOS Boot partition (which means basically FAT), doesn't have support for "atomicity" nor multidisk..

It's definitely not FAT. It's a blob of space owned by the bootloader.
No file system at all. As far as I know only the BIOS variant of GRUB
uses it. But GRUB does have a way of detecting core.img on it, and
avoids overwriting it by preferring to write in free space within that
partition, ostensibly to support multiple instances of GRUB (multiple
distributions), and some degree of atomicity as the core.img is
written first to this partition before the boot.img or "jump code" is
written in the first 440 bytes of the MBR.

Obviously this is BIOS specific, which is also x86 specific. So it
needs to grow to be more arch and firmware agnostic. But it's so
simple it might actually be more practical than alternatives like a
new file system or building a transactional based FAT.

I'm sorta annoyed with the UEFI spec using FAT, having not solved the
problem of atomic updating of the EFI System partition. But we could
agree to only use the EFI System partition for the sole purpose of the
firmware loading an EFI file system driver, immediately allowing the
firmware to read/write to a more reliable file system.

www.datalight.com/assets/files/secure/resources/Where%20Does%20FAT%20Fail%202016.pdf
https://elinux.org/images/5/54/Elc2011_munegowda.pdf

Those PDFs are kind interesting.




-- 
Chris Murphy
