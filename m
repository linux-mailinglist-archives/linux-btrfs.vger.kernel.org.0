Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 731B742A72E
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Oct 2021 16:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237250AbhJLOcc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Oct 2021 10:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236976AbhJLOca (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Oct 2021 10:32:30 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8892FC061745
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Oct 2021 07:30:26 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id r1so47052614ybo.10
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Oct 2021 07:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Rxv4pYP0PImq3ZQqkKORjTUcLtrUXu2ntmbbLsPFLFw=;
        b=qcjV/QVBPzpgSJymfDauQ2zVoVQqUTrp2Yg1JUvprvzclIEVzYuCudE2ni/k5Tcg+H
         L53n1AIXEpjbI9ft4aBUI9rS8PeAws3LgHAFlhweK33osFflW/3p78Lms4nwq5I9u9gk
         ThFkg6tpgyNi5r79zo3mtSFnJ1SKt+H+SErkJpmimOFasfUmWGjDzUt/oV4tmQaGdMFN
         Io3c0lTHrZIrTW7ofCkbCE4dY7o3QuLdsKVw42cUVCjzh87Bog0vdK6cAfpYh3SHb85e
         J7/vvgksznFlA9btWyZJ4xNoYKTGTrsp41Qk5Ee9TrzNfXPAqfIa+Rl0t29N0nQi5zRM
         Na4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Rxv4pYP0PImq3ZQqkKORjTUcLtrUXu2ntmbbLsPFLFw=;
        b=vkBc5N7rp41xALg6LytEjFgkNtNssTnVwyB3iPAeSs5o3cbFIctdLwB/xaPIXCdXJZ
         dGS56DO9c3PZ3WMPYg+UgLJvPSmTjSJCll6NyU9OWSHWGoobQ8PmBMAOAVq1li5YH8FD
         xMqEBITh3uNGYpv51W8cvT1R86AXun8Sp8Mtj7dL8fH4FHtty8bro+7djsnTUrhiFEKU
         QQ+X1z2ejr+Z5dRH+PReHDp4Wqo7xEFez7LYPXUAywwgAL0KaXWRtBFtYZ26/4r1oAAG
         7LS59Yt4OMH5NcZk9hBbmAevxcD254eyzFOSJ6KSVrBoxHki0hfmUvXTCdXii0CcmJwY
         N1ag==
X-Gm-Message-State: AOAM532DujHcMdtqacKnfSBF0iXwTjlYJJj1IC3KJ9CO8w2VmaN1f42x
        HEoOhST83bjQlB9Pw8dgCm+nBXiUQ8XuVFapRO0Mg0wHy0o6kj3r2zA=
X-Google-Smtp-Source: ABdhPJzkfgO1yyjXUjSq761DmxEpr4ERJmOfPMQCc2Mt/xB/ntCHNTcHLe+p24B16FSyq8AZlNtnpRpFuaCYgeh/TXc=
X-Received: by 2002:a25:d3c8:: with SMTP id e191mr28454239ybf.455.1634049024182;
 Tue, 12 Oct 2021 07:30:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtTqR8TJGZKKfwWB4sbu2-A+ZMPUBSQWzb0mYnXruuykAw@mail.gmail.com>
 <da57d024-e125-bcea-7ac3-4e596e5341a2@suse.com> <debf9d63-0068-84db-dcd4-1d923742f989@gmx.com>
In-Reply-To: <debf9d63-0068-84db-dcd4-1d923742f989@gmx.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 12 Oct 2021 10:30:08 -0400
Message-ID: <CAJCQCtSsLSwtNTrUKq_4Rs0tauT45iSA1+AkGWnS9Nmkb=0oWg@mail.gmail.com>
Subject: Re: 5.14.9 aarch64 OOPS Workqueue: btrfs-delalloc btrfs_work_helper
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <wqu@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 12, 2021 at 2:47 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2021/10/12 13:25, Nikolay Borisov wrote:
> >
> >
> > On 12.10.21 =D0=B3. 3:59, Chris Murphy wrote:
> >> Linux version 5.14.9-300.fc35.aarch64 Fedora-Cloud-Base-35-20211004.n.=
0.aarch64
> >> [ 2164.477113] Unable to handle kernel paging request at virtual
> >> address fffffffffffffdd0
> >> [ 2164.483166] Mem abort info:
> >> [ 2164.485300]   ESR =3D 0x96000004
> >> [ 2164.487824]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> >> [ 2164.493361]   SET =3D 0, FnV =3D 0
> >> [ 2164.496336]   EA =3D 0, S1PTW =3D 0
> >> [ 2164.498762]   FSC =3D 0x04: level 0 translation fault
> >> [ 2164.503031] Data abort info:
> >> [ 2164.509584]   ISV =3D 0, ISS =3D 0x00000004
> >> [ 2164.516918]   CM =3D 0, WnR =3D 0
> >> [ 2164.523438] swapper pgtable: 4k pages, 48-bit VAs, pgdp=3D000000015=
8751000
> >> [ 2164.533628] [fffffffffffffdd0] pgd=3D0000000000000000, p4d=3D000000=
0000000000
> >> [ 2164.543741] Internal error: Oops: 96000004 [#1] SMP
> >> [ 2164.551652] Modules linked in: virtio_gpu virtio_dma_buf
> >> drm_kms_helper cec fb_sys_fops syscopyarea sysfillrect sysimgblt
> >> joydev virtio_net virtio_balloon net_failover failover vfat fat drm
> >> fuse zram ip_tables crct10dif_ce ghash_ce virtio_blk qemu_fw_cfg
> >> virtio_mmio aes_neon_bs
> >> [ 2164.583368] CPU: 2 PID: 8910 Comm: kworker/u8:3 Not tainted
> >> 5.14.9-300.fc35.aarch64 #1
> >> [ 2164.593732] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/=
06/2015
> >> [ 2164.603204] Workqueue: btrfs-delalloc btrfs_work_helper
> >> [ 2164.611402] pstate: 80400005 (Nzcv daif +PAN -UAO -TCO BTYPE=3D--)
> >> [ 2164.620165] pc : submit_compressed_extents+0x38/0x3d0
> >
> > Qu isn't this the subpage bug you narrowed down a couple of days ago ?
>
> Not exactly.
>
> The bug I pinned down is inside my refactored code of LZO code, not the
> generic part, and my refactored code is not yet merged.
>
> Chris, mind to share the code context of the stack?

From the bug report:

* provision Fedora 35 aarhc64 cloud based VM in openstack
* try rebuilding kernel rpm(it seems there is need for some load on
the system to trigger the issue, but it seems to reliably trigger for
me)


So it seems reliably reproducible when compiling the kernel...



--=20
Chris Murphy
