Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C235E2FB9D9
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Jan 2021 15:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387712AbhASOhb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Jan 2021 09:37:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387429AbhASJ3F (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Jan 2021 04:29:05 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D231AC061573
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Jan 2021 01:28:24 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id m4so18969431wrx.9
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Jan 2021 01:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rkjnsn-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eCNLXStw5RDu0DTNKnoDJaRPnv/wj5VIjUz8eX6PXeY=;
        b=Ri60W7B92jg8uZWruHrWdhPlCNY9na8xBCKNLivZPxvNyYZ2rnGFHa6Lb44YaAhThD
         9OnqjlUaAMsex2Jco1hNhD/HjudsUY/xjsgg9Dcx1KaBpTEpaGKVpTY0An4OiHLjsK7a
         +U6HkseNdiAzf8leJGgH29StWaGzbzCX241PBT0KTnlTC31WFVhtxjAYdPv0kO9kHMt5
         wj5DXZlWgeg4uMFfUliymmzTZrHW9uazXb0fC/yH0+G91yCEQ4xSDDPNcVNNs/S2NLRW
         M7OlVtfKqykw9ww+KYWp4vgQRy1Mvc8/550KJOj2zWrqS8uszW4e1mwFP97wp8SyDffA
         k9SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eCNLXStw5RDu0DTNKnoDJaRPnv/wj5VIjUz8eX6PXeY=;
        b=XLrlWz6KvHAwGTp4vgfBMBiY0dfyEn7Z7zKfPJhPrZ0KhfCr4NOFg6TXgF5X7b+MmU
         GHl7tYzQMQYL2E2iLpaQiPbNxuQeuoTCyZEopOah9M1bAa8ic9XEsVvMqSzBm7zTXKRD
         FiSL5OAuE7XEh4l9+slmBTpnClviCbSSvtUrLlW8ssqhg3SZOltPp2pj9PAhoJDeIm2q
         cpTgGIaW59CMOs6SVZaUgEEkITIPr/ZAzsXFMjrkbYluo/bgcWgSnlLzHle6uDBcj4K0
         xc9NNZxW7yMsfgcUEKeKvWAFZJXiKH4e6vk2QHctKWC8DOI5ojtsuL7tmLzbJ81oNdxi
         kSZQ==
X-Gm-Message-State: AOAM531w8V5D7kLYRVmNjoZSHgQhy1aSqY1leEp6YpuObS5ygPARV3xp
        pHa7Asm9B2HcWK+NKotnJLpSIQM/gWYLs+QYMyCeRQ==
X-Google-Smtp-Source: ABdhPJzOSQ2a2fSLtdrySN5qU2nKdhrSbFqiM3OQogW5yB1uzOFU8QfBR+CL0MtCJeAHmAkpNLX12vBDHHlT1Mmthpo=
X-Received: by 2002:a05:6000:185:: with SMTP id p5mr3313185wrx.403.1611048503547;
 Tue, 19 Jan 2021 01:28:23 -0800 (PST)
MIME-Version: 1.0
References: <CAMj6ewO7PGBoN565WYz_bqL6nGszweNouP-Fphok9+GGpGn8gg@mail.gmail.com>
 <20190521091842.GS1667@carfax.org.uk> <CAMj6ewPKbRA_eT7JYA9ob9Qk9ZROoshOqaJE=4N_X9bPaskLUw@mail.gmail.com>
 <CAMj6ewOHrJVdwfKrgXZxwfwE=eoTaB9MS57zha33yb1_iOLWiw@mail.gmail.com>
 <8aa09a61-aa1c-5dcd-093f-ec096a38a7b5@gmx.com> <CAMj6ewO229vq6=s+T7GhUegwDADv4dzhqPiM0jo10QiKujvytA@mail.gmail.com>
 <684e89f3-666f-6ae6-5aa2-a4db350c1cd4@gmx.com> <CAMj6ewMqXLtrBQgTJuz04v3MBZ0W95fU4pT0jP6kFhuP830TuA@mail.gmail.com>
 <218f6448-c558-2551-e058-8a69caadcb23@gmx.com> <CAMj6ewPR8hVYmUSoNWVk6gZvy-HyKnmtMXexAr2f4VQU_7bbUw@mail.gmail.com>
 <3b2fe3d7-1919-d236-e6bb-483593287cc5@gmx.com> <CAMj6ewNDQFzXsvF5c1=raJc11iMvMKcHH=AbkUkrNeV2e3XGVg@mail.gmail.com>
 <CAMj6ewPiEvXbtHC1auSfRag5QGtYJxwH_Hvoi2t_18uDSxzm8w@mail.gmail.com>
In-Reply-To: <CAMj6ewPiEvXbtHC1auSfRag5QGtYJxwH_Hvoi2t_18uDSxzm8w@mail.gmail.com>
From:   Erik Jensen <erikjensen@rkjnsn.net>
Date:   Tue, 19 Jan 2021 01:28:12 -0800
Message-ID: <CAMj6ewNjSs-_3akOquO1Zry5RBNEPqQWf7ZKjs8JOzTA7ZGZ7w@mail.gmail.com>
Subject: Re: "bad tree block start" when trying to mount on ARM
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Hugo Mills <hugo@carfax.org.uk>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 18, 2021 at 9:22 PM Erik Jensen <erikjensen@rkjnsn.net> wrote:
>
> On Mon, Jan 18, 2021 at 4:12 AM Erik Jensen <erikjensen@rkjnsn.net> wrote=
:
> >
> > The offending system is indeed ARMv7 (specifically a Marvell ARMADA=C2=
=AE
> > 388), but I believe the Broadcom BCM2835 in my Raspberry Pi is
> > actually ARMv6 (with hardware float support).
>
> Using NBD, I have verified that I receive the same error when
> attempting to mount the filesystem on my ARMv6 Raspberry Pi:
> [ 3491.339572] BTRFS info (device dm-4): disk space caching is enabled
> [ 3491.394584] BTRFS info (device dm-4): has skinny extents
> [ 3492.385095] BTRFS error (device dm-4): bad tree block start, want
> 26207780683776 have 3395945502747707095
> [ 3492.514071] BTRFS error (device dm-4): bad tree block start, want
> 26207780683776 have 3395945502747707095
> [ 3492.553599] BTRFS warning (device dm-4): failed to read tree root
> [ 3492.865368] BTRFS error (device dm-4): open_ctree failed
>
> The Raspberry Pi is running Linux 5.4.83.
>

Okay, after some more testing, ARM seems to be irrelevant, and 32-bit
is the key factor. On a whim, I booted up an i686, 5.8.14 kernel in a
VM, attached the drives via NBD, ran cryptsetup, tried to mount, and=E2=80=
=A6
I got the exact same error message.
