Return-Path: <linux-btrfs+bounces-14573-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C88E8AD24C8
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Jun 2025 19:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92F1016C44A
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Jun 2025 17:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D8F21CC57;
	Mon,  9 Jun 2025 17:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="EuSMOnDg";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="EuSMOnDg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A37921C19C
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Jun 2025 17:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749489015; cv=none; b=cfJ9JMg2m0bz8AZS8m+VGGZ4vLPOItQ35ybc3MNrfDkVhKtQkll2oIqYxJwx2Dd8X4WVouX9XjEHhBkq3EYnhzX4wAVwNQATDG0v4wWiW/ZJvsQyI/eIRRMTPKxFggN+sjpBkQiQeb7BCT1loG9XXUcyqNFZK++4Nzd4P3uJS/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749489015; c=relaxed/simple;
	bh=t+wNPOIB0NNRPEo1WjY9e6vnUYTtE4V4njfb8LpTz1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eEWQNWnZ4DEsgdXt7FVmdLsnLO4mNue3FNWJFXaGayUJuT9WSGVZoVAjf47KCbucaakKP+OVLczM0HOBJKyNF1YNxqJUA0OyC/ilEP0CxI+AlBvKNTWP49yXFKRRWFXa00SfXQ8AX+5qRE4bve6RqWvkl8CXeoIn1rGrnvdAkdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=EuSMOnDg; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=EuSMOnDg; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C08E621195;
	Mon,  9 Jun 2025 17:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749489004; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mAM8vNBxTIWQc0v1ER4EB0QsCAHm7f7p61mSDV+ITgk=;
	b=EuSMOnDgrbZawajGuYOM4hj4J6MoYIdHPwMa/v5wpBy8haPvqHpFS14HXkOTKBAIoUhnk6
	n+SkM5RklgASS7a8Nh7O1RsGVb9O8h5oBxSA707hYj5VrILJIr9/fXyn90Uhk8tpQvaUum
	WwAbTmONmcbaWxNghRidKCaRVBocI/8=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=EuSMOnDg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749489004; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mAM8vNBxTIWQc0v1ER4EB0QsCAHm7f7p61mSDV+ITgk=;
	b=EuSMOnDgrbZawajGuYOM4hj4J6MoYIdHPwMa/v5wpBy8haPvqHpFS14HXkOTKBAIoUhnk6
	n+SkM5RklgASS7a8Nh7O1RsGVb9O8h5oBxSA707hYj5VrILJIr9/fXyn90Uhk8tpQvaUum
	WwAbTmONmcbaWxNghRidKCaRVBocI/8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B8A5E137FE;
	Mon,  9 Jun 2025 17:10:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id F/YRLWwVR2i7HAAAD6G6ig
	(envelope-from <dsterba@suse.com>); Mon, 09 Jun 2025 17:10:04 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 10/11] btrfs: simplify debug print helpers without enabled printk
Date: Mon,  9 Jun 2025 19:09:30 +0200
Message-ID: <3c5d0b5a28295dcbefa2263a25e7c6a618baad2e.1749488829.git.dsterba@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1749488829.git.dsterba@suse.com>
References: <cover.1749488829.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: C08E621195
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.01
X-Spam-Level: 

The btrfs_debug() helpers depend on various config options. In case of
"no_printk" we don't need to define a special helper that in the end
does nothing but validates the parameters. As the default build config
is to validate the parameters we can simplify it to let the debug
helpers expand to nothing and remove btrfs_no_printk_in_rcu().

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/messages.h | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/messages.h b/fs/btrfs/messages.h
index 9b78600efe0eb1..cef7526236d989 100644
--- a/fs/btrfs/messages.h
+++ b/fs/btrfs/messages.h
@@ -74,10 +74,9 @@ void _btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fmt, ...);
 #define btrfs_debug_rl(fs_info, fmt, args...) \
 	btrfs_printk_rl_in_rcu(fs_info, KERN_DEBUG fmt, ##args)
 #else
-#define btrfs_debug(fs_info, fmt, args...) \
-	btrfs_no_printk_in_rcu(fs_info, KERN_DEBUG fmt, ##args)
-#define btrfs_debug_rl(fs_info, fmt, args...) \
-	btrfs_no_printk_in_rcu(fs_info, KERN_DEBUG fmt, ##args)
+/* When printk() is no_printk(), expand to nothing. */
+#define btrfs_debug(fs_info, fmt, args...)
+#define btrfs_debug_rl(fs_info, fmt, args...)
 #endif
 
 #define btrfs_printk_in_rcu(fs_info, fmt, args...)	\
@@ -87,13 +86,6 @@ do {							\
 	rcu_read_unlock();				\
 } while (0)
 
-#define btrfs_no_printk_in_rcu(fs_info, fmt, args...)	\
-do {							\
-	rcu_read_lock();				\
-	btrfs_no_printk(fs_info, fmt, ##args);		\
-	rcu_read_unlock();				\
-} while (0)
-
 #define btrfs_printk_ratelimited(fs_info, fmt, args...)		\
 do {								\
 	static DEFINE_RATELIMIT_STATE(_rs,			\
-- 
2.49.0


