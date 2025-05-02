Return-Path: <linux-btrfs+bounces-13629-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E44FAA73F5
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 May 2025 15:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E02C18863FB
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 May 2025 13:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FDD255E2B;
	Fri,  2 May 2025 13:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="TILiZqKp";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KgbcdQWd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57C5255224
	for <linux-btrfs@vger.kernel.org>; Fri,  2 May 2025 13:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746193075; cv=none; b=e4O0YucB4Y9KNUM203o7TchkLrT/IJ83CDCf0I1Ggd+w47PDaZ50xgjU6cKymbLGJOy4M3aeOt5Rye7kXUxpbGOnXgP1GpKFekia7zIId96agWa7XUJ76X/5V4GX0ahb+35L9+ndCDlom7EsTvWKUNkluBEM0tQ9VDgIGLv0uqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746193075; c=relaxed/simple;
	bh=Vp5B1bJMI+2aaEZ+RMoH09rh6FfOUV/dA6N/uMI9n9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D91+lgDXQm6xvznKdMhk0F1pvjqT9jC+CWDnor7K9T95hbmvbHp02ePG30y50dIHatb3LB9n7hlGL2kzmpLtc8DXip0g1pYdAjPoNYQfyIh2m2Wj9tAAL9DSBTcoHZ6YQzCc6C4p8j6PN6h9dOWeo6QAcOgMeu1WYP6rlYM/Y9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=TILiZqKp; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KgbcdQWd; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7EB451F385;
	Fri,  2 May 2025 13:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1746193072; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UXiyfd80xDkxcK8l88BL2VTexa/gmsmXBTfWopTM9Zs=;
	b=TILiZqKpQr8lwzrnsE4VKt38L2Oud6thn62RmPZE2bS60tjz/sdx9hU95spvHy9LiGYXj+
	Go3gFiyZUCxkU8zW/aby2ibQC4RkYudo2icTuP40dRDhTajJj9frEulapcVKn+RTopFNMm
	bmEKpIBs5p6gJ8AyWWdNtgUXrhZrXik=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1746193071; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UXiyfd80xDkxcK8l88BL2VTexa/gmsmXBTfWopTM9Zs=;
	b=KgbcdQWdqJ6Hdnuy6D1eL7+f+g4lLey3uCUhD7+mjwrb25CSaoVr97pwyRuwdQM5QniirD
	0lRY6SSxdMeySxaUmQj8lDjmUpuVCdLTCJrbbjqRRSRHjR/DlUb2Q2UbkTEBnRi9WeRbm+
	GohFXWN6yBXjddWDs+pFDzDB70BPCdY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 694DF1372E;
	Fri,  2 May 2025 13:37:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 88jfGK/KFGiIHQAAD6G6ig
	(envelope-from <neelx@suse.com>); Fri, 02 May 2025 13:37:51 +0000
From: Daniel Vacek <neelx@suse.com>
To: David Sterba <dsterba@suse.com>
Cc: Daniel Vacek <neelx@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] btrfs: eb struct cleanups
Date: Fri,  2 May 2025 15:37:21 +0200
Message-ID: <20250502133725.1210587-1-neelx@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250429151800.649010-1-neelx@suse.com>
References: <20250429151800.649010-1-neelx@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	URIBL_BLOCKED(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

This series is about the first patch. See the details there.
The second patch is just a small followup size optimization.

v1 is here: https://lore.kernel.org/linux-btrfs/20250429151800.649010-1-neelx@suse.com/

To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Daniel Vacek (2):
  btrfs: remove extent buffer's redundant `len` member field
  btrfs: rearrange the extent buffer structure members

 fs/btrfs/accessors.c             |  4 +--
 fs/btrfs/disk-io.c               | 11 +++---
 fs/btrfs/extent-tree.c           | 28 ++++++++-------
 fs/btrfs/extent_io.c             | 59 ++++++++++++++------------------
 fs/btrfs/extent_io.h             | 12 +++----
 fs/btrfs/ioctl.c                 |  2 +-
 fs/btrfs/relocation.c            |  2 +-
 fs/btrfs/subpage.c               | 12 ++++---
 fs/btrfs/tests/extent-io-tests.c | 12 +++----
 fs/btrfs/zoned.c                 |  2 +-
 10 files changed, 72 insertions(+), 72 deletions(-)

-- 
2.47.2


