Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F88D4D0AB9
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 23:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239703AbiCGWOX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 17:14:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235109AbiCGWOX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 17:14:23 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE92755762
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 14:13:27 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id z66so13246123qke.10
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Mar 2022 14:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=LHS9rRwM5mwTZq15h/26b1I+L2Ts42XJNZmDCP9ICqE=;
        b=7oMFVe94aBLRj3X4DYmCnybxP/fYehrHVzPr4s4/vbGFEWSZ97KzuM3KzHrpiMSOFp
         iz23O4aZ5OBxTUgfdP82YdCsJA3NZRIrm5YMXShoCviYlfIYzxYToPwA/4e/RTAsc4ek
         u389o0SvG3aMOwoOCv3x+jwhPXrDn4EMfdQ5Np1yIVp7YELWuAf+zlfI9HkZBbpx4tol
         q2LUUkTUGoo4d01LGigMkJ+fYcGLuL+X+NiV2V7N+bGIdktuw+jNbtQCBhAAy79/90UT
         eKkIC4tRQEfwDtKU/JPX1QDP+AbDA3kUblNswBz3YR9mxCY5EHQeGAs5pP8p2iYrVQx5
         xwjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LHS9rRwM5mwTZq15h/26b1I+L2Ts42XJNZmDCP9ICqE=;
        b=B5URICfouF9sXF9OmkutmgsbYZGOTXtjU1fbfyPZ+W82YJhT6Op/vcrXoUGqYgRPBK
         i40j+uHC/NQMm8TEHpeX7+TUW2MAh/8tyEscHcYRsqkt6WBKnjjqw7xP65gPA0vib8bd
         2Fuv6agsYdbA3UX5f1K9itK5YDLwi65jdzkBwe/yUI6yrpZs+UTN2lknMk58a5gzrwO2
         QlwlEEfEePG9RO4tHPxiIlFOdjNaJExExnP2MtphH2rSP/USfQGQ+hiue+96GQXNOktu
         nhaHMo5jUPRn59lGL6q9RasdHEHooYQq9AUhnyzMPyr1xJRO2NMbNkOVMoY/V8xW4R9G
         gGHw==
X-Gm-Message-State: AOAM532Qh2tLgV1L6iouafb/qiTRvxLN9k0F+F2G5poMpNBgaFX1DfQq
        3R3QYm42mbbeD5C+sHkJEhhZL9CLAHKf/4dR
X-Google-Smtp-Source: ABdhPJwFGwqyyJ7frnh7JWQajvuQ70Npxma3s2GhpPcD1MglLxs99hMG2DW8nITiLv8vr0jaH1kTBg==
X-Received: by 2002:a37:a985:0:b0:67b:322a:2aa7 with SMTP id s127-20020a37a985000000b0067b322a2aa7mr3426758qke.578.1646691206625;
        Mon, 07 Mar 2022 14:13:26 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id r2-20020a05620a03c200b00477981c7129sm6614133qkm.17.2022.03.07.14.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:13:26 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 03/15] btrfs-progs: check: skip extent backref for metadata in extent tree v2
Date:   Mon,  7 Mar 2022 17:13:08 -0500
Message-Id: <bd575b75a1cdf8afe50071c1761cecac44c99bfd.1646691128.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1646691128.git.josef@toxicpanda.com>
References: <cover.1646691128.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We do not track backrefs for metadata in the extent root with extent
tree v2, simply skip adding the backref object.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/main.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/check/main.c b/check/main.c
index 2ab68248..b5d08280 100644
--- a/check/main.c
+++ b/check/main.c
@@ -4798,6 +4798,13 @@ static int add_tree_backref(struct cache_tree *extent_cache, u64 bytenr,
 	int ret;
 	bool insert = false;
 
+	/*
+	 * There are no extent references for metadata in extent tree v2, skip
+	 * this.
+	 */
+	if (btrfs_fs_incompat(gfs_info, EXTENT_TREE_V2))
+		return 0;
+
 	cache = lookup_cache_extent(extent_cache, bytenr, 1);
 	if (!cache) {
 		struct extent_record tmpl;
-- 
2.26.3

