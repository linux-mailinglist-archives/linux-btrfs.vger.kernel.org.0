Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A489D151160
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2020 21:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbgBCUud (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Feb 2020 15:50:33 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35708 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727215AbgBCUud (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Feb 2020 15:50:33 -0500
Received: by mail-qt1-f194.google.com with SMTP id n17so11442901qtv.2
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Feb 2020 12:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=YFAcPg4djdO95KN66+LsxZOdz0HVQ8aUClZQzb7cE+g=;
        b=0bmBrLvgMbjh8buI3Y8Qq5HPrl1jl0VuKJIY0vf9b6S6UwbWMNXayXXiEfNwqqCcFk
         aiMGdBpwkXfwRpZGMdgHxCggRsDTjvQjHS25BwLfjv55l5xb8Qk8brlQoQTZGrjMwFp7
         wxMpJAU2nf59l6qnbAfkd+FlIK4Qo/d28zTueV7+G4UWb7vN0vfCp35J45uyseMCAlbm
         YbuVQB64vDS8hYd5t4oDUkkgVyfxqgsAVmHVaCGZSu9HoKv64t3B5b/Ot6O4zhE7oq4u
         twHUWNE/ggv5hzPF09Qr5O7g7jtxzhCuYBbZOWaXxwaXXuERo7aEc9R0qXBJgLAPZo8O
         iReQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YFAcPg4djdO95KN66+LsxZOdz0HVQ8aUClZQzb7cE+g=;
        b=kbx7u0tbNRB/bjBOOXwUg8IDDtrZ+/OEg9od3BwjrAxCJf4OrVuLAOf917uhI63IJw
         ggY/MjT1lMHvKjQ0RdStqF/vQwDorFyEYynQZdPKUbIKIDuXQUpdBP+wkyEWro/lsXD5
         +kcbk1QOmscPvD+3yrOOv8E03UBXEaXuj2qpMOdqaQGP/7+0AnEVtoN0Mi5vk2Qc8s42
         wnC0SPEQ6qXsckBzJU/Hi1paxAUuPCO6jEzgq+pkUhZ/Y7bMBVqRplli1o/+rMo7B6Pm
         YAjTYX2RggZhPfdSLcC2PwMXm3bmVKIT2jt7LwZcPZs+UZmmjUnyviEaOqB59qCuvH8u
         Z6Kw==
X-Gm-Message-State: APjAAAVmgo7N+UEPlCfx01n34MVeJ6HpcIUnumhOn1qNfZmvL9Vqj/iH
        gHMiKR8ldMSmaZRFVBfriJeGRm89L4IuBw==
X-Google-Smtp-Source: APXvYqwyx3FTZVPOZs/Lm20AS0kffAiOi4AvcZ5GJinU1mpEW17npnzJYa6p3H/YxqCIgm/jJEMoZQ==
X-Received: by 2002:ac8:33f8:: with SMTP id d53mr25208473qtb.86.1580763030560;
        Mon, 03 Feb 2020 12:50:30 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id z185sm4459250qkb.116.2020.02.03.12.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 12:50:29 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 22/24] btrfs: flush delayed refs when trying to reserve data space
Date:   Mon,  3 Feb 2020 15:49:49 -0500
Message-Id: <20200203204951.517751-23-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200203204951.517751-1-josef@toxicpanda.com>
References: <20200203204951.517751-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We can end up with free'd extents in the delayed refs, and thus
may_commit_transaction() may not think we have enough pinned space to
commit the transaction and we'll ENOSPC early.  Handle this by running
the delayed refs in order to make sure pinned is uptodate before we try
to commit the transaction.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index d9085322bacd..8d5d57d4aba3 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -805,6 +805,7 @@ static const enum btrfs_flush_state evict_flush_states[] = {
 static const enum btrfs_flush_state data_flush_states[] = {
 	FLUSH_DELALLOC_WAIT,
 	RUN_DELAYED_IPUTS,
+	FLUSH_DELAYED_REFS,
 	COMMIT_TRANS,
 };
 
-- 
2.24.1

