Return-Path: <linux-btrfs+bounces-2629-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3A885F503
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Feb 2024 10:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AC5C1C20E91
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Feb 2024 09:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98FE38F8F;
	Thu, 22 Feb 2024 09:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="QzFke9kG";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="QzFke9kG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D08381A1;
	Thu, 22 Feb 2024 09:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708595494; cv=none; b=i937J3PoqGLBoA56MQsNCER3RR72ETbKgpZWqkPAC8nXw5/vOoveFXtxPnXS4gkAR1E1wOo5Go9aDzQs2VqLtwVHEHRDvc0+9+AnPPIFMoTUogW0yFTKU4hZ1zCxrDPOAPDjJWgDDBoVZ43uI/2xECArNSH8GlnqWzKbg5ZzVXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708595494; c=relaxed/simple;
	bh=3WONCnNWN9FRJjQj+9p32J5snbIKrp1z3T6eI6wv6j0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I4mwZLUUfsE2RUI3FYuGEvW98P9NSxK5/VWSmhrXIZPh3vWaH3y1tPEdxd/MLW9l8h1vgYUBYx3xVkIIa8q6r4xH3x6eBITHaQXY2PzRlqdTn7lvXMCtUvpEemJDHDbgTajLSVsI5nZztlyFC6Y6c57gJm92rrPMQCf1QldC/bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=QzFke9kG; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=QzFke9kG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4D168222AB;
	Thu, 22 Feb 2024 09:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708595490; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0UpGcDW7WT60+FpypPVhdOPN2sYsjG/UaW8e4cftZfA=;
	b=QzFke9kGd7lITrxJkKZ7LPkKO0jk+Dzn5hkQ+RabrFUvJ/vdyCquDOlw5rIRxmBvrxWXU7
	R0NE54g/K95mwwOadMFcv6PCT8FTrBjCaombRPi8JJA8B6DWTNYtE6E4RogkO7XzSEZcNW
	KFOulHqeAE31qIfhw1CdVo8uW1UTQGM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708595490; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0UpGcDW7WT60+FpypPVhdOPN2sYsjG/UaW8e4cftZfA=;
	b=QzFke9kGd7lITrxJkKZ7LPkKO0jk+Dzn5hkQ+RabrFUvJ/vdyCquDOlw5rIRxmBvrxWXU7
	R0NE54g/K95mwwOadMFcv6PCT8FTrBjCaombRPi8JJA8B6DWTNYtE6E4RogkO7XzSEZcNW
	KFOulHqeAE31qIfhw1CdVo8uW1UTQGM=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 4193C13A6B;
	Thu, 22 Feb 2024 09:51:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id hhK8DyIZ12UxJgAAn2gu4w
	(envelope-from <dsterba@suse.com>); Thu, 22 Feb 2024 09:51:30 +0000
From: David Sterba <dsterba@suse.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	David Sterba <dsterba@suse.com>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH] generic/733: disable for btrfs
Date: Thu, 22 Feb 2024 10:50:48 +0100
Message-ID: <20240222095048.14211-1-dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=QzFke9kG
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.03 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 TO_DN_SOME(0.00)[];
	 DWL_DNSWL_LOW(-1.00)[suse.com:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.52)[97.83%]
X-Spam-Score: -0.03
X-Rspamd-Queue-Id: 4D168222AB
X-Spam-Flag: NO

This tests if a clone source can be read but in btrfs there's an
exclusive lock and the test always fails. The functionality might be
implemented in btrfs in the future but for now disable the test.

CC: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 tests/generic/733 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/733 b/tests/generic/733
index d88d92a4705add..b26fa47dad776f 100755
--- a/tests/generic/733
+++ b/tests/generic/733
@@ -18,7 +18,7 @@ _begin_fstest auto clone punch
 . ./common/reflink
 
 # real QA test starts here
-_supported_fs generic
+_supported_fs generic ^btrfs
 _require_scratch_reflink
 _require_cp_reflink
 _require_xfs_io_command "fpunch"
-- 
2.42.1


