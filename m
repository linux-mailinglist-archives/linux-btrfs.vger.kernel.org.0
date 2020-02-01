Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0D2C14FAA0
	for <lists+linux-btrfs@lfdr.de>; Sat,  1 Feb 2020 22:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgBAVRU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 1 Feb 2020 16:17:20 -0500
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:42604 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbgBAVRU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 1 Feb 2020 16:17:20 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 4896Nv5vqwz9vZ60
        for <linux-btrfs@vger.kernel.org>; Sat,  1 Feb 2020 21:17:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4PkSvp0Vd4Jo for <linux-btrfs@vger.kernel.org>;
        Sat,  1 Feb 2020 15:17:19 -0600 (CST)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 4896Nv3Xlsz9vZ5T
        for <linux-btrfs@vger.kernel.org>; Sat,  1 Feb 2020 15:17:19 -0600 (CST)
Received: by mail-ed1-f72.google.com with SMTP id g20so7299875edt.18
        for <linux-btrfs@vger.kernel.org>; Sat, 01 Feb 2020 13:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=d.umn.edu; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=k1cwKh2k3EqX0YLb5dJQoArB3mzIo3Kj1WPuVRtkxMU=;
        b=GwU/98dPAYhbdctOPHeoxiUpuTfVmmc7SxE7NRQQRH3EhSCj0K026qxa4m6u/h800U
         CzPWjaCrWhG63F8cdXosv358f1egHzsLly2s58oyPn3IDLpH5FWMDBJUWInjAPfMG/XW
         JOT6A/SsOjDI4OYcUuawT3Rt0Nq0NJ/aaCU05zvin91UTvFAu7da9OFa/JAqLZyMbR9C
         mn9N9ghIm195w54IyKQxSRmFb7zHbG1j1LJWkdnPJpybQqSOlgnH1oHIr8StCXIJSoWg
         9EFdzRkrkRWW5TckvKvvQnNFj+c6pmc2ACNeqyf1qaXcLZhrfA6wmDalfAJSnG0A1p45
         +MrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=k1cwKh2k3EqX0YLb5dJQoArB3mzIo3Kj1WPuVRtkxMU=;
        b=A+/sAuo/R1HlhNxyfj+hSPtSPKh8SXWF2AX6xznrNFVOtU5YangBnntgyrno8ieJbL
         8RZQGDOaNywHiNUC1XTAYUOGx8UerOA3scwAFKRbkSD4PPmXlRgVzuroYDrI+mlCo163
         7DBQc8KnJa/MH6SKHWTM4fdS7WvrAHELvtsdk17CtW+CU1sQVf67U5uWy9Crf/EmbSzx
         BwtlWsOdHtK8ZS+hxnN0h4ci7Dk+OJxfgcSj+F1VH0uoUuUf5Y+f7FekSs4ghqR6LXOB
         qrxrklgDPsiw+bmER7LfP1Ytah53WmzMvfakzWoDmJkMJ4hAthN11MdOY6EaTiCuRmI8
         B36Q==
X-Gm-Message-State: APjAAAWd2ml2SZt/QqV1nhXT8apSk/NrsHq3XHnS/hsHxc1ASiz6Mg7V
        dkMuf/CRlfu25GreAlQLihy91vyumLsP5WmtiDJSIGVG6+UpnMmsmIKMkFbeTjROPwJaK7me6MG
        D5akFNFHX5uW3sWdC28EVdSIagywnPD6W0YBU/FJIaC8=
X-Received: by 2002:a17:906:c78b:: with SMTP id cw11mr14126550ejb.262.1580591838190;
        Sat, 01 Feb 2020 13:17:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqzIa3uLceuW1geHM1ql6zwk0A6+BELBsPNIImLt1HxvC3zXwARfhluAYC8RCpva7gOBA4/2Gco9BX0CFw2HkvY=
X-Received: by 2002:a17:906:c78b:: with SMTP id cw11mr14126541ejb.262.1580591837938;
 Sat, 01 Feb 2020 13:17:17 -0800 (PST)
MIME-Version: 1.0
From:   Matt Zagrabelny <mzagrabe@d.umn.edu>
Date:   Sat, 1 Feb 2020 15:17:06 -0600
Message-ID: <CAOLfK3Vs-5CJxPuC2zFyQ4tw0BZkHx-ggE=tLcmriELx-Qe8og@mail.gmail.com>
Subject: support for RAID10 installation
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Greetings,

I have recently installed Debian with a root disk formatted with btrfs
(RAID 10 with 4 drives of 12TB each.)

root@zeus:~# uname -a
Linux zeus 5.4.0-3-amd64 #1 SMP Debian 5.4.13-1 (2020-01-19) x86_64 GNU/Linux
root@zeus:~# btrfs --version
btrfs-progs v5.4.1
root@zeus:~# btrfs fi show
Label: 'root'  uuid: bfd97357-7f10-4648-88a4-6521c6c4bb9c
        Total devices 4 FS bytes used 775.79GiB
        devid    1 size 10.00TiB used 388.53GiB path /dev/sda2
        devid    2 size 10.00TiB used 388.53GiB path /dev/sdb2
        devid    3 size 10.00TiB used 388.53GiB path /dev/sdc2
        devid    4 size 10.00TiB used 388.53GiB path /dev/sdd2

root@zeus:~# btrfs fi df /
Data, RAID10: total=776.00GiB, used=774.84GiB
System, RAID10: total=64.00MiB, used=112.00KiB
Metadata, RAID10: total=1.00GiB, used=966.09MiB
GlobalReserve, single: total=512.00MiB, used=0.00B
root@zeus:~# dmesg > /tmp/dmesg.log

I've run out of space:

root@zeus:~# df -h
Filesystem      Size  Used Avail Use% Mounted on
udev             16G     0   16G   0% /dev
tmpfs           3.2G  9.2M  3.2G   1% /run
/dev/sda2        20T  777G     0 100% /
tmpfs            16G     0   16G   0% /dev/shm
tmpfs           5.0M  4.0K  5.0M   1% /run/lock
tmpfs            16G     0   16G   0% /sys/fs/cgroup
tmpfs           3.2G   16K  3.2G   1% /run/user/1000
root@zeus:~#

and I've tried balancing (both data and metadata) to get both the
system and btrfs to agree on how much free space I have.

I've also tried resizing the disks smaller and then larger - I found a
(perhaps misleading) post on an online forum suggesting such things to
retrieve space.

I have no idea how to proceed to fix things.

If you'd like to see the dmesg output, please let me know - it didn't
look very informative.

Any help, pointers, or suggestions is very welcome.

Thanks you for your time!

-m
