Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 635E37A46B7
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Sep 2023 12:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234383AbjIRKNk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Sep 2023 06:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237946AbjIRKNL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Sep 2023 06:13:11 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8489B
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Sep 2023 03:13:05 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c00b37ad84so12934491fa.0
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Sep 2023 03:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695031983; x=1695636783; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C+PyXWdgD5/uPeMrdfSfwuF3t3IgKgV8K0Fl6FKPWU8=;
        b=Y5JFPsT/KVBJkMRzSQF0H1dpY7nsiCw+0hhElRUXkLJ8m+O67PWT/hcoPqazvpB0GD
         J3WKQmjT9YYcXFSSPq7b7wUxLZ3xQgJcTrjwbV/7TlE3LOey+xI6vHbWaSUgC6EagKAW
         8pFnEq8kNmam3AK3ZvaELu/5R9eCwn06IMDq+m64xMmNGfKDrZuF4at/bRb96gQrUC9c
         tQpkPbz7hDudXmDiPx8GEtPW53IQTA+Cx0olbpQNUxW8ppjywMk17i3V3rNmNTwJLmnA
         a0/PYxvAUNyJduoWiGz1J0MsJWJzeLp+2E46N/leZLu/JFQwymlWu76RynJIjSspXxpP
         q+EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695031983; x=1695636783;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C+PyXWdgD5/uPeMrdfSfwuF3t3IgKgV8K0Fl6FKPWU8=;
        b=FFXQKlXNFM6WtXwUBn5raVRiLiaBzN+e0Bgf5E8pm2qd1zL+V+sN2YoKARugsTrYkY
         4gYgxSjgtck89cGhYVw4QBJbnNhxPt560DA/Gn0oPYVpfdB/bx2XwmQDjX3LFDmuz1d3
         qEZRLrXYNCsh9/Pccl6qT75p7cumBeqDL+qxKRWaKfEm8T0rIgNjzSVrXMlE92LFCHnb
         AlMdcQJmev1Ftzb9d1sfDN8sc//WfX67/h1G7T/qNtW4+n7S5V5bMzGiK13ZouYwpMfd
         pDkDbZp+7zOEnFfqatfTJmvu538enjXDBBNr3NQ4G76jI17IZ4thIWa/3ZOJJ4JM+g1U
         XLCA==
X-Gm-Message-State: AOJu0YyXCv51bWNS5+EvD+ERej77HJOhq/UJsmWwufwwLczWJNv1smZp
        zM7wfOxZJpfMlfiPVOOprIZgZ9euI1lk3gJs9C+m4/KZ/DmvkR0=
X-Google-Smtp-Source: AGHT+IFMFRFd4U0RRKyLqIopNF9qeo8UKRo+qkyBVGYcrO/9H1rdTmBmN501gx9hJraRvaPSp4N4UgkGpS9Aoi7ZCFg=
X-Received: by 2002:a2e:a372:0:b0:2bf:f133:62e5 with SMTP id
 i18-20020a2ea372000000b002bff13362e5mr4044907ljn.50.1695031982873; Mon, 18
 Sep 2023 03:13:02 -0700 (PDT)
MIME-Version: 1.0
From:   Antoine Bolvy <antoine.bolvy@gmail.com>
Date:   Mon, 18 Sep 2023 12:12:51 +0200
Message-ID: <CADg0FA-U2U_s30RpoyCm-F5F7NYGDcAbowA39u=wV-4Z3cJNhQ@mail.gmail.com>
Subject: Help with "parent transid verify failed"
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

This is the third (I think?) time on this laptop (6-month-old, DELL XPS with
nvme SSD) that the system gets readonly. Usually I don't notice right away and
the system locks up, but this time I managed to get the following from dmesg:

[...] Nothing special
BTRFS error (device dm-0): parent transid verify failed on logical
413445128192 mirror @ wanted 628190 found 627968
BTRFS error (device dm-0): failed to run delayed ref for logical
112333930496 num_bytes 102400 type 178 action 1 ref_mod 1: -5
BTRFS: error (device dm-0: state A) in btrfs_run_delayed_refs:2144:
errno=-5 IO failure
BTRFS info (device dm-0: state EA): forced readonly
[...] Nothing special and obvious errors about system being readonly

After rebooting, the system mounts and boots fine. Note the FS is under a LUKS
container.

I've ran `btrfs check --force` (after carefully reading the manual) on the
mounted drive, but after setting the FS to being readonly:

$ sudo btrfs prop set / ro true

$ sudo btrfs check --force /dev/mapper/cryptroot
Opening filesystem to check...
WARNING: filesystem mounted, continuing because of --force
Checking filesystem on /dev/mapper/cryptroot
UUID: 4be6f5de-1e3e-420d-9099-97950733b482
[1/7] checking root items
[2/7] checking extents
[3/7] checking free space cache
[4/7] checking fs roots
root 257 inode 881855 errors 200, dir isize wrong
    unresolved ref dir 881855 index 471 namelen 13 name login.keyring
filetype 1 errors 5, no dir item, no inode ref
ERROR: errors found in fs roots
found 511072440320 bytes used, error(s) found
total csum bytes: 466646072
total tree bytes: 8946089984
total fs tree bytes: 7916453888
total extent tree bytes: 406454272
btree space waste bytes: 1466008737
file data blocks allocated: 4329978150912
 referenced 625292898304

I've run it twice and got the same error. I'm not sure how to diagnose from
there, and not even sure the two errors are related.

I'm happy to help diagnose further.

$ uname -a
Linux dellxps15 6.1.52-1-lts #1 SMP PREEMPT_DYNAMIC Thu, 07 Sep 2023
05:17:41 +0000 x86_64 GNU/Linux

I've read multiple times that I should contact the developers and never repair
without being asked to; so here am I. This is my first post to a linux mailing
list so please advise if I did anything wrong.

Best regards,
Antoine
