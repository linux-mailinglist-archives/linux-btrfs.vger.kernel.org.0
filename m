Return-Path: <linux-btrfs+bounces-2389-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EAB985522B
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Feb 2024 19:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1E461C295EB
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Feb 2024 18:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFCA13B7A8;
	Wed, 14 Feb 2024 18:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="C/HaVNmR";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="C/HaVNmR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AA513341A
	for <linux-btrfs@vger.kernel.org>; Wed, 14 Feb 2024 18:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707935554; cv=none; b=OnwMGeCxcKUxAcrQWptuWWZhvZ1Y8rqm6wYguyu4oc/Jw+ui62jP82Dx6Me1KjHIxDCGCIhy83drDig4BcjyjyqL9eEhpKbJluuqMQZHFu97FaG5LywEYsyBHfxARh7zt9xlQV/ybUay4U6kRV6tQgsTY3HFByjpFqBTYhCIufM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707935554; c=relaxed/simple;
	bh=fTI4jUpQvVO+TbQckByZrwjMdHSy29aF3arCFAOsz5o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QK/WnzfkgDc6t2Feykuy2I8xzxxQOaL7LWMEb1IbUWAr5yctg+q3HhbH29fg14c0UDBD/otlgSS+O1U/xAZlHYBIbURGk9XlOO29NnynCRCy+Y8lSF8aLme8v+nQFWsparbBsoGxjuBByaQpvq2ibFRpUfRz3M94W/xoMGRHdWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=C/HaVNmR; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=C/HaVNmR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 82C1C21F38;
	Wed, 14 Feb 2024 18:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707935549; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Qka3EzR+uDO/hZTWwNO90yXfRpe0Ny4kBdZXAKIHZ3M=;
	b=C/HaVNmR5IawykKS9r6TGnYRKQpRCfyUYgPnZZLC0Vz6A3+OF4sClNzyTdJctb4/jsdOuo
	f6EJ1fN29CvZ1hPy++E5cMn6jp+mqMoq2IADfhaVpy2578wlEp7rCw22coGgZw7bN9/WjZ
	ZhHZzzAKPd20EJNMxJe+TynNcucovBo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707935549; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Qka3EzR+uDO/hZTWwNO90yXfRpe0Ny4kBdZXAKIHZ3M=;
	b=C/HaVNmR5IawykKS9r6TGnYRKQpRCfyUYgPnZZLC0Vz6A3+OF4sClNzyTdJctb4/jsdOuo
	f6EJ1fN29CvZ1hPy++E5cMn6jp+mqMoq2IADfhaVpy2578wlEp7rCw22coGgZw7bN9/WjZ
	ZhHZzzAKPd20EJNMxJe+TynNcucovBo=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 75E8413A0B;
	Wed, 14 Feb 2024 18:32:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id gEt0HD0HzWUBRQAAn2gu4w
	(envelope-from <dsterba@suse.com>); Wed, 14 Feb 2024 18:32:29 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	Edward Adam Davis <eadavis@qq.com>
Subject: [PATCH 0/3] Ioctl buffer name/path validation
Date: Wed, 14 Feb 2024 19:31:54 +0100
Message-ID: <cover.1707935035.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
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
	 RCPT_COUNT_THREE(0.00)[3];
	 FREEMAIL_ENVRCPT(0.00)[qq.com];
	 R_MISSING_CHARSET(2.50)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[suse.com,qq.com];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[16.45%]
X-Spam-Level: ****
X-Spam-Score: 4.90
X-Spam-Flag: NO

This is inspired by a report and fix [1] where device replace buffers
were not properly validated (third patch). The other two are doing
proper validation of vol args path or name so that an unterminated
string is reported as an error rather than relying on later actions like
open that would catch an invalid path.

(I'm OK to replace the third patch in favor of Edward as he spent time
analyzing it but we did not agree on a fix and I did not get a reply
with the suggestion I implemented in the end.)

[1] https://lore.kernel.org/linux-btrfs/tencent_44CA0665C9836EF9EEC80CB9E7E206DF5206@qq.com/

David Sterba (3):
  btrfs: factor out validation of btrfs_ioctl_vol_args::name
  btrfs: factor out validation of btrfs_ioctl_vol_args_v2::name
  btrfs: dev-replace: properly validate device names

 fs/btrfs/dev-replace.c | 24 +++++++++++++++----
 fs/btrfs/fs.h          |  2 ++
 fs/btrfs/ioctl.c       | 54 +++++++++++++++++++++++++++++++++++-------
 fs/btrfs/super.c       |  5 +++-
 4 files changed, 72 insertions(+), 13 deletions(-)

-- 
2.42.1


