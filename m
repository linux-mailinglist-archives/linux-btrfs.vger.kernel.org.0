Return-Path: <linux-btrfs+bounces-14338-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4C2AC9364
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 May 2025 18:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63DA35068E0
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 May 2025 16:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E717522D7BF;
	Fri, 30 May 2025 16:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="hg7guBtz";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="hg7guBtz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BF91A23B5
	for <linux-btrfs@vger.kernel.org>; Fri, 30 May 2025 16:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748621953; cv=none; b=bo6lfQmBbLGlPhgTyqBr9vptd9aXbR36S+mHOHP9e+f37XY+w2xDrGqc702+SoPDPTZ69tjbSlfKG8tFT/2yFW2HzKSW02xRhxOyJFiBi7RXdPKrchGY9dPL40ubNV7SwKaawzIsrtwuZoPWi7mzbdtG0UNERbIGYvTn9ak5VIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748621953; c=relaxed/simple;
	bh=Q91G9s8PHrKXSADFwx1K4WGHb9Ebu2d1LnJ13fkgEbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QppenYZtb20lTkYBzFYBtkXwppNy1BpvhoNInZDopu5mwn+EvAAcc01st8SJJH6AKgvc7hrPidjLKP7O9L7y7FanrFttVva7ey5x10fiSpvHZuE5PQuBIxXZQd43ADl7NnDA1SbWMJD7Fge1hQoys3LNPh08d7cjmdaAz/dfUo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=hg7guBtz; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=hg7guBtz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 26D6021A4F;
	Fri, 30 May 2025 16:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748621933; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NfI8RxJOy3EAyIvGmf6c36mKfEQaidClCmDP5gmEj/o=;
	b=hg7guBtz3S8UOaW2RzgTsAoRb54tlb4PhWCGFqEXkP+SyZqD7L98rkW32HMXKoRD2RC6Bo
	D+fVHgzst/SA17jdhEfx3AR2r8jKiGsiJk6FqChxo+0XsTGPSEgjfLLuungQ8hAPuVMs/5
	glugrhpX8oa7/eYjvz7PuXW/ZObVzM4=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748621933; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NfI8RxJOy3EAyIvGmf6c36mKfEQaidClCmDP5gmEj/o=;
	b=hg7guBtz3S8UOaW2RzgTsAoRb54tlb4PhWCGFqEXkP+SyZqD7L98rkW32HMXKoRD2RC6Bo
	D+fVHgzst/SA17jdhEfx3AR2r8jKiGsiJk6FqChxo+0XsTGPSEgjfLLuungQ8hAPuVMs/5
	glugrhpX8oa7/eYjvz7PuXW/ZObVzM4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1E42413889;
	Fri, 30 May 2025 16:18:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id X7RgB23aOWgDaAAAD6G6ig
	(envelope-from <dsterba@suse.com>); Fri, 30 May 2025 16:18:53 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 18/22] btrfs: rename err to ret in quota_override_store()
Date: Fri, 30 May 2025 18:18:48 +0200
Message-ID: <210e3b68358ff8824e5a7ba37b8b3542ec623a43.1748621715.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1748621715.git.dsterba@suse.com>
References: <cover.1748621715.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -6.80

Unify naming of return value to the preferred way.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/sysfs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 04715201c643..b860470cffc4 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1210,7 +1210,7 @@ static ssize_t quota_override_store(struct kobject *kobj,
 {
 	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
 	unsigned long knob;
-	int err;
+	int ret;
 
 	if (!fs_info)
 		return -EPERM;
@@ -1218,9 +1218,9 @@ static ssize_t quota_override_store(struct kobject *kobj,
 	if (!capable(CAP_SYS_RESOURCE))
 		return -EPERM;
 
-	err = kstrtoul(buf, 10, &knob);
-	if (err)
-		return err;
+	ret = kstrtoul(buf, 10, &knob);
+	if (ret)
+		return ret;
 	if (knob > 1)
 		return -EINVAL;
 
-- 
2.47.1


