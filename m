Return-Path: <linux-btrfs+bounces-11476-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0071A36CA1
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Feb 2025 09:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32F017A1E17
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Feb 2025 08:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F2F199249;
	Sat, 15 Feb 2025 08:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mMc3tGxF";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mMc3tGxF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663F8DDA8
	for <linux-btrfs@vger.kernel.org>; Sat, 15 Feb 2025 08:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739608485; cv=none; b=H2scI7rh984OX+GY5CZ59tsHMUzEDM03bjgh+IGO8cWTbGlmm+o1LlJtHYKWZJlRPAqyiO8k4YNxOzQgDNFPGKMR7Cs0IOOi479AqiSFg0S2AN58BBPr1nruguuJ/Q5gIkyvvQpbryynzVZQ++T10+FDC+zYaZ8/qYdVgNIRqcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739608485; c=relaxed/simple;
	bh=ldNG8wxBQHeOT6Qjxkjg8H/UBQEC1ehClo/RV4rwVks=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=QWhEm4o3ckcW7EDqoVC+VmwVxd2z0QAITLty1snOqNzG53y48u332bQwZNzua6iluBJoN+6lTtaaTgKYvUXlYxMXhRsVx8sj0+3q2Gl4gKdif/xLUujqXdqFIK9FZPsQZAaq/JQWJrDFw2vt1/uW34+Xefz8DX6bUwmJSdKczIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mMc3tGxF; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mMc3tGxF; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4C0A621177
	for <linux-btrfs@vger.kernel.org>; Sat, 15 Feb 2025 08:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1739608481; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=1Byn5JXkIlWCopWFS8xV+jYIbQXwYWtQMySkzQFjG9w=;
	b=mMc3tGxFEkztU7sRKvpmNW+NVd4vPSJDNIUgLDl8SswqlpduAzPMBQ5p/3v+Lq6JRBKlkH
	OltS6HtgmMCPH369GB68uMXrroKPEYjiqB6bxgBNFzsQ6mlJkQ/IRWVUfUaWX04OlDHWH0
	1cBWrlox/n0dy5a9B6vf8YSI4bL8LC8=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=mMc3tGxF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1739608481; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=1Byn5JXkIlWCopWFS8xV+jYIbQXwYWtQMySkzQFjG9w=;
	b=mMc3tGxFEkztU7sRKvpmNW+NVd4vPSJDNIUgLDl8SswqlpduAzPMBQ5p/3v+Lq6JRBKlkH
	OltS6HtgmMCPH369GB68uMXrroKPEYjiqB6bxgBNFzsQ6mlJkQ/IRWVUfUaWX04OlDHWH0
	1cBWrlox/n0dy5a9B6vf8YSI4bL8LC8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7C2A8136E6
	for <linux-btrfs@vger.kernel.org>; Sat, 15 Feb 2025 08:34:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eCuVDqBRsGfNTQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sat, 15 Feb 2025 08:34:40 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/4] btrfs: allow creating inline data extents for sector size < page size case
Date: Sat, 15 Feb 2025 19:04:18 +1030
Message-ID: <cover.1739608189.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4C0A621177
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

[CHANGELOG]
v2:
- Add the previous inline read fix into the series
- Add a patch to remove the subpage experimental warning message
  The main reason for the warning is the lack of some features, but it's
  no longer the case.

For btrfs block size < page size (subpage), there used to a list of
features that are not supported:

- RAID56
  Added in v5.19

- Block perfect compressed write
  Added in v6.13, previously only page aligned range can go through
  compressed write path.

- Inline data extent creation

But now the only feature that is missing is only inline data extent
creation.

And all technical problems are solved in v6.13, it's time for us to
allow subpage btrfs to create inline data extents.

The first patch is to fix a bug that can only be triggered with recent
partial uptodate folio support.

The second patch fixes a minor issue for qgroup accounting for inlined
data extents.

The third path enables inline data extent creation for subpage btrfs.

And finally remove the experimental warning message for subpage btrfs.

Qu Wenruo (4):
  btrfs: fix inline data extent reads which zero out the remaining part
  btrfs: fix the qgroup data free range for inline data extents
  btrfs: allow inline data extents creation if sector size < page size
  btrfs: remove the subpage related warning message

 fs/btrfs/disk-io.c |  5 -----
 fs/btrfs/inode.c   | 30 ++++++++++--------------------
 2 files changed, 10 insertions(+), 25 deletions(-)

-- 
2.48.1


