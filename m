Return-Path: <linux-btrfs+bounces-4864-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3DA8C0D47
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 May 2024 11:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F80A1C21264
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 May 2024 09:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C3E14A623;
	Thu,  9 May 2024 09:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Ddcn6GFK";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Y6syag0g"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846C013C9B6
	for <linux-btrfs@vger.kernel.org>; Thu,  9 May 2024 09:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715245982; cv=none; b=BzbFxcSs8jNfikR5k6vY1GApFurv+P26WRLAYJY8NHBZfNG8WLd6ZJr6WOkHmxqaeZ8eN/M+9fOrSzFAQAGUfIm0pUurWNKzMHpxCED0BOiTL+NRZCbLK4DSKznddlx65aK5MA2ImcRuhWaOBUT9Z6k+J6LxK++y1KMvW8BfRxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715245982; c=relaxed/simple;
	bh=2eo+WsNVZfy7yoNqg4QT4I2BSgs25Y65E/0S3qvx/2M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=OMafSSwGqA90Vt3ZbpFYwp1D9ROFpWKOd1AJI+qhw1oXhXNVuZyu/Eqag2H1QDuyvPDenI5m12My7aiqob/Fw4LJEBmlYGr7H/L8IKQ28/PqIyTGalQXL5dNiJe+UsHCx1T3GvUjK95GPxHiK/POgUj21Gjy9wqeQvJDK4HG5oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Ddcn6GFK; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Y6syag0g; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D6E763816D
	for <linux-btrfs@vger.kernel.org>; Thu,  9 May 2024 09:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715245973; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=xtcW4UJuHf3GKn+H+3HZGfNn/Mv9/V7kEhdIwmfgHQs=;
	b=Ddcn6GFKucJiStdjlhaszhORUOJlAoa6fyEwVvqV5RZ9NXVCGZ/vM/cI4G6sJS3cYA5t87
	XxYNbwSdfLzMk/UIwAJ40mx01h3lrMpZFe8nl5lTCIwFaTvcZgNdUsHZBwUhMNwlrpZWb1
	Y70dro/9W4RK2g/d/cec2jrXkIteIl0=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Y6syag0g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715245972; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=xtcW4UJuHf3GKn+H+3HZGfNn/Mv9/V7kEhdIwmfgHQs=;
	b=Y6syag0gG9pBva4zqnzm3RalQF7XcwhVaA9Mf1ntWn05knKqRK6ZBKiKubcbDpBmSzqEAA
	jryi5s/FpDP1cnruIUBl85ZtpXbb/xPC65bf7oRVQH5eTRYe6kb+BFazluCkQbM7n08nE7
	8zLeDnogWWcEMORniCxvMX8v5nFQSPQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ED51513A24
	for <linux-btrfs@vger.kernel.org>; Thu,  9 May 2024 09:12:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id b1bXJ5OTPGZ6KgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 09 May 2024 09:12:51 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/4] btrfs-progs: cmds/qgroup: enhance stale qgroups handling
Date: Thu,  9 May 2024 18:42:29 +0930
Message-ID: <cover.1715245781.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.88
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: D6E763816D
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.88 / 50.00];
	BAYES_HAM(-2.87)[99.45%];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.com:+]

Currently the `<stale>` label is give incorrectly for a lot of qgroups
that can not and should not be deleted.

The patchset would address the problem for `btrfs qgroup show` and
`btrfs qgroup clear-stale` commands, so that:

- `clear-stale` would not try to delete incorrect qgroups
  Thus it should not return false errors.

- `show` would show extra types of qgroups
  Including `<under deletion>` and `<squota space holder>`

Qu Wenruo (4):
  btrfs-progs: cmds/qgroup: sync the fs before doing qgroup search
  btrfs-progs: cmds/qgroup: add qgroup_lookup::flags member
  btrfs-progs: cmds/qgroup: handle stale qgroup deleteion more
    accurately
  btrfs-progs: cmds/qgroup: add more special status for qgroups

 Documentation/btrfs-qgroup.rst |  24 +++++
 cmds/qgroup.c                  | 160 ++++++++++++++++++++++++++++-----
 2 files changed, 162 insertions(+), 22 deletions(-)

--
2.45.0


