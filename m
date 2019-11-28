Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9C310C230
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Nov 2019 03:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729726AbfK1CP2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Nov 2019 21:15:28 -0500
Received: from mail-ed1-f47.google.com ([209.85.208.47]:39339 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729712AbfK1CP1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Nov 2019 21:15:27 -0500
Received: by mail-ed1-f47.google.com with SMTP id n26so21386190edw.6
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Nov 2019 18:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=AlvT/gXGaNjJIJcQ+oRj+IE7m63D8+FDsVkU0hwwT/E=;
        b=TG+3Bj+pItDMzaR9hMdrda2+zIpx/equOkxon593EpeFDUC5pd8dMNG+q+LVJGoANc
         QYaYxwKoxSDXH6iNGzfGH2r+mJxB/8hdMx3NXtZPGXT66Ho7tzpBGSVB/K/jp0rVouYa
         fFbDdXfKCDfILXJxXKAFyAwDR7Y6YsmH0KCNZmJyKBJUGisQM+UYs8lPRzIxIEn+l4vs
         yKUckMb69dH1NquJjsK0BHSG+GhDCctAxBpHWX1egj3XIzx2j0gW2r7xGSmiOU7stijD
         +NmN15rtYB/x4eCQ2S3QwPqHTi8ik8fQbrzVMmXEfr7VhhqzeJ8W7rfc6cTi5APpK7Xa
         BHyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=AlvT/gXGaNjJIJcQ+oRj+IE7m63D8+FDsVkU0hwwT/E=;
        b=NlXQd59zS6uh9BNIoWheSg34DdsPyIPk4lFP9yJe5xDyu3cmizx1RUF73RFf01HPes
         a2XGxmlkCOkz5h31PO+tOiJqfvYu/Ui1K8INPW5zAJz53z+zRXe2/d9R2aA4RXwlcggA
         Q1F/ox4zf1zBbVgyvTKTygTGE5Xb9Y7QhZX1+c7/A5/z8fKoj0PQkoBwl0wXa35TmtKQ
         wbQlGnnzDThAx43dh/83c+o7CKCCaiK2wAkLpzUNMCBMn8pbHX7u7qFQkglbGt7JDBgP
         Z7zWKt80j1zSLcFsQKDiSkiC22aIvuowu3ai7z7NaaxbIKOiSXhH6m3u9w0H+/UiPdj5
         VcSQ==
X-Gm-Message-State: APjAAAXdZ35GNEOVg/hd5aHoIQYLARgrcduhNsax9flUTnvKQ1cGZkcD
        Np8uACgpZiO2KCBusHbVNwckh3gtGQm0jWFX8koGdlzU
X-Google-Smtp-Source: APXvYqygpeGuDAQQei7W1NQLgFmdcq9tdtTQIsL85X2sDNmxOISNYe6jsqdYrjORAytXJC8bBn2nGpgeICJjyMggquo=
X-Received: by 2002:a17:906:80c:: with SMTP id e12mr53063026ejd.59.1574907325900;
 Wed, 27 Nov 2019 18:15:25 -0800 (PST)
MIME-Version: 1.0
From:   Meng Xu <mengxu.gatech@gmail.com>
Date:   Wed, 27 Nov 2019 21:15:15 -0500
Message-ID: <CAAwBoOKOAUf4KqmpTE+FFU4wz7nL9wO2HyjsiH5=1CL0HRkuSQ@mail.gmail.com>
Subject: Possible data race on btrfs_set_block_group_used(&cache->item, ...)
 when two syncfs runs in parallel
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Btrfs Developer,

I am writing to report a data race between
btrfs_set_block_group_used(&cache->item, ...) and memcpy() while both
threads are running syncfs. Following is the call stack observed at
run time. I can confirm that the order of the [READ] and [WRITE]
statements are not deterministic.

[Setup]
create("bar", 511) = 3;
dup2(3, 198) = 198;
open("baz", 2097152, 511) = 4;


[Thread 1]
syncfs(4);

__do_sys_syncfs
  sync_filesystem
    __sync_filesystem
      btrfs_sync_fs
        btrfs_commit_transaction
          btrfs_start_dirty_block_groups
            write_one_cache_group
              write_extent_buffer
                [READ] memcpy(kaddr + offset, src, cur)  (src is the
pointer read)


[Thread 2]
syncfs(198);

__do_sys_syncfs
  sync_filesystem
    __sync_filesystem
      btrfs_sync_fs
        btrfs_commit_transaction
          btrfs_run_delayed_refs
            __btrfs_run_delayed_refs
               btrfs_run_delayed_refs_for_head
                 run_one_delayed_ref
                   run_delayed_tree_ref
                     alloc_reserved_tree_block
                       btrfs_update_block_group
                         btrfs_set_block_group_used
                           [WRITE]
btrfs_set_block_group_used(&cache->item, old_val);

Would you mind confirming whether this is a valid data race and
whether this might lead to inconsistent states on disk?

Best Regards,
Meng
