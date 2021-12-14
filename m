Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6A60473B60
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Dec 2021 04:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbhLNDPP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Dec 2021 22:15:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbhLNDPO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Dec 2021 22:15:14 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FCB5C061574
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Dec 2021 19:15:14 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id f186so43106958ybg.2
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Dec 2021 19:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F0LbXaOM6BhSyBylrT+7glmMcsVu4gMBF0LXhA4v0Ts=;
        b=7vb2wcP1KrOo5oyDkeChx/SiiXIjehUcs9e86ujnEZhsViNMZYgfCVttqz1jVCID3Y
         J7cuxQkcLFshBKFEp9hP38ig+X9PbwitQEQR5hRzCaHUK7otg8yzOS1Iwpf/8bX8j/8W
         3eSSNpajAVc6EqhAuCQQr2/ROoHWjAQCq1yW/22uMwifXeX5qq5bdp7eTXqXorP813A0
         SnbAaeVntePaifiUFuE6js70O3Ok4IItqce459O7gMBQTs44/sQm7MAx0PGNHmGsi3du
         72fafrERkEYfnSnUTDSUeiPzwe7Vc/WSdE+Knk9pDlV3D4rYQCGM0Vok6LTZR9l6vjMU
         u4jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F0LbXaOM6BhSyBylrT+7glmMcsVu4gMBF0LXhA4v0Ts=;
        b=zxK/zBDemXuERnuOyQ9g4v4ffxWs4d/GHe6/jucCIZq2R1FcFvj/phDY4uElkphxhE
         toHxEhEja4Z/0st0DRWaA4jXfIwqyADkuMXapBLulf1UR5f7a90Bej9qY0n+gwswXfBI
         i+XPIVi+nJhUj5+bhuROV4PdSzzq0/O8siXjDflvv6D10cui5hMfAM2CAwVrU+YgfdVp
         iRxAu1uDrpbago0NUEA/4o+Sr+T5bT2LnDejw94q442vzTLZt4BFoUywxzi6sZKTNk8H
         XHfP0VGfkOf1zNsvQ7zTn7+fV7yjgSaY5oo9JRRs+RqwtKhWL7YTdClEyiqO8DQ3vlwf
         LBVg==
X-Gm-Message-State: AOAM530Kbg4qVb61DS9T5BI22pJt6KgxmwFuxyrZYWArZfV1XsIXrvtr
        LF7Bkr20kZd6j/u9JLIIuOOw2quupqXhDm06iLzbRQ==
X-Google-Smtp-Source: ABdhPJzCkEKU0fcDgzVV00FbED6lLDy9SdC1X7Nt8PjqWcAWlRjiuI01qO3qcxCnsX9jgsYTIjU0ApYYbkjwBhZrmSU=
X-Received: by 2002:a25:6152:: with SMTP id v79mr2892127ybb.400.1639451713524;
 Mon, 13 Dec 2021 19:15:13 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtT+RSzpUjbMq+UfzNUMe1X5+1G+DnAGbHC=OZ=iRS24jg@mail.gmail.com>
In-Reply-To: <CAJCQCtT+RSzpUjbMq+UfzNUMe1X5+1G+DnAGbHC=OZ=iRS24jg@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 13 Dec 2021 22:14:57 -0500
Message-ID: <CAJCQCtT4VLkjLqwNUKJMTvYPH6rsQomDX7UAb0iYoWv-M8iOCw@mail.gmail.com>
Subject: Re: 5.16.0-0.rc5, btrfs-transacti:9822 blocked, write time tree block
 corruption, parent transid verify failed, error in free_log_tree, forced ro
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I can't tell for sure which Btrfs file system is the instigator. But
looks to me like it stalled pretty soon after I mounted this
/dev/loop0 Btrfs. The stack is:

NVMe->plain partition->Btrfs->nodatacow file->LUKS/dmcrypt->Btrfs

Dec 13 21:39:42 kernel: loop0: detected capacity change from 0 to 2097152
Dec 13 21:39:42 kernel: BTRFS: device fsid
a1510170-f603-4015-b7f0-2731c85504a6 devid 1 transid 91448 /dev/dm-0
scanned by systemd-udevd (9795)
Dec 13 21:39:44 kernel: BTRFS info (device dm-0): use zstd compression, level 1
Dec 13 21:39:44 kernel: BTRFS info (device dm-0): using free space tree
Dec 13 21:39:44 kernel: BTRFS info (device dm-0): has skinny extents
Dec 13 21:39:44 kernel: BTRFS info (device dm-0): enabling ssd optimizations
...
Dec 13 21:42:47 kernel: INFO: task btrfs-transacti:9822 blocked for
more than 122 seconds.
Dec 13 21:42:47 kernel:       Tainted: G        W        --------- ---
 5.16.0-0.rc5.35.fc36.x86_64+debug #1


--
Chris Murphy
