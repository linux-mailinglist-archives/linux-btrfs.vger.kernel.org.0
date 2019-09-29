Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4F3BC19B7
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Sep 2019 00:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbfI2WLO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 29 Sep 2019 18:11:14 -0400
Received: from mail-oi1-f169.google.com ([209.85.167.169]:33350 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfI2WLO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 29 Sep 2019 18:11:14 -0400
Received: by mail-oi1-f169.google.com with SMTP id e18so9512824oii.0
        for <linux-btrfs@vger.kernel.org>; Sun, 29 Sep 2019 15:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=havIgu4geXYv4TQskqDmQtUxur0hs3+cSWcpbXXJJzo=;
        b=lE5sbMqKBHiGGFEb337R+3T/n1UeVKSY+NnRKjtLql+4pN7vcsHhOcau3+WcxRqSIx
         DxJKmfNVLKtdjrzStC+3Niw0ShvwDvKokbebUYLdAWFzZAjFqSgmhZZJsjlMkJ9oxSQy
         Bxe9Tgnj3+HNhTwBKyHhCOwYyPtcF7uZgYsYUGEV6v3kW6pXr6iRVkwtsj1imGNlZYnK
         ybq/nmyAnOXqan6YBLCNKDnrxXR2iOzL4N9FT7vuedZBdL93hEtonAjBVuSwp9wCJ+ZL
         Vb6Kd63s2ctseIu632VVvN+WdvAr0Jc+m36BTZ9oAfPidcBkhhkvsrMyGLCKCPvcfOHj
         SwQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=havIgu4geXYv4TQskqDmQtUxur0hs3+cSWcpbXXJJzo=;
        b=rcYtJ/ThPAKV0DnBs+tPkS0YQFF3WrgHnPqIm87wsHat70vpUxso7CKnvdHbVp9LM2
         Y5/ZJ66Zepr0yvzsZvm+CAwfSjsuRIjsfgnKeUqrGtpRKKS2/VFBGO3WeQbWtNQ53bmF
         4h4vhMfLYwlA4JiUpFZ43tD7bEFzyXoJx9K495DSz6PEZZvev4o0zgXE6/CH9FQlfcoJ
         BSoau6/hE4hc4HsgwlL6F0AkWS21oPiZbL7JOkH+Cg7WFRdnOshe5HZSFRjqFnQJMPEp
         rmuEAgtbpA4h32XGVz3tsr5kmsr1Ofdpk22KP+CdAxA3QaTA6yRFUBlysWup0OzxrqBe
         4H0Q==
X-Gm-Message-State: APjAAAUFkjbmSm7myzDoEkUSw7rXrN/REAtcQMnnwagzrKRriPeTBRo/
        c9/6EwirvYe3m6CW2xZE2jLyuz4BvgZc25akkac6MzCr
X-Google-Smtp-Source: APXvYqxTnGjL9diYnss9tHt9SYE+TiVh1jQRUTb9rSkp2LV9rA5zSzIWUUrgrg8EJcTy+93BCuqIrT2FfX18p8asHl8=
X-Received: by 2002:aca:4bc4:: with SMTP id y187mr15887346oia.80.1569795072720;
 Sun, 29 Sep 2019 15:11:12 -0700 (PDT)
MIME-Version: 1.0
From:   Andrew Nelson <andrew.s.nelson@gmail.com>
Date:   Sun, 29 Sep 2019 15:11:00 -0700
Message-ID: <CAPTELemSEXCsqXUBxh0c=qR2rWP+EUaN9qDYOb5m=g-Ujuyupw@mail.gmail.com>
Subject: Btrfs volume seems to hang with any kernel newer than 4.20
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is on a Fedora 30 system. I have tested with both 5.1 and 5.2
with the same result. Kernels 4.20 and older have worked fine. Not
sure where to start debugging the issue. Here is an example stack of
Vim hanging when trying to do a write to the filesystem.

[<0>] pagecache_get_page+0x196/0x370
[<0>] io_ctl_prepare_pages+0x4b/0x140 [btrfs]
[<0>] __load_free_space_cache+0x1e1/0x600 [btrfs]
[<0>] load_free_space_cache+0xc1/0x170 [btrfs]
[<0>] cache_block_group+0x1b4/0x3d0 [btrfs]
[<0>] find_free_extent+0x901/0xff0 [btrfs]
[<0>] btrfs_reserve_extent+0xea/0x190 [btrfs]
[<0>] __btrfs_prealloc_file_range+0x11d/0x490 [btrfs]
[<0>] cache_save_setup+0x229/0x3d0 [btrfs]
[<0>] btrfs_start_dirty_block_groups+0x1e2/0x4d0 [btrfs]
[<0>] btrfs_commit_transaction+0xba/0x9a0 [btrfs]
[<0>] btrfs_sync_file+0x32b/0x420 [btrfs]
[<0>] do_fsync+0x38/0x70
[<0>] __x64_sys_fsync+0x10/0x20
[<0>] do_syscall_64+0x5f/0x1a0
[<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
