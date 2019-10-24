Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB66E283F
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2019 04:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437097AbfJXCev (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Oct 2019 22:34:51 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44718 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437093AbfJXCev (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Oct 2019 22:34:51 -0400
Received: by mail-qt1-f196.google.com with SMTP id z22so14976795qtq.11;
        Wed, 23 Oct 2019 19:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MdjBl45h9xt9Bxg4VPMkmRN0bJK1gJzee5THO4fvM2c=;
        b=aqXvgS3dfP+0XgdQ80ffVw/io7830PY0SVCeCv8a/9ej7O94EcqaGaLh6AYImu6STm
         mbKpYUKkXI1+rFwxzkaNAxMpCmUb49ksKFEPzblBU+rQuNwuiefHUPTUzsdlYsNGEOa9
         JLE/iGz6GxZ7j1zOXVWUx4cfD1vuCkq3taXk+LDX5VbEYVYV7oNeUgUiDAqLyf917MH3
         KA4WWT18vIb8ZrVhvc/3K3Nh7keNQNGj9cpVZ+fW09q5ZoBRU8NCQrlway+59xqyc6TZ
         IrJEe1BC1xLdCvOUvN48hCte6niOwNmXEkj0k2yU82hRXiJWFDw1c9qNkhnyDsR87k1B
         LgQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MdjBl45h9xt9Bxg4VPMkmRN0bJK1gJzee5THO4fvM2c=;
        b=ZHKgjTZL6VZAI3ZbdYRuBWeKrNOQtFOIAdzYC7mqwnSqWAgEL5MTPMT7kK4AXI41vp
         Tr1dqMQYdVgtvVN8TU7jpQCsuf2/nj/kOHjRX6wPtx6mgCQW1Bya+UCXz0hsl22TGy0H
         F+tfKKQfi2tw0J+3TnNZ5SDU0Dx+rMuswCBJx6/QETut9f9dBdcYmIoHRw3OG2G+RvYv
         LAqpmUz/8UfOou2pP3g2mBbHiU2OGAQwswqTxLJO7qEBU2RkefUrnctqr6jEtyIgxT6l
         ePSxlRny/Knc1sD2kCwYu74vQXiKVAUfwutj5CdQQI8gQsUmtOLEif8FnWkQ/ins/k9X
         YVAQ==
X-Gm-Message-State: APjAAAU+Lxg8g5xXolWKMFjnztP51WwO7DN73ANAMB2bdm9auiAmh/P+
        3lOJZjo3q+DMHVADTGFaOelrOCUV
X-Google-Smtp-Source: APXvYqw+mzewUgpctNlCsG9CnLPmhf9YMul+ytiPBkO5dHRaxba/a8qNlrzwQf12lfL6yuQdwpym1A==
X-Received: by 2002:a0c:92dc:: with SMTP id c28mr12627065qvc.26.1571884489717;
        Wed, 23 Oct 2019 19:34:49 -0700 (PDT)
Received: from localhost.localdomain ([186.212.94.31])
        by smtp.gmail.com with ESMTPSA id q16sm10252495qke.22.2019.10.23.19.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 19:34:49 -0700 (PDT)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, mpdesouza@suse.com
Subject: [PATCH 4/5] btrfs: ctree.h: Add btrfs_is_snapshot function
Date:   Wed, 23 Oct 2019 23:36:35 -0300
Message-Id: <20191024023636.21124-5-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191024023636.21124-1-marcos.souza.org@gmail.com>
References: <20191024023636.21124-1-marcos.souza.org@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

This new function takes a btrfs_root as argument, and returns true is
root_key.offset is bigger than 0, meaning that this tree is a snapshot.

This new function will be used by the next patch.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 fs/btrfs/ctree.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 19d669d12ca1..8502e9082914 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3411,6 +3411,20 @@ static inline int btrfs_defrag_cancelled(struct btrfs_fs_info *fs_info)
 	return signal_pending(current);
 }
 
+/*
+ * btrfs_is_snapshot() - Verify is a tree is a snapshot
+ * @root: btrfs_root
+ *
+ * When the key.offset field of btrfs_root is bigger than 0 it means the referred
+ * tree is a snapshot.
+ *
+ * Returns true if @root refers to a snapshot.
+ */
+static inline bool btrfs_is_snapshot(struct btrfs_root *root)
+{
+	return root->root_key.offset > 0;
+}
+
 #define in_range(b, first, len) ((b) >= (first) && (b) < (first) + (len))
 
 /* Sanity test specific functions */
-- 
2.23.0

