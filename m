Return-Path: <linux-btrfs+bounces-21956-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLkWMkwwoGnUgAQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21956-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 12:36:44 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3021A52D4
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 12:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CB5FA3054DE2
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 11:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429DF3081C2;
	Thu, 26 Feb 2026 11:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zadara.com header.i=@zadara.com header.b="VkzZYR4N"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC0C374736
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Feb 2026 11:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772105681; cv=none; b=qB01TRj1j2ujdMeFLMY9lchUWWBIMOLuTPuOmdJGnOYFz5TlVHwMFOKSes/uU8VTCferDTdoLgnZyYX4ykqd7D+EXZzDZQ+A7YTFiSzENcIjyE+lzVBemeOIQaEW7S5Say5lXy8aA/xB972hq4KxmCriQJxXQD03g3VDzKhVTRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772105681; c=relaxed/simple;
	bh=6Y/ZHWycFLYVmA+Jd3wBe0w7vKKuKhuYGbw5Uc3Rzps=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mAtfCtTWjixai2NOlFNtwbgoCauuu4HNjX9bFbwBRP7JAtokS1q9XdHf1p9Oew1yeHVQvjh2xO15dA6pTDnhaTVICIYb1tyFoEvoQi6iBg9SmIjHBYlfyjEh9305C9I0riTgsLD6Ve90XiVW1iRZIwGF1tZHaPw1aJaZRc9iTyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zadara.com; spf=pass smtp.mailfrom=zadarastorage.com; dkim=pass (2048-bit key) header.d=zadara.com header.i=@zadara.com header.b=VkzZYR4N; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zadara.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zadarastorage.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4398c7083d7so669436f8f.3
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Feb 2026 03:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zadara.com; s=google; t=1772105678; x=1772710478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0zKmi7cuHNqc3CCp1GvK7BQ1K+6B23dh+tsdIvDxd9U=;
        b=VkzZYR4NGYeTItRVPSTLyz0oFXCWozpNeVeG4YME1GabQGlk9RYA/6scRMNzS9GZNp
         sqWAeKhzZilFSBtB+T+3rpUct5fD7VbaHyTeRXN+M5EanVNZFz3uE+4J7GnBpzp1Pz7E
         2QFFdARD2e9yO8Qrzfr16sSZhhsDc5IwoyVTKbbhSbWiAVGt7Puszme0T5Ml7L1r5Cvi
         eGjdIrbGbUm4fL5WTTicVPIghdP0YEuc3E6l4wW3GA1PxH8r2vvx0uL9pKZ0Kytr9U9R
         pa7Qf3lHj4tq3fXp4zr7QdySHmy1MDMqWPhlddfntOFXeqK/YG/qOoHzSGNz9uSNLjOt
         u39g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772105678; x=1772710478;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0zKmi7cuHNqc3CCp1GvK7BQ1K+6B23dh+tsdIvDxd9U=;
        b=bYFxNqGq7GXZj0JkNkoXJsqdnQAAcjh6tw69LgtkRYxDSTm0m93YiG7QFviPuUNdcp
         1f1I+ukoY9cNV9ZFoGyPGaMra07+6RTgQZUufrHhKK7LpsirH1Pt7VFuRhxuJcMGv0Uc
         Q/Z7BFCiB4TggI//NqYp4pyPTsM4mes6zbDgoQTs/MALj/ON3+YCMVxrZ4oh/byWl/vS
         aOQQOdW/gBlxwbxJmLTBcHv1pMTikAyOuy1LhWmrVz4ZhgMeRsT+Z5ge3ukYYanXPyev
         P4Mfw4uUarK5Ac3FGCLljuwmIv9teSv3Ve5Xv3+yLCXFRlO5XU1IiJ+xoNCtBxCFlVnd
         vLaA==
