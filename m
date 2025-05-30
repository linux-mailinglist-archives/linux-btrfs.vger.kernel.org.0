Return-Path: <linux-btrfs+bounces-14324-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C26AC9351
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 May 2025 18:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27B5A3A1716
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 May 2025 16:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33EDC1ADC97;
	Fri, 30 May 2025 16:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="coifWoeN";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="coifWoeN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FE01A23B5
	for <linux-btrfs@vger.kernel.org>; Fri, 30 May 2025 16:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748621861; cv=none; b=mI44LKp7GrEbcGtYfnux0NEWHujPMZVBM3uOqLujktw9fI19APA+fZrEA+soVWBmWNfddOg3ftwJcSxBjYW/8szWPfWNUNM5e8QXjUkVoI2Tg5k/2jHQS8XSi6/j3R1eVAODDw/K/pTEk+88aOXDVkAvPYFMmeFmcvue7RHXHcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748621861; c=relaxed/simple;
	bh=AboWx4dKuZZszSm7vyme8kJgRNUwlEMhZr4c4vWeE0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ucwRZ6MW2J3vkMABgSN1Woj7NGQe7mm+/dcPQJFazws4osj3E3DG9kcFQXSrrWhWscm1SRil4l1dYXVnAm3Plfd7TlXL4T+odpIA+viA56QeFTe1EB5uJRpWm3gu5Q4RgievvM/m0vxi2e0KtP/QKSxtQ/zPxTeF+OKjCC/5aQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=coifWoeN; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=coifWoeN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A0ABF21CCB;
	Fri, 30 May 2025 16:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748621857; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gm9OE+jjUX+AmsDEl4wfKTsgBF16MKB1H0QbmZpnG/g=;
	b=coifWoeNlDxgZID+WoMMBwUQDIXJ5syogCfWpxMrGby4jvd1nvSdxqEsUxj+hP7tz3fww2
	2FqN1NsvukoDNbbz423+LTp3C9geiYxoQDRczcFWgTGtZDQ5ZRr1CVhZIav1iGNr33boIC
	Xgm7WE1cLlzjm2dEo2nGdUO5YWlIueU=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748621857; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gm9OE+jjUX+AmsDEl4wfKTsgBF16MKB1H0QbmZpnG/g=;
	b=coifWoeNlDxgZID+WoMMBwUQDIXJ5syogCfWpxMrGby4jvd1nvSdxqEsUxj+hP7tz3fww2
	2FqN1NsvukoDNbbz423+LTp3C9geiYxoQDRczcFWgTGtZDQ5ZRr1CVhZIav1iGNr33boIC
	Xgm7WE1cLlzjm2dEo2nGdUO5YWlIueU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9A03C13889;
	Fri, 30 May 2025 16:17:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2IWYJSHaOWiUZwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Fri, 30 May 2025 16:17:37 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 06/22] btrfs: rename err to ret2 in btrfs_setsize()
Date: Fri, 30 May 2025 18:17:37 +0200
Message-ID: <cbeac21adb13710ca72cda01be01935936d70a9e.1748621715.git.dsterba@suse.com>
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
X-Spam-Flag: NO
X-Spam-Score: -6.80
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

Unify naming of return value to the preferred way.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/inode.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 7074f975c033..2af381f2f5ed 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5256,7 +5256,7 @@ static int btrfs_setsize(struct inode *inode, struct iattr *attr)
 
 		ret = btrfs_truncate(BTRFS_I(inode), newsize == oldsize);
 		if (ret && inode->i_nlink) {
-			int err;
+			int ret2;
 
 			/*
 			 * Truncate failed, so fix up the in-memory size. We
@@ -5264,9 +5264,9 @@ static int btrfs_setsize(struct inode *inode, struct iattr *attr)
 			 * wait for disk_i_size to be stable and then update the
 			 * in-memory size to match.
 			 */
-			err = btrfs_wait_ordered_range(BTRFS_I(inode), 0, (u64)-1);
-			if (err)
-				return err;
+			ret2 = btrfs_wait_ordered_range(BTRFS_I(inode), 0, (u64)-1);
+			if (ret2)
+				return ret2;
 			i_size_write(inode, BTRFS_I(inode)->disk_i_size);
 		}
 	}
-- 
2.47.1


