Return-Path: <linux-btrfs+bounces-19372-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB13C8D1F3
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Nov 2025 08:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1AD63B04C5
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Nov 2025 07:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A6430EF75;
	Thu, 27 Nov 2025 07:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OLToRmA2";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OLToRmA2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB6931DD96
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Nov 2025 07:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764228820; cv=none; b=WGTw0BUVyYAF2On+5c5B8SaU/RNwY8E+r2sz/tI7Xw+IHO7Nm2E/YwD1ovGdR8mz9MTlyrck7m/igcPNzDIu/O8PMkhoGmJLUCm8ky6/nVkPMt/i5F8nCt4Zuv9PsH//pSfpubJElqyfvHeEf80Rm/WaCq6m62PTroDMPRKgKYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764228820; c=relaxed/simple;
	bh=379ASGynee5Td8wmhWRlIO915UjzvxTWK7wrQN2WOs8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=NzHN9Ff2NTIhswpLNx45tKRrEXhUZdrJ8DUkZ2MISe0Kjc2XpFBFBD6TUTPz3gwh/bDI2X8reNcAD3uv+E40Uq9H24Hi4J7r7wURvjsjScU2rFCZ2H9R31/2O84EIBpw9L745PAZcj3HFfGcnskgwL79I2PQUyUvwE8rZfo6+hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OLToRmA2; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OLToRmA2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A883633695
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Nov 2025 07:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1764228815; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=3JMcGJzjknm5g7PDIywQcnHjyLK1LmRcr4dzh3qQgUg=;
	b=OLToRmA2NvgqEqO+CuRkC2BccG3prPGDl20zPDZmpr9rLUdWwTz75+Az43rQrI5DWCUF18
	eq6GpwcVn2fgJnQkEH658Lt/warVuyUn2HJcJz4yU9VzsjHSw04rpHmAQ9arIklAM5ol7J
	A9MyWbRI0ygIihjTlMsUmmRtc5gQJ2E=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=OLToRmA2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1764228815; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=3JMcGJzjknm5g7PDIywQcnHjyLK1LmRcr4dzh3qQgUg=;
	b=OLToRmA2NvgqEqO+CuRkC2BccG3prPGDl20zPDZmpr9rLUdWwTz75+Az43rQrI5DWCUF18
	eq6GpwcVn2fgJnQkEH658Lt/warVuyUn2HJcJz4yU9VzsjHSw04rpHmAQ9arIklAM5ol7J
	A9MyWbRI0ygIihjTlMsUmmRtc5gQJ2E=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E40E03EA63
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Nov 2025 07:33:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZZbYKM7+J2nlcgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Nov 2025 07:33:34 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/3] btrfs-progs: add block-group-tree to the default mkfs/convert features
Date: Thu, 27 Nov 2025 18:03:14 +1030
Message-ID: <cover.1764228560.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:mid,suse.com:dkim];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A883633695

[CHANGELOG]
v2:
- Automatically remove bgt feature when dependent feature is missing
  Instead of erroring out. This will allow us to run the existing
  no-holes/v1 free space cache test cases without any modification.

I was planning to do this during v6.12 but forgot it and now the next
LTS kernel release is not that far away, it's finally time to make the
switch.

The first patch is to change mkfs/btrfs-convert from rejecting
"bgt,^no-holes" to disabling bgt when no-holes/fst feature is not
selected.
This allows the existing "mkfs.btrfs ^no-holes" to be executed without
extra modification.

The second patch is a large page-size specific fix, where on 64K page
size systems misc/057 will fail due to subpage mounts always enable v2
free space cache, resulting later conversion failure to fst (as it's
already fst).

The final patch is the one enabling new default block-group-tree feature
for mkfs and convert.

Qu Wenruo (3):
  btrfs-progs: disable block-group-tree feature if dependency is missing
  btrfs-progs: misc-tests: check if free space tree is enabled after
    mount
  btrfs-progs: add block-group-tree to the default mkfs features

 Documentation/mkfs.btrfs.rst                           |  7 ++++++-
 common/fsfeatures.c                                    |  2 +-
 common/fsfeatures.h                                    |  3 ++-
 convert/main.c                                         |  4 ++--
 mkfs/main.c                                            | 10 +++++++---
 tests/misc-tests/057-btrfstune-free-space-tree/test.sh |  8 ++++++++
 6 files changed, 26 insertions(+), 8 deletions(-)

--
2.52.0


