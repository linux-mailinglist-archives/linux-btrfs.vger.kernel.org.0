Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECDE92CC734
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Dec 2020 20:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389828AbgLBTxf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 14:53:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389841AbgLBTxe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Dec 2020 14:53:34 -0500
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2590C061A4B
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Dec 2020 11:52:47 -0800 (PST)
Received: by mail-qv1-xf43.google.com with SMTP id q7so1295969qvt.12
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Dec 2020 11:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kNOtAisk0hN8omuiH6mLCn6ZjHq8m2odxb3m+HFyoKQ=;
        b=xxEdC7Cgc3ejhw8F0f63bBz8LkNgTjH3u4q8NYHpHi5l4ocK+TcZfpreNrMlvRIF3f
         BMHFQAsGTLgYQDzD6TECQaQoGSGeUdmUYGTy0Sodkvw4zSQIpn9xevyj3SNfafsUW870
         1rLOb+BY3PbMMsX86XXxLZQ4S4jZVEPRkHdgHDgJGTRd8cGMeJE5y+UhjpGW26E0x0A+
         MkKUraNtuxPydF4rvt6ziTfW+5S0htkwQPMMIDRVUxRlPhDnF+MdaEkC7jVAoZVzzqqM
         XqpvzgIEAYsG0JZAtBZHhc6rlGDCWm0B4JS1odRq8/bnNpIywjqpJI6dXg5U+voioUdA
         i7nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kNOtAisk0hN8omuiH6mLCn6ZjHq8m2odxb3m+HFyoKQ=;
        b=p4GiqyILID/lSBcLCkTZqakP2I669SCyYsfIfnd8rBNwQ0x/JK/EQktVZHMMJRUxVY
         5Owx6PDHwAq5la+z6Sfr+Y7DG3+qC3oDpPg6/0IsgZc91R6uInmr19X/7byWI5NiNkUY
         xpegPiVmjoXYXEXufMumRufeNEge6izje0NBF7PToU+aahkcA5JiChIp9g/3sf+Pq0/2
         0r8vJQtxTMyRrH5kyMF2lGke72G1FcMt0Oa+2vd95XHu4WIk4XyR9cYmQpgF2YWiyQjL
         2ZKaGS3gZX4wtBYpDX5HHEZDqk+A4iBqZeRcdvRNIJYP8pAdSfYlhppyghkQ2DBt8GsZ
         zVCw==
X-Gm-Message-State: AOAM532WaFejjaQQa4/gBFOV3ytCRG2tsqJND02MGvGY1evmhqEOW2z4
        ipB6bOEB6jleo9+n5jpm3AazVnYNM8x/AQ==
X-Google-Smtp-Source: ABdhPJy5fzT0CKoZym1WtlXIMUIH/fGBl3Yq/ZuOljetTRo4Ai6dyR0vK4sgt04PMcLSgQ+x2OIO+w==
X-Received: by 2002:ad4:5587:: with SMTP id e7mr4075189qvx.33.1606938766852;
        Wed, 02 Dec 2020 11:52:46 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s68sm2921415qkc.43.2020.12.02.11.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 11:52:46 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Subject: [PATCH v3 51/54] btrfs: do not WARN_ON() if we can't find the reloc root
Date:   Wed,  2 Dec 2020 14:51:09 -0500
Message-Id: <cea30a007d25dd4fe0e390114b1b040dab4565ad.1606938211.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1606938211.git.josef@toxicpanda.com>
References: <cover.1606938211.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Any number of things could have gone wrong, like ENOMEM or EIO, so don't
WARN_ON() if we're unable to find the reloc root in the backref code.

Reported-by: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/backref.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 56f7c840031e..525815d2914b 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -2617,7 +2617,7 @@ static int handle_direct_tree_backref(struct btrfs_backref_cache *cache,
 		/* Only reloc backref cache cares about a specific root */
 		if (cache->is_reloc) {
 			root = find_reloc_root(cache->fs_info, cur->bytenr);
-			if (WARN_ON(!root))
+			if (!root)
 				return -ENOENT;
 			cur->root = root;
 		} else {
-- 
2.26.2

