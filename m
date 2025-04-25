Return-Path: <linux-btrfs+bounces-13420-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B44BAA9CA22
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Apr 2025 15:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0FCD1BA19E7
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Apr 2025 13:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2692D24E4DD;
	Fri, 25 Apr 2025 13:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0TACscoj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="++HHT8H0";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rpy+zGx+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0aBYiO3w"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9674678F2D
	for <linux-btrfs@vger.kernel.org>; Fri, 25 Apr 2025 13:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745587512; cv=none; b=tzQ9/jYs0vcpZx5XUh5yDDCeFQR/t84Z76beRnkAqhdlUP4nRIu3x/Kjegca5mTe1PjuFsUIAc9BSo/Cc9HbJwXSLxkKgj+FqGtMzh9if4yHnQPPRi+Yzvf7gpRyfezTVw+xriidi521wTj0vn3U5L0N18UZuK2UJCKa2AIhl2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745587512; c=relaxed/simple;
	bh=AHY1afDRMiQMGSHDeDL2aVizBRdVCHQwscWI+kfKYsQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=i2ukEWj/h5ZZlLeA1U0M3I5mUY43lnH5a3SPtQyc34nKrQr9VG33H/xX5VukALDPxuUgZxGpnOV3wkepgC+Ibho8EPS9ILaSxIn8sEzl2xmWCQa617HmuzkHxb+zpQLccjVEGhzuuFTHoDapJC93RYcX123mJXxxG75e3jMwmls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0TACscoj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=++HHT8H0; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rpy+zGx+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0aBYiO3w; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A0D1F1F394
	for <linux-btrfs@vger.kernel.org>; Fri, 25 Apr 2025 13:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745587508; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=Uzic46MJmwmX4XoR4BFsOACwBWuqspICaYUFrZXe+gI=;
	b=0TACscojYPb840xm7wrZ0cBeq+/S/W67p1iwv1d053cvGjxqX4wBwnnhdmC5Dh3R+uhtyg
	TGrfu3eIGo5mWUKrrvHl/eti1SeBUwJP4KD+GmKuvuWxkDYJwnA6K/bQckGkSWUsUyNM4j
	AaZmarUGdqGkMiUQuJGJMxLZdOGEOlo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745587508;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=Uzic46MJmwmX4XoR4BFsOACwBWuqspICaYUFrZXe+gI=;
	b=++HHT8H0OxqsDG2FBFQgpweZCqXgHSQxjEWCt8n0+YigMusFrUv9OROgGDtB03AFhPJLVm
	cZ1BKU5d1JbPOXAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=rpy+zGx+;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=0aBYiO3w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745587507; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=Uzic46MJmwmX4XoR4BFsOACwBWuqspICaYUFrZXe+gI=;
	b=rpy+zGx+K7VmjFjJZ1NxQmk9r4/rYqa3WpKwYrYfHJrouE5RczzUEIdelgyPx7MmmX44Kt
	OTHM7hqkRErvBqYkyh0KuOORwOftb6CzUQKSyHXRP/cfjOmqOiHl18c31KMengmsB3OGbO
	WovTe6TpV7b+diMItrttAXAxRG53LRI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745587507;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=Uzic46MJmwmX4XoR4BFsOACwBWuqspICaYUFrZXe+gI=;
	b=0aBYiO3w+sqOaz9STyFBfILljasOvyhr7DrLfSovcZEkPkpJl1aHEDn1uferAjDkkz2t4Z
	RB9OtZwnAevyffDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6740C1388F
	for <linux-btrfs@vger.kernel.org>; Fri, 25 Apr 2025 13:25:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id e0cZEzONC2hGUwAAD6G6ig
	(envelope-from <rgoldwyn@suse.de>)
	for <linux-btrfs@vger.kernel.org>; Fri, 25 Apr 2025 13:25:07 +0000
Date: Fri, 25 Apr 2025 09:25:06 -0400
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: correct the order of prelim_ref arguments in
 btrfs__prelim_ref
Message-ID: <xkizy4mfcknvikvddixci24oplxxnmu2enwx6sbxqqa4czrzzy@omjt5fi4rmym>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Queue-Id: A0D1F1F394
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.de:dkim,qemu.org:url]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

btrfs_prelim_ref() calls the old and new reference variables in the
incorrect order. This causes a NULL pointer dereference because oldref
is passed as NULL to trace_btrfs_prelim_ref_insert(). 

Note, trace_btrfs_prelim_ref_insert() is being called with newref as
oldref (and oldref as NULL) on purpose in order to print out
the values of newref.

To reproduce:
echo 1 > /sys/kernel/debug/tracing/events/btrfs/btrfs_prelim_ref_insert/enable

Perform some writeback operations.

Backtrace:
BUG: kernel NULL pointer dereference, address: 0000000000000018
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 115949067 P4D 115949067 PUD 11594a067 PMD 0 
 Oops: Oops: 0000 [#1] SMP NOPTI
 CPU: 1 UID: 0 PID: 1188 Comm: fsstress Not tainted 6.15.0-rc2-tester+ #47 PREEMPT(voluntary)  7ca2cef72d5e9c600f0c7718adb6462de8149622
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-2-gc13ff2cd-prebuilt.qemu.org 04/01/2014
 RIP: 0010:trace_event_raw_event_btrfs__prelim_ref+0x72/0x130
 Code: e8 43 81 9f ff 48 85 c0 74 78 4d 85 e4 0f 84 8f 00 00 00 49 8b 94 24 c0 06 00 00 48 8b 0a 48 89 48 08 48 8b 52 08 48 89 50 10 <49> 8b 55 18 48 89 50 18 49 8b 55 20 48 89 50 20 41 0f b6 55 28 88
 RSP: 0018:ffffce44820077a0 EFLAGS: 00010286
 RAX: ffff8c6b403f9014 RBX: ffff8c6b55825730 RCX: 304994edf9cf506b
 RDX: d8b11eb7f0fdb699 RSI: ffff8c6b403f9010 RDI: ffff8c6b403f9010
 RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000010
 R10: 00000000ffffffff R11: 0000000000000000 R12: ffff8c6b4e8fb000
 R13: 0000000000000000 R14: ffffce44820077a8 R15: ffff8c6b4abd1540
 FS:  00007f4dc6813740(0000) GS:ffff8c6c1d378000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000018 CR3: 000000010eb42000 CR4: 0000000000750ef0
 PKRU: 55555554
 Call Trace:
  <TASK>
  prelim_ref_insert+0x1c1/0x270
  find_parent_nodes+0x12a6/0x1ee0
  ? __entry_text_end+0x101f06/0x101f09
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? srso_alias_return_thunk+0x5/0xfbef5
  btrfs_is_data_extent_shared+0x167/0x640
  ? fiemap_process_hole+0xd0/0x2c0
  extent_fiemap+0xa5c/0xbc0
  ? __entry_text_end+0x101f05/0x101f09
  btrfs_fiemap+0x7e/0xd0
  do_vfs_ioctl+0x425/0x9d0
  __x64_sys_ioctl+0x75/0xc0

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index 848485d16587..bebc252db865 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -1923,7 +1923,7 @@ DECLARE_EVENT_CLASS(btrfs__prelim_ref,
 	TP_PROTO(const struct btrfs_fs_info *fs_info,
 		 const struct prelim_ref *oldref,
 		 const struct prelim_ref *newref, u64 tree_size),
-	TP_ARGS(fs_info, newref, oldref, tree_size),
+	TP_ARGS(fs_info, oldref, newref, tree_size),
 
 	TP_STRUCT__entry_btrfs(
 		__field(	u64,  root_id		)

-- 
Goldwyn

