Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D69172CDD6A
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 19:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436610AbgLCSYs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 13:24:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436551AbgLCSYq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Dec 2020 13:24:46 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C7BC09424B
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Dec 2020 10:23:41 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id h20so3026792qkk.4
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Dec 2020 10:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=OZ5WmzNLf5+KfavbqzHhLM8WSJX3ryg1x+vWlPdM3x4=;
        b=S6txz0Tn0/7Djo+cKBi6zJoUwBG2L93Sh76s5yd+p4gRGpGMo1pe13VmM+ljqB2Xax
         yWytZGT+XZMNsf0y0e4HHG/GjbXsIdfoYHjz62s6m62qE0D7+93rafhcd7329ZSWHknu
         M3O6aErEO1d9qaaEXlXPuc0H/cdJA4IBth35KaXWi/+fzIWkK8OB9bJ9pCQJR1zaz/m6
         TKl8zVl7INQBAd3hJKcIkRNu998CIU6shS/jHmQ7WbOL1oa1RerL1JWr+6Gd5G82j3wg
         3zM760glj5vmpLus3bILpzNhq3RHcdkoi+w1/UsswO0mfig/fRUVPrfC8yKQwqAgryY1
         tuVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OZ5WmzNLf5+KfavbqzHhLM8WSJX3ryg1x+vWlPdM3x4=;
        b=DAgJNYbJKJai4+BPVabNrnFxxE2Qp9gHm5FWk3WlJ7XMjAcmUz6Ryc8nWWks8X9tT4
         bl+HDz2r4AmCMy2YYgCrXzJ8Gzx5EppdcHrhb/DviEXZqhcBQmLi9y33LNAc3vorhCvH
         HvxP//vRQSG1fjpmstAOcJSQBzS7SkZvQkv6GNd5E46L0z0oJ7IZPXt8MZjPlQ2Om4gS
         9X4f7ZgxCHJQysj4KLe2/JUi9TIQT6peexEn+5BmZiZSPNsAttAT9vL3wP05oFzdB55L
         sgg+rD7KMOQ5VDhSDDoep9RaS7AXORCqFtvVt9fFPhXR7UPzdx0YNRJB37c9/qAdJkvm
         x3Ig==
X-Gm-Message-State: AOAM531dHZ3+tEDOilmFOj1wyvLwvpLea3/T2z4kvDKhmx7oK81hOl/j
        6omGWfXkyBoN+ili1f5pwN/xEZhjzy3eARRI
X-Google-Smtp-Source: ABdhPJwcj03qu0EEShr10FHGIY7M0FB6NpfM1Fi9AuNW0+epBfcCUJmndPlAO+GYwKRsThTG2KWa/A==
X-Received: by 2002:a05:620a:1387:: with SMTP id k7mr4097024qki.338.1607019820021;
        Thu, 03 Dec 2020 10:23:40 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id r201sm2069643qka.114.2020.12.03.10.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 10:23:39 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 22/53] btrfs: handle btrfs_record_root_in_trans failure in create_subvol
Date:   Thu,  3 Dec 2020 13:22:28 -0500
Message-Id: <fd13f4bcd79d42abd247d113a7e1701c0ba88ed6.1607019557.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607019557.git.josef@toxicpanda.com>
References: <cover.1607019557.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_record_root_in_trans will return errors in the future, so handle
the error properly in create_subvol.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ioctl.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index f240beed4739..6b08fc026846 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -714,7 +714,12 @@ static noinline int create_subvol(struct inode *dir,
 	/* Freeing will be done in btrfs_put_root() of new_root */
 	anon_dev = 0;
 
-	btrfs_record_root_in_trans(trans, new_root);
+	ret = btrfs_record_root_in_trans(trans, new_root);
+	if (ret) {
+		btrfs_put_root(new_root);
+		btrfs_abort_transaction(trans, ret);
+		goto fail;
+	}
 
 	ret = btrfs_create_subvol_root(trans, new_root, root, new_dirid);
 	if (!ret) {
-- 
2.26.2

