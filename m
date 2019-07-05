Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17CC260349
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2019 11:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbfGEJm2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Jul 2019 05:42:28 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44922 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbfGEJm2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Jul 2019 05:42:28 -0400
Received: by mail-ot1-f68.google.com with SMTP id b7so8428576otl.11
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Jul 2019 02:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p9HYj+KKtDPvgu3tkaF8s77To8zcurEd+sii4mPg76Y=;
        b=rceVG8xJO6K/stzrRRR3P4uaFdCburRqWQEl+msVw4nI1xhdZOxdNcMYJ2i2m7/mF6
         Vkf16HjEb9zrzBhUzVcIgaw96giz8p1gA6pkyy0qRv4o8wbRvI46EKoY703zPn0cgBeL
         76R3BgWVlWUotzQhjQfBjw4HPzWKYtx5+RHiLn4KiLV/PSyC4O91ogpSl2iWyH7VDePz
         NeumjdhumpBmh11uPBP+RpeN7uK/FxmjUlLs2BFDjcvaCdGLu7EzUiPte7WBMArwisLI
         3pK+SnmaVkxf9ZWe8ePvXX6KfARBWSUv8AC36z71bxprZXbf36t18/GduqJo87NgYqPa
         Qu2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p9HYj+KKtDPvgu3tkaF8s77To8zcurEd+sii4mPg76Y=;
        b=gzCHI/SUv8bidSOlHi6aU2JMz/poEDiXI3RQduObwr9NiXK3fPCH/GcZZUYBRpiODc
         8L0nBj2wne8E8HPO5ukKFpa43tK9ITsYHQO5ppmGyUGsGpP3JHyrGKkSNEW2QACsldyT
         O7qE9S6VH/0kOX5YgA/H010FqzamQxqfkdeEbZXfWuUuMSrTnpuJ8b9EKR+SHmshqSk2
         Vx9YIAdkHMgWdnpCADUJClhAzNmYD/xDTAZclZ6+8iK9gEZjfKSvo12TbWqn622AlxD0
         cbSsemnpgSGXPXaCrfhzveqGwHh38xXaGcZ6bVk9cWtHrvdgHMFDku9CQEE39Ub/H1FS
         TNtA==
X-Gm-Message-State: APjAAAVioSnTrxKLZLvP0qoHwXjj08/rjZdKPITgR4O+rdoQeuSlXnjh
        or2c7DtilJCv0sA8vMHW0/u0yijhBdrOTikPzDvn8bUr
X-Google-Smtp-Source: APXvYqw9PufdhrnErKk5p97bUbuplNm7d/OXF5XizJqE89hk3Gq4qDGpoojwbhIu6/uUp7pW9OPRMrN+Z5CBTPAXRd4=
X-Received: by 2002:a9d:4c8:: with SMTP id 66mr2082762otm.214.1562319747667;
 Fri, 05 Jul 2019 02:42:27 -0700 (PDT)
MIME-Version: 1.0
References: <966f5562-1993-2a4f-0d6d-5cea69d6e1c6@gmail.com>
In-Reply-To: <966f5562-1993-2a4f-0d6d-5cea69d6e1c6@gmail.com>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
Date:   Fri, 5 Jul 2019 12:42:16 +0300
Message-ID: <CAA91j0W+UhJ2O+K1SJs3JaOfzkCnRhWgGjfFxXju5_sUsCj18A@mail.gmail.com>
Subject: Re: "kernel BUG" and segmentation fault with "device delete"
To:     Vladimir Panteleev <thecybershadow@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 5, 2019 at 7:45 AM Vladimir Panteleev
<thecybershadow@gmail.com> wrote:
>
> Hi,
>
> I'm trying to convert a data=RAID10,metadata=RAID1 (4 disks) array to
> RAID1 (2 disks). The array was less than half full, and I disconnected
> two parity drives,

btrfs does not have dedicated parity drives; it is quite possible that
some chunks had their mirror pieces on these two drives, meaning you
effectively induced data loss. You had to perform "btrfs device
delete" *first*, then disconnect unused drive after this process has
completed.

I suspect at this point the only possibility to salvage data is "btrfs restore".

> leaving two that contained one copy of all data.
>
> After stubbing out btrfs_check_rw_degradable (because btrfs currently
> can't realize when it has all drives needed for RAID10), I've
> successfully mounted rw+degraded, balance-converted all RAID10 data to
> RAID1, and then btrfs-device-delete-d one of the missing drives. It
> fails at deleting the second.
>
> The process reached a point where the last missing device shows as
> containing 20 GB of RAID1 metadata. At this point, attempting to delete
> the device causes the operation to shortly fail with "No space left",
> followed by a "kernel BUG at fs/btrfs/relocation.c:2499!", and the
> "btrfs device delete" command to crash with a segmentation fault.
>
> Here is the information about the filesystem:
>
> https://dump.thecybershadow.net/55d558b4d0a59643e24c6b4ee9019dca/04%3A28%3A23-upload.txt
>
> And here is the dmesg output (with enospc_debug):
>
> https://dump.thecybershadow.net/9d3811b85d078908141a30886df8894c/04%3A28%3A53-upload.txt
>
> Attempting to unmount the filesystem causes another warning:
>
> https://dump.thecybershadow.net/6d6f2353cd07cd8464ece7e4df90816e/04%3A30%3A30-upload.txt
>
> The umount command then hangs indefinitely.
>
> Linux 5.1.15-arch1-1-ARCH, btrfs-progs v5.1.1
>
> --
> Best regards,
>   Vladimir
