Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23FD5B3061
	for <lists+linux-btrfs@lfdr.de>; Sun, 15 Sep 2019 15:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfIONzp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 15 Sep 2019 09:55:45 -0400
Received: from mail-vs1-f44.google.com ([209.85.217.44]:33402 "EHLO
        mail-vs1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfIONzp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 15 Sep 2019 09:55:45 -0400
Received: by mail-vs1-f44.google.com with SMTP id p13so2884458vso.0
        for <linux-btrfs@vger.kernel.org>; Sun, 15 Sep 2019 06:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=dQMHEJtv56kBvVgeYICW7ZuD99DcopTcpYFOp2MBC+M=;
        b=mkyKfV4xuVzpQjgaNkK1t2DA4xzlRYXnvO99WeEpnPBVt8bgwOYSUptXXVdB7nuBCu
         jxGXVdr6VTLKunKZIfaUIKxcPjlj4Z4/BiQigQqW/yH7fy1BoMWltq994JQ21d0DMLht
         Z9l8V2LR4J9F8InVCTEEOkonbgkxwTLFMvAgtu3FyBzwC72Rzls9EOVl/rjs7ultzscB
         esJ4sukjLpVzGNIoXyOhtVMmF7ves2LUBrx1nYXLJcHwjvAuDpyamrQ4Bl4/S6Co9G/W
         YXlAcqaLN4UNzTkCmZb20MONJu5gW6Sex2KBx+uYjZBG/Yvn8D/3wMzMlWBC1Y1omdyY
         Fpdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=dQMHEJtv56kBvVgeYICW7ZuD99DcopTcpYFOp2MBC+M=;
        b=tDlxY8G0UVvCTm8oPDTWNaIP61IVj2hTWg6rY+yb0A/2H0LbELcwYRxMW0eMvTT2FS
         TK5bIc7J6H3y4g/boUakczaW0aQ+iGS6GNPbjRs5imcqv6Gyc49eDBOnUUVMIZdDRM0Y
         oDkDaSZEHRVu/CRA3131o1fYhfW9TMYBZrxetbjz/Ffka4h9nPBoOCtkqAR2RoCT3Wxj
         +UuaQqo+b70C00CqKzw5QfVQNyaNFtlz62kBEcnlIpB33RnDYabswccfqFxM7QDxcwj9
         AUXqXKCi0o/w9rwRhKX2iSdsH+xgaiU+So0ZjxX/GtsrmcN1X5t5Nt07AOD/ZCN15MQB
         CUdQ==
X-Gm-Message-State: APjAAAVfOUX4EEX5WCnH2A2RETcmY0melWU+7zyBsdjpzDyxCYSYRm5s
        EVCX545WDXeOOPdlaEppSOjP0J+pmKdXCQc0aAs=
X-Google-Smtp-Source: APXvYqy1yJnOiFF6UCCdJpWFxxkygDpVPdcDeiidXKxdPt6HYpqF+ANUhxm3/5Mkwau7zRw874OMcYfGRpFA0QBrIJU=
X-Received: by 2002:a67:6044:: with SMTP id u65mr31045916vsb.95.1568555744017;
 Sun, 15 Sep 2019 06:55:44 -0700 (PDT)
MIME-Version: 1.0
References: <CA+X5Wn7Rtw4rTqXTG8wrEc883uFV7JpGo-zD8FhhD9gM+_Vpfg@mail.gmail.com>
In-Reply-To: <CA+X5Wn7Rtw4rTqXTG8wrEc883uFV7JpGo-zD8FhhD9gM+_Vpfg@mail.gmail.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Sun, 15 Sep 2019 14:55:32 +0100
Message-ID: <CAL3q7H41BpuVTHOAMOFcVvVsJuc4iR10KKPDVfgEsG=ZEpwmWw@mail.gmail.com>
Subject: Re: WITH regression patch, still btrfs-transacti blocked for... (forever)
To:     James Harvey <jamespharvey20@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Sep 15, 2019 at 1:46 PM James Harvey <jamespharvey20@gmail.com> wro=
te:
>
> For several weeks, I've had an enormous amount of frustration when
> under heavy I/O load with a filesystem putting processes using it into
> permanent uninterruptible sleep.  Sometimes the filesystem allows
> reads and only locks up writing processes, sometimes it locks up both.
>
> I really, really want this fixed, so will be happy to perform further
> diagnostics.
>
> I've ruled out hardware.  I have two identical Xeon/ECC machines that
> have been functioning perfectly for years (other amdgpu crashes and a
> btrfs encryption kernel crash that Qu patched.)  I can replicate this
> on both machines, using completely separate hardware.
>
> I am running into this within QEMU, and originally thought it must be
> a virtio issue.  But, I believe I've ruled that out.  Within the VM,
> after a filesystem lock condition starts, I have always been able to
> dd the entire block device to /dev/null, and I have always been able
> to dd part of the block device to /tmp, and re-write it back onto
> itself.  Additionally, as a test, I created a new LVM volume, and
> within the VM setup LVM and 2 btrfs volumes within it.  When the heavy
> I/O volume locked up, I could still properly use the other "dummy"
> volume that was (from the VM's perspective) on the same underlying
> block device.
>
> I've also had a few VM's under minimal I/O load have BTRFS related
> "blocked for" problems for several minutes, then come out of it.
>
> The VM is actually given two LVM partitions, one for the btrfs root
> filesystem, and one for the btrfs heavy I/O filesystem.  Its root
> filesystem doesn't also start having trouble, so it doesn't lock up
> the entire VM.  Since I saw someone else mention this, I'll mention
> that no fstrim or dedupe has been involved with me.
>
> I started to report this as a BTRFS issue about 4 days ago, but saw it
> had already been reported and a proposed patch was given for a
> "serious regression" in the 5.2 kernel.
>
> Because the heavy I/O involves mongodb, and it really doesn't do well
> in a crash, and I wasn't sure if there could be any residual
> filesystem corruption, I just decided to create a new VM and rebuild
> the database from its source material.
>
> Running a custom compiled 5.2.14 WITH Filipe Manana's "fix unwritten
> extent buffers and hangs on future writeback attempts" patch, it ran
> for about a day under heavy I/O.  And, then, it went into a state
> where anything reading or writing goes to uninterruptible sleep.
>
> Here is everything logged near the beginning of the lockup in the VM.
> The host has never logged a single thing related to any of these
> issues.
>
> Host and VM are up to date Arch Linux, linux 5.2.14 with Filipe's
> patch, and QEMU 4.1.0.
>
> The physical drive is a Samsung 970 EVO 1TB NVMe, and a host LVM
> partition is given to QEMU.  I've used both virtio-blk and
> virtio-scsi.  I don't use QEMU drive caching, because with this drive,
> I've found it's faster not to.
>
>
> View relevant journalctl here: http://ix.io/1VeT
>
>
> You'll see they're different looking backtraces than without the
> patch, so I don't actually know if it's related to the original
> regression that several others reported or not.

It's a different problem.

A fsync task is trying to get an inode that is being freed, while
holding a transaction open, and the vfs waits (at btrfs_iget5() ->
find_inode()) for the inode to be freed before returning.
Another task which is freeing the inode and running eviction is trying
to commit the transaction, but it can't, because the fsync task is
holding the transaction open.
So, there's a deadlock between those two tasks.

All the other tasks are also trying to commit the transaction but
can't because of those 2 tasks that are deadlocking.

So getting an inode while fsync'ing another one turns out to be a bad
idea as it can cause this type of deadlock, which I haven't thought
about when I added that code in commit [1].
The problem goes all way back to kernel 4.10, and commit [1]
introduced this issue, which was meant to fix a performance regression
that could be detected with dbench (it came to my knowledge through
the SUSE performance team at the time).

Commit [2] while fixing a data loss (actually entire file) caused by
fsync after rename scenarios, introduced the performance regression,
but just because before we had
incorrect fsync behaviour that lead to the file/data loss, that is we
were not doing enough work to avoid the file loss. But it was deadlock
safe, since it was simple and
just triggered a transaction commit instead of trying to get and log
other inodes.

That was back in 2016, and a few other commits built on top that just
added a few more "get other inode" operations while fsync'ing a file.
So I'll have to undo the performance optimization and just fallback to
transaction commits whenever that file loss scenario is detected.

I'll send a fix this week for that. Thanks for the report!

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D44f714dae50a2e795d3268a6831762aa6fa54f55
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D56f23fdbb600e6087db7b009775b95ce07cc3195

>
> After that, everything that was reading/writing is hung, and anything
> new that tries to do so is also hung.  It doesn't report more "task...
> blocked" messages, even for new processes attempting reads/writes.



--
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
