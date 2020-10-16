Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31935290857
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Oct 2020 17:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410101AbgJPP30 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Oct 2020 11:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407581AbgJPP30 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Oct 2020 11:29:26 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A103C061755
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Oct 2020 08:29:25 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id c2so2208331qkf.10
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Oct 2020 08:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LSEkm8l0uk4G5NH+FdJxG9QmpxzL0u4w35EHq1RNxq4=;
        b=BxOK23nfeXNqtO1+9bulz46MV7nyIKHapSoFRWx9/kUsCS1n9dW7m/LKI19LGIzAud
         tN02ycE4zqT+r65UNCpBMBraUeSjzCV5bF3NQF1U+Qkvqay8ROVhh1esoWGQql+bs9p0
         BoSQ4wc4NFktgviiIu8gVdh02i8JKm2JblISKQJS1dcnho1Ydur00v6AgzeFj7tDAoZJ
         VmiWgOyBNF6CwDsJt/7uVHf4oufFTAcEJIbKiMgSv3PbqeGMhMvitZW+Ct/s05l34h8P
         CtlA0n4QgS922RFRA/LrGn8fIE/x6akInSzyO2t//L8LCJgaF35KD3xtypM7rIJGTNeG
         QmGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LSEkm8l0uk4G5NH+FdJxG9QmpxzL0u4w35EHq1RNxq4=;
        b=HRSph8mdZ7rWKMWE2IUDGsGzQ+U7se0jlYUv0e3bDuASZtaYVMABK6ZbGkHILcOPlV
         zailE4zPNczW/2CWTuaF28U/KxaPExYr/0dXQjhCehoEWJ2pYQ+eu1cOj+4/uuYYd0PI
         gcUr06ty7cZXZq9BUoap1RFOKtkHR3Ks3qCBnL0Vp6oM5atzt1cWNByAe85/Tkw5SkUW
         REAdaESdJ/eCYbdmPAsGnsuDxByiGnHRHfr9k7OGU37V5AAiVEaCuyYC+o5mtmDyVovE
         a0AKpiRENwVmDRNFBo7SllLI0yreU4E5bK6x9IswoL1SyV7i4URpIW4/vYqykEuNW03k
         Jvfw==
X-Gm-Message-State: AOAM531RP1BARR3J3stRUCXZudEAAG/rRNUf1mO345Ay0iZdv3YhgqZH
        GW8awzuuAVzY/8EgmE3JVRUm3HZkih5gVbpW
X-Google-Smtp-Source: ABdhPJyy20bAx+GafiJ03sZOwjh9lkqrTv8GkecmPhBKKMtiHmKQYiPJotshJ9MkfljoEXJ0Xwn5Cg==
X-Received: by 2002:a05:620a:ed1:: with SMTP id x17mr4364909qkm.322.1602862163549;
        Fri, 16 Oct 2020 08:29:23 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id f187sm983870qke.60.2020.10.16.08.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 08:29:22 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>
Subject: [PATCH v4 1/8] btrfs: unify the ro checking for mount options
Date:   Fri, 16 Oct 2020 11:29:13 -0400
Message-Id: <4e8692bf3f8e37824710e91a8a13f3ea20b3cdcc.1602862052.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602862052.git.josef@toxicpanda.com>
References: <cover.1602862052.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We're going to be adding more options that require RDONLY, so add a
helper to do the check and error out if we don't have RDONLY set.

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/super.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 8840a4fa81eb..f99e89ec46b2 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -458,6 +458,17 @@ static const match_table_t rescue_tokens = {
 	{Opt_err, NULL},
 };
 
+static bool check_ro_option(struct btrfs_fs_info *fs_info, unsigned long opt,
+			    const char *opt_name)
+{
+	if (fs_info->mount_opt & opt) {
+		btrfs_err(fs_info, "%s must be used with ro mount option",
+			  opt_name);
+		return true;
+	}
+	return false;
+}
+
 static int parse_rescue_options(struct btrfs_fs_info *info, const char *options)
 {
 	char *opts;
@@ -968,14 +979,12 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 		}
 	}
 check:
-	/*
-	 * Extra check for current option against current flag
-	 */
-	if (btrfs_test_opt(info, NOLOGREPLAY) && !(new_flags & SB_RDONLY)) {
-		btrfs_err(info,
-			  "nologreplay must be used with ro mount option");
+	/* We're read-only, don't have to check. */
+	if (new_flags & SB_RDONLY)
+		goto out;
+
+	if (check_ro_option(info, BTRFS_MOUNT_NOLOGREPLAY, "nologreplay"))
 		ret = -EINVAL;
-	}
 out:
 	if (btrfs_fs_compat_ro(info, FREE_SPACE_TREE) &&
 	    !btrfs_test_opt(info, FREE_SPACE_TREE) &&
-- 
2.26.2

