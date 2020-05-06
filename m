Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 654701C6704
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 May 2020 06:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725869AbgEFEiI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 May 2020 00:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbgEFEiI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 May 2020 00:38:08 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28087C061A0F
        for <linux-btrfs@vger.kernel.org>; Tue,  5 May 2020 21:38:07 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id n207so173146vkf.8
        for <linux-btrfs@vger.kernel.org>; Tue, 05 May 2020 21:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=eLl1Pk8/saeVsDHwG+h1VL5FYUobDYlLCr4kXOCNdU4=;
        b=nXTQOlqCcC9u4gXKuNCRYUVgadnv4kAq0IExlFoRrvtGqeG3oPE6xQxQEBjlqtdm89
         BwSnKDnoux34Mj3jhyw6XarssjAkXD6YAtZvNP5IGp+eu97UE+kAutJapmjqEdwYKEPE
         dAMhrAizjHbvanggMDiR5xwOKydVdWyQRHQAbZzfxEdteR+CFp0NjXJgQJ1GJRdQUu68
         RBUkaQs8V7zA2jrDvkIOD7fDTProA1PPSaE8e8lk5MibdvowOGX3xnYn6/2stGIDZxp/
         16nTFvdzb9NkU/LpUlrGwH3AVTYYDPA1CWrIhJgQr0zkDeQR1e2ZRQS3JxEahf/sIVeE
         H9ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=eLl1Pk8/saeVsDHwG+h1VL5FYUobDYlLCr4kXOCNdU4=;
        b=pHJ7OFiU4EROmQMgnmcQbnxx3WIYBDNuS/2VBrtA6pI8uhObfBNOJkX5T0pTiCVmoD
         dAoy04UF0KEmnCRWM3FNebyAJ1LraWbXVh8Q4oEKbv2qh3A8IEmJqPZhXrFX0fPoZPg9
         oFnwBAf3GCIcJOaT75ucdxi/Fbhbkf8aRobXdWbMxgASbbTct5dIU/Rpma9xinDNdlFW
         jr1llc+9/oYVIqh1JSKb1RuXqty36LRmdrMkzppUTsebf313aB4lnMZzv1wDnfc4UOpq
         Q/wcnyKT8rErO57fnOJe9wLm5VScysQCi7NaHgcIJmeNMU9Ic2ASSIMTLZ92DfGxDvzu
         OuFw==
X-Gm-Message-State: AGi0PubuzY0/zQDsJX8ReaqD95An4qYzH2gI0AYNtQTK4rKT2X+S3U2+
        ESv/wvpmErNBnKSsTTre9JaM9O55uxgnDBKwhWZ8r0fuMJw=
X-Google-Smtp-Source: APiQypLLoF0m4DWgMG+pGSxmkVPKZxC5FZN4NewD2ZLHY+14qBNSpwA1qX31Zyn+5cs/kZh68WWkjdQOnnBS+lK9WI0=
X-Received: by 2002:a1f:2c3:: with SMTP id 186mr5744104vkc.17.1588739885603;
 Tue, 05 May 2020 21:38:05 -0700 (PDT)
MIME-Version: 1.0
References: <CA+M2ft9zjGm7XJw1BUm364AMqGSd3a8QgsvQDCWz317qjP=o8g@mail.gmail.com>
In-Reply-To: <CA+M2ft9zjGm7XJw1BUm364AMqGSd3a8QgsvQDCWz317qjP=o8g@mail.gmail.com>
From:   John Hendy <jw.hendy@gmail.com>
Date:   Tue, 5 May 2020 23:37:53 -0500
Message-ID: <CA+M2ft895gy-zmDsax14pOgK3JmGxj6+1Z_itn3GhaGREBfDKw@mail.gmail.com>
Subject: Re: btrfs root fs started remounting ro
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Greetings,


I'm following up to the below as this just occurred again. I think
there is something odd between btrfs behavior and browsers. Since the
last time, I was able to recover my drive, and have disabled
continuous trim (and have not manually trimmed for that matter).

