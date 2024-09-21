Return-Path: <linux-btrfs+bounces-8151-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E0897DB72
	for <lists+linux-btrfs@lfdr.de>; Sat, 21 Sep 2024 04:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A93011C213F5
	for <lists+linux-btrfs@lfdr.de>; Sat, 21 Sep 2024 02:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320BB1CD2B;
	Sat, 21 Sep 2024 02:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="AwCmdGjx";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="AwCmdGjx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FCB3D7A
	for <linux-btrfs@vger.kernel.org>; Sat, 21 Sep 2024 02:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726885616; cv=none; b=mBfhGOog5B/7rZ6vSQKUWGKB0mecV6x2lsHaZuxqbi+8Iureq24gS66euInU0YNWCi1cufaIqMCMgZz3PQen+Q4il6ONENqaSR99kgkWYh//YXHPzVnxZq6fDdYvpYjME+fjMaQiZmQ5x+DM8GLp3ycmrbPzRH74NAFe9AIkyOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726885616; c=relaxed/simple;
	bh=DKmbggXNT+oU3HVWreJ17QVxm+da3iG+2M+/P177Mmw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d3ICnkV8wE1ks2BSiLj3wfifFFCPudKvi6sw2kHFpV1Ta/qih/BYLv2Ha0uk3lY7oFsrP5dRklxtFYu2m8Avbf2+dsmHO0YACFK/Qwt0L7V1pjLkSq+/r+ey7ZlrUYdLfQp+2oePSmpxAdYgMj3hPNdp29ds5aW2umurJQsykGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=AwCmdGjx; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=AwCmdGjx; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D274833A80
	for <linux-btrfs@vger.kernel.org>; Sat, 21 Sep 2024 02:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1726885611; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E3Y/+28kUYc4GxksJ3UWeKUQ1F7koGi9A+mLxTjandE=;
	b=AwCmdGjxzBTLEkzfjz49cKxObfhseYCt4ZBjyp2qMkh6Knrvi3Yw+Cne0MnXL+GU3B+2t3
	1+dLlosi/q8uACPfsCPdAEb1EEcwIWTQ0ieUinaPoPtgCRt44ZZxv0ECw0F4qBJ5/sCN+D
	WDsM4XoTK9RvllRwtKefMaw4dXeQL3g=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1726885611; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E3Y/+28kUYc4GxksJ3UWeKUQ1F7koGi9A+mLxTjandE=;
	b=AwCmdGjxzBTLEkzfjz49cKxObfhseYCt4ZBjyp2qMkh6Knrvi3Yw+Cne0MnXL+GU3B+2t3
	1+dLlosi/q8uACPfsCPdAEb1EEcwIWTQ0ieUinaPoPtgCRt44ZZxv0ECw0F4qBJ5/sCN+D
	WDsM4XoTK9RvllRwtKefMaw4dXeQL3g=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 10C9B13882
	for <linux-btrfs@vger.kernel.org>; Sat, 21 Sep 2024 02:26:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gERQMeou7malAQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sat, 21 Sep 2024 02:26:50 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs-progs: libbtrfsutil/python: remove unnecessary build options
Date: Sat, 21 Sep 2024 11:56:25 +0930
Message-ID: <b9686165ac0d83ab80aae29392ec8d4a3a6fcfa0.1726885304.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <cover.1726885304.git.wqu@suse.com>
References: <cover.1726885304.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.68 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	NEURAL_HAM_SHORT(-0.08)[-0.410];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.68
X-Spam-Flag: NO

There is no special include and libarary path required for the build of
cpython binding.

Just remove the unnecessary build options.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 libbtrfsutil/python/setup.py | 2 --
 1 file changed, 2 deletions(-)

diff --git a/libbtrfsutil/python/setup.py b/libbtrfsutil/python/setup.py
index 79c0b48dee7d..8b377b9fa1b6 100755
--- a/libbtrfsutil/python/setup.py
+++ b/libbtrfsutil/python/setup.py
@@ -97,8 +97,6 @@ module = Extension(
         'qgroup.c',
         'subvolume.c',
     ],
-    include_dirs=['..'],
-    library_dirs=['../..'],
     libraries=['btrfsutil'],
 )
 
-- 
2.46.1


