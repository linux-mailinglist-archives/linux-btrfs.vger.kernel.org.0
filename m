Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7795535315F
	for <lists+linux-btrfs@lfdr.de>; Sat,  3 Apr 2021 00:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235256AbhDBW6X (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Apr 2021 18:58:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:55804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231406AbhDBW6X (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 2 Apr 2021 18:58:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9062C61178;
        Fri,  2 Apr 2021 22:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617404301;
        bh=HsdtBwrGpz0B7P4KjYisOOAoz6HCZgFDLQo9wy72rkA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Z5Ak4d/gd1Ng/xKnwv0huBhr2efmjxn+ep6Qvc410A1HavFD8VHejRwCwmXCrfgMk
         CEIP7Ra/6IoDL/P0dh4UR7JAtmS5vFdv8IwkqEoTUdUU3H1OTuJCjfxV9IbhyGYRQ9
         3YCnOvjoB84X1QuEyiZXI2vPtImAM01xQ4239cZBHjq+/VekdJGpptPngPU7xkixMa
         TE2s+YPbej+f+ZvkxGNqMTaUqo9yRULqP/pav8cc+HrO/lVetR6b0RZYXBSKm906E0
         I9OCvKnCJ70Bfa/PdfSrLRb0rmqrnDoWy5lFU+kQSBbHoslyaoYjD3nCeL0SGdMu6m
         Q2GZWZwSnNBSQ==
Received: by mail-qk1-f180.google.com with SMTP id o5so6580100qkb.0;
        Fri, 02 Apr 2021 15:58:21 -0700 (PDT)
X-Gm-Message-State: AOAM5310TjWSIQY27O5j1YDbzXeXEGmh8E6FXEUq60/TYiDP27iiQE/S
        QOTJn+1pokJIRrjGUjMSx/IHklWu97BkrE7sqrg=
X-Google-Smtp-Source: ABdhPJx7mavDQdz3rLzA//s7S7vu8cXSp5EC4aJD+m4tUuyc+1SwRfb18qycIVsyIwCHJU+zofx5g9a24TbsSkkSHrE=
X-Received: by 2002:a05:620a:110a:: with SMTP id o10mr15782650qkk.281.1617404300698;
 Fri, 02 Apr 2021 15:58:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200813163749.GV4332@42.do-not-panic.com> <0b1621bf-fc82-1a56-c11f-c5c46677e59e@tuxforce.de>
 <20200813221348.GB4332@42.do-not-panic.com> <fc887e06-874c-79d8-0607-4e27ae788446@tuxforce.de>
 <20200814163723.GC4332@42.do-not-panic.com> <a79f1a0c-012d-bebe-c9c7-b505f59079c2@tuxforce.de>
 <20200817152056.GD4332@42.do-not-panic.com> <9e5c716e-1736-9890-54be-75739ea5462f@tuxforce.de>
 <20200818143715.GF4332@42.do-not-panic.com> <6b61e549-42b8-8e71-ff57-43b7c5b4291f@tuxforce.de>
 <20210402180253.GS4332@42.do-not-panic.com> <CAB=NE6WVnR197DnH+EgHDoyy98x15D0fVdoGjZcHW9W5P7Jipg@mail.gmail.com>
In-Reply-To: <CAB=NE6WVnR197DnH+EgHDoyy98x15D0fVdoGjZcHW9W5P7Jipg@mail.gmail.com>
From:   Luis Chamberlain <mcgrof@kernel.org>
Date:   Fri, 2 Apr 2021 15:58:08 -0700
X-Gmail-Original-Message-ID: <CAB=NE6X8bXUoTuTxhy-DDqO8ByaFiJqbjzCSmmGwTbbLY95FhA@mail.gmail.com>
Message-ID: <CAB=NE6X8bXUoTuTxhy-DDqO8ByaFiJqbjzCSmmGwTbbLY95FhA@mail.gmail.com>
Subject: Re: Is request_firmware() really safe to call in resume callback when
 /usr/lib/firmware is on btrfs?
To:     Lukas Middendorf <kernel@tuxforce.de>
Cc:     linux-btrfs@vger.kernel.org, Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 2, 2021 at 3:19 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> Lukas, can you share your /etc/fstab ? Also, how long do you stay in
> the boot before you try to suspend?

OK I cannot reproduce the issue with the modified patch I sent to
test_firmware, which if you enable config_enable_resume_test will
trigger a request_firmware() on resume, thus trying to mimic the race
you note. To test this you can simply use a loopback filesystem for
your /lib/firmware and create a btrfs filesystem for it, and then run:

echo 1 > /sys/devices/virtual/misc/test_firmware/config_enable_resume_test

systemctl suspend

Then resume. You should see "resume test" print on dmesg. I keep my
/lib/firmware/ empty and still, nothing. Can you provide kernel logs
for where you are seeing things get stuck at? Note that I had
mentioned the races on suspend/resume do exist for any journaling
filesystem, but this typically happens if you are doing ongoing
writes. I suppose you are *not* doing writes and your filesystem is
idle.

As such without kernel logs I cannot be sure what the issue is, but at
this point after the initial testing I've done I don't suspect this is
a firmware API issue. You might be better off just reposting your
patches with the respective Reviewed-by tags and pestering your
maintainer.

PS. If you want to test this on a guest you bring the guest back up
with virsh dompmwakeup.

  Luis
