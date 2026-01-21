Return-Path: <linux-btrfs+bounces-20821-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6IoOLqu7cGkRZgAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20821-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 12:42:35 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBCD56299
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 12:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5FFDB9456C7
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 11:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538BC480DDD;
	Wed, 21 Jan 2026 11:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JaArpAAQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661B7480960
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 11:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768994047; cv=none; b=ggVn1Lr0TpiIvFn2GnCLt0dFG31qkdHeRHZ5hGymYODiYDhGXhY62u4tdfwV8hq2imSNN6QbYb/tYlAy+60QoAQBl9dPlWOgtkJUsmb0yIVvmJeJsuvpXwcBfpDtWxKgndRmBDCeVFNuoVNC0ndV2UUaab1WtO9DH80BIgFV4hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768994047; c=relaxed/simple;
	bh=AFX21W9vR8YpM42S6GNoRm6OKklQMMJbuHfdq6MEIbU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=egHc1uKNjF5f9lVg8/vHbAWvHadR0y6Hs042QZigERnT6aLMpWD2K5Wjt3PiocHxB2Pxwi3Iw85HnA8y6z23EXrny4f13caoXI8ShRRg/fm+cPv5Zdn2hMslwCLAT9x9BDoZIBS7IOG/eid7ntpfMk2YpriUU70YU48O8dKn3mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JaArpAAQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61310C19424
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 11:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768994046;
	bh=AFX21W9vR8YpM42S6GNoRm6OKklQMMJbuHfdq6MEIbU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=JaArpAAQukxgMKxFlmoNZByliSwEoZ8IySHGlq5q6mfScorR0Se/BiF4yAzCFajvu
	 cCifGdb3FI3k1bMYCJKUtb+AgFkjzqcNNs15BVbX+KcoZ7S5kUTf2H6na0aEEBzdsi
	 MvHwQtJuFB6hEB0f+dAU6ks8ieSpBIfCbupcyPEPWQ3P74ZXAVj7LBEfDngMxy7v3D
	 R0vOEW5pClEB3AiyNyBHd4JOExaePhTEDKUzTu3RIFzKvZE2pp6GMseTZEher1xSSA
	 bAZB8c3O5CEM0tUc/xuQQxLfN9J+5K212d85ito90Xk94Mxrjx2rWUKGLF/WXnk7rA
	 jNXSyinjro5ZA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 11/19] btrfs: remove out_failed label in find_lock_delalloc_range()
Date: Wed, 21 Jan 2026 11:13:45 +0000
Message-ID: <7d2ac3cba9f38bc61dc3a629551b2d2416734e7d.1768993725.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1768993725.git.fdmanana@suse.com>
References: <cover.1768993725.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20821-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 2CBCD56299
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Filipe Manana <fdmanana@suse.com>

There is no point in having the label since all it does is return the
value in the 'found' variable. Instead make every goto return directly
and remove the label.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_io.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index dfc17c292217..3df399dc8856 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -440,8 +440,7 @@ noinline_for_stack bool find_lock_delalloc_range(struct inode *inode,
 			loops = 1;
 			goto again;
 		} else {
-			found = false;
-			goto out_failed;
+			return false;
 		}
 	}
 
@@ -461,7 +460,7 @@ noinline_for_stack bool find_lock_delalloc_range(struct inode *inode,
 	}
 	*start = delalloc_start;
 	*end = delalloc_end;
-out_failed:
+
 	return found;
 }
 
-- 
2.47.2


