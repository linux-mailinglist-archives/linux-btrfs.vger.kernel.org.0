Return-Path: <linux-btrfs+bounces-21622-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJebAeG/i2l6aQAAu9opvQ
	(envelope-from <linux-btrfs+bounces-21622-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Feb 2026 00:31:45 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D6511FF7A
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Feb 2026 00:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 570CF30599F9
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 23:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FBE331282F;
	Tue, 10 Feb 2026 23:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lKw2bICs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D582DC76F;
	Tue, 10 Feb 2026 23:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770766298; cv=none; b=gJ4dmLMm9I4hoKlnNX50lhC5rQlY5Bt7MjZDV0dNsb6Ev9JToBWrhnadX3WFAuppswYBKdFkeqx0Omy96GDHJcZcBLqu+UNcz69cDkfBOlnuB7ocydNwlltEInCv9EaCc/AbbH0jD/pcAx+IPxMrgi1p3yoZm5lFHJZjyAXZbdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770766298; c=relaxed/simple;
	bh=PR342Yvg/wWgOLIi+ArpXvdos4mdkwXg+U2ozOVU6zE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bk161RAcG/KqywnIyfjtJVN+ctJBhTa64feNW33XfSILv80p0FbKBOc65LSfomEtOERF6hadQdVH3FOoZ4zjOiudHRPHRHH6Lg+z55hAqPyLoniL7jKagZAk/RowG1VAAW1FKgnYj7pE+b6wPElu4kuuadGwNRX7rXRsADG7aB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lKw2bICs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1278AC19424;
	Tue, 10 Feb 2026 23:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770766298;
	bh=PR342Yvg/wWgOLIi+ArpXvdos4mdkwXg+U2ozOVU6zE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lKw2bICsNxN36rGEXoIOZC2weXIfP+0SDDyppqp0s+385R/TsaQuX7yI9wI8aw/Pi
	 Frv0DD/T0SVJONqHP7ST6be1L9y/jvrN+DQ5Fa0gCO/T/GQF7Ct3dIKf3V7CfWJhPb
	 JfIlWs3nUEy7GUmSMiaX78gd9q8uAMsWvImcTjSj/5K9IYAwpGpAkXR7NDy1sBkxlJ
	 lEc14onn+k0v/4FY7UKsUN7+dtXFRUlwcW4G4tGaBsSJgbPjLUnSiuIH/m/wNlHM0m
	 5PPNbxpzbzp1zZS1AX8z9biPgc0Ox4knL9fbJQniUCKNoV1K2Lg/lwYTq0oWG257al
	 vD+Mu7N+7viGA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Boris Burkov <boris@bur.io>,
	Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19] btrfs: don't BUG() on unexpected delayed ref type in run_one_delayed_ref()
Date: Tue, 10 Feb 2026 18:30:53 -0500
Message-ID: <20260210233123.2905307-8-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260210233123.2905307-1-sashal@kernel.org>
References: <20260210233123.2905307-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.19
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21622-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bur.io:email]
X-Rspamd-Queue-Id: 76D6511FF7A
X-Rspamd-Action: no action

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit c7d1d4ff56744074e005771aff193b927392d51f ]

There is no need to BUG(), we can just return an error and log an error
message.

Reviewed-by: Boris Burkov <boris@bur.io>
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Those `BUG()` calls in the sub-functions (`run_delayed_data_ref` line
1602 and `run_delayed_tree_ref` line 1752) are for unexpected
`node->action` values, not `node->type` values. The commit we're
analyzing only addresses the `node->type` BUG() in
`run_one_delayed_ref`. These are separate concerns and independently
addressable.

## Analysis Summary

### What the commit does
This commit replaces a `BUG()` (unconditional kernel panic) with proper
error handling (`-EUCLEAN` return + `btrfs_err()` log message) in
`run_one_delayed_ref()` in `fs/btrfs/extent-tree.c`. The `BUG()`
triggers when a delayed ref node has an unexpected type value that
doesn't match any of the known reference key types
(`BTRFS_TREE_BLOCK_REF_KEY`, `BTRFS_SHARED_BLOCK_REF_KEY`,
`BTRFS_EXTENT_DATA_REF_KEY`, `BTRFS_SHARED_DATA_REF_KEY`, or
`BTRFS_EXTENT_OWNER_REF_KEY`).

### Why it matters
- **BUG() causes a complete kernel crash/panic.** The system becomes
  unresponsive, potentially causing data loss if writes were in
  progress, and requires a reboot.
- **With the fix**, the error returns -EUCLEAN, which propagates through
  `btrfs_run_delayed_refs_for_head()` -> `__btrfs_run_delayed_refs()` ->
  `btrfs_run_delayed_refs()`, where `btrfs_abort_transaction(trans,
  ret)` is called. This gracefully aborts the transaction and puts the
  filesystem into an error state, allowing the system to continue
  operating (possibly in read-only mode for that filesystem) without a
  full kernel crash.

