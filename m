Return-Path: <linux-btrfs+bounces-1502-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F29F982FF76
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jan 2024 05:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11AD21C23D1D
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jan 2024 04:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9121F6AB8;
	Wed, 17 Jan 2024 04:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="sRk+KfRF";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="sRk+KfRF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2949522D
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Jan 2024 04:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705464665; cv=none; b=SrI5RfYMUFN1jqUjELFe7DBs2SqaKzTnvrDJafKCAAwXqXg+XyZf6YXSNMFIS4x/jlS4mAfKPP/fsjMfglbqJkKF2uM+Ec54aDHzkzS7ORyoKmzKrHsV4f3Rrpay2+JjBli1ZfcqWlkLSR+tOwV7HzIj0yDi/jM2wpa2QldlmEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705464665; c=relaxed/simple;
	bh=tyX9StE4zMWb84tWp3HhJht2S+dHshA8IKf+4DR8mYs=;
	h=Received:DKIM-Signature:DKIM-Signature:Received:Received:From:To:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Spamd-Result:X-Rspamd-Server:
	 X-Spam-Score:X-Rspamd-Queue-Id:X-Spam-Level:X-Spam-Flag:
	 X-Spamd-Bar; b=P9uL8TBisLSf41wENwZqwIniJwECOVsaY7qQHD5B3IE7YWWTyfM+Sg1LiAU5DLZj2k1YIIB9TnekXxkhedtZU4mHo8HjRpu1y7nbzXd4PG1NDc7FCkXccNUcDNJBSLnkFajTaJXDR9xSrzQHmPxM/J0t+3XZvzY5h1IaaTQXI6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=sRk+KfRF; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=sRk+KfRF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F13C71FD58
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Jan 2024 04:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705464660; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=f2hfoGLqhTqNyL9PUjqGQnS27c5u9K2U9hAyD6DcdU0=;
	b=sRk+KfRFLuE34jFNyZMCTVdb+TdwrXJD4ffC5wRhS17fiVtB6qJGbLp1l3TTjul+/3oYQS
	Ulf+MmkpsMKjI6orBLMgTPjSvY8QftvwrZMCiycCagzAaB9jx+1BcveaTU2+zO0msAQBCL
	7bX9nvWsNlPMsMK4DuieP8Knlergrl8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705464660; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=f2hfoGLqhTqNyL9PUjqGQnS27c5u9K2U9hAyD6DcdU0=;
	b=sRk+KfRFLuE34jFNyZMCTVdb+TdwrXJD4ffC5wRhS17fiVtB6qJGbLp1l3TTjul+/3oYQS
	Ulf+MmkpsMKjI6orBLMgTPjSvY8QftvwrZMCiycCagzAaB9jx+1BcveaTU2+zO0msAQBCL
	7bX9nvWsNlPMsMK4DuieP8Knlergrl8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2B2A813751
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Jan 2024 04:10:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JHD5M1JTp2XrSgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Jan 2024 04:10:58 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs-progs: parser related cleanups
Date: Wed, 17 Jan 2024 14:40:38 +1030
Message-ID: <cover.1705464240.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=sRk+KfRF
X-Spamd-Result: default: False [2.64 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 FROM_HAS_DN(0.00)[];
	 DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_NONE(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.05)[60.46%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 2.64
X-Rspamd-Queue-Id: F13C71FD58
X-Spam-Level: **
X-Spam-Flag: NO
X-Spamd-Bar: ++

Btrfs-progs has two types of parsers:

- parse_*()
  Those would return 0 for a good parse, and save the value into a
  pointer.
  Callers are responsible to handle the error.

- arg_strto*()
  Those would directly return the parsed value, and call exit(1)
  directly for errors.

However this split is not perfect:

- A lot of code can be shared between them
  In fact, mostly arg_strto*() can be implement using parse_*().
  The only difference is in how detailed the error string would be.

- parse_size_from_string() doesn't follow the scheme
  It follows arg_strto*() behavior but has the parse_*() name.

This patch would:

- Use parse_u64() to implement arg_strtou64()
  The first patch.

- Use parse_u64_with_suffix() to implement arg_strtou64_with_suffix()
  The new helper parse_u64_with_suffix() would replace the old
  parse_size_from_string() and do the proper error handling.

Qu Wenruo (2):
  btrfs-progs: use parse_u64() to implement arg_strtou64()
  btrfs-progs: implement arg_strtou64_with_suffix() with a new helper

 cmds/filesystem.c     | 15 ++++----
 cmds/qgroup.c         |  3 +-
 cmds/reflink.c        |  7 ++--
 cmds/scrub.c          |  2 +-
 common/parse-utils.c  | 85 ++++++++++++++++++++++++++++---------------
 common/parse-utils.h  |  2 +-
 common/string-utils.c | 45 +++++++++++++++--------
 common/string-utils.h |  3 ++
 convert/main.c        |  3 +-
 kernel-shared/zoned.c |  4 +-
 mkfs/main.c           |  6 +--
 11 files changed, 110 insertions(+), 65 deletions(-)

--
2.43.0


