Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5F2614F4E2
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jan 2020 23:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgAaWg4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 Jan 2020 17:36:56 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38731 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbgAaWgz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 Jan 2020 17:36:55 -0500
Received: by mail-qt1-f193.google.com with SMTP id c24so6718344qtp.5
        for <linux-btrfs@vger.kernel.org>; Fri, 31 Jan 2020 14:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=+UrJOCU5WbPWQtIPp2MB0dRS8vSO02ENQco0IBK98lU=;
        b=CJi0Kl4UOxAfPvJFyR04IlxuFnAuvkQ2d6bVhqSTJOrWgvZudzbL1uAAeyeaB70jwH
         Phuc4ePRLdzgW+oem3KY8uEw5X2y3YYxG810wY6t02hjdOY70oogNjboaVkrvTkWx2vO
         StTyztydbsA+pVfeYpWNVtAxmQcNa56IuzJoPgCR578vM5MMW0pV34XspeF85bOjmuu6
         QTo7CiAoMjqNfr89IgshzRCNkfgQMYV8BDTR3sBjmlost/XWj9fNko7H9rKL41hYe5Ii
         qBwKCzn/Fr+2kgE75b403N4q3pQd7maHtCnNTnlia/qkGl7FDQMmHDrhZ4M4KH7BXY7V
         s/mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+UrJOCU5WbPWQtIPp2MB0dRS8vSO02ENQco0IBK98lU=;
        b=dBuVfkICZHkfYmeGriPCn7EHeuWLPfKF22QB/XijRqtE3SOAaPSYPPct7QJr/QTKNA
         o3H1KrQI1tHIShaUbGnnJWNLAGCgNbBecUvNG06KTmnDPSwPT/v24/A6YnydFnqNsPHt
         BPm4L0WVVJ1iiNYbqnIKl61KGiWX8eBdq1J+9Y66m5+kyj/L+VCVy4nUGmH2kYm1Gnyw
         /f5SHFk9RfTcm1q63SmfmA3HXAsrIWEp3rq2UfKIK6IV5GickG8CzB76dCsqO6R2paaP
         CpC494648H67IMleZMbynRUbAfrKW4/LqZAUo0sAZOMnJSYO2grkU/2leswfE7I87LiS
         9Fvw==
X-Gm-Message-State: APjAAAVjb9UW+2dFbV3Ywx1mjaFe0gbkqAWDSqOituC1vPdZF896wR3Y
        xrTjVC9IjKpoA4pf/mMcA3fw57hWFS+OFQ==
X-Google-Smtp-Source: APXvYqytSFImqOi/JMF2R29CPbkytU5hgHZhzNcYHwnzKUEc83FvhhiRqYZxeK4DmPi02617qhLkXQ==
X-Received: by 2002:ac8:36ab:: with SMTP id a40mr12838337qtc.60.1580510214384;
        Fri, 31 Jan 2020 14:36:54 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id g62sm5226311qkd.25.2020.01.31.14.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 14:36:53 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 22/23] btrfs: flush delayed refs when trying to reserve data space
Date:   Fri, 31 Jan 2020 17:36:12 -0500
Message-Id: <20200131223613.490779-23-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200131223613.490779-1-josef@toxicpanda.com>
References: <20200131223613.490779-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We can end up with free'd extents in the delayed refs, and thus
may_commit_transaction() may not think we have enough pinned space to
commit the transaction and we'll ENOSPC early.  Handle this by running
the delayed refs in order to make sure pinned is uptodate before we try
to commit the transaction.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index c86fad4174f1..5b0dc1046daa 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -805,6 +805,7 @@ static const enum btrfs_flush_state evict_flush_states[] = {
 static const enum btrfs_flush_state data_flush_states[] = {
 	FLUSH_DELALLOC_WAIT,
 	RUN_DELAYED_IPUTS,
+	FLUSH_DELAYED_REFS,
 	COMMIT_TRANS,
 };
 
-- 
2.24.1

