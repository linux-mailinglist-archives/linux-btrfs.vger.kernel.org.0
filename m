Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 383662E8B7A
	for <lists+linux-btrfs@lfdr.de>; Sun,  3 Jan 2021 10:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbhACJ3M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 3 Jan 2021 04:29:12 -0500
Received: from eu-shark2.inbox.eu ([195.216.236.82]:42830 "EHLO
        eu-shark2.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbhACJ3M (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 3 Jan 2021 04:29:12 -0500
Received: from eu-shark2.inbox.eu (localhost [127.0.0.1])
        by eu-shark2-out.inbox.eu (Postfix) with ESMTP id BE7D3450746;
        Sun,  3 Jan 2021 11:28:19 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1609666099; bh=2E+rYFLVJbDWGBazDm+/n6Ljuhktlk2oEp0fETUUeV4=;
        h=From:To:Cc:Subject:Date;
        b=E9F2v5lYoxlpgP3Rw9Dw0R0mJBHBFHt4WQHAeKRi548ReSa4+EGC2o9GWYIYw6JR2
         OOIqJEAXx908jnG5XeW2UcgEaLQHc/onlwuYrfa7fgxzvwYQgHcfBwEVTlIiHI9bbG
         wkL1C8OI0XqiQPoxmyKq30DJRB3JXMZilvbg5jzw=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id ACA6D45073F;
        Sun,  3 Jan 2021 11:28:19 +0200 (EET)
Received: from eu-shark2.inbox.eu ([127.0.0.1])
        by localhost (eu-shark2.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id FhVIaU3pa4Vv; Sun,  3 Jan 2021 11:28:19 +0200 (EET)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id 5965245073C;
        Sun,  3 Jan 2021 11:28:19 +0200 (EET)
Received: from localhost.localdomain (unknown [211.106.132.202])
        (Authenticated sender: l@damenly.su)
        by mail.inbox.eu (Postfix) with ESMTPA id EF9521BE00CF;
        Sun,  3 Jan 2021 11:28:17 +0200 (EET)
From:   Su Yue <l@damenly.su>
To:     linux-btrfs@vger.kernel.org
Cc:     l@damenly.su
Subject: [PATCH v2 0/2] btrfs: fix issues when mouting the poc image
Date:   Sun,  3 Jan 2021 17:28:02 +0800
Message-Id: <20210103092804.756-1-l@damenly.su>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: OK
X-ESPOL: 6N1mlpY3ejOmi1+/QnvYGwc0rTRLXO/5mZO30RtZnXnyMi+AeFR+Lh33wixqPg+1xV0X
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The two patches fix issues found by the image which is provided by
Insu Yun at SSLab@Gatech.

patch 1 fixes a NULL pointer dereference in error handling path.
patch 2 enhances tree checker to detect chunk item end overflow.

Su Yue (2):
  btrfs: prevent NULL pointer dereference in extent_io_tree_panic()
  btrfs: tree-checker: check if chunk item end oveflows

 fs/btrfs/extent_io.c    | 4 +---
 fs/btrfs/tree-checker.c | 7 +++++++
 2 files changed, 8 insertions(+), 3 deletions(-)

-- 
2.29.2

