Return-Path: <linux-btrfs+bounces-21471-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ZCHpHbwFiGl1hQQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21471-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sun, 08 Feb 2026 04:40:44 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1EB107C1D
	for <lists+linux-btrfs@lfdr.de>; Sun, 08 Feb 2026 04:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DBC1730137B7
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Feb 2026 03:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A990287263;
	Sun,  8 Feb 2026 03:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lGxgOnUf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yx1-f66.google.com (mail-yx1-f66.google.com [74.125.224.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5181F0991
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Feb 2026 03:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770522033; cv=none; b=i3XX8gAns8TVxL/T1F+9f3PKl+8uZ3F0A+Fl7U5Tyr5u9pNxRoq1aU1Mr5f/nxrIw22qZm8u9SAu0xtXl6SjeTldIyeDzmxvVVTL6pCkIUvvFGXPjQxr6ssucBXkDrLHwRsSeyospguivJBOqQf2lpFhN+8iX1EYLd+rW78FmLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770522033; c=relaxed/simple;
	bh=7qPB4X8hudxIJYiotoxS2yhNjl7wPwBZgbqZe1Rx3x8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hbCETCnenEye8eEBhDkXf+jF7cbFJw9MPH/RXpBtrewoK211pNDHiIByP7hRUmbbCE2Y10ZJbMOhML5VvRhTznqCHYbvt7NulrTLd/GWQ+F5VUVmDB2VKuh83ZcNYUw7ZWXckTUj0tuN4AMzttvocswHhSaJHA4J1T4syITNytY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lGxgOnUf; arc=none smtp.client-ip=74.125.224.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f66.google.com with SMTP id 956f58d0204a3-649d589ab0fso585980d50.2
        for <linux-btrfs@vger.kernel.org>; Sat, 07 Feb 2026 19:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770522032; x=1771126832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jRIUavyF0wIJCdEpNmYOn0qZFZWf88scYYTeI6/nu74=;
        b=lGxgOnUfZLpNHNZAddXxd3mEKinAF/MgEeWU508PeMYAfEhUaneld6vx8V+GcTdmD3
         vLv6gCxoA+kQKGLt12vaEIAQ4JK6NqrUV5QYcn2AEBK/iyyJXAsAMywMiFVym/WEnABI
         y24l0TM/eUc0Rle3aeOeV9ZtYAX2K8VNIqeOZLkTtEkGNQhVMcSdHDsWVUPAg2dtKycJ
         aMEIgZ7ZSnEY6lV9WkoD1kEF19Lxu6pIRpNwpY44f0hV1stujKq+TrSISwc+aKI2HKpR
         U9rchXdKzkBimzDtVYejKS3Syw3tKD6YJYVJfgVVkF0M6362Q+h7dycUw/u3ypefM2of
         ig6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770522032; x=1771126832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jRIUavyF0wIJCdEpNmYOn0qZFZWf88scYYTeI6/nu74=;
        b=oowdZge/dSHh5kCDVggGRqnhQWrpWBaFV7yBqD3pUWPnMivrX8KNdDqcPCk7a2wl7Q
         LX0Pgq+uvvIY4rbtbyaUWA7RA6lCOtBDeLINsuRS0UVMS4UikoykL1Uel99SbyRjPXS7
         5q6xCytW72SE8y01qnAdkzWEW0PpuXmVSFEfqn8VTYKOLm7Aq3a8+77+dNbRag0+I+id
         p3/sZqcvP97On5mBlWW27J7Y2t1R8J2WKS2Uu5scZ+WKTh7GoN/swiRDf8aiqzDKiS17
         dTCX8tc/q47WEVsA45M6IAHuJ+4HeF4XLY4lp+bx48KX++Mok9VHBoaBL+RupljpVVwO
         gEAQ==
X-Gm-Message-State: AOJu0YzrPbN7nhOZIA1+o1BxhLU0riHQvnUNgWeUp7SsrdoN373J1/UX
	oyTcockKj4vljzPmvn0NQKVxOHigDDcSQ4cubTQ9fNnd0QgK5cZwbTsga+mfXkGwNJnXlA==
X-Gm-Gg: AZuq6aJGX4PyZRXon51CkutnOJe+1Q67dzDkgTDToG65PnIH1zdrTFILjIuSFTob8cZ
	j/T2yLc7LYUP4Qmv4s1RwvDNcDHTRMXXMBaRqcckhEgiGyS7sgXEjZ148kLibdTIBNaeyLZchgS
	aijdkVW51j1xzTIgisqkQu9Ehq5PX9ID1Xpc72eBMtKQKfSOI/TX02SeF5ILEB51PU2bVb3fava
	AhS5FvPOfqkwnehh/L7GeSiVk6CakFGhdkQPKL7KxGg+NwvtA1AxkVv/um2SeRnvXJ840esz7hq
	E7BhAW1cDnt6zMbOVSW5om5VVHpHtC+7VibQROHQ3/tXNnSaMUfMZcnZXVmNKBzoal+orwObZPO
	qNvTy7pZI2jLz4E6V6HWdUa/KrqjM5v+iOdvtAsTz8TZiZds4euyiN1H6xqui+gamWCtoFacY+L
	Bc+bRlImmHOuJYf9ZNug==
X-Received: by 2002:a05:690e:134e:b0:63f:b366:98cb with SMTP id 956f58d0204a3-649f220b06cmr5808419d50.6.1770522032468;
        Sat, 07 Feb 2026 19:40:32 -0800 (PST)
Received: from SaltyKitkat ([163.176.176.7])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-649f246cddcsm6672201d50.4.2026.02.07.19.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 19:40:32 -0800 (PST)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Sun YangKai <sunk67188@gmail.com>
Subject: [PATCH 2/3] btrfs: send: drop unnecessary return_any search in get_last_extent()
Date: Sun,  8 Feb 2026 11:38:29 +0800
Message-ID: <20260208033942.31650-1-sunk67188@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260208032705.27040-3-sunk67188@gmail.com>
References: <20260208032705.27040-3-sunk67188@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-21471-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunk67188@gmail.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AF1EB107C1D
X-Rspamd-Action: no action

There must always be a previous item before an extent data item, at
least the inode_item. Because of this, setting @return_any in
btrfs_search_slot_for_read() is unnecessary.

Signed-off-by: Sun YangKai <sunk67188@gmail.com>
---
 fs/btrfs/send.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index d8127a7120c2..5b551f811bf6 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -6320,7 +6320,7 @@ static int get_last_extent(struct send_ctx *sctx, u64 offset)
 	key.objectid = sctx->cur_ino;
 	key.type = BTRFS_EXTENT_DATA_KEY;
 	key.offset = offset;
-	ret = btrfs_search_slot_for_read(root, &key, path, 0, 1);
+	ret = btrfs_search_slot_for_read(root, &key, path, 0, 0);
 	if (ret < 0)
 		return ret;
 	ret = 0;
-- 
2.52.0


