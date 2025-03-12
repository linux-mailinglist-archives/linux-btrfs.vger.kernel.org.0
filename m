Return-Path: <linux-btrfs+bounces-12231-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA8BA5DB21
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Mar 2025 12:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B54303B94EE
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Mar 2025 11:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF23023ED56;
	Wed, 12 Mar 2025 11:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qHTnir3l";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qHTnir3l"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3F823AE83
	for <linux-btrfs@vger.kernel.org>; Wed, 12 Mar 2025 11:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741777972; cv=none; b=JUhDsx9fE2toGI3h5Grls++x73iNnzKKIVW+n7sYSZoMxGVftLxgmu5nl9jZMMHcQ0qodf8iVPufpnYWAiE1w/xP3qYYyRg6zPYKgC0uMlfMvxw72aHFP06ICOGi6GE3JhkziEfLxAaOS7XlQbT9F2FFxrgLIHX1NgJa1v2S4YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741777972; c=relaxed/simple;
	bh=u51y2eHwjTtxt68gjgwGVIiR38qfRhRG+TtaHxzz6kA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jiwVCx8EX0OmwrRp1KaDHgC4FwEgTm7nOh7YC5pATAlW//unMHl3XrPO8JSJG2IoxPcQpmNdJWJIynIw1A5xj8izLN6J5Y6eU5CTnDpeQf/+/Sc4KCxi4pU9QN8pjzrDJ+R5mdWZ4q3GEp5VjEZIRPo/Mv27CDr/hnysuhMsAyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qHTnir3l; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qHTnir3l; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3804D21169;
	Wed, 12 Mar 2025 11:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741777960; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ik4vWLFtYIlWv2HmhLmCzgZ1F/5/uQlsWwmkG3Y3yfw=;
	b=qHTnir3lamDh+wFMB6ney4TQgRNkN5L4sj1epYh73QqaS/VZptf0E6Mv2UFabbZGtNAFf/
	mgSD3YYmng/+zGKNaiOEAmEhSpg3PK3gRA5C5Ed9ac2MqD6WMrpaddveFpZ9v6j7J2MHsX
	S+DBwCtKL+Mv4MovT5mRW8+dcZCVcwY=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741777960; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ik4vWLFtYIlWv2HmhLmCzgZ1F/5/uQlsWwmkG3Y3yfw=;
	b=qHTnir3lamDh+wFMB6ney4TQgRNkN5L4sj1epYh73QqaS/VZptf0E6Mv2UFabbZGtNAFf/
	mgSD3YYmng/+zGKNaiOEAmEhSpg3PK3gRA5C5Ed9ac2MqD6WMrpaddveFpZ9v6j7J2MHsX
	S+DBwCtKL+Mv4MovT5mRW8+dcZCVcwY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 31659132CB;
	Wed, 12 Mar 2025 11:12:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QcQLDChs0WdFNgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 12 Mar 2025 11:12:40 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH v2 5/6] btrfs: add more zeroout modes to CLEAR_FREE ioctl
Date: Wed, 12 Mar 2025 12:12:39 +0100
Message-ID: <b0b90b337da3510b585e37bc4bada0bd60a27440.1741777050.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1741777050.git.dsterba@suse.com>
References: <cover.1741777050.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

The zeroing mode BTRFS_CLEAR_OP_ZERO is safe for use regardless of the
underlying device capabilities, either zeros are written or the device
will unmap the blocks. This a safe behaviour.

In case it's desired to do one or the another add modes that can enforce
that or fail when unsupported;

- CLEAR_OP_ZERO - overwrite by zero blocks, forbid unmapping blocks by
                  the device

- CLEAR_OP_ZERO_NOFALLBACK - unmap the blocks by device and do not fall
                             back to overwriting by zeros

Implemented by __blkdev_issue_zeroout() and also documented there.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent-tree.c     | 11 +++++++++--
 include/uapi/linux/btrfs.h |  5 +++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 1e2fe403ee89..f287184ae663 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1259,10 +1259,17 @@ static int btrfs_issue_clear_op(struct block_device *bdev, u64 start, u64 size,
 	case BTRFS_CLEAR_OP_DISCARD:
 		return blkdev_issue_discard(bdev, start >> SECTOR_SHIFT,
 					    size >> SECTOR_SHIFT, GFP_NOFS);
+	case BTRFS_CLEAR_OP_ZERO_NOUNMAP:
+		flags |= BLKDEV_ZERO_NOUNMAP;
+		return blkdev_issue_zeroout(bdev, start >> SECTOR_SHIFT,
+					    size >> SECTOR_SHIFT, GFP_NOFS, flags);
+	case BTRFS_CLEAR_OP_ZERO_NOFALLBACK:
+		flags |= BLKDEV_ZERO_NOFALLBACK;
+		return blkdev_issue_zeroout(bdev, start >> SECTOR_SHIFT,
+					    size >> SECTOR_SHIFT, GFP_NOFS, flags);
 	case BTRFS_CLEAR_OP_ZERO:
 		return blkdev_issue_zeroout(bdev, start >> SECTOR_SHIFT,
-					    size >> SECTOR_SHIFT, GFP_NOFS,
-					    flags);
+					    size >> SECTOR_SHIFT, GFP_NOFS, flags);
 	default:
 		return -EOPNOTSUPP;
 	}
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index 229a07843965..e2f16733c53f 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -1114,6 +1114,11 @@ enum btrfs_clear_op_type {
 	 * garbage collection must also be erased.
 	 */
 	BTRFS_CLEAR_OP_SECURE_ERASE,
+
+	/* Overwrite by zeros, do not try to unmap blocks. */
+	BTRFS_CLEAR_OP_ZERO_NOUNMAP,
+	/* Request unmapping the blocks and don't fall back to writing zeros. */
+	BTRFS_CLEAR_OP_ZERO_NOFALLBACK,
 	BTRFS_NR_CLEAR_OP_TYPES,
 };
 
-- 
2.47.1


