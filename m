Return-Path: <linux-btrfs+bounces-16797-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BA9B54156
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Sep 2025 06:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 023D4162DE6
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Sep 2025 04:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C040821D3F8;
	Fri, 12 Sep 2025 04:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Q966Yese";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Q966Yese"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F370D2DC77F
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Sep 2025 04:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757649609; cv=none; b=WMF9RnF/hXZk+1j+CVyqszgqy2nxKaaDKp6NvnseudN1YCALFE8NmB19iLI/Fqgv+eKCUnnm2CbdaOvsmT0zSnhyQJ6oHKgzjpKT6iSbRKWg6yrGKqDjpTcvPqLEdx0B6j4KbKWCrxRDiCcien4BY/CphiyxI4l301h3YsRSTVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757649609; c=relaxed/simple;
	bh=14tGS1hhX72ZTGq4ZXfHkBqvbws4nOycK5iKThVTF1s=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=XykgwFrYKLjOu4kJhN9YRzqduOHQzIiUoVf3xr0FOwFgpGmVVfXWIOoQfI04nQ3dt+FZ+MtdAoktE8PAwsI9JSRIybVfGs9F4HSOUf0DOKVPFG9++RL4K3WlrSD2yr5fNYzc8hPOryKaLg/a9RutfsSTeho0CSmpFc0quSmUEj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Q966Yese; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Q966Yese; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A03FC20B40
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Sep 2025 04:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1757649602; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=aSEex+zrToZ8fTivhmCOQ7h57zX++obBeWY073Nqi/E=;
	b=Q966Yese5lq05H3VodHW8ByM7BCtblZ4Vy+DbYQnu5zCAcx2kkx14D2ck1WhudgTNGsP3l
	eJc3nZArZZpDctVw0YExpdpqFyNhPu+NVilmxUABKvF2nSTuuDyCC07OQDodv6ALI4gZD4
	uROaHAKnvebF8Av+ttlWje1/9HTmMg0=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1757649602; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=aSEex+zrToZ8fTivhmCOQ7h57zX++obBeWY073Nqi/E=;
	b=Q966Yese5lq05H3VodHW8ByM7BCtblZ4Vy+DbYQnu5zCAcx2kkx14D2ck1WhudgTNGsP3l
	eJc3nZArZZpDctVw0YExpdpqFyNhPu+NVilmxUABKvF2nSTuuDyCC07OQDodv6ALI4gZD4
	uROaHAKnvebF8Av+ttlWje1/9HTmMg0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DB52D13647
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Sep 2025 04:00:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /cbwJsGaw2hWXQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Sep 2025 04:00:01 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: prepare raid56 and scrub to support bs > ps cases
Date: Fri, 12 Sep 2025 13:29:38 +0930
Message-ID: <cover.1757649253.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80

After the previous compression bs > ps preparation, this series focus on
raid56 and scrub.

Both raid56 and scrub are using a page array storing their stripes.

Thankfully both are already using physical memory addresses for checksum
calculation, thus there are no internal code to do the checksum
handling.

Just convert the involved arraies (and some RAID56 internal page related
members) to folio arraies will handle most thing properly.

Now the remaining code is mostly encoded write, which shares some
infrastructure with send, which makes the conversion more complex than I
thought.

Qu Wenruo (2):
  btrfs: prepare raid56 to support bs > ps cases
  btrfs: prepare scrub to support bs > ps cases

 fs/btrfs/misc.h   |   5 ++
 fs/btrfs/raid56.c | 180 +++++++++++++++++++++++-----------------------
 fs/btrfs/raid56.h |  26 ++++---
 fs/btrfs/scrub.c  |  51 +++++++------
 4 files changed, 142 insertions(+), 120 deletions(-)

-- 
2.50.1


