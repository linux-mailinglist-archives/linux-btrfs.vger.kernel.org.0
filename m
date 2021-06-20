Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8BF83AE0A9
	for <lists+linux-btrfs@lfdr.de>; Sun, 20 Jun 2021 23:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbhFTVWL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 20 Jun 2021 17:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbhFTVWL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 20 Jun 2021 17:22:11 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8F8C061574
        for <linux-btrfs@vger.kernel.org>; Sun, 20 Jun 2021 14:19:58 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id v20-20020a05600c2154b02901dcefb16af0so1804389wml.5
        for <linux-btrfs@vger.kernel.org>; Sun, 20 Jun 2021 14:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2PgedpuM/1+s92UpjKeMjBkjQzAS4IegM010T4lTVpQ=;
        b=REJosikW1GlRj88o9u40E0Z1N9BGBH6GXM8rjNVrnRvfOurXP60CqOZMIxrBPv/S0o
         TSrLBXFOq8Jid4gUiyjap8vbLTOz3/CRY6KR3KD7YcBfotxZSqBhItTfXbgQ7THgf4x+
         4yziCBgdP650X9SyQGGpsVJYUQzgkNcZOAI4T+xCZZ/gEENnVLXGScHBInHux8pweq7t
         cA0TddTcfqwB0tWfWRG8LWdPVT7Y2BicYCQBOQ2wP3KULE3V4DhYD1qrCkCkib+gxQfF
         IRiWapiAhsdT/1ufQuJ3fnQl18P9uhaOUpt8laqHJZdtWDqAMeLZYni+uxcBYQeiOsjo
         O03A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2PgedpuM/1+s92UpjKeMjBkjQzAS4IegM010T4lTVpQ=;
        b=hkTGoh5vVHmJhwBxH6VjnP7nyGUTrG3j2a0Upspr/20oz/IpCtY62+Sf5QIrpb/lmv
         LIoax4aEG1DQjGgIBAfVTKSw2sn0g4IvxQS2NP/7jC1KZiSZ2SIbuMfVKYjQaGZ79r2E
         9Hnsy+E5mPEc3EWX0HzUQrgj17gEOVuoVB8wiXLmzAzqtiPKKqv6PSXH5nso3cv9tqmD
         cfUM+gn+IOMVnzeq67ruA9alyostEpEEITYYMw3oIx3t6LRqFgH5oZL27bKbmujxN4k2
         sdQiAyC+W74g1+hNLEFzZqIGVgdBGTrQ9btaW0NoR3/ICl3xC1B6AtjDEwoUwnznGpvU
         m9Qg==
X-Gm-Message-State: AOAM533fgxfIu7piGjtktyu/FGi43DwCQZ4MTp3YXMi5E/S7/1SleOcC
        3wVnrLvrd1mKCIQBwCpw5Rfj1G5Avq/n7hDQYtBYdg==
X-Google-Smtp-Source: ABdhPJzzC97crqP1FOB7kvxL0ejFnmM57YUfOCN5NYzyjZnTrfVAwlrCzAllqnKa/fpiqj8UN/HRgQDpzuVSQr/6Oxw=
X-Received: by 2002:a05:600c:1c87:: with SMTP id k7mr680913wms.168.1624223996809;
 Sun, 20 Jun 2021 14:19:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAEEhgEss-SusbDdw1qz-7hB3SbQyWhkYNkVLHdQuE+NhMXe27A@mail.gmail.com>
In-Reply-To: <CAEEhgEss-SusbDdw1qz-7hB3SbQyWhkYNkVLHdQuE+NhMXe27A@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 20 Jun 2021 15:19:40 -0600
Message-ID: <CAJCQCtTHu=ZQ92Y9g9MrUewCSK190dDB0hEa+yxAO7r6aHCzSg@mail.gmail.com>
Subject: Re: Recover from "couldn't read tree root"?
To:     Nathan Dehnel <ncdehnel@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jun 20, 2021 at 2:38 PM Nathan Dehnel <ncdehnel@gmail.com> wrote:
>
> A machine failed to boot, so I tried to mount its root partition from
> systemrescuecd, which failed:
>
> [ 5404.240019] BTRFS info (device bcache3): disk space caching is enabled
> [ 5404.240022] BTRFS info (device bcache3): has skinny extents
> [ 5404.243195] BTRFS error (device bcache3): parent transid verify
> failed on 3004631449600 wanted 1420882 found 1420435
> [ 5404.243279] BTRFS error (device bcache3): parent transid verify
> failed on 3004631449600 wanted 1420882 found 1420435
> [ 5404.243362] BTRFS error (device bcache3): parent transid verify
> failed on 3004631449600 wanted 1420882 found 1420435
> [ 5404.243432] BTRFS error (device bcache3): parent transid verify
> failed on 3004631449600 wanted 1420882 found 1420435
> [ 5404.243435] BTRFS warning (device bcache3): couldn't read tree root
> [ 5404.244114] BTRFS error (device bcache3): open_ctree failed

This is generally bad, and means some lower layer did something wrong,
such as getting write order incorrect, i.e. failing to properly honor
flush/fua. Recovery can be difficult and take a while.
https://btrfs.wiki.kernel.org/index.php/Problem_FAQ#parent_transid_verify_failed

I suggest searching logs since the last time this file system was
working, because the above error is indicating a problem that's
already happened and what we need to know is what happened, if
possible. Something like this:

journalctl --since=-5d -k -o short-monotonic --no-hostname | grep
"Linux version\| ata\|bcache\|Btrfs\|BTRFS\|] hd\| scsi\| sd\| sdhci\|
mmc\| nvme\| usb\| vd"



> btrfs rescue super-recover -v /dev/bcache0 returned this:
>
> parent transid verify failed on 3004631449600 wanted 1420882 found 1420435
> parent transid verify failed on 3004631449600 wanted 1420882 found 1420435
> parent transid verify failed on 3004631449600 wanted 1420882 found 1420435
> parent transid verify failed on 3004631449600 wanted 1420882 found 1420435
> parent transid verify failed on 3004631449600 wanted 1420882 found 1420435
> Ignoring transid failure
> ERROR: could not setup extent tree
> Failed to recover bad superblocks

OK something is really wrong if you're not able to see a single
superblock on any of the bcache devices. Every member device has  3
super blocks, given the sizes you've provided. For there to not be a
single one is a spectacular failure as if the bcache cache device
isn't returning correct information for any of them. So I'm gonna
guess a single shared SSD, which is a single point of failure, and
it's spitting out garbage or zeros. But I'm not even close to a bcache
expert so you might want to ask bcache developers how to figure out
what state bcache is in and whether and how to safely decouple it from
the backing drives so that you can engage in recovery attempts.

If bcache mode is write through, there's a chance the backing drives
have valid btrfs metadata, and it's just that on read the SSD is
returning bogus information.





-- 
Chris Murphy
