Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 562E43CAF13
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Jul 2021 00:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbhGOWWs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Jul 2021 18:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbhGOWWs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Jul 2021 18:22:48 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD99AC06175F
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Jul 2021 15:19:53 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id p67so8559600oig.2
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Jul 2021 15:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=uzf1HAwGc+IBXKIMWINXd5y/sWjCNovPK7OlbuS2waw=;
        b=el6UXPaZAcX3YEchcOaOVhoseb8HOuQZ+Vk11RcNjFRkDDGyy9MTUU5KrncfzlVpJJ
         lH8wrUMZtuHyIN4ZDT2qaPIagDdIRBRDtzvFY77sgQThRM2lnyIVAO/anvYx2dd3sGqF
         dTLH22ElxbPpWtGRoowv+NS8eAWCnLu1bg1UyVt/AOhn1UAPYbCyEtPCntKoPsTSJISH
         RJLxxLqy7rWWWRBiB3vTWaZIt56DskEH6pjhTCBD2qvLAJRXHaJYAF2YPjn7yTxTX0eP
         4Kg+TB9nWc/r8PpRmnEMlT/wEyJ1ljLL/OaJEGmVYzELhU8n0f0/DO6hN90y01u1uRF1
         twWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=uzf1HAwGc+IBXKIMWINXd5y/sWjCNovPK7OlbuS2waw=;
        b=fOrLWowPgfnl6XSKVDquMx33i4pmIWv4zPmCnOm73yWAc6BUZYxv0htJFanWQ8dWFE
         SFS208TV06KS1N11+nOErkx2e5wUsSs4KJ1Ugl+kdAZCigz76G5Xd6InJay3rzM5NVcK
         3MoN5oeUTGBDKGUQ0R6t8WRVJ7VqarzGXe34n7VOtyQc56px+0rvd+onth1opnfBRlCv
         FTzDfKDj+rAEVBj88v6LMlUwiBjYHZBjBCJdn9KRuSgD8U4eiWEW7eaZX43LW1Z5L4N1
         N5WIDrID1eiN6tBtrMQmFL3AUaH6SdZDTrrYztWx6lzflK5GF9fFHOpsYZGtxujqcfvn
         4BIw==
X-Gm-Message-State: AOAM5308OacRvvG0JyaLhuwgj4cZOp1AE6dgPBi/wKMZw68jaX7c0JmW
        iivXI47o1OvHIIhYTqaBzfWfMIlD6ZH1XuDkje8=
X-Google-Smtp-Source: ABdhPJzOQKdxkgK1RxvA2fyVOX1re5S3ejH888fk2dwd7P5Hbf8qrfIF//P0cesdkFc3rxnyFpp7ltKBK67b6SO5ZWg=
X-Received: by 2002:aca:47d6:: with SMTP id u205mr5449756oia.44.1626387593134;
 Thu, 15 Jul 2021 15:19:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAGdWbB6qxBtVc1XtSF_wOR3NyR9nGpr5_Nc5RCLGT5NK=C4iRA@mail.gmail.com>
 <3be8bba9-60cd-2cce-a05d-6c24b8895f3f@gmx.com> <CAGdWbB44nH7dgdP3qO_bFYZwbkrW37OwFEVTE2Bn+rn4d7zWiQ@mail.gmail.com>
 <43e7dc04-c862-fff1-45af-fd779206d71c@gmx.com> <CAGdWbB7Q98tSbPgHUBF+yjqYRBPZ-a42hd=xLwMZUMO46gfd0A@mail.gmail.com>
In-Reply-To: <CAGdWbB7Q98tSbPgHUBF+yjqYRBPZ-a42hd=xLwMZUMO46gfd0A@mail.gmail.com>
From:   Dave T <davestechshop@gmail.com>
Date:   Thu, 15 Jul 2021 18:19:42 -0400
Message-ID: <CAGdWbB47rKnLoSBZ7Ez+inkeKRgE+SbOAp5QEpB=VWfM_5AmRA@mail.gmail.com>
Subject: Re: bad file extent, some csum missing - how to check that restored
 volumes are error-free?
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> > >> You may want to run "btrfs check --mode=lowmem" to get a more human
> > >> readable report.
> > >>   From that we can get a full view of the problem and give better advice.
> > >
> > > Thank you. I will try to do that after I finish fully setting up the new SSD.
> > >
> > Looking forward to the output.

kernel version 5.12.15-arch1-1 (linux@archlinux)

# btrfs scrub start -B /
scrub done for ff2b04eb-088c-4fb0-9ad4-84780d23f821
Scrub started:    Thu Jul 15 11:44:47 2021
Status:           finished
Duration:         0:15:53
Total to scrub:   310.04GiB
Rate:             327.54MiB/s
Error summary:    no errors found

# btrfs check --mode=lowmem /dev/mapper/xyz
Opening filesystem to check...
Checking filesystem on /dev/mapper/extluks
UUID: ff2b04eb-088c-4fb0-9ad4-84780d23f821
[1/7] checking root items
[2/7] checking extents
[3/7] checking free space cache
[4/7] checking fs roots
ERROR: root 329 EXTENT_DATA[262 536576] compressed extent must have
csum, but only 0 bytes have, expect 65536
ERROR: root 329 EXTENT_DATA[262 536576] is compressed, but inode flag
doesn't allow it
ERROR: root 329 EXTENT_DATA[7070 0] compressed extent must have csum,
but only 0 bytes have, expect 4096
ERROR: root 329 EXTENT_DATA[7070 0] is compressed, but inode flag
doesn't allow it
ERROR: root 329 EXTENT_DATA[7242 0] compressed extent must have csum,
but only 0 bytes have, expect 28672
ERROR: root 329 EXTENT_DATA[7242 0] is compressed, but inode flag
doesn't allow it
ERROR: root 329 EXTENT_DATA[7246 0] compressed extent must have csum,
but only 0 bytes have, expect 16384
ERROR: root 329 EXTENT_DATA[7246 0] is compressed, but inode flag
doesn't allow it
ERROR: root 329 EXTENT_DATA[7252 0] compressed extent must have csum,
but only 0 bytes have, expect 32768
ERROR: root 329 EXTENT_DATA[7252 0] is compressed, but inode flag
doesn't allow it
ERROR: root 329 EXTENT_DATA[7401 0] compressed extent must have csum,
but only 0 bytes have, expect 12288
ERROR: root 329 EXTENT_DATA[7401 0] is compressed, but inode flag
doesn't allow it

and hundreds more errors of this same type... (I guess you don't want
to see every error line.)

ERROR: root 334 EXTENT_DATA[184874 0] compressed extent must have
csum, but only 0 bytes have, expect 16384
ERROR: root 334 EXTENT_DATA[184874 0] is compressed, but inode flag
doesn't allow it
ERROR: errors found in fs roots
found 327307210752 bytes used, error(s) found
total csum bytes: 282325056
total tree bytes: 5130452992
total fs tree bytes: 4535648256
total extent tree bytes: 249790464
btree space waste bytes: 848096029
file data blocks allocated: 588119937024
 referenced 568343642112

I'm interested in your thoughts about what might have caused this, and
how I should repair / fix it. Are any of these options appropriate?

-  btrfs rescue chunk-recover /dev/mapper/xyz

-  btrfs check --repair --init-extent-tree /dev/mapper/zyz

- btrfs check --repair --init-csum-tree /dev/mapper/xyz

Thank you.
