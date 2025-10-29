Return-Path: <linux-btrfs+bounces-18407-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DB9C1D90E
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Oct 2025 23:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 81D474E2EB2
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Oct 2025 22:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DC43148C1;
	Wed, 29 Oct 2025 22:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ILHVb4wi";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ILHVb4wi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBE03148AC
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Oct 2025 22:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761775700; cv=none; b=Hj+ewShAbQFBMRtstAJv7XUwTQ//cCrHljBOci8OvCjy0NffmXM9HxWoJIfP7YOUe5iiTXBwMhIyolm8ssh4xgRRczuZaPvCyR8I4WqKOIJUK82ACpbS3DmGrIhe+hExMxiWnEurYTy05elLzfeC2DlsncSECqberdWagxAaEUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761775700; c=relaxed/simple;
	bh=0LP8vjYOaRyCLWzl+XJuAP5+050PZ8TPZpiFBCZR0UQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=WO1ehUMu55LwA22zi/y6tNMByMN5BDJSTEEJgvmJuRzaj7hkpohgBBEsnLdUKWNAbC5n4moPrkg5muoAW/12lPXQIWLi8U7jrpcyJRh8vVEoq68gk3MSObmTY924WzMGiZEpbBjFIMy7bgcHZCmWDKXz+vqH8fJsm73bQv10AfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ILHVb4wi; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ILHVb4wi; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 596015CA74
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Oct 2025 22:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1761775696; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=/N2JuqZDAqRxo2HH18G6EoVSttDJ/asaJC/rU48dxY0=;
	b=ILHVb4wioiapM2UdsgyphRE5ScF+7d1CCqn6ifK+IMLLG4lNriuY+G5kHx3GqEimGkPD9a
	0MsLbvEJ9FWuAeNRVLfChd49Lpz1mTlBVoZvEXptm/ltnQHC31aQz2DxluKGjPhdieyv0+
	Oys4Q3UIvSle4YsvMilIfOw5qdbq9/M=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1761775696; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=/N2JuqZDAqRxo2HH18G6EoVSttDJ/asaJC/rU48dxY0=;
	b=ILHVb4wioiapM2UdsgyphRE5ScF+7d1CCqn6ifK+IMLLG4lNriuY+G5kHx3GqEimGkPD9a
	0MsLbvEJ9FWuAeNRVLfChd49Lpz1mTlBVoZvEXptm/ltnQHC31aQz2DxluKGjPhdieyv0+
	Oys4Q3UIvSle4YsvMilIfOw5qdbq9/M=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 947881349D
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Oct 2025 22:08:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0vt0FU+QAmkncQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Oct 2025 22:08:15 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: docs: add notes about interruption to scrub/dev-replace
Date: Thu, 30 Oct 2025 08:37:57 +1030
Message-ID: <f2e576ef61711fa84aeeee337cba5e54e0829c29.1761775676.git.wqu@suse.com>
X-Mailer: git-send-email 2.51.0
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
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_ONE(0.00)[1];
	URIBL_BLOCKED(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -2.80

Since the kernel patch is queued for v6.19, add notes to scrub and
dev-replace about the new behavior change.

For scrub it's not a huge deal as we can just resume using 'btrfs scrub
resume' command.
But for dev-replace one has to start from the beginning, thus it's
recommended to disable pm during dev-replace.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 Documentation/btrfs-replace.rst  | 12 ++++++++++++
 Documentation/ch-scrub-intro.rst |  8 ++++++++
 2 files changed, 20 insertions(+)

diff --git a/Documentation/btrfs-replace.rst b/Documentation/btrfs-replace.rst
index c63f1dfaaab1..8559d3e6c1a4 100644
--- a/Documentation/btrfs-replace.rst
+++ b/Documentation/btrfs-replace.rst
@@ -37,6 +37,18 @@ start [options] <srcdev>|<devid> <targetdev> <path>
                 larger target device; this can be achieved with
                 ``btrfs filesystem resize <devid>:max /path``
 
+	.. note::
+		Device replace can be interrupted by various events after v6.19 kernel,
+		including but not limited to power management suspension/hibernation,
+		filesystem freezing, cgroup freezing (utilized by systemd for slice freezing)
+		and pending signals.
+
+		The running device replace will be aborted after such interruption, and
+		the end user needs to restart the device replace from the beginning.
+
+		Thus it's recommended to disable suspension/hiberation before executing the
+		device replace operation.
+
         ``Options``
 
         -r
diff --git a/Documentation/ch-scrub-intro.rst b/Documentation/ch-scrub-intro.rst
index c688cfeacc51..4ef77394d428 100644
--- a/Documentation/ch-scrub-intro.rst
+++ b/Documentation/ch-scrub-intro.rst
@@ -56,6 +56,14 @@ read-write mounted filesystem.
    To avoid any writes from scrub, one has to run read-only scrub on read-only
    filesystem.
 
+.. note::
+   Scrub can be interrupted by various events after v6.19 kernel, including
+   but not limited to power management suspension/hibernation, filesystem freezing,
+   cgroup freezing (utilized by systemd for slice freezing) and pending signals.
+
+   The running scrub will be aborted after such interruption, and can be resumed
+   by `btrfs scrub resume` command.
+
 The user is supposed to run it manually or via a periodic system service. The
 recommended period is a month but it could be less. The estimated device bandwidth
 utilization is about 80% on an idle filesystem.
-- 
2.51.0


