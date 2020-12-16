Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4FD2DC431
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Dec 2020 17:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgLPQ2g (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Dec 2020 11:28:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbgLPQ2g (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Dec 2020 11:28:36 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986CBC0619D8
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:27:37 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id i67so15509799qkf.11
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=RB3ZVAwErcd97s2dhyLnYsI1ypCe4zlqd+anJuxPtEY=;
        b=uyyiI/z0ZVJh5IsbTrA7UlEUmYFlTOLjC9JqCU4A5YqYMR/JjCZsp1fg5DVht06yru
         HRM24YtfCiyDj96Ba2F/EihAOWpFsx+vnf+/raLKgBIhcXq8kuSqISbglzxAtlCSqXdS
         nVo2iZ9sPcIaj5Ftbsk0+FljhP0KrSBiPsxkxgL+BRa1rTW54w7eLyVJGqEYKjrU905j
         RbMH/4hvwrhemVzPCfaO2tRfruZcqZk6JG81F6H2VVUHoB3gCMjERDbbcJwsPXX6yBLH
         /+BHzdRuUi9A0Q6OOAd36vFMc9AbaP55xXpcKDWPtDCJvnYDR42P4E017BfqBtTPi6jA
         0zcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RB3ZVAwErcd97s2dhyLnYsI1ypCe4zlqd+anJuxPtEY=;
        b=R8y6CqRcBHjPworbvBdg4dg7PsizjQ55kWXmXI/8DNKqfmFss/9zF8J5wZnioXhQXz
         d1La5imOdFjwm/wmltkHKyEnJGuVTFZe382h5Rjs+97cah4BS6g6foDA3+vJxQ7KLXYd
         yqRzB6fDJgBlQxDRJaw62lzm8obvcrdh7tD40MOnOFbx4oF9mwSeVU7iQrReRs480T29
         Joy02l3/Koof8ZaIQvsotDo/9H1Qm7GhMpFazZP3WFgYymoQ6jdPEsBunmfrsAFuuBAu
         0pWnBcuQsDvRFAAhyCiTgIKbM1LJjyQX/kNI4nhPcd7D/anx37IDZxDniyvY2t4z/nXS
         WHZg==
X-Gm-Message-State: AOAM533ub4RFcUb2oVIT8g+wpDDwi4C3wwHcDA8d4N5Zp4h0oMFoA8g3
        QPhrDOc/e9GDRnNE/9OZt+CrYbbYRGfEo0H3
X-Google-Smtp-Source: ABdhPJw76tvN6UPWxAbm+2PEDzaeoxyAZtHdPRnWd5TLPnn618KhmvS7G9CCebR6fDP5TmgL99ncaA==
X-Received: by 2002:a37:994:: with SMTP id 142mr26149474qkj.257.1608136056277;
        Wed, 16 Dec 2020 08:27:36 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id n2sm1440275qkf.37.2020.12.16.08.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 08:27:35 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v7 23/38] btrfs: handle btrfs_update_reloc_root failure in insert_dirty_subvol
Date:   Wed, 16 Dec 2020 11:26:39 -0500
Message-Id: <3358ffdae439bd9dbaa7fa6af47b00c11090572d.1608135849.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1608135849.git.josef@toxicpanda.com>
References: <cover.1608135849.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_update_reloc_root will will return errors in the future, so handle
the error properly in insert_dirty_subvol.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 13d5fd74e745..dde383477f5f 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1572,6 +1572,7 @@ static int insert_dirty_subvol(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_root *reloc_root = root->reloc_root;
 	struct btrfs_root_item *reloc_root_item;
+	int ret;
 
 	/* @root must be a subvolume tree root with a valid reloc tree */
 	ASSERT(root->root_key.objectid != BTRFS_TREE_RELOC_OBJECTID);
@@ -1582,7 +1583,9 @@ static int insert_dirty_subvol(struct btrfs_trans_handle *trans,
 		sizeof(reloc_root_item->drop_progress));
 	btrfs_set_root_drop_level(reloc_root_item, 0);
 	btrfs_set_root_refs(reloc_root_item, 0);
-	btrfs_update_reloc_root(trans, root);
+	ret = btrfs_update_reloc_root(trans, root);
+	if (ret)
+		return ret;
 
 	if (list_empty(&root->reloc_dirty_list)) {
 		btrfs_grab_root(root);
-- 
2.26.2

