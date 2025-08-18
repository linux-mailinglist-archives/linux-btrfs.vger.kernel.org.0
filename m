Return-Path: <linux-btrfs+bounces-16118-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF54B295D6
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Aug 2025 02:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0681B3B9D7E
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Aug 2025 00:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCE7202987;
	Mon, 18 Aug 2025 00:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jVXsimy5";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jVXsimy5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C541531771A
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Aug 2025 00:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755477147; cv=none; b=EGlqJslbc3kO5obs8+Ib8etqnq7pb2oHpLFFf3soqjy5C0ZVItYXJOaYSXlTHAdz7mpJ6lNmTdySCpMqo7HhN6vUJRHLlINHHh95gbG+rCqFKhUuXUo0InYDuB/bCxc4xnut64W2I9tHt3t8utpDRKeCgqubZOg1DAYVpdiIe4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755477147; c=relaxed/simple;
	bh=96NqLDNfLKjUPRPjEhe0CHN8U9sLQFZQ8j7MQDgXlOE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DF7uCIt1DNBb7echgtbEoSXqWh3IVgTQVeIlq+2VbCTnxf+3OKFIFBWdTCnNqUOxmRLbsdT8PLXLGiNluJbjjxn1Sp1jir8xC+UsKa9y5u0vq11DL0tJtML1TkrGxshreskrr1gjhuGFbXaVwFH23oHz1FRXTokOWVAwF01yXBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jVXsimy5; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jVXsimy5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3CDA41F46E
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Aug 2025 00:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1755477132; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pnuvHRhKQKuMkIRvK3I/uVb3oDSl82CGiZAZ0SrZYUI=;
	b=jVXsimy5BMY4QzWTULEvc81lWEob7hOoehMdvrnOgkdzYtO4ak1PE8CLlbII9FHgyjK5FO
	Ai9sSFcC97jJWcpuGTcNvYdCqYCcE4owxdsZuYJ4K1+Rbvpxip+onhoer7D8nD+jCBpvIt
	jMQ0WQfuTYh2B4VyDJjG2NAUb1Qk5UM=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1755477132; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pnuvHRhKQKuMkIRvK3I/uVb3oDSl82CGiZAZ0SrZYUI=;
	b=jVXsimy5BMY4QzWTULEvc81lWEob7hOoehMdvrnOgkdzYtO4ak1PE8CLlbII9FHgyjK5FO
	Ai9sSFcC97jJWcpuGTcNvYdCqYCcE4owxdsZuYJ4K1+Rbvpxip+onhoer7D8nD+jCBpvIt
	jMQ0WQfuTYh2B4VyDJjG2NAUb1Qk5UM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7885D13686
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Aug 2025 00:32:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WKfiDot0omhWKgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Aug 2025 00:32:11 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 5/5] btrfs-progs: doc/mkfs: remove the note about memory usage
Date: Mon, 18 Aug 2025 10:01:47 +0930
Message-ID: <c5d36303c357e3782016094e8c223accfcc35e95.1755474438.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755474438.git.wqu@suse.com>
References: <cover.1755474438.git.wqu@suse.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
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

With the recent enhancements to --subvol and --inode-flags options, the
memory usage for them are just 4K+, and even for the older 8K+ memory
usage, it's really hard to consider them as heavy memory usage.

E.g. even if the end user specified over 1000 entries of
--subvol/--inode-flags, it only takes a little over 8MiB for the older
code or over 4MiB for the newer code.

Since we're in the user space and the year is 2025 not 1995, such memory
usage is far from heavy.

Just remove the paranoid note from the man page.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 Documentation/mkfs.btrfs.rst | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/Documentation/mkfs.btrfs.rst b/Documentation/mkfs.btrfs.rst
index 82837e429778..940bf3a09b6e 100644
--- a/Documentation/mkfs.btrfs.rst
+++ b/Documentation/mkfs.btrfs.rst
@@ -243,11 +243,6 @@ OPTIONS
 	each subvolume is independent and will not inherit from the parent directory.
 	(The same as the kernel behavior.)
 
-        .. note::
-                Both *--inode-flags* and *--subvol* options are memory hungry,
-                will consume at least 8KiB for each option.  Please keep the
-                usage of both options to minimum.
-
 --shrink
         Shrink the filesystem to its minimal size, only works with *--rootdir* option.
 
-- 
2.50.1


