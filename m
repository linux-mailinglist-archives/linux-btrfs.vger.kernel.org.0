Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61B9D115346
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2019 15:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbfLFOh1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Dec 2019 09:37:27 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33054 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbfLFOh0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Dec 2019 09:37:26 -0500
Received: by mail-qk1-f196.google.com with SMTP id c124so6681728qkg.0
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Dec 2019 06:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=HxHuv0PZ9eZrYr0EmgG8kKcUxMyKn/q2A73WhZ6BK1Q=;
        b=xLixmouUpo948cJINiO80zMBgKzJjSJYgfuVD/GA+fhPoemdxkj3dg8DPPbsTBOixW
         Si668Hl6sm5i4QzgirkqjtvtCpWpEK0HBBT9FVMifeYswZv/gNR0BcZ7Rr7ceDI6DpRS
         oUWjdxqaS1/iIg+ZlEX6W3QLuKkEXOF1+7gIQdBbj0DTpTrG11BHenXypaTEjZxP+K4s
         wNi6AmsUUvB7e6GbAcoqosNDEhPAF3CnCg3oLxyR3qTJS3/EW95UWXKTGN5TtKNKuUWL
         OXp4JflwBEh09fBD9OiD9/mTYad8TL6/mMvpzXCcuShF3bJwVxFo0QqaSCmp3KIz5KpX
         lgEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HxHuv0PZ9eZrYr0EmgG8kKcUxMyKn/q2A73WhZ6BK1Q=;
        b=QuAAR6cP4b+OeXcq5I4ykyQgAIYDzAr2Ca4BQTt7QX0ymPNIf6SUDwDdEz8akU0A2+
         WWctAMWuy+J9G7P7HPbxGQgwii8qlWEFhNdLPDF0eTFkB7L6qLXuP0VO6DrY3F8tOUPf
         KRKGuQ3cPJ3x9332kMo580CL2wsqjlt7/XUQGEMy6rKsG39vbTfITs2kJJ6oaHTwA7lv
         mtA9O/55AbjRsUby67kqFcrp61XyKZAX5FYkiRxBQAOMszLll7G3Aj2bUdsi9w4tEgJD
         8yRHPVVFlZu8swOkCtWAs143tIRbA1p8MbjTRq2PiL+FzpvHQngeD1KXoliZg/OLiBPz
         gzeQ==
X-Gm-Message-State: APjAAAUxTnNS8Ujp3gaw4bMYrp+f9Elu6X0veN0mTzgjdaTX9zurBtxQ
        TojsteT5iSFIrlYNi98MrOZ9EtbibD3xMA==
X-Google-Smtp-Source: APXvYqxNbv5/KP6flx1/yPMxSL1ppERfZnDUh+AbzWlmN2j9gprK9wcCwIgQZyjIN84L8matgU7Qcw==
X-Received: by 2002:a05:620a:13c4:: with SMTP id g4mr14076247qkl.305.1575643045201;
        Fri, 06 Dec 2019 06:37:25 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id s2sm5889204qke.113.2019.12.06.06.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 06:37:24 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/5] btrfs: don't BUG_ON in create_subvol
Date:   Fri,  6 Dec 2019 09:37:15 -0500
Message-Id: <20191206143718.167998-3-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191206143718.167998-1-josef@toxicpanda.com>
References: <20191206143718.167998-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We can just abort the transaction here, and in fact do that for every
other failure in this function except these two cases.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ioctl.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index a1ee0b775e65..375befdecc19 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -704,11 +704,17 @@ static noinline int create_subvol(struct inode *dir,
 
 	btrfs_i_size_write(BTRFS_I(dir), dir->i_size + namelen * 2);
 	ret = btrfs_update_inode(trans, root, dir);
-	BUG_ON(ret);
+	if (ret) {
+		btrfs_abort_transaction(trans, ret);
+		goto fail;
+	}
 
 	ret = btrfs_add_root_ref(trans, objectid, root->root_key.objectid,
 				 btrfs_ino(BTRFS_I(dir)), index, name, namelen);
-	BUG_ON(ret);
+	if (ret) {
+		btrfs_abort_transaction(trans, ret);
+		goto fail;
+	}
 
 	ret = btrfs_uuid_tree_add(trans, root_item->uuid,
 				  BTRFS_UUID_KEY_SUBVOL, objectid);
-- 
2.23.0

