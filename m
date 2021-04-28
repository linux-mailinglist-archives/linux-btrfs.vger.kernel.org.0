Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62C3036DE83
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Apr 2021 19:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242648AbhD1Rk7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Apr 2021 13:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242763AbhD1Rjo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Apr 2021 13:39:44 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7910C0613ED
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Apr 2021 10:38:57 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id 190so7723029qkl.11
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Apr 2021 10:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=UqetKq/bdwiqKwQ7OIwmuOIYYkvXlIOefyVfaVdNg2g=;
        b=2ShFlTkLFcEa0F0cA08PMTKOPHwxjiQ80uCWfaLY+WJWSeNr/IDLiNPtyt5GQlQIWu
         fD5gL5y9rioyYYbyguMA2G5Jvh4wJylWF9V0488Y2sZO0PsQsC3VNL/Hg3BIvejyuZuu
         wxOdjgW+q/I4tkgnsf13TQ8z4US2H/ee26PUEU0v8OrmmW9Yae4O9W8K7HYnVK9pxpng
         LCw5VTPQrrL8dhkwjylgq0sGdBg9ivoP6bJB+rE/6vm5iMubVw+Gxbmvu7QpZ3bcHlkK
         AV5OjQCIEAPKiodyJ+uorQ8uixPYN8yBIEEbysKoqh7REhgqu5MXBxOts6uBClU4royR
         vkyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UqetKq/bdwiqKwQ7OIwmuOIYYkvXlIOefyVfaVdNg2g=;
        b=DA6BbsZ66jAnkqhoAxAyhzJxOScSjX3ilhj/O0/Y7oKmt35/frkTmw6CXCgdMPKlRa
         ubf86HNxsQFRgk2PEMojCSEYx+x1ilL6FsMOr7lgfeF/tdyKrX7p2rsDyBgJYVabF5oc
         KC7VCR0/we6fczPmffgWOcPfojYDXXSFNR8gVL9esHB2RYvOt/RrJ/1mHC3hgJpvZgUc
         nSpQZ0MZjYThZm1xAwHtUlmWVF96ZeTV9VjwNioCQ3uwa52gEkEj3/kvPC7Umymj3ITF
         fb3TWxr63UiV7VVBC26kHymBfc99MYJxc8NqDcLdOB106qIK5Y2eqfRtkWY08UK7+Dql
         EBNw==
X-Gm-Message-State: AOAM532YfLvlaOyOdrdXGU6cfzIeU417yQvO91pBKJYcpJAFQ/k+t9kR
        CUzNAI1PbbVIf698ieMyg0FImRWzARmmOA==
X-Google-Smtp-Source: ABdhPJw79KQN5m9If8ko1T+bGKVic8lx3wp2BFjwe7jjzViPco79oP7Z4N7zeTk7GqBIMez7tIyeSA==
X-Received: by 2002:a37:ad0:: with SMTP id 199mr30182088qkk.283.1619631536797;
        Wed, 28 Apr 2021 10:38:56 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u18sm302025qku.39.2021.04.28.10.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 10:38:56 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 5/7] btrfs: don't include the global rsv size in the preemptive used amount
Date:   Wed, 28 Apr 2021 13:38:46 -0400
Message-Id: <612a917a29754cb8f2745a9d45a2d78dfee538fc.1619631053.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1619631053.git.josef@toxicpanda.com>
References: <cover.1619631053.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When deciding if we should preemptively flush space, we will add in the
amount of space used by all block rsvs.  However this also includes the
global block rsv, which isn't flushable so shouldn't be accounted for in
this calculation.  If we decide to use ->bytes_may_use in our used
calculation we need to subtract the global rsv size from this amount so
it most closely matches the flushable space.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index b0dd9b57d352..4e3857474cfd 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -871,7 +871,7 @@ static bool need_preemptive_reclaim(struct btrfs_fs_info *fs_info,
 		used += fs_info->delayed_refs_rsv.reserved +
 			fs_info->delayed_block_rsv.reserved;
 	else
-		used += space_info->bytes_may_use;
+		used += space_info->bytes_may_use - global_rsv_size;
 
 	return (used >= thresh && !btrfs_fs_closing(fs_info) &&
 		!test_bit(BTRFS_FS_STATE_REMOUNTING, &fs_info->fs_state));
-- 
2.26.3

