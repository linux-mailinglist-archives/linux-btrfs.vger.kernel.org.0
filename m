Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29FCD482A80
	for <lists+linux-btrfs@lfdr.de>; Sun,  2 Jan 2022 08:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbiABHbV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 2 Jan 2022 02:31:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiABHbV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 2 Jan 2022 02:31:21 -0500
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52000C061574
        for <linux-btrfs@vger.kernel.org>; Sat,  1 Jan 2022 23:31:21 -0800 (PST)
Received: by mail-ua1-x930.google.com with SMTP id v12so41243943uar.7
        for <linux-btrfs@vger.kernel.org>; Sat, 01 Jan 2022 23:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aDQQx6ZFFidLWmGfuEHl3RpTCGEba9lXWhi/vvbJV7I=;
        b=DSKClMrkanBlmqs9h4xh3/wOaN3HbRrnbxbZkjGP8iCXKVQbNvIVU5Fq6tjpclt4KD
         9tnbCTD9VmYaIOyFGxBaj/R3NyTLuDq38hgi2i4qHXubTWfVNYqtJMvL0WoEwymAr9U5
         WbRXjoqCPF4uEa0p69sVwk0RS1ufj8l0CRAr0TvKtpyXgyEXorplYIFFJerl0LJ7s7A5
         DgGwuRjWpRR0uIlqj9PmPuOAvl5zckNntA7KMZ7Zz/9aEP2xFlNfS/c14jrmyFPiOL9R
         9VBML0DpUnB4kvEg12bvgj24NfbCyXglIcLjPzzm2UTkyNZPvVeO0Y+FUxDIqVeaRYoT
         KaVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aDQQx6ZFFidLWmGfuEHl3RpTCGEba9lXWhi/vvbJV7I=;
        b=xLQuAHwBkyh3YpAHm6ZsgTZcd6I/ZM8lz7HLoNEB0wIQsK3eJJcrZCdnU2p3DX14ic
         8AYKK2BEqieZsb96+cUtv8GTdaGVvBD5BHm7YdxZkhU3dJhZAagBaqS1xkOSOUHoZEg1
         4wpRNMz84S2Xla9OLN+Lm9Ub7TpeZs0l1+zghMamGAWEWE0VvMsp1y2dx3hQgfaN6nPi
         d0As+32sZQxZUWvZcb/qq4Kn7I0mEtEw8QDhA0mzINqbNK+gN1WB6dxOJAMkuRlHolIq
         F8bhnDTjkY7AXtF2WY59vitKRn26JPDUIF8c/dH4ZZLJoXEnbhkdxhyXwkiAI6mugFW6
         +vHQ==
X-Gm-Message-State: AOAM530Sws6awGGTtsvXIhdA7ARg0sfz3sF3K9VLZL4pUJpUKXsgu9Fa
        zxAq40dynsbgFCMY9qDShvnzqRKrNQvB1ERjAmF+OgVdX0A=
X-Google-Smtp-Source: ABdhPJy7bdBAhEFpA/nzgxQku/JWG6JIKqMlaReOSuhFRjOGCm4mls5IBEOczhHTIJhY7Tdzpo1mvkeh8VfPo91ecoo=
X-Received: by 2002:a67:e10c:: with SMTP id d12mr12020706vsl.20.1641108680360;
 Sat, 01 Jan 2022 23:31:20 -0800 (PST)
MIME-Version: 1.0
References: <c0c6ec8de80b8e10185fe1980377dcc7af8d3200.camel@ericlevy.name>
 <Yc9Wgsint947Tj59@hungrycats.org> <baa90652685a400aa60636f8596e3d28304da1ad.camel@ericlevy.name>
In-Reply-To: <baa90652685a400aa60636f8596e3d28304da1ad.camel@ericlevy.name>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
Date:   Sun, 2 Jan 2022 10:31:09 +0300
Message-ID: <CAA91j0W2z6tnM2UBrC9v84CDyHYEjaffSJacghg6qbAXm5yDfw@mail.gmail.com>
Subject: Re: parent transid verify failed
To:     Eric Levy <contact@ericlevy.name>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jan 2, 2022 at 4:11 AM Eric Levy <contact@ericlevy.name> wrote:
>
> Dec 29 21:01:09 hostname kernel: sd 4:0:0:1: Warning! Received an indication that the LUN assignments on this target have changed. The Linux SCSI layer does not automatical

Message is truncated (please always show full log), but it indicates
that iSCSI target configuration changed. You may need to update your
client to reflect this change.

...
> Dec 30 03:45:09 hostname kernel:  connection1:0: ping timeout of 5 secs expired, recv timeout 5, last rx 4461894664, last ping 4461895936, now 4461897216
> Dec 30 03:45:09 hostname kernel:  connection1:0: detected conn error (1022)
> Dec 30 03:47:10 hostname kernel:  session1: session recovery timed out after 120 secs

