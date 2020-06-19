Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0C0C2002AF
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jun 2020 09:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729987AbgFSHZF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Jun 2020 03:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbgFSHZE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Jun 2020 03:25:04 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDBBC06174E
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Jun 2020 00:25:04 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id dr13so9105452ejc.3
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Jun 2020 00:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=j5LhkVcGmehm1TRndO1Pg0uiOGTXtTEY051/oB9bZ9Q=;
        b=W9SG6JwTdZB9AxHWa3Zaz6S1tgbTf2l4YuTwwMZ++MedDhzhp8sEjLaMAdLzp7kU2B
         xY98pDPbg4Cgnps8nwxmX5tWAHWN9vmNjr5aRq1NtvncC3ZZZVMvSOTRDHMYxYPVnPSs
         6zb6mckmlJzRKqrSDKl8dt21M+/sd/DqFL4JwtRFJKUOyYEUlBeM8ZMc+GPWrhxPc5r2
         QGSCHsDvTuAVUp182AetNjsIT6dAjE3eUli7gHRR13kwrVMnU3eo5OiZE650wcmjOc9U
         3mMw/Tg0nSmTDiuSqwdyD5QPOV6goARzl8M1D7ZtKtSphkY1JvJpYKkutPt3isqNmrEQ
         eXLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=j5LhkVcGmehm1TRndO1Pg0uiOGTXtTEY051/oB9bZ9Q=;
        b=qh1IV8Xo8+dC2DoAUucgEFxPfFvq89/osD0cBDy+SF9SgBiTPZ1e1aZDhEk8g/kdjb
         15jw5IIwHKSNfiGl1bX4DSDfa11289jgpStV1qIL8F3VyUYuJYZ1k3nqAmIizak7Bbow
         cx1BrknghIC3nlZBy3/kl4Oq+/3dgGL4GllDC/X3lXiCj7H+gsVda4FZUSJtyZ7LND7W
         mWqLuBU2SA4BQBkJIa3fpi7jOZb7KI0PcohCjq5NXQw0f5EIZkd80YbSglfjUOiE1Sc0
         yI8VChxiKgmwmT5hn4RrylHtLOjAYXSojwSbeLHxBwfMItM2ji/mor2mh++s71xO4djP
         bnUg==
X-Gm-Message-State: AOAM532lOrLxfwItSSQp1aX57XAaFgiy8sjBFtost94Y0/uCh2FAEMqI
        mjwKp+CXVNw76pDZcjGItif8mfWWRLNxv0FziewxQ5ntsdw=
X-Google-Smtp-Source: ABdhPJwBsJxEk4G7Ur2w7LU5oYjcnv0o39SAnHG0cPqUhlA3K9aWqcuBqXFYEgCOH56jCliijwougbNSM4WRyssiPGM=
X-Received: by 2002:a17:906:5496:: with SMTP id r22mr2424900ejo.449.1592551502519;
 Fri, 19 Jun 2020 00:25:02 -0700 (PDT)
MIME-Version: 1.0
From:   Daniel Smedegaard Buus <danielbuus@gmail.com>
Date:   Fri, 19 Jun 2020 09:24:26 +0200
Message-ID: <CAHnuAezOHbwpuVM6=bJRRtORpdHy=rVPFD+jeAQVz3xUTEsUpQ@mail.gmail.com>
Subject: Behavior after encountering bad block
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi :)

I'm on Deepin 20 beta, which is based on Debian.

Linux deepin 5.3.0-3-amd64 #1 SMP deepin 5.3.15-6apricot (2020-04-13)
x86_64 GNU/Linux

btrfs-progs v4.20.1

Label: none  uuid: 01775a38-62bb-4bf2-b6a0-d5af252b3435
Total devices 1 FS bytes used 883.55MiB
devid    1 size 1000.00MiB used 999.00MiB path /dev/loop0

Data, single: total=3D883.00MiB, used=3D882.44MiB
System, DUP: total=3D8.00MiB, used=3D16.00KiB
Metadata, DUP: total=3D50.00MiB, used=3D1.09MiB
GlobalReserve, single: total=3D16.00MiB, used=3D0.00B

I was testing btrfs to see data checksumming behavior when
encountering a rotten area, so I set up a loop device backed by a 1GB
file. I filled it with a compressed file and made it rot with, e.g.,

dd if=3D/dev/zero of=3Dloopie bs=3D1k seek=3D800000 count=3D1

That is, the equivalent of having data on a single block on an actual
hard drive go bad. I did this different places in the loopback file,
with the same result: Reading the file back from btrfs seems possible
before the point at which the bad block of data is encoutered, and
then *most* reads from beyond that point yield IO errors. E.g.:

 daniel@deepin =EE=82=B0 ~ =EE=82=B0 sudo dd of=3D/dev/null if=3D/mnt/file =
bs=3D1M count=3D100
status=3Dprogress conv=3Dsync,noerror
100+0 records in
100+0 records out
104857600 bytes (105 MB, 100 MiB) copied, 0.0150797 s, 7.0 GB/s

daniel@deepin =EE=82=B0 ~ =EE=82=B0 sudo dd of=3D/dev/null if=3D/mnt/file b=
s=3D1M count=3D100
skip=3D700 status=3Dprogress conv=3Dsync,noerror
dd: error reading '/mnt/file': Input/output error
34+0 records in
34+0 records out
 ... snip 39 more errors ...

daniel@deepin =EE=82=B0 ~ =EE=82=B0 sudo dd of=3D/dev/null if=3D/mnt/file b=
s=3D1M count=3D100
skip=3D600 status=3Dprogress conv=3Dsync,noerror
dd: error reading '/mnt/file': Input/output error
66+1 records in
67+0 records out
 ... snip 36 more errors ...

 daniel@deepin =EE=82=B0 ~ =EE=82=B0 sudo dd of=3D/dev/null if=3D/mnt/file =
bs=3D1M count=3D100
skip=3D300 status=3Dprogress conv=3Dsync,noerror
dd: error reading '/mnt/file': Input/output error
26+0 records in
26+0 records out
 ... snip 63 more errors ...

This seems ... well, wrong. Like, in, bug wrong. Surely, a single
block of bad data on a device shouldn't cause btrfs to produce such a
cascade of errors, making so much data inaccessible?

Cheers :)
Daniel
