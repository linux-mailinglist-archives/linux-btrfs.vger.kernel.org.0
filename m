Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2D64762E9
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Dec 2021 21:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235292AbhLOUPD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 15:15:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234938AbhLOUPC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 15:15:02 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B46BC061574
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:15:02 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id b67so21270677qkg.6
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=xOQL8GeciX9sJAxPKVtv4ZbnmqRbbstK7Hx/QMm5l8U=;
        b=aJMiD66d8VfLU2GaqBplW+w4aaGj4CmAkLU4tqpkA/kvwEx2JDxZ5lv2cI0c5soVf/
         UtmYNYpsHD90oxF5EnKUaOOdhciyiJuUMCzpl0ulHqN4/S5hvaeGLFS44a+3bVUQ/VSe
         hRaH7YL8zSDPgUMLewU0NCeGFHVOgCNesY6S/qeXZBl0DwLrbANlYIyBHx241X9lt2bR
         awT32oLs+BwQ4/q2JAeTi3HOKquJnOHe9H6k6DHp4ItayJvcc9Y6EyRPdf/6QIpBdtEA
         zoaiFzkaTiWGB2IjhNS1XuFDES7SuB2LA8z5Rw9aBDrmf6cnJBN8bnKaShMgN5o2RZnr
         Vgag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xOQL8GeciX9sJAxPKVtv4ZbnmqRbbstK7Hx/QMm5l8U=;
        b=M9qYgDAd86gDpODJ1NipSaMZSgCZx8ArHIFDPPffW/7G1ZZ1izRJuoG6EtcGbOiCT+
         BepiPF2Gs/wt8tXuj6t1N9jhkVybUNO0B7mLLLTUseI0QMpvrT5ioGzG4uoQO7mVr393
         fxWOIfFAwKcB/DeBxrxMH3U7xxA3JJ3gjH8WXA168V/g/5VuG/Av6wTTDW3/EQn6R+mm
         KKlRtlF1yJcOE0meyv2VDmtUaaaWOCt1e6QJU8QpPIHCggtNcZsdwMHaIudmvdcagHzb
         sY46vWf/EjY8Uzr7/2LtOd6+TNLhOdsQWqrqLOFzGtyI4mLSkoICmXXbI4eZIVx4yWlE
         FULw==
X-Gm-Message-State: AOAM530yENz9Wn6Z2XQSL3jYtkBRv0/5zb92VRhDqn/qBDmVLeh8UGHm
        40KYBt8WwLUBU9mhUWWRvGNq+6bKLPgTQA==
X-Google-Smtp-Source: ABdhPJwFFvokNwwXoBSHvm9rDhPYB7iDlPTPPBa7N6hpU4h+PelGlZKj7vroH1CwPcfQMBqTDekUCw==
X-Received: by 2002:a05:620a:4446:: with SMTP id w6mr10183717qkp.631.1639599300824;
        Wed, 15 Dec 2021 12:15:00 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id j9sm1620973qkp.111.2021.12.15.12.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 12:15:00 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 04/15] btrfs-progs: check: calculate normal flags for extent tree v2 metadata
Date:   Wed, 15 Dec 2021 15:14:42 -0500
Message-Id: <7743102c55910cae8d95b199a9a8d2e346d31c3c.1639598612.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1639598612.git.josef@toxicpanda.com>
References: <cover.1639598612.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Metadata in extent tree v2 will not have FULL_BACKREF set, so simply
calculate normal flags for any metadata blocks we find.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/check/main.c b/check/main.c
index ed38709b..1b3ea079 100644
--- a/check/main.c
+++ b/check/main.c
@@ -6172,6 +6172,9 @@ static int calc_extent_flag(struct cache_tree *extent_cache,
 
 	rec = container_of(cache, struct extent_record, cache);
 
+	if (btrfs_fs_incompat(gfs_info, EXTENT_TREE_V2))
+		goto normal;
+
 	/*
 	 * Except file/reloc tree, we can not have
 	 * FULL BACKREF MODE
-- 
2.26.3

