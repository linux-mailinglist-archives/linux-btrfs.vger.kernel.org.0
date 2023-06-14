Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D197972F541
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jun 2023 08:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237178AbjFNG7S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Jun 2023 02:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235013AbjFNG7R (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Jun 2023 02:59:17 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D99B1984
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 23:59:15 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4Qgx9W3FFbzBQJYc
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Jun 2023 14:59:11 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1686725951; x=1689317952; bh=kXBKIs8Nh33WqgV62LHlPZQl7XD
        V7OtBPx3MI4EvG/Y=; b=x2fVcPwKbDjLkKswJG70cNh7HkleAINqMY3PIzH76j8
        4foYPhc7j/9A7yVEx612j/V5oWg65n+aeTBKM6hGSZIr3/XaNeZc+79ww0FPTKP4
        q/jLXd5+yT62/i/5Eqfp/7YehfWcaDvZYAZIXSYKFCT3dG3mFbwHJxVJacEnpnCT
        SWLPABQhBVNHfjQVa50aUa+uia+w8jjlV5Gy3Pn/Kl95LfL21L1O6mgGeAo5EivD
        1Xy+2LvbdkM0t0eS1Wn7c+LfqNTKvAYIEJMNy0qxlzgnPwGrWNA6OVEp++0zxOwX
        N8n+KZxLRQ9usZsmMzXPxF8brVf4U/SMa8TsFGgNzQQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id cfgFVzL4oewq for <linux-btrfs@vger.kernel.org>;
        Wed, 14 Jun 2023 14:59:11 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4Qgx9W0mJ6zBJLB3;
        Wed, 14 Jun 2023 14:59:11 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 14 Jun 2023 14:59:11 +0800
From:   baomingtong001@208suo.com
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] btrfs: remove unneeded variable from unpin_extent_cache()
In-Reply-To: <20230614065736.22353-1-luojianhong@cdjrlc.com>
References: <20230614065736.22353-1-luojianhong@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <a1c89487cc2839474f232ab140a96e3b@208suo.com>
X-Sender: baomingtong001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

fix the following coccicheck warning:

fs/btrfs/extent_map.c:298:5-8: Unneeded variable: "ret". Return "0".

Signed-off-by: Mingtong Bao <baomingtong001@208suo.com>
---
  fs/btrfs/extent_map.c | 3 +--
  1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 0cdb3e86f29b..f3e9aaeb9956 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -295,7 +295,6 @@ static void try_merge_map(struct extent_map_tree 
*tree, struct extent_map *em)
  int unpin_extent_cache(struct extent_map_tree *tree, u64 start, u64 
len,
                 u64 gen)
  {
-    int ret = 0;
      struct extent_map *em;
      bool prealloc = false;

@@ -327,7 +326,7 @@ int unpin_extent_cache(struct extent_map_tree *tree, 
u64 start, u64 len,
      free_extent_map(em);
  out:
      write_unlock(&tree->lock);
-    return ret;
+    return 0;

  }
