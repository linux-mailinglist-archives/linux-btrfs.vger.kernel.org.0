Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 036332D12E3
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Dec 2020 15:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbgLGOAC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Dec 2020 09:00:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbgLGOAB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Dec 2020 09:00:01 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F872C08E9AA
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Dec 2020 05:58:27 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id h19so7130339qtq.13
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Dec 2020 05:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UP22N1wW4BouddiNGmO6P25lyeEkJRg0GBlKgir49N8=;
        b=Kr5bZFNNmeSbvySx1F9VEVc6CB3YREjlL9PrRpxcEplfWlwvr48mJCxc+iAFhZWWdA
         6F2zDT1xJjvXI0eGG3ULYhM7h1118EvOxfWP9EgMm85kn21HUSvsN9cbXTidtDnTixQE
         O6tdml/4xUOjbdG8kZlpIa5lHkvrQ2VKAINVMBusxLfaThT9mtEU7UdvKDVlqAkRo8Ri
         ofCaKzw2CMXsCOhCQb9FE+fKr+T2Z6mz7UctRNpGiG3x7iKWNNRLTqQc3me9O4y8y/iY
         foQED1Ok3sWgssWs9ZHCB7a2e1g8J4q8VyqNGwjT2NT4sGPZ4PfgDfM9kmIQQQUE1o4R
         H65w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UP22N1wW4BouddiNGmO6P25lyeEkJRg0GBlKgir49N8=;
        b=e6gBykwzC3cKNqVNeMA2Sh0ljYygaDa5XI/DEVuBKxircxiHGdd4wDGPYzmotwHFQ9
         /E1YbYa60JN4m7QdWS5Rd/8KYVl8tNcEX0hE4DTDiINshX6IH3MJa0lHHSRn7josEepf
         fJSwAyjax8vtRisjFUVYaph/kJ0egdVypivMBgk6I1v3OhrjtsmnhF1SOxYeHO2iTDy6
         ahhhVkwO8ORJuNMm+IN3aZ9TY0MAkmzc+9y2NSj8DNibaU2Ds/vC0bQ9plG+EJghBgby
         Xw59JokcjrWupOP8KgeQfEzsMpQV8MAg4EY/R9Qs8J9wbxBQ2Z/yEY9EeqE544EvfCm5
         6B3Q==
X-Gm-Message-State: AOAM5307Zc9wOmFmReBIhXb8ebrOtdeJCVX5iNe8upJgE4/C3Dw6230q
        Jl1g4rTat3hi/ULuU60trcSrf15dP+z6Z+BI
X-Google-Smtp-Source: ABdhPJzOC6Lsih6y/BbTkVyEWMjC1JINnjA+ADljIU1QL0yJvrGraKApsriL6FiKj0fbFhNZO65vwg==
X-Received: by 2002:ac8:7b38:: with SMTP id l24mr53153qtu.136.1607349505566;
        Mon, 07 Dec 2020 05:58:25 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id b33sm12787709qta.62.2020.12.07.05.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 05:58:24 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v5 20/52] btrfs: handle btrfs_record_root_in_trans failure in btrfs_recover_log_trees
Date:   Mon,  7 Dec 2020 08:57:12 -0500
Message-Id: <329b4cef6cdc6bb7899b043a80a620df80234bb0.1607349282.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607349281.git.josef@toxicpanda.com>
References: <cover.1607349281.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_record_root_in_trans will return errors in the future, so handle
the error properly in btrfs_recover_log_trees.

This appears tricky, however we have a reference count on the
destination root, so if this fails we need to continue on in the loop to
make sure the properly cleanup is done.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/tree-log.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 254c2ee43aae..77adeb3c988d 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -6286,8 +6286,12 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 		}
 
 		wc.replay_dest->log_root = log;
-		btrfs_record_root_in_trans(trans, wc.replay_dest);
-		ret = walk_log_tree(trans, log, &wc);
+		ret = btrfs_record_root_in_trans(trans, wc.replay_dest);
+		if (ret)
+			btrfs_handle_fs_error(fs_info, ret,
+				"Couldn't record the root in the transaction.");
+		else
+			ret = walk_log_tree(trans, log, &wc);
 
 		if (!ret && wc.stage == LOG_WALK_REPLAY_ALL) {
 			ret = fixup_inode_link_counts(trans, wc.replay_dest,
-- 
2.26.2

