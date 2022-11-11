Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C11D16263A3
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Nov 2022 22:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234146AbiKKVap (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Nov 2022 16:30:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234074AbiKKVae (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Nov 2022 16:30:34 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B71BF027
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Nov 2022 13:30:33 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id w10so4121687qvr.3
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Nov 2022 13:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BGTLGPNKt9rHwMmVBTUJWDbcQrsnFY5gBQrILtbVypo=;
        b=0hYUfApvt6Vw7PRcHGmtR7wzDR8fne/J+4qBEwl1Pdq6K9L/2Sw9a61Ow7f0vHXl4G
         VgFDO7YBjI7beak3GHx2EEcQT7I9ZTo6YhYMA6rpZDVLuuJteI6CCFFJQld3TFKM080z
         QDBZ4P7p9b1EJb3rA/dCtVBqShZ3NYiRJJWPHWso3SksAgBaxPyQPcxoteaKi8rm1x6J
         YQcB5LKP6FRd78DwAibSFCBEc8rP+zd+bNu9XS5NTNDS2VF54GwN3eNhSR6o5KzRulYL
         EKmbAr/P7t9xXdn1ZlUWLkr9TMn/uzoJZ2a8f5WtAUESHo7ax2VXx77mfKTWvgyOVVOR
         GMPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BGTLGPNKt9rHwMmVBTUJWDbcQrsnFY5gBQrILtbVypo=;
        b=Rzt+Z2HICmbnVCPuGTA1jWBYEi8c7/V84UhvHHySjZCLhmtKTvBgtiibT4S0+4juvg
         Ay9xJkCSweTHhHx+B2/rEVivhsGfdNs6Tv57LmFCvf9hjFrsKcs/smDFlPN24n4eSqwB
         IId+p7uOOHxfpLfBgo6d8kwy0rPyP2GAxoJUKVG0MIfR59Za4anyqV+EvLzcvLv53JwE
         7imgthh1FySYai8L1GQauFmxopcauIWBSge8BmIqvcmyiyp9bT1Qb/Z+ENznUCYfLQMB
         ng6m519vOKmx7VGwjpf77ruj2y0jhkrzZEZQ1eUAv3sSASKJAa3f81Uhh9Es3lJVMxQp
         Dtpw==
X-Gm-Message-State: ANoB5pkbUJl/91WV6spIyau4s6osRvM/GnROQROQ+11L4NlnaefNxHM4
        /xKXqN9xhKdu4DSqHAzl5xYBX7qfsidJsQ==
X-Google-Smtp-Source: AA0mqf6bEb/gH9ktqC0hnjh0aVCmzZBjAjhcsYGH/knu/c8vas1/K25Ma4U/JSe+l9KtGdwdyv3s8A==
X-Received: by 2002:a0c:edce:0:b0:4b4:51f1:7d74 with SMTP id i14-20020a0cedce000000b004b451f17d74mr3731451qvr.121.1668202232450;
        Fri, 11 Nov 2022 13:30:32 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id bz25-20020a05622a1e9900b003a51e6b6c95sm1844894qtb.14.2022.11.11.13.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 13:30:32 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 11/14] btrfs: stop using btrfs_root_item_v0
Date:   Fri, 11 Nov 2022 16:30:12 -0500
Message-Id: <a545cdcdd503c032a36aa94dd5ac1b272e59c303.1668201935.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1668201935.git.josef@toxicpanda.com>
References: <cover.1668201935.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This isn't defined in the kernel, we simply check if the root item size
is less than btrfs_root_item, so adjust the user of btrfs_root_item_v0
to make a similar check.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 cmds/subvolume-list.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/cmds/subvolume-list.c b/cmds/subvolume-list.c
index 6997d877..1c734f50 100644
--- a/cmds/subvolume-list.c
+++ b/cmds/subvolume-list.c
@@ -870,8 +870,8 @@ static int list_subvol_search(int fd, struct rb_root *root_lookup)
 				ri = (struct btrfs_root_item *)(args.buf + off);
 				gen = btrfs_root_generation(ri);
 				flags = btrfs_root_flags(ri);
-				if(sh.len >
-				   sizeof(struct btrfs_root_item_v0)) {
+				if(sh.len <
+				   sizeof(struct btrfs_root_item)) {
 					otime = btrfs_stack_timespec_sec(&ri->otime);
 					ogen = btrfs_root_otransid(ri);
 					memcpy(uuid, ri->uuid, BTRFS_UUID_SIZE);
-- 
2.26.3

