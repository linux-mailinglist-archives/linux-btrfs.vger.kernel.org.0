Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8F21C2544
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 May 2020 14:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbgEBM0Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 2 May 2020 08:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727113AbgEBM0P (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 2 May 2020 08:26:15 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63926C061A0C
        for <linux-btrfs@vger.kernel.org>; Sat,  2 May 2020 05:26:14 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id c2so7422901iow.7
        for <linux-btrfs@vger.kernel.org>; Sat, 02 May 2020 05:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=pc3Z3DJnXe7VMYDsknhzKbMvipgG1+s+OAS9a4sSSEw=;
        b=tD9EMMbUhGJcyb/J5SWiDGZKXENvLgLU1ASQFgpF63AW38yNYnQD66uu9Wg3hLJnfG
         i0Yc6bzgerrrStQlhwhS1VSGNjHa1R7QAnY+xKBK3cNv1llNBjYJO7ztD/TM2XsqY3TY
         rmXB/qRmfgDd3CJ2qRkB3FsEjWK8lIoVRh9OSvHv3X/kz8Czenw/XOKII1jMveX1L9PZ
         JKcgPi/J/q/O8AJy1uJNOBODko/4bRQ07ohhS9eoCgKAbklRqQIq7aCyaHpEZZrbwuoh
         ln7LaXnc1KtmrDcnTiqCPzC/W/1Or8667n3SQzl01HfPDCF2ly/i76GXfWoE1OKavZwP
         9evA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=pc3Z3DJnXe7VMYDsknhzKbMvipgG1+s+OAS9a4sSSEw=;
        b=bme5dmbENKPEYtV8oqJ8bDHXs74oiYZdo59+ZQ6MtEZk3HgjqZnDDtKTrxbh0p0MKC
         M6zbw/gUjrfY4lA4MI5wwRUputsYIvWkGhMVKQfgYl4ElntIRoSWr8lCdKb3N1CM9y9K
         EYZ1s5ZoZsYQ3YRXFxO/qXHRSpHrNRogVqrBTO9Epb7CSQqJjNSfgAX8HgkMUq02mqZ9
         4Z1/zzDjK2fd1jydTYxnjFxriGU8esIfcZC47Xyq4Up9rO0NgxT5oCRYKrST5q2N0IfT
         BKtXzbPcMOm3G/OrJX4SGMU0H2wVgOYhk0NFL9xEBcDqUBwe9kqjL+cWmMLk6oSGZxO5
         fGbA==
X-Gm-Message-State: AGi0PuY+kDd4pTSz43C3z7WgT3v1wXc1JDq81varoVtVjWyXFV/9wwOF
        +CH2JNMVB+FgyiIn+jTLvhwrB2C6nwJ6cZyUUGnxSXFwLhA=
X-Google-Smtp-Source: APiQypJYTIonNm6ZQa68+cBR5ya1swV2lxyxsku0EsD9D0yQEkMjBd33vePNHw77EW61LnXXLj+mBkVMUFoymOiTVnc=
X-Received: by 2002:a6b:f911:: with SMTP id j17mr5361701iog.139.1588422373383;
 Sat, 02 May 2020 05:26:13 -0700 (PDT)
MIME-Version: 1.0
From:   Torstein Eide <torsteine@gmail.com>
Date:   Sat, 2 May 2020 14:26:03 +0200
Message-ID: <CAL5DHTE7HtboVpxx1irAHwkAz9FnjW6mRw27bdG1H1RczwJEdA@mail.gmail.com>
Subject: Re: Western Digital Red's SMR and btrfs?
To:     rrauenza@gmail.com
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I recommend to read this paper:
https://www.toshiba.co.jp/tech/review/en/01_02/pdf/a08.pdf
https://www.servethehome.com/surreptitiously-swapping-smr-into-hard-drives-must-end/

I think it very bad that WD did not declare that the disk is a SMR.

The SMR code that is written expect the drive to inform the host about
it status.  The host manage SMR and Host aware SMR.
The type WD red uses is Disk managed SMR, and our machines are unaware
of it SMR usage.

As far as I understand the problem that have been described by others,
it is not the SMR its self that is the problem.
The problem is that a user expect to be able to do random writes, like
normal like the old WD red drives. But as the action of rebuild a raid
is a sequential operation, when pared other writes is becomes random
writes.

So my understanding is that maybe SMR can be okay for setup with cache
or setups with huge downtime, for the system to be able to rebuild
without user writes. I am still looking for documentation to verify
what is the break point, on how much other writes are acceptable
during a rebuild before the linux kernel/FS will mark it as a bad
drive.

according to this test:
https://www.youtube.com/watch?v=JDYEG4X_LCg
WD red with SMR have better sequential read/write, during raid build,
for a empty raid.

according to this test:
https://www.youtube.com/watch?v=0PhvXPVH-qE
WD red with SMR have slightly slower sequential read/write, during
raid build, for a empty raid.

So what can BTRFS do.
I think this is something that primeratly needs to handle at kernel
level not filesystem level.
Where one solution can be to temperatury slow the write speed to that
manuel disk to have writes below disk rated level.
A other solution can be to stop rebuild if writes fall below a level,
for a some duration to allow the disk to move some of the data in
media cache area over SMR area.
But primarily there need to be a way to mark a DM-SMR disk with a
"This is a SMR disk " similar to host managed and host aware SMR, so
the kernel and/or filesystem can do something with it.

-- 
Torstein Eide
Torsteine@gmail.com
