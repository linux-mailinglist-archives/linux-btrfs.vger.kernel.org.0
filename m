Return-Path: <linux-btrfs+bounces-8931-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E67699EA01
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2024 14:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DC111C21391
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2024 12:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5530C227B94;
	Tue, 15 Oct 2024 12:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="P97ClPkU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out203-205-221-190.mail.qq.com (out203-205-221-190.mail.qq.com [203.205.221.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E85227B93;
	Tue, 15 Oct 2024 12:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728995962; cv=none; b=iUkFW5zHWUgfj9WEcnFDuG2A04F5BJEqVjW6Ie7kqfZruMMHK7QK9LgO2+vYc2i778dL76yTW1vN0eYCo6wuqF/T0/EVe6kixCtIqqPnkrtevRqSI+Wl+fkNT/BNbxB2srV/eAe+EQKcH7UqhZnnSq1+vE6a846py2aHZLvYn/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728995962; c=relaxed/simple;
	bh=x+iDAAYTgZt7thPALE/GpuoN/+1g28XVcuiZEr2MEbk=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=qFFxRW+BSTQ/sI/EbIEzSyfXT0z27rLqsh34xOxjr5NqE1BK7vzMbYe3n35+h9+8/1cbkoLaz28NPOJKALEAQEZDxPzT8Mhl8W25hY2CCsX/eifjJerscjSSdbLEbuGPbcKjq97Ogm4+/tQg/zs2DptSicddFeu88ZAANJDgqaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=P97ClPkU; arc=none smtp.client-ip=203.205.221.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1728995958; bh=6mzUwp6tTsQPmtvvHIUC4eTR4DQea9zTLMhz8Df/uUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P97ClPkUXGlR5ZxiiS1Jdwqv5wq16M56QYYXIMfSgRhptIZUn3OwITKJMJ/pgDvpw
	 Qoq6NVXebNpsc9tGI1v7ZhY7VRwxnoaHLQPvYLr9uA0kmQn3OsmF1UCqnY0JUYTueN
	 jr7s/bIwcV9xByybxXzdiQm7aC2owPWSNCJWflH8=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrsza15-1.qq.com (NewEsmtp) with SMTP
	id 6AD19C34; Tue, 15 Oct 2024 20:26:45 +0800
X-QQ-mid: xmsmtpt1728995205t9pig5lzf
Message-ID: <tencent_0EBF9E731B704B091B022578BA9EBB8E3308@qq.com>
X-QQ-XMAILINFO: NDz66ktblfzJrZJDwmHjGNtPHzbvecvgaHO9S260NFM0PyeeXQZAeHYqUX/EuD
	 x/i7GprzXlhbKdlhEODCaiALa3OMv+dg4dY94//BbETSFOyxC6RqW3wvGDUMYyK2huoZm4iKOnV0
	 zjpGHbWQeOj17p7eGMSQS3hfsyIzhHZO62AwN+XJckbTuCXIW+eQDpPLPOED6J02BNZkHvME4V3r
	 sNNJflEY23E8lw2PVxyNmh/aDFiz6wGAf1WTSGmHWcRdyZknY9STw843auJWw4JBpwnA+maPfb5T
	 i7YDOodrOdAycLqFEd9FsXtyVTKQcN+BSQd4eBXU3ZdwgF2B3wpO2mFLK0FBOcQakjcbIAMpLAaM
	 n2MM1Jav6uGED56VveP9/KiPYMVbkmnEDaLZb0c0mW4nil/DO6+ke7CmK0K64vjpcaZVJgSi55I+
	 zUTimoe8BvR6NV3T3lGANO4KAKpUY438yEPDcl//RJKJXRydQEUzomdcw3ghBAvnhWCKwP+x1NqQ
	 zi/3Gb1lLjUd3CDerOChFkoqJJkBs0Ho2Wa3YfAH2k6jsC+NVKoXXWMJD5unZJkx5Uc4y7kiDA5U
	 b8e0Y+VT8PZnJersrV3BKRfOsVOIZjQl4OMWrwWKPgdqiLNHnHh6Ecn6itN+OtWE88bWSRs+5RAl
	 qsTIC0JeXp6U+MwQDaI+d/r2LNXHPEEFvT54bMPtaz7aHUsEBBdOmEysud2GJpqFkV60ht1Z4ALk
	 HiiSAbQGYC4usk7kOMA/bdHC0tW7VHkoxMwHu6cStsNrq5pQ96D6i2xhFLTopZ17JFT7D4hwyYuM
	 OkF3TcoeacP4WgY+Nl9Zpo71RylLZLVLdQe0FmR7e8OyVi3xlVQR6On3eyjEG5zbrJSGQNKYsf1r
	 XGFe0s4Hqk3MJUEaqqfh7j+NMtWnP1bF55/7ejcPs4Ueu9ZmHjjADsPruCdY3NER8uXsX357i5Gq
	 5bRSKJCXiE/B7KchFdJQ==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+c3a3a153f0190dca5be9@syzkaller.appspotmail.com
Cc: clm@fb.com,
	dsterba@suse.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH next] btrfs: Accessing head_ref within delayed_refs lock
Date: Tue, 15 Oct 2024 20:26:46 +0800
X-OQ-MSGID: <20241015122645.136494-2-eadavis@qq.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <670d3f2c.050a0220.3e960.0066.GAE@google.com>
References: <670d3f2c.050a0220.3e960.0066.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is because the thread routine btrfs_work_helper released head_def after
exiting delayed_refs->lock in add_delayed_ref.
Causing add_delayed_ref to encounter uaf when accessing head_def->bytenr
outside the delayed_refs->lock.

Move head_ref->bytenr into the protection range of delayed_refs->lock 
to avoid uaf in add_delayed_ref.

Fixes: a3aad8f4f5d9 ("btrfs: qgroups: remove bytenr field from struct btrfs_qgroup_extent_record")
Reported-and-tested-by: syzbot+c3a3a153f0190dca5be9@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c3a3a153f0190dca5be9
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/btrfs/delayed-ref.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 13c2e00d1270..f50fc05847a1 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -1012,6 +1012,7 @@ static int add_delayed_ref(struct btrfs_trans_handle *trans,
 	int action = generic_ref->action;
 	bool merged;
 	int ret;
+	u64 bytenr;
 
 	node = kmem_cache_alloc(btrfs_delayed_ref_node_cachep, GFP_NOFS);
 	if (!node)
@@ -1056,6 +1057,7 @@ static int add_delayed_ref(struct btrfs_trans_handle *trans,
 		goto free_record;
 	}
 	head_ref = new_head_ref;
+	bytenr = head_ref->bytenr;
 
 	merged = insert_delayed_ref(trans, head_ref, node);
 	spin_unlock(&delayed_refs->lock);
@@ -1074,7 +1076,7 @@ static int add_delayed_ref(struct btrfs_trans_handle *trans,
 		kmem_cache_free(btrfs_delayed_ref_node_cachep, node);
 
 	if (qrecord_inserted)
-		return btrfs_qgroup_trace_extent_post(trans, record, head_ref->bytenr);
+		return btrfs_qgroup_trace_extent_post(trans, record, bytenr);
 	return 0;
 
 free_record:
-- 
2.43.0


