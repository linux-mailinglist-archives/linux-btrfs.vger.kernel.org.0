Return-Path: <linux-btrfs+bounces-2552-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E793885B1CA
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Feb 2024 05:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88134B2161E
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Feb 2024 04:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637C256759;
	Tue, 20 Feb 2024 04:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="cGFvrIXd";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="cGFvrIXd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8953454F94;
	Tue, 20 Feb 2024 04:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708401711; cv=none; b=fxPKKkCPAMGf2ZzgSkFPsmD6cNUDvQbAGEYOJQFtvK9KEZuKECUX4P424lYtBwkgXWhfbbrQpcjAx+H2n4YwFGTw0usoaE1fkMQmbylu47WjHUdq/2tO1VYf2FSa5S5zKNBmaVSh9Fu6/hBShXrrSJHMjbbr8j2Hv852/75qUlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708401711; c=relaxed/simple;
	bh=3VbRjOrXlNy6XoiEjbOtN712qBaKYmkiBYBl1BrQ2mM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=r4PIpw3xr4yLaIKhh0sxVr+QjrlB/8yUu2hf6DPN87GbCtnnF/BYHEVCxD4TRvdaXOEtDVz/c+FJrIOryiCw+dCvvwNwDWLwE9jy6GSz1pbsq0AvN6jHj71jAevhZA9ZZ0yFFSAjFdM0J29nNbrxegki3ACTO3RtS2sJspHUzzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=cGFvrIXd; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=cGFvrIXd; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BED491FD5C;
	Tue, 20 Feb 2024 04:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708401701; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=yFCiEiAIO0C1b22i12+uX9Y+alKW8tV9JEL93RADb54=;
	b=cGFvrIXdrUyWFvCNpesOclaUsTnAS8e+MNL4Ju3lhVHGuc/LNIur2BFTLUtrM/7/X6vlXJ
	J+VjyGI3NmuexKAVKSffXmbZOxF1eONBPFswU8T2y40eTbHSaHpz9bfmQl/L5Ush3HF7jx
	zxJuYTaArQ5eEJZmPYko9TiXrP853ek=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708401701; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=yFCiEiAIO0C1b22i12+uX9Y+alKW8tV9JEL93RADb54=;
	b=cGFvrIXdrUyWFvCNpesOclaUsTnAS8e+MNL4Ju3lhVHGuc/LNIur2BFTLUtrM/7/X6vlXJ
	J+VjyGI3NmuexKAVKSffXmbZOxF1eONBPFswU8T2y40eTbHSaHpz9bfmQl/L5Ush3HF7jx
	zxJuYTaArQ5eEJZmPYko9TiXrP853ek=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 7F6FE133B5;
	Tue, 20 Feb 2024 04:01:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id B2aNDiQk1GVeKwAAn2gu4w
	(envelope-from <wqu@suse.com>); Tue, 20 Feb 2024 04:01:40 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH] fstests: btrfs: detect regular qgroup for older kernels correctly
Date: Tue, 20 Feb 2024 14:31:34 +1030
Message-ID: <20240220040134.81084-1-wqu@suse.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [4.89 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_DN_NONE(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.01)[47.93%]
X-Spam-Level: ****
X-Spam-Score: 4.89
X-Spam-Flag: NO

[BUG]
When running an older (vendoer v6.4) kernel, some qgroup test cases
would be skipped:

  btrfs/017 1s ... [not run] not running normal qgroups

[CAUSE]
With the introduce of simple quota mode, there is a new sysfs interface,
/sys/fs/btrfs/<uuid>/qgroups/mode to indicate the currently running
qgroup modes.

And _qgroup_mode() from `common/btrfs` is using that new interface to
detect the mode.

Unfortuantely for older kernels without simple quota support,
_qgroup_mode() would return "disabled" directly, causing those test case
to be skipped.

[FIX]
Fallback to regular qgroup if that sysfs interface is not accessible, as
qgroup is introduced from the very beginning of btrfs, thus the regular
qgroup is always supported.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 common/btrfs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/btrfs b/common/btrfs
index e1b29c61..0a3f0f0b 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -728,7 +728,7 @@ _qgroup_mode()
 	if _has_fs_sysfs_attr $dev /qgroups/mode; then
 		_get_fs_sysfs_attr $dev qgroups/mode
 	else
-		echo "disabled"
+		echo "qgroup"
 	fi
 }
 
-- 
2.42.0