I've switched to firefox almost exclusively (I can think of a handful
of times using it), but the problem was related chromium cache and the
problem this time was the file:

.cache/mozilla/firefox/tqxxilph.default-release/cache2/entries/D8FD7600C30A=
3A68D18D98B233F9C5DD3F7DDAD0

In this particular instance, I suspended my computer, and resumed to
find it read only. I opened it to reboot into windows, finding I
couldn't save my open file in emacs.

The dmesg is here: https://pastebin.com/B8nUkYzB

The file above was found uncorrectable via btrfs scrub, but after I
manually deleted it the scrub succeeded on the second try with no
errors.

$ btrfs --version
btrfs-progs v5.6

$ uname -a
Linux voltaur 5.6.10-arch1-1 #1 SMP PREEMPT Sat, 02 May 2020 19:11:54
+0000 x86_64 GNU/Linux

I don't know how to reproduce this at all, but it's always been
browser cache related. There are similar issues out there, but no
obvious pattern/solutions.
- https://forum.manjaro.org/t/root-and-home-become-read-only/46944
- https://bbs.archlinux.org/viewtopic.php?id=3D224243

Anything else to check on why this might occur?

Best regards,
John


On Wed, Feb 5, 2020 at 10:01 AM John Hendy <jw.hendy@gmail.com> wrote:
>
> Greetings,
>
> I've had this issue occur twice, once ~1mo ago and once a couple of
> weeks ago. Chromium suddenly quit on me, and when trying to start it
> again, it complained about a lock file in ~. I tried to delete it
> manually and was informed I was on a read-only fs! I ended up biting
> the bullet and re-installing linux due to the number of dead end
> threads and slow response rates on diagnosing these issues, and the
> issue occurred again shortly after.
>
> $ uname -a
> Linux whammy 5.5.1-arch1-1 #1 SMP PREEMPT Sat, 01 Feb 2020 16:38:40
> +0000 x86_64 GNU/Linux
>
> $ btrfs --version
> btrfs-progs v5.4
>
> $ btrfs fi df /mnt/misc/ # full device; normally would be mounting a subv=
ol on /
> Data, single: total=3D114.01GiB, used=3D80.88GiB
> System, single: total=3D32.00MiB, used=3D16.00KiB
> Metadata, single: total=3D2.01GiB, used=3D769.61MiB
> GlobalReserve, single: total=3D140.73MiB, used=3D0.00B
>
> This is a single device, no RAID, not on a VM. HP Zbook 15.
> nvme0n1                                       259:5    0 232.9G  0 disk
> =E2=94=9C=E2=94=80nvme0n1p1                                   259:6    0 =
  512M  0
> part  (/boot/efi)
> =E2=94=9C=E2=94=80nvme0n1p2                                   259:7    0 =
    1G  0 part  (/boot)
> =E2=94=94=E2=94=80nvme0n1p3                                   259:8    0 =
231.4G  0 part (btrfs)
>
> I have the following subvols:
> arch: used for / when booting arch
> jwhendy: used for /home/jwhendy on arch
> vault: shared data between distros on /mnt/vault
> bionic: root when booting ubuntu bionic
>
> nvme0n1p3 is encrypted with dm-crypt/LUKS.
>
> dmesg, smartctl, btrfs check, and btrfs dev stats attached.
>
> If these are of interested, here are reddit threads where I posted the
> issue and was referred here.
> 1) https://www.reddit.com/r/btrfs/comments/ejqhyq/any_hope_of_recovering_=
from_various_errors_root/
> 2)  https://www.reddit.com/r/btrfs/comments/erh0f6/second_time_btrfs_root=
_started_remounting_as_ro/
>
> It has been suggested this is a hardware issue. I've already ordered a
> replacement m2.sata, but for sanity it would be great to know
> definitively this was the case. If anything stands out above that
> could indicate I'm not setup properly re. btrfs, that would also be
> fantastic so I don't repeat the issue!
>
> The only thing I've stumbled on is that I have been mounting with
> rd.luks.options=3Ddiscard and that manually running fstrim is preferred.
>
>
> Many thanks for any input/suggestions,
> John
