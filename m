Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33CEA277572
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Sep 2020 17:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbgIXPdJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Sep 2020 11:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728517AbgIXPdJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Sep 2020 11:33:09 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB035C0613CE
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Sep 2020 08:33:08 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id f142so3589150qke.13
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Sep 2020 08:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=zhYasqp4t3/Sq5r00l9oBUtB0wtxnmCZxQcvro0K8MY=;
        b=gDxxYeaGgnRN1EtN/u9Y/InhEcy4zyLfL9uWJ09cOQd//K/xVVbZMW2CN0P1zpwbwh
         u/xhC9BWjEl4Nxlz44GJqrt8Q62xMA5TlyoOAnkcn2W3l2nfZMKhL5RpI4U2UAaNAQYP
         ocbA1tVCGQVuPqqDdYVmE1BQr9qGupnbvlayWi46MyFjAoa6IdNBZm/tQqT2pTT838cl
         iXDIMM/arQw+m2F1j1MXptA0r/IGd1YD3zi+PKMyjRDj1peGCA2PB13BlSQRJy0vp+Fg
         JWsTnJGsKhvpOsTAKYppmaLFp1LOGyrJCwNEIQAJjDXcJqrlyaza81dWiuE6091KJGlL
         McyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zhYasqp4t3/Sq5r00l9oBUtB0wtxnmCZxQcvro0K8MY=;
        b=XgfwWN4HPxNFschht/zfWglBWx3xE49cyRQ1TK5H2o0Iuch1J/4c2TbQPvcKl/PBzs
         6WVsFXc8kxGywM7YX8QmJzkjCjxcKw5WcABM6RB0OVFnazKgqb8KFRXd8Hy+QKBwUsAq
         F1gY1N2BdUNJ6Uxg43eyK6EnaoBDh2L2lqM1advztdSYJNFB4VHfaV2xnXtji0SJuM+M
         ZKUjX3QoyWrXo1nlL4bHxJe2xpLay90F2B7a2Z/yLRwbVgxrGgsNdRzCKm6tTYvXaGwd
         +yiUvhRtyY9flVuQLlbjToqH9Q7lS9OwVZ2mWnpE376vS78ABx4WaHtYhbwWjbtTxP7B
         5xLw==
X-Gm-Message-State: AOAM532mn1BsvYPKM4yC8inruadKKsFJTOstlI2KPiTWWvAZPEE0w4Ht
        ZXTxLrG4dmUGUeDBEbY6+bH2vV/6+0scZVxT
X-Google-Smtp-Source: ABdhPJwhDerO27HXwzGdudGjhTpaJcx9gKiy/11vB7pSV/S8KoppjtBP9FDt3kvLraoERlHMcSPE6g==
X-Received: by 2002:a05:620a:159b:: with SMTP id d27mr237945qkk.28.1600961587546;
        Thu, 24 Sep 2020 08:33:07 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id p192sm2368517qke.7.2020.09.24.08.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 08:33:06 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 5/5] btrfs: introduce rescue=all
Date:   Thu, 24 Sep 2020 11:32:54 -0400
Message-Id: <2377349868151ecd4be5f7077d22220793492f58.1600961206.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1600961206.git.josef@toxicpanda.com>
References: <cover.1600961206.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that we have the building blocks for some better recovery options
with corrupted file systems, add a rescue=all option to enable all of
the relevant rescue options.  This will allow distro's to simply default
to rescue=all for the "oh dear lord the world's on fire" recovery
without needing to know all the different options that we have and may
add in the future.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/super.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 2282f0240c1d..3412763a9a0d 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -362,6 +362,7 @@ enum {
 	Opt_nologreplay,
 	Opt_ignorebadroots,
 	Opt_ignoredatacsums,
+	Opt_all,
 
 	/* Deprecated options */
 	Opt_recovery,
@@ -459,6 +460,7 @@ static const match_table_t rescue_tokens = {
 	{Opt_nologreplay, "nologreplay"},
 	{Opt_ignorebadroots, "ignorebadroots"},
 	{Opt_ignoredatacsums, "ignoredatacsums"},
+	{Opt_all, "all"},
 	{Opt_err, NULL},
 };
 
@@ -510,6 +512,12 @@ static int parse_rescue_options(struct btrfs_fs_info *info, const char *options)
 			btrfs_set_and_info(info, IGNOREDATACSUMS,
 					   "ignoring data csums");
 			break;
+		case Opt_all:
+			btrfs_set_opt(info->mount_opt, IGNOREDATACSUMS);
+			btrfs_set_opt(info->mount_opt, IGNOREBADROOTS);
+			btrfs_set_opt(info->mount_opt, NOLOGREPLAY);
+			btrfs_info(info, "enabling all of the rescue options");
+			break;
 		case Opt_err:
 			btrfs_info(info, "unrecognized rescue option '%s'", p);
 			ret = -EINVAL;
-- 
2.26.2

