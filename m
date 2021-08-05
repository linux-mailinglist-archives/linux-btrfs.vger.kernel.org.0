Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 059C43E19CC
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Aug 2021 18:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbhHEQrX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Aug 2021 12:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbhHEQrW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Aug 2021 12:47:22 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF00C061765
        for <linux-btrfs@vger.kernel.org>; Thu,  5 Aug 2021 09:47:06 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id a5-20020a05683012c5b029036edcf8f9a6so5794809otq.3
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Aug 2021 09:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=SXQoBno43GIZX8lTJTllDI2TcTfVVHzWfXlmutq/Vyw=;
        b=OMb7cpOW9Cfys6FvLg28KoGXwyjXcONefpzOjlG2wBGkMovoDqvM/OZs5zstYpOQkD
         9idkMlOKLw997b8x4hBu1c5CPLWrNOnyNjDJe2lSaln1kWa/P136qFvQiYrPpfv7BKxi
         cxuPWAGi1BaFTvZiN+SYWLZ6dfrftDrBBPr68yIQB1M+3aBfEtNhN3Sb0L5SqycNrevE
         oI/GE8v+fXk2qVTq52Wix2SUWXwkUSvLXLX+eTdtGldJu+z3xFrGPrZbOGxFxufHOt89
         o/v2wVBTtjQepiO4dmkxOWkm5GT+ebu040yHowZTVtoqk5YxNHZ6+KZq4lH/QHWeYZP5
         6wsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=SXQoBno43GIZX8lTJTllDI2TcTfVVHzWfXlmutq/Vyw=;
        b=q6eVPvdCZ++HzZwC3kI5RdMWJSPLe95vZo6f6sN1vkedEGw8QHcKvkw9Cxaa6UxeIR
         WebKwuNJ6G2em/D0wmtoDPO4rAc37NxNyh+4tzusX17HN2QNjLgcVtqttGrfoYQIlhA7
         PR+ko/vVntI498WmE5oEgChCDfpAXKduYIjvwcrLOE0GgWyk9x1/g5uuyxbXEl4NhfMB
         UNsj22FbnLbIHFVZKvrJE67ehIG3N3THkIkfgZg21/3zdU2Ix1aUljH51a9w+MM+bMAU
         K/4swIBTi2NmFc00jRwUD6PEmHFHD/ChJdSqkzDmQwUD2Xqee2WIeIuXFX6JjTFXG5ub
         s8og==
X-Gm-Message-State: AOAM530WV9+vbQcXVjPcK+YeD3mMQiFqQ7A1A0X852+iSnd6hCntI/as
        nhi+7GS+mXtiFrcYxAFRk1ICtQObtxFCcQQb/GooNibqVb0=
X-Google-Smtp-Source: ABdhPJydxBaC/Pr7FSiCmYFnpP+a9cUtiUN6iqdtYYWtECNLbS6+Iug++L+cJdOJvSW6NunPQosTfIYSTymK51j8Bqs=
X-Received: by 2002:a9d:410b:: with SMTP id o11mr4451462ote.211.1628182026128;
 Thu, 05 Aug 2021 09:47:06 -0700 (PDT)
MIME-Version: 1.0
From:   Dave T <davestechshop@gmail.com>
Date:   Thu, 5 Aug 2021 12:46:54 -0400
Message-ID: <CAGdWbB59ULVxpNnq5Og0SCri+qyz_cwDLFTLr5N7iVT9gb0w1A@mail.gmail.com>
Subject: why is the same mount point repeatedly mounted in nested manner?
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I recently switched from snapper and snapsync to btrbk, which I
generally prefer. However, I am running into one issue.

Background - from https://digint.ch/btrbk/doc/faq.html
Btrbk is designed to operate on the subvolumes within a root
subvolume. The author recommend booting linux from a btrfs subvolume,
and using the btrfs root only as a container for subvolumes (i.e. NOT
booting from "subvolid=3D5").

That's exactly what I'm doing.

The key point is that btrbk requires mounting the toplevel subvolume
to perform its tasks.

I'm using btrbk via a systemd timer. I have a daily and hourly timer
set up. Each timer starts by mounting the btrfs root, performing the
btrbk task, and unmounting the btrfs root.

I create hourly snapshots and on a daily basis I use btrbk to transfer
those to two different USB HDD's as well as to a remote server via
SSH.

Here's the problem. I now end up (after some time) with a nested list
of mounts for one particular mount point as shown below. I don't
understand why or how this is happening. It does have side effects
(disk access can hang). The apparent "cure" is to restart the nfs
server service, but I'm still trying to understand the issue fully.

# cat /etc/fstab
UUID=3D28D099A-9D92-487C-8113-A231CAD0EEF2  /     btrfs
rw,noatime,nodiratime,compress=3Dlzo,space_cache,subvol=3D/@btrtop/snapshot
0 0 #mounts my root filesystem
UUID=3D28D099A-9D92-487C-8113-A231CAD0EEF2  /mnt/btrtop/root  btrfs
noauto,nofail,rw,noatime,nodiratime,compress=3Dlzo,space_cache    0 0
#mounts the top btrfs volume for btrbk access to all snapshots
/var/cache/pacman       /srv/nfs/var/cache/pacman       none  bind  0 0

