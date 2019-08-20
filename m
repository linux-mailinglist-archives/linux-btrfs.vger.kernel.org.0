Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C58896ABD
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Aug 2019 22:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730092AbfHTUiC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Aug 2019 16:38:02 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:36477 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729156AbfHTUiC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Aug 2019 16:38:02 -0400
Received: by mail-wr1-f49.google.com with SMTP id r3so13756322wrt.3
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Aug 2019 13:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VcLFoCyl+vpoc3ONbc8hMvvCDtqFo00ZZqwgrsA3mr4=;
        b=UdO1Dl6eaxuILQbQRkZw7OzqQmzyPMPUVix21DdSRRNFZxBgQQly536fPTqLmDAw8d
         5+Zxs5Xvsk1wzIvi9j36/TlLAa2qqY+PkZRd6B4XTgi6/CtzrtiImPj8YoXCG1zJVuJ/
         I9Bk5BZs53mFPJ1o/fhy+DrbeZoM9IUnKqmLmYpm3CSJTFtV0unITaOlrG5RGyV38cRx
         /8dauwF+luW28X9hivrpGVsR39Sveu7MobXXHvrcXoLjoPC7IejnU4H0KbTCs/jiIVPm
         iWAVRq1ZpjDY26iu3oppRvGMdZSWt6xGPGlPg8LlEcQ+7Cdw8BG6NEgb7jBXCqyW1vqN
         sWfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VcLFoCyl+vpoc3ONbc8hMvvCDtqFo00ZZqwgrsA3mr4=;
        b=oVsGXMniDth7iTmx83eh3Bdxfl2D2uGcb32gOUFlinowIOQHcg2/7+ndHm+dV0yTKl
         kM5yqMAbsgVk2yW7WaAPmSw12B6HUEIRGAVq/Ib9Sejdfw+oNmsCnX5AQeLldGksY2r0
         /3j5JYcNfY+++ieYAg9r5xk+YghKDtARTQ+KeIV7S7OF0Lf4/tEv8xLDvRVzoVqJ4bfL
         Xm0aWfyAnju0Hoh4fZrEvqQ1zSa4qswbZ7rHK+AIDcU6KXfcZ47WKL89LuLfqWVcSXvl
         ZzqiuKvrrYGvzqwWdjlAaTSsuwUg6PTDT+zbJoc3kXM0oX0ZvpTnopIOu+/ZrqDzrY6D
         ZXTQ==
X-Gm-Message-State: APjAAAUMZt3VXtnr7wRS4HRU+pRM2S+bmtDDUBugbbY91k/KkZZvQAFM
        fbvzDcL/yaMx6p5YD23ZADsYEJCXksc9OWSBgWtTca6EZlY3vQ==
X-Google-Smtp-Source: APXvYqwSLiIAnfKpgXafRwD74YyxDsKxwHkXkKrI9KNT/jpKv2pxZMMrS+axVZyYGFc4nn82zIQPV6XGAM/I3p9fVWU=
X-Received: by 2002:a5d:4403:: with SMTP id z3mr25405263wrq.29.1566333480412;
 Tue, 20 Aug 2019 13:38:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAP-b2nNHVnfDyC2-F2pWtwUgjZxcqfwqYvNcBmknd5ZHauWoUw@mail.gmail.com>
In-Reply-To: <CAP-b2nNHVnfDyC2-F2pWtwUgjZxcqfwqYvNcBmknd5ZHauWoUw@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 20 Aug 2019 14:37:49 -0600
Message-ID: <CAJCQCtQDs00bs=L_W39XhdJm5iRZPP1F_NrFhn3F3JLNR8g_wQ@mail.gmail.com>
Subject: Re: BTRFS unable to mount after one failed disk in RAID 1
To:     Daniel Clarke <dan@e-dan.co.uk>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 20, 2019 at 1:42 PM Daniel Clarke <dan@e-dan.co.uk> wrote:

> ~$ btrfs check --init-extent-tree /dev/sdc1
> warning, device 2 is missing
> Checking filesystem on /dev/sdc1
> UUID: 70a651ab-4837-4891-9099-a6c8a52aa40f
> Creating a new extent tree
> bytenr mismatch, want=3D1058577645568, have=3D0
> Error reading tree block
> error pinning down used bytes
> ERROR: attempt to start transaction over already running one
> extent buffer leak: start 1768503115776 len 16384


This very likely has made the problem much worse and will prevent data
recovery, especially given the old version of btrfs-progs you were
using. This option is explicitly listed in the man page as a dangerous
option, *and* it comes with a note:

               Do not use unless you know what you=E2=80=99re doing.

That you used this option without first trying to use 'degraded' mount
option (or at least you didn't say you tried it), suggests you don't
know what you're doing.

Otherwise, had you not used this option I'd have suggested the following:

> ~$ mount -t btrfs -o ro,usebackuproot,compress=3Dzstd /dev/sdc1 /mnt/main=
disk
> mount: /mnt/maindisk: wrong fs type, bad option, bad superblock on
> /dev/sdc1, missing codepage or helper program, or other error.

I would use mount -o ro,degraded, check the kernel messages, see if
this mounts and your latest files are intact, make a backup of
important files while you have the chance. If this does not mount then
try:

mount -o ro,degraded,norecovery   ##same as nologreplay

>~$ btrfs --version
>btrfs-progs v4.15.1

Before proceeding further I recommend newer btrfs-progs, that's old
enough I'm not totally certain of the 'btrfs replace' status - it's
probably fine, I just can't vouch for it because a lot of bugs have
been fixed since this version. You didn't mention kernel but since
you're using zstd it must be 4.14 or newer, and that should be safe to
proceed, but I'll recommend 5.1.20+, or the newest long term kernel
you can use.

Next,

mount -o degraded
## or if already ro mounted
mount -o remount,rw,degraded

Choose one:

##replacement device is same size or bigger than the failed drive
btrfs replace start
btrfs fi resize X:max

##replacement device is smaller than the failed drive
brtfs dev add
btrfs dev rem missing

Of course you need to read the man page and ensure you specify the
correct devices to add and remove (the failed device can be referred
to as "missing" without quotes) and proper mount points. Using replace
is faster than dev add + dev rem, but filesystem resize is not
included. Where btrfs dev add + dev rem will resize the file system
(twice actually).

It should be safe to just immediately mount degraded and start one of
the replacement processes, while you do your backup refresh. But I'm
very conservative and tend to start with an ro,degraded mount, that
way if there are problems I have made very few changes to the file
system and I also have decent backups.

--=20
Chris Murphy
