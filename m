Return-Path: <linux-btrfs+bounces-21820-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WvguFzv7mmntowMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21820-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Feb 2026 13:48:59 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B9116F114
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Feb 2026 13:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75252301547C
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Feb 2026 12:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4FF231C9F;
	Sun, 22 Feb 2026 12:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="Qmk0dIOM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894F917B43F;
	Sun, 22 Feb 2026 12:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771764521; cv=none; b=i7aJt24x13qUjIS3wB4BZ6Vq+rPNBZaA5/UDUoZ7mar8mPFz5+/S+wAvj5jc0vYs5duQSE7DjLKJyyV3mFLoBtxHl/voGzoKfdtWj/A24V81eU7614TUH8h5z9UfeDHYjgwmgcXEAWnB3Rf1Ol7A06Z4h5sw/haLAIhq7dhfFus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771764521; c=relaxed/simple;
	bh=8ziw2Z47J3cWWIxD67JMP8hooLgeKjQaf5bGnOyQ4Ug=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BLamBlkollVtFX3KVEuZ1icAqCW69d9pNnMdB1I/TjV/RPQlpE6rQ1VOaz0qFGnjQ0jstd4vJG27c2ky0VESgyd5RxuSFN/pmxT7+LKhf9RKv1ffLn4JFHe3fLv345sKvDdYDTa6h1piUS/tFitY9ijWdGPnfmTrh7YopEc7p2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=Qmk0dIOM; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from VelichayshiyPC.Dlink (unknown [92.101.134.175])
	by mail.ispras.ru (Postfix) with ESMTPSA id A8922413A4B4;
	Sun, 22 Feb 2026 12:48:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru A8922413A4B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1771764509;
	bh=k5gXoamKVQ8go7/vBbv6Nq/xRVeU9Ng9q2GcmtjPAyU=;
	h=From:To:Cc:Subject:Date:From;
	b=Qmk0dIOMsHzAYcL9FqSsnfMdl4ybL9DlGHC0lBMaDlSbaCzRgd3U2pi6LdOTOpQX8
	 96NoW0Qa7vOF3q0P/4P20UCfkGdRu6/a7y748YeW90iD2g0Q+vy/7XoikAfPUv82qZ
	 o3Hrc8dqdtqOgvC8h48TTAf31ISfhK9qUU5zVSR8=
From: Alexey Velichayshiy <a.velichayshiy@ispras.ru>
To: a.velichayshiy@ispras.ru,
	Chris Mason <clm@fb.com>
Cc: Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Filipe Manana <fdmanana@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-project@linuxtesting.org
Subject: [PATCH] btrfs: Remove redundant nowait check in lock_extent_direct
Date: Sun, 22 Feb 2026 15:47:23 +0300
Message-ID: <20260222124758.953175-1-a.velichayshiy@ispras.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ispras.ru,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ispras.ru:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21820-lists,linux-btrfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[a.velichayshiy@ispras.ru,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[ispras.ru:+];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ispras.ru:mid,ispras.ru:dkim,ispras.ru:email]
X-Rspamd-Queue-Id: B3B9116F114
X-Rspamd-Action: no action

The nowait flag is always false in this context, making the conditional
check unnecessary. Simplify the code by directly assigning -ENOTBLK.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Alexey Velichayshiy <a.velichayshiy@ispras.ru>
---
 fs/btrfs/direct-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
index 07e19e88ba4b..72a229c44833 100644
--- a/fs/btrfs/direct-io.c
+++ b/fs/btrfs/direct-io.c
@@ -107,7 +107,7 @@ static int lock_extent_direct(struct inode *inode, u64 lockstart, u64 lockend,
 			    test_bit(BTRFS_ORDERED_DIRECT, &ordered->flags))
 				btrfs_start_ordered_extent(ordered);
 			else
-				ret = nowait ? -EAGAIN : -ENOTBLK;
+				ret = -ENOTBLK;
 			btrfs_put_ordered_extent(ordered);
 		} else {
 			/*
-- 
2.43.0


