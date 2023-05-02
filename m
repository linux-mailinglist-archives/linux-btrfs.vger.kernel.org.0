Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76A876F4AB6
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 May 2023 22:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjEBUAO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 May 2023 16:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjEBUAN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 May 2023 16:00:13 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFFF19A7
        for <linux-btrfs@vger.kernel.org>; Tue,  2 May 2023 13:00:11 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-5ef673a49e2so43579886d6.3
        for <linux-btrfs@vger.kernel.org>; Tue, 02 May 2023 13:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1683057610; x=1685649610;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=DOMZjXbq3iWeqmqYRFPl1dxPJHdLgmJ1bHhGQtJAbng=;
        b=bRWnCBcfFiMqvocN3deOkvKEHvJwPn9L8gsuf/ZMy5bU6XSWMN9mKFY1NStzRqkIzi
         QCIqcrFMlJeqwFjOo3Novnk+yoPltkNHLCHHq0Z4sZiJj2GxyBpwUxRRIx294woqTR7p
         h8uCS3gpXTKWiJb+Rq7y4HDYxjElhVX1fUymCpSMTgqC8UndaC0VKz9EF6WI4L9E+pc4
         IpwnDToSb9KnTxl162Dd356DOk7jHyCH6S2InW8NED2jzS51nOLjRVCR8wjbNuyOqH8/
         2vi6U2Xb5Gr7AH2uAfQaGlOWrhhtaIhfuf3/qqMYQH7mjWWJcqIWGlLfJZlNF7zFd8Di
         e7Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683057610; x=1685649610;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DOMZjXbq3iWeqmqYRFPl1dxPJHdLgmJ1bHhGQtJAbng=;
        b=OXVblNYZbVzpdhOk9mJI68a2EJDckSl639UbcFaX729tgol1N0vP0Jkg0Mzi9HqEBi
         CoAXMNKR0eUlmjhIMF9kJUjB1TaZ5m8xAfv5zF3LQUBYEuY8RxsHSLCX9GH8NIIzOfdr
         baqwSoLHhbZlE4QpiCJJyfcEuiiY7CQZz7/xe5hzjmN3kKrlk+R1OxMnJbON0QOJuBsT
         ADK3Ka2Mw6K4JLFX07LOLmg9L8d00ei83Mdlbnq7tu5G2bOF7sK4Qzj31gfsdFKqDHMV
         Si7UwrGrNMj7fYUfG7FfELsQJSyOs5VSuJ7zWqKeAeRF4Igq5GZa7ZF6weRC4BBbxGo1
         he+g==
X-Gm-Message-State: AC+VfDzpFzloxYQ/ABXXpAb2+CkjRszlIYgUtYUrdTkHYhjjGjwGUWPg
        dwxish0wUiNMUaJdkSKeJ5z/z2FFeBw7DNAA5e/4Ow==
X-Google-Smtp-Source: ACHHUZ7tSlVUA1crR+DKnf/MSxFR5oCzJWxkBt0QOareDI7nRghBYgAi8o/w2ncUgydXodq6rJXSGg==
X-Received: by 2002:a05:6214:518c:b0:5c2:a8b0:d71a with SMTP id kl12-20020a056214518c00b005c2a8b0d71amr6828652qvb.43.1683057609685;
        Tue, 02 May 2023 13:00:09 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id y15-20020a0c8ecf000000b005e7648f9b78sm9699278qvb.109.2023.05.02.13.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 13:00:09 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: don't free qgroup space unless specified
Date:   Tue,  2 May 2023 16:00:06 -0400
Message-Id: <e65d1d3fd413623f9d0c58614a296f0ab5422a05.1683057598.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
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

Boris noticed in his simple quotas testing that he was getting a leak
with Sweet Tea's change to subvol create that stopped doing a
transaction commit.  This was just a side effect of that change.

In the delayed inode code we have an optimization that will free extra
reservations if we think we can pack a dir item into an already modified
leaf.  Previously this wouldn't be triggered in the subvolume create
case because we'd commit the transaction, it was still possible but
much harder to trigger.  It could actually be triggered if we did a
mkdir && subvol create with qgroups enabled.

This occurs because in btrfs_insert_delayed_dir_index(), which gets
called when we're adding the dir item, we do the following

btrfs_block_rsv_release(fs_info, trans->block_rsv, bytes, NULL);

if we're able to skip reserving space.

The problem here is that trans->block_rsv points at the temporary block
rsv for the subvolume create, which has qgroup reservations in the block
rsv.

This is a problem because btrfs_block_rsv_release() will do the
following

  if (block_rsv->qgroup_rsv_reserved >= block_rsv->qgroup_rsv_size) {
	  qgroup_to_release = block_rsv->qgroup_rsv_reserved -
		  block_rsv->qgroup_rsv_size;
	  block_rsv->qgroup_rsv_reserved = block_rsv->qgroup_rsv_size;
  }

The temporary block rsv just has ->qgroup_rsv_reserved set,
->qgroup_rsv_size == 0.  The optimization in
btrfs_insert_delayed_dir_index() sets ->qgroup_rsv_reserved = 0.  Then
later on when we call btrfs_subvolume_release_metadata() which has

  btrfs_block_rsv_release(fs_info, rsv, (u64)-1, &qgroup_to_release);
  btrfs_qgroup_convert_reserved_meta(root, qgroup_to_release);

qgroup_to_release is set to 0, and we do not convert the reserved
metadata space.

The problem here is that the block rsv code has been unconditionally
messing with ->qgroup_rsv_reserved, because the main place this is used
is delalloc, and any time we call btrfs_block_rsv_release() we do it
with qgroup_to_release set, and thus do the proper accounting.

The subvolume code is the only other code that uses the qgroup
reservation stuff, but it's intermingled with the above optimization,
and thus was getting its reservation freed out from underneath it and
thus leaking the reserved space.

The solution is to simply not mess with the qgroup reservations if we
don't have qgroup_to_release set.  This works with the existing code as
anything that messes with the delalloc reservations always have
qgroup_to_release set.  This fixes the leak that Boris was observing.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-rsv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
index 3ab707e26fa2..ac18c43fadad 100644
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -124,7 +124,8 @@ static u64 block_rsv_release_bytes(struct btrfs_fs_info *fs_info,
 	} else {
 		num_bytes = 0;
 	}
-	if (block_rsv->qgroup_rsv_reserved >= block_rsv->qgroup_rsv_size) {
+	if (qgroup_to_release_ret &&
+	    block_rsv->qgroup_rsv_reserved >= block_rsv->qgroup_rsv_size) {
 		qgroup_to_release = block_rsv->qgroup_rsv_reserved -
 				    block_rsv->qgroup_rsv_size;
 		block_rsv->qgroup_rsv_reserved = block_rsv->qgroup_rsv_size;
-- 
2.26.3

