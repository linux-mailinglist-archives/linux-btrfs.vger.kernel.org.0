Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC50BB4056
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Sep 2019 20:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390409AbfIPSbN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Sep 2019 14:31:13 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39574 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbfIPSbN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Sep 2019 14:31:13 -0400
Received: by mail-pf1-f194.google.com with SMTP id i1so427278pfa.6
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Sep 2019 11:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yf7eCydr4rb/u9vGUZOAtsyQTVjD3zIKFrpyj6IVVNc=;
        b=ihIXlHpM9L0UDhfIOCHwFx4xjDlroBerqu42BOXFHuHSwS2D5EsQklt2D5S3CkDfBK
         MNMgtNb8ErudbCK1GthkqcA8wDnt08VbhpSLdDWXtg8Pgvb/5N69INZDGus2wtSfcs80
         VVU00shHeRi7xIb+m8UxOMTf/6TQkDU2481bdGfjFn/A+VaUs32pWWJ2BNY7TLDgXQuG
         GL1vWx+Cpe3iefXJVyBdJia2b9y473/u37siI8xdkvKJn8W28iD5Rbrmr+ZsNj3M+YTz
         EIUsCZ+hHS6a8+bHYRIft9G+4QAX0bca3nX6CM0wUY9KVr8+pvTkre2foW1fwMDuqrPw
         ae+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yf7eCydr4rb/u9vGUZOAtsyQTVjD3zIKFrpyj6IVVNc=;
        b=IidE6B1b48fZ33JJnTl+89U/Kz/NNLG+QR/XMud+13zLUCvWwfW+ZL5rz4rbr1bToL
         xMQxob/kyKBV5PCPkpb9hqBaVA1EyTgaNGInqLniFxjUkZdoflRXOS5B1/xJ4gAPmDvR
         P9e6m3UTdxGd43SR4bp/4PY3UFth64uAHkg7TVk8SN/brK00by8i9eBRa5sbBZBr4LVV
         ZUfqJ4dzhKnwDSvUExbfZ7oNfGAfV3N/5r+euf6vNwZJvOCGRgpneQI0gNTdWtHCOb34
         /ju8/Xj+C2npwtjFNCBnnochyFclDwc58TrRW84mw1ndSbXaXuh+XGSQAfYq0gMBA80a
         LbrA==
X-Gm-Message-State: APjAAAWM7+FZv5Jtwbo5r6noGRu/I6R8YRV8FzO+tS7wHXoPiQWhuQtk
        gKD/UNUlT9hFy/Sywav1r9YIks+toho=
X-Google-Smtp-Source: APXvYqybJ4d2I6O45YOuh41SCLe+E5KsVjQPi9qShnXoT7JHCO4gluHWzc3Am+mgd4bXbbh60dOL3Q==
X-Received: by 2002:a65:648b:: with SMTP id e11mr486093pgv.2.1568658670248;
        Mon, 16 Sep 2019 11:31:10 -0700 (PDT)
Received: from vader.thefacebook.com ([2620:10d:c090:200::3:d0da])
        by smtp.gmail.com with ESMTPSA id i7sm24231385pfd.126.2019.09.16.11.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 11:31:09 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH 1/7] btrfs: get rid of unnecessary memset() of work item
Date:   Mon, 16 Sep 2019 11:30:52 -0700
Message-Id: <5d25104c72198a164eee3756ae8e3b5664f02079.1568658527.git.osandov@fb.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1568658527.git.osandov@fb.com>
References: <cover.1568658527.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Commit fc97fab0ea59 ("btrfs: Replace fs_info->qgroup_rescan_worker
workqueue with btrfs_workqueue.") converted qgroup_rescan_work to be
initialized with btrfs_init_work(), but it left behind an unnecessary
memset(). Get rid of the memset().

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/qgroup.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 8d3bd799ac7d..b2b8ceaff467 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -3272,8 +3272,6 @@ qgroup_rescan_init(struct btrfs_fs_info *fs_info, u64 progress_objectid,
 	spin_unlock(&fs_info->qgroup_lock);
 	mutex_unlock(&fs_info->qgroup_rescan_lock);
 
-	memset(&fs_info->qgroup_rescan_work, 0,
-	       sizeof(fs_info->qgroup_rescan_work));
 	btrfs_init_work(&fs_info->qgroup_rescan_work,
 			btrfs_qgroup_rescan_helper,
 			btrfs_qgroup_rescan_worker, NULL, NULL);
-- 
2.23.0

