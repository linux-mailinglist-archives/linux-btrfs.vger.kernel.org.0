Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 265A344CA21
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Nov 2021 21:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbhKJULA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Nov 2021 15:11:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbhKJULA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Nov 2021 15:11:00 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D3DC061764
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 12:08:12 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id p19so3226814qtw.12
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 12:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J5xUuI659t30AD1pZp9xW4jARRSRvXgqIMVzU6dSKBo=;
        b=w/3vdgKDbTTfoTCSt85q+t3A3HrZAFt9TZzhicowZLoWu7s/G/2z0yU0IruAOcGxhp
         GwbYKBHqwVfEIloIlp3fX9Jkx8ThFcoN4uUAt66FyH5wlLIbDDiS35/2BrahQMdk7YL9
         55mt5dALstJo7i6DWcjwV6XKPGWRyVNXMYm+bmmZeofVDgFMfjMo7Pp/v3sG5Ae50uXD
         vjeVPeJeO1K9S/ECKRnqlDdJA/QGljp2hcJ+M+2oiB4N2y3C1uZjyuHM6Y43jop7xrEk
         4Wg939AAaK4tYRx73DqLZ53YpRPBN6pZvPDYOTkkkGT9yLr80aIwITOtlDok3lNRLiYa
         ihDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J5xUuI659t30AD1pZp9xW4jARRSRvXgqIMVzU6dSKBo=;
        b=2vaBQbRSpufAn9nI0fKgsGEU0OY2uuccSAo29Xu1KuGHZ3DP3rKMtQuvFc3f36G+75
         Mhy26r0zl4Eoyau2hOo0+OMUplfBQAnu/VjTLt6v7fSO+0mPnwmv8fLgtbGZzA3v+0ea
         QxcWFNoQuwAXXoEQJEbUb8/rvzaU5nxpjE54v5QJFAnSVyn+r0SMGgq/QiM1MugqBdws
         8Nl+I8F1/uGOQFE38cApDQKFkuFAi+4xCd1mMa/ouBKyB10+RojmYDudA0lE9u6W6MmH
         eldHNgUyTg7r73E8UbQ0pcUt1HViYbPln6mkxq+FKSXkUOUgtouO1GLwmpD8pZu0vynK
         Jk5w==
X-Gm-Message-State: AOAM530ahmQEEMn3TDsNafAlETVVIRdoIshxhkDfQVtGWHI0kkp58eOd
        zirbtN75z9e55EMqs/JOfMj59REPnqjDmw==
X-Google-Smtp-Source: ABdhPJxq5rjrOUA/kYCX8I0O4tSP9p+gb0ktj8Dfuao/aS+W5xbbQ0KqoaMnZO9DrJXy4xECrhOmPg==
X-Received: by 2002:ac8:5acb:: with SMTP id d11mr1820558qtd.109.1636574891133;
        Wed, 10 Nov 2021 12:08:11 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id br30sm373998qkb.104.2021.11.10.12.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 12:08:10 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v2 03/13] btrfs-progs: check: don't walk down non fs-trees for qgroup check
Date:   Wed, 10 Nov 2021 15:07:54 -0500
Message-Id: <b8339a9e3e5bd4c20ab51df2dd32a3d550351e12.1636574767.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636574767.git.josef@toxicpanda.com>
References: <cover.1636574767.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We will lookup implied refs for every root id for every block that we
find when verifying qgroups, but we don't need to worry about non
fstrees, so skip them here.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/qgroup-verify.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/check/qgroup-verify.c b/check/qgroup-verify.c
index 14645c85..a514fee1 100644
--- a/check/qgroup-verify.c
+++ b/check/qgroup-verify.c
@@ -765,6 +765,10 @@ static int add_refs_for_implied(struct btrfs_fs_info *info, u64 bytenr,
 	struct btrfs_root *root;
 	struct btrfs_key key;
 
+	/* If this is a global tree skip it. */
+	if (!is_fstree(root_id))
+		return 0;
+
 	/* Tree reloc tree doesn't contribute qgroup, skip it */
 	if (root_id == BTRFS_TREE_RELOC_OBJECTID)
 		return 0;
-- 
2.26.3

