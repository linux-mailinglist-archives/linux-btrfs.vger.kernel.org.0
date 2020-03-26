Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B97DB194088
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Mar 2020 14:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbgCZNyF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Mar 2020 09:54:05 -0400
Received: from mail-qk1-f178.google.com ([209.85.222.178]:40135 "EHLO
        mail-qk1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727612AbgCZNyF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Mar 2020 09:54:05 -0400
Received: by mail-qk1-f178.google.com with SMTP id l25so6410225qki.7
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Mar 2020 06:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=wc+XKje0auOusPPz0a7GcIQLQGhOTtijgQ7Lu0ztLys=;
        b=Myq9bnUelFOaWH1EwFp5X9/NLqzJxNuIsG/dQrghhPyUeuPOAHEBtXkMVzM+De8el7
         Z7dO2FjNyP+cYj5bzvvaFiSmrIQEovqvHdSYN0UutuANNjBbpGvQ3U+o8ZFFL9RJrKPb
         g/5vj/1nWMDQarlBNmhJWiLq/OS7QIQoJZUA31gM8PwnxtiITrdYNm0lt1th2yjww26w
         f1MsUrLkFPu56WIuZIVTGXhfjFM0S9bGlUNZ7nnsdVgdrr1EQsKgSMcaExHbcNBWCp8E
         oqz69deKC+zxxlKqp51NV8vUih+r+N1cyVDe7FrhMnaH5TgG65zCxIGomRhDQKKLe47G
         qKug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=wc+XKje0auOusPPz0a7GcIQLQGhOTtijgQ7Lu0ztLys=;
        b=Oe37OYP7L85bVmUCIz70vW66F7nKfp9rrjwM1tZALNhYcSbu6rVH6YBxM8qjh5MLcX
         b3/B2jD1YG9b8MWwlvoU9pOnM3r938bYiQ95WBPFOV/OOOEezMjdee66ZMt6U2eST2Vl
         DNDSQWTcK/GmYvhbDany1RmnPz5qfY8YsKq+BDuzH3E5Cso9G3BRRU61c4weMoBh2ajn
         WeH4uxoHwpFLDX6vs9LEjd12QpENkv+Wco6MLTKyi83NxH9AUtjhTe1TfgJ9LKCIDYzz
         88rZOgjmWNn6rcJfB28wTqSxkFwvivnGdl36QWvLHoXK4PYPpmy2YIGZb6dY9yasuArt
         svDA==
X-Gm-Message-State: ANhLgQ1P4TLjyHKdz+m6LYBeJQKHpEyRNsX8KDY7dWqW91qfw6IM0rok
        ilo+3+blQ40IWM5JO359PjI/iyalKhDrmXFDWpztlTL9l10=
X-Google-Smtp-Source: ADFU+vtnt5/E26VYV/RgvvZ8EqmS3YoJvKrOVRj6Kf2zp17oY2U4aIrSvGoq/WA/ElfnO1xEi+F7sKZ4yKW6xlNcakE=
X-Received: by 2002:a37:4901:: with SMTP id w1mr7230007qka.427.1585230843630;
 Thu, 26 Mar 2020 06:54:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200311204204.GA21905@li61-168.members.linode.com> <20200317002945.GV12659@twin.jikos.cz>
In-Reply-To: <20200317002945.GV12659@twin.jikos.cz>
From:   Andrea Gelmini <andrea.gelmini@gmail.com>
Date:   Thu, 26 Mar 2020 14:53:52 +0100
Message-ID: <CAK-xaQYSEHsxeXRJS9kzTPjzpUaQCYYeYcoKN0VGCTQfbCn=6Q@mail.gmail.com>
Subject: Re: Request about "Page cache invalidation failure on direct I/O."
To:     David Sterba <dsterba@suse.cz>, Andrea Gelmini <gelma@gelma.net>,
        Linux BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Il giorno mar 17 mar 2020 alle ore 01:30 David Sterba
<dsterba@suse.cz> ha scritto:
> without tuning of the rate I can't say if the buffered vs dio happens
> all the time or just once. For the 'once' case I would not be worried.

Thanks a lot David for your interest.

Well, with latest kernel (5.5.13), I still see it, but a lot less than
before (same setup, hardware and
software versions).

After a few hours of work I just got this bouch of warnings (btw, no
boot of virtual machine guest, it was in status saved/suspended).

[gio mar 26 05:22:58 2020] Page cache invalidation failure on direct
I/O.  Possible data corruption due to collision with buffered I/O!
[gio mar 26 05:22:58 2020] File:
/mnt/4TB/piastrelli/home/virtual/VirtualBox
VMs/Zuccotti/Snapshots/{23d5aff0-4514-46b9-ab38-76ae59b3acbf}.vdi P
ID: 25176 Comm: kworker/4:3
[gio mar 26 05:28:41 2020] Page cache invalidation failure on direct
I/O.  Possible data corruption due to collision with buffered I/O!
[gio mar 26 05:28:41 2020] File:
/mnt/4TB/piastrelli/home/virtual/VirtualBox
VMs/Zuccotti/Snapshots/{23d5aff0-4514-46b9-ab38-76ae59b3acbf}.vdi P
ID: 35075 Comm: kworker/4:1
[gio mar 26 05:44:00 2020] Page cache invalidation failure on direct
I/O.  Possible data corruption due to collision with buffered I/O!
[gio mar 26 05:44:00 2020] File:
/mnt/4TB/piastrelli/home/virtual/VirtualBox
VMs/Zuccotti/Snapshots/{23d5aff0-4514-46b9-ab38-76ae59b3acbf}.vdi P
ID: 38801 Comm: kworker/4:4
[gio mar 26 05:54:48 2020] Page cache invalidation failure on direct
I/O.  Possible data corruption due to collision with buffered I/O!
[gio mar 26 05:54:48 2020] File:
/mnt/4TB/piastrelli/home/virtual/VirtualBox
VMs/Zuccotti/Snapshots/{23d5aff0-4514-46b9-ab38-76ae59b3acbf}.vdi P
ID: 44366 Comm: kworker/4:1
[gio mar 26 06:02:43 2020] Page cache invalidation failure on direct
I/O.  Possible data corruption due to collision with buffered I/O!
[gio mar 26 06:02:43 2020] File:
/mnt/4TB/piastrelli/home/virtual/VirtualBox
VMs/Zuccotti/Snapshots/{23d5aff0-4514-46b9-ab38-76ae59b3acbf}.vdi P
ID: 44366 Comm: kworker/4:1
[gio mar 26 06:02:43 2020] Page cache invalidation failure on direct
I/O.  Possible data corruption due to collision with buffered I/O!
[gio mar 26 06:02:43 2020] File:
/mnt/4TB/piastrelli/home/virtual/VirtualBox
VMs/Zuccotti/Snapshots/{23d5aff0-4514-46b9-ab38-76ae59b3acbf}.vdi P
ID: 53354 Comm: kworker/4:2
[gio mar 26 06:02:43 2020] Page cache invalidation failure on direct
I/O.  Possible data corruption due to collision with buffered I/O!
[gio mar 26 06:02:43 2020] File:
/mnt/4TB/piastrelli/home/virtual/VirtualBox
VMs/Zuccotti/Snapshots/{23d5aff0-4514-46b9-ab38-76ae59b3acbf}.vdi P
ID: 55712 Comm: kworker/4:6

I have no problem at the moment (this is happening on the test setup
to evaluate BTRFS), but maybe it's important to spot it for you all
devs.
If it help you, I can test the same setup with ext4 or another fs.

Thanks again,
Gelma


Ciao,
Gelma
