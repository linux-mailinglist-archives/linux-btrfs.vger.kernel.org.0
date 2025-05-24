Return-Path: <linux-btrfs+bounces-14201-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BEF2AC2D06
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 May 2025 04:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E33F1BA6EAF
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 May 2025 02:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C93F1946C8;
	Sat, 24 May 2025 02:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fXTrp1Ii";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fXTrp1Ii"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EADE14885B
	for <linux-btrfs@vger.kernel.org>; Sat, 24 May 2025 02:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748052532; cv=none; b=Ysvx6CIgvxCJ6n+M/bqB/hp8rKWSrYio962RaWFWBRDUpOYbyEEhh3EA9KlUC/U38wHdHHsm2ljXwlCievumtgwM/tX/ndnSvWi6CBmgaYDGXCcY2vQCqypKg13rYoF2ZRr/0vC6FqWX6KEquci0OKuLJPRr8/o19tq4rujAcOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748052532; c=relaxed/simple;
	bh=029V/ljFASjQMI8Nd6v26K3MaDcEP5W/cQod5Uo3bLQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=isaevbapbSqh0h8aZhyBnGodzf3HFr8AgWwwWMGpXsrcp4LxY5yxiVlUoLeyJdoBdvvI+jdFYUai9remWQAlqi+pNnaJmy0AA0Jl2dOSm0D+yIrhcUfugV/y1kh1LZKBr/PWhinprl/Kuhw22bmNu5KbhAAzAAvvgFenxmMA1CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fXTrp1Ii; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fXTrp1Ii; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3384C21CA0
	for <linux-btrfs@vger.kernel.org>; Sat, 24 May 2025 02:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748052516; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OZU6CwExVt5pwJs2+GUYME9qaEUBnCtnLBBDUMwKX44=;
	b=fXTrp1IinF3xvX/by8I/GIQLa+f+UbYqRoDGOf/jYOuxWdgT7iPNXbg4ZtpiharuxuisbB
	ZQXFrzcgPf2ANoj4zFul8fv/29cMaf7mkON0/VdHSAlAcjHD8piStkjlHmuwYv1Ejgdxs4
	zd3WQ6BkikOMftN/Nrd9eo+PWWsDFo8=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748052516; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OZU6CwExVt5pwJs2+GUYME9qaEUBnCtnLBBDUMwKX44=;
	b=fXTrp1IinF3xvX/by8I/GIQLa+f+UbYqRoDGOf/jYOuxWdgT7iPNXbg4ZtpiharuxuisbB
	ZQXFrzcgPf2ANoj4zFul8fv/29cMaf7mkON0/VdHSAlAcjHD8piStkjlHmuwYv1Ejgdxs4
	zd3WQ6BkikOMftN/Nrd9eo+PWWsDFo8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 75D1A1373E
	for <linux-btrfs@vger.kernel.org>; Sat, 24 May 2025 02:08:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mDSnDiMqMWjYXQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sat, 24 May 2025 02:08:35 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/9] btrfs-progs: convert: replace the bytenr check with a UASSERT()
Date: Sat, 24 May 2025 11:38:07 +0930
Message-ID: <40dcedd8276d4ce353898571a5ecbf20b4050f49.1748049973.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1748049973.git.wqu@suse.com>
References: <cover.1748049973.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.20
X-Spamd-Result: default: False [0.20 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]

The bytenr sequence of all roots are controlled by our code, so if
something went wrong with the sequence, it's a bug.

A UASSERT() is more suitable for this case.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 convert/common.c | 34 +++++-----------------------------
 1 file changed, 5 insertions(+), 29 deletions(-)

diff --git a/convert/common.c b/convert/common.c
index 2cbe45180ce9..0b567da2312e 100644
--- a/convert/common.c
+++ b/convert/common.c
@@ -260,19 +260,8 @@ static int setup_temp_root_tree(int fd, struct btrfs_mkfs_config *cfg,
 	 * Provided bytenr must in ascending order, or tree root will have a
 	 * bad key order.
 	 */
-	if (!(root_bytenr < extent_bytenr && extent_bytenr < dev_bytenr &&
-	      dev_bytenr < fs_bytenr && fs_bytenr < csum_bytenr)) {
-		error("bad tree bytenr order: "
-				"root < extent %llu < %llu, "
-				"extent < dev %llu < %llu, "
-				"dev < fs %llu < %llu, "
-				"fs < csum %llu < %llu",
-				root_bytenr, extent_bytenr,
-				extent_bytenr, dev_bytenr,
-				dev_bytenr, fs_bytenr,
-				fs_bytenr, csum_bytenr);
-		return -EINVAL;
-	}
+	UASSERT(root_bytenr < extent_bytenr && extent_bytenr < dev_bytenr &&
+	        dev_bytenr < fs_bytenr && fs_bytenr < csum_bytenr);
 	buf = malloc(sizeof(*buf) + cfg->nodesize);
 	if (!buf)
 		return -ENOMEM;
@@ -703,22 +692,9 @@ static int setup_temp_extent_tree(int fd, struct btrfs_mkfs_config *cfg,
 	 * We must ensure provided bytenr are in ascending order,
 	 * or extent tree key order will be broken.
 	 */
-	if (!(chunk_bytenr < root_bytenr && root_bytenr < extent_bytenr &&
-	      extent_bytenr < dev_bytenr && dev_bytenr < fs_bytenr &&
-	      fs_bytenr < csum_bytenr)) {
-		error("bad tree bytenr order: "
-				"chunk < root %llu < %llu, "
-				"root < extent %llu < %llu, "
-				"extent < dev %llu < %llu, "
-				"dev < fs %llu < %llu, "
-				"fs < csum %llu < %llu",
-				chunk_bytenr, root_bytenr,
-				root_bytenr, extent_bytenr,
-				extent_bytenr, dev_bytenr,
-				dev_bytenr, fs_bytenr,
-				fs_bytenr, csum_bytenr);
-		return -EINVAL;
-	}
+	UASSERT(chunk_bytenr < root_bytenr && root_bytenr < extent_bytenr &&
+		extent_bytenr < dev_bytenr && dev_bytenr < fs_bytenr &&
+		fs_bytenr < csum_bytenr);
 	buf = malloc(sizeof(*buf) + cfg->nodesize);
 	if (!buf)
 		return -ENOMEM;
-- 
2.49.0


