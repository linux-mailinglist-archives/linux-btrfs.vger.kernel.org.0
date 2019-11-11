Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51CAFF7FAD
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2019 20:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbfKKTTq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Nov 2019 14:19:46 -0500
Received: from mail-wm1-f42.google.com ([209.85.128.42]:54579 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbfKKTTq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Nov 2019 14:19:46 -0500
Received: by mail-wm1-f42.google.com with SMTP id z26so498611wmi.4
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Nov 2019 11:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mcDlNHadEEtoWQVNqJB53gyk0Nf1IwiAS/+pS7cblY4=;
        b=gbDV+6UNdfq6CysxTxl0bTMAK03M5D5N4mse+XE5vR6XmUtR1QuHX8bHc4WUaIFgGt
         07sLgrTSBsWzyQN7YRPvq6SW+Jys5hJABnJTorhf+GyruRV75rEW74fWYiqygaL2Snaz
         nm4/eDRB0cknrMpaBmeIFXtasBVtBLGp4sRQ5saorp5DfV0UeDLVE6tCMhUBXWhA29FA
         KpAF6Z60DPd7D1R22112SOkhCCviLn3CWwIY3TfqJmgAaEd0OZOus8aEAUkLFYU4wyOh
         5vei8TAw1mHk3cSFU3aQqHRMEGguoFdkFqg5CWIHZBox58iiHtqQrhYMnAGf0SL1nWdJ
         yMYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mcDlNHadEEtoWQVNqJB53gyk0Nf1IwiAS/+pS7cblY4=;
        b=ccTr4qv08obD4AHBzyvGkQkAep+nL0Xolrls/4kcv3XfccWrhuxE71cR3w/c7JPAL3
         jk8H6NF4OoEN9nVYir0/cKg4sFgquTYaQi6T9gBXhlEzlhUY9E6xZzct2Sh20oDil6j5
         MurB5KnqCBKeldnwiiwBUgi/ziPMQ8qxz6UnZHBxFU71jMa+R849qFaxPkdLM4anKQzx
         HiljTsgiVwnD6wyBuATePbYW1XVI3mHw5nOETBoJC2gPUVuQvchUB4aFP3XJvgi0Y0Vm
         fK0aJp3HGocSsKCD7qnlsSclZscTD0L6gcgOH4w+EEX0xMlNCT34hSG80O/2YSo5QGRy
         6LLg==
X-Gm-Message-State: APjAAAUADnnADAHQz+mWArgL+X9VtR55+8cQrDktshbWCk/kaLBVCrjK
        QFekRcCYer3i4VRaHduNdPwWfiKMpqHRyouczO+FXg==
X-Google-Smtp-Source: APXvYqwFQq/p+1g6y/sL2U31oi9BfpTjSsbyVniBUGHWXXVK3qxT67y5u0X/V8UUnW0BGTN+FpBKcuLweXWCyMKdQJ0=
X-Received: by 2002:a1c:3b05:: with SMTP id i5mr548279wma.8.1573499984196;
 Mon, 11 Nov 2019 11:19:44 -0800 (PST)
MIME-Version: 1.0
References: <trinity-9b5e3549-dd52-48e7-98f1-9f8bfd1a358a-1573440280042@3c-app-mailcom-bs04>
In-Reply-To: <trinity-9b5e3549-dd52-48e7-98f1-9f8bfd1a358a-1573440280042@3c-app-mailcom-bs04>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 11 Nov 2019 19:19:10 +0000
Message-ID: <CAJCQCtToDnDCpTrERudijavs2Vho2-hgeipHEJG90=D_53DXvQ@mail.gmail.com>
Subject: Re: dd does it again!
To:     Paul Monsour <boulos@gmx.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 11, 2019 at 2:44 AM Paul Monsour <boulos@gmx.com> wrote:
>
> parted -l produced:
>
> Model: ATA ST3000DM008-2DM1 (scsi)
> Disk /dev/sdc: 3001GB
> Sector size (logical/physical): 512B/4096B
> Partition Table: gpt
> Disk Flags:
> Number  Start   End     Size    File system  Name  Flags
>  1      1049kB  3001GB  3001GB  btrfs        Home
>
> Model: ATA ST3000DM008-2DM1 (scsi)
> Disk /dev/sdd: 3001GB
> Sector size (logical/physical): 512B/4096B
> Partition Table: msdos
> Disk Flags:
> Number  Start  End     Size    Type     File system  Flags
>  2      119kB  1593kB  1475kB  primary               esp
>
> The portion of the dd command that wrecked the files was "of=/dev/sdd1"

OK? According to the parted output, there is a single partition number
2, therefore only /dev/sdd2 should exist and the dd command should
have failed. So... something is missing in the information provided,
or maybe a typo somewhere.



>
> btrfs restore produced just:
>
> drwxr-xr-x 1 root root   0 Nov 10 12:43 ftp
> drwxr-xr-x 1 root root 362 Nov 10 12:51 palsor
>
> However, I was (perhaps optimistically) heartened by what "btrfs-find-root /dev/sdc1" produced:
>
> # btrfs-find-root /dev/sdc1
> warning, device 2 is missing
> Superblock thinks the generation is 322292
> Superblock thinks the level is 1
> Found tree root at 649710272512 gen 322292 level 1
>
> How do I use this information? Is there reason to be optimistic?

No. The best possible case is data raid0, and metadata raid1, in which
case the file system will mount with "degraded" option and you'll be
able to recover any files that are completely on the intact device,
and not subject to any striping. Otherwise they will be considered by
Btrfs to be corrupt/missing, although I'm not sure if it results in
EIO or something else. If metadata is also raid0, then the file system
won't mount. You probably also won't have much success with btrfs
restore either.


-- 
Chris Murphy
