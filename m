Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6854D3198
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Mar 2022 16:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233801AbiCIPRf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Mar 2022 10:17:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233799AbiCIPRe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Mar 2022 10:17:34 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E860F177D0C
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Mar 2022 07:16:35 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id b8so2597487pjb.4
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Mar 2022 07:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Sx+6GWsE/ARTcr+blW7LOOkZGoDRntA5m1lDIg9VgRg=;
        b=f9VcAE7Ooqedmmljv+qWY5A692chWST5CtPzcGdkS4UCJ9S0CuxuXJieB/yCzagV0p
         /ReYn6Z6K9UfgSFWSZ9l/jE/1chrG5tW5g/NNK6yq3dvLNPB/bQaii97u2uz0plotLCM
         FPgRXKiaHkrSH88z8e7k+6fIh6fdNpx6m2vPxNULEG2dPxLu8L46TfbSNX/pO99HAEaW
         pLVYtDLHygJ+3Tdavx16Mis4Wor623gSJ6x0P333uwQjaUawtniKLvzh8adQ5ibAUlfn
         rXoX8h4jjpqMoIgQGIKTK+9Ix533cY2eBQt4PxUxrXWC+mehiVLxEl4h/VHrW5GaViBW
         19EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sx+6GWsE/ARTcr+blW7LOOkZGoDRntA5m1lDIg9VgRg=;
        b=Z9s5PRuqefP541H69YHBbC9wWlqbxH/DSy8PKGyQEtVdBQ5Pb2wSYTf5oPJbgh+9MZ
         ytd3F+ZVdoDrC5UXXKinrxYR/w4tikaLauEPOvzA+4gzIoJu7G/ELpQtzJrqVcgUFiBF
         vTg9vw8uGJ1vwVy8aiHXnh/za/fLSsLaWyYeN16tHOPqxeZ2PreoLN/7pra1tzkQwRTX
         hW34EavGqm0KyujDV78qXjtYcekwljLxZ+sbpcxD5bC8srR7U/bScE7a8XiyNCe68Qih
         iHffV09wqbPAiCKBsmyKDgvXyxgdxf0exGw8TSKUNtuwIgMmPoX0lNS9uJlex3exOUll
         3EAA==
X-Gm-Message-State: AOAM530Z2XW+yHjBd5t9lT0jKyZRoMHlOV34xt852BtAs4IcIn9Q+OYd
        WTqI6+KOgR7BqYOWIMr9GA8=
X-Google-Smtp-Source: ABdhPJzJkPCsTsaP01Tjr32yObNxtH7kAT4Ir0PhLn1Mw6Yi2/omCCc9rQXnmcDVYOX7FRx9U5WXUw==
X-Received: by 2002:a17:902:7b8d:b0:14b:8884:b4ad with SMTP id w13-20020a1709027b8d00b0014b8884b4admr27420pll.120.1646838995415;
        Wed, 09 Mar 2022 07:16:35 -0800 (PST)
Received: from localhost.localdomain ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id s2-20020a056a001c4200b004f41e1196fasm3192640pfw.17.2022.03.09.07.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 07:16:35 -0800 (PST)
From:   Sidong Yang <realwakka@gmail.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Cc:     Sidong Yang <realwakka@gmail.com>
Subject: [PATCH v2 2/2] btrfs-progs: qgroup: remove unused btrfs_qgroup_inherit_add_group()
Date:   Wed,  9 Mar 2022 15:16:07 +0000
Message-Id: <20220309151607.48650-2-realwakka@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220309151607.48650-1-realwakka@gmail.com>
References: <20220309151607.48650-1-realwakka@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The function btrfs_qgroup_inherit_add_group() was used for options in
create subvolume '-c' or snapshot '-c' or '-x' command. These options
are deleted and the function is not needed everywhere now. So we can
delete it.

Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
 cmds/qgroup.c | 41 -----------------------------------------
 cmds/qgroup.h |  2 --
 2 files changed, 43 deletions(-)

diff --git a/cmds/qgroup.c b/cmds/qgroup.c
index 139dca97..3f59ba05 100644
--- a/cmds/qgroup.c
+++ b/cmds/qgroup.c
@@ -1477,47 +1477,6 @@ int btrfs_qgroup_inherit_add_group(struct btrfs_qgroup_inherit **inherit, char *
 	return 0;
 }
 
-int btrfs_qgroup_inherit_add_copy(struct btrfs_qgroup_inherit **inherit, char *arg,
-			    int type)
-{
-	int ret;
-	u64 qgroup_src;
-	u64 qgroup_dst;
-	char *p;
-	int pos = 0;
-
-	p = strchr(arg, ':');
-	if (!p) {
-bad:
-		error("invalid copy specification, missing separator :");
-		return -EINVAL;
-	}
-	*p = 0;
-	qgroup_src = parse_qgroupid_or_path(arg);
-	qgroup_dst = parse_qgroupid_or_path(p + 1);
-	*p = ':';
-
-	if (!qgroup_src || !qgroup_dst)
-		goto bad;
-
-	if (*inherit)
-		pos = (*inherit)->num_qgroups +
-		      (*inherit)->num_ref_copies * 2 * type;
-
-	ret = qgroup_inherit_realloc(inherit, 2, pos);
-	if (ret)
-		return ret;
-
-	(*inherit)->qgroups[pos++] = qgroup_src;
-	(*inherit)->qgroups[pos++] = qgroup_dst;
-
-	if (!type)
-		++(*inherit)->num_ref_copies;
-	else
-		++(*inherit)->num_excl_copies;
-
-	return 0;
-}
 static const char * const qgroup_cmd_group_usage[] = {
 	"btrfs qgroup <command> [options] <path>",
 	NULL
diff --git a/cmds/qgroup.h b/cmds/qgroup.h
index 69b8c11f..f30cb8a8 100644
--- a/cmds/qgroup.h
+++ b/cmds/qgroup.h
@@ -38,8 +38,6 @@ struct btrfs_qgroup_stats {
 
 int btrfs_qgroup_inherit_size(struct btrfs_qgroup_inherit *p);
 int btrfs_qgroup_inherit_add_group(struct btrfs_qgroup_inherit **inherit, char *arg);
-int btrfs_qgroup_inherit_add_copy(struct btrfs_qgroup_inherit **inherit, char *arg,
-			    int type);
 int btrfs_qgroup_query(int fd, u64 qgroupid, struct btrfs_qgroup_stats *stats);
 
 #endif
-- 
2.25.1

