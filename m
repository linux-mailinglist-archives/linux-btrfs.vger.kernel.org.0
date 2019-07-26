Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33B4077172
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2019 20:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388135AbfGZSnn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Jul 2019 14:43:43 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:46195 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387440AbfGZSnn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Jul 2019 14:43:43 -0400
Received: by mail-wr1-f48.google.com with SMTP id z1so55383184wru.13
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2019 11:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=rKFdfrZnKwvV47yr51OW9jjzCxaEzCl7Vn56a1F/ZZM=;
        b=QNuIK0SfPpxuKdfY5lN11YIW6LkO4cACWsyPt0uoWmqtEWMhYCw+jV/yUwuy/jf5+I
         Iz2SaqOHwhlL+naRCYgWAyKwHVVTnowyEZEhzo2BIzTX+sM5O1QPjUwBFV5uXamiQCkH
         9hq3HWrpxZkg9Ffygp/ATI/49ud/3pog1p4yw63KKwSDsQ1iHMTLCA8ZqAxilzHh1buO
         Y1+j4r9w1q9POpS6OzGG7WyH1WMv4TA8j+mkzxEnJz4jkj3n6HP3lQPfJujxUeaPtn8g
         qqwlV9qmenTM4mM5q5NuOWgLJTzleaxTuDauF1fN6W3M+JWRY3UQl+/IG1S08nLTiu1O
         pMrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=rKFdfrZnKwvV47yr51OW9jjzCxaEzCl7Vn56a1F/ZZM=;
        b=sAj5Xvu2yUeqrf5UoCmQlvaVSqGof8uYPCXq1zjsXTp7j3ezV/8Lm+KyWzacXHOCEY
         eCIOjuyBaxRoiOZzTA0RS8j/7ifACazLSZktSk45RzOBJfVbyQVNWffVREoH+8s+GEOG
         eTX8eQz4N1olFyA4wO4VVLkCpEV1Bcyt3EDwvekJ1uHGrNf9S9isEDnkdVmRhHFPdSvg
         7KaG0Tyzy3g1FiYRIwZ3MziSOSa6RELAYwSrpPBS5xXWv0vp6rK2ApcJa791W3wBXQba
         qVN6PNeL+hZcIDYVHTccHBrqAd4WQltEqt9AecFlFwQGHvShoB8BFEqc/LhH4GN1niMy
         MNTg==
X-Gm-Message-State: APjAAAXEaTKIREjceeF5x1Y81lYD3nZ6f2sMryQjKLpl2TTSQTmwCdKG
        dRv6q1s70Hz37GGp56ncNBPnIgytoK3arTniSSQG7NbVd/s=
X-Google-Smtp-Source: APXvYqyjzpxhKndLLfC5BnX7tMRa6nFgdnt9zJemjkmwY9IZFvwoJ4/nil+KA89CQsiy9tZ7Go4bszqjDrOFkeIKI7c=
X-Received: by 2002:adf:f851:: with SMTP id d17mr103773206wrq.77.1564166621083;
 Fri, 26 Jul 2019 11:43:41 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Murphy <lists@colorremedies.com>
Date:   Fri, 26 Jul 2019 12:43:30 -0600
Message-ID: <CAJCQCtRGNrKDBBFOZ3=Say=STMBAGMNKBwe4xsdJZL7mCRw98g@mail.gmail.com>
Subject: 5.3.0-0.rc1 various tasks blocked for more than 120 seconds
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Seeing this with Fedora kernel 5.3.0-0.rc1.git3.1.fc31.x86_64 which
translates to git bed38c3e2dca

It's causing automated OS installations to hang indefinitely, only on
Btrfs. This is an excerpt of the first of many call traces:

15:52:20,316 ERR kernel:INFO: task kworker/u4:0:7 blocked for more
than 122 seconds.
15:52:20,316 ERR kernel:      Not tainted 5.3.0-0.rc1.git3.1.fc31.x86_64 #1
15:52:20,316 ERR kernel:"echo 0 >
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
15:52:20,316 INFO kernel:kworker/u4:0    D12192     7      2 0x80004000
15:52:20,317 INFO kernel:Workqueue: btrfs-endio-write
btrfs_endio_write_helper [btrfs]
15:52:20,317 WARNING kernel:Call Trace:
15:52:20,317 WARNING kernel: ? __schedule+0x352/0x900
15:52:20,317 WARNING kernel: schedule+0x3a/0xb0
15:52:20,317 WARNING kernel: btrfs_tree_read_lock+0xa3/0x260 [btrfs]
15:52:20,317 WARNING kernel: ? finish_wait+0x90/0x90
15:52:20,317 WARNING kernel: btrfs_read_lock_root_node+0x2f/0x40 [btrfs]
15:52:20,317 WARNING kernel: btrfs_search_slot+0x601/0x9d0 [btrfs]
15:52:20,317 WARNING kernel: btrfs_lookup_file_extent+0x4c/0x70 [btrfs]
15:52:20,317 WARNING kernel: __btrfs_drop_extents+0x16e/0xe00 [btrfs]
15:52:20,317 WARNING kernel: ? __set_extent_bit+0x55f/0x6a0 [btrfs]
15:52:20,317 WARNING kernel: ? kmem_cache_free+0x368/0x420
15:52:20,318 WARNING kernel:
insert_reserved_file_extent.constprop.0+0x93/0x2e0 [btrfs]
15:52:20,318 WARNING kernel: ? start_transaction+0x95/0x4e0 [btrfs]
15:52:20,318 WARNING kernel: btrfs_finish_ordered_io+0x3da/0x840 [btrfs]
15:52:20,318 WARNING kernel: normal_work_helper+0xd7/0x500 [btrfs]
15:52:20,318 WARNING kernel: process_one_work+0x272/0x5a0
15:52:20,318 WARNING kernel: worker_thread+0x50/0x3b0
15:52:20,318 WARNING kernel: kthread+0x108/0x140
15:52:20,318 WARNING kernel: ? process_one_work+0x5a0/0x5a0
15:52:20,318 WARNING kernel: ? kthread_park+0x80/0x80
15:52:20,318 WARNING kernel: ret_from_fork+0x3a/0x50
15:52:20,318 ERR kernel:INFO: task kworker/u4:1:31 blocked for more
than 122 seconds.


The full log is here:
https://openqa.fedoraproject.org/tests/426671/file/_do_install_and_reboot-syslog


-- 
Chris Murphy
