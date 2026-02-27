Return-Path: <linux-btrfs+bounces-22072-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLqbNOK4oWkYwAQAu9opvQ
	(envelope-from <linux-btrfs+bounces-22072-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 16:31:46 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D991B9D1D
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 16:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 152BE315D53C
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 15:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE8543D515;
	Fri, 27 Feb 2026 15:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b="1I8Fs3oS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A491A23AC;
	Fri, 27 Feb 2026 15:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772205505; cv=none; b=Iy0BrtdyQ0VoiGRWjiw/Hr154PPa5gvY1/j79e4wBaC/MNyU6gkrXu4Fxhx7c8qYNYYqCDQluFQZMhm/JecNgSEXXoACrhaYhYQf23XS79fL1CxnvhEoV3Xfm4h5aWNVzLYQ3cltaETmUtgKqPr/df6Mwitk6Rc2zIZwqgfc354=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772205505; c=relaxed/simple;
	bh=c+EC9wP2LQZS+mnUdbL5ddZKP7WXJEsGwEj/Gp20W3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Trs6unRreUuoXSSjpVMuJWI0ylqjnbGPSMTrNGa7ispnVA+OHqZBXxoyrEqC5/YTXSL/ogcd68AQraRYQGfkgHN7OlxKLEBe4zRuVztMLjEm8irKdJH2emkrK/bg/JTQfE5usURjjFLlv+tiytocA2pKpLVlqwEfc2/RSU/jTzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com; spf=fail smtp.mailfrom=mssola.com; dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b=1I8Fs3oS; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mssola.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4fMsQz0Z97z9tFZ;
	Fri, 27 Feb 2026 16:18:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mssola.com; s=MBO0001;
	t=1772205499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i/8R02XIRzy8sQhuDCMP6q+5Q1Yj+EuHXolkMlvZNbk=;
	b=1I8Fs3oS9bAnsUlrIUe2z0ytPJcLZqzhYGiOGxN/DXALphIrOmP+57piEgEQBvUmrgQ2oL
	DdIc9HFyM280eDJR9EkasYM6bUrXkKTAF9rii0EwsfPZbwVXZgws9EP1ElaVLF6E+iQndY
	chffNDU4PCfZ5v6qDPh0vfAmMUbdtGOt0uOFYQ39YXVa+WFwOvDIaDyX6qOAjZYeR4mbjx
	q9TmqUYPSKEoMiuhh+ul6DCwgh4zr6tlVKS1bxn1dQT5P5UPCxgxo+mnZW/RgprhdY/pqB
	cEg5o8Xr/btQRIUYqVQ41LNUZNJnzUBKK9MxaDBuPy3NaNG3g5i0QKVZZa/7zA==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=softfail (outgoing_mbo_mout: 2001:67c:2050:b231:465::1 is neither permitted nor denied by domain of mssola@mssola.com) smtp.mailfrom=mssola@mssola.com
From: =?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mssola@mssola.com>
To: dsterba@suse.com
Cc: clm@fb.com,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mssola@mssola.com>
Subject: [PATCH 1/2] btrfs: return early if allocations fail on add_block_entry()
Date: Fri, 27 Feb 2026 16:17:58 +0100
Message-ID: <20260227151759.704838-2-mssola@mssola.com>
In-Reply-To: <20260227151759.704838-1-mssola@mssola.com>
References: <20260227151759.704838-1-mssola@mssola.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.49 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MIXED_CHARSET(0.67)[subject];
	DMARC_POLICY_ALLOW(-0.50)[mssola.com,none];
	R_DKIM_ALLOW(-0.20)[mssola.com:s=MBO0001];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22072-lists,linux-btrfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mssola@mssola.com,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[mssola.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-btrfs];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mssola.com:mid,mssola.com:dkim,mssola.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 30D991B9D1D
X-Rspamd-Action: no action

In add_block_entry(), if the allocation of 're' fails, return right away
instead of trying to allocate 'be' next. This also removes a useless
kfree() call.

Signed-off-by: Miquel Sabaté Solà <mssola@mssola.com>
---
 fs/btrfs/ref-verify.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
index f78369ff2a66..7b4d52db7897 100644
--- a/fs/btrfs/ref-verify.c
+++ b/fs/btrfs/ref-verify.c
@@ -246,14 +246,16 @@ static struct block_entry *add_block_entry(struct btrfs_fs_info *fs_info,
 					   u64 bytenr, u64 len,
 					   u64 root_objectid)
 {
-	struct block_entry *be = NULL, *exist;
-	struct root_entry *re = NULL;
+	struct block_entry *be, *exist;
+	struct root_entry *re;
 
 	re = kzalloc_obj(struct root_entry, GFP_NOFS);
+	if (!re)
+		return ERR_PTR(-ENOMEM);
+
 	be = kzalloc_obj(struct block_entry, GFP_NOFS);
-	if (!be || !re) {
+	if (!be) {
 		kfree(re);
-		kfree(be);
 		return ERR_PTR(-ENOMEM);
 	}
 	be->bytenr = bytenr;
-- 
2.53.0


