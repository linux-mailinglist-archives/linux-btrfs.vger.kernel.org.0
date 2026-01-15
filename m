Return-Path: <linux-btrfs+bounces-20591-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E66C3D283BD
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Jan 2026 20:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0553C308BA18
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Jan 2026 19:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F31A31ED6B;
	Thu, 15 Jan 2026 19:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DS+bjLH7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EECA31AA81
	for <linux-btrfs@vger.kernel.org>; Thu, 15 Jan 2026 19:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768506358; cv=none; b=UrAr1dV/6Or+WcjdrA9RvNNhYH1UPdHhiBU/r1W51bSwdFIoa7rYm7k2QkC6YwnM2AGPiJSI501zoHssEYOS8WNp82U3CiYX+FTBbCK+Fdp+w+UD34Bc5KjojZ/BWqM8bxEG7GdcJWT4ODTqtH+UIoTEVVkhTyL20044+1yIUhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768506358; c=relaxed/simple;
	bh=X3aQac9rqERQ6QcF2Rotr+Y5XaUOArcdl81/mczTjlU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=fCMozvl69rS6hZ/oO2HdD3fTq0pTPIjwJJxXS/grHjHNesdiAEiH0Ume5Dj73q5ued+iZt5ft0rkb0ilVderhUIQfuO18bXhSxKwXVXAGxyDhd/bYKkrnJ7lSjaeZJXOGGWgogznaaMPIxfTDEdbqAXvtoFDFYsqHcBbWZSwD5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DS+bjLH7; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-50145cede6eso10479531cf.2
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Jan 2026 11:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768506356; x=1769111156; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lBBd8pbvbzjUNeOvUvCpAmPRNU6tyUINXWbg4j9nEZQ=;
        b=DS+bjLH7DDF/ihUwW193Gs2wsnrQeel9sLXPWoM7lcIW6f19KCIsLZOG8DZsLr8Uoz
         BvNgFgI4ZzfVJhhhHsHxBq9pI7geWbKJRh/cERXLevzl6B98MMNlYBeVsm5kOZvIILWP
         FFiDdROshNCqMfBC9/qw4sE1lusW+nw2x08cS4NTqIiN5VW9v6ExwkDNCqD71L2bxh0t
         DOvNpY5et3X9F6tfP5IaVTm21TU6ql6ZuwvqJIDM8QzaQxfgAdzilU1OfEZ/yqISsFUI
         LByFsTAWN30+gk0jUW/U18bFk0dTkUNt6+RxX1SzY7Srqpm8uCUoSOq8fUFnSm8ivmU3
         Nspg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768506356; x=1769111156;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lBBd8pbvbzjUNeOvUvCpAmPRNU6tyUINXWbg4j9nEZQ=;
        b=DY223elkjzMLPTWT5yEyqT58jBOa8DIfYO9TEJHhFD3xIJGLyZC8y0t6QAT5LtkfXa
         YvPRxlC1JMqWiWj3yiiBkSkuJd9r0mQUOb0Omw7Nn4EhW1fEq+MXkav1C56H6drcaG/P
         uUqShcrlvhdhVCbfUSuvosV/oQMXjAeCHSQZmYTK9wI8kbbsUnhexFe+ALfHitMoOak+
         twi3iswwWxA3jWOrGnHdDSkep1Dz6ylqz3KqccWLOswaemdBtAh+OMJVSy4Zn5uSGzlI
         Fcsa89YnRcSiyUYkfHIE52Snwn497JrIKcEXe/ej8nrIt4DxDjox6bfjf8QpNNEh6t1r
         a+0w==
X-Gm-Message-State: AOJu0YxwzXx9rcqwH9GVh19cNjMH1MndwkHywXYjutCtr9vBLOmXZHzG
	tGtaAsQDhFDQp44BB8ldsH17+KPA/gDP1rP+So7MiRBsM+d0pvckpp8PInRwpmN5DnAT6Ait4Mj
	bS0QbaxZJRbOrryXmAt58I4ldZd02ia8jUcAX
X-Gm-Gg: AY/fxX6QkdgcFQIW/j8kvBvvsHXgsMYrqYxUV5fjZiRH3NDYuezxS37QJXdfMJcW2Hl
	61xZWY4BgosuXD7X7fTmHOzAHIGHFmnpImdMK3P/JO46Hjv/6xcUQuV1Y5i6btjq0HI949GscJ1
	5LNVselskq+VIjdZGrj+RPs/ZPFxkvrHKRMaRfiU0uaTmLhNTLocpGVYgn+3rvBFNbRUEXsWiX2
	jsrnHL4CGHijWtMZNwDDF5+OIRJybx33j+3GputZeVIRHxa7c/7WtZG2AgWlOMySvTLXV4JtZqK
	TdX2gHB2UplhIRsrDlsZSp+1lQ==
X-Received: by 2002:ac8:5a10:0:b0:4eb:9eaf:ab4d with SMTP id
 d75a77b69052e-502a1f34829mr6071061cf.62.1768506356097; Thu, 15 Jan 2026
 11:45:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAE8gLhk0Sg2PnPTtFZ1WLb+DJgZHYoukBazEX2qKb-P1QR8HYg@mail.gmail.com>
