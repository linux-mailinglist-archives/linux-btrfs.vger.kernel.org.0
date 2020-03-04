Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB2361794DB
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Mar 2020 17:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388231AbgCDQSh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Mar 2020 11:18:37 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44945 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729739AbgCDQSg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Mar 2020 11:18:36 -0500
Received: by mail-qk1-f195.google.com with SMTP id f198so2146114qke.11
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Mar 2020 08:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=gAK1da/LKBjkl7EBkrL4Rdz0dBqcuF+zieoCZPZIVIM=;
        b=Fa43c+BSDCkOkgg5clFLvmMOrnaFijJGbVDY1x1HE/TtQj1rDN47wViEH55eQs8HFw
         +RYMBvQHPuyVm9JOSt+LrVJFzycdMI8fg9/SCVLZpXrqTsa6Sv/98QOUy1pD0t9rbOhy
         N2kgCnFoiDlGPZXx6iwpns1/pwZaKxCNHjObYKytvBGJV6oetdodPTHo/UPCGAxMOonb
         90+AHGkVvwDCy4Ma4gzkg8Wk0BdhVHLPymqWJn5gcb+TRum6fsYQCKYH7w6X5OlP7LTQ
         X/ai+9sW3yW6aunf/ovHb4FgcjriCriDWyLK0jDGJJZdWUEWsFFigEbdVX36JB6hrp7j
         OrzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gAK1da/LKBjkl7EBkrL4Rdz0dBqcuF+zieoCZPZIVIM=;
        b=M2bk6nUsJNbGTFoUwpCmJxucd7xqnhbgp1ly8fI+RB5HBwbJ5GcVeRq9KYz9urPekx
         wj7DXOoGLe14T3lE9vqta7gmDG/gcRRdRooFjPrbPFs26auB9llkaWkzeKJ5mEWw4yCz
         g8qwP+jqWGAHItcj8/JztWxBd81kI9iPnPDEvCiwixvk7PJhZ0Vn3CUYM2DEXwtVMvQE
         3I8iV2gZ4Eg+WdC6o8zhXn7NxvV5B9g2cV0lnAh+7GRz/c6Xq+LaaHEPHGCQutdZZN6U
         9v7TqvrH98U5HZrgTx0Vk71oS+dxg+7m2ngxT20scMDgRWGG4XQSg4bGaAMdqxRAOaUK
         NHuA==
X-Gm-Message-State: ANhLgQ2iN7PbziwKZGEMZeGbpyskSmh9qIU4U/uisIIuvOBeIBkYKMlQ
        VJaMSK7RglCi8219VrCNvq31ZLnSPmE=
X-Google-Smtp-Source: ADFU+vsatHYmY41BIBq6v5y5NcEWz4VCPJPxN9eFx0ZMErp+ruEfymx1FSsTQhiIM4Fxx/8mAk52zQ==
X-Received: by 2002:a37:9047:: with SMTP id s68mr3750138qkd.63.1583338714681;
        Wed, 04 Mar 2020 08:18:34 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id w83sm13576024qkb.83.2020.03.04.08.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 08:18:33 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/8] btrfs: drop block from cache on error in relocation
Date:   Wed,  4 Mar 2020 11:18:23 -0500
Message-Id: <20200304161830.2360-2-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200304161830.2360-1-josef@toxicpanda.com>
References: <20200304161830.2360-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we have an error while building the backref tree in relocation we'll
process all the pending edges and then free the node.  However if we
integrated some edges into the cache we'll lose our link to those edges
by simply freeing this node, which means we'll leak memory and
references to any roots that we've found.

Instead we need to use remove_backref_node(), which walks through all of
the edges that are still linked to this node and free's them up and
drops any root references we may be holding.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 4fb7e3cc2aca..507361e99316 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1244,7 +1244,7 @@ struct backref_node *build_backref_tree(struct reloc_control *rc,
 			free_backref_node(cache, lower);
 		}
 
-		free_backref_node(cache, node);
+		remove_backref_node(cache, node);
 		return ERR_PTR(err);
 	}
 	ASSERT(!node || !node->detached);
-- 
2.24.1

