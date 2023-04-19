Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3756E839B
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Apr 2023 23:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbjDSVZJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Apr 2023 17:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232095AbjDSVYv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Apr 2023 17:24:51 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B12B5240
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:24:24 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id qf26so1046610qvb.6
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1681939461; x=1684531461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/aGUmJ58PhF22BYrne7qOV0ewnxxkSCoZ+9LxhYk7Ro=;
        b=DZ+A0yWmeJv0r7bY4TLbu95FsLlxf6M7IwxGVLYWGrrNmAnGj/IgbHbwRYuTDsHvWV
         jvOEzvZbTF6f4Uk/GOU2h/++PgokYTsHyfUXSFLzJE8XZgSpdP1ha3L6F5whSlNdS1NM
         UFgYQb0YIPCxSYvc32C5OAMG72Qvm/g/AW2PxxAZgH11wFEIrXlw2y4JWu3p0BrbYoxn
         nbTc0qSZmldevPhlL2DOuYk/t5SG7nxxvoPsEZd/5AH7f5BwkQoRX7beVf3PEVAMAYfk
         ry6a8DAXh+nNb26lV2hlVtoDBKhip4526ZBsS4TkCtaKP8p69a4Gy9ZpafSuoxQAJCsu
         Vueg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681939461; x=1684531461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/aGUmJ58PhF22BYrne7qOV0ewnxxkSCoZ+9LxhYk7Ro=;
        b=UQxB5QBPimxL98ajhbKKpyREPR1SnKl7Q5RwEQUa7MZPz21eRjrIdpvRqVB9J5H1na
         ks+rbNt1k2NhLZAiCxoyPnd6YAwDvmkfapzs3khHvXZ3AgRvD4s6vi2gofhgfFJf6Lc7
         RTmslU0J0Cp7LF9cdvByLpepI0UmML3zO9J+D8/i7eTG7Rp2ao2Wzy6HGUJ0zHi5gvJ/
         /2IPIcUDFtUpYYNYMjpHWjrZm8l6Dm2yLr3bTYrnnXltsYtqbf5wD/fxFXgNLnimcX44
         M4AtIvsthkJci7RCN6B5XQouEUE/Ko7AI88lzTvSg01F5jAlLjsh064Xd5iW2DuqbPJT
         jf+A==
X-Gm-Message-State: AAQBX9eGC5aMiMoU/++m41JNpN7i9o0+AojGJyKHfR+il9oTVVoSXImq
        p2DcfX8YxQ56ByQ5SOGmnxIpjjW2o/AV27udye1+/Q==
X-Google-Smtp-Source: AKy350YBb0NuqxsIxcFiNSxaTnrXYAS5qny+3m88bjvX42uqFVotwOTBpE+bIBP1q9Cs5TADFuk5hQ==
X-Received: by 2002:a05:6214:da7:b0:5ef:5138:1e4d with SMTP id h7-20020a0562140da700b005ef51381e4dmr34425818qvh.42.1681939461491;
        Wed, 19 Apr 2023 14:24:21 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id e23-20020a0caa57000000b005e3bda8a5e0sm12790qvb.6.2023.04.19.14.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 14:24:21 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 06/18] btrfs-progs: add btrfs_is_testing helper
Date:   Wed, 19 Apr 2023 17:23:57 -0400
Message-Id: <a98097300b247750c4f7e70838f9e67af491f055.1681939316.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1681939316.git.josef@toxicpanda.com>
References: <cover.1681939316.git.josef@toxicpanda.com>
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

This is sprinkled throughout the kernel code for the in-kernel self
tests.  Add the helper to btrfs-progs to make it easier to sync the
kernel code.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/ctree.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index c892d707..26171288 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -389,6 +389,11 @@ static inline bool btrfs_is_zoned(const struct btrfs_fs_info *fs_info)
 	return fs_info->zoned != 0;
 }
 
+static inline bool btrfs_is_testing(const struct btrfs_fs_info *fs_info)
+{
+	return false;
+}
+
 /*
  * The state of btrfs root
  */
-- 
2.40.0

