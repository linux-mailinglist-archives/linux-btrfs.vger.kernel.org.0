Return-Path: <linux-btrfs+bounces-20859-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJz9EKoicWl8eQAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20859-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 20:02:02 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D8F5BBB0
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 20:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A40EC9A2674
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 16:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEBA4A33E8;
	Wed, 21 Jan 2026 16:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MkKh9MfP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CB4494A1A
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 16:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769013649; cv=none; b=ihKg6gaYajoVPLJy8XtmF5UOPVQ2Aqi0QRUh/2bpfapPsL6lFl2LMfL3HiMrPXDSsnEflYxbc5hzl0PAabXlfiCGR5+FRe1EKernhG9mVfg8wENqzIt57+hn4qEs9QlV3gpyoQnTQ7u5TRnZBkjaSm1SVDJt3T5Pbjb03b7ANTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769013649; c=relaxed/simple;
	bh=jlM/LtmLtEhWHmA65Ilb5nHba8h71F1ezGFEpDo1Cps=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=VOvdO+4LdGC483PD/zGV5Bjm87OzbVjRAaKrXstQPy9RxGAXn4HSllowF/75rFMUhx4MDPhEcbbTt+4AVKqxw/8rRjwLHgcEsWp8Mr3VISqQdtTYWxkK8SFVAUse2x445CJdrAAnkgDO6QnpHaY2Fm0KIi2+HtuUNKW5mfQ7Wm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MkKh9MfP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 280F0C4CEF1
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 16:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769013648;
	bh=jlM/LtmLtEhWHmA65Ilb5nHba8h71F1ezGFEpDo1Cps=;
	h=From:To:Subject:Date:From;
	b=MkKh9MfP6fZdo+xMBGPZAqRGAw6XthbB8ZJ6hY4fvY9qqmzD+dr02QhbIecQcWJYy
	 xrKBQQoJSm4C7RTFnpu0yo38i7jm0UKvTJ9H3v75TR2jnoTZXn8i/uqqyXfegq+DYM
	 yFTsmqbFIdKVKCWO9eRb7STpprrvQY70bg5Y0DPsNX2aVIpwxcRh0oHPuQeL3rd5eT
	 HOqnwP64/U0gSnWo8qqSRzDHCei8gk0cSMphmfdmZMP7otxQgeoOn1A34FR4HWA4q5
	 30ia7Ieo/Fd/IJRvk3Zge45h0VpIA5YqPt60vT3I0lrQTvWkX0x4XyxibYwi99YQ8V
	 5axbR6Au2ACMw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: unfold transaction aborts in btrfs_finish_one_ordered()
Date: Wed, 21 Jan 2026 16:40:45 +0000
Message-ID: <f528a186fae32bf12b9d2a61efa77a1cad66e55a.1769013565.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20859-lists,linux-btrfs=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org]
X-Rspamd-Queue-Id: 78D8F5BBB0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Filipe Manana <fdmanana@suse.com>

We have a single transaction abort that can be caused either by a failure
from a call to btrfs_mark_extent_written(), if we are dealling with a
write to a prealloc extent, or otherwise from a call to
insert_ordered_extent_file_extent(). So when the transaction abort happens
we can know for sure which case failed. Unfold the aborts so that it's
clear in case of a failure.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 09a7e074ecb9..10609b8199a0 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3253,19 +3253,21 @@ int btrfs_finish_one_ordered(struct btrfs_ordered_extent *ordered_extent)
 						logical_len);
 		btrfs_zoned_release_data_reloc_bg(fs_info, ordered_extent->disk_bytenr,
 						  ordered_extent->disk_num_bytes);
+		if (unlikely(ret < 0)) {
+			btrfs_abort_transaction(trans, ret);
+			goto out;
+		}
 	} else {
 		BUG_ON(root == fs_info->tree_root);
 		ret = insert_ordered_extent_file_extent(trans, ordered_extent);
-		if (!ret) {
-			clear_reserved_extent = false;
-			btrfs_release_delalloc_bytes(fs_info,
-						ordered_extent->disk_bytenr,
-						ordered_extent->disk_num_bytes);
+		if (unlikely(ret < 0)) {
+			btrfs_abort_transaction(trans, ret);
+			goto out;
 		}
-	}
-	if (unlikely(ret < 0)) {
-		btrfs_abort_transaction(trans, ret);
-		goto out;
+		clear_reserved_extent = false;
+		btrfs_release_delalloc_bytes(fs_info,
+					     ordered_extent->disk_bytenr,
+					     ordered_extent->disk_num_bytes);
 	}
 
 	ret = btrfs_unpin_extent_cache(inode, ordered_extent->file_offset,
-- 
2.47.2


