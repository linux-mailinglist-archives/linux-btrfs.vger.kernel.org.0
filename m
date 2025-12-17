Return-Path: <linux-btrfs+bounces-19824-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7913ACC680C
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Dec 2025 09:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 834153023D66
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Dec 2025 08:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C3733EB04;
	Wed, 17 Dec 2025 08:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GMq2Qtbq";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="U++wtK8z"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24F8339867
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Dec 2025 08:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765958925; cv=none; b=jCXpErBmHtsBGb1Bnx2Fg+Ld3f+bdI9V/U/39zJtO6ITxIpNNMu8EeQEs6lkihEhqdJNJMn+ubvHTdrQAx7/QkBhOyploqXqGFXw7QSQxWxxbTqYvMo20rs2uq+hD1ryOfu7jXUT3UkRE5/U5tpIXeDcc9umKiuoqF9/RM3JuBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765958925; c=relaxed/simple;
	bh=sVU+Yzug93zO8VGaGFcB0h/A9mmqcBLoUXvRKHCoGks=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UU3Dkg3ral7LssyK5jMXXTO+b+0f5UnvhA3r8KXQnxx8oTj5wIWYu8fRFq9cZOzxEkOoj5fqgMkjHLWOC7Xxq3BUV7XoheDhnbognhqx8Pj15lFJTTHTZZLyiSKXFbNpcpbAJnp4s+dVMoQTS1P+vStoS4NsQ6HMhlkS6ufTPEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=GMq2Qtbq; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=U++wtK8z; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 110C6336C7
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Dec 2025 08:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1765958904; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wx7OQ/oNTT4MOI1KpokKBjIzwKRskwH29SrldQCwatw=;
	b=GMq2Qtbqul9Q4N2xINpKif8U6GZdHa3ANRzFanYGVOq74vN2FB1UUAi2QpjD2uldruxJIE
	mUXTMCaRogL38bex8yBxW5rgXBc/GvjidgmdlZLlk7H/csLUrA0pCyVrsf9/tc3ScpRVR0
	FJ1lLJs0+nhqNLE5SdFwdiML81vD4p4=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1765958903; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wx7OQ/oNTT4MOI1KpokKBjIzwKRskwH29SrldQCwatw=;
	b=U++wtK8zMKdvybBVURfwSs7tk5n58m9RX4lNpNrCArTZ7JuQg+DVbSCs3tUojQXskgCVhj
	Rkn7p9QPWCxsWfy0V9MVeEj8CJRAv2Owvh/HijKdwzc2rDOwRgmXVWp0rl/aqHHh+TNmFh
	cGCKRsge1OmqHgweywj8z7vRnFZKOe0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 52E073EA65
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Dec 2025 08:08:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GMZhBvZkQmmoGQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Dec 2025 08:08:22 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs-progs: fsck-tests: add a test case for repairing missing INODE_REF
Date: Wed, 17 Dec 2025 18:38:15 +1030
Message-ID: <2174d23a6cf83e392fb64a1b9367da60ea1470fe.1765958753.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1765958753.git.wqu@suse.com>
References: <cover.1765958753.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.62 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	NEURAL_HAM_SHORT(-0.02)[-0.118];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.62

The image is created by removing the INODE_REF for inode 257.

Now both original and lowmem mode should be able to repair it.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 .../070-missing-inode-ref/.lowmem_repairable     |   0
 .../070-missing-inode-ref/default.img.xz         | Bin 0 -> 2092 bytes
 2 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 tests/fsck-tests/070-missing-inode-ref/.lowmem_repairable
 create mode 100644 tests/fsck-tests/070-missing-inode-ref/default.img.xz

diff --git a/tests/fsck-tests/070-missing-inode-ref/.lowmem_repairable b/tests/fsck-tests/070-missing-inode-ref/.lowmem_repairable
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/tests/fsck-tests/070-missing-inode-ref/default.img.xz b/tests/fsck-tests/070-missing-inode-ref/default.img.xz
new file mode 100644
index 0000000000000000000000000000000000000000..15d95eed391c14630d93be2bf3e665186f816259
GIT binary patch
literal 2092
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
V7#QB0-LcqsB>guNNR}ls3IGh@4rTxV

literal 0
HcmV?d00001

-- 
2.52.0