### Trigger conditions
While the `node->type` field is typically populated correctly by
`btrfs_ref_type()` (which can only return 4 valid values), this BUG()
can be triggered by:
1. **Memory corruption** (e.g., hardware memory errors, other kernel
   bugs corrupting memory)
2. **Future code bugs** that introduce a new type without handling it
   here
3. **Unusual filesystem states** or logic bugs in the delayed ref
   infrastructure

### Stable kernel criteria assessment

1. **Obviously correct and tested**: Yes. The patch is reviewed by 3
   btrfs developers (Boris Burkov, Qu Wenruo, David Sterba). The error
   path already exists and is exercised by other error codes. The change
   is straightforward: `BUG()` -> `return -EUCLEAN` + error log.

2. **Fixes a real bug**: Yes. BUG() in a code path that can be triggered
   is a bug - it causes an unnecessary kernel crash when graceful error
   handling is possible. The entire call chain already handles errors
   from this function correctly.

3. **Fixes an important issue**: Yes. A kernel panic/crash is a serious
   issue. Converting to graceful error handling prevents data loss and
   system downtime.

4. **Small and contained**: Yes. The change is approximately 10 lines in
   a single function, in a single file. It only modifies error handling
   behavior.

5. **No new features**: Correct. No new features or APIs are added. This
   only changes how an error condition is handled.

6. **Applies cleanly**: For 6.12.y and later stable trees, it should
   apply cleanly. For 6.6.y, the `BTRFS_EXTENT_OWNER_REF_KEY` branch
   needs to be removed (it was introduced in v6.7), requiring a minor
   backport adaptation.

### Precedent
Similar BUG_ON()/BUG() to -EUCLEAN conversions in the same file
(`fs/btrfs/extent-tree.c`) by the same author have been backported to
stable:
- `28cb13f29faf` ("btrfs: don't BUG_ON() when 0 reference count at
  btrfs_lookup_extent_info()") - backported to 6.6.y
- `bb3868033a4c` ("btrfs: do not BUG_ON() when freeing tree block after
  error") - backported to 6.6.y

### Risk assessment
**Very low risk.** The change only affects an error path that was
previously causing a kernel panic. The new behavior (returning -EUCLEAN)
is strictly better than the old behavior (BUG/crash). The error
propagation chain is already well-tested since other errors from
`run_one_delayed_ref` follow the exact same path.

### Dependencies
The commit is **self-contained**. It has no dependencies on other
commits. For older stable trees (pre-6.7), the
`BTRFS_EXTENT_OWNER_REF_KEY` branch wouldn't exist, requiring a trivial
adaptation.

**YES**

 fs/btrfs/extent-tree.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index e4cae34620d19..1bf081243efb2 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1761,32 +1761,36 @@ static int run_one_delayed_ref(struct btrfs_trans_handle *trans,
 			       struct btrfs_delayed_extent_op *extent_op,
 			       bool insert_reserved)
 {
+	struct btrfs_fs_info *fs_info = trans->fs_info;
 	int ret = 0;
 
 	if (TRANS_ABORTED(trans)) {
 		if (insert_reserved) {
 			btrfs_pin_extent(trans, node->bytenr, node->num_bytes);
-			free_head_ref_squota_rsv(trans->fs_info, href);
+			free_head_ref_squota_rsv(fs_info, href);
 		}
 		return 0;
 	}
 
 	if (node->type == BTRFS_TREE_BLOCK_REF_KEY ||
-	    node->type == BTRFS_SHARED_BLOCK_REF_KEY)
+	    node->type == BTRFS_SHARED_BLOCK_REF_KEY) {
 		ret = run_delayed_tree_ref(trans, href, node, extent_op,
 					   insert_reserved);
-	else if (node->type == BTRFS_EXTENT_DATA_REF_KEY ||
-		 node->type == BTRFS_SHARED_DATA_REF_KEY)
+	} else if (node->type == BTRFS_EXTENT_DATA_REF_KEY ||
+		   node->type == BTRFS_SHARED_DATA_REF_KEY) {
 		ret = run_delayed_data_ref(trans, href, node, extent_op,
 					   insert_reserved);
-	else if (node->type == BTRFS_EXTENT_OWNER_REF_KEY)
+	} else if (node->type == BTRFS_EXTENT_OWNER_REF_KEY) {
 		ret = 0;
-	else
-		BUG();
+	} else {
+		ret = -EUCLEAN;
+		btrfs_err(fs_info, "unexpected delayed ref node type: %u", node->type);
+	}
+
 	if (ret && insert_reserved)
 		btrfs_pin_extent(trans, node->bytenr, node->num_bytes);
 	if (ret < 0)
-		btrfs_err(trans->fs_info,
+		btrfs_err(fs_info,
 "failed to run delayed ref for logical %llu num_bytes %llu type %u action %u ref_mod %d: %d",
 			  node->bytenr, node->num_bytes, node->type,
 			  node->action, node->ref_mod, ret);
-- 
2.51.0


