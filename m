Return-Path: <linux-btrfs+bounces-15804-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45030B18AF8
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Aug 2025 09:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BF221AA087F
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Aug 2025 07:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C971E7C1B;
	Sat,  2 Aug 2025 07:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BwDjSEjh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WcpYo3Q4";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vqM2dJWb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="aKte48fq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B246AB665
	for <linux-btrfs@vger.kernel.org>; Sat,  2 Aug 2025 07:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754118738; cv=none; b=JAlHZKFMksxmCeIply3QC0YLFof9QDBA9Mx+P2nU10cOMYZVYf7XW4zsPQfaicCZn2NWur7nBPki4qglzwazANzwgrc2rXPOsULY4gc8GaagW2DZSHj0g9IiXy23fDqwM3VavwHeuyLucKsjvV2v54tlC5c5tAZqXCV9Jg7aB3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754118738; c=relaxed/simple;
	bh=giz9OJncllQ2TzaF+riW8fZ46iYvJNnBJknoxcrEHSA=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=G4ln2px9+c2/AGisnJzUgnpyAT6i2upxGBH80AsIEGvZx0LXpncLPr7HgGickDbusZjJTNv5I/omHfVLY7WPnCRwxM3rwa77ebBqRSRAOsttV3S9fznSecToaszcrSITxp4ty9sUrozjn1M9IErvv+orqg3m+UHZRx/E8JD4tfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BwDjSEjh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WcpYo3Q4; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vqM2dJWb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=aKte48fq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A1ADF21B40;
	Sat,  2 Aug 2025 07:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754118733; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2Fcfwdl7JAzJCSB+Q6OKJjo+7YL0CTlUKh9JPvTOi/g=;
	b=BwDjSEjhm97sd9ykIXovjRSx9wRAqLBjGM3TTDCxM1TtHP+0v9kbzpYWJv/Jr8GgDkQdI4
	v2iZWLFsolC4Z57V8iBSAmYJK+u5sXZpECcjTnEbkPQqzWkgF3KNyFgi06lNaVBi/0YWJu
	6jnGysJmgwzlsegMlGBxqjf6BwvDn10=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754118733;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2Fcfwdl7JAzJCSB+Q6OKJjo+7YL0CTlUKh9JPvTOi/g=;
	b=WcpYo3Q4XaDDXYD84G3Ec8/LPdkLl81EIJLwjJiTdgIhBXthQo+4lwsXk+gVN6FMDfGtbs
	i1WQyp0GVUWj0rAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=vqM2dJWb;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=aKte48fq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754118732; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2Fcfwdl7JAzJCSB+Q6OKJjo+7YL0CTlUKh9JPvTOi/g=;
	b=vqM2dJWbBlovrjkO+iUby9t1PRfafPfZKUGJEM3cG/LtCuQzCc1JrJx/++NflTq7zqouIQ
	xENGGpTc9feK0clJhmYu6nKaRvRHOkQARO3nG7bH3ltLmutMhuRbs3Hv8AAd33KN13dhM4
	vDMBvA/ffIUvB+hh/qSrAbRp6s58hsI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754118732;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2Fcfwdl7JAzJCSB+Q6OKJjo+7YL0CTlUKh9JPvTOi/g=;
	b=aKte48fqWpuKPl3A2sTndQSfJ2gYr/Gz6jEY62Ai58R4uAoOqA6Ct0kWKh4Unsrkxf+WWG
	S8c8TVi7egCP4eCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9BBC3136A1;
	Sat,  2 Aug 2025 07:12:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +lnnFku6jWhTIAAAD6G6ig
	(envelope-from <wqu@suse.de>); Sat, 02 Aug 2025 07:12:11 +0000
Message-ID: <aef03da8-853a-4c9f-b77b-30cf050ec1a5@suse.de>
Date: Sat, 2 Aug 2025 16:41:46 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Anand Jain <anand.jain@oracle.com>,
 linux-btrfs <linux-btrfs@vger.kernel.org>, David Sterba <dsterba@suse.com>
From: Qu Wenruo <wqu@suse.de>
Subject: Should seed device be allowed to be mounted multiple times?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: A1ADF21B40
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	SUBJECT_ENDS_QUESTION(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.51

Hi,

There is the test case misc/046 from btrfs-progs, that the same seed 
device is mounted multiple times while a sprouted fs already being mounted.

However after kernel commit e04bf5d6da76 ("btrfs: restrict writes to 
opened btrfs devices"), every device can only be opened once.

Thus the same read-only seed device can not be mounted multiple times 
anymore.

I'm wondering what is the proper way to handle it.

Should we revert the patch and lose the extra protection, or change the 
docs to drop the "seed multiple filesystems, at the same time" part?

Personally speaking, I'd prefer the latter solution for the sake of 
safety (no one can write our block devices when it's mounted).

Thanks,
Qu

