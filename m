Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAE8637A2B6
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 May 2021 10:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbhEKI5v (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 May 2021 04:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbhEKI5u (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 May 2021 04:57:50 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9546EC061574
        for <linux-btrfs@vger.kernel.org>; Tue, 11 May 2021 01:56:43 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id y12so14043995qtx.11
        for <linux-btrfs@vger.kernel.org>; Tue, 11 May 2021 01:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=pmQO5f1TuPaiGNc1DJcIXKur/6t2oIEFv1LEd2OJb7U=;
        b=PBs1AGLVAaRG8HXHGzsxAjaoLJntPU/uUUkYKnob5DUxwM2rc/Ha9St0Tra5Rei/q0
         V6JCjyp1TKemwz09f81hBHC8DU5Rfq+N6dTxO4KqQscJw7oxNbpA2DI/PhqRvlx77szh
         6ob+DbMLy/JwIFE/uNWF9L6/vI3bS9DWlAkuoC+9TQWfuo1uSM4PccHcgFmiHKvALxYD
         h/DwD9HRgTG31TVij5ApiBsSO2lWVjGQjv52Ho6/lvZPmZ3JEMkziYlkmGwFcKB4Aifb
         Z3uw0IyBLpjlgqrRCPvo2+QK8VQDPcGskMnK0U00L+PCgJ/5s8eell7YQe8si1CMFDfp
         GkeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=pmQO5f1TuPaiGNc1DJcIXKur/6t2oIEFv1LEd2OJb7U=;
        b=X89eWBaxZ4nPdTgh5MGd/380VucoVWO9pqLXE0bAUjsXWwGRGljR+9Cjqrr+StBdk0
         m1yXCxcsLI0dnjSzJLT0FI9jOMU/VOQqf33Mc+7fGpHFbztdWSMfHZoFOckZp4uXp5s9
         RbaCqKRuSOL4ISWVaERDmLIdZJvzlbzS8NU0JAJDUpxuEG5Qv95vQm+Ml1lWnOfGc12T
         XLykD6medYg9Xj4lb34HUR+m+xz1LeQSrx5JLgtjP1qNL7W23KsaobrZqJJ0DtNptbn5
         W2l8qAVanCJl0nM0deF7Wi0wrTd5wSTX6wWzZaUUGTOdw2PDaZoHI4Gro4ZhwzwofRQE
         RmHw==
X-Gm-Message-State: AOAM532/tSy0J8uwY+akpdnq4YogKkwUusFR0rDN2/ZGfJZ7b+yYwgI0
        67CH51C04ayQ3sPQJgzHJ5S8HGTcJEjjRsy+Vu6NnLLRHv4=
X-Google-Smtp-Source: ABdhPJwyGvecsyp7EQW6Wi3mHaVbX6FUwcI1WTH6vZSItQYwm3RK+Wu+6LeJKV4nH9WbZ6ekx2/W2x9Szs3w8nTuors=
X-Received: by 2002:ac8:d03:: with SMTP id q3mr26997995qti.183.1620723402880;
 Tue, 11 May 2021 01:56:42 -0700 (PDT)
MIME-Version: 1.0
References: <93c4600e-5263-5cba-adf0-6f47526e7561@in.tum.de>
In-Reply-To: <93c4600e-5263-5cba-adf0-6f47526e7561@in.tum.de>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Tue, 11 May 2021 09:56:31 +0100
Message-ID: <CAL3q7H7mFmNhhCUTeYG_56gsz1p2G_sN=1GuPBjdbB=sC-EQyw@mail.gmail.com>
Subject: Re: Leaf corruption due to csum range
To:     Philipp Fent <fent@in.tum.de>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 10, 2021 at 10:01 PM Philipp Fent <fent@in.tum.de> wrote:
>
> I encountered a btrfs error on my system. I run Microsoft SQL Server in
> a docker container on a btrfs filesystem on an SSD. When bulk-loading
> some benchmark data, my system reproducibly enters in the following
> failing state:
>
> [  366.665714] BTRFS critical (device sda): corrupt leaf:
> root=3D18446744073709551610 block=3D507544305664 slot=3D0, csum end range
> (308900515840) goes beyond the start range (308900384768) of the next
> csum item
> [  366.665723] BTRFS info (device sda): leaf 507544305664 gen 18292
> total ptrs 4 free space 3 owner 18446744073709551610
> [  366.665725]  item 0 key (18446744073709551606 128 308891275264)
> itemoff 7259 itemsize 9024
> [  366.665727]  item 1 key (18446744073709551606 128 308900384768)
> itemoff 7067 itemsize 192
> [  366.665728]  item 2 key (18446744073709551606 128 309036716032)
> itemoff 2587 itemsize 4480
> [  366.665730]  item 3 key (18446744073709551606 128 309041303552)
> itemoff 103 itemsize 2484
> [  366.665731] BTRFS error (device sda): block=3D507544305664 write time
> tree block corruption detected
> [  366.665821] BTRFS: error (device sda) in btrfs_sync_log:3136:
> errno=3D-5 IO failure
> [  366.665824] BTRFS info (device sda): forced readonly
>
> Please note the erroring ranges:
> csum end:   308900515840
> Start next: 308900384768
> which is a difference of (1 << 17) =3D=3D 0b100000000000000000 =3D=3D 128=
KB
> To me, this looks suspiciously like an off-by-one error, but I'm not too
> versed in debugging btrfs.

Most likely it's a race when adding checksums. In this case for the
log tree (fsync).
This has happened in the past and the most recent fix was:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3De289f03ea79bbc6574b78ac25682555423a91cbb

There were cases too that affected the csum tree and not the log tree,
but those are many years old now.

>
> I reproduced this several times on my machine using the attached
> scripts. The only obvious similarity between the crashes is this 128KB
> csum end / start next. Sometimes a get one corrupt leaf, sometimes many.
> I tried to reproduce it on another machine with an HDD, but didn't
> encounter this error there.
> Can you help me to debug this further?

Try to see if there are reflink operations (clone and dedupe) done by
sql server (or maybe docker), in case there aren't, that excludes
shared extents being the cause of the problem.

I'll have to look at the code and think what might go wrong to lead to
that, so I can't say that I have exact steps on how to debug that.

Thanks.

>
> # uname -a
> Linux desk 5.12.2-arch1-1 #1 SMP PREEMPT Fri, 07 May 2021 15:36:06 +0000
> x86_64 GNU/Linux
> # btrfs --version
> btrfs-progs v5.11.1
> # btrfs fi show
> Label: none  uuid: 6733acf5-be40-4fe2-9d6f-819d39e49720
>         Total devices 1 FS bytes used 187.11GiB
>         devid    1 size 931.51GiB used 208.03GiB path /dev/sda
> # btrfs fi df /ssdSpace
> Data, single: total=3D207.00GiB, used=3D186.67GiB
> System, single: total=3D32.00MiB, used=3D48.00KiB
> Metadata, single: total=3D1.00GiB, used=3D450.08MiB
> GlobalReserve, single: total=3D215.41MiB, used=3D0.00B



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
