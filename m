Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF79B2FF8
	for <lists+linux-btrfs@lfdr.de>; Sun, 15 Sep 2019 14:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbfIOMq2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 15 Sep 2019 08:46:28 -0400
Received: from mail-vs1-f46.google.com ([209.85.217.46]:43208 "EHLO
        mail-vs1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbfIOMq2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 15 Sep 2019 08:46:28 -0400
Received: by mail-vs1-f46.google.com with SMTP id b1so652392vsr.10
        for <linux-btrfs@vger.kernel.org>; Sun, 15 Sep 2019 05:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=kW5OGpTDZKDWQpmSPqdav8AYElfky36XCL6u9/+qwtI=;
        b=A1YOpptLr7FiHXOBtwJJpazlxRqguiPnAXF1SCPTBcoOXGwbWT+7OFglVTEKW++INb
         VLqnFQY56UsvGfY6JRWjBP44xUmT/WpbvBWFN4Hy15TkIgEfcp5AWciIBmNyAjPEmZ2s
         TjsnrPphlMdqL2gRgxnbO1eQrKpYQafC4uWSo9cmI4y6X8JEeWt/argJoqSjf5ugz9kZ
         LujJTBDelQ3Du8Zw+AQnPQvw6HXulBFlnYteD1CC9qkUV4SYOlA3s2EgCwidZAQknH6h
         pd8hk1UFeW2tTsrO3lSwO0W723WC6tNdrUeB9ZGKdZFfd1nU4N1/lRrNxMPJF1zpHQxA
         wc8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=kW5OGpTDZKDWQpmSPqdav8AYElfky36XCL6u9/+qwtI=;
        b=YiDjzFOUQyEgqPh4KABJa0bGEJnMdlunStOqGhWD4uA1tvIq3zLCInaMDSslcBTT18
         lb8aXfUot7E1165CiKkNU5Bg+EjFAiutkDcePrRDhDyF8eu/N8s9vfyLcPzVOnl4KP9o
         phLJebBhy55cOcmdBTCYrzvUjwTMeeLJ7+3yKAu3LIvNFB2yjKxO0POkcAZL1Uv/iXrM
         QMKabAjomiVFQ8aSqY3e3S7vhcFmysLqDnRFT6A1sIU8LZKpcSF27nu5389pICSQzS4V
         IgEuDPtGgpjbr4YNSQ3Qh2gOxkezClMoJHAqREy3J+l4Pt3qGmVfsetMNaZnW5qxqL7S
         B7zQ==
X-Gm-Message-State: APjAAAX60x0T13dkQjtqB2u3KHQ6C5nbAnjy0tn57mpr7EZq7PrC3Jid
        66ZLpZnjghsa3krWhup3k7HS3OjzY0JVQaFIOyskMVdZ
X-Google-Smtp-Source: APXvYqyqag/oFS7CxDwYQbRVTHIiLmBYYHq2VAa6NX6VjuDuBLgd5fFtORRT1YCbCV1TkoAIYKsI6qEIDITKml8gWH0=
X-Received: by 2002:a67:5f45:: with SMTP id t66mr19701693vsb.204.1568551587479;
 Sun, 15 Sep 2019 05:46:27 -0700 (PDT)
MIME-Version: 1.0
From:   James Harvey <jamespharvey20@gmail.com>
Date:   Sun, 15 Sep 2019 08:46:16 -0400
Message-ID: <CA+X5Wn7Rtw4rTqXTG8wrEc883uFV7JpGo-zD8FhhD9gM+_Vpfg@mail.gmail.com>
Subject: WITH regression patch, still btrfs-transacti blocked for... (forever)
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For several weeks, I've had an enormous amount of frustration when
under heavy I/O load with a filesystem putting processes using it into
permanent uninterruptible sleep.  Sometimes the filesystem allows
reads and only locks up writing processes, sometimes it locks up both.

I really, really want this fixed, so will be happy to perform further
diagnostics.

I've ruled out hardware.  I have two identical Xeon/ECC machines that
have been functioning perfectly for years (other amdgpu crashes and a
btrfs encryption kernel crash that Qu patched.)  I can replicate this
on both machines, using completely separate hardware.

I am running into this within QEMU, and originally thought it must be
a virtio issue.  But, I believe I've ruled that out.  Within the VM,
after a filesystem lock condition starts, I have always been able to
dd the entire block device to /dev/null, and I have always been able
to dd part of the block device to /tmp, and re-write it back onto
itself.  Additionally, as a test, I created a new LVM volume, and
within the VM setup LVM and 2 btrfs volumes within it.  When the heavy
I/O volume locked up, I could still properly use the other "dummy"
volume that was (from the VM's perspective) on the same underlying
block device.

I've also had a few VM's under minimal I/O load have BTRFS related
"blocked for" problems for several minutes, then come out of it.

The VM is actually given two LVM partitions, one for the btrfs root
filesystem, and one for the btrfs heavy I/O filesystem.  Its root
filesystem doesn't also start having trouble, so it doesn't lock up
the entire VM.  Since I saw someone else mention this, I'll mention
that no fstrim or dedupe has been involved with me.

I started to report this as a BTRFS issue about 4 days ago, but saw it
had already been reported and a proposed patch was given for a
"serious regression" in the 5.2 kernel.

Because the heavy I/O involves mongodb, and it really doesn't do well
in a crash, and I wasn't sure if there could be any residual
filesystem corruption, I just decided to create a new VM and rebuild
the database from its source material.

Running a custom compiled 5.2.14 WITH Filipe Manana's "fix unwritten
extent buffers and hangs on future writeback attempts" patch, it ran
for about a day under heavy I/O.  And, then, it went into a state
where anything reading or writing goes to uninterruptible sleep.

Here is everything logged near the beginning of the lockup in the VM.
The host has never logged a single thing related to any of these
issues.

Host and VM are up to date Arch Linux, linux 5.2.14 with Filipe's
patch, and QEMU 4.1.0.

The physical drive is a Samsung 970 EVO 1TB NVMe, and a host LVM
partition is given to QEMU.  I've used both virtio-blk and
virtio-scsi.  I don't use QEMU drive caching, because with this drive,
I've found it's faster not to.


View relevant journalctl here: http://ix.io/1VeT


You'll see they're different looking backtraces than without the
patch, so I don't actually know if it's related to the original
regression that several others reported or not.

After that, everything that was reading/writing is hung, and anything
new that tries to do so is also hung.  It doesn't report more "task...
blocked" messages, even for new processes attempting reads/writes.
