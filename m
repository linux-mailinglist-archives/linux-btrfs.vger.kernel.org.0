Return-Path: <linux-btrfs+bounces-22049-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SB/jFPY+oWnsrQQAu9opvQ
	(envelope-from <linux-btrfs+bounces-22049-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 07:51:34 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 11AFD1B3822
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 07:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 194BF30F7019
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 06:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011FB3ECBE4;
	Fri, 27 Feb 2026 06:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="nQsRkN6m"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2723D903C
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Feb 2026 06:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772174701; cv=none; b=O+r5hCHtlF8KJEykORcQiaAxnFxpBfPQfJWkT5BCg4I/BHqCpMn4TN951jFrIbfzL9p/B2eiC970Kid/QxnOP31tpHqBWvckewWvs7IT+oMc/eaL1ydF6AgdeuX1pOd7EK4uIhWwA+84rLVunshA1qr6+z7gVQHAtctmPH9NgJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772174701; c=relaxed/simple;
	bh=McUsGtsYMIjoW4/3cyGX4W2lRKGWMgcD+jtlcBg/R7M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UbxOXaOcPDGOl/KW8H1lLpwcQZ1LESqVZX4zl9wqgt+sc4WgFcNOclqrzJlTBUHWIvmQMpxlp4QKKSeYu3I7me5t1XoguA4JyCLt3SjCDZ9vYJFi7adkP0jKRgTBbzlQZO6aYUR7pYHxggICYW6ymc1OpwO2fQYL1Q4gO+ael58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=nQsRkN6m; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=K+IYaWPR83WGqnjCvqNaJeEeVaFQcqF7c5tIrgNlKIU=;
	b=nQsRkN6mWwn99Ic49rPGfv98cxBuO+E90HLVU0dqhRcAtgNYs7YRD52Kax0I+rg02x1sxq2St
	UzILMmnEdIr9cdyvj8d4sknESQkQNjaWcS4paYEvRcPA4jC0wfZ/KrLzIm8EfcPs/JKHkVoIS6w
	osXISQS6DSQnpoj5So+1gpc=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fMdwx6P18zKm65;
	Fri, 27 Feb 2026 14:40:01 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 7F3F84056C;
	Fri, 27 Feb 2026 14:44:50 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemr500015.china.huawei.com
 (7.202.195.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 27 Feb
 2026 14:44:49 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <clm@fb.com>, <josef@toxicpanda.com>, <dsterba@suse.com>
CC: <wqu@suse.com>, <sashal@kernel.org>, <fdmanana@suse.com>,
	<linux-btrfs@vger.kernel.org>, <lihongbo22@huawei.com>
Subject: [PATCH 6.6] btrfs: free path if inline extents in range_is_hole_in_parent()
Date: Fri, 27 Feb 2026 14:44:14 +0800
Message-ID: <20260227064414.2314529-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemr500015.china.huawei.com (7.202.195.162)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[lihongbo22@huawei.com,linux-btrfs@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-22049-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	RCVD_COUNT_FIVE(0.00)[6];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:mid,huawei.com:dkim,huawei.com:email]
X-Rspamd-Queue-Id: 11AFD1B3822
X-Rspamd-Action: no action

Commit f2dc6ab3a14c ("btrfs: send: check for inline extents in
range_is_hole_in_parent()") is a patch backported directly from
mainline to 6.6, it does not free the path in the inline extents case.

Commit 4ca6f24a52c4 ("btrfs: more trivial BTRFS_PATH_AUTO_FREE
conversions") in 6.18-rc1 fixes this by accident by converting to
BTRFS_PATH_AUTO_FREE, but we cannot backport this to 6.6 due to many
dependencies. Instead, we choose to use a goto statement to avoid the
memory leak in inline extents case.

Fixes: f2dc6ab3a14c ("btrfs: send: check for inline extents in range_is_hole_in_parent()")
Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 fs/btrfs/send.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 6768e2231d61..b107a33dfd4d 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -6545,8 +6545,10 @@ static int range_is_hole_in_parent(struct send_ctx *sctx,
 		extent_end = btrfs_file_extent_end(path);
 		if (extent_end <= start)
 			goto next;
-		if (btrfs_file_extent_type(leaf, fi) == BTRFS_FILE_EXTENT_INLINE)
-			return 0;
+		if (btrfs_file_extent_type(leaf, fi) == BTRFS_FILE_EXTENT_INLINE) {
+			ret = 0;
+			goto out;
+		}
 		if (btrfs_file_extent_disk_bytenr(leaf, fi) == 0) {
 			search_start = extent_end;
 			goto next;
-- 
2.34.1


