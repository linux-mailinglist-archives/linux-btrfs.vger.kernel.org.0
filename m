Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D33221A4BA
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jul 2020 18:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbgGIQYV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Jul 2020 12:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbgGIQYV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Jul 2020 12:24:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B25BC08C5CE
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Jul 2020 09:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=g0Q3noTq2doaY0bD+kfqjR1jrRX9VYpYWv3PM1lHLO4=; b=R7Gql92EYtu/gZhdQc5nDM4yBV
        Xlxid/OvX9HWlaKW4AcB3w6inEeC2gkLGSpyAqktgc7iJ7KLIooh8Qxr9xg8oaQ1OCiyDshjK9m3w
        XDSF7TfsYJehdbj2wwG9g7nNWOmJp+UBavsw9FGZY5t+slaCjt0icFnTqPMiaN4MoXeQhmRIljMte
        Apoq4XmYw/qM9qwFVMvtHT6TP95SF6b86+1xXVL97t7YvTVLkUHVOLwdTPl/jkP2exwSdYdRjITMj
        aWMu3S7Gm2puT6Q1oqTcAdn5VS0yuKuxjTbw7yyILKTBO40UeKiHUtzTyuRlhnuxVAnqV4QybTuSm
        nQsjmFmQ==;
Received: from 089144201169.atnat0010.highway.a1.net ([89.144.201.169] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jtZLP-0008BD-35; Thu, 09 Jul 2020 16:24:19 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Andy Lavr <andy.lavr@gmail.com>
Subject: [PATCH] btrfs: wire up iter_file_splice_write
Date:   Thu,  9 Jul 2020 18:22:06 +0200
Message-Id: <20200709162206.113927-1-hch@lst.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs implements the iter_write op and thus can use the more efficient
iov_iter based splice implementation.  For now falling back to the less
efficient default is pretty harmless, but I have a pending series that
removes the default, and thus would cause btrfs to not support splice
at all.

Reported-by: Andy Lavr <andy.lavr@gmail.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Andy Lavr <andy.lavr@gmail.com>
---
 fs/btrfs/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 2520605afc256e..b0d2c976587e52 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3509,6 +3509,7 @@ const struct file_operations btrfs_file_operations = {
 	.read_iter      = generic_file_read_iter,
 	.splice_read	= generic_file_splice_read,
 	.write_iter	= btrfs_file_write_iter,
+	.splice_write	= iter_file_splice_write,
 	.mmap		= btrfs_file_mmap,
 	.open		= btrfs_file_open,
 	.release	= btrfs_release_file,
-- 
2.26.2

