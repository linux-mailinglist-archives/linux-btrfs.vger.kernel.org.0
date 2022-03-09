Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D559F4D2A65
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Mar 2022 09:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbiCIIPr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Mar 2022 03:15:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbiCIIPp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Mar 2022 03:15:45 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C18E15679A
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Mar 2022 00:14:47 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id s42so1633980pfg.0
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Mar 2022 00:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Sx+6GWsE/ARTcr+blW7LOOkZGoDRntA5m1lDIg9VgRg=;
        b=dtf9lLlMIcYlsHI7Z8+t31Xjm42PZzGaFfuOeUnKbQXlIRPTE0m8lZza82SBJhDnrY
         fZZwjqqTNRybNsyfHYi+GkTCsAfkDXZqMsRLVQgyKSQIvOCTY9KbHEZ0f9j+kSoqaVtt
         6z4C7YtLcWO4CE14ajn0o2nvPr18242PxbWQLOgdHY8KMa7tUtFshY+Rs3/pNJRee5dF
         aWrqaQMTFpFlDcrAvL98WV9PHk2MkXSr+5QwJYapYOPJQxAt9aRb48TX4PYu79KqMGMP
         dqAVRf49fuTl+Dksm81ClK9RNdTFxwypy86uOwMw+2KDccRyB2JPdtJ6rSTuGD/w2Saq
         HuwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sx+6GWsE/ARTcr+blW7LOOkZGoDRntA5m1lDIg9VgRg=;
        b=JJAhjqFy9yQ1rHzAnFVLjrDJe+PX6/wGFxywys6nSq8JLnM+xCnBgxaBLk0DJ5bz8j
         ACjy2cG10vQ0eYO0RL+g5QaNFvuxcCrwWB+Veon6vWp2YXmpnX09dEwx77YY/qEnDGLA
         trVOMHfzplWx4Hz4/9nceTZ1lBsAkXORlgcZ8K1Z6TbYsQPxp+9jpiL17tPY+pw3nrll
         ejmCg5bF6AMPstEA3W52Iyg6SfMg9rhh2/FrGMo3A3AmSDm7B0FwY7UB2OJ9BinpsXj0
         CYA15NLiWmVjz6bxDn1U63G7qIybsbvWESv89Bg+6lrEf+bveNZSnMICh2QSkGn0N6rj
         Vl0g==
X-Gm-Message-State: AOAM5331NO6Y9q3H6dSa3fVTkIZ40R1N/cDsGJqqZ3zDkLfL7HC4lbAb
        K9FwAacb4QXydrOoZT3pAIZ99b+fK+o=
X-Google-Smtp-Source: ABdhPJwQswj0/qT7WuSUkFUI0YF8NP1MQL5e/H68frATIHumsYYrw12kcgvPldETJ7KJOBGyCCaW7w==
X-Received: by 2002:a05:6a02:193:b0:375:65a5:2fcd with SMTP id bj19-20020a056a02019300b0037565a52fcdmr17255467pgb.288.1646813687005;
        Wed, 09 Mar 2022 00:14:47 -0800 (PST)
Received: from localhost.localdomain ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id t9-20020a056a0021c900b004f72e3838aasm1716275pfj.183.2022.03.09.00.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 00:14:46 -0800 (PST)
From:   Sidong Yang <realwakka@gmail.com>
To:     linux-btrfs@vger.kernel.org, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Sidong Yang <realwakka@gmail.com>
Subject: [PATCH 2/2] btrfs-progs: qgroup: remove unused btrfs_qgroup_inherit_add_group()
Date:   Wed,  9 Mar 2022 08:14:18 +0000
Message-Id: <20220309081418.46215-2-realwakka@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220309081418.46215-1-realwakka@gmail.com>
References: <20220309081418.46215-1-realwakka@gmail.com>
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

