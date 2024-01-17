Return-Path: <linux-btrfs+bounces-1535-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA3B831006
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jan 2024 00:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2E2E1C2175A
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jan 2024 23:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB761286BD;
	Wed, 17 Jan 2024 23:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="MJHlnu0T";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="CI7re5ba"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC37A2556A
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Jan 2024 23:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705533070; cv=none; b=QAQDV/+zGyQGdggC9B7HQF52dMHb22amGyH9rsp/bP8oLrEwKdo5TItRJV3a3PHhgV+ICFJfRAy7xb16eOmhVjB1o0DojLYHJyAR/gg2tPOlGiIXOZ4i6GVfbMRn79PF6gT12WYrg0FvKY0D0V+fBXYjId1Gihsqq9OWLOMt0vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705533070; c=relaxed/simple;
	bh=Vn5hV3WxfWlVJ5u5JCvQYbstB5PtkIHR5Rl/WTEWSUc=;
	h=Received:DKIM-Signature:DKIM-Signature:Received:Received:From:To:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Spamd-Result:X-Spam-Level:X-Spam-Score:
	 X-Spam-Flag; b=I6o/U+Uh03v64VlbpueHJRaDsIyIehsyy976vXruat3G3xyPF/u+DCRG+jCXzJrhBElVN5fx48HnBFaRna9sFpMlSOBlU14hfb5Zs4VJC5ccg5z/k9ctj/IaAUq8QDpjnGu99JuCNrq14po15SfL1MRYeGzuxcOKKUnaxbyaGi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=MJHlnu0T; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=CI7re5ba; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EE2AA21FD8
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Jan 2024 23:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705533063; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=dFFnvoh0yfDlaUqeNuXsA7/AYtgP0QnCD5SwYfhxUqs=;
	b=MJHlnu0TOGD3r4feSFKk7TXCQACrEXVSpMSJVifgHvCEse4YSZX9v0RJo2+vL4JtvNk/kT
	7yaLy+B0/D+qJkFNC+Gss5p+BRI1VUvW//T7HplbcnRB1C8zfIt0AfuHogOPWv4nQAYkCG
	ilVkpChpjYd4NoWfKVZI9xR2BedCOPA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705533062; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=dFFnvoh0yfDlaUqeNuXsA7/AYtgP0QnCD5SwYfhxUqs=;
	b=CI7re5ba3aSSwb4QmlCCjHeSh00oAXm1XSb7e12PiFL/24JFSP+TwH+kql1e/9x7qG8ylF
	g7crWccM6cVxaF3nzL5PJw+hKxDSeuP2Yb3ztmwTmU9TP3sHeQmXsKnQ4wAe/fcH03RE3S
	Dtg6jxqcWYVOK+LXqZHP6RLy7lZrswY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2D87313800
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Jan 2024 23:11:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5CSEOIVeqGXpHwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Jan 2024 23:11:01 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/2] btrfs-progs: parser related cleanups
Date: Thu, 18 Jan 2024 09:40:41 +1030
Message-ID: <cover.1705532789.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [4.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_NONE(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[19.39%]
X-Spam-Level: ****
X-Spam-Score: 4.90
X-Spam-Flag: NO

[CHANGELOG]
v2:
- Properly return the parsed value for parse_u64_with_suffix()
  Facepalm, I forgot to assign the result to @value_ret, and only relied
  on cli-tests to catch them, but they are not enough to catch.

- Avoid outputting any error message inside parse_u64_with_suffix()
  One error message and exit(1) call is left from previous function.
  Need to be consistent with all other error situations.

- Rebased using the patch from devel branch
  So that the modification David did won't need to be redone.

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
 common/parse-utils.c  | 90 +++++++++++++++++++++++++++----------------
 common/parse-utils.h  |  2 +-
 common/string-utils.c | 45 ++++++++++++++--------
 common/string-utils.h |  9 +++++
 convert/main.c        |  3 +-
 kernel-shared/zoned.c |  4 +-
 mkfs/main.c           |  6 +--
 11 files changed, 118 insertions(+), 68 deletions(-)

--
2.43.0


