Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 249612B203C
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 17:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgKMQYH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 11:24:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbgKMQYG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 11:24:06 -0500
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3EDFC0613D1
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 08:24:06 -0800 (PST)
Received: by mail-qv1-xf43.google.com with SMTP id q7so4822090qvt.12
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 08:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=n2/WX1alcdkjlt82F9yXMyuKjxX6z6psZftpiGS+rmM=;
        b=vgRrtxJCI3vGNJiIxClf/wrstFLjKcBmM3C0F3MV2F3ZbBFecUJ6D5+PeH8bmGJm/G
         uK1qCEk2kLsTKmpQAdUqWYYxrtrvXK5+jUZwH/0fa+1/eLc5gqzMc9Xbwd0B6Kr6mO9D
         pEXo5vvLZiyYyFyZIRG4T9px0eQPPoeIDF0XBLwg5tyoFOwEBSj2CJnlboJpnIaUq5x5
         liXY2vnuxbKVF8xdoMtwliDcEwx1zTAQEjbQZfRC2d7AGtLMGzdpmxh8ZyCsazL6dhjH
         ipgx9N1x7NyGtjpmfoaOdWbtyWoMkdqvaSfUlt3MEJJDQ/lQz/76W2t+tNplLeE1vMVx
         GagA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n2/WX1alcdkjlt82F9yXMyuKjxX6z6psZftpiGS+rmM=;
        b=Akq8OVxtZGb37/sK9csemotiy4osr03FoBYhY1+J09vO0i1+6wswaoK5/PKnYS0g42
         y39QfHU9IhLM+uySPDNYlauQDHHYD+D918XsNdbA/ZtOLHuRXUTkLdXFcFBfj6PHc+QE
         p+wIdYxXlQ8oowh+fdYmspmDRw1BRFZup74gAtyRGgQSUzRlHY/iM2R4UlRb297F+ed5
         cHn/m6cVnfI1jEbHjz6o9/tL48KVlg509b+OlPMGx5F1eCvkBrntUasGk0XFhkhgTZTZ
         lgIUMbz/DOTEDqb3R4oosdj6aoU6c2Lj7RPsf0XPqqZ5YhAI2UIs7+R+HfFDbSDnvGuy
         oZsA==
X-Gm-Message-State: AOAM532RJSjd1TUPF6x2/nC5yFAsfBp/mik59zs2tUvvR4PojBjlPfLZ
        s95qB1Y29rHtznCj21owgBcbDL19KnpfWA==
X-Google-Smtp-Source: ABdhPJxjDltXyl0PgMW4JoU0bEUZIJtkbWm69GOTkuYogaDTWsneYpih9/+leBYaf65a/1ywjVhHrQ==
X-Received: by 2002:ad4:4673:: with SMTP id z19mr3142744qvv.60.1605284640732;
        Fri, 13 Nov 2020 08:24:00 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id i192sm7253180qke.73.2020.11.13.08.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 08:24:00 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 14/42] btrfs: handle btrfs_record_root_in_trans failure in create_subvol
Date:   Fri, 13 Nov 2020 11:23:04 -0500
Message-Id: <dc7a7364fc721d327df03636cfe2dfc724f50e7b.1605284383.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605284383.git.josef@toxicpanda.com>
References: <cover.1605284383.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_record_root_in_trans will return errors in the future, so handle
the error properly in create_subvol.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ioctl.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index a5dc7cc5d705..da9026a487d2 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -702,7 +702,11 @@ static noinline int create_subvol(struct inode *dir,
 	/* Freeing will be done in btrfs_put_root() of new_root */
 	anon_dev = 0;
 
-	btrfs_record_root_in_trans(trans, new_root);
+	ret = btrfs_record_root_in_trans(trans, new_root);
+	if (ret) {
+		btrfs_abort_transaction(trans, ret);
+		goto fail;
+	}
 
 	ret = btrfs_create_subvol_root(trans, new_root, root, new_dirid);
 	btrfs_put_root(new_root);
-- 
2.26.2

