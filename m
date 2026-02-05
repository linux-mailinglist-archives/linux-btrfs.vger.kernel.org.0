Return-Path: <linux-btrfs+bounces-21401-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBGQJxYvhWn/9gMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21401-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 06 Feb 2026 01:00:22 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A864F87A6
	for <lists+linux-btrfs@lfdr.de>; Fri, 06 Feb 2026 01:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F13703029C1E
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Feb 2026 00:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1533F239E60;
	Fri,  6 Feb 2026 00:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="dJbvrGvi";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="dJbvrGvi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325001F2380
	for <linux-btrfs@vger.kernel.org>; Fri,  6 Feb 2026 00:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770336019; cv=none; b=arNfMKlU0a+8m/5Ur1bA1yH6EPd3ndVuWAvWM31xhEG3p4zv8jKV7yUN4Os8rHeo+R1NXkiFPlaLy+7yy0VFU54FTm2eNfQUMdnuP3RTWhYJQN4emP4Z56B/ZcsolOuq0/obq7TwtRNk87g9lzU93ESLNpGgTeXWcFS6P8DWwgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770336019; c=relaxed/simple;
	bh=vzsqm8WyBc/00hJxb+ydjhokCCFlw2OUN0UiPY2+kyg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WxmUHcwxzBzpHrx5DSAuYcS/N/GH1HQqSw4+r4j3tWcyONX6KDrhbKnVw3a8l9oX4hUj9d2jVq4QUIlumwc80pqFQn2bbLUZEuieC73KHNHpRmFM/f1f9Eu1a7B5ji+6tiz3JpRkyzxQQovqOvNyGYpycibeGAdO4/iHXB60wes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=dJbvrGvi; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=dJbvrGvi; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C2ED43E6D2
	for <linux-btrfs@vger.kernel.org>; Fri,  6 Feb 2026 00:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1770336005; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TM5lJGfDYu6zse+vDkkhISHF+6+59H6HfOrZm63xqN8=;
	b=dJbvrGviZi3JS82lyOtZLspMwG8DyWmaV7fde1Z44QOvLQ71KzFiVFm+Qr2217M6FFErwW
	Ms9eP9f/xV9+Nuq+T5nqng1I+JehuUM97AiUtKad7c+kNjFjhcjgTMjj1gzNybt7S0tLVd
	FJ3ZO970/yFZtpoNuck4Y0rSmXHKezM=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=dJbvrGvi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1770336005; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TM5lJGfDYu6zse+vDkkhISHF+6+59H6HfOrZm63xqN8=;
	b=dJbvrGviZi3JS82lyOtZLspMwG8DyWmaV7fde1Z44QOvLQ71KzFiVFm+Qr2217M6FFErwW
	Ms9eP9f/xV9+Nuq+T5nqng1I+JehuUM97AiUtKad7c+kNjFjhcjgTMjj1gzNybt7S0tLVd
	FJ3ZO970/yFZtpoNuck4Y0rSmXHKezM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EF9513EA63
	for <linux-btrfs@vger.kernel.org>; Fri,  6 Feb 2026 00:00:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oK+EKwQvhWlzOQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 06 Feb 2026 00:00:04 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs-progs: fsck-tests: add a new test case for deleting orphan fst entries
Date: Fri,  6 Feb 2026 10:29:43 +1030
Message-ID: <dd3a868f33762d907a1c8bfc99c14b47c917ba7b.1770335913.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1770335913.git.wqu@suse.com>
References: <cover.1770335913.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_FROM(0.00)[bounces-21401-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,v:email,p:email,tink-ly3m:email,nah:email,cyxfie:email,ixuwe0:email,om:email]
X-Rspamd-Queue-Id: 0A864F87A6
X-Rspamd-Action: no action

The image is created by creating an empty btrfs with older v6.16 btrfs-progs.
Which has free space tree entries for two temporary block groups.

And the test itself is going through the common repair test procedure.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 .../071-orphan-fst-entry/.lowmem_repairable      |   0
 .../orphan_fst_entries.img.xz                    | Bin 0 -> 1864 bytes
 2 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 tests/fsck-tests/071-orphan-fst-entry/.lowmem_repairable
 create mode 100644 tests/fsck-tests/071-orphan-fst-entry/orphan_fst_entries.img.xz

diff --git a/tests/fsck-tests/071-orphan-fst-entry/.lowmem_repairable b/tests/fsck-tests/071-orphan-fst-entry/.lowmem_repairable
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/tests/fsck-tests/071-orphan-fst-entry/orphan_fst_entries.img.xz b/tests/fsck-tests/071-orphan-fst-entry/orphan_fst_entries.img.xz
new file mode 100644
index 0000000000000000000000000000000000000000..bc68661b1e1917da5266c50747e6c7f14cfecf49
GIT binary patch
literal 1864
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

literal 0
HcmV?d00001

-- 
2.52.0


