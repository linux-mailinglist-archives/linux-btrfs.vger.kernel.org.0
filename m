Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCE7227B48D
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Sep 2020 20:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgI1SfK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Sep 2020 14:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbgI1SfK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Sep 2020 14:35:10 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A849C0613CE
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Sep 2020 11:35:10 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id s131so1962808qke.0
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Sep 2020 11:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P34x7OrRTAxolemp0GyF0eG5bPjuN3/8N+geC9Tq8C8=;
        b=fkfO+DrnfYymaTh8+DSnKd3zf468DGotp2b5jwYVOtLEcGWK2pdDWnv+fJxECgkuJe
         r0ah65PXwxgv0WPXhJe3ApiiTQ2Wc0ROSH7Me7RmCnfeAfgj77d1PVu5K26ruhp84Rlx
         RP921pe5fOrs1HwS9WDh2V0UbWlAhlBPNLRsvmsxCRlBuZsoEEA/SMdtAQWUfBxCQWVI
         JF2qtiVEqTfx59VwjKT5YTZz2xSw6U0o7PPbESpVf5y3N4j9MQ7fFpQMNHDxVKQBPe2z
         US4LFxBTK9tpQUDamzt31kW9Zcin82mubMXvBUbGv810IKlup30eWWFBe93eF5ieCmJK
         2gkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P34x7OrRTAxolemp0GyF0eG5bPjuN3/8N+geC9Tq8C8=;
        b=Zg8EmcQA30Q3TjIlUtvO1nwvXyARyZ11Hj1fWa4JwYfjcHDnT9GLmlQq43yHmIEDSO
         dqYCFUkCumUxnRZpA4pBZ84/Jh6j9xg24OjLnUWjjpsaABWZZn1rydbwhBrR7Y3pGY7r
         Vq81b6xyYSkWcyzTiDboIkPpogN/fkBoWpuPUfhdQkO0FbGastU+smHmusbgS+AzaODZ
         cIP+8X+aev8bNDF8E4yBc4w2QSuEXaEVttuJPLgb25nJbN+cV/ARW/L8ZX8nMfzD9c7k
         F+YWgitfknVUXg0KUfakcVxjIDg26MSXSHJjKGFgjRgN0VsUNJdd9ZmiiZVcf5EAZOjl
         jnOQ==
X-Gm-Message-State: AOAM53399ZgVWscPua4+3NpvDwY8uoYrtRPT2vaUDG8n73Kz7k2FqO6z
        yIqlS46HsrBUMKj1wi93XCJgqJTznKfbOMbW
X-Google-Smtp-Source: ABdhPJx1xaBidUH1/hQbQNX6FPzkjoFoKrVCUfq4jC8WwNTY0wYMFumPZmkmz2CfCdUVgwSV37WbTA==
X-Received: by 2002:ae9:f80f:: with SMTP id x15mr762411qkh.341.1601318108477;
        Mon, 28 Sep 2020 11:35:08 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id a3sm2175410qtp.63.2020.09.28.11.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 11:35:07 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v2 5/5] btrfs: introduce rescue=all
Date:   Mon, 28 Sep 2020 14:34:57 -0400
Message-Id: <b3975f6ad0362885ffd7ff8ff53e7861a316515a.1601318001.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601318001.git.josef@toxicpanda.com>
References: <cover.1601318001.git.josef@toxicpanda.com>
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

Reviewed-by: Qu Wenruo <wqu@suse.com>
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

