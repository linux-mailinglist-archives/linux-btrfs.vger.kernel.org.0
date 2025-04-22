Return-Path: <linux-btrfs+bounces-13246-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C95A97115
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Apr 2025 17:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1174C3AE244
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Apr 2025 15:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3FD253F1F;
	Tue, 22 Apr 2025 15:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="CXz2boSn";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="CXz2boSn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF29328F928
	for <linux-btrfs@vger.kernel.org>; Tue, 22 Apr 2025 15:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745335946; cv=none; b=ZQeEjt/P03CWRmII/+jprLz89pYZqVh5XFCnzGG7iSrKz5e65T3JXfOGbl0aNF5LyPuUpnqVTBqCDbm9ZKRoDPIGEPVsJtORmg3BF579XRA0r2kPlh3yplEC6wceren6hkuCW2vdg4D+vBhzcUZvhfpKIkj6Yfhb9od2vv6mPJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745335946; c=relaxed/simple;
	bh=QYzuJNjKtc2ozfuStdBSyJhApTX0W4zhSB0TsNQOlaM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h8xA/l3E7UELDLZtd3sjtgXIjE0iGXzOP/CvdTmFF2oMaWbfSvMbHWWlzs8O1X3ocIXzxVawhni6MSfeGiph/wxxONMfKFVlfk9R8hUKnsLngLOEvzYgj982SCbYYjVAqg0dmljt29x7eTePi0/j+JcisHBooDoR8aEhEqi0As4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=CXz2boSn; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=CXz2boSn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CF87621171;
	Tue, 22 Apr 2025 15:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745335942; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=q961XA6JUZSkA9YYhFhieYWZp0MCB4zIFCB0B7q2dJ4=;
	b=CXz2boSnUJt2dEHAqSgHpdX0Zoayq20R714OEp5uji9I4gDtNyWoZKxaWEu574QsTLrFHQ
	52OPX+//vQY7tKOl9YDWY+hRvrNbaKc3u8sgCPgpUvWT4o5XdNdtLcTDs5o/n7SrvcNixD
	7eMHU+jbvy935UhjGWbDYpPH/Fj5yfU=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745335942; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=q961XA6JUZSkA9YYhFhieYWZp0MCB4zIFCB0B7q2dJ4=;
	b=CXz2boSnUJt2dEHAqSgHpdX0Zoayq20R714OEp5uji9I4gDtNyWoZKxaWEu574QsTLrFHQ
	52OPX+//vQY7tKOl9YDWY+hRvrNbaKc3u8sgCPgpUvWT4o5XdNdtLcTDs5o/n7SrvcNixD
	7eMHU+jbvy935UhjGWbDYpPH/Fj5yfU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C8D90139D5;
	Tue, 22 Apr 2025 15:32:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RtUCMYa2B2igYAAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 22 Apr 2025 15:32:22 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: remove unused btrfs_io_stripe::length
Date: Tue, 22 Apr 2025 17:32:17 +0200
Message-ID: <20250422153217.256995-1-dsterba@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid]
X-Spam-Score: -2.80
X-Spam-Flag: NO

First added (but not effectively used) in 02c372e1f016e5 ("btrfs: add
support for inserting raid stripe extents"). The structure is
initialized to zeros so the only use in btrfs_insert_one_raid_extent()

    u64 length = bioc->stripes[i].length;
    struct btrfs_raid_stride *raid_stride = &stripe_extent->strides[i];

    if (length == 0)
            length = bioc->size;

the 'if' always happens.

Last use in 4016358e852861 ("btrfs: remove unused variable length in
btrfs_insert_one_raid_extent()") was an obvious cleanup. It seems to be
safe to remove, raid-stripe-tree works without using it since 6.6.

This was found by tool https://github.com/jirislaby/clang-struct .

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/volumes.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 0e793b9776d677..d06d2d8713f87f 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -473,7 +473,6 @@ struct btrfs_io_stripe {
 	struct btrfs_device *dev;
 	/* Block mapping. */
 	u64 physical;
-	u64 length;
 	bool rst_search_commit_root;
 	/* For the endio handler. */
 	struct btrfs_io_context *bioc;
-- 
2.49.0


