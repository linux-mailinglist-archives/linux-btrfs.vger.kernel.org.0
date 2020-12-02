Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83D852CC721
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Dec 2020 20:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389764AbgLBTxQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 14:53:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387412AbgLBTxP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Dec 2020 14:53:15 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B224DC094243
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Dec 2020 11:52:25 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id k4so1966277qtj.10
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Dec 2020 11:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=41wznrbbP7EJRnAZgFwcJ8Zc4Rn6ZDo/o1TGdHD4OCU=;
        b=BP9QevaUxLQzT6aaGjXRBcHwG734FzM/Cq43dRbCEPPh/ppp+j1DaSmKzT87GkSDJk
         V2id0t8pgjkiJQAo5a3AcFRLLQL5xauwe2CdToRtQQsW9sUmDngUDXXS675IZWrgs7q2
         W7VZhEm1J1N3TtPH9LtmtLBIXHcYTTSAd4pFjOLTolr2mYi0qeawNn7eNonXedx5218Z
         8puprf4L57r0UsyFVsw4sz22JG+VCoGb14azCb5yK/+DWasD+8IkM1k3GgPZcq/h9hg8
         FhCx2My8OJduLF1Shp1wDuPWvm1uRwruCjj6GXifK7UPz1zk32jjnHsfcBfiy7axokd8
         YLUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=41wznrbbP7EJRnAZgFwcJ8Zc4Rn6ZDo/o1TGdHD4OCU=;
        b=knmz4L6ec37ca4P9WoB2JLxaOqJY4Oc2+uE8UBJ+slO8g3WGLixZ3+dCBDd6W8NUDz
         POeOf1yEmZQj2v7dJEsf8U4cj/HCOr/DZhxW6T03Vvn02vihxJ1InOJuJoslFT9ptJFZ
         z76Ecf+62ultjamxSFyZmVPmLnqSkFqeZCx/FJ2K8qwivRZSnV50FSDHs+suHtTQL5Oz
         mV/q4mPRbB4C7RgZV3Fz4th0nUbGYmsDo9OiPr7UPNvFxEF9aIPl7n4ROY2dKw8FKnXG
         ktJ9gfMqr0yMi+eTD79dRXwBF9YWSwVr2qL3X9j+7iXrmLewE3nRzbANWPKB5a+fSKui
         vy1A==
X-Gm-Message-State: AOAM531fQska93sI+F+HHbrLU+CR+WP7Ia405jy+Kq/0UKyezNKDo+0/
        vvWmPVTtwdTSEAb/MIiY0s58wwrKK7vvIg==
X-Google-Smtp-Source: ABdhPJwxclJq9XbBbfyX+Q0mL1HD3vCQCH499xpAtfi1xxAskNRwrdJcMTc++lgtBfgeW/HBDzgTng==
X-Received: by 2002:aed:2ae2:: with SMTP id t89mr4297169qtd.82.1606938744611;
        Wed, 02 Dec 2020 11:52:24 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id b14sm2841684qti.97.2020.12.02.11.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 11:52:23 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 39/54] btrfs: handle btrfs_search_slot failure in replace_path
Date:   Wed,  2 Dec 2020 14:50:57 -0500
Message-Id: <3ad95395a035d5364f77170c6d734b96f7ecc345.1606938211.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1606938211.git.josef@toxicpanda.com>
References: <cover.1606938211.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This can fail for any number of reasons, why bring the whole box down
with it?

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 781908f3a3af..8c407ebc5500 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1314,7 +1314,8 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 		path->lowest_level = level;
 		ret = btrfs_search_slot(trans, src, &key, path, 0, 1);
 		path->lowest_level = 0;
-		BUG_ON(ret);
+		if (ret)
+			break;
 
 		/*
 		 * Info qgroup to trace both subtrees.
-- 
2.26.2

