Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEEB339851
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Mar 2021 21:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234870AbhCLU0m (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Mar 2021 15:26:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234857AbhCLU0T (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Mar 2021 15:26:19 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388FBC061762
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Mar 2021 12:26:19 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id g24so4839841qts.6
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Mar 2021 12:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y6rZYyY9TvS4LM7RXIQE4ZNZgbl8/f5ImfrFfXAVsb0=;
        b=NQ7hpSH5AnuGBKszUPZVJT36C+L5FUF2NA6eg0SOv1gcqhg1PR4W85fuIRMXXfY6rS
         mF2k47CGieAKotW7Wxh8EALbp1SwojYphYYS9DHAPbUkX4uyyuZn1gw5sJAwvbuN/tNL
         VmriOCsWOIrr71qYFGh1cl4G5HXsw0Q6z7rVyv/NAnag5uw+hbafY/MQxq5wjPsM8y0i
         7Np6Vdy/3MCoijxhxmoJcZRsUw5NkRaOHkmfum0uidE9WqoVYqkSIg1OKVhbG3dHpf7u
         M4zfXpUUKEl7szTr4oTnhlhclmZuqpWYOLtkSgWXJAreFGlOuFGPabBZzTFaM6MupEYh
         WHuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y6rZYyY9TvS4LM7RXIQE4ZNZgbl8/f5ImfrFfXAVsb0=;
        b=j9u2ls+HOtwMAagVu/jh6u8uCb+BXYKZjng4Ie1hq0NUPFcmK8rvZL4DJ9EgBnfT5T
         bQHvlBvOC2gZ2mLMdngcAfsrWrCppPzFtgfSy7Ag+cOwlteWqdZS0L032TjMDJoQJUDU
         WeNkBJfAmiSogpCW9rRU9iAfWGfwzo0LKFITMCmh5m5io0CnVRyAcek4WZMtD+aEwffI
         y3RFE9J0KGyVnffxkhWtGLCjC2Y2I5XrXUpU5g4RJCDLqFaW4As/2RRWMd6UWh5qNMRV
         4xc9wsbhRUsUXvxX8UGmO/d/HQO43PiCJ/uNNoph9E2L2Jb/hlSm+Kl5bVZUOFqIERto
         /opQ==
X-Gm-Message-State: AOAM532HVGYRlByVzlGbslXRS5kw7F2R+dQ3UG6syj1QD/TXzharoNxu
        okHp87UEtyhAa4i7wZNAfy3iRp9cmgVUoGY8
X-Google-Smtp-Source: ABdhPJwcQ0h7WRAlQoas0B8tGLoP4f8NmLLgk5k6Yy64q5bG9cBkbij9qOR61ucqVDE1TBBBBGJRBQ==
X-Received: by 2002:ac8:1494:: with SMTP id l20mr13705775qtj.151.1615580778247;
        Fri, 12 Mar 2021 12:26:18 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id e14sm5086272qka.56.2021.03.12.12.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 12:26:17 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v8 27/39] btrfs: handle btrfs_cow_block errors in replace_path
Date:   Fri, 12 Mar 2021 15:25:22 -0500
Message-Id: <4e3369f452184885a2af686b90d31b4372bf8ca8.1615580595.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1615580595.git.josef@toxicpanda.com>
References: <cover.1615580595.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we error out cow'ing the root node when doing a replace_path then we
simply unlock and free the buffer and return the error.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index dfd58fa9f189..592b2d156626 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1230,7 +1230,11 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 	if (cow) {
 		ret = btrfs_cow_block(trans, dest, eb, NULL, 0, &eb,
 				      BTRFS_NESTING_COW);
-		BUG_ON(ret);
+		if (ret) {
+			btrfs_tree_unlock(eb);
+			free_extent_buffer(eb);
+			return ret;
+		}
 	}
 
 	if (next_key) {
@@ -1290,7 +1294,11 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 				ret = btrfs_cow_block(trans, dest, eb, parent,
 						      slot, &eb,
 						      BTRFS_NESTING_COW);
-				BUG_ON(ret);
+				if (ret) {
+					btrfs_tree_unlock(eb);
+					free_extent_buffer(eb);
+					break;
+				}
 			}
 
 			btrfs_tree_unlock(parent);
-- 
2.26.2