In-Reply-To: <CAE8gLhk0Sg2PnPTtFZ1WLb+DJgZHYoukBazEX2qKb-P1QR8HYg@mail.gmail.com>
From: MegaBrutal <megabrutal@gmail.com>
Date: Thu, 15 Jan 2026 20:45:00 +0100
X-Gm-Features: AZwV_QgD2fd9MBiO1uabIyLu9z2EFj9kLFy-gWLex7Er6wJdnOzefMm1_XmfXGk
Message-ID: <CAE8gLh=yiBcUE675_AHUe-iTKRgmKbeFp_X75hkNiNKZA8HxnQ@mail.gmail.com>
Subject: Fwd: Damaged filesystem
To: linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hello,

It rarely happens, but seems like I have a damaged BTRFS filesystem
now that I can't even mount because this happens:

# mount -vo ro /dev/vmdata-vg/lxc-container /mnt
mount: /mnt: can't read superblock on /dev/mapper/vmdata--vg-lxc--container.
       dmesg(1) may have more information after failed mount system call.

Jan 15 20:00:00 vmhost kernel: BTRFS: device label Container devid 1
transid 3991863 /dev/mapper/vmdata--vg-lxc--container scanned by mount
(1273180)
Jan 15 20:00:00 vmhost kernel: BTRFS info (device dm-62): first mount
of filesystem 783f5e97-ebe8-424b-aee8-aaec1e3342b2
Jan 15 20:00:00 vmhost kernel: BTRFS info (device dm-62): using crc32c
(crc32c-intel) checksum algorithm
Jan 15 20:00:00 vmhost kernel: BTRFS info (device dm-62): disk space
caching is enabled
Jan 15 20:00:00 vmhost kernel: BTRFS error (device dm-62): level
verify failed on logical 670793728 mirror 1 wanted 1 found 0
Jan 15 20:00:00 vmhost kernel: BTRFS error (device dm-62): level
verify failed on logical 670793728 mirror 2 wanted 1 found 0
Jan 15 20:00:00 vmhost kernel: BTRFS warning (device dm-62): couldn't
read tree root
Jan 15 20:00:00 vmhost kernel: BTRFS error (device dm-62): open_ctree failed

This is what happened to the disk, but strangely much earlier than the
problems actually started to appear:

Jan 06 13:11:18 vmhost kernel: ata3.00: exception Emask 0x10 SAct
0x20000000 SErr 0x4090000 action 0xe frozen
Jan 06 13:11:18 vmhost kernel: ata3.00: irq_stat 0x00400040,
connection status changed
Jan 06 13:11:18 vmhost kernel: ata3: SError: { PHYRdyChg 10B8B DevExch }
Jan 06 13:11:18 vmhost kernel: ata3.00: failed command: READ FPDMA QUEUED
Jan 06 13:11:18 vmhost kernel: ata3.00: cmd
60/80:e8:20:24:a2/00:00:6e:00:00/40 tag 29 ncq dma 65536 in
                                        res
40/00:ff:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error)
Jan 06 13:11:18 vmhost kernel: ata3.00: status: { DRDY }
Jan 06 13:11:18 vmhost kernel: ata3: hard resetting link
Jan 06 13:11:24 vmhost kernel: ata3: link is slow to respond, please
be patient (ready=0)
Jan 06 13:11:28 vmhost kernel: ata3: SATA link up 6.0 Gbps (SStatus
133 SControl 300)
Jan 06 13:11:28 vmhost kernel: ata3.00: ACPI cmd
f5/00:00:00:00:00:00(SECURITY FREEZE LOCK) filtered out
Jan 06 13:11:28 vmhost kernel: ata3.00: ACPI cmd
b1/c1:00:00:00:00:00(DEVICE CONFIGURATION OVERLAY) filtered out
Jan 06 13:11:28 vmhost kernel: ata3.00: ACPI cmd
f5/00:00:00:00:00:00(SECURITY FREEZE LOCK) filtered out
Jan 06 13:11:28 vmhost kernel: ata3.00: ACPI cmd
b1/c1:00:00:00:00:00(DEVICE CONFIGURATION OVERLAY) filtered out
Jan 06 13:11:28 vmhost kernel: ata3.00: configured for UDMA/133
Jan 06 13:11:28 vmhost kernel: sd 2:0:0:0: [sdc] tag#29 FAILED Result:
hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=10s
Jan 06 13:11:28 vmhost kernel: sd 2:0:0:0: [sdc] tag#29 Sense Key :
Illegal Request [current]
Jan 06 13:11:28 vmhost kernel: sd 2:0:0:0: [sdc] tag#29 Add. Sense:
Unaligned write command
Jan 06 13:11:28 vmhost kernel: sd 2:0:0:0: [sdc] tag#29 CDB: Read(16)
88 00 00 00 00 00 6e a2 24 20 00 00 00 80 00 00
Jan 06 13:11:28 vmhost kernel: I/O error, dev sdc, sector 1856119840
op 0x0:(READ) flags 0x80700 phys_seg 16 prio class 0
Jan 06 13:11:28 vmhost kernel: ata3: EH complete

The first error was only logged on Jan 13:

Jan 13 18:12:45 vmhost kernel: BTRFS error (device dm-62): level
verify failed on logical 687194112 mirror 1 wanted 1 found 0

What should be the first thing to try to repair the file system
without the least possible data loss? Unfortunately it's a 1 TB FS,
but most of its data can be redownloaded, so I don't worry too much,
the worst thing is that I possibly need to rebuild the container from
scratch that will take a lot of work. I'm also worried about the ATA
errors, but every time I test the drive, it comes out OK.


Best regards,
MegaBrutal

