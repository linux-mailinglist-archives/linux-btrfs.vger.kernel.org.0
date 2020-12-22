Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E93F32E05E0
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Dec 2020 07:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725833AbgLVGAQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Dec 2020 01:00:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:35480 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725300AbgLVGAQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Dec 2020 01:00:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1608616770; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZiuLKZnHiGnwAItXBUbWP0W6qOGiq8Ot4ieMMcJ/XQ4=;
        b=L3WcJUvGGv4vzz9CNb/ofRfg8Pez3l+m1iy6xr7SIOsgnAAcBl+ssQUnOia++zt5Z4aWvE
        PNRrGoYOvObYYILi7wnDryTNGjuvSScCFVdsbzB7Bjj8l0jTkMreH5EexAUZW76x5czb1z
        S0nDKCjqmOUp3/09U5mhOL/hUpoRXt0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 21AD0AD4D
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Dec 2020 05:59:30 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/2] btrfs: make btrfs_dio_private::bytes to be u32
Date:   Tue, 22 Dec 2020 13:59:23 +0800
Message-Id: <20201222055924.64724-2-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201222055924.64724-1-wqu@suse.com>
References: <20201222055924.64724-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_dio_private::bytes is only assigned from bio::bi_iter::bi_size,
which is no larger than U32.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/btrfs_inode.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index d9bf53d9ff90..fbd65807f29d 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -325,7 +325,7 @@ struct btrfs_dio_private {
 	struct inode *inode;
 	u64 logical_offset;
 	u64 disk_bytenr;
-	u64 bytes;
+	u32 bytes;
 
 	/*
 	 * References to this structure. There is one reference per in-flight
-- 
2.29.2

