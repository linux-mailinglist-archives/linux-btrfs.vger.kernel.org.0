Return-Path: <linux-btrfs+bounces-18879-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 913AFC501F9
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Nov 2025 01:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41F5B3B1581
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Nov 2025 00:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D92D1AF0AF;
	Wed, 12 Nov 2025 00:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jr8VY3w2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yx1-f68.google.com (mail-yx1-f68.google.com [74.125.224.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF8612F5A5
	for <linux-btrfs@vger.kernel.org>; Wed, 12 Nov 2025 00:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762906985; cv=none; b=GtxAbfqsmYVGt4iKCsM9+LGltFOmtYSFjQSvnsNdCZjqVLK4H+keG+2BjZPBLOBgVfNWp1htWsIo3ZumUv+NvweabHpnokRd5FmJJEMeHa26+EPwViNmtU1nw6jO8zOk1e8eNpeemU/RmfNrRIzB0zZ7V8kkAvw1uaSwBGFBHCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762906985; c=relaxed/simple;
	bh=SAaScmU0BdruLwbB4uyMGIOzHa7s/9hgRWbLyIozkGw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=uGvy/tLzEaSD9ZVHMej3VFV5rh82ILJYZCs3jbWiJo8Wk6+VK8gZe0Zwh2YRg4V8BhAn5nxOI9js1TQjO8uf6z2LDYH9qQV0KqiymN8yxMrQewzH+FmcKRQ8ihh3sRs5egfmT6NB+WjbcoA2LSGq2Y3/NqFMp3uRJCeeZdIVYmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jr8VY3w2; arc=none smtp.client-ip=74.125.224.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f68.google.com with SMTP id 956f58d0204a3-640f2c9cc72so231235d50.3
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Nov 2025 16:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762906982; x=1763511782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=sO0eRAdE+Ey0VD/B5vfRCN14CF0utZS1j/VJ+c4jiN4=;
        b=Jr8VY3w2BzJrJW6L8Ax+KNOralJmPgAOZN0z576ey648UkX0WCE4XoxhK1Xc0SPb3V
         YDvrfGxGcTnvYwpBQvJpPZxwRO7D9Gx0iinEJGpxxW0TUH7GIf21f9bj1cG/TjZuLfQy
         at2nLoWgu7Za1DOnnX1PwkEbLDn2+fb+tfYRm1mYmwb7QrToKbO+HcvMUFuNCURuTnWD
         yDfJhqMTKPIMeDLUhuKYH4WzMz5g1eOWqHcaNdM95jBODDwAyMz7l/f8/YGb7EvXQGz4
         cXypclwR/EkRRpBDy8QUT/tlxG2ezU+K5x/ahOb3fby1+hv7ugVEY+Zw5Qfa98GBiNv/
         PGIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762906982; x=1763511782;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sO0eRAdE+Ey0VD/B5vfRCN14CF0utZS1j/VJ+c4jiN4=;
        b=uALZTQ4dyEVgnZycnW8Q1aElrenF2iYhGod+GTW+8HgYAiaNN5qYykhomzdzBRIn+W
         M30/rCB0dlBxHbJH7u3dyoZ58B6scLMnz7Uy+9FTa3E51AKDWqR7JOfcM7H8MHuJAGFg
         cW/1O8R/WlqX1LXVT2uQSOV1fwP5bLss3V5OD06LFzPS4uy3NE5s+W5EAmMwlzwWafdd
         KN07kIbh9fVIQ6y7fXsQrWl8+jRDdUQET3qgJB4/Co/1TyzalZC5uz+/jUKj9LjPnuwM
         Gq9E45EhBCbOpZdQLHidTcEVuEvVSdAHEXQnP5p9QFdLg3CTxtsJG8rl9tLieZ+WF4r9
         ylMQ==
X-Gm-Message-State: AOJu0Yz4j3rg9A03wJyMrqBBLLpMxFvo/P1Z8b0kL1j0ZGOx+g2O+w7T
	rmwwG5yOl+PLlXfo7Cm4NxTTpD3iNfjgqw8lNZhUI4b5KKeJHkh5osLobJPVexsO
X-Gm-Gg: ASbGncvI7dT4PF/QmksWVOafOmCUiSy8ltduIiPxP7TBD54n8ezlK3+IDZSIDa80k/m
	vTbT1PkRvzUWZf9JGI7D1zOI5ffgfpzMAnDdty/xY6j2UpnSUdiK2+9Tnr7uNSF/TLKi1DQhp3b
	9e6FcpVXDwrcQh/0SoHYhF1DDt//BNLCYXco/h2u7orVPORZPw31bfFl2S51WfG/7Abpg63uGqm
	Th4X/TVL/6hanKx3c4ArmK4xy5cVqJOh8Jw03b4cQhBY8JABdISl1mA/AtGA9yHecFu0kbN/IBx
	6TtqEdJQtfVJM3ji1VjoasnJmKhOdK0EkpW80ogQy0nb8wMC7gYc8r5PkFnRFg65pd3cKVlS3nu
	O6cesTGkfZ1Bh9CbTR3yO2W4a30UQPkORLSs/IrNcUmXc6igr2Ca9q6s03TWgrqUSP4oHQBdxX7
	7/XHgHiKY=
X-Google-Smtp-Source: AGHT+IEAySMNz8Weuu7hLwzhADl/Jrwes2QyK9f1sWy5dXc6bvOx5Dy8hdUO7BXNbuWRSjtTY+i+ew==
X-Received: by 2002:a05:690c:a748:b0:787:f2c3:7164 with SMTP id 00721157ae682-788134ed383mr15090097b3.0.1762906981867;
        Tue, 11 Nov 2025 16:23:01 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:49::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6410168440dsm417027d50.24.2025.11.11.16.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 16:23:01 -0800 (PST)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH] btrfs: take delayed_node mutex when releasing item
Date: Tue, 11 Nov 2025 16:22:57 -0800
Message-ID: <58b8b78ff75d5aff478859f9fe51e0ff14e35fba.1762906462.git.loemra.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The error path in btrfs_delete_delayed_dir_index does not take
the delayed_node mutex when releasing delayed item.
btrfs_release_delayed_item -> __btrfs_remove_delayed_item which
has lockdep_assert_held(&delayed_node->mutex)

Fix this by taking the mutex when releasing.

Fixes: 933c22a7512c ("btrfs: delayed-inode: Kill the BUG_ON() in btrfs_delete_delayed_dir_index()")
Signed-off-by: Leo Martins <loemra.dev@gmail.com>
---
 fs/btrfs/delayed-inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index e77a597580c5..30dd067e2db3 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -1662,7 +1662,9 @@ int btrfs_delete_delayed_dir_index(struct btrfs_trans_handle *trans,
 		btrfs_err(trans->fs_info,
 "metadata reservation failed for delayed dir item deletion, index: %llu, root: %llu, inode: %llu, error: %d",
 			  index, btrfs_root_id(node->root), node->inode_id, ret);
+		mutex_lock(&node->mutex);
 		btrfs_release_delayed_item(item);
+		mutex_unlock(&node->mutex);
 		goto end;
 	}
 
-- 
2.47.3


