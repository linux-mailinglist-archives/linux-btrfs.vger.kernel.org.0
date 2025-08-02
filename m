Return-Path: <linux-btrfs+bounces-15812-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C07B190E3
	for <lists+linux-btrfs@lfdr.de>; Sun,  3 Aug 2025 01:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AABA1899F30
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Aug 2025 23:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036C2224AFC;
	Sat,  2 Aug 2025 23:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="P/XFoTke";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pyJCz7Wz";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UlPw4s30";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LnpjPVxe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4B720296C
	for <linux-btrfs@vger.kernel.org>; Sat,  2 Aug 2025 23:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754177774; cv=none; b=Vy8irRiYf6tnsV6oHlyv9A2D1en7QQ9A5FL3wg6M2ZniF3Me0MppKqSCfMDCKzoDd6MBgNptycyCYdbyg+5bdzGX0QlTNuUVh9b4J+5k3c4v1zBEQUCH/1ROEwwoGe418Mzi/4Ey2dGaiUd/b4xbGtI+NQ/SF6PGBiZBbXm2Q40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754177774; c=relaxed/simple;
	bh=MKR1w1bmXeYDEt9QbLN+mOgEUkapo6HhN6zvk3nhdMk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=T8Mk/f8swQwcyf9EwtOmRUUbbKLSfrTPz8MNNOxej8zzxrN4TwzcLBp9JCWUzBPmK5XQP58DF2/YVRmFFFtl6YI6JdLgVQiTq2iCoA48N7xyd3nwZXjo33abGMti6g50GIbaZwONxduk4vt5aUCCUtrthz0Zhvx7AE+urquHboc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=P/XFoTke; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pyJCz7Wz; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UlPw4s30; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LnpjPVxe; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EC7982197F;
	Sat,  2 Aug 2025 23:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754177770; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6MPOp6uywDwKnhLxNLMm3/zsAJaOW8cMsZ/J1ZPKDFg=;
	b=P/XFoTke2VQpPHVNrAwzyKLY8Gu4ltJRpCEHsKjeIeo2GlRjwCEs/LOOAg2MMtGW0KGSzk
	3AEvv5JfvRTOPMbjth9jztsBVLpbtYvtOpvRjLItCFVJIqgYJO8adXhdoVtmmnR+1E+RDX
	GAwlej01PkJ0NCqFphuPMPe2HXqRp9w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754177770;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6MPOp6uywDwKnhLxNLMm3/zsAJaOW8cMsZ/J1ZPKDFg=;
	b=pyJCz7WzQ7RU1GLy3fyUxWdh12aONC9T4wMkezWDnHQKtHs4y1vofuk7MQSKR64zeFiUFU
	9J25JKoE8zxuK1Aw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=UlPw4s30;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=LnpjPVxe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754177769; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6MPOp6uywDwKnhLxNLMm3/zsAJaOW8cMsZ/J1ZPKDFg=;
	b=UlPw4s30dVMxHugKGf+zLxCeKFJaC241gdnGLhHxs+bW+nWOgE6RZW4XkRa9cpkzjZkYuX
	AMQTxLf7L0biJP4gQp+iGXTHhIr489E71Cs0LJ35uFCSkGmvYkZodXqOkJjRZmJPUG/BCb
	9AIRxPHQ/2ABjQ/BYbMrZhFnZyQnptM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754177769;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6MPOp6uywDwKnhLxNLMm3/zsAJaOW8cMsZ/J1ZPKDFg=;
	b=LnpjPVxeIO6k/o83oXcvzm1gbsvP1YZECVnpVxvNGmBhuqVONCWDZMD9s2/X67lPYezqEv
	ubyJsBP/OnHvtcCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E67E1136A1;
	Sat,  2 Aug 2025 23:36:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id d6pVKeigjmjGCwAAD6G6ig
	(envelope-from <wqu@suse.de>); Sat, 02 Aug 2025 23:36:08 +0000
Message-ID: <4cdf6f5c-41e8-4943-9c8b-794e04aa47c5@suse.de>
Date: Sun, 3 Aug 2025 09:05:47 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Should seed device be allowed to be mounted multiple times?
From: Qu Wenruo <wqu@suse.de>
To: Anand Jain <anand.jain@oracle.com>,
 linux-btrfs <linux-btrfs@vger.kernel.org>, David Sterba <dsterba@suse.com>
References: <aef03da8-853a-4c9f-b77b-30cf050ec1a5@suse.de>
Content-Language: en-US
In-Reply-To: <aef03da8-853a-4c9f-b77b-30cf050ec1a5@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: EC7982197F
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUBJECT_ENDS_QUESTION(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -3.51



在 2025/8/2 16:41, Qu Wenruo 写道:
> Hi,
> 
> There is the test case misc/046 from btrfs-progs, that the same seed 
> device is mounted multiple times while a sprouted fs already being mounted.
> 
> However after kernel commit e04bf5d6da76 ("btrfs: restrict writes to 
> opened btrfs devices"), every device can only be opened once.
> 
> Thus the same read-only seed device can not be mounted multiple times 
> anymore.
> 
> I'm wondering what is the proper way to handle it.
> 
> Should we revert the patch and lose the extra protection, or change the 
> docs to drop the "seed multiple filesystems, at the same time" part?

BTW, reverting will not be that simple anymore.

The problem is we're now using unique blk dev holder (super block) for 
each filesystem.

Thus each block device can not have two different super blocks.

Thanks,
Qu

> 
> Personally speaking, I'd prefer the latter solution for the sake of 
> safety (no one can write our block devices when it's mounted).
> 
> Thanks,
> Qu
> 


