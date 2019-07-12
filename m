Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9706C6702F
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jul 2019 15:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbfGLNgE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Jul 2019 09:36:04 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35114 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727291AbfGLNgE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Jul 2019 09:36:04 -0400
Received: by mail-wm1-f66.google.com with SMTP id l2so9010170wmg.0
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Jul 2019 06:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9idr00AAq53w+ScA3a3Otywee0XUbZRR3G32MZ6ddgc=;
        b=rrinZwxjCrixGLmn9u2vm4EGAu4GWVPbUff0j0ArusFYG/pcHY5OQJYglFKL77Vk1I
         warZcvi+2FsKiv8zHl1SZg78MC9vH5B6pZuVjY7ZfHHMAFVsTONuYEQTyWX8Q2VgJrzs
         I/y3Gb9VU5GrrDC23Snk4hsjZ5oj8XNlUqk9RfCJVZxH5lFZIiugreh3w1XoMtEo5XKv
         lk3ZQs7rcfLzcevIC+NV5g28Gl5pmJVBGX5J/npGYJSPamhlYc2XJxkWLw/HIxJB9sCF
         fxkqajzHLuHCMOlmbBz2xqsi+DD77w7KRSAUzZWk+hKkCfku3bIOSAYF7cAAEdwArS5e
         bujw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9idr00AAq53w+ScA3a3Otywee0XUbZRR3G32MZ6ddgc=;
        b=kpakzIV/eRutpv0Asu3/rGuTZJe36FsW3zIczt0e/XwsRsn45l5sfkIgDdrzStv6jl
         haMRTa5/93W+YpBhHdsS8Hx8dcFPxIwmdfi3Daxo9lKyPzWZfbgMVLP5SFfA3/RYzuT8
         ++3Ic4clXNvwNSBIMsGimagXmPhCWCEqTrG6sbMm5oEkJE9Bj6GQK+Q4j0VZ+XKntZCG
         JEUCQzsj52Ws+YGL5TrLkTCP3R/bCfKx9GX6ii929NeWcHbj6En9hTq0nlkttW0DO/60
         qdq1hQ0h8mNnt8EOc1UYhPFk7xxnL+uaqMKPVuyemr296t84bjpfGr/1KeJKrK3wan+O
         pTCA==
X-Gm-Message-State: APjAAAWyIwotwS6KDmhXTlAknFYpB9AOvQXhYAabE9Y6TJ2BYp/rCnlb
        tEDZ6UoW4Val80hUV1FIn2cusD2sGeOb6uyhUF8LjDRq
X-Google-Smtp-Source: APXvYqw4aMo1MkEg7BVGnwxAXem5+HthReWIVqAr9DKEFo2XnMUWbm1BNO6biFcf1jZipnQMyrIa2B2DexkK5IjLVqE=
X-Received: by 2002:a7b:cc04:: with SMTP id f4mr10188043wmh.125.1562938562204;
 Fri, 12 Jul 2019 06:36:02 -0700 (PDT)
MIME-Version: 1.0
References: <5d8baf80-4fb3-221f-5ab4-e98a838f63e1@cobb.uk.net>
 <c01ab9f6-c553-3625-5656-a8f61659de7d@oracle.com> <a3d6e202-acf4-c02e-430a-aef4a2ee4247@cobb.uk.net>
 <7766d592-525e-67fa-5db0-bcfff17fbf83@oracle.com>
In-Reply-To: <7766d592-525e-67fa-5db0-bcfff17fbf83@oracle.com>
From:   Patrik Lundquist <patrik.lundquist@gmail.com>
Date:   Fri, 12 Jul 2019 15:35:50 +0200
Message-ID: <CAA7pwKM_Le3FO8qprqn4busbTzWHeUTB+9h1zwBQ+KOjKqZuvw@mail.gmail.com>
Subject: Re: "btrfs: harden agaist duplicate fsid" spams syslog
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Graham Cobb <g.btrfs@cobb.uk.net>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        calestyo@scientia.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, 12 Jul 2019 at 14:48, Anand Jain <anand.jain@oracle.com> wrote:
> I am unable to reproduce, I have tried with/without dm-crypt on both
> oraclelinux and opensuse (I am yet to try debian).

I'm using Debian testing 4.19.0-5-amd64 without problem. Raid1 with 5
LUKS disks. Mounting with the UUID but not(!) automounted.

Running "btrfs device scan --all-devices" doesn't trigger the fsid move.

$ sudo btrfs fi show /raid/
Label: 'btrfs_pool'  uuid: 4242423a-990c-4650-b615-14fe009b0edd
    Total devices 5 FS bytes used 7.85TiB
    devid    1 size 7.28TiB used 5.85TiB path /dev/mapper/sdb1_crypt
    devid    2 size 1.82TiB used 1.44TiB path /dev/mapper/sda1_crypt
    devid    3 size 1.82TiB used 1.34TiB path /dev/mapper/sdc1_crypt
    devid    4 size 5.46TiB used 4.98TiB path /dev/mapper/sdd1_crypt
    devid    5 size 2.73TiB used 2.25TiB path /dev/mapper/sdf1_crypt

$ ll /dev/dm-*
brw-rw---- 1 root disk 254, 0 jul  9 15:08 /dev/dm-0
brw-rw---- 1 root disk 254, 1 jul  9 15:08 /dev/dm-1
brw-rw---- 1 root disk 254, 2 jul  9 15:08 /dev/dm-2
brw-rw---- 1 root disk 254, 3 jul  9 15:08 /dev/dm-3
brw-rw---- 1 root disk 254, 4 jul  9 15:08 /dev/dm-4

$ ll /dev/mapper/
total 0
drwxr-xr-x  2 root root     160 jul  9 15:08 ./
drwxr-xr-x 18 root root    3640 jul 10 08:16 ../
crw-------  1 root root 10, 236 jul  9 15:08 control
lrwxrwxrwx  1 root root       7 jul  9 15:08 sda1_crypt -> ../dm-0
lrwxrwxrwx  1 root root       7 jul  9 15:08 sdb1_crypt -> ../dm-1
lrwxrwxrwx  1 root root       7 jul  9 15:08 sdc1_crypt -> ../dm-2
lrwxrwxrwx  1 root root       7 jul  9 15:08 sdd1_crypt -> ../dm-3
lrwxrwxrwx  1 root root       7 jul  9 15:08 sdf1_crypt -> ../dm-4