# findmnt -t btrfs
TARGET                                      SOURCE
                                       FSTYPE OPTIONS
/
/dev/mapper/xyz[/@btrtop/snapshot]                     btrfs
rw,noatime,nodiratime,compress=3Dlzo,space_cache,subvolid=3D3194,subvol=3D/=
@btrtop/snapshot
=E2=94=9C=E2=94=80/srv/nfs/var/cache/pacman
/dev/mapper/xyz[/@btrtop/snapshot/var/cache/pacman]    btrfs
rw,noatime,nodiratime,compress=3Dlzo,space_cache,subvolid=3D3194,subvol=3D/=
@btrtop/snapshot
=E2=94=82 =E2=94=94=E2=94=80/srv/nfs/var/cache/pacman
/dev/mapper/xyz[/@btrtop/snapshot/var/cache/pacman]    btrfs
rw,noatime,nodiratime,compress=3Dlzo,space_cache,subvolid=3D3194,subvol=3D/=
@btrtop/snapshot
=E2=94=82   =E2=94=94=E2=94=80/srv/nfs/var/cache/pacman
/dev/mapper/xyz[/@btrtop/snapshot/var/cache/pacman]    btrfs
rw,noatime,nodiratime,compress=3Dlzo,space_cache,subvolid=3D3194,subvol=3D/=
@btrtop/snapshot
=E2=94=82     =E2=94=94=E2=94=80/srv/nfs/var/cache/pacman
/dev/mapper/xyz[/@btrtop/snapshot/var/cache/pacman]    btrfs
rw,noatime,nodiratime,compress=3Dlzo,space_cache,subvolid=3D3194,subvol=3D/=
@btrtop/snapshot
=E2=94=82       =E2=94=94=E2=94=80/srv/nfs/var/cache/pacman
/dev/mapper/xyz[/@btrtop/snapshot/var/cache/pacman]    btrfs
rw,noatime,nodiratime,compress=3Dlzo,space_cache,subvolid=3D3194,subvol=3D/=
@btrtop/snapshot
=E2=94=82         =E2=94=94=E2=94=80/srv/nfs/var/cache/pacman
/dev/mapper/xyz[/@btrtop/snapshot/var/cache/pacman]    btrfs
rw,noatime,nodiratime,compress=3Dlzo,space_cache,subvolid=3D3194,subvol=3D/=
@btrtop/snapshot
=E2=94=82           =E2=94=94=E2=94=80/srv/nfs/var/cache/pacman
/dev/mapper/xyz[/@btrtop/snapshot/var/cache/pacman]    btrfs
rw,noatime,nodiratime,compress=3Dlzo,space_cache,subvolid=3D3194,subvol=3D/=
@btrtop/snapshot
=E2=94=82             =E2=94=94=E2=94=80/srv/nfs/var/cache/pacman
/dev/mapper/xyz[/@btrtop/snapshot/var/cache/pacman]    btrfs
rw,noatime,nodiratime,compress=3Dlzo,space_cache,subvolid=3D3194,subvol=3D/=
@btrtop/snapshot
=E2=94=9C=E2=94=80/var/cache/pacman
/dev/mapper/xyz[/@btrtop/snapshot/var/cache/pacman]    btrfs
rw,noatime,nodiratime,compress=3Dlzo,space_cache,subvolid=3D3194,subvol=3D/=
@btrtop/snapshot
=E2=94=82 =E2=94=94=E2=94=80/var/cache/pacman
/dev/mapper/xyz[/@btrtop/snapshot/var/cache/pacman]    btrfs
rw,noatime,nodiratime,compress=3Dlzo,space_cache,subvolid=3D3194,subvol=3D/=
@btrtop/snapshot
=E2=94=82   =E2=94=94=E2=94=80/var/cache/pacman
/dev/mapper/xyz[/@btrtop/snapshot/var/cache/pacman]    btrfs
rw,noatime,nodiratime,compress=3Dlzo,space_cache,subvolid=3D3194,subvol=3D/=
@btrtop/snapshot
=E2=94=82     =E2=94=94=E2=94=80/var/cache/pacman
/dev/mapper/xyz[/@btrtop/snapshot/var/cache/pacman]    btrfs
rw,noatime,nodiratime,compress=3Dlzo,space_cache,subvolid=3D3194,subvol=3D/=
@btrtop/snapshot
=E2=94=82       =E2=94=94=E2=94=80/var/cache/pacman
/dev/mapper/xyz[/@btrtop/snapshot/var/cache/pacman]    btrfs
rw,noatime,nodiratime,compress=3Dlzo,space_cache,subvolid=3D3194,subvol=3D/=
@btrtop/snapshot
=E2=94=82         =E2=94=94=E2=94=80/var/cache/pacman
/dev/mapper/xyz[/@btrtop/snapshot/var/cache/pacman]    btrfs
rw,noatime,nodiratime,compress=3Dlzo,space_cache,subvolid=3D3194,subvol=3D/=
@btrtop/snapshot
=E2=94=82           =E2=94=94=E2=94=80/var/cache/pacman
/dev/mapper/xyz[/@btrtop/snapshot/var/cache/pacman]    btrfs
rw,noatime,nodiratime,compress=3Dlzo,space_cache,subvolid=3D3194,subvol=3D/=
@btrtop/snapshot
