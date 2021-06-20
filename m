Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF2A3AE05A
	for <lists+linux-btrfs@lfdr.de>; Sun, 20 Jun 2021 22:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbhFTUkZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 20 Jun 2021 16:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbhFTUkY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 20 Jun 2021 16:40:24 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEE7C061574
        for <linux-btrfs@vger.kernel.org>; Sun, 20 Jun 2021 13:38:11 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id bm25so10442259qkb.0
        for <linux-btrfs@vger.kernel.org>; Sun, 20 Jun 2021 13:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=ldk8tA65+m2606pOo410IHGd50z2oZhqcb48l6BDpQk=;
        b=M4uV5U0b5prZ6RClmNN3cmFNIwvMJBs15TpRKdKKYuaAwU24RD5RJtolTxBSpTN9lD
         GkpiI3fG6uLjPvHXc5ZPPeKfvJiPaeWIsYPWtg+67yLC0OjMU10e4g6s1I70sKC5oWo1
         wCZe6a3dkZxvwAtrXLkIWLrLwyexp29xxW3oiVa+AJIxK74GT3sB6c108RH1tQCHyUVp
         v8FssA7IONQUQ9h/3VKw/AjLjVmHQlsZ96cs9HtpyEzMn3TRxrVy9voPq0Y9mNdmruj6
         uBlriy56cM5s7p6mp2T1qayoToD8GMOO7LnoC6yPbGCSZkwBx61JchcHcYBueBxjjyzy
         VQZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ldk8tA65+m2606pOo410IHGd50z2oZhqcb48l6BDpQk=;
        b=BPqVeFGe5V+Ne+7IOOS6HLx9gN5SDxMwK25Ob0TxQUfWkdPZnu3EKUPbo7FP8/Thla
         cneCA4sw5G76PlZIOZSVi+b6TrBELtiDFSsN/bqXDDiGSc1KQXPa3M8v3uqZZrH9j1Di
         yBoZyrLw4JBJivPe7PQWtXtggFxnbBiVSWg2ezaft3DkjzexGzAcC2vQb1onGl0Gv70E
         6pIQpL1OIYDNKB/5JMr3h4Luc0/q9xelf9S+fUS0ih8d/Jxnwt0VVyVdgw9jq0MitWeg
         YEKA4LyD+0Bbmv776/g2FaINYrGS8WrDHgE9W4vukRMMLU4p+Ah+EpE1+CFTRVINsiWk
         nEiA==
X-Gm-Message-State: AOAM5324qdhk5y69V8N5MAtiS/vHQm6v0yPNsHFw7/CpabGIum856kkh
        ATuExodfMr7mVPDcgitba/UfyfsJ1Z5aK3UQNKjHuCQ7/e0=
X-Google-Smtp-Source: ABdhPJxLH4NwPgybxyJc3zf+Vw6l8yqhY4kTGSGP4F6WDxpSbMp2s207xS2PwLJhrkR2WIa7S4HmB/tf44hkYRq5j7s=
X-Received: by 2002:a05:6902:50b:: with SMTP id x11mr27425126ybs.133.1624221490461;
 Sun, 20 Jun 2021 13:38:10 -0700 (PDT)
MIME-Version: 1.0
From:   Nathan Dehnel <ncdehnel@gmail.com>
Date:   Sun, 20 Jun 2021 20:37:59 +0000
Message-ID: <CAEEhgEss-SusbDdw1qz-7hB3SbQyWhkYNkVLHdQuE+NhMXe27A@mail.gmail.com>
Subject: Recover from "couldn't read tree root"?
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

A machine failed to boot, so I tried to mount its root partition from
systemrescuecd, which failed:

[ 5404.240019] BTRFS info (device bcache3): disk space caching is enabled
[ 5404.240022] BTRFS info (device bcache3): has skinny extents
[ 5404.243195] BTRFS error (device bcache3): parent transid verify
failed on 3004631449600 wanted 1420882 found 1420435
[ 5404.243279] BTRFS error (device bcache3): parent transid verify
failed on 3004631449600 wanted 1420882 found 1420435
[ 5404.243362] BTRFS error (device bcache3): parent transid verify
failed on 3004631449600 wanted 1420882 found 1420435
[ 5404.243432] BTRFS error (device bcache3): parent transid verify
failed on 3004631449600 wanted 1420882 found 1420435
[ 5404.243435] BTRFS warning (device bcache3): couldn't read tree root
[ 5404.244114] BTRFS error (device bcache3): open_ctree failed

btrfs rescue super-recover -v /dev/bcache0 returned this:

parent transid verify failed on 3004631449600 wanted 1420882 found 1420435
parent transid verify failed on 3004631449600 wanted 1420882 found 1420435
parent transid verify failed on 3004631449600 wanted 1420882 found 1420435
parent transid verify failed on 3004631449600 wanted 1420882 found 1420435
parent transid verify failed on 3004631449600 wanted 1420882 found 1420435
Ignoring transid failure
ERROR: could not setup extent tree
Failed to recover bad superblocks

uname -a:

Linux sysrescue 5.10.34-1-lts #1 SMP Sun, 02 May 2021 12:41:09 +0000
x86_64 GNU/Linux

btrfs --version:

btrfs-progs v5.10.1

btrfs fi show:

Label: none  uuid: 76189222-b60d-4402-a7ff-141f057e8574
        Total devices 10 FS bytes used 1.50TiB
        devid    1 size 931.51GiB used 311.03GiB path /dev/bcache3
        devid    2 size 931.51GiB used 311.00GiB path /dev/bcache2
        devid    3 size 931.51GiB used 311.00GiB path /dev/bcache1
        devid    4 size 931.51GiB used 311.00GiB path /dev/bcache0
        devid    5 size 931.51GiB used 311.00GiB path /dev/bcache4
        devid    6 size 931.51GiB used 311.00GiB path /dev/bcache8
        devid    7 size 931.51GiB used 311.00GiB path /dev/bcache6
        devid    8 size 931.51GiB used 311.03GiB path /dev/bcache9
        devid    9 size 931.51GiB used 311.03GiB path /dev/bcache7
        devid   10 size 931.51GiB used 311.03GiB path /dev/bcache5

Is this filesystem recoverable?

(Sorry, re-sending because I forgot to add a subject)
