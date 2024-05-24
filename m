Return-Path: <linux-btrfs+bounces-5279-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F54E8CE682
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 May 2024 15:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 840041C21AF8
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 May 2024 13:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E87612C46A;
	Fri, 24 May 2024 13:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WZDuOX5l";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WZDuOX5l"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AAF1E52C;
	Fri, 24 May 2024 13:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716559166; cv=none; b=hxQtekpWHWyNu+wBhyo3UDE0oOS/nJBD5m1KXeWsibV+z9etu+UHtj+lT5erdznB2l7RNZUgvaRO8bGBrWmgR28HNtbM8DKl75X3Tpa2nzTcxbM7uIsLiT8Xk58Vu+CADOaAtn0N8/xcaZM8jmEMQYbd51ljKIVs3TZW4QXwOWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716559166; c=relaxed/simple;
	bh=eigOkXhVAxkNczG9ILW2GNepTM5dLWzRxSnSxnnuquI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UsIFG87kkVGeY/XaNcBMA0pHa6u8dnRlWzmwKFOXdUO8ae0+zVvo9JV7WTfa6q3GU8cDdfjefRA/xspNqkaEzj+s2DvdpqZUIS2fpzsdxwVYSn2xrp9PCurssTBT+Opa+/y9bXG+k25fGBjDJRIUHrEaytAxQEU07v82VxsBzjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=WZDuOX5l; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=WZDuOX5l; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 89CAF33B42;
	Fri, 24 May 2024 13:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716559162; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YQNWZX9NpdGCXnzY+udQQ+tZbyDmZM0w61obvO98b00=;
	b=WZDuOX5lAQ0l+NtGpxeDrnUUaT6xfn55xMiC7i6A+JtCOO+W7uF5HbeJAiHIIgGVzxkhqY
	Z1djCeadBZgCU5y4Pukcj3/BbF8X9/FbBB1WH7qAI4hO3E3EkBmQozD1LA2WaTGEjVt/8C
	awq2jmP8lSBlhbvixjlFpxmGT1hRF6g=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=WZDuOX5l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716559162; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YQNWZX9NpdGCXnzY+udQQ+tZbyDmZM0w61obvO98b00=;
	b=WZDuOX5lAQ0l+NtGpxeDrnUUaT6xfn55xMiC7i6A+JtCOO+W7uF5HbeJAiHIIgGVzxkhqY
	Z1djCeadBZgCU5y4Pukcj3/BbF8X9/FbBB1WH7qAI4hO3E3EkBmQozD1LA2WaTGEjVt/8C
	awq2jmP8lSBlhbvixjlFpxmGT1hRF6g=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 83C3113A3D;
	Fri, 24 May 2024 13:59:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pXwmIDqdUGZpTAAAD6G6ig
	(envelope-from <dsterba@suse.com>); Fri, 24 May 2024 13:59:22 +0000
From: David Sterba <dsterba@suse.com>
To: torvalds@linux-foundation.org
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Btrfs updtes for 6.10, part 2
Date: Fri, 24 May 2024 15:59:18 +0200
Message-ID: <cover.1716556959.git.dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -5.51
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 89CAF33B42
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-5.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim]

Hi,

a few more updates, mostly stability fixes or user visible changes.
Please pull, thanks.

- fix race in zoned mode during device replace that can lead to
  use-after-free

- update return codes and lower message levels for quota rescan where
  it's causing false alerts

- fix unexpected qgroup id reuse under some conditions

- fix condition when looking up extent refs

- add option norecovery (removed in 6.8), the intended replacements
  haven't been used and some aplications still rely on the old one

- build warning fixes

----------------------------------------------------------------
The following changes since commit 0e39c9e524479b85c1b83134df0cfc6e3cb5353a:

  btrfs: qgroup: fix initialization of auto inherit array (2024-05-07 21:31:11 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.10-tag

for you to fetch changes up to 440861b1a03c72cc7be4a307e178dcaa6894479b:

  btrfs: re-introduce 'norecovery' mount option (2024-05-21 15:27:17 +0200)

----------------------------------------------------------------
Boris Burkov (1):
      btrfs: qgroup: fix qgroup id collision across mounts

David Sterba (1):
      btrfs: qgroup: update rescan message levels and error codes

Filipe Manana (2):
      btrfs: zoned: fix use-after-free due to race with dev replace
      btrfs: fix end of tree detection when searching for data extent ref

Lu Yao (1):
      btrfs: scrub: initialize ret in scrub_simple_mirror() to fix compilation warning

Qu Wenruo (1):
      btrfs: re-introduce 'norecovery' mount option

 fs/btrfs/extent-tree.c |  2 +-
 fs/btrfs/qgroup.c      | 32 +++++++++++++++++++++++++-------
 fs/btrfs/scrub.c       |  2 +-
 fs/btrfs/super.c       |  8 ++++++++
 fs/btrfs/zoned.c       | 13 ++++++++++---
 5 files changed, 45 insertions(+), 12 deletions(-)

