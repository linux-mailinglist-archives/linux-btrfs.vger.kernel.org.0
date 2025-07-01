Return-Path: <linux-btrfs+bounces-15177-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 394D9AF01AF
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Jul 2025 19:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62BF552038E
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Jul 2025 17:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B806422B585;
	Tue,  1 Jul 2025 17:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WjEeWb0Q";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WjEeWb0Q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3814B27EFEE
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Jul 2025 17:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751390655; cv=none; b=mPhnFqdJ2Rii/Oqizu5XK13250643yG7Zz0yrzAgKN7M+i1JGN5C5tmussuYyoJPHbUFlydW+nc/e4BKEUurJK8FhwrVHAPxPuEhJEJD6Ad73JOp74IOtVoeOaj9KQsCDXVWkDk3zIYOT/pEMyT26I2tj2hpyKHnUUUfTqCb0kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751390655; c=relaxed/simple;
	bh=D/o/zpXMknZXeJw5Ng+HPDayfnR9hRIY6KOns1HFObg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bl7mvbMtbckm9HzPAlWw3f4co7gdN92gDTO36aEQK42LZj94x7yhgJJA+q1sa9djktw497O41UaH2r0HjxuXwm6dXIIOH9AhRpU5jNZWh3hs8fD5TOTwSPeFogRDcVaY7M2+ePFKdO24cmiUWjXzgXB0OG5ZUnQiDBy7U9QL3vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=WjEeWb0Q; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=WjEeWb0Q; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 203EC2117F;
	Tue,  1 Jul 2025 17:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751390650; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RgkS3uymLY6uguDDCDJ51LzbaYyFvpdKnvu0x3DN+sw=;
	b=WjEeWb0QBVXbOFI4WSOZDchG7FrJmDs+TGye5T1/i5Tt1R8DFLp/TLU+svTBHO79O4jUNX
	2n0ZWy4gOnQf+1L90Mt94pzRF9VZi5jN1ij9ZymhIUDG7SjIacas+6Z0BnHSWUFa6B2XJG
	kW5ygqJROJLgPcVxaOO7diy4WmQDgdg=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751390650; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RgkS3uymLY6uguDDCDJ51LzbaYyFvpdKnvu0x3DN+sw=;
	b=WjEeWb0QBVXbOFI4WSOZDchG7FrJmDs+TGye5T1/i5Tt1R8DFLp/TLU+svTBHO79O4jUNX
	2n0ZWy4gOnQf+1L90Mt94pzRF9VZi5jN1ij9ZymhIUDG7SjIacas+6Z0BnHSWUFa6B2XJG
	kW5ygqJROJLgPcVxaOO7diy4WmQDgdg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1955213890;
	Tue,  1 Jul 2025 17:24:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HVErBroZZGg/RgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 01 Jul 2025 17:24:10 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 4/7] btrfs: accessors: compile-time fast path for u8
Date: Tue,  1 Jul 2025 19:23:51 +0200
Message-ID: <b49e4c7288d3686261eef572d2adea0d8e6ca212.1751390044.git.dsterba@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1751390044.git.dsterba@suse.com>
References: <cover.1751390044.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.80

Reading/writing 1 byte (u8) is a special case compared to the others as
it's always contained in the folio we find, so the split memcpy will
never be needed. Turn it to a compile-time check that the memcpy part
can be optimized out.

The stack usage is reduced:

  btrfs_set_8                                         -16 (32 -> 16)
  btrfs_get_8                                         -16 (24 -> 8)

Code size reduction:

     text    data     bss     dec     hex filename
  1454951  115665   16088 1586704  183610 pre/btrfs.ko
  1454691  115665   16088 1586444  18350c post/btrfs.ko

  DELTA: -260

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/accessors.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/accessors.c b/fs/btrfs/accessors.c
index a7b6b2d7bde224..547e9f8fb87d61 100644
--- a/fs/btrfs/accessors.c
+++ b/fs/btrfs/accessors.c
@@ -55,7 +55,8 @@ u##bits btrfs_get_##bits(const struct extent_buffer *eb,		\
 		report_setget_bounds(eb, ptr, off, sizeof(u##bits));	\
 		return 0;						\
 	}								\
-	if (INLINE_EXTENT_BUFFER_PAGES == 1 || likely(sizeof(u##bits) <= part))	\
+	if (INLINE_EXTENT_BUFFER_PAGES == 1 || sizeof(u##bits) == 1 ||	\
+	    likely(sizeof(u##bits) <= part))				\
 		return get_unaligned_le##bits(kaddr + oil);		\
 									\
 	memcpy(lebytes, kaddr + oil, part);				\
@@ -78,7 +79,7 @@ void btrfs_set_##bits(const struct extent_buffer *eb, void *ptr,	\
 		report_setget_bounds(eb, ptr, off, sizeof(u##bits));	\
 		return;							\
 	}								\
-	if (INLINE_EXTENT_BUFFER_PAGES == 1 ||				\
+	if (INLINE_EXTENT_BUFFER_PAGES == 1 || sizeof(u##bits) == 1 ||	\
 	    likely(sizeof(u##bits) <= part)) {				\
 		put_unaligned_le##bits(val, kaddr + oil);		\
 		return;							\
-- 
2.49.0


