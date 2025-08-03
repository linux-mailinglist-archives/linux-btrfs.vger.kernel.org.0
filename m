Return-Path: <linux-btrfs+bounces-15821-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA030B196DF
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Aug 2025 01:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C2273B5705
	for <lists+linux-btrfs@lfdr.de>; Sun,  3 Aug 2025 23:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA54218AA0;
	Sun,  3 Aug 2025 23:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="SElDIMra";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="SElDIMra"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F02205513
	for <linux-btrfs@vger.kernel.org>; Sun,  3 Aug 2025 23:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754265188; cv=none; b=h/jSBK+uz/0T5XklvJ41OcaCwAyGQPffC57h+6Xi+VEHHFRTOMV7ZiZl7/CIo8C66J3PpwzPWhwEwJmvZKpmX1cdtx6t3exWG5e6hmbp38me6AmQLn50/13Ixh4hwGAlQV1JqJ3213b6/ztNQUkT8h4pvkWXgkbItLGEqFbc1lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754265188; c=relaxed/simple;
	bh=Esl8VGxziByoucXns+t62lrnLST7/cC/8hlB3I9uiFY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R0z1A9nPjnW+xiC7hvoueb9sylaoYNOCkxk5kqcXlGKJMq83pz+xP1yv1H80oc0iJh2Dq/MidzHGw2myLQ4wQInkgEiGBvky31tEqPsTWbs2UsKkfOuHf0OZavmN+LWhedRQXiWtjFRDSXSskoArkatq6K0wUeBb2r4AncJyvXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=SElDIMra; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=SElDIMra; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 16A441F38C
	for <linux-btrfs@vger.kernel.org>; Sun,  3 Aug 2025 23:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1754265178; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=15DXN3ICkZFIIxOjyVnKj1oVGjWOBRwW8oSx5yQN4Xk=;
	b=SElDIMra99DLRf1x0TwlVX6AWAexwReRXT5kdqX5PA99WLPKwkADhy0pRx+23NiBWCnmyu
	RDgqo8E/d2+IX2f6FscTgqxz4f2RXxnSVODUCl/jvJ6Oc5CCNwgdZC5t77bSiiF5wk+7XO
	L5npJD6cVO+vcGBIVCqrpFYe7yzkyhg=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1754265178; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=15DXN3ICkZFIIxOjyVnKj1oVGjWOBRwW8oSx5yQN4Xk=;
	b=SElDIMra99DLRf1x0TwlVX6AWAexwReRXT5kdqX5PA99WLPKwkADhy0pRx+23NiBWCnmyu
	RDgqo8E/d2+IX2f6FscTgqxz4f2RXxnSVODUCl/jvJ6Oc5CCNwgdZC5t77bSiiF5wk+7XO
	L5npJD6cVO+vcGBIVCqrpFYe7yzkyhg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4D05213974
	for <linux-btrfs@vger.kernel.org>; Sun,  3 Aug 2025 23:52:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UJvFA1n2j2hPZAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sun, 03 Aug 2025 23:52:57 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs-progs: docs/seed: update a note related to orphan roots cleanup
Date: Mon,  4 Aug 2025 09:22:36 +0930
Message-ID: <f5fe490f6c9958886f87c3bf33e82ea885c0e703.1754265134.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1754265134.git.wqu@suse.com>
References: <cover.1754265134.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80

There is a note about a bug that mount a fs RO first, then remount it
RW, will make btrfs to skip the orphan roots cleanup.

However it's no longer the case after kernel commit 44c0ca211a4d
("btrfs: lift read-write mount setup from mount and remount"), as that
commit unify the pre-RW mount checks, and will always do the orphan
roots cleanup.

Just update the note so that it won't cause any confusion.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 Documentation/ch-seeding-device.rst | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/ch-seeding-device.rst b/Documentation/ch-seeding-device.rst
index e04dd28d9ff8..8ca55dacd6a5 100644
--- a/Documentation/ch-seeding-device.rst
+++ b/Documentation/ch-seeding-device.rst
@@ -26,11 +26,13 @@ filesystem at :file:`/path` ready for use.
 
 .. note::
 
-        There is a known bug with using remount to make the mount writeable:
+        There was a known bug with using remount to make the mount writeable:
         remount will leave the filesystem in a state where it is unable to
         clean deleted snapshots, so it will leak space until it is unmounted
         and mounted properly.
 
+	That bug is fixed in v5.11 and newer kernels.
+
 Furthermore, deleting the seeding device from the filesystem can turn it into
 a normal filesystem, provided that the writable device can also contain all the
 data from the seeding device.
-- 
2.50.1


