Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 234341412DE
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 22:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbgAQV0q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 16:26:46 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:44260 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgAQV0q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 16:26:46 -0500
Received: by mail-qv1-f67.google.com with SMTP id n8so11353120qvg.11
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 13:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=79SwE5YlG/SPO84o5TzSObabEBwnaBR1h21On1MbvN8=;
        b=BNA45tixil1hOdgDyOeoEL1HIOhW16VgnAQh2VGQxvsWmk5fZACU1Gs/7aksaIq/4d
         TQYZ6vWj5w7Zg38wI5anXvDD/akM0I7QosLk/ulShsIt2uytpsJiGWQU4knJKBsDppPG
         /JhORO8C4mzOAa6WqamgcK7e3B4ofhSCE/NPgZWOmdNYN3SgC1hLTgxkAr3MnUEUZ5NK
         P/06HA+/9C9WFJgzbsjz2B+iXyaka3kaLsW7XQz2J/MVKK8GDUaPhTmvHu74U2kvMINe
         r+W5mcAWgJrTzlYvGoCziidt/37UKiljYtbP6rRpqnpXNtGDUarR+xuvuia7j0/05oMg
         SQRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=79SwE5YlG/SPO84o5TzSObabEBwnaBR1h21On1MbvN8=;
        b=iAJ23YAImQbm54BcET7LdT8FfPDx0fo9IBUTFFm18FOaU1yrvZr/Rs0dk3CY9q5KQb
         HI0a4tlXmC2NMGzLiNYtIvaCtpATTHWLPBVrVVpNB+e2f7UfmtvceFzqE2k9b7iTu41I
         vuIQAqX35ySYQmneemr0cV1uBNYtmE01Qljp3UCDV6X/cgHV59XXE37O4zl5y/92imqN
         rByAQlC31ecFc+BDPkKWQxpFx9EcYo9Ypv+mlXfmeHhzYKxyswIZqFDc5AqVPtvLdVOR
         y+dIkcefhBumprNcEwP5G2XnDk90qABO97DIQHUljJrvidkLgLQFuJBO4RC8CjOLmA8m
         S2Vw==
X-Gm-Message-State: APjAAAW68A1h8r122XlIryXeh1ZBaT1Y/857aKp3ADkCCuIkqVlNzKgo
        VUrUKxpRWxImVZZiVy6C+/SWA1xcw+INGQ==
X-Google-Smtp-Source: APXvYqxaN2rA2boG+7WePD0MeXBOJV9jOMtwZYCyGRwfSeHbG+c3NFR9I35KzrF12fzFKvO8V7KfiA==
X-Received: by 2002:a05:6214:1923:: with SMTP id es3mr9994032qvb.49.1579296405061;
        Fri, 17 Jan 2020 13:26:45 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id u57sm13542845qth.68.2020.01.17.13.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 13:26:44 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 22/43] btrfs: hold a ref on the root in prepare_to_merge
Date:   Fri, 17 Jan 2020 16:25:41 -0500
Message-Id: <20200117212602.6737-23-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117212602.6737-1-josef@toxicpanda.com>
References: <20200117212602.6737-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We look up the reloc roots corresponding root, we need to hold a ref on
that root.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 990595a27a15..53df57b59bc3 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2474,6 +2474,8 @@ int prepare_to_merge(struct reloc_control *rc, int err)
 		list_del_init(&reloc_root->root_list);
 
 		root = read_fs_root(fs_info, reloc_root->root_key.offset);
+		if (!btrfs_grab_fs_root(root))
+			BUG();
 		BUG_ON(IS_ERR(root));
 		BUG_ON(root->reloc_root != reloc_root);
 
@@ -2486,6 +2488,7 @@ int prepare_to_merge(struct reloc_control *rc, int err)
 		btrfs_update_reloc_root(trans, root);
 
 		list_add(&reloc_root->root_list, &reloc_roots);
+		btrfs_put_fs_root(root);
 	}
 
 	list_splice(&reloc_roots, &rc->reloc_roots);
-- 
2.24.1

