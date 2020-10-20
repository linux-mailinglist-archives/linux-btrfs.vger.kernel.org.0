Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7982429383F
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Oct 2020 11:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405564AbgJTJhH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Oct 2020 05:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392887AbgJTJhG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Oct 2020 05:37:06 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CABDC061755
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Oct 2020 02:37:06 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id l4so1158368ota.7
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Oct 2020 02:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=PmEBNuq3FWq3sd1gxiKUanGb060hqn+oEu3Q8e8Uaqk=;
        b=JBR1f7Yf+derbhOm2yKlVefYS8edjTynSJbrUG7qJpc0LbCgIAYNzzl5mhSbm1L9DN
         8CFRwQbbBSggygh2N51+JKX5Mt6ZjByXvy55pb9EckH/gZkN6C7Z9NaJuGtb+Bkb3RoT
         G0VIvHQBhUICryhpHyLDDxeKvrW3+26odtzK8A8DgiTw777rRp3ManmMkjYzirfAqs+o
         nGVX2Ot/vrGrkuAY4Um5RdHylPGWHqyM8LRUD2Lvs8tYWhHlc/IxMWyfyUQLXsQGAQSt
         6I/D/Pg/80eWnf4oTdm4tT39QFV+W/e37DclyxKe5rbQL47PK6keBFEaGFPAzx057YY+
         kc9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=PmEBNuq3FWq3sd1gxiKUanGb060hqn+oEu3Q8e8Uaqk=;
        b=ot6yaOIFWo5lGDVzL85+DacyuDTMMB8F2nEA5CTDGAFuUx7b9MVxItIgODTCNnkWqK
         sGkDIdPjNSaRQmcui6QQjeZZjrRSm8Sl6b1xPjNjJsJN/mbNPa3guTeMkCW5UFBHXOE7
         K5USkoDFdlbG4RPNxqNpu3YafE3+bOYjcApxGmKC5WmgU641CPsNUoovhsI1s83WL0at
         5XoEjdkt3GFegokZHUoOhXNuMpqPDES+c1JAK3zueX5UQh85FYunpgyiwtsb2m1JjXPA
         LRIhdgoDuX2dEg62PYX7SuygCXHcW09YiPpl6iBx2onshulGYBiyqFcaSQgv6jBFSEeU
         EsOw==
X-Gm-Message-State: AOAM532li92Lj89QRsJtD579uPU4rMXAht4z4i1a572CZGv5iRB9VHtC
        Gxw79lKXVmNNUeYMPkR29q+rxifM1url8rFRGy2RLS5YU0qBGg==
X-Google-Smtp-Source: ABdhPJyieWGIIR/Gl1gtMPnP7ViNtJPtTJiL180i7xSJ1yu6cGUtjqYtfZBQqn4S5iVxsVMs/BMcdYSV37pWyiefJcI=
X-Received: by 2002:a9d:41:: with SMTP id 59mr1153467ota.216.1603186625294;
 Tue, 20 Oct 2020 02:37:05 -0700 (PDT)
MIME-Version: 1.0
From:   Tyler Hardin <th020394@gmail.com>
Date:   Tue, 20 Oct 2020 05:36:29 -0400
Message-ID: <CAJwFvsW0_=zEOHFwHJZjvZb1akcJYR3FJANhG1GsK7eR=PSc4g@mail.gmail.com>
Subject: Raid5, deleted a device, now see "some devices missing"
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I replace a drive the dumb way by adding a new one and deleting the
old. The add worked fine and the delete seemed to work, the change in
disk usage moved from the old drive to the new drive, but when I try
to mount the fs I now get an error.

$ uname -a
Linux lnv 5.8.0-3-amd64 #1 SMP Debian 5.8.14-1 (2020-10-10) x86_64 GNU/Linux

$ btrfs --version
btrfs-progs v5.7

$ sudo btrfs fi show
Label: none  uuid: 5cf68b2e-3665-41aa-a38d-6e616e52d4d7
Total devices 1 FS bytes used 1.52TiB
devid    1 size 1.79TiB used 1.53TiB path /dev/sda3

Label: none  uuid: 8e6f0b0f-8b93-4fda-a243-8ed2d798bfd7
Total devices 5 FS bytes used 4.56TiB
devid    1 size 1.82TiB used 1.52TiB path /dev/sdc
devid    2 size 1.82TiB used 1.52TiB path /dev/sdd
devid    3 size 1.82TiB used 1.52TiB path /dev/sde
devid    5 size 7.28TiB used 1.52TiB path /dev/sdb
*** Some devices missing

$ sudo mount /dev/sdb /mnt/data
mount: /mnt/data: wrong fs type, bad option, bad superblock on
/dev/sdb, missing codepage or helper program, or other error.

$ dmesg
[ 1130.412726] BTRFS info (device sdc): disk space caching is enabled
[ 1130.412731] BTRFS info (device sdc): has skinny extents
[ 1130.483868] BTRFS error (device sdc): super_num_devices 5 mismatch
with num_devices 4 found here
[ 1130.483877] BTRFS error (device sdc): failed to read chunk tree: -22
[ 1130.503239] BTRFS error (device sdc): open_ctree failed

Thanks in advance.
