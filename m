Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4097115371
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2019 15:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbfLFOp7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Dec 2019 09:45:59 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:39838 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbfLFOp6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Dec 2019 09:45:58 -0500
Received: by mail-qv1-f66.google.com with SMTP id y8so2722283qvk.6
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Dec 2019 06:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=BHAJCZpUixrFOo6YxjTvdeyJ+SbmjrYnDz0qcyoWdoY=;
        b=vnZWs3PwFRxWXC3Y8h7RWOLCvnOkpdfbmSvQE4zbMssEVIZ7ZLyBB51smZtyXnULf8
         FgI55LCJn5u6/0RMv5n7JxTrsHrtFo03X1UQUV/lUOkPXtTpbFVGajq9ohVtFctXnR7J
         eLi28gFtpoXbZ8ut+BUrkfhAhpEI20Ex+Wp5+dA2ImvJcs6kBqrP42T71DeBslokVrFp
         h3AVZuKbpLIrh9lAgFltdFd5EhWzqsKwksEQVulD36UnOjTcJucIUO7Zt6zVg00qrUxd
         vCJI0VbVwreQ8azOWsPjbqUvXyX7qLsFwvVP+KIrEwiDCUKPSOR5UZsntytRBm7vbyEQ
         zQ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BHAJCZpUixrFOo6YxjTvdeyJ+SbmjrYnDz0qcyoWdoY=;
        b=PqHSXB5IB4xgRfAa/gOqscocUa5K5JMlP1eXbBb8CsUw22yfS8WdQYYAxQIKDrbNgw
         6tHjR7W50shv/QrSoTV6NG8vSWoi0a6JZ+jIK3l/AbzZ0ltbisfSJw8hzVEe8xrVcqQ9
         n0dSHNy97nVVoMf6cSzOSI4R4GzGWuZsW2vUHbQgT7uE3K+QDXfAlBZwqbnIhoEQ7nDj
         tP5ENvfmy4phdpT4GqF+mrEtGnCU/gdkAirKBISU3yWEROt+bWLxpSB4EIy5RDCrEG8D
         1Sdrr78BWNgrRc+mCN9d7vmKsrCUqL1+QnDgCst7dBIJH7THrHLr9RjQj9WIaSy1PCHo
         u+GA==
X-Gm-Message-State: APjAAAX0alSjp4L37FZPoVc/xKmyMKamVUFDezsKmN3bEOyEJd1snTXB
        OPQyAApnn10yhY0F+eZR3Bc6+eNCGgC6Lw==
X-Google-Smtp-Source: APXvYqxCxHvZc1Wz/yR2nr1CwUsd+nOLFkTDi8vYXxDGLL+U0u54Ff/hf2GMhm58ZAQAne0mUxy5ow==
X-Received: by 2002:a0c:962f:: with SMTP id 44mr13023362qvx.103.1575643557456;
        Fri, 06 Dec 2019 06:45:57 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id i4sm5850971qki.45.2019.12.06.06.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 06:45:56 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 09/44] btrfs: handle NULL roots in btrfs_put_fs_root()
Date:   Fri,  6 Dec 2019 09:45:03 -0500
Message-Id: <20191206144538.168112-10-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191206144538.168112-1-josef@toxicpanda.com>
References: <20191206144538.168112-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We want to use this for dropping all roots, and in some error cases we
may not have a root, so handle this to make the cleanup code easier.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 5b38558e164d..1685dd2cf7ab 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -95,6 +95,9 @@ static inline struct btrfs_root *btrfs_grab_fs_root(struct btrfs_root *root)
 
 static inline void btrfs_put_fs_root(struct btrfs_root *root)
 {
+	if (!root)
+		return;
+
 	if (refcount_dec_and_test(&root->refs))
 		kfree(root);
 }
-- 
2.23.0

