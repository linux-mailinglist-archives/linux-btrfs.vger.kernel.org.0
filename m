Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2DED3FDF7A
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Sep 2021 18:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245096AbhIAQMR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Sep 2021 12:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234245AbhIAQMQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Sep 2021 12:12:16 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C85C061575
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Sep 2021 09:11:19 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id f6so236468vsr.3
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Sep 2021 09:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wcWZnmBMdXMLsbhh8A8I+zAqTIGh5K6Nid5rVJ4POMg=;
        b=bh9sjMVGyWxHTJyi7oUYXYR4bjb4Vu8sUVFIcSymLvxYZv46hdAMEFJohc/YmPI+qX
         pxPZxQa/1V0AbgElLhY1dlQRteMVR/eBxgoqfilA0mC1TQXTnXL2JhXL7C0qqNXyWqRa
         Lp8BXrX6gm8TRIEuNeNa7yFWP3fYXyxmOrLPiDIOwrjyl3b4L2+DQPkPB86K3qzo7jAC
         eoHz2MdKMFLAJOeH6Glg6vNSbVL/e9lVyeda50cKBP+JQJuhW0Gqb7JCFbGd7e9pcvW9
         3CQCjwh8Odl5LuSHROSbFAbE0775gse+4f5COtWr6Sui0E9FTXVHkj2Ftak4OqXX/kiP
         trgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wcWZnmBMdXMLsbhh8A8I+zAqTIGh5K6Nid5rVJ4POMg=;
        b=WXZ0htex8vI2NnHnc3f3aFPvFE57pqNaw2dNGHp3mk3Wvyf+x4w58S8V+PV9vjqkFo
         cOmz6J0H9ekd6wpvNlVMjR1cGSwFDQHEKn5xbvWk1GLMDewhVXM5/n+rksT/fbe3sOFd
         sjtdi+Eyn7YVxwtrcz7Zfzm0NLAdHvIGCyGfS4nyVo2dq6aB2mfuEOQtnEqyT6gXCmiX
         Phyt8QwryqjiOW+tfvJZxXTeI5ETRO3A7k1xo9ByCLnkv/qG1Q2YAXEdTh7fVqqOftvh
         Vzk9Oq/QObD+xnZwnfdnyLHoLzj/ZaFPTD2a8xB3V/TAZQrB/ywQpLWpCduTPjN6n896
         P9bA==
X-Gm-Message-State: AOAM533KjVphu6NGMFfEQz65PN+ySPmQiuL8hutr923BwbPbeL9ZFz4W
        DCjM1WEqh11/WkJGmvtsJGXrwztcGC5avepSF/E=
X-Google-Smtp-Source: ABdhPJzt2unvbuMHnHg/Hdyl8Nv3k3JpMjwaao3z8Vh+9nh1nHoGLBKdK8Xx4verMrD0Zyb6FWl+xg1wphE9Gm+EAqg=
X-Received: by 2002:a05:6102:188:: with SMTP id r8mr14588914vsq.11.1630512677125;
 Wed, 01 Sep 2021 09:11:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAHQ7scVGPAwEGQOq3Kmn75GJzyzSQ9qrBBZrHFu+4YWQhGE0Lw@mail.gmail.com>
 <ce0a558f-0fab-4d52-f2d1-1faf4fb1777c@oracle.com> <CAHQ7scVkHp8Lcfxx2QZXv2ghkW-nYpiFGntyZa0Toz2hU3S-tQ@mail.gmail.com>
 <b0feb23e-4a18-efd7-eeaf-832ef0cf6860@oracle.com> <CAHQ7scUiNLVD_4---ArBet-0DqzfmmH5Y9JgQY0grYrUv8yhiQ@mail.gmail.com>
 <c2d2a244-f77c-e0a4-d266-db011fc4154b@oracle.com>
In-Reply-To: <c2d2a244-f77c-e0a4-d266-db011fc4154b@oracle.com>
From:   =?UTF-8?B?RMSBdmlzIE1vc8SBbnM=?= <davispuh@gmail.com>
Date:   Wed, 1 Sep 2021 19:11:06 +0300
Message-ID: <CAOE4rSx5+9jXEE2ra5qYOiZWpVU=EcB1MadEf_35fa0M3MZyiw@mail.gmail.com>
Subject: Re: btrfs mount takes too long time
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Jingyun He <jingyun.ho@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        David Sterba <dsterba@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

pirmd., 2021. g. 30. aug., plkst. 16:08 =E2=80=94 lietot=C4=81js Anand Jain
(<anand.jain@oracle.com>) rakst=C4=ABja:
>
> open_ctree() took 228254398 us. And 98% of it that is 225418272 us
> was taken by btrfs_read_block_groups().
>
> -------------------
>   1) $ 225418272 us | } /* btrfs_read_block_groups [btrfs] */
>   1) * 16934.96 us | btrfs_check_rw_degradable [btrfs]();
>   0) 0.967 us | btrfs_apply_pending_changes [btrfs]();
>   0) 0.239 us | btrfs_read_qgroup_config [btrfs]();
>   0) * 21017.34 us | btrfs_get_root_ref [btrfs]();
>   0) + 15.717 us | btrfs_start_pre_rw_mount [btrfs]();
>   0) 0.865 us | btrfs_discard_resume [btrfs]();
>   0) $ 228254398 us | } /* open_ctree [btrfs] */
> -------------------
>
> Now we need to run the same thing on btrfs_read_block_groups(),
> could you please run.. [1] (no need of the time).
>
> [1]
>    $ umount /btrfs;
>    $./ftracegraph btrfs_read_block_groups 2 "*:mod:btrfs" "mount
> /dev/vg/scratch0 /btrfs"
>
> Thanks, Anand
>
>

Hi,

I also have a btrfs filesystem that takes a while to mount.
So I'm interested if this could be improved.

$ ./ftracegraph open_ctree 2 "*:mod:btrfs" "time mount /dev/md127 -o
space_cache=3Dv2,compress=3Dzstd,acl,subvol=3DData /mnt/Data/"
kernel.ftrace_enabled =3D 1

real    1m33,638s
user    0m0,000s
sys     0m1,130s

Here's the trace output https://d=C4=81vis.lv/files/ftracegraph.out.gz

The filesystem is on top of RAID6 mdadm array which is from 9x 3TB HDDs.

Best regards,
D=C4=81vis
