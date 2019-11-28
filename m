Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38CEF10C3BB
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Nov 2019 06:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfK1FbC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Nov 2019 00:31:02 -0500
Received: from mail-ed1-f44.google.com ([209.85.208.44]:40908 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbfK1FbB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Nov 2019 00:31:01 -0500
Received: by mail-ed1-f44.google.com with SMTP id p59so21686461edp.7
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Nov 2019 21:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=S3OzoTWOroaiWXdIgsq2kez4CqjsEW76UhmY/jecQJg=;
        b=MJitl2OMKcv2ZroiL9YV9XU4lru77tBx4Yaqp84zvxDcbqkAcYP3TNghGyB+5uHQMu
         Pa9WLz3oYv6e6HJWvK4g9vzjYAIMRe3DtzyK0JXEo/p0kfOGlE7hDydbnCIL7ZMjd5bh
         GbvgkMAGmESJZ443mJDGY7RcOquSl8wEBH6oyymxeVv83DZfJzhSrH8RhOcKWLWp7qZ7
         fEfzrNLwod4d9t311uuP64JqfejqbBbpjwDikoZZtx0fYF3vdB446wDvoCHWth+IT2GL
         AfUMqWBSe9hp3Ih3i3MXBnr2uFb+PbiYdpj02viqLiRPqSqI2tR65Ra3Tfjr194UoJco
         /AiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=S3OzoTWOroaiWXdIgsq2kez4CqjsEW76UhmY/jecQJg=;
        b=NRVMqAEqWsjTjWKY/h+37E5fUfGDpuhoxFxsn6ttbselR3Dv6YpQXPkwWTV6btmOMS
         P5tuXoYLpZyjYb4eCs06G+IczFclp6FVjFieEiTXb074r+plNJN2eQ+rZc1dEykqqTlk
         8w3hrRb9+0RZilUmJ6Nu+rFlaWYho1osG2qlF4Jk4nCYurF5jHdBf8MmJX/qTLoQVSnY
         WEHHz8ZkxcW0b3AiOoQsS2VPtOZ4yFVV0m4hvzm6uHH/6ZK4EnDwBdjCS9AXLZ9rcLaJ
         1DPr3W0lU5xiZKf8Ok30vVx1kawYEmDCGKI4BFTAPyTxdZOggao2plfh8r8n7cnhdt+M
         eU9w==
X-Gm-Message-State: APjAAAUVfe+2K9WIg8CjFRVmqTU0mtcxRJi52WuMzi5pRkbhcbLzY/Xe
        F8stKlrSd0jGyTdC2nxF6/2n2rluK2RxneYTdjGsH4MX
X-Google-Smtp-Source: APXvYqxrApLT/fREd3zuErkAdd83yGcR9ZNUReXcfH70EmFRk1bvOUtqw+QMIsjOutdc6CGYkLW7yzHjjMf1fu5b0LQ=
X-Received: by 2002:a17:906:5246:: with SMTP id y6mr53828040ejm.330.1574919059948;
 Wed, 27 Nov 2019 21:30:59 -0800 (PST)
MIME-Version: 1.0
From:   Meng Xu <mengxu.gatech@gmail.com>
Date:   Thu, 28 Nov 2019 00:30:49 -0500
Message-ID: <CAAwBoOLzHjTL97oHXCs+j_4nuAWaB9gGENd=wCa5sj8fHL-d-Q@mail.gmail.com>
Subject: potential data race on BTRFS_I(inode)->root->last_log_commit when
 adding inode while fdatasync
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Btrfs Developers,

While fuzzing btrfs I notice a potential data race on
BTRFS_I(inode)->root->last_log_commit and log_transid when an inode is
being added and fdatasync-ed at the same time. Following is the
execution trace:

[Setup]
mkdir("foo", 511) = 0;
open("foo", 65536, 511) = 3;

[Thread 1]
mkdirat(-100, "bar", 246);

__do_sys_mkdirat
  do_mkdirat
    vfs_mkdir
      btrfs_mkdir
        btrfs_new_inode
          btrfs_set_inode_last_trans
            [READ] BTRFS_I(inode)->last_sub_trans =
BTRFS_I(inode)->root->log_transid;

           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
            [READ] BTRFS_I(inode)->last_log_commit =
BTRFS_I(inode)->root->last_log_commit;

             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^



[Thread 2]
fdatasync(3);

__do_sys_fdatasync
  do_fsync
    vfs_fsync
      vfs_fsync_range
        btrfs_sync_file
          btrfs_log_dentry_safe
            btrfs_log_inode_parent
              start_log_trans
                btrfs_add_log_tree
                  [WRITE] root->log_transid = 0;
                  [WRITE] root->last_log_commit = 0;


The trace seems fine based on the program order. However, if adding
the memory model into consideration, i.e., the inter-leavings of the
writes and reads, it is possible that the two [READ] receives
inconsistent information about BTRFS_I(inode)->root->*. For example,
BTRFS_I(inode)->root->log_transid is 0 while
BTRFS_I(inode)->root->last_log_commit is a stale value (or the other
way round). This may have a negative impact when persisting the
mkdirat-created inode?

Best Regards,
Meng
