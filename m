Return-Path: <linux-btrfs+bounces-4799-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA8D8BDC14
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2024 09:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C267B1C21B0E
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2024 07:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099FF13B5A4;
	Tue,  7 May 2024 07:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="XL/oFA0Y";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="XL/oFA0Y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FA112FF9B;
	Tue,  7 May 2024 07:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715065594; cv=none; b=PcHxh9OAc2OFlXAx0E6HDIS67XEq7CEPBuO9AsHmsblTn1fivgeyf3wgGv2m5+2Y4iv0nCRDICCJASIAdYCIRu5CRS3QREVBvKm2ccdQrZ9EgOgNdEJ1TE4lC1CmOLU94nG4s/D2rQZV1r59pcfJVqBAFcwdiClkwNH2F7oAfJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715065594; c=relaxed/simple;
	bh=OqOr5ZD3V/TLQas1e4d2FLAH5L6fKYb0atjJG9DonCU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=FqfsepYkgvd4pguQLNK3tnDDP5XaWsEVVkmPS0X8fCx3FfURKg2GjOOr8dox5Clp2Qo/fUZHEaiO0Q7qtiOM2M3/RrzPDK9CzdtsyBtalICKfMAN5hPS3dNH0fiFDYwJS782UZy7gIR+08FaJa9IHIWLDCrs3MAQU5k4PORTfxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=XL/oFA0Y; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=XL/oFA0Y; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6C8BC33AA3;
	Tue,  7 May 2024 07:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715065590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Ddesa1nvagHjWueGsIp4Yh9SO+s/Z0U3L3vbjNYwR+s=;
	b=XL/oFA0Y2sC8U2ImuEhoVUq/hg78s3cM2u+5FboIC78s7wTaB4RRZaPYxAzuwJyFddoY6o
	YK1yRSdMnGkZVCvphKMOpfx/Ey4BaBUdS2aH+ZlACSJ3Er51yKqEmmxoHMe+L0dnhU8wzU
	1Du6z42IBzDc5e6fy6vOVbaO10p5vok=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715065590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Ddesa1nvagHjWueGsIp4Yh9SO+s/Z0U3L3vbjNYwR+s=;
	b=XL/oFA0Y2sC8U2ImuEhoVUq/hg78s3cM2u+5FboIC78s7wTaB4RRZaPYxAzuwJyFddoY6o
	YK1yRSdMnGkZVCvphKMOpfx/Ey4BaBUdS2aH+ZlACSJ3Er51yKqEmmxoHMe+L0dnhU8wzU
	1Du6z42IBzDc5e6fy6vOVbaO10p5vok=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 37B5D13A3A;
	Tue,  7 May 2024 07:06:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FE4VN/TSOWamGwAAD6G6ig
	(envelope-from <wqu@suse.com>); Tue, 07 May 2024 07:06:28 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH] fstests: btrfs/301: handle auto-removed qgroups
Date: Tue,  7 May 2024 16:36:06 +0930
Message-ID: <20240507070606.64126-1-wqu@suse.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]

There are always attempts to auto-remove empty qgroups after dropping a
subvolume.

For squota mode, not all qgroups can or should be dropped, as there are
common cases where the dropped subvolume are still referred by other
snapshots.
In that case, the numbers can only be freed when the last referencer
got dropped.

The latest kernel attempt would only try to drop empty qgroups for
squota mode.
But even with such safe change, the test case still needs to handle
auto-removed qgroups, by explicitly echoing "0", or later calculation
would break bash grammar.

This patch would add extra handling for such removed qgroups, to be
future proof for qgroup auto-removal behavior change.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/301 | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tests/btrfs/301 b/tests/btrfs/301
index db469724..bb18ab04 100755
--- a/tests/btrfs/301
+++ b/tests/btrfs/301
@@ -51,9 +51,17 @@ _require_fio $fio_config
 get_qgroup_usage()
 {
 	local qgroupid=$1
+	local output
 
-	$BTRFS_UTIL_PROG qgroup show --sync --raw $SCRATCH_MNT | \
-				grep "$qgroupid" | $AWK_PROG '{print $3}'
+	output=$($BTRFS_UTIL_PROG qgroup show --sync --raw $SCRATCH_MNT | \
+		 grep "$qgroupid" | $AWK_PROG '{print $3}')
+	# The qgroup is auto-removed, this can only happen if its numbers are
+	# already all zeros, so here we only need to explicitly echo "0".
+	if [ -z "$output" ]; then
+		echo "0"
+	else
+		echo "$output"
+	fi
 }
 
 get_subvol_usage()
-- 
2.44.0


