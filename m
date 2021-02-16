Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B87131D190
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Feb 2021 21:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbhBPUa1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Feb 2021 15:30:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhBPUaY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Feb 2021 15:30:24 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73CD7C06174A
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Feb 2021 12:29:44 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id x19so11742114ybe.0
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Feb 2021 12:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2I/5z9x5YHpje3jY/9spDnvf+ahGHyhjEvw4gjC5fi4=;
        b=gDZomU34z1KaB09pAw7xp3mCTEBJgxVS+CXjlWfIehj66MmO3uPtF0DVzP805p4kpl
         B2rkg75fN3ZMcHXZvGez8s8lIcVyaJ1udXch2DqDDiTiMLf+c9B0ogCOpznn8qCf+BgT
         ngqK9vzi3jZ+IKo3Ey7a0aiccgU3wHE3LSvpjLyAyX22k95cNlhjezmT1sx7mhbUJkwC
         KI01hG9+2nri8iXLBxMXkh/TsO+KfbtdclQlpd1jAupy3kIR7XcFNjYy//KQJh9UaWAS
         Ur3byUu26rDwJez+Iphjz9jZTKabLVz8p31a4qwcDlN3k6VuzKQOa06YyARsy+E2V8Nf
         nqOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2I/5z9x5YHpje3jY/9spDnvf+ahGHyhjEvw4gjC5fi4=;
        b=YW8AM2EXYh9hLnUyYHYeLz+2tbtETpuavTVJWNq993y7YDrdU5EhzEm4AP5fwPplox
         lWXPaetU5Ax91iX/e41qcuC4iVOF1pf6zbS3p+BJL5O6Y3XnSF8CUFPc/pFjm43NPmIG
         0gEiXEp72zrcrMicsv0SfUmHKqXYnKRBxqHpzIY1jMCdLyHHxC5PEtpxXiz9LmmCfzuU
         Doe0AcVrfErwNb+ltykb4GcHMRz3L26u0c7bMZO/pEG0TSfjyV5Ga02NfuR70VRN3BdU
         ePK8CBsNEWOULiKDRWQnZ/yu4vwMXzdc1eimVzsdVgM2L5xi2S3oXNvzK3xPXmkfbbHY
         WKoA==
X-Gm-Message-State: AOAM530g1xlMzUbgV44LH29PsE3/G1kP7LIjXsvn0DM6V2vhZF7B5cPh
        GQQgP820A65lq/qJzUC0WU2Jhb4TXhBP0f3KrPpcgJo+Gm/24g==
X-Google-Smtp-Source: ABdhPJy5vM+1SqGuKAOyL1PABUOzrS9MRrFY0CPKOjfR0YPXZfxEBa99O2ooGQZRzHvegDLlexzECXYwo1BKBjj3IrY=
X-Received: by 2002:a25:4f41:: with SMTP id d62mr31999280ybb.354.1613507383763;
 Tue, 16 Feb 2021 12:29:43 -0800 (PST)
MIME-Version: 1.0
References: <CAEg-Je-DJW3saYKA2OBLwgyLU6j0JOF7NzXzECi0HJ5hft_5=A@mail.gmail.com>
 <0c4701b2-23ef-fd7a-d198-258b49eedea8@toxicpanda.com> <CAEg-Je9NGV0Mvhw7v8CwcyAZ9zd9T5Fmk2iQyZ1PFWVUOXaP+Q@mail.gmail.com>
 <90da9117-6b02-3c27-17a0-ff497eb04496@toxicpanda.com>
In-Reply-To: <90da9117-6b02-3c27-17a0-ff497eb04496@toxicpanda.com>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Tue, 16 Feb 2021 15:29:07 -0500
Message-ID: <CAEg-Je-zRWrkKOQM-Y_Y17eHhUrJe+d1_H9iLzQB4w7T+Een=w@mail.gmail.com>
Subject: Re: Recovering Btrfs from a freak failure of the disk controller
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 16, 2021 at 1:11 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> On 2/16/21 11:27 AM, Neal Gompa wrote:
> > On Tue, Feb 16, 2021 at 10:19 AM Josef Bacik <josef@toxicpanda.com> wro=
te:
> >>
> >> On 2/14/21 3:25 PM, Neal Gompa wrote:
> >>> Hey all,
> >>>
> >>> So one of my main computers recently had a disk controller failure
> >>> that caused my machine to freeze. After rebooting, Btrfs refuses to
> >>> mount. I tried to do a mount and the following errors show up in the
> >>> journal:
> >>>
> >>>> Feb 14 15:20:49 localhost-live kernel: BTRFS info (device sda3): dis=
k space caching is enabled
> >>>> Feb 14 15:20:49 localhost-live kernel: BTRFS info (device sda3): has=
 skinny extents
> >>>> Feb 14 15:20:49 localhost-live kernel: BTRFS critical (device sda3):=
 corrupt leaf: root=3D401 block=3D796082176 slot=3D15 ino=3D203657, invalid=
 inode transid: has 888896 expect [0, 888895]
> >>>> Feb 14 15:20:49 localhost-live kernel: BTRFS error (device sda3): bl=
ock=3D796082176 read time tree block corruption detected
> >>>> Feb 14 15:20:49 localhost-live kernel: BTRFS critical (device sda3):=
 corrupt leaf: root=3D401 block=3D796082176 slot=3D15 ino=3D203657, invalid=
 inode transid: has 888896 expect [0, 888895]
> >>>> Feb 14 15:20:49 localhost-live kernel: BTRFS error (device sda3): bl=
ock=3D796082176 read time tree block corruption detected
> >>>> Feb 14 15:20:49 localhost-live kernel: BTRFS warning (device sda3): =
couldn't read tree root
> >>>> Feb 14 15:20:49 localhost-live kernel: BTRFS error (device sda3): op=
en_ctree failed
> >>>
> >>> I've tried to do -o recovery,ro mount and get the same issue. I can't
> >>> seem to find any reasonably good information on how to do recovery in
> >>> this scenario, even to just recover enough to copy data off.
> >>>
> >>> I'm on Fedora 33, the system was on Linux kernel version 5.9.16 and
> >>> the Fedora 33 live ISO I'm using has Linux kernel version 5.10.14. I'=
m
> >>> using btrfs-progs v5.10.
> >>>
> >>> Can anyone help?
> >>
> >> Can you try
> >>
> >> btrfs check --clear-space-cache v1 /dev/whatever
> >>
> >> That should fix the inode generation thing so it's sane, and then the =
tree
> >> checker will allow the fs to be read, hopefully.  If not we can work o=
ut some
> >> other magic.  Thanks,
> >>
> >> Josef
> >
> > I got the same error as I did with btrfs-check --readonly...
> >
>
> Oh lovely, what does btrfs check --readonly --backup do?
>

No dice...

# btrfs check --readonly --backup /dev/sda3
> Opening filesystem to check...
> parent transid verify failed on 791281664 wanted 888893 found 888895
> parent transid verify failed on 791281664 wanted 888893 found 888895
> parent transid verify failed on 791281664 wanted 888893 found 888895
> Ignoring transid failure
> ERROR: could not setup extent tree
> ERROR: cannot open file system





--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
