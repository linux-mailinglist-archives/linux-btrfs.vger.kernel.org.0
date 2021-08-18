Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D92043F0D66
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Aug 2021 23:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234028AbhHRVeT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Aug 2021 17:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234031AbhHRVeM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Aug 2021 17:34:12 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8C8C0613D9
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Aug 2021 14:33:35 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id q6so2488623qvs.12
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Aug 2021 14:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Av+6P7r7wMUOiqp0xZ3VE9CpiVt04+/HbLnF1QpYMlY=;
        b=170ikBXMgTAXOQQqLuHoPD4AuOSyDaQaAQw1iJIkKlyu1ixhtdJVJGk829/kfbppC8
         FgEe8hdG277NBC0ioZEu5SV3L4RRAO2eyT+8QHuc8I/zBdTpZhmGbBqkGQFMpVP/9rc7
         uTGehQU/jzMzvQDBkeH0F4KFW5IbR6wHK268IsGm2jpErlJIaO4wb4DHJ88sKxVoXkDh
         J0zpZ8Q5QLImHBvp38ezdbsHFwI6h36RWXTPUAu12g1V2+1/ZRfqLbfLoZpjF2v6iAXi
         prgNMKkDM1b47OyZBcP8acEbZe7L5VU+hJrrSWDSP5/S+q78Ipg+KUWDL6YefH/bVMXA
         x6OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Av+6P7r7wMUOiqp0xZ3VE9CpiVt04+/HbLnF1QpYMlY=;
        b=qf5847clKqbUGU9RXW56zddjARNoK2pRCdPJdJ63s+8E4yJliNiUBN89rqcrZCgXBm
         AgCwJpYPH1PyqacmHlptJgwUUwrKDyuj3qfIZgJ0R6wHatKVAErtmGrAILHDBqt+eRHS
         DqxzPkRf1wJ/oYPS2FhdpZ0xyJudg2fcubFZxlEFO8QwrjhIDQZrUv3T5ZAwHhsvT79Z
         QOxxySoFZgSq+IOAEYBvuvmAqqGGn1+cBXoKqKJZhnMaZWI3lzJ+yOIocf9fmPE46eIV
         xdm0zhhBdulpk36F5LoKDDeVMxmNwjuJlj/s/8HdbfuK7Qa7q0/a9C979szlgWWCuelN
         QIOw==
X-Gm-Message-State: AOAM532mpCG+ayO8HH9uwRLbl/l+BRJkXx+F6hmIg18zoTQwaUfK16E2
        zdHU1EvgsyuWKGLsrg6HBfJPERdTLYnkKQ==
X-Google-Smtp-Source: ABdhPJwZ7FJi0eHYE67aO22/7gIalNlVZnNMiVpKLhCdurASym08RXaQmYschGSPAhaF055pBiN/ZA==
X-Received: by 2002:a05:6214:12a9:: with SMTP id w9mr11173283qvu.0.1629322414588;
        Wed, 18 Aug 2021 14:33:34 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id c7sm618251qtv.9.2021.08.18.14.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 14:33:34 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 05/12] btrfs-progs: do not double add unaligned extent records
Date:   Wed, 18 Aug 2021 17:33:17 -0400
Message-Id: <7f5f08739fa5f7ecd207034e2715f863799cbdd4.1629322156.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1629322156.git.josef@toxicpanda.com>
References: <cover.1629322156.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The repair cycle in the main check will drop all of our cache and loop
through again to make sure everything is still good to go.
Unfortunately we record our unaligned extent records on a per-root list
so they can be retrieved when we're checking the fs roots.  This isn't
straightforward to clean up, so instead simply check our current list of
unaligned extent records when we are adding a new one to make sure we're
not duplicating our efforts.  This makes us able to pass 001 with my
super bytes_used fix applied.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/main.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/check/main.c b/check/main.c
index a8851815..3f6db8f8 100644
--- a/check/main.c
+++ b/check/main.c
@@ -7892,6 +7892,8 @@ static int record_unaligned_extent_rec(struct extent_record *rec)
 
 	rbtree_postorder_for_each_entry_safe(back, tmp,
 					     &rec->backref_tree, node) {
+		bool skip = false;
+
 		if (back->full_backref || !back->is_data)
 			continue;
 
@@ -7907,6 +7909,24 @@ static int record_unaligned_extent_rec(struct extent_record *rec)
 		if (IS_ERR_OR_NULL(dest_root))
 			continue;
 
+		/*
+		 * If we repaired something and restarted we could potentially
+		 * try to add this unaligned record multiple times, so check
+		 * before we add a new one.
+		 */
+		list_for_each_entry(urec, &dest_root->unaligned_extent_recs,
+				    list) {
+			if (urec->objectid == dest_root->objectid &&
+			    urec->owner == dback->owner &&
+			    urec->bytenr == rec->start) {
+				skip = true;
+				break;
+			}
+		}
+
+		if (skip)
+			continue;
+
 		urec = malloc(sizeof(struct unaligned_extent_rec_t));
 		if (!urec)
 			return -ENOMEM;
-- 
2.26.3