X-Gm-Message-State: AOJu0YzUmXlLy1/s+torLQVO8e+Kvh5pVjciqoJ8EVtfl0nyZ4wvhbx/
	dZx2VRy5KhV6ksMpisrW8effElNXPDQXqoqz+s+yLYGDESFFg7BuaEjtPB3kmigYG/l4lwAVVrB
	4fJSz
X-Gm-Gg: ATEYQzwLvd8R1iJTaMqF+bSynGJE1oIOR6bor+qmGDMN6klsKKUZwUcKA52+bf/0NgS
	fJsqQ9lu9pmzlqknIfMKCG7Ue1/2RRiS8HznLZnSEq7wE7ahn3qpd/1DytaWR+6JWzPU9NJXp7l
	u7hwMZQYt7dAFXnKbsIaeMw8qEvi+3khPsl5daXEchqVgEy/EqomO75dehMrff9cInJ7bWMG5mf
	I8Avk48LxxRYFur7AzOnGGr490jWs6Ha32KabSInmt2Jufxm6QszRJFQrX8MJNnwpHJZs1O1rul
	yBEBu/MiByrUpWXIOs2NgxFSlQf/ckAv8azwiIQ36utxlQEvKZgwxfRuC1CLH/t6s1l5mN+x5su
	I4o78G12XXV7JsRQX/fDU6fCDZkcxES9W103QAJhvvo9uuxyefg1VNXxCxI5TbCxvnkPfH05yyF
	nIpXJ1buJdPcCDdQWMu3oGeL68f1WfMQg=
X-Received: by 2002:a5d:5c89:0:b0:439:95c3:fecb with SMTP id ffacd0b85a97d-43997f39f1emr3902538f8f.44.1772105677806;
        Thu, 26 Feb 2026 03:34:37 -0800 (PST)
Received: from alex-ws.. ([82.166.81.77])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d40004sm40481267f8f.21.2026.02.26.03.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 03:34:37 -0800 (PST)
From: Alex Lyakas <alex.lyakas@zadara.com>
To: linux-btrfs@vger.kernel.org
Cc: alex.lyakas@zadara.com
Subject: [PATCH-RFC] btrfs: for unclustered allocation don't consider ffe_ctl->empty_cluster
Date: Thu, 26 Feb 2026 13:34:19 +0200
Message-ID: <20260226113419.28687-1-alex.lyakas@zadara.com>
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
	DMARC_POLICY_ALLOW(-0.50)[zadara.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[zadara.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[zadara.com:+];
	TAGGED_FROM(0.00)[bounces-21956-lists,linux-btrfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex.lyakas@zadara.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,zadara.com:mid,zadara.com:dkim,zadara.com:email]
X-Rspamd-Queue-Id: CB3021A52D4
X-Rspamd-Action: no action

I encountered an issue when performing unclustered allocation for metadata:

free_space_ctl->free_space = 2MB
ffe_ctl->num_bytes = 4096
ffe_ctl->empty_cluster = 2MB
ffe_ctl->empty_size = 0

So early check for free_space_ctl->free_space skips the block group, even though
it has enough space to do the allocation.
I think when doing unclustered allocation we should not look at ffe_ctl->empty_cluster.

I tested this on stable kernel 6.6.

Signed-off-by: Alex Lyakas <alex.lyakas@zadara.com>
---
 fs/btrfs/extent-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 03cf9f242c70..84b340a67882 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3885,7 +3885,7 @@ static int find_free_extent_unclustered(struct btrfs_block_group *bg,
 		free_space_ctl = bg->free_space_ctl;
 		spin_lock(&free_space_ctl->tree_lock);
 		if (free_space_ctl->free_space <
-		    ffe_ctl->num_bytes + ffe_ctl->empty_cluster +
+		    ffe_ctl->num_bytes +
 		    ffe_ctl->empty_size) {
 			ffe_ctl->total_free_space = max_t(u64,
 					ffe_ctl->total_free_space,
-- 
2.43.0


