Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 815AA29085E
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Oct 2020 17:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410119AbgJPP3j (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Oct 2020 11:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407477AbgJPP3i (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Oct 2020 11:29:38 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085B5C061755
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Oct 2020 08:29:38 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id b69so2214202qkg.8
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Oct 2020 08:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R86yHF8mmwe0DChfPpFQwDkY+H3Wr/ye808Nk2VTBvg=;
        b=MRbpY6egO4Eg+FklASjcbG5xT4TW6WkOaYVZqdLTQGwJbYLetKyoHOpdNRKHGWuG89
         90OM4kYkDHGGr+7Af/AFeDJLjxcFS9+5Wkn633BGBtvEWkfD7TLNXenAIeg+lDKbkkyZ
         38DQdId/TUL2qsIFMPRjuiraN6K3WpB5XnZQfGyeDz96X/IGIEOTPNTcyvVn5J3JIIuF
         eVX4eE0w9ZmTIvruwr0NePTjh8mo6XUuBAB115AJ90oUgGQ4skBUEKpTrFqdThBDhQ+f
         XVVHVZnJj3e3aoKYqNe/d3jltLXpJaagt+/C86tNk/835JTrwK+VMnDjZPS4JdM5Jsq3
         l1LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R86yHF8mmwe0DChfPpFQwDkY+H3Wr/ye808Nk2VTBvg=;
        b=hNV9hjgXBGhoJSCyuxJRiYHsON80B67dIgChjja/BKfi0KkzTWtoqnEXFlWAls6BO1
         gVcheYISgtVzXjmNwuO9N7OPEQsS+3wMsbA5UxaFaGCFjhn3ajpVczA5oduFZUkKysUP
         qJGT2UNO4jxyKYIkxVUXySPJYkGwDc5EzeV4Qlkt3mv2qD8PVQlpc39zHRKJ6Qx/hoMB
         T6uH9nxKnCuMtl5nIbj/ZFl5+KTbPovAwwRHmb3wyuSWqgTGjJaCgZptZjq1fTXeO8ou
         UoYfen0Scb3oy01gmC5v51xJbbYFFS8i+PzCdJGErDD74VIJBnPStvUzZ+dEj4R/eTTa
         gfUA==
X-Gm-Message-State: AOAM530ylaVV4syfnEFzs38EP3xcyRaxjf58j8LAUZ8K0HaPR79QkQGd
        hgKWhT+SzIFgWcqARxT65WzeTp/jnKRIYZ3+
X-Google-Smtp-Source: ABdhPJya1JTGzVd3kOFxsi1t7iaUemMEQ98Ba0mxUXGSwtZoZOC57LgjkSXiCmyNrEGXd14lGJuXkA==
X-Received: by 2002:ae9:ea18:: with SMTP id f24mr4182763qkg.135.1602862176849;
        Fri, 16 Oct 2020 08:29:36 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id g1sm1103769qtp.74.2020.10.16.08.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 08:29:36 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v4 8/8] btrfs: introduce rescue=all
Date:   Fri, 16 Oct 2020 11:29:20 -0400
Message-Id: <30396ee8e71dbcd707c84046917a6e378c89fd98.1602862052.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602862052.git.josef@toxicpanda.com>
References: <cover.1602862052.git.josef@toxicpanda.com>
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
 fs/btrfs/super.c | 11 +++++++++++
 fs/btrfs/sysfs.c |  1 +
 2 files changed, 12 insertions(+)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 83689e6659fc..bc28747cf7b3 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -362,6 +362,7 @@ enum {
 	Opt_nologreplay,
 	Opt_ignorebadroots,
 	Opt_ignoredatacsums,
+	Opt_all,
 
 	/* Deprecated options */
 	Opt_recovery,
@@ -461,6 +462,7 @@ static const match_table_t rescue_tokens = {
 	{Opt_ignorebadroots, "ibadroots"},
 	{Opt_ignoredatacsums, "ignoredatacsums"},
 	{Opt_ignoredatacsums, "idatacsums"},
+	{Opt_all, "all"},
 	{Opt_err, NULL},
 };
 
@@ -512,6 +514,15 @@ static int parse_rescue_options(struct btrfs_fs_info *info, const char *options)
 			btrfs_set_and_info(info, IGNOREDATACSUMS,
 					   "ignoring data csums");
 			break;
+		case Opt_all:
+			btrfs_info(info, "enabling all of the rescue options");
+			btrfs_set_and_info(info, IGNOREDATACSUMS,
+					   "ignoring data csums");
+			btrfs_set_and_info(info, IGNOREBADROOTS,
+					   "ignoring bad roots");
+			btrfs_set_and_info(info, NOLOGREPLAY,
+					   "disabling log replay at mount time");
+			break;
 		case Opt_err:
 			btrfs_info(info, "unrecognized rescue option '%s'", p);
 			ret = -EINVAL;
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 86f70a60447b..fcd6c7a9bbd1 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -334,6 +334,7 @@ static const char *rescue_opts[] = {
 	"nologreplay",
 	"ignorebadroots",
 	"ignoredatacsums",
+	"all",
 };
 
 static ssize_t supported_rescue_options_show(struct kobject *kobj,
-- 
2.26.2

