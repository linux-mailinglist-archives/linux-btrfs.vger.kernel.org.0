Return-Path: <linux-btrfs+bounces-22039-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFDfCYThoGk4nwQAu9opvQ
	(envelope-from <linux-btrfs+bounces-22039-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 01:12:52 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D061B127F
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 01:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80DAE305C2BD
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 00:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A560208961;
	Fri, 27 Feb 2026 00:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UxEoZ96M"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9834E1FF7C7
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Feb 2026 00:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772151109; cv=none; b=b7rSXLxh9CXbjG5y5TI9XDc4gu5lbcUmBVdyjaPJ6OgJ7qpsHC6f9i1TtOv+ZHc7q1Rq3EqoWwYxA8zXyrdyuUcc0Mp+sqEjpKKFp8Eo3t1fbtaY9HQk0ATH/UmbtMKeyulR7lLx8FbJnfd003j3DI7u7gG60iNRRYdKY003cGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772151109; c=relaxed/simple;
	bh=O0pfZSxohe516n1a4BYIbBz9/waHKPobAAoZfwqT4Tk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XzA4Ny2cyyATuYon6VMxojLDT1lN6RARn72gs55Sb8KexzoWDCeW6XVHZEVLDOjNsOopv58WhlNzt7e2JQf7WvS2LuySp04QNUzQkF/2R62EvKxiL3UNDPVPT8pX+TDcVbPtMkCX+aDYGgYBs3j5QcVxX3W5FNNrx2amuR/Gj/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UxEoZ96M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0B96C116C6
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Feb 2026 00:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772151109;
	bh=O0pfZSxohe516n1a4BYIbBz9/waHKPobAAoZfwqT4Tk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=UxEoZ96MrIMBml3EATQy3oOUgtsJGe1VrxnHPSY5wK5yXLgAkzcl3h7pwUhem8v5n
	 cF2CHcVUNUu9A6w5ZNgZE3GL5dArbCaURoZvpIUD/k7O6P8hysSPX7J+za0EDlSer0
	 7tgkz4z+D0sSH2S6xam33T7Y5zl4mB31IrjenGhCIrOQyDwxRgw9Q2fLeRQsVIpLrn
	 gl4nXG7nzdlThthR07j+RfaimLRiW/40NlSn54VCm9jZJahqASOs0GI+WVEnaCpGze
	 YyZ7EJGaA+XnoS8pWURxbNhixwJ3M+RFSjzpneAd618BDHYIObNmw9eMSYvWvkTKmc
	 uktZUEeBdfwrg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs: abort transaction on failure to update root in the received subvol ioctl
Date: Fri, 27 Feb 2026 00:11:42 +0000
Message-ID: <fb5378fbfbb1f7a51b3187f65213d1222c852a8f.1772150849.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1772150849.git.fdmanana@suse.com>
References: <cover.1772150849.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22039-lists,linux-btrfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C8D061B127F
X-Rspamd-Action: no action

From: Filipe Manana <fdmanana@suse.com>

If we failed to update the root we don't abort the transaction, which is
wrong since we already used the transaction to remove an item from the
uuid tree.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ioctl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index dd411b0732a7..8799eb82c4c3 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3921,6 +3921,7 @@ static long _btrfs_ioctl_set_received_subvol(struct file *file,
 	ret = btrfs_update_root(trans, fs_info->tree_root,
 				&root->root_key, &root->root_item);
 	if (ret < 0) {
+		btrfs_abort_transaction(trans, ret);
 		btrfs_end_transaction(trans);
 		goto out;
 	}
-- 
2.47.2


