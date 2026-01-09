Return-Path: <linux-btrfs+bounces-20342-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F78D0B939
	for <lists+linux-btrfs@lfdr.de>; Fri, 09 Jan 2026 18:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 74600301D495
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jan 2026 17:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BBFB3382C7;
	Fri,  9 Jan 2026 17:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="iNPEi2Sm";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="b7WUTUIa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7910154BE2
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Jan 2026 17:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767979068; cv=none; b=AloA6IbsTogdlAaILLrWgJ0URlUUZGJcYPmfqHkgVOpYJKBqUslhaR6Y9ANs5+88tqDe5YV3YIKmOfK7jjUl5m4Whj5o8CGOd+cbv3nPsvUa2Mwi9TkIAHDz9SivOwEtSrveW/CB6JFnn0puWcfUiNY1n8f8ryAUMpSqBUP7Syc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767979068; c=relaxed/simple;
	bh=g4ycIn6tojCTkxBzpH1B2JtfJNBoIB8vxr7lqNeYhm4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=st+eo7qI9VTYz1jExtoxdjmYZSwGylDVKrZlqhowTE8WZlUETi35uBv575jZ6ewqy3wFGgpCVbqXl2/Wbj/gF75SrmvvwWH/HVnF7QfnSVsQLAIJbDqlA+oy/KDECo63FJPUXK88pbyiHIDhEd/5/O/WcZ1uFy/FS7hXsblWJTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=iNPEi2Sm; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=b7WUTUIa; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D452C5BFA7;
	Fri,  9 Jan 2026 17:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1767979065; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=xi518uvyocmXJRbMxJ67tlAqE4DQEEJZ1PcMXVOVGj8=;
	b=iNPEi2SmT9EsV1eR3XiG1I7+H2ytQA7/yuWrjwTpBchzoVkdAf/M/WzGPbyRTIZHzgZTsn
	Mga1+vl3+l2PjSITwJpmndPaXvOFvVsxU15V2cmCebZfBoEhB/YvxqvSOndSDl2EwfZo0p
	s65J6+od/Ig/b37of3t7sMMP6IXTKZY=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=b7WUTUIa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1767979064; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=xi518uvyocmXJRbMxJ67tlAqE4DQEEJZ1PcMXVOVGj8=;
	b=b7WUTUIazbDgdFdxjTPrcik7xy6tAJjrBig9lQSOD+31ibwVSlB8JNPuaT42aV2s4V+TQg
	Mk01zMZrxlGHKf9EcW0FJNuSK2hF/6IU6ORTuG6URvdoT5iFEr35CStok5j+tbnyTe9ZqF
	VHf9EaQ7cY92Go7Auud9W2xxGgqxU8w=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CE7063EA63;
	Fri,  9 Jan 2026 17:17:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /slfMjg4YWkUVAAAD6G6ig
	(envelope-from <dsterba@suse.com>); Fri, 09 Jan 2026 17:17:44 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 0/4] Delayed ref root cleanups
Date: Fri,  9 Jan 2026 18:17:39 +0100
Message-ID: <cover.1767979013.git.dsterba@suse.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Rspamd-Queue-Id: D452C5BFA7
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 

Embed delayed root into btrfs_fs_info.

David Sterba (4):
  btrfs: embed delayed root to struct btrfs_fs_info
  btrfs: reorder members in btrfs_delayed_root for better packing
  btrfs: don't use local variables for fs_info->delayed_root
  btrfs: pass btrfs_fs_info to btrfs_first_delayed_node()

 fs/btrfs/delayed-inode.c | 49 +++++++++++++---------------------------
 fs/btrfs/delayed-inode.h | 15 ------------
 fs/btrfs/disk-io.c       |  8 ++-----
 fs/btrfs/fs.h            | 18 +++++++++++++--
 4 files changed, 34 insertions(+), 56 deletions(-)

-- 
2.51.1


