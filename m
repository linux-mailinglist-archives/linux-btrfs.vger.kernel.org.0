Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF97265FB
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 May 2019 16:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbfEVOia (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 May 2019 10:38:30 -0400
Received: from mail-yb1-f181.google.com ([209.85.219.181]:32796 "EHLO
        mail-yb1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728111AbfEVOia (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 May 2019 10:38:30 -0400
Received: by mail-yb1-f181.google.com with SMTP id k128so959426ybf.0
        for <linux-btrfs@vger.kernel.org>; Wed, 22 May 2019 07:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=pr7tTlRV9n8pmJmeCdZJFcWhjeNrlMTP6A1L7nu0G8s=;
        b=PXn9XFksJ+S5t/49WEmSZXGy03d06EOkfewhOIAdGLfxkOzGXr587La28PnISJLm1J
         CeC2LpYNQe+tr5BKSAXN0XqEwfrJPdHW/PhOW38GOI2bWETG7V0DLNLZPIJW7BxNvVJQ
         RFn6GSPpanUCcj5MHbGHSSeUSWiUTULdMoFjPnELCbZ/Dse979jQkmhUogx3QL/7qOrI
         TqX6zvIa3WvGqr2XSkfQk8zYhaFAitlO9x+9dzq/chnx3+zBChGhjRjg97uYEEw1y+Pa
         cyWPQJZO/npJMr9O0Tg683GixxAOGRGZ66N+ySaLGto3zWgiqa1r639vrWsGp9vQdum2
         n4Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=pr7tTlRV9n8pmJmeCdZJFcWhjeNrlMTP6A1L7nu0G8s=;
        b=kKAfjb1FxCZpsTOA+UP9LwR31VgWnpo9Xm5V8v0VGJd0fyvGTFtK1gl/fyo5NfRAK1
         DZP3c9jg5bWN5+TV99na17yr6pCtXvdXcLpGbC+xoPWUNqlQZ0InRsjuwP+lpourBKl2
         5xC31Mdn9v8sUg0n6Aq4XD0yV+DCvA/4op0cqEvkUpK3zCDgr4n7w64+5ISJ6hwUKDg0
         AOa6t3tfDW7mwSkn5ijo+mq+GR28xEA6FrMCkW8itu7ELQ+cVA56f1eUnFNp9/rnSAmO
         gfCkP49l+7IlLwSm04WsxPTebdIcZwZ0LxPVvKGEr2R/PoliPbZax/Gg86hcUPdrcmpU
         cpnA==
X-Gm-Message-State: APjAAAUQz27fKSrMjQleKAS+VdbRb85HtR1CHQXp/Dy+ev7WK6sHv/F4
        QmF/fYqXNFS6gIwsK/Cxz9gWLuGRorEvYiGvUBoSJk0wRw==
X-Google-Smtp-Source: APXvYqyCru3emtzurH9M/oRDjFTCC7synomKvA5fVPpf8+OKYPFbGnYlTAzkZw3uhnrzvi7Pnz0RffUCsFlb3Xyiaa4=
X-Received: by 2002:a25:ba8c:: with SMTP id s12mr20683855ybg.431.1558535909571;
 Wed, 22 May 2019 07:38:29 -0700 (PDT)
MIME-Version: 1.0
From:   Daniel Martinez <danielsmartinez@gmail.com>
Date:   Wed, 22 May 2019 11:37:52 -0300
Message-ID: <CAMmfObYRT=WV1OzcjTo7OLXc1yEaTY5dncZj_ARvRrDHDtB=Bg@mail.gmail.com>
Subject: btrfs-convert with --no-datasum and --no-inline. How can I enable
 those features now?
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

I've converted an ext4 filesystem (after a few attempts, and after
rolling back to a system running both the kernel and btrfs-progs 4.12)
to a single disk btrfs filesystem, but to do so I needed to disable
data checksums and small file inlining, otherwise I would get ENOSPC.

Now that I've defragged everything, I want to enable those features
back for all the existing files (datasums mainly). How can I go about
doing that?

I assume `--init-csum-tree` would recreate the checksums, but will it
also set the appropriate flags so that all new files in all
subdirectories have checksums aswell?

When I tried to run it (back on 4.19 kernel and btrfs-progs 4.20), it
ran for a few hours and then gave me this error:

Creating a new CRC tree
Opening filesystem to check...
Checking filesystem on /dev/sdb2
UUID: eb930a78-f6f7-4552-8200-6ebdd6c56b93
Reinitialize checksum tree
Unable to find block group for 0
Unable to find block group for 0
Unable to find block group for 0
ctree.c:2245: split_leaf: BUG_ON `1` triggered, value 1
btrfs(+0x141e9)[0x55d3c529d1e9]
btrfs(+0x14284)[0x55d3c529d284]
btrfs(+0x169ad)[0x55d3c529f9ad]
btrfs(btrfs_search_slot+0xf24)[0x55d3c52a0f9f]
btrfs(btrfs_csum_file_block+0x25f)[0x55d3c52ae888]
btrfs(+0x4aa30)[0x55d3c52d3a30]
btrfs(cmd_check+0x10b1)[0x55d3c52dfc9e]
btrfs(main+0x1f3)[0x55d3c529ce63]
/lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xeb)[0x7f2eb872309b]
btrfs(_start+0x2a)[0x55d3c529ceaa]
Aborted

Did this actually generate checksums for some files and then stop, or
was nothing written at all? How can I verify checksums are calculated
and enabled, or otherwise make sure its working as intended?
