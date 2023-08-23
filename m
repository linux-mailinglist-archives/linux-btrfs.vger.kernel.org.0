Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8FA785A98
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Aug 2023 16:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236476AbjHWOd2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Aug 2023 10:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236466AbjHWOd0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Aug 2023 10:33:26 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5940E6E
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:33:17 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-59254e181a2so14303577b3.1
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692801197; x=1693405997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1H2Zlv1o3VIX483lfJm/ywo5TfIg7XeI5NRHVO7sb9I=;
        b=PSLntg7rHqGsCpZaqg7VVUX2lMVBoomel0a12L3x1EToo310tBaYa6Afe532BXdcL9
         i99lpqD+D0qwk/hYr2n051+OosQXANjoDEA6XVd06U9lKlbJmyjNhXenAxc8vPsyVGFI
         OxSHJWKQexurWoOGfh3dIbYQ3T6dHS9GuIH3mt4sBgZJT3Xwv+/AkAOEhf1Z/MB6d10T
         N+tuATX+4wwzj1PQW9CVEyCeK/wd5WVdKf9m3pzib0A61TPe6ygs65AxaLBUC/CBDaqS
         7CQQGmc23Sm/PFCMrNT3l2sZLv7yP3I7QCJzsrAGy7r04oMqXLaLNKDvAHyjYHbi/Q9p
         quVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692801197; x=1693405997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1H2Zlv1o3VIX483lfJm/ywo5TfIg7XeI5NRHVO7sb9I=;
        b=Ez7TyzPWOSVeHk4U87dfFh/PWDs7jBkdZaIJgVqwg3bhhbHQkbDLnx7aAQfvmBeW3u
         M57aj9UnvvPh9SlPCtHj6ROLRHSclJYgS6kN4mtnNIau9GcdeFiCSNDmDx7ZYx9J8cIz
         FlXEvusBQX/NDORf22fuYwsSETFEVzQ7nvCuYZJBFtcvAWyvg4zU3Gp/rogsBvqoW8Lv
         dje/5h+jJh3W0xRoCNdlNLQsCHOedVxy6GH/igOm/KD8ZIY/9uJCn7scISUU7kB/h0qA
         UJPoGbV74xfUrG8XgdXvxqukrgvPVYleZCOEtlumeW/tclDUI6eEemGJL1iSbZKkcgTV
         tGjw==
X-Gm-Message-State: AOJu0YxKVxVKGBgiUyTUxJIlqYZswhB0DM6AlssSsgJ9mBDcRjLrQq3m
        TYzfo7dTID8Tjt6sdxaXnuo3GwTNcrTC+VpYnjQ=
X-Google-Smtp-Source: AGHT+IEWoSb+aNjZMdqP+gHzhIAzKxqdoF1utlj1uBiPTVUOB10woLhpSB1o1YMUMu1Myz19rAJBJQ==
X-Received: by 2002:a0d:ca8e:0:b0:576:8d7f:d163 with SMTP id m136-20020a0dca8e000000b005768d7fd163mr12566264ywd.8.1692801196892;
        Wed, 23 Aug 2023 07:33:16 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id i126-20020a0df884000000b0057085b18cddsm3364247ywf.54.2023.08.23.07.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 07:33:16 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 07/38] btrfs-progs: update btrfs_bin_search to match the kernel definition
Date:   Wed, 23 Aug 2023 10:32:33 -0400
Message-ID: <035b46cd8be1339b6576f08f0dd685423f37da9b.1692800904.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692800904.git.josef@toxicpanda.com>
References: <cover.1692800904.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This was updated to include a first_slot argument, update it to match
the kernel definition to make it easier to sync ctree.c.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/main.c          | 2 +-
 kernel-shared/ctree.c | 6 +++---
 kernel-shared/ctree.h | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/check/main.c b/check/main.c
index d992b9f8..481fe11e 100644
--- a/check/main.c
+++ b/check/main.c
@@ -6524,7 +6524,7 @@ static int run_next_block(struct btrfs_root *root,
 		 * technically unreferenced and don't need to be worried about.
 		 */
 		if (ri != NULL && ri->drop_level && level > ri->drop_level) {
-			ret = btrfs_bin_search(buf, &ri->drop_key, &i);
+			ret = btrfs_bin_search(buf, 0, &ri->drop_key, &i);
 			if (ret && i > 0)
 				i--;
 		}
diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
index 3b703f7c..4d269e45 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -816,8 +816,8 @@ static int generic_bin_search(struct extent_buffer *eb, unsigned long p,
  * simple bin_search frontend that does the right thing for
  * leaves vs nodes
  */
-int btrfs_bin_search(struct extent_buffer *eb, const struct btrfs_key *key,
-		     int *slot)
+int btrfs_bin_search(struct extent_buffer *eb, int first_slot,
+		     const struct btrfs_key *key, int *slot)
 {
 	if (btrfs_header_level(eb) == 0)
 		return generic_bin_search(eb,
@@ -1355,7 +1355,7 @@ again:
 		ret = check_block(fs_info, p, level);
 		if (ret)
 			return -1;
-		ret = btrfs_bin_search(b, key, &slot);
+		ret = btrfs_bin_search(b, 0, key, &slot);
 		if (level != 0) {
 			if (ret && slot > 0)
 				slot -= 1;
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index dc11b246..66c05a69 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -983,8 +983,8 @@ int btrfs_search_slot_for_read(struct btrfs_root *root,
                                const struct btrfs_key *key,
                                struct btrfs_path *p, int find_higher,
                                int return_any);
-int btrfs_bin_search(struct extent_buffer *eb, const struct btrfs_key *key,
-		     int *slot);
+int btrfs_bin_search(struct extent_buffer *eb, int first_slot,
+		     const struct btrfs_key *key, int *slot);
 int btrfs_find_item(struct btrfs_root *fs_root, struct btrfs_path *found_path,
 		u64 iobjectid, u64 ioff, u8 key_type,
 		struct btrfs_key *found_key);
-- 
2.41.0