Looks like your system does not have access to this device any more.

> Dec 30 03:47:10 hostname kernel: sd 4:0:0:1: rejecting I/O to offline device
> Dec 30 03:47:10 hostname kernel: blk_update_request: I/O error, dev sdc, sector 523542288 op 0x1:(WRITE) flags 0x104000 phys_seg 128 prio class 0
> Dec 30 03:47:10 hostname kernel: blk_update_request: I/O error, dev sdc, sector 523540240 op 0x1:(WRITE) flags 0x100000 phys_seg 128 prio class 0
> Dec 30 03:47:10 hostname kernel: blk_update_request: I/O error, dev sdc, sector 523538192 op 0x1:(WRITE) flags 0x100000 phys_seg 128 prio class 0
> Dec 30 03:47:10 hostname kernel: blk_update_request: I/O error, dev sdc, sector 523537168 op 0x1:(WRITE) flags 0x104000 phys_seg 128 prio class 0
> Dec 30 03:47:10 hostname kernel: BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 1, rd 0, flush 0, corrupt 0, gen 0
> Dec 30 03:47:10 hostname kernel: blk_update_request: I/O error, dev sdc, sector 523541264 op 0x1:(WRITE) flags 0x104000 phys_seg 128 prio class 0
> Dec 30 03:47:10 hostname kernel: blk_update_request: I/O error, dev sdc, sector 523539216 op 0x1:(WRITE) flags 0x104000 phys_seg 128 prio class 0
> Dec 30 03:47:10 hostname kernel: BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 2, rd 0, flush 0, corrupt 0, gen 0
> Dec 30 03:47:10 hostname kernel: blk_update_request: I/O error, dev sdc, sector 523543312 op 0x1:(WRITE) flags 0x100000 phys_seg 1 prio class 0
> Dec 30 03:47:10 hostname kernel: BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 3, rd 0, flush 0, corrupt 0, gen 0
> Dec 30 03:47:10 hostname kernel: blk_update_request: I/O error, dev sdc, sector 523635088 op 0x1:(WRITE) flags 0x800 phys_seg 64 prio class 0
> Dec 30 03:47:10 hostname kernel: BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 4, rd 0, flush 0, corrupt 0, gen 0
> Dec 30 03:47:10 hostname kernel: blk_update_request: I/O error, dev sdc, sector 523543320 op 0x1:(WRITE) flags 0x100000 phys_seg 81 prio class 0
> Dec 30 03:47:10 hostname kernel: BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 5, rd 0, flush 0, corrupt 0, gen 0
> Dec 30 03:47:10 hostname kernel: blk_update_request: I/O error, dev sdc, sector 523543968 op 0x1:(WRITE) flags 0x104000 phys_seg 128 prio class 0
> Dec 30 03:47:10 hostname kernel: BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 6, rd 0, flush 0, corrupt 0, gen 0
> Dec 30 03:47:10 hostname kernel: BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 7, rd 0, flush 0, corrupt 0, gen 0
> Dec 30 03:47:10 hostname kernel: BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 8, rd 0, flush 0, corrupt 0, gen 0
> Dec 30 03:47:10 hostname kernel: BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 9, rd 0, flush 0, corrupt 0, gen 0
> Dec 30 03:47:10 hostname kernel: BTRFS error (device sdc1): bdev /dev/sdc1 errs: wr 10, rd 0, flush 0, corrupt 0, gen 0
> Dec 30 03:47:10 hostname kernel: BTRFS warning (device sdc1): error -5 while searching for dev_stats item for device /dev/sdc1
> Dec 30 03:47:10 hostname kernel: BTRFS warning (device sdc1): Skipping commit of aborted transaction.
> Dec 30 03:47:10 hostname kernel: BTRFS: error (device sdc1) in cleanup_transaction:1975: errno=-5 IO failure
> Dec 30 03:47:10 hostname kernel: BTRFS info (device sdc1): forced readonly
> Dec 30 05:11:10 hostname kernel: BTRFS warning (device sdc1): sdc1 checksum verify failed on 867254272 wanted 0x62c8b548 found 0x982a1375 level 0
> Dec 30 05:11:10 hostname kernel: BTRFS error (device sdc1): parent transid verify failed on 867254272 wanted 9212 found 8675
> Dec 30 05:11:10 hostname kernel: BTRFS warning (device sdc1): csum hole found for disk bytenr range [271567056896, 271567060992)
> Dec 30 05:11:10 hostname kernel: BTRFS error (device sdc1): parent transid verify failed on 867254272 wanted 9212 found 8675
> Dec 30 05:11:10 hostname kernel: BTRFS error (device sdc1): parent transid verify failed on 867254272 wanted 9212 found 8675
>

Those are probably just followup errors.
