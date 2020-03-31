Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F34FB19A01C
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Mar 2020 22:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731331AbgCaUrS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Mar 2020 16:47:18 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52537 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730907AbgCaUrS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Mar 2020 16:47:18 -0400
Received: by mail-wm1-f66.google.com with SMTP id t8so701239wmi.2;
        Tue, 31 Mar 2020 13:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2hiN4D4ziicIicURcM9kTX3QBwWjTWrbPU8zupmJf9M=;
        b=AWJsx9HO8fDO/PUITUpmkPpwyy0/OjUtIsVKTIIUWVAhzn3qnZlEGSb7AOXluG+VhY
         ogjZMfEZcABmqsfZuTlBf/YihQemiKzjEWRhLTUSyjswFUFaGQ4FIlUpvhRz7m6M2Hdj
         OuHLE9JGD0LkCg9veJzqbsGNfMN3fK2o7lgMrtdzFpB6m2+Wyn/WWJ4R1qhowfUHthbv
         36qt1dbziy2Br4WXblOpwz7hO+Xd+ePco1+NSHNHivS6DHMpbW/+2JmT7D84Wt99Onp2
         bCVcJ6maHqb5mfOnIr3dcc0byJaT6nxq1yNabJOKm8KDB/jZfT+TclmS0lhANvyk5cSE
         b/9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2hiN4D4ziicIicURcM9kTX3QBwWjTWrbPU8zupmJf9M=;
        b=Whej8vS6SVe1qdlp2MvQ6WobVTE0DVZhRPB5JF8mQZ66KIQADt4raXsbqOeW+T5NyW
         Gak2s5oDmhxi3C6BmTIK9DJyqMO2TPfpUfPiICyq3jPFPbw0PYAan/G/AsO3qz3U02DJ
         aN6Mryep9Z+QKsno0x1udNf8FSj2zYI51Ehv9yfFOvHzlnoSiTX/1siOXjgHqC/5F7BB
         w6ux+c4Y7ujD0BSH5W2DWVMT05qmvKf4qMWeYUxBSORFvIO4QkRXEaz8qT1iA206mclc
         oOPPMju89g96j0g9kuSVM8ojmN6jU1IUk6auXu/3uG6nl2yS3RdakRJFQrCO0GE7jO23
         t7oA==
X-Gm-Message-State: AGi0PuZtEoNHa34HFuCB/h5uwYX0983ef75buy5EaTXeS4zXEF8xzh49
        VHXHDDD4fdtb618g/ySbsFS4lPdlvQ/3
X-Google-Smtp-Source: APiQypLbF6eRP1OB6LA75P3wQ/qMBBh/heQWRkOJzqJSLu+MvZEehQAfOeM2P7JEQ4dJD0c1WCvARA==
X-Received: by 2002:a1c:cc11:: with SMTP id h17mr692873wmb.39.1585687635703;
        Tue, 31 Mar 2020 13:47:15 -0700 (PDT)
Received: from ninjahost.lan (host-92-23-85-227.as13285.net. [92.23.85.227])
        by smtp.gmail.com with ESMTPSA id o9sm28335491wrx.48.2020.03.31.13.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 13:47:15 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     boqun.feng@gmail.com, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org (open list:BTRFS FILE SYSTEM)
Subject: [PATCH 5/7] btrfs: Add missing annotation for btrfs_lock_cluster()
Date:   Tue, 31 Mar 2020 21:46:41 +0100
Message-Id: <20200331204643.11262-6-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200331204643.11262-1-jbi.octave@gmail.com>
References: <0/7>
 <20200331204643.11262-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Sparse reports a warning at btrfs_lock_cluster()

warning: context imbalance in btrfs_lock_cluster()
	- wrong count

The root cause is the missing annotation at btrfs_lock_cluster()
Add the missing __acquires(&cluster->refill_lock) annotation.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 fs/btrfs/extent-tree.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 0163fdd59f8f..9057a5ca6678 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3395,6 +3395,7 @@ static struct btrfs_block_group *btrfs_lock_cluster(
 		   struct btrfs_block_group *block_group,
 		   struct btrfs_free_cluster *cluster,
 		   int delalloc)
+	__acquires(&cluster->refill_lock)
 {
 	struct btrfs_block_group *used_bg = NULL;
 
-- 
2.24.1

