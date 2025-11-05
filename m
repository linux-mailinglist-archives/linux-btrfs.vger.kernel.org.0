Return-Path: <linux-btrfs+bounces-18728-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0AFC35003
	for <lists+linux-btrfs@lfdr.de>; Wed, 05 Nov 2025 11:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56C74467336
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Nov 2025 09:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A251309EF3;
	Wed,  5 Nov 2025 09:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="p+vVBQfR";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="p+vVBQfR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AA2155CB3
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Nov 2025 09:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762336714; cv=none; b=Gq3RF+Ql4y+T4x/khB/K1jM8zpkZXT0t+d+TPCaNPW4noid8znWyLMHF0ULzwo+da3aykZrH3+alloH12inhk1kvywWH+KTC3zh1UCc+2F/j4O5Wrik8BeRkD4l+oHUKIyyBx6ivS4iwKOowlA08E+pg9+NLCyvLK39fg4DjADE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762336714; c=relaxed/simple;
	bh=pxsjKw2acJHv4LWvIEiH4dZYMoJeshBVxw5u5gtT0mU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=kCvBtnImEh7C0LOMpRfVBpKVPeeCf6rVV1i+D8Exq2ItoRtBuCEWR60Jij77LDMRFBiXDGWbGxzgx0DAvmsyJr2n3ku9ZA1OPQELIfERTME0R3enarXgnLQpF6HPcA72WmUnIRmzXdrdko/IJLFIAUPpyZjO833U5DTo4wZQRbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=p+vVBQfR; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=p+vVBQfR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B3387210EF
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Nov 2025 09:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1762336710; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=yvjLvhLYywnAC0VYYTfVlBOd0RIebULLOEE28stbfMc=;
	b=p+vVBQfRZCzZT49pd2Pfcjim2gNT69BuLhw2kTv4nv1U2bKUDY9mtbsNMea9CUIXqI6TYr
	WkDWeGCAcGE6q5sh55p3rcavgcT6K/11uT3eY7VBAjzPWs9bfnxAPJt1Dirrg7vW0+bPX2
	L5LOmspEJ3lJ+Uhgdv7kojOSkeVx8QI=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1762336710; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=yvjLvhLYywnAC0VYYTfVlBOd0RIebULLOEE28stbfMc=;
	b=p+vVBQfRZCzZT49pd2Pfcjim2gNT69BuLhw2kTv4nv1U2bKUDY9mtbsNMea9CUIXqI6TYr
	WkDWeGCAcGE6q5sh55p3rcavgcT6K/11uT3eY7VBAjzPWs9bfnxAPJt1Dirrg7vW0+bPX2
	L5LOmspEJ3lJ+Uhgdv7kojOSkeVx8QI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F183E13699
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Nov 2025 09:58:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rtloLMUfC2mhOQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 05 Nov 2025 09:58:29 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs: make sure extent and csum paths are always released in scrub_raid56_parity_stripe()
Date: Wed,  5 Nov 2025 20:28:12 +1030
Message-ID: <83ada67a04aee0542397e7442f6c6dd1d0719e60.1762336672.git.wqu@suse.com>
X-Mailer: git-send-email 2.51.2
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
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

Unlike queue_scrub_stripe() which uses the global sctx->extent_path and
sctx->csum_path which are always released at the end of scrub_stripe(),
scrub_raid56_parity_stripe() uses local extent_path and csum_path, as
that function is going to handle the full stripe, whose bytenr may be
smaller than the bytenr in the global sctx paths.

However the cleanup of local extent/csum paths are only happening after
we have successfully submitted an rbio.

There are several error routes that we didn't release those two paths:

- scrub_find_fill_first_stripe() errored out at csum tree search
  In that case extent_path is still valid, and that function itself will
  not release the extent_path passed in.
  And the function returns directly without releasing both paths.

- The full stripe is empty
- Some blocks failed to be recovered
- btrfs_map_block() failed
- raid56_parity_alloc_scrub_rbio() failed
  The function returns directly without releasing both paths.

Fix it by covering btrfs_release_path() calls inside the out: tag.

This is just a hot fix, in the long run we will go scoped based auto
freeing for both local paths.

Fixes: 1dc4888e725d ("btrfs: scrub: avoid unnecessary extent tree search preparing stripes")
Fixes: 3c771c194402 ("btrfs: scrub: avoid unnecessary csum tree search preparing stripes")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Fix the fixes: tag
---
 fs/btrfs/scrub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 92fcd138cd67..b6278406a103 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -2288,9 +2288,9 @@ static int scrub_raid56_parity_stripe(struct scrub_ctx *sctx,
 	bio_put(bio);
 	btrfs_bio_counter_dec(fs_info);
 
+out:
 	btrfs_release_path(&extent_path);
 	btrfs_release_path(&csum_path);
-out:
 	return ret;
 }
 
-- 
2.51.2


