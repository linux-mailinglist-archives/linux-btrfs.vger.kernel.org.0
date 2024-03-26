Return-Path: <linux-btrfs+bounces-3606-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF0E88C5C6
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 15:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF851B226B9
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 14:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE30713C801;
	Tue, 26 Mar 2024 14:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="DjWG4LD3";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="DjWG4LD3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1572213C668
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Mar 2024 14:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711464624; cv=none; b=UXEghk3dk2Kp5UyUyXNFlANl4Ft/C1lK0lTKUQ8OPo98Q8jomm8/jcMJWVfRuMNmyTruo578WmG4elaNWJMld6RqpoLrvKC+oShtdln+AWQEG7m5sqqgkAE82sFKq6fLHAutGd7kmsQvCYOKQkMBlFdHuKlJQTQ0J/fVUVfkbKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711464624; c=relaxed/simple;
	bh=E4p9XzyKJBXGPXgvxjbUqp9ZFwjhe37aG6wjCvskTjM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=RYOyBc3WOfvLb1Cjgr/omiS3TCgLg6gdPoI34HvlbREm3xL4/6R5nT8MwI7ZcA7smqWzkoxLOFqR7yZrzkntgEMLuvXVPA340loCHIvalsKYtHNlEA9NjBs1dtdpvvWfjro/gXRTFu627lOFGO1hgsKl/ngZoOU1Ixev+r2d+I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=DjWG4LD3; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=DjWG4LD3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3551537CF7
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Mar 2024 14:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1711464620; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=/MgFxVOu6JWxBlggx3M0kXsP1/ML1+sOGDNm602nn84=;
	b=DjWG4LD3taj3NcMEcPRJPT+n05dFzGFpMe84SBJjRqFoqqDnVLg/qsFB7edE00z5PtQJ0g
	iBaeY0qBaNng9jiQPOlWuscp+LMu/ZL/NSuaZClBLVblUliq7nvFsHlBWYD9vh1U+J79oA
	yYaMdigOoq9057DHsSwdN4P/9VY2Ibg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1711464620; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=/MgFxVOu6JWxBlggx3M0kXsP1/ML1+sOGDNm602nn84=;
	b=DjWG4LD3taj3NcMEcPRJPT+n05dFzGFpMe84SBJjRqFoqqDnVLg/qsFB7edE00z5PtQJ0g
	iBaeY0qBaNng9jiQPOlWuscp+LMu/ZL/NSuaZClBLVblUliq7nvFsHlBWYD9vh1U+J79oA
	yYaMdigOoq9057DHsSwdN4P/9VY2Ibg=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 2EA2113215
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Mar 2024 14:50:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id tzBiC6zgAmbPTQAAn2gu4w
	(envelope-from <dsterba@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Mar 2024 14:50:20 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: Btrfs progs release 6.8
Date: Tue, 26 Mar 2024 15:42:16 +0100
Message-ID: <20240326144302.12504-1-dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: 4.00
X-Spamd-Result: default: False [4.00 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_DN_NONE(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.09)[64.61%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_SPAM_SHORT(0.19)[0.063];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCPT_COUNT_ONE(0.00)[1];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Level: ***
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Flag: NO

Hi,

btrfs-progs version 6.8 have been released.

There are a few bug fixes and documentation updated. The libbtrfsutil API has
been updated and prepared for new enhancements.

Changelog:

  * fix --enqueue option timeout handling
  * subvolume: remove support for undocumented options -c and -x,
    functionality disabled in kernel
  * libbtrfsutil:
    * version 0.1.3, backward compabile
    * add aliases for all existing functions with unified naming scheme
    * updated header defintions for recently added kernel features
  * send: v3 supported in experimental mode
  * other:
    * docs: manual page references, graphs, enhancements, clarifications
    * error handling fixes
    * cleanups and refactoring

Tarballs: https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/
Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git
Release: https://github.com/kdave/btrfs-progs/releases/tag/v6.8

