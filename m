Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B155932652D
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Feb 2021 17:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbhBZQCe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Feb 2021 11:02:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbhBZQC0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Feb 2021 11:02:26 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DD8C06178A
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Feb 2021 08:01:45 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id g9so8426709ilc.3
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Feb 2021 08:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jNfa2stWkfB0N8ndx7SowUrQU8FcNO0v9HsqYgQLndo=;
        b=ZNGwuRtwni0eit7Cw5Qm+z7nOBiFSxVcpLMyIB8y/UiZca/QhiuTEcbX+45xkRY7RZ
         D3/RHTJVAl+nSua5JaC3I0jWyzwAQ3n/kBj2YK+Eivu6ZaTRmU70GUukf8RAwk0uDIVJ
         ieiojJankhknU6jXGNnBkvxKZ9YJN/lCQGPVhDecZU+nOAsqKw9nuWtQsjWMm1oclcQk
         3xhrQRlRFWlfREeoHu/ZPXfzwf8uiGgClQzdkeWQpYrvShmF33B1sMKf3Qk33ckTPAdx
         iRTCezxUy79b+f3M2EuSCaXoQSkxhrRQZA43q8MZekPmm+rXSX4tJm33X45KBZiJVqZc
         YWZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jNfa2stWkfB0N8ndx7SowUrQU8FcNO0v9HsqYgQLndo=;
        b=B2aWAUa/YDIePbntLX6K/a5VlR0XGpDLFJ/kUAPhBU2yuAzQmR4KWbBPPHdnDZPO5Z
         gmF2MiQrlhcx+8JLuntg4ydby5dqowmoUykbXukd3tD/MnuJDJLwtabjTuE3XY2St6Cb
         vOw3XDdBLsdTPlArgawdMqc8FBMojZ+Ux1ysjy8GN9zGU0/rU8JSMAZZpPmgkzUoIJQ7
         5+g5nc6dAxqbUPgR0I4rrpQT4gb7zYLmE8eiOX9OOzYNAr7KsPIARmkeJIgbz0tm+Cuw
         51ubknUoOVmaDcTqtaTT5NNMP7MzAH62oXrmNpr5Uax8hZhUSBN8FOx3rnvbHsrEsgkN
         +MIA==
X-Gm-Message-State: AOAM531Gow6G5XaoNinZ4FYt1B2tCrrrmHaKDwi4ILjBBl96slS9QUfY
        Ju4nw5Dgo4vZzzzOesaPUc5zjx6mHZlN0cXB6KeDzSGZYJAlcA==
X-Google-Smtp-Source: ABdhPJzgpdCVe012d6kpqtdhzjifC5Q2OTRL+WgTg0igOldPUd4891Uf1PT2yJcbNI0GJIBjL/Ku3okRy5mTo3IimWk=
X-Received: by 2002:a92:4105:: with SMTP id o5mr2930572ila.47.1614355304887;
 Fri, 26 Feb 2021 08:01:44 -0800 (PST)
MIME-Version: 1.0
References: <CALS+qHMo-XVzXKEfd44E6BG7TPnWKT+r2m7p1wFtFs5XjQApEA@mail.gmail.com>
 <CAJCQCtT38_0Uk7_V-EnfJ-qj4dheJnqVcWEZEKvVRsw6tY5VDg@mail.gmail.com> <CAJCQCtRkPa7GSjqOBs95ZsJL04o-FBXhgB6xH5KwP+TgupjCnw@mail.gmail.com>
In-Reply-To: <CAJCQCtRkPa7GSjqOBs95ZsJL04o-FBXhgB6xH5KwP+TgupjCnw@mail.gmail.com>
From:   Sebastian Roller <sebastian.roller@gmail.com>
Date:   Fri, 26 Feb 2021 17:01:08 +0100
Message-ID: <CALS+qHOg89Qtd26NFC4WT+SCv_VxH_k3Erk4=a_pzEMdKZ1Kbw@mail.gmail.com>
Subject: Re: All files are damaged after btrfs restore
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> > I think you best chance is to start out trying to restore from a
> > recent snapshot. As long as the failed controller wasn't writing
> > totally spurious data in random locations, that snapshot should be
> > intact.
>
> i.e. the strategy for this is btrfs restore -r option
>
> That only takes subvolid. You can get a subvolid listing with -l
> option but this doesn't show the subvolume names yet (patch is
> pending)
> https://github.com/kdave/btrfs-progs/issues/289
>
> As an alternative to applying that and building yourself, you can
> approximate it with:
>
> sudo btrfs insp dump-t -t 1 /dev/sda6 | grep -A 1 ROOT_REF
>
> e.g.
>     item 9 key (FS_TREE ROOT_REF 631) itemoff 14799 itemsize 26
>         root ref key dirid 256 sequence 54 name varlog34
>

Using this command I got a complete list of all the snapshots back to
2016 with full name.
I tried to restore from different snapshots and using btrfs restore -t
from some other older roots.
Unfortunately no matter which root I restore from, the files are
always the same. I selected a list of some larger files, namely ppts
and sgmls from one of our own tools, and restored them from different
roots. Then I compared the files by checksums. They are the same from
all roots I could find the files.
The output of btrfs restore gives me some errors for checksums and
deflate, but most of the files are just listed as restored.

Errors look like this:

Restoring /mnt/dumpo/recover/transfer/Hardware_Software/ABAQUS/AWI/AWI_6.14-2_2015.zip
Restoring /mnt/dumpo/recover/transfer/Hardware_Software/ABAQUS/AWI/installInstructions.txt
Done searching /Hardware_Software/ABAQUS/AWI
checksum verify failed on 57937054842880 found 000000B6 wanted 00000000
ERROR: lzo decompress failed: -4
Error copying data for
/mnt/dumpo/recover/transfer/Hardware_Software/ABAQUS/CM/CMA_win86_32_2012.0928.3/setup.exe
Error searching
/mnt/dumpo/recover/transfer/Hardware_Software/ABAQUS/CM/CMA_win86_32_2012.0928.3/setup.exe
ERROR: lzo decompress failed: -4
Error copying data for
/mnt/dumpo/recover/transfer/Hardware_Software/ABAQUS/CM/CMAInstaller.msi
ERROR: lzo decompress failed: -4
Error copying data for
/mnt/dumpo/recover/transfer/Hardware_Software/ABAQUS/CM/setup.exe
Error searching
/mnt/dumpo/recover/transfer/Hardware_Software/ABAQUS/CM/setup.exe

Most of the files are just listed as "Restoring ...". Still they are
severely damaged afterwards. They seem to contain "holes" filled with
0x00 (this is from some rudimentary hexdump examination of the files.)

Any chance to recover/restore from that? Thanks.

Sebastian
