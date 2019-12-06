Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 700B8115599
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2019 17:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfLFQjE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Dec 2019 11:39:04 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39362 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbfLFQjE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Dec 2019 11:39:04 -0500
Received: by mail-qk1-f194.google.com with SMTP id d124so6977621qke.6
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Dec 2019 08:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=GEwpNbdB3OHH1VqcNM0Meq/d8Xwg41vV4wHkpi56c8Y=;
        b=Q4NQxYWlwZYoyCCioXqsNMJqv2N97yitPxD0HF3dYYZfqhV4BjikkvCmBBdqlXqGN3
         +U6nw3tPbnd0i3WtKh1ysyKKF4j3aXjV6YlbzyflqSRoC9c2ZwkgmmO1avsa2vcCtEsU
         7N8fR7NbTFbc4HjCehoN79Jva89dCwJhjeCKkHIc0+7lHaYlAKmxI+joEp/28TwWteTm
         RwmMx39x4JvgBUSaiez+qyD9ouHkGkSZXz43chY24T24WF9pdbzBOOyfOwxNUxOemLDn
         U6VanhUSapzdYRLwp9F44wZXnQNrVCCBWnsr1fiQXl6QUdOonEaaCdDV7mhtP6lUaXrs
         29ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GEwpNbdB3OHH1VqcNM0Meq/d8Xwg41vV4wHkpi56c8Y=;
        b=foRlnxHHuJtbh5MR944Y7tqe61r7d6wEb8Tk7xZVf6WjzEIAOmMDDuzOtuu2uH19Jq
         dK5PGijGsKjvp341EQ6WZE3P+YNVdfGtfqYeSP0tFovoqT1nQaXlu/Ea+V2aJOzCA7Gd
         KrKm4PUDxqMCzKza0G7eY3a29rAL9LJGiAlo6+do6g3YOxRpvm8PK5lBfGDVRbFxOTqv
         3H3QJgc3IG+oAnUUVrU7r82iKnqRyGzxrMSeB2C3zeFSleASqzZfdQJjCpmk+hKTmYHK
         DeYhTMOKT3+hPLVjWQ6l4mQUWWDqdoJgwwJZK3wguNhxLq+bHqjFunK6E/kWVQOkzT14
         R7bQ==
X-Gm-Message-State: APjAAAXIf5Hl1ivZz6cxShZeoAmGCytu5Zs8O6B5BXyxm8eJLxcirjp5
        R3Zqx1uwG3shW4b3GGij27N+tB9hxbU6yQ==
X-Google-Smtp-Source: APXvYqxZMiKfobqW/tqaUkSocYdyc7kWWkM/5JHINqyuURkFk/aGMxGXEa7sFd2l0przXMtO1OukLg==
X-Received: by 2002:a37:9acb:: with SMTP id c194mr14270294qke.291.1575650342743;
        Fri, 06 Dec 2019 08:39:02 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id v125sm2396324qka.47.2019.12.06.08.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 08:39:01 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 3/5][v2] btrfs: handle ENOENT in btrfs_uuid_tree_iterate
Date:   Fri,  6 Dec 2019 11:39:00 -0500
Message-Id: <20191206163900.168465-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191206143718.167998-4-josef@toxicpanda.com>
References: <20191206143718.167998-4-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we get an -ENOENT back from btrfs_uuid_iter_rem when iterating the
uuid tree we'll just continue and do btrfs_next_item().  However we've
done a btrfs_release_path() at this point and no longer have a valid
path.  So increment the key and go back and do a normal search.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
v1->v2:
- increase key.offset instead of key.objectid so we don't skip over a bunch of
  keys.

 fs/btrfs/uuid-tree.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/uuid-tree.c b/fs/btrfs/uuid-tree.c
index 91caab63bdf5..76b84f2397b1 100644
--- a/fs/btrfs/uuid-tree.c
+++ b/fs/btrfs/uuid-tree.c
@@ -324,6 +324,8 @@ int btrfs_uuid_tree_iterate(struct btrfs_fs_info *fs_info,
 				}
 				if (ret < 0 && ret != -ENOENT)
 					goto out;
+				key.offset++;
+				goto again_search_slot;
 			}
 			item_size -= sizeof(subid_le);
 			offset += sizeof(subid_le);
-- 
2.23.0

