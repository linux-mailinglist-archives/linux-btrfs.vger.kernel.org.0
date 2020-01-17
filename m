Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9C5140BEA
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 15:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbgAQOCa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 09:02:30 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34350 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgAQOC3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 09:02:29 -0500
Received: by mail-qk1-f194.google.com with SMTP id j9so22765702qkk.1
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 06:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pYAX2OFOHP1myQkDlAK08uSEtgvGOznJlLOPr///aUE=;
        b=h3oQXTUTzg+Ahlc46aRMW5nbZXReqUJsAk0+3tc8gKZFCTdaNU4iWDpdrKLZS8i0xm
         ltXRchZcxri+RXIH2VwZtP4FBSzUcz8FTmXnR88X+LomxklEo672a3ezK9d/ROyEKNr4
         o1ow1XcsgMJKK/LAzKBl8Q4XhUs/itsJW5tHWpfzgyNAk+L69ccav1GjFkI/gdkuuaNh
         h1+XfCNRHZ2L2PwlG/mXzIEkeoMFSr3HL07+OwVuEgrtsqf+0gR/4oYgLkvK+uFfPzDX
         vTzhDjN/FHDAR9Q8Vnh2ux0GHs2TcK3OvJLIvJviGYTjEJIwnIg91GKh4u9B9hBz8bHY
         V5QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pYAX2OFOHP1myQkDlAK08uSEtgvGOznJlLOPr///aUE=;
        b=H+9IaILUUhvWJdn3yqNREMSCmdr9dCwRtUxXay5E+nkZqI5SbY0MJddfACQtmMCpP5
         Rv0QHpG8lmJWRkkmNj+AytErB8t2Mn+Tr1RUg2/QPBdaTPThQQ7awkz0bLaisaTfxKnc
         74GWxv74RRh/nfxnhapW2+WlL/ZMGcBGCCMP6qIV2D1Bs6uFoB/KWFF9p/WWBnOIp/dY
         hvsHnHQnhIFYlPqjBhDeyefrMguGbdotacRzBYgkBeMwIMMhJvH3AtOMpR3a5AZvEJ32
         o4XoLOlihgYhFrd6RUFYKv4QuGbSH/JETn3EFncenkUP/BSzRReI0oxf+qgw8eQ3uUTE
         LLng==
X-Gm-Message-State: APjAAAWfiIX+mfvFNnnGHxoLLfI6EZlKV5OGzH71dLd9wSR32RiwLrIS
        UxQX9ktGZSdwI51YzYAC9UU0jsPxGaW67w==
X-Google-Smtp-Source: APXvYqyEAMMlj7N3Z9/2OxTa6fnf3XAm6hJDF25xSbEkcUunVMSqdo6Dj6CbuzMxMjYXvNTsyjRj0g==
X-Received: by 2002:a37:4b93:: with SMTP id y141mr39993510qka.205.1579269748877;
        Fri, 17 Jan 2020 06:02:28 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id o81sm11802282qke.33.2020.01.17.06.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 06:02:28 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 1/6] btrfs: use btrfs_ordered_update_i_size in clone_finish_inode_update
Date:   Fri, 17 Jan 2020 09:02:19 -0500
Message-Id: <20200117140224.42495-2-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117140224.42495-1-josef@toxicpanda.com>
References: <20200117140224.42495-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We were using btrfs_i_size_write(), which unconditionally jacks up
inode->disk_i_size.  However since clone can operate on ranges we could
have pending ordered extents for a range prior to the start of our clone
operation and thus increase disk_i_size too far and have a hole with no
file extent.

Fix this by using the btrfs_ordered_update_i_size helper which will do
the right thing in the face of pending ordered extents outside of our
clone range.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ioctl.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index ef6c5d672860..db95144e4f22 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3332,8 +3332,10 @@ static int clone_finish_inode_update(struct btrfs_trans_handle *trans,
 	 */
 	if (endoff > destoff + olen)
 		endoff = destoff + olen;
-	if (endoff > inode->i_size)
-		btrfs_i_size_write(BTRFS_I(inode), endoff);
+	if (endoff > inode->i_size) {
+		i_size_write(inode, endoff);
+		btrfs_ordered_update_i_size(inode, endoff, NULL);
+	}
 
 	ret = btrfs_update_inode(trans, root, inode);
 	if (ret) {
-- 
2.24.1

