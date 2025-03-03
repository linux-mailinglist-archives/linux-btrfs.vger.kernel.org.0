Return-Path: <linux-btrfs+bounces-11959-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D54A4B637
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Mar 2025 03:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14B7E3A8A9B
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Mar 2025 02:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72766190468;
	Mon,  3 Mar 2025 02:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="cX2ap5pe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F609146585;
	Mon,  3 Mar 2025 02:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740969776; cv=none; b=hDqu/yjR3/QerfOd8vgLha9pB1gmhJfD80QsXqSyMX7u5Hp5ezhPN+yMMOYoQHUHK2hZJjSV7zvFKUAR3UgVisfAPE86rYG4PNbDIwTd8ycEc81vZiK0A500v6tBsmYbGCF9kNLobdWPbPIiup3u8RFHaj8uXI8gj7OIiB9qTkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740969776; c=relaxed/simple;
	bh=LPsDAF4daV1b80Sc87gTh5bt29Y3h9Ne2D/+R21IRO0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MqK9glcJmvGFq60/6fhpHuM2rJYGpjrbFjD5T43XeiLWXpWyHT2fJ2sWaG3Zwc6eVUwojpjVycQ8KUshz73SlTDz1pDl4qoXbGcbYE39WYM2qUFHAuFWWvPp2jIKzOPUjIN5p+W0kWM6eyoP8WYIU1sWbNTjvfqoQyZtCfFsL7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=cX2ap5pe; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=9wCrl
	m+ulJ569ETKNhrEDhDUJvY3Yz7e67hlsiJwJac=; b=cX2ap5pel61WJEdxM5GBh
	a/5Dq361w/REnXArk14mYW9Hwh3yzOM0iBsudLecW33ch/MsPbJtUjD+nDwGahee
	Jv6z0Vzl/XhVA0iM406uV1V7nz9GGgFMffSQkAId9AkSzjkY8z8NzTvYyM/nDuYM
	45pV0lHbmdWUVZzmHFDgDw=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wA3dX8aF8VnyuKdPA--.58228S4;
	Mon, 03 Mar 2025 10:42:36 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	fdmanana@suse.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] btrfs: fix a memory leak issue in read_one_chunk()
Date: Mon,  3 Mar 2025 10:42:33 +0800
Message-Id: <20250303024233.3865292-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wA3dX8aF8VnyuKdPA--.58228S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jry7CFW8WFWDJFWxuw4kJFb_yoW3Crc_Ja
	47JryDZry7tw15XryrKFZ0gFWYqw109r4kZ3y2krsYyFZ8ArnFvrsF9rs0va97WrWUAF1a
	y3Wxtr18uwnrCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRZ8n53UUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/1tbiqB8FbmfFFtwIUwAAsv

Add btrfs_free_chunk_map() to free the memory allocated
by btrfs_alloc_chunk_map() if btrfs_add_chunk_map() fails.

Fixes: 7dc66abb5a47 ("btrfs: use a dedicated data structure for chunk maps")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 fs/btrfs/volumes.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index fb22d4425cb0..3f8afbd1ebb5 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7155,6 +7155,7 @@ static int read_one_chunk(struct btrfs_key *key, struct extent_buffer *leaf,
 		btrfs_err(fs_info,
 			  "failed to add chunk map, start=%llu len=%llu: %d",
 			  map->start, map->chunk_len, ret);
+		btrfs_free_chunk_map(map);
 	}
 
 	return ret;
-- 
2.25.1


