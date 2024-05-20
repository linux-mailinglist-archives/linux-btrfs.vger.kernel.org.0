Return-Path: <linux-btrfs+bounces-5125-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3119D8CA2F1
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2024 21:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0BF52818A5
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2024 19:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1495113958F;
	Mon, 20 May 2024 19:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Xl4MHfK0";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Xl4MHfK0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC8213959A
	for <linux-btrfs@vger.kernel.org>; Mon, 20 May 2024 19:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716234755; cv=none; b=CiD1mrVoMgFkJrSJbq3WdTCMiHX17fVC4H/dupDxLqdxQ1pUitncr0xDw5GkAzgcYx9KpUY7Y1neWDnIBPsEvKmtSnT/gW2nrPkw0qvngsFiVrEr6AHyqqKvIhZeXIijTLHpLzTgDXkNCbOFDbH9bv9ek2zB7R3P2JEMBQsc2lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716234755; c=relaxed/simple;
	bh=3CbtMFG8UKPv9qcUoxa5/zyAdOP5eR4BwLuN9ketx/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GVojWXGYbLJ0i9xZ4+KPJJrlRiont7p2EPZ/AE/ZnTXlRqugDYhc9bj2vYuL3es6eLpxax7lcVsTlr3PN8+EDazhA9inydYHswxNU/FXuwIWjSrU0ZGxoCzAOrBaFHs6O3Yl58OHErZPOgkp1B7U7XhE1LlNpwYSrRer7ikpPMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Xl4MHfK0; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Xl4MHfK0; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C13A333EBC;
	Mon, 20 May 2024 19:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716234751; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nN/qs9Htj9M1VLA7B8Z5NIk7aTokDugMz3h4Lw+iE5I=;
	b=Xl4MHfK06prdYVEuvQUXLj/TouU5unRSHcGtkAUjrjkb9bwrfUFeDFFT443TEhTog3XMhm
	8deNTRuZHqlDK/G6X2sfRei2cPZgKJ6GawrSgCjWDrU6T1TranQCAaLY5MkfbwsQTrD+06
	i4eGaYw39zA+2qEVCi0/cZ9uYi/3Yr0=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716234751; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nN/qs9Htj9M1VLA7B8Z5NIk7aTokDugMz3h4Lw+iE5I=;
	b=Xl4MHfK06prdYVEuvQUXLj/TouU5unRSHcGtkAUjrjkb9bwrfUFeDFFT443TEhTog3XMhm
	8deNTRuZHqlDK/G6X2sfRei2cPZgKJ6GawrSgCjWDrU6T1TranQCAaLY5MkfbwsQTrD+06
	i4eGaYw39zA+2qEVCi0/cZ9uYi/3Yr0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BBA1513A6B;
	Mon, 20 May 2024 19:52:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MV7MLf+pS2ZgRwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Mon, 20 May 2024 19:52:31 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 5/6] btrfs: keep const whene returnin value from get_unaligned_le8()
Date: Mon, 20 May 2024 21:52:31 +0200
Message-ID: <d5e88373ee6f83658af337d84f29886c8c72ab70.1716234472.git.dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1716234472.git.dsterba@suse.com>
References: <cover.1716234472.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-0.48 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	BAYES_HAM(-0.68)[83.07%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -0.48
X-Spam-Flag: NO

This was reported by -Wcast-qual, the get_unaligned_le8() simply returns
the arugment and there's no reason to drop the cast.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/accessors.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/accessors.h b/fs/btrfs/accessors.h
index 6fce3e8d3dac..c60f0e7f768a 100644
--- a/fs/btrfs/accessors.h
+++ b/fs/btrfs/accessors.h
@@ -34,7 +34,7 @@ void btrfs_init_map_token(struct btrfs_map_token *token, struct extent_buffer *e
 
 static inline u8 get_unaligned_le8(const void *p)
 {
-       return *(u8 *)p;
+       return *(const u8 *)p;
 }
 
 static inline void put_unaligned_le8(u8 val, void *p)
-- 
2.45.0


